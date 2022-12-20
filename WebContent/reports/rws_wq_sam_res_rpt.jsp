<%@ include file = "conn.jsp" %>
<%@ include file = "header_rpt.jsp" %>


<%
	try{
		String dCode = String.valueOf(session.getAttribute("dCode"));
		String dName = String.valueOf(session.getAttribute("dName"));
		String mCode = String.valueOf(session.getAttribute("mCode"));
		String mName = String.valueOf(session.getAttribute("mName"));
		String pCode = String.valueOf(session.getAttribute("pCode"));
		String pName = String.valueOf(session.getAttribute("pName"));
		String vCode = String.valueOf(session.getAttribute("vCode"));
		String vName = String.valueOf(session.getAttribute("vName"));
		String hCode = String.valueOf(session.getAttribute("hCode"));
		String hName = String.valueOf(session.getAttribute("hName"));
		String query="";
		//System.out.println("in rpt of sample .......sridhar");

	
		
		nic.watersoft.commons.RwsOffices rwsOffices = new nic.watersoft.commons.RwsOffices();
		String fromDate = request.getParameter("fromdate");		
		String toDate = request.getParameter("todate");
		
		String dcode = request.getParameter("district");
		String mcode = request.getParameter("mandal");
		String pcode = request.getParameter("panchayat");
		//System.out.println("PANCHAYAT = " + pcode);
		String vcode = request.getParameter("village");
		//System.out.println("VILLAGE = " + vcode);
		String hcode = request.getParameter("habitation");
		//System.out.println("Habitaton = "+hcode);
		//RwsOffices rwsOffices = new RwsOffices(dataSource);
		//System.out.println("in rpt of sample .......sridhar1");
		stmt = conn.createStatement();
			//System.out.println("dcode = "+dcode); 
			
		if(dcode.equals("40") && !fromDate.equals("00") && !toDate.equals("00"))
		{
			//System.out.println("FOR ALL DISTRICTS...");
			query = "SELECT sam.TEST_ID, sam.HAB_CODE, pr.PANCH_NAME, sam.SOURCE_CODE,"
			+ " nvl(sr.SOURCE_NAME,'-'), sam.TEST_CODE, tes.TEST_NAME," 
			+ " DECODE(sam.NATURE_OF_TEST, '1', 'ROUTINE', '2', 'SEASONAL', '3', 'QUARTERLY',"
			+ " '4', 'DISEASE OUTBREAK'), sam.LAB_CODE, lab.LAB_NAME, 1 || sam.CIRCLE_OFFICE_CODE ||"
			+ " sam.DIVISION_OFFICE_CODE || sam.SUBDIVISION_OFFICE_CODE, sam.SAMP_COLLECTOR_CODE,"
			+ " des.DESIGNATION_NAME, TO_CHAR(sam.SAMP_COLLECT_DATE, 'dd/MM/yyyy'),"
			+ " TO_CHAR(sam.ASSIGNED_ON, 'dd/MM/yyyy'), sam.PREPARED_BY,"
			+ " TO_CHAR(sam.PREPARED_ON, 'dd/MM/yyyy'),lab.LOCATION,decode (sam.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE', '0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002', 'MPWSSURFACE','0301003','MPWSPUMPSETS ' ,'0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS', '0701 001','PONDS','0801001','OTHERS') as sname FROM "
			+ " RWS_WATER_SAMPLE_COLLECT_TBL"
			+ " sam,"
			+ " RWS_PANCHAYAT_RAJ_TBL pr, RWS_SOURCE_TBL sr, RWS_WATER_QUALITY_TEST_TBL tes," 
			+ " RWS_WATER_QUALITY_LAB_TBL lab,RWS_DESIGNATION_TBL des" 
			+ " WHERE sam.HAB_CODE = pr.PANCH_CODE AND sam.SOURCE_CODE = sr.SOURCE_CODE AND"
			+ " sam.TEST_CODE = tes.TEST_CODE AND sam.LAB_CODE = lab.LAB_CODE AND"
			+ " sam.SAMP_COLLECTOR_CODE = des.DESIGNATION_CODE"
			+ " AND sam.SAMP_COLLECT_DATE BETWEEN to_date('"+fromDate+"', 'dd/MM/yyyy') AND" 
			+ " to_date('"+toDate+"', 'dd/MM/yyyy')  and  sam.DIVISION_OFFICE_CODE || sam.SUBDIVISION_OFFICE_CODE  is not null ORDER BY sam.TEST_ID";
		}
		if(!dcode.equals("40") && !dcode.equals("00") && !fromDate.equals("00") && !toDate.equals("00") && !mcode.equals("5555") && mcode.equals("00"))
		{
			//System.out.println("FOR PERTICULAR DISTRICT...");	
			query = "SELECT sam.TEST_ID, sam.HAB_CODE, pr.PANCH_NAME, sam.SOURCE_CODE,"
			+ " nvl(sr.SOURCE_NAME,'-'), sam.TEST_CODE, tes.TEST_NAME," 
			+ " DECODE(sam.NATURE_OF_TEST, '1', 'ROUTINE', '2', 'SEASONAL', '3', 'QUARTERLY',"
			+ " '4', 'DISEASE OUTBREAK'), sam.LAB_CODE, lab.LAB_NAME, 1 || sam.CIRCLE_OFFICE_CODE ||"
			+ " sam.DIVISION_OFFICE_CODE || sam.SUBDIVISION_OFFICE_CODE, sam.SAMP_COLLECTOR_CODE,"
			+ " des.DESIGNATION_NAME, TO_CHAR(sam.SAMP_COLLECT_DATE, 'dd/MM/yyyy'),"
			+ " TO_CHAR(sam.ASSIGNED_ON, 'dd/MM/yyyy'), sam.PREPARED_BY, "
			+ " TO_CHAR(sam.PREPARED_ON, 'dd/MM/yyyy'),lab.LOCATION,decode (sam.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE', '0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002', 'MPWSSURFACE','0301003','MPWSPUMPSETS ' ,'0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS', '0701 001','PONDS','0801001','OTHERS') as sname FROM "
			+ " RWS_WATER_SAMPLE_COLLECT_TBL"
			+ " sam,"
			+ " RWS_PANCHAYAT_RAJ_TBL pr, RWS_SOURCE_TBL sr, RWS_WATER_QUALITY_TEST_TBL tes," 
			+ " RWS_WATER_QUALITY_LAB_TBL lab, RWS_DESIGNATION_TBL des" 
			+ " WHERE sam.HAB_CODE = pr.PANCH_CODE AND sam.SOURCE_CODE = sr.SOURCE_CODE AND"
			+ " sam.TEST_CODE = tes.TEST_CODE AND sam.LAB_CODE = lab.LAB_CODE AND"
			+ "   sam.SAMP_COLLECTOR_CODE = des.DESIGNATION_CODE"
			+ " AND sam.SAMP_COLLECT_DATE BETWEEN to_date('"+fromDate+"', 'dd/MM/yyyy') AND" 
			+ " to_date('"+toDate+"', 'dd/MM/yyyy') AND SUBSTR(sam.HAB_CODE,1,2) = '"+dcode+"' "
			+ "  and  sam.DIVISION_OFFICE_CODE || sam.SUBDIVISION_OFFICE_CODE  is not null ORDER BY sam.TEST_ID";				
		}
		if(!dcode.equals("40") && !dcode.equals("00") && !fromDate.equals("00") && !toDate.equals("00") && mcode.equals("5555"))
		{
			//System.out.println("FOR ALL MANDALS...");
			query = "SELECT sam.TEST_ID, sam.HAB_CODE, pr.PANCH_NAME, sam.SOURCE_CODE,"
			+ " nvl(sr.SOURCE_NAME,'-'), sam.TEST_CODE, tes.TEST_NAME," 
			+ " DECODE(sam.NATURE_OF_TEST, '1', 'ROUTINE', '2', 'SEASONAL', '3', 'QUARTERLY',"
			+ " '4', 'DISEASE OUTBREAK'), sam.LAB_CODE, lab.LAB_NAME, 1 || sam.CIRCLE_OFFICE_CODE ||"
			+ " sam.DIVISION_OFFICE_CODE || sam.SUBDIVISION_OFFICE_CODE, sam.SAMP_COLLECTOR_CODE,"
			+ " des.DESIGNATION_NAME, TO_CHAR(sam.SAMP_COLLECT_DATE, 'dd/MM/yyyy'),"
			+ " TO_CHAR(sam.ASSIGNED_ON, 'dd/MM/yyyy'), sam.PREPARED_BY, "
			+ " TO_CHAR(sam.PREPARED_ON, 'dd/MM/yyyy'),lab.LOCATION,decode (sam.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE', '0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002', 'MPWSSURFACE','0301003','MPWSPUMPSETS ' ,'0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS', '0701 001','PONDS','0801001','OTHERS') as sname FROM "
			+ " RWS_WATER_SAMPLE_COLLECT_TBL"
			+ " sam,"
			+ " RWS_PANCHAYAT_RAJ_TBL pr, RWS_SOURCE_TBL sr, RWS_WATER_QUALITY_TEST_TBL tes," 
			+ " RWS_WATER_QUALITY_LAB_TBL lab, RWS_DESIGNATION_TBL des" 
			+ " WHERE sam.HAB_CODE = pr.PANCH_CODE AND sam.SOURCE_CODE = sr.SOURCE_CODE AND"
			+ " sam.TEST_CODE = tes.TEST_CODE AND sam.LAB_CODE = lab.LAB_CODE AND"
			+ "  sam.SAMP_COLLECTOR_CODE = des.DESIGNATION_CODE"
			+ " AND sam.SAMP_COLLECT_DATE BETWEEN to_date('"+fromDate+"', 'dd/MM/yyyy') AND" 
			+ " to_date('"+toDate+"', 'dd/MM/yyyy') AND SUBSTR(sam.HAB_CODE,1,2) = '"+dcode+"' "
			+ " and  sam.DIVISION_OFFICE_CODE || sam.SUBDIVISION_OFFICE_CODE  is not null ORDER BY sam.TEST_ID";
		}
		if(!dcode.equals("40") && !dcode.equals("00") && !fromDate.equals("00") && !toDate.equals("00") && !mcode.equals("5555") && !mcode.equals("00") && pcode.equals("00"))
		{
			//System.out.println("FOR PERTICULAR MANDAL...");
			query = "SELECT sam.TEST_ID, sam.HAB_CODE, pr.PANCH_NAME, sam.SOURCE_CODE,"
			+ " nvl(sr.SOURCE_NAME,'-'), sam.TEST_CODE, tes.TEST_NAME," 
			+ " DECODE(sam.NATURE_OF_TEST, '1', 'ROUTINE', '2', 'SEASONAL', '3', 'QUARTERLY',"
			+ " '4', 'DISEASE OUTBREAK'), sam.LAB_CODE, lab.LAB_NAME, 1 || sam.CIRCLE_OFFICE_CODE ||"
			+ " sam.DIVISION_OFFICE_CODE || sam.SUBDIVISION_OFFICE_CODE, sam.SAMP_COLLECTOR_CODE,"
			+ " des.DESIGNATION_NAME, TO_CHAR(sam.SAMP_COLLECT_DATE, 'dd/MM/yyyy'),"
			+ " TO_CHAR(sam.ASSIGNED_ON, 'dd/MM/yyyy'), sam.PREPARED_BY, "
			+ " TO_CHAR(sam.PREPARED_ON, 'dd/MM/yyyy'),lab.LOCATION,decode (sam.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE', '0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002', 'MPWSSURFACE','0301003','MPWSPUMPSETS ' ,'0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS', '0701 001','PONDS','0801001','OTHERS') as sname FROM "
			+ " RWS_WATER_SAMPLE_COLLECT_TBL"
			+ " sam,"
			+ " RWS_PANCHAYAT_RAJ_TBL pr, RWS_SOURCE_TBL sr, RWS_WATER_QUALITY_TEST_TBL tes," 
			+ " RWS_WATER_QUALITY_LAB_TBL lab, RWS_DESIGNATION_TBL des" 
			+ " WHERE sam.HAB_CODE = pr.PANCH_CODE AND sam.SOURCE_CODE = sr.SOURCE_CODE AND"
			+ " sam.TEST_CODE = tes.TEST_CODE AND sam.LAB_CODE = lab.LAB_CODE AND"
			+ "  sam.SAMP_COLLECTOR_CODE = des.DESIGNATION_CODE"
			+ " AND sam.SAMP_COLLECT_DATE BETWEEN to_date('"+fromDate+"', 'dd/MM/yyyy') AND" 
			+ " to_date('"+toDate+"', 'dd/MM/yyyy') AND SUBSTR(sam.HAB_CODE,1,2) = '"+dcode+"' AND "
			+ " SUBSTR(sam.HAB_CODE,6,2)= '"+mcode+"' and  sam.DIVISION_OFFICE_CODE || sam.SUBDIVISION_OFFICE_CODE  is not null ORDER BY sam.TEST_ID";
		}
		if(!dcode.equals("40") && !dcode.equals("00") && !fromDate.equals("00") && !toDate.equals("00") && !mcode.equals("5555") && !mcode.equals("00") && pcode.equals("66666"))
		{
			//System.out.println("FOR ALL PANCHAYAT...");
			query = "SELECT sam.TEST_ID, sam.HAB_CODE, pr.PANCH_NAME, sam.SOURCE_CODE,"
			+ " nvl(sr.SOURCE_NAME,'-'), sam.TEST_CODE, tes.TEST_NAME," 
			+ " DECODE(sam.NATURE_OF_TEST, '1', 'ROUTINE', '2', 'SEASONAL', '3', 'QUARTERLY',"
			+ " '4', 'DISEASE OUTBREAK'), sam.LAB_CODE, lab.LAB_NAME, 1 || sam.CIRCLE_OFFICE_CODE ||"
			+ " sam.DIVISION_OFFICE_CODE || sam.SUBDIVISION_OFFICE_CODE, sam.SAMP_COLLECTOR_CODE,"
			+ " des.DESIGNATION_NAME, TO_CHAR(sam.SAMP_COLLECT_DATE, 'dd/MM/yyyy'),"
			+ " TO_CHAR(sam.ASSIGNED_ON, 'dd/MM/yyyy'), sam.PREPARED_BY, "
			+ " TO_CHAR(sam.PREPARED_ON, 'dd/MM/yyyy'),lab.LOCATION,decode (sam.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE', '0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002', 'MPWSSURFACE','0301003','MPWSPUMPSETS ' ,'0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS', '0701 001','PONDS','0801001','OTHERS') as sname FROM "
			+ " RWS_WATER_SAMPLE_COLLECT_TBL"
			+ " sam,"
			+ " RWS_PANCHAYAT_RAJ_TBL pr, RWS_SOURCE_TBL sr, RWS_WATER_QUALITY_TEST_TBL tes," 
			+ " RWS_WATER_QUALITY_LAB_TBL lab, RWS_DESIGNATION_TBL des" 
			+ " WHERE sam.HAB_CODE = pr.PANCH_CODE AND sam.SOURCE_CODE = sr.SOURCE_CODE AND"
			+ " sam.TEST_CODE = tes.TEST_CODE AND sam.LAB_CODE = lab.LAB_CODE AND"
			+ "  sam.SAMP_COLLECTOR_CODE = des.DESIGNATION_CODE"
			+ " AND sam.SAMP_COLLECT_DATE BETWEEN to_date('"+fromDate+"', 'dd/MM/yyyy') AND" 
			+ " to_date('"+toDate+"', 'dd/MM/yyyy') AND SUBSTR(sam.HAB_CODE,1,2) = '"+dcode+"' AND "
			+ " SUBSTR(sam.HAB_CODE,6,2)= '"+mcode+"'  and  sam.DIVISION_OFFICE_CODE || sam.SUBDIVISION_OFFICE_CODE  is not null ORDER BY sam.TEST_ID";

		}
		if(!dcode.equals("40") && !dcode.equals("00") && !fromDate.equals("00") && !toDate.equals("00") && !mcode.equals("5555") && !mcode.equals("00") && !pcode.equals("66666") && !pcode.equals("00") && vcode.equals("000"))
		{
			//System.out.println("FOR PERTICULAR PANCHAYAT...");
			query = "SELECT sam.TEST_ID, sam.HAB_CODE, pr.PANCH_NAME, sam.SOURCE_CODE,"
			+ " nvl(sr.SOURCE_NAME,'-'), sam.TEST_CODE, tes.TEST_NAME," 
			+ " DECODE(sam.NATURE_OF_TEST, '1', 'ROUTINE', '2', 'SEASONAL', '3', 'QUARTERLY',"
			+ " '4', 'DISEASE OUTBREAK'), sam.LAB_CODE, lab.LAB_NAME, 1 || sam.CIRCLE_OFFICE_CODE ||"
			+ " sam.DIVISION_OFFICE_CODE || sam.SUBDIVISION_OFFICE_CODE, sam.SAMP_COLLECTOR_CODE,"
			+ " des.DESIGNATION_NAME, TO_CHAR(sam.SAMP_COLLECT_DATE, 'dd/MM/yyyy'),"
			+ " TO_CHAR(sam.ASSIGNED_ON, 'dd/MM/yyyy'), sam.PREPARED_BY, "
			+ " TO_CHAR(sam.PREPARED_ON, 'dd/MM/yyyy'),lab.LOCATION,decode (sam.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE', '0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002', 'MPWSSURFACE','0301003','MPWSPUMPSETS ' ,'0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS', '0701 001','PONDS','0801001','OTHERS') as sname FROM "
			+ " RWS_WATER_SAMPLE_COLLECT_TBL"
			+ " sam,"
			+ " RWS_PANCHAYAT_RAJ_TBL pr, RWS_SOURCE_TBL sr, RWS_WATER_QUALITY_TEST_TBL tes," 
			+ " RWS_WATER_QUALITY_LAB_TBL lab, RWS_DESIGNATION_TBL des" 
			+ " WHERE sam.HAB_CODE = pr.PANCH_CODE AND sam.SOURCE_CODE = sr.SOURCE_CODE AND"
			+ " sam.TEST_CODE = tes.TEST_CODE AND sam.LAB_CODE = lab.LAB_CODE AND"
			+ "  sam.SAMP_COLLECTOR_CODE = des.DESIGNATION_CODE"
			+ " AND sam.SAMP_COLLECT_DATE BETWEEN to_date('"+fromDate+"', 'dd/MM/yyyy') AND" 
			+ " to_date('"+toDate+"', 'dd/MM/yyyy') AND SUBSTR(sam.HAB_CODE,1,2) = '"+dcode+"' AND "
			+ " SUBSTR(sam.HAB_CODE,6,2)= '"+mcode+"' AND SUBSTR(sam.HAB_CODE,13,2)= '"+pcode+"' "
			+ "  and  sam.DIVISION_OFFICE_CODE || sam.SUBDIVISION_OFFICE_CODE  is not null ORDER BY sam.TEST_ID";

		}
		if(!dcode.equals("40") && !dcode.equals("00") && !fromDate.equals("00") && !toDate.equals("00") && !mcode.equals("5555") && !mcode.equals("00") && !pcode.equals("66666") && !pcode.equals("00") && vcode.equals("777777"))
		{
			//System.out.println("FOR ALL VILLAGES...");
			query = "SELECT sam.TEST_ID, sam.HAB_CODE, pr.PANCH_NAME, sam.SOURCE_CODE,"
			+ " nvl(sr.SOURCE_NAME,'-'), sam.TEST_CODE, tes.TEST_NAME," 
			+ " DECODE(sam.NATURE_OF_TEST, '1', 'ROUTINE', '2', 'SEASONAL', '3', 'QUARTERLY',"
			+ " '4', 'DISEASE OUTBREAK'), sam.LAB_CODE, lab.LAB_NAME, 1 || sam.CIRCLE_OFFICE_CODE ||"
			+ " sam.DIVISION_OFFICE_CODE || sam.SUBDIVISION_OFFICE_CODE, sam.SAMP_COLLECTOR_CODE,"
			+ " des.DESIGNATION_NAME, TO_CHAR(sam.SAMP_COLLECT_DATE, 'dd/MM/yyyy'),"
			+ " TO_CHAR(sam.ASSIGNED_ON, 'dd/MM/yyyy'), sam.PREPARED_BY, "
			+ " TO_CHAR(sam.PREPARED_ON, 'dd/MM/yyyy'),lab.LOCATION,decode (sam.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE', '0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002', 'MPWSSURFACE','0301003','MPWSPUMPSETS ' ,'0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS', '0701 001','PONDS','0801001','OTHERS') as sname FROM "
			+ " RWS_WATER_SAMPLE_COLLECT_TBL"
			+ " sam,"
			+ " RWS_PANCHAYAT_RAJ_TBL pr, RWS_SOURCE_TBL sr, RWS_WATER_QUALITY_TEST_TBL tes," 
			+ " RWS_WATER_QUALITY_LAB_TBL lab, RWS_DESIGNATION_TBL des" 
			+ " WHERE sam.HAB_CODE = pr.PANCH_CODE AND sam.SOURCE_CODE = sr.SOURCE_CODE AND"
			+ " sam.TEST_CODE = tes.TEST_CODE AND sam.LAB_CODE = lab.LAB_CODE AND"
			+ "  sam.SAMP_COLLECTOR_CODE = des.DESIGNATION_CODE"
			+ " AND sam.SAMP_COLLECT_DATE BETWEEN to_date('"+fromDate+"', 'dd/MM/yyyy') AND" 
			+ " to_date('"+toDate+"', 'dd/MM/yyyy') AND SUBSTR(sam.HAB_CODE,1,2) = '"+dcode+"' AND "
			+ " SUBSTR(sam.HAB_CODE,6,2) = '"+mcode+"' AND SUBSTR(sam.HAB_CODE,13,2) = '"+pcode+"' "
			+ "  and  sam.DIVISION_OFFICE_CODE || sam.SUBDIVISION_OFFICE_CODE  is not null ORDER BY sam.TEST_ID";

		}
		if(!dcode.equals("40") && !dcode.equals("00") && !fromDate.equals("00") && !toDate.equals("00") && !mcode.equals("5555") && !mcode.equals("00") && !pcode.equals("66666") && !pcode.equals("00") && !vcode.equals("777777") && !vcode.equals("000") && hcode.equals("00"))
		{
			//System.out.println("FOR PERTICULAR VILLAGE...");
			query = "SELECT sam.TEST_ID, sam.HAB_CODE, pr.PANCH_NAME, sam.SOURCE_CODE,"
			+ " nvl(sr.SOURCE_NAME,'-'), sam.TEST_CODE, tes.TEST_NAME," 
			+ " DECODE(sam.NATURE_OF_TEST, '1', 'ROUTINE', '2', 'SEASONAL', '3', 'QUARTERLY',"
			+ " '4', 'DISEASE OUTBREAK'), sam.LAB_CODE, lab.LAB_NAME, 1 || sam.CIRCLE_OFFICE_CODE ||"
			+ " sam.DIVISION_OFFICE_CODE || sam.SUBDIVISION_OFFICE_CODE, sam.SAMP_COLLECTOR_CODE,"
			+ " des.DESIGNATION_NAME, TO_CHAR(sam.SAMP_COLLECT_DATE, 'dd/MM/yyyy'),"
			+ " TO_CHAR(sam.ASSIGNED_ON, 'dd/MM/yyyy'), sam.PREPARED_BY, "
			+ " TO_CHAR(sam.PREPARED_ON, 'dd/MM/yyyy'),lab.LOCATION,decode (sam.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE', '0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002', 'MPWSSURFACE','0301003','MPWSPUMPSETS ' ,'0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS', '0701 001','PONDS','0801001','OTHERS') as sname FROM "
			+ " RWS_WATER_SAMPLE_COLLECT_TBL"
			+ " sam,"
			+ " RWS_PANCHAYAT_RAJ_TBL pr, RWS_SOURCE_TBL sr, RWS_WATER_QUALITY_TEST_TBL tes," 
			+ " RWS_WATER_QUALITY_LAB_TBL lab, RWS_DESIGNATION_TBL des" 
			+ " WHERE sam.HAB_CODE = pr.PANCH_CODE AND sam.SOURCE_CODE = sr.SOURCE_CODE AND"
			+ " sam.TEST_CODE = tes.TEST_CODE AND sam.LAB_CODE = lab.LAB_CODE AND"
			+ "  sam.SAMP_COLLECTOR_CODE = des.DESIGNATION_CODE"
			+ " AND sam.SAMP_COLLECT_DATE BETWEEN to_date('"+fromDate+"', 'dd/MM/yyyy') AND" 
			+ " to_date('"+toDate+"', 'dd/MM/yyyy') AND SUBSTR(sam.HAB_CODE,1,2) = '"+dcode+"' AND "
			+ " SUBSTR(sam.HAB_CODE,6,2) = '"+mcode+"' AND SUBSTR(sam.HAB_CODE,13,2) = '"+pcode+"' "
			+ " AND SUBSTR(sam.HAB_CODE,8,3) = '"+vcode+"' and  sam.DIVISION_OFFICE_CODE || sam.SUBDIVISION_OFFICE_CODE  is not null ORDER BY sam.TEST_ID";
		}
		if(!dcode.equals("40") && !dcode.equals("00") && !fromDate.equals("00") && !toDate.equals("00") && !mcode.equals("5555") && !mcode.equals("00") && !pcode.equals("66666") && !pcode.equals("00") && !vcode.equals("777777") && !vcode.equals("00") && hcode.equals("8888888"))
		{
			//System.out.println("FOR ALL HABITATIONS...");
			query = "SELECT sam.TEST_ID, sam.HAB_CODE, pr.PANCH_NAME, sam.SOURCE_CODE,"
			+ " nvl(sr.SOURCE_NAME,'-'), sam.TEST_CODE, tes.TEST_NAME," 
			+ " DECODE(sam.NATURE_OF_TEST, '1', 'ROUTINE', '2', 'SEASONAL', '3', 'QUARTERLY',"
			+ " '4', 'DISEASE OUTBREAK'), sam.LAB_CODE, lab.LAB_NAME, 1 || sam.CIRCLE_OFFICE_CODE ||"
			+ " sam.DIVISION_OFFICE_CODE || sam.SUBDIVISION_OFFICE_CODE, sam.SAMP_COLLECTOR_CODE,"
			+ " des.DESIGNATION_NAME, TO_CHAR(sam.SAMP_COLLECT_DATE, 'dd/MM/yyyy'),"
			+ " TO_CHAR(sam.ASSIGNED_ON, 'dd/MM/yyyy'), sam.PREPARED_BY,"
			+ " TO_CHAR(sam.PREPARED_ON, 'dd/MM/yyyy'),lab.LOCATION,decode (sam.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE', '0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002', 'MPWSSURFACE','0301003','MPWSPUMPSETS ' ,'0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS', '0701 001','PONDS','0801001','OTHERS') as sname FROM "
			+ " RWS_WATER_SAMPLE_COLLECT_TBL"
			+ " sam,"
			+ " RWS_PANCHAYAT_RAJ_TBL pr, RWS_SOURCE_TBL sr, RWS_WATER_QUALITY_TEST_TBL tes," 
			+ " RWS_WATER_QUALITY_LAB_TBL lab, RWS_DESIGNATION_TBL des" 
			+ " WHERE sam.HAB_CODE = pr.PANCH_CODE AND sam.SOURCE_CODE = sr.SOURCE_CODE AND"
			+ " sam.TEST_CODE = tes.TEST_CODE AND sam.LAB_CODE = lab.LAB_CODE AND"
			+ "  sam.SAMP_COLLECTOR_CODE = des.DESIGNATION_CODE"
			+ " AND sam.SAMP_COLLECT_DATE BETWEEN to_date('"+fromDate+"', 'dd/MM/yyyy') AND" 
			+ " to_date('"+toDate+"', 'dd/MM/yyyy') AND SUBSTR(sam.HAB_CODE,1,2) = '"+dcode+"' AND "
			+ " SUBSTR(sam.HAB_CODE,6,2) = '"+mcode+"' AND SUBSTR(sam.HAB_CODE,13,2) = '"+pcode+"' "
			+ "  and  sam.DIVISION_OFFICE_CODE || sam.SUBDIVISION_OFFICE_CODE  is not null ORDER BY sam.TEST_ID";
		}
		if(!dcode.equals("40") && !dcode.equals("00") && !fromDate.equals("00") && !toDate.equals("00") && !mcode.equals("5555") && !mcode.equals("00") && !pcode.equals("66666") && !pcode.equals("00") && !vcode.equals("777777") && !vcode.equals("00") && !hcode.equals("8888888") && !hcode.equals("00"))
		{
		//System.out.println("FOR PERTICULAR HABITATION...");
			query = "SELECT sam.TEST_ID, sam.HAB_CODE, pr.PANCH_NAME, sam.SOURCE_CODE,"
			+ " nvl(sr.SOURCE_NAME,'-'), sam.TEST_CODE, tes.TEST_NAME," 
			+ " DECODE(sam.NATURE_OF_TEST, '1', 'ROUTINE', '2', 'SEASONAL', '3', 'QUARTERLY',"
			+ " '4', 'DISEASE OUTBREAK'), sam.LAB_CODE, lab.LAB_NAME, 1 || sam.CIRCLE_OFFICE_CODE ||"
			+ " sam.DIVISION_OFFICE_CODE || sam.SUBDIVISION_OFFICE_CODE, sam.SAMP_COLLECTOR_CODE,"
			+ " des.DESIGNATION_NAME, TO_CHAR(sam.SAMP_COLLECT_DATE, 'dd/MM/yyyy'),"
			+ " TO_CHAR(sam.ASSIGNED_ON, 'dd/MM/yyyy'), sam.PREPARED_BY,"
			+ " TO_CHAR(sam.PREPARED_ON, 'dd/MM/yyyy'),lab.LOCATION,decode (sam.source_type,'0101001','PWSSUBSURFACE','0101002','PWSSURFACE','0101003','PWSPUMPSETS','0201001','MPWSSUBSURFACE', '0201002','MPWSSURFACE','0201003','MPWSPUMPSETS','0301001','CPWSSUBSURFACE','0301002', 'MPWSSURFACE','0301003','MPWSPUMPSETS ' ,'0401001','HANDPUMPS','0501001','SHALLOWHANDPUMPS','0601001','OPENWELLS', '0701 001','PONDS','0801001','OTHERS') as sname FROM "
			+ " RWS_WATER_SAMPLE_COLLECT_TBL"
			+ " sam,"
			+ " RWS_PANCHAYAT_RAJ_TBL pr, RWS_SOURCE_TBL sr, RWS_WATER_QUALITY_TEST_TBL tes," 
			+ " RWS_WATER_QUALITY_LAB_TBL lab,RWS_DESIGNATION_TBL des" 
			+ " WHERE sam.HAB_CODE = pr.PANCH_CODE AND sam.SOURCE_CODE = sr.SOURCE_CODE AND"
			+ " sam.TEST_CODE = tes.TEST_CODE AND sam.LAB_CODE = lab.LAB_CODE AND"
			+ "  sam.SAMP_COLLECTOR_CODE = des.DESIGNATION_CODE"
			+ "  AND sam.SAMP_COLLECT_DATE BETWEEN to_date('"+fromDate+"', 'dd/MM/yyyy') AND" 
			+ " to_date('"+toDate+"', 'dd/MM/yyyy') AND sam.HAB_CODE  = '"+hcode+"' and  sam.DIVISION_OFFICE_CODE || sam.SUBDIVISION_OFFICE_CODE  is not null ORDER BY "
			+ " sam.TEST_ID";
		}
		//System.out.println(query);
		rs = stmt.executeQuery(query);
%>

		

<html>
<head>
<title>WaterSoft</title>
<link rel="stylesheet" type="text/css" href="rwsstyle.css">



<script language="JavaScript">


function wopen(url, name, w, h)
{
// Fudge factors for window decoration space.
 // In my tests these work well on all platforms & browsers.
w += 32;
h += 96;
 var win = window.open(url,
  name, 
  'width=' + w + ', height=' + h + ', ' +
  'location=yes, menubar=no, ' +
  'status=yes, toolbar=no, scrollbars=yes, resizable=yes');
 
 win.focus();
}


</script>
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
				<td class="bwborder"><a href="./rws_wq_sam_res_loc_frm.jsp">Back&nbsp;|&nbsp;</a>&nbsp;<a href="../home.jsp">Home</a></td>
			</tr>
		</table>
	</caption>
<%
	if(dcode.equals("40") && !fromDate.equals("00") && !toDate.equals("00"))
	{
		//System.out.println("FOR ALL DISTRICTS... HEADING...");
%>
	<tr bgcolor="lavander">
		<td class="mystyle" align="center" colspan="11"><font color="navy">Water Quality Status Report For All Districts</font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class="btext" align="center" colspan="11"><font color="navy">From :<%=fromDate%> To :<%=toDate%></font></td>
	</tr>
<%
	}
	if(!dcode.equals("40") && !dcode.equals("00") && !fromDate.equals("00") && !toDate.equals("00") && !mcode.equals("5555") && mcode.equals("00"))
	{
		//System.out.println("FOR PERTICULAR DISTRICT... HEADING...");
%>
	<tr bgcolor="lavander">
		<td class="mystyle" align="center" colspan="11"><font color="navy">Water Quality Status Report</font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class="btext" align="center" colspan="11"><font color="navy">District :<%=dName%></font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class="btext" align="center" colspan="11"><font color="navy">From :<%=fromDate%> To :<%=toDate%></font></td>
	</tr>
<%
	}
	if(!dcode.equals("40") && !dcode.equals("00") && !fromDate.equals("00") && !toDate.equals("00") && mcode.equals("5555"))
	{
		//System.out.println("FOR ALL MANDALS...HEADING...");	
%>
	<tr bgcolor="lavander">
		<td class="mystyle" align="center" colspan="11"><font color="navy">Water Quality Status Report For All Mandals</font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class="btext" align="center" colspan="11"><font color="navy">District :<%=dName%></font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class="btext" align="center" colspan="11"><font color="navy">From :<%=fromDate%> To :<%=toDate%></font></td>
	</tr>
<%
	}
	if(!dcode.equals("40") && !dcode.equals("00") && !fromDate.equals("00") && !toDate.equals("00") && !mcode.equals("5555") && !mcode.equals("00") && pcode.equals("00"))
	{
		//System.out.println("FOR PERTICULAR MANDAL...HEADING...");
%>
	<tr bgcolor="lavander">
		<td class="mystyle" align="center" colspan="11"><font color="navy">Water Quality Status Report For Perticular Mandal</font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class="btext" align="center" colspan="11"><font color="navy">District :<%=dName%>
		Mandal :<%=mName%></font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class="btext" align="center" colspan="11"><font color="navy">From :<%=fromDate%> To :<%=toDate%></font></td>
	</tr>
<%
	}
	if(!dcode.equals("40") && !dcode.equals("00") && !fromDate.equals("00") && !toDate.equals("00") && !mcode.equals("5555") && !mcode.equals("00") && pcode.equals("66666"))
	{
		//System.out.println("FOR ALL PANCHAYAT...HEADING...");
%>
	<tr bgcolor="lavander">
		<td class="mystyle" align="center" colspan="11"><font color="navy">Water Quality Status Report For All Panchayats</font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class="btext" align="center" colspan="11"><font color="navy">District :<%=dName%>
		Mandal :<%=mName%></font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class="btext" align="center" colspan="11"><font color="navy">From :<%=fromDate%> To :<%=toDate%></font></td>
	</tr>

<%
	}
	if(!dcode.equals("40") && !dcode.equals("00") && !fromDate.equals("00") && !toDate.equals("00") && !mcode.equals("5555") && !mcode.equals("00") && !pcode.equals("66666") && !pcode.equals("00") && vcode.equals("000"))
	{
		//System.out.println("FOR PERTICULAR PANCHAYAT...HEADING...");
%>
	<tr bgcolor="lavander">
		<td class="mystyle" align="center" colspan="11"><font color="navy">Water Quality Status Report For Perticular Panchayat</font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class="btext" align="center" colspan="11"><font color="navy">District :<%=dName%>
		Mandal :<%=mName%> Panchayat :<%=pName%></font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class="btext" align="center" colspan="11"><font color="navy">From :<%=fromDate%> To :<%=toDate%></font></td>
	</tr>
<%
	}
	if(!dcode.equals("40") && !dcode.equals("00") && !fromDate.equals("00") && !toDate.equals("00") && !mcode.equals("5555") && !mcode.equals("00") && !pcode.equals("66666") && !pcode.equals("00") && vcode.equals("777777"))
	{
			//System.out.println("FOR ALL VILLAGES...HEADING...");

%>
	<tr bgcolor="lavander">
		<td class="mystyle" align="center" colspan="11"><font color="navy">Water Quality Status Report For All Villages</font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class="btext" align="center" colspan="11"><font color="navy">District :<%=dName%>
		Mandal :<%=mName%> Panchayat :<%=pName%></font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class="btext" align="center" colspan="11"><font color="navy">From :<%=fromDate%> To :<%=toDate%></font></td>
	</tr>
<%
	}
	if(!dcode.equals("40") && !dcode.equals("00") && !fromDate.equals("00") && !toDate.equals("00") && !mcode.equals("5555") && !mcode.equals("00") && !pcode.equals("66666") && !pcode.equals("00") && !vcode.equals("777777") && !vcode.equals("000") && hcode.equals("00"))
	{
		//System.out.println("FOR PERTICULAR VILLAGE...HEADING...");
%>
	<tr bgcolor="lavander">
		<td class="mystyle" align="center" colspan="11"><font color="navy">Water Quality Status Report For Perticular Village</font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class="btext" align="center" colspan="11"><font color="navy">District :<%=dName%>
		Mandal :<%=mName%> Panchayat :<%=pName%> Village :<%=vName%></font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class="btext" align="center" colspan="11"><font color="navy">From :<%=fromDate%> To :<%=toDate%></font></td>
	</tr>

<%
	}
	if(!dcode.equals("40") && !dcode.equals("00") && !fromDate.equals("00") && !toDate.equals("00") && !mcode.equals("5555") && !mcode.equals("00") && !pcode.equals("66666") && !pcode.equals("00") && !vcode.equals("777777") && !vcode.equals("00") && hcode.equals("8888888"))
	{
		//System.out.println("FOR ALL HABITATIONS...HEADING...");
%>
	<tr bgcolor="lavander">
		<td class="mystyle" align="center" colspan="11"><font color="navy">Water Quality Status Report For All Habitations</font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class="btext" align="center" colspan="11"><font color="navy">District :<%=dName%>
		Mandal :<%=mName%> Panchayat :<%=pName%> Village :<%=vName%></font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class="btext" align="center" colspan="11"><font color="navy">From :<%=fromDate%> To :<%=toDate%></font></td>
	</tr>
<%
	}
	if(!dcode.equals("40") && !dcode.equals("00") && !fromDate.equals("00") && !toDate.equals("00") && !mcode.equals("5555") && !mcode.equals("00") && !pcode.equals("66666") && !pcode.equals("00") && !vcode.equals("777777") && !vcode.equals("00") && !hcode.equals("8888888") && !hcode.equals("00"))
	{
		//System.out.println("FOR PERTICULAR HABITATION...HEADING...");
%>
	<tr bgcolor="lavander">
		<td class="mystyle" align="center" colspan="11"><font color="navy">Water Quality Status Report For Perticular Habitation</font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class="btext" align="center" colspan="11"><font color="navy">District :<%=dName%>
		Mandal :<%=mName%> Panchayat :<%=pName%> Village :<%=vName%> Habitation :<%=hName%></font></td>
	</tr>
	<tr bgcolor="#ffffff">
		<td class="btext" align="center" colspan="11"><font color="navy">From :<%=fromDate%> To :<%=toDate%></font></td>
	</tr>
<%
	}
%>
	
	<tr align=center bgcolor="#ffffff">
		<td class=btext>Sl.No</td>
		<td class=btext>Test ID</td>
		<td class=btext>Habitation</td>
		<td class=btext>Source Code/<br>Source Name</td>
		<td class=btext>Test / <br>Nature Of Test</td>		
		<td class=btext>Lab</td>
		<td class=btext>Sample Collector</td>
		<td class=btext>Sample Collected Date</td>		
		<!-- <td class=btext>Assigned On</td> -->
		<td class=btext>Tested Date</td>		
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
		<td class="mystyle1"><%=rs.getString(3)%></td>
		<td class="mystyle1"><a href="#" onclick="wopen('./rws_wq_sam_res_sourcename_rpt.jsp?testId=<%=rs.getString(1)%>&testName=<%=rs.getString(7)%>&testCode=<%=rs.getString(6)%>&sourcecode=<%=rs.getString(4)%>&fromDate=<%=fromDate %>&toDate=<%=toDate %>&location=<%=rs.getString(18)%>&sctype=<%=rs.getString(19)%>','popup', 640, 480)" ><font face="verdana" size="2"><%=rs.getString(4)%>/<br><%=rs.getString(5)%></font></a></td>  </td>
		<td class="mystyle1"><%=rs.getString(7)%><br><%=rs.getString(8)%></td>	
		<td class="mystyle1"><%=rwsOffices.getOfficeName(rs.getString(11),true)%></td>
		<td class="mystyle1"><%=rs.getString(13)%></td>
		<td class="mystyle1"><%=rs.getString(14)%></td>
		<%-- <td class="mystyle1"><%=rs.getString(15)%></td> --%>
		<td class="mystyle1"><%=rs.getString(17)%></td>
			
	</tr>
<%
		}
         if(rs!=null) rs.close();
		if(slno == 0) 
		{
%>
	<tr>
		<td class="mystyle1" colspan=10 align="center">No Records Matching with This Selection Criteira..</td>
	</tr>
<%
		}


}catch(Exception e)
{
	System.out.println("Exception in WQ Report :"+e);
}
%>

</table>


</body>
</html>


<%@ include file = "footer.jsp" %>