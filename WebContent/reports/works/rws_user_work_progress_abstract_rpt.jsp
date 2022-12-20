<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.util.*"%>
<%
	String query = null;
	nic.watersoft.commons.RwsUser user = null;
	user = (nic.watersoft.commons.RwsUser) session
			.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();
%>
<html>
<head>

<script language="JavaScript">
	function fnSubmit() {
		
		if (document.f1.district.value == '') {
			alert("Please Select District");
			return false;
		} 
		else if (document.f1.program.value == '') {
			alert("Please Select Programmes");
			return false;
		}
		else {
			
			document.f1.action = "./rws_user_ongoing_works_abs_cm_rpt.jsp";
			document.f1.submit();
		}
	}
</script>

</head>
<body bgcolor="#edf2f8">
	<form name=f1 action="<%=request.getRequestURI()%>" method="post">
		<table border=1 align=center cellspacing=0 cellpadding=0 rules="rows"
			bordercolor=navy style="border-collapse: collapse" bgcolor="#ffffff"
			width=350>
			<caption>
				<table border=0 rules=none style="border-collapse: collapse" width=100% align="right" bgcolor="#edf2f8">
					<tr>
						<td align="right" class="bwborder"><a href="/pred/home.jsp?loginMode=watersoft">Home</a></td>
					</tr>
				</table>
			</caption>
			<tr bgcolor="#8A9FCD" align="center">
				<td align="center" class="rptHeading" colspan=4>Work Progress
					Abstract Report</td>
			</tr>

			<%
				try {
					String dcode = request.getParameter("district");

					if (loggedUser.substring(0, 3).equals("col")) {
						dcode = (String) session.getAttribute("district");
					}
			%>
			<tr>
				<td class=rptLabel>District&nbsp;&nbsp;<font color="red">*</font></td>
				<td class=btext>
					<%
						if (loggedUser != null
									&& (loggedUser.equals("admin")
											|| loggedUser.equals("100000")
											|| loggedUser.equals("guest")
											|| loggedUser.substring(0, 3).equals("col") || loggedUser.substring(0, 2).equals("ce") || loggedUser
												.equals("secrwss"))) {
					%> <SELECT name="district" id="combo" class="mycombo"
					style="width: 150px" onchange="this.form.submit()">

						<option value="00">ALL</option>
						<%
							stmt = conn.createStatement();
									query = "SELECT distinct dcode,dname  from rws_district_tbl where dcode <>16 ";

									query += " order by dcode";
									rs = stmt.executeQuery(query);
									while (rs.next()) {
										if (rs.getString(1).equals(dcode)) {
						%>
						<option value="<%=rs.getString(1)%>" selected><%=rs.getString(2)%></option>
						<%
							} else {
						%>
						<option value="<%=rs.getString(1)%>"><%=rs.getString(2)%></option>
						<%
							}
									}
									rs.close();
									stmt.close();
								} else {

									stmt = conn.createStatement();

									query = "SELECT dcode,dname from rws_district_tbl where dcode='"
											+ loggedUser.substring(1, 3) + "'";
									rs = stmt.executeQuery(query);
									if (rs.next()) {
										dcode = rs.getString(1);
						%>
						<input type="text" name="dname" readonly="true" class="mytext"
						style="width: 150px" value="<%=rs.getString(2)%>">
						<input type="hidden" name="district" value="<%=rs.getString(1)%>">
						<%
							}
								}
						%>
				</SELECT>
				</td>
			</tr>


			<tr>

				<td class=rptLabel>Programme&nbsp;&nbsp;<font color="red">*</font></td>
				<td class=btext><SELECT name="program" id="combo" class="mycombo"
					style="width: 150px">

						<option value="all">ALL</option>
						<%
							String progCode = "";
								String nrdwpQuery = "select PROGRAMME_CODE from  rws_programme_tbl where NRDWP_RELATED='Y' order by 1";
								Statement statement = conn.createStatement();
								ResultSet resultSet = statement.executeQuery(nrdwpQuery);
								while (resultSet.next()) {
									if (!progCode.equals("")) {
										progCode = progCode + "," + resultSet.getString(1);
									} else {
										progCode = resultSet.getString(1);
									}
								}
								resultSet.close();
								statement.close();
								if (!progCode.equals("")) {
						%>
						<option value=<%=progCode%>>NRDWP Related</option>
						<%
							}
						%>

						<%
							Statement stmt2 = conn.createStatement();
								String query2 = "select * from  rws_programme_tbl  where programme_code in ('04','65','57')";
								ResultSet rs2 = stmt2.executeQuery(query2);
								while (rs2.next()) {
						%>
						<option value="<%=rs2.getString(1)%>"><%=rs2.getString(2)%></option>
						<%
							}
								rs2.close();
						%>
				</SELECT></td>



			</tr>
			<%
				} catch (Exception e) {
					e.printStackTrace();
				}
			%>
			<tr bgcolor="#8A9FCD" align="center">
				<td colspan=4 align="center"><input type=button id="vbutton"
					onclick="fnSubmit()" class=btext value="Submit"></td>
			</tr>

		</table>

		<INPUT type="hidden" name="dname"> <INPUT type="hidden"
			name="pname">


	</form>
</body>
</html>