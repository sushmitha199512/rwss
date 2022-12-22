
<%@page import="nic.watersoft.works.WorksData1"%>
<%@page import="java.sql.Connection"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%    DecimalFormat ndf = new DecimalFormat("####.00");

    int NRDWPhabsSanctioned12=0;

	HashMap programmeName = new HashMap();
	int count = 1;
    String sub = "ALL";
    String mode = "initial";

    if (request.getParameter("sub") != null) {
        sub = (String) request.getParameter("sub");
    }
    if (request.getParameter("mode") != null) {
        mode = request.getParameter("mode");
    }

    String pcd = request.getParameter("pc");
    String pcn = request.getParameter("pn");
    String coc = request.getParameter("coc");
    String con = request.getParameter("con");
    String doc = request.getParameter("doc");
    String don = request.getParameter("don");
    
    String schemes=request.getParameter("scheme");
    String programme = request.getParameter("programme");
    String programName = request.getParameter("programmeName");
    String programe = "";
    String subProgrammeCode="",subProgrammeName="";
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
    yearStart=Integer.parseInt( request.getParameter("yearStart"));
    yearEnd=Integer.parseInt(request.getParameter("yearEnd"));
    /* if (month <= 3) {
        yearStart = cyear - 1;
        yearEnd = cyear;
    } else {
        yearStart = cyear;
        yearEnd = cyear + 1;
    } */
    String ye=""+yearEnd;
    ye=ye.substring(2,4).toString();
    
    int yEnd=Integer.parseInt(ye);
    
    String InputPhyFinStr="";
    HashMap ongoingWorks = new HashMap();
	HashMap completedWorks = new HashMap();
	HashMap progMap = new HashMap();
	
	HashMap sanctionedHabs = new HashMap();
	HashMap coveredHabs = new HashMap();
	
	HashMap estimatedCost = new HashMap();
	HashMap expenditure = new HashMap();
	HashMap balanceEstimatedCost = new HashMap();
	
	String names="";

%>
<html>
<script src="/pred/resources/graphs/jquery.min.js"></script>

<script language="JavaScript">



    function viewWorks(URL)
    {

        var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
        if (URL != "")
        {
            myNewWin = window.open(URL, 'newWinddow', popFeatures);
            myNewWin.focus();
        }
    }

    function wopen(url, name, w, h)
    {
        w += 32;
        h += 96;
        var win = window.open(url,
                name,
                'width=' + w + ', height=' + h + ', ' +
                'location=yes, menubar=no, ' +
                'status=yes, toolbar=no, scrollbars=yes, resizable=yes');
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
<script language="JavaScript" src="<rws:context page='/resources/javascript/wz_tooltip1.js'/>"></script>
    <br/>
    <br/>
    <form name=f1 id="f1" method="post" action="rws_work_progress_abstract_list1.jsp">
        <center>
            <font color="#663899" face="Maiandra GD" size="4px"><b>ABSTRACT REPORT - WEEKLY REVIEW BY HON'BLE CHIEF SECRETARY WITH DISTRICT COLLECTORS</b></font>
            <br/><br/><font color="#889900" face="Maiandra GD" size="3px"  >Programme: <%=programName %>
            <%
                if (request.getParameter("con") != null) {
            %>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Circle: <%=request.getParameter("con")%>
            <%
                }
                if (request.getParameter("don") != null) {
            %>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Division: <%=request.getParameter("don")%>
            <%
                }
            %>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Year: <%=yearStart%>-<%=yEnd%></font>
        </center>

        <br/><br/>
        <%
			if (!mode.equals("initial") ) {
		%>
		<table align="center"
			style="margin-top: -35px !important; width: 1050px !important; text-align: center !important;">
			<tr>
				<td style="width: 950px !important;"></td>
				<td style="width: 100px !important;" align="right"><a
					href="javascript:history.back(-1)"><img	src="/pred/resources/graphs/go_back.gif" height="30px" /></a>&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		<%
			} else {
		%>
		<table align="center"
			style="margin-top: -45px !important; width: 1050px !important; text-align: center !important;">
			<tr>
				<td style="width: 1000px !important; text-align: left !important;"><font
					color="#889900" face="Maiandra GD" size="2px">(Rs. Lakhs)</font></td>
					<td style="width: 40px !important;">
                    <!-- <a href="rws_work_progress_CM_abstract_rpt.jsp?programme=00&mode1=Bar" style="color: green !important; font-size: 13px;" id="showGraph"><img height="30px" src="/pred/resources/graphs/bar.ico"></a> --></td>
                     
				<td style="width: 100px !important;" align="right"><a
					href="javascript:history.back(-1)"><img	src="/pred/resources/graphs/go_back.gif" height="30px" /></a>&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		<%
			}
		%>
		<br/><br/>
        <table border=1 cellspacing=0 cellpadding=0 height=5% width="800px" class="baseTable"
               bordercolor=#000000 style="border-collapse: collapse; margin-top: -15px !important; "
               bgcolor="#ffffff" align="center">
             <tr align=center align=center class="thead">
                <td class=btext rowspan=2>SNO</td>
                <td class=btext rowspan=2>Programme</td>
                <td class=btext rowspan=2>Sub Programme</td>
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
                String programmeNam = "",subprogrammeNam = "";
                Connection connection = null;
                Statement stmt1 = null;
                ResultSet rs1 = null;
                int slno = 0;
                try {
                	   int totNoOfWorks = 0,  totWorksComp = 0, totWorksNotGround=0,totWorksUnderProgress=0,totWorksUnderProgress25=0,totWorksUnderProgress50=0,totWorksUnderProgress75=0,totWorksUnderProgress100=0,totWorksComm=0;
                       long totPopBenf = 0, totPopCov = 0, popBenf = 0, popCov = 0, nrdwpPopBenf = 0, nrdwpPopCov = 0;
                       double totEstCost = 0, totAmountLFI=0,totTotExp=0,totToBePaid=0,totValueOfWork=0,totTotPaymentsMade=0;
                    String query = "";
                    String mainProgramme = "",mainProgrammeName = "",dupeProgrammeName="";
                    String sa;
                    String schemeName="",oldprogName="";
                    double estCost = 0, bankYear = 0, paoYear = 0,bankLastYear=0,paoLastYear=0,amountLFI=0;
                    int noOfWorks= 0,worksComp = 0, worksNotGround=0,worksUnderProgress=0,worksComm=0,worksUnderProgress25=0,worksUnderProgress50=0,worksUnderProgress75=0,worksUnderProgress100=0;
                   					
			             	String programmeQuery = "select a.PROGRAMME_CODE,PROGRAMME_NAME,SUBPROGRAMME_CODE,SUBPROGRAMME_NAME from  rws_programme_tbl a,rws_subprogramme_tbl b where a.PROGRAMME_CODE=b.PROGRAMME_CODE and a.PROGRAMME_CODE in("+ programme + ")";
			             	Statement statement1 = conn.createStatement();
			             	ResultSet resultSet1 = statement1.executeQuery(programmeQuery);
			             	//System.out.println(programmeQuery);
			             	while (resultSet1.next()) {
			             		programmeNam = resultSet1.getString("PROGRAMME_NAME");
			             		programme=resultSet1.getString("PROGRAMME_CODE");
			             		subProgrammeCode=resultSet1.getString("SUBPROGRAMME_CODE");
			             		subProgrammeName=resultSet1.getString("SUBPROGRAMME_NAME");	     	
			          
                        query = "select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"
                                + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") "
                                + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
                                + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' ";                     
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(query);
                   if (rs.next()) {                    	
                        	names+=programmeNam+",";                       
                        noOfWorks = rs.getInt(2);
                        estCost = rs.getDouble(1);
                    }                             
                                    
                    stmt.close();
                    rs.close();  
                    
                    String Not_Grounded_Query="select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a,rws_programme_tbl p where a.work_id not in "
							   +"(select work_id from RWS_WORK_COMMENCEMENT_TBL where GROUNDING_DATE is not null ) and a.work_id not in " 
                       +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)  " 
                       +"and WORK_CANCEL_DT is null and a.programme_code=p.PROGRAMME_CODE and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y'  and  "
                       +"  a.PROGRAMME_CODE in ("+programme+") and a.subprogramme_code in (" + subProgrammeCode + ")  and TO_DATE(TARGET_DATE_COMP)>='01-APR-"+ yearStart+"' "
                       +" and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') ";
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
                            + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") "
                            + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null ) "
                            + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id and t.work_id=a.work_id "
                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' ";
                    
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
                    
                    String compWorks = "";
                	compWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                            + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id  and "
                            + " a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ")  and TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMPLETION)<='31-MAR-" + yearEnd + "' and b.DATE_OF_COMPLETION is not null and "
                            + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(compWorks);
                    if (rs1.next()) {
                        worksComp = rs1.getInt(1);
                      }
                    stmt1.close();
                    rs1.close();
               
                    String commWorks = "";
                	commWorks = "select count(distinct a.work_id) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                            + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id  and "
                            + " a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") and b.DATE_OF_COMPLETION is not null and TO_DATE(b.DATE_OF_COMM) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMM)<='31-MAR-" + yearEnd + "'  and b.DATE_OF_COMM is not null and "
                            + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
                    // System.out.println("COMPLTE habs"+compWorks);
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(commWorks);
                    if (rs1.next()) {
                        worksComm= rs1.getInt(1);
                    }
                    stmt1.close();
                    rs1.close();
                    
                                 
                    String bankLFI = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                            + "where WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and a.subprogramme_code in (" + subProgrammeCode + ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                            + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and TO_DATE(BANK_SEND_DATE)<='31-MAR-" + yearStart + "' "
                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
 		               stmt1 = conn.createStatement();
 		               rs1 = stmt1.executeQuery(bankLFI);
 		               if (rs1.next()) {
 		                   bankLastYear = rs1.getDouble(1);
 		               }
 		               stmt1.close();
 		               rs1.close();
 		               String paoLFI = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
 		                       + "where WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and a.subprogramme_code in (" + subProgrammeCode + ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
 		                       + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and TO_DATE(STATE_SEND_DATE)<='31-MAR-" + yearStart + "' "
 		                       + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
 		               stmt1 = conn.createStatement();
 		               rs1 = stmt1.executeQuery(paoLFI);
 		               if (rs1.next()) {
 		                   paoLastYear = rs1.getDouble(1);
 		               }
 		               stmt1.close();
 		               rs1.close();
 		                amountLFI = bankLastYear + paoLastYear ;
 		                
                    String bankCum = "";
                      bankCum = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                          + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                          + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
                          + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "'";               
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(bankCum);
                    if (rs1.next()) {
                        bankYear = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();
             	 String paoCum = "";                  
             	paoCum = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                            + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                            + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  "
                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "'";                  
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(paoCum);
                    if (rs1.next()) {
                        paoYear = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();

                    String amountCum = ndf.format((bankYear + paoYear) / 100000);
                    String paymentsMade=ndf.format((bankYear + paoYear + amountLFI) / 100000);
                    double valOfWorkDone=0;
                    String valOfWorkDoneQry = "select sum(nvl(PERCENT_COMPLETED_VAL,0)) from RWS_MILESTONE_TARGET_ACH_TBL v,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"
                            + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") "
                            + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                            + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and v.work_id=a.work_id ";
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(valOfWorkDoneQry);
                    if (rs1.next()) {
                  	  valOfWorkDone=rs1.getDouble(1);
                    } 
                    stmt1.close();
                    rs1.close();
                    
                    
                    String partAAmount = "select sum(nvl(BILL_AMT_CONTRACTOR,0)) from RWS_WORK_BILL_TBL v,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"
                            + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") "
                            + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                            + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and v.work_id=a.work_id and BILL_TYPE='A'";
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(partAAmount);
                    if (rs1.next()) {
                  	  valOfWorkDone+=rs1.getDouble(1);
                    } 
                    stmt1.close();
                    rs1.close();
                    
                   double toBePaid=valOfWorkDone-(bankYear + paoYear + amountLFI);
                   
                    if(noOfWorks==0 && estCost==0 && amountLFI==0 && worksComp==0 && bankYear==0 && paoYear==0 && worksComm==0 && worksNotGround== 0 && worksUnderProgress==0
                 		   && worksUnderProgress25==0 && worksUnderProgress50==0 && worksUnderProgress75==0&& worksUnderProgress100==0)
                 {}else{     	 
                	 if (styleCount % 2 == 0) {
                         style = "gridbg1";
                     } else {
                         style = "gridbg2";
                     }
                     styleCount++;  
                %>
                     <tr>  
                         <%if(!oldprogName.equals(programmeNam)){ %>
                         <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><%=++slno%></td>
                         <td class="<%=style%>" style="text-align: left;" align="right" width="100px"><%=programmeNam%></td>
                         <%}else{ %>
                         <td class="<%=style%>" style="text-align: right;" align="right" width="50px"></td>
                         <td class="<%=style%>" style="text-align: left;" align="right" width="100px"></td>
                         <%} %>
                         <td class="<%=style%>" style="text-align: left;" align="right" width="100px"><%=subProgrammeName%></td>
                         <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=tWorks&pc=<%=programme%>&pn=<%=programmeNam%>&spc=<%=subProgrammeCode%>&spn=<%=subprogrammeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=noOfWorks%></a></td>
                         <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=ndf.format(estCost) %></td>
                         <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=ndf.format(amountLFI/100000) %></td>
                         <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=ngWorks&pc=<%=programme%>&pn=<%=programmeNam%>&spc=<%=subProgrammeCode%>&spn=<%=subprogrammeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksNotGround%></a></td>
                         <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=cWorks&pc=<%=programme%>&pn=<%=programmeNam%>&spc=<%=subProgrammeCode%>&spn=<%=subprogrammeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksComp%></a></td>
                         <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=comWorks&pc=<%=programme%>&pn=<%=programmeNam%>&spc=<%=subProgrammeCode%>&spn=<%=subprogrammeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksComm%></a></td> 	
                       	 <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=uWorks25&pc=<%=programme%>&pn=<%=programmeNam%>&spc=<%=subProgrammeCode%>&spn=<%=subprogrammeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksUnderProgress25%></a></td>
                         <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=uWorks50&pc=<%=programme%>&pn=<%=programmeNam%>&spc=<%=subProgrammeCode%>&spn=<%=subprogrammeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksUnderProgress50%></a></td>
                         <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=uWorks75&pc=<%=programme%>&pn=<%=programmeNam%>&spc=<%=subProgrammeCode%>&spn=<%=subprogrammeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksUnderProgress75%></a></td>
                         <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=uWorks100&pc=<%=programme%>&pn=<%=programmeNam%>&spc=<%=subProgrammeCode%>&spn=<%=subprogrammeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksUnderProgress100%></a></td>
                         <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><a href="#" onclick="viewWorks('./rws_work_progress_cs_abstract_drill.jsp?mode=uWorks&pc=<%=programme%>&pn=<%=programmeNam%>&spc=<%=subProgrammeCode%>&spn=<%=subprogrammeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=worksUnderProgress%></a></td>
                         <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=ndf.format(valOfWorkDone/100000) %></td>
	                     <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=paymentsMade %></td>
	                     <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=ndf.format(toBePaid/100000) %></td>
	                     <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=amountCum %></td>
			         </tr>
                <%
               
                oldprogName=programmeNam;
                   }
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
                    totToBePaid=totToBePaid+toBePaid;
                    
                    totValueOfWork=totValueOfWork+valOfWorkDone;
                    totTotPaymentsMade = totTotPaymentsMade + bankYear+paoYear+amountLFI;
			             	}
			             	resultSet1.close();
			             	statement1.close();
                   
                    stmt.close();
                    rs.close();
                    if (slno == 0) {
                %>
            <tr>
                <td colspan="15" class="<%=style%>" style="text-align: center;">NO Records Found</td>
            </tr>
            <%
                }      
                 
            %>
            <tr class="rightPad">
                <td class="btext" style="text-align: right;" colspan=3>Total:</td>
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
    <br/>
  

    <table height="20px" align="center">
        <tr height="1%">
            <td align="center" valign="bottom" style="font-family:verdana;font-size:8pt;font-weight:bold;width:100%;color:#6600CC;">
                Source: <a href="http://rwss.ap.nic.in" target="_blank">WaterSoft</a>, Designed & Developed by <a href="http://www.nic.in" target="_blank">National Informatics Centre</a>, AP State Centre
            </td>
        </tr>
    </table>
    <br/>
</body>
</html>

