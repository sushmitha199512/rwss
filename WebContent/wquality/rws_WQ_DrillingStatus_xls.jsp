<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
</head>

<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
<tr><td colspan=4 class="textborder">Source Finalisation Drilling  List</td></tr>
<tr>
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
<td class="bwborder" ><%=i++%></td>
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