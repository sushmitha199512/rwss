<%@ include file="/commons/rws_header1.jsp" %>
</head>

<body bgcolor="#edf2f8" leftmargin="0" topmargin="0">
<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#FFFFFF" 
	   style="border-collapse:collapse;display:block">
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
	<th><bean:message key="app.habitationCode" /></th>
	<th><bean:message key="app.habitationName" /></th>
	<th><bean:message key="app.population" /></th>
	<th><bean:message key="app.status" /></th>
</tr>
</thead>
<tbody class="gridText">
	<c:forEach items="${requestScope.functionalHabs}" var="item" varStatus="status">
	<c:set var="index" value="${status.index}"/>
	<tr class="<c:out value='row${index%2}'/>">
		<td align="center"><c:out value='${item.habCode}'/></td>
		<td><c:out value='${item.habName}'/></td>
		<td align="right"><c:out value='${item.population}'/></td>
		<td><c:out value='${item.status}'/></td>
	</tr>
	</c:forEach>
</tbody>
<tfoot class="gridLabel"> 
<tr bgcolor="#8A9FCD">
	<th colspan="4" align="left">
		Total No. of Selected Habitations:&nbsp;<c:out value="${index+1}" />
	</th>
</tr>
</tfoot>
</table><br>
<center>
	<html:button property="mode" styleClass="btext" onclick="javascript:fnClose()">
		<bean:message key="button.close" />
	</html:button>
</center>
</body>
</html>
