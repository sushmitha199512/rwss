<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
</head>

<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
<tr><td colspan=3 class="textborder">Source Type Details</td></tr>
<tr>
		<td align=left class="textborder">SNo</td>
		<td class="textborder" align=center><bean:message key="app.sourceTypeCode" /></td>
		<td class="textborder" align=center><bean:message key="app.sourceTypeName" /></td>
</tr>
<% int i=1;%>
<logic:iterate id="sourcetypelist" name="sourceTypes">
<tr align="left" >

	<td align="left" class=bwborder><%= i++%></td>

	<td class=bwborder align=left><bean:write name="sourcetypelist" property="sourceTypeCode" /></td>
	<td class=bwborder><bean:write name="sourcetypelist" property="sourceTypeName" /></td>
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
