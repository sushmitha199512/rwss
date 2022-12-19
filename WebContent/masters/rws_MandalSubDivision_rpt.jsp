<%@ include file="/commons/rws_header1.jsp" %>
</head>

<body topmargin="0">
<p align="center"><b><font face="Verdana" size="2">WaterSoft<br>
Panchayat Raj Engineering Department<br>
Rural Water Supply<br>
Govt.of Andhra Pradesh</p>
<br>

<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="60%">
<caption align=right>
<script language="JavaScript">
<!--
document.write("Reprot on : "+mydate()+"<br><br>");
//-->
</script>
</caption>
<tr><td colspan=6> <font face="Verdana" size="2"><b>Mandal Sub Division Details</b></td></tr>
<tr>
	<td align=center><b><font face="Verdana" size="2">SNo</font></b></td>
	<td align=center><b><font face="Verdana" size="2">District</font></b></td>
	<td align=center><b><font face="Verdana" size="2">Circle </font></b></td>
	<td align=center><b><font face="Verdana" size="2">Division </font></b></td>
	<td align=center><b><font face="Verdana" size="2">Sub Division</font></b></td>
	<td align=center><b><font face="Verdana" size="2">Mandal</font></b></td>
</tr>
<% int i=1;%>
<logic:iterate id="mandalSubdivision" name="mandalSubdivisions">
<tr align="left" >

<td  class=mycborder1 align="left">
<FONT class=myfontclr1><%= i++%></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="mandalSubdivision" property="dname" /></FONT>
</td>
<td  class=mycborder1 align="left">
<FONT class=myfontclr1><bean:write name="mandalSubdivision" property="con" /></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="mandalSubdivision" property="don" /></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="mandalSubdivision" property="sdon" /></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="mandalSubdivision" property="mandalName" /></FONT>
</td>

</tr>
</logic:iterate>
</table>

<br><br> 

<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
