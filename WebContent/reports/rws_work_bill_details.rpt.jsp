<%
DecimalFormat ndf = new DecimalFormat("####.##");
  workid=request.getParameter("workId");
//System.out..println("workid in bill details jsp:"+workid);
%>
  
<%@page import="java.text.DecimalFormat"%><table >

 	<tr align="center">
		<td align="left" class="rptHeading" colspan=8>IX.Bill Details&nbsp;&nbsp;&nbsp;&nbsp;(Amount In Lakhs) </font></td>	
	</tr>
		<tr  bgcolor="#ffffff">
			<td class="btext">S.No</td>
		    <td class="btext">Bill No</td>
			<td class="btext">Bill Sl No</td>
			<td class="btext">Bill Date</td>
			<td class="btext">Bill Entered Date</td>
			<td class="btext">EE Forwarded Date</td>
			<td class="btext">Bill Amt Contractor</td>
			<td class="btext">Bill Amt Admissible</td>
			
		</tr>
<%int cnt=0;double bcamt=0.0,bamt=0.0;
String bqry="select bill_no,bill_sl_no,to_char(bill_date,'dd/MM/yyyy'),to_char(update_date,'dd/MM/yyyy'), bill_amt_contractor/100000, bill_amt_admissible/100000,to_char(ee_fwd_date,'dd/MM/yyyy') from rws_work_bill_tbl where work_id='"+workid+"' ";
stmt=conn.createStatement();
rs=stmt.executeQuery(bqry);
while(rs.next())
{%>
  <tr>
  	<td class=rptvalue><%=++cnt%></td>
	<td class=rptvalue><%=rs.getString(1)%></td>
	<td class=rptvalue><%=rs.getString(2)%></td>
	<td class=rptvalue><%=rs.getString(3)%></td>
	<td class=rptvalue><%=rs.getString(4)%></td>
	<td class=rptvalue><%=rs.getString(7)%></td>
	<td class=rptvalue align="right"><%= ndf.format(Double.parseDouble(rs.getString(5)))%></td>
	<td class=rptvalue align="right"><%=ndf.format(Double.parseDouble(rs.getString(6)))%></td>
  </tr>
<%
bcamt+=Double.parseDouble(rs.getString(5));
bamt+=Double.parseDouble(rs.getString(6));
}%>

<%

 bqry="select bill_no,bill_sl_no,to_char(bill_date,'dd/MM/yyyy'),to_char(update_date,'dd/MM/yyyy'), bill_amt_contractor/100000, bill_amt_admissible/100000 from rws_work_direct_bill_tbl where work_id='"+workid+"' ";
Statement stmt11=conn.createStatement();
ResultSet rsr=stmt11.executeQuery(bqry);
while(rsr.next())
{%>
  <tr>
  	<td class=rptvalue><%=++cnt%></td>
	<td class=rptvalue><%=rsr.getString(1)%></td>
	<td class=rptvalue><%=rsr.getString(2)%></td>
	<td class=rptvalue><%=rsr.getString(3)%></td>
	<td class=rptvalue><%=rsr.getString(4)%></td>
	<td class=rptvalue>-</td>
	<td class=rptvalue align="right"><%= ndf.format(Double.parseDouble(rsr.getString(5)))%></td>
	<td class=rptvalue align="right"><%=ndf.format(Double.parseDouble(rsr.getString(6)))%></td>
  </tr>
<%
bcamt+=Double.parseDouble(rsr.getString(5));
bamt+=Double.parseDouble(rsr.getString(6));
}%>
<tr><td class=btext colspan=6>Total</td>
<td class=btext align="right"><b><font color="red"><%=ndf.format(bcamt)%></font></td>
<td class=btext align="right"><b><font color="red"><%=ndf.format(bamt)%></font></td></tr>





 	<tr align="center">
		<td align="left" class="rptHeading" colspan=8>X.Voucher Details &nbsp;&nbsp;&nbsp;&nbsp;(Amount In Lakhs) </font></td>	
	</tr>

	
		<tr  bgcolor="#ffffff">
			<td class="btext">S.No</td>
		   	<td class="btext">Bill Sl No</td>
			<td class="btext">Voucher No</td>
			<td class="btext">Voucher Date</td>
			<td class="btext">M Book No</td>
			<td class="btext">Cheque No</td>
			<td class="btext">Cheque Date </td>
			 <td class="btext">Voucher Amt</td>
			
		</tr>
<%int cnt1=0;double vamt=0.0;
String vqry="select BILL_SL_NO,VOUCHER_NO,to_char(VOUCHER_DT,'dd/MM/yyyy'), MBOOK_NO ,CHEQUE_NO,to_char(CHEQUE_DT,'dd/MM/yyyy'),VOUCHER_AMT/100000 from rws_work_exp_voucher_tbl  where work_id='"+workid+"' ";
Statement vstmt=conn.createStatement();
ResultSet vrs=vstmt.executeQuery(vqry);
while(vrs.next()){
%><tr>
	<td class=rptvalue><%=++cnt1%></td>
	<td class=rptvalue><%=vrs.getString(1)%></td>
	<td class=rptvalue><%=vrs.getString(2)%></td>
	<td class=rptvalue><%=vrs.getString(3)%></td>
	<td class=rptvalue><%=vrs.getString(4)%></td>
	<td class=rptvalue><%=vrs.getString(5)%></td>
	<td class=rptvalue><%=vrs.getString(6)%></td>
	<td class=rptvalue align="right"><%=ndf.format(Double.parseDouble(vrs.getString(7)))%></td>
	</tr>
 <%
 vamt+=Double.parseDouble(vrs.getString(7));	
}%>


<%

 vqry="select BILL_SL_NO,VOUCHER_NO,to_char(VOUCHER_DT,'dd/MM/yyyy'), MBOOK_NO ,CHEQUE_NO,to_char(CHEQUE_DT,'dd/MM/yyyy'),VOUCHER_AMT/100000 from rws_work_exp_voucher_tbl  where work_id='"+workid+"' ";
Statement vstmt11=conn.createStatement();
ResultSet vrs11=vstmt11.executeQuery(vqry);
while(vrs11.next()){
%><tr>
	<td class=rptvalue><%=++cnt1%></td>
	<td class=rptvalue><%=vrs11.getString(1)%></td>
	<td class=rptvalue><%=vrs11.getString(2)%></td>
	<td class=rptvalue><%=vrs11.getString(3)%></td>
	<td class=rptvalue><%=vrs11.getString(4)%></td>
	<td class=rptvalue><%=vrs11.getString(5)%></td>
	<td class=rptvalue><%=vrs11.getString(6)%></td>
	
	<td class=rptvalue align="right"><%=ndf.format(Double.parseDouble(vrs11.getString(7)))%></td>
	</tr>
 <%
 vamt+=Double.parseDouble(vrs11.getString(7));	
}%>
<tr><td class=btext colspan=7>Total</td>
<td class=btext align="right"><b><font color="red"><%=ndf.format(vamt)%></font></td>
</tr>


 

 	<tr align="center">
		<td align="left" class="rptHeading" colspan=8>XI.Payment Details </font></td>	
	</tr>
	<tr  bgcolor="#ffffff">
	<td class=btext> Sl No</td>
	<td class=btext>Bill Sl No</td>
	<td class=btext>Bank Send Date</td>
	<td class=btext> Central Releases</td>
	<td class=btext>State Send Date</td>
	<td class=btext> State Releases</td>
	</tr>
	
<%int pcount=0;
String pbqry="select bill_sl_no,nvl(to_char(bank_send_date,'dd/MM/yyyy'),'-'),nvl(bill_amount_central,'0')/100000,nvl(to_char(state_send_date,'dd/MM/yyyy'),'-'),nvl(bill_amout_state,'0')/100000 from rws_bill_bank_bridge_tbl where work_id='"+workid+"'  and bill_activation_flag='P' ";
////System.out..println(pbqry);
Statement pbstmt=conn.createStatement();
ResultSet prs=pbstmt.executeQuery(pbqry);
double bankamt=0,stateamt=0;
while(prs.next())
{%>
<tr>
<td class=rptvalue><%=++pcount%></td>
<td class=rptvalue><%=prs.getString(1)%></td>
<td class=rptvalue><%=prs.getString(2)%></td>
<td class=rptvalue align=right><%= ndf.format(Double.parseDouble(prs.getString(3)))%></td>
<td class=rptvalue><%=prs.getString(4)%></td>
<td class=rptvalue align="right"><%= ndf.format(Double.parseDouble(prs.getString(5)))%></td>
 
</tr>
<%

bankamt+=Double.parseDouble(prs.getString(3));
stateamt+=Double.parseDouble(prs.getString(5));
}
%>
<tr><td class=btext colspan=3>Total</td>
<td class=btext align="right"><b><font color="red"><%=ndf.format(bankamt)%></font></td>
<td class=btext>-</td>
<td class=btext align="right"><b><font color="red"><%=ndf.format(stateamt)%></font></td>
</tr>
</table>
