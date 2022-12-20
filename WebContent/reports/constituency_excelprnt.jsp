<%@ include file = "conn.jsp" %>
<%
	//System.out.println("***********************REPORT BEGINING***********************");
	String rDistrict, rConstituency, rMandal, rPanchayat, rVillage, distvalue, distname, conname, convalue, manvalue, manname, panvalue, panname, vilvalue, vilname = null;
	rDistrict = request.getParameter("district");
	rMandal = request.getParameter("mandal");
	rPanchayat = request.getParameter("panchayat");
	rVillage = request.getParameter("village");
	rConstituency = request.getParameter("constituency");
	String districtName = (String)session.getAttribute("districtName");
	String mandalName = (String)session.getAttribute("mandalName");
	String panchayatName = (String)session.getAttribute("panchayatName");
	String villageName = (String)session.getAttribute("villageName");
	String constituencyName = (String)session.getAttribute("constituencyName");
	
	java.text.SimpleDateFormat fmt = new java.text.SimpleDateFormat("dd/MM/yyyy"); 
	String query=null, query1 = null;
	ResultSet rs1 = null;
	Statement stmt1 = null;
	PreparedStatement pstmt = null;
	int slno = 0,total=0;
	int i = 0;
	int[] gcount = new int[8];
	int[] gcount1= new int[8];
	String[] coveragestatus = {"FC","NC","NSS","PC1","PC2","PC3","PC4","UI"};
try
{
%>
<html>
<head>
</head>
<body>

<form name=f1 method="post">
<p align="center"><b><font face="Verdana" size="2">WaterSoft<br>
	Panchayat Raj Engineering Department<br>
	Rural Water Supply<br>
	Govt.of Andhra Pradesh</font></p>

	
	<p align="right" class=dateFont><%=fmt.format(new java.util.Date())%></p>

<table border = 1 cellspacing = 0 cellpadding = 0 height=5% width="100%" bordercolor=#000000 style="border-collapse:collapse"  align = "center">
	<% 
	stmt = conn.createStatement();
	if(rDistrict != null && rDistrict.equals("00"))
	{
		//System.out.println("IN DISTRICT ALL...COVERAGE");		
		/*query = "SELECT DNAME, DCODE FROM RWS_DISTRICT_TBL ORDER BY DCODE";*/	
		query="SELECT DISTINCT D.Dcode,D.DNAME,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='UI' then 1 Else 0 End)as UI  FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE  GROUP BY D.Dcode,D.Dname";
	}
	if(rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("-1"))
	{
		//System.out.println("IN DISTRICT SELECTION...COVERAGE");
		/*query = "SELECT C.CONSTITUENCY_NAME, C.CONSTITUENCY_CODE FROM RWS_CONSTITUENCY_TBL C WHERE C.DCODE = '" +rDistrict+ "' ORDER BY C.CONSTITUENCY_CODE";*/
		query="SELECT DISTINCT C.CONSTITUENCY_CODE,C.CONSTITUENCY_NAME,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='UI' then 1 Else 0 End)as UI FROM RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = C.DCODE AND C.DCODE = '" +rDistrict+ "' AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE GROUP BY C.CONSTITUENCY_CODE,C.CONSTITUENCY_NAME";
	}
	if(rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("00"))
	{
		//System.out.println("IN DISTRICT , CONSTITUENCY ALL SELECTION...COVERAGE");

		/*query = "SELECT C.CONSTITUENCY_NAME, C.CONSTITUENCY_CODE FROM RWS_CONSTITUENCY_TBL C WHERE C.DCODE = '" +rDistrict+ "' ORDER BY C.CONSTITUENCY_CODE";*/
		 query="SELECT DISTINCT C.CONSTITUENCY_CODE,C.CONSTITUENCY_NAME,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='UI' then 1 Else 0 End)as UI FROM RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = C.DCODE AND C.DCODE = '" +rDistrict+ "' AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE GROUP BY C.CONSTITUENCY_CODE,C.CONSTITUENCY_NAME";

	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && rMandal.equals("-1"))
	{
		//System.out.println("IN DISTRICT , CONSTITUENCY SELECTION...COVERAGE");
		/*query = "SELECT DISTINCT M.MNAME, M.MCODE FROM RWS_MANDAL_TBL M, RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = M.DCODE AND M.DCODE = '" +rDistrict+ "' AND SUBSTR(H.HAB_CODE,6,2) = M.MCODE AND C.DCODE = M.DCODE AND SUBSTR(H.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' ORDER BY M.MCODE";*/

		query="SELECT DISTINCT m.mcode,M.MNAME,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='UI' then 1 Else 0 End)as UI  FROM RWS_MANDAL_TBL M, RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = M.DCODE AND M.DCODE = '" +rDistrict+ "' AND SUBSTR(HD.HAB_CODE,6,2) = M.MCODE AND C.DCODE = M.DCODE AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' GROUP BY mcode,mname";

	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && rMandal.equals("00") && rPanchayat.equals("-1"))
	{
		//System.out.println("IN DISTRICT , CONSTITUENCY, MANDAL ALL SELECTION...COVERAGE");
		/*query = "SELECT DISTINCT M.MNAME, M.MCODE FROM RWS_MANDAL_TBL M, RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = M.DCODE AND M.DCODE = '" +rDistrict+ "' AND SUBSTR(H.HAB_CODE,6,2) = M.MCODE AND C.DCODE = M.DCODE AND SUBSTR(H.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' ORDER BY M.MCODE";*/

		query="SELECT DISTINCT m.mcode,M.MNAME,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='UI' then 1 Else 0 End)as UI  FROM RWS_MANDAL_TBL M, RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = M.DCODE AND M.DCODE = '" +rDistrict+ "' AND SUBSTR(HD.HAB_CODE,6,2) = M.MCODE AND C.DCODE = M.DCODE AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' GROUP BY mcode,mname";
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && rPanchayat.equals("-1"))
	{
		//System.out.println("IN DISTRICT , CONSTITUENCY, MANDAL SELECTION...COVERAGE");
		/*query = "SELECT DISTINCT P.PNAME, P.PCODE FROM RWS_PANCHAYAT_TBL P, RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = P.DCODE AND P.DCODE = '" +rDistrict+ "' AND P.MCODE = '" +rMandal+ "' AND SUBSTR(H.HAB_CODE,6,2) = P.MCODE AND C.DCODE = P.DCODE AND SUBSTR(H.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' ORDER BY P.PCODE";*/
		
		query="SELECT DISTINCT P.PCODE,P.PNAME,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='UI' then 1 Else 0 End)as UI FROM RWS_PANCHAYAT_TBL P, RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = P.DCODE AND P.DCODE = '" +rDistrict+ "' AND  SUBSTR(HD.HAB_CODE,6,2) = P.MCODE and P.MCODE ='" +rMandal+ "' AND  SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' and C.DCODE = P.DCODE AND SUBSTR(HD.HAB_CODE,13,2) = P.PCODE  GROUP BY P.PCODE,P.PNAME";

	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && rPanchayat.equals("00") && !rVillage.equals("-1"))
	{
		//System.out.println("IN DISTRICT , CONSTITUENCY, MANDAL, PANCHAYAT ALL SELECTION...COVERAGE");
		/*query = "SELECT DISTINCT P.PNAME, P.PCODE FROM RWS_PANCHAYAT_TBL P, RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = P.DCODE AND P.DCODE = '" +rDistrict+ "' AND P.MCODE = '" +rMandal+ "' AND SUBSTR(H.HAB_CODE,6,2) = P.MCODE AND C.DCODE = P.DCODE AND SUBSTR(H.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' ORDER BY P.PCODE";*/
		query="SELECT DISTINCT P.PCODE,P.PNAME,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='UI' then 1 Else 0 End)as UI FROM RWS_PANCHAYAT_TBL P, RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = P.DCODE and C.DCODE = P.DCODE AND P.DCODE = '" +rDistrict+ "' AND  SUBSTR(HD.HAB_CODE,6,2) = P.MCODE and P.MCODE ='" +rMandal+ "' AND  SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "'  AND SUBSTR(HD.HAB_CODE,13,2) = P.PCODE GROUP BY P.PCODE,P.PNAME";

	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("00") && !rPanchayat.equals("-1") && rVillage.equals("-1"))
	{
		//System.out.println("IN DISTRICT , CONSTITUENCY, MANDAL, PANCHAYAT SELECTION...COVERAGE");
		/*query = "SELECT DISTINCT V.VNAME, V.VCODE FROM RWS_VILLAGE_TBL V, RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = V.DCODE AND V.DCODE = '" +rDistrict+ "' AND V.MCODE = '" +rMandal+ "' AND V.PCODE = '" +rPanchayat+ "' AND SUBSTR(H.HAB_CODE,6,2) = V.MCODE AND C.DCODE = V.DCODE AND SUBSTR(H.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' ORDER BY V.VCODE";*/

		query="SELECT DISTINCT V.Vcode,V.VNAME,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='UI' then 1 Else 0 End)as UI FROM RWS_VILLAGE_TBL V, RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = V.DCODE AND V.DCODE = '" +rDistrict+ "' AND V.MCODE = '" +rMandal+ "' AND V.PCODE = '" +rPanchayat+ "' AND SUBSTR(HD.HAB_CODE,6,2) = V.MCODE AND C.DCODE = V.DCODE AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' and SUBSTR(HD.HAB_CODE,8,3) = V.VCODE GROUP BY V.VCODE,V.VNAME";
	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("00") && !rPanchayat.equals("-1") && !rVillage.equals("-1") && rVillage.equals("00"))
	{
		//System.out.println("IN DISTRICT , CONSTITUENCY, MANDAL, PANCHAYAT VILLAGE ALL SELECTION...COVERAGE");
		/*query = "SELECT DISTINCT V.VNAME, V.VCODE FROM RWS_VILLAGE_TBL V, RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = V.DCODE AND V.DCODE = '" +rDistrict+ "' AND V.MCODE = '" +rMandal+ "' AND V.PCODE = '" +rPanchayat+ "' AND SUBSTR(H.HAB_CODE,6,2) = V.MCODE AND C.DCODE = V.DCODE AND SUBSTR(H.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' ORDER BY V.VCODE";*/

		query="SELECT DISTINCT V.Vcode,V.VNAME,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='UI' then 1 Else 0 End)as UI FROM RWS_VILLAGE_TBL V, RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL HD WHERE SUBSTR(HD.HAB_CODE,1,2) = V.DCODE AND V.DCODE = '" +rDistrict+ "' AND V.MCODE = '" +rMandal+ "' AND V.PCODE = '" +rPanchayat+ "' AND SUBSTR(HD.HAB_CODE,6,2) = V.MCODE AND C.DCODE = V.DCODE AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' and SUBSTR(HD.HAB_CODE,8,3) = V.VCODE GROUP BY V.VCODE,V.VNAME";

	}
	if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("00") && !rPanchayat.equals("-1") && !rVillage.equals("-1") && !rVillage.equals("00"))
	{
		//System.out.println("IN DISTRICT , CONSTITUENCY, MANDAL, PANCHAYAT VILLAGE SELECTION...COVERAGE");
		/*query = "SELECT DISTINCT P.PANCH_NAME, H.HAB_CODE FROM RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL H, RWS_PANCHAYAT_RAJ_TBL P WHERE H.HAB_CODE = P.PANCH_CODE AND SUBSTR(H.HAB_CODE,1,2) = '" +rDistrict+ "' AND SUBSTR(H.HAB_CODE,6,2) = '" +rMandal+ "' AND SUBSTR(H.HAB_CODE,13,2) = '" +rPanchayat+ "' AND SUBSTR(H.HAB_CODE,8,3) = '" +rVillage+ "' AND C.DCODE = SUBSTR(H.HAB_CODE,1,2) AND SUBSTR(H.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' ORDER BY H.HAB_CODE";*/

        query="SELECT DISTINCT P.PANCH_NAME,HD.HAB_CODE,SUM(Case When HD.coverage_status='FC' then 1 Else 0 End) as FC, SUM(Case When HD.coverage_status='NC' then 1 Else 0 End) as NC,SUM(Case When HD.coverage_status='NSS' then 1 Else 0 End) as NSS,SUM(Case When HD.coverage_status='PC1' then 1 Else 0 End) AS PC1,SUM(Case When HD.coverage_status='PC2' then 1 Else 0 End) AS PC2,SUM(Case When HD.coverage_status='PC3' then 1 Else 0 End) AS PC3,SUM(Case When HD.coverage_status='PC4' then 1 Else 0 End) AS PC4,SUM(Case When HD.coverage_status='UI' then 1 Else 0 End)as UI FROM RWS_CONSTITUENCY_TBL C, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL P WHERE HD.HAB_CODE = P.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '" +rDistrict+ "' AND SUBSTR(HD.HAB_CODE,6,2) = '" +rMandal+ "' AND SUBSTR(HD.HAB_CODE,13,2) = '" +rPanchayat+ "' AND SUBSTR(HD.HAB_CODE,8,3) = '" +rVillage+ "' AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.CONSTITUENCY_CODE = '" +rConstituency+ "' GROUP BY HD.HAB_CODE,P.PANCH_NAME";
	}
	rs = stmt.executeQuery(query);
%>
<%@ include file="./rws_const_coverage_label.jsp"%>
<%	
	int fcTotal=0,ncTotal=0,nssTotal=0,pc1Total=0,pc4Total=0,pc3Total=0,pc2Total=0,uiTotal=0;
	while(rs.next())
	{
		++ slno;%>
		<td class=rptValue><%=slno%></td>
		<td class=rptValue><%=rs.getString(2)%></td>
	<%
			total=rs.getInt(3)+rs.getInt(4)+rs.getInt(5)+rs.getInt(6)+rs.getInt(7)+rs.getInt(8)+rs.getInt(9)+rs.getInt(10);%>
		
		 <td class=btext><%=total%></td>
		<% /*for (i=0; i<coveragestatus.length; i++)
		{
			
			if(rDistrict != null && rDistrict.equals("00"))
			{
				query1 = "SELECT COUNT(*) FROM RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = '" +rs.getString(2)+ "' AND COVERAGE_STATUS = ? ";				
			}
			if(rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("-1"))
			{
				query1 = "SELECT COUNT(*) FROM RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = '" +rDistrict+ "' AND SUBSTR(H.HAB_CODE,3,3) = '" +rs.getString(2)+ "' AND COVERAGE_STATUS = ? ";	
			}
			if(rDistrict != null && !rDistrict.equals("00") && rConstituency.equals("00"))
			{
				query1 = "SELECT COUNT(*) FROM RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = '" +rDistrict+ "' AND SUBSTR(H.HAB_CODE,3,3) = '" +rs.getString(2)+ "' AND COVERAGE_STATUS = ? ";	
			}
			if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && rMandal.equals("-1"))
			{
				query1 = "SELECT COUNT(*) FROM RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = '" +rDistrict+ "' AND SUBSTR(H.HAB_CODE,3,3) = '" +rConstituency+ "' AND SUBSTR(H.HAB_CODE,6,2) = '" +rs.getString(2)+ "' AND COVERAGE_STATUS = ? ";	
			}
			if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && rMandal.equals("00"))
			{
				query1 = "SELECT COUNT(*) FROM RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = '" +rDistrict+ "' AND SUBSTR(H.HAB_CODE,3,3) = '" +rConstituency+ "' AND SUBSTR(H.HAB_CODE,6,2) = '" +rs.getString(2)+ "' AND COVERAGE_STATUS = ? ";	
			}
			if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00"))
			{
				query1 = "SELECT COUNT(*) FROM RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = '" +rDistrict+ "' AND SUBSTR(H.HAB_CODE,3,3) = '" +rConstituency+ "' AND SUBSTR(H.HAB_CODE,6,2) = '" +rMandal+ "' AND SUBSTR(H.HAB_CODE,13,2) = '" +rs.getString(2)+ "' AND COVERAGE_STATUS = ? ";	
			}
			if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && rPanchayat.equals("00") && !rPanchayat.equals("-1"))
			{
				query1 = "SELECT COUNT(*) FROM RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = '" +rDistrict+ "' AND SUBSTR(H.HAB_CODE,3,3) = '" +rConstituency+ "' AND SUBSTR(H.HAB_CODE,6,2) = '" +rMandal+ "' AND SUBSTR(H.HAB_CODE,13,2) = '" +rs.getString(2)+ "' AND COVERAGE_STATUS = ? ";
			}
			if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("00") && !rPanchayat.equals("-1") && rVillage.equals("-1"))
			{
				query1 = "SELECT COUNT(*) FROM RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = '" +rDistrict+ "' AND SUBSTR(H.HAB_CODE,3,3) = '" +rConstituency+ "' AND SUBSTR(H.HAB_CODE,6,2) = '" +rMandal+ "' AND SUBSTR(H.HAB_CODE,13,2) = '" +rPanchayat+ "' AND SUBSTR(H.HAB_CODE,8,3) = '" +rs.getString(2)+ "' AND COVERAGE_STATUS = ? ";
			}
			if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("00") && !rPanchayat.equals("-1") && !rVillage.equals("-1") && rVillage.equals("00"))
			{
				query1 = "SELECT COUNT(*) FROM RWS_HABITATION_DIRECTORY_TBL H WHERE SUBSTR(H.HAB_CODE,1,2) = '" +rDistrict+ "' AND SUBSTR(H.HAB_CODE,3,3) = '" +rConstituency+ "' AND SUBSTR(H.HAB_CODE,6,2) = '" +rMandal+ "' AND SUBSTR(H.HAB_CODE,13,2) = '" +rPanchayat+ "' AND SUBSTR(H.HAB_CODE,8,3) = '" +rs.getString(2)+ "' AND COVERAGE_STATUS = ? ";
			}


			if(rDistrict != null && !rDistrict.equals("00") && !rConstituency.equals("00") && !rConstituency.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("00") && !rPanchayat.equals("-1") && !rVillage.equals("-1") && !rVillage.equals("00"))
			{
				query1 = "SELECT COUNT(*) FROM RWS_HABITATION_DIRECTORY_TBL H WHERE H.HAB_CODE = '" +rs.getString(2)+ "' AND COVERAGE_STATUS = ? ";
			}
			pstmt = conn.prepareStatement(query1);			
			pstmt.setString(1,coveragestatus[i]);
			rs1 = pstmt.executeQuery();
			if (rs1.next())
			{		
				gcount[i] = rs1.getInt(1);*/
				
%>			
			<td class=rptValue><%=rs.getString(3)%></td>
			<% fcTotal+=rs.getInt(3); %>
			<td class=rptValue><%=rs.getString(4)%></td>
			<% ncTotal+=rs.getInt(4); %>
			<td class=rptValue><%=rs.getString(5)%></td>
			<% nssTotal+=rs.getInt(5); %>
			<td class=rptValue><%=rs.getString(6)%></td>
			<% pc1Total+=rs.getInt(6); %>
			<td class=rptValue><%=rs.getString(7)%></td>
			<% pc2Total+=rs.getInt(7); %>
			<td class=rptValue><%=rs.getString(8)%></td>
			<% pc3Total+=rs.getInt(8); %>
			<td class=rptValue><%=rs.getString(9)%></td>
			<% pc4Total+=rs.getInt(9); %>
			<td class=rptValue><%=rs.getString(10)%></td>
			<% uiTotal+=rs.getInt(10); %>
			</tr>
<%
			}//end of while
			rs.close();
			
			
		
		/*gcount1[0] = gcount1[0] + gcount[0];
		gcount1[1] = gcount1[1] + gcount[1];
		gcount1[2] = gcount1[2] + gcount[2];
		gcount1[3] = gcount1[3] + gcount[3];
		gcount1[4] = gcount1[4] + gcount[4];
		gcount1[5] = gcount1[5] + gcount[5];
		gcount1[6] = gcount1[6] + gcount[6];
		gcount1[7] = gcount1[7] + gcount[7];	

		*/
	
%>
</tr>
<%
	/*rs1.close();
	pstmt.close();
	}*/
%>

	<tr>
		<td class=btext colspan=3>Grand Total</td>
		<td class=btext><%=fcTotal%></td>
		<td class=btext><%=ncTotal%></td>
		<td class=btext><%=nssTotal%></td>
		<td class=btext><%=pc1Total%></td>
		<td class=btext><%=pc2Total%></td>
		<td class=btext><%=pc3Total%></td>
		<td class=btext><%=pc4Total%></td>
		<td class=btext><%=uiTotal%></td>
	</tr>
</table>
<%
}
catch(Exception e)
{
	//System.out.println("The Error Is In rws_const_coverage_rpt.jsp" +e);
}
finally{
if(conn!=null)
conn.close();
}
			
%>
<p align="center"><b><font face="Verdana" size="2">Designed and Developed By NIC APSC</b></font></p>
</form>
</body>
</html>
<%
	conn.close();
%>