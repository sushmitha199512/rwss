<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>

</head>
<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="60%">
<tr><td colspan=3 class="textborder">Public Institution Details</td></tr>
<tr>
	<td align=left class="textborder">SNo</td>
	<td align=center class="textborder"><bean:message key="app.instCode" /></td>
	<td class="textborder"><bean:message key="app.instName" /></td>
</tr>
<% int i=1;%>
<logic:iterate id="publicreplist" name="institutes">
<tr align="left" >

	<td  class=bwborder align="center"><%= i++%></td>

	<td  class=bwborder align=center align=center><bean:write name="publicreplist" property="instituteCode" /></td>
	<td  class=bwborder ><bean:write name="publicreplist" property="instituteName" /></td>

</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
