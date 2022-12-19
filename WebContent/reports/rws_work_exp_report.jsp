<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%	
Statement st1 = null,s=null,s1=null,s2=null,s3=null,ss=null;
Statement st2 = null,st22=null,ss1=null;
ResultSet rs2 = null,r=null,r1=null,r2=null,rr=null,rss=null,rr1=null,rss1=null;
	Statement stmt1 = null;
	ResultSet rs1 = null;
	ResultSetMetaData rsm=null;
	String query=null,query2=null;
	//String[] record = null;
		int Count=0,Cnt=0,slno=0,sl=0,Counts=0,no=0;
	//int start,end,limit = 3;
	//String assetType = request.getParameter("aType");
	String dName = String.valueOf(session.getAttribute("dName"));
	String dCode = String.valueOf(session.getAttribute("dCode"));
	
	
	

try
{
	
	/*query ="select distinct nvl(w.WORK_NAME,'-'),nvl(w.work_id,'-'),count(ln.hab_code),nvl(SANCTION_AMOUNT,'0'),nvl(w.ADMIN_NO,'0'),nvl(to_char(w.ADMIN_DATE,'dd-mm-yyyy'),'-'),p.programme_name from RWS_WORK_ADMN_TBL w,RWS_PANCHAYAT_RAJ_TBL PR,RWS_ADMN_HAB_LNK_TBL ln,rws_programme_tbl p,rws_circle_office_tbl c where substr(w.office_code,2,2)=c.circle_office_code and w.work_id=ln.work_id and ln.hab_code=pr.panch_code(+) and w.programme_code=p.programme_code  and  substr(w.office_code,2,2)='"+dCode+"' group by nvl(w.WORK_NAME,'-'),nvl(w.work_id,'-'),nvl(SANCTION_AMOUNT,'0'),nvl(w.ADMIN_NO,'0'),nvl(to_char(w.ADMIN_DATE,'dd-mm-yyyy'),'-'),p.programme_name";*/

	/*query ="select distinct nvl(w.WORK_NAME,'-'),nvl(w.work_id,'-') from RWS_WORK_ADMN_TBL w,rws_work_admn_prog_lnk_tbl prg where w.work_id(+)=prg.work_id and w.programme_code=prg.programme_code and substr(w.office_code,2,2)='"+dCode+"'" ;*/

     query ="select distinct nvl(w.WORK_NAME,'-'),nvl(w.work_id,'-') from RWS_WORK_ADMN_TBL w,rws_work_expenditure_tbl e where w.work_id=e.work_id and substr(w.office_code,2,2) ='"+dCode+"'";


 stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
 st1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
 st2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
  
 rs = stmt.executeQuery(query);
rs.setFetchSize(500);
 rs.last();
Count = rs.getRow();
rs.beforeFirst();%>

<html>
<head>
<script>
  window.history.forward(1);
  </script>
</head>
<body bgcolor="#edf2f8">

<form name=f1 method="post">

<table border = 1 cellspacing = 0 cellpadding = 0   bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="./rws_work_expenditure_frm.jsp">Back |</a></td>
				<td class="bwborder"><a href="../home.jsp">Home |</a></td>
				
			</tr>
		</table>
	</caption>

<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=10>Work Expenditure Report</font></td>	
	</tr>
<% 
	
		
			//System.out.println("IN DISTRICT SELECTION LABEL...");
%>	
	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=10>District: <%=dName%></font></td>	
	</tr>	

	
	
		<tr align=center bgcolor="#ffffff">
		<td  class= "btext" rowspan=2>S.NO</td>
		<td class="btext" rowspan=2>WorkId/WorkName</td>
		<td class="btext" rowspan=2>ProgrammeName</td>
		<td class="btext" colspan=5>Expenditure During<br>The Year<br>(Rs In Lakhs)</td>
		<td class="btext" rowspan=2>Expenditure During<br>The Prev Year<br>(Rs In Lakhs)</td>
		</tr>
		<tr>
	    <td class="btext">Year</td>
		<td class="btext">Month</td>
		<td class="btext">Upto Previous<br>Month</td>
		<td class="btext">During The<br> Month</td>
		<td class="btext">Value of work<br>done but not paid</td>
		</tr>
		
		
	
<%	
	if(Count!=0)
	{
	while(rs.next())
	{
	%>	
	    <tr bgcolor="#ffffff">
		<td class=rptValue><%=++slno%></td>			
		<td class=rptValue><%=rs.getString(2)%>/<br><%=rs.getString(1)%></td>
	   
		
		<%
         int sno=0,habs=1,habs1=0,serial=0,ha=1;
		
		String qury1="select distinct e.programme_code,p.programme_name,nvl(e.Year,'-'),nvl(decode(e.Month,'01','January','02','February','03','March','04','April','05','May','06','June','07','July','08','August','09','September','10','October','11','November','12','December'),'-'),nvl(e.EXPENDITURE_UPTO,'0'),nvl(e.EXPENDITURE_During,'0'),nvl(e.VALUE_OF_WORK_NOT_PAID,'0')  from rws_work_expenditure_tbl e,rws_programme_tbl p where e.programme_code=p.programme_code and e.work_id='"+rs.getString(2)+"'";
        
		String qury2="select distinct e.programme_code,nvl(prev.expenditure_upto_the_pre_year,'0') from rws_work_expenditure_tbl e,RWS_WORK_EXP_UPTO_PRE_YEAR_TBL prev where e.programme_code=prev.programme_code and e.work_id=prev.work_id and e.work_id='"+rs.getString(2)+"'";
		//out.println(qury1);

        rs1 = st1.executeQuery(qury1);
		rs2 = st2.executeQuery(qury2);
		rs1.setFetchSize(500);
        rs1.last();
        Cnt = rs1.getRow();
        rs1.beforeFirst();

		if(Cnt!=0)
		{
		while(rs1.next())
		{
			//out.println(rs1.getString(2));%>
	    
		<td class="rptValue" ><%=++sno%>.&nbsp;<%=rs1.getString(2)%></td>
		<td class="rptValue" ><%=rs1.getString(3)%></td>
		<td class="rptValue" ><%=rs1.getString(4)%></td>
		<td class="rptValue" ><%=rs1.getFloat(5)%></td>
		<td class="rptValue" ><%=rs1.getFloat(6)%></td>
		<td class="rptValue" ><%=rs1.getFloat(7)%></td>
		<% if(rs2.next())
			{%>
			<td class="rptValue" ><%=rs2.getFloat(2)%></td>
			<%}
		else
		%>
         <td class="rptValue" >-</td>
		</tr>
		<tr>
		<td colspan=2>
		</tr>
<% 
}
		}
		
			else
		{%>
		<td class=rptValue align="center">-</td>
	    <td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		<td class=rptValue align="center">-</td>
		
		</tr>
		<% }%>
</tr>		
<% }//end of main while

	}
else
	{%>
	 <tr bgcolor="#ffffff">
	 <td colspan=7></td>
	 <tr>
		<td class=rptValue colspan=10 align=center><a href="./rws_work_expenditure_frm.jsp"><b>No Records</b></a></td>
		</tr>
		<% }
}
catch(Exception e)
{
	e.printStackTrace();
}
	finally
	{
	conn.close();
	}
%>
</table>
<p class="rptHeading" align="right"><b>Total No of Records is:<%=slno%></b></p>
<input type="hidden" name="pass"> 
<%@ include file = "footer.jsp" %>
</form>
</body>
</html>
