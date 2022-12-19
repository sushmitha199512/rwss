<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
</head>

<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
<tr><td colspan=4 class="textborder">Circle Office Details</td></tr>
<tr>
	<td align=center class="textborder">SNo</td>
	<td  class="textborder" align="center"><bean:message key="app.headOffice" />&nbsp;</td>
	<td  class="textborder" align="center"><bean:message key="app.circleOfficeCode" /></td>
	<td  class="textborder" align="center"><bean:message key="app.circleOfficeName" /></td>

</tr>
<% int i=1;%>
<logic:iterate id="circlelist" name="circles">
<tr align="left" >
<td align="center" class=bwborder><%= i++%></td>
<td  class=bwborder align=center><bean:write name="circlelist" property="hon" /></td>
<td  class=bwborder align=center><bean:write name="circlelist" property="coc" /></td>
<td  class=bwborder><bean:write name="circlelist" property="con" /></td>
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
