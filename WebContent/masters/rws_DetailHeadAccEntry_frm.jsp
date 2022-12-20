<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_user_restriction.jsp"%>
<html:javascript formName="detailHeadForm" />
<SCRIPT LANGUAGE="JavaScript">
<!--
	function getData() {
		document.forms[0].action = "switch.do?prefix=/masters&page=/DetailHead.do?mode=data";
		document.forms[0].submit();
	}
	function autocompletion() {
		for (i = 0; i < document.forms.length; i++) {
			document.forms[i].setAttribute("AutoComplete", "off");
		}
	}
//-->
</SCRIPT>

<%@ include file="/commons/rws_header2.jsp"%>
<body onload="autocompletion()">
	<html:form action="/DetailHead.do">

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
							<td class="textborder">Major Head Code<font color="#FF6666">*</font>
							</td>
							<td class="textborder"><html:select
									property="majorHeadCode" style="width:200px"
									styleClass="mycombo" onchange="javascript: getData()">
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
									property="submajorHeadCode" style="width:200px"
									styleClass="mycombo" onchange="javascript: getData()">
									<html:option value="">SELECT...</html:option>
									<html:options collection="submajorHeads" name="rwsMaster"
										property="submajorHeadCode" labelProperty="codeName" />
								</html:select></td>
						</tr>
						<tr>
							<td class="textborder">Minor Head Code<font color="#FF6666">*</font>
							</td>
							<td class="textborder"><html:select
									property="minorHeadCode" style="width:200px"
									styleClass="mycombo" onchange="javascript: getData()">
									<html:option value="">SELECT...</html:option>
									<html:options collection="minorheads" name="rwsMaster"
										property="minorHeadCode" labelProperty="codeName" />
								</html:select></td>
						</tr>
						<tr>
							<td class="textborder">Group Sub Head Code<font
								color="#FF6666">*</font>
							</td>
							<td class="textborder"><html:select
									property="grpSubHeadCode" style="width:200px"
									styleClass="mycombo" onchange="javascript: getData()">
									<html:option value="">SELECT...</html:option>
									<html:options collection="grpsubheads" name="rwsMaster"
										property="grpSubHeadCode" labelProperty="codeName" />
								</html:select></td>
						</tr>
						<tr>
							<td class="textborder">Sub Head Code<font color="#FF6666">*</font>
							</td>
							<td class="textborder"><html:select property="subHeadCode"
									style="width:200px" styleClass="mycombo">
									<html:option value="">SELECT...</html:option>
									<html:options collection="subheads" name="rwsMaster"
										property="subHeadCode" labelProperty="codeName" />
								</html:select></td>
						</tr>
						<tr>
							<td class="textborder">Detail Head Code<font color="#FF6666">*</font>
							</td>
							<td class="textborder"><html:text property="detailHeadCode"
									value="" styleClass="mytext" maxlength="3" style="width:200px"   onkeypress="return numeralsOnly(event)"	   />
							</td>
						</tr>
						<tr>
							<td class="textborder">Detail Head Name<font color="#FF6666">*</font>
							</td>
							<td class="textborder"><html:text property="detailHeadName"
									value="" styleClass="mytext" style="width:200px"   onkeypress="return textOnly(event)"	  /></td>
						</tr>
					</table> <%
 	String csrfToken = "";
 		nic.watersoft.commons.ValidationUtils valUtil = new nic.watersoft.commons.ValidationUtils();
 		csrfToken = valUtil.getCSRFCode();
 		session.setAttribute("csrfToken", csrfToken);
 %> <html:hidden property="token" styleClass="mytext"
						value="${sessionScope.csrfToken}" />
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center"><html:submit property="mode"
						title="Save the Fields" styleClass="btext" value="Save"
						onclick=" return validateDetailHeadForm(detailHeadForm)" /> <html:reset
						title="Clear all the Fields" styleClass="btext" value="Reset" />
					<html:submit property="mode" title="View the Fields"
						styleClass="btext" value="View" /></td>
			</tr>
		</table>

		<jsp:include page="/commons/TableFotter.jsp">
			<jsp:param name="TWidth" value="390" />
		</jsp:include>
	</html:form>
</body>
<%@ include file="/commons/rws_footer.jsp"%>
<%@ include file="/commons/rws_alert.jsp"%>
