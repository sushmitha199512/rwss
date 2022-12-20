<%@ include file="/commons/rws_header1.jsp" %>
</head>

<body topmargin="0">
<p align="center"><b><font face="Verdana" size="3">WaterSoft<br>
Panchayat Raj Engineering Department<br>
Rural Water Supply<br>
Govt.of Andhra Pradesh</p>
<br>

<table border="1" bordercolor=black align=center width="60%" style="border-collapse:collapse" >
<caption align=right>
	<table align=right>
	<tr>
		<td	class="bwborder" align="right">Report Date :<%=fmt.format(new java.util.Date())%></td>
	</tr>
</table>
</caption>
<tr><td colspan=4 class=textborder>Division Office Details</td></tr>
<tr>
	<td class=textborder >SNo.</td>
	<td  class=textborder align=center><bean:message key="app.circle" /></td>
	<td  class=textborder align=center><bean:message key="app.code" /></td>
	<td  class=textborder align=center><bean:message key="app.division" /></td>		
		
</tr>
<% int i=1;%>
<logic:iterate id="divisionlist" name="divisions">
<tr align="left" >
	<td align="left" class =bwborder ><%= i++%></td>
	<td  class=bwborder align=left><bean:write name="divisionlist" property="con" /></td>
	<td  class=bwborder align=left><bean:write name="divisionlist" property="doc" /></td>
	<td  class=bwborder><bean:write name="divisionlist" property="don" /></td>
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
