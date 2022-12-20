<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.util.*"%>
<%@page import="nic.watersoft.works.WorksData1"%>
<%
String scode="89";
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
String schemeName = request.getParameter("schemeName");

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
			<font color="#663899" face="Maiandra GD" size="4px"><b>Abstract Progress Report</b></font></br><font color="#889900" face="Maiandra GD" size="3px"  > Programme :- <%=programmeName %>
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
			<td class=btext >Sl.No</td>
			<%if(mode.equals("circles")){ %>
			<td class=btext >Circle</td>
			<%}else if(mode.equals("divisions")){ %>
			<td class=btext >Division</td>
			<%}else if(mode.equals("subdivisions")){ %>
			<td class=btext>Sub Division</td>
			<%} %>
		 	<td class=btext >No. of<br/>Works</td>
            <td class=btext>Est. Cost</td>
            <td class=btext >Habs<br/>Sanc.</td>
           <td class=btext >FHTC's for House Holds<br/>Sanc.</td>
            <td class=btext align="center">Works<br/>Not<br/>Grounded</td>
            <td class=btext align="center">Works<br/>Grounded</td>
            <td class=btext align="center">Works<br/>Under Progress</td>
            <td class=btext align="center">Works<br/>Comp.</td>
            <td class=btext align="center">Works<br/>Commissioned</td>
            <td class=btext align="center">Habs<br/>Covered</td>
            <td class=btext align="center">FHTC's<br/>Provided  for House Holds</td>
            <td class=btext >Cumulative Exp.(as on date since inception)</td>
            <td class=btext >Exp. during year</td>
            <td class=btext >Exp. of Physically comp but financially not comp works during the year</td>
            <td class=btext >Total Exp. during the year</td>  
            <td class=btext >Bills raised so far</td>  
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
 		 double totbillamt=0.0;
             int totNoOfWorks = 0, totHabsSanctioned = 0, totWorksComp = 0, totHabsCov = 0, totWorksPhyCompNotFin = 0,totWorksNotGround=0,totWorksGround=0,totWorksUnderProgress=0,totWorksComm=0,no_of_house_holds=0,provide_no_of_house_holds=0;
             long totPopBenf = 0, totPopCov = 0, popBenf = 0, popCov = 0, nrdwpPopBenf = 0, nrdwpPopCov = 0,totfhtsSanctioned=0,totprovidefhtsSanctioned=0;
             double totarfc = 0, totEstCost = 0, totExpUptoFY = 0, totExpUptoLM = 0, totExpDM = 0, totTotExp = 0, totExpIncPhyCompNotFin=0, totExpPhyCompNotFin = 0, totalAmtInclPhyCompNotFin = 0;
            // double arfc = 0, nrdwparfc = 0, nrdwpEstCost = 0, nrdwpExpUptoLFY = 0, nrdwpExpUptoLM = 0, nrdwpExpDM = 0, nrdwpTotExp = 0, nrdwpExpPhyCompNotFin = 0, nrdwpBankPhyCompNotFin = 0, nrdwpPaoPhyCompNotFin = 0, nrdwpTotExpPhyCompNotFin = 0, nrdwpAmtInclPhyCompNotFin = 0;
             
             String query = "";String sacHabs="";String Not_Grounded_Query="";String underProgressWorks = "";String groundWorks = "";String totalFhtsQry="";String totalFhtsProvideQry="";

String compWorks = "";

String commWorks= "";
String comphabs = "";

String   bankCum= "";

String paoCum= "";

String  bankCM= "";


String paoCM= "";


String phyCompNotFinBank = "";

 String phyCompNotFinPAO = "";  

String ExpIncPhyCompNotFinBank = "";
String ExpIncPhyCompNotFinPAO = ""; 
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
        	  double estCost = 0, bankYear = 0, bankLastMonth = 0, bankCurrentMonth = 0, paoYear = 0, paoLastMonth = 0, paoCurrentMonth = 0, expUptoLFY = 0, expUptoLM = 0, expDM = 0, TotExp = 0,expPhyCompNotFin = 0, bankPhyCompNotFin = 0,expIncBankPhyCompNotFin=0, paoPhyCompNotFin = 0,expIncPhyCompNotFin=0;
              int noOfWorks = 0, habsSanctioned = 0, worksComp = 0, habsCov = 0, worksPhyCompNotFin = 0,worksNotGround=0,worksGround=0,worksUnderProgress=0,worksComm=0;
              double billamount=0.0;
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
				
				
				
				
				
				
				
				
				
		
				if(programme.equals(scode) && schemeName.contains("laks")){
					//String schemeName = request.getParameter("schemeName");
					if(schemeName.contains("Below 5 laks")){
						 query = "select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"
		                           + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
		                           + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
		                           + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
		                           + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5 ";
					}else{
						 query = "select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"
		                           + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
		                           + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
		                           + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
		                           + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5 ";
					}
				}else{
					 query = "select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"
	                           + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
	                           + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
	                           + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
	                           + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' ";
				}
				  
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
		//---------
		
		
		///////
		
		 String billsamtquery = "";
		 if(programme.equals(scode) && schemeName.contains("laks")){
			 if(schemeName.contains("Below 5 laks")){
		    		//schemeName +=" (Below 5 laks)";
		    		billsamtquery = "select sum(wb.BILL_AMT_ADMISSIBLE) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,"//rws_new_est_tbl t ,
                     + "rws_contractor_selection_tbl m,RWS_WORK_BILL_TBL wb where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
                     + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                     + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  "//and t.work_id=a.work_id
                     + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and wb.EE_FWD_DATE is not null and wb.work_id=a.work_id and  not EXISTS  (select 1 from rws_bill_bank_bridge_tbl b where b.work_id=wb.work_Id and b.bill_sl_no=wb.bill_sl_no ) and a.SANCTION_AMOUNT <=5";
		    	}else{
		    		//schemeName +=" (Above 5 laks)";
		    		billsamtquery = "select sum(wb.BILL_AMT_ADMISSIBLE) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,"//rws_new_est_tbl t ,
                     + "rws_contractor_selection_tbl m,RWS_WORK_BILL_TBL wb where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
                     + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "' ) "
                     + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  "//and t.work_id=a.work_id
                     + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and wb.EE_FWD_DATE is not null and wb.work_id=a.work_id and  not EXISTS  (select 1 from rws_bill_bank_bridge_tbl b where b.work_id=wb.work_Id and b.bill_sl_no=wb.bill_sl_no ) and  a.SANCTION_AMOUNT >5 ";
		    	}
         	 //System.out.println("groundWorks :"+groundWorks);
         }else{
        	 billsamtquery = "select sum(wb.BILL_AMT_ADMISSIBLE) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,"//rws_new_est_tbl t ,
                     + "rws_contractor_selection_tbl m,RWS_WORK_BILL_TBL wb where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
                     + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "' ) "
                     + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  "//and t.work_id=a.work_id
                     + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and wb.EE_FWD_DATE is not null and wb.work_id=a.work_id and  not EXISTS  (select 1 from rws_bill_bank_bridge_tbl b where b.work_id=wb.work_Id and b.bill_sl_no=wb.bill_sl_no )";
        
         //System.out.println(groundWorks);
         }
		 
		 if(mode.equals("circles")){ 
			 billsamtquery = billsamtquery+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
			}else if(mode.equals("divisions")){
				billsamtquery = billsamtquery+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			}
			else if(mode.equals("subdivisions")){
				billsamtquery = billsamtquery+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
			}
         
         stmt1 = conn.createStatement();
         rs1 = stmt1.executeQuery(billsamtquery);
         if (rs1.next()) {
           billamount = rs1.getDouble(1);    
           if(billamount != 0)
         	  billamount = billamount/100000;
         }
         stmt1.close();
         rs1.close();
		
		
		//////////
		
		
		
		
		
		
		
		
if(programme.equals(scode) && schemeName.contains("laks")){
			
			//String schemeName = request.getParameter("schemeName");
			if(schemeName.contains("Below 5 laks")){
				totalFhtsQry = "select SUM(TOTALHOUSEHOLDS) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
		                  + ", IMISMASTERDATA_TBL hd where hd.habcode=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
		                  + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and  b.work_id=a.work_id  and  c.work_id(+)=a.work_id "
		                  + "and a.programme_code in (" + programme + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5" ;
			}else
			{
				totalFhtsQry = "select SUM(TOTALHOUSEHOLDS) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
		                  + ", IMISMASTERDATA_TBL hd where hd.habcode=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
		                  + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and  b.work_id=a.work_id  and  c.work_id(+)=a.work_id "
		                  + "and a.programme_code in (" + programme + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5";
				}
			}else
			{
				totalFhtsQry = "select SUM(TOTALHOUSEHOLDS) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
		                  + ", IMISMASTERDATA_TBL hd where hd.habcode=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
		                  + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and  b.work_id=a.work_id  and  c.work_id(+)=a.work_id "
		                  + "and a.programme_code in (" + programme + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y'";
				
			}
		
			
		if(mode.equals("circles")){ 
			totalFhtsQry = totalFhtsQry+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}else if(mode.equals("divisions")){
			totalFhtsQry = totalFhtsQry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			totalFhtsQry = totalFhtsQry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
	  //System.out.println("@@@@@hab_query"+totalFhtsQry)	;	
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(totalFhtsQry);
		if(rs2.next()){
			 no_of_house_holds = rs2.getInt(1); 
            // popBenf = rs2.getLong(2);
		}
		
		rs2.close();
		stmt2.close();
		
		
		
		
		
		
		
		//------------
		
		
		
		
		//---------
		
		if(programme.equals(scode) && schemeName.contains("laks")){
					
					//String schemeName = request.getParameter("schemeName");
					if(schemeName.contains("Below 5 laks")){
						totalFhtsProvideQry = "select SUM(PENDING_FHTC) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
				                  + ", rws_habitation_directory_tbl hd where hd.hab_code=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
				                  + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and  b.work_id=a.work_id  and  c.work_id(+)=a.work_id "
				                  + "and a.programme_code in (" + programme + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS<>'UI' and a.SANCTION_AMOUNT <=5 ";
						}else
					{
						totalFhtsProvideQry = "select SUM(PENDING_FHTC) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
				                  + ", rws_habitation_directory_tbl hd where hd.hab_code=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
				                  + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and  b.work_id=a.work_id  and  c.work_id(+)=a.work_id "
				                  + "and a.programme_code in (" + programme + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS<>'UI' and a.SANCTION_AMOUNT >5";
						}
					}else
					{
						totalFhtsProvideQry = "select SUM(PENDING_FHTC) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
				                  + ", rws_habitation_directory_tbl hd where hd.hab_code=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
				                  + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and  b.work_id=a.work_id  and  c.work_id(+)=a.work_id "
				                  + "and a.programme_code in (" + programme + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS<>'UI' ";
						
					}
				
					
				if(mode.equals("circles")){ 
					totalFhtsProvideQry = totalFhtsProvideQry+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
				}else if(mode.equals("divisions")){
					totalFhtsProvideQry = totalFhtsProvideQry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
				}
				else if(mode.equals("subdivisions")){
					totalFhtsProvideQry = totalFhtsProvideQry+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
				}
			  //System.out.println("@@@@@hab_query"+totalFhtsQry)	;	
				stmt2 = conn.createStatement();
				rs2 = stmt2.executeQuery(totalFhtsProvideQry);
				if(rs2.next()){
					provide_no_of_house_holds = rs2.getInt(1); 
		            // popBenf = rs2.getLong(2);
				}
				
				rs2.close();
				stmt2.close();
				
				
				
				
				
				
				
				//------------
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		if(programme.equals(scode) && schemeName.contains("laks")){
			
			//String schemeName = request.getParameter("schemeName");
			if(schemeName.contains("Below 5 laks")){
		 sacHabs = "select count(distinct b.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
                  + ", rws_habitation_directory_tbl hd where hd.hab_code=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                  + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and  b.work_id=a.work_id and COVERAGE_STATUS<>'UI' and  c.work_id(+)=a.work_id "
                  + "and a.programme_code in (" + programme + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5" ;
			}else
			{
				 sacHabs = "select count(distinct b.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
		                  + ", rws_habitation_directory_tbl hd where hd.hab_code=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
		                  + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and  b.work_id=a.work_id and COVERAGE_STATUS<>'UI' and  c.work_id(+)=a.work_id "
		                  + "and a.programme_code in (" + programme + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5" ;
				}
			}else
			{
				 sacHabs = "select count(distinct b.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
		                  + ", rws_habitation_directory_tbl hd where hd.hab_code=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
		                  + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and  b.work_id=a.work_id and COVERAGE_STATUS<>'UI' and  c.work_id(+)=a.work_id "
		                  + "and a.programme_code in (" + programme + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y'";
				
			}
		
			
		if(mode.equals("circles")){ 
			sacHabs = sacHabs+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}else if(mode.equals("divisions")){
			sacHabs = sacHabs+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}
		else if(mode.equals("subdivisions")){
			sacHabs = sacHabs+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
	  //System.out.println("hab_query"+hab_query)	;	
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(sacHabs);
		if(rs2.next()){
			 habsSanctioned = rs2.getInt(1); 
             popBenf = rs2.getLong(2);
		}
		
		rs2.close();
		stmt2.close();
		
		if(programme.equals(scode) && schemeName.contains("laks")){
			//String schemeName = request.getParameter("schemeName");
			if(schemeName.contains("Below 5 laks")){
		  Not_Grounded_Query="select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a,rws_programme_tbl p where a.work_id not in "
				   +"(select work_id from RWS_WORK_COMMENCEMENT_TBL where GROUNDING_DATE is not null ) and a.work_id not in " 
            +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)  " 
            +"and WORK_CANCEL_DT is null and a.programme_code=p.PROGRAMME_CODE and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y'  and  "
            +"  a.PROGRAMME_CODE in ("+programme+") and TO_DATE(TARGET_DATE_COMP)>='01-APR-"+ yearStart+"' "
            +"   and a.SANCTION_AMOUNT <=5";//and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') 
			}else{
				Not_Grounded_Query="select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a,rws_programme_tbl p where a.work_id not in "
						   +"(select work_id from RWS_WORK_COMMENCEMENT_TBL where GROUNDING_DATE is not null ) and a.work_id not in " 
		            +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)  " 
		            +"and WORK_CANCEL_DT is null and a.programme_code=p.PROGRAMME_CODE and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y'  and  "
		            +"  a.PROGRAMME_CODE in ("+programme+") and TO_DATE(TARGET_DATE_COMP)>='01-APR-"+ yearStart+"' "
		            +"    and a.SANCTION_AMOUNT >5 ";//and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') 
			}
		}else{
			Not_Grounded_Query="select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a,rws_programme_tbl p where a.work_id not in "
					   +"(select work_id from RWS_WORK_COMMENCEMENT_TBL where GROUNDING_DATE is not null ) and a.work_id not in " 
	            +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)  " 
	            +"and WORK_CANCEL_DT is null and a.programme_code=p.PROGRAMME_CODE and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y'  and  "
	            +"  a.PROGRAMME_CODE in ("+programme+") and TO_DATE(TARGET_DATE_COMP)>='01-APR-"+ yearStart+"' "
	            +"  ";//and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')
		}
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
      if(programme.equals(scode) && schemeName.contains("laks")){
			//String schemeName = request.getParameter("schemeName");
			if(schemeName.contains("Below 5 laks")){
		
        groundWorks = "select count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,"//rws_new_est_tbl t ,
                + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
                + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id=a.work_id and m.work_id(+)=a.work_id  "///and t.work_id=a.work_id
                + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5 ";
			}
			else
			{groundWorks = "select count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,"//rws_new_est_tbl t ,
	                + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
	                + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
	                + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id=a.work_id and m.work_id(+)=a.work_id "//and t.work_id=a.work_id 
	                + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5";
				
			}
      }else
      {
    	  groundWorks = "select count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,"//rws_new_est_tbl t ,
                  + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
                  + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                  + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id=a.work_id and m.work_id(+)=a.work_id "//and t.work_id=a.work_id 
                  + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' ";
      }
        if(mode.equals("circles")){ 
        	groundWorks = groundWorks+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'"; 
		}else if(mode.equals("divisions")){
			groundWorks = groundWorks+ " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'"; 		
		}else if(mode.equals("subdivisions")){
			groundWorks= groundWorks+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
        stmt1 = conn.createStatement();
        rs1 = stmt1.executeQuery(groundWorks);
        if (rs1.next()) {
          worksGround = rs1.getInt(1);    
        }
        stmt1.close();
        rs1.close();
		
        if(programme.equals(scode) && schemeName.contains("laks")){
			//String schemeName = request.getParameter("schemeName");
			if(schemeName.contains("Below 5 laks")){
        
        underProgressWorks = "select count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,"//rws_new_est_tbl t ,
                + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
                + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) "
                + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id "//and t.work_id=a.work_id 
                + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5 ";
			}
			else
			{
				 underProgressWorks = "select count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,"//rws_new_est_tbl t ,
			                + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
			                + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) "
			                + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id  "//and t.work_id=a.work_id
			                + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5 ";
				
			}
        }
        else{
        	 underProgressWorks = "select count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,"///rws_new_est_tbl t ,
                     + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
                     + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) "
                     + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id  "//and t.work_id=a.work_id
                     + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' ";
        }
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
        }
        stmt1.close();
        rs1.close();
        if(programme.equals(scode) && schemeName.contains("laks")){
			//String schemeName = request.getParameter("schemeName");
			if(schemeName.contains("Below 5 laks")){
		 compWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id(+)=a.work_id and hd.hab_code(+)=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
                + " a.programme_code in (" + programme + ")   and TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMPLETION)<='31-MAR-" + yearEnd + "'  and b.DATE_OF_COMPLETION is not null and "
                + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5 ";
			}else
			{ compWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
	                + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id(+)=a.work_id and hd.hab_code(+)=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
	                + " a.programme_code in (" + programme + ")   and TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMPLETION)<='31-MAR-" + yearEnd + "'  and b.DATE_OF_COMPLETION is not null and "
	                + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5";
				}
        }else
        { compWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id(+)=a.work_id and hd.hab_code(+)=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
                + " a.programme_code in (" + programme + ")   and TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMPLETION)<='31-MAR-" + yearEnd + "'  and b.DATE_OF_COMPLETION is not null and "
                + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
			}
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
		if(programme.equals(scode) && schemeName.contains("laks")){
			//String schemeName = request.getParameter("schemeName");
			if(schemeName.contains("Below 5 laks")){
		 commWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
                + " a.programme_code in (" + programme + ") and b.DATE_OF_COMPLETION is not null and TO_DATE(b.DATE_OF_COMM) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMM)<='31-MAR-" + yearEnd + "' and b.DATE_OF_COMM is not null and "
                + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5 ";
		
			}else{commWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
	                + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
	                + " a.programme_code in (" + programme + ") and b.DATE_OF_COMPLETION is not null and TO_DATE(b.DATE_OF_COMM) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMM)<='31-MAR-" + yearEnd + "' and b.DATE_OF_COMM is not null and "
	                + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5";
			}
		}else
		{commWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
                + " a.programme_code in (" + programme + ") and b.DATE_OF_COMPLETION is not null and TO_DATE(b.DATE_OF_COMM) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMM)<='31-MAR-" + yearEnd + "' and b.DATE_OF_COMM is not null and "
                + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
		}
                
                
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
		if(programme.equals(scode) && schemeName.contains("laks")){
			//String schemeName = request.getParameter("schemeName");
			if(schemeName.contains("Below 5 laks")){
		 comphabs = "select count(distinct h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
                + " a.programme_code in (" + programme + ")  and ((TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart +"' and TO_DATE(b.DATE_OF_COMPLETION) <= '31-MAR-" + yearEnd +"' and b.DATE_OF_COMPLETION is not null) OR (TO_DATE(b.partial_date_of_completion) >= '01-APR-" + yearStart +"' and TO_DATE(b.partial_date_of_completion) <= '31-MAR-" + yearEnd +"' and b.DATE_OF_COMPLETION is null)) and "
                + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5 ";
		
			}else{ comphabs = "select count(distinct h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
	                + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
	                + " a.programme_code in (" + programme + ")  and ((TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart +"' and TO_DATE(b.DATE_OF_COMPLETION) <= '31-MAR-" + yearEnd +"' and b.DATE_OF_COMPLETION is not null) OR (TO_DATE(b.partial_date_of_completion) >= '01-APR-" + yearStart +"' and TO_DATE(b.partial_date_of_completion) <= '31-MAR-" + yearEnd +"' and b.DATE_OF_COMPLETION is null)) and "
	                + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5";
			}
		}else
		{ comphabs = "select count(distinct h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
                + " a.programme_code in (" + programme + ")  and ((TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart +"' and TO_DATE(b.DATE_OF_COMPLETION) <= '31-MAR-" + yearEnd +"' and b.DATE_OF_COMPLETION is not null) OR (TO_DATE(b.partial_date_of_completion) >= '01-APR-" + yearStart +"' and TO_DATE(b.partial_date_of_completion) <= '31-MAR-" + yearEnd +"' and b.DATE_OF_COMPLETION is null)) and "
                + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
		}
                
                if(mode.equals("circles")){ 
			comphabs = comphabs+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'"; 
		}else if(mode.equals("divisions")){
			comphabs = comphabs+ " and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'"; 		
		}else if(mode.equals("subdivisions")){
			comphabs= comphabs+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		//System.out.println("bankpaos"+comphabs)	;	
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(comphabs);
		if(rs2.next()){
			 habsCov = rs2.getInt(1);
             popCov = rs2.getLong(2);  
		}
		rs2.close();
		stmt2.close();		
		if(programme.equals(scode) && schemeName.contains("laks")){
			//String schemeName = request.getParameter("schemeName");
			if(schemeName.contains("Below 5 laks")){
		   bankCum = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                   + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                   + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
                   + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'  and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.SANCTION_AMOUNT <=5 ";  
			}else
			{   bankCum = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
	                   + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
	                   + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
	                   + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'  and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.SANCTION_AMOUNT >5";  
				}
			}else
			{
				   bankCum = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
		                   + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
		                   + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
		                   + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'  and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "'";  
			}
			
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
		if(programme.equals(scode) && schemeName.contains("laks")){
			
			//String schemeName = request.getParameter("schemeName");
			if(schemeName.contains("Below 5 laks")){
		  paoCum = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                  + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                  + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
                  + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.SANCTION_AMOUNT <=5";
		
			}else
			{ 
				paoCum = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
	                  + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
	                  + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
	                  + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.SANCTION_AMOUNT >5";
			}
		}else
		{ paoCum = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
                + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "'";
		}
                  
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
		}rs2.close();
		stmt2.close();
		  String amountCum = ndf.format((bankYear + paoYear) / 100000);	  
		  
		/* String  bankLM = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                  + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                  + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and BANK_SEND_DATE>='01-APR-" + yearStart + "'"
                  + "and BANK_SEND_DATE<'01-" + currentMonth + "-" + cyear + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
		if(mode.equals("circles")){ 
			bankLM = bankLM+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}else if(mode.equals("divisions")){
			bankLM = bankLM+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
  		}else if(mode.equals("subdivisions")){
  			bankLM = bankLM+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
//System.out.println("bankLM"+bankLM);	
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(bankLM);
		if(rs2.next()){
			 bankLastMonth = rs2.getDouble(1);
		}		
		rs2.close();
		stmt2.close();
		String paoLM = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                 + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                 + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and STATE_SEND_DATE>='01-APR-" + yearStart + "'"
                 + "and STATE_SEND_DATE<'01-" + currentMonth + "-" + cyear + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
		
		if(mode.equals("circles")){ 
			paoLM = paoLM+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}else if(mode.equals("divisions")){
			paoLM = paoLM+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
  		}else if(mode.equals("subdivisions")){
  			paoLM = paoLM+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		//System.out.println("paoLM"+paoLM);	
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(paoLM);
		while(rs2.next()){
			 paoLastMonth = rs2.getDouble(1);
		}
		rs2.close();
		stmt2.close();
		  String amountLM = ndf.format((bankLastMonth + paoLastMonth) / 100000); */
		   
		  if(programme.equals(scode) && schemeName.contains("laks")){
				//String schemeName = request.getParameter("schemeName");
				if(schemeName.contains("Below 5 laks")){

		  
		  
		  bankCM = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                 + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                 + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' "
                 + "and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5 ";
		
                 
				}else
				{  bankCM = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
		                 + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
		                 + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' "
		                 + "and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5";
				}
				}else
				{
					  bankCM = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
				                 + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
				                 + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' "
				                 + "and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
						
				}
                 
                 
                 if(mode.equals("circles")){ 
			bankCM = bankCM+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}else if(mode.equals("divisions")){
			bankCM = bankCM+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
  		}else if(mode.equals("subdivisions")){
  			bankCM = bankCM+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}		
		 //System.out.println("bankCM"+bankCM);	
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(bankCM);
		if(rs2.next()){
			 bankCurrentMonth = rs2.getDouble(1);
		}
		rs2.close();
		stmt2.close();
		if(programme.equals(scode) && schemeName.contains("laks")){
			//String schemeName = request.getParameter("schemeName");
			if(schemeName.contains("Below 5 laks")){


		
		
		 paoCM = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "' "
                + "and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5 ";
			}else
			{ paoCM = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
	                + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
	                + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "' "
	                + "and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5";
				}
		}else
		{ paoCM = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "' "
                + "and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
			}
                
                
                if(mode.equals("circles")){ 
			paoCM=paoCM+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'";
		}else if(mode.equals("divisions")){
			paoCM=paoCM+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}else if(mode.equals("subdivisions")){
			paoCM=paoCM+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'";
		}
		//System.out.println("paoCM"+paoCM);	
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(paoCM);
		if(rs2.next()){
			 paoCurrentMonth = rs2.getDouble(1);
		}rs2.close();
			stmt2.close();
			//String amountCM = ndf.format((bankCurrentMonth + paoCurrentMonth) / 100000);

            String amountTot = ndf.format(( bankCurrentMonth + paoCurrentMonth) / 100000);
            if(programme.equals(scode) && schemeName.contains("laks")){
				//String schemeName = request.getParameter("schemeName");
				if(schemeName.contains("Below 5 laks")){

			 
             phyCompNotFinBank =   "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
 					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "' "
 					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
 					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id and a.work_id in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') and a.SANCTION_AMOUNT <=5";
			
				}else
				{phyCompNotFinBank =   "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
 					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "' "
 					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
 					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id and a.work_id in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') and a.SANCTION_AMOUNT >5";
			}
            }else
            {phyCompNotFinBank =   "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
					+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "' "
					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id and a.work_id in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "')";
		}
 					
 					
 					
 					if(mode.equals("circles")){ 
				phyCompNotFinBank=phyCompNotFinBank+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'"; 
			}else if(mode.equals("divisions")){
				phyCompNotFinBank= phyCompNotFinBank+" and substr(a.office_code,2,2)='"+ccode+"'  and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			}else if(mode.equals("subdivisions")){
				phyCompNotFinBank= phyCompNotFinBank+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"' ";
			}
				//	System.out.println("fin_banksendQuery"+fin_banksendQuery);	
			stmt2 = conn.createStatement();
			rs2 = stmt2.executeQuery(phyCompNotFinBank);
			while(rs2.next()){
				 bankPhyCompNotFin = rs2.getDouble(1);
			}
			rs2.close();
			stmt2.close();
			       
			
			
			if(programme.equals(scode) && schemeName.contains("laks")){
				//String schemeName = request.getParameter("schemeName");
				if(schemeName.contains("Below 5 laks")){
             phyCompNotFinPAO = "select sum(nvl(BILL_AMOUT_STATE,0)) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
 					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "'  and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "'"
 					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
 					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id and a.work_id in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') and a.SANCTION_AMOUNT <=5 ";
			
				}else
				{ phyCompNotFinPAO = "select sum(nvl(BILL_AMOUT_STATE,0)) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
 					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "'  and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "'"
 					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
 					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id and a.work_id in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') and a.SANCTION_AMOUNT >5";
			}
			}else
			{ phyCompNotFinPAO = "select sum(nvl(BILL_AMOUT_STATE,0)) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
					+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "'  and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "'"
					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id and a.work_id in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "')";
		}
 					if(mode.equals("circles")){ 
				phyCompNotFinPAO=phyCompNotFinPAO+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"' ";
			}else if(mode.equals("divisions")){
				phyCompNotFinPAO=phyCompNotFinPAO+" and substr(a.office_code,2,2)='"+ccode+"'  and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			}else if(mode.equals("subdivisions")){
				phyCompNotFinPAO= phyCompNotFinPAO+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"' ";
			}
					//System.out.println("phyCompNotFinPAO"+phyCompNotFinPAO);	
			stmt2 = conn.createStatement();
			rs2 = stmt2.executeQuery(phyCompNotFinPAO);
			if(rs2.next()){
				paoPhyCompNotFin = rs2.getDouble(1);
			}
			rs2.close();
			stmt2.close();
			 String amountPhyCompNotFin = ndf.format((bankPhyCompNotFin + paoPhyCompNotFin) / 100000);
			 
			 if(programme.equals(scode) && schemeName.contains("laks")){
					//String schemeName = request.getParameter("schemeName");
					if(schemeName.contains("Below 5 laks")){

			 ExpIncPhyCompNotFinBank =  "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
 					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "'"
 					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
 					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id and a.SANCTION_AMOUNT <=5";
			
					}else
					{	 ExpIncPhyCompNotFinBank =  "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
							+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
		 					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "'"
		 					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
		 					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id and a.SANCTION_AMOUNT >5";
					}
			 }else
			 {	 ExpIncPhyCompNotFinBank =  "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "'"
					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";
			}
 					
 					if(mode.equals("circles")){ 
				ExpIncPhyCompNotFinBank=ExpIncPhyCompNotFinBank+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'"; 
			}else if(mode.equals("divisions")){
				ExpIncPhyCompNotFinBank= ExpIncPhyCompNotFinBank+" and substr(a.office_code,2,2)='"+ccode+"'  and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			}else if(mode.equals("subdivisions")){
				ExpIncPhyCompNotFinBank= ExpIncPhyCompNotFinBank+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"' ";
			}
				//	System.out.println("fin_banksendQuery"+ExpIncPhyCompNotFinBank);	
			stmt2 = conn.createStatement();
			rs2 = stmt2.executeQuery(ExpIncPhyCompNotFinBank);
			while(rs2.next()){
				expIncBankPhyCompNotFin = rs2.getDouble(1);
			}
			rs2.close();
			stmt2.close();
			       
			
			if(programme.equals(scode) && schemeName.contains("laks")){
				//String schemeName = request.getParameter("schemeName");
				if(schemeName.contains("Below 5 laks")){


			 ExpIncPhyCompNotFinPAO = "select sum(nvl(BILL_AMOUT_STATE,0)) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
 					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "'"
 					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
 					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id  and a.SANCTION_AMOUNT <=5";
			
				}
				else
				{ExpIncPhyCompNotFinPAO = "select sum(nvl(BILL_AMOUT_STATE,0)) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
 					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "'"
 					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
 					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id and a.SANCTION_AMOUNT >5";
			}
			}else
			{ExpIncPhyCompNotFinPAO = "select sum(nvl(BILL_AMOUT_STATE,0)) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
					+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "'"
					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";
		}
			
 					if(mode.equals("circles")){ 
				ExpIncPhyCompNotFinPAO=ExpIncPhyCompNotFinPAO+ " and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"' ";
			}else if(mode.equals("divisions")){
				ExpIncPhyCompNotFinPAO=ExpIncPhyCompNotFinPAO+" and substr(a.office_code,2,2)='"+ccode+"'  and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
			}else if(mode.equals("subdivisions")){
				ExpIncPhyCompNotFinPAO= ExpIncPhyCompNotFinPAO+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"' ";
			}
					//System.out.println("phyCompNotFinPAO"+phyCompNotFinPAO);	
			stmt2 = conn.createStatement();
			rs2 = stmt2.executeQuery(ExpIncPhyCompNotFinPAO);
			if(rs2.next()){
				expIncPhyCompNotFin = rs2.getDouble(1);
			}
			rs2.close();
			stmt2.close();
			 String amountExpIncPhyCompNotFin = ndf.format((expIncBankPhyCompNotFin + expIncPhyCompNotFin) / 100000);
            // arfc = estCost - (bankLastYear + paoLastYear + bankLastMonth + paoLastMonth + bankCurrentMonth + paoCurrentMonth) / 100000;
            if(noOfWorks==0 && estCost==0 && habsSanctioned==0 && worksComp==0 &&  habsCov==0 && popCov==0 &&
            popBenf==0 && bankYear==0.0 && paoYear==0.0 && bankLastMonth ==0.0 && paoLastMonth==0.0 &&
              bankCurrentMonth ==0.0 && paoCurrentMonth==0.0 && worksPhyCompNotFin==0.0&&bankPhyCompNotFin==0&&paoPhyCompNotFin==0) {}else{
         %>
             <tr>            
            
                      <td class="<%=style%>" style="text-align: right;" align="right"><%=++slno%></td>
                     <% if (mode.equals("circles")) {%>
                      <td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_work_progress_min_circle_div_rpt.jsp?mode=divisions&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>"><%=cname%></a></td>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=tWorks&coc=<%=ccode%>&con=<%=programmeName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=noOfWorks%></a></td>
                     <% } else if (mode.equals("divisions")) {   %>
                      <td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_work_progress_min_circle_div_rpt.jsp?mode=subdivisions&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>"><%=divName%></a></td>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=tWorks&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=noOfWorks%></a></td>
                     <% } else if (mode.equals("subdivisions")) { %>
                   	 <td class="<%=style%>" style="text-align: left;" align="left" ><%=subdivName%></td>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=tWorks&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=noOfWorks%></a></td>
                      <%   } %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(estCost) %></td>                    
                      <%  if (mode.equals("circles")) { %>
                        <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=sHabs&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=habsSanctioned%></a></td>
                      <%  } else if (mode.equals("divisions")) {  %>
                        <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=sHabs&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=habsSanctioned%></a></td>
                      <% } else if (mode.equals("subdivisions")) { %>
                        <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=sHabs&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=habsSanctioned%></a></td>
                      <% }%>   
                      
                      <%  if (mode.equals("circles")) { %>
                        <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=fhtcforsac&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=no_of_house_holds%></a></td>
                      <%  } else if (mode.equals("divisions")) {  %>
                        <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=fhtcforsac&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=no_of_house_holds%></a></td>
                      <% } else if (mode.equals("subdivisions")) { %>
                        <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=fhtcforsac&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=no_of_house_holds%></a></td>
                      <% }%>  
                      
                      
                                        
                      <%  if (mode.equals("circles")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=ngWorks&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"> <%=worksNotGround%></a></td>
                      <% } else if (mode.equals("divisions")) {  %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=ngWorks&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"> <%=worksNotGround%> </a></td>
                      <% } else if (mode.equals("subdivisions")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=ngWorks&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"> <%=worksNotGround%> </a></td>
                      <%}                       
                      if (mode.equals("circles")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=gWorks&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksGround%></a></td>
                      <% } else if (mode.equals("divisions")) {  %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=gWorks&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksGround%></a></td>
                      <% } else if (mode.equals("subdivisions")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=gWorks&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksGround%></a></td>
                      <%}                       
                       if (mode.equals("circles")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=uWorks&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksUnderProgress%></a></td>
                      <% } else if (mode.equals("divisions")) {  %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=uWorks&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksUnderProgress%></a></td>
                      <% } else if (mode.equals("subdivisions")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=uWorks&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksUnderProgress%></a></td>
                      <%}
                      if (mode.equals("circles")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=cWorks&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksComp%></a></td>
                      <% } else if (mode.equals("divisions")) {  %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=cWorks&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksComp%></a></td>
                      <% } else if (mode.equals("subdivisions")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=cWorks&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksComp%></a></td>
                      <%}                         
                      if (mode.equals("circles")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=comWorks&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksComm%></a></td>
                      <% } else if (mode.equals("divisions")) {  %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=comWorks&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksComm%></a></td>
                      <% } else if (mode.equals("subdivisions")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=comWorks&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksComm%></a></td>
                      <%}                		 
                      if (mode.equals("circles")) {  %>
                     <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=cHabs&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=habsCov%></a></td>
                     <%} else if (mode.equals("divisions")) {%>
                     <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=cHabs&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=habsCov%></a></td>
                     <% } else if (mode.equals("subdivisions")) { %>
                     <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=cHabs&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=habsCov%></a></td>
                     <%      }           %>
                     
                      <%if (mode.equals("circles")) {  %>
                     <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=fhtcforprovided&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=provide_no_of_house_holds%></a></td>
                     <%} else if (mode.equals("divisions")) {%>
                     <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=fhtcforprovided&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=provide_no_of_house_holds%></a></td>
                     <% } else if (mode.equals("subdivisions")) { %>
                     <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=fhtcforprovided&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=provide_no_of_house_holds%></a></td>
                     <%      }           %>
                     
                     <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=amountCum%></td>
                     <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=amountTot%></td>
                     <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=amountPhyCompNotFin%></td>
                     <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=amountExpIncPhyCompNotFin%></td> 
        		<td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=ndf.format(billamount)%></td> 
        		</tr>    
        			 
        <%       }
            	 totNoOfWorks = totNoOfWorks + noOfWorks;
                 totEstCost = totEstCost + estCost;
                 totHabsSanctioned = totHabsSanctioned + habsSanctioned;
                 totfhtsSanctioned = totfhtsSanctioned + no_of_house_holds;
                 totWorksComp = totWorksComp + worksComp;
                 totWorksComm = totWorksComm + worksComm;
                 totWorksNotGround = totWorksNotGround + worksNotGround;
                 totWorksGround = totWorksGround + worksGround;
                 totWorksUnderProgress = totWorksUnderProgress + worksUnderProgress;
                 totHabsCov = totHabsCov + habsCov;
                 totPopCov = totPopCov + popCov;
                 totPopBenf = totPopBenf + popBenf;
                 totExpUptoFY = totExpUptoFY + bankYear + paoYear;
                 totExpUptoLM = totExpUptoLM + bankLastMonth + paoLastMonth;
                 totExpDM = totExpDM + bankCurrentMonth + paoCurrentMonth;
                 totTotExp = totExpUptoLM + totExpDM;
             //    totarfc = totarfc + arfc;
                 totWorksPhyCompNotFin = totWorksPhyCompNotFin + worksPhyCompNotFin;
                 totExpPhyCompNotFin = totExpPhyCompNotFin + bankPhyCompNotFin + paoPhyCompNotFin;
                 totExpIncPhyCompNotFin = totExpIncPhyCompNotFin+ expIncBankPhyCompNotFin + expIncPhyCompNotFin;
          
                 totprovidefhtsSanctioned = totprovidefhtsSanctioned + provide_no_of_house_holds;
                 totbillamt=totbillamt+billamount;
          }
            
          
             if (slno == 0) {
         %>
     <tr>
         <td colspan="13" class="<%=style%>" style="text-align: center;">NO Records Found</td>
     </tr>
     <%
             }  %>
		 	<tr class="rightPad">
                <td class="btext" style="text-align: right;" colspan=2>Total:</td>
                <td class="btext" style="text-align: right;"><%=totNoOfWorks%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totEstCost)%></td>
                <td class="btext" style="text-align: right;"><%=totHabsSanctioned%></td>
                <td class="btext" style="text-align: right;"><%=totfhtsSanctioned%></td>
                <td class="btext" style="text-align: right;"><%=totWorksNotGround%></td>
                <td class="btext" style="text-align: right;"><%=totWorksGround%></td>
                <td class="btext" style="text-align: right;"><%=totWorksUnderProgress%></td>
                <td class="btext" style="text-align: right;"><%=totWorksComp%></td>
                <td class="btext" style="text-align: right;"><%=totWorksComm%></td>
                <td class="btext" style="text-align: right;"><%=totHabsCov%></td>
                <td class="btext" style="text-align: right;"><%=totprovidefhtsSanctioned%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totExpUptoFY / 100000)%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totTotExp / 100000)%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totExpPhyCompNotFin / 100000)%></td>
             	<td class="btext" style="text-align: right;"><%=ndf.format(totExpIncPhyCompNotFin / 100000)%></td>             
               <td class="btext" style="text-align: right;"><%=ndf.format(totbillamt)%></td>
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