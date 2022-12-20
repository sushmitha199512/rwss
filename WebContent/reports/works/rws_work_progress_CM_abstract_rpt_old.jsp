
<%@page import="nic.watersoft.works.WorksData1"%>
<%@page import="java.sql.Connection"%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/reports/conn.jsp"%>
<%    DecimalFormat ndf = new DecimalFormat("####.00");


	String InputWorkProStr="";
	HashMap programmeName = new HashMap();
	int count = 1;
    String sub = "ALL";
    String mode = "initial";

    if (request.getParameter("sub") != null) {
        sub = (String) request.getParameter("sub");
    }
    if (request.getParameter("mode") != null) {
        mode = request.getParameter("mode");
    }

    String pcd = request.getParameter("pc");
    String pcn = request.getParameter("pn");
    String coc = request.getParameter("coc");
    String con = request.getParameter("con");
    String doc = request.getParameter("doc");
    String don = request.getParameter("don");
    
    String programe = "";
    String programName = "";
 
    String progCode = "";
    String CmDBCodes ="";
    String NRDWPCodes = "";
    String codesToSend = "";
    String nrdwpQuery = "select PROGRAMME_CODE from  rws_programme_tbl where NRDWP_RELATED='Y' order by 1";
    Statement stmtNRDWP = conn.createStatement();
    ResultSet rsNRDWP = stmtNRDWP.executeQuery(nrdwpQuery);
    while (rsNRDWP.next()) {
        NRDWPCodes += rsNRDWP.getString(1) + ",";
    }
    String CmDBQuery = "select PROGRAMME_CODE from  rws_programme_tbl where CM_CORE_DB='Y' and NRDWP_RELATED='N' order by PROGRAMME_NAME";
    Statement stmtCmDB = conn.createStatement();
    ResultSet rsCmDB = stmtCmDB.executeQuery(CmDBQuery);
    while (rsCmDB.next()) {
    	CmDBCodes += rsCmDB.getString(1) +",";
    }
   System.out.println(CmDBCodes);
    
    CmDBCodes =CmDBCodes.substring(0, CmDBCodes.length() - 1);
    NRDWPCodes = NRDWPCodes.substring(0, NRDWPCodes.length() - 1);
    if (request.getParameter("pc") != null && !((String) request.getParameter("pc")).equals("null") && !((String) request.getParameter("pc")).equals("")) {
        progCode = request.getParameter("pc");
        programName = request.getParameter("pn");
    } else {
        programName = "ALL";
        progCode = NRDWPCodes+","+CmDBCodes;
    }
    //System.out.println(progCode);
    String schemes = "'01','02','03'";
    programe = progCode;


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
    String ye=""+yearEnd;
    ye=ye.substring(2,4).toString();
    
    int yEnd=Integer.parseInt(ye);
    
    String InputPhyFinStr="";
    HashMap ongoingWorks = new HashMap();
	HashMap completedWorks = new HashMap();
	HashMap progMap = new HashMap();
	
	HashMap sanctionedHabs = new HashMap();
	HashMap coveredHabs = new HashMap();
	
	HashMap estimatedCost = new HashMap();
	HashMap expenditure = new HashMap();
	HashMap balanceEstimatedCost = new HashMap();
	
	String names="";

%>

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

<BODY>
    <br/>
    <br/>
    <form name=f1 id="f1" method="post" action="rws_work_progress_abstract_list1.jsp">
        <center>
            <font color="#663899" face="Maiandra GD" size="4px"><b>Works Progress - Physical & Financial</b></font>
            <br/><br/><font color="#889900" face="Maiandra GD" size="3px"  >Programme: <%=programName%>
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

        <br/><br/>
        <%
			if (!mode.equals("initial") ) {
		%>
		<table align="center"
			style="margin-top: -35px !important; width: 1050px !important; text-align: center !important;">
			<tr>
				<td style="width: 950px !important;"></td>
				<td style="width: 100px !important;" align="right"><a
					href="javascript:history.back(-1)"><img	src="/pred/resources/graphs/go_back.gif" height="30px" /></a>&nbsp;&nbsp;
				</td>
			</tr>
		</table>
		<%
			} else {
		%>
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
		<%
			}
		%>
		<br/><br/>
        <table border=1 cellspacing=0 cellpadding=0 height=5% width="1000px" class="baseTable"
               bordercolor=#000000 style="border-collapse: collapse; margin-top: -15px !important; "
               bgcolor="#ffffff" align="center">
            <tr align=center align=center class="thead">
                <td class=btext rowspan=3>SNO</td>
                <%if (mode.equals("cir")) {
                %>
                <td class=btext rowspan=3>Circle</td>
                <% } else if (mode.equals("div")) {%>
                <td class=btext rowspan=3>Division</td>
                <%} else if (mode.equals("sdiv")) {%>
                <td class=btext rowspan=3>Sub Division</td>
                <%} else {%>
                <td class=btext rowspan=3>Program</td>
                <%}%>
                <td class=btext rowspan=3>No. of<br/>Works</td>
                <td class=btext rowspan=3>Est. Cost</td>
                <td class=btext rowspan=3>Habs<br/>Sanc.</td>
                <td class=btext rowspan=3>Pop<br/>Benefited</td>
                <td class=btext colspan=3>Physical Progress</td>
                <td class=btext colspan=5>Financial Progress</td>
                <td class=btext colspan=2>Balance Program</td>
            </tr>
            <tr>
                <td class=btext align="center" rowspan=2>Works<br/>Comp.</td>
                <td class=btext align="center" rowspan=2>Habs<br/>Covered</td>
                <td class=btext align="center" rowspan=2>Pop<br/>Covered</td>
                <td class=btext align="center" rowspan=2>Expenditure<br/>Upto<br/><%=(yearStart - 1)%>-<%=(yEnd - 1)%></td>
                <td class=btext align="center" colspan=3>During the Current Year</td>
                <td class=btext align="center" rowspan=2>Total Exp<br/>Including<br/>Phy Comp But<br/>Fin. Not Comp Works</td>
                <td class=btext align="center" rowspan=2>Works</td>
                <td class=btext align="center" rowspan=2>ARFC</td>
            </tr>
            <tr>
            	<td class=btext align="center" >Upto Last Month<br/><font size="1px"><i>(<%=lastMonth%>)</i></font></td>
                <td class=btext align="center" >Current Month<br/> <font size="1px"><i>(<%=currentMonth%>-<%=cyear%>)</i></font></td>
                <td class=btext align="center" >Total Exp. During <br/><%=yearStart%>-<%=yEnd%></td>
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
                    long totPopBenf = 0, totPopCov = 0, popBenf = 0, popCov = 0, nrdwpPopBenf = 0, nrdwpPopCov = 0;
                    int nrdwpNoOfWorks = 0, nrdwpHabsSanctioned = 0, nrdwpWorksComp = 0, nrdwpHabsCov = 0, nrdwpWorksPhyCompNotFin = 0;
                    double totarfc = 0, totEstCost = 0, totExpUptoLFY = 0, totExpUptoLM = 0, totExpDM = 0, totTotExp = 0, expPhyCompNotFin = 0, bankPhyCompNotFin = 0, paoPhyCompNotFin = 0, totExpPhyCompNotFin = 0, totalAmtInclPhyCompNotFin = 0;
                    double arfc = 0, nrdwparfc = 0, nrdwpEstCost = 0, nrdwpExpUptoLFY = 0, nrdwpExpUptoLM = 0, nrdwpExpDM = 0, nrdwpTotExp = 0, nrdwpExpPhyCompNotFin = 0, nrdwpBankPhyCompNotFin = 0, nrdwpPaoPhyCompNotFin = 0, nrdwpTotExpPhyCompNotFin = 0, nrdwpAmtInclPhyCompNotFin = 0;
                    String query = "";

                 /*   if (mode.equals("initial")) {
                        query = "select sum(a.SANCTION_AMOUNT),count(a.work_id),p.PROGRAMME_NAME,a.programme_code from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"
                                + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and c.GROUNDING_DATE is not null and a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programe + ") "
                                + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                + "and target_date_comp>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id "
                                + "and a.TYPE_OF_ASSET in (" + schemes + ") and c.CORE_DASHBOARD_STATUS<>'N' ";
                        query += " group by p.PROGRAMME_NAME,a.programme_code  "
                                + "order by p.PROGRAMME_NAME";
                    } else if (mode.equals("cir")) {
                        query = "select sum(a.SANCTION_AMOUNT),count(a.work_id),cir.CIRCLE_OFFICE_NAME,cir.CIRCLE_OFFICE_CODE from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"
                                + "rws_contractor_selection_tbl m, rws_circle_office_tbl cir where WORK_CANCEL_DT is null and c.GROUNDING_DATE is not null and a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programe + ") "
                                + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                + "and target_date_comp>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id "
                                + "and a.TYPE_OF_ASSET in (" + schemes + ") and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)=cir.CIRCLE_OFFICE_CODE group by cir.CIRCLE_OFFICE_NAME,cir.CIRCLE_OFFICE_CODE  order by cir.CIRCLE_OFFICE_CODE";
                    } else if (mode.equals("div")) {
                        query = "select sum(a.SANCTION_AMOUNT),count(a.work_id),div.DIVISION_OFFICE_NAME,div.DIVISION_OFFICE_CODE from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"
                                + "rws_contractor_selection_tbl m, rws_circle_office_tbl cir, rws_division_office_tbl div where WORK_CANCEL_DT is null and c.GROUNDING_DATE is not null and a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programe + ") "
                                + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                + "and target_date_comp>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id "
                                + "and a.TYPE_OF_ASSET in (" + schemes + ") and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)=cir.CIRCLE_OFFICE_CODE  and SUBSTR(a.OFFICE_CODE,4,1)=div.DIVISION_OFFICE_CODE "
                                + "and div.CIRCLE_OFFICE_CODE = cir.CIRCLE_OFFICE_CODE and div.CIRCLE_OFFICE_CODE='" + request.getParameter("coc") + "' group by div.DIVISION_OFFICE_NAME,div.DIVISION_OFFICE_CODE,div.CIRCLE_OFFICE_CODE  order by div.DIVISION_OFFICE_CODE";
                    } else if (mode.equals("sdiv")) {
                        query = "select sum(a.SANCTION_AMOUNT),count(a.work_id),sdiv.SUBDIVISION_OFFICE_NAME,sdiv.SUBDIVISION_OFFICE_CODE from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"
                                + "rws_contractor_selection_tbl m, rws_circle_office_tbl cir, rws_division_office_tbl div, rws_subdivision_office_tbl sdiv where WORK_CANCEL_DT is null and c.GROUNDING_DATE is not null and a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programe + ") "
                                + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                + "and target_date_comp>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id "
                                + "and a.TYPE_OF_ASSET in (" + schemes + ") and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)=cir.CIRCLE_OFFICE_CODE  and SUBSTR(a.OFFICE_CODE,4,1)=div.DIVISION_OFFICE_CODE "
                                + "and div.CIRCLE_OFFICE_CODE = cir.CIRCLE_OFFICE_CODE and SUBSTR(a.OFFICE_CODE,5,2)=sdiv.SUBDIVISION_OFFICE_CODE and sdiv.CIRCLE_OFFICE_CODE=cir.CIRCLE_OFFICE_CODE and sdiv.DIVISION_OFFICE_CODE=div.DIVISION_OFFICE_CODE "
                                + "and sdiv.CIRCLE_OFFICE_CODE='" + request.getParameter("coc") + "' and sdiv.DIVISION_OFFICE_CODE='" + request.getParameter("doc") + "' group by sdiv.SUBDIVISION_OFFICE_NAME,sdiv.SUBDIVISION_OFFICE_CODE,sdiv.DIVISION_OFFICE_CODE,sdiv.CIRCLE_OFFICE_CODE  order by sdiv.SUBDIVISION_OFFICE_CODE";
                    }  */
                 if (mode.equals("initial")) {
                        query = "select sum(a.SANCTION_AMOUNT),count(a.work_id),p.PROGRAMME_NAME,a.programme_code from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"
                                + "rws_contractor_selection_tbl m where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programe + ") "
                                + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                + "and target_date_comp>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
                                + "and a.TYPE_OF_ASSET in (" + schemes + ") and c.CORE_DASHBOARD_STATUS<>'N' ";
                        query += " group by p.PROGRAMME_NAME,a.programme_code  "
                                + "order by p.PROGRAMME_NAME";
                    } else if (mode.equals("cir")) {
                        query = "select sum(a.SANCTION_AMOUNT),count(a.work_id),cir.CIRCLE_OFFICE_NAME,cir.CIRCLE_OFFICE_CODE from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"
                                + "rws_contractor_selection_tbl m, rws_circle_office_tbl cir where WORK_CANCEL_DT is null and   a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programe + ") "
                                + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                + "and target_date_comp>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  "
                                + "and a.TYPE_OF_ASSET in (" + schemes + ") and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)=cir.CIRCLE_OFFICE_CODE group by cir.CIRCLE_OFFICE_NAME,cir.CIRCLE_OFFICE_CODE  order by cir.CIRCLE_OFFICE_CODE";
                    } else if (mode.equals("div")) {
                        query = "select sum(a.SANCTION_AMOUNT),count(a.work_id),div.DIVISION_OFFICE_NAME,div.DIVISION_OFFICE_CODE from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"
                                + "rws_contractor_selection_tbl m, rws_circle_office_tbl cir, rws_division_office_tbl div where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programe + ") "
                                + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                + "and target_date_comp>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
                                + "and a.TYPE_OF_ASSET in (" + schemes + ") and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)=cir.CIRCLE_OFFICE_CODE  and SUBSTR(a.OFFICE_CODE,4,1)=div.DIVISION_OFFICE_CODE "
                                + "and div.CIRCLE_OFFICE_CODE = cir.CIRCLE_OFFICE_CODE and div.CIRCLE_OFFICE_CODE='" + request.getParameter("coc") + "' group by div.DIVISION_OFFICE_NAME,div.DIVISION_OFFICE_CODE,div.CIRCLE_OFFICE_CODE  order by div.DIVISION_OFFICE_CODE";
                    } else if (mode.equals("sdiv")) {
                        query = "select sum(a.SANCTION_AMOUNT),count(a.work_id),sdiv.SUBDIVISION_OFFICE_NAME,sdiv.SUBDIVISION_OFFICE_CODE from rws_work_admn_tbl a,rws_programme_tbl p,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,"
                                + "rws_contractor_selection_tbl m, rws_circle_office_tbl cir, rws_division_office_tbl div, rws_subdivision_office_tbl sdiv where WORK_CANCEL_DT is null and  a.programme_code=p.PROGRAMME_CODE and a.programme_code in (" + programe + ") "
                                + "and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                + "and target_date_comp>='01-APR-" + yearStart + "' and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id "
                                + "and a.TYPE_OF_ASSET in (" + schemes + ") and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)=cir.CIRCLE_OFFICE_CODE  and SUBSTR(a.OFFICE_CODE,4,1)=div.DIVISION_OFFICE_CODE "
                                + "and div.CIRCLE_OFFICE_CODE = cir.CIRCLE_OFFICE_CODE and SUBSTR(a.OFFICE_CODE,5,2)=sdiv.SUBDIVISION_OFFICE_CODE and sdiv.CIRCLE_OFFICE_CODE=cir.CIRCLE_OFFICE_CODE and sdiv.DIVISION_OFFICE_CODE=div.DIVISION_OFFICE_CODE "
                                + "and sdiv.CIRCLE_OFFICE_CODE='" + request.getParameter("coc") + "' and sdiv.DIVISION_OFFICE_CODE='" + request.getParameter("doc") + "' group by sdiv.SUBDIVISION_OFFICE_NAME,sdiv.SUBDIVISION_OFFICE_CODE,sdiv.DIVISION_OFFICE_CODE,sdiv.CIRCLE_OFFICE_CODE  order by sdiv.SUBDIVISION_OFFICE_CODE";
                    } 
                   // System.out.println("test query is :" +query);

                
                    stmt = conn.createStatement();
                    rs = stmt.executeQuery(query);

                    while (rs.next()) {
                    	
                        	names+=rs.getString(3)+",";
                        
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
                        if (NRDWPCodes.indexOf(rs.getString(4)) == -1 || !mode.equals("initial")) {
            %>
            <tr>
                <td class="<%=style%>" style="text-align: right;" align="right"><%=++slno%></td>

                <%
                    if (mode.equals("initial")) {
                    	
                    	programmeName.put(count,rs.getString(3));
                    	
                %>
                <td class="<%=style%>" style="text-align: left;" align="right"><a href="rws_work_progress_CM_abstract_rpt.jsp?mode=cir&pc=<%=rs.getString(4)%>&pn=<%=rs.getString(3)%>"><%=rs.getString(3)%></a></td>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=tWorks&pc=<%=rs.getString(4)%>&pn=<%=rs.getString(3)%>')"><%=noOfWorks%></a></td>
                
                    <%
                    } else if (mode.equals("cir")) {
                    %>
                <td class="<%=style%>" style="text-align: left;" align="right"><a href="rws_work_progress_CM_abstract_rpt.jsp?mode=div&coc=<%=rs.getString(4)%>&con=<%=rs.getString(3)%>&pc=<%=request.getParameter("pc")%>&pn=<%=request.getParameter("pn")%>"><%=rs.getString(3)%></a></td>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=tWorks&coc=<%=rs.getString(4)%>&con=<%=rs.getString(3)%>&pc=<%=pcd%>&pn=<%=pcn%>')"><%=noOfWorks%></a></td>
                    <%
                    } else if (mode.equals("div")) {
                    %>
                <td class="<%=style%>" style="text-align: left;" align="right"><a href="rws_work_progress_CM_abstract_rpt.jsp?mode=sdiv&doc=<%=rs.getString(4)%>&don=<%=rs.getString(3)%>&coc=<%=request.getParameter("coc")%>&pc=<%=request.getParameter("pc")%>&pn=<%=request.getParameter("pn")%>"><%=rs.getString(3)%></a></td>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=tWorks&doc=<%=rs.getString(4)%>&don=<%=rs.getString(3)%>&coc=<%=coc%>&con=<%=con%>&pc=<%=pcd%>&pn=<%=pcn%>')"><%=noOfWorks%></a></td>
                    <%
                    } else if (mode.equals("sdiv")) {
                    %>
                <td class="<%=style%>" style="text-align: left;" align="right"><%=rs.getString(3)%></td>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=tWorks&soc=<%=rs.getString(4)%>&son=<%=rs.getString(3)%>&coc=<%=coc%>&con=<%=con%>&doc=<%=doc%>&don=<%=don%>&pc=<%=pcd%>&pn=<%=pcn%>')"><%=noOfWorks%></a></td>
                <%
                    }
                %>

                <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(estCost) %></td>
                <%
                    }
                    String sacHabs = "";

                   /* if (mode.equals("initial")) {
                        sacHabs = "select count(b.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                + ", rws_habitation_directory_tbl hd where hd.hab_code=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                + "and target_date_comp>='01-APR-" + yearStart + "' and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  "
                                + "and a.programme_code in ('" + rs.getString(4) + "') and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N'";
                    } else if (mode.equals("cir")) {
                        sacHabs = "select count(b.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                + ", rws_habitation_directory_tbl hd where hd.hab_code=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                + "and target_date_comp>='01-APR-" + yearStart + "' and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in (" + programe + ") "
                                + " and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)='" + rs.getString(4) + "'";
                    } else if (mode.equals("div")) {
                        sacHabs = "select count(b.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                + ", rws_habitation_directory_tbl hd where hd.hab_code=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                + "and target_date_comp>='01-APR-" + yearStart + "' and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in (" + programe + ") "
                                + " and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)='" + request.getParameter("coc") + "'  and SUBSTR(a.OFFICE_CODE,4,1)='" + rs.getString(4) + "'";
                    } else if (mode.equals("sdiv")) {
                        sacHabs = "select count(b.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                + ", rws_habitation_directory_tbl hd where hd.hab_code=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                + "and target_date_comp>='01-APR-" + yearStart + "' and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and a.programme_code in (" + programe + ") "
                                + "and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)='" + request.getParameter("coc") + "'  and SUBSTR(a.OFFICE_CODE,4,1)='" + request.getParameter("doc") + "' and SUBSTR(a.OFFICE_CODE,5,2)='" + rs.getString(4) + "'";
                    }  */

              if (mode.equals("initial")) {
                        sacHabs = "select count(distinct b.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                + ", rws_habitation_directory_tbl hd,rws_district_tbl dist, rws_mandal_tbl mdl, rws_panchayat_tbl panch, rws_village_tbl vill, rws_panchayat_raj_tbl habs  where  hd.hab_code=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                + "and target_date_comp>='01-APR-" + yearStart + "' and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id   "
                                + "and a.programme_code in ('" + rs.getString(4) + "') and a.TYPE_OF_ASSET in (" + schemes + ") and c.CORE_DASHBOARD_STATUS<>'N' and COVERAGE_STATUS<>'UI' and b.hab_code=habs.PANCH_CODE and dist.dcode=SUBSTR(habs.PANCH_CODE,1,2) and mdl.mcode=SUBSTR(habs.PANCH_CODE,6,2) "
                                        + "and panch.pcode=SUBSTR(habs.PANCH_CODE,13,2) and vill.vcode=SUBSTR(habs.PANCH_CODE,8,3) and mdl.dcode=dist.dcode and panch.dcode=mdl.dcode "
                                        + "and panch.mcode=mdl.mcode and vill.dcode=panch.dcode and vill.mcode=panch.mcode and vill.pcode=panch.pcode";
            	 } else if (mode.equals("cir")) {
                	   sacHabs = "select count(distinct b.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                + ", rws_habitation_directory_tbl hd,rws_panchayat_raj_tbl p where hd.hab_code=p.panch_code and hd.hab_code=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                + "and target_date_comp>='01-APR-" + yearStart + "' and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id   and a.programme_code in (" + programe + ") "
                                + " and a.TYPE_OF_ASSET in (" + schemes + ") and  c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)='" + rs.getString(4) + "'  and b.hab_code=habs.PANCH_CODE and COVERAGE_STATUS<>'UI' and dist.dcode=SUBSTR(habs.PANCH_CODE,1,2) and mdl.mcode=SUBSTR(habs.PANCH_CODE,6,2) "
                                        + "and panch.pcode=SUBSTR(habs.PANCH_CODE,13,2) and vill.vcode=SUBSTR(habs.PANCH_CODE,8,3) and mdl.dcode=dist.dcode and panch.dcode=mdl.dcode "
                                        + "and panch.mcode=mdl.mcode and vill.dcode=panch.dcode and vill.mcode=panch.mcode and vill.pcode=panch.pcode";
                    } else if (mode.equals("div")) {
                        sacHabs = "select count(distinct b.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                + ", rws_habitation_directory_tbl hd,rws_panchayat_raj_tbl p where hd.hab_code=p.panch_code and hd.hab_code=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                + "and target_date_comp>='01-APR-" + yearStart + "' and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id and a.programme_code in (" + programe + ") and COVERAGE_STATUS<>'UI'"
                                + " and a.TYPE_OF_ASSET in (" + schemes + ") and  c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)='" + request.getParameter("coc") + "'  and SUBSTR(a.OFFICE_CODE,4,1)='" + rs.getString(4) + "'  and b.hab_code=habs.PANCH_CODE and dist.dcode=SUBSTR(habs.PANCH_CODE,1,2) and mdl.mcode=SUBSTR(habs.PANCH_CODE,6,2) "
                                        + "and panch.pcode=SUBSTR(habs.PANCH_CODE,13,2) and vill.vcode=SUBSTR(habs.PANCH_CODE,8,3) and mdl.dcode=dist.dcode and panch.dcode=mdl.dcode "
                                        + "and panch.mcode=mdl.mcode and vill.dcode=panch.dcode and vill.mcode=panch.mcode and vill.pcode=panch.pcode";
                    } else if (mode.equals("sdiv")) {
                        sacHabs = "select count(distinct b.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from rws_work_admn_tbl a,RWS_ADMN_HAB_LNK_TBL b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                + ", rws_habitation_directory_tbl hd,rws_panchayat_raj_tbl p where hd.hab_code=p.panch_code and hd.hab_code=b.hab_code and WORK_CANCEL_DT is null and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                + "and target_date_comp>='01-APR-" + yearStart + "' and  b.work_id=a.work_id and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id(+)=a.work_id  and a.programme_code in (" + programe + ") and COVERAGE_STATUS<>'UI'"
                                + "and a.TYPE_OF_ASSET in (" + schemes + ") and  c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)='" + request.getParameter("coc") + "'  and SUBSTR(a.OFFICE_CODE,4,1)='" + request.getParameter("doc") + "' and SUBSTR(a.OFFICE_CODE,5,2)='" + rs.getString(4) + "' and b.hab_code=habs.PANCH_CODE and dist.dcode=SUBSTR(habs.PANCH_CODE,1,2) and mdl.mcode=SUBSTR(habs.PANCH_CODE,6,2) "
                                + "and panch.pcode=SUBSTR(habs.PANCH_CODE,13,2) and vill.vcode=SUBSTR(habs.PANCH_CODE,8,3) and mdl.dcode=dist.dcode and panch.dcode=mdl.dcode "
                                + "and panch.mcode=mdl.mcode and vill.dcode=panch.dcode and vill.mcode=panch.mcode and vill.pcode=panch.pcode";
                    } 

                 // System.out.println("sanctioned habs"+sacHabs);
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(sacHabs);
                    if (rs1.next()) {
                        habsSanctioned = rs1.getInt(1); 
                        popBenf = rs1.getLong(2);
                        if (NRDWPCodes.indexOf(rs.getString(4)) == -1 || !mode.equals("initial")) {
                            if (mode.equals("initial")) {
                        %>
                        <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=sHabs&pc=<%=rs.getString(4)%>&pn=<%=rs.getString(3)%>')"><%=habsSanctioned%></a></td>
                            <%
                            } else if (mode.equals("cir")) {
                            %>
                        <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=sHabs&coc=<%=rs.getString(4)%>&con=<%=rs.getString(3)%>&pc=<%=pcd%>&pn=<%=pcn%>')"><%=habsSanctioned%></a></td>
                            <%
                            } else if (mode.equals("div")) {
                            %>
                        <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=sHabs&doc=<%=rs.getString(4)%>&don=<%=rs.getString(3)%>&coc=<%=coc%>&con=<%=con%>&pc=<%=pcd%>&pn=<%=pcn%>')"><%=habsSanctioned%></a></td>
                            <%
                            } else if (mode.equals("sdiv")) {
                            %>
                        <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=sHabs&soc=<%=rs.getString(4)%>&son=<%=rs.getString(3)%>&coc=<%=coc%>&con=<%=con%>&doc=<%=doc%>&don=<%=don%>&pc=<%=pcd%>&pn=<%=pcn%>')"><%=habsSanctioned%></a></td>
                        <%
                            }
                        %>
                

                <td class="<%=style%>" style="text-align: right;" align="right"><%=popBenf%></td>
                <%
                        }
                    }
                    stmt1.close();
                    rs1.close();
                %>

                <%
                    String compWorks = "";
                if (mode.equals("initial")) {
                	compWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                            + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and "
                            + "a.programme_code='" + rs.getString(4) + "'  and b.DATE_OF_COMPLETION between '01-APR-" + yearStart + "' and '31-MAR-" + yearEnd + "' and b.DATE_OF_COMPLETION is not null and "
                            + " target_date_comp>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N'";
                } else if (mode.equals("cir")) {
                	compWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                            + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and "
                            + "a.programme_code in (" + programe + ")  and b.DATE_OF_COMPLETION between '01-APR-" + yearStart + "' and '31-MAR-" + yearEnd + "' and b.DATE_OF_COMPLETION is not null and "
                            + " target_date_comp>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)='" + rs.getString(4) + "'";
                } else if (mode.equals("div")) {
                	compWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                            + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and "
                            + "a.programme_code in (" + programe + ")  and b.DATE_OF_COMPLETION between '01-APR-" + yearStart + "' and '31-MAR-" + yearEnd + "' and b.DATE_OF_COMPLETION is not null and "
                            + " target_date_comp>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)='" + request.getParameter("coc") + "'  and SUBSTR(a.OFFICE_CODE,4,1)='" + rs.getString(4) + "'";
                } else if (mode.equals("sdiv")) {
                	compWorks = "select count(distinct a.work_id),count(h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                            + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and "
                            + "a.programme_code in (" + programe + ")  and b.DATE_OF_COMPLETION between '01-APR-" + yearStart + "' and '31-MAR-" + yearEnd + "' and b.DATE_OF_COMPLETION is not null and "
                            + " target_date_comp>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)='" + request.getParameter("coc") + "'  and SUBSTR(a.OFFICE_CODE,4,1)='" + request.getParameter("doc") + "' and SUBSTR(a.OFFICE_CODE,5,2)='" + rs.getString(4) + "'";
                }

                    
                   // System.out.println("COMPLTE habs"+compWorks);
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(compWorks);

                    if (rs1.next()) {
                        worksComp = rs1.getInt(1);
                       /*  habsCov = rs1.getInt(2);
                        popCov = rs1.getLong(3); */
                        
                        if (NRDWPCodes.indexOf(rs.getString(4)) == -1 || !mode.equals("initial")) {
                        	InputPhyFinStr += "[" + noOfWorks + "," + worksComp + ","+(noOfWorks-worksComp)+"],";
                        if (mode.equals("initial")) {
                        	
                        	                       	
                        	ongoingWorks.put(rs.getString(4), noOfWorks);
                        	completedWorks.put(rs.getString(4), worksComp);
                        	progMap.put(rs.getString(4), rs.getString(3));
                        	
                        	sanctionedHabs.put(rs.getString(4), habsSanctioned);
                        
                        	
                        	
                        %>
                        <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=cWorks&pc=<%=rs.getString(4)%>&pn=<%=rs.getString(3)%>')"><%=worksComp%></a></td>
                        
                            <%
                            } else if (mode.equals("cir")) {
                            %>
                        <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=cWorks&coc=<%=rs.getString(4)%>&con=<%=rs.getString(3)%>&pc=<%=pcd%>&pn=<%=pcn%>')"><%=worksComp%></a></td>
                        
                            <%
                            } else if (mode.equals("div")) {
                            %>
                        <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=cWorks&doc=<%=rs.getString(4)%>&don=<%=rs.getString(3)%>&coc=<%=coc%>&con=<%=con%>&pc=<%=pcd%>&pn=<%=pcn%>')"><%=worksComp%></a></td>
                        
                            <%
                            } else if (mode.equals("sdiv")) {
                            %>
                        <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=cWorks&soc=<%=rs.getString(4)%>&son=<%=rs.getString(3)%>&coc=<%=coc%>&con=<%=con%>&doc=<%=doc%>&don=<%=don%>&pc=<%=pcd%>&pn=<%=pcn%>')"><%=worksComp%></a></td>
                                                <%
                            }
                        %>

                <%
                        }
                    }
                    stmt1.close();
                    rs1.close();
                %>
                <%
                    String comphabs = "";
                if (mode.equals("initial")) {
                	comphabs = "select count(distinct h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                            + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and "
                            + "a.programme_code='" + rs.getString(4) + "'  and ((b.DATE_OF_COMPLETION >= '01-APR-" + yearStart +"' and b.DATE_OF_COMPLETION is not null) OR (b.partial_date_of_completion is not null and b.DATE_OF_COMPLETION is null)) and "
                            + " target_date_comp>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N'";
                } else if (mode.equals("cir")) {
                	comphabs = "select count(distinct h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                            + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and "
                            + "a.programme_code in (" + programe + ")  and  ((b.DATE_OF_COMPLETION >= '01-APR-" + yearStart +"' and b.DATE_OF_COMPLETION is not null) OR (b.partial_date_of_completion is not null and b.DATE_OF_COMPLETION is null)) and "
                            + " target_date_comp>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)='" + rs.getString(4) + "'";
                } else if (mode.equals("div")) {
                	comphabs = "select count(distinct h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                            + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and "
                            + "a.programme_code in (" + programe + ")  and  ((b.DATE_OF_COMPLETION >= '01-APR-" + yearStart +"' and b.DATE_OF_COMPLETION is not null) OR (b.partial_date_of_completion is not null and b.DATE_OF_COMPLETION is null))  and "
                            + " target_date_comp>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)='" + request.getParameter("coc") + "'  and SUBSTR(a.OFFICE_CODE,4,1)='" + rs.getString(4) + "'";
                } else if (mode.equals("sdiv")) {
                	comphabs = "select count(distinct h.hab_code),SUM(nvl(CENSUS_PLAIN_POPU,0)+nvl(CENSUS_SC_POPU,0)+nvl(CENSUS_ST_POPU,0)+nvl(CENSUS_MINORITY_POPU,0)) from RWS_WORK_COMP_HAB_LNK_TBL h,rws_work_admn_tbl a,rws_work_completion_tbl b,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m"
                            + ", rws_habitation_directory_tbl hd where WORK_CANCEL_DT is null and b.work_id=a.work_id and h.work_id=a.work_id and hd.hab_code=h.hab_code and i.work_id(+)=a.work_id  and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id  and "
                            + "a.programme_code in (" + programe + ")  and  ((b.DATE_OF_COMPLETION >= '01-APR-" + yearStart +"' and b.DATE_OF_COMPLETION is not null) OR (b.partial_date_of_completion is not null and b.DATE_OF_COMPLETION is null))  and "
                            + " target_date_comp>='01-APR-" + yearStart + "' and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)='" + request.getParameter("coc") + "'  and SUBSTR(a.OFFICE_CODE,4,1)='" + request.getParameter("doc") + "' and SUBSTR(a.OFFICE_CODE,5,2)='" + rs.getString(4) + "'";
                }

                   
                    //System.out.println("COMPLTE habs"+comphabs);
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(comphabs);

                    if (rs1.next()) {
                        /* worksComp = rs1.getInt(1); */
                       habsCov = rs1.getInt(1);
                        popCov = rs1.getLong(2); 
                        
                        if (NRDWPCodes.indexOf(rs.getString(4)) == -1 || !mode.equals("initial")) {
                        	InputPhyFinStr += "[" + noOfWorks + "," + worksComp + ","+(noOfWorks-worksComp)+"],";
                        if (mode.equals("initial")) {
                        	                     	
                        	
                        	coveredHabs.put(rs.getString(4), habsCov);
                        	
                        	
                        %>
                          <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=cHabs&pc=<%=rs.getString(4)%>&pn=<%=rs.getString(3)%>')"><%=habsCov%></a></td>
                            <%
                            } else if (mode.equals("cir")) {
                            %>
                        
                        <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=cHabs&coc=<%=rs.getString(4)%>&con=<%=rs.getString(3)%>&pc=<%=pcd%>&pn=<%=pcn%>')"><%=habsCov%></a></td>
                            <%
                            } else if (mode.equals("div")) {
                            %>
                        
                        <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=cHabs&doc=<%=rs.getString(4)%>&don=<%=rs.getString(3)%>&coc=<%=coc%>&con=<%=con%>&pc=<%=pcd%>&pn=<%=pcn%>')"><%=habsCov%></a></td>
                            <%
                            } else if (mode.equals("sdiv")) {
                            %>
                        
                        <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=cHabs&soc=<%=rs.getString(4)%>&son=<%=rs.getString(3)%>&coc=<%=coc%>&con=<%=con%>&doc=<%=doc%>&don=<%=don%>&pc=<%=pcd%>&pn=<%=pcn%>')"><%=habsCov%></a></td>
                        <%
                            }
                        %>

                <td class="<%=style%>" style="text-align: right;" align="right"><%=popCov%></td>
                <%
                        }
                    }
                    stmt1.close();
                    rs1.close();
                %>

                <%
                    String bankLFI = "";
                    
                    if (mode.equals("initial")) {
                        bankLFI = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                            + "where WORK_CANCEL_DT is null and a.programme_code='" + rs.getString(4) + "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                            + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and BANK_SEND_DATE<='31-MAR-" + yearStart + "' "
                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N'";
                    } else if (mode.equals("cir")) {
                        bankLFI = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                            + "where WORK_CANCEL_DT is null and a.programme_code in (" + programe + ") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                            + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and BANK_SEND_DATE<='31-MAR-" + yearStart + "' "
                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N'  and SUBSTR(a.OFFICE_CODE,2,2)='" + rs.getString(4) + "'";
                    } else if (mode.equals("div")) {
                        bankLFI = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                            + "where WORK_CANCEL_DT is null and a.programme_code in ("+programe+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                            + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and BANK_SEND_DATE<='31-MAR-" + yearStart + "' "
                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N'  and SUBSTR(a.OFFICE_CODE,2,2)='" + request.getParameter("coc") + "'  and SUBSTR(a.OFFICE_CODE,4,1)='" + rs.getString(4) + "'";
                    } else if (mode.equals("sdiv")) {
                        bankLFI = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                            + "where WORK_CANCEL_DT is null and a.programme_code in ("+programe+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                            + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and BANK_SEND_DATE<='31-MAR-" + yearStart + "' "
                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)='" + request.getParameter("coc") + "'  and SUBSTR(a.OFFICE_CODE,4,1)='" + request.getParameter("doc") + "' and SUBSTR(a.OFFICE_CODE,5,2)='" + rs.getString(4) + "'";
                    }
               
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(bankLFI);
                    if (rs1.next()) {
                        bankLastYear = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();
                %>

                <%
                    String paoLFI = "";
                    
                    if (mode.equals("initial")) {
                        paoLFI = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                            + "where WORK_CANCEL_DT is null and a.programme_code='" + rs.getString(4) + "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                            + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and STATE_SEND_DATE<='31-MAR-" + yearStart + "' "
                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N'";
                    } else if (mode.equals("cir")) {
                        paoLFI = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                            + "where WORK_CANCEL_DT is null and a.programme_code in ("+programe+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                            + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and STATE_SEND_DATE<='31-MAR-" + yearStart + "' "
                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)='" + rs.getString(4) + "'";
                    } else if (mode.equals("div")) {
                        paoLFI = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                            + "where WORK_CANCEL_DT is null and a.programme_code in ("+programe+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                            + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and STATE_SEND_DATE<='31-MAR-" + yearStart + "' "
                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)='" + request.getParameter("coc") + "'  and SUBSTR(a.OFFICE_CODE,4,1)='" + rs.getString(4) + "'";
                    } else if (mode.equals("sdiv")) {
                        paoLFI = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                            + "where WORK_CANCEL_DT is null and a.programme_code in ("+programe+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                            + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and STATE_SEND_DATE<='31-MAR-" + yearStart + "' "
                            + "and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)='" + request.getParameter("coc") + "'  and SUBSTR(a.OFFICE_CODE,4,1)='" + request.getParameter("doc") + "' and SUBSTR(a.OFFICE_CODE,5,2)='" + rs.getString(4) + "'";
                    }
                    
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(paoLFI);
                    if (rs1.next()) {
                        paoLastYear = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();

                    String amountLFI = ndf.format((bankLastYear + paoLastYear) / 100000);

                    if (NRDWPCodes.indexOf(rs.getString(4)) == -1 || !mode.equals("initial")) {
                %>

                <td class="<%=style%>" style="text-align: right;" align="right"><%=amountLFI%></td>

                <%
                    }

                    String bankLM = "";
                    
                    if (mode.equals("initial")) {
                        bankLM = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                        + "where WORK_CANCEL_DT is null and a.programme_code='" + rs.getString(4) + "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                        + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and BANK_SEND_DATE>'31-MAR-" + yearStart + "' "
                                        + "and BANK_SEND_DATE<'01-" + currentMonth + "-" + cyear + "' and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N'";
                    } else if (mode.equals("cir")) {
                        bankLM = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                        + "where WORK_CANCEL_DT is null and a.programme_code in ("+programe+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                        + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and BANK_SEND_DATE>'31-MAR-" + yearStart + "' "
                                        + "and BANK_SEND_DATE<'01-" + currentMonth + "-" + cyear + "' and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)='" + rs.getString(4) + "'";
                    } else if (mode.equals("div")) {
                        bankLM = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                        + "where WORK_CANCEL_DT is null and a.programme_code in ("+programe+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                        + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and BANK_SEND_DATE>'31-MAR-" + yearStart + "' "
                                        + "and BANK_SEND_DATE<'01-" + currentMonth + "-" + cyear + "' and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N'  and SUBSTR(a.OFFICE_CODE,2,2)='" + request.getParameter("coc") + "'  and SUBSTR(a.OFFICE_CODE,4,1)='" + rs.getString(4) + "'";
                    } else if (mode.equals("sdiv")) {
                        bankLM = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                        + "where WORK_CANCEL_DT is null and a.programme_code in ("+programe+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                        + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and BANK_SEND_DATE>'31-MAR-" + yearStart + "' "
                                        + "and BANK_SEND_DATE<'01-" + currentMonth + "-" + cyear + "' and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)='" + request.getParameter("coc") + "'  and SUBSTR(a.OFFICE_CODE,4,1)='" + request.getParameter("doc") + "' and SUBSTR(a.OFFICE_CODE,5,2)='" + rs.getString(4) + "'";
                    }

                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(bankLM);
                    if (rs1.next()) {
                        bankLastMonth = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();
                %>

                <%
                    String paoLM = "";
                    
                    if (mode.equals("initial")) {
                        paoLM = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                            + "where WORK_CANCEL_DT is null and a.programme_code='" + rs.getString(4) + "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                            + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and STATE_SEND_DATE>'31-MAR-" + yearStart + "' "
                            + "and STATE_SEND_DATE<'01-" + currentMonth + "-" + cyear + "' and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N'";
                    } else if (mode.equals("cir")) {
                        paoLM = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                            + "where WORK_CANCEL_DT is null and a.programme_code in ("+programe+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                            + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and STATE_SEND_DATE>'31-MAR-" + yearStart + "' "
                            + "and STATE_SEND_DATE<'01-" + currentMonth + "-" + cyear + "' and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)='" + rs.getString(4) + "'";
                    } else if (mode.equals("div")) {
                        paoLM = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                            + "where WORK_CANCEL_DT is null and a.programme_code in ("+programe+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                            + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and STATE_SEND_DATE>'31-MAR-" + yearStart + "' "
                            + "and STATE_SEND_DATE<'01-" + currentMonth + "-" + cyear + "' and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)='" + request.getParameter("coc") + "'  and SUBSTR(a.OFFICE_CODE,4,1)='" + rs.getString(4) + "'";
                    } else if (mode.equals("sdiv")) {
                        paoLM = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                            + "where WORK_CANCEL_DT is null and a.programme_code in ("+programe+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                            + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and STATE_SEND_DATE>'31-MAR-" + yearStart + "' "
                            + "and STATE_SEND_DATE<'01-" + currentMonth + "-" + cyear + "' and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)='" + request.getParameter("coc") + "'  and SUBSTR(a.OFFICE_CODE,4,1)='" + request.getParameter("doc") + "' and SUBSTR(a.OFFICE_CODE,5,2)='" + rs.getString(4) + "'";
                    }
                    
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(paoLM);
                    if (rs1.next()) {
                        paoLastMonth = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();

                    String amountLM = ndf.format((bankLastMonth + paoLastMonth) / 100000);

                    if (NRDWPCodes.indexOf(rs.getString(4)) == -1 || !mode.equals("initial")) {
                %>

                <td class="<%=style%>" style="text-align: right;" align="right"><%=amountLM%></td>

                <%
                    }

                    String bankCM = "";
                    
                    if (mode.equals("initial")) {
                        bankCM = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                + "where WORK_CANCEL_DT is null and a.programme_code='" + rs.getString(4) + "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and BANK_SEND_DATE>'31-MAR-" + yearStart + "' "
                                + "and BANK_SEND_DATE>='01-" + currentMonth + "-" + cyear + "' and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N'";
                    } else if (mode.equals("cir")) {
                        bankCM = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                + "where WORK_CANCEL_DT is null and a.programme_code in ("+programe+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and BANK_SEND_DATE>'31-MAR-" + yearStart + "' "
                                + "and BANK_SEND_DATE>='01-" + currentMonth + "-" + cyear + "' and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)='" + rs.getString(4) + "'";
                    } else if (mode.equals("div")) {
                        bankCM = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                + "where WORK_CANCEL_DT is null and a.programme_code in ("+programe+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and BANK_SEND_DATE>'31-MAR-" + yearStart + "' "
                                + "and BANK_SEND_DATE>='01-" + currentMonth + "-" + cyear + "' and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)='" + request.getParameter("coc") + "'  and SUBSTR(a.OFFICE_CODE,4,1)='" + rs.getString(4) + "'";
                    } else if (mode.equals("sdiv")) {
                        bankCM = "select sum(nvl(BILL_AMOUNT_CENTRAL,0)) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                + "where WORK_CANCEL_DT is null and a.programme_code in ("+programe+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and BANK_SEND_DATE>'31-MAR-" + yearStart + "' "
                                + "and BANK_SEND_DATE>='01-" + currentMonth + "-" + cyear + "' and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)='" + request.getParameter("coc") + "'  and SUBSTR(a.OFFICE_CODE,4,1)='" + request.getParameter("doc") + "' and SUBSTR(a.OFFICE_CODE,5,2)='" + rs.getString(4) + "'";
                    }

                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(bankCM);
                    if (rs1.next()) {
                        bankCurrentMonth = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();
                %>

                <%
                    String paoCM = "";
                    
                    if (mode.equals("initial")) {
                        paoCM = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                + "where WORK_CANCEL_DT is null and a.programme_code='" + rs.getString(4) + "' and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and STATE_SEND_DATE>'31-MAR-" + yearStart + "' "
                                + "and STATE_SEND_DATE>='01-" + currentMonth + "-" + cyear + "' and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N'";
                    } else if (mode.equals("cir")) {
                        paoCM = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                + "where WORK_CANCEL_DT is null and a.programme_code in ("+programe+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and STATE_SEND_DATE>'31-MAR-" + yearStart + "' "
                                + "and STATE_SEND_DATE>='01-" + currentMonth + "-" + cyear + "' and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)='" + rs.getString(4) + "'";
                    } else if (mode.equals("div")) {
                        paoCM = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                + "where WORK_CANCEL_DT is null and a.programme_code in ("+programe+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and STATE_SEND_DATE>'31-MAR-" + yearStart + "' "
                                + "and STATE_SEND_DATE>='01-" + currentMonth + "-" + cyear + "' and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)='" + request.getParameter("coc") + "'  and SUBSTR(a.OFFICE_CODE,4,1)='" + rs.getString(4) + "'";
                    } else if (mode.equals("sdiv")) {
                        paoCM = "select sum(nvl(BILL_AMOUT_STATE,0)) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a,RWS_SOURCE_IDEN_FIN_TBL i,RWS_WORK_COMMENCEMENT_TBL c ,rws_contractor_selection_tbl m "
                                + "where WORK_CANCEL_DT is null and a.programme_code in ("+programe+") and a.work_id not in(select work_id from rws_work_completion_tbl where DATE_OF_COMPLETION is not null and DATE_OF_COMPLETION<'01-APR-" + yearStart + "') "
                                + "and  b.work_id=a.work_id and i.work_id(+)=a.work_id and target_date_comp>='01-APR-" + yearStart + "' and c.work_id(+)=a.work_id and m.work_id=a.work_id and m.work_id=i.work_id and STATE_SEND_DATE>'31-MAR-" + yearStart + "' "
                                + "and STATE_SEND_DATE>='01-" + currentMonth + "-" + cyear + "' and a.TYPE_OF_ASSET in (" + schemes + ") and c.GROUNDING_DATE is not null and c.CORE_DASHBOARD_STATUS<>'N' and SUBSTR(a.OFFICE_CODE,2,2)='" + request.getParameter("coc") + "'  and SUBSTR(a.OFFICE_CODE,4,1)='" + request.getParameter("doc") + "' and SUBSTR(a.OFFICE_CODE,5,2)='" + rs.getString(4) + "'";
                    }
                    
                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(paoCM);
                    if (rs1.next()) {
                        paoCurrentMonth = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();

                    String amountCM = ndf.format((bankCurrentMonth + paoCurrentMonth) / 100000);

                    String amountTot = ndf.format((bankLastMonth + paoLastMonth + bankCurrentMonth + paoCurrentMonth) / 100000);

                    if (NRDWPCodes.indexOf(rs.getString(4)) == -1 || !mode.equals("initial")) {
                %>

                <td class="<%=style%>" style="text-align: right;" align="right"><%=amountCM%></td>
                <td class="<%=style%>" style="text-align: right;" align="right"><%=amountTot%></td>
                <%
                    }
                    String phyCompNotFinBank = "";
                    

                    phyCompNotFinBank = "select sum(BILL_AMOUNT_CENTRAL) from RWS_BILL_BANK_BRIDGE_DET_TBL b,rws_work_admn_tbl a where "
                                        + "b.work_id=a.work_id and a.programme_code='" + rs.getString(4) + "' and "
                                        + "BANK_SEND_DATE between '01-APR-" + yearStart + "' and '31-MAR-" + yearEnd + "'";
                    if (mode.equals("cir")) {
                        phyCompNotFinBank += " and SUBSTR(a.OFFICE_CODE,2,2)='" + rs.getString(4) + "'";
                    }
                    else if (mode.equals("div")) {
                        phyCompNotFinBank += " and SUBSTR(a.OFFICE_CODE,2,2)='" + request.getParameter("coc") + "'  and SUBSTR(a.OFFICE_CODE,4,1)='" + rs.getString(4) + "'";
                    }
                    else if (mode.equals("sdiv")) {
                        phyCompNotFinBank += " and SUBSTR(a.OFFICE_CODE,2,2)='" + request.getParameter("coc") + "'  and SUBSTR(a.OFFICE_CODE,4,1)='" + request.getParameter("doc") + "' and SUBSTR(a.OFFICE_CODE,5,2)='" + rs.getString(4) + "'";
                    }

                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(phyCompNotFinBank);
                    if (rs1.next()) {
                        bankPhyCompNotFin = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();

                    String phyCompNotFinPAO = "";
                    
                    phyCompNotFinPAO = "select sum(BILL_AMOUT_STATE) from RWS_BILL_PAO_BRIDGE_DET_TBL b,rws_work_admn_tbl a where "
                                    + "b.work_id=a.work_id and a.programme_code='" + rs.getString(4) + "' and "
                                    + "STATE_SEND_DATE between '01-APR-" + yearStart + "' and '31-MAR-" + yearEnd + "'";

                    if (mode.equals("cir")) {
                        phyCompNotFinPAO += " and SUBSTR(a.OFFICE_CODE,2,2)='" + rs.getString(4) + "'";
                    }
                    else if (mode.equals("div")) {
                        phyCompNotFinPAO += " and SUBSTR(a.OFFICE_CODE,2,2)='" + request.getParameter("coc") + "'  and SUBSTR(a.OFFICE_CODE,4,1)='" + rs.getString(4) + "'";
                    }
                    else if (mode.equals("sdiv")) {
                        phyCompNotFinPAO += " and SUBSTR(a.OFFICE_CODE,2,2)='" + request.getParameter("coc") + "'  and SUBSTR(a.OFFICE_CODE,4,1)='" + request.getParameter("doc") + "' and SUBSTR(a.OFFICE_CODE,5,2)='" + rs.getString(4) + "'";
                    }

                    stmt1 = conn.createStatement();
                    rs1 = stmt1.executeQuery(phyCompNotFinPAO);
                    if (rs1.next()) {
                        paoPhyCompNotFin = rs1.getDouble(1);
                    }
                    stmt1.close();
                    rs1.close();

                    String amountPhyCompNotFin = ndf.format((bankPhyCompNotFin + paoPhyCompNotFin) / 100000);


                    arfc = estCost - (bankLastYear + paoLastYear + bankLastMonth + paoLastMonth + bankCurrentMonth + paoCurrentMonth) / 100000;

                    if (NRDWPCodes.indexOf(rs.getString(4)) == -1 || !mode.equals("initial")) {
                %>
                <td class="<%=style%>" style="text-align: right;" align="right"><%=amountPhyCompNotFin%></td>
                
                <%
                 if (mode.equals("initial")) {
                %>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=fWorks&pc=<%=rs.getString(4)%>&pn=<%=rs.getString(3)%>')"><%=noOfWorks - worksComp%></a></td>
                    <%
                    } else if (mode.equals("cir")) {
                    %>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=fWorks&coc=<%=rs.getString(4)%>&con=<%=rs.getString(3)%>&pc=<%=pcd%>&pn=<%=pcn%>')"><%=noOfWorks - worksComp%></a></td>
                    <%
                    } else if (mode.equals("div")) {
                    %>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=fWorks&doc=<%=rs.getString(4)%>&don=<%=rs.getString(3)%>&coc=<%=coc%>&con=<%=con%>&pc=<%=pcd%>&pn=<%=pcn%>')"><%=noOfWorks - worksComp%></a></td>
                    <%
                    } else if (mode.equals("sdiv")) {
                    %>
                <td class="<%=style%>" style="text-align: right;" align="right"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=fWorks&soc=<%=rs.getString(4)%>&son=<%=rs.getString(3)%>&coc=<%=coc%>&con=<%=con%>&doc=<%=doc%>&don=<%=don%>&pc=<%=pcd%>&pn=<%=pcn%>')"><%=noOfWorks - worksComp%></td>
                <%
                    }
                %>
                
                <td class="<%=style%>" style="text-align: right;" align="right"><%=ndf.format(arfc)%></td>
                <%
                    estimatedCost.put(rs.getString(4), estCost);
                	expenditure.put(rs.getString(4), (bankLastYear + paoLastYear + bankLastMonth + paoLastMonth + bankCurrentMonth + paoCurrentMonth) / 100000);
                	balanceEstimatedCost.put(rs.getString(4), arfc);
                    }

                        totNoOfWorks = totNoOfWorks + noOfWorks;
                        totEstCost = totEstCost + estCost;
                        totHabsSanctioned = totHabsSanctioned + habsSanctioned;
                        totWorksComp = totWorksComp + worksComp;
                        totHabsCov = totHabsCov + habsCov;
                        totPopCov = totPopCov + popCov;
                        totPopBenf = totPopBenf + popBenf;
                        totExpUptoLFY = totExpUptoLFY + bankLastYear + paoLastYear;
                        totExpUptoLM = totExpUptoLM + bankLastMonth + paoLastMonth;
                        totExpDM = totExpDM + bankCurrentMonth + paoCurrentMonth;
                        totTotExp = totExpUptoLM + totExpDM;
                        totarfc = totarfc + arfc;
                        totWorksPhyCompNotFin = totWorksPhyCompNotFin
                                + worksPhyCompNotFin;
                        totExpPhyCompNotFin = totExpPhyCompNotFin
                                + bankPhyCompNotFin + paoPhyCompNotFin;
                       // totalAmtInclPhyCompNotFin = totExpUptoLFY + totTotExp + totExpPhyCompNotFin;
                        if (NRDWPCodes.indexOf(rs.getString(4)) != -1 && mode.equals("initial")) {
                        	
                        	
                        	
                            codesToSend += rs.getString(4) + ",";
                            //System.out.println(nrdwpNoOfWorks +"    "+noOfWorks+" "+(nrdwpNoOfWorks + noOfWorks));
                            nrdwpNoOfWorks = nrdwpNoOfWorks + noOfWorks;
                            
                            nrdwpEstCost = nrdwpEstCost + estCost;
                           // System.out.println(nrdwpHabsSanctioned +"    "+habsSanctioned+" "+(nrdwpHabsSanctioned + habsSanctioned));
                            nrdwpHabsSanctioned = nrdwpHabsSanctioned + habsSanctioned;
                          
                            nrdwpWorksComp = nrdwpWorksComp + worksComp;
                            nrdwpHabsCov = nrdwpHabsCov + habsCov;
                            nrdwpPopCov = nrdwpPopCov + popCov;
                            nrdwpPopBenf = nrdwpPopBenf + popBenf;
                            nrdwpExpUptoLFY = nrdwpExpUptoLFY + bankLastYear + paoLastYear;
                            nrdwpExpUptoLM = nrdwpExpUptoLM + bankLastMonth + paoLastMonth;
                            nrdwpExpDM = nrdwpExpDM + bankCurrentMonth + paoCurrentMonth;
                            nrdwpTotExp = nrdwpExpUptoLM + nrdwpExpDM;
                            nrdwparfc = nrdwparfc + arfc;
                            nrdwpWorksPhyCompNotFin = nrdwpWorksPhyCompNotFin + worksPhyCompNotFin;
                            nrdwpTotExpPhyCompNotFin = nrdwpTotExpPhyCompNotFin + bankPhyCompNotFin + paoPhyCompNotFin;
                            
                        }

                    }
                   
                    if (codesToSend.length() > 0) {
                        codesToSend = codesToSend.substring(0, codesToSend.length() - 1);
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
                if (mode.equals("initial")) {
                	
                	InputPhyFinStr += "[" + nrdwpNoOfWorks + "," + nrdwpWorksComp + ","+(nrdwpNoOfWorks-nrdwpWorksComp)+"],";
                	
                	ongoingWorks.put(NRDWPCodes, nrdwpNoOfWorks);
                	completedWorks.put(NRDWPCodes, nrdwpWorksComp);
                	progMap.put(NRDWPCodes, "NRDWP");
                	
                	
                	
                	sanctionedHabs.put(NRDWPCodes, nrdwpHabsSanctioned);
                	coveredHabs.put(NRDWPCodes, nrdwpHabsCov);
                	
                	estimatedCost.put(NRDWPCodes, nrdwpEstCost);
                	expenditure.put(NRDWPCodes, (nrdwpExpUptoLFY + nrdwpExpUptoLM + nrdwpExpDM) / 100000);
                	balanceEstimatedCost.put(NRDWPCodes, nrdwparfc);
                	
                	
                	
            %>

            <tr>
                <td class="<%=style%>" style="text-align: right;"><%=++slno%></td>
                <td class="<%=style%>" style="text-align: left;" ><a href="rws_work_progress_CM_abstract_rpt.jsp?mode=cir&pc=<%=NRDWPCodes%>&pn=NRDWP">NRDWP</a></td>
                <td class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=tWorks&pc=<%=NRDWPCodes%>&pn=NRDWP')"><%=nrdwpNoOfWorks%></a></td>
                <td class="<%=style%>" style="text-align: right;"><%=ndf.format(nrdwpEstCost)%></a></td>
                <td class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=sHabs&pc=<%=NRDWPCodes%>&pn=NRDWP')"><%=nrdwpHabsSanctioned%></td>
                <td class="<%=style%>" style="text-align: right;"><%=nrdwpPopBenf%></td>
                <td class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=cWorks&pc=<%=NRDWPCodes%>&pn=NRDWP')"><%=nrdwpWorksComp%></a></td>
                <td class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=cHabs&pc=<%=NRDWPCodes%>&pn=NRDWP')"><%=nrdwpHabsCov%></a></td>
                <td class="<%=style%>" style="text-align: right;"><%=nrdwpPopCov%></td>
                <td class="<%=style%>" style="text-align: right;"><%=ndf.format(nrdwpExpUptoLFY / 100000)%></td>
                <td class="<%=style%>" style="text-align: right;"><%=ndf.format(nrdwpExpUptoLM / 100000)%></td>
                <td class="<%=style%>" style="text-align: right;"><%=ndf.format(nrdwpExpDM / 100000)%></td>
                <td class="<%=style%>" style="text-align: right;"><%=ndf.format(nrdwpTotExp / 100000)%></td>
                <td class="<%=style%>" style="text-align: right;"><%=ndf.format(nrdwpTotExpPhyCompNotFin / 100000)%></td>
                <td class="<%=style%>" style="text-align: right;"><a href="#" onclick="viewWorks('./rws_work_progress_CM_abstract_drill.jsp?mode=fWorks&pc=<%=NRDWPCodes%>&pn=NRDWP')"><%=nrdwpNoOfWorks - nrdwpWorksComp%></a></td>
                <td class="<%=style%>" style="text-align: right;"><%=ndf.format(nrdwparfc)%></td>
            </tr>
            <%
           
                }
               
                ongoingWorks.put("00", totNoOfWorks);
            	completedWorks.put("00", totWorksComp);
            	progMap.put("00", "ALL");
            	
            	sanctionedHabs.put("00", totHabsSanctioned);
            	coveredHabs.put("00", totHabsCov);
            	
            	estimatedCost.put("00", totEstCost);
            	expenditure.put("00", (totExpUptoLFY + totExpUptoLM + totExpDM) / 100000);
            	balanceEstimatedCost.put("00", totarfc);
                
            	session.setAttribute("ongoingWorks", ongoingWorks);
            	session.setAttribute("completedWorks", completedWorks);
            	session.setAttribute("progMap", progMap);
            	
            	session.setAttribute("sanctionedHabs", sanctionedHabs);
            	session.setAttribute("coveredHabs", coveredHabs);
            	
            	session.setAttribute("estimatedCost", estimatedCost);
            	session.setAttribute("expenditure", expenditure);
            	session.setAttribute("balanceEstimatedCost", balanceEstimatedCost);
            	//System.out.println("InputPhyFinStr"+InputPhyFinStr.length());
            	if(InputPhyFinStr.length()>0){
                InputPhyFinStr = InputPhyFinStr.substring(0, InputPhyFinStr.length() - 1);
                session.setAttribute("InputPhyFinStr", InputPhyFinStr);
            	}
            %>
            <tr class="rightPad">
                <td class="btext" style="text-align: right;" colspan=2>Total:</td>
                <td class="btext" style="text-align: right;"><%=totNoOfWorks%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totEstCost)%></td>
                <td class="btext" style="text-align: right;"><%=totHabsSanctioned%></td>
                <td class="btext" style="text-align: right;"><%=totPopBenf%></td>
                <td class="btext" style="text-align: right;"><%=totWorksComp%></td>
                <td class="btext" style="text-align: right;"><%=totHabsCov%></td>
                <td class="btext" style="text-align: right;"><%=totPopCov%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totExpUptoLFY / 100000)%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totExpUptoLM / 100000)%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totExpDM / 100000)%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totTotExp / 100000)%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totExpPhyCompNotFin / 100000)%></td>
                <td class="btext" style="text-align: right;"><%=totNoOfWorks - totWorksComp%></td>
                <td class="btext" style="text-align: right;"><%=ndf.format(totarfc)%></td>
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
   <%--  <%if (mode.equals("initial") ) { %> --%>
    
    <%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashMap"%>
<!doctype html>

<html>

    <%
       /*  if(session.getAttribute("habSancMap")==null || session.getAttribute("habTarMap")==null || session.getAttribute("habCovMap")==null || session.getAttribute("InputPhyFinStr")==null )
        {
            response.sendRedirect("http://core.ap.gov.in/");
            return;
        }
       */
    String programme = request.getParameter("pn");
      // System.out.println(programme);
        if(programme==null || programme==""){
        	programme="00";
        }
        String mode1 = request.getParameter("mode1");
        if(mode1==null || mode1==""){
        	mode1="Bar";
        }
         /* long workToCover = Long.parseLong(ongoingWorks.get(programme).toString()) - Long.parseLong(completedWorks.get(programme).toString());
         long habToCover = Long.parseLong(sanctionedHabs.get(programme).toString()) - Long.parseLong(coveredHabs.get(programme).toString());
      
       
         String distBars = "";
        
         String worksPie = "[[\"Ongoing Works \","+ongoingWorks.get(programme)+"],"+"[\"Completed Works \","+completedWorks.get(programme)+"],"+"[\"To be Covered Works\","+workToCover+"]]";
         String habsPie = "[[\"Sanctioned Habs \","+sanctionedHabs.get(programme)+"],"+"[\"Covered Habs \","+coveredHabs.get(programme)+"],"+"[\"To be Covered Habs\","+habToCover+"]]"; 
         String expPie = "[[\"Est Cost \","+ndf.format(estimatedCost.get(programme))+"],"+"[\"Exp \","+ndf.format(expenditure.get(programme))+"],"+"[\"ARFC \","+ndf.format(balanceEstimatedCost.get(programme))+"]]"; 
          */
        
         
         Set keySet2 = progMap.keySet();
         List keyList = new ArrayList(keySet2);
         Collections.sort(keyList); 
         
    %>
    <head>
        <meta charset="utf-8">
        <meta name="description" content="A jquery plugin to create simple donut, bar or line charts with dom nodes, style with css.">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title></title>

        <script src="/pred/resources/graphs/jquery.min.js"></script>
        <link rel="stylesheet" href="/pred/resources/graphs/cssCharts.css">
        <script src="/pred/resources/graphs/jquery.chart.js"></script>

        <style>
            /* page specific styles*/
            h1{text-align:center;font-family:sans-serif;font-size:28px;color:#333;padding:40px 0 0 0;}
            h2{text-align:center;font-family:sans-serif;font-size:18px;color:#333;padding:40px 0 0 0;}
            hr{width:60%;height:1px;background:none;border:none;border-bottom:1px dashed rgba(0,0,0,0.1);outline:none;margin:40px auto 60px auto;}

            .desc p{text-align:center;font-size:16px;color:rgba(0,0,0,0.6);padding:20px 0 0 0;font-family:sans-serif;}
            .desc a{color:blue;}
            .wrap{margin:0 auto;width:640px;padding-bottom:100px;}
            #line{width:400px;}
            
          .distbar ul {
                margin-right: 10px !important;
            }
             .bar-chart span{
                    margin: 0 0px !important;
            }
            .chart.pie .pie-legend {
                margin-right: 20px !important;
                margin-top: 180px !important;
            }
             .bar-chart span:before {
                width: 20px !important;
                word-wrap: normal !important;
            }
            .bar-chart ul {
            <%if (mode.equals("initial")) { %>
    			margin-left: 40px !important;
    			<%} else{%>
    			margin-left: 30px !important;
    			<%} %>

        </style>
        <script>
            $(document).ready(function() {
                    $("#programme option[value='<%=programme%>']").prop('selected', true);
                    $("#programme").change(function() {
                        $("#graphParams").submit();
                    });
            });
        </script>

    </head>
    <%
    String ar[]=names.split(",");
    int width=0;
    if (mode.equals("initial")) {
    width=1000;
    }
    else{
    	width=ar.length*102;
    	if(width>1000){
    		
    	}
    	else{
    		width=1000;
    	}
    }
    %>
   <%--  <body>
        <form id="graphParams" name="graphParams" action="rws_work_progress_CM_abstract_rpt.jsp">
            <input type="hidden" id="mode1" name="mode1" value="<%=mode1%>"/>
        <div class="wrap" style="margin-top: -30px !important; width: <%=width%>px !important; text-align: center !important;">
            

            <%
                if(mode1.equals("Bar"))
                {
                	
                	
                System.out.println();
            %>
                    <br/><br/><br/>
            <div id="distChart" style=" padding-left: 50px;  padding-bottom: 100px;   padding-top: 20px; border : 1px double #c67; border-radius: 8px;">
                <p style="font-weight: normal; text-align: center;">
                    <span style="background-color: #728C00;" >&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;Ongoing Works&nbsp;&nbsp;&nbsp;&nbsp;
                   <span style="background-color: #F88017;" >&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;Completed Works&nbsp;&nbsp;&nbsp;&nbsp;
                   <span style="background-color: #C00;" >&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;To be Completed Works 
                </p>
                <br/>
                 <%if (mode.equals("initial")) {%>
                <div class="chart" style="left: 30px ; height: 300px;">
                    <ul id="distChartUL" class="bar-chart" data-bars="<%=InputPhyFinStr%>" data-max="" data-unit="" data-width="16" style="width: 500px;">
                    <ul><li style="height:300px"></li></ul>
                    </ul>
                    <p style="transform: rotate(270deg);position: relative;top: 120px; left: -320px; font-weight: bold;	margin-left: -60px !important;">Ongoing and Completed Works count</p>
                    <p style="margin-left: -30px !important;">
                    <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
                  </p>
                    <br/>
                    
                   <%
                   System.out.println(programmeName.size()); 
                   for (int i=1; i <= programmeName.size(); i++) {
					%>
                   <%=(String) programmeName.get(i)%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   
                   <%} %>               
                </div>
                   <%}else{ 
                	  
                   	int top=35,left=-(47*ar.length);
                   int len=ar.length;
                   len=90*len;
                    if(ar.length<=2){
                	   len=85*(ar.length+1);
                   } 
                   System.out.println(len);
                   int graphleft=ar.length*ar.length;
                 //  graphleft=-graphleft-480;
                   graphleft=-ar.length*52;
                   if(ar.length<=3){
                	   graphleft=-(ar.length+1)*85;
                   }
                  System.out.println(graphleft);
                  
                   
                   %>
                   <div class="chart" style="left: 30px ; height: 300px;">
                    <ul id="distChartUL" class="bar-chart" data-bars="<%=InputPhyFinStr%>" data-max="" data-unit="" data-width="16" style="width: <%=len %>px;">
                    <ul><li style="height:300px"></li></ul>
                    </ul>
                    <p style="transform: rotate(270deg);position: relative;top: 120px; left: <%=graphleft%>px; font-weight: bold;	margin-left: -60px !important;">Ongoing and Completed Works count</p>
                    <p style="margin-left: -30px !important;">
                    <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
                   
                  
                   <%
                   for(int i=0;i<ar.length;i++){
                	   top=top-15;
                	   if(ar.length<=2){
                	   left=left+60;
                	   }
                	   else{
                		   left=left+82;
                	   }
                	  // System.out.println("left-----"+left);
                   %>
                   
                   <h4 style="transform: rotate(-30deg);top: <%=top%>px;position: relative;left: <%=left%>px;"><%=ar[i] %></h4>
                   <%}%>
                   </p>
                    <br/>
                   
                </div>
                   <%}%>
                   
            </div>
            <%
                }
                else if(mode1.equals("Pie"))
                {
            %>
            <br/><br/><br/>
             <div id="pieChart" style="padding-bottom: 130px;  border : 1px double #c67; border-radius: 8px; vertical-align: top !important;">
                     <div class="desc" style="text-align: center; font-weight: bold;">
                

                <font color="#889900" face="Maiandra GD" size="3px">( Programme: <%=progMap.get(programme)%> )</font> 
                <br/> 
            </div>
                     <div id="distPieDiv" style=" margin-left: 380px !important;width:480px !important; text-align: center !important; font-weight: bold; margin-top: 50px !important;">
                        Programme Wise Work Progress : &nbsp;
                        <select name="programme" id="programme" style="width: 120px !important;">
                            <%
                                for(Object key: keyList)
                                {
                                    %>
                                    <option value="<%=key%>"><%=progMap.get(key)%></option>
                                    <%
                                }
                            %>
                        </select>&nbsp;&nbsp;
                    </div> 
                    <br/>
                    <table>
                        <tr>
                            <td >
                                <h3 style="margin-left: 60px !important;">Work Progress</h3>
                                <div class="chart" style="width:220px !important; margin-left: 30px !important; text-align: left !important; ">
                                    <div class="pie-thychart" data-set='<%=worksPie%>' data-colors="#FFA500,#006400,#d62929">
                                    </div>
                                </div>
                            </td>
                             <td>
                                <h3 style="margin-left: 190px !important;">Habs Progress</h3>
                                <div class="chart" style="width:220px !important; margin-left: 180px !important; text-align: left !important;">
                                    <div class="pie-thychart" data-set='<%=habsPie%>' data-colors="#FFA500,#006400,#d62929">
                                    </div>
                                </div>
                            </td>
                           <td>
                                <h3 style="margin-left: 80px !important;">Expenditures (Amount in Lakhs)</h3>
                                <div class="chart" style="width:200px !important; margin-left: 180px !important; text-align: left !important;">
                                    <div class="pie-thychart" data-set='<%=expPie%>' data-colors="#FFA500,#006400,#d62929">
                                    </div>
                                </div>
                            </td> 
                        </tr>
                    </table>
            </div> 
            <%
                }
            %>
        </div>
        </form>
     
        
        <script>
            $(function () {
                $('.bar-chart').cssCharts({type: "bar"});
                $('.donut-chart').cssCharts({type: "donut"}).trigger('show-donut-chart');
                $('.line-chart').cssCharts({type: "line"});
                $('.pie-thychart').cssCharts({type: "pie"});
            });
        </script>
    </body>
 --%></html>
<%//} %>
    <table height="20px" align="center">
        <tr height="1%">
            <td align="center" valign="bottom" style="font-family:verdana;font-size:8pt;font-weight:bold;width:100%;color:#6600CC;">
                Source: <a href="http://rwss.ap.nic.in" target="_blank">WaterSoft</a>, Designed & Developed by <a href="http://www.nic.in" target="_blank">National Informatics Centre</a>, AP State Centre
            </td>
        </tr>
    </table>
    <br/>
</BODY>

