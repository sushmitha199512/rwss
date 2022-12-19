<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER"); %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">

<script language="JavaScript">

function autocompletion()
{
      // alert("auto comp");
	 for (i=0; i<document.forms.length; i++) {
        document.forms[i].setAttribute("AutoComplete","off");
       }
}

function fnUpdate()
{
	
	if(document.getElementById("tankerRegNo").value=="")
	{
	alert("Please Enter Tanker Reg No");
	return false;
	}
	else if(document.getElementById("tankerRCNo").value=="")
	{
		alert("Please Enter Tanker RC Number");
		return false;
	}
	else if(document.getElementById("tankerRCName").value=="")
	{
		alert("Please Enter Tanker RC Name");
		return false;
	}
	else if(document.getElementById("tankerCapacity").value=="")
	{
	alert("Please Enter Tanker Capacity in Kilo Litres");
	return false;
	}
	else if(document.getElementById("tankerOwnerName").value=="")
	{
	alert("Please Enter Driver Name");
	return false;
	}
	/* else if(document.getElementById("tankerOwnerAadhar").value=="")
	{
	alert("Please Enter Tanker Owner Aadhar");
	return false;
	}
	else if(document.getElementById("tankerOwnerAadhar").value.length!=12)
	{
		alert("Please Enter 12 Digits Aadhar Number");
		return;
	} */
	else if(document.getElementById("tankerOwnerMobileNumber").value=="")
	{
	alert("Please Enter Driver Mobile Number");
	return false;
	}
	else if(document.getElementById("tankerOwnerMobileNumber").value.length!=10)
	{
		alert("Please Enter 10 Digits Mobile Number");
		return;
	}
	else if(document.forms[0].tankerOwnerIMEINumber.value.length!=15)
	{
		alert("Please Enter 15 Digits IMEI Number");
		return;
	}
	else
		{
		
		document.forms[0].action="switch.do?prefix=/smsmobile&page=/TankerRegistration.do?mode=update";
		document.forms[0].submit();
		
		}
	
	
	}

function fnView(){
	
	if(document.getElementById("circleOfficeCode").value=="")
	{
		alert("Please Select District");
		return false;
	}
	else
		{
	document.forms[0].action="switch.do?prefix=/smsmobile&page=/TankerRegistration.do?mode=view";
	document.forms[0].submit();
		}
}

function getData2()
{
    
	document.forms[0].action="switch.do?prefix=/smsmobile&page=/TankerRegistration.do?mode=get2";
	document.forms[0].submit();
    
     
}

</script>

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



</head>

<body onload="autocompletion()">
	<html:form action="/TankerRegistration.do" method="post" enctype="multipart/form-data">
	<%
			String csrfToken = "";
				nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
				csrfToken = valUtil.getCSRFCode();
				session.setAttribute("csrfToken", csrfToken);
		%>
		<html:hidden property="token" styleClass="mytext"
			value="${sessionScope.csrfToken}" />
<table align="center" cellpadding="0" cellspacing="0" border=0>
<thead>
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Tanker Registration Edit Form" />
		<jsp:param name="TWidth" value="100%" />
		
	</jsp:include>
</td>
</tr>
</thead>

<tfoot>
<tr>
<td>
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="100%"/>
	</jsp:include>
</td>
</tr>
</tfoot>

<tbody>
<tr>
<td>

<table bgcolor="#DEE3E0" bordercolor= "#8A9FCD" rules="cols" border="1" 
	   style="border-collapse:collapse;" width="450" >
<tr>
<td>
   <fieldset>
   <legend>Registration Details</legend>
   <label>
   <table  border=0  width="50%"  align=center  style="margin-bottom:0;margin-top:0">
      <tr>
	    <td class="textborder" width="100"><bean:message key="app.district"/>&nbsp;<font color="#FF6666">*</font></td>
		<td class="textborder" width="80">
		<html:text property="districtName" styleClass="mytext" style="width:150px" disabled="true"/>
		</td>
		</tr>
		<tr>
		<td class="textborder" width="100">
	<bean:message key="app.mandal"/>&nbsp;<font color="#FF6666">*</font>
	<td class="textborder" width="150">
		    <html:text property="mandal" styleClass="mytext" style="width:150px" disabled="true"/>
	</td>
	</tr>
	 <tr>
		<td class="textborder" width="100">
	<bean:message key="app.panchayat" />&nbsp;<font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
		<html:text property="panchayat" styleClass="mytext" style="width:150px" disabled="true"/>
	</td>
	
		</tr> 
		
	<tr>
	<td class="textborder" width="100">
	<bean:message key="app.habCode" />&nbsp;<font color="#FF6666">*</font></td>
	<td class="textborder" colspan=3>
		<html:text property="habName" styleClass="mytext" style="width:150px" disabled="true"/>
		<html:hidden property="habCode" styleClass="mytext" style="width:150px"/>
	</td>
	</tr>
	 <tr>
	 <td class="textborder" >
       Tanker&nbsp;Reg.&nbsp;No&nbsp;<font color="#FF6666">*</font></td><td><html:text property="tankerRegNo" styleClass="mytext" style="width:150px" readonly="true"/></td>
	</tr>
	<tr>
	 <td class="textborder" >
       Tanker&nbsp;RC&nbsp;No&nbsp;<font color="#FF6666">*</font></td><td><html:text property="tankerRCNo" styleClass="mytext" style="width:150px"/></td>
	</tr>
	<tr>
	 <td class="textborder" >
       Tanker&nbsp;RC&nbsp;Name&nbsp;<font color="#FF6666">*</font></td><td><html:text property="tankerRCName" styleClass="mytext" style="width:150px"/></td>
	</tr>
	
	<tr>
	 <td class="textborder" >
       Tanker&nbsp;Capacity(in KLtrs)&nbsp;<font color="#FF6666">*</font></td><td><html:text property="tankerCapacity" styleClass="mytext" style="width:150px"/></td>
	</tr>
	
	<tr>
	<td class="textborder" >
       Driver&nbsp;Name&nbsp;<font color="#FF6666">*</font></td>
       
       <td>
       
       <html:text property="tankerOwnerName" styleClass="mytext" style="width:150px"/>
       </td>
     
	</tr>
	<tr>
	<%-- <td class="textborder" >
     Tanker&nbsp;Owner&nbsp;Aadhar&nbsp;<font color="#FF6666">*</font></td><td><html:text property="tankerOwnerAadhar" styleClass="mytext" style="width:150px"    onkeypress="return numeralsOnly(event)" />
       </td> --%>
        <html:hidden property="tankerOwnerAadhar" value="0" />
	</tr>
	
	
	
	<tr>
	
	 <td class="textborder" >
       Driver&nbsp;Mobile&nbsp;Number&nbsp;<font color="#FF6666">*</font></td><td><html:text property="tankerOwnerMobileNumber" maxlength="10"  size="10"   styleClass="mytext" style="width:150px"  onkeypress="return numeralsOnly(event)"  />
       </td>
	</tr>
			
	<tr>
	
	 <td class="textborder" >
       Driver&nbsp;IMEI&nbsp;Number&nbsp;<font color="#FF6666">*</font></td><td><html:text property="tankerOwnerIMEINumber" maxlength="15"  size="15"   styleClass="mytext" style="width:150px"  onkeypress="return numeralsOnly(event)"  />
       </td>
	</tr>
	<tr>
	<td class="textborder" >
       Remarks</td><td><html:textarea property="remarks"  rows="3" cols="18" />
       </td>
	</tr>
		</table>
		</label>
	</fieldset>
	</td>
</tr>



   
   
  
   
 <tr align=center>
	<td>
	<html:button property="save" title="Save the Fields"  styleClass="btext" value="Update"  onclick="fnUpdate();"/>

	<html:button property="view" title="View the Fields"  styleClass="btext" value="View"  onclick="fnView();"/>
</td>
    </tr>


</table>
		</td>
		</tr>
		</tbody>
		</table>
</html:form>
<table width="30%" align=center>
	<tr>
		<td bordercolor="black"><font color="red" size="2">NOTE&nbsp;&nbsp;:&nbsp;&nbsp;</font></td>
		<td class=rptValue nowrap>1. For IMEI Number Dial <font
			color="red"> *#06# </font>on your Phone or Tab
		</td>
	</tr>


</table>
</body>
</html>




<p align="center">
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</p>
