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

<tr><td class=myfontclr colspan=4><B> Water Quality Test Form </B></td></tr>
<tr >
	<td class=mycborder align=center>
	<FONT class=myfontclr>Sl. No.</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.labCode" /></FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.labName" /></FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.location" /></FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr>Lab Head</FONT>
	</td>
	</tr>
<% int i=1;%>
<logic:iterate id="labs" name="wqlabs">
<tr align="left" >

<td  class=mycborder1 align="center">
<FONT class=myfontclr1><%= i++%></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="labs" property="labCode" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="labs" property="labName" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="labs" property="location" /></FONT>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="labs" property="desgnCode" /></FONT>
</td>
</tr>
</logic:iterate>
</table>

<br><br> 

<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
