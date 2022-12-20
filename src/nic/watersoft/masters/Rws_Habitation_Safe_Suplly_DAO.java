package nic.watersoft.masters;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;

public class Rws_Habitation_Safe_Suplly_DAO {
	
	public ArrayList getHabitations(String dcode, String mcode, String pcode,
			String vcode) throws Exception {
		ArrayList habs = new ArrayList();
		Connection conn=null;
		String query = "";
		LabelValueBean labelValueBean = null;
		PreparedStatement ps=null;
		ResultSet rset=null;
		try {
			conn = RwsOffices.getConn();
			query = "SELECT RAJ.HAB_CODE,RAJ.PANCH_CODE,RAJ.PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL RAJ,rws_habitation_dir_dyna_tbl HD WHERE"
					+ " RAJ.PANCH_CODE = HD.HAB_CODE AND SUBSTR(RAJ.HAB_CODE,1,2)=? AND SUBSTR(RAJ.HAB_CODE,6,2)=? AND  SUBSTR(RAJ.HAB_CODE,13,2)=? AND SUBSTR(RAJ.HAB_CODE,8,3)=? AND (HD.COVERAGE_STATUS IS NOT NULL AND HD.COVERAGE_STATUS <> 'UI')";
			ps = conn.prepareStatement(query);
			ps.setString(1,dcode);
			ps.setString(2,mcode);
			ps.setString(3,pcode);
			ps.setString(4,vcode);
			rset = ps.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(2));
				labelValueBean.setLabel(rset.getString(3));
				labelValueBean.setLabelValue(rset.getString(3) + " - "
						+ rset.getString(2));
				habs.add(labelValueBean);
			}
		} catch (Exception e) {
			 System.out.println("The exception in Rws_Habitation_Safe_Supply_DAO getHabitations="+e);
		} finally {
			if(conn!=null){
				conn.close();
			}
		}
		return habs;
	}


public ArrayList getHabitaionReservoirsSafeSupply(Rws_Habitation_Safe_Suplly_Form mForm,HttpSession session) {
		
		ArrayList arrayList=new  ArrayList();
		Connection connection=null;
		PreparedStatement preparedStatement=null;
		ResultSet resultSet=null;
		String query="";
		String habCode=mForm.getHabitation();
		try{
		connection=RwsOffices.getConn();
		query="select GLSR_NO,GLSR_QTY,OHSR_NO,OHSR_QTY,HOUSEHOLD_NO,UNSAFE_LPCD,SAFE_LPCD,COVERAGE_STATUS,EXIST_WATER_LEVEL,TOTAL_WATER_SUPPLY,CENSUS_YEAR,CENSUS_PLAIN_POPU,CENSUS_SC_POPU,CENSUS_ST_POPU,FLOAT_POP,CENSUS_MINORITY_POPU,NO_OF_HOUSECONN_GIVEN,NO_OF_TAPS_WITH_STANDPOSTS,contam_type,to_char(STATUS_DATE,'dd/mm/yyyy') as STATUS_DATE,ACT_TOT_POPU,ACT_HOUSE_HOLD,ACT_HOUSE_CONN  from  rws_habitation_dir_dyna_tbl where HAB_CODE=?";
		preparedStatement=connection.prepareStatement(query);
		preparedStatement.setString(1, habCode);
		resultSet=preparedStatement.executeQuery();
		if(resultSet.next()){
			mForm.setGlsrNo(resultSet.getInt(1));
			mForm.setGlsrQty(resultSet.getInt(2));
			mForm.setOhsrNo(resultSet.getInt(3));
			mForm.setOhsrQty(resultSet.getInt(4));
			mForm.setHouseHolds(resultSet.getInt(5));
			mForm.setLevelOfWaterSupplyUnSafeSource(resultSet.getDouble(6));
			mForm.setLevelOfWaterSupplySafeSource(resultSet.getDouble(7));
			mForm.setCoverageStatus(resultSet.getString(8));
			mForm.setLevelOfWaterSupplyLPCD(resultSet.getDouble(9));
			mForm.setPreviousYearLPCD(resultSet.getDouble(9));
			mForm.setTotalWaterSupply(resultSet.getInt(10));
			mForm.setLevelOfWaterSupplySafeUnSafe(resultSet.getDouble(6)+resultSet.getDouble(7));
			mForm.setcYear(resultSet.getInt(11));
			mForm.setNetPop(resultSet.getInt(12)+resultSet.getInt(13)+resultSet.getInt(14)+resultSet.getInt(15)+resultSet.getInt(16));
			mForm.setTotPop(resultSet.getInt(12)+resultSet.getInt(13)+resultSet.getInt(14)+resultSet.getInt(16));
			mForm.setHouseConn(resultSet.getInt(17));
			mForm.setStandPosts(resultSet.getInt(18));
			mForm.setPreviousCS(resultSet.getString("COVERAGE_STATUS"));
			mForm.setActTotPop(resultSet.getInt("ACT_TOT_POPU"));
			mForm.setActHouseHold(resultSet.getInt("ACT_HOUSE_HOLD"));
			mForm.setActHouseConn(resultSet.getInt("ACT_HOUSE_CONN"));	
			if(resultSet.getString("COVERAGE_STATUS").equals("NSS"))
				mForm.setContaminationType(resultSet.getString("contam_type"));
			else
				mForm.setContaminationType("");
			mForm.setStatusDate(resultSet.getString("STATUS_DATE"));
			session.setAttribute("status", "Yes");
			arrayList.add(mForm);
		}
		preparedStatement.close();
		resultSet.close();
		
		}
		catch(Exception e){
			System.out.println("Exception at getHabitaionReservoirsSafeSupply in Rws_Habitation_Safe_Suplly_DAO"+e);
		}
		finally {
			try{
			if(connection!=null){
				connection.close();
			}
			}
			catch(Exception e){
				System.out.println("Exception at finally block of getHabitaionReservoirsSafeSupply in Rws_Habitation_Safe_Suplly_DAO"+e);
			}
		}
		return arrayList;
		
	}


	public String getHabitationUpdateDate(Rws_Habitation_Safe_Suplly_Form mForm,HttpSession session) {
		String updateDate = null;
		Connection connection=null;
		PreparedStatement preparedStatement=null;
		ResultSet resultSet=null;
		String query="";
		String habCode=mForm.getHabitation();
		try{
			connection=RwsOffices.getConn();
			query="select to_char(UPDATE_DATE,'dd/mm/yyyy') from  rws_hab_supply_status_tbl where HAB_CODE=?";
			preparedStatement=connection.prepareStatement(query);
			preparedStatement.setString(1, habCode);
			resultSet=preparedStatement.executeQuery();
			if(resultSet.next()){
				updateDate = resultSet.getString(1);
				mForm.setUpdateDate(updateDate);
				session.setAttribute("status", "Yes");
			}
			preparedStatement.close();
			resultSet.close();
		}
		catch(Exception e){
			
			System.out.println("Exception at getHabitationUpdateDate in Rws_Habitation_Safe_Suplly_DAO"+e);
		}
		finally {
			try{
			if(connection!=null){
				connection.close();
			}
			}
			catch(Exception e){
				System.out.println("Exception at finally block of getHabitationUpdateDate in Rws_Habitation_Safe_Suplly_DAO"+e);
			}
		}
		return updateDate;
	}

	public ArrayList getHabitaionPWSSafeSupply(Rws_Habitation_Safe_Suplly_Form mForm,HttpSession session) {
		
		ArrayList arrayList=new  ArrayList();
		Connection connection=null;
		PreparedStatement preparedStatement=null;
		ResultSet resultSet=null;
		PreparedStatement preparedStatement1=null;
		ResultSet resultSet1=null;
		PreparedStatement preparedStatement2=null;
		ResultSet resultSet2=null;
		String query="";
		int count=1;
		String habCode=mForm.getHabitation();
		try{
		connection=RwsOffices.getConn();
		query="select PWS_SUPPLY,PWS_NO,PWS_UNSAFE_SUPPLY,PWS_UNSAFE_NO from  rws_hab_supply_status_tbl where HAB_CODE=?";
		preparedStatement=connection.prepareStatement(query);
		preparedStatement.setString(1, habCode);
		resultSet=preparedStatement.executeQuery();
		if(resultSet.next()){
			mForm.setPwsHabLPCD(resultSet.getInt(1));
			mForm.setPwsNo(resultSet.getInt(2));
			mForm.setPwsHabUnsafeLPCD(resultSet.getInt(3));
			mForm.setPwsUnSafeNo(resultSet.getInt(4));
			session.setAttribute("status", "Yes");
			
		}
		preparedStatement.close();
		resultSet.close();
		query="select a.ASSET_CODE,nvl(b.ASSET_NAME,'--'),a.SOURCE_CODE,nvl(a.SOURCE_NAME,'--'),nvl(a.LOCATION,'--'),a.SAFE_LPD,a.UNSAFE_LPD,FLOURIDE,BRAKISH,IRON,NITRATE,nvl(to_char(a.UPDATE_DATE,'dd/mm/yyyy'),'--'),SOURCE_TYPE_CODE,nvl(STATUS,'') as status,nvl(YIELD,'--') as YIELD  from  rws_source_tbl a,rws_asset_mast_tbl b where a.HAB_CODE=? and TYPE_OF_ASSET_CODE ='01' and a.asset_code=b.asset_code";
		preparedStatement=connection.prepareStatement(query);
		preparedStatement.setString(1, habCode);
		resultSet=preparedStatement.executeQuery();
		while(resultSet.next()){
			mForm=new Rws_Habitation_Safe_Suplly_Form();
			mForm.setsNo(count++);
			mForm.setPwsAssetCode(resultSet.getString(1));
			mForm.setPwsAssetName(resultSet.getString(2));
			mForm.setPwsSourceCode(resultSet.getString(3));
			mForm.setPwsSourceName("PWS/"+resultSet.getString(4));
			mForm.setPwsLocation(resultSet.getString(5));
			mForm.setPwsSafeLPCD(resultSet.getInt(6));
			mForm.setPwsUnSafeLPCD(resultSet.getInt(7));
			mForm.setSourceType(resultSet.getString(13));
			mForm.setTableName("source");
			mForm.setSourceStatus(resultSet.getString("status"));
			mForm.setYield(resultSet.getString("YIELD"));
			mForm.setImageStatus(getImageStatus(resultSet.getString("ASSET_CODE"), resultSet.getString("SOURCE_CODE")));
			
			String waterBeging="select WATER_SUPP_FREQ from rws_asset_hab_tbl where asset_code=? and hab_code=?";
			preparedStatement1=connection.prepareStatement(waterBeging);
			preparedStatement1.setString(1,resultSet.getString(1));
			preparedStatement1.setString(2,habCode);
			resultSet1=preparedStatement1.executeQuery();
			if(resultSet1.next()){
				mForm.setWaterBeingSupplied(resultSet1.getString("WATER_SUPP_FREQ"));
			}
			preparedStatement1.close();
			resultSet1.close();
			
			String testResults="";
			
				testResults="select to_char(max(prepared_on),'dd/mm/yyyy') from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and source_code=? order by max(prepared_on) desc";
			preparedStatement1=connection.prepareStatement(testResults);
			preparedStatement1.setString(1,resultSet.getString(3));
			resultSet1=preparedStatement1.executeQuery();
			if(resultSet1.next()){
				if(resultSet1.getString(1)!=null && !resultSet1.getString(1).equals("")){
				mForm.setPreparedOn(resultSet1.getString(1));
				String flouride="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='13' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(flouride);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setFlouride(resultSet2.getString(1));
				}
				else{
					
					mForm.setFlouride("--");
					mForm.setTestid("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				
					
				String iron="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='16' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(iron);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setIron(resultSet2.getString(1));
					
				}
				else{
					mForm.setIron("--");
				}
				preparedStatement2.close();
				resultSet2.close();
				
					
				String nitrate="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='15' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(nitrate);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setNitrate(resultSet2.getString(1));
					
				}
				else{
					
					mForm.setNitrate("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				
					
				String barkish="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='05' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(barkish);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setBrakish(resultSet2.getString(1));
					
				}
				else{
					
					mForm.setBrakish("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				
				}
				else{
					mForm.setPreparedOn("--");
					mForm.setFlouride("--");
					mForm.setBrakish("--");
					mForm.setNitrate("--");
					mForm.setIron("--");
				}
			}
			else{
				mForm.setPreparedOn("--");
				mForm.setFlouride("--");
				mForm.setBrakish("--");
				mForm.setNitrate("--");
				mForm.setIron("--");
			}
			preparedStatement1.close();
			resultSet1.close();
			arrayList.add(mForm);
		}
		preparedStatement.close();
		resultSet.close();
		query="select a.ASSET_CODE,nvl(b.ASSET_NAME,'--'),a.GLSR_CODE,nvl(a.GLSR_LOC,'--'),a.GLSR_CAP_LTS  from  RWS_AST_GLSR_SC_PARAM_TBL a,rws_asset_mast_tbl b where substr(a.GLSR_CODE,1,16)=? and TYPE_OF_ASSET_CODE ='01' and a.asset_code=b.asset_code";
		preparedStatement=connection.prepareStatement(query);
		preparedStatement.setString(1, habCode);
		resultSet=preparedStatement.executeQuery();
		while(resultSet.next()){
			mForm=new Rws_Habitation_Safe_Suplly_Form();
			mForm.setsNo(count++);
			mForm.setPwsAssetCode(resultSet.getString(1));
			mForm.setPwsAssetName(resultSet.getString(2));
			mForm.setPwsSourceCode(resultSet.getString(3));
			mForm.setPwsLocation(resultSet.getString(4));
			mForm.setPwsSourceName("GLSR");
			mForm.setPwsSafeLPCD(resultSet.getInt(5));
			mForm.setYield("--");
			mForm.setImageStatus(getImageStatus(resultSet.getString("ASSET_CODE"), resultSet.getString("GLSR_CODE")));
			mForm.setTableName("glsr");
			String testResults="select to_char(max(prepared_on),'dd/mm/yyyy') from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and source_code=? order by max(prepared_on) desc";
			preparedStatement1=connection.prepareStatement(testResults);
			preparedStatement1.setString(1,resultSet.getString(3));
			resultSet1=preparedStatement1.executeQuery();
			if(resultSet1.next()){
				if(resultSet1.getString(1)!=null && !resultSet1.getString(1).equals("")){
				mForm.setPreparedOn(resultSet1.getString(1));
				String flouride="SELECT TESTING_PARAMETER_VALUE,a.test_id FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='13' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(flouride);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setFlouride(resultSet2.getString(1));
					mForm.setTestid(resultSet2.getString(2));
				}
				else{
					
					mForm.setFlouride("--");
					mForm.setTestid("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				String iron="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='16' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(iron);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setIron(resultSet2.getString(1));
					
				}
				else{
					mForm.setIron("--");
				}
				preparedStatement2.close();
				resultSet2.close();
				String nitrate="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='15' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(nitrate);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setNitrate(resultSet2.getString(1));
					
				}
				else{
					
					mForm.setNitrate("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				String barkish="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='05' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(barkish);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setBrakish(resultSet2.getString(1));
					
				}
				else{
					
					mForm.setBrakish("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				}
				else{
					mForm.setPreparedOn("--");
					mForm.setFlouride("--");
					mForm.setTestid("--");
					mForm.setBrakish("--");
					mForm.setNitrate("--");
					mForm.setIron("--");
				}
			}
			else{
				mForm.setPreparedOn("--");
				mForm.setFlouride("--");
				mForm.setTestid("--");
				mForm.setBrakish("--");
				mForm.setNitrate("--");
				mForm.setIron("--");
			}
			preparedStatement1.close();
			resultSet1.close();
			arrayList.add(mForm);
		}
		preparedStatement.close();
		resultSet.close();
		
		query="select a.ASSET_CODE,nvl(b.ASSET_NAME,'--'),a.OHSR_CODE,nvl(a.OHSR_LOC,'--'),a.OHSR_CAP_LTS  from  RWS_AST_OHSR_SC_PARAM_TBL a,rws_asset_mast_tbl b where substr(a.OHSR_CODE,1,16)=? and TYPE_OF_ASSET_CODE ='01' and a.asset_code=b.asset_code";
		preparedStatement=connection.prepareStatement(query);
		preparedStatement.setString(1, habCode);
		resultSet=preparedStatement.executeQuery();
		while(resultSet.next()){
			mForm=new Rws_Habitation_Safe_Suplly_Form();
			mForm.setsNo(count++);
			mForm.setPwsAssetCode(resultSet.getString(1));
			mForm.setPwsAssetName(resultSet.getString(2));
			mForm.setPwsSourceCode(resultSet.getString(3));
			mForm.setPwsSourceName("OHSR");
			mForm.setPwsLocation(resultSet.getString(4));
			mForm.setPwsSafeLPCD(resultSet.getInt(5));
			mForm.setTableName("ohsr");
			mForm.setYield("--");
			mForm.setImageStatus(getImageStatus(resultSet.getString("ASSET_CODE"), resultSet.getString("OHSR_CODE")));
			String testResults="select to_char(max(prepared_on),'dd/mm/yyyy') from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and source_code=? order by max(prepared_on) desc";
			preparedStatement1=connection.prepareStatement(testResults);
			preparedStatement1.setString(1,resultSet.getString(3));
			resultSet1=preparedStatement1.executeQuery();
			if(resultSet1.next()){
				if(resultSet1.getString(1)!=null && !resultSet1.getString(1).equals("")){
				mForm.setPreparedOn(resultSet1.getString(1));
				String flouride="SELECT TESTING_PARAMETER_VALUE,a.test_id FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='13' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(flouride);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setFlouride(resultSet2.getString(1));
					mForm.setTestid(resultSet2.getString(2));
				}
				else{
					
					mForm.setFlouride("--");
					mForm.setTestid("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				String iron="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='16' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(iron);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setIron(resultSet2.getString(1));
					
				}
				else{
					mForm.setIron("--");
				}
				preparedStatement2.close();
				resultSet2.close();
				String nitrate="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='15' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(nitrate);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setNitrate(resultSet2.getString(1));
					
				}
				else{
					
					mForm.setNitrate("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				String barkish="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='05' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(barkish);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setBrakish(resultSet2.getString(1));
					
				}
				else{
					
					mForm.setBrakish("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				}else{
					mForm.setPreparedOn("--");
					mForm.setFlouride("--");
					mForm.setTestid("--");
					mForm.setBrakish("--");
					mForm.setNitrate("--");
					mForm.setIron("--");
				}
				
			}
			else{
				mForm.setPreparedOn("--");
				mForm.setFlouride("--");
				mForm.setTestid("--");
				mForm.setBrakish("--");
				mForm.setNitrate("--");
				mForm.setIron("--");
			}
			preparedStatement1.close();
			resultSet1.close();
			arrayList.add(mForm);
		}
		preparedStatement.close();
		resultSet.close();
		}
		catch(Exception e){
			System.out.println("Exception at getHabitaionPWSSafeSupply in Rws_Habitation_Safe_Suplly_DAO"+e);
		}
		finally {
			try{
			if(connection!=null){
				connection.close();
			}
			}
			catch(Exception e){
				System.out.println("Exception at finally block of getHabitaionPWSSafeSupply in Rws_Habitation_Safe_Suplly_DAO"+e);
			}
		}
		return arrayList;
		
	}
	
	
	
	
	
	
public ArrayList getHabitaionCPWSLinksSafeSupply(Rws_Habitation_Safe_Suplly_Form mForm,HttpSession session) {
		
		ArrayList arrayList=new  ArrayList();
		Connection connection=null;
		PreparedStatement preparedStatement=null;
		ResultSet resultSet=null;
		
		String query="";
		int count=1;
		String habCode=mForm.getHabitation();
		try{
		connection=RwsOffices.getConn();
		query="select CPWS_HAB_SUPPLY from  rws_hab_supply_status_tbl where HAB_CODE=?";
		preparedStatement=connection.prepareStatement(query);
		preparedStatement.setString(1, habCode);
		resultSet=preparedStatement.executeQuery();
		if(resultSet.next()){
			mForm.setCpwsHabLinkLPCD(resultSet.getInt(1));
			session.setAttribute("status", "Yes");
		}
		preparedStatement.close();
		resultSet.close();
		
		query="select m.ASSET_CODE,nvl(m.ASSET_NAME,'--'),a.WATER_SUPP_FREQ from rws_asset_hab_tbl a,rws_asset_mast_tbl m where a.HAB_CODE=? and a.Hab_code<>m.hab_code and TYPE_OF_ASSET_CODE ='03' and a.asset_code=m.asset_code";
		preparedStatement=connection.prepareStatement(query);
		preparedStatement.setString(1, habCode);
		resultSet=preparedStatement.executeQuery();
		while(resultSet.next()){
			mForm=new Rws_Habitation_Safe_Suplly_Form();
			mForm.setsNo(count++);
			mForm.setCpwsLinksAssetCode(resultSet.getString(1));
			mForm.setCpwsLinksAssetName(resultSet.getString(2));
			mForm.setWaterBeingSupplied(resultSet.getString(3));
			arrayList.add(mForm);
		}
		preparedStatement.close();
		resultSet.close();
		}
		catch(Exception e){
			System.out.println("Exception at getHabitaionCPWSLinksSafeSupply in Rws_Habitation_Safe_Suplly_DAO"+e);
		}
		finally {
			try{
			if(connection!=null){
				connection.close();
			}
			}
			catch(Exception e){
				System.out.println("Exception at finally block of getHabitaionCPWSLinksSafeSupply in Rws_Habitation_Safe_Suplly_DAO"+e);
			}
		}
		return arrayList;
		
	}

public ArrayList getHabitaionCPWSLinksResSafeSupply(Rws_Habitation_Safe_Suplly_Form mForm, HttpSession session) {
	ArrayList arrayList = new ArrayList();
	Connection connection = null;
	PreparedStatement preparedStatement = null, preparedStatement1 = null, preparedStatement2 = null;
	ResultSet resultSet = null, resultSet1 = null, resultSet2 = null;
	String query = "";
	int count = 1;
	String habCode = mForm.getHabitation();
	try {
		connection = RwsOffices.getConn();

		query = "select a.ASSET_CODE,nvl(b.ASSET_NAME,'-'),a.GLSR_CODE,nvl(a.GLSR_LOC,'-'),c.YIELD  from  RWS_AST_GLSR_SC_PARAM_TBL a,rws_asset_mast_tbl b,RWS_OHGLCI_HAB_LINK_TBL c where a.GLSR_CODE=c.SUBCOMP_CODE and c.HAB_CODE=? and TYPE_OF_ASSET_CODE ='03' and a.asset_code=b.asset_code and c.hab_code<>substr(glsr_code,1,16)";
		preparedStatement = connection.prepareStatement(query);
		preparedStatement.setString(1, habCode);
		resultSet = preparedStatement.executeQuery();
		while (resultSet.next()) {
			mForm = new Rws_Habitation_Safe_Suplly_Form();
			mForm.setsNo(count++);
			mForm.setCpwsLinksAssetCode(resultSet.getString(1));
			mForm.setCpwsLinksAssetName(resultSet.getString(2));
			mForm.setCpwsLinksSourceCode(resultSet.getString(3));
			mForm.setCpwsLinksLocation(resultSet.getString(4));
			mForm.setCpwsLinksSourceName("GLSR");
			mForm.setCpwsLinksSafeLPCD(resultSet.getInt(5));
			mForm.setTableName("glsr");
			mForm.setYield("-");
			mForm.setImageStatus(
					getImageStatus(resultSet.getString("ASSET_CODE"), resultSet.getString("GLSR_CODE")));
			String testResults = "select to_char(max(prepared_on),'dd/mm/yyyy') from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and source_code=? order by max(prepared_on) desc";
			preparedStatement1 = connection.prepareStatement(testResults);
			preparedStatement1.setString(1, resultSet.getString(3));
			resultSet1 = preparedStatement1.executeQuery();
			if (resultSet1.next()) {
				if (resultSet1.getString(1) != null && !resultSet1.getString(1).equals("")) {
					mForm.setPreparedOn(resultSet1.getString(1));
					String flouride = "SELECT TESTING_PARAMETER_VALUE,a.test_id FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='13' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
					preparedStatement2 = connection.prepareStatement(flouride);
					preparedStatement2.setString(1, resultSet.getString(3));
					preparedStatement2.setString(2, resultSet1.getString(1));
					resultSet2 = preparedStatement2.executeQuery();
					if (resultSet2.next()) {
						mForm.setFlouride(resultSet2.getString(1));
						mForm.setTestid(resultSet2.getString(2));
					} else {
						mForm.setFlouride("-");
						mForm.setTestid("-");
					}
					preparedStatement2.close();
					resultSet2.close();
					String iron = "SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='16' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
					preparedStatement2 = connection.prepareStatement(iron);
					preparedStatement2.setString(1, resultSet.getString(3));
					preparedStatement2.setString(2, resultSet1.getString(1));
					resultSet2 = preparedStatement2.executeQuery();
					if (resultSet2.next()) {
						mForm.setIron(resultSet2.getString(1));
					} else {
						mForm.setIron("-");
					}
					preparedStatement2.close();
					resultSet2.close();
					String nitrate = "SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='15' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
					preparedStatement2 = connection.prepareStatement(nitrate);
					preparedStatement2.setString(1, resultSet.getString(3));
					preparedStatement2.setString(2, resultSet1.getString(1));
					resultSet2 = preparedStatement2.executeQuery();
					if (resultSet2.next()) {
						mForm.setNitrate(resultSet2.getString(1));
					} else {
						mForm.setNitrate("-");
					}
					preparedStatement2.close();
					resultSet2.close();
					String barkish = "SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='05' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
					preparedStatement2 = connection.prepareStatement(barkish);
					preparedStatement2.setString(1, resultSet.getString(3));
					preparedStatement2.setString(2, resultSet1.getString(1));
					resultSet2 = preparedStatement2.executeQuery();
					if (resultSet2.next()) {
						mForm.setBrakish(resultSet2.getString(1));
					} else {
						mForm.setBrakish("-");
					}
					preparedStatement2.close();
					resultSet2.close();
				} else {
					mForm.setPreparedOn("-");
					mForm.setFlouride("-");
					mForm.setTestid("-");
					mForm.setBrakish("-");
					mForm.setNitrate("-");
					mForm.setIron("-");
				}
			} else {
				mForm.setPreparedOn("-");
				mForm.setFlouride("-");
				mForm.setTestid("-");
				mForm.setBrakish("-");
				mForm.setNitrate("-");
				mForm.setIron("-");
			}
			preparedStatement1.close();
			resultSet1.close();
			arrayList.add(mForm);
		}
		preparedStatement.close();
		resultSet.close();

		query = "select a.ASSET_CODE,nvl(b.ASSET_NAME,'-'),a.OHSR_CODE,nvl(a.OHSR_LOC,'-'),c.YIELD  from  RWS_AST_OHSR_SC_PARAM_TBL a,rws_asset_mast_tbl b,RWS_OHGLCI_HAB_LINK_TBL c where a.OHSR_CODE=c.SUBCOMP_CODE and c.HAB_CODE=? and TYPE_OF_ASSET_CODE ='03' and a.asset_code=b.asset_code and c.hab_code<>substr(ohsr_code,1,16)";
		preparedStatement = connection.prepareStatement(query);
		preparedStatement.setString(1, habCode);
		resultSet = preparedStatement.executeQuery();
		while (resultSet.next()) {
			mForm = new Rws_Habitation_Safe_Suplly_Form();
			mForm.setsNo(count++);
			mForm.setCpwsLinksAssetCode(resultSet.getString(1));
			mForm.setCpwsLinksAssetName(resultSet.getString(2));
			mForm.setCpwsLinksSourceCode(resultSet.getString(3));
			mForm.setCpwsLinksSourceName("OHSR");
			mForm.setCpwsLinksLocation(resultSet.getString(4));
			mForm.setCpwsLinksSafeLPCD(resultSet.getInt(5));
			mForm.setTableName("ohsr");
			mForm.setYield("-");
			mForm.setImageStatus(
					getImageStatus(resultSet.getString("ASSET_CODE"), resultSet.getString("OHSR_CODE")));

			String testResults = "select to_char(max(prepared_on),'dd/mm/yyyy') from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and source_code=? order by max(prepared_on) desc";
			preparedStatement1 = connection.prepareStatement(testResults);
			preparedStatement1.setString(1, resultSet.getString(3));
			resultSet1 = preparedStatement1.executeQuery();
			if (resultSet1.next()) {
				if (resultSet1.getString(1) != null && !resultSet1.getString(1).equals("")) {
					mForm.setPreparedOn(resultSet1.getString(1));
					String flouride = "SELECT TESTING_PARAMETER_VALUE,a.test_id FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='13' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
					preparedStatement2 = connection.prepareStatement(flouride);
					preparedStatement2.setString(1, resultSet.getString(3));
					preparedStatement2.setString(2, resultSet1.getString(1));
					resultSet2 = preparedStatement2.executeQuery();
					if (resultSet2.next()) {
						mForm.setFlouride(resultSet2.getString(1));
						mForm.setTestid(resultSet2.getString(2));
					} else {
						mForm.setFlouride("-");
						mForm.setTestid("-");
					}
					preparedStatement2.close();
					resultSet2.close();
					String iron = "SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='16' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
					preparedStatement2 = connection.prepareStatement(iron);
					preparedStatement2.setString(1, resultSet.getString(3));
					preparedStatement2.setString(2, resultSet1.getString(1));
					resultSet2 = preparedStatement2.executeQuery();
					if (resultSet2.next()) {
						mForm.setIron(resultSet2.getString(1));
					} else {
						mForm.setIron("-");
					}
					preparedStatement2.close();
					resultSet2.close();
					String nitrate = "SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='15' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
					preparedStatement2 = connection.prepareStatement(nitrate);
					preparedStatement2.setString(1, resultSet.getString(3));
					preparedStatement2.setString(2, resultSet1.getString(1));
					resultSet2 = preparedStatement2.executeQuery();
					if (resultSet2.next()) {
						mForm.setNitrate(resultSet2.getString(1));
					} else {
						mForm.setNitrate("-");
					}
					preparedStatement2.close();
					resultSet2.close();
					String barkish = "SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='05' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
					preparedStatement2 = connection.prepareStatement(barkish);
					preparedStatement2.setString(1, resultSet.getString(3));
					preparedStatement2.setString(2, resultSet1.getString(1));
					resultSet2 = preparedStatement2.executeQuery();
					if (resultSet2.next()) {
						mForm.setBrakish(resultSet2.getString(1));
					} else {
						mForm.setBrakish("-");
					}
					preparedStatement2.close();
					resultSet2.close();
				} else {
					mForm.setPreparedOn("-");
					mForm.setFlouride("-");
					mForm.setTestid("-");
					mForm.setBrakish("-");
					mForm.setNitrate("-");
					mForm.setIron("-");
				}
			} else {
				mForm.setPreparedOn("-");
				mForm.setFlouride("-");
				mForm.setTestid("-");
				mForm.setBrakish("-");
				mForm.setNitrate("-");
				mForm.setIron("-");
			}
			preparedStatement1.close();
			resultSet1.close();
			arrayList.add(mForm);
		}
		preparedStatement.close();
		resultSet.close();
	} catch (Exception e) {
		System.out.println("Exception at getHabitaionCPWSLinksSafeSupply in Rws_Habitation_Safe_Suplly_DAO" + e);
	} finally {
		try {
			if (connection != null) {
				connection.close();
			}
		} catch (Exception e) {
			System.out.println(
					"Exception at finally block of getHabitaionCPWSLinksSafeSupply in Rws_Habitation_Safe_Suplly_DAO"
							+ e);
		}
	}
	return arrayList;

}


public ArrayList getHabitaionPWSLinksSafeSupply(Rws_Habitation_Safe_Suplly_Form mForm,HttpSession session) {
	
	ArrayList arrayList=new  ArrayList();
	Connection connection=null;
	PreparedStatement preparedStatement=null;
	ResultSet resultSet=null;
	PreparedStatement preparedStatement1=null;
	ResultSet resultSet1=null;
	PreparedStatement preparedStatement2=null;
	ResultSet resultSet2=null;
	String query="";
	int count=1;
	String habCode=mForm.getHabitation();
	try{
	connection=RwsOffices.getConn();
	query="select PWS_HAB_SUPPLY,PWS_HAB_UNSAFE_SUPPLY from  rws_hab_supply_status_tbl where HAB_CODE=?";
	preparedStatement=connection.prepareStatement(query);
	preparedStatement.setString(1, habCode);
	resultSet=preparedStatement.executeQuery();
	if(resultSet.next()){
		mForm.setPwsHabLinkLPCD(resultSet.getInt(1));
		mForm.setPwsHabLinkUnsafeLPCD(resultSet.getInt(2));
		session.setAttribute("status", "Yes");
	}
	preparedStatement.close();
	resultSet.close();	
	
	query="select m.ASSET_CODE,nvl(m.ASSET_NAME,'--') as assetname,a.WATER_SUPP_FREQ from rws_asset_hab_tbl a,rws_asset_mast_tbl m where a.HAB_CODE=? and a.Hab_code<>m.hab_code and TYPE_OF_ASSET_CODE ='01' and a.asset_code=m.asset_code";
	preparedStatement=connection.prepareStatement(query);
	preparedStatement.setString(1, habCode);
	resultSet=preparedStatement.executeQuery();
	//System.out.println(query);
	while(resultSet.next()){
		int souCount=0;
		String souCountqry="select count(*) from RWS_SOURCE_HABITATION_TBL a,RWS_SOURCE_TBL b where a.SOURCE_CODE=b.SOURCE_CODE and a.HAB_CODE=? and b.ASSET_CODE=?";
		preparedStatement2=connection.prepareStatement(souCountqry);
		preparedStatement2.setString(1, habCode);
		preparedStatement2.setString(2, resultSet.getString(1));
		ResultSet souCountRs=preparedStatement2.executeQuery();
		//System.out.println(souCountqry);
		if(souCountRs.next()) {
			souCount=souCountRs.getInt(1);
		}
		preparedStatement2.close();
		souCountRs.close();
		if(souCount==0) {
			mForm=new Rws_Habitation_Safe_Suplly_Form();
			mForm.setsNo(count++);
			mForm.setPwsLinksAssetCode(resultSet.getString("ASSET_CODE"));
			mForm.setPwsLinksAssetName(resultSet.getString("assetname"));
			mForm.setWaterBeingSupplied(resultSet.getString("WATER_SUPP_FREQ"));	
			mForm.setPwsLinksSourceCode("--");
			mForm.setPwsLinksSourceName("--");
			mForm.setPwsLinksLocation("--");
			mForm.setPwsLinksSafeLPCD(0);
			mForm.setPwsLinksUnSafeLPCD(0);
			mForm.setSourceType("--");
			mForm.setTableName("source");
			mForm.setSourceStatus("--");
			mForm.setYield("--");
			mForm.setImageStatus("No");
			mForm.setPreparedOn("--");
			mForm.setFlouride("--");
			mForm.setBrakish("--");
			mForm.setNitrate("--");
			mForm.setIron("--");
			arrayList.add(mForm);
		}else {		
			String sourceHabQry="select b.SOURCE_CODE,nvl(b.SOURCE_NAME,'--') as SOURCE_NAME,nvl(b.LOCATION,'--') as LOCATION,nvl(safe_supply,0) as safe_supply ,nvl(unsafe_supply,0) as unsafe_supply,nvl(to_char(b.UPDATE_DATE,'dd/mm/yyyy'),'--'),SOURCE_TYPE_CODE,nvl(STATUS,'') as status,nvl(b.YIELD,'--') as YIELD from RWS_SOURCE_HABITATION_TBL a,RWS_SOURCE_TBL b where a.SOURCE_CODE=b.SOURCE_CODE and a.HAB_CODE=? and b.ASSET_CODE=?";
			preparedStatement2=connection.prepareStatement(sourceHabQry);
			preparedStatement2.setString(1, habCode);
			preparedStatement2.setString(2, resultSet.getString(1));
			ResultSet souHabRs=preparedStatement2.executeQuery();
			while(souHabRs.next()) {			
				mForm=new Rws_Habitation_Safe_Suplly_Form();
				mForm.setsNo(count++);
				mForm.setPwsLinksAssetCode(resultSet.getString("ASSET_CODE"));
				mForm.setPwsLinksAssetName(resultSet.getString("assetname"));
				mForm.setWaterBeingSupplied(resultSet.getString("WATER_SUPP_FREQ"));	
				mForm.setPwsLinksSourceCode(souHabRs.getString("SOURCE_CODE"));
				mForm.setPwsLinksSourceName("PWS/"+souHabRs.getString("SOURCE_NAME"));
				mForm.setPwsLinksLocation(souHabRs.getString("LOCATION"));
				mForm.setPwsLinksSafeLPCD(souHabRs.getInt("safe_supply"));
				mForm.setPwsLinksUnSafeLPCD(souHabRs.getInt("unsafe_supply"));
				mForm.setSourceType(souHabRs.getString("SOURCE_TYPE_CODE"));
				mForm.setTableName("source");
				mForm.setSourceStatus(souHabRs.getString("status"));
				mForm.setYield(souHabRs.getString("YIELD"));
				mForm.setImageStatus(getImageStatus(resultSet.getString("ASSET_CODE"), souHabRs.getString("SOURCE_CODE")));			
				
			String testResults="select to_char(max(prepared_on),'dd/mm/yyyy') from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and source_code=? order by max(prepared_on) desc";
			preparedStatement1=connection.prepareStatement(testResults);
			preparedStatement1.setString(1,souHabRs.getString("SOURCE_CODE"));
			resultSet1=preparedStatement1.executeQuery();
			if(resultSet1.next()){
				if(resultSet1.getString(1)!=null && !resultSet1.getString(1).equals("")){
				mForm.setPreparedOn(resultSet1.getString(1));
				String flouride="SELECT TESTING_PARAMETER_VALUE,a.test_id FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='13' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(flouride);
				preparedStatement2.setString(1,souHabRs.getString("SOURCE_CODE"));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setFlouride(resultSet2.getString(1));
					mForm.setTestid(resultSet2.getString(2));
				}
				else{				
					mForm.setFlouride("--");
					mForm.setTestid("--");
				}
				preparedStatement2.close();
				resultSet2.close();
				String iron="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='16' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(iron);
				preparedStatement2.setString(1,souHabRs.getString("SOURCE_CODE"));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setIron(resultSet2.getString(1));				
				}
				else{
					mForm.setIron("--");
				}
				preparedStatement2.close();
				resultSet2.close();
				String nitrate="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='15' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(nitrate);
				preparedStatement2.setString(1,souHabRs.getString("SOURCE_CODE"));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setNitrate(resultSet2.getString(1));				
				}
				else{
					
					mForm.setNitrate("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				String barkish="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='05' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(barkish);
				preparedStatement2.setString(1,souHabRs.getString("SOURCE_CODE"));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setBrakish(resultSet2.getString(1));				
				}
				else{
					
					mForm.setBrakish("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				}
				else{
					mForm.setPreparedOn("--");
					mForm.setFlouride("--");
					mForm.setTestid("--");
					mForm.setBrakish("--");
					mForm.setNitrate("--");
					mForm.setIron("--");
				}
			}
			else{
				mForm.setPreparedOn("--");
				mForm.setFlouride("--");
				mForm.setTestid("--");
				mForm.setBrakish("--");
				mForm.setNitrate("--");
				mForm.setIron("--");
			}
			preparedStatement1.close();
			resultSet1.close();
			arrayList.add(mForm);
			}
		}
	}
	preparedStatement.close();
	resultSet.close();
	
	query = "select a.ASSET_CODE,nvl(b.ASSET_NAME,'-'),a.GLSR_CODE,nvl(a.GLSR_LOC,'-'),c.YIELD  from  RWS_AST_GLSR_SC_PARAM_TBL a,rws_asset_mast_tbl b,RWS_OHGLCI_HAB_LINK_TBL c where a.GLSR_CODE=c.SUBCOMP_CODE and c.HAB_CODE=? and TYPE_OF_ASSET_CODE ='01' and a.asset_code=b.asset_code and c.hab_code<>substr(glsr_code,1,16)";
	preparedStatement = connection.prepareStatement(query);
	preparedStatement.setString(1, habCode);
	resultSet = preparedStatement.executeQuery();
	while (resultSet.next()) {
		mForm = new Rws_Habitation_Safe_Suplly_Form();
		mForm.setsNo(count++);
		mForm.setPwsLinksAssetCode(resultSet.getString(1));
		mForm.setPwsLinksAssetName(resultSet.getString(2));
		mForm.setPwsLinksSourceCode(resultSet.getString(3));
		mForm.setPwsLinksLocation(resultSet.getString(4));
		mForm.setPwsLinksSourceName("GLSR");
		mForm.setPwsLinksSafeLPCD(resultSet.getInt(5));
		mForm.setYield("-");
		mForm.setImageStatus(
				getImageStatus(resultSet.getString("ASSET_CODE"), resultSet.getString("GLSR_CODE")));
		mForm.setTableName("glsr");
		String testResults = "select to_char(max(prepared_on),'dd/mm/yyyy') from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and source_code=? order by max(prepared_on) desc";
		preparedStatement1 = connection.prepareStatement(testResults);
		preparedStatement1.setString(1, resultSet.getString(3));
		resultSet1 = preparedStatement1.executeQuery();
		if (resultSet1.next()) {
			if (resultSet1.getString(1) != null && !resultSet1.getString(1).equals("")) {
				mForm.setPreparedOn(resultSet1.getString(1));
				String flouride = "SELECT TESTING_PARAMETER_VALUE,a.test_id FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='13' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2 = connection.prepareStatement(flouride);
				preparedStatement2.setString(1, resultSet.getString(3));
				preparedStatement2.setString(2, resultSet1.getString(1));
				resultSet2 = preparedStatement2.executeQuery();
				if (resultSet2.next()) {
					mForm.setFlouride(resultSet2.getString(1));
					mForm.setTestid(resultSet2.getString(2));
				} else {
					mForm.setFlouride("-");
					mForm.setTestid("-");
				}
				preparedStatement2.close();
				resultSet2.close();
				String iron = "SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='16' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2 = connection.prepareStatement(iron);
				preparedStatement2.setString(1, resultSet.getString(3));
				preparedStatement2.setString(2, resultSet1.getString(1));
				resultSet2 = preparedStatement2.executeQuery();
				if (resultSet2.next()) {
					mForm.setIron(resultSet2.getString(1));
				} else {
					mForm.setIron("-");
				}
				preparedStatement2.close();
				resultSet2.close();
				String nitrate = "SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='15' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2 = connection.prepareStatement(nitrate);
				preparedStatement2.setString(1, resultSet.getString(3));
				preparedStatement2.setString(2, resultSet1.getString(1));
				resultSet2 = preparedStatement2.executeQuery();
				if (resultSet2.next()) {
					mForm.setNitrate(resultSet2.getString(1));
				} else {
					mForm.setNitrate("-");
				}
				preparedStatement2.close();
				resultSet2.close();
				String barkish = "SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='05' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2 = connection.prepareStatement(barkish);
				preparedStatement2.setString(1, resultSet.getString(3));
				preparedStatement2.setString(2, resultSet1.getString(1));
				resultSet2 = preparedStatement2.executeQuery();
				if (resultSet2.next()) {
					mForm.setBrakish(resultSet2.getString(1));
				} else {
					mForm.setBrakish("-");
				}
				preparedStatement2.close();
				resultSet2.close();
			} else {
				mForm.setPreparedOn("-");
				mForm.setFlouride("-");
				mForm.setTestid("-");
				mForm.setBrakish("-");
				mForm.setNitrate("-");
				mForm.setIron("-");
			}
		} else {
			mForm.setPreparedOn("-");
			mForm.setFlouride("-");
			mForm.setTestid("-");
			mForm.setBrakish("-");
			mForm.setNitrate("-");
			mForm.setIron("-");
		}
		preparedStatement1.close();
		resultSet1.close();
		arrayList.add(mForm);
	}
	preparedStatement.close();
	resultSet.close();

	query = "select a.ASSET_CODE,nvl(b.ASSET_NAME,'-'),a.OHSR_CODE,nvl(a.OHSR_LOC,'-'),c.YIELD  from  RWS_AST_OHSR_SC_PARAM_TBL a,rws_asset_mast_tbl b,RWS_OHGLCI_HAB_LINK_TBL c where a.OHSR_CODE=c.SUBCOMP_CODE and c.HAB_CODE=? and TYPE_OF_ASSET_CODE ='01' and a.asset_code=b.asset_code and c.hab_code<>substr(ohsr_code,1,16)";
	preparedStatement = connection.prepareStatement(query);
	preparedStatement.setString(1, habCode);
	resultSet = preparedStatement.executeQuery();
	while (resultSet.next()) {
		mForm = new Rws_Habitation_Safe_Suplly_Form();
		mForm.setsNo(count++);
		mForm.setPwsLinksAssetCode(resultSet.getString(1));
		mForm.setPwsLinksAssetName(resultSet.getString(2));
		mForm.setPwsLinksSourceCode(resultSet.getString(3));
		mForm.setPwsLinksSourceName("OHSR");
		mForm.setPwsLinksLocation(resultSet.getString(4));
		mForm.setPwsLinksSafeLPCD(resultSet.getInt(5));
		mForm.setTableName("ohsr");
		mForm.setYield("-");
		mForm.setImageStatus(
				getImageStatus(resultSet.getString("ASSET_CODE"), resultSet.getString("OHSR_CODE")));
		String testResults = "select to_char(max(prepared_on),'dd/mm/yyyy') from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and source_code=? order by max(prepared_on) desc";
		preparedStatement1 = connection.prepareStatement(testResults);
		preparedStatement1.setString(1, resultSet.getString(3));
		resultSet1 = preparedStatement1.executeQuery();
		if (resultSet1.next()) {
			if (resultSet1.getString(1) != null && !resultSet1.getString(1).equals("")) {
				mForm.setPreparedOn(resultSet1.getString(1));
				String flouride = "SELECT TESTING_PARAMETER_VALUE,a.test_id FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='13' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2 = connection.prepareStatement(flouride);
				preparedStatement2.setString(1, resultSet.getString(3));
				preparedStatement2.setString(2, resultSet1.getString(1));
				resultSet2 = preparedStatement2.executeQuery();
				if (resultSet2.next()) {
					mForm.setFlouride(resultSet2.getString(1));
					mForm.setTestid(resultSet2.getString(2));
				} else {
					mForm.setFlouride("-");
					mForm.setTestid("-");
				}
				preparedStatement2.close();
				resultSet2.close();
				String iron = "SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='16' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2 = connection.prepareStatement(iron);
				preparedStatement2.setString(1, resultSet.getString(3));
				preparedStatement2.setString(2, resultSet1.getString(1));
				resultSet2 = preparedStatement2.executeQuery();
				if (resultSet2.next()) {
					mForm.setIron(resultSet2.getString(1));
				} else {
					mForm.setIron("-");
				}
				preparedStatement2.close();
				resultSet2.close();
				String nitrate = "SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='15' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2 = connection.prepareStatement(nitrate);
				preparedStatement2.setString(1, resultSet.getString(3));
				preparedStatement2.setString(2, resultSet1.getString(1));
				resultSet2 = preparedStatement2.executeQuery();
				if (resultSet2.next()) {
					mForm.setNitrate(resultSet2.getString(1));
				} else {
					mForm.setNitrate("-");
				}
				preparedStatement2.close();
				resultSet2.close();
				String barkish = "SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='05' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2 = connection.prepareStatement(barkish);
				preparedStatement2.setString(1, resultSet.getString(3));
				preparedStatement2.setString(2, resultSet1.getString(1));
				resultSet2 = preparedStatement2.executeQuery();
				if (resultSet2.next()) {
					mForm.setBrakish(resultSet2.getString(1));
				} else {
					mForm.setBrakish("-");
				}
				preparedStatement2.close();
				resultSet2.close();
			} else {
				mForm.setPreparedOn("-");
				mForm.setFlouride("-");
				mForm.setTestid("-");
				mForm.setBrakish("-");
				mForm.setNitrate("-");
				mForm.setIron("-");
			}
		} else {
			mForm.setPreparedOn("-");
			mForm.setFlouride("-");
			mForm.setTestid("-");
			mForm.setBrakish("-");
			mForm.setNitrate("-");
			mForm.setIron("-");
		}
		preparedStatement1.close();
		resultSet1.close();
		arrayList.add(mForm);
	}
	preparedStatement.close();
	resultSet.close();
	}
	catch(Exception e){
		System.out.println("Exception at getHabitaionPWSLinksSafeSupply in Rws_Habitation_Safe_Suplly_DAO"+e);
	}
	finally {
		try{
		if(connection!=null){
			connection.close();
		}
		}
		catch(Exception e){
			System.out.println("Exception at finally block of getHabitaionPWSLinksSafeSupply in Rws_Habitation_Safe_Suplly_DAO"+e);
		}
	}
	return arrayList;
}


public ArrayList getHabitaionMPWSLinksSafeSupply(Rws_Habitation_Safe_Suplly_Form mForm,HttpSession session) {

	
	ArrayList arrayList=new  ArrayList();
	Connection connection=null;
	PreparedStatement preparedStatement=null;
	ResultSet resultSet=null;
	PreparedStatement preparedStatement1=null;
	ResultSet resultSet1=null;
	PreparedStatement preparedStatement2=null;
	ResultSet resultSet2=null;
	
	String query="";
	int count=1;
	String habCode=mForm.getHabitation();
	try{
	connection=RwsOffices.getConn();
	query="select MPWS_HAB_SUPPLY,MPWS_HAB_UNSAFE_SUPPLY from  rws_hab_supply_status_tbl where HAB_CODE=?";
	preparedStatement=connection.prepareStatement(query);
	preparedStatement.setString(1, habCode);
	resultSet=preparedStatement.executeQuery();
	if(resultSet.next()){
		mForm.setMpwsHabLinkLPCD(resultSet.getInt(1));
		mForm.setMpwsHabLinkUnsafeLPCD(resultSet.getInt(2));
		session.setAttribute("status", "Yes");
	}
	preparedStatement.close();
	resultSet.close();
	
	query="select m.ASSET_CODE,nvl(m.ASSET_NAME,'--') as assetname,a.WATER_SUPP_FREQ from rws_asset_hab_tbl a,rws_asset_mast_tbl m where a.HAB_CODE=? and a.Hab_code<>m.hab_code and TYPE_OF_ASSET_CODE ='02' and a.asset_code=m.asset_code";
	preparedStatement=connection.prepareStatement(query);
	preparedStatement.setString(1, habCode);
	resultSet=preparedStatement.executeQuery();
	while(resultSet.next()){
		int souCount=0;
		String souCountqry="select count(*) from RWS_SOURCE_HABITATION_TBL a,RWS_SOURCE_TBL b where a.SOURCE_CODE=b.SOURCE_CODE and a.HAB_CODE=? and b.ASSET_CODE=?";
		preparedStatement2=connection.prepareStatement(souCountqry);
		preparedStatement2.setString(1, habCode);
		preparedStatement2.setString(2, resultSet.getString(1));
		ResultSet souCountRs=preparedStatement2.executeQuery();
		if(souCountRs.next()) {
			souCount=souCountRs.getInt(1);
		}
		preparedStatement2.close();
		souCountRs.close();
		if(souCount==0) {			
			mForm=new Rws_Habitation_Safe_Suplly_Form();
			mForm.setsNo(count++);
			mForm.setMpwsLinksAssetCode(resultSet.getString("ASSET_CODE"));
			mForm.setMpwsLinksAssetName(resultSet.getString("assetname"));
			mForm.setWaterBeingSupplied(resultSet.getString("WATER_SUPP_FREQ"));	
			mForm.setMpwsLinksSourceCode("--");
			mForm.setMpwsLinksSourceName("--");
			mForm.setMpwsLinksLocation("--");
			mForm.setMpwsLinksSafeLPCD(0);
			mForm.setMpwsLinksUnSafeLPCD(0);
			mForm.setSourceType("--");
			mForm.setTableName("source");
			mForm.setSourceStatus("--");
			mForm.setYield("--");
			mForm.setImageStatus("No");
			mForm.setPreparedOn("--");
			mForm.setFlouride("--");
			mForm.setBrakish("--");
			mForm.setNitrate("--");
			mForm.setIron("--");
			arrayList.add(mForm);
		}else {		
			String sourceHabQry="select b.SOURCE_CODE,nvl(b.SOURCE_NAME,'--') as SOURCE_NAME,nvl(b.LOCATION,'--') as LOCATION,nvl(safe_supply,0) as safe_supply ,nvl(unsafe_supply,0) as unsafe_supply,nvl(to_char(b.UPDATE_DATE,'dd/mm/yyyy'),'--'),SOURCE_TYPE_CODE,nvl(STATUS,'') as status,nvl(b.YIELD,'--') as YIELD from RWS_SOURCE_HABITATION_TBL a,RWS_SOURCE_TBL b where a.SOURCE_CODE=b.SOURCE_CODE and a.HAB_CODE=? and b.ASSET_CODE=?";
			preparedStatement2=connection.prepareStatement(sourceHabQry);
			preparedStatement2.setString(1, habCode);
			preparedStatement2.setString(2, resultSet.getString(1));
			
			ResultSet souHabRs=preparedStatement2.executeQuery();
			while(souHabRs.next()) {			
				mForm=new Rws_Habitation_Safe_Suplly_Form();
				mForm.setsNo(count++);
				mForm.setMpwsLinksAssetCode(resultSet.getString("ASSET_CODE"));
				mForm.setMpwsLinksAssetName(resultSet.getString("assetname"));
				mForm.setWaterBeingSupplied(resultSet.getString("WATER_SUPP_FREQ"));	
				mForm.setMpwsLinksSourceCode(souHabRs.getString("SOURCE_CODE"));
				mForm.setMpwsLinksSourceName("MPWS/"+souHabRs.getString("SOURCE_NAME"));
				mForm.setMpwsLinksLocation(souHabRs.getString("LOCATION"));
				mForm.setMpwsLinksSafeLPCD(souHabRs.getInt("safe_supply"));
				mForm.setMpwsLinksUnSafeLPCD(souHabRs.getInt("unsafe_supply"));
				mForm.setSourceType(souHabRs.getString("SOURCE_TYPE_CODE"));
				mForm.setTableName("source");
				mForm.setSourceStatus(souHabRs.getString("status"));
				mForm.setYield(souHabRs.getString("YIELD"));
				mForm.setImageStatus(getImageStatus(resultSet.getString("ASSET_CODE"), souHabRs.getString("SOURCE_CODE")));			
				
			String testResults="select to_char(max(prepared_on),'dd/mm/yyyy') from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and source_code=? order by max(prepared_on) desc";
			preparedStatement1=connection.prepareStatement(testResults);
			preparedStatement1.setString(1,souHabRs.getString("SOURCE_CODE"));
			resultSet1=preparedStatement1.executeQuery();
			if(resultSet1.next()){
				if(resultSet1.getString(1)!=null && !resultSet1.getString(1).equals("")){
				mForm.setPreparedOn(resultSet1.getString(1));
				String flouride="SELECT TESTING_PARAMETER_VALUE,a.test_id FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='13' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(flouride);
				preparedStatement2.setString(1,souHabRs.getString("SOURCE_CODE"));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setFlouride(resultSet2.getString(1));
					mForm.setTestid(resultSet2.getString(2));
				}
				else{				
					mForm.setFlouride("--");
					mForm.setTestid("--");
				}
				preparedStatement2.close();
				resultSet2.close();
				String iron="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='16' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(iron);
				preparedStatement2.setString(1,souHabRs.getString("SOURCE_CODE"));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setIron(resultSet2.getString(1));				
				}
				else{
					mForm.setIron("--");
				}
				preparedStatement2.close();
				resultSet2.close();
				String nitrate="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='15' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(nitrate);
				preparedStatement2.setString(1,souHabRs.getString("SOURCE_CODE"));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setNitrate(resultSet2.getString(1));				
				}
				else{					
					mForm.setNitrate("--");					
				}
				preparedStatement2.close();
				resultSet2.close();
				String barkish="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='05' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(barkish);
				preparedStatement2.setString(1,souHabRs.getString("SOURCE_CODE"));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setBrakish(resultSet2.getString(1));				
				}
				else{
					
					mForm.setBrakish("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				}
				else{
					mForm.setPreparedOn("--");
					mForm.setFlouride("--");
					mForm.setTestid("--");
					mForm.setBrakish("--");
					mForm.setNitrate("--");
					mForm.setIron("--");
				}
			}
			else{
				mForm.setPreparedOn("--");
				mForm.setFlouride("--");
				mForm.setTestid("--");
				mForm.setBrakish("--");
				mForm.setNitrate("--");
				mForm.setIron("--");
			}
			preparedStatement1.close();
			resultSet1.close();
			arrayList.add(mForm);
			}
		}
	}
	preparedStatement.close();
	resultSet.close();
	query = "select a.ASSET_CODE,nvl(b.ASSET_NAME,'-'),a.GLSR_CODE,nvl(a.GLSR_LOC,'-'),c.YIELD  from  RWS_AST_GLSR_SC_PARAM_TBL a,rws_asset_mast_tbl b,RWS_OHGLCI_HAB_LINK_TBL c where a.GLSR_CODE=c.SUBCOMP_CODE and c.HAB_CODE=? and TYPE_OF_ASSET_CODE ='02' and a.asset_code=b.asset_code and c.hab_code<>substr(glsr_code,1,16)";
	preparedStatement = connection.prepareStatement(query);
	preparedStatement.setString(1, habCode);
	resultSet = preparedStatement.executeQuery();
	System.out.println(query);
	while (resultSet.next()) {
		mForm = new Rws_Habitation_Safe_Suplly_Form();
		mForm.setsNo(count++);
		mForm.setMpwsLinksAssetCode(resultSet.getString(1));
		mForm.setMpwsLinksAssetName(resultSet.getString(2));
		mForm.setMpwsLinksSourceCode(resultSet.getString(3));
		mForm.setMpwsLinksLocation(resultSet.getString(4));
		mForm.setMpwsLinksSourceName("GLSR");
		mForm.setMpwsLinksSafeLPCD(resultSet.getInt(5));
		mForm.setYield("-");
		mForm.setImageStatus(
				getImageStatus(resultSet.getString("ASSET_CODE"), resultSet.getString("GLSR_CODE")));
		mForm.setTableName("glsr");
		mForm.setYield("-");
		String testResults = "select to_char(max(prepared_on),'dd/mm/yyyy') from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and source_code=? order by max(prepared_on) desc";
		preparedStatement1 = connection.prepareStatement(testResults);
		preparedStatement1.setString(1, resultSet.getString(3));
		resultSet1 = preparedStatement1.executeQuery();
		if (resultSet1.next()) {
			if (resultSet1.getString(1) != null && !resultSet1.getString(1).equals("")) {
				mForm.setPreparedOn(resultSet1.getString(1));
				String flouride = "SELECT TESTING_PARAMETER_VALUE,a.test_id FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='13' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2 = connection.prepareStatement(flouride);
				preparedStatement2.setString(1, resultSet.getString(3));
				preparedStatement2.setString(2, resultSet1.getString(1));
				resultSet2 = preparedStatement2.executeQuery();
				if (resultSet2.next()) {
					mForm.setFlouride(resultSet2.getString(1));
					mForm.setTestid(resultSet2.getString(2));
				} else {
					mForm.setFlouride("-");
					mForm.setTestid("-");
				}
				preparedStatement2.close();
				resultSet2.close();
				String iron = "SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='16' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2 = connection.prepareStatement(iron);
				preparedStatement2.setString(1, resultSet.getString(3));
				preparedStatement2.setString(2, resultSet1.getString(1));
				resultSet2 = preparedStatement2.executeQuery();
				if (resultSet2.next()) {
					mForm.setIron(resultSet2.getString(1));
				} else {
					mForm.setIron("-");
				}
				preparedStatement2.close();
				resultSet2.close();
				String nitrate = "SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='15' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2 = connection.prepareStatement(nitrate);
				preparedStatement2.setString(1, resultSet.getString(3));
				preparedStatement2.setString(2, resultSet1.getString(1));
				resultSet2 = preparedStatement2.executeQuery();
				if (resultSet2.next()) {
					mForm.setNitrate(resultSet2.getString(1));
				} else {
					mForm.setNitrate("-");
				}
				preparedStatement2.close();
				resultSet2.close();
				String barkish = "SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='05' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2 = connection.prepareStatement(barkish);
				preparedStatement2.setString(1, resultSet.getString(3));
				preparedStatement2.setString(2, resultSet1.getString(1));
				resultSet2 = preparedStatement2.executeQuery();
				if (resultSet2.next()) {
					mForm.setBrakish(resultSet2.getString(1));
				} else {
					mForm.setBrakish("-");
				}
				preparedStatement2.close();
				resultSet2.close();
			} else {
				mForm.setPreparedOn("-");
				mForm.setFlouride("-");
				mForm.setTestid("-");
				mForm.setBrakish("-");
				mForm.setNitrate("-");
				mForm.setIron("-");
			}
		} else {
			mForm.setPreparedOn("-");
			mForm.setFlouride("-");
			mForm.setTestid("-");
			mForm.setBrakish("-");
			mForm.setNitrate("-");
			mForm.setIron("-");
		}
		preparedStatement1.close();
		resultSet1.close();
		arrayList.add(mForm);
	}
	preparedStatement.close();
	resultSet.close();

	query = "select a.ASSET_CODE,nvl(b.ASSET_NAME,'-'),a.OHSR_CODE,nvl(a.OHSR_LOC,'-'),c.YIELD  from  RWS_AST_OHSR_SC_PARAM_TBL a,rws_asset_mast_tbl b,RWS_OHGLCI_HAB_LINK_TBL c where a.OHSR_CODE=c.SUBCOMP_CODE and c.HAB_CODE=? and TYPE_OF_ASSET_CODE ='02' and a.asset_code=b.asset_code and c.hab_code<>substr(ohsr_code,1,16)";
	preparedStatement = connection.prepareStatement(query);
	preparedStatement.setString(1, habCode);
	resultSet = preparedStatement.executeQuery();
	System.out.println(query);
	while (resultSet.next()) {
		mForm = new Rws_Habitation_Safe_Suplly_Form();
		mForm.setsNo(count++);
		mForm.setMpwsLinksAssetCode(resultSet.getString(1));
		mForm.setMpwsLinksAssetName(resultSet.getString(2));
		mForm.setMpwsLinksSourceCode(resultSet.getString(3));
		mForm.setMpwsLinksLocation(resultSet.getString(4));
		mForm.setMpwsLinksSourceName("OHSR");
		mForm.setMpwsLinksSafeLPCD(resultSet.getInt(5));
		mForm.setYield("-");
		mForm.setImageStatus(
				getImageStatus(resultSet.getString("ASSET_CODE"), resultSet.getString("OHSR_CODE")));
		mForm.setTableName("ohsr");
		mForm.setYield("-");
		String testResults = "select to_char(max(prepared_on),'dd/mm/yyyy') from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and source_code=? order by max(prepared_on) desc";
		preparedStatement1 = connection.prepareStatement(testResults);
		preparedStatement1.setString(1, resultSet.getString(3));
		resultSet1 = preparedStatement1.executeQuery();
		if (resultSet1.next()) {
			if (resultSet1.getString(1) != null && !resultSet1.getString(1).equals("")) {
				mForm.setPreparedOn(resultSet1.getString(1));
				String flouride = "SELECT TESTING_PARAMETER_VALUE,a.test_id FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='13' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2 = connection.prepareStatement(flouride);
				preparedStatement2.setString(1, resultSet.getString(3));
				preparedStatement2.setString(2, resultSet1.getString(1));
				resultSet2 = preparedStatement2.executeQuery();
				if (resultSet2.next()) {
					mForm.setFlouride(resultSet2.getString(1));
					mForm.setTestid(resultSet2.getString(2));
				} else {
					mForm.setFlouride("-");
					mForm.setTestid("-");
				}
				preparedStatement2.close();
				resultSet2.close();
				String iron = "SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='16' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2 = connection.prepareStatement(iron);
				preparedStatement2.setString(1, resultSet.getString(3));
				preparedStatement2.setString(2, resultSet1.getString(1));
				resultSet2 = preparedStatement2.executeQuery();
				if (resultSet2.next()) {
					mForm.setIron(resultSet2.getString(1));

				} else {
					mForm.setIron("-");
				}
				preparedStatement2.close();
				resultSet2.close();
				String nitrate = "SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='15' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2 = connection.prepareStatement(nitrate);
				preparedStatement2.setString(1, resultSet.getString(3));
				preparedStatement2.setString(2, resultSet1.getString(1));
				resultSet2 = preparedStatement2.executeQuery();
				if (resultSet2.next()) {
					mForm.setNitrate(resultSet2.getString(1));
				} else {
					mForm.setNitrate("-");
				}
				preparedStatement2.close();
				resultSet2.close();
				String barkish = "SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='05' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2 = connection.prepareStatement(barkish);
				preparedStatement2.setString(1, resultSet.getString(3));
				preparedStatement2.setString(2, resultSet1.getString(1));
				resultSet2 = preparedStatement2.executeQuery();
				if (resultSet2.next()) {
					mForm.setBrakish(resultSet2.getString(1));
				} else {

					mForm.setBrakish("-");

				}
				preparedStatement2.close();
				resultSet2.close();
			} else {
				mForm.setPreparedOn("-");
				mForm.setFlouride("-");
				mForm.setTestid("-");
				mForm.setBrakish("-");
				mForm.setNitrate("-");
				mForm.setIron("-");
			}
		} else {
			mForm.setPreparedOn("-");
			mForm.setFlouride("-");
			mForm.setTestid("-");
			mForm.setBrakish("-");
			mForm.setNitrate("-");
			mForm.setIron("-");
		}
		preparedStatement1.close();
		resultSet1.close();
		arrayList.add(mForm);
	}
	preparedStatement.close();
	resultSet.close();
	}
	catch(Exception e){
		System.out.println("Exception at getHabitaionMPWSLinksSafeSupply in Rws_Habitation_Safe_Suplly_DAO"+e);
	}
	finally {
		try{
		if(connection!=null){
			connection.close();
		}
		}
		catch(Exception e){
			System.out.println("Exception at finally block of getHabitaionMPWSLinksSafeSupply in Rws_Habitation_Safe_Suplly_DAO"+e);
		}
	}
	return arrayList;	
}


public ArrayList getHabitaionDPLinksSafeSupply(Rws_Habitation_Safe_Suplly_Form mForm,HttpSession session) {ArrayList arrayList=new  ArrayList();
	Connection connection=null;
	PreparedStatement preparedStatement=null;
	ResultSet resultSet=null;
	PreparedStatement preparedStatement1=null;
	ResultSet resultSet1=null;
	PreparedStatement preparedStatement2=null;
	ResultSet resultSet2=null;	
	String query="";
	int count=1;
	String habCode=mForm.getHabitation();
	try{
	connection=RwsOffices.getConn();
	query="select DP_HAB_SUPPLY,DP_HAB_UNSAFE_SUPPLY from  rws_hab_supply_status_tbl where HAB_CODE=?";
	preparedStatement=connection.prepareStatement(query);
	preparedStatement.setString(1, habCode);
	resultSet=preparedStatement.executeQuery();
	if(resultSet.next()){
		mForm.setDpHabLinkLPCD(resultSet.getInt(1));
		mForm.setDpHabLinkUnsafeLPCD(resultSet.getInt(2));
		session.setAttribute("status", "Yes");
	}
	preparedStatement.close();
	resultSet.close();
	
	query="select m.ASSET_CODE,nvl(m.ASSET_NAME,'--') as assetname,a.WATER_SUPP_FREQ from rws_asset_hab_tbl a,rws_asset_mast_tbl m where a.HAB_CODE=? and a.Hab_code<>m.hab_code and TYPE_OF_ASSET_CODE ='09' and a.asset_code=m.asset_code";
	preparedStatement=connection.prepareStatement(query);
	preparedStatement.setString(1, habCode);
	resultSet=preparedStatement.executeQuery();
	while(resultSet.next()){
		int souCount=0;
		String souCountqry="select count(*) from RWS_SOURCE_HABITATION_TBL a,RWS_SOURCE_TBL b where a.SOURCE_CODE=b.SOURCE_CODE and a.HAB_CODE=? and b.ASSET_CODE=?";
		preparedStatement2=connection.prepareStatement(souCountqry);
		preparedStatement2.setString(1, habCode);
		preparedStatement2.setString(2, resultSet.getString(1));
		ResultSet souCountRs=preparedStatement2.executeQuery();
		if(souCountRs.next()) {
			souCount=souCountRs.getInt(1);
		}
		preparedStatement2.close();
		souCountRs.close();
		if(souCount==0) {
			mForm=new Rws_Habitation_Safe_Suplly_Form();
			mForm.setsNo(count++);
			mForm.setDpLinksAssetCode(resultSet.getString("ASSET_CODE"));
			mForm.setDpLinksAssetName(resultSet.getString("assetname"));
			mForm.setWaterBeingSupplied(resultSet.getString("WATER_SUPP_FREQ"));	
			mForm.setDpLinksSourceCode("--");
			mForm.setDpLinksSourceName("--");
			mForm.setDpLinksLocation("--");
			mForm.setDpLinksSafeLPCD(0);
			mForm.setDpLinksUnSafeLPCD(0);
			mForm.setSourceType("--");
			mForm.setTableName("source");
			mForm.setSourceStatus("--");
			mForm.setYield("--");
			mForm.setImageStatus("No");
			mForm.setPreparedOn("--");
			mForm.setFlouride("--");
			mForm.setBrakish("--");
			mForm.setNitrate("--");
			mForm.setIron("--");
			arrayList.add(mForm);
		}else {		
			String sourceHabQry="select b.SOURCE_CODE,nvl(b.SOURCE_NAME,'--') as SOURCE_NAME,nvl(b.LOCATION,'--') as LOCATION,nvl(safe_supply,0) as safe_supply ,nvl(unsafe_supply,0) as unsafe_supply,nvl(to_char(b.UPDATE_DATE,'dd/mm/yyyy'),'--'),SOURCE_TYPE_CODE,nvl(STATUS,'') as status,nvl(b.YIELD,'--') as YIELD from RWS_SOURCE_HABITATION_TBL a,RWS_SOURCE_TBL b where a.SOURCE_CODE=b.SOURCE_CODE and a.HAB_CODE=? and b.ASSET_CODE=?";
			preparedStatement2=connection.prepareStatement(sourceHabQry);
			preparedStatement2.setString(1, habCode);
			preparedStatement2.setString(2, resultSet.getString(1));
			ResultSet souHabRs=preparedStatement2.executeQuery();
			while(souHabRs.next()) {			
				mForm=new Rws_Habitation_Safe_Suplly_Form();
				mForm.setsNo(count++);
				mForm.setDpLinksAssetCode(resultSet.getString("ASSET_CODE"));
				mForm.setDpLinksAssetName(resultSet.getString("assetname"));
				mForm.setWaterBeingSupplied(resultSet.getString("WATER_SUPP_FREQ"));	
				mForm.setDpLinksSourceCode(souHabRs.getString("SOURCE_CODE"));
				mForm.setDpLinksSourceName("Direct Pumping/"+souHabRs.getString("SOURCE_NAME"));
				mForm.setDpLinksLocation(souHabRs.getString("LOCATION"));
				mForm.setDpLinksSafeLPCD(souHabRs.getInt("safe_supply"));
				mForm.setDpLinksUnSafeLPCD(souHabRs.getInt("unsafe_supply"));
				mForm.setSourceType(souHabRs.getString("SOURCE_TYPE_CODE"));
				mForm.setTableName("source");
				mForm.setSourceStatus(souHabRs.getString("status"));
				mForm.setYield(souHabRs.getString("YIELD"));
				mForm.setImageStatus(getImageStatus(resultSet.getString("ASSET_CODE"), souHabRs.getString("SOURCE_CODE")));			
				
			String testResults="select to_char(max(prepared_on),'dd/mm/yyyy') from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and source_code=? order by max(prepared_on) desc";
			preparedStatement1=connection.prepareStatement(testResults);
			preparedStatement1.setString(1,souHabRs.getString("SOURCE_CODE"));
			resultSet1=preparedStatement1.executeQuery();
			if(resultSet1.next()){
				if(resultSet1.getString(1)!=null && !resultSet1.getString(1).equals("")){
				mForm.setPreparedOn(resultSet1.getString(1));
				String flouride="SELECT TESTING_PARAMETER_VALUE,a.test_id FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='13' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(flouride);
				preparedStatement2.setString(1,souHabRs.getString("SOURCE_CODE"));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setFlouride(resultSet2.getString(1));
					mForm.setTestid(resultSet2.getString(2));
				}
				else{				
					mForm.setFlouride("--");
					mForm.setTestid("--");
				}
				preparedStatement2.close();
				resultSet2.close();
				String iron="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='16' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(iron);
				preparedStatement2.setString(1,souHabRs.getString("SOURCE_CODE"));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setIron(resultSet2.getString(1));				
				}
				else{
					mForm.setIron("--");
				}
				preparedStatement2.close();
				resultSet2.close();
				String nitrate="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='15' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(nitrate);
				preparedStatement2.setString(1,souHabRs.getString("SOURCE_CODE"));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setNitrate(resultSet2.getString(1));				
				}
				else{
					
					mForm.setNitrate("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				String barkish="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='05' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(barkish);
				preparedStatement2.setString(1,souHabRs.getString("SOURCE_CODE"));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setBrakish(resultSet2.getString(1));				
				}
				else{
					
					mForm.setBrakish("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				}
				else{
					mForm.setPreparedOn("--");
					mForm.setFlouride("--");
					mForm.setTestid("--");
					mForm.setBrakish("--");
					mForm.setNitrate("--");
					mForm.setIron("--");
				}
			}
			else{
				mForm.setPreparedOn("--");
				mForm.setFlouride("--");
				mForm.setTestid("--");
				mForm.setBrakish("--");
				mForm.setNitrate("--");
				mForm.setIron("--");
			}
			preparedStatement1.close();
			resultSet1.close();
			arrayList.add(mForm);
			}
		}
	}
	preparedStatement.close();
	resultSet.close();
	}
	catch(Exception e){
		System.out.println("Exception at getHabitaionDPLinksSafeSupply in Rws_Habitation_Safe_Suplly_DAO"+e);
	}
	finally {
		try{
		if(connection!=null){
			connection.close();
		}
		}
		catch(Exception e){
			System.out.println("Exception at finally block of getHabitaionDPLinksSafeSupply in Rws_Habitation_Safe_Suplly_DAO"+e);
		}
	}
	return arrayList;
}


	
	
	
	public ArrayList getHabitaionCPWSSafeSupply(Rws_Habitation_Safe_Suplly_Form mForm,HttpSession session) {
		
		ArrayList arrayList=new  ArrayList();
		Connection connection=null;
		PreparedStatement preparedStatement=null;
		ResultSet resultSet=null;
		PreparedStatement preparedStatement1=null;
		ResultSet resultSet1=null;
		PreparedStatement preparedStatement2=null;
		ResultSet resultSet2=null;
		
		String query="";
		int count=1;
		String habCode=mForm.getHabitation();
		try{
		connection=RwsOffices.getConn();
		query="select CPWS_SUPPLY,CPWS_NO from  rws_hab_supply_status_tbl where HAB_CODE=?";
		preparedStatement=connection.prepareStatement(query);
		preparedStatement.setString(1, habCode);
		resultSet=preparedStatement.executeQuery();
		if(resultSet.next()){
			mForm.setCpwsHabLPCD(resultSet.getInt(1));
			mForm.setCpwsNo(resultSet.getInt(2));
			session.setAttribute("status", "Yes");
		}
		preparedStatement.close();
		resultSet.close();
		query="select a.ASSET_CODE,nvl(b.ASSET_NAME,'--'),a.SOURCE_CODE,nvl(a.SOURCE_NAME,'--'),nvl(a.LOCATION,'--'),a.SAFE_LPD,FLOURIDE,BRAKISH,IRON,NITRATE,nvl(to_char(a.UPDATE_DATE,'dd/mm/yyyy'),'--'),nvl(STATUS,'') as status,nvl(YIELD,'--') as YIELD  from  rws_source_tbl a,rws_asset_mast_tbl b where a.HAB_CODE=? and TYPE_OF_ASSET_CODE ='03' and a.asset_code=b.asset_code";
		preparedStatement=connection.prepareStatement(query);
		preparedStatement.setString(1, habCode);
		resultSet=preparedStatement.executeQuery();
		while(resultSet.next()){
			mForm=new Rws_Habitation_Safe_Suplly_Form();
			mForm.setsNo(count++);
			mForm.setCpwsAssetCode(resultSet.getString(1));
			mForm.setCpwsAssetName(resultSet.getString(2));
			mForm.setCpwsSourceCode(resultSet.getString(3));
			mForm.setCpwsSourceName("CPWS/"+resultSet.getString(4));
			mForm.setCpwsLocation(resultSet.getString(5));
			mForm.setCpwsSafeLPCD(resultSet.getInt(6));
			mForm.setTableName("source");
			mForm.setSourceStatus(resultSet.getString("status"));
			mForm.setYield(resultSet.getString("YIELD"));
			mForm.setImageStatus(getImageStatus(resultSet.getString("ASSET_CODE"), resultSet.getString("SOURCE_CODE")));
			
			String waterBeging="select WATER_SUPP_FREQ from rws_asset_hab_tbl where asset_code=? and hab_code=?";
			preparedStatement1=connection.prepareStatement(waterBeging);
			preparedStatement1.setString(1,resultSet.getString(1));
			preparedStatement1.setString(2,habCode);
			resultSet1=preparedStatement1.executeQuery();
			if(resultSet1.next()){
				mForm.setWaterBeingSupplied(resultSet1.getString("WATER_SUPP_FREQ"));
			}
			preparedStatement1.close();
			resultSet1.close();
			
			String testResults="";
				testResults="select to_char(max(prepared_on),'dd/mm/yyyy') from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and source_code=? order by max(prepared_on) desc";
			preparedStatement1=connection.prepareStatement(testResults);
			preparedStatement1.setString(1,resultSet.getString(3));
			resultSet1=preparedStatement1.executeQuery();
			if(resultSet1.next()){
				if(resultSet1.getString(1)!=null && !resultSet1.getString(1).equals("")){
				mForm.setPreparedOn(resultSet1.getString(1));
				String flouride="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='13' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(flouride);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setFlouride(resultSet2.getString(1));
				}
				else{
					
					mForm.setFlouride("--");
					mForm.setTestid("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
					
				String iron="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='16' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(iron);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setIron(resultSet2.getString(1));
					
				}
				else{
					mForm.setIron("--");
				}
				preparedStatement2.close();
				resultSet2.close();
				
					
				String nitrate="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='15' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(nitrate);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setNitrate(resultSet2.getString(1));
					
				}
				else{
					
					mForm.setNitrate("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				
					
				String barkish="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='05' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(barkish);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setBrakish(resultSet2.getString(1));
					
				}
				else{
					
					mForm.setBrakish("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				
				}
				else{
					mForm.setPreparedOn("--");
					mForm.setFlouride("--");
					mForm.setBrakish("--");
					mForm.setNitrate("--");
					mForm.setIron("--");
				}
				
			}
			else{
				mForm.setPreparedOn("--");
				mForm.setFlouride("--");
				mForm.setBrakish("--");
				mForm.setNitrate("--");
				mForm.setIron("--");
			}
			preparedStatement1.close();
			resultSet1.close();
			arrayList.add(mForm);
		}
		preparedStatement.close();
		resultSet.close();
		
		query="select a.ASSET_CODE,nvl(b.ASSET_NAME,'--'),a.GLSR_CODE,nvl(a.GLSR_LOC,'--'),a.GLSR_CAP_LTS  from  RWS_AST_GLSR_SC_PARAM_TBL a,rws_asset_mast_tbl b where substr(a.GLSR_CODE,1,16)=? and TYPE_OF_ASSET_CODE ='03' and a.asset_code=b.asset_code";
		preparedStatement=connection.prepareStatement(query);
		preparedStatement.setString(1, habCode);
		resultSet=preparedStatement.executeQuery();
		while(resultSet.next()){
			mForm=new Rws_Habitation_Safe_Suplly_Form();
			mForm.setsNo(count++);
			mForm.setCpwsAssetCode(resultSet.getString(1));
			mForm.setCpwsAssetName(resultSet.getString(2));
			mForm.setCpwsSourceCode(resultSet.getString(3));
			mForm.setCpwsLocation(resultSet.getString(4));
			mForm.setCpwsSourceName("GLSR");
			mForm.setCpwsSafeLPCD(resultSet.getInt(5));
			mForm.setTableName("glsr");
			mForm.setYield("--");
			mForm.setImageStatus(getImageStatus(resultSet.getString("ASSET_CODE"), resultSet.getString("GLSR_CODE")));
			
			String testResults="select to_char(max(prepared_on),'dd/mm/yyyy') from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and source_code=? order by max(prepared_on) desc";
			preparedStatement1=connection.prepareStatement(testResults);
			preparedStatement1.setString(1,resultSet.getString(3));
			resultSet1=preparedStatement1.executeQuery();
			if(resultSet1.next()){
				if(resultSet1.getString(1)!=null && !resultSet1.getString(1).equals("")){
				mForm.setPreparedOn(resultSet1.getString(1));
				String flouride="SELECT TESTING_PARAMETER_VALUE,a.test_id FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='13' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(flouride);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setFlouride(resultSet2.getString(1));
					mForm.setTestid(resultSet2.getString(2));
				}
				else{
					
					mForm.setFlouride("--");
					mForm.setTestid("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				String iron="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='16' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(iron);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setIron(resultSet2.getString(1));
					
				}
				else{
					mForm.setIron("--");
				}
				preparedStatement2.close();
				resultSet2.close();
				String nitrate="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='15' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(nitrate);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setNitrate(resultSet2.getString(1));
					
				}
				else{
					
					mForm.setNitrate("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				String barkish="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='05' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(barkish);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setBrakish(resultSet2.getString(1));
					
				}
				else{
					
					mForm.setBrakish("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				}else{
					mForm.setPreparedOn("--");
					mForm.setFlouride("--");
					mForm.setTestid("--");
					mForm.setBrakish("--");
					mForm.setNitrate("--");
					mForm.setIron("--");
				}
			}
			else{
				mForm.setPreparedOn("--");
				mForm.setFlouride("--");
				mForm.setTestid("--");
				mForm.setBrakish("--");
				mForm.setNitrate("--");
				mForm.setIron("--");
			}
			preparedStatement1.close();
			resultSet1.close();
			arrayList.add(mForm);
		}
		preparedStatement.close();
		resultSet.close();
		
		query="select a.ASSET_CODE,nvl(b.ASSET_NAME,'--'),a.OHSR_CODE,nvl(a.OHSR_LOC,'--'),a.OHSR_CAP_LTS  from  RWS_AST_OHSR_SC_PARAM_TBL a,rws_asset_mast_tbl b where substr(a.OHSR_CODE,1,16)=? and TYPE_OF_ASSET_CODE ='03' and a.asset_code=b.asset_code";
		preparedStatement=connection.prepareStatement(query);
		preparedStatement.setString(1, habCode);
		resultSet=preparedStatement.executeQuery();
		while(resultSet.next()){
			mForm=new Rws_Habitation_Safe_Suplly_Form();
			mForm.setsNo(count++);
			mForm.setCpwsAssetCode(resultSet.getString(1));
			mForm.setCpwsAssetName(resultSet.getString(2));
			mForm.setCpwsSourceCode(resultSet.getString(3));
			mForm.setCpwsSourceName("OHSR");
			mForm.setCpwsLocation(resultSet.getString(4));
			mForm.setCpwsSafeLPCD(resultSet.getInt(5));
			mForm.setTableName("ohsr");
			mForm.setYield("--");
			mForm.setImageStatus(getImageStatus(resultSet.getString("ASSET_CODE"), resultSet.getString("OHSR_CODE")));
			
			String testResults="select to_char(max(prepared_on),'dd/mm/yyyy') from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and source_code=? order by max(prepared_on) desc";
			preparedStatement1=connection.prepareStatement(testResults);
			preparedStatement1.setString(1,resultSet.getString(3));
			resultSet1=preparedStatement1.executeQuery();
			if(resultSet1.next()){
				if(resultSet1.getString(1)!=null && !resultSet1.getString(1).equals("")){
				mForm.setPreparedOn(resultSet1.getString(1));
				String flouride="SELECT TESTING_PARAMETER_VALUE,a.test_id FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='13' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(flouride);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setFlouride(resultSet2.getString(1));
					mForm.setTestid(resultSet2.getString(2));
				}
				else{
					
					mForm.setFlouride("--");
					mForm.setTestid("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				String iron="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='16' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(iron);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setIron(resultSet2.getString(1));
					
				}
				else{
					mForm.setIron("--");
				}
				preparedStatement2.close();
				resultSet2.close();
				String nitrate="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='15' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(nitrate);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setNitrate(resultSet2.getString(1));
					
				}
				else{
					
					mForm.setNitrate("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				String barkish="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='05' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(barkish);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setBrakish(resultSet2.getString(1));
					
				}
				else{
					
					mForm.setBrakish("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				}else{
					mForm.setPreparedOn("--");
					mForm.setFlouride("--");
					mForm.setTestid("--");
					mForm.setBrakish("--");
					mForm.setNitrate("--");
					mForm.setIron("--");
				}
			}
			else{
				mForm.setPreparedOn("--");
				mForm.setFlouride("--");
				mForm.setTestid("--");
				mForm.setBrakish("--");
				mForm.setNitrate("--");
				mForm.setIron("--");
			}
			preparedStatement1.close();
			resultSet1.close();
			arrayList.add(mForm);
		}
		preparedStatement.close();
		resultSet.close();
		}
		catch(Exception e){
			System.out.println("Exception at getHabitaionCPWSSafeSupply in Rws_Habitation_Safe_Suplly_DAO"+e);
		}
		finally {
			try{
			if(connection!=null){
				connection.close();
			}
			}
			catch(Exception e){
				System.out.println("Exception at finally block of getHabitaionCPWSSafeSupply in Rws_Habitation_Safe_Suplly_DAO"+e);
			}
		}
		return arrayList;
		
	}
	public ArrayList getHabitaionMPWSSafeSupply(Rws_Habitation_Safe_Suplly_Form mForm,HttpSession session) {
		
		ArrayList arrayList=new  ArrayList();
		Connection connection=null;
		PreparedStatement preparedStatement=null;
		ResultSet resultSet=null;
		PreparedStatement preparedStatement1=null;
		ResultSet resultSet1=null;
		PreparedStatement preparedStatement2=null;
		ResultSet resultSet2=null;
		
		String query="";
		int count=1;
		String habCode=mForm.getHabitation();
		try{
		connection=RwsOffices.getConn();
		query="select MPWS_SUPPLY,MPWS_NO,MPWS_UNSAFE_SUPPLY,MPWS_UNSAFE_NO from  rws_hab_supply_status_tbl where HAB_CODE=?";
		preparedStatement=connection.prepareStatement(query);
		preparedStatement.setString(1, habCode);
		resultSet=preparedStatement.executeQuery();
		if(resultSet.next()){
			mForm.setMpwsHabLPCD(resultSet.getInt(1));
			mForm.setMpwsNo(resultSet.getInt(2));
			mForm.setMpwsHabUnsafeLPCD(resultSet.getInt(3));
			mForm.setMpwsUnSafeNo(resultSet.getInt(4));
			session.setAttribute("status", "Yes");
		}
		preparedStatement.close();
		resultSet.close();
		query="select a.ASSET_CODE,nvl(b.ASSET_NAME,'--'),a.SOURCE_CODE,nvl(a.SOURCE_NAME,'--'),nvl(a.LOCATION,'--'),a.SAFE_LPD,a.UNSAFE_LPD,FLOURIDE,BRAKISH,IRON,NITRATE,nvl(to_char(a.UPDATE_DATE,'dd/mm/yyyy'),'--'),SOURCE_TYPE_CODE,nvl(STATUS,'') as status,nvl(YIELD,'--') as YIELD  from  rws_source_tbl a,rws_asset_mast_tbl b where a.HAB_CODE=? and TYPE_OF_ASSET_CODE ='02' and a.asset_code=b.asset_code";
		
		preparedStatement=connection.prepareStatement(query);
		preparedStatement.setString(1, habCode);
		resultSet=preparedStatement.executeQuery();
		while(resultSet.next()){
			mForm=new Rws_Habitation_Safe_Suplly_Form();
			mForm.setsNo(count++);
			mForm.setMpwsAssetCode(resultSet.getString(1));
			mForm.setMpwsAssetName(resultSet.getString(2));
			mForm.setMpwsSourceCode(resultSet.getString(3));
			mForm.setMpwsSourceName("MPWS/"+resultSet.getString(4));
			mForm.setMpwsLocation(resultSet.getString(5));
			mForm.setMpwsSafeLPCD(resultSet.getInt(6));
			mForm.setMpwsUnSafeLPCD(resultSet.getInt(7));
			mForm.setSourceType(resultSet.getString(13));
			mForm.setTableName("source");
			mForm.setSourceStatus(resultSet.getString("status"));
			mForm.setYield(resultSet.getString("YIELD"));
			mForm.setImageStatus(getImageStatus(resultSet.getString("ASSET_CODE"), resultSet.getString("SOURCE_CODE")));
			
			String waterBeging="select WATER_SUPP_FREQ from rws_asset_hab_tbl where asset_code=? and hab_code=?";
			preparedStatement1=connection.prepareStatement(waterBeging);
			preparedStatement1.setString(1,resultSet.getString(1));
			preparedStatement1.setString(2,habCode);
			resultSet1=preparedStatement1.executeQuery();
			if(resultSet1.next()){
				mForm.setWaterBeingSupplied(resultSet1.getString("WATER_SUPP_FREQ"));
			}
			preparedStatement1.close();
			resultSet1.close();
			
			String testResults="";
							testResults="select to_char(max(prepared_on),'dd/mm/yyyy') from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and source_code=? order by max(prepared_on) desc";
			preparedStatement1=connection.prepareStatement(testResults);
			preparedStatement1.setString(1,resultSet.getString(3));
			resultSet1=preparedStatement1.executeQuery();
			if(resultSet1.next()){
				if(resultSet1.getString(1)!=null && !resultSet1.getString(1).equals("")){
				mForm.setPreparedOn(resultSet1.getString(1));
				String flouride="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='13' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(flouride);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setFlouride(resultSet2.getString(1));
				}
				else{
					
					mForm.setFlouride("--");
					mForm.setTestid("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				
					
				String iron="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='16' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(iron);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setIron(resultSet2.getString(1));
					
				}
				else{
					mForm.setIron("--");
				}
				preparedStatement2.close();
				resultSet2.close();
				
						
				String nitrate="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='15' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(nitrate);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setNitrate(resultSet2.getString(1));
					
				}
				else{
					
					mForm.setNitrate("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				
					
				String barkish="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='05' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(barkish);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setBrakish(resultSet2.getString(1));
					
				}
				else{
					
					mForm.setBrakish("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				
				}
				else{
					mForm.setPreparedOn("--");
					mForm.setFlouride("--");
					mForm.setBrakish("--");
					mForm.setNitrate("--");
					mForm.setIron("--");
				}
				
			}
			else{
				mForm.setPreparedOn("--");
				mForm.setFlouride("--");
				mForm.setBrakish("--");
				mForm.setNitrate("--");
				mForm.setIron("--");
			}
			preparedStatement1.close();
			resultSet1.close();
			arrayList.add(mForm);
		}
		preparedStatement.close();
		resultSet.close();
		query="select a.ASSET_CODE,nvl(b.ASSET_NAME,'--'),a.GLSR_CODE,nvl(a.GLSR_LOC,'--'),a.GLSR_CAP_LTS  from  RWS_AST_GLSR_SC_PARAM_TBL a,rws_asset_mast_tbl b where substr(a.GLSR_CODE,1,16)=? and TYPE_OF_ASSET_CODE ='02' and a.asset_code=b.asset_code";
		preparedStatement=connection.prepareStatement(query);
		preparedStatement.setString(1, habCode);
		resultSet=preparedStatement.executeQuery();
		while(resultSet.next()){
			mForm=new Rws_Habitation_Safe_Suplly_Form();
			mForm.setsNo(count++);
			mForm.setMpwsAssetCode(resultSet.getString(1));
			mForm.setMpwsAssetName(resultSet.getString(2));
			mForm.setMpwsSourceCode(resultSet.getString(3));
			mForm.setMpwsLocation(resultSet.getString(4));
			mForm.setMpwsSourceName("GLSR");
			mForm.setMpwsSafeLPCD(resultSet.getInt(5));
			mForm.setTableName("glsr");
			mForm.setYield("--");
			mForm.setImageStatus(getImageStatus(resultSet.getString("ASSET_CODE"), resultSet.getString("GLSR_CODE")));
			
			String testResults="select to_char(max(prepared_on),'dd/mm/yyyy') from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and source_code=? order by max(prepared_on) desc";
			preparedStatement1=connection.prepareStatement(testResults);
			preparedStatement1.setString(1,resultSet.getString(3));
			resultSet1=preparedStatement1.executeQuery();
			if(resultSet1.next()){
				if(resultSet1.getString(1)!=null && !resultSet1.getString(1).equals("")){
				mForm.setPreparedOn(resultSet1.getString(1));
				String flouride="SELECT TESTING_PARAMETER_VALUE,a.test_id FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='13' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(flouride);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setFlouride(resultSet2.getString(1));
					mForm.setTestid(resultSet2.getString(2));
				}
				else{
					
					mForm.setFlouride("--");
					mForm.setTestid("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				String iron="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='16' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(iron);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setIron(resultSet2.getString(1));
					
				}
				else{
					mForm.setIron("--");
				}
				preparedStatement2.close();
				resultSet2.close();
				String nitrate="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='15' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(nitrate);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setNitrate(resultSet2.getString(1));
					
				}
				else{
					
					mForm.setNitrate("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				String barkish="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='05' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(barkish);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setBrakish(resultSet2.getString(1));
					
				}
				else{
					
					mForm.setBrakish("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				}else{
					mForm.setPreparedOn("--");
					mForm.setFlouride("--");
					mForm.setTestid("--");
					mForm.setBrakish("--");
					mForm.setNitrate("--");
					mForm.setIron("--");
				}
			}
			else{
				mForm.setPreparedOn("--");
				mForm.setFlouride("--");
				mForm.setTestid("--");
				mForm.setBrakish("--");
				mForm.setNitrate("--");
				mForm.setIron("--");
			}
			preparedStatement1.close();
			resultSet1.close();
			arrayList.add(mForm);
		}
		preparedStatement.close();
		resultSet.close();
		
		query="select a.ASSET_CODE,nvl(b.ASSET_NAME,'--'),a.OHSR_CODE,nvl(a.OHSR_LOC,'--'),a.OHSR_CAP_LTS  from  RWS_AST_OHSR_SC_PARAM_TBL a,rws_asset_mast_tbl b where substr(a.OHSR_CODE,1,16)=? and TYPE_OF_ASSET_CODE ='02' and a.asset_code=b.asset_code";
		preparedStatement=connection.prepareStatement(query);
		preparedStatement.setString(1, habCode);
		resultSet=preparedStatement.executeQuery();
		while(resultSet.next()){
			mForm=new Rws_Habitation_Safe_Suplly_Form();
			mForm.setsNo(count++);
			mForm.setMpwsAssetCode(resultSet.getString(1));
			mForm.setMpwsAssetName(resultSet.getString(2));
			mForm.setMpwsSourceCode(resultSet.getString(3));
			mForm.setMpwsSourceName("OHSR");
			mForm.setMpwsLocation(resultSet.getString(4));
			mForm.setMpwsSafeLPCD(resultSet.getInt(5));
			mForm.setTableName("ohsr");
			mForm.setYield("--");
			mForm.setImageStatus(getImageStatus(resultSet.getString("ASSET_CODE"), resultSet.getString("OHSR_CODE")));
			
			String testResults="select to_char(max(prepared_on),'dd/mm/yyyy') from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and source_code=? order by max(prepared_on) desc";
			preparedStatement1=connection.prepareStatement(testResults);
			preparedStatement1.setString(1,resultSet.getString(3));
			resultSet1=preparedStatement1.executeQuery();
			if(resultSet1.next()){
				if(resultSet1.getString(1)!=null && !resultSet1.getString(1).equals("")){
				mForm.setPreparedOn(resultSet1.getString(1));
				String flouride="SELECT TESTING_PARAMETER_VALUE,a.test_id FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='13' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(flouride);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setFlouride(resultSet2.getString(1));
					mForm.setTestid(resultSet2.getString(2));
				}
				else{
					
					mForm.setFlouride("--");
					mForm.setTestid("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				String iron="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='16' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(iron);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setIron(resultSet2.getString(1));
					
				}
				else{
					mForm.setIron("--");
				}
				preparedStatement2.close();
				resultSet2.close();
				String nitrate="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='15' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(nitrate);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setNitrate(resultSet2.getString(1));
					
				}
				else{
					
					mForm.setNitrate("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				String barkish="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='05' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(barkish);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setBrakish(resultSet2.getString(1));
					
				}
				else{
					
					mForm.setBrakish("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				}else{
					mForm.setPreparedOn("--");
					mForm.setFlouride("--");
					mForm.setTestid("--");
					mForm.setBrakish("--");
					mForm.setNitrate("--");
					mForm.setIron("--");
				}
			}
			else{
				mForm.setPreparedOn("--");
				mForm.setFlouride("--");
				mForm.setTestid("--");
				mForm.setBrakish("--");
				mForm.setNitrate("--");
				mForm.setIron("--");
			}
			preparedStatement1.close();
			resultSet1.close();
			arrayList.add(mForm);
		}
		preparedStatement.close();
		resultSet.close();
		}
		catch(Exception e){
			System.out.println("Exception at getHabitaionMPWSSafeSupply in Rws_Habitation_Safe_Suplly_DAO"+e);
		}
		finally {
			try{
			if(connection!=null){
				connection.close();
			}
			}
			catch(Exception e){
				System.out.println("Exception at finally block of getHabitaionMPWSSafeSupply in Rws_Habitation_Safe_Suplly_DAO"+e);
			}
		}
		return arrayList;
		
	}
public ArrayList getHabitaionHPSafeSupply(Rws_Habitation_Safe_Suplly_Form mForm,HttpSession session) {
		
		ArrayList arrayList=new  ArrayList();
		Connection connection=null;
		PreparedStatement preparedStatement=null;
		ResultSet resultSet=null;
		PreparedStatement preparedStatement1=null;
		ResultSet resultSet1=null;
		PreparedStatement preparedStatement2=null;
		ResultSet resultSet2=null;
		
		String query="";
		int count=1;
		String habCode=mForm.getHabitation();
		try{
		connection=RwsOffices.getConn();
		query="select HPS_OTH_SUPPLY,HPS_NO,HPS_OTH_SUPPLY_UNSAFE,HPS_NO_UNSAFE from  rws_hab_supply_status_tbl where HAB_CODE=?";
		preparedStatement=connection.prepareStatement(query);
		preparedStatement.setString(1, habCode);
		resultSet=preparedStatement.executeQuery();
		if(resultSet.next()){
			mForm.setHpHabLPCD(resultSet.getInt(1));
			mForm.setHpNo(resultSet.getInt(2));
			mForm.setHpHabUnsafeLPCD(resultSet.getInt(3));
			mForm.setHpUnSafeNo(resultSet.getInt(4));
			session.setAttribute("status", "Yes");
		}
		preparedStatement.close();
		resultSet.close();
		query="select a.ASSET_CODE,nvl(b.ASSET_NAME,'--'),a.HP_CODE,nvl(a.LOCATION,'--'),a.SAFE_LPD,a.UNSAFE_LPD,FLOURIDE,BRAKISH,IRON,NITRATE,nvl(to_char(a.UPDATE_DATE,'dd/mm/yyyy'),'--'),nvl(STATUS,'') as status,PLATFORM_EXISTING,SOAK_PIT,nvl(P_YEILD,0) as YIELD  from  RWS_HP_SUBCOMP_PARAM_TBL a,rws_asset_mast_tbl b where substr(a.HP_CODE,1,16)=? and TYPE_OF_ASSET_CODE ='04' and a.asset_code=b.asset_code";
		preparedStatement=connection.prepareStatement(query);
		preparedStatement.setString(1, habCode);
		resultSet=preparedStatement.executeQuery();
		while(resultSet.next()){
			mForm=new Rws_Habitation_Safe_Suplly_Form();
			mForm.setsNo(count++);
			mForm.setHpAssetCode(resultSet.getString(1));
			mForm.setHpAssetName(resultSet.getString(2));
			mForm.setHpSourceCode(resultSet.getString(3));
			mForm.setHpLocation(resultSet.getString(4));
			mForm.setHpSafeLPCD(resultSet.getInt(5));
			mForm.setHpUnSafeLPCD(resultSet.getInt(6));
			mForm.setTableName("hp");
			mForm.setSourceStatus(resultSet.getString("status"));
			mForm.setPlatformExisting(resultSet.getString("PLATFORM_EXISTING"));
			mForm.setSoakPit(resultSet.getString("SOAK_PIT"));
			mForm.setYield(resultSet.getString("YIELD"));
			mForm.setImageStatus(getImageStatus(resultSet.getString("ASSET_CODE"), resultSet.getString("HP_CODE")));
			
			String waterBeging="select WATER_SUPP_FREQ from rws_asset_hab_tbl where asset_code=? and hab_code=?";
			preparedStatement1=connection.prepareStatement(waterBeging);
			preparedStatement1.setString(1,resultSet.getString(1));
			preparedStatement1.setString(2,habCode);
			resultSet1=preparedStatement1.executeQuery();
			if(resultSet1.next()){
				mForm.setWaterBeingSupplied(resultSet1.getString("WATER_SUPP_FREQ"));
			}
			preparedStatement1.close();
			resultSet1.close();
			
			String testResults="";
				testResults="select to_char(max(prepared_on),'dd/mm/yyyy') from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and source_code=? order by max(prepared_on) desc";
			preparedStatement1=connection.prepareStatement(testResults);
			preparedStatement1.setString(1,resultSet.getString(3));
			resultSet1=preparedStatement1.executeQuery();
			if(resultSet1.next()){
				if(resultSet1.getString(1)!=null && !resultSet1.getString(1).equals("")){
				mForm.setPreparedOn(resultSet1.getString(1));
				String flouride="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='13' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(flouride);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setFlouride(resultSet2.getString(1));
				}
				else{
					
					mForm.setFlouride("--");
					mForm.setTestid("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				
				String iron="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='16' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(iron);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setIron(resultSet2.getString(1));
					
				}
				else{
					mForm.setIron("--");
				}
				preparedStatement2.close();
				resultSet2.close();
				
					
				String nitrate="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='15' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(nitrate);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setNitrate(resultSet2.getString(1));
					
				}
				else{
					
					mForm.setNitrate("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				
					
				String barkish="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='05' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
				preparedStatement2=connection.prepareStatement(barkish);
				preparedStatement2.setString(1,resultSet.getString(3));
				preparedStatement2.setString(2,resultSet1.getString(1));
				resultSet2=preparedStatement2.executeQuery();
				if(resultSet2.next()){
					mForm.setBrakish(resultSet2.getString(1));
					
				}
				else{
					
					mForm.setBrakish("--");
					
				}
				preparedStatement2.close();
				resultSet2.close();
				
				}
				else{
					mForm.setPreparedOn("--");
					mForm.setFlouride("--");
					mForm.setBrakish("--");
					mForm.setIron("--");
					mForm.setNitrate("--");
					
				}
				
			}
			else{
				mForm.setPreparedOn("--");
				mForm.setFlouride("--");
				mForm.setBrakish("--");
				mForm.setIron("--");
				mForm.setNitrate("--");
				
			}
			preparedStatement1.close();
			resultSet1.close();
			arrayList.add(mForm);
		}
		preparedStatement.close();
		resultSet.close();
		
		}
		catch(Exception e){
			System.out.println("Exception at getHabitaionHPSafeSupply in Rws_Habitation_Safe_Suplly_DAO"+e);
		}
		finally {
			try{
			if(connection!=null){
				connection.close();
			}
			}
			catch(Exception e){
				System.out.println("Exception at finally block of getHabitaionHPSafeSupply in Rws_Habitation_Safe_Suplly_DAO"+e);
			}
		}
		return arrayList;
		
	}
public ArrayList getHabitaionSHPSafeSupply(Rws_Habitation_Safe_Suplly_Form mForm,HttpSession session) {
	
	ArrayList arrayList=new  ArrayList();
	Connection connection=null;
	PreparedStatement preparedStatement=null;
	ResultSet resultSet=null;
	PreparedStatement preparedStatement1=null;
	ResultSet resultSet1=null;
	PreparedStatement preparedStatement2=null;
	ResultSet resultSet2=null;
	
	String query="";
	int count=1;
	String habCode=mForm.getHabitation();
	try{
	connection=RwsOffices.getConn();
	query="select SHP_DK_SUPPLY_SAFE,SHP_NO_SAFE,SHP_DK_SUPPLY,SHP_NO from  rws_hab_supply_status_tbl where HAB_CODE=?";
	preparedStatement=connection.prepareStatement(query);
	preparedStatement.setString(1, habCode);
	resultSet=preparedStatement.executeQuery();
	if(resultSet.next()){
		mForm.setShpHabLPCD(resultSet.getInt(1));
		mForm.setShpNo(resultSet.getInt(2));
		mForm.setShpHabUnsafeLPCD(resultSet.getInt(3));
		mForm.setShpUnSafeNo(resultSet.getInt(4));
		session.setAttribute("status", "Yes");
	}
	preparedStatement.close();
	resultSet.close();
	query="select a.ASSET_CODE,nvl(b.ASSET_NAME,'--'),a.SHALLOWHP_CODE,nvl(a.LOCATION,'--'),a.SAFE_LPD,a.UNSAFE_LPD,FLORIDE,BRAKISH,IRON,NITRATE_PER,nvl(to_char(a.UPDATE_DATE,'dd/mm/yyyy'),'--'),nvl(STATUS,'') as status,PLATFORM_EXISTING,SOAK_PIT,nvl(YIELD,0) YIELD from  RWS_SHALLOWHANDPUMPS_TBL a,rws_asset_mast_tbl b where a.HAB_CODE=? and TYPE_OF_ASSET_CODE ='05' and a.asset_code=b.asset_code";
	preparedStatement=connection.prepareStatement(query);
	preparedStatement.setString(1, habCode);
	resultSet=preparedStatement.executeQuery();
	while(resultSet.next()){
		mForm=new Rws_Habitation_Safe_Suplly_Form();
		mForm.setsNo(count++);
		mForm.setShpAssetCode(resultSet.getString(1));
		mForm.setShpAssetName(resultSet.getString(2));
		mForm.setShpSourceCode(resultSet.getString(3));
		mForm.setShpLocation(resultSet.getString(4));
		mForm.setShpSafeLPCD(resultSet.getInt(5));
		mForm.setShpUnSafeLPCD(resultSet.getInt(6));
		mForm.setTableName("shp");
		mForm.setSourceStatus(resultSet.getString("status"));
		mForm.setPlatformExisting(resultSet.getString("PLATFORM_EXISTING"));
		mForm.setSoakPit(resultSet.getString("SOAK_PIT"));
		mForm.setYield(resultSet.getString("YIELD"));
		mForm.setImageStatus(getImageStatus(resultSet.getString("ASSET_CODE"), resultSet.getString("SHALLOWHP_CODE")));
		
		String waterBeging="select WATER_SUPP_FREQ from rws_asset_hab_tbl where asset_code=? and hab_code=?";
		preparedStatement1=connection.prepareStatement(waterBeging);
		preparedStatement1.setString(1,resultSet.getString(1));
		preparedStatement1.setString(2,habCode);
		resultSet1=preparedStatement1.executeQuery();
		if(resultSet1.next()){
			mForm.setWaterBeingSupplied(resultSet1.getString("WATER_SUPP_FREQ"));
		}
		preparedStatement1.close();
		resultSet1.close();
		
		String testResults="";
			testResults="select to_char(max(prepared_on),'dd/mm/yyyy') from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and source_code=? order by max(prepared_on) desc";
		preparedStatement1=connection.prepareStatement(testResults);
		preparedStatement1.setString(1,resultSet.getString(3));
		resultSet1=preparedStatement1.executeQuery();
		if(resultSet1.next()){
			if(resultSet1.getString(1)!=null && !resultSet1.getString(1).equals("")){
			mForm.setPreparedOn(resultSet1.getString(1));
			String flouride="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='13' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
			preparedStatement2=connection.prepareStatement(flouride);
			preparedStatement2.setString(1,resultSet.getString(3));
			preparedStatement2.setString(2,resultSet1.getString(1));
			resultSet2=preparedStatement2.executeQuery();
			if(resultSet2.next()){
				mForm.setFlouride(resultSet2.getString(1));
			}
			else{
				
				mForm.setFlouride("--");
				mForm.setTestid("--");
				
			}
			preparedStatement2.close();
			resultSet2.close();
			
			String iron="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='16' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
			preparedStatement2=connection.prepareStatement(iron);
			preparedStatement2.setString(1,resultSet.getString(3));
			preparedStatement2.setString(2,resultSet1.getString(1));
			resultSet2=preparedStatement2.executeQuery();
			if(resultSet2.next()){
				mForm.setIron(resultSet2.getString(1));
				
			}
			else{
				mForm.setIron("--");
			}
			preparedStatement2.close();
			resultSet2.close();
			
			String nitrate="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='15' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
			preparedStatement2=connection.prepareStatement(nitrate);
			preparedStatement2.setString(1,resultSet.getString(3));
			preparedStatement2.setString(2,resultSet1.getString(1));
			resultSet2=preparedStatement2.executeQuery();
			if(resultSet2.next()){
				mForm.setNitrate(resultSet2.getString(1));
				
			}
			else{
				
				mForm.setNitrate("--");
				
			}
			preparedStatement2.close();
			resultSet2.close();
			String barkish="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='05' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
			preparedStatement2=connection.prepareStatement(barkish);
			preparedStatement2.setString(1,resultSet.getString(3));
			preparedStatement2.setString(2,resultSet1.getString(1));
			resultSet2=preparedStatement2.executeQuery();
			if(resultSet2.next()){
				mForm.setBrakish(resultSet2.getString(1));
				
			}
			else{
				
				mForm.setBrakish("--");
				
			}
			preparedStatement2.close();
			resultSet2.close();
			
			}
			else{
				mForm.setPreparedOn("--");
				mForm.setFlouride("--");
				mForm.setBrakish("--");
				mForm.setIron("--");
				mForm.setNitrate("--");
				
			}
			
		}
		else{
			mForm.setPreparedOn("--");
			mForm.setFlouride("--");
			mForm.setBrakish("--");
			mForm.setIron("--");
			mForm.setNitrate("--");
			
		}
		preparedStatement1.close();
		resultSet1.close();
		arrayList.add(mForm);
	}
	preparedStatement.close();
	resultSet.close();
	
	}
	catch(Exception e){
		System.out.println("Exception at getHabitaionSHPSafeSupply in Rws_Habitation_Safe_Suplly_DAO"+e);
	}
	finally {
		try{
		if(connection!=null){
			connection.close();
		}
		}
		catch(Exception e){
			System.out.println("Exception at finally block of getHabitaionSHPSafeSupply in Rws_Habitation_Safe_Suplly_DAO"+e);
		}
	}
	return arrayList;
	
}
public ArrayList getHabitaionDPSafeSupply(Rws_Habitation_Safe_Suplly_Form mForm,HttpSession session) {
	ArrayList arrayList=new  ArrayList();
	Connection connection=null;
	PreparedStatement preparedStatement=null;
	ResultSet resultSet=null;
	PreparedStatement preparedStatement1=null;
	ResultSet resultSet1=null;
	PreparedStatement preparedStatement2=null;
	ResultSet resultSet2=null;
	
	String query="";
	int count=1;
	String habCode=mForm.getHabitation();
	try{
	connection=RwsOffices.getConn();
	query="select OTHERS_SUPPLY_SAFE,OTHERS_NO_SAFE,OTHERS_SUPPLY,OTHERS_NO from  rws_hab_supply_status_tbl where HAB_CODE=?";
	preparedStatement=connection.prepareStatement(query);
	preparedStatement.setString(1, habCode);
	resultSet=preparedStatement.executeQuery();
	if(resultSet.next()){
		mForm.setDpHabLPCD(resultSet.getInt(1));
		mForm.setDpSafeNo(resultSet.getInt(2));
		mForm.setDpHabUnsafeLPCD(resultSet.getInt(3));
		mForm.setDpUnSafeNo(resultSet.getInt(4));
		session.setAttribute("status", "Yes");
	}
	preparedStatement.close();
	resultSet.close();
	query="select a.ASSET_CODE,nvl(b.ASSET_NAME,'--'),a.SOURCE_CODE,nvl(a.LOCATION,'--'),a.SAFE_LPD,nvl(a.SOURCE_NAME,'--'),a.UNSAFE_LPD,FLOURIDE,BRAKISH,IRON,NITRATE,nvl(to_char(a.UPDATE_DATE,'dd/mm/yyyy'),'--'),SOURCE_TYPE_CODE,nvl(STATUS,'') as status,PLATFORM_EXISTING,SOAK_PIT,nvl(YIELD,'--') as YIELD from  rws_source_tbl a,rws_asset_mast_tbl b where a.HAB_CODE=? and TYPE_OF_ASSET_CODE ='09' and a.asset_code=b.asset_code";
	preparedStatement=connection.prepareStatement(query);
	preparedStatement.setString(1, habCode);
	resultSet=preparedStatement.executeQuery();
	while(resultSet.next()){
		mForm=new Rws_Habitation_Safe_Suplly_Form();
		mForm.setsNo(count++);
		mForm.setOthersAssetCode(resultSet.getString(1));
		mForm.setOthersAssetName(resultSet.getString(2));
		mForm.setOthersSourceCode(resultSet.getString(3));
		mForm.setOthersLocation(resultSet.getString(4));
		mForm.setOthersSafeLPCD(resultSet.getInt(5));
		mForm.setOthersUnSafeLPCD(resultSet.getInt(7));
		mForm.setOthersSourceName("Direct Pumping/"+resultSet.getString(6));
		mForm.setTableName("source");
		mForm.setSourceStatus(resultSet.getString("status"));
		mForm.setYield(resultSet.getString("YIELD"));
		mForm.setSourceType(resultSet.getString("SOURCE_TYPE_CODE"));
		mForm.setImageStatus(getImageStatus(resultSet.getString("ASSET_CODE"), resultSet.getString("SOURCE_CODE")));
		
		String waterBeging="select WATER_SUPP_FREQ from rws_asset_hab_tbl where asset_code=? and hab_code=?";
		preparedStatement1=connection.prepareStatement(waterBeging);
		preparedStatement1.setString(1,resultSet.getString(1));
		preparedStatement1.setString(2,habCode);
		resultSet1=preparedStatement1.executeQuery();
		if(resultSet1.next()){
			mForm.setWaterBeingSupplied(resultSet1.getString("WATER_SUPP_FREQ"));
		}
		preparedStatement1.close();
		resultSet1.close();
		
		String testResults="";
			testResults="select to_char(max(prepared_on),'dd/mm/yyyy') from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and source_code=? order by max(prepared_on) desc";
		preparedStatement1=connection.prepareStatement(testResults);
		preparedStatement1.setString(1,resultSet.getString(3));
		resultSet1=preparedStatement1.executeQuery();
		if(resultSet1.next()){
			if(resultSet1.getString(1)!=null && !resultSet1.getString(1).equals("")){
			mForm.setPreparedOn(resultSet1.getString(1));
				
			String flouride="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='13' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
			preparedStatement2=connection.prepareStatement(flouride);
			preparedStatement2.setString(1,resultSet.getString(3));
			preparedStatement2.setString(2,resultSet1.getString(1));
			resultSet2=preparedStatement2.executeQuery();
			if(resultSet2.next()){
				mForm.setFlouride(resultSet2.getString(1));
			}
			else{
				
				mForm.setFlouride("--");
				mForm.setTestid("--");
				
			}
			preparedStatement2.close();
			resultSet2.close();
			String iron="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='16' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
			preparedStatement2=connection.prepareStatement(iron);
			preparedStatement2.setString(1,resultSet.getString(3));
			preparedStatement2.setString(2,resultSet1.getString(1));
			resultSet2=preparedStatement2.executeQuery();
			if(resultSet2.next()){
				mForm.setIron(resultSet2.getString(1));
				
			}
			else{
				mForm.setIron("--");
			}
			preparedStatement2.close();
			resultSet2.close();
			
			String nitrate="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='15' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
			preparedStatement2=connection.prepareStatement(nitrate);
			preparedStatement2.setString(1,resultSet.getString(3));
			preparedStatement2.setString(2,resultSet1.getString(1));
			resultSet2=preparedStatement2.executeQuery();
			if(resultSet2.next()){
				mForm.setNitrate(resultSet2.getString(1));
				
			}
			else{
				
				mForm.setNitrate("--");
				
			}
			preparedStatement2.close();
			resultSet2.close();
			
				
			String barkish="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='05' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
			preparedStatement2=connection.prepareStatement(barkish);
			preparedStatement2.setString(1,resultSet.getString(3));
			preparedStatement2.setString(2,resultSet1.getString(1));
			resultSet2=preparedStatement2.executeQuery();
			if(resultSet2.next()){
				mForm.setBrakish(resultSet2.getString(1));
				
			}
			else{
				
				mForm.setBrakish("--");
				
			}
			preparedStatement2.close();
			resultSet2.close();
			
			}
			else{
				mForm.setPreparedOn("--");
				mForm.setFlouride("--");
				mForm.setBrakish("--");
				mForm.setIron("--");
				mForm.setNitrate("--");
			}
		}
		else{
			mForm.setPreparedOn("--");
			mForm.setFlouride("--");
			mForm.setBrakish("--");
			mForm.setIron("--");
			mForm.setNitrate("--");
		}
		preparedStatement1.close();
		resultSet1.close();
		arrayList.add(mForm);
	}
	preparedStatement.close();
	resultSet.close();
	}
	catch(Exception e){
		System.out.println("Exception at getHabitaionDPSafeSupply in Rws_Habitation_Safe_Suplly_DAO"+e);
	}
	finally {
		try{
		if(connection!=null){
			connection.close();
		}
		}
		catch(Exception e){
			System.out.println("Exception at finally block of getHabitaionDPSafeSupply in Rws_Habitation_Safe_Suplly_DAO"+e);
		}
	}
	return arrayList;
}
public ArrayList getHabitaionOthersSafeSupply(Rws_Habitation_Safe_Suplly_Form mForm,HttpSession session) {
	
	ArrayList arrayList=new  ArrayList();
	Connection connection=null;
	PreparedStatement preparedStatement=null;
	ResultSet resultSet=null;
	PreparedStatement preparedStatement1=null;
	ResultSet resultSet1=null;
	PreparedStatement preparedStatement2=null;
	ResultSet resultSet2=null;
	
	String query="";
	int count=1;
	String habCode=mForm.getHabitation();
	try{
	connection=RwsOffices.getConn();
	query="select OTHERS_SUPPLY_SAFE,OTHERS_NO_SAFE,OTHERS_SUPPLY,OTHERS_NO from  rws_hab_supply_status_tbl where HAB_CODE=?";
	preparedStatement=connection.prepareStatement(query);
	preparedStatement.setString(1, habCode);
	resultSet=preparedStatement.executeQuery();
	if(resultSet.next()){
		mForm.setOthersHabLPCD(resultSet.getInt(1));
		mForm.setOthersNo(resultSet.getInt(2));
		mForm.setOthersHabUnsafeLPCD(resultSet.getInt(3));
		mForm.setOthersUnSafeNo(resultSet.getInt(4));
		session.setAttribute("status", "Yes");
	}
	preparedStatement.close();
	resultSet.close();
	query="select a.ASSET_CODE,nvl(b.ASSET_NAME,'--'),a.OPENWELL_CODE,nvl(a.LOCATION,'--'),a.SAFE_LPD,a.UNSAFE_LPD,FLOURIDE_PER,BRAKISH_PER,IRON_PER,NITRATE,nvl(to_char(a.UPDATE_DATE,'dd/mm/yyyy'),'--'),nvl(STATUS,'') as status,PLATFORM_EXISTING,SOAK_PIT  from  RWS_OPEN_WELL_MAST_TBL a,rws_asset_mast_tbl b where a.HABITATION_CODE=? and TYPE_OF_ASSET_CODE ='06' and a.asset_code=b.asset_code";
	preparedStatement=connection.prepareStatement(query);
	preparedStatement.setString(1, habCode);
	resultSet=preparedStatement.executeQuery();
	while(resultSet.next()){
		mForm=new Rws_Habitation_Safe_Suplly_Form();
		mForm.setsNo(count++);
		mForm.setOthersAssetCode(resultSet.getString(1));
		mForm.setOthersAssetName(resultSet.getString(2));
		mForm.setOthersSourceCode(resultSet.getString(3));
		mForm.setOthersLocation(resultSet.getString(4));
		mForm.setOthersSafeLPCD(resultSet.getInt(5));
		mForm.setOthersUnSafeLPCD(resultSet.getInt(6));
		mForm.setOthersSourceName("OPEN WELL");
		mForm.setTableName("ow");
		mForm.setSourceStatus(resultSet.getString("status"));
		mForm.setPlatformExisting(resultSet.getString("PLATFORM_EXISTING"));
		mForm.setSoakPit(resultSet.getString("SOAK_PIT"));
		mForm.setYield("--");
		mForm.setImageStatus(getImageStatus(resultSet.getString("ASSET_CODE"), resultSet.getString("OPENWELL_CODE")));
		
		String waterBeging="select WATER_SUPP_FREQ from rws_asset_hab_tbl where asset_code=? and hab_code=?";
		preparedStatement1=connection.prepareStatement(waterBeging);
		preparedStatement1.setString(1,resultSet.getString(1));
		preparedStatement1.setString(2,habCode);
		resultSet1=preparedStatement1.executeQuery();
		if(resultSet1.next()){
			mForm.setWaterBeingSupplied(resultSet1.getString("WATER_SUPP_FREQ"));
		}
		preparedStatement1.close();
		resultSet1.close();
		
		String testResults="";
			testResults="select to_char(max(prepared_on),'dd/mm/yyyy') from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and source_code=? order by max(prepared_on) desc";
		preparedStatement1=connection.prepareStatement(testResults);
		preparedStatement1.setString(1,resultSet.getString(3));
		resultSet1=preparedStatement1.executeQuery();
		if(resultSet1.next()){
			if(resultSet1.getString(1)!=null && !resultSet1.getString(1).equals("")){
			mForm.setPreparedOn(resultSet1.getString(1));
			String flouride="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='13' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
			preparedStatement2=connection.prepareStatement(flouride);
			preparedStatement2.setString(1,resultSet.getString(3));
			preparedStatement2.setString(2,resultSet1.getString(1));
			resultSet2=preparedStatement2.executeQuery();
			if(resultSet2.next()){
				mForm.setFlouride(resultSet2.getString(1));
			}
			else{
				
				mForm.setFlouride("--");
				mForm.setTestid("--");
				
			}
			preparedStatement2.close();
			resultSet2.close();
			
				
			String iron="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='16' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
			preparedStatement2=connection.prepareStatement(iron);
			preparedStatement2.setString(1,resultSet.getString(3));
			preparedStatement2.setString(2,resultSet1.getString(1));
			resultSet2=preparedStatement2.executeQuery();
			if(resultSet2.next()){
				mForm.setIron(resultSet2.getString(1));
				
			}
			else{
				mForm.setIron("--");
			}
			preparedStatement2.close();
			resultSet2.close();
			
				
			String nitrate="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='15' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
			preparedStatement2=connection.prepareStatement(nitrate);
			preparedStatement2.setString(1,resultSet.getString(3));
			preparedStatement2.setString(2,resultSet1.getString(1));
			resultSet2=preparedStatement2.executeQuery();
			if(resultSet2.next()){
				mForm.setNitrate(resultSet2.getString(1));
				
			}
			else{
				
				mForm.setNitrate("--");
				
			}
			preparedStatement2.close();
			resultSet2.close();
			
				
			String barkish="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='05' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
			preparedStatement2=connection.prepareStatement(barkish);
			preparedStatement2.setString(1,resultSet.getString(3));
			preparedStatement2.setString(2,resultSet1.getString(1));
			resultSet2=preparedStatement2.executeQuery();
			if(resultSet2.next()){
				mForm.setBrakish(resultSet2.getString(1));
				
			}
			else{
				
				mForm.setBrakish("--");
				
			}
			preparedStatement2.close();
			resultSet2.close();
			
			}
			else{
				mForm.setPreparedOn("--");
				mForm.setFlouride("--");
				mForm.setBrakish("--");
				mForm.setIron("--");
				mForm.setNitrate("--");
				
			}
		}
		else{
			mForm.setPreparedOn("--");
			mForm.setFlouride("--");
			mForm.setBrakish("--");
			mForm.setIron("--");
			mForm.setNitrate("--");
			
		}
		preparedStatement1.close();
		resultSet1.close();
		arrayList.add(mForm);
	}
	preparedStatement.close();
	resultSet.close();
	
	
	
	query="select a.ASSET_CODE,nvl(b.ASSET_NAME,'--'),a.OTHER_COMP_CODE,nvl(a.COMP_LOCATION,'--'),nvl(a.COMP_NAME,'--'),a.COLLECTION_TANK_CAPACITY,nvl(to_char(a.UPDATE_DATE,'dd/mm/yyyy'),'--'),nvl(STATUS,'') as status,nvl(YEILD,0) as YEILD,a.SPECIAL_ASSET_TYPE as SPECIAL_ASSET_TYPE from  RWS_AST_OTHERS_PARAM_TBL a,rws_asset_mast_tbl b where a.HAB_CODE=? and a.SPECIAL_ASSET_TYPE in ('Spring','Solar','CTP') and a.asset_code=b.asset_code";
	preparedStatement=connection.prepareStatement(query);
	preparedStatement.setString(1, habCode);
	resultSet=preparedStatement.executeQuery();
	while(resultSet.next()){
		mForm=new Rws_Habitation_Safe_Suplly_Form();
		mForm.setsNo(count++);
		mForm.setOthersAssetCode(resultSet.getString(1));
		mForm.setOthersAssetName(resultSet.getString(2));
		mForm.setOthersSourceCode(resultSet.getString(3));
		mForm.setOthersLocation(resultSet.getString(4));
		if(resultSet.getString("SPECIAL_ASSET_TYPE").equals("Spring")){
			mForm.setOthersSourceName("Spring / "+resultSet.getString(5));
		}
		else if(resultSet.getString("SPECIAL_ASSET_TYPE").equals("Solar")){
			mForm.setOthersSourceName("Solar / "+resultSet.getString(5));
		}
		else if(resultSet.getString("SPECIAL_ASSET_TYPE").equals("CTP")){
			mForm.setOthersSourceName("Community Water Treatment Plants / "+resultSet.getString(5));
		}
		mForm.setOthersSafeLPCD(resultSet.getInt(6));
		mForm.setTableName("spring");
		mForm.setSourceStatus(resultSet.getString("status"));
		mForm.setYield(resultSet.getString("YEILD"));
		
		String waterBeging="select WATER_SUPP_FREQ from rws_asset_hab_tbl where asset_code=? and hab_code=?";
		preparedStatement1=connection.prepareStatement(waterBeging);
		preparedStatement1.setString(1,resultSet.getString(1));
		preparedStatement1.setString(2,habCode);
		resultSet1=preparedStatement1.executeQuery();
		if(resultSet1.next()){
			mForm.setWaterBeingSupplied(resultSet1.getString("WATER_SUPP_FREQ"));
		}
		preparedStatement1.close();
		resultSet1.close();
		
		String testResults="";
			testResults="select to_char(max(prepared_on),'dd/mm/yyyy') from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and source_code=? order by max(prepared_on) desc";
		preparedStatement1=connection.prepareStatement(testResults);
		preparedStatement1.setString(1,resultSet.getString(3));
		resultSet1=preparedStatement1.executeQuery();
		if(resultSet1.next()){
			if(resultSet1.getString(1)!=null && !resultSet1.getString(1).equals("")){
			mForm.setPreparedOn(resultSet1.getString(1));
				
			String flouride="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='13' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
			preparedStatement2=connection.prepareStatement(flouride);
			preparedStatement2.setString(1,resultSet.getString(3));
			preparedStatement2.setString(2,resultSet1.getString(1));
			resultSet2=preparedStatement2.executeQuery();
			if(resultSet2.next()){
				mForm.setFlouride(resultSet2.getString(1));
			}
			else{
				
				mForm.setFlouride("--");
				mForm.setTestid("--");
				
			}
			preparedStatement2.close();
			resultSet2.close();
			
				
			String iron="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='16' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
			preparedStatement2=connection.prepareStatement(iron);
			preparedStatement2.setString(1,resultSet.getString(3));
			preparedStatement2.setString(2,resultSet1.getString(1));
			resultSet2=preparedStatement2.executeQuery();
			if(resultSet2.next()){
				mForm.setIron(resultSet2.getString(1));
				
			}
			else{
				mForm.setIron("--");
			}
			preparedStatement2.close();
			resultSet2.close();
			
				
			String nitrate="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='15' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
			preparedStatement2=connection.prepareStatement(nitrate);
			preparedStatement2.setString(1,resultSet.getString(3));
			preparedStatement2.setString(2,resultSet1.getString(1));
			resultSet2=preparedStatement2.executeQuery();
			if(resultSet2.next()){
				mForm.setNitrate(resultSet2.getString(1));
				
			}
			else{
				
				mForm.setNitrate("--");
				
			}
			preparedStatement2.close();
			resultSet2.close();
			
				
			String barkish="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='05' AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";
			preparedStatement2=connection.prepareStatement(barkish);
			preparedStatement2.setString(1,resultSet.getString(3));
			preparedStatement2.setString(2,resultSet1.getString(1));
			resultSet2=preparedStatement2.executeQuery();
			if(resultSet2.next()){
				mForm.setBrakish(resultSet2.getString(1));
				
			}
			else{
				
				mForm.setBrakish("--");
				
			}
			preparedStatement2.close();
			resultSet2.close();
			
			}
			else{
				mForm.setPreparedOn("--");
				mForm.setFlouride("--");
				mForm.setBrakish("--");
				mForm.setIron("--");
				mForm.setNitrate("--");
				
			}
		}
		else{
			mForm.setPreparedOn("--");
			mForm.setFlouride("--");
			mForm.setBrakish("--");
			mForm.setIron("--");
			mForm.setNitrate("--");
			
		}
		preparedStatement1.close();
		resultSet1.close();
		arrayList.add(mForm);
	}
	preparedStatement.close();
	resultSet.close();
	
	}
	catch(Exception e){
		System.out.println("Exception at getHabitaionOthersSafeSupply in Rws_Habitation_Safe_Suplly_DAO"+e);
	}
	finally {
		try{
		if(connection!=null){
			connection.close();
		}
		}
		catch(Exception e){
			System.out.println("Exception at finally block of getHabitaionOthersSafeSupply in Rws_Habitation_Safe_Suplly_DAO"+e);
		}
	}
	return arrayList;
	
}
public String saveSchemes(Rws_Habitation_Safe_Suplly_Form myForm,HttpServletRequest request){
	String query="";
	Connection connection=null;
	Statement statement=null;
	int recCount=0;
	
	try{
		connection=RwsOffices.getConn();
		connection.setAutoCommit(false);
		statement=connection.createStatement();	
		if(myForm.getContaminationType()==null)
			myForm.setContaminationType("");
	
		//query="update rws_habitation_dir_dyna_tbl  set LPCD_ACT_POPU='"+myForm.getNewLpcd()+"', UNSAFE_LPCD='"+myForm.getLevelOfWaterSupplyUnSafeSource()+"',SAFE_LPCD='"+myForm.getLevelOfWaterSupplySafeSource()+"',COVERAGE_STATUS='"+myForm.getCoverageStatus()+"',EXIST_WATER_LEVEL='"+myForm.getLevelOfWaterSupplyLPCD()+"',TOTAL_WATER_SUPPLY='"+myForm.getTotalWaterSupply()+"',UPDATE_DATE=SYSDATE,GLSR_NO='"+myForm.getGlsrNo()+"',GLSR_QTY='"+myForm.getGlsrQty()+"',OHSR_NO='"+myForm.getOhsrNo()+"',OHSR_QTY='"+myForm.getOhsrQty()+"',NO_OF_TAPS_WITH_STANDPOSTS='"+myForm.getStandPosts()+"',contam_type='"+myForm.getContaminationType()+"'  where HAB_CODE='"+myForm.getHabitation()+"'";
		query="update rws_habitation_dir_dyna_tbl set ACT_COVERAGE_STATUS='"+myForm.getNewCoverageStatus()+"',LPCD_ACT_POPU='"+myForm.getNewLpcd()+"', UNSAFE_LPCD='"+myForm.getLevelOfWaterSupplyUnSafeSource()+"',SAFE_LPCD='"+myForm.getLevelOfWaterSupplySafeSource()+"',COVERAGE_STATUS='"+myForm.getCoverageStatus()+"',EXIST_WATER_LEVEL='"+myForm.getLevelOfWaterSupplyLPCD()+"',TOTAL_WATER_SUPPLY='"+myForm.getTotalWaterSupply()+"',UPDATE_DATE=SYSDATE,GLSR_NO='"+myForm.getGlsrNo()+"',GLSR_QTY='"+myForm.getGlsrQty()+"',OHSR_NO='"+myForm.getOhsrNo()+"',OHSR_QTY='"+myForm.getOhsrQty()+"',NO_OF_TAPS_WITH_STANDPOSTS='"+myForm.getStandPosts()+"'  where HAB_CODE='"+myForm.getHabitation()+"'";//"',contam_type='"+myForm.getContaminationType()+
		statement.addBatch(query);
		recCount++;
		
		query="update rws_hab_supply_status_tbl set UPDATE_DATE=SYSDATE  where HAB_CODE='"+myForm.getHabitation()+"'";
		statement.addBatch(query);
		recCount++;
		
		if(myForm.getPws().size()!=0){
			recCount++;
			query="update rws_hab_supply_status_tbl set  PWS_SUPPLY='"+myForm.getPwsHabLPCD()+"',PWS_NO='"+myForm.getPwsNo()+"',PWS_UNSAFE_SUPPLY='"+myForm.getPwsHabUnsafeLPCD()+"',PWS_UNSAFE_NO='"+myForm.getPwsUnSafeNo()+"'  where HAB_CODE='"+myForm.getHabitation()+"'";
			statement.addBatch(query);
			
		}
		else{
			recCount++;
			query="update rws_hab_supply_status_tbl set  PWS_SUPPLY='0',PWS_NO='0',PWS_UNSAFE_SUPPLY='0',PWS_UNSAFE_NO='0'  where HAB_CODE='"+myForm.getHabitation()+"'";
			statement.addBatch(query);
		}
		
	for (int i = 0; i < myForm.getPws().size(); i++) {
		recCount++;
		Rws_Habitation_Safe_Suplly_Form pwsRecord = myForm.getPws().get(i);
		if(pwsRecord.getFlouride().equals("--")){
			pwsRecord.setFlouride("");
		}
		if(pwsRecord.getBrakish().equals("--")){
			pwsRecord.setBrakish("");
		}
		if(pwsRecord.getIron().equals("--")){
			pwsRecord.setIron("");
		}
		if(pwsRecord.getNitrate().equals("--")){
			pwsRecord.setNitrate("");
		}
		if(pwsRecord.getTableName().equals("source")){
			query="update rws_source_tbl set SAFE_LPD='"+pwsRecord.getPwsSafeLPCD()+"',UNSAFE_LPD='"+pwsRecord.getPwsUnSafeLPCD()+"',FLOURIDE='"+pwsRecord.getFlouride()+"',BRAKISH='"+pwsRecord.getBrakish()+"',IRON='"+pwsRecord.getIron()+"',NITRATE='"+pwsRecord.getNitrate()+"',SOURCE_TYPE_CODE='"+pwsRecord.getSourceType()+"',STATUS='"+pwsRecord.getSourceStatus()+"' where asset_code='"+pwsRecord.getPwsAssetCode()+"' and source_code='"+pwsRecord.getPwsSourceCode()+"'";
			statement.addBatch(query);
			
			query="update rws_asset_hab_tbl set WATER_SUPP_FREQ='"+pwsRecord.getWaterBeingSupplied()+"' where asset_code='"+pwsRecord.getPwsAssetCode()+"' and hab_code='"+myForm.getHabitation()+"'";
			statement.addBatch(query);
			recCount++;
			
		}
		else if(pwsRecord.getTableName().equals("glsr")){
			query="update RWS_AST_GLSR_SC_PARAM_TBL set GLSR_CAP_LTS='"+pwsRecord.getPwsSafeLPCD()+"' where asset_code='"+pwsRecord.getPwsAssetCode()+"' and glsr_code='"+pwsRecord.getPwsSourceCode()+"'";
			
			statement.addBatch(query);
		
		}
		else if(pwsRecord.getTableName().equals("ohsr")){
			query="update RWS_AST_OHSR_SC_PARAM_TBL set OHSR_CAP_LTS='"+pwsRecord.getPwsSafeLPCD()+"' where asset_code='"+pwsRecord.getPwsAssetCode()+"' and ohsr_code='"+pwsRecord.getPwsSourceCode()+"'";
			statement.addBatch(query);
			
		}
		
	}
	
	if(myForm.getMpws().size()!=0){
		recCount++;
		query="update rws_hab_supply_status_tbl set MPWS_SUPPLY='"+myForm.getMpwsHabLPCD()+"',MPWS_NO='"+myForm.getMpwsNo()+"',MPWS_UNSAFE_SUPPLY='"+myForm.getMpwsHabUnsafeLPCD()+"',MPWS_UNSAFE_NO='"+myForm.getMpwsUnSafeNo()+"'  where HAB_CODE='"+myForm.getHabitation()+"'";
		statement.addBatch(query);
	}
	else{
		recCount++;
		query="update rws_hab_supply_status_tbl set MPWS_SUPPLY='0',MPWS_NO='0',MPWS_UNSAFE_SUPPLY='0',MPWS_UNSAFE_NO='0'  where HAB_CODE='"+myForm.getHabitation()+"'";
		statement.addBatch(query);
	}
	for (int i = 0; i < myForm.getMpws().size(); i++) {
		recCount++;
		Rws_Habitation_Safe_Suplly_Form mpwsRecord = myForm.getMpws().get(i);
		if(mpwsRecord.getFlouride().equals("--")){
			mpwsRecord.setFlouride("");
		}
		if(mpwsRecord.getBrakish().equals("--")){
			mpwsRecord.setBrakish("");
		}
		if(mpwsRecord.getIron().equals("--")){
			mpwsRecord.setIron("");
		}
		if(mpwsRecord.getNitrate().equals("--")){
			mpwsRecord.setNitrate("");
		}
		if(mpwsRecord.getTableName().equals("source")){
			query="update rws_source_tbl set SAFE_LPD='"+mpwsRecord.getMpwsSafeLPCD()+"',UNSAFE_LPD='"+mpwsRecord.getMpwsUnSafeLPCD()+"',FLOURIDE='"+mpwsRecord.getFlouride()+"',BRAKISH='"+mpwsRecord.getBrakish()+"',IRON='"+mpwsRecord.getIron()+"',NITRATE='"+mpwsRecord.getNitrate()+"',SOURCE_TYPE_CODE='"+mpwsRecord.getSourceType()+"',STATUS='"+mpwsRecord.getSourceStatus()+"' where asset_code='"+mpwsRecord.getMpwsAssetCode()+"' and source_code='"+ mpwsRecord.getMpwsSourceCode()+"'";
			statement.addBatch(query);
			
			query="update rws_asset_hab_tbl set WATER_SUPP_FREQ='"+mpwsRecord.getWaterBeingSupplied()+"' where asset_code='"+mpwsRecord.getMpwsAssetCode()+"' and hab_code='"+myForm.getHabitation()+"'";
			statement.addBatch(query);
			recCount++;
		}
		else if(mpwsRecord.getTableName().equals("glsr")){
			query="update RWS_AST_GLSR_SC_PARAM_TBL set GLSR_CAP_LTS='"+mpwsRecord.getMpwsSafeLPCD()+"' where asset_code='"+mpwsRecord.getMpwsAssetCode()+"' and glsr_code='"+mpwsRecord.getMpwsSourceCode()+"'";
			statement.addBatch(query);
		}
		else if(mpwsRecord.getTableName().equals("ohsr")){
			query="update RWS_AST_OHSR_SC_PARAM_TBL set OHSR_CAP_LTS='"+mpwsRecord.getMpwsSafeLPCD()+"' where asset_code='"+mpwsRecord.getMpwsAssetCode()+"' and ohsr_code='"+mpwsRecord.getMpwsSourceCode()+"'";
			statement.addBatch(query);
		}
		
	}
	for (int i = 0; i < myForm.getDps().size(); i++) {
		recCount++;
		Rws_Habitation_Safe_Suplly_Form dpRecord = myForm.getDps().get(i);
		if(dpRecord.getFlouride().equals("--")){
			dpRecord.setFlouride("");
		}
		if(dpRecord.getBrakish().equals("--")){
			dpRecord.setBrakish("");
		}
		if(dpRecord.getIron().equals("--")){
			dpRecord.setIron("");
		}
		if(dpRecord.getNitrate().equals("--")){
			dpRecord.setNitrate("");
		}
			query="update rws_source_tbl set SAFE_LPD='"+dpRecord.getOthersSafeLPCD()+"',UNSAFE_LPD='"+dpRecord.getOthersUnSafeLPCD()+"',FLOURIDE='"+dpRecord.getFlouride()+"',BRAKISH='"+dpRecord.getBrakish()+"',IRON='"+dpRecord.getIron()+"',NITRATE='"+dpRecord.getNitrate()+"',SOURCE_TYPE_CODE='"+dpRecord.getSourceType()+"',STATUS='"+dpRecord.getSourceStatus()+"' where asset_code='"+dpRecord.getOthersAssetCode()+"' and source_code='"+ dpRecord.getOthersSourceCode()+"'";
			statement.addBatch(query);
			
			query="update rws_asset_hab_tbl set WATER_SUPP_FREQ='"+dpRecord.getWaterBeingSupplied()+"' where asset_code='"+dpRecord.getOthersAssetCode()+"' and hab_code='"+myForm.getHabitation()+"'";
			statement.addBatch(query);
			recCount++;
	}
	
	if(myForm.getCpwsLinks().size()!=0){
		recCount++;
		query="update rws_hab_supply_status_tbl set CPWS_HAB_SUPPLY='"+myForm.getCpwsHabLinkLPCD()+"' where HAB_CODE='"+myForm.getHabitation()+"'";
		statement.addBatch(query);
	}
	//added
		else{
			recCount++;
			query="update rws_hab_supply_status_tbl set CPWS_HAB_SUPPLY='0' where HAB_CODE='"+myForm.getHabitation()+"'";
			statement.addBatch(query);
		}
	for (int i = 0; i < myForm.getCpwsLinks().size(); i++) {
		recCount++;
		Rws_Habitation_Safe_Suplly_Form cpwsLinksRecord = myForm.getCpwsLinks().get(i);
		
		query="update rws_asset_hab_tbl set WATER_SUPP_FREQ='"+cpwsLinksRecord.getWaterBeingSupplied()+"' where asset_code='"+cpwsLinksRecord.getCpwsLinksAssetCode()+"' and hab_code='"+myForm.getHabitation()+"'";
		statement.addBatch(query);
		
	}
	for (int i = 0; i < myForm.getCpwsResLinks().size(); i++) {
		recCount++;
		Rws_Habitation_Safe_Suplly_Form cpwsLinkResRecord = myForm.getCpwsResLinks().get(i);
		if (cpwsLinkResRecord.getTableName().equals("glsr")) {
			query = "update RWS_OHGLCI_HAB_LINK_TBL set YIELD='" + cpwsLinkResRecord.getCpwsLinksSafeLPCD()
					+ "' where SUBCOMP_CODE='" + cpwsLinkResRecord.getCpwsLinksSourceCode() + "' and hab_code='"
					+ myForm.getHabitation() + "'";

			// System.out.println(query);
			statement.addBatch(query);
		} else if (cpwsLinkResRecord.getTableName().equals("ohsr")) {
			query = "update RWS_OHGLCI_HAB_LINK_TBL  set YIELD='" + cpwsLinkResRecord.getCpwsLinksSafeLPCD()
					+ "' where SUBCOMP_CODE='" + cpwsLinkResRecord.getCpwsLinksSourceCode() + "' and hab_code='"
					+ myForm.getHabitation() + "'";

			// System.out.println(query);
			statement.addBatch(query);
		}
	}
	if(myForm.getPwsLinks().size()!=0){
		recCount++;
		query="update rws_hab_supply_status_tbl set PWS_HAB_SUPPLY='"+myForm.getPwsHabLinkLPCD()+"',PWS_HAB_UNSAFE_SUPPLY='"+myForm.getPwsHabLinkUnsafeLPCD()+"' where HAB_CODE='"+myForm.getHabitation()+"'";
		statement.addBatch(query);	
	}
	//added
		else{
			recCount++;
			query="update rws_hab_supply_status_tbl set PWS_HAB_SUPPLY='0',PWS_HAB_UNSAFE_SUPPLY='0' where HAB_CODE='"+myForm.getHabitation()+"'";
			statement.addBatch(query);
		}
	for (int i = 0; i < myForm.getPwsLinks().size(); i++) {
		Rws_Habitation_Safe_Suplly_Form pwsLinksRecord = myForm.getPwsLinks().get(i);
	
		if (pwsLinksRecord.getTableName().equals("source")) {
			recCount++;
			query = "update rws_asset_hab_tbl set WATER_SUPP_FREQ='" + pwsLinksRecord.getWaterBeingSupplied()
					+ "' where asset_code='" + pwsLinksRecord.getPwsLinksAssetCode() + "' and hab_code='"
					+ myForm.getHabitation() + "'";
			statement.addBatch(query);
			query = "update RWS_SOURCE_HABITATION_TBL set SAFE_SUPPLY='" + pwsLinksRecord.getPwsLinksSafeLPCD()
					+ "',UNSAFE_SUPPLY='" + pwsLinksRecord.getPwsLinksUnSafeLPCD() + "' where HAB_CODE='"
					+ myForm.getHabitation() + "' and source_code='" + pwsLinksRecord.getPwsLinksSourceCode()
					+ "'";
			statement.addBatch(query);
		} else if (pwsLinksRecord.getTableName().equals("glsr")) {
			query = "update RWS_OHGLCI_HAB_LINK_TBL set YIELD='" + pwsLinksRecord.getPwsLinksSafeLPCD()
					+ "' where SUBCOMP_CODE='" + pwsLinksRecord.getPwsLinksSourceCode() + "' and hab_code='"
					+ myForm.getHabitation() + "'";
			statement.addBatch(query);
		} else if (pwsLinksRecord.getTableName().equals("ohsr")) {
			query = "update RWS_OHGLCI_HAB_LINK_TBL  set YIELD='" + pwsLinksRecord.getPwsLinksSafeLPCD()
					+ "' where SUBCOMP_CODE='" + pwsLinksRecord.getPwsLinksSourceCode() + "' and hab_code='"
					+ myForm.getHabitation() + "'";
			statement.addBatch(query);
		}
		recCount++;	
	}
	if(myForm.getMpwsLinks().size()!=0){
		recCount++;
		query="update rws_hab_supply_status_tbl set MPWS_HAB_SUPPLY='"+myForm.getMpwsHabLinkLPCD()+"',MPWS_HAB_UNSAFE_SUPPLY='"+myForm.getMpwsHabLinkUnsafeLPCD()+"' where HAB_CODE='"+myForm.getHabitation()+"'";
		statement.addBatch(query);
	}
	//added
		else{
			recCount++;
			query="update rws_hab_supply_status_tbl set MPWS_HAB_SUPPLY='0',MPWS_HAB_UNSAFE_SUPPLY='0' where HAB_CODE='"+myForm.getHabitation()+"'";
			statement.addBatch(query);
		}
	for (int i = 0; i < myForm.getMpwsLinks().size(); i++) {
		
		Rws_Habitation_Safe_Suplly_Form mpwsLinksRecord = myForm.getMpwsLinks().get(i);
		
		if (mpwsLinksRecord.getTableName().equals("source")) {
			recCount++;
			query = "update rws_asset_hab_tbl set WATER_SUPP_FREQ='" + mpwsLinksRecord.getWaterBeingSupplied()
					+ "' where asset_code='" + mpwsLinksRecord.getMpwsLinksAssetCode() + "' and hab_code='"
					+ myForm.getHabitation() + "'";
			statement.addBatch(query);
			query = "update RWS_SOURCE_HABITATION_TBL set SAFE_SUPPLY='"
					+ mpwsLinksRecord.getMpwsLinksSafeLPCD() + "',UNSAFE_SUPPLY='"
					+ mpwsLinksRecord.getMpwsLinksUnSafeLPCD() + "' where HAB_CODE='" + myForm.getHabitation()
					+ "' and source_code='" + mpwsLinksRecord.getMpwsLinksSourceCode() + "'";
			statement.addBatch(query);
		} else if (mpwsLinksRecord.getTableName().equals("glsr")) {
			query = "update RWS_OHGLCI_HAB_LINK_TBL set YIELD='" + mpwsLinksRecord.getMpwsLinksSafeLPCD()
					+ "' where SUBCOMP_CODE='" + mpwsLinksRecord.getMpwsLinksSourceCode() + "' and hab_code='"
					+ myForm.getHabitation() + "'";
			statement.addBatch(query);
		} else if (mpwsLinksRecord.getTableName().equals("ohsr")) {
			query = "update RWS_OHGLCI_HAB_LINK_TBL  set YIELD='" + mpwsLinksRecord.getMpwsLinksSafeLPCD()
					+ "' where SUBCOMP_CODE='" + mpwsLinksRecord.getMpwsLinksSourceCode() + "' and hab_code='"
					+ myForm.getHabitation() + "'";
			statement.addBatch(query);
		}
		recCount++;	
	}
	if(myForm.getDpLinks().size()!=0){
		recCount++;
		query="update rws_hab_supply_status_tbl set DP_HAB_SUPPLY='"+myForm.getDpHabLinkLPCD()+"',DP_HAB_UNSAFE_SUPPLY='"+myForm.getDpHabLinkUnsafeLPCD()+"' where HAB_CODE='"+myForm.getHabitation()+"'";
		statement.addBatch(query);
	}
	//added
		else{
			recCount++;
			query="update rws_hab_supply_status_tbl set DP_HAB_SUPPLY='0',DP_HAB_UNSAFE_SUPPLY='0' where HAB_CODE='"+myForm.getHabitation()+"'";
			statement.addBatch(query);
		}
	for (int i = 0; i < myForm.getDpLinks().size(); i++) {
		recCount++;
		Rws_Habitation_Safe_Suplly_Form dpLinksRecord = myForm.getDpLinks().get(i);		
		query="update rws_asset_hab_tbl set WATER_SUPP_FREQ='"+dpLinksRecord.getWaterBeingSupplied()+"' where asset_code='"+dpLinksRecord.getDpLinksAssetCode()+"' and hab_code='"+myForm.getHabitation()+"'";
		statement.addBatch(query);
		query="update RWS_SOURCE_HABITATION_TBL set SAFE_SUPPLY='"+dpLinksRecord.getDpLinksSafeLPCD()+"',UNSAFE_SUPPLY='"+dpLinksRecord.getDpLinksUnSafeLPCD()+"' where HAB_CODE='"+myForm.getHabitation()+"' and source_code='"+dpLinksRecord.getDpLinksSourceCode()+"'";
		statement.addBatch(query);
		recCount++;		
	}
	if(myForm.getCpws().size()!=0){
		recCount++;
		query="update rws_hab_supply_status_tbl set CPWS_SUPPLY='"+myForm.getCpwsHabLPCD()+"',CPWS_NO='"+myForm.getCpwsNo()+"' where HAB_CODE='"+myForm.getHabitation()+"'";
		statement.addBatch(query);
	}
	else{
		recCount++;
		query="update rws_hab_supply_status_tbl set CPWS_SUPPLY='0',CPWS_NO='0' where HAB_CODE='"+myForm.getHabitation()+"'";
		statement.addBatch(query);
	}
	for (int i = 0; i < myForm.getCpws().size(); i++) {
		recCount++;
		Rws_Habitation_Safe_Suplly_Form cpwsRecord = myForm.getCpws().get(i);
		if(cpwsRecord.getFlouride().equals("--")){
			cpwsRecord.setFlouride("");
		}
		if(cpwsRecord.getBrakish().equals("--")){
			cpwsRecord.setBrakish("");
		}
		if(cpwsRecord.getIron().equals("--")){
			cpwsRecord.setIron("");
		}
		if(cpwsRecord.getNitrate().equals("--")){
			cpwsRecord.setNitrate("");
		}
		if(cpwsRecord.getTableName().equals("source")){
			query="update rws_source_tbl set SAFE_LPD='"+ cpwsRecord.getCpwsSafeLPCD()+"',FLOURIDE='"+cpwsRecord.getFlouride()+"',BRAKISH='"+cpwsRecord.getBrakish()+"',IRON='"+cpwsRecord.getIron()+"',NITRATE='"+cpwsRecord.getNitrate()+"',STATUS='"+cpwsRecord.getSourceStatus()+"' where asset_code='"+cpwsRecord.getCpwsAssetCode()+"' and source_code='"+ cpwsRecord.getCpwsSourceCode()+"'";
			statement.addBatch(query);
			
			query="update rws_asset_hab_tbl set WATER_SUPP_FREQ='"+cpwsRecord.getWaterBeingSupplied()+"' where asset_code='"+cpwsRecord.getCpwsAssetCode()+"' and hab_code='"+myForm.getHabitation()+"'";
			statement.addBatch(query);
			recCount++;
		}
		else if(cpwsRecord.getTableName().equals("glsr")){
			query="update RWS_AST_GLSR_SC_PARAM_TBL set GLSR_CAP_LTS='"+cpwsRecord.getCpwsSafeLPCD()+"' where asset_code='"+cpwsRecord.getCpwsAssetCode()+"' and glsr_code='"+cpwsRecord.getCpwsSourceCode()+"'";
			statement.addBatch(query);
		}
		else if(cpwsRecord.getTableName().equals("ohsr")){
			query="update RWS_AST_OHSR_SC_PARAM_TBL set OHSR_CAP_LTS='"+cpwsRecord.getCpwsSafeLPCD()+"' where asset_code='"+cpwsRecord.getCpwsAssetCode()+"' and ohsr_code='"+cpwsRecord.getCpwsSourceCode()+"'";
			statement.addBatch(query);
		}
	}
	
	if(myForm.getHp().size()!=0){
		recCount++;
		query="update rws_hab_supply_status_tbl set HPS_OTH_SUPPLY='"+myForm.getHpHabLPCD()+"',HPS_NO='"+myForm.getHpNo()+"',HPS_OTH_SUPPLY_UNSAFE='"+myForm.getHpHabUnsafeLPCD()+"',HPS_NO_UNSAFE='"+myForm.getHpUnSafeNo()+"'  where HAB_CODE='"+myForm.getHabitation()+"'";
		statement.addBatch(query);
	}
	else{
		recCount++;
		query="update rws_hab_supply_status_tbl set HPS_OTH_SUPPLY='0',HPS_NO='0',HPS_OTH_SUPPLY_UNSAFE='0',HPS_NO_UNSAFE='0'  where HAB_CODE='"+myForm.getHabitation()+"'";
		statement.addBatch(query);
	}
	for (int i = 0; i < myForm.getHp().size(); i++) {
		recCount++;
		Rws_Habitation_Safe_Suplly_Form hpRecord = myForm.getHp().get(i);
		if(hpRecord.getFlouride().equals("--")){
			hpRecord.setFlouride("");
		}
		if(hpRecord.getBrakish().equals("--")){
			hpRecord.setBrakish("");
		}
		if(hpRecord.getIron().equals("--")){
			hpRecord.setIron("");
		}
		if(hpRecord.getNitrate().equals("--")){
			hpRecord.setNitrate("");
		}
		query="update RWS_HP_SUBCOMP_PARAM_TBL set SAFE_LPD='"+hpRecord.getHpSafeLPCD()+"',UNSAFE_LPD='"+hpRecord.getHpUnSafeLPCD()+"',FLOURIDE='"+hpRecord.getFlouride()+"',BRAKISH='"+hpRecord.getBrakish()+"',IRON='"+hpRecord.getIron()+"',NITRATE='"+hpRecord.getNitrate()+"',STATUS='"+hpRecord.getSourceStatus()+"',PLATFORM_EXISTING='"+hpRecord.getPlatformExisting()+"',SOAK_PIT='"+hpRecord.getSoakPit()+"' where asset_code='"+hpRecord.getHpAssetCode()+"' and HP_CODE='"+hpRecord.getHpSourceCode()+"'";
		statement.addBatch(query);
		
		query="update rws_asset_hab_tbl set WATER_SUPP_FREQ='"+hpRecord.getWaterBeingSupplied()+"' where asset_code='"+hpRecord.getHpAssetCode()+"' and hab_code='"+myForm.getHabitation()+"'";
		statement.addBatch(query);
		recCount++;
	}
	
	if(myForm.getShp().size()!=0){
		recCount++;
		query="update rws_hab_supply_status_tbl set SHP_DK_SUPPLY_SAFE='"+myForm.getShpHabLPCD()+"',SHP_NO_SAFE='"+myForm.getShpNo()+"',SHP_DK_SUPPLY='"+myForm.getShpHabUnsafeLPCD()+"',SHP_NO='"+myForm.getShpUnSafeNo()+"'  where HAB_CODE='"+myForm.getHabitation()+"'";
		statement.addBatch(query);
	}
	else{
		recCount++;
		query="update rws_hab_supply_status_tbl set SHP_DK_SUPPLY_SAFE='0',SHP_NO_SAFE='0',SHP_DK_SUPPLY='0',SHP_NO='0'  where HAB_CODE='"+myForm.getHabitation()+"'";
		statement.addBatch(query);
	}
	for (int i = 0; i < myForm.getShp().size(); i++) {
		recCount++;
		Rws_Habitation_Safe_Suplly_Form shpRecord = myForm.getShp().get(i);
		if(shpRecord.getFlouride().equals("--")){
			shpRecord.setFlouride("");
		}
		if(shpRecord.getBrakish().equals("--")){
			shpRecord.setBrakish("");
		}
		if(shpRecord.getIron().equals("--")){
			shpRecord.setIron("");
		}
		if(shpRecord.getNitrate().equals("--")){
			shpRecord.setNitrate("");
		}
		query="update RWS_SHALLOWHANDPUMPS_TBL set SAFE_LPD='"+shpRecord.getShpSafeLPCD()+"',UNSAFE_LPD='"+shpRecord.getShpUnSafeLPCD()+"',FLORIDE='"+shpRecord.getFlouride()+"',BRAKISH='"+shpRecord.getBrakish()+"',IRON='"+shpRecord.getIron()+"',NITRATE_PER='"+shpRecord.getNitrate()+"',STATUS='"+shpRecord.getSourceStatus()+"',PLATFORM_EXISTING='"+shpRecord.getPlatformExisting()+"',SOAK_PIT='"+shpRecord.getSoakPit()+"' where asset_code='"+shpRecord.getShpAssetCode()+"' and SHALLOWHP_CODE='"+shpRecord.getShpSourceCode()+"'";
		statement.addBatch(query);
		
		query="update rws_asset_hab_tbl set WATER_SUPP_FREQ='"+shpRecord.getWaterBeingSupplied()+"' where asset_code='"+shpRecord.getShpAssetCode()+"' and hab_code='"+myForm.getHabitation()+"'";
		statement.addBatch(query);
		recCount++;
	}
	
	if(myForm.getOthers().size()!=0 || myForm.getDps().size()!=0){
		recCount++;
		int safe=0,safeno=0,unsafe=0,unsafeno=0;
		if(myForm.getOthers().size()!=0){
			safe+=myForm.getOthersHabLPCD();
			 safeno+=myForm.getOthersNo();
			 unsafe+=myForm.getOthersHabUnsafeLPCD();
			 unsafeno+=myForm.getOthersUnSafeNo();
		}
		if(myForm.getDps().size()!=0){
			
			 safe+=myForm.getDpHabLPCD();
			 safeno+=myForm.getDpSafeNo();
			 unsafe+=myForm.getDpHabUnsafeLPCD();
			 unsafeno+=myForm.getDpUnSafeNo();
		
		}
		query="update rws_hab_supply_status_tbl set OTHERS_SUPPLY_SAFE='"+safe+"',OTHERS_NO_SAFE='"+safeno+"',OTHERS_SUPPLY='"+unsafe+"',OTHERS_NO='"+unsafeno+"'  where HAB_CODE='"+myForm.getHabitation()+"'";
		statement.addBatch(query);
	}
	else{
		recCount++;
		query="update rws_hab_supply_status_tbl set OTHERS_SUPPLY_SAFE='0',OTHERS_NO_SAFE='0',OTHERS_SUPPLY='0',OTHERS_NO='0'  where HAB_CODE='"+myForm.getHabitation()+"'";
		statement.addBatch(query);
	}
	for (int i = 0; i < myForm.getOthers().size(); i++) {
		recCount++;
		Rws_Habitation_Safe_Suplly_Form ohersRecord = myForm.getOthers().get(i);
		if(ohersRecord.getFlouride().equals("--")){
			ohersRecord.setFlouride("");
		}
		if(ohersRecord.getBrakish().equals("--")){
			ohersRecord.setBrakish("");
		}
		if(ohersRecord.getIron().equals("--")){
			ohersRecord.setIron("");
		}
		if(ohersRecord.getNitrate().equals("--")){
			ohersRecord.setNitrate(""); 
		}
		if(ohersRecord.getTableName().equals("source")){
			query="update rws_source_tbl set SAFE_LPD='"+ohersRecord.getOthersSafeLPCD()+"',UNSAFE_LPD='"+ohersRecord.getOthersUnSafeLPCD()+"',FLOURIDE='"+ohersRecord.getFlouride()+"',BRAKISH='"+ohersRecord.getBrakish()+"',IRON='"+ohersRecord.getIron()+"',NITRATE='"+ohersRecord.getNitrate()+"',STATUS='"+ohersRecord.getSourceStatus()+"',PLATFORM_EXISTING='"+ohersRecord.getPlatformExisting()+"',SOAK_PIT='"+ohersRecord.getSoakPit()+"' where asset_code='"+ohersRecord.getOthersAssetCode()+"' and source_code='"+ohersRecord.getOthersSourceCode()+"'";
			statement.addBatch(query);
			
			query="update rws_asset_hab_tbl set WATER_SUPP_FREQ='"+ohersRecord.getWaterBeingSupplied()+"' where asset_code='"+ohersRecord.getOthersAssetCode()+"' and hab_code='"+myForm.getHabitation()+"'";
			statement.addBatch(query);
			recCount++;
		}
		else if(ohersRecord.getTableName().equals("ow")){
			query="update RWS_OPEN_WELL_MAST_TBL set SAFE_LPD='"+ohersRecord.getOthersSafeLPCD()+"',UNSAFE_LPD='"+ohersRecord.getOthersUnSafeLPCD()+"',FLOURIDE_PER='"+ohersRecord.getFlouride()+"',BRAKISH_PER='"+ohersRecord.getBrakish()+"',IRON_PER='"+ohersRecord.getIron()+"',NITRATE='"+ohersRecord.getNitrate()+"',STATUS='"+ohersRecord.getSourceStatus()+"',PLATFORM_EXISTING='"+ohersRecord.getPlatformExisting()+"',SOAK_PIT='"+ohersRecord.getSoakPit()+"' where asset_code='"+ohersRecord.getOthersAssetCode()+"' and OPENWELL_CODE='"+ohersRecord.getOthersSourceCode()+"'";
			statement.addBatch(query);
			
			query="update rws_asset_hab_tbl set WATER_SUPP_FREQ='"+ohersRecord.getWaterBeingSupplied()+"' where asset_code='"+ohersRecord.getOthersAssetCode()+"' and hab_code='"+myForm.getHabitation()+"'";
			statement.addBatch(query);
			recCount++;
		}
		else if(ohersRecord.getTableName().equals("spring")){
			query="update  RWS_AST_OTHERS_PARAM_TBL set COLLECTION_TANK_CAPACITY='"+ohersRecord.getOthersSafeLPCD()+"',STATUS='"+ohersRecord.getSourceStatus()+"' where asset_code='"+ohersRecord.getOthersAssetCode()+"' and OTHER_COMP_CODE='"+ohersRecord.getOthersSourceCode()+"'";
			statement.addBatch(query);
			
			query="update rws_asset_hab_tbl set WATER_SUPP_FREQ='"+ohersRecord.getWaterBeingSupplied()+"' where asset_code='"+ohersRecord.getOthersAssetCode()+"' and hab_code='"+myForm.getHabitation()+"'";
			statement.addBatch(query);
			recCount++;
		}
	}
	int res[] = statement.executeBatch();
	if (res.length == recCount) {
		request.setAttribute("message", "Records Updated Successfully");
		connection.commit();
		connection.setAutoCommit(true);
	} else {
		connection.rollback();
		request.setAttribute("message", "Updation Failed");
	}	
	}
	catch(Exception e){
		request.setAttribute("message", "Updation Failed");
		System.out.println("Exception at saveSchemes in Rws_Habitation_Safe_Suplly_DAO"+e);
	}
	finally {
		try{
		if(connection!=null){
			connection.close();
		}
		}
		catch(Exception e){
			System.out.println("Exception at finally block of saveSchemes in Rws_Habitation_Safe_Suplly_DAO"+e);
		}
	}
	return null;
	
}
public void updateHabDir(Rws_Habitation_Safe_Suplly_Form myForm,
		HttpServletRequest request) {

	String query="";
	Connection connection=null;
	PreparedStatement preparedStatement=null;
	try{
		connection=RwsOffices.getConn();
		
		query="update rws_habitation_dir_dyna_tbl set GLSR_NO=?,GLSR_QTY=?,OHSR_NO=?,OHSR_QTY=?,NO_OF_TAPS_WITH_STANDPOSTS=? where hab_code=?";
		preparedStatement=connection.prepareStatement(query);
		preparedStatement.setInt(1, myForm.getGlsrNo());
		preparedStatement.setInt(2, myForm.getGlsrQty());
		preparedStatement.setInt(3, myForm.getOhsrNo());
		preparedStatement.setInt(4, myForm.getOhsrQty());
		preparedStatement.setInt(5, myForm.getStandPosts());
		preparedStatement.setString(6, myForm.getHabitation());
	int res = preparedStatement.executeUpdate();
	if (res>0) {
		request.setAttribute("message", "Records Updated Successfully");		
	} else {		
		request.setAttribute("message", "Updation Failed");
	}
	}
	catch(Exception e){
		System.out.println("Exception at updateHabDir in Rws_Habitation_Safe_Suplly_DAO"+e);
	}
	finally {
		try{
		if(connection!=null){
			connection.close();
		}
		}
		catch(Exception e){
			System.out.println("Exception at finally block of updateHabDir in Rws_Habitation_Safe_Suplly_DAO"+e);
		}
	}
		
}


public String savePlatFormsAndSoakPits(Rws_Habitation_Safe_Suplly_Form myForm,
		HttpServletRequest request) {
	String query="";
	Connection connection=null;
	Statement statement=null;
	int recCount=0;
	
	try{
		connection=RwsOffices.getConn();
		connection.setAutoCommit(false);
		statement=connection.createStatement();
		
		
	
	for (int i = 0; i < myForm.getHp().size(); i++) {
		recCount++;
		Rws_Habitation_Safe_Suplly_Form hpRecord = myForm.getHp().get(i);
		query="update RWS_HP_SUBCOMP_PARAM_TBL set PLATFORM_EXISTING='"+hpRecord.getPlatformExisting()+"',SOAK_PIT='"+hpRecord.getSoakPit()+"' where asset_code='"+hpRecord.getHpAssetCode()+"' and HP_CODE='"+hpRecord.getHpSourceCode()+"'";
		statement.addBatch(query);
	}
	
	for (int i = 0; i < myForm.getShp().size(); i++) {
		recCount++;
		Rws_Habitation_Safe_Suplly_Form shpRecord = myForm.getShp().get(i);
		query="update RWS_SHALLOWHANDPUMPS_TBL set PLATFORM_EXISTING='"+shpRecord.getPlatformExisting()+"',SOAK_PIT='"+shpRecord.getSoakPit()+"' where asset_code='"+shpRecord.getShpAssetCode()+"' and SHALLOWHP_CODE='"+shpRecord.getShpSourceCode()+"'";
		statement.addBatch(query);
	}
	
	for (int i = 0; i < myForm.getOthers().size(); i++) {
		
		Rws_Habitation_Safe_Suplly_Form ohersRecord = myForm.getOthers().get(i);
		if(ohersRecord.getTableName().equals("ow")){
			recCount++;
			query="update RWS_OPEN_WELL_MAST_TBL set PLATFORM_EXISTING='"+ohersRecord.getPlatformExisting()+"',SOAK_PIT='"+ohersRecord.getSoakPit()+"' where asset_code='"+ohersRecord.getOthersAssetCode()+"' and OPENWELL_CODE='"+ohersRecord.getOthersSourceCode()+"'";
			statement.addBatch(query);
		}
		
	}
	int res[] = statement.executeBatch();
	if (res.length == recCount) {
		request.setAttribute("message", "Records Updated Successfully");
		connection.commit();
		connection.setAutoCommit(true);
	} else {
		connection.rollback();
		request.setAttribute("message", "Updation Failed");
	}	
	}
	catch(Exception e){
		request.setAttribute("message", "Updation Failed");
		System.out.println("Exception at savePlatFormsAndSoakPits in Rws_Habitation_Safe_Suplly_DAO"+e);
	}
	finally {
		try{
		if(connection!=null){
			connection.close();
		}
		}
		catch(Exception e){
			System.out.println("Exception at finally block of savePlatFormsAndSoakPits in Rws_Habitation_Safe_Suplly_DAO"+e);
		}
	}
	return null;
	
}
public String getImageStatus(String astcode,String Sourcecode){
	
    String query="";String imgstatus="";
	Connection connection=null;
	PreparedStatement preparedStatement=null;
	ResultSet res=null;
	
	try{
		connection=RwsOffices.getConn();
		
		query="select COMPO_LAT,COMPO_LON,COMPO_IMAGE from RWS_ASSET_COMPONENT_IMAGE_TBL where ASSET_CODE=? and ASSET_COMPONENT=?";
		preparedStatement=connection.prepareStatement(query);
		preparedStatement.setString(1, astcode);
		preparedStatement.setString(2, Sourcecode);
	    res = preparedStatement.executeQuery();
	if (res.next()) {
		java.sql.Blob a=  res.getBlob("COMPO_IMAGE");
		 if(a==null){
         	imgstatus="No";
         }
         else
         {
       	  imgstatus="Yes";
         }
 	} 
	} 	catch(Exception e){
		System.out.println("Exception at getImageStatus in Rws_Habitation_Safe_Suplly_DAO"+e);
	}
	finally {
		try{
		if(connection!=null){
			connection.close();
		}
		}
		catch(Exception e){
			System.out.println("Exception at finally block of getImageStatus in Rws_Habitation_Safe_Suplly_DAO"+e);
		}
	}
	return imgstatus;
		
 }
public ArrayList getPpmValues(Rws_Habitation_Safe_Suplly_Form mForm,HttpSession session) {
	
	ArrayList arrayList=new  ArrayList();
	Connection connection=null;
	PreparedStatement preparedStatement=null;
	ResultSet resultSet=null;
	String query="";
	String habCode=mForm.getHabitation();
	try{
	connection=RwsOffices.getConn();
	query="select TESTING_PARAMETER_CODE,MAX_PERMISSIBLE_VALUE  from  RWS_WQ_PARA_TEST_TBL where TESTING_PARAMETER_CODE in (13,16,15,05)";
	preparedStatement=connection.prepareStatement(query);
	resultSet=preparedStatement.executeQuery();
	while(resultSet.next()){
		if(resultSet.getString("TESTING_PARAMETER_CODE").equals("13")){
			mForm.setFlouridePPM(resultSet.getString("MAX_PERMISSIBLE_VALUE").trim());
		}
		if(resultSet.getString("TESTING_PARAMETER_CODE").equals("16")){
			mForm.setIronPPM(resultSet.getString("MAX_PERMISSIBLE_VALUE").trim());
		}
		if(resultSet.getString("TESTING_PARAMETER_CODE").equals("15")){
			mForm.setNitratePPM(resultSet.getString("MAX_PERMISSIBLE_VALUE").trim());
		}
		if(resultSet.getString("TESTING_PARAMETER_CODE").equals("05")){
			mForm.setBrakishPPM(resultSet.getString("MAX_PERMISSIBLE_VALUE").trim());
		}
	}
	preparedStatement.close();
	resultSet.close();
	arrayList.add(mForm);
	}
	catch(Exception e){
		System.out.println("Exception at getPpmValues in Rws_Habitation_Safe_Suplly_DAO"+e);
	}
	finally {
		try{
		if(connection!=null){
			connection.close();
		}
		}
		catch(Exception e){
			System.out.println("Exception at finally block of getPpmValues in Rws_Habitation_Safe_Suplly_DAO"+e);
		}
	}
	return arrayList;
	
}
 }

