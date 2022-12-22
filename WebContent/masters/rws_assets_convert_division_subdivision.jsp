
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ include file="/reports/conn.jsp"%>
<%
	String query = null, query1 = null;
	nic.watersoft.commons.RwsUser user = null;
	user = (nic.watersoft.commons.RwsUser) session.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
	PreparedStatement stmt1 = null, stmt2 = null;
	ResultSet rs1 = null, rs2 = null;
	String rDivion = null;
	String rCircle = null;;
	String rSubDivision = null;
	String assetCode = null;
	rDivion = request.getParameter("division");
	rCircle = request.getParameter("circle");
	rSubDivision = request.getParameter("subDivision");
%>
<html>
<head>
<script language="JavaScript">
	function fnSubmit() {
		var circle = document.forms[0].circle.value;
		var division = document.forms[0].division.value;
		var subDivision = document.forms[0].subDivision.value;

		if (circle == "-1") {
			alert("please Select Circle");
			return false;
		} else if (division == "-1") {
			alert("please Select Division");
			return false;
		} else if (subDivision == "-1") {
			alert("please Select Sub Division");
			return false;
		}
		else {
			document.forms[0].action = "switch.do?prefix=/masters&page=/AssetChange.do&mode=getData";
			document.forms[0].submit();
		}
	}
	
</script>
</head>
<body bgcolor="#edf2f8" onload="check()">
	<form action="<%=request.getRequestURI()%>" method="post">
		<table border=1 align=center cellspacing=0 cellpadding=0 rules="rows"
			bordercolor=navy style="border-collapse: collapse" bgcolor="#ffffff"
			width=350>
			<caption>
				<table border=0 rules=none style="border-collapse: collapse"
					width=100% align="right" bgcolor="#edf2f8">
					<tr align="right">
						<td><a href="/pred/home.jsp?loginMode=watersoft">Home
								|&nbsp; <a href="javascript:onclick=history.go(-1)">Back </td>
					</tr>
				</table>
			</caption>
			<tr bgcolor="#8A9FCD" align="center">
				<td align="center" class="rptHeading" colspan=3>Change of
					Division and Sub Division</td>
			</tr>
			<%
				try {
			%>
			<tr>
				<td colspan=2>
					<table border=1 align=center cellspacing=0 cellpadding=0
						rules="rows" bordercolor=navy style="border-collapse: collapse"
						bgcolor="#ffffff" width=350>
						<%
							if (loggedUser.toString() != null && (loggedUser.toString().equals(Constants.ADMIN)
										|| loggedUser.toString().equals(Constants.LAKH_USER)
										|| loggedUser.toString().equals(Constants.GUEST)
										|| loggedUser.toString().equals(Constants.DROUGHT_USER)
										|| loggedUser.toString().equals(Constants.SEC_USER))) {
						%>
						<tr>
							<td class=rptLabel>Circle&nbsp;&nbsp;<font color="red">*</font></td>
							<td class=btext><SELECT name="circle" class="mycombo"
								style="width: 150px" onChange="this.form.submit()">
									<option value="-1" SELECTED>SELECT..</option>
									<%
										String query3 = "select distinct a.circle_office_code from  rws_asset_mast_tbl a,rws_mandal_subdivision_tbl b where substr(a.hab_code,1,2)=b.dcode and substr(a.HAB_CODE,6,2)=b.MCODE and a.circle_office_code=b.circle_office_code  and  (a.division_office_code <> b.division_office_code or a.subdivision_office_code <> b.subdivision_office_code)";
												stmt1 = conn.prepareStatement(query3);
												rs1 = stmt1.executeQuery();
												while (rs1.next()) {
													query = "select  distinct * from RWS_CIRCLE_OFFICE_TBL where circle_office_code=?";
													ps = conn.prepareStatement(query);
													ps.setString(1, rs1.getString(1));
													rs = ps.executeQuery();
													if (rs.next()) {
														if (rCircle != null && rCircle.equals(rs.getString(2))) {
									%>
									<option value="<%=rs.getString(2)%>" SELECTED><%=rs.getString(3)%></option>
									<%
										} else {
									%>
									<option value="<%=rs.getString(2)%>"><%=rs.getString(3)%></option>
									<%
										}
													}
													rs.close();
													ps.close();
												}
												rs1.close();
												stmt1.close();
									%>

							</SELECT></td>
						</tr>
						<%
							} else {
									query = "select  distinct * from RWS_CIRCLE_OFFICE_TBL where circle_office_code=? ";
									ps = conn.prepareStatement(query);
									ps.setString(1, loggedUser.substring(1, 3));
									rs = ps.executeQuery();
									if (rs.next()) {
						%>

						<tr>
							<td class=rptLabel>Circle&nbsp;&nbsp;<font color="red">*</font></td>
							<td class=btext><input type="text" name="circleName"
								value=<%=rs.getString(3)%> class="mytext" style="width: 150px"
								readonly /> <input type="hidden" name="circle"
								value="<%=rs.getString(2)%>" /></td>
						</tr>
						<%
							}
									ps.close();
									rs.close();

								}
						%>
						<%
							if (loggedUser.toString() != null && (loggedUser.toString().equals(Constants.ADMIN)
										|| loggedUser.toString().equals(Constants.LAKH_USER)
										|| loggedUser.toString().equals(Constants.GUEST)
										|| loggedUser.toString().equals(Constants.DROUGHT_USER)
										|| loggedUser.toString().equals(Constants.SEC_USER))) {
						%>
						<tr>
							<td class=rptLabel>Exist Division<font color="red">*</font></td>
							<td class=btext><SELECT name="division" class="mycombo"
								style="width: 150px" onChange="this.form.submit()">
									<option value="-1" SELECTED>SELECT..</option>
									<%
										query1 = "select distinct a.division_office_code from  rws_asset_mast_tbl a,rws_mandal_subdivision_tbl b where substr(a.hab_code,1,2)=b.dcode and a.circle_office_code=?"
												+ " and substr(a.HAB_CODE,6,2)=b.MCODE and a.circle_office_code=b.circle_office_code  and  (a.division_office_code <> b.division_office_code or a.subdivision_office_code <> b.subdivision_office_code)";
												stmt1 = conn.prepareStatement(query1);
												stmt1.setString(1, rCircle);
												rs1 = stmt1.executeQuery();
												while (rs1.next()) {
													query = "select  distinct * from RWS_DIVISION_OFFICE_TBL where circle_office_code=? and division_office_code=? and status <> 'UI'";
													ps = conn.prepareStatement(query);
													ps.setString(1, rCircle);
													ps.setString(2,  rs1.getString(1));
													rs = ps.executeQuery();
													if (rs.next()) {
														if (rDivion != null && rDivion.equals(rs.getString(3))) {
									%>
									<option value="<%=rs.getString(3)%>" SELECTED><%=rs.getString(4)%></option>
									<%
										} else {
									%>
									<option value="<%=rs.getString(3)%>"><%=rs.getString(4)%></option>
									<%
										}
													}
													rs.close();
													ps.close();
												}
												rs1.close();
												stmt1.close();
									%>

							</select></td>
						</tr>
						<%
							} else {
						%>
						<tr>
							<td class=rptLabel>Exist Division<font color="red">*</font></td>
							<td class=btext><SELECT name="division" class="mycombo"
								style="width: 150px" onChange="this.form.submit()">
									<option value="-1" SELECTED>SELECT..</option>
									<%
										query1 = "select distinct a.division_office_code from  rws_asset_mast_tbl a,rws_mandal_subdivision_tbl b where substr(a.hab_code,1,2)=b.dcode and "
										+" a.circle_office_code=?  and substr(a.HAB_CODE,6,2)=b.MCODE and a.circle_office_code=b.circle_office_code  and  "
										+" (a.division_office_code <> b.division_office_code or a.subdivision_office_code <> b.subdivision_office_code)";
												//System.out.println("query1" + query1);
												stmt1 =conn.prepareStatement(query1);
												stmt1.setString(1,  loggedUser.substring(1, 3));
												rs1 = stmt1.executeQuery();
												while (rs1.next()) {											

													query = "select  distinct * from RWS_DIVISION_OFFICE_TBL where circle_office_code=/ and division_office_code=? and status <> 'UI'";
													ps = conn.prepareStatement(query);
													ps.setString(1, loggedUser.substring(1, 3));
													ps.setString(2,  rs1.getString(1));
													rs = ps.executeQuery();
													if (rs.next()) {
														if (rDivion != null && rDivion.equals(rs.getString(3))) {
									%>
									<option value="<%=rs.getString(3)%>" SELECTED><%=rs.getString(4)%></option>
									<%
										} else {
									%>
									<option value="<%=rs.getString(3)%>"><%=rs.getString(4)%></option>
									<%
										}
													}
													rs.close();
													ps.close();
												}
												rs1.close();
												stmt1.close();
									%>


							</select></td>
						</tr>
						<%
							}
						%>
						<tr>
							<td class=rptLabel>Exist Sub&nbsp;Division<font color="red">*</font></td>
							<td class=btext><SELECT name="subDivision" class="mycombo"
								style="width: 150px">
									<option value="-1" SELECTED>SELECT..</option>
									<%
										query1 = "select distinct a.subdivision_office_code from  rws_asset_mast_tbl a,rws_mandal_subdivision_tbl b where substr(a.hab_code,1,2)=b.dcode and a.circle_office_code=?"
													+  " and a.division_office_code=? and substr(a.HAB_CODE,6,2)=b.MCODE and a.circle_office_code=b.circle_office_code  and  (a.division_office_code <> b.division_office_code or a.subdivision_office_code <> b.subdivision_office_code)";
											stmt1 = conn.prepareStatement(query1);
													stmt1.setString(1, rCircle);
													stmt1.setString(2, rDivion);
											rs1 = stmt1.executeQuery();
											while (rs1.next()) {										
												query = "select  distinct * from RWS_SUBDIVISION_OFFICE_TBL where CIRCLE_OFFICE_CODE=? and DIVISION_OFFICE_CODE=? and SUBDIVISION_OFFICE_CODE=?";
												ps = conn.prepareStatement(query);
												ps.setString(1, rCircle);
												ps.setString(2, rDivion);
												ps.setString(3,  rs1.getString(1) );
												rs = ps.executeQuery();
												if (rs.next()) {
													if (rDivion != null && rDivion.equals(rs.getString(4))) {
									%>
									<option value="<%=rs.getString(4)%>" SELECTED><%=rs.getString(5)%></option>
									<%
										} else {
									%>
									<option value="<%=rs.getString(4)%>"><%=rs.getString(5)%></option>
									<%
										}
												}
												rs.close();
												ps.close();
											}
											rs1.close();
											stmt1.close();
									%>


							</select></td>
						</tr>



					</table>

				</td>
			</tr>
			<tr>
				<td colspan=3 align=center><input type=button
					onclick="fnSubmit()" class=btext value="GetData"></td>
			</tr>
		</table>
		<br /> <br /> <br /> <br /> <br /> <br />

		<table align="center">
			<tr align="center">
				<td class="rptValue"><font color="red" size="3"><b>Note:
					</b></font><font color="green" size="2"><b>If Mandal existing in
							more than one Sub Division</b></font></td>
			</tr>
			<tr align="center">
				<td class="rptValue"><font color="red"></font><font
					color="green" size="2"><b>We are giving facility to
							update Division and Sub Division.</b></font></td>
			</tr>


		</table>

		<%
}
catch(Exception e){
	/* e.printStackTrace(); */
}
finally{
	
}
%>
		<%@ include file="/reports/footer.jsp"%>
	</form>
</body>
</html>
