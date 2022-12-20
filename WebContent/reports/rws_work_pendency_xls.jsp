<%@ include file="/commons/rws_header1.jsp"%>
<%@ page contentType="application/vnd.ms-excel" %>
<%@ include file = "conn.jsp" %>

<html>
<body>
<table border = 1 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=10>Work Pendency Status Report</td>	
	</tr>
<td class=btext>Sl.No</td>
<td class=btext>Work Id</td>
<td class=btext>Work Name</td>
<td class=btext>Admin No</td>
<td class=btext>Admin Date</td>
<td class=btext>Estimation Cost(in Lakhs)</td>
<td class=btext>Grounding Date</td>
<td class=btext>Date of Completion</td>
<td class=btext>Stipulated Date Of Completion</td>
</tr>

<% 
Statement stmt1=null;
ResultSet rs1=null;
 stmt1=conn.createStatement();
 String  dist=request.getParameter("dist");
 String wtype=request.getParameter("wrktype");
 String year=request.getParameter("fnyear");
int sno=0;
  String qry="select  a.work_id,work_name,admin_no,to_char(admin_date,'dd/MM/YYYY'),sanction_amount, to_char(grounding_date,'dd/MM/YYYY'),nvl(to_char(date_of_completion,'dd/MM/YYYY'),'-') from rws_work_admn_tbl a,rws_work_commencement_tbl b,rws_work_completion_tbl c where a.work_id=b.work_id and a.work_id=c.work_id and b.work_id=c.work_id and grounding_date is not null and date_of_completion is null  ";
  if(dist!=null && !dist.equals("")  && !dist.equals("-1"))
  {
	qry+=" and substr(a.work_id,5,2)='"+dist+"' ";
  }
  if(wtype!=null && !wtype.equals("")  && !wtype.equals("-1"))
  {
	qry+=" and category_code='"+wtype+"' ";
  }
  if(year!=null && !year.equals("")  && !year.equals("-1"))
{
	qry+=" and to_char (admin_date,'yyyy') ='"+year+"' ";
}
  stmt=conn.createStatement();
 //System.out.println("qryxls:"+qry);
  rs=stmt.executeQuery(qry);
 while(rs.next())
 {%>
   <tr>
   <td class=rptValue><%=++sno%></td>
   <td class=rptValue nowrap>&nbsp;<%=rs.getString(1)%></td>
   <td class=rptValue nowrap><%=rs.getString(2)%></td>
   <td class=rptValue nowrap><%=rs.getString(3)%></td>
   <td class=rptValue nowrap><%=rs.getString(4)%></td>
   <td class=rptValue nowrap><%=rs.getString(5)%></td>
	<td class=rptValue nowrap><%=rs.getString(6)%></td>
	<td class=rptValue nowrap><%=rs.getString(7)%></td>
   <%
   String qry1="select nvl(to_char(date_of_completion,'dd/MM/YYYY'),'-') from rws_contractor_selection_tbl where work_id='"+rs.getString(1)+"' ";
   rs1=stmt1.executeQuery(qry1);
   if(rs1.next())
	 {%>
	 <td class=rptValue align="right" nowrap><%=rs1.getString(1)%></td>

	 <%}
	else{%>
              <td class=rptValue align="right" nowrap>-</td>
	 <%}


   %>
   </tr>
 <%}
 if(sno==0)
 {%>
   <tr>
   <td class=rptValue colspan=10 align="center">No Records Matching With This Selection Crietria</td></tr>
 <%}
 %>