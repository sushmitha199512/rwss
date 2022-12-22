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
		<td	class="bwborder" align="right">Report Date :<%=fmt.format(new java.util.Date())%></td>
	</tr>
	</table>
</caption>
<tr><td colspan=3 class="head"> <b>Work Specialzation Details</b></td></tr>
<tr class="bwborder">
	<td align=center  >SNo</td>
	<td   align=center><b><bean:message key="app.workSpecCode" /></b></FONT>
	</td>
	<td   align=center><b><bean:message key="app.workSpecName" /></b></FONT>
	</td>	
</tr>
<% int i=1;%>
<logic:iterate id="workSpeclist" name="workSpecs">
<tr align="left" >

<td align="left" class=myfontclr1>
<%= i++%>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="workSpeclist" property="workSpecCode" /></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="workSpeclist" property="workSpecName" /></FONT>
</td>
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
