<%@ include file="/commons/rws_header1.jsp" %>
 

<body topmargin="0">
<p align="center"><b><font face="Verdana" size="3">WaterSoft<br>
Panchayat Raj Engineering Department<br>
Rural Water Supply<br>
Govt.of Andhra Pradesh</p>
<br>

<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
<caption align=right>
<script language="JavaScript">
<!--
document.write("Report on : "+mydate()+"<br><br>");
//-->
</script>
</caption>
<tr><td colspan=11 class="head"> <b>Source Details</b></td></tr>
<tr class="bwborder">
<td align=left><b>SNo</b></td>
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

<td align="left"><FONT class=myfontclr1>
<%= i++%></FONT>
</td>

 
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
<tr>
</logic:iterate>
</table>
<br><br> 

<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
