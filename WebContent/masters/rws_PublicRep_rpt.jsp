<%@ include file="/commons/rws_header1.jsp" %>
</head>

<body topmargin="0">
<p align="center"><b><font face="Verdana" size="3">WaterSoft<br>
Panchayat Raj Engineering Department<br>
Rural Water Supply<br>
Govt.of Andhra Pradesh</p>
<br>

<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="60%">
<caption align=right>
<table align=right>
	<tr>
		<td	class="bwborder" align="right">Report Date :<%=fmt.format(new java.util.Date()) %></td>
	</tr>
</table>
</caption>
<tr><td colspan=3 class="textborder"> Public Representatives Details</td></tr>
<tr>
	<td align=left class="textborder">SNo</td>
	<td align=left class="textborder"><bean:message key="app.repCode" /></td>
	<td class="textborder"><bean:message key="app.repName" /></td>
</tr>
<% int i=1;%>
<logic:iterate id="publicreplist" name="publicReps">
<tr align="left" >
	<td  class="bwborder" align="left"><%= i++%></td>

	<td  class="bwborder" align="left">
		<bean:write name="publicreplist" property="publicRepCode" />
	</td>
	<td  class="bwborder" >
		<bean:write name="publicreplist" property="publicRepName" />
	</td>
</tr>
</logic:iterate>
</table>
<br><p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
