<% 
	if(request.getParameter("type") != null && request.getParameter("type").equals("excel")) 
	{
		response.setContentType("application/vnd.ms-excel"); 
	}
%>
<%@ include file="/commons/rws_header1.jsp"%>
<%@ include file="/commons/rws_header2.jsp"%>
<%@ include file = "conn.jsp" %>
<%	try 
	{
	String sourceName = String.valueOf(session.getAttribute("sourceName"));
	String rSource = request.getParameter("source");
	//System.out.println("rSource"+rSource);
	String fromDate = request.getParameter("fromDate");
	//System.out.println("fromDate"+fromDate);
	String toDate = request.getParameter("toDate");
	//System.out.println("toDate"+toDate);
	int slno = 0;
	String rDist = request.getParameter("district");
	String rMandal = request.getParameter("mandal");
	String rPanchayat = request.getParameter("panchayat");
	String rVillage = request.getParameter("village");
	String rHabitation = request.getParameter("habitation");
	int start=0, end, limit=3;
	int cnt,st=0;
	int pg=1;
	String query = null;

	 
%>
<html>
<head>
<title>WaterSoft</title>

</head>
<body bgcolor="#edf2f8">
<form name=f1 action="<%= request.getRequestURI()%>">
<table border = 1 cellspacing = 0 cellpadding = 0 height=20% width ="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<caption>
		<table  border=0 rules=none style="border-collapse:collapse" align = "right">
			
			<tr align="right">
				<td class="bwborder"><a href="./rws_source_loc_rpt_frm.jsp">Back |</a></td>
				<td class="bwborder"><a href="../home.jsp">Home |</a></td>
				<td class="bwborder"><a href="./rws_source_loc_prnt_rpt.jsp?district=<%=rDist%>&mandal=<%=rMandal%>&panchayat=<%=rPanchayat%>&village=<%=rVillage%>&habitation=<%=rHabitation%>&source=<%=rSource%>&fromDate=<%=fromDate%>&toDate=<%=toDate%>" target="_new">Print |</a></td>
				<td class="bwborder"><a href="./rws_source_loc_xls_rpt.jsp?type=excel&district=<%=rDist%>&mandal=<%=rMandal%>&panchayat=<%=rPanchayat%>&village=<%=rVillage%>&habitation=<%=rHabitation%>&source=<%=rSource%>&fromDate=<%=fromDate%>&toDate=<%=toDate%>" target="_new">Excel</a></td>			
			</tr>
		</table>
	</caption>
	 
<%
	RwsOffices rwsOffices = new RwsOffices(ds);
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	query = " SELECT DISTINCT SAM.TEST_ID, (1 || SAM.CIRCLE_OFFICE_CODE || SAM.DIVISION_OFFICE_CODE || SAM.SUBDIVISION_OFFICE_CODE), SAM.HAB_CODE, SAM.SOURCE_CODE, SR.SOURCE_NAME, SAM.TEST_CODE, T.TEST_NAME, DECODE(SAM.NATURE_OF_TEST, '1', 'ROUTINE', '2', 'SEASONAL', '3', 'QUARTERLY', '4', 'DISEASE OUTBREAK'), SAM.LAB_CODE, SAM.SAMP_COLLECTOR_CODE, D.DESIGNATION_NAME, TO_CHAR(SAM.SAMP_COLLECT_DATE, 'dd/MM/yyyy'), SAM.SAMP_COLLECT_TIME, TO_CHAR(SAM.ASSIGNED_ON, 'dd/MM/yyyy'), SAM.PREPARED_BY, TO_CHAR(SAM.PREPARED_ON, 'dd/MM/yyyy'), GEO.TEST_ID, GEO.OFFICE_CODE, GEO.LAB_CODE, GEO.ASSIGNED_BY, GEO.ASSIGNED_FROM_DATE, GEO.ASSIGNED_TO_DATE, GEO.ASSIGNED_TO, NVL(TO_CHAR(GEO.RESULT_OBTAIN_DATE, 'dd/MM/yyyy'),'---'), NVL(TO_CHAR(GEO.FORWARDED_DATE, 'dd/MM/yyyy'),'---'),  GEO.OFFICE_FORWARD, GEO.PREPARED_BY, GEO.PREPARED_ON, WTR.TEST_ID, WTR.RECOMMENDATIONS, WTR.CONDEMN_THE_SOURCE, WTR.UPDATE_SOURCE_DATA, TO_CHAR(WTR.FORWARDED_ON, 'dd/MM/yyyy'), WTR.PREPARED_BY, TO_CHAR(WTR.PREPARED_ON, 'dd/MM/yyyy'), WTR.TEST_CODE, WTR.LAB_CODE, WTR.SOURCE_CODE FROM RWS_WATER_SAMPLE_COLLECT_TBL SAM, RWS_WQ_GEOLOGIST_TEST_TBL GEO, RWS_WQ_TEST_RESULTS_TBL WTR, RWS_SOURCE_TBL SR, RWS_DESIGNATION_TBL D, RWS_WATER_QUALITY_TEST_TBL T WHERE SAM.TEST_CODE = T.TEST_CODE AND SAM.SAMP_COLLECTOR_CODE = D.DESIGNATION_CODE AND  SAM.SOURCE_CODE=SR.SOURCE_CODE AND SAM.TEST_ID=GEO.TEST_ID AND SAM.TEST_ID=WTR.TEST_ID AND GEO.TEST_ID=WTR.TEST_ID AND SR.SOURCE_CODE = SAM.SOURCE_CODE AND SR.SOURCE_CODE='"+rSource+"' AND SAM.SAMP_COLLECT_DATE >= TO_DATE('"+fromDate+"', 'DD/MM/YYYY') AND SAM.SAMP_COLLECT_DATE <= TO_DATE('"+toDate+"', 'DD/MM/YYYY') ORDER BY SAM.TEST_CODE ";	
	rs = stmt.executeQuery(query);
	rs.last();

	cnt=rs.getRow();
	//System.out.println("cnt="+cnt+"limit="+limit);
	int totpage = (cnt/limit) + 1;
	rs.beforeFirst();

	//System.out.println("int is *************"+cnt);
	if(rs.next())
	{
%>
	<tr bgcolor="#8A9FCD" align="center">
		<td class="rptHeading" colspan="11">Details Of Source: <%=sourceName%> At <%=rwsOffices.getOfficeName(rs.getString(2),true)%></td>	
	</tr>


	<tr bgcolor="#FFFFFF" align="center">
		<td class="rptValue" colspan="11">From: <%=fromDate%> To: <%=toDate%></td>	
	</tr>

	<tr align=center bgcolor="#ffffff" align=center>
		<td class=btext>Sl.No</td>		
		<td class=btext>Nature Of Test</td>
		<td class=btext>Sample Collector - <br> Collected Date</td>		
		<td class=btext>Prepared By - <br> Prepared On</td>
		<td class=btext>Assigned On</td>
		<td class=btext>Assigned By - <br> Assigned To</td>
		<td class=btext>Result Obtained On - <br> Forwarded Date</td>		
		<td class=btext>Forwarded On</td>
		<td class=btext>Prepared By <br> Prepared On</td>		
		<td class=btext>Recommendations</td>
	</tr>
<%	
	rs.beforeFirst();
	int k=1, l=1;
	if(request.getParameter("start") != null && !request.getParameter("start").equals("null"))
	{	
		start=Integer.parseInt(String.valueOf(request.getParameter("start")));
		
		//System.out.println("Start = "+ start+"st="+st);
		if(start==1 || start==0)
			start=1;
		else
			if(start<limit)
			{
		     start=limit+1;
			 pg=(start-limit)+1;  
			}
			else 
			st=1;
	}
	else
		{
		start=1;
		//System.out.println("Start = "+ start);
		}
			if(st!=1)
			{		  
				end=start+limit;
				//System.out.println("start="+start+"end="+end+"limit="+limit+"cnt="+cnt);
					if(end>cnt)
						end=cnt+1;
			}
			else
				end=start;
				//System.out.println("start="+start+"end="+end+"limit="+limit+"cnt="+cnt);
				
		for(int sum=start; sum<end; sum++)
		{
			rs.absolute(sum);
			slno++;				
%>	
<%
			if(rs.getString(6).equals("1") && k==1)
			{
				//System.out.println("FISRT CODE IN TEST...");

%>
	<tr bgcolor="#FFFFFF">
		<td class="rptSubValue" colspan="11"><%=rs.getString(7)%> Test At <%=rwsOffices.getOfficeName(rs.getString(2),true)%> Lab Details:</td>	
	</tr>
<%
			k++;
			}
			else
				if(rs.getString(6).equals("2") && l==1)
				{
					//System.out.println("SECOND CODE IN TEST...");
%>
	<tr bgcolor="#FFFFFF">
		<td class="rptSubValue" colspan="11"><%=rs.getString(7)%> Test At <%=rwsOffices.getOfficeName(rs.getString(2),true)%> Lab Details:</td>	
	</tr>
<%
			l++;
				}
				else
					if(rs.getString(6).equals("3"))
					{
						//System.out.println("SECOND CODE IN TEST...");					
%>
	<tr bgcolor="#FFFFFF">
		<td class="rptSubValue" colspan="11"><%=rs.getString(7)%> Test At <%=rwsOffices.getOfficeName(rs.getString(2),true)%> Lab Details:</td>	
	</tr>
<%
					}
%>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=rptValue><%=slno%></td>		
		<td class=rptValue><a href="./rws_source_loc_res_rpt.jsp?testId=<%=rs.getString(1)%>&testName=<%=rs.getString(7)%>" target ="_new"><%=rs.getString(8)%></a></td>
		<td class=rptValue><%=rs.getString(11)%> <br> <%=rs.getString(12)%></td>		
		<td class=rptValue><%=rs.getString(15)%> <br> <%=rs.getString(16)%></td>
		<td class=rptValue><%=rs.getString(14)%></td>
		<td class=rptValue><%=rs.getString(20)%> <br> <%=rs.getString(23)%></td>
		<td class=rptValue><%=rs.getString(24)%> <br> <%=rs.getString(25)%></td>		
		<td class=rptValue><%=rs.getString(33)%></td>
		<td class=rptValue><%=rs.getString(34)%> <br> <%=rs.getString(35)%></td>		
		<td class=rptValue><%=rs.getString(30)%></td>
	</tr>
<%
		}		
		
	}
	else
		if(slno == 0)
		{
%>
	<tr>
		<td class="rptSubValue" colspan=10 align = center>NO RECORDS FOR YOUR QUERY...</td>
	</tr>
<%
		}
	conn.close();
%>

<% 
	if(st!=1)
	{
%>

	<tr align=center>
		<td class="rptSubValue" colspan=7 align = center>Go To Page</td>
		<td class="rptSubValue" colspan=2 align = center><input type="text" name="start" onchange="document.f1.submit()"></td>
		<td class="rptSubValue" colspan=1 align = center>Page <%=pg%> of <%= totpage%></td>
	</tr>
<%
	}
	else
		{
%>
	<script>
		alert("Invalid Page Entered...");
	</script>

	<tr align=center>
		<td class="rptSubValue" colspan=5 align = center>Go To Page</td>
		<td class="rptSubValue" colspan=2 align = center><input type="text" name="start"  onchange="document.f1.submit()"></td>
		<td class="rptSubValue" colspan=3 align = center>Enter Page Between <%= totpage %></td>
	<tr>
<%
		}
%>
</table>

<input type="hidden" name=district value="<%=rDist%>">
<input type="hidden" name=mandal value="<%=rMandal%>">
<input type="hidden" name=panchayat value="<%=rPanchayat%>">
<input type="hidden" name=village value="<%=rVillage%>">
<input type="hidden" name=habitation value=<%=rHabitation%>>
<input type="hidden" name=source value=<%=rSource%>>
<input type="hidden" name=fromDate value=<%=fromDate%>>
<input type="hidden" name=toDate value=<%=toDate%>>
 



</body>
</html>
<%@ include file = "footer.jsp" %>
<%
	}
	catch(Exception e)
	{
		//System.out.println("error is "+ e);

	}
%>