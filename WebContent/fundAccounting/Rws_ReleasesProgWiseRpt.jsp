<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>

<table border="0">
<tr><td align="right"><a href="#1" onclick="javascript:history.go(-1)">Back</a>&nbsp;|&nbsp;<a href="/pred/home.jsp">Home</a></td></tr>
<tr><td align="right"><b>Amount in Rs. Lakhs</b></td></tr>

<tr><td>
<!--<table cellpadding="1" cellspacing="0" border="1" width="100%" bordercolor="#000000" style="border-collapse: collapse;font-family:Cottonwood" >  -->

<table cellpadding="1" cellspacing="0" border="1" width="100%" bordercolor="#000000" style="border-collapse: collapse;font-family:Times Roman;font-size:12px;" >
<tr class="gridHeader">
		<td width="145"><b>Loc Id</td>
		<td width="145"><b>Loc Ref</td>
		<td width="145"><b>Loc Date</td>
		<td width="145"><b>Head Of Account</td>
		<td width="145"><b>Project</td>
		<td width="145"><b>Work Id</td>
		<td width="145"><b>Work Name</td>
		<td width="145"><b>Loc Amount</td>
		
		
	<c:set var="programmeCode" value="" />
	<c:set var="circleOfficeCode" value="" />
	<c:set var="totalReleasesForCircle" value="0" />
	<c:set var="grandTotal" value="0" />
	<c:forEach items="${releasesProgWiseList}" var="detailsItem" varStatus="detailsStatus">
	
	<c:if test="${programmeCode!='' && (detailsItem.circleOfficeCode != circleOfficeCode || detailsItem.programmeCode != programmeCode ) }">
	<tr class="<c:out value='row1'/>">
	<td  colspan="7" align="left" style="font-family:Georgia"><font color=red><b>Total:</b></font></td>
	<td><font color=red><b> <c:out value="${totalReleasesForCircle}"/></b></font></td>
	</tr>
	<c:set var="totalReleasesForCircle" value="0" />
	</c:if>
	<c:if test="${detailsItem.programmeCode != programmeCode}">
	<c:set var="programmeCode" value="${detailsItem.programmeCode}" />
	<c:set var="circleOfficeCode" value="" />
	<tr class="<c:out value='row1'/>">
	<td bgcolor="lightyellow" colspan="8" align="center" style="font-family:Georgia"><b>Programme: <c:out value="${detailsItem.programmeName}"/><b></td>
	</tr>
	</c:if>
	
	<c:if test="${detailsItem.circleOfficeCode != circleOfficeCode}">
	<c:set var="circleOfficeCode" value="${detailsItem.circleOfficeCode}" />
	<tr class="<c:out value='row1'/>">
	<td bgcolor="lightyellow" colspan="8" align="left" style="font-family:Georgia"><b>Circle: <c:out value="${detailsItem.circleOfficeName}"/><b></td>
	</tr>
	</c:if>
	<c:set var="totalReleasesForCircle" value="${totalReleasesForCircle+detailsItem.locAmount}" />
	<c:set var="grandTotal" value="${grandTotal+detailsItem.locAmount}" />
	<tr class="<c:out value='row1'/>" >
	<td><c:out value="${detailsItem.locId}"/></td>
	<td><c:out value="${detailsItem.locReference}"/></td>
	<td><c:out value="${detailsItem.locDate}"/></td>
	<td><c:out value="${detailsItem.headOfAccount}"/></td>
	<td><c:out value="${detailsItem.project}"/></td>
	<td><c:out value="${detailsItem.workId}"/></td>
	<td><c:out value="${detailsItem.workName}"/></td>
	<td><c:out value="${detailsItem.locAmount}"/></td>
	
	</tr>
	</c:forEach>	
	<!-- to print totals for the last circle -->
	<tr class="<c:out value='row1'/>">
	<td  colspan="7" align="left" style="font-family:Georgia"><font color=red><b>Total:</b></font></td>
	<td><font color=red><b> <c:out value="${totalReleasesForCircle}"/></b></font></td>
	</tr>
	<c:if test="${totalReleasesForCircle!=grandTotal}">
	<tr class="<c:out value='row1'/>">
	<td  colspan="7" align="left" style="font-family:Georgia"><font color=red><b>Grand Total:</b></font></td>
	<td><font color=red><b> <c:out value="${grandTotal}"/></b></font></td>
	</tr>
	</c:if>
</table>
</td></tr></table>

<%@ include file="/commons/rws_footer.jsp"%>