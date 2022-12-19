<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
</head>

<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
<tr><td colspan=4 class="head"><b>Designation Details</b></td></tr>
<tr class="bwborder">
	<td align=left><b>SNo</b></td>
	<td align=center><b><bean:message key="app.desgnCode" /></b>&nbsp;</td>
	<td  align=center><b><bean:message key="app.desgnAcr" /></b></td>
	<td  align=center><b><bean:message key="app.desgnName" /></b>
	<td  align=center><b><bean:message key="app.desgnType" /></b>
	</td>
</tr>
<% int i=1;%>
<logic:iterate id="desgnlist" name="desgns">
<tr align="left" >
<td align="left"><%= i++%></td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="desgnlist" property="desgnCode" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="desgnlist" property="desgnAcr" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="desgnlist" property="desgnName" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="desgnlist" property="desgnType" /></FONT>
</td>

</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
