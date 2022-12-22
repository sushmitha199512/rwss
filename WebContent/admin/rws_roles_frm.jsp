<%@ include file="/commons/rws_header1.jsp" %>
<script>
<!--
function fnSave(frm)
{
	if(validateUserRoleForm(frm))
		return true;
	
	return false;	
}
//-->
</script>
<html:javascript formName="UserRoleForm" />
<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="/UserRolesAction" focus="roleName">
<table align="center" cellpadding="0" cellspacing="0">

<thead>
<tr>
	<td>
		<jsp:include page="/commons/TableHeader.jsp">
			<jsp:param name="TableName" value="User Roles Form" />
			<jsp:param name="TWidth" value="100%" />
		</jsp:include>
	</td>
</tr>
</thead>

<tfoot>
<tr>
	<td>
		<jsp:include page="/commons/TableFotter.jsp">
			<jsp:param name="TWidth" value="100%" />
		</jsp:include>
	</td>
</tr>
</tfoot>

<tbody>
<tr>
<td>

<table bgcolor="#DEE3E0" border="1" bordercolor="#8A9FCD" rules="none" style="border-collapse:collapse">
<tbody class="formTBody">
<tr>
	<td><bean:message key="app.roleId" /><span class="mandatory">*</span></td>
	<td><html:text property="roleId" styleClass="thin-text-box" readonly="true" /></td>
</tr>	
<tr>
	<td><bean:message key="app.roleName" /><span class="mandatory">*</span></td>
	<td><html:text property="roleName" styleClass="thin-text-box" onkeypress="upperOnly()" /></td>
</tr>
<tr>	
	<td><bean:message key="app.roleDesc" /><span class="mandatory">*</span></td>
	<td><html:textarea property="roleDesc" styleClass="thin-text-box" onkeypress="upperOnly()"/></td>
</tr>
<tr>
	<td align="center" colspan="2">
		<html:submit property="mode" styleClass="btext" onclick="return fnSave(this.form)">
			<bean:message key="button.save" />
		</html:submit>
		<html:reset property="mode" styleClass="btext">
			<bean:message key="button.clear" />
		</html:reset>
		<html:submit property="mode" styleClass="btext">
			<bean:message key="button.view" />
		</html:submit>
		 
	</td>
</tr>
</tbody>
</table>

</td>
</tr>
</tbody>
</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp" %>