<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
</head>

<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
<tr><td colspan=3 class="head"> <b>Work Specialzation Details</b></td></tr>
<tr class="bwborder">
	<td align=center  >SNo</td>
	<td   align=center><b> <bean:message key="app.workSpecCode" /></b></FONT>
	</td>
	<td   align=center><b>
	 <bean:message key="app.workSpecName" /></b></FONT>
	</td>	
</tr>
<% int i=1;%>
<logic:iterate id="workSpeclist" name="workSpecs">
<tr align="left" >

<td><%= i++%></td>
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
