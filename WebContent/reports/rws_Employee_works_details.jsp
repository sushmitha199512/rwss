<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file = "conn.jsp" %>
<%
String empcode=request.getParameter("empcode");
String mode=request.getParameter("mode");
%>
<form>

<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="80%" border=1 style="border-collapse:collapse" >
<tr >
<td class=btext ><b>S.No</b></font></td>
 	<td class=btext><b> Work Id</b></font></td>
	<td class=btext><b> Work Name</b></font></td>
	<td class=btext><b> Work Category</b></font></td>
    <td class=btext nowrap><b>Admin Sanc No</b></font></td>
	<td class=btext><b>Admn Sanc Date</b></font></td>
	<td class=btext nowrap><b>Est Cost<BR>(In Lakhs)</b></font></td>
</tr>
<%
String qry1 = "";
if (mode!=null && mode.equals("1"))
{
	 qry1="select work_id,work_name,admin_no,to_char(admin_date,'dd/mm/yyyy'),sanction_amount,decode(category_code,'1','Projects','2','Normal','3','District Level') from rws_work_admn_tbl where work_id in(select work_id from rws_work_commencement_tbl where(OFFICER_ASSIGNED_TO='"+empcode+"' or OFFICER_ASSIGNED_TO1='"+empcode+"' or OFFICER_ASSIGNED_TO2='"+empcode+"' or OFFICER_ASSIGNED_TO3='"+empcode+"') and work_id not in(select work_id from rws_work_completion_tbl))";
}
else if(mode!=null && mode.equals("2"))
{
	 qry1="select work_id,work_name,admin_no,to_char(admin_date,'dd/mm/yyyy'),sanction_amount,decode(category_code,'1','Projects','2','Normal','3','District Level') from rws_work_admn_tbl where work_id in(select work_id from rws_work_commencement_tbl where(OFFICER_ASSIGNED_TO='"+empcode+"' or OFFICER_ASSIGNED_TO1='"+empcode+"' or OFFICER_ASSIGNED_TO2='"+empcode+"' or OFFICER_ASSIGNED_TO3='"+empcode+"') and work_id in(select work_id from rws_work_completion_tbl))";
}
//System.out.println(qry1);
int count=1;
 Statement stmt1=conn.createStatement();
  ResultSet rs1=stmt1.executeQuery(qry1);
 while(rs1.next())
	{
%>
<tr>
 <td class=rptvalue ><%=count++%></td>
 <td class=rptvalue  nowrap><%=rs1.getString(1)%></td>
  <td class=rptvalue  ><%=rs1.getString(2)%></td>
     <td class=rptvalue  nowrap><%=rs1.getString(6)%></td>
  <td class=rptvalue  nowrap><%=rs1.getString(3)%></td>
    <td class=rptvalue  nowrap><%=rs1.getString(4)%></td>
	     <td class=rptvalue  nowrap align="center"><%=rs1.getString(5)%></td>
 </tr>

<%}
%>
</form>
</table>
