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
<tr><td colspan=5 class="head"><b>Asset Sub Component Parameter Type Details</b></td></tr>
<tr class="bwborder">
	<td align=left><b>SNo.</b></td>
	<td  align=center><b><bean:message key="app.assetType" /></b></td>
	<td   align=center><b>Asset Component Type</b></td>
	<td   align=center><b>Asset SubComponent Type</b></td>
	<td   align=center><b>Measurement Type</b></td>
	<td   align=center><b>Unit of Measurement</b></td>
	
</tr>
<% int i=1;%>
<logic:iterate id="assetSubCompParamList" name="assetSubCompParams">
<tr align="left" >

	<td class=bwborder><%= i++%></td>

<td  class=bwborder nowrap>
<bean:write name="assetSubCompParamList" property="assetTypeName" />
</td>
<td  class=bwborder >
<bean:write name="assetSubCompParamList" property="assetCompTypeName" />
</td>
<td  class=bwborder nowrap>
<bean:write name="assetSubCompParamList" property="assetSubCompTypeName" />
</td>
<td  class=bwborder nowrap>
<bean:write name="assetSubCompParamList" property="dimension" />
</td>
<td  class=bwborder nowrap>
<bean:write name="assetSubCompParamList" property="uom" />
</td>
</tr>
</logic:iterate>
</table>
<p align=center><%@ include file="/commons/rws_footer.jsp"%></p>
</body>
</html>
