<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%@ page import="java.sql.Date"%>
<%@page import="nic.watersoft.works.WorksData1"%>
<%@ page import="java.util.*"%>
<%
String populationType = "";
if (request.getParameter("poptype") != null && !request.getParameter("poptype").equals("") && !request.getParameter("poptype").equals("ALL")) {
	populationType = request.getParameter("poptype");
} else {
	populationType = "ALL";
}
DecimalFormat ndf = new DecimalFormat("####.00");
WorksData1 data1 = new WorksData1();
int cyear = Calendar.getInstance().get(Calendar.YEAR);
int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
int nmonth= Calendar.getInstance().get(Calendar.MONTH) +2;
int lMonth = Calendar.getInstance().get(Calendar.MONTH);
int day = Calendar.getInstance().get(Calendar.DATE);
String currentMonth = data1.getCurrentMonth(month);
String lastMonth = "";
if (currentMonth.equals("JAN")) {
	lastMonth = "DEC-" + (cyear - 1);
} else {
	lastMonth = data1.getCurrentMonth(lMonth) + "-" + cyear;
}
String nextMonth="";
if (currentMonth.equals("DEC")) {
	nextMonth = "JAN-" + (cyear + 1);
} else {
	nextMonth = data1.getCurrentMonth(nmonth) + "-" + cyear;
}
//System.out.println("Next Month:"+nextMonth);
String cDate = day + "-" + currentMonth + "-" + cyear;
int yearStart = 0;
int yearEnd = 0;
if (month <= 3) {
	yearStart = cyear - 1;
	yearEnd = cyear;
} else {
	yearStart = cyear;
	yearEnd = cyear + 1;
}
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
int x=1;
while (resultSet.next()) {
	programmeList.put(x,resultSet.getString(1));
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

</style><form>
<body>
	<br/><br/><br />
	<center>
		<font color="#663899" face="Maiandra GD" size="4px"><b>Progress Report (Key Performance Indicators)</b></font> <br />
	</center>
	<br/><br/><br/>
	<table align="center"
		style="margin-top: -45px !important; width: 800px !important; text-align: center !important;">
		<tr>
			<td style="width: 1000px !important; text-align: right !important;">
				<font color="#889900" face="Maiandra GD" size="2px">(Rs. Lakhs)</font>
			</td>
			<!-- <td style="width: 40px !important;">
                   <a href="rws_achie_analy_cm_rpt.jsp?programme=00&mode=Bar"  style="color: green !important; font-size: 13px;" id="showGraph"><img height="30px" src="/pred/resources/graphs/bar.ico"></a></td>
               <td style="width: 50px !important; text-align: right !important">
				 <a	href="rws_achie_analy_cm_rpt.jsp?programme=00&mode=Pie" style="color: green !important; font-size: 13px;"
				id="showGraph"><img width="30px" src="/pred/resources/graphs/pie.png"></a> &nbsp;&nbsp;
			</td> -->
		</tr>
	</table>
	<br/><br/>
			<center>
	<font color="#663899" face="Maiandra GD" size="4px"><b>Select Type:<font color="red">*</font>
					<SELECT name="poptype" id="poptype" style="width: 140px" onchange="this.form.submit()">
					   	 <option value="ALL"><font color="#889900" face="Maiandra GD" size="2px">ALL</font></option>
						<% if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){ %>
						     <option value="SC" selected><font color="#889900" face="Maiandra GD" size="2px">SC</font></option>
						<% } else {%>
							 <option value="SC" ><font color="#889900" face="Maiandra GD" size="2px">SC</font></option>
						<% } if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){ %>
							 <option value="ST" selected>ST</option>
						<% } else {%>
							 <option value="ST"><font color="#889900" face="Maiandra GD" size="2px">ST</font></option>
						<% } if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){ %>
						     <option value="PLAIN" selected>PLAIN</option>
						 <%} else {%>
						     <option value="PLAIN"><font color="#889900" face="Maiandra GD" size="2px">PLAIN</font></option>
						<% } %>
		</SELECT></b></font></center>
					<br/><br/>
	<table border=1 cellspacing=0 cellpadding=0 height=5% width="1050px" bordercolor=#000000 style="border-collapse: collapse; margin-top: 20px !important;" bgcolor="#ffffff" align="center">
			
		
		<tr align=center align=center>
				<td class=btext rowspan=4 style="width: 30px !important;">SNO</td>
				<td class=btext rowspan=4>&nbsp;&nbsp;&nbsp;&nbsp;Programme&nbsp;&nbsp;&nbsp;&nbsp;</td>
				<td class=btext rowspan=4>Total Works</td>
				<td class=btext rowspan=4>Est.cost</td>
				<td class=btext rowspan=4>Cum. Exp. Upto 31.3.<%=yearStart %></td>
				<td class=btext rowspan=4>Bal Est Cost as on 1.4.<%=yearStart %></td>
				<td class=btext rowspan=4>Exp. During month</td>
				<td class=btext rowspan=4>Exp. During year</td>
				<td class=btext rowspan=4>Total Exp. Including Physically completed but financially not completed before by 31.3.<%=yearStart %></td>
				<td class=btext colspan=8>Habs Sanctioned</td>
				<td class=btext rowspan=4>Works Targeted(<%=yearStart %>-<%=yearEnd%>)</td>
				<td class=btext rowspan=4>Works completed(<%=yearStart %>-<%=yearEnd%>)</td>
				<td class=btext colspan=16>Habs Targeted (<%=yearStart %>-<%=yearEnd%>)</td>
				<td class=btext colspan=16>Achievements(<%=yearStart %>-<%=yearEnd%>)</td>
			</tr>
			<tr align=center >
				<td class=btext rowspan=3>FC</td>
				<td class=btext colspan=5>PC</td>
				<td class=btext rowspan=3>QA</td>
				<td class=btext rowspan=3>Total</td>
				<td class=btext colspan=8>Current Month</td>
				<td class=btext colspan=8>Upto Previous Month</td>
				<td class=btext colspan=8>Current Month</td>
				<td class=btext colspan=8>Upto Previous Month</td>
			</tr>
			<tr align=center >
				<td class=btext rowspan=2>PC4</td>
				<td class=btext rowspan=2>PC3</td>
				<td class=btext rowspan=2>PC2</td>
				<td class=btext rowspan=2>PC1</td>
				<td class=btext rowspan=2>NC</td>
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
			<tr align=center >
				<td class=btext >PC4</td>
				<td class=btext >PC3</td>
				<td class=btext >PC2</td>
				<td class=btext >PC1</td>
				<td class=btext >NC</td>
				<td class=btext >PC4</td>
				<td class=btext >PC3</td>
				<td class=btext >PC2</td>
				<td class=btext >PC1</td>
				<td class=btext >NC</td>
				<td class=btext >PC4</td>
				<td class=btext >PC3</td>
				<td class=btext >PC2</td>
				<td class=btext >PC1</td>
				<td class=btext >NC</td>
				<td class=btext >PC4</td>
				<td class=btext >PC3</td>
				<td class=btext >PC2</td>
				<td class=btext >PC1</td>
				<td class=btext >NC</td>
			</tr>
			<%
			int styleCount = 0;
			String style = "";
			String schemes = "'01','02','03','10'";
			Statement stmt1 = null;
			ResultSet rs1 = null;
			int slno = 0;
			try{
				int tot_works=0,tot_targetWorks=0,tot_compWorks=0;
				int tot_sanPC4Habs=0,tot_sanPC3Habs=0,tot_sanPC2Habs=0,tot_sanPC1Habs=0,tot_sanNCHabs=0,tot_sanFCHabs=0,tot_sanQAHabs=0,tot_sanHabs=0;
				int tot_tarCMPC4Habs=0,tot_tarCMPC3Habs=0,tot_tarCMPC2Habs=0,tot_tarCMPC1Habs=0,tot_tarCMNCHabs=0,tot_tarCMFCHabs=0,tot_tarCMQAHabs=0,tot_tarCMHabs=0;
				int tot_achCMPC4Habs=0,tot_achCMPC3Habs=0,tot_achCMPC2Habs=0,tot_achCMPC1Habs=0,tot_achCMNCHabs=0,tot_achCMFCHabs=0,tot_achCMQAHabs=0,tot_achCMHabs=0;
				int tot_tarUMPC4Habs=0,tot_tarUMPC3Habs=0,tot_tarUMPC2Habs=0,tot_tarUMPC1Habs=0,tot_tarUMNCHabs=0,tot_tarUMFCHabs=0,tot_tarUMQAHabs=0,tot_tarUMHabs=0;
				int tot_achUMPC4Habs=0,tot_achUMPC3Habs=0,tot_achUMPC2Habs=0,tot_achUMPC1Habs=0,tot_achUMNCHabs=0,tot_achUMFCHabs=0,tot_achUMQAHabs=0,tot_achUMHabs=0;
				Double tot_EstCost=0.0,tot_amountLFI=0.0,tot_amountBAL=0.0,tot_amountPhyCompNotFin=0.0,tot_expCMAmt=0.0,tot_expBMAmt=0.0;
				String programme = "";
				for (int i = 1; i <= programmeList.size(); i++){
					int works = 0,targetWorks=0,compWorks=0;
					int sanFCHabs=0,sanPC4Habs=0,sanPC3Habs=0,sanPC2Habs=0,sanPC1Habs=0,sanNCHabs=0,sanHabs=0,sanQAHabs=0;
					int tarCMFCHabs=0,tarCMPC4Habs=0,tarCMPC3Habs=0,tarCMPC2Habs=0,tarCMPC1Habs=0,tarCMNCHabs=0,tarCMHabs=0,tarCMQAHabs=0;
					int tarUMFCHabs=0,tarUMPC4Habs=0,tarUMPC3Habs=0,tarUMPC2Habs=0,tarUMPC1Habs=0,tarUMNCHabs=0,tarUMHabs=0,tarUMQAHabs=0;
					int achCMFCHabs=0,achCMPC4Habs=0,achCMPC3Habs=0,achCMPC2Habs=0,achCMPC1Habs=0,achCMNCHabs=0,achCMHabs=0,achCMQAHabs=0;
					int achUMFCHabs=0,achUMPC4Habs=0,achUMPC3Habs=0,achUMPC2Habs=0,achUMPC1Habs=0,achUMNCHabs=0,achUMHabs=0,achUMQAHabs=0;
					double EstCost=0.0,bankLastYear = 0.0,paoLastYear = 0.0,bankPhyCompNotFin=0.0,paoPhyCompNotFin=0.0;
					double bankCMAmt=0.0,paoCMAmt=0.0,expCMAmt=0.0,bankBMAmt=0.0,paoBMAmt=0.0,expBMAmt=0.0;
					programme = (String) programmeList.get(i);
				    String programmeName = "";
				    if (programme.length() > 2) {
				        programmeName = "NRDWP";
		           	} else {
		             	String programmeQuery = "select PROGRAMME_CODE,PROGRAMME_NAME from  rws_programme_tbl where PROGRAMME_CODE='"+ programme + "'";
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
					String worksQuery="select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_contractor_selection_tbl m "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and a.PROGRAMME_CODE=p.PROGRAMME_CODE and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y'";
					//System.out.println("worksrelatedSanQuery :- "+ worksQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(worksQuery);
					if (rs1.next()) {
						works=rs1.getInt(2);
						EstCost=rs1.getDouble(1);
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
	                            + "where WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
	                            + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and BANK_SEND_DATE<='31-MAR-" + yearStart + "' "
	                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(bankLFI);
                    if (rs1.next()) {
                        bankLastYear = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();
                    String paoLFI = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                            + "where WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                            + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and STATE_SEND_DATE<='31-MAR-" + yearStart + "' "
                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(paoLFI);
                    if (rs1.next()) {
                        paoLastYear = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();
                    Double amountLFI = bankLastYear + paoLastYear ;
                    Double amountBAL = (EstCost*100000)-(bankLastYear + paoLastYear);
                    String bankCM = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                            + "where WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                            + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and BANK_SEND_DATE>='01-"+currentMonth+"-" + cyear + "' "
                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
	                stmt1 = conn.createStatement();
	                rs1 = stmt1.executeQuery(bankCM);
	                if (rs1.next()) {
	                	bankCMAmt = rs1.getDouble(1);
	                }
	                stmt1.close();
	                rs1.close();
	                String paoCM = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
	                        + "where WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
	                        + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and STATE_SEND_DATE>='01-"+currentMonth+"-" + cyear + "' "
	                        + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
	                stmt1 = conn.createStatement();
	                rs1 = stmt1.executeQuery(paoCM);
	                if (rs1.next()) {
	                	paoCMAmt = rs1.getDouble(1);
	                }
	                stmt1.close();
	                rs1.close();
	                expCMAmt = bankCMAmt + paoCMAmt ;
	                String bankDY = "select sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
	    					+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
	    					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and BANK_SEND_DATE>='01-APR-" + yearStart + "'"
	    					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
	    					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id "
	    					+" and target_date_comp>='01-APR-" + yearStart + "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "')";
	                stmt1 = conn.createStatement();
	                rs1 = stmt1.executeQuery(bankDY);
	                if (rs1.next()) {
	                	bankBMAmt = rs1.getDouble(1);
	                }
	                stmt1.close();
	                rs1.close();
	                String paoDY = "select sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
	            			+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
	            			+ " and a.TYPE_OF_ASSET in (" + schemes + ") and STATE_SEND_DATE>='01-APR-" + yearStart + "'"
	            			+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
	            			+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id "
	            			+" and target_date_comp>='01-APR-" + yearStart + "' AND a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "')";
	                stmt1 = conn.createStatement();
	                rs1 = stmt1.executeQuery(paoDY);
	                if (rs1.next()) {
	                	paoBMAmt = rs1.getDouble(1);
	                }
	                stmt1.close();
	                rs1.close();
	                expBMAmt = bankBMAmt + paoBMAmt ;
                    String phyCompNotFinBank= "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
                    						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
					    					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and BANK_SEND_DATE>='01-APR-" + yearStart + "'"
					    					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
					    					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(phyCompNotFinBank);
                    if (rs1.next()) {
                        bankPhyCompNotFin = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();
                    String phyCompNotFinPAO ="select sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
            						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
			    					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and STATE_SEND_DATE>='01-APR-" + yearStart + "'"
			    					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
			    					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(phyCompNotFinPAO);
                    if (rs1.next()) {
                        paoPhyCompNotFin = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();
                  	Double amountPhyCompNotFin = (bankPhyCompNotFin + paoPhyCompNotFin) ;
                    String sanFCHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
										+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
										+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
										+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='FC'";
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
                    	sanFCHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	sanFCHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	sanFCHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}				
					//System.out.println("habsSanQuery :- "+ sanFCHabQry);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(sanFCHabQry);
					if (rs1.next()) {
						sanFCHabs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close(); 
					String sanPC4HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC4'";
					  if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
					    	sanPC4HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}	
	                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
	                    	sanPC4HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
	                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
	                    	sanPC4HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}	
					//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(sanPC4HabQry);
					if (rs1.next()) {
						sanPC4Habs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String sanPC3HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC3'";
					 if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
					    	sanPC3HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}	
	                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
	                    	sanPC3HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}
	                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
	                    	sanPC3HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
						}	
					//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(sanPC3HabQry);
					if (rs1.next()) {
						sanPC3Habs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String sanPC2HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC2'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						sanPC2HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	sanPC2HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	sanPC2HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
					//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(sanPC2HabQry);
					if (rs1.next()) {
						sanPC2Habs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String sanPC1HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC1'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						sanPC1HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	sanPC1HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	sanPC1HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
					//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(sanPC1HabQry);
					if (rs1.next()) {
						sanPC1Habs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String sanNCHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NC'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						sanNCHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	sanNCHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	sanNCHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
					//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(sanNCHabQry);
					if (rs1.next()) {
						sanNCHabs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String sanQAHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NSS'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						sanQAHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	sanQAHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	sanQAHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(sanQAHabQry);
					if (rs1.next()) {
						sanQAHabs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String sanHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS in ('FC','PC1','PC2','PC3','PC4','NC','NSS')";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						sanHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	sanHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	sanHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(sanHabQry);
					if (rs1.next()) {
						sanHabs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String targetworksQuery="select count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_contractor_selection_tbl m "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and a.PROGRAMME_CODE=p.PROGRAMME_CODE and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'"+cDate+"') and TARGET_DATE_COMP between '01-APR-"+yearStart+"' and "
							+" '31-MAR-"+yearEnd+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y'";
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(targetworksQuery);
					if (rs1.next()) {
						targetWorks=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String compworksQuery="select count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd "
							+"where  WORK_CANCEL_DT is null and h.work_id=a.work_id and hd.hab_code=h.hab_code and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and a.PROGRAMME_CODE=p.PROGRAMME_CODE and "
							+"a.work_id  in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION>='01-APR-"+yearStart+"') and TARGET_DATE_COMP >='01-APR-"+yearStart+"' and "
							+" ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y'";
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(compworksQuery);
					if (rs1.next()) {
						compWorks=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String tarCMFCHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-"+currentMonth+"-"+cyear+"' and TARGET_DATE_COMP<'01-"+nextMonth+"' and"
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='FC'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						tarCMFCHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	tarCMFCHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	tarCMFCHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ sanFCHabQry);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(tarCMFCHabQry);
					if (rs1.next()) {
						tarCMFCHabs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close(); 
					String tarCMPC4HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-"+currentMonth+"-"+cyear+"' and TARGET_DATE_COMP<'01-"+nextMonth+"' and"
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC4'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						tarCMPC4HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	tarCMPC4HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	tarCMPC4HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(tarCMPC4HabQry);
					if (rs1.next()) {
						tarCMPC4Habs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String tarCMPC3HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-"+currentMonth+"-"+cyear+"' and TARGET_DATE_COMP<'01-"+nextMonth+"' and"
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC3'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						tarCMPC3HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	tarCMPC3HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	tarCMPC3HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(tarCMPC3HabQry);
					if (rs1.next()) {
						tarCMPC3Habs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String tarCMPC2HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-"+currentMonth+"-"+cyear+"' and TARGET_DATE_COMP<'01-"+nextMonth+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC2'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						tarCMPC2HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	tarCMPC2HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	tarCMPC2HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(tarCMPC2HabQry);
					if (rs1.next()) {
						tarCMPC2Habs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String tarCMPC1HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-"+currentMonth+"-"+cyear+"' and TARGET_DATE_COMP<'01-"+nextMonth+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC1'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						tarCMPC1HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	tarCMPC1HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	tarCMPC1HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(tarCMPC1HabQry);
					if (rs1.next()) {
						tarCMPC1Habs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String tarCMNCHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-"+currentMonth+"-"+cyear+"' and TARGET_DATE_COMP<'01-"+nextMonth+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NC'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						tarCMNCHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	tarCMNCHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	tarCMNCHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(tarCMNCHabQry);
					if (rs1.next()) {
						tarCMNCHabs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String tarCMQAHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-"+currentMonth+"-"+cyear+"' and TARGET_DATE_COMP<'01-"+nextMonth+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NSS'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						tarCMQAHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	tarCMQAHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	tarCMQAHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(tarCMQAHabQry);
					if (rs1.next()) {
						tarCMQAHabs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String tarCMHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP>='01-"+currentMonth+"-"+cyear+"' and TARGET_DATE_COMP<'01-"+nextMonth+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS in ('FC','PC1','PC2','PC3','PC4','NC','NSS')";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						tarCMHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	tarCMHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	tarCMHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(tarCMHabQry);
					if (rs1.next()) {
						tarCMHabs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String tarUMFCHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP<'01-"+currentMonth+"-"+cyear+"' and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and"
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='FC'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						tarUMFCHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	tarUMFCHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	tarUMFCHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ sanFCHabQry);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(tarUMFCHabQry);
					if (rs1.next()) {
						tarUMFCHabs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close(); 
					String tarUMPC4HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP<'01-"+currentMonth+"-"+cyear+"' and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and"
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC4'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						tarUMPC4HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	tarUMPC4HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	tarUMPC4HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(tarUMPC4HabQry);
					if (rs1.next()) {
						tarUMPC4Habs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String tarUMPC3HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP<'01-"+currentMonth+"-"+cyear+"' and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and"
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC3'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						tarUMPC3HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	tarUMPC3HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	tarUMPC3HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(tarUMPC3HabQry);
					if (rs1.next()) {
						tarUMPC3Habs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String tarUMPC2HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP<'01-"+currentMonth+"-"+cyear+"' and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC2'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						tarUMPC2HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	tarUMPC2HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	tarUMPC2HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(tarUMPC2HabQry);
					if (rs1.next()) {
						tarUMPC2Habs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String tarUMPC1HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP<'01-"+currentMonth+"-"+cyear+"' and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC1'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						tarUMPC1HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	tarUMPC1HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	tarUMPC1HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(tarUMPC1HabQry);
					if (rs1.next()) {
						tarUMPC1Habs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String tarUMNCHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP<'01-"+currentMonth+"-"+cyear+"' and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NC'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						tarUMNCHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	tarUMNCHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	tarUMNCHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(tarUMNCHabQry);
					if (rs1.next()) {
						tarUMNCHabs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String tarUMQAHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP<'01-"+currentMonth+"-"+cyear+"' and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NSS'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						tarUMQAHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	tarUMQAHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	tarUMQAHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(tarUMQAHabQry);
					if (rs1.next()) {
						tarUMQAHabs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String tarUMHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and TARGET_DATE_COMP<'01-"+currentMonth+"-"+cyear+"' and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS in ('FC','PC1','PC2','PC3','PC4','NC','NSS')";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						tarUMHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	tarUMHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	tarUMHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(tarUMHabQry);
					if (rs1.next()) {
						tarUMHabs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String achCMFCHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-"+currentMonth+"-"+cyear+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-"+currentMonth+"-"+cyear+"' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='FC'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						achCMFCHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	achCMFCHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	achCMFCHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ sanFCHabQry);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(achCMFCHabQry);
					if (rs1.next()) {
						achCMFCHabs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close(); 
					String achCMPC4HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-"+currentMonth+"-"+cyear+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-"+currentMonth+"-"+cyear+"' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC4'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						achCMPC4HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	achCMPC4HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	achCMPC4HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(achCMPC4HabQry);
					if (rs1.next()) {
						achCMPC4Habs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String achCMPC3HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-"+currentMonth+"-"+cyear+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-"+currentMonth+"-"+cyear+"' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC3'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						achCMPC3HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	achCMPC3HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	achCMPC3HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(achCMPC3HabQry);
					if (rs1.next()) {
						achCMPC3Habs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String achCMPC2HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-"+currentMonth+"-"+cyear+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-"+currentMonth+"-"+cyear+"' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC2'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						achCMPC2HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	achCMPC2HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	achCMPC2HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(achCMPC2HabQry);
					if (rs1.next()) {
						achCMPC2Habs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String achCMPC1HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-"+currentMonth+"-"+cyear+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-"+currentMonth+"-"+cyear+"' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC1'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						achCMPC1HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	achCMPC1HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	achCMPC1HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(achCMPC1HabQry);
					if (rs1.next()) {
						achCMPC1Habs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String achCMNCHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-"+currentMonth+"-"+cyear+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-"+currentMonth+"-"+cyear+"' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NC'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						achCMNCHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	achCMNCHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	achCMNCHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(achCMNCHabQry);
					if (rs1.next()) {
						achCMNCHabs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String achCMQAHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-"+currentMonth+"-"+cyear+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-"+currentMonth+"-"+cyear+"' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NSS'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						achCMQAHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	achCMQAHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	achCMQAHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(achCMQAHabQry);
					if (rs1.next()) {
						achCMQAHabs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String achCMHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION>='01-"+currentMonth+"-"+cyear+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >='01-"+currentMonth+"-"+cyear+"' and DATE_OF_COMPLETION is null))) and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS in ('FC','PC1','PC2','PC3','PC4','NC','NSS')";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						achCMHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	achCMHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	achCMHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(achCMHabQry);
					if (rs1.next()) {
						achCMHabs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String achUMFCHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION<'01-"+currentMonth+"-"+cyear+"' and DATE_OF_COMPLETION>='01-APR-"+yearStart+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion<'01-"+currentMonth+"-"+cyear+"' and partial_date_of_completion>='01-APR-"+yearStart+"' and DATE_OF_COMPLETION is null))  ) and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='FC'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						achUMFCHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	achUMFCHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	achUMFCHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ sanFCHabQry);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(achUMFCHabQry);
					if (rs1.next()) {
						achUMFCHabs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close(); 
					String achUMPC4HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION<'01-"+currentMonth+"-"+cyear+"' and DATE_OF_COMPLETION>='01-APR-"+yearStart+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion<'01-"+currentMonth+"-"+cyear+"' and partial_date_of_completion>='01-APR-"+yearStart+"' and DATE_OF_COMPLETION is null)) ) and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC4'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						achUMPC4HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	achUMPC4HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	achUMPC4HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(achUMPC4HabQry);
					if (rs1.next()) {
						achUMPC4Habs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String achUMPC3HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION<'01-"+currentMonth+"-"+cyear+"' and DATE_OF_COMPLETION>='01-APR-"+yearStart+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion<'01-"+currentMonth+"-"+cyear+"' and partial_date_of_completion>='01-APR-"+yearStart+"' and DATE_OF_COMPLETION is null)) ) and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC3'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						achUMPC3HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	achUMPC3HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	achUMPC3HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(achUMPC3HabQry);
					if (rs1.next()) {
						achUMPC3Habs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String achUMPC2HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION<'01-"+currentMonth+"-"+cyear+"' and DATE_OF_COMPLETION>='01-APR-"+yearStart+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion<'01-"+currentMonth+"-"+cyear+"' and partial_date_of_completion>='01-APR-"+yearStart+"' and DATE_OF_COMPLETION is null)) ) and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC2'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						achUMPC2HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	achUMPC2HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	achUMPC2HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(achUMPC2HabQry);
					if (rs1.next()) {
						achUMPC2Habs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String achUMPC1HabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION<'01-"+currentMonth+"-"+cyear+"' and DATE_OF_COMPLETION>='01-APR-"+yearStart+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion<'01-"+currentMonth+"-"+cyear+"' and partial_date_of_completion>='01-APR-"+yearStart+"' and DATE_OF_COMPLETION is null)) ) and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='PC1'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						achUMPC1HabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	achUMPC1HabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	achUMPC1HabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(achUMPC1HabQry);
					if (rs1.next()) {
						achUMPC1Habs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String achUMNCHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION<'01-"+currentMonth+"-"+cyear+"' and DATE_OF_COMPLETION>='01-APR-"+yearStart+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion<'01-"+currentMonth+"-"+cyear+"' and partial_date_of_completion>='01-APR-"+yearStart+"' and DATE_OF_COMPLETION is null)) ) and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NC'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						achUMNCHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	achUMNCHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	achUMNCHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(achUMNCHabQry);
					if (rs1.next()) {
						achUMNCHabs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String achUMQAHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION<'01-"+currentMonth+"-"+cyear+"' and DATE_OF_COMPLETION>='01-APR-"+yearStart+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion<'01-"+currentMonth+"-"+cyear+"' and partial_date_of_completion>='01-APR-"+yearStart+"' and DATE_OF_COMPLETION is null)) ) and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS='NSS'";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						achUMQAHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	achUMQAHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	achUMQAHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(achUMQAHabQry);
					if (rs1.next()) {
						achUMQAHabs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					String achUMHabQry = "select count(distinct b.hab_code) from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_habitation_directory_tbl h "
							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and b.work_id=a.work_id and b.hab_code=h.hab_code and "
							+"a.work_id  in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION<'01-"+currentMonth+"-"+cyear+"' and DATE_OF_COMPLETION>='01-APR-"+yearStart+"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion<'01-"+currentMonth+"-"+cyear+"' and partial_date_of_completion>='01-APR-"+yearStart+"' and DATE_OF_COMPLETION is null)) ) and TARGET_DATE_COMP>='01-APR-"+yearStart+"' and "
							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS in ('FC','PC1','PC2','PC3','PC4','NC','NSS')";
					if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("SC")){
						achUMHabQry += " and (h.CENSUS_SC_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}	
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("ST")){
                    	achUMHabQry += " and (h.CENSUS_ST_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}
                    if(populationType != null && !populationType.equals("") && populationType.equalsIgnoreCase("PLAIN")){
                    	achUMHabQry += " and (h.CENSUS_PLAIN_POPU/ (case WHEN (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) > 0 then (h.CENSUS_MINORITY_POPU + h.CENSUS_PLAIN_POPU + h.CENSUS_SC_POPU + h.CENSUS_ST_POPU) else 1 end)*100) > 40.00";
					}//System.out.println("habsSanQuery :- "+ habsSanQuery);
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(achUMHabQry);
					if (rs1.next()) {
						achUMHabs=rs1.getInt(1);						
					}
					stmt1.close();
					rs1.close();
					tot_works+=works;
					tot_EstCost+=EstCost;
					tot_amountLFI+=amountLFI;
					tot_amountBAL+=amountBAL;
					tot_expCMAmt+=expCMAmt;
					tot_expBMAmt+=expBMAmt;
					tot_amountPhyCompNotFin+=amountPhyCompNotFin;
					tot_sanFCHabs+=sanFCHabs;
					tot_sanPC4Habs+=sanPC4Habs;
					tot_sanPC3Habs+=sanPC3Habs;
					tot_sanPC2Habs+=sanPC2Habs;
					tot_sanPC1Habs+=sanPC1Habs;
					tot_sanNCHabs+=sanNCHabs;
					tot_sanQAHabs+=sanQAHabs;
					tot_sanHabs+=sanHabs;
					tot_tarCMFCHabs+=tarCMFCHabs;
					tot_tarCMPC4Habs+=tarCMPC4Habs;
					tot_tarCMPC3Habs+=tarCMPC3Habs;
					tot_tarCMPC2Habs+=tarCMPC2Habs;
					tot_tarCMPC1Habs+=tarCMPC1Habs;
					tot_tarCMNCHabs+=tarCMNCHabs;
					tot_tarCMQAHabs+=tarCMQAHabs;
					tot_tarCMHabs+=tarCMHabs;
					tot_tarUMFCHabs+=tarUMFCHabs;
					tot_tarUMPC4Habs+=tarUMPC4Habs;
					tot_tarUMPC3Habs+=tarUMPC3Habs;
					tot_tarUMPC2Habs+=tarUMPC2Habs;
					tot_tarUMPC1Habs+=tarUMPC1Habs;
					tot_tarUMNCHabs+=tarUMNCHabs;
					tot_tarUMQAHabs+=tarUMQAHabs;
					tot_tarUMHabs+=tarUMHabs;
					tot_achCMFCHabs+=achCMFCHabs;
					tot_achCMPC4Habs+=achCMPC4Habs;
					tot_achCMPC3Habs+=achCMPC3Habs;
					tot_achCMPC2Habs+=achCMPC2Habs;
					tot_achCMPC1Habs+=achCMPC1Habs;
					tot_achCMNCHabs+=achCMNCHabs;
					tot_achCMQAHabs+=achCMQAHabs;
					tot_achCMHabs+=achCMHabs;
					tot_achUMFCHabs+=achUMFCHabs;
					tot_achUMPC4Habs+=achUMPC4Habs;
					tot_achUMPC3Habs+=achUMPC3Habs;
					tot_achUMPC2Habs+=achUMPC2Habs;
					tot_achUMPC1Habs+=achUMPC1Habs;
					tot_achUMNCHabs+=achUMNCHabs;
					tot_achUMQAHabs+=achUMQAHabs;
					tot_achUMHabs+=achUMHabs;
					tot_targetWorks+=targetWorks;
					tot_compWorks+=compWorks;
					 if(works == 0&&targetWorks==0&&compWorks==0&&
						sanFCHabs==0&&sanPC4Habs==0&&sanPC3Habs==0&&sanPC2Habs==0&&sanPC1Habs==0&&sanNCHabs==0&&sanHabs==0&&sanQAHabs==0&&
						tarCMFCHabs==0&&tarCMPC4Habs==0&&tarCMPC3Habs==0&&tarCMPC2Habs==0&&tarCMPC1Habs==0&&tarCMNCHabs==0&&tarCMHabs==0&&tarCMQAHabs==0&&
						tarUMFCHabs==0&&tarUMPC4Habs==0&&tarUMPC3Habs==0&&tarUMPC2Habs==0&&tarUMPC1Habs==0&&tarUMNCHabs==0&&tarUMHabs==0&&tarUMQAHabs==0&&
						achCMFCHabs==0&&achCMPC4Habs==0&&achCMPC3Habs==0&&achCMPC2Habs==0&&achCMPC1Habs==0&&achCMNCHabs==0&&achCMHabs==0&&achCMQAHabs==0&&
						achUMFCHabs==0&&achUMPC4Habs==0&&achUMPC3Habs==0&&achUMPC2Habs==0&&achUMPC1Habs==0&&achUMNCHabs==0&&achUMHabs==0&&achUMQAHabs==0&&
						EstCost==0.0&&bankLastYear == 0.0&&paoLastYear == 0.0&&bankPhyCompNotFin==0.0&&paoPhyCompNotFin==0.0&&
						bankCMAmt==0.0&&paoCMAmt==0.0&&expCMAmt==0.0&&bankBMAmt==0.0&&paoBMAmt==0.0&&expBMAmt==0.0){
					}else{ 
							%>
					<tr>
						<td class="<%=style%>" style="text-align: right;" align="right"><%=++slno%></td>
						<td class="<%=style%>" style="text-align: left;" align="left"><a href="./rws_work_key_per_div_subdiv_rpt.jsp?mode=circles&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>"><%=programmeName%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=total&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=works %></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(EstCost)%></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(amountLFI/100000) %></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(amountBAL/100000) %></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(expCMAmt/100000) %></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(expBMAmt/100000)%></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(amountPhyCompNotFin/100000) %></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanFC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=sanFCHabs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanPC4&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=sanPC4Habs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanPC3&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=sanPC3Habs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanPC2&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=sanPC2Habs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanPC1&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=sanPC1Habs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanNC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=sanNCHabs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=sanQA&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=sanQAHabs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=san&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=sanHabs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=targeted&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=targetWorks%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=completed&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=compWorks%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=tarCMFC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=tarCMFCHabs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=tarCMPC4&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=tarCMPC4Habs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=tarCMPC3&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=tarCMPC3Habs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=tarCMPC2&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=tarCMPC2Habs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=tarCMPC1&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=tarCMPC1Habs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=tarCMNC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=tarCMNCHabs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=tarCMQA&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=tarCMQAHabs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=tarCM&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=tarCMHabs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=tarUMFC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=tarUMFCHabs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=tarUMPC4&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=tarUMPC4Habs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=tarUMPC3&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=tarUMPC3Habs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=tarUMPC2&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=tarUMPC2Habs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=tarUMPC1&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=tarUMPC1Habs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=tarUMNC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=tarUMNCHabs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=tarUMQA&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=tarUMQAHabs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=tarUM&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=tarUMHabs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=achCMFC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=achCMFCHabs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=achCMPC4&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=achCMPC4Habs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=achCMPC3&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=achCMPC3Habs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=achCMPC2&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=achCMPC2Habs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=achCMPC1&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=achCMPC1Habs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=achCMNC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=achCMNCHabs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=achCMQA&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=achCMQAHabs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=achCM&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=achCMHabs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=achUMFC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=achUMFCHabs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=achUMPC4&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=achUMPC4Habs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=achUMPC3&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=achUMPC3Habs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=achUMPC2&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=achUMPC2Habs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=achUMPC1&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=achUMPC1Habs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=achUMNC&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=achUMNCHabs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=achUMQA&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=achUMQAHabs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=achUM&programme=<%=programme%>&programmeName=<%=programmeName%>&populationType=<%=populationType%>')"><%=achUMHabs%></a></td>
					</tr>						
					<%}
				}%>
				<tr>
						<td class="btext" style="text-align: right;" colspan="2">Total </td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_works%></td>
						<td class="btext" style="text-align: right;" align="right"><%=ndf.format(tot_EstCost)%></td>
						<td class="btext" style="text-align: right;" align="right"><%=ndf.format(tot_amountLFI/100000)%></td>
						<td class="btext" style="text-align: right;" align="right"><%=ndf.format(tot_amountBAL/100000)%></td>
						<td class="btext" style="text-align: right;" align="right"><%=ndf.format(tot_expCMAmt/100000)%></td>
						<td class="btext" style="text-align: right;" align="right"><%=ndf.format(tot_expBMAmt/100000)%></td>
						<td class="btext" style="text-align: right;" align="right"><%=ndf.format(tot_amountPhyCompNotFin/100000)%></td>
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
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarCMFCHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarCMPC4Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarCMPC3Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarCMPC2Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarCMPC1Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarCMNCHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarCMQAHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarCMHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarUMFCHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarUMPC4Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarUMPC3Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarUMPC2Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarUMPC1Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarUMNCHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarUMQAHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_tarUMHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_achCMFCHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_achCMPC4Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_achCMPC3Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_achCMPC2Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_achCMPC1Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_achCMNCHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_achCMQAHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_achCMHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_achUMFCHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_achUMPC4Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_achUMPC3Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_achUMPC2Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_achUMPC1Habs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_achUMNCHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_achUMQAHabs%></td>
						<td class="btext" style="text-align: right;" align="right"><%=tot_achUMHabs%></td>
				</tr>
		<%
		}catch (Exception e) {
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
		<br/>
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
		