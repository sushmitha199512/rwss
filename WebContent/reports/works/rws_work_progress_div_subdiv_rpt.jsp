<%@ include file="/reports/conn.jsp"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.util.*"%>
<%@page import="nic.watersoft.works.WorksData1"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%
DecimalFormat ndf = new DecimalFormat("####.00");
String coc = request.getParameter("coc");
String con = request.getParameter("con");
String doc = request.getParameter("doc");
String don = request.getParameter("don");
String mode = "";
if (request.getParameter("mode") != null)
	mode = request.getParameter("mode");
//System.out.println("mode"+mode);
String programme = request.getParameter("programme");
String programmeName=request.getParameter("programmeName");
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
if (month <= 3) {
	yearStart = cyear - 1;
	yearEnd = cyear;
} else {
	yearStart = cyear;
	yearEnd = cyear + 1;
}
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
			<font color="#663899" face="Maiandra GD" size="4px"><b>Progress Report <%=yearStart%>-<%=yearEnd%></b></font><br/><br/><br/><font color="#889900" face="Maiandra GD" size="3px"  > Programme :- <%=programmeName %>
						<%if(mode.equals("divisions")){ %>
						 , Circle :- <%=request.getParameter("cname") %>
						<%}else if(mode.equals("subdivisions")){  %>
						, Circle :- <%=request.getParameter("cname") %>
						 , Division :- <%=request.getParameter("divname") %>
						<%} %>
		</center>
		<br/><br/><br/>
		<table align="center"
			style="margin-top: -45px !important; width: 1050px !important;">
			<tr>
				<td style="width: 1000px !important; text-align: right !important;"><font
					color="#889900" face="Maiandra GD" size="2px">Rs. In Lakhs</font></td>
				<td style="width: 100px !important;" align="right"><a
				href="javascript:history.back(-1)"><img	src="/pred/resources/graphs/go_back.gif" height="30px" /></a>&nbsp;&nbsp;
				</td>
			</tr>
		</table>
<br/></br>
		<table border=1 cellspacing=0 cellpadding=0 height=5% width="70%" bordercolor=#000000 style="border-collapse: collapse" bgcolor="#ffffff" align="center">
				<tr align=center align=center>
					<td class=btext rowspan=2>Sl.No</td>
					<%if(mode.equals("circles")){ %>
						<td class=btext rowspan=2>Circle</td>
						<%}else if(mode.equals("divisions")){ %>
						<td class=btext rowspan=2>Division</td>
						<%}else if(mode.equals("subdivisions")){ %>
						<td class=btext rowspan=2>Sub Division</td>
						<%} %>
					<td colspan=4 class=btext align="center">Total Ongoing works in<br><%=yearStart%>-<%=yearEnd%></td>
					<td colspan=2 class=btext align="center">Financial Pending</td>
					<td class=btext rowspan=2>Total Commitment</td>
					<td colspan=4 class=btext align="center">Target <%=yearStart%>-<%=yearEnd%></td>
					<td colspan=6 class=btext align="center">Achievements during <%=yearStart%>-<%=yearEnd%></td>
				</tr>
				<tr>
					<td colspan=1 class=btext align="center">No of Works</td>
					<td colspan=1 class=btext align="center">Habs </td>
					<td colspan=1 class=btext align="center">Population</td>
					<td colspan=1 class=btext align="center">Cost</td>
					<td colspan=1 class=btext align="center">Works</td>
					<td colspan=1 class=btext align="center">Amount</td>
					<td colspan=1 class=btext align="center">No of Works</td>
					<td colspan=1 class=btext align="center">Habs </td>
					<td colspan=1 class=btext align="center">Population</td>
					<td colspan=1 class=btext align="center">Cost</td>
					<td colspan=1 class=btext align="center">No of Works</td>
					<td colspan=1 class=btext align="center">Habs </td>
					<td colspan=1 class=btext align="center">Population</td>
					<td colspan=1 class=btext align="center">Exp. of Progress works</td>
					<td colspan=1 class=btext align="center">Exp. of Pending works</td>
					<td colspan=1 class=btext align="center">Total Exp.</td>
				</tr>
				<%
				String schemes = "'01','02','03','10'";
				int styleCount = 0;
				String style = "";
				int slno=0;	
				String ach_qry="",ach_hab_query="",ach_banksendQuery="",ach_bankpaos="";
				String query="",hab_query="",ach_fin_not_comp_central_qry="",ach_fin_not_comp_state_qry="",banksendQuery="",bankpaos="",query_target="",target_hab_query="",Financial_qry="",fin_banksendQuery="",fin_bankpaos="",target_banksendQuery="",target_bankpaos="";
				Statement stmt1=null,stmt2=null;
				ResultSet rs1=null,rs2=null;
				Double sanction_amount=0.0,finalBal=0.0,ach_amount=0.0,ach_finalBal=0.0,ach_fin_not_comp_central=0.0,ach_fin_not_comp_state=0.0,ach_fin_not_comp_exp=0.0,total_ach_fin_not_comp_exp=0.0;
				int no_works=0,habs=0,pop=0,fin_works=0,target_no_works=0,target_tot_habs=0,target_tot_pop=0;
				Double banksendAmount=0.0,bankpaoAmt=0.0,fin_amount=0.0,fin_banksendAmount=0.0,fin_bankpaoAmt=0.0,not_finalBal=0.0;	
				int tot_no_works=0,tot_habs=0,tot_pop=0,tot_fin_works=0,target_tot_no_works=0,target_habs=0,target_pop=0;
				Double tot_fin_amount=0.0,tot_not_finalBal=0.0,target_sanction_amount=0.0,target_banksendAmount=0.0,target_bankpaoAmt=0.0,target_finalBal=0.0;	
				Double target_tot_fin_amount=0.0,tot_ach_amount=0.0,tot_ach_finalBal=0.0,ach_banksendAmount=0.0,ach_bankpaoAmt=0.0; 
				int ach_works=0,ach_habs=0,ach_pop=0,tot_ach_works=0,ach_tot_habs=0,ach_tot_pop=0;
				Double tot_target_exp=0.0,target_exp=0.0,Progress_central=0.0,Progress_state=0.0;
				String ccode = "",c_query="";
		        String divCode = "";
		        String cname = "";
		        String divName = "";
		        String subdivCode = "";
		        String subdivName = "";
		        if(mode.equals("divisions")){
			        ccode = request.getParameter("ccode");
			        cname = request.getParameter("cname");
		        }
		          if(mode.equals("subdivisions")){
			        ccode = request.getParameter("ccode");
			        cname = request.getParameter("cname");
			        divCode = request.getParameter("divCode");
		        }
				try{
			 		 if(mode.equals("circles")){
			 			c_query="select circle_office_code,circle_office_name from rws_circle_office_tbl  order by circle_office_code";
		            }
		            else if(mode.equals("divisions")){
		            	c_query="select division_office_code,division_office_name from rws_division_office_tbl where  circle_office_code='"+ccode+"' and status <> 'UI' order by division_office_code";
		            }
		            else if(mode.equals("subdivisions")){
		            	 c_query="select subdivision_office_code,subdivision_office_name from rws_subdivision_office_tbl where  circle_office_code='"+ccode+"' and division_office_code='"+divCode+"' order by subdivision_office_code";
		            }
		          //System.out.println("query"+c_query);
		          PreparedStatement preparedStatement = conn.prepareStatement(c_query);
		          ResultSet res = preparedStatement.executeQuery();
		          while(res.next()){
		        	  if(mode.equals("circles")){
		                  cname=res.getString("circle_office_name");
		              	  ccode=res.getString("circle_office_code");
		              }
		              if(mode.equals("divisions")){
						divCode=res.getString("division_office_code");
						divName=res.getString("division_office_name");
					  }
					if(mode.equals("subdivisions")){
						subdivCode=res.getString("subdivision_office_code");
						subdivName=res.getString("subdivision_office_name");
					}
					    if (styleCount % 2 == 0) {
					        style = "gridbg1";
						} else {
							style = "gridbg2";
						}
						styleCount++;
		        
					if(mode.equals("circles")){ 
						query = "select sum(a.SANCTION_AMOUNT) as SANCTION_AMOUNT,count(a.work_id) as works from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
								+ " and substr(a.work_id,7,2)  in (" + schemes + ") and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'"
								+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
								+ programme
								+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id";
					}
					else if(mode.equals("divisions")){
						query = "select sum(a.SANCTION_AMOUNT) as SANCTION_AMOUNT,count(a.work_id) as works from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
								+ " and substr(a.work_id,7,2)  in (" + schemes + ") and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'"
								+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
								+ programme
								+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id ";
					}
					else if(mode.equals("subdivisions")){
						query = "select sum(a.SANCTION_AMOUNT) as SANCTION_AMOUNT,count(a.work_id) as works from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
								+ " and substr(a.work_id,7,2)  in (" + schemes + ") and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'"
								+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
								+ programme
								+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id ";
					}
				//System.out.println("query"+query);	
				stmt1 = conn.createStatement();
				rs1 = stmt1.executeQuery(query);
				if(rs1.next())
				{
				  sanction_amount=rs1.getDouble("SANCTION_AMOUNT");
				  no_works=rs1.getInt("works");
			   
				}
				tot_no_works+=no_works;		
				rs1.close();
				stmt1.close();
				if(mode.equals("circles")){ 
			   		hab_query = "select count(Distinct hab.hab_code) as habs,sum(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) as pop from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_ADMN_HAB_LNK_TBL hab,rws_habitation_directory_tbl h where WORK_CANCEL_DT is null "
						+ " and substr(a.work_id,7,2) in (" + schemes + ") and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'"
						+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
						+ programme
						+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and hab.work_id=a.work_id and  hab.hab_code=h.hab_code and COVERAGE_STATUS<>'UI'";
				}else if(mode.equals("divisions")){
					hab_query = "select count(Distinct hab.hab_code) as habs,sum(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) as pop from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_ADMN_HAB_LNK_TBL hab,rws_habitation_directory_tbl h where WORK_CANCEL_DT is null "
							+ " and substr(a.work_id,7,2) in (" + schemes + ") and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'"
							+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
							+ programme
							+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and hab.work_id=a.work_id and  hab.hab_code=h.hab_code and COVERAGE_STATUS<>'UI' ";
				}
				else if(mode.equals("subdivisions")){
					hab_query = "select count(Distinct hab.hab_code) as habs,sum(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) as pop from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_ADMN_HAB_LNK_TBL hab,rws_habitation_directory_tbl h where WORK_CANCEL_DT is null "
							+ " and substr(a.work_id,7,2) in (" + schemes + ") and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'"
							+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
							+ programme
							+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and hab.work_id=a.work_id and  hab.hab_code=h.hab_code and COVERAGE_STATUS<>'UI' ";
				}
			 // System.out.println("hab_query"+hab_query)	;	
				stmt2 = conn.createStatement();
				rs2 = stmt2.executeQuery(hab_query);
				if(rs2.next()){
					habs=rs2.getInt("habs");
					pop=rs2.getInt("pop");
				}
				tot_habs+=habs;
				tot_pop+=pop;
				rs2.close();
				stmt2.close();
				if(mode.equals("circles")){ 
					banksendQuery= "select sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
						+ " and substr(a.work_id,7,2) in (" + schemes + ") and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"' and BANK_SEND_DATE<='"+cDate+"'"
						+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
						+ programme
						+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";
				}else if(mode.equals("divisions")){
					banksendQuery= "select sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
							+ " and substr(a.work_id,7,2) in (" + schemes + ") and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"' and BANK_SEND_DATE<='"+cDate+"'"
							+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
							+ programme
							+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";
				}
				else if(mode.equals("subdivisions")){
					banksendQuery= "select sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
							+ " and substr(a.work_id,7,2) in (" + schemes + ") and substr(a.office_code,2,2)='"+ccode+"'"
							+" and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"' and BANK_SEND_DATE<='"+cDate+"'"
							+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
							+ programme
							+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";
				}
				//System.out.println("banksendQuery"+banksendQuery)	;	
				stmt2 = conn.createStatement();
				rs2 = stmt2.executeQuery(banksendQuery);
				while(rs2.next()){
					banksendAmount=rs2.getDouble("BILL_AMOUNT_CENTRAL");
				}
				rs2.close();
				stmt2.close();
				if(mode.equals("circles")){ 
						bankpaos= "select sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
						+ " and substr(a.work_id,7,2)  in (" + schemes + ") and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"' and STATE_SEND_DATE<='"+cDate+"'"
						+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
						+ programme 
						+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";		
				}else if(mode.equals("divisions")){
					bankpaos= "select sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
							+ " and substr(a.work_id,7,2)  in (" + schemes + ") and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"' and STATE_SEND_DATE<='"+cDate+"'"
							+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
							+ programme 
							+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";		
				}
				else if(mode.equals("subdivisions")){
					bankpaos= "select sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
							+ " and substr(a.work_id,7,2)  in (" + schemes + ") and substr(a.office_code,2,2)='"+ccode+"' and STATE_SEND_DATE<='"+cDate+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'"
							+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
							+ programme 
							+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";		
				}
				//System.out.println("bankpaos"+bankpaos)	;	
				stmt2 = conn.createStatement();
				rs2 = stmt2.executeQuery(bankpaos);
				if(rs2.next()){
					bankpaoAmt=rs2.getDouble("BILL_AMOUT_STATE");
				}
				rs2.close();
				stmt2.close();
				finalBal=(sanction_amount*100000)-(banksendAmount + bankpaoAmt);
				tot_fin_amount+=finalBal;
					
				if(mode.equals("circles")){ 
					Financial_qry="select count(a.work_id) as works,sum(a.sanction_amount) as sanction_amount from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
								+ " and substr(a.work_id,7,2) in (" + schemes + ") and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'"
								+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
								+ programme
								+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id in(select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '"+cDate+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  ";
				}else if(mode.equals("divisions")){
					Financial_qry="select count(a.work_id) as works,sum(a.sanction_amount) as sanction_amount from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
							+ " and substr(a.work_id,7,2) in (" + schemes + ") and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'"
							+ " and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and a.ADMIN_DATE<to_date('01/04/"+yearStart+"','dd/mm/yyyy') "
							+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
							+ programme
							+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id in(select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '"+cDate+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id ";
			
				}
				else if(mode.equals("subdivisions")){
					Financial_qry="select count(a.work_id) as works,sum(a.sanction_amount) as sanction_amount from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
							+ " and substr(a.work_id,7,2) in (" + schemes + ") and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'"
							+ " and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and a.ADMIN_DATE<to_date('01/04/"+yearStart+"','dd/mm/yyyy') "
							+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
							+ programme
							+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id in(select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '"+cDate+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id ";
			
				}
				//System.out.println("Financial_qry"+Financial_qry);	
				stmt2 = conn.createStatement();
				rs2 = stmt2.executeQuery(Financial_qry);
				if(rs2.next()){
					fin_works=rs2.getInt("works");
					fin_amount=rs2.getDouble("sanction_amount");				
									
					}rs2.close();
					stmt2.close();
					tot_fin_works+=fin_works;
					if(mode.equals("circles")){ 
					fin_banksendQuery= "select sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
							+ " and substr(a.work_id,7,2) in (" + schemes + ") and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"' and BANK_SEND_DATE<='"+cDate+"'"
							+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
							+ programme
							+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id in(select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '"+cDate+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";
					}else if(mode.equals("divisions")){
						fin_banksendQuery= "select sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
								+ " and substr(a.work_id,7,2) in (" + schemes + ") and substr(a.office_code,2,2)='"+ccode+"' and BANK_SEND_DATE<='"+cDate+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'"
								+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
								+ programme
								+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id in(select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '"+cDate+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";
						
					}
					else if(mode.equals("subdivisions")){
						fin_banksendQuery= "select sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
								+ " and substr(a.work_id,7,2) in (" + schemes + ") and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"' and BANK_SEND_DATE<='"+cDate+"'"
								+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
								+ programme
								+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id in(select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '"+cDate+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";
						
					}
						//	System.out.println("fin_banksendQuery"+fin_banksendQuery);	
					stmt2 = conn.createStatement();
					rs2 = stmt2.executeQuery(fin_banksendQuery);
					while(rs2.next()){
						fin_banksendAmount=rs2.getDouble("BILL_AMOUNT_CENTRAL");
					}
					rs2.close();
					stmt2.close();
					if(mode.equals("circles")){ 
					fin_bankpaos= "select sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
							+ " and substr(a.work_id,7,2)  in (" + schemes + ") and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"' and STATE_SEND_DATE<='"+cDate+"'"
							+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
							+ programme 
							+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id  in(select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '"+cDate+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";		
					}else if(mode.equals("divisions")){
						fin_bankpaos= "select sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
								+ " and substr(a.work_id,7,2)  in (" + schemes + ") and substr(a.office_code,2,2)='"+ccode+"' and STATE_SEND_DATE<='"+cDate+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'"
								+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
								+ programme 
								+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id  in(select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '"+cDate+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";		
					}
					else if(mode.equals("subdivisions")){
						fin_bankpaos= "select sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
								+ " and substr(a.work_id,7,2)  in (" + schemes + ") and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"' and STATE_SEND_DATE<='"+cDate+"'"
								+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
								+ programme 
								+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id  in(select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '"+cDate+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";		
					}
							//System.out.println("fin_bankpaos"+fin_bankpaos);	
					stmt2 = conn.createStatement();
					rs2 = stmt2.executeQuery(fin_bankpaos);
					if(rs2.next()){
						fin_bankpaoAmt=rs2.getDouble("BILL_AMOUT_STATE");
					}
					rs2.close();
					stmt2.close();
					not_finalBal=(fin_amount*100000)-(fin_banksendAmount + fin_bankpaoAmt);
					tot_not_finalBal+=not_finalBal;
					if(mode.equals("circles")){ 
						query_target = "select sum(a.SANCTION_AMOUNT) as SANCTION_AMOUNT,count(a.work_id) as works from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
								+ " and substr(a.work_id,7,2)  in (" + schemes + ") and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'"
								+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
								+ programme
								+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"'  and  ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearEnd+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
								+ "  and TARGET_DATE_COMP<to_date('01/04/"+yearEnd+"','dd/mm/yyyy')";
					}
					else if(mode.equals("divisions")){
						query_target = "select sum(a.SANCTION_AMOUNT) as SANCTION_AMOUNT,count(a.work_id) as works from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
								+ " and substr(a.work_id,7,2)  in (" + schemes + ") and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'"
								+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
								+ programme
								+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"'  and  ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearEnd+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
								+ "  and TARGET_DATE_COMP<to_date('01/04/"+yearEnd+"','dd/mm/yyyy')";
					}
					else if(mode.equals("subdivisions")){
						query_target = "select sum(a.SANCTION_AMOUNT) as SANCTION_AMOUNT,count(a.work_id) as works from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
								+ " and substr(a.work_id,7,2)  in (" + schemes + ") and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'"
								+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
								+ programme
								+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"'  and  ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearEnd+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
								+ "  and TARGET_DATE_COMP<to_date('01/04/"+yearEnd+"','dd/mm/yyyy')";
					}
				//System.out.println("query_target"+query_target);	
				stmt1 = conn.createStatement();
				rs1 = stmt1.executeQuery(query_target);
				if(rs1.next())
				{
				  target_sanction_amount=rs1.getDouble("SANCTION_AMOUNT");
				  target_no_works=rs1.getInt("works");
			   
				}
				target_tot_no_works+=target_no_works;		
				rs1.close();
				stmt1.close();
				if(mode.equals("circles")){ 
			   		target_hab_query = "select count(Distinct hab.hab_code) as habs,sum(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) as pop from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_ADMN_HAB_LNK_TBL hab,rws_habitation_directory_tbl h where WORK_CANCEL_DT is null "
						+ " and substr(a.work_id,7,2) in (" + schemes + ") and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'"
						+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
						+ programme
						+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearEnd+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and hab.work_id=a.work_id and  hab.hab_code=h.hab_code and COVERAGE_STATUS<>'UI'"
						+ "  and TARGET_DATE_COMP<to_date('01/04/"+yearEnd+"','dd/mm/yyyy')";
				}else if(mode.equals("divisions")){
					target_hab_query = "select count(Distinct hab.hab_code) as habs,sum(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) as pop from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_ADMN_HAB_LNK_TBL hab,rws_habitation_directory_tbl h where WORK_CANCEL_DT is null "
							+ " and substr(a.work_id,7,2) in (" + schemes + ") and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'"
							+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
							+ programme
							+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearEnd+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and hab.work_id=a.work_id and  hab.hab_code=h.hab_code and COVERAGE_STATUS<>'UI'"
							+ "  and TARGET_DATE_COMP<to_date('01/04/"+yearEnd+"','dd/mm/yyyy')";
				}
				else if(mode.equals("subdivisions")){
					target_hab_query = "select count(Distinct hab.hab_code) as habs,sum(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) as pop from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_ADMN_HAB_LNK_TBL hab,rws_habitation_directory_tbl h where WORK_CANCEL_DT is null "
							+ " and substr(a.work_id,7,2) in (" + schemes + ") and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'"
							+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
							+ programme
							+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearEnd+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and hab.work_id=a.work_id and  hab.hab_code=h.hab_code and COVERAGE_STATUS<>'UI'"
							+ "  and TARGET_DATE_COMP<to_date('01/04/"+yearEnd+"','dd/mm/yyyy')";
				}
			//  System.out.println("target_hab_query"+target_hab_query)	;	
				stmt2 = conn.createStatement();
				rs2 = stmt2.executeQuery(target_hab_query);
				if(rs2.next()){
					target_habs=rs2.getInt("habs");
					target_pop=rs2.getInt("pop");
				}
				target_tot_habs+=target_habs;
				target_tot_pop+=target_pop;
				rs2.close();
				stmt2.close();
				if(mode.equals("circles")){ 
					target_banksendQuery= "select sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
						+ " and substr(a.work_id,7,2) in (" + schemes + ") and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"' and BANK_SEND_DATE<='"+cDate+"'"
						+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
						+ programme
						+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearEnd+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id "
						+ " and TARGET_DATE_COMP is not null and TARGET_DATE_COMP<to_date('01/04/"+yearEnd+"','dd/mm/yyyy')";
				}else if(mode.equals("divisions")){
					target_banksendQuery= "select sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
							+ " and substr(a.work_id,7,2) in (" + schemes + ") and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"' and BANK_SEND_DATE<='"+cDate+"'"
							+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
							+ programme
							+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearEnd+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id "
							+ " and TARGET_DATE_COMP<to_date('01/04/"+yearEnd+"','dd/mm/yyyy')";
				}
				else if(mode.equals("subdivisions")){
					target_banksendQuery= "select sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
							+ " and substr(a.work_id,7,2) in (" + schemes + ") and substr(a.office_code,2,2)='"+ccode+"'"
							+" and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"' and BANK_SEND_DATE<='"+cDate+"'"
							+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
							+ programme
							+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearEnd+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id "
							+ "  and TARGET_DATE_COMP<to_date('01/04/"+yearEnd+"','dd/mm/yyyy')";
				}
				//System.out.println("target_banksendQuery"+target_banksendQuery)	;	
				stmt2 = conn.createStatement();
				rs2 = stmt2.executeQuery(target_banksendQuery);
				while(rs2.next()){
					target_banksendAmount=rs2.getDouble("BILL_AMOUNT_CENTRAL");
				}
				rs2.close();
				stmt2.close();
				if(mode.equals("circles")){ 
						target_bankpaos= "select sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
						+ " and substr(a.work_id,7,2)  in (" + schemes + ") and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"' and STATE_SEND_DATE<='"+cDate+"'"
						+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
						+ programme 
						+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearEnd+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id "
						+ "and TARGET_DATE_COMP<to_date('01/04/"+yearEnd+"','dd/mm/yyyy')";		
				}else if(mode.equals("divisions")){
					target_bankpaos= "select sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
							+ " and substr(a.work_id,7,2)  in (" + schemes + ") and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"' and STATE_SEND_DATE<='"+cDate+"'"
							+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
							+ programme 
							+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearEnd+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id "
							+ "and TARGET_DATE_COMP<to_date('01/04/"+yearEnd+"','dd/mm/yyyy')";		
				}
				else if(mode.equals("subdivisions")){
					target_bankpaos= "select sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
	  						+ " and substr(a.work_id,7,2)  in (" + schemes + ") and substr(a.office_code,2,2)='"+ccode+"' and STATE_SEND_DATE<='"+cDate+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'"
							+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
							+ programme 
							+ ") and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearEnd+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id "
							+ "and TARGET_DATE_COMP<to_date('01/04/"+yearEnd+"','dd/mm/yyyy')";		
				}
				//System.out.println("target_bankpaos"+target_bankpaos)	;	
				stmt2 = conn.createStatement();
				rs2 = stmt2.executeQuery(target_bankpaos);
				if(rs2.next()){
					target_bankpaoAmt=rs2.getDouble("BILL_AMOUT_STATE");
				}
				rs2.close();
				stmt2.close();
				target_finalBal=(target_sanction_amount*100000)-(target_banksendAmount + target_bankpaoAmt);
				//System.out.println(target_sanction_amount +" , " + target_banksendAmount +" , " + target_banksendAmount +" = " + target_finalBal); 
				target_tot_fin_amount+=target_finalBal;			
				
			if(mode.equals("circles")){ 
				ach_qry = "select sum(a.SANCTION_AMOUNT) as SANCTION_AMOUNT,count(DISTINCT a.work_id) as works from RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
						+ " and substr(a.work_id,7,2)  in (" + schemes + ") and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'"
						+" and h.work_id=a.work_id and hd.hab_code=h.hab_code and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
						+ programme
						+ ") and a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION >= '01-APR-"+yearStart+"' and DATE_OF_COMPLETION is not null ) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id";
			}
			else if(mode.equals("divisions")){
				ach_qry = "select sum(a.SANCTION_AMOUNT) as SANCTION_AMOUNT,count(DISTINCT a.work_id) as works from RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
						+ " and substr(a.work_id,7,2)  in (" + schemes + ") and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'"
						+" and h.work_id=a.work_id and hd.hab_code=h.hab_code and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
						+ programme
						+ ") and a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION >= '01-APR-"+yearStart+"' and DATE_OF_COMPLETION is not null ) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id";
			}
			else if(mode.equals("subdivisions")){
				ach_qry = "select sum(a.SANCTION_AMOUNT) as SANCTION_AMOUNT,count(DISTINCT a.work_id) as works from RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
						+ " and substr(a.work_id,7,2)  in (" + schemes + ") and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'"
						+" and h.work_id=a.work_id and hd.hab_code=h.hab_code and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
						+ programme
						+ ") and a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION >= '01-APR-"+yearStart+"' and DATE_OF_COMPLETION is not null ) and  i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id ";
			}
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
			if(mode.equals("circles")){ 
				ach_hab_query = "select count(distinct hab.hab_code) as habs,sum(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) as pop from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL hab,rws_habitation_directory_tbl h where WORK_CANCEL_DT is null "
					+ " and substr(a.work_id,7,2) in (" + schemes + ") and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'"
					+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
					+ programme
					+ ") and a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id in (select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION >= '01-APR-" + yearStart +"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >= '01-APR-" + yearStart +"' and DATE_OF_COMPLETION is null)) ) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and hab.work_id=a.work_id and  hab.hab_code=h.hab_code and COVERAGE_STATUS<>'UI'";
			}else if(mode.equals("divisions")){
				ach_hab_query = "select count(Distinct hab.hab_code) as habs,sum(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) as pop from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL hab,rws_habitation_directory_tbl h where WORK_CANCEL_DT is null "
						+ " and substr(a.work_id,7,2) in (" + schemes + ") and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'"
						+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
						+ programme
						+ ") and a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id in (select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION >= '01-APR-" + yearStart +"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >= '01-APR-" + yearStart +"' and DATE_OF_COMPLETION is null))) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and hab.work_id=a.work_id and  hab.hab_code=h.hab_code and COVERAGE_STATUS<>'UI'";
			}
			else if(mode.equals("subdivisions")){
				ach_hab_query = "select count(Distinct hab.hab_code) as habs,sum(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) as pop from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL hab,rws_habitation_directory_tbl h where WORK_CANCEL_DT is null "
						+ " and substr(a.work_id,7,2) in (" + schemes + ") and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'"
						+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
						+ programme
						+ ") and a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id in (select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION >= '01-APR-" + yearStart +"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >= '01-APR-" + yearStart +"' and DATE_OF_COMPLETION is null))) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and hab.work_id=a.work_id and  hab.hab_code=h.hab_code and COVERAGE_STATUS<>'UI'";
			}
			//System.out.println("ach_hab_query"+ach_hab_query)	;	
			stmt2 = conn.createStatement();
			rs2 = stmt2.executeQuery(ach_hab_query);
			if(rs2.next()){
				ach_habs=rs2.getInt("habs");
				ach_pop=rs2.getInt("pop");
			}
			ach_tot_habs+=ach_habs;
			ach_tot_pop+=ach_pop;
			rs2.close();
			stmt2.close();
			ach_fin_not_comp_central_qry= "select sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
					+ " and substr(a.work_id,7,2) in (" + schemes + ") and BANK_SEND_DATE>='01-APR-" + yearStart + "' and BANK_SEND_DATE<='"+cDate+"'"
					+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
					+ programme
					+ ")  and  a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION <'01-APR-"+yearStart+"' ) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";
			if(mode.equals("circles")){ 
				ach_fin_not_comp_central_qry  = ach_fin_not_comp_central_qry+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
			}
			else if(mode.equals("divisions")){
				ach_fin_not_comp_central_qry = ach_fin_not_comp_central_qry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			}
			else if(mode.equals("subdivisions")){
				ach_fin_not_comp_central_qry = ach_fin_not_comp_central_qry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
			}
			//System.out.println("fin_banksendQuery"+ach_fin_not_comp_central_qry);	
			stmt2 = conn.createStatement();
			rs2 = stmt2.executeQuery(ach_fin_not_comp_central_qry);
			while(rs2.next()){
				ach_fin_not_comp_central=rs2.getDouble("BILL_AMOUNT_CENTRAL");
			}
			rs2.close();
			stmt2.close();
			ach_fin_not_comp_state_qry= "select sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
					+ " and substr(a.work_id,7,2)  in (" + schemes + ") and STATE_SEND_DATE>='01-APR-" + yearStart + "' and  STATE_SEND_DATE<='"+cDate+"'"
					+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
					+ programme 
					+ ")  and  a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION <'01-APR-"+yearStart+"' ) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and b.work_id=a.work_id ";
			if(mode.equals("circles")){ 
				ach_fin_not_comp_state_qry  = ach_fin_not_comp_state_qry+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
			}
			else if(mode.equals("divisions")){
				ach_fin_not_comp_state_qry = ach_fin_not_comp_state_qry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			}
			else if(mode.equals("subdivisions")){
				ach_fin_not_comp_state_qry = ach_fin_not_comp_state_qry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
			}
			//System.out.println("fin_bankpaos"+ach_fin_not_comp_state_qry);	
			stmt2 = conn.createStatement();
			rs2 = stmt2.executeQuery(ach_fin_not_comp_state_qry);
			if(rs2.next()){
				ach_fin_not_comp_state=rs2.getDouble("BILL_AMOUT_STATE");
			}
			rs2.close();
			stmt2.close();
			ach_fin_not_comp_exp =(ach_fin_not_comp_state + ach_fin_not_comp_central);
			total_ach_fin_not_comp_exp += ach_fin_not_comp_exp;
			String progressqry= "select sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
					+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and BANK_SEND_DATE>='01-APR-" + yearStart + "'"
					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id "
					+" and target_date_comp>='01-APR-" + yearStart + "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "')";
			if(mode.equals("circles")){ 
				progressqry  = progressqry+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
			}
			else if(mode.equals("divisions")){
				progressqry = progressqry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			}
			else if(mode.equals("subdivisions")){
				progressqry = progressqry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
			}
					
					/* "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
            + "where WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
            + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and BANK_SEND_DATE >'31-MAR-" + yearStart + "' and BANK_SEND_DATE<='" + cDate + "' "
            + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'"; */
	//System.out.println("fin_banksendQuery"+ach_fin_not_comp_central_qry);	
	stmt2 = conn.createStatement();
	rs2 = stmt2.executeQuery(progressqry);
	while(rs2.next()){
		Progress_central=rs2.getDouble(1);
	}
	rs2.close();
	stmt2.close();
	String Prog_state_qry= "select sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
			+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
			+ " and a.TYPE_OF_ASSET in (" + schemes + ") and STATE_SEND_DATE>='01-APR-" + yearStart + "'"
			+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
			+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id "
			+" and target_date_comp>='01-APR-" + yearStart + "' AND a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "')";
	if(mode.equals("circles")){ 
		Prog_state_qry  = Prog_state_qry+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
	}
	else if(mode.equals("divisions")){
		Prog_state_qry = Prog_state_qry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
	}
	else if(mode.equals("subdivisions")){
		Prog_state_qry = Prog_state_qry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
	}
		/* 	
			"select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
            + "where WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
            + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and STATE_SEND_DATE >'31-MAR-" + yearStart + "' and STATE_SEND_DATE<='"+cDate+ "' "
            + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'"; */		
	//System.out.println("fin_bankpaos"+ach_fin_not_comp_state_qry);	
	stmt2 = conn.createStatement();
	rs2 = stmt2.executeQuery(Prog_state_qry);
	if(rs2.next()){
		Progress_state=rs2.getDouble(1);
	}
	rs2.close();
	stmt2.close();
	target_exp =(Progress_state + Progress_central);
	tot_target_exp += target_exp;
			if(sanction_amount==0.0&&finalBal==0.0&&ach_amount==0.0&&ach_finalBal==0.0&&ach_fin_not_comp_exp==0.0&&
					no_works==0&&habs==0&&pop==0&&fin_works==0&&target_no_works==0&&
					fin_amount==0.0&&fin_banksendAmount==0.0&&fin_bankpaoAmt==0.0&&not_finalBal==0.0&&	
					target_habs==0&&target_pop==0&&
					target_sanction_amount==0.0&&target_finalBal==0.0&&	
					ach_works==0&&ach_habs==0&&ach_pop==0){						
					}else{
			%>
				<tr>
					<td class="<%=style%>" style="text-align: right;" align="right"><%=++slno%></td>
					<%if(mode.equals("circles")){ %>
					<td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_work_progress_div_subdiv_rpt.jsp?mode=divisions&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>"><%=cname%></a></td>
					<%}else if(mode.equals("divisions")){ %>
					<td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_work_progress_div_subdiv_rpt.jsp?mode=subdivisions&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>"><%=divName%></a></td>
					<%}else if(mode.equals("subdivisions")){ %>
					<td class="<%=style%>" style="text-align: left;" align="left" ><%=subdivName%></td>
					<%} 	
					if(mode.equals("circles")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=ongoing&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=no_works%></a></td>
					<%}else if(mode.equals("divisions")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=ongoing&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=no_works%></a></td>
					<%}else if(mode.equals("subdivisions")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=ongoing&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=no_works%></a></td>
					<%}%>
					<%if(mode.equals("circles")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=ongoing&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=habs%></a></td>
					<%}else if(mode.equals("divisions")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=ongoing&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=habs%></a></td>
					<%}else if(mode.equals("subdivisions")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=ongoing&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=habs%></a></td>
					<%}%>					
					<td class="<%=style%>" style="text-align: right;" align="right"><%=pop%></td>
					<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(finalBal/100000)%></td>
					<%if(mode.equals("circles")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=financial&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=fin_works%></a></td>
					<%}else if(mode.equals("divisions")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=financial&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=fin_works%></a></td>
					<%}else if(mode.equals("subdivisions")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=financial&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=fin_works%></a></td>
					<%}%>
					<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(not_finalBal/100000) %> </td>
					<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format((finalBal+not_finalBal)/100000) %></td>
					<%if(mode.equals("circles")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=target&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=target_no_works%></a></td>
					<%}else if(mode.equals("divisions")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=target&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=target_no_works%></a></td>
					<%}else if(mode.equals("subdivisions")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=target&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=target_no_works%></a></td>
					<%}%>
					<%if(mode.equals("circles")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=target&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=target_habs%></a></td>
					<%}else if(mode.equals("divisions")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=target&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=target_habs%></a></td>
					<%}else if(mode.equals("subdivisions")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=target&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=target_habs%></a></td>
					<%}%>					
					<td class="<%=style%>" style="text-align: right;" align="right"><%=target_pop%></td>
					<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(target_finalBal/100000)%></td>
					<%if(mode.equals("circles")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=achieve&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=ach_works%></a></td>
					<%}else if(mode.equals("divisions")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=achieve&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=ach_works%></a></td>
					<%}else if(mode.equals("subdivisions")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=achieve&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=ach_works%></a></td>
					<%}%>
					<%if(mode.equals("circles")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=achieve&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=ach_habs%></a></td>
					<%}else if(mode.equals("divisions")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=achieve&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=ach_habs%></a></td>
					<%}else if(mode.equals("subdivisions")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=achieve&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=ach_habs%></a></td>
					<%}%>
					<td class="<%=style%>" style="text-align: right;" align="right"><%=ach_pop%></td>
					<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(target_exp/100000)%></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(ach_fin_not_comp_exp/100000)%></td>
						<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format((target_exp+ach_fin_not_comp_exp)/100000)%></td>
					</tr>
				<%}}%>
				<tr>
				<td class="btext" style="text-align: right;" colspan="2">Total </td>
				<%-- <%if(mode.equals("circles")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=ongoing&programme=<%=programme%>&programmeName=<%=programmeName%>')"><%=tot_no_works%></a></td>
				<%}else if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=ongoing&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=tot_no_works%></a></td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=ongoing&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=tot_no_works%></a></td>
				<%} %>
				 --%>
				 <td class="btext" style="text-align: right;" align="right"><%=tot_no_works%></td>
				 <td class="btext" style="text-align: right;" ><%=tot_habs%> </td>
				<td class="btext" style="text-align: right;" ><%=tot_pop %> </td>
				<td class="btext" style="text-align: right;" ><%=ndf.format(tot_fin_amount/100000) %> </td>
				<%-- <%if(mode.equals("circles")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=financial&programme=<%=programme%>&programmeName=<%=programmeName%>')"><%=tot_fin_works%></a></td>
				<%}else if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=financial&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=tot_fin_works%></a></td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=financial&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=tot_fin_works%></a></td>
				<%}%> --%>
				<td class="btext" style="text-align: right;" align="right"><%=tot_fin_works%></td>
				<td class="btext" style="text-align: right;" ><%=ndf.format(tot_not_finalBal/100000) %> </td>
				<td class="btext" style="text-align: right;" ><%=ndf.format((tot_fin_amount+tot_not_finalBal)/100000)%> </td>
				<%-- <%if(mode.equals("circles")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=target&programme=<%=programme%>&programmeName=<%=programmeName%>')"><%=target_tot_no_works%></a></td>
				<%}else if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=target&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=target_tot_no_works%></a></td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=target&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=target_tot_no_works%></a></td>
				<%} %> --%>
				<td class="btext" style="text-align: right;" align="right"><%=target_tot_no_works%></td>
				<td class="btext" style="text-align: right;" ><%=target_tot_habs%> </td>
				<td class="btext" style="text-align: right;" ><%=target_tot_pop %> </td>
				<td class="btext" style="text-align: right;" ><%=ndf.format(target_tot_fin_amount/100000) %> </td>
				<%-- <%if(mode.equals("circles")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=achieve&programme=<%=programme%>&programmeName=<%=programmeName%>')"><%=tot_ach_works%></a></td>
				<%}else if(mode.equals("divisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=achieve&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=tot_ach_works%></a></td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=achieve&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=tot_ach_works%></a></td>
				<%} %> --%>
				<td class="btext" style="text-align: right;" align="right"><%=tot_ach_works%></td>
				<td class="btext" style="text-align: right;" ><%=ach_tot_habs%> </td>
				<td class="btext" style="text-align: right;" ><%=ach_tot_pop%> </td>
				<td class="btext" style="text-align: right;" ><%=ndf.format(tot_target_exp/100000)%></td>
					<td class="btext" style="text-align: right;" ><%=ndf.format( total_ach_fin_not_comp_exp/100000) %></td>
					<td class="btext" style="text-align: right;" ><%=ndf.format((tot_target_exp+total_ach_fin_not_comp_exp)/100000)%></td>
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