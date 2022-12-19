<%@page import="nic.watersoft.works.WorksData1"%>
<%@page import="java.sql.Connection"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%
	DecimalFormat ndf = new DecimalFormat("####.00");

	int NRDWPhabsSanctioned12 = 0;
	String InputWorkProStr = "";
	HashMap programmeName = new HashMap();
	int count = 1;

	String programe = "";
	String programName = "";
	String progCode = "";
	String progCodeNRDWP = "";
	HashMap programmeList = new HashMap();

	String nrdwpQuery = "select PROGRAMME_CODE from  rws_programme_tbl where NRDWP_RELATED='Y' and CENTRE_STATE_DISTRICT<>'D' order by 1";
	Statement statement = conn.createStatement();
	ResultSet resultSet = statement.executeQuery(nrdwpQuery);
	while (resultSet.next()) {
		if (!progCode.equals("")) {
			progCode = progCode + "," + resultSet.getString(1);
			progCodeNRDWP = progCodeNRDWP + "," + resultSet.getString(1);
		} else {
			progCode = resultSet.getString(1);
			progCodeNRDWP = resultSet.getString(1);
		}

	}

	resultSet.close();
	statement.close();
	int x = 1;

	programmeList.put(x, progCode + "@NRDWP RELATED");

	String nrdwpSubQuery = "select PROGRAMME_CODE,PROGRAMME_NAME from  rws_programme_tbl where NRDWP_RELATED='N' and CM_CORE_DB='Y' and CENTRE_STATE_DISTRICT<>'D' and PROGRAMME_NAME like '%NRDWP%' order by 1";
	Statement statementn = conn.createStatement();
	ResultSet resultSetn = statementn.executeQuery(nrdwpSubQuery);
	while (resultSetn.next()) {
		x++;
		programmeList.put(x, resultSetn.getString(1) + "@NRDWP RELATED");
		progCodeNRDWP += "," + resultSetn.getString(1);
	}
	resultSetn.close();
	statementn.close();

	String CmDBQuery = "select PROGRAMME_CODE,PROGRAMME_NAME from  rws_programme_tbl where CM_CORE_DB='Y' and NRDWP_RELATED='N' and CENTRE_STATE_DISTRICT<>'D' and PROGRAMME_NAME not like '%NRDWP%' order by 1";
	Statement stmtCmDB = conn.createStatement();
	ResultSet rsCmDB = stmtCmDB.executeQuery(CmDBQuery);
	while (rsCmDB.next()) {
		x++;
		programmeList.put(x, rsCmDB.getString(1) + "@" + rsCmDB.getString(2));
	}
	String schemes = "";
	String schemesTot = "01,02,03,10";
	HashMap schemesList = new HashMap();
	schemesList.put(1, "01,02");
	schemesList.put(2, "03");
	schemesList.put(3, "10");
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
	int yearStart = 0;
	int yearEnd = 0;
	String y = "";
	if (request.getParameter("finyear") != null) {
		y = request.getParameter("finyear");
		yearStart = Integer.parseInt(y.substring(0, 4));
		yearEnd = yearStart + 1;
	} else {
		if (month <= 3) {
			yearStart = cyear - 1;
			yearEnd = cyear;
		} else {
			yearStart = cyear;
			yearEnd = cyear + 1;
		}
	}
	String ye = "" + yearEnd;
	ye = ye.substring(2, 4).toString();

	int yEnd = Integer.parseInt(ye);

	String InputPhyFinStr = "";
	String names = "";
%>
<html>
<script src="/pred/resources/graphs/jquery.min.js"></script>

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
	border: 1px solid #000000 !important;
	font-family: "Maiandra GD", Georgia, Serif !important;
	font-size: 12px !important;
}

.rightPad td {
	padding-right: 3px !important;
}
</style>

<body>
	<script language="JavaScript"
		src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
	<br />
	<br />
	<form name=f1 id="f1">
		<center>
			<font color="#663899" face="Maiandra GD" size="4px"><b>Abstract
					Progress Report for Physically Completed But Financially Not
					completed Works </b></font> <br /> <br /> <font color="#889900"
				face="Maiandra GD" size="3px">Programme: ALL <%
 	if (request.getParameter("con") != null) {
 %> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle: <%=request.getParameter("con")%>
				<%
					}
					if (request.getParameter("don") != null) {
				%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Division: <%=request.getParameter("don")%>
				<%
					}
				%> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Year: <%=yearStart%>-<%=yEnd%></font>
		</center>
		<center>
			<br /> <br /> <font color="#663899" face="Maiandra GD" size="4px"><b>Select
					Financial Year:<font color="red">*</font> <SELECT name="finyear"
					id="finyear" style="width: 140px" onchange="this.form.submit()">
						<%
							try {
								String finYear = request.getParameter("finyear");
								String temp = "";
								Statement stmt11 = conn.createStatement();
								String fy = "";
								int fy1 = 0;
								String finquery = "select distinct  substr(to_char(BANK_SEND_DATE,'dd/mm/yyyy'),7,4)  from RWS_bill_bank_bridge_TBL where BANK_SEND_DATE is not null and to_char(BANK_SEND_DATE,'MM')>='03'  order by substr(to_char(BANK_SEND_DATE,'dd/mm/yyyy'),7,4) desc ";
								//	System.out.println("Fin" + finquery);
								ResultSet rs11 = stmt11.executeQuery(finquery);
								while (rs11.next()) {
									//	System.out.println( rs11.getString(1));
									fy = rs11.getString(1);
									fy1 = Integer.parseInt(fy) + 1;
									if (finYear != null && !finYear.equals("0")) {
										temp = finYear.substring(0, 4);
									}
									if (temp.equals(rs11.getString(1))) {
						%>
						<option value="<%=fy + "-" + fy1%>" selected><%=fy + "-" + fy1%></option>
						<%
							} else {
						%>
						<option value="<%=fy + "-" + fy1%>"><%=fy + "-" + fy1%></option>
						<%
							}
								}
								if (rs11 != null)
									rs11.close();
								if (stmt11 != null)
									stmt11.close();

							} catch (Exception e) {
								//System.out.println("ddd");
								//e.printStackTrace();
							}
						%>
				</SELECT>
			</b></font> <br>
		</center>
		<br> <br>
		<table align="center"
			style="margin-top: -45px !important; width: 1050px !important; text-align: center !important;">
			<tr>
				<td style="width: 1000px !important; text-align: left !important;"><font
					color="#889900" face="Maiandra GD" size="2px">(Rs. Lakhs)</font></td>
				<td style="width: 40px !important;">
				</td>
			</tr>
		</table>
		<br /> <br />
		<table border=1 cellspacing=0 cellpadding=0 height=5% width="800px"
			class="baseTable" bordercolor=#000000
			style="border-collapse: collapse; margin-top: -15px !important;"
			bgcolor="#ffffff" align="center">
			<tr align=center align=center class="thead">
				<td class=btext>SNO</td>
				<td class=btext>&nbsp;Main&nbsp;Programme&nbsp;</td>
				<td class=btext>Programme</td>
				<td class=btext>Sub Programme</td>
				<td class=btext>Scheme-No. of<br />Works
				</td>
				<td class=btext>Original Est Cost</td>
				<td class=btext align="center">Agreement Value</td>
				<td class=btext>Cum Exp. Upto 31.3.<%=yearStart%></td>
				<td class=btext>Bal Est Cost as on 1.4.<%=yearStart%><br>(6-8)
				</td>
				<td class=btext>Exp. During <%=yearStart%>-<%=yearEnd%></td>
				<td class=btext>Balance to be paid<br>(6-(8+10))</td>
				<td class=btext>Bills raised so far</td>
				
			</tr>
			
			<tr align=center align=center class="thead">
				<td class=btext>1</td>
				<td class=btext>2</td>
				<td class=btext>3</td>
				<td class=btext>4</td>
				<td class=btext>5</td>
				<td class=btext>6</td>
				<td class=btext>7</td>
				<td class=btext>8</td>
				<td class=btext>9</td>
				<td class=btext>10</td>
				<td class=btext>11</td>
				<td class=btext>12</td>
			</tr>
			<%
				int styleCount = 0;
				String style = "";
				Connection connection = null;
				Statement stmt1 = null;
				ResultSet rs1 = null;
				int slno = 0;
				try {
					int totNoOfWorks = 0;				
					double totarfc = 0, totEstCost = 0,totAgrCost=0, totExpUptoPY = 0, totBalEstCost14ys = 0, totTotExp = 0,totBalEstCost=0;
							
					String query = "";
					String programme = "";
					String mainProgramme = "", mainProgrammeName = "", dupeProgrammeName = "";
					String sa;
					String schemeName = "", oldprogName = "";
					double billamount=0,totbillamt=0;

					for (int i = 1; i <= programmeList.size(); i++) {
						for (int j = 1; j <= schemesList.size(); j++) {
							schemes = (String) schemesList.get(j);
							if (schemes.equals("03")) {
								schemeName = "MVS";
							} else if (schemes.equals("10")) {
								schemeName = "Sustainability";
							} else {
								schemeName = "SVS";
							}
							double estCost = 0, agreementValue = 0, bankUptoPrevYear = 0, bankYear = 0, paoUptoPrevYear = 0,
									paoYear = 0, TotExp = 0;
							int noOfWorks = 0;
							programme = (String) programmeList.get(i);
							String ar[] = programme.split("@");
							programme = ar[0];
							mainProgrammeName = ar[1];
							String programmeNam = "";
							if (programme.length() > 2) {
								programmeNam = "NRDWP";
							} else {
								String programmeQuery = "select PROGRAMME_CODE,PROGRAMME_NAME from  rws_programme_tbl where PROGRAMME_CODE='"
										+ programme + "'";
								Statement statement1 = conn.createStatement();
								ResultSet resultSet1 = statement1.executeQuery(programmeQuery);
								if (resultSet1.next()) {
									programmeNam = resultSet1.getString("PROGRAMME_NAME");
								}
								resultSet.close();
								statement.close();
							}
							query = "select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a, rws_programme_tbl p,rws_work_completion_tbl c where "
									+ "WORK_CANCEL_DT is null and a.TYPE_OF_ASSET in (" + schemes
									+ ") and a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
									+ "AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
									+ "a.work_id=c.work_id  and DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-"
									+ yearStart + "' and c.dt_fin_completion is null";
							stmt = conn.createStatement();
							rs = stmt.executeQuery(query);
							if (rs.next()) {
								names += programmeNam + ",";
								noOfWorks = rs.getInt(2);
								estCost = rs.getDouble(1);
							}
							String agreementValueQry = "";
							agreementValueQry ="select sum(con.agreement_value),count(distinct a.work_id) from rws_work_admn_tbl a, rws_programme_tbl p,"
									+"rws_work_completion_tbl c,rws_contractor_selection_tbl con where WORK_CANCEL_DT is null and a.work_id=con.work_id "
									+"and a.TYPE_OF_ASSET in ("+schemes+") and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+programme+")"
									+" AND a.CORE_DASHBOARD_STATUS='Y' and ( a.TARGET_DATE_COMP is not null OR a.TARGET_DATE_COMP <> '') and "
									+" a.work_id=c.work_id  and c.DATE_OF_COMPLETION is not null and to_date(c.DATE_OF_COMPLETION)<='31-MAR-"+ yearStart 
									+"' and c.dt_fin_completion is null";
							stmt1 = conn.createStatement();
							rs1 = stmt1.executeQuery(agreementValueQry);
							if (rs1.next()) {
								agreementValue = rs1.getDouble(1);
							}
							stmt1.close();
							rs1.close();
							String bankCum = "";
							bankCum = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
									+"rws_work_completion_tbl c where  WORK_CANCEL_DT is null and b.work_id=a.work_id and a.TYPE_OF_ASSET in (" + schemes
									+ ")  and a.programme_code in (" + programme + ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
									+ "a.work_id=c.work_id  and DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-"
									+ yearStart + "' and c.dt_fin_completion is null and to_date(BANK_SEND_DATE)<='31-MAR-"
									+ yearStart + "'";
							stmt1 = conn.createStatement();
							rs1 = stmt1.executeQuery(bankCum);
							if (rs1.next()) {
								bankUptoPrevYear = rs1.getDouble(1);
							}
							stmt1.close();
							rs1.close();
							String paoCum = "";
							paoCum = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
									+"rws_work_completion_tbl c where  WORK_CANCEL_DT is null and b.work_id=a.work_id and a.TYPE_OF_ASSET in (" + schemes
									+ ")  and a.programme_code in (" + programme + ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
									+ "a.work_id=c.work_id  and DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-"
									+ yearStart + "' and c.dt_fin_completion is null and  to_date(STATE_SEND_DATE)<='31-MAR-" + yearStart + "'";
							stmt1 = conn.createStatement();
							rs1 = stmt1.executeQuery(paoCum);
							if (rs1.next()) {
								paoUptoPrevYear = rs1.getDouble(1);
							}
							stmt1.close();
							rs1.close();
							String amountCumUptoPrevYear = ndf.format((bankUptoPrevYear + paoUptoPrevYear) / 100000);
							String BalEstCostys = ndf.format(estCost - ((bankUptoPrevYear + paoUptoPrevYear) / 100000));
							String bankTot = "";
							bankTot = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
									+"rws_work_completion_tbl c where  WORK_CANCEL_DT is null and b.work_id=a.work_id and a.TYPE_OF_ASSET in (" + schemes
									+ ")  and a.programme_code in (" + programme + ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
									+ "a.work_id=c.work_id  and DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-"
									+ yearStart + "' and c.dt_fin_completion is null and  to_date(BANK_SEND_DATE)>='01-APR-" + yearStart+"'";
							stmt1 = conn.createStatement();
							rs1 = stmt1.executeQuery(bankTot);
							if (rs1.next()) {
								bankYear = rs1.getDouble(1);
							}
							stmt1.close();
							rs1.close();
							//
							 
		                    String billsamtquery = "";
							
		                    billsamtquery = "select sum(wb.BILL_AMT_ADMISSIBLE) from rws_work_admn_tbl a, rws_programme_tbl p,rws_work_completion_tbl c ,RWS_WORK_BILL_TBL wb where "
		    						+ "WORK_CANCEL_DT is null and a.TYPE_OF_ASSET in (" + schemes
		    						+ ") and a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
		    						+ "AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
		    						+ "a.work_id=c.work_id  and DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-"
		    						+ yearStart + "' and c.dt_fin_completion is null and wb.EE_FWD_DATE is not null and wb.work_id=a.work_id and  not EXISTS  (select 1 from rws_bill_bank_bridge_tbl b where b.work_id=wb.work_Id and b.bill_sl_no=wb.bill_sl_no )";
		                    
		                   /*  	billsamtquery = "select sum(wb.BILL_AMT_ADMISSIBLE) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_new_est_tbl t ,"
		                                 + "rws_contractor_selection_tbl m,RWS_WORK_BILL_TBL wb where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
		                                 + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') "
		                                 + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id and t.work_id=a.work_id "
		                                 + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and wb.EE_FWD_DATE is not null and wb.work_id=a.work_id and  not EXISTS  (select 1 from rws_bill_bank_bridge_tbl b where b.work_id=wb.work_Id and b.bill_sl_no=wb.bill_sl_no )";
		                    */
		                    //System.out.println(groundWorks);
		                 
		                    stmt1 = conn.createStatement();
		                    rs1 = stmt1.executeQuery(billsamtquery);
		                    if (rs1.next()) {
		                      billamount = rs1.getDouble(1);    
		                    }
		                    stmt1.close();
		                    rs1.close();
		                    
							
							
							
							
							//
							
							
							
							
							
							
							String paoTot = "";
							paoTot = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
									+"rws_work_completion_tbl c where  WORK_CANCEL_DT is null and b.work_id=a.work_id and a.TYPE_OF_ASSET in (" + schemes
									+ ")  and a.programme_code in (" + programme + ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
									+ "a.work_id=c.work_id  and DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-"
									+ yearStart + "' and c.dt_fin_completion is null and  to_date(STATE_SEND_DATE)>='01-APR-" + yearStart+ "'"; 
							stmt1 = conn.createStatement();
							rs1 = stmt1.executeQuery(paoTot);
							if (rs1.next()) {
								paoYear = rs1.getDouble(1);
							}
							stmt1.close();
							rs1.close();
							String amountTot = ndf.format((bankYear + paoYear) / 100000);
							String balEstCost= ndf.format(estCost-(bankUptoPrevYear+paoUptoPrevYear+bankYear + paoYear) / 100000);
							if (noOfWorks == 0 && estCost == 0 &&agreementValue==0
									&& bankUptoPrevYear == 0.0 && paoUptoPrevYear == 0.0
									&& bankYear == 0.0 && paoYear == 0.0 ) {
							} else {
								if (styleCount % 2 == 0) {
									style = "gridbg1";
								} else {
									style = "gridbg2";
								}
								styleCount++;
			%>
			<tr>
				<%
					if (!mainProgrammeName.equals(dupeProgrammeName)) {
										//System.out.println("programme----"+mainProgrammeName);
				%>
				<td class="<%=style%>" style="text-align: right;" align="right"
					width="50px"><%=++slno%></td>
				<%
					if (mainProgrammeName.equals("NRDWP RELATED")) {
				%>
				<td class="<%=style%>" style="text-align: left;" align="right"
					width="100px"><a
					href="rws_work_prog_phyComp_finNot_circle_div_rpt.jsp?mode=circles&programme=<%=progCodeNRDWP%>&programmeName=<%=mainProgrammeName%>&schemes=<%=schemesTot%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>"><%=mainProgrammeName%></a></td>
				<%
					} else {
				%>
				<td class="<%=style%>" style="text-align: left;" align="right"
					width="100px"><a
					href="rws_work_prog_phyComp_finNot_circle_div_rpt.jsp?mode=circles&programme=<%=programme%>&programmeName=<%=mainProgrammeName%>&schemes=<%=schemesTot%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>"><%=mainProgrammeName%></a></td>
				<%
					}
				} else {
				%>
				<td class="<%=style%>" style="text-align: right;" align="right"
					width="50px"></td>
				<td class="<%=style%>" style="text-align: right;" align="right"
					width="100px"></td>
				<%
					}
				%>
				<td class="<%=style%>" style="text-align: left;" align="right"
					width="100px"><a
					href="rws_work_prog_phyComp_finNot_circle_div_rpt.jsp?mode=circles&programme=<%=programme%>&programmeName=<%=programmeNam%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>"><%=programmeNam%>
						(<b><%=schemeName%></b>)</a></td>

				<td class="<%=style%>" style="text-align: right;" align="right"
					width="50px"><a
					href="rws_work_phyComp_finNComp_subprog_rpt.jsp?programme=<%=programme%>&programmeName=<%=programmeNam%>&scheme=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>"
					onmouseover="Tip(this.value,TITLE,'Click Here To View the Sub Program wise Details for Programme <%=programmeNam%> and Scheme <%=schemeName%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"
					onmouseout="UnTip()"><b>Click&nbsp;Here</b></a></td>
				<%
					if (schemeName.equals("SVS")) {
				%>
				<td class="<%=style%>" style="text-align: left;" align="center"
					width="100px"><a href="#"
					onclick="viewWorks('./rws_work_prog_phyComp_finNotComp_drill.jsp?mode=cWorks&pc=<%=programme%>&pn=<%=programmeNam%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><font
					color="blue"><b><%=schemeName%>-<%=noOfWorks%></b></font></a></td>
				<%
					} else if (schemeName.equals("MVS")) {
				%>
				<td class="<%=style%>" style="text-align: left;" align="center"
					width="100px"><a href="#"
					onclick="viewWorks('./rws_work_prog_phyComp_finNotComp_drill.jsp?mode=cWorks&pc=<%=programme%>&pn=<%=programmeNam%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><font
					color="green"><b><%=schemeName%>-<%=noOfWorks%></b></font></a></td>
				<%
					} else {
				%>
				<td class="<%=style%>" style="text-align: left;" align="center"
					width="100px"><a href="#"
					onclick="viewWorks('./rws_work_prog_phyComp_finNotComp_drill.jsp?mode=cWorks&pc=<%= programme%>&pn=<%= programmeNam%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><font
					color="orange"><b><%=schemeName%>-<%=noOfWorks%></b></font></a></td>
				<%
					}
				%>
				<td class="<%=style%>" style="text-align: right;" align="right"	width="100px"><%=ndf.format(estCost)%></td>
				<td class="<%=style%>" style="text-align: right;" align="right"	width="100px"><%=ndf.format(agreementValue/100000)%></td>
				<td class="<%=style%>" style="text-align: right;" align="right"	width="100px"><%=amountCumUptoPrevYear%></td>
				<td class="<%=style%>" style="text-align: right;" align="right"	width="100px"><%=BalEstCostys%></td>
				<td class="<%=style%>" style="text-align: right;" align="right"	width="100px"><%=amountTot%></td>
				<td class="<%=style%>" style="text-align: right;" align="right"	width="100px"><%=balEstCost%></td>
			
			<td class="<%=style%>" style="text-align: right;" align="right"	width="100px"><%=ndf.format(billamount/100000)%></td>
			</tr>
			<%
								dupeProgrammeName = mainProgrammeName;
								oldprogName = programmeNam;
							}
							totNoOfWorks = totNoOfWorks + noOfWorks;
							totEstCost = totEstCost + estCost;
							totAgrCost=totAgrCost+agreementValue;
							totExpUptoPY = totExpUptoPY + bankUptoPrevYear + paoUptoPrevYear;
							totBalEstCost14ys = totBalEstCost14ys + (estCost -((bankUptoPrevYear + paoUptoPrevYear)/100000));
							totTotExp = totTotExp +bankYear + paoYear;
							totBalEstCost=totBalEstCost+ (estCost -((bankUptoPrevYear + paoUptoPrevYear+bankYear + paoYear)/100000));
							//if(!mainProgrammeName.equals("JJM")){
							totbillamt=totbillamt+billamount;
							//}
							//System.out.println(mainProgrammeName+"*****  "+billamount);
							
							stmt.close();
							rs.close();
							if (slno == 0) {
			%>
			<tr>
				<td colspan="12" class="<%=style%>" style="text-align: center;">No Records Found</td>
			</tr>
			<%
				}
						}
					}
			%>
			<tr class="rightPad">
				<td class="btext" style="text-align: right;" colspan=4>Total:</td>
				<td class="btext" style="text-align: right;"><%=totNoOfWorks%></td>
				<td class="btext" style="text-align: right;"><%=ndf.format(totEstCost)%></td>
				<td class="btext" style="text-align: right;"><%=ndf.format(totAgrCost / 100000)%></td>
				<td class="btext" style="text-align: right;"><%=ndf.format(totExpUptoPY / 100000)%></td>
				<td class="btext" style="text-align: right;"><%=ndf.format(totBalEstCost14ys )%></td>
				<td class="btext" style="text-align: right;"><%=ndf.format(totTotExp / 100000)%></td>
				<td class="btext" style="text-align: right;"><%=ndf.format(totBalEstCost ) %></td>
				<td class="btext" style="text-align: right;"><%=ndf.format(totbillamt/100000 ) %></td>
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
	</form>
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
</body>
</html>

