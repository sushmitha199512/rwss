<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>
<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>

<script>
function openwin(workid,wname)
{
	var width = 800; 
	var height = 400;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var url = "rws_history_excess.rpt.jsp?workid="+workid+"&wname="+wname;
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes,left=50,top=50";
	newWindow = window.open(url, "_New", properties);
	newWindow.focus();

}
</script>
<table align="right" width="20%">
<tr>
<td class=rptvalue><a href="rws_payment_Excess_xls.jsp" target="_new">Excel</a>|<a href="#" onclick="javascript:window.close()">Close</a></td></tr>
<table border = 0 cellspacing = 0 cellpadding = 0  width=80%  bordercolor=#000000 style="border-collapse:collapse">
<tr>
<td class=btext align="center">Payment Excess Report</td>
</tr></table>

<table >
 <tr>
<td width="30%" bgcolor="pink" bordercolor="black"></td><td class=rptValue>&nbsp;-&nbsp;Manually Payments made </td></tr>
<tr><td width="30%" bgcolor="red" bordercolor="black"></td><td class=rptValue nowrap>&nbsp;-&nbsp;Central/State  Payments Made </td></tr>
<tr><td width="30%" bgcolor="green" bordercolor=""></td><td class=rptValue>&nbsp;-&nbsp;No Payments Made(Fresh Bill) </td></tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0  width=80%  bordercolor=#000000 style="border-collapse:collapse">
<tr>
<td class=btext align="center">Sl.No</td>
<td class=btext align="center">Division</td>
<td class=btext align="center">Work Id/<BR>Work Name</td>
<td class=btext align="center">Program/<BR>subprogram</td>
<td class=btext align="center">Bill No/<BR>Bill Date/<BR>Bill Enterd Date</td>
<td class=btext align="center">Bill Amount Contractor</td>
<td class=btext align="center">Bill Amount Admissible</td>
<td class=btext align="center">Payment Excess</td>
<td class=btext align="center">Central Txid</td>
<td class=btext align="center">Central Amount</td>
<td class=btext align="center">State Txid</td>
<td class=btext align="center">State Amount</td>
<td class=btext align="center">Manual Cental Amt</td>
<td class=btext align="center">Manual State Amt</td>
<td class=btext align="center">Paid Through Vouchers</td>


</tr>
<tr>
<td class=btext align="center">1</td>
<td class=btext align="center">2</td>
<td class=btext align="center">3</td>
<td class=btext align="center">4</td>
<td class=btext align="center">5</td>
<td class=btext align="center">6</td>
<td class=btext align="center">7</td>
<td class=btext align="center">8(7-6)</td>
<td class=btext align="center">9</td>
<td class=btext align="center">10</td>
<td class=btext align="center">11</td>
<td class=btext align="center">12</td>
<td class=btext align="center">13</td>
<td class=btext align="center">14</td>
<td class=btext align="center">15</td>


</tr>
 <%

 int cnt=1;
 Hashtable ht=new  Hashtable();
String qry1="select a.work_id||a.bill_sl_no,b.txid||'@'||BILL_AMOUNT_CENTRAL from rws_work_bill_tbl a, RWS_BILL_BANK_BRIDGE_DET_TBL b where BILL_AMT_CONTRACTOR < BILL_AMT_ADMISSIBLE and a.work_id=b.work_id and a.bill_sl_no=b.bill_sl_no and bill_activation_flag='P' and txid is not null ";
Statement stmt1=conn.createStatement();
ResultSet rs1=stmt1.executeQuery(qry1);
while(rs1.next())
{
	ht.put(rs1.getString(1),rs1.getString(2));
}
String qry2="select a.work_id||a.bill_sl_no,b.state_txid||'@'||BILL_AMOUT_state from rws_work_bill_tbl a, RWS_BILL_PAO_BRIDGE_DET_TBL b where BILL_AMT_CONTRACTOR < BILL_AMT_ADMISSIBLE and a.work_id=b.work_id and a.bill_sl_no=b.bill_sl_no and bill_activation_flag='P' and state_txid is not null ";
Statement stmt2=conn.createStatement();
ResultSet rs2=stmt2.executeQuery(qry2);
Hashtable ht1=new  Hashtable();
while(rs2.next())
{
	ht1.put(rs2.getString(1),rs2.getString(2));
}

String qry3=" select work_id||bill_sl_no,bill_amount_central ||'@'||bill_amout_state from rws_bill_bank_bridge_tbl where  txid is null and state_txid is null  ";
 Statement stmt3=conn.createStatement();
ResultSet rs3=stmt3.executeQuery(qry3);
Hashtable ht2=new  Hashtable();
while(rs3.next())
{
	ht2.put(rs3.getString(1),rs3.getString(2));
}
String qry4=" select work_id||bill_sl_no,sum(voucher_amt) from  rws_work_exp_voucher_tbl group by  work_id||bill_sl_no";
 Statement stmt4=conn.createStatement();
ResultSet rs4=stmt4.executeQuery(qry4);
Hashtable ht3=new  Hashtable();
while(rs4.next())
{
	ht3.put(rs4.getString(1),rs4.getString(2));
}

 String qry="select a.work_id||a.bill_sl_no,b.work_name,bill_no,to_char(bill_date,'dd/MM/yyyy'), to_char (update_date,'dd/MM/yyyy'),bill_amt_contractor,bill_amt_admissible,(BILL_AMT_ADMISSIBLE - BILL_AMT_CONTRACTOR ),a.work_id,division_office_name,programme_name,subprogramme_name from rws_work_bill_tbl a,rws_work_admn_tbl b,rws_division_office_tbl v,rws_programme_tbl p,rws_subprogramme_tbl s where a.work_id=b.work_id and BILL_AMT_CONTRACTOR < BILL_AMT_ADMISSIBLE and substr(a.work_id,5,2)=v.circle_office_code and substr(office_code,4,1) =v.division_office_code  and p.programme_code=s.programme_code and p.programme_code=b.programme_code and s.subprogramme_code=b.subprogramme_code   order by BILL_AMT_ADMISSIBLE - BILL_AMT_CONTRACTOR desc ";

stmt=conn.createStatement();
//System.out.println()l
rs=stmt.executeQuery(qry);
while(rs.next())
{
	String color="green";
	String css = "<font color=black face=verdana size=2>";	 
    String camt=""+ht.get(rs.getString(1));
      String a3="0",a4="0";
     if(camt!=null  && !camt.equals("")  && !camt.equals("null")) {
	 color="red";
	 css = "<font color=black face=verdana size=2>";	 
	 String []bb=camt.split("@");
	 a3=bb[0];a4=bb[1];}
	 String samt=""+ht1.get(rs.getString(1));
      String a1="0",a2="0";
     if(samt!=null  && !samt.equals("")  && !samt.equals("null")) {
	 color="red";
	 css = "<font color=black face=verdana size=2>";	 
	 String []bb1=samt.split("@");
	 a1=bb1[0];a2=bb1[1];}
     String namt=""+ht2.get(rs.getString(1));
	 String b1="0",b2="0";
	  if(namt!=null  && !namt.equals("")  && !namt.equals("null")) {
	 color="pink";
	 css = "<font color=black face=verdana size=2>";	 
	 String []aa=namt.split("@");
	 b1=aa[0];b2=aa[1];}
     String vamt=""+ht3.get(rs.getString(1));
	 if(vamt!=null  && (!vamt.equals("") && !vamt.equals("null"))) {}else{vamt="0";}

	%>
<tr  bgcolor="<%=color%>">
<td class=rptvalue ><%=cnt++%></td>
<td class=rptvalue ><%=rs.getString(10)%></td>
<td class=rptvalue><a href="#" onclick="openwin('<%=rs.getString(9)%>','<%=rs.getString(2)%>')"><font  color="blue" face="verdana" size="2"><%=rs.getString(9)%></a></font>/<BR><%=rs.getString(2)%></td>
<td class=rptvalue ><%=rs.getString(11)%>/<BR><%=rs.getString(12)%></td>
<td class=rptvalue ><%=rs.getString(3)%>/<BR><%=rs.getString(4)%>/<BR><%=rs.getString(5)%></td>
<td class=rptvalue align="right"><%=rs.getString(6)%></td>
<td class=rptvalue align="right"><%=rs.getString(7)%></td>
<td  align="right"><font  color="blue" face="verdana" size="2"><%=rs.getString(8)%></font></td>
<td class=rptvalue align="right"><%=a3%></td>
<td class=rptvalue align="right"><%=a4%></td>
<td class=rptvalue align="right"><%=a1%></td>
<td class=rptvalue align="right"><%=a2%></td>
<td class=rptvalue align="right"><%=b1%></td>
<td class=rptvalue align="right"><%=b2%></td>
<td class=rptvalue align="right"><%=vamt%></td>


</tr>
<%} %>
<%@ include file = "/reports/connClose1.jsp" %>

<!-- select count(*),division_office_name from rws_work_bill_tbl a,rws_work_admn_tbl b,rws_division_office_tbl v where a.work_id=b.work_id and BILL_AMT_CONTRACTOR < BILL_AMT_ADMISSIBLE and substr (a.work_id,5,2)=v.circle_office_code and substr(office_code,4,1)=v.division_office_code and (BILL_AMT_ADMISSIBLE- BILL_AMT_CONTRACTOR)>10000 group by division_office_name order by 1 -->