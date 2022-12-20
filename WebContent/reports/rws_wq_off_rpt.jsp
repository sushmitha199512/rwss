<%@ include file = "conn.jsp" %>
<%@ include file = "header_rpt.jsp" %>


<%
		String cCode = String.valueOf(session.getAttribute("circleCode"));		
		String cName = String.valueOf(session.getAttribute("circleName"));		
		String dCode = String.valueOf(session.getAttribute("dCode"));		
		String dName = String.valueOf(session.getAttribute("dName"));		
		String sDCode = String.valueOf(session.getAttribute("sDCode"));		
		String sDName = String.valueOf(session.getAttribute("sDName"));		
		String fromDate = request.getParameter("fromdate");		
		String toDate = request.getParameter("todate");		
		String ccode = request.getParameter("circleOffice");
		String dcode = request.getParameter("divisionOffice");
		String sdcode = request.getParameter("subDivisionOffice");		
		
		RwsOffices rwsOffices = new RwsOffices(dataSource);
		
		stmt = conn.createStatement();		
			if(cCode.equals("00") && !fromDate.equals("00") && !toDate.equals("00"))
			{				
			//System.out.println("FOR ALL CIRCLES...");
			query = " SELECT "					
					+ " SAM.TEST_ID, SAM.HAB_CODE, PR.PANCH_NAME "					
					+ " FROM "					
					+ " RWS_WATER_SAMPLE_COLLECT_TBL SAM, RWS_PANCHAYAT_RAJ_TBL PR "					
					+ " WHERE "
					+ " SAM.HAB_CODE = PR.PANCH_CODE AND "
					+ " SAM.SAMP_COLLECT_DATE >= TO_DATE('"+fromDate+"','dd/MM/yyyy') AND " 			
					+ " SAM.SAMP_COLLECT_DATE <= TO_DATE('"+toDate+"','dd/MM/yyyy') ";
			}
			if(!cCode.equals("00")&& !fromDate.equals("00") && !toDate.equals("00") && !dCode.equals("00"))
			{
				//System.out.println("FOR A PERTICILAR CIRCLE...");
			query = " SELECT "					
					+ " SAM.TEST_ID, SAM.HAB_CODE, PR.PANCH_NAME "					
					+ " FROM "					
					+ " RWS_WATER_SAMPLE_COLLECT_TBL SAM, RWS_PANCHAYAT_RAJ_TBL PR "					
					+ " WHERE "
					+ " SAM.HAB_CODE = PR.PANCH_CODE AND "
					+ " SAM.SAMP_COLLECT_DATE >= TO_DATE('"+fromDate+"','dd/MM/yyyy') AND " 			
					+ " SAM.SAMP_COLLECT_DATE <= TO_DATE('"+toDate+"','dd/MM/yyyy') AND "				
					+ " SAM.CIRCLE_OFFICE_CODE = '"+cCode+"' ";
			}
			if(!cCode.equals("00") && !cCode.equals("-1") && dCode.equals("00") && !fromDate.equals("00") && !toDate.equals("00"))
			{
				//System.out.println("FOR ALL DIVISIONS...");
			query = " SELECT "					
					+ " SAM.TEST_ID "					
					+ " FROM "					
					+ " RWS_WATER_SAMPLE_COLLECT_TBL SAM "										
					+ " WHERE "
					+ " SAM.SAMP_COLLECT_DATE >= TO_DATE('"+fromDate+"','dd/MM/yyyy') AND " 			
					+ " SAM.SAMP_COLLECT_DATE <= TO_DATE('"+toDate+"','dd/MM/yyyy') AND "				
					+ " SAM.CIRCLE_OFFICE_CODE = '"+cCode+"' ";					
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

<table border = 1 cellspacing = 0 cellpadding = 0 height=20% width ="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">
			
			<tr align="right">
				<td class="bwborder"><a href="./rws_wq_off_rpt_frm.jsp">Back&nbsp;|&nbsp;</a>&nbsp;<a href="../home.jsp">Home</a></td>
			</tr>
		</table>
	</caption>
<%
	if(cCode.equals("00") && !fromDate.equals("00") && !toDate.equals("00"))
	{
		//System.out.println("FOR ALL CIRCLES... HEADING...");
%>
	<tr bgcolor="lavander">
		<td class="mystyle" align="center" colspan="3"><font color="navy">All Circles Water Quality Report</font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class="btext" align="center" colspan="3"><font color="navy">From :<%=fromDate%> && To :<%=toDate%></font></td>
	</tr>
<%	
	}
	if(!cCode.equals("00")&& !fromDate.equals("00") && !toDate.equals("00") && !dCode.equals("00"))
	{
		//System.out.println("FOR A PERTICULAR CIRCLE... HEADING...");
%>
	<tr bgcolor="lavander">
		<td class="mystyle" align="center" colspan="16"><font color="navy">Water Quality Report Of Circle <%=cName%></font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class="btext" align="center" colspan="16"><font color="navy">From :<%=fromDate%> && To :<%=toDate%></font></td>
	</tr>
<%
	}
	if(!cCode.equals("00") && !cCode.equals("-1") && dCode.equals("00") && !fromDate.equals("00") && !toDate.equals("00"))
	{
		//System.out.println("FOR ALL DIVISIONS...HEADING...");
%>
	<tr bgcolor="lavander">
		<td class="mystyle" align="center" colspan="16"><font color="navy">Water Quality Report</font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class="btext" align="center" colspan="16"><font color="navy">All Divisions Of Circle <%=cName%> From :<%=fromDate%> To :<%=toDate%></font></td>
	</tr>
<%
	}
%>

	
	<tr align=center bgcolor="#ffffff">
		<td class=btext>Sl.No</td>
		<td class=btext>Test ID (Click For Details)</td>
		<td class=btext>Habitaiton</td>		
	</tr>
<%		
		int slno = 0;
		while(rs.next())
		{
			slno++;
%>
	<tr>
		<td class="mystyle1"><%=slno%></td>
		<td class="mystyle1"><a href="./rws_wq_off_sam_coll_rpt.jsp?testId=<%=rs.getString(1)%>&habitationName=<%=rs.getString(3)%>&fromDate=<%=request.getParameter("fromdate")%>&toDate=<%=request.getParameter("todate")%>&cCode=<%=cCode%>&cName=<%=cName%>&dCode=<%=dCode%>&dName=<%=dName%>"><%=rs.getString(1)%></a></td>
		<td class="mystyle1"><%=rs.getString(3)%></td>		
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
<%@ include file = "footer.jsp" %>