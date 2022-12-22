<%@ include file="/commons/rws_header1.jsp" %>
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
		<td	class="bwborder" align="right">Report Date :<%=fmt.format(new java.util.Date()) %></td>
	</tr>
</table>
</caption>
<tr><td colspan=5 class="textborder">Priority Details</td></tr>
<tr>
	<td align=left class="textborder">SNo</td>
	<td class="textborder" align=center><bean:message key="app.priorityCode" /></td>
	<td class="textborder" align=center><bean:message key="app.priorityDesc" /></td>
	<td class="textborder" align=center><bean:message key="app.priorityFrom" /></td>
	
	
</tr>
<% int i=1;%>
<logic:iterate id="prioritylist" name="prioritys">
<tr>
<td class=myfontclr1><%= i++%></td>
<td class="bwborder" align=center>
<FONT class=myfontclr1><bean:write name="prioritylist" property="priorityCode" />
</td>
<td  class="bwborder">
<FONT class=myfontclr1><bean:write name="prioritylist" property="priorityDesc" />
</td>
<td  class="bwborder" >
<FONT class=myfontclr1><bean:write name="prioritylist" property="priorityFrom" />
</td>
</tr>
</logic:iterate>
</table>

<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
