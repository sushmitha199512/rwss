<%@ include file="/reports/conn.jsp"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.util.*"%>
<%@page import="nic.watersoft.works.WorksData1"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%
DecimalFormat ndf = new DecimalFormat("####.00");
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
String y="";
if(request.getParameter("finyear")!=null){
	y=request.getParameter("finyear");
yearStart = Integer.parseInt(y.substring(0,4));
yearEnd = yearStart + 1;
}
else{
	if (month <= 3) {
        yearStart = cyear - 1;
        yearEnd = cyear;
    } else {
        yearStart = cyear;
        yearEnd = cyear + 1;
    }
}
Statement statement = null;
ResultSet resultSet = null;
HashMap programmeList = new HashMap();
int count=1;
String progCode = "";
/* String nrdwpQuery = "select PROGRAMME_CODE from  rws_programme_tbl where NRDWP_RELATED='Y' order by 1";
Statement statement = conn.createStatement();
ResultSet resultSet = statement.executeQuery(nrdwpQuery);
while (resultSet.next()) {
	if (!progCode.equals("")) {
		progCode = progCode + "," + resultSet.getString(1);
	} else {
		progCode = resultSet.getString(1);
	}
}
programmeList.put(count, progCode);
resultSet.close();
statement.close();

String CmDBQuery = "select PROGRAMME_CODE from  rws_programme_tbl where CM_CORE_DB='Y' and NRDWP_RELATED='N' order by programme_name";
Statement stmtCmDB = conn.createStatement();
ResultSet rsCmDB = stmtCmDB.executeQuery(CmDBQuery);
while (rsCmDB.next()) {
	count=count+1;
	programmeList.put(count,rsCmDB.getString(1));
	
} */
String CmDBQuery = "select PROGRAMME_CODE from  rws_programme_tbl where CENTRE_STATE_DISTRICT='D' order by programme_name";
Statement stmtCmDB = conn.createStatement();
ResultSet rsCmDB = stmtCmDB.executeQuery(CmDBQuery);
while (rsCmDB.next()) {
	
	programmeList.put(count,rsCmDB.getString(1));
	count=count+1;
	
}
stmtCmDB.close();
rsCmDB.close();
//System.out.println("programmeList"+programmeList);
//programmeList.put(count, progCode);
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
        border: 1px solid #000000 !important;
        font-family: "Maiandra GD", Georgia, Serif !important;
        font-size: 12px !important;
    }
    .rightPad td {
        padding-right: 3px !important;
    }
</style>
<body>
<form name=f1 method="post">
      <br />
		<br />
		<center>
			<font color="#663899" face="Maiandra GD" size="4px"><b>Abstract Progress Report <%=yearStart%>-<%=yearEnd%></b></font><br/>
		</center>
		<br/><br/>
		
		<br/>
		<table align="center"
			style="margin-top: -45px !important; width: 1050px !important;">
			<tr>
				<td style="width: 1000px !important; text-align: right !important;"><font
					color="#889900" face="Maiandra GD" size="2px">Rs. In Lakhs</font></td>
			</tr>
		</table>
		
		<center>
		 <font color="#663899" face="Maiandra GD" size="4px"><b>Select
				Financial Year:<font color="red">*</font> <SELECT name="finyear" id="finyear"
				style="width: 140px" onchange="this.form.submit()">
					<%
						try{
							String finYear=request.getParameter("finyear");
							String temp="";
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
     <br>
     <br>
		
		
	       	<table border=1 cellspacing=0 cellpadding=0 height=5% width="1050px"
			bordercolor=#000000
			style="border-collapse: collapse; margin-top: 20px !important;"
			bgcolor="#ffffff" align="center">
					<tr align=center align=center>
						<td class="btext" rowspan=2>Sl.No</td>
						<td class="btext" rowspan=2>Programme(District)</td>
						<td colspan=3 class="btext" align="center">Total Ongoing works in <%=yearStart%>-<%=yearEnd%></td>
						<!-- <td colspan=2 class="btext" align="center">Financial Pending</td>
						<td class="btext" rowspan=2>Total Commitment</td> -->
						<%-- <td colspan=4 class="btext" align="center">Target (<%=yearStart%>-<%=yearEnd%>)</td> --%>
						<td colspan=3 class="btext" align="center">Achievements during <%=yearStart%>-<%=yearEnd%></td>
					</tr>
					<tr>
						<td colspan=1 class="btext" align="center">No of Works</td>
						<td colspan=1 class="btext" align="center">Habs </td>
						<!-- <td colspan=1 class="btext" align="center">Population</td> -->
						<td colspan=1 class="btext" align="center">Cost</td>
						<!-- <td colspan=1 class="btext" align="center">Works</td>
						<td colspan=1 class="btext" align="center">Amount</td> -->
						<!-- <td colspan=1 class="btext" align="center">No of Works</td>
						<td colspan=1 class="btext" align="center">Habs </td>
						<td colspan=1 class="btext" align="center">Population</td>
						<td colspan=1 class="btext" align="center">Bal. Est. Cost</td> -->
						
						<td colspan=1 class="btext" align="center">No of Works</td>
						<td colspan=1 class="btext" align="center">Habs </td>
						<!-- <td colspan=1 class="btext" align="center">Population</td> -->
						<td colspan=1 class="btext" align="center">Exp. <!-- of Progress works --></td>
						<!-- <td colspan=1 class="btext" align="center">Exp. of Pending works</td>
						<td colspan=1 class="btext" align="center">Total Exp.</td> -->
					</tr>
					<%
					int styleCount = 0;
					String style = "";
					int slno=0;	
					String ach_qry="",ach_hab_query="",ach_banksendQuery="",ach_bankpaos="";
					String query="",hab_query="";
					Statement stmt1=null,stmt2=null;
					ResultSet rs1=null,rs2=null;
					Double sanction_amount=0.0,tot_sanction_amount=0.0,ach_amount=0.0,exp=0.0,tot_exp=0.0;
					int no_works=0,tot_no_works=0,habs=0,tot_habs=0,ach_works=0,tot_ach_works=0,ach_habs=0,tot_ach_habs=0;
					try{			
					String programme = "";
					String schemes = "'01','02','03','10'";
					for (int i = 1; i <= programmeList.size(); i++){
						String programmeName = "";
						 programme = (String) programmeList.get(i);
					   
						 /*if (programme.length() > 2) {
					        programmeName = "NRDWP";
			           	} else {*/
			             	String programmeQuery = "select PROGRAMME_CODE,PROGRAMME_NAME from  rws_programme_tbl where PROGRAMME_CODE='"+ programme + "'";
			           		//System.out.println(programmeQuery+"   programme");
			           		Statement statement1 = conn.createStatement();
			             	ResultSet resultSet1 = statement1.executeQuery(programmeQuery);
			             	if (resultSet1.next()) {
			             		programmeName = resultSet1.getString("PROGRAMME_NAME");
			             	}			             	
			             	resultSet1.close();
			             	statement1.close();
			             	/* }  */			             	
			                if (styleCount % 2 == 0) {
						        style = "gridbg1";
							} else {
								style = "gridbg2";
							}
							styleCount++;
							 
					query = "select sum(a.SANCTION_AMOUNT) as SANCTION_AMOUNT,count(distinct a.work_id) as works from rws_work_admn_tbl a,rws_programme_tbl p where WORK_CANCEL_DT is null "
							+ " and substr(a.work_id,7,2)  in (" + schemes + ") "
							+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
							+ programme
							+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<='31-MAR-"+yearStart+"')";
					//System.out.println("query"+query);	
					stmt1 = conn.createStatement();
					rs1 = stmt1.executeQuery(query);
					if(rs1.next())
					{
					  sanction_amount=rs1.getDouble("SANCTION_AMOUNT");
					  no_works=rs1.getInt("works");
				   	}
					tot_no_works+=no_works;
					tot_sanction_amount+=sanction_amount;
					
					rs1.close();
					stmt1.close();
				    hab_query = "select count(Distinct hab.hab_code) as habs,sum(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) as pop from rws_work_admn_tbl a,rws_programme_tbl p,RWS_ADMN_HAB_LNK_TBL hab,rws_habitation_directory_tbl h where WORK_CANCEL_DT is null "
							+ " and substr(a.work_id,7,2) in (" + schemes + ") " 
							+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
							+ programme
							+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<='31-MAR-"+yearStart+"') and hab.work_id=a.work_id and  hab.hab_code=h.hab_code and COVERAGE_STATUS<>'UI'";
				    //System.out.println("hab_query"+hab_query)	;	
					stmt2 = conn.createStatement();
					rs2 = stmt2.executeQuery(hab_query);
					if(rs2.next()){
						habs=rs2.getInt("habs");
						//pop=rs2.getInt("pop");
					}
					tot_habs+=habs;
					//tot_pop+=pop;
					rs2.close();
					stmt2.close();
					/* banksendQuery= "select sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
							+ " and substr(a.work_id,7,2) in (" + schemes + ") and BANK_SEND_DATE<='"+cDate+"'"
							+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
							+ programme
							+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";
					//System.out.println("banksendQuery"+banksendQuery)	;	
					stmt2 = conn.createStatement();
					rs2 = stmt2.executeQuery(banksendQuery);
					while(rs2.next()){
						banksendAmount=rs2.getDouble("BILL_AMOUNT_CENTRAL");
					}
					rs2.close();
					stmt2.close();
					bankpaos= "select sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
							+ " and substr(a.work_id,7,2)  in (" + schemes + ") and STATE_SEND_DATE<='"+cDate+"'"
							+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
							+ programme 
							+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";		
					//System.out.println("bankpaos"+bankpaos)	;	
					stmt2 = conn.createStatement();
					rs2 = stmt2.executeQuery(bankpaos);
					if(rs2.next()){
						bankpaoAmt=rs2.getDouble("BILL_AMOUT_STATE");
					}
					rs2.close();
					stmt2.close();
					finalBal=(sanction_amount*100000)-(banksendAmount + bankpaoAmt);
					tot_fin_amount+=finalBal; */
					
					
				ach_qry="select count(distinct a.work_id) as works,sum(a.sanction_amount) as sanction_amount from  Rws_Work_Completion_Tbl comp,rws_work_admn_tbl a,rws_programme_tbl p where WORK_CANCEL_DT is null "
						+ " and substr(a.work_id,7,2) in (" + schemes + ") " 
						+" and comp.work_id=a.work_id  and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
						+ programme
						+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION >= '01-APR-"+yearStart+"' and DATE_OF_COMPLETION is not null) ";
			//System.out.println("ach_qry"+ach_qry);	
			stmt2 = conn.createStatement();
			rs2 = stmt2.executeQuery(ach_qry);
			if(rs2.next()){
			ach_works=rs2.getInt("works");
			ach_amount=rs2.getDouble("sanction_amount");
			}
			tot_ach_works+=ach_works;
			rs2.close();
			stmt2.close();
			ach_hab_query = "select count(Distinct hab.hab_code) as habs,sum(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) as pop from rws_work_admn_tbl a,rws_programme_tbl p,RWS_WORK_COMP_HAB_LNK_TBL hab,rws_habitation_directory_tbl h where WORK_CANCEL_DT is null "
					+ " and substr(a.work_id,7,2) in (" + schemes + ") " 
					+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
					+ programme
					+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP >='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id in(select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION >= '01-APR-" + yearStart +"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >= '01-APR-" + yearStart +"' and DATE_OF_COMPLETION is null))) and hab.work_id=a.work_id and  hab.hab_code=h.hab_code and COVERAGE_STATUS<>'UI'";
					
			//System.out.println("ach_hab_query"+ach_hab_query)	;	
			stmt2 = conn.createStatement();
			rs2 = stmt2.executeQuery(ach_hab_query);
			if(rs2.next()){
				ach_habs=rs2.getInt("habs");
				//ach_pop=rs2.getInt("pop");
			}
			tot_ach_habs+=ach_habs;
			//ach_tot_pop+=ach_pop;
			rs2.close();
			stmt2.close();
			Double Progress_central=0.0,Progress_state=0.0;
			String progressqry= "select sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p where WORK_CANCEL_DT is null "
							+ " and substr(a.work_id,7,2) in (" + schemes + ") " 		
							+ " and BANK_SEND_DATE>='01-APR-" + yearStart + "'"
	    					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
	    					+ " b.work_id=a.work_id and target_date_comp>='01-APR-" + yearStart + "'";
	    					/*   and a.work_id in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>='01-APR-" + yearStart + "')"; */
	    					
	    					/* "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                    + "where WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                    + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and BANK_SEND_DATE >'31-MAR-" + yearStart + "' and BANK_SEND_DATE<='" + cDate + "' "
                    + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'"; */
			//System.out.println("progressqry"+progressqry);	
			stmt2 = conn.createStatement();
			rs2 = stmt2.executeQuery(progressqry);
			while(rs2.next()){
				Progress_central=rs2.getDouble(1);
			}
			rs2.close();
			stmt2.close();
			String Prog_state_qry= "select sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
					+ " rws_programme_tbl p where WORK_CANCEL_DT is null "
					+ " and substr(a.work_id,7,2) in (" + schemes + ") " 
					+ " and STATE_SEND_DATE>='01-APR-" + yearStart + "'"
					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
					+ " b.work_id=a.work_id "
					+" and target_date_comp>='01-APR-" + yearStart + "' ";
					/* AND a.work_id  in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION>='01-APR-" + yearStart + "') */
				/* 	
					"select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                    + "where WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                    + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and STATE_SEND_DATE >'31-MAR-" + yearStart + "' and STATE_SEND_DATE<='"+cDate+ "' "
                    + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'"; */		
			//System.out.println("Prog_state_qry"+Prog_state_qry);	
			stmt2 = conn.createStatement();
			rs2 = stmt2.executeQuery(Prog_state_qry);
			if(rs2.next()){
				Progress_state=rs2.getDouble(1);
			}
			rs2.close();
			stmt2.close();
			exp =(Progress_state + Progress_central);
			tot_exp += exp;
			
			
			
			/* ach_banksendQuery= "select sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
					+ " and substr(a.work_id,7,2) in (" + schemes + ") and BANK_SEND_DATE<='"+cDate+"'"
					+ " and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null"
					+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
					+ programme
					+ ") and a.work_id  in(select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '"+cDate+"') and DATE_OF_COMPLETION is not null and to_date(DT_FIN_COMPLETION) < '"+cDate+"' and DT_FIN_COMPLETION is not null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and b.work_id=a.work_id ";
			//System.out.println("fin_banksendQuery"+fin_banksendQuery);	
			stmt2 = conn.createStatement();
			rs2 = stmt2.executeQuery(banksendQuery);
			while(rs2.next()){
				ach_banksendAmount=rs2.getDouble("BILL_AMOUNT_CENTRAL");
			}
			rs2.close();
			stmt2.close();
			ach_bankpaos= "select sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
					+ " and substr(a.work_id,7,2)  in (" + schemes + ") and STATE_SEND_DATE<='"+cDate+"'"
					+ " and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and a.ADMIN_DATE<to_date('01/04/"+yearStart+"','dd/mm/yyyy') and c.GROUNDING_DATE is not null"
					+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
					+ programme 
					+ ") and a.work_id in(select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '"+cDate+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and b.work_id=a.work_id ";		
			 //System.out.println("fin_bankpaos"+fin_bankpaos);	
			stmt2 = conn.createStatement();
			rs2 = stmt2.executeQuery(bankpaos);
			if(rs2.next()){
				ach_bankpaoAmt=rs2.getDouble("BILL_AMOUT_STATE");
			}
			rs2.close();
			stmt2.close();
			ach_finalBal=(ach_amount*100000)-(ach_banksendAmount+ach_bankpaoAmt);
			tot_ach_finalBal+=ach_finalBal; */
			if(sanction_amount==0.0&&ach_amount==0.0&&
			no_works==0&&habs==0&&exp==0.0&&	
			ach_works==0&&ach_habs==0){
				
			}else{
					%>
					<tr>
						<td class="<%=style%>" style="text-align: right;" align="right"><%=++slno%></td>
						<td class="<%=style%>" style="text-align: left;" align="left"><%-- <a href="./rws_work_progress_div_subdiv_rpt.jsp?mode=circles&programme=<%=programme%>&programmeName=<%=programmeName%>"> --%><%=programmeName%></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_district_drill.jsp?mode=ongoing&programme=<%=programme%>&programmeName=<%=programmeName%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=no_works%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><%-- <a href="#" onclick="viewWorks('./rws_work_progress_district_drill.jsp?mode=ongoing&programme=<%=programme%>&programmeName=<%=programmeName%>')"> --%><%=habs%></td>
						<%-- <td class="<%=style%>" style="text-align: right;" align="right"><%=pop%></td> --%>
						<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(sanction_amount)%></td>	
						<%-- <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=financial&programme=<%=programme%>&programmeName=<%=programmeName%>')"><%=fin_works%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(not_finalBal/100000) %> </td>
						<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format((finalBal+not_finalBal)/100000) %></td>	
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=target&programme=<%=programme%>&programmeName=<%=programmeName%>')"><%=target_no_works%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=target&programme=<%=programme%>&programmeName=<%=programmeName%>')"><%=target_habs%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><%=target_pop%></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(target_finalBal/100000)%></td> --%>
						<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_district_drill.jsp?mode=achieve&programme=<%=programme%>&programmeName=<%=programmeName%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=ach_works%></a></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><%-- <a href="#" onclick="viewWorks('./rws_work_progress_district_drill.jsp?mode=achieve&programme=<%=programme%>&programmeName=<%=programmeName%>')"> --%><%=ach_habs%></td>
						<%-- <td class="<%=style%>" style="text-align: right;" align="right"><%=ach_pop%></td> --%>
						<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(exp/100000)%></td>
						<%-- <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(ach_fin_not_comp_exp/100000)%></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format((ach_fin_not_comp_exp+target_exp)/100000)%></td> --%>
						
					<%
			}
					}%>
					</tr>
					<tr >
					<td class="btext" style="text-align: right;" colspan="2">Total </td>
					<td class="btext" style="text-align: right;" align="right"><%=tot_no_works %> </td>
					<td class="btext" style="text-align: right;" ><%=tot_habs%> </td>
					<%-- <td class="btext" style="text-align: right;" ><%=tot_pop %> </td> --%>
					<td class="btext" style="text-align: right;" ><%=ndf.format(tot_sanction_amount)%> </td>
				<%-- 	<td class="btext" style="text-align: right;" align="right"><%=tot_fin_works%></a> </td>
					<td class="btext" style="text-align: right;" ><%=ndf.format(tot_not_finalBal/100000) %> </td>
					<td class="btext" style="text-align: right;" ><%=ndf.format((tot_fin_amount+tot_not_finalBal)/100000)%> </td>
					<td class="btext" style="text-align: right;" align="right"><%=target_tot_no_works %> </td>
					<td class="btext" style="text-align: right;" ><%=target_tot_habs%> </td>
					<td class="btext" style="text-align: right;" ><%=target_tot_pop %> </td>
					<td class="btext" style="text-align: right;" ><%=ndf.format(target_tot_fin_amount/100000)%> </td> --%>
					<td class="btext" style="text-align: right;" align="right"><%=tot_ach_works %> </td>
					<td class="btext" style="text-align: right;" ><%=tot_ach_habs%> </td>
					<%-- <td class="btext" style="text-align: right;" ><%=ach_tot_pop %> </td> --%>
					<td class="btext" style="text-align: right;" ><%=ndf.format(tot_exp/100000)%></td>
					<%-- <td class="btext" style="text-align: right;" ><%=ndf.format( total_ach_fin_not_comp_exp/100000) %></td>
					<td class="btext" style="text-align: right;" ><%=ndf.format((tot_target_exp+total_ach_fin_not_comp_exp)/100000)%></td> --%>
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
		  <br/>
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
</form>			
</body>