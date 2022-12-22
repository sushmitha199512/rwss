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
			
	var url="./reports/rws_om_proposal_list_rpt1.jsp?proposalId="+proposalId;
	var properties = "width=700,height=500,toolbar=no,status=no,menubar=yes,location=no,directories=no,"
				   + "scrollbars=yes,copyhistory=no,resizable=yes";
	var printWindow = window.open(url,"",properties); 
}
</script>
<%@ include file="/commons/rws_header2.jsp"%>

<c:set var="sentProposals" value="${requestScope.omProposalList[0]}" />
<c:set var="receivedProposals" value="${requestScope.omProposalList[1]}" />

<table align="center" cellpadding="0" cellspacing="0">
<thead summary="Page header with round corner images">
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="O&M Proposals List" />
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
<table width="100%" cellpadding="0" cellspacing="0" border="1" bordercolor="#8A9FCD" 
	   rules="none" style="border-collapse: collapse">

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
		<th><bean:message key="app.proposalId" /></th>
		<th><bean:message key="app.assetName" /></th>
		<th><bean:message key="app.programme" />/<br>
			<bean:message key="app.subprogramme" />
		</th>
		<th><bean:message key="app.estimateCost" /><br>(Rs. in lakhs)</th>
		<th><bean:message key="app.financialYear" /></th>
		<th>Status</th>
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
			<input type="radio" name="select" onclick="javascript:fnPrint(this)" 
				   value="<c:out value='${item.proposalId}' />"/>
		</td>
		<td><c:out value="${item.officeName}"/></td>
		<td align="center" style="display:block;cursor:hand" 
			onmouseover='<c:out value="dddrivetip(\"${item.message}\")" escapeXml="false"/>' 
			onmouseout="hideddrivetip()">
			<c:out value="${item.proposalId}"/>
		</td>
		<td><c:out value="${item.assetName}"/></td>
		<c:set var="programmes" value="${item.programmes}" />
		<td align="left">
			<c:forEach items="${programmes}" var="programmeBean"> 
				<c:out value="${programmeBean.programmeName}" />
				<c:if test="${not empty programmeBean.subprogrammeName}">
				/&nbsp;<c:out value="${programmeBean.subprogrammeName}"/>
				</c:if>
				<br>
			</c:forEach>
		</td>
		<td><c:out value="${item.estimateCost}"/></td>
		<td><c:out value="${item.financialYear}"/></td>
		<td><c:out value="${item.status}"/></td>
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
	<c:if test="${not empty receivedProposals}">
	<table cellpadding="0" cellspacing="0" border="1" bordercolor="#000000" style="border-collapse: collapse">
	<thead class="gridHeader">
	<tr>
		<th>Print</th>
		<th>From</th>
		<th><bean:message key="app.proposalId" /></th>
		<th><bean:message key="app.assetName" /></th>
		<th><bean:message key="app.programme" />/<br>
			<bean:message key="app.subprogramme" />
		</th>
		<th><bean:message key="app.estimateCost" /><br>(Rs. in lakhs)</th>
		<th><bean:message key="app.financialYear" /></th>
		<th>Status</th>
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
		<td align="center">
			<input type="radio" name="select" onclick="javascript:fnPrint(this)" 
				   value="<c:out value='${item.proposalId}' />"/>
		</td>
		<td><c:out value="${item.officeName}"/></td>
		<td align="center" style="display:block;cursor:hand" 
			onmouseover='<c:out value="dddrivetip(\"${item.message}\")" escapeXml="false"/>' 
			onmouseout="hideddrivetip()">
			<c:out value="${item.proposalId}"/>
		</td>
		<td><c:out value="${item.assetName}"/></td>
		<c:set var="programmes" value="${item.programmes}" />
		<td align="left">
			<c:forEach items="${programmes}" var="programmeBean"> 
				<c:out value="${programmeBean.programmeName}" />
				<c:if test="${not empty programmeBean.subprogrammeName}">
				/&nbsp;<c:out value="${programmeBean.subprogrammeName}"/>
				</c:if>
				<br>
			</c:forEach>
		</td>
		<td><c:out value="${item.estimateCost}"/></td>
		<td><c:out value="${item.financialYear}"/></td>
		<td><c:out value="${item.status}"/></td>
	</tr>	
	</c:forEach>
	</tbody>
	<tfoot>
		<tr bgcolor="#8A9FCD">
			<td colspan="12" align="right" class="label">
			<b>No. of Received Proposals:&nbsp;<c:out value="${index+1}"/>&nbsp;</b>
			</td>
		</tr>
	</tfoot>
	</table>
	</c:if>
	<c:if test="${empty receivedProposals}">
		<span class="label">There are no received proposals</span>
	</c:if>
	</label>
	</fieldset>
</td>
</tr>
</table>

</td>
</tr>
</tbody>
</table>

<%@ include file="/commons/rws_tooltip.jsp"%>
<%@ include file="/commons/rws_footer.jsp"%>