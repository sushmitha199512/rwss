<%String message = (String)request.getAttribute("message");
%>
<html>
<head>
<script language="javascript">
function init()
{
	//alert("delete");
	var message = '<%=message%>';
	if(message!=null && message!="")
	{
		alert(message);
	}
//opener.document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do&mode=data";
//opener.document.forms[0].submit();
window.opener.location.reload();
window.close();
}
//-->
</SCRIPT>
</head>
<body onload="init()">
</body>