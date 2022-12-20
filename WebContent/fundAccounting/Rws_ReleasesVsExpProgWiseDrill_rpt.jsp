<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<script language="javascript">

var fromYear='<%=request.getParameter("fromYear")%>';
function getReleasesDetailRpt(programmeCode)
{
document.forms[0].action="switch.do?prefix=/fundAccounting&page=/releasesVsExpenditureProgrammeWise.do&mode=getProgWiseReleasesRpt&fromYear="+fromYear+"&programme="+programmeCode;
document.forms[0].submit();
}
function getExpDetailRpt(programmeCode)
{
document.forms[0].action="switch.do?prefix=/fundAccounting&page=/releasesVsExpenditureProgrammeWise.do&mode=getProgWiseRpt&fromYear="+fromYear+"&programme="+programmeCode;
document.forms[0].submit();
}
function getAllReleasesDetailRpt()
{
document.forms[0].action="switch.do?prefix=/fundAccounting&page=/releasesVsExpenditureProgrammeWise.do&mode=getProgWiseReleasesRpt&fromYear="+fromYear;
document.forms[0].submit();
}
function getAllExpDetailRpt()
{
document.forms[0].action="switch.do?prefix=/fundAccounting&page=/releasesVsExpenditureProgrammeWise.do&mode=getProgWiseRpt&fromYear="+fromYear;
document.forms[0].submit();
}
</script>

<html:form action="releasesVsExpenditureProgrammeWise.do">
<table border="0">
<tr><td align="right"><a href="#1" onclick="javascript:history.go(-1)">Back</a>&nbsp;|&nbsp;<a href="/pred/home.jsp">Home</a></td></tr>
<tr><td align="right"><b>Amount in Rs. Lakhs</b></td></tr>

<tr><td>
<!--<table cellpadding="1" cellspacing="0" border="1" width="100%" bordercolor="#000000" style="border-collapse: collapse;font-family:Cottonwood" >  -->

<table cellpadding="1" cellspacing="0" border="1" width="100%" bordercolor="#000000" style="border-collapse: collapse;font-family:Times Roman;font-size:12px;" >
<tr class="gridHeader">
		<td width="145"><b>Programme Code</td>
		<td width="145"><b>Programme Name</td>
		<td width="145"><b>Total Releases</td>
		<td width="145"><b>Total Expenditure</td>
		
	<c:set var="totalReleases" value="0" />
	<c:set var="totalExpenditure" value="0" />
	<c:forEach items="${releasesVsExpProgWiseList}" var="detailsItem" varStatus="detailsStatus">
	
	<tr class="<c:out value='row1'/>" >
	<td><c:out value="${detailsItem.programmeCode}"/></td>
	<td><c:out value="${detailsItem.programmeName}"/></td>
	<c:set var="totalReleases" value="${totalReleases+detailsItem.totalReleases}" />
	<c:set var="totalExpenditure" value="${totalExpenditure+detailsItem.totalExpenditure}" />
	<td><a href="#1" onclick="getReleasesDetailRpt('<c:out value="${detailsItem.programmeCode}"/>')"><c:out value="${detailsItem.totalReleases}"/></td>
	<td><a href="#1" onclick="getExpDetailRpt('<c:out value="${detailsItem.programmeCode}"/>')"><c:out value="${detailsItem.totalExpenditure}"/></a></td>
	

	
	</tr>
	</c:forEach>	
	<tr class="<c:out value='row1'/>">
	<td  colspan="2" align="left" style="font-family:Georgia"><font color=red><b>Total:</b></font></td>
	<td><a href="#1" onclick="getAllReleasesDetailRpt()"> <font color=red><b><c:out value="${totalReleases}"/></b></font></a></td>
	<td><a href="#1" onclick="getAllExpDetailRpt()"><font color=red> <c:out value="${totalExpenditure}"/></b></font></a></td>
	
	</tr>
</table>
</html:form>
</td></tr></table>

<%@ include file="/commons/rws_footer.jsp"%>