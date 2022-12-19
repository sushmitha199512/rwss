<%
	java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("dd/MM/yyyy");
%>
<%@ include file = "conn.jsp" %>

<%
	//System.out.println("*****REPORT BEGINING*****");
	String rDistrict, rMandal, rPanchayat, rVillage, rHabitation = null;
	rDistrict = request.getParameter("rDistrict");
	rMandal = request.getParameter("rMandal");
	rPanchayat = request.getParameter("rPanchayat");
	rVillage = request.getParameter("rVillage");
	rHabitation = request.getParameter("rHabitation");	
	String districtName = String.valueOf(session.getAttribute("districtName"));
	String mandalName = String.valueOf(session.getAttribute("mandalName"));
	String panchayatName = String.valueOf(session.getAttribute("panchayatName"));
	String villageName = String.valueOf(session.getAttribute("villageName"));
	String habitationName = String.valueOf(session.getAttribute("habitationName"));
	//System.out.println("rDistrict = " +rDistrict);		
	//System.out.println("rMandal = " +rMandal);		
	//System.out.println("rPanchayat = " +rPanchayat);
	//System.out.println("rVillage = " +rVillage);
	//System.out.println("rHabitation = " +rHabitation);
	String query=null, query1 = null;
	ResultSet rs1 = null;
	Statement stmt1 = null;
	int slno = 0, lnno =0, pageno = 1;	
	RwsOffices rwsOffices = new RwsOffices(ds);	
%>

<html>
<head>

<title>WaterSoft</title>
</head>
<link rel="stylesheet" type="text/css" href="/pred-rpt/resources/style/rwsstyle.css">
<body bgcolor="#edf2f8">
<form name=f1 action="<%= request.getRequestURI()%>">

	<p align="center"><b><font face="Verdana" size="2">WaterSoft<br>
	Panchayat Raj Engineering Department<br>
	Rural Water Supply<br>
	Govt.of Andhra Pradesh</font></p>

	<p align="center"><b><font face="Verdana" size="2">RWS Planning Format - I Report</font></p>
	<p align="right" class=dateFont><%=sdf.format(new java.util.Date())%></p>
	<p align="right" class=dateFont>Page No: <%=pageno%></p>

<table border = 1 cellspacing = 0 cellpadding = 0 height=20% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=prptLabel>Sl.No</td>				
		<td class=prptLabel>District Code</td>
		<td class=prptLabel>District Name</td>
		<td class=prptLabel>Assembly Constituency Code</td>
		<td class=prptLabel>Assembly Constituency Name</td>
		<td class=prptLabel>Mandal Code</td>
		<td class=prptLabel>MandalName</td>
		<td class=prptLabel>Parliamentary Constituency</td>
		<td class=prptLabel>Division</td>
		<td class=prptLabel>Village Code</td>
		<td class=prptLabel>Village Name</td>
		<td class=prptLabel>Habitation Code</td>
		<td class=prptLabel>Habitation Name</td>
		<td class=prptLabel>Panchayat Code</td>
		<td class=prptLabel>Panchayat Name</td>
		<td class=prptLabel>PR Hab Code</td>
		<td class=prptLabel>Total Population</td>
		<td class=prptLabel>SC Population</td>
		<td class=prptLabel>ST Population</td>
		<td class=prptLabel>Status (1.4.05)</td>
		<td class=prptLabel>NSS - Ty</td>
		<td class=prptLabel>NSS - Fl</td>
		<td class=prptLabel>NSS - Br</td>
		<td class=prptLabel>NSS - Ir</td>
	</tr>
<%	
	if(rDistrict.equals("00"))
	{
		//System.out.println("IN DISTRICT ALL SELECTION...");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query = " SELECT D.DCODE, D.DNAME, C.CONSTITUENCY_CODE, C.CONSTITUENCY_NAME, M.MCODE, M.MNAME,    1 || HD.CIRCLE_OFFICE_CODE || HD.DIVISION_OFFICE_CODE || HD.SUBDIVISION_OFFICE_CODE, V.VCODE, V.VNAME, SUBSTR(HD.HAB_CODE,11,2), PR.PANCH_NAME, P.PCODE, P.PNAME, SUBSTR(PR.PANCH_CODE,15,2), HD.CENSUS_SC_POPU, HD.CENSUS_ST_POPU, NVL(HD.COVERAGE_STATUS, '---'), HD.NEAR_SURFACE_SOURCE FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL PR, RWS_MANDAL_TBL M, RWS_PANCHAYAT_TBL P, RWS_VILLAGE_TBL V, RWS_CONSTITUENCY_TBL C WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND SUBSTR(HD.HAB_CODE,6,2) = M.MCODE AND D.DCODE = M.DCODE AND SUBSTR(HD.HAB_CODE,13,2) = P.PCODE AND P.DCODE = D.DCODE AND P.MCODE = M.MCODE AND SUBSTR(HD.HAB_CODE,8,3) = V.VCODE AND V.DCODE = D.DCODE AND V.MCODE = M.MCODE AND V.PCODE = P.PCODE AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND C.CONSTITUENCY_TYPE = 'A' AND HD.HAB_CODE = PR.PANCH_CODE ORDER BY HD.HAB_CODE";
	}
	if(!rDistrict.equals("00") && !rDistrict.equals("-1") && rMandal.equals("-1"))
	{
		//System.out.println("IN DISTRICT SELECTION...");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query = "SELECT D.DCODE, D.DNAME, C.CONSTITUENCY_CODE, C.CONSTITUENCY_NAME, M.MCODE, M.MNAME,    1 || HD.CIRCLE_OFFICE_CODE || HD.DIVISION_OFFICE_CODE || HD.SUBDIVISION_OFFICE_CODE, V.VCODE, V.VNAME, SUBSTR(HD.HAB_CODE,11,2), PR.PANCH_NAME, P.PCODE, P.PNAME, SUBSTR(PR.PANCH_CODE,15,2), HD.CENSUS_SC_POPU, HD.CENSUS_ST_POPU, NVL(HD.COVERAGE_STATUS, '---'), HD.NEAR_SURFACE_SOURCE FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL PR, RWS_MANDAL_TBL M, RWS_PANCHAYAT_TBL P, RWS_VILLAGE_TBL V, RWS_CONSTITUENCY_TBL C WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND SUBSTR(HD.HAB_CODE,6,2) = M.MCODE AND D.DCODE = M.DCODE AND SUBSTR(HD.HAB_CODE,13,2) = P.PCODE AND P.DCODE = D.DCODE AND P.MCODE = M.MCODE AND SUBSTR(HD.HAB_CODE,8,3) = V.VCODE AND V.DCODE = D.DCODE AND V.MCODE = M.MCODE AND V.PCODE = P.PCODE AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND C.CONSTITUENCY_TYPE = 'A' AND HD.HAB_CODE = PR.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' ORDER BY HD.HAB_CODE";
	}
	if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && rMandal.equals("00") && rPanchayat.equals("-1"))
	{
		//System.out.println("IN MANDAL ALL SELECTION...");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query = "SELECT D.DCODE, D.DNAME, C.CONSTITUENCY_CODE, C.CONSTITUENCY_NAME, M.MCODE, M.MNAME,    1 || HD.CIRCLE_OFFICE_CODE || HD.DIVISION_OFFICE_CODE || HD.SUBDIVISION_OFFICE_CODE, V.VCODE, V.VNAME, SUBSTR(HD.HAB_CODE,11,2), PR.PANCH_NAME, P.PCODE, P.PNAME, SUBSTR(PR.PANCH_CODE,15,2), HD.CENSUS_SC_POPU, HD.CENSUS_ST_POPU, NVL(HD.COVERAGE_STATUS, '---'), HD.NEAR_SURFACE_SOURCE FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL PR, RWS_MANDAL_TBL M, RWS_PANCHAYAT_TBL P, RWS_VILLAGE_TBL V, RWS_CONSTITUENCY_TBL C WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND SUBSTR(HD.HAB_CODE,6,2) = M.MCODE AND D.DCODE = M.DCODE AND SUBSTR(HD.HAB_CODE,13,2) = P.PCODE AND P.DCODE = D.DCODE AND P.MCODE = M.MCODE AND SUBSTR(HD.HAB_CODE,8,3) = V.VCODE AND V.DCODE = D.DCODE AND V.MCODE = M.MCODE AND V.PCODE = P.PCODE AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND C.CONSTITUENCY_TYPE = 'A' AND HD.HAB_CODE = PR.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' ORDER BY HD.HAB_CODE";
	}
	if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && rPanchayat.equals("-1"))
	{
		//System.out.println("IN MANDAL SELECTION...");
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query = "SELECT D.DCODE, D.DNAME, C.CONSTITUENCY_CODE, C.CONSTITUENCY_NAME, M.MCODE, M.MNAME,    1 || HD.CIRCLE_OFFICE_CODE || HD.DIVISION_OFFICE_CODE || HD.SUBDIVISION_OFFICE_CODE, V.VCODE, V.VNAME, SUBSTR(HD.HAB_CODE,11,2), PR.PANCH_NAME, P.PCODE, P.PNAME, SUBSTR(PR.PANCH_CODE,15,2), HD.CENSUS_SC_POPU, HD.CENSUS_ST_POPU, NVL(HD.COVERAGE_STATUS, '---'), HD.NEAR_SURFACE_SOURCE FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL PR, RWS_MANDAL_TBL M, RWS_PANCHAYAT_TBL P, RWS_VILLAGE_TBL V, RWS_CONSTITUENCY_TBL C WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND SUBSTR(HD.HAB_CODE,6,2) = M.MCODE AND D.DCODE = M.DCODE AND SUBSTR(HD.HAB_CODE,13,2) = P.PCODE AND P.DCODE = D.DCODE AND P.MCODE = M.MCODE AND SUBSTR(HD.HAB_CODE,8,3) = V.VCODE AND V.DCODE = D.DCODE AND V.MCODE = M.MCODE AND V.PCODE = P.PCODE AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND C.CONSTITUENCY_TYPE = 'A' AND HD.HAB_CODE = PR.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' AND SUBSTR(HD.HAB_CODE,6,2) = '"+rMandal+"' ORDER BY HD.HAB_CODE";
	}
	if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && rPanchayat.equals("00"))
	{
		//System.out.println("IN PANCHAYAT ALL SELECTION...");		
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query = "SELECT D.DCODE, D.DNAME, C.CONSTITUENCY_CODE, C.CONSTITUENCY_NAME, M.MCODE, M.MNAME,    1 || HD.CIRCLE_OFFICE_CODE || HD.DIVISION_OFFICE_CODE || HD.SUBDIVISION_OFFICE_CODE, V.VCODE, V.VNAME, SUBSTR(HD.HAB_CODE,11,2), PR.PANCH_NAME, P.PCODE, P.PNAME, SUBSTR(PR.PANCH_CODE,15,2), HD.CENSUS_SC_POPU, HD.CENSUS_ST_POPU, NVL(HD.COVERAGE_STATUS, '---'), HD.NEAR_SURFACE_SOURCE FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL PR, RWS_MANDAL_TBL M, RWS_PANCHAYAT_TBL P, RWS_VILLAGE_TBL V, RWS_CONSTITUENCY_TBL C WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND SUBSTR(HD.HAB_CODE,6,2) = M.MCODE AND D.DCODE = M.DCODE AND SUBSTR(HD.HAB_CODE,13,2) = P.PCODE AND P.DCODE = D.DCODE AND P.MCODE = M.MCODE AND SUBSTR(HD.HAB_CODE,8,3) = V.VCODE AND V.DCODE = D.DCODE AND V.MCODE = M.MCODE AND V.PCODE = P.PCODE AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND C.CONSTITUENCY_TYPE = 'A' AND HD.HAB_CODE = PR.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' AND SUBSTR(HD.HAB_CODE,6,2) = '"+rMandal+"' ORDER BY HD.HAB_CODE";
	}
	if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && rVillage.equals("-1"))
	{
		//System.out.println("IN PANCHAYAT SELECTION...");		
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query = "SELECT D.DCODE, D.DNAME, C.CONSTITUENCY_CODE, C.CONSTITUENCY_NAME, M.MCODE, M.MNAME,    1 || HD.CIRCLE_OFFICE_CODE || HD.DIVISION_OFFICE_CODE || HD.SUBDIVISION_OFFICE_CODE, V.VCODE, V.VNAME, SUBSTR(HD.HAB_CODE,11,2), PR.PANCH_NAME, P.PCODE, P.PNAME, SUBSTR(PR.PANCH_CODE,15,2), HD.CENSUS_SC_POPU, HD.CENSUS_ST_POPU, NVL(HD.COVERAGE_STATUS, '---'), HD.NEAR_SURFACE_SOURCE FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL PR, RWS_MANDAL_TBL M, RWS_PANCHAYAT_TBL P, RWS_VILLAGE_TBL V, RWS_CONSTITUENCY_TBL C WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND SUBSTR(HD.HAB_CODE,6,2) = M.MCODE AND D.DCODE = M.DCODE AND SUBSTR(HD.HAB_CODE,13,2) = P.PCODE AND P.DCODE = D.DCODE AND P.MCODE = M.MCODE AND SUBSTR(HD.HAB_CODE,8,3) = V.VCODE AND V.DCODE = D.DCODE AND V.MCODE = M.MCODE AND V.PCODE = P.PCODE AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND C.CONSTITUENCY_TYPE = 'A' AND HD.HAB_CODE = PR.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' AND SUBSTR(HD.HAB_CODE,6,2) = '"+rMandal+"' AND SUBSTR(HD.HAB_CODE,13,2) = '"+rPanchayat+"' ORDER BY HD.HAB_CODE";
	}
	if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && !rVillage.equals("-1") && rVillage.equals("00"))
	{
		//System.out.println("IN VILLAGE ALL SELECTION...");		
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query = "SELECT D.DCODE, D.DNAME, C.CONSTITUENCY_CODE, C.CONSTITUENCY_NAME, M.MCODE, M.MNAME,    1 || HD.CIRCLE_OFFICE_CODE || HD.DIVISION_OFFICE_CODE || HD.SUBDIVISION_OFFICE_CODE, V.VCODE, V.VNAME, SUBSTR(HD.HAB_CODE,11,2), PR.PANCH_NAME, P.PCODE, P.PNAME, SUBSTR(PR.PANCH_CODE,15,2), HD.CENSUS_SC_POPU, HD.CENSUS_ST_POPU, NVL(HD.COVERAGE_STATUS, '---'), HD.NEAR_SURFACE_SOURCE FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL PR, RWS_MANDAL_TBL M, RWS_PANCHAYAT_TBL P, RWS_VILLAGE_TBL V, RWS_CONSTITUENCY_TBL C WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND SUBSTR(HD.HAB_CODE,6,2) = M.MCODE AND D.DCODE = M.DCODE AND SUBSTR(HD.HAB_CODE,13,2) = P.PCODE AND P.DCODE = D.DCODE AND P.MCODE = M.MCODE AND SUBSTR(HD.HAB_CODE,8,3) = V.VCODE AND V.DCODE = D.DCODE AND V.MCODE = M.MCODE AND V.PCODE = P.PCODE AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND C.CONSTITUENCY_TYPE = 'A' AND HD.HAB_CODE = PR.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' AND SUBSTR(HD.HAB_CODE,6,2) = '"+rMandal+"' AND SUBSTR(HD.HAB_CODE,13,2) = '"+rPanchayat+"' ORDER BY HD.HAB_CODE";
	}
	if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && !rVillage.equals("-1") && !rVillage.equals("00") && rHabitation.equals("-1"))
	{
		//System.out.println("IN VILLAGE SELECTION...");		
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query = "SELECT D.DCODE, D.DNAME, C.CONSTITUENCY_CODE, C.CONSTITUENCY_NAME, M.MCODE, M.MNAME,    1 || HD.CIRCLE_OFFICE_CODE || HD.DIVISION_OFFICE_CODE || HD.SUBDIVISION_OFFICE_CODE, V.VCODE, V.VNAME, SUBSTR(HD.HAB_CODE,11,2), PR.PANCH_NAME, P.PCODE, P.PNAME, SUBSTR(PR.PANCH_CODE,15,2), HD.CENSUS_SC_POPU, HD.CENSUS_ST_POPU, NVL(HD.COVERAGE_STATUS, '---'), HD.NEAR_SURFACE_SOURCE FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL PR, RWS_MANDAL_TBL M, RWS_PANCHAYAT_TBL P, RWS_VILLAGE_TBL V, RWS_CONSTITUENCY_TBL C WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND SUBSTR(HD.HAB_CODE,6,2) = M.MCODE AND D.DCODE = M.DCODE AND SUBSTR(HD.HAB_CODE,13,2) = P.PCODE AND P.DCODE = D.DCODE AND P.MCODE = M.MCODE AND SUBSTR(HD.HAB_CODE,8,3) = V.VCODE AND V.DCODE = D.DCODE AND V.MCODE = M.MCODE AND V.PCODE = P.PCODE AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND C.CONSTITUENCY_TYPE = 'A' AND HD.HAB_CODE = PR.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' AND SUBSTR(HD.HAB_CODE,6,2) = '"+rMandal+"' AND SUBSTR(HD.HAB_CODE,13,2) = '"+rPanchayat+"' AND SUBSTR(HD.HAB_CODE,8,3) = '"+rVillage+"' ORDER BY HD.HAB_CODE";
	}
	if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && !rVillage.equals("-1") && !rVillage.equals("00") && !rHabitation.equals("-1") && rHabitation.equals("00"))
	{
		//System.out.println("IN HABITATION ALL SELECTION...");		
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query = "SELECT D.DCODE, D.DNAME, C.CONSTITUENCY_CODE, C.CONSTITUENCY_NAME, M.MCODE, M.MNAME,    1 || HD.CIRCLE_OFFICE_CODE || HD.DIVISION_OFFICE_CODE || HD.SUBDIVISION_OFFICE_CODE, V.VCODE, V.VNAME, SUBSTR(HD.HAB_CODE,11,2), PR.PANCH_NAME, P.PCODE, P.PNAME, SUBSTR(PR.PANCH_CODE,15,2), HD.CENSUS_SC_POPU, HD.CENSUS_ST_POPU, NVL(HD.COVERAGE_STATUS, '---'), HD.NEAR_SURFACE_SOURCE FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL PR, RWS_MANDAL_TBL M, RWS_PANCHAYAT_TBL P, RWS_VILLAGE_TBL V, RWS_CONSTITUENCY_TBL C WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND SUBSTR(HD.HAB_CODE,6,2) = M.MCODE AND D.DCODE = M.DCODE AND SUBSTR(HD.HAB_CODE,13,2) = P.PCODE AND P.DCODE = D.DCODE AND P.MCODE = M.MCODE AND SUBSTR(HD.HAB_CODE,8,3) = V.VCODE AND V.DCODE = D.DCODE AND V.MCODE = M.MCODE AND V.PCODE = P.PCODE AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND C.CONSTITUENCY_TYPE = 'A' AND HD.HAB_CODE = PR.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' AND SUBSTR(HD.HAB_CODE,6,2) = '"+rMandal+"' AND SUBSTR(HD.HAB_CODE,13,2) = '"+rPanchayat+"' AND SUBSTR(HD.HAB_CODE,8,3) = '"+rVillage+"' ORDER BY HD.HAB_CODE";
	}
	if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && !rVillage.equals("-1") && !rVillage.equals("00") && !rHabitation.equals("-1") && !rHabitation.equals("00"))
	{
		//System.out.println("IN HABITATION SELECTION...");		
		stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		query = "SELECT D.DCODE, D.DNAME, C.CONSTITUENCY_CODE, C.CONSTITUENCY_NAME, M.MCODE, M.MNAME,    1 || HD.CIRCLE_OFFICE_CODE || HD.DIVISION_OFFICE_CODE || HD.SUBDIVISION_OFFICE_CODE, V.VCODE, V.VNAME, SUBSTR(HD.HAB_CODE,11,2), PR.PANCH_NAME, P.PCODE, P.PNAME, SUBSTR(PR.PANCH_CODE,15,2), HD.CENSUS_SC_POPU, HD.CENSUS_ST_POPU, NVL(HD.COVERAGE_STATUS, '---'), HD.NEAR_SURFACE_SOURCE FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL PR, RWS_MANDAL_TBL M, RWS_PANCHAYAT_TBL P, RWS_VILLAGE_TBL V, RWS_CONSTITUENCY_TBL C WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND SUBSTR(HD.HAB_CODE,6,2) = M.MCODE AND D.DCODE = M.DCODE AND SUBSTR(HD.HAB_CODE,13,2) = P.PCODE AND P.DCODE = D.DCODE AND P.MCODE = M.MCODE AND SUBSTR(HD.HAB_CODE,8,3) = V.VCODE AND V.DCODE = D.DCODE AND V.MCODE = M.MCODE AND V.PCODE = P.PCODE AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND C.CONSTITUENCY_TYPE = 'A' AND HD.HAB_CODE = PR.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' AND SUBSTR(HD.HAB_CODE,6,2) = '"+rMandal+"' AND SUBSTR(HD.HAB_CODE,13,2) = '"+rPanchayat+"' AND SUBSTR(HD.HAB_CODE,8,3) = '"+rVillage+"' AND HD.HAB_CODE = '"+rHabitation+"' ORDER BY HD.HAB_CODE";
	}	
	rs = stmt.executeQuery(query);
	//System.out.println("QUERY = " +query);
	lnno = 13;
	while(rs.next())
	{
		slno++;		
%>
	<tr bgcolor="#ffffff">
		<td class=rptValue nowrap><%=slno%></td>			
		<td class=rptValue nowrap><%=rs.getString(1)%></td>
		<td class=rptValue nowrap><%=rs.getString(2)%></td>
		<td class=rptValue nowrap><%=rs.getString(3)%></td>
		<td class=rptValue nowrap><%=rs.getString(4)%></td>
		<td class=rptValue nowrap><%=rs.getString(5)%></td>
		<td class=rptValue nowrap><%=rs.getString(6)%></td>		
		<td class=rptValue nowrap>--</td>
		<td class=rptValue nowrap>--</td>
		<td class=rptValue nowrap><%=rs.getString(8)%></td>
		<td class=rptValue nowrap><%=rs.getString(9)%></td>
		<td class=rptValue nowrap><%=rs.getString(10)%></td>
		<td class=rptValue nowrap><%=rs.getString(11)%></td>
		<td class=rptValue nowrap><%=rs.getString(12)%></td>
		<td class=rptValue nowrap><%=rs.getString(13)%></td>
		<td class=rptValue nowrap><%=rs.getString(14)%></td>
		<td class=rptValue align=right><%=rs.getInt(15)+rs.getInt(16)%></td>
		<td class=rptValue align=right><%=rs.getInt(15)%></td>		
		<td class=rptValue align=right><%=rs.getInt(16)%></td>
		<td class=rptValue nowrap><%=rs.getString(17)%></td>
		<td class=rptValue align=right><%=rs.getInt(18)%></td>
		<td class=rptValue align=right>--</td>
		<td class=rptValue align=right>--</td>
		<td class=rptValue align=right>--</td>
	</tr>

	


<%
	lnno++;	
	if(lnno > 45)
		{
		lnno = 1;
		pageno++;

%>
</table>
	<p align="center"><b><font face="Verdana" size="2">Designed and Developed By NIC APSC</b></font></p>
	<p style="page-break-before:always"></p>

	<p align="center"><b><font face="Verdana" size="2">WaterSoft<br>
	Panchayat Raj Engineering Department<br>
	Rural Water Supply<br>
	Govt.of Andhra Pradesh</font></p>

	<p align="center"><b><font face="Verdana" size="2">RWS Planning Format - I Report</font></p>
	<p align="right" class=dateFont><%=sdf.format(new java.util.Date())%></p>
	<p align="right" class=dateFont>Page No: <%=pageno%></p>

<table border = 1 cellspacing = 0 cellpadding = 0 height=20% width="100%" bordercolor=#000000 style="border-collapse:collapse" bgcolor="#ffffff" align = "center">	
	<tr align=center bgcolor="#ffffff" align=center>
		<td class=prptLabel>Sl.No</td>				
		<td class=prptLabel>District Code</td>
		<td class=prptLabel>District Name</td>
		<td class=prptLabel>Assembly Constituency Code</td>
		<td class=prptLabel>Assembly Constituency Name</td>
		<td class=prptLabel>Mandal Code</td>
		<td class=prptLabel>MandalName</td>
		<td class=prptLabel>Parliamentary Constituency</td>
		<td class=prptLabel>Division</td>
		<td class=prptLabel>Village Code</td>
		<td class=prptLabel>Village Name</td>
		<td class=prptLabel>Habitation Code</td>
		<td class=prptLabel>Habitation Name</td>
		<td class=prptLabel>Panchayat Code</td>
		<td class=prptLabel>Panchayat Name</td>
		<td class=prptLabel>PR Hab Code</td>
		<td class=prptLabel>Total Population</td>
		<td class=prptLabel>SC Population</td>
		<td class=prptLabel>ST Population</td>
		<td class=prptLabel>Status (1.4.05)</td>
		<td class=prptLabel>NSS - Ty</td>
		<td class=prptLabel>NSS - Fl</td>
		<td class=prptLabel>NSS - Br</td>
		<td class=prptLabel>NSS - Ir</td>
	</tr>
	
<%
		}
	}
	rs.close();
	stmt.close();		
%>

</table>

<%
	conn.close();
%>

</form>
</body>
</html>