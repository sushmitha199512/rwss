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
String pQry = "";
/* if(special!=null && special.equals("Y")) pQry = "and c.programme_code in ('02','01','48','32','23','49','51','18','37')"; */
String nrdwpProgrammeCodes=Constants.NRDWP_RELATED;
if(special!=null && special.equals("Y")) pQry = "and c.programme_code in ("+nrdwpProgrammeCodes+")";
stmt=conn.createStatement();
Statement stmt1=conn.createStatement();
ResultSet rs1=null;
%>
<table width="100%"  align="center">
<table align="center">
<tr><td align=right><a href="javascript:onClick=window.close()">Close&nbsp;</a>
</td></tr>
<tr><td  class=rptHeading>Expenditure(through Vouchers) in the District:&nbsp;<%=dname%> and Division:&nbsp;<%=divname%></td></tr></table><BR>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse"  align="center">
<tr align=center>
			<td class=btext>Sl No.</td>
			<td class=btext>Work Id</td>
			<td class=btext>Work Name</td>
			<td class=btext>Program</td>
			<td class=btext>Sub Program</td>
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
Hashtable ht=new Hashtable();
String qry1="select programme_name,a.work_id from rws_work_exp_voucher_tbl a,rws_work_admn_prog_lnk_tbl b,rws_programme_tbl p where a.work_id=b.work_id and a.programme_code=b.programme_code and p.programme_code=b.programme_code group by programme_name,a.work_id ";
rs1=stmt1.executeQuery(qry1);
while(rs1.next())
{
  ht.put(rs1.getString(2),rs1.getString(1));
}

DecimalFormat ndf = new DecimalFormat("####.00");
qry = "select distinct mbook_no,VOUCHER_no,to_char(VOUCHER_DT,'dd/mm/yyyy'),VOUCHER_AMT,nvl(CHEQUE_NO,'-'),nvl (to_char (CHEQUE_DT,'dd/mm/yyyy'),'-'),b.bill_no,a.work_id,c.work_name,VOUCHER_DT,programme_name,subprogramme_name from rws_work_exp_voucher_tbl a,rws_work_bill_tbl b,rws_work_admn_tbl c,rws_programme_tbl p,rws_subprogramme_tbl s where a.work_id=b.work_id and b.work_id=c.work_id and a.work_id=c.work_id  and substr(office_code,2,3)='"+dcode+divcode+"' and a.BILL_SL_NO <> '0' and a.bill_sl_no=b.bill_sl_no "+pQry+"  and c.programme_code=p.programme_code and c.subprogramme_code=s.subprogramme_code and p.programme_code=s.programme_code order by VOUCHER_DT desc";
//System.out.<BLOCKQUOTE></BLOCKQUOTE>println("qry22222222:"+qry);
rs=stmt.executeQuery(qry);
double ddd = 0.0;
String prgName="";
while(rs.next())
{ 
	ddd += rs.getDouble(4);
	prgName=""+ht.get(rs.getString("work_id"));
	if(prgName!=null && !prgName.equals("null")){}else{prgName="-";}
%>
<tr>
<td class=rptValue><%=++count%></td>
<td class=rptValue><%=rs.getString("work_id")%></td>
<td class=rptValue><%=rs.getString("work_name")%></td>
<td class=rptValue><%=rs.getString("programme_name")%>/<%=prgName%></td>
<td class=rptValue><%=rs.getString("subprogramme_name")%></td>
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
<td class=rptHeading colspan="9" align="center">Total</td>
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