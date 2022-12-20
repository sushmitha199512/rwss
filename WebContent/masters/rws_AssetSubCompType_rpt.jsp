<%@ include file="/commons/rws_header1.jsp" %>
</head>

<body topmargin="0">
<p align="center"><b><font face="Verdana" size="3">WaterSoft<br>
Panchayat Raj Engineering Department<br>
Rural Water Supply<br>
Govt.of Andhra Pradesh</p>
<br>

<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="750">
<caption align=right>
<table align=right>
	<tr>
		<td	class="bwborder" align="right">Report Date :<%=fmt.format(new java.util.Date()) %></td>
	</tr>
</table>
</caption>
<tr><td colspan=5 class="textborder">Asset Sub Component Type Details</td></tr>
<tr>
	<td class="textborder" align="left">SNo</td>
	<td class="textborder" align=center><bean:message key="app.assetType" /></td>
	<td class="textborder" align=center>Asset Component Type</td>
	<td class="textborder" align=center>Asset Sub Component Type Code</td>
	<td class="textborder" align=center>Asset Sub Component Type Name</td>
	
</tr>
<% int i=1;%>
<logic:iterate id="assetSubCompType" name="assetSubCompTypes">
<tr align="left" >

	<td class=bwborder><%= i++%></td>

	<td class=bwborder nowrap><bean:write name="assetSubCompType" property="assetTypeName" />
	<html:hidden name="assetSubCompType" property="assetTypeCode"/></td>
	<td class=bwborder><bean:write name="assetSubCompType" property="assetCompTypeName" />
	<html:hidden name="assetSubCompType" property="assetCompTypeCode"/></td>
	<td class=bwborder align=center nowrap><bean:write name="assetSubCompType" property="assetSubCompTypeCode" /></td>
	<td class=bwborder nowrap><bean:write name="assetSubCompType" property="assetSubCompTypeName" /></td>
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
