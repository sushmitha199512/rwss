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
 
<tr><td class=myfontclr colspan=8><B> Water Quality Test Form </B></td></tr>
<tr >
	<td class=mycborder align=center>
	<FONT class=myfontclr>Sl. No.</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr>Type of Asset</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr><bean:message key="app.workId" /></FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr>Work Component</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr>Work Sub Component </FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr>Quantity </FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr>Unit Rate</FONT>
	</td>
	<td class=mycborder align=center>
	<FONT class=myfontclr>Amount</FONT>
	</td>
	</tr>

 <% int i=1;%>

<logic:iterate id="tenderScheduleAlist" name="tenderScheduleA">

<tr align="left" >

<td  class=mycborder1 align="center">
<FONT class=myfontclr1><%= i++%></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="tenderScheduleAlist" property="assetTypeCode" /></FONT>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="tenderScheduleAlist" property="workId" /></FONT>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="tenderScheduleAlist" property="assetComponentCode" /></FONT>
</td>

<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="tenderScheduleAlist" property="assetSubCompTypeName" /></FONT>
</td>

<td  class=mycborder1 align=right>
<FONT class=myfontclr1><bean:write name="tenderScheduleAlist" property="quantity" /></FONT>
</td>
<td  class=mycborder1 align=right>
<FONT class=myfontclr1><bean:write name="tenderScheduleAlist" property="unitRate" /></FONT>
</td>
<td  class=mycborder1 align=right>
<FONT class=myfontclr1><bean:write name="tenderScheduleAlist" property="amount" /></FONT>
</td>
</tr>
</logic:iterate>
</table>
<br><br> 

<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
