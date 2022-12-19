<%@page import="nic.watersoft.works.WorksData1"%>
<%@page import="java.sql.Connection"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>



<%
	DecimalFormat ndf = new DecimalFormat("####.00");
	HashMap habSancMap = new HashMap();
	HashMap habCovMap = new HashMap();
	HashMap workSancMap = new HashMap();
	HashMap workCovMap = new HashMap();
	HashMap costEstMap = new HashMap();
	HashMap costExpMap = new HashMap();
	HashMap distMap = new HashMap();
	String rDistrict = "";
	String finyear = "";
	String dname = "";
	//String programe = "";
	String mode = "";

	if (request.getParameter("mode") != null)
		mode = request.getParameter("mode");
	

	if (request.getParameter("finyear") != null)
		finyear = request.getParameter("finyear");
	else {
		Statement stmtt = conn.createStatement(
				ResultSet.TYPE_SCROLL_SENSITIVE,
				ResultSet.CONCUR_UPDATABLE);
		ResultSet rss = stmtt
				.executeQuery("select distinct to_char(max(status_date),'dd-MON-yyyy') from rws_habitation_directory_tbl");
		while (rss.next()) {
			finyear = rss.getString(1);
		}
		int yr = Integer
				.parseInt(finyear.substring(7, finyear.length()));
		finyear = yr + "-" + (yr + 1);
	}

	session.setAttribute("finyear", finyear);

	/* if (request.getParameter("program") != null)
		programe = request.getParameter("program");
	else
		programe = "all"; */

	HashMap programmeList = new HashMap();
	/* if (programe.equals("all")) { */
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

	programmeList.put(1, progCode);
	programmeList.put(2, "04");
	programmeList.put(3, "65");
	programmeList.put(4, "57");

	/* programe = progCode + ",04,65,57";
	
	}
	
	session.setAttribute("programe", programe);
	 */
	String startyr = finyear.substring(0, 4);

	String endyr = finyear.substring(5, 9);

	String divCode = "";
	WorksData1 data1 = new WorksData1();
	int cyear = Calendar.getInstance().get(Calendar.YEAR);
	int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
	int lMonth = Calendar.getInstance().get(Calendar.MONTH);
	int day = Calendar.getInstance().get(Calendar.DATE);
	String currentMonth = data1.getCurrentMonth(month);
	String lastMonth = "";
	if (currentMonth.equals("JAN")) {
		lastMonth = "DEC-" + (cyear - 1);
	} else {
		lastMonth = data1.getCurrentMonth(lMonth) + "-" + cyear;
	}
	String cDate = day + "-" + currentMonth + "-" + cyear;
	
	//System.out.println("cDate----"+cDate);
	int yearStart = 0;
	int yearEnd = 0;
	if (month <= 3) {
		yearStart = cyear - 1;
		yearEnd = cyear;
	} else {
		yearStart = cyear;
		yearEnd = cyear + 1;
	}
	lastMonth = lastMonth.substring(0, 1).toUpperCase()
			+ lastMonth.substring(1).toLowerCase();
	currentMonth = currentMonth.substring(0, 1).toUpperCase()
			+ currentMonth.substring(1).toLowerCase();
	int y=cyear-1;
	String pDate = day + "-" + currentMonth + "-"+y ;
%>
<script language="JavaScript">
	function viewWorks(URL) {

		var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
		if (URL != "") {
			myNewWin = window.open(URL, 'newWinddow', popFeatures);
			myNewWin.focus();
		}
	}

	function wopen(url, name, w, h) {
		w += 32;
		h += 96;
		var win = window.open(url, name, 'width=' + w + ', height=' + h + ', '
				+ 'location=yes, menubar=no, '
				+ 'status=yes, toolbar=no, scrollbars=yes, resizable=yes');

		win.focus();
	}
</script>
<style type="text/css">
body, body a {
	font-family: "Verdana", Georgia, Serif !important;
	font-size: 13px !important;
}

.btext {
	font-family: "Verdana", Georgia, Serif !important;
	font-size: 12px !important;
	border: 1px solid #777777;
}

.rightPad td {
	padding-right: 3px !important;
}
</style>
<BODY>
	<form name=f1 method="post">

		<br />
		<br />
		<center>
			<font color="#663899" face="Maiandra GD" size="4px"><b>Physical
					(Coverage of Habitations) and Financial Achievements - (<%=yearStart %>-<%=yearEnd %>)</b></font> <br />
			<!-- br/><font color="#889900" face="Maiandra GD" size="3px">(Amount in Lakhs)</font> -->
		</center>

		<br />
		<%
			if (mode.equals("districts") ) {
		%>
		<table align="center"
			style="margin-top: -35px !important; width: 1050px !important; text-align: center !important;">
			<tr>
				<td style="width: 950px !important;"></td>
				<td style="width: 100px !important;" align="right"><a
					href="javascript:history.back(-1)"><img
						src="/pred/resources/graphs/go_back.gif" height="30px" /></a>&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		<%
			} else {
		%>
		<table align="center"
			style="margin-top: -45px !important; width: 1050px !important; text-align: center !important;">
			<tr>
				<td style="width: 1000px !important; text-align: left !important;"><font
					color="#889900" face="Maiandra GD" size="2px">(Rs. Lakhs)</font></td>
				<td style="width: 50px !important; text-align: right !important">
					<!-- <a
					href="/pred/resources/graphs/workGraphView.jsp?dcode=00&mode=Pie"
					target="_blank" style="color: green !important; font-size: 13px;"
					id="showGraph"><img width="30px"
						src="/pred/resources/graphs/pie.png"></a> -->&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		<%
			}
		%>
		<table border=1 cellspacing=0 cellpadding=0 height=5% width="1050px"
			bordercolor=#000000
			style="border-collapse: collapse; margin-top: 20px !important;"
			bgcolor="#ffffff" align="center">

			<tr align=center align=center>
				<td class=btext rowspan=3 style="width: 30px !important;">SNO</td>
				<%-- <%
				if (mode.equals("districts") ) {
				%>
				<td class=btext rowspan=3>&nbsp;&nbsp;&nbsp;&nbsp;District&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<%
				}else{
				%> --%>
				<td class=btext rowspan=3>&nbsp;&nbsp;&nbsp;&nbsp;Programme&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<%-- <%
				}
				%> --%>
				<td class=btext colspan="15">Physical</td>
				<td class=btext colspan="2">Financial (Rs. Lakhs)</td>
			</tr>
			<tr align=center align=center>
				<td class=btext colspan="3">Quarter-1</td>
				<td class=btext colspan="3">Quarter-2</td>
				<td class=btext colspan="3">Quarter-3</td>
				<td class=btext colspan="3">Quarter-4</td>
				<td class=btext colspan="3">Total</td>
				<td class=btext rowspan="2">During (<%=yearStart %>-<%=yearEnd %>)</td>
				<td class=btext rowspan="2">Previous Year (<%=(yearStart-1) %>-<%=(yearEnd-1) %>)</td>
			</tr>
			<tr align=center align=center>
				<td colspan=1 class=btext align="center">Target</td>
				<td colspan=1 class=btext align="center">Achievement</td>
				<!-- <td colspan=1 class=btext align="center">%</td> -->
				<td colspan=1 class=btext align="center">Previous Year habs
					Coverage</td>
				<td colspan=1 class=btext align="center">Target</td>
				<td colspan=1 class=btext align="center">Achievement</td>
				<!-- <td colspan=1 class=btext align="center">%</td> -->
				<td colspan=1 class=btext align="center">Previous Year habs
					Coverage</td>
				<td colspan=1 class=btext align="center">Target</td>
				<td colspan=1 class=btext align="center">Achievement</td>
				<!-- <td colspan=1 class=btext align="center">%</td> -->
				<td colspan=1 class=btext align="center">Previous Year habs
					Coverage</td>
				<td colspan=1 class=btext align="center">Target</td>
				<td colspan=1 class=btext align="center">Achievement</td>
				<!-- <td colspan=1 class=btext align="center">%</td> -->
				<td colspan=1 class=btext align="center">Previous Year habs
					Coverage</td>
				<td colspan=1 class=btext align="center">Target</td>
				<td colspan=1 class=btext align="center">Achievement</td>
				<!-- <td colspan=1 class=btext align="center">%</td> -->
				<td colspan=1 class=btext align="center">Previous Year habs
					Coverage</td>
			</tr>

			<%
				int styleCount = 0;
				String style = "";
			%>
			<%
				Connection connection = null;
				Statement stmt1 = null;
				ResultSet rs1 = null;
				int slno = 0;
				int tothabsSacQ1=0,tothabsCovQ1=0,totprehabsCovQ1=0;
				int tothabsSacQ2 = 0, tothabsCovQ2 = 0, totprehabsCovQ2 = 0;
				int tothabsSacQ3 = 0, tothabsCovQ3 = 0, totprehabsCovQ3 = 0;
				int tothabsSacQ4 = 0, tothabsCovQ4 = 0, totprehabsCovQ4 = 0;
				int tothabsSacTot = 0, tothabsCovTot = 0, totprehabsCovTot = 0;
				double totExpDuringFY=0,totExpPreviousFY=0;
				try {
					String programme = "";
					String schemes = "'01','02','03'";
					for (int i = 1; i <= programmeList.size(); i++) {
						int habsSacQ1 = 0, habsCovQ1 = 0, prehabsCovQ1 = 0;
						int habsSacQ2 = 0, habsCovQ2 = 0, prehabsCovQ2 = 0;
						int habsSacQ3 = 0, habsCovQ3 = 0, prehabsCovQ3 = 0;
						int habsSacQ4 = 0, habsCovQ4 = 0, prehabsCovQ4 = 0;
						int habsSacTot = 0, habsCovTot = 0, prehabsCovTot = 0;
						double totExpBankDur=0,totExpPaoDur=0,totExpBankPre=0,totExpPaoPre=0;
						
						programme = (String) programmeList.get(i);
						String programmeName = "";

						if (programme.length() > 2) {
							programmeName = "NRDWP-Related";
						} else {
							String programmeQuery = "select PROGRAMME_CODE,PROGRAMME_NAME from  rws_programme_tbl where PROGRAMME_CODE='"
									+ programme + "'";
							Statement statement1 = conn.createStatement();
							ResultSet resultSet1 = statement1
									.executeQuery(programmeQuery);
							if (resultSet1.next()) {
								programmeName = resultSet1
										.getString("PROGRAMME_NAME");
							}
							resultSet.close();
							statement.close();
						}
						if (styleCount % 2 == 0) {
							style = "gridbg1";
						} else {
							style = "gridbg2";
						}
						styleCount++;
						//************Quarter 1**************//
						String targetHabsQ1 = "select count(b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m  where WORK_CANCEL_DT is null  "
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
								+ programme
								+ ") and c.GROUNDING_DATE is not null  and substr(a.work_id,7,2) in ("
								+ schemes
								+ ") AND TARGET_DATE_COMP between '01-APR-"
								+ yearStart
								+ "' and '30-JUN-"
								+ yearStart
								+ "' and  c.CORE_DASHBOARD_STATUS<>'N' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
						//System.out.println(targetHabsQ1);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(targetHabsQ1);
						if (rs1.next()) {
							habsSacQ1 = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String achievementHabsQ1 = "select count(h.hab_code) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h  where WORK_CANCEL_DT is null "
								+ "   and h.work_id=b.work_id and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
								+ programme
								+ ") and b.DATE_OF_COMPLETION between '01-APR-"
								+ yearStart
								+ "' and '30-JUN-"
								+ yearStart
								+ "' and b.DATE_OF_COMPLETION is not null  ";
						achievementHabsQ1 += " and substr(a.work_id,7,2) in ("
								+ schemes
								+ ") ";
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(achievementHabsQ1);
						if (rs1.next()) {
							habsCovQ1 = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						double percentageQ1 = 0;
						if (habsSacQ1 > 0) {
							percentageQ1 = Double.parseDouble("" + habsCovQ1 * 100)
									/ Double.parseDouble("" + habsSacQ1);
						}
						String previousHabsQ1 = "select count(h.hab_code) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h  where WORK_CANCEL_DT is null "
								+ "   and h.work_id=b.work_id and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
								+ programme
								+ ") and b.DATE_OF_COMPLETION between '01-APR-"
								+ (yearStart - 1)
								+ "' and '30-JUN-"
								+ (yearStart - 1)
								+ "' and b.DATE_OF_COMPLETION is not null and substr(a.work_id,7,2) in ("
								+ schemes + ") ";
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(previousHabsQ1);
						if (rs1.next()) {
							prehabsCovQ1 = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();

						//************Quarter 2**************//
						String targetHabsQ2 = "select count(b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m  where WORK_CANCEL_DT is null  "
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
								+ programme
								+ ") and c.GROUNDING_DATE is not null  and substr(a.work_id,7,2) in ("
								+ schemes
								+ ") AND TARGET_DATE_COMP between '01-JUL-"
								+ yearStart
								+ "' and  '30-SEP-"
								+ yearStart
								+ "' and  c.CORE_DASHBOARD_STATUS<>'N' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(targetHabsQ2);
						if (rs1.next()) {
							habsSacQ2 = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String achievementHabsQ2 = "select count(h.hab_code) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h  where WORK_CANCEL_DT is null "
								+ "   and h.work_id=b.work_id and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
								+ programme
								+ ") and b.DATE_OF_COMPLETION between '01-JUL-"
								+ yearStart
								+ "' and '30-SEP-"
								+ yearStart
								+ "' and b.DATE_OF_COMPLETION is not null  and c.CORE_DASHBOARD_STATUS<>'N'";
						achievementHabsQ2 += " and substr(a.work_id,7,2) in ("
								+ schemes
								+ ") ";
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(achievementHabsQ2);
						if (rs1.next()) {
							habsCovQ2 = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						double percentageQ2 = 0;
						if (habsSacQ2 > 0) {
							percentageQ2 = Double.parseDouble("" + habsCovQ2 * 100)
									/ Double.parseDouble("" + habsSacQ2);
						}
						String previousHabsQ2 = "select count(h.hab_code) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h  where WORK_CANCEL_DT is null "
								+ "   and h.work_id=b.work_id and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
								+ programme
								+ ") and b.DATE_OF_COMPLETION between '01-JUL-"
								+ (yearStart - 1)
								+ "' and '30-SEP-"
								+ (yearStart - 1)
								+ "' and b.DATE_OF_COMPLETION is not null and substr(a.work_id,7,2) in ("
								+ schemes + ") ";
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(previousHabsQ2);
						if (rs1.next()) {
							prehabsCovQ2 = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						//************Quarter 3**************//
						String targetHabsQ3 = "select count(b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m  where WORK_CANCEL_DT is null  "
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
								+ programme
								+ ") and c.GROUNDING_DATE is not null  and substr(a.work_id,7,2) in ("
								+ schemes
								+ ") AND TARGET_DATE_COMP between '01-OCT-"
								+ yearStart
								+ "' and '31-DEC-"
								+ yearStart
								+ "' and  c.CORE_DASHBOARD_STATUS<>'N' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(targetHabsQ3);
						if (rs1.next()) {
							habsSacQ3 = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String achievementHabsQ3 = "select count(h.hab_code) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h  where WORK_CANCEL_DT is null "
								+ "   and h.work_id=b.work_id and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
								+ programme
								+ ") and b.DATE_OF_COMPLETION between '01-OCT-"
								+ yearStart
								+ "' and '31-DEC-"
								+ yearStart
								+ "' and b.DATE_OF_COMPLETION is not null  and c.CORE_DASHBOARD_STATUS<>'N'";
						achievementHabsQ3 += " and substr(a.work_id,7,2) in ("
								+ schemes
								+ ") ";
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(achievementHabsQ3);
						if (rs1.next()) {
							habsCovQ3 = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						double percentageQ3 = 0;
						if (habsSacQ3 > 0) {
							percentageQ3 = Double.parseDouble("" + habsCovQ3 * 100)
									/ Double.parseDouble("" + habsSacQ3);
						}

						String previousHabsQ3 = "select count(h.hab_code) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h  where WORK_CANCEL_DT is null "
								+ "   and h.work_id=b.work_id and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
								+ programme
								+ ") and b.DATE_OF_COMPLETION between '01-OCT-"
								+ (yearStart - 1)
								+ "' and '31-DEC-"
								+ (yearStart - 1)
								+ "' and b.DATE_OF_COMPLETION is not null and substr(a.work_id,7,2) in ("
								+ schemes + ") ";
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(previousHabsQ3);
						if (rs1.next()) {
							prehabsCovQ3 = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						//************Quarter 4**************//
						String targetHabsQ4 = "select count(b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m  where WORK_CANCEL_DT is null  "
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
								+ programme
								+ ") and c.GROUNDING_DATE is not null  and substr(a.work_id,7,2) in ("
								+ schemes
								+ ") AND TARGET_DATE_COMP between '01-JAN-"
								+ yearEnd
								+ "' and '31-MAR-"
								+ yearEnd
								+ "' and  c.CORE_DASHBOARD_STATUS<>'N' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(targetHabsQ4);
						if (rs1.next()) {
							habsSacQ4 = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String achievementHabsQ4 = "select count(h.hab_code) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h  where WORK_CANCEL_DT is null "
								+ "   and h.work_id=b.work_id and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
								+ programme
								+ ") and b.DATE_OF_COMPLETION between '01-JAN-"
								+ yearEnd
								+ "' and '31-MAR-"
								+ yearEnd
								+ "' and b.DATE_OF_COMPLETION is not null  and c.CORE_DASHBOARD_STATUS<>'N'";
						achievementHabsQ4 += " and substr(a.work_id,7,2) in ("
								+ schemes
								+ ") ";
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(achievementHabsQ4);
						if (rs1.next()) {
							habsCovQ4 = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						double percentageQ4 = 0;
						if (habsSacQ4 > 0) {
							percentageQ4 = Double.parseDouble("" + habsCovQ4 * 100)
									/ Double.parseDouble("" + habsSacQ4);
						}
						String previousHabsQ4 = "select count(h.hab_code) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h  where WORK_CANCEL_DT is null "
								+ "   and h.work_id=b.work_id and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
								+ programme
								+ ") and b.DATE_OF_COMPLETION between '01-JAN-"
								+ (yearEnd - 1)
								+ "' and '31-MAR-"
								+ (yearEnd - 1)
								+ "' and b.DATE_OF_COMPLETION is not null and substr(a.work_id,7,2) in ("
								+ schemes + ") ";
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(previousHabsQ4);
						if (rs1.next()) {
							prehabsCovQ4 = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						//************Total Physical**************//
						
						habsSacTot = habsSacQ1+habsSacQ2+habsSacQ3+habsSacQ4;
						habsCovTot = habsCovQ1+habsCovQ2+habsCovQ3+habsCovQ4;
						prehabsCovTot = prehabsCovQ1+prehabsCovQ2+prehabsCovQ3+prehabsCovQ4;
						double percentageTot = 0;
						if (habsSacTot > 0) {
							percentageTot = Double.parseDouble("" + habsCovTot * 100)
									/ Double.parseDouble("" + habsSacTot);
						}
						
						//****************Total Exp FY Wise***************//
					String totExpBankDurQuery="select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL a,rws_work_admn_tbl b WHERE a.work_id=b.work_id and BANK_SEND_DATE BETWEEN '01-APR-"+yearStart+"' AND '31-MAR-"+yearEnd+"'  and b.programme_code in ("+ programme+ ")";
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(totExpBankDurQuery);
					if (rs1.next()) {
					 totExpBankDur = rs1.getDouble(1);
					}
					stmt1.close();
					rs1.close();
									
					String totExpPaoDurQuery="select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL a,rws_work_admn_tbl b WHERE a.work_id=b.work_id and STATE_SEND_DATE BETWEEN '01-APR-"+yearStart+"' AND '31-MAR-"+yearEnd+"'  and b.programme_code in ("+ programme+ ")";
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(totExpPaoDurQuery);
					if (rs1.next()) {
						totExpPaoDur = rs1.getDouble(1);
					}
					stmt1.close();
					rs1.close();
					String totexpDur=ndf.format((totExpBankDur+totExpPaoDur)/100000);
					
					String totExpBankPreQuery="select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL a,rws_work_admn_tbl b WHERE a.work_id=b.work_id and BANK_SEND_DATE BETWEEN '01-APR-"+(yearStart-1)+"' AND '"+pDate+"'  and b.programme_code in ("+ programme+ ")";
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(totExpBankPreQuery);
					if (rs1.next()) {
					 totExpBankPre = rs1.getDouble(1);  
					}
					stmt1.close();
					rs1.close();
									
					String totExpPaoPreQuery="select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL a,rws_work_admn_tbl b WHERE a.work_id=b.work_id and STATE_SEND_DATE BETWEEN '01-APR-"+(yearStart-1)+"' AND '"+pDate+"'  and b.programme_code in ("+ programme+ ")";
					//System.out.println(totExpPaoPreQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(totExpPaoPreQuery);
					if (rs1.next()) {
						totExpPaoPre = rs1.getDouble(1);
					}
					stmt1.close();
					rs1.close();
					String totexpPre=ndf.format((totExpBankPre+totExpPaoPre)/100000);
			%>
			<tr>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=++slno%></td>
				<td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_habs_covered_district_cm_rpt.jsp?mode=districts&programme=<%=programme%>&finyear=<%=finyear%>&programmeName=<%=programmeName%>"><%=programmeName%></a></td>
				<% if(habsSacQ1>0){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_habs_covered_drill_rpt.jsp?mode=sHabs&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=30-JUN-<%=yearStart%>&message=<%=programmeName%> Quarter-1 Target')"><%=habsSacQ1%></a></td>
				<%}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=habsSacQ1%></td>
				<%} if(habsCovQ1>0){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_habs_covered_drill_rpt.jsp?mode=cHabs&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=30-JUN-<%=yearStart%>&message=<%=programmeName%> Quarter-1 Achievement')"><%=habsCovQ1%></a></td>
				<%}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=habsCovQ1%></td>
				<%}%>
				<%-- <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(percentageQ1)%></td> --%>
				<% if(prehabsCovQ1>0){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_habs_covered_drill_rpt.jsp?mode=preHabs&programme=<%=programme%>&yearStart=01-APR-<%=(yearStart-1)%>&yearEnd=30-JUN-<%=(yearStart-1)%>&message=<%=programmeName%> Quarter-1 Previous FY Achievement')"><%=prehabsCovQ1%></a></td>
				<%}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=prehabsCovQ1%></td>
				<%} if(habsSacQ2>0){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_habs_covered_drill_rpt.jsp?mode=sHabs&programme=<%=programme%>&yearStart=01-JUL-<%=yearStart%>&yearEnd=30-SEP-<%=yearStart%>&message=<%=programmeName%> Quarter-2 Target')"><%=habsSacQ2%></a></td>
				<%}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=habsSacQ2%></td>
				<%} if(habsCovQ2>0){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_habs_covered_drill_rpt.jsp?mode=cHabs&programme=<%=programme%>&yearStart=01-JUL-<%=yearStart%>&yearEnd=30-SEP-<%=yearStart%>&message=<%=programmeName%> Quarter-2 Achievement')"><%=habsCovQ2%></a></td>
				<%}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=habsCovQ2%></td>
				<%} %>
				<%-- <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(percentageQ2)%></td> --%>
				<% if(prehabsCovQ2>0){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_habs_covered_drill_rpt.jsp?mode=preHabs&programme=<%=programme%>&yearStart=01-JUL-<%=(yearStart-1)%>&yearEnd=30-SEP-<%=(yearStart-1)%>&message=<%=programmeName%> Quarter-2 Previous FY Achievement')"><%=prehabsCovQ2%></a></td>
				<%}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=prehabsCovQ2%></td>
				<%} if(habsSacQ3>0){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_habs_covered_drill_rpt.jsp?mode=sHabs&programme=<%=programme%>&yearStart=01-OCT-<%=yearStart%>&yearEnd=31-DEC-<%=yearStart%>&message=<%=programmeName%> Quarter-3 Target')"><%=habsSacQ3%></a></td>
				<%}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=habsSacQ3%></td>
				<%} if(habsCovQ3>0){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_habs_covered_drill_rpt.jsp?mode=cHabs&programme=<%=programme%>&yearStart=01-OCT-<%=yearStart%>&yearEnd=31-DEC-<%=yearStart%>&message=<%=programmeName%> Quarter-3 Achievement')"><%=habsCovQ3%></a></td>
				<%}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=habsCovQ3%></td>
				<%} %>
				<%-- <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(percentageQ3)%></td> --%>
				<% if(prehabsCovQ3>0){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_habs_covered_drill_rpt.jsp?mode=preHabs&programme=<%=programme%>&yearStart=01-OCT-<%=(yearStart-1)%>&yearEnd=31-DEC-<%=(yearStart-1)%>&message=<%=programmeName%> Quarter-3 Previous FY Achievement')"><%=prehabsCovQ3%></a></td>
				<%}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=prehabsCovQ3%></td>
				<%} if(habsSacQ4>0){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_habs_covered_drill_rpt.jsp?mode=sHabs&programme=<%=programme%>&yearStart=01-JAN-<%=yearEnd%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=programmeName%> Quarter-4 Target')"><%=habsSacQ4%></a></td>
				<%}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=habsSacQ4%></td>
				<%} if(habsCovQ4>0){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_habs_covered_drill_rpt.jsp?mode=cHabs&programme=<%=programme%>&yearStart=01-JAN-<%=yearEnd%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=programmeName%> Quarter-4 Achievement')"><%=habsCovQ4%></a></td>
				<%}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=habsCovQ4%></td>
				<%} %>
				<%-- <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(percentageQ4)%></td> --%>
				<% if(prehabsCovQ4>0){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_habs_covered_drill_rpt.jsp?mode=preHabs&programme=<%=programme%>&yearStart=01-JAN-<%=(yearEnd-1)%>&yearEnd=31-MAR-<%=(yearEnd-1)%>&message=<%=programmeName%> Quarter-4 Previous FY Achievement')"><%=prehabsCovQ4%></a></td>
				<%}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=prehabsCovQ4%></td>
				<%} if(habsSacTot>0){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_habs_covered_drill_rpt.jsp?mode=sHabs&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=programmeName%> Total Target')"><%=habsSacTot%></a></td>
				<%}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=habsSacTot%></td>
				<%} if(habsCovTot>0){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_habs_covered_drill_rpt.jsp?mode=cHabs&programme=<%=programme%>&yearStart=01-APR-<%=yearStart%>&yearEnd=31-MAR-<%=yearEnd%>&message=<%=programmeName%> Total Achievement')"><%=habsCovTot%></a></td>
				<%}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=habsCovTot%></td>
				<%} %>
				<%-- <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(percentageTot)%></td> --%>
				<% if(prehabsCovTot>0){%>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_habs_covered_drill_rpt.jsp?mode=preHabs&programme=<%=programme%>&yearStart=01-APR-<%=(yearStart-1)%>&yearEnd=31-MAR-<%=(yearEnd-1)%>&message=<%=programmeName%> Total Previous FY Achievement')"><%=prehabsCovTot%></a></td>
				<%}else{ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=prehabsCovTot%></td>
				<%} %>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=totexpDur%></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=totexpPre%></td>
			</tr>
			
			<%
			 tothabsSacQ1 += habsSacQ1;
			 tothabsCovQ1 += habsCovQ1;
			 totprehabsCovQ1 += prehabsCovQ1;
			 tothabsSacQ2 += habsSacQ2;
			 tothabsCovQ2 += habsCovQ2;
			 totprehabsCovQ2 += prehabsCovQ2;
			 tothabsSacQ3 += habsSacQ3;
			 tothabsCovQ3 += habsCovQ3;
			 totprehabsCovQ3 += prehabsCovQ3;
			 tothabsSacQ4 += habsSacQ4;
			 tothabsCovQ4 += habsCovQ4;
			 totprehabsCovQ4 += prehabsCovQ4;
			 tothabsSacTot += habsSacTot;
			 tothabsCovTot += habsCovTot;
			 totprehabsCovTot += prehabsCovTot;
			 totExpDuringFY+=totExpBankDur+totExpPaoDur;
			 totExpPreviousFY+=totExpBankPre+totExpPaoPre;
			 
				}
					/* double percentageTot = 0;
					if (habsSacTot > 0) {
						percentageTot = Double.parseDouble("" + habsCovTot * 100)
								/ Double.parseDouble("" + habsSacTot);
					} */
				%>
			<tr class="rightPad">
				<td class="btext" style="text-align: right;" colspan=2>Total</td>
				<td class="btext" style="text-align: right;"><%=tothabsSacQ1 %></td>
				<td class="btext" style="text-align: right;"><%=tothabsCovQ1 %></td>
				<td class="btext" style="text-align: right;"><%=totprehabsCovQ1 %></td>
				
				<td class="btext" style="text-align: right;"><%=tothabsSacQ2 %></td>
				<td class="btext" style="text-align: right;"><%=tothabsCovQ2 %></td>
				<td class="btext" style="text-align: right;"><%=totprehabsCovQ2 %></td>
				
				<td class="btext" style="text-align: right;"><%=tothabsSacQ3 %></td>
				<td class="btext" style="text-align: right;"><%=tothabsCovQ3 %></td>
				<td class="btext" style="text-align: right;"><%=totprehabsCovQ3 %></td>
				
				<td class="btext" style="text-align: right;"><%=tothabsSacQ4 %></td>
				<td class="btext" style="text-align: right;"><%=tothabsCovQ4 %></td>
				<td class="btext" style="text-align: right;"><%=totprehabsCovQ4 %></td>
				
				<td class="btext" style="text-align: right;"><%=tothabsSacTot %></td>
				<td class="btext" style="text-align: right;"><%=tothabsCovTot %></td>
				<td class="btext" style="text-align: right;"><%=totprehabsCovTot %></td>
				
				<td class="btext" style="text-align: right;"><%=ndf.format(totExpDuringFY/100000) %></td>
				<td class="btext" style="text-align: right;"><%=ndf.format(totExpPreviousFY/100000) %></td>
				
			</tr>
			<%

				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try {
						if (conn != null) {
							conn.close();
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
			%>

		</table>
		<br />
		<table height="20px" align="center">
			<tr height="1%">
				<td align="center" valign="bottom"
					style="font-family: verdana; font-size: 8pt; font-weight: bold; width: 100%; color: #6600CC;">
					Source: <a href="http://rwss.ap.nic.in" target="_blank">WaterSoft</a>,
					Designed & Developed by <a href="http://www.nic.in" target="_blank">National
						Informatics Centre</a>, AP State Centre
				</td>
			</tr>
		</table>
		<br />
</BODY>

