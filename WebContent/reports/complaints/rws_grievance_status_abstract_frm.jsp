<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import = "java.sql.Date" %>
<%@ page import = "java.util.*" %>
<%@ page import = "nic.watersoft.works.WorksData1" %>

<%
//String query = null;
StringBuffer query=new StringBuffer();
	nic.watersoft.commons.RwsUser user=null;
	user=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	//String loggedUser = user.getUserId();
	StringBuffer loggedUser=new StringBuffer();
		loggedUser.append(user.getUserId());
	
%>
<html>
<head>

<script language="JavaScript">
	function fnSubmit()
	{
		var loggedUser = '<%=loggedUser%>';
			
		 if(document.f1.fromDate.value=='')
			{
				alert("Please Select From Date");
				return false;
			}
			else if(document.f1.toDate.value=='')
			{
				alert("Please Select To Date");
				return false;
			}
			
					
			else
			{
				
				
				document.f1.action="./rws_grievance_status_abs_rpt.jsp";
				document.f1.submit();
			}	
		}
		</script>

</head>
<body bgcolor="#edf2f8">
<form name=f1  action="<%= request.getRequestURI()%>" method="post">
<table border = 1 align = center cellspacing = 0 cellpadding = 0 rules = "rows" bordercolor = navy style = "border-collapse:collapse" bgcolor="#ffffff" width=350>		
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
			<% 
if(loggedUser.toString()!=null && !loggedUser.toString().equals(Constants.SEC_USER))
{ %>
			<tr><td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</a></td></tr>
<%  } else {%>
	<tr><td align="right" class="bwborder"><a href="#" onclick="window.close()">Close</a></td></tr>
<%} %>

			</table>
		</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=3>Grievance Monitoring Abstract Report</td>	
	</tr>
	<%
try
{


	
	
		
%>
	
			
			
				<tr align=center>
<td align="center" class=rptvalue>From Date:&nbsp;<font color="red">*</font><input type="text" name=fromDate maxlength=10 readonly  style="width:80px">
<a href="javascript: showCalendarFuture(document.forms[0].fromDate);">
<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a><td></tr>
<tr>
<td  align="center" class=rptvalue>To Date:&nbsp;<font color="red">*</font>&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name=toDate maxlength=10 readonly  style="width:80px"><a href="javascript: showCalendarFuture(document.forms[0].toDate);">
<img src="<rws:context page='/images/calendar.gif'/>" width="25" height="17" border="0" alt="" align="absmiddle"/></a><td>
</tr>
	
<%

}
	catch(Exception e)
		{
        e.printStackTrace();
        }
%>
	<tr bgcolor="#8A9FCD" align="center">
	<td colspan=3  align="center">
	<input type=button id="vbutton" onclick="fnSubmit()" class=btext value="Get Details">
	</td>
	</tr>
</table>


<%@ include file = "/commons/rws_footer.jsp" %>
<INPUT type="hidden" name="dname">
</form>

</body>

</html>
</body>

</html>