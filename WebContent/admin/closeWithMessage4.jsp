<%
String message = (String)request.getAttribute("message");%>
<html>
<head>
<script language="javascript">
function init()
{
	var message = '<%=message%>';
	if(message!=null && message!="")
	{
		alert(message);
	}
window.opener.location.reload();
window.close();
}
//-->
</SCRIPT>
</head>
<body onload="init()">
</body>