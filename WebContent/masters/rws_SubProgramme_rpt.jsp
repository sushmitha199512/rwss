<%@ include file="/commons/rws_header1.jsp" %>
</head>
<body topmargin="0">
<p align="center"><b><font face="Verdana" size="3">WaterSoft<br>
Panchayat Raj Engineering Department<br>
Rural Water Supply<br>
Govt.of Andhra Pradesh</p>
<br>
<table border="1" bordercolor=black align=center width="90%" style="border-collapse:collapse" >
<caption align=right>
	<table align=right>
	<tr>
		<td	class="bwborder" align="right">Report Date :<%=fmt.format(new java.util.Date())%></td>
	</tr>
</table>
</caption>
<tr><td colspan=4 class="textborder">Sub Programme Details</td></tr>
<tr>
	<td class="textborder" align="center">SNo</td>
	<td class="textborder" align=center><bean:message key="app.programme" /></td>
	<td class="textborder" align=center><bean:message key="app.subprgmCode" /></td>
	<td class="textborder" align=center><bean:message key="app.subprgmName" /></td>
</tr>
<% int i=1;%>
<logic:iterate id="subprgmlist" name="subprogrammes">
<tr align="left" >
	<td class=bwborder align="left"><%=i++%></td>
	<td class=bwborder align="left"><bean:write name="subprgmlist" property="prgmName" /></td>
	<td class=bwborder align=center><bean:write name="subprgmlist" property="subprgmCode" /></td>
	<td class=bwborder><bean:write name="subprgmlist" property="subprgmName" /></td>
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>