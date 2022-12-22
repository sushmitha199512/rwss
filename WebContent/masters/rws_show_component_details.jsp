<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="http://java.sun.com/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="/WEB-INF/rws-tags.tld" prefix="rws"%>

<html>
<head>
<title><bean:message key="app.title" /></title>
<link rel="stylesheet" type="text/css" href="<rws:context page='/resources/style/rwsstyle.css'/>">
<link rel="stylesheet" type="text/css" href="<rws:context page='/resources/style/theme1.css'/>">
</head>

<body bgcolor="#edf2f8" topmargin="0" leftmargin="0">

<table cellpadding="2" cellspacing="0" width="100%"
	   border="1" bordercolor="#000000" style="border-collapse: collapse">
<% int count=0;%>
<c:if test="${requestScope.value=='handpumps'}" > 
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
	<th><bean:message key="app.sno"/></th>
	<th><bean:message key="app.assetCode"/></th>
	<th><bean:message key="app.pumpCode"/></th>
	<th><bean:message key="app.assetName"/></th>
	<th><bean:message key="app.location"/></th>
	<th><bean:message key="app.commissionDate"/></th>
	<th><bean:message key="app.yield"/>(l.p.m)</th>
	<th><bean:message key="app.status"/></th>
	<th><bean:message key="app.assetCost"/><br>(Rs. in lakhs)</th>
	<th><bean:message key="app.startYear"/></th>
	
	 <th>Water Quality</th>
	 <th>Flouride %</th>
	 <th>Brakish %</th>
	 <th>Iron %</th>
	 <th>Other Contamination Type</th>
	 <th>Other Contamination %</th>
	 
</tr>	
</thead>
<tbody class="gridText">
<c:forEach items="${components}" var="item" varStatus="status">
<c:set var="index" value="${status.index}" />
 	  <%count=count+1; %>
<tr class="row<c:out value='${index%2}'/>">
	<td><c:out value="${index+1}"/></td>
	<td><c:out value="${item.assetCode}"/></td>
	<td><c:out value="${item.schemeCode}"/></td>
	<td><c:out value="${item.assetName}"/></td>
	<td><c:out value="${item.location}"/></td>
	<td align="center"><c:out value="${item.dateofCreation}"/></td>
	<td><c:out value="${item.pyield}"/></td>
	<td align="right"><c:out value="${item.assetStatus}"/></td>

	<td align="right">
		<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
					  	  value="${item.assetCost}" />&nbsp;
	</td>
	<td align="center"><c:out value="${item.startYear}"/></td>
	<td><c:out value="${item.waterQuality}"/></td>
	<td><c:out value="${item.flouride}"/></td>
	<td><c:out value="${item.brakish}"/></td>
	<td><c:out value="${item.iron}"/></td>
	<td><c:out value="${item.othersType}"/></td>
	<td><c:out value="${item.others}"/></td>
	 
</tr>
</c:forEach>
</tbody>
<tfoot class="gridLabel"> 
<tr bgcolor="#8A9FCD">
	<th colspan="20" align="left">
		Total No. of Assets:&nbsp;<c:out value="${index+1}"/>
	</th>
</tr>
</tfoot>
</c:if>
<%if(count==0){ %>
   <tfoot align="center" class="gridLabel"> 
	<tr bgcolor="#8A9FCD">
	<th align="center" colspan="20" align="left">
		There Are No Records
	</th>
	</tr>
   </tfoot>	
<%} %>
</table>
</body>
</html>