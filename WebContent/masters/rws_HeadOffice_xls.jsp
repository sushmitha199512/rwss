<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
</head>

<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
<tr><td colspan=3> <b>Head Office Details</b></td></tr>
<tr>
	<td align=center><b>SNo</b></td>
	<td    align=center><b>
	 <bean:message key="app.hoc" />&nbsp;</b></font></FONT></td>
	<td   align=center><b>
 <bean:message key="app.hon" /></b></FONT>
	</td>
<td   align=center><b>
 <bean:message key="app.honame" /></b></FONT>
	</td>
</tr>
<% int i=1;%>
<logic:iterate id="headlist" name="headdetails">
<tr align="left" >
<td align="center"><%= i++%></td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="headlist" property="hoc" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="headlist" property="hon" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="headlist" property="hoName" /></FONT>
</td></tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
