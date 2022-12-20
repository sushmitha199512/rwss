<%@page import="nic.watersoft.works.WorksData1"%>
<%@page import="java.sql.Connection"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%    DecimalFormat ndf = new DecimalFormat("####.00");
    String finyear = "";
    //String rDistrict = "";
    
    Calendar c = Calendar.getInstance();
    int year1 = c.get(Calendar.YEAR);
    int month1 = c.get(Calendar.MONTH) + 1;
    if (month1 < 3) {
        finyear = (year1 - 1) + "-" + year1;
    } else {
        finyear = year1 + "-" + (year1 + 1);
    }

    System.out.println("@@@@@@@@@@@finyear" + finyear);

    String sub = "ALL";
    String mode = "initial";
    
    if(request.getParameter("sub") !=null)
        sub = (String) request.getParameter("sub");
    
    if(request.getParameter("mode") !=null)
        mode = request.getParameter("mode");
    
    session.setAttribute("mode", mode);
    String program= "";
    String programe = "";//request.getParameter("program");
    String programName = "";

    //if(programe.equals("all")){
    String progCode = "";
    String NRDWPCodes = "";
    String codesToSend="";
    String nrdwpQuery = "select PROGRAMME_CODE from  rws_programme_tbl where NRDWP_RELATED='Y' order by 1";
    Statement stmtNRDWP = conn.createStatement();
    ResultSet rsNRDWP = stmtNRDWP.executeQuery(nrdwpQuery);
    while (rsNRDWP.next()) {
        NRDWPCodes += rsNRDWP.getString(1) + ",";
    }
    NRDWPCodes = NRDWPCodes.substring(0, NRDWPCodes.length() - 1);
    if (request.getParameter("program") != null && !((String) request.getParameter("program")).equals("null") && !((String) request.getParameter("program")).equals("") ) {
        program = request.getParameter("program");
        programe = request.getParameter("program");
        progCode = programe.split("_@_")[0];
        programName = programe.split("_@_")[1];
    } else {
        programName = "ALL";
        progCode = NRDWPCodes + ",04,65,70,57,77";
    }

    programe = progCode;

    session.setAttribute("programe", programe);
    session.setAttribute("programName", programName);

    String subprogCode = "";
    String subprogName = "ALL";
//    if (request.getParameter("subprogram") != null && !request.getParameter("subprogram").equals("all")) {
//        subprogCode = request.getParameter("subprogram");
//        String ar1[] = subprogCode.split("_@_");
//        subprogCode = ar1[0];
//        subprogName = ar1[1];
//    }
    subprogCode = "01,02,03";
    session.setAttribute("subprogram", subprogCode);
    session.setAttribute("subprogName", subprogName);
    String startyr = finyear.substring(0, 4);

    String endyr = finyear.substring(5, 9);

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

%>

<script src="/pred/resources/graphs/jquery.min.js"></script>
<script language="JavaScript">

            $(document).ready(function() {
                    $("#sub option[value='<%=sub%>']").prop('selected', true);
                    $("#sub").change(function() {
                        $("#f1").submit();
                    });
            });

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

<BODY>
    <br/>
    <br/>
    <form name=f1 id="f1" method="post" action="rws_work_progress_abstract_list1.jsp">
        <input type="hidden" name="mode" value="<%=mode%>"/>
        <input type="hidden" name="program" value="<%=program%>"/>
        <center>
            <font color="#663899" face="Maiandra GD" size="4px"><b>Work Progress Abstract</b></font>
            <br/><font color="#889900" face="Maiandra GD" size="2px">Programme: <%=programName%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Year: <%=finyear%></font>
        </center>

        <table align="center" style="margin-top: -25px !important; width: 1000px !important;  text-align: right !important;">
            <tr>
                <td style="width: 860px !important; text-align: left !important;">Scheme Type: 
                    <select name="sub" id="sub" onchange="document.f1.submit();">
                        <option value="ALL">ALL</option>
                        <option value="MVS">MVS</option>
                        <option value="SVS">SVS</option>
                    </select>
                </td>
                <td style="width: 70px !important;" align="right">
                    <a href="/pred/home.jsp?loginMode=watersoft"><img src="/pred/resources/graphs/home.png" height="28px"/></a>&nbsp;&nbsp; 
                </td>
                <td style="width: 70px !important;" align="right">
                    <a href="javascript:history.back(-1)"><img src="/pred/resources/graphs/go_back.gif" height="28px"/></a>&nbsp;&nbsp; 
                </td>
            </tr>
        </table>

        <table border=1 cellspacing=0 cellpadding=0 height=5% width="1000px" class="baseTable"
               bordercolor=#000000 style="border-collapse: collapse; margin-top: -15px !important; "
               bgcolor="#ffffff" align="center">

            <tr align=center align=center class="thead">
                <td class=btext rowspan=2>SNO</td>
                <!-- <td class=btext rowspan=2>District</td> -->
                <%if (mode.equals("initial")) {
                %>
                <td class=btext rowspan=2>Programme</td>
                <% } else if (mode.equals("subprog")) { %>
                <td class=btext rowspan=2>Sub Programme</td>
                <%} else if (mode.equals("districts")) {%>
                <td class=btext rowspan=2>District</td>
                <%}%>
                <td class=btext rowspan=2>No. of<br/>Works</td>
                <td class=btext rowspan=2>Estimated<br/>Cost</td>
                <td class=btext rowspan=2>Habs<br/>Sanctioned</td>
                <td class=btext rowspan=2>Works<br/>completed</td>
                <td class=btext rowspan=2>Habs<br/>Covered</td>
                <td class=btext rowspan=2>Expenditure<br/>Upto<br/><%=(yearStart - 1)%>-<%=(yearEnd - 1)%></td>
                <td colspan=3 class=btext align="center">Expenditure<br>(<%=yearStart%>-<%=yearEnd%>)</td>
                <td class=btext rowspan=2>ARFC<br/><font size="1px"><i>(Est.Cost- <br/> Cum.Exp.)</i></font></td>

                <td class=btext rowspan=1 colspan=2
                    style="width: 250px !important;">Physically Completed<br />
                    (Financially Not Completed)<br />(<%=yearStart - 1%>-<%=yearEnd - 1%>)
                </td>
            </tr>
            <tr>
                <td colspan=1 class=btext align="center">Upto Last Month<br/><font size="1px"><i>(<%=lastMonth%>)</i></font></td>
                <td colspan=1 class=btext align="center">Current Month<br/> <font size="1px"><i>(<%=currentMonth%>-<%=cyear%>)</i></font></td>
                <td colspan=1 class=btext align="center">Total</td>
                <td colspan=1 class=btext align="center">Works</td>
                <td colspan=1 class=btext align="center">Expenditure</td>


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
                    int totNoOfWorks = 0, totHabsSanctioned = 0, totWorksComp = 0, totHabsCov = 0, totWorksPhyCompNotFin = 0;
                     int nrdwpNoOfWorks = 0, nrdwpHabsSanctioned = 0, nrdwpWorksComp = 0, nrdwpHabsCov = 0, nrdwpWorksPhyCompNotFin = 0;
                    double totarfc = 0, totEstCost = 0, totExpUptoLFY = 0, totExpUptoLM = 0, totExpDM = 0, totTotExp = 0, expPhyCompNotFin = 0, bankPhyCompNotFin = 0, paoPhyCompNotFin = 0, totExpPhyCompNotFin = 0;
                    double nrdwparfc = 0, nrdwpEstCost = 0, nrdwpExpUptoLFY = 0, nrdwpExpUptoLM = 0, nrdwpExpDM = 0, nrdwpTotExp = 0, nrdwpExpPhyCompNotFin = 0, nrdwpBankPhyCompNotFin = 0, nrdwpPaoPhyCompNotFin = 0, nrdwpTotExpPhyCompNotFin = 0;
                    String query = "";
                    if (mode.equals("initial")) {
                        query = "select sum(a.SANCTION_AMOUNT),count(a.work_id),p.PROGRAMME_NAME,a.programme_code from rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE";
                        query += " and substr(a.work_id,7,2) not in ('11','12') and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
                        if(sub.equals("MVS"))
                            query+= " and a.TYPE_OF_ASSET='03' ";
                        else if(sub.equals("SVS"))
                            query+= " and a.TYPE_OF_ASSET<>'03' ";
                        query += " and a.programme_code=p.PROGRAMME_CODE and a.programme_code in ("
                                + programe
                                + ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  group by p.PROGRAMME_NAME,a.programme_code  order by p.PROGRAMME_NAME";
                    } else if (mode.equals("subprog")) {
                        query = "select sum(a.SANCTION_AMOUNT),count(a.work_id),p.PROGRAMME_NAME,a.programme_code,sp.SUBPROGRAMME_NAME,a.subprogramme_code from rws_work_admn_tbl a,rws_programme_tbl p,rws_subprogramme_tbl sp,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE";
                        query += " and substr(a.work_id,7,2) not in ('11','12') and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
                        if(sub.equals("MVS"))
                            query+= " and a.TYPE_OF_ASSET='03' ";
                        else if(sub.equals("SVS"))
                            query+= " and a.TYPE_OF_ASSET<>'03' ";
                        if (request.getParameter("subprogram") != null && !request.getParameter("subprogram").equals("all")) {
                            query += " and a.subprogramme_code in (" + subprogCode + ")";
                        }
                        query += " and a.programme_code=p.PROGRAMME_CODE and sp.programme_code=p.PROGRAMME_CODE and a.subprogramme_code=sp.subPROGRAMME_CODE and a.programme_code in ("
                                + programe
                                + ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  group by p.PROGRAMME_NAME,a.programme_code,sp.SUBPROGRAMME_NAME,a.subprogramme_code  order by a.programme_code,a.subprogramme_code";
                    } else if (mode.equals("districts")) {

                        query = "select sum(a.SANCTION_AMOUNT),count(a.work_id),p.PROGRAMME_NAME,a.programme_code,dname,dcode from rws_work_admn_tbl a,rws_programme_tbl p,rws_district_tbl d,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and substr(a.WORK_ID,5,2)=d.DCODE";
                        query += " and substr(a.work_id,7,2) not in ('11','12') and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
                        if(sub.equals("MVS"))
                            query+= " and a.TYPE_OF_ASSET='03' ";
                        else if(sub.equals("SVS"))
                            query+= " and a.TYPE_OF_ASSET<>'03' ";
                        query += " and a.programme_code=p.PROGRAMME_CODE  and a.programme_code in ("
                                + programe
                                + ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  group by p.PROGRAMME_NAME,a.programme_code,dname,dcode  order by a.programme_code,dcode";
                    }
                    
                    
                            
                    System.out.println("main query" + query);
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(query);
                    //boolean flagNABARD = false;

                    while (rs.next()) {

                        double estCost = 0, bankLastYear = 0, bankLastMonth = 0, bankCurrentMonth = 0, paoLastYear = 0, paoLastMonth = 0, paoCurrentMonth = 0, expUptoLFY = 0, expUptoLM = 0, expDM = 0, TotExp = 0;
                        int noOfWorks = 0, habsSanctioned = 0, worksComp = 0, habsCov = 0, worksPhyCompNotFin = 0;
                        noOfWorks = rs.getInt(2);
                        estCost = rs.getDouble(1);
                        if (styleCount % 2 == 0) {
                            style = "gridbg1";
                        } else {
                            style = "gridbg2";
                        }
                        styleCount++;


            %>
            <tr>


                <%  
                    
                    if((NRDWPCodes.indexOf(rs.getString(4))==-1 || progCode.equals(NRDWPCodes)) && mode.equals("initial") ) {
                        //if (programName.equals("NRDWP")) {
                %>
                <td class="<%=style%>" style="text-align: right;" align="right"><%=++slno%></td>
                <td class="<%=style%>" style="text-align: left;" align="right"><a href="./rws_work_progress_abstract_list1.jsp?mode=districts&program=<%=rs.getString(4)%>_@_<%=rs.getString(3)%>&finyear=<%=finyear%>&sub=<%=sub%>"><%=rs.getString(3)%></a></td>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_abstract_drill1.jsp?mode=tWorks&programmeCode=<%=rs.getString(4)%>&programmeName=<%=rs.getString(3)%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&sub=<%=sub%>')"><%=noOfWorks%></a></td>
                    <%} else if (mode.equals("subprog")) {%>
                <td class="<%=style%>" style="text-align: right;" align="right"><%=++slno%></td>
                <td class="<%=style%>" style="text-align: left;" align="right"><a href="./rws_work_progress_abstract_list1.jsp?mode=districts&program=<%=rs.getString(4)%>_@_<%=rs.getString(3)%>&subprogram=<%=rs.getString(6)%>_@_<%=rs.getString(5)%>&finyear=<%=finyear%>&sub=<%=sub%>"><%=rs.getString(5)%></a></td>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_abstract_drill1.jsp?mode=tWorks&programmeCode=<%=rs.getString(4)%>&programmeName=<%=rs.getString(3)%>&subprogrammeCode=<%=rs.getString(6)%>&subprogrammeName=<%=rs.getString(5)%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&sub=<%=sub%>')"><%=noOfWorks%></a></td> 
                    <%} else if (mode.equals("districts")) {%>
                <td class="<%=style%>" style="text-align: right;" align="right"><%=++slno%></td>
                <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString(5)%></td>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_abstract_drill1.jsp?mode=tWorks&dcode=<%=rs.getString(6)%>&programmeCode=<%=rs.getString(4)%>&dname=<%=rs.getString(5)%>&programmeName=<%=rs.getString(3)%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&sub=<%=sub%>')"><%=noOfWorks%></a></td>
                    <%} if((NRDWPCodes.indexOf(rs.getString(4))==-1 || progCode.equals(NRDWPCodes) || mode.equals("districts") )) {%>

                <td class="<%=style%>" style="text-align: right;" align="right"><%=estCost%></td>
                <%}

                    String sacHabs = "select count(b.hab_code) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m  where WORK_CANCEL_DT is null"
                            + "  and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code='" + rs.getString(4) + "'";
                    sacHabs += " and substr(a.work_id,7,2) not in ('11','12') and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
                    if (mode.equals("subprog")) {
                        sacHabs += " and a.subprogramme_code in (" + rs.getString(6) + ")";
                    }
                    if (mode.equals("districts")) {
                        sacHabs += " and substr(a.work_id,5,2)='" + rs.getString(6) + "'";
                    }
                    if(sub.equals("MVS"))
                        sacHabs+= " and a.TYPE_OF_ASSET='03' ";
                    else if(sub.equals("SVS"))
                        sacHabs+= " and a.TYPE_OF_ASSET<>'03' ";
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(sacHabs);
                    if (rs1.next()) {
                        habsSanctioned = rs1.getInt(1);
                %>
                <%if((NRDWPCodes.indexOf(rs.getString(4))==-1 || progCode.equals(NRDWPCodes)) && mode.equals("initial") ) {%>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_abstract_drill1.jsp?mode=sHabs&mode1=normal&programmeCode=<%=rs.getString(4)%>&programmeName=<%=rs.getString(3)%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&sub=<%=sub%>')"><%=habsSanctioned%></a></td>
                    <%} else if (mode.equals("subprog")) {%>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_abstract_drill1.jsp?mode=sHabs&mode1=normal&programmeCode=<%=rs.getString(4)%>&programmeName=<%=rs.getString(3)%>&subprogrammeCode=<%=rs.getString(6)%>&subprogrammeName=<%=rs.getString(5)%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&sub=<%=sub%>')"><%=habsSanctioned%></a></td>
                    <%} else if (mode.equals("districts")) {%>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_abstract_drill1.jsp?mode=sHabs&mode1=normal&dcode=<%=rs.getString(6)%>&programmeCode=<%=rs.getString(4)%>&dname=<%=rs.getString(5)%>&programmeName=<%=rs.getString(3)%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&sub=<%=sub%>')"><%=habsSanctioned%></a></td>
                    <%} %>

                <%
                    }
                    stmt1.close();
                    rs1.close();
                %>

                <%
                    String compWorks = "select count(a.work_id) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m  where WORK_CANCEL_DT is null "
                            + "  and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code='"
                            + rs.getString(4)
                            + "'  and b.DATE_OF_COMPLETION between '01-APR-" + yearStart + "' and '31-MAR-" + yearEnd + "' and b.DATE_OF_COMPLETION is not null";
                    compWorks += " and substr(a.work_id,7,2) not in ('11','12') and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
                    if (mode.equals("subprog")) {
                        compWorks += " and a.subprogramme_code='" + rs.getString(6) + "'";
                    }
                    if (mode.equals("districts")) {
                        compWorks += " and substr(a.work_id,5,2)='" + rs.getString(6) + "'";
                    }
                     if(sub.equals("MVS"))
                        compWorks+= " and a.TYPE_OF_ASSET='03' ";
                    else if(sub.equals("SVS"))
                        compWorks+= " and a.TYPE_OF_ASSET<>'03' ";
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(compWorks);

                    if (rs1.next()) {
                        worksComp = rs1.getInt(1);
                %>
                <%if((NRDWPCodes.indexOf(rs.getString(4))==-1 || progCode.equals(NRDWPCodes)) && mode.equals("initial") ) {%>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_abstract_drill1.jsp?mode=cWorks&programmeCode=<%=rs.getString(4)%>&programmeName=<%=rs.getString(3)%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&sub=<%=sub%>')"><%=worksComp%></a></td>
                    <%} else if (mode.equals("subprog")) {%>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_abstract_drill1.jsp?mode=cWorks&programmeCode=<%=rs.getString(4)%>&programmeName=<%=rs.getString(3)%>&subprogrammeCode=<%=rs.getString(6)%>&subprogrammeName=<%=rs.getString(5)%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&sub=<%=sub%>')"><%=worksComp%></a></td>
                    <%} else if (mode.equals("districts")) {%>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_abstract_drill1.jsp?mode=cWorks&programmeCode=<%=rs.getString(4)%>&programmeName=<%=rs.getString(3)%>&dcode=<%=rs.getString(6)%>&dname=<%=rs.getString(5)%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&sub=<%=sub%>')"><%=worksComp%></a></td>
                    <%} %>

                <%
                    }
                    stmt1.close();
                    rs1.close();
                %>


                <%
                    String covHabs = "select count(h.hab_code) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,RWS_WORK_COMP_HAB_LNK_TBL h  where WORK_CANCEL_DT is null "
                            + "   and h.work_id=b.work_id and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code='"
                            + rs.getString(4)
                            + "'  and b.DATE_OF_COMPLETION between '01-APR-" + yearStart + "' and '31-MAR-" + yearEnd + "' and b.DATE_OF_COMPLETION is not null";
                    covHabs += " and substr(a.work_id,7,2) not in ('11','12') and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
                    if (mode.equals("subprog")) {
                        covHabs += " and a.subprogramme_code='" + rs.getString(6) + "'";
                    }
                    if (mode.equals("districts")) {
                        covHabs += " and substr(a.work_id,5,2)='" + rs.getString(6) + "'";
                    }
                    if(sub.equals("MVS"))
                        covHabs+= " and a.TYPE_OF_ASSET='03' ";
                    else if(sub.equals("SVS"))
                        covHabs+= " and a.TYPE_OF_ASSET<>'03' ";
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(covHabs);
                    if (rs1.next()) {
                        habsCov = rs1.getInt(1);
                %>
                <%if((NRDWPCodes.indexOf(rs.getString(4))==-1 || progCode.equals(NRDWPCodes)) && mode.equals("initial") ) {%>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_abstract_drill1.jsp?mode=cHabs&mode1=normal&programmeCode=<%=rs.getString(4)%>&programmeName=<%=rs.getString(3)%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&sub=<%=sub%>')"><%=habsCov%></a></td>
                    <%} else if (mode.equals("subprog")) {%>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_abstract_drill1.jsp?mode=cHabs&mode1=normal&programmeCode=<%=rs.getString(4)%>&programmeName=<%=rs.getString(3)%>&subprogrammeCode=<%=rs.getString(6)%>&subprogrammeName=<%=rs.getString(5)%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&sub=<%=sub%>')"><%=habsCov%></a></td>
                    <%} else if (mode.equals("districts")) {%>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_abstract_drill1.jsp?mode=cHabs&mode1=normal&programmeCode=<%=rs.getString(4)%>&programmeName=<%=rs.getString(3)%>&dcode=<%=rs.getString(6)%>&dname=<%=rs.getString(5)%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&sub=<%=sub%>')"><%=habsCov%></a></td>
                    <%} %>

                <%
                    }
                    stmt1.close();
                    rs1.close();
                %>
                <%
                    String bankLFY = "select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
                            + " and a.programme_code='"
                            + rs.getString(4)
                            + "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and BANK_SEND_DATE<='31-MAR-"
                            + (yearEnd - 1) + "'";
                    bankLFY += " and substr(a.work_id,7,2) not in ('11','12') and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
                    if (mode.equals("subprog")) {
                        bankLFY += " and a.subprogramme_code='" + rs.getString(6) + "'";
                    }
                    if (mode.equals("districts")) {
                        bankLFY += " and substr(a.work_id,5,2)='" + rs.getString(6) + "'";
                    }
                    if(sub.equals("MVS"))
                        bankLFY+= " and a.TYPE_OF_ASSET='03' ";
                    else if(sub.equals("SVS"))
                        bankLFY+= " and a.TYPE_OF_ASSET<>'03' ";
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(bankLFY);
                    if (rs1.next()) {
                        bankLastYear = rs1.getDouble(1);

                    }
                    stmt1.close();
                    rs1.close();

                    String paoFLY = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
                            + " and a.programme_code='"
                            + rs.getString(4)
                            + "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null)  and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and STATE_SEND_DATE<='31-MAR-"
                            + (yearEnd - 1) + "'";
                    paoFLY += " and substr(a.work_id,7,2) not in ('11','12') and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
                    if (mode.equals("subprog")) {
                        paoFLY += " and a.subprogramme_code='" + rs.getString(6) + "'";
                    }
                    if (mode.equals("districts")) {
                        paoFLY += " and substr(a.work_id,5,2)='" + rs.getString(6) + "'";
                    }
                    if(sub.equals("MVS"))
                        paoFLY+= " and a.TYPE_OF_ASSET='03' ";
                    else if(sub.equals("SVS"))
                        paoFLY+= " and a.TYPE_OF_ASSET<>'03' ";
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(paoFLY);
                    if (rs1.next()) {
                        paoLastYear = rs1.getDouble(1);

                    }
                    stmt1.close();
                    rs1.close();

                    String finalamount = ndf
                            .format((bankLastYear + paoLastYear) / 100000);
                    if((NRDWPCodes.indexOf(rs.getString(4))==-1 || progCode.equals(NRDWPCodes) || mode.equals("districts"))  ) {
                %>
                <td class="<%=style%>" style="text-align: right;" align="right"><%=finalamount%></td>

                <%
                    }
                    String bankUptoLastMonth = "select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null "
                            + " and a.programme_code='"
                            + rs.getString(4)
                            + "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and BANK_SEND_DATE>='01-APR-"
                            + yearStart
                            + "' and BANK_SEND_DATE<'01-"
                            + currentMonth + "-" + yearEnd + "'";
                    bankUptoLastMonth += " and substr(a.work_id,7,2) not in ('11','12') and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
                    if (mode.equals("subprog")) {
                        bankUptoLastMonth += " and a.subprogramme_code='" + rs.getString(6) + "'";
                    }
                    if (mode.equals("districts")) {
                        bankUptoLastMonth += " and substr(a.work_id,5,2)='" + rs.getString(6) + "'";
                    }
                    if(sub.equals("MVS"))
                        bankUptoLastMonth+= " and a.TYPE_OF_ASSET='03' ";
                    else if(sub.equals("SVS"))
                        bankUptoLastMonth+= " and a.TYPE_OF_ASSET<>'03' ";
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(bankUptoLastMonth);
                    if (rs1.next()) {
                        bankLastMonth = rs1.getDouble(1);

                    }
                    stmt1.close();
                    rs1.close();

                    String paoUptoLastMonth = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and a.programme_code='"
                            + rs.getString(4)
                            + "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and STATE_SEND_DATE>='01-APR-"
                            + yearStart
                            + "' and STATE_SEND_DATE<'01-"
                            + currentMonth + "-" + yearEnd + "'";
                    paoUptoLastMonth += " and substr(a.work_id,7,2) not in ('11','12') and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
                    if (mode.equals("subprog")) {
                        paoUptoLastMonth += " and a.subprogramme_code='" + rs.getString(6) + "'";
                    }
                    if (mode.equals("districts")) {
                        paoUptoLastMonth += " and substr(a.work_id,5,2)='" + rs.getString(6) + "'";
                    }
                    if(sub.equals("MVS"))
                        paoUptoLastMonth+= " and a.TYPE_OF_ASSET='03' ";
                    else if(sub.equals("SVS"))
                        paoUptoLastMonth+= " and a.TYPE_OF_ASSET<>'03' ";
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(paoUptoLastMonth);
                    if (rs1.next()) {
                        paoLastMonth = rs1.getDouble(1);

                    }
                    stmt1.close();
                    rs1.close();
                    String finalamountUptoLastMonth = ndf
                            .format((bankLastMonth + paoLastMonth) / 100000);
                    if((NRDWPCodes.indexOf(rs.getString(4))==-1 || progCode.equals(NRDWPCodes) || mode.equals("districts")) ) {
                %>
                <td class="<%=style%>" style="text-align: right;" align="right"><%=finalamountUptoLastMonth%></td>

                <%
                    }
                    String bankcurrMonth = "select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null  and a.programme_code='"
                            + rs.getString(4)
                            + "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and BANK_SEND_DATE>='01-"
                            + currentMonth
                            + "-"
                            + cyear
                            + "' and BANK_SEND_DATE<='" + cDate + "'";
                    bankcurrMonth += " and substr(a.work_id,7,2) not in ('11','12') and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
                    if (mode.equals("subprog")) {
                        bankcurrMonth += " and a.subprogramme_code='" + rs.getString(6) + "'";
                    }
                    if (mode.equals("districts")) {
                        bankcurrMonth += " and substr(a.work_id,5,2)='" + rs.getString(6) + "'";
                    }
                    if(sub.equals("MVS"))
                        bankcurrMonth+= " and a.TYPE_OF_ASSET='03' ";
                    else if(sub.equals("SVS"))
                        bankcurrMonth+= " and a.TYPE_OF_ASSET<>'03' ";
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(bankcurrMonth);
                    if (rs1.next()) {
                        bankCurrentMonth = rs1.getDouble(1);

                    }
                    stmt1.close();
                    rs1.close();

                    String paocurrMonth = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and a.programme_code='"
                            + rs.getString(4)
                            + "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null) and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and STATE_SEND_DATE>='01-"
                            + currentMonth
                            + "-"
                            + cyear
                            + "' and STATE_SEND_DATE<='" + cDate + "'";
                    paocurrMonth += " and substr(a.work_id,7,2) not in ('11','12') and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
                    if (mode.equals("subprog")) {
                        paocurrMonth += " and a.subprogramme_code='" + rs.getString(6) + "'";
                    }
                    if (mode.equals("districts")) {
                        paocurrMonth += " and substr(a.work_id,5,2)='" + rs.getString(6) + "'";
                    }
                    if(sub.equals("MVS"))
                        paocurrMonth+= " and a.TYPE_OF_ASSET='03' ";
                    else if(sub.equals("SVS"))
                        paocurrMonth+= " and a.TYPE_OF_ASSET<>'03' ";
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
                    double cexp = ((bankLastYear + paoLastYear + bankLastMonth
                            + paoLastMonth + bankCurrentMonth + paoCurrentMonth) / 100000);
                    double arfc = estCost - cexp;
                    if((NRDWPCodes.indexOf(rs.getString(4))==-1 || progCode.equals(NRDWPCodes) || mode.equals("districts")) ){
                %>
                <td class="<%=style%>" style="text-align: right;" align="right"><%=finalamountCurrentMonth%></td>
                <td class="<%=style%>" style="text-align: right;" align="right"><%=finalTotalFY%></td>
                <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(arfc)%></td>
                <%
                    }
                    String phyCompNotFinWorks = "select count(a.work_id) from rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m,rws_programme_tbl p  where WORK_CANCEL_DT is null "
                            + " and SUBSTR(a.work_id,7,2) not in ('11','12') and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.PROGRAMME_CODE=p.PROGRAMME_CODE  and a.programme_code in ("
                            + rs.getString(4)
                            + ") and b.DATE_OF_COMPLETION is not null and b.DATE_OF_COMPLETION between '01-APR-"
                            + (yearStart - 1)
                            + "' and '31-MAR-"
                            + (yearEnd - 1)
                            + "' and substr(a.work_id,7,2) not in ('11','12') and b.DT_FIN_COMPLETION is null";
                    if (mode.equals("subprog")) {
                        phyCompNotFinWorks += " and a.subprogramme_code='" + rs.getString(6) + "'";
                    }
                    if (mode.equals("districts")) {
                        phyCompNotFinWorks += " and substr(a.work_id,5,2)='" + rs.getString(6) + "'";
                    }
                    phyCompNotFinWorks += " and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
                    if(sub.equals("MVS"))
                        phyCompNotFinWorks+= " and a.TYPE_OF_ASSET='03' ";
                    else if(sub.equals("SVS"))
                        phyCompNotFinWorks+= " and a.TYPE_OF_ASSET<>'03' ";
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(phyCompNotFinWorks);
                    if (rs1.next()) {
                        worksPhyCompNotFin = rs1.getInt(1);
                    }
                    stmt1.close();
                    rs1.close();
                %>

                <%if((NRDWPCodes.indexOf(rs.getString(4))==-1 || progCode.equals(NRDWPCodes)) && mode.equals("initial") ) {%>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_abstract_drill1.jsp?mode=fWorks&programmeCode=<%=rs.getString(4)%>&programmeName=<%=rs.getString(3)%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&sub=<%=sub%>')"><%=worksPhyCompNotFin%></a></td>
                    <%} else if (mode.equals("subprog")) {%>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_abstract_drill1.jsp?mode=fWorks&programmeCode=<%=rs.getString(4)%>&programmeName=<%=rs.getString(3)%>&subprogrammeCode=<%=rs.getString(6)%>&subprogrammeName=<%=rs.getString(5)%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&sub=<%=sub%>')"><%=worksPhyCompNotFin%></a></td>
                    <%} else if (mode.equals("districts")) {%>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_abstract_drill1.jsp?mode=fWorks&programmeCode=<%=rs.getString(4)%>&programmeName=<%=rs.getString(3)%>&dcode=<%=rs.getString(6)%>&dname=<%=rs.getString(5)%>&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&sub=<%=sub%>')"><%=worksPhyCompNotFin%></a></td>
                    <%} %>

                <%
                    String phyCompNotFinExpBANK = "select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m, rws_work_completion_tbl wc where WORK_CANCEL_DT is null "
                            + "  and a.programme_code in ("
                            + rs.getString(4)
                            + ") and SUBSTR(a.work_id,7,2) not in ('11','12') and a.work_id=wc.work_id and wc.DATE_OF_COMPLETION is not null and wc.DATE_OF_COMPLETION between '01-APR-"
                            + (yearStart - 1)
                            + "' and '31-MAR-"
                            + (yearEnd - 1)
                            + "'  and wc.DT_FIN_COMPLETION is null and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and BANK_SEND_DATE<='31-MAR-"
                            + (yearEnd - 1) + "'";
                    if (mode.equals("subprog")) {
                        phyCompNotFinExpBANK += " and a.subprogramme_code='" + rs.getString(6) + "'";
                    }
                    if (mode.equals("districts")) {
                        phyCompNotFinExpBANK += " and substr(a.work_id,5,2)='" + rs.getString(6) + "'";
                    }
                    phyCompNotFinExpBANK += " and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
                    
                    if(sub.equals("MVS"))
                        phyCompNotFinExpBANK+= " and a.TYPE_OF_ASSET='03' ";
                    else if(sub.equals("SVS"))
                        phyCompNotFinExpBANK+= " and a.TYPE_OF_ASSET<>'03' ";
                    
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(phyCompNotFinExpBANK);
                    if (rs1.next()) {
                        bankPhyCompNotFin = rs1.getDouble(1);

                    }
                    stmt1.close();
                    rs1.close();

                    String phyCompNotFinExpPAO = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m, rws_work_completion_tbl wc where WORK_CANCEL_DT is null "
                            + "  and a.programme_code in ("
                            + rs.getString(4)
                            + ") and SUBSTR(a.work_id,7,2) not in ('11','12') and a.work_id=wc.work_id and wc.DATE_OF_COMPLETION is not null and wc.DATE_OF_COMPLETION between '01-APR-"
                            + (yearStart - 1)
                            + "' and '31-MAR-"
                            + (yearEnd - 1)
                            + "' and wc.DT_FIN_COMPLETION is null and b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and STATE_SEND_DATE<='31-MAR-"
                            + (yearEnd) + "'";
                    if (mode.equals("subprog")) {
                        phyCompNotFinExpPAO += " and a.subprogramme_code='" + rs.getString(6) + "'";
                    }
                    if (mode.equals("districts")) {
                        phyCompNotFinExpPAO += " and substr(a.work_id,5,2)='" + rs.getString(6) + "'";
                    }
                    phyCompNotFinExpPAO += " and a.ADMIN_DATE >to_date('01/04/2011','dd/mm/yyyy') and c.GROUNDING_DATE is not null";
                    
                    if(sub.equals("MVS"))
                        phyCompNotFinExpPAO+= " and a.TYPE_OF_ASSET='03' ";
                    else if(sub.equals("SVS"))
                        phyCompNotFinExpPAO+= " and a.TYPE_OF_ASSET<>'03' ";
                    
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(phyCompNotFinExpPAO);
                    if (rs1.next()) {
                        paoPhyCompNotFin = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();

                    String finAmount = ndf
                            .format((bankPhyCompNotFin + paoPhyCompNotFin) / 100000);
                    if((NRDWPCodes.indexOf(rs.getString(4))==-1 || progCode.equals(NRDWPCodes) || mode.equals("districts"))  ) {
                %>
                <td class="<%=style%>" style="text-align: right;" align="right"><%=finAmount%></td>
<%}%>
            </tr>
            <%
                    totNoOfWorks = totNoOfWorks + noOfWorks;
                    totEstCost = totEstCost + estCost;
                    totHabsSanctioned = totHabsSanctioned + habsSanctioned;
                    totWorksComp = totWorksComp + worksComp;
                    totHabsCov = totHabsCov + habsCov;
                    totExpUptoLFY = totExpUptoLFY + bankLastYear + paoLastYear;
                    totExpUptoLM = totExpUptoLM + bankLastMonth + paoLastMonth;
                    totExpDM = totExpDM + bankCurrentMonth + paoCurrentMonth;
                    totTotExp = totExpUptoLM + totExpDM;
                    totarfc = totarfc + arfc;
                    totWorksPhyCompNotFin = totWorksPhyCompNotFin
                            + worksPhyCompNotFin;
                    totExpPhyCompNotFin = totExpPhyCompNotFin
                            + bankPhyCompNotFin + paoPhyCompNotFin;
                    if(NRDWPCodes.indexOf(rs.getString(4))!=-1&& mode.equals("initial") && progCode.length() > NRDWPCodes.length())
                    {
                            codesToSend += rs.getString(4)+",";
                            nrdwpNoOfWorks = nrdwpNoOfWorks + noOfWorks;
                            nrdwpEstCost = nrdwpEstCost + estCost;
                            nrdwpHabsSanctioned = nrdwpHabsSanctioned + habsSanctioned;
                            nrdwpWorksComp = nrdwpWorksComp + worksComp;
                            nrdwpHabsCov = nrdwpHabsCov + habsCov;
                            nrdwpExpUptoLFY = nrdwpExpUptoLFY + bankLastYear + paoLastYear;
                            nrdwpExpUptoLM = nrdwpExpUptoLM + bankLastMonth + paoLastMonth;
                            nrdwpExpDM = nrdwpExpDM + bankCurrentMonth + paoCurrentMonth;
                            nrdwpTotExp = nrdwpTotExp + totExpDM;
                            nrdwparfc = nrdwparfc + arfc;
                            nrdwpWorksPhyCompNotFin = nrdwpWorksPhyCompNotFin + worksPhyCompNotFin;
                            nrdwpTotExpPhyCompNotFin = nrdwpTotExpPhyCompNotFin
                                    + bankPhyCompNotFin + paoPhyCompNotFin;
                    }
                }
                if(codesToSend.length()>0)
                {
                 codesToSend = codesToSend.substring(0,codesToSend.length()-1);
                }
                stmt.close();
                rs.close();
                if (slno == 0) {
            %>
            <tr>
                <td colspan="12" class="<%=style%>" style="text-align: center;">NO Records Found</td>
            </tr>
            <%
                }
System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%progCode:"+progCode+", NRDWPCodes:"+NRDWPCodes);
if(mode.equals("initial") && progCode.length() > NRDWPCodes.length())
{
           
            %>
            
            <tr>
                <td class="<%=style%>" style="text-align: right;"><%=++slno%></td>
                <td class="<%=style%>" style="text-align: left;"><a href="./rws_work_progress_abstract_list1.jsp?mode=initial&program=<%=NRDWPCodes%>_@_NRDWP&finyear=<%=finyear%>&sub=<%=sub%>">NRDWP</a></td>
                <td class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_work_progress_abstract_drill1.jsp?mode=tWorks&programmeCode=<%=codesToSend%>&programmeName=NRDWP&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&sub=<%=sub%>')"><%=nrdwpNoOfWorks%></a></td>
                <td class="<%=style%>" style="text-align: right;"><%=ndf.format(nrdwpEstCost)%></td>
                <td class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_work_progress_abstract_drill1.jsp?mode=sHabs&mode1=normal&programmeCode=<%=NRDWPCodes%>&programmeName=NRDWP&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&sub=<%=sub%>')"><%=nrdwpHabsSanctioned%></a></td>
                <td class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_work_progress_abstract_drill1.jsp?mode=cWorks&programmeCode=<%=codesToSend%>&programmeName=NRDWP&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&sub=<%=sub%>')"><%=nrdwpWorksComp%></a></td>
                <td class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_work_progress_abstract_drill1.jsp?mode=cHabs&mode1=normal&programmeCode=<%=codesToSend%>&programmeName=NRDWP&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&sub=<%=sub%>')"><%=nrdwpHabsCov%></a></td>
                <td class="<%=style%>" style="text-align: right;"><%=ndf.format(nrdwpExpUptoLFY / 100000)%></td>
                <td class="<%=style%>" style="text-align: right;"><%=ndf.format(nrdwpExpUptoLM / 100000)%></td>
                <td class="<%=style%>" style="text-align: right;"><%=ndf.format(nrdwpExpDM / 100000)%></td>
                <td class="<%=style%>" style="text-align: right;"><%=ndf.format(nrdwpTotExp / 100000)%></td>
                <td class="<%=style%>" style="text-align: right;"><%=ndf.format(nrdwparfc)%></td>
                <td class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_work_progress_abstract_drill1.jsp?mode=fWorks&programmeCode=<%=codesToSend%>&programmeName=NRDWP&yearStart=<%=yearStart%>&yearEnd=<%=yearEnd%>&sub=<%=sub%>')"><%=nrdwpWorksPhyCompNotFin%></a></td>
                <td class="<%=style%>" style="text-align: right;"><%=ndf.format(nrdwpTotExpPhyCompNotFin / 100000)%></td>
            </tr>
 <%
 }
 %>
            <tr class="rightPad">
                <td class="btext" style="text-align: right;" colspan=2>Total:</td>
                <td class="btext" style="text-align: right;"><%=totNoOfWorks%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totEstCost)%></td>
                <td class="btext" style="text-align: right;"><%=totHabsSanctioned%></td>
                <td class="btext" style="text-align: right;"><%=totWorksComp%></td>
                <td class="btext" style="text-align: right;"><%=totHabsCov%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totExpUptoLFY / 100000)%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totExpUptoLM / 100000)%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totExpDM / 100000)%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totTotExp / 100000)%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totarfc)%></td>
                <td class="btext" style="text-align: right;"><%=totWorksPhyCompNotFin%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totExpPhyCompNotFin / 100000)%></td>
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
</BODY>

