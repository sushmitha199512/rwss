<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header4.jsp"%>
<!--<%@ page import="nic.watersoft.masters.RwsMasterData" %>-->
<%@ include file = "conn.jsp" %>
<%
	java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("yyyy-MM-dd");
    java.util.Date currentDate = new java.util.Date();
    String currentYear= dateFormat.format(currentDate).substring(0,4);
    String currentMonth = dateFormat.format(currentDate).substring(5,7);
    //stem.out.println("The Current Month::"+currentMonth);
    int nextYear = Integer.parseInt(currentYear);
    nextYear++;
    String nextYear1 = ""+nextYear;
    String currentYearPeriod = currentYear + "-" + nextYear1;

    java.util.Date d1 = dateFormat.parse(currentYear+"-03-31");
    String financialYearFrom="";
    String financialYearTo="";
    if(currentDate.after(d1))
    {
    financialYearFrom="01-APR-"+currentYear;
    financialYearTo="31-Mar-"+(Integer.parseInt(currentYear)+1);
    }
    else
    {
    financialYearTo="01-APR-"+(Integer.parseInt(currentYear)-1);
    financialYearFrom="31-Mar-"+currentYear;
    }
    
	String rDistrict="", rConstituency="", rMandal="", rPanchayat="", rVillage="", rHabitation="", distvalue="", distname="", conname="", convalue="", manvalue="", manname="", panvalue="", panname="", vilvalue="", vilname ="";
	
	rDistrict = request.getParameter("district");
	rConstituency = request.getParameter("constituency");
	String query3="",query4="",query5="",hab="",hab_code="";
	
	String districtName="",mandalName="",panchayatName="",villageName="",constituencyName="",habitationName="",work_id="",workCategory="",programName = "",subprogramCode="";
	if(request.getParameter("work_id")!=null)
	{
	work_id = request.getParameter("work_id");
	session.setAttribute("work_id",work_id);
	}
	if(request.getParameter("hab_code")!=null)
	{
	hab_code = request.getParameter("hab_code");
	session.setAttribute("hab_code",hab_code);
	}
	
	if(request.getParameter("hab")!=null)
	{
	hab = request.getParameter("hab");
	session.setAttribute("hab",hab);
	}
	districtName = (String)session.getAttribute("districtName");
	constituencyName = (String)session.getAttribute("constituencyName");	
	String query=null, query1 = null,query2=null;
	ResultSet rs1 = null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null;
	ResultSet rs2 = null;
	Statement stmt1 = null;
	PreparedStatement pstmt = null;
	int slno = 0,total=0;
	int i = 0;
	boolean flag=true,flag1=false,flagp=true,flagn=true,flagd=true;
	
	int gnspills=0,gspills=0,gtspills=0,ghabsan=0,gtsno=0,gcomp=0,gcomm=0,ghabcov=0,gten=0,gagree=0,ggrnd=0;
	float gnspillamt=0,gspillamt=0,gtspamt=0,grevamt=0,gepreyr=0,geprev=0,gedur=0,gcum=0,getot=0;
	

try
{
%>
<html>
<head>
<!-- 
<script>
	window.history.forward(1);
</script>
 -->
</head>
<body bgcolor="#edf2f8">

<form name=f1 method="post">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			

	<% 
//		System.out.println("Work Id ::"+work_id);
	if(!hab.equals("1"))
	{
//		System.out.println("Work Id Report start here");
	   %>
	   <tr align="right">
			  				<td class="bwborder"><a href="javascript:history.go(-1)">Back|</a></td>
				<td class="bwborder"><a href="work_id_report_excel.jsp" target="_new">Excel|</a></td>
				 
			</tr>
		</table>
	</caption>
	   	<%@ include file="rws_worksmonitoring_work_id_report.jsp"%>
<%
String qry1="",qry2="",qry3="",qry4="",qry5="",qry6="",qry7="";



  		qry1 = "select distinct nvl(w.work_id,'-'),nvl(w.WORK_NAME,'-'),p.programme_name,sp.subprogramme_name from RWS_WORK_ADMN_TBL w,rws_programme_tbl p,rws_subprogramme_tbl sp where w.programme_code=p.programme_code and p.programme_code=sp.programme_code and w.programme_code=sp.programme_code and w.subprogramme_code=sp.subprogramme_code and w.work_id='"+work_id+"'";
  		stmt1 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs1=stmt1.executeQuery(qry1);
  		while(rs1.next())
		{
  		%>
		<tr>
		<td class=rptValue colspan=1><%=++slno%></td>
		<td class=rptValue colspan=1><%=rs1.getString(1)%></td>
		<td class=rptValue colspan=1><%=rs1.getString(2)%></td>
		<td class=rptValue colspan=1><%=rs1.getString(3)%></td>
		<td class=rptValue colspan=1><%=rs1.getString(4)%></td>
		<%

		qry2 = "select nvl(A.ADMIN_NO,'0'),nvl(to_char(A.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(A.SANCTION_AMOUNT,'0'),nvl(B.ADMIN_NO,'0'),nvl(to_char(B.ADMIN_DATE,'dd-mm-yyyy'),'-'),nvl(B.SANCTION_AMOUNT,'0'),NVL(P.PROGRAMME_NAME,'-') from rws_work_admn_tbl A,RWS_WORK_ADMN_PROG_LNK_TBL B,RWS_PROGRAMME_TBL P where A.WORK_ID=B.WORK_ID(+) AND B.PROGRAMME_CODE = P.PROGRAMME_CODE(+) AND A.work_id='"+rs1.getString(1)+"'";
		//System.out.println("THe 2nd Query is::"+qry2);		
		Statement stmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs2=stmt2.executeQuery(qry2);
		if(rs2.next())
		{
%>
		<td class=rptValue colspan=1><%=rs2.getString(1)%></td>
		<td class=rptValue colspan=1 nowrap><%=rs2.getString(2)%></td>
		<td class=rptValue colspan=1><%=rs2.getString(3)%></td>
		<td class=rptValue colspan=1><%=rs2.getString(7)%></td>
		<td class=rptValue colspan=1><%=rs2.getString(6)%></td>
	<%
 		 }
 		 else
 		 {
 		 %>
			<td class=rptValue colspan=1><center>-</center></td>
			<td class=rptValue colspan=1><center>-</center></td> 		 			
			<td class=rptValue colspan=1><center>-</center></td>
			<td class=rptValue colspan=1><center>-</center></td> 		 			
			<td class=rptValue colspan=1><center>-</center></td>
 		 <%
 		 }
		qry3 = "select nvl(TS_NO,'0'),nvl(to_char(TS_DATE,'dd-mm-yyyy'),'-'),nvl(TS_AMOUNT,'0') from RWS_NEW_EST_TBL where work_id="+rs1.getString(1)+"";
	//	System.out.println("THe 3nd Query is::"+qry3);		

		Statement stmt3 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs3=stmt3.executeQuery(qry3);
		if(rs3.next())
		{
%>
  		<td class=rptValue colspan=1 nowrap><%=rs3.getString(1)%></td>
		<td class=rptValue colspan=1 nowrap><%=rs3.getString(2)%></td>
		<td class=rptValue colspan=1><%=rs3.getString(3)%></td>
	<%
		}
		else
 		 {
 		 %>
			<td class=rptValue colspan=1><center>-</center></td>
			<td class=rptValue colspan=1><center>-</center></td> 		 			
			<td class=rptValue colspan=1><center>-</center></td>
 		 <%
 		 }
%><td class=rptValue colspan=1><center>-</center></td><%
	qry4 = "select distinct ten.CONTRACTOR_NAME_COMPANY,con.AGREEMENT_REFERENCE_NO,AGREEMENT_DURATION ,nvl(to_char(con.AGREEMENT_DATE ,'dd-mm-yyyy'),'-'),nvl(to_char(con.SITE_HAND_OVER_DATE  ,'dd-mm-yyyy'),'-') from RWS_CONTRACTOR_SELECTION_TBL con,RWS_contractor_TBL ten where con.CONTRACTOR_REG_NO =ten.CONTRACTOR_REG_NO  and con.work_id='"+rs1.getString(1)+"'";
		//System.out.println("THe 4nd Query is::"+qry4);		

		Statement stmt4 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs4=stmt4.executeQuery(qry4);
		if(rs4.next())
		{
	%>
  		<td class=rptValue colspan=1><%=rs4.getString(1)%></td>
		<td class=rptValue colspan=1 nowrap><%=rs4.getString(2)%></td>
		<td class=rptValue colspan=1 nowrap><%=rs4.getString(3)%></td>
		<td class=rptValue colspan=1 nowrap><%=rs4.getString(4)%></td>
		<td class=rptValue colspan=1 nowrap><%=rs4.getString(5)%></td>
	<%
		}
		else
		{
		%>
			<td class=rptValue colspan=1><center>-</center></td>
			<td class=rptValue colspan=1><center>-</center></td>
			<td class=rptValue colspan=1><center>-</center></td>
			<td class=rptValue colspan=1><center>-</center></td>
			<td class=rptValue colspan=1><center>-</center></td>
		<%
		}
        qry5="SELECT nvl(SUM(total),0) from rws_exp_view where WORK_ID='"+rs1.getString(1)+"'";
//		System.out.println("Query 5 is::"+qry5);
		Statement stmt5 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs5=stmt5.executeQuery(qry5);
		if(rs5.next())
		{%>
		   <td class=rptValue align=center><%=Math.round((rs5.getFloat(1))*100)/100f%></td>	
		 <%
		 }
	
		qry6 = "select distinct NVL(TO_CHAR(COMM.GROUNDING_DATE,'DD-MON-YYYY'),'-'),NVL(TO_CHAR (CON.DATE_OF_COMPLETION,'DD-MON-YYYY'),'-'),NVL(TO_CHAR (COM.DATE_OF_COMPLETION,'DD-MON-YYYY'),'-'),NVL(TO_CHAR(COM.DATE_OF_COMM,'DD- MON-YYYY'),'-') from RWS_CONTRACTOR_SELECTION_TBL CON,RWS_WORK_COMMENCEMENT_TBL COMM,RWS_WORK_COMPLETION_TBL COM,RWS_WORK_COMP_HAB_LNK_TBL LN where con.work_id=COMM.WORK_ID AND CON.WORK_ID=COM.WORK_ID AND CON.WORK_ID=LN.WORK_ID AND CON.WORK_ID='"+rs1.getString(1)+"' group by COMM.GROUNDING_DATE,CON.DATE_OF_COMPLETION,COM.DATE_OF_COMPLETION,COM.DATE_OF_COMM";
		//System.out.println("THe 6nd Query is::"+qry6);		

		Statement stmt6 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
		rs6=stmt6.executeQuery(qry6);
		if(rs6.next())
		{
		%>
	  		<td class=rptValue align="center" colspan=1 nowrap><%=rs6.getString(1)%></td>
	  		<td class=rptValue align="center" colspan=1 nowrap><%=rs6.getString(2)%></td>
	 		<td class=rptValue align="center" colspan=1 nowrap><%=rs6.getString(3)%></td>
	  		<td class=rptValue colspan=1 nowrap><%=rs6.getString(4)%></td>
<%
	}
	else
	{
	%>
		  	<td class=rptValue colspan=1><center>-</center></td>
		  	<td class=rptValue colspan=1><center>-</center></td>
		  	<td class=rptValue colspan=1><center>-</center></td>
		  	<td class=rptValue colspan=1><center>-</center></td>
	<%
	}
	qry7 = "select count(hl.hab_code) from rws_new_est_tbl est,rws_est_new_hab_lnk_tbl hl where est.work_id=hl.work_id and hl.work_id="+rs1.getString(1)+"";
	//System.out.println("Query 7 is::"+qry7);
//	String qry8 = "select hl.hab_code from rws_new_est_tbl est,rws_est_new_hab_lnk_tbl hl where est.work_id=hl.work_id and hl.work_id="+rs1.getString(1)+"";
	//System.out.println("Qry7 is::"+qry7);
	Statement stmt7 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	Statement stmt8 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
	rs7 = stmt7.executeQuery(qry7);
	//rs8 = stmt8.executeQuery(qry8);
	if(rs7.next())
	{if(!rs7.getString(1).equals("0")){
	%>
	  		<td class=rptValue colspan=1 align="center" title="Click to Get Habitation Details"><b><a href="work_id_report1.jsp?hab=1&work_id=<%=rs1.getString(1)%>"><%=rs7.getString(1)%></a></b></td>	
	<%
	}
	else
	{
	%>
			  	<td class=rptValue colspan=1><center>-</center></td>
			  	</table>
	<%}}
}//while
}//if
else
{
int Cnt = 0;
//System.out.println("In hab selection");
%>
<tr align="right">
			 				<td class="bwborder"><a href="javascript:history.go(-1)">Back|</a></td>
				<td class="bwborder"><a href="work_id_report_excel.jsp" target="_new">Excel|</a></td>
				 
			</tr>
		</table>
	</caption>
<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=8>Habitation Details Report for Work ID - <%=work_id%></td>	
	</tr>
	           <tr>
       <td colspan=1 class="btext">S.No.</td>
	   <td colspan=1 class="btext">Habitation Code</td>
   	   <td colspan=1 class="btext">Habitation Name</td>
	   <td colspan=1 class="btext">Plain</td>
	   <td colspan=1 class="btext">SC</td>
	   <td colspan=1 class="btext">ST</td>
	   <td colspan=1 class="btext">Total</td>
	   <td colspan=1 class="btext">Coverage Status</td>
	   </tr>
<%
String p = "select hl.hab_code from rws_new_est_tbl est,rws_est_new_hab_lnk_tbl hl where est.work_id=hl.work_id and hl.work_id="+work_id+"";
//System.out.println("The Query P is ::"+p);
Statement stmtp = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
ResultSet rsp = stmtp.executeQuery(p);
Statement stmt8 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
Statement stmt88 = conn.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
int sno = 0;
while(rsp.next())
{
	String q="select nvl(h1.CENSUS_PLAIN_POPU,'0'), nvl(h1.CENSUS_SC_POPU,'0'),nvl (h1.CENSUS_ST_POPU,'0'),nvl(h1.CENSUS_PLAIN_POPU,'0')+ nvl(h1.CENSUS_SC_POPU,'0')+nvl (h1.CENSUS_ST_POPU,'0'),nvl(h1.coverage_status,'-') from rws_habitation_directory_tbl h1 where h1.hab_code="+rsp.getString(1)+"";
	String qq="select panch_name from RWS_PANCHAYAT_RAJ_TBL where panch_code="+rsp.getString(1)+"";
	//System.out.println("The Query Q is ::"+q);
//	System.out.println("The Query QQ is ::"+qq);
    ResultSet rss9 = stmt8.executeQuery(q);	
    ResultSet rss99 = stmt88.executeQuery(qq);
    while(rss9.next())
    {
    rss99.next();
    sno++;
    %>
    	<tr>
			<td class=rptValue><%=sno%></td>
			<td class=rptValue><%=rsp.getString(1)%></td>
			<td class=rptValue><%=rss99.getString(1)%></td>
			<td class=rptValue><%=rss9.getString(1)%></td>
			<td class=rptValue><%=rss9.getString(2)%></td>
			<td class=rptValue><%=rss9.getString(3)%></td>
			<td class=rptValue><%=rss9.getString(4)%></td>
			<td class=rptValue><%=rss9.getString(5)%></td>
		</tr>
    <%
    }
}
}
}//try
catch(Exception e)
{
	e.printStackTrace();
}
finally
{

	if(conn!=null)
	conn.close();
}
%>

</form>
</body>
</html>
