<%@ page contentType="application/vnd.ms-excel"%>
<%@ include file="/commons/rws_header1.jsp"%>
</head>
<body>

<table width="100%" align="center">
<tbody bgcolor="#000000">
<tr>
	<td class="printTitle">O&M Estimates List</td>
</tr>
</tbody>
</table>
<table width="100%" align="center" border="1" bordercolor="#000000" style="border-collapse:collapse">
<thead class="printHead">
<tr>
	<td>S.No.</td>
	<td>Work Id</td>
	<td>Work Name</td>
	<td>Financial Year</td>
	<td>Source Name</td>
	<td>Estimate Amount<br>(Rs. in lakhs)</td>
	<td>Sanctioned Amount<br>(Rs. in lakhs)</td>	
	<td>Total Components</td>
	<td>Manpower Charges<br>(in Rs.)</td>
	<td>Power Charges<br>(in Rs.)</td>
	<td>Consumables<br>(in Rs.)</td>
	<td>Repairs & Repairs<br>(in Rs.)</td>
	<td>Other Charges<br>(in Rs.)</td>
	<td>Remarks</td>
</tr>
</thead>
<tbody class="printBody">
<c:forEach items="${requestScope.estimateList}" var="item" varStatus="status">
<c:set var="index" value="${status.index}" />
<tr>
	<td><c:out value="${index+1}"/></td>
	<td nowrap><c:out value="${item.workId}"/></td>
	<td><c:out value="${item.workName}"/></td>
	<td nowrap><c:out value="${item.financialYear}"/></td>
	<td><c:out value="${item.sourceCode}"/></td>
	<td align="right">
		<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" minIntegerDigits="1"
						  value="${item.estimateAmount}" />
	</td>
	<td align="right">
		<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" minIntegerDigits="1"
						  value="${item.sanctionedAmount}" />
		
	</td>
	<td align="center"><c:out value="${item.totalComponents}"/></td>
	<td align="right">
		<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" minIntegerDigits="1"
						  value="${item.manpowerCharges}" />
	</td>
	<td align="right">
		<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" minIntegerDigits="1"
						  value="${item.powerCharges}" />	
	</td>
	<td align="right">
		<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" minIntegerDigits="1"
						  value="${item.consumables}" />
	</td>
	<td align="right">
		<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" minIntegerDigits="1"
						  value="${item.repairs}" />		
	</td>
	<td align="right">
		<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" minIntegerDigits="1"
						  value="${item.others}" />	
	</td>
	<td><c:out value="${item.remarks}"/></td>
</tr>
</c:forEach>	
</tbody>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
