<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
</head>

<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
<tr><td colspan=4 class="textborder">Sub Source Type Details</b></td></tr>
<tr>
	<td align=center class="textborder">SNo</td>
	<td class="textborder" align=center><bean:message key="app.sourceTypeCode" /></td>
	<td  class="textborder" align=center><bean:message key="app.subSourceTypeCode" /></td>
	<td  class="textborder" align=center><bean:message key="app.subSourceTypeName" /></td>
</tr>
<% int i=1;%>
<logic:iterate id="subsourcetypelist" name="subSourceTypes">
<tr align="left" >
	<td class="bwborder"><%= i++%></td>
	<td class="bwborder" align="left"><bean:write name="subsourcetypelist" property="sourceTypeName" /></td>
	<td class="bwborder" align="left"><bean:write name="subsourcetypelist" property="subSourceTypeCode" /></td>
	<td class="bwborder"><bean:write name="subsourcetypelist" property="subSourceTypeName" /></td>
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
