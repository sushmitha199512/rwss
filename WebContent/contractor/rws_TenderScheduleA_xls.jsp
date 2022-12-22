<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
</head>

<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
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
 
</body>
</html>
