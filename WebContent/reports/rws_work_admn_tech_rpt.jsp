<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>

<html>
<body>
<%
String dcode=request.getParameter("district");
String acode=request.getParameter("wrktype");
String year=request.getParameter("fnyear");
%>
<table border = 1 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
<caption>
		<table  border=0 rules=none style="border-collapse:collapse" width=100% align="right" bgcolor="#edf2f8">		
			<tr><td align="right" class="bwborder"><a href="../home.jsp">Home|
			<a href="javascript:history.go(-1)">Back|
			<a href="./rws_work_admn_tech_xls.jsp?district=<%=dcode%>&wrktype=<%=acode%>&fnyear=<%=year%>" target=_new>Excel</td></tr>
		</table>
	</caption>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=10>Difference In Admn and Tech Habs Report</td>	
	</tr>
<td class=btext>Sl.No</td>
<td class=btext>Work Id</td>
<td class=btext>Work Name</td>
<td class=btext>Admin No</td>
<td class=btext>Admin Date</td>
<td class=btext>Estimation Cost(in Lakhs)</td>
<td class=btext>No of Admin Habs</td>
<td class=btext>No of Tech habs</td>
<td class=btext>Work Status</td>
</tr>
<%

Statement stmt1=null,stmt2=null,stmt3=null;
ResultSet rs1=null,rs2=null,rs3=null;
int sno=0;
String qry1="",qry2="";
String qry="select work_id from rws_work_admn_tbl where substr(work_id,5,2)='"+dcode+"' and work_cancel_dt is null ";
if(acode!=null && !acode.equals("") &&  !acode.equals("-1"))
{
	qry+=" and category_code='"+acode+"' ";
}
if(year!=null && !year.equals("")  && !year.equals("-1"))
{
	qry+=" and to_char (admin_date,'yyyy') ='"+year+"' ";
}
////System.out.println("qry:"+qry);
stmt=conn.createStatement();
stmt1=conn.createStatement();
stmt2=conn.createStatement();
stmt3=conn.createStatement();
rs=stmt.executeQuery(qry);
while(rs.next())
{
  qry1="select (select count(b.hab_code)  from rws_work_admn_tbl a, rws_admn_hab_lnk_tbl b where a.work_id=b.work_id and admin_no is not null and admin_date is not null and a.work_id='"+rs.getString(1)+"')a,(select count(b.hab_code)  from rws_new_est_tbl a, rws_est_new_hab_lnk_tbl b where a.work_id=b.work_id and ts_no is not null and ts_date is not null and   a.work_id='"+rs.getString(1)+"')b from dual";
  // ,(select count(b.hab_code)  from RWS_WORK_COMPLETION_TBL a, RWS_WORK_COMP_HAB_LNK_TBL b where a.work_id=b.work_id and DATE_OF_COMPLETION is not null and a.work_id='"+rs.getString(1)+"')c from dual";
  ////System.out.println("gggg:"+qry1);
   rs1=stmt1.executeQuery(qry1);
   if(rs1.next())
	{
	   ////System.out.println("sssssss");
	    if (rs1.getInt(1) != rs1.getInt(2)) // || (rs1.getInt(2) != rs1.getInt(3)) || (rs1.getInt(1) != rs1.getInt(3)) )
		{
			 qry2="select work_name, admin_no,admin_date from rws_work_admn_tbl where work_id='"+rs.getString(1)+"' ";
			%>
         <tr>
		  <td class=rptValue><%= ++sno%></td>
		  <td class=rptValue><%= rs.getString(1)%></td>
		  <%
		       qry2="select work_name, admin_no,to_char(admin_date,'dd/MM/YYYY'),sanction_amount from rws_work_admn_tbl where work_id='"+rs.getString(1)+"' ";
		    	rs2=stmt2.executeQuery(qry2);
			   if(rs2.next()) {%>
			 <td class=rptValue nowrap><%= rs2.getString(1)%></td>
			 <td class=rptValue nowrap><%= rs2.getString(2)%></td>
			 <td class=rptValue nowrap><%= rs2.getString(3)%></td>
			 <td class=rptValue  align="right" nowrap><%= rs2.getString(4)%></td>
			 <%}
			   String qry3="select  (select grounding_date from rws_work_commencement_tbl  where work_id='"+rs.getString(1)+"')a,(select  date_of_completion from rws_work_completion_tbl  where work_id='"+rs.getString(1)+"')b from dual ";   
			   rs3=stmt3.executeQuery(qry3);
			   String status="";
			   if(rs3.next())
			  {
				  if(rs3.getString(2)!=null && !rs3.getString(2).equals(""))
				  {
                     status="Completed";
				  }
				  else  if(rs3.getString(1)!=null && !rs3.getString(1).equals(""))
				  {
                     status="Grounded";
				  }
				  else{
					  status="Not Grounded";
				  }


			  }
			  else
			  {
				   status="Not Grounded";
			  }

			  
			   %>
			    <td class=rptValue  align="right"  nowrap><font color="blue"><%= rs1.getString(1)%></font></td>
			    <td class=rptValue   align="right"  nowrap><font color="blue"><%= rs1.getString(2)%></font></td>
			    <td class=rptValue nowrap><%=status%></td>

			
			 
		 </tr>

		<%}
	}


}
if(sno==0)
{
	%>
         <tr>
		  <td class=rptValue align="center" colspan=10>No Records Matching With This Selection Crietria </td></tr>
<%}
%>
</table>
<%@ include file = "footer.jsp" %>
</body>
</html>
