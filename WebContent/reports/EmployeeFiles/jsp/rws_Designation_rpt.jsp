<%@ include file="/commons/rws_header1.jsp" %>
<%
	java.text.SimpleDateFormat sdfmt = new java.text.SimpleDateFormat("dd/MM/yyyy");
%>
	

</head>

<body topmargin="0">
<p align="center"><b><font face="Verdana" size="3">WaterSoft<br>
Panchayat Raj Engineering Department<br>
Rural Water Supply<br>
Govt.of Andhra Pradesh</p>
<br>

<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
<caption align=right>
	<table align=right>
	<tr>
		<td	class="bwborder" align="right">Report Date :<%=fmt.format(new java.util.Date())%></td>
	</tr>
	</table>
</caption>
<tr><td colspan=4 class="head"><b>Designation Details</b></td></tr>
<tr class="bwborder">
	<td align=left><b>SNo</b></td>
	<td align=center><b><bean:message key="app.desgnCode" /></b>&nbsp;</td>
	<td  align=center><b><bean:message key="app.desgnAcr" /></b></td>
	<td  align=center><b><bean:message key="app.desgnName" /></b>
	<td align=center><b><bean:message key="app.desgnType"/></b>
	</td>
</tr>
<% int i=1;%>
<logic:iterate id="desgnlist" name="desgns">
<tr align="left" >
<td class="myfontclr1"><%= i++%></td>
<td  class=mycborder1>
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
