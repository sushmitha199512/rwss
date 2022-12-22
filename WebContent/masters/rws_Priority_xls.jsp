<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
</head>

<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
<tr><td colspan=4 class="textborder">Priority Details</td></tr>
<tr>
	<td align=left class="textborder">SNo</td>
	<td class="textborder" align=center><bean:message key="app.priorityCode" /></td>
	<td class="textborder" align=center><bean:message key="app.priorityDesc" /></td>
	<td class="textborder" align=center><bean:message key="app.priorityFrom" /></td>
		
</tr>
<% int i=1;%>
<logic:iterate id="prioritylist" name="prioritys">
<tr align="left" >

	<td class=bwborder><%= i++%></td>
	<td class=bwborder align=center><bean:write name="prioritylist" property="priorityCode" /></td>
	<td class=bwborder><bean:write name="prioritylist" property="priorityDesc" /></td>
	<td class=bwborder><bean:write name="prioritylist" property="priorityFrom" /></td>
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
