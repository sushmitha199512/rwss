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
/* if(special!=null && special.equals("Y")) pQry = "and b.programme_code in ('02','01','48','32','23','49','51','18','37')"; */
String nrdwpProgrammeCodes=Constants.NRDWP_RELATED;
if(special!=null && special.equals("Y")) pQry = "and b.programme_code in ("+nrdwpProgrammeCodes+")";
stmt=conn.createStatement();
Statement stmt1 = conn.createStatement();
Statement stmt2 = conn.createStatement();
ResultSet rs1=null;
%>
<table width="100%"  align="center">
<table align="center">
<%if(special==null || (special!=null && !special.equals("Y"))){%>
<tr><td align=right><a href="javascript:onClick=window.close()">Close</a>&nbsp;|&nbsp;<a href="rws_bill_rpt_xls.jsp?dcode=<%=dcode%>&divcode=<%=divcode%>&dnamee=<%=dname%>&divname=<%=divname%>&mode=<%=mode%>" target="_new">Excel</a>
</td></tr>
<%}else{%>
<tr><td align=right><a href="javascript:onClick=window.close()">Close</a>&nbsp;|&nbsp;<a href="rws_bill_rpt_xls.jsp?dcode=<%=dcode%>&divcode=<%=divcode%>&dnamee=<%=dname%>&divname=<%=divname%>&mode=<%=mode%>&special=Y" target="_new">Excel</a>
</td></tr>
<%}%>
<tr><td  class=rptHeading>Bills in the District:&nbsp;<%=dname%> and Division:&nbsp;<%=divname%></td></tr></table><BR>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse"  align="center">
<tr align=center>
			<td class=btext>Sl No.</td>
			<td class=btext>Work Id</td>
			<td class=btext>Work Name</td>
			<td class=btext>Program</td>
			<td class=btext>Sub Program</td>
			<td class=btext>Bill No</td>			
			<td class=btext>Bill Date</td>
			<td class="btext" nowrap>Bill Amount <BR>(In Rupees)</td>
			<td class="btext">Bill Amount<br>Admissable<br>(In Rupees)</td>
			<td class="btext">Voucher <br>Amount<br>(In Rupees)</td>
	</tr>

<%
int count=0;
String qry= "";
Hashtable ht=new Hashtable();
String qry1="select a.work_id,programme_name from rws_work_admn_prog_lnk_tbl a,rws_programme_tbl p,rws_work_bill_tbl b where p.programme_code=a.programme_code and a.work_id=b.work_id  group by a.work_id,programme_name";
rs1=stmt2.executeQuery(qry1);
while(rs1.next())
{
	ht.put(rs1.getString(1),rs1.getString(2));
}

DecimalFormat ndf = new DecimalFormat("####.00");
qry = "select a.work_id,b.work_name,bill_no,to_char(bill_date,'dd/mm/yyyy'),bill_amt_contractor,bill_amt_admissible,bill_sl_no,bill_date,programme_name,subprogramme_name from rws_work_bill_tbl a,rws_work_admn_tbl b,rws_programme_tbl p,rws_subprogramme_tbl s where a.work_id=b.work_id and p.programme_code=s.programme_code and p.programme_code=b.programme_code and s.subprogramme_code=b.subprogramme_code and substr(office_code,2,3)='"+dcode+divcode+"' and bill_sl_no<>'0' "+pQry+"  order by work_id,bill_date desc";

//System.out.println("qry3:"+qry);
rs=stmt.executeQuery(qry);
double ddd = 0.0;double ddd1 = 0.0,ddd2 = 0.0;
String prgName="";
while(rs.next())
{ 
	ddd += Double.parseDouble(rs.getString(5));ddd1 += Double.parseDouble(rs.getString(6));
	prgName=""+ht.get(rs.getString(1));
	if(prgName!=null && !prgName.equals("null")){}else{prgName="-";}
%>
<tr>
<td class=rptValue><%=++count%></td>
<td class=rptValue><%=rs.getString(1)%></td>
<td class=rptValue><%=rs.getString(2)%></td>
<td class=rptValue><%=rs.getString("programme_name")%>/<%=prgName%></td>
<td class=rptValue><%=rs.getString("subprogramme_name")%></td>
<td class=rptValue><%=rs.getString(3)%></td>
<td class=rptValue><%=rs.getString(4)%></td>
<td class=rptValue align="right"><%=ndf.format(Double.parseDouble(rs.getString(5)))%></td>
<td class=rptValue align="right"><%=ndf.format(Double.parseDouble(rs.getString(6)))%></td>
<%String qqq = "select nvl(sum(voucher_amt),0) from rws_work_exp_voucher_tbl where work_id='"+rs.getString(1)+"' and bill_sl_no='"+rs.getString(7)+"'";
//System.out.println(qqq);
	ResultSet rsss = stmt1.executeQuery(qqq);
	if(rsss.next()){
		ddd2 += Double.parseDouble(rsss.getString(1));%>
	<td class=rptValue align="right"><%=ndf.format(Double.parseDouble(rsss.getString(1)))%></td>
	<%}else{%>
	<td class=rptValue align="right"><%=ndf.format(Double.parseDouble(rsss.getString(1)))%></td>
	<%}%>
</tr>
<% } 
%>
<tr>
<td class=rptHeading colspan="7" align="center">Total</td>
<td class=rptValue align="right"><%=ndf.format(ddd)%></td>
<td class=rptValue align="right"><%=ndf.format(ddd1)%></td>
<td class=rptValue align="right"><%=ndf.format(ddd2)%></td>
</tr>
</table>
<p align="left">
<font face=verdana size=2 color=red>
&nbsp;&nbsp;&nbsp;Note****:
 <BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<font face=verdana size=2 color=red>1. Amount Displayed is in Rupees
</font>
</p>