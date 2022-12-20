<%@ include file="/commons/rws_header1.jsp"%>
<script>
function fnShowHabs(proposalId)
{
	var proposalId = proposalId.name;
	var url = "switch.do?prefix=/proposals&page=/ShowSelectedHabs.do?proposalId="+proposalId;
	var properties = "width=548,height=232,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url,"",properties);
	newWindow.moveTo(10,10);
}
function fnShowOtherDetails(proposalId)
{
	var proposalId = proposalId.name;
	var url = "switch.do?prefix=/proposals&page=/ShowOtherDetails.do?proposalId="+proposalId
	var properties = "width=420,height=330,toolbar=no,status=no,menubar=no,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var newWindow = window.open(url,"",properties);
}

function fnPrint(that)
{
	var proposalId = that.value;
			
	var url="./reports/rws_new_proposal_list_rpt.jsp?proposalId="+proposalId;
	var properties = "width=800,height=600,toolbar=no,status=no,menubar=yes,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var printWindow = window.open(url,"",properties); 
	
	

}
</script>
<%@ include file="/commons/rws_header2.jsp"%>

<c:set var="representativeProposals" value="${requestScope.proposalList[0]}" />
<c:set var="sentProposals" value="${requestScope.proposalList[1]}" />
<c:set var="receivedProposals" value="${requestScope.proposalList[2]}" />

<table align="center" cellpadding="0" cellspacing="0">
<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b>&nbsp;&nbsp;</caption>
<thead summary="Page header with round corner images">
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="New Proposals List" />
		<jsp:param name="TWidth" value="100%" />
	</jsp:include>
</td>
</tr>
</thead>

<tfoot summary="Page footer with round corner images">
<tr>
<td>
	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="100%"/>
	</jsp:include>
</td>
</tr>
</tfoot>

<tbody bgcolor="#DEE3E0">
<tr>
<td>
	<fieldset>
	<legend>Representative Proposals</legend>
	<label>
	<c:if test="${not empty representativeProposals}">	
	<table cellpadding="1" cellspacing="0" border="1" width="100%" bordercolor="#000000" style="border-collapse: collapse">
	<thead class="gridHeader">
	<tr>
		<th><bean:message key="app.workname" /></th>
		<th><bean:message key="app.proposalId" /></th>
		<th><bean:message key="app.proposalDate" /></th>
		<th><bean:message key="app.selectedhabs" /></th>
		<th><bean:message key="app.scheme" /></th>
		<th><bean:message key="app.programme" /></th>
		<th><bean:message key="app.subprogramme" /></th>
		<th><bean:message key="app.estimateCost" />(Rs.)</th>
		<th><bean:message key="app.status" /></th>
		<th><bean:message key="app.otherdetails" /></th>
	</tr>
	</thead>
	<tbody class="label">
	<c:forEach items="${representativeProposals}" var="item" varStatus="status">
	<c:set var="index" value="${status.index}" />
	<tr class="<c:out value='row${index%2}'/>">
		<td width="145">
			<c:out value="${item.proposalName}"/>
		</td>
		<td align="center" width="85"><c:out value="${item.proposalId}"/></td>
		<td align="center" width="65"><c:out value="${item.proposalDate}"/></td>
		<td align="center" width="65"><c:out value="${item.noOfHabs}"/>
		<input type="button" value="..." title="Show Selected Habs" class="btext" 
				name='<c:out value="${item.proposalId}"/>' onclick="javascript:fnShowHabs(this)">
		</td>
		<td width="60">&nbsp;<c:out value="${item.assetName}"/></td>
		<td width="70">&nbsp;<c:out value="${item.programmeName}"/></td>
		<td width="70">&nbsp;<c:out value="${item.subprogrammeName}"/></td>
		<td width="60" align="right"><c:out value="${item.estimateCost}"/>&nbsp;</td>
		<td width="80"><c:out value="${item.flag}"/></td>
		<td width="40" align="center">
		<input type="button" class="btext" value="..." name="<c:out value='${item.proposalId}' />"
				   onclick="javascript:fnShowOtherDetails(this)">
		</td>
	</tr>	
	</c:forEach>
	</tbody>
	<tfoot>
		<tr bgcolor="#8A9FCD">
			<td colspan="12" align="right" class="label">
			<b>No. of Representative Proposals:&nbsp;<c:out value="${index+1}"/>&nbsp;</b>
			</td>
		</tr>
	</tfoot>
	</table>	
	</c:if>
	<c:if test="${empty representativeProposals}">
		<span class="label">There are no representative proposals</span>
	</c:if>

	</label>
	</fieldset>
</td>
</tr>


<tr>
<td>
	<fieldset>
	<legend>Sent Proposals</legend>
	<label>
	<c:if test="${not empty sentProposals}">
		<table cellpadding="0" cellspacing="0" border="1" bordercolor="#000000" style="border-collapse: collapse">
	<thead class="gridHeader">
	<tr>
		<th>Print</th>
		<th>To</th>
		<th><bean:message key="app.workname" /></th>
		<th><bean:message key="app.proposalId" /></th>
		<th><bean:message key="app.proposalDate" /></th>
		<th><bean:message key="app.selectedhabs" /></th>
		<th><bean:message key="app.scheme" /></th>
		<th><bean:message key="app.programme" /></th>
		<th><bean:message key="app.subprogramme" /></th>
		<th><bean:message key="app.estimateCost" />(Rs.)</th>
		<th>Status</th>
		<th><bean:message key="app.otherdetails" /></th>
	</tr>
	</thead>
	<tbody class="label">
	<c:set var="flag" value="" />
	<c:forEach items="${sentProposals}" var="item" varStatus="status">
	<c:set var="index" value="${status.index}" />
	<c:if test="${item.flag != flag}">
	<c:set var="flag" value="${item.flag}" />
	<tr bgcolor="lightyellow">
		<td class="" colspan="12">
			<font size="-1" face="verdana">
				<c:if test="${item.flag == 'F'}">
					Forwarded Proposals
				</c:if>
				<c:if test="${item.flag == 'S'}">
					Submitted Proposals
				</c:if>
				<c:if test="${item.flag == 'D'}">
					Deferred Proposals
				</c:if>
				<c:if test="${item.flag == 'T'}">
					Transmitted  Proposals
				</c:if>
			</font>
		</td>
	</tr>
	</c:if>
	<tr class="<c:out value='row${index%2}'/>">
		<td align="center">
		<input type="radio" name="select" onclick="javascript:fnPrint(this)" value="<c:out value='${item.proposalId}' />"/>
		</td>
		<td><c:out value="${item.officeName}"/></td>
		<td width="145" style="display:block;cursor:hand" 
			onmouseover='<c:out value="dddrivetip(\"${item.message}\")" escapeXml="false"/>' 
			onmouseout="hideddrivetip()">
		<c:out value="${item.proposalName}"/></td>
		<td align="center"><c:out value="${item.proposalId}"/></td>
		<td align="center"><c:out value="${item.proposalDate}"/></td>
		<td align="center"><c:out value="${item.noOfHabs}"/>
			<input type="button" value="..." title="Show Selected Habs" class="btext" 
				name='<c:out value="${item.proposalId}"/>' onclick="javascript:fnShowHabs(this)">
		</td>
		<td><c:out value="${item.assetName}"/></td>
		<td><c:out value="${item.programmeName}"/></td>
		<td><c:out value="${item.subprogrammeName}"/></td>
		<td><c:out value="${item.estimateCost}"/></td>
		<td><c:out value="${item.status}"/></td>
		<td align="center">
		<input type="button" class="btext" value="..." name="<c:out value='${item.proposalId}' />"
				   onclick="javascript:fnShowOtherDetails(this)">
		</td>
	</tr>	
	</c:forEach>
	</tbody>
	<tfoot>
		<tr bgcolor="#8A9FCD">
			<td colspan="12" align="right" class="label">
			<b>No. of Sent Proposals:&nbsp;<c:out value="${index+1}"/>&nbsp;</b>
			</td>
		</tr>
	</tfoot>
	</table>
	</c:if>
	<c:if test="${empty sentProposals}">
		<span class="label">There are no sent proposals</span>
	</c:if>
	</label>
	</fieldset>
</td>
</tr>

<tr>
<td>
	<fieldset>
	<legend>Received Proposals</legend>
	<label>
	<table cellpadding="0" cellspacing="0" border="1" bordercolor="#000000" style="border-collapse: collapse">
	<c:if test="${not empty receivedProposals}">
	<thead class="gridHeader">
	<tr>
		<th>Print</th>
		<th>From</th>
		<th><bean:message key="app.workname" /></th>
		<th><bean:message key="app.proposalId" /></th>
		<th><bean:message key="app.proposalDate" /></th>
		<th><bean:message key="app.selectedhabs" /></th>
		<th><bean:message key="app.scheme" /></th>
		<th><bean:message key="app.programme" /></th>
		<th><bean:message key="app.subprogramme" /></th>
		<th><bean:message key="app.estimateCost" />(Rs.)</th>
		<th>Status</th>
		<th><bean:message key="app.otherdetails" /></th>
	</tr>
	</thead>
	<tbody class="label">
	<c:set var="flag" value="" />
	<c:forEach items="${receivedProposals}" var="item" varStatus="status">
	<c:set var="index" value="${status.index}" />
	<c:if test="${item.flag != flag}">
	<c:set var="flag" value="${item.flag}" />
	<tr bgcolor="lightyellow">
		<td class="" colspan="12">
			<font size="-1" face="verdana">
				<c:if test="${item.flag == 'F'}">
					Forwarded Proposals
				</c:if>
				<c:if test="${item.flag == 'S'}">
					Submitted Proposals
				</c:if>
				<c:if test="${item.flag == 'D'}">
					Deferred Proposals
				</c:if>
				<c:if test="${item.flag == 'T'}">
					Transmitted  Proposals
				</c:if>
			</font>
		</td>
	</tr>
	</c:if>
	<tr class="<c:out value='row${index%2}'/>">
		<td><input type="radio" name="select" onclick="javascript:fnPrint(this)" value="<c:out value='${item.proposalId}' />"/></td>
		<td><c:out value="${item.officeName}"/></td>
		<td width="145" style="display:block;cursor:hand" 
			onmouseover='<c:out value="dddrivetip(\"${item.message}\")" escapeXml="false"/>' 
			onmouseout="hideddrivetip()">
			<c:out value="${item.proposalName}"/>
		</td>
		<td align="center"><c:out value="${item.proposalId}"/></td>
		<td align="center"><c:out value="${item.proposalDate}"/></td>
		<td align="center"><c:out value="${item.noOfHabs}"/>
			<input type="button" value="..." title="Show Selected Habs" class="btext" 
				name='<c:out value="${item.proposalId}"/>' onclick="javascript:fnShowHabs(this)">
		</td>
		<td><c:out value="${item.assetName}"/></td>
		<td><c:out value="${item.programmeName}"/></td>
		<td><c:out value="${item.subprogrammeName}"/></td>
		<td><c:out value="${item.estimateCost}"/></td>
		<td><c:out value="${item.status}"/></td>
		<td align="center">
		<input type="button" class="btext" value="..." name="<c:out value='${item.proposalId}' />"
				   onclick="javascript:fnShowOtherDetails(this)">
		</td>
	</tr>	
	</c:forEach>
	</tbody>
		<tfoot>
		<tr bgcolor="#8A9FCD">
			<th colspan="12" align="right" class="label">
			<b>No. of Received Proposals:&nbsp;<c:out value="${index+1}"/>&nbsp;</b>
			</th>
		</tr>
	</tfoot>
	</c:if>
	<c:if test="${empty receivedProposals}">
		<tbody>
		<tr>
			<td class="label">There are no received proposals</td>
		</tr>
		</tbody>
	</c:if>
	</table>
	</label>
	</fieldset>
</td>
</tr>
</tbody>

</table>

<%@ include file="/commons/rws_tooltip.jsp"%>
<%@ include file="/commons/rws_footer.jsp"%>