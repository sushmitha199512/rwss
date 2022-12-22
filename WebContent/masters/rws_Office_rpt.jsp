<%@ include file="/commons/rws_header1.jsp" %>
</head>
<body topmargin="0">
<p align="center"><b><font face="Verdana" size="3">WaterSoft<br>
Panchayat Raj Engineering Department<br>
Rural Water Supply<br>
Govt.of Andhra Pradesh</p>
<br>
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
<caption align=right>
	<table align=right>
	<tr>
		<td	class="bwborder" align="right">Report Date :<%=fmt.format(new java.util.Date())%></td>
	</tr>
</table>
</caption>
</caption>
<tr>
	<td colspan=9 class=textborder>Office Details</td>
</tr>
<tr>
	<td align=center class=textborder>SNo</td>
	<td class=textborder align=center><bean:message key="app.code" /></td>
	<td class=textborder align=center><bean:message key="app.address" /></td>
	<td class=textborder align=center><bean:message key="app.phone" /></td>
	<td class=textborder align=center><bean:message key="app.fax" /></td>
	<td class=textborder align=center><bean:message key="app.email" /></td>
	<td class=textborder align=center><bean:message key="app.building" /></td>
	<td class=textborder align=center><bean:message key="app.hof" /></td>
	<td class=textborder align=center><bean:message key="app.project" /></td>
</tr>
<% int i=1;%>
<logic:iterate id="rwsofficelist" name="offices">
<tr align="left" >
	<td align="center" class=bwborder><%= i++%></td>
	<td class=bwborder align=center><bean:write name="rwsofficelist" property="roc" /></td>
	<td class=bwborder><bean:write name="rwsofficelist" property="address" /><br>
	<bean:write name="rwsofficelist" property="area" /><br>
	<bean:write name="rwsofficelist" property="location" /><br>
	<bean:write name="rwsofficelist" property="city" /><br>
	<bean:write name="rwsofficelist" property="pin" /></td>
	<td class=bwborder align=center><bean:write name="rwsofficelist" property="phone" /></td>
	<td class=bwborder align=center><bean:write name="rwsofficelist" property="fax" /></td>
	<td class=bwborder><bean:write name="rwsofficelist" property="email" /></td>
	<td class=bwborder align=center><bean:write name="rwsofficelist" property="building" /></td>
	<td class=bwborder align=center><bean:write name="rwsofficelist" property="hof" /></td>
	<td class=bwborder align=center><bean:write name="rwsofficelist" property="project" /></td>
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>