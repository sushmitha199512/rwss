<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%	
Statement st1 = null,s=null,s1=null,s2=null,s3=null,ss=null;
Statement st2 = null,st22=null,ss1=null;
ResultSet rs2 = null,r=null,r1=null,r2=null,rr=null,rss=null,rr1=null,rss1=null;
	Statement stmt1 = null;
	ResultSet rs1 = null;
	//ResultSet rs2 = null;
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

     query ="select distinct nvl(w.work_id,'-'),nvl(w.work_name,'-') from RWS_WORK_ADMN_TBL w,RWS_CONTRACTOR_SELECTION_TBL con,RWS_WORK_COMPLETION_TBL COM,RWS_WORK_COMMENCEMENT_TBL COMM,RWS_WORK_COMP_HAB_LNK_TBL LN where w.work_id=con.work_id and w.work_id=com.work_id and W.WORK_ID=COMM.WORK_ID AND W.WORK_ID=LN.WORK_ID AND substr(w.office_code,2,2)='"+dCode+"'"; 
	 /*query ="select distinct nvl(con.work_id,'-') from RWS_CONTRACTOR_SELECTION_TBL con,RWS_TENDER_APPL_TBL ten where con.work_id=ten.work_id and  substr(con.work_id,5,2)='"+dCode+"'";*/
     
	 //t.println(query);

 stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
 st1 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
  st2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
  ss = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);


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
				<td class="bwborder"><a href="./rws_work_completion_frm.jsp">Back |</a></td>
				<td class="bwborder"><a href="../home.jsp">Home |</a></td>
				
			</tr>
		</table>
	</caption>

<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=18>Work Completion Report </font></td>	
	</tr>

	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=18>District: <%=dName%></font></td>	
	</tr>	

	
	
		<tr align=center bgcolor="#ffffff" >
		<td  class= "btext" rowspan=2>S.NO</td>
		<td class="btext" rowspan=2>WorkId/WorkName</td>
		<td class="btext" rowspan=2>Start Date</td>
		<td class="btext" rowspan=2>Stipulated Date Of<br>Completion</td>
		<td class="btext" rowspan=2>Actual Date Of<br>Completion</td>
		<td class="btext" rowspan=2>Date Of<br> Commissioning</td>
	    <td class="btext" rowspan=2>Habitations<br>Benefitted</td>
		<td class="btext" rowspan=2>Habitations</td>
		
		<td class="btext" colspan=4>Population Benefitted</td>
       </tr>
	   <tr>
	   <td class="btext">Plain</td>
	   <td class="btext">SC</td>
	   <td class="btext">ST</td>
	   <td class="btext">Total</td>
	   </tr>
	
<%	
	 int sno=0,habs=1,habs1=0,ha=1;
	if(Count!=0)
	{
	while(rs.next())
	{ sno++;
		%>
		 
	  
		<tr>
		<td class=rptValue align="center"><%=sno%></td>
		<td class=rptValue align="center"><%=rs.getString(1)%>/<%=rs.getString(2)%></td>
		<%
			String qury1="select distinct NVL(TO_CHAR(COMM.GROUNDING_DATE,'DD-MON-YYYY'),'-'),NVL(TO_CHAR (CON.DATE_OF_COMPLETION,'DD-MON-YYYY'),'-'),NVL(TO_CHAR (COM.DATE_OF_COMPLETION,'DD-MON-YYYY'),'-'),NVL(TO_CHAR(COM.DATE_OF_COMM,'DD- MON-YYYY'),'-'),count(ln.hab_code) from RWS_CONTRACTOR_SELECTION_TBL CON,RWS_WORK_COMMENCEMENT_TBL COMM,RWS_WORK_COMPLETION_TBL COM,RWS_WORK_COMP_HAB_LNK_TBL LN where con.work_id=COMM.WORK_ID AND CON.WORK_ID=COM.WORK_ID AND CON.WORK_ID=LN.WORK_ID AND CON.WORK_ID='"+rs.getString(1)+"' group by COMM.GROUNDING_DATE,CON.DATE_OF_COMPLETION, COM.DATE_OF_COMPLETION,COM.DATE_OF_COMM";
        
		//out.println(qury1);
        rs1 = st1.executeQuery(qury1);
	    rs1.beforeFirst();
		while(rs1.next())
		{
			%>
		<td class=rptValue align="center"><%=rs1.getString(1)%></td>
		<td class=rptValue align="center"><%=rs1.getString(2)%></td>
		<td class=rptValue align="center"><%=rs1.getString(3)%></td>
		<td class=rptValue align="center"><%=rs1.getString(4)%></td>
		<td class=rptValue align="center"><b><%=rs1.getString(5)%></b></td>
		
	    
		<% 
			String q="select distinct pr.panch_code,nvl(pr.panch_name,'-'),nvl(CENSUS_PLAIN_POPU,'0'), nvl(CENSUS_SC_POPU,'0'),nvl(CENSUS_ST_POPU,'0'),nvl(CENSUS_PLAIN_POPU,'0')+ nvl(CENSUS_SC_POPU,'0')+nvl(CENSUS_ST_POPU,'0') from RWS_PANCHAYAT_RAJ_TBL PR,RWS_WORK_COMP_HAB_LNK_TBL ln,rws_habitation_directory_tbl h where  ln.hab_code=pr.panch_code(+) and ln.hab_code=h.hab_code(+) and ln.work_id='"+rs.getString(1)+"' order by pr.panch_code"; 

           rs2 = st2.executeQuery(q);
           rs2.setFetchSize(500);
           rs2.last();
           Cnt = rs2.getRow();
           rs2.beforeFirst();
		   if(Cnt!=0)
		{
			   int serial=0;
		while(rs2.next())
		{ 
		serial++;%>
		
		<td class=rptValue><%=serial%>.&nbsp;<%=rs2.getString(2)%></td>
		<td class=rptValue><%=rs2.getString(3)%></td>
		<td class=rptValue ><%=rs2.getString(4)%></td>
		<td class=rptValue ><%=rs2.getString(5)%></td>
		<td class=rptValue><%=rs2.getString(6)%></td>
		</tr>
		<tr>
		<td colspan=7>
		</tr>
<% 
		}
		}
		else
		{%>
		<td class=rptValue>-</td>
		<td class=rptValue>-</td>
		<td class=rptValue>-</td>
		<td class=rptValue>-</td>
		<td class=rptValue >-</td>
		</tr>
		<% }
         
	} 
		
	}
	}
	
	else
	{%>
	 <tr bgcolor="#ffffff">
	 <td colspan=7></td>
	 <tr>
		<td class=rptValue colspan=18 align=center><a href="./rws_work_completion_frm.jsp"><b>No Records</b></a></td>
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
<!--<p class="rptHeading" align="right"><b>Total No of Records is:<%=slno%></b></p>
<input type="hidden" name="pass"> -->
<%@ include file = "footer.jsp" %>
</form>
</body>
</html>
