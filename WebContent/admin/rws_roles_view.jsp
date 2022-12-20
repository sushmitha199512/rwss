<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>

<table width="90%" align="center" border="0" bordercolor="#8A9FCD" style="border-collapse:collapse">
<thead>
<tr>
	<td align="right">
		<a href="<rws:context page='/home.jsp'/>">Home</a>&nbsp;|&nbsp;
		<a href="switch.do?prefix=/admin&page=/UserRolesData.do">Back</a>&nbsp;|&nbsp;
		<a href="switch.do?prefix=/admin&page=/EditRoles.do&mode=Print" target="_new">Print</a>&nbsp;|&nbsp;
		<a href="switch.do?prefix=/admin&page=/EditRoles.do&mode=Excel" target="_new">Excel</a>
	</td>
</tr>	
</thead>
<tbody bgcolor="#8A9FCD">
<tr>
	<td class="reportTitle">User Roles List</td>
</tr>
</tbody>
</table>
<table width="90%" align="center" border="1" bordercolor="#8A9FCD" style="border-collapse:collapse">
<thead class="reportHead">
<tr>
	<td>S.No.</td>
	<td><bean:message key="app.roleId" /></td>
	<td><bean:message key="app.roleName" /></td>
	<td><bean:message key="app.roleDesc" /></td>
	<td><bean:message key="app.action" /></td>
</tr>
</thead>
<tbody class="reportBody">
<c:forEach items="${requestScope.roles}" var="item" varStatus="status">
<c:set var="index" value="${status.index}" />
<tr>
	<td><c:out value="${index+1}"/></td>
	<td nowrap><c:out value="${item.roleId}"/></td>
	<td><c:out value="${item.roleName}"/></td>
	<td><c:out value="${item.roleDesc}"/></td>
	<td nowrap align="center">
		<a href="switch.do?prefix=/admin&page=/EditRoles.do&mode=Edit&roleId=<c:out value='${item.roleId}'/>" id="edit">Edit</a>&nbsp;|&nbsp;<a href="switch.do?prefix=/admin&page=/EditRoles.do&mode=Delete&roleId=<c:out value='${item.roleId}'/>" id="delete" onclick="return fnConfirmDelete()">Delete</a> 
	</td>
</tr>
</c:forEach>	
</tbody>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
<rws:alert />