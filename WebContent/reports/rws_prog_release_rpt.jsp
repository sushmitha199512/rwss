<%@ page import="java.text.DecimalFormat,java.math.BigDecimal" %>
<%@ include file="/reports/conn.jsp" %>
<%@ include file="/commons/rws_header1.jsp"%>
<%
String pcode=request.getParameter("pcode");
String pname=request.getParameter("pname");
String mode = request.getParameter("mode");

stmt=conn.createStatement();
nic.watersoft.commons.RwsUser users=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
	String userid = users.getUserId();
	//System.out.println("user SUB  ssss JSP:"+userid);

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
<tr><td  class=rptHeading>Releases in the Program:&nbsp;<%=pname%> </td></tr></table><BR>
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
	qry="select b.bro_id,b.loc_id,to_char(b.loc_date,'dd/mm/yyyy'),b.loc_amount from rws_loc_master_tbl a,rws_loc_details_tbl b,rws_bro_master_tbl c where a.loc_id=b.loc_id and a.bro_id=b.bro_id and b.bro_id=c.bro_id and   a.bro_id=c.bro_id and fin_year='2010-2011'  and programme_code='"+pcode+"' ";

	if(!(userid!=null && (userid.equals("admin") || userid.equals("100000") ||userid.equals("psrwss") || userid.equals("guest")))) 
	{
		qry +=" and substr(office_to_code,2,2)='"+userid.substring(1,3)+"'";
		if(!userid.substring(3,4).equals("0"))
		qry+=" and  substr(office_to_code,4,1)='"+userid.substring(3,4)+"' ";
	}

////System.out.println("qry:"+qry);
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