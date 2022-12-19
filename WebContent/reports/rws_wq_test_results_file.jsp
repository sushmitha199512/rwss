<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<html>
<head>
</head>
<body>
<%
session.setAttribute("fname","WORK_QUALITY_TEST_REPORT.mdb");


 %>
<table align=center cellspacing = 0 cellpadding = 0 rules="rows"  bordercolor=navy style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
	<table  border=0 rules=none style="border-collapse:collapse" align = "right" bgcolor="#edf2f8">
		
		<tr>
				<td align="right" class="bwborder"><a href="./home.jsp">Home</td> 
			</tr>
			</table>
		</caption>
		
</table>

<br><br><br><br><br><br>
<table  bordercolor= navy width="50%" height="20%" border=1 rules="rows" style="border-collapse:collapse" align = center>
<tr align = center><td class=rptLabel>WQ TEST RESULTS PORTING FILE&nbsp;</td></tr>
<tr align = center><td class=rptValue>
<html:link action="/reports/DownloadIt">Click here for the MDB</html:link> 
</td></tr>
</table>
</body>
</html>
<script language="javascript">

		 alert("WQ test results MDB file Created Successfully");
		
</script>