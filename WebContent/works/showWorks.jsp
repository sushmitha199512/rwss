<%@ include file="/commons/rws_SpecialHeader.jsp" %>
<head>

<body bgcolor="#edf2f8" leftmargin="0" topmargin="0">
<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="black" 
	   style="border-collapse:collapse;display:block">
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
    <th>Sno </th>
	<th>Work ID</th>
	<th>Work Name</th>
	<th>Admn No</th>
	<th>Admn Date</th>
	<th>Sanction Amount</th>
	<th>Hab Count</th>
	<th>Program Name</th>
	<th>Sub Program Name</th>
	
	
	
</tr>
</thead>
<tbody class="gridText">
<%int rcount=1; %>
	<c:forEach items="${requestScope.selectedWorks}" var="item" varStatus="status">
	<c:set var="index" value="${status.index}"/>
	<tr class="<c:out value='row${index%2}'/>">
		<td><%=rcount++%></td>
		<td><c:out value='${item.workid}'/></td>
		<td><c:out value='${item.workname}'/></td>
		<td><c:out value='${item.billNo}'/></td>
		<td><c:out value='${item.sanctiondt}'/></td>
		<td><c:out value='${item.sanctionamount}'/></td>
		<td><c:out value='${item.noofhabs}'/></td>
		<td><c:out value='${item.progName}'/></td>
		<td><c:out value='${item.subprogName}'/></td>		
	</tr>
	</c:forEach>
</tbody>

</table><br>
<center>
	<html:button property="mode" styleClass="btext" onclick="javascript:fnClose()">
		<bean:message key="button.close" />
	</html:button>
</center>
</body>
</html>
