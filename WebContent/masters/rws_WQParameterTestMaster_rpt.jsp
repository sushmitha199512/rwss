<%@ include file="/commons/rws_header1.jsp" %>
</head>

<body topmargin="0">
<p align="center"><b><font face="Verdana" size="3">WaterSoft<br>
Panchayat Raj Engineering Department<br>
Rural Water Supply<br>
Govt.of Andhra Pradesh</p>
<br>

<table border="1" bordercolor=black align=center style="border-collapse:collapse" width="80%">
<caption align=right>
   <script language="JavaScript">
   <!--
   document.write("Report on&nbsp;:&nbsp;"+mydate()+"<br><br>")
   //-->
   </script>
   </caption>

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
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="waterptestlist" property="minPerVal" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="waterptestlist" property="maxPerVal" /></FONT>
</td>
</tr>
</logic:iterate>
</table>

<br><br> 

<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
