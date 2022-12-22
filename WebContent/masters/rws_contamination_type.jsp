<%@page import="nic.watersoft.masters.Rws_Habitation_Safe_Suplly_Form"%>
<%@ include file="/reports/conn.jsp"%>
<%
	String habCode = request.getParameter("habcode");
String statusDate = request.getParameter("statusDate");
String date="";
System.out.println(statusDate);
	String typeOfContamination = "--";
	ResultSet resset = null;
	ArrayList sources = new ArrayList();
	Rws_Habitation_Safe_Suplly_Form suplly_Form = null;
	try {
		String query = "select to_char(max(prepared_on),'dd/mm/yyyy'),source_code from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and substr(source_code,1,16)='"
				+ habCode
				+ "' and prepared_on>=to_date('"+statusDate+"','dd/mm/yyyy') group by source_code order by max(prepared_on) desc";
		stmt = conn.createStatement();
		rs = stmt.executeQuery(query);
		while (rs.next()) {
			suplly_Form = new Rws_Habitation_Safe_Suplly_Form();
			String prepared_on = rs.getString(1);
			String source_code = rs.getString(2);
			suplly_Form.setPreparedOn(prepared_on);
			suplly_Form.setSourceType(source_code);
			sources.add(suplly_Form);
			String flouride = "SELECT A.TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B,RWS_WQ_PARA_TEST_TBL c WHERE A.TEST_ID =B.TEST_ID AND B.TEST_CODE='1' AND A.TESTING_PARAMETER_CODE='13' AND a.TESTING_PARAMETER_CODE=c.TESTING_PARAMETER_CODE AND B.TEST_CODE=c.TEST_CODE AND to_number(TRIM(a.TESTING_PARAMETER_VALUE))>to_number(TRIM(c.MAX_PERMISSIBLE_VALUE)) AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
			ps = conn.prepareStatement(flouride);
			ps.setString(1, source_code);
			ps.setString(2, prepared_on);
			resset = ps.executeQuery();
			if (resset.next()) {
				typeOfContamination = "FLOURIDE";
			}
			resset.close();
			ps.close();
		}
		stmt.close();
		rs.close();
		if (typeOfContamination.equals("--")) {
			Iterator iterator = sources.iterator();
			while (iterator.hasNext()) {
				suplly_Form = (Rws_Habitation_Safe_Suplly_Form) iterator.next();
				String prepared_on = suplly_Form.getPreparedOn();
				String source_code = suplly_Form.getSourceType();
				String brakish = "SELECT A.TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B,RWS_WQ_PARA_TEST_TBL c WHERE A.TEST_ID =B.TEST_ID AND B.TEST_CODE='1' AND A.TESTING_PARAMETER_CODE='05' AND a.TESTING_PARAMETER_CODE=c.TESTING_PARAMETER_CODE AND B.TEST_CODE=c.TEST_CODE AND to_number(TRIM(a.TESTING_PARAMETER_VALUE))>to_number(TRIM(c.MAX_PERMISSIBLE_VALUE)) AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				ps = conn.prepareStatement(brakish);
				ps.setString(1, source_code);
				ps.setString(2, prepared_on);
				resset = ps.executeQuery();
				if (resset.next()) {
					typeOfContamination = "BRAKISH";
				}
				resset.close();
				ps.close();
			}
		}
		if (typeOfContamination.equals("--")) {
			Iterator iterator = sources.iterator();
			while (iterator.hasNext()) {

				suplly_Form = (Rws_Habitation_Safe_Suplly_Form) iterator.next();
				String prepared_on = suplly_Form.getPreparedOn();
				String source_code = suplly_Form.getSourceType();
				String brakish = "SELECT A.TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B,RWS_WQ_PARA_TEST_TBL c WHERE A.TEST_ID =B.TEST_ID AND B.TEST_CODE='1' AND A.TESTING_PARAMETER_CODE='16' AND a.TESTING_PARAMETER_CODE=c.TESTING_PARAMETER_CODE AND B.TEST_CODE=c.TEST_CODE AND to_number(TRIM(a.TESTING_PARAMETER_VALUE))>to_number(TRIM(c.MAX_PERMISSIBLE_VALUE)) AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				ps = conn.prepareStatement(brakish);
				ps.setString(1, source_code);
				ps.setString(2, prepared_on);
				resset = ps.executeQuery();
				if (resset.next()) {
					typeOfContamination = "IRON";
				}
				resset.close();
				ps.close();
			}
		}
		if (typeOfContamination.equals("--")) {
			Iterator iterator = sources.iterator();
			while (iterator.hasNext()) {
				suplly_Form = (Rws_Habitation_Safe_Suplly_Form) iterator.next();
				String prepared_on = suplly_Form.getPreparedOn();
				String source_code = suplly_Form.getSourceType();

				String brakish = "SELECT A.TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B,RWS_WQ_PARA_TEST_TBL c WHERE A.TEST_ID =B.TEST_ID AND B.TEST_CODE='1' AND A.TESTING_PARAMETER_CODE='15' AND a.TESTING_PARAMETER_CODE=c.TESTING_PARAMETER_CODE AND B.TEST_CODE=c.TEST_CODE AND to_number(TRIM(a.TESTING_PARAMETER_VALUE))>to_number(TRIM(c.MAX_PERMISSIBLE_VALUE)) AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				ps = conn.prepareStatement(brakish);
				ps.setString(1, source_code);
				ps.setString(2, prepared_on);
				resset = ps.executeQuery();
				if (resset.next()) {
					typeOfContamination = "NITRATE";
				}
				resset.close();
				ps.close();
			}
		}
		//NSS hab with Linkage
		if (typeOfContamination.equals("--")) {
			String nsshablink = "select to_char(max(prepared_on),'dd/mm/yyyy'),a.source_code from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b,RWS_SOURCE_HABITATION_TBL c where a.test_id=b.test_id and a.source_code=c.source_code AND TEST_CODE='1' and HAB_CODE='"
					+ habCode
					+ "' and prepared_on>=to_date('"+statusDate+"','dd/mm/yyyy') group by a.source_code order by max(prepared_on) desc ";
			System.out.println(nsshablink);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(nsshablink);
			while (rs.next()) {
				suplly_Form = new Rws_Habitation_Safe_Suplly_Form();
				String prepared_on = rs.getString(1);
				String source_code = rs.getString(2);
				suplly_Form.setPreparedOn(prepared_on);
				suplly_Form.setSourceType(source_code);
				sources.add(suplly_Form);
				String flouride = "SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE='13' AND A.TESTING_PARAMETER_VALUE > 1.5 AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				System.out.println(flouride);
				ps = conn.prepareStatement(flouride);
				ps.setString(1, source_code);
				ps.setString(2, prepared_on);
				resset = ps.executeQuery();
				if (resset.next()) {
					typeOfContamination = "FLOURIDE";
				}
				resset.close();
				ps.close();
			}
			stmt.close();
			rs.close();
			if (typeOfContamination.equals("--")) {
				Iterator iterator = sources.iterator();
				while (iterator.hasNext()) {
					suplly_Form = (Rws_Habitation_Safe_Suplly_Form) iterator.next();
					String prepared_on = suplly_Form.getPreparedOn();
					String source_code = suplly_Form.getSourceType();
					String brakish = "SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE='05' AND A.TESTING_PARAMETER_VALUE > 2000 AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
					System.out.println(brakish);
					ps = conn.prepareStatement(brakish);
					ps.setString(1, source_code);
					ps.setString(2, prepared_on);
					resset = ps.executeQuery();
					if (resset.next()) {
						typeOfContamination = "BRAKISH";
					}
					resset.close();
					ps.close();
				}
			}
			if (typeOfContamination.equals("--")) {
				Iterator iterator = sources.iterator();
				while (iterator.hasNext()) {
					suplly_Form = (Rws_Habitation_Safe_Suplly_Form) iterator.next();
					String prepared_on = suplly_Form.getPreparedOn();
					String source_code = suplly_Form.getSourceType();
					String brakish = "SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE='16' AND A.TESTING_PARAMETER_VALUE > 1 AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
					System.out.println(brakish);
					ps = conn.prepareStatement(brakish);
					ps.setString(1, source_code);
					ps.setString(2, prepared_on);
					resset = ps.executeQuery();
					if (resset.next()) {
						typeOfContamination = "IRON";
					}
					resset.close();
					ps.close();
				}
			}

			System.out.println("7");
			if (typeOfContamination.equals("--")) {
				Iterator iterator = sources.iterator();
				while (iterator.hasNext()) {
					suplly_Form = (Rws_Habitation_Safe_Suplly_Form) iterator.next();
					String prepared_on = suplly_Form.getPreparedOn();
					String source_code = suplly_Form.getSourceType();
					String brakish = "SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE='15' AND A.TESTING_PARAMETER_VALUE > 45 AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
					System.out.println(brakish);
					ps = conn.prepareStatement(brakish);
					ps.setString(1, source_code);
					ps.setString(2, prepared_on);
					resset = ps.executeQuery();
					if (resset.next()) {
						typeOfContamination = "NITRATE";
					}
					resset.close();
					ps.close();
				}
			}
		}
		
		 if(typeOfContamination.equals("--")){			 
			  String maxquery="select to_char(max(prepared_on),'dd-mm-yyyy'),source_code from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and substr(source_code,1,16)='"
						+ habCode
						+ "' group by source_code order by max(prepared_on) ";
			  System.out.println(maxquery);
			  stmt=conn.createStatement();
			  rs=stmt.executeQuery(maxquery);
			  if(rs.next()){
				  date=rs.getString(1); 
			  }			  
		  }	 
	} catch (Exception e) {
		System.out.println("Exception at rws_contamination_type : "+e.getMessage());
	}
%>
<%=typeOfContamination.trim()+"/"+date%>