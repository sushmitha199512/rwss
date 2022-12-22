<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<html>
<head>
<script type="text/javascript" src="/resources/javascript/emailValidation.js"></script>
<meta http-equiv="Content-type" content="text/html;charset=utf-8" />
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">

<title>Users List Form</title>
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

<script type="text/javascript" language="JavaScript">
function saveUser(){
	//alert("hi");
document.forms[0].action="switch.do?prefix=/admin&page=/loginuser.do&mode=saveMM";	
document.forms[0].submit();
}
</script>


<body bgcolor="#edf2f8">

<html:form action="loginuser.do&mode=userLL" method="post">
<jsp:include page="/commons/TableHeader.jsp">
	<jsp:param name="TableName" value="Users List Form" />
	<jsp:param name="TWidth" value="500" />
	
</jsp:include>

<table width="43%" border="0" bgcolor="#DEE3E0" bordercolor="#8A9FCD" style="border-collapse:collapse;" align="center">
  <tr>
	    <td class="textborder" width="80">User<font color="#FF6666">*</font> <html:text property="userId"  readonly="true" ></html:text></td>
		<td class="textborder" width="80">Mobile No  <html:text property="mobileNo" ></html:text></td>
		<td class="textborder" width="80">Email Id <html:text property="mailId" ></html:text> </td>
		</tr>
		<tr>
		<td colspan="14" align="center">
		<input type="button" name="Save" value="Save" onclick="saveUser()" class="btext">
		</td>
		</tr>
 </table>
 
	

<jsp:include page="/commons/TableFotter.jsp">
	<jsp:param name="TWidth" value="500" />
</jsp:include>

</html:form>
 
  
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
</body>
</html>

