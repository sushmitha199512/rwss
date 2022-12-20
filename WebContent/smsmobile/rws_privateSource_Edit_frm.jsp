<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER"); 
String sourceCode=(String)session.getAttribute("nextSourceCode");
String tname=(String)session.getAttribute("tname");
%>

<%-- <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%> --%>
<!DOCTYPE html>
<html>
<head>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"> -->
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">

<script language="JavaScript">

function autocompletion()
{
	 for (i=0; i<document.forms.length; i++) {
        document.forms[i].setAttribute("AutoComplete","off");
       }
}

function fnSave()
{
	
	var sourceImg = document.getElementById('sourceImg');
    var FileUploadPath = sourceImg.value;

   
    
 if(document.forms[0].psourceLoc.value=="" || document.forms[0].psourceLoc.value=="")
	{
	alert("Please Enter Source Code Location ");
	return false;

	}
    
    else if(document.forms[0].psourceName.value=="" || document.forms[0].psourceName.value=="")
	{
	alert("Please Enter Owner Name ");
	return false;

	}
    
    else if(document.forms[0].psourceMob.value=="" || document.forms[0].psourceMob.value=="")
	{
	alert("Please Enter Owner Owner Mobile Number ");
	return false;

	}
    
   else if (document.forms[0].sourceImg.value == ""
				|| document.forms[0].sourceImg.value == "") {
			alert("Please upload Source Image ");
			return false;

		}else if (!fileMimeType(FileUploadPath)) {			
			return false;
		}
    
    else if(document.forms[0].psourceLat.value=="" || document.forms[0].psourceLat.value=="")
	{
	alert("Please Enter Source Latitude");
	return false;

	}
    else if(document.forms[0].psourceLong.value=="" || document.forms[0].psourceLong.value=="")
	{
	alert("Please Enter Source Longitude ");
	return false;

	}

	
    else{
		document.forms[0].action="switch.do?prefix=/smsmobile&page=/PrivateSourceReg.do?mode=update";
		
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
	document.forms[0].action="switch.do?prefix=/smsmobile&page=/PrivateSourceReg.do?mode=view";
	document.forms[0].submit();
		}
}

function getData2()
{
    
	document.forms[0].action="switch.do?prefix=/smsmobile&page=/PrivateSourceReg.do?mode=get2";
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
	<html:form action="/PrivateSourceReg.do" method="post" enctype="multipart/form-data">

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
		<jsp:param name="TableName" value="Private Source Edit Form" />
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
   <legend>Private Source Details</legend>
   <label>
   <table  border=0  width="50%"  align=center  style="margin-bottom:0;margin-top:0">
    <tr>
	    <td class="textborder" width="100"><bean:message key="app.district"/><font color="#FF6666">*</font></td>
		<td class="textborder" width="150">
		
	
		<html:text property="districtName" styleClass="mytext" style="width:150px" readonly="true" />
		<html:hidden property="circleOfficeCode"/>
		
		</td>
		</tr>
		<tr>
		<td class="textborder" width="100">
	<bean:message key="app.mandal"/><font color="#FF6666">*</font>
	<td class="textborder" width="150">
	<html:text property="mand" styleClass="mytext" style="width:150px" readonly="true" />
		
		    
	</td>
	</tr>
	<tr>
		<td class="textborder" width="100">
	<bean:message key="app.panchayat" /><font color="#FF6666">*</font></td>
	<td class="textborder" width="150">
		<html:text property="panch" styleClass="mytext" style="width:150px" readonly="true" />
	</td>
	
		</tr>

	<tr>
	<td class="textborder" width="100">
	<bean:message key="app.habCode" /><font color="#FF6666">*</font></td>
	<td class="textborder" colspan=3>
		<html:text property="panchName" styleClass="mytext" style="width:150px" readonly="true" />
	</td>
	</tr>
	 <tr>
	 <td class="textborder" >
      Private&nbsp;Source&nbsp;Code</td><td><html:text property="psourceCode" styleClass="mytext" style="width:150px"  onkeypress="return numeralsOnly(event)" readonly="true"/>
       </td>
	</tr>
	
	
	<tr>
	 <td class="textborder" >
      Private&nbsp;Source&nbsp;Location</td><td><html:text property="psourceLoc" styleClass="mytext" style="width:150px"  />
       </td>
	</tr>
	<tr>
	 <td class="textborder" >
      Private&nbsp;Source&nbsp;Location&nbsp;in&nbsp;Telugu</td><td><input type="text" id="psourceLocT"  name="psourceLocT" style="width:150px"  maxlength="100"  value="<%=tname%>" />
       </td>
	</tr>
	
	
	<tr>
	 <td class="textborder" >
      Source&nbsp;Owner&nbsp;Name</td><td><html:text property="psourceName" styleClass="mytext" style="width:150px"  />
       </td>
	</tr>
	
	
	<tr>
	 <td class="textborder" >
      Source&nbsp;Owner&nbsp;Mobile</td><td><html:text property="psourceMob" styleClass="mytext" style="width:150px"  onkeypress="return numeralsOnly(event)" maxlength="10"/>
       </td>
	</tr>
	
	<tr>
	 <td class="textborder" width="100">
	 Upload&nbsp;Source&nbsp;Image<font color="#FF6666">*</font> </td><td><html:file property="sourceImg" styleClass="mytext" style="width:150px" onchange="javascript:rest();javascript:ValidateFileUpload();" /></td>
   
	</tr>
	
	<tr>
	 <td class="textborder" >
      Latitude</td><td><html:text property="psourceLat" styleClass="mytext" style="width:150px"  onkeypress="return decimalsOnly(event)" maxlength="10" />
       </td>
	</tr>
	
	<tr>
	 <td class="textborder" >
      Longitude</td><td><html:text property="psourceLong" styleClass="mytext" style="width:150px"  onkeypress="return decimalsOnly(event)" maxlength="10" />
       </td>
	</tr>
	
	
	
		</table>
		</label>
	</fieldset>
	</td>
</tr>



   
   
  
   
 <tr align=center>
	<td>
	<html:button property="save" title="Save the Fields"  styleClass="btext" value="Update"  onclick="fnSave();"/>

	
</td>
    </tr>


</table>
		</td>
		</tr>
		</tbody>
		</table>
</html:form>
										<font color="red" face="verdana" size="2">Note: Please enter only telugu alphabets in Private Source Location in Telugu &&<br/><font color="blue" face="verdana" size="2">Numbers and Special characters are not allowed.</font></font>

</body>
</html>





<p align="center">
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</p>
