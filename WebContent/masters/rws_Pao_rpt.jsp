<%@ include file="/commons/rws_header1.jsp" %>
</head>

<body topmargin="0">
<p align="center"><b><font face="Verdana" size="3">WaterSoft<br>
Panchayat Raj Engineering Department<br>
Rural Water Supply<br>
Govt.of Andhra Pradesh</p>
<br>


<table border="1" bordercolor=black align=center width="75%" style="border-collapse:collapse" >
<caption align=right>
	<script language="JavaScript">
	<!--
	document.write(mydate()+"<br><br>");
	//-->
	</script>
</caption>
<tr><td colspan=7> <b>Pay and Account Office Details</b></td></tr>
<tr>
	<td align=center><b>SNo</b></td>
	<td align=center><b>District Code</b></td>
	<td align=center><b>PAO Code</b></td>	<td align=center><b>PAO Name</b></td>
	<td align=center><b>Address</b></td>
	<td align=center><b>Contacts</b></td>
	
</tr>
<% int i=1;%>
<logic:iterate id="paoofficelist" name="paos">
<tr align="left" >
<td  class=mycborder1 align="center">
<FONT class=myfontclr1><%= i++%></FONT>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="paoofficelist" property="distcode" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="paoofficelist" property="paocode" /></FONT>
</td><td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="paoofficelist" property="paoName" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="paoofficelist" property="address1" /></FONT><br>
<FONT class=myfontclr1><bean:write name="paoofficelist" property="location" /></FONT><br>
<FONT class=myfontclr1><bean:write name="paoofficelist" property="area" /></FONT><br>
<FONT class=myfontclr1><bean:write name="paoofficelist" property="city" /></FONT><br>
<FONT class=myfontclr1><bean:write name="paoofficelist" property="pin" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="paoofficelist" property="phone" /></FONT><br>
<FONT class=myfontclr1><bean:write name="paoofficelist" property="email" /></FONT><br>
<FONT class=myfontclr1><bean:write name="paoofficelist" property="fax" /></FONT>
</td>


</tr>
</logic:iterate>
</table>
</td></tr></table>
<br><br><br><br><br><br><br>

<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
