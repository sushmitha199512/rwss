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
stmt=conn.createStatement();
String pQry = "";
/* if(special!=null && special.equals("Y")) pQry = "and a.programme_code in ('02','01','48','32','23','49','51','18','37')"; */
String nrdwpProgrammeCodes=Constants.NRDWP_RELATED;
if(special!=null && special.equals("Y")) pQry = "and a.programme_code in ("+nrdwpProgrammeCodes+")";
%>
<table align="center">
<tr><td align=right><a href="javascript:onClick=window.close()">Close&nbsp;</a>
</td></tr>
<tr><td  class=rptHeading>Opening Balance in the District:&nbsp;<%=dname%> and Division:&nbsp;<%=divname%></td></tr></table><BR>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD" border=1 style="border-collapse:collapse"  align="center">
<tr align=center>
			<td class=btext>Sl No.</td>
			<td class=btext>Programme Name</td>
			<td class=btext>Head Of Account</td>
			<td class="btext">OB Amount</td>
</tr>
<%
DecimalFormat ndf = new DecimalFormat("####.00");
int count=0;
String qry = "";
qry = "select HEAD_OF_ACCOUNT,OP_CL_BAL,programme_name from RWS_GRANT_OP_CL_BAL_TBL a,rws_programme_tbl p where  a.programme_code=p.programme_code and substr(office_code,2,3)='"+dcode+divcode+"' "+pQry+"";
//System.out.println("qry:"+qry);
rs=stmt.executeQuery(qry);
double ddd = 0.0;
nic.watersoft.fundAccounting.Rws_BroData data=new nic.watersoft.fundAccounting.Rws_BroData();
while(rs.next())
{
	ddd += rs.getDouble(2);
	%>
<tr>
<td class=rptValue><%=++count%></td>
<td class=rptValue><%=rs.getString(3)%></td>
<td class=rptValue>
<%
	String hoa1[]=data.getHeadOfAccountName(rs.getString(1)).split("->");
	for (int i=0; i<hoa1.length; i++) {%>
	<%=hoa1[i]%>&nbsp;<%if(i<hoa1.length-1){%>&raquo;<%}%><br><%}%>
</td>
<td class=rptValue align="right"><%=ndf.format(rs.getDouble(2))%></td>
</tr>
<% } 
%> 
<tr>
<td class=rptHeading colspan="3" align="center">Total</td>
<td class=rptValue align="right"><%=ndf.format(ddd)%></td>
</tr>
</table>