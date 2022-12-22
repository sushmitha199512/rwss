<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>

</head>

<body topmargin="0">
<table border="1" bordercolor=black align=center width="75%" style="border-collapse:collapse" >
<caption align=right>
	<script language="JavaScript">
	<!--
	document.write(mydate()+"<br><br>");
	//-->
	</script>
</caption>
<tr><td colspan=5> <b>Pay and Account Office Details</b></td></tr>
<tr>
	<td align=center><b>SNo</b></td>
	<td align=center><b>District Code</b></td>
	<td align=center><b>District Name</b></td>
	<td align=center><b>PAO Code</b></td>
	<td align=center><b>PAO/APAO</b></td>
	<td align=center><b>PAO Name</b></td>
	<td align=center><b>Address</b></td>
	<td align=center><b>Contacts</b></td>
	
</tr>
<% int i=1;%>
<logic:iterate id="paoofficelist" name="paos">
<tr align="left" >
<td  class=mycborder1 align="center" valign="top">
<FONT class=myfontclr1><%= i++%></FONT>
</td>

<td  class=mycborder1 align=center valign="top">
<FONT class=myfontclr1><bean:write name="paoofficelist" property="distcode" /></FONT>
</td>
<td  class=mycborder1 align=center valign="top">
<FONT class=myfontclr1><bean:write name="paoofficelist" property="dname" /></FONT>
</td><td  class=mycborder1 align=center valign="top">
<FONT class=myfontclr1><bean:write name="paoofficelist" property="paocode" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="paoofficelist" property="paoapao" /></FONT>
</td>
<td  class=mycborder1 align=center valign="top">
<FONT class=myfontclr1><bean:write name="paoofficelist" property="paoName" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="paoofficelist" property="address" /></FONT><br>
<FONT class=myfontclr1><bean:write name="paoofficelist" property="location" /></FONT><br>
<FONT class=myfontclr1><bean:write name="paoofficelist" property="area" /></FONT><br>
<FONT class=myfontclr1><bean:write name="paoofficelist" property="city" /></FONT><br>
<FONT class=myfontclr1><bean:write name="paoofficelist" property="pin" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1>Phone:<bean:write name="paoofficelist" property="phone" /></FONT><br>
<FONT class=myfontclr1>Email:<bean:write name="paoofficelist" property="email" /></FONT><br>
<FONT class=myfontclr1>Fax:<bean:write name="paoofficelist" property="fax" /></FONT>
</td>


</tr>
</logic:iterate>
</table>
</body>
</html>
