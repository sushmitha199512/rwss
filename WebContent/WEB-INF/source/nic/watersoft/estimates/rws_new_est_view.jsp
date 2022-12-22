<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>

<table width="100%" align="center" border="0" bordercolor="#8A9FCD" style="border-collapse:collapse">
<thead>
<tr>
	<td align="right">
		<a href="<rws:context page='/home.jsp'/>">Home</a>&nbsp;|&nbsp;
		<a href="switch.do?prefix=/estimates&page=/NewEstimateData.do">Back</a>&nbsp;|&nbsp;
		<a href="switch.do?prefix=/estimates&page=/NewEstimateAction.do&mode=Print" target="_new">Print</a>&nbsp;|&nbsp;
		<a href="switch.do?prefix=/estimates&page=/NewEstimateAction.do&mode=Excel" target="_new">Excel</a>
	</td>
</tr>	
</thead>
<tbody bgcolor="#8A9FCD">
<tr>
	<td class="reportTitle">New Estimates List</td>
</tr>
</tbody>
</table>
<table width="100%" align="center" border="1" bordercolor="#8A9FCD" style="border-collapse:collapse">
<thead class="reportHead">
<tr>
	<td>S.No.</td>
	<td>Work Id</td>
	<td>Work Name</td>
	<td>Financial Year</td>
	<td>Asset Type</td>
	<td>Source Name</td>
	<td>Estimate Amount<br>(Rs. in lakhs)</td>
	<td>Sanctioned Amount<br>(Rs. in lakhs)</td>	
	<td>Total Components</td>
	<td>Remarks</td>
	<td>Action</td>
</tr>
</thead>
<tbody class="reportBody">
<c:forEach items="${requestScope.estimateList}" var="item" varStatus="status">
<c:set var="index" value="${status.index}" />
<tr>
	<td><c:out value="${index+1}"/></td>
	<td align="center" nowrap><c:out value="${item.workId}"/></td>
	<td><c:out value="${item.workName}"/></td>
	<td align="center" nowrap><c:out value="${item.financialYear}"/></td>
	<td><c:out value="${item.assetType}" /></td>
	<td><c:out value="${item.sourceCode}"/></td>
	<td align="right">
		<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" minIntegerDigits="1"
						  value="${item.estimateAmount}" />
	</td>
	<td align="right">
		<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" minIntegerDigits="1"
						  value="${item.sanctionedAmount}" />
		
	</td>
	<td align="center">
		<c:out value="${item.totalComponents}"/>
		<input type="button" value="..." name="<c:out value='${item.workId}'/>"
				class="btext" onclick="javascript: fnShowWorkComponents(this,'new')">
	</td>
	<td><c:out value="${item.remarks}"/></td>
	<td nowrap>
		<a href="switch.do?prefix=/estimates&page=/EditNewEstimate.do&mode=data&target=view&workId=<c:out value='${item.workId}'/>" id="edit">Edit</a>&nbsp;|&nbsp;<a href="switch.do?prefix=/estimates&page=/NewEstimateAction.do&mode=Delete&workId=<c:out value='${item.workId}'/>" id="delete" onclick="return fnConfirmDelete()">Delete</a> 
	</td>
</tr>
</c:forEach>	
</tbody>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
<rws:alert />