<%@page import="nic.watersoft.works.WorksData1"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" />

<table bgcolor="#F8FCEE" width="100%" height="40px" cellspacing="0" cellpadding="0" border="0" >
<!-- Page header starts here-->
<tr height="1%">
	<td class="pageHeading" align="center">
		<bean:message key="app.title1" />
		 <span style="font-family:verdana; font-size: 8pt; "></span>		
	</td>
</tr>
<tr height="1%">
	<td class="pageHeading2" align="center">
		&nbsp;&nbsp;&nbsp;&nbsp;<bean:message key="app.heading2" />
	</td>
</tr>
<tr height="1%">
	<td class="pageHeading2" align="center">
		&nbsp;
	</td>
</tr>
</table>

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






    <%    DecimalFormat ndf = new DecimalFormat("####.00");
        String dcode = request.getParameter("dcode");
        String dname = request.getParameter("dname");
        String programmeCode = request.getParameter("programmeCode");
        //String programmeName=request.getParameter("programmeName");
        String mode = request.getParameter("mode");
        String mode1 = request.getParameter("mode1");
        String work_id = request.getParameter("workid");
        //String type = request.getParameter("type");
        int count = 1;
        int styleCount = 0;
        String style = "";
        String query = "";
        String finyear = "";
        if (request.getParameter("finyear") != null) {
            finyear = request.getParameter("finyear");
            session.setAttribute("finyear", finyear);
        }

        String startyr = finyear.substring(0, 4);

        String endyr = finyear.substring(5, 9);
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
        int yearStart = 0;
        int yearEnd = 0;
        if (month <= 3) {
            yearStart = cyear - 1;
            yearEnd = cyear;
        } else {
            yearStart = cyear;
            yearEnd = cyear + 1;
        }
    %>


    <table border=1 cellspacing=0 cellpadding=0 width="70%"
           bordercolor=#000000 style="border-collapse: collapse" ALIGN=CENTER>
        <caption>
            <table border=0 rules=none style="border-collapse: collapse"
                   align="right">
                <a href="javascript:onclick=history.go(-1)">Back</a>&nbsp;|&nbsp;
                <a href="#" onClick="window.close();">Close</a>


            </table>
        </caption>
        <tr align="center">
            <td align="center" class=gridhdbg></td>
            <td align="center" class=gridhdbg>Work Progress Detailed Report
                for District:&nbsp;<%=dname%>&nbsp;
            </td>
        </tr>

    </table>
    <table width="70%" border=1 style="border-collapse: collapse"
           ALIGN=CENTER>
        <%
            if (mode.equals("cWorks") || mode.equals("tWorks") || mode.equals("pnfWorks")) {
        %>
        <tr align=center>


            <td class=gridhdbg rowspan=2><b>SL&nbsp;NO </b></td>
            <td class=gridhdbg rowspan=2><b>WorkId</b></td>
            <td class=gridhdbg rowspan=2><b>Work Name </b></td>
            <td class=gridhdbg rowspan=2><b>Program Name </b></td>
            <td class=gridhdbg rowspan=2><b>Sanction Date </b></td>
            <td class=gridhdbg rowspan=2><b>Est. Cost </b></td>
            <td class=gridhdbg rowspan=2><b>No. of Habs </b></td>
            <td class=gridhdbg rowspan=2>Exp. Upto Last Financial Year</td>
            <td colspan=3 class=gridhdbg align="center">Exp. During the
                Financial Year</td>
            <td class=gridhdbg rowspan=2>ARFC(Est.Cost-Cum. Exp.)</td>
            <td class=gridhdbg rowspan=2><b>Work Completion Date </b></td>
            <td class=gridhdbg rowspan=2><b>Image1 </b></td>
            <td class=gridhdbg rowspan=2><b>Image2</b></td>


        </tr>

        <tr>
            <td colspan=1 class=gridhdbg align="center">Exp. Upto Last Month
            </td>
            <td colspan=1 class=gridhdbg align="center">Exp. During the Month
            </td>
            <td colspan=1 class=gridhdbg align="center">Total Exp.</td>


        </tr>
        <%
            Statement statement = null;
            ResultSet resultSet = null;
            Statement stmt1 = null;
            ResultSet rs1 = null;
            double estCost = 0, bankLastYear = 0, bankLastMonth = 0, bankCurrentMonth = 0, paoLastYear = 0, paoLastMonth = 0, paoCurrentMonth = 0, expUptoLFY = 0, expUptoLM = 0, expDM = 0, TotExp = 0;
            int totNoOfWorks = 0, totHabsSanctioned = 0, totWorksComp = 0, totHabsCov = 0;
            double totarfc = 0, totEstCost = 0, totExpUptoLFY = 0, totExpUptoLM = 0, totExpDM = 0, totTotExp = 0;

            try {

                if (mode.equals("tWorks")) {
                    //query = "select a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(PROBABLE_DATE,'dd/mm/yyyy'),'--') from rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='" + dcode + "' and a.programme_code in ("+programmeCode+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMM is not null and DT_FIN_COMPLETION is not null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id ";
                    query = "select a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(PROBABLE_DATE,'dd/mm/yyyy'),'--'),p.PROGRAMME_NAME from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
                            + dcode
                            + "' and a.programme_code in ("
                            + programmeCode
                            + ") and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and a.PROGRAMME_CODE=p.PROGRAMME_CODE and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and c.GROUNDING_DATE is not null and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id";
                    if (request.getParameter("divCode") != null) {
                        query += " and substr(a.office_code,4,1)='"
                                + request.getParameter("divCode") + "'";
                    }
                    if (request.getParameter("subdivCode") != null) {
                        query += " and substr(a.office_code,5,2)='"
                                + request.getParameter("subdivCode")
                                + "'";
                    }
                    System.out.println("query---_______________---"
                            + query);
                } else if (mode.equals("cWorks")) {
                    query = "select a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(PROBABLE_DATE,'dd/mm/yyyy'),'--'),p.PROGRAMME_NAME,to_char(b.DATE_OF_COMPLETION,'dd/mm/yyyy') from rws_work_admn_tbl a,rws_programme_tbl p,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m  where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
                            + dcode
                            + "' and a.PROGRAMME_CODE=p.PROGRAMME_CODE and b.DATE_OF_COMPLETION between '01-APR-"
                            + yearStart
                            + "' and '31-MAR-"
                            + yearEnd
                            + "' and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
                            + programmeCode
                            + ") and b.DATE_OF_COMPLETION is not null ";
                    if (request.getParameter("divCode") != null) {
                        query += " and substr(a.office_code,4,1)='"
                                + request.getParameter("divCode") + "'";
                    }
                    if (request.getParameter("subdivCode") != null) {
                        query += " and substr(a.office_code,5,2)='"
                                + request.getParameter("subdivCode")
                                + "'";
                    }
                    query += " order by b.DATE_OF_COMPLETION desc";
                    System.out.println("@@@@@@@@@query: " + query);
                } else {
                    query = "select a.SANCTION_AMOUNT,a.work_id,a.work_name,nvl(to_char(admin_date,'dd/mm/yyyy'),'--'),nvl(to_char(PROBABLE_DATE,'dd/mm/yyyy'),'--'),p.PROGRAMME_NAME,to_char(b.DATE_OF_COMPLETION,'dd/mm/yyyy') from rws_work_admn_tbl a,rws_work_completion_tbl b,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m  where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='" + dcode + "' and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and a.PROGRAMME_CODE=p.PROGRAMME_CODE and m.work_id=i.work_id  and a.programme_code in (" + programmeCode + ") and b.DATE_OF_COMPLETION is not null and b.DATE_OF_COMPLETION between '01-APR-" + (yearStart-1) + "' and '31-MAR-" + (yearEnd-1) + "' and b.DT_FIN_COMPLETION is null";
                    if (request.getParameter("divCode") != null) {
                        query += " and substr(a.office_code,4,1)='"
                                + request.getParameter("divCode") + "'";
                    }
                    if (request.getParameter("subdivCode") != null) {
                        query += " and substr(a.office_code,5,2)='"
                                + request.getParameter("subdivCode")
                                + "'";
                    }
                    query += " order by b.DATE_OF_COMPLETION desc";
                    System.out.println("@@@@@@@@@query: " + query);
                }

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
                    String noofHabs = "";
                    String habs = "";
                    if (mode.equals("tWorks")) {
                        habs = "select count(hab_code) from RWS_ADMN_HAB_LNK_TBL where work_id='"
                                + rs.getString(2) + "'";
                    } else if (mode.equals("cWorks")) {
                        habs = "select count(hab_code) from RWS_WORK_COMP_HAB_LNK_TBL where work_id='"
                                + rs.getString(2) + "'";
                    }
                    else {
                        habs = "select count(hab_code) from RWS_WORK_COMP_HAB_LNK_TBL where work_id='"
                                + rs.getString(2) + "'";
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
                    String typeofasset = rs.getString(2)
                            .substring(6, 8);

                    if (typeofasset.equals("11")) {
                        noofHabs = "SCHOOL";
                    } else if (typeofasset.equals("12")) {
                        noofHabs = "LAB";
                    }
        %>

        <tr>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=count++%></td>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=rs.getString(2)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString(3)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString(6)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString(4)%></td>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=rs.getString(1)%></td>
            <%
                if (mode.equals("tWorks")) {
                    if (typeofasset.equals("11")
                            || typeofasset.equals("12")) {
            %>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=noofHabs%></td>
            <%
            } else {
            %>
            <td class="<%=style%>" style="text-align: left;" align="right"><a
                    href="#"
                    onclick="viewWorks('./rws_CM_work_progress_abstract_drill.jsp?mode=sHabs&mode1=work&workid=<%=rs.getString(2)%>&dcode=<%=dcode%>&programmeCode=<%=programmeCode%>&dname=<%=dname%>&finyear=<%=yearStart%>-<%=yearEnd%>')"><%=noofHabs%></a></td>
                <%
                    }
                } else if (typeofasset.equals("11")
                        || typeofasset.equals("12")) {
                %>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=noofHabs%></td>
            <%
            } else {
            %>
            <td class="<%=style%>" style="text-align: left;" align="right"><a
                    href="#"
                    onclick="viewWorks('./rws_CM_work_progress_abstract_drill.jsp?mode=cHabs&mode1=work&workid=<%=rs.getString(2)%>&dcode=<%=dcode%>&programmeCode=<%=programmeCode%>&dname=<%=dname%>&finyear=<%=yearStart%>-<%=yearEnd%>')"><%=noofHabs%></a></td>
                <%
                    }
                %>

            <%
                String bankLFY = "select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL where work_id='"
                        + workid
                        + "' and BANK_SEND_DATE<='31-MAR-"
                        + (yearEnd - 1) + "'";

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
                        + "' and STATE_SEND_DATE<='31-MAR-"
                        + (yearEnd - 1) + "'";
                stmt1 = conn.createStatement();
                rs1 = stmt1.executeQuery(paoFLY);
                //System.out.println("paoFLY"+paoFLY);
                if (rs1.next()) {
                    paoLastYear = rs1.getDouble(1);

                }
                stmt1.close();
                rs1.close();

                String finalamount = ndf
                        .format((bankLastYear + paoLastYear) / 100000);
            %>
            <td class="<%=style%>" style="text-align: right;" align="right"><%=finalamount%></td>

            <%
                String bankUptoLastMonth = "select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL where work_id='"
                        + work_id
                        + "' and BANK_SEND_DATE>='01-APR-"
                        + yearStart
                        + "' and BANK_SEND_DATE<'01-"
                        + currentMonth + "-" + yearEnd + "'";
                stmt1 = conn.createStatement();
                rs1 = stmt1.executeQuery(bankUptoLastMonth);
                //System.out.println("bankUptoLastMonth"+bankUptoLastMonth);
                if (rs1.next()) {
                    bankLastMonth = rs1.getDouble(1);

                }
                stmt1.close();
                rs1.close();

                String paoUptoLastMonth = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL where work_id='"
                        + work_id
                        + "' and STATE_SEND_DATE>='01-APR-"
                        + yearStart
                        + "' and STATE_SEND_DATE<'01-"
                        + currentMonth + "-" + yearEnd + "'";

                stmt1 = conn.createStatement();
                rs1 = stmt1.executeQuery(paoUptoLastMonth);
                //System.out.println("paoUptoLastMonth"+paoUptoLastMonth);
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
                        + work_id
                        + "' and BANK_SEND_DATE>='01-"
                        + currentMonth
                        + "-"
                        + cyear
                        + "' and BANK_SEND_DATE<='" + cDate + "'";

                stmt1 = conn.createStatement();
                rs1 = stmt1.executeQuery(bankcurrMonth);
                //System.out.println("bankcurrMonth"+bankcurrMonth);
                if (rs1.next()) {
                    bankCurrentMonth = rs1.getDouble(1);

                }
                stmt1.close();
                rs1.close();

                String paocurrMonth = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL  where work_id='"
                        + work_id
                        + "' and STATE_SEND_DATE>='01-"
                        + currentMonth
                        + "-"
                        + cyear
                        + "' and STATE_SEND_DATE<='" + cDate + "'";
                stmt1 = conn.createStatement();
                rs1 = stmt1.executeQuery(paocurrMonth);
                //System.out.println("paocurrMonth"+paocurrMonth);
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
            <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(arfc)%></td>
            <td class="<%=style%>" style="text-align: left;" align="right"><%=compDate%></td>

            <%
                String image1 = "select WORK_IMAGE from rws_work_image_tbl where WORK_ID='"
                        + rs.getString(2) + "'";
                statement = conn.createStatement();
                resultSet = statement.executeQuery(image1);

                if (resultSet.next()) {
            %>
            <td class="<%=style%>" style="text-align: left;" align="right"><a
                    href="#"
                    onclick="viewWorks('rws_Work_Image_view.jsp?workid=<%=rs.getString(2)%>&mode=image1')">View</a></td>

            <%
            } else {
            %>
            <td class="<%=style%>" style="text-align: left;" align="right">Image
                Not Exist</td>
                <%
                    }
                    statement.close();
                    resultSet.close();

                    String image2 = "select WORK_IMAGE1 from rws_work_image_tbl where WORK_ID='"
                            + rs.getString(2) + "'";
                    statement = conn.createStatement();
                    resultSet = statement.executeQuery(image2);

                    if (resultSet.next()) {
                %>
            <td class="<%=style%>" style="text-align: left;" align="right"><a
                    href="#"
                    onclick="viewWorks('rws_Work_Image_view.jsp?workid=<%=rs.getString(2)%>&mode=image2')">View</a></td>

            <%
            } else {
            %>
            <td class="<%=style%>" style="text-align: left;" align="right">Image
                Not Exist</td>
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
                %>


        </tr>

        <%
            }
            stmt.close();
            rs.close();
        %>
        <tr>
            <td class="gridhdbg" style="text-align: right;" colspan=5>Total:</td>
            <td class="gridhdbg" style="text-align: right;"><%=ndf.format(totEstCost)%></td>
            <td class="gridhdbg" style="text-align: right;"></td>
            <td class="gridhdbg" style="text-align: right;"><%=ndf.format(totExpUptoLFY / 100000)%></td>
            <td class="gridhdbg" style="text-align: right;"><%=ndf.format(totExpUptoLM / 100000)%></td>
            <td class="gridhdbg" style="text-align: right;"><%=ndf.format(totExpDM / 100000)%></td>
            <td class="gridhdbg" style="text-align: right;"><%=ndf.format(totTotExp / 100000)%></td>
            <td class="gridhdbg" style="text-align: right;"><%=ndf.format(totarfc)%></td>
            <td class="gridhdbg" style="text-align: right;"></td>
            <td class="gridhdbg" style="text-align: right;"></td>
            <td class="gridhdbg" style="text-align: right;"></td>
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
            <td class=gridhdbg><b>SL&nbsp;NO </b></td>
            <td class=gridhdbg><b>District</b></td>
            <td class=gridhdbg><b>Mandal</b></td>
            <td class=gridhdbg><b>Panchayat</b></td>
            <td class=gridhdbg><b>Village</b></td>
            <td class=gridhdbg><b>Habitation Code</b></td>
            <td class=gridhdbg><b>Habitation Name</b></td>

            <td class=gridhdbg><b>Coverage Status</b></td>
            <td class=gridhdbg><b>Total Population</b></td>
        </tr>
        <%
            Statement statement = null;
            ResultSet resultSet = null;
            try {

                if (mode.equals("sHabs")) {
                    query = "select b.hab_code from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m  where WORK_CANCEL_DT is null  and substr(a.WORK_ID,5,2)='"
                            + dcode
                            + "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
                            + programmeCode + ")";
                    if (mode1.equals("work")) {
                        query += " and a.work_id='" + work_id + "'";
                    }
                    if (request.getParameter("divCode") != null) {
                        query += " and substr(a.office_code,4,1)='"
                                + request.getParameter("divCode") + "'";
                    }
                    if (request.getParameter("subdivCode") != null) {
                        query += " and substr(a.office_code,5,2)='"
                                + request.getParameter("subdivCode")
                                + "'";
                    }
                } else if (mode1.equals("work")) {
                    query = "select h.hab_code from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h  where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
                            + dcode
                            + "' and h.work_id=b.work_id and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
                            + programmeCode
                            + ") and b.DATE_OF_COMPLETION is not null";

                    query += " and a.work_id='" + work_id + "'";
                } else {
                    query = "select h.hab_code from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h  where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)='"
                            + dcode
                            + "' and h.work_id=b.work_id and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in ("
                            + programmeCode
                            + ") and b.DATE_OF_COMPLETION between '01-APR-"
                            + yearStart
                            + "' and '31-MAR-"
                            + yearEnd
                            + "' and b.DATE_OF_COMPLETION is not null";

                    if (request.getParameter("divCode") != null) {
                        query += " and substr(a.office_code,4,1)='"
                                + request.getParameter("divCode")
                                + "'";
                    }
                    if (request.getParameter("subdivCode") != null) {
                        query += " and substr(a.office_code,5,2)='"
                                + request
                                .getParameter("subdivCode")
                                + "'";
                    }
                } /* if(type.equals("MVS")){
                                                        query+=" and substr(a.work_id,7,2)='03'";
                                                }
                                                else{
                                                        query+=" and substr(a.work_id,7,2) <> '03'";
                                                } */

                System.out.println("query---#############______" + query);
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

                    String details = "select dname,mname,pname,vname,panch_code,panch_name  from rws_complete_hab_view where panch_code='" + hab_code + "'";
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
                            System.out.println(hab_code);
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
            }
        %>
    </table>
<%@ include file="/commons/rws_footer.jsp"%>
</html:html>
