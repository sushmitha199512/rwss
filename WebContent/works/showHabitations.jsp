<%@ include file="/commons/rws_header1.jsp" %>

<head>

<body bgcolor="#edf2f8" leftmargin="0" topmargin="0">
<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#FFFFFF" 
	   style="border-collapse:collapse;display:block">
<thead class="gridLabel">
<tr bgcolor="#8A9FCD">
    <th>Sno </th>
	<th>Mandal Name</th>
	<th>Habitation Code</th>
	<th>Habitation Name</th>
	
	
	
</tr>
</thead>
<tbody class="gridText">
<%int rcount=1; %>
	<c:forEach items="${requestScope.selectedHabs}" var="item" varStatus="status">
	<c:set var="index" value="${status.index}"/>
	<tr class="<c:out value='row${index%2}'/>">
		<td><%=rcount++%></td>
		<td><c:out value='${item.mandalName}'/></td>
		<td align="center">
		<c:out value='${item.habCode}'/></td>
		<td><c:out value='${item.habName}'/></td>
		
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
