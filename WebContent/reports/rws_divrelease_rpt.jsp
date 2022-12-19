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
<tr><td  class=btext>Releases in the Program <font color=black><%=pname%></font>&nbsp; and &nbsp; Division: &nbsp;<font color=black><%=divname%></font> </td></tr></table><BR>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse"  align="center">

<tr align=center>
			<td class=btext>Sl No.</td>
			<td class=btext>BRO Id</td>
			<td class=btext>LOC Id</td>
			<td class="btext">LOC Date</td>
			<td class="btext">LOC Amount</td>
</tr>

<%
DecimalFormat ndf = new DecimalFormat("####.00");
int count=0;
String qry = "";
if(mode!=null && mode.equals("1"))
{
	qry="select b.bro_id,b.loc_id,to_char(b.loc_date,'dd/mm/yyyy'),b.loc_amount from rws_loc_master_tbl a,rws_loc_details_tbl b,rws_bro_master_tbl c where a.loc_id=b.loc_id and a.bro_id=b.bro_id and b.bro_id=c.bro_id and   a.bro_id=c.bro_id and b.work_id is null and fin_year='2010-2011' and programme_code='"+pcode+"' and substr(office_to_code,2,3)='"+dcode+"' ";
}
else if(mode!=null && mode.equals("2"))
{
	//qry = "select b.bro_id,b.loc_id,to_char(b.loc_date,'dd/mm/yyyy'),b.loc_amount from rws_loc_master_tbl a,rws_loc_details_tbl b,rws_work_admn_tbl c where a.loc_id=b.loc_id and a.bro_id=b.bro_id and b.work_id is not null and b.work_id=c.work_id and b.programme_code='"+pcode+"'";
	qry = "select b.bro_id,b.loc_id,to_char(b.loc_date,'dd/mm/yyyy'),b.loc_amount from rws_loc_master_tbl a,rws_loc_details_tbl b,rws_work_admn_tbl c,rws_bro_master_tbl d where a.loc_id=b.loc_id and a.bro_id=b.bro_id and b.work_id is not null and b.work_id=c.work_id and b.bro_id=d.bro_id and a.bro_id=d.bro_id and fin_year='2010-2011' and  b.programme_code='"+pcode+"' and substr(office_to_code,2,3)='"+dcode+"' ";

}
else if(mode!=null && mode.equals("3"))
{
	//qry = "select b.bro_id,b.loc_id,to_char(b.loc_date,'dd/mm/yyyy'),b.loc_amount from rws_loc_master_tbl a,rws_loc_details_tbl b where a.loc_id=b.loc_id and a.bro_id=b.bro_id and b.work_id is null  and b.programme_code='"+pcode+"' union select b.bro_id,b.loc_id,to_char(b.loc_date,'dd/mm/yyyy'),b.loc_amount from rws_loc_master_tbl a,rws_loc_details_tbl b,rws_work_admn_tbl c where a.loc_id=b.loc_id and a.bro_id=b.bro_id and b.work_id is not null and b.work_id=c.work_id and b.programme_code='"+pcode+"'";
	//
	qry =" select b.bro_id,b.loc_id,to_char(b.loc_date,'dd/mm/yyyy'),b.loc_amount from rws_loc_master_tbl a,rws_loc_details_tbl b,rws_bro_master_tbl c where a.loc_id=b.loc_id and a.bro_id=b.bro_id and b.bro_id=c.bro_id and   a.bro_id=c.bro_id and b.work_id is null and fin_year='2010-2011' and programme_code='"+pcode+"' union select b.bro_id,b.loc_id,to_char(b.loc_date,'dd/mm/yyyy'),b.loc_amount from rws_loc_master_tbl a,rws_loc_details_tbl b,rws_work_admn_tbl c,rws_bro_master_tbl d where a.loc_id=b.loc_id and a.bro_id=b.bro_id and b.work_id is not null and b.work_id=c.work_id and b.bro_id=d.bro_id and a.bro_id=d.bro_id and fin_year='2010-2011' and  b.programme_code='"+pcode+"' " ;
	qry="select b.bro_id,b.loc_id,to_char(b.loc_date,'dd/mm/yyyy'),b.loc_amount from rws_loc_master_tbl a,rws_loc_details_tbl b where a.loc_id=b.loc_id and a.bro_id=b.bro_id   and programme_code='"+pcode+"' and substr(office_to_code,2,3)='"+dcode+"' ";
}
//System.out.println("qry:"+qry);
rs=stmt.executeQuery(qry);
double ddd = 0.0;
while(rs.next())
{
	ddd += rs.getDouble(4)*100000;
	%>
<tr>
<td class=rptValue><%=++count%></td>
<td class=rptValue><%=rs.getString(1)%></td>
<td class=rptValue><%=rs.getString(2)%></td>
<td class=rptValue><%=rs.getString(3)%></td>
<td class=rptValue align="right"><%=ndf.format(rs.getDouble(4)*100000)%></td>
</tr>
<% } 
%>
<tr>
<td class=rptHeading colspan="4" align="center">Total</td>
<td class=rptValue align="right"><%=ndf.format(ddd)%></td>
</tr>
</table>