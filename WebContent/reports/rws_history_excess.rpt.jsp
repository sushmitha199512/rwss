<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%
String workid=request.getParameter("workid");
String wname=request.getParameter("wname");
DecimalFormat ndf = new DecimalFormat("####.00");


String qry1="select  sum(PERCENT_COMPLETED_WORK_VAL),sum(PERCENT_COMPLETED_VAL)  from  RWS_WORK_MILESTONE_BILL_TBL where work_id='"+workid+"' ";
//System.out.println("qry1:"+qry1);
Statement stmt1=conn.createStatement();
ResultSet rs1=stmt1.executeQuery(qry1);
rs1.next();


%>
<table border = 0 width=20%  align="right">
<tr><td><a href="javascript:window.close()">Close</td></tr>
</table>
<br>
<table border = 0 cellspacing = 0 cellpadding = 0  width=80%  bordercolor=#000000 style="border-collapse:collapse">
<tr>
  <td class=btext>Work:<%=workid%>-<%=wname%></td></tr>
  <tr>
  <td class=btext>MileStone Target:<font color="black"><%=rs1.getString(1)%></font> &nbsp;&nbsp;&nbsp;MileStone Achivement:<font color="black"><%=rs1.getString(2)%></font></td></tr>
 </table>
<table border = 1 cellspacing = 0 cellpadding = 0  width=80%  bordercolor=#000000 style="border-collapse:collapse">
 <tr>
  <td class=btext>Sl.No</td>
  <td class=btext>Bill Sl No</td>
  <td class=btext>Bill No</td>
  <td class=btext>Bill Date</td>
  <td class=btext>Bill Amt Contractor(In Rs.)</td>
  <td class=btext>Bill Amt Admissible(In Rs.)</td>
  <td class=btext>Bill Entered Date</td>
  <td class=btext>EE Forward Date</td>
  </tr>

<%
double bcamt=0.0,bamt=0.0;
int cnt=1;
String qry="select  BILL_SL_NO,BILL_NO,to_char(BILL_DATE,'dd/MM/yyyy'),BILL_AMT_CONTRACTOR,BILL_AMT_ADMISSIBLE,to_char(UPDATE_DATE,'dd/MM/yyyy'),nvl(to_char(EE_FWD_DATE,'dd/MM/yyyy'),'-')  from rws_work_bill_tbl where work_id='"+workid+"' order by bill_sl_no ";
stmt=conn.createStatement();
////System.out.println("sss:"+qry);
rs=stmt.executeQuery(qry);
while(rs.next())
{%><tr>
  <td class=rptvalue><%=cnt++%></td>
  <td class=rptvalue><%=rs.getString(1)%></td>
  <td class=rptvalue><%=rs.getString(2)%></td>
  <td class=rptvalue><%=rs.getString(3)%></td>
  <td class=rptvalue align="right"><%=rs.getString(4)%></td>
 <td class=rptvalue align="right"><%=rs.getString(5)%></td>
 <td class=rptvalue><%=rs.getString(6)%></td>
 <td class=rptvalue><%=rs.getString(7)%></td>
</tr>
<%
   bcamt+=Double.parseDouble(rs.getString(4));
   bamt+=Double.parseDouble(rs.getString(5));
}
%>
<tr>
<td colspan=4 align="center">Total</td>
 <td class=rptvalue align="right"><%=ndf.format(bcamt)%></td>
  <td class=rptvalue align="right"><%=ndf.format(bamt)%></td>
</tr>
</table>
 <%@ include file = "/reports/connClose1.jsp" %>

 