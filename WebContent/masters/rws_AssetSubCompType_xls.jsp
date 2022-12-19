<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
</head>

<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
<tr><td colspan=5> <b>Asset Sub Component Type Details</b></td></tr>
<tr>
	<td align=left><b>SNo</b></td>
	<td class="mycborder" align=center>
	<FONT class=myfontclr><bean:message key="app.assetType" /></td>
	<td class="mycborder" align=center>
	<FONT class=myfontclr>Asset Component Type</td>
	<td class="mycborder" align=center>
	<FONT class=myfontclr>Asset Sub Component Type Code</td>
	<td class="mycborder" align=center>
	<FONT class=myfontclr>Asset Sub Component Type Name</td>
	
</tr>
<% int i=1;%>
<logic:iterate id="assetSubCompType" name="assetSubCompTypes">
<tr align="left" >

<td><%= i++%></td>
<td class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="assetSubCompType" property="assetTypeName" /></FONT>
<html:hidden name="assetSubCompType" property="assetTypeCode"/>
</td>
<td  class=mycborder1 >
<FONT class=myfontclr1><bean:write name="assetSubCompType" property="assetCompTypeName" /></FONT>
<html:hidden name="assetSubCompType" property="assetCompTypeCode"/>
</td>
<td  class=mycborder1 align=center nowrap>
<FONT class=myfontclr1><bean:write name="assetSubCompType" property="assetSubCompTypeCode" /></FONT>
</td>
<td  class=mycborder1 nowrap>
<FONT class=myfontclr1><bean:write name="assetSubCompType" property="assetSubCompTypeName" /></FONT>
</td>
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
