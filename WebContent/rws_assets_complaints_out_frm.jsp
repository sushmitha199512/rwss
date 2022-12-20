

<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>   
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ page import="java.util.*" %>
<%
	 
	 Date systemdate= new java.util.Date(System.currentTimeMillis());
	 
	 java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
	 String transdate=null;
	 transdate=dateFormat.format(systemdate);
	 
	 
	 %>


<html:html>

 

<script language="JavaScript">

function fnM()
{
    if(document.forms[0].mand.value== "" || document.forms[0].mand.value==null)
   {
   alert("Select Mandal");
   return false;
   }
   else if(document.forms[0].panch.value== "" || document.forms[0].panch.value==null)
   {
   alert("Select Panchayat");
   return false;
   }
   else if(document.forms[0].habCode.value== "" || document.forms[0].habCode.value==null)
   {
   alert("Select Habitation");
   return false;
   }

}
function fnSea()
{
if(document.forms[0].asset.value== "" || document.forms[0].asset.value==null)
{
    alert("Select Asset Type");
    return false
    }
    else if(document.forms[0].dist.value== "" || document.forms[0].dist.value==null)
    {
    alert("Select District");
    return false;
    }
   else if(document.forms[0].mand.value== "" || document.forms[0].mand.value==null)
   {
   alert("Select Mandal");
   return false;
   }
   else if(document.forms[0].panch.value== "" || document.forms[0].panch.value==null)
   {
   alert("Select Panchayat");
   return false;
   }
   else if(document.forms[0].habCode.value== "" || document.forms[0].habCode.value==null)
   {
   alert("Select Habitation");
   return false;
   }
     else if((!fnSar()))
     {
     alert("Select Sources");
     return false;
     }
    else if(document.forms[0].category.value== "0" || document.forms[0].category.value==null)
     {
     alert("Select Complaint Category");
     return false;
     }
     else if(document.forms[0].complntdesc.value == " " || document.forms[0].complntdesc.value==null)
     {
     alert("Enter Complaint Description");
     return false;
     }
     else if(document.forms[0].repCode.value== "0" || document.forms[0].repCode.value==null)
     {
     alert("Select Complaint Given By");
     return false;
     }
     else if(document.forms[0].name.value == " " || document.forms[0].name.value==null)
     {
     alert("Enter Name");
     return false;
     }
     else if(document.forms[0].address.value == " " || document.forms[0].address.value==null)
     {
     alert("Enter Address");
     return false;
     }
    
    
     else
     {
      
     return true;
     }
     
     }


function fnView()
{
    if(document.forms[0].asset.value== "" || document.forms[0].asset.value==null)
    {
   	 alert("Select Asset Type");
    }
    else if(document.forms[0].dist.value== "" || document.forms[0].dist.value==null)
    {
    	alert("Select District");
    }
    
     else 
    {
		document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintsout.do?mode=cview";
		document.forms[0].submit();
	}
}

function getData2()
{
	document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintsout.do?mode=get2";
	document.forms[0].submit();
}

function getParameters(that)
{
   var index=that.value;
		document.forms[0].save.disabled=false;
   var assetcode=document.getElementById("ASSTLIST["+index+"].assetCode").value;
   var sourcecode=document.getElementById("ASSTLIST["+index+"].sourceCode").value;
   
    
   document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintsout.do?mode=save&assetCode="+assetcode+"&sourceCode="+sourcecode+"";
   init1();
}


function fnSave()
{
	alert(11);
	if(fnSea()==true)
	{
		
		var index;
	if(document.forms[0].assetCd2.length==undefined)
    {
 		index=0;
		var assetcode=document.getElementById("ASSTLIST["+index+"].assetCode").value;
		var sourcecode=document.getElementById("ASSTLIST["+index+"].sourceCode").value;
		
var url = "switch.do?prefix=/complaints&page=/Complaintsout.do?mode=save&assetCode="+assetcode+"&sourceCode="+sourcecode;

		document.forms[0].action=url;
		document.forms[0].submit();
    }
else{	
   
	for(var i=0;i<document.forms[0].assetCd2.length;i++)
		{
			if(document.forms[0].assetCd2[i].checked)
			{index = i;break;}
		}
		
		var assetcode=document.getElementById("ASSTLIST["+index+"].assetCode").value;
		var sourcecode=document.getElementById("ASSTLIST["+index+"].sourceCode").value;
		
var url = "switch.do?prefix=/complaints&page=/Complaintsout.do?mode=save&assetCode="+assetcode+"&sourceCode="+sourcecode;

		document.forms[0].action=url;
		document.forms[0].submit();
	}
}
}


function fnSar()
{
/*var chosen = "";
alert(document.forms[0].assetCd2.checked);
var len = document.forms[0].assetCd2.length;
alert("length "+len);
for (i = 0; i <len; i++) 
{
	if (document.forms[0].assetCd2[i].checked) 
	{
		chosen = document.forms[0].assetCd2[i].value;
		alert("choosen"+chosen);
	}
}*/
var len="";
if(document.forms[0].assetCd2.length)
{
len=1;
}
else
{
len=2;
}

var chosen="";
if(len==2)
{

if(document.forms[0].assetCd2.checked==true)
{
	return true;
}
else 
{
	return false;
}
}
else if(len==1)
{

var choosen=document.forms[0].assetCd2.length;

for(i=0;i<choosen;i++)
{
	if (document.forms[0].assetCd2[i].checked) 
	{
		chosen = document.forms[0].assetCd2[i].value;
		
	}
	}

if(chosen=="")
{
return false;
}
else 
{
return true;
}


}

}
function fnView()
{
    if(document.forms[0].asset.value== "" || document.forms[0].asset.value==null)
    {
   	 alert("Select Asset Type");
    }
    else if(document.forms[0].dist.value== "" || document.forms[0].dist.value==null)
    {
    	alert("Select District");
    }
    else 
    {
		document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintsout.do?mode=cview";
		document.forms[0].submit();
	}
}

   function init()
{
	
	document.forms[0].complntdt.value = "";
	document.forms[0].complntdesc.value = "";
	if((document.forms[0].dist.value== "") && (document.forms[0].mand.value=="") && (document.forms[0].panch.value=="") && (document.forms[0].habCode.value==""))
	{
	  document.forms[0].asset.value="";
	}
	
}
   
  





function getData1()
{
	document.forms[0].action="switch.do?prefix=/complaints&page=/Complaintsout.do?mode=view";
	document.forms[0].submit();
}

function init()
{
//toggleItem('collapse_myTbody2');
//toggleItem('collapse_myTbody3');
toggleItem('collapse_myTbody1');
}

function hide()
{
	document.getElementById('text').style.display ="none";
}
function show()
{
	
	document.getElementById('text').style.display = "block";
}

function getItem(id)
{
    var itm = false;
    if(document.getElementById)
        itm = document.getElementById(id);
    else if(document.all)
        itm = document.all[id];
    else if(document.layers)
        itm = document.layers[id];

    return itm;
}

function toggleItem(id)
{   
     itm = getItem(id);
    if(id=="collapse_myTbody2")
      var im = "onea";
    else if(id=="collapse_myTbody3")
      var im = "onec";
    else
       var im = "oneb";
    if(!itm)
        return false;
    if(itm.style.display == 'none'){
        itm.style.display = '';
        if (document.images[im]) {
		document.images[im].src = "/pred/images/collapse.gif";
	    }
    }    
    else{
	      itm.style.display = 'none';
	      if (document.images[im]) {
		document.images[im].src = "/pred/images/expand.gif";
	   }
    }	      
    return false;
}

</script>

<body  onload="javascript:init();javascript:hide();">


<html:form action="Complaintsout.do">

<jsp:include page="/commons/TableHeaderComplaints.jsp">
	<jsp:param name="TableName" value="Complaint Entry Form" />
	<jsp:param name="TWidth" value="822" />
</jsp:include>

<%
int as = 0;
java.util.Collection a = (java.util.ArrayList)session.getAttribute("assts"); 
if(a != null)as = a.size();
System.out.println("A Size in jsp::"+as);
 %>

 
<table   bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="850" align="center">
<tr>
<td>
 <fieldset>
	<legend>Asset Details</legend>
	<label>
	<table  border=0  width="850"  align=center  style="margin-bottom:0;margin-top:0">

	<tr>
		    <td class="textborder" width="100">Asset Type<font color="#FF6666">*</font><td>
 
 			<html:select property="asset" styleClass="mycombo" style="width:125px" onchange="javascript:getData2()">
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
			<html:option value="01"><font class="myfontclr1">PWS</html:option>
			<html:option value="02"><font class="myfontclr1">MPWS</html:option>
			<html:option value="03"><font class="myfontclr1">CPWS</html:option>
			<html:option value="04"><font class="myfontclr1">HANDPUMPS</html:option>
			<html:option value="05"><font class="myfontclr1">SHALLOWHANDPUMPS</html:option>
			<html:option value="06"><font class="myfontclr1">OPENWELLS</html:option>
			<html:option value="07"><font class="myfontclr1">PONDS</html:option>			
            <html:option value="09"><font class="myfontclr1">DIRECT PUMPING</html:option>
            </html:select>

			</td>
		
</tr>
</table>
</label>
</fieldset>

   <fieldset>
   <legend><bean:message key="legend.habitationDetails"/></legend>
   <label>
   <table  border=0  width="100%"  align=center  style="margin-bottom:0;margin-top:0">
   
   <tr>
   <td class="textborder" width="100"><bean:message key="app.district"/><font color="#FF6666">*</font></td>
		<td class="textborder" width="150">
		<html:select property="dist" styleClass="mycombo" style="width:125px" onchange="javascript:getData2()" >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
		<logic:present name="districts">
		<html:options collection="districts" name="rwsLocationBean" property="districtCode" labelProperty="districtName" />
		</logic:present>
		</html:select>
	
	
	<td class="textborder" width="100">
	<bean:message key="app.mandal"/><font color="#FF6666">*</font>
	<td class="textborder" width="150">
		    <html:select property="mand" styleClass="mycombo" style="width:130px" onchange="javascript:getData2()">
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
			<logic:present name="mandals">
			<html:options collection="mandals" name="rwsLocationBean" property="mandalCode" labelProperty="mandalName" />
			</logic:present>
			
			</html:select>
	</td>
	
	<td class="textborder" width="100">
	<bean:message key="app.panchayat" /><font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
		<html:select property="panch" styleClass="mycombo" style="width:150px"  onchange="javascript:getData2()">
		<html:option value="">SELECT...</html:option>
		<logic:present name="panchayats">
		<html:options collection="panchayats" name="rwsLocationBean" property="panchayatCode" labelProperty="panchayatName" />
		</logic:present>
		</html:select>
	</td>
	</tr>
	
	<tr>
	<td class="textborder" nowrap width="100">
	<bean:message key="app.habCode" /><font color="#FF6666">*</font></td>
	<td class="textborder" colspan=3>
		<html:select property="habCode" styleClass="mycombo" style="width:350px"  onchange="javascript:getData1()">
		<html:option value="">SELECT...</html:option>
		<logic:present name="habitations">
		<html:options collection="habitations" name="rwsLocationBean" property="habCode" labelProperty="habName" />
		</logic:present>
		</html:select>
	</td>
	</tr>
		
	</table>
	</label>
	</fieldset>
	
   </td>
  </tr>
  
  <tr>
  <td bgcolor="#8A9FCD">
    <table bgcolor="#DEE3E0" bordercolor= "#8A9FCD"  border="0" style="border-collapse:collapse;margin-top:0" width="100%" align=center>
  <tbody>
  
  <tr>
  <td  bgcolor="#8A9FCD">
	<div onclick="return toggleItem('collapse_myTbody1')" style="cursor:hand"><img style="WIDTH:13px;HEIGHT:11px" src="/pred/images/expand.gif" name="oneb">
	<font style="font-family:verdana; font-size:8pt;font-weight: bold; color:#000000">&nbsp;Asset Details</font></div>	
	</td>
	</tr>
	</tbody>
    <tbody class="collapse_obj" id="collapse_myTbody1" style="display:none">
	<tr><td>
    <% 
   
    if(request.getAttribute("asst")!=null && request.getAttribute("asst").equals("04"))
	{System.out.println("innnnnnnnnnn 04");
%>
		<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border="1" style="border-collapse:collapse;" width="850" align=center >
			 	
		<tr>
		    <td class=clrborder align=center>Select</td>
		    <td class=clrborder align=center>Scheme Name</td>
		    <td class=clrborder align=center>Scheme Code</td>
		   <!--  <td class=clrborder align=center>AssetCode</td> -->
			<td class=clrborder align=center>Location</td>
			<td class=clrborder align=center>Diameter(mts)</td>
			<td class=clrborder align=center>Status</td>
			<td class=clrborder align=center>Condition</td>
			<td class=clrborder align=center>Static Water Level(mts)</td>
			<td class=clrborder align=center>Summer Water Level(mts)</td>
			<td class=clrborder align=center>Year of Creation</td>
		</tr>

<%

if(as > 0)
{
System.out.println("innnnnnnnnnn");
%>
<% int resultCount = 0;%>
	<nested:iterate id="ASSTLIST" property="assts" scope="session" indexId="ndx">
<%System.out.println("innnnnnnnnnn"); %>
<% resultCount++; %>
		
	<tr>
    <td>
    <input type=radio title="Select any Asset Details to give complaint" name="assetCd2" value="<%=String.valueOf(ndx)%>"   onclick="show();getParameters(this);"/>
   
	</td>
        	
		<td  class=bwborder align=left>
		<nested:write name="ASSTLIST" property="assetName"  />
		</td>
		<td  class=bwborder align=center>
		<nested:hidden name="ASSTLIST" property="sourceCode" indexed="true"/>
		<nested:write name="ASSTLIST" property="sourceCode"  />
		</td>
        <!-- <td class=bwborder align=center>-->
		<nested:hidden name="ASSTLIST" property="assetCode" indexed="true"/>
		<!--<nested:write name="ASSTLIST" property="assetCode"  />-->
		<!--</td> -->
           
        <td  class=bwborder align=left>
		<nested:write  name="ASSTLIST" property="location" /> 
        </td>

        <td  class=bwborder align=center>
		<nested:write name="ASSTLIST" property="diameterOfBorewell" /> 
		</td>

        <td  class=bwborder align=left>
		<nested:write name="ASSTLIST" property="status"  />
		</td>

        <td  class=bwborder align=left>
		<nested:write name="ASSTLIST" property="cond"  />
		</td>

        <td  class=bwborder align=center>
		<nested:write name="ASSTLIST" property="staticWaterLevel"  /> 
		</td>
      
        <td  class=bwborder align=center>
		<nested:write name="ASSTLIST" property="summerWaterLevel"  /> 
		</td>

        <td  class=bwborder align=center>
		<nested:write name="ASSTLIST" property="drillYear"/> 
		</td>
		
		</tr>
</nested:iterate>
<%} 
else
    {
    %>
    <tr>
	
	<td colspan=11 align=center>No Records</td>
	</tr>
	<%}%>
    </table>
    
	</td>
	</tr>

<tr><td>
<%} else if(request.getAttribute("asst")!=null && request.getAttribute("asst").equals("05"))
  {%>
	<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border="1" style="border-collapse:collapse;" width="850" align=center >
		 	
	<tr>
	    <td class=clrborder align=center>Select</td>
	    <td class=clrborder align=center>Scheme Name</td>
	    <td class=clrborder align=center>Scheme Code</td>
	  <!--   <td class=clrborder align=center>AssetCode</td> -->
		
		<td class=clrborder align=center>Location</td>
		<td class=clrborder align=center>Diameter(mts)</td>
		<td class=clrborder align=center>Depth(mts)</td>
		<td class=clrborder align=center>Yield(l.p.m)</td>
		<td class=clrborder align=center>Average Hours</td>
		<td class=clrborder align=center>Average Time</td>
		<td class=clrborder align=center>Hygiene</td>
	</tr>
<%

 if(as > 0)
 {
%>


<%int resultCount = 0;%>


<nested:iterate id="ASSTLIST" property="assts" scope="session"  indexId="ndx">


<% resultCount++; %>
	
	<tr>
        <td>
        <input type=radio  title="Select any Asset Details to give complaint" name="assetCd2" value="<%=String.valueOf(ndx)%>" indexed="false" onclick="show();getParameters(this);"/>
       
		</td>
	
        <td  class=bwborder align=left>
		<nested:write name="ASSTLIST" property="assetName"  />
		</td>
		<td  class=bwborder align=center>
		<nested:hidden name="ASSTLIST" property="sourceCode" indexed="true"/>
		<nested:write name="ASSTLIST" property="sourceCode"  />
		</td>
		
		<td class=bwborder align=center>
		<nested:hidden name="ASSTLIST" property="assetCode" indexed="true"/>
		<nested:write name="ASSTLIST" property="assetCode"  />
		</td>
        
       
        
         <td  class=bwborder align=left>
		 <nested:write  name="ASSTLIST" property="shpLocation" /> 
         </td>

        <td  class=bwborder align=center>
		<nested:write name="ASSTLIST" property="shpDiameter" /> 
		</td>

		<td  class=bwborder align=center>
		<nested:write name="ASSTLIST" property="shpDepth"  />
		</td>
        
        <td  class=bwborder align=center>
		<nested:write name="ASSTLIST" property="shpYield"  />
		</td>

        <td  class=bwborder align=center>
		<nested:write name="ASSTLIST" property="shpAvgHours"  /> 
		</td>
        
        <td  class=bwborder align=center>
		<nested:write name="ASSTLIST" property="shpAvgTime"  /> 
		</td>

        <td  class=bwborder align=center>
		<nested:write name="ASSTLIST" property="shpHygiene"/> 
		</td>
	</tr>
</nested:iterate>

<%} 
else
    {
    %>
    <tr>
	
	<td colspan=12 align=center>No Records</td>
	</tr>
	<%}%>
    </table>
    
	</td>
	</tr>

<tr><td>
<%} else if(request.getAttribute("asst")!=null && request.getAttribute("asst").equals("06"))
  {%>
	<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border="1" style="border-collapse:collapse;" width="850" align=center >
			 	
			<tr>
			    <td class=clrborder align=center>Select</td>
			    <td class=clrborder align=center>Scheme Name</td>
			    <td class=clrborder align=center>Scheme Code</td>
			    <td class=clrborder align=center>AssetCode</td>
				
				<td class=clrborder align=center>Location</td>
				<td class=clrborder align=center>Diameter(mts)</td>
				<td class=clrborder align=center>Depth(mts)</td>
				<td class=clrborder align=center>Normal Water Level(mts)</td>
				<td class=clrborder align=center>Minimum Water Level(mts)</td>
				<td class=clrborder align=center>Maximum Water Level(mts)</td>
				<td class=clrborder align=center>Quality</td>
			</tr>
<%


if(as > 0)
{
%>

<% int resultCount = 0;%>


<nested:iterate id="ASSTLIST" property="assts"  scope="session" indexId="ndx">


<% resultCount++; %>
	
	<tr>
        <td>
        <input type=radio name="assetCd2" title="Select any Asset Details to give complaint" value="<%=String.valueOf(ndx)%>" indexed="true" onclick="show();getParameters(this);"/>
        </td>
	
        <td  class=bwborder align=left>
		<nested:write name="ASSTLIST" property="assetName"  />
		</td>
		<td  class=bwborder align=center>
		<nested:hidden name="ASSTLIST" property="sourceCode" indexed="true"/>
		<nested:write name="ASSTLIST" property="sourceCode"  />
		</td>
		
		<td class=bwborder align=center>
		<nested:hidden name="ASSTLIST" property="assetCode" indexed="true"/>
		<nested:write name="ASSTLIST" property="assetCode"  />
		</td>
        
        
        
        <td  class=bwborder align=left>
        <nested:write  name="ASSTLIST" property="owLocation" /> 
        </td>

        <td  class=bwborder align=center>
		<nested:write name="ASSTLIST" property="owDiameter" /> 
		</td>
				
        <td  class=bwborder align=center>
		<nested:write name="ASSTLIST" property="owDepth"  />
		</td>
		<td  class=bwborder align=center>
		<nested:write name="ASSTLIST" property="owNormalwl"  />
		</td>
		<td  class=bwborder align=center>
		<nested:write name="ASSTLIST" property="owMinwl"  />
		</td>
		<td  class=bwborder align=center>
		<nested:write name="ASSTLIST" property="owMaxwl"  />
		<td  class=bwborder align=left>
		<nested:write name="ASSTLIST" property="owQuality"  />
		</td>
		
	</tr>
</nested:iterate>
<%} 

 else
    {
    %>
    <tr>
	
	<td colspan=10 align=center>No Records</td>
	</tr>
	<%}%>
    

    </table>

    
	</td>
	</tr>

    <tr>
	<td>
 
	<%}else if(request.getAttribute("asst")!=null && (request.getAttribute("asst").equals("01") || request.getAttribute("asst").equals("02") || request.getAttribute("asst").equals("03") || request.getAttribute("asst").equals("09")))
	  {%>
	<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border="1" style="border-collapse:collapse;" width="850" align=center >
			 	
			<tr>
			    <td class=clrborder align=center>Select</td>
			    <td class=clrborder align=center>Scheme Name</td>
			    <td class=clrborder align=center>Scheme Code</td>
			    <td class=clrborder align=center>AssetCode</td>
				
				<td class=clrborder align=center>Location</td>
				
			</tr>
<%

if(as > 0)
{
%>

<% int resultCount = 0;%>

 %>

<nested:iterate id="ASSTLIST" property="assts"  scope="session" indexId="ndx">


<% resultCount++; %>
	
	<tr>
        <td>
        <input type=radio name="assetCd2" title="Select any Asset Details to give complaint"  value="<%=String.valueOf(ndx)%>" indexed="false"  onclick="show();getParameters(this);"/>
        </td>
	
        <td  class=bwborder align=left>
		<nested:write name="ASSTLIST" property="assetName"  />
		</td>
		<td  class=bwborder align=center>
		<nested:hidden name="ASSTLIST" property="sourceCode" indexed="true"/>
		<nested:write name="ASSTLIST" property="sourceCode"  />
		</td>
        
		
		<td class=bwborder align=center>
		<nested:hidden name="ASSTLIST" property="assetCode" indexed="true"/>
		<nested:write name="ASSTLIST" property="assetCode"  />
		</td>
        
        
        <td  class=bwborder align=left>
        <nested:write  name="ASSTLIST" property="assetLocation" /> 
        </td>

        
	</tr>
</nested:iterate>
<%}
else
    {
    %>
    <tr>
	
	<td colspan=10 align=center>No Records</td>
	</tr>
	<%}%>
    

    </table>

    
	</td>
	</tr>





	



<tr><td>
<%} else if(request.getAttribute("asst")!=null && request.getAttribute("asst").equals("07"))
  {%>
	<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border="1" style="border-collapse:collapse;" width="850" align=center >
			 	
			<tr>
			    <td class=clrborder align=center>Select</td>
			    <td class=clrborder align=center>Scheme Name</td>
			    <td class=clrborder align=center>Scheme Code</td>
			    <td class=clrborder align=center>AssetCode</td>
				
				<td class=clrborder align=center>Pond Name</td>
				<td class=clrborder align=center>Pond Size</td>
				<td class=clrborder align=center>Pond Volume</td>
			</tr>
<%

if(as > 0)
{
%>

<% int resultCount = 0;%>

 %>

<nested:iterate id="ASSTLIST" property="assts"  scope="session"  indexId="ndx">


<% resultCount++; %>
	
	<tr>
        <td>
        <input type=radio name="assetCd2" title="Select any Asset Details to give complaint"  value="<%=String.valueOf(ndx)%>" indexed="false"  onclick="show();getParameters(this);"/>
       	</td>
	
        <td  class=bwborder align=left>
		<nested:write name="ASSTLIST" property="assetName"  />
		</td>
		<td  class=bwborder align=center>
		<nested:hidden name="ASSTLIST" property="sourceCode" indexed="true"/>
		<nested:write name="ASSTLIST" property="sourceCode"  />
		</td>
		
		<td class=bwborder align=center>
		<nested:hidden name="ASSTLIST" property="assetCode" indexed="true"/>
		<nested:write name="ASSTLIST" property="assetCode"  />
		</td>
        <td  class=bwborder align=left>
        <nested:write  name="ASSTLIST" property="pondName" /> 
        </td>

        <td  class=bwborder align=center>
		<nested:write name="ASSTLIST" property="pondSize" /> 
		</td>
				
        <td  class=bwborder align=center>
		<nested:write name="ASSTLIST" property="pondVolume"  />
		</td>
	</tr>
</nested:iterate>
<%}
else
    {
    %>
    <tr>
	
	<td colspan=10 align=center>No Records</td>
	</tr>
	<%}%>
    </table>
	</td>
	</tr>
<tr><td>
<%}%>
    </table>
	</td>
	</tr>
	<% 
if(session.getAttribute("compnos")!=null)
{
String numb=(String)session.getAttribute("compnos");
%>

   <tr>
    <td class="textborder">
    <div id="text" style="display:none;">
    <TABLE >
    <tr >
    <td class="textborder" >
       Complaint No  <font color="#FF6666">*</font></td><td><html:text property="complntno" value="<%=numb%>" styleClass="mytext"  readonly="true"  maxlength="14" size="14" onkeypress="return numeralsOnly(event)" />
       </td>
       
       <td class="textborder" >
      Date <font color="#FF6666">*</font></td><td><html:text property="complntdt" value="<%=transdate%>" styleClass="mytext" style="width:100px" readonly="true"/><a href="javascript:showCalendar(document.CompForm.complntdt);"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a></td>
    
	
		    <td class="textborder" > Nature of Category  <font color="#FF6666">*</font><td>
  
 			<html:select property="category" styleClass="mycombo" style="width:125px"  >
			<html:option value="0"><font class="myfontclr1">SELECT...</html:option>
			<html:option value="01"><font class="myfontclr1">LEAKING</html:option>
			<html:option value="02"><font class="myfontclr1">PUMP DAMAGED</html:option>
			</html:select>
			</td>
	

	
	</tr>
    <tr>
	
	<td class="textborder" >
	  Description  <font color="#FF6666">*</font></td><td><html:textarea property="complntdesc" rows="3" cols="12"  onkeypress="return alpha(event)"  /></td>
	 
	 
	
				<td class="textborder">
					Complaint Given By  <span class="mandatory">*</span>
				</td>
				<td class="column2">
					<logic:present name="representatives">
						<html:select property="repCode" styleClass="mycombo" style="width:125px">
							<html:option value="0"><bean:message key="app.pleaseSelect" /></html:option>
							<html:options collection="representatives" name="compForm"
										  property="repCode" labelProperty="repName" />
						</html:select>
					</logic:present>
				</td>
				    <td class="textborder" >
       Name  <font color="#FF6666">*</font></td><td><html:text property="name"  styleClass="mytext" style="width:125px"  size="25" maxlength="25"  onkeypress="return alpha(event)"  />
       </td>
      
    
   </tr>
   <tr>
	<td class="textborder" >
	 Address  <font color="#FF6666">*</font></td><td><html:textarea property="address" rows="3" cols="12"  onkeypress="upperOnly()"  /></td>
	
     <td class="textborder" >
	 Phone No </td><td><html:text property="phoneNo" maxlength="10"  size="10"  onkeypress="numeralsOnly(event)"  /></td>
	 
	
	 
	 </tr>



   
	 
	 
	 	 
	 </TABLE>
    </div>
   </td>
  </tr>
   
  <%}
   else
    { %>
  <tr>
    <td class="textborder">
    <div id="text" style="display:none;">
     <TABLE>
    <tr >
    <td class="textborder" >
       Complaint No  <font color="#FF6666">*</font></td><td><html:text property="complntno" value="" styleClass="mytext" style="width:80px" readonly="true"  maxlength="12" onkeypress="return numeralsOnly(event)" />
       </td>
       
             
       
       <td class="textborder" >
      Date  <font color="#FF6666">*</font></td><td><html:text property="complntdt" value="<%=transdate%>" styleClass="mytext" style="width:100px" readonly="true"/>
      <a href="javascript:showCalendar(document.CompForm.complntdt);"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a></td>
  
	
	</tr>
	 <tr>
		    <td class="textborder" >Nature of Category  <font color="#FF6666">*</font><td>
  
 			<html:select property="category" styleClass="mycombo" style="width:125px" >
			<html:option value="0"><font class="myfontclr1">SELECT...</html:option>
			<html:option value="01"><font class="myfontclr1">LEAKING</html:option>
			<html:option value="02"><font class="myfontclr1">PUMP DAMAGED</html:option>
			</html:select>
			</td>
			</tr>
	
		
	
	<tr>
	<td class="textborder" >
	 Description  <font color="#FF6666">*</font></td><td><html:textarea property="complntdesc" rows="3"  cols="12"   onkeypress="return alpha(event)"  /></td>
	 
	
	 
	 </tr>
<tr>
				<td class="textborder">
					Complaint Given By  <span class="mandatory">*</span>
				</td>
				<td class="column2">
					<logic:present name="representatives">
						<html:select property="repCode" styleClass="mycombo" style="width:125px">
							<html:option value="0"><bean:message key="app.pleaseSelect" /></html:option>
							<html:options collection="representatives" name="compForm"
										  property="repCode" labelProperty="repName" />
						</html:select>
					</logic:present>
				</td>
				</tr>

<tr>
    <td class="textborder" >
       Name  <font color="#FF6666">*</font></td><td><html:text property="name"  styleClass="mytext" style="width:125px"  size="25" maxlength="25"  onkeypress="return alpha(event)"   />
       </td>
       
    
    <tr>
	<td class="textborder" >
	 Address  <font color="#FF6666">*</font></td><td><html:textarea property="address" rows="3" cols="12"   onkeypress="upperOnly()"  /></td>
	 
	<td class="textborder" >
	 Phone No </td><td><html:text property="phoneNo" maxlength="10"   onkeypress="numeralsOnly(event)"  /></td>
	
	 
	 </tr>

    
	
	 
	 
	 	 	 
	 </TABLE>
     
     
     
		
			  </div>
				
			

			
     
	 
   </td>
  </tr>
    
  <%} %>
<tr align=center>
	<td>
	<html:button property="save" title="Save the Fields"  styleClass="btext" value="Save" disabled="true" onclick="fnSave();"/>
	<html:button property="view" title="View the Results" styleClass="btext" value="View" onclick="fnView()"/>
    </td>
    </tr>



<jsp:include page="/commons/TableFotter.jsp">
<jsp:param name="TWidth" value="822"/>
</jsp:include>
</table>

	



</html:form>



</html:html>

<p align="center">

<%@ include file="/commons/rws_footer.jsp"%>



</p>

<script language="javascript">
<%
 if(request.getAttribute("message")!=null)
 {
%>
 alert('<%=request.getAttribute("message")%>');
<%
 }
%>
</script>


