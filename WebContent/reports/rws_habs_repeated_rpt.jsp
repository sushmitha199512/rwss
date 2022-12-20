<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%String qry="",qry1="",qry2="",qry3="";
 Statement stmt1=null,stmt2=null,stmt3=null;
 ResultSet rs1=null,rs2=null,rs3=null;
String ftype=request.getParameter("ftype");
try{
%>
<html>
<body>
<table border = 1 cellspacing = 0 cellpadding = 0 width=75%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
<caption>
			<table  border=0 rules=none style="border-collapse:collapse" width=75% align="right" bgcolor="#edf2f8">		
				<tr align="right">
					<td  class="bwborder"><a href="javascript:history.back(-1)">Back|</a> 
					<a href="../home.jsp">Home</a>
                </tr>
			</table>
		</caption>
  <tr bgcolor="lavander">
		<td class="textborder" align="center" colspan="11">
		<font color="ffffff">Project Shelf  List of Works for Repeated Habitations </font></td>
 </tr>
<tr>
  <td class=btext>Sl.no</td>
  <td class=btext>Name Of the Work</td>
  <td class=btext>Work Id</td>
  <td class=btext>Admin Sanc Ref No</td>
  <td class=btext>Estimation Cost</td>
  <td class=btext>Program Name</td>
  <td class=btext>Type Of Scheme(MVS/SVS)</td>
  <td class=btext>Habitation Name</td>
  <td class=btext>Habitation Id</td>
  <td class=btext>Status</td>
  <td class=btext>Mandal Name</td>
</tr>
<% qry="select hab_code from rws_works_action_plan_habs_tbl a,rws_ddws_scheme_data_port b where a.work_id=b.work_id and a.fin_year=b.fin_year and work_asset='W' ";
 if(ftype!=null && !ftype.equals("-1"))
 {
	 qry+=" and a.fin_year='"+ftype+"' ";
 }
qry+=" group by hab_code having count(*)>1 ";
//// System.out.println("qry:"+qry);
stmt=conn.createStatement();
stmt1=conn.createStatement();
stmt2=conn.createStatement();
stmt3=conn.createStatement();
rs=stmt.executeQuery(qry);
int count=0;
while(rs.next())
{

qry1="select a.work_id,work_name,admin_no,sanction_amount,programme_name from rws_work_admn_tbl a,rws_admn_hab_lnk_tbl b,rws_works_action_plan_habs_tbl c,rws_programme_tbl p where a.work_id=b.work_id and a.work_id =c.work_id and b.hab_code=c.hab_code and a.programme_code=p.programme_code and b.hab_code='"+rs.getString(1)+"'  ";
rs1=stmt1.executeQuery(qry1);
while(rs1.next())
	{%>
	   <tr>
	   <td class=rptValue><%=++count%></td>
	   <td class=rptValue nowrap><%=rs1.getString(2)%></td>
	   <td class=rptValue><%=rs1.getString(1)%></td>
	   <td class=rptValue nowrap><%=rs1.getString(3)%></td>
	   <td class=rptValue align="right"><%=rs1.getString(4)%></td>
	   <td class=rptValue nowrap ><%=rs1.getString(5)%></td>
	
	<%qry2="select work_id,count(*) from rws_works_action_plan_habs_tbl where work_id='"+rs1.getString(1)+"' group by work_id";
	rs2=stmt2.executeQuery(qry2);
    if(rs2.next())
		{
           if(rs2.getInt(2) >1)
			{%>
			   <td class=rptValue>MVS</td>

			<%}else
			{%>
					<td class=rptValue>SVS</td>
			<%}

		}
  qry3="select h.hab_code,panch_name,coverage_status,mname from rws_habitation_directory_tbl h,rws_panchayat_raj_tbl p,rws_mandal_tbl m where h.hab_code=p.panch_code and substr(h.hab_code,1,2)=m.dcode and substr(h.hab_code,6,2)=m.mcode and h.hab_code='"+rs.getString(1)+"' ";
   rs3=stmt3.executeQuery(qry3);
   if(rs3.next())
		{%>
			 <td class=rptValue><%=rs3.getString(2)%></td>
			 <td class=rptValue nowrap><%=rs3.getString(1)%></td>
			 <td class=rptValue><%=rs3.getString(3)%></td>
			 <td class=rptValue><%=rs3.getString(4)%></td>

		<%}
	
	}


}
//// System.out.println("count"+count);
if(count==0)
	{%>
	<tr><td colspan=11 align="center">No Records Matching With This Selection Crietria</td></tr>
	<%}
%>
</table>
</body>
</html>
<%} catch(Exception e) {
	
}finally {
   if(rs3!=null) rs3.close();
   if(rs2!=null) rs2.close();
   if(rs1!=null) rs1.close();
   if(rs!=null) rs.close();

}%>