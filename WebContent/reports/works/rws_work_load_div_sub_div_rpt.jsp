<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.util.*"%>
<%@page import="nic.watersoft.works.WorksData1"%>
<%
String schemes = "'01','02','03','10'";
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
<body>
<br />
		<br />
		<center>
			<font color="#663899" face="Maiandra GD" size="4px"><b>Work Load for <%=yearStart%>-<%=yearEnd%></font></br><font color="#889900" face="Maiandra GD" size="3px"  > Programme :- <%=programmeName %>
			<b><%if(mode.equals("divisions")){ %>
			 , Circle: <%=request.getParameter("cname") %>
			<%}else if(mode.equals("subdivisions")){  %>
			, Circle: <%=request.getParameter("cname") %>
			 , Division: <%=request.getParameter("divname") %>
			<%} %></b></font><br/>
		</center>
		<br/><br/><br/>
		<table align="center"
		style="margin-top: -45px !important; width: 800px !important; text-align: center !important;">
		<tr>
			<td style="width: 1000px !important; text-align: right !important;">
				<font color="#889900" face="Maiandra GD" size="2px">(Rs. Lakhs)</font>
			</td>
			<td style="width: 100px !important;" align="right"><a
					href="javascript:history.back(-1)"><img
						src="/pred/resources/graphs/go_back.gif" height="30px" /></a>&nbsp;&nbsp;
			</td>
		</tr>
	</table>
		
		<table border=1 cellspacing=0 cellpadding=0 height=5% width="1050px" bordercolor=#000000 style="border-collapse: collapse; margin-top: 20px !important;" bgcolor="#ffffff" align="center">
		<tr align=center align=center>
			<td class=btext rowspan=2>Sl.No</td>
			<%if(mode.equals("circles")){ %>
				<td class=btext rowspan=2>Circle</td>
				<%}else if(mode.equals("divisions")){ %>
				<td class=btext rowspan=2>Division</td>
				<%}else if(mode.equals("subdivisions")){ %>
				<td class=btext rowspan=2>Sub Division</td>
				<%} %>
			<td colspan=6 class=btext align="center">Spill Over works as on <br> 01.04.<%=yearStart%></td>
			<td colspan=4 class=btext align="center">New works sanctioned in<br><%=yearStart%>-<%=yearEnd%></td>
			<td colspan=6 class=btext align="center">Total Ongoing works in<br><%=yearStart%>-<%=yearEnd%></td>
			<td colspan=2 class=btext align="center">Financial Pending</td>
			<td class=btext rowspan=2 align="center">Total Commitment</td>
			<td colspan=4 class=btext align="center">Achievements</td>
		</tr>
		<tr>
			<td colspan=1 class=btext align="center">No of Works</td>
			<td colspan=1 class=btext align="center">Habs Sanctioned</td>
			<td colspan=1 class=btext align="center">Population</td>
			<td colspan=1 class=btext align="center">Sanctioned Amount</td>
			<td colspan=1 class=btext align="center">Tot.Exp. </td>
			<td colspan=1 class=btext align="center">Bal.Est.Cost</td>
			<td colspan=1 class=btext align="center">No of Works</td>
			<td colspan=1 class=btext align="center">Habs Sanctioned</td>
			<td colspan=1 class=btext align="center">Population</td>
			<td colspan=1 class=btext align="center">Cost</td>
			<td colspan=1 class=btext align="center">No of Works</td>
			<td colspan=1 class=btext align="center">Habs Sanctioned</td>
			<td colspan=1 class=btext align="center">Population</td>
			<td colspan=1 class=btext align="center">Sanctioned Amount</td>
			<td colspan=1 class=btext align="center">Tot.Exp. </td>
			<td colspan=1 class=btext align="center">Bal.Est.Cost</td>
			<td colspan=1 class=btext align="center">Works</td>
			<td colspan=1 class=btext align="center">Amount</td>
			<td colspan=1 class=btext align="center">No. of Works</td>
			<td colspan=1 class=btext align="center">No. of Habs</td>
			<td colspan=1 class=btext align="center">Population</td>
			<td colspan=1 class=btext align="center">Exp.</td>
		</tr>
		<%
		int styleCount = 0;
		String style = "";
		int slno=0,tot_on_works=0;	
		String ach_qry="",ach_hab_query="",ach_state_qry,ach_central_qry;
		String tot_on_exp_qry="",central_qry="",state_qry="";
		String query="",hab_query="",banksendQuery="",bankpaos="",query_new="",new_hab_query="",Financial_qry="",fin_banksendQuery="",fin_bankpaos="";
		Statement stmt1=null,stmt2=null;
		ResultSet rs1=null,rs2=null;
		Double sanction_amount=0.0,finalBal=0.0,new_work_amt=0.0,tot_ongonig_san=0.0,tot_san=0.0;
		int no_works=0,new_works=0,habs=0,new_habs=0,pop=0,new_pop=0,fin_works=0,on_works=0;
		Double banksendAmount=0.0,bankpaoAmt=0.0,fin_amount=0.0,fin_banksendAmount=0.0,fin_bankpaoAmt=0.0,not_finalBal=0.0;	
		int tot_no_works=0,tot_new_works=0,tot_habs=0,tot_new_habs=0,tot_pop=0,tot_new_pop=0,tot_fin_works=0;
		Double tot_new_work_amount=0.0,tot_fin_amount=0.0,tot_not_finalBal=0.0,	tot_ongoing=0.0,ongoing_cost=0.0;	
		Double tot_exp=0.0,tot_exp_ongoing=0.0,ongoing_sanction=0.0,ongong_state=0.0,ongoing_central=0.0,exp_ongoing=0.0;
		Double ach_amount=0.0,ach_state=0.0,ach_central=0.0,ach_exp=0.0, total_ach_exp=0.0;
		int ach_works=0,ach_habs=0,ach_pop=0,tot_ach_works=0,ach_tot_habs=0,ach_tot_pop=0;
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
		
			query = "select sum(a.SANCTION_AMOUNT) as SANCTION_AMOUNT,count(a.work_id) as works from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
					+ " and substr(a.work_id,7,2)  in ("+schemes+") "
					+ "  and a.ADMIN_DATE<to_date('01/04/"+yearStart+"','dd/mm/yyyy')"
					+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
					+ programme
					+ ")  AND TARGET_DATE_COMP>='01-APR-"
					+ yearStart
					+ "'  and  a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  ";
			if(mode.equals("circles")){ 
				query  = query+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
			}
			else if(mode.equals("divisions")){
				query = query+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			}
			else if(mode.equals("subdivisions")){
				query = query+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
			}
		//System.out.println("query"+query);	
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(query);
		if(rs1.next())
		{
		  sanction_amount=rs1.getDouble("SANCTION_AMOUNT");
		  no_works=rs1.getInt("works");
	    }
		tot_san+=sanction_amount;
		tot_no_works+=no_works;		
		rs1.close();
		stmt1.close();
		 hab_query = "select count(distinct hab.hab_code) as habs,sum(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) as pop from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_ADMN_HAB_LNK_TBL hab,rws_habitation_directory_tbl h where WORK_CANCEL_DT is null "
					+ " and substr(a.work_id,7,2) in (" + schemes + ") "
					+ "  and a.ADMIN_DATE<to_date('01/04/"+yearStart+"','dd/mm/yyyy')  "
					+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
					+ programme
					+ ")  AND TARGET_DATE_COMP>='01-APR-"
					+ yearStart
					+ "'  and  a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and hab.work_id=a.work_id and  hab.hab_code=h.hab_code and COVERAGE_STATUS in ('FC','PC1','PC2','PC3','PC4','NC','NSS')";
		if(mode.equals("circles")){ 
			hab_query = hab_query+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}else if(mode.equals("divisions")){
			hab_query = hab_query+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			hab_query = hab_query+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
	  //System.out.println("hab_query"+hab_query)	;	
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
		banksendQuery= "select sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
				+ " and substr(a.work_id,7,2) in ("+schemes+") and BANK_SEND_DATE<='"+cDate+"'"
				+ " and  a.ADMIN_DATE<to_date('01/04/"+yearStart+"','dd/mm/yyyy') "
				+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
				+ programme
				+ ") AND TARGET_DATE_COMP>='01-APR-"
				+ yearStart
				+ "'  and  a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and  i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";
		if(mode.equals("circles")){ 
		 	banksendQuery = banksendQuery+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'"; 
		}else if(mode.equals("divisions")){
			banksendQuery = banksendQuery+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}else if(mode.equals("subdivisions")){
			banksendQuery = banksendQuery+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'"; 
		}
		//System.out.println("banksendQuery"+banksendQuery)	;	
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(banksendQuery);
		while(rs2.next()){
			banksendAmount=rs2.getDouble("BILL_AMOUNT_CENTRAL");
		}
		rs2.close();
		stmt2.close();
		bankpaos= "select sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
				+ " and substr(a.work_id,7,2)  in ("+schemes+")  and STATE_SEND_DATE<='"+cDate+"'"
				+ " and  a.ADMIN_DATE<to_date('01/04/"+yearStart+"','dd/mm/yyyy') "
				+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
				+ programme 
				+ ") AND TARGET_DATE_COMP>='01-APR-"
				+ yearStart
				+ "' and a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";
		if(mode.equals("circles")){ 
			bankpaos = bankpaos+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'"; 
		}else if(mode.equals("divisions")){
			bankpaos = bankpaos+ " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'"; 		
		}else if(mode.equals("subdivisions")){
			bankpaos= bankpaos+" and substr(a.office_code,2,2)='"+ccode+"' and STATE_SEND_DATE<='"+cDate+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
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
		tot_exp+=banksendAmount + bankpaoAmt;
		query_new = "select sum(a.SANCTION_AMOUNT) as SANCTION_AMOUNT,count(a.work_id) as works from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
				+ " and substr(a.work_id,7,2) in ("+schemes+")  "
				+ " and a.ADMIN_DATE >=to_date('01/04/"+yearStart+"','dd/mm/yyyy') "
				+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
				+  programme
				+ ") AND TARGET_DATE_COMP>='01-APR-"
				+ yearStart
				+ "' and a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and  i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  ";
		if(mode.equals("circles")){ 
			query_new = query_new+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";			
		}else if(mode.equals("divisions")){
			query_new = query_new+"  and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}else if(mode.equals("subdivisions")){
			query_new = query_new+"  and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		//System.out.println("query_new"+query_new)	;	
		stmt1 = conn.createStatement();
		rs1 = stmt1.executeQuery(query_new);
		if(rs1.next())
		{
		  new_work_amt=rs1.getDouble("SANCTION_AMOUNT");
		  new_works=rs1.getInt("works");
		}
		rs1.close();
		stmt1.close();
		tot_new_works+=new_works;
		 new_hab_query = "select count(distinct hab.hab_code) as habs,sum(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) as pop from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_ADMN_HAB_LNK_TBL hab,rws_habitation_directory_tbl h where WORK_CANCEL_DT is null "
							+ " and substr(a.work_id,7,2) in (" + schemes + ") "
							+ " and a.ADMIN_DATE >=to_date('01/04/"+yearStart+"','dd/mm/yyyy') "
							+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
							+ programme
							+ ") AND TARGET_DATE_COMP>='01-APR-"
							+ yearStart
							+ "'  and  a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null ) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and hab.work_id=a.work_id and  hab.hab_code=h.hab_code and COVERAGE_STATUS in ('FC','PC1','PC2','PC3','PC4','NC','NSS')";
		if(mode.equals("circles")){ 
	    	new_hab_query = new_hab_query+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}else if(mode.equals("divisions")){
  			new_hab_query = new_hab_query+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
  		}else if(mode.equals("subdivisions")){
			new_hab_query = new_hab_query+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		//System.out.println("new_hab_query"+new_hab_query)	;	
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(new_hab_query);
		if(rs2.next()){
			new_habs=rs2.getInt("habs");
			new_pop=rs2.getInt("pop");
		}rs2.close();
		stmt2.close();
		tot_new_work_amount+=new_work_amt;
		tot_on_exp_qry="select count(a.work_id) as works,sum(a.sanction_amount) as sanction_amount from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
				+ " and substr(a.work_id,7,2) in ("+schemes+") "
				+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
				+ programme
				+ ") AND TARGET_DATE_COMP>='01-APR-"
				+ yearStart
				+ "'  and  a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id ";
		if(mode.equals("circles")){ 
			tot_on_exp_qry = tot_on_exp_qry+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}else if(mode.equals("divisions")){
			tot_on_exp_qry = tot_on_exp_qry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
  		}else if(mode.equals("subdivisions")){
  			tot_on_exp_qry = tot_on_exp_qry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
//System.out.println("Financial_qry"+tot_on_exp_qry);	
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(tot_on_exp_qry);
		if(rs2.next()){
			on_works=rs2.getInt("works");
			ongoing_sanction=rs2.getDouble("sanction_amount");
		}
		tot_on_works+=on_works;
		tot_ongonig_san+=ongoing_sanction;
		rs2.close();
		stmt2.close();
		central_qry= "select sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
				+ " and substr(a.work_id,7,2) in ("+schemes+") and BANK_SEND_DATE<='"+cDate+"'"
				+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
				+ programme
				+ ") AND TARGET_DATE_COMP>='01-APR-"
				+ yearStart
				+ "'  and  a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";
		
		if(mode.equals("circles")){ 
			central_qry = central_qry+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}else if(mode.equals("divisions")){
			central_qry = central_qry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
  		}else if(mode.equals("subdivisions")){
  			central_qry = central_qry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		//System.out.println("fin_banksendQuery"+fin_banksendQuery);	
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(central_qry);
		while(rs2.next()){
			ongoing_central=rs2.getDouble("BILL_AMOUNT_CENTRAL");
		}
		rs2.close();
		stmt2.close();
		state_qry= "select sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
				+ " and substr(a.work_id,7,2)  in ("+schemes+") and STATE_SEND_DATE<='"+cDate+"'"
				+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
				+ programme 
				+ ") AND TARGET_DATE_COMP>='01-APR-"
				+ yearStart
				+ "'  and  a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and b.work_id=a.work_id ";
		if(mode.equals("circles")){ 
			state_qry = state_qry+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}else if(mode.equals("divisions")){
			state_qry = state_qry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
  		}else if(mode.equals("subdivisions")){
  			state_qry = state_qry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}		
		 //System.out.println("fin_bankpaos"+fin_bankpaos);	
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(state_qry);
		if(rs2.next()){
			ongong_state=rs2.getDouble("BILL_AMOUT_STATE");
		}
		rs2.close();
		stmt2.close();
		ongoing_cost=(ongoing_sanction*100000)-(ongoing_central + ongong_state);	
		tot_ongoing	+=ongoing_cost;
		exp_ongoing=(ongoing_central + ongong_state);
		tot_exp_ongoing+=exp_ongoing;
		Financial_qry="select count(a.work_id) as works,sum(a.sanction_amount) as sanction_amount from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
				+ " and substr(a.work_id,7,2) in ("+schemes+") "
				+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
				+ programme
				+ ") AND TARGET_DATE_COMP>='01-APR-"
				+ yearStart
				+ "'  and  a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id in(select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '"+cDate+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id ";
		if(mode.equals("circles")){ 
			Financial_qry=Financial_qry+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}else if(mode.equals("divisions")){
			Financial_qry=Financial_qry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}else if(mode.equals("subdivisions")){
			Financial_qry=Financial_qry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
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
			fin_banksendQuery= "select sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
					+ " and substr(a.work_id,7,2) in ("+schemes+") and BANK_SEND_DATE<='"+cDate+"'"
					+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
					+ programme
					+ ") AND TARGET_DATE_COMP>='01-APR-"
					+ yearStart
					+ "'  and  a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id  in(select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '"+cDate+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";
			if(mode.equals("circles")){ 
			fin_banksendQuery=fin_banksendQuery+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'"; 
			}else if(mode.equals("divisions")){
				fin_banksendQuery= fin_banksendQuery+" and substr(a.office_code,2,2)='"+ccode+"'  and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			}else if(mode.equals("subdivisions")){
				fin_banksendQuery= fin_banksendQuery+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"' ";
			}
				//	System.out.println("fin_banksendQuery"+fin_banksendQuery);	
			stmt2 = conn.createStatement();
			rs2 = stmt2.executeQuery(fin_banksendQuery);
			while(rs2.next()){
				fin_banksendAmount=rs2.getDouble("BILL_AMOUNT_CENTRAL");
			}
			rs2.close();
			stmt2.close();
			fin_bankpaos= "select sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
					+ " and substr(a.work_id,7,2)  in ("+schemes+") and STATE_SEND_DATE<='"+cDate+"'"
					+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
					+ programme 
					+ ") AND TARGET_DATE_COMP>='01-APR-"
					+ yearStart
					+ "'  and  a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id in(select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '"+cDate+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and b.work_id=a.work_id ";
			if(mode.equals("circles")){ 
				fin_bankpaos=fin_bankpaos+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"' ";
			}else if(mode.equals("divisions")){
				fin_bankpaos=fin_bankpaos+" and substr(a.office_code,2,2)='"+ccode+"'  and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			}else if(mode.equals("subdivisions")){
				fin_bankpaos= fin_bankpaos+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"' ";
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
			//Change by Deepak 29062017	
			ach_qry="select count(distinct a.work_id) as works,sum(a.sanction_amount) as sanction_amount from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null "
						+ " and substr(a.work_id,7,2) in (" + schemes + ") "
						+" and h.work_id=a.work_id and hd.hab_code=h.hab_code and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
						+ programme
						+ ") AND TARGET_DATE_COMP>='01-APR-"
						+ yearStart
						+ "' and a.CORE_DASHBOARD_STATUS='Y' and a.work_id in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION >= '01-APR-"+yearStart+"' and DATE_OF_COMPLETION is not null ) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id";
			//System.out.println("ach_qry"+ach_qry);
			if(mode.equals("circles")){ 
				ach_qry=ach_qry+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"' ";
			}else if(mode.equals("divisions")){
				ach_qry=ach_qry+" and substr(a.office_code,2,2)='"+ccode+"'  and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			}else if(mode.equals("subdivisions")){
				ach_qry= ach_qry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"' ";
			}
			stmt2 = conn.createStatement();
			rs2 = stmt2.executeQuery(ach_qry);
			if(rs2.next()){
			ach_works=rs2.getInt("works");
			ach_amount=rs2.getDouble("sanction_amount");
			}
			tot_ach_works += ach_works;
			rs2.close();
			stmt2.close();
			ach_hab_query = "select count(Distinct hab.hab_code) as habs,sum(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) as pop from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL hab,rws_habitation_directory_tbl h where WORK_CANCEL_DT is null "
					+ " and substr(a.work_id,7,2) in (" + schemes + ") "
					+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
					+ programme
					+ ") AND TARGET_DATE_COMP>='01-APR-"
					+ yearStart
					+ "' and a.CORE_DASHBOARD_STATUS='Y' and a.work_id in ( select work_id from rws_work_completion_tbl where ((DATE_OF_COMPLETION >= '01-APR-" + yearStart +"' and DATE_OF_COMPLETION is not null) OR (partial_date_of_completion >= '01-APR-" + yearStart +"' and DATE_OF_COMPLETION is null))) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and hab.work_id=a.work_id and  hab.hab_code=h.hab_code and COVERAGE_STATUS in ('FC','PC1','PC2','PC3','PC4','NC','NSS')";
			//System.out.println("ach_hab_query"+ach_hab_query)	;
			if(mode.equals("circles")){ 
				ach_hab_query=ach_hab_query+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"' ";
			}else if(mode.equals("divisions")){
				ach_hab_query=ach_hab_query+" and substr(a.office_code,2,2)='"+ccode+"'  and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			}else if(mode.equals("subdivisions")){
				ach_hab_query= ach_hab_query+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"' ";
			}
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
			ach_central_qry= "select sum(BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
					+ " and substr(a.work_id,7,2) in (" + schemes + ") and BANK_SEND_DATE<='"+cDate+"'"
					+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
					+ programme
					+ ") AND TARGET_DATE_COMP>='01-APR-"
					+ yearStart
					+ "'  and  a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION >='01-APR-"+yearStart+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";
			//System.out.println("fin_banksendQuery"+ach_central_qry);	
			if(mode.equals("circles")){ 
				ach_central_qry=ach_central_qry+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"' ";
			}else if(mode.equals("divisions")){
				ach_central_qry=ach_central_qry+" and substr(a.office_code,2,2)='"+ccode+"'  and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			}else if(mode.equals("subdivisions")){
				ach_central_qry= ach_central_qry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"' ";
			}
			stmt2 = conn.createStatement();
			rs2 = stmt2.executeQuery(ach_central_qry);
			while(rs2.next()){
				ach_central=rs2.getDouble("BILL_AMOUNT_CENTRAL");
			}
			rs2.close();
			stmt2.close();
			ach_state_qry= "select sum(BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
					+ " and substr(a.work_id,7,2)  in (" + schemes + ") and STATE_SEND_DATE<='"+cDate+"'"
					+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
					+ programme 
					+ ") AND TARGET_DATE_COMP>='01-APR-"
					+ yearStart
					+ "'  and  a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION >='01-APR-"+yearStart+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and b.work_id=a.work_id ";		
			//System.out.println("fin_bankpaos"+ach_state_qry);	
			if(mode.equals("circles")){ 
				ach_state_qry=ach_state_qry+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"' ";
			}else if(mode.equals("divisions")){
				ach_state_qry=ach_state_qry+" and substr(a.office_code,2,2)='"+ccode+"'  and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			}else if(mode.equals("subdivisions")){
				ach_state_qry= ach_state_qry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"' ";
			}
			stmt2 = conn.createStatement();
			rs2 = stmt2.executeQuery(ach_state_qry);
			if(rs2.next()){
				ach_state=rs2.getDouble("BILL_AMOUT_STATE");
			}
			rs2.close();
			stmt2.close();
			ach_exp =(ach_state + ach_central);
			total_ach_exp += ach_exp;
			
			
			
			 if(no_works==0 && habs==0 && pop==0&& banksendAmount==0.0 && bankpaoAmt==0.0&& new_works==0 && new_pop==0 &&new_habs==0 && fin_works==0 && sanction_amount==0.0&&on_works==0&&ongoing_cost==0.0
					 &&ach_works==0&&ach_pop==0 && ach_exp==0.0){
				}else{ 
			%>
		<tr>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=++slno%></td>
			<%if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_work_load_div_sub_div_rpt.jsp?mode=divisions&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>"><%=cname%></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_work_load_div_sub_div_rpt.jsp?mode=subdivisions&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>"><%=divName%></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: left;" align="left" ><%=subdivName%></td>
			<%} 
			if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=spill&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=no_works %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=spill&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=no_works %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=spill&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=no_works %></a></td>
			<%} 
			if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=spill&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=habs %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=spill&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=habs %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=spill&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=habs %></a></td>
			<%} %>	
		    <td class="<%=style%>" style="text-align: right;" align="right"><%=pop%></td>
		    <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(sanction_amount)%></td>
		    <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format((banksendAmount + bankpaoAmt)/100000)%></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(finalBal/100000)%></td>
		  	<%if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=new&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=new_works %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=new&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=new_works %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=new&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=new_works %></a></td>
			<%} 	
			 if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=new&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=new_habs %></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=new&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=new_habs %></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=new&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=new_habs %></a></td>
			<%}%>			
			<td class="<%=style%>" style="text-align: right;" align="right"><%=new_pop%></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(new_work_amt/100000)%></td>
			<%if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=ongoing&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=on_works%></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=ongoing&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=on_works%></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=ongoing&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=on_works%></a></td>
			<%}%>
			<%if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=ongoing&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=habs+new_habs%></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=ongoing&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=habs+new_habs%></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=ongoing&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=habs+new_habs%></a></td>
			<%}%>			
			<td class="<%=style%>" style="text-align: right;" align="right"><%=pop+new_pop%></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(ongoing_sanction)%></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(exp_ongoing/100000)%></td>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(ongoing_cost/100000)%></td>
			<%if(mode.equals("circles")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=financial&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=fin_works%></a></td>
			<%}else if(mode.equals("divisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=financial&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=fin_works%></a></td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=financial&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=fin_works%></a></td>
			<%}%>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(not_finalBal/100000) %> </td>
			<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format((new_work_amt+finalBal+not_finalBal)/100000) %></td>
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
			<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(ach_exp/100000) %> </td>
		</tr>
		
		<%}}%>
		<tr >
		<td class="btext" style="text-align: right;" colspan="2">Total </td>
		<%-- <%if(mode.equals("circles")){ %>
		<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=spill&programme=<%=programme%>&programmeName=<%=programmeName%>')"><%=tot_no_works%></a></td>
		<%}else if(mode.equals("divisions")){ %>
		<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=spill&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=tot_no_works%></a></td>
		<%}else if(mode.equals("subdivisions")){ %>
		<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=spill&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=tot_no_works%></a></td>
		<%}%>	 --%>
		<td class="btext" style="text-align: right;" align="right"><%=tot_no_works%></td>
		<td class="btext" style="text-align: right;" ><%=tot_habs %> </td>
		<td class="btext" style="text-align: right;" ><%=tot_pop %> </td>
		<td class="btext" style="text-align: right;" ><%=ndf.format(tot_san)%> </td>
		<td class="btext" style="text-align: right;" ><%=ndf.format(tot_exp/100000)%> </td>
		<td class="btext" style="text-align: right;" ><%=ndf.format(tot_fin_amount/100000)%> </td>
	<%-- 	<%if(mode.equals("circles")){%>
		<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=new&programme=<%=programme%>&programmeName=<%=programmeName%>')"><%=tot_new_works %></a></td>
		<%}else if(mode.equals("divisions")){ %>
		<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=new&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=tot_new_works %></a></td>
		<%}else if(mode.equals("subdivisions")){ %>
		<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=new&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=tot_new_works%></a></td>
		<%}%>	 --%>
		<td class="btext" style="text-align: right;" align="right"><%=tot_new_works %></td>
		<td class="btext" style="text-align: right;" ><%=tot_new_habs %> </td>
		<td class="btext" style="text-align: right;" ><%=tot_new_pop %> </td>
		<td class="btext" style="text-align: right;" ><%=ndf.format(tot_new_work_amount/100000)%> </td>
		<%-- <%if(mode.equals("circles")){ %>
		<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=ongoing&programme=<%=programme%>&programmeName=<%=programmeName%>')"><%=tot_on_works%></a></td>
		<%}else if(mode.equals("divisions")){ %>
		<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=ongoing&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=tot_on_works%></a></td>
		<%}else if(mode.equals("subdivisions")){ %>
		<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=ongoing&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=tot_on_works%></a></td>
		<%} %> --%>
		<td class="btext" style="text-align: right;" align="right"><%=tot_on_works%></td>
		<td class="btext" style="text-align: right;" ><%=tot_habs+ tot_new_habs%> </td>
		<td class="btext" style="text-align: right;" ><%=tot_pop+tot_new_pop %> </td>
		<td class="btext" style="text-align: right;" ><%=ndf.format(tot_ongonig_san) %> </td>
		<td class="btext" style="text-align: right;" ><%=ndf.format(tot_exp_ongoing/100000) %> </td>
		<td class="btext" style="text-align: right;" ><%=ndf.format(tot_ongoing/100000) %> </td>
		<%-- <%if(mode.equals("circles")){ %>
		<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=financial&programme=<%=programme%>&programmeName=<%=programmeName%>')"><%=tot_fin_works%></a></td>
		<%}else if(mode.equals("divisions")){ %>
		<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=financial&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=tot_fin_works%></a></td>
		<%}else if(mode.equals("subdivisions")){ %>
		<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_load_drill.jsp?mode=financial&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=tot_fin_works%></a></td>
		<%}%> --%>
		<td class="btext" style="text-align: right;" align="right"><%=tot_fin_works%></td>
		<td class="btext" style="text-align: right;" align="right"><%=ndf.format(tot_not_finalBal/100000) %> </td>
		<td class="btext" style="text-align: right;" align="right"><%=ndf.format((tot_ongoing+tot_not_finalBal)/100000)%> </td>
		<td class="btext" style="text-align: right;" align="right"><%=tot_ach_works%></td>
		<td class="btext" style="text-align: right;" align="right"><%=ach_tot_habs%> </td>
		<td class="btext" style="text-align: right;" align="right"><%=ach_tot_pop%> </td>
		<td class="btext" style="text-align: right;" align="right"><%=ndf.format(total_ach_exp/100000) %> </td>
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