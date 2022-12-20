<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_user_restriction.jsp"%>
<html:javascript formName="minorHeadForm" />
<%@ include file="/commons/rws_header2.jsp"%>
<script>
function autocompletion()
{
      // alert("auto comp");
	 for (i=0; i<document.forms.length; i++) {
        document.forms[i].setAttribute("AutoComplete","off");
       }
}
</script>
 <body onload="autocompletion()">
<html:form action="/MinorHead.do?mode=edit"
	onsubmit="return validateMinorHeadForm(this)">

	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Minor Head Account Entry Form" />
		<jsp:param name="TWidth" value="300" />
	</jsp:include>

	<table bgcolor="#DEE3E0" bordercolor="#8A9FCD" width="340">
		<tr>
			<td>
				<table border=0 width="300" align=center
					style="margin-bottom: 5; margin-top: 5">
					<tr>
						<td class=mycborder><FONT class=myfontclr><bean:message
									key="app.majorHeadCode" /></FONT></td>
						<td class=mycborder><html:text property="majorHeadCode"
								styleClass="mytext" maxlength="4" readonly="true" /></td>
					</tr>
					<tr>
						<td class=mycborder><FONT class=myfontclr><bean:message
									key="app.submajorHeadCode" /></FONT></td>
						<td class=mycborder><html:text property="submajorHeadCode"
								styleClass="mytext" maxlength="2" readonly="true" /></td>
					</tr>
					<tr>
						<td class=mycborder><FONT class=myfontclr><bean:message
									key="app.minorHeadCode" /></FONT></td>
						<td class=mycborder><html:text property="minorHeadCode"
								styleClass="mytext" maxlength="3" readonly="true" /></td>
					</tr>
					<tr>
						<td class=mycborder><FONT class=myfontclr><bean:message
									key="app.minorHeadName" /></FONT></td>
						<td class=mycborder><html:text property="minorHeadName" onkeypress="return textOnly(event)"
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
			<td colspan="2" align="center"><html:submit
					title="Save the Fields" styleClass="btext" value="Save"
					onclick="return winView()" /> <html:reset
					title="Clear all the Fields" styleClass="btext" value="Reset" /></td>
		</tr>
	</table>

	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="300" />
	</jsp:include>
</html:form>
</td>
</tr>
</body>

<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

