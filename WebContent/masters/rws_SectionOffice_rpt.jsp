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
<tr><td colspan=6> <b>Section Office Details</b></td></tr>
<tr>
	<td align=center><b>SNo</b></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr>Head Office</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr>Circle Office</FONT>	</td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr>Division Office</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr>Sub Division Office</FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.code" /></FONT></td>
	<td  class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.name" /></FONT></td>
</tr>
<% int i=1;%>
<logic:iterate id="sectionlist" name="sections">
<tr align="left" >
<td align="center"><%= i++%></td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="sectionlist" property="hon" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="sectionlist" property="con" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="sectionlist" property="don" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="sectionlist" property="sdon" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="sectionlist" property="soc" /></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="sectionlist" property="son" /></FONT>
</td>
</tr>
</logic:iterate>
</table>

</body>
</html>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>