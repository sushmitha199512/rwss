<%String message = (String)request.getAttribute("message");
//System.out.println("messssssage in wquality:"+message);
//System.out.println("modeeeeee:"+request.getParameter("mode"));%>
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
window.close();
}
//-->
</SCRIPT>
</head>
<body onload="init()">
</body>