<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="java.util.Date.*"%>
<%@ include file="conn.jsp"%>

<html>

<script language="Javascript">
	function wopen(url) {
		var width = 500;
		var height = 500;
		var left = parseInt((screen.availWidth / 2) - (width / 2));
		var top = parseInt((screen.availHeight / 2) - (height / 2));
		var properties = "width="
				+ width
				+ ",height="
				+ height
				+ ",screenX="
				+ left
				+ ",screenY="
				+ top
				+ ",toolbar=no,"
				+ "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
				+ "resizable=yes,status=yes,left=20,top=20";
		newWindow = window.open(url, "_New", properties);
		newWindow.focus();
	}
</script>
<%
	nic.watersoft.commons.RwsUser user = null;
	user = (nic.watersoft.commons.RwsUser) session
			.getAttribute("RWS_USER");
	String loggedUser = user.getUserId();

	int sno = 1;
	int habTotal = 0;
	int contaminatedHabCount = 0;
	ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null, rs5 = null, rs7 = null, rr = null, rr1 = null;
	PreparedStatement pstmt1 = null, pstmt2 = null, pstmt3 = null, pstmt4 = null, pstmt5 = null;
	boolean flag = false;
	boolean flag1 = false, flag2 = false, flag3 = false, flag4 = false, flag5 = false, flag6 = false;

	int florideCount = 0;
	int salinityCount = 0;
	int tDSCount = 0;
	int nitrateCount = 0;
	int ironCount = 0;
	int arsenicCount = 0;
	String dcode = request.getParameter("rDistrict");

	String dname = request.getParameter("rDistrictName");
	//System.out.println("Dcode"+dname);
	String finYear = request.getParameter("finyear");
	String type = request.getParameter("type");

	Calendar cal = Calendar.getInstance();
	int year1 = cal.get(Calendar.YEAR);
	int month = cal.get(Calendar.MONTH);
	if (month < 3) {
		year1--;
	}
	String year = String.valueOf(year1);
	int prevYear = Integer.parseInt(year) - 1;
	String habTableName = "";
	if (finYear != null && !finYear.equals("ALL")) {
		if (finYear.substring(0, 4).equals(year)) {
			habTableName = "rws_habitation_directory_tbl";
		} else if (finYear.substring(0, 4).equals(
				String.valueOf(prevYear))) {
			habTableName = "RWS_HABITATION_DIR_HIS_TBL";
		} else {
			habTableName = "RWS_HABITATION_DIR_HIS"
					+ finYear.substring(0, 4) + "_TBL";
		}
		System.out.println("Hab Table" + habTableName);
	} else {
		habTableName = "rws_habitation_directory_tbl";
	}
	String wqTbl = "";
	String wqResTbl = "";
	//System.out.println("Hab Table"+habTableName);
//	if (finYear.equals("ALL") || finYear.substring(0, 4).equals(year)) {
		wqTbl = "RWS_WQ_TEST_RESULTS_TBL";
		wqResTbl = "RWS_WQ_TEST_RESULTS_LNK_TBL";

//	} else {
//		String ffyear = finYear.substring(0, 4);

//		wqTbl = "RWS_WQ_TEST_RESULTS_TBL" + ffyear;
//		wqResTbl = "RWS_WQ_TEST_RES_LNK_TBL" + ffyear;
//	}
	//System.out.println("yy "+finYear.substring(2,4));
	//System.out.println("table 2:"+wqResTbl);

	session.setAttribute("habTable", habTableName);
%>
<form>
	<table border=1 cellspacing=0 cellpadding=0 width="100%"
		bordercolor=#000000 style="border-collapse: collapse"
		bgcolor="#ffffff" ALIGN=CENTER>
		<caption>
			<table border=0 rules=none style="border-collapse: collapse"
				align="right">

				<%
					if (loggedUser != null && !loggedUser.equals(Constants.SEC_USER)) {
				%>
				<tr>
					<td align="right" class="bwborder"><a
						href="javascript:onclick=history.go(-1)">Back&nbsp;|</a><a
						href="../home.jsp">Home</a></td>
				</tr>
				<%
					} else {
				%>
				<tr>
					<td align="right" class="bwborder"><a
						href="javascript:onclick=history.go(-1)">Back&nbsp;|</a><a
						href="#" onclick="window.close()">Close</a></td>
				</tr>
				<%
					}
				%>




			</table>
		</caption>

		<tr bgcolor="#8A9FCD" align="center">
			<td align="center" class="rptHeading" colspan="14"><%=dname%>
				DISTRICT WATER QUALITY Vs HABITATION COVERAGE (<%=finYear%>)</td>
		</tr>


	</table>
	<table bgcolor="#FFFFFF" bordercolor="#8A9FCD" width="80%" border=1
		style="border-collapse: collapse" ALIGN=CENTER>
		<tr align=center>

			<td class=btext>Sl.No</td>
			<td class=btext>District</td>
			<td class=btext>Total No Of Habs</td>
			<td class=btext>No Of Habs Contaminated</td>
			<td class=btext>FLUORIDE</td>
			<td class=btext>SALINITY</td>
			<td class=btext>TDS</td>
			<td class=btext>NITRATE</td>
			<td class=btext>IRON</td>
			<td class=btext>ARSENIC</td>

		</tr>

		<%
			HashMap records = new HashMap();
			HashMap parameterVaulesHash = new HashMap();
			Set florideList = new HashSet();
			Set salinityList = new HashSet();
			Set tdsList = new HashSet();
			Set nitrateList = new HashSet();
			Set ironList = new HashSet();
			Set arscList = new HashSet();
			Set contamiNatedHabs = new HashSet();

			//Subsurface sources (Bore well (Hand pump, Shallow Hand pump), Tube well, filter points, open well)

			//Surface sources (River, Canal, Reservoir(GLSR,GLBR,OHSR), Ponds)

			try {
				String q2 = "";

				if (type.equals("1")) {
					q2 = "select distinct a.TEST_ID,a.TEST_CODE,b.hab_code from "
							+ wqTbl + "  a, " + habTableName + "  b  where ";
					if (!finYear.equals("ALL")) {

q2 += " to_date(to_char(a.prepared_on,'dd/mm/yyyy'),'dd/mm/yyyy')>=to_date('01/04/"+finYear.substring(0, 4)+"','dd/mm/yyyy') and ";
q2 += " to_date(to_char(a.prepared_on,'dd/mm/yyyy'),'dd/mm/yyyy')<=to_date('31/03/"+finYear.substring(5, 9)+"','dd/mm/yyyy') and ";
						//q2 += " SUBSTR(TEST_ID,4,2)='"
						//		+ finYear.substring(2, 4) + "' and ";
					}
					q2 += " SUBSTR(a.SOURCE_CODE,1,16)=b.hab_code and substr(b.hab_code,1,2)=? and ((a.SOURCE_CODE in (select POND_CODE from RWS_OPENWELL_POND_TBL)) or (a.SOURCE_CODE in (select OPENWELL_CODE from rws_open_well_mast_tbl)) or  (a.SOURCE_CODE in (select HP_CODE from rws_hp_subcomp_param_tbl)) or (a.source_code in (select SHALLOWHP_CODE from rws_shallowhandpumps_tbl))) and b.COVERAGE_STATUS <>'UI' and  (a.PREPARED_ON=(select  MAX(c.prepared_on) from  "
							+ wqTbl + " c where c.source_code=a.source_code))";
				} else if (type.equals("2")) {
					q2 = "select distinct a.TEST_ID,a.TEST_CODE ,b.hab_code from "
							+ wqTbl + " a ," + habTableName + "  b where  ";
					if (!finYear.equals("ALL")) {

q2 += " to_date(to_char(a.prepared_on,'dd/mm/yyyy'),'dd/mm/yyyy')>=to_date('01/04/"+finYear.substring(0, 4)+"','dd/mm/yyyy') and ";
q2 += " to_date(to_char(a.prepared_on,'dd/mm/yyyy'),'dd/mm/yyyy')<=to_date('31/03/"+finYear.substring(5, 9)+"','dd/mm/yyyy') and ";
						//q2 += " SUBSTR(TEST_ID,4,2)='"
						//		+ finYear.substring(2, 4) + "' and ";
					}
					q2 += " SUBSTR(a.SOURCE_CODE,1,16)=b.hab_code  and substr(b.hab_code,1,2)=? and (a.SOURCE_CODE in (select POND_CODE from RWS_OPENWELL_POND_TBL)) and b.COVERAGE_STATUS <>'UI' and  (a.PREPARED_ON=(select  MAX(c.prepared_on) from  "
							+ wqTbl + " c where c.source_code=a.source_code))";
				} else if (type.equals("3")) {
					q2 = "select distinct a.TEST_ID,a.TEST_CODE,b.hab_code from "
							+ wqTbl + " a," + habTableName + "  b where ";
					if (!finYear.equals("ALL")) {
						q2 += " to_date(to_char(a.prepared_on,'dd/mm/yyyy'),'dd/mm/yyyy')>=to_date('01/04/"+finYear.substring(0, 4)+"','dd/mm/yyyy') and ";
						q2 += " to_date(to_char(a.prepared_on,'dd/mm/yyyy'),'dd/mm/yyyy')<=to_date('31/03/"+finYear.substring(5, 9)+"','dd/mm/yyyy') and ";
						//q2 += " SUBSTR(TEST_ID,4,2)='"
						//		+ finYear.substring(2, 4) + "' and ";
					}

					q2 += " SUBSTR(a.SOURCE_CODE,1,16)=b.hab_code  and substr(b.hab_code,1,2)=? and ((a.SOURCE_CODE in (select OPENWELL_CODE from rws_open_well_mast_tbl)) or  (a.SOURCE_CODE in (select HP_CODE from rws_hp_subcomp_param_tbl)) or (a.source_code in (select SHALLOWHP_CODE from rws_shallowhandpumps_tbl))) and  (a.PREPARED_ON=(select  MAX(c.prepared_on) from  "
							+ wqTbl
							+ " c where c.source_code=a.source_code)) and  b.COVERAGE_STATUS <>'UI'";
				}

				System.out.println("q2===" + q2);
				pstmt2 = conn.prepareStatement(q2);
				String qq = "SELECT distinct TESTING_PARAMETER_CODE,MAX_PERMISSIBLE_VALUE FROM RWS_WQ_PARA_TEST_TBL WHERE my_to_number(MAX_PERMISSIBLE_VALUE) is not null";
				pstmt3 = conn.prepareStatement(qq);

				String q = "SELECT distinct a.TESTING_PARAMETER_CODE,a.TESTING_PARAMETER_VALUE  FROM "
						+ wqResTbl
						+ " a WHERE a.TEST_ID=? and a.TESTING_PARAMETER_VALUE is not null and my_to_number(a.TESTING_PARAMETER_VALUE) is not null and (a.TESTING_PARAMETER_CODE =? or  a.TESTING_PARAMETER_CODE=? or  a.TESTING_PARAMETER_CODE=? or  a.TESTING_PARAMETER_CODE=? or a.TESTING_PARAMETER_CODE=? or a.TESTING_PARAMETER_CODE=?)";
				pstmt5 = conn.prepareStatement(q);

				rr = pstmt3.executeQuery();
				while (rr.next()) {
					if (rr.getString(2) != null
							&& !rr.getString(2).equals("null")) {
						parameterVaulesHash.put(rr.getString(1),
								rr.getString(2));
					}
				}
				//System.out.println("Completed");	
				String mainQuery, q10;
				if (dname != null && dname.equals("ALL")) {
					mainQuery = "select  dcode,dname from rws_district_tbl where dcode<> '16'";
					pstmt1 = conn.prepareStatement(mainQuery);
				} else {
					mainQuery = "select  dcode,dname from rws_district_tbl  where dcode=? and dcode<> '16'";
					pstmt1 = conn.prepareStatement(mainQuery);
					pstmt1.setString(1, dcode);
				}
				rs1 = pstmt1.executeQuery();
				while (rs1.next()) //habCode Change
				{
					double value = 0;
					pstmt2.setString(1, rs1.getString(1));
					rs4 = pstmt2.executeQuery();
					int cnt = 0;
					while (rs4.next()) // sourcess loop
					{

						if (contamiNatedHabs.contains(rs4.getString(3))) {

							continue;
						}
						pstmt5.setString(1, rs4.getString(1));
						pstmt5.setInt(2, 13);
						pstmt5.setInt(3, 12);
						pstmt5.setInt(4, 05);
						pstmt5.setInt(5, 15);
						pstmt5.setInt(6, 16);
						pstmt5.setInt(7, 24);
						//System.out.println("pstmt5 ==" + q);
						rs7 = pstmt5.executeQuery();
						//System.out.println("Test ID"+rs4.getString(1));
						while (rs7.next()) {
							double actValue = Double
									.parseDouble((String) parameterVaulesHash
											.get(rs7.getString(1)));
							value = Double.parseDouble(rs7.getString(2));
							//	System.out.println("Value:"+value);
							//	System.out.println("ActValue:"+actValue);
							if (rs7.getString(1).equals("12")) {
								value = 0.03 + ((1.806 * value) / 1000);
								actValue = 1.836;
							}

							if (value > actValue) {

								//System.out.println("Value:"+value);
								//System.out.println("ActValue:"+actValue);						
								flag = true;
								if (rs7.getString(1).equals("13")) { //  FLOURID
									flag1 = true;
									break;
								} else if (rs7.getString(1).equals("12")) { //  SALNITY
									flag2 = true;
									break;
								} else if (rs7.getString(1).equals("05")) { // TDS
									flag3 = true;
									break;
								} else if (rs7.getString(1).equals("15")) { // NITRATE
									flag4 = true;
									break;
								} else if (rs7.getString(1).equals("16")) { // IRON
									flag5 = true;
									break;
								} else if (rs7.getString(1).equals("24")) { // ARSENIC
									flag6 = true;
									break;
								}

							}

						}

						if (flag) {

							contamiNatedHabs.add(rs4.getString(3));
						}
						if (flag1) {
							florideCount += 1;
							florideList.add(rs1.getString(1) + "@"
									+ rs4.getString(3) + "@" + value);
						}
						if (flag2) {
							tDSCount += 1;
							tdsList.add(rs1.getString(1) + "@"
									+ rs4.getString(3) + "@" + value);
						}
						if (flag3) {
							salinityCount += 1;
							salinityList.add(rs1.getString(1) + "@"
									+ rs4.getString(3) + "@" + value);
						}
						if (flag4) {
							nitrateCount += 1;
							nitrateList.add(rs1.getString(1) + "@"
									+ rs4.getString(3) + "@" + value);
						}
						if (flag5) {
							ironCount += 1;
							ironList.add(rs1.getString(1) + "@"
									+ rs4.getString(3) + "@" + value);
						}
						if (flag6) {
							arsenicCount += 1;
							arscList.add(rs1.getString(1) + "@"
									+ rs4.getString(3) + "@" + value);
						}
						flag = false;
						flag1 = false;
						flag2 = false;
						flag3 = false;
						flag4 = false;
						flag5 = false;
						flag6 = false;
					}

					pstmt4 = conn
							.prepareStatement("select count(*) from "
									+ habTableName
									+ " where substr(hab_code,1,2)=? and COVERAGE_STATUS <>'UI'");
					pstmt4.setString(1, rs1.getString(1));
					rs2 = pstmt4.executeQuery();
					if (rs2.next())
						cnt = rs2.getInt(1);
					contaminatedHabCount = contamiNatedHabs.size();
					contamiNatedHabs.clear();

					records.put(rs1.getString(1), "" + cnt + "@"
							+ contaminatedHabCount + "@" + florideCount + "@"
							+ salinityCount + "@" + tDSCount + "@"
							+ nitrateCount + "@" + ironCount + "@"
							+ arsenicCount);
					contaminatedHabCount = 0;
					florideCount = 0;
					arsenicCount = 0;
					salinityCount = 0;
					nitrateCount = 0;
					ironCount = 0;
					tDSCount = 0;
				}//End District loop
				session.setAttribute("flist", florideList);
				session.setAttribute("slist", salinityList);
				session.setAttribute("tdslist", tdsList);
				session.setAttribute("nitrateList", nitrateList);
				session.setAttribute("ironList", ironList);
				session.setAttribute("arsenicList", arscList);
				rs1.close();
				pstmt1.close();
				pstmt1 = conn.prepareStatement(mainQuery);
				if (dname != null && !dname.equals("ALL")) {
					pstmt1.setString(1, dcode);
				}
				rs1 = pstmt1.executeQuery();
				while (rs1.next()) {
					String r = (String) records.get(rs1.getString(1));
					String rec[] = r.split("@");
					habTotal = 0;
					habTotal += Integer.parseInt(rec[0]);
		%>


		<tr>
			<td class=rptvalue><%=sno++%></td>
			<td class=rptvalue><%=rs1.getString(2)%></td>
			<td class=rptvalue><%=rec[0]%></td>
			<td class=rptvalue><%=rec[1]%></td>
			<td class=rptvalue><a href="#"
				onClick="wopen('rws_WQ_Hab_View.jsp?dcode=<%=rs1.getString(1)%>&type=1')"><%=rec[2]%></a></td>
			<td class=rptvalue><a href="#"
				onClick="wopen('rws_WQ_Hab_View.jsp?dcode=<%=rs1.getString(1)%>&type=2')"><%=rec[3]%></a></td>
			<td class=rptvalue><a href="#"
				onClick="wopen('rws_WQ_Hab_View.jsp?dcode=<%=rs1.getString(1)%>&type=3')"><%=rec[4]%></a></td>
			<td class=rptvalue><a href="#"
				onClick="wopen('rws_WQ_Hab_View.jsp?dcode=<%=rs1.getString(1)%>&type=4')"><%=rec[5]%></a></td>
			<td class=rptvalue><a href="#"
				onClick="wopen('rws_WQ_Hab_View.jsp?dcode=<%=rs1.getString(1)%>&type=5')"><%=rec[6]%></a></td>
			<td class=rptvalue><a href="#"
				onClick="wopen('rws_WQ_Hab_View.jsp?dcode=<%=rs1.getString(1)%>')"
				&type=6> <%=arsenicCount%></a></td>
		</tr>
		<%
			}
		%>
		<tr>
			<td></td>
			<td class=btext>Total:</td>
			<td class=btext><%=habTotal%></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</tr>
		<%
			} catch (Exception e) {
				e.printStackTrace();
			}
		%>

	</table>
</html>