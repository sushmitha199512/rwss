<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>

<table border="0">
<tr><td align="right"><a href="#1" onclick="javascript:history.go(-1)">Back</a>&nbsp;|&nbsp;<a href="/pred/home.jsp">Home</a></td></tr>

<tr><td align="center"><font  class="row1"><b><u><%=request.getAttribute("rptHeading") %></u></b></font></td></tr>
<!-- <tr><td align="center">&nbsp;</td></tr> -->
<tr><td>
<!--<table cellpadding="1" cellspacing="0" border="1" width="100%" bordercolor="#000000" style="border-collapse: collapse;font-family:Cottonwood" >  -->

<table cellpadding="1" cellspacing="0" border="1" width="100%" bordercolor="#000000" style="border-collapse: collapse;font-family:Times Roman;font-size:12px;" >
<tr class="gridHeader">
	<td width="145"><b>Work Id</td>
	<td width="145"><b>Work Name</td>
	<td width="145"><b>Total Releases<br>(Amount in Rs.Lakhs)</td>
	<td width="145"><b>Total Expenditure<br>(Amount in Rs.Lakhs)</td>

	<c:set var="totalReleases" value="0" />
	<c:set var="totalExpenditure" value="0" />
	<c:set var="grandTotalReleases" value="0" />
	<c:set var="grandTotalExpenditure" value="0" />
	<%int rowCount3=0; %>
	<c:set var="typeOfAssetCode" value="" />
	<c:set var="circleOfficeCode" value="" />
	<c:forEach items="${releasesVsExpList}" var="detailsItem" varStatus="detailsStatus">
	<%rowCount3++; %>
	<c:set var="detailsIndex" value="${detailsStatus.index}" />
	<c:set var="totalReleases" value="${totalReleases+detailsItem.totalReleases}"/>
	<c:set var="totalExpenditure" value="${totalExpenditure+detailsItem.totalExpenditure}"/>
	<c:set var="grandTotalReleases" value="${grandTotalReleases+detailsItem.totalReleases}"/>
	<c:set var="grandTotalExpenditure" value="${grandTotalExpenditure+detailsItem.totalExpenditure}"/>
	
	<%if(request.getParameter("scheme")!=null && request.getParameter("scheme").equals("")){ %>
	<!--
	<c:if test="${detailsItem.typeOfAssetCode != typeOfAssetCode && typeOfAssetCode!='' }">
	<tr style="font-family:Georgia;color:red">
	<td  colspan="2" align="right" style="font-family:Georgia;color:red"><b>Total: <b></td>
	<td align="right"><c:out value="${totalReleases-detailsItem.totalReleases}" /></td>
	<td align="right"><c:out value="${totalExpenditure-detailsItem.totalExpenditure}" /></td>
	</tr>
	</c:if>
	 -->
	<%}%>
	<%if(request.getParameter("circle")!=null && request.getParameter("circle").equals("")){ %>
	<c:if test="${detailsItem.circleOfficeCode != circleOfficeCode}">
	<c:set var="circleOfficeCode" value="${detailsItem.circleOfficeCode}" />
	<c:set var="typeOfAssetCode" value="" />
	<tr class="<c:out value='row1'/>">
	<td bgcolor="lightyellow" colspan="6" align="left" style="font-family:Georgia"><b>CircleOffice: <c:out value="${detailsItem.circleOfficeName}"/><b></td>
	</tr>
	</c:if>
	<%} %>
	
	<%if(request.getParameter("scheme")!=null && request.getParameter("scheme").equals("")){ %>
	<c:if test="${detailsItem.typeOfAssetCode != typeOfAssetCode}">
	
	 
	
	<c:set var="totalReleases" value="${0+detailsItem.totalReleases}"/>
	<c:set var="totalExpenditure" value="${0+detailsItem.totalExpenditure}"/>
	
	<c:set var="typeOfAssetCode" value="${detailsItem.typeOfAssetCode}" />
	<tr class="<c:out value='row1'/>">
	<td bgcolor="lightyellow" colspan="6" align="center" style="font-family:Georgia"><b>Scheme: <c:out value="${detailsItem.typeOfAssetName}"/><b></td>
	</tr>
	</c:if>
	<%} %>
	
	<tr>
	<td colspan="6">
	<tr class="<c:out value='row1'/>" >
	<td><a href="switch.do?prefix=/fundAccounting&page=/releasesVsExpenditureWorkWise.do&mode=init&selectedWorkId=<c:out value="${detailsItem.workId}"/>#at<c:out value="${detailsItem.workId}"/>" style="color:blue;">
	<c:out value="${detailsItem.workId}"/></a></td>
	<td><a href="switch.do?prefix=/fundAccounting&page=/releasesVsExpenditureWorkWise.do&mode=init&selectedWorkId=<c:out value="${detailsItem.workId}"/>#at<c:out value="${detailsItem.workId}"/>" style="color:blue">
	<c:out value="${detailsItem.workName}"/></a></td>
	<td align="right"><c:out value="${detailsItem.totalReleases}"/></td>
	<td align="right"><c:out value="${detailsItem.totalExpenditure}"/></td>
	</tr>
	</c:forEach>	
	
	<%if(rowCount3==0){ %>
	<tr class="<c:out value='row1'/>" >
		<td colspan="10" align="center">No Records</td>
	</tr>
	<%}else{ %>
	<tr style="font-family:Georgia;color:red">
	<td  colspan="2" align="right" style="font-family:Georgia;color:red"><b>Total: <b></td>
	<td align="right"><c:out value="${grandTotalReleases}" /></td>
	<td align="right"><c:out value="${grandTotalExpenditure}" /></td>
	</tr>
	<%} %>
</table>

</td></tr></table>

<%@ include file="/commons/rws_footer.jsp"%>