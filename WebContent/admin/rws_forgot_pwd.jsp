<%@ include file="/commons/rws_header1.jsp"%>



<script>
	function getData() {
		document.forms[0].action = "switch.do?prefix=/admin&page=/forgotPassword.do&mode=get";
		document.forms[0].submit();
	}
	function resetUser() {

		if (document.forms[0].elements["userId"].value == "") {
			alert("Enter User ID");
			return;
		}

/* 		if (document.forms[0].elements["selectOption"].value == "0") {
			alert("Please Select to Password Sent To.");
			return;
		} */
		//if (document.forms[0].elements["selectOption"].value == "email") {
			if (document.forms[0].elements["registeredMailId"].value == "Not Registered"
				|| document.forms[0].elements["registeredMailId"].value == "-"
					|| document.forms[0].elements["registeredMailId"].value == "") {
				var res = confirm("You don't have registered email, do you want to send new password to higher level authority registered email?");
				return res;
			}

		//}
		/* else if (document.forms[0].elements["selectOption"].value == "mobile") {
			if (document.forms[0].elements["registeredMobileNo"].value == "Not Registered"
					|| document.forms[0].elements["registeredMobileNo"].value == "") {
				alert("You are Not Yet Register Mobile Number");
				return;
			}
		} */

		/* if (document.forms[0].elements["number"].value == "") {
			alert("Enter Security Code");
			return;
		} */
		<%-- else
		{
			if (<%=session.getAttribute("forgotkey")%> != null) {

				var key = <%=(String) session.getAttribute("forgotkey")%>;
				var enteredKey = document.forms[0].elements["number"].value;
				if (key!=enteredKey) {
					alert("You are Entered Wrong Security Code");
					return;
				}

			}
		} --%>

		document.forms[0].elements["sbtButton"].value = "Sending.........";

		document.forms[0].action = "switch.do?prefix=/admin&page=/forgotPassword.do&mode=reset";
		document.forms[0].submit();

	}

	/* function view() {

		if (document.forms[0].selectOption.value == "email") {
			document.getElementById('mobilecontent').style.display = 'none';
			document.getElementById('emailcontent').style.display = 'block';

		}
		if (document.forms[0].selectOption.value == "mobile") {
			document.getElementById('emailcontent').style.display = 'none';
			document.getElementById('mobilecontent').style.display = 'block';
		}

	} */
</script>

<body bgcolor="#A1CADB">
	<html:form action="forgotPassword.do" method="post">
		<br></br>
		<br></br>
		<br></br>
		<br></br>
		<br></br>
		<table align="center" cellpadding="0" cellspacing="0" width="500">
			<thead>
				<tr align=right valign=middle>
					<td><a href="/pred/rws_login_frm.jsp"> <font face=verdana
							size=2 color=BLUE><B>Home</B></font>
					</a></td>
				</tr>
				<tr>
					<td><jsp:include page="/commons/TableHeaderWithoutClose.jsp">
							<jsp:param name="TableName" value="Forgot Password" />
							<jsp:param name="TWidth" value="100%" />
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
					<td align="center">
						<table bgcolor="white" border="1" bordercolor="#8A9FCD"
							width="500" rules="none" style="border-collapse: collapse">
							<tr>
								<td class="btext">Enter UserId:<font color="red"><b>*</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<html:text
										property="userId" onblur="getData();view();"></html:text></td>
							</tr>
							<%-- 						<tr><td class="btext">Circle:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<html:text property="circleOfficeName" readonly="true"></html:text></td></tr>
						<tr><td class="btext">Division:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<html:text property="divOfficeName" readonly="true"></html:text></td></tr> --%>

							<tr>
								<td class="btext">Circle:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font
									color="green"><b><html:hidden
												property="circleOfficeName"></html:hidden>
											<bean:write property="circleOfficeName"
												name="forgotPasswordBean"></bean:write></b></font></td>
							</tr>
							<tr>
								<td class="btext">Division:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font
									color="green"><b><html:hidden
												property="divOfficeName"></html:hidden>
											<bean:write property="divOfficeName"
												name="forgotPasswordBean"></bean:write></b></font></td>
							</tr>
							<tr>
								<td class="btext">Registered Email
									ID:&nbsp;&nbsp;&nbsp;&nbsp;<font color="green"><b><html:hidden
												property="registeredMailId"></html:hidden>
											<bean:write property="registeredMailId"
												name="forgotPasswordBean"></bean:write></b></font>
								</td>
							</tr>
							<tr><td class="btext"><br/></td></tr>
							<tr>
								<td align="center" class="btext" colspan="2"><input
									type="button" value="Reset Password" id="sbtButton"
									class="btext" onclick="resetUser();"></input></td>
							</tr>
							<%-- <tr><td class="btext">Password Sent to:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<html:select property="selectOption"
							style="width:153px" styleClass="mycombo" onchange="javascript:view();" >
							<html:option value="0">
								<font class="myfontclr1">Select...
							</html:option>
							
							<html:option value="email">
								<font class="myfontclr1">Registered Email ID
							</html:option>
							<html:option value="mobile">
								<font class="myfontclr1">Registered Mobile
							</html:option>
							
						</html:select> </td></tr> --%>

						</table> <%-- <div style="display:block"; id="emailcontent">
						<table width="500" bgcolor="white" border="1" bordercolor="#8A9FCD" rules="none"
				style="border-collapse: collapse">
				<tr><td class="btext">Registered Email ID:<font color="green"><b><html:hidden property="registeredMailId"></html:hidden><bean:write property="registeredMailId"  name="forgotPasswordBean"></bean:write></b></font></td></tr>
			</table>
						</div> 
						
						<div style="display:none" id="mobilecontent">
						<table width="500"  bgcolor="white" border="1" bordercolor="#8A9FCD" rules="none"
				style="border-collapse: collapse">
				<tr><td class="btext">Registered Mobile:&nbsp;&nbsp;&nbsp;<font color="green"><b><html:hidden property="registeredMobileNo"></html:hidden><bean:write property="registeredMobileNo" name="forgotPasswordBean" ></bean:write></b></font></td></tr>
			</table>
						</div> --%>
						<!-- <table width="500" bgcolor="white" border="1"
							bordercolor="#8A9FCD" rules="none"
							style="border-collapse: collapse"> -->
							<%-- <tr>
								<td>
									<fieldset>
										<legend>Security Code</legend>
										<label>
											<div id="captcha"><%@include file="/Captcha/form.jsp"%></div>
										</label>
									</fieldset>
								</td>
							</tr> --%>
							
							
					<!-- 	</table> -->
					</td>
				</tr>


			</tbody>

		</table>
		<br></br>
		<br></br>
		<br></br>
		<br></br>
		<br></br>
		<br></br>
		<center>
			<table>
				<tr>
					<td valign="bottom" class="pageFooter" align="center">
						Designed & Developed by National Informatics Centre, AP State
						Centre</td>
				</tr>
			</table>
		</center>
	</html:form>

</body>
<%@ include file="/commons/rws_alert.jsp"%>
