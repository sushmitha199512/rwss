<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<html>
<body>
<%session.setAttribute("fname","BackendFTKDB.mdb"); %>
	<table align="center" cellspacing="0" cellpadding="0" rules="rows"  bordercolor="navy" style="border-collapse:collapse" bgcolor="#ffffff">
		<caption>
			<table  border="0" rules="none" style="border-collapse:collapse" align="right" bgcolor="#edf2f8">		
				<tr>
					<td align="right" class="bwborder"><a href="./home.jsp">Home</td> 
				</tr>
			</table>
		</caption>		
	</table>
	<br><br><br><br><br><br>
	<table  bordercolor="navy" width="50%" height="20%" border="1" rules="rows" style="border-collapse:collapse" align="center">
		<tr align = center><td class=rptLabel>WATER QUALITY FTK PORTING FILE&nbsp;</td></tr>
		<tr align = center><td class=rptValue><html:link action="/DownloadIt">Click here for the MDB</html:link></td></tr>
	</table>
</body>
</html>
<script language="javascript">
	<% if(request.getAttribute("message")!=null){%>
	 alert('<%=request.getAttribute("message")%>');
	<%request.removeAttribute("message"); }%>
</script>