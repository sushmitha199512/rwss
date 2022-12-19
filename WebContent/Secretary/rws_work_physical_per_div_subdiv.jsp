<%@ include file="/reports/conn.jsp"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.util.*"%>
<%@page import="nic.watersoft.works.WorksData1"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
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

		<table  border=0 rules=none width="70%" style="border-collapse:collapse" align = "right">	
			<tr>
				<td style="width: 100px !important; text-align: left !important; "><font color="#889900" face="Maiandra GD" size="2px">Rs. In Lakhs</font></td>
				<td style="width: 100px !important;" align="right"><a href="javascript:history.back(-1)">BACK</a>&nbsp;&nbsp;	</td>
			</tr>
		</table>
<br/></br>
		<table border=1 cellspacing=0 cellpadding=0 height=5% width="70%" bordercolor=#000000 style="border-collapse: collapse" bgcolor="#ffffff" align="center">
				<tr align=center >
				<td class="gridhdbg" colspan="17"><b>Works - Physical Percentage(%) Completion Status for Programme :- <%=programmeName %>
					<%if(mode.equals("divisions")){ %>
						 , Circle :- <%=request.getParameter("cname") %>
						<%}else if(mode.equals("subdivisions")){  %>
						, Circle :- <%=request.getParameter("cname") %>
						 , Division :- <%=request.getParameter("divname") %>
						<%} %>
				</b></td></tr>
				<tr align=center align=center>
					<td class=gridhdbg rowspan=3>Sl.No</td>
					<%if(mode.equals("circles")){ %>
						<td class=gridhdbg rowspan=3>Circle</td>
						<%}else if(mode.equals("divisions")){ %>
						<td class=gridhdbg rowspan=3>Division</td>
						<%}else if(mode.equals("subdivisions")){ %>
						<td class=gridhdbg rowspan=3>Sub Division</td>
						<%} %>
						<td class=gridhdbg colspan=15>Physical % of Works Range</td>
				</tr>
				<tr>
				<td class=gridhdbg colspan=3>100%</td>
				<td class=gridhdbg colspan=3>75 to 100%</td>
				<td class=gridhdbg colspan=3>50 to 75%</td>
				<td class=gridhdbg colspan=3>25 to 50%</td>
				<td class=gridhdbg colspan=3>0 to 25%</td>
				</tr>
				<tr>
				<td class=gridhdbg rowspan=1>No. of Works</td>
				<td class=gridhdbg rowspan=1>Bal Cost 1.4.17</td>
				<td class=gridhdbg rowspan=1>Exp. During 2017-18</td>
				<td class=gridhdbg rowspan=1>No. of Works</td>
				<td class=gridhdbg rowspan=1>Bal Cost 1.4.17</td>
				<td class=gridhdbg rowspan=1>Exp. During 2017-18</td>
				<td class=gridhdbg rowspan=1>No. of Works</td>
				<td class=gridhdbg rowspan=1>Bal Cost 1.4.17</td>
				<td class=gridhdbg rowspan=1>Exp. During 2017-18</td>
				<td class=gridhdbg rowspan=1>No. of Works</td>
				<td class=gridhdbg rowspan=1>Bal Cost 1.4.17</td>
				<td class=gridhdbg rowspan=1>Exp. During 2017-18</td>
				<td class=gridhdbg rowspan=1>No. of Works</td>
				<td class=gridhdbg rowspan=1>Bal Cost 1.4.17</td>
				<td class=gridhdbg rowspan=1>Exp. During 2017-18</td>
				</tr>
				<%
				//String schemes = "'01','02','03','10'";
				int styleCount = 0;
				String style = "";
				int slno=0;	
				Statement stmt1=null,stmt2=null;
				ResultSet rs1=null,rs2=null;
				int comp_works=0,works_75=0,works_50=0,works_25=0,works_00=0,tot_comp_works=0,tot_75_works=0,tot_50_works=0,tot_25_works=0,tot_00_works=0;
				String comp_query="",comp_banksendQuery="",comp_bankpaos="",comp_exp_banksendQuery="",comp_exp_bankpaos="";	
				Double comp_sanction_amount=0.0,comp_bankpaoAmt=0.0,comp_banksendAmount=0.0,comp_bal=0.0,tot_COMP_bal_amount=0.0,tot_comp_exp=0.0,comp_exp_banksendAmount=0.0,comp_exp_bankpaoAmt=0.0;
				String query_75="",banksendQuery_75="",bankpaos_75="",banksendQuery_75_exp="",bankpaos_75_exp="";		
				Double sanction_amount_75=0.0,bankpaoAmt_75=0.0,banksendAmount_75=0.0,bal_75=0.0,tot_75_bal_amount=0.0,tot_75_exp=0.0,bankpaoAmt_75_exp=0.0,banksendAmount_75_exp=0.0;
				String query_50="",banksendQuery_50="",bankpaos_50="",banksendQuery_50_exp="",bankpaos_50_exp="";		
				Double sanction_amount_50=0.0,bankpaoAmt_50=0.0,banksendAmount_50=0.0,bal_50=0.0,tot_50_bal_amount=0.0,tot_50_exp=0.0,bankpaoAmt_50_exp=0.0,banksendAmount_50_exp=0.0;
				String query_25="",banksendQuery_25="",bankpaos_25="",banksendQuery_25_exp="",bankpaos_25_exp="";		
				Double sanction_amount_25=0.0,bankpaoAmt_25=0.0,banksendAmount_25=0.0,bal_25=0.0,tot_25_bal_amount=0.0,tot_25_exp=0.0,bankpaoAmt_25_exp=0.0,banksendAmount_25_exp=0.0;
				String query_00="",banksendQuery_00="",bankpaos_00="",banksendQuery_00_exp="",bankpaos_00_exp="";		
				Double sanction_amount_00=0.0,bankpaoAmt_00=0.0,banksendAmount_00=0.0,bal_00=0.0,tot_00_bal_amount=0.0,tot_00_exp=0.0,bankpaoAmt_00_exp=0.0,banksendAmount_00_exp=0.0;
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
		        
						comp_query = "select sum(a.SANCTION_AMOUNT) as SANCTION_AMOUNT,count(distinct a.work_id) as works from rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_work_completion_tbl comp where a.work_id=comp.work_id and WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE"
								+ " and  c.GROUNDING_DATE is not null AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and m.PERCENT_COMPLETED =100"
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme
								+ ") and  comp.DATE_OF_COMPLETION is not null and comp.DT_FIN_COMPLETION is null and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id";
						if(mode.equals("circles")){ 
							comp_query+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
						}
						else if(mode.equals("divisions")){
							comp_query+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
						}
						else if(mode.equals("subdivisions")){
							comp_query+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
						}
						//System.out.println("comp query"+comp_query);	
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(comp_query);
						if(rs1.next())
						{
						  comp_sanction_amount=rs1.getDouble("SANCTION_AMOUNT");
						  comp_works=rs1.getInt("works");
					   	}
						tot_comp_works+=comp_works;
						rs1.close();
						stmt1.close();
					 	comp_banksendQuery= "select sum(b.BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_work_completion_tbl comp where a.work_id=comp.work_id and WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE"
								+ " and a.work_id=b.work_id and  c.GROUNDING_DATE is not null AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and BANK_SEND_DATE>='01-APR-"+yearStart+"' and m.PERCENT_COMPLETED =100"
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme
								+ ") and  comp.DATE_OF_COMPLETION is not null and comp.DT_FIN_COMPLETION is null and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id ";				
					 	if(mode.equals("circles")){ 
					 		comp_banksendQuery+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
						}
						else if(mode.equals("divisions")){
							comp_banksendQuery+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
						}
						else if(mode.equals("subdivisions")){
							comp_banksendQuery+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
						}
						//System.out.println("_comp banksendQuery"+comp_banksendQuery)	;	
						stmt2 = conn.createStatement();
						rs2 = stmt2.executeQuery(comp_banksendQuery);
						while(rs2.next()){
							comp_banksendAmount=rs2.getDouble("BILL_AMOUNT_CENTRAL");
						}
						rs2.close();
						stmt2.close();
						comp_bankpaos= "select sum(b.BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_work_completion_tbl comp where a.work_id=comp.work_id and WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE"
								+ " and a.work_id=b.work_id and  c.GROUNDING_DATE is not null AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and STATE_SEND_DATE>='01-APR-"+yearStart+"' and m.PERCENT_COMPLETED =100"
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme
								+ ") and  comp.DATE_OF_COMPLETION is not null and comp.DT_FIN_COMPLETION is null and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id ";
						if(mode.equals("circles")){ 
							comp_bankpaos+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
						}
						else if(mode.equals("divisions")){
							comp_bankpaos+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
						}
						else if(mode.equals("subdivisions")){
							comp_bankpaos+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
						}
						//System.out.println("comp bankpaos"+comp_bankpaos)	;	
						stmt2 = conn.createStatement();
						rs2 = stmt2.executeQuery(comp_bankpaos);
						if(rs2.next()){
							comp_bankpaoAmt=rs2.getDouble("BILL_AMOUT_STATE");
						}
						rs2.close();
						stmt2.close();
						tot_comp_exp+=comp_banksendAmount + comp_bankpaoAmt;
						comp_exp_banksendQuery= "select sum(b.BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_work_completion_tbl comp where a.work_id=comp.work_id and WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE"
								+ " and a.work_id=b.work_id and  c.GROUNDING_DATE is not null AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and m.PERCENT_COMPLETED =100 "
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme
								+ ") and  comp.DATE_OF_COMPLETION is not null and comp.DT_FIN_COMPLETION is null and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id ";
						if(mode.equals("circles")){ 
							comp_exp_banksendQuery+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
						}
						else if(mode.equals("divisions")){
							comp_exp_banksendQuery+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
						}
						else if(mode.equals("subdivisions")){
							comp_exp_banksendQuery+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
						}		
						//System.out.println("_comp banksendQuery"+comp_exp_banksendQuery)	;	
						stmt2 = conn.createStatement();
						rs2 = stmt2.executeQuery(comp_exp_banksendQuery);
						while(rs2.next()){
							comp_exp_banksendAmount=rs2.getDouble("BILL_AMOUNT_CENTRAL");
						}
						rs2.close();
						stmt2.close();
						comp_exp_bankpaos= "select sum(b.BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_work_completion_tbl comp where a.work_id=comp.work_id and WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE"
								+ " and a.work_id=b.work_id and  c.GROUNDING_DATE is not null AND TARGET_DATE_COMP>='01-APR-"+yearStart+"'and m.PERCENT_COMPLETED =100  "
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme
								+ ") and  comp.DATE_OF_COMPLETION is not null and comp.DT_FIN_COMPLETION is null and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id ";
						if(mode.equals("circles")){ 
							comp_exp_bankpaos+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
						}
						else if(mode.equals("divisions")){
							comp_exp_bankpaos+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
						}
						else if(mode.equals("subdivisions")){
							comp_exp_bankpaos+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
						}	
						//System.out.println("comp bankpaos"+comp_exp_bankpaos)	;	
						stmt2 = conn.createStatement();
						rs2 = stmt2.executeQuery(comp_exp_bankpaos);
						if(rs2.next()){
							comp_exp_bankpaoAmt=rs2.getDouble("BILL_AMOUT_STATE");
						}
						rs2.close();
						stmt2.close();
						comp_bal=(comp_sanction_amount*100000)-(comp_exp_banksendAmount + comp_exp_bankpaoAmt);
						tot_COMP_bal_amount+=comp_bal;					
						query_75 = "select sum(a.SANCTION_AMOUNT) as SANCTION_AMOUNT,count(distinct a.work_id) as works from rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where  WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE"
								+ " and  c.GROUNDING_DATE is not null AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and m.PERCENT_COMPLETED between 76 and 100"
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme
								+ ") and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id"
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)";	
						if(mode.equals("circles")){ 
							query_75+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
						}
						else if(mode.equals("divisions")){
							query_75+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
						}
						else if(mode.equals("subdivisions")){
							query_75+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
						}
						//System.out.println("75 query"+query_75);	
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(query_75);
						if(rs1.next())
						{
						  sanction_amount_75=rs1.getDouble("SANCTION_AMOUNT");
						  works_75=rs1.getInt("works");
					   	}
						tot_75_works+=works_75;
						rs1.close();
						stmt1.close();
					 	banksendQuery_75= "select sum(b.BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE"
								+ " and a.work_id=b.work_id and  c.GROUNDING_DATE is not null AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and BANK_SEND_DATE>='01-APR-"+yearStart+"' and m.PERCENT_COMPLETED between 76 and 100"
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme
								+ ") and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id "
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)";	
					 	if(mode.equals("circles")){ 
					 		banksendQuery_75+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
						}
						else if(mode.equals("divisions")){
							banksendQuery_75+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
						}
						else if(mode.equals("subdivisions")){
							banksendQuery_75+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
						}
						//System.out.println("75 banksendQuery"+banksendQuery_75)	;	
						stmt2 = conn.createStatement();
						rs2 = stmt2.executeQuery(banksendQuery_75);
						while(rs2.next()){
							banksendAmount_75=rs2.getDouble("BILL_AMOUNT_CENTRAL");
						}
						rs2.close();
						stmt2.close();
						bankpaos_75= "select sum(b.BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE"
								+ " and a.work_id=b.work_id and  c.GROUNDING_DATE is not null AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and STATE_SEND_DATE>='01-APR-"+yearStart+"' and m.PERCENT_COMPLETED between 76 and 100"
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme
								+ ") and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id "
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)";
						if(mode.equals("circles")){ 
							bankpaos_75+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
						}
						else if(mode.equals("divisions")){
							bankpaos_75+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
						}
						else if(mode.equals("subdivisions")){
							bankpaos_75+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
						}
						//System.out.println("75 bankpaos"+bankpaos_75)	;	
						stmt2 = conn.createStatement();
						rs2 = stmt2.executeQuery(bankpaos_75);
						if(rs2.next()){
							bankpaoAmt_75=rs2.getDouble("BILL_AMOUT_STATE");
						}
						rs2.close();
						stmt2.close();
						tot_75_exp+=banksendAmount_75 + bankpaoAmt_75;			
						banksendQuery_75_exp= "select sum(b.BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE"
								+ " and a.work_id=b.work_id and  c.GROUNDING_DATE is not null AND TARGET_DATE_COMP>='01-APR-"+yearStart+"'  and m.PERCENT_COMPLETED between 76 and 100"
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme
								+ ") and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id "
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)";	
						if(mode.equals("circles")){ 
							banksendQuery_75_exp+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
						}
						else if(mode.equals("divisions")){
							banksendQuery_75_exp+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
						}
						else if(mode.equals("subdivisions")){
							banksendQuery_75_exp+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
						}
						//System.out.println("75 banksendQuery"+banksendQuery_75_exp)	;	
						stmt2 = conn.createStatement();
						rs2 = stmt2.executeQuery(banksendQuery_75_exp);
						while(rs2.next()){
							banksendAmount_75_exp=rs2.getDouble("BILL_AMOUNT_CENTRAL");
						}
						rs2.close();
						stmt2.close();
						bankpaos_75_exp= "select sum(b.BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE"
								+ " and a.work_id=b.work_id and  c.GROUNDING_DATE is not null AND TARGET_DATE_COMP>='01-APR-"+yearStart+"'  and m.PERCENT_COMPLETED between 76 and 100"
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme
								+ ") and   i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id "
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)";
						if(mode.equals("circles")){ 
							bankpaos_75_exp+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
						}
						else if(mode.equals("divisions")){
							bankpaos_75_exp+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
						}
						else if(mode.equals("subdivisions")){
							bankpaos_75_exp+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
						}
										
						//System.out.println("75 bankpaos"+bankpaos_75_exp)	;	
						stmt2 = conn.createStatement();
						rs2 = stmt2.executeQuery(bankpaos_75_exp);
						if(rs2.next()){
							bankpaoAmt_75_exp=rs2.getDouble("BILL_AMOUT_STATE");
						}
						rs2.close();
						stmt2.close();
						bal_75=(sanction_amount_75*100000)-(banksendAmount_75_exp +bankpaoAmt_75_exp);
						tot_75_bal_amount+=bal_75;
						query_50 = "select sum(a.SANCTION_AMOUNT) as SANCTION_AMOUNT,count(distinct a.work_id) as works from rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where  WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE"
								+ " and  c.GROUNDING_DATE is not null AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and m.PERCENT_COMPLETED between 51 and 75"
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme
								+ ") and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id"
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)";	
						if(mode.equals("circles")){ 
							query_50+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
						}
						else if(mode.equals("divisions")){
							query_50+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
						}
						else if(mode.equals("subdivisions")){
							query_50+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
						}
						//System.out.println("50 query"+query_50);	
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(query_50);
						if(rs1.next())
						{
						  sanction_amount_50=rs1.getDouble("SANCTION_AMOUNT");
						  works_50=rs1.getInt("works");
					   	}
						tot_50_works+=works_50;
						rs1.close();
						stmt1.close();
					 	banksendQuery_50= "select sum(b.BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE"
								+ " and a.work_id=b.work_id and  c.GROUNDING_DATE is not null AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and BANK_SEND_DATE>='01-APR-"+yearStart+"' and m.PERCENT_COMPLETED between 51 and 75"
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme
								+ ") and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id "
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)";	
					 	if(mode.equals("circles")){ 
					 		banksendQuery_50+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
						}
						else if(mode.equals("divisions")){
							banksendQuery_50+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
						}
						else if(mode.equals("subdivisions")){
							banksendQuery_50+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
						}
						//System.out.println("50 banksendQuery"+banksendQuery_50)	;	
						stmt2 = conn.createStatement();
						rs2 = stmt2.executeQuery(banksendQuery_50);
						while(rs2.next()){
							banksendAmount_50=rs2.getDouble("BILL_AMOUNT_CENTRAL");
						}
						rs2.close();
						stmt2.close();
						bankpaos_50= "select sum(b.BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE"
								+ " and a.work_id=b.work_id and  c.GROUNDING_DATE is not null AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and STATE_SEND_DATE>='01-APR-"+yearStart+"' and m.PERCENT_COMPLETED between 51 and 75"
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme
								+ ") and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id "
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)";
						if(mode.equals("circles")){ 
							bankpaos_50+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
						}
						else if(mode.equals("divisions")){
							bankpaos_50+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
						}
						else if(mode.equals("subdivisions")){
							bankpaos_50+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
						}
						//System.out.println("50 bankpaos"+bankpaos_50)	;	
						stmt2 = conn.createStatement();
						rs2 = stmt2.executeQuery(bankpaos_50);
						if(rs2.next()){
							bankpaoAmt_50=rs2.getDouble("BILL_AMOUT_STATE");
						}
						rs2.close();
						stmt2.close();
						tot_50_exp+=banksendAmount_50 + bankpaoAmt_50;			
						banksendQuery_50_exp= "select sum(b.BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE"
								+ " and a.work_id=b.work_id and  c.GROUNDING_DATE is not null AND TARGET_DATE_COMP>='01-APR-"+yearStart+"'  and m.PERCENT_COMPLETED between 51 and 75"
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme
								+ ") and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id "
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)";	
						if(mode.equals("circles")){ 
							banksendQuery_50_exp+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
						}
						else if(mode.equals("divisions")){
							banksendQuery_50_exp+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
						}
						else if(mode.equals("subdivisions")){
							banksendQuery_50_exp+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
						}
						//System.out.println("50 banksendQuery"+banksendQuery_50_exp)	;	
						stmt2 = conn.createStatement();
						rs2 = stmt2.executeQuery(banksendQuery_50_exp);
						while(rs2.next()){
							banksendAmount_50_exp=rs2.getDouble("BILL_AMOUNT_CENTRAL");
						}
						rs2.close();
						stmt2.close();
						bankpaos_50_exp= "select sum(b.BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE"
								+ " and a.work_id=b.work_id and  c.GROUNDING_DATE is not null AND TARGET_DATE_COMP>='01-APR-"+yearStart+"'  and m.PERCENT_COMPLETED between 51 and 75"
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme
								+ ") and   i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id "
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)";
						if(mode.equals("circles")){ 
							bankpaos_50_exp+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
						}
						else if(mode.equals("divisions")){
							bankpaos_50_exp+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
						}
						else if(mode.equals("subdivisions")){
							bankpaos_50_exp+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
						}
						//System.out.println("50 bankpaos"+bankpaos_50_exp)	;	
						stmt2 = conn.createStatement();
						rs2 = stmt2.executeQuery(bankpaos_50_exp);
						if(rs2.next()){
							bankpaoAmt_50_exp=rs2.getDouble("BILL_AMOUT_STATE");
						}
						rs2.close();
						stmt2.close();
						bal_50=(sanction_amount_50*100000)-(banksendAmount_50_exp +bankpaoAmt_50_exp);
						tot_50_bal_amount+=bal_50;
						query_25 = "select sum(a.SANCTION_AMOUNT) as SANCTION_AMOUNT,count(distinct a.work_id) as works from rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where  WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE"
								+ " and  c.GROUNDING_DATE is not null AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and m.PERCENT_COMPLETED between 26 and 50"
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme
								+ ") and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id"
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)";
						if(mode.equals("circles")){ 
							query_25+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
						}
						else if(mode.equals("divisions")){
							query_25+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
						}
						else if(mode.equals("subdivisions")){
							query_25+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
						}
						//System.out.println("25 query"+query_25);	
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(query_25);
						if(rs1.next())
						{
						  sanction_amount_25=rs1.getDouble("SANCTION_AMOUNT");
						  works_25=rs1.getInt("works");
					   	}
						tot_25_works+=works_25;
						rs1.close();
						stmt1.close();
					 	banksendQuery_25= "select sum(b.BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE"
								+ " and a.work_id=b.work_id and  c.GROUNDING_DATE is not null AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and BANK_SEND_DATE>='01-APR-"+yearStart+"' and m.PERCENT_COMPLETED between 26 and 50"
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme
								+ ") and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id "
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)";
					 	if(mode.equals("circles")){ 
					 		banksendQuery_25+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
						}
						else if(mode.equals("divisions")){
							banksendQuery_25+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
						}
						else if(mode.equals("subdivisions")){
							banksendQuery_25+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
						}
						//System.out.println("25 banksendQuery"+banksendQuery_25)	;	
						stmt2 = conn.createStatement();
						rs2 = stmt2.executeQuery(banksendQuery_25);
						while(rs2.next()){
							banksendAmount_25=rs2.getDouble("BILL_AMOUNT_CENTRAL");
						}
						rs2.close();
						stmt2.close();
						bankpaos_25= "select sum(b.BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE"
								+ " and a.work_id=b.work_id and  c.GROUNDING_DATE is not null AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and STATE_SEND_DATE>='01-APR-"+yearStart+"' and m.PERCENT_COMPLETED between 26 and 50"
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme
								+ ") and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id "
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)";
						if(mode.equals("circles")){ 
							bankpaos_25+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
						}
						else if(mode.equals("divisions")){
							bankpaos_25+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
						}
						else if(mode.equals("subdivisions")){
							bankpaos_25+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
						}
						//System.out.println("25 bankpaos"+bankpaos_25)	;	
						stmt2 = conn.createStatement();
						rs2 = stmt2.executeQuery(bankpaos_25);
						if(rs2.next()){
							bankpaoAmt_25=rs2.getDouble("BILL_AMOUT_STATE");
						}
						rs2.close();
						stmt2.close();
						tot_25_exp+=banksendAmount_25 + bankpaoAmt_25;			
						banksendQuery_25_exp= "select sum(b.BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE"
								+ " and a.work_id=b.work_id and  c.GROUNDING_DATE is not null AND TARGET_DATE_COMP>='01-APR-"+yearStart+"'  and m.PERCENT_COMPLETED between 26 and 50"
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme
								+ ") and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id "
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)";	
						if(mode.equals("circles")){ 
							banksendQuery_25_exp+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
						}
						else if(mode.equals("divisions")){
							banksendQuery_25_exp+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
						}
						else if(mode.equals("subdivisions")){
							banksendQuery_25_exp+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
						}
						//System.out.println("25 banksendQuery"+banksendQuery_25_exp)	;	
						stmt2 = conn.createStatement();
						rs2 = stmt2.executeQuery(banksendQuery_25_exp);
						while(rs2.next()){
							banksendAmount_25_exp=rs2.getDouble("BILL_AMOUNT_CENTRAL");
						}
						rs2.close();
						stmt2.close();
						bankpaos_25_exp= "select sum(b.BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE"
								+ " and a.work_id=b.work_id and  c.GROUNDING_DATE is not null AND TARGET_DATE_COMP>='01-APR-"+yearStart+"'  and m.PERCENT_COMPLETED between 26 and 50"
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme
								+ ") and   i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id "
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)";
						if(mode.equals("circles")){ 
							bankpaos_25_exp+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
						}
						else if(mode.equals("divisions")){
							bankpaos_25_exp+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
						}
						else if(mode.equals("subdivisions")){
							bankpaos_25_exp+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
						}
						//System.out.println("25 bankpaos"+bankpaos_25_exp)	;	
						stmt2 = conn.createStatement();
						rs2 = stmt2.executeQuery(bankpaos_25_exp);
						if(rs2.next()){
							bankpaoAmt_25_exp=rs2.getDouble("BILL_AMOUT_STATE");
						}
						rs2.close();
						stmt2.close();
						bal_25=(sanction_amount_25*100000)-(banksendAmount_25_exp +bankpaoAmt_25_exp);
						tot_25_bal_amount+=bal_25;
						query_00 = "select sum(a.SANCTION_AMOUNT) as SANCTION_AMOUNT,count(distinct a.work_id) as works from rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where  WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE"
								+ " and  c.GROUNDING_DATE is not null AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and m.PERCENT_COMPLETED between 0 and 25"
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme
								+ ") and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id"
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)";
						if(mode.equals("circles")){ 
							query_00+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
						}
						else if(mode.equals("divisions")){
							query_00+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
						}
						else if(mode.equals("subdivisions")){
							query_00+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
						}
						//System.out.println("00 query"+query_00);	
						stmt1 = conn.createStatement();
						rs1 = stmt1.executeQuery(query_00);
						if(rs1.next())
						{
						  sanction_amount_00=rs1.getDouble("SANCTION_AMOUNT");
						  works_00=rs1.getInt("works");
					   	}
						tot_00_works+=works_00;
						rs1.close();
						stmt1.close();
					 	banksendQuery_00= "select sum(b.BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE"
								+ " and a.work_id=b.work_id and  c.GROUNDING_DATE is not null AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and BANK_SEND_DATE>='01-APR-"+yearStart+"' and m.PERCENT_COMPLETED between 0 and 25"
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme
								+ ") and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id "
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)";
					 	if(mode.equals("circles")){ 
					 		banksendQuery_00+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
						}
						else if(mode.equals("divisions")){
							banksendQuery_00+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
						}
						else if(mode.equals("subdivisions")){
							banksendQuery_00+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
						}
						//System.out.println("00 banksendQuery"+banksendQuery_00)	;	
						stmt2 = conn.createStatement();
						rs2 = stmt2.executeQuery(banksendQuery_00);
						while(rs2.next()){
							banksendAmount_00=rs2.getDouble("BILL_AMOUNT_CENTRAL");
						}
						rs2.close();
						stmt2.close();
						bankpaos_00= "select sum(b.BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE"
								+ " and a.work_id=b.work_id and  c.GROUNDING_DATE is not null AND TARGET_DATE_COMP>='01-APR-"+yearStart+"' and STATE_SEND_DATE>='01-APR-"+yearStart+"' and m.PERCENT_COMPLETED between 0 and 25"
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme
								+ ") and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id "
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)";
						if(mode.equals("circles")){ 
							bankpaos_00+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
						}
						else if(mode.equals("divisions")){
							bankpaos_00+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
						}
						else if(mode.equals("subdivisions")){
							bankpaos_00+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
						}
						//System.out.println("00 bankpaos"+bankpaos_00)	;	
						stmt2 = conn.createStatement();
						rs2 = stmt2.executeQuery(bankpaos_00);
						if(rs2.next()){
							bankpaoAmt_00=rs2.getDouble("BILL_AMOUT_STATE");
						}
						rs2.close();
						stmt2.close();
						tot_00_exp+=banksendAmount_00 + bankpaoAmt_00;			
						banksendQuery_00_exp= "select sum(b.BILL_AMOUNT_CENTRAL) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE"
								+ " and a.work_id=b.work_id and  c.GROUNDING_DATE is not null AND TARGET_DATE_COMP>='01-APR-"+yearStart+"'  and m.PERCENT_COMPLETED between 0 and 25"
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme
								+ ") and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id "
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)";
						if(mode.equals("circles")){ 
							banksendQuery_00_exp+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
						}
						else if(mode.equals("divisions")){
							banksendQuery_00_exp+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
						}
						else if(mode.equals("subdivisions")){
							banksendQuery_00_exp+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
						}
						//System.out.println("00 banksendQuery"+banksendQuery_00_exp)	;	
						stmt2 = conn.createStatement();
						rs2 = stmt2.executeQuery(banksendQuery_00_exp);
						while(rs2.next()){
							banksendAmount_00_exp=rs2.getDouble("BILL_AMOUNT_CENTRAL");
						}
						rs2.close();
						stmt2.close();
						bankpaos_00_exp= "select sum(b.BILL_AMOUT_STATE) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE"
								+ " and a.work_id=b.work_id and  c.GROUNDING_DATE is not null AND TARGET_DATE_COMP>='01-APR-"+yearStart+"'  and m.PERCENT_COMPLETED between 0 and 25"
								+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme
								+ ") and   i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id "
								+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)";
						if(mode.equals("circles")){ 
							bankpaos_00_exp+=  " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
						}
						else if(mode.equals("divisions")){
							bankpaos_00_exp+= " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
						}
						else if(mode.equals("subdivisions")){
							bankpaos_00_exp+=" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
						}									
						//System.out.println("00 bankpaos"+bankpaos_00_exp)	;	
						stmt2 = conn.createStatement();
						rs2 = stmt2.executeQuery(bankpaos_00_exp);
						if(rs2.next()){
							bankpaoAmt_00_exp=rs2.getDouble("BILL_AMOUT_STATE");
						}
						rs2.close();
						stmt2.close();
						bal_00=(sanction_amount_00*100000)-(banksendAmount_00_exp +bankpaoAmt_00_exp);
						tot_00_bal_amount+=bal_00;
						
						if(comp_works==0.0&&comp_bal==0.0&&comp_banksendAmount==0.0&&comp_bankpaoAmt==0.0&&
								works_75==0.0&&bal_75==0.0&&banksendAmount_75==0.0&&bankpaoAmt_75==0.0&&
								works_50==0.0&&bal_50==0.0&&banksendAmount_50==0.0&&bankpaoAmt_50==0.0&&
								works_25==0.0&&bal_25==0.0&&banksendAmount_25==0.0&&bankpaoAmt_25==0.0&&
								works_00==0.0&&bal_00==0.0&&banksendAmount_00==0.0&&bankpaoAmt_00==0.0
							){
							
						}else{
								%>
								<tr>
				
					<td class="<%=style%>" style="text-align: right;" align="right"><%=++slno%></td>
					<%if(mode.equals("circles")){ %>
					<td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_work_physical_per_div_subdiv.jsp?mode=divisions&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>"><%=cname%></a></td>
					<%}else if(mode.equals("divisions")){ %>
					<td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_work_physical_per_div_subdiv.jsp?mode=subdivisions&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>"><%=divName%></a></td>
					<%}else if(mode.equals("subdivisions")){ %>
					<td class="<%=style%>" style="text-align: left;" align="left" ><%=subdivName%></td>
					<%} 	
					if(mode.equals("circles")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_phy_per_sec_work_drill.jsp?mode=100per&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=comp_works%></a></td>
					<%}else if(mode.equals("divisions")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_phy_per_sec_work_drill.jsp?mode=100per&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=comp_works%></a></td>
					<%}else if(mode.equals("subdivisions")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_phy_per_sec_work_drill.jsp?mode=100per&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=comp_works%></a></td>
					<%}%>
					<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(comp_bal/100000)%></td>
					<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format((comp_banksendAmount + comp_bankpaoAmt)/100000)%></td>
					<% if(mode.equals("circles")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_phy_per_sec_work_drill.jsp?mode=75per&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=works_75%></a></td>
					<%}else if(mode.equals("divisions")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_phy_per_sec_work_drill.jsp?mode=75per&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=works_75%></a></td>
					<%}else if(mode.equals("subdivisions")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_phy_per_sec_work_drill.jsp?mode=75per&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=works_75%></a></td>
					<%}%>
					<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(bal_75/100000)%></td>
					<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format((banksendAmount_75 + bankpaoAmt_75)/100000)%></td>
					<% if(mode.equals("circles")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_phy_per_sec_work_drill.jsp?mode=50per&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=works_50%></a></td>
					<%}else if(mode.equals("divisions")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_phy_per_sec_work_drill.jsp?mode=50per&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=works_50%></a></td>
					<%}else if(mode.equals("subdivisions")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_phy_per_sec_work_drill.jsp?mode=50per&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=works_50%></a></td>
					<%}%>
					<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(bal_50/100000)%></td>
					<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format((banksendAmount_50 + bankpaoAmt_50)/100000)%></td>
					<% if(mode.equals("circles")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_phy_per_sec_work_drill.jsp?mode=25per&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=works_25%></a></td>
					<%}else if(mode.equals("divisions")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_phy_per_sec_work_drill.jsp?mode=25per&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=works_25%></a></td>
					<%}else if(mode.equals("subdivisions")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_phy_per_sec_work_drill.jsp?mode=25per&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=works_25%></a></td>
					<%}%>
					<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(bal_25/100000)%></td>
					<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format((banksendAmount_25 + bankpaoAmt_25)/100000)%></td>
					<% if(mode.equals("circles")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_phy_per_sec_work_drill.jsp?mode=0per&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>')"><%=works_00%></a></td>
					<%}else if(mode.equals("divisions")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_phy_per_sec_work_drill.jsp?mode=0per&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>')"><%=works_00%></a></td>
					<%}else if(mode.equals("subdivisions")){ %>
					<td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_phy_per_sec_work_drill.jsp?mode=0per&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&subdivcode=<%=subdivCode%>&subdivname=<%=subdivName%>')"><%=works_00%></a></td>
					<%}%>
					<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(bal_00/100000)%></td>
					<td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format((banksendAmount_00 + bankpaoAmt_00)/100000)%></td>
					
				</tr>
				<%}}%>
				<tr>
				<td class="btext" style="text-align: right;" colspan="2">Total </td>
					<td class="btext" style="text-align: right;" align="right"><%=tot_comp_works %> </td>
					<td class="btext" style="text-align: right;" ><%=ndf.format(tot_COMP_bal_amount/100000)%> </td>
					<td class="btext" style="text-align: right;" ><%=ndf.format(tot_comp_exp/100000) %> </td>
					<td class="btext" style="text-align: right;" align="right"><%=tot_75_works %> </td>
					<td class="btext" style="text-align: right;" ><%=ndf.format(tot_75_bal_amount/100000)%> </td>
					<td class="btext" style="text-align: right;" ><%=ndf.format(tot_75_exp/100000) %> </td>
					<td class="btext" style="text-align: right;" align="right"><%=tot_50_works %> </td>
					<td class="btext" style="text-align: right;" ><%=ndf.format(tot_50_bal_amount/100000)%> </td>
					<td class="btext" style="text-align: right;" ><%=ndf.format(tot_50_exp/100000) %> </td>
					<td class="btext" style="text-align: right;" align="right"><%=tot_25_works %> </td>
					<td class="btext" style="text-align: right;" ><%=ndf.format(tot_25_bal_amount/100000)%> </td>
					<td class="btext" style="text-align: right;" ><%=ndf.format(tot_25_exp/100000) %> </td>
					<td class="btext" style="text-align: right;" align="right"><%=tot_00_works %> </td>
					<td class="btext" style="text-align: right;" ><%=ndf.format(tot_00_bal_amount/100000)%> </td>
					<td class="btext" style="text-align: right;" ><%=ndf.format(tot_00_exp/100000) %> </td>
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
		<table>
		  <tr>
					<td>
					<font color="green" size="2">Note:</font>					
					</td>
					</tr>
					<tr>
					<td>
					<font color="red" size="1">1. 100% --> Physical % of works equal to 100 and work should be complted </font>
					</td>
					</tr>
					<tr>
					<td>
					<font color="red" size="1">2. 75-100% --> Physical % of works >= 75 and < 100</font>
					</td>
					</tr>
					<tr>
					<td>
					<font color="red" size="1">3. 50-75% --> Physical % of works >= 50 and < 75</font>
					</td>
					</tr>
					<tr>
					<td>
					<font color="red" size="1">4. 25-50% --> Physical % of works >= 25 and < 50</font>
					</td>
					</tr>
					<tr>
					<td>
					<font color="red" size="1">5. 0-25% --> Physical % of works  < 25</font>
					</td>
					</tr>
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