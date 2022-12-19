<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
</head>

<body topmargin="0">
<table border="1" align=center bordercolor=black style="border-collapse:collapse" width="90%">
<tr><td colspan=5 class="head"><b>Asset Sub Component Parameter Type Details</b></td></tr>
<tr class="bwborder">
	 
	<td  align=center><b><bean:message key="app.assetType" /></b></td>
	<td   align=center><b>Asset Component Type</b></td>
	<td   align=center><b>Asset SubComponent Type</b></td>
	<td   align=center><b>Measurement Type</b></td>
	<td   align=center><b>Unit of Measurement</b></td>
	
</tr>
 

<logic:iterate id="assetSubCompParamList" name="assetSubCompParams">
<tr align="left" >
 
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
