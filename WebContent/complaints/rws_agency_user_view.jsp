<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>

<table width="98%" align="center" border="0" bordercolor="#8A9FCD" style="border-collapse:collapse">
<thead>
<tr>
	<td align="right">
		<a href="<rws:context page='/home.jsp'/>">Home</a>&nbsp;|&nbsp;
		<a href="switch.do?prefix=/complaints&page=/UserAgencyData.do">Back</a>
	</td>
</tr>	
</thead>
<tbody bgcolor="#8A9FCD">
<tr>
	<td class="reportTitle">User List</td>
</tr>
</tbody>
</table>
<table width="98%" align="center" border="1" bordercolor="#8A9FCD" style="border-collapse:collapse">
<thead class="reportHead">
<tr>
	<td width="40">S.No.</td>
	<td width="120">Agency Name</td>
	<td width="100">District</td>
	<td width="180">Area</td>
	<td width="160">ModuleAccess</td>
	<td>Name</td>
	<td>Mobile numbers</td>
	<!-- <td width="80">Action</td> -->
</tr>
</thead>
<tbody class="reportBody">
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
	
	<%-- <td align="center" nowrap>
		<a href="#" id="save" onclick=" fnConfirmSave('switch.do?prefix=/admin&page=/EditUser.do&mode=Edit&userId=<c:out value='${item.userid}'/>')">Edit</a> &nbsp;|&nbsp;
		<a href="#" id="delete" onclick=" fnConfirmDeletes('<c:out value='${item.userid}'/>')">Delete</a> 
	</td> --%>
</tr>
</c:forEach>	
</tbody>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
<rws:alert />