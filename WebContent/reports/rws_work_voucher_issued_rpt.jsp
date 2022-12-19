
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%
String workid=request.getParameter("workid");
String slNo=request.getParameter("slNo");
stmt=conn.createStatement();
%>
<table width="100%"  align="center">
<tr><td align=right><a href="javascript:onClick=window.close()">Close&nbsp;</a>
</td></tr>
<tr><td  class=btext  align="center"> Work Id:&nbsp;<%=workid%></td></tr></table>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse" align="center" >

<tr align=center>
			<td class=btext>Sl No.</td>
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
String qry="select mbook_no,VOUCHER_no,to_char(VOUCHER_DT,'dd/mm/yyyy'),VOUCHER_AMT,nvl(CHEQUE_NO,'-'),nvl(to_char(CHEQUE_DT,'dd/mm/yyyy'),'-'),b.bill_no from rws_work_exp_voucher_tbl a,rws_work_bill_tbl b where a.bill_sl_no=b.bill_sl_no and a.work_id=b.work_id and a.work_id='"+workid+"'";
if(slNo!=null && !slNo.equals(""))qry+=" and MILESTONE_SLNO='"+slNo+"'";
qry += " order by MILESTONE_SLNO";
//System.out.println("vochers qry:"+qry);
rs=stmt.executeQuery(qry);
while(rs.next())
{ %>
<tr>
<td class=rptValue><%=++count%></td>
<td class=rptValue><%=rs.getString("bill_no")%></td>
<td class=rptValue><%=rs.getString(1)%></td>
<td class=rptValue><%=rs.getString(2)%></td>
<td class=rptValue><%=rs.getString(3)%></td>
<td class=rptValue><%=rs.getString(4)%></td>
<td class=rptValue><%=rs.getString(5)%></td>
<td class=rptValue><%=rs.getString(6)%></td>
</tr>
<% } 
%>
</table>
<p align="left">
<font face=verdana size=2 color=red>
&nbsp;&nbsp;&nbsp;Note****:
 <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=2 color=red>1. Amount Displayed is in Rupees
</font>
</p>
