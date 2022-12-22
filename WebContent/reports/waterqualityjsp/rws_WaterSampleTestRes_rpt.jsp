<%@ include file="/commons/rws_header1.jsp" %>
<html>
<head>
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
<tr><td colspan=6 class="textborder"><b>Water Sample Test Result List</b></td></tr>
<tr>
	<td class="textborder" align="center"><b>SNo</b></td>
	<td class="textborder" align="center"><b>Source</b></td>
	<td class="textborder" align="center"><b>Type of Test</b></td>
	<td class="textborder" align="center"><b>Lab</b></td>
	<td class="textborder" align="center"><b>Recommendations</b></td>
	<td class="textborder" align="center"><b>Condemn Source</b></td>
	<td class="textborder" align="center"><b>Update Source</b></td>

</tr>
<% int i=1;%>
<logic:iterate id="watersamplereslist" name="watersampleres">
<tr align="left" >
<td class="bwborder"  ><%= i++%></td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="sourceName" /></td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="testName" /></td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="labName" /></td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="recommendations" /></td>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="condemnSource" /><br>
<td  class="bwborder" ><bean:write name="watersamplereslist" property="updateSource" /></td>

</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>

</body>
</html>
