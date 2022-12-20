<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%
String dcode=request.getParameter("divcode");
String pcode=request.getParameter("pcode");
String divname=request.getParameter("divname");
String mode = request.getParameter("mode");
String pname=request.getParameter("pname");
stmt=conn.createStatement();
%>
<table width="100%"  align="center">
<table border = 0 align="right">	
		<caption>
			<table  border=0 rules=none style="border-collapse:collapse" align = "right">		
				<tr>
					<td align="right" class="bwborder">
					<a href="javascript:window.close()">Close</a>
					</td>
				</tr>
			</table>
		</caption>
		</table>
<table align="center">
<tr><td  class=rptHeading>Releases in the Program &nbsp;<font color=black><%=pname%></font> &nbsp; and &nbsp;Division:&nbsp;<font color=black><%=divname%></font></td></tr></table><BR>
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
if(mode!=null && mode.equals("1"))
{
	
	qry="select distinct mbook_no,VOUCHER_no,to_char(VOUCHER_DT,'dd/mm/yyyy'),VOUCHER_AMT,nvl(CHEQUE_NO,'-'),nvl (to_char (CHEQUE_DT,'dd/mm/yyyy'),'-'),b.bill_no,a.work_id,c.work_name,VOUCHER_DT from rws_work_exp_voucher_tbl a,rws_work_bill_tbl b,rws_work_admn_tbl c where a.work_id=b.work_id and b.work_id=c.work_id and a.work_id=c.work_id AND A.WORK_ID NOT in(select WORK_ID from rws_loc_master_tbl a,rws_loc_details_tbl b where a.loc_id=b.loc_id and a.bro_id=b.bro_id and b.work_id is NOT null) and a.programme_code='"+pcode+"' and a.BILL_SL_NO <> '0' and a.bill_sl_no=b.bill_sl_no  and substr(office_code,2,3)='"+dcode+"' order by VOUCHER_DT desc";
}
else if(mode!=null && mode.equals("2"))
{
	
	qry = "select distinct mbook_no,VOUCHER_no,to_char(VOUCHER_DT,'dd/mm/yyyy'),VOUCHER_AMT,nvl(CHEQUE_NO,'-'),nvl (to_char (CHEQUE_DT,'dd/mm/yyyy'),'-'),b.bill_no,a.work_id,c.work_name,VOUCHER_DT from rws_work_exp_voucher_tbl a,rws_work_bill_tbl b,rws_work_admn_tbl c where a.work_id=b.work_id and b.work_id=c.work_id and a.work_id=c.work_id AND A.WORK_ID in(select WORK_ID from rws_loc_master_tbl a,rws_loc_details_tbl b where a.loc_id=b.loc_id and a.bro_id=b.bro_id and b.work_id is NOT null) and  a.programme_code='"+pcode+"' and a.BILL_SL_NO <> '0' and a.bill_sl_no=b.bill_sl_no  and substr(office_code,2,3)='"+dcode+"'  order by VOUCHER_DT desc";
}
else if(mode!=null && mode.equals("3"))
{
	
	qry = "select distinct mbook_no,VOUCHER_no,to_char(VOUCHER_DT,'dd/mm/yyyy'),VOUCHER_AMT,nvl(CHEQUE_NO,'-'),nvl (to_char (CHEQUE_DT,'dd/mm/yyyy'),'-'),b.bill_no,a.work_id,c.work_name,VOUCHER_DT from rws_work_exp_voucher_tbl a,rws_work_bill_tbl b,rws_work_admn_tbl c where a.work_id=b.work_id and b.work_id=c.work_id and a.work_id=c.work_id AND A.WORK_ID NOT in(select WORK_ID from rws_loc_master_tbl a,rws_loc_details_tbl b where a.loc_id=b.loc_id and a.bro_id=b.bro_id and b.work_id is NOT null) and a.programme_code='"+pcode+"' and a.BILL_SL_NO <> '0' and a.bill_sl_no=b.bill_sl_no and substr(office_code,2,3)='"+dcode+"' union select distinct mbook_no,VOUCHER_no,to_char(VOUCHER_DT,'dd/mm/yyyy'),VOUCHER_AMT,nvl(CHEQUE_NO,'-'),nvl (to_char (CHEQUE_DT,'dd/mm/yyyy'),'-'),b.bill_no,a.work_id,c.work_name,VOUCHER_DT from rws_work_exp_voucher_tbl a,rws_work_bill_tbl b,rws_work_admn_tbl c where a.work_id=b.work_id and b.work_id=c.work_id and a.work_id=c.work_id AND A.WORK_ID in(select WORK_ID from rws_loc_master_tbl a,rws_loc_details_tbl b where a.loc_id=b.loc_id and a.bro_id=b.bro_id and b.work_id is NOT null) and a.programme_code='"+pcode+"' and a.BILL_SL_NO <> '0' and a.bill_sl_no=b.bill_sl_no  and substr(office_code,2,3)='"+dcode+"' ";

	qry += "order by VOUCHER_DT desc";

}
// System.out.println("qry2:"+qry);
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