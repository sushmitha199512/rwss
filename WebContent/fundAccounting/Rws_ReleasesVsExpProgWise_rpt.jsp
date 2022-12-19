<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<table border="0">
<tr><td align="right"><a href="#1" onclick="javascript:history.go(-1)">Back</a>&nbsp;|&nbsp;<a href="/pred/home.jsp">Home</a></td></tr>
<tr><td align="right"><b>Amount in Rs. Lakhs</b></td></tr>

<tr><td>
<!--<table cellpadding="1" cellspacing="0" border="1" width="100%" bordercolor="#000000" style="border-collapse: collapse;font-family:Cottonwood" >  -->

<table cellpadding="1" cellspacing="0" border="1" width="100%" bordercolor="#000000" style="border-collapse: collapse;font-family:Times Roman;font-size:12px;" >
<tr class="gridHeader">
		<td width="25"><b>S.No.</td>		
		<td width="145"><b>Work Id</td>
		<td width="145"><b>Work Name</td>
		<td width="145"><b>Expenditue During</td>
	
	<c:set var="workIdCount" value="0" />
	<c:set var="workIdTmp" value="" />		
	<c:set var="programmeCode" value="" />
	<c:set var="circleOfficeCode" value="" />
	<c:set var="totalExpenditueForCircle" value="0" />
	<c:set var="grandTotal" value="0" />
	<%int index = 1; %>
	<c:forEach items="${releasesVsExpProgWiseList}" var="detailsItem" varStatus="status">
	<c:set var="index" value="${status.index}" />
	<c:if test="${programmeCode!='' && (detailsItem.circleOfficeCode != circleOfficeCode || detailsItem.programmeCode != programmeCode ) }">
	<tr class="<c:out value='row1'/>">
	<td  colspan="3" align="left" style="font-family:Georgia"><font color=red><b>Total:</b></font></td>
	<td><font color=red><b> <c:out value="${totalExpenditueForCircle}"/></b></font></td>
	</tr>
	<c:set var="totalExpenditueForCircle" value="0" />
	</c:if>
	
	<c:if test="${workIdTmp != detailsItem.workId}">
	<c:set var="workIdCount" value="${workIdCount+1}" />
	<c:set var="workIdTmp" value="${detailsItem.workId}" />
	</c:if>
	
	<c:if test="${detailsItem.programmeCode != programmeCode}">
	<c:set var="programmeCode" value="${detailsItem.programmeCode}" />
	<c:set var="circleOfficeCode" value="" />
	<tr class="<c:out value='row1'/>">
	<td bgcolor="lightyellow" colspan="4" align="center" style="font-family:Georgia"><b>Programme: <c:out value="${detailsItem.programmeName}"/><b></td>
	</tr>
	</c:if>
	
	<c:if test="${detailsItem.circleOfficeCode != circleOfficeCode}">
	<c:set var="circleOfficeCode" value="${detailsItem.circleOfficeCode}" />
	<tr class="<c:out value='row1'/>">
	<td bgcolor="lightyellow" colspan="4" align="left" style="font-family:Georgia"><b>Circle: <c:out value="${detailsItem.circleOfficeName}"/><b></td>
	</tr>
	</c:if>
	<c:set var="totalExpenditueForCircle" value="${totalExpenditueForCircle+detailsItem.expenditureDuring}" />
	<c:set var="grandTotal" value="${grandTotal+detailsItem.expenditureDuring}" />
	<tr class="<c:out value='row${index%2}'/>" >
	<td><%=index++%></td>
	<td><c:out value="${detailsItem.workId}"/></td>
	<td><c:out value="${detailsItem.workName}"/></td>
	<td><a href='GetExpenditureDetails' onClick="window.open('fundAccounting/rws_expenditure_details.jsp?workName=<c:out value="${detailsItem.workName}"/>&program=<c:out value="${detailsItem.programmeName}"/>&circle=<c:out value="${detailsItem.circleOfficeName}"/>&work_id=<c:out value="${detailsItem.workId}"/>','RIC','width=500,height=400,resizable=no,scrollbars=yes');return false;"><c:out value="${detailsItem.expenditureDuring}"/></a></td>
	</tr>
	</c:forEach>	
	<!-- to print totals for the last circle -->
	<tr class="<c:out value='row1'/>">
	<td  colspan="3" align="left" style="font-family:Georgia"><font color=red><b>Total:</b></font></td>
	<td><font color=red><b> <c:out value="${totalExpenditueForCircle}"/></b></font></td>
	</tr>
	<c:if test="${totalExpenditueForCircle!=grandTotal}">
	<tr class="<c:out value='row1'/>">
	<td  colspan="3" align="left" style="font-family:Georgia"><font color=red><b>Grand Total:</b></font></td>
	<td><font color=red><b> <c:out value="${grandTotal}"/></b></font></td>
	</tr>
	</c:if>
</table>
</td></tr></table>

<%@ include file="/commons/rws_footer.jsp"%>