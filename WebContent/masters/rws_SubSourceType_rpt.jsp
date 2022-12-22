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
		<td	class="bwborder" align="right">Report Date :<%=fmt.format(new java.util.Date()) %></td>
	</tr>
</table>
</caption>
<tr><td colspan=4 class="textborder">Sub Source Type Details</td></tr>
<tr>
	<td align=center class="textborder">SNo</td>
	<td class="textborder" align=center><bean:message key="app.sourceType" /></td>
	<td class="textborder" align=center><bean:message key="app.subSourceTypeCode" /></td>
	<td class="textborder" align=center><bean:message key="app.subSourceTypeName" /></td>
</tr>
<% int i=1;%>
<logic:iterate id="subsourcetypelist" name="subSourceTypes">
<tr align="left" >

	<td class="bwborder"><%= i++%></td>
	<td class="bwborder" align="left">&nbsp;<bean:write name="subsourcetypelist" property="sourceTypeName" /></td>
	<td class="bwborder" align="left">&nbsp;<bean:write name="subsourcetypelist" property="subSourceTypeCode" /></td>
	<td class="bwborder"><bean:write name="subsourcetypelist" property="subSourceTypeName" /></td>
</tr>
</logic:iterate>
</table>

<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
