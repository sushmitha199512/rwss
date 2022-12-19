<%
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
%>
<%@ include file = "conn.jsp" %>
<%
	String testId = request.getParameter("testId");
	//System.out.println("testId" + testId);
	String testName = request.getParameter("testName");
	String query = null;

%>
<html>
<head>
<title>WaterSoft</title>

</head>
<link rel="stylesheet" type="text/css" href="/pred-rpt/resources/style/rwsstyle.css">
<body bgcolor="#edf2f8">

	<p align="center"><b><font face="Verdana" size="2">WaterSoft<br>
	Panchayat Raj Engineering Department<br>
	Rural Water Supply<br>
	Govt.of Andhra Pradesh</font></p>
	<p align="right" class=dateFont><%=sdf.format(new java.util.Date())%></p>

<table border = 1 cellspacing = 0 cellpadding = 0 height=20% width ="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">
	<tr align=center align=center>
		<td class=prptLabel>Sl.No</td>
		<td class=prptLabel>Test Name</td>
		<td class=prptLabel>Testing Parameter Code</td>
		<td class=prptLabel>Testing Parameter Name</td>
		<td class=prptLabel>Min Permissible Value</td>
		<td class=prptLabel>Max Permissible Value</td>		
		<td class=prptLabel>Testing Parameter Code</td>		
		<td class=prptLabel>Testing Parameter Name</td>		
	</tr>

	<tr>
		<td class="prptLabel" colspan="11"><%=testName%> Test Details</font></td>	
	</tr>
<%
	int slno = 0;
	RwsOffices rwsOffices = new RwsOffices(ds);
	stmt = conn.createStatement();
	query = "SELECT T.TEST_NAME, P.TESTING_PARAMETER_CODE, P.TESTING_PARAMETER_NAME, P.MIN_PERMISSIBLE_VALUE, P.MAX_PERMISSIBLE_VALUE, L.TESTING_PARAMETER_CODE, NVL(L.TESTING_PARAMETER_VALUE,'---') FROM RWS_WQ_GEOLOGIST_TEST_TBL G, RWS_WQ_PARA_TEST_TBL P, RWS_WQ_TEST_RESULTS_LNK_TBL L, RWS_WATER_SAMPLE_COLLECT_TBL S, RWS_WATER_QUALITY_TEST_TBL T WHERE S.TEST_CODE = P.TEST_CODE  AND G.TEST_ID = L.TEST_ID AND P.TESTING_PARAMETER_CODE = L.TESTING_PARAMETER_CODE AND S.TEST_ID = G.TEST_ID AND T.TEST_CODE = S.TEST_CODE AND L.TEST_ID = '"+testId+"' ";
	rs = stmt.executeQuery(query);
		while(rs.next())
		{
			slno++;	
%>
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=rptValue><%=slno%></td>
		<td class=rptValue><%=rs.getString(1)%></td>
		<td class=rptValue><%=rs.getString(2)%></td>
		<td class=rptValue><%=rs.getString(3)%></td>
		<td class=rptValue><%=rs.getString(4)%></td>
		<td class=rptValue><%=rs.getString(5)%></td>
		<td class=rptValue><%=rs.getString(6)%></td>
		<td class=rptValue><%=rs.getString(7)%></td>		
		
	</tr>



<%
		}
		rs.close();
		stmt.close();
		conn.close();
%>
</table>
<p align="center"><b><font face="Verdana" size="2">Designed and Developed By NIC APSC</b></font></p>
</body>
</html>