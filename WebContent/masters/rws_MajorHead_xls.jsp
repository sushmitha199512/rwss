<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
</head>

<body topmargin="0">
<center>

<br>
<table width="400px" align=center>
<tr><td>
<table border="1" bordercolor=black style="border-collapse:collapse" width="400px" cellspacing=2 cellpadding=3>
<tr><td colspan=3  class="head"> <b>Major Head Details</b></td></tr>
<tr>
	<td align=left><b>SNo</b></td>
	<td align=center><b>Major Head Code</b></td>
	<td align=center><b>Major Head Name</b></td>
</tr>
<% int i=1;%>
<logic:iterate id="majorheadlist" name="majorHeads">
<tr align="left" >

<td  class=mycborder1 align="left">
<FONT class=myfontclr1><%= i++%></FONT>
</td>

<td  class=mycborder1 align="center">
<FONT class=myfontclr1><bean:write name="majorheadlist" property="majorHeadCode" /></FONT>
</td>
<td  class=mycborder1>
<FONT class=myfontclr1><bean:write name="majorheadlist" property="majorHeadName" /></FONT>
</td>
</tr>
</logic:iterate>
</table>
</td></tr></table>
<br><br> <p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</center>
</body>
</html>
