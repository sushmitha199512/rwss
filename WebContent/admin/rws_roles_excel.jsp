<%@page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>
</head>
<body>
<table width="90%" align="center" border="0" bordercolor="#000000" style="border-collapse:collapse">
<tbody>
<tr>
	<td class="printTitle">User Roles List</td>
</tr>
</tbody>
</table>
<table width="90%" align="center" border="1" bordercolor="#000000" style="border-collapse:collapse">
<thead class="printHead">
<tr>
	<td>S.No.</td>
	<td><bean:message key="app.roleId" /></td>
	<td><bean:message key="app.roleName" /></td>
	<td><bean:message key="app.roleDesc" /></td>
</tr>
</thead>
<tbody class="printBody">
<c:forEach items="${requestScope.roles}" var="item" varStatus="status">
<c:set var="index" value="${status.index}" />
<tr>
	<td><c:out value="${index+1}"/></td>
	<td nowrap><c:out value="${item.roleId}"/></td>
	<td><c:out value="${item.roleName}"/></td>
	<td><c:out value="${item.roleDesc}"/></td>
</tr>
</c:forEach>	
</tbody>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
<rws:alert />