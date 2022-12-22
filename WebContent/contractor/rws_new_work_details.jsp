<%@ include file="/commons/rws_header1.jsp" %>
<script language="JavaScript">
<!--
function fnClose()
{
	window.close();
}
//-->
</script>
</head>
<body bgcolor="" topmargin="0" leftmargin="0">
<c:set var="item" value="${requestScope.proposalDTO}" />
<table cellpadding="2" cellspacing="0">
<tr bgcolor="#8A9FCD">
	<td colspan="6"><font size="2" color="#FFFFFF" face="verdana"><b>Work Details</b></font></td>
</tr>

<tbody>
<tr class="row0">
	<td class="textborder" nowrap>Work Id</td>
	<td class="textborder">:&nbsp;</td>
	<td class="bwborder" nowrap><c:out value="${item.workId}" /></td>
	<td class="textborder" nowrap>&nbsp;Work Name</td>
	<td class="textborder">:&nbsp;</td>
	<td class="bwborder" nowrap><c:out value="${item.proposalName}" /></td>
</tr>
<tr class="row1">
	<td class="textborder" nowrap>No. of Habs</td>
	<td class="textborder">:&nbsp;</td>
	<td class="bwborder" nowrap><c:out value="${item.noOfHabs}" /></td>
	<td class="textborder" nowrap>&nbsp;Asset Type</td>
	<td class="textborder">:&nbsp;</td>
	<td class="bwborder" nowrap><c:out value="${item.assetName}" /></td>
</tr>
<tr class="row0">
	<td class="textborder" nowrap>Programme</td>
	<td class="textborder">:&nbsp;</td>
	<td class="bwborder" nowrap><c:out value="${item.programmeName}" /></td>
	<td class="textborder" nowrap>&nbsp;Sub Programme</td>
	<td class="textborder">:&nbsp;</td>
	<td class="bwborder" nowrap><c:out value="${item.subprogrammeName}" /></td>
</tr>
<tr class="row1">
	<td class="textborder" nowrap>Sanctioned At</td>
	<td class="textborder">:&nbsp;</td>
	<td class="bwborder" nowrap><c:out value="${item.sanctionedAt}" /></td>
	<td class="textborder" nowrap>&nbsp;Sanctioning Authority</td>
	<td class="textborder">:&nbsp;</td>
	<td class="bwborder" nowrap><c:out value="${item.sanctioningAuthority}" /></td>
</tr>
<tr class="row0">
	<td class="textborder" nowrap>Admin No.</td>
	<td class="textborder">:&nbsp;</td>
	<td class="bwborder" nowrap><c:out value="${item.adminNo}" /></td>
	<td class="textborder" nowrap>&nbsp;Admin Date</td>
	<td class="textborder">:&nbsp;</td>
	<td class="bwborder" nowrap><c:out value="${item.adminDate}" /></td>
</tr>
<tr class="row1">
	<td class="textborder" nowrap>Go No.</td>
	<td class="textborder">:&nbsp;</td>
	<td class="bwborder" nowrap><c:out value="${item.goNo}" /></td>
	<td class="textborder" nowrap>&nbsp;Estimate Cost</td>
	<td class="textborder">:&nbsp;</td>
	<td class="bwborder" nowrap><c:out value="${item.estimateCost}" /></td>
</tr>
<tr class="row0">
	<td class="textborder" nowrap>Sanctioned Amount</td>
	<td class="textborder">:&nbsp;</td>
	<td class="bwborder" nowrap><c:out value="${item.sanctionedAmount}" /></td>
	<td class="textborder" nowrap>&nbsp;Phased</td>
	<td class="textborder">:&nbsp;</td>
	<td class="bwborder" nowrap><c:out value="${item.phased}" /></td>
</tr>
<tr class="row1">
	<td class="textborder" nowrap>Phase No.</td>
	<td class="textborder">:&nbsp;</td>
	<td class="bwborder" nowrap><c:out value="${item.phaseNo}" /></td>
	<td class="textborder" nowrap>&nbsp;Remarks</td>
	<td class="textborder">:&nbsp;</td>
	<td class="bwborder"><c:out value="${item.remarks}" /></td>
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