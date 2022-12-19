<%String message = (String)request.getAttribute("message");
System.out.println("AAAAAAAAAAAA:"+message);
%>
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


self.close();
}
//-->
</SCRIPT>
</head>
<body onload="init()">
</body>