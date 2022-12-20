<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
</head>

<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
<tr><td colspan=7> <b>Item Details</b></td></tr>
<tr>
	<td align=center><b>SNo</b></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.itemCode" /></FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr>Item Name</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.district" /></FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.itemYear" /></FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.units" /></FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.rate" /></FONT></td>
	
</tr>
<% int i=1;%>
<logic:iterate id="itemlist" name="items">
<tr align="left" >
<td align="center"><%= i++%></td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="itemlist" property="itemCode" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="itemlist" property="itemName" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="itemlist" property="distCode" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="itemlist" property="finyear" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="itemlist" property="units" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="itemlist" property="rate" /></FONT>
</td>
</tr>
</logic:iterate>
</table>

</body>
</html>
