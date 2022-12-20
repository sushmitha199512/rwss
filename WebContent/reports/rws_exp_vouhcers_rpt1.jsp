<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%
String dcode=request.getParameter("dcode");
String dname=request.getParameter("dnamee");
String divcode=request.getParameter("divcode");
String divname=request.getParameter("divname");
String mode = request.getParameter("mode");
String special = request.getParameter("special");
String pcode=request.getParameter("pcode");
String pname=request.getParameter("pname");
String pQry = "";
if(special!=null && special.equals("Y")) pQry = "and c.programme_code in ('02','01','48','32','23','49','51','18','37')";
stmt=conn.createStatement();
%>
<table width="100%"  align="center">
<table align="center">
<tr><td align=right><a href="javascript:onClick=window.close()">Close&nbsp;</a>
</td></tr>
<tr><td  class=rptHeading>Expenditure(through Vouchers) in the District:&nbsp;<%=dname%> and Division:&nbsp;<%=divname%> and Program:&nbsp;<%=pname%></td></tr></table><BR>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse"  align="center">
<tr align=center>
			<td class=btext>Sl No.</td>
			<td class=btext>Work Id</td>
			<td class=btext>Work Name</td>
			<td class=btext>Bill No</td>			
			<td class=btext>M Book No</td>			
			<td class=btext>Voucher No</td>
			<td class=btext>Voucher Date</td>
			<td class=btext>Voucher Amount</td>
			<td class=btext>Cheque No</td>			
			<td class=btext>Cheque Date</td>
			</tr>

<%
int count=0;
String qry= "";
DecimalFormat ndf = new DecimalFormat("####.00");
qry = "select distinct mbook_no,VOUCHER_no,to_char(VOUCHER_DT,'dd/mm/yyyy'),VOUCHER_AMT,nvl(CHEQUE_NO,'-'),nvl (to_char (CHEQUE_DT,'dd/mm/yyyy'),'-'),b.bill_no,a.work_id,c.work_name,VOUCHER_DT from rws_work_exp_voucher_tbl a,rws_work_bill_tbl b,rws_work_admn_tbl c where a.work_id=b.work_id and b.work_id=c.work_id and a.work_id=c.work_id  and substr(office_code,2,3)='"+dcode+divcode+"' and a.BILL_SL_NO <> '0' and a.bill_sl_no=b.bill_sl_no  and c.programme_code='"+pcode+"' order by VOUCHER_DT desc";
//System.out.println("qry22222222:"+qry);
rs=stmt.executeQuery(qry);
double ddd = 0.0;
while(rs.next())
{ 
	ddd += rs.getDouble(4);
%>
<tr>
<td class=rptValue><%=++count%></td>
<td class=rptValue><%=rs.getString("work_id")%></td>
<td class=rptValue><%=rs.getString("work_name")%></td>
<td class=rptValue><%=rs.getString("bill_no")%></td>
<td class=rptValue><%=rs.getString(1)%></td>
<td class=rptValue><%=rs.getString(2)%></td>
<td class=rptValue><%=rs.getString(3)%></td>
<td class=rptValue align="right"><%=ndf.format(Double.parseDouble(rs.getString(4)))%></td>
<td class=rptValue><%=rs.getString(5)%></td>
<td class=rptValue><%=rs.getString(6)%></td>
</tr>
<% } 
%>
<tr>
<td class=rptHeading colspan="7" align="center">Total</td>
<td class=rptValue align="right"><%=ndf.format(ddd)%></td>
<td class=rptHeading colspan="2" align="center"></td>
</tr>
</table>
<p align="left">
<font face=verdana size=2 color=red>
&nbsp;&nbsp;&nbsp;Note****:
 <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=2 color=red>1. Amount Displayed is in Rupees
</font>
</p>