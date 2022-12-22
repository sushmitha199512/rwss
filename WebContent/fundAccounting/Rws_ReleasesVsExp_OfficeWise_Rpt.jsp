<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<script language="javascript">
function funcInit()
{
document.getElementById("releasesVsExpenditureTable").style.height="1%";
}
</script>
<body onload="funcInit()">
<html:form action="releasesVsExpenditureWorkWise.do">
</html:form>
<table align="center" cellpadding="0" cellspacing="0" border=0 bordercolor="black" id="releasesVsExpenditureTable">
<caption align="right" class="staticLabel"><b>Amount in Rs. lakhs</b>&nbsp;&nbsp;</caption>
<thead>
<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="textborder">
				<table border="0" width="100%"><tr><td><font color="#FFFFFF" size="2">Releases Vs Expenditure Office Wise</font>
				<font color="#FFFFFF" size="2">&nbsp;&nbsp;&nbsp;</font></td>
				<td align="right"><font color="#FFFFFF" size="3"><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="13" HEIGHT="13" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td>
				</tr>
				</table>
			</td>	
</tr>
</thead>


<tbody bgcolor="#DEE3E0">
<tr>
<td>
	<fieldset>
	<legend></legend>
	<label>
	<c:if test="${not empty releasesDetailsCircleOfficeWise}">	
	<table cellpadding="1" cellspacing="0" border="1" width="100%" bordercolor="#000000" style="border-collapse: collapse">
	<thead class="gridHeader">
	
	</thead>
	<tbody class="label">
	
	<c:forEach items="${releasesDetailsCircleOfficeWise}" var="item" varStatus="status">
	<c:set var="index" value="${status.index}" />
	<c:if test="${index != 0}">
	<tr><td colspan="6">&nbsp;</td></tr>
	</c:if>
	<tr class="gridHeader">
		<td align="left"><b>Circle Office Name: </b><c:out value="${item.circleOfficeName}"/></td>
		<td align="left"><b>Total Amount Released: </b><c:out value="${item.locAmount}"/></td>
		<td align="left"><b>Total Expenditure: </b><c:out value="${item.expenditureDuring}"/></td>
		
	</tr>	
	<!-- code to display division office wise for each circleofficewise recode -->
	
	<c:set var="circleOfficeCodeTmp" value="" />
	<c:set var="workIdTmp2" value="" />
	
	<tr><td colspan="6">
	
	<table cellpadding="1" cellspacing="0" border="1" width="100%" bordercolor="#000000" style="border-collapse: collapse">
	<tr class="<c:out value='row${index%2}'/>">
	<td><b><small>Circle Office Name</small></b></td>
	<td><b><small>Division Office Name</small></b></td>
	<td><b><small>Total Amount Released</small></b></td>
	<td><b><small>Total Expenditure</small></b></td>
	</tr>
	<%int i=-1; %>
	<c:forEach items="${releasesDetailsDivisionOfficeWiseList}" var="divisionItem" varStatus="divisionStatus">
	<c:set var="divisionIndex" value="${divisionStatus.index}" />
	<c:if test="${divisionItem.circleOfficeCode == item.circleOfficeCode}">
	<%i++; %>
	
	<c:if test="${detailsItem.workId != workIdTmp}">
	<c:set var="circleOfficeCodeTmp" value="${divisionItem.circleOfficeCode}" />
	
	</c:if>
	<tr>
	
	<td colspan="6">
	
	<tr class="<c:out value='row${index%2}'/>">
	<td><c:out value="${divisionItem.circleOfficeName}"/></td>
	<td><c:out value="${divisionItem.divisionOfficeName}"/></td>
	<td><c:out value="${divisionItem.locAmount}"/></td>
	<td><c:out value="${divisionItem.expenditureDuring}"/></td>
	</tr>
	
	
	</c:if>
	</c:forEach>	
	<%if(i==-1){ %>
	<tr class="<c:out value='row${index%2}'/>"><td colspan="6" align="center"><small>No Data</small></td></tr>
	<%} %>
	</table>
	</td>
	</tr>
	
	<!-- end of code code to display division office wise for each circleofficewise recode -->
	
	
	</c:forEach>
	</tbody>
	</table>
	</c:if>
	</label>
	</fieldset>
	</td>
	</tr>
	</tbody>
	</table>

</body>
<%@ include file="/commons/rws_footer.jsp"%>