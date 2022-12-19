<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
</head>

<body topmargin="0">
<table border=1 width="400px" align=center>
<tr><td colspan=6> <font face="Verdana" size="2"><b>Mandal Sub Division Details</b></td></tr>
<tr>
	<td align=center><b><font face="Verdana" size="2">SNo</font></b></td>
	<td align=center><b><font face="Verdana" size="2">District</font></b></td>
	<td align=center><b><font face="Verdana" size="2">Circle </font></b></td>
	<td align=center><b><font face="Verdana" size="2">Division</font></b></td>
	<td align=center><b><font face="Verdana" size="2">Sub Division</font></b></td>
	<td align=center><b><font face="Verdana" size="2">Mandal</font></b></td>
</tr>
<% int i=1;%>
<logic:iterate id="mandalSubdivision" name="mandalSubdivisions">
<tr align="left" >

<td    align="left">
<FONT class=myfontclr1><%= i++%></FONT>
</td>
<td  >
<FONT class=myfontclr1><bean:write name="mandalSubdivision" property="dname" /></FONT>
</td>

<td    align="left">
<FONT class=myfontclr1><bean:write name="mandalSubdivision" property="con" /></FONT>
</td>
<td   >
<FONT class=myfontclr1><bean:write name="mandalSubdivision" property="don" /></FONT>
</td>
<td   >
<FONT class=myfontclr1><bean:write name="mandalSubdivision" property="sdon" /></FONT>
</td>
<td   >
<FONT class=myfontclr1><bean:write name="mandalSubdivision" property="mandalName" /></FONT>
</td>

</tr>
</logic:iterate>
</table>
</td></tr></table>
<br><br><br><br> 

</body>
</html>
