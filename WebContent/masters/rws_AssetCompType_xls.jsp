<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
</head>

<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
<tr><td colspan=4 class="textborder">Asset Component Type Details</td></tr>
<tr>
	<td align=left class="textborder">SNo</td>
	<td class="textborder" align=center><bean:message key="app.assetTypeCode" /></td>
	<td class="textborder" align=center><bean:message key="app.assetCompTypeCode" /></FONT></td>
	<td class="textborder" align=center><bean:message key="app.assetCompTypeName" /></FONT></td>
	
</tr>
<% int i=1;%>
<logic:iterate id="assetcomponenttypelist" name="assetCompTypes">
<tr align="left" >

	<td align="left" class=bwborder><%= i++%></td>

	<td  align="left" class=bwborder ><bean:write name="assetcomponenttypelist" property="assetTypeName" /></td>
	<td   align="center" class=bwborder><bean:write name="assetcomponenttypelist" property="assetCompTypeCode" /></td>
	<td  class=bwborder ><bean:write name="assetcomponenttypelist" property="assetCompTypeName" /></td>
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
