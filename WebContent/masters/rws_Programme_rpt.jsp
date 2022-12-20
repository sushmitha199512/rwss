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
		<td	class="bwborder" align="right">Report Date :<%=fmt.format(new java.util.Date()) %></td>
	</tr>
</table>
</caption>
<tr><td colspan=7 class="textborder">Programme Details</td></tr>
<tr>
	<td align=center class="textborder">SNo</td>
	<td class="textborder" nowrap>Programme Code</td>
		<td class="textborder" nowrap>Programme Name</td>
		<td class="textborder" nowrap>Fin. Start Yr.</td>
		<td class="textborder" nowrap>Shares Details</td>
		<td class="textborder" nowrap><bean:message key="app.status" /></td>
		<td class="textborder" nowrap>Programme End Date</td>
		</tr>
<% int i=1;%>
<logic:iterate id="programmelist" name="programmes">
<tr align="left" >
	<td class="bwborder" align="center" ><%= i++%></td>

	<td class="bwborder" align=center><bean:write name="programmelist" property="prgmCode" /></td>
	<td class="bwborder"><bean:write name="programmelist" property="prgmName" /></td>
	<td class="bwborder" align=center><bean:write name="programmelist" property="prgmStartYr" /></td>
	<td class="bwborder">Central Share:<bean:write name="programmelist" property="centralShare" /><br>
	State Share  &nbsp;&nbsp;&nbsp;:<bean:write name="programmelist" property="stateShare" /><br>
	Public Share &nbsp;&nbsp;:<bean:write name="programmelist" property="publicShare" /><br>
	Other Share &nbsp;&nbsp; :<bean:write name="programmelist" property="otherShare" /></td>
	<td class="bwborder" align=center><bean:write name="programmelist" property="status" /></td>
	<td class="bwborder" align=center><bean:write name="programmelist" property="prgmEndDate" /></td>
</tr>
</logic:iterate>
</table>
</td></tr></table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>