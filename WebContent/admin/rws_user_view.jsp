<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<script>
/* function fnConfirmSave(url)
{
    var properties="width=728,height=622,toolbar=0,top=25,left=25,status=yes,menubar=no,location=no,directories=no scrollbars=no,copyhistory=no,resizable=1";
    newWindow1 = window.open(url, "_Self", properties);
} */
function fnConfirmDeletes(url)
{
	var url1 = "/pred/admin/userDeleteConfirmation.jsp?userId="+url;
     var properties="width=500,height=450,toolbar=0,status=yes,menubar=no,location=no,directories=no,scrollbars=no,copyhistory=no,resizable=1";
    newWindow1 = window.open(url1, "_New", properties);
}
</script>
<table width="98%" align="center" border="0" bordercolor="#8A9FCD" style="border-collapse:collapse">
<thead>
<tr>
	<td align="right">
		<a href="<rws:context page='/home.jsp'/>">Home</a>&nbsp;|&nbsp;
		<a href="switch.do?prefix=/admin&page=/UserManagementData.do">Back</a>&nbsp;|&nbsp;
		<a href="switch.do?prefix=/admin&page=/EditUser.do&mode=Print" target="_new">Print</a>&nbsp;|&nbsp;
		<a href="switch.do?prefix=/admin&page=/EditUser.do&mode=Excel" target="_new">Excel</a>
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
	<td width="120">User Id</td>
	<td width="100">Designation</td>
	<td width="180">Office</td>
	<td width="160">Account Activation Date</td>
	<td>Modules</td>
	<td>Permissions</td>
	<td width="80">Action</td>
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
	<td align="center" nowrap>
		<a  id="save" href="./switch.do?prefix=/admin&page=/EditUser.do&mode=Edit&userId=<c:out value='${item.userid}'/>"  >Edit</a> &nbsp;|&nbsp;
	<a href="#" id="delete" onclick=" fnConfirmDeletes('<c:out value='${item.userid}'/>')">Delete</a> 
	</td>
</tr>
</c:forEach>	
</tbody>
</table>
<%@ include file="/commons/rws_footer.jsp"%>
<rws:alert />