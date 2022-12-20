package nic.watersoft.wquality;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Vector;

import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.RwsLocations;
import nic.watersoft.masters.RwsMaster;
import nic.watersoft.masters.RwsMasterData;
import nic.watersoft.commons.Debug;
import nic.watersoft.masters.SubCompMetaData;
import nic.watersoft.commons.DAOMessage;

public class RwsWQualityData 
{
	static Connection conn = null;
	static Statement stmt = null;
	static Statement stmt2 = null;
	static ResultSet rs = null;
	static ResultSet rs2 = null;
	static PreparedStatement ps = null;
	static SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	public static String errorMessage;
	
	public static void  closeAll() throws Exception
	{
		if (rs != null) 
		{
			try 
			{
				rs.close();
			}
			catch (Exception e) 
			{
				//System.out.println("The error in closeAll"+e);
			}
			rs = null;
		}
		if (rs2 != null) 
		{
			try 
			{
				rs2.close();
			}
			catch (Exception e) 
			{
				//System.out.println("The error in closeAll"+e);
			}
			rs2 = null;
		}
		if (stmt != null) 
		{
			try 
			{
				stmt.close();
			}
			catch (Exception e) 
			{
				//System.out.println("The error in closeAll="+e);
			}
			stmt = null;
		}
		if (stmt2 != null) 
		{
			try 
			{
				stmt2.close();
			}
			catch (Exception e) 
			{
				//System.out.println("The error in closeAll="+e);
			}
			stmt2 = null;
		}
		if (conn != null) 
		{
			try 
			{
				conn.close();
			}
			catch (Exception e) 
			{
				//System.out.println("The error in closeAll="+e);
			}
			conn = null;
		}
		if (ps != null) 
		{
			try 
			{
				ps.close();
			}
			catch (Exception e) 
			{
				//System.out.println("The error in closeAll="+e);
			}
			ps = null;
		}
}


public static DAOMessage insertWaterSample(RwsWQuality rwsWQuality,DataSource dataSource) throws Exception
{
	DAOMessage daoMessage=new DAOMessage();
	int rowCount=0;
	if(rwsWQuality.getCoc()==null)
	{
		rwsWQuality.setCoc("00");
	}
	if(rwsWQuality.getDoc()==null)
	{
		rwsWQuality.setDoc("0");
	}
	//System.out.println("sd code1:"+rwsWQuality.getSdoc());
	if(rwsWQuality.getSdoc()==null)
	{
		rwsWQuality.setSdoc("00");
	}
	try
	{
		
		
		
		conn = dataSource.getConnection();
		String query="insert into RWS_WATER_SAMPLE_COLLECT_TBL(TEST_ID,CIRCLE_OFFICE_CODE," +
				"DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE,HAB_CODE,SOURCE_CODE,"+
				"TEST_CODE,NATURE_OF_TEST,LAB_CODE,SAMP_COLLECTOR_CODE,SAMP_COLLECT_DATE,"+
				"SAMP_COLLECT_TIME,ASSIGNED_ON,PREPARED_BY,PREPARED_ON,SOURCE_TYPE)"+
				" values" +
				"('"+getTestId("sample",rwsWQuality.getLabCode(),(rwsWQuality.getPreparedOn()).substring(6),conn)+"'," +
				"'"+rwsWQuality.getCoc()+"','"+rwsWQuality.getDoc()+"'," +
				"'"+rwsWQuality.getSdoc()+"','"+rwsWQuality.getHabCode()+"'," +
				"'"+rwsWQuality.getSourceCode()+"','"+rwsWQuality.getTestCode()+"'," +
				"'"+rwsWQuality.getNatureOfTest()+"','"+rwsWQuality.getLabCode()+"'," +
				"'"+rwsWQuality.getSampCollectCode()+"'," +
				"TO_DATE('"+rwsWQuality.getSampCollectDate()+"','dd/MM/yyyy')," +
				"'"+rwsWQuality.getSampCollectTime()+"'," +
				"TO_DATE('"+rwsWQuality.getAssignedOn()+"','dd/MM/yyyy')," +
				"'"+rwsWQuality.getPreparedBy()+"'," +
				"TO_DATE('"+rwsWQuality.getPreparedOn()+"','dd/MM/yyyy')," 
				+"'"+rwsWQuality.getSourceType()+"')";
		
		//System.out.println("query= "+query);
		stmt=conn.createStatement();
							
		rowCount=stmt.executeUpdate(query);
	}
	catch(Exception e)
	{
		//System.out.println("The error is in RwsMasterData insertWaterSample "+e.getMessage());
	}
	finally 
	{
		closeAll();
	}
	if(rowCount>0)
	{
		daoMessage.setMessage("Record Inserted Successfully");
		daoMessage.setOperationSussess(true);
	}
	else
	{
		daoMessage.setMessage("Record Cannot be Inserted");
		daoMessage.setOperationSussess(false);
	}
		
	return daoMessage;
}
public static DAOMessage updateWaterSample(RwsWQuality rwsWQuality,DataSource dataSource) throws Exception
{
	DAOMessage daoMessage=new DAOMessage();
	int rowCount=0;
	if(rwsWQuality.getCoc()==null)
	{
		rwsWQuality.setCoc("00");
	}
	if(rwsWQuality.getDoc()==null)
	{
		rwsWQuality.setDoc("0");
	}
	if(rwsWQuality.getSdoc()==null)
	{
		rwsWQuality.setSdoc("00");
	}
	try
	{
		
		
		
		conn = dataSource.getConnection();
		String query="UPDATE RWS_WATER_SAMPLE_COLLECT_TBL"+
				" set " +
				"TEST_ID='"+rwsWQuality.getTestId()+"',"+
				"CIRCLE_OFFICE_CODE='"+rwsWQuality.getCoc()+"',"+
				"DIVISION_OFFICE_CODE='"+rwsWQuality.getDoc()+"'," +
				"SUBDIVISION_OFFICE_CODE='"+rwsWQuality.getSdoc()+"'," +
				"HAB_CODE='"+rwsWQuality.getHabCode()+"'," +
				"SOURCE_CODE='"+rwsWQuality.getSourceCode()+"'," +
				"TEST_CODE='"+rwsWQuality.getTestCode()+"'," +
				"NATURE_OF_TEST='"+rwsWQuality.getNatureOfTest()+"'," +
				"LAB_CODE='"+rwsWQuality.getLabCode()+"'," +
				"SAMP_COLLECTOR_CODE='"+rwsWQuality.getSampCollectCode()+"'," +
				"SAMP_COLLECT_DATE=TO_DATE('"+rwsWQuality.getSampCollectDate()+"','dd/MM/yyyy')," +
				"SAMP_COLLECT_TIME='"+rwsWQuality.getSampCollectTime()+"'," +
				"ASSIGNED_ON=TO_DATE('"+rwsWQuality.getAssignedOn()+"','dd/MM/yyyy')," +
				"PREPARED_BY='"+rwsWQuality.getPreparedBy()+"'," +
				"PREPARED_ON=TO_DATE('"+rwsWQuality.getPreparedOn()+"','dd/MM/yyyy'),"+
				"SOURCE_TYPE='"+rwsWQuality.getSourceType()+"' " +
				"WHERE TEST_ID='"+rwsWQuality.getTestId()+"'";
		
		//System.out.println("query= "+query);
		stmt=conn.createStatement();
							
		rowCount=stmt.executeUpdate(query);
	}
	catch(Exception e)
	{
		//System.out.println("The error is in RwsMasterData updateWaterSample "+e.getMessage());
	}
	finally 
	{
		closeAll();
	}
	if(rowCount>0)
	{
		daoMessage.setMessage("Record Updated Successfully");
		daoMessage.setOperationSussess(true);
	}
	else
	{
		daoMessage.setMessage("Record Cannot be Updated");
		daoMessage.setOperationSussess(false);
	}
		
	return daoMessage;
}

public static RwsWQuality getWaterSample(String testId,DataSource dataSource) throws Exception
{
	RwsWQuality rwsWQuality = null;
	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		//System.out.println("testId= "+testId);
		String qry = "select distinct a.test_id from RWS_WQ_TEST_RESULTS_lnk_TBL a,RWS_WQ_TEST_RESULTS_lnk_TBL b where a.test_id=b.test_id and a.test_id='"+testId+"'";
	//	System.out.println("check qry:"+qry);
		ResultSet rss = stmt.executeQuery(qry);
		if(!rss.next())
		{
			String query="select WC.*,to_char(wc.SAMP_COLLECT_DATE,'dd/mm/yyyy')as sampleCollectionDate,substr(WC.HAB_CODE,1,2)DCODE,substr(WC.HAB_CODE,6,2)MCODE,substr(WC.HAB_CODE,8,3) VCODE,substr(WC.HAB_CODE,13,2) PCODE from RWS_WATER_SAMPLE_COLLECT_TBL WC where WC.test_id='"+testId+"'";
		//	System.out.println("query is in side "+query);
			rs =stmt.executeQuery(query);
			if ( rs.next() ) 
			{
				rwsWQuality = new RwsWQuality();
				rwsWQuality.setCoc(rs.getString("CIRCLE_OFFICE_CODE"));
				rwsWQuality.setDoc(rs.getString("DIVISION_OFFICE_CODE"));
				rwsWQuality.setSdoc(rs.getString("SUBDIVISION_OFFICE_CODE"));
				rwsWQuality.setCircleOfficeName(RwsMasterData.getCircleOfficeName("1",rs.getString("CIRCLE_OFFICE_CODE"),conn));
				rwsWQuality.setDivisionOfficeName(RwsMasterData.getDivisionOfficeName("1",rs.getString("CIRCLE_OFFICE_CODE"),rs.getString("DIVISION_OFFICE_CODE"),conn));
				rwsWQuality.setSubDivisionOfficeName(RwsMasterData.getSubDivisionOfficeName("1",rs.getString("CIRCLE_OFFICE_CODE"),rs.getString("DIVISION_OFFICE_CODE"),rs.getString("SUBDIVISION_OFFICE_CODE"),conn));
				rwsWQuality.setMandalCode(rs.getString("MCODE"));
				rwsWQuality.setPanchCode(rs.getString("PCODE"));
				
				rwsWQuality.setMandalName(RwsMasterData.getMandalName(rs.getString("DCODE"),rs.getString("MCODE"),conn));
				rwsWQuality.setPanchName(RwsMasterData.getPanchayatName(rs.getString("DCODE"),rs.getString("MCODE"),rs.getString("PCODE"),conn));
				rwsWQuality.setVillageCode(RwsMasterData.getVillageName(rs.getString("DCODE"),rs.getString("MCODE"),rs.getString("PCODE"),rs.getString("VCODE"),conn));
				rwsWQuality.setTestId(rs.getString("TEST_ID"));
				rwsWQuality.setHabCode(rs.getString("HAB_CODE"));
				rwsWQuality.setSourceCode(rs.getString("SOURCE_CODE"));
				rwsWQuality.setSourceType(rs.getString("SOURCE_TYPE"));
				//System.out.println("sourceType is "+rs.getString("SOURCE_TYPE"));
				rwsWQuality.setTestCode(rs.getString("TEST_CODE"));
				rwsWQuality.setNatureOfTest(rs.getString("NATURE_OF_TEST"));
				rwsWQuality.setLabCode(rs.getString("LAB_CODE"));
				rwsWQuality.setSampCollectCode(rs.getString("SAMP_COLLECTOR_CODE"));
				rwsWQuality.setSampCollectDate(rs.getString("sampleCollectionDate"));
				rwsWQuality.setSampCollectTime(rs.getString("SAMP_COLLECT_TIME"));
				//System.out.println("Sample Collection Time:"+rs.getString("SAMP_COLLECT_TIME"));
				rwsWQuality.setAssignedOn(df.format(rs.getDate("ASSIGNED_ON")));
				rwsWQuality.setPreparedBy(rs.getString("PREPARED_BY"));
				rwsWQuality.setPreparedOn(df.format(rs.getDate("PREPARED_ON")));
			}
				rs=stmt.executeQuery("select panch_name from rws_panchayat_raj_tbl where panch_code='"+rwsWQuality.getHabCode()+"'");
				if(rs.next())
					rwsWQuality.setHabName(rs.getString(1));
		}
	}
	catch (Exception e)
	{
		//System.out.println("The error in rwsWQualityData getWaterSample=  "+e.getMessage());
	}
	finally 
	{
		closeAll();
	}
	return rwsWQuality;
}

public static ArrayList getWaterSamples(String preparedBy,DataSource dataSource) throws Exception
{
	RwsWQuality rwsWQuality = null;
	ArrayList watersamples=new ArrayList();
	//System.out.println("Preparedby======================="+preparedBy);
	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		//rs =stmt.executeQuery("select * from RWS_WQ_SAMPLE_COLLECT_VIEW where prepared_by='"+preparedBy+"'");
		
		String query="select SCT.TEST_ID,SCT.CIRCLE_OFFICE_CODE," 
			+"SCT.DIVISION_OFFICE_CODE,SCT.SUBDIVISION_OFFICE_CODE," 
			+"SCT.HAB_CODE,SCT.SOURCE_TYPE,SCT.SOURCE_CODE," 
			+"SCT.TEST_CODE,SCT.NATURE_OF_TEST,SCT.LAB_CODE," 
			+"D.DESIGNATION_ACR,TO_CHAR(SCT.SAMP_COLLECT_DATE,'DD/MM/YYYY')SAMP_COLLECT_DATE," 
			+"SCT.SAMP_COLLECT_TIME,SCT.ASSIGNED_ON," 
			+"SCT.PREPARED_BY from RWS_WATER_SAMPLE_COLLECT_TBL SCT," 
			+"RWS_DESIGNATION_TBL D where D.DESIGNATION_CODE=SCT.SAMP_COLLECTOR_CODE" ;
	//	System.out.println("query in getWaterSamples in RwsWQualityData is "+query);
		rs =stmt.executeQuery(query);
		while ( rs.next() ) 
		{
			try{
			rwsWQuality = new RwsWQuality();
			rwsWQuality.setTestId(rs.getString("TEST_ID"));
			rwsWQuality.setCoc(RwsMasterData.getCircleOfficeName("1",rs.getString("CIRCLE_OFFICE_CODE"),conn));
			rwsWQuality.setDoc(rs.getString("DIVISION_OFFICE_CODE"));
			rwsWQuality.setSdoc(rs.getString("SUBDIVISION_OFFICE_CODE"));
			rwsWQuality.setHabCode(rs.getString("HAB_CODE"));
			rwsWQuality.setSourceType(getSourceName(format(rs.getString("SOURCE_TYPE"))));
			rwsWQuality.setSourceCode(rs.getString("SOURCE_CODE"));
			rwsWQuality.setTestCode(rs.getString("TEST_CODE"));
			rwsWQuality.setTestName(RwsMasterData.getWaterTestName(rs.getString("TEST_CODE"),conn));
			int natureOfTestCode=rs.getInt("NATURE_OF_TEST");
			//System.out.println("10");
			
			String natureOfTest="";
			switch(natureOfTestCode)
			{
			case 1: natureOfTest="ROUTINE";
			break;
			case 2: natureOfTest="SEASONAL";
			break;
			case 3: natureOfTest="QUARTERLY";
			break;
			case 4: natureOfTest="DISEASE OUTBREAK";
			}
			rwsWQuality.setNatureOfTest(natureOfTest);
			rwsWQuality.setLabCode(rs.getString("LAB_CODE"));
			rwsWQuality.setLabName(RwsMasterData.getWQLab(rs.getString("LAB_CODE"),dataSource).getLabName());
			rwsWQuality.setSampCollectCode(rs.getString("DESIGNATION_ACR"));
			//rwsWQuality.setSampCollectDate(df.format(rs.getDate("SAMP_COLLECT_DATE")));
			rwsWQuality.setSampCollectDate(rs.getString("SAMP_COLLECT_DATE"));
			rwsWQuality.setSampCollectTime(rs.getString("SAMP_COLLECT_TIME"));
			rwsWQuality.setAssignedOn(df.format(rs.getDate("ASSIGNED_ON")));
			rwsWQuality.setPreparedBy(rs.getString("PREPARED_BY"));
			
			watersamples.add(rwsWQuality);
			}catch(Exception e){System.out.println("Exception in getWaterSamples while retrieving is "+e);}
		}
		//System.out.println("watersamples size is "+watersamples.size());
	}
	catch (Exception e)
	{
		//System.out.println("Exception in getWaterSamples is "+e);
	}
	finally 
	{
		closeAll();
	}
	return watersamples;
}
/*added by ramesh

public static String recordExists(String testId, DataSource dataSource) throws Exception
{
	String recordExists = "";
	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		String qry = "select * from RWS_WQ_TEST_RESULTS_TBL where test_id='"+testId+"'";
		System.out.println(qry);
		rs = stmt.executeQuery(qry);
		if(rs.next())
		{
			recordExists = "Y";
		}
		else
		{
			recordExists = "N";
		}
		System.out.println("recordExists value in qulaity data::"+recordExists);
	}
	catch (Exception e)
	{
		//System.out.println("Error in Rws"+e.getMessage());
	}
	finally 
	{
			closeAll();
			
	}
	return recordExists;
}*/
public static int removeWaterSample(String testId, DataSource dataSource) throws Exception
{
	int del=0;
	int rvalue[]=null;
	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		Statement stmt1 = conn.createStatement();
		//String qry = "select * from RWS_WQ_TEST_RESULTS_TBL where test_id='"+testId+"'";
		String qry = "select distinct a.test_id from RWS_WQ_TEST_RESULTS_lnk_TBL a,RWS_WQ_TEST_RESULTS_lnk_TBL b where a.test_id=b.test_id and a.test_id='"+testId+"'";
		//System.out.println("Query in delete check is:"+qry);
		ResultSet rss = stmt1.executeQuery(qry);
		if(!rss.next())
		{
			//System.out.println("watch in rss");
			stmt.addBatch("DELETE FROM RWS_WQ_TEST_RESULTS_lnk_TBL  WHERE TEST_ID='"+testId+"'");
			stmt.addBatch("DELETE FROM RWS_WQ_TEST_RESULTS_TBL  WHERE TEST_ID='"+testId+"'");
			stmt.addBatch("DELETE FROM RWS_WATER_SAMPLE_COLLECT_TBL WHERE TEST_ID='"+testId+"'");
			rvalue=stmt.executeBatch();
			del = rvalue.length;
		}
		else
		{
		//	System.out.println("watch in else rss");
			del = -1;
		}
	}
	catch (Exception e)
	{
		//System.out.println("Error in Rws"+e.getMessage());
	}
	finally 
	{
			closeAll();
			
	}
	//System.out.println("watch in outside");
	//System.out.println("del value:"+del);
	return del;
	
}
public static void updateWaterSample(String testId,RwsWQuality rwsWQuality,DataSource dataSource) throws Exception
{
	try
	{
		
			conn = dataSource.getConnection();
						
			ps=conn.prepareStatement("update RWS_WATER_SAMPLE_COLLECT_TBL set HAB_CODE=?,SOURCE_CODE=?,TEST_CODE=?,NATURE_OF_TEST=?,LAB_CODE=?,SAMP_COLLECTOR_CODE=?,SAMP_COLLECT_DATE=TO_DATE('"+rwsWQuality.getSampCollectDate()+"','dd/MM/yyyy'),SAMP_COLLECT_TIME=?,ASSIGNED_ON =TO_DATE('"+rwsWQuality.getSampCollectDate()+"','dd/MM/yyyy'),SOURCE_TYPE=? where test_id='"+testId+"'");
			
			ps.setString(1,rwsWQuality.getHabCode());
			
			ps.setString(2,rwsWQuality.getSourceCode());
			ps.setString(3,rwsWQuality.getTestCode());			
			ps.setString(4,rwsWQuality.getNatureOfTest());
			ps.setString(5,rwsWQuality.getLabCode());
			ps.setString(6,rwsWQuality.getSampCollectCode());
			ps.setString(7,rwsWQuality.getSampCollectTime());
			ps.setString(8,rwsWQuality.getSourceType());
			ps.executeUpdate();
			
	}
	catch (Exception e)
	{
		//System.out.println(e.getMessage());
	}
	finally 
	{
		closeAll();
	}
}
//********************************************************************************************//

/*
public static int[] insertWaterSampleRes(RwsWQuality rwsWQuality,ArrayList tests,ArrayList results,DataSource dataSource) throws Exception
{
	int rowCount[]= new int[50];
	WaterSampleTestResLnk waterSampleTestResLnk = new WaterSampleTestResLnk();
	WaterSampleTestResBean waterSampleTestResBean = new WaterSampleTestResBean();
	try
	{	
		conn = dataSource.getConnection();
		conn.setAutoCommit(false);
		stmt=conn.createStatement();
			
		for (int i=0;i<tests.size();i++)
		{
			waterSampleTestResBean = (WaterSampleTestResBean)tests.get(i);	
			if(waterSampleTestResBean.getHabCode() != null)
			{
			  
				String query="insert into RWS_WQ_TEST_RESULTS_TBL values" +
				"('"+waterSampleTestResBean.getTestId()+"'," +
				"'"+rwsWQuality.getRecommendations()+"'," +
				"'"+rwsWQuality.getCondemnSource()+"'," +
				"'"+rwsWQuality.getUpdateSource()+"'," +
				"TO_DATE('"+rwsWQuality.getForwadedOn()+"','dd/MM/yyyy')," +
				"'"+rwsWQuality.getPreparedBy()+"'," +
				"TO_DATE('"+rwsWQuality.getPreparedOn()+"','dd/MM/yyyy')," +
				"'"+waterSampleTestResBean.getTestCode()+"'," +
				"'"+waterSampleTestResBean.getLabCode()+"'," +
				"'"+waterSampleTestResBean.getSourceCode()+"')";
				//System.out.println("query is "+query);
				stmt.addBatch(query);
				for (int j=0;j<results.size();j++)
				{
					waterSampleTestResLnk = (WaterSampleTestResLnk)results.get(j);	
					
					
					query="insert into RWS_WQ_TEST_RESULTS_LNK_TBL values" +
						  "('"+waterSampleTestResBean.getTestId()+"'," +
						  "'"+waterSampleTestResLnk.getTestPCode()+"'," +
						  "'"+waterSampleTestResLnk.getResult()+"')";
					//System.out.println("query is "+query);
					stmt.addBatch(query);
					
				}
			}
			
		}
		
		rowCount = stmt.executeBatch();
		conn.commit();

		
	}
	catch(Exception e)
	{
		//System.out.println("The error is insertWaterSampleRes= "+e.getMessage());
	}
	finally 
	{
		closeAll();
	}
	return rowCount;
}
*/

public static int[] insertWaterSampleRes(RwsWQuality rwsWQuality,ArrayList tests,ArrayList allResults,DataSource dataSource) throws Exception
{
	int rowCount[]= new int[50];
	String query="";
	String query1="";
	//System.out.println("in insertWaterSampleRes");
	WaterSampleTestResLnk waterSampleTestResLnk = new WaterSampleTestResLnk();
	WaterSampleTestResBean waterSampleTestResBean = new WaterSampleTestResBean();
	try
	{	
		conn = dataSource.getConnection();
		conn.setAutoCommit(false);
		stmt=conn.createStatement();
		int size=tests.size();
		ArrayList inserted=new ArrayList();
		for (int i=0;i<tests.size();i++)
		{
			inserted.add(i,"false");
		}
			
		for (int i=0;i<tests.size();i++)
		{
			
			waterSampleTestResBean = (WaterSampleTestResBean)tests.get(i);	
			if(waterSampleTestResBean.getHabCode() != null)
			{
			  
				query1="insert into RWS_WQ_TEST_RESULTS_TBL values" +
				"('"+waterSampleTestResBean.getTestId()+"'," +
				"'"+rwsWQuality.getRecommendations()+"'," +
				"'"+rwsWQuality.getCondemnSource()+"'," +
				"'"+rwsWQuality.getUpdateSource()+"'," +
				"TO_DATE('"+rwsWQuality.getForwadedOn()+"','dd/MM/yyyy')," +
				"'"+rwsWQuality.getPreparedBy()+"'," +
				"TO_DATE('"+rwsWQuality.getPreparedOn()+"','dd/MM/yyyy')," +
				"'"+waterSampleTestResBean.getTestCode()+"'," +
				"'"+waterSampleTestResBean.getLabCode()+"'," +
				"'"+waterSampleTestResBean.getSourceCode()+"')";
				////System.out.println("query is "+query1);
				//stmt.addBatch(query);
			
				for(int k=0;k<allResults.size();k++)
				{
					ArrayList resultsTmp=(ArrayList)allResults.get(k);
						for (int j=0;j<resultsTmp.size();j++)
						{
							waterSampleTestResLnk = (WaterSampleTestResLnk)resultsTmp.get(j);	
							if(waterSampleTestResBean.getTestId().equals(waterSampleTestResLnk.getTestId()))
							{
							if(((String)inserted.get(i)).equals("false"))
							{
								stmt.addBatch(query1);
								//System.out.println("query added is "+query1);
								inserted.add(i,"true");
							}
							query="insert into RWS_WQ_TEST_RESULTS_LNK_TBL values" +
								  "('"+waterSampleTestResLnk.getTestId()+"'," +
								  "'"+waterSampleTestResLnk.getTestPCode()+"'," +
								  "'"+waterSampleTestResLnk.getResult()+"')";
							//System.out.println("query is "+query);
							stmt.addBatch(query);
							}
							
						}
					}
			
			}
		}
		
		rowCount = stmt.executeBatch();
		conn.commit();

		
	}
	catch(Exception e)
	{
		//System.out.println("The error is insertWaterSampleRes= "+e);
	}
	finally 
	{
		closeAll();
	}
	return rowCount;
}

public static int[] insertWaterSampleRes1(RwsWQuality rwsWQuality,ArrayList tests,ArrayList carryResults,String selectedRadio,DataSource dataSource) throws Exception
{
	int rowCount[]= new int[50];
	String testIds ="",testParameter = "",testValue = "";
	String query="";
	String query1="";
	//System.out.println("in insertWaterSampleRes");
	WaterSampleTestResLnk waterSampleTestResLnk = new WaterSampleTestResLnk();
	WaterSampleTestResBean waterSampleTestResBean = new WaterSampleTestResBean();
	//System.out.println("selectedRadio:"+selectedRadio);
	int selectedRadio1 = Integer.parseInt(selectedRadio);
	//System.out.println("selectedRadio1:"+selectedRadio1);
	try
	{	
		conn = dataSource.getConnection();
		conn.setAutoCommit(false);
		stmt=conn.createStatement();
		int size=tests.size();
		ArrayList inserted=new ArrayList();
		for (int i=0;i<tests.size();i++)
		{
			inserted.add(i,"false");
		}
			
		//for (int i=0;i<tests.size();i++)
		//{
		//System.out.println("bofore if:"+selectedRadio1);
			waterSampleTestResBean = (WaterSampleTestResBean)tests.get(selectedRadio1);
			//System.out.println("bofore if1:"+waterSampleTestResBean.getTestId());
			if(waterSampleTestResBean.getTestId() != null)
			{
			  //System.out.println("in side if");
				query1="insert into RWS_WQ_TEST_RESULTS_TBL values" +
				"('"+waterSampleTestResBean.getTestId()+"'," +
				"'"+rwsWQuality.getRecommendations()+"'," +
				"''," +
				"'"+rwsWQuality.getUpdateSource()+"'," +
				"TO_DATE('"+rwsWQuality.getForwadedOn()+"','dd/MM/yyyy')," +
				"'"+rwsWQuality.getPreparedBy()+"'," +
				"TO_DATE('"+rwsWQuality.getPreparedOn()+"','dd/MM/yyyy')," +
				"'"+waterSampleTestResBean.getTestCode()+"'," +
				"'"+waterSampleTestResBean.getLabCode()+"'," +
				"'"+waterSampleTestResBean.getSourceCode()+"'," +
				"'"+rwsWQuality.getCondemnSource()+"')";
				//System.out.println("query is "+query1);
				stmt.addBatch(query1);
				
					for(int j=0,i=0;j<carryResults.size()/3;j++)
					{
						//System.out.println(i+"~~~~~~"+j);
						testIds = (String)carryResults.get(i++);
						testParameter = (String)carryResults.get(i++);
						testValue = (String)carryResults.get(i++);
						if(i % 3 == 0)
						{
							query="insert into RWS_WQ_TEST_RESULTS_LNK_TBL values" +
							  "('"+testIds+"'," +
							  "'"+testParameter+"'," +
							  "'"+testValue+"')";
						//System.out.println("query is for carryResults "+query);
						stmt.addBatch(query);
						}
					}
					
					//ArrayList resultsTmp=(ArrayList)carryResults.get(k);
					//System.out.println("watch1");
						/*for (int j=0;j<resultsTmp.size();j++)
						{
							//System.out.println("watch in i");
							//System.out.println(waterSampleTestResLnk.getTestId()+"********"+waterSampleTestResBean.getTestId());
							waterSampleTestResLnk = (WaterSampleTestResLnk)resultsTmp.get(j);	
							if(waterSampleTestResBean.getTestId().equals(waterSampleTestResLnk.getTestId()))
							{
							if(((String)inserted.get(selectedRadio1)).equals("false"))
							{
								stmt.addBatch(query1);
								//System.out.println("query added is "+query1);
								inserted.add(selectedRadio1,"true");
							} 
							query="insert into RWS_WQ_TEST_RESULTS_LNK_TBL values" +
								  "('"+waterSampleTestResLnk.getTestId()+"'," +
								  "'"+waterSampleTestResLnk.getTestPCode()+"'," +
								  "'"+waterSampleTestResLnk.getResult()+"')";
							//System.out.println("query is "+query);
							stmt.addBatch(query);
							}
							
						}*/
					//}
			
			}
		//}
		
		rowCount = stmt.executeBatch();
		conn.commit();

		
	}
	catch(Exception e)
	{
		System.out.println("The error is insertWaterSampleRes= "+e);
	}
	finally 
	{
		closeAll();
	}
	System.out.println("exit from insertWaterSampleRes"+rowCount.length);
	return rowCount;
}

public static RwsWQuality getWaterSampleResult(DataSource dataSource,String testId) throws Exception
{
	RwsWQuality rwsWQuality = null;
 	
	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		
		String query="SELECT * FROM RWS_WQ_TEST_RESULTS_TBL WHERE TEST_ID='"+testId+"'";
		//System.out.println("query is "+query);
		rs =stmt.executeQuery(query);
		if ( rs.next() ) 
		{
			rwsWQuality = new RwsWQuality();
//System.out.println("Recommendations in Method:"+rs.getString(2));
			rwsWQuality.setTestId(rs.getString(1));
			rwsWQuality.setRecommendations(rs.getString(2));
			rwsWQuality.setUpdateSource(rs.getString(4));
			rwsWQuality.setForwadedTo(rs.getString(6));
			rwsWQuality.setForwadedOn(df.format(rs.getDate(5)));
			rwsWQuality.setTestCode(rs.getString(8));
			rwsWQuality.setLabCode(rs.getString(9));
			rwsWQuality.setSourceCode(rs.getString(10));
			rwsWQuality.setCondemnSource(rs.getString(11));
			            
		}
	}
	catch (Exception e)
	{
		//System.out.println("The error in getWaterSampleResult=   "+e.getMessage());
	}
	finally 
	{
		closeAll();
	}
	return rwsWQuality;
}
public static ArrayList getWaterSampleResults(DataSource dataSource,String empcode) throws Exception
{
	RwsWQuality rwsWQuality = null;
	ArrayList watersampleres=new ArrayList();
	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		//System.out.println("empcode="+empcode);
		//String query="select wq.test_id,s.source_name,t.test_name,l.lab_name,wq.recommendations,decode(wq.condemn_the_source,'Y','YES','N','NO'),decode(wq.update_source_data,'Y' ,'YES','N','NO'),p.USER_ID,wq.FORWARDED_ON  from RWS_WQ_TEST_RESULTS_TBL wq,rws_source_tbl s,RWS_WATER_QUALITY_TEST_TBL t,RWS_WATER_QUALITY_LAB_TBL l,rws_password_tbl p where wq.test_code=t.test_code and wq.source_code=s.source_code and wq.lab_code=l.lab_code and wq.PREPARED_BY=p.user_id and wq.PREPARED_BY='"+empcode+"'";
		String query="select wq.test_id,wq.source_code,t.test_name,l.lab_name,wq.recommendations,decode(wq.potable,'Y','YES','N','NO'),decode(wq.update_source_data,'Y' ,'YES','N','NO'),p.USER_ID,wq.FORWARDED_ON,WQ.PREPARED_ON  from RWS_WQ_TEST_RESULTS_TBL wq,RWS_WATER_QUALITY_TEST_TBL t,RWS_WATER_QUALITY_LAB_TBL l,rws_password_tbl p where wq.test_code=t.test_code  and wq.lab_code=l.lab_code and wq.PREPARED_BY=p.user_id";
		//System.out.println("query is "+query);
		rs =stmt.executeQuery(query);
		while ( rs.next() ) 
		{
			rwsWQuality = new RwsWQuality();

			rwsWQuality.setTestId(rs.getString(1));
			rwsWQuality.setSourceName(rs.getString(2));
			rwsWQuality.setTestName(rs.getString(3));
			rwsWQuality.setLabName(rs.getString(4));
			rwsWQuality.setRecommendations(rs.getString(5));
			rwsWQuality.setCondemnSource(rs.getString(6));
			rwsWQuality.setUpdateSource(rs.getString(7));
			rwsWQuality.setForwadedTo(rs.getString(8));
			rwsWQuality.setForwadedOn(df.format(rs.getDate(9)));
			rwsWQuality.setPreparedOn(df.format(rs.getDate(10)));
										
			watersampleres.add(rwsWQuality);
		}
	}
	catch (Exception e)
	{
		//System.out.println(e.getMessage());
	}
	finally 
	{
		closeAll();
	}
	return watersampleres;
}
public static int removeWaterSampleRes(String testId, DataSource dataSource) throws Exception
{
	int rowCount=0;
	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		rowCount=stmt.executeUpdate("delete  from RWS_WQ_TEST_RESULTS_TBL where test_id='"+testId+"'");
	}
	 
	//	rs =stmt.executeQuery("SELECT * FROM rws_watersample_tbl where HAB_CODE='"+habCode+"'");
	//	if(rs.next() == false)
	//	{
	//		rowCount=stmt.executeUpdate("delete  from rws_watersample_tbl where HAB_CODE='"+habCode+"' and ENTEREDON='"+employeeCode+"'");
	//	}
	//}
	catch (Exception e)
	{
		//System.out.println("Error in Rws"+e.getMessage());
	}
	finally 
	{
			closeAll();
	}
	return rowCount;
}
public static int[] updateWaterSampleResult(String testId,ArrayList results,RwsWQuality rwsWQuality,DataSource dataSource) throws Exception
{  int rowCount[]= new int[50];
   WaterSampleTestResLnk waterSampleTestResLnk = new WaterSampleTestResLnk();
   try
	{
		    //System.out.println("testId--------------------"+testId);
		    //System.out.println("recomendations="+rwsWQuality.getRecommendations()+"CONDEMN_THE_SOURCE="+rwsWQuality.getCondemnSource()+"update source"+rwsWQuality.getUpdateSource()+"forwared on="+rwsWQuality.getForwadedOn());
			conn = dataSource.getConnection();
			conn.setAutoCommit(false);
			String query="update RWS_WQ_TEST_RESULTS_TBL set RECOMMENDATIONS='"+rwsWQuality.getRecommendations()+"',CONDEMN_THE_SOURCE='"+rwsWQuality.getCondemnSource()+"',UPDATE_SOURCE_DATA='"+rwsWQuality.getUpdateSource()+"',FORWARDED_ON=TO_DATE('"+rwsWQuality.getForwadedOn()+"','dd/MM/yyyy') where TEST_ID='"+testId+"'";		
			stmt=conn.createStatement();
			//System.out.println("query  is "+query);
			stmt.addBatch(query);
			for (int j=0;j<results.size();j++)
			{
				waterSampleTestResLnk = (WaterSampleTestResLnk)results.get(j);	
				//System.out.println("######### Record No : " + (j+1) + " ##########");
				//System.out.println("######### waterSampleTestResBean.getTestId() : " + testId + " ##########");
				//System.out.println("######### waterSampleTestResLnk.getTestPCode() : " + waterSampleTestResLnk.getTestPCode() + " ##########");
				//System.out.println("######### waterSampleTestResLnk.getResult() : " + waterSampleTestResLnk.getResult() + " ##########");
				stmt.addBatch("update RWS_WQ_TEST_RESULTS_LNK_TBL set TESTING_PARAMETER_VALUE='"+waterSampleTestResLnk.getResult()+"' WHERE TEST_ID='"+testId+"' AND TESTING_PARAMETER_CODE='"+waterSampleTestResLnk.getTestPCode()+"'");
				
			}
			rowCount = stmt.executeBatch();
			conn.commit();
	}
	catch (Exception e)
	{
		//System.out.println(e.getMessage());
	}
	finally 
	{
		closeAll();
	}
	return rowCount;
}

public static ArrayList getHabCodesForWaterSample(DataSource dataSource,String coc,String doc,String sdoc) throws Exception
{
	RwsWQuality rwsWQuality = null;
	ArrayList habs=new ArrayList();
	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		//System.out.println("coc="+coc+"***doc="+doc+"****sdoc="+sdoc);
		rs =stmt.executeQuery("SELECT panch_code,panch_name FROM rws_panchayat_raj_tbl WHERE substr(panch_code,0,2)='"+coc+"' order by panch_name");
		while ( rs.next() ) 
		{
			rwsWQuality = new RwsWQuality();

			rwsWQuality.setCode(rs.getString("PANCH_CODE"));
			rwsWQuality.setName(rs.getString("PANCH_NAME"));
			rwsWQuality.setCodeName(rs.getString("PANCH_NAME")+" - "+rs.getString("PANCH_CODE"));
			habs.add(rwsWQuality);
		}
	}
	catch (Exception e)
	{
		//System.out.println("The error in getHabCodesForWaterSample="+e);
	}
	finally 
	{
		closeAll();
	}
	return habs;
}

public static ArrayList getEmpCodesForWaterSample(DataSource dataSource,String designation) throws Exception
{
		RwsWQuality rwsWQuality = null;
		ArrayList empcodes=new ArrayList();
		String query;
		
		try
		{
			conn = dataSource.getConnection();
			stmt=conn.createStatement();
			//System.out.println("designation is "+designation);
			if(designation.equals("lab"))
			{
				query="SELECT USER_ID FROM RWS_PASSWORD_TBL WHERE DESIGNATION_CODE='13'";
				rs = stmt.executeQuery(query);
			}
			else if(designation.equals("geologist"))
			{
				query="SELECT USER_ID FROM RWS_PASSWORD_TBL WHERE DESIGNATION_CODE='12'";
				rs = stmt.executeQuery(query);
			}
				while ( rs.next() ) 
			{
				rwsWQuality = new RwsWQuality();
				rwsWQuality.setEmpcode(rs.getString(1));
				empcodes.add(rwsWQuality);

			}
		}
		
		catch (Exception e)
		{
			//System.out.println("The error in getEmpCodesForWaterSample="+e);
		}
		finally 
		{
			closeAll();
		}
	return empcodes;
}

public static String getEmpName(String code,Connection conn) throws Exception
{
	String name=null;
	Statement stmt1=null;
	ResultSet rs1=null;
	try
	{	
		//System.out.println("getEmpCode="+code);
		stmt1=conn.createStatement();
		if(code!=null && !code.equals("null")){
		rs1 = stmt1.executeQuery("SELECT EMPLOYEE_NAME  FROM rws_EMPLOYEE_tbl WHERE EMPLOYEE_CODE  ='"+code+"'");
		rs1.next();
		name=rs1.getString(1);
		}
		else
			name="";
		
	}
	catch (Exception e)
	{
		//System.out.println("Ther error in getEmpName="+e);
	}
	finally 
	{
		stmt1.close();
	}
	//System.out.println("name="+name);
    return name;
}
public static String getTestName(String code,Connection conn) throws Exception
{
	String name=null;
	Statement stmt1=null;
	ResultSet rs1=null;
	try
	{	
		//System.out.println("getTestName="+code);
		stmt1=conn.createStatement();
		
		rs1 = stmt1.executeQuery("SELECT TEST_NAME  FROM RWS_WATER_QUALITY_TEST_TBL WHERE TEST_CODE  ='"+code+"'");
		rs1.next();
		name=rs1.getString(1);
		
	}
	catch (Exception e)
	{
		//System.out.println("Ther error in getTestName="+e);
	}
	finally 
	{
		stmt1.close();
	}
return name;
}
public static String getLabName(String code,Connection conn) throws Exception
{
	String name=null;
	Statement stmt1=null;
	ResultSet rs1=null;
	try
	{	
		//System.out.println("getLabName="+code);
		stmt1=conn.createStatement();
		
		rs1 = stmt1.executeQuery("SELECT LAB_NAME  FROM RWS_WATER_QUALITY_LAB_TBL WHERE LAB_CODE  ='"+code+"'");
		rs1.next();
		name=rs1.getString(1);
		
	}
	catch (Exception e)
	{
		//System.out.println("Ther error in getLabName="+e);
	}
	finally 
	{
		stmt1.close();
	}
return name;
}


public static ArrayList getWQLabTests(DataSource dataSource,String empcode,String circle,String division) throws Exception
{
	RwsWQuality rwsWQuality = null;
	RwsLocations rwsLocations = new RwsLocations(dataSource);
	ArrayList watersamples=new ArrayList();
	try
	{
		//System.out.println("empcode in getWaterEmpTests is===="+empcode);
		if(empcode != null)
		{
			conn = dataSource.getConnection();
			stmt = conn.createStatement();
			String labCode="";
			String  query="SELECT WS.TEST_ID,T.TEST_CODE,T.TEST_NAME," +
					"WS.HAB_CODE,D.DESIGNATION_ACR,to_char(ws.prepared_on,'dd/mm/yyyy')prepared_on, " +
					"TO_CHAR(WS.SAMP_COLLECT_DATE,'dd/mm/yyyy')SAMP_COLLECT_DATE," +
					"WS.SOURCE_CODE,WS.SOURCE_CODE,L.LAB_CODE," +
					"L.LOCATION,WS.TEST_ID FROM RWS_WATER_SAMPLE_COLLECT_TBL WS," +
					"RWS_WATER_QUALITY_TEST_TBL T,RWS_DESIGNATION_TBL D," +
					"RWS_WATER_QUALITY_LAB_TBL L WHERE   " +
					"WS.TEST_CODE=T.TEST_CODE  AND " +
					"WS.SAMP_COLLECTOR_CODE=D.DESIGNATION_CODE AND WS.LAB_CODE=L.LAB_CODE AND " +
					"ws.TEST_ID NOT IN (SELECT TEST_ID FROM RWS_WQ_TEST_RESULTS_TBL) and " ;
			if((circle!=null || circle !="" ) && (division!=null || division !="" ))
					query += " ws.circle_office_code='"+circle+"' and ws.division_office_code='"+division+"'";
			//System.out.println("query is "+query);
			rs =stmt.executeQuery(query);
			while ( rs.next() ) 
			{
				rwsWQuality = new RwsWQuality();
				
				rwsWQuality.setTestCode(rs.getString("TEST_CODE"));
				rwsWQuality.setTestName(rs.getString("TEST_NAME"));
				rwsWQuality.setHabCode(rs.getString("HAB_CODE"));
				rwsWQuality.setHabName(rwsLocations.getHabName(rs.getString("HAB_CODE"),conn));
				rwsWQuality.setSampCollectCode(rs.getString("DESIGNATION_ACR"));
				rwsWQuality.setSampCollectDate(rs.getString("SAMP_COLLECT_DATE"));
				//THE FOLLOWING SHOULD BE REMOVED
				rwsWQuality.setAssignedOn(rs.getString("PREPARED_ON"));
				rwsWQuality.setSourceCode(rs.getString("SOURCE_CODE"));
				//rwsWQuality.setSourceName(rs.getString(8));
				rwsWQuality.setSourceName(rs.getString("SOURCE_CODE"));				
				rwsWQuality.setLabCode(rs.getString("LAB_CODE"));
				rwsWQuality.setLabName(rs.getString("LOCATION"));
				//FOLLOWING LINE SHOULD BE MODIFIED
				rwsWQuality.setTestId(rs.getString("TEST_ID"));
											
				watersamples.add(rwsWQuality);
				////System.out.println("added all tests");
			}
		}
	}
	catch (Exception e)
	{
		//System.out.println("The error in getWaterEmpTests is ==="+e.getMessage());
	}
	finally 
	{
		closeAll();
	}
	return watersamples;
}


public static ArrayList getWQLabTest(DataSource dataSource,String empcode,String testcode) throws Exception
{
	RwsWQuality rwsWQuality = null;
	RwsLocations rwsLocations = new RwsLocations(dataSource);
	ArrayList watersamples=new ArrayList();
	ArrayList watersamples1=new ArrayList();
	int i = 0;
	try
	{
		//System.out.println("getWQLabTest");
		//System.out.println("empcode in getWQLabTest is===="+empcode+"testcode="+testcode);
		if(empcode != null)
		{
			conn = dataSource.getConnection();
			stmt = conn.createStatement();
			/*
			String query="SELECT T.TEST_CODE,T.TEST_NAME," +
			  "WS.HAB_CODE,D.DESIGNATION_ACR," +
			  "TO_CHAR(WS.SAMP_COLLECT_DATE,'dd/mm/yyyy')SAMP_COLLECT_DATE," +
			  "TO_CHAR(G.ASSIGNED_TO_DATE,'dd/mm/yyyy')ASSIGNED_TO_DATE," +
			  "S.SOURCE_CODE,S.SOURCE_NAME," +
			  "L.LAB_CODE,L.LOCATION,G.TEST_ID " +
			  "FROM RWS_WQ_GEOLOGIST_TEST_TBL G," +
			  "RWS_WATER_SAMPLE_COLLECT_TBL WS," +
			  "RWS_SOURCE_TBL S,RWS_WATER_QUALITY_TEST_TBL T," +
			  "RWS_DESIGNATION_TBL D,RWS_WATER_QUALITY_LAB_TBL L" +
			  " WHERE G.TEST_ID=WS.TEST_ID AND " +
			  "WS.SOURCE_CODE=S.SOURCE_CODE AND " +
			  "WS.TEST_CODE=T.TEST_CODE AND " +
			  "G.LAB_CODE=L.LAB_CODE AND " +
			  "WS.SAMP_COLLECTOR_CODE=D.DESIGNATION_CODE " +
			  "AND G.TEST_ID NOT IN " +
			  "(SELECT TEST_ID FROM RWS_WQ_TEST_RESULTS_TBL where  test_code='"+testcode+"') AND " +
			  "G.ASSIGNED_TO='"+empcode+"' and G.TEST_ID='"+testcode+"'";
			  */
			
			String query="SELECT T.TEST_CODE,T.TEST_NAME," +
			  "WS.HAB_CODE,D.DESIGNATION_ACR," +
			  "TO_CHAR(WS.SAMP_COLLECT_DATE,'dd/mm/yyyy')SAMP_COLLECT_DATE," +
			  ""+
			  "S.SOURCE_CODE,S.SOURCE_NAME," +
			  "L.LAB_CODE,L.LOCATION,WS.TEST_ID " +
			  "FROM "+
			  "RWS_WATER_SAMPLE_COLLECT_TBL WS," +
			  "RWS_SOURCE_TBL S,RWS_WATER_QUALITY_TEST_TBL T," +
			  "RWS_DESIGNATION_TBL D,RWS_WATER_QUALITY_LAB_TBL L" +
			  " WHERE  " +
			  "WS.SOURCE_CODE=S.SOURCE_CODE AND " +
			  "WS.TEST_CODE=T.TEST_CODE AND " +
			  "WS.LAB_CODE=L.LAB_CODE AND " +
			  "WS.SAMP_COLLECTOR_CODE=D.DESIGNATION_CODE " +
			  "AND WS.TEST_ID NOT IN " +
			  "(SELECT TEST_ID FROM RWS_WQ_TEST_RESULTS_TBL where  test_code='"+testcode+"')  " +
			  " and WS.TEST_ID='"+testcode+"'";
			String qq = "select ws.test_id,t.test_code,t.test_name,ws.hab_code,ws.samp_collector_code,ws.source_code,TO_CHAR(WS.SAMP_COLLECT_DATE,'dd/mm/yyyy') as SAMP_COLLECT_DATE,ws.lab_code,l.lab_name,d.designation_acr from rws_water_sample_collect_tbl ws,RWS_WATER_QUALITY_LAB_TBL l,RWS_WATER_QUALITY_TEST_TBL t,RWS_DESIGNATION_TBL d where l.lab_code=ws.lab_code and WS.TEST_CODE=T.TEST_CODE and WS.SAMP_COLLECTOR_CODE=D.DESIGNATION_CODE and ws.test_id="+testcode;
			//System.out.println("qq is::"+qq);
			
	//		System.out.println("query is:: "+query);
			rs =stmt.executeQuery(qq);
			while ( rs.next() ) 
			{
				watersamples1.add(0,rs.getString("TEST_CODE"));
				watersamples1.add(1,rs.getString("TEST_NAME"));
				watersamples1.add(2,rs.getString("HAB_CODE"));
				watersamples1.add(3,rwsLocations.getHabName(rs.getString("HAB_CODE"),conn));
				watersamples1.add(4,rs.getString("DESIGNATION_ACR"));
				watersamples1.add(5,rs.getString("SAMP_COLLECT_DATE"));
				watersamples1.add(6,rs.getString("SOURCE_CODE"));
				watersamples1.add(7,rs.getString("LAB_CODE"));
				watersamples1.add(8,rs.getString("LAB_NAME"));
				watersamples1.add(9,rs.getString("TEST_ID"));
				rwsWQuality = new RwsWQuality();
				//System.out.println("Test Code::"+rs.getString("TEST_CODE"));
				rwsWQuality.setTestCode(rs.getString("TEST_CODE"));
				rwsWQuality.setTestName(rs.getString("TEST_NAME"));
				rwsWQuality.setHabCode(rs.getString("HAB_CODE"));
				rwsWQuality.setHabName(rwsLocations.getHabName(rs.getString("HAB_CODE"),conn));
				rwsWQuality.setSampCollectCode(rs.getString("DESIGNATION_ACR"));
				rwsWQuality.setSampCollectDate(rs.getString("SAMP_COLLECT_DATE"));
				//rwsWQuality.setAssignedOn(rs.getString("ASSIGNED_TO_DATE"));
				rwsWQuality.setSourceCode(rs.getString("SOURCE_CODE"));
				//rwsWQuality.setSourceName(rs.getString("SOURCE_NAME"));
				rwsWQuality.setLabCode(rs.getString("LAB_CODE"));
				rwsWQuality.setLabName(rs.getString("LAB_NAME"));
				rwsWQuality.setTestId(rs.getString("TEST_ID"));
				//System.out.println("HabName::"+rwsWQuality.getHabName());
				//System.out.println("labcode="+rs.getString("LAB_CODE")+"labName="+rs.getString("LOCATION")+"test name="+rs.getString("TEST_NAME")+"testcode="+rs.getString("TEST_CODE"));
				
				watersamples.add(rwsWQuality);
			}
		//	System.out.println("watersample size:"+watersamples.size());
		}
	}
	catch (Exception e)
	{
		System.out.println("The error in getWaterEmpTests is ==="+e.getMessage());
	}
	finally 
	{
		closeAll();
	}
	
	//return watersamples;
	return watersamples1;
}

public static String getTestId(String test,String labCode,String yr,Connection conn) throws Exception
{
	String name=null;
	Statement stmt1=null;
	ResultSet rs1=null;
	try
	{	
		//System.out.println("  year="+yr);
		stmt1=conn.createStatement();
		if(test.equals("sample"))
		{
		rs1 = stmt1.executeQuery("select max(substr(test_id,3,4)),max(to_number(substr(test_id,7,10))) from rws_water_sample_collect_tbl where substr(test_id,1,2)='"+labCode+"'");
		}
		else if(test.equals("test"))
		{
			rs1 = stmt1.executeQuery("select max(substr(test_id,3,4)),max(to_number(substr(test_id,7,10))) from RWS_WQ_TEST_RESULTS_TBL where substr(test_id,1,2)='"+labCode+"'");
		}
		rs1.next();
		if(rs1.getString(1) != null)
		{
			if(rs1.getString(1).equals(yr))
			{
				if(rs1.getInt(2) < 9)
				{
					name="000"+(rs1.getInt(2)+1);
				}
				else if(rs1.getInt(2) < 99)
				{
					name="00"+(rs1.getInt(2)+1);
				}
				else if(rs1.getInt(2) < 999)
				{
					name="0"+(rs1.getInt(2)+1);
				}
				else if(rs1.getInt(2) < 9999)
				{
					name=String.valueOf(rs1.getInt(2)+1);
				}
			}
			else
			{
				name="0001";
			}
		}
		else
		{
			name="0001";
		}
	}
	catch (Exception e)
	{
		//System.out.println("Ther error in getLabName="+e);
	}
	finally 
	{
		stmt1.close();
	}
	//System.out.println("labCode+yr+name="+labCode+yr+name);
return (labCode+yr+name);
}
public static ArrayList getWorkIds(String coc,String doc,String status,DataSource dataSource) throws Exception
{
	RwsWQuality rwsWQuality = null;
	ArrayList workIds=new ArrayList();
	String query;
	try
	{
		if(coc != null && doc != null)
		{
			conn = dataSource.getConnection();
			stmt = conn.createStatement();
			
			
			if(status.equalsIgnoreCase("none"))
			{
			//code changed on 050407
			/*query="SELECT FIN.WORK_ID,P.PROPOSAL_NAME  FROM RWS_SOURCE_IDEN_FIN_TBL FIN,RWS_WORK_PROPOSAL_TBL P" +
			" WHERE FIN.CIRCLE_OFFICE_CODE='"+coc+"' AND" +
			" FIN.DIVISION_OFFICE_CODE='"+doc+"' AND FIN.FINALISED='Y'" +
			" AND FIN.WORK_ID=P.WORK_ID ORDER BY FIN.WORK_ID";*/
				
			
			/*query="SELECT FIN.WORK_ID,P.PROPOSAL_NAME  FROM RWS_SOURCE_IDEN_FIN_TBL FIN,RWS_WORK_PROPOSAL_TBL P" +
				" WHERE substr(fin.office_code,2,2)='"+coc+"' and substr(fin.office_code,4,1)='"+doc+"'AND FIN.FINALISED is null" +
				" AND FIN.WORK_ID=P.WORK_ID ORDER BY FIN.WORK_ID";*/
			
			query="SELECT FIN.WORK_ID,P.PROPOSAL_NAME  FROM RWS_SOURCE_IDEN_FIN_TBL FIN,RWS_WORK_PROPOSAL_TBL P" +
				" WHERE  substr(P.office_code,2,2)='"+coc+"' and substr(P.office_code,4,1)='"+doc+"' " +
				" AND FIN.FINALISED is null" +
				" AND FIN.WORK_ID=P.WORK_ID ORDER BY FIN.WORK_ID";	
				
			//System.out.println("query is "+query);
				rs =stmt.executeQuery(query);
			}
			else if(status.equalsIgnoreCase("status"))
			{
				//code changed on 050407
				/*query="SELECT FIN.WORK_ID,P.PROPOSAL_NAME FROM RWS_SOURCE_IDEN_FIN_TBL FIN,RWS_WORK_PROPOSAL_TBL P" +
				" WHERE FIN.CIRCLE_OFFICE_CODE='"+coc+"' AND" +
				" FIN.DIVISION_OFFICE_CODE='"+doc+"' AND FIN.FINALISED='Y'" +
				" AND FIN.WORK_ID=P.WORK_ID ORDER BY FIN.WORK_ID";*/
				
				query="SELECT FIN.WORK_ID,P.PROPOSAL_NAME FROM RWS_SOURCE_IDEN_FIN_TBL FIN,RWS_WORK_PROPOSAL_TBL P" +
				" WHERE substr(fin.office_code,2,2)='"+coc+"' and substr(fin.office_code,4,1)='"+doc+"' AND FIN.FINALISED='Y'" +
				" AND FIN.WORK_ID=P.WORK_ID ORDER BY FIN.WORK_ID";
				//System.out.println("query is "+query);
				rs =stmt.executeQuery(query);
			}
			while ( rs.next() ) 
			{
				rwsWQuality = new RwsWQuality();
				
				rwsWQuality.setWorkCode(rs.getString(1));
				rwsWQuality.setCodeName(rs.getString(2)+" - "+rs.getString(1));
				//rwsWQuality.setAssetName(rs.getString(2));
						
				workIds.add(rwsWQuality);
			}
		}
	}
	catch (Exception e)
	{
		//System.out.println("The error in getWorkIds in rwsWQualityData is"+e);
	}
	finally 
	{
		closeAll();
	}
	return workIds;
}
public static ArrayList getTestParameterCodes(DataSource dataSource,String testId,String testCode) throws Exception
{
	RwsWQuality rwsWQuality = null;
	ResultSet rss = null;
	ArrayList parameters=new ArrayList();
	//System.out.println("The testCode is-----------------"+testCode);
	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		Statement stmt1 = conn.createStatement();
		Statement stmts = conn.createStatement();
		String query="SELECT TEST_NAME,TESTING_PARAMETER_CODE," +
		   "TESTING_PARAMETER_NAME,MIN_PERMISSIBLE_VALUE," +
		   "MAX_PERMISSIBLE_VALUE,UNDESIRE_EFFECT,P.TEST_CODE  FROM RWS_WQ_PARA_TEST_TBL P," +
		   "RWS_WATER_QUALITY_TEST_TBL T " +
		   "WHERE T.TEST_CODE=P.TEST_CODE AND " +
		   "P.TEST_CODE IN (SELECT TEST_CODE FROM " +
		   "RWS_WATER_QUALITY_TEST_TBL WHERE TEST_CODE='"+testCode+"') order by testing_parameter_code";
	//	System.out.println("query is in gettestparameterCodes:"+query);
		rs = stmt.executeQuery(query);
		int i= 0;
		while(rs.next())i++;
		//System.out.println("RS Size::"+i);
		rs.close();
		
		rs = stmts.executeQuery(query);
		while(rs.next())
		{					
			rwsWQuality = new RwsWQuality();
			
			rwsWQuality.setTestId(testId);
			rwsWQuality.setTestName(rs.getString(1));
			rwsWQuality.setTestPCode(rs.getString(2));
			rwsWQuality.setTestPName(rs.getString(3));
			rwsWQuality.setMinPerVal(rs.getString(4));
			rwsWQuality.setMaxPerVal(rs.getString(5));
			rwsWQuality.setUndesirableEffect(rs.getString(6));
			String q = "select TESTING_PARAMETER_VALUE from RWS_WQ_TEST_RESULTS_LNK_TBL where TEST_ID='"+testId+"' and TESTING_PARAMETER_CODE='"+rs.getString(2)+"'";
			////System.out.println("q is::"+q);
			rss = stmt.executeQuery(q);
			if(rss.next())
				rwsWQuality.setResult(rss.getString(1));
			else
				rwsWQuality.setResult("");
			parameters.add(rwsWQuality);
			
		}
	
	}
	catch(Exception e)
	{	
		//System.out.println("Imam:  " + e);
	}
	finally
	{
		closeAll();
	}
	return parameters;
}


/*public static ArrayList getTestResult(DataSource dataSource,String testId) throws Exception
{
	RwsWQuality rwsWQuality = null;
	ArrayList parameters=new ArrayList();
	//System.out.println("The testCode is-----------------"+testId);
	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		String query="SELECT TEST_NAME,P.TESTING_PARAMETER_CODE," +
		   "P.TESTING_PARAMETER_NAME,P.MIN_PERMISSIBLE_VALUE," +
		   "P.MAX_PERMISSIBLE_VALUE FROM RWS_WQ_PARA_TEST_TBL P," +
		   "RWS_WATER_QUALITY_TEST_TBL T " +
		   "WHERE T.TEST_CODE=P.TEST_CODE AND " +
		   "P.TEST_CODE IN (SELECT TEST_CODE FROM " +
		   "RWS_WATER_QUALITY_TEST_TBL WHERE T.TEST_ID='"+test+"')";
		//System.out.println("query is "+query);
		rs = stmt.executeQuery(query);
		while(rs.next())
		{					
			rwsWQuality = new RwsWQuality();
			
			rwsWQuality.setTestName(rs.getString(1));
			rwsWQuality.setTestPCode(rs.getString(2));
			rwsWQuality.setTestPName(rs.getString(3));
			rwsWQuality.setMinPerVal(rs.getString(4));
			rwsWQuality.setMaxPerVal(rs.getString(5));
		 	parameters.add(rwsWQuality);
			
		}
	
	}
	catch(Exception e)
	{	
		//System.out.println("Imam:  " + e);
	}
	finally
	{
		closeAll();
	}
	return parameters;
}
*/
public static ArrayList getWQTestParameterCodes(DataSource dataSource,String testCode,String testId) throws Exception
{
	RwsWQuality rwsWQuality = null;
	ArrayList parameters=new ArrayList();
	//System.out.println("The testCode is-----------------"+testCode+"testId is----"+testId);
	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		String qry = "SELECT T.TEST_NAME,P.TESTING_PARAMETER_CODE,P.TESTING_PARAMETER_NAME,P.MIN_PERMISSIBLE_VALUE,P.MAX_PERMISSIBLE_VALUE,P.UNDESIRE_EFFECT,RL.TESTING_PARAMETER_VALUE,rl.test_id FROM RWS_WQ_PARA_TEST_TBL P," +
        "RWS_WATER_QUALITY_TEST_TBL T,RWS_WQ_TEST_RESULTS_LNK_TBL RL,RWS_WQ_TEST_RESULTS_TBL WQ WHERE RL.TEST_ID=WQ.TEST_ID" +
        " AND T.TEST_CODE=WQ.TEST_CODE AND T.TEST_CODE=P.TEST_CODE AND P.TEST_CODE IN (SELECT TEST_CODE FROM RWS_WATER_QUALITY_TEST_TBL WHERE TEST_CODE='"+testCode+"')"+
        " AND P.TEST_CODE=WQ.TEST_CODE and P.TESTING_PARAMETER_CODE=RL.TESTING_PARAMETER_CODE AND WQ.TEST_ID='"+testId+"'";
	//	System.out.println("query in getWQTestParameterCodes:"+qry);
		rs=stmt.executeQuery(qry);

		while(rs.next())
		{					
			rwsWQuality = new RwsWQuality();
			rwsWQuality.setTestId(rs.getString(8));
			rwsWQuality.setTestName(rs.getString(1));
			rwsWQuality.setTestPCode(rs.getString(2));
			rwsWQuality.setTestPName(rs.getString(3));
			rwsWQuality.setMinPerVal(rs.getString(4));
			rwsWQuality.setMaxPerVal(rs.getString(5));
			rwsWQuality.setUndesirableEffect(rs.getString(6));
			rwsWQuality.setResult(rs.getString(7));								
			parameters.add(rwsWQuality);
			
		}
	
	}
	catch(Exception e)
	{	
		//System.out.println("Imam:  " + e);
	}
	finally
	{
		closeAll();
	}
	return parameters;
}
public static ArrayList getUpdatTestPCodes(DataSource dataSource,String testCode) throws Exception
{
	RwsWQuality rwsWQuality = null;
	ArrayList parameters=new ArrayList();
	//System.out.println("The testCode is-----------------"+testCode);
	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		String query="SELECT R.PREPARED_ON,WQ.TEST_NAME,P.TESTING_PARAMETER_NAME," +
		   "P.MIN_PERMISSIBLE_VALUE,P.MAX_PERMISSIBLE_VALUE," +
		   "RL.TESTING_PARAMETER_VALUE " +
		   "FROM RWS_WQ_PARA_TEST_TBL P," +
		   "RWS_WQ_TEST_RESULTS_LNK_TBL RL," +
		   "RWS_WQ_TEST_RESULTS_TBL R,RWS_WATER_QUALITY_TEST_TBL WQ WHERE " +
		   "P.TEST_CODE in " +
		   "(select test_code from RWS_WATER_QUALITY_TEST_TBL " +
		   "where test_code='"+testCode+"') and " +
		   "months_between(sysdate,FORWARDED_ON)<=36 and " +
		   "R.update_source_data='Y' " +
		   "AND RL.TEST_ID=R.TEST_ID AND " +
		   "RL.TESTING_PARAMETER_CODE=P.TESTING_PARAMETER_CODE " +
		   "AND P.TEST_CODE=R.TEST_CODE AND WQ.TEST_CODE=R.TEST_CODE";
		rs = stmt.executeQuery(query);
		//System.out.println("query is "+query);
		while(rs.next())
		{					
			rwsWQuality = new RwsWQuality();
			
			rwsWQuality.setPreparedOn(df.format(rs.getDate(1)));
			rwsWQuality.setTestName(rs.getString(2));
			rwsWQuality.setTestPName(rs.getString(3));
			rwsWQuality.setMinPerVal(rs.getString(4));
			rwsWQuality.setMaxPerVal(rs.getString(5));
			rwsWQuality.setResult(rs.getString(6));
									
			parameters.add(rwsWQuality);
			
		}
	
	}
	catch(Exception e)
	{	
		//System.out.println("getUpdatTestPCodes:  " + e);
	}
	finally
	{
		closeAll();
	}
	return parameters;
}



public static ArrayList getWQUpdatTestPCodes(DataSource dataSource,String testCode,String testId,String source) throws Exception
{
	RwsWQuality rwsWQuality = null;
	RwsWQuality rwsWQuality1 = null;
	ArrayList parameters=new ArrayList();
	ArrayList parametersnew =new ArrayList();
	//System.out.println("The testCode is-----------------"+testCode+"testId Is---"+testId);
	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		String qq = "SELECT distinct r.test_id,R.PREPARED_ON,WQ.TEST_NAME,decode(r.potable,'Y','YES','N','NO'),r.recommendations  "+
		   "FROM RWS_WQ_PARA_TEST_TBL P," +
		   "RWS_WQ_TEST_RESULTS_LNK_TBL RL," +
		   "RWS_WQ_TEST_RESULTS_TBL R,RWS_WATER_QUALITY_TEST_TBL WQ WHERE " +
		   "P.TEST_CODE in " +
		   "(select test_code from RWS_WATER_QUALITY_TEST_TBL " +
		   ") and " +
		   "months_between(sysdate,FORWARDED_ON)<=36 and " +
		   "R.update_source_data='Y' " +
		   "AND RL.TEST_ID=R.TEST_ID AND " +
		   "RL.TESTING_PARAMETER_CODE=P.TESTING_PARAMETER_CODE " +
		   "AND P.TEST_CODE=R.TEST_CODE AND WQ.TEST_CODE = R.TEST_CODE AND R.TEST_ID <> '"+testId+"' AND R.SOURCE_CODE='"+source+"'";
	//	System.out.println("query new::"+qq);
		int i = 0;
		ResultSet rs1 = stmt.executeQuery(qq);
		while(rs1.next())
		{
			rwsWQuality1 = new RwsWQuality();
			rwsWQuality1.setTestId(rs1.getString(1));
			rwsWQuality1.setPreparedOn(df.format(rs1.getDate(2)));
			rwsWQuality1.setTestName(rs1.getString(3));
			rwsWQuality1.setCondemnSource(rs1.getString(4));
			rwsWQuality1.setRecommendations(rs1.getString(5));
			
			parametersnew.add(rwsWQuality1);
		}
		String query="SELECT R.PREPARED_ON,WQ.TEST_NAME,P.TESTING_PARAMETER_NAME," +
		   "P.MIN_PERMISSIBLE_VALUE,P.MAX_PERMISSIBLE_VALUE," +
		   "RL.TESTING_PARAMETER_VALUE " +
		   "FROM RWS_WQ_PARA_TEST_TBL P," +
		   "RWS_WQ_TEST_RESULTS_LNK_TBL RL," +
		   "RWS_WQ_TEST_RESULTS_TBL R,RWS_WATER_QUALITY_TEST_TBL WQ WHERE " +
		   "P.TEST_CODE in " +
		   "(select test_code from RWS_WATER_QUALITY_TEST_TBL " +
		   "where test_code='"+testCode+"') and " +
		   "months_between(sysdate,FORWARDED_ON)<=36 and " +
		   "R.update_source_data='Y' " +
		   "AND RL.TEST_ID=R.TEST_ID AND " +
		   "RL.TESTING_PARAMETER_CODE=P.TESTING_PARAMETER_CODE " +
		   "AND P.TEST_CODE=R.TEST_CODE AND WQ.TEST_CODE = R.TEST_CODE AND R.TEST_ID <> '"+testId+"' AND R.SOURCE_CODE='"+source+"'";
		//System.out.println("query in getWQUpdatTestPCodes "+query);
		rs = stmt.executeQuery(query);
		while(rs.next())
		{					
			rwsWQuality = new RwsWQuality();
			
			rwsWQuality.setPreparedOn(df.format(rs.getDate(1)));
			rwsWQuality.setTestName(rs.getString(2));
			rwsWQuality.setTestPName(rs.getString(3));
			rwsWQuality.setMinPerVal(rs.getString(4));
			rwsWQuality.setMaxPerVal(rs.getString(5));
			rwsWQuality.setResult(rs.getString(6));
									
			parameters.add(rwsWQuality);
			
		}
	
	}
	catch(Exception e)
	{	
		//System.out.println("getUpdatTestPCodes:  " + e);
	}
	finally
	{
		closeAll();
	}
//	System.out.println("size in rwsqualitydata:"+parametersnew.size());
	return parametersnew;
}

//added by ramesh

public static ArrayList getWQUpdatTestPCodes1(DataSource dataSource,String testId) throws Exception
{
	RwsWQuality rwsWQuality = null;
	ArrayList parameters=new ArrayList();
	//System.out.println("The testCode is-----------------"+testCode+"testId Is---"+testId);
	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		/*String qq = "SELECT distinct r.test_id,R.PREPARED_ON,WQ.TEST_NAME "+
		   "FROM RWS_WQ_PARA_TEST_TBL P," +
		   "RWS_WQ_TEST_RESULTS_LNK_TBL RL," +
		   "RWS_WQ_TEST_RESULTS_TBL R,RWS_WATER_QUALITY_TEST_TBL WQ WHERE " +
		   "P.TEST_CODE in " +
		   "(select test_code from RWS_WATER_QUALITY_TEST_TBL " +
		   " and " +
		   "months_between(sysdate,FORWARDED_ON)<=36 and " +
		   "R.update_source_data='Y' " +
		   "AND RL.TEST_ID=R.TEST_ID AND " +
		   "RL.TESTING_PARAMETER_CODE=P.TESTING_PARAMETER_CODE " +
		   "AND P.TEST_CODE=R.TEST_CODE AND WQ.TEST_CODE = R.TEST_CODE AND R.TEST_ID <> '"+testId+"'";
		System.out.println("query new::"+qq);
		int i = 0;
		ResultSet rs1 = stmt.executeQuery(qq);
		while(rs1.next())
		{
			rwsWQuality1 = new RwsWQuality();
			rwsWQuality1.setTestId(rs1.getString(1));
			rwsWQuality1.setPreparedOn(df.format(rs1.getDate(2)));
			rwsWQuality1.setTestName(rs1.getString(3));
			
			parametersnew.add(rwsWQuality1);
		}*/
		/*String query="SELECT R.PREPARED_ON,WQ.TEST_NAME,P.TESTING_PARAMETER_NAME," +
		   "P.MIN_PERMISSIBLE_VALUE,P.MAX_PERMISSIBLE_VALUE," +
		   "RL.TESTING_PARAMETER_VALUE " +
		   "FROM RWS_WQ_PARA_TEST_TBL P," +
		   "RWS_WQ_TEST_RESULTS_LNK_TBL RL," +
		   "RWS_WQ_TEST_RESULTS_TBL R,RWS_WATER_QUALITY_TEST_TBL WQ WHERE " +
		   "P.TEST_CODE in " +
		   "(select test_code from RWS_WATER_QUALITY_TEST_TBL " +
		   ") and " +
		   "months_between(sysdate,FORWARDED_ON)<=36 and " +
		   "R.update_source_data='Y' " +
		   "AND RL.TEST_ID=R.TEST_ID AND " +
		   "RL.TESTING_PARAMETER_CODE=P.TESTING_PARAMETER_CODE " +
		   "AND P.TEST_CODE=R.TEST_CODE AND WQ.TEST_CODE = R.TEST_CODE AND R.TEST_ID = '"+testId+"' ";
		System.out.println("query in getWQUpdatTestPCodes "+query);
		rs = stmt.executeQuery(query);
		while(rs.next())
		{					
			rwsWQuality = new RwsWQuality();
			
			rwsWQuality.setPreparedOn(df.format(rs.getDate(1)));
			rwsWQuality.setTestName(rs.getString(2));
			rwsWQuality.setTestPName(rs.getString(3));
			rwsWQuality.setMinPerVal(rs.getString(4));
			rwsWQuality.setMaxPerVal(rs.getString(5));
			rwsWQuality.setResult(rs.getString(6));
									
			parameters.add(rwsWQuality);
			
		}*/
		String qry = "SELECT T.TEST_NAME,P.TESTING_PARAMETER_CODE,P.TESTING_PARAMETER_NAME,P.MIN_PERMISSIBLE_VALUE,P.MAX_PERMISSIBLE_VALUE,P.UNDESIRE_EFFECT,RL.TESTING_PARAMETER_VALUE,rl.test_id FROM RWS_WQ_PARA_TEST_TBL P," +
        "RWS_WATER_QUALITY_TEST_TBL T,RWS_WQ_TEST_RESULTS_LNK_TBL RL,RWS_WQ_TEST_RESULTS_TBL WQ WHERE RL.TEST_ID=WQ.TEST_ID" +
        " AND T.TEST_CODE=WQ.TEST_CODE AND T.TEST_CODE=P.TEST_CODE AND P.TEST_CODE IN (SELECT TEST_CODE FROM RWS_WATER_QUALITY_TEST_TBL )"+
        " AND P.TEST_CODE=WQ.TEST_CODE and P.TESTING_PARAMETER_CODE=RL.TESTING_PARAMETER_CODE AND WQ.TEST_ID='"+testId+"'";
	//	System.out.println("query in getWQTestParameterCodes:"+qry);
		rs=stmt.executeQuery(qry);

		while(rs.next())
		{					
			rwsWQuality = new RwsWQuality();
			rwsWQuality.setTestId(rs.getString(8));
			rwsWQuality.setTestName(rs.getString(1));
			rwsWQuality.setTestPCode(rs.getString(2));
			rwsWQuality.setTestPName(rs.getString(3));
			rwsWQuality.setMinPerVal(rs.getString(4));
			rwsWQuality.setMaxPerVal(rs.getString(5));
			rwsWQuality.setUndesirableEffect(rs.getString(6));
			rwsWQuality.setResult(rs.getString(7));								
			parameters.add(rwsWQuality);
			
		}
	
	}
	catch(Exception e)
	{	
		//System.out.println("getUpdatTestPCodes:  " + e);
	}
	finally
	{
		closeAll();
	}
//	System.out.println("size in rwsqualitydata:"+parameters.size());
	return parameters;
}
public static ArrayList getWQUpdatTestParameterCodes(DataSource dataSource,String testCode,String testId,String sourceCode) throws Exception
{
	RwsWQuality rwsWQuality = null;
	ArrayList parameters=new ArrayList();
	//System.out.println("The testCode is-----------------"+testCode+"testId Is---"+testId);
	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		String query="SELECT R.PREPARED_ON,WQ.TEST_NAME,P.TESTING_PARAMETER_NAME," +
		   "P.MIN_PERMISSIBLE_VALUE,P.MAX_PERMISSIBLE_VALUE," +
		   "RL.TESTING_PARAMETER_VALUE,RL.TEST_ID " +
		   "FROM RWS_WQ_PARA_TEST_TBL P," +
		   "RWS_WQ_TEST_RESULTS_LNK_TBL RL," +
		   "RWS_WQ_TEST_RESULTS_TBL R,RWS_WATER_QUALITY_TEST_TBL WQ WHERE " +
		   "P.TEST_CODE in " +
		   "(select test_code from RWS_WATER_QUALITY_TEST_TBL " +
		   "where test_code='"+testCode+"') and " +
		   "months_between(sysdate,FORWARDED_ON)<=36 and " +
		   "R.update_source_data='Y' " +
		   "AND RL.TEST_ID=R.TEST_ID AND " +
		   "RL.TESTING_PARAMETER_CODE=P.TESTING_PARAMETER_CODE " +
		   "AND P.TEST_CODE=R.TEST_CODE AND WQ.TEST_CODE=R.TEST_CODE AND R.SOURCE_CODE='"+sourceCode+"'" +
		   		"and rl.test_id='"+testId+"'";
	//	System.out.println("query is "+query);
		rs = stmt.executeQuery(query);
		while(rs.next())
		{					
			rwsWQuality = new RwsWQuality();
			
			rwsWQuality.setPreparedOn(df.format(rs.getDate(1)));
			rwsWQuality.setTestName(rs.getString(2));
			rwsWQuality.setTestPName(rs.getString(3));
			rwsWQuality.setMinPerVal(rs.getString(4));
			rwsWQuality.setMaxPerVal(rs.getString(5));
			rwsWQuality.setResult(rs.getString(6));
			rwsWQuality.setTestId(rs.getString(7));
									
			parameters.add(rwsWQuality);
			
		}
	
	}
	catch(Exception e)
	{	
		//System.out.println("getUpdatTestPCodes:  " + e);
	}
	finally
	{
		closeAll();
	}
	return parameters;
}



//**************************Water sample source finalisation and identification methods***********
public static int insertWQSourceFinIden(RwsWQuality rwsWQuality,DataSource dataSource) throws Exception
{
	int rowCount=0;
	if(rwsWQuality.getCoc()==null)
	{
		rwsWQuality.setCoc("00");
	}
	if(rwsWQuality.getDoc()==null)
	{
		rwsWQuality.setDoc("0");
	}
	if(rwsWQuality.getSdoc()==null)
	{
		rwsWQuality.setSdoc("00");
	}
	//System.out.println("worid="+rwsWQuality.getWorkCode()+"  coc="+rwsWQuality.getCoc()+"  doc="+rwsWQuality.getDoc());
	try
	{
		conn = dataSource.getConnection();
		stmt=conn.createStatement();
		
		//code modified on 050407
		/*
		String query="UPDATE RWS_SOURCE_IDEN_FIN_TBL SET " +
				"SUBDIVISION_OFFICE_CODE='"+rwsWQuality.getSdoc()+
				"',HAB_CODE='"+rwsWQuality.getHabCode()+
				"',SOURCE_CODE="+rwsWQuality.getSourceCode()+
				",PROGRAMME_CODE='"+rwsWQuality.getPrgmCode()+
				"',SUBPROGRAMME_CODE='"+rwsWQuality.getSubprgmCode()+
				"',CASING='"+rwsWQuality.getCasing()+
				"',DEPTH='"+rwsWQuality.getDepth()+
				"',EXPECTED_YIELD='"+rwsWQuality.getYield()+
				"',SOURCE1='"+rwsWQuality.getSource1()+
				"',DEPTH1='"+rwsWQuality.getDepth1()+
				"',YIELD1='"+rwsWQuality.getYield1()+
				"',SOURCE2='"+rwsWQuality.getSource2()+
				"',DEPTH2='"+rwsWQuality.getDepth2()+
				"',YIELD2='"+rwsWQuality.getYield2()+
				"',SOURCE3='"+rwsWQuality.getSource3()+
				"',DEPTH3='"+rwsWQuality.getDepth3()+
				"',YIELD3='"+rwsWQuality.getYield3()+
				"',EMPLOYEE_CODE='"+rwsWQuality.getEmpcode()+
				"',SITE_IDENT_DATE=TO_DATE('"+rwsWQuality.getSiteIdenData()+
				"','dd/MM/yyyy'),FINALISED ='"+rwsWQuality.getFinalised()+
				"',FINALISE_DATE=TO_DATE('"+rwsWQuality.getFinalDate()+
				"','dd/MM/yyyy'),REMARKS='"+rwsWQuality.getRemarks()+
				"',PREPARED_BY='"+rwsWQuality.getPreparedBy()+
				"',PREPARED_ON=TO_DATE('"+rwsWQuality.getPreparedOn()+
				"','dd/MM/yyyy') WHERE WORK_ID='"+rwsWQuality.getWorkCode()+
				"' AND CIRCLE_OFFICE_CODE='"+rwsWQuality.getCoc()+
				"' AND DIVISION_OFFICE_CODE='"+rwsWQuality.getDoc()+"'";
		*/
		
		String query="UPDATE RWS_SOURCE_IDEN_FIN_TBL SET " +
				"HAB_CODE='"+rwsWQuality.getHabCode()+
				"',TYPE_OF_ASSET_CODE='"+rwsWQuality.getAssetTypeCode()+
				"',ASSET_COMPONENT_CODE='"+rwsWQuality.getCompTypeCode()+
				"',ASSET_SUBCOMPONENT_CODE='"+rwsWQuality.getSubCompTypeCode()+
				"',SOURCE_CODE='"+rwsWQuality.getSourceCode()+
				"',CASING='"+rwsWQuality.getCasing()+
				"',DEPTH='"+rwsWQuality.getDepth()+
				"',EXPECTED_YIELD='"+rwsWQuality.getYield()+
				"',SOURCE1='"+rwsWQuality.getSourceCode1()+
				"',DEPTH1='"+rwsWQuality.getDepth1()+
				"',YIELD1='"+rwsWQuality.getYield1()+
				"',SOURCE2='"+rwsWQuality.getSourceCode2()+
				"',DEPTH2='"+rwsWQuality.getDepth2()+
				"',YIELD2='"+rwsWQuality.getYield2()+
				"',SOURCE3='"+rwsWQuality.getSourceCode3()+
				"',DEPTH3='"+rwsWQuality.getDepth3()+
				"',YIELD3='"+rwsWQuality.getYield3()+
				"',SITE_IDENT_DATE=TO_DATE('"+rwsWQuality.getSiteIdenData()+
				"','dd/MM/yyyy'),EMPLOYEE_CODE='"+rwsWQuality.getEmpcode()+
				"',FINALISED ='"+rwsWQuality.getFinalised()+
				"',FINALISE_DATE=TO_DATE('"+rwsWQuality.getFinalDate()+
				"','dd/MM/yyyy'),REMARKS='"+rwsWQuality.getRemarks()+
				"',OFFICE_CODE ='"+rwsWQuality.getOfficeCode()+
				"',PREPARED_BY='"+rwsWQuality.getPreparedBy()+
				"',PREPARED_ON=TO_DATE('"+rwsWQuality.getPreparedOn()+
				"','dd/MM/yyyy') WHERE WORK_ID='"+rwsWQuality.getWorkCode()+
				"' AND substr(work_id,5,2)='"+rwsWQuality.getCoc()+"'";
		//System.out.println("query is "+query);		
		rowCount=stmt.executeUpdate(query);
	}
	catch(Exception e)
	{
		//System.out.println("The error is insertWQSourceFinIden"+e.getMessage());
	}
	finally 
	{
		closeAll();
	}
	return rowCount;
}
public static RwsWQuality getWQSourceFinIden(String workCode,DataSource dataSource) throws Exception
{
	RwsWQuality rwsWQuality = null;
	try
	{
		//System.out.println("workCode%%%%%%%%%%%%%%%%%%%%%%%%%%%="+workCode);
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		
		rs =stmt.executeQuery("select FIN.*,P.PROPOSAL_NAME  WORK_NAME from RWS_SOURCE_IDEN_FIN_TBL FIN,RWS_WORK_PROPOSAL_TBL P where FIN.WORK_ID='"+workCode+"' and P.WORK_ID='"+workCode+"'");
		if ( rs.next() ) 
		{
			rwsWQuality = new RwsWQuality();
				//System.out.println("2");
				//rwsWQuality.setCoc(rs.getString(1));
				rwsWQuality.setCoc(rs.getString("office_code").substring(1,3));
				//rwsWQuality.setDoc(rs.getString(2));
			    rwsWQuality.setDoc(rs.getString("office_code").substring(3,4));
				
			    
				//rwsWQuality.setSdoc(rs.getString(3));
			    rwsWQuality.setSdoc(rs.getString("office_code").substring(4,6));
				
				rwsWQuality.setHabCode(rs.getString("hab_code"));
				
				rwsWQuality.setAssetTypeCode(rs.getString("TYPE_OF_ASSET_CODE"));
				//System.out.println("assetTypeCode in WQualityDAO is "+rs.getString("TYPE_OF_ASSET_CODE"));
				rwsWQuality.setCompTypeCode(rs.getString("ASSET_COMPONENT_CODE"));
				rwsWQuality.setSubCompTypeCode(rs.getString("ASSET_SUBCOMPONENT_CODE"));
				
				rwsWQuality.setSourceCode(rs.getString("source_code"));
				rwsWQuality.setPrgmCode(rs.getString("work_id").substring(0,2));
				rwsWQuality.setSubprgmCode(rs.getString("work_id").substring(2,4));
				rwsWQuality.setWorkCode(rs.getString("work_id")+"-"+rs.getString("WORK_NAME"));
				rwsWQuality.setCasing(rs.getString("casing"));
				rwsWQuality.setDepth(rs.getString("depth"));
				rwsWQuality.setYield(rs.getString("EXPECTED_YIELD"));
				rwsWQuality.setSourceCode1(rs.getString("source1"));
				rwsWQuality.setDepth1(rs.getString("depth1"));
				rwsWQuality.setYield1(rs.getString("yield1"));
				rwsWQuality.setSourceCode2(rs.getString("source2"));
				rwsWQuality.setDepth2(rs.getString("depth2"));
				rwsWQuality.setYield2(rs.getString("yield2"));
				rwsWQuality.setSourceCode3(rs.getString("source3"));
				rwsWQuality.setDepth3(rs.getString("depth3"));
				rwsWQuality.setYield3(rs.getString("yield3"));
				rwsWQuality.setEmpcode(rs.getString("EMPLOYEE_CODE"));
				rwsWQuality.setSiteIdenData(df.format(rs.getDate("SITE_IDENT_DATE")));
				rwsWQuality.setFinalised(rs.getString("FINALISED"));
				rwsWQuality.setFinalDate(df.format(rs.getDate("FINALISE_DATE")));
				rwsWQuality.setRemarks(rs.getString("REMARKS"));
				rwsWQuality.setPreparedBy(rs.getString("PREPARED_BY"));
				rwsWQuality.setPreparedOn(df.format(rs.getDate("PREPARED_ON")));
		}
	}
	catch (Exception e)
	{
		//System.out.println("The error in rwsWQualityData getWaterSample=  "+e);
	}
	finally 
	{
		closeAll();
	}
	return rwsWQuality;
}

public static ArrayList getWQSourceFinIdens(DataSource dataSource,String coc,String doc,String sdoc) throws Exception
{
	RwsWQuality rwsWQuality = null;
	ArrayList watersamples=new ArrayList();
	RwsLocations rwsLocations = new RwsLocations(dataSource);
	//System.out.println("coc in view="+coc+"doc in view="+doc+"sdoc in view="+sdoc);
	try
	{
		
			conn = dataSource.getConnection();
			stmt = conn.createStatement();
			/*rs =stmt.executeQuery("SELECT * FROM RWS_SOURCE_IDEN_FIN_TBL" +
					" WHERE circle_office_code='"+coc+"' and " +
					"division_office_code='"+doc+"' and subdivision_office_code='"+sdoc+"' and FINALISED IN('Y','N')");
					*/
			String query="SELECT * FROM RWS_SOURCE_IDEN_FIN_TBL" +
			" WHERE substr(office_code,2,2)='"+coc+"' and substr(office_code,4,1)='"+doc+"' and " +
			" substr(office_code,5,2)='"+sdoc+"' and FINALISED IN('Y','N')";
			//System.out.println("query is "+query);
			rs =stmt.executeQuery(query);
					
			
			
			while ( rs.next() ) 
			{
				rwsWQuality = new RwsWQuality();
				
				//rwsWQuality.setCoc(rs.getString(1));
				//rwsWQuality.setDoc(rs.getString(2));
				//rwsWQuality.setSdoc(rs.getString(3));
				rwsWQuality.setHabCode(rwsLocations.getHabName(rs.getString("hab_code"),conn));
				rwsWQuality.setSourceCode(rs.getString("source_code"));
				//rwsWQuality.setPrgmCode(RwsMasterData.getPrgmName(rs.getString(6),conn));
				//rwsWQuality.setSubprgmCode(RwsMasterData.getSubprgmName(rs.getString(6),rs.getString(7),conn));
				rwsWQuality.setWorkCode(rs.getString("WORK_ID"));
				rwsWQuality.setPrgmCode(rs.getString("WORK_ID").substring(0,2));
				rwsWQuality.setPrgmName(RwsMasterData.getPrgmName(rwsWQuality.getPrgmCode(),conn));
				rwsWQuality.setSubprgmCode(rs.getString("WORK_ID").substring(2,4));
				rwsWQuality.setSubprgmName(RwsMasterData.getSubprgmName(rwsWQuality.getPrgmCode(),rwsWQuality.getSubprgmCode(),conn));
				rwsWQuality.setCasing(rs.getString("casing"));
				rwsWQuality.setDepth(rs.getString("depth"));
				rwsWQuality.setYield(rs.getString("EXPECTED_YIELD"));
				if(rs.getString("source1")!=null)
				//rwsWQuality.setSource1(RwsMasterData.getSourceName(rs.getString("source1"),conn));
					rwsWQuality.setSource1(rs.getString("source1"));
				
				else
				rwsWQuality.setSource1("----");
				
				rwsWQuality.setDepth1(rs.getString("depth1"));
				rwsWQuality.setYield1(rs.getString("yield1"));
				if(rs.getString("source2")!=null)
				rwsWQuality.setSource2(rs.getString("source2"));
				else
				rwsWQuality.setSource2("----");
				rwsWQuality.setDepth2(rs.getString("depth2"));
				rwsWQuality.setYield2(rs.getString("yield2"));
				if(rs.getString("source3")!=null)
				rwsWQuality.setSource3(rs.getString("source3"));
				else
				rwsWQuality.setSource3("----");
				rwsWQuality.setDepth3(rs.getString("depth3"));
				rwsWQuality.setYield3(rs.getString("yield3"));
				rwsWQuality.setEmpcode(rs.getString("EMPLOYEE_CODE"));
				rwsWQuality.setOfficeCode(rs.getString("OFFICE_CODE"));
				rwsWQuality.setCoc(rs.getString("OFFICE_CODE").substring(1,3));
				rwsWQuality.setDoc(rs.getString("OFFICE_CODE").substring(3,4));
				rwsWQuality.setSdoc(rs.getString("OFFICE_CODE").substring(4,6));
				if(rs.getDate("SITE_IDENT_DATE")!=null && !rs.getDate("SITE_IDENT_DATE").equals("null"))
				 rwsWQuality.setSiteIdenData(df.format(rs.getDate("SITE_IDENT_DATE")));
				////System.out.println("finalised="+rs.getString(23));
				if(rs.getString("FINALISED")!=null && !rs.getString("FINALISED").equals("null"))
				{	
				 if(rs.getString("FINALISED").equals("Y"))
				 {
					rwsWQuality.setFinalised("YES");
				 }
				 else
				 {
					rwsWQuality.setFinalised("NO");
				 }
				} 
				else
					rwsWQuality.setFinalised("");
				if(rs.getDate("FINALISE_DATE")!=null && !rs.getDate("FINALISE_DATE").equals("null"))
				rwsWQuality.setFinalDate(df.format(rs.getDate("FINALISE_DATE")));
				rwsWQuality.setRemarks(rs.getString("REMARKS"));
				rwsWQuality.setPreparedBy(rs.getString("PREPARED_BY"));
				if(rs.getDate("PREPARED_ON")!=null && !rs.getDate("PREPARED_ON").equals("null"))
				rwsWQuality.setPreparedOn(df.format(rs.getDate("PREPARED_ON")));
				watersamples.add(rwsWQuality);
			}
		
	}
	catch (Exception e)
	{
		//System.out.println("Error In Get Method:"+e.getMessage());
	}
	finally 
	{
		closeAll();
	}
	return watersamples;
}
public static int removeWQSourceFinIdens(String workId,DataSource dataSource) throws Exception
{
	int rowCount=0;
	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		rowCount =stmt.executeUpdate("DELETE FROM RWS_SOURCE_IDEN_FIN_TBL WHERE WORK_ID='"+workId+"'");
		
	}
	catch (Exception e)
	{
		//System.out.println(e.getMessage());
	}
	finally 
	{
			closeAll();
	}
	return rowCount;
}
//****************************Drilling Status Methods*******************************************
public static int insertWQDrillStatus(RwsWQuality rwsWQuality,DataSource dataSource) throws Exception
{
	int rowCount=0;
	try
	{
		conn = dataSource.getConnection();
		stmt=conn.createStatement();
		rowCount=stmt.executeUpdate("insert into RWS_WQ_DRILLING_STATUS_TBL values('"+rwsWQuality.getWorkCode()+"','"+rwsWQuality.getDrillStatus()+"',TO_DATE('"+rwsWQuality.getDrillDate()+"','dd/mm/yyyy'),'"+rwsWQuality.getYield()+"','"+rwsWQuality.getPreparedBy()+"',TO_DATE('"+rwsWQuality.getPreparedOn()+"','dd/mm/yyyy'))");
	}
	catch(SQLException sqle)
	{	int errorCode = sqle.getErrorCode();
			if(errorCode == 1)
				errorMessage = "Record with this name exists.";
	}
	catch(Exception e)
	{
		//System.out.println("The error is"+e.getMessage());
	}
	finally 
	{
		closeAll();
	}
	return rowCount;
}
public static RwsWQuality getWQDrillStatus(String workId,DataSource dataSource) throws Exception
{
	RwsWQuality rwsWQuality = null;
		
	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		rs =stmt.executeQuery("SELECT * FROM RWS_WQ_DRILLING_STATUS_TBL WHERE WORK_CODE="+workId);
		if ( rs.next() ) 
		{
			rwsWQuality = new RwsWQuality();

			rwsWQuality.setWorkCode(rs.getString(1));
			rwsWQuality.setDrillStatus(rs.getString(2));
			rwsWQuality.setDrillDate(df.format(rs.getDate(3)));
			rwsWQuality.setYield(rs.getString(4));
			rwsWQuality.setPreparedBy(rs.getString(5));
			rwsWQuality.setPreparedOn(df.format(rs.getDate(6)));
		}
	}
	catch (Exception e)
	{
		//System.out.println("The error is in getWQDrillStatus="+e);
	}
	finally 
	{
		closeAll();
	}
	return rwsWQuality;
}
public static ArrayList getWQDrillStatuss(String empcode,DataSource dataSource) throws Exception
{
	RwsWQuality rwsWQuality = null;
	ArrayList wqDrillStatus=new ArrayList();
	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		rs =stmt.executeQuery("SELECT WORK_CODE,DECODE(DRILLING,'1','ONGOING','2','COMPLETED','3','DEFFERED','4','NOTINITIATED'),TO_CHAR(DRILLED_DATE,'DD/MM/YYYY'),YIELD,PREPARED_BY,PREPARED_ON FROM RWS_WQ_DRILLING_STATUS_TBL  WHERE PREPARED_BY='"+empcode+"' ORDER BY WORK_CODE");
		while ( rs.next() ) 
		{
			rwsWQuality = new RwsWQuality();
			
			rwsWQuality.setWorkCode(rs.getString(1));
			rwsWQuality.setDrillStatus(rs.getString(2));
			rwsWQuality.setDrillDate(rs.getString(3));
			rwsWQuality.setYield(rs.getString(4));
			rwsWQuality.setPreparedBy(rs.getString(5));
			rwsWQuality.setPreparedOn(df.format(rs.getDate(6)));

			wqDrillStatus.add(rwsWQuality);
		}
	}
	catch (Exception e)
	{
		//System.out.println("The error is in getWQDrillStatuss="+e);
	}
	finally 
	{
		closeAll();
	}
	return wqDrillStatus;
}
public static int removeWQDrillStatus(String workId,DataSource dataSource) throws Exception
{
	int rowCount=0;
	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		rowCount =stmt.executeUpdate("DELETE FROM RWS_WQ_DRILLING_STATUS_TBL WHERE WORK_CODE='"+workId+"'");
		
	}
	catch (Exception e)
	{
		//System.out.println("The error is in removeWQDrillStatus="+e);
	}
	finally 
	{
			closeAll();
	}
	return rowCount;
}
public static void updateWQDrillStatus(RwsWQuality rwsWQuality,DataSource dataSource) throws Exception
{
	try
	{
		conn = dataSource.getConnection();
					
		stmt=conn.createStatement();
		stmt.executeUpdate("update RWS_WQ_DRILLING_STATUS_TBL set DRILLING='"+rwsWQuality.getDrillStatus()+"',DRILLED_DATE=TO_DATE('"+rwsWQuality.getDrillDate()+"','dd/mm/yyyy'),YIELD='"+rwsWQuality.getYield()+"' where WORK_CODE='"+rwsWQuality.getWorkCode()+"'");
			
	}
	catch (Exception e)
	{
		//System.out.println("The error is in updateWQDrillStatus="+e);
	}
	finally 
	{
		closeAll();
	}
}
public static ArrayList getWQFinalStatus(String workCode,DataSource dataSource) throws Exception
{
	RwsWQuality rwsWQuality = null;
	ArrayList wqFianlStatus=new ArrayList();
	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		//String query="select sif.work_id,to_char(ADMIN_DATE,'dd/mm/yyyy'),p.panch_name,s.source_name,p.programme_name,su.subprogramme_name,to_char(SITE_IDENT_DATE,'dd/mm/yyyy'),to_char(FINALISE_DATE,'dd/mm/yyyy'),p.user_id  from rws_source_iden_fin_tbl sif,rws_panchayat_raj_tbl p,rws_source_tbl s,rws_programme_tbl p,rws_subprogramme_tbl su,RWS_WORK_PROPOSAL_TBL w,rws_password_tbl p where sif.hab_code=p.panch_code and sif.source_code=s.source_code and p.programme_code=sif.programme_code and sif.subprogramme_code=su.subprogramme_code and sif.programme_code=su.programme_code and sif.prepared_by=p.user_id and sif.work_id=w.work_id and sif.work_id='"+workCode+"'";
		String query="select sif.work_id,to_char(ADMIN_DATE,'dd/mm/yyyy'),p.panch_name,sif.source_code,p.programme_name,su.subprogramme_name,to_char(SITE_IDENT_DATE,'dd/mm/yyyy'),to_char(FINALISE_DATE,'dd/mm/yyyy'),p.user_id  from rws_source_iden_fin_tbl sif,rws_panchayat_raj_tbl p,rws_programme_tbl p,rws_subprogramme_tbl su,RWS_WORK_PROPOSAL_TBL w,rws_password_tbl p where sif.hab_code=p.panch_code and p.programme_code=sif.programme_code and sif.subprogramme_code=su.subprogramme_code and sif.programme_code=su.programme_code and sif.prepared_by=p.user_id and sif.work_id=w.work_id and sif.work_id='"+workCode+"'";
		rs =stmt.executeQuery(query);
		while ( rs.next() ) 
		{
			rwsWQuality = new RwsWQuality();
			
			rwsWQuality.setWorkCode(rs.getString(1));
			rwsWQuality.setDrillDate(rs.getString(2));
			rwsWQuality.setHabName(rs.getString(3));
			rwsWQuality.setSourceName(rs.getString(4));
			rwsWQuality.setPrgmName(rs.getString(5));
			rwsWQuality.setSubprgmName(rs.getString(6));
			rwsWQuality.setSiteIdenData(rs.getString(7));
			rwsWQuality.setFinalDate(rs.getString(8));
			rwsWQuality.setPreparedBy(rs.getString(9));
			
			wqFianlStatus.add(rwsWQuality);
		}
	}
	catch (Exception e)
	{
		//System.out.println("The error is in getWQFinalStatus="+e);
	}
	finally 
	{
		closeAll();
	}
	return wqFianlStatus;
}
public static ArrayList getLabAssistants(DataSource dataSource,String officeCode) throws Exception
{
	RwsWQuality rwsWQuality = null;
	ArrayList labAssists=new ArrayList();
	try
	{
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		rs =stmt.executeQuery("SELECT USER_ID " +
							  "FROM RWS_PASSWORD_TBL WHERE DESIGNATION_CODE='13' " +
							  "AND OFFICE_CODE='"+officeCode+"'");
		while ( rs.next() ) 
		{
			rwsWQuality = new RwsWQuality();
			
			rwsWQuality.setEmpcode(rs.getString(1));
			 
						
			labAssists.add(rwsWQuality);
		}
	}
	catch (Exception e)
	{
		//System.out.println("The error is in getLabAssistants="+e);
	}
	finally 
	{
		closeAll();
	}
	return labAssists;
}
public static ArrayList getForwardedTests(DataSource dataSource,String officeCode,String desgnName,String circle,String division) throws Exception
{
	RwsWQuality rwsWQuality = null;
	ArrayList forwardTests=new ArrayList();
	//System.out.println("Designation in getForwardedTests is===="+desgnName);
	
		try
		{
			if(!desgnName.equalsIgnoreCase("LAB ASST."))
			{
			//System.out.println("empcode in getForwardedTests is===="+officeCode);
			
			conn = dataSource.getConnection();
			stmt = conn.createStatement();
			stmt2 = conn.createStatement();
			
			/*
			 String query="select distinct ws.test_id," +
			"to_char(ws.prepared_on,'dd/mm/yyyy')," +
			"to_char(ws.SAMP_COLLECT_DATE,'dd/mm/yyyy')," +
			"pr.panch_name,ws.source_code,t.test_name,ws.SAMP_COLLECTOR_CODE," +
			"to_char(sysdate,'dd/mm/yyyy') " +
			"from RWS_WATER_SAMPLE_COLLECT_TBL ws,RWS_PASSWORD_TBL p," +
			"rws_water_quality_lab_tbl l," +
			"rws_water_quality_test_tbl t,rws_panchayat_raj_tbl pr" +
			" where designation_code!='13' and l.lab_code=ws.lab_code and ws.prepared_by=p.user_id" +
			"  and t.test_code=ws.test_code" +
			" and ws.hab_code=pr.panch_code  " +
			" and test_id not in(select test_id from rws_wq_geologist_test_tbl)" +
			" and l.office_code='"+officeCode+"'";
			*/
			/* String query="select distinct ws.test_id," +
				"to_char(ws.prepared_on,'dd/mm/yyyy')," +
				"to_char(ws.SAMP_COLLECT_DATE,'dd/mm/yyyy')," +
				"pr.panch_name,ws.source_code,t.test_name,ws.SAMP_COLLECTOR_CODE," +
				"to_char(sysdate,'dd/mm/yyyy'),ws.SOURCE_TYPE  " +
				"from RWS_WATER_SAMPLE_COLLECT_TBL ws,RWS_PASSWORD_TBL p," +
				"rws_water_quality_lab_tbl l," +
				"rws_water_quality_test_tbl t,rws_panchayat_raj_tbl pr" +
				" where designation_code!='13' and l.lab_code=ws.lab_code and ws.prepared_by=p.user_id" +
				"  and t.test_code=ws.test_code" +
				" and ws.hab_code=pr.panch_code  " +
				" and test_id not in(select test_id from RWS_WQ_TEST_RESULTS_TBL)" +
				" and substr(ws.prepared_by,1,4)=substr('"+officeCode+"',1,4)" +
				" and ws.source_type is not null" +
				" order by to_char(ws.prepared_on,'dd/mm/yyyy')";*/
			 //String qry = "select distinct ws.test_id,to_char(ws.prepared_on,'dd/mm/yyyy'),to_char (ws.SAMP_COLLECT_DATE,'dd/mm/yyyy'),pr.panch_name,ws.source_code,t.test_name,ws.SAMP_COLLECTOR_CODE,to_char (sysdate,'dd/mm/yyyy'),ws.SOURCE_TYPE,l.lab_name,d.division_office_name from RWS_WATER_SAMPLE_COLLECT_TBL ws,RWS_PASSWORD_TBL p,rws_division_office_tbl d,rws_water_quality_lab_tbl l,rws_water_quality_test_tbl t,rws_panchayat_raj_tbl pr where ws.circle_office_code='"+circle+"' and ws.division_office_code='"+division+"' and d.circle_office_code=ws.circle_office_code and d.division_office_code = ws.division_office_code and l.lab_code=ws.lab_code and t.test_code=ws.test_code and ws.hab_code=pr.panch_code and test_id not in(select test_id from RWS_WQ_TEST_RESULTS_TBL) and ws.source_type is not null order by to_char (ws.prepared_on,'dd/mm/yyyy')";
			 String qry = "select distinct ws.test_id, d.division_office_name, l.lab_name, to_char (ws.SAMP_COLLECT_DATE,'dd/mm/yyyy'), pr.panch_name, ws.SOURCE_TYPE, ws.source_code, t.test_name, desg.DESIGNATION_ACR from RWS_WATER_SAMPLE_COLLECT_TBL ws,RWS_PASSWORD_TBL p,rws_division_office_tbl d,rws_water_quality_lab_tbl l,rws_water_quality_test_tbl t,rws_panchayat_raj_tbl pr,RWS_DESIGNATION_TBL desg where ws.circle_office_code='"+circle+"' and ws.division_office_code='"+division+"' and d.circle_office_code=ws.circle_office_code and d.division_office_code = ws.division_office_code and l.lab_code=ws.lab_code and t.test_code=ws.test_code and ws.hab_code=pr.panch_code and desg.designation_code=ws.samp_collector_code and test_id not in(select test_id from RWS_WQ_TEST_RESULTS_TBL) and ws.source_type is not null order by to_char (ws.SAMP_COLLECT_DATE,'dd/mm/yyyy')";
			 //System.out.println("query in get forwarded tests:"+qry);
			 //System.out.println("query in get forwarded tests:"+query);
			 rs =stmt.executeQuery(qry);
			 while ( rs.next() ) 
			 {
				rwsWQuality = new RwsWQuality();
				rwsWQuality.setCheckedTest(rs.getString(1));
				rwsWQuality.setTestId(rs.getString(1));
				rwsWQuality.setDivisionOfficeName(rs.getString(2));
				rwsWQuality.setLabName(rs.getString(3));
				rwsWQuality.setSampCollectDate(rs.getString(4));
				rwsWQuality.setHabCode(rs.getString(5));
				if(rs.getString("SOURCE_TYPE")!=null)
					rwsWQuality.setSourceType(getSourceName(rs.getString("SOURCE_TYPE")));
				else
					rwsWQuality.setSourceType("");
				rwsWQuality.setSourceCode(rs.getString(7));
				rwsWQuality.setTestCode(rs.getString(8));
				rwsWQuality.setSampCollectCode(rs.getString(9));
				forwardTests.add(rwsWQuality);
			}
		}
	}
	catch (Exception e)
	{
		//System.out.println("The error in getForwardedTests is ==="+e.getMessage());
	}
	finally 
	{
		closeAll();
	}
	return forwardTests;
}
public static ArrayList getTestsSubmittedToSubdivision(DataSource dataSource,String officeCode,String desgnName,String selectedMonth,String selectedYear,String circle,String division) throws Exception
{
	RwsWQuality rwsWQuality = null;
	ArrayList submittedTests=new ArrayList();
	//System.out.println("Circle in getForwardedTests is===="+circle);
//	System.out.println("division Code is "+division);
	
		try
		{
			//code added
			//for division office
			
				//System.out.println("in EE");
				conn = dataSource.getConnection();
				stmt = conn.createStatement();
							
				String query="select distinct ws.test_id,ws.prepared_on," +
						"to_char(wt.forwarded_on,'dd/mm/yyyy')prepared_on1," +
						"pr.panch_name,ws.source_code,t.test_name," +
						"wt.prepared_by,to_char(wt.prepared_on,'dd/mm/yyyy')prepared_on," +
						"to_char(sysdate,'dd/mm/yyyy')sys_date,ws.SOURCE_TYPE,  " +
						"decode(wt.update_source_data,'y','YES','Y','YES','n','NO','N','NO')as update_source_data,wt.RECOMMENDATIONS "+
						"from RWS_WATER_SAMPLE_COLLECT_TBL ws,RWS_PASSWORD_TBL p," +
						"RWS_WQ_TEST_RESULTS_TBL wt,RWS_WQ_TEST_RESULTS_lnk_TBL wlt," +
						"rws_water_quality_test_tbl t,rws_panchayat_raj_tbl pr " +
						"where  wt.test_id=wlt.test_id and p.user_id=wt.prepared_by " +
						"and ws.test_code=t.test_code and ws.test_id=wt.test_id " +
						"and pr.panch_code=ws.hab_code and ws.test_id in " +
						"(select test_id from RWS_WQ_TEST_RESULTS_TBL) " +
						"AND WS.CIRCLE_OFFICE_CODE='"+circle+"' AND WS.DIVISION_OFFICE_CODE='"+division+"' " +
						"and ws.source_type is not null";
				if(selectedMonth.equals("ALL"))
				{
					query += " and to_char(ws.prepared_on,'yyyy')='"+selectedYear+"'";
				}
				else
				{
					query += " and to_char(ws.prepared_on,'mm/yyyy')='"+selectedMonth+"/"+selectedYear+"'";
				}
				query += "order by ws.prepared_on desc";
					
			//	System.out.println("query is"+query);
				rs =stmt.executeQuery(query);
				while ( rs.next() ) 
				{
					//System.out.println("source type is "+rs.getString("SOURCE_TYPE"));
					//System.out.println("rs.next()");
					rwsWQuality = new RwsWQuality();
					
					rwsWQuality.setCheckedTest(rs.getString("test_id"));
					rwsWQuality.setTestId(rs.getString("test_id"));
					rwsWQuality.setDateAssignedFromDiv(rs.getString("prepared_on1"));
					rwsWQuality.setHabCode(rs.getString("panch_name"));
					rwsWQuality.setSourceCode(rs.getString("source_code"));
					rwsWQuality.setTestCode(rs.getString("test_name"));
					//the following line should be modified
					rwsWQuality.setForwadedOn("");
					rwsWQuality.setForwadedTo(rs.getString("prepared_by"));
					rwsWQuality.setResultObtainOn(rs.getString("prepared_on"));
					rwsWQuality.setResultForwardOn(rs.getString("sys_date"));
					rwsWQuality.setUpdateSource(rs.getString("UPDATE_SOURCE_DATA"));
					rwsWQuality.setRecommendations(rs.getString("RECOMMENDATIONS"));
					//System.out.println("source name is "+getSourceName(rs.getString("SOURCE_TYPE")));
					
					if(rs.getString("SOURCE_TYPE")!=null)
					rwsWQuality.setSourceType(getSourceName(rs.getString("SOURCE_TYPE")));
					else
					rwsWQuality.setSourceType("");
					submittedTests.add(rwsWQuality);
					//System.out.println("added");
				}
				//System.out.println("out of while");
			
			//end of code added
			
	}
	catch (Exception e)
	{
		//System.out.println("The error in getTestsSubmittedToSubdivision is ==="+e);
	}
	finally 
	{
		closeAll();
	}
	return submittedTests;
}


public static ArrayList getTestResults(DataSource dataSource,String testId) throws Exception
{
	RwsWQuality rwsWQuality = null;
	ArrayList testResults=new ArrayList();
	
		try
		{
			//code added
			//for division office
				conn = dataSource.getConnection();
				stmt = conn.createStatement();
				String query="select testResults.test_id," +
						"params.TESTING_PARAMETER_CODE," +
						"params.TESTING_PARAMETER_NAME," +
						"params.MIN_PERMISSIBLE_VALUE," +
						"params.MAX_PERMISSIBLE_VALUE," +
						"params.UNDESIRE_EFFECT, "+
						"testLink.TESTING_PARAMETER_VALUE " +
						"from RWS_WQ_TEST_RESULTS_TBL testResults," +
						"RWS_WQ_PARA_TEST_TBL  params," +
						"RWS_WQ_TEST_RESULTS_LNK_TBL testLink " +
						"where testResults.test_id=testLink.test_id " +
						"and testResults.test_code=params.test_code " +
						"and testResults.test_id='"+testId+"' " +
						"and params.TESTING_PARAMETER_CODE =testLink.TESTING_PARAMETER_CODE " +
						"order by testResults.test_Id," +
						"params.test_code,params.TESTING_PARAMETER_CODE";


				//ArrayList testingParameterValues = new ArrayList();
				//System.out.println("query is "+query);
				rs =stmt.executeQuery(query);
				int i = 0;
				while ( rs.next() ) 
				{
					//System.out.println("rs.next()");
					rwsWQuality = new RwsWQuality();
					
					rwsWQuality.setTestingParameterCode(rs.getString("TESTING_PARAMETER_CODE"));
					rwsWQuality.setTestingParameterName(rs.getString("TESTING_PARAMETER_NAME"));
					rwsWQuality.setMinPermissibleValue(rs.getString("MIN_PERMISSIBLE_VALUE"));
					rwsWQuality.setMaxPermissibleValue(rs.getString("MAX_PERMISSIBLE_VALUE"));
					rwsWQuality.setTestingParameterValue(rs.getString("TESTING_PARAMETER_VALUE"));
					rwsWQuality.setUndesirableEffect(rs.getString("UNDESIRE_EFFECT"));
					testResults.add(rwsWQuality);
					//testingParameterValues.add(i++,rs.getString("TESTING_PARAMETER_VALUE"));
					//System.out.println("added");
				}
				//System.out.println("TESTING_PARAMETER_VALUEs::"+testingParameterValues.size());
			
			//end of code added
			
	}
	catch (Exception e)
	{
		//System.out.println("The error in getTestResults is ==="+e);
	}
	finally 
	{
		closeAll();
	}
	return testResults;
}




//************************Water Sample Geologist Forwarded Tests******************************

public static int[] insertSampleGeoTestsForward(RwsWQuality rwsWQuality,ArrayList checkedTests,DataSource dataSource) throws Exception
{
	int [] rowCount = new int[5];
	SampleForwardGeoTests sampleForwardGeoTests =new SampleForwardGeoTests();
	if(rwsWQuality.getCoc()==null)
	{
		rwsWQuality.setCoc("00");
	}
	if(rwsWQuality.getDoc()==null)
	{
		rwsWQuality.setDoc("0");
	}
	if(rwsWQuality.getSdoc()==null)
	{
		rwsWQuality.setSdoc("00");
	}
	try
	{
		conn = dataSource.getConnection();
		conn.setAutoCommit(false);
		stmt=conn.createStatement();
		String query="";
		//System.out.println("rwsWQuality.getRoc()="+rwsWQuality.getRoc()+"size="+checkedTests.size());
		
		for (int i=0;i<checkedTests.size();i++)
		{
			sampleForwardGeoTests = (SampleForwardGeoTests)checkedTests.get(i);	
			if(sampleForwardGeoTests.getCheckedTest() != null)
			{
				//System.out.println("######### Record No : " + (i+1) + " ##########");
				//System.out.println("######### sampleForwardGeoTests.getCheckedTest() : " + sampleForwardGeoTests.getCheckedTest() + " ##########");
				//System.out.println("######### sampleForwardGeoTests.getTestId() : " + sampleForwardGeoTests.getTestId() + " ##########");
				query="insert into rws_wq_geologist_test_tbl values" +
					"('"+sampleForwardGeoTests.getTestId()+"'," +
					"'"+rwsWQuality.getRoc()+"'," +
					"'"+sampleForwardGeoTests.getTestId().substring(0,2)+"'," +
					"'"+rwsWQuality.getPreparedBy()+"'," +
					"TO_DATE('"+sampleForwardGeoTests.getDateAssignedFromDiv()+"'," +
					"'dd/MM/yyyy'),TO_DATE('"+sampleForwardGeoTests.getForwadedOn()+"','dd/MM/yyyy')," +
					"'"+sampleForwardGeoTests.getForwadedTo()+"','','','','"+rwsWQuality.getPreparedBy()+"'," +
					"TO_DATE('"+rwsWQuality.getPreparedOn()+"','dd/mm/yyyy'))";
				//System.out.println("query="+query);
				stmt.addBatch(query);
			}
		}
		rowCount = stmt.executeBatch();
		conn.commit();
		
	}
	catch(Exception e)
	{
		//System.out.println("The error is in RwsWQualityData insertSampleGeoTestsForward "+e.getMessage());
	}
	finally 
	{
		closeAll();
	}
	//System.out.println("rowcount="+rowCount.length);
	return rowCount;
}
public static int[] insertResultsSubmittedToSubdivision(RwsWQuality rwsWQuality,ArrayList checkedTests,DataSource dataSource) throws Exception
{
	int [] rowCount = new int[5];
	SampleForwardGeoTests sampleForwardGeoTests =new SampleForwardGeoTests();
	
	//System.out.println("in insertResultsSubmittedToSubdivision()");
	if(rwsWQuality.getCoc()==null)
	{
		rwsWQuality.setCoc("00");
	}
	if(rwsWQuality.getDoc()==null)
	{
		rwsWQuality.setDoc("0");
	}
	if(rwsWQuality.getSdoc()==null)
	{
		rwsWQuality.setSdoc("00");
	}
	try
	{
		conn = dataSource.getConnection();
		conn.setAutoCommit(false);
		stmt=conn.createStatement();
		//System.out.println("rwsWQuality.getRoc()="+rwsWQuality.getRoc()+"checked test size="+checkedTests.size());
		
		for (int i=0;i<checkedTests.size();i++)
		{
			////System.out.println("in for");
			sampleForwardGeoTests = (SampleForwardGeoTests)checkedTests.get(i);	
			if(sampleForwardGeoTests.getCheckedTest() != null)
			{
				
				//System.out.println("######### Record No : " + (i+1) + " ##########");
				//System.out.println("######### sampleForwardGeoTests.getCheckedTest() : " + sampleForwardGeoTests.getCheckedTest() + " ##########");
				//System.out.println("######### sampleForwardGeoTests.getTestId() : " + sampleForwardGeoTests.getTestId() + " ##########");
				//System.out.println("testid="+sampleForwardGeoTests.getTestId()+"office="+rwsWQuality.getRoc()+"labcode="+sampleForwardGeoTests.getTestId().substring(0,2));
				//System.out.println("ASSIGNED_BY="+rwsWQuality.getPreparedBy()+"ASSIGNED_FROM_DATE="+sampleForwardGeoTests.getDateAssignedFromDiv()+"ASSIGNED_TO_DATE="+sampleForwardGeoTests.getForwadedOn()+"ASSIGNED_TO="+sampleForwardGeoTests.getForwadedTo());
				//System.out.println("RESULT_OBTAIN_DATE="+sampleForwardGeoTests.getResultObtainOn()+"FORWARDED_DATE="+sampleForwardGeoTests.getResultForwardOn()+"OFFICE_FORWARD="+sampleForwardGeoTests.getSubdivision()+"PREPARED_BY ="+rwsWQuality.getPreparedBy()+"PREPARED_ON="+rwsWQuality.getPreparedOn());
				String query="update rws_wq_geologist_test_tbl set OFFICE_CODE=" +
				"'"+rwsWQuality.getRoc()+"',LAB_CODE=" +
				"'"+sampleForwardGeoTests.getTestId().substring(0,2)+"',ASSIGNED_BY=" +
				"'"+rwsWQuality.getPreparedBy()+"',ASSIGNED_FROM_DATE=" +
				"TO_DATE('"+sampleForwardGeoTests.getDateAssignedFromDiv()+"'," +
				"'dd/MM/yyyy'),ASSIGNED_TO_DATE=TO_DATE('"+sampleForwardGeoTests.getForwadedOn()+"','dd/MM/yyyy'),ASSIGNED_TO=" +
				"'"+sampleForwardGeoTests.getForwadedTo()+"',RESULT_OBTAIN_DATE=TO_DATE('"+sampleForwardGeoTests.getResultObtainOn()+"','dd/MM/yyyy'),FORWARDED_DATE=TO_DATE('"+sampleForwardGeoTests.getResultForwardOn()+"','dd/MM/yyyy'),OFFICE_FORWARD='"+sampleForwardGeoTests.getSubdivision()+"',PREPARED_BY='"+rwsWQuality.getPreparedBy()+"',PREPARED_ON=" +
				"TO_DATE('"+rwsWQuality.getPreparedOn()+"','dd/mm/yyyy') where TEST_ID='"+sampleForwardGeoTests.getTestId()+"'";
				//System.out.println("query is "+query);
				stmt.addBatch(query);
			}
		}
		rowCount = stmt.executeBatch();
		conn.commit();
		
	}
	catch(Exception e)
	{
		//System.out.println("The error is in RwsWQualityData insertSampleGeoTestsForward "+e.getMessage());
	}
	finally 
	{
		closeAll();
	}
	//System.out.println("rowcount="+rowCount.length);
	return rowCount;
}

public static String getSourceName(String sourceType)
{
	String sourceName="";
	if(sourceType==null||sourceType.equals(""))
	sourceName="";
	if(sourceType.equals("0101001"))
	sourceName="PWS SUBSURFACE SOURCE";
	if(sourceType.equals("0101002"))
	sourceName="PWS SURFACE SOURCE";
	if(sourceType.equals("0101003"))
	sourceName="PWS PUMPSETS";
	if(sourceType.equals("0201001"))
	sourceName="MPWS SUBSURFACE SOURCE";
	if(sourceType.equals("0201002"))
	sourceName="MPWS SURFACE SOURCE";
	if(sourceType.equals("0201003"))
	sourceName="MPWS PUMPSETS";
	if(sourceType.equals("0301001"))
	sourceName="CPWS SUBSURFACE SOURCE";
	if(sourceType.equals("0301002"))
	sourceName="CPWS SURFACE SOURCE";
	if(sourceType.equals("0101001"))
	sourceName="CPWS PUMPSETS";
	if(sourceType.equals("0401001"))
	sourceName="HANDPUMPS BOREWELL";
	if(sourceType.equals("0501001"))
	sourceName="SHALLOW HANDPUMPS";
	if(sourceType.equals("0601001"))
	sourceName="OPEN WELLS";
	if(sourceType.equals("0701001"))
	sourceName="PONDS";
	
	return sourceName;

}

public static String getSourceType(String sourceCode)
{
	String sourceType;
	SubCompMetaData subCompMetaData=new SubCompMetaData(sourceCode);
	sourceType=subCompMetaData.getTypeOfAssetCode()+subCompMetaData.getAssetCompTypeCode()+subCompMetaData.getAssetSubCompTypeCode();
	return sourceType;
	
}

public static ArrayList  getSourceCodes(DataSource dataSource,String sourceType,String habCode) throws Exception
{
	RwsMaster rwsMaster = null;
	ArrayList sourceCodes = new ArrayList();
	SubCompMetaData subCompMetaData=new SubCompMetaData(sourceType.substring(0,2),sourceType.substring(2,4),sourceType.substring(4,7));
	
	
	try {
		
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		String query="";
		//for source
		if((sourceType.substring(0,2).equals("01")||sourceType.substring(0,2).equals("02")||sourceType.substring(0,2).equals("03"))
				&&(sourceType.substring(2,4).equals("01") && !sourceType.substring(4,7).equals("003")))
		{
			if(sourceType.substring(4,7).equals("001"))
				query="SELECT "+subCompMetaData.getSchemeCodeField()+" from "+subCompMetaData.getTableName()+" where substr("+subCompMetaData.getSchemeCodeField()+",1,16)='"+habCode+"' and source_type_code=1 and substr("+subCompMetaData.getSchemeCodeField()+",17,3) like '"+subCompMetaData.getSchemeCodeSeries().substring(0,1)+"%'";
			else if(sourceType.substring(4,7).equals("002"))
				query="SELECT "+subCompMetaData.getSchemeCodeField()+" from "+subCompMetaData.getTableName()+" where substr("+subCompMetaData.getSchemeCodeField()+",1,16)='"+habCode+"' and source_type_code=2 and substr("+subCompMetaData.getSchemeCodeField()+",17,3) like '"+subCompMetaData.getSchemeCodeSeries().substring(0,1)+"%'";
		}
		else if((sourceType.substring(0,2).equals("04")))
		{
			query="SELECT "+subCompMetaData.getSchemeCodeField()+" from "+subCompMetaData.getTableName()+" where substr("+subCompMetaData.getSchemeCodeField()+",1,16)='"+habCode+"' and substr("+subCompMetaData.getSchemeCodeField()+",17,3) like '"+"0"+"%'";
		}
		else
			query="SELECT "+subCompMetaData.getSchemeCodeField()+" from "+subCompMetaData.getTableName()+" where substr("+subCompMetaData.getSchemeCodeField()+",1,16)='"+habCode+"' and substr("+subCompMetaData.getSchemeCodeField()+",17,3) like '"+subCompMetaData.getSchemeCodeSeries().substring(0,1)+"%'";	
		//System.out.println("query is "+query);
		rs = stmt.executeQuery(query);
		while (rs.next()) {
			rwsMaster = new RwsMaster();
			//System.out.println("sourceCode in rwsWQualityData is "+rs.getString(1));
			rwsMaster.setSourceCode(rs.getString(1));
			
			sourceCodes.add(rwsMaster);
		}
	} catch (Exception e) {
		//System.out.println(e.getMessage());
	} finally {
		closeAll();
	}
	return sourceCodes;
}

public static ArrayList  getSourceCodesWithLocation(DataSource dataSource,String sourceType,String habCode) throws Exception
{
	RwsMaster rwsMaster = null;
	ArrayList sourceCodes = new ArrayList();
	SubCompMetaData subCompMetaData=new SubCompMetaData(sourceType.substring(0,2),sourceType.substring(2,4),sourceType.substring(4,7));
	String subCompRep=subCompMetaData.getSubCompRep();
	
	try {
		
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		String query="";
		//for source
		if((sourceType.substring(0,2).equals("01")||sourceType.substring(0,2).equals("02")||sourceType.substring(0,2).equals("03"))
				&&(sourceType.substring(2,4).equals("01") && !sourceType.substring(4,7).equals("003")))
		{
			if(sourceType.substring(4,7).equals("001"))
				query="SELECT "+subCompMetaData.getSchemeCodeField()+",location from "+subCompMetaData.getTableName()+" where substr("+subCompMetaData.getSchemeCodeField()+",1,16)='"+habCode+"' and source_type_code=1 and substr("+subCompMetaData.getSchemeCodeField()+",17,3) like '"+subCompMetaData.getSchemeCodeSeries().substring(0,1)+"%' and substr("+subCompMetaData.getSchemeCodeField()+",20,2)= '"+subCompRep+"'";
			else if(sourceType.substring(4,7).equals("002"))
				query="SELECT "+subCompMetaData.getSchemeCodeField()+",location from "+subCompMetaData.getTableName()+" where substr("+subCompMetaData.getSchemeCodeField()+",1,16)='"+habCode+"' and source_type_code=2 and substr("+subCompMetaData.getSchemeCodeField()+",17,3) like '"+subCompMetaData.getSchemeCodeSeries().substring(0,1)+"%' and substr("+subCompMetaData.getSchemeCodeField()+",20,2)= '"+subCompRep+"'";
		}
		else if((sourceType.substring(0,2).equals("04")))
		{
			query="SELECT "+subCompMetaData.getSchemeCodeField()+",location from "+subCompMetaData.getTableName()+" where substr("+subCompMetaData.getSchemeCodeField()+",1,16)='"+habCode+"' and substr("+subCompMetaData.getSchemeCodeField()+",17,3) like '0%' and substr("+subCompMetaData.getSchemeCodeField()+",20,2)= '"+subCompRep+"'";
		}
		else if((sourceType.substring(0,2).equals("07")))
		{
			query="SELECT "+subCompMetaData.getSchemeCodeField()+",pond_location from "+subCompMetaData.getTableName()+" where substr("+subCompMetaData.getSchemeCodeField()+",1,16)='"+habCode+"' and substr("+subCompMetaData.getSchemeCodeField()+",17,3) like '7%' and substr("+subCompMetaData.getSchemeCodeField()+",20,2)= '"+subCompRep+"'";
		}
		else
			query="SELECT "+subCompMetaData.getSchemeCodeField()+",location from "+subCompMetaData.getTableName()+" where substr("+subCompMetaData.getSchemeCodeField()+",1,16)='"+habCode+"' and substr("+subCompMetaData.getSchemeCodeField()+",17,3) like '"+subCompMetaData.getSchemeCodeSeries().substring(0,1)+"%' and substr("+subCompMetaData.getSchemeCodeField()+",20,2)= '"+subCompRep+"'";	
		//System.out.println("query is "+query);
		rs = stmt.executeQuery(query);
		while (rs.next()) {
			rwsMaster = new RwsMaster();
			//System.out.println("sourceCode in rwsWQualityData is "+rs.getString(1));
			rwsMaster.setSourceCode(rs.getString(1));
			if(rs.getString(2)!=null)
				rwsMaster.setSourceAndLocation(rs.getString(1)+" At "+rs.getString(2));
			else
				rwsMaster.setSourceAndLocation(rs.getString(1));
			
			sourceCodes.add(rwsMaster);
		}
	} catch (Exception e) {
		//System.out.println(e.getMessage());
	} finally {
		closeAll();
	}
	return sourceCodes;
}
public static ArrayList getSources(DataSource dataSource,String circleOfficeCode,String mandalCode,String habCode,HttpSession session) throws Exception
{
	RwsMaster rwsMaster = null;
	ArrayList sources = new ArrayList();
	ArrayList codes = new ArrayList();
	String compTypeCode=null;
	String subCompTypeCode=null;
	String assetTypeCode=null;
	String sourceTypeName="";
	String qr = "";
	int i = 0;
	
	try {
		
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		//System.out.println("got conn and stmt");
		SubCompMetaData subCompMetaData=new SubCompMetaData();
		String query="null";
		if(!(habCode == null || habCode == "" || habCode.equals("")))
		{
			query="select POND_CODE,POND_LOCATION,POND_NAME from RWS_OPENWELL_POND_TBL  where hab_code='"+habCode+"'";
			qr  = "select a.POND_CODE,a.POND_LOCATION,a.POND_NAME,b.pname,c.panch_name from RWS_OPENWELL_POND_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c where b.dcode=substr (a.hab_code,1,2) and b.mcode=substr (a.hab_code,6,2) and b.pcode=substr (a.hab_code,13,2) and b.dcode=substr (a.hab_code,1,2) and b.mcode=substr (a.hab_code,6,2) and b.pcode=substr (a.hab_code,13,2) and substr(a.hab_code,1,14)=c.hab_code and a.HAB_CODE ='"+habCode+"' order by b.pname";
		}
		else
		{
			query="select POND_CODE,POND_LOCATION,POND_NAME from RWS_OPENWELL_POND_TBL  where substr(HAB_CODE,1,2)='"+circleOfficeCode+"' and substr(hab_code,6,2)='"+mandalCode+"'";
			qr  = "select a.POND_CODE,a.POND_LOCATION,a.POND_NAME,b.pname,c.panch_name from RWS_OPENWELL_POND_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c where b.dcode=substr (a.hab_code,1,2) and b.mcode=substr (a.hab_code,6,2) and b.pcode=substr (a.hab_code,13,2) and b.dcode=substr (a.hab_code,1,2) and b.mcode=substr (a.hab_code,6,2) and b.pcode=substr (a.hab_code,13,2) and substr(a.hab_code,1,14)=c.hab_code and substr (a.HAB_CODE,1,2) ='"+circleOfficeCode+"' and substr (a.hab_code,6,2) ='"+mandalCode+"' order by b.pname";
		}
//		System.out.println("query1 is "+query);
	//	System.out.println("qr1 is "+qr);
		rs = stmt.executeQuery(qr);
		while (rs.next()) {
			rwsMaster = new RwsMaster();
			//System.out.println("sourceCode in rwsWQualityData is "+rs.getString(1));
			rwsMaster.setSourceCode(rs.getString(1));
			rwsMaster.setLocation(rs.getString(2));
			
			subCompMetaData.setSubCompDetails(rs.getString(1));
			assetTypeCode=subCompMetaData.getTypeOfAssetCode();
			compTypeCode=subCompMetaData.getAssetCompTypeCode();
			subCompTypeCode=subCompMetaData.getAssetSubCompTypeCode();
			//System.out.println("typeOfAssetCode is "+assetTypeCode);
			//System.out.println("compTypeCode is"+compTypeCode);
			//System.out.println("subCompTypeCode is "+subCompTypeCode);
			
			sourceTypeName=RwsMasterData.getSourceTypeName(assetTypeCode+compTypeCode+subCompTypeCode);
			rwsMaster.setSourceTypeCode(assetTypeCode+compTypeCode+subCompTypeCode);
			rwsMaster.setSourceTypeName(sourceTypeName);
			rwsMaster.setPanchName(rs.getString(4));
			rwsMaster.setHabName(rs.getString(5));
			codes.add(i++,assetTypeCode+compTypeCode+subCompTypeCode);
			sources.add(rwsMaster);
		}
		if(!(habCode == null || habCode == "" || habCode.equals("")))
		{
			query="select OPENWELL_CODE ,LOCATION  from RWS_OPEN_WELL_MAST_TBL  where HABITATION_CODE='"+habCode+"'";
			qr = "select a.OPENWELL_CODE ,a.LOCATION,b.pname,c.panch_name from RWS_OPEN_WELL_MAST_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c where b.dcode=substr(a.HABITATION_code,1,2) and b.mcode=substr(a.HABITATION_code,6,2) and b.pcode=substr (a.HABITATION_code,13,2) and b.dcode=substr(a.HABITATION_code,1,2) and b.mcode=substr (a.HABITATION_code,6,2) and b.pcode=substr (a.HABITATION_code,13,2) and substr(a.HABITATION_code,1,14)=c.hab_code and a.HABITATION_CODE='"+habCode+"' order by b.pname";
		}
		else
		{
			query="select OPENWELL_CODE ,LOCATION  from RWS_OPEN_WELL_MAST_TBL  where substr(HABITATION_CODE,1,2)='"+circleOfficeCode+"' and substr(HABITATION_CODE,6,2)='"+mandalCode+"'";
			qr = "select a.OPENWELL_CODE ,a.LOCATION,b.pname,c.panch_name from RWS_OPEN_WELL_MAST_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c where b.dcode=substr(a.HABITATION_code,1,2) and b.mcode=substr(a.HABITATION_code,6,2) and b.pcode=substr (a.HABITATION_code,13,2) and b.dcode=substr(a.HABITATION_code,1,2) and b.mcode=substr (a.HABITATION_code,6,2) and b.pcode=substr (a.HABITATION_code,13,2) and substr(a.HABITATION_code,1,14)=c.hab_code and substr(a.HABITATION_CODE,1,2)='"+circleOfficeCode+"' and substr (a.HABITATION_CODE,6,2)='"+mandalCode+"' order by b.pname";
		}
//		System.out.println("query2 is "+qr);
		rs = stmt.executeQuery(qr);
		while (rs.next()) {
			rwsMaster = new RwsMaster();
			//System.out.println("sourceCode in rwsWQualityData is "+rs.getString(1));
			rwsMaster.setSourceCode(rs.getString(1));
			rwsMaster.setLocation(rs.getString(2));
		//	System.out.println("source code::"+rs.getString(1));
			subCompMetaData.setSubCompDetails(rs.getString(1));
			assetTypeCode=subCompMetaData.getTypeOfAssetCode();
			compTypeCode=subCompMetaData.getAssetCompTypeCode();
			subCompTypeCode=subCompMetaData.getAssetSubCompTypeCode();
			//System.out.println("typeOfAssetCode is "+assetTypeCode);
			//System.out.println("compTypeCode is"+compTypeCode);
			//System.out.println("subCompTypeCode is "+subCompTypeCode);
			
			sourceTypeName=RwsMasterData.getSourceTypeName(assetTypeCode+compTypeCode+subCompTypeCode);
		//	System.out.println("Source Type Name::"+sourceTypeName+" code::"+assetTypeCode+compTypeCode+subCompTypeCode);
			rwsMaster.setSourceTypeCode(assetTypeCode+compTypeCode+subCompTypeCode);
			rwsMaster.setSourceTypeName(sourceTypeName);
			rwsMaster.setPanchName(rs.getString(3));
			rwsMaster.setHabName(rs.getString(4));
			codes.add(i++,rs.getString(1));
			sources.add(rwsMaster);
		}
		if(!(habCode == null || habCode == "" || habCode.equals("")))
		{
			query="select PUMP_CODE,LOCATION  from RWS_PWS_SUBCOMP_PARAM_TBL  where hab_code='"+habCode+"'";
		}
		else
		{
			query="select PUMP_CODE,LOCATION  from RWS_PWS_SUBCOMP_PARAM_TBL  where  substr(HAB_CODE,1,2)='"+circleOfficeCode+"' and substr(hab_code,6,2)='"+mandalCode+"'";
		}
//		System.out.println("query3 is "+query);
		rs = stmt.executeQuery(query);
		while (rs.next()) {
			rwsMaster = new RwsMaster();
			//System.out.println("sourceCode in rwsWQualityData is "+rs.getString(1));
			rwsMaster.setSourceCode(rs.getString(1));
			rwsMaster.setLocation(rs.getString(2));
			
			subCompMetaData.setSubCompDetails(rs.getString(1));
			assetTypeCode=subCompMetaData.getTypeOfAssetCode();
			compTypeCode=subCompMetaData.getAssetCompTypeCode();
			subCompTypeCode=subCompMetaData.getAssetSubCompTypeCode();
			//System.out.println("typeOfAssetCode is "+assetTypeCode);
			//System.out.println("compTypeCode is"+compTypeCode);
			//System.out.println("subCompTypeCode is "+subCompTypeCode);
			
			sourceTypeName=RwsMasterData.getSourceTypeName(assetTypeCode+compTypeCode+subCompTypeCode);
			rwsMaster.setSourceTypeCode(assetTypeCode+compTypeCode+subCompTypeCode);
			rwsMaster.setSourceTypeName(sourceTypeName);
			codes.add(i++,rs.getString(1));
			sources.add(rwsMaster);
		}
		if(!(habCode == null || habCode == "" || habCode.equals("")))
		{
			query="select PUMP_CODE,LOCATION  from RWS_MPWS_SUBCOMP_PARAM_TBL  where hab_code='"+habCode+"'";
		}
		else
		{
			query="select PUMP_CODE,LOCATION  from RWS_MPWS_SUBCOMP_PARAM_TBL  where  substr(HAB_CODE,1,2)='"+circleOfficeCode+"' and substr(hab_code,6,2)='"+mandalCode+"'";
		}		
	//	System.out.println("query4 is "+query);
		rs = stmt.executeQuery(query);
		while (rs.next()) {
			rwsMaster = new RwsMaster();
			//System.out.println("sourceCode in rwsWQualityData is "+rs.getString(1));
			rwsMaster.setSourceCode(rs.getString(1));
			rwsMaster.setLocation(rs.getString(2));
			
			subCompMetaData.setSubCompDetails(rs.getString(1));
			assetTypeCode=subCompMetaData.getTypeOfAssetCode();
			compTypeCode=subCompMetaData.getAssetCompTypeCode();
			subCompTypeCode=subCompMetaData.getAssetSubCompTypeCode();
			//System.out.println("typeOfAssetCode is "+assetTypeCode);
			//System.out.println("compTypeCode is"+compTypeCode);
			//System.out.println("subCompTypeCode is "+subCompTypeCode);
			
			sourceTypeName=RwsMasterData.getSourceTypeName(assetTypeCode+compTypeCode+subCompTypeCode);
			rwsMaster.setSourceTypeCode(assetTypeCode+compTypeCode+subCompTypeCode);
			rwsMaster.setSourceTypeName(sourceTypeName);
			codes.add(i++,rs.getString(1));
			sources.add(rwsMaster);
		}
		if(!(habCode == null || habCode == "" || habCode.equals("")))
		{
			query="select PUMP_CODE,LOCATION  from RWS_CPWS_SUBCOMP_PARAM_TBL  where hab_code='"+habCode+"'";
		}
		else
		{
			query="select PUMP_CODE,LOCATION  from RWS_CPWS_SUBCOMP_PARAM_TBL  where  substr(HAB_CODE,1,2)='"+circleOfficeCode+"' and substr(hab_code,6,2)='"+mandalCode+"'";
		}
		
//		System.out.println("query5 is "+query);
		rs = stmt.executeQuery(query);
		while (rs.next()) {
			rwsMaster = new RwsMaster();
			//System.out.println("sourceCode in rwsWQualityData is "+rs.getString(1));
			rwsMaster.setSourceCode(rs.getString(1));
			rwsMaster.setLocation(rs.getString(2));
			
			subCompMetaData.setSubCompDetails(rs.getString(1));
			assetTypeCode=subCompMetaData.getTypeOfAssetCode();
			compTypeCode=subCompMetaData.getAssetCompTypeCode();
			subCompTypeCode=subCompMetaData.getAssetSubCompTypeCode();
			//System.out.println("typeOfAssetCode is "+assetTypeCode);
			//System.out.println("compTypeCode is"+compTypeCode);
			//System.out.println("subCompTypeCode is "+subCompTypeCode);
			
			sourceTypeName=RwsMasterData.getSourceTypeName(assetTypeCode+compTypeCode+subCompTypeCode);
			rwsMaster.setSourceTypeCode(assetTypeCode+compTypeCode+subCompTypeCode);
			rwsMaster.setSourceTypeName(sourceTypeName);
			codes.add(i++,rs.getString(1));
			sources.add(rwsMaster);
		}
		if(!(habCode == null || habCode == "" || habCode.equals("")))
		{
			query="select SOURCE_CODE ,LOCATION,SOURCE_NAME  from RWS_SOURCE_TBL where source_type_code=1 and hab_code='"+habCode+"'";
		}
		else
		{
			query="select SOURCE_CODE ,LOCATION,SOURCE_NAME  from RWS_SOURCE_TBL where source_type_code=1 and  substr(HAB_CODE,1,2)='"+circleOfficeCode+"' and substr(hab_code,6,2)='"+mandalCode+"'";
		}
		
	//	System.out.println("query6 is "+query);
		rs = stmt.executeQuery(query);
		while (rs.next()) {
			rwsMaster = new RwsMaster();
			//System.out.println("sourceCode in rwsWQualityData is "+rs.getString(1));
			rwsMaster.setSourceCode(rs.getString(1));
			rwsMaster.setLocation(rs.getString(2));
			
			subCompMetaData.setSubCompDetails(rs.getString(1));
			assetTypeCode=subCompMetaData.getTypeOfAssetCode();
			compTypeCode=subCompMetaData.getAssetCompTypeCode();
			subCompTypeCode=subCompMetaData.getAssetSubCompTypeCode();
			//System.out.println("typeOfAssetCode is "+assetTypeCode);
			//System.out.println("compTypeCode is"+compTypeCode);
			//System.out.println("subCompTypeCode is "+subCompTypeCode);
			
			sourceTypeName=RwsMasterData.getSourceTypeName(assetTypeCode+compTypeCode+subCompTypeCode);
			rwsMaster.setSourceTypeCode(assetTypeCode+compTypeCode+subCompTypeCode);
			rwsMaster.setSourceTypeName(sourceTypeName);
			codes.add(i++,rs.getString(1));
			sources.add(rwsMaster);
		}
		if(!(habCode == null || habCode == "" || habCode.equals("")))
		{
			query="select SOURCE_CODE ,LOCATION,SOURCE_NAME   from RWS_SOURCE_TBL where source_type_code=2 and hab_code='"+habCode+"'";
		}
		else
		{
			query="select SOURCE_CODE ,LOCATION,SOURCE_NAME   from RWS_SOURCE_TBL where source_type_code=2 and  substr(HAB_CODE,1,2)='"+circleOfficeCode+"' and substr(hab_code,6,2)='"+mandalCode+"'";
		}
		//System.out.println("query 7is "+query);
		rs = stmt.executeQuery(query);
		while (rs.next()) {
			rwsMaster = new RwsMaster();
			//System.out.println("sourceCode in rwsWQualityData is "+rs.getString(1));
			rwsMaster.setSourceCode(rs.getString(1));
			rwsMaster.setLocation(rs.getString(2));
			
			subCompMetaData.setSubCompDetails(rs.getString(1));
			assetTypeCode=subCompMetaData.getTypeOfAssetCode();
			compTypeCode=subCompMetaData.getAssetCompTypeCode();
			subCompTypeCode=subCompMetaData.getAssetSubCompTypeCode();
			//System.out.println("typeOfAssetCode is "+assetTypeCode);
			//System.out.println("compTypeCode is"+compTypeCode);
			//System.out.println("subCompTypeCode is "+subCompTypeCode);
			
			sourceTypeName=RwsMasterData.getSourceTypeName(assetTypeCode+compTypeCode+subCompTypeCode);
			rwsMaster.setSourceTypeCode(assetTypeCode+compTypeCode+subCompTypeCode);
			rwsMaster.setSourceTypeName(sourceTypeName);
			codes.add(i++,rs.getString(1));
			sources.add(rwsMaster);
		}
		if(!(habCode == null || habCode == "" || habCode.equals("")))
		{
			query="select HP_CODE ,LOCATION from RWS_HP_SUBCOMP_PARAM_TBL  where substr(hp_code,1,16)='"+habCode+"'";
			qr = "select a.HP_CODE ,a.LOCATION,b.pname,c.panch_name from RWS_HP_SUBCOMP_PARAM_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c where b.dcode=substr(hp_code,1,2) and b.mcode=substr(hp_code,6,2) and b.pcode=substr (hp_code,13,2) and b.dcode=substr(hab_code,1,2) and b.mcode=substr (hab_code,6,2) and b.pcode=substr (hab_code,13,2) and substr(a.hp_code,1,14)=c.hab_code and substr(hp_code,1,16)='"+habCode+"' order by b.pname";
		}
		else
		{
			query="select HP_CODE ,LOCATION from RWS_HP_SUBCOMP_PARAM_TBL  where substr(HP_CODE,1,2)='"+circleOfficeCode+"' AND substr(hp_code,6,2)='"+mandalCode+"'";
			qr = "select a.HP_CODE ,a.LOCATION,b.pname,c.panch_name from RWS_HP_SUBCOMP_PARAM_TBL a,rws_panchayat_tbl b,rws_panchayat_raj_tbl c where b.dcode=substr(hp_code,1,2) and b.mcode=substr(hp_code,6,2) and b.pcode=substr (hp_code,13,2) and b.dcode=substr(hab_code,1,2) and b.mcode=substr (hab_code,6,2) and b.pcode=substr (hab_code,13,2) and substr(a.hp_code,1,14)=c.hab_code  and substr(HP_CODE,1,2)='"+circleOfficeCode+"' AND substr(hp_code,6,2)='"+mandalCode+"' order by b.pname";
		}
		
	//	System.out.println("query 8 is "+query);
//		System.out.println("query 8 is QR:"+qr);
		
		rs = stmt.executeQuery(qr);
		while (rs.next()) {
			rwsMaster = new RwsMaster();
			//System.out.println("sourceCode in rwsWQualityData is "+rs.getString(1));
			rwsMaster.setSourceCode(rs.getString(1));
			rwsMaster.setLocation(rs.getString(2));
			//String pname = RwsMasterData.getPanchName(rs.getString(1),dataSource);
			//System.out.println("pname::"+pname);
			//subCompMetaData.setPanchayatName(rs.getString(3));
			//subCompMetaData.setHabName(rs.getString(4));
			subCompMetaData.setSubCompDetails(rs.getString(1));
			assetTypeCode=subCompMetaData.getTypeOfAssetCode();
			compTypeCode=subCompMetaData.getAssetCompTypeCode();
			subCompTypeCode=subCompMetaData.getAssetSubCompTypeCode();
			//System.out.println("typeOfAssetCode is "+assetTypeCode);
			//System.out.println("compTypeCode is"+compTypeCode);
			//System.out.println("subCompTypeCode is "+subCompTypeCode);
			
			sourceTypeName=RwsMasterData.getSourceTypeName(assetTypeCode+compTypeCode+subCompTypeCode);
			rwsMaster.setSourceTypeCode(assetTypeCode+compTypeCode+subCompTypeCode);
			rwsMaster.setSourceTypeName(sourceTypeName);
			rwsMaster.setPanchName(rs.getString(3));
			rwsMaster.setHabName(rs.getString(4));
			codes.add(i++,rs.getString(1));
			sources.add(rwsMaster);
		}
		if(!(habCode == null || habCode == "" || habCode.equals("")))
		{
			query="select SHALLOWHP_CODE ,LOCATION  from RWS_SHALLOWHANDPUMPS_TBL  where hab_code='"+habCode+"'";
		}
		else
		{
			query="select SHALLOWHP_CODE ,LOCATION  from RWS_SHALLOWHANDPUMPS_TBL  where  substr(HAB_CODE,1,2)='"+circleOfficeCode+"' and substr(hab_code,6,2)='"+mandalCode+"'";
		}
		
	//	System.out.println("query 9 is "+query);
		rs = stmt.executeQuery(query);
		while (rs.next()) {
			rwsMaster = new RwsMaster();
			//System.out.println("sourceCode in rwsWQualityData is "+rs.getString(1));
			rwsMaster.setSourceCode(rs.getString(1));
			rwsMaster.setLocation(rs.getString(2));
			
			subCompMetaData.setSubCompDetails(rs.getString(1));
			assetTypeCode=subCompMetaData.getTypeOfAssetCode();
			compTypeCode=subCompMetaData.getAssetCompTypeCode();
			subCompTypeCode=subCompMetaData.getAssetSubCompTypeCode();
			//System.out.println("typeOfAssetCode is "+assetTypeCode);
			//System.out.println("compTypeCode is"+compTypeCode);
			//System.out.println("subCompTypeCode is "+subCompTypeCode);
			
			sourceTypeName=RwsMasterData.getSourceTypeName(assetTypeCode+compTypeCode+subCompTypeCode);
			rwsMaster.setSourceTypeCode(assetTypeCode+compTypeCode+subCompTypeCode);
			rwsMaster.setSourceTypeName(sourceTypeName);
			codes.add(i++,rs.getString(1));
			sources.add(rwsMaster);
		}
		//System.out.println("Codes Size:"+codes.size());
		session.setAttribute("codes",codes);
		
		//for source
			
		
		
	} catch (Exception e) {
		//System.out.println(e.getMessage());
	} finally {
		closeAll();
	}
	return sources;
}
public static String  getSourceLocation(DataSource dataSource,String sourceCode) throws Exception
{
	String location="";
	SubCompMetaData subCompMetaData=new SubCompMetaData(sourceCode);
	
	
	try {
		
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		String query="";
		//for source
		if((subCompMetaData.getTypeOfAssetCode().equals("01")||subCompMetaData.getTypeOfAssetCode().equals("02")||subCompMetaData.getTypeOfAssetCode().equals("03"))
				&&(subCompMetaData.getAssetCompTypeCode().equals("01") && !subCompMetaData.getAssetSubCompTypeCode().equals("003")))
		{
			if(subCompMetaData.getAssetSubCompTypeCode().equals("001"))
				query="SELECT "+subCompMetaData.getLocationField()+" from "+subCompMetaData.getTableName()+" where "+subCompMetaData.getSchemeCodeField()+"='"+sourceCode+"'";
			else if(subCompMetaData.getAssetSubCompTypeCode().equals("002"))
				query="SELECT "+subCompMetaData.getLocationField()+" from "+subCompMetaData.getTableName()+" where "+subCompMetaData.getSchemeCodeField()+"='"+sourceCode+"'";
		}
		else if((subCompMetaData.getTypeOfAssetCode().equals("04")))
		{
			query="SELECT "+subCompMetaData.getLocationField()+" from "+subCompMetaData.getTableName()+"  where "+subCompMetaData.getSchemeCodeField()+"='"+sourceCode+"'";
		}
		else
			query="SELECT "+subCompMetaData.getLocationField()+" from "+subCompMetaData.getTableName()+" where "+subCompMetaData.getSchemeCodeField()+"='"+sourceCode+"'";	
		//System.out.println("query is "+query);
		if(!subCompMetaData.getLocationField().equals(""))
		{
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				
				//System.out.println("sourceCode in rwsWQualityData is "+rs.getString(1));
				location=rs.getString(1);
				
				
			}
		}
	} catch (Exception e) {
		//System.out.println("Exception is "+e);
	} finally {
		closeAll();
	}
	return location;
}

public static String getWQSourceFinIdenAssetTypeCode(String workCode,DataSource dataSource) throws Exception
{
	String assetTypeCode=null;
	try
	{
		//System.out.println("workCode%%%%%%%%%%%%%%%%%%%%%%%%%%%="+workCode);
		conn = dataSource.getConnection();
		stmt = conn.createStatement();
		
		rs =stmt.executeQuery("select FIN.*,P.PROPOSAL_NAME  WORK_NAME from RWS_SOURCE_IDEN_FIN_TBL FIN,RWS_WORK_PROPOSAL_TBL P where FIN.WORK_ID='"+workCode+"' and P.WORK_ID='"+workCode+"'");
		if ( rs.next() ) 
		{
			assetTypeCode=rs.getString("TYPE_OF_ASSET_CODE");
		}
	}catch(Exception e){System.out.println("Exception in getWQSourceFinIdenAssetTypeCode");}
	finally{closeAll();}
	return assetTypeCode;
}

static String format(String arg)
{
	if(arg==null)
		arg="";
	return arg;
}
}