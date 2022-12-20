<%String message = (String)request.getAttribute("message"); %>
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
opener.document.forms[0].action="switch.do?prefix=/masters&page=/Asset.do&mode=data";
opener.document.forms[0].submit();
opener.document.getElementById('docBody').innerHTML="<img align='center'src='/pred/images/ajax-loader3.gif'style='position:absolute; left:350px; top:250px; height=100px; width=300px' ALT='Please wait..' border='0'></img>";

self.close();
}
//-->
</SCRIPT>
</head>
<body onload="init()">
</body>