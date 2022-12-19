<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>

<c:set var="track1" value="${requestScope.consideredTracks[0]}" />
<h4 align="center"><u>O&M Proposal History</u></h4>

<table border="1">
<caption class="staticLabelBold">
	Proposal considered at <c:out value="${track1.officeName}"/> on <c:out value="${track1.proposalDate}"/> by <c:out value="${track1.userId}"/>
</caption>
<tbody>
<colgroup class="staticLabel">
<colgroup class="staticLabelBold">
<colgroup class="staticLabel">
<colgroup class="staticLabelBold">
<colgroup class="staticLabel">
<colgroup class="staticLabelBold">
<tr>
	<td><bean:message key="app.proposalId" /></td>
	<td><c:out value="${track1.proposalId}" /></td>
	<td><bean:message key="app.assetCode" /></td>
	<td><c:out value="${track1.assetCode}" /></td>
	<td><bean:message key="app.assetName" /></td>
	<td><c:out value="${track1.assetName}" /></td>
</tr>
<tr>
	<td><bean:message key="app.financialYear" /></td>
	<td><c:out value="${track1.financialYear}" /></td>
	<td><bean:message key="app.estimateCost" /></td>
	<td>Rs.&nbsp; 
		<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
					  	  value="${track1.estimateCost}" />&nbsp;(in lakhs)
	</td>
	<td><bean:message key="app.remarks"/></td>
	<td><c:out value="${track1.remarks}" /></td>
</tr>
<tr>	
	<td>
		<bean:message key="app.programme"/>/<br>
		<bean:message key="app.subprogramme"/>
	<td colspan="5">
		<c:set var="programmes" value="${track1.programmes}" />
		<c:forEach items="${programmes}" var="programmeBean"> 
			<c:out value="${programmeBean.programmeName}" />
			<c:if test="${not empty programmeBean.subprogrammeName}">
			/&nbsp;<c:out value="${programmeBean.subprogrammeName}"/>
			</c:if>
			<br>
		</c:forEach>
	</td>
</tr>
</tbody>
</table>
<br>
<c:if test="${not empty requestScope.actualTracks}">
<c:set var="show" value="true" />

<c:set var="submitDate" value="" />
<c:forEach items="${actualTracks}" var="item" varStatus="status">

<c:if test="${item.actionType eq 'SUBMITTED' || item.actionType eq 'FORWARDED'}">
<c:if test="${show == 'true'}">
<table border="1" bordercolor="#000000" style="border-collapse:collapse">
<thead class="gridHeader">
<tr>
	<th><bean:message key="app.trackNo" /></th>
	<th><bean:message key="app.action" /></th>
	<th><bean:message key="app.from" /></th>
	<th><bean:message key="app.to" /></th>
	<th><bean:message key="app.letterMemoNo"/></th>
	<th><bean:message key="app.subject" /></th>
	<th><bean:message key="app.ref" /></th>
	<th><bean:message key="app.content" /></th>
	<th><bean:message key="app.estimateCost"/></th>
	<th><bean:message key="app.financialYear"/></th>
	<th><bean:message key="app.remarks"/></th>
</tr>
</thead>
<c:set var="show" value="false" />
</c:if>

<tbody bgcolor="#FFFFFF" class="staticLabel">

<c:if test="${submitDate != item.submitDate}">
<c:set var="submitDate" value="${item.submitDate}"/>
<tr bgcolor="lightyellow">
	<td colspan="12"><b>Date:&nbsp;<c:out value="${item.submitDate}"/></b></td>
</tr>
</c:if>

<c:set var="actionType" value="${item.actionType}" />
<c:set var="deferred" value="false" />
<c:if test="${empty item.workId}">
<tr>
	<td><c:out value="${item.trackNo}"/></td>
	<td><c:out value="${item.actionType}"/></td>
	<td>
		<c:out value="${item.sentBy}"/>,<br>
		<c:out value="${item.actionFrom}"/>
	</td>
	<td>
		<c:out value="${item.sentTo}"/>,<br>
		<c:out value="${item.actionTo}"/>
	</td>
	<td><c:out value="${item.letterNo}"/></td>
	<td><c:out value="${item.submitSubject}"/></td>
	<td><c:out value="${item.submitRef}"/></td>
	<td><c:out value="${item.submitContent}"/></td>
	<td align="right">
		<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
					  	  value="${item.estimateCost}" />
	</td>
	<td align="center" nowrap><c:out value="${item.financialYear}"/></td>
	<td><c:out value="${item.remarks}"/></td>
</tr>
</c:if>
</c:if>

<c:if test="${item.actionType ne 'SUBMITTED' && item.actionType ne 'FORWARDED'}">
	<c:set var="actionType" value="${item.actionType}" />
	<c:set var="actionRemarks" value="${item.submitContent}" />
	<c:set var="actionDate" value="${item.actionDate}" />
	<c:set var="deferred" value="true" />
</c:if>
</c:forEach>

</c:if>
<c:if test="${show == 'false'}"> 
</tbody>
</table>
</c:if>
<br>
<c:if test="${deferred == true}">
<center>
	<span class="staticLabelBold" style="color:red">
		PROPOSAL <c:out value="${actionType}" /> on <c:out value="${actionDate}" />
	</span><br>
	<span class="staticLabel">
		Remarks: <c:out value="${actionRemarks}" />
	</span>
</center>
</c:if>


<c:set var="sanctionedTracks" value="${requestScope.sanctionedTracks}" />

<c:if test="${not empty sanctionedTracks}">
<c:set var="track1" value="${sanctionedTracks[0]}"/>
<table border="1">
<caption class="staticLabelBold">
	Proposal sanctioned at <c:out value="${track1.officeName}"/> on <c:out value="${track1.adminDate}"/>
</caption>
<tbody>
<colgroup class="staticLabel">
<colgroup class="staticLabelBold">
<colgroup class="staticLabel">
<colgroup class="staticLabelBold">
<colgroup class="staticLabel">
<colgroup class="staticLabelBold">
<tr>
	<td><bean:message key="app.workId" /></td>
	<td><c:out value="${track1.workId}" /></td>
	<td><bean:message key="app.estimateCost" /></td>
	<td>Rs.&nbsp;
		<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
					  	  value="${track1.estimateCost}" />&nbsp;(in lakhs)
	</td>
	<td><bean:message key="app.sanctionedAmount" /></td>
	<td>Rs.&nbsp;
		<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
				  	  	  value="${track1.sanctionedAmount}" />&nbsp;(in lakhs)
	</td>
</tr>
<tr>
	<td>Admn. Sanc. Proc. No.</td>
	<td><c:out value="${track1.adminNo}" /></td>
	<td>Admin. Date</td>
	<td><c:out value="${track1.adminDate}" /></td>
	<td>GO No.</td>
	<td><c:out value="${track1.goNo}" /></td>
</tr>
<tr>
	<td>Sanctioning Authority</td>
	<td><c:out value="${track1.sanctioningAuthority}" /></td>
	<td>Sanctioned At</td>
	<td colspan="3"><c:out value="${track1.sanctionedAt}" /></td>
</tr>
</tbody>
</table>
</c:if>

<br>
<c:if test="${not empty requestScope.actualTracks}">
<c:set var="show" value="true" />

<c:set var="submitDate" value="" />
<c:forEach items="${actualTracks}" var="item" varStatus="status">

<c:if test="${show == 'true' && not empty item.workId}">
<table border="1" bordercolor="#000000" style="border-collapse:collapse">
<thead class="gridHeader">
<tr>
	<th><bean:message key="app.trackNo" /></th>
	<th><bean:message key="app.action" /></th>
	<th><bean:message key="app.from" /></th>
	<th><bean:message key="app.to" /></th>
	<th><bean:message key="app.letterMemoNo"/></th>
	<th><bean:message key="app.subject" /></th>
	<th><bean:message key="app.ref" /></th>
	<th><bean:message key="app.content" /></th>
	<th><bean:message key="app.estimateCost"/></th>
	<th><bean:message key="app.financialYear"/></th>
	<th><bean:message key="app.remarks"/></th>
</tr>
</thead>
<c:set var="show" value="false" />
</c:if>

<c:if test="${show == 'false'}"> 
<tbody bgcolor="#FFFFFF" class="staticLabel">
</c:if>
<c:if test="${submitDate != item.submitDate && not empty item.workId}">
<c:set var="submitDate" value="${item.submitDate}"/>
<tr bgcolor="lightyellow">
	<td colspan="12"><b>Date:&nbsp;<c:out value="${item.submitDate}"/></b></td>
</tr>
</c:if>

<c:if test="${not empty item.workId}">
<tr>
	<td><c:out value="${item.trackNo-1}"/></td>
	<td><c:out value="${item.actionType}"/></td>
	<td>
		<c:out value="${item.sentBy}"/>,<br>
		<c:out value="${item.actionFrom}"/>
	</td>
	<td>
		<c:out value="${item.sentTo}"/>,<br>
		<c:out value="${item.actionTo}"/>
	</td>
	<td><c:out value="${item.letterNo}"/></td>
	<td><c:out value="${item.submitSubject}"/></td>
	<td><c:out value="${item.submitRef}"/></td>
	<td><c:out value="${item.submitContent}"/></td>
	<td align="right">
		<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
					  	  value="${item.estimateCost}" />
	</td>
	<td align="center"><c:out value="${item.financialYear}"/></td>
	<td><c:out value="${item.remarks}"/></td>
</tr>
</c:if>
</c:forEach>

</c:if>
<c:if test="${show == 'false'}"> 
</tbody>
</table>
</c:if>
<br>


<%@ include file="/commons/rws_footer.jsp" %>