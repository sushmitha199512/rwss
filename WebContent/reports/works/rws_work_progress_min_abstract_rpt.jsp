<%@page import="nic.watersoft.works.WorksData1"%>
<%@page import="java.sql.Connection"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%    DecimalFormat ndf = new DecimalFormat("####.00");
   String scode="89";
   String jhsrcode="91";
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
    programmeList.put(x,scode+"@"+"JHC"); //JJM works below 5laks above 5 laks
    x++;
    programmeList.put(x,jhsrcode+"@"+"JHC"); 
    ///System.out.println("programme list NRDWP"+programmeList);
    //System.out.println("scode===??? "+scode);
   
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
        <center>
		<br />
		<br /> <font color="#663899" face="Maiandra GD" size="4px"><b>Select
				Financial Year:<font color="red">*</font> <SELECT name="finyear" id="finyear"
				style="width: 140px" onchange="this.form.submit()">
				<!-- <option value="2020"+"-" +"2021">2020 - 2021</option>
				<option value="2019"+"-" +"2020">"2019"+"-" +"2020"</option>
				<option value="2018"+"-" +"2019">"2018"+"-" +"2019"</option>
				<option value="2017"+"-" +"2018">"2017"+"-" +"2018"</option>
				<option value="2016"+"-" +"2017">"2016"+"-" +"2017"</option>
				<option value="2015"+"-" +"2016">"2015"+"-" +"2016"</option>
				<option value="2014"+"-" +"2015">"2014"+"-" +"2015"</option> -->
				<%
					int endFinYear = 2011;
				int tempYear = 0,temp=0;
				String finYear=request.getParameter("finyear");
				while(startFinYear>=endFinYear){
					tempYear = startFinYear+1;
					//System.out.println("start year :"+startFinYear+" finYear :"+finYear);
					if(finYear != null &&  !finYear.equals("0")){
						temp = Integer.parseInt( finYear.substring(0, 4));
						
					}
					
					if(startFinYear == temp ){
						//System.out.println("in if start year :"+startFinYear+" finYear :"+temp);
						%>
						<option value=<%= String.valueOf(startFinYear)+" - "+String.valueOf(tempYear) %> selected ><%= String.valueOf(startFinYear)+" - "+String.valueOf(tempYear) %></option>
						<%
					}else
					{
					%>
					<option value=<%= String.valueOf(startFinYear)+" - "+String.valueOf(tempYear) %>><%= String.valueOf(startFinYear)+" - "+String.valueOf(tempYear) %></option>
					<%}
					
					startFinYear--;
				}
				
				%>
					<%-- <%
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
					%> --%>
			</SELECT>
		</b></font> <br>
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
                <td class=btext >SNO</td>
                <td class=btext >&nbsp;Main&nbsp;Programme&nbsp;</td>
                <td class=btext >Programme</td>
                <td class=btext >Sub Programme</td>
                <td class=btext >Scheme-No. of<br/>Works</td>
                <td class=btext >Est. Cost</td>
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
            %>
            <%
                Connection connection = null;
                Statement stmt1 = null;
                ResultSet rs1 = null;
                int slno = 0;
                try {
                	double totbillamt=0.0;
                    int totNoOfWorks = 0, totHabsSanctioned = 0, totWorksComp = 0, totHabsCov = 0, totWorksPhyCompNotFin = 0, totWorksNotGround=0,totWorksGround=0,totWorksUnderProgress=0,totWorksComm=0;
                    long totPopBenf = 0, totPopCov = 0, popBenf = 0, popCov = 0, nrdwpPopBenf = 0, nrdwpPopCov = 0,totHouseholds=0,totfhtsprovided=0;
                    double totarfc = 0, totEstCost = 0, totExpUptoFY = 0, totExpUptoLM = 0, totExpDM = 0, totTotExp = 0, expPhyCompNotFin = 0, bankPhyCompNotFin = 0,expIncBankPhyCompNotFin=0, paoPhyCompNotFin = 0,expIncPhyCompNotFin=0,totExpIncPhyCompNotFin=0, totExpPhyCompNotFin = 0, totalAmtInclPhyCompNotFin = 0;
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
                        double estCost = 0, bankYear = 0, bankLastMonth = 0, bankCurrentMonth = 0, paoYear = 0, paoLastMonth = 0, paoCurrentMonth = 0, expUptoLFY = 0, expUptoLM = 0, expDM = 0, TotExp = 0;
                        int noOfWorks = 0, habsSanctioned = 0, worksComp = 0, habsCov = 0, worksPhyCompNotFin = 0, worksNotGround=0,worksGround=0,worksUnderProgress=0,worksComm=0,fhtc_for_house_holds = 0,fhtsprovided=0;
                        double billamount=0;
                   						programme = (String) programmeList.get(i);
                   						
                                    	String ar[]=programme.split("@");
                                    	programme=ar[0];
                                    	mainProgrammeName=ar[1];
                                        if(mainProgrammeName.equals("JHC")||mainProgrammeName.equals("JJM"))
                                    	System.out.println("programme1-----"+programme+" mainProgrammeName: "+mainProgrammeName);
                          String programmeNam = "";
					    if (programme.length() > 2) {
					   
					    	 programmeNam = "NRDWP";
			           	} else {
			             	String programmeQuery = "select PROGRAMME_CODE,PROGRAMME_NAME from  rws_programme_tbl where PROGRAMME_CODE='"+ programme + "'";
			             	Statement statement1 = conn.createStatement();
			             	ResultSet resultSet1 = statement1.executeQuery(programmeQuery);
			             	if (resultSet1.next()) {
			             		programmeNam = resultSet1.getString("PROGRAMME_NAME");
			             		//System.out.println("programme369-----"+programmeNam);
			             	}
			             	resultSet.close();
			             	statement.close();
			             	} 
					   // System.out.println(" programme name  :" +programme+"scode==== "+scode);
					    if(programme.equals(scode)){
					    	//System.out.println("programme376-----"+schemesSizeTemp);
					    	if(schemesSizeTemp.equals("below5")){
					    		schemeName +=" (Below 5 laks)";
					    		 query = "select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"
			                                + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
			                                + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
			                                + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
			                                + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5";
					    	}else{
					    		schemeName +=" (Above 5 laks)";
					    		 query = "select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"
			                                + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
			                                + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
			                                + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
			                                + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5 ";
					    	}
					    	
					    	/* if(j==schemesList.size())
					    	schemesSizeTemp ="above5"; */
					    	
					    	 //System.out.println(" work  query is :" +query);
					    	
					    }else {
                 query = "select sum(a.SANCTION_AMOUNT),count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"
                                + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
                                + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
                                + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' ";               
					    }
                      
                
                    stmt = conn.createStatement();
                    //System.out.println("query---  "+query);
                    rs = stmt.executeQuery(query);
                   if (rs.next()) {                    	
                        	names+=programmeNam+",";                       
                        noOfWorks = rs.getInt(2);
                        estCost = rs.getDouble(1);
                    }   
                   
                   
                   
                   if(mainProgrammeName.equals("JHC"))
                System.out.println("pr2==  :"+mainProgrammeName);   
                   String fhtcsForHouseHolds = "";
                   if(programme.equals(scode)){
                   	if(schemesSizeTemp.equals("below5")){
				    		//schemeName +=" (Below 5 laks)";
                   		fhtcsForHouseHolds = "select sum(hd.totalhouseholds)  from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
                                + ", imismasterdata_tbl hd where hd.habcode=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and  b.work_id=a.work_id and  c.work_id(+)=a.work_id "
                                + "and a.programme_code in (" + programme + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5";
				    	}else{
				    		//schemeName +=" (Above 5 laks)";
				    		fhtcsForHouseHolds = "select sum(hd.totalhouseholds)  from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
                                    + ", imismasterdata_tbl hd where hd.habcode=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                    + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and  b.work_id=a.work_id and  c.work_id(+)=a.work_id "
                                    + "and a.programme_code in (" + programme + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5";
				    	}
                   	//System.out.println("fhtcsForHouseHolds :"+fhtcsForHouseHolds);
                   }else{
                	   fhtcsForHouseHolds = "select sum(hd.totalhouseholds)  from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
                               + ", imismasterdata_tbl hd where hd.habcode=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                               + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and  b.work_id=a.work_id and  c.work_id(+)=a.work_id "
                               + "and a.programme_code in (" + programme + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y'";  
                   }
                       
                  // System.out.println("sanctioned habs1****** :"+fhtcsForHouseHolds);
                   
                   stmt1 = conn.createStatement();
                   rs1 = stmt1.executeQuery(fhtcsForHouseHolds);
                   if (rs1.next()) {
                	   fhtc_for_house_holds = rs1.getInt(1);
                       //popBenf = rs1.getLong(2);
                   }
                   stmt1.close();
                   rs1.close();
                   
                   
                   
                   
                   
                   
                   
                   
                   
                    String sacHabs = "";
                    if(programme.equals(scode)){
                    	if(schemesSizeTemp.equals("below5")){
				    		//schemeName +=" (Below 5 laks)";
				    		sacHabs = "select count(distinct b.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
	                                + ", rws_habitation_directory_tbl hd where hd.hab_code=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
	                                + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and  b.work_id=a.work_id and COVERAGE_STATUS<>'UI' and  c.work_id(+)=a.work_id "
	                                + "and a.programme_code in (" + programme + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5";
				    	}else{
				    		//schemeName +=" (Above 5 laks)";
				    		sacHabs = "select count(distinct b.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
	                                + ", rws_habitation_directory_tbl hd where hd.hab_code=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
	                                + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and  b.work_id=a.work_id and COVERAGE_STATUS<>'UI' and  c.work_id(+)=a.work_id "
	                                + "and a.programme_code in (" + programme + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5 ";
				    	}
                    //	System.out.println("sanctioned habs1 :"+sacHabs);
                    }else{
                    sacHabs = "select count(distinct b.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
                                + ", rws_habitation_directory_tbl hd where hd.hab_code=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and 	TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and  b.work_id=a.work_id and COVERAGE_STATUS<>'UI' and  c.work_id(+)=a.work_id "
                                + "and a.programme_code in (" + programme + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y'";
                    }
                        
                   // System.out.println("sanctioned habs1****** :"+sacHabs);
                    
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(sacHabs);
                    if (rs1.next()) {
                        habsSanctioned = rs1.getInt(1); 
                        popBenf = rs1.getLong(2);
                    }
                    stmt1.close();
                    rs1.close(); 
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    
                    if(mainProgrammeName.equals("JHC"))
                        System.out.println("pr3==  :"+mainProgrammeName);  
                    String Not_Grounded_Query="";
                    if(programme.equals(scode)){
                    	if(schemesSizeTemp.equals("below5")){
				    		//schemeName +=" (Below 5 laks)";
				    		 Not_Grounded_Query="select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a,rws_programme_tbl p where a.work_id not in "
  							   +"(select work_id from RWS_WORK_COMMENCEMENT_TBL where GROUNDING_DATE is not null ) and a.work_id not in " 
                            +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)  " 
                            +"and WORK_CANCEL_DT is null and a.programme_code=p.PROGRAMME_CODE and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y'  and  "
                            +"  a.PROGRAMME_CODE in ("+programme+") and TO_DATE(TARGET_DATE_COMP)>='01-APR-"+ yearStart+"' "
                            +"   and a.SANCTION_AMOUNT <=5";//and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')
				    	}else{
				    		//schemeName +=" (Above 5 laks)";
				    		 Not_Grounded_Query="select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a,rws_programme_tbl p where a.work_id not in "
  							   +"(select work_id from RWS_WORK_COMMENCEMENT_TBL where GROUNDING_DATE is not null ) and a.work_id not in " 
                            +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)  " 
                            +"and WORK_CANCEL_DT is null and a.programme_code=p.PROGRAMME_CODE and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y'  and  "
                            +"  a.PROGRAMME_CODE in ("+programme+") and TO_DATE(TARGET_DATE_COMP)>='01-APR-"+ yearStart+"' "
                            +"   and a.SANCTION_AMOUNT >5 ";//and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')
				    	}
                    	//System.out.println("Not_Grounded_Query :"+Not_Grounded_Query);
                    }else{
                    	 Not_Grounded_Query="select count (distinct a.work_id) from RWS_WORK_ADMN_TBL a,rws_programme_tbl p where a.work_id not in "
  							   +"(select work_id from RWS_WORK_COMMENCEMENT_TBL where GROUNDING_DATE is not null ) and a.work_id not in " 
                            +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)  " 
                            +"and WORK_CANCEL_DT is null and a.programme_code=p.PROGRAMME_CODE and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y'  and  "
                            +"  a.PROGRAMME_CODE in ("+programme+") and TO_DATE(TARGET_DATE_COMP)>='01-APR-"+ yearStart+"' "
                            +" ";//and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') 
                    }
                   
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(Not_Grounded_Query);
                    if (rs1.next()) {
                      worksNotGround = rs1.getInt(1);    
                    }
                    stmt1.close();
                    rs1.close();      
                    
                    
                    //code for getting bill raised so for by nagendra 13-5-21 wait
                    String billsamtquery = "";
                    if(programme.equals(scode)){
                    	if(schemesSizeTemp.equals("below5")){
				    		//schemeName +=" (Below 5 laks)";
				    		billsamtquery = "select sum(wb.BILL_AMT_ADMISSIBLE) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c , "//rws_new_est_tbl t ,
                                + "rws_contractor_selection_tbl m,RWS_WORK_BILL_TBL wb where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
                                + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  "//and t.work_id=a.work_id
                                + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and wb.EE_FWD_DATE is not null and wb.work_id=a.work_id and  not EXISTS  (select 1 from rws_bill_bank_bridge_tbl b where b.work_id=wb.work_Id and b.bill_sl_no=wb.bill_sl_no ) and a.SANCTION_AMOUNT <=5";
				    	}else{
				    		//schemeName +=" (Above 5 laks)";
				    		billsamtquery = "select sum(wb.BILL_AMT_ADMISSIBLE) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c , "//rws_new_est_tbl t ,
                                + "rws_contractor_selection_tbl m,RWS_WORK_BILL_TBL wb where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
                                + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  "//and t.work_id=a.work_id
                                + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and wb.EE_FWD_DATE is not null and wb.work_id=a.work_id and  not EXISTS  (select 1 from rws_bill_bank_bridge_tbl b where b.work_id=wb.work_Id and b.bill_sl_no=wb.bill_sl_no ) and  a.SANCTION_AMOUNT >5 ";
				    	}
                    	// System.out.println("billsamtquery :"+billsamtquery);
                    }else{
                    	billsamtquery = "select sum(wb.BILL_AMT_ADMISSIBLE) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c , "//rws_new_est_tbl t ,
                                + "rws_contractor_selection_tbl m,RWS_WORK_BILL_TBL wb where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
                                + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  "//and t.work_id=a.work_id
                                + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and wb.EE_FWD_DATE is not null and wb.work_id=a.work_id and  not EXISTS  (select 1 from rws_bill_bank_bridge_tbl b where b.work_id=wb.work_Id and b.bill_sl_no=wb.bill_sl_no )";
                    //System.out.println(groundWorks);
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
                    
                    
                    
                    String groundWorks = "";
                    if(programme.equals(scode)){
                    	if(schemesSizeTemp.equals("below5")){
                    		System.out.println("below5");
				    		//schemeName +=" (Below 5 laks)";
				    		groundWorks = "select count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,"//rws_new_est_tbl t ,
                                 + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
                                 + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                 + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id=a.work_id and m.work_id(+)=a.work_id  "//and t.work_id(+)=a.work_id
                                 + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y'  and a.SANCTION_AMOUNT <=5";
				    	}else{
				    		//System.out.println("below5 else");
				    		//schemeName +=" (Above 5 laks)";
				    		groundWorks = "select count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,"//rws_new_est_tbl t ,
                                 + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
                                 + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                 + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id=a.work_id and m.work_id(+)=a.work_id  "//and t.work_id(+)=a.work_id
                                 + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5 ";
				    	}
                    	// System.out.println("groundWorks :"+groundWorks);
                    }else{
                    	//System.out.println("programme else");
                    	 groundWorks = "select count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,"//rws_new_est_tbl t ,
                                 + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
                                 + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                 + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id=a.work_id and m.work_id(+)=a.work_id  "//and t.work_id(+)=a.work_id
                                 + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' ";
                   
                    //System.out.println(groundWorks);
                    }
                    //System.out.println(groundWorks);
                   
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(groundWorks);
                    if (rs1.next()) {
                      worksGround = rs1.getInt(1);    
                    }
                    stmt1.close();
                    rs1.close();
                    
                    String underProgressWorks = "";
                    if(programme.equals(scode)){
                    	if(schemesSizeTemp.equals("below5")){
				    		//schemeName +=" (Below 5 laks)";
				    		underProgressWorks = "select count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,"//rws_new_est_tbl t ,
                                 + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
                                 + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) "
                                 + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id  "//and t.work_id=a.work_id
                                 + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y'  and a.SANCTION_AMOUNT <=5";
				    	}else{
				    		//schemeName +=" (Above 5 laks)";
				    		underProgressWorks = "select count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,"//rws_new_est_tbl t ,
                                 + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
                                 + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) "
                                 + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id "//and t.work_id=a.work_id 
                                 + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5 ";
				    	}
                    	  // System.out.println("underProgressWorks :"+underProgressWorks);
                    }else{
                    	 underProgressWorks = "select count(distinct a.work_id) from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,"//rws_new_est_tbl t ,
                                 + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programme + ") "
                                 + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null ) "
                                 + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id "// and t.work_id=a.work_id
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
 					 if(programme.equals(scode)){
 						if(schemesSizeTemp.equals("below5")){
				    		//schemeName +=" (Below 5 laks)";
				    		compWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
 	                            + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id(+)=a.work_id and hd.hab_code(+)=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
 	                            + " a.programme_code in (" + programme + ")   and TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMPLETION)<='31-MAR-" + yearEnd + "' and b.DATE_OF_COMPLETION is not null  and "
 	                            + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5";
				    	}else{
				    		//schemeName +=" (Above 5 laks)";
				    		compWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
 	                            + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id(+)=a.work_id and hd.hab_code(+)=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
 	                            + " a.programme_code in (" + programme + ")   and TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMPLETION)<='31-MAR-" + yearEnd + "' and b.DATE_OF_COMPLETION is not null  and "
 	                            + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5 ";
				    	}
 						//System.out.println("compWorks :"+compWorks);
 					 }else{
 						compWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
 	                            + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id(+)=a.work_id and hd.hab_code(+)=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
 	                            + " a.programme_code in (" + programme + ")   and TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMPLETION)<='31-MAR-" + yearEnd + "' and b.DATE_OF_COMPLETION is not null  and "
 	                            + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
 					 }
                	
                   
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(compWorks);
                    if (rs1.next()) {
                        worksComp = rs1.getInt(1); 
                    }
                    
                    /* 49010801160003 this work is complted but it does't have hablink so it is not displayed in work completion */
                    stmt1.close();
                    rs1.close();
                    
					String commWorks = "";
					 if(programme.equals(scode)){
						 if(schemesSizeTemp.equals("below5")){
					    		//schemeName +=" (Below 5 laks)";
					    	 commWorks = "select count(distinct a.work_id) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
		                            + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id  and "
		                            + " a.programme_code in (" + programme + ") and  b.DATE_OF_COMPLETION is not null and b.DATE_OF_COMM is not null and TO_DATE(b.DATE_OF_COMM) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMM)<='31-MAR-" + yearEnd + "' and"
		                            + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5";
					    	}else{
					    		//schemeName +=" (Above 5 laks)";
					    		 commWorks = "select count(distinct a.work_id) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
		                            + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id  and "
		                            + " a.programme_code in (" + programme + ") and  b.DATE_OF_COMPLETION is not null and b.DATE_OF_COMM is not null and TO_DATE(b.DATE_OF_COMM) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMM)<='31-MAR-" + yearEnd + "' and"
		                            + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5 ";
					    	}
						 /// System.out.println("commWorks "+commWorks);
					 }else{
						 commWorks = "select count(distinct a.work_id) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
		                            + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id  and "
		                            + " a.programme_code in (" + programme + ") and  b.DATE_OF_COMPLETION is not null and b.DATE_OF_COMM is not null and TO_DATE(b.DATE_OF_COMM) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMM)<='31-MAR-" + yearEnd + "' and"
		                            + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
					 }
                	
                 
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(commWorks);
                    if (rs1.next()) {
                        worksComm = rs1.getInt(1); 
                    }       
                    stmt1.close();
                    rs1.close();
                    
                    
                    
                    
                    
                    String fhtcsProvided = "";  
                    if(programme.equals(scode)){
                    	 if(schemesSizeTemp.equals("below5")){
					    		//schemeName +=" (Below 5 laks)";
                    		 fhtcsProvided = "select sum(hd.PENDING_FHTC)  from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
                                     + ", rws_habitation_directory_tbl hd where hd.hab_code=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                     + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and  b.work_id=a.work_id and  c.work_id(+)=a.work_id "
                                     + "and a.programme_code in (" + programme + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5";
					    	}else{
					    		//schemeName +=" (Above 5 laks)";
					    		fhtcsProvided = "select sum(hd.PENDING_FHTC)  from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
		                                + ", rws_habitation_directory_tbl hd where hd.hab_code=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
		                                + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and  b.work_id=a.work_id and  c.work_id(+)=a.work_id "
		                                + "and a.programme_code in (" + programme + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5";
					    	}
                    	 // System.out.println("fhtcsProvided "+fhtcsProvided);
                    }else{
                    	fhtcsProvided = "select sum(hd.PENDING_FHTC)  from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_WORK_COMMENCEMENT_TBL c "
                                + ", rws_habitation_directory_tbl hd where hd.hab_code=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and  b.work_id=a.work_id and  c.work_id(+)=a.work_id "
                                + "and a.programme_code in (" + programme + ")  and a.TYPE_OF_ASSET in (" + schemes + ")  and a.CORE_DASHBOARD_STATUS='Y'";
                    }
                	
                   
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(fhtcsProvided);
                    if (rs1.next()) {
                        /* worksComp = rs1.getInt(1); */
                       fhtsprovided = rs1.getInt(1);
                       // popCov = rs1.getLong(2);   
                    }
                    stmt1.close();
                    rs1.close();

                    
                    
                    
                    
                    
                    
                    
                    
                    if(mainProgrammeName.equals("JHC"))
                        System.out.println("pr4==  :"+mainProgrammeName);  
                    String comphabs = "";  
                    if(programme.equals(scode)){
                    	 if(schemesSizeTemp.equals("below5")){
					    		//schemeName +=" (Below 5 laks)";
					    	comphabs = "select count(distinct h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                                + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
                                + " a.programme_code in (" + programme + ")  and ((TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart +"' and TO_DATE(b.DATE_OF_COMPLETION) <= '31-MAR-" + yearEnd +"' and b.DATE_OF_COMPLETION is not null) OR (TO_DATE(b.partial_date_of_completion) >= '01-APR-" + yearStart +"' and TO_DATE(b.partial_date_of_completion) <= '31-MAR-" + yearEnd +"' and b.DATE_OF_COMPLETION is null)) and "
                                + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5";
					    	}else{
					    		//schemeName +=" (Above 5 laks)";
					    		 comphabs = "select count(distinct h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                                + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
                                + " a.programme_code in (" + programme + ")  and ((TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart +"' and TO_DATE(b.DATE_OF_COMPLETION) <= '31-MAR-" + yearEnd +"' and b.DATE_OF_COMPLETION is not null) OR (TO_DATE(b.partial_date_of_completion) >= '01-APR-" + yearStart +"' and TO_DATE(b.partial_date_of_completion) <= '31-MAR-" + yearEnd +"' and b.DATE_OF_COMPLETION is null)) and "
                                + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5 ";
					    	}
                    	 // System.out.println("comphabs habs"+comphabs);
                    }else{
                    	comphabs = "select count(distinct h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                                + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
                                + " a.programme_code in (" + programme + ")  and ((TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart +"' and TO_DATE(b.DATE_OF_COMPLETION) <= '31-MAR-" + yearEnd +"' and b.DATE_OF_COMPLETION is not null) OR (TO_DATE(b.partial_date_of_completion) >= '01-APR-" + yearStart +"' and TO_DATE(b.partial_date_of_completion) <= '31-MAR-" + yearEnd +"' and b.DATE_OF_COMPLETION is null)) and "
                                + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
                    }
                	
                   
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
                    if(programme.equals(scode)){
                    	 if(schemesSizeTemp.equals("below5")){
					    		//schemeName +=" (Below 5 laks)";
					    bankCum = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                 + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                 + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and to_date(target_date_comp)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  "
                                 + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.SANCTION_AMOUNT <=5";
					    	}else{
					    		//schemeName +=" (Above 5 laks)";
					    bankCum = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                 + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                 + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and to_date(target_date_comp)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  "
                                 + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.SANCTION_AMOUNT >5 ";
					    	}
                    	/// System.out.println("bankCum habs"+bankCum);   
                    }else{
                    	 bankCum = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                 + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                 + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and to_date(target_date_comp)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  "
                                 + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "'";
                    }
                   
                   
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(bankCum);
                    if (rs1.next()) {
                        bankYear = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();
                    String paoCum = "";
                    if(programme.equals(scode)){
                    	 if(schemesSizeTemp.equals("below5")){
					    		//schemeName +=" (Below 5 laks)";
					  paoCum = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                 + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                 + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  "
                                 + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.SANCTION_AMOUNT <=5";
					    	}else{
					    		//schemeName +=" (Above 5 laks)";
					   paoCum = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                 + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                 + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  "
                                 + "and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.SANCTION_AMOUNT >5 ";
					    	}
                    	// System.out.println("paoCum habs"+paoCum);   
                    }else{
                    	 paoCum = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                 + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
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
                    
                 /*    String bankLM = "";
                    bankLM = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                 + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                 + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and BANK_SEND_DATE>='01-APR-" + yearStart + "' "
                                 + "and BANK_SEND_DATE<'01-" + currentMonth + "-" + cyear + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(bankLM);
                    if (rs1.next()) {
                        bankLastMonth = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();
                    String paoLM = "";
                    paoLM = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                            + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                            + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and STATE_SEND_DATE>='01-APR-" + yearStart + "' "
                            + "and STATE_SEND_DATE<'01-" + currentMonth + "-" + cyear + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(paoLM);
                    if (rs1.next()) {
                        paoLastMonth = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();

                    String amountLM = ndf.format((bankLastMonth + paoLastMonth) / 100000); */
                    String bankTot = "";    
                    if(programme.equals(scode)){
                    	if(schemesSizeTemp.equals("below5")){
				    		//schemeName +=" (Below 5 laks)";
				 bankTot = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                 + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                 + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' "
                                 + "and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5";
				    	}else{
				    		//schemeName +=" (Above 5 laks)";
				   bankTot = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                 + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                 + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' "
                                 + "and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5 ";
				    	}
                    	// System.out.println("bankTot habs"+bankTot);   
                    }else{
                    	 bankTot = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                 + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                 + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' "
                                 + "and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
                    }
                   
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(bankTot);
                    if (rs1.next()) {
                        bankCurrentMonth = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();
                    String paoTot = "";
                    if(programme.equals(scode)){
                    	if(schemesSizeTemp.equals("below5")){
				    		//schemeName +=" (Below 5 laks)";
				paoTot = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "' "
                                + "and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT <=5";
				    	}else{
				    		//schemeName +=" (Above 5 laks)";
				  paoTot = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "' "
                                + "and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and a.SANCTION_AMOUNT >5 ";
				    	}
                    	 // System.out.println("paoTot habs"+paoTot);   
                    }else{
                    	paoTot = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                + "where WORK_CANCEL_DT is null and  a.programme_code in (" + programme + ")  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                                + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "' "
                                + "and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
                    }
                  
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(paoTot);
                    if (rs1.next()) {
                        paoCurrentMonth = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();
                    
                  //  String amountCM = ndf.format((bankCurrentMonth + paoCurrentMonth) / 100000);

                    String amountTot = ndf.format((bankLastMonth + paoLastMonth + bankCurrentMonth + paoCurrentMonth) / 100000);
                    
                    String phyCompNotFinBank = "";
                    if(programme.equals(scode)){
                    	if(schemesSizeTemp.equals("below5")){
				    		//schemeName +=" (Below 5 laks)";
				phyCompNotFinBank =  "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
        						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
    	    					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "' "
    	    					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
    	    					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id and a.work_id in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') and a.SANCTION_AMOUNT <=5";
				    	}else{
				    		//schemeName +=" (Above 5 laks)";
				phyCompNotFinBank =  "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
        						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
    	    					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "' "
    	    					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
    	    					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id and a.work_id in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') and a.SANCTION_AMOUNT >5 ";
				    	}
                    	//System.out.println("phyCompNotFinBank "+phyCompNotFinBank);
                    }else{
                    	phyCompNotFinBank =  "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
        						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
    	    					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "' "
    	    					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
    	    					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id and a.work_id in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "')";
                    }
                    
                            
                 
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(phyCompNotFinBank);
                    if (rs1.next()) {
                        bankPhyCompNotFin = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();
                    
                    
                    
                    
                    
                    
                    

                    String phyCompNotFinPAO = "";     
                    if(programme.equals(scode)){
                    	if(schemesSizeTemp.equals("below5")){
				    		//schemeName +=" (Below 5 laks)";
				 phyCompNotFinPAO = "select sum(nvl(BILL_AMOUT_STATE,0)) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
         						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
     	    					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "'  and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "'"
     	    					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
     	    					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id and a.work_id in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') and a.SANCTION_AMOUNT <=5";
				    	}else{
				    		//schemeName +=" (Above 5 laks)";
			 phyCompNotFinPAO = "select sum(nvl(BILL_AMOUT_STATE,0)) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
         						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
     	    					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "'  and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "'"
     	    					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
     	    					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id and a.work_id in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "') and a.SANCTION_AMOUNT >5 ";
				    	}
                    	// System.out.println("phyCompNotFinPAO : "+phyCompNotFinPAO);
                    }else{
                    	 phyCompNotFinPAO = "select sum(nvl(BILL_AMOUT_STATE,0)) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
         						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
     	    					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "'  and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "'"
     	    					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
     	    					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id and a.work_id in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and to_date(DATE_OF_COMPLETION)<='31-MAR-" + yearStart + "')";
                    }
                   
                      
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(phyCompNotFinPAO);
                    if (rs1.next()) {
                        paoPhyCompNotFin = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();
                    String amountPhyCompNotFin = ndf.format((bankPhyCompNotFin + paoPhyCompNotFin) / 100000);
                    
                    
				    String ExpIncPhyCompNotFinBank = "";
				    if(programme.equals(scode)){
				    	if(schemesSizeTemp.equals("below5")){
				    		//schemeName +=" (Below 5 laks)";
			 ExpIncPhyCompNotFinBank =  "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
		    						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
			    					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "'"
			    					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
			    					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id  and a.SANCTION_AMOUNT <=5";
				    	}else{
				    		//schemeName +=" (Above 5 laks)";
			  ExpIncPhyCompNotFinBank =  "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
		    						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
			    					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "'"
			    					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
			    					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id  and a.SANCTION_AMOUNT >5 ";
				    	}
				    ///	System.out.println("ExpIncPhyCompNotFinBank "+ExpIncPhyCompNotFinBank);
				    }else{
				    	 ExpIncPhyCompNotFinBank =  "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) as BILL_AMOUNT_CENTRAL from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
		    						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
			    					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(BANK_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(BANK_SEND_DATE)<='31-MAR-" + yearEnd + "'"
			    					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
			    					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";
		                            
				    }
				   
                 	
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(ExpIncPhyCompNotFinBank);
                    if (rs1.next()) {
                        expIncBankPhyCompNotFin = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();

                    String ExpIncPhyCompNotFinPAO = "";      
                    if(programme.equals(scode)){
                    	if(schemesSizeTemp.equals("below5")){
				    		//schemeName +=" (Below 5 laks)";
		 ExpIncPhyCompNotFinPAO = "select sum(nvl(BILL_AMOUT_STATE,0)) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
         						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
     	    					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "'"
     	    					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
     	    					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id  and a.SANCTION_AMOUNT <=5";
				    	}else{
				    		//schemeName +=" (Above 5 laks)";
			 ExpIncPhyCompNotFinPAO = "select sum(nvl(BILL_AMOUT_STATE,0)) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
         						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
     	    					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "'"
     	    					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
     	    					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id  and a.SANCTION_AMOUNT >5 ";
				    	}
                    //	System.out.println("ExpIncPhyCompNotFinPAO "+ExpIncPhyCompNotFinPAO);
                    }else{
                    	 ExpIncPhyCompNotFinPAO = "select sum(nvl(BILL_AMOUT_STATE,0)) as BILL_AMOUT_STATE from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,"
         						+ " rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
     	    					+ " and a.TYPE_OF_ASSET in (" + schemes + ") and to_date(STATE_SEND_DATE)>='01-APR-" + yearStart + "' and to_date(STATE_SEND_DATE)<='31-MAR-" + yearEnd + "'"
     	    					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("+ programme+ ") AND a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and "
     	    					+ " i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and b.work_id=a.work_id ";
                    }
                   
                       
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(ExpIncPhyCompNotFinPAO);
                    if (rs1.next()) {
                        expIncPhyCompNotFin = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();
                    String amountExpIncPhyCompNotFin = ndf.format((expIncBankPhyCompNotFin + expIncPhyCompNotFin) / 100000);
                   // arfc = estCost - (bankLastYear + paoLastYear + bankLastMonth + paoLastMonth + bankCurrentMonth + paoCurrentMonth) / 100000;
                   if(mainProgrammeName.equals("JHC")){
                	   noOfWorks=1;
                	   System.out.println("noOfWorks: "+noOfWorks+" estCost: "+noOfWorks+"habsSanctioned: "+habsSanctioned);
                   	System.out.println("worksComp: "+worksComp+" habsCov: "+habsCov+" popCov: "+popCov);
                   	System.out.println("popBenf: "+popBenf+" bankYear: "+bankYear+"paoYear: "+paoYear);
                   	System.out.println("bankLastMonth: "+bankLastMonth+" paoLastMonth: "+paoLastMonth+" bankCurrentMonth: "+bankCurrentMonth);
                   	System.out.println("worksPhyCompNotFin: "+worksPhyCompNotFin+" paoPhyCompNotFin: "+paoPhyCompNotFin+"bankPhyCompNotFin: "+bankPhyCompNotFin);   
                   }
                   if(noOfWorks==0 && estCost==0 && habsSanctioned==0 && worksComp==0 &&  habsCov==0 && popCov==0 &&
                   popBenf==0 && bankYear==0.0 && paoYear==0.0 && bankLastMonth ==0.0 && paoLastMonth==0.0 &&
                     bankCurrentMonth ==0.0 && paoCurrentMonth==0.0 && worksPhyCompNotFin==0.0&&paoPhyCompNotFin==0 &&bankPhyCompNotFin==0)
                 {
                	   System.out.println("inside 1136");
                 }else{
                	 if (styleCount % 2 == 0) {
                         style = "gridbg1";
                         System.out.println("inside 1140");
                     } else {
                         style = "gridbg2";
                         System.out.println("inside 1143");
                     }
                     styleCount++;  
                %>
                    <tr>
                    <%System.out.println("mainProgrammeName=== "+mainProgrammeName+" dupeProgrammeName??==  "+dupeProgrammeName);
                    if(!mainProgrammeName.equals(dupeProgrammeName)){ 
                    //System.out.println("programme----"+mainProgrammeName);
                    %>
                             <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><%=++slno%></td>
                             <%if(mainProgrammeName.equals("NRDWP RELATED")){ %>
                              <td class="<%=style%>" style="text-align: left;" align="right" width="100px"><a href="rws_work_progress_min_circle_div_rpt.jsp?mode=circles&programme=<%=progCodeNRDWP%>&programmeName=<%=mainProgrammeName%>&schemes=<%=schemesTot %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>"><%=mainProgrammeName%></a></td>
                              <%}else{
                            	 
                            	  %>
                              <%if(programme.equals(scode)){ 
                            	  String abc="";
                            	  //System.out.println("@@@@@@@@@@@@@@@@@@@@@"+programe); %>
                                                            <td class="<%=style%>" style="text-align: left;" align="right" width="100px"><a href="rws_work_progress_min_circle_div_rpt.jsp?mode=circles&programme=<%=programme%>&programmeName=<%=mainProgrammeName%>&schemes=<%=schemesTot %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=abc %>"><%=mainProgrammeName%></a></td>
                              
                              
<%--                                 <td class="<%=style%>" style="text-align: left;" align="right" width="100px"><%=mainProgrammeName%></td>
 --%>                              
                              
                             <%}else{ 
                            	 //System.out.println("@@@@@@@@@@@@@@@@@@@@@"+programe);
                            	 %>
                              <td class="<%=style%>" style="text-align: left;" align="right" width="100px"><a href="rws_work_progress_min_circle_div_rpt.jsp?mode=circles&programme=<%=programme%>&programmeName=<%=mainProgrammeName%>&schemes=<%=schemesTot %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>"><%=mainProgrammeName%></a></td>
                             
                             <%} %>
                             <%}}else{ %>
                             <td class="<%=style%>" style="text-align: right;" align="right" width="50px"></td>
                              <td class="<%=style%>" style="text-align: right;" align="right" width="100px"></td>
                             <%} %>
                              <td class="<%=style%>" style="text-align: left;" align="right" width="100px"><a href="rws_work_progress_min_circle_div_rpt.jsp?mode=circles&programme=<%=programme%>&programmeName=<%=programmeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>"><%=programmeNam%> (<b><%=schemeName %></b>)</a></td>
                              <%-- <%if(!oldprogName.equals(programmeNam)){ %>
                             <td class="<%=style%>" style="text-align: left;" align="right" width="100px"><a href="rws_work_progress_min_circle_div_rpt.jsp?mode=circles&programme=<%=programme%>&programmeName=<%=programmeNam%>"><%=programmeNam%></a></td>
                             <%}else{ %>
                             <td class="<%=style%>" style="text-align: left; " align="right" width="100px"></td>
                             <%} %> --%>
                             <td class="<%=style%>" style="text-align: right;" align="right" width="50px">
                             <a href="rws_work_progress_min_abstract_subprog_rpt.jsp?programme=<%=programme %>&programmeName=<%=programmeNam%>&scheme=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>&pc=<%=programme%>"  onmouseover="Tip(this.value,TITLE,'Click Here To View the Sub Program wise Details for Programme <%=programmeNam %> and Scheme <%=schemeName %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"  onmouseout="UnTip()"><b>Click&nbsp;Here</b></a>
                             </td>
                             <%if(schemeName.equals("SVS")){ %>
                             <td class="<%=style%>" style="text-align: left;" align="center" width="100px"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=tWorks&pc=<%=programme%>&pn=<%=programmeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><font color="blue" ><b><%=schemeName %>-<%=noOfWorks%></b></font></a></td>
                             <%}else if(schemeName.equals("MVS")){ %>
                             <td class="<%=style%>" style="text-align: left;" align="center" width="100px"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=tWorks&pc=<%=programme%>&pn=<%=programmeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><font color="green" ><b><%=schemeName %>-<%=noOfWorks%></b></font></a></td>
                             <%}
                             else{ %>
                             <td class="<%=style%>" style="text-align: left;" align="center" width="100px"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=tWorks&pc=<%=programme%>&pn=<%=programmeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><font color="orange" ><b><%=schemeName %>-<%=noOfWorks%></b></font></a></td>
                             <%} %>                             
                             <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=ndf.format(estCost) %></td>
                             <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=sHabs&pc=<%=programme%>&pn=<%=programmeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=habsSanctioned%></a></td>
                              <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=fhtcforsac&pc=<%=programme%>&pn=<%=programmeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=fhtc_for_house_holds%></a></td>
                             <td class="<%=style%>" style="text-align: right;" align="right" width="60px"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=ngWorks&pc=<%=programme%>&pn=<%=programmeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksNotGround%> </a></td>
                             <td class="<%=style%>" style="text-align: right;" align="right" width="60px"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=gWorks&pc=<%=programme%>&pn=<%=programmeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksGround%></a></td>
                             <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=uWorks&pc=<%=programme%>&pn=<%=programmeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksUnderProgress%></a></td>
                             <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=cWorks&pc=<%=programme%>&pn=<%=programmeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksComp%></a></td>
                             <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=comWorks&pc=<%=programme%>&pn=<%=programmeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=worksComm%></a></td>
                       		 <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=cHabs&pc=<%=programme%>&pn=<%=programmeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=habsCov%></a></td>
                       		 <td class="<%=style%>" style="text-align: right;" align="right" width="50px"><a href="#" onclick="viewWorks('./rws_work_progress_min_abstract_drill.jsp?mode=fhtcforprovided&pc=<%=programme%>&pn=<%=programmeNam%>&schemes=<%=schemes %>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&schemeName=<%=schemeName %>')"><%=fhtsprovided%></a></td>
	                         <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=amountCum%></td>
	                         <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=amountTot%></td>
	                         <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=amountPhyCompNotFin%></td>
	                         <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=amountExpIncPhyCompNotFin%></td>
	                         <td class="<%=style%>" style="text-align: right;" align="right" width="100px"><%=ndf.format(billamount)%></td>
                        </tr>
                <%
	                dupeProgrammeName=mainProgrammeName;
	                oldprogName=programmeNam;
                   }
                   		totNoOfWorks = totNoOfWorks + noOfWorks;
                        totEstCost = totEstCost + estCost;
                        totHabsSanctioned = totHabsSanctioned + habsSanctioned;
                        totWorksComp = totWorksComp + worksComp;
                        totWorksComm = totWorksComm + worksComm;
                        totWorksGround = totWorksGround + worksGround;//System.out.println("totWorksGround: "+totWorksGround);System.out.println("worksGround: "+worksGround);
                        totWorksNotGround = totWorksNotGround + worksNotGround;
                        totWorksUnderProgress = totWorksUnderProgress + worksUnderProgress;
                        totHabsCov = totHabsCov + habsCov;
                        totPopCov = totPopCov + popCov;
                        totPopBenf = totPopBenf + popBenf;
                        totExpUptoFY = totExpUptoFY + bankYear + paoYear;
                        totExpUptoLM = totExpUptoLM + bankLastMonth + paoLastMonth;
                        totExpDM = totExpDM + bankCurrentMonth + paoCurrentMonth;
                        totTotExp = totExpUptoLM + totExpDM;
                       // totarfc = totarfc + arfc;
                       // totWorksPhyCompNotFin = totWorksPhyCompNotFin  + worksPhyCompNotFin;
                        totExpPhyCompNotFin = totExpPhyCompNotFin+ bankPhyCompNotFin + paoPhyCompNotFin;
                        totExpIncPhyCompNotFin = totExpIncPhyCompNotFin+ expIncBankPhyCompNotFin + expIncPhyCompNotFin;
                        totHouseholds=totHouseholds+fhtc_for_house_holds;
                        totfhtsprovided=totfhtsprovided+fhtsprovided;
                        totbillamt=totbillamt+billamount;
                 
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
                <td class="btext" style="text-align: right;" colspan=4>Total:</td>
                <td class="btext" style="text-align: right;"><%=totNoOfWorks%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totEstCost)%></td>
                <td class="btext" style="text-align: right;"><%=totHabsSanctioned%></td>
                 <td class="btext" style="text-align: right;"><%=totHouseholds%></td>
                <td class="btext" style="text-align: right;"><%=totWorksNotGround%></td>
                <td class="btext" style="text-align: right;"><%=totWorksGround%></td>
                <td class="btext" style="text-align: right;"><%=totWorksUnderProgress%></td>
                <td class="btext" style="text-align: right;"><%=totWorksComp%></td>
                <td class="btext" style="text-align: right;"><%=totWorksComm%></td>
                <td class="btext" style="text-align: right;"><%=totHabsCov%></td>
                <td class="btext" style="text-align: right;"><%=totfhtsprovided%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totExpUptoFY / 100000)%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totTotExp / 100000)%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totExpPhyCompNotFin / 100000)%></td>
             	<td class="btext" style="text-align: right;"><%=ndf.format(totExpIncPhyCompNotFin / 100000)%></td>
             <td class="btext" style="text-align: right;"><%=ndf.format(totbillamt)%></td>
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