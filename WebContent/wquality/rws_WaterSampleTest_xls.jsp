<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
</head>

<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
<tr><td colspan=10 class="textborder">Water Quality Sample Collection Form</td></tr>
<tr>
<tr>
	<td class="textborder" align="center"><b>SNo</b></td>
	<td class="textborder" align="center"><b>Office</b></td>
	<td class="textborder" align="center"><b>Habitation</b></td>
	<td class="textborder" align="center"><b>Source</b></td>
	<td class="textborder" align="center"><b>Type of Test</b></td>
	<td class="textborder" align="center"><b>Nature of Test</b></td>
	<td class="textborder" align="center"><b>Lab Assigned</b></td>
	<td class="textborder" align="center"><b>Sample Collected&nbsp;By</b></td>
	<td class="textborder" align="center"><b>Collection Date & Time</b></td>
	<td class="textborder" align="center"><b>Assigned On</b></td>
</tr>
<% int i=1;%>
<logic:iterate id="watersamplelist" name="watersamples">
<tr align="left" >
<td class="bwborder" ><%= i++%></td>
<td class="bwborder"><bean:write name="watersamplelist" property="coc" /></td>
<td  class="bwborder" >&nbsp;<bean:write name="watersamplelist" property="habCode" /></td>
<td  class="bwborder" >&nbsp;<bean:write name="watersamplelist" property="sourceCode" /></td>
<td  class="bwborder" ><bean:write name="watersamplelist" property="testCode" /></td>
<td  class="bwborder" ><bean:write name="watersamplelist" property="natureOfTest" /></td>
<td  class="bwborder" ><bean:write name="watersamplelist" property="labCode" /></td>
<td  class="bwborder" ><bean:write name="watersamplelist" property="sampCollectCode" /></td>
<td  class="bwborder" ><bean:write name="watersamplelist" property="sampCollectDate" /><br>
<bean:write name="watersamplelist" property="sampCollectTime" />
<td  class="bwborder" ><bean:write name="watersamplelist" property="assignedOn" /></td>
<html:hidden name="watersamplelist" property="preparedBy" />
<html:hidden name="watersamplelist" property="coc" />
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>