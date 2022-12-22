<%@ include file="/commons/rws_header1.jsp" %>
<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file = "conn.jsp" %>
<%

String dcode = (String)session.getAttribute("dcode");
String divcode = (String)session.getAttribute("divcode");
String subcode = (String)session.getAttribute("subcode");
String dname=(String)session.getAttribute("dname");
String divname=(String)session.getAttribute("divname");
String sdname=(String)session.getAttribute("sdname");
%>
<form>
<table bgcolor="#FFFFFF" bordercolor= "#8A9FCD"  width="80%" border=1 style="border-collapse:collapse" >
<tr >
<td class=btext ><b>S.No</b></font></td>
<%
if(divcode!=null && divcode.length()>0){}else{%>
 	<td class=btext ><b>DivisionName</b></font></td>
<%}
if(subcode!=null && subcode.length()>0){}else{%>
<td class=btext><b> SubDivisionName</b></font></td>
<%}%>
 	<td class=btext><b> EmployeeCode</b></font></td>
	<td class=btext><b> Name</b></font></td>
    <td class=btext><b>Date Of Birth</b></font></td>
<td class=btext><b>Works In Hand</b></font></td>
	 <td class=btext><b>Completed Works</b></font></td>
</tr>
<%
String qry="select d.division_office_name,sd.subdivision_office_name,e.EMPLOYEE_CODE,e.EMPLOYEE_NAME||'.'||e.EMPLOYEE_SURNAME,nvl(to_char(e.DATE_OF_BIRTH,'dd/mm/yyyy'),'-') from  rws_employee_tbl e,rws_division_office_tbl d,rws_subdivision_office_tbl sd where d.circle_office_code=substr(e.office_code,2,2) and d.division_office_code=substr(e.office_code,4,1) and d.circle_office_code=sd.circle_office_code and  d.division_office_code=sd.division_office_code  and sd.subdivision_office_code=substr(e.office_code,5,2) "+
 " and substr(e.office_code,2,2)='"+dcode+"' ";

if(divcode!=null && !divcode.equals(""))
{
qry+=" and substr(e.office_code,4,1)='"+divcode+"' ";
}
if(subcode!=null && !subcode.equals(""))
{
qry+=" and substr(e.office_code,5,2)='"+subcode+"' ";
}

stmt=conn.createStatement();
rs=stmt.executeQuery(qry);
int count = 1;
 Statement stmt1=conn.createStatement();
if(rs.isBeforeFirst())
{
while(rs.next())
{%>
 <tr>
 <td class=rptvalue ><%=count++%></td>
<%if(divcode!=null && divcode.length()>0){}else{%>
 	<td class=rptvalue nowrap><%=rs.getString(1)%></td>
<%}
if(subcode!=null && subcode.length()>0){}else{%>
<td class=rptvalue nowrap><%=rs.getString(2)%></td>
<%}%>
 <td class=rptvalue  nowrap><%=rs.getString(3)%></td>
 <td class=rptvalue  nowrap><%=rs.getString(4)%></td>
 <td class=rptvalue ><%=rs.getString(5)%></td>
 <%
	String qry1="select(select count(*) from rws_work_commencement_tbl where (OFFICER_ASSIGNED_TO='"+rs.getString(3)+"' or OFFICER_ASSIGNED_TO1='"+rs.getString(3)+"' or OFFICER_ASSIGNED_TO2='"+rs.getString(3)+"' or OFFICER_ASSIGNED_TO3='"+rs.getString(3)+"') and work_id not in(select work_id from rws_work_completion_tbl))a,(select count(*) from rws_work_commencement_tbl where (OFFICER_ASSIGNED_TO='"+rs.getString(3)+"' or OFFICER_ASSIGNED_TO1='"+rs.getString(3)+"' or OFFICER_ASSIGNED_TO2='"+rs.getString(3)+"' or OFFICER_ASSIGNED_TO3='"+rs.getString(3)+"') and work_id in(select work_id from rws_work_completion_tbl))b from dual";

  ResultSet rs1=stmt1.executeQuery(qry1);
 if(rs1.next())
	{
 %>
 <td class=rptvalue align="right"><%=rs1.getString(1)%></td>
 <td class=rptvalue align="right"><%=rs1.getString(2)%></td>
 </tr>

<%}}
}
else
{
	%>
	<script>
		alert("There are no Employees in Selected Sub Division");
		document.location.href="rws_employee_work_frm.jsp";
	</script>
	<%
}
%>
</form>
</table>

