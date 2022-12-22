<%@ include file="/commons/rws_header1.jsp"%>
<%@ page contentType="application/vnd.ms-excel" %>
<%@ page import="java.math.BigDecimal"%>
<%@ page import="javax.servlet.jsp.*"%>


<%@ include file="conn.jsp"%>
<%!Statement st1 = null, s = null, s1 = null, s2 = null, s3 = null, ss = null,
            stmt3 = null;

    Statement st2 = null, st22 = null, ss1 = null;

    ResultSet rs2 = null, r = null, r1 = null, r2 = null, rr = null,
            rss = null, rr1 = null, rss1 = null;

    Statement stmt1 = null;

    ResultSet rs1 = null;

    ResultSetMetaData rsm = null;

    String query = null, query2 = null;

    int Count = 0, Cnt = 0, slno = 1, sl = 0, Counts = 0, no = 0;

    public double expenditure_previous_year = 0.0f;

    public float expenditure_previous_month = 0.0f,
            expenditure_current_month = 0.0f, total_expenditure = 0.0f,
            expd_notpaid = 0.0f, grandtotal = 0.0f;

    String dName, divName, subdivName, schName, aName, pName, planName,
            workcName, adyear, dCode, divCode, subdivCode, planCode, spName;

    String workccode, schCode, aCode, pCode, spCode, yearCode;

    nic.watersoft.reports.rws_Expenditure_Bean databean[];

    HashSet no_of_years_andmonths_workid;

    String no_of_years_for_workid[];

    %>

<%!public String isNull(String nstr) {
        if (nstr != null) {
            return nstr;
        } else {
            return "";
        }

    }

    %>

<%
  
    stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    st1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    st2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    s = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    stmt3=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    
     dName = String.valueOf(session.getAttribute("dName"));
     divName = String.valueOf(session.getAttribute("divName"));
     subdivName = String.valueOf(session.getAttribute("subdivName"));
     schName = String.valueOf(session.getAttribute("schName"));
     aName = String.valueOf(session.getAttribute("augName"));    
     pName = String.valueOf(session.getAttribute("progName")); 
     spName = String.valueOf(session.getAttribute("sprogName")); 
     planName = String.valueOf(session.getAttribute("PlanName"));
     workcName = String.valueOf(session.getAttribute("workcName"));
     adyear = String.valueOf(session.getAttribute("yrName"));
    
     dCode = (String)request.getParameter("district");
     divCode = (String)request.getParameter("division"); 
     subdivCode = (String)request.getParameter("subdivision"); 
     planCode = (String)request.getParameter("plan"); 
     workccode = (String)request.getParameter("work"); 
     schCode = (String)request.getParameter("scheme");; 
     aCode = (String)request.getParameter("augmentation");
     pCode = (String)request.getParameter("programme"); 
     spCode = (String)request.getParameter("subprogramme"); 
     yearCode= (String)request.getParameter("year"); 
    String programm_code="";
    int fields=0;
    int colcount=3;
    Statement scheme=conn.createStatement();
    Statement qhh=conn.createStatement();
    Statement sh=conn.createStatement();
    String divname="";
    String subdivname="";
    String schname="";
    String augname="";
    String pname="";
    String subprog="";
    String yearval="";
    double expprev=0;
    double valup=0;
    double toto=0;
    
%>

<html>
<head>

</head>

<body bgcolor="#edf2f8">
<form name=f1 method="post">

<table border=1 cellspacing=0 cellpadding=0 width="100%"
	bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff"
	align="center">
	
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=17>Work Expenditure
		Report</td>
	</tr>
	<c:if test="${param.district ne null and param.district ne ''}">
		<tr bgcolor="#edf2f8">
			<td class="rptHeading" colspan="17">District: <%=dName%></td>
		</tr>
	</c:if>
	<c:if test="${divName ne null and divName ne 'null'}">
		<tr>
			<td class="rptHeading" colspan="17" bgcolor="#edf2f8">Division: <c:out
				value="${divName}" /></td>
		</TR>
		<c:if test="${subdivName ne null and subdivName ne 'null'}">
			<TR>
				<td class="rptHeading" colspan="17" bgcolor="#edf2f8">SubDivision:<c:out
					value="${subdivName}" /></td>
			</TR>
		</c:if>
		<c:if test="${schName ne null and schName ne 'null'}">
			<TR>
				<td class="rptHeading" colspan="17" bgcolor="#edf2f8">Scheme: <c:out
					value="${schName}" /></td>
			</tr>
		</c:if>
		<c:if test="${augName ne null and augName ne 'null'}">
			<TR>
				<td class="rptHeading" colspan="17" bgcolor="#edf2f8">Augemntation:
				<c:out value="${augName}" /></td>
			</tr>
		</c:if>

		<c:if test="${progName ne null and progName ne 'null'}">
			<TR>
				<td class="rptHeading" colspan="17" bgcolor="#edf2f8">Programme: <c:out
					value="${progName}" /></td>
			</TR>
		</c:if>
		<c:if test="${sprogName ne null and sprogName ne 'null'}">
			<TR>
				<td class="rptHeading" colspan="17" bgcolor="#edf2f8">SubProgramme:
				<c:out value="${sprogName}" /></td>
			</TR>
		</c:if>
		<c:if test="${param.year ne null and param.year ne 'null'}">
			<TR>
				<td class="rptHeading" colspan="17" bgcolor="#edf2f8">Year(Admin_Sanc_Year):
				<c:out value="${param.year}" /></td>
			</TR>
		</c:if>
	</c:if>
	</tr>

	<c:if test="${PlanName ne null and PlanName ne 'null'}">
		<tr bgcolor="#edf2f8">
			<td class="rptHeading" colspan="17">Plan/Non-Plan
			&nbsp;&nbsp;&nbsp;&nbsp;:<%=planName%></td>
		</tr>
	</c:if>

	<c:if test="${workcName ne null and workcName ne 'null'}">
		<tr bgcolor="#edf2f8">
			<td class="rptHeading" colspan="17">WorkCategory&nbsp;&nbsp;&nbsp;&nbsp;:<%=workcName%></td>
		</tr>
	</c:if>
	<c:if test="${augName ne null and augName ne 'null'}">
		<tr bgcolor="#edf2f8">
			<td class="rptHeading" colspan="17">MainScheme/Augumentation/Maintenance&nbsp;&nbsp;:<%=aName%></td>
		</tr>
	</c:if>
</table>
<%slno=0; %>
<table>
	<tr>
		<td></td>
	</tr>
</table>
<table border=1 cellspacing=0 cellpadding=0 width="100%"
	bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff"
	align="center">
	<tr align=center bgcolor="#ffffff">
		<td class="btext" rowspan=2>S.NO</td>
		<td class="btext" rowspan=2>WorkId/WorkName</td>
		<%--<td class="btext" nowrap rowspan=2>Plan/<br>Non-Plan</td>
        <td class="btext" rowspan=2>Category</td>
        <td class="btext" rowspan=2>MainScheme/<br>Augumentation/<br>Maintenance</td>
        <td class="btext" rowspan=2>ProgrammeName</td> --%>
		<c:if test="${divName eq null or divName eq 'null'}">
			<%colcount++;%>
			<td class="btext" rowspan=2>Division</td>
		</c:if>
		<c:if test="${subdivName eq null or subdivName eq 'null'}">
			<%colcount++;%>
			<td class="btext" rowspan=2>SubDivision</td>
		</c:if>
		<c:if test="${PlanName eq null or PlanName eq 'null'}">
			<%colcount++;%>
			<td class="btext" rowspan=2>Plan/Non-Plan</td>
		</c:if>
		<c:if test="${workcName eq null or workcName eq 'null'}">
			<%colcount++;%>
			<td class="btext" rowspan=2>Work Category</td>
		</c:if>
		<c:if test="${schName eq null or schName eq 'null'}">
			<%colcount++;%>
			<td class="btext" rowspan=2>Scheme</td>
		</c:if>
		<c:if test="${augName eq null or augName eq 'null'}">
			<%colcount++;%>
			<td class="btext" rowspan=2>MainScheme/<br>
			Augumentation/<br>
			Maintenance</td>
		</c:if>
		<c:if test="${progName eq null or progName eq 'null'}">
			<%colcount++;%>
			<td class="btext" rowspan=2>Programme</td>
		</c:if>
		<c:if test="${sprogName eq null or sprogName eq 'null'}">
			<%colcount++;%>
			<td class="btext" rowspan=2>SubProgramme</td>
		</c:if>
		<c:if
			test="${param.year eq null or param.year eq 'null' or param.year eq ''}">
			<%colcount++;%>
			<td class="btext" rowspan=2>Year(Admin_Sanc_year)</td>
		</c:if>
		<td class="btext" rowspan=2 nowrap>Expenditure Upto<br>
		The Prev Year<br>
		(Rs In Lakhs)</td>
		<td class="btext" colspan=5>Expenditure During<br>
		The Year<br>
		(Rs In Lakhs)</td>
		<td class="btext" nowrap>Value of <br>
		work<br>
		done<br>
		but not<br>
		paid</td>
		<td class="btext" rowspan=2>Total Expenditure(Rs In Lakhs)</td>
	</tr>

	<tr>
		<td class="btext">Programe</td>
		<td class="btext">Year</td>
		<td class="btext">Month</td>
		<td class="btext">Upto Previous<br>
		Month</td>
		<td class="btext">During The<br>
		Month</td>
		<td class="btext" nowrap>Value of <br>
		work<br>
		done<br>
		but not<br>
		paid</td>
	</tr>
	<jsp:useBean id="expenditure" class="nic.watersoft.reports.rws_ExpenditureReport" />

	<%String query = expenditure.preparefirstQuery(dCode, divCode,
                    subdivCode, planCode, workccode, schCode, aCode, pCode,
                    spCode, yearCode);
//					System.out.println("query:"+query);
            stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            rs = stmt.executeQuery(query);
            rs.setFetchSize(1000);
            rs.last();
            Count = rs.getRow();
            databean = new nic.watersoft.reports.rws_Expenditure_Bean[Count];
            int item = 0;
            //int counter = 0;
            rs.beforeFirst();
            while (rs.next()) {
                databean[item] = new nic.watersoft.reports.rws_Expenditure_Bean();
                databean[item].setWorkname(isNull(rs.getString(1)));
                databean[item].setWorkid(isNull(rs.getString(2)));
                databean[item].setOfficecode(isNull(rs.getString(3)));
                databean[item].setYearcode(isNull(rs.getString(4)));
                databean[item].setPlannonplan(isNull(rs.getString(5)));
                databean[item].setAugumentation(isNull(rs.getString(6)));
                databean[item].setCategorycode(isNull(rs.getString(7)));
                databean[item].setSubstrofficecode(isNull(rs.getString(10)));
                databean[item].setSubstrofficecode1(isNull(rs.getString(11)));
                item++;
            }
            pageContext.setAttribute("databean", databean);
%>
	<!-- Begining of Report data -->
	<c:forEach items="${databean}" var="workdata">
		<tr bgcolor="#ffffff">
			<td class=rptValue><%=++slno%></td>
			<td class=rptValue>&nbsp;<c:out value="${workdata.workid}" /><br>
			/ <c:out value="${workdata.workname}" /></td>
			<c:set var="currentworkid" value="${workdata.workid}" scope="request" />
			<c:set var="curofficecode" value="${workdata.officecode}"
				scope="request" />
			<%query = expenditure.prepareDivisionOfficeQuery((String) request
                        .getAttribute("curofficecode"), (String) request
                        .getAttribute("currentworkid"));
                ResultSet rh = sh.executeQuery(query);
               
                if (rh.next()) {
                divname = rh.getString(2);
                subdivname = rh.getString(4);                  
%>

			<c:if test="${divName eq null or divName eq 'null'}">
			<td class=rptValue><%=divname%></td>
			</c:if>
			<c:if test="${subdivName eq null or subdivName eq 'null'}">
			<td class=rptValue><%=subdivname%></td>
			</c:if>

			<%}

                %>
			<c:if test="${PlanName eq null or PlanName eq 'null'}">
				<td class="rptValue"><c:out value="${workdata.plannonplan}" /></td>
			</c:if>
			<c:if test="${workcName eq null or workcName eq 'null'}">
				<td class="rptValue"><c:out value="${workdata.categorycode}" /></td>
			</c:if>


			<%String queryscheme = expenditure
                        .prepareSchemeQuery((String) request
                                .getAttribute("currentworkid"));
                ResultSet rscheme = scheme.executeQuery(queryscheme);
                if (rscheme.next()) {

                    %>
			<c:if test="${schName eq null or schName eq 'null'}">
				<%schname = rscheme.getString(2);%>
				<td class="rptValue"><%=schname%></td>
			</c:if>

			<%}

                %>
			<c:if test="${augName eq null or augName eq 'null'}">
				<c:set var="substrofficecode" value="${workdata.substrofficecode}"
					scope="request" />
				<%augname = (String) request.getAttribute("substrofficecode");

                %>
				<td class="rptValue"><c:out value="${workdata.augumentation}" /></td>
			</c:if>
			<%String queryhh = expenditure
                        .prepareProgrammeQuery((String) request
                                .getAttribute("currentworkid"));
                //System.out.println("query program"+queryhh);
                ResultSet rq = qhh.executeQuery(queryhh);
                if (rq.next()) {

                    %>
			<c:if test="${progName eq null or progName eq 'null'}">
				<%pname = rq.getString(2);

                        %>
				<td class="rptValue"><%=pname%></td>
			</c:if>
			<c:if test="${sprogName eq null or sprogName eq 'null'}">
				<%subprog = rq.getString(4);

                        %>
				<td class="rptValue"><%=subprog%></td>
			</c:if>
			<%}

                %>
			<c:if
				test="${param.year eq null or param.year eq 'null' or param.year eq ''}">
				<c:set var="yearval" value="${workdata.substrofficecode1}"
					scope="request" />
				<td class="rptValue"><c:out value="${workdata.yearcode}" /></td>
			</c:if>
			<td colspan="8">&nbsp;</td>
			<%String expditureuptopreviousquery = expenditure
                        .previousYearExpenditureQuery((String) request
                                .getAttribute("currentworkid"));
                rs2 = st2.executeQuery(expditureuptopreviousquery);
                if (rs2.next())
                    expenditure_previous_year = rs2.getDouble(1);

                %>
		<tr>
			<td class="rptValue" colspan="<%=colcount%>" align="right"><%=expenditure_previous_year%></td>
		</tr>
		<tr>

			<%//PrintWriter mywriter=response.getWriter();

                JspWriter myout = pageContext.getOut();

                String queryyear = expenditure
                        .distinctYearQuery((String) request
                                .getAttribute("currentworkid"));
                rss = stmt3.executeQuery(queryyear);
                rss.afterLast();
                int no_of_years_wid = rss.getRow();
                no_of_years_for_workid = new String[no_of_years_wid];
                rss.beforeFirst();
                int no_of_months_for_year = 0;
                int val = 0, loop = 0;
                grandtotal = 0.0f;

                for (int counter = 0; rss.next(); counter++) {
                    //no_of_years_for_workid[counter]=isNull(rss.getString(1));
                    String no_of_coloumn_query = expenditure.countMonths(
                            (String) request.getAttribute("currentworkid"), rss
                                    .getString(1));
                    ResultSet countrs = st1.executeQuery(no_of_coloumn_query);
                    if (countrs.next()) {
                        no_of_months_for_year = countrs.getInt(1);
                        //  no_of_years_andmonths_workid.put(new Integer(no_of_months_for_year),no_of_years_for_workid[counter]);
                    }
                    no_of_months_for_year++;
                    String expenditureformonthquery = expenditure
                            .getexpenditureQuery((String) request
                                    .getAttribute("currentworkid"), rss
                                    .getString(1));
                    rs1 = st1.executeQuery(expenditureformonthquery);
                    int[] mon = new int[no_of_months_for_year];
                    String[] year = new String[no_of_months_for_year];
                    float[] expd = new float[no_of_months_for_year];
                    float[] valupto = new float[no_of_months_for_year];
                    float[] workd = new float[no_of_months_for_year];
                    String[] programme_nam = new String[no_of_months_for_year];
                    rs1.afterLast();
                    Counts = rs1.getRow();
                    rs1.beforeFirst();
                    int Counts1 = Counts;
                    rs1 = st1.executeQuery(expenditureformonthquery);
                    while (rs1.next()) {
                        year[val] = rs1.getString(1);
                        expd[val] = rs1.getFloat(3);
                        valupto[val] = rs1.getFloat(4);
                        workd[val] = rs1.getFloat(5);
                        mon[val] = rs1.getInt(6);
                        //				                          yearStart[val] = rs1.getInt(7);
                        programme_nam[val] = getProgrammeName(isNull(rs1
                                .getString(8)));

                        val++;
                    }
                    val = 0;

                   grandtotal += expenditure.caliculateTotalExpenditure(myout,year, mon, expd, valupto, workd, programme_nam,colcount);
                    //	System.out.println("Returned from class"+grandtotal);
                }

                // request.setAttribute("no_of_years_andmonths_workid",no_of_years_andmonths_workid);

                grandtotal = grandtotal
                        + new Float(expenditure_previous_year).floatValue();
                BigDecimal bd = new BigDecimal(Double.toString(grandtotal));
                bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
                grandtotal = Float.parseFloat("" + bd);

                %>
		<tr>
			<td align="right" colspan=<%=colcount+6%>>&nbsp;</td>
			<td align="left"><%=grandtotal%><%grandtotal = 0.0f;
			
            %></td>
		</tr>
		</tr>

	</c:forEach>

	<%!public String getProgrammeName(String code) throws Exception {
        String programme_name;
        if (code.length() == 0) {
            return code;
        } else {
            String qury = "select distinct programme_name from rws_programme_tbl p where programme_code='"
                    + code + "'";
            r = s.executeQuery(qury);
            r.next();
            programme_name = r.getString(1);
            return isNull(programme_name);
        }

    }

    %>


</table>
<p class="rptHeading" align="right"><b>Total No of Records is:<%=slno%></b></p>
<input type="hidden" name="pass"> <%@ include file="footer.jsp"%></form>
</body>
</html>
