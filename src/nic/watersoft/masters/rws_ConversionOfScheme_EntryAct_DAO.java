package nic.watersoft.masters;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocationBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.works.WorksData1;

public class rws_ConversionOfScheme_EntryAct_DAO {
	private DataSource dataSource = null;
	private Connection conn = null;
	private Statement stmt = null;
	private ResultSet rs = null;
	private String query = null;
	private PreparedStatement ps;
	private RwsLocationBean rwsLocation = null;
	private String year=null;

	
	public rws_ConversionOfScheme_EntryAct_DAO(DataSource dataSource)
	{
		this.dataSource = dataSource;		
	}
	public rws_ConversionOfScheme_EntryAct_DAO()
	{
		
	}
	public static Asset_Pumpset getPumpsetsFromRs(DataSource dataSource,
			ResultSet rs) throws Exception {
		Asset_Pumpset asset_pumpset = new Asset_Pumpset();
		asset_pumpset.setAssetCode(rs.getString("ASSET_CODE"));
		asset_pumpset.setPumpCode(rs.getString("PUMP_CODE"));
		asset_pumpset.setPumpMake(rs.getString("PUMP_MAKE"));
		asset_pumpset.setPumpCapacity(rs.getString("PUMP_CPTY"));

		asset_pumpset.setPumpType(rs.getString("PUMP_TYPE"));
		asset_pumpset.setPumpYearOfCommissioning(rs.getString("YEAR_COMM"));
		asset_pumpset.setPumpHoursRunningPerDay(rs.getString("HR_RUN"));
		asset_pumpset.setPumpUsage(rs.getString("USAGE"));

		asset_pumpset.setPumpDesignedLpm(rs.getString("DESIGNED_LPM"));
		asset_pumpset.setPumpDesignedHead(rs.getString("DESIGNED_HEAD"));
		asset_pumpset.setPumpControlPanel(rs.getString("CONTROL_PANEL"));
		asset_pumpset.setPumpLowVoltageProblems(rs.getString("LOW_VOLT_PROB"));

		asset_pumpset.setPumpHoursOfPowerAvailability(rs
				.getString("POWER_AVAIL_PER_DAY"));
		asset_pumpset.setPumpFeasiblityOfGettingUrbanLine(rs
				.getString("FEAS_URBAN_LINE"));
		asset_pumpset.setPumpAppCostOfUrbanFeeder(rs.getString("COST"));
		asset_pumpset.setPumpDistanceFromWhereUrbanLineCanBeHad(rs
				.getString("URBAN_LINE_DISTANCE"));

		asset_pumpset.setPumpSuggestions(rs.getString("SUGGESTIONS"));
		asset_pumpset.setGeneratorExisting(rs.getString("GENERATOR_EXISTING"));
		asset_pumpset.setGeneratorCapacity(rs.getString("GENERATOR_CAPACITY"));
		asset_pumpset.setGeneratorWorking(rs.getString("GENERATOR_WORKING"));
		asset_pumpset.setHabCode(format(rs.getString("HAB_CODE")));

		asset_pumpset.setPumpLocation(rs.getString("LOCATION"));
		asset_pumpset.setPumpFeeder(rs.getString("FEEDER"));

		//added by swapna on 20-01-2012 for gis data entry
		asset_pumpset.setLatitude(rs.getString("latitude"));
		asset_pumpset.setLongitude(rs.getString("longitude"));
		asset_pumpset.setElevation(rs.getString("elevation"));
		asset_pumpset.setWaypoint(rs.getString("way_point"));
		//
		return asset_pumpset;
	}

	private void closeAll()
	{
		if(rs != null)
		{
			try
			{	rs.close();
			}
			catch(SQLException sqle)
			{	// Ignore this exception
			}
		}
		if(stmt != null)
		{
			try
			{	stmt.close();
			}
			catch(SQLException sqle)
			{	// Ignore this exception
			}
		}
		if(conn != null)
		{
			try
			{	conn.close();
			}
			catch(SQLException sqle)
			{	// Ignore this exception
			}
		}
	}
	static public boolean isDataAlreadyExists(String tableName, String schemeCodeField, String schemeCode) {
		int count = 0;
		String query;
		RwsMasterData rwsMasterData = new RwsMasterData();
		boolean recordExists = false;
		try {
			Debug.println("in isDataAlreadyExists()");
			
			rwsMasterData.conn = RwsOffices.getConn();
			rwsMasterData.stmt = rwsMasterData.conn.createStatement();
			//query="select count(*) from "+tableName+" where
			// "+schemeCodeField+"='"+schemeCode+"' and
			// asset_code='"+assetCode+"' and
			// hab_code='"+schemeCode.substring(0,16)+"'";
			query = "select count(*) from  " + tableName + " where "
					+ schemeCodeField + "='" + schemeCode + "'";
			Debug.println("query is " + query);
			rwsMasterData.rs = rwsMasterData.stmt.executeQuery(query);
			while (rwsMasterData.rs.next()) {
				count = rwsMasterData.rs.getInt(1);
			}
			if (count > 0)
				recordExists = true;
			//rwsMasterData.closeAll();
			
			return recordExists;

		} catch (Exception e) {
			Debug.println("Exception in isDataAlreadyExists in RwsMasterData "
					+ e);
			recordExists = false;
			
		}

		return recordExists;

	}
	public ArrayList getConvertFromSchemeDetails(String oldAstType) {
		// TODO Auto-generated method stub
		String query="";
		System.out.println("convert listttttt:"+oldAstType);
		ArrayList list=new ArrayList();
			ConverstionOfSchemeForm scheme=null;
			if(oldAstType.equals("04")){
				scheme=new ConverstionOfSchemeForm();
				scheme.setType_of_asset_code("09");
				scheme.setType_of_asset_name("Direct Pumping");
				list.add(scheme);
			}
			else if(oldAstType.equals("09")){
				scheme=new ConverstionOfSchemeForm();
				scheme.setType_of_asset_code("01");
				scheme.setType_of_asset_name("PWS");
				scheme.setType_of_asset_code("02");
				scheme.setType_of_asset_name("MPWS");
				list.add(scheme);
			}
			else if(oldAstType.equals("02")){
				scheme=new ConverstionOfSchemeForm();
				scheme.setType_of_asset_code("01");
				scheme.setType_of_asset_name("PWS");
				list.add(scheme);
			}	
			System.out.println("list size"+list.size());
		return  list;	
	}	
	public static String getNewAssetCode(String assetCode,String typeOfAsset, DataSource dataSource) throws Exception{
		RwsMasterData rwsMasterData = new RwsMasterData();
		String query = "";
		String newAstCode="";
		String max="";
		try {
			newAstCode=assetCode.substring(0, 6)+typeOfAsset+assetCode.substring(8, 14);
			System.out.println("converted code"+newAstCode);
			rwsMasterData.conn = RwsOffices.getConn();
			rwsMasterData.stmt = rwsMasterData.conn.createStatement();
			query = "SELECT max(to_number(substr(ASSET_CODE,11,4)))+1  FROM RWS_ASSET_MAST_TBL where  substr(asset_code,1,10)='"+newAstCode.substring(0, 10)+"'";
			rwsMasterData.rs = rwsMasterData.stmt.executeQuery(query);
			rwsMasterData.rs.next();
			max = rwsMasterData.rs.getString(1);
			if (max == null) {
				max = "0001";
			} else if (max.length() == 1) {
				max = "000" + max;
			} else if (max.length() == 2) {
				max = "00" + max;
			} else if (max.length() == 3) {
				max = "0" + max;
			}
			newAstCode=newAstCode.substring(0, 10)+max;
			} catch (Exception e) {
			Debug.println("The error in getAssetCode=" + e);
		} finally {
			rwsMasterData.closeAll();		
		}
		return newAstCode;
	}
	
	private static java.sql.Date getCurrentDate(String date) {

	    java.util.Date today;
	    java.sql.Date rv = null;
	    try {

	        SimpleDateFormat format = new SimpleDateFormat("dd-MMM-yyyy");
	        		
	        today = format.parse(date);
	        rv = new java.sql.Date(today.getDate());
	        System.out.println("DATEEEEE"+rv);

	    } catch (Exception e) {
	        System.out.println("Exception: " + e.getMessage());
	    } finally {
	        return rv;
	    }

	}    
	public  static Statement batchUpdateForAssetCode1(Statement stmt,ConverstionOfSchemeForm panchRajForm,String newassetCode)
	{
		RwsMasterData rwsMasterData = new RwsMasterData();
		rwsMasterData.conn = RwsOffices.getConn();
		Date dateNow = new Date();
		 SimpleDateFormat formatDateJava=new SimpleDateFormat("dd-MMM-yyyy");
		String date_to_string = formatDateJava.format(dateNow);
		rwsMasterData.conn = RwsOffices.getConn();
		try {
		rwsMasterData.stmt=rwsMasterData.conn.createStatement();
		
		rwsMasterData.stmt1=rwsMasterData.conn.createStatement();
		rwsMasterData.stmt2=rwsMasterData.conn.createStatement();
		rwsMasterData.stmt3=rwsMasterData.conn.createStatement();
		rwsMasterData.stmt4=rwsMasterData.conn.createStatement();
		
		Statement stmt5=rwsMasterData.conn.createStatement();
		
			rwsMasterData.stmt=rwsMasterData.conn.createStatement();
		String query1="select ASSET_CODE,ASSET_COMPONENT,COMPO_IMAGE,COMPO_LAT,COMPO_LON,UPDATE_DATE,MOBILE,TYPE,IMEI from rws_asset_component_image_tbl where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			ResultSet imagers=rwsMasterData.stmt1.executeQuery(query1);
			String ASSET_CODE="",ASSET_COMPONENT="",TYPE="",IMEI="",UPDATE_DATE="";
			Blob COMPO_IMAGE = null;
			int MOBILE=0,COMPO_LON=0,COMPO_LAT=0;
			
			
			
			//Retrieving Asset Scheme
		String query2="select ASSET_CODE,SCHEME_CODE from rws_asset_scheme_tbl where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			ResultSet Schemesrs=rwsMasterData.stmt2.executeQuery(query2);
			String Scheme_ASSET_CODE="",Scheme_SCHEME_CODE="";
			
			
			//Retrieving AssetHAB
			String query3="select ASSET_CODE,HAB_CODE,nvl(SAFE_LPCD,'0') as SAFE_LPCD,nvl(WATER_SUPP_FREQ,'') as WATER_SUPP_FREQ from RWS_ASSET_HAB_TBL where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			   ResultSet habrs=rwsMasterData.stmt3.executeQuery(query3);
			   String hab_assetcode="",hab_habcode="",hab_water_sup="";
			   int hab_sage_lpcd=0;
			 
			   
			   //Retrieving Asset Master Tbl
			String query4="select nvl(ASSET_CODE,'') as ASSET_CODE,nvl(ASSET_NAME,'') as ASSET_NAME,nvl(TYPE_OF_ASSET_CODE,'') as TYPE_OF_ASSET_CODE,nvl(HAB_CODE,'') as HAB_CODE,nvl(LOCATION,'') as LOCATION,to_char(DATE_CREATION,'dd-MON-yyyy') as creation_date,nvl(ASSET_STATUS,'0') as ASSET_STATUS,nvl(ASSET_COST,'0') as ASSET_COST,nvl(START_YEAR,'') as START_YEAR,nvl(END_YEAR,'') as END_YEAR,nvl(CIRCLE_OFFICE_CODE,'') as CIRCLE_OFFICE_CODE,nvl(DIVISION_OFFICE_CODE,'0') as DIVISION_OFFICE_CODE,nvl(SUBDIVISION_OFFICE_CODE,'') as SUBDIVISION_OFFICE_CODE,UPDATE_DATE,nvl(POPU_BENEFITED,'0') as POPU_BENEFITED,nvl(DEFUNCT_REASON,'') as DEFUNCT_REASON,nvl(REMARKS,'') as REMARKS,nvl(DIRECT_PUMPING_YIELD,'0') as DIRECT_PUMPING_YIELD,nvl(PROGRAMME_CODE,'') as PROGRAMME_CODE,nvl(LATITUDE,'0') as LATITUDE,nvl(LONGITUDE,'0') as LONGITUDE,nvl(ELEVATION,'0') as ELEVATION,nvl(WAY_POINT,'0') as WAY_POINT,to_char(LAST_REPAIRED_DATE,'dd-MON-yyyy') as repair_date from rws_asset_mast_tbl where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			   /* query4 = "select a.ASSET_CODE,a.ASSET_NAME,,a.TYPE_OF_ASSET_CODE,a.HAB_CODE,a.LOCATION,to_char(a.DATE_CREATION,'dd-MON-yyyy') as creation_date,a.ASSET_STATUS,a.ASSET_COST,a.START_YEAR,a.END_YEAR,a.CIRCLE_OFFICE_CODE,a.DIVISION_OFFICE_CODE,a.SUBDIVISION_OFFICE_CODE,a.UPDATE_DATE,nvl(a.POPU_BENEFITED,0) as POPU_BENEFITED,nvl(a.DEFUNCT_REASON,'') as DEFUNCT_REASON,nvl(REMARKS,'') as REMARKS,nvl(DIRECT_PUMPING_YIELD,'0') as DIRECT_PUMPING_YIELD,LATITUDE,LONGITUDE,ELEVATION,WAY_POINT,to_char(LAST_REPAIRED_DATE,'dd-MON-yyyy') as repair_date from rws_asset_mast_tbl a,rws_asset_scheme_tbl s where "
						+"a.asset_code=s.asset_code and a.asset_code='"
						+ panchRajForm.getAssetCode() + "'";*/

			   ResultSet masterrs=rwsMasterData.stmt4.executeQuery(query4);
			   
			 
			  
			   //Insertion Batch Statements
			   if(!Schemesrs.isBeforeFirst())
				{
					
				}
				else
				{
				while(Schemesrs.next())
				{
					Scheme_ASSET_CODE=newassetCode;
					Scheme_SCHEME_CODE=Schemesrs.getString("SCHEME_CODE");
				String query5="insert into rws_asset_scheme_tbl values('"+newassetCode+"','"+Scheme_SCHEME_CODE+"')";
					   System.out.println("Insertion rws_asset_scheme_tbl "+query5);
					   stmt.addBatch(query5);
				}
				
				}  
			  
			   
			   
			  
			   if(!habrs.isBeforeFirst())
			   {
				   
			   }
			   else
			   {
			   while(habrs.next())
			   {
				   hab_assetcode=newassetCode;
				   hab_habcode=habrs.getString("HAB_CODE");
				   hab_sage_lpcd=habrs.getInt("SAFE_LPCD");
				   hab_water_sup=habrs.getString("WATER_SUPP_FREQ");
				   if(hab_water_sup==null)
				   {
					   hab_water_sup="";
				   }
				 String  query6="insert into RWS_ASSET_HAB_TBL values('"+newassetCode+"','"+hab_habcode+"',"+hab_sage_lpcd+",'"+hab_water_sup+"')";
				   System.out.println("Insertion RWS_ASSET_HAB_TBL "+query6);
				   stmt.addBatch(query6);
			   }
			   }
			   if(!masterrs.isBeforeFirst())
			   {
			      
			   }
			   else
			   {
			   while(masterrs.next())
			   {
				  String DEFUNCT_REASON=masterrs.getString("DEFUNCT_REASON");
				if(DEFUNCT_REASON==null)
				{
					DEFUNCT_REASON="";
				}
				String LAST_REPAIRED_DATE=masterrs.getString("repair_date");
				if(LAST_REPAIRED_DATE==null)
				{
					LAST_REPAIRED_DATE="";
				}
				String progcode=masterrs.getString("PROGRAMME_CODE");
				if(progcode==null)
				{
					progcode="";
				}
				else
				{
					progcode=progcode.trim();
				}
			String  query8="insert into rws_asset_mast_tbl values('"+newassetCode+"','"
			   +masterrs.getString("ASSET_NAME")+"','"
					  // +masterrs.getString("TYPE_OF_ASSET_CODE")+"','"panchRajForm
		   +panchRajForm.getType_of_asset_name1()+"','"
			   +masterrs.getString("HAB_CODE")+"','"
					   +masterrs.getString("LOCATION")+"','"
			   +masterrs.getString("creation_date")+"',"
					   +masterrs.getInt("ASSET_STATUS")+","
			   +masterrs.getInt("ASSET_COST")+",'"
					   +masterrs.getString("START_YEAR")+"','"
			   +masterrs.getString("END_YEAR")+"','"
					   +masterrs.getString("CIRCLE_OFFICE_CODE")+"',"
			   +masterrs.getInt("DIVISION_OFFICE_CODE")+",'"
					   +masterrs.getString("SUBDIVISION_OFFICE_CODE")+"','"
			   +date_to_string+"',"
					   +masterrs.getInt("POPU_BENEFITED")+",'"
			   +DEFUNCT_REASON+"','"
					   +masterrs.getString("REMARKS")+"',"
			   +masterrs.getInt("DIRECT_PUMPING_YIELD")+",'"
					   +progcode+"',"
			   +masterrs.getInt("LATITUDE")+","
					   +masterrs.getInt("LONGITUDE")+","
			   +masterrs.getInt("ELEVATION")+","
					   +masterrs.getInt("WAY_POINT")+",'"
			   +LAST_REPAIRED_DATE+"')";
					   System.out.println("Insertion rws_asset_mast_tbl "+query8);
					   stmt.addBatch(query8);	   
			   }
			   }
			   
			   if(!imagers.isBeforeFirst())
				{
					
				}
				else
				{
					System.out.println("MM");
				while(imagers.next())
				{
					ASSET_CODE=newassetCode;
					ASSET_COMPONENT=imagers.getString("ASSET_COMPONENT");
					COMPO_IMAGE=imagers.getBlob("COMPO_IMAGE");
					
					
					byte [] b1=new byte[(int)COMPO_IMAGE.length()];
					COMPO_LAT=imagers.getInt("COMPO_LAT");
					COMPO_LON=imagers.getInt("COMPO_LON");
				
					MOBILE=imagers.getInt("MOBILE");
					
					TYPE=imagers.getString("TYPE");
					IMEI=imagers.getString("IMEI");
					String query6_1="create table imagess_tmp as select * from rws_asset_component_image_tbl where 1=0";
					stmt.addBatch(query6_1);
					System.out.println("Asset_Componet_Image_tbl query6_1 "+query6_1);
					String query6_2="insert into imagess_tmp(ASSET_CODE,ASSET_COMPONENT,COMPO_IMAGE,COMPO_LAT,COMPO_LON,UPDATE_DATE,MOBILE,TYPE,IMEI) select * from rws_asset_component_image_tbl where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
					stmt.addBatch(query6_2);
					System.out.println("Asset_Componet_Image_tbl query6_2 "+query6_2);
					String query6_3="update imagess_tmp set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
					
					System.out.println("Asset_Componet_Image_tbl query6_3 "+query6_3);
					stmt.addBatch(query6_3);
					/*query7="insert into rws_asset_component_image_tbl(ASSET_CODE,ASSET_COMPONENT,COMPO_IMAGE,COMPO_LAT,COMPO_LON,UPDATE_DATE,MOBILE,TYPE,IMEI) values('"+newassetCode+"','"+ASSET_COMPONENT+"',"+COMPO_LAT+","+COMPO_LON+",'"+UPDATE_DATE+"',"+MOBILE+",'"+TYPE+"','"+IMEI+"')";*/
				String query7="insert into rws_asset_component_image_tbl(ASSET_CODE,ASSET_COMPONENT,COMPO_IMAGE,COMPO_LAT,COMPO_LON,UPDATE_DATE,MOBILE,TYPE,IMEI) select * from imagess_tmp where asset_code='"+newassetCode+"'";					
					System.out.println("Asset_Componet_Image_tbl "+query7);
					stmt.addBatch(query7);	
					String query6_4="drop table imagess_tmp";
					System.out.println("query6_4"+query6_4);
					stmt.addBatch(query6_4);
					
				}
				
				}
			   String query6_1="create  table assets_imagess_tmp as select * from RWS_ASSET_IMAGE_TBL where 1=0";
			   stmt.addBatch(query6_1);
				System.out.println("RWS_ASSET_IMAGE_TBL query6_1 "+query6_1);
				String query6_2="insert into assets_imagess_tmp(ASSET_CODE,ASSET_IMAGE,ASSET_LAT,ASSET_LON,UPDATE_DATE,MOBILE,IMEI_NO) select * from RWS_ASSET_IMAGE_TBL where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
				stmt.addBatch(query6_2);
				System.out.println("RWS_ASSET_IMAGE_TBL query6_2 "+query6_2);
				String query6_3="update assets_imagess_tmp set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
				
				System.out.println("RWS_ASSET_IMAGE_TBL query6_3 "+query6_3);
				stmt.addBatch(query6_3);
				//String query7="insert into rws_asset_component_image_tbl(ASSET_CODE,ASSET_COMPONENT,COMPO_IMAGE,COMPO_LAT,COMPO_LON,UPDATE_DATE,MOBILE,TYPE,IMEI) values('"+newassetCode+"','"+ASSET_COMPONENT+"',"+COMPO_LAT+","+COMPO_LON+",'"+UPDATE_DATE+"',"+MOBILE+",'"+TYPE+"','"+IMEI+"')";
				String query6_5="insert into RWS_ASSET_IMAGE_TBL(ASSET_CODE,ASSET_IMAGE,ASSET_LAT,ASSET_LON,UPDATE_DATE,MOBILE,IMEI_NO) select * from assets_imagess_tmp where asset_code='"+newassetCode+"'";					
				System.out.println("RWS_ASSET_IMAGE_TBL "+query6_5);
				stmt.addBatch(query6_5);	
				String query6_4="drop table assets_imagess_tmp";
				System.out.println("drop"+query6_4);
				stmt.addBatch(query6_4);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		return stmt;
	}
	public void updateAssetCode(ConverstionOfSchemeForm panchRajForm,String astcode,String newassetCode,HttpServletRequest request) {
		// TODO Auto-generated method stub
		RwsMasterData rwsMasterData = new RwsMasterData();
		String Tab_Prifix = "";
		Asset_SubComponent assetSources = new Asset_SubComponent();
		Asset_Pumpset asset_pumpset = null;
		Asset_PipeLine asset_pipeline = null;
		Asset_Reservior asset_reservoir = null;
		ArrayList parameters = new ArrayList();
		int[] rowCount = new int[50];
		Date dateNow = new Date();
		SimpleDateFormat formatDateJava=new SimpleDateFormat("dd-MMM-yyyy");
		String date_to_string = formatDateJava.format(dateNow);
		System.out.println("Updated Date is "+date_to_string);
		try {
			rwsMasterData.conn = RwsOffices.getConn();
			rwsMasterData.conn.setAutoCommit(false);
			rwsMasterData.stmt=rwsMasterData.conn.createStatement();
			/*rwsMasterData.stmt1=rwsMasterData.conn.createStatement();
			rwsMasterData.stmt2=rwsMasterData.conn.createStatement();
			rwsMasterData.stmt3=rwsMasterData.conn.createStatement();
			rwsMasterData.stmt4=rwsMasterData.conn.createStatement();*/
			ResultSet rs=null;
			HttpSession session=request.getSession();
			RwsUser userss=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
			if(userss!=null){				
				String user= userss.getUserId();
				query="insert into RWS_ASSET_CHANGE_HISTORY_TBL(ASSET_CODE,ASSET_CODE_OLD,UPDATE_DATE,PREPARED_BY) VALUES('"+newassetCode+"','"+astcode+"','"+date_to_string+"','"+user+"')";
			}
			stmt.addBatch(query);
			if(astcode.substring(6,8).equals("04")){
				String DPCode=getDPFromHP(panchRajForm);
			}
			
			String query="update rws_asset_mast_tbl set ASSET_CODE ='"+newassetCode+"' where ASSET_CODE ='"+astcode+"'";
			stmt.addBatch(query);
			query="update RWS_ASSET_HAB_TBL set ASSET_CODE='"+newassetCode+"' where ASSET_CODE ='"+astcode+"'";
			stmt.addBatch(query);
			/*query="update rws_asset_scheme_tbl set ASSET_CODE='"+newassetCode+"' where ASSET_CODE ='"+astcode+"'";
			stmt.addBatch(query);*/
			query="update RWS_ASSET_IMAGE_TBL set ASSET_CODE='"+newassetCode+"' where ASSET_CODE ='"+astcode+"'";
			stmt.addBatch(query);
			
			
			if(astcode.substring(6,8).equals("04")){
				
				 /*List list=getHandPumpDetails(panchRajForm);
				    for(Iterator it=list.iterator();it.hasNext();)
				    {
				    	rwsMasters = (RwsMaster) it.next();
				    	String HP_CODE=rwsMasters.getHpCode();
				    	System.out.println("HP_CODE @@@@@@@@@@@"+HP_CODE);
				    }		
//rws_hp_subcomp_param_tbl
			
			
		if(hp_list!=null)
		{
			//RwsMaster	rwsMaster = new RwsMaster();//assetSources = (Asset_SubComponent) hp_list.get(0);
				for (int i = 0; i < hp_list.size(); i++) {
					RwsMaster	rwsMaster= (RwsMaster) hp_list.get(i);
			String HpCode=rwsMaster.getHpCode();
			System.out.println("Old HPCODE "+HpCode);
			String new_hp_code=null;
			if(HpCode!=null)
			{
		String hp_code_1=HpCode.substring(0, 19);
		String hp_code_2=HpCode.substring(21, 24);
		System.out.println("hp_code_1"+hp_code_1);
		System.out.println("hp_code_2"+hp_code_2);
		if(assetTypeCode.equals("09"))
		{
			new_hp_code=hp_code_1+"DP"+hp_code_2;
		}
			}
			System.out.println("New Hp Code is "+new_hp_code);
			if (format(rwsMaster.getQualityAffected()).equals("N")) {
				rwsMaster.setBrakish(0);
				rwsMaster.setIron(0);
				rwsMaster.setOthers("");
				rwsMaster.setOthersType("");
			}
			String  insertQuery=null;
			if (isDataAlreadyExists("RWS_HP_SUBCOMP_PARAM_TBL","HP_CODE",new_hp_code)) {
				System.out.println("HP CODE MATCHER");
			 insertQuery="update RWS_HP_SUBCOMP_PARAM_TBL set HP_CODE='"+new_hp_code+"',asset_code='"+newassetCode+"' where HP_CODE='"+new_hp_code+"'";
			}
			else
			{
		 insertQuery = "INSERT INTO RWS_HP_SUBCOMP_PARAM_TBL(HP_CODE,ASSET_CODE,LOCATION ,DIAMETER,"
					+ "CASING,GEN_CONDITION,GI_NO,PAINTED,STATIC_WL,SUMMER_WL,platform_existing,"
					+ "SER_NO,SER_HRS,REPAIRS,PLATFORM_CONDITION,DRAIN,DRAIN_CONDITION,"
					+ "DRAIN_SD,DRAIN_LP,HYGIENE,AVG_TIME,P_YEILD,PYEILD_LOCAL,PERIOD,"
					+ "DEPTH,QUALITY_AFFECTED,FLOURIDE,BRAKISH,IRON,CONT_OTHERS_PER,"
					+ "cont_others_type,pipe_length,latitude,longitude,elevation,way_point) VALUES("
					+ "'"
					+ new_hp_code
					+ "',"
					+ "'"
					+ newassetCode
					+ "',"
					+ "'"
					+ rwsMaster.getLocation()
					//+ "',DRILL_YEAR ='" +
					// assetSources.getYearOfDrilling() + "',"
					+ "',nvl('"
					+ rwsMaster.getDiameter()
					+ "',0),'"
					+ rwsMaster.getCasing()
					+ "',"
					//+ "STATUS = '"+ assetSources.getStatus()/////       
					+ "  '"
					+ format(rwsMaster.getGenCondition())                       
					+ "',  nvl('"
					+ rwsMaster.getGino()
					+ "',0),"
					+ "  '"
					+ format(rwsMaster.getPainted())
					+ "', nvl('"
					+ rwsMaster.getStaticWaterLevel()
					+ "',0)"
					+ ", nvl('"
					+ rwsMaster.getSummerWaterLevel()
					+ "',0), '"
					+ format(rwsMaster.getPcond())
					//+ "',DRY_DURING ='"+ rwsMaster.getDryduring()
					//+ "', SERVICE='"+ rwsMaster.getService()
					+ "', nvl('"
					+ rwsMaster.getSerno()
					+ "',0),"
					+ "  nvl('"
					+ rwsMaster.getSerhrs()
					+ "',0), '"
					+ format(rwsMaster.getRepairs())
					+ "', '"
					+ format(rwsMaster.getPlatformCondition())
					+ "', '"
					+ format(rwsMaster.getDrain())
					+ "', '"
					+ RwsMasterData
							.format(rwsMaster.getDrainCondition())
					+ "', '"
					+ format(rwsMaster.getDrainsd())
					+ "', '"
					+ format(rwsMaster.getDrainlp())
					+ "', '"
					+ format(rwsMaster.getHygiene())
					+ "', nvl('"
					+ rwsMaster.getAvgtime()
					+ "',0), nvl('"
					+ rwsMaster.getPyield()
					+ "',''),  '"
					+ format(rwsMaster.getPyieldLocal())
					+ "',"
					+ "'"
					+ RwsMasterData.format(rwsMaster.getPeriod())
					+ "',nvl('"
					+ rwsMaster.getDepth()
					+ "',0),'"
					+ format(rwsMaster.getQualityAffected())
					+ "',"
					+ " nvl('"
					+ rwsMaster.getFlouride()
					+ "',0), nvl('"
					+ rwsMaster.getBrakish()
					+ "',0), nvl('"
					+ rwsMaster.getIron()
					+ "',0), nvl('"
					+ format(rwsMaster.getOthers())
					//+ "',0), cont_others_type =
					// '"+rwsMaster.getOtherspecify()
					+ "',''),  '"
					+ format(rwsMaster.getOthersType())
					+ "',nvl('"
					+ rwsMaster.getPipeLength()
					+ "',0),'"
					+ format(rwsMaster.getLatitude())
					+ "','"
					+ format(rwsMaster.getLongitude())
					+ "','"
					+ format(rwsMaster.getElevation())
					+ "','"
					+ format(rwsMaster.getWaypoint()) + "')";

			
			System.out.println("HP_Subcomp_Param_Tbl "+insertQuery);
			}
			rwsMasterData.stmt.addBatch(insertQuery);
				}
			
		}
		HttpSession session=request.getSession();
		RwsUser userss=(nic.watersoft.commons.RwsUser)session.getAttribute("RWS_USER");
		
			if(userss==null)
			{
				
			}
			else{
				
				String useridd = userss.getUserId();
				System.out.println("else part"+useridd);
				String insertQuerys1="insert into RWS_ASSET_CHANGE_HISTORY_TBL(ASSET_CODE,ASSET_CODE_OLD,UPDATE_DATE,PREPARED_BY) VALUES('"+newassetCode+"','"+panchRajForm.getAssetCode()+"','"+date_to_string+"','"+useridd+"')";
				System.out.println("insert"+insertQuerys1);
				rwsMasterData.stmt.addBatch(insertQuerys1);	
			}
	   Statement stbatch=batchUpdateForAssetCode1(rwsMasterData.stmt,panchRajForm,newassetCode);
	   
		Statement deletebatch=batchDeleteBasedOnAssetCode1(stbatch,panchRajForm,newassetCode);
		rowCount=deletebatch.executeBatch();
				rwsMasterData.conn.commit();
				rwsMasterData.conn.setAutoCommit(true);
			
			}
			*/
		}else if(astcode.substring(6,8).equals("09") || astcode.substring(6,8).equals("02")){
			
			
			
		}
				
		}catch(Exception e)
			{
				e.printStackTrace();try {
					System.out.println("Roll back is calling");
					rwsMasterData.conn.rollback();
					Debug.println("Exception in this function:" + e);
				} catch (SQLException e1) {
					Debug.println("Exception in this function:" + e1);
					e1.printStackTrace();
				}
			}
		
			   //Data Deletion
			
			//rwsMasterData.conn = RwsOffices.getConn();
			//rwsMasterData.conn.setAutoCommit(false);	   
			//Statement stmt5=rwsMasterData.conn.createStatement();
			 /* query9="delete rws_asset_scheme_tbl where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			   System.out.println("delete rws_asset_scheme_tbl "+query9);
			   stmt5.addBatch(query9);
			   
			   
			   query10="delete from RWS_ASSET_HAB_TBL where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			   System.out.println("delete RWS_ASSET_HAB_TBL "+query10);
			   stmt5.addBatch(query10);

			   
			   query11="delete from rws_asset_component_image_tbl where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			   System.out.println("delete rws_asset_component_image_tbl "+query11);
			   stmt5.addBatch(query11);
			   
			   
			   query12="delete from RWS_ASSET_MAST_TBL where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			   System.out.println("delete RWS_ASSET_MAST_TBL "+query12);
			   stmt5.addBatch(query12);*/
			  
			/*query = "update rws_openwell_pond_tbl set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("update rws_openwell_pond_tbl query***************Egr" + query);
			rwsMasterData.stmt.addBatch(query);
			
			
			query1 = "update rws_open_well_mast_tbl set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("update rws_open_well_mast_tbl query***************Egr" + query1);
			rwsMasterData.stmt.addBatch(query1);
			
			
			query2 = "update rws_shallowhandpumps_tbl set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("update rws_shallowhandpumps_tbl query***************Egr" + query2);
			rwsMasterData.stmt.addBatch(query2);
			
			query3 = "update rws_ast_others_param_tbl set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("update rws_ast_others_param_tbl query***************Egr" + query3);
			rwsMasterData.stmt.addBatch(query3);
			
			
			query4 = "update rws_ast_subcomp_param_tbl set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("update rws_ast_subcomp_param_tbl query***************Egr" + query4);
			rwsMasterData.stmt.addBatch(query4);
			
			
			query5 = "update rws_ast_others_param_tbl set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("update rws_ast_others_param_tbl query***************Egr" + query5);
			rwsMasterData.stmt.addBatch(query5);
			
			query6 = "update rws_ast_chlorination_tbl set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("update rws_ast_chlorination_param_tbl query***************Egr" + query6);
			rwsMasterData.stmt.addBatch(query6);
			
			
			query7= "update rws_ast_oandm_param_tbl set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("update rws_ast_oandm_param_tbl query***************Egr" + query7);
			rwsMasterData.stmt.addBatch(query7);
			
			query8= "update rws_hp_subcomp_param_tbl set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("update rws_hp_subcomp_param_tbl query***************Egr" + query8);
			rwsMasterData.stmt.addBatch(query8);
			
			query9= "update rws_ast_ohsr_sc_param_tbl set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("update rws_ast_ohsr_sc_param_tbl query***************Egr" + query9);
			rwsMasterData.stmt.addBatch(query9);
			
			
			query10= "update rws_ast_glsr_sc_param_tbl set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("update rws_ast_glsr_sc_param_tbl query***************Egr" + query10);
			rwsMasterData.stmt.addBatch(query10);
			
			query11= "update rws_ast_glbr_sc_param_tbl set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("update rws_ast_glbr_sc_param_tbl query***************Egr" + query11);
			rwsMasterData.stmt.addBatch(query11);
			
			
			query12= "update rws_ast_bpt_param_tbl set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("update rws_ast_bpt_param_tbl query***************Egr" + query12);
			rwsMasterData.stmt.addBatch(query12);
			
			query13= "update rws_ast_cis_sc_param_tbl set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("update rws_ast_cis_sc_param_tbl query***************Egr" + query13);
			rwsMasterData.stmt.addBatch(query13);
			
			query14= "update rws_ast_ss_sc_param_tbl set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("update rws_ast_ss_sc_param_tbl query***************Egr" + query14);
			rwsMasterData.stmt.addBatch(query14);
			
			query15= "update rws_ast_wtp_sc_param_tbl set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("update rws_ast_ss_sc_param_tbl query***************Egr" + query15);
			rwsMasterData.stmt.addBatch(query15);
			
			query16= "update rws_ast_wtp_sc_param_tbl set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("update rws_ast_ss_sc_param_tbl query***************Egr" + query16);
			rwsMasterData.stmt.addBatch(query16);
			
			query17= "update rws_ast_sump_m_sc_param_tbl set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("update rws_ast_sump_m_sc_param_tbl query***************Egr" + query17);
			rwsMasterData.stmt.addBatch(query17);
			
			query18= "update rws_ast_fp_bridge_param_tbl set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("update rws_ast_fp_bridge_param_tbl query***************Egr" + query18);
			rwsMasterData.stmt.addBatch(query18);
			
			query19= "update rws_ast_pumphouse_param_tbl set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("update rws_ast_pumphouse_param_tbl query***************Egr" + query19);
			rwsMasterData.stmt.addBatch(query19);
			
			query20= "update rws_ast_watchman_param_tbl set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("update rws_ast_watchman_param_tbl query***************Egr" + query20);
			rwsMasterData.stmt.addBatch(query20);
			
			query21= "update rws_ast_cw_collwell_param_tbl set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("update rws_ast_cw_collwell_param_tbl query***************Egr" + query21);
			rwsMasterData.stmt.addBatch(query21);
			
			query22= "update rws_ast_wtp_sc_param_tbl set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("update rws_ast_wtp_sc_param_tbl query***************Egr" + query22);
			rwsMasterData.stmt.addBatch(query22);
			
			query23= "update rws_ast_pumpingmain_tbl set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("update rws_ast_pumpingmain_tbl query***************Egr" + query23);
			rwsMasterData.stmt.addBatch(query23);
			
			query24= "update rws_ast_gravitymain_tbl set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("update rws_ast_gravitymain_tbl query***************Egr" + query24);
			rwsMasterData.stmt.addBatch(query24);
			
			query25= "update rws_ast_DISTRI_SC_PARAM_TBL set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("update rws_ast_distri_sc_tbl query***************Egr" + query25);
			rwsMasterData.stmt.addBatch(query25);
			
		*/
			
			
		   /*query26= "update rws_asset_scheme_tbl set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			System.out.println("Scheme Table Update EGR "+query26);
			rwsMasterData.stmt.addBatch(query26);
			
		    query27="update RWS_ASSET_HAB_TBL set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
		    System.out.println("Asset HAB Table Update EGR "+query27);
			rwsMasterData.stmt.addBatch(query27);*/
			
			
/*
		    query28="update RWS_SOURCE_TBL set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
		    System.out.println("RWS_SOURCE_TBL Update EGR "+query28);
			rwsMasterData.stmt.addBatch(query28);
			
			 query29="update RWS_AST_OHBR_SC_PARAM_TBL set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			    System.out.println("RWS_AST_OHBR_SC_PARAM_TBL Update EGR "+query29);
				rwsMasterData.stmt.addBatch(query29);
				
				 query30="update RWS_AST_PUMPINGMAIN_TBL set ASSET_CODE='"+newassetCode+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
				    System.out.println("RWS_AST_OHBR_SC_PARAM_TBL Update EGR "+query30);
					rwsMasterData.stmt.addBatch(query30);
			*/
			
			
		/*	query31 = "insert into rws_asset_component_image_tbl values(ASSET_CODE,ASSET_COMPONENT,COMPO_IMAGE,COMPO_LAT,COMPO_LON,UPDATE_DATE,MOBILE,TYPE,IMEI) values('"+ASSET_CODE+"','"+ASSET_COMPONENT+"','"+COMPO_IMAGE+"','"+COMPO_LAT+"','"+COMPO_LON+"','"+UPDATE_DATE+"','"+MOBILE+"','"+TYPE+"','"+IMEI+"' )";
			Debug.println("insert rws_asset_component_image_tbl query***************Egr" + query31);
			rwsMasterData.stmt.addBatch(query31);
			
			
			query32 = "delete from rws_asset_component_image_tbl  where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("delete rws_asset_component_image_tbl query***************Egr" + query32);
			rwsMasterData.stmt.addBatch(query32);
			
			query33 = "update RWS_ASSET_MAST_TBL set ASSET_CODE='"+newassetCode+"',UPDATE_DATE='"+date_to_string+"' where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
			Debug.println("update asset query***************Egr" + query33);
			rwsMasterData.stmt.addBatch(query33);
			
			
			
			
			rowCount = rwsMasterData.stmt.executeBatch();
			System.out.println("ROW COUNT IS " + rowCount.length);
			rwsMasterData.conn.commit();
			rwsMasterData.conn.setAutoCommit(true);*/
			   //rowCount=stmt5.executeBatch();
			  		
	}

	private Statement batchDeleteBasedOnAssetCode1(Statement stmt2,
			ConverstionOfSchemeForm panchRajForm, String newassetCode) {
		// TODO Auto-generated method stub
		
		try {
		
		   String query9="delete from rws_asset_scheme_tbl where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
		   System.out.println("delete rws_asset_scheme_tbl "+query9);
		   stmt2.addBatch(query9);
		   
		   String query10="delete from RWS_ASSET_HAB_TBL where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
		   System.out.println("delete RWS_ASSET_HAB_TBL "+query10);
		   stmt2.addBatch(query10);
		   
		   String query11="delete from rws_asset_component_image_tbl where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
		   System.out.println("delete rws_asset_component_image_tbl "+query11);
		   stmt2.addBatch(query11);
		   
		   String query13="delete from RWS_ASSET_IMAGE_TBL where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
		   System.out.println("delete RWS_ASSET_MAST_TBL "+query13);
		   stmt2.addBatch(query13);
		   
		   String query14="delete from RWS_HP_SUBCOMP_PARAM_TBL where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
		   System.out.println("delete RWS_ASSET_MAST_TBL "+query14);
		   stmt2.addBatch(query14);
		   
		   String query12="delete from RWS_ASSET_MAST_TBL where ASSET_CODE='"+panchRajForm.getAssetCode()+"'";
		   System.out.println("delete RWS_ASSET_MAST_TBL "+query12);
		   stmt2.addBatch(query12);
		   
		
		  
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		return stmt2;
	}
	private Statement batchUpdateForAssetCode(Statement stmt2) {
		// TODO Auto-generated method stub
		return null;
	}
	public static String format(String val) {
		if (val == null || val.equals("null"))
			val = "";
		return val;
	}

	public static String format(int val) {
		String rValue = "";
		if (val == 0)
			rValue = "";
	
		else
			rValue = val + "";
		return rValue;
	}

	public static String format(float val) {
		String rValue = "";
		if (val == 0)
			rValue = "";
		else
			rValue = val + "";
		return rValue;
	}
	public static String format(double val) {
		String rValue = "";
		if (val == 0)
			rValue = "";
		else
			rValue = val + "";
		return rValue;
	}

	public ArrayList getDistricts() {
		// TODO Auto-generated method stub
		ArrayList districts=new ArrayList();
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			rs =stmt.executeQuery("SELECT * FROM RWS_DISTRICT_TBL ORDER BY DNAME");
			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
	
				rwsLocation.setDistrictCode(rs.getString(1));
				rwsLocation.setDistrictName(rs.getString(2));
				rwsLocation.setCodeName(rs.getString(2)+" - "+rs.getString(1));
				districts.add(rwsLocation);
			}
		System.out.println("in district pf rwslocatiion");
		}
		catch (Exception e)
		{
			System.out.println("The error in getDistricts()=== RwsLocations "+e);
		}
		finally 
		{
			closeAll();
		}
		return districts;
	}

	public ArrayList getMandals(String dcode) {
		// TODO Auto-generated method stub
		ArrayList mandals=new ArrayList();
		String query = null;
		try
		{
			conn = RwsOffices.getConn();
			query = "SELECT DISTINCT DCODE,MCODE,MNAME FROM RWS_MANDAL_TBL WHERE" +
			 " DCODE=? ORDER BY MNAME";
			//stmt = conn.createStatement();
			//rs =stmt.executeQuery("SELECT DISTINCT DCODE,MCODE,MNAME FROM RWS_MANDAL_TBL WHERE" + " DCODE=? ORDER BY MNAME");
			//System.out.println("innnnn"+query);
			ps = conn.prepareStatement(query);
			ps.setString(1,dcode);
			rs = ps.executeQuery();
			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setDistrictCode(rs.getString(1));
				rwsLocation.setMandalCode(rs.getString(2));
				rwsLocation.setMandalName(rs.getString(3));
				rwsLocation.setCodeName(rs.getString(3)+" - "+rs.getString(2));
				mandals.add(rwsLocation);
			}
		}
		catch (Exception e)
		{
			//System.out.println("The error in getMandals()=== RwsLocations "+e);
		}
		finally 
		{
			closeAll();
		}
		Debug.println("mandals size:"+mandals.size());
		return mandals;
	}

	public ArrayList getPanchayats(String dcode, String mcode) {
		// TODO Auto-generated method stub
		ArrayList panchyats=new ArrayList();
		try
		{
		Connection	conn = RwsOffices.getConn();
		Statement	stmt = conn.createStatement();
			String query="SELECT DISTINCT PCODE,PNAME FROM RWS_PANCHAYAT_TBL WHERE" +
			" DCODE='"+dcode+"' and MCODE='"+mcode+"' ORDER BY PNAME";
			//System.out.println("query in getPanchayats is "+query);
			ResultSet rs =stmt.executeQuery(query);
			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setPanchayatCode(rs.getString(1));
				rwsLocation.setPanchayatName(rs.getString(2));
				rwsLocation.setCodeName(rs.getString(2)+" - "+rs.getString(1));
				panchyats.add(rwsLocation);
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		finally 
		{
			closeAll();
		}
		return panchyats;
	}

	public ArrayList getVillages(String dcode, String mcode,
			String pcode) {
		// TODO Auto-generated method stub
		ArrayList villages=new ArrayList();
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String query="SELECT DISTINCT VCODE,VNAME FROM RWS_VILLAGE_TBL WHERE" +
			" DCODE='"+dcode+"' AND MCODE='"+mcode+"' AND PCODE='"+pcode+"' ORDER BY VNAME";
			//System.out.println("query in getVillages is "+query);
			rs =stmt.executeQuery(query);
			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setVillageCode(rs.getString(1));
				rwsLocation.setVillageName(rs.getString(2));
				rwsLocation.setCodeName(rs.getString(2)+" - "+rs.getString(1));
				villages.add(rwsLocation);
			}
		}
		catch (Exception e)
		{
			//System.out.println("The error in getVillageCodes ==in== RwsLocation"+e);
		}
		finally 
		{
			closeAll();
		}
		return villages;
	}

	public ArrayList getHabitations(String dcode, String mcode,
			String pcode, String vcode, DataSource dataSource2) {
		// TODO Auto-generated method stub
		ArrayList habs=new ArrayList();
		  
		 String query="";
		try
		{
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			Statement stmt1 = conn.createStatement();
			query="SELECT HAB_CODE,PANCH_CODE,PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL WHERE" +
			" SUBSTR(HAB_CODE,1,2)='"+dcode+"' AND SUBSTR(HAB_CODE,6,2)='"+mcode+"' AND " +
			"SUBSTR(HAB_CODE,13,2)='"+pcode+"' AND SUBSTR(HAB_CODE,8,3)='"+vcode+"'";
			//System.out.println("query in getHabitations is "+query);
			rs =stmt.executeQuery(query);

			while ( rs.next() ) 
			{
				rwsLocation = new RwsLocationBean();
				rwsLocation.setHabitationCode(rs.getString(1));
				rwsLocation.setHabCode(rs.getString(2));
				rwsLocation.setHabName(rs.getString(3)+" - "+rs.getString(2));
				habs.add(rwsLocation);
				
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		finally 
		{
			closeAll();
		}
		return habs;
	}

	 public static ArrayList getSelectedAssets(String source, String habCode)
	            throws Exception {
	        RwsMaster rwsMaster = null;
	        ArrayList selsource = new ArrayList();
	        Statement stmt1 = null, stmt2 = null, stmt3 = null, stmt4 = null;
	        ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null;
	        String qry = "";
	        try {
	       Connection conn = RwsOffices.getConn();
	       Statement stmt = conn.createStatement();

	            if (source != null ) {
	                qry = "select ASSET_CODE,ASSET_NAME,decode(TYPE_OF_ASSET_CODE,'01','PWS','02','MPWS','03','CPWS','04','HANDPUMPS','05','SHALLOW HAND PUMPS','06','OPEN WELLS','07','PONDS','08','OTHERS','09','DIRECT PUMPING','10','SUSTAINABILITY','11','SCHOOLS','12','LAB'),LOCATION,HAB_CODE,decode(ASSET_STATUS,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED') from RWS_ASSET_MAST_TBL where HAB_CODE='"+habCode+"' and TYPE_OF_ASSET_CODE='"+source+"'";
	               // Debug.println("SElected Sources:" + qry);
	                System.out.println("ASSET QUERY"+qry);
	               ResultSet rs = stmt.executeQuery(qry);
	                while (rs.next()) {
	                    rwsMaster = new RwsMaster();
	                    rwsMaster.setAssetCode(rs.getString(1));
	                    rwsMaster.setAssetName(rs.getString(2));
	                    rwsMaster.setAssettype(rs.getString(3));
	                    rwsMaster.setLocation(rs.getString(4));
	                    rwsMaster.setHabitation(rs.getString(5));
	                    rwsMaster.setAssetstatus(rs.getString(6));
	                    selsource.add(rwsMaster);
	                }
	                if (rs != null) {
	                    rs.close();
	                }
	                if (stmt != null) {
	                    stmt.close();
	                }
	            }
	            System.out.println("Asset List SIZE "+selsource.size());
	           
	        } catch (Exception e) {
	            //Debug.println("Exception in getSelected Sources method");
	        } finally {

	        }

	        return selsource;
	    }
	 public static String getHabName(String habCode)
				throws Exception {
			RwsMasterData rwsMasterData = new RwsMasterData();
			//connCount--;
			//rwsMasterData.conn = conn;
			String name = null;
			rwsMasterData.stmt1 = null;
			rwsMasterData.rs1 = null;
			Statement stmt=null;
			try {
				Debug.println("in getHabName");
				//Debug.println("ConnCount is " + connCount);
				 Connection conn = RwsOffices.getConn();
			        stmt = conn.createStatement();
			       String query="SELECT PANCH_NAME FROM rws_panchayat_raj_tbl WHERE panch_code ="+habCode;
			       System.out.println("hab query"+query);
					ResultSet rs1=stmt.executeQuery(query);
				while (rs1.next()) {
					name = rs1.getString(1);

				}
				System.out.println("hab name"+name);
			} catch (Exception e) {
				Debug.println("The error in getHabName=" + e);
			} finally {
				stmt.close();
			}
			return name;
		}
	public List getHandPumpDetails(ConverstionOfSchemeForm panchRajForm) {
		// TODO Auto-generated method stub
		List list=new ArrayList();
		rws_ConversionOfScheme_EntryAct_DAO conversiondao=new rws_ConversionOfScheme_EntryAct_DAO();
		 RwsMaster rwsMaster = null;
	        ArrayList selsource = new ArrayList();
	        Statement stmt1 = null, stmt2 = null, stmt3 = null, stmt4 = null;
	        ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null;
	        String qry = "";
	        try {
	       Connection conn = RwsOffices.getConn();
	       Statement stmt = conn.createStatement();
	       query = "select  HP.LOCATION ,HP.PLATFORM_EXISTING,HP.DIAMETER ,HP.CASING ,HP.GEN_CONDITION ,HP.GI_NO ,HP.PAINTED,HP.STATIC_WL  ,HP.SUMMER_WL ,HP.P_COND ,HP.DRY_DURING,HP.SER_NO ,HP.SER_HRS ,HP.REPAIRS ,HP.PLATFORM_CONDITION ,HP.DRAIN ,HP.DRAIN_CONDITION ,HP.DRAIN_SD ,HP.DRAIN_LP ,HP.HYGIENE ,HP.AVG_TIME ,HP.P_YEILD ,HP.PYEILD_LOCAL ,HP.PERIOD ,HP.ASSET_CODE,HP.hp_code,HP.PIPE_LENGTH,HP.depth,HP.QUALITY_AFFECTED, HP.FLOURIDE,HP.BRAKISH ,HP.IRON,HP.cont_others_type,HP.CONT_OTHERS_PER,nvl(hp.latitude,'0') as latitude,nvl(hp.longitude,'0') as longitude,nvl(hp.elevation,'0') as elevation,nvl(hp.way_point,'0') as way_point  from RWS_HP_SUBCOMP_PARAM_TBL HP where HP.ASSET_CODE='"
	       +panchRajForm.getAssetCode()+ "' order by hp.hp_code";
	       ResultSet rs=stmt.executeQuery(query);
			System.out.println("EGR hp"+query);
			if (!rs.isBeforeFirst())
			{
				//parameters.add(rwsMaster);
			}
			else
			{
				while (rs.next()) {
                   System.out.println("Coming to while loop");
					rwsMaster = new RwsMaster();
					rwsMaster.setLocation(rs.getString("LOCATION"));
					rwsMaster.setHabitation(conversiondao.getHabName(rs.getString("HP_CODE")).substring(0, 16));
					rwsMaster.setDiameter(rs.getString("DIAMETER"));
					rwsMaster.setCasing(rs.getString("CASING"));
					rwsMaster.setGenCondition(rs.getString("GEN_CONDITION"));
					rwsMaster.setGino(rs.getString("GI_NO"));
					rwsMaster.setPipeLength(rs.getString("PIPE_LENGTH"));
					rwsMaster.setPainted(rs.getString("PAINTED"));
					rwsMaster.setStaticWaterLevel(rs.getString("STATIC_WL"));
					rwsMaster.setSummerWaterLevel(rs
							.getString("SUMMER_WL"));
					rwsMaster.setPcond(rs
							.getString("PLATFORM_EXISTING"));
					
					rwsMaster
							.setSerno(rs.getString("SER_NO"));
					rwsMaster.setSerhrs(rs
							.getString("SER_HRS"));
					rwsMaster.setRepairs(rs
							.getString("REPAIRS"));
					rwsMaster.setPlatformCondition(rs
							.getString("PLATFORM_CONDITION"));
					rwsMaster.setDrain(rs.getString("DRAIN"));
					rwsMaster.setDrainCondition(rs
							.getString("DRAIN_CONDITION"));
					rwsMaster.setDrainsd(rs
							.getString("DRAIN_SD"));
					rwsMaster.setDrainlp(rs
							.getString("DRAIN_LP"));
					rwsMaster.setHygiene(rs
							.getString("HYGIENE"));
					rwsMaster.setAvgtime(rs
							.getString("AVG_TIME"));
					rwsMaster.setPyield(rs
							.getString("P_YEILD"));
					rwsMaster.setPyieldLocal(rs
							.getString("PYEILD_LOCAL"));
					rwsMaster.setPeriod(rs
							.getString("PERIOD"));
					rwsMaster.setAssetCode(rs
							.getString("ASSET_CODE"));
					rwsMaster.setHpCode(rs
							.getString("HP_CODE"));
					rwsMaster.setHabCode(rwsMaster.getHpCode().substring(0,16));
					rwsMaster.setDepth(rs.getInt("DEPTH"));
					rwsMaster.setQualityAffected(rs
							.getString("QUALITY_AFFECTED"));
					rwsMaster.setFlouride(rs
							.getDouble("FLOURIDE"));
					rwsMaster.setBrakish(rs
							.getDouble("BRAKISH"));
					rwsMaster.setIron(rs.getDouble("IRON"));
					rwsMaster.setOthersType(format(rs
							.getString("cont_others_type")));
					rwsMaster.setOthers(rs
							.getString("CONT_OTHERS_PER"));
					//bhagya
					String query2="select nvl(COMPO_LAT,'0') as COMPO_LAT,nvl(COMPO_LON,'0') as COMPO_LON,COMPO_IMAGE from RWS_ASSET_COMPONENT_IMAGE_TBL where ASSET_CODE='"+panchRajForm.getAssetCode()+"' and ASSET_COMPONENT='"+rs.getString("HP_CODE")+"'";
					
					Statement st2=conn.createStatement();
	                rs2 = st2.executeQuery(query2);
	                System.out.println("quer2"+query2);
	                if(rs2.next()){
	                    java.sql.Blob a=  rs2.getBlob("COMPO_IMAGE");
	                    if(a==null){
	                    	rwsMaster.setImageStatus("No");
	                    }
	                    else
	                    {
	                    	rwsMaster.setImageStatus("Yes");
	                    }
	                    rwsMaster.setLatitude(format(rs2
	                                        .getString("COMPO_LAT")));
	                    rwsMaster.setLongitude(format(rs2
	                                        .getString("COMPO_LON")));
	                                   
	                }
					
					//added by swapna on 20-01-2012 for gis data entry
					/*rwsMaster.setLatitude(rwsMasterData.rs
							.getString("latitude"));
					rwsMaster.setLongitude(rwsMasterData.rs
							.getString("longitude"));*/
					rwsMaster.setElevation(rs
							.getString("elevation"));
					rwsMaster.setWaypoint(format(rs
							.getString("way_point")));
					//
					System.out.println("watpoint"+rwsMaster.getWaypoint());
					list.add(rwsMaster);
					
				}
			}
			System.out.println("Hp Sub Comp Param List Size is"+list.size());
	        } catch (Exception e) {
	            //Debug.println("Exception in getSelected Sources method");
	        } finally {

	        }

		return list;
	}
	
}
