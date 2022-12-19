<%@ include file = "conn.jsp" %>
<%@ include file = "header_rpt.jsp" %>
<%	
	String cCode = request.getParameter("cCode");	
	String cName = request.getParameter("cName");	
	String dCode = request.getParameter("dCode");	
	String dName = request.getParameter("dName");	
	String fromDate = request.getParameter("fromDate");	
	String toDate = request.getParameter("toDate");	
	String testId = request.getParameter("testId");	
	String habitationName = request.getParameter("habitationName");		
%>

<html>
<head>
<title>WaterSoft</title>
<link rel="stylesheet" type="text/css" href="rwsstyle.css">

<style>
.mystyle
{
	border-width:1;
	color:brown;
	font-weight:bold;
	font-family:verdana;
	font-size:9pt;
}
.mystyle1
{
	border-width:1;
	color:black;
	font-family:verdana;
	font-size:9pt;
}

</style>
</head>
<body bgcolor="#edf2f8">
<%
	if(cCode.equals("00"))
	{
		//System.out.println("FIRST INNER IF...");

%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">
			
			<tr align="right">
				<td class="bwborder"><a href="javascript:window.history.back()">Back&nbsp;|&nbsp;</a>&nbsp;<a href="../home.jsp">Home</a></td>
			</tr>
		</table>
	</caption>
	
	<tr bgcolor="lavander">
		<td class="mystyle" align="center" colspan="8"><font color="navy">All Circles Water Quality Report</font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class="btext" align="center" colspan="8"><font color="navy">From :<%=fromDate%> && To :<%=toDate%> For The Test ID <%=testId%> , Habitation <%=habitationName%></font></td>
	</tr>
	
	<tr bgcolor="#ffffff">
		<td class="btext" colspan="8"><font color="navy">Collection Details:</font></td>
	</tr>

	<tr align=center bgcolor="#ffffff">
		<td class=btext>Sl.No</td>				
		<td class=btext>Source</td>
		<td class=btext>Test / Nature Of The Test</td>
		<td class=btext>Lab</td>
		<td class=btext>Sample Collector / Date</td>
		<td class=btext>Assigned On</td>
		<td class=btext colspan=2>Prepared By / Prepared On</td>
		
		
	</tr>
<%
	RwsOffices rwsOffices = new RwsOffices(dataSource);

	//System.out.println("FIRST INNER IF QUERY...");
	stmt = conn.createStatement();
	query = "SELECT SAM.HAB_CODE, PR.PANCH_NAME, SAM.SOURCE_CODE, SR.SOURCE_NAME, SAM.TEST_CODE, TES.TEST_NAME, DECODE(SAM.NATURE_OF_TEST, '1', 'ROUTINE', '2', 'SEASONAL', '3', 'QUARTERLY', '4', 'DISEASE OUTBREAK'), 1 || SAM.CIRCLE_OFFICE_CODE || SAM.DIVISION_OFFICE_CODE || SAM.SUBDIVISION_OFFICE_CODE, SAM.LAB_CODE, LAB.LAB_NAME, SAM.SAMP_COLLECTOR_CODE, DES.DESIGNATION_NAME, TO_CHAR(SAM.SAMP_COLLECT_DATE, 'DD/MM/YYYY'), TO_CHAR(SAM.ASSIGNED_ON, 'DD/MM/YYYY'), SAM.PREPARED_BY, TO_CHAR(SAM.PREPARED_ON, 'DD/MM/YYYY') FROM RWS_WATER_SAMPLE_COLLECT_TBL SAM, RWS_PANCHAYAT_RAJ_TBL PR, RWS_SOURCE_TBL SR, RWS_WATER_QUALITY_TEST_TBL TES, RWS_WATER_QUALITY_LAB_TBL LAB, RWS_DESIGNATION_TBL DES WHERE TEST_ID = '"+testId+"' AND SAM.HAB_CODE = PR.PANCH_CODE AND SAM.SOURCE_CODE = SR.SOURCE_CODE AND SAM.TEST_CODE = TES.TEST_CODE AND SAM.LAB_CODE = LAB.LAB_CODE AND SAM.SAMP_COLLECTOR_CODE = DES.DESIGNATION_CODE AND SAM.SAMP_COLLECT_DATE >= TO_DATE('"+fromDate+"', 'DD/MM/YYYY') AND SAM.SAMP_COLLECT_DATE <= TO_DATE('"+toDate+"', 'DD/MM/YYYY')";
	
		rs = stmt.executeQuery(query);
		int slno = 0;
		while(rs.next())
		{
		slno++;		
%>
		<tr align=center bgcolor="#ffffff">
			<td class=mystyle1><%=slno%></td>			
			<td class=mystyle1><%=rs.getString(4)%></td>
			<td class=mystyle1><%=rs.getString(6)%><br><%=rs.getString(7)%></td>
			<td class=mystyle1><%=rwsOffices.getOfficeName(rs.getString(8),true)%></td>
			<td class=mystyle1><%=rs.getString(12)%><br><%=rs.getString(13)%></td>
			<td class=mystyle1><%=rs.getString(14)%></td>
			<td class=mystyle1 colspan=2><%=rs.getString(15)%><br><%=rs.getString(16)%></td>			
		</tr>
<%
		}
		if(slno == 0)
		{
%>
		<tr>
			<td class="mystyle1" colspan=7 align=center>NO RECORDS FOR YOUR QUERY...</td>
		</tr>	
<%
		}
%>
	<tr bgcolor="#ffffff">
		<td class="btext" colspan="8"><font color="navy">Assignment Details:</font></td>
	</tr>

	<tr align=center bgcolor="#ffffff" colspan="8">
		<td class=btext>Sl.No</td>
		<td class=btext>Office</td>
		<td class=btext>Lab / Assigned By</td>
		<td class=btext>Assigned From Date / Assigned To Date</td>		
		<td class=btext>Assigned To</td>
		<td class=btext>Result Obtained Date</td>
		<td class=btext>Forwarded Date</td>
		<td class=btext>Prepared By / On</td>		
	</tr>
<%
	//System.out.println("HERE");
	stmt = conn.createStatement();
	query = "SELECT GEO.OFFICE_CODE, GEO.LAB_CODE, GEO.ASSIGNED_BY, TO_CHAR(GEO.ASSIGNED_FROM_DATE, 'DD/MM/YYYY'), TO_CHAR(GEO.ASSIGNED_TO_DATE, 'DD/MM/YYYY'), GEO.ASSIGNED_TO, GEO.RESULT_OBTAIN_DATE, GEO.FORWARDED_DATE, GEO.OFFICE_FORWARD, GEO.PREPARED_BY, GEO.PREPARED_ON, SAM.CIRCLE_OFFICE_CODE, SAM.DIVISION_OFFICE_CODE, SAM.SUBDIVISION_OFFICE_CODE, SAM.HAB_CODE, SAM.SOURCE_CODE, SAM.TEST_CODE, SAM.NATURE_OF_TEST, SAM.LAB_CODE, SAM.SAMP_COLLECTOR_CODE, TO_CHAR(SAM.SAMP_COLLECT_DATE, 'DD/MM/YYYY'), SAM.SAMP_COLLECT_TIME, TO_CHAR(SAM.ASSIGNED_ON, 'DD/MM/YYYY'), SAM.PREPARED_BY, SAM.PREPARED_ON FROM RWS_WQ_GEOLOGIST_TEST_TBL GEO, RWS_WATER_SAMPLE_COLLECT_TBL SAM WHERE SAM.TEST_ID = '"+testId+"' AND SAM.SAMP_COLLECT_DATE >= TO_DATE('"+fromDate+"', 'DD/MM/YYYY') AND SAM.SAMP_COLLECT_DATE <= TO_DATE('"+toDate+"', 'DD/MM/YYYY') AND SAM.TEST_ID = GEO.TEST_ID";
	
		rs = stmt.executeQuery(query);
		slno = 0;
		while(rs.next())
		{
		slno++;		
%>
		<tr align=center bgcolor="#ffffff">
			<td class=mystyle1><%=slno%></td>			
			<td class=mystyle1><%=rwsOffices.getOfficeName(rs.getString(1),true)%></td>
			<td class=mystyle1><%=rwsOffices.getOfficeName(rs.getString(1),true)%><br><%=rs.getString(3)%></td>
			
			<td class=mystyle1><%=rs.getString(4)%><br><%=rs.getString(5)%></td>

			<td class=mystyle1><%=rs.getString(6)%></td>
			<td class=mystyle1><%=rs.getString(7)%><br><%=rs.getString(8)%></td>				
		</tr>
<%
		}
		if(slno == 0)
		{
%>
		<tr>
			<td class="mystyle1" colspan=8 align=center>NO RECORDS FOR YOUR QUERY...</td>
		</tr>
<%
		}
	}
	else
		if(!cCode.equals("00") && !dCode.equals("00"))
		{
			//System.out.println("FIRST ELSE PART...");
%>
<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">
			
			<tr align="right">
				<td class="bwborder"><a href="javascript:window.history.back()">Back&nbsp;|&nbsp;</a>&nbsp;<a href="../home.jsp">Home</a></td>
			</tr>
		</table>
	</caption>
	
	<tr bgcolor="lavander">
		<td class="mystyle" align="center" colspan="16"><font color="navy">Water Quality Report Of Circle <%=cName%></font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class="btext" align="center" colspan="16"><font color="navy">From :<%=fromDate%> && To :<%=toDate%> For The Test ID <%=testId%> , Habitation <%=habitationName%></font></td>
	</tr>

	<tr align=center bgcolor="#ffffff">
		<td class=btext>Sl.No</td>				
		<td class=btext>Source</td>
		<td class=btext>Test / Nature Of The Test</td>
		<td class=btext>Lab</td>
		<td class=btext>Sample Collector / Date</td>
		<td class=btext>Assigned On</td>
		<td class=btext>Prepared By / Prepared On</td>		
	</tr>
<%
	RwsOffices rwsOffices = new RwsOffices(dataSource);

	//System.out.println("FIRST ELSE QUERY...");
	stmt = conn.createStatement();
	query = "SELECT SAM.HAB_CODE, PR.PANCH_NAME, SAM.SOURCE_CODE, SR.SOURCE_NAME, SAM.TEST_CODE, TES.TEST_NAME, DECODE(SAM.NATURE_OF_TEST, '1', 'ROUTINE', '2', 'SEASONAL', '3', 'QUARTERLY', '4', 'DISEASE OUTBREAK'), 1 || SAM.CIRCLE_OFFICE_CODE || SAM.DIVISION_OFFICE_CODE || SAM.SUBDIVISION_OFFICE_CODE, SAM.LAB_CODE, LAB.LAB_NAME, SAM.SAMP_COLLECTOR_CODE, DES.DESIGNATION_NAME, TO_CHAR(SAM.SAMP_COLLECT_DATE, 'DD/MM/YYYY'), TO_CHAR(SAM.ASSIGNED_ON, 'DD/MM/YYYY'), SAM.PREPARED_BY, TO_CHAR(SAM.PREPARED_ON, 'DD/MM/YYYY') FROM RWS_WATER_SAMPLE_COLLECT_TBL SAM, RWS_PANCHAYAT_RAJ_TBL PR, RWS_SOURCE_TBL SR, RWS_WATER_QUALITY_TEST_TBL TES, RWS_WATER_QUALITY_LAB_TBL LAB, RWS_DESIGNATION_TBL DES WHERE TEST_ID = '"+testId+"' AND SAM.CIRCLE_OFFICE_CODE = '"+cCode+"' AND SAM.HAB_CODE = PR.PANCH_CODE AND SAM.SOURCE_CODE = SR.SOURCE_CODE AND SAM.TEST_CODE = TES.TEST_CODE AND SAM.LAB_CODE = LAB.LAB_CODE AND SAM.SAMP_COLLECTOR_CODE = DES.DESIGNATION_CODE AND SAM.SAMP_COLLECT_DATE >= TO_DATE('"+fromDate+"', 'DD/MM/YYYY') AND SAM.SAMP_COLLECT_DATE <= TO_DATE('"+toDate+"', 'DD/MM/YYYY')";
	
			rs = stmt.executeQuery(query);
			int slno = 0;
			while(rs.next())
			{
				slno++;		
%>
			<tr align=center bgcolor="#ffffff">
				<td class=mystyle1><%=slno%></td>				
				<td class=mystyle1><%=rs.getString(4)%></td>
				<td class=mystyle1><%=rs.getString(6)%><br><%=rs.getString(7)%></td>
				<td class="mystyle1"><%=rwsOffices.getOfficeName(rs.getString(8),true)%></td>
				<td class=mystyle1><%=rs.getString(12)%><br><%=rs.getString(13)%></td>

				<td class=mystyle1><%=rs.getString(14)%></td>
				<td class=mystyle1><%=rs.getString(15)%><br><%=rs.getString(16)%></td>				
			</tr>
<%
			}
			if(slno == 0)
			{
%>
			<tr>
				<td class="mystyle1" colspan=10>NO RECORDS FOR YOUR QUERY...</td>
			</tr>
<%
			}
		}
		else
			if(!cCode.equals("00") && dCode.equals("00"))
			{
				//System.out.println("ELSE IN ALL DIVISIONS...");
%>

		<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
			<caption>
				<table  border=0 rules=none style="border-collapse:collapse" align = "right">			
					<tr align="right">
						<td class="bwborder"><a href="javascript:window.history.back()">Back&nbsp;|&nbsp;</a>&nbsp;<a href="../home.jsp">Home</a></td>
					</tr>
				</table>
			</caption>
	
		<tr bgcolor="lavander">
			<td class="mystyle" align="center" colspan="16"><font color="navy">Water Quality Report For All Divisions Of Test ID :<%=testId%></font></td>
		</tr>
		<tr bgcolor="lavander">
			<td class="mystyle" align="center" colspan="16"><font color="navy">Circle :<%=cName%></font></td>
		</tr>
		<tr bgcolor="#ffffff">
			<td class="btext" align="center" colspan="16"><font color="navy">From <%=fromDate%> To :<%=toDate%></font></td>
		</tr>

		<tr align=center bgcolor="#ffffff">
			<td class=btext>Sl.No</td>		
			<td class=btext>Habitaion</td>
			<td class=btext>Source</td>
			<td class=btext>Test / Nature Of The Test</td>
			<td class=btext>Lab</td>
			<td class=btext>Sample Collector / Date</td>
			<td class=btext>Assigned On</td>
			<td class=btext>Prepared By / Prepared On</td>		
		</tr>
<%
	RwsOffices rwsOffices = new RwsOffices(dataSource);

		//System.out.println("ALL DIVISIONS QUERY PART...");
		stmt = conn.createStatement();
		query = "SELECT SAM.HAB_CODE, PR.PANCH_NAME, SAM.SOURCE_CODE, SR.SOURCE_NAME, SAM.TEST_CODE, TES.TEST_NAME, DECODE(SAM.NATURE_OF_TEST, '1', 'ROUTINE', '2', 'SEASONAL', '3', 'QUARTERLY', '4', 'DISEASE OUTBREAK'), 1 || SAM.CIRCLE_OFFICE_CODE || SAM.DIVISION_OFFICE_CODE || SAM.SUBDIVISION_OFFICE_CODE, SAM.LAB_CODE, LAB.LAB_NAME, SAM.SAMP_COLLECTOR_CODE, DES.DESIGNATION_NAME, TO_CHAR(SAM.SAMP_COLLECT_DATE, 'DD/MM/YYYY'), TO_CHAR(SAM.ASSIGNED_ON, 'DD/MM/YYYY'), SAM.PREPARED_BY, TO_CHAR(SAM.PREPARED_ON, 'DD/MM/YYYY') FROM RWS_WATER_SAMPLE_COLLECT_TBL SAM, RWS_PANCHAYAT_RAJ_TBL PR, RWS_SOURCE_TBL SR, RWS_WATER_QUALITY_TEST_TBL TES, RWS_WATER_QUALITY_LAB_TBL LAB, RWS_DESIGNATION_TBL DES WHERE TEST_ID = '"+testId+"' AND SAM.CIRCLE_OFFICE_CODE = '"+cCode+"' AND SAM.HAB_CODE = PR.PANCH_CODE AND SAM.SOURCE_CODE = SR.SOURCE_CODE AND SAM.TEST_CODE = TES.TEST_CODE AND SAM.LAB_CODE = LAB.LAB_CODE AND SAM.SAMP_COLLECTOR_CODE = DES.DESIGNATION_CODE AND SAM.SAMP_COLLECT_DATE >= TO_DATE('"+fromDate+"', 'DD/MM/YYYY') AND SAM.SAMP_COLLECT_DATE <= TO_DATE('"+toDate+"', 'DD/MM/YYYY')";
	
				rs = stmt.executeQuery(query);
				int slno = 0;
				while(rs.next())
				{
					slno++;		
%>
				<tr align=center bgcolor="#ffffff">
					<td class=mystyle1><%=slno%></td>
					<td class=mystyle1><%=rs.getString(2)%></td>
					<td class=mystyle1><%=rs.getString(4)%></td>
					<td class=mystyle1><%=rs.getString(6)%><br><%=rs.getString(7)%></td>
					<td class="mystyle1"><%=rwsOffices.getOfficeName(rs.getString(8),true)%></td>
					<td class=mystyle1><%=rs.getString(12)%><br><%=rs.getString(13)%></td>

					<td class=mystyle1><%=rs.getString(14)%></td>
					<td class=mystyle1><%=rs.getString(15)%><br><%=rs.getString(16)%></td>				
				</tr>
<%
				}
				if(slno == 0)
				{
%>
				<tr>
					<td class="mystyle1" colspan=10>NO RECORDS FOR YOUR QUERY...</td>
				</tr>
<%				}
			}
%>

</table>


</body>
</html>
<%@ include file = "footer.jsp" %>