<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%	
Statement st1 = null;
	Statement stmt1 = null;
	ResultSet rs1 = null;
	ResultSetMetaData rsm=null;
    Statement s = null,s1=null;
	//ResultSet rs1 = null;
	ResultSet r1 = null,r=null,r2=null;
	String query=null,query2=null;
	//String[] record = null;
		int Count=0,Cnt=0,slno=0;
	//int start,end,limit = 3;
	//String assetType = request.getParameter("aType");
	String dName = String.valueOf(session.getAttribute("dName"));
	String dCode = String.valueOf(session.getAttribute("dCode"));
	
	
	

try
{
	
	query ="select distinct nvl(w.WORK_NAME,'-'),nvl(e.work_id,'-'),count(ln.hab_code),nvl (e.TS_AMOUNT,'0'),nvl(e.TS_NO,'0'),nvl(to_char(e.TS_DATE,'dd-mm-yyyy'),'- '),nvl(e.SSR_YEAR,'-') from RWS_WORK_ADMN_TBL w,RWS_NEW_EST_TBL e,RWS_EST_NEW_HAB_LNK_TBL ln where w.work_id=e.work_id and e.work_id=ln.work_id and substr(w.office_code,2,2)='"+dCode+"' group by nvl(w.WORK_NAME,'-'),nvl (e.work_id,'-'),nvl(e.TS_AMOUNT,'0'),e.TS_NO,e.ts_date,e.ssr_year";
	

	
	
		
 stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
 st1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

 rs = stmt.executeQuery(query);
rs.setFetchSize(500);
 rs.last();
Count = rs.getRow();
// System.out.println("Total Records = "+Count);
rs.beforeFirst();%>

<html>
<head>
<script>
  window.history.forward(1);
  </script>
</head>
<body bgcolor="#edf2f8">

<form name=f1 method="post">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="./rws_tech_status_form.jsp">Back |</a></td>
				<td class="bwborder"><a href="../home.jsp">Home |</a></td>
				
			</tr>
		</table>
	</caption>

<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=16>Technical Sanction Report Details</font></td>	
	</tr>
<% 
	
		
			//System.out.println("IN DISTRICT SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=16>District: <%=dName%></font></td>	
	</tr>	

	
	
		<tr align=center bgcolor="#ffffff" align=center>
		<td  class= "btext">S.No</td>
		<td class="btext" >WorkId/WorkName</td>
		<td class="btext" >Tech Sanction<br>Amt(Rs In Lakhs)</td>
		<td class="btext" >TSNo/TSDate</td>
	    <td class="btext" >SSRYear</td>
		<td class="btext">No Of Habs/Habitations</td>
		<td class="btext" rowspan=2>Population</td>
		<td class="btext" rowspan=2>Coverage Status</td>
		</tr>
	
<%	
	if(Count!=0)
	{%>
	
	<% while(rs.next())
	{
	%>	
	     <tr bgcolor="#ffffff">
		<td class=rptValue><%=++slno%></td>			
		<td class=rptValue><%=rs.getString(2)%>/<br><%=rs.getString(1)%></td>
		<td class="rptValue"><%=rs.getFloat(4)%></td>
		<td class="rptValue"><%=rs.getString(5)%>/<br><%=rs.getString(6)%></td>			
		<td class=rptValue><%=rs.getString(7)%></td>
		<td class=rptValue align="center"><b><%=rs.getString(3)%></b></td>
		</tr>
		<% 
	
		String qury ="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),nvl(coverage_status,'-') from RWS_WORK_ADMN_TBL w,RWS_NEW_EST_TBL e,RWS_EST_NEW_HAB_LNK_TBL ln,RWS_PANCHAYAT_RAJ_TBL PR,rws_habitation_directory_tbl h where w.work_id=e.work_id and e.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and  substr(w.office_code,2,2)='"+dCode+"' and ln.work_id='"+rs.getString(2)+"' order by pr.panch_code";

		
		rs1 = st1.executeQuery(qury);
        rs1.setFetchSize(500);
        rs1.last();
        Count = rs1.getRow();
		rs1.beforeFirst();
		int sno=0;
		while(rs1.next())
		{
			
			%>
		<tr>
		<td colspan=5></td>
		<td class="rptValue"><%=++sno%>.&nbsp;<%=rs1.getString(2)%></td>
		<td class="rptValue"><%=rs1.getString(3)%></td>
		<td class="rptValue"><%=rs1.getString(4)%></td>
		</tr>
		<% }
      
	
      String q1="select distinct nvl(w.WORK_NAME,'-'),nvl(e.work_id,'-'),count(ln.hab_code),nvl(e.rev_sanctioned_AMOUNT,'0'),nvl(e.rev_TS_NO,'0'),nvl(to_char(e.rev_TS_DATE,'dd-mm-yyyy'),'- '),nvl(e.SSR_YEAR,'-') from RWS_WORK_ADMN_TBL w,RWS_NEW_REVISED_EST_TBL e,RWS_REV_EST_NEW_HAB_LNK_TBL ln where w.work_id=e.work_id and e.work_id=ln.work_id and e.work_id='"+rs.getString(2)+"' group by w.WORK_NAME,e.work_id,e.rev_sanctioned_AMOUNT,e.rev_TS_NO,e.rev_TS_DATE,e.SSR_YEAR";

 s = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
 s1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
// s2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);

r= s.executeQuery(q1);
r.setFetchSize(500);
 r.last();
int Counts = r.getRow();
// System.out.println("Total Records = "+Count);
r.beforeFirst();
if(Counts!=0)
		{
	while(r.next())
			{
               %>	
	    <tr bgcolor="#ffffff">
		<td class=rptValue rowspan=1></td>			
		<td class=rptValue rowspan=1 ><b><%=r.getString(1)%><br>(Revised To)</br></b></td>
        <td class="rptValue"><%=r.getFloat(4)%></td>
		<td class="rptValue"><%=r.getString(5)%>/<br><%=r.getString(6)%></td>			
		<td class=rptValue ><%=r.getString(7)%></td>
		<td class=rptValue align="center"><b><%=r.getString(3)%></b></td>
		</tr>
		
		<% 
	
		String q2 ="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0'),nvl(coverage_status,'-') from RWS_WORK_ADMN_TBL w,RWS_NEW_REVISED_EST_TBL e,RWS_REV_EST_NEW_HAB_LNK_TBL ln,RWS_PANCHAYAT_RAJ_TBL PR,rws_habitation_directory_tbl h where  e.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+rs.getString(2)+"' order by pr.panch_code";

		r2 = s1.executeQuery(q2);
        r2.setFetchSize(500);
        r2.last();
        int Countss = r2.getRow();
		r2.beforeFirst();
		int sln=0;
		while(r2.next())
		{
			
			%>
		<tr>
		<td colspan=5></td>
		<td class="rptValue"><%=++sln%>.&nbsp;<%=r2.getString(2)%></td>
		<td class="rptValue"><%=r2.getString(3)%></td>
		<td class="rptValue"><%=r2.getString(4)%></td>
		</tr>
		<% }
			
			}
} 
	}
	}
else
	{%>
	 <tr bgcolor="#ffffff">
		<td class=rptValue colspan=6 align=center><a href="./rws_tech_status_form.jsp"><b>No Records</b></a></td>
		<% }
}
catch(Exception e)
{
	//e.printStackTrace();
}
	finally
	{
	conn.close();
	}
%>
</table>
<p class="rptHeading" align="right"><b>Total No of Records is:<%=slno%></b></p>
<!--<input type="hidden" name="pass"> -->
<%@ include file = "footer.jsp" %>
</form>
</body>
</html>
