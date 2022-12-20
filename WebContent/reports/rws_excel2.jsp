
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%@ page contentType="application/vnd.ms-excel"%>
<%
	//System.out.println("*****REPORT BEGINING*****");
	String dcode=null;
	dcode= request.getParameter("dcode");
	//System.out.println(dcode);
    String year=request.getParameter("year");
	//System.out.println( year);
	String query=null;
	int slno = 0;
	int Count = 0;
try
{

%>
<html>
<head>
</head>
<body>
<table border = 1 cellspacing = 0 cellpadding = 0  bordercolor=#000000 style="border-collapse:collapse"  align = "center">
	<tr  align="center">
		<td align="center" class="rptHeading" colspan="7">Proposed-Year/Cost-FC</td>	
	</tr>
<tr align=center>
		<td>Slno</td>
		<td >Habitation</td>
		<td>Present<br>Status</td>
		<td>Proposed<br>FC<br>Year</td>
		<td>Proposed<br>FC<br>Amt(Rs.In lakhs)</td>
		<td>Update Date</td>
		<td>Status Date</td>
	 </tr>
<%	
	//if(rDistrict != null && rDistrict.equals("00"))
     if(dcode != null && dcode.equals("51"))
	{
       //System.out.println("IN DISTRICT ALL SELECTION...");
		
		query="SELECT DISTINCT PR.PANCH_NAME,PR.PANCH_CODE,nvl(COVERAGE_STATUS,'-'),nvl(PROPOSED_FC_YEAR,'-'),NVL(PROPOSED_FC_EST_AMT,'0'),NVL(TO_CHAR(UPDATE_DATE,'DD-MON-YY'),'-'),NVL(TO_CHAR(STATUS_DATE,'DD-MON-YY'),'-') FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE and PROPOSED_FC_YEAR='"+year+"' AND COVERAGE_STATUS!='FC' GROUP BY PR.PANCH_NAME,PR.PANCH_CODE,COVERAGE_STATUS,PROPOSED_FC_YEAR,PROPOSED_FC_EST_AMT,TO_CHAR(UPDATE_DATE,'DD-MON-YY'),TO_CHAR(STATUS_DATE,'DD-MON-YY')";
	}
   else if(dcode != null && !dcode.equals("51"))
	{
		//System.out.println("IN DISTRICT GRAND TOTAL SELECTION...");
		query="SELECT DISTINCT PR.PANCH_NAME,PR.PANCH_CODE,nvl(COVERAGE_STATUS,'-'),nvl(PROPOSED_FC_YEAR,'-'),NVL(PROPOSED_FC_EST_AMT,'0'),NVL(TO_CHAR(UPDATE_DATE,'DD-MON-YY'),'-'),NVL(TO_CHAR(STATUS_DATE,'DD-MON-YY'),'-') FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE and PROPOSED_FC_YEAR='"+year+"' AND COVERAGE_STATUS!='FC' and SUBSTR(HD.HAB_CODE,1,2) ='"+dcode+"' GROUP BY PR.PANCH_NAME,PR.PANCH_CODE,COVERAGE_STATUS,PROPOSED_FC_YEAR,PROPOSED_FC_EST_AMT,TO_CHAR(UPDATE_DATE,'DD-MON-YY'),TO_CHAR(STATUS_DATE,'DD-MON-YY')";

		
	}
	/*else if(!rDistrict.equals("00"))
	{
		//System.out.println("IN DISTRICT SELECTION...");
		
        query="SELECT DISTINCT PR.PANCH_NAME,PR.PANCH_CODE,nvl(COVERAGE_STATUS,'-'),nvl(PROPOSED_FC_YEAR,'-'),NVL(PROPOSED_FC_EST_AMT,'0'),NVL(TO_CHAR(UPDATE_DATE,'DD-MON-YY'),'-'),NVL(TO_CHAR(STATUS_DATE,'DD-MON-YY'),'-') FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD,RWS_PANCHAYAT_RAJ_TBL PR WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND PR.PANCH_CODE = HD.HAB_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"'  AND COVERAGE_STATUS!='FC' group by PR.PANCH_NAME,PR.PANCH_CODE,COVERAGE_STATUS,PROPOSED_FC_YEAR,PROPOSED_FC_EST_AMT,TO_CHAR(UPDATE_DATE,'DD-MON-YY'),TO_CHAR(STATUS_DATE,'DD-MON-YY')" ;
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
	 <tr>
		<td class=rptValue><%=++slno%></td>			
	    <td class=rptValue><%=rs.getString(2)+'-'%><%=rs.getString(1)%></td>
		<td class=rptValue><%=rs.getString(3)%></td>
		<td class=rptValue><%=rs.getString(4)%></td>
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
	//System.out.println("THE ERROR IN REPORT = " + e);
}
%>

</table>

<%@ include file = "footer.jsp" %>
</form>
</body>
</html>
<%
	conn.close();
%>