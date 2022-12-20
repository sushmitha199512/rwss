<%@ include file="/commons/rws_header1.jsp" %>
<script>
<!--
function fnSave(frm)
{
	if(document.forms[0].number.value!="")
	{
	if(fnConfirmUpdate())
	{
		if(validateEditUserForm(frm))
			return true;
	}
	}
	else
	{
		alert("Please Enter Security Code");
	}
	return false;	

}
//-->
</script>
<html:javascript formName="EditUserForm" />

<%@ include file="/commons/rws_header2.jsp" %>

<html:form action="/EditUser">
<% 
	String csrfToken="";
	nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
	csrfToken = valUtil.getCSRFCode();
	session.setAttribute("csrfToken",csrfToken);
%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
<table align="center" cellpadding="0" cellspacing="0">

<thead>
<tr>
	<td>
		<jsp:include page="/commons/TableHeader.jsp">
			<jsp:param name="TableName" value="User Edit Form" />
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
<tr>
<td>
	<fieldset>
	<legend><bean:message key="legend.rwsOffices"/></legend>
	<label>
	<table width="100%" class="formTbody">
	<tr>
		<td><bean:message key="app.headOffice" /><span class="mandatory">*</span></td>
		<td><html:text property="headOfficeName" styleClass="thin-text-box" readonly="true"/></td>
		<td><bean:message key="app.circleOffice" /></td>
		<td><html:text property="circleOfficeName" styleClass="thin-text-box" readonly="true"/></td>
	</tr>
	<tr>	
		<td><bean:message key="app.division" /></td>
		<td><html:text property="divisionOfficeName" styleClass="thin-text-box" readonly="true"/></td>
		<td><bean:message key="app.subdivision" /></td>
		<td><html:text property="subdivisionOfficeName" styleClass="thin-text-box" readonly="true"/></td>
	</tr>
	
	<tr>
	<td><bean:message key="app.mandal" /></td>
		<td><html:text property="mandal" styleClass="thin-text-box" readonly="true"/></td>
	</tr>
	
	</table>
	</label>
	</fieldset>
</td>
</tr>
<tr>
<td>
	<fieldset>
	<legend><bean:message key="legend.personalInformation" /></legend>
	<label>
	<table class="formTbody">
	<tr>
		<td><bean:message key="app.designation" /><span class="mandatory">*</span></td>
		<td>
			<html:text property="designationCode" styleClass="thin-text-box" readonly="true" />
		</td>
	</tr>
	<tr>
		<td><bean:message key="app.userid" /><span class="mandatory">*</span></td>
		<td><html:text property="userId" styleClass="thin-text-box" maxlength="25" readonly="true"/></td>
	</tr>
	<tr>
		<td><bean:message key="app.hint" /></td>
		<td><html:textarea property="hint" styleClass="thin-text-box" /></td>
	</tr>
	</table>
	</label>
	</fieldset>
</td>
</tr>

<tr>
<td>
	<fieldset>
	<legend><bean:message key="legend.modules"/></legend>
	<label>
	<table class="formTbody">
	<tr>
		<td><html:checkbox property="proposals" value="1"/></td>
		<td nowrap><bean:message key="app.module.proposals" /></td>
		<td><html:checkbox property="estimates" value="1" /></td>
		<td nowrap><bean:message key="app.module.estimates" /></td>
		<td><html:checkbox property="waterquality" value="1" /></td>
		<td nowrap><bean:message key="app.module.waterquality" /></td>
	</tr>
	<tr>
		<td><html:checkbox property="contractor" value="1"/></td>
		<td nowrap><bean:message key="app.module.contractor" /></td>
		<td><html:checkbox property="works" value="1"/></td>
		<td nowrap><bean:message key="app.module.works" /></td>
		<td><html:checkbox property="assets" value="1"/></td>
		<td nowrap><bean:message key="app.module.assets" /></td>
	</tr>
	<tr>
		<td><html:checkbox property="funds" value="1"/></td>
		<td nowrap><bean:message key="app.module.funds" /></td>
		<td><html:checkbox property="masters" value="1"/></td>
		<td nowrap><bean:message key="app.module.masters" /></td>
	</tr>
	</table>
	</label>
	</fieldset>
</td>
</tr>

<tr>
<td>
	<fieldset>
	<legend><bean:message key="legend.permissions" /></legend>
	<label>
	<table class="formTbody">
	<tr>
		<td><html:checkbox property="read" value="1"/></td>
		<td nowrap><bean:message key="app.read" /></td>
		<td><html:checkbox property="write" value="1"/></td>
		<td nowrap><bean:message key="app.write" /></td>
		<td><html:checkbox property="del" value="1"/></td>
		<td nowrap><bean:message key="app.delete" /></td>
	</tr>
	</table>
	</label>
	</fieldset>
</td>
</tr>
	<tr><td>
<fieldset>
	<legend>Security Code</legend>
	<label>
	<div  id="captcha"><%@include file="./Captcha/form.jsp"%></div>
	</label>
	</fieldset></td></tr>
<tr>
	<td colspan="2" align="center">
		<html:submit property="mode" title="Save the Fields" styleClass="btext" onclick="return fnSave(this.form)">
			<bean:message key="button.save" />
		</html:submit>
		<html:reset title="Clear all the Fields" styleClass="btext">
			<bean:message key="button.clear" />
		</html:reset>
	</td>
</tr>	
</table>

</td>
</tr>
</tbody>

</table>
</html:form>
<%@ include file="/commons/rws_footer.jsp" %>
<rws:alert />