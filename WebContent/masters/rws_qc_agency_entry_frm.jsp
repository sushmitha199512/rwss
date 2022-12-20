<%@ include file="/commons/rws_header1.jsp"%>
<%@	page import="java.util.*"%>
<%@	page import="nic.watersoft.commons.Debug"%>
<%@	page import="nic.watersoft.commons.RwsUser"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%
	nic.watersoft.commons.RwsUser users = (nic.watersoft.commons.RwsUser) session.getAttribute("RWS_USER");
	//System.out.println("users :"+users);
	String mode=request.getParameter("mode");
	//System.out.println("Jsp mode :"+mode);
	 java.util.Date date =new  java.util.Date();
	int year=date.getYear()+1900;
    String currentYear= String.valueOf(year); 
    int finYear_Start=2021;
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
	/* function funcDistrictChanged() {
		document.forms[0].action = "/pred/masters/Panchayat.do?mode=mandals";
		document.forms[0].submit();
	}
 */
	function fnSave() {
		document.forms[0].action = "/pred/masters/qcagency.do?mode=save";
		document.forms[0].submit();
		document.forms[0].save.disabled = true;
	}
 
 
 	function fnEdit() {
		document.forms[0].action = "/pred/masters/qcagency.do?mode=QCAgencyUpd";
		document.forms[0].submit();
		document.forms[0].save.disabled = true;
	}
 	
 	function fnDelete() {
		document.forms[0].action = "/pred/masters/qcagency.do?mode=QCAgencyDelete";
		document.forms[0].submit();
		document.forms[0].save.disabled = true;
	}
 	
 	function funcFinYearChanged() {
		document.forms[0].action = "/pred/masters/qcagency.do?mode=QcAgencyEntryFrm";
		document.forms[0].submit();
	}

	function fnSaveNew() {
		/* if (document.forms[0].agencycode.value == "") {
			alert("Please Enter Agency Code");
			return;
		} 
		else */ if (document.forms[0].agencyname.value == "") {
			alert("Please Enter Agency Name");
			return;
		} 
		else {
			document.forms[0].save.disabled = true;
			document.forms[0].action = "/pred/masters/qcagency.do?mode=saveNew";
			document.forms[0].submit();
		}
	}
	function viewfun() {
		/* if (document.forms[0].agencycode.value != ""
				&& document.forms[0].agencyname.value != "") { */
			document.forms[0].action = "/pred/masters/qcagency.do?mode=view";
			document.forms[0].submit();
		/* } else {
			alert("Agency Code Cannot be Empty\nAgency Name Cannot be Empty");

		} */
	}
	function fnAddNew() {
		document.forms[0].action = "/pred/masters/qcagency.do?mode=addNew";
		document.forms[0].submit();

	}
</script>
</head>
<body>
	<html:form action="qcagency.do">
		<table align="center" cellpadding="0" cellspacing="0" border=0>
			<thead>
				<tr>
					<td><jsp:include page="/commons/TableHeader.jsp">
							<jsp:param name="TableName" value="TPQC Agency Entry Form" />
							<jsp:param name="TWidth" value="100%" />
							<jsp:param name="" value="/pred/help/panchayat.doc" />
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
						<table bgcolor="#DEE3E0" bordercolor="#8A9FCD" rules="cols" border="1" style="border-collapse: collapse;" width="350">
							<tr>
								<td>
									<fieldset>
										 <%-- <legend>
											<bean:message key="legend.rwsOffices" />
										</legend> --%> 
										<label>
											<table border=0 width="100%">
											    <tr>
													<td class="textborder">Financial Year<span class="mandatory">*</span></td>
													
													<% if(mode!= null && (mode.equals("QCAgencyEdit") || mode.equals("QCAgencyUpd"))) {
													%>
													<td>
													<html:text property="finyear" style="width:140px" maxlength="20"  readonly="true"/>
													<%-- <html:select property="finyear" styleClass="mycombo" >
													    <html:option value="0">SELECT...</html:option>
														<html:option value="2021-2022">2021-2022</html:option>
													</html:select> --%>
													</td>
													<%} else{%>
													<td>
													<%-- <html:select property="finyear" styleClass="mycombo" onchange="javascript: funcFinYearChanged()">
													    <html:option value="0">SELECT...</html:option>
														<html:option value="2021-2022">2021-2022</html:option>
													</html:select> --%>
													

<html:select property="finyear" styleClass="mycombo">
<!-- <option value="0">Select</option> -->
<%
int fy=0;
while(year>=finYear_Start)
{
   fy=year+1;
%>
<option value="<%=year+"-"+fy%>"><%=year+"-"+fy%></option> 
<%
year--;	
}
%>
</html:select>
													</td>
													<%} %>
													
												</tr>
												<tr>
													<td class="textborder">Agency Code<span class="mandatory">*</span></td>
													<% if(mode!= null && (mode.equals("QCAgencyEdit") || mode.equals("QCAgencyUpd"))) {%>
													<td><html:text property="agencycode" style="width:140px" maxlength="20"  readonly="true"/></td>
													<%} else{%>
													<td><html:text property="agencycode" style="width:140px" readonly="true"/></td>
													<%} %>
												</tr>
												<tr>
													<td class="textborder">Agency Name<span class="mandatory">*</span></td>
													<td><html:text property="agencyname" style="width:140px"  maxlength="50"  onkeypress="return textOnly1(event);"/></td>
												</tr>
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
							<html:hidden property="token" styleClass="mytext" value="${sessionScope.csrfToken}" />
							<tr>
								<td>
									<table width="100%">
										<tr>
											<td class="textborder" align=center>
												<%
													//System.out.println("Mode :"+mode);
													String loguser  = (String) session.getAttribute("userId");
													if (mode!=null && mode.equals("save") && (loguser != "admin" || loguser != "100000")) {
												%>
												<html:button property="save" title="Save the Fields"
													styleClass="btext" value="Save" onclick="return fnSave()" />
												<%	} else if (mode!=null && (mode.equals("QCAgencyEdit") || mode.equals("QCAgencyUpd")) && (loguser != "admin" || loguser != "100000")) { %>
													<html:button property="update" title="Update the Fields" styleClass="btext" value="Update" onclick="return fnEdit()" />
													<%-- <html:button property="delete" title="Delete the Fields" styleClass="btext" value="Delete" onclick="return fnDelete()" /> --%>
													<%} else {
												%> <html:button property="save"
													title="Save the Fields" styleClass="btext" value="Save" onclick="return fnSaveNew()" /> 
													<html:button
													property="mode" title="View Agencies" styleClass="btext"
													value="View" onclick="return viewfun()" /> <%} %>
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
