<%@ include file="/commons/rws_header1.jsp" %>
<%@include file="/commons/rws_header2.jsp" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>

<html:html>
<head>
<style>
.btext2 {
	border-width: 1;
	border-color: #000000;
	color: #660099;
	font-weight: bold;
	height: 18px;
	font-family: verdana;
	font-size: 9pt
}

.btext1 {
	text-transform: uppercase;
	color: green;
}

.btext3 {
	color: red;
	font-weight: bold;
}
</style>
<STYLE>
fieldset {
	border: 1px solid green
}

legend {
	padding: 0.2em 0.5em;
	border: 1px solid green;
	color: green;
	font-size: 90%;
	text-align: right;
}

.tstyle {
	background: transparent url('images/bg.jpg') no-repeat;
	color: #747862;
	height: 20px;
	border: 0;
	padding: 4px 8px;
	margin-bottom: 0px;
}
</STYLE>
<script language="JavaScript">
function fnSea()
{
	      
       
        if(document.forms[0].workId.value=="" || document.forms[0].workId.value==null)
        {
        alert("Enter WorkId");
        return false;
        }
        else
        {
        var a=document.forms[0].workId.value;
        //alert(a);
        if(a.length != 14)
        {    
	     alert("Work Id  must be 14 digits");
		 return false;
  	     }

        document.forms[0].action="switch.do?prefix=/works&page=/LeadHab.do?mode=view"
		document.forms[0].submit;
        }
  }
function getData2()
{
	  document.forms[0].action="switch.do?prefix=/works&page=/LeadHab.do?mode=get2";
	   document.forms[0].submit();
    
}
function getData3()
{
	  document.forms[0].action="switch.do?prefix=/works&page=/LeadHab.do?mode=lead";
	   document.forms[0].submit();
    
}
function fnSar()
{
var len="";
if(document.forms[0].assetCd1.length)
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
if(document.forms[0].assetCd1.checked==true)
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
var choosen=document.forms[0].assetCd1.length;
for(i=0;i<choosen;i++)
{
	if (document.forms[0].assetCd1[i].checked) 
	{
		chosen = document.forms[0].assetCd1[i].value;
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
function fnSea1()
{
	       

             
       document.forms[0].action="switch.do?prefix=/works&page=/LeadHab.do?mode=update";
	   document.forms[0].submit();
      
      
}
function fnSave()
{

	if(document.forms[0].workId.value=="" || document.forms[0].workId.value==null)
	{
		alert("Enter Work Id");
		return false;
	}	
else if(document.forms[0].dist.value=="" || document.forms[0].dist.value==null)
	{
		alert("Select District");
		return false;
	}
else if(document.forms[0].mcode.value=="" || document.forms[0].mcode.value==null)
{
	alert("Select Mandal");
	return false;
}
else if(document.forms[0].pcode.value=="" || document.forms[0].pcode.value==null)
{
	alert("Select Panchayat");
	return false;
}
else if(document.forms[0].pcode.value=="" || document.forms[0].pcode.value==null)
{
	alert("Select Panchayat");
	return false;
}
		
	else
	{

	 var flag=false;
	    var choosen = document.getElementsByName('assetCd1');
	   			for(i=0;i<choosen.length;i++)
			{
				if (choosen[i].checked) 
				{
					flag=true;
				}
	}

  if(!flag){
            alert("Please Select Lead Habitation");
             return ;
  }
			
	var hab=document.forms[0].assetCd1.value;
	if(confirm("Do You Want To Change the selected Habitation as Lead Habitation"))
	{
		
	
	document.forms[0].action="switch.do?prefix=/works&page=/LeadHab.do&mode=update";
	document.forms[0].submit();
	
	}
	}
   
   
	
}
function getLead(that)
{

	var index=that.value;
	
	
	
	
	var habcode=document.forms[0].elements["COMPNLIST["+index+"].habCode"].value;
	var habname=document.forms[0].elements["COMPNLIST["+index+"].habName"].value;
	
	
    
	
	
	
	document.forms[0].action="switch.do?prefix=/works&page=/LeadHab.do&mode=update&habName="+habname+"&habCode="+habcode;
	document.forms[0].submit();
   
	
	
	


}



</script>
<body>




<table border = 0 cellspacing = 0 cellpadding = 0 width="600"  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" ALIGN=CENTER>
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "center">			
			<tr >
			

			
			</tr>  
		</table>
	</caption>

</table>

<body>
   <html:form action="LeadHab.do" >
   <% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
    <jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Lead Habitation Change for  Work  " />
	<jsp:param name="TWidth" value="100%" />
</jsp:include>

<table   bgcolor="ffffe0" bordercolor= "#8A9FCD" rules="cols" border="1" style="border-collapse:collapse;" width="100%" align="center">
<tr>

<td align=center><b>Enter Work Id:</b><font color="#FF6666">*</font>:<html:text property="workId" 
 styleClass="mytext" style="width:100px"   maxlength="14" size="20"  onkeypress="numeralsOnly(event)"  />
 <html:submit property="mode" title="Submit"  styleClass="btext"  onclick="return fnSea();"/>
 
</td>
</tr>
<tr>
<td>&nbsp;</td>
</tr>
 <tr><td>
			<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" border="1"
				style="border-collapse:collapse;" width="100%" align=center>
<tr  align=center>
<td class=clrborder colspan=7  >Works details</td>
</tr>
				<tr>
					<td class=clrborder align=center nowrap>Sl.No</td>
					
				    <td class=clrborder align=center nowrap>Work Id</td>
                     <td class=clrborder align=center nowrap>Work Name</td> 
                    <td class=clrborder align=center nowrap>Lead Habitation Code</td>
                    <td class=clrborder align=center nowrap> Lead Habitation Name</td>
                    
                    
				
				</tr>
				<%
try{
	int count=0;
java.util.ArrayList a = (java.util.ArrayList)session.getAttribute("works"); 


	if( a != null && !a.equals("") &&  !a.equals("null")  && a.size() > 0)
	{
	%>
	
	
	<nested:iterate id="COMPLIST" name="works" indexId="ndx">
	
	
		
		<% count=count+1;%>
		<tr align="left" id='tr<%=count%>'
		onmouseover="this.style.background='#E3E4FA'"
		onmouseout="this.style.background='WHITE'">
        <td class=bwborder align=left nowrap><%=count%></td>
		
		
		
		<td class=bwborder align=left nowrap><nested:hidden name="COMPLIST"
		property="workId" indexed="true" /> <nested:write
		name="COMPLIST" property="workId" /></td>
		<td class=bwborder align=left nowrap><nested:hidden name="COMPLIST"
		property="workName" indexed="true" /> <nested:write
		name="COMPLIST" property="workName" /></td>
		<td class=bwborder align=left nowrap><nested:hidden name="COMPLIST"
		property="leadHab" indexed="true" /> <nested:write
		name="COMPLIST" property="leadHab" /></td>
		<td class=bwborder align=left nowrap><nested:hidden name="COMPLIST"
		property="leadName" indexed="true" /> <nested:write
		name="COMPLIST" property="leadName" /></td>
		

						
		</tr>

				</nested:iterate>
	<%
	}
	else 
	{
	%>
	<tr>
	<td colspan=10 align=center>No Records</td>
	</tr>
	
	<%
	}
}catch(Exception p)
{
p.printStackTrace();
}
%>
	</table>
	</td>
	</tr>
	<tr>
	<td>&nbsp;
	
	</td>
	</tr>
<tr>
<td>
<table bgcolor="ffffe0" bordercolor= "#8A9FCD" rules="cols" border="1" 
	   style="border-collapse:collapse;" width="50%" align="center" >



    <tr>
	    <td class="textborder" width="100"><bean:message key="app.district"/><font color="#FF6666">*</font>
		<td class="textborder" width="150">
		<html:select property="dist" styleClass="mycombo" style="width:150px" onchange="javascript:getData2()" >
		<html:option value=""><font class="myfontclr1">SELECT...</html:option>
         <logic:present name="districts">
		<html:options collection="districts" name="rwsLocationBean" property="value" labelProperty="label" />
		</logic:present >
		</html:select>
		</td>
		
		
		<td class="textborder" width="100">
	<bean:message key="app.mandal"/><font color="#FF6666">*</font>
	<td class="textborder" width="150">
		    <html:select property="mcode" styleClass="mycombo" style="width:130px" onchange="javascript:getData2()">
			<html:option value=""><font class="myfontclr1">SELECT...</html:option>
             <logic:present name="mandals">
			<html:options collection="mandals" name="rwsLocationBean" property="value" labelProperty="label" />
            </logic:present >
			</html:select>
	</td>
	
	
		<td class="textborder" width="100">
	<bean:message key="app.panchayat" /><font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
		<html:select property="pcode" styleClass="mycombo" style="width:150px"  onchange="javascript:getData3()">
		<html:option value="">SELECT...</html:option>
        <logic:present name="panchayats">
		<html:options collection="panchayats" name="rwsLocationBean" property="value" labelProperty="label" />
        </logic:present >
		</html:select>
	</td>
	</tr>
	</table>
	</td>
	</tr>
	<tr>
	<td>&nbsp;</td>
	</tr>

<tr>
<td>
  <table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse;" width="440" align=center >			 	
			<tr>
			    <td class=clrborder align=center>Select</td>
			   
			   
			    <td class=clrborder align=center>Habitation Code</td>
                <td class=clrborder align=center>Habitation Name</td>
                
                
				
				
			</tr>
<%
try{ 
java.util.ArrayList a = (java.util.ArrayList)session.getAttribute("habs"); 

if(a != null && !a.equals("") &&  !a.equals("null") && a.size() > 0)
{
%>
<% int resultCount = 0;%>

<nested:iterate id="COMPNLIST" property="habs" indexId="ndx" >

<% resultCount++; %>
	
	<tr>
	<td  class=bwborder align=center>
	    <input type=radio name="assetCd1"  title="Select any Hab"  value=<nested:write  name="COMPNLIST" property="habCode" />    />
	
	</td>
       
        <td  class=bwborder align=center>
        <nested:write  name="COMPNLIST" property="habCode" /> 
        <nested:hidden name="COMPNLIST" property="habCode" indexed="true"/>
        </td>
        <td  class=bwborder align=center>
        <nested:write  name="COMPNLIST" property="habName" /> 
        <nested:hidden name="COMPNLIST" property="habName" indexed="true"/>
        </td>

                 
        
	</tr>
</nested:iterate>     
<input type="hidden"  name="resCount" value="<%=resultCount%>"/>                                                
<%
}
else 
{
%>
<tr>
<td colspan=7 align=center>No Records</td>
</tr>
<%
}



}catch(Exception e)
{
e.printStackTrace();
}

%>

  </table>
</td>
</tr>
<tr>
<td align="center">
<html:button property="mode" title="Save the Fields" styleClass="btext2" value="Save" onclick="fnSave()"  /></td>
</tr>
		


 

 	

	
	<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="100%"/>
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





