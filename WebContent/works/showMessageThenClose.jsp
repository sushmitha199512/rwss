<%String message = (String)request.getAttribute("message");
System.out.println("message in showMessageThenClose.jsp:"+message);%>
<%=message%>
<html>
<head>
<script language="javascript">
function init()
{
	alert("in init mode");
	window.open("HabConvertionReport.jsp");
	window.close();
}
//-->
</SCRIPT>
</head>
<body onload="init()">
</body>