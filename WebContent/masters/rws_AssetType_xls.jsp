<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
</head>

<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
<tr><td colspan=3 class="textborder">Asset Type Details</td></tr>
<tr>
	<td align=center class="textborder">SNo</td>
	<td class=textborder align=center><bean:message key="app.assetTypeCode" /></td>
	<td class=textborder align=center><bean:message key="app.assetTypeName" /></td>	
</tr>
<% int i=1;%>
<logic:iterate id="assettypelist" name="assetTypes">
<tr align="left" >
	<td align="center" class=bwborder><%= i++%></td>
	<td class=bwborder align=center><bean:write name="assettypelist" property="assetTypeCode" /></td>
	<td class=bwborder><bean:write name="assettypelist" property="assetTypeName" /></td>
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
