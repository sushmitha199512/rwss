<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
</head>

<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
<tr><td colspan=9> <b>Store Details</b></td></tr>
<tr>
	<td align=center><b>SNo</b></td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.district" /></FONT></td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.mandal" /></FONT></td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.subdivision" /></FONT></td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.storeCode" /></FONT></td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.location" /></FONT>
	<td class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.storeInCharge" /></FONT></td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.empcode" /></FONT></td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.postheld" /> </FONT></td>
</tr>
<% int i=1;%>
<logic:iterate id="storelist" name="stores">
<tr align="left" >
<td align="center"><%= i++%></td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="storelist" property="district" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="storelist" property="mandal" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="storelist" property="subdivision" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="storelist" property="storeCode" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="storelist" property="location" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="storelist" property="storeInCharge" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="storelist" property="empcode" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="storelist" property="postheld" /></FONT>
</td>

</tr>
</logic:iterate>
</table>

</body>
</html>
