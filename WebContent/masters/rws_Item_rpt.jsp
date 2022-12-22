<%@ include file="/commons/rws_header1.jsp" %>
</head>

<body topmargin="0">
<p align="center"><b><font face="Verdana" size="3">WaterSoft<br>
Panchayat Raj Engineering Department<br>
Rural Water Supply<br>
Govt.of Andhra Pradesh</p>
<br>

<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
<script language="JavaScript">
<!--
document.write("Report on : "+mydate()+"<br><br>");
//-->
</script>
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
	<td  class=mycborder align=center>
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
<br><br><br><br><br><br><br>

<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>

</body>
</html>
