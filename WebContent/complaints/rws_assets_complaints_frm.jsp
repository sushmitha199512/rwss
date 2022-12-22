<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>   
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ page import="java.util.*" %>
<%@ page import=" nic.watersoft.commons.RwsUser" %>
<%
	 String mode = request.getParameter("mode");
	 int sno=0;
	 Date systemdate= new java.util.Date(System.currentTimeMillis());
	 java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
	 String transdate=null;
	 transdate=dateFormat.format(systemdate);
     RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
	 System.out.println("user:"+user);
	 %>
<html:html>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<style type="text/css">
.container {
    font-family:verdana,arial,helvetica,sans-serif;
    font-size:0.9em;
    margin:4px 0;
 }
.container img {
    width:16px;
    vertical-align:bottom;
 }
.container span {
    font-weight:bold;
    cursor:pointer;
 }
.off {
    display:none;
}
.on {
    width:400px;
    margin:10px 30px;
    text-align:justify;
    color:#003;
    background-color:#eef;                  
}
</style>

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
   /*  else if((!fnSar()))
     {
     alert("Select Sources");
     return false;
     }*/
	 else if(document.forms[0].inwardNo.value=="" || document.forms[0].inwardNo.value==null)
     {
     alert("Enter Inward No");
     return false;
     }
    else if(document.forms[0].category.value== "0" || document.forms[0].category.value==null)
     {
     alert("Select Nature of Problem");
     return false;
     }
     else if(document.forms[0].complntdesc.value == " " || document.forms[0].complntdesc.value==null)
     {
     alert("Enter Problem Description");
     return false;
     }
     else if(document.forms[0].repCode.value== "0" || document.forms[0].repCode.value==null)
     {
     alert("Select Complaint Given By");
     return false;
     }
     else if(document.forms[0].name.value == "" || document.forms[0].name.value==null)
     {
     alert("Enter Name");
     return false;
     }
     else if(document.forms[0].address.value == "" || document.forms[0].address.value==null)
     {
     alert("Enter Address");
     return false;
     }
	 else if(document.forms[0].phoneNo.value == "" || document.forms[0].phoneNo.value==null)
     {
     alert("Enter Phone No");
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
		document.forms[0].action="switch.do?prefix=/complaints&page=/Complaints.do?mode=cview";
		document.forms[0].submit();
	}
}
function getData()
{
	document.forms[0].action="switch.do?prefix=/complaints&page=/Complaints.do?mode=data";
	document.forms[0].submit();
}

function getData2()
{
	document.forms[0].action="switch.do?prefix=/complaints&page=/Complaints.do?mode=get2";
	document.forms[0].submit();
}

function fnSave()
{
   //alert(document.forms[0].asset.value);	
   //alert(document.forms[0].sno.value);	
   var assetcode,soucecode;
   //alert(fnSea());
	if(fnSea()==true)
	{
		//alert("SS:"+document.forms[0].assetCode.value);
		//alert("DD:"+document.forms[0].assetCd2.length);
	
		

		assetcode='<%=request.getParameter("assetCode")%>';
		sourcecode='<%=request.getParameter("sourceCode")%>';

      	//assetcode = document.forms[0].assetCode.value;
		//sourcecode = document.forms[0].sourceCode.value;
		
		assetcode='<%=request.getParameter("assetCode")%>';
		sourcecode='<%=request.getParameter("sourceCode")%>';
		//alert("else assetcode:"+assetcode);
		//alert("else  sourcecode:"+sourcecode);
		
		if(assetcode!=null  && assetcode!="" &&  sourcecode!=null  && sourcecode!="")
		{
		var complaintno=document.forms[0].complntno.value;
		
		var inwardno=document.forms[0].inwardNo.value;
		var complaintdate=document.forms[0].complntdt.value;
		var category=document.forms[0].category.value;
		var description=document.forms[0].complntdesc.value;
		var givenby=document.forms[0].repCode.value;
		var name=document.forms[0].name.value;
		var address=document.forms[0].address.value;
		var phone=document.forms[0].phoneNo.value;
		var url = "switch.do?prefix=/complaints&page=/Complaints.do?mode=save&assetCode="+assetcode+"&sourceCode="+sourcecode+"&inwardNo="+inwardno+"&complntno="+complaintno+"&complntdt="+complaintdate+"&category="+category+"&complntdesc="+description+"&repCode="+givenby+"&name="+name+"&address="+address+"&phoneNo="+phone;
		//alert("2:"+url);
		 var width = 838;
		 var height = 600;
		 var left = parseInt((screen.availWidth/2)-(width/2));
		 var top = parseInt((screen.availHeight/2)-(height/2));
		 var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes";
			newWindow = window.open(url, "_New", properties);
			newWindow.focus();
		}
	}
}


function fnSar()
{
var len="";
//alert("sss:"+document.forms[0].assetCd2.length);
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
//alert("ddd:"+document.forms[0].assetCd2.checked);
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
	//alert("val before:"+document.forms[0].assetCd2[i].checked)
	if (document.forms[0].assetCd2[i].checked) 
	{
		//alert("val:"+document.forms[0].assetCd2[i].value);
		chosen = document.forms[0].assetCd2[i].value;
	//	alert("chosen in for loop:"+chosen)
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
		document.forms[0].action="switch.do?prefix=/complaints&page=/Complaints.do?mode=cview";
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
	document.forms[0].action="switch.do?prefix=/complaints&page=/Complaints.do?mode=view";
	document.forms[0].submit();
}

function hide()
{
	var mode = '<%=mode%>';
	
	if(mode=="genrate")
	{
		//alert(document.getElementById('some').style.display="block");
		document.forms[0].save.disabled=false;
		if(document.forms[0].asset.value=="01" || document.forms[0].asset.value=="02" || document.forms[0].asset.value=="03" || document.forms[0].asset.value=="09") {
		document.getElementById('some').style.display="block"; }
		document.getElementById('text').style.display ="block";
	}

}
function show(acode,scode,compcode)
{
	//alert("kk:"+document.forms[0].assetCd2.length);
	//alert(acode);
	//alert(scode);
	//alert(compcode);
	var cmpcode=compcode;
	document.forms[0].assetCode.value=acode;
	document.forms[0].sourceCode.value=scode;
	document.getElementById('text').style.display = "block";
	//alert("1:"+document.forms[0].save.disabled);
	document.forms[0].save.disabled=false;
	//alert("2:"+document.forms[0].save.disabled);
	var chosen;
for(i=0;i<document.forms[0].assetCd2.length;i++)
{
	//alert("val before:"+document.forms[0].assetCd2[i].checked)
	if (document.forms[0].assetCd2[i].checked) 
	{
		//alert("val:"+document.forms[0].assetCd2[i].value);
		chosen = document.forms[0].assetCd2[i].value;
	}
	}
	//alert("chosen in for loop:"+chosen)

			
    document.forms[0].action="switch.do?prefix=/complaints&page=/Complaints.do?mode=genrate&cmpcode="+cmpcode;
	document.forms[0].submit();

}
function Toggle(node){
// Expanding the Node
	if (node.nextSibling.style.display == 'none'){
		// Change the image (if there is an image)
		if (node.childNodes.length > 0){
			if (node.childNodes.item(0).nodeName == "IMG"){
				node.childNodes.item(0).src = "../images/collapse.gif";
			}
		}
		node.nextSibling.style.display = 'block';
	}
	// Collapsing the Node
	else{
		// Change the image (if there is an image)
		if (node.childNodes.length > 0)	{
			if (node.childNodes.item(0).nodeName == "IMG"){
				node.childNodes.item(0).src = "../images/expand.gif";
			}
		}
		node.nextSibling.style.display = 'none';
	}
}
</script>

<body  onload="javascript:hide();">


<html:form action="Complaints.do">

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Grievance Entry ( for Existing Assets )" />
	<jsp:param name="TWidth" value="822" />
</jsp:include>

<%
int as = 0,count=0;
java.util.Collection a = (java.util.ArrayList)session.getAttribute("assts"); 
if(a != null)as = a.size();
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
 
 			<html:select property="asset" styleClass="mycombo" style="width:125px" onchange="javascript:getData()">
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
	<div>
	<font style="font-family:verdana; font-size:8pt;font-weight: bold; color:#000000">&nbsp;Asset Details</font></div>	
	</td>
	</tr>
	</tbody>
   	<tr><td>
	<%
	//System.out.println("DDDDDDD:"+session.getAttribute("asst"));
	if(session.getAttribute("asst")!=null && (session.getAttribute("asst").equals("01") || session.getAttribute("asst").equals("02") || session.getAttribute("asst").equals("03") || session.getAttribute("asst").equals("09")))
	  {%>
	
	<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border="1" style="border-collapse:collapse;" width="850" align=center >
	<tr>
	<td colspan="4" class=btext>Assets</td>
	</tr>
	<tr><td>	
	 <%
	  int vall = sno-1;
     ArrayList comps = ((ArrayList)session.getAttribute("assts1"));
   if(as>0)
	{%>
	
	<nested:iterate id="ASSTLIST" property="assts"  scope="session" indexId="ndx">
		
		<bean:define id="astCmpt" scope="request">   
                <bean:write name="ASSTLIST" property="astCmpt"/>
		</bean:define>
		
		<bean:define id="assetCode" scope="request">   
	    	<nested:write name="ASSTLIST" property="assetCode"/>
		</bean:define>
	
	<tr>
	<td  class=bwborder align=center><%=++sno%></td>
	<input type="hidden" name="sno" value="<%=sno%>">		
	<td colspan=3>

	<TABLE BORDER=0><TR><TD class=rptValue><A class=tab onClick="Toggle(this)"><IMG SRC="../images/expand.gif">
	  <font color="red">Name: </font><nested:write name="ASSTLIST" property="assetName" />&nbsp;
	  <font color="red">Location Name:</font> <nested:write name="ASSTLIST" property="assetLocation" />&nbsp;
	 <font color="red">Creation Date:</font> <nested:write name="ASSTLIST" property="dateCreation" />&nbsp;
	  </A><DIV style='display:none' id="some">
	  <table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border="1" style="border-collapse:collapse;" width="800" align=center >
	  <%
	    ArrayList compss = (ArrayList)comps.get(sno-1);
		if(compss!=null && compss.size()>0)	 
		{%>
		 <tr>
		<td class=clrborder align=center>Select</td>
		<td class=clrborder align=center>Component Name</td>
		<td class=clrborder align=center >Component Location</td>
		<td class=clrborder align=center>Date Creation</td>
		</tr>
		<%
		 for(int i=0;i<compss.size();i++){
		nic.watersoft.complaints.CompForm c1 = (nic.watersoft.complaints.CompForm)(compss).get(i);
		%>
		 <TR>
		 <TD><input type=radio name="assetCd2" title="Select any Asset Details to give complaint"  value="<%=String.valueOf(ndx)%>" indexed="false"  onclick="show('<%=c1.getAssetCode()%>','<%=c1.getSourceCode()%>','<%=c1.getCompCode()%>');"/>
		 <td class=rptValue><%=c1.getName()%></td>
		 <td class=rptValue><%=c1.getAssetLocation()%></td>
		 <td class=rptValue><%=c1.getDateCreation()%></td>
		  </td></tr>
		<%}} else{%>
		<tr><td colspan="4" class=btext align="center">No Components </td></tr>
		<%}%>
		</TD></TR></TABLE>
		</DIV></TD></TR></TABLE>
		
		</nested:iterate>	
		
			
<%}%></table>
	
	
	<%}else  if(session.getAttribute("asst")!=null && session.getAttribute("asst").equals("04"))
	{
%>
		<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border="1" style="border-collapse:collapse;" width="850" align=center >
			 	
		<tr>
		    <td class=clrborder align=center>Select</td>
		    <td class=clrborder align=center>Scheme Name </td>
		  	<td class=clrborder align=center>Location</td>
			<td class=clrborder align=center>Diameter(mm)</td>
			<td class=clrborder align=center>Status</td>
			<td class=clrborder align=center>Condition</td>
			<td class=clrborder align=center>Static Water Level(mts)</td>
			<td class=clrborder align=center>Summer Water Level(mts)</td>
			<td class=clrborder align=center>Year of Creation</td>
		</tr>
		<%

if(as > 0)
{
	 int resultCount = 0;%>
	<nested:iterate id="ASSTLIST" property="assts" scope="session" indexId="ndx">
	 <% resultCount++; %>
	<tr>
    <td>
    <input type=radio title="Select any Asset Details to give complaint" name="assetCd2" value="<%=String.valueOf(ndx)%>"   onclick="show('<nested:write name="ASSTLIST" property="assetCode" />','<nested:write name="ASSTLIST" property="sourceCode"/>','<nested:write name="ASSTLIST" property="compCode"/>')"/>
   	</td>
    	<td  class=bwborder align=left>
		<nested:write name="ASSTLIST" property="assetName"  />
		</td>
		<nested:hidden name="ASSTLIST" property="sourceCode" indexed="true"/>
		<nested:hidden name="ASSTLIST" property="assetCode" indexed="true"/>
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
<%}  else if(session.getAttribute("asst")!=null && session.getAttribute("asst").equals("05"))
  {%>
	<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border="1" style="border-collapse:collapse;" width="850" align=center >
		 	
	<tr>
	    <td class=clrborder align=center>Select</td>
	    <td class=clrborder align=center>Scheme Name</td>
		<td class=clrborder align=center>Location</td>
		<td class=clrborder align=center>Diameter(mm)</td>
		<td class=clrborder align=center>Depth(mts)</td>
		<td class=clrborder align=center>Yield(l.p.m)</td>
		<td class=clrborder align=center>Average Hours</td>
		<td class=clrborder align=center>Average Time</td>
		<td class=clrborder align=center>Hygiene</td>
	</tr>
<%

 if(as > 0)
 {



int resultCount = 0;%>


<nested:iterate id="ASSTLIST" property="assts" scope="session"  indexId="ndx">


<% resultCount++; %>
	
	<tr>
        <td>
        <input type=radio  title="Select any Asset Details to give complaint" name="assetCd2" value="<%=String.valueOf(ndx)%>" indexed="false"  onclick="show('<nested:write name="ASSTLIST" property="assetCode" />','<nested:write name="ASSTLIST" property="sourceCode"/>','<nested:write name="ASSTLIST" property="compCode"/>')"/>
       
		</td>
	
        <td  class=bwborder align=left>
		<nested:write name="ASSTLIST" property="assetName"  />
		</td>
		
		<nested:hidden name="ASSTLIST" property="sourceCode" indexed="true"/>
		<nested:hidden name="ASSTLIST" property="assetCode" indexed="true"/>
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
 
<%} else if(session.getAttribute("asst")!=null && session.getAttribute("asst").equals("06"))
  {%>
	<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border="1" style="border-collapse:collapse;" width="850" align=center >
			 	
			<tr>
			    <td class=clrborder align=center>Select</td>
			    <td class=clrborder align=center>Scheme Name</td>
				<td class=clrborder align=center>Location</td>
				<td class=clrborder align=center>Diameter(mm)</td>
				<td class=clrborder align=center>Depth(mts)</td>
				<td class=clrborder align=center>Normal Water Level(mts)</td>
				<td class=clrborder align=center>Minimum Water Level(mts)</td>
				<td class=clrborder align=center>Maximum Water Level(mts)</td>
				<td class=clrborder align=center>Quality</td>
			</tr>
<%


if(as > 0)
{


 int resultCount = 0;%>


<nested:iterate id="ASSTLIST" property="assts"  scope="session" indexId="ndx">


<% resultCount++; %>
	
	<tr>
        <td>
        <input type=radio name="assetCd2" title="Select any Asset Details to give complaint" value="<%=String.valueOf(ndx)%>" indexed="true"  onclick="show('<nested:write name="ASSTLIST" property="assetCode" />','<nested:write name="ASSTLIST" property="sourceCode"/>','<nested:write name="ASSTLIST" property="compCode"/>')"/>
        </td>
	
        <td  class=bwborder align=left>
		<nested:write name="ASSTLIST" property="assetName"  />
		</td>
		
		<nested:hidden name="ASSTLIST" property="sourceCode" indexed="true"/>
		<nested:hidden name="ASSTLIST" property="assetCode" indexed="true"/>
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
<%}  else if(session.getAttribute("asst")!=null && session.getAttribute("asst").equals("07"))
  {%>
	<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border="1" style="border-collapse:collapse;" width="850" align=center >
			 	
			<tr>
			    <td class=clrborder align=center>Select</td>
			    <td class=clrborder align=center>Scheme Name</td>
				<td class=clrborder align=center>Pond Name</td>
				<td class=clrborder align=center>Pond Size</td>
				<td class=clrborder align=center>Pond Volume</td>
			</tr>
<%

if(as > 0)
{


 int resultCount = 0;%>

 

<nested:iterate id="ASSTLIST" property="assts"  scope="session"  indexId="ndx">


<% resultCount++; %>
	
	<tr>
        <td>
        <input type=radio name="assetCd2" title="Select any Asset Details to give complaint"  value="<%=String.valueOf(ndx)%>" indexed="false"  onclick="show('<nested:write name="ASSTLIST" property="assetCode" />','<nested:write name="ASSTLIST" property="sourceCode"/>','<nested:write name="ASSTLIST" property="compCode"/>')"/>
       	</td>
	
        <td  class=bwborder align=left>
		<nested:write name="ASSTLIST" property="assetName"  />
		</td>
		<nested:hidden name="ASSTLIST" property="sourceCode" indexed="true"/>
		<nested:hidden name="ASSTLIST" property="assetCode" indexed="true"/>
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
<%
String numb=(String)session.getAttribute("compnos");
//System.out.println("numb:"+numb);
if(session.getAttribute("compnos")!=null)
{
%>
<br>
   <tr>
    <td class="textborder">
    <div id="text" style="display:none;">
    <TABLE align=center>
    <tr >
    <td class="textborder" >
       Complaint No  <font color="#FF6666">*</font></td><td><html:text property="complntno" value="<%=numb%>" styleClass="mytext" style="width:100px" readonly="true"  size="14" maxlength="14" onkeypress="return numeralsOnly(event)" />
       </td>
     <% if(user == null || (user!=null && !user.getUserId().equals(""))){%>
	 <td class="textborder" width="100">
	 Inward No </td><td><html:text property="inwardNo"  maxlength="10"  size="15"  /></td>
	 <%} else{}%>
       
       <td class="textborder" >
      Date <font color="#FF6666">*</font></td><td><html:text property="complntdt" value="<%=transdate%>" styleClass="mytext" style="width:100px" readonly="true"/></td>
    
	</tr>
    <tr>
		   <td class="textborder" > Nature of  Problem  <font color="#FF6666">*</font><td>
  				<html:select property="category" styleClass="mycombo" style="width:200px">
				<html:option value="0"><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="categorytypes">
				<html:options collection="categorytypes" name="labelValueBean"
				  property="value" labelProperty="label" />
				 </logic:present>
				</html:select>
		</td>
	
	<td class="textborder" >
	 Problem Description </td><td><html:textarea property="complntdesc" rows="3" cols="12"  onkeypress="return alpha(event)"/></td>
		<td class="textborder">
					Complaint Given By  <span class="mandatory">*</span>
				</td>
				<td class="column2">
					
						<html:select property="repCode" styleClass="mycombo" style="width:125px">
							<html:option value="0"><bean:message key="app.pleaseSelect" /></html:option>
							<logic:present name="representatives">
							<html:options collection="representatives" name="labelValueBean" property="value" labelProperty="label" />
							</logic:present>
						</html:select>
				</td>
</tr>
<tr>
				    <td class="textborder" width="100">
       Name  <font color="#FF6666">*</font></td><td><html:text property="name"  styleClass="mytext" style="width:125px"  size="25" maxlength="25"  onkeypress="return alpha(event)"  />
       </td>
      
    
  <td class="textborder" width="100">
	 Address  <font color="#FF6666">*</font></td><td><html:textarea property="address" rows="3" cols="12"  onkeypress="upperOnly()"  /></td>
	
     <td class="textborder" width="100">
	 Phone No </td><td><html:text property="phoneNo" maxlength="10"  size="10"  onkeypress="return numeralsOnly(event)"  /></td>
 </tr>
 </TABLE>
    </div>
   </td>
  </tr>
   
  <%}
   else
    {%>
		  <tr>
			<td class="textborder">
			<div id="text" style="display:none;">
			 <TABLE>
			<tr >
			<td class="textborder" width="100">
			   Complaint No  <font color="#FF6666">*</font></td><td><html:text property="complntno" value="" styleClass="mytext" style="width:80px" readonly="true"  maxlength="12" onkeypress="return numeralsOnly(event)" />
			   </td>
			   
			 <td class="textborder" width="100">
			  Date  <font color="#FF6666">*</font></td><td><html:text property="complntdt" value="<%=transdate%>" styleClass="mytext" style="width:100px" readonly="true"/>
			  <a href="javascript:showCalendar(document.CompForm.complntdt);"><IMG SRC="<rws:context page='/images/calendar.gif'/>" width="20" border="0" height="17" align="absmiddle"></a></td>
		  
			
			</tr>
			 <tr>
					 <td class="textborder" > Nature of  Problem  <font color="#FF6666">*</font><td>
  				<html:select property="category" styleClass="mycombo" style="width:200px">
				<html:option value="0"><bean:message key="app.pleaseSelect" /></html:option>
				<logic:present name="categorytypes">
				<html:options collection="categorytypes" name="labelValueBean"
				  property="value" labelProperty="label" />
				 </logic:present>
				</html:select>
					</td>
					</tr>
			<tr>
			<td class="textborder" width="100">
			Problem  Description </td><td><html:textarea property="complntdesc" rows="3"  cols="12"   onkeypress="return alpha(event)"  /></td>
		 </tr>
		 <tr>
						<td class="textborder">
							Complaint Given By  <span class="mandatory">*</span>
						</td>
						<td class="column2">
							<logic:present name="representatives">
							<html:select property="repCode" styleClass="mycombo" style="width:125px">
							<html:option value="0"><bean:message key="app.pleaseSelect" /></html:option>
							<html:options collection="representatives" name="labelValueBean"
										  property="value" labelProperty="label" />
							</html:select>
							</logic:present>
						</td>
						</tr>
		<tr>
			<td class="textborder" width="100">
			   Name  <font color="#FF6666">*</font></td><td><html:text property="name"  styleClass="mytext" style="width:125px"  size="25" maxlength="25"  onkeypress="return alpha(event)"   />
			   </td>
			<tr>
			<td class="textborder" width="100">
			 Address  <font color="#FF6666">*</font></td><td><html:textarea property="address" rows="3" cols="12"   onkeypress="upperOnly()"  /></td>
			 
			<td class="textborder" width="100">
			 Phone No </td><td><html:text property="phoneNo" maxlength="10"  size="10"  onkeypress="return numeralsOnly(event)"  /></td>
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
<input type="hidden" name="assetCode">
<input type="hidden" name="sourceCode">
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
 }%>
</script>


