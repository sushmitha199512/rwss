
<%@page import="nic.watersoft.works.WorksData1"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 
<style>
.thumbnail{
	position: relative;
	z-index: 0;
	}

	.thumbnail:hover{
	background-color: transparent;
	z-index: 60;
	}

	.thumbnail span{ /*CSS for enlarged image*/
	position: absolute;
	background-color: lightyellow;
	padding: 4px;
	left: -1000px;
	border: 1px dashed gray;
	visibility: hidden;
	color: black;
	text-decoration: none;
	}

	.thumbnail span img{ /*CSS for enlarged image*/
	border-width: 0;
	padding: 2px;
	}

	.thumbnail:hover span{ /*CSS for enlarged image on hover*/
	visibility: visible;
	top: -120px;
	left: -350px; /*position where enlarged image should offset horizontally */

	}
</style>
<html:html>
    <head>
        <title>Report</title>
        <link rel="stylesheet" type="text/css" href="style.css"> 

    </head>
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
    // Fudge factors for window decoration space.
            // In my tests these work well on all platforms & browsers.
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
    <%
    DecimalFormat ndf = new DecimalFormat("####.00");
        String coc = request.getParameter("coc");
        String con = request.getParameter("con");
        String doc = request.getParameter("doc");
        String don = request.getParameter("don");
        String soc = request.getParameter("soc");
        String son = request.getParameter("son");
        String pc = request.getParameter("pc");
        String pn = request.getParameter("pn");
        String mode = request.getParameter("mode");
        String mode1 = request.getParameter("mode1");
        String spc = request.getParameter("spc");
        String spn = request.getParameter("spn");

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
        yearStart=Integer.parseInt(request.getParameter("yearStart"));
        yearEnd=Integer.parseInt(request.getParameter("yearEnd"));
      /*   if (month <= 3) {
            yearStart = cyear - 1;
            yearEnd = cyear;
        } else {
            yearStart = cyear;
            yearEnd = cyear + 1;
        } */
        String schemes = request.getParameter("schemes");
        String sub = "ALL";
        if (request.getParameter("sub") != null) {
            sub = (String) request.getParameter("sub");
        }

        int count = 1;
        int styleCount = 0;
        String style = "";
        String query = "";

    %>
    <table border = 1 cellspacing = 0 cellpadding = 0 width="70%"  bordercolor=#000000 style="border-collapse:collapse"  ALIGN=CENTER>
        <caption>
            <table  border=0 rules=none style="border-collapse:collapse" align = "right">			
                <a href="javascript:onclick=history.go(-1)">Back</a>&nbsp;|&nbsp;
                <a href="#" onClick="window.close();">Close</a>
            </table>
        </caption>
        <tr  align="center">
            <td align="center" class=gridhdbg ></td><td align="center" class=gridhdbg >ABSTRACT DETAILED REPORT - WEEKLY REVIEW BY HON'BLE CHIEF SECRETARY WITH DISTRICT COLLECTORS for &nbsp;<%=yearStart%>-<%=yearEnd%> and  Programme:&nbsp;<%=pn%> </td>
        </tr>
    </table>
    <table    width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
        <%if (!mode.equals("sHabs") && !mode.equals("cHabs") ) { %>
        <tr align=center>
            <td class=gridhdbg rowspan="3"><b>SL&nbsp;NO   </b></td>
            <td class=gridhdbg rowspan="3"><b>District</b></td>
            <td class=gridhdbg rowspan="3"><b>Constituency</b></td>
            <td class=gridhdbg rowspan="3"><b>WorkId</b></td>
            <td class=gridhdbg rowspan="3"><b>Work Name </b></td>
            <td class=gridhdbg rowspan="3"><b>Est. Cost(In Lakhs.) </b></td>
            <td class=gridhdbg rowspan="3"><b>Exp. Up to 31.03.<%=yearStart %>(In Lakhs.) </b></td>
            <td class=gridhdbg rowspan="3"><b>Habs Sanctioned </b></td>
            <td class=gridhdbg colspan="2"><b>Admin Sanction</b></td>
            <%if(!mode.equals("ngWorks")) {%>
            <td class=gridhdbg rowspan="3"><b>Entrustment/<br>Grounding Date</b></td>
            <td class=gridhdbg rowspan="3"><b>Stipulated Date of Completion</b></td>
			<td class=gridhdbg rowspan="3"><b>Probable Date of Completion </b></td>
            <td class=gridhdbg colspan="8"><b>Physical Stage</b></td>
            <td class=gridhdbg colspan="3"><b>Payments(<%=yearStart %> - <%=yearEnd %>) </b></td>
             <%if(mode.equals("comWorks") || mode.equals("cWorks") ) {%>
            <td class=gridhdbg rowspan="3"><b>Work Completion Date </b></td>
            <%} %>
            <%if(mode.equals("comWorks")) {%>
            <td class=gridhdbg rowspan="3"><b>Work Commissioned Date </b></td>
            <%} %>
            <td class=gridhdbg rowspan="3"><b>Image1 </b></td>
            <td class=gridhdbg rowspan="3"><b>Image2</b></td>
            <%} %>
        </tr>
       
        <tr>
        	<td class=gridhdbg rowspan="2"><b>No. </b></td>
            <td class=gridhdbg rowspan="2"><b>Date</b></td>
             <%if(!mode.equals("ngWorks")) {%>
            <td class=gridhdbg rowspan="2"><b>Source Creation (Y/N) </b></td>
            <td class=gridhdbg ><b>Head Works</b></td>
            <td class=gridhdbg colspan="2"><b>Pipe Lines(Length in Meters) </b></td>
            <td class=gridhdbg colspan="2"><b>OHSRs</b></td>
            <td class=gridhdbg rowspan="2"><b>Testing Done/Water released  (Y/N)</b></td>
            <td class=gridhdbg rowspan="2"><b>Total % of Comp (0-25%/25-50%, 50-75%, 75-100%)</b></td>
            <td class=gridhdbg rowspan="2"><b>Value of work done</b></td>
            <td class=gridhdbg rowspan="2">Paid</td>
            <td class=gridhdbg rowspan="2">To be Paid</td>
            <%} %>
        </tr>
         <tr>
         <%if(!mode.equals("ngWorks")) {%>
       
	        <td class=gridhdbg ><b>% of completion</b></td>
	        <td class=gridhdbg ><b>Total length to be laid</b></td>
	        <td class=gridhdbg ><b>Laid so far</b></td>
	        <td class=gridhdbg ><b>Sanctioned</b></td>
	        <td class=gridhdbg ><b>Comp.</b></td>
	          <%} %>
        </tr>
      
        <%
            Statement statement = null;
            ResultSet resultSet = null;
            try {
              
                if (mode.equals("tWorks")) {
                    query = "select distinct a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--') as admindate,nvl(to_char(TARGET_DATE_COMP ,'dd/mm/yyyy'),'--') as TARGET_DATE_COMP,ADMIN_NO,dis.dname,nvl(a.lead_habitation,'--') as lead_habitation,nvl(to_char(m.DATE_OF_COMPLETION,'dd/mm/yyyy'),'--') as stipDate,nvl(m.PERCENT_COMPLETED,0) as PERCENT_COMPLETED,nvl(to_char(m.AGREEMENT_DATE,'dd/mm/yyyy'),'--') as AGREEMENT_DATE,nvl(to_char(GROUNDING_DATE,'dd/mm/yyyy'),'--') as GROUNDING_DATE,nvl(SOURCE_CODE,'--') as SOURCE_CODE from "
                            + "rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c, rws_contractor_selection_tbl m,rws_district_tbl dis where dis.dcode=substr(a.work_id,5,2) and "
                            + "WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + pc + ") "
                            + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                            + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  "
                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y'";
                }else if (mode.equals("cWorks")) {                    
                    query = "select distinct a.SANCTION_AMOUNT, a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--') as admindate,nvl(to_char(TARGET_DATE_COMP ,'dd/mm/yyyy'),'--')  as TARGET_DATE_COMP,ADMIN_NO,dis.dname,nvl(a.lead_habitation,'--') as lead_habitation,nvl(to_char(m.DATE_OF_COMPLETION,'dd/mm/yyyy'),'--') as stipDate,nvl(m.PERCENT_COMPLETED,0) as PERCENT_COMPLETED,nvl(to_char(m.AGREEMENT_DATE,'dd/mm/yyyy'),'--') as AGREEMENT_DATE,nvl(to_char(GROUNDING_DATE,'dd/mm/yyyy'),'--') as GROUNDING_DATE,to_char(b.DATE_OF_COMPLETION,'dd/mm/yyyy') as compdate,nvl(SOURCE_CODE,'--') as SOURCE_CODE "
                            + "from RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_district_tbl dis  where dis.dcode=substr(a.work_id,5,2) and "
                            + "WORK_CANCEL_DT is null and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
                            + "and h.work_id=a.work_id and hd.hab_code=h.hab_code and a.programme_code in ("+pc+")  and TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-"+yearStart+"' and TO_DATE(b.DATE_OF_COMPLETION)<='31-MAR-" + yearEnd + "' and b.DATE_OF_COMPLETION is not null and "
                            + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
                }else if (mode.equals("ngWorks")) {                    
                	query = "select distinct a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--') as admindate,nvl(to_char(TARGET_DATE_COMP ,'dd/mm/yyyy'),'--')  as TARGET_DATE_COMP,ADMIN_NO,dis.dname,nvl(a.lead_habitation,'--') as lead_habitation,nvl(SOURCE_CODE,'--') as SOURCE_CODE from "
                			+" RWS_WORK_ADMN_TBL a,rws_programme_tbl p,rws_district_tbl dis,RWS_SOURCE_IDEN_FIN_TBL i where substr(a.work_id,5,2)=dis.dcode and a.work_id not in "
     						+"(select work_id from RWS_WORK_COMMENCEMENT_TBL where GROUNDING_DATE is not null ) and a.work_id not in " 
                            +"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)  " 
                            +"and WORK_CANCEL_DT is null and a.programme_code=p.PROGRAMME_CODE and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y'  and  "
                            +"  a.PROGRAMME_CODE in ("+pc+") and TO_DATE(TARGET_DATE_COMP)>='01-APR-"+ yearStart+"' "
                            +" and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id ";
                }else if (mode.equals("gWorks")) {                    
                	query = "select distinct a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--') as admindate,nvl(to_char(TARGET_DATE_COMP ,'dd/mm/yyyy'),'--')  as TARGET_DATE_COMP,ADMIN_NO,dis.dname,nvl(a.lead_habitation,'--') as lead_habitation,nvl(to_char(m.DATE_OF_COMPLETION,'dd/mm/yyyy'),'--') as stipDate,nvl(m.PERCENT_COMPLETED,0) as PERCENT_COMPLETED,nvl(to_char(m.AGREEMENT_DATE,'dd/mm/yyyy'),'--') as AGREEMENT_DATE,nvl(to_char(GROUNDING_DATE,'dd/mm/yyyy'),'--') as GROUNDING_DATE,nvl(SOURCE_CODE,'--') as SOURCE_CODE from "
                            + "rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c, rws_contractor_selection_tbl m,rws_district_tbl dis,rws_new_est_tbl t where substr(a.work_id,5,2)=dis.dcode and "
                            + "WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + pc + ") "
                            + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and TO_DATE(DATE_OF_COMPLETION)<'01-APR-" + yearStart + "') "
                            + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id and t.work_id=a.work_id "
                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y'";
                }else if (mode.equals("uWorks25")||mode.equals("uWorks50") ||mode.equals("uWorks75")||mode.equals("uWorks100")||mode.equals("uWorks")) {                    
                	query = "select distinct a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--') as admindate,nvl(to_char(TARGET_DATE_COMP ,'dd/mm/yyyy'),'--')  as TARGET_DATE_COMP,ADMIN_NO,dis.dname,nvl(a.lead_habitation,'--') as lead_habitation,nvl(to_char(m.DATE_OF_COMPLETION,'dd/mm/yyyy'),'--') as stipDate,nvl(m.PERCENT_COMPLETED,0) as PERCENT_COMPLETED,nvl(to_char(m.AGREEMENT_DATE,'dd/mm/yyyy'),'--') as AGREEMENT_DATE,nvl(to_char(GROUNDING_DATE,'dd/mm/yyyy'),'--') as GROUNDING_DATE,nvl(i.SOURCE_CODE,'--') as SOURCE_CODE from "
                            + "rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c, rws_contractor_selection_tbl m,rws_district_tbl dis,rws_new_est_tbl t where substr(a.work_id,5,2)=dis.dcode and "
                            + "WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + pc + ") "
                            + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null ) "
                            + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id=a.work_id  and c.work_id=a.work_id and m.work_id=a.work_id and t.work_id=a.work_id "
                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y'";
                     if(mode.equals("uWorks25"))
                    	 query+=" and (m.PERCENT_COMPLETED is null or m.PERCENT_COMPLETED<=25) " ;
                     else if(mode.equals("uWorks50"))
                    	 query+=" and m.PERCENT_COMPLETED>25 and m.PERCENT_COMPLETED<=50 " ;
                     else if(mode.equals("uWorks75"))
                    	 query+=" and m.PERCENT_COMPLETED>50 and m.PERCENT_COMPLETED<=75 " ;
                     else if(mode.equals("uWorks100"))
                    	 query+=" and m.PERCENT_COMPLETED>75 and m.PERCENT_COMPLETED<=100 " ;
                }else if (mode.equals("comWorks")) {                    
	               	  query = "select distinct a.SANCTION_AMOUNT, a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--') as admindate,nvl(to_char(TARGET_DATE_COMP ,'dd/mm/yyyy'),'--')  as TARGET_DATE_COMP,ADMIN_NO,dis.dname,nvl(a.lead_habitation,'--') as lead_habitation,to_char(b.DATE_OF_COMM,'dd/mm/yyyy') as DATE_OF_COMM,nvl(to_char(m.DATE_OF_COMPLETION,'dd/mm/yyyy'),'--')  as stipDate,nvl(m.PERCENT_COMPLETED,0) as PERCENT_COMPLETED,nvl(to_char(m.AGREEMENT_DATE,'dd/mm/yyyy'),'--') as AGREEMENT_DATE,nvl(to_char(GROUNDING_DATE,'dd/mm/yyyy'),'--') as GROUNDING_DATE,to_char(b.DATE_OF_COMPLETION,'dd/mm/yyyy') as compdate,nvl(SOURCE_CODE,'--') as SOURCE_CODE "
                             + "from RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_district_tbl dis  where dis.dcode=substr(a.work_id,5,2) and "
                             + "WORK_CANCEL_DT is null and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
                             + "and h.work_id=a.work_id and hd.hab_code=h.hab_code and a.programme_code in ("+pc+") and b.DATE_OF_COMPLETION is not null and TO_DATE(b.DATE_OF_COMM) >= '01-APR-" + yearStart + "' and TO_DATE(b.DATE_OF_COMM)<='31-MAR-" + yearEnd + "' and b.DATE_OF_COMM is not null and "
                             + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y'";
                }else {
                      query = "select distinct a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--') as admindate,nvl(to_char(TARGET_DATE_COMP ,'dd/mm/yyyy'),'--')  as TARGET_DATE_COMP,ADMIN_NO,dis.dname,nvl(a.lead_habitation,'--') as lead_habitation,nvl(to_char(m.DATE_OF_COMPLETION,'dd/mm/yyyy'),'--') as stipDate,nvl(m.PERCENT_COMPLETED,0) as PERCENT_COMPLETED,nvl(to_char(m.AGREEMENT_DATE,'dd/mm/yyyy'),'--') as AGREEMENT_DATE,nvl(to_char(GROUNDING_DATE,'dd/mm/yyyy'),'--') as GROUNDING_DATE,nvl(SOURCE_CODE,'--') as SOURCE_CODE from "
                             + " rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c, rws_contractor_selection_tbl m ,rws_district_tbl dis  where dis.dcode=substr(a.work_id,5,2) and "
                             + "  WORK_CANCEL_DT is null and   a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + pc + ") and "
                             + "a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)"
           	                 + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and a.TYPE_OF_ASSET in (" + schemes + ") and a.CORE_DASHBOARD_STATUS='Y'";
                }
                if(spc!=null) {
                    query += "and a.subprogramme_code in (" + spc + ")";
                } 
                if(coc!=null) {
                    query += " and SUBSTR(a.OFFICE_CODE,2,2)='"+coc+"'";
                }
                if(doc!=null) {
                    query += " and SUBSTR(a.OFFICE_CODE,4,1)='"+doc+"'";
                }
                if(soc!=null) {
                    query += " and SUBSTR(a.OFFICE_CODE,5,2)='"+soc+"'";
                }
                query += " order by a.work_id";
                
                //System.out.println(query);
                stmt = conn.createStatement();
                rs = stmt.executeQuery(query);
                double totEstCost=0,totCommExpUpyo31=0,totExpDY=0,totValueOfWork=0,totToBePaid=0;
                while (rs.next()) {
                	double estCost=rs.getDouble(1);
                    String compDate = "",physicalStage="";
                    Double bankAmount=0.0,paoAmount=0.0,tot_amountupto31=0.0;
					 String bank = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL where work_id='"+ rs.getString("work_id")+"' and BANK_SEND_DATE is not null and to_date(BANK_SEND_DATE)<='31-MAR-" + yearStart + "'";            
					 statement=conn.createStatement();
					 resultSet=statement.executeQuery(bank);
	                  if (resultSet.next()) {
	                      bankAmount = resultSet.getDouble(1);
	                  }
	                  statement.close();
	                  resultSet.close();

	                  String paocurrMonth = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL  where work_id='"+ rs.getString("work_id")+"' and STATE_SEND_DATE is not null and to_date(STATE_SEND_DATE)<='31-MAR-" + yearStart + "'";
	                  statement = conn.createStatement();
	                  resultSet = statement.executeQuery(paocurrMonth);
	                  if (resultSet.next()) {
	                      paoAmount = resultSet.getDouble(1);

	                  }
	                  statement.close();
	                  resultSet.close();
	                  tot_amountupto31=bankAmount+paoAmount;
                    
                    String workCompletion = "select to_char(DATE_OF_COMPLETION,'dd/mm/yyyy') from rws_work_completion_tbl where work_id='" + rs.getString(2) + "' and DATE_OF_COMPLETION is not null";
                    statement = conn.createStatement();
                    resultSet = statement.executeQuery(workCompletion);
                    if (resultSet.next()) {
                        compDate = resultSet.getString(1);
                    } else {
                        compDate = "--";
                    }
                    statement.close();
                    resultSet.close();
                    
                    String isTestedSource="";
                    String sourceTested = "select source_code from RWS_WQ_TEST_RESULTS_TBL where source_code='"+rs.getString("SOURCE_CODE")+"'";
                    statement = conn.createStatement();
                    resultSet = statement.executeQuery(sourceTested);
                    if (resultSet.next()) {
                    	isTestedSource="Yes";
                    } else {
                    	isTestedSource="No";
                    }
                    statement.close();
                    resultSet.close();
                    
                    String noofHabs = "";
                    String habs = "";
                    if (mode.equals("cWorks")) {
                        habs = "select count(distinct hab_code) from RWS_WORK_COMP_HAB_LNK_TBL where work_id='" + rs.getString(2) + "'";
                    } else {
                        habs = "select count(distinct hab_code) from RWS_ADMN_HAB_LNK_TBL where work_id='" + rs.getString(2) + "'";
                    }
                    statement = conn.createStatement();
                    resultSet = statement.executeQuery(habs);
                    if (resultSet.next()) {
                        noofHabs = resultSet.getString(1);
                    } else {
                        noofHabs = "0";
                    }
                    statement.close();
                    resultSet.close();
                    
                  String leadHab=rs.getString("lead_habitation");
                  String constName="";
                  if(!leadHab.equals("--")){
	                  String constQuery="select constituency_name from rws_constituency_tbl where dcode='"+leadHab.substring(0,2)+"' and mcode='"+leadHab.substring(5,7)+"'";
	                  statement = conn.createStatement();
	                  resultSet = statement.executeQuery(constQuery);
	                  if (resultSet.next()) {
	                	  constName = resultSet.getString(1);
	                  }
	                  statement.close();
	                  resultSet.close();
                  }
                  else{
                	  constName=leadHab;
                  }
                  
                  Double bankAmountDY=0.0,paoAmountDY=0.0,tot_amountDY=0.0;
				 String bankDY = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL where work_id='"+ rs.getString(2)+"' and TO_DATE(BANK_SEND_DATE)>='01-APR-"+yearStart+"' and TO_DATE(BANK_SEND_DATE)<='31-MAR-"+yearEnd+"'";
				 statement=conn.createStatement();
				 resultSet=statement.executeQuery(bankDY);
                  if (resultSet.next()) {
                      bankAmountDY = resultSet.getDouble(1);
                  }
                  statement.close();
                  resultSet.close();
                  String paoDY = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL  where work_id='"+ rs.getString(2)+"' and TO_DATE(STATE_SEND_DATE)>='01-APR-"+yearStart+"' and TO_DATE(STATE_SEND_DATE)<='31-MAR-"+yearEnd+"'";
                  statement = conn.createStatement();
                  resultSet = statement.executeQuery(paoDY);		                 
                  if (resultSet.next()) {
                      paoAmountDY = resultSet.getDouble(1);
                  }
                  statement.close();
                  resultSet.close();
                  tot_amountDY=bankAmountDY+paoAmountDY+tot_amountupto31;
                  double valOfWorkDone=0;
                  String valOfWorkDoneQry = "select sum(nvl(PERCENT_COMPLETED_VAL,0)) from RWS_MILESTONE_TARGET_ACH_TBL where work_id='"+rs.getString("work_id")+"'";
                  statement = conn.createStatement();
                  resultSet = statement.executeQuery(valOfWorkDoneQry);
                  if (resultSet.next()) {
                	  valOfWorkDone=resultSet.getDouble(1);
                  } 
                  statement.close();
                  resultSet.close();
                  
                  String partAAmount = "select sum(nvl(BILL_AMT_CONTRACTOR,0)) from RWS_WORK_BILL_TBL where work_id='"+rs.getString("work_id")+"' and BILL_TYPE='A'";
                  statement = conn.createStatement();
                  resultSet = statement.executeQuery(partAAmount);
                  if (resultSet.next()) {
                	  valOfWorkDone+=resultSet.getDouble(1);
                  } 
                  statement.close();
                  resultSet.close();
                  
                 double toBePaid=valOfWorkDone-(bankAmountDY+paoAmountDY+tot_amountupto31);
                  
                    if (styleCount % 2 == 0) {
                        style = "gridbg1";
                    } else {
                        style = "gridbg2";
                    }
                    styleCount++;
        %>
        <tr>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=count++%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString("dname")%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=constName%></td>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=rs.getString("work_id")%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString("work_name")%></td>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(estCost)%></td>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(tot_amountupto31/100000)%></td>
            <%if(mode.equals("cWorks")) { %>
            	<td class="<%=style%>" style="text-align: left;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=cHabs&mode1=wrk&wid=<%=rs.getString(2)%>&pc=<%=pc%>&pn=<%=pn%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=noofHabs%></a></td>
            <%}else{%>
            	<td class="<%=style%>" style="text-align: left;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=sHabs&mode1=wrk&wid=<%=rs.getString(2)%>&pc=<%=pc%>&pn=<%=pn%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>')"><%=noofHabs%></a></td>
            <%}%>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString("ADMIN_NO")%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString("admindate")%></td>
            <%if(!mode.equals("ngWorks")) {%>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString("AGREEMENT_DATE") %> / <br><%=rs.getString("GROUNDING_DATE")  %></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString("stipDate")%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString("TARGET_DATE_COMP")%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%if(!rs.getString("SOURCE_CODE").equals("--")){%>Yes<%}else {%>No<%} %></td>
            <td class="<%=style%>" style="text-align: left;" align="right"></td>
            <td class="<%=style%>" style="text-align: left;" align="right"></td>
            <td class="<%=style%>" style="text-align: left;" align="right"></td>
            <td class="<%=style%>" style="text-align: left;" align="right"></td>
            <td class="<%=style%>" style="text-align: left;" align="right"></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=isTestedSource %></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString("PERCENT_COMPLETED") %></td>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(valOfWorkDone/100000) %></td>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(tot_amountDY/100000)%></td>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(toBePaid/100000)%></td>
            <%if(mode.equals("comWorks")||mode.equals("cWorks")){ %>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString("compDate")%></td>
            <%} %>
            <%if(mode.equals("comWorks")) {%>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString("DATE_OF_COMM")%></td>
            <%} %>            
            <%
                 String image1 = "select WORK_IMAGE,dbms_lob.getlength(WORK_IMAGE) from rws_work_image_tbl where WORK_ID='" + rs.getString(2) + "'";
                 statement = conn.createStatement();
                 resultSet = statement.executeQuery(image1);
                 if (resultSet.next()) {
                 	int a=resultSet.getInt(2);
                 	   if(a==0){%>
         			  		<td class="<%=style%>" style="text-align: left;" align="right">Image Not Exist</td>
               			<%}else{%>
                      	  <td class="<%=style%>" style="text-align: left;" align="right"><a class="thumbnail" href="#thumb"><img src="./workImage.jsp?workid=<%=rs.getString(2)%>&mode=image1"  width="30px" height="30px" border="0" /><span><img src="./workImage.jsp?workid=<%=rs.getString(2)%>&mode=image1"  width="350px" height="230px"/></span></a></td>
	            <%}} else {%>
	            <td class="<%=style%>" style="text-align: left;" align="right">Image Not Exist</td>
	            <%}
                statement.close();
                resultSet.close();
                String image2 = "select WORK_IMAGE1,dbms_lob.getlength(WORK_IMAGE1) from rws_work_image_tbl where WORK_ID='" + rs.getString(2) + "'";
                statement = conn.createStatement();
                resultSet = statement.executeQuery(image2);
                if (resultSet.next()) {
                	int b=resultSet.getInt(2);
		    		 if(b==0){
		    			 %>
	              		<td class="<%=style%>" style="text-align: left;" align="right">Image Not Exist</td>
	              		<%
		    	     }else{
	             		 %>
                         <td class="<%=style%>" style="text-align: left;" align="right"><a class="thumbnail" href="#thumb"><img src="./workImage.jsp?workid=<%=rs.getString(2)%>&mode=image2"  width="30px" height="30px" border="0" /><span><img src="./workImage.jsp?workid=<%=rs.getString(2)%>&mode=image2"  width="350px" height="230px"/></span></a></td>

            		<%}} else {%>
           		 	<td class="<%=style%>" style="text-align: left;" align="right">Image Not Exist</td>
          		  	<%}
                statement.close();
                resultSet.close();
            %>
             <%} %>
        </tr>
        <%              
        totEstCost+=estCost;
        totCommExpUpyo31+=tot_amountupto31;
        totValueOfWork+=valOfWorkDone;
        totExpDY+=tot_amountDY;
        totToBePaid+=toBePaid;
                }
                stmt.close();
                rs.close();
                %>
                <tr>
                    <td class="btext" style="text-align: right;" colspan=5>Total:</td>
                    <td class="btext" style="text-align: right;"><%=ndf.format(totEstCost)%></td>
                    <td class="btext" style="text-align: right;"><%=ndf.format(totCommExpUpyo31 / 100000)%></td>
                    <td class="btext" style="text-align: right;" colspan=3></td>
                     <%if(!mode.equals("ngWorks")) {%>
                    <td class="btext" style="text-align: right;" colspan=11></td>
                    <td class="btext" style="text-align: right;"><%=ndf.format(totValueOfWork / 100000)%></td>
                    <td class="btext" style="text-align: right;"><%=ndf.format(totExpDY / 100000)%></td>
                    <td class="btext" style="text-align: right;"><%=ndf.format(totToBePaid / 100000)%></td>
                    <td class="btext" style="text-align: right;" colspan=8></td>   
                    <%} %>                
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
        } else {
        %>
        <tr align=center>
            <td class=gridhdbg ><b>SNO</b></td>
            <td class=gridhdbg ><b>District</b></td>
            <td class=gridhdbg ><b>Mandal</b></td>
            <td class=gridhdbg ><b>Panchayat</b></td>
            <td class=gridhdbg ><b>Village</b></td>
            <td class=gridhdbg ><b>Habitation Code</b></td>
            <td class=gridhdbg ><b>Habitation Name</b></td>
            <td class=gridhdbg ><b>Coverage Status</b></td>
            <td class=gridhdbg ><b>Total Population</b></td>
            <%if(mode.equals("cHabs")) {%>
            <td class=gridhdbg ><b>Habitation Covered Works </b></td>
            <%} %>
        </tr>
        <%
            Statement statement = null;
            ResultSet resultSet = null;
            try {
                if (mode.equals("sHabs")) {
                  query = "select  dist.dname,mdl.mname,panch.pname,vill.vname,habs.PANCH_NAME,b.hab_code,SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) as pop,hd.coverage_status "
                             + "from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m, rws_habitation_directory_tbl hd, "
                             + "rws_district_tbl dist, rws_mandal_tbl mdl, rws_panchayat_tbl panch, rws_village_tbl vill, rws_panchayat_raj_tbl habs where hd.hab_code=b.hab_code and "
                             + "WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and "
                             + "TO_DATE(DATE_OF_COMPLETION)<'01-APR-"+yearStart+"') and TO_DATE(TARGET_DATE_COMP)>='01-APR-"+yearStart+"' and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id "
                             + "and m.work_id(+)=a.work_id and a.programme_code in ("+pc+") and a.TYPE_OF_ASSET in ("+schemes+")"
                             + "and a.CORE_DASHBOARD_STATUS='Y' and COVERAGE_STATUS<>'UI' and b.hab_code=habs.PANCH_CODE and dist.dcode=SUBSTR(habs.PANCH_CODE,1,2) and mdl.mcode=SUBSTR(habs.PANCH_CODE,6,2) "
                             + "and panch.pcode=SUBSTR(habs.PANCH_CODE,13,2) and vill.vcode=SUBSTR(habs.PANCH_CODE,8,3) and mdl.dcode=dist.dcode and panch.dcode=mdl.dcode "
                             + "and panch.mcode=mdl.mcode and vill.dcode=panch.dcode and vill.mcode=panch.mcode and vill.pcode=panch.pcode ";
                } else if(mode.equals("cHabs")){
                    query = "select distinct dist.dname,mdl.mname,panch.pname,vill.vname,habs.PANCH_NAME,b.hab_code,SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) as pop,hd.coverage_status "
                           + "from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m, rws_habitation_directory_tbl hd, "
                           + "rws_district_tbl dist, rws_mandal_tbl mdl, rws_panchayat_tbl panch, rws_village_tbl vill, rws_panchayat_raj_tbl habs, rws_work_completion_tbl comp where hd.hab_code=b.hab_code and "
                           + "WORK_CANCEL_DT is null and a.work_id=comp.work_id and ((TO_DATE(comp.DATE_OF_COMPLETION) >= '01-APR-" + yearStart +"' and TO_DATE(comp.DATE_OF_COMPLETION) <= '31-MAR-" + yearEnd +"'  and comp.DATE_OF_COMPLETION is not null) OR (TO_DATE(comp.partial_date_of_completion) >= '01-APR-" + yearStart +"' and TO_DATE(comp.partial_date_of_completion) <= '31-MAR-" + yearEnd +"' and comp.DATE_OF_COMPLETION is null))"
                            + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-"+yearStart+"' and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id "
                           + "and m.work_id(+)=a.work_id and a.programme_code in ("+pc+") and a.TYPE_OF_ASSET in ("+schemes+") and c.GROUNDING_DATE is not null "
                           + "and a.CORE_DASHBOARD_STATUS='Y' and b.hab_code=habs.PANCH_CODE and dist.dcode=SUBSTR(habs.PANCH_CODE,1,2) and mdl.mcode=SUBSTR(habs.PANCH_CODE,6,2) "
                           + "and panch.pcode=SUBSTR(habs.PANCH_CODE,13,2) and vill.vcode=SUBSTR(habs.PANCH_CODE,8,3) and mdl.dcode=dist.dcode and panch.dcode=mdl.dcode "
                           + "and panch.mcode=mdl.mcode and vill.dcode=panch.dcode and vill.mcode=panch.mcode and vill.pcode=panch.pcode ";
                }else {
                    query = "select  dist.dname,mdl.mname,panch.pname,vill.vname,habs.PANCH_NAME,b.hab_code,SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) as pop,hd.coverage_status "
                            + "from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m, rws_habitation_directory_tbl hd, "
                            + "rws_district_tbl dist, rws_mandal_tbl mdl, rws_panchayat_tbl panch, rws_village_tbl vill, rws_panchayat_raj_tbl habs, rws_work_completion_tbl comp where hd.hab_code=b.hab_code and "
                            + "WORK_CANCEL_DT is null and a.work_id=comp.work_id and comp.DATE_OF_COMPLETION is not null and TO_DATE(comp.DATE_OF_COMPLETION) between '01-APR-"+yearStart+"' and '31-MAR-"+yearEnd+"' "
                             + "and TO_DATE(TARGET_DATE_COMP)>='01-APR-"+yearStart+"' and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id "
                            + "and m.work_id(+)=a.work_id and a.programme_code in ("+pc+") and a.TYPE_OF_ASSET in ("+schemes+") and c.GROUNDING_DATE is not null "
                            + "and a.CORE_DASHBOARD_STATUS='Y' and b.hab_code=habs.PANCH_CODE and dist.dcode=SUBSTR(habs.PANCH_CODE,1,2) and mdl.mcode=SUBSTR(habs.PANCH_CODE,6,2) "
                            + "and panch.pcode=SUBSTR(habs.PANCH_CODE,13,2) and vill.vcode=SUBSTR(habs.PANCH_CODE,8,3) and mdl.dcode=dist.dcode and panch.dcode=mdl.dcode "
                            + "and panch.mcode=mdl.mcode and vill.dcode=panch.dcode and vill.mcode=panch.mcode and vill.pcode=panch.pcode ";
                 }
                if(mode1!=null&&!mode1.equals("")&&mode1.equals("wrk"))
                {
                    query+=" and a.work_id='"+request.getParameter("wid")+"'";
                }
                if(coc!=null) {
                    query += " and SUBSTR(a.OFFICE_CODE,2,2)='"+coc+"'";
                }
                if(doc!=null) {
                    query += " and SUBSTR(a.OFFICE_CODE,4,1)='"+doc+"'";
                }
                if(soc!=null) {
                    query += " and SUBSTR(a.OFFICE_CODE,5,2)='"+soc+"'";
                }
                if(spc!=null) {
                    query += " a.subprogramme_code in ("+spc+")";
                }
                query+= " group by dist.dname,mdl.mname,panch.pname,vill.vname,habs.PANCH_NAME,b.hab_code,hd.coverage_status order by dist.dname,mdl.mname,panch.pname,vill.vname,habs.PANCH_NAME";
               
                Statement st = conn.createStatement();
                ResultSet rs1 = st.executeQuery(query);
                while (rs1.next()) {
                	String covWorks="";
                	if(mode.equals("cHabs")) {
                	  String habWorksQry = "";              
                	  habWorksQry = "select distinct a.work_id,a.work_name from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                              + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and "
                              + " a.programme_code in (" + pc + ")  and ((TO_DATE(b.DATE_OF_COMPLETION) >= '01-APR-" + yearStart +"' and TO_DATE(b.DATE_OF_COMPLETION) <= '31-MAR-" + yearEnd +"'  and b.DATE_OF_COMPLETION is not null) OR (TO_DATE(b.partial_date_of_completion) >= '01-APR-" + yearStart +"' and TO_DATE(b.partial_date_of_completion) <= '31-MAR-" + yearEnd +"' and b.DATE_OF_COMPLETION is null)) and "
                              + " TO_DATE(TARGET_DATE_COMP)>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and  a.CORE_DASHBOARD_STATUS='Y' and h.hab_code='"+rs1.getString("hab_code")+"'";
                    //  System.out.println("COMPLTE habs"+habWorksQry);
                      Statement stmt1 = conn.createStatement();
                      ResultSet habWorksRs = stmt1.executeQuery(habWorksQry);
                      while(habWorksRs.next()) {
                    	  if(!covWorks.equals("")){
                    		  covWorks+= ","+habWorksRs.getString("work_id")+"-"+habWorksRs.getString("work_name");
                    	  }else{
                    		  covWorks=habWorksRs.getString("work_id")+"-"+habWorksRs.getString("work_name");
                    	  }                             
                      }
                      stmt1.close();
                      habWorksRs.close();                	
                	}
                	if (styleCount % 2 == 0) {
                        style = "gridbg1";
                    } else {
                        style = "gridbg2";
                    }
                    styleCount++;
                %>
                <tr>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=count++%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString(1)%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString(2)%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString(3)%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString(4)%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString(6)%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString(5)%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString("coverage_status")%></td>
                    <td class="<%=style%>" style="text-align: left;" align="right"><%=rs1.getString("pop")%></td>
                    <%	if(mode.equals("cHabs")) { %>	
                     <td class="<%=style%>" style="text-align: left;" align="right"><%=covWorks%></td>
                     <%} %>
                </tr>
                <%
                    }
                    st.close();
                    rs1.close();
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
            }
        %>
    </table>

</html:html>
