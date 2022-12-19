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

 <% int count=0;%>
 

<table cellpadding="2" cellspacing="0" width="100%"
   border="1" bordercolor="#000000" style="border-collapse: collapse">
 <c:if test="${requestScope.value=='ponds'}" > 
	  <%count=count+1; %>
	 <thead class="gridLabel">
     <tr bgcolor="#8A9FCD">
	 <th><bean:message key="app.sno"/></th>
	 <th><bean:message key="app.habCode"/></th>
	
	 <th><bean:message key="app.pondCode"/></th>
	 <th><bean:message key="app.pondName"/></th>
	 <th><bean:message key="app.location"/></th>
	 <th><bean:message key="app.size"/>(sq mts)</th>
	 <th><bean:message key="app.volume"/>(cubic mts)</th>
	
	 
	 <th>Water Quality</th>
	 <th>Flouride %</th>
	 <th>Brakish %</th>
	 <th>Iron %</th>
	 <th>Other Contamination Type</th>
	 <th>Other Contamination %</th>
	 
     </tr>	
      </thead>
	 <tbody class="gridText">
	  <c:forEach items="${ponds}" var="item" varStatus="status">
      <c:set var="index" value="${status.index}" />
      
    <tr class="row<c:out value='${index%2}'/>">
	<td><c:out value="${index+1}"/></td>
	<td><c:out value="${item.habCode}"/></td>
	
	<td><c:out value="${item.pondCode}"/></td>
	<td><c:out value="${item.pondName}"/></td>
	<td><c:out value="${item.location}"/></td>
	<td><c:out value="${item.pondSize}"/></td>
	<td><c:out value="${item.pondVolume}"/></td>
	
	
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
	<th colspan="15" align="left">
		Total No. of Ponds:&nbsp;<c:out value="${index+1}"/>
	</th>
</tr>
</tfoot>
</c:if>
<!-- 
  <c:if test="${requestScope.value=='dwtanks'}" > 
	  <%count=count+1; %>
	 <thead class="gridLabel">
     <tr bgcolor="#8A9FCD">
	 <th><bean:message key="app.sno"/></th>
	 <th><bean:message key="app.habCode"/></th>
	 <th><bean:message key="app.habitation"/></th>
	 <th><bean:message key="app.tankCode"/></th>
	 <th><bean:message key="app.tankName"/></th>
	 <th><bean:message key="app.location"/></th>
	 <th><bean:message key="app.size"/></th>
	 <th><bean:message key="app.volume"/></th>
	 <th><bean:message key="app.pondService"/></th> 
     </tr>	
      </thead>
	 <tbody class="gridText">
	  <c:forEach items="${dwtanks}" var="item" varStatus="status">
      <c:set var="index" value="${status.index}" />
      
    <tr class="row<c:out value='${index%2}'/>">
	<td><c:out value="${index+1}"/></td>
	<td><c:out value="${item.habCode}"/></td>
	<td><c:out value="${item.habName}"/></td>
	<td><c:out value="${item.pondCode}"/></td>
	<td><c:out value="${item.pondName}"/></td>
	<td><c:out value="${item.location}"/></td>
	<td><c:out value="${item.pondSize}"/></td>
	<td><c:out value="${item.pondVolume}"/></td>
	<td><c:out value="${item.pondServiceMonths}"/></td>
 	 
</tr>
</c:forEach>
</tbody>

<tfoot class="gridLabel"> 
<tr bgcolor="#8A9FCD">
	<th colspan="12" align="left">
		Total No. of DW Tanks:&nbsp;<c:out value="${index+1}"/>
	</th>
</tr>
</tfoot>
</c:if> 
 -->
<c:if test="${requestScope.value=='shallowhandpumps'}" > 
	  <%count=count+1; %>
	 <thead class="gridLabel">
     <tr bgcolor="#8A9FCD">
	 <th><bean:message key="app.sno"/></th>
	 <th><bean:message key="app.habCode"/></th>
	
	 <th>Shallow Hand Pump Code</th>
	 <th>Location</th>
	 <th>Diameter</th>
	 <th>Depth</th>
	 <th>Hygiene</th>
	 <th>Average Hours</th> 
	 <th>Average Time</th> 
	 <th>Yield</th> 
	 <th>Water Quality</th> 
	 <th>Flouride %</th> 
	 <th>Brakish %</th> 
	 <th>Iron %</th> 
	 <th>Other Contamination Type</th>
 	 <th>Other Contamination %</th> 
	 
     </tr>	
      </thead>
	 <tbody class="gridText">
	  <c:forEach items="${shallowhandpumps}" var="item" varStatus="status">
      <c:set var="index" value="${status.index}" />
      
    <tr class="row<c:out value='${index%2}'/>">
	<td><c:out value="${index+1}"/></td>
	<td><c:out value="${item.habCode}"/></td>
	
	
	<td><c:out value="${item.shpCode}"/></td>
	<td><c:out value="${item.shpLocation}"/></td>
	<td><c:out value="${item.shpDiameter}"/></td>
	<td><c:out value="${item.shpDepth}"/></td>
	<td><c:out value="${item.shpHygiene}"/></td>
	<td><c:out value="${item.shpAvgHours}"/></td>
	<td><c:out value="${item.shpAvgTime}"/></td>
	<td><c:out value="${item.shpYield}"/></td>
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
	<th colspan="16" align="left">
		Total No. of DW Tanks:&nbsp;<c:out value="${index+1}"/>
	</th>
</tr>
</tfoot>
</c:if> 


<c:if test="${requestScope.value=='openwells'}" > 
	  <%count=count+1; %>
	 <thead class="gridLabel">
     <tr bgcolor="#8A9FCD">
	 <th><bean:message key="app.sno"/></th>
	 <th><bean:message key="app.habCode"/></th>
	
	 <th><bean:message key="app.openwellCode"/></th>
	 <th><bean:message key="app.location"/></th>
	 <th><bean:message key="app.diameter"/></th>
	 <th><bean:message key="app.depth"/></th>
	 <th><bean:message key="app.minwl"/></th>
	 <th><bean:message key="app.maxwl"/></th>
	 
	 <th>Water Quality</th>
	 <th>Flouride %</th>
	 <th>Brakish %</th>
	 <th>Iron %</th>
	 <th>Other Contamination Type</th>
	 <th>Other Contamination %</th>
     </tr>	
      </thead>
	 <tbody class="gridText">
	  <c:forEach items="${openwells}" var="item" varStatus="status">
      <c:set var="index" value="${status.index}" />
      
    <tr class="row<c:out value='${index%2}'/>">
	<td><c:out value="${index+1}"/></td>
	<td><c:out value="${item.habCode}"/></td>
	<td><c:out value="${item.owCode}"/></td>
	<td><c:out value="${item.owLocation}"/></td>
	<td><c:out value="${item.owDiameter}"/></td>
	<td><c:out value="${item.owDepth}"/></td>
	<td><c:out value="${item.owMinwl}"/></td>
	<td><c:out value="${item.owMaxwl}"/></td>
	
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
	<th colspan="15" align="left">
		Total No. of Open Wells:&nbsp;<c:out value="${index+1}"/>
	</th>
</tr>
</tfoot>
</c:if> 


 <c:if test="${requestScope.value=='CPWS'}" > 
  <%count=count+1; %>
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
	<th><bean:message key="app.sno"/></th>
	<th><bean:message key="app.assetCode"/></th>
	<th><bean:message key="app.schemeCode"/></th>
	<th><bean:message key="app.glsrCount"/></th>
	<th><bean:message key="app.glbrCount"/></th>
	<th><bean:message key="app.ohsrCount"/></th>
	<th><bean:message key="app.ohbrCount"/></th>
	<th><bean:message key="app.assetName"/></th>
	<th><bean:message key="app.location"/></th>
	<th><bean:message key="app.commissionDate"/></th>
	<th><bean:message key="app.status"/></th>
	<th><bean:message key="app.assetCost"/><br>(Rs. in lakhs)</th>
	<th><bean:message key="app.startYear"/></th>
	<th><bean:message key="app.endYear"/></th>
	 
</tr>	
</thead>
<tbody class="gridText">
<c:forEach items="${CPWS}" var="item" varStatus="status">
<c:set var="index" value="${status.index}" />
 
<tr class="row<c:out value='${index%2}'/>">
	<td><c:out value="${index+1}"/></td>
	<td><c:out value="${item.assetCode}"/></td>
	<td><c:out value="${item.schemeCode}"/></td>
	<td><c:out value="${item.glsrCount}"/></td>
	<td><c:out value="${item.glbrCount}"/></td>
	<td><c:out value="${item.ohsrCount}"/></td>
	<td><c:out value="${item.ohbrCount}"/></td>
	<td><c:out value="${item.assetName}"/></td>
	<td><c:out value="${item.location}"/></td>
	<td><c:out value="${item.dateofCreation}"/></td>
	<td><c:out value="${item.assetStatus}"/></td>
	<td align="right">
		<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
					  	  value="${item.assetCost}" />&nbsp;
	</td>
	<td align="center"><c:out value="${item.startYear}"/></td>
		<td align="center"><c:out value="${item.endYear}"/></td>
	 
</tr>
</c:forEach>
</tbody>
 
<tfoot class="gridLabel"> 
<tr bgcolor="#8A9FCD">
	<th colspan="15" align="left">
		Total No. of Assets:&nbsp;<c:out value="${index+1}"/> 
	</th>
</tr>
</tfoot>
 </c:if>

 <c:if test="${requestScope.value=='PWS'}" > 
  <%count=count+1; %>
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
	<th><bean:message key="app.sno"/></th>
	<th><bean:message key="app.assetCode"/></th>
	<th><bean:message key="app.schemeCode"/></th>
	<th><bean:message key="app.glsrCount"/></th>
	<th><bean:message key="app.ohsrCount"/></th>
	<th><bean:message key="app.assetName"/></th>
	<th><bean:message key="app.location"/></th>
	<th><bean:message key="app.commissionDate"/></th>
	<th><bean:message key="app.status"/></th>
	<th><bean:message key="app.assetCost"/><br>(Rs. in lakhs)</th>
	<th><bean:message key="app.startYear"/></th>
	<th><bean:message key="app.endYear"/></th>
	 
</tr>	
</thead>
<tbody class="gridText">
<c:forEach items="${PWS}" var="item" varStatus="status">
<c:set var="index" value="${status.index}" />
 
<tr class="row<c:out value='${index%2}'/>">
	<td><c:out value="${index+1}"/></td>
	<td><c:out value="${item.assetCode}"/></td>
	<td><c:out value="${item.schemeCode}"/></td>
	<td><c:out value="${item.glsrCount}"/></td>
	<td><c:out value="${item.ohsrCount}"/></td>
	<td><c:out value="${item.assetName}"/></td>
	<td><c:out value="${item.location}"/></td>
	<td><c:out value="${item.dateofCreation}"/></td>
	<td><c:out value="${item.assetStatus}"/></td>
	<td align="right">
		<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
					  	  value="${item.assetCost}" />&nbsp;
	</td>
	<td align="center"><c:out value="${item.startYear}"/></td>
		<td align="center"><c:out value="${item.endYear}"/></td>
	 
</tr>
</c:forEach>
</tbody>
 
<tfoot class="gridLabel"> 
<tr bgcolor="#8A9FCD">
	<th colspan="12" align="left">
		Total No. of Assets:&nbsp;<c:out value="${index+1}"/> 
	</th>
</tr>
</tfoot>
 </c:if>


<c:if test="${requestScope.value=='MPWS'}" > 
  <%count=count+1; %>
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
	<th><bean:message key="app.sno"/></th>
	<th><bean:message key="app.assetCode"/></th>
	<th><bean:message key="app.schemeCode"/></th>
	<th><bean:message key="app.glsrCount"/></th>
	<th><bean:message key="app.ohsrCount"/></th>
	<th><bean:message key="app.assetName"/></th>
	<th><bean:message key="app.location"/></th>
	<th><bean:message key="app.commissionDate"/></th>
	<th><bean:message key="app.status"/></th>
	<th><bean:message key="app.assetCost"/><br>(Rs. in lakhs)</th>
	<th><bean:message key="app.startYear"/></th>
	<th><bean:message key="app.endYear"/></th>
	 
</tr>	
</thead>
<tbody class="gridText">
<c:forEach items="${MPWS}" var="item" varStatus="status">
<c:set var="index" value="${status.index}" />
 
<tr class="row<c:out value='${index%2}'/>">
	<td><c:out value="${index+1}"/></td>
	<td><c:out value="${item.assetCode}"/></td>
	<td><c:out value="${item.schemeCode}"/></td>
	<td><c:out value="${item.glsrCount}"/></td>
	<td><c:out value="${item.ohsrCount}"/></td>
	<td><c:out value="${item.assetName}"/></td>
	<td><c:out value="${item.location}"/></td>
	<td><c:out value="${item.dateofCreation}"/></td>
	<td><c:out value="${item.assetStatus}"/></td>
	<td align="right">
		<fmt:formatNumber maxFractionDigits="2" minFractionDigits="2" 
					  	  value="${item.assetCost}" />&nbsp;
	</td>
	<td align="center"><c:out value="${item.startYear}"/></td>
		<td align="center"><c:out value="${item.endYear}"/></td>
	 
</tr>
</c:forEach>
</tbody>
 
<tfoot class="gridLabel"> 
<tr bgcolor="#8A9FCD">
	<th colspan="12" align="left">
		Total No. of Assets:&nbsp;<c:out value="${index+1}"/> 
	</th>
</tr>
</tfoot>
 </c:if>


<%if(count==0){ %>
   <script>
   alert("No details available.");
   window.close();
</script>   
<%} %>

 
</table><br> <center>
   <html:reset title="Close the Window" styleClass="btext" value="Close" onclick="javascript:window.close()"/></center>
</body>
</html>