<%@page import="nic.watersoft.works.WorksData1"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<html:html>
 <head>
        <title>Report</title>
        <link rel="stylesheet" type="text/css" href="style.css">

    </head>
    <script language="JavaScript">
        function viewWorks(URL) {

            var popFeatures = "width=900,height=650,toolbar=0,location=0,directories=0,status=1,menuBar=0,scrollBars=1,resizable=1,screenX=10,screenY=10,left=10,top=30";
            if (URL != "") {
                myNewWin = window.open(URL, 'newWinddow', popFeatures);
                myNewWin.focus();
            }
        }

        function wopen(url, name, w, h) {
            // Fudge factors for window decoration space.
            // In my tests these work well on all platforms & browsers.
            w += 32;
            h += 96;
            var win = window.open(url, name, 'width=' + w + ', height=' + h + ', '
                    + 'location=yes, menubar=no, '
                    + 'status=yes, toolbar=no, scrollbars=yes, resizable=yes');

            win.focus();
        }
    </script>
<style type="text/css">
    body, body a {
        font-family: "Verdana", Georgia, Serif !important;
        font-size: 13px !important;
    }
    .btext {
        font-family: "Verdana", Georgia, Serif !important;
        font-size: 12px !important;
    }
    .rightPad td {
        padding-right: 3px !important;
    }
   
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
    <%    DecimalFormat ndf = new DecimalFormat("####.00");
        String ccode = request.getParameter("ccode");
        String cname = request.getParameter("cname");
        String programme = request.getParameter("programme");
        String mode = request.getParameter("mode");
    //    String schemes = "'01','02','03','10'";
        String yearStart=request.getParameter("yearStart");
        String yearEnd=request.getParameter("yearEnd");
        String message=request.getParameter("message");
        int count = 1;
        int styleCount = 0;
        String style = "";
        String query = "";
        String year = request.getParameter("year");
        String divcode=request.getParameter("divcode");
        String subdivcode=request.getParameter("subdivcode");
        String mode1=request.getParameter("mode1");        
        WorksData1 data1 = new WorksData1();
        int cyear = Calendar.getInstance().get(Calendar.YEAR);
        int month = Calendar.getInstance().get(Calendar.MONTH) + 1;
        int lMonth = Calendar.getInstance().get(Calendar.MONTH);
        int day = Calendar.getInstance().get(Calendar.DATE);
        String currentMonth = data1.getCurrentMonth(month);
        // System.out.println("currentMonth"+currentMonth);
        String lastMonth = "";
        if (currentMonth.equals("JAN")) {
            lastMonth = "DEC-" + (cyear - 1);
        } else {
            lastMonth = data1.getCurrentMonth(lMonth) + "-" + cyear;
        }
        String cDate = day + "-" + currentMonth + "-" + cyear;
        String today=day + "-" + month + "-" + cyear;
         int ys = 0;
        int ye = 0;
        if (month <= 3) {
        	ys = cyear - 1;
            ye = cyear;
        } else {
        	ys = cyear;
            ye = cyear + 1;
        } 
        lastMonth = lastMonth.substring(0,1).toUpperCase()+lastMonth.substring(1).toLowerCase();
        currentMonth = currentMonth.substring(0,1).toUpperCase()+currentMonth.substring(1).toLowerCase();
        String schemes="";
        if(request.getParameter("schemes")!=null)
        	schemes=request.getParameter("schemes");
        else
        	schemes="01,02,03,10";
            %>
    <br/><br/>
        <center>
            <font color="#663899" face="Maiandra GD" size="4px"><b>Works Not Grounded - Post Administrative Sanction <br/><br/> <%=message %></b></font>
            <!-- <br/><br/><font color="#889900" face="Maiandra GD" size="3px">(Amount in Lakhs)</font> -->
        </center>
    <br/>
            <table align="center" style="margin-top: -35px !important; width: 1200px !important;  text-align: center !important;">
                <tr>
                    <td style="width: 1000px !important;"></td>
                    <!-- <td style="width: 100px !important;" align="right">
                        <a href="javascript:history.back(-1)"><img src="/pred/resources/graphs/go_back.gif" height="30px"/></a>&nbsp;&nbsp; 
                    </td> -->
                    <td style="width: 100px !important;" align="right">
                        <a href="#" onClick="window.close();"><img src="/pred/resources/graphs/close.png" height="30px"/></a>&nbsp;&nbsp; 
                    </td>
                </tr>
            </table>
     
          <table width="1200px" border=1 style="border-collapse: collapse"
           ALIGN=CENTER>
          <tr align=center>
 			<td class=btext rowspan=2><b>SNO </b></td>
 			<td class=btext rowspan=2 ><b>District</b></td>
              <td class=btext rowspan=2 ><b>Constituency</b></td>
              <td class=btext rowspan=2><b>WorkId</b></td>
              <td class=btext rowspan=2><b>Work Name </b></td>
              <td class=btext rowspan=2><b>Programme </b></td>
              <td class=btext rowspan=2><b>Sub Programme </b></td>
              <td class=btext rowspan=2><b>Sanction Date </b></td>
              <td class=btext rowspan=2><b>Est. Cost (Rs. Lakhs) </b></td>
              <td class=btext rowspan=2><b>No. of<br/>Habs </b></td>
              <td class=btext rowspan=2>Expenditure<br/>Upto<br/> 31-MAR-<%=ys%></td> 
              <td colspan=3 class=btext align="center">Expenditure<br>(<%=ys%>-<%=ye%>)</td>
              <td class=btext rowspan=2><b>Agreement<br/>Date </b></td>
              <td class=btext rowspan=2><b>Stipulated<br/>Date </b></td>
              <%if(!mode.equals("days0")){ %>
              <td class=btext rowspan=2><b>Reason For Delay </b></td>
              <%} %>
              <td class=btext rowspan=2><b>Target<br/>Date </b></td>
              <!-- <td class=btext rowspan=2><b>Completion<br/>Date </b></td> -->
              <td class=btext rowspan=2><b>Image1 </b></td>
              <td class=btext rowspan=2><b>Image2</b></td>
          </tr>
          <tr>
              <td colspan=1 class=btext align="center">Upto LastMonth <br/>(<%=lastMonth%>)</td>
  				<td colspan=1 class=btext align="center">CurrentMonth<br/>(<%=currentMonth%>-<%=cyear%>)</td>
              <td colspan=1 class=btext align="center">Total</td>
          </tr>
          <%
              Statement statement = null;
              ResultSet resultSet = null;
              Statement stmt1 = null;
              ResultSet rs1 = null;
              double estCost = 0, bankLastYear = 0, bankLastMonth = 0, bankCurrentMonth = 0, paoLastYear = 0, paoLastMonth = 0, paoCurrentMonth = 0, expUptoLFY = 0, expUptoLM = 0, expDM = 0, TotExp = 0;
              int totNoOfWorks = 0, totHabsSanctioned = 0, totWorksComp = 0, totHabsCov = 0, totHabs=0;
              double totarfc = 0, totEstCost = 0, totExpUptoLFY = 0, totExpUptoLM = 0, totExpDM = 0, totTotExp = 0;
              try {

                	if(mode.equals("yearsg3")){
                      query = "select distinct SANCTION_AMOUNT,work_id,work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(TARGET_DATE_COMP,'dd/mm/yyyy'),'--') as TARGET_DATE_COMP,PROGRAMME_CODE,SUBPROGRAMME_CODE,nvl(LEAD_HABITATION,'--') as lead_habitation, d.DNAME as dname  from RWS_WORK_ADMN_TBL w, RWS_DISTRICT_TBL d where d.DCODE=SUBSTR(w.work_id,5,2) and work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)"
	  							+" and WORK_CANCEL_DT is null and substr(work_id,7,2) in ("+ schemes+ ") and CORE_DASHBOARD_STATUS='Y' and PROGRAMME_CODE in ("+programme+")"
	  							+" and TARGET_DATE_COMP>='"+ yearStart+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')"
	  							+" and work_id not in "
	  							+"(select a.work_id from RWS_WORK_COMMENCEMENT_TBL b,RWS_WORK_ADMN_TBL a,rws_new_est_tbl e,RWS_CONTRACTOR_SELECTION_TBL c,RWS_SOURCE_IDEN_FIN_TBL s where a.work_id not in "
                           	+"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and b.GROUNDING_DATE is not null " 
                          	+"and WORK_CANCEL_DT is null and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y' and a.work_id=b.work_id and "
                          	+" a.work_id=e.work_id  and c.work_id=a.work_id and a.work_id=s.work_id and a.PROGRAMME_CODE in ("+programme+") and TARGET_DATE_COMP>='"+ yearStart+"' "
                           	+" and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')) and MONTHS_BETWEEN(To_Date('"+cDate+"','DD-MM-YYYY'),admin_date) > 36";
                	}else if(mode.equals("yearsg2")){
                        query = "select distinct SANCTION_AMOUNT,work_id,work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(TARGET_DATE_COMP,'dd/mm/yyyy'),'--') as TARGET_DATE_COMP,PROGRAMME_CODE,SUBPROGRAMME_CODE,nvl(LEAD_HABITATION,'--') as lead_habitation, d.DNAME as dname  from RWS_WORK_ADMN_TBL w, RWS_DISTRICT_TBL d where d.DCODE=SUBSTR(w.work_id,5,2) and work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)"
	  							+" and WORK_CANCEL_DT is null and substr(work_id,7,2) in ("+ schemes+ ") and CORE_DASHBOARD_STATUS='Y' and PROGRAMME_CODE in ("+programme+")"
	  							+" and TARGET_DATE_COMP>='"+ yearStart+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')"
	  							+" and work_id not in "
	  							+"(select a.work_id from RWS_WORK_COMMENCEMENT_TBL b,RWS_WORK_ADMN_TBL a,rws_new_est_tbl e,RWS_CONTRACTOR_SELECTION_TBL c,RWS_SOURCE_IDEN_FIN_TBL s where a.work_id not in "
                           	+"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and b.GROUNDING_DATE is not null " 
                          	+"and WORK_CANCEL_DT is null and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y' and a.work_id=b.work_id and "
                          	+" a.work_id=e.work_id  and c.work_id=a.work_id and a.work_id=s.work_id and a.PROGRAMME_CODE in ("+programme+") and TARGET_DATE_COMP>='"+ yearStart+"' "
                           	+" and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')) and MONTHS_BETWEEN(To_Date('"+cDate+"','DD-MM-YYYY'),admin_date) > 24 and MONTHS_BETWEEN(To_Date('"+cDate+"','DD-MM-YYYY'),admin_date)<=36";
                  	}
                	else if(mode.equals("yearsg1")){
                        query = "select distinct SANCTION_AMOUNT,work_id,work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(TARGET_DATE_COMP,'dd/mm/yyyy'),'--') as TARGET_DATE_COMP,PROGRAMME_CODE,SUBPROGRAMME_CODE,nvl(LEAD_HABITATION,'--') as lead_habitation, d.DNAME as dname  from RWS_WORK_ADMN_TBL w, RWS_DISTRICT_TBL d where d.DCODE=SUBSTR(w.work_id,5,2) and work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)"
	  							+" and WORK_CANCEL_DT is null and substr(work_id,7,2) in ("+ schemes+ ") and CORE_DASHBOARD_STATUS='Y' and PROGRAMME_CODE in ("+programme+")"
	  							+" and TARGET_DATE_COMP>='"+ yearStart+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')"
	  							+" and work_id not in "
	  							+"(select a.work_id from RWS_WORK_COMMENCEMENT_TBL b,RWS_WORK_ADMN_TBL a,rws_new_est_tbl e,RWS_CONTRACTOR_SELECTION_TBL c,RWS_SOURCE_IDEN_FIN_TBL s where a.work_id not in "
	                           	+"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and b.GROUNDING_DATE is not null " 
	                          	+"and WORK_CANCEL_DT is null and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y' and a.work_id=b.work_id and "
	                          	+" a.work_id=e.work_id  and c.work_id=a.work_id and a.work_id=s.work_id and a.PROGRAMME_CODE in ("+programme+") and TARGET_DATE_COMP>='"+ yearStart+"' "
	                           	+" and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')) and MONTHS_BETWEEN(To_Date('"+cDate+"','DD-MM-YYYY'),admin_date) > 12 and MONTHS_BETWEEN(To_Date('"+cDate+"','DD-MM-YYYY'),admin_date)<=24";
                  	}
                	else if(mode.equals("mons6to12")){
                        query = "select distinct SANCTION_AMOUNT,work_id,work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(TARGET_DATE_COMP,'dd/mm/yyyy'),'--') as TARGET_DATE_COMP,PROGRAMME_CODE,SUBPROGRAMME_CODE,nvl(LEAD_HABITATION,'--') as lead_habitation, d.DNAME as dname  from RWS_WORK_ADMN_TBL w, RWS_DISTRICT_TBL d where d.DCODE=SUBSTR(w.work_id,5,2) and work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)"
	  							+" and WORK_CANCEL_DT is null and substr(work_id,7,2) in ("+ schemes+ ") and CORE_DASHBOARD_STATUS='Y' and PROGRAMME_CODE in ("+programme+")"
	  							+" and TARGET_DATE_COMP>='"+ yearStart+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')"
	  							+" and work_id not in "
	  							+"(select a.work_id from RWS_WORK_COMMENCEMENT_TBL b,RWS_WORK_ADMN_TBL a,rws_new_est_tbl e,RWS_CONTRACTOR_SELECTION_TBL c,RWS_SOURCE_IDEN_FIN_TBL s where a.work_id not in "
	                           	+"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and b.GROUNDING_DATE is not null " 
	                          	+"and WORK_CANCEL_DT is null and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y' and a.work_id=b.work_id and "
	                          	+" a.work_id=e.work_id  and c.work_id=a.work_id and a.work_id=s.work_id and a.PROGRAMME_CODE in ("+programme+") and TARGET_DATE_COMP>='"+ yearStart+"' "
	                           	+" and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')) and MONTHS_BETWEEN(To_Date('"+cDate+"','DD-MM-YYYY'),admin_date) > 6 and MONTHS_BETWEEN(To_Date('"+cDate+"','DD-MM-YYYY'),admin_date)<=12";
                  	}
                	else if(mode.equals("mons1to6")){
                        query = "select distinct SANCTION_AMOUNT,work_id,work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(TARGET_DATE_COMP,'dd/mm/yyyy'),'--') as TARGET_DATE_COMP,PROGRAMME_CODE,SUBPROGRAMME_CODE,nvl(LEAD_HABITATION,'--') as lead_habitation, d.DNAME as dname  from RWS_WORK_ADMN_TBL w, RWS_DISTRICT_TBL d where d.DCODE=SUBSTR(w.work_id,5,2) and work_id not in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)"
	  							+" and WORK_CANCEL_DT is null and substr(work_id,7,2) in ("+ schemes+ ") and CORE_DASHBOARD_STATUS='Y' and PROGRAMME_CODE in ("+programme+")"
	  							+" and TARGET_DATE_COMP>='"+ yearStart+"' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')"
	  							+" and work_id not in "
	  							+"(select a.work_id from RWS_WORK_COMMENCEMENT_TBL b,RWS_WORK_ADMN_TBL a,rws_new_est_tbl e,RWS_CONTRACTOR_SELECTION_TBL c,RWS_SOURCE_IDEN_FIN_TBL s where a.work_id not in "
	                           	+"(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and b.GROUNDING_DATE is not null " 
	                          	+"and WORK_CANCEL_DT is null and substr(a.work_id,7,2) in ("+ schemes+ ") and a.CORE_DASHBOARD_STATUS='Y' and a.work_id=b.work_id and "
	                          	+" a.work_id=e.work_id  and c.work_id=a.work_id and a.work_id=s.work_id and a.PROGRAMME_CODE in ("+programme+") and TARGET_DATE_COMP>='"+ yearStart+"' "
	                           	+" and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')) and MONTHS_BETWEEN(To_Date('"+cDate+"','DD-MM-YYYY'),admin_date) >= 0 and MONTHS_BETWEEN(To_Date('"+cDate+"','DD-MM-YYYY'),admin_date)<=6";
                  	}                	
                     if(ccode!=null){
                  		query+=" and substr(office_code,2,2)='"+ccode+"'";
                  	}
                  	if(divcode!=null){
                  		query+="  and substr(office_code,4,1)='"+divcode+"'";
                  	}
                  	if(subdivcode!=null){
                  		query+="  and substr(office_code,5,2)='"+subdivcode+"'";
                  	}
                  	query+=" order by d.DNAME";
                 	//System.out.println("IN Drill"+query);
                  stmt = conn.createStatement();
                  rs = stmt.executeQuery(query);
                  while (rs.next()) {              	       	  
                	  
                     String compDate = "";
                      estCost = rs.getDouble(1);
                      String workid = rs.getString(2);
                      String prog_name="",subprog_name="";
                      String prog_qry = "select a.PROGRAMME_NAME,b.SUBPROGRAMME_NAME from Rws_Programme_Tbl a,Rws_Subprogramme_Tbl b where a.PROGRAMME_CODE=b.PROGRAMME_CODE and a.PROGRAMME_CODE='"+rs.getString("PROGRAMME_CODE")+"' and b.SUBPROGRAMME_CODE='"+rs.getString("SUBPROGRAMME_CODE")+"'" ;
                      statement = conn.createStatement();
                      resultSet = statement.executeQuery(prog_qry);
                      if (resultSet.next()) {
                    	  prog_name = resultSet.getString(1);
                    	  subprog_name=resultSet.getString(2);
                      } else {
                    	  prog_name = "--";
                    	  subprog_name="--";
                      }
                      statement.close();
                      resultSet.close();
                      String workCompletion = "select to_char(DATE_OF_COMPLETION,'dd/mm/yyyy') from rws_work_completion_tbl where work_id='"
                              + rs.getString(2)
                              + "' and DATE_OF_COMPLETION is not null";
                      statement = conn.createStatement();
                      resultSet = statement.executeQuery(workCompletion);
                      if (resultSet.next()) {
                          compDate = resultSet.getString(1);
                      } else {
                          compDate = "--";
                      }
                      statement.close();
                      resultSet.close();
                      int noofHabs = 0;
                      String habs = "select count(distinct hab_code) from RWS_ADMN_HAB_LNK_TBL where work_id='"
                                  + rs.getString(2) + "'";
                     
                      statement = conn.createStatement();
                      resultSet = statement.executeQuery(habs);
                      if (resultSet.next()) {
                          noofHabs = resultSet.getInt(1);
                      } else {
                          noofHabs = 0;
                      }
                      statement.close();
                      resultSet.close();
                      String stipDateComp=""; String agreementDate="";
                      int phyPer=0;
                      String stipCompletion = "select nvl(to_char(DATE_OF_COMPLETION,'dd/mm/yyyy'),'--'),PERCENT_COMPLETED,nvl(to_char(AGREEMENT_DATE,'dd/mm/yyyy'),'--')  from RWS_CONTRACTOR_SELECTION_TBL where work_id='" + rs.getString(2) + "' ";
                      statement = conn.createStatement();
                      resultSet = statement.executeQuery(stipCompletion);
                      if (resultSet.next()) {
                    	  if(resultSet.getString(1)!=null&& !resultSet.getString(1).equals("") )
                      		stipDateComp = resultSet.getString(1);
                    	  else
                    		stipDateComp = "--";
                      	phyPer=resultSet.getInt(2);
                      	if(resultSet.getString(3)!=null&& !resultSet.getString(3).equals("") )
                      		agreementDate=resultSet.getString(3);
                    	  else
                    		  agreementDate = "--";
                      }
                      statement.close();
                      resultSet.close();
                      String reason = "--";
                      if(!mode.equals("days0")){
	                     
	                      String resonQry = "select b.DELAY_REASON_NAME From RWS_WORK_ADMN_TBL a,RWS_WORK_DELAY_REASONS b where a.REASON_FOR_NOT_GROUNDING=b.DELAY_REASON_CODE and a.WORK_ID='"
	                                  + rs.getString(2) + "'";
	                     
	                      statement = conn.createStatement();
	                      resultSet = statement.executeQuery(resonQry);
	                      if (resultSet.next()) {
	                    	  reason = resultSet.getString(1);
	                      } 
	                      statement.close();
	                      resultSet.close();
                      }
                      
                      String leadHab=rs.getString("lead_habitation");
	                  String constName="";
	                  if(leadHab != null && !leadHab.equals("--")){
	                  String constQuery="select constituency_name from rws_constituency_tbl where dcode='"+leadHab.substring(0,2)+"' and mcode='"+leadHab.substring(5,7)+"'";
	                  statement = conn.createStatement();
	                  resultSet = statement.executeQuery(constQuery);	                 
	                  if (!resultSet.next()) {
	                	  constName="-";
	                  }
	                  else{
	                	  constName = resultSet.getString(1);
	                  }	 
	                  statement.close();
	                  resultSet.close();
	                  }
	                  else{
	                	  constName="-";
	                  }	
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
              <td class="<%=style%>" style="text-align: right;" align="right"><%=rs.getString(2)%></td>
              <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString(3)%></td>
              <td class="<%=style%>" style="text-align: left;" align="right"><%=prog_name%></td>
              <td class="<%=style%>" style="text-align: left;" align="right"><%=subprog_name%></td>
             <%--  <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString(6)%></td> --%>
              <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString(4)%></td>
              <td class="<%=style%>" style="text-align: right;" align="right"><%=rs.getString(1)%></td>
              <td class="<%=style%>" style="text-align: left;" align="right"><%=noofHabs%></td>
              
              <%
                  String bankLFY = "select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL where work_id='"
                          + workid
                          + "' and BANK_SEND_DATE<'"+yearStart+"'";

                  stmt1 = conn.createStatement();
                  rs1 = stmt1.executeQuery(bankLFY);
                 //System.out.println("bankLFY"+bankLFY);
                  if (rs1.next()) {
                      bankLastYear = rs1.getDouble(1);

                  }
                  stmt1.close();
                  rs1.close();

                  String paoFLY = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL where work_id='"
                          + workid
                          + "' and STATE_SEND_DATE<'"+yearStart+"'";
                  stmt1 = conn.createStatement();
                  rs1 = stmt1.executeQuery(paoFLY);
                 // System.out.println("paoFLY"+paoFLY);
                  if (rs1.next()) {
                      paoLastYear = rs1.getDouble(1);

                  }
                  stmt1.close();
                  rs1.close();
  				//double lastyear=bankLastYear + paoLastYear;
                  String finalamount = ndf
                          .format((bankLastYear + paoLastYear) / 100000);
              %>
              <td class="<%=style%>" style="text-align: right;" align="right"><%=finalamount%></td> 

              <%
                  String bankUptoLastMonth = "select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL where work_id='"
                          + workid
                          + "' and BANK_SEND_DATE>='"+ yearStart+ "' and BANK_SEND_DATE<'01-"
                          + currentMonth + "-" + cyear + "'";
                  stmt1 = conn.createStatement();
                  rs1 = stmt1.executeQuery(bankUptoLastMonth);
                  
                  if (rs1.next()) {
                      bankLastMonth = rs1.getDouble(1);

                  }
                  stmt1.close();
                  rs1.close();

                  String paoUptoLastMonth = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL where work_id='"
                          + workid
                          + "' and STATE_SEND_DATE>='"+ yearStart+ "' and STATE_SEND_DATE<'01-"
                          + currentMonth + "-" + cyear + "'";

                  stmt1 = conn.createStatement();
                  rs1 = stmt1.executeQuery(paoUptoLastMonth);
                  if (rs1.next()) {
                      paoLastMonth = rs1.getDouble(1);

                  }
                  stmt1.close();
                  rs1.close();
                  String finalamountUptoLastMonth = ndf
                          .format((bankLastMonth + paoLastMonth) / 100000);
              %>
              <td class="<%=style%>" style="text-align: right;" align="right"><%=finalamountUptoLastMonth%></td>
              <%
                  String bankcurrMonth = "select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL where work_id='"
                          + workid
                          + "' and BANK_SEND_DATE>='01-"
                          + currentMonth
                          + "-"
                          + cyear
                          + "' and BANK_SEND_DATE<='" + cDate + "'";

                  stmt1 = conn.createStatement();
                  rs1 = stmt1.executeQuery(bankcurrMonth);
                  
                  if (rs1.next()) {
                      bankCurrentMonth = rs1.getDouble(1);

                  }
                  stmt1.close();
                  rs1.close();

                  String paocurrMonth = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL  where work_id='"
                          + workid
                          + "' and STATE_SEND_DATE>='01-"
                          + currentMonth
                          + "-"
                          + cyear
                          + "' and STATE_SEND_DATE<='" + cDate + "'";
                  stmt1 = conn.createStatement();
                  rs1 = stmt1.executeQuery(paocurrMonth);
                 
                  if (rs1.next()) {
                      paoCurrentMonth = rs1.getDouble(1);

                  }
                  stmt1.close();
                  rs1.close();
                  String finalamountCurrentMonth = ndf
                          .format((bankCurrentMonth + paoCurrentMonth) / 100000);
                  String finalTotalFY = ndf
                          .format((bankLastMonth + paoLastMonth
                                  + bankCurrentMonth + paoCurrentMonth) / 100000);
                  double cexp = ((bankLastYear + paoLastYear
                          + bankLastMonth + paoLastMonth
                          + bankCurrentMonth + paoCurrentMonth) / 100000);
                  double arfc = estCost - cexp;
              %>
              <td class="<%=style%>" style="text-align: right;" align="right"><%=finalamountCurrentMonth%></td>
              <td class="<%=style%>" style="text-align: right;" align="right"><%=finalTotalFY%></td>
           	  <td class="<%=style%>" style="text-align: right;" align="right"><%=agreementDate%></td>
              <td class="<%=style%>" style="text-align: right;" align="right"><%=stipDateComp%></td>
              <%if(!mode.equals("days0")){ %>
              <td class="<%=style%>" style="text-align: right;" align="right"><%=reason%></td>
              <%} %>
              <td class="<%=style%>" style="text-align: right;" align="right"><%=rs.getString("TARGET_DATE_COMP")%></td>
              <%-- <td class="<%=style%>" style="text-align: left;" align="right"><%=compDate%></td> --%>

              <%
                  String image1 = "select WORK_IMAGE,dbms_lob.getlength(WORK_IMAGE) from rws_work_image_tbl where WORK_ID='"
                          + rs.getString(2) + "'";
                  statement = conn.createStatement();
                  resultSet = statement.executeQuery(image1);

                  if (resultSet.next()) {
                	  int a=resultSet.getInt(2);
                  	   if(a==0){
   				    	%>
          			  		<td class="<%=style%>" style="text-align: left;" align="right">Image Not Exist</td>
                			<%}else{
                			         %>
              <td class="<%=style%>" style="text-align: left;" align="right"><a class="thumbnail" href="#thumb"><img src="./workImage.jsp?workid=<%=rs.getString(2)%>&mode=image1"  width="30px" height="30px" border="0" /><span><img src="./workImage.jsp?workid=<%=rs.getString(2)%>&mode=image1"  width="350px" height="230px"/></span></a></td>
              <%-- <td class="<%=style%>" style="text-align: left;" align="right"><a
                      href="#"
                      onclick="viewWorks('works/rws_Work_Image_view.jsp?workid=<%=rs.getString(2)%>&mode=image1')">View</a></td> --%>
              <%
              }} else {
              %>
              <td class="<%=style%>" style="text-align: left;" align="right">Image Not Exist</td>
                  <%
                      }
                      statement.close();
                      resultSet.close();

                      String image2 = "select WORK_IMAGE1,dbms_lob.getlength(WORK_IMAGE1) from rws_work_image_tbl where WORK_ID='"
                              + rs.getString(2) + "'";
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
              <%-- <td class="<%=style%>" style="text-align: left;" align="right"><a
                      href="#"
                      onclick="viewWorks('works/rws_Work_Image_view.jsp?workid=<%=rs.getString(2)%>&mode=image2')">View</a></td> --%>
                   <%
              } }else {
              %>
              <td class="<%=style%>" style="text-align: left;" align="right">Image
                  Not Exist</td>
                  <%
                      }
                      statement.close();
                      resultSet.close();
                      totEstCost = totEstCost + estCost;
                      totExpUptoLFY = totExpUptoLFY + bankLastYear + paoLastYear;
                      totExpUptoLM = totExpUptoLM + bankLastMonth + paoLastMonth;
                      totExpDM = totExpDM + bankCurrentMonth+ paoCurrentMonth;
                      totTotExp = totExpUptoLM + totExpDM;
                      totarfc = totarfc + arfc;
                      totHabs+=noofHabs;
                  %>
          </tr>
          <%
              }
              stmt.close();
              rs.close();
          %>
          <tr>
              <td class="btext" style="text-align: right;" colspan=6>Total:</td>
              <td class="btext" style="text-align: right;"><%=ndf.format(totEstCost)%></td>
              <td class="btext" style="text-align: right;"><%=totHabs %></td>
               <td class="btext" style="text-align: right;"><%=ndf.format(totExpUptoLFY / 100000)%></td> 
              <td class="btext" style="text-align: right;"><%=ndf.format(totExpUptoLM / 100000)%></td>
              <td class="btext" style="text-align: right;"><%=ndf.format(totExpDM / 100000)%></td>
              <td class="btext" style="text-align: right;"><%=ndf.format(totTotExp / 100000)%></td>
              <td class="btext" style="text-align: right;"></td>
              <td class="btext" style="text-align: right;"></td>
              <td class="btext" style="text-align: right;"></td>
              <td class="btext" style="text-align: right;"></td>
              <td class="btext" style="text-align: right;"></td>
              <td class="btext" style="text-align: right;"></td>
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
<br/>
        <table height="20px" align="center">
            <tr height="1%">
                <td align="center" valign="bottom" style="font-family:verdana;font-size:8pt;font-weight:bold;width:100%;color:#6600CC;">
                    Source: <a href="http://rwss.ap.nic.in" target="_blank">WaterSoft</a>, Designed & Developed by <a href="http://www.nic.in" target="_blank">National Informatics Centre</a>, AP State Centre
                </td>
            </tr>
        </table>
<br/>
</html:html>
