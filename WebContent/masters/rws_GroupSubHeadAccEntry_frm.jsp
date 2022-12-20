<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_user_restriction.jsp"%>

<SCRIPT LANGUAGE="JavaScript">
	function autocompletion() {
		// alert("auto comp");
		for (i = 0; i < document.forms.length; i++) {
			document.forms[i].setAttribute("AutoComplete", "off");
		}
	}
	function fnValidate() {
		if (document.forms[0].majorHeadCode.value == "" || document.forms[0].majorHeadCode.value == null  ) {
			alert("Select Major Head Code");
			return false;
		}else if (document.forms[0].submajorHeadCode.value == "" || document.forms[0].submajorHeadCode.value == null  ) {
			alert("Select Sub Major Head Code");
			return false;
		}else if (document.forms[0].minorHeadCode.value == "" || document.forms[0].minorHeadCode.value == null  ) {
			alert("Select Minor Head Code");
			return false;
		}else if (document.forms[0].plannonplan[0].checked == false	&& document.forms[0].plannonplan[1].checked == false) {
			alert("Please Select Plan/Non Plan");
			return false;
		} else if (document.forms[0].grpSubHeadCode.value == "" || document.forms[0].grpSubHeadCode.value == null  ) {
			alert("Enter Group Head Code");
			return false;
		}else if (document.forms[0].grpSubHeadCode.value.length!=3  ) {
			alert("Group Head Code must have 3 digits");
			return false;
		}  else if ((document.forms[0].grpSubHeadName.value == "" || document.forms[0].grpSubHeadName.value == null)) {
			alert("Enter Group Head Name");
			return false;
		} else {
			return true;
		}
	}
	function planorNon() {			
		if (document.forms[0].plannonplan[0].checked == false 	&&  document.forms[0].plannonplan[1].checked == false) {
			alert("Please Select Plan/Non Plan");
			return false;
		}else{
			document.forms[0].submit();
		}	
	}
	
	function fnRadioClick(value) {
		if (value == 1) {
			document.forms[0].grpSubHeadCode.value = '';
			document.forms[0].grpSubHeadCode.readOnly = false;
			document.forms[0].grpSubHeadName.value = '';
			document.forms[0].grpSubHeadName.readOnly = false;
		} else if (value == 2) {
			document.forms[0].grpSubHeadCode.value = '000';
			document.forms[0].grpSubHeadCode.readOnly = true;
			document.forms[0].grpSubHeadName.value = '-';
			//document.forms[0].grpSubHeadName.readOnly = true;
		}
	}
	function getData() {
		document.forms[0].action = "switch.do?prefix=/masters&page=/GrpSubHead.do&mode=data";
		document.forms[0].submit();
	}
	function init() {
		document.forms[0].plannonplan[0].checked = false;
		document.forms[0].plannonplan[1].checked = false;
	}
</SCRIPT>

<%@ include file="/commons/rws_header2.jsp"%>
<body onload="init();autocompletion();">
	<html:form action="/GrpSubHead.do">

		<jsp:include page="/commons/TableHeader.jsp">
			<jsp:param name="TableName" value="Group Head Account Entry Form" />
			<jsp:param name="TWidth" value="360" />
		</jsp:include>

		<table bgcolor="#DEE3E0" bordercolor="#8A9FCD" rules="cols" border="1"
			style="border-collapse: collapse;" width="400">
			<tr>
				<td>
					<table border=0 width="360" align=center
						style="margin-bottom: 5; margin-top: 5">
						<tr>
							<td class="textborder">Major Head Code<font color="#FF6666">*</font>
							</td>
							<td class="textborder"><html:select
									property="majorHeadCode" styleClass="mycombo"
									style="width:190px" onchange="javascript: getData()">
									<html:option value="">SELECT...</html:option>
									<html:options collection="majorHeads" name="rwsMaster"
										property="majorHeadCode" labelProperty="codeName" />
								</html:select></td>
						</tr>
						<tr>
							<td class="textborder">SubMajor Head Code<font
								color="#FF6666">*</font>
							</td>
							<td class="textborder"><html:select
									property="submajorHeadCode" styleClass="mycombo"
									style="width:190px" onchange="javascript: getData()">
									<html:option value="">SELECT...</html:option>
									<html:options collection="submajorHeads" name="rwsMaster"
										property="submajorHeadCode" labelProperty="codeName" />
								</html:select></td>
						</tr>
						<tr>
							<td class="textborder">Minor Head Code<font color="#FF6666">*</font>
							</td>
							<td class="textborder"><html:select
									property="minorHeadCode" styleClass="mycombo"
									style="width:190px">
									<html:option value="">SELECT...</html:option>
									<html:options collection="minorheads" name="rwsMaster"
										property="minorHeadCode" labelProperty="codeName"  	/>
								</html:select></td>
						</tr>
						<tr>
							<td class="textborder">Choose :</td>
							<td class="textborder"><INPUT type="radio" value="1"
								name="plannonplan" onClick="fnRadioClick('1')">Plan&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<INPUT
								type="radio" value="2" name="plannonplan"
								onClick="fnRadioClick('2')">Non Plan</td>
						</tr>
						<tr>
							<td class="textborder">Group Sub Head Code<font
								color="#FF6666">*</font>
							</td>
							<td class="textborder"><html:text property="grpSubHeadCode"
									value="" styleClass="mytext" maxlength="3" style="width:60px" onkeypress="return numeralsOnly(event)"/>
							</td>
						</tr>
						<tr>
							<td class="textborder">Group Sub Head Name<font
								color="#FF6666">*</font>
							</td>
							<td class="textborder"><html:text property="grpSubHeadName"
									value="" maxlength="60" styleClass="mytext" style="width:190px" onkeypress="return textOnly(event)"/>
							</td>
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
						onclick="return fnValidate()" /> <html:reset
						title="Clear all the Fields" styleClass="btext" value="Reset" />
					<html:submit property="mode" title="View the Fields"
						styleClass="btext" value="View" onclick="return planorNon()"/></td>
			</tr>
		</table>

		<jsp:include page="/commons/TableFotter.jsp">
			<jsp:param name="TWidth" value="360" />
		</jsp:include>

	</html:form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>

