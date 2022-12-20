<%@ include file="/commons/rws_header1.jsp"%>
<html:javascript formName="detailHeadForm" />
<%@ include file="/commons/rws_header2.jsp"%>

<script type="text/javascript">
	function autocompletion() {
		for (i = 0; i < document.forms.length; i++) {
			document.forms[i].setAttribute("AutoComplete", "off");
		}
	}
</script>

<body onload="autocompletion()">
	<html:form action="/DetailHead.do?mode=edit"
		onsubmit="return validateDetailHeadForm(this)">


		<jsp:include page="/commons/TableHeader.jsp">
			<jsp:param name="TableName" value="Detailed Head Account Entry Form" />
			<jsp:param name="TWidth" value="390" />
		</jsp:include>


		<table bgcolor="#DEE3E0" bordercolor="#8A9FCD" rules="cols" border="1"
			style="border-collapse: collapse;" width="430">
			<tr>
				<td>
					<table border=0 width="390" align=center
						style="margin-bottom: 5; margin-top: 5">
						<tr>
							<td class=mycborder><FONT class=myfontclr><bean:message
										key="app.majorHeadCode" /><font color="#FF6666">*</font></FONT></td>
							<td class=mycborder><html:text property="majorHeadCode"
									styleClass="mytext" maxlength="4" /></td>
						</tr>
						<tr>
							<td class=mycborder><FONT class=myfontclr><bean:message
										key="app.submajorHeadCode" /><font color="#FF6666">*</font></FONT></td>
							<td class=mycborder><html:text property="submajorHeadCode"
									styleClass="mytext" maxlength="2" /></td>
						</tr>
						<tr>
							<td class=mycborder><FONT class=myfontclr><bean:message
										key="app.minorHeadCode" /><font color="#FF6666">*</font></FONT></td>
							<td class=mycborder><html:text property="minorHeadCode"
									styleClass="mytext" maxlength="3" /></td>
						</tr>
						<tr>
							<td class=mycborder><FONT class=myfontclr><bean:message
										key="app.grpSubHeadCode" /><font color="#FF6666">*</font></FONT></td>
							<td class=mycborder><html:text property="grpSubHeadCode"
									styleClass="mytext" maxlength="3" /></td>
						</tr>
						<tr>
							<td class=mycborder><FONT class=myfontclr><bean:message
										key="app.subHeadCode" /><font color="#FF6666">*</font></FONT></td>
							<td class=mycborder><html:text property="subHeadCode"
									styleClass="mytext" maxlength="2" /></td>
						</tr>
						<tr>
							<td class=mycborder><FONT class=myfontclr><bean:message
										key="app.detailHeadCode" /><font color="#FF6666">*</font></FONT></td>
							<td class=mycborder><html:text property="detailHeadCode"
									styleClass="mytext" maxlength="2" readonly="true" /></td>
						</tr>
						<tr>
							<td class=mycborder><FONT class=myfontclr><bean:message
										key="app.detailHeadName" /><font color="#FF6666">*</font></FONT></td>
							<td class=mycborder><html:text property="detailHeadName"
									styleClass="mytext"   onkeypress="return textOnly(event)"	  /></td>
						</tr>
					</table> <%
 	String csrfToken = "";
 		nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
 		csrfToken = valUtil.getCSRFCode();
 		session.setAttribute("csrfToken", csrfToken);
 %> <html:hidden property="token" styleClass="mytext"
						value="${sessionScope.csrfToken}" />
			<tr>
				<td colspan="2" align="center"><html:submit
						title="Save the Fields" styleClass="btext" value="Save"
						onclick="return winView()" /> <html:reset
						title="Clear all the Fields" styleClass="btext" value="Reset" />
				</td>
			</tr>
		</table>

		<jsp:include page="/commons/TableFotter.jsp">
			<jsp:param name="TWidth" value="390" />
		</jsp:include>

	</html:form>
</body>
</td>
</tr>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

