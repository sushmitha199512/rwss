<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%
nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
String userId = users.getUserId(); stmt=conn.createStatement();
%>
<table width="100%"  align="center">
<tr><td align=right><a href="javascript:onClick=window.close()">Close&nbsp;</a>
</td></tr>
<tr><td  class=btext  align="center"> Pending Vouchers for the User :&nbsp;<%=userId%></td></tr></table>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse" align="center" >

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
String qry = "select mbook_no,VOUCHER_no,to_char(VOUCHER_DT,'dd/mm/yyyy'),VOUCHER_AMT*100000,nvl(CHEQUE_NO,'-'),nvl(to_char(CHEQUE_DT,'dd/mm/yyyy'),'-'),b.bill_no,c.work_id,c.work_name,c.admin_no from rws_work_exp_voucher_tbl a,rws_work_bill_tbl b,rws_work_admn_tbl c where a.work_id=b.work_id and b.work_id=c.work_id and a.work_id=c.work_id and substr(c.office_code,2,3)='"+userId.substring(1,4)+"' and a.bill_sl_no=b.bill_sl_no and a.work_id=b.work_id order by MILESTONE_SLNO";
//System.out.println("qry in jsp:"+qry);
rs=stmt.executeQuery(qry);
while(rs.next())
{ %>
<tr>
<td class=rptValue><%=++count%></td>
<td class=rptValue><%=rs.getString("work_id")%></td>
<td class=rptValue><%=rs.getString("work_name")%></td>
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
 <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=2 color=red>2. Cheque No '-' is represents New Vouchers
</font>
</p>
