<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%
	//System.out.println("*****REPORT BEGINING*****");
	String dcode=null;
	dcode=  String.valueOf(session.getAttribute("dCode"));
	//System.out.println(dcode);
     String range=request.getParameter("range");
	//System.out.println( range);
	String query=null;
	int slno = 0;
	int Count = 0;
try
{

%>
<html>
<head>
<script>
	window.history.forward(1);
</script>
</head>
<body bgcolor="#edf2f8">

<form name=f1 action="./rss1.jsp">

<table border = 1 cellspacing = 0 cellpadding = 0 height=5%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="./rws_graph_frm2.jsp">Back |</a></td>
				<td class="bwborder"><a href="../home.jsp">Home |</a></td>
				<!--<td class="bwborder"><a href="./rws_excel2_prnt.jsp" target="_new">Print |</a></td>-->
			    <td class="bwborder"><a href="./rws_xls2.jsp?dcode=<%=dcode%>&range=<%=range%>" target="_new">Excel</a></td>
			</tr>
		</table>
	</caption>


<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan="14">Proposed-Year/Cost-FC</td>	
	</tr>
<tr align=center>
		<td class=btext>Slno</td>
		<td class=btext>Habitation</td>
		<td class=btext>Present<br>Status</td>
		<td class=btext>Proposed<br>FC<br>Year</td>
		<td class=btext>Proposed<br>FC<br>Amt(Rs.In lakhs)</td>
		<td class=btext>Update Date</td>
		<td class=btext>Status Date</td>
	 </tr>
<%	
	//if(rDistrict != null && rDistrict.equals("00"))
    if(dcode.equals("51")&& range.equals("0 - 1"))
				 {
                query="SELECT DISTINCT PR.PANCH_NAME,PR.PANCH_CODE,nvl(COVERAGE_STATUS,'-'),nvl(PROPOSED_FC_YEAR,'-'),NVL(PROPOSED_FC_EST_AMT,'0'),NVL(TO_CHAR(UPDATE_DATE,'DD-MON-YY'),'-'),NVL(TO_CHAR(STATUS_DATE,'DD-MON-YY'),'-') FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE  AND COVERAGE_STATUS!='FC' and proposed_fc_est_amt is not null and proposed_fc_est_amt >=0 and proposed_fc_est_amt <=1 AND  substr(proposed_fc_year,3,4)>= substr(sysdate,8,9) and PR.PANCH_CODE = HD.HAB_CODE";
				 }

				 else if(dcode.equals("51")&& range.equals("1 - 10"))
				 {
                query="SELECT DISTINCT PR.PANCH_NAME,PR.PANCH_CODE,nvl(COVERAGE_STATUS,'-'),nvl(PROPOSED_FC_YEAR,'-'),NVL(PROPOSED_FC_EST_AMT,'0'),NVL(TO_CHAR(UPDATE_DATE,'DD-MON-YY'),'-'),NVL(TO_CHAR(STATUS_DATE,'DD-MON-YY'),'-') FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE  AND COVERAGE_STATUS!='FC' and proposed_fc_est_amt is not null and proposed_fc_est_amt > 1 and proposed_fc_est_amt <=10 AND  substr(proposed_fc_year,3,4)>= substr(sysdate,8,9) and PR.PANCH_CODE = HD.HAB_CODE";
				 }
				else if(dcode.equals("51")&& range.equals("10 - 20"))
				 {
                query="SELECT DISTINCT PR.PANCH_NAME,PR.PANCH_CODE,nvl(COVERAGE_STATUS,'-'),nvl(PROPOSED_FC_YEAR,'-'),NVL(PROPOSED_FC_EST_AMT,'0'),NVL(TO_CHAR(UPDATE_DATE,'DD-MON-YY'),'-'),NVL(TO_CHAR(STATUS_DATE,'DD-MON-YY'),'-') FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE  AND COVERAGE_STATUS!='FC' and proposed_fc_est_amt is not null and proposed_fc_est_amt > 10 and proposed_fc_est_amt <=20 AND  substr(proposed_fc_year,3,4)>= substr(sysdate,8,9) and PR.PANCH_CODE = HD.HAB_CODE";
				 }
   else if(dcode != null && !dcode.equals("51") && range.equals("0 - 1"))
	{
		//System.out.println("IN DISTRICT GRAND TOTAL SELECTION...");
		query="SELECT DISTINCT PR.PANCH_NAME,PR.PANCH_CODE,nvl(COVERAGE_STATUS,'-'),nvl(PROPOSED_FC_YEAR,'-'),NVL(PROPOSED_FC_EST_AMT,'0'),NVL(TO_CHAR(UPDATE_DATE,'DD-MON-YY'),'-'),NVL(TO_CHAR(STATUS_DATE,'DD-MON-YY'),'-') FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE  AND COVERAGE_STATUS!='FC' and proposed_fc_est_amt is not null and proposed_fc_est_amt >=0 and proposed_fc_est_amt <= 1 AND   substr(proposed_fc_year,3,4)>= substr(sysdate,8,9) and PR.PANCH_CODE = HD.HAB_CODE and SUBSTR(HD.HAB_CODE,1,2)='"+dcode+"'";
     }
	   else if(dcode != null && !dcode.equals("51") && range.equals("1 - 10"))
	{
		//System.out.println("IN DISTRICT GRAND TOTAL SELECTION...");
		query="SELECT DISTINCT PR.PANCH_NAME,PR.PANCH_CODE,nvl(COVERAGE_STATUS,'-'),nvl(PROPOSED_FC_YEAR,'-'),NVL(PROPOSED_FC_EST_AMT,'0'),NVL(TO_CHAR(UPDATE_DATE,'DD-MON-YY'),'-'),NVL(TO_CHAR(STATUS_DATE,'DD-MON-YY'),'-') FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE  AND COVERAGE_STATUS!='FC' and proposed_fc_est_amt is not null and proposed_fc_est_amt > 1 and proposed_fc_est_amt <= 10 AND   substr(proposed_fc_year,3,4)>= substr(sysdate,8,9) and PR.PANCH_CODE = HD.HAB_CODE and SUBSTR(HD.HAB_CODE,1,2)='"+dcode+"'";
     }
	else 
	{
		//System.out.println("IN DISTRICT GRAND TOTAL SELECTION...");
		query="SELECT DISTINCT PR.PANCH_NAME,PR.PANCH_CODE,nvl(COVERAGE_STATUS,'-'),nvl(PROPOSED_FC_YEAR,'-'),NVL(PROPOSED_FC_EST_AMT,'0'),NVL(TO_CHAR(UPDATE_DATE,'DD-MON-YY'),'-'),NVL(TO_CHAR(STATUS_DATE,'DD-MON-YY'),'-') FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE  AND COVERAGE_STATUS!='FC' and proposed_fc_est_amt is not null and proposed_fc_est_amt >= 10 and proposed_fc_est_amt <=20 AND  substr(proposed_fc_year,3,4)>= substr(sysdate,8,9) and PR.PANCH_CODE = HD.HAB_CODE and SUBSTR(HD.HAB_CODE,1,2)='"+dcode+"'";
     }

	/*if(dcode == null && dName==null && !rDistrict.equals("00") && updateDate==null)
	{
		//System.out.println("IN DISTRICT SELECTION...");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		
        query="SELECT distinct d.dcode,D.DNAME,PR.PANCH_NAME,PR.PANCH_CODE,nvl(HD.COVERAGE_STATUS,'--'),TO_CHAR(update_date,'DD-MON-YYYY'),TO_DATE(update_date,'DD-MON-YYYY') from RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR where update_date is not null and SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' order by d.dcode,TO_DATE(update_date,'DD-MON-YYYY')";
		
		
	}*/
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	rs = stmt.executeQuery(query);
	rs.last();
    Count = rs.getRow();
	//System.out.println("Count is"+Count);
	rs.beforeFirst();
	/*if(request.getParameter("pass") !=  null) {
	pass = Integer.parseInt(request.getParameter("pass"));*/
     //}
	if(Count!=0)
	 {
	while(rs.next())
		 {
	 %>
	 <tr bgcolor="#ffffff">
		<td class=rptValue><%=++slno%></td>			
	    <td class=rptValue><%=rs.getString(2)+'-'%><%=rs.getString(1)%></td>
		<td class=rptValue><%=rs.getString(3)%></td>
		<% if(rs.getString(4).equals("null"))
			 {%>

		<td class=rptValue><%="--"%></td>
		<%}
		 else{%>
		 <td class=rptValue><%=rs.getString(4)%></td>
		 <%}%>
		<td class=rptValue><%=rs.getString(5)%></td>
		<td class=rptValue><%=rs.getString(6)%></td>
		<td class=rptValue><%=rs.getString(7)%></td>
		</tr>
	  <% 
	}
	 }
	else
	{%>
	  <td align="center" class="rptHeading" colspan=12>There are no Records</td>
	  <%
	}
   /* rs.close(); rs1.close(); rs2.close(); rs3.close(); rs4.close(); rs5.close(); rs6.close(); rs7.close(); rs8.close(); rs9.close(); rs10.close(); rs11.close();
	stmt.close(); stmt1.close(); stmt2.close(); stmt3.close(); stmt4.close(); stmt5.close(); stmt6.close(); stmt7.close(); stmt8.close(); stmt9.close(); stmt10.close(); stmt11.close();*/
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
<%@ include file = "footer.jsp" %>
</form>
</body>
</html>
