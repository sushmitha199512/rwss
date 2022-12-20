<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>

</head>

<body topmargin="0">
<table border="1" bordercolor=black align=center width="90%" style="border-collapse:collapse" >
<tr><td colspan=7 class="textborder">Programme Details</b></td></tr>
<tr>
	<td align=center class="textborder">SNo</td>
	<td class="textborder" nowrap>Prog Code</td>
		<td class="textborder" nowrap>Prog Name</td>
		<td class="textborder" nowrap>Prog Start Yr.</td>
		<td class="textborder" nowrap>Shares Details</td>
		<td class="textborder" nowrap><bean:message key="app.status" /></td>
		<td class="textborder" nowrap>Prog End Date</td>
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
