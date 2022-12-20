<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>

</head>

<body topmargin="0">
<table border="1" bordercolor=black align=center style="border-collapse:collapse" width="80%">
<tr><td colspan=6 class="head"> <b>Water Quality Test Master Details</b></td></tr>
<tr class="bwborder">
	<td align=left><b>SNo</b></td>
	<td align=center><b>Test Code</b></td>
	<td align=center><b>Test Name</b></td>
	<td align=center><b>Test Period</b></td>
</tr><% int i=1;%>
<logic:iterate id="watertestlist" name="watertests">
<tr align="left" >

<td  class=mycborder1 align="left">
<FONT class=myfontclr1><%= i++%></FONT>
</td>

<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="watertestlist" property="testCode" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="watertestlist" property="testName" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="watertestlist" property="testPeriod" /></FONT>
</td>
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
