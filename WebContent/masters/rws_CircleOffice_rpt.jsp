<%@ include file="/commons/rws_header1.jsp" %>
</head>

<body topmargin="0">
<p align="center"><b><font face="Verdana" size="3">WaterSoft<br>
Panchayat Raj Engineering Department<br>
Rural Water Supply<br>
Govt.of Andhra Pradesh</p>
<br>

<table border="1" bordercolor=black align=center width="90%" style="border-collapse:collapse" >
<caption align=right>
	<table align=right>
	<tr>
		<td	class="bwborder" align="right">Report Date :<%=fmt.format(new java.util.Date())%></td>
	</tr>
</table>
</caption>

<tr><td colspan=4 class="textborder">Circle Office Details</td></tr>
<tr>
	<td class="textborder" align=center>SNo</td>
	<td class=textborder align="center"><bean:message key="app.headOffice" />&nbsp;</td>
	<td class=textborder align="center"><bean:message key="app.circleOfficeCode" /></td>
	<td class=textborder align="center"><bean:message key="app.circleOfficeName" /></td>
</tr>
<% int i=1;%>
<logic:iterate id="circlelist" name="circles">
<tr align="left" >
<td align="center" class=bwborder><%= i++%></td>
<td  class=bwborder align=center><bean:write name="circlelist" property="hon" /></td>
<td  class=bwborder align=center><bean:write name="circlelist" property="coc" /></td>
<td  class=bwborder><bean:write name="circlelist" property="con" /></td>
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
