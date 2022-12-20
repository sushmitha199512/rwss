
<%String grpHead = request.getParameter("grpSubHeadCode");
 %>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/commons/rws_user_restriction.jsp"%>
<SCRIPT LANGUAGE="JavaScript">
function autocompletion()
{      
	 for (i=0; i<document.forms.length; i++) {
        document.forms[i].setAttribute("AutoComplete","off");
      }
}
function fnValidate()
{
	if((document.forms[0].grpSubHeadCode.value == "" || document.forms[0].grpSubHeadCode.value == null))
	{
		alert("Select Group Head Code");
		return false;
	}
	else if((document.forms[0].grpSubHeadName.value == "" || document.forms[0].grpSubHeadName.value == null))
	{
		alert("Select Group Head Name");
		return false;
	}
	else
	{
		return true;
	}
}

function init()
{
	var code = <%=grpHead%>
	;
		if (code == "0") {
			document.forms[0].planNonplan[0].checked = true;
			document.forms[0].planNonplan[1].checked = false;
			document.forms[0].grpSubHeadCode.readOnly = true;
			document.forms[0].grpSubHeadName.readOnly = true;
		} else {
			document.forms[0].planNonplan[0].checked = false;
			document.forms[0].planNonplan[1].checked = true;
			document.forms[0].grpSubHeadCode.readOnly = true;
			document.forms[0].grpSubHeadName.readOnly = false;
		}
	}
	function fnRadioClick(value) {
		if (value == 1) {
			document.forms[0].grpSubHeadCode.value = '000';
			document.forms[0].grpSubHeadCode.readOnly = true;
			document.forms[0].grpSubHeadName.value = '-';
			document.forms[0].grpSubHeadName.readOnly = true;
		} else if (value == 2) {
			document.forms[0].grpSubHeadCode.value = '';
			document.forms[0].grpSubHeadCode.readOnly = false;
			document.forms[0].grpSubHeadName.value = '';
			document.forms[0].grpSubHeadName.readOnly = false;
		}
	}
</script>
<body onLoad="init();autocompletion();">

	<html:form action="GrpSubHead.do?mode=edit"
		onsubmit="return fnValidate()">
		<H3></H3>
		<jsp:include page="/commons/TableHeader.jsp">
			<jsp:param name="TableName" value="Group Head Account Entry Form" />
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
										key="app.grpSubHeadCode" /></FONT></td>
							<td class=mycborder><html:text property="grpSubHeadCode"
									styleClass="mytext" maxlength="3" readonly="true" /></td>
						</tr>
						<tr>
							<td class=mycborder><FONT class=myfontclr><bean:message
										key="app.grpSubHeadName" /></FONT></td>
							<td class=mycborder><html:text property="grpSubHeadName"
									styleClass="mytext"  onkeypress="return textOnly(event)"/></td>
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
						title="Save the Fields" styleClass="btext" value="Save" /> <html:reset
						title="Clear all the Fields" styleClass="btext" value="Reset" /></td>
			</tr>
		</table>
		<jsp:include page="/commons/TableFotter.jsp">
			<jsp:param name="TWidth" value="300" />
		</jsp:include>
	</html:form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
