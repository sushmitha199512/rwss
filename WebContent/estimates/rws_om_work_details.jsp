<%@ include file="/commons/rws_header1.jsp" %>
</head>
<body bgcolor="#edf2f8" leftmargin="0" topmargin="0">
<c:set var="item" value="${requestScope.proposalDTO}" />
<table cellpadding="2" cellspacing="0" width="100%" border="1" bordercolor="#ffffff" style="border-collapse:collapse">
<tr bgcolor="#8A9FCD">
	<td colspan="6"><font size="2" color="#000000" face="verdana"><b>Work Details</b></font></td>
</tr>

<tbody>
<tr class="row0">
	<td class="staticLabel" nowrap>Work Id</td>
	<td>:</td>
	<td class="myfontclr" nowrap><c:out value="${item.workId}" /></td>
	<td class="staticLabel" nowrap>Proposal Id</td>
	<td>:</td>
	<td class="myfontclr" nowrap><c:out value="${item.proposalId}" /></td>
</tr>
<tr class="row1">
	<td class="staticLabel" nowrap>Asset Name</td>
	<td>:</td>
	<td class="myfontclr" nowrap><c:out value="${item.assetName}" /></td>
	<td class="staticLabel" nowrap>Asset Type</td>
	<td>:</td>
	<td class="myfontclr" nowrap><c:out value="CPWS" /></td>
</tr>
<tr class="row0">
	<td class="staticLabel" nowrap>Programme / Sub Programme</td>
	<td>:</td>
	<td colspan="4" class="staticLabelBold">
		<c:forEach items="${item.programmes}" var="programme">
			<c:out value="${programme.programmeName}" /> / <c:out value="${programme.subprogrammeName}" /><br>
		</c:forEach>
	</td>
</tr>
<tr class="row1">
	<td class="staticLabel" nowrap>Estimate Cost</td>
	<td>:</td>
	<td class="myfontclr" nowrap><c:out value="${item.estimateCost}" /></td>
	<td class="staticLabel" nowrap>Sanctioned Amount</td>
	<td>:</td>
	<td class="myfontclr" nowrap><c:out value="${item.sanctionedAmount}" /></td>
</tr>
<tr class="row0">
	<td class="staticLabel" nowrap>Admin No.</td>
	<td>:</td>
	<td class="myfontclr" nowrap><c:out value="${item.adminNo}" /></td>
	<td class="staticLabel" nowrap>Admin Date</td>
	<td>:</td>
	<td class="myfontclr" nowrap><c:out value="${item.adminDate}" /></td>
</tr>
<tr class="row1">
	<td class="staticLabel" nowrap>Go No.</td>
	<td>:</td>
	<td class="myfontclr" nowrap><c:out value="${item.goNo}" /></td>
	<td class="staticLabel" nowrap>Sanctioned At</td>
	<td>:</td>
	<td class="myfontclr" nowrap><c:out value="${item.sanctionedAt}" /></td>
</tr>
<tr class="row0">
	<td class="staticLabel" nowrap>Sanctioning Authority</td>
	<td>:</td>
	<td class="myfontclr" nowrap><c:out value="${item.sanctioningAuthority}" /></td>	
	<td class="staticLabel" nowrap>Remarks</td>
	<td>:</td>
	<td class="myfontclr" nowrap><c:out value="${item.remarks}" /></td>
</tr>
<tr>
	<td colspan="6" class="staticLabel">
		<table width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#000000" 
				style="border-collapse:collapse">
		<caption align="left" class="staticLabelBold">Habitation Details</caption>
		<thead class="gridLabel">
		<tr bgcolor="#8A9FCD">
			<th><bean:message key="app.habitationCode" /></th>
			<th><bean:message key="app.habitationName" /></th>
			<th><bean:message key="app.population" /></th>
			<th><bean:message key="app.status" /></th>
		</tr>
		</thead>
		<tbody class="gridText">
		<c:forEach items="${items.habs}" var="hab">
		<tr>
			<td align="center"><c:out value="${hab.habCode}"/></td>
			<td><c:out value="${hab.habName}"/></td>
			<td align="right"><c:out value="${hab.population}"/></td>
			<td><c:out value="${hab.status}"/></td>
		</tr>
		</c:forEach>
		</tbody>
		
		</table>
	</td> 
</tr>
<tr class="row1">
	<td colspan="6" align="center">
		<input type="button" value="Close" class="btext" 
			   onclick="javascript: fnClose()">
	</td>
</tr>
</tbody>
</table>
</body>
</html>