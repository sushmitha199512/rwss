<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_user_restriction.jsp"%>
<html:javascript formName="programmeForm" />
<script language="JavaScript">
	function autocompletion()
	{
	      // alert("auto comp");
		 for (i=0; i<document.forms.length; i++) {
	        document.forms[i].setAttribute("AutoComplete","off");
	       }
	}
	function centralShareDet() {
		var cs = parseFloat(programmeForm.centralShare.value)
		if (cs > 100) {
			alert(" Total Share Value Cannot exceeds 100%");
			programmeForm.centralShare.value = 0;
			programmeForm.centralShare.focus();
		}
	}
	function stateShareDet() {
		var sh = parseFloat(programmeForm.centralShare.value)
				+ parseFloat(programmeForm.stateShare.value);
		if (sh > 100) {
			alert(" Total Share Value Cannot exceeds 100%");
			programmeForm.stateShare.value = 0;
			programmeForm.stateShare.focus();
		}
	}
	function publicShareDet() {
		var ps = parseFloat(programmeForm.centralShare.value)
				+ parseFloat(programmeForm.stateShare.value)
				+ parseFloat(programmeForm.publicShare.value);
		if (ps > 100) {
			alert(" Total Share Value Cannot exceeds 100%");
			programmeForm.publicShare.value = 0;
			programmeForm.publicShare.focus();
		}
	}
	function otherShareDet() {
		var os = parseFloat(programmeForm.centralShare.value)
				+ parseFloat(programmeForm.stateShare.value)
				+ parseFloat(programmeForm.publicShare.value)
				+ parseFloat(programmeForm.otherShare.value);
		if (os > 100) {
			alert(" Total Share Value Cannot exceeds 100%");
			programmeForm.otherShare.value = 0;
			programmeForm.otherShare.focus();
		}
	}
</script>
<%@ include file="/commons/rws_header2.jsp"%>
<body onload="autocompletion()">
<html:form action="/Programme.do">
	<jsp:include page="/commons/TableHeader.jsp">
		<jsp:param name="TableName" value="Programme Entry Form" />
		<jsp:param name="TWidth" value="565" />
	</jsp:include>
	<table bgcolor="#DEE3E0" bordercolor="#8A9FCD" rules="cols" border="1"
		style="border-collapse: collapse;" width="605">
		<tr>
			<td>
				<table 	style="margin-bottom: 5; margin-top: 5;width:600; align:center;border:0 ">
					<tr>
						<td class=mycborder><FONT class=myfontclr>Programme
								Code<font color="#FF6666">*</font>
						</FONT></td>
						<td class=mycborder><html:text property="prgmCode"
								value="<%=(String) request.getAttribute(\"code\")%>"
								styleClass="mytext" maxlength="2" size="4" readonly="true" /></td>
						<td class=mycborder><FONT class=myfontclr>Programme
								Name<font color="#FF6666">*</font>
						</FONT></td>
						<td class=mycborder><html:text property="prgmName" value=""
								styleClass="mytext" maxlength="30" /></td>
					</tr>
					<tr>
						<td class=mycborder><FONT class=myfontclr>Financial
								Year<font color="#FF6666">*</font>
						</FONT></td>
						<td class=mycborder><html:text property="prgmStartYr"
								value="" styleClass="mytext" maxlength="9" /></td>
						<td class=mycborder><FONT class=myfontclr>End
								Date(dd/mm/yyyy)</FONT></td>
						<td class=mycborder><html:text property="prgmEndDate"
								value="" styleClass="mytext" size="10" /> <a
							href="javascript: showCalendar(document.programmeForm.prgmEndDate);"><IMG
								SRC="<rws:context page='/images/calendar.gif'/>" width="30"
								border="0" height="19" align="absmiddle"></a>
						</td>
					</tr>
				</table>
				<hr style="color: #8A9FCD">
				<table style="margin-bottom: 5; margin-top: 5;align:center;width: 600;border: 0">
					<tr>
						<td class=mycborder><FONT class=myfontclr>Central
								Share</FONT></td>
						<td class=mycborder><html:text property="centralShare"
								value="0" styleClass="mytext" maxlength="5"
								onblur="javascript:centralShareDet()" size="5" />&nbsp;<b>%</b>
						</td>
						<td class=mycborder><FONT class=myfontclr>State Share</FONT>
						</td>
						<td class=mycborder><html:text property="stateShare"
								value="0" styleClass="mytext" maxlength="5"
								onblur="javascript:stateShareDet()" size="5" />&nbsp;<b>%</b></td>
					</tr>
					<tr>
						<td class=mycborder><FONT class=myfontclr>Public
								Share</FONT></td>
						<td class=mycborder><html:text property="publicShare"
								value="0" styleClass="mytext" maxlength="5"
								onblur="javascript:publicShareDet()" size="5" />&nbsp;<b>%</b>

						</td>
						<td class=mycborder><FONT class=myfontclr>Other Share</FONT>
						</td>
						<td class=mycborder><html:text property="otherShare"
								value="0" styleClass="mytext" maxlength="5"
								onblur="javascript:otherShareDet()" size="5" />&nbsp;<b>%</b></td>
					</tr>
					<tr>
						<td class=mycborder><FONT class=myfontclr>Status<font
								color="#FF6666">*</font></FONT></td>
						<td class=mycborder><html:select property="status"
								styleClass="mycombo">
								<html:option value="">SELECT..</html:option>
								<html:option value="F">FRESH</html:option>
								<html:option value="O">ONGOING</html:option>
							</html:select></td>

						<td class=mycborder><FONT class=myfontclr>NRDWP-RELATED<font
								color="#FF6666">*</font></FONT></td>
						<td class=mycborder><html:select property="nrdwprelated"
								styleClass="mycombo">
								<html:option value="">SELECT..</html:option>
								<html:option value="Y">Yes</html:option>
								<html:option value="N">No</html:option>
							</html:select></td>
					</tr>
					<TR>
						<td class=mycborder><FONT class=myfontclr>Display in
								CORE DASHBOARD<font color="#FF6666">*</font>
						</FONT></td>
						<td class=mycborder><html:select property="cmcoredb"
								styleClass="mycombo">
								<html:option value="">SELECT..</html:option>
								<html:option value="Y">Yes</html:option>
								<html:option value="N">No</html:option>
							</html:select></td>
						<td class=mycborder><FONT class=myfontclr>Centre/State/District
								Level<font color="#FF6666">*</font>
						</FONT></td>
						<td class=mycborder><html:select property="progBelongTo"
								styleClass="mycombo">
								<html:option value="">SELECT..</html:option>
								<html:option value="C">Centre</html:option>
								<html:option value="S">State</html:option>
								<html:option value="D">District</html:option>
							</html:select></td>
					</TR>
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
					onclick="return validateProgrammeForm(programmeForm)" /> <html:reset
					title="Clear all the Fields" styleClass="btext" value="Reset" /> <html:submit
					property="mode" title="View the Fields" styleClass="btext"
					value="View" /></td>
		</tr>
	</table>

	<jsp:include page="/commons/TableFotter.jsp">
		<jsp:param name="TWidth" value="565" />
	</jsp:include>

</html:form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>