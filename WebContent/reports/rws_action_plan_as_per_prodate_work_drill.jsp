<%@page import="nic.watersoft.works.WorksData1"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" />
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
    <%  
    	DecimalFormat ndf = new DecimalFormat("####.00");
        String ccode = request.getParameter("ccode");
        String cname = request.getParameter("cname");
        String programme = request.getParameter("programme");
        String programmeName = request.getParameter("programmeName");
        String subProgramme = request.getParameter("subprogramme");
        String subProgrammeName = request.getParameter("subprogrammeName");
        String MonthCode = request.getParameter("monthCode");
        String mode = request.getParameter("mode");
        int count = 1;
        int styleCount = 0;
        String style = "";
        String query = "";
        String year = request.getParameter("year");
        String divcode=request.getParameter("divCode");
       // System.out.println("divcode"+divcode);
        String subdivcode=request.getParameter("subdivcode");
        String divname=request.getParameter("divname");
        String subdivname=request.getParameter("subdivname");
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
        %>
    <br/><br/>
        <center>
            <font color="#663899" face="Maiandra GD" size="4px"><b>
            <br/>
            <%if(mode.equals("spill")){ %>
            Spill Over works as on  01.04.<%=ys%> in Programme :<%=programmeName%> <br>
            <%if(ccode!=null ){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("new")){ %>
            Newly Sanctioned Works on <%=ys%>-<%=ye%> in Programme :<%=programmeName%>
            <%if(ccode!=null ){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null ){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("ongoing")){ %>
            Ongoing Works on <%=ys%>-<%=ye%> in Programme :<%=programmeName%> and Sub ProProgramme :<%=subProgrammeName%>  
		   <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null ){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("financial")){ %>
            Financially Not Completed Works as on <%=cDate %> in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("target")){ %>
            target Works   <%=ys%>-<%=ye%>  in Programme :<%=programmeName%> and Sub ProProgramme :<%=subProgrammeName%>  
		    and Month : <%if(MonthCode != null && MonthCode.equals("01")){%> January  <%}else if(MonthCode != null && MonthCode.equals("02")){%> February <%}else if(MonthCode != null && MonthCode.equals("03")){%> March <%}else if(MonthCode != null && MonthCode.equals("04")){%> April <%}else if(MonthCode != null && MonthCode.equals("05")){%> May <%}else if(MonthCode != null && MonthCode.equals("06")){%> June <%}else if(MonthCode != null && MonthCode.equals("07")){%> July <%}else if(MonthCode != null && MonthCode.equals("08")){%> August <%}else if(MonthCode != null && MonthCode.equals("09")){%> September  <%}else if(MonthCode != null && MonthCode.equals("10")){%> October <%}else if(MonthCode != null && MonthCode.equals("11")){%> November  <%}else if(MonthCode != null && MonthCode.equals("12")){%> December  <%}%>              
		    <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("achieve")){ %>
            Achievements during <%=ys%>-<%=ye%> in Programme :<%=programmeName%>  and Sub ProProgramme :<%=subProgrammeName%>  
            and Month : <%if(MonthCode != null && MonthCode.equals("01")){%> January  <%}else if(MonthCode != null && MonthCode.equals("02")){%> February <%}else if(MonthCode != null && MonthCode.equals("03")){%> March <%}else if(MonthCode != null && MonthCode.equals("04")){%> April <%}else if(MonthCode != null && MonthCode.equals("05")){%> May <%}else if(MonthCode != null && MonthCode.equals("06")){%> June <%}else if(MonthCode != null && MonthCode.equals("07")){%> July <%}else if(MonthCode != null && MonthCode.equals("08")){%> August <%}else if(MonthCode != null && MonthCode.equals("09")){%> September  <%}else if(MonthCode != null && MonthCode.equals("10")){%> October <%}else if(MonthCode != null && MonthCode.equals("11")){%> November  <%}else if(MonthCode != null && MonthCode.equals("12")){%> December  <%}%>              
		    <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("completed")){ %>
            Completed Works During <%=ys%>-<%=ye%> in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("total")){ %>
            Total Works During <%=ys%>-<%=ye%> in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }else if(mode.equals("targeted")){ %>
            Target works During <%=ys%>-<%=ye%> in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            }   %>
            <br/> </b></font>
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
              <td class=btext rowspan=2><b>WorkId</b></td>
              <td class=btext rowspan=2><b>Work Name </b></td>
              <td class=btext rowspan=2><b>Sanction Date </b></td>
              <td class=btext rowspan=2><b>Est. Cost (Rs. Lakhs) </b></td>
              <td class=btext rowspan=2><b>No. of<br/>Habs </b></td>
              <td class=btext rowspan=2>Expenditure<br/>Upto<br/> 31-MAR-<%=ys%></td> 
              <td colspan=3 class=btext align="center">Expenditure<br>(<%=ys%>-<%=ye%>)</td>
              <td class=btext rowspan=2><b>Target<br/>Date </b></td>
              <td class=btext rowspan=2><b>Completion<br/>Date </b></td>
              <td class=btext rowspan=2><b>Image1 </b></td>
              <td class=btext rowspan=2><b>Image2</b></td>
          </tr>
          <tr>
              <td colspan=1 class=btext align="center">Upto LastMonth <br/>(<%=lastMonth%>)</td>
  				<td colspan=1 class=btext align="center">CurrentMonth<br/>(<%=currentMonth%>-<%=cyear%>)</td>
              <td colspan=1 class=btext align="center">Total</td>
          </tr>
          <%
          String schemes = "'01','02','03','10'";
              Statement statement = null;
              ResultSet resultSet = null;
              Statement stmt1 = null;
              ResultSet rs1 = null;
              double estCost = 0, bankLastYear = 0, bankLastMonth = 0, bankCurrentMonth = 0, paoLastYear = 0, paoLastMonth = 0, paoCurrentMonth = 0, expUptoLFY = 0, expUptoLM = 0, expDM = 0, TotExp = 0;
              int totNoOfWorks = 0, totHabsSanctioned = 0, totWorksComp = 0, totHabsCov = 0, totHabs=0;
              double totarfc = 0, totEstCost = 0, totExpUptoLFY = 0, totExpUptoLM = 0, totExpDM = 0, totTotExp = 0;

              try {
            	  if(mode.equals("spill")){ 
            		 query= "select distinct a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(TARGET_DATE_COMP,'dd/mm/yyyy'),'--') as TARGET_DATE_COMP from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
            					+ " and substr(a.work_id,7,2)  in ("+schemes+") "
            					+ " and a.ADMIN_DATE<to_date('01/04/"+ys+"','dd/mm/yyyy') "
            					+ " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
            					+ programme
            					+ ") AND TARGET_DATE_COMP>='01-APR-"
       							+ ys
       							+ "'  and  a.CORE_DASHBOARD_STATUS='Y' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-"+ys+"') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  ";
                  }else if(mode.equals("new")){ 
                	  query = "select distinct a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(TARGET_DATE_COMP,'dd/mm/yyyy'),'--') as TARGET_DATE_COMP from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
              				+ " and substr(a.work_id,7,2)  in ("+schemes+") "
              				+ " and a.ADMIN_DATE >=to_date('01/04/"+ys+"','dd/mm/yyyy') "
              				+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
              				+  programme
            				+ ") AND TARGET_DATE_COMP>='01-APR-"
   							+ ys
   							+ "'  and  a.CORE_DASHBOARD_STATUS='Y' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and  i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  ";
                  }else if(mode.equals("ongoing")){ 
                	  query = "select distinct a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(TARGET_DATE_COMP,'dd/mm/yyyy'),'--') as TARGET_DATE_COMP from rws_work_admn_tbl a,rws_programme_tbl p, RWS_SUBPROGRAMME_TBL sp,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
                			  +" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
								+ programme
								+ ") and a.SUBPROGRAMME_CODE=sp.SUBPROGRAMME_CODE and a.SUBPROGRAMME_CODE in ("
								+ subProgramme
								+ ")and a.CORE_DASHBOARD_STATUS='Y' AND TARGET_DATE_COMP>='01-APR-2018' and (TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-2018') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id ";						
                  }else if(mode.equals("financial")){ 
                	  query="select distinct a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(TARGET_DATE_COMP,'dd/mm/yyyy'),'--') as TARGET_DATE_COMP  from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
      						+ " and substr(a.work_id,7,2) in ("+schemes+") "
      						+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
      						+ programme
      						+ ") AND TARGET_DATE_COMP>='01-APR-"
   							+ ys
   							+ "'  and  a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id in (select work_id from rws_work_completion_tbl where (to_date(DATE_OF_COMPLETION) < '"+cDate+"') and DATE_OF_COMPLETION is not null and DT_FIN_COMPLETION is null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  ";
                  } else if(mode.equals("target")){ 
                	  query="select distinct a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(TARGET_DATE_COMP,'dd/mm/yyyy'),'--') as TARGET_DATE_COMP  from rws_work_admn_tbl a,rws_programme_tbl p, RWS_SUBPROGRAMME_TBL sp,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
      						+ " and substr(a.work_id,7,2) in ("+schemes+") "
      						+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
      						+ programme
      						+ ") and a.SUBPROGRAMME_CODE=sp.SUBPROGRAMME_CODE and a.SUBPROGRAMME_CODE in ("
							+ subProgramme
      						+ ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and to_char(a.TARGET_DATE_COMP,'MM')='"
      						+MonthCode
      						+ "' and a.CORE_DASHBOARD_STATUS='Y' and TARGET_DATE_COMP is not null and TARGET_DATE_COMP>=to_date('01/04/"+ys+"','dd/mm/yyyy') and TARGET_DATE_COMP<to_date('01/04/"+ye+"','dd/mm/yyyy')";
                  } 
                  else if(mode.equals("achieve")){ 
                	  query="select distinct a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(TARGET_DATE_COMP,'dd/mm/yyyy'),'--') as TARGET_DATE_COMP  from RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd,rws_work_admn_tbl a,rws_programme_tbl p, RWS_SUBPROGRAMME_TBL sp,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
      						+ " and substr(a.work_id,7,2) in ("+schemes+") "
      						+" and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
      						+ programme
      						+ ") and a.SUBPROGRAMME_CODE=sp.SUBPROGRAMME_CODE and a.SUBPROGRAMME_CODE in ("
							+ subProgramme
      						+ ") and h.work_id=a.work_id and hd.hab_code=h.hab_code AND TARGET_DATE_COMP>='01-APR-"
   							+ ys
   							+ "' and  a.CORE_DASHBOARD_STATUS='Y' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and a.work_id in (select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION>=to_date('01/04/"+ys+"','dd/mm/yyyy') and DATE_OF_COMPLETION is not null  AND DATE_OF_COMPLETION <= TARGET_DATE_COMP and to_char(DATE_OF_COMPLETION,'MM')='"
   		      				+MonthCode+ "') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id ";
                  } 
                  else if(mode.equals("total")){ 
                	  query="select distinct a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(TARGET_DATE_COMP,'dd/mm/yyyy'),'--') as TARGET_DATE_COMP from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_contractor_selection_tbl m "
  							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and a.PROGRAMME_CODE=p.PROGRAMME_CODE and "
  							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'01-APR-"+ys+"') and TARGET_DATE_COMP>='01-APR-"+ys+"' and "
  							+"( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y'";
                  } 
                  else if(mode.equals("targeted")){ 
                	  query="select distinct a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(TARGET_DATE_COMP,'dd/mm/yyyy'),'--') as TARGET_DATE_COMP from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_contractor_selection_tbl m "
  							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and a.PROGRAMME_CODE=p.PROGRAMME_CODE and "
  							+"a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION<'"+cDate+"') and TARGET_DATE_COMP between '01-APR-"+ys+"' and "
  							+" '31-MAR-"+ye+"' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y'";
                  } 
                  else if(mode.equals("completed")){ 
                	  query="select distinct a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(TARGET_DATE_COMP,'dd/mm/yyyy'),'--') as TARGET_DATE_COMP from RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd,rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c,rws_contractor_selection_tbl m "
  							+"where  WORK_CANCEL_DT is null and a.programme_code in ("+programme+") and SUBSTR(a.work_id,7,2) in ("+ schemes +")  and a.PROGRAMME_CODE=p.PROGRAMME_CODE and "
  							+"a.work_id  in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null  and  DATE_OF_COMPLETION>='01-APR-"+ys+"') and h.work_id=a.work_id and hd.hab_code=h.hab_code and TARGET_DATE_COMP > '01-APR-"+ys+"' and "
  							+" ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '') and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and  a.CORE_DASHBOARD_STATUS='Y'";
                  }
            	     if(ccode!=null){
                  		query+=" and substr(a.office_code,2,2)='"+ccode+"'";
                  	}
                  	if(divcode!=null){
                  		query+="  and substr(a.office_code,4,1)='"+divcode+"'";
                  	}
                  	if(subdivcode!=null){
                  		query+="  and substr(a.office_code,5,2)='"+subdivcode+"'";
                  	}                   
                 	//System.out.println(query);
                  stmt = conn.createStatement();
                  rs = stmt.executeQuery(query);
                  while (rs.next()) {
                     String compDate = "";
                      estCost = rs.getDouble(1);
                      String workid = rs.getString(2);
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
                      String habs;
                      if(mode.equals("financial")||mode.equals("completed")||mode.equals("achieve")){ 
                    habs = "select count(distinct h.hab_code) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_habitation_directory_tbl hd where h.work_id='"
                                  + rs.getString(2) + "' and h.hab_code=hd.hab_code and COVERAGE_STATUS in ('FC','PC1','PC2','PC3','PC4','NC','NSS')";
                      }else{
                    	  habs = "select count(distinct h.hab_code) from RWS_ADMN_HAB_LNK_TBL h,rws_habitation_directory_tbl hd where h.work_id='"
                                  + rs.getString(2) + "' and h.hab_code=hd.hab_code and COVERAGE_STATUS in ('FC','PC1','PC2','PC3','PC4','NC','NSS')";
                      }
                      statement = conn.createStatement();
                      resultSet = statement.executeQuery(habs);
                      if (resultSet.next()) {
                          noofHabs = resultSet.getInt(1);
                      } else {
                          noofHabs = 0;
                      }
                      statement.close();
                      resultSet.close();
                      if (styleCount % 2 == 0) {
                          style = "gridbg1";
                      } else {
                          style = "gridbg2";
                      }
                      styleCount++;                    

                      
          %>

          <tr>
              <td class="<%=style%>" style="text-align: right;"><%=count++%></td>
              <td class="<%=style%>" style="text-align: right;" ><%=rs.getString(2)%></td>
              <td class="<%=style%>" style="text-align: left;" ><%=rs.getString(3)%></td>
             <%--  <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString(6)%></td> --%>
              <td class="<%=style%>" style="text-align: left;" ><%=rs.getString(4)%></td>
              <td class="<%=style%>" style="text-align: right;"><%=rs.getString(1)%></td>
              <td class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('./work_load_habs_drill.jsp?mode=<%=mode%>&programme=<%=programme%>&programmeName=<%=programmeName%>&workid=<%=rs.getString(2)%>')"><%=noofHabs%></a></td>
            
              <%
                  String bankLFY = "select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL where work_id='"
                          + workid
                          + "' and BANK_SEND_DATE<='31-MAR-" + ys + "'";
                  stmt1 = conn.createStatement();
                  rs1 = stmt1.executeQuery(bankLFY);
                // System.out.println("bankLFY"+bankLFY);
                  if (rs1.next()) {
                      bankLastYear = rs1.getDouble(1);
                  }
                  stmt1.close();
                  rs1.close();

                  String paoFLY = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL where work_id='"
                          + workid
                          + "' and STATE_SEND_DATE<='31-MAR-" + ys + "' ";
                  stmt1 = conn.createStatement();
                  rs1 = stmt1.executeQuery(paoFLY);
                //System.out.println("paoFLY"+paoFLY);
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
                          + "' and BANK_SEND_DATE>='01-APR-"+ ys+ "' and BANK_SEND_DATE<'01-"+ currentMonth + "-" + cyear + "'";
                  stmt1 = conn.createStatement();
                  rs1 = stmt1.executeQuery(bankUptoLastMonth);
                  
                  if (rs1.next()) {
                      bankLastMonth = rs1.getDouble(1);

                  }
                  stmt1.close();
                  rs1.close();

                  String paoUptoLastMonth = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL where work_id='"
                          + workid
                          + "' and STATE_SEND_DATE>='01-APR-"+ ys+ "' and STATE_SEND_DATE<'01-" + currentMonth + "-" + cyear + "'";

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
                          + "' and BANK_SEND_DATE>='01-"+ currentMonth + "-" + cyear
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
             <td class="<%=style%>" style="text-align: right;" align="right"><%=rs.getString("TARGET_DATE_COMP")%></td>
              <td class="<%=style%>" style="text-align: left;" align="right"><%=compDate%></td>

              <%
                  String image1 = "select WORK_IMAGE,dbms_lob.getlength(WORK_IMAGE) from rws_work_image_tbl where WORK_ID='"
                          + rs.getString(2) + "'";
                  statement = conn.createStatement();
                  resultSet = statement.executeQuery(image1);

                  if (resultSet.next()) {
                	  int b=resultSet.getInt(2);
			    		 if(b==0){
			    			 %>
		              		<td class="<%=style%>" style="text-align: left;" align="right">Image Not Exist</td>
		              		<%
			    	     }else{
		             		 %>
		              		<td class="<%=style%>" style="text-align: left;" align="right"><a class="thumbnail" href="#thumb"><img src="./workImage.jsp?workid=<%=workid%>&mode=image1"  width="30px" height="30px" border="0" /><span><img src="./workImage.jsp?workid=<%=workid%>&mode=image1"  width="350px" height="230px"/></span></a></td>
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
                    	  int a=resultSet.getInt(2);
                   	   if(a==0){
    				    	%>
           			  		<td class="<%=style%>" style="text-align: left;" align="right">Image Not Exist</td>
                 			<%}else{
                 			%>
             					<td class="<%=style%>" style="text-align: left;" align="right"><a class="thumbnail" href="#thumb"><img src="./workImage.jsp?workid=<%=workid%>&mode=image2"  width="30px" height="30px" border="0" /><span><img src="./workImage.jsp?workid=<%=workid%>&mode=image2"  width="350px" height="230px"/></span></a></td>
		             		<%
             			} }else {
             			  	%>
           			  	<td class="<%=style%>" style="text-align: left;" align="right">Image Not Exist</td>
                 			<%
                 		}
                  			
                      statement.close();
                      resultSet.close();
                      totEstCost = totEstCost + estCost;
                      totExpUptoLFY = totExpUptoLFY + bankLastYear
                              + paoLastYear;
                      totExpUptoLM = totExpUptoLM + bankLastMonth
                              + paoLastMonth;
                      totExpDM = totExpDM + bankCurrentMonth
                              + paoCurrentMonth;
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
              <td class="btext" style="text-align: right;" colspan=4>Total:</td>
              <td class="btext" style="text-align: right;"><%=ndf.format(totEstCost)%></td>
              <td class="btext" style="text-align: right;"><%=totHabs %></td>
               <td class="btext" style="text-align: right;"><%=ndf.format(totExpUptoLFY / 100000)%></td> 
              <td class="btext" style="text-align: right;"><%=ndf.format(totExpUptoLM / 100000)%></td>
              <td class="btext" style="text-align: right;"><%=ndf.format(totExpDM / 100000)%></td>
              <td class="btext" style="text-align: right;"><%=ndf.format(totTotExp / 100000)%></td>
              <td class="btext" style="text-align: right;" colspan=4></td>
             
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
