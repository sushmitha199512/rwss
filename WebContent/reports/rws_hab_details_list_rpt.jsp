<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>

<%
try 
{
	////Debug.println("*****REPORT BEGINING*****");
	String rDistrict, rMandal, rPanchayat, rStatus, query, query1 = null,date=null;
	rDistrict = request.getParameter("district");
	rMandal = request.getParameter("mandal");
	rPanchayat = request.getParameter("panchayat");
	rStatus = request.getParameter("cstatus");
    date = request.getParameter("date");
	////Debug.println("rDistrict = " +rDistrict);		
	////Debug.println("rMandal = " +rMandal);		
	////Debug.println("rPanchayat = " +rPanchayat);
	////Debug.println("rStatus = " +rStatus);
	Statement stmt1=null;
	ResultSet rs1=null;
	int slno=0;
%>

<html>
<head>
</head>
<body bgcolor="#edf2f8">
<form name=f1 method="post" action="<%= request.getRequestURI()%>">
<table border = 1 cellspacing = 0 cellpadding = 0 height=20% width="75%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
			<tr align="right">
				<td class="bwborder"><a href="javascript:window.history.back()">Back |</a></td>
				<td class="bwborder"><a href="../home.jsp">Home</a></td>
				<!-- <td class="bwborder"><a href="../home.jsp">Print |</a></td>
				<td class="bwborder"><a href="../home.jsp">Excel</a></td>	 -->		
			</tr>
		</table>
	</caption>
	<tr bgcolor="#8A9FCD" align="center">
		<td align="center" class="rptHeading" colspan=5>Habitation Details for <%=rStatus%> Status</font></td>	
	</tr>			
<% 
	if(!rDistrict.equals("51")) 
	{
%>
	<tr bgcolor="#edf2f8" align="center">
		<td class=rptValue colspan=3><font color="navy">District: <%=session.getAttribute("dName")%></td>
	</tr>
<% 
	} 
%>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Sl.No</td>				
		<td class=btext>Habitation Code</td>		
		<td class=btext>Habitation Name</td>		
	</tr>
<%
if(rDistrict.equals("51"))
{
	//Debug.println("IN DISTRICT ALL SELECTION...");
	query1="SELECT DISTINCT HD.HAB_CODE, PR.PANCH_NAME FROM RWS_HABITATION_DIRECTORY_TBL HD, rws_complete_hab_view PR WHERE HD.COVERAGE_STATUS = '"+rStatus+"' AND STATUS_DATE='"+date+"' AND HD.HAB_CODE = PR.PANCH_CODE  ORDER BY HD.HAB_CODE";

/*query1="SELECT HD.HAB_CODE, HD.HAB_NAME  FROM RWS_HABITATION_DIRECTORY_TBL HD WHERE HD.COVERAGE_STATUS = '"+rStatus+"'  ORDER BY HD.HAB_CODE";*/
}
if(!rDistrict.equals("51") && !rDistrict.equals("0") && rMandal.equals("0"))
{
	////Debug.println("IN DISTRICT SELECTION...");
	query1="SELECT HD.HAB_CODE, PR.PANCH_NAME, SUBSTR(HD.HAB_CODE,1,2),DNAME FROM RWS_HABITATION_DIRECTORY_TBL HD, rws_complete_hab_view PR, RWS_DISTRICT_TBL D WHERE HD.COVERAGE_STATUS = '"+rStatus+"' AND STATUS_DATE='"+date+"' and HD.HAB_CODE = PR.PANCH_CODE AND D.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' ORDER BY HD.HAB_CODE";
}
if(!rDistrict.equals("51") && !rDistrict.equals("0") && rMandal.equals("5200") && rPanchayat.equals("0"))
{
	////Debug.println("IN MANDAL ALL SELECTION...");
	query1="SELECT HD.HAB_CODE, PR.PANCH_NAME, SUBSTR(HD.HAB_CODE,1,2), DNAME FROM RWS_HABITATION_DIRECTORY_TBL HD, rws_complete_hab_view PR, RWS_DISTRICT_TBL D WHERE HD.COVERAGE_STATUS = '"+rStatus+"' AND STATUS_DATE='"+date+"' and HD.HAB_CODE = PR.PANCH_CODE AND D.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' ORDER BY HD.HAB_CODE";
}
if(!rDistrict.equals("51") && !rDistrict.equals("0") && !rMandal.equals("5200") && !rMandal.equals("0") && rPanchayat.equals("0"))
{
	////Debug.println("IN MANDAL SELECTION...");
	query1="SELECT HD.HAB_CODE, PR.PANCH_NAME, SUBSTR(HD.HAB_CODE,1,2), DNAME FROM RWS_HABITATION_DIRECTORY_TBL HD, rws_complete_hab_view PR, RWS_DISTRICT_TBL D WHERE HD.COVERAGE_STATUS = '"+rStatus+"' AND STATUS_DATE='"+date+"' and HD.HAB_CODE = PR.PANCH_CODE AND D.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' AND SUBSTR(HD.HAB_CODE,6,2)='"+rMandal+"' ORDER BY HD.HAB_CODE";
}
if(!rDistrict.equals("51") && !rDistrict.equals("0") && !rMandal.equals("5200") && !rMandal.equals("0") && rPanchayat.equals("5300"))
{
	////Debug.println("IN PANCHAYAT ALL SELECTION...");
	query1="SELECT HD.HAB_CODE, PR.PANCH_NAME, SUBSTR(HD.HAB_CODE,1,2), DNAME FROM RWS_HABITATION_DIRECTORY_TBL HD, rws_complete_hab_view PR, RWS_DISTRICT_TBL D WHERE HD.COVERAGE_STATUS = '"+rStatus+"' AND STATUS_DATE='"+date+"' AND HD.HAB_CODE = PR.PANCH_CODE AND D.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' AND SUBSTR(HD.HAB_CODE,6,2)= '"+rMandal+"' ORDER BY HD.HAB_CODE";
}
if(!rDistrict.equals("51") && !rDistrict.equals("0") && !rMandal.equals("5200") && !rMandal.equals("0") && !rPanchayat.equals("5300") && !rPanchayat.equals("0"))
{
	////Debug.println("IN PANCHAYAT SELECTION...");
	query1="SELECT HD.HAB_CODE, PR.PANCH_NAME, SUBSTR(HD.HAB_CODE,1,2), DNAME FROM RWS_HABITATION_DIRECTORY_TBL HD, rws_complete_hab_view PR, RWS_DISTRICT_TBL D WHERE HD.COVERAGE_STATUS = '"+rStatus+"' AND STATUS_DATE='"+date+"' AND HD.HAB_CODE = PR.PANCH_CODE AND D.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' AND SUBSTR(HD.HAB_CODE,6,2)= '"+rMandal+"' AND SUBSTR(HD.HAB_CODE,13,2) = '"+rPanchayat+"' ORDER BY HD.HAB_CODE";
}
/*
if(!rDistrict.equals("51") && !rDistrict.equals("0") && rMandal.equals("52"))
{
	////Debug.println("IN DIVISION ALL SELECTION...");
	query1="SELECT P.PROPOSAL_ID, P.PROPOSAL_NAME, P.LEAD_HAB_CODE, PR.PANCH_NAME FROM RWS_REP_PROPOSAL_TBL P, rws_complete_hab_view PR WHERE P.LEAD_HAB_CODE = PR.PANCH_CODE AND SUBSTR(OFFICE_CODE,2,2)='"+rDistrict+"' ORDER BY PROPOSAL_ID ";
}
if(!rDistrict.equals("51") && !rDistrict.equals("0") && !rMandal.equals("52") && !rMandal.equals("0") && rPanchayat.equals("0"))
{
	////Debug.println("IN DIVISION SELECTION...");
	query1="SELECT P.PROPOSAL_ID, P.PROPOSAL_NAME, P.LEAD_HAB_CODE, PR.PANCH_NAME FROM RWS_REP_PROPOSAL_TBL P, rws_complete_hab_view PR WHERE P.LEAD_HAB_CODE = PR.PANCH_CODE AND SUBSTR(OFFICE_CODE,2,2)='"+rDistrict+"' AND SUBSTR(OFFICE_CODE,4,1) = '"+rMandal+"' ORDER BY PROPOSAL_ID ";
}
if(!rDistrict.equals("51") && !rDistrict.equals("0") && !rMandal.equals("52") && !rMandal.equals("0") && rPanchayat.equals("53"))
{
	////Debug.println("IN SUB DIVISION ALL SELECTION...");
	query1="SELECT P.PROPOSAL_ID, P.PROPOSAL_NAME, P.LEAD_HAB_CODE, PR.PANCH_NAME FROM RWS_REP_PROPOSAL_TBL P, rws_complete_hab_view PR WHERE P.LEAD_HAB_CODE = PR.PANCH_CODE AND SUBSTR(OFFICE_CODE,2,2)='"+rDistrict+"' AND SUBSTR(OFFICE_CODE,4,1) = '"+rMandal+"' ORDER BY PROPOSAL_ID ";
}
*/
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);	
	rs = stmt.executeQuery(query1);	
	while(rs.next())
	{	
		slno++;				
%>

	
	<tr bgcolor="#ffffff">
		<td class=rptValue><%=slno%></td>			
		<td class=rptValue><a href="./rws_hab_details_rpt.jsp?habId=<%=rs.getString(1)%>&habName=<%=rs.getString(2)%>">
		<%=rs.getString(1)%></a></td>
		<td class=rptValue><%=rs.getString(2)%></td>		
	</tr>	

<%				
	}
		if(slno==0)
		{
%>
	<tr bgcolor="#FFFFFF" align="center">
		<td class="rptSubValue" colspan="3">NO RECORDS FOR YOUR QUERY...</td>	
	</tr>
<%
		}

}
catch(Exception e)
{
	//Debug.println("error is  "+e);
}
%>
</table>
</body>
</html>
<%@ include file = "footer.jsp" %>			