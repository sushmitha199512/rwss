<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.util.*"%>
<%@page import="nic.watersoft.works.WorksData1"%>
<%
String schemes = request.getParameter("schemes");
//String schemes = "01,02,03";
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
int yearStart =0;
int yearEnd = 0;
yearStart=Integer.parseInt( request.getParameter("yearStart"));
yearEnd=Integer.parseInt(request.getParameter("yearEnd"));
/* if (month <= 3) {
	yearStart = cyear - 1;
	yearEnd = cyear;
} else {
	yearStart = cyear;
	yearEnd = cyear + 1;
} */
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
			<font color="#663899" face="Maiandra GD" size="4px"><b>ABSTRACT REPORT - WEEKLY REVIEW BY HON'BLE CHIEF SECRETARY WITH DISTRICT COLLECTORS</b></font></br><font color="#889900" face="Maiandra GD" size="3px"  > Programme :- <%=programmeName %>
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
		 	 	<td class=btext rowspan=2>Scheme-No. of<br/>Works</td>
                <td class=btext rowspan=2>Est. Cost</td>
                <td class=btext rowspan=2> Exp. Up to 31.03.<%=yearStart %></td>
                <td class=btext align="center" rowspan=2>Works<br/>Not<br/>Grounded</td>
                <td class=btext align="center" rowspan=2>Works<br/>Comp.</td>
                <td class=btext align="center" rowspan=2>Works<br/>Commissioned</td>
                <td class=btext align="center" colspan=5> Under Progress(%)</td>
                <td class=btext align="center" colspan=3> Payments Made</td>
                <td class=btext align="center" rowspan=2> Payments During (<%=yearStart %> - <%=yearEnd %>)</td>
          </tr>      
          <tr>
           	<td class=btext >0-25</td>
           	<td class=btext >25-50&nbsp;</td>
           	<td class=btext >50-75&nbsp;</td>
           	<td class=btext >75-100&nbsp;</td>
           	<td class=btext >Total</td>
           	<td class=btext >Value of Work done</td>
           	<td class=btext >Paid</td>
            <td class=btext >To be Paid</td>
          </tr>      
		<%
      			int styleCount = 0;
      				String style = "";
      				 Connection connection = null;
      		         Statement stmt1 = null;
      		         ResultSet rs1 = null;
      		         int slno = 0;
      		         Statement stmt2=null;
      		 		 ResultSet rs2=null;        
      		 		 int totNoOfWorks = 0,  totWorksComp = 0, totWorksNotGround=0,totWorksUnderProgress=0,totWorksUnderProgress25=0,totWorksUnderProgress50=0,totWorksUnderProgress75=0,totWorksUnderProgress100=0,totWorksComm=0;
      		         long totPopBenf = 0, totPopCov = 0, popBenf = 0, popCov = 0, nrdwpPopBenf = 0, nrdwpPopCov = 0;
      		         double totEstCost = 0, totAmountLFI=0,totTotExp=0,totToBePaid=0,totValueOfWork=0,totTotPaymentsMade=0;
      		        String query = "";
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
      		        	  double estCost = 0, bankYear = 0, paoYear = 0,bankLastYear=0,paoLastYear=0,amountLFI=0;
      		              int noOfWorks= 0,worksComp = 0, worksNotGround=0,worksUnderProgress=0,worksComm=0,worksUnderProgress25=0,worksUnderProgress50=0,worksUnderProgress75=0,worksUnderProgress100=0;
      		         
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
      				
      				   query = "select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"
      		                           + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
      		                           + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
      		                           + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
      		                           + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' ";
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
      			 noOfWorks = rs1.getInt(2);
      		             estCost = rs1.getDouble(1);
      			    }
      				
      				rs1.close();
      				stmt1.close();
      				
      				 String Not_Grounded_Query="select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a,rws_programme_tbl p where a.work_id not in "
      				   +"(select work_id from RWS_WORK_COMMENCEMENT_TBL where GROUNDING_DATE is not null ) and a.work_id not in " 
      		            +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)  " 
      		            +"and WORK_CANCEL_DT is null and a.programme_code=p.PROGRAMME_CODE and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y'  and  "
      		            +"  a.PROGRAMME_CODE in ("+programme+") and TO_DATE(TARGET_DATE_COMP)>='01-APR-"+ yearStart+"' "
      		            +" and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') ";
      				 if(mode.equals("circles")){ 
      				 Not_Grounded_Query = Not_Grounded_Query+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'"; 
      				}else if(mode.equals("divisions")){
      			Not_Grounded_Query = Not_Grounded_Query+ " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'"; 		
      				}else if(mode.equals("subdivisions")){
      			Not_Grounded_Query= Not_Grounded_Query+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
      				}
      		      stmt1 = conn.createStatement();
      		      rs1 = stmt1.executeQuery(Not_Grounded_Query);
      		      if (rs1.next()) {
      		        worksNotGround = rs1.getInt(1);    
      		      }
      		      stmt1.close();
      		      rs1.close();                                                                                                                                                                       
      				
      		        String underProgressWorks = "";
      		        underProgressWorks = "select count(distinct a.work_id),sum(case when PERCENT_COMPLETED is null or PERCENT_COMPLETED<=25 then 1 else 0 end) as under25,"
      		        		+ "sum(case when PERCENT_COMPLETED>25 and PERCENT_COMPLETED<=50 then 1 else 0 end) as under50,sum(case when PERCENT_COMPLETED>50 and PERCENT_COMPLETED<=75 then 1 else 0 end) as under75,sum(case when PERCENT_COMPLETED>75 and PERCENT_COMPLETED<=100 then 1 else 0 end) as under100 from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_new_est_tbl t ,"
      		                + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
      		                + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) "
      		                + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id and t.work_id=a.work_id "
      		                + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' ";
      		        if(mode.equals("circles")){ 
      		        	underProgressWorks = underProgressWorks+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'"; 
      				}else if(mode.equals("divisions")){
      			underProgressWorks = underProgressWorks+ " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'"; 		
      				}else if(mode.equals("subdivisions")){
      			underProgressWorks= underProgressWorks+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
      				}
      		        stmt1 = conn.createStatement();
      		        rs1 = stmt1.executeQuery(underProgressWorks);
      		        if (rs1.next()) {
      		          worksUnderProgress = rs1.getInt(1);    
      		          worksUnderProgress25 = rs1.getInt("under25");  
      		          worksUnderProgress50 = rs1.getInt("under50");  
      		          worksUnderProgress75 = rs1.getInt("under75");  
      		          worksUnderProgress100 = rs1.getInt("under100");
      		        }
      		        stmt1.close();
      		        rs1.close();
      				
      				String compWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
      		                + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
      		                + " a.programme_code in (" + programme + ")   and TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMPLETION)<='31-MAR-" + yearEnd + "'  and b.DATE_OF_COMPLETION is not null and "
      		                + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
      				if(mode.equals("circles")){ 
      			compWorks = compWorks+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'"; 
      				}else if(mode.equals("divisions")){
      			compWorks = compWorks+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
      				}else if(mode.equals("subdivisions")){
      			compWorks = compWorks+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'"; 
      				}
      				//System.out.println("compWorks"+compWorks)	;	
      				stmt2 = conn.createStatement();
      				rs2 = stmt2.executeQuery(compWorks);
      				while(rs2.next()){
      			  worksComp = rs2.getInt(1);
      				}
      				rs2.close();
      				stmt2.close();
      				
      				String commWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
      		                + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
      		                + " a.programme_code in (" + programme + ") and b.DATE_OF_COMPLETION is not null and TO_DATE(b.DATE_OF_COMM) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMM)<='31-MAR-" + yearEnd + "' and b.DATE_OF_COMM is not null and "
      		                + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
      				if(mode.equals("circles")){ 
      			commWorks = commWorks+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'"; 
      				}else if(mode.equals("divisions")){
      			commWorks = commWorks+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
      				}else if(mode.equals("subdivisions")){
      			commWorks = commWorks+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'"; 
      				}
      				//System.out.println("compWorks"+compWorks)	;	
      				stmt2 = conn.createStatement();
      				rs2 = stmt2.executeQuery(commWorks);
      				while(rs2.next()){
      			  worksComm = rs2.getInt(1);
      				}
      				rs2.close();
      				stmt2.close();
      				String bankLFI = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
      		                + "where WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
      		                + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and TO_DATE(BANK_SEND_DATE)<='31-MAR-" + yearStart + "' "
      		                + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
      				if(mode.equals("circles")){ 
      			bankLFI = bankLFI+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";			
      				}else if(mode.equals("divisions")){
      			bankLFI = bankLFI+"  and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
      				}else if(mode.equals("subdivisions")){
      			bankLFI = bankLFI+"  and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
      				}
      		            stmt1 = conn.createStatement();
      		            rs1 = stmt1.executeQuery(bankLFI);
      		            if (rs1.next()) {
      		                bankLastYear = rs1.getDouble(1);
      		            }
      		            stmt1.close();
      		            rs1.close();
      		            String paoLFI = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
      		                    + "where WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
      		                    + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and TO_DATE(STATE_SEND_DATE)<='31-MAR-" + yearStart + "' "
      		                    + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
      		            if(mode.equals("circles")){ 
      		            	paoLFI = paoLFI+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";			
      		    		}else if(mode.equals("divisions")){
      		    			paoLFI = paoLFI+"  and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
      		    		}else if(mode.equals("subdivisions")){
      		    			paoLFI = paoLFI+"  and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
      		    		}
      		            stmt1 = conn.createStatement();
      		            rs1 = stmt1.executeQuery(paoLFI);
      		            if (rs1.next()) {
      		                paoLastYear = rs1.getDouble(1);
      		            }
      		            stmt1.close();
      		            rs1.close();
      		        amountLFI = bankLastYear + paoLastYear ;
      				
      				String   bankCum = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
      		                   + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
      		                   + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
      		                   + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "'";            
      				if(mode.equals("circles")){ 
      					bankCum = bankCum+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";			
      				}else if(mode.equals("divisions")){
      					bankCum = bankCum+"  and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
      				}else if(mode.equals("subdivisions")){
      					bankCum = bankCum+"  and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
      				}
      				//System.out.println("bankLFI"+bankLFI)	;	
      				stmt1 = conn.createStatement();
      				rs1 = stmt1.executeQuery(bankCum);
      				if(rs1.next())
      				{
      			 		 bankYear = rs1.getDouble(1);
      				}
      				rs1.close();
      				stmt1.close();
      				 String paoCum = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
      		                  + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
      		                  + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
      		                  + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "'";
      				if(mode.equals("circles")){ 
      					paoCum = paoCum+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
      				}else if(mode.equals("divisions")){
      					paoCum = paoCum+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
      		  		}else if(mode.equals("subdivisions")){
      		  			paoCum = paoCum+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
      				}
      				//System.out.println("paoLFI"+paoLFI)	;	
      				stmt2 = conn.createStatement();
      				rs2 = stmt2.executeQuery(paoCum);
      				if(rs2.next()){
      					paoYear = rs2.getDouble(1);
      				}
      				rs2.close();
      				stmt2.close();
      				
      				  String amountCum = ndf.format((bankYear + paoYear) / 100000);	 
      				 String paymentsMade = ndf.format((bankYear + paoYear + amountLFI) / 100000);	 
      				   double valOfWorkDone=0;
      		           String valOfWorkDoneQry = "select sum(nvl(PERCENT_COMPLETED_VAL,0)) from RWS_MILESTONE_TARGET_ACH_TBL v,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"
      		                   + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
      		                   + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
      		                   + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
      		                   + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and v.work_id=a.work_id ";
      		           	if (mode.equals("circles")) {
      						valOfWorkDoneQry = valOfWorkDoneQry + " and substr(a.office_code,2,2)='"+ res.getString("circle_office_code") + "'";
      					} else if (mode.equals("divisions")) {
      						valOfWorkDoneQry = valOfWorkDoneQry + " and substr(a.office_code,2,2)='" + ccode+ "' and substr(a.office_code,4,1)='" + res.getString("division_office_code") + "'";
      					} else if (mode.equals("subdivisions")) {
      						valOfWorkDoneQry = valOfWorkDoneQry + " and substr(a.office_code,2,2)='" + ccode+ "' and substr(a.office_code,4,1)='" + divCode + "' and substr(a.office_code,5,2)='"+ res.getString("subdivision_office_code") + "'";
      					}
      					stmt1 = conn.createStatement();
      					rs1 = stmt1.executeQuery(valOfWorkDoneQry);
      					if (rs1.next()) {
      						valOfWorkDone = rs1.getDouble(1);
      					}
      					stmt1.close();
      					rs1.close();
      					
      					 String partAAmount = "select sum(nvl(BILL_AMT_CONTRACTOR,0)) from RWS_WORK_BILL_TBL v,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"
        		                   + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
        		                   + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
        		                   + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
        		                   + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and v.work_id=a.work_id and BILL_TYPE='A' ";
        		           	if (mode.equals("circles")) {
        		           		partAAmount = partAAmount + " and substr(a.office_code,2,2)='"+ res.getString("circle_office_code") + "'";
        					} else if (mode.equals("divisions")) {
        						partAAmount = partAAmount + " and substr(a.office_code,2,2)='" + ccode+ "' and substr(a.office_code,4,1)='" + res.getString("division_office_code") + "'";
        					} else if (mode.equals("subdivisions")) {
        						partAAmount = partAAmount + " and substr(a.office_code,2,2)='" + ccode+ "' and substr(a.office_code,4,1)='" + divCode + "' and substr(a.office_code,5,2)='"+ res.getString("subdivision_office_code") + "'";
        					}
        					stmt1 = conn.createStatement();
        					rs1 = stmt1.executeQuery(partAAmount);
        					if (rs1.next()) {
        						valOfWorkDone+= rs1.getDouble(1);
        					}
        					stmt1.close();
        					rs1.close();

      					
      					
      					double toBePaid = valOfWorkDone - (bankYear + paoYear + amountLFI);

      					if (noOfWorks == 0 && estCost == 0 && amountLFI == 0 && worksComp == 0 && bankYear == 0
      							&& paoYear == 0 && worksComm == 0 && worksNotGround == 0 && worksUnderProgress == 0
      							&& worksUnderProgress25 == 0 && worksUnderProgress50 == 0 && worksUnderProgress75 == 0
      							&& worksUnderProgress100 == 0) {
      					} else {
      		%>
             <tr>            
            
                      <td class="<%=style%>" style="text-align: right;" align="right"><%=++slno%></td>
                     <% if (mode.equals("circles")) {%>
                      <td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_work_progress_cs_circle_div_rpt.jsp?mode=divisions&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>"><%=cname%></a></td>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=tWorks&coc=<%=ccode%>&con=<%=programmeName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=noOfWorks%></a></td>
                     <% } else if (mode.equals("divisions")) {   %>
                      <td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_work_progress_cs_circle_div_rpt.jsp?mode=subdivisions&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>"><%=divName%></a></td>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=tWorks&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=noOfWorks%></a></td>
                     <% } else if (mode.equals("subdivisions")) { %>
                   	 <td class="<%=style%>" style="text-align: left;" align="left" ><%=subdivName%></td>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=tWorks&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=noOfWorks%></a></td>
                      <%   } %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(estCost) %></td>        
                      <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=ndf.format(amountLFI/100000) %></td>            
                      <%  if (mode.equals("circles")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=ngWorks&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"> <%=worksNotGround%></a></td>
                      <% } else if (mode.equals("divisions")) {  %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=ngWorks&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"> <%=worksNotGround%> </a></td>
                      <% } else if (mode.equals("subdivisions")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=ngWorks&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"> <%=worksNotGround%> </a></td>
                      <%}                       
                      
                      if (mode.equals("circles")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=cWorks&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksComp%></a></td>
                      <% } else if (mode.equals("divisions")) {  %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=cWorks&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksComp%></a></td>
                      <% } else if (mode.equals("subdivisions")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=cWorks&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksComp%></a></td>
                      <%}                         
                      if (mode.equals("circles")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=comWorks&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksComm%></a></td>
                      <% } else if (mode.equals("divisions")) {  %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=comWorks&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksComm%></a></td>
                      <% } else if (mode.equals("subdivisions")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=comWorks&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksComm%></a></td>
                      <%}                		 
                      if (mode.equals("circles")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=uWorks25&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksUnderProgress25%></a></td>
                      <% } else if (mode.equals("divisions")) {  %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=uWorks25&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksUnderProgress25%></a></td>
                      <% } else if (mode.equals("subdivisions")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=uWorks25&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksUnderProgress25%></a></td>
                      <%} if (mode.equals("circles")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=uWorks50&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksUnderProgress50%></a></td>
                      <% } else if (mode.equals("divisions")) {  %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=uWorks50&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksUnderProgress50%></a></td>
                      <% } else if (mode.equals("subdivisions")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=uWorks50&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksUnderProgress50%></a></td>
                      <%} if (mode.equals("circles")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=uWorks75&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksUnderProgress75%></a></td>
                      <% } else if (mode.equals("divisions")) {  %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=uWorks75&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksUnderProgress75%></a></td>
                      <% } else if (mode.equals("subdivisions")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=uWorks75&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksUnderProgress75%></a></td>
                      <%} if (mode.equals("circles")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=uWorks100&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksUnderProgress100%></a></td>
                      <% } else if (mode.equals("divisions")) {  %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=uWorks100&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksUnderProgress100%></a></td>
                      <% } else if (mode.equals("subdivisions")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=uWorks100&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksUnderProgress100%></a></td>
                      <%} if (mode.equals("circles")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=uWorks&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksUnderProgress%></a></td>
                      <% } else if (mode.equals("divisions")) {  %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=uWorks&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksUnderProgress%></a></td>
                      <% } else if (mode.equals("subdivisions")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=uWorks&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksUnderProgress%></a></td>
                      <%}          %>
                      <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=ndf.format(valOfWorkDone/100000) %></td>
	                  <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=paymentsMade %></td>
	                  <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=ndf.format(toBePaid/100000) %></td>
	                  <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=amountCum %></td>
        		</tr>    
        			 
        <%       }
		  totNoOfWorks = totNoOfWorks + noOfWorks;
          totEstCost = totEstCost + estCost;
          totAmountLFI=  totAmountLFI+ amountLFI;
          totWorksComp = totWorksComp + worksComp;
          totWorksComm = totWorksComm + worksComm;
          totWorksUnderProgress = totWorksUnderProgress + worksUnderProgress;
          totWorksUnderProgress25 = totWorksUnderProgress25 + worksUnderProgress25;
          totWorksUnderProgress50 = totWorksUnderProgress50 + worksUnderProgress50;
          totWorksUnderProgress75 = totWorksUnderProgress75 + worksUnderProgress75;
          totWorksUnderProgress100 = totWorksUnderProgress100 + worksUnderProgress100;
          totWorksNotGround = totWorksNotGround + worksNotGround;
          totTotExp = totTotExp + bankYear+paoYear;
          totToBePaid+=toBePaid;
          totValueOfWork+=valOfWorkDone;
          totTotPaymentsMade = totTotPaymentsMade + bankYear+paoYear+amountLFI;
          }
            
          
             if (slno == 0) {
         %>
     <tr>
         <td colspan="12" class="<%=style%>" style="text-align: center;">NO Records Found</td>
     </tr>
     <%
             }  %>
		 	<tr class="rightPad">
                <td class="btext" style="text-align: right;" colspan=2>Total:</td>
                <td class="btext" style="text-align: right;"><%=totNoOfWorks%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totEstCost)%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totAmountLFI/100000) %></td>
                <td class="btext" style="text-align: right;"><%=totWorksNotGround%></td>
                <td class="btext" style="text-align: right;"><%=totWorksComp%></td>
                <td class="btext" style="text-align: right;"><%=totWorksComm%></td>
                <td class="btext" style="text-align: right;"><%=totWorksUnderProgress25 %></td>
                <td class="btext" style="text-align: right;"><%=totWorksUnderProgress50 %></td>
                <td class="btext" style="text-align: right;"><%=totWorksUnderProgress75 %></td>
                <td class="btext" style="text-align: right;"><%=totWorksUnderProgress100 %></td>
                <td class="btext" style="text-align: right;"><%=totWorksUnderProgress %></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totValueOfWork/100000) %></td>
             	<td class="btext" style="text-align: right;"><%=ndf.format(totTotPaymentsMade/100000) %></td>
             	<td class="btext" style="text-align: right;"><%=ndf.format(totToBePaid/100000) %></td>   
             	<td class="btext" style="text-align: right;"><%=ndf.format(totTotExp/100000) %></td>          
            </tr>
		
		<%
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}finally{}
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