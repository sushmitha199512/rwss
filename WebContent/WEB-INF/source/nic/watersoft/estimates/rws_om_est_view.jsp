<%@ include file="/commons/rws_header1.jsp"%>
<script>
function fnShowWorkComponents(workId)
{
	var workId = workId.name;
	var url = "switch.do?prefix=/estimates&page=/ShowWorkComponents.do&type=om&workId="+workId;
	var properties = 'width=300,height=150,toolbar=no,status=no,menubar=no,location=no,directories=no,'
				   + 'scrollbars=yes,copyhistory=no,resizable=yes';
	var newWindow = window.open(url,'',properties);
	newWindow.moveTo(10,10);
}
</script>
<%@ include file="/commons/rws_header2.jsp"%>

<table width="100%" align="center" border="0" bordercolor="#8A9FCD" style="border-collapse:collapse">
<thead>
<tr>
	<td align="right">
		<a href="<rws:context page='/home.jsp'/>">Home</a>&nbsp;|&nbsp;
		<a href="switch.do?prefix=/estimates&page=/OMEstimateData.do">Back</a>&nbsp;|&nbsp;
		<a href="switch.do?prefix=/estimates&page=/OMEstimateAction.do&mode=Print" target="_new">Print</a>&nbsp;|&nbsp;
		<a href="switch.do?prefix=/estimates&page=/OMEstimateAction.do&mode=Excel" target="_new">Excel</a>
	</td>
</tr>	
</thead>
<tbody bgcolor="#8A9FCD">
<tr>
	<td class="reportTitle">O&M Estimates List</td>
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
	<td>Source Name</td>
	<td>Estimate Amount<br>(Rs. in lakhs)</td>
	<td>Sanctioned Amount<br>(Rs. in lakhs)</td>	
	<td>Total Components</td>
	<td>Manpower Charges<br>(in Rs.)</td>
	<td>Power Charges<br>(in Rs.)</td>
	<td>Consumables<br>(in Rs.)</td>
	<td>Repairs & Renewals<br>(in Rs.)</td>
	<td>Other Charges<br>(in Rs.)</td>
	<td>Remarks</td>
	<td>Action</td>
</tr>
</thead>
<tbody class="reportBody">
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
	<td align="center">
		<c:out value="${item.totalComponents}"/>
		<input type="button" value="..." name="<c:out value='${item.workId}'/>"
				class="btext" onclick="javascript: fnShowWorkComponents(this)">
	</td>
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
	<td nowrap>
		<a href="switch.do?prefix=/estimates&page=/EditOMEstimate.do&mode=data&target=view&workId=<c:out value='${item.workId}'/>" id="edit">Edit</a>&nbsp;|&nbsp;<a href="switch.do?prefix=/estimates&page=/OMEstimateAction.do&mode=Delete&workId=<c:out value='${item.workId}'/>" id="delete" onclick="return fnConfirmDelete()">Delete</a> 
	</td>
</tr>
</c:forEach>	
</tbody>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
<rws:alert />