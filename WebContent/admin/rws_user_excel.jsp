<%@page contentType="application/vnd.ms-excel" %>
<%@ include file="/commons/rws_header1.jsp"%>
</head>
<body>

<table width="98%" align="center" border="0" bordercolor="#000000" style="border-collapse:collapse">
<thead>
<tr>
	<td align="right">
		
	</td>
</tr>	
</thead>
<tbody bgcolor="#8A9FCD">
<tr>
	<td class="printTitle">User List</td>
</tr>
</tbody>
</table>
<table width="98%" align="center" border="1" bordercolor="#000000" style="border-collapse:collapse">
<thead class="printHead">
<tr>
	<td>S.No.</td>
	<td>User Id</td>
	<td>Designation</td>
	<td>Office</td>
	<td>Account Activation Date</td>
	<td>Modules</td>
	<td>Permissions</td>
</tr>
</thead>
<tbody class="printBody">
<c:forEach items="${requestScope.users}" var="item" varStatus="status">
<c:set var="index" value="${status.index}" />
<tr>
	<td><c:out value="${index+1}"/></td>
	<td nowrap><c:out value="${item.userid}"/></td>
	<td><c:out value="${item.designation}"/></td>
	<td nowrap><c:out value="${item.officeName}"/></td>
	<td align="center"><c:out value="${item.accountActivationDate}" /></td>
	<td nowrap>
		<c:if test="${not empty item.proposals}">
			<c:out value="${item.proposals}"/>
		</c:if>
		<c:if test="${not empty item.estimates}">
			<br><c:out value="${item.estimates}"/>
		</c:if>
		<c:if test="${not empty item.waterquality}">	
			<br><c:out value="${item.waterquality}"/>
		</c:if>
		<c:if test="${not empty item.contractor}">	
			<br><c:out value="${item.contractor}"/>
		</c:if>	
		<c:if test="${not empty item.works}">
			<br><c:out value="${item.works}"/>
		</c:if>	
		<c:if test="${not empty item.assets}">
			<br><c:out value="${item.assets}"/>
		</c:if>	
		<c:if test="${not empty item.funds}">
			<br><c:out value="${item.funds}"/>
		</c:if>	
		<c:if test="${not empty item.masters}">
			<br><c:out value="${item.masters}"/>
		</c:if>	
	</td>
	<td nowrap>
		<c:if test="${not empty item.read}">
			<c:out value="${item.read}"/>
		</c:if>
		<c:if test="${not empty item.write}">
			<br><c:out value="${item.write}"/>
		</c:if>
		<c:if test="${not empty item.delete}">	
			<br><c:out value="${item.delete}"/>
		</c:if>
	</td>
</tr>
</c:forEach>	
</tbody>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
<rws:alert />