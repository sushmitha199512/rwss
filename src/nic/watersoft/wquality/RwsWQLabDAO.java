package nic.watersoft.wquality;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;

import nic.watersoft.commons.DAOMessage;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUtils;

public class RwsWQLabDAO {

	public DAOMessage insertWQLabSamplesAndResults(RwsWQuality rwsWQuality, HttpServletRequest request,String potable) {
		Statement stmt = null;
		Connection conn = null;

		DAOMessage daoMessage = new DAOMessage();
		boolean success = true;
		String ftkid = rwsWQuality.getFtktestid();
		if (rwsWQuality.getCoc() == null) {
			rwsWQuality.setCoc("00");
		}
		if (rwsWQuality.getDoc() == null) {
			rwsWQuality.setDoc("0");
		}
		if (rwsWQuality.getSdoc() == null) {
			rwsWQuality.setSdoc("00");
		}
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			if (rwsWQuality.getLabCode().length() == 1) {
				rwsWQuality.setLabCode("0" + rwsWQuality.getLabCode());
			}
			String currentDate = RwsUtils.getCurrentDate("dd/MM/yyyy");
			String testId = getTestId("sample", rwsWQuality.getLabCode(), (rwsWQuality.getPreparedOn()).substring(8), conn);

			String query = "insert into RWS_WATER_SAMPLE_COLLECT_TBL(TEST_ID,CIRCLE_OFFICE_CODE,"
					+ "DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE,HAB_CODE,SOURCE_CODE,"
					+ "TEST_CODE,NATURE_OF_TEST,LAB_CODE,SAMP_COLLECTOR_CODE,SAMP_COLLECT_DATE,"
					+ "SAMP_COLLECT_TIME,ASSIGNED_ON,PREPARED_BY,PREPARED_ON,SOURCE_TYPE,FTK_TEST_ID,OLD_TEST_ID)"
					+ " values"
					+ "('"
					+ testId
					+ "',"
					+ "'"
					+ rwsWQuality.getCoc()
					+ "','"
					+ rwsWQuality.getDoc()
					+ "',"
					+ "'"
					+ rwsWQuality.getSdoc()
					+ "','"
					+ rwsWQuality.getHabCode()
					+ "',"
					+ "'"
					+ rwsWQuality.getSourceCode()
					+ "','"
					+ rwsWQuality.getTestCode()
					+ "',"
					+ "'"
					+ rwsWQuality.getNatureOfTest()
					+ "','"
					+ rwsWQuality.getLabCode()
					+ "',"
					+ "'"
					+ rwsWQuality.getSampCollectCode()
					+ "',"
					+ "TO_DATE('"
					+ rwsWQuality.getSampCollectDate()
					+ "','dd/MM/yyyy'),"
					+ "'"
					+ rwsWQuality.getSampCollectTime()
					+ "',"
					+ "TO_DATE('"
					+ rwsWQuality.getAssignedOn()
					+ "','dd/MM/yyyy'),"
					+ "'"
					+ rwsWQuality.getPreparedBy()
					+ "',"
					+ "TO_DATE('"
					+ rwsWQuality.getPreparedOn()
					+ "','dd/MM/yyyy'),"
					+ "'"
					+ rwsWQuality.getSourceType()
					+ "','"
					+ rwsWQuality.getFtktestid()
					+ "','"
					+ testId
					+ "')";
			stmt.addBatch(query);	
			
			String testResult = "insert into RWS_WQ_TEST_RESULTS_TBL values"
					+ "('" + testId + "'," + "'"
					+ rwsWQuality.getRecommendations() + "'," + "'"
					+ rwsWQuality.getCondemnSource() + "'," + "'"
					+ rwsWQuality.getUpdateSource() + "'," + "TO_DATE('"
					+ rwsWQuality.getForwadedOn() + "','dd/MM/yyyy')," + "'"
					+ rwsWQuality.getPreparedBy() + "'," + "TO_DATE('"
					+ rwsWQuality.getPreparedOn() + "','dd/MM/yyyy')," + "'"
					+ rwsWQuality.getTestCode() + "'," + "'"
					+ rwsWQuality.getLabCode() + "'," + "'"
					+ rwsWQuality.getSourceCode() 	+ "'," + "'"+potable+"','',"+ "TO_DATE('"
					+ currentDate + "','dd/MM/yyyy'))";	 
			stmt.addBatch(testResult);
			
           int pSize=0;
			if(rwsWQuality.getTestCode().equals("1")){
				pSize=34;
			}else{
				pSize=2;
			}
			for (int k = 0; k < pSize; k++) {
				String value = request.getParameter("TESTPARAM_LIST[" + k + "].result");				
                if (value!=null && !value.equals("")) {

                        String testParams = "insert into RWS_WQ_TEST_RESULTS_LNK_TBL values"
                                        + "('"
                                        + testId
                                        + "',"
                                        + "'"
                                        + request.getParameter("TESTPARAM_LIST[" + k
                                                        + "].testPCode")
                                        + "',"
                                        + "'"
                                        + request.getParameter("TESTPARAM_LIST[" + k
                                                        + "].result") + "','')";                      
                        stmt.addBatch(testParams);
                }
			}
				int reccount[] = stmt.executeBatch();	

						for(int k=0;k<reccount.length;k++){							
							if(reccount[k]>=0){
								continue;
							}else{
								success=false;
							}
						}
					
			if (!success) {
				conn.rollback();	
			} else {
				try {
					conn.commit();
					conn.setAutoCommit(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			success=false;
		} finally {

		}
		if (success) {
			daoMessage.setMessage("Record Inserted Successfully");
			daoMessage.setOperationSussess(true);
		} else  {
			daoMessage.setMessage("Record Cannot be Inserted");
			daoMessage.setOperationSussess(false);
		} 

		return daoMessage;

	}
	
	public DAOMessage insertWQLabSamplesAndResults1(RwsWQuality rwsWQuality,
			HttpServletRequest request,String potable) {

		Statement stmt = null;
		Connection conn = null;

		DAOMessage daoMessage = new DAOMessage();
		boolean success = true;
		int rowCount = 0;
		int cnt = 0;
		String ftkid = rwsWQuality.getFtktestid();
		if (rwsWQuality.getCoc() == null) {
			rwsWQuality.setCoc("00");
		}
		if (rwsWQuality.getDoc() == null) {
			rwsWQuality.setDoc("0");
		}
		//System.out.println("sd code1:"+rwsWQuality.getSdoc());
		if (rwsWQuality.getSdoc() == null) {
			rwsWQuality.setSdoc("00");
		}
		try {

			conn = RwsOffices.getConn();

			conn.setAutoCommit(false);

			stmt = conn.createStatement();

			//Debug.println("Lab Code:"+rwsWQuality.getLabCode());
			if (rwsWQuality.getLabCode().length() == 1) {
				//Debug.println("in length 1");
				rwsWQuality.setLabCode("0" + rwsWQuality.getLabCode());
			}
			String currentDate = RwsUtils.getCurrentDate("dd/MM/yyyy");
			String testId = getTestId("sample", rwsWQuality.getLabCode(),
					(rwsWQuality.getPreparedOn()).substring(8), conn);

			String query = "insert into RWS_WATER_SAMPLE_COLLECT_TBL(TEST_ID,CIRCLE_OFFICE_CODE,"
					+ "DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE,HAB_CODE,SOURCE_CODE,"
					+ "TEST_CODE,NATURE_OF_TEST,LAB_CODE,SAMP_COLLECTOR_CODE,SAMP_COLLECT_DATE,"
					+ "SAMP_COLLECT_TIME,ASSIGNED_ON,PREPARED_BY,PREPARED_ON,SOURCE_TYPE,FTK_TEST_ID,OLD_TEST_ID)"
					+ " values"
					+ "('"
					+ testId
					+ "',"
					+ "'"
					+ rwsWQuality.getCoc()
					+ "','"
					+ rwsWQuality.getDoc()
					+ "',"
					+ "'"
					+ rwsWQuality.getSdoc()
					+ "','"
					+ rwsWQuality.getHabCode()
					+ "',"
					+ "'"
					+ rwsWQuality.getSourceCode()
					+ "','"
					+ rwsWQuality.getTestCode()
					+ "',"
					+ "'"
					+ rwsWQuality.getNatureOfTest()
					+ "','"
					+ rwsWQuality.getLabCode()
					+ "',"
					+ "'"
					+ rwsWQuality.getSampCollectCode()
					+ "',"
					+ "TO_DATE('"
					+ rwsWQuality.getSampCollectDate()
					+ "','dd/MM/yyyy'),"
					+ "'"
					+ rwsWQuality.getSampCollectTime()
					+ "',"
					+ "TO_DATE('"
					+ rwsWQuality.getAssignedOn()
					+ "','dd/MM/yyyy'),"
					+ "'"
					+ rwsWQuality.getPreparedBy()
					+ "',"
					+ "TO_DATE('"
					+ rwsWQuality.getPreparedOn()
					+ "','dd/MM/yyyy'),"
					+ "'"
					+ rwsWQuality.getSourceType()
					+ "','"
					+ rwsWQuality.getFtktestid()
					+ "','"
					+ testId
					+ "')";

			Debug.println("Sample Insert query= " + query);

			stmt.addBatch(query);

				
			
			String testResult = "insert into RWS_WQ_TEST_RESULTS_TBL values"
					+ "('" + testId + "'," + "'"
					+ rwsWQuality.getRecommendations() + "'," + "'"
					+ rwsWQuality.getCondemnSource() + "'," + "'"
					+ rwsWQuality.getUpdateSource() + "'," + "TO_DATE('"
					+ rwsWQuality.getForwadedOn() + "','dd/MM/yyyy')," + "'"
					+ rwsWQuality.getPreparedBy() + "'," + "TO_DATE('"
					+ rwsWQuality.getPreparedOn() + "','dd/MM/yyyy')," + "'"
					+ rwsWQuality.getTestCode() + "'," + "'"
					+ rwsWQuality.getLabCode() + "'," + "'"
					+ rwsWQuality.getSourceCode() 	+ "'," + "'"+potable+"','',"+ "TO_DATE('"
					+ currentDate + "','dd/MM/yyyy'))";
			 
					
			stmt.addBatch(testResult);
           int pSize=0;
			if(rwsWQuality.getTestCode().equals("1")){
				pSize=9;
			}else{
				pSize=2;
			}
			for (int k = 0; k < pSize; k++) {
				String value = request.getParameter("TESTPARAM_LIST[" + k
						+ "].result");
				System.out.println("value"+value);
				if (!value.equals("")) {
					
					String testParams = "insert into RWS_WQ_TEST_RESULTS_LNK_TBL values"
							+ "('"
							+ testId
							+ "',"
							+ "'"
							+ request.getParameter("TESTPARAM_LIST[" + k
									+ "].testPCode")
							+ "',"
							+ "'"
							+ request.getParameter("TESTPARAM_LIST[" + k
									+ "].result") + "','')";
					System.out.println("params testresults" + testParams);
					stmt.addBatch(testParams);
				}
			}

				int reccount[] = stmt.executeBatch();
		//	System.out.println("Record Count"+reccount);

						for(int k=0;k<reccount.length;k++){
							
							if(reccount[k]>=0){
							//	System.out.println("Success"+success);
								continue;
							}else{
							//	System.out.println("Failed"+success);
								success=false;
							}
						}
				
			if (!success) {
				conn.rollback();
				

			} else {
				try {
					conn.commit();
					conn.setAutoCommit(true);
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
			success=false;
		} finally {

		}
		if (success) {
			daoMessage.setMessage("Record Inserted Successfully");
			daoMessage.setOperationSussess(true);
		} else  {
			daoMessage.setMessage("Record Cannot be Inserted");
			daoMessage.setOperationSussess(false);
		} 

		return daoMessage;

	}
	
	
	
	

	public static String getTestId(String test, String labCode, String yr,
			Connection conn) throws Exception {
		String name = null;
		Statement stmt1 = null,stmt2=null;
		ResultSet rs1 = null,rs2=null;
		boolean flag=false;
		try {
			//System.out.println(" year="+yr);
			stmt1 = conn.createStatement();
			stmt2 = conn.createStatement();
			
			String recQuery="select count(*) from rws_water_sample_collect_tbl  where substr(test_id,4,2)='"+yr+"' and substr(test_id,1,3)='"+labCode+"'";
			
			rs2=stmt2.executeQuery(recQuery);
			if(rs2.next()){
				if(rs2.getInt(1)>0){
					flag=true;
				}else{
					flag=false;
				}
			}
			
			if (test.equals("sample")) {
				String q1="select max(substr(test_id,4,2)),max(to_number(substr(test_id,6,5))) from rws_water_sample_collect_tbl where substr(test_id,1,3)='"
					+ labCode + "'";
				System.out.println("TestIdQuery:"+q1);
				rs1 = stmt1.executeQuery(q1);
			} else if (test.equals("test")) {
				rs1 = stmt1
						.executeQuery("select max(substr(test_id,4,2)),max(to_number(substr(test_id,6,5))) from RWS_WQ_TEST_RESULTS_TBL where substr(test_id,1,3)='"
								+ labCode + "'");
			}
			rs1.next();
			
			
			
			if (rs1.getString(1) != null) {
				if (flag) {
					if (rs1.getInt(2) < 9) {
						name = "0000" + (rs1.getInt(2) + 1);
					} else if (rs1.getInt(2) < 99) {
						name = "000" + (rs1.getInt(2) + 1);
					} else if (rs1.getInt(2) < 999) {
						name = "00" + (rs1.getInt(2) + 1);
					} else if (rs1.getInt(2) < 9999) {
						name = "0" + (rs1.getInt(2) + 1);
					} else if (rs1.getInt(2) < 99999) {
						name = String.valueOf(rs1.getInt(2) + 1);
					}
				} else {
					name = "00001";
				}
			} else {
			name = "00001";
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			stmt1.close();
		}
		//System.out.println("labCode+yr+name="+labCode+yr+name);
		return (labCode + yr + name);
	}
	public DAOMessage updtaeWQLabSamplesAndResults(String testId, String testCode,String recommendations ,HttpServletRequest request) {
		
		DAOMessage daoMessage=new DAOMessage();
		Statement stmt=null;
		Connection conn=null;		
		boolean success = true;
		try{
			conn=RwsOffices.getConn();
			stmt=conn.createStatement();
		    int pSize=0;		
			if(testCode.equals("1")){
				pSize=34;
			}else{
				pSize=2;
			}			
			String testparams1="update rws_wq_test_results_tbl set RECOMMENDATIONS ='"+recommendations+"' where TEST_ID='"+testId+"' ";
			stmt.addBatch(testparams1);			
			for (int k = 0; k < pSize; k++) {
				String value = request.getParameter("parameters[" + k + "].result");
				System.out.println("value"+value);
				if (!value.equals("")) {					
					String testParams="update RWS_WQ_TEST_RESULTS_LNK_TBL set TESTING_PARAMETER_VALUE='"+request.getParameter("parameters[" + k + "].result")+"' where TESTING_PARAMETER_CODE='"+request.getParameter("parameters[" + k + "].testPCode")+"' and  TEST_ID='"+testId+"'";
					stmt.addBatch(testParams);
				}
			}
				int reccount[] = stmt.executeBatch();
						for(int k=0;k<reccount.length;k++){							
							if(reccount[k]>=0){
								continue;
							}else{
								success=false;
							}
						}					
			if (!success) {
				conn.rollback();				

			} else {
				try {
					conn.commit();
					conn.setAutoCommit(true);
				} catch (Exception e) {
					System.out.println("The exception in RwsWQLabDAO updtaeWQLabSamplesAndResults = "+e.getMessage());
				}
			}

		} catch (Exception e) {
			System.out.println("The exception in RwsWQLabDAO updtaeWQLabSamplesAndResults = "+e.getMessage());
			success=false;
		} 
		if (success) {
			daoMessage.setMessage("Record Inserted Successfully");
			daoMessage.setOperationSussess(true);
		} else  {
			daoMessage.setMessage("Record Cannot be Inserted");
			daoMessage.setOperationSussess(false);
		} 		
		
		return daoMessage ;
	}
}