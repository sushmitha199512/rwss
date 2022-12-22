package nic.watersoft.wquality;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Vector;

import javax.sql.DataSource;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;

public class RWS_WQ_ContaminatedHabs_DAO

{
	public ArrayList getContaminatedDetailsCount(String dcode, String yearStart,
			String yearEnd,String financialYear) {
		
		Connection conn = null;
		ResultSet resultSet2=null,resultSet3=null,resultSet4=null,resultSet5=null;
		ResultSet resultSet6=null;
		PreparedStatement preparedStatement2=null,preparedStatement3=null,preparedStatement4=null,preparedStatement5=null;
		PreparedStatement preparedStatement6=null;
		ArrayList contaminatedDetails = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			Hashtable hashtable=new  Hashtable();
						
			RWS_WQ_ContaminatedHabs_FormBeam contaminatedHabs_FormBeam=new RWS_WQ_ContaminatedHabs_FormBeam();
			contaminatedHabs_FormBeam.setDcode(dcode);
			contaminatedHabs_FormBeam.setFinancialYear(financialYear);
						
			Statement stmt = conn.createStatement();
			String query="SELECT dname from rws_district_tbl where dcode='"+dcode+"'";
			ResultSet rs = stmt.executeQuery(query);
			if(rs.next())
			{
				contaminatedHabs_FormBeam.setDistrict(rs.getString(1));
			}
			String createView="CREATE OR REPLACE VIEW CONTAMINATIONDETAILS"+dcode+" AS "
					+ "SELECT DISTINCT SOURCE_CODE AS SOURCECODE, to_char(MAX(B.PREPARED_ON),'DD-MON-YYYY') AS PREPAREDON,A.TESTING_PARAMETER_CODE AS TCODE,A.TESTING_PARAMETER_VALUE AS TVALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B,RWS_WQ_PARA_TEST_TBL c WHERE A.TEST_ID =B.TEST_ID AND B.TEST_CODE='1' AND A.TESTING_PARAMETER_CODE =C.TESTING_PARAMETER_CODE AND A.TESTING_PARAMETER_CODE ='13' AND to_number(TRIM(TESTING_PARAMETER_VALUE))>to_number(TRIM(c.MAX_PERMISSIBLE_VALUE)) AND B.PREPARED_ON BETWEEN '"+yearStart+"' AND '"+yearEnd+"' AND SUBSTR(SOURCE_CODE ,1,2)='"+dcode+"' GROUP BY SOURCE_CODE,B.PREPARED_ON,A.TESTING_PARAMETER_CODE,TESTING_PARAMETER_VALUE"
					+ " UNION ALL "
					+ "SELECT DISTINCT SOURCE_CODE AS SOURCECODE,to_char(MAX(B.PREPARED_ON),'DD-MON-YYYY') AS PREPAREDON,A.TESTING_PARAMETER_CODE AS TCODE,A.TESTING_PARAMETER_VALUE AS TVALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B,RWS_WQ_PARA_TEST_TBL c WHERE A.TEST_ID =B.TEST_ID AND B.TEST_CODE='1' AND A.TESTING_PARAMETER_CODE =C.TESTING_PARAMETER_CODE AND A.TESTING_PARAMETER_CODE ='05' AND to_number(TRIM(TESTING_PARAMETER_VALUE))>to_number(TRIM(c.MAX_PERMISSIBLE_VALUE)) AND B.PREPARED_ON BETWEEN '"+yearStart+"' AND '"+yearEnd+"' AND SUBSTR(SOURCE_CODE ,1,2)='"+dcode+"' GROUP BY SOURCE_CODE,B.PREPARED_ON,A.TESTING_PARAMETER_CODE,TESTING_PARAMETER_VALUE"
					+ " UNION ALL "
					+ "SELECT DISTINCT SOURCE_CODE AS SOURCECODE,to_char(MAX(B.PREPARED_ON),'DD-MON-YYYY') AS PREPAREDON,A.TESTING_PARAMETER_CODE AS TCODE,A.TESTING_PARAMETER_VALUE AS TVALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B,RWS_WQ_PARA_TEST_TBL c WHERE A.TEST_ID =B.TEST_ID AND B.TEST_CODE='1' AND A.TESTING_PARAMETER_CODE =C.TESTING_PARAMETER_CODE AND A.TESTING_PARAMETER_CODE ='16' AND to_number(TRIM(TESTING_PARAMETER_VALUE))>to_number(TRIM(c.MAX_PERMISSIBLE_VALUE)) AND B.PREPARED_ON BETWEEN '"+yearStart+"' AND '"+yearEnd+"' AND SUBSTR(SOURCE_CODE ,1,2)='"+dcode+"' GROUP BY SOURCE_CODE,B.PREPARED_ON,A.TESTING_PARAMETER_CODE,TESTING_PARAMETER_VALUE"
					+ " UNION ALL "
					+ "SELECT DISTINCT SOURCE_CODE AS SOURCECODE,to_char(MAX(B.PREPARED_ON),'DD-MON-YYYY') AS PREPAREDON,A.TESTING_PARAMETER_CODE AS TCODE,A.TESTING_PARAMETER_VALUE AS TVALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B,RWS_WQ_PARA_TEST_TBL c WHERE A.TEST_ID =B.TEST_ID AND B.TEST_CODE='1' AND A.TESTING_PARAMETER_CODE =C.TESTING_PARAMETER_CODE AND A.TESTING_PARAMETER_CODE ='12' AND (0.03+((1.806*TESTING_PARAMETER_VALUE)/1000)>to_number(TRIM(c.MAX_PERMISSIBLE_VALUE))) AND B.PREPARED_ON BETWEEN '"+yearStart+"' AND '"+yearEnd+"' AND SUBSTR(SOURCE_CODE ,1,2)='"+dcode+"' GROUP BY SOURCE_CODE,B.PREPARED_ON,A.TESTING_PARAMETER_CODE,TESTING_PARAMETER_VALUE"
					+ " UNION ALL "
					+ "SELECT DISTINCT SOURCE_CODE AS SOURCECODE,to_char(MAX(B.PREPARED_ON),'DD-MON-YYYY') AS PREPAREDON,A.TESTING_PARAMETER_CODE AS TCODE,A.TESTING_PARAMETER_VALUE AS TVALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B,RWS_WQ_PARA_TEST_TBL c WHERE A.TEST_ID =B.TEST_ID AND B.TEST_CODE='1' AND A.TESTING_PARAMETER_CODE =C.TESTING_PARAMETER_CODE AND A.TESTING_PARAMETER_CODE ='15' AND to_number(TRIM(TESTING_PARAMETER_VALUE))>to_number(TRIM(c.MAX_PERMISSIBLE_VALUE)) AND B.PREPARED_ON BETWEEN '"+yearStart+"' AND '"+yearEnd+"' AND SUBSTR(SOURCE_CODE ,1,2)='"+dcode+"' GROUP BY SOURCE_CODE,B.PREPARED_ON,A.TESTING_PARAMETER_CODE,TESTING_PARAMETER_VALUE";
			
			System.out.println("createViewQuery -----"+createView);
			
			Statement statement=conn.createStatement();
			statement.executeUpdate(createView);
			
			String distinctHabquery="SELECT COUNT(DISTINCT SUBSTR(SOURCECODE,1,16)) FROM CONTAMINATIONDETAILS"+dcode+"";
			Statement statement11=conn.createStatement();
			ResultSet set1=statement11.executeQuery(distinctHabquery);
			if(set1.next()){
				contaminatedHabs_FormBeam.setContaminatedHabs(set1.getInt(1));
			}
			statement11.close();	
			set1.close();
			
			String viewquery="SELECT COUNT(DISTINCT SOURCECODE) FROM CONTAMINATIONDETAILS"+dcode+"";
			Statement statement1=conn.createStatement();
			ResultSet set=statement1.executeQuery(viewquery);
			if(set.next()){
				contaminatedHabs_FormBeam.setContaminatedSources(set.getInt(1));
			}
			statement1.close();	
			set.close();				
			
			String tdsQuery1="SELECT COUNT(DISTINCT SOURCECODE) FROM CONTAMINATIONDETAILS"+dcode+" a,RWS_WQ_PARA_TEST_TBL b WHERE TCODE ='05' AND a.TCODE =b.TESTING_PARAMETER_CODE AND to_number(TRIM(TVALUE))>to_number(TRIM(b.MAX_PERMISSIBLE_VALUE))";
			System.out.println("tdsQuery1 -----"+tdsQuery1);
			preparedStatement6=conn.prepareStatement(tdsQuery1);
			resultSet6=preparedStatement6.executeQuery();	
			if(resultSet6.next()){
				contaminatedHabs_FormBeam.setTds(resultSet6.getInt(1));
				
			}
			preparedStatement6.close();
			resultSet6.close();
			
			
			String florideQuery="SELECT COUNT(DISTINCT SOURCECODE) FROM CONTAMINATIONDETAILS"+dcode+" a,RWS_WQ_PARA_TEST_TBL b WHERE TCODE ='13' AND a.TCODE =b.TESTING_PARAMETER_CODE AND to_number(TRIM(TVALUE))>to_number(TRIM(b.MAX_PERMISSIBLE_VALUE))";
			System.out.println("florideQuery -----"+florideQuery);
			preparedStatement2=conn.prepareStatement(florideQuery);
			resultSet2=preparedStatement2.executeQuery();	
			if(resultSet2.next()){
				contaminatedHabs_FormBeam.setFloride(resultSet2.getInt(1));
			}
			preparedStatement2.close();
			resultSet2.close();
			
			String ironQuery="SELECT COUNT(DISTINCT SOURCECODE) FROM CONTAMINATIONDETAILS"+dcode+" a,RWS_WQ_PARA_TEST_TBL b WHERE TCODE ='16' AND a.TCODE =b.TESTING_PARAMETER_CODE  AND to_number(TRIM(TVALUE))>to_number(TRIM(b.MAX_PERMISSIBLE_VALUE))";
			System.out.println("ironQuery -----"+ironQuery);
			preparedStatement3=conn.prepareStatement(ironQuery);
			resultSet3=preparedStatement3.executeQuery();	
			if(resultSet3.next()){
				contaminatedHabs_FormBeam.setIron(resultSet3.getInt(1));
				
				}
			preparedStatement3.close();
			resultSet3.close();
			
			String selinityQuery="SELECT COUNT(DISTINCT SOURCECODE) FROM CONTAMINATIONDETAILS"+dcode+" a,RWS_WQ_PARA_TEST_TBL b WHERE TCODE ='12' AND a.TCODE =b.TESTING_PARAMETER_CODE AND (0.03+((1.806*TVALUE)/1000)>to_number(TRIM(b.MAX_PERMISSIBLE_VALUE)))";
			System.out.println("selinityQuery -----"+selinityQuery);
			preparedStatement4=conn.prepareStatement(selinityQuery);
			resultSet4=preparedStatement4.executeQuery();	
			if(resultSet4.next()){
				contaminatedHabs_FormBeam.setSelinity(resultSet4.getInt(1));
				
			}
			preparedStatement4.close();
			resultSet4.close();
			
			
			String nitrateQuery="SELECT COUNT(DISTINCT SOURCECODE) FROM CONTAMINATIONDETAILS"+dcode+" a,RWS_WQ_PARA_TEST_TBL b WHERE TCODE ='15' AND a.TCODE =b.TESTING_PARAMETER_CODE AND to_number(TRIM(TVALUE))>to_number(TRIM(b.MAX_PERMISSIBLE_VALUE))";
			System.out.println("nitrateQuery -----"+nitrateQuery);
			preparedStatement5=conn.prepareStatement(nitrateQuery);
			resultSet5=preparedStatement5.executeQuery();	
			if(resultSet5.next()){
				contaminatedHabs_FormBeam.setNitrate(resultSet5.getInt(1));
				
				}
			preparedStatement5.close();
			resultSet5.close();
			contaminatedDetails.add(contaminatedHabs_FormBeam);		
		}

		catch (SQLException e) {
			e.printStackTrace();
		}
		// TODO Auto-generated method stub

		finally{
			if(conn!=null){
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return contaminatedDetails;

	}

	public ArrayList getContaminatedHabDetails(String dcode, String yearStart,
			String yearEnd,String financialYear) {
		
		Connection conn = null;
		ResultSet rs3=null;
		Statement stmt3=null;
		
		ArrayList contaminatedDetails = new ArrayList();
		Hashtable hashtable=new Hashtable();
		try {
			conn = RwsOffices.getConn();
			
			
			String viewquery="SELECT DISTINCT SUBSTR(SOURCECODE,1,16) FROM CONTAMINATIONDETAILS"+dcode+" group by SOURCECODE";
			
			Statement statement1=conn.createStatement();
			ResultSet set=statement1.executeQuery(viewquery);
			
			while(set.next()){
				
				RWS_WQ_ContaminatedHabs_FormBeam contaminatedHabs_FormBeam=new RWS_WQ_ContaminatedHabs_FormBeam();
				contaminatedHabs_FormBeam.setDcode(dcode);
				contaminatedHabs_FormBeam.setFinancialYear(financialYear);
				
				String habCode = set.getString(1);
				contaminatedHabs_FormBeam.setHabCode(habCode);
				String query="select dname,mname,pname,vname,panch_name,dcode,panch_code from rws_complete_hab_view  where panch_code='"+habCode+"'";
			 stmt3=conn.createStatement();
			rs3 = stmt3.executeQuery(query);
			
		if(rs3.next()){
			contaminatedHabs_FormBeam.setDistrictName(rs3.getString(1));
			contaminatedHabs_FormBeam.setMandal(rs3.getString(2));
			contaminatedHabs_FormBeam.setPanchayat(rs3.getString(3));
			contaminatedHabs_FormBeam.setVillage(rs3.getString(4));
			contaminatedHabs_FormBeam.setHabName(rs3.getString(5));
			
			contaminatedDetails.add(contaminatedHabs_FormBeam);
			}
			stmt3.close();
			rs3.close();
			
			}
			statement1.close();
			set.close();
			
		
		}
		

		catch (Exception e) {
			e.printStackTrace();
		}
		// TODO Auto-generated method stub
		finally{
			if(conn!=null){
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return contaminatedDetails;

	}
	
	public ArrayList getContaminatedHabsList(String dcode, String yearStart,
			String yearEnd,String financialYear) {
		
		Connection conn = null;
		ResultSet rs3=null,resultSet2=null,resultSet3=null,resultSet4=null,resultSet5=null;
		ResultSet resultSet6=null;
		Statement stmt3=null;
		PreparedStatement preparedStatement2=null,preparedStatement3=null,preparedStatement4=null,preparedStatement5=null;
		PreparedStatement preparedStatement6=null;
		ArrayList contaminatedDetails = new ArrayList();
		Hashtable hashtable=new Hashtable();
		try {
			conn = RwsOffices.getConn();
			
			
			String viewquery="SELECT DISTINCT SOURCECODE,PREPAREDON FROM CONTAMINATIONDETAILS"+dcode+" group by SOURCECODE,PREPAREDON";
			
			Statement statement1=conn.createStatement();
			ResultSet set=statement1.executeQuery(viewquery);
			
			while(set.next()){
				hashtable.put(set.getString(1), set.getString(2));
			}
			statement1.close();
			set.close();
			
			int size=hashtable.size();
			System.out.println("size of hash table is--------------"+size);
			 Vector v = new Vector(hashtable.keySet());
			    Collections.sort(v);
			  Iterator  it = v.iterator();
			while(it.hasNext()){
				RWS_WQ_ContaminatedHabs_FormBeam contaminatedHabs_FormBeam=new RWS_WQ_ContaminatedHabs_FormBeam();
				contaminatedHabs_FormBeam.setDcode(dcode);
				contaminatedHabs_FormBeam.setFinancialYear(financialYear);
				
				String element =  (String)it.next();
				String sourceCode = element;
				String preparedOn = (String)hashtable.get(element); 
				
				contaminatedHabs_FormBeam.setPreparedOn(preparedOn);
				
				String sName=this.getSourceName(sourceCode);
				contaminatedHabs_FormBeam.setSourceName(sName);
				contaminatedHabs_FormBeam.setSourceCode(sourceCode);
				String query="select dname,mname,pname,vname,panch_name,dcode,panch_code from rws_complete_hab_view  where panch_code=SUBSTR('"+sourceCode+"',1,16)";
			 stmt3=conn.createStatement();
			rs3 = stmt3.executeQuery(query);
			
		if(rs3.next()){
			contaminatedHabs_FormBeam.setDistrictName(rs3.getString(1));
			contaminatedHabs_FormBeam.setMandal(rs3.getString(2));
			contaminatedHabs_FormBeam.setPanchayat(rs3.getString(3));
			contaminatedHabs_FormBeam.setVillage(rs3.getString(4));
			contaminatedHabs_FormBeam.setHabName(rs3.getString(5));
			contaminatedHabs_FormBeam.setHabCode(rs3.getString(7));
			
			String tds1="--";
			String flouride1="--";
			String iron1="--";
			String selinity1="--";
			String nitrate1="--";
				
				String tdsQuery1="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B,RWS_WQ_PARA_TEST_TBL c WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE =C.TESTING_PARAMETER_CODE AND A.TESTING_PARAMETER_CODE ='05' AND to_number(TRIM(TESTING_PARAMETER_VALUE))>to_number(TRIM(c.MAX_PERMISSIBLE_VALUE)) AND SOURCE_CODE=? AND B.PREPARED_ON=? GROUP BY TESTING_PARAMETER_VALUE";
			preparedStatement6=conn.prepareStatement(tdsQuery1);
			preparedStatement6.setString(1, sourceCode);
			preparedStatement6.setString(2, preparedOn);
			resultSet6=preparedStatement6.executeQuery();
			System.out.println("tdsQuery1"+tdsQuery1+sourceCode+preparedOn);
			if(resultSet6.next()){
				tds1=resultSet6.getString(1);
				
			}
			contaminatedHabs_FormBeam.setTds1(tds1);
			preparedStatement6.close();
			resultSet6.close();
			
			
			String florideQuery="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B,RWS_WQ_PARA_TEST_TBL c WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE =C.TESTING_PARAMETER_CODE AND A.TESTING_PARAMETER_CODE ='13' AND to_number(TRIM(TESTING_PARAMETER_VALUE))>to_number(TRIM(c.MAX_PERMISSIBLE_VALUE)) AND SOURCE_CODE=? AND B.PREPARED_ON=? GROUP BY TESTING_PARAMETER_VALUE";
			preparedStatement2=conn.prepareStatement(florideQuery);
			preparedStatement2.setString(1, sourceCode);
			preparedStatement2.setString(2, preparedOn);
			resultSet2=preparedStatement2.executeQuery();
			//System.out.println("florideQuery"+florideQuery);
			if(resultSet2.next()){
				flouride1=resultSet2.getString(1);
			}
			contaminatedHabs_FormBeam.setFloride1(flouride1);
			preparedStatement2.close();
			resultSet2.close();
			
			String ironQuery="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B,RWS_WQ_PARA_TEST_TBL c WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE =C.TESTING_PARAMETER_CODE AND A.TESTING_PARAMETER_CODE ='16' AND to_number(TRIM(TESTING_PARAMETER_VALUE))>to_number(TRIM(c.MAX_PERMISSIBLE_VALUE)) AND SOURCE_CODE=? AND B.PREPARED_ON=? GROUP BY TESTING_PARAMETER_VALUE";
			preparedStatement3=conn.prepareStatement(ironQuery);
			preparedStatement3.setString(1, sourceCode);
			preparedStatement3.setString(2, preparedOn);
			resultSet3=preparedStatement3.executeQuery();
			//System.out.println("ironQuery"+ironQuery);
			if(resultSet3.next()){
				
				iron1=resultSet3.getString(1);
				}
			contaminatedHabs_FormBeam.setIron1(iron1);
			preparedStatement3.close();
			resultSet3.close();
			
			String selinityQuery="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B,RWS_WQ_PARA_TEST_TBL c WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE =C.TESTING_PARAMETER_CODE AND A.TESTING_PARAMETER_CODE ='12' AND (0.03+((1.806*TESTING_PARAMETER_VALUE)/1000)>to_number(TRIM(c.MAX_PERMISSIBLE_VALUE))) AND SOURCE_CODE=? AND B.PREPARED_ON=? GROUP BY TESTING_PARAMETER_VALUE";
			preparedStatement4=conn.prepareStatement(selinityQuery);
			preparedStatement4.setString(1, sourceCode);
			preparedStatement4.setString(2, preparedOn);
			resultSet4=preparedStatement4.executeQuery();	
			//System.out.println("selinityQuery"+selinityQuery);
			if(resultSet4.next()){
				selinity1=resultSet4.getString(1);
				
			}
			contaminatedHabs_FormBeam.setSelinity1(selinity1);
			preparedStatement4.close();
			resultSet4.close();
			
			
			String nitrateQuery="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B,RWS_WQ_PARA_TEST_TBL c WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE =C.TESTING_PARAMETER_CODE AND A.TESTING_PARAMETER_CODE ='15' AND to_number(TRIM(TESTING_PARAMETER_VALUE))>to_number(TRIM(c.MAX_PERMISSIBLE_VALUE)) AND  SOURCE_CODE=? AND B.PREPARED_ON=? GROUP BY TESTING_PARAMETER_VALUE";
			preparedStatement5=conn.prepareStatement(nitrateQuery);
			preparedStatement5.setString(1, sourceCode);
			preparedStatement5.setString(2, preparedOn);
			resultSet5=preparedStatement5.executeQuery();	
			//System.out.println("nitrateQuery"+nitrateQuery);
			if(resultSet5.next()){
				
				nitrate1=resultSet5.getString(1);
				}
			contaminatedHabs_FormBeam.setNitrate1(nitrate1);
			preparedStatement5.close();
			resultSet5.close();
			contaminatedDetails.add(contaminatedHabs_FormBeam);
			}
			stmt3.close();
			rs3.close();
			
			}
			
		}
		

		catch (SQLException e) {
			e.printStackTrace();
		}
		// TODO Auto-generated method stub
		finally{
			if(conn!=null){
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		return contaminatedDetails;

	}
	

	public ArrayList getContaminatedTdsHabsList(String dcode, String yearStart,
			String yearEnd,String financialYear) {
		
		Connection conn = null;
		ResultSet resultSet=null,resultSet1=null,resultSet2=null,resultSet3=null,resultSet4=null,resultSet5=null,resultSet6=null;
		PreparedStatement preparedStatement=null, preparedStatement1=null,preparedStatement2=null,preparedStatement3=null,preparedStatement4=null,preparedStatement5=null,preparedStatement6=null;
		Statement stmt3=null;
		ArrayList contaminatedDetails = new ArrayList();
		Hashtable hashtable=new Hashtable();
		try {
			conn = RwsOffices.getConn();
			
			
			String viewquery="SELECT DISTINCT SOURCECODE,PREPAREDON,TVALUE FROM CONTAMINATIONDETAILS"+dcode+" A,RWS_WQ_PARA_TEST_TBL C WHERE TCODE ='05' AND A.TCODE =C.TESTING_PARAMETER_CODE AND to_number(TRIM(TVALUE))>to_number(TRIM(c.MAX_PERMISSIBLE_VALUE)) group by SOURCECODE,PREPAREDON,TVALUE";
			Statement statement1=conn.createStatement();
			ResultSet set=statement1.executeQuery(viewquery);
			
			while(set.next()){
				hashtable.put(set.getString(1), set.getString(2)+"@"+set.getString(3));
			}
			statement1.close();
			set.close();
		
			int size=hashtable.size();
			System.out.println("size of hash table is--------------"+size);
			 Vector v = new Vector(hashtable.keySet());
			    Collections.sort(v);
			  Iterator  it = v.iterator();
			while(it.hasNext()){
				RWS_WQ_ContaminatedHabs_FormBeam contaminatedHabs_FormBeam=new RWS_WQ_ContaminatedHabs_FormBeam();
				contaminatedHabs_FormBeam.setDcode(dcode);
				contaminatedHabs_FormBeam.setFinancialYear(financialYear);
				
				String element =  (String)it.next();
				String sourceCode = element;
				String value = (String)hashtable.get(element); 
				String ar[]=value.split("@");
				String preparedOn =ar[0];
				String TDS =ar[1];
				
				contaminatedHabs_FormBeam.setPreparedOn(preparedOn);
				contaminatedHabs_FormBeam.setTds1(TDS);
				String sName=this.getSourceName(sourceCode);
				contaminatedHabs_FormBeam.setSourceName(sName);
				contaminatedHabs_FormBeam.setSourceCode(sourceCode);
				String query="select dname,mname,pname,vname,panch_name,dcode,panch_code from rws_complete_hab_view  where panch_code=SUBSTR('"+sourceCode+"',1,16)";
			 stmt3=conn.createStatement();
			ResultSet rs3 = stmt3.executeQuery(query);
			
		if(rs3.next()){
			contaminatedHabs_FormBeam.setDistrictName(rs3.getString(1));
			contaminatedHabs_FormBeam.setMandal(rs3.getString(2));
			contaminatedHabs_FormBeam.setPanchayat(rs3.getString(3));
			contaminatedHabs_FormBeam.setVillage(rs3.getString(4));
			contaminatedHabs_FormBeam.setHabName(rs3.getString(5));
			contaminatedHabs_FormBeam.setHabCode(rs3.getString(7));
			
			
			String flouride1="--";
			String iron1="--";
			String selinity1="--";
			String nitrate1="--";
			
			String labQuery="select LAB_NAME from RWS_WQ_TEST_RESULTS_TBL a,RWS_WATER_QUALITY_LAB_TBL b where a.lab_code=b.lab_code and source_code='"+sourceCode+"' and PREPARED_ON='"+preparedOn+"'";
			Statement statement=conn.createStatement();
			ResultSet rs=statement.executeQuery(labQuery);
			if(rs.next()){
				contaminatedHabs_FormBeam.setLabName(rs.getString(1));
			}
			statement.close();
			rs.close();
			
			String florideQuery="SELECT COUNT(DISTINCT SUBSTR(B.SOURCE_CODE,1,16)),TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='13' AND SOURCE_CODE=? AND PREPARED_ON=? GROUP BY TESTING_PARAMETER_VALUE";
			//System.out.println("florideQuery----"+florideQuery);
			preparedStatement3=conn.prepareStatement(florideQuery);
			preparedStatement3.setString(1, sourceCode);
			preparedStatement3.setString(2, preparedOn);
			
			resultSet3=preparedStatement3.executeQuery();	
			if(resultSet3.next()){
				flouride1=resultSet3.getString(2);
				
				}
			contaminatedHabs_FormBeam.setFloride1(flouride1);
			preparedStatement3.close();
			resultSet3.close();
			
			String ironQuery="SELECT COUNT(DISTINCT SUBSTR(B.SOURCE_CODE,1,16)),TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='16' AND SOURCE_CODE=? AND PREPARED_ON=? GROUP BY TESTING_PARAMETER_VALUE";
			//System.out.println("ironQuery----"+ironQuery);
			preparedStatement3=conn.prepareStatement(ironQuery);
			preparedStatement3.setString(1, sourceCode);
			preparedStatement3.setString(2, preparedOn);
			
			resultSet3=preparedStatement3.executeQuery();
			if(resultSet3.next()){
				iron1=resultSet3.getString(2);
				
				}
			contaminatedHabs_FormBeam.setIron1(iron1);
			preparedStatement3.close();
			resultSet3.close();
			
			
			
			String selinityQuery="SELECT COUNT(DISTINCT SUBSTR(B.SOURCE_CODE,1,16)),TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='12' AND SOURCE_CODE=?  AND PREPARED_ON=? GROUP BY TESTING_PARAMETER_VALUE";
			preparedStatement4=conn.prepareStatement(selinityQuery);
			preparedStatement4.setString(1, sourceCode);
			preparedStatement4.setString(2, preparedOn);
			
			resultSet4=preparedStatement4.executeQuery();	
			if(resultSet4.next()){
				selinity1=resultSet4.getString(2);
				
			}
			contaminatedHabs_FormBeam.setSelinity1(selinity1);
			preparedStatement4.close();
			resultSet4.close();
			
			
			String nitrateQuery="SELECT COUNT(DISTINCT SUBSTR(B.SOURCE_CODE,1,16)),TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='15' AND SOURCE_CODE=? AND PREPARED_ON=? GROUP BY TESTING_PARAMETER_VALUE";
			preparedStatement5=conn.prepareStatement(nitrateQuery);
			preparedStatement5.setString(1, sourceCode);
			preparedStatement5.setString(2, preparedOn);
			
			resultSet5=preparedStatement5.executeQuery();	
			if(resultSet5.next()){
				nitrate1=resultSet5.getString(2);
				
				}
			contaminatedHabs_FormBeam.setNitrate1(nitrate1);
			preparedStatement5.close();
			resultSet5.close();
			
			contaminatedDetails.add(contaminatedHabs_FormBeam);
		}
		stmt3.close();
		rs3.close();
		
		}
		
	
	}
	

	catch (SQLException e) {
		e.printStackTrace();
	}
	// TODO Auto-generated method stub
		finally{
			if(conn!=null){
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

	return contaminatedDetails;

	}
	public ArrayList getContaminatedFlourideHabsList(String dcode, String yearStart,
			String yearEnd,String financialYear) {
		
		
		Connection conn = null;
		ResultSet resultSet=null,resultSet1=null,resultSet2=null,resultSet3=null,resultSet4=null,resultSet5=null,resultSet6=null;
		PreparedStatement preparedStatement=null, preparedStatement1=null,preparedStatement2=null,preparedStatement3=null,preparedStatement4=null,preparedStatement5=null,preparedStatement6=null;
		Statement stmt3=null;
		ArrayList contaminatedDetails = new ArrayList();
		Hashtable hashtable=new Hashtable();
		try {
			conn = RwsOffices.getConn();
			
			
			String viewquery="SELECT DISTINCT SOURCECODE,PREPAREDON,TVALUE FROM CONTAMINATIONDETAILS"+dcode+" A,RWS_WQ_PARA_TEST_TBL C WHERE TCODE ='13' AND A.TCODE =C.TESTING_PARAMETER_CODE AND to_number(TRIM(TVALUE))>to_number(TRIM(c.MAX_PERMISSIBLE_VALUE))  group by SOURCECODE,PREPAREDON,TVALUE";
			Statement statement1=conn.createStatement();
			ResultSet set=statement1.executeQuery(viewquery);
			
			while(set.next()){
				hashtable.put(set.getString(1), set.getString(2)+"@"+set.getString(3));
			}
			statement1.close();
			set.close();
			
			int size=hashtable.size();
			System.out.println("size of hash table is--------------"+size);
			 Vector v = new Vector(hashtable.keySet());
			    Collections.sort(v);
			  Iterator  it = v.iterator();
			while(it.hasNext()){
				RWS_WQ_ContaminatedHabs_FormBeam contaminatedHabs_FormBeam=new RWS_WQ_ContaminatedHabs_FormBeam();
				contaminatedHabs_FormBeam.setDcode(dcode);
				contaminatedHabs_FormBeam.setFinancialYear(financialYear);
				
				String element =  (String)it.next();
				String sourceCode = element;
				String value = (String)hashtable.get(element); 
				String ar[]=value.split("@");
				String preparedOn =ar[0];
				String FLOURIDE =ar[1];
				
				contaminatedHabs_FormBeam.setPreparedOn(preparedOn);
				contaminatedHabs_FormBeam.setFloride1(FLOURIDE);
				String sName=this.getSourceName(sourceCode);
				contaminatedHabs_FormBeam.setSourceName(sName);
				contaminatedHabs_FormBeam.setSourceCode(sourceCode);
				String query="select dname,mname,pname,vname,panch_name,dcode,panch_code from rws_complete_hab_view  where panch_code=SUBSTR('"+sourceCode+"',1,16)";
			 stmt3=conn.createStatement();
			ResultSet rs3 = stmt3.executeQuery(query);
			
		if(rs3.next()){
			contaminatedHabs_FormBeam.setDistrictName(rs3.getString(1));
			contaminatedHabs_FormBeam.setMandal(rs3.getString(2));
			contaminatedHabs_FormBeam.setPanchayat(rs3.getString(3));
			contaminatedHabs_FormBeam.setVillage(rs3.getString(4));
			contaminatedHabs_FormBeam.setHabName(rs3.getString(5));
			contaminatedHabs_FormBeam.setHabCode(rs3.getString(7));
			
			
			String tds1="--";
			String iron1="--";
			String selinity1="--";
			String nitrate1="--";
			
			String labQuery="select LAB_NAME from RWS_WQ_TEST_RESULTS_TBL a,RWS_WATER_QUALITY_LAB_TBL b where a.lab_code=b.lab_code and source_code='"+sourceCode+"' and PREPARED_ON='"+preparedOn+"'";
			Statement statement=conn.createStatement();
			ResultSet rs=statement.executeQuery(labQuery);
			if(rs.next()){
				contaminatedHabs_FormBeam.setLabName(rs.getString(1));
			}
			statement.close();
			rs.close();
			
			String tdsQuery="SELECT COUNT(DISTINCT SUBSTR(B.SOURCE_CODE,1,16)),TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='05' AND SOURCE_CODE=? AND PREPARED_ON=? GROUP BY TESTING_PARAMETER_VALUE";
			//System.out.println("florideQuery----"+florideQuery);
			preparedStatement3=conn.prepareStatement(tdsQuery);
			preparedStatement3.setString(1, sourceCode);
			preparedStatement3.setString(2, preparedOn);
			
			resultSet3=preparedStatement3.executeQuery();	
			if(resultSet3.next()){
				tds1=resultSet3.getString(2);
				
				}
			contaminatedHabs_FormBeam.setTds1(tds1);
			preparedStatement3.close();
			resultSet3.close();
			
			String ironQuery="SELECT COUNT(DISTINCT SUBSTR(B.SOURCE_CODE,1,16)),TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='16' AND SOURCE_CODE=? AND PREPARED_ON=? GROUP BY TESTING_PARAMETER_VALUE";
			//System.out.println("ironQuery----"+ironQuery);
			preparedStatement3=conn.prepareStatement(ironQuery);
			preparedStatement3.setString(1, sourceCode);
			preparedStatement3.setString(2, preparedOn);
			
			resultSet3=preparedStatement3.executeQuery();
			if(resultSet3.next()){
				iron1=resultSet3.getString(2);
				
				}
			contaminatedHabs_FormBeam.setIron1(iron1);
			preparedStatement3.close();
			resultSet3.close();
			
			
			
			String selinityQuery="SELECT COUNT(DISTINCT SUBSTR(B.SOURCE_CODE,1,16)),TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='12' AND SOURCE_CODE=?  AND PREPARED_ON=? GROUP BY TESTING_PARAMETER_VALUE";
			preparedStatement4=conn.prepareStatement(selinityQuery);
			preparedStatement4.setString(1, sourceCode);
			preparedStatement4.setString(2, preparedOn);
			
			resultSet4=preparedStatement4.executeQuery();	
			if(resultSet4.next()){
				selinity1=resultSet4.getString(2);
				
			}
			contaminatedHabs_FormBeam.setSelinity1(selinity1);
			preparedStatement4.close();
			resultSet4.close();
			
			
			String nitrateQuery="SELECT COUNT(DISTINCT SUBSTR(B.SOURCE_CODE,1,16)),TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='15' AND SOURCE_CODE=? AND PREPARED_ON=? GROUP BY TESTING_PARAMETER_VALUE";
			preparedStatement5=conn.prepareStatement(nitrateQuery);
			preparedStatement5.setString(1, sourceCode);
			preparedStatement5.setString(2, preparedOn);
			
			resultSet5=preparedStatement5.executeQuery();	
			if(resultSet5.next()){
				nitrate1=resultSet5.getString(2);
				contaminatedHabs_FormBeam.setNitrate1(nitrate1);
				}
			preparedStatement5.close();
			resultSet5.close();
			
			contaminatedDetails.add(contaminatedHabs_FormBeam);
		}
		stmt3.close();
		rs3.close();
		
		}
		
	}
	

	catch (SQLException e) {
		e.printStackTrace();
	}
	// TODO Auto-generated method stub
		finally{
			if(conn!=null){
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	return contaminatedDetails;

	

	}
		
	
	public ArrayList getContaminatedIronHabsList(String dcode, String yearStart,
			String yearEnd,String financialYear) {
		
		Connection conn = null;
		ResultSet resultSet=null,resultSet1=null,resultSet2=null,resultSet3=null,resultSet4=null,resultSet5=null,resultSet6=null;
		PreparedStatement preparedStatement=null, preparedStatement1=null,preparedStatement2=null,preparedStatement3=null,preparedStatement4=null,preparedStatement5=null,preparedStatement6=null;
		Statement stmt3=null;
		ArrayList contaminatedDetails = new ArrayList();
		Hashtable hashtable=new Hashtable();
		try {
			conn = RwsOffices.getConn();
			
			
			String viewquery="SELECT DISTINCT SOURCECODE,PREPAREDON,TVALUE FROM CONTAMINATIONDETAILS"+dcode+" A,RWS_WQ_PARA_TEST_TBL C WHERE TCODE ='16' AND A.TCODE =C.TESTING_PARAMETER_CODE AND to_number(TRIM(TVALUE))>to_number(TRIM(c.MAX_PERMISSIBLE_VALUE))  group by SOURCECODE,PREPAREDON,TVALUE";
			Statement statement1=conn.createStatement();
			ResultSet set=statement1.executeQuery(viewquery);
			
			while(set.next()){
				hashtable.put(set.getString(1), set.getString(2)+"@"+set.getString(3));
			}
			statement1.close();
			set.close();
			
			int size=hashtable.size();
			System.out.println("size of hash table is--------------"+size);
			 Vector v = new Vector(hashtable.keySet());
			    Collections.sort(v);
			  Iterator  it = v.iterator();
			while(it.hasNext()){
				RWS_WQ_ContaminatedHabs_FormBeam contaminatedHabs_FormBeam=new RWS_WQ_ContaminatedHabs_FormBeam();
				contaminatedHabs_FormBeam.setDcode(dcode);
				contaminatedHabs_FormBeam.setFinancialYear(financialYear);
				
				String element =  (String)it.next();
				String sourceCode = element;
				String value = (String)hashtable.get(element); 
				String ar[]=value.split("@");
				String preparedOn =ar[0];
				String value1 =ar[1];
				contaminatedHabs_FormBeam.setPreparedOn(preparedOn);
				contaminatedHabs_FormBeam.setIron1(value1);
				String sName=this.getSourceName(sourceCode);
				contaminatedHabs_FormBeam.setSourceName(sName);
				contaminatedHabs_FormBeam.setSourceCode(sourceCode);
				String query="select dname,mname,pname,vname,panch_name,dcode,panch_code from rws_complete_hab_view  where panch_code=SUBSTR('"+sourceCode+"',1,16)";
			 stmt3=conn.createStatement();
			ResultSet rs3 = stmt3.executeQuery(query);
			
		if(rs3.next()){
			contaminatedHabs_FormBeam.setDistrictName(rs3.getString(1));
			contaminatedHabs_FormBeam.setMandal(rs3.getString(2));
			contaminatedHabs_FormBeam.setPanchayat(rs3.getString(3));
			contaminatedHabs_FormBeam.setVillage(rs3.getString(4));
			contaminatedHabs_FormBeam.setHabName(rs3.getString(5));
			contaminatedHabs_FormBeam.setHabCode(rs3.getString(7));
			
			
			String tds1="--";
			String flouride1="--";
			String selinity1="--";
			String nitrate1="--";
			
			String labQuery="select LAB_NAME from RWS_WQ_TEST_RESULTS_TBL a,RWS_WATER_QUALITY_LAB_TBL b where a.lab_code=b.lab_code and source_code='"+sourceCode+"' and PREPARED_ON='"+preparedOn+"'";
			Statement statement=conn.createStatement();
			ResultSet rs=statement.executeQuery(labQuery);
			if(rs.next()){
				contaminatedHabs_FormBeam.setLabName(rs.getString(1));
			}
			statement.close();
			rs.close();
			
			String tdsQuery="SELECT COUNT(DISTINCT SUBSTR(B.SOURCE_CODE,1,16)),TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='05' AND SOURCE_CODE=? AND PREPARED_ON=? GROUP BY TESTING_PARAMETER_VALUE";
			//System.out.println("florideQuery----"+florideQuery);
			preparedStatement3=conn.prepareStatement(tdsQuery);
			preparedStatement3.setString(1, sourceCode);
			preparedStatement3.setString(2, preparedOn);
			
			resultSet3=preparedStatement3.executeQuery();	
			if(resultSet3.next()){
				tds1=resultSet3.getString(2);
				
				}
			contaminatedHabs_FormBeam.setTds1(tds1);
			preparedStatement3.close();
			resultSet3.close();
			
			String flourideQuery="SELECT COUNT(DISTINCT SUBSTR(B.SOURCE_CODE,1,16)),TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='13' AND SOURCE_CODE=? AND PREPARED_ON=? GROUP BY TESTING_PARAMETER_VALUE";
			//System.out.println("ironQuery----"+ironQuery);
			preparedStatement3=conn.prepareStatement(flourideQuery);
			preparedStatement3.setString(1, sourceCode);
			preparedStatement3.setString(2, preparedOn);
			
			resultSet3=preparedStatement3.executeQuery();
			if(resultSet3.next()){
				flouride1=resultSet3.getString(2);
				
				}
			contaminatedHabs_FormBeam.setFloride1(flouride1);
			preparedStatement3.close();
			resultSet3.close();
			
			
			
			String selinityQuery="SELECT COUNT(DISTINCT SUBSTR(B.SOURCE_CODE,1,16)),TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='12' AND SOURCE_CODE=?  AND PREPARED_ON=? GROUP BY TESTING_PARAMETER_VALUE";
			preparedStatement4=conn.prepareStatement(selinityQuery);
			preparedStatement4.setString(1, sourceCode);
			preparedStatement4.setString(2, preparedOn);
			
			resultSet4=preparedStatement4.executeQuery();	
			if(resultSet4.next()){
				selinity1=resultSet4.getString(2);
				
			}
			contaminatedHabs_FormBeam.setSelinity1(selinity1);
			preparedStatement4.close();
			resultSet4.close();
			
			
			String nitrateQuery="SELECT COUNT(DISTINCT SUBSTR(B.SOURCE_CODE,1,16)),TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='15' AND SOURCE_CODE=? AND PREPARED_ON=? GROUP BY TESTING_PARAMETER_VALUE";
			preparedStatement5=conn.prepareStatement(nitrateQuery);
			preparedStatement5.setString(1, sourceCode);
			preparedStatement5.setString(2, preparedOn);
			
			resultSet5=preparedStatement5.executeQuery();	
			if(resultSet5.next()){
				nitrate1=resultSet5.getString(2);
				contaminatedHabs_FormBeam.setNitrate1(nitrate1);
				}
			preparedStatement5.close();
			resultSet5.close();
			

			contaminatedDetails.add(contaminatedHabs_FormBeam);
		}
		stmt3.close();
		rs3.close();
		
		}
		
	}
	

	catch (SQLException e) {
		e.printStackTrace();
	}
		finally{
			if(conn!=null){
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	// TODO Auto-generated method stub

	return contaminatedDetails;

	}
	
	public ArrayList getContaminatedSelinityHabsList(String dcode, String yearStart,
			String yearEnd,String financialYear) {
		
		Connection conn = null;
		ResultSet resultSet=null,resultSet1=null,resultSet2=null,resultSet3=null,resultSet4=null,resultSet5=null,resultSet6=null;
		PreparedStatement preparedStatement=null, preparedStatement1=null,preparedStatement2=null,preparedStatement3=null,preparedStatement4=null,preparedStatement5=null,preparedStatement6=null;
		Statement stmt3=null;
		ArrayList contaminatedDetails = new ArrayList();
		Hashtable hashtable=new Hashtable();
		try {
			conn = RwsOffices.getConn();
			
			String viewquery="SELECT DISTINCT SOURCECODE,PREPAREDON,TVALUE FROM CONTAMINATIONDETAILS"+dcode+" A,RWS_WQ_PARA_TEST_TBL C WHERE TCODE ='12' AND A.TCODE =C.TESTING_PARAMETER_CODE AND (0.03+((1.806*TVALUE)/1000)>to_number(TRIM(c.MAX_PERMISSIBLE_VALUE)))  group by SOURCECODE,PREPAREDON,TVALUE";
			Statement statement1=conn.createStatement();
			ResultSet set=statement1.executeQuery(viewquery);
			while(set.next()){
				hashtable.put(set.getString(1), set.getString(2)+"@"+set.getString(3));
			}
			statement1.close();
			set.close();
			
			
			int size=hashtable.size();
			System.out.println("size of hash table is--------------"+size);
			 Vector v = new Vector(hashtable.keySet());
			    Collections.sort(v);
			  Iterator  it = v.iterator();
			while(it.hasNext()){
				RWS_WQ_ContaminatedHabs_FormBeam contaminatedHabs_FormBeam=new RWS_WQ_ContaminatedHabs_FormBeam();
				contaminatedHabs_FormBeam.setDcode(dcode);
				contaminatedHabs_FormBeam.setFinancialYear(financialYear);
				
				String element =  (String)it.next();
				String sourceCode = element;
				String value = (String)hashtable.get(element); 
				String ar[]=value.split("@");
				String preparedOn =ar[0];
				String value1 =ar[1];
				contaminatedHabs_FormBeam.setPreparedOn(preparedOn);
				contaminatedHabs_FormBeam.setSelinity1(value1);
				String sName=this.getSourceName(sourceCode);
				contaminatedHabs_FormBeam.setSourceName(sName);
				contaminatedHabs_FormBeam.setSourceCode(sourceCode);
				String query="select dname,mname,pname,vname,panch_name,dcode,panch_code from rws_complete_hab_view  where panch_code=SUBSTR('"+sourceCode+"',1,16)";
			 stmt3=conn.createStatement();
			ResultSet rs3 = stmt3.executeQuery(query);
			
		if(rs3.next()){
			contaminatedHabs_FormBeam.setDistrictName(rs3.getString(1));
			contaminatedHabs_FormBeam.setMandal(rs3.getString(2));
			contaminatedHabs_FormBeam.setPanchayat(rs3.getString(3));
			contaminatedHabs_FormBeam.setVillage(rs3.getString(4));
			contaminatedHabs_FormBeam.setHabName(rs3.getString(5));
			contaminatedHabs_FormBeam.setHabCode(rs3.getString(7));
			
			
			String tds1="--";
			String iron1="--";
			String flouride1="--";
			String nitrate1="--";
			
			String labQuery="select LAB_NAME from RWS_WQ_TEST_RESULTS_TBL a,RWS_WATER_QUALITY_LAB_TBL b where a.lab_code=b.lab_code and source_code='"+sourceCode+"' and PREPARED_ON='"+preparedOn+"'";
			Statement statement=conn.createStatement();
			ResultSet rs=statement.executeQuery(labQuery);
			if(rs.next()){
				contaminatedHabs_FormBeam.setLabName(rs.getString(1));
			}
			statement.close();
			rs.close();
			
			String tdsQuery="SELECT COUNT(DISTINCT SUBSTR(B.SOURCE_CODE,1,16)),TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='05' AND SOURCE_CODE=? AND PREPARED_ON=? GROUP BY TESTING_PARAMETER_VALUE";
			//System.out.println("florideQuery----"+florideQuery);
			preparedStatement3=conn.prepareStatement(tdsQuery);
			preparedStatement3.setString(1, sourceCode);
			preparedStatement3.setString(2, preparedOn);
			
			resultSet3=preparedStatement3.executeQuery();	
			if(resultSet3.next()){
				tds1=resultSet3.getString(2);
				
				}
			contaminatedHabs_FormBeam.setTds1(tds1);
			preparedStatement3.close();
			resultSet3.close();
			
			String flourideQuery="SELECT COUNT(DISTINCT SUBSTR(B.SOURCE_CODE,1,16)),TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='13' AND SOURCE_CODE=?  AND PREPARED_ON=? GROUP BY TESTING_PARAMETER_VALUE";
			preparedStatement4=conn.prepareStatement(flourideQuery);
			preparedStatement4.setString(1, sourceCode);
			preparedStatement4.setString(2, preparedOn);
			
			resultSet4=preparedStatement4.executeQuery();	
			if(resultSet4.next()){
				flouride1=resultSet4.getString(2);
				
			}
			contaminatedHabs_FormBeam.setFloride1(flouride1);
			preparedStatement4.close();
			resultSet4.close();
			
			
			String ironQuery="SELECT COUNT(DISTINCT SUBSTR(B.SOURCE_CODE,1,16)),TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='16' AND SOURCE_CODE=? AND PREPARED_ON=? GROUP BY TESTING_PARAMETER_VALUE";
			//System.out.println("ironQuery----"+ironQuery);
			preparedStatement3=conn.prepareStatement(ironQuery);
			preparedStatement3.setString(1, sourceCode);
			preparedStatement3.setString(2, preparedOn);
			
			resultSet3=preparedStatement3.executeQuery();
			if(resultSet3.next()){
				iron1=resultSet3.getString(2);
				
				}
			contaminatedHabs_FormBeam.setIron1(iron1);
			preparedStatement3.close();
			resultSet3.close();
			
			
			
			
			
			String nitrateQuery="SELECT COUNT(DISTINCT SUBSTR(B.SOURCE_CODE,1,16)),TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='15' AND SOURCE_CODE=? AND PREPARED_ON=? GROUP BY TESTING_PARAMETER_VALUE";
			preparedStatement5=conn.prepareStatement(nitrateQuery);
			preparedStatement5.setString(1, sourceCode);
			preparedStatement5.setString(2, preparedOn);
			
			resultSet5=preparedStatement5.executeQuery();	
			if(resultSet5.next()){
				nitrate1=resultSet5.getString(2);
				contaminatedHabs_FormBeam.setNitrate1(nitrate1);
				}
			preparedStatement5.close();
			resultSet5.close();


			contaminatedDetails.add(contaminatedHabs_FormBeam);
		}
		stmt3.close();
		rs3.close();
		
		}
		System.out.println(contaminatedDetails.size());
	}
	

	catch (SQLException e) {
		e.printStackTrace();
	}
		
		finally{
			if(conn!=null){
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	// TODO Auto-generated method stub

	return contaminatedDetails;
	}

	public ArrayList getContaminatedNitrateHabsList(String dcode, String yearStart,
			String yearEnd,String financialYear) {
		
		Connection conn = null;
		ResultSet resultSet=null,resultSet1=null,resultSet2=null,resultSet3=null,resultSet4=null,resultSet5=null,resultSet6=null;
		PreparedStatement preparedStatement=null, preparedStatement1=null,preparedStatement2=null,preparedStatement3=null,preparedStatement4=null,preparedStatement5=null,preparedStatement6=null;
		Statement stmt3=null;
		ArrayList contaminatedDetails = new ArrayList();
		Hashtable hashtable=new Hashtable();
		try {
			conn = RwsOffices.getConn();
			
			
			String viewquery="SELECT DISTINCT SOURCECODE,PREPAREDON,TVALUE FROM CONTAMINATIONDETAILS"+dcode+" A,RWS_WQ_PARA_TEST_TBL C WHERE TCODE ='15' AND A.TCODE =C.TESTING_PARAMETER_CODE AND to_number(TRIM(TVALUE))>to_number(TRIM(c.MAX_PERMISSIBLE_VALUE))  group by SOURCECODE,PREPAREDON,TVALUE";
			Statement statement1=conn.createStatement();
			ResultSet set=statement1.executeQuery(viewquery);
			
			while(set.next()){
				hashtable.put(set.getString(1), set.getString(2)+"@"+set.getString(3));
			}
			statement1.close();
			set.close();
			
			
			int size=hashtable.size();
			//System.out.println("size of hash table is--------------"+size);
			 Vector v = new Vector(hashtable.keySet());
			    Collections.sort(v);
			  Iterator  it = v.iterator();
			while(it.hasNext()){
				RWS_WQ_ContaminatedHabs_FormBeam contaminatedHabs_FormBeam=new RWS_WQ_ContaminatedHabs_FormBeam();
				contaminatedHabs_FormBeam.setDcode(dcode);
				contaminatedHabs_FormBeam.setFinancialYear(financialYear);
				
				String element =  (String)it.next();
				String sourceCode = element;
				String value = (String)hashtable.get(element); 
				String ar[]=value.split("@");
				String preparedOn =ar[0];
				String value1 =ar[1];
				contaminatedHabs_FormBeam.setPreparedOn(preparedOn);
				contaminatedHabs_FormBeam.setNitrate1(value1);
				String sName=this.getSourceName(sourceCode);
				contaminatedHabs_FormBeam.setSourceName(sName);
				contaminatedHabs_FormBeam.setSourceCode(sourceCode);
				String query="select dname,mname,pname,vname,panch_name,dcode,panch_code from rws_complete_hab_view  where panch_code=SUBSTR('"+sourceCode+"',1,16)";
			 stmt3=conn.createStatement();
			ResultSet rs3 = stmt3.executeQuery(query);
			
		if(rs3.next()){
			contaminatedHabs_FormBeam.setDistrictName(rs3.getString(1));
			contaminatedHabs_FormBeam.setMandal(rs3.getString(2));
			contaminatedHabs_FormBeam.setPanchayat(rs3.getString(3));
			contaminatedHabs_FormBeam.setVillage(rs3.getString(4));
			contaminatedHabs_FormBeam.setHabName(rs3.getString(5));
			contaminatedHabs_FormBeam.setHabCode(rs3.getString(7));
			
			String tds1="--";
			String iron1="--";
			String selinity1="--";
			String flouride1="--";
			
			String labQuery="select LAB_NAME from RWS_WQ_TEST_RESULTS_TBL a,RWS_WATER_QUALITY_LAB_TBL b where a.lab_code=b.lab_code and source_code='"+sourceCode+"' and PREPARED_ON='"+preparedOn+"'";
			Statement statement=conn.createStatement();
			ResultSet rs=statement.executeQuery(labQuery);
			if(rs.next()){
				contaminatedHabs_FormBeam.setLabName(rs.getString(1));
			}
			statement.close();
			rs.close();
			
			String tdsQuery="SELECT COUNT(DISTINCT SUBSTR(B.SOURCE_CODE,1,16)),TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='05' AND SOURCE_CODE=? AND PREPARED_ON=? GROUP BY TESTING_PARAMETER_VALUE";
			//System.out.println("florideQuery----"+florideQuery);
			preparedStatement3=conn.prepareStatement(tdsQuery);
			preparedStatement3.setString(1, sourceCode);
			preparedStatement3.setString(2, preparedOn);
			
			resultSet3=preparedStatement3.executeQuery();	
			if(resultSet3.next()){
				tds1=resultSet3.getString(2);
				
				}
			contaminatedHabs_FormBeam.setTds1(tds1);
			preparedStatement3.close();
			resultSet3.close();
			
			String ironQuery="SELECT COUNT(DISTINCT SUBSTR(B.SOURCE_CODE,1,16)),TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='16' AND SOURCE_CODE=? AND PREPARED_ON=? GROUP BY TESTING_PARAMETER_VALUE";
			//System.out.println("ironQuery----"+ironQuery);
			preparedStatement3=conn.prepareStatement(ironQuery);
			preparedStatement3.setString(1, sourceCode);
			preparedStatement3.setString(2, preparedOn);
			
			resultSet3=preparedStatement3.executeQuery();
			if(resultSet3.next()){
				iron1=resultSet3.getString(2);
				
				}
			contaminatedHabs_FormBeam.setIron1(iron1);
			preparedStatement3.close();
			resultSet3.close();
			
			
			
			String selinityQuery="SELECT COUNT(DISTINCT SUBSTR(B.SOURCE_CODE,1,16)),TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='12' AND SOURCE_CODE=?  AND PREPARED_ON=? GROUP BY TESTING_PARAMETER_VALUE";
			preparedStatement4=conn.prepareStatement(selinityQuery);
			preparedStatement4.setString(1, sourceCode);
			preparedStatement4.setString(2, preparedOn);
			
			resultSet4=preparedStatement4.executeQuery();	
			if(resultSet4.next()){
				selinity1=resultSet4.getString(2);
				
			}
			contaminatedHabs_FormBeam.setSelinity1(selinity1);
			preparedStatement4.close();
			resultSet4.close();
			
			
			String flourideQuery="SELECT COUNT(DISTINCT SUBSTR(B.SOURCE_CODE,1,16)),TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE ='13' AND SOURCE_CODE=? AND PREPARED_ON=? GROUP BY TESTING_PARAMETER_VALUE";
			preparedStatement5=conn.prepareStatement(flourideQuery);
			preparedStatement5.setString(1, sourceCode);
			preparedStatement5.setString(2, preparedOn);
			
			resultSet5=preparedStatement5.executeQuery();	
			if(resultSet5.next()){
				flouride1=resultSet5.getString(2);
				contaminatedHabs_FormBeam.setFloride1(flouride1);
				}
			preparedStatement5.close();
			resultSet5.close();

			contaminatedDetails.add(contaminatedHabs_FormBeam);
		}
		stmt3.close();
		rs3.close();
		
		}
		
	}
	

	catch (SQLException e) {
		e.printStackTrace();
	}
		
		finally{
			if(conn!=null){
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	// TODO Auto-generated method stub

	return contaminatedDetails;

	}
	public String getSourceName(String sourceCode){
		String sourceCode1=sourceCode;
		String s=sourceCode1.substring(19,21);
		String sourceName="";
		String query="";
		String schemeCodeField = null;
		String tableName;
		if(s.equals("SO"))
		{
			tableName="RWS_SOURCE_TBL";
			Connection conn = null;
			ResultSet resultSet=null;
			PreparedStatement preparedStatement=null;
			
			try {
				conn = RwsOffices.getConn();
			query="select source_name from RWS_SOURCE_TBL where source_code=?";
			preparedStatement=conn.prepareStatement(query);
			preparedStatement.setString(1, sourceCode1);
			resultSet=preparedStatement.executeQuery();
			if(resultSet.next()){
				schemeCodeField=resultSet.getString(1);
				
			}
			preparedStatement.close();
			resultSet.close();
			}
			catch(Exception e){
				e.printStackTrace();
			}
			finally{
				if(conn!=null){
					try {
						conn.close();
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
				}
			}
			
		}
		if(s.equals("HP"))
		{
			tableName="RWS_HP_SUBCOMP_PARAM_TBL";
			schemeCodeField="HANDPUMP";
			
		}
		
		else if(s.equals("SH"))
		{
			tableName="RWS_SHALLOWHANDPUMPS_TBL";
			schemeCodeField="SHALLOWHANDPUMPS";
			
		}
		else if(s.equals("PD"))
		{
			tableName="RWS_OPENWELL_POND_TBL";
			sourceName="POND";
			
			
		}
		else if(s.equals("OW"))
		{
			tableName="RWS_OPEN_WELL_MAST_TBL";
			schemeCodeField="OPENWELL";
			
			
		}
		else if(s.equals("PS"))
		{
			tableName="RWS_AST_SUBCOMP_PARAM_TBL";
			schemeCodeField="SUBCOMP";
			
			
		}
	
		else if(s.equals("RW"))
		{
			tableName="RWS_AST_RW_COLLWELL_PARAM_TBL";
			schemeCodeField="COLLWELL";
			
			
		}
		else if(s.equals("ST"))
		{
			tableName="RWS_AST_SS_SC_PARAM_TBL";
			schemeCodeField="SSSC";
			
		}
		else if(s.equals("SS")||s.equals("RS"))
		{
			tableName="RWS_AST_WTP_SC_PARAM_TBL";
			schemeCodeField="WTPSC";
			
		}
		else if(s.equals("SM"))
		{
			tableName="RWS_AST_SUMP_M_SC_PARAM_TBL";
			schemeCodeField="SUMP_M_SC";
			
		}
		else if(s.equals("FP"))
		{
			tableName="RWS_AST_FP_BRIDGE_PARAM_TBL";
			schemeCodeField="FP_BRIDGE";
			
		}
		else if(s.equals("PH"))
		{
			tableName="RWS_AST_PUMPHOUSE_PARAM_TBL";
			schemeCodeField="PUMPHOUSE";
			
		}
		else if(s.equals("WQ"))
		{
			tableName="RWS_AST_WATCHMAN_PARAM_TBL";
			schemeCodeField="WATCHMAN";
			
		}
		else if(s.equals("CW"))
		{
			tableName="RWS_AST_CW_COLLWELL_PARAM_TBL";
			schemeCodeField="CW_COLLWELL";
			
		}
		else if(s.equals("PM"))
		{
			tableName="RWS_AST_PUMPINGMAIN_TBL";
			schemeCodeField="PUMPINGMAIN";
			
		}
		else if(s.equals("GM"))
		{
			tableName="RWS_AST_GRAVITYMAIN_TBL";
			schemeCodeField="GRAVITYMAIN";
			
		}
		else if(s.equals("DT"))
		{
			tableName="RWS_AST_DISTRI_SC_PARAM_TBL";
			schemeCodeField="DISTRI_SC";
			
		}
		else if(s.equals("OS"))
		{
			tableName="RWS_AST_OHSR_SC_PARAM_TBL";
			schemeCodeField="OHSR_SC";
			
		}
		else if(s.equals("OB"))
		{
			tableName="RWS_AST_OHBR_SC_PARAM_TBL";
			schemeCodeField="OHBR_CODE";
			
		}
		else if(s.equals("GL"))
		{
			tableName="RWS_AST_GLSR_SC_PARAM_TBL";
			schemeCodeField="GLSR_SC";
			
		}
		else if(s.equals("GB"))
		{
			tableName="RWS_AST_GLBR_SC_PARAM_TBL";
			schemeCodeField="GLBR_SC";
			
		}
		else if(s.equals("BT"))
		{
			tableName="RWS_AST_BPT_PARAM_TBL";
			schemeCodeField="BPT";
			
		}
		else if(s.equals("CT"))
		{
			tableName="RWS_AST_CIS_SC_PARAM_TBL";
			schemeCodeField="CIS_SC ";
			
		}
		else if(s.equals("OT"))
		{
			tableName="RWS_AST_OTHERS_PARAM_TBL";
			schemeCodeField="OTHERS";
			
		}
		else{
			schemeCodeField="-";
		}
		
		
		
		
		return schemeCodeField;
		
		
	}
	
	}