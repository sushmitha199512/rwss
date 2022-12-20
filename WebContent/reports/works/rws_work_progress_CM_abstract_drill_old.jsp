
<%@page import="nic.watersoft.works.WorksData1"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp" %>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" /> 

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
        if (month <= 3) {
            yearStart = cyear - 1;
            yearEnd = cyear;
        } else {
            yearStart = cyear;
            yearEnd = cyear + 1;
        }
        String schemes = "'01','02','03'";
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
            <td align="center" class=gridhdbg ></td><td align="center" class=gridhdbg >Works Progress - Physical & Financial Detailed Report for &nbsp;<%=yearStart%>-<%=yearEnd%> and  Programme:&nbsp;<%=pn%> </td>
        </tr>

    </table>
    <table    width="70%" border=1 style="border-collapse:collapse"  ALIGN=CENTER >
        <%if (mode.equals("cWorks") || mode.equals("tWorks") || mode.equals("fWorks")) {%>
        <tr align=center>


            <td class=gridhdbg ><b>SL&nbsp;NO   </b></td>
            <td class=gridhdbg ><b>WorkId</b></td>
            <td class=gridhdbg ><b>Work Name </b></td>
            <td class=gridhdbg ><b>Sanction Date </b></td>
            <td class=gridhdbg ><b>Est. Cost </b></td>
            <td class=gridhdbg ><b>Probable Date of Completion </b></td>
            <td class=gridhdbg ><b>Work Completion Date </b></td>
            <td class=gridhdbg ><b>No. of Habs </b></td>
            <td class=gridhdbg ><b>Image1 </b></td>
            <td class=gridhdbg ><b>Image2</b></td>


        </tr>


        <%
            Statement statement = null;
            ResultSet resultSet = null;
            try {
               /*  if (mode.equals("tWorks")) {
                    query = "select a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(PROBABLE_DATE,'dd/mm/yyyy'),'--') from "
                            + "rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c, rws_contractor_selection_tbl m where "
                            + "WORK_CANCEL_DT is null and c.GROUNDING_DATE is not null and a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + pc + ") "
                            + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                            + "and target_date_comp>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id "
                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and c.CORE_DASHBOARD_STATUS<>'N'";
                } else if (mode.equals("cWorks")) {                    
                    query = "select a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(PROBABLE_DATE,'dd/mm/yyyy'),'--'),to_char(b.DATE_OF_COMPLETION,'dd/mm/yyyy') "
                            + "from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where "
                            + "WORK_CANCEL_DT is null and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  "
                            + "and a.programme_code in ("+pc+")  and b.DATE_OF_COMPLETION between '01-APR-"+yearStart+"' and '31-MAR-"+yearEnd+"' and b.DATE_OF_COMPLETION is not null and "
                            + " target_date_comp>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N'";
                } else {
                    query = "select a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(PROBABLE_DATE,'dd/mm/yyyy'),'--') from "
                            + "rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c, rws_contractor_selection_tbl m where "
                            + "WORK_CANCEL_DT is null and c.GROUNDING_DATE is not null and a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + pc + ") "
                            + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) "
                            + "and target_date_comp>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id "
                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and c.CORE_DASHBOARD_STATUS<>'N'";
                } */
                if (mode.equals("tWorks")) {
                    /* query = "select a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(TARGET_DATE_COMP ,'dd/mm/yyyy'),'--') from "
                            + "rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c, rws_contractor_selection_tbl m where "
                            + "WORK_CANCEL_DT is null and c.GROUNDING_DATE is not null and a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + pc + ") "
                            + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                            + "and target_date_comp>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id "
                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and c.CORE_DASHBOARD_STATUS<>'N'"; */
                	query = "select a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(TARGET_DATE_COMP ,'dd/mm/yyyy'),'--') from "
                            + "rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c, rws_contractor_selection_tbl m where "
                            + "WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + pc + ") "
                            + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                            + "and target_date_comp>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  "
                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and c.CORE_DASHBOARD_STATUS<>'N'";
                } else if (mode.equals("cWorks")) {                    
                    query = "select a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(TARGET_DATE_COMP ,'dd/mm/yyyy'),'--'),to_char(b.DATE_OF_COMPLETION,'dd/mm/yyyy') "
                            + "from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where "
                            + "WORK_CANCEL_DT is null and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  "
                            + "and a.programme_code in ("+pc+")  and b.DATE_OF_COMPLETION between '01-APR-"+yearStart+"' and '31-MAR-"+yearEnd+"' and b.DATE_OF_COMPLETION is not null and "
                            + " target_date_comp>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N'";
                } else {
                    query = "select a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(TARGET_DATE_COMP ,'dd/mm/yyyy'),'--') from "
                            + "rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c, rws_contractor_selection_tbl m where "
                            + "WORK_CANCEL_DT is null and c.GROUNDING_DATE is not null and a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + pc + ") "
                            + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) "
                            + "and target_date_comp>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id "
                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and c.CORE_DASHBOARD_STATUS<>'N'";
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
                
//                if (sub.equals("MVS")) {
//                    query += " and a.TYPE_OF_ASSET='03' ";
//                } else if (sub.equals("SVS")) {
//                    query += " and a.TYPE_OF_ASSET<>'03' ";
//                }

               // System.out.println(query);
                stmt = conn.createStatement();
                rs = stmt.executeQuery(query);
                while (rs.next()) {

                    String compDate = "";
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
                    String noofHabs = "";
                    String habs = "";
                    if (mode.equals("cWorks")) {
                        habs = "select count(hab_code) from RWS_WORK_COMP_HAB_LNK_TBL where work_id='" + rs.getString(2) + "'";
                    } else {
                        habs = "select count(hab_code) from RWS_ADMN_HAB_LNK_TBL where work_id='" + rs.getString(2) + "'";
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
                    if (styleCount % 2 == 0) {
                        style = "gridbg1";
                    } else {
                        style = "gridbg2";
                    }
                    styleCount++;

        %>

        <tr>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=count++%></td>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=rs.getString(2)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString(3)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString(4)%></td>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=rs.getString(1)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString(5)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=compDate%></td>
            <%
            if(mode.equals("cWorks"))
            {
                %><td class="<%=style%>" style="text-align: left;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=cHabs&mode1=wrk&wid=<%=rs.getString(2)%>&pc=<%=pc%>&pn=<%=pn%>')"><%=noofHabs%></a></td><%
            }
            else
            {
                %><td class="<%=style%>" style="text-align: left;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=sHabs&mode1=wrk&wid=<%=rs.getString(2)%>&pc=<%=pc%>&pn=<%=pn%>')"><%=noofHabs%></a></td><%
            }
                    String image1 = "select WORK_IMAGE from rws_work_image_tbl where WORK_ID='" + rs.getString(2) + "'";
                    statement = conn.createStatement();
                    resultSet = statement.executeQuery(image1);

                    if (resultSet.next()) {
                %>
            <td class="<%=style%>" style="text-align: left;" align="right"><a href="#" onclick="viewWorks('rws_Work_Image_view.jsp?workid=<%=rs.getString(2)%>&mode=image1')">View</a></td>

            <%} else {%>
            <td class="<%=style%>" style="text-align: left;" align="right">Image Not Exist</td>
            <%}
                statement.close();
                resultSet.close();

                String image2 = "select WORK_IMAGE1 from rws_work_image_tbl where WORK_ID='" + rs.getString(2) + "'";
                statement = conn.createStatement();
                resultSet = statement.executeQuery(image2);

                if (resultSet.next()) {
            %>
            <td class="<%=style%>" style="text-align: left;" align="right"><a href="#" onclick="viewWorks('rws_Work_Image_view.jsp?workid=<%=rs.getString(2)%>&mode=image2')">View</a></td>

            <%} else {%>
            <td class="<%=style%>" style="text-align: left;" align="right">Image Not Exist</td>
            <%}
                statement.close();
                resultSet.close();

            %>


        </tr>

        <%                }
                stmt.close();
                rs.close();
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
        </tr>
        <%
            Statement statement = null;
            ResultSet resultSet = null;
            try {

                if (mode.equals("sHabs")) {
                  /*  query = "select dist.dname,mdl.mname,panch.pname,vill.vname,habs.PANCH_NAME,b.hab_code,SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) as pop,hd.coverage_status "
                           + "from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m, rws_habitation_directory_tbl hd, "
                           + "rws_district_tbl dist, rws_mandal_tbl mdl, rws_panchayat_tbl panch, rws_village_tbl vill, rws_panchayat_raj_tbl habs where hd.hab_code=b.hab_code and "
                           + "WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and "
                           + "DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and target_date_comp>='01-APR-"+yearStart+"' and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id "
                           + "and m.work_id=a.work_id and m.work_id=i.work_id and a.programme_code in ("+pc+") and a.TYPE_OF_ASSET in ("+schemes+") and c.GROUNDING_DATE is not null "
                           + "and c.CORE_DASHBOARD_STATUS<>'N' and b.hab_code=habs.PANCH_CODE and dist.dcode=SUBSTR(habs.PANCH_CODE,1,2) and mdl.mcode=SUBSTR(habs.PANCH_CODE,6,2) "
                           + "and panch.pcode=SUBSTR(habs.PANCH_CODE,13,2) and vill.vcode=SUBSTR(habs.PANCH_CODE,8,3) and mdl.dcode=dist.dcode and panch.dcode=mdl.dcode "
                           + "and panch.mcode=mdl.mcode and vill.dcode=panch.dcode and vill.mcode=panch.mcode and vill.pcode=panch.pcode "; */
                	 query = "select  dist.dname,mdl.mname,panch.pname,vill.vname,habs.PANCH_NAME,b.hab_code,SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) as pop,hd.coverage_status "
                             + "from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m, rws_habitation_directory_tbl hd, "
                             + "rws_district_tbl dist, rws_mandal_tbl mdl, rws_panchayat_tbl panch, rws_village_tbl vill, rws_panchayat_raj_tbl habs where hd.hab_code=b.hab_code and "
                             + "WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and "
                             + "DATE_OF_COMPLETION<'01-APR-"+yearStart+"') and target_date_comp>='01-APR-"+yearStart+"' and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id "
                             + "and m.work_id(+)=a.work_id and a.programme_code in ("+pc+") and a.TYPE_OF_ASSET in ("+schemes+")"
                             + "and c.CORE_DASHBOARD_STATUS<>'N' and b.hab_code=habs.PANCH_CODE and dist.dcode=SUBSTR(habs.PANCH_CODE,1,2) and mdl.mcode=SUBSTR(habs.PANCH_CODE,6,2) "
                             + "and panch.pcode=SUBSTR(habs.PANCH_CODE,13,2) and vill.vcode=SUBSTR(habs.PANCH_CODE,8,3) and mdl.dcode=dist.dcode and panch.dcode=mdl.dcode "
                             + "and panch.mcode=mdl.mcode and vill.dcode=panch.dcode and vill.mcode=panch.mcode and vill.pcode=panch.pcode ";
                } else if(mode.equals("cHabs")){
                    query = "select distinct dist.dname,mdl.mname,panch.pname,vill.vname,habs.PANCH_NAME,b.hab_code,SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) as pop,hd.coverage_status "
                           + "from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m, rws_habitation_directory_tbl hd, "
                           + "rws_district_tbl dist, rws_mandal_tbl mdl, rws_panchayat_tbl panch, rws_village_tbl vill, rws_panchayat_raj_tbl habs, rws_work_completion_tbl comp where hd.hab_code=b.hab_code and "
                           + "WORK_CANCEL_DT is null and a.work_id=comp.work_id and ((comp.DATE_OF_COMPLETION >= '01-APR-"+yearStart+"'  and comp.DATE_OF_COMPLETION is not null) OR (comp.partial_date_of_completion is not null and comp.DATE_OF_COMPLETION is null))"
                            + "and target_date_comp>='01-APR-"+yearStart+"' and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id "
                           + "and m.work_id=a.work_id and m.work_id=i.work_id and a.programme_code in ("+pc+") and a.TYPE_OF_ASSET in ("+schemes+") and c.GROUNDING_DATE is not null "
                           + "and c.CORE_DASHBOARD_STATUS<>'N' and b.hab_code=habs.PANCH_CODE and dist.dcode=SUBSTR(habs.PANCH_CODE,1,2) and mdl.mcode=SUBSTR(habs.PANCH_CODE,6,2) "
                           + "and panch.pcode=SUBSTR(habs.PANCH_CODE,13,2) and vill.vcode=SUBSTR(habs.PANCH_CODE,8,3) and mdl.dcode=dist.dcode and panch.dcode=mdl.dcode "
                           + "and panch.mcode=mdl.mcode and vill.dcode=panch.dcode and vill.mcode=panch.mcode and vill.pcode=panch.pcode ";
                }else {
                    query = "select  dist.dname,mdl.mname,panch.pname,vill.vname,habs.PANCH_NAME,b.hab_code,SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) as pop,hd.coverage_status "
                            + "from rws_work_admn_tbl a,RWS_WORK_COMP_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m, rws_habitation_directory_tbl hd, "
                            + "rws_district_tbl dist, rws_mandal_tbl mdl, rws_panchayat_tbl panch, rws_village_tbl vill, rws_panchayat_raj_tbl habs, rws_work_completion_tbl comp where hd.hab_code=b.hab_code and "
                            + "WORK_CANCEL_DT is null and a.work_id=comp.work_id and comp.DATE_OF_COMPLETION is not null and comp.DATE_OF_COMPLETION between '01-APR-"+yearStart+"' and '31-MAR-"+yearEnd+"' "
                             + "and target_date_comp>='01-APR-"+yearStart+"' and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id "
                            + "and m.work_id=a.work_id and m.work_id=i.work_id and a.programme_code in ("+pc+") and a.TYPE_OF_ASSET in ("+schemes+") and c.GROUNDING_DATE is not null "
                            + "and c.CORE_DASHBOARD_STATUS<>'N' and b.hab_code=habs.PANCH_CODE and dist.dcode=SUBSTR(habs.PANCH_CODE,1,2) and mdl.mcode=SUBSTR(habs.PANCH_CODE,6,2) "
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
                query+= " group by dist.dname,mdl.mname,panch.pname,vill.vname,habs.PANCH_NAME,b.hab_code,hd.coverage_status order by dist.dname,mdl.mname,panch.pname,vill.vname,habs.PANCH_NAME";

                System.out.println("query---" + query);
                Statement st = conn.createStatement();
                ResultSet rs1 = st.executeQuery(query);
                while (rs1.next()) {
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
