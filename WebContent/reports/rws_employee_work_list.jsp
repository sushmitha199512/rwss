<%@ include file="/commons/rws_header1.jsp" %>
<%@ include file="/commons/rws_header2.jsp" %>
<%@ include file = "conn.jsp" %>
<%
String dcode=request.getParameter("district");
if(dcode!=null){
session.setAttribute("dcode",dcode);
}
String divcode=request.getParameter("division");
if(divcode!=null){
session.setAttribute("divcode",divcode);
}
String subcode=request.getParameter("subdivision");
if(subcode!=null){
session.setAttribute("subcode",subcode);
}
String dname=request.getParameter("dname");
if(dname!=null){
session.setAttribute("dname",dname);
}
String divname=request.getParameter("divname");
if(divname!=null){
session.setAttribute("divname",divname);
}
String sdname=request.getParameter("sdname");
if(sdname!=null){
session.setAttribute("sdname",sdname);
}
%>
<script language="javascript">
function wopen(url,name,w,h)
{
	var width = w;
	var height = h;
	var left = parseInt((screen.availWidth/2)-(width/2));
	var top = parseInt((screen.availHeight/2)-(height/2));
	var properties = "width="+width+",height="+height+",screenX="+left+",screenY="+top+",toolbar=no,"
					   + "status=no,menubar=no,location=no,directories=no,scrollbars=yes,copyhistory=no,"
					   + "resizable=yes,status=yes,left=20,top=20";
	newWindow = window.open(url, "_New", properties);
	newWindow.focus();
}
</script>
<form>
<table width="80%">
<tr><td align=right><a href="#" onclick="javascript:history.go(-1)">Back</a>&nbsp;|&nbsp;
<a href="<rws:context page='/home.jsp'/>">Home</a>&nbsp;|&nbsp;
<a href="./rws_Employee_xls.jsp" target="_new">Excel</a>
</tr>
</table>
<table><tr><td class="btext">
District:</td><td class="rptvalue"><%=dname%></td>
<%if(divcode!=null && divcode.length()>0){%>
<td class="btext">
- Division:</td><td class="rptvalue"><%=divname%></td>
<%}%>
<%if(subcode!=null && subcode.length()>0){%>
<td class="btext">
- Sub Division:</td><td class="rptvalue"><%=sdname%></td>
<%}%>
</td></tr></table>
<table width="80%" bgcolor="#8A9FCD">
<tr>
<td class=myfontclr><B><font color="#FFFFFF">Employees List</font></B></td>
<td align=right><IMG SRC="<rws:context page='/images/cloapp.gif'/>" WIDTH="12" HEIGHT="12" onclick="winClose()" style="cursor:hand" alt="Close">&nbsp;&nbsp;</td></tr>
</table>
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

System.out.println(qry);
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
//System.out.println(qry1);
  ResultSet rs1=stmt1.executeQuery(qry1);
 if(rs1.next())
	{
 if(Integer.parseInt(rs1.getString(1))>0){%>

 <td class=rptvalue  align="right"><a href="#" onclick="wopen('rws_Employee_works_details.jsp?empcode=<%=rs.getString(3)%>&mode=1','popup', 900, 300)"><%=rs1.getString(1)%></a></td>
 <%}else{%>
 <td class=rptvalue align="right"><%=rs1.getString(1)%></td>
 
 <%}%><%
  if(Integer.parseInt(rs1.getString(2))>0){%>

 <td class=rptvalue  align="right"><a href="#" onclick="wopen('rws_Employee_works_details.jsp?empcode=<%=rs.getString(3)%>&mode=2','popup', 900, 300)"><%=rs1.getString(2)%></a></td>
 <%}else{%>
 <td class=rptvalue align="right"><%=rs1.getString(2)%></td>
 
 <%}%>

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
<%@ include file="/commons/rws_footer.jsp"%>

