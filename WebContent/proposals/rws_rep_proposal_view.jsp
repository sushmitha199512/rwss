<%@ include file="/commons/rws_header1.jsp"%>
<script language="JavaScript">
<!--
function fnShowHabs(proposalId)
{
	var proposalId = proposalId.name;
	var url = "switch.do?prefix=/proposals&page=/ShowSelectedHabs.do?proposalId="+proposalId;
	var properties = "width=548,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url, "", properties);
	newWindow.moveTo(10,10);
}
function fnShowOtherDetails(proposalId)
{
	var proposalId = proposalId.name;
	var url = "switch.do?prefix=/proposals&page=/ShowOtherDetails.do?proposalId="+proposalId
	var properties = "width=420,height=360,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url,"",properties);
}

//-->
</script>
<%@ include file="/commons/rws_header2.jsp"%>

<table width="100%" align="center" border="0" bordercolor="#8A9FCD" style="border-collapse:collapse">
<thead>
<tr>
	<td align="right">
		<a href="<rws:context page='/home.jsp'/>">Home</a>&nbsp;|&nbsp;
		<a href="switch.do?prefix=/proposals&page=/RepresentativeProposalData.do">Back</a> 
	</td>
</tr>	
</thead>
<tbody>
<tr>
	<td class="reportTitle">Representative Proposals List</td>
</tr>
</tbody>
</table>
<table width="100%" align="center" border="1" bordercolor="#8A9FCD" style="border-collapse:collapse">
<thead class="reportHead">
<tr>
	<th><bean:message key="app.sno"/></th>
	<th><bean:message key="app.workname" /></th>
	<th><bean:message key="app.proposalid" /></th>
	<th><bean:message key="app.proposaldate" /></th>
	<th><bean:message key="app.selectedhabs" /></th>
	<th><bean:message key="app.scheme" /></th>
	<th><bean:message key="app.programme" /></th>
	<th><bean:message key="app.subprogramme" /></th>
	<th><bean:message key="app.estimatecost" /></th>
	<th><bean:message key="app.otherdetails" /></th>
	<th><bean:message key="app.action"/></th>
</tr>
</thead>
<tbody class="reportBody">
<c:forEach items="${representativeProposals}" var="item" varStatus="status">
<c:set var="index" value="${status.index}" />
<tr>
	<td><c:out value="${index+1}"/></td>
	<td width="135"><c:out value="${item.proposalName}" /></td>
	<td align="center"><c:out value="${item.proposalId}" /></td>
	<td align="center" nowrap><c:out value="${item.proposalDate}" /></td>
	<td align="center" nowrap>
		<c:out value="${item.noOfHabs}" />&nbsp;<input type="button" value="..." title="Show Selected Habs" class="btext" 
			name="<c:out value='${item.proposalId}' />" onclick="javascript:fnShowHabs(this)">
	</td>
	<td><c:out value="${item.assetName}" /></td>
	<td><c:out value="${item.programmeName}" /></td>
	<td><c:out value="${item.subprogrammeName}" /></td>
	<td align="right" nowrap>
		<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" minIntegerDigits="1"
					  	  value="${item.estimateCost}" />
	</td>
	<td align="center"><input type="button" class="btext" value="..." title="Show Other Details"
		name="<c:out value='${item.proposalId}' />" onclick="javascript:fnShowOtherDetails(this)">
	</td>
	<td align="center" nowrap>
		<a href="switch.do?prefix=/proposals&page=/EditRepProposal.do&mode=Edit&proposalId=<c:out value='${item.proposalId}' />" id="edit">Edit</a>&nbsp;|&nbsp;<a href="switch.do?prefix=/proposals&page=/EditRepProposal.do&mode=Delete&proposalId=<c:out value='${item.proposalId}' />" onclick="return fnConfirmDelete()" id="delete">Delete</a>
	</td>
</tr>
</c:forEach>
</tbody>
</table>
<br>
<%@ include file="/commons/rws_footer.jsp"%>
<rws:alert />