<%@ include file="/commons/rws_header1.jsp"%>

<script language="javascript">
function getLocDetails(broId)
{
	document.forms[0].action="switch.do?prefix=/fundAccounting&page=/broDetailsList.do&mode=getLocList&broId="+broId;
	document.forms[0].submit();
}
function getCircleLocList(url)
{
document.forms[0].action=url;
document.forms[0].submit();
}
function getProjectLocList(url)
{
document.forms[0].action=url;
document.forms[0].submit();

}
</script>
<%@ include file="/commons/rws_header2.jsp"%>
<html:form action="broDetailsList.do">
<html:hidden property="broId" />
</html:form>
<table align="center" cellpadding="0" cellspacing="0">
<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b>&nbsp;&nbsp;</caption>
<thead summary="Page header with round corner images">
<tr>
<td>
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="LOC Details List" />
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
<c:set var="toDisplay" value="${requestScope.toDisplay}" />
<c:if test="${toDisplay == 'LOC' }">
<tr>
<td>
	<fieldset>
	<legend>Sent From HeadOffice to CircleOffice</legend>
	<label>
	<c:if test="${not empty locList}">	
	<table cellpadding="1" cellspacing="0" border="1" width="100%" bordercolor="#000000" style="border-collapse: collapse">
	<thead class="gridHeader">
	<tr>
		<th>District</th>
		<th>Programme</th>
		<th>Sub Programme</th>
		<th>Head Of Account</th>
		<th>LOC Date</th>
		<th>LOC Amount</th>
		<th>Office</th>
		<th>Place</th>
		<th>PAO/APAO</th>
		<th>Remarks</th>
		
	</tr>
	</thead>
	<tbody class="label">
	
	<c:set var="broId" value="${requestScope.broId}" />
	
	<c:set var="locIdTmp" value="" />
	<c:forEach items="${locList}" var="locItem" varStatus="locStatus">
	<c:set var="locIndex" value="${locStatus.index}" />
	
	<c:if test="${locItem.project == 'N' }">
	
	<c:if test="${locItem.locId != locIdTmp}">
	<c:set var="locIdTmp" value="${locItem.locId}" />
	<tr bgcolor="lightyellow" ONMOUSEOVER="this.style.cursor='hand'" onclick="getCircleLocList('switch.do?prefix=/fundAccounting&page=/broDetailsList.do&mode=getCircleLocList&broId=<c:out value="${broId}"/>&locId=<c:out value="${locItem.locId}"/>')">
		<td colspan=14" ><b>Loc Id : </b><c:out value="${locItem.locId}"/></td>
	</tr>
	</c:if>
	
	
	<tr class="<c:out value='row${index%2}'/>">
		<td width="145"><c:out value="${locItem.districtName}"/></td>
		<td align="center" width="85"><c:out value="${locItem.programName}"/></td>
		<td align="center" width="65"><c:out value="${locItem.subprogramName}"/></td>
		<td align="center" width="65"><c:out value="${locItem.headOfAccountName}"/></td>
		<td width="60">&nbsp;<c:out value="${locItem.locDate}"/></td>
		<td width="60" align="right"><c:out value="${locItem.locAmount}"/>&nbsp;</td>
		<td width="60" align="right"><c:out value="${locItem.office}"/>&nbsp;</td>
		<td width="80"><c:out value="${locItem.place}"/></td>
		<td width="80"><c:out value="${locItem.paoApaoFlag}"/></td>
		<td width="60" align="right"><c:out value="${locItem.remarks}"/>&nbsp;</td>
	</tr>
	</c:if>	
	</c:forEach>
	</tbody>
	</table>
	</c:if>
	</label>
	</fieldset>
</td>
</tr>
	
	
<tr>
<td>
	<fieldset>
	<legend>Sent from HeadOffice to DivisionOffice (Projects)</legend>
	<label>
	<c:if test="${not empty locList}">	
	<table cellpadding="1" cellspacing="0" border="1" width="100%" bordercolor="#000000" style="border-collapse: collapse">
	<thead class="gridHeader">
	<tr>
		<th>District</th>
		<th>Programme</th>
		<th>Sub Programme</th>
		<th>Head Of Account</th>
		<th>LOC Date</th>
		<th>Work Description</th>
		<th>Work Id</th>
		<th>Work Name</th>
		<th>LOC Amount</th>
		<th>Office</th>
		<th>Place</th>
		<th>PAO/APAO</th>
		<th>Remarks</th>
		
	</tr>
	</thead>
	<tbody class="label">
	<c:set var="locIdTmp" value="" />
	
	<c:forEach items="${locList}" var="locItem" varStatus="locStatus">
	<c:set var="locIndex" value="${locStatus.index}" />
	
	<c:if test="${locItem.project == 'Y' }">
	<c:if test="${locItem.locId != locIdTmp}">
	<c:set var="locIdTmp" value="${locItem.locId}" />
	<tr bgcolor="lightyellow" ONMOUSEOVER="this.style.cursor='hand'" onclick="getProjectLocList('switch.do?prefix=/fundAccounting&page=/broDetailsList.do&mode=getProjectLocList&broId=<c:out value="${broId}"/>&locId=<c:out value="${locItem.locId}"/>')">
		<td colspan=14" ><b>Loc Id : </b><c:out value="${locItem.locId}"/></td>
	</tr>
	</c:if>
	<tr class="<c:out value='row${index%2}'/>">
		<td width="145"><c:out value="${locItem.districtName}"/></td>
		<td align="center" width="85"><c:out value="${locItem.programName}"/></td>
		<td align="center" width="65"><c:out value="${locItem.subprogramName}"/></td>
		<td align="center" width="65"><c:out value="${locItem.headOfAccountName}"/></td>
		<td width="60">&nbsp;<c:out value="${locItem.locDate}"/></td>
		<td width="70">&nbsp;<c:out value="${locItem.workDescription}"/></td>
		<td width="70">&nbsp;<c:out value="${locItem.workId}"/></td>
		<td width="70">&nbsp;<c:out value="${locItem.workName}"/></td>
		<td width="60" align="right"><c:out value="${locItem.locAmount}"/>&nbsp;</td>
		<td width="60" align="right"><c:out value="${locItem.office}"/>&nbsp;</td>
		<td width="80"><c:out value="${locItem.place}"/></td>
		<td width="80"><c:out value="${locItem.paoApaoFlag}"/></td>
		<td width="60" align="right"><c:out value="${locItem.remarks}"/>&nbsp;</td>
	</tr>
	</c:if>	
	</c:forEach>
	</tbody>
	</table>
	</c:if>
	</label>
	</fieldset>
</td>
</tr>



	
	
	
	<c:if test="${empty locList}">
		<span class="label">There are no LOC's</span>
	</c:if>

	</label>
	</fieldset>
</td>
</tr>
</c:if>










<c:if test="${toDisplay == 'CLOC' }">
<tr>
<td>
	<fieldset>
	<legend>List Of Circle LOC's</legend>
	<label>
	<c:if test="${not empty locList}">	
	<table cellpadding="1" cellspacing="0" border="1" width="100%" bordercolor="#000000" style="border-collapse: collapse">
	<thead class="gridHeader">
	<tr>
		<th>District</th>
		<th>Programme</th>
		<th>Sub Programme</th>
		<th>Head Of Account</th>
		<th>LOC Date</th>
		<th>Work Description</th>
		<th>Work Id</th>
		<th>Work Name</th>
		<th>LOC Amount</th>
		<th>Office</th>
		<th>Place</th>
		<th>PAO/APAO</th>
		<th>Remarks</th>
		
	</tr>
	</thead>
	<tbody class="label">
	<c:set var="broId" value="${requestScope.broId}" />
	<c:set var="circleLocIdTmp" value="" />
	<c:forEach items="${locList}" var="locItem" varStatus="locStatus">
	<c:set var="locIndex" value="${locStatus.index}" />
	
	<c:if test="${locItem.locId != circleLocIdTmp}">
	<c:set var="circleLocIdTmp" value="${locItem.locId}" />
	<tr bgcolor="lightyellow">
		<td colspan=14"><b>Circle Loc Id : </b><c:out value="${locItem.locId}"/></td>
	</tr>
	</c:if>
	<tr class="<c:out value='row${index%2}'/>">
		<td width="145"><c:out value="${locItem.districtName}"/></td>
		<td align="center" width="85"><c:out value="${locItem.programName}"/></td>
		<td align="center" width="65"><c:out value="${locItem.subprogramName}"/></td>
		<td align="center" width="65"><c:out value="${locItem.headOfAccountName}"/></td>
		<td width="60">&nbsp;<c:out value="${locItem.locDate}"/></td>
		<td width="70" align="center">--</td>
		<td align="center">--</td>
		<td width="70" align="center">--</td>
		<td width="60" align="right"><c:out value="${locItem.locAmount}"/>&nbsp;</td>
		<td width="60" align="right"><c:out value="${locItem.office}"/>&nbsp;</td>
		<td width="80"><c:out value="${locItem.place}"/></td>
		<td width="80"><c:out value="${locItem.paoApaoFlag}"/></td>
		<td width="60" align="right"><c:out value="${locItem.remarks}"/>&nbsp;</td>
	</tr>
	</c:forEach>
	
	</tbody>
	</table>	
	</c:if>
	
	<c:if test="${empty locList}">
		<span class="label" width="300">No Records Available</span>
	</c:if>

	</label>
	</fieldset>
</td>
</tr>

</c:if>


<c:if test="${toDisplay == 'PLOC' }">
<tr>
<td>
	<fieldset>
	<legend>List Of Projects LOC's</legend>
	<label>
	<c:if test="${not empty locList}">	
	<table cellpadding="1" cellspacing="0" border="1" width="100%" bordercolor="#000000" style="border-collapse: collapse">
	<thead class="gridHeader">
	<tr>
		<th>District</th>
		<th>Programme</th>
		<th>Sub Programme</th>
		<th>Head Of Account</th>
		<th>LOC Date</th>
		<th>Work Description</th>
		<th>Work Id</th>
		<th>Work Name</th>
		<th>LOC Amount</th>
		<th>Office</th>
		<th>Place</th>
		<th>PAO/APAO</th>
		<th>Remarks</th>
		
	</tr>
	</thead>
	<tbody class="label">
	<c:set var="broId" value="${requestScope.broId}" />
	<c:set var="circleLocIdTmp" value="" />
	<c:forEach items="${locList}" var="locItem" varStatus="locStatus">
	<c:set var="locIndex" value="${locStatus.index}" />
	
	<c:if test="${locItem.locId != circleLocIdTmp}">
	<c:set var="circleLocIdTmp" value="${locItem.locId}" />
	<tr bgcolor="lightyellow">
		<td colspan=14"><b>Loc Id : </b><c:out value="${locItem.locId}"/></td>
	</tr>
	</c:if>
	<tr class="<c:out value='row${index%2}'/>">
		<td width="145"><c:out value="${locItem.districtName}"/></td>
		<td align="center" width="85"><c:out value="${locItem.programName}"/></td>
		<td align="center" width="65"><c:out value="${locItem.subprogramName}"/></td>
		<td align="center" width="65"><c:out value="${locItem.headOfAccountName}"/></td>
		<td width="60">&nbsp;<c:out value="${locItem.locDate}"/></td>
		<td width="70" align="center"><c:out value="${locItem.workDescription}"/></td>
		<td align="center"><c:out value="${locItem.workId}"/></td>
		<td width="70" align="center"><c:out value="${locItem.workName}"/></td>
		<td width="60" align="right"><c:out value="${locItem.locAmount}"/>&nbsp;</td>
		<td width="60" align="right"><c:out value="${locItem.office}"/>&nbsp;</td>
		<td width="80"><c:out value="${locItem.place}"/></td>
		<td width="80"><c:out value="${locItem.paoApaoFlag}"/></td>
		<td width="60" align="right"><c:out value="${locItem.remarks}"/>&nbsp;</td>
	</tr>
	</c:forEach>
	
	</tbody>
	</table>	
	</c:if>
	
	<c:if test="${empty locList}">
		<span class="label" width="300">No Records Available</span>
	</c:if>

	</label>
	</fieldset>
</td>
</tr>

</c:if>
</tbody>

</table>

<%@ include file="/commons/rws_footer.jsp"%>