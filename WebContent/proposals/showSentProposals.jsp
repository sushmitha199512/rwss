<%@ include file="/commons/rws_header1.jsp"%>
</head>

<body bgcolor="#edf2f8" leftmargin="0" topmargin="0">
<table bgcolor="#DEE3E0" border="1" bordercolor="black" width="700" cellpadding="0" 
	   cellspacing="0" style="border-collapse:collapse;" >
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
	<th></th>
	<th><bean:message key="app.workname" /></th>
	<th><bean:message key="app.proposalid" /></th>
	<th><bean:message key="app.proposaldate" /></th>
	<th><bean:message key="app.selectedhabs" /></th>
	<th><bean:message key="app.scheme" /></th>
	<th><bean:message key="app.programme" /></th>
	<th><bean:message key="app.subprogramme" /></th>
	<th><bean:message key="app.estimatecost" /></th>
	<th><bean:message key="app.otherdetails" /></th>
</tr>
</thead>
<tbody class="gridLabel">
<c:forEach items="${sentProposals}" var="item" varStatus="status">
<tr class='<c:out value="row${status.index%2}" />'>
	<td></td>
	<td><c:out value="${item.proposalName}" /></td>	
	<td><c:out value="${item.proposalId}" /></td>
	<td><c:out value="${item.proposalDate}" /></td>
	<td><c:out value="${item.noOfHabs}" /></td>
	<td><c:out value="${item.assetName}" /></td>				
	<td><c:out value="${item.programmeName}" /></td>
	<td><c:out value="${item.subprogrammeName}" /></td>
	<td><c:out value="${item.estimateCost}" /></td>				
</tr>
</c:forEach>
</tbody>
</table>
</body>
</html>