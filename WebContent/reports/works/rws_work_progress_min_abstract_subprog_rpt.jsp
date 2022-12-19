<%@page import="nic.watersoft.works.WorksData1"%>
<%@page import="java.sql.Connection"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%    DecimalFormat ndf = new DecimalFormat("####.00");
String scode="89";
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

    String pc = request.getParameter("pc");
    String pcn = request.getParameter("pn");
    String coc = request.getParameter("coc");
    String con = request.getParameter("con");
    String doc = request.getParameter("doc");
    String don = request.getParameter("don");
    
    String schemes=request.getParameter("scheme");
    String programme = request.getParameter("programme");
    String programName = request.getParameter("programmeName");
    String schemeName = request.getParameter("schemeName");
	
	//System.out.println(schemeName+"&&&&&&&&&&&&&&&&"+pc);
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
            <font color="#663899" face="Maiandra GD" size="4px"><b>Abstract Progress Report</b></font>
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
                <td class=btext >SNO</td>
                <td class=btext >Programme</td>
                <td class=btext >Sub Programme</td>
                <td class=btext >No. of<br/>Works</td>
                <td class=btext >Est. Cost</td>
                <td class=btext >Habs<br/>Sanc.</td>
                 <td class=btext >FHTC's for House Holds<br/>Sanc.</td>
                <td class=btext align="center">Works<br/>Not<br/>Grounded</td>
                <td class=btext align="center">Works<br/>Grounded</td>
                <td class=btext align="center">Works<br/>Under Progress</td>
                <td class=btext align="center">Works<br/>Comp.</td>
                <td class=btext align="center">Works<br/>Commmissioned</td>
                <td class=btext align="center">Habs<br/>Covered</td>
                <td class=btext align="center">FHTC's<br/>Provided  for House Holds</td>
                <td class=btext >Cumulative Exp.(as on date since inception)</td>
                <td class=btext >Exp. during year</td>
                <td class=btext >Exp. of Physically comp but financially not comp works during the year</td>
                <td class=btext >Total Exp. during the year</td>  
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
                    int totNoOfWorks = 0, totHabsSanctioned = 0, totWorksComp = 0, totHabsCov = 0, totWorksPhyCompNotFin = 0,totWorksNotGround=0,totWorksGround=0,totWorksUnderProgress=0,totWorksComm=0,provide_no_of_house_holds=0,no_of_house_holds=0;
                    long totPopBenf = 0, totPopCov = 0, popBenf = 0, popCov = 0, nrdwpPopBenf = 0, nrdwpPopCov = 0,totprovidefhtsSanctioned=0,totfhtsSanctioned=0;
                    double totarfc = 0, totEstCost = 0, totExpUptoFY = 0, totExpUptoLM = 0, totExpDM = 0, totTotExp = 0, expPhyCompNotFin = 0, bankPhyCompNotFin = 0,expIncBankPhyCompNotFin=0, paoPhyCompNotFin = 0,expIncPhyCompNotFin=0,totExpIncPhyCompNotFin=0, totExpPhyCompNotFin = 0, totalAmtInclPhyCompNotFin = 0;
                    //double arfc = 0, nrdwparfc = 0, nrdwpEstCost = 0, nrdwpExpUptoLFY = 0, nrdwpExpUptoLM = 0, nrdwpExpDM = 0, nrdwpTotExp = 0, nrdwpExpPhyCompNotFin = 0, nrdwpBankPhyCompNotFin = 0, nrdwpPaoPhyCompNotFin = 0, nrdwpTotExpPhyCompNotFin = 0, nrdwpAmtInclPhyCompNotFin = 0;
                    String query = "";
                    String mainProgramme = "",mainProgrammeName = "",dupeProgrammeName="";
                    String sa;
                    String oldprogName="";
                      double estCost = 0, bankYear = 0, bankLastMonth = 0, bankCurrentMonth = 0, paoYear = 0, paoLastMonth = 0, paoCurrentMonth = 0, expUptoLFY = 0, expUptoLM = 0, expDM = 0, TotExp = 0;
                        int noOfWorks = 0, habsSanctioned = 0, worksComp = 0, habsCov = 0, worksPhyCompNotFin = 0,worksNotGround=0,worksGround=0,worksUnderProgress=0,worksComm=0;
                   					
			             	String programmeQuery = "select a.PROGRAMME_CODE,PROGRAMME_NAME,SUBPROGRAMME_CODE,SUBPROGRAMME_NAME from  rws_programme_tbl a,rws_subprogramme_tbl b where a.PROGRAMME_CODE=b.PROGRAMME_CODE and a.PROGRAMME_CODE in("+ programme + ")";
			             	Statement statement1 = conn.createStatement();
			             	ResultSet resultSet1 = statement1.executeQuery(programmeQuery);
			             	//System.out.println(programmeQuery);
			             	while (resultSet1.next()) {
			             		programmeNam = resultSet1.getString("PROGRAMME_NAME");
			             		programme=resultSet1.getString("PROGRAMME_CODE");
			             		subProgrammeCode=resultSet1.getString("SUBPROGRAMME_CODE");
			             		subProgrammeName=resultSet1.getString("SUBPROGRAMME_NAME");
			             		
			             		if(pc.equals(scode) && schemeName.contains("laks")){
			    					
			    					if(schemeName.contains("Below 5 laks")){
			          
                        query = "select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"
                                + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") "
                                + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
                                + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5 ";                     
                   
                                
			    					}else
			    					{ query = "select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"
			                                + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") "
			                                + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
			                                + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
			                                + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5";                     
			                   }
			             		}else
			             		{ query = "select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"
		                                + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") "
		                                + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
		                                + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
		                                + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' ";                     
		                   }
                                
                                
                                
                                
                                
                                stmt = conn.createStatement();
                    rs = stmt.executeQuery(query);
                   if (rs.next()) {                    	
                        	names+=programmeNam+",";                       
                        noOfWorks = rs.getInt(2);
                        estCost = rs.getDouble(1);
                    }  
                   
                   
                   
String  totalFhtsProvideQry = "";
                   
                   if(pc.equals(scode) && schemeName.contains("laks")){
                       					
                       					if(schemeName.contains("Below 5 laks")){
                       						
                       						totalFhtsProvideQry = "select SUM(PENDING_FHTC) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
                       	                           + ", rws_habitation_directory_tbl hd where hd.hab_code=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                       	                           + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and  b.work_id=a.work_id  and  c.work_id(+)=a.work_id "
                       	                           + "and a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS<>'UI' and a.SANCTION_AMOUNT <=5";}else
                       					{
                       						totalFhtsProvideQry = "select SUM(PENDING_FHTC) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
                       	                           + ", rws_habitation_directory_tbl hd where hd.hab_code=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                       	                           + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and  b.work_id=a.work_id  and  c.work_id(+)=a.work_id "
                       	                           + "and a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS<>'UI' and a.SANCTION_AMOUNT >5";}
                   }else
                   {
                	   totalFhtsProvideQry = "select SUM(PENDING_FHTC) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
                           + ", rws_habitation_directory_tbl hd where hd.hab_code=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                           + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and  b.work_id=a.work_id  and  c.work_id(+)=a.work_id "
                           + "and a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS<>'UI'";
                   }
                                                   
                                                   // System.out.println("$$$$$$$$$$$sanctioned habs1"+sacHabs);
                                      
                                       //System.out.println("sanctioned habs"+sacHabs);
                                       stmt1 = conn.createStatement();
                                       rs1 = stmt1.executeQuery(totalFhtsProvideQry);
                                       if (rs1.next()) {
                                    	   provide_no_of_house_holds = rs1.getInt(1); 
                                           //popBenf = rs1.getLong(2);
                                       }
                                       
                                       stmt1.close();
                                       rs1.close(); 
                                       
                                       
                                    
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                  String  totalFhtsQry = "";
                   
                   if(pc.equals(scode) && schemeName.contains("laks")){
                       					
                       					if(schemeName.contains("Below 5 laks")){
                       						
                       						totalFhtsQry = "select SUM(TOTALHOUSEHOLDS) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
                       	                           + ", IMISMASTERDATA_TBL hd where hd.habcode=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                       	                           + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and  b.work_id=a.work_id  and  c.work_id(+)=a.work_id "
                       	                           + "and a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5 ";
                                          
                       					}else
                       					{
                       						totalFhtsQry = "select SUM(TOTALHOUSEHOLDS) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
                       	                           + ", IMISMASTERDATA_TBL hd where hd.habcode=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                       	                           + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and  b.work_id=a.work_id  and  c.work_id(+)=a.work_id "
                       	                           + "and a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5";
                                          }
                   }else
                   {
                	   totalFhtsQry = "select SUM(TOTALHOUSEHOLDS) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
                           + ", IMISMASTERDATA_TBL hd where hd.habcode=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                           + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and  b.work_id=a.work_id  and  c.work_id(+)=a.work_id "
                           + "and a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y'";
                   }
                                                   
                                                   // System.out.println("$$$$$$$$$$$sanctioned habs1"+sacHabs);
                                      
                                       //System.out.println("sanctioned habs"+sacHabs);
                                       stmt1 = conn.createStatement();
                                       rs1 = stmt1.executeQuery(totalFhtsQry);
                                       if (rs1.next()) {
                                    	   no_of_house_holds = rs1.getInt(1); 
                                           //popBenf = rs1.getLong(2);
                                       }
                                       
                                       stmt1.close();
                                       rs1.close(); 
                                       
                                       
                                    
                   
                   
                   
                   
                   
                   
                   
                   
                    String sacHabs = "";
                   
if(pc.equals(scode) && schemeName.contains("laks")){
    					
    					if(schemeName.contains("Below 5 laks")){
                        sacHabs = "select count(distinct b.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
                                + ", rws_habitation_directory_tbl hd where hd.hab_code=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and  b.work_id=a.work_id and COVERAGE_STATUS<>'UI' and  c.work_id(+)=a.work_id "
                                + "and a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5 ";
                       
    					}else
    					{sacHabs = "select count(distinct b.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
                                + ", rws_habitation_directory_tbl hd where hd.hab_code=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and  b.work_id=a.work_id and COVERAGE_STATUS<>'UI' and  c.work_id(+)=a.work_id "
                                + "and a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5";
                       }
}else
{sacHabs = "select count(distinct b.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
        + ", rws_habitation_directory_tbl hd where hd.hab_code=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
        + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and  b.work_id=a.work_id and COVERAGE_STATUS<>'UI' and  c.work_id(+)=a.work_id "
        + "and a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y'";
}
                                
                                // System.out.println("$$$$$$$$$$$sanctioned habs1"+sacHabs);
                   
                    //System.out.println("sanctioned habs"+sacHabs);
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(sacHabs);
                    if (rs1.next()) {
                        habsSanctioned = rs1.getInt(1); 
                        popBenf = rs1.getLong(2);
                    }
                    
                    stmt1.close();
                    rs1.close(); 
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    String Not_Grounded_Query="";  
if(pc.equals(scode) && schemeName.contains("laks")){
    					
    					if(schemeName.contains("Below 5 laks")){
                    
                    
                     Not_Grounded_Query="select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a,rws_programme_tbl p where a.work_id not in "
							   +"(select work_id from RWS_WORK_COMMENCEMENT_TBL where GROUNDING_DATE is not null ) and a.work_id not in " 
                       +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)  " 
                       +"and WORK_CANCEL_DT is null and a.programme_code=p.PROGRAMME_CODE and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y'  and  "
                       +"  a.PROGRAMME_CODE in ("+programme+") and a.subprogramme_code in (" + subProgrammeCode + ")  and TO_DATE(TARGET_DATE_COMP)>='01-APR-"+ yearStart+"' "
                       +" and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') ";
	                
    					}else
    					{
    						 Not_Grounded_Query="select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a,rws_programme_tbl p where a.work_id not in "
    								   +"(select work_id from RWS_WORK_COMMENCEMENT_TBL where GROUNDING_DATE is not null ) and a.work_id not in " 
    	                       +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)  " 
    	                       +"and WORK_CANCEL_DT is null and a.programme_code=p.PROGRAMME_CODE and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y'  and  "
    	                       +"  a.PROGRAMME_CODE in ("+programme+") and a.subprogramme_code in (" + subProgrammeCode + ")  and TO_DATE(TARGET_DATE_COMP)>='01-APR-"+ yearStart+"' "
    	                       +" and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') ";
    		                
    					}
    						
    					
}                    else{
	 Not_Grounded_Query="select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a,rws_programme_tbl p where a.work_id not in "
			   +"(select work_id from RWS_WORK_COMMENCEMENT_TBL where GROUNDING_DATE is not null ) and a.work_id not in " 
    +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)  " 
    +"and WORK_CANCEL_DT is null and a.programme_code=p.PROGRAMME_CODE and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y'  and  "
    +"  a.PROGRAMME_CODE in ("+programme+") and a.subprogramme_code in (" + subProgrammeCode + ")  and TO_DATE(TARGET_DATE_COMP)>='01-APR-"+ yearStart+"' "
    +" and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') ";
 
}

                       
                       
                       
                       stmt1 = conn.createStatement();
	                 rs1 = stmt1.executeQuery(Not_Grounded_Query);
	                 if (rs1.next()) {
	                   worksNotGround = rs1.getInt(1);    
	                 }
	                 stmt1.close();
	                 rs1.close();  
                    
                    String groundWorks = "";
if(pc.equals(scode) && schemeName.contains("laks")){
    					
    					if(schemeName.contains("Below 5 laks")){
                    
                    groundWorks = "select count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_new_est_tbl t ,"
                            + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") "
                            + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                            + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id and t.work_id=a.work_id "
                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5  ";
                    
    					}else
    					{groundWorks = "select count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_new_est_tbl t ,"
                                + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") "
                                + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id and t.work_id=a.work_id "
                                + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5";
                        }
}else
{groundWorks = "select count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_new_est_tbl t ,"
        + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") "
        + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
        + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id and t.work_id=a.work_id "
        + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' ";
}
                            
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(groundWorks);
                    if (rs1.next()) {
                      worksGround = rs1.getInt(1);    
                    }
                    stmt1.close();
                    rs1.close();
                    
                    
                    String underProgressWorks = "";
                    
if(pc.equals(scode) && schemeName.contains("laks")){
    					
    					if(schemeName.contains("Below 5 laks")){
                    underProgressWorks = "select count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_new_est_tbl t ,"
                            + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") "
                            + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null ) "
                            + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id and t.work_id=a.work_id "
                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5";
                    
                            
    					}else
    					{ underProgressWorks = "select count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_new_est_tbl t ,"
                                + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") "
                                + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null ) "
                                + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id and t.work_id=a.work_id "
                                + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5 ";
                        }
}else
{ underProgressWorks = "select count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_new_est_tbl t ,"
        + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") "
        + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null ) "
        + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id and t.work_id=a.work_id "
        + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' ";
}
                            
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(underProgressWorks);
                    if (rs1.next()) {
                      worksUnderProgress = rs1.getInt(1);    
                    }
                    stmt1.close();
                    rs1.close();
                    
                    String compWorks = "";
              
if(pc.equals(scode) && schemeName.contains("laks")){
    					
    					if(schemeName.contains("Below 5 laks")){
                    
                    
                	compWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                            + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id  and "
                            + " a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ")  and TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMPLETION)<='31-MAR-" + yearEnd + "' and b.DATE_OF_COMPLETION is not null and "
                            + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5 ";
                        
    					}else
    					{compWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                                + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id  and "
                                + " a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ")  and TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMPLETION)<='31-MAR-" + yearEnd + "' and b.DATE_OF_COMPLETION is not null and "
                                + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5 ";
                            }
}else
{compWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
        + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id  and "
        + " a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ")  and TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMPLETION)<='31-MAR-" + yearEnd + "' and b.DATE_OF_COMPLETION is not null and "
        + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
    }
                            
                            
                            
                   // System.out.println("COMPLTE habs"+compWorks);
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(compWorks);

                    if (rs1.next()) {
                        worksComp = rs1.getInt(1);
                       /*  habsCov = rs1.getInt(2);
                        popCov = rs1.getLong(3); */
                      }
                    stmt1.close();
                    rs1.close();
               
                    String commWorks = "";
                    
if(pc.equals(scode) && schemeName.contains("laks")){
    					
    					if(schemeName.contains("Below 5 laks")){
                	commWorks = "select count(distinct a.work_id) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                            + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id  and "
                            + " a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") and b.DATE_OF_COMPLETION is not null and TO_DATE(b.DATE_OF_COMM) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMM)<='31-MAR-" + yearEnd + "'  and b.DATE_OF_COMM is not null and "
                            + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5 ";
                   
    					}else
    					{commWorks = "select count(distinct a.work_id) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                                + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id  and "
                                + " a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") and b.DATE_OF_COMPLETION is not null and TO_DATE(b.DATE_OF_COMM) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMM)<='31-MAR-" + yearEnd + "'  and b.DATE_OF_COMM is not null and "
                                + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5";
                       }
}else
{commWorks = "select count(distinct a.work_id) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
        + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id  and "
        + " a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") and b.DATE_OF_COMPLETION is not null and TO_DATE(b.DATE_OF_COMM) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMM)<='31-MAR-" + yearEnd + "'  and b.DATE_OF_COMM is not null and "
        + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
}
                            
                            
                            // System.out.println("COMPLTE habs"+compWorks);
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(commWorks);
                    if (rs1.next()) {
                        worksComm= rs1.getInt(1);
                    }
                    stmt1.close();
                    rs1.close();
                    
                    String comphabs = "";
                    
if(pc.equals(scode)&& schemeName.contains("laks")){
    					
    					if(schemeName.contains("Below 5 laks")){
                    
                    
                	comphabs = "select count(distinct h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                            + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
                            + " a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") and ((TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart +"' and TO_DATE(b.DATE_OF_COMPLETION) <= '31-MAR-" + yearEnd +"' and b.DATE_OF_COMPLETION is not null) OR (TO_DATE(b.partial_date_of_completion) >= '01-APR-" + yearStart +"' and TO_DATE(b.partial_date_of_completion) <= '31-MAR-" + yearEnd +"' and b.DATE_OF_COMPLETION is null)) and "
                            + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5 ";
                            
    					}else
    					{comphabs = "select count(distinct h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                                + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
                                + " a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") and ((TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart +"' and TO_DATE(b.DATE_OF_COMPLETION) <= '31-MAR-" + yearEnd +"' and b.DATE_OF_COMPLETION is not null) OR (TO_DATE(b.partial_date_of_completion) >= '01-APR-" + yearStart +"' and TO_DATE(b.partial_date_of_completion) <= '31-MAR-" + yearEnd +"' and b.DATE_OF_COMPLETION is null)) and "
                                + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5";
                                }
}else
{comphabs = "select count(distinct h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
        + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
        + " a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") and ((TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart +"' and TO_DATE(b.DATE_OF_COMPLETION) <= '31-MAR-" + yearEnd +"' and b.DATE_OF_COMPLETION is not null) OR (TO_DATE(b.partial_date_of_completion) >= '01-APR-" + yearStart +"' and TO_DATE(b.partial_date_of_completion) <= '31-MAR-" + yearEnd +"' and b.DATE_OF_COMPLETION is null)) and "
        + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
        }
                            
                            
                            
                            // System.out.println("COMPLTE habs"+comphabs);
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(comphabs);
                    if (rs1.next()) {
                        /* worksComp = rs1.getInt(1); */
                       habsCov = rs1.getInt(1);
                        popCov = rs1.getLong(2);                 
                    }
                    stmt1.close();
                    rs1.close();                                 
                    
                    String bankCum = "";
if(pc.equals(scode) && schemeName.contains("laks")){
    					
    					if(schemeName.contains("Below 5 laks")){
                    
                      bankCum = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                          + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                          + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
                          + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'  and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "'  and a.SANCTION_AMOUNT <=5";               
                   
    					}else
    					{ bankCum = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
    	                          + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
    	                          + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
    	                          + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'  and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "'  and a.SANCTION_AMOUNT >5";               
    	                   }
}else
{ bankCum = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
        + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
        + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
        + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'  and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "'";               
 }
                          
                          
                          stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(bankCum);
                    if (rs1.next()) {
                        bankYear = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();
             	 String paoCum = "";  
             	 
             	if(pc.equals(scode)&& schemeName.contains("laks")){
					
					if(schemeName.contains("Below 5 laks")){
             	paoCum = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                            + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                            + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  "
                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.SANCTION_AMOUNT <=5  ";                  
                   
					}else
					{paoCum = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                            + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                            + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  "
                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.SANCTION_AMOUNT >5";                  
                   }
             	}else
             	{paoCum = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                        + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                        + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  "
                        + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "'";                  
               }
                            
                            stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(paoCum);
                    if (rs1.next()) {
                        paoYear = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();

                    String amountCum = ndf.format((bankYear + paoYear) / 100000);
                    
                   /*  String bankLM = "";                  
                        bankLM = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                        + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                        + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
                                        + "and BANK_SEND_DATE<'01-" + currentMonth + "-" + cyear + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and BANK_SEND_DATE>='01-APR-" + yearStart + "'";
                     stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(bankLM);
                    if (rs1.next()) {
                        bankLastMonth = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();
                  String paoLM = "";               
                        paoLM = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                            + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                            + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
                            + "and STATE_SEND_DATE<'01-" + currentMonth + "-" + cyear + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and STATE_SEND_DATE>='01-APR-" + yearStart + "'";
                                 
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(paoLM);
                    if (rs1.next()) {
                        paoLastMonth = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close(); */

                //    String amountLM = ndf.format((bankLastMonth + paoLastMonth) / 100000);
                    String bankCM = "";
if(pc.equals(scode) && schemeName.contains("laks")){
    					
    					if(schemeName.contains("Below 5 laks")){
                    
                        bankCM = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') "
                                + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' "
                                + "and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5 ";
                   
    					}else
    					{ bankCM = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') "
                                + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' "
                                + "and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5";
                   }
}else
{ bankCM = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
        + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') "
        + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' "
        + "and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
}
                                
                                stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(bankCM);
                    if (rs1.next()) {
                        bankCurrentMonth = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();
                    
               		String paoCM = ""; 
               		
               		
if(pc.equals(scode) && schemeName.contains("laks")){
    					
    					if(schemeName.contains("Below 5 laks")){
                     paoCM =  "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                             + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') "
                             + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "' "
                             + "and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5 ";
    					}else
    					{ paoCM =  "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') "
                                + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "' "
                                + "and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5";
       					}
}else
{ paoCM =  "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
        + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ") and a.subprogramme_code in (" + subProgrammeCode + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') "
        + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "' "
        + "and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
	}
                    
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(paoCM);
                    if (rs1.next()) {
                        paoCurrentMonth = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();

                    String amountTot = ndf.format((bankCurrentMonth + paoCurrentMonth) / 100000);

                   // String amountTot = ndf.format((bankLastMonth + paoLastMonth + bankCurrentMonth + paoCurrentMonth) / 100000);
                    
				    String phyCompNotFinBank = "";
				    
if(pc.equals(scode) && schemeName.contains("laks")){
    					
    					if(schemeName.contains("Below 5 laks")){
				    
                    phyCompNotFinBank =    "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
    						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
    	 					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "' "
    	 					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") and a.subprogramme_code in (" + subProgrammeCode + ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
    	 					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id and a.work_id in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') and a.SANCTION_AMOUNT <=5 ";
                  
    					}else{phyCompNotFinBank =    "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
        						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
        	 					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "' "
        	 					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") and a.subprogramme_code in (" + subProgrammeCode + ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
        	 					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id and a.work_id in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') and a.SANCTION_AMOUNT >5";
                      }
}else
{phyCompNotFinBank =    "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
		+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
			+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "' "
			+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") and a.subprogramme_code in (" + subProgrammeCode + ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
			+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id and a.work_id in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "')";
}
					//System.out.println("phyCompNotFinBank"+phyCompNotFinBank);
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(phyCompNotFinBank);
                    if (rs1.next()) {
                        bankPhyCompNotFin = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();

                    String phyCompNotFinPAO = ""; 
                    
                    
                    
if(pc.equals(scode)&& schemeName.contains("laks")){
    					
    					if(schemeName.contains("Below 5 laks")){
                    phyCompNotFinPAO ="select sum(nvl(BILL_AMOUT_STATE,0)) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
    						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
    	 					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "'  and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "'"
    	 					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") and a.subprogramme_code in (" + subProgrammeCode + ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
    	 					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id and a.work_id in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') and a.SANCTION_AMOUNT <=5";
                  
    					}else
    					{ phyCompNotFinPAO ="select sum(nvl(BILL_AMOUT_STATE,0)) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
        						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
        	 					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "'  and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "'"
        	 					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") and a.subprogramme_code in (" + subProgrammeCode + ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
        	 					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id and a.work_id in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') and a.SANCTION_AMOUNT >5";
                      }
}else
{ phyCompNotFinPAO ="select sum(nvl(BILL_AMOUT_STATE,0)) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
		+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
			+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "'  and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "'"
			+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") and a.subprogramme_code in (" + subProgrammeCode + ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
			+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id and a.work_id in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "')";
}
    	 					
    	 					
    	 					
                	//System.out.println("phyCompNotFinPAO"+phyCompNotFinPAO);
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(phyCompNotFinPAO);
                    if (rs1.next()) {
                        paoPhyCompNotFin = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();
                    
                    String amountPhyCompNotFin = ndf.format((bankPhyCompNotFin + paoPhyCompNotFin) / 100000);
                    
                    String ExpIncPhyCompNotFinBank = "";
                    
if(pc.equals(scode) && schemeName.contains("laks")){
    					
    					if(schemeName.contains("Below 5 laks")){
                    
                    ExpIncPhyCompNotFinBank =   "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
    						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
    	 					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "'"
    	 					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") and a.subprogramme_code in (" + subProgrammeCode + ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
    	 					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id  and a.SANCTION_AMOUNT <=5";
    					}else
    					{
    						ExpIncPhyCompNotFinBank =   "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
    	    						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
    	    	 					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "'"
    	    	 					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") and a.subprogramme_code in (" + subProgrammeCode + ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
    	    	 					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id  and a.SANCTION_AMOUNT >5";
    	    					
    					}
}else
{ExpIncPhyCompNotFinBank =   "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
		+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
			+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "'"
			+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") and a.subprogramme_code in (" + subProgrammeCode + ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
			+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";
	}
    	 					
    	 					
    	 					
    	 					//System.out.println("phyCompNotFinBank"+phyCompNotFinBank);
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(ExpIncPhyCompNotFinBank);
                    if (rs1.next()) {
                    	expIncBankPhyCompNotFin = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();

                    String ExpIncPhyCompNotFinPAO = "";  
                    
                    
if(pc.equals(scode)&& schemeName.contains("laks")){
    					
    					if(schemeName.contains("Below 5 laks")){
                    
                    ExpIncPhyCompNotFinPAO = "select sum(nvl(BILL_AMOUT_STATE,0)) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
    						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
    	 					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "'"
    	 					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") and a.subprogramme_code in (" + subProgrammeCode + ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
    	 					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id  and a.SANCTION_AMOUNT <=5 ";
                	
    					}
    					else
    					{ ExpIncPhyCompNotFinPAO = "select sum(nvl(BILL_AMOUT_STATE,0)) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
        						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
        	 					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "'"
        	 					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") and a.subprogramme_code in (" + subProgrammeCode + ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
        	 					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id and a.SANCTION_AMOUNT >5 ";
                    	}
}else
{ ExpIncPhyCompNotFinPAO = "select sum(nvl(BILL_AMOUT_STATE,0)) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
		+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
			+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "'"
			+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") and a.subprogramme_code in (" + subProgrammeCode + ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
			+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";
}
    	 					
    	 					//System.out.println("phyCompNotFinPAO"+ExpIncPhyCompNotFinPAO);
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(ExpIncPhyCompNotFinPAO);
                    if (rs1.next()) {
                    	expIncPhyCompNotFin = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();
                    
                    String amountExpIncPhyCompNotFin = ndf.format((expIncBankPhyCompNotFin + expIncPhyCompNotFin) / 100000);
                    //arfc = estCost - (bankLastYear + paoLastYear + bankLastMonth + paoLastMonth + bankCurrentMonth + paoCurrentMonth) / 100000;
                   if(noOfWorks==0 && estCost==0 && habsSanctioned==0 && worksComp==0 &&  habsCov==0 && popCov==0 &&
                   popBenf==0 && bankYear==0.0 && paoYear==0.0 && bankLastMonth ==0.0 && paoLastMonth==0.0 &&
                     bankCurrentMonth ==0.0 && paoCurrentMonth==0.0 && worksPhyCompNotFin==0.0&&bankPhyCompNotFin==0&&paoPhyCompNotFin==0)
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
                         <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=tWorks&pc=<%=programme%>&pn=<%=programmeNam%>&spc=<%=subProgrammeCode%>&spn=<%=subprogrammeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>&pc=<%=programme%>')"><%=noOfWorks%></a></td>
                         <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=ndf.format(estCost) %></td>
                         <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=sHabs&pc=<%=programme%>&pn=<%=programmeNam%>&spc=<%=subProgrammeCode%>&spn=<%=subprogrammeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>&pc=<%=programme%>')"><%=habsSanctioned%></a></td>
                                        <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=fhtcforsac&pc=<%=programme%>&pn=<%=programmeNam%>&spc=<%=subProgrammeCode%>&spn=<%=subprogrammeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>&pc=<%=programme%>')"><%=no_of_house_holds%></a></td>
                         <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=ngWorks&pc=<%=programme%>&pn=<%=programmeNam%>&spc=<%=subProgrammeCode%>&spn=<%=subprogrammeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>&pc=<%=programme%>')"><%=worksNotGround%></a></td>
                         <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=gWorks&pc=<%=programme%>&pn=<%=programmeNam%>&spc=<%=subProgrammeCode%>&spn=<%=subprogrammeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>&pc=<%=programme%>')"><%=worksGround%></a></td>
                         <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=uWorks&pc=<%=programme%>&pn=<%=programmeNam%>&spc=<%=subProgrammeCode%>&spn=<%=subprogrammeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>&pc=<%=programme%>')"><%=worksUnderProgress%></a></td>
                         <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=cWorks&pc=<%=programme%>&pn=<%=programmeNam%>&spc=<%=subProgrammeCode%>&spn=<%=subprogrammeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>&pc=<%=programme%>')"><%=worksComp%></a></td>
                         <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=comWorks&pc=<%=programme%>&pn=<%=programmeNam%>&spc=<%=subProgrammeCode%>&spn=<%=subprogrammeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>&pc=<%=programme%>')"><%=worksComm%></a></td> 	
                   		 <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=cHabs&pc=<%=programme%>&pn=<%=programmeNam%>&spc=<%=subProgrammeCode%>&spn=<%=subprogrammeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>&pc=<%=programme%>')"><%=habsCov%></a></td>
                   		  <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=fhtcforprovided&pc=<%=programme%>&pn=<%=programmeNam%>&spc=<%=subProgrammeCode%>&spn=<%=subprogrammeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>&pc=<%=programme%>')"><%=provide_no_of_house_holds%></a></td>
                       	 <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=amountCum%></td>
	                     <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=amountTot%></td>
	                     <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=amountPhyCompNotFin%></td>
	                     <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=amountExpIncPhyCompNotFin%></td>
			         </tr>
                <%
               
                oldprogName=programmeNam;
                   }
			             	
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
                        //totarfc = totarfc + arfc;
                        totWorksPhyCompNotFin = totWorksPhyCompNotFin + worksPhyCompNotFin;
                        totExpPhyCompNotFin = totExpPhyCompNotFin+ bankPhyCompNotFin + paoPhyCompNotFin;
                        totExpIncPhyCompNotFin = totExpIncPhyCompNotFin+ expIncBankPhyCompNotFin + expIncPhyCompNotFin;
                        totprovidefhtsSanctioned = totprovidefhtsSanctioned + provide_no_of_house_holds;

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

