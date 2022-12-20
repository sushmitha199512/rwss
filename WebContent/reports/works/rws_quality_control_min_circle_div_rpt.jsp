<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%@ page import="java.sql.Date"%>
<%@ page import="java.util.*"%>
<%@page import="nic.watersoft.works.WorksData1"%>
<%
//String scode="89";
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
//System.out.println("mode:::::::"+mode);
/////String programme = request.getParameter("program");
//////request.setAttribute("program", programme); 
String mCode=session.getAttribute("mCode").toString();
/////System.out.println(mode+"====="+"mCode:::::::"+mCode);
String mName=session.getAttribute("mName").toString();
//////System.out.println(mode+"====="+"from date:::::::"+session.getAttribute("fromdate").toString());
String programme=mCode;
String programmeName=mName;
String dcode=request.getParameter("district");
String fromDate=request.getParameter("fromDate");
session.setAttribute("fromDate", request.getParameter("fromDate"));
String toDate=request.getParameter("toDate");
session.setAttribute("toDate", request.getParameter("toDate"));
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
int yearStart =2021;
int yearEnd = 2022;
String schemeName = request.getParameter("schemeName");
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
			<font color="#663899" face="Maiandra GD" size="4px"><b>Quality Control Report</b></font></br><font color="#889900" face="Maiandra GD" size="3px"  > Programme :- <%=programmeName %>
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
		 	<!-- <td class=btext >No. of<br/>Works</td> -->
            <!-- <td class=btext>Est. Cost</td>
            <td class=btext >Habs<br/>Sanc.</td>
           <td class=btext >FHTC's for House Holds<br/>Sanc.</td>
            <td class=btext align="center">Works<br/>Not<br/>Grounded</td>
            <td class=btext align="center">Works<br/>Grounded</td>
            <td class=btext align="center">Works<br/>Under Progress</td>
             -->
             <td class=btext align="center">Works<br/>Comp.</td>
            <td class=btext align="center">Works<br/>Commissioned</td>
            <td class=btext>Inspected Works</td>
            <td class=btext>To be Inspected Works</td>
            <!-- <td class=btext align="center">Habs<br/>Covered</td>
            <td class=btext align="center">FHTC's<br/>Provided  for House Holds</td>
            <td class=btext >Cumulative Exp.(as on date since inception)</td>
            <td class=btext >Exp. during year</td>
            <td class=btext >Exp. of Physically comp but financially not comp works during the year</td>
            <td class=btext >Total Exp. during the year</td>  
            <td class=btext >Bills raised so far</td> -->  
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
             long totqcinComp=0,qcComp=0,totqcComp=0,totPopBenf = 0, totPopCov = 0, popBenf = 0, popCov = 0, nrdwpPopBenf = 0, nrdwpPopCov = 0,totfhtsSanctioned=0,totprovidefhtsSanctioned=0;
             double totarfc = 0, totEstCost = 0, totExpUptoFY = 0, totExpUptoLM = 0, totExpDM = 0, totTotExp = 0, totExpIncPhyCompNotFin=0, totExpPhyCompNotFin = 0, totalAmtInclPhyCompNotFin = 0;
            // double arfc = 0, nrdwparfc = 0, nrdwpEstCost = 0, nrdwpExpUptoLFY = 0, nrdwpExpUptoLM = 0, nrdwpExpDM = 0, nrdwpTotExp = 0, nrdwpExpPhyCompNotFin = 0, nrdwpBankPhyCompNotFin = 0, nrdwpPaoPhyCompNotFin = 0, nrdwpTotExpPhyCompNotFin = 0, nrdwpAmtInclPhyCompNotFin = 0;
             
             String query = "";String sacHabs="";String Not_Grounded_Query="";String underProgressWorks = "";String groundWorks = "";String totalFhtsQry="";String totalFhtsProvideQry="";

String compWorks = "";
String qcWorks="";

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
	 			 if(dcode.equalsIgnoreCase("00")){
	 				 //System.out.println();
	 	 			c_query="select circle_office_code,circle_office_name from rws_circle_office_tbl   order by circle_office_code";

	 			 }else{
	 			c_query="select circle_office_code,circle_office_name from rws_circle_office_tbl where  circle_office_code='"+dcode+"'  order by circle_office_code";
	 			 }
	 		 }
            else if(mode.equals("divisions")){
            	c_query="select division_office_code,division_office_name from rws_division_office_tbl where  circle_office_code='"+ccode+"' and status <> 'UI' order by division_office_code";
                //System.out.println(";;;;"+c_query);
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
				
				
				
				
				
				
				
				
				
				/* 	 query = "select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"
                + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
                + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
                + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' ";
	
	   */

		/* 		 query = "select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"
                          + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
                          + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                          + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
                          + "and a.CORE_DASHBOARD_STATUS='Y' ";
				
				
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
		stmt1.close(); */
		//---------
		
		
		///////
		
		 
         /* compWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
                + " a.programme_code in (" + programme + ")   and TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMPLETION)<='31-MAR-" + yearEnd + "'  and b.DATE_OF_COMPLETION is not null and "
                + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
			 */
			 
		        /* qcWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                        + ", rws_habitation_directory_tbl hd,rws_quality_control_tbl qc where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
                        + " a.programme_code in (" + programme + ")   and TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMPLETION)<='31-MAR-" + yearEnd + "'  and b.DATE_OF_COMPLETION is not null and "
                        + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "'  and b.work_id=qc.work_id and  a.CORE_DASHBOARD_STATUS='Y'";
        			 */
                        /* qcWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                                + ", rws_habitation_directory_tbl hd,rws_quality_control_tbl qc where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
                                + " a.programme_code in (" + programme + ")   and    b.DATE_OF_COMPLETION is not null and "
                                + " TARGET_DATE_COMP is not null  and b.work_id=qc.work_id and  a.CORE_DASHBOARD_STATUS='Y'";
                			 */
        			 /* qcWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                             + ", rws_habitation_directory_tbl hd,rws_quality_control_tbl qc where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
                             + " a.programme_code in (" + programme + ")   and    b.DATE_OF_COMPLETION is not null and "
                             + " TARGET_DATE_COMP is not null  and b.work_id=qc.work_id and  a.CORE_DASHBOARD_STATUS='Y' and to_date(to_char(qc.inspection_date,'dd/mm/yyyy'),'dd/mm/yyyy') >=  to_date('"+fromDate+"','dd/mm/yyyy') and to_date(to_char(qc.inspection_date,'dd/mm/yyyy'),'dd/mm/yyyy') <= to_date('"+toDate+"','dd/mm/yyyy')";
             			
                              */
                              qcWorks = "select count(distinct a.work_id) from rws_work_admn_tbl a,rws_work_completion_tbl b"
                                      + ",rws_quality_control_tbl qc where WORK_CANCEL_DT is null and b.work_id=a.work_id   and "
                                      + " a.programme_code in (" + programme + ")   and    b.DATE_OF_COMPLETION is not null and "
                                      + " TARGET_DATE_COMP is not null  and b.work_id=qc.work_id and  a.CORE_DASHBOARD_STATUS='Y' and to_date(to_char(qc.inspection_date,'dd/mm/yyyy'),'dd/mm/yyyy') >=  to_date('"+fromDate+"','dd/mm/yyyy') and to_date(to_char(qc.inspection_date,'dd/mm/yyyy'),'dd/mm/yyyy') <= to_date('"+toDate+"','dd/mm/yyyy')";
                      			
                             
                if(mode.equals("circles")){ 
			qcWorks = qcWorks+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'"; 
		}else if(mode.equals("divisions")){
			qcWorks = qcWorks+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}else if(mode.equals("subdivisions")){
			qcWorks = qcWorks+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'"; 
		}
		//System.out.println("qcWorks: "+qcWorks)	;	
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(qcWorks);
		while(rs2.next()){
			  qcComp = rs2.getInt(1);
		}
		rs2.close();
		stmt2.close();
		
                
                /* compWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                        + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
                        + " a.programme_code in (" + programme + ")   and TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMPLETION)<='31-MAR-" + yearEnd + "'  and b.DATE_OF_COMPLETION is not null and "
                        + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "'  and  a.CORE_DASHBOARD_STATUS='Y'";
        			 */
                        /* compWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                                + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
                                + " a.programme_code in (" + programme + ")   and b.DATE_OF_COMPLETION is not null and "
                                + " TARGET_DATE_COMP is not null and  a.CORE_DASHBOARD_STATUS='Y'";
                			 */
                			 
                			 
                			 
                			 compWorks = "select count(distinct a.work_id) from rws_work_admn_tbl a,rws_work_completion_tbl b"
                                     + "  where WORK_CANCEL_DT is null and b.work_id=a.work_id and  "
                                     + " a.programme_code in (" + programme + ")   and b.DATE_OF_COMPLETION is not null and "
                                     + " TARGET_DATE_COMP is not null and  a.CORE_DASHBOARD_STATUS='Y'";
                     			
                			 
                if(mode.equals("circles")){ 
			compWorks = compWorks+" and substr(a.office_code,2,2)='"+res.getString("circle_office_code")+"'"; 
		}else if(mode.equals("divisions")){
			compWorks = compWorks+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+res.getString("division_office_code")+"'";
		}else if(mode.equals("subdivisions")){
			compWorks = compWorks+" and substr(a.office_code,2,2)='"+ccode+"' and substr(a.office_code,4,1)='"+divCode+"' and substr(a.office_code,5,2)='"+res.getString("subdivision_office_code")+"'"; 
		}
		//System.out.println("compWorks:----; "+compWorks)	;	
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(compWorks);
		while(rs2.next()){
			  worksComp = rs2.getInt(1);
		}
		rs2.close();
		stmt2.close();
		
		
		
		
		
		
		
		/* commWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
                + " a.programme_code in (" + programme + ") and b.DATE_OF_COMPLETION is not null and TO_DATE(b.DATE_OF_COMM) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMM)<='31-MAR-" + yearEnd + "' and b.DATE_OF_COMM is not null and "
                + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
		
                 */
                /* commWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                        + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
                        + " a.programme_code in (" + programme + ") and b.DATE_OF_COMPLETION is not null  and b.DATE_OF_COMM is not null and "
                        + " TARGET_DATE_COMP is not null  and  a.CORE_DASHBOARD_STATUS='Y'";
        		
                  */   
                  commWorks = "select count(distinct a.work_id) from rws_work_admn_tbl a,rws_work_completion_tbl b"
                          + " where WORK_CANCEL_DT is null and b.work_id=a.work_id and "
                          + " a.programme_code in (" + programme + ") and b.DATE_OF_COMPLETION is not null  and b.DATE_OF_COMM is not null and "
                          + " TARGET_DATE_COMP is not null  and  a.CORE_DASHBOARD_STATUS='Y'";
          		
                   
                
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
		

					 //String amountExpIncPhyCompNotFin = ndf.format((expIncBankPhyCompNotFin + expIncPhyCompNotFin) / 100000);
            // arfc = estCost - (bankLastYear + paoLastYear + bankLastMonth + paoLastMonth + bankCurrentMonth + paoCurrentMonth) / 100000;
            if(noOfWorks==0 && worksComp==0 
           ) {}else{
         %>
             <tr>            
                    <%
                    //int comp=Integer.parseInt(worksComp);
                    
                    %>
            
                      <td class="<%=style%>" style="text-align: right;" align="right"><%=++slno%></td>
                     <% if (mode.equals("circles")) {
                    	 //programme="04";
                    	 //System.out.println("!!!!!!!!!!fromDate"+fromDate);
                    	 ///////System.out.println("session!!!!!!!!!!fromDate"+session.getAttribute("fromDate"));%>
                      <td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_quality_control_min_circle_div_rpt.jsp?mode=divisions&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>&fromDate=<%=request.getParameter("fromDate") %>&toDate=<%=request.getParameter("toDate") %>"><%=cname%></a></td>
                      <%-- <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_qc_progress_min_abstract_drill.jsp?mode=tWorks&coc=<%=ccode%>&con=<%=programmeName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=noOfWorks%></a></td> --%>
                     <% } else if (mode.equals("divisions")) {   %>
                      <td class="<%=style%>" style="text-align: left;" align="left" ><a href="./rws_quality_control_min_circle_div_rpt.jsp?mode=subdivisions&programme=<%=programme%>&programmeName=<%=programmeName%>&ccode=<%=ccode%>&cname=<%=cname%>&divCode=<%=divCode%>&divname=<%=divName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>&fromDate=<%=request.getParameter("fromDate") %>&toDate=<%=request.getParameter("toDate") %>"><%=divName%></a></td>
<%--                       <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_qc_progress_min_abstract_drill.jsp?mode=tWorks&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=noOfWorks%></a></td>
 --%>                     <% } else if (mode.equals("subdivisions")) { %>
                   	 <td class="<%=style%>" style="text-align: left;" align="left" ><%=subdivName%></td>
<%--                       <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_qc_progress_min_abstract_drill.jsp?mode=tWorks&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=noOfWorks%></a></td>
 --%>                      <%   } %>
            
                      <%if (mode.equals("circles")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_qc_progress_min_abstract_drill.jsp?mode=cWorks&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksComp%></a></td>
                      <% } else if (mode.equals("divisions")) {  %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_qc_progress_min_abstract_drill.jsp?mode=cWorks&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksComp%></a></td>
                      <% } else if (mode.equals("subdivisions")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_qc_progress_min_abstract_drill.jsp?mode=cWorks&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksComp%></a></td>
                      <%}                         
                      if (mode.equals("circles")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_qc_progress_min_abstract_drill.jsp?mode=comWorks&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksComm%></a></td>
                      <% } else if (mode.equals("divisions")) {  %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_qc_progress_min_abstract_drill.jsp?mode=comWorks&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksComm%></a></td>
                      <% } else if (mode.equals("subdivisions")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_qc_progress_min_abstract_drill.jsp?mode=comWorks&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksComm%></a></td>
                      <%}
                      
                      if (mode.equals("circles")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_qc_progress_min_abstract_drill.jsp?mode=qcWorks&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>&fromDate=<%=request.getParameter("fromDate") %>&toDate=<%=request.getParameter("toDate") %>')"><%=qcComp%></a></td>
                      <% } else if (mode.equals("divisions")) {  %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_qc_progress_min_abstract_drill.jsp?mode=qcWorks&doc=<%=divCode%>&don=<%=divName%>&coc=<%=ccode%>&con=<%=cname%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>&fromDate=<%=request.getParameter("fromDate") %>&toDate=<%=request.getParameter("toDate") %>')"><%=qcComp%></a></td>
                      <% } else if (mode.equals("subdivisions")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_qc_progress_min_abstract_drill.jsp?mode=qcWorks&soc=<%=subdivCode%>&son=<%=subdivName%>&coc=<%=ccode%>&con=<%=cname%>&doc=<%=divCode%>&don=<%=divName%>&pc=<%=programme%>&pn=<%=programmeName%>&schemes=<%=schemes%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>&fromDate=<%=request.getParameter("fromDate") %>&toDate=<%=request.getParameter("toDate") %>')"><%=qcComp%></a></td>
                      <%}  
                              
                              
                              
                      if (mode.equals("circles")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><%=worksComp-qcComp%></td>
                      <% } else if (mode.equals("divisions")) {  %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><%=worksComp-qcComp%></td>
                      <% } else if (mode.equals("subdivisions")) { %>
                      <td class="<%=style%>" style="text-align: right;" align="right"><%=worksComp-qcComp%></td>
                      <%}  
                      
                      
                      
                              %>        
                     
                    
        		</tr>    
        			 
        <%       }
            	///// totNoOfWorks = totNoOfWorks + noOfWorks;
                 /* totEstCost = totEstCost + estCost;
                 totHabsSanctioned = totHabsSanctioned + habsSanctioned;
                 totfhtsSanctioned = totfhtsSanctioned + no_of_house_holds; */
                 totWorksComp = totWorksComp + worksComp;
                 totWorksComm = totWorksComm + worksComm;
                 totqcComp    = totqcComp+qcComp;
                 totqcinComp    = totqcinComp+(worksComp-qcComp);
                 
                // worksComp-qcComp
                 
                /*  totWorksNotGround = totWorksNotGround + worksNotGround;
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
                 totbillamt=totbillamt+billamount; */
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
                <%-- <td class="btext" style="text-align: right;"><%=totNoOfWorks%></td> --%>
                <td class="btext" style="text-align: right;"><%=totWorksComp%></td>
                <td class="btext" style="text-align: right;"><%=totWorksComm%></td>
                <td class="btext" style="text-align: right;"><%=totqcComp%></td>
                <td class="btext" style="text-align: right;"><%=totqcinComp%></td>
                
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