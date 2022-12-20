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
<tr><td  class=rptHeading>Releases in the Program <font color=black><%=pname%></font> &nbsp; and &nbsp; Division:&nbsp;<font color=black><%=divname%></font></td></tr></table><BR>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse"  align="center">
<tr align=center>
			<td class=btext>Sl No.</td>
			<td class=btext>Work Id</td>
			<td class=btext>Work Name</td>
			<td class=btext>Bill No</td>			
			<td class=btext>Bill Date</td>
			<td class="btext" nowrap>Bill Amount <BR>(In Rupees)</td>
			<td class="btext">Bill Amount<br>Admissable</td>
	</tr>

<%
int count=0;
String qry= "";
DecimalFormat ndf = new DecimalFormat("####.00");
if(mode!=null && mode.equals("1"))
{
	qry = "select a.work_id,b.work_name,bill_no,to_char(bill_date,'dd/mm/yyyy'),bill_amt_contractor,bill_amt_admissible,bill_sl_no,bill_date from rws_work_bill_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id  and a.work_id not in(select c.work_id from rws_loc_master_tbl a,rws_loc_details_tbl b,rws_work_admn_tbl c where a.loc_id=b.loc_id and a.bro_id=b.bro_id and b.work_id is not null and b.work_id=c.work_id) and b.programme_code='"+pcode+"' and substr(office_code,2,3)='"+dcode+"' and bill_sl_no<>'0' order by bill_date desc";
}
else if(mode!=null && mode.equals("2"))
{
	qry = "select a.work_id,b.work_name,bill_no,to_char(bill_date,'dd/mm/yyyy'),bill_amt_contractor,bill_amt_admissible,bill_sl_no,bill_date from rws_work_bill_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id  and a.work_id in(select c.work_id from rws_loc_master_tbl a,rws_loc_details_tbl b,rws_work_admn_tbl c where a.loc_id=b.loc_id and a.bro_id=b.bro_id and b.work_id is not null and b.work_id=c.work_id)  and b.programme_code='"+pcode+"'  and substr(office_code,2,3)='"+dcode+"' and bill_sl_no<>'0' order by bill_date desc";
}
else if(mode!=null && mode.equals("3"))
{
	qry = "select a.work_id,b.work_name,bill_no,to_char(bill_date,'dd/mm/yyyy'),bill_amt_contractor,bill_amt_admissible,bill_sl_no,bill_date from rws_work_bill_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id  and a.work_id not in(select c.work_id from rws_loc_master_tbl a,rws_loc_details_tbl b,rws_work_admn_tbl c where a.loc_id=b.loc_id and a.bro_id=b.bro_id and b.work_id is not null and b.work_id=c.work_id) and b.programme_code='"+pcode+"'  and substr(office_code,2,3)='"+dcode+"'  and bill_sl_no<>'0' union select a.work_id,b.work_name,bill_no,to_char(bill_date,'dd/mm/yyyy'),bill_amt_contractor,bill_amt_admissible,bill_sl_no,bill_date from rws_work_bill_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id  and a.work_id in(select c.work_id from rws_loc_master_tbl a,rws_loc_details_tbl b,rws_work_admn_tbl c where a.loc_id=b.loc_id and a.bro_id=b.bro_id and b.work_id is not null and b.work_id=c.work_id) and b.programme_code='"+pcode+"' and substr(office_code,2,3)='"+dcode+"' and bill_sl_no<>'0'  " ;
	qry += " order by bill_date desc";
}
//// System.out.println("qry3:"+qry);
rs=stmt.executeQuery(qry);
double ddd = 0.0;double ddd1 = 0.0;
while(rs.next())
{ 
	ddd += Double.parseDouble(rs.getString(5));ddd1 += Double.parseDouble(rs.getString(6));
%>
<tr>
<td class=rptValue><%=++count%></td>
<td class=rptValue><%=rs.getString(1)%></td>
<td class=rptValue><%=rs.getString(2)%></td>
<td class=rptValue><%=rs.getString(3)%></td>
<td class=rptValue><%=rs.getString(4)%></td>
<td class=rptValue align="right"><%=ndf.format(Double.parseDouble(rs.getString(5)))%></td>
<td class=rptValue align="right"><%=ndf.format(Double.parseDouble(rs.getString(6)))%></td>
</tr>
<% } 
%>
<tr>
<td class=rptHeading colspan="5" align="center">Total</td>
<td class=rptValue align="right"><%=ndf.format(ddd)%></td>
<td class=rptValue align="right"><%=ndf.format(ddd1)%></td>
</tr>
</table>
<p align="left">
<font face=verdana size=2 color=red>
&nbsp;&nbsp;&nbsp;Note****:
 <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=2 color=red>1. Amount Displayed is in Rupees
</font>
</p>