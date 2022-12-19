<%@ include file="/commons/rws_header1.jsp" %>

</head>

<body bgcolor="#edf2f8" topmargin="0" leftmargin="0">
<table width="100%" cellpadding="1" cellspacing="0" border="1" bordercolor="#ffffff" style="border-collapse:collapse">
<thead class="gridHeader">
<tr>
	<th>Work Component</th>
	<th>Amount (Rs. in lakhs)</th>
</tr>
</thead>
<tbody class="staticLabel">
<c:forEach items="${requestScope.workComponents}" var="item" varStatus="status">
<c:set var="index" value="${status.index}" />
<tr class="<c:out value='row${index%2}'/>">
	<td>
		<c:out value="${item.assetComponentCode}" />
	</td>
	<td align="right">
		<fmt:formatNumber minIntegerDigits="1" maxFractionDigits="2" minFractionDigits="2" 
						  value="${item.amount}"/>
	</td>
</tr>
</c:forEach>
<tr>
	<td colspan="10" align="center">
		<input type="button" value="Close" class="btext" 
			   onclick="javascript: fnClose()">
	</td>
</tr>
</tbody>
</table>
</body>
</html>