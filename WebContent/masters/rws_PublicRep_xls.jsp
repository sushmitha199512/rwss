<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>

</head>
<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="60%">
<tr>
	<td colspan=3 class="textborder"> <b>Public Representatives Details</b></td></tr>
<tr>
	<td align=left class="textborder">SNo</td>
	<td align=left class="textborder"><bean:message key="app.repCode" /></td>
	<td class="textborder"><bean:message key="app.repName" /></td>
</tr>
<% int i=1;%>
<logic:iterate id="publicreplist" name="publicReps">
<tr align="left" >
	<td  class=bwborder align="left"><%= i++%></td>
	<td  class=bwborder align="left"><bean:write name="publicreplist" property="publicRepCode" /></td>
	<td  class=bwborder><bean:write name="publicreplist" property="publicRepName" /></td>
</tr>
</logic:iterate>
</table>

</body>
</html>
