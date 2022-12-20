<%@ include file="conn.jsp"%>
<%
	//////System.out.println("*****REPORT BEGINING*****");
	ArrayList resultList = new ArrayList();
	ArrayList resultList1 = new ArrayList();
	String[] recordList=null;
	String[] recordList1=null;
	Statement stmt2 = null;
	Statement stmt3 = null;
	String rDistrict=null, rMandal=null, rPanchayat=null, rVillage=null, rHabitation=null,q1=null;
	rDistrict = request.getParameter("district");
	rMandal = request.getParameter("mandal");
	rPanchayat = request.getParameter("panchayat");
	rVillage = request.getParameter("village");
	rHabitation = request.getParameter("habitation");	
	String districtName = String.valueOf(session.getAttribute("districtName"));
	String mandalName = String.valueOf(session.getAttribute("mandalName"));
	String panchayatName = String.valueOf(session.getAttribute("panchayatName"));
	String villageName = String.valueOf(session.getAttribute("villageName"));
	String habitationName = String.valueOf(session.getAttribute("habitationName"));
	
	String query=null;
	ResultSetMetaData rsm = null;
	Statement stmt1 = null;	
	int Count = 0;
try
{
	stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
	if(rDistrict.equals("00"))
{
    	////System.out.println("IN DISTRICT ALL SELECTION...");		
		query = " SELECT D.DCODE, D.DNAME, C.CONSTITUENCY_CODE, C.CONSTITUENCY_NAME, M.MCODE, M.MNAME, D.DIVISION_OFFICE_NAME, V.VCODE, V.VNAME, SUBSTR(HD.HAB_CODE,11,2), PR.PANCH_NAME, P.PCODE, P.PNAME, SUBSTR(PR.PANCH_CODE,15,2),CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU, HD.CENSUS_SC_POPU, HD.CENSUS_ST_POPU, NVL(HD.COVERAGE_STATUS, '---') FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL PR, RWS_MANDAL_TBL M, RWS_PANCHAYAT_TBL P, RWS_VILLAGE_TBL V, RWS_CONSTITUENCY_TBL C, RWS_DIVISION_OFFICE_TBL D WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND SUBSTR(HD.HAB_CODE,6,2) = M.MCODE AND D.DCODE = M.DCODE AND SUBSTR(HD.HAB_CODE,13,2) = P.PCODE AND P.DCODE = D.DCODE AND P.MCODE = M.MCODE AND SUBSTR(HD.HAB_CODE,8,3) = V.VCODE AND V.DCODE = D.DCODE AND V.MCODE = M.MCODE AND V.PCODE = P.PCODE AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND C.CONSTITUENCY_TYPE = 'A' AND HD.HAB_CODE = PR.PANCH_CODE  AND D.DIVISION_OFFICE_CODE = HD.DIVISION_OFFICE_CODE AND D.CIRCLE_OFFICE_CODE = HD.CIRCLE_OFFICE_CODE ORDER BY HD.HAB_CODE " ;

		 q1="select distinct a.acode,a.parlc,b.constituency_code,b.constituency_name from rws_habmast_tbl a,rws_constituency_tbl b where a.acode=b.constituency_code and constituency_type='A'";
	}
	if(!rDistrict.equals("00") && !rDistrict.equals("-1") && rMandal.equals("-1"))
	{
		////System.out.println("IN DISTRICT SELECTION...");
		query = "SELECT D.DCODE, D.DNAME, C.CONSTITUENCY_CODE, C.CONSTITUENCY_NAME, M.MCODE, M.MNAME, D.DIVISION_OFFICE_NAME, V.VCODE, V.VNAME, SUBSTR(HD.HAB_CODE,11,2), PR.PANCH_NAME, P.PCODE, P.PNAME, SUBSTR(PR.PANCH_CODE,15,2), CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU, HD.CENSUS_SC_POPU, HD.CENSUS_ST_POPU, NVL(HD.COVERAGE_STATUS, '---') FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL PR, RWS_MANDAL_TBL M, RWS_PANCHAYAT_TBL P, RWS_VILLAGE_TBL V, RWS_CONSTITUENCY_TBL C, RWS_DIVISION_OFFICE_TBL D WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND SUBSTR(HD.HAB_CODE,6,2) = M.MCODE AND D.DCODE = M.DCODE AND SUBSTR(HD.HAB_CODE,13,2) = P.PCODE AND P.DCODE = D.DCODE AND P.MCODE = M.MCODE AND SUBSTR(HD.HAB_CODE,8,3) = V.VCODE AND V.DCODE = D.DCODE AND V.MCODE = M.MCODE AND V.PCODE = P.PCODE AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND C.CONSTITUENCY_TYPE = 'A' AND HD.HAB_CODE = PR.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' AND D.DIVISION_OFFICE_CODE = HD.DIVISION_OFFICE_CODE AND D.CIRCLE_OFFICE_CODE = HD.CIRCLE_OFFICE_CODE ORDER BY HD.HAB_CODE";

		 q1="select distinct a.acode,a.parlc,b.constituency_code,b.constituency_name from rws_habmast_tbl a,rws_constituency_tbl b where a.acode=b.constituency_code and constituency_type='A'";
	}
	if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && rMandal.equals("00") && rPanchayat.equals("-1"))
	{
		////System.out.println("IN MANDAL ALL SELECTION...");		
		query = "SELECT D.DCODE, D.DNAME, C.CONSTITUENCY_CODE, C.CONSTITUENCY_NAME, M.MCODE, M.MNAME,D.DIVISION_OFFICE_NAME, V.VCODE, V.VNAME, SUBSTR(HD.HAB_CODE,11,2), PR.PANCH_NAME, P.PCODE, P.PNAME, SUBSTR(PR.PANCH_CODE,15,2), CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU, HD.CENSUS_SC_POPU, HD.CENSUS_ST_POPU, NVL(HD.COVERAGE_STATUS, '---') FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL PR, RWS_MANDAL_TBL M, RWS_PANCHAYAT_TBL P, RWS_VILLAGE_TBL V, RWS_CONSTITUENCY_TBL C, RWS_DIVISION_OFFICE_TBL D WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND SUBSTR(HD.HAB_CODE,6,2) = M.MCODE AND D.DCODE = M.DCODE AND SUBSTR(HD.HAB_CODE,13,2) = P.PCODE AND P.DCODE = D.DCODE AND P.MCODE = M.MCODE AND SUBSTR(HD.HAB_CODE,8,3) = V.VCODE AND V.DCODE = D.DCODE AND V.MCODE = M.MCODE AND V.PCODE = P.PCODE AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND C.CONSTITUENCY_TYPE = 'A' AND HD.HAB_CODE = PR.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' AND D.DIVISION_OFFICE_CODE = HD.DIVISION_OFFICE_CODE AND D.CIRCLE_OFFICE_CODE = HD.CIRCLE_OFFICE_CODE ORDER BY HD.HAB_CODE";

		 q1="select distinct a.acode,a.parlc,b.constituency_code,b.constituency_name from rws_habmast_tbl a,rws_constituency_tbl b where a.acode=b.constituency_code and constituency_type='A'and a.dcode='"+rDistrict+"'";
	}
	if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && rPanchayat.equals("-1"))
	{
		////System.out.println("IN MANDAL SELECTION...");
		query = "SELECT D.DCODE, D.DNAME, C.CONSTITUENCY_CODE, C.CONSTITUENCY_NAME, M.MCODE, M.MNAME,D.DIVISION_OFFICE_NAME, V.VCODE, V.VNAME, SUBSTR(HD.HAB_CODE,11,2), PR.PANCH_NAME, P.PCODE, P.PNAME, SUBSTR(PR.PANCH_CODE,15,2),CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU, HD.CENSUS_SC_POPU, HD.CENSUS_ST_POPU, NVL(HD.COVERAGE_STATUS, '---') FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL PR, RWS_MANDAL_TBL M, RWS_PANCHAYAT_TBL P, RWS_VILLAGE_TBL V, RWS_CONSTITUENCY_TBL C, RWS_DIVISION_OFFICE_TBL D  WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND SUBSTR(HD.HAB_CODE,6,2) = M.MCODE AND D.DCODE = M.DCODE AND SUBSTR(HD.HAB_CODE,13,2) = P.PCODE AND P.DCODE = D.DCODE AND P.MCODE = M.MCODE AND SUBSTR(HD.HAB_CODE,8,3) = V.VCODE AND V.DCODE = D.DCODE AND V.MCODE = M.MCODE AND V.PCODE = P.PCODE AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND C.CONSTITUENCY_TYPE = 'A' AND HD.HAB_CODE = PR.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' AND SUBSTR(HD.HAB_CODE,6,2) = '"+rMandal+"' AND D.DIVISION_OFFICE_CODE = HD.DIVISION_OFFICE_CODE AND D.CIRCLE_OFFICE_CODE = HD.CIRCLE_OFFICE_CODE  ORDER BY HD.HAB_CODE ";

		  q1="select distinct a.acode,a.parlc,b.constituency_code,b.constituency_name from rws_habmast_tbl a,rws_constituency_tbl b where a.acode=b.constituency_code and constituency_type='A' and a.dcode='"+rDistrict+"' and a.mcode='"+rMandal+"'";
	}
	if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && rPanchayat.equals("00"))
	{
		////System.out.println("IN PANCHAYAT ALL SELECTION...");
		query = "SELECT D.DCODE, D.DNAME, C.CONSTITUENCY_CODE, C.CONSTITUENCY_NAME, M.MCODE, M.MNAME,D.DIVISION_OFFICE_NAME, V.VCODE, V.VNAME, SUBSTR(HD.HAB_CODE,11,2), PR.PANCH_NAME, P.PCODE, P.PNAME, SUBSTR(PR.PANCH_CODE,15,2),CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU, HD.CENSUS_SC_POPU, HD.CENSUS_ST_POPU, NVL(HD.COVERAGE_STATUS, '---'), HD.NEAR_SURFACE_SOURCE FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL PR, RWS_MANDAL_TBL M, RWS_PANCHAYAT_TBL P, RWS_VILLAGE_TBL V, RWS_CONSTITUENCY_TBL C, RWS_DIVISION_OFFICE_TBL D  WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND SUBSTR(HD.HAB_CODE,6,2) = M.MCODE AND D.DCODE = M.DCODE AND SUBSTR(HD.HAB_CODE,13,2) = P.PCODE AND P.DCODE = D.DCODE AND P.MCODE = M.MCODE AND SUBSTR(HD.HAB_CODE,8,3) = V.VCODE AND V.DCODE = D.DCODE AND V.MCODE = M.MCODE AND V.PCODE = P.PCODE AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND C.CONSTITUENCY_TYPE = 'A' AND HD.HAB_CODE = PR.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' AND SUBSTR(HD.HAB_CODE,6,2) = '"+rMandal+"' AND D.DIVISION_OFFICE_CODE = HD.DIVISION_OFFICE_CODE AND D.CIRCLE_OFFICE_CODE = HD.CIRCLE_OFFICE_CODE  ORDER BY HD.HAB_CODE ";

         q1="select distinct a.acode,a.parlc,b.constituency_code,b.constituency_name from rws_habmast_tbl a,rws_constituency_tbl b where a.acode=b.constituency_code and constituency_type='A' and a.dcode='"+rDistrict+"' and a.mcode='"+rMandal+"'";
        }
	if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && rVillage.equals("-1"))
	{
		////System.out.println("IN PANCHAYAT SELECTION...");
		query = "SELECT D.DCODE, D.DNAME, C.CONSTITUENCY_CODE, C.CONSTITUENCY_NAME, M.MCODE, M.MNAME,D.DIVISION_OFFICE_NAME, V.VCODE, V.VNAME, SUBSTR(HD.HAB_CODE,11,2), PR.PANCH_NAME, P.PCODE, P.PNAME, SUBSTR(PR.PANCH_CODE,15,2),CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU, HD.CENSUS_SC_POPU, HD.CENSUS_ST_POPU, NVL(HD.COVERAGE_STATUS, '---')FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL PR, RWS_MANDAL_TBL M, RWS_PANCHAYAT_TBL P, RWS_VILLAGE_TBL V, RWS_CONSTITUENCY_TBL C, RWS_DIVISION_OFFICE_TBL D   WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND SUBSTR(HD.HAB_CODE,6,2) = M.MCODE AND D.DCODE = M.DCODE AND SUBSTR(HD.HAB_CODE,13,2) = P.PCODE AND P.DCODE = D.DCODE AND P.MCODE = M.MCODE AND SUBSTR(HD.HAB_CODE,8,3) = V.VCODE AND V.DCODE = D.DCODE AND V.MCODE = M.MCODE AND V.PCODE = P.PCODE AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND C.CONSTITUENCY_TYPE = 'A' AND HD.HAB_CODE = PR.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' AND SUBSTR(HD.HAB_CODE,6,2) = '"+rMandal+"' AND SUBSTR(HD.HAB_CODE,13,2) = '"+rPanchayat+"' AND D.DIVISION_OFFICE_CODE = HD.DIVISION_OFFICE_CODE AND D.CIRCLE_OFFICE_CODE = HD.CIRCLE_OFFICE_CODE   ORDER BY HD.HAB_CODE ";

		 q1="select distinct a.acode,a.parlc,b.constituency_code,b.constituency_name from rws_habmast_tbl a,rws_constituency_tbl b where a.acode=b.constituency_code and constituency_type='A' and a.dcode='"+rDistrict+"' and a.mcode='"+rMandal+"' and a.pcode='"+rPanchayat+"'";
	}
	if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && !rVillage.equals("-1") && rVillage.equals("00"))
	{
		////System.out.println("IN VILLAGE ALL SELECTION...");
		query = "SELECT D.DCODE, D.DNAME, C.CONSTITUENCY_CODE, C.CONSTITUENCY_NAME, M.MCODE, M.MNAME,D.DIVISION_OFFICE_NAME, V.VCODE, V.VNAME, SUBSTR(HD.HAB_CODE,11,2), PR.PANCH_NAME, P.PCODE, P.PNAME, SUBSTR(PR.PANCH_CODE,15,2),CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU, HD.CENSUS_SC_POPU, HD.CENSUS_ST_POPU, NVL(HD.COVERAGE_STATUS, '---') FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL PR, RWS_MANDAL_TBL M, RWS_PANCHAYAT_TBL P, RWS_VILLAGE_TBL V, RWS_CONSTITUENCY_TBL C, RWS_DIVISION_OFFICE_TBL D   WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND SUBSTR(HD.HAB_CODE,6,2) = M.MCODE AND D.DCODE = M.DCODE AND SUBSTR(HD.HAB_CODE,13,2) = P.PCODE AND P.DCODE = D.DCODE AND P.MCODE = M.MCODE AND SUBSTR(HD.HAB_CODE,8,3) = V.VCODE AND V.DCODE = D.DCODE AND V.MCODE = M.MCODE AND V.PCODE = P.PCODE AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND C.CONSTITUENCY_TYPE = 'A' AND HD.HAB_CODE = PR.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' AND SUBSTR(HD.HAB_CODE,6,2) = '"+rMandal+"' AND SUBSTR(HD.HAB_CODE,13,2) = '"+rPanchayat+"' AND D.DIVISION_OFFICE_CODE = HD.DIVISION_OFFICE_CODE AND D.CIRCLE_OFFICE_CODE = HD.CIRCLE_OFFICE_CODE   ORDER BY HD.HAB_CODE ";

		q1="select distinct a.acode,a.parlc,b.constituency_code,b.constituency_name from rws_habmast_tbl a,rws_constituency_tbl b where a.acode=b.constituency_code and constituency_type='A'and a.dcode='"+rDistrict+"' and a.mcode='"+rMandal+"' and a.pcode='"+rPanchayat+"'";
	}
	if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && !rVillage.equals("-1") && !rVillage.equals("00") && rHabitation.equals("-1"))
	{
		////System.out.println("IN VILLAGE SELECTION...");
		query = "SELECT D.DCODE, D.DNAME, C.CONSTITUENCY_CODE, C.CONSTITUENCY_NAME, M.MCODE, M.MNAME, D.DIVISION_OFFICE_NAME, V.VCODE, V.VNAME, SUBSTR(HD.HAB_CODE,11,2), PR.PANCH_NAME, P.PCODE, P.PNAME, SUBSTR(PR.PANCH_CODE,15,2),CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU, HD.CENSUS_SC_POPU, HD.CENSUS_ST_POPU, NVL(HD.COVERAGE_STATUS, '---') FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL PR, RWS_MANDAL_TBL M, RWS_PANCHAYAT_TBL P, RWS_VILLAGE_TBL V, RWS_CONSTITUENCY_TBL C, RWS_DIVISION_OFFICE_TBL D    WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND SUBSTR(HD.HAB_CODE,6,2) = M.MCODE AND D.DCODE = M.DCODE AND SUBSTR(HD.HAB_CODE,13,2) = P.PCODE AND P.DCODE = D.DCODE AND P.MCODE = M.MCODE AND SUBSTR(HD.HAB_CODE,8,3) = V.VCODE AND V.DCODE = D.DCODE AND V.MCODE = M.MCODE AND V.PCODE = P.PCODE AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND C.CONSTITUENCY_TYPE = 'A' AND HD.HAB_CODE = PR.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' AND SUBSTR(HD.HAB_CODE,6,2) = '"+rMandal+"' AND SUBSTR(HD.HAB_CODE,13,2) = '"+rPanchayat+"' AND SUBSTR(HD.HAB_CODE,8,3) = '"+rVillage+"' AND D.DIVISION_OFFICE_CODE = HD.DIVISION_OFFICE_CODE AND D.CIRCLE_OFFICE_CODE = HD.CIRCLE_OFFICE_CODE    ORDER BY HD.HAB_CODE ";

		q1="select distinct a.acode,a.parlc,b.constituency_code,b.constituency_name from rws_habmast_tbl a,rws_constituency_tbl b where a.acode=b.constituency_code and constituency_type='A' and a.dcode='"+rDistrict+"' and a.mcode='"+rMandal+"' and a.pcode='"+rPanchayat+"' and a.vcode='"+rVillage+"'";
	}
	if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && !rVillage.equals("-1") && !rVillage.equals("00") && !rHabitation.equals("-1") && rHabitation.equals("00"))
	{
		////System.out.println("IN HABITATION ALL SELECTION...");
		query = "SELECT D.DCODE, D.DNAME, C.CONSTITUENCY_CODE, C.CONSTITUENCY_NAME, M.MCODE, M.MNAME,D.DIVISION_OFFICE_NAME, V.VCODE, V.VNAME, SUBSTR(HD.HAB_CODE,11,2), PR.PANCH_NAME, P.PCODE, P.PNAME, SUBSTR(PR.PANCH_CODE,15,2),CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU, HD.CENSUS_SC_POPU, HD.CENSUS_ST_POPU, NVL(HD.COVERAGE_STATUS, '---')FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL PR, RWS_MANDAL_TBL M, RWS_PANCHAYAT_TBL P, RWS_VILLAGE_TBL V, RWS_CONSTITUENCY_TBL C, RWS_DIVISION_OFFICE_TBL D    WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND SUBSTR(HD.HAB_CODE,6,2) = M.MCODE AND D.DCODE = M.DCODE AND SUBSTR(HD.HAB_CODE,13,2) = P.PCODE AND P.DCODE = D.DCODE AND P.MCODE = M.MCODE AND SUBSTR(HD.HAB_CODE,8,3) = V.VCODE AND V.DCODE = D.DCODE AND V.MCODE = M.MCODE AND V.PCODE = P.PCODE AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND C.CONSTITUENCY_TYPE = 'A' AND HD.HAB_CODE = PR.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' AND SUBSTR(HD.HAB_CODE,6,2) = '"+rMandal+"' AND SUBSTR(HD.HAB_CODE,13,2) = '"+rPanchayat+"' AND SUBSTR(HD.HAB_CODE,8,3) = '"+rVillage+"' AND D.DIVISION_OFFICE_CODE = HD.DIVISION_OFFICE_CODE AND D.CIRCLE_OFFICE_CODE = HD.CIRCLE_OFFICE_CODE    ORDER BY HD.HAB_CODE ";
        
		q1="select distinct a.acode,a.parlc,b.constituency_code,b.constituency_name from rws_habmast_tbl a,rws_constituency_tbl b where a.acode=b.constituency_code and constituency_type='A' and a.dcode='"+rDistrict+"' and a.mcode='"+rMandal+"' and a.pcode='"+rPanchayat+"' and a.vcode='"+rVillage+"'";

	}
	if(!rDistrict.equals("00") && !rDistrict.equals("-1") && !rMandal.equals("-1") && !rMandal.equals("00") && !rPanchayat.equals("-1") && !rPanchayat.equals("00") && !rVillage.equals("-1") && !rVillage.equals("00") && !rHabitation.equals("-1") && !rHabitation.equals("00"))
	{
		////System.out.println("IN HABITATION SELECTION...");
		query = "SELECT D.DCODE, D.DNAME, C.CONSTITUENCY_CODE, C.CONSTITUENCY_NAME, M.MCODE, M.MNAME, D.DIVISION_OFFICE_NAME, V.VCODE, V.VNAME, SUBSTR(HD.HAB_CODE,11,2), PR.PANCH_NAME, P.PCODE, P.PNAME, SUBSTR(PR.PANCH_CODE,15,2), CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU, HD.CENSUS_SC_POPU, HD.CENSUS_ST_POPU, NVL(HD.COVERAGE_STATUS, '---') FROM RWS_DISTRICT_TBL D, RWS_HABITATION_DIRECTORY_TBL HD, RWS_PANCHAYAT_RAJ_TBL PR, RWS_MANDAL_TBL M, RWS_PANCHAYAT_TBL P, RWS_VILLAGE_TBL V, RWS_CONSTITUENCY_TBL C, RWS_DIVISION_OFFICE_TBL D WHERE SUBSTR(HD.HAB_CODE,1,2) = D.DCODE AND SUBSTR(HD.HAB_CODE,6,2) = M.MCODE AND D.DCODE = M.DCODE AND SUBSTR(HD.HAB_CODE,13,2) = P.PCODE AND P.DCODE = D.DCODE AND P.MCODE = M.MCODE AND SUBSTR(HD.HAB_CODE,8,3) = V.VCODE AND V.DCODE = D.DCODE AND V.MCODE = M.MCODE AND V.PCODE = P.PCODE AND SUBSTR(HD.HAB_CODE,3,3) = C.CONSTITUENCY_CODE AND C.DCODE = SUBSTR(HD.HAB_CODE,1,2) AND C.CONSTITUENCY_TYPE = 'A' AND HD.HAB_CODE = PR.PANCH_CODE AND SUBSTR(HD.HAB_CODE,1,2) = '"+rDistrict+"' AND SUBSTR(HD.HAB_CODE,6,2) = '"+rMandal+"' AND SUBSTR(HD.HAB_CODE,13,2) = '"+rPanchayat+"' AND SUBSTR(HD.HAB_CODE,8,3) = '"+rVillage+"' AND HD.HAB_CODE = '"+rHabitation+"'  AND D.DIVISION_OFFICE_CODE = HD.DIVISION_OFFICE_CODE AND D.CIRCLE_OFFICE_CODE = HD.CIRCLE_OFFICE_CODE  ORDER BY HD.HAB_CODE ";

		q1="select distinct a.acode,a.parlc,b.constituency_code,b.constituency_name from rws_habmast_tbl a,rws_constituency_tbl b where a.acode=b.constituency_code and constituency_type='A' and a.dcode='"+rDistrict+"' and a.mcode='"+rMandal+"' and a.pcode='"+rPanchayat+"' and a.vcode='"+rVillage+"' and a.HAB_CODE = '"+rHabitation+"'";
	}	
	////System.out.println("query is  "+query);
	rs = stmt.executeQuery(query);
	rsm = rs.getMetaData();
	Count = rsm.getColumnCount();
	while(rs.next())
	{
		
		 recordList = new String[Count];
			for(int s=0, c=1; s < recordList.length; s++, c++)
			{		
				// ////System.out.println("code is"+rs.getString(7));
				recordList[s] = rs.getString(c);
				
			}
			resultList.add(recordList);
	}
		session.setAttribute("arrayList", resultList);
    ////System.out.println("second query "+q1);
	try{
    ResultSet rset= stmt.executeQuery(q1);
	////System.out.println("HERE....");
	while(rset.next())
	{
		
		String q2="select nvl(substr(constituency_code,2,2),'-'),nvl(constituency_name,'-') from rws_constituency_tbl where substr(constituency_code,2,2)='"+rset.getString(2)+"'and constituency_type='P'";
		////System.out.println("q2 is"+q2);
		ResultSet rset1= stmt.executeQuery(q2);
		rsm = rset1.getMetaData();
	    Count = rsm.getColumnCount();
		recordList1 = new String[Count];
		while(rset1.next())
			{
			////System.out.println("conname"+rset1.getString(1));
			for(int s=0,c=1; s < recordList1.length; s++,c++)
			{				
				recordList1[s] = rset1.getString(c);
				////System.out.println("recordList1[s]" + recordList1[s]);
			}
			
			resultList1.add(recordList1);
			
		}
		////System.out.println("Ps"+resultList1.size());
		session.setAttribute("format1", resultList1);  
		
        }
	}
		catch(Exception e)
		{
			//out.println("PPPPPPPPPP"+e);
		}
		
		//session.setAttribute("format2", rset); 
		
	%>
<%@ include file = "rws_planning_format1_rpt_temp.jsp" %>
	<%}
catch(Exception e)
{

	////System.out.println("THE ERROR IN REPORT = " + e);
}
finally
{
conn.close();
}%>





