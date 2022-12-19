<html>
<head>
<title>Exception Page</title>
</head>
<body>
<%if(session.getAttribute("unCaughtExceptionMessage")==null)
{ %>
<h2>An UnKnown Exception has Occured</h2>
<%} 
else
{%>
<h2><%= session.getAttribute("unCaughtExceptionMessage") %>

<%} 
session.removeAttribute("unCaughtExceptionMessage");
%>

</body>
</html>