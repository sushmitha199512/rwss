<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>

</head>

<body topmargin="0">
<table border="1" bordercolor=black align=center style="border-collapse:collapse" width="80%">
<tr><td colspan=6 class="head"> <b>Water Quality Parameter Test Details</b></td></tr>
<tr class="bwborder">
	<td align=left><b>SNo</b></td>
	<td align=center><b>Test </b></td>
	<td align=center><b>Parameter Code</b></td>
	<td align=center><b>Parameter Name</b></td>
	<td align=center><b>Min Per Val</b></td>
	<td align=center><b>Max Per Val</b></td>
</tr>
<% int i=1;%>
<logic:iterate id="waterptestlist" name="waterptests">
<tr align="left" >

<td  class=mycborder1 align="left">
<FONT class=myfontclr1><%= i++%></FONT>
</td>

<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="waterptestlist" property="testName" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="waterptestlist" property="testPCode" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="waterptestlist" property="testPName" /></FONT>
</td>
<td  class=mycborder1  >
<FONT class=myfontclr1><bean:write name="waterptestlist" property="minPerVal" /></FONT>
</td>
<td  class=mycborder1  >
<FONT class=myfontclr1><bean:write name="waterptestlist" property="maxPerVal" /></FONT>
</td>
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
