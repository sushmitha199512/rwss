<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_user_restriction.jsp"%>
<html:javascript formName="submajorHeadForm" />

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

	<html:form action="/SubMajorHead.do">
		<jsp:include page="/commons/TableHeader.jsp">
			<jsp:param name="TableName" value="Sub Major Head Entry Form" />
			<jsp:param name="TWidth" value="350" />
		</jsp:include>

		<table bgcolor="#DEE3E0" bordercolor="#8A9FCD" rules="cols" border="1"
			style="border-collapse: collapse;" width="350">
			<tr>
				<td>
					<table border=0 width="385" align=center
						style="margin-bottom: 5; margin-top: 5">
						<tr>
							<td class="textborder">Major Head Code<font color="#FF6666">*</font>
							</td>
							<td class="textborder"><html:select
									property="majorHeadCode" styleClass="mycombo"
									style="width:200px">
									<html:option value="">SELECT...</html:option>
									<html:options collection="majorHeads" name="rwsMaster"
										property="majorHeadCode" labelProperty="codeName" />
								</html:select></td>
						</tr>
						<tr>
							<td class="textborder">SubMajor Head Code<font
								color="#FF6666">*</font>
							</td>
							<td class="textborder"><html:text
									property="submajorHeadCode" value="" styleClass="mytext"
									maxlength="2" style="width:60px"
									onkeypress="return numeralsOnly(event)" /></td>
						</tr>
						<tr>
							<td class="textborder">SubMajor Head Name<font
								color="#FF6666">*</font>
							</td>
							<td class="textborder"><html:text
									property="submajorHeadName" value="" styleClass="mytext"
									style="width:200px" onkeypress="return textOnly(event)" /></td>
						</tr>
					</table> <%
 	String csrfToken = "";
 		nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
 		csrfToken = valUtil.getCSRFCode();
 		session.setAttribute("csrfToken", csrfToken);
 %> <html:hidden property="token" styleClass="mytext"
						value="${sessionScope.csrfToken}" />
			<tr>
				<td colspan="2" align="center"><html:submit property="mode"
						title="Save the Fields" styleClass="btext" value="Save"
						onclick="return validateSubmajorHeadForm(submajorHeadForm)" /> <html:reset
						title="Clear all the Fields" styleClass="btext" value="Reset" />
					<html:submit property="mode" title="View the Fields"
						styleClass="btext" value="View" /></td>
			</tr>
		</table>

		<jsp:include page="/commons/TableFotter.jsp">
			<jsp:param name="TWidth" value="350" />
		</jsp:include>

	</html:form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>