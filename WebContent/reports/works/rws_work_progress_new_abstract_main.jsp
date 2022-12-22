<%@page import="nic.watersoft.works.WorksData1"%>
<%@page import="java.sql.Connection"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%    DecimalFormat ndf = new DecimalFormat("####.00");
      String scode="89";
    int NRDWPhabsSanctioned12=0;
	String InputWorkProStr="";
	HashMap programmeName = new HashMap();
	int count = 1;
  	
    String programe = "";
    String programName = ""; 
    String progCode = ""; 
    String progCodeNRDWP = "";  
    HashMap programmeList = new HashMap();
    

    String nrdwpQuery = "select PROGRAMME_CODE from  rws_programme_tbl where NRDWP_RELATED='Y' and CENTRE_STATE_DISTRICT<>'D' order by 1";
    Statement statement = conn.createStatement();
    ResultSet resultSet = statement.executeQuery(nrdwpQuery);
    while (resultSet.next()) {
    	if (!progCode.equals("")) {
    		progCode = progCode + "," + resultSet.getString(1);
    		progCodeNRDWP=progCodeNRDWP + "," + resultSet.getString(1);
    	} else {
    		progCode = resultSet.getString(1);
    		progCodeNRDWP=resultSet.getString(1);
    	}
    	
    }

    resultSet.close();
    statement.close();
    int x=1;
    
    programmeList.put(x, progCode+"@NRDWP RELATED");
    
    String nrdwpSubQuery = "select PROGRAMME_CODE,PROGRAMME_NAME from  rws_programme_tbl where NRDWP_RELATED='N' and CM_CORE_DB='Y' and CENTRE_STATE_DISTRICT<>'D' and PROGRAMME_NAME like '%NRDWP%' order by 1";
    Statement statementn = conn.createStatement();
    ResultSet resultSetn = statementn.executeQuery(nrdwpSubQuery);
    while (resultSetn.next()) {
    	x++;
    	programmeList.put(x,resultSetn.getString(1)+"@NRDWP RELATED");
    	progCodeNRDWP+=","+resultSetn.getString(1);
    }
    resultSetn.close();
    statementn.close();
    
    String CmDBQuery = "select PROGRAMME_CODE,PROGRAMME_NAME from  rws_programme_tbl where CM_CORE_DB='Y' and NRDWP_RELATED='N' and CENTRE_STATE_DISTRICT<>'D' and PROGRAMME_NAME not like '%NRDWP%' order by 1";
    Statement stmtCmDB = conn.createStatement();
    ResultSet rsCmDB = stmtCmDB.executeQuery(CmDBQuery);
    while (rsCmDB.next()) {
    	x++;
    	programmeList.put(x,rsCmDB.getString(1)+"@"+rsCmDB.getString(2));
    }
    x++;
    programmeList.put(x,scode+"@"+"JJM"); //JJM works below 5laks above 5 laks
    ///System.out.println("programme list NRDWP"+programmeList);
   
    //String schemes = "'01','02','03','10'";
    String schemesSizeTemp = "below5";
    String schemes="";
    String schemesTot="01,02,03,10";
    HashMap schemesList = new HashMap();
    schemesList.put(1,"01,02");
    schemesList.put(2,"03");
    schemesList.put(3,"10");
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
    int startFinYear=0;
    if (month <= 3) {
    	startFinYear = cyear - 1;
       
    } else {
    	startFinYear = cyear;
       
    }
    String ye=""+yearEnd;
    ye=ye.substring(2,4).toString();
    
    int yEnd=Integer.parseInt(ye);
    
    String InputPhyFinStr="";
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
    <form name=f1 id="f1" >
        <center>
            <font color="#663899" face="Maiandra GD" size="4px"><b>Abstract Progress Report</b></font>
            <br/><br/><font color="#889900" face="Maiandra GD" size="3px"  >Programme: ALL
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
       
     <br>
     <br>
		<table align="center"
			style="margin-top: -45px !important; width: 1050px !important; text-align: center !important;">
			<tr>
				<td style="width: 1000px !important; text-align: left !important;"><font
					color="#889900" face="Maiandra GD" size="2px">(Rs. Lakhs)</font></td>
					<td style="width: 40px !important;">
                    <!-- <a href="rws_work_progress_CM_abstract_rpt.jsp?programme=00&mode1=Bar" style="color: green !important; font-size: 13px;" id="showGraph"><img height="30px" src="/pred/resources/graphs/bar.ico"></a> --></td>
                     
				<td style="width: 50px !important; text-align: right !important">
					<!--  <a
					href="rws_work_progress_CM_abstract_rpt.jsp?programme=00&mode1=Pie"
					 style="color: green !important; font-size: 13px;"
					id="showGraph"><img width="30px"
						src="/pred/resources/graphs/pie.png"></a> --> &nbsp;&nbsp;
				</td> 
			</tr>
		</table>
		
		<br/><br/>
        <table border=1 cellspacing=0 cellpadding=0 height=5% width="800px" class="baseTable"
               bordercolor=#000000 style="border-collapse: collapse; margin-top: -15px !important; "
               bgcolor="#ffffff" align="center">
            <tr align=center align=center class="thead">
                <td class=btext rowspan="2">SNO</td>
                <td class=btext rowspan="2">&nbsp;Main&nbsp;Programme&nbsp;</td>
                <td class=btext rowspan="2">Programme</td>
               <!--  <td class=btext >Sub Programme</td>
                <td class=btext >Scheme-No. of<br/>Works</td> -->
		 	<td class=btext rowspan="2">Works Sanctioned</td>
		 	<td class=btext rowspan="2" >Est. Cost</td>
            <td class=btext rowspan="2">No of Works Cancelled</td>
            <td class=btext rowspan="2">Est. Cost</td>
            <td class=btext  colspan="2">Achivements upto Previous year</td>
           <td class=btext  colspan="7">Balance Program for the current financial year</td>
          </tr>

          <tr> 
           <td class=btext align="center"  >Works<br/>Completed</td>
            <td class=btext align="center" >Expenditure for all works</td>
             <td class=btext align="center"  >Works</td>
             <td class=btext align="center" >Bal. Cost</td>
              <td class=btext align="center" >Expenditure</td>
            <td class=btext align="center" >Works<br/>Not<br/>Grounded</td>
            <td class=btext align="center"  >Works<br/>Grounded</td>
            <td class=btext align="center" >Works<br/>Comp.</td>
            <td class=btext >Bills raised so far</td>  
          </tr> 
        
            <%
                int styleCount = 0;
                String style = "";
            %>
            <%
                Connection connection = null;
                Statement stmt1 = null;
                ResultSet rs1 = null;
                int slno = 0;
                try {
                	double totbillamt=0.0,totCancelEstCst=0.0,totCurrBalCost=0,totPrevExp=0.0,totBalCost=0.0,totCurrExp=0.0;
                    int totCancelWork = 0,totCurrWorks=0,currentYearWorks = 0,prevCompWorks=0,totNoOfWorks = 0, noOfCancelWorks = 0,totHabsSanctioned = 0, totWorksComp = 0, totHabsCov = 0, totWorksPhyCompNotFin = 0, totWorksNotGround=0,totWorksGround=0,totWorksUnderProgress=0,totWorksComm=0,totPrevWorks = 0;
                    long totPopBenf = 0, totPopCov = 0,  popCov = 0, nrdwpPopBenf = 0, nrdwpPopCov = 0,totHouseholds=0,totfhtsprovided=0;
                    double expUptoPrevYearPAO = 0,totarfc = 0,estCostCancelWorks = 0, totEstCost = 0, totExpUptoFY = 0, totExpUptoLM = 0, totExpDM = 0, totTotExp = 0, expPhyCompNotFin = 0, bankPhyCompNotFin = 0,expIncBankPhyCompNotFin=0, paoPhyCompNotFin = 0,expIncPhyCompNotFin=0,totExpIncPhyCompNotFin=0, totExpPhyCompNotFin = 0, totalAmtInclPhyCompNotFin = 0;
                  //  double arfc = 0, nrdwparfc = 0, nrdwpEstCost = 0, nrdwpExpUptoLFY = 0, nrdwpExpUptoLM = 0, nrdwpExpDM = 0, nrdwpTotExp = 0, nrdwpExpPhyCompNotFin = 0, nrdwpBankPhyCompNotFin = 0, nrdwpPaoPhyCompNotFin = 0, nrdwpTotExpPhyCompNotFin = 0, nrdwpAmtInclPhyCompNotFin = 0;
                    String query = "";
                    String programme = "";
                    String mainProgramme = "",mainProgrammeName = "",dupeProgrammeName="";
                    String sa;
                    String schemeName="",oldprogName="";
                                      
                   
                    for (int i = 1; i <= programmeList.size(); i++){
                    	
                    	for(int j=1;j<=schemesList.size();j++){
                    		
                        	schemes=(String) schemesList.get(j);
                        	if(schemes.equals("03")){
                        	schemeName="MVS";
                        	}
                        	else if(schemes.equals("10")){
                            	schemeName="Sustainability";
                            }
                        	else{
                        		schemeName="SVS";
                        	}
                        	
                        	
                    	//89 jjm
                        double expUptoPrevYearBank = 0,texpUptoPrevYear = 0,estCost = 0,balCost = 0, bankYear = 0, bankLastMonth = 0, bankCurrentMonth = 0, paoYear = 0, paoLastMonth = 0, paoCurrentMonth = 0, expUptoLFY = 0, expUptoLM = 0, expDM = 0, TotExp = 0;
                        int noOfWorks = 0, habsSanctioned = 0, worksComp = 0, habsCov = 0, worksPhyCompNotFin = 0, worksNotGround=0,worksGround=0,worksUnderProgress=0;
                        double billamount=0;
                   						programme = (String) programmeList.get(i);
                   						
                                    	String ar[]=programme.split("@");
                                    	programme=ar[0];
                                    	mainProgrammeName=ar[1];
                                    	//System.out.println("programme-----"+programme+" schemeName:"+schemeName);
                          String programmeNam = "";
					    if (programme.length() > 2) {
					   
					    	 programmeNam = "NRDWP";
			           	} else {
			             	String programmeQuery = "select PROGRAMME_CODE,PROGRAMME_NAME from  rws_programme_tbl where PROGRAMME_CODE='"+ programme + "'";
			             	Statement statement1 = conn.createStatement();
			             	ResultSet resultSet1 = statement1.executeQuery(programmeQuery);
			             	if (resultSet1.next()) {
			             		programmeNam = resultSet1.getString("PROGRAMME_NAME");
			             	}
			             	resultSet.close();
			             	statement.close();
			             	} 
					   // System.out.println(" programme name  :" +programmeNam+" i val :"+i+" j val :"+j);
					    query =     "select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p "
	                           +" where  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") and  "
								+"  a.TYPE_OF_ASSET in (" + schemes + ")   "
								+"   ";
					    if(programme.equals(scode)){
					    	if(schemesSizeTemp.equals("below5")){
					    		schemeName +=" (Below 5 laks)";
					    		 query += " and a.SANCTION_AMOUNT <=5 ";
					    	}else{
					    		schemeName +=" (Above 5 laks)";
					    		 query += " and a.SANCTION_AMOUNT >5 ";
					    	}
					    	
					    	if(j==schemesList.size())
					    	schemesSizeTemp ="above5";
					    }
                      
                	//System.out.println("Query main :"+query);
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(query);
                   if (rs.next()) {                    	
                        	names+=programmeNam+",";                       
                        noOfWorks = rs.getInt(2);
                        estCost = rs.getDouble(1);
                        if(estCost != 0)
                        	estCost = estCost/100000;
                        
                    }   
                   
                   
                  String prevWorksQry    =     "select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a "
							+" where a.work_id in (select work_id from rws_work_completion_tbl where  "
						+" DATE_OF_COMPLETION<'01-APR-" + yearStart + "')   and  a.TYPE_OF_ASSET in (" + schemes + ") and "
						+"  a.PROGRAMME_CODE in (" + programme + ")   ";
                   
                  
                   if(programme.equals(scode)){
                   	if(schemesSizeTemp.equals("below5")){
				    		//schemeName +=" (Below 5 laks)";
                   		prevWorksQry += " and a.SANCTION_AMOUNT <=5";
				    	}else{
				    		//schemeName +=" (Above 5 laks)";
				    		prevWorksQry += " and a.SANCTION_AMOUNT >5";
				    	}
                   	//System.out.println("fhtcsForHouseHolds :"+fhtcsForHouseHolds);
                   }
                       
                  // System.out.println("sanctioned habs1****** :"+fhtcsForHouseHolds);
                   
                   stmt1 = conn.createStatement();
                   rs1 = stmt1.executeQuery(prevWorksQry);
                   if (rs1.next()) {
                	   prevCompWorks = rs1.getInt(1);
                   }
                   stmt1.close();
                   rs1.close();
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   String cancelWorksQry = "select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p " 
							+" where WORK_CANCEL_DT is not null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") " 
 							+"  and a.TYPE_OF_ASSET in (" + schemes + ")   "
							+"  "; 
                    if(programme.equals(scode)){
                    	if(schemesSizeTemp.equals("below5")){
				    		//schemeName +=" (Below 5 laks)";
				    		cancelWorksQry += " and a.SANCTION_AMOUNT <=5";
				    	}else{
				    		//schemeName +=" (Above 5 laks)";
				    		cancelWorksQry += " and a.SANCTION_AMOUNT >5 ";
				    	}
                    //	System.out.println("sanctioned habs1 :"+sacHabs);
                    }
                        
                   // System.out.println("sanctioned habs1****** :"+sacHabs);
                   // System.out.println("******************"+cancelWorksQry);
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(cancelWorksQry);
                    if (rs1.next()) {
                    	 noOfCancelWorks = rs1.getInt(2);

                    estCostCancelWorks = rs1.getDouble(1);
                    if(estCostCancelWorks != 0)
                    	estCostCancelWorks = estCostCancelWorks/100000;
                    
                    }
                    stmt1.close();
                    rs1.close(); 
                  
                    
                    
                   String expenditureUptoPrevQry = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m " 
							+" where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ") and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id"
							+" and m.work_id(+)=a.work_id and to_date(STATE_SEND_DATE)<='31-MAR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") "; 

                   
                    if(programme.equals(scode)){
                    	if(schemesSizeTemp.equals("below5")){
				    		//schemeName +=" (Below 5 laks)";
				    		 expenditureUptoPrevQry +="  and a.SANCTION_AMOUNT <=5";//and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')
				    	}else{
				    		//schemeName +=" (Above 5 laks)";
				    		 expenditureUptoPrevQry +="   and a.SANCTION_AMOUNT >5 ";//and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')
				    	}
                    	//System.out.println("Not_Grounded_Query :"+Not_Grounded_Query);
                    }
                   // System.out.println("**#################............."+expenditureUptoPrevQry);
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(expenditureUptoPrevQry);
                    if (rs1.next()) {
                    	expUptoPrevYearPAO = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();      
                    
                    expenditureUptoPrevQry = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m " 
							+" where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and b.work_id=a.work_id and i.work_id(+)=a.work_id and " 
							+" c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(BANK_SEND_DATE)<='31-MAR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") "; 

                    
                    
                    //code for getting bill raised so for by nagendra 13-5-21 wait
                    String billsamtquery = "";
                    if(programme.equals(scode)){
                    	if(schemesSizeTemp.equals("below5")){
				    		//schemeName +=" (Below 5 laks)";
				    		expenditureUptoPrevQry += " and a.SANCTION_AMOUNT <=5";
				    	}else{
				    		//schemeName +=" (Above 5 laks)";
				    		expenditureUptoPrevQry += " and  a.SANCTION_AMOUNT >5 ";
				    	}
                    	// System.out.println("billsamtquery :"+billsamtquery);
                    }
                    //System.out.println("#################............."+expenditureUptoPrevQry);
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(expenditureUptoPrevQry);
                    if (rs1.next()) {
                    	expUptoPrevYearBank = rs1.getDouble(1);
                    	
                    	
                    
                    }
                    stmt1.close();
                    rs1.close();
                    double expUptoPrevYear = (expUptoPrevYearBank + expUptoPrevYearPAO) / 100000;
                    currentYearWorks = noOfWorks -(noOfCancelWorks+prevCompWorks);
                    
                    //in (" + programme + ")
                   /*  billsamtquery=" select sum(b.BILL_AMT_ADMISSIBLE) from rws_work_bill_tbl b,rws_work_admn_tbl a where a.work_id=b.work_id and a.programme_code=" + programme + " "
        		 			+" and a.TYPE_OF_ASSET in (" + schemes + ") and not EXISTS  (select 1 from rws_bill_bank_bridge_tbl wb where b.work_id=wb.work_id "
        		 		+"and b.bill_sl_no=wb.BILL_SL_NO)"; */
                    billsamtquery=" select sum(b.BILL_AMT_ADMISSIBLE) from rws_work_bill_tbl b,rws_work_admn_tbl a where a.work_id=b.work_id and a.programme_code in (" + programme + ") "
        		 			+" and a.TYPE_OF_ASSET in (" + schemes + ") and not EXISTS  (select 1 from rws_bill_bank_bridge_tbl wb where b.work_id=wb.work_id "
        		 		+"and b.bill_sl_no=wb.BILL_SL_NO)";
                    
                    if(programme.equals(scode)){
                    	if(schemesSizeTemp.equals("below5")){
				    		//schemeName +=" (Below 5 laks)";
				    		billsamtquery += "  and a.SANCTION_AMOUNT <=5";
				    	}else{
				    		//schemeName +=" (Above 5 laks)";
				    		billsamtquery += " and a.SANCTION_AMOUNT >5 ";
				    	}
                    	// System.out.println("groundWorks :"+groundWorks);
                    }
                   
                   // System.out.println("billsamtquery******************"+billsamtquery);
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(billsamtquery);
                    if (rs1.next()) {
                    	 billamount = rs1.getDouble(1); 
                         if(billamount != 0)
                      	   billamount = billamount/100000;
                    }
                    stmt1.close();
                    rs1.close();
                    
                    
                    String Not_Grounded_Query = "select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a,rws_programme_tbl p "
        	        		+" where a.work_id not in (select work_id from RWS_WORK_COMMENCEMENT_TBL where GROUNDING_DATE is not null )  and WORK_CANCEL_DT is null "
        	        		+" and a.programme_code=p.PROGRAMME_CODE and substr(a.work_id,7,2) in ("+ schemes+ ")    and    a.PROGRAMME_CODE in ("+programme+") "
        	        		+" and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-"+ yearStart+"') ";
                    if(programme.equals(scode)){
                    	if(schemesSizeTemp.equals("below5")){
				    		//schemeName +=" (Below 5 laks)";
				    		Not_Grounded_Query += "  and a.SANCTION_AMOUNT <=5";
				    	}else{
				    		//schemeName +=" (Above 5 laks)";
				    		Not_Grounded_Query += " and a.SANCTION_AMOUNT >5 ";
				    	}
                    	  // System.out.println("underProgressWorks :"+underProgressWorks);
                    }
                   
                   // System.out.println("!Not_Grounded_Query******************"+Not_Grounded_Query);
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(Not_Grounded_Query);
                    if (rs1.next()) {
                    	 worksNotGround = rs1.getInt(1);        
                    }
                    stmt1.close();
                    rs1.close();
                  
                   String groundWorks = "select count(distinct a.work_id) "
                   		 +" from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_contractor_selection_tbl m" 
                   		 +" where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
                   		 +" and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                   		 +" and i.work_id(+)=a.work_id  and c.work_id=a.work_id and m.work_id(+)=a.work_id  and a.TYPE_OF_ASSET in (" + schemes + ") ";

 					 if(programme.equals(scode)){
 						if(schemesSizeTemp.equals("below5")){
				    		//schemeName +=" (Below 5 laks)";
				    		groundWorks += " and a.SANCTION_AMOUNT <=5";
				    	}else{
				    		//schemeName +=" (Above 5 laks)";
				    		groundWorks += " and a.SANCTION_AMOUNT >5 ";
				    	}
 						//System.out.println("compWorks :"+compWorks);
 					 }
                	
                   
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(groundWorks);
                    if (rs1.next()) {
                    	worksGround = rs1.getInt(1);    
                    }
                    
                    /* 49010801160003 this work is complted but it does't have hablink so it is not displayed in work completion */
                    stmt1.close();
                    rs1.close();
                    
                    String compWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) "
                  		  +" from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m, rws_habitation_directory_tbl hd " 
                  		  +" where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and "
                  		  +" i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and a.programme_code in (" + programme + ")   and " 
                  		  +" TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMPLETION)<='31-MAR-" + yearEnd + "'  and b.DATE_OF_COMPLETION is not null and " 
                  		  +" a.TYPE_OF_ASSET in (" + schemes + ")";//TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and

					 if(programme.equals(scode)){
						 if(schemesSizeTemp.equals("below5")){
					    		//schemeName +=" (Below 5 laks)";
					    	 compWorks += " and a.SANCTION_AMOUNT <=5";
					    	}else{
					    		//schemeName +=" (Above 5 laks)";
					    		 compWorks += " and a.SANCTION_AMOUNT >5 ";
					    	}
						 /// System.out.println("commWorks "+commWorks);
					 }
                	
                 
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(compWorks);
                    if (rs1.next()) {
                    	  worksComp = rs1.getInt(1);
                    }       
                    stmt1.close();
                    rs1.close();
                    
                    
                    
                    
                   String bankCM = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
			                 + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') "
			                 + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' "
			                 + "and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.TYPE_OF_ASSET in (" + schemes + ") ";
                   
                    if(programme.equals(scode)){
                    	 if(schemesSizeTemp.equals("below5")){
					    		//schemeName +=" (Below 5 laks)";
                    		 bankCM += " and a.SANCTION_AMOUNT <=5";
					    	}else{
					    		//schemeName +=" (Above 5 laks)";
					    		bankCM += " and a.SANCTION_AMOUNT >5";
					    	}
                    	 // System.out.println("fhtcsProvided "+fhtcsProvided);
                    }
                	
                   
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(bankCM);
                    if (rs1.next()) {
                    	 bankCurrentMonth = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();

                    String paoCM = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                            + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') "
                            + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "' "
                            + "and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.TYPE_OF_ASSET in (" + schemes + ") ";
                            
                    if(programme.equals(scode)){
                    	 if(schemesSizeTemp.equals("below5")){
					    		//schemeName +=" (Below 5 laks)";
					    	paoCM += " and a.SANCTION_AMOUNT <=5";
					    	}else{
					    		//schemeName +=" (Above 5 laks)";
					    		 paoCM += " and a.SANCTION_AMOUNT >5 ";
					    	}
                    	 // System.out.println("comphabs habs"+comphabs);
                    }
                	
                   
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(paoCM);
                    if (rs1.next()) {
                    	 paoCurrentMonth = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();

                    double currBills = (bankCurrentMonth + paoCurrentMonth)/100000;
        			double amountTot = ( bankCurrentMonth + paoCurrentMonth) / 100000;


        			       balCost = estCost - (estCostCancelWorks + expUptoPrevYear);
        			       
        			       //
        			       
        			       if(balCost != 0)
        			    	   balCost = balCost/100000;
        			       
        			       //
        			       
        			       
                   
        			       if(noOfWorks==0 && estCost==0  && worksComp==0   &&

        			               bankYear==0.0 && paoYear==0.0 && bankLastMonth ==0.0 && paoLastMonth==0.0 &&

        			                 bankCurrentMonth ==0.0 && paoCurrentMonth==0.0 && worksPhyCompNotFin==0.0) {}else{
                	 if (styleCount % 2 == 0) {
                         style = "gridbg1";
                     } else {
                         style = "gridbg2";
                     }
                     styleCount++;  
                %>
                    <tr>
                    <%if(!mainProgrammeName.equals(dupeProgrammeName)){ //need to modify
                    //System.out.println("programme----"+mainProgrammeName);
                    %>
                             <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><%=++slno%></td>
                             <%if(mainProgrammeName.equals("NRDWP RELATED")){ %>
                              <td class="<%=style%>" style="text-align: left;" align="right" width="100px"><a href="rws_work_progress_new_abstract_main_rpt.jsp?mode=circles&programme=<%=progCodeNRDWP%>&programmeName=<%=mainProgrammeName%>&schemes=<%=schemesTot %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>"><%=mainProgrammeName%></a></td>
                              <%}else{
                            	  %>
                              <%if(programme.equals(scode)){ 
                            	  String abc="";%>
                                                             <td class="<%=style%>" style="text-align: left;" align="right" width="100px"><a href="rws_work_progress_new_abstract_main_rpt.jsp?mode=circles&programme=<%=programme%>&programmeName=<%=mainProgrammeName%>&schemes=<%=schemesTot %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=abc %>"><%=mainProgrammeName%></a></td>    
                             <%}else{ 
                            	 %>
                              <td class="<%=style%>" style="text-align: left;" align="right" width="100px"><a href="rws_work_progress_new_abstract_main_rpt.jsp?mode=circles&programme=<%=programme%>&programmeName=<%=mainProgrammeName%>&schemes=<%=schemesTot %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>"><%=mainProgrammeName%></a></td>
                             
                             <%} %>
                             <%}}else{ %>
                             <td class="<%=style%>" style="text-align: right;" align="right" width="50px"></td>
                              <td class="<%=style%>" style="text-align: right;" align="right" width="100px"></td>
                             <%} %>
                              <td class="<%=style%>" style="text-align: left;" align="right" width="100px"><a href="rws_work_progress_new_abstract_main_rpt.jsp?mode=circles&programme=<%=programme%>&programmeName=<%=programmeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>"><%=programmeNam%> (<b><%=schemeName %></b>)</a></td>
                            
                             <%-- <td class="<%=style%>" style="text-align: right;" align="right" width="50px">
                             <a href="rws_work_progress_new_abstract_main_rpt.jsp?programme=<%=programme %>&programmeName=<%=programmeNam%>&scheme=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>&pc=<%=programme%>"  onmouseover="Tip(this.value,TITLE,'Click Here To View the Sub Program wise Details for Programme <%=programmeNam %> and Scheme <%=schemeName %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"  onmouseout="UnTip()"><b>Click&nbsp;Here</b></a>
                             </td> --%>
                             <%if(schemeName.equals("SVS")){ %>
                             <td class="<%=style%>" style="text-align: left;" align="center" width="100px"><a href="#" onclick="viewWorks('./rws_work_progress_new_abstract_drill_rpt.jsp?mode=tWorks&pc=<%=programme%>&pn=<%=programmeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><font color="blue" ><b><%=schemeName %>-<%=noOfWorks%></b></font></a></td>
                             <%}else if(schemeName.equals("MVS")){ %>
                             <td class="<%=style%>" style="text-align: left;" align="center" width="100px"><a href="#" onclick="viewWorks('./rws_work_progress_new_abstract_drill_rpt.jsp?mode=tWorks&pc=<%=programme%>&pn=<%=programmeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><font color="green" ><b><%=schemeName %>-<%=noOfWorks%></b></font></a></td>
                             <%}
                             else{ %>
                             <td class="<%=style%>" style="text-align: left;" align="center" width="100px"><a href="#" onclick="viewWorks('./rws_work_progress_new_abstract_drill_rpt.jsp?mode=tWorks&pc=<%=programme%>&pn=<%=programmeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><font color="orange" ><b><%=schemeName %>-<%=noOfWorks%></b></font></a></td>
                             <%} %>                             
                             <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=ndf.format(estCost) %></td>
                             <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><%=noOfCancelWorks%></td>
                              <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><%=ndf.format(estCostCancelWorks)%></td>
                             <td class="<%=style%>" style="text-align: right;" align="right" width="60px"><a href="#" onclick="viewWorks('./rws_work_progress_new_abstract_drill_rpt.jsp?mode=wcPrevYear&pc=<%=programme%>&pn=<%=programmeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=prevCompWorks%> </a></td>
                             <td class="<%=style%>" style="text-align: right;" align="right" width="60px"><%=ndf.format(expUptoPrevYear)%></td>
                             <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><%=currentYearWorks%></td>
                             <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><%=ndf.format(balCost )%></td>
                             <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=ndf.format(amountTot)%></td>
                       		<td class="<%=style%>" style="text-align: right;" align="right" width="60px"><a href="#" onclick="viewWorks('./rws_work_progress_new_abstract_drill_rpt.jsp?mode=ngWorks&pc=<%=programme%>&pn=<%=programmeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksNotGround%> </a></td>
                       		<td class="<%=style%>" style="text-align: right;" align="right" width="60px"><a href="#" onclick="viewWorks('./rws_work_progress_new_abstract_drill_rpt.jsp?mode=gWorks&pc=<%=programme%>&pn=<%=programmeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksGround%> </a></td>
                       		<td class="<%=style%>" style="text-align: right;" align="right" width="60px"><a href="#" onclick="viewWorks('./rws_work_progress_new_abstract_drill_rpt.jsp?mode=cWorks&pc=<%=programme%>&pn=<%=programmeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksComp%> </a></td>
	                         <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=ndf.format(billamount)%></td>
                        </tr>
                <%
	                dupeProgrammeName=mainProgrammeName;
	                oldprogName=programmeNam;
                   }
        			       totNoOfWorks = totNoOfWorks + noOfWorks;
        	                 totEstCost = totEstCost + estCost;
        	 					totCancelWork +=noOfCancelWorks;
        	                 
        	                 totCancelEstCst +=estCostCancelWorks;
        	                 totPrevWorks += prevCompWorks;
        	                 totPrevExp += expUptoPrevYear;
        	                 totCurrBalCost += balCost;
        	                 totCurrWorks += currentYearWorks;
        	                 totbillamt=totbillamt+billamount;
        	                 totWorksNotGround = totWorksNotGround + worksNotGround;
        	                 totWorksGround = totWorksGround + worksGround;
        	                 totWorksComp = totWorksComp + worksComp;              
        	                 totCurrExp += currBills;
                 
                    stmt.close();
                    rs.close();
                    if (slno == 0) {
                %>
            <tr>
                <td colspan="12" class="<%=style%>" style="text-align: center;">NO Records Found</td>
            </tr>
            <%
                }          
              }                               	
            	}
                      %>
            <tr class="rightPad">
                <td class="btext" style="text-align: right;" colspan=3>Total:</td>
                <td class="btext" style="text-align: right;"><%=totNoOfWorks%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totEstCost)%></td>
                <td class="btext" style="text-align: right;"><%=totCancelWork%></td>
                 <td class="btext" style="text-align: right;"><%=ndf.format(totCancelEstCst)%></td>
                <td class="btext" style="text-align: right;"><%=totPrevWorks%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totPrevExp)%></td>
                <!--  -->
                <td class="btext" style="text-align: right;"><%=totCurrWorks%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totCurrBalCost)%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totCurrExp)%></td>
                <td class="btext" style="text-align: right;"><%=totWorksNotGround%></td>
                <td class="btext" style="text-align: right;"><%=totWorksGround%></td>
                <td class="btext" style="text-align: right;"><%=totWorksComp%></td>
            <%--     <td class="btext" style="text-align: right;"><%=ndf.format(totTotExp / 100000)%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totExpPhyCompNotFin / 100000)%></td>
             	<td class="btext" style="text-align: right;"><%=ndf.format(totExpIncPhyCompNotFin / 100000)%></td>
             --%> <td class="btext" style="text-align: right;"><%=ndf.format(totbillamt)%></td>
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

