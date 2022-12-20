<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_user_restriction.jsp"%>
<html:javascript formName="priorityForm" />
<%@ include file="/commons/rws_header2.jsp"%>
<script>
	function autocompletion() {
		// alert("auto comp");
		for (i = 0; i < document.forms.length; i++) {
			document.forms[i].setAttribute("AutoComplete", "off");
		}
	}
</script>
<body onload="autocompletion()">
	<html:form action="Priority.do">

		<jsp:include page="/commons/TableHeader.jsp">
			<jsp:param name="TableName" value="Priority Entry Form" />
			<jsp:param name="TWidth" value="300" />
		</jsp:include>

		<table bgcolor="#DEE3E0" bordercolor="#8A9FCD" rules="cols" border="1"
			style="border-collapse: collapse;" width="340">
			<tr>
				<td>
					<table border=0 width="330" align=center
						style="margin-bottom: 5; margin-top: 5">
						<tr>
							<td class="bwborder"><FONT class=myfontclr><bean:message
										key="app.priorityCode" /><font color="#FF6666">*</font></FONT></td>
							<td><html:text property="priorityCode"
									value="<%=(String) request.getAttribute(\"code\")%>"
									styleClass="mytext" />
						</tr>
						<tr>
							<td class="bwborder"><FONT class=myfontclr><bean:message
										key="app.priorityDesc" /><font color="#FF6666">*</font></FONT></td>
							<td><html:text property="priorityDesc" value=""
									styleClass="mytext" /></td>
						</tr>
						<tr>
							<td class="bwborder"><FONT class=myfontclr><bean:message
										key="app.priorityFrom" /><font color="#FF6666">*</font></FONT></td>
							<td><html:text property="priorityFrom" value=""
									styleClass="mytext" /></td>
						</tr>
					</table>
					<% 
			String csrfToken="";
			nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
			csrfToken = valUtil.getCSRFCode();
			session.setAttribute("csrfToken",csrfToken);
		%>
<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
			<tr>
				<td colspan="2" align="center"><html:submit property="mode"
						title="Save the Fields" styleClass="btext" value="Save"
						onclick="return validatePriorityForm(priorityForm)" /> <html:reset
						title="Clear all the Fields" styleClass="btext" value="Reset" />
					<html:submit property="mode" title="view the Fields"
						styleClass="btext" value="View" /></td>
			</tr>
		</table>

		<jsp:include page="/commons/TableFotter.jsp">
			<jsp:param name="TWidth" value="300" />
		</jsp:include>

	</html:form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>


