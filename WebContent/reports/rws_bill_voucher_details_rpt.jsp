
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<jsp:useBean id="workData" class="nic.watersoft.works.WorksData1" />   
<%
Statement stmt1=null;
ResultSet rs1=null;
String officecode=request.getParameter("officecode");
String cat=request.getParameter("cat");
String billvoc=request.getParameter("brv");
String year=request.getParameter("year");
String divname=request.getParameter("divname");
//System.out.println("brv:"+billvoc);
stmt=conn.createStatement();
stmt1=conn.createStatement();
%>
<table width="100%"  align="center">
<tr><td align=right><a href="javascript:onClick=window.close()">Close&nbsp;</a>
</td></tr>
</table>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse" align="center" >
<% if(billvoc!=null && billvoc.equals("bill")) {%>
<tr class=btext align=center>Bill Details of under Division:<font color="black"><%=divname%></font></tr>

<tr align=center>
			<td class=btext>Sl No.</td>
			<td class=btext>Work Id</td>			
			<td class=btext>Work Name</td>			
			<td class=btext>Bill Sl.No</td>
			<td class=btext>Bill No</td>
			<td class=btext>Bill Date</td>			
			<td class=btext>Bill Amount<BR>(In Rupees)</td>
	</tr>
<%

int count=0;
long bamt=0;

String qry="select a.WORK_ID,b.work_name,BILL_SL_NO,BILL_NO,to_char(BILL_DATE,'dd/mm/yyyy'),BILL_AMT_CONTRACTOR from RWS_WORK_BILL_TBL a,rws_work_admn_tbl b where a.work_id=b.work_id and substr(office_code,2,3)='"+officecode+"' and category_code='"+cat+"' ";
if(year!=null && !year.equals("")){
qry += " and admin_date <='31/MAR/"+year.substring(5)+"' and  admin_date >='01/APR/"+year.substring(0,4)+"'";
}

//and admin_date <='31/MAR/"+year.substring(5)+"' and  admin_date >='01/APR/"+year.substring(0,4)+"' ";
//System.out.println("qry"+qry);
rs=stmt.executeQuery(qry);
while(rs.next())
{ %>
<tr>
<td class=rptValue><%=++count%></td>
<td class=rptValue><%=rs.getString(1)%></td>
<td class=rptValue><%=rs.getString(2)%></td>
<td class=rptValue><%=rs.getString(3)%></td>
<td class=rptValue><%=rs.getString(4)%></td>
<td class=rptValue><%=rs.getString(5)%></td>
<td class=rptValue align=right><%=rs.getString(6)%></td>
</tr>
<%
bamt+=(new Double(rs.getDouble(6))).longValue();

} 
%>
<tr>
<td colspan=6 align="center" class=btext>Total</td>
<td align="right" class=btext><%=bamt%></td>
</table>
<%} else if (billvoc!=null && billvoc.equals("voucher")) {%>
			<tr class=btext align=center>Voucher Details of under Division:<font color="black"><%=divname%></font></tr>
			<tr>
			<td class=btext>Sl No.</td>
			<td class=btext>Work Id</td>
			<td class=btext>Work Name</td>
			<td class=btext>M Book No</td>			
			<td class=btext>Voucher No</td>
			<td class=btext>Voucher Date</td>
			<td class=btext>Cheque No</td>			
			<td class=btext>Cheque Date</td>
			<td class=btext>Voucher Amount<BR>(In Rupees)</td>
			
<%int count1=0;
long vamt=0;
String qry1="select b.work_id,b.work_name, mbook_no,VOUCHER_no,to_char(VOUCHER_DT,'dd/mm/yyyy'),nvl(CHEQUE_NO,'-'),nvl(to_char(CHEQUE_DT,'dd/mm/yyyy'),'-'),VOUCHER_AMT from rws_work_exp_voucher_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and substr(office_code,2,3)='"+officecode+"' and category_code= '"+cat+"' ";

if(year!=null && !year.equals("")){
qry1 += " and admin_date <='31/MAR/"+year.substring(5)+"' and  admin_date >='01/APR/"+year.substring(0,4)+"'";
}
//and admin_date <='31/MAR/"+year.substring(5)+"' and  admin_date >='01/APR/"+year.substring(0,4)+"' ";
//System.out.println("qry1"+qry1);
rs1=stmt1.executeQuery(qry1);
while(rs1.next())
{ %>
<tr>
<td class=rptValue><%=++count1%></td>
<td class=rptValue><%=rs1.getString(1)%></td>
<td class=rptValue><%=rs1.getString(2)%></td>
<td class=rptValue><%=rs1.getString(3)%></td>
<td class=rptValue><%=rs1.getString(4)%></td>
<td class=rptValue><%=rs1.getString(5)%></td>
<td class=rptValue><%=rs1.getString(6)%></td>
<td class=rptValue><%=rs1.getString(7)%></td>
<td class=rptValue align="right"><%=rs1.getString(8)%></td>
</tr>

<%
vamt+=(new Double(rs1.getDouble(8))).longValue();
	
}%>
<tr>
<td colspan=8 align="center" class=btext>Total</td>
<td align="right" class=btext><%=vamt%></td>
</table>

<%}


%>
