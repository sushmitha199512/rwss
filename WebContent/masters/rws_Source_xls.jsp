<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
</head>

<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="70%">
<tr><td colspan=8 class="head"> <b>Source Details</b></td></tr>
<tr class="bwborder">
 
	<td  class=mycborder align=center>
		<FONT class=myfontclr><b> Source Code</b></td>
		 
		<td  class=mycborder align=center>
		<FONT class=myfontclr><b>Habitation</b></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><b> <bean:message key="app.location" /></b></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><b> <bean:message key="app.noOfHab" /></b></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><b> <bean:message key="app.popbenefited" /></b></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><b><bean:message key="app.seasonal" /></b></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><b> <bean:message key="app.presentCondition" /></b></td>
		<td  class=mycborder align=center>
		<FONT class=myfontclr><b> Water Quality</b></td>
		</tr>
<% int i=1;%>
<logic:iterate id="sourcelist" name="sources">
<tr align="left" >

 

 
<td  class=mycborder1  nowrap>
<FONT class=myfontclr1><bean:write name="sourcelist" property="sourceName" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="sourcelist" property="sourceTypeName" /></FONT><BR>
<FONT class=myfontclr1><bean:write name="sourcelist" property="subSourceTypeName" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="sourcelist" property="habName" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="sourcelist" property="location" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="sourcelist" property="noOfHab" /></FONT>
</td>
<td  class=mycborder1 align=left>
<FONT class=myfontclr1><bean:write name="sourcelist" property="popbenefited" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="sourcelist" property="seasonal" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="sourcelist" property="presentCondition" /></FONT>
</td>
<td  class=mycborder1 align=center>
<FONT class=myfontclr1><bean:write name="sourcelist" property="waterQuality" /></FONT>
</td>
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
