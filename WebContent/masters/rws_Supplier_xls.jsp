<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
</head>

<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
<tr><td colspan=8> <b>Supplier Details</b></td></tr>
<tr>
	<td align=center><b>SNo</b></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.supplierCode" /></FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.supplierName" /></FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.address" /></FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.phone" /></FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.fax" /></FONT>	</td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.email" /></FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.supplierRegNo" /></FONT>
</tr>
<% int i=1;%>
<logic:iterate id="supplierlist" name="suppliers">
<tr align="left" >
<td align="center"><%= i++%></td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="supplierlist" property="supplierCode" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="supplierlist" property="supplierName" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="supplierlist" property="address" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="supplierlist" property="area" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="supplierlist" property="location" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="supplierlist" property="city" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="supplierlist" property="pin" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="supplierlist" property="phone" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="supplierlist" property="fax" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="supplierlist" property="email" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="supplierlist" property="supplierRegNo" /></FONT>
</td>

</tr>
</logic:iterate>
</table>

</body>
</html>
