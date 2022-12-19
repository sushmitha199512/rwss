<html>
<head>
<title>Encrypt All Passwords</title>
</head>
<body>
<%
long count = 0;
try{
	nic.watersoft.commons.MakeHashUtils utilHash = new nic.watersoft.commons.MakeHashUtils();
	/* if(request.getParameter("user_id")==null)
	{
		count = utilHash.encryptAllPwds("");
	}
	else
	{
		count = utilHash.encryptAllPwds(request.getParameter("user_id").toString());
	} */
	count = utilHash.encryptAllPwds();
}
catch(Exception e)
{
	e.printStackTrace();
}
%>
	Count Updated: <%=count %>
</body>
</html>