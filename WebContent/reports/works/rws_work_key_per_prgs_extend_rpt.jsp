<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%@ page import="java.sql.Date"%>
<%@page import="nic.watersoft.works.WorksData1"%>
<%@ page import="java.util.*"%>
<%
	String populationType = "";
	if (request.getParameter("poptype") != null && !request.getParameter("poptype").equals("")
			&& !request.getParameter("poptype").equals("ALL")) {
		populationType = request.getParameter("poptype");
	} else {
		populationType = "ALL";
	}
	DecimalFormat ndf = new DecimalFormat("####.00");
	WorksData1 data1 = new WorksData1();
	int cyear = Calendar.getInstance().get(Calendar.YEAR);
	int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
	int nmonth = Calendar.getInstance().get(Calendar.MONTH) + 2;
	int lMonth = Calendar.getInstance().get(Calendar.MONTH);
	int day = Calendar.getInstance().get(Calendar.DATE);
	String currentMonth = data1.getCurrentMonth(month);
	String lastMonth = "";
	if (currentMonth.equals("JAN")) {
		lastMonth = "DEC-" + (cyear - 1);
	} else {
		lastMonth = data1.getCurrentMonth(lMonth) + "-" + cyear;
	}
	String nextMonth = "";
	if (currentMonth.equals("DEC")) {
		nextMonth = "JAN-" + (cyear + 1);
	} else {
		nextMonth = data1.getCurrentMonth(nmonth) + "-" + cyear;
	}
	//System.out.println("Next Month:"+nextMonth);
	String cDate = day + "-" + currentMonth + "-" + cyear;
	int yearStart = 0;
	int yearEnd = 0;
	int nextYear = 0;
	/* if (month <= 3) {
		yearStart = cyear - 1;
		yearEnd = cyear;
	} else {
		yearStart = cyear;
		yearEnd = cyear + 1;	
	} */
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
	 int startFinYear=0;
	    if (month <= 3) {
	    	startFinYear = cyear - 1;
	       
	    } else {
	    	startFinYear = cyear;
	       
	    }
	nextYear = yearEnd + 1;
	HashMap programmeList = new HashMap();

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
	statement.close();
	resultSet.close();
	String cmcoredb = "select PROGRAMME_CODE from  rws_programme_tbl where NRDWP_RELATED='N' and  CM_CORE_DB='Y' order by 1";
	statement = conn.createStatement();
	resultSet = statement.executeQuery(cmcoredb);
	int x = 1;
	while (resultSet.next()) {
		programmeList.put(x, resultSet.getString(1));
		x++;
	}
	programmeList.put(x, progCode);
	resultSet.close();
	statement.close();
%>
<script language="JavaScript">
	function viewWorks(URL) {
		var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
		if (URL != "") {
			myNewWin = window.open(URL, 'newWinddow', popFeatures);
			myNewWin.focus();
		}
	}
	<%-- function selectedMonth(){
		var selectedMonth=document.forms[0].selectMonth.value;
		alert(selectedMonth);
		if(selectedMonth==''){			
			document.forms[0].selectMonth.value=<%=currentMonth%>;
		}else{
			document.forms[0].selectMonth.value=<%=request.getParameter("selectMonth")%>;			
		}
		alert(document.forms[0].selectMonth.value);
	} --%>
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
<form>
	<body>
		<br />
		<br />
		<br />
		<center>
			<font color="#663899" face="Maiandra GD" size="4px"><b>Progress
					Report (Key Performance Indicators-Extended Report)</b></font> <br />
		</center>
		<br />
		<br>
		<br>
		<center>
			<font color="#663899" face="Maiandra GD" size="4px"><b>Select
					Financial Year:<font color="red">*</font> <SELECT name="finyear"
					id="finyear" style="width: 140px" onchange="this.form.submit()">
					<%
					int endFinYear = 2011;
				int tempYear = 0,temp=0;
				String finYear=request.getParameter("finyear");
				while(startFinYear>=endFinYear){
					tempYear = startFinYear+1;
					//System.out.println("start year :"+startFinYear+" finYear :"+finYear);
					if(finYear != null &&  !finYear.equals("0")){
						temp = Integer.parseInt( finYear.substring(0, 4));
						
					}
					
					if(startFinYear == temp ){
						//System.out.println("in if start year :"+startFinYear+" finYear :"+temp);
						%>
						<option value=<%= String.valueOf(startFinYear)+" - "+String.valueOf(tempYear) %> selected ><%= String.valueOf(startFinYear)+" - "+String.valueOf(tempYear) %></option>
						<%
					}else
					{
					%>
					<option value=<%= String.valueOf(startFinYear)+" - "+String.valueOf(tempYear) %>><%= String.valueOf(startFinYear)+" - "+String.valueOf(tempYear) %></option>
					<%}
					
					startFinYear--;
				}
				
				%>
						<%-- <%
							try {
								String finYear = request.getParameter("finyear");
								String temp = "";
								Statement stmt11 = conn.createStatement();
								String fy = "";
								int fy1 = 0;
								String finquery = "select distinct  substr(to_char(BANK_SEND_DATE,'dd/mm/yyyy'),7,4)  from RWS_bill_bank_bridge_TBL where TO_DATE(BANK_SEND_DATE) is not null and to_char(BANK_SEND_DATE,'MM')>='03'  order by substr(to_char(BANK_SEND_DATE,'dd/mm/yyyy'),7,4) desc ";
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
						%> --%>
				</SELECT>
			</b></font>
		</center>
		<br>
		<br>
		<%
			String selectMonth = "";
			if (request.getParameter("selectMonth") != null) {
				;
				selectMonth = request.getParameter("selectMonth");
			} else {
				selectMonth = currentMonth;
			}
		%>
		<center>
			<font color="#663899" face="Maiandra GD" size="4px"><b>Select
					Month:<font color="red">*</font> <SELECT name="selectMonth"
					id="finyear" style="width: 140px" onchange="this.form.submit()">
						<%
							ArrayList months = new ArrayList();
							months.add("APR");
							months.add("MAY");
							months.add("JUN");
							months.add("JUL");
							months.add("AUG");
							months.add("SEP");
							months.add("OCT");
							months.add("NOV");
							months.add("DEC");
							months.add("JAN");
							months.add("FEB");
							months.add("MAR");

							for (int i = 0; i < months.size(); i++) {
								if (selectMonth != null && selectMonth.equalsIgnoreCase((String) months.get(i))) {
						%>
						<option value="<%=months.get(i)%>" SELECTED><%=months.get(i)%>
							<%
								} else {
							%>
						
						<option value="<%=months.get(i)%>"><%=months.get(i)%>
							<%
								}
								}
							%>
						
				</SELECT>
			</b></font>
		</center>
		<br>
		<br>
		<center>
			<font color="#663899" face="Maiandra GD" size="4px"><b>Select
					Type:<font color="red">*</font> <SELECT name="poptype" id="poptype"
					style="width: 140px" onchange="this.form.submit()">
						<option value="ALL"><font color="#889900"
								face="Maiandra GD" size="2px">ALL</font></option>
						<%
							if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
						%>
						<option value="SC" selected><font color="#889900"
								face="Maiandra GD" size="2px">SC</font></option>
						<%
							} else {
						%>
						<option value="SC"><font color="#889900"
								face="Maiandra GD" size="2px">SC</font></option>
						<%
							}
							if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
						%>
						<option value="ST" selected>ST</option>
						<%
							} else {
						%>
						<option value="ST"><font color="#889900"
								face="Maiandra GD" size="2px">ST</font></option>
						<%
							}
							if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")) {
						%>
						<option value="PLAIN" selected>PLAIN</option>
						<%
							} else {
						%>
						<option value="PLAIN"><font color="#889900"
								face="Maiandra GD" size="2px">PLAIN</font></option>
						<%
							}
						%>
				</SELECT>
			</b></font>
		</center>
		<br />
		<br />
		<table align="center"
			style="margin-top: -45px !important; width: 800px !important; text-align: center !important;">
			<tr>
				<td style="width: 1000px !important; text-align: right !important;">
					<font color="#889900" face="Maiandra GD" size="2px">(Rs.
						Lakhs)</font>
				</td>
				<!-- <td style="width: 40px !important;">
                   <a href="rws_achie_analy_cm_rpt.jsp?programme=00&mode=Bar"  style="color: green !important; font-size: 13px;" id="showGraph"><img height="30px" src="/pred/resources/graphs/bar.ico"></a></td>
               <td style="width: 50px !important; text-align: right !important">
				 <a	href="rws_achie_analy_cm_rpt.jsp?programme=00&mode=Pie" style="color: green !important; font-size: 13px;"
				id="showGraph"><img width="30px" src="/pred/resources/graphs/pie.png"></a> &nbsp;&nbsp;
			</td> -->
			</tr>
		</table>
		<table border=1 cellspacing=0 cellpadding=0 height=5% width="1050px"
			bordercolor=#000000
			style="border-collapse: collapse; margin-top: 20px !important;"
			bgcolor="#ffffff" align="center">
			<tr align=center align=center>
				<td class=btext rowspan=3 style="width: 30px !important;">SNO</td>
				<td class=btext rowspan=3>&nbsp;&nbsp;&nbsp;&nbsp;Programme&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td class=btext rowspan=3>Total Works</td>
				<td class=btext rowspan=3>Est.cost</td>
				<td class=btext rowspan=3>Cum. Exp. Upto 31.3.<%=yearStart%></td>
				<td class=btext rowspan=3>Bal Est Cost as on 1.4.<%=yearStart%></td>
				<td class=btext rowspan=3>Exp. During month</td>
				<td class=btext rowspan=3>Exp. During Fin. Year</td>
				<td class=btext rowspan=3>Total Exp. Including Physically
					completed but financially not completed before by 31.3.<%=yearStart%></td>
				<td class=btext colspan=8>Habs Sanctioned</td>
				<td class=btext rowspan=3>Works Targeted(<%=yearStart%>-<%=yearEnd%>)
				</td>
				<td class=btext rowspan=3>Works completed(<%=yearStart%>-<%=yearEnd%>)
				</td>
				<td class=btext colspan=8>Habs Targeted (<%=yearStart%>-<%=yearEnd%>)
				</td>
				<td class=btext colspan=8>Achievements(<%=yearStart%>-<%=yearEnd%>)
				</td>
				<td class=btext colspan=8>Habs Targeted (<%=yearEnd%>-<%=nextYear%>)
				</td>
			</tr>
			<tr align=center>
				<td class=btext rowspan=2>FC</td>
				<td class=btext colspan=5>PC</td>
				<td class=btext rowspan=2>QA</td>
				<td class=btext rowspan=2>Total</td>
				<td class=btext rowspan=2>FC</td>
				<td class=btext colspan=5>PC</td>
				<td class=btext rowspan=2>QA</td>
				<td class=btext rowspan=2>Total</td>
				<td class=btext rowspan=2>FC</td>
				<td class=btext colspan=5>PC</td>
				<td class=btext rowspan=2>QA</td>
				<td class=btext rowspan=2>Total</td>
				<td class=btext rowspan=2>FC</td>
				<td class=btext colspan=5>PC</td>
				<td class=btext rowspan=2>QA</td>
				<td class=btext rowspan=2>Total</td>
			</tr>
			<tr align=center>
				<td class=btext rowspan=1>PC4</td>
				<td class=btext rowspan=1>PC3</td>
				<td class=btext rowspan=1>PC1</td>
				<td class=btext rowspan=1>PC1</td>
				<td class=btext rowspan=1>NC</td>
				<td class=btext rowspan=1>PC4</td>
				<td class=btext rowspan=1>PC3</td>
				<td class=btext rowspan=1>PC1</td>
				<td class=btext rowspan=1>PC1</td>
				<td class=btext rowspan=1>NC</td>
				<td class=btext rowspan=1>PC4</td>
				<td class=btext rowspan=1>PC3</td>
				<td class=btext rowspan=1>PC1</td>
				<td class=btext rowspan=1>PC1</td>
				<td class=btext rowspan=1>NC</td>
				<td class=btext rowspan=1>PC4</td>
				<td class=btext rowspan=1>PC3</td>
				<td class=btext rowspan=1>PC1</td>
				<td class=btext rowspan=1>PC1</td>
				<td class=btext rowspan=1>NC</td>
			</tr>
			<%
				int styleCount = 0;
				String style = "";
				String schemes = "'01','02','03','10'";
				Statement stmt1 = null;
				ResultSet rs1 = null;
				int slno = 0;
				try {
					int tot_works = 0, tot_targetWorks = 0, tot_compWorks = 0;
					int tot_sanPC4Habs = 0, tot_sanPC3Habs = 0, tot_sanPC2Habs = 0, tot_sanPC1Habs = 0, tot_sanNCHabs = 0,
							tot_sanFCHabs = 0, tot_sanQAHabs = 0, tot_sanHabs = 0;
					int tot_tarPC4Habs = 0, tot_tarPC3Habs = 0, tot_tarPC2Habs = 0, tot_tarPC1Habs = 0, tot_tarNCHabs = 0,
							tot_tarFCHabs = 0, tot_tarQAHabs = 0, tot_tarHabs = 0;
					int tot_achCYPC4Habs = 0, tot_achCYPC3Habs = 0, tot_achCYPC2Habs = 0, tot_achCYPC1Habs = 0,
							tot_achCYNCHabs = 0, tot_achCYFCHabs = 0, tot_achCYQAHabs = 0, tot_achCYHabs = 0;
					int tot_tarNYPC4Habs = 0, tot_tarNYPC3Habs = 0, tot_tarNYPC2Habs = 0, tot_tarNYPC1Habs = 0,
							tot_tarNYNCHabs = 0, tot_tarNYFCHabs = 0, tot_tarNYQAHabs = 0, tot_tarNYHabs = 0;
					Double tot_EstCost = 0.0, tot_amountLFI = 0.0, tot_amountBAL = 0.0, tot_amountPhyCompNotFin = 0.0,
							tot_expCMAmt = 0.0, tot_expBMAmt = 0.0;
					String programme = "";
					for (int i = 1; i <= programmeList.size(); i++) {
						int works = 0, targetWorks = 0, compWorks = 0;
						int sanFCHabs = 0, sanPC4Habs = 0, sanPC3Habs = 0, sanPC2Habs = 0, sanPC1Habs = 0, sanNCHabs = 0,
								sanHabs = 0, sanQAHabs = 0;
						int tarFCHabs = 0, tarPC4Habs = 0, tarPC3Habs = 0, tarPC2Habs = 0, tarPC1Habs = 0, tarNCHabs = 0,
								tarHabs = 0, tarQAHabs = 0;
						int tarNYFCHabs = 0, tarNYPC4Habs = 0, tarNYPC3Habs = 0, tarNYPC2Habs = 0, tarNYPC1Habs = 0,
								tarNYNCHabs = 0, tarNYHabs = 0, tarNYQAHabs = 0;
						int achCYFCHabs = 0, achCYPC4Habs = 0, achCYPC3Habs = 0, achCYPC2Habs = 0, achCYPC1Habs = 0,
								achCYNCHabs = 0, achCYHabs = 0, achCYQAHabs = 0;
						double EstCost = 0.0, bankLastYear = 0.0, paoLastYear = 0.0, bankPhyCompNotFin = 0.0,
								paoPhyCompNotFin = 0.0;
						double bankCMAmt = 0.0, paoCMAmt = 0.0, expCMAmt = 0.0, bankBMAmt = 0.0, paoBMAmt = 0.0,
								expBMAmt = 0.0;
						programme = (String) programmeList.get(i);
						String programmeName = "";
						if (programme.length() > 2) {
							programmeName = "NRDWP";
						} else {
							String programmeQuery = "select PROGRAMME_CODE,PROGRAMME_NAME from  rws_programme_tbl where PROGRAMME_CODE='"
									+ programme + "'";
							Statement statement1 = conn.createStatement();
							ResultSet resultSet1 = statement1.executeQuery(programmeQuery);
							if (resultSet1.next()) {
								programmeName = resultSet1.getString("PROGRAMME_NAME");
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
						String worksQuery = "select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_contractor_selection_tbl m "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and a.PROGRAMME_CODE=p.PROGRAMME_CODE and "
								+ "a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"
								+ yearStart + "') and TARGET_DATE_COMP>='01-APR-" + yearStart + "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y'";
						//System.out.println("worksrelatedSanQuery :- "+ worksQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(worksQuery);
						if (rs1.next()) {
							works = rs1.getInt(2);
							EstCost = rs1.getDouble(1);
						}
						stmt1.close();
						rs1.close();
						/* String habsSanQuery = "select count(b.hab_code),sum(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
								+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y'";
						System.out.println("habsSanQuery :- "+ habsSanQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(habsSanQuery);
						if (rs1.next()) {
							habsSac=rs1.getInt(1);
							popBen=rs1.getInt(2);
						}
						stmt1.close();
						rs1.close(); */
						String bankLFI = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
								+ "where WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"
								+ yearStart + "') "
								+ "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-"
								+ yearStart
								+ "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and TO_DATE(BANK_SEND_DATE)<='31-MAR-"
								+ yearStart + "' " + "and a.TYPE_OF_ASSET in (" + schemes
								+ ") and  a.CORE_DASHBOARD_STATUS='Y'";
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(bankLFI);
						if (rs1.next()) {
							bankLastYear = rs1.getDouble(1);
						}
						stmt1.close();
						rs1.close();
						String paoLFI = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
								+ "where WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"
								+ yearStart + "') "
								+ "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-"
								+ yearStart
								+ "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and TO_DATE(STATE_SEND_DATE)<='31-MAR-"
								+ yearStart + "' " + "and a.TYPE_OF_ASSET in (" + schemes
								+ ") and  a.CORE_DASHBOARD_STATUS='Y'";
						// System.out.println(paoLFI);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(paoLFI);
						if (rs1.next()) {
							paoLastYear = rs1.getDouble(1);
						}
						stmt1.close();
						rs1.close();
						Double amountLFI = bankLastYear + paoLastYear;
						Double amountBAL = (EstCost * 100000) - (bankLastYear + paoLastYear);
						//  System.out.println(selectMonth+"-"+yearStart);
						String bankCM = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
								+ "where WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"
								+ yearStart + "') "
								+ "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-"
								+ yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id";
						if (!selectMonth.equals("JAN") && !selectMonth.equals("FEB") && !selectMonth.equals("MAR")) {
							bankCM += " and to_char(BANK_SEND_DATE,'MON-YYYY')='" + selectMonth + "-" + yearStart + "' ";
						} else {
							bankCM += " and to_char(BANK_SEND_DATE,'MON-YYYY')='" + selectMonth + "-" + yearEnd + "' ";
						}
						bankCM += " and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
						// System.out.println(bankCM);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(bankCM);
						if (rs1.next()) {
							bankCMAmt = rs1.getDouble(1);
						}
						stmt1.close();
						rs1.close();
						String paoCM = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
								+ "where WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"
								+ yearStart + "') "
								+ "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-"
								+ yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id ";
						if (!selectMonth.equals("JAN") && !selectMonth.equals("FEB") && !selectMonth.equals("MAR")) {
							paoCM += " and to_char(STATE_SEND_DATE,'MON-YYYY')='" + selectMonth + "-" + yearStart + "' ";
						} else {
							paoCM += " and to_char(STATE_SEND_DATE,'MON-YYYY')='" + selectMonth + "-" + yearEnd + "' ";
						}

						paoCM += " and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
						//  System.out.println(bankCM);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(paoCM);
						if (rs1.next()) {
							paoCMAmt = rs1.getDouble(1);
						}
						stmt1.close();
						rs1.close();
						expCMAmt = bankCMAmt + paoCMAmt;
						String bankDY = "select sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
								+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
								+ " and a.TYPE_OF_ASSET in (" + schemes + ") and TO_DATE(BANK_SEND_DATE)>='01-APR-" + yearStart
								+ "' and TO_DATE(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "'"
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme
								+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
								+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id "
								+ " and target_date_comp>='01-APR-" + yearStart
								+ "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"
								+ yearStart + "')";
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(bankDY);
						if (rs1.next()) {
							bankBMAmt = rs1.getDouble(1);
						}
						stmt1.close();
						rs1.close();
						String paoDY = "select sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
								+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
								+ " and a.TYPE_OF_ASSET in (" + schemes + ") and TO_DATE(STATE_SEND_DATE)>='01-APR-" + yearStart
								+ "' and TO_DATE(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "'"
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme
								+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
								+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id "
								+ " and target_date_comp>='01-APR-" + yearStart
								+ "' AND a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"
								+ yearStart + "')";
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(paoDY);
						if (rs1.next()) {
							paoBMAmt = rs1.getDouble(1);
						}
						stmt1.close();
						rs1.close();
						expBMAmt = bankBMAmt + paoBMAmt;
						String phyCompNotFinBank = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
								+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
								+ " and a.TYPE_OF_ASSET in (" + schemes + ") and TO_DATE(BANK_SEND_DATE)>='01-APR-" + yearStart
								+ "'  and TO_DATE(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "'"
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme
								+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
								+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(phyCompNotFinBank);
						if (rs1.next()) {
							bankPhyCompNotFin = rs1.getDouble(1);
						}
						stmt1.close();
						rs1.close();
						String phyCompNotFinPAO = "select sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
								+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
								+ " and a.TYPE_OF_ASSET in (" + schemes + ") and TO_DATE(STATE_SEND_DATE)>='01-APR-" + yearStart
								+ "'  and TO_DATE(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "'"
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme
								+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
								+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(phyCompNotFinPAO);
						if (rs1.next()) {
							paoPhyCompNotFin = rs1.getDouble(1);
						}
						stmt1.close();
						rs1.close();
						Double amountPhyCompNotFin = (bankPhyCompNotFin + paoPhyCompNotFin);
						String sanFCHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"
								+ yearStart + "') and TARGET_DATE_COMP>='01-APR-" + yearStart + "' and "
								+ "(TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='FC'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							sanFCHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							sanFCHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							sanFCHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						//System.out.println("habsSanQuery :- "+ sanFCHabQry);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(sanFCHabQry);
						if (rs1.next()) {
							sanFCHabs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String sanPC4HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"
								+ yearStart + "') and TARGET_DATE_COMP>='01-APR-" + yearStart + "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC4'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							sanPC4HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							sanPC4HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							sanPC4HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						//System.out.println("habsSanQuery :- "+ habsSanQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(sanPC4HabQry);
						if (rs1.next()) {
							sanPC4Habs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String sanPC3HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"
								+ yearStart + "') and TARGET_DATE_COMP>='01-APR-" + yearStart + "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC3'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							sanPC3HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							sanPC3HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							sanPC3HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						//System.out.println("habsSanQuery :- "+ habsSanQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(sanPC3HabQry);
						if (rs1.next()) {
							sanPC3Habs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String sanPC2HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"
								+ yearStart + "') and TARGET_DATE_COMP>='01-APR-" + yearStart + "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC2'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							sanPC2HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							sanPC2HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							sanPC2HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						//System.out.println("habsSanQuery :- "+ habsSanQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(sanPC2HabQry);
						if (rs1.next()) {
							sanPC2Habs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String sanPC1HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"
								+ yearStart + "') and TARGET_DATE_COMP>='01-APR-" + yearStart + "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC1'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							sanPC1HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							sanPC1HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							sanPC1HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						//System.out.println("habsSanQuery :- "+ habsSanQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(sanPC1HabQry);
						if (rs1.next()) {
							sanPC1Habs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String sanNCHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"
								+ yearStart + "') and TARGET_DATE_COMP>='01-APR-" + yearStart + "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NC'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							sanNCHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							sanNCHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							sanNCHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						//System.out.println("habsSanQuery :- "+ habsSanQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(sanNCHabQry);
						if (rs1.next()) {
							sanNCHabs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String sanQAHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"
								+ yearStart + "') and TARGET_DATE_COMP>='01-APR-" + yearStart + "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NSS'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							sanQAHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							sanQAHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							sanQAHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						} //System.out.println("habsSanQuery :- "+ habsSanQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(sanQAHabQry);
						if (rs1.next()) {
							sanQAHabs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String sanHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"
								+ yearStart + "') and TARGET_DATE_COMP>='01-APR-" + yearStart + "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS in ('FC','PC1','PC2','PC3','PC4','NC','NSS')";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							sanHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							sanHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							sanHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						} //System.out.println("habsSanQuery :- "+ habsSanQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(sanHabQry);
						if (rs1.next()) {
							sanHabs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String targetworksQuery = "select count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_contractor_selection_tbl m "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and a.PROGRAMME_CODE=p.PROGRAMME_CODE and "
								+ "a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null";
						if (!selectMonth.equals("JAN") && !selectMonth.equals("FEB") && !selectMonth.equals("MAR")) {
							targetworksQuery += " and DATE_OF_COMPLETION<=LAST_DAY(to_date('" + selectMonth + "-"
									+ yearStart + "','MON-YYYY')) ";
						} else {
							targetworksQuery += " and DATE_OF_COMPLETION<=LAST_DAY(to_date('" + selectMonth + "-" + yearEnd
									+ "','MON-YYYY')) ";
						}

						targetworksQuery += ")  and TARGET_DATE_COMP between '01-APR-" + yearStart + "' and " + " '31-MAR-"
								+ yearEnd
								+ "' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y'";
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(targetworksQuery);
						if (rs1.next()) {
							targetWorks = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String compworksQuery = "select count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd "
								+ "where  WORK_CANCEL_DT is null and h.work_id=a.work_id and hd.hab_code=h.hab_code and a.programme_code in ("
								+ programme + ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and a.PROGRAMME_CODE=p.PROGRAMME_CODE and "
								+ "a.work_id  in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION>='01-APR-"
								+ yearStart + "' and DATE_OF_COMPLETION<='31-MAR-" + yearEnd
								+ "') and TARGET_DATE_COMP >='01-APR-" + yearStart + "' and "
								+ " ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y'";
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(compworksQuery);
						if (rs1.next()) {
							compWorks = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String tarFCHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"
								+ yearStart + "') and TARGET_DATE_COMP>='01-APR-" + yearStart
								+ "' and TARGET_DATE_COMP<='31-MAR" + yearEnd + "' and"
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='FC'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							tarFCHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							tarFCHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							tarFCHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						} //System.out.println("habsSanQuery :- "+ sanFCHabQry);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(tarFCHabQry);
						if (rs1.next()) {
							tarFCHabs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String tarPC4HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"
								+ yearStart + "') and TARGET_DATE_COMP>='01-APR-" + yearStart
								+ "' and TARGET_DATE_COMP<='31-MAR" + yearEnd + "' and"
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC4'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							tarPC4HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							tarPC4HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							tarPC4HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						} //System.out.println("habsSanQuery :- "+ habsSanQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(tarPC4HabQry);
						if (rs1.next()) {
							tarPC4Habs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String tarPC3HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"
								+ yearStart + "') and TARGET_DATE_COMP>='01-APR-" + yearStart
								+ "' and TARGET_DATE_COMP<='31-MAR" + yearEnd + "' and"
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC3'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							tarPC3HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							tarPC3HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							tarPC3HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						} //System.out.println("habsSanQuery :- "+ habsSanQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(tarPC3HabQry);
						if (rs1.next()) {
							tarPC3Habs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String tarPC2HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"
								+ yearStart + "') and TARGET_DATE_COMP>='01-APR-" + yearStart
								+ "' and TARGET_DATE_COMP<='31-MAR" + yearEnd + "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC2'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							tarPC2HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							tarPC2HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							tarPC2HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						} //System.out.println("habsSanQuery :- "+ habsSanQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(tarPC2HabQry);
						if (rs1.next()) {
							tarPC2Habs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String tarPC1HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"
								+ yearStart + "') and TARGET_DATE_COMP>='01-APR-" + yearStart
								+ "' and TARGET_DATE_COMP<='31-MAR" + yearEnd + "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC1'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							tarPC1HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							tarPC1HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							tarPC1HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						} //System.out.println("habsSanQuery :- "+ habsSanQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(tarPC1HabQry);
						if (rs1.next()) {
							tarPC1Habs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String tarNCHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"
								+ yearStart + "') and TARGET_DATE_COMP>='01-APR-" + yearStart
								+ "' and TARGET_DATE_COMP<='31-MAR" + yearEnd + "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NC'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							tarNCHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							tarNCHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							tarNCHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						} //System.out.println("habsSanQuery :- "+ habsSanQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(tarNCHabQry);
						if (rs1.next()) {
							tarNCHabs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String tarQAHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"
								+ yearStart + "') and TARGET_DATE_COMP>='01-APR-" + yearStart
								+ "' and TARGET_DATE_COMP<='31-MAR" + yearEnd + "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NSS'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							tarQAHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							tarQAHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							tarQAHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						} //System.out.println("habsSanQuery :- "+ habsSanQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(tarQAHabQry);
						if (rs1.next()) {
							tarQAHabs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String tarHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"
								+ yearStart + "') and TARGET_DATE_COMP>='01-APR-" + yearStart
								+ "' and TARGET_DATE_COMP<='31-MAR" + yearEnd + "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS in ('FC','PC1','PC2','PC3','PC4','NC','NSS')";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							tarHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							tarHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							tarHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						} //System.out.println("habsSanQuery :- "+ habsSanQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(tarHabQry);
						if (rs1.next()) {
							tarHabs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String tarNYFCHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null ) and TARGET_DATE_COMP>='01-APR-"
								+ yearEnd + "' and  TARGET_DATE_COMP<='31-MAR-" + nextYear + "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='FC'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							tarNYFCHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							tarNYFCHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							tarNYFCHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						} //System.out.println("tarNYFCHabQry :- "+ tarNYFCHabQry);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(tarNYFCHabQry);
						if (rs1.next()) {
							tarNYFCHabs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String tarNYPC4HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and TARGET_DATE_COMP>='01-APR-"
								+ yearEnd + "' and  TARGET_DATE_COMP<='31-MAR-" + nextYear + "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC4'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							tarNYPC4HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							tarNYPC4HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							tarNYPC4HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						} //System.out.println("tarNYPC4HabQry :- "+ tarNYPC4HabQry);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(tarNYPC4HabQry);
						if (rs1.next()) {
							tarNYPC4Habs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String tarNYPC3HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null ) and TARGET_DATE_COMP>='01-APR-"
								+ yearEnd + "' and  TARGET_DATE_COMP<='31-MAR-" + nextYear + "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC3'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							tarNYPC3HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							tarNYPC3HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							tarNYPC3HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						} //System.out.println("tarNYPC3HabQry :- "+ tarNYPC3HabQry);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(tarNYPC3HabQry);
						if (rs1.next()) {
							tarNYPC3Habs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String tarNYPC2HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and TARGET_DATE_COMP>='01-APR-"
								+ yearEnd + "' and  TARGET_DATE_COMP<='31-MAR-" + nextYear + "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC2'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							tarNYPC2HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							tarNYPC2HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							tarNYPC2HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						} //System.out.println("tarNYPC2HabQry :- "+ tarNYPC2HabQry);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(tarNYPC2HabQry);
						if (rs1.next()) {
							tarNYPC2Habs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String tarNYPC1HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null ) and TARGET_DATE_COMP>='01-APR-"
								+ yearEnd + "' and  TARGET_DATE_COMP<='31-MAR-" + nextYear + "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC1'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							tarNYPC1HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							tarNYPC1HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							tarNYPC1HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						} //System.out.println("tarNYPC1HabQry :- "+ tarNYPC1HabQry);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(tarNYPC1HabQry);
						if (rs1.next()) {
							tarNYPC1Habs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String tarNYNCHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and TARGET_DATE_COMP>='01-APR-"
								+ yearEnd + "' and  TARGET_DATE_COMP<='31-MAR-" + nextYear + "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NC'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							tarNYNCHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							tarNYNCHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							tarNYNCHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						} //System.out.println("tarNYNCHabQry :- "+ tarNYNCHabQry);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(tarNYNCHabQry);
						if (rs1.next()) {
							tarNYNCHabs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String tarNYQAHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and TARGET_DATE_COMP>='01-APR-"
								+ yearEnd + "' and  TARGET_DATE_COMP<='31-MAR-" + nextYear + "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NSS'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							tarNYQAHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							tarNYQAHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							tarNYQAHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						} //System.out.println("tarNYQAHabQry :- "+ tarNYQAHabQry);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(tarNYQAHabQry);
						if (rs1.next()) {
							tarNYQAHabs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String tarNYHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and TARGET_DATE_COMP>='01-APR-"
								+ yearEnd + "' and  TARGET_DATE_COMP<='31-MAR-" + nextYear + "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS in ('FC','PC1','PC2','PC3','PC4','NC','NSS')";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							tarNYHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							tarNYHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							tarNYHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						} //System.out.println("tarNYHabQry :- "+ tarNYHabQry);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(tarNYHabQry);
						if (rs1.next()) {
							tarNYHabs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String achCYFCHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-APR-"
								+ yearStart + "' and DATE_OF_COMPLETION<='31-MAR-" + yearEnd
								+ "' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-APR-"
								+ yearStart + "' and partial_date_of_completion <='31-MAR-" + yearEnd
								+ "' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-" + yearStart
								+ "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='FC'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							achCYFCHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							achCYFCHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							achCYFCHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						} //System.out.println("achCYFCHabQry :- "+ achCYFCHabQry);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(achCYFCHabQry);
						if (rs1.next()) {
							achCYFCHabs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String achCYPC4HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-APR-"
								+ yearStart + "' and DATE_OF_COMPLETION<='31-MAR-" + yearEnd
								+ "' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-APR-"
								+ yearStart + "' and partial_date_of_completion <='31-MAR-" + yearEnd
								+ "' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-" + yearStart
								+ "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC4'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							achCYPC4HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							achCYPC4HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							achCYPC4HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						} //System.out.println("habsSanQuery :- "+ habsSanQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(achCYPC4HabQry);
						if (rs1.next()) {
							achCYPC4Habs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String achCYPC3HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-APR-"
								+ yearStart + "' and DATE_OF_COMPLETION<='31-MAR-" + yearEnd
								+ "' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-APR-"
								+ yearStart + "' and partial_date_of_completion <='31-MAR-" + yearEnd
								+ "' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-" + yearStart
								+ "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC3'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							achCYPC3HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							achCYPC3HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							achCYPC3HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						} //System.out.println("habsSanQuery :- "+ habsSanQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(achCYPC3HabQry);
						if (rs1.next()) {
							achCYPC3Habs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String achCYPC2HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-APR-"
								+ yearStart + "' and DATE_OF_COMPLETION<='31-MAR-" + yearEnd
								+ "' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-APR-"
								+ yearStart + "' and partial_date_of_completion <='31-MAR-" + yearEnd
								+ "' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-" + yearStart
								+ "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC2'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							achCYPC2HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							achCYPC2HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							achCYPC2HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						} //System.out.println("habsSanQuery :- "+ habsSanQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(achCYPC2HabQry);
						if (rs1.next()) {
							achCYPC2Habs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String achCYPC1HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-APR-"
								+ yearStart + "' and DATE_OF_COMPLETION<='31-MAR-" + yearEnd
								+ "' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-APR-"
								+ yearStart + "' and partial_date_of_completion <='31-MAR-" + yearEnd
								+ "' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-" + yearStart
								+ "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC1'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							achCYPC1HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							achCYPC1HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							achCYPC1HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						} //System.out.println("habsSanQuery :- "+ habsSanQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(achCYPC1HabQry);
						if (rs1.next()) {
							achCYPC1Habs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String achCYNCHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-APR-"
								+ yearStart + "' and DATE_OF_COMPLETION<='31-MAR-" + yearEnd
								+ "' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-APR-"
								+ yearStart + "' and partial_date_of_completion <='31-MAR-" + yearEnd
								+ "' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-" + yearStart
								+ "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NC'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							achCYNCHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							achCYNCHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							achCYNCHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						} //System.out.println("habsSanQuery :- "+ habsSanQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(achCYNCHabQry);
						if (rs1.next()) {
							achCYNCHabs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String achCYQAHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-APR-"
								+ yearStart + "' and DATE_OF_COMPLETION<='31-MAR-" + yearEnd
								+ "' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-APR-"
								+ yearStart + "' and partial_date_of_completion <='31-MAR-" + yearEnd
								+ "' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-" + yearStart
								+ "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NSS'";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							achCYQAHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							achCYQAHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							achCYQAHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						} //System.out.println("habsSanQuery :- "+ habsSanQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(achCYQAHabQry);
						if (rs1.next()) {
							achCYQAHabs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						String achCYHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
								+ "where  WORK_CANCEL_DT is null and a.programme_code in (" + programme
								+ ") and SUBSTR(a.work_id,7,2) in (" + schemes
								+ ")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
								+ "a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-APR-"
								+ yearStart + "' and DATE_OF_COMPLETION<='31-MAR-" + yearEnd
								+ "' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-APR-"
								+ yearStart + "' and partial_date_of_completion <='31-MAR-" + yearEnd
								+ "' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-" + yearStart
								+ "' and "
								+ "( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS in ('FC','PC1','PC2','PC3','PC4','NC','NSS')";
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")) {
							achCYHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")) {
							achCYHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
						if (populationType != null && !populationType.equals("")
								&& populationType.equalsIgnoreCase("PLAIN")) {
							achCYHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						} //System.out.println("habsSanQuery :- "+ habsSanQuery);
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(achCYHabQry);
						if (rs1.next()) {
							achCYHabs = rs1.getInt(1);
						}
						stmt1.close();
						rs1.close();
						tot_works += works;
						tot_EstCost += EstCost;
						tot_amountLFI += amountLFI;
						tot_amountBAL += amountBAL;
						tot_expCMAmt += expCMAmt;
						tot_expBMAmt += expBMAmt;
						tot_amountPhyCompNotFin += amountPhyCompNotFin;
						tot_sanFCHabs += sanFCHabs;
						tot_sanPC4Habs += sanPC4Habs;
						tot_sanPC3Habs += sanPC3Habs;
						tot_sanPC2Habs += sanPC2Habs;
						tot_sanPC1Habs += sanPC1Habs;
						tot_sanNCHabs += sanNCHabs;
						tot_sanQAHabs += sanQAHabs;
						tot_sanHabs += sanHabs;
						tot_tarFCHabs += tarFCHabs;
						tot_tarPC4Habs += tarPC4Habs;
						tot_tarPC3Habs += tarPC3Habs;
						tot_tarPC2Habs += tarPC2Habs;
						tot_tarPC1Habs += tarPC1Habs;
						tot_tarNCHabs += tarNCHabs;
						tot_tarQAHabs += tarQAHabs;
						tot_tarHabs += tarHabs;
						tot_tarNYFCHabs += tarNYFCHabs;
						tot_tarNYPC4Habs += tarNYPC4Habs;
						tot_tarNYPC3Habs += tarNYPC3Habs;
						tot_tarNYPC2Habs += tarNYPC2Habs;
						tot_tarNYPC1Habs += tarNYPC1Habs;
						tot_tarNYNCHabs += tarNYNCHabs;
						tot_tarNYQAHabs += tarNYQAHabs;
						tot_tarNYHabs += tarNYHabs;
						tot_achCYFCHabs += achCYFCHabs;
						tot_achCYPC4Habs += achCYPC4Habs;
						tot_achCYPC3Habs += achCYPC3Habs;
						tot_achCYPC2Habs += achCYPC2Habs;
						tot_achCYPC1Habs += achCYPC1Habs;
						tot_achCYNCHabs += achCYNCHabs;
						tot_achCYQAHabs += achCYQAHabs;
						tot_achCYHabs += achCYHabs;
						tot_targetWorks += targetWorks;
						tot_compWorks += compWorks;
						if (works == 0 && targetWorks == 0 && compWorks == 0 && sanFCHabs == 0 && sanPC4Habs == 0
								&& sanPC3Habs == 0 && sanPC2Habs == 0 && sanPC1Habs == 0 && sanNCHabs == 0 && sanHabs == 0
								&& sanQAHabs == 0 && tarFCHabs == 0 && tarPC4Habs == 0 && tarPC3Habs == 0 && tarPC2Habs == 0
								&& tarPC1Habs == 0 && tarNCHabs == 0 && tarHabs == 0 && tarQAHabs == 0 && tarNYFCHabs == 0
								&& tarNYPC4Habs == 0 && tarNYPC3Habs == 0 && tarNYPC2Habs == 0 && tarNYPC1Habs == 0
								&& tarNYNCHabs == 0 && tarNYHabs == 0 && tarNYQAHabs == 0 && achCYFCHabs == 0
								&& achCYPC4Habs == 0 && achCYPC3Habs == 0 && achCYPC2Habs == 0 && achCYPC1Habs == 0
								&& achCYNCHabs == 0 && achCYHabs == 0 && achCYQAHabs == 0 && EstCost == 0.0
								&& bankLastYear == 0.0 && paoLastYear == 0.0 && bankPhyCompNotFin == 0.0
								&& paoPhyCompNotFin == 0.0 && bankCMAmt == 0.0 && paoCMAmt == 0.0 && expCMAmt == 0.0
								&& bankBMAmt == 0.0 && paoBMAmt == 0.0 && expBMAmt == 0.0) {
						} else {
			%>
			<tr>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=++slno%></td>
				<td class="<%=style%>" style="text-align: left;" align="left"><a
					href="./rws_work_key_per_extend_div_subdiv_rpt.jsp?mode=circles&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>"><%=programmeName%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./rws_work_key_per_ext_drill.jsp?mode=total&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=works%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(EstCost)%></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(amountLFI / 100000)%></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(amountBAL / 100000)%></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(expCMAmt / 100000)%></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(expBMAmt / 100000)%></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(amountPhyCompNotFin / 100000)%></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanFC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=sanFCHabs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanPC4&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=sanPC4Habs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanPC3&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=sanPC3Habs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanPC2&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=sanPC2Habs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanPC1&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=sanPC1Habs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanNC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=sanNCHabs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanQA&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=sanQAHabs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill.jsp?mode=san&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=sanHabs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./rws_work_key_per_ext_drill.jsp?mode=targeted&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=targetWorks%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./rws_work_key_per_ext_drill.jsp?mode=completed&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=compWorks%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarFC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=tarFCHabs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarPC4&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=tarPC4Habs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarPC3&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=tarPC3Habs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarPC2&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=tarPC2Habs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarPC1&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=tarPC1Habs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=tarNCHabs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarQA&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=tarQAHabs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tar&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=tarHabs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYFC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=achCYFCHabs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYPC4&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=achCYPC4Habs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYPC3&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=achCYPC3Habs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYPC2&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=achCYPC2Habs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYPC1&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=achCYPC1Habs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYNC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=achCYNCHabs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCYQA&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=achCYQAHabs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=achCY&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=achCYHabs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYFC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=tarNYFCHabs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYPC4&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=tarNYPC4Habs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYPC3&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=tarNYPC3Habs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYPC2&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=tarNYPC2Habs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYPC1&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=tarNYPC1Habs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYNC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=tarNYNCHabs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNYQA&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=tarNYQAHabs%></a></td>
				<td class="<%=style%>" style="text-align: right;" align="right"><a
					href="#"
					onclick="viewWorks('./work_load_habs_drill_kpi_new.jsp?mode=tarNY&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&selectMonth=<%=selectMonth%>')"><%=tarNYHabs%></a></td>
			</tr>
			<%
				}
					}
			%>
			<tr>
				<td class="btext" style="text-align: right;" colspan="2">Total
				</td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_works%></td>
				<td class="btext" style="text-align: right;" align="right"><%=ndf.format(tot_EstCost)%></td>
				<td class="btext" style="text-align: right;" align="right"><%=ndf.format(tot_amountLFI / 100000)%></td>
				<td class="btext" style="text-align: right;" align="right"><%=ndf.format(tot_amountBAL / 100000)%></td>
				<td class="btext" style="text-align: right;" align="right"><%=ndf.format(tot_expCMAmt / 100000)%></td>
				<td class="btext" style="text-align: right;" align="right"><%=ndf.format(tot_expBMAmt / 100000)%></td>
				<td class="btext" style="text-align: right;" align="right"><%=ndf.format(tot_amountPhyCompNotFin / 100000)%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_sanFCHabs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_sanPC4Habs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_sanPC3Habs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_sanPC2Habs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_sanPC1Habs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_sanNCHabs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_sanQAHabs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_sanHabs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_targetWorks%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_compWorks%>
				<td class="btext" style="text-align: right;" align="right"><%=tot_tarFCHabs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_tarPC4Habs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_tarPC3Habs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_tarPC2Habs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_tarPC1Habs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_tarNCHabs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_tarQAHabs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_tarHabs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_achCYFCHabs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_achCYPC4Habs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_achCYPC3Habs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_achCYPC2Habs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_achCYPC1Habs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_achCYNCHabs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_achCYQAHabs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_achCYHabs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_tarNYFCHabs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_tarNYPC4Habs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_tarNYPC3Habs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_tarNYPC2Habs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_tarNYPC1Habs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_tarNYNCHabs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_tarNYQAHabs%></td>
				<td class="btext" style="text-align: right;" align="right"><%=tot_tarNYHabs%></td>

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
</body>
