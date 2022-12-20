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
</style>





    <%    DecimalFormat ndf = new DecimalFormat("####.00");
        String dcode = request.getParameter("dcode");
        String dname = request.getParameter("dname");
        String programme = request.getParameter("programme");
        String mode = request.getParameter("mode");
        String schemes = "'01','02','03'";
        String yearStart=request.getParameter("yearStart");
        String yearEnd=request.getParameter("yearEnd");
        String message=request.getParameter("message");
        int count = 1;
        int styleCount = 0;
        String style = "";
        String query = "";
        
        
    %>


    <br/><br/>
        <center>
            <font color="#663899" face="Maiandra GD" size="4px"><b>Physical Coverage of Habitations for <%=message %></b></font>
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
            <td class=btext><b>SL&nbsp;NO </b></td>
            <td class=btext><b>District</b></td>
            <td class=btext><b>Mandal</b></td>
            <td class=btext><b>Panchayat</b></td>
            <td class=btext><b>Village</b></td>
            <td class=btext><b>Habitation Name</b></td>
            <td class=btext><b>Habitation Code</b></td>
            <td class=btext><b>Coverage Status</b></td>
            <td class=btext><b>Total Population</b></td>
        </tr>
        <%
            Statement statement = null;
            ResultSet resultSet = null;
            try {

                if (mode.equals("sHabs")) {
                	query = "select b.hab_code from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m  where WORK_CANCEL_DT is null  "
						+ " and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
						+ programme
						+ ") and c.GROUNDING_DATE is not null  and substr(a.work_id,7,2) in ("
						+ schemes
						+ ") AND TARGET_DATE_COMP between '"+yearStart+"' and '"+yearEnd+"' and  c.CORE_DASHBOARD_STATUS<>'N' and ( TARGET_DATE_COMP is not null OR TARGET_DATE_COMP <> '')";
                	if(dcode!=null){
                		query+=" and substr(a.work_id,5,2)='"+dcode+"'";
                	}
                	} else if(mode.equals("cHabs")){ 
                    query = "select h.hab_code from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h  where WORK_CANCEL_DT is null "
							+ "   and h.work_id=b.work_id and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
							+ programme
							+ ") and b.DATE_OF_COMPLETION between '"+yearStart+"' and '"+yearEnd+"' and b.DATE_OF_COMPLETION is not null  and c.CORE_DASHBOARD_STATUS<>'N' and substr(a.work_id,7,2) in ("
							+ schemes
							+ ") ";
                    if(dcode!=null){
                		query+=" and substr(a.work_id,5,2)='"+dcode+"'";
                	}
                 } else if(mode.equals("preHabs")){ 
                     query = "select h.hab_code from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h  where WORK_CANCEL_DT is null "
								+ "   and h.work_id=b.work_id and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
								+ programme
								+ ") and b.DATE_OF_COMPLETION between '"+yearStart+"' and '"+yearEnd+"' and b.DATE_OF_COMPLETION is not null and substr(a.work_id,7,2) in ("
								+ schemes + ") ";
                     if(dcode!=null){
                 		query+=" and substr(a.work_id,5,2)='"+dcode+"'";
                 	}
                  }
			//System.out.println(query);
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
