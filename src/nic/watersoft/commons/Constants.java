package nic.watersoft.commons;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class Constants implements Serializable {	
	static String progCode="";
	public static String getNrdwp(){
		progCode="";
		Connection  conn=null;
		try{
			 conn=RwsOffices.getConn();
		
		String nrdwpQuery="select PROGRAMME_CODE from  rws_programme_tbl where NRDWP_RELATED='Y' and CENTRE_STATE_DISTRICT<>'D' order by 1";
		Statement statement=conn.createStatement();
		ResultSet  resultSet=statement.executeQuery(nrdwpQuery);
		while(resultSet.next()){
			if(!progCode.equals("")){
			progCode=progCode+","+resultSet.getString(1);
			}
			else{
				progCode=resultSet.getString(1);
			}
		}
		String CmDBQuery = "select PROGRAMME_CODE from  rws_programme_tbl where CM_CORE_DB='Y' and NRDWP_RELATED='N' and CENTRE_STATE_DISTRICT<>'D' order by 1";
		Statement stmtCmDB = conn.createStatement();
		ResultSet rsCmDB = stmtCmDB.executeQuery(CmDBQuery);
		while (rsCmDB.next()) {
			if(!progCode.equals("")){
				progCode=progCode+","+rsCmDB.getString(1);
				}
				else{
					progCode=rsCmDB.getString(1);
				}
		}
		//System.out.println("progCode"+progCode);
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
		return progCode;
	}	
	
	public static boolean IsUser(String userId) {
		ValidationUtils validuser=new ValidationUtils(); 
		if(userId.substring(0, 1).equals("1") && validuser.numValidator(userId) && validuser.maxLenghtValidator(userId, 6)) {
			return true;
		}		
		return false;
	}
	
	public static boolean IsEEUser(String userId) {
		ValidationUtils validuser=new ValidationUtils(); 
		if(userId.substring(0, 1).equals("1") && userId.substring(4, 6).equals("EE")  && validuser.maxLenghtValidator(userId, 6)) {
			return true;
		}		
		return false;
	}
	public static boolean IsCollectorUser(String userId) {
		ValidationUtils validuser=new ValidationUtils(); 
		if(userId.substring(0, 3).equals("col")  ) {
			return true;
		}		
		return false;
	}
	public static boolean IsAOUser(String userId) {
		ValidationUtils validuser=new ValidationUtils(); 
		if(userId.substring(0, 1).equals("1") && userId.substring(4, 6).equals("AO")  && validuser.maxLenghtValidator(userId, 6)) {
			return true;
		}		
		return false;
	}
	
	public static boolean IsWaterQualityUser(String userId) {
		ValidationUtils validuser=new ValidationUtils(); 
		if(userId.substring(0, 1).equals("1") && userId.substring(4, 6).equals("WQ")  && validuser.maxLenghtValidator(userId, 6)) {
			return true;
		}		
		return false;
	}


	public static final String RWS_USER = "RWS_USER";

	public static final String SEC_USER = "secrwss";

	public static final String ADMIN = "admin";

	public static final String LAKH_USER = "100000";
	
	public static final String GUEST = "guest";

	public static final String DROUGHT_USER = "1000DR";

	public static final String ENC = "ENC";

	public static final String EE_BUDGET = "EE-Budget";

	public static final String HO_ADMN = "HO-ADMIN";	
	
	public static final String MINISTER = "minrwss";
	
	public static final String NRDWP_RELATED = getNrdwp();

	public static final String TYPE_A_BILL = "A";

	public static final String TYPE_B_BILL = "B";

	public static final int LANDAQUISITION_CHRG = 1;

	public static final int WATERDRAWLPERMISSION_CHRG = 2;

	public static final int RAILWAYCROSSINGPERMISSION_CHR = 3;

	public static final int ROADCROSSINGPERMISSION_CHRG = 4;

	public static final int ROADCROSSINGPERMISSIONNHAI_CHRG = 5;

	public static final int FORESTCLEARANCE_CHRG = 6;

	public static final int POWERAPTRANSCO_CHRGS = 7;

	public static final int HMWS_CHRGS = 8;

	public static final int OTHERSCHRG = 9;

	public static final int GROUNDWATERINVESTIGATION_CHG = 10;

	public static final int YIELDTESTING_CHG = 11;

	public static final int SOURCECREATION_CHG = 12;

	public static final int DPR_CHARGES = 13;
	
	
}