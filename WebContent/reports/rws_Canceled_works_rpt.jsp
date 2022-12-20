<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "/reports/conn.jsp" %>

<table border = 0 cellspacing = 0 cellpadding = 0 width="60%">
<tr><td align="right"><a href="/pred/home.jsp">Close</td></tr>
</table>
<table border = 1 cellspacing = 0 cellpadding = 0 width=60%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<tr bgcolor="#8A9FCD" align="center">
<td align="center" class="rptHeading" colspan=10 >Cancel Works</td>	
</tr>
<tr align="center">
<td class=btext>Sl.No</td>
<td class=btext>Circle</td>
<td class=btext>Division</td>
<td class=btext>Work Id/<BR>Work Name</td>  
<td class=btext>No of Habs</td>
<td class=btext>Work Category</td>
<td class=btext>Program/<BR>Subprogram</td>
<td class=btext>Sanction Amount</td>
<td class=btext>Canceled Date</td>
</tr>
<% int count=0;
String qry="select circle_office_name,division_office_name,work_id,work_name,no_of_habs,programme_name,subprogramme_name,sanction_amount, category_name,to_char(WORK_CANCEL_DT,'dd/MM/yyyy') from rws_work_admn_tbl a,rws_programme_tbl p,rws_subprogramme_tbl s,rws_work_category_tbl c,rws_circle_office_tbl v,rws_division_office_tbl d where a.programme_code=s.programme_code and p.programme_code=s.programme_code and a.subprogramme_code=s.subprogramme_code and a.category_code=c.category_code and v.circle_office_code=substr (work_id,5,2) and substr(office_code,4,1) =d.division_office_code and v.circle_office_code=d.circle_office_code and WORK_CANCEL_DT is not null order by circle_office_name,division_office_name ";
stmt=conn.createStatement();
rs=stmt.executeQuery(qry);
while(rs.next())
{%>
 <tr>
 <td class=rptvalue><%=++count%></td>
<td class=rptvalue><%=rs.getString(1)%></td>
<td class=rptvalue><%=rs.getString(2)%></td>
<td class=rptvalue><%=rs.getString(3)%>/<BR><%=rs.getString(4)%></td>
<td class=rptvalue align="right"><%=rs.getString(5)%></td>
<td class=rptvalue><%=rs.getString(9)%></td>
<td class=rptvalue><%=rs.getString(6)%>/<BR><%=rs.getString(7)%></td>
<td class=rptvalue align="right"><%=rs.getString(8)%></td>
<td class=rptvalue><%=rs.getString(10)%></td>

</tr>
<%}

%>