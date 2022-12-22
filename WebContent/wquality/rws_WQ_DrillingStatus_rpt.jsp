<%@ include file="/commons/rws_header1.jsp" %>
</head>

<body topmargin="0">
<p align="center"><b><font face="Verdana" size="3">WaterSoft<br>

Rural Water Supply & Sanitation<br>
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
<tr><td colspan=5 class="textborder">Source Finalisation Drilling  List</td></tr>
<tr>
	<td class="textborder" align="center">SNo</td>
	<td class="textborder" align="center">Work Code</td>
	<td class="textborder" align="center">Drilling Status</td>
	<td class="textborder" align="center">Drilling Date</td>
	<td class="textborder" align="center">Yield</td>	
</tr>
<% int i=1;%>
<logic:iterate id="wqDrillList" name="wqDrillStatus">
<tr align="left" >
<td class="bwborder" ><%= i++%></td>
<td  class="bwborder" align="center"><bean:write name="wqDrillList" property="workCode" /></td>
<td  class="bwborder" align="center"><bean:write name="wqDrillList" property="drillStatus" /></td>
<td  class="bwborder" align="center"><bean:write name="wqDrillList" property="drillDate" /></td>
<td  class="bwborder" align="center"><bean:write name="wqDrillList" property="yield" /></td>
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>

</body>
</html>
