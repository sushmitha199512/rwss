<%@page import="nic.watersoft.works.WorksData1"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" />
<html:html>
    <head>
        <title>Report</title>
        <link rel="stylesheet" type="text/css" href="style.css">
    </head>
   
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
 
    
</style>
    <%  DecimalFormat ndf = new DecimalFormat("####.00");
        String ccode = request.getParameter("ccode");
        String cname = request.getParameter("cname");
        String programme = request.getParameter("programme");
        String programmeName = request.getParameter("programmeName");
        String mode = request.getParameter("mode");
        int count = 1;
        int styleCount = 0;
        String style = "";
        String query = "";
        String year = request.getParameter("year");
        String divcode=request.getParameter("divCode");
        System.out.println("divcode"+divcode);
        String subdivcode=request.getParameter("subdivcode");
        String divname=request.getParameter("divname");
        String subdivname=request.getParameter("subdivname");
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
           %>
    <br/><br/>
        <center>
            <font color="#663899" face="Maiandra GD" size="4px"><b><b>Work Load for <%=ys%>-<%=ye%></b>
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
            Ongoing Works on <%=ys%>-<%=ye%> in Programme :<%=programmeName%>
            <%if(ccode!=null){ %>
            Circle:<%=cname%> 
            <%}else if(divcode!=null ){ %> 
            And Division:<%=divname %><br>
            <%}else if(subdivcode!=null){ %> 
            And SubDivision :<%=subdivname %>
            <%}
            } %>
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
            <td class=gridhdbg ><b>SNO</b></td>
            <td class=gridhdbg ><b>District</b></td>
            <td class=gridhdbg ><b>Mandal</b></td>
            <td class=gridhdbg ><b>Panchayat</b></td>
            <td class=gridhdbg ><b>Village</b></td>
            <td class=gridhdbg ><b>Habitation Code</b></td>
            <td class=gridhdbg ><b>Habitation Name</b></td>

            <td class=gridhdbg ><b>Coverage Status</b></td>
            <td class=gridhdbg ><b>Total Population</b></td>
        </tr>
        <%
            Statement statement = null;
            ResultSet resultSet = null;
            try {


                if (mode.equals("spill")) {
                	query = "select b.hab_code from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m  where WORK_CANCEL_DT is null  "
						+ " and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
						+ programme
						+ ") and substr(a.work_id,7,2) in ('01','02','03') and c.GROUNDING_DATE is not null  and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and a.ADMIN_DATE<to_date('01/04/"+ys+"','dd/mm/yyyy') "
						+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)";
                	if(ccode!=null){
                		query+=" and substr(a.office_code,2,2)='"+ccode+"'";
                	}
                	if(divcode!=null){
                		query+="  and substr(a.office_code,4,1)='"+divcode+"'";
                	}
                	if(subdivcode!=null){
                		query+="  and substr(a.office_code,5,2)='"+subdivcode+"'";
                	}
                	} 
                else  if (mode.equals("new")) {
                	query =  "select b.hab_code from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m  where WORK_CANCEL_DT is null  "
    						+ " and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
    						+ programme
    						+ ") and substr(a.work_id,7,2) in ('01','02','03') and c.GROUNDING_DATE is not null  and a.ADMIN_DATE >=to_date('01/04/"+ys+"','dd/mm/yyyy') and a.ADMIN_DATE<to_date('01/04/"+ys+"','dd/mm/yyyy') "
    						+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)";
                	if(ccode!=null){
                		query+=" and substr(a.office_code,2,2)='"+ccode+"'";
                	}
                	if(divcode!=null){
                		query+="  and substr(a.office_code,4,1)='"+divcode+"'";
                	}
                	if(subdivcode!=null){
                		query+="  and substr(a.office_code,5,2)='"+subdivcode+"'";
                	}
                	}
                else if(mode.equals("ongoing")){ 
                    query =  "select b.hab_code from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m  where WORK_CANCEL_DT is null  "
    						+ " and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
    						+ programme
    						+ ") and substr(a.work_id,7,2) in ('01','02','03') and c.GROUNDING_DATE is not null  and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy')"
    						+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)";
                    if(ccode!=null){
                    	query+=" and substr(a.office_code,2,2)='"+ccode+"'";
                	}
                    if(divcode!=null){
                		query+="  and substr(a.office_code,4,1)='"+divcode+"'";
                	}
                    if(subdivcode!=null){
                		query+="  and substr(a.office_code,5,2)='"+subdivcode+"'";
                	}
                 } 
			System.out.println(query);
                Statement st = conn.createStatement();
                ResultSet rs1 = st.executeQuery(query);
                while (rs1.next()) {

                    String hab_code = rs1.getString(1);
                    String habDetails = "select sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU),COVERAGE_STATUS from rws_habitation_directory_tbl where hab_code='"
                            + hab_code + "' group by COVERAGE_STATUS";
                    statement = conn.createStatement();
                    resultSet = statement.executeQuery(habDetails);
                    int population = 0;
                    String covStatus = "";
                    if (resultSet.next()) {
                        population = resultSet.getInt(1);
                        covStatus = resultSet.getString(2);
                    }
                    resultSet.close();
                    statement.close();
                    if (styleCount % 2 == 0) {
                        style = "gridbg1";
                    } else {
                        style = "gridbg2";
                    }
                    styleCount++;

                    /* String details = "select dname,mname,pname,vname,panch_code,panch_name  from rws_complete_hab_view where panch_code='" + hab_code + "'"; */
                    String details="select dname,mname,pname,vname,panch_name,panch_code from rws_district_tbl a,rws_mandal_tbl b,rws_panchayat_tbl c,rws_village_tbl d,rws_panchayat_raj_tbl e where a.dcode=b.dcode and a.dcode=c.dcode and a.dcode=d.dcode and a.dcode=substr(e.panch_code,1,2) and b.mcode=c.mcode and b.mcode=d.mcode and b.mcode=substr(e.panch_code,6,2) and c.pcode=d.pcode and c.pcode=substr(e.panch_code,13,2) and d.vcode=substr(e.panch_code,8,3) and e.panch_code='"+hab_code+"'";
                    statement = conn.createStatement();
                    resultSet = statement.executeQuery(details);

                    if (resultSet.next()) {
        %>

        <tr>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=count++%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(1)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(2)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(3)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(4)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(5)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=resultSet.getString(6)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=covStatus%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=population%></td>
        </tr>

        <%
                        } else {
                           // System.out.println(hab_code);
                        }
                        statement.close();
                        resultSet.close();
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
        %>
    </table>

</html:html>
