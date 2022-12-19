<%@ include file="/commons/rws_header1.jsp" %>
</head>

<body topmargin="0">
<p align="center"><b><font face="Verdana" size="3">WaterSoft<br>
Panchayat Raj Engineering Department<br>
Rural Water Supply<br>
Govt.of Andhra Pradesh</p>
<br>

<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="60%">
<caption align=right>
<script language="JavaScript">
<!--
document.write("Reprot on : "+mydate()+"<br><br>");
//-->
</script>
</caption>
<tr><td colspan=6 class="head"><b>Major Head Details</b></td></tr>
<tr>
	<td align=left class="bwborder"><b>SNo</b></td>
	<td align=center class="bwborder"><b>Major Head Code</b></td>
	<td align=center class="bwborder"><b>Major Head Name</b></td>
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

<br><br> 

<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
