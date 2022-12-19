<%@ include file = "conn.jsp" %>
<%@ include file = "header_rpt.jsp" %>


<%
		String cCode = String.valueOf(session.getAttribute("circleCode"));
		//System.out.println("cCode " +cCode);
		String cName = String.valueOf(session.getAttribute("circleName"));
		//System.out.println("cName " +cName);
		String dCode = String.valueOf(session.getAttribute("dCode"));
		//System.out.println("dCode " +dCode);
		String dName = String.valueOf(session.getAttribute("dName"));
		//System.out.println("dName " +dName);
		String sDCode = String.valueOf(session.getAttribute("sDCode"));
		//System.out.println("sDCode " +sDCode);
		String sDName = String.valueOf(session.getAttribute("sDName"));
		//System.out.println("sDName " +sDName);					
		String fromDate = request.getParameter("fromdate");		
		String toDate = request.getParameter("todate");		
		String ccode = request.getParameter("circleOffice");
		String dcode = request.getParameter("divisionOffice");
		String sdcode = request.getParameter("subDivisionOffice");
		
		RwsOffices rwsOffices = new RwsOffices(dataSource);
		
		stmt = conn.createStatement();		
			if(cCode.equals("00") && !fromDate.equals("00") && !toDate.equals("00"))
			{
				if(fromDate.equals(toDate))
				{
					//System.out.println("HERE");
			//System.out.println("FOR ALL CIRCLES...");
			query = " SELECT "
					
					+ " SAM.TEST_ID, "
					+ " 1 || SAM.CIRCLE_OFFICE_CODE || SAM.DIVISION_OFFICE_CODE || "
					+ " SAM.SUBDIVISION_OFFICE_CODE, "
					+ " SAM.HAB_CODE, PR.PANCH_NAME, "
					+ " SAM.SOURCE_CODE, SR.SOURCE_NAME, "
					+ " SAM.TEST_CODE, TES.TEST_NAME, "
					+ " DECODE(SAM.NATURE_OF_TEST, '1', 'ROUTINE', '2', 'SEASONAL', '3', "
					+ " 'QUARTERLY', '4', 'DISEASE OUTBREAK'), "
					+ " SAM.LAB_CODE, LAB.LAB_NAME, "
					+ " SAM.SAMP_COLLECTOR_CODE, DES.DESIGNATION_NAME, "
					+ " TO_CHAR(SAM.SAMP_COLLECT_DATE, 'dd/MM/yyyy'), "
					+ " TO_CHAR(SAM.ASSIGNED_ON, 'dd/MM/yyyy'), "
					+ " SAM.PREPARED_BY, TO_CHAR(SAM.PREPARED_ON, 'dd/MM/yyyy'), "
					+ " RES.RECOMMENDATIONS, DECODE(RES.CONDEMN_THE_SOURCE, 'Y', 'Yes', 'N', 'No'), "
					+ " DECODE(RES.UPDATE_SOURCE_DATA, 'Y', 'Yes', 'N', 'No'), "
					+ " TO_CHAR(RES.FORWARDED_ON, 'dd/MM/yyyy'), RES.PREPARED_BY, "
					+ " TO_CHAR(RES.PREPARED_ON, 'dd/MM/yyyy'), RES.LAB_CODE, LAB.LAB_NAME, "
					+ " RES.SOURCE_CODE, SR.SOURCE_NAME "
					
					+ " FROM "
					
					+ " RWS_WATER_SAMPLE_COLLECT_TBL SAM, RWS_PANCHAYAT_RAJ_TBL PR, RWS_SOURCE_TBL SR, "
					+ " RWS_WATER_QUALITY_TEST_TBL TES, RWS_WATER_QUALITY_LAB_TBL LAB, "
					+ " RWS_DESIGNATION_TBL DES, "
					+ " RWS_WQ_TEST_RESULTS_TBL RES "
					
					+ " WHERE "
					+ " SAM.TEST_ID = RES.TEST_ID AND "
					+ " SAM.HAB_CODE = PR.PANCH_CODE AND "
					+ " SAM.SOURCE_CODE = SR.SOURCE_CODE AND "
					+ " SAM.TEST_CODE = TES.TEST_CODE AND "
					+ " SAM.LAB_CODE = LAB.LAB_CODE AND "
					+ " SAM.SAMP_COLLECTOR_CODE = DES.DESIGNATION_CODE AND "
					+ " RES.LAB_CODE = LAB.LAB_CODE AND "
					+ " RES.SOURCE_CODE = SR.SOURCE_CODE " ;
				}
				else
				{
					//System.out.println("NOT HERE");
					query = " SELECT "
					
					+ " SAM.TEST_ID, "
					+ " 1 || SAM.CIRCLE_OFFICE_CODE || SAM.DIVISION_OFFICE_CODE || "
					+ " SAM.SUBDIVISION_OFFICE_CODE, "
					+ " SAM.HAB_CODE, PR.PANCH_NAME, "
					+ " SAM.SOURCE_CODE, SR.SOURCE_NAME, "
					+ " SAM.TEST_CODE, TES.TEST_NAME, "
					+ " DECODE(SAM.NATURE_OF_TEST, '1', 'ROUTINE', '2', 'SEASONAL', '3', "
					+ " 'QUARTERLY', '4', 'DISEASE OUTBREAK'), "
					+ " SAM.LAB_CODE, LAB.LAB_NAME, "
					+ " SAM.SAMP_COLLECTOR_CODE, DES.DESIGNATION_NAME, "
					+ " TO_CHAR(SAM.SAMP_COLLECT_DATE, 'dd/MM/yyyy'), "
					+ " TO_CHAR(SAM.ASSIGNED_ON, 'dd/MM/yyyy'), "
					+ " SAM.PREPARED_BY, TO_CHAR(SAM.PREPARED_ON, 'dd/MM/yyyy'), "
					+ " RES.RECOMMENDATIONS, DECODE(RES.CONDEMN_THE_SOURCE, 'Y', 'Yes', 'N', 'No'), "
					+ " DECODE(RES.UPDATE_SOURCE_DATA, 'Y', 'Yes', 'N', 'No'), "
					+ " TO_CHAR(RES.FORWARDED_ON, 'dd/MM/yyyy'), RES.PREPARED_BY, "
					+ " TO_CHAR(RES.PREPARED_ON, 'dd/MM/yyyy'), RES.LAB_CODE, LAB.LAB_NAME, "
					+ " RES.SOURCE_CODE, SR.SOURCE_NAME "
					
					+ " FROM "
					
					+ " RWS_WATER_SAMPLE_COLLECT_TBL SAM, RWS_PANCHAYAT_RAJ_TBL PR, RWS_SOURCE_TBL SR, "
					+ " RWS_WATER_QUALITY_TEST_TBL TES, RWS_WATER_QUALITY_LAB_TBL LAB, "
					+ " RWS_DESIGNATION_TBL DES, "
					+ " RWS_WQ_TEST_RESULTS_TBL RES "
					
					+ " WHERE "
					+ " SAM.TEST_ID = RES.TEST_ID AND "
					+ " SAM.HAB_CODE = PR.PANCH_CODE AND "
					+ " SAM.SOURCE_CODE = SR.SOURCE_CODE AND "
					+ " SAM.TEST_CODE = TES.TEST_CODE AND "
					+ " SAM.LAB_CODE = LAB.LAB_CODE AND "
					+ " SAM.SAMP_COLLECTOR_CODE = DES.DESIGNATION_CODE AND "
					+ " RES.LAB_CODE = LAB.LAB_CODE AND "
					+ " RES.SOURCE_CODE = SR.SOURCE_CODE " ;
				}
			}		
			rs = stmt.executeQuery(query);
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

<table border = 1 cellspacing = 0 cellpadding = 0 width=100% height=20%  bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">
			
			<tr align="right">
				<td class="bwborder"><a href="./rws_wq_sam_res_off_frm_temp.jsp">Back&nbsp;|&nbsp;</a>&nbsp;<a href="../home.jsp">Home</a></td>
			</tr>
		</table>
	</caption>
<%
	if(cCode.equals("00") && !fromDate.equals("00") && !toDate.equals("00"))
	{
		//System.out.println("FOR ALL CIRCLES... HEADING...");
%>
	<tr bgcolor="lavander">
		<td class="mystyle" align="center" colspan="16"><font color="navy">Water Quality Report</font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class="btext" align="center" colspan="16"><font color="navy">For All Circles From :<%=fromDate%> To :<%=toDate%></font></td>
	</tr>
<%	
	}
%>

	
	<tr align=center bgcolor="#ffffff">
		<td class=btext>Sl.No</td>
		<td class=btext>Test ID</td>
		<td class=btext>Habitation</td>
		<td class=btext>Source</td>
		<td class=btext>Test / <br>Nature Of Test</td>		
		<td class=btext>Lab</td>
		<td class=btext>Sample Collector / Date</td>		
		<td class=btext>Assigned On</td>
		<td class=btext>Prepared By / On</td>
		<td class=btext>Recommendations</td>
		<td class=btext>Source Condemended / Updated</td>
		<td class=btext>Forwarded On</td>
		<td class=btext>Prepared By / On</td>		
	</tr>
<%		
		int slno = 0;
		while(rs.next())
		{
			slno++;
%>
	<tr>
		<td class="mystyle1"><%=slno%></td>
		<td class="mystyle1"><%=rs.getString(1)%></td>
		<td class="mystyle1"><%=rs.getString(4)%></td>
		<td class="mystyle1"><%=rs.getString(6)%></td>
		<td class="mystyle1"><%=rs.getString(8)%><br><%=rs.getString(9)%></td>
		<td class="mystyle1"><%=rwsOffices.getOfficeName(rs.getString(2),true)%></td>
		
		<td class="mystyle1"><%=rs.getString(13)%><br><%=rs.getString(14)%></td>
		<td class="mystyle1"><%=rs.getString(15)%></td>
		<td class="mystyle1"><%=rs.getString(16)%><br><%=rs.getString(17)%></td>
		<td class="mystyle1"><%=rs.getString(18)%></td>
		<td class="mystyle1"><%=rs.getString(19)%><br><%=rs.getString(20)%></td>
		<td class="mystyle1"><%=rs.getString(21)%></td>
		<td class="mystyle1"><%=rs.getString(22)%><br><%=rs.getString(23)%></td>		
	</tr>
<%
		}
		if(slno == 0)
		{
%>
	<tr>
		<td class="mystyle1" colspan=10 align = center>NO RECORDS FOR YOUR QUERY...</td>
	</tr>
<%
		}
		stmt.close();
		rs.close();
		conn.close();
%>

</table>


</body>
</html>

<%
	
%>
<%@ include file = "footer.jsp" %>