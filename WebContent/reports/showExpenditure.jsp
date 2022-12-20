
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ page import="javax.servlet.jsp.*" %>
<%@ page import="java.math.BigDecimal"%>
<%@ include file="conn.jsp"%>

<HEAD>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page import="java.sql.*,java.util.*" %>		
<META http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<META name="GENERATOR" content="IBM Software Development Platform">
<META http-equiv="Content-Style-Type" content="text/css">
<LINK href="../theme/Master.css" rel="stylesheet" type="text/css">
<TITLE></TITLE>
<script language="javascript">
function showDiv()
{
	if(document.getElementById('hide').style.display=='none')
		document.getElementById('hide').style.display='block';
	else 
		document.getElementById('hide').style.display='none';
}
</script>
</HEAD>
<BODY>
<%! 
Statement st1 = null, s = null, s1 = null, s2 = null, s3 = null, ss = null,
            stmt3 = null;

    Statement st2 = null, st22 = null, ss1 = null;

    ResultSet rs2 = null, r = null, r1 = null, r2 = null, rr = null,
            rss = null, rr1 = null, rss1 = null;

    Statement stmt1 = null;

    ResultSet rs1 = null;
	int    colcount=0;

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

    }%>
    <% 
    stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    st1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    st2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    s = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    stmt3=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
    %>
    


<jsp:useBean id="expenditure" class="nic.watersoft.reports.rws_ExpenditureReport" />
<%String wid=request.getParameter("workid"); %>

<%
int len=wid.length();
for(int i=len;i<14;i++)
{
wid="0"+wid;
}%>
<BR>
<%
int snno=1;
double totExp = 0.0;
Statement stt = conn.createStatement();
ResultSet rss = stt.executeQuery("select sum(total),year from rws_exp_view where work_id='"+wid+"' group by year order by 2 ");
%>
<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#000000" style="border-collapse:collapse;display:block">
<caption align="right" class="staticLabel"><b>(Amount in Rs. lakhs )</b></caption>
<tr bgcolor="#8A9FCD" align="center">	<td align="center" class="rptHeading" colspan=3>Work Expenditure Details Year Wise for the WorkId:  <%=wid %></td></tr>
<tr class="rptHeading" >
	<td>S.No.</td>
	<td>Financial Year</td>
	<td>Total Expenditure</td>
</tr>
<%while(rss.next()){
	totExp += rss.getDouble(1);%>
<tr>
	<td><%=snno++%></td>
	<td><%=rss.getString(2)%></td>
	<td><%=rss.getString(1)%></td>
</tr>
<%}
	BigDecimal bdd = new BigDecimal(Double.toString(totExp));
	    bdd = bdd.setScale(2,BigDecimal.ROUND_HALF_UP);
%>
<tr>
	<td colspan=2  class="rptHeading" align=center>Total Expenditure</td>
	<td  class="rptHeading" onclick="showDiv()" style="cursor:hand"><%=bdd.doubleValue()%>&nbsp;&nbsp;&nbsp;<--Click here to View/Hide Month Wise Details</td>
</tr>
</table>
<%if(rss!=null)rss.close();
if(stt!=null)stt.close();%>
<br>
<div id="hide" style="display:none">
<%String expditureuptopreviousquery = expenditure
                        .previousYearExpenditureQuery(wid);
                rs2 = st2.executeQuery(expditureuptopreviousquery);
                if (rs2.next())
                    expenditure_previous_year = rs2.getDouble(1);

                %>
				<table width="100%" cellspacing="0" cellpadding="2" border="0" bordercolor="#000000" 
			   style="border-collapse:collapse;display:block"><tr>
		<td align="right">
<!-- 		<a	href="./showExpenditureExcel.jsp?workid=<%=wid%>" target="_new">Excel</a> -->
		</td>
	</tr></table>
			<table width="100%" cellspacing="0" cellpadding="2" border="1" bordercolor="#000000" 
			   style="border-collapse:collapse;display:block">
<caption align="right" class="staticLabel"><b>(Amount in Rs. lakhs )</b></caption>
			 <tr bgcolor="#8A9FCD" align="center">
		
		<td align="center" class="rptHeading" colspan=17>Work Expenditure
		Details Month Wise for the WorkId   <%=wid %>    </td>
	</tr>
				<!-- <tr>
				<td align="center" colspan="7" class="btext">
				Expenditure upto previous year
				</td>
				<td class="rptValue"  align="right">&nbsp;&nbsp;<%=expenditure_previous_year%></td>
				</tr> -->
				<tr><td style="width:0px"></td>
				<td class="btext" >PROGRAMME</td>
				<td class="btext" >YEAR</td>
				<td class="btext" >MONTH</td>
				<td class="btext" >UPTO PERVIOUS MONTH</td>
				<td class="btext" >CURRENT MONTH</td>
				<td class="btext" >VALUE OF WORK NOT PAID</td>
				<td class="btext" colspan="2">TOTAL EXPENDITURE</td>
				<tr>

			<%//PrintWriter mywriter=response.getWriter();

                JspWriter myout = pageContext.getOut();

                String queryyear = expenditure
                        .distinctYearQuery(wid);
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
                            wid, rss
                                    .getString(1));
                    ResultSet countrs = st1.executeQuery(no_of_coloumn_query);
                    if (countrs.next()) {
                        no_of_months_for_year = countrs.getInt(1);
                        //  no_of_years_andmonths_workid.put(new Integer(no_of_months_for_year),no_of_years_for_workid[counter]);
                    }
                    no_of_months_for_year++;
                    String expenditureformonthquery = expenditure
                            .getexpenditureQuery(wid, rss
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

                    grandtotal += expenditure.caliculateTotalExpenditure(myout,
                            year, mon, expd, valupto, workd, programme_nam,
                            colcount);
                    //	System.out.println("Returned from class"+grandtotal);
                }

                // request.setAttribute("no_of_years_andmonths_workid",no_of_years_andmonths_workid);

                grandtotal = grandtotal;
//                        + new Float(expenditure_previous_year).floatValue();
                BigDecimal bd = new BigDecimal(Double.toString(grandtotal));
                bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
                grandtotal = Float.parseFloat("" + bd);

                %>
		<tr>
			<td align="right" colspan=<%=colcount+7%>>&nbsp;</td>
			<td align="left"><%=grandtotal%><%grandtotal = 0.0f;
			
            %></td>
		</tr>
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
</div>
<input type="hidden" name="pass"> <%@ include file="footer.jsp"%>
</body>
</html>


