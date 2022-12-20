<%@ include file="/commons/rws_header1.jsp"%>

<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file = "/reports/conn.jsp" %>

<%
 String dist=request.getParameter("district");
 String div=request.getParameter("division");
 String frmDate = request.getParameter("frmDate");
 String toDate = request.getParameter("toDate");
 String dname=request.getParameter("dname");
 String divname=request.getParameter("divname");
 String billType=request.getParameter("bill");
%>

<table cellspacing = 0 cellpadding = 0  width="100%"  align="center">
<tr><td class=btext align="left" colspan="15">Division Wise Bill-Voucher Details Report</td></tr>
<tr><td class=btext align="left"  colspan="15">District:<font face="verdana" size="1" color="black"><%=dname%></font>&nbsp;Division:<font face="verdana" size="1" color="black"><%=divname%></font>From Date:<font face="verdana" size="1" color="black"><%=frmDate%></font>&nbsp;To Date:<font face="verdana" size="1" color="black"><%=toDate%></font></td></tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0  width=100%  bordercolor=#000000 style="border-collapse:collapse">
<tr><td class=btext>Sl.No</td>
<td class=btext>Work Id</td>
<td class=btext>Work Name</td>
<td class=btext>Program</td>
<td class=btext nowrap>Sub Program</td>
<td class=btext>Estimate Cost(in lakhs)</td>
<td class=btext>Bill NO</td>
<td class=btext>Bill Date</td>
<td class=btext>Bill Entered Date</td>
<td class=btext>Bill Amount Contractor<br>(in Rs)</td>
<td class=btext>Bill Amount Admissible<br>(in Rs)</td>
<td class=btext>Voucher Amount<br>(in Rs)</td>
<td class=btext>Amount Due from <br>the Bill(in Rs)</td>
</tr>
<tr>
<td class=btext align="center">1</td>
<td class=btext align="center">2</td>
<td class=btext align="center">3</td>
<td class=btext align="center">4</td>
<td class=btext align="center">5</td>
<td class=btext align="center">6</td>
<td class=btext align="center">7</td>
<td class=btext align="center">8</td>
<td class=btext align="center">9</td>
<td class=btext align="center">10</td>
<td class=btext align="center">11</td>
<td class=btext align="center">12</td>
<td class=btext nowrap>13(11-12)</td>
</tr>
<%
try{
Statement stmt1=conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_READ_ONLY);
ResultSet rs1=null,rs2=null;
int sno=0;
double samt=0.0,bamtc=0.0,bamt=0.0,vamt=0.0,col13=0.0;
String qry="select distinct a.work_id,work_name,programme_name,subprogramme_name,sanction_amount  from rws_work_admn_tbl a,rws_programme_tbl b ,rws_subprogramme_tbl c,rws_work_bill_tbl d where a.programme_code=b.programme_code and b.programme_code=c.programme_code and a.subprogramme_code=c.subprogramme_code and a.work_id=d.work_id and substr(office_code,2,2)='"+dist+"' and substr(office_code,4,1)='"+div+"'  and  bill_sl_no<>'0'  ";
if(billType!=null && billType.equals("1"))
{
  qry+=" and to_date(bill_date,'dd/mm/yy')>= to_date('"+frmDate+"', 'dd/MM/yy')   and to_date(bill_date,'dd/mm/yy')<= to_date('"+toDate+"', 'dd/MM/yy') ";
}
if(billType!=null && billType.equals("2"))
{
  qry+=" and to_date(update_date,'dd/mm/yy')>= to_date('"+frmDate+"', 'dd/MM/yy')   and to_date(update_date,'dd/mm/yy')<= to_date('"+toDate+"', 'dd/MM/yy') ";
}

stmt=conn.createStatement();
Statement stmt2=conn.createStatement();
rs=stmt.executeQuery(qry);
while(rs.next())
{
	String bill0 = "",bill1 = "",bill2 = "";
	samt+=rs.getDouble(5);
	%>
 <tr>
      <td class=rptvalue><%=++sno%></td>
	  <td class=rptvalue>&nbsp;<%=rs.getString(1)%></td>
      <td class=rptvalue nowrap><%=rs.getString(2)%></td>
	  <td class=rptvalue nowrap><%=rs.getString(3)%></td>
	  <td class=rptvalue nowrap><%=rs.getString(4)%></td>
	  <td class=rptvalue align="right"><%=rs.getString(5)%></td>
	  <%
String qry1="select distinct  to_char(bill_date,'dd/mm/yyyy'),nvl(voucher_amt,0),BILL_AMT_ADMISSIBLE,bill_no,BILL_AMT_CONTRACTOR,a.bill_no, to_char(a.update_date,'dd/mm/yyyy')update_date,a.bill_sl_no from rws_work_bill_tbl a,rws_work_exp_voucher_tbl b where a.work_id=b.work_id(+) and a.work_id='"+rs.getString(1)+"' and a.bill_sl_no=b.bill_sl_no(+) and  a.bill_sl_no<>'0'  ";
		if(billType!=null && billType.equals("1"))
		{
		  qry1+=" and to_date(bill_date,'dd/mm/yy')>= to_date('"+frmDate+"', 'dd/MM/yy')   and to_date(bill_date,'dd/mm/yy')<= to_date('"+toDate+"', 'dd/MM/yy') ";
		}
		if(billType!=null && billType.equals("2"))
		{
		  qry1+=" and to_date(a.update_date,'dd/mm/yy')>= to_date('"+frmDate+"', 'dd/MM/yy')   and to_date(a.update_date,'dd/mm/yy')<= to_date('"+toDate+"', 'dd/MM/yy') ";
		}
		qry1 += " order by bill_sl_no";
		rs1=stmt1.executeQuery(qry1);
	    double voucherAmt=0.0;
		int countt = 1;
		String prevBillNo = "";
		while(rs1.next()){
			bill1 = "";bill2 = "";
			String billno=rs1.getString(4);
			bill1 = rs1.getString("bill_sl_no");
			if(!prevBillNo.equals(rs1.getString("bill_sl_no")))
			{
			String qry2=" select sum(voucher_amt) from rws_work_exp_voucher_tbl where work_id ='"+rs.getString(1)+"' and bill_sl_no='"+rs1.getString("bill_sl_no")+"' ";
			rs2=stmt2.executeQuery(qry2);
			if(rs2.next())
				{
				  voucherAmt=rs2.getDouble(1);
				}
			}
			if(countt == 1)
			{
				bamtc+=rs1.getDouble("BILL_AMT_CONTRACTOR");
				bamt+=rs1.getDouble("BILL_AMT_ADMISSIBLE");
				vamt+=voucherAmt;
				//prevAmt = rs1.getDouble(2);
				%>
				<td class=rptvalue align="right" ><%=rs1.getString("bill_no")%></td>
	  			<td class=rptvalue><%=rs1.getString(1)%></td>
				<%if(rs1.getString("update_date")!=null && !rs1.getString("update_date").equals("")){%>
				<td class=rptvalue><%=rs1.getString("update_date")%></td>
				<%}else{%><td class=rptvalue align="center">-</td>
				<%}%>
				<td class=rptvalue align="right"><%=rs1.getString("BILL_AMT_CONTRACTOR")%></td>				
				<td class=rptvalue align="right"><%=rs1.getString("BILL_AMT_ADMISSIBLE")%></td>
				<td class=rptvalue align="right"><%=voucherAmt%></td>
				<td class=rptvalue align="right"><%=Math.round(rs1.getDouble("BILL_AMT_ADMISSIBLE")-voucherAmt)%></td>
				</tr>
			<%
				col13 += rs1.getDouble("BILL_AMT_ADMISSIBLE")-voucherAmt;
			}
			else
			{%>
			
			<%if(!prevBillNo.equals(""))
			{
			  	
				if(!prevBillNo.equals(rs1.getString("bill_sl_no"))){
					bamtc+=rs1.getDouble("BILL_AMT_CONTRACTOR");
					bamt+=rs1.getDouble("BILL_AMT_ADMISSIBLE");
					vamt+=voucherAmt;
				 	%>
				 <td class=rptvalue colspan=6></td>
				<td class=rptvalue align="right" ><%=rs1.getString("bill_no")%></td>
				<td class=rptvalue><%=rs1.getString(1)%></td>
				<%if(rs1.getString("update_date")!=null && !rs1.getString("update_date").equals("")){%>
				<td class=rptvalue><%=rs1.getString("update_date")%></td>
				<%}else{%><td class=rptvalue align="center">-</td>
				<%}%>
				<td class=rptvalue align="right"><%=rs1.getString("BILL_AMT_CONTRACTOR")%></td>				
				<td class=rptvalue align="right"><%=rs1.getString("BILL_AMT_ADMISSIBLE")%></td>				
				<td class=rptvalue align="right"><%=voucherAmt%></td>				
				<td class=rptvalue align="right"><%=Math.round(rs1.getDouble("BILL_AMT_ADMISSIBLE")-voucherAmt)%></td>				
				 <%} 
				col13 += rs1.getDouble("BILL_AMT_ADMISSIBLE")-voucherAmt;
			}
	}
	countt++;
	prevBillNo = rs1.getString("bill_sl_no");
 %>  
</tr>
<%
  }

}%>
<tr>
<td colspan=5 class=btext align="center">Total:</td>
<td class=rptvalue align="right"><%=Math.round(samt*100)/100f%></td>
<td class=rptvalue align="right"></td>
<td class=rptvalue align="right"></td>
<td class=rptvalue align="right"></td>
<td class=rptvalue align="right" ><%=Math.round(bamtc) %></td>
<td class=rptvalue align="right"><%=Math.round(bamt)%></td>
<td class=rptvalue align="right"><%=Math.round(vamt)%></td>
<td class=rptvalue align="right"><%=Math.round(col13) %></td>
</tr>
<%}catch(Exception e){
}finally{
if(rs!=null)rs.close();
if(stmt!=null)stmt.close();
if(conn!=null)conn.close();
}%>
</table>
</form>