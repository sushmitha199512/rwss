<%@ include file="header_rpt.jsp" %>
<%@ page isErrorPage="true" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<html>
<head>
<title> Error Page</title>
<script>
	
function back()
{
	location.href="/Pred/login.jsp";
}

</script>
</head>
<body align=center bgcolor="#ffffff">
<br><br><br><br><br><br>
<center>
<h1>Invalid UserName and PassWord</h1>
<hr>
<IMG SRC="resources/images/doorin.gif" WIDTH="50" HEIGHT="50" onclick="back()" style="cursor:hand" alt="Back">
<br><a href="./login.jsp">BACK</a>

<html:errors />
<p align="center">

<%@ include file="footer.jsp" %>


              </p>
			  </center>
</body>
</html>
