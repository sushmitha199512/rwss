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

     query ="select distinct nvl(w.work_id,'-'),nvl(w.work_name,'-') from RWS_WORK_ADMN_TBL w,RWS_CONTRACTOR_SELECTION_TBL con,RWS_TENDER_APPL_TBL ten where w.work_id=con.work_id  and con.work_id=ten.work_id and substr(w.office_code,2,2)='"+dCode+"'";
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
				<td class="bwborder"><a href="./rws_contractor_frm.jsp">Back |</a></td>
				<td class="bwborder"><a href="../home.jsp">Home |</a></td>
				
			</tr>
		</table>
	</caption>

<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=18>Contractor Report Details</font></td>	
	</tr>

	<tr bgcolor="#edf2f8" align="center">
		<td align="center" class="rptValue" colspan=18>District: <%=dName%></font></td>	
	</tr>	

	
	
		<tr align=center bgcolor="#ffffff" >
		<td  class= "btext" rowspan=2>S.NO</td>
		<td class="btext" rowspan=2>WorkId/WorkName</td>
		<td class="btext" rowspan=2>Tender<br>Notification Id</td>
		<td class="btext" rowspan=2>Tender Cost(In Lakhs)</td>
		<td class="btext" rowspan=2>Contractor Name</td>
		<td class="btext" rowspan=2 >Tender<br>Accepted Date</td>
	    <td class="btext" rowspan=2>LOA<BR>issued on date</td>
		<td class="btext" rowspan=2>Agreement RefNo</td>
		<td class="btext" rowspan=2>Agreement Date</td>
		<td class="btext" rowspan=2>Agreement Duration<br> In Months</td>
		<td class="btext" rowspan=2>Agreement Value</td>
		<td class="btext" rowspan=2>Site Handing<br>Over Date</td>
		<td class="btext" rowspan=2>Stipulated Date Of<br>Completion</td>
		<td class="btext" colspan=5>Work Milestone</td>
       </tr>
	   <tr>
	   <td class="btext">Slno</td>
	   <td class="btext">Milestone</td>
	   <td class="btext">Stage</td>
	   <td class="btext">TargetDate</td>
	   <td class="btext">Percent<br>Completed</td>
		</tr>
	
<%	
	 int sno=0,habs=1,habs1=0,serial=0,ha=1;
	if(Count!=0)
	{
	while(rs.next())
	{
		 String qury1="select distinct ten.TENDER_IDNO,ten.TENDER_AMOUNT,nvl(ten.CONTRACTOR_NAME,'-'),nvl(to_char(con.TENDER_APPROVED_ON,'dd-mm-yyyy'),'-'),nvl(TO_CHAR(con.LOA_ISSUED_ON,'DD-MON-YYYY'),'-'),nvl(con.AGREEMENT_REFERENCE_NO,'-'),nvl(TO_CHAR(con.AGREEMENT_DATE,'DD-MON-YYYY'),'-'),nvl(con.AGREEMENT_DURATION,'0'),nvl(con.AGREEMENT_VALUE,'0'),nvl(TO_CHAR(con.SITE_HAND_OVER_DATE,'DD-MON-YYYY'),'-'),nvl(TO_CHAR(con.DATE_OF_COMPLETION,'DD-MON-YYYY'),'-') from RWS_CONTRACTOR_SELECTION_TBL con,RWS_TENDER_APPL_TBL ten where con.TENDER_IDNO=ten.TENDER_IDNO and con.work_id='"+rs.getString(1)+"'";
        
		//out.println(qury1);
        rs1 = st1.executeQuery(qury1);
       
	    rs1.beforeFirst();
		rs1.next();
		sno++; %>
	  
		<tr>
		<td class=rptValue align="center"><%=sno%></td>
		<td class=rptValue align="center"><%=rs.getString(1)%>/<%=rs.getString(2)%></td>
		<td class=rptValue align="center"><%=rs1.getString(1)%></td>
		<td class=rptValue align="center"><%=rs1.getFloat(2)%></td>
		<td class=rptValue align="center"><%=rs1.getString(3)%></td>
		<td class=rptValue align="center"><%=rs1.getString(4)%></td>
		<td class=rptValue align="center"><%=rs1.getString(5)%></td>
		<td class=rptValue align="center"><%=rs1.getString(6)%></td>
		<td class=rptValue align="center"><%=rs1.getString(7)%></td>
		<td class=rptValue align="center"><%=rs1.getString(8)%></td>
		<td class=rptValue align="center"><%=rs1.getString(9)%></td>
		<td class=rptValue align="center"><%=rs1.getString(10)%></td>
		<td class=rptValue align="center"><%=rs1.getString(11)%></td>
	    
		<% 
			String q="select distinct m.milestone_name, st.milestone_stage_name,NVL(TO_CHAR(mil.TARGET_DATE,'DD-MON-YYYY'),'-'),mil.PERCENT_COMPLETED from rws_milestone_tbl m,RWS_MILESTONE_TARGET_ACH_TBL mil,RWS_MILESTONE_STAGE_TBL st where m.milestone_code=mil.milestone_code and st.milestone_code=mil.milestone_code and st.milestone_stage_code=mil.milestone_stage_code and mil.work_id='"+rs.getString(1)+"'"; 

           rs2 = st2.executeQuery(q);
           rs2.setFetchSize(500);
           rs2.last();
           Cnt = rs2.getRow();
           rs2.beforeFirst();
		   if(Cnt!=0)
		{
		while(rs2.next())
		{ 
		serial++;%>
	   
		<td class=rptValue align="center"><%=serial%></td>
		<td class=rptValue align="center"><%=rs2.getString(1)%></td>
		<td class=rptValue align="center"><%=rs2.getString(2)%></td>
		<td class=rptValue align="center"><%=rs2.getString(3)%></td>
		<td class=rptValue align="center"><%=rs2.getString(4)%></td>
		</tr>
		<tr>
		<td colspan=13>
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
		</tr>
		<% }
         
	} 
		
	}
	else
	{%>
	 <tr bgcolor="#ffffff">
	 <td colspan=7></td>
	 <tr>
		<td class=rptValue colspan=18 align=center><a href="./rws_contractor_frm.jsp"><b>No Records</b></a></td>
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
