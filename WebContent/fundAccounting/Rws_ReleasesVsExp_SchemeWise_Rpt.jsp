<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<table border="0">
<tr><td align="right"><a href="/pred/home.jsp">Home</a></td></tr>


<tr><td>
<!--<table cellpadding="1" cellspacing="0" border="1" width="100%" bordercolor="#000000" style="border-collapse: collapse;font-family:Cottonwood" >  -->

<table cellpadding="1" cellspacing="0" border="1" width="100%" bordercolor="#000000" style="border-collapse: collapse;font-family:Times Roman;font-size:12px;" >

<tr class="gridHeader">
		<td width="145"><b>Work Id</td>
		<td width="145"><b>Work Name</td>
		<td width="145"><b>Total Amount Released<br>(Amount in Rs.Lakhs)</td>
		<td width="145"><b>Total Expenditure<br>(Amount in Rs.Lakhs)</td>


	<c:set var="typeOfAssetCode" value="" />
	<c:set var="totalReleases" value="0" />
	<c:set var="totalExpenditure" value="0" />
	<c:forEach items="${releasesVsExpenditureSchemeWiseList}" var="detailsItem" varStatus="detailsStatus">
	<c:set var="detailsIndex" value="${detailsStatus.index}" />
	
	
	
	<c:if test="${detailsItem.typeOfAssetCode != typeOfAssetCode && typeOfAssetCode!=''}">
	<tr style="font-family:Georgia;color:red">
	<td  colspan="2" align="left" style="font-family:Georgia;color:red"><b>Total: <b></td>
	<td><c:out value="${totalReleases}" /></td>
	<td><c:out value="${totalExpenditure}" /></td>
	<c:set var="totalReleases" value="0"/>
	<c:set var="totalExpenditure" value="0"/>
	</tr>
	</c:if>
	
	<c:if test="${detailsItem.typeOfAssetCode != typeOfAssetCode}">
	<c:set var="typeOfAssetCode" value="${detailsItem.typeOfAssetCode}" />
	<tr class="<c:out value='row1'/>">
	<td bgcolor="lightyellow" colspan="6" align="center" style="font-family:Georgia"><b>Scheme: <c:out value="${detailsItem.typeOfAssetName}"/><b></td>
</tr>
	</c:if>
	<tr>
	
	<td colspan="6">
	
	<tr class="<c:out value='row1'/>" >
	<td><a href="switch.do?prefix=/fundAccounting&page=/releasesVsExpenditureWorkWise.do&mode=init&selectedWorkId=<c:out value="${detailsItem.workId}"/>#at<c:out value="${detailsItem.workId}"/>" style="color:black">
	<c:out value="${detailsItem.workId}"/></a></td>
	<td><a href="switch.do?prefix=/fundAccounting&page=/releasesVsExpenditureWorkWise.do&mode=init&selectedWorkId=<c:out value="${detailsItem.workId}"/>#at<c:out value="${detailsItem.workId}"/>" style="color:black">
	<c:out value="${detailsItem.workName}"/></a></td>
	
	<td><c:out value="${detailsItem.totalReleases}"/></td>
	<td><c:out value="${detailsItem.totalExpenditure}"/></td>
	
	<c:if test="${detailsItem.typeOfAssetCode == typeOfAssetCode}" >
	<c:set var="totalReleases" value="${totalReleases+detailsItem.totalReleases}"/>
	<c:set var="totalExpenditure" value="${totalExpenditure+detailsItem.totalExpenditure}"/>
	</c:if>
	
	</tr>
	
	
	
	</c:forEach>	

	<tr style="font-family:Georgia;color:red">
	<td  colspan="2" align="left" style="font-family:Georgia;color:red"><b>Total: <b></td>
	<td><c:out value="${totalReleases}" /></td>
	<td><c:out value="${totalExpenditure}" /></td>
	</tr>
</table>

</td></tr></table>

<%@ include file="/commons/rws_footer.jsp"%>