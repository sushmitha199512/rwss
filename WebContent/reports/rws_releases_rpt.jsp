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
/* if(special!=null && special.equals("Y")) pQry = "and b.programme_code in ('02','01','48','32','23','49','51','18','37','60')"; */
String nrdwpProgrammeCodes=Constants.NRDWP_RELATED;
if(special!=null && special.equals("Y")) pQry = "and b.programme_code in ("+nrdwpProgrammeCodes+")";
stmt=conn.createStatement();
%>
<table align="center">
<tr><td align=right><a href="javascript:onClick=window.close()">Close&nbsp;</a>
</td></tr>
<tr><td  class=rptHeading>Releases in the District:&nbsp;<%=dname%> and Division:&nbsp;<%=divname%></td></tr></table><BR>
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
qry = "select b.bro_id,b.loc_id,to_char(b.loc_date,'dd/mm/yyyy'),b.loc_amount from rws_loc_master_tbl a,rws_loc_details_tbl b,rws_bro_master_tbl c where a.loc_id=b.loc_id and a.bro_id=b.bro_id and b.bro_id=c.bro_id and   a.bro_id=c.bro_id  and fin_year='2010-2011' and substr(office_to_code,2,3)='"+dcode+divcode+"'  "+pQry;

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