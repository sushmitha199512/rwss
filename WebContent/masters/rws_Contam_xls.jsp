<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
</head>

<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
<tr><td colspan=3 class="textborder">Contamination Details</td></tr>
<tr>
	<td align=center class="textborder">SNo</td>
	<td class=textborder align=center><bean:message key="app.contamCode" /></td>
	<td class=textborder align=center><bean:message key="app.contamName" /></td>	
</tr>
<% int i=1;%>
<logic:iterate id="contamlist" name="contams">
<tr align="left" >
	<td align="center" class=bwborder><%= i++%></td>
	<td class=bwborder align=center><bean:write name="contamlist" property="contamCode" /></td>
	<td class=bwborder><bean:write name="contamlist" property="contamName" /></td>
</tr>
</logic:iterate>
</table>
</body>
</html>