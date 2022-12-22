<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/AdminAuthorization.jsp"%>
<%@ include file="/commons/rws_generaladmin_header.jsp"%>

<script language="javascript">
	function validate() {
		if (document.forms[0].repairName.value == '') {
			alert("please Enter Repair Name ");
			return false;
		}

		else {
			document.forms[0].action = "switch.do?prefix=/masters&page=/repair.do?mode=save";
			document.forms[0].submit();
		}
	}
</script>
<html:form action="repair.do">
	<% 
		String csrfToken="";
		nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
		csrfToken = valUtil.getCSRFCode();
		session.setAttribute("csrfToken",csrfToken);
	%>
	<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
	
	<table border=0 cellspacing=0 cellpadding=0 width="50%"
		bordercolor=#000000 style="border-collapse: collapse"
		bgcolor="#ffffff" ALIGN=CENTER>
		<caption>
			<table border=0 rules=none style="border-collapse: collapse"
				align="RIGHT">
				<tr align="right">
					<td class="bwborder"><a
						href="../admin/rws_general_admn_loginsuccess.jsp">&nbsp;Back</a></td>

				</tr>
			</table>
		</caption>

	</table>
	<jsp:include page="/commons/TableHeaderWithoutClose.jsp">
		<jsp:param name="TableName" value="Repair Type Entry Form" />
		<jsp:param name="TWidth" value="300" />
	</jsp:include>

	<table bgcolor="#DEE3E0" bordercolor="#8A9FCD" rules="cols" border="1"
		style="border-collapse: collapse;" width="340">
		<tr>
			<td>
				<table border=0 width="300" align=center
					style="margin-bottom: 5; margin-top: 5">
					<tr>
						<td class=mycborder><FONT class=myfontclr>Repair
								Code:<font color="#FF6666">*</font>
						</FONT></td>
						<td class=mycborder><html:text property="repairCode"
								value="<%=(String) request.getAttribute(\"repairCode\")%>"
								styleClass="mytext" maxlength="3" readonly="true" /></td>
					</tr>
					<tr>
						<td class=mycborder><FONT class=myfontclr>Repair
								Description:<font color="#FF6666">*</font>
						</FONT></td>
						<td><html:text property="repairName" style="width:100px"  /></td>
					</tr>

				</table>
		<tr>
			<td colspan="2" align="center"><html:button property="mode"
					title="Save the Fields" styleClass="btext" value="save"
					onclick="return validate()" /> <html:reset
					title="Clear all the Fields" styleClass="btext" value="Reset" /> <html:submit
					property="mode" title="View the Fields" styleClass="btext"
					value="View" /></td>
		</tr>
	</table>

	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="300" />
	</jsp:include>

</html:form>


<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>


