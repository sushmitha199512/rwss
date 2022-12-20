<%@ include file="/commons/rws_header1.jsp" %>
</head>
<body bgcolor="#edf2f8" leftmargin="0" topmargin="0">
<c:set var="item" value="${requestScope.proposalDTO}" />
<table cellpadding="2" cellspacing="0">
<tr bgcolor="#8A9FCD">
	<td colspan="6"><font size="2" color="#FFFFFF" face="verdana"><b>Work Details</b></font></td>
</tr>

<tbody>
<tr class="row0">
	<td class="staticLabel" nowrap>Work Id</td>
	<td>:</td>
	<td class="myfontclr" nowrap><c:out value="${item.workId}" /></td>
	<td class="staticLabel" nowrap>Work Name</td>
	<td>:</td>
	<td class="myfontclr" nowrap><c:out value="${item.proposalName}" /></td>
</tr>
<tr class="row1">
	<td class="staticLabel" nowrap>No. of Habs</td>
	<td>:</td>
	<td class="myfontclr" nowrap><c:out value="${item.noOfHabs}" /></td>
	<td class="staticLabel" nowrap>Asset Type</td>
	<td>:</td>
	<td class="myfontclr" nowrap><c:out value="${item.assetName}" /></td>
</tr>
<tr class="row0">
	<td class="staticLabel" nowrap>Programme</td>
	<td>:</td>
	<td class="myfontclr" nowrap><c:out value="${item.programmeName}" /></td>
	<td class="staticLabel" nowrap>Sub Programme</td>
	<td>:</td>
	<td class="myfontclr" nowrap><c:out value="${item.subprogrammeName}" /></td>
</tr>
<tr class="row1">
	<td class="staticLabel" nowrap>Sanctioned At</td>
	<td>:</td>
	<td class="myfontclr" nowrap><c:out value="${item.sanctionedAt}" /></td>
	<td class="staticLabel" nowrap>Sanctioning Authority</td>
	<td>:</td>
	<td class="myfontclr"><c:out value="${item.sanctioningAuthority}" /></td>
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
	<td class="staticLabel" nowrap>Estimate Cost</td>
	<td>:</td>
	<td class="myfontclr" nowrap><c:out value="${item.estimateCost}" /></td>
</tr>
<tr class="row0">
	<td class="staticLabel" nowrap>Sanctioned Amount</td>
	<td>:</td>
	<td class="myfontclr" nowrap><c:out value="${item.sanctionedAmount}" /></td>
	<td class="staticLabel" nowrap>Phased</td>
	<td>:</td>
	<td class="myfontclr" nowrap><c:out value="${item.phased}" /></td>
</tr>
<tr class="row1">
	<td class="staticLabel" nowrap>Phase No.</td>
	<td>:</td>
	<td class="myfontclr" nowrap><c:out value="${item.phaseNo}" /></td>
	<td class="staticLabel" nowrap>Remarks</td>
	<td>:</td>
	<td class="myfontclr"><c:out value="${item.remarks}" /></td>
</tr>
<tr class="row0">
	<td colspan="6" align="center">
		<input type="button" value="Close" class="btext" 
			   onclick="javascript: fnClose()">
	</td>
</tr>
</tbody>
</table>
</body>
</html>