<html>
<script language="javascript">
function fnview()
{
	if(window.confirm("Do you want to give a Complaint on Non  Working Assets"))
	{
		window.location.href="switch.do?prefix=/complaints&page=/Complaints.do?mode=get2";
	}
	else
	{
		history.go("-1");
	}
}
</script>

<body onload="javascript:fnview()">
<form>
</form>
</body>

</html>
