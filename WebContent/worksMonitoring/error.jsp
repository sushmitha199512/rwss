
<%@ page isErrorPage="true" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<html>
<head>
<title> Error Page</title>
</head>

<body>
<h1>An error has occurred</h1>
<hr>
<%= exception %>

<html:errors />
</body>
</html>
