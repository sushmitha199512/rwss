<%@ page import="nic.watersoft.scheduler.ScheduleJob_Tot_Transactions" %>
<html>
<h1>Loading...</h1>
<img id="progress" src="../images/loading1.gif">
<%
ScheduleJob_Tot_Transactions jl=new ScheduleJob_Tot_Transactions();
jl.customExcecute();
%>
 <script language="JavaScript">
 
	 window.opener.location.reload();
	 window.close();
</script> 

</html>