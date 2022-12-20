<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
</head>

<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
<tr><td colspan=3 class="head"><b>Qualification Details</b></td></tr>
<tr class="bwborder">
	<td align=center><b>SNo</b></td>
	<td  align=center><b><bean:message key="app.qualCode" /></b></td>
	<td  align=center><b><bean:message key="app.qualName" /></b></td>

</tr>
<% int i=1;%>
<logic:iterate id="quallist" name="quals">
<tr align="left" >
<td align="left"><%= i++%></td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="quallist" property="qualCode" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="quallist" property="qualName" /></FONT>
</td>
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
