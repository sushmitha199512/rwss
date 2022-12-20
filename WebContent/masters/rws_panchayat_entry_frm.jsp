<%@ include file="/commons/rws_header1.jsp"%>
<%@	page import="java.util.*"%>
<%@	page import="nic.watersoft.commons.Debug"%>
<%@	page import="nic.watersoft.commons.RwsUser"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%
	nic.watersoft.commons.RwsUser users = (nic.watersoft.commons.RwsUser) session.getAttribute("RWS_USER");
%>
<head>
<script language="javascript">
function funcInit()
{
	var ad='<%=(String) session.getAttribute("userId")%>';
		if (ad != "admin" && ad != "100000") {
			//if(document.forms[0].district.value=="14" )
			document.forms[0].addNew.disabled = "true";
		}
	}
	function funcDistrictChanged() {
		document.forms[0].action = "/pred/masters/Panchayat.do?mode=mandals";
		document.forms[0].submit();
	}

	function fnSave() {
		document.forms[0].action = "/pred/masters/Panchayat.do?mode=save";
		document.forms[0].submit();
		document.forms[0].save.disabled = true;
	}

	function fnSaveNew() {
		if (document.forms[0].district.value == "") {
			alert("Please Select District");
			return;
		} else if (document.forms[0].mandal.value == "") {
			alert("Please Select Mandal");
			return;
		} else if (document.forms[0].pcode.value == "") {
			alert("Please Enter Panchayat Code");
			return;
		} else if (document.forms[0].pname.value == "") {
			alert("Please Enter Panchayat Name");
			return;
		} else if (document.forms[0].pcode.value.length != 2) {
			alert("Panchayat Code Should be Of Length 2");
			return;
		} else {
			document.forms[0].save.disabled = true;
			document.forms[0].action = "/pred/masters/Panchayat.do?mode=saveNew";
			document.forms[0].submit();
		}
	}
	function viewfun() {
		if (document.forms[0].district.value != ""
				&& document.forms[0].mandal.value != "") {
			document.forms[0].action = "/pred/masters/Panchayat.do?mode=view";
			document.forms[0].submit();
		} else {
			alert("District Cannot be Empty\nMandal Cannot be Empty");

		}
	}
	function fnAddNew() {
		document.forms[0].action = "/pred/masters/Panchayat.do?mode=addNew";
		document.forms[0].submit();

	}
</script>
</head>
<body>
	<html:form action="HabStatus.do">
		<table align="center" cellpadding="0" cellspacing="0" border=0>
			<thead>
				<tr>
					<td><jsp:include page="/commons/TableHeader.jsp">
							<jsp:param name="TableName" value="Panchayat Entry Form" />
							<jsp:param name="TWidth" value="100%" />
							<jsp:param name="contextHelpUrl" value="/pred/help/panchayat.doc" />
						</jsp:include></td>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td><jsp:include page="/commons/TableFotter.jsp">
							<jsp:param name="TWidth" value="100%" />
						</jsp:include></td>
				</tr>
			</tfoot>
			<tbody>
				<tr>
					<td>
						<table bgcolor="#DEE3E0" bordercolor="#8A9FCD" rules="cols"
							border="1" style="border-collapse: collapse;" width="350">
							<tr>
								<td>
									<fieldset>
										<legend>
											<bean:message key="legend.rwsOffices" />
										</legend>
										<label>
											<table border=0 width="100%">
												<tr>
													<td class="textborder">District <span
														class="mandatory">*</span>
													</td>
													<td class="textborder"><logic:equal name="RWS_USER"
															property="circleOfficeCode" value="00">
															<html:select property="district" style="width:140px"
																onchange="javascript: funcDistrictChanged()"
																styleClass="mycombo">
																<html:option value="">
																	<bean:message key="app.pleaseSelect" />
																</html:option>
																<html:options collection="districts"
																	name="labelValueBean" property="value"
																	labelProperty="label" />
															</html:select>
														</logic:equal> <logic:notEqual name="RWS_USER"
															property="circleOfficeCode" value="00">
															<html:text property="districtName" styleClass="mytext"
																style="width:140px" readonly="true" />
															<html:hidden property="district" />
														</logic:notEqual></td>
												</tr>
												<tr>
													<td class="textborder">Mandal <span class="mandatory">*</span>
													</td>
													<td><html:select property="mandal" style="width:140px"
															styleClass="mycombo">
															<html:option value="">
																<bean:message key="app.pleaseSelect" />
															</html:option>
															<html:options collection="mandals" name="labelValueBean"
																property="value" labelProperty="label" />
														</html:select></td>
												</tr>
												<%
													if (request.getAttribute("mode") != null && request.getAttribute("mode").equals("panchayatEdit")) {
												%>
												<tr>
													<td class="textborder">Panchayat Code <span
														class="mandatory">*</span>
													</td>
													<td><html:text property="pcode" style="width:140px"
															readonly="true" /></td>
												</tr>
												<tr>
													<td class="textborder">Panchayat Name <span
														class="mandatory">*</span>
													</td>
													<td><html:text property="pname" style="width:140px" />
													</td>
												</tr>
												<%
													}
												
													if (request.getAttribute("mode") != null && request.getAttribute("mode").equals("panchayatNew")) {
												%>
												<tr>
													<td class="textborder">Panchayat Code <span
														class="mandatory">*</span>
													</td>
													<td><html:text property="pcode" style="width:140px"
															readonly="false" maxlength="2"
															onkeypress="return numeralsOnly()" /></td>
												</tr>
												<tr>
													<td class="textborder">Panchayat Name <span
														class="mandatory">*</span>
													</td>
													<td><html:text property="pname" style="width:140px"
															maxlength="23" onkeypress="return textOnly()" /></td>
												</tr>
												<%
													}
												%>
											</table>
										</label>
									</fieldset>
								</td>
							</tr>
							<%
								String csrfToken = "";
								nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
								csrfToken = valUtil.getCSRFCode();
								session.setAttribute("csrfToken", csrfToken);
							%>
							<html:hidden property="token" styleClass="mytext"	value="${sessionScope.csrfToken}" />
							<tr>
								<td>
									<table width="100%">
										<tr>
											<td class="textborder" align=center>
												<%
													if (request.getAttribute("mode") != null && request.getAttribute("mode").equals("panchayatEdit")) {
												%>
												<html:button property="save" title="Save the Fields"
													styleClass="btext" value="Save" onclick="return fnSave()" />
												<%
													} else {
												%> <html:button property="save"
													title="Save the Fields" styleClass="btext" value="Save"
													onclick="return fnSaveNew()" /> <html:button
													property="mode" title="View Panchayats" styleClass="btext"
													value="View" onclick="return viewfun()" /> <%
			//System.out.println("aaa:"+users.getUserId());
			if(users.getUserId().equals("100000") || users.getUserId().equals("admin")||(users.getUserId().length()==6 && (users.getUserId().substring(users.getUserId().length()-3).equals("000") ))){
				//System.out.println("in false");%> <html:button property="addNew"
													title="Add New Panchayat" styleClass="btext"
													value="Add New" onclick="fnAddNew();" disabled="false" /> <%}else
			{
					//System.out.println("in true");
				%> <html:button property="addNew" title="Add New Panchayat"
													styleClass="btext" value="Add New" onclick="fnAddNew();"
													disabled="true" /> <%}%> <%} %> <% if(request.getAttribute("mode")!=null && request.getAttribute("mode").equals("panchayatEdit")){ %>
												<%--  <html:button property="mode" title="Close The Form"
													styleClass="btext" value="Close"
													onclick="javascript:self.close();" /> --%>  <%} %>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</tbody>
		</table>
	</html:form>
</body>
<%@ include file="/commons/rws_alert.jsp"%>
