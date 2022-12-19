<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<html>
<head>
<meta http-equiv="Content-type" content="text/html;charset=utf-8" />
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<%
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy serve
%>

<title>EE DSC RegistrationForm</title>
<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:8pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:8pt;
}

</style>
</head>
<script type="text/javascript">
function dscSaveToken()
{
document.forms[0].action="switch.do?prefix=/masters&page=/regdsctoken.do&mode=Save";
document.forms[0].submit();
}
</script>
<script type="text/javascript" src="/resources/javascript/DSScript.js"> </script>
<body bgcolor="#edf2f8">
<html:form action="regdsctoken.do&mode=data" method="post">

<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Register DSC Token" />
	<jsp:param name="TWidth" value="300" />
	
</jsp:include>

<table width="400" border="0" bgcolor="#DEE3E0" bordercolor="#8A9FCD" style="border-collapse:collapse;" align="center">
  <tr>
 		<td class="textborder" width="150">EE PAO Code</td>
		<td width="50">
		<html:text property="eecode" name="eecode" value=""></html:text>
	    </td>
</tr>

<tr>
	<td class="textborder" width="150">EE PAO Name</td>
	<td width="50">
		<html:text property="eename" name="eename" value=""></html:text>
	    </td>	
  </tr>
  <tr>
	<td class="textborder" width="150">DSC Token Sign</td><td width="50">
		<html:text property="sign" name="sign" value=""></html:text>
	    </td>	
  </tr>
 <tr>
    <td colspan="2" align="center">
	    <html:button property="mode" title="Save" styleClass="btext" value="Save" onclick="dscSaveToken()"/>
 		<html:reset title="Clear" styleClass="btext" value="Reset" /> 		
	</td>
 </tr>

</table>

<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="400" />
</jsp:include>

</html:form>
  
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</body>
</html>

