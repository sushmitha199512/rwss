package nic.watersoft.masters;
import nic.watersoft.commons.Debug;
import java.sql.BatchUpdateException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;

import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.LabelValueBean;
//import nic.watersoft.commons.Debug;
import nic.watersoft.commons.CommonLists;
import nic.watersoft.reports.rws_asset_CheckList_Bean;
import nic.watersoft.wquality.RwsWQuality;

public class EmpMasterData {
	
	public static int connCount=0;

	Connection conn = null;
	
	Statement stmt = null;

	Statement stmt1 = null;
	
	Statement stmt2 = null;
	
	Statement stmt3 = null;
	
	Statement stmt4 = null;

	ResultSet rs = null;

	static ResultSetMetaData rsm = null;

	ResultSet rs1 = null;
	
	ResultSet rs2 = null;
	
	ResultSet rs3 = null;
	
	ResultSet rs4 = null;

	static PreparedStatement ps = null;

	static SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");

	public static String errorMessage;

	static HttpSession session;

	public  void closeAll() throws Exception {
		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				//System.out.println("The error in EmpMasterData" + e);
			}
			rs = null;
		}
		if (rs1 != null) {
			try {
				rs1.close();
			} catch (Exception e) {
				//System.out.println("The error in EmpMasterData" + e);
			}
			rs1 = null;
		}
		if (rs2 != null) {
			try {
				rs2.close();
			} catch (Exception e) {
				//System.out.println("The error in EmpMasterData" + e);
			}
			rs2 = null;
		}
		if (rs3 != null) {
			try {
				rs3.close();
			} catch (Exception e) {
				//System.out.println("The error in EmpMasterData" + e);
			}
			rs3 = null;
		}
		if (rs4 != null) {
			try {
				rs4.close();
			} catch (Exception e) {
				//System.out.println("The error in EmpMasterData" + e);
			}
			rs4 = null;
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (Exception e) {
				//System.out.println("The error in closeAll=" + e);
			}
			stmt = null;
		}
		if (stmt1 != null) {
			try {
				stmt1.close();
			} catch (Exception e) {
				//System.out.println("The error in closeAll=" + e);
			}
			stmt1 = null;
		}
		if (stmt2 != null) {
			try {
				stmt2.close();
			} catch (Exception e) {
				//System.out.println("The error in closeAll=" + e);
			}
			stmt2 = null;
		}
		if (stmt3 != null) {
			try {
				stmt3.close();
			} catch (Exception e) {
				//System.out.println("The error in closeAll=" + e);
			}
			stmt3 = null;
		}
		if (stmt4 != null) {
			try {
				stmt4.close();
			} catch (Exception e) {
				//System.out.println("The error in closeAll=" + e);
			}
			stmt4 = null;
		}
		if (ps != null) {
			try {
				ps.close();
			} catch (Exception e) {
				//System.out.println("The error in closeAll=" + e);
			}
			ps = null;
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
				//System.out.println("The error in closeAll=" + e);
			}
			conn = null;
		}
		
	}

	//*******************************Contam
	// methods**********************************

	public static int insertContam(RwsMaster empMaster, DataSource dataSource)
			throws Exception {  
		EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		
		try {
			
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			String quer1="insert into RWS_CONTAMINATION_TBL values(?,?)";
			 PreparedStatement pst=  empMasterData.conn.preparedStatement(quer1);     
        pst.setString(1,empMaster.getContamCode());    
        pst.setString(1,empMaster.getContamName().toUpperCase() );    
        rowCount = pst.executeUpdate();
					
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println("The error in insertContam" + e);
		}

		finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getContam(String contamCode,DataSource dataSource)
			throws Exception {  
		EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt
					.executeQuery("select * from RWS_CONTAMINATION_TBL where CONTAMINATION_CODE=?");
			stmt.setString(1,contamCode);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setContamCode(empMasterData.rs.getString(1));
				empMaster.setContamName(empMasterData.rs.getString(2));
			}
		} catch (Exception e) {
			//System.out.println("The error in getContam" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getContams(DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList contams = new ArrayList();
		
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt
					.executeQuery("select * from RWS_CONTAMINATION_TBL order by CONTAMINATION_CODE");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setContamCode(empMasterData.rs.getString(1));
				empMaster.setContamName(empMasterData.rs.getString(2));

				empMaster.setContamNoName(empMasterData.rs.getString(1) + " - "
						+ empMasterData.rs.getString(2));

				contams.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getContams" + e);
		} finally {
			empMasterData.closeAll();
		}
		return contams;
	}

	public static int removeContam(String contamCode, DataSource dataSource)
			throws Exception {  
		EmpMasterData empMasterData=new EmpMasterData();
		int rcount = 0;
		
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			String qr="delete  from RWS_CONTAMINATION_TBL where CONTAMINATION_CODE=?"
			PreparedStatement ps= empMasterData.conn.PreparedStatement(qr) 
			ps.setString(1, contamCode);
			rcount = empMasterData.stmt.executeUpdate();
			
		} catch (Exception e) {
			//System.out.println("The error in removeContam=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rcount;
	}

	public static int updateContam(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int updateCount = 0;
		
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			
		PreparedStatement ps= empMasterData.conn.prepareStatement("update  RWS_CONTAMINATION_TBL set CONTAMINATION_NAME=? where CONTAMINATION_CODE=?");
		ps.setString(1,empMaster.getContamName().toUpperCase());
		ps.setString(2,empMaster.getContamCode());
		updateCount = ps.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			//System.out.println("The error in updateContam " + sqle);
		} catch (Exception e) {
			//System.out.println("The error in updateContam" + e);
		} finally {
			empMasterData.closeAll();
		}
		return updateCount;
	}

	public static String getContamCode(DataSource dataSource) throws Exception {  
		EmpMasterData empMasterData=new EmpMasterData();
		String code = null;
		
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt
					.executeQuery("SELECT MAX(to_number(CONTAMINATION_CODE))+1 FROM RWS_CONTAMINATION_TBL");
			empMasterData.rs.next();
			code = empMasterData.rs.getString(1);
			if (code == null) {
				code = "01";
			} else if (code.length() == 1) {
				code = "0" + code;
			}
		} catch (Exception e) {
			//System.out.println("The error in getContamCode=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	public static String getContamCode(String name, Connection conn)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		empMasterData.conn=conn;
		String acode = null;
		try {
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt
					.executeQuery("SELECT CONTAMINATION_CODE FROM RWS_CONTAMINATION_TBL where CONTAMINATION_NAME='"
							+ name + "'");
			empMasterData.rs.next();
			acode = empMasterData.rs.getString(1);
		} catch (Exception e) {
			//System.out.println("The error in getContamCode=" + e);
		} finally {
			empMasterData.stmt.close();
		}
		return acode;
	}

	//***********************Designation
	// Methods**************************************************
	public static int insertDesgn(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		String query="";
		
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			query="insert into rws_designation_tbl values(?,?,?,?)";
			
			PreparedStatement pst= empMasterData.preparedStatement(query);
			pst.setString(1, empMaster.getDesgnCode());
			pst.setString(2, empMaster.getDesgnAcr().toUpperCase());
			pst.setString(3, eempMaster.getDesgnName().toUpperCase());
			pst.setString(4, empMaster.getDesgnType().toUpperCase());
			rowCount = ps.executeUpdate();
			//System.out.println("insert query Desig "+query);
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			//System.out.println("The error in insertDesgn " + sqle);
		} catch (Exception e) {

			//System.out.println("The error in insertDesgn=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getDesgn(String desgnCode, DataSource dataSource)
			throws Exception { 
		EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from rws_designation_tbl where designation_code="+ desgnCode);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setDesgnCode(empMasterData.rs.getString(1));
				empMaster.setDesgnAcr(empMasterData.rs.getString(2));
				empMaster.setDesgnName(empMasterData.rs.getString(3));
				empMaster.setDesgnType(empMasterData.rs.getString(4));
				
				//System.out.println("Desgn Type in Edit Part "+empMaster.getDesgnType());
			}
		} catch (Exception e) {
			//System.out.println("The error in getDesgn=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getDesgns(DataSource dataSource) throws Exception {   
		EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList desgns = new ArrayList();
		
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from rws_designation_tbl order by designation_code");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setDesgnCode(empMasterData.rs.getString(1));
				empMaster.setDesgnAcr(empMasterData.rs.getString(2));
				empMaster.setDesgnName(empMasterData.rs.getString(3));
				empMaster.setDesgnType(empMasterData.rs.getString(4));
				
				desgns.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getDesgns=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return desgns;
	}

	public static ArrayList getDesgns1(DataSource dataSource) throws Exception {   
		EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList desgns = new ArrayList();
		
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select DESIGNATION_CODE ,DESIGNATION_NAME  from rws_designation_tbl order by designation_code");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setLabel(empMasterData.rs.getString("DESIGNATION_NAME"));
				empMaster.setValue(empMasterData.rs.getString("DESIGNATION_CODE"));
				desgns.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getDesgns=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return desgns;
	}

	public static ArrayList getSector1(DataSource dataSource)throws Exception
	{
		EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster=null;
		ArrayList sectorcode=new ArrayList();
		String query=null;
		try
		{
			empMasterData.conn=dataSource.getConnection();
			empMasterData.stmt=empMasterData.conn.createStatement();
			query="SELECT * FROM RWS_HEAD_OFFICE_TBL ORDER BY HEAD_OFFICE_CODE ";
			empMasterData.rs=empMasterData.stmt.executeQuery(query);
			//System.out.println(query);
			while(empMasterData.rs.next())
			{
				empMaster=new EmpMaster();
				empMaster.setLabel(empMasterData.rs.getString("HEAD_OFFICE_NAME"));
				empMaster.setValue(empMasterData.rs.getString("HEAD_OFFICE_CODE"));
				sectorcode.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getSector1=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return sectorcode;
	}
	//code added for Emp Status Form
	
	public static String[] getDesignations(DataSource dataSource) throws Exception {   
		EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		String designations[] = new String[50];
		
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from rws_designation_tbl order by designation_code");
			int i=0;
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setDesgnName(empMasterData.rs.getString(3));
				designations[i]=empMaster.getDesgnName();
			}
		} catch (Exception e) {
			//System.out.println("The error in getDesgns=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return designations;
	}
	
	
	
	//for getting the Zones
	public static String[] getEmpZones(DataSource dataSource)
	throws Exception {   
	EmpMasterData empMasterData=new EmpMasterData();
	EmpMaster empMaster = null;
	String designations[]= new String[50];

	try {
	//System.out.println("in getZones");
		//System.out.println("ConnCount is "+connCount);
	empMasterData.conn = dataSource.getConnection();
	empMasterData.stmt = empMasterData.conn.createStatement();
	empMasterData.rs =empMasterData.stmt.executeQuery("SELECT * FROM RWS_ZONE_MST_TBL order by ZONE_CODE");
	int i=0;
	while (empMasterData.rs.next()) {
		empMaster = new EmpMaster();
		empMaster.setZoneName(empMasterData.rs.getString(3));
		designations[i]=empMaster.getZoneName();
	}
	}

	catch (Exception e) {
	//System.out.println("The error in zoneName" + e);
	} finally {
	empMasterData.closeAll();
	//System.out.println("ConnCount after closing is "+connCount);
	}
	return designations;
	}
	
	
	
	//end of Code added
	
	public static int removeDesgn(String desgnCode,DataSource dataSource)
			throws Exception {  
		EmpMasterData empMasterData=new EmpMasterData();
		int rcount = 0;
		
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			String query="delete from rws_designation_tbl where designation_code=?";
			PreparedStatement ps= empMasterData.stmt.preparedStatement(query);
			ps.setString(1, desgnCode);
			rcount = ps.executeUpdate();
			//System.out.println("delete query "+query);
		} catch (Exception e)
		{
			//System.out.println("The error in removeDesgn=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rcount;
	}

	public static int updateDesgn(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int updateCount = 0;
		
		try {
			empMasterData.conn = dataSource.getConnection();
			ps = empMasterData.conn
					.prepareStatement("update rws_designation_tbl set designation_name=?,designation_acr=?,TEMP_PERMNENT=?  where designation_code=?");
			ps.setString(1, empMaster.getDesgnName().toUpperCase());
			ps.setString(2, empMaster.getDesgnAcr().toUpperCase());
			ps.setString(4, empMaster.getDesgnCode());
			ps.setString(3, empMaster.getDesgnType());
			updateCount = ps.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			//System.out.println("The error in insertDesgn " + sqle);
		} catch (Exception e) {
			//System.out.println("The error in updateDesgn=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return updateCount;
	}

	public static String getDesgnCode(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData=new EmpMasterData();
		String code = null;
		
		try {
			empMasterData.conn = dataSource.getConnection();

			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT MAX(to_number(DESIGNATION_CODE))+1 FROM rws_designation_tbl");
			empMasterData.rs.next();
			code = empMasterData.rs.getString(1);
			if (code == null)
				code = "1";
		} catch (Exception e) {
			//System.out.println("The error in getDesgnCode" + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	//-----------------------------qualification
	// methods---------------------------------

	public static int insertQual(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps=empMasterData.conn.preparedStatement("insert into RWS_QUALIFICATION_TBL values(?,?)");
			ps.setString(1,empMaster.getQualCode());
			ps.setString(2,  empMaster.getQualName().toUpperCase());
			rowCount = ps.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			//System.out.println("The error in updateQual " + sqle);
		} catch (Exception e) {
			//System.out.println("The error in insertQual=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getQual(String qualCode, DataSource dataSource)
			throws Exception {   
		EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt.executeQuery("select * from RWS_QUALIFICATION_TBL where qual_code="
							+ qualCode);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setQualCode(empMasterData.rs.getString(1));
				empMaster.setQualName(empMasterData.rs.getString(2));
			}
		} catch (Exception e) {
			//System.out.println("The error in getQual=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getQuals(DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList quals = new ArrayList();
		
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from RWS_QUALIFICATION_TBL order by qual_code");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setQualCode(empMasterData.rs.getString(1));
				empMaster.setQualName(empMasterData.rs.getString(2));

				quals.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getQuals" + e);
		} finally {
			empMasterData.closeAll();
		}
		return quals;
	}

	public static int removeQual(String qualCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rcount = 0;
		
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps= empMasterData.conn.PrepareStatement("delete  from RWS_QUALIFICATION_TBL where qual_code=?");
			ps.setString(1,qualCode);
			rcount = ps.executeUpdate();
		} catch (Exception e) {
			//System.out.println("The error in removeQual=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rcount;
	}

	public static int updateQual(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int ans = 0;
		
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps=empMasterData.conn.prepareStatement("update RWS_QUALIFICATION_TBL set qual_name=?  where qual_code=?)"); 
			ps.setString(1,empMaster.getQualName().toUpperCase());
			ps.setString(2,empMaster.getQualCode());
			ans = ps.executeUpdate();
					
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			//System.out.println("The error in updateQual " + sqle);
		} catch (Exception e) {
			//System.out.println("The error in updateQual" + e);
		} finally {
			empMasterData.closeAll();
		}
		return ans;
	}

	public static String getQualCode(DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String qcode = null;
		
		try {
			empMasterData.conn = dataSource.getConnection();

			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT MAX(to_number(QUAL_CODE))+1 FROM RWS_QUALIFICATION_TBL");
			empMasterData.rs.next();
			qcode = empMasterData.rs.getString(1);
			if (qcode == null) {
				qcode = "1";
			}
		} catch (Exception e) {
			//System.out.println("The error in getQualCode=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return qcode;
	}

	//*******************************************Employee
	// Methods****************************************
	
public static int[] insertEmp(EmpMaster empMaster, DataSource dataSource)
	throws Exception {   
EmpMasterData empMasterData=new EmpMasterData();
EmpMaster empMaster1=new EmpMaster();
int rowCount[] = null;
String desgcode=null;
boolean inserted=false;
String var1=null;

try {
	////System.out.println("in insertEmp");
	////System.out.println("ConnCount is "+connCount);
	empMasterData.conn = dataSource.getConnection();
	empMasterData.stmt = empMasterData.conn.createStatement();
	
	empMaster1=EmpMasterData.getEmp(empMaster.getEmpcode(),dataSource);
	if(empMaster1!=null && empMaster1.getEmpcode().equals(empMaster.getEmpcode()))
     return rowCount;	
	else
	{
	
String query="insert into rws_employee_tbl(EMPLOYEE_CODE,EMPLOYEE_SURNAME,EMPLOYEE_NAME,SEX,FATHER_NAME,DATE_OF_BIRTH,RELG_CODE,CASTE_CODE,NATIVE_DISTRICT,NATIVE_MANDAL," +
			 "NATIVE_REV_DIVISION,QUAL_CODE,PH,DIST_CLASS_IV,DIST_CLASS_V,DIST_CLASS_VI,DIST_CLASS_VII,DIST_CLASS_VIII,DIST_CLASS_IX,DIST_CLASS_X,LOCAL_DIST_AS_PER_SCH," +
			 "LOCAL_ZONE,NOOF_YEARS_STUDIED_IN_DIST,NOOF_YEARS_STUDIED_IN_ZONE,PRIVATE_PASSED_DIST,PRIVATE_PASSED_ZONE,TEMP_PERMNENT,DESIGNATION_CODE,APPOINT_CATEGORY," +
			 "APPOINTMENT_DATE,DATE_OF_JOINING,MOAP_CODE,ZONE_CODE,RECRUIT_LOCAL_NONLOCAL,APCATEG_CODE,DATE_OF_COMMENCE_PROBATION,DATE_OF_REGULARISATION,CURRENT_POST_HELD_FROM," +
			 "PROMOTION_DT_PRESENT_DESG,ACCTEST_PASSED,ACCTEST_PASS_DATE,ADD_QUAL_1,ADD_QUAL_2,PRESENT_DESIG,WORK_SPECIALIZATION,OTHER_DETAILS,OFFICE_CODE,SECTION,DEPT_OPTED," +
			 "SECTOR,DEPUTATION,DEPUTATION_FROM,SENIORITY,DISCIPLINE_CASE,DISCIPLINE_TYPE,PAN_NO,APGLI_NO,GPF_NO,PRESENT_PAY_SCALE,INCREMENT_DATE,UPDATE_DATE," +
			 "DEPUTATION_DEPT,DATE_OF_LEAVE,LEAVE_SUSPENDED)values('"
			 + empMaster.getEmpcode()+ "','"
			 + empMaster.getSurname().toUpperCase()+"','"
			 + empMaster.getEmpname().toUpperCase()+"','"
			 + empMaster.getGender()+"','"
			 + empMaster.getRelation()+"',TO_DATE('"
			 + empMaster.getDob()+ "','dd/mm/yyyy'),"+"'"
			 + empMaster.getReligion()+"','" 
			 + empMaster.getSocial()+"','"
			 + empMaster.getNdist()+"','"+format(empMaster.getNmand())+"','"
			 + empMaster.getNrevenue()+"','"
			 + format(empMaster.getQual())+"','"+format(empMaster.getHandicap())+"','"
			 + empMaster.getDiststudied4()+"','"+empMaster.getDiststudied5()+"','"+empMaster.getDiststudied6()+"','"+empMaster.getDiststudied7()+"','"+empMaster.getDiststudied8()+"','"
			 + empMaster.getDiststudied9()+"','"+empMaster.getDiststudied10()+"','"+empMaster.getLocaldist()+"','"
			 + empMaster.getLocalzone()+"','"+empMaster.getNoofyrs()+"','"+empMaster.getNoofyrs1()+"','"+empMaster.getPvtdist()+"','"+empMaster.getPvtzone()+"','"
			 + empMaster.getDesig()+"','"+empMaster.getDesgnCode()+"','"+ empMaster.getApptcategory()+"',TO_DATE('"+empMaster.getAppointdate()+"','dd/mm/yyyy'),TO_DATE('"
			 + empMaster.getDoj()+"','dd/mm/yyyy'),'"+ empMaster.getMoap()+"','"+ empMaster.getZone()+"','"
			 + empMaster.getNarecruit()+"','"+empMaster.getApcatog()+"',TO_DATE('"
			 + empMaster.getDcommprob()+ "','dd/mm/yyyy'),TO_DATE('"
			 + empMaster.getDdeclprob()+ "','dd/mm/yyyy'),TO_DATE('"
			 + empMaster.getCurrentpostdate()+"','dd/mm/yyyy'),TO_DATE('"
			 + empMaster.getPromotedate()+"','dd/mm/yyyy'),'"
			 + format(empMaster.getTestpassed())+"',TO_DATE('"+empMaster.getDacctest()+"','dd/mm/yyyy'),'"
			 + empMaster.getAddqual1()+"','"+empMaster.getAddqual2()+"','"
			 + empMaster.getPresentdesig()+"','"+empMaster.getWorkSpecial()+"','"
			 + empMaster.getOtherDet()+"','"+empMaster.getRoc()+"','"
			 + empMaster.getSection()+"','"+format(empMaster.getDept())+"','"
			 + empMaster.getHoc()+"','"+format(empMaster.getDeputation())+"',TO_DATE('"
			 + empMaster.getDeputationDate()+"','dd/mm/yyyy'),'"+empMaster.getSeniority()+"','"
			 + format(empMaster.getDisciplinecase())+"','"+empMaster.getDisciplinetype()+"','"
			 + empMaster.getPanno()+"','"+empMaster.getApgli()+"','"+empMaster.getGpfno()+"','"
			 + empMaster.getPayscale()+"',TO_DATE('"
			 + empMaster.getIncrementdate()+"','dd/mm/yyyy'),TO_DATE('"
			 + empMaster.getUpdatedate()+"','dd/mm/yyyy'),'"
			 + empMaster.getDepudept()+"',TO_DATE('"+empMaster.getLeavedate()+"','dd/mm/yyyy'),'"+ format(empMaster.getLeavesuspend())+"')";
	 
	 
////System.out.println("dept value"+empMaster.getDept());	

	empMasterData.stmt.addBatch(query);
	//System.out.println("INSERT QUERY IS EMP"+query);

query="insert into rws_employee_spouse_tbl(EMPLOYEE_CODE,SPOUSE_EMPLOYED,SPOUSE_CENTRE_STATE,"+
"SPOUSE_DISTRICT_WORK,SPOUSE_REV_DIV_WORK,SPOUSE_REV_MANDAL_WORK)values('"+empMaster.getEmpcode()+"','"+format(empMaster.getSpouseemployd())+"','"
+format(empMaster.getSpouseworking())+"','"+empMaster.getSpouseworkdist()+"','"+empMaster.getSpouseworkdiv()+"','"+empMaster.getSpouseworkmand()+"')";

empMasterData.stmt.addBatch(query);
//System.out.println("INSERT QUERY IS spouse"+query);

rowCount = empMasterData.stmt.executeBatch();
////System.out.println("after executebatch");

for (int j = 0; j < rowCount.length; j++)
{
	////System.out.println("j value"+rowCount[j]);
        if (rowCount[j]== 0)
		inserted = false;
}

if (inserted){
	var1="Record Inserted Successfully";
	empMasterData.conn.commit();
}
else
{
	var1="Record Not Inserted";
}
empMasterData.conn.setAutoCommit(true);
	}
	
} catch (Exception e) {
	for (int j = 0; j < rowCount.length; j++)
	{
		////System.out.println("j value"+rowCount[j]);
	        if (rowCount[j]== 0)
			inserted = false;
	}
	//System.out.println(e.getMessage());
} finally {
	empMasterData.closeAll();
	//System.out.println("ConnCount after closing is "+connCount);
}
return rowCount;

}

	public static EmpMaster getEmp(String empcode, DataSource dataSource)
			throws Exception {  
		EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
	
	try {
		////System.out.println("in getEmp");
		////System.out.println("ConnCount is "+connCount);
		empMasterData.conn = dataSource.getConnection();
		empMasterData.stmt = empMasterData.conn.createStatement();
		String query="select * from rws_employee_tbl e,rws_employee_spouse_tbl s where e.employee_code=s.employee_code(+) and  e.employee_code='"+empcode+"' ";
		empMasterData.rs =empMasterData.stmt.executeQuery(query);
		//System.out.println("getEmp Query="+query);
		if (empMasterData.rs.next()) {
			empMaster = new EmpMaster();
						
			empMaster.setEmpcode(empMasterData.rs.getString(2));
			////System.out.println("EMPCODE getEmp"+empMasterData.rs.getString(2));
			empMaster.setSurname(empMasterData.rs.getString("EMPLOYEE_SURNAME"));
			////System.out.println("surname getEmp"+empMasterData.rs.getString("EMPLOYEE_SURNAME"));
			empMaster.setEmpname(empMasterData.rs.getString("EMPLOYEE_NAME"));
			////System.out.println("empname getEmp"+empMasterData.rs.getString("EMPLOYEE_NAME"));
			
			empMaster.setRelation(empMasterData.rs.getString("FATHER_NAME"));
			////System.out.println("relation getEmp"+empMasterData.rs.getString("FATHER_NAME"));
			empMaster.setReligion(empMasterData.rs.getString("RELG_CODE"));
			empMaster.setSocial(empMasterData.rs.getString("CASTE_CODE"));
			////System.out.println("caste getEmp"+empMasterData.rs.getString("CASTE_CODE"));
			empMaster.setNdist(empMasterData.rs.getString("NATIVE_DISTRICT"));
			////System.out.println("Ndistrict getEmp"+empMasterData.rs.getString("NATIVE_DISTRICT"));
			empMaster.setNmand(empMasterData.rs.getString("NATIVE_MANDAL"));
			////System.out.println("Nmand getEmp"+empMasterData.rs.getString("NATIVE_MANDAL"));
			if(empMasterData.rs.getString("SEX")!=null){
			empMaster.setGender(empMasterData.rs.getString("SEX"));
			}
			empMaster.setNrevenue(empMasterData.rs.getString("NATIVE_REV_DIVISION"));
			empMaster.setQual(empMasterData.rs.getString("QUAL_CODE"));
			if(empMasterData.rs.getDate("DATE_OF_BIRTH")!= null) 
			{
				empMaster.setDob(df.format(empMasterData.rs.getDate("DATE_OF_BIRTH")));
			}
			if(empMasterData.rs.getString("PH")!=null)
			{
				empMaster.setHandicap(empMasterData.rs.getString("PH"));
			}
			
			
			if(empMasterData.rs.getString("SPOUSE_EMPLOYED")!=null)
			{
			  empMaster.setSpouseemployd(empMasterData.rs.getString("SPOUSE_EMPLOYED"));	
			 // //System.out.println("Spouse Details in RWS getEmp"+empMasterData.rs.getString("SPOUSE_EMPLOYED"));
			}
			if(empMasterData.rs.getString("SPOUSE_CENTRE_STATE")!=null)
			{
			  empMaster.setSpouseworking(empMasterData.rs.getString("SPOUSE_CENTRE_STATE"));	
			}
			if(empMasterData.rs.getString("SPOUSE_DISTRICT_WORK")!=null)
			{
			  empMaster.setSpouseworkdist(empMasterData.rs.getString("SPOUSE_DISTRICT_WORK"));
			  //System.out.println("DIstrict employeed getEmp"+empMasterData.rs.getString("SPOUSE_DISTRICT_WORK"));
			}
			if(empMasterData.rs.getString("SPOUSE_REV_MANDAL_WORK")!=null)
			{
			  empMaster.setSpouseworkmand(empMasterData.rs.getString("SPOUSE_REV_MANDAL_WORK"));
			  //System.out.println("spouse Mandal getEmp"+empMasterData.rs.getString("SPOUSE_REV_MANDAL_WORK"));
			}
			if(empMasterData.rs.getString("SPOUSE_REV_DIV_WORK")!=null)
			{
			  empMaster.setSpouseworkdiv(empMasterData.rs.getString("SPOUSE_REV_DIV_WORK"));	
			  //System.out.println("spouse work  Div getEmp"+empMasterData.rs.getString("SPOUSE_REV_DIV_WORK"));
			}
			////System.out.println("spouse details");
		
			
			empMaster.setDiststudied4(empMasterData.rs.getString("DIST_CLASS_IV"));
			empMaster.setDiststudied5(empMasterData.rs.getString("DIST_CLASS_V"));
			empMaster.setDiststudied6(empMasterData.rs.getString("DIST_CLASS_VI"));
			empMaster.setDiststudied7(empMasterData.rs.getString("DIST_CLASS_VII"));
			empMaster.setDiststudied8(empMasterData.rs.getString("DIST_CLASS_VIII"));
			empMaster.setDiststudied9(empMasterData.rs.getString("DIST_CLASS_IX"));
			empMaster.setDiststudied10(empMasterData.rs.getString("DIST_CLASS_X"));
			empMaster.setLocaldist(empMasterData.rs.getString("LOCAL_DIST_AS_PER_SCH"));
			empMaster.setNoofyrs(empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_DIST"));
			////System.out.println("the getemps Noofyrs"+empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_DIST"));
			empMaster.setLocalzone(empMasterData.rs.getString("LOCAL_ZONE"));
			empMaster.setNoofyrs1(empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_ZONE"));
			////System.out.println("the getemps Noofyrs1"+empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_ZONE"));
			empMaster.setPvtdist(empMasterData.rs.getString("PRIVATE_PASSED_DIST"));
			empMaster.setPvtzone(empMasterData.rs.getString("PRIVATE_PASSED_ZONE"));
			////System.out.println("PVT ZONE VALUE in getEMP()"+empMasterData.rs.getString("PRIVATE_PASSED_ZONE"));

			if(empMasterData.rs.getString("TEMP_PERMNENT")!=null){
			empMaster.setDesig(empMasterData.rs.getString("TEMP_PERMNENT"));
			////System.out.println("Desig getEmp"+empMasterData.rs.getString("TEMP_PERMNENT"));
			}
			if(empMaster.getDesig()!=null && empMaster.getDesig().equals("P"))
			{
				empMaster.setDesgnCode(empMasterData.rs.getString("DESIGNATION_CODE"));
				////System.out.println("DesgnCode"+empMasterData.rs.getString("DESIGNATION_CODE"));	
			}
			else if(empMaster.getDesig()!=null && empMaster.getDesig().equals("T"))
			{
				empMaster.setDesgnCode(empMasterData.rs.getString("DESIGNATION_CODE"));
				////System.out.println("TDesgCode"+empMasterData.rs.getString("DESIGNATION_CODE"));
			}
			else if(empMaster.getDesig()!=null && empMaster.getDesig().equals("W"))
			{
				empMaster.setDesgnCode(empMasterData.rs.getString("DESIGNATION_CODE"));
				//System.out.println("WDesgCode"+empMasterData.rs.getString("DESIGNATION_CODE"));
			}
			//empMaster.setDesgnCode(empMasterData.rs.getString("DESIGNATION_CODE"));
			////System.out.println("Desgncode getEmp"+empMasterData.rs.getString("DESIGNATION_CODE"));
			try//if(empMasterData.rs.getString("APPOINT_CATEGORY")!=null)
			{
				empMaster.setApptcategory(empMasterData.rs.getString("APPOINT_CATEGORY"));
				//System.out.println("ApptCatergory value in geEmp() "+empMasterData.rs.getString("APPOINT_CATEGORY"));
			}catch(Exception e){
				//System.out.println("error in apptcategoryappt "+e);
			}
			try//{if(empMasterData.rs.getDate("APPOINTMENT_DATE")!= null) 
			{
				empMaster.setAppointdate(df.format(empMasterData.rs.getDate("APPOINTMENT_DATE")));
			}catch(Exception e){
				//System.out.println("error in apptcategoryapp "+e);
			}
							
			try//{if (empMasterData.rs.getDate("DATE_OF_JOINING")!= null) 
			{
				empMaster.setDoj(df.format(empMasterData.rs.getDate("DATE_OF_JOINING")));
			}catch(Exception e){
				//System.out.println("error in apptcategorydoj "+e);
			}
			empMaster.setNarecruit(empMasterData.rs.getString("RECRUIT_LOCAL_NONLOCAL"));
			empMaster.setZone(empMasterData.rs.getString("ZONE_CODE"));
			////System.out.println("zone details executed");
			empMaster.setApcatog(empMasterData.rs.getString("APCATEG_CODE"));
			empMaster.setMoap(empMasterData.rs.getString("MOAP_CODE"));
			
			
			try//{if(empMasterData.rs.getDate("DATE_OF_COMMENCE_PROBATION")!=null)
			{
				empMaster.setDcommprob(df.format(empMasterData.rs.getDate("DATE_OF_COMMENCE_PROBATION")));					
			}catch(Exception e){
				//System.out.println("error in apptcategorydcomm "+e);
			}
			try//if(empMasterData.rs.getDate("DATE_OF_REGULARISATION")!=null)
			{
				empMaster.setDdeclprob(df.format(empMasterData.rs.getDate("DATE_OF_REGULARISATION")));					
			}catch(Exception e){
				//System.out.println("error in apptcategorydecl "+e);
			}
			try//if (empMasterData.rs.getDate("CURRENT_POST_HELD_FROM")!= null) 
			{
				empMaster.setCurrentpostdate(df.format(empMasterData.rs.getDate("CURRENT_POST_HELD_FROM")));
			}catch(Exception e){
				//System.out.println("error in apptcategorycurr "+e);
			}
			try//{if(empMasterData.rs.getDate("PROMOTION_DT_PRESENT_DESG")!=null)
			{
			   empMaster.setPromotedate(df.format(empMasterData.rs.getDate("PROMOTION_DT_PRESENT_DESG")));
			}catch(Exception e){
				//System.out.println("error in apptcategorypro "+e);
			}			
			
			empMaster.setTestpassed(empMasterData.rs.getString("ACCTEST_PASSED"));
			try//{if(empMasterData.rs.getDate("ACCTEST_PASS_DATE")!=null)
			{
				empMaster.setDacctest(df.format(empMasterData.rs.getDate("ACCTEST_PASS_DATE")));					
			}catch(Exception e){
				//System.out.println("error in apptcategoryacc "+e);
			}
			empMaster.setAddqual2(empMasterData.rs.getString("ADD_QUAL_2"));
			empMaster.setAddqual1(empMasterData.rs.getString("ADD_QUAL_1"));
			
			empMaster.setPresentdesig(empMasterData.rs.getString("PRESENT_DESIG"));
			////System.out.println("present desig"+empMasterData.rs.getString("PRESENT_DESIG"));
			empMaster.setWorkSpecial(empMasterData.rs.getString("WORK_SPECIALIZATION"));
			////System.out.println("work Special getEmp"+empMasterData.rs.getString("WORK_SPECIALIZATION"));
			/*try {
				empMaster.setWorkSpecial(empMasterData.rs.getString("WORK_SPECIALIZATION"));
				} catch (Exception e) {
					//System.out.println("the error in getEmps()= " + e);
				}*/
			empMaster.setOtherDet(empMasterData.rs.getString("OTHER_DETAILS"));
						
			empMaster.setHoc((empMasterData.rs.getString("OFFICE_CODE")).substring(0,1));				
			empMaster.setCoc((empMasterData.rs.getString("OFFICE_CODE")).substring(1,3));
			empMaster.setDoc((empMasterData.rs.getString("OFFICE_CODE")).substring(3,4));
			empMaster.setSdoc((empMasterData.rs.getString("OFFICE_CODE")).substring(4,6));
			try//if(empMasterData.rs.getString("SECTION")!=null)
			{
				empMaster.setSection(empMasterData.rs.getString("SECTION"));
			}catch(Exception e){
				//System.out.println("error in getEmp() "+e);
			}
		
			try//if(empMasterData.rs.getString("DEPT_OPTED")!=null)
			{
			empMaster.setDept(empMasterData.rs.getString("DEPT_OPTED"));
			//System.out.println("DEPT OPTED"+empMasterData.rs.getString("DEPT_OPTED"));
			}catch(Exception e){
				//System.out.println("error in getEmp() "+e);
			}
		
			empMaster.setRoc(empMasterData.rs.getString("OFFICE_CODE"));
			//System.out.println("officecode roc"+empMasterData.rs.getString("OFFICE_CODE"));
			empMaster.setDeputation(empMasterData.rs.getString("DEPUTATION"));
			try//if(empMasterData.rs.getDate("DEPUTATION_FROM")!=null)
			{
				empMaster.setDeputationDate(df.format(empMasterData.rs.getDate("DEPUTATION_FROM")));
				//System.out.println("Deputation Date getEmp() "+df.format(empMasterData.rs.getDate("DEPUTATION_FROM")));
			}catch(Exception e){
			//Deputation Date names as Depu
				//System.out.println("error in DeputationDate"+e);
			}
			try{//if(empMasterData.rs.getString("DEPUTATION_DEPT")!=null)
						empMaster.setDepudept(empMasterData.rs.getString("DEPUTATION_DEPT"));
			}catch(Exception e){
				//System.out.println("Error in DeputationDept"+e);
			}
			////System.out.println("Deputation Dept in geEmp()"+empMasterData.rs.getString("DEPUTATION_DEPT"));
			
			try//if(empMasterData.rs.getString("SENIORITY")!=null)
			{
			empMaster.setSeniority(empMasterData.rs.getString("SENIORITY"));
			////System.out.println("Seniority getEmp"+empMasterData.rs.getString("SENIORITY"));
			}catch(Exception e){
				//System.out.println("error in  getEmp() "+e);
			}
			
			try//{if(empMasterData.rs.getString("DISCIPLINE_CASE")!=null)
			{
				empMaster.setDisciplinecase(empMasterData.rs.getString("DISCIPLINE_CASE"));
			}catch(Exception e){
				//System.out.println("error in getEmp() "+e);
			}
			try//{if(empMasterData.rs.getString("DISCIPLINE_TYPE")!=null)
			{
				empMaster.setDisciplinetype(empMasterData.rs.getString("DISCIPLINE_TYPE"));
				////System.out.println("Discipline Type getEmp"+empMasterData.rs.getString("DISCIPLINE_TYPE"));
			}catch(Exception e){
				//System.out.println("error in getEmp() "+e);
			}
		
			
			try//{if(empMasterData.rs.getString("LEAVE_SUSPENDED")!=null)
			{
				empMaster.setLeavesuspend(empMasterData.rs.getString("LEAVE_SUSPENDED"));
			
			}catch(Exception e){
				//System.out.println("error in LeaveSuspend"+e);
			}
			////System.out.println("LeaveSuspend in getEmp()"+empMasterData.rs.getString("LEAVE_SUSPENDED"));
			try//if(empMasterData.rs.getDate("DATE_OF_LEAVE")!=null)
			{
				empMaster.setLeavedate(df.format(empMasterData.rs.getDate("DATE_OF_LEAVE")));
			}catch(Exception e){
				//System.out.println("error in LeaveDate "+e);
			}
			////System.out.println("LeaveDate Value in getEmp()"+empMasterData.rs.getDate("DATE_OF_LEAVE"));
			
			empMaster.setPanno(empMasterData.rs.getString("PAN_NO"));
			empMaster.setApgli(empMasterData.rs.getString("APGLI_NO"));
			empMaster.setGpfno(empMasterData.rs.getString("GPF_NO"));
			////System.out.println("in the pan_no");
			
			empMaster.setPayscale(empMasterData.rs.getString("PRESENT_PAY_SCALE"));
			
			try//if(empMasterData.rs.getDate("UPDATE_DATE")!=null)
			{
				empMaster.setIncrementdate(df.format(empMasterData.rs.getDate("UPDATE_DATE")));
			}catch(Exception e){
				//System.out.println("error in getEmp() "+e);
			}
		}
		} catch (Exception e) {
			//System.out.println("error in getEmp=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static String getPayScales(String desgcode,DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
	
	String payscale=null;
	
	try {
		//System.out.println("in getPayScale");
		//System.out.println("ConnCount is "+connCount);
		empMasterData.conn = dataSource.getConnection();
		empMasterData.stmt = empMasterData.conn.createStatement();
		
		    //System.out.println("desgsssss"+desgcode);
			empMasterData.rs =empMasterData.stmt.executeQuery("select DISTINCT REVISED_PAY_SCALE  from RWS_PAY_SCALE_TBL P,RWS_DESIGNATION_TBL D WHERE P.DESIGNATION_CODE=D.DESIGNATION_CODE AND P.DESIGNATION_CODE='"+desgcode+"'");
		
		if(empMasterData.rs.next())
		{
		if(empMasterData.rs.getString(1)!=null)
		{
		payscale=empMasterData.rs.getString(1);
		//System.out.println("payyyyyyysacle0"+payscale);
		}
		else 
		{
		payscale="-";
		//System.out.println("payyyyyyysacle1"+payscale);
		}
		}
		else
		{
		payscale="-";
		//System.out.println("payyyyyyysacle2"+payscale);
		}
			
		
	} catch (Exception e) {
		//System.out.println("The error in getPayScales=" + e);
	} finally {
		empMasterData.closeAll();
		
		//System.out.println("ConnCount after closing is "+connCount);
	}
	return payscale;
}
			
	//testing for Ajax
	public  static ArrayList getCircles(DataSource datasource)throws Exception
	{
		Connection conn=null; 
		ArrayList circles=null;
		EmpForm circle=null;
		 		
		try{
			circles=new ArrayList();
			//System.out.println("in getCircles ");
		   String query="select CIRCLE_OFFICE_CODE,CIRCLE_OFFICE_NAME  from RWS_CIRCLE_OFFICE_TBL order by CIRCLE_OFFICE_NAME";
		   conn=datasource.getConnection();
		   PreparedStatement ps=conn.prepareStatement(query);
		   ResultSet rs=ps.executeQuery();
		   while(rs.next())
		   {
		   	circle=new EmpForm();
		   	circle.setCircleCode(rs.getString("CIRCLE_OFFICE_CODE")+"");
		   	//System.out.println("circle code is"+rs.getString("CIRCLE_OFFICE_CODE"));
		   	circle.setCircleName(rs.getString("CIRCLE_OFFICE_NAME"));
		   	circles.add(circle);
		   }
	
		}
		catch(Exception e)
		{
			//System.out.println("Exception while geting circles"+e);
		}
		finally
		{
			conn.close();
		}
		return circles;
	}
	
	//ens of code
	
	
	public  static ArrayList getCircleCodes(DataSource datasource)throws Exception
	{
		Connection conn=null; 
		ArrayList circles=null;
		EmpForm circle=null;
		 		
		try{
			circles=new ArrayList();
			//System.out.println("in getCircles ");
		   String query="select CIRCLE_OFFICE_CODE,CIRCLE_OFFICE_NAME  from RWS_CIRCLE_OFFICE_TBL order by CIRCLE_OFFICE_NAME";
		   conn=datasource.getConnection();
		   PreparedStatement ps=conn.prepareStatement(query);
		   ResultSet rs=ps.executeQuery();
		   while(rs.next())
		   {
		   	circle=new EmpForm();
		   	circle.setCircleCode(rs.getString("CIRCLE_OFFICE_CODE")+"");
		   	//System.out.println("circle code is"+rs.getString("CIRCLE_OFFICE_CODE"));
		   	circle.setCircleName(rs.getString("CIRCLE_OFFICE_NAME"));
		   	circles.add(circle);
		   }
	
		}
		catch(Exception e)
		{
			//System.out.println("Exception while geting circles"+e);
		}
		finally
		{
			conn.close();
		}
		return circles;
	}
	
		
	public static String getEmployee(String hoc, String coc, String doc,
			String sdoc, DataSource dataSource) throws Exception {  
		EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select count(*) from  rws_employee_tbl where substr(OFFICE_CODE,1,1)='"
							+ hoc
							+ "' and substr(OFFICE_CODE,2,2)='"
							+ coc
							+ "' and substr(OFFICE_CODE,4,1)='"
							+ doc
							+ "' and substr(OFFICE_CODE,5,2)='" + sdoc + "'");
			if (empMasterData.rs.next()) {
				rowCount = empMasterData.rs.getInt(1);
			}

		} catch (Exception e) {
			//System.out.println("error in getEmp=" + e);
		} finally {
			empMasterData.closeAll();
		}
		if (rowCount >= 1)
			return "1";
		else
			return "0";
	}

	
	//code added 
public static ArrayList getEmps(String hoc,String coc,String doc,String sdoc,DataSource dataSource) throws Exception 
	{
		String str;
		EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;//Form bean
		ArrayList emps = new ArrayList();
		
		try {
			empMasterData.conn = dataSource.getConnection();
			////System.out.println("connection established");
			empMasterData.stmt = empMasterData.conn.createStatement();
			////System.out.println("create statement executed");
			String query="";
			////System.out.println("hoc="+hoc+"coc="+coc+"doc="+doc+"sdoc="+sdoc);
						
			//code added
			if(hoc.equals("0") && coc.equals("00") && doc.equals("0") && sdoc.equals("00"))
			{
				query="select * from rws_employee_tbl e,rws_employee_spouse_tbl s where e.employee_code=s.employee_code(+) order by e.employee_code";
			}
			//headOffice
			else if (!hoc.equals("0") && coc.equals("00") && doc.equals("0") && sdoc.equals("00"))
			{
			query="select * from rws_employee_tbl e,rws_employee_spouse_tbl s where e.employee_code=s.employee_code(+) and substr(office_code,1,1)='"+hoc+"' order by e.EMPLOYEE_CODE";
			}
			//circleOffice
			else if (!hoc.equals("0") && !coc.equals("00") && doc.equals("0") && sdoc.equals("00"))
			{
			query="select * from rws_employee_tbl e,rws_employee_spouse_tbl s where e.employee_code=s.employee_code(+) and substr(office_code,1,1)='"+hoc+"' and substr(office_code,2,2)='"+coc+"' order by e.EMPLOYEE_CODE";
			}
			//divisionOffice
			else if (!coc.equals("00") && !doc.equals("0") && sdoc.equals("00"))
			{
			query="select * from rws_employee_tbl e,rws_employee_spouse_tbl s where e.employee_code=s.employee_code(+) and substr(office_code,1,1)='"+hoc+"' and substr(office_code,2,2)='"+coc+"' and substr(office_code,4,1)='"+doc+"' order by e.EMPLOYEE_CODE";
			}
			//SubDivisionOffice
			else if (!hoc.equals("0") && !coc.equals("00") && !doc.equals("0") && !sdoc.equals("00"))
			{
			query="select * from rws_employee_tbl e,rws_employee_spouse_tbl s where e.employee_code=s.employee_code(+) and substr(office_code,1,1)='"+hoc+"' and substr(office_code,2,2)='"+coc+"' and substr(office_code,4,1)='"+doc+"' and substr(office_code,5,2)='"+sdoc+"'order by e.EMPLOYEE_CODE";
			}
						
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			////System.out.println("query in getEmps(hoc,coc,doc,sdoc) "+query);
			////System.out.println("select statement executed");
			while(empMasterData.rs.next()) 
			{
				empMaster = new EmpMaster();
				////System.out.println("rws statement executed");

				empMaster.setEmpcode(empMasterData.rs.getString(2));
				////System.out.println(empMasterData.rs.getString(2));
				empMaster.setSurname(empMasterData.rs.getString("EMPLOYEE_SURNAME"));
				empMaster.setEmpname(empMasterData.rs.getString("EMPLOYEE_NAME"));
				//empMaster.setRoc(empMasterData.rs.getString("OFFICE_CODE"));
				try//if(empMasterData.rs.getString("OFFICE_CODE")!=null)
				{
					String officeNames[]=new String[5];
					String hoc1=null;
					String coc1=null;
					String doc1=null;
					String sdoc1=null;
				if(officeNames!=null)
				{					
				nic.watersoft.commons.RwsOffices rwsOffices=new nic.watersoft.commons.RwsOffices(dataSource);
				officeNames=rwsOffices.getOfficeNames(empMasterData.rs.getString("OFFICE_CODE"),true,dataSource);
				hoc1=officeNames[0];
				coc1=officeNames[1];
				doc1=officeNames[2];
				sdoc1=officeNames[3];
				//empMaster.setHoc(hoc1+coc1+doc1+sdoc1);
				empMaster.setHoc(hoc1);
				empMaster.setCoc(coc1);
				empMaster.setDoc(doc1);
				empMaster.setSdoc(sdoc1);
				}
				//System.out.println();
				
			}catch(Exception e)
			{
				//System.out.println("Error in gettting office names"+e);
			}
				////System.out.println("rwsOffices1");
				
				//empMaster.setHoc(empMasterData.rs.getString("SECTOR"));
				if(empMasterData.rs.getString("SECTOR")!=null)
				{
					empMaster.setRoc(getHeadName(empMasterData.rs.getString("SECTOR"),dataSource));
				}
				
				////System.out.println("sector");
				if (empMasterData.rs.getDate("DATE_OF_BIRTH") != null) {
					empMaster.setDob(df.format(empMasterData.rs.getDate("DATE_OF_BIRTH")));
				}
				if (empMasterData.rs.getDate("APPOINTMENT_DATE") != null) {
					empMaster.setAppointdate(df.format(empMasterData.rs.getDate("APPOINTMENT_DATE")));
				}
				if (empMasterData.rs.getDate("DATE_OF_JOINING") != null) {
					empMaster.setDoj(df.format(empMasterData.rs.getDate("DATE_OF_JOINING")));
				}
				if (empMasterData.rs.getDate("CURRENT_POST_HELD_FROM") != null) {
					empMaster.setCurrentpostdate(df.format(empMasterData.rs
							.getDate("CURRENT_POST_HELD_FROM")));
				}
				if(empMasterData.rs.getDate("DATE_OF_COMMENCE_PROBATION")!=null)
				{
					empMaster.setDcommprob(df.format(empMasterData.rs.getDate("DATE_OF_COMMENCE_PROBATION")));
				}
				//empMaster.setDcommprob(empMasterData.rs.getString("DATE_OF_COMMENCE_PROBATION"));
				if(empMasterData.rs.getDate("DATE_OF_REGULARISATION")!=null)
				{
					empMaster.setDdeclprob(df.format(empMasterData.rs.getDate("DATE_OF_REGULARISATION")));					
				}
				if(empMasterData.rs.getDate("ACCTEST_PASS_DATE")!=null)
				{
					empMaster.setDacctest(df.format(empMasterData.rs.getDate("ACCTEST_PASS_DATE")));
				}
				if(empMasterData.rs.getDate("UPDATE_DATE")!=null)
				{
					empMaster.setIncrementdate(df.format(empMasterData.rs.getDate("UPDATE_DATE")));
				}
				
				
				////System.out.println("all date details executed");
				//empMaster.setPhone(empMasterData.rs.getString("PHONE"));
				//empMaster.setMobile(empMasterData.rs.getString("MOBILE"));
				//empMaster.setTotalworkscomp(empMasterData.rs.getString("TOTAL_NO_WORKS_COMPLETED"));
				
				if(empMasterData.rs.getString("QUAL_CODE")!=null)
				{
				//empMaster.setQual(empMasterData.rs.getString("QUAL_CODE"));
				empMaster.setQualName(getQualName(empMasterData.rs.getString("QUAL_CODE"),dataSource));
				//System.out.println("Qualification details");
				}
				
				//if(empMasterData.rs.getString("ADD_QUAL_2")!=null)
				//{
				////System.out.println("qual2"+empMasterData.rs.getString("ADD_QUAL_2"));
				//empMaster.setAddqual2(empMasterData.rs.getString("ADD_QUAL_2"));
				
				try{
					empMaster.setAddqual2(getQualName(empMasterData.rs.getString("ADD_QUAL_2"),dataSource));
					////System.out.println("Qualification details2");
				}
				catch(Exception e)
				{
					//System.out.println("error in qual2"+e);
				}
				//empMaster.setAddqual1(empMasterData.rs.getString("ADD_QUAL_1"));
				
				try{
					empMaster.setAddqual1(getQualName(empMasterData.rs.getString("ADD_QUAL_1"),dataSource));
					////System.out.println("Qualification details1");
				}
				catch(Exception e)
				{
					//System.out.println("error in qual1"+e);
				}
				empMaster.setPresentation(empMasterData.rs.getString("PRESENT_STATION_MANDAL"));
				////System.out.println("work");
				try {
					empMaster.setWorkSpecial(getWorkSpecName(empMasterData.rs.getString("WORK_SPECIALIZATION"),dataSource));
					} catch (Exception e) {
						//System.out.println("the error in getEmps workspecial= " + e);
					}
				
				empMaster.setRelation(empMasterData.rs.getString("FATHER_NAME"));
				////System.out.println("relation details ");
					try {
					empMaster.setNdist(getDistName(dataSource,empMasterData.rs.getString("NATIVE_DISTRICT")));
					} catch (Exception e) {
						//System.out.println("the error in setNdist getEmps()= " + e);
					}
					//empMaster.setNmand(empMasterData.rs.getString("NATIVE_MANDAL"));
					try {
						empMaster.setNmand(getMandalName(empMasterData.rs.getString("NATIVE_DISTRICT"),empMasterData.rs.getString("NATIVE_MANDAL"),dataSource));
						} catch (Exception e) {
							//System.out.println("the error in setNmand getEmps()= " + e);
						}
							
				////System.out.println("Ndist,Nmand details ");
				try
				{
				empMaster.setNarecruit(getRecName(empMasterData.rs.getString("RECRUIT_LOCAL_NONLOCAL")));
				}catch(Exception e)
				{
					//System.out.println("error in Narecruit getEmps()"+e);
				}
				try{
					empMaster.setDesig(getTempPer(empMasterData.rs.getString("TEMP_PERMNENT")));
					}catch(Exception e){
						//System.out.println("error in Desig getEmps()"+e);
					
					}
					try{
					empMaster.setDesgnCode(getDesigName(empMasterData.rs.getString("DESIGNATION_CODE"),dataSource));
					//System.out.println("Desgnation Code:= "+empMaster.getDesgnCode());
					}catch(Exception e)
					{
						//System.out.println("error in Designation getEmps()"+e);
					}
					/*try{
						empMaster.setTempdesgCode(getDesigName(empMasterData.rs.getString("DESIGNATION_CODE"),dataSource));
						}catch(Exception e)
						{
							//System.out.println("error in Designation getEmps()"+e);
						}
					*/
				////System.out.println("Designation details ");
				//empMaster.setPerdesig(empMasterData.rs.getString("TEMP_PERMNENT"));
				//empMaster.setSurname(empMasterData.rs.getString("EMPLOYEE_SURNAME"));
				//empMaster.setMoap(empMasterData.rs.getString("MOAP_CODE"));
				try {
					empMaster.setMoap(getModeName(empMasterData.rs.getString("MOAP_CODE"),dataSource));
					} catch (Exception e) {
						//System.out.println("the error in set getEmps()= " + e);
					}
				
				//empMaster.setApcatog(empMasterData.rs.getString("APCATEG_CODE"));
				try {
					empMaster.setApcatog(getCatogName(empMasterData.rs.getString("APCATEG_CODE"), dataSource));
					} catch (Exception e) {
						//System.out.println("the error in getEmps()= " + e);
					}
			
				//empMaster.setZone(empMasterData.rs.getString("ZONE_CODE"));
				try {
						empMaster.setZone(getZoneName(empMasterData.rs.getString("ZONE_CODE"), dataSource));
						} catch (Exception e) {
							//System.out.println("the error in getEmps()= " + e);
						}
				
				////System.out.println("catog,zone details ");
				/*
				empMaster.setZone(empMasterData.rs.getString("ZONE_CODE"));
				//System.out.println("zone details executed");
				empMaster.setApcatog(empMasterData.rs.getString("APCATEG_CODE"));
				empMaster.setMoap(empMasterData.rs.getString("MOAP_CODE"));*/
				//Added on Aug 12
				try{
				empMaster.setGender(getGenderName(empMasterData.rs.getString("SEX")));
				//System.out.println("SEX:= "+empMaster.getGender());
				} catch (Exception e) {
					//System.out.println("the error in Gender= " + e);
				}
		
				empMaster.setNrevenue(empMasterData.rs.getString("NATIVE_REV_DIVISION"));
				try{
				empMaster.setTestpassed(getYesNo(empMasterData.rs.getString("ACCTEST_PASSED")));
				}catch (Exception e) {
					//System.out.println("the error in getEmps()= " + e);
				}
		
				////System.out.println("Sex acctest");
				if(empMasterData.rs.getString("DEPUTATION")!=null){
				try{					
				empMaster.setDeputation(getYesNo(empMasterData.rs.getString("DEPUTATION")));
				} catch (Exception e) {
					//System.out.println("the error in getEmps()= " + e);
				}
				}
				empMaster.setPanno(empMasterData.rs.getString("PAN_NO"));
				empMaster.setApgli(empMasterData.rs.getString("APGLI_NO"));
				empMaster.setGpfno(empMasterData.rs.getString("GPF_NO"));
				////System.out.println("pan_no,Deputaion");
				if(empMasterData.rs.getString("PRESENT_PAY_SCALE")!=null)
				{
				empMaster.setPayscale(empMasterData.rs.getString("PRESENT_PAY_SCALE"));
				}
				////System.out.println("payscale increment data");
							
				empMaster.setOtherDet(empMasterData.rs.getString("OTHER_DETAILS"));
				empMaster.setReligion(empMasterData.rs.getString("RELG_CODE"));
				try {
					empMaster.setReligion(getReligionName(empMasterData.rs.getString("RELG_CODE"),dataSource));
					} catch (Exception e) {
						//System.out.println("the error in getEmps()= " + e);
					}
				
				//code added to include spouse details
				try//if(empMasterData.rs.getString("DEPT_OPTED")!=null)
				{
				empMaster.setDept(empMasterData.rs.getString("DEPT_OPTED"));
				//System.out.println("DEPT OPTED:= "+empMaster.getDept());
				} catch (Exception e) {
					//System.out.println("the error in getEmps()= " + e);
				}
				
				try//if(empMasterData.rs.getString("DEPUTATION_DEPT")!=null)
				{
					empMaster.setDepudept(empMasterData.rs.getString("DEPUTATION_DEPT"));
				} catch (Exception e) {
					//System.out.println("the error in getEmps()= " + e);
				}
				try//if(empMasterData.rs.getDate("DEPUTATION_FROM")!=null)
				{
					empMaster.setDeputationDate(df.format(empMasterData.rs.getDate("DEPUTATION_FROM")));
				} catch (Exception e) {
					//System.out.println("the error in getEmps()= " + e);
				}
				
				
				try{
					empMaster.setPh(getYesNo(empMasterData.rs.getString("PH")));
					} catch (Exception e) {
						//System.out.println("the error in PH= " + e);
					}
			
				
				try//if(empMasterData.rs.getString("APPOINT_CATEGORY")!=null)
				{
					empMaster.setApptcategory(empMasterData.rs.getString("APPOINT_CATEGORY"));
				} catch (Exception e) {
					//System.out.println("the error in getEmps()= " + e);
				}
				
				try//if(empMasterData.rs.getDate("PROMOTION_DT_PRESENT_DESG")!=null)
				{
					empMaster.setPromotedate(df.format(empMasterData.rs.getDate("PROMOTION_DT_PRESENT_DESG")));
				
				} catch (Exception e) {
					//System.out.println("the error in getEmps()= " + e);
				}
				
				
				try//if(empMasterData.rs.getString("SECTION")!=null)
				{
					empMaster.setSection(empMasterData.rs.getString("SECTION"));
				} catch (Exception e) {
					//System.out.println("the error in getEmps()= " + e);
				}
				
				try//if(empMasterData.rs.getString("SENIORITY")!=null)
				{
					empMaster.setSeniority(empMasterData.rs.getString("SENIORITY"));
				} catch (Exception e) {
					//System.out.println("the error in getEmps()= " + e);
				}
				
				try//if(empMasterData.rs.getString("DISCIPLINE_CASE")!=null)
				{
					empMaster.setDisciplinecase(getYesNo(empMasterData.rs.getString("DISCIPLINE_CASE")));
				} catch (Exception e) {
					//System.out.println("the error in getEmps()= " + e);
				}
				
				try//if(empMasterData.rs.getString("DISCIPLINE_TYPE")!=null)
				{
					empMaster.setDisciplinetype(empMasterData.rs.getString("DISCIPLINE_TYPE"));
				} catch (Exception e) {
					//System.out.println("the error in getEmps()= " + e);
				}
				
				try{
					empMaster.setLeavesuspend(getLeaveSus(empMasterData.rs.getString("LEAVE_SUSPENDED")));
					} catch (Exception e) {
						//System.out.println("the error in Leave= " + e);
					}
			
				
				try//if(empMasterData.rs.getDate("DATE_OF_LEAVE")!=null)
				{
					empMaster.setLeavedate(df.format(empMasterData.rs.getDate("DATE_OF_LEAVE")));
				}catch (Exception e) {
					//System.out.println("the error in getEmps()= " + e);
				}
				//spouse details from rws_employee_spouse_tbl
				////System.out.println("CODE ADDED FORM");
				
				
					try{
				  empMaster.setSpouseemployd(getYesNo(empMasterData.rs.getString("SPOUSE_EMPLOYED")));	
					}catch(Exception e)
					{
						//System.out.println("error in spouse"+e);
					}
					
				
				
				
				try{
				    empMaster.setSpouseworking(getWorkingName(empMasterData.rs.getString("SPOUSE_CENTRE_STATE")));
					}catch(Exception e)
					{
						//System.out.println("error in working"+e);
					}
				
				try//if(empMasterData.rs.getString("SPOUSE_DISTRICT_WORK")!=null)
				{
				  empMaster.setSpouseworkdist(getDistrictName(empMasterData.rs.getString("SPOUSE_DISTRICT_WORK"),dataSource));	
				}catch (Exception e) {
					//System.out.println("the error in getEmps()= " + e);
				}
				try//if(empMasterData.rs.getString("SPOUSE_REV_DIV_WORK")!=null)
				{
				  empMaster.setSpouseworkmand(empMasterData.rs.getString("SPOUSE_REV_DIV_WORK"));	
				}catch (Exception e) {
					//System.out.println("the error in getEmps()= " + e);
				}
				try//if(empMasterData.rs.getString("SPOUSE_REV_MANDAL_WORK")!=null)
				{
				  empMaster.setSpouseworkdiv(empMasterData.rs.getString("SPOUSE_REV_MANDAL_WORK"));	
				}catch (Exception e) {
					//System.out.println("the error in getEmps()= " + e);
				}
														
				////System.out.println("spouse details");
			
				//end of code
								
			
				////System.out.println("end statement executed");
				emps.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getEmps" + e);
		} finally {
			empMasterData.closeAll();
		}
		return emps;
	}
	




//code added for EmpCheckList Report

public static ArrayList getEmps1(String hoc,String coc,String doc,String sdoc,String fromdate,String todate,DataSource dataSource) throws Exception 
{
	String str;
	EmpMasterData empMasterData=new EmpMasterData();
	EmpMaster empMaster = null;//Form bean
	ArrayList emps = new ArrayList();
	
	try {
		empMasterData.conn = dataSource.getConnection();
		////System.out.println("connection established");
		empMasterData.stmt = empMasterData.conn.createStatement();
		////System.out.println("create statement executed");
		String query="";
		////System.out.println("hoc="+hoc+"coc="+coc+"doc="+doc+"sdoc="+sdoc+"fromdate="+fromdate+"todate="+todate);
		
		
		//code added
		if (!hoc.equals("0") && coc.equals("00") && doc.equals("0") && sdoc.equals("00") && fromdate.equals("") && todate.equals(""))
		{			
			query="select * from rws_employee_tbl where substr(office_code,1,1)='"+hoc+"' order by EMPLOYEE_CODE";
		}
		else if (!hoc.equals("0") && coc.equals("00") && doc.equals("0") && sdoc.equals("00"))
		{
			query="select * from rws_employee_tbl where substr(office_code,1,1)='"+hoc+"' and UPDATE_DATE>=to_Date('"+fromdate+"','dd/mm/yy') and UPDATE_DATE<=to_Date('"+todate+"','dd/mm/yy') order by EMPLOYEE_CODE,UPDATE_DATE desc";		//circleOffice
		}
				
		//headOffice
		/*else if (coc.equals("00") && doc.equals("0") && sdoc.equals("00"))
		query="select * from rws_employee_tbl where substr(office_code,1,1)='"+hoc+"' and UPDATE_DATE >= to_Date('"+fromdate+"','dd/mm/yy') and UPDATE_DATE<=to_Date('"+todate+"','dd/mm/yy') order by EMPLOYEE_CODE,UPDATE_DATE desc";		//circleOffice*/
		else if (!hoc.equals("0") && !coc.equals("00") && doc.equals("0") && sdoc.equals("00") && fromdate.equals("") && todate.equals(""))
		{
			query="select * from rws_employee_tbl where substr(office_code,1,1)='"+hoc+"' and substr(office_code,2,2)='"+coc+"' order by EMPLOYEE_CODE desc";
		}
		
		else if (!hoc.equals("0") && !coc.equals("00") && doc.equals("0") && sdoc.equals("00")){
			query="select * from rws_employee_tbl where substr(office_code,1,1)='"+hoc+"' and substr(office_code,2,2)='"+coc+"' and UPDATE_DATE >= to_Date('"+fromdate+"','dd/mm/yy') and UPDATE_DATE<=to_Date('"+todate+"','dd/mm/yy') order by EMPLOYEE_CODE,UPDATE_DATE desc";
		}
			
		//divisionOffice
		else if (!hoc.equals("0") && !coc.equals("00") && !doc.equals("0") && sdoc.equals("00") && fromdate.equals("") && todate.equals("")){
			query="select * from rws_employee_tbl where substr(office_code,1,1)='"+hoc+"' and substr(office_code,2,2)='"+coc+"' and substr(office_code,4,1)='"+doc+"' order by EMPLOYEE_CODE desc";
		}
		
		else if (!hoc.equals("0") && !coc.equals("00") && !doc.equals("0") && sdoc.equals("00")){
			query="select * from rws_employee_tbl where substr(office_code,1,1)='"+hoc+"' and substr(office_code,2,2)='"+coc+"' and substr(office_code,4,1)='"+doc+"' and UPDATE_DATE >= to_Date('"+fromdate+"','dd/mm/yy') and UPDATE_DATE<=to_Date('"+todate+"','dd/mm/yy') order by EMPLOYEE_CODE,UPDATE_DATE desc";
		}
			
		//subDivisionOffice
		else if (!hoc.equals("0") && !coc.equals("00") && !doc.equals("0") && !sdoc.equals("00") && fromdate.equals("") && todate.equals("")){
			query="select * from rws_employee_tbl where substr(office_code,1,1)='"+hoc+"' and substr(office_code,2,2)='"+coc+"' and substr(office_code,4,1)='"+doc+"' and substr(office_code,5,2)='"+sdoc+"' order by EMPLOYEE_CODE desc";
		}
		
		else if (!hoc.equals("0") && !coc.equals("00") && !doc.equals("0") && !sdoc.equals("00")){
			query="select * from rws_employee_tbl where substr(office_code,1,1)='"+hoc+"' and substr(office_code,2,2)='"+coc+"' and substr(office_code,4,1)='"+doc+"' and substr(office_code,5,2)='"+sdoc+"' and UPDATE_DATE >= to_Date('"+fromdate+"','dd/mm/yy') and UPDATE_DATE<=to_Date('"+todate+"','dd/mm/yy') order by EMPLOYEE_CODE,UPDATE_DATE desc";
		}
		
		//System.out.println("query is "+query);
		empMasterData.rs =empMasterData.stmt.executeQuery(query);
		//end of code added
		
		//empMasterData.rs =empMasterData.stmt.executeQuery(query);
		////System.out.println("select statement executed");
		while(empMasterData.rs.next()) 
		{
			empMaster = new EmpMaster();
			////System.out.println("rws statement executed");

			empMaster.setEmpcode(empMasterData.rs.getString("EMPLOYEE_CODE"));
			////System.out.println("Employee Code"+empMasterData.rs.getString("EMPLOYEE_CODE"));
			empMaster.setSurname(empMasterData.rs.getString("EMPLOYEE_SURNAME"));
			empMaster.setEmpname(empMasterData.rs.getString("EMPLOYEE_NAME"));
			if(empMasterData.rs.getString("SECTOR")!=null)
			{
				empMaster.setRoc(getHeadName(empMasterData.rs.getString("SECTOR"),dataSource));
			}
						
		try//if(empMasterData.rs.getString("OFFICE_CODE")!=null)
		{
			String officeNames[]=new String[5];
			String hoc1=null;
			String coc1=null;
			String doc1=null;
			String sdoc1=null;
		if(officeNames!=null)
		{					
		nic.watersoft.commons.RwsOffices rwsOffices=new nic.watersoft.commons.RwsOffices(dataSource);
		officeNames=rwsOffices.getOfficeNames(empMasterData.rs.getString("OFFICE_CODE"),true,dataSource);
		hoc1=officeNames[0];
		coc1=officeNames[1];
		doc1=officeNames[2];
		sdoc1=officeNames[3];
		//empMaster.setHoc(hoc1+coc1+doc1+sdoc1);
		empMaster.setHoc(hoc1);
		empMaster.setCoc(coc1);
		empMaster.setDoc(doc1);
		empMaster.setSdoc(sdoc1);
		}
		//System.out.println();
		}catch (Exception e) {
			//System.out.println("the error in getEmps() oficeCode= " + e);
		}
		////System.out.println("rwsOffices1");
		
			////System.out.println("employee details executed");
			if (empMasterData.rs.getDate("DATE_OF_BIRTH") != null) {
				empMaster.setDob(df.format(empMasterData.rs.getDate("DATE_OF_BIRTH")));
			}
			if (empMasterData.rs.getDate("APPOINTMENT_DATE") != null) {
				empMaster.setAppointdate(df.format(empMasterData.rs.getDate("APPOINTMENT_DATE")));
			}
			if (empMasterData.rs.getDate("DATE_OF_JOINING") != null) {
				empMaster.setDoj(df.format(empMasterData.rs.getDate("DATE_OF_JOINING")));
			}
			if (empMasterData.rs.getDate("CURRENT_POST_HELD_FROM") != null) 
			{
				empMaster.setCurrentpostdate(df.format(empMasterData.rs.getDate("CURRENT_POST_HELD_FROM")));
			}
				
			empMaster.setQual(empMasterData.rs.getString("QUAL_CODE"));
			try {
			empMaster.setQualName(getQualName(empMasterData.rs.getString("QUAL_CODE"), dataSource));
			}
			catch (Exception e)
			{
				//System.out.println("the error in getEmps()= " + e);
			}
			empMaster.setAddqual2(empMasterData.rs.getString("ADD_QUAL_2"));
			try {
				empMaster.setAddqual2(getQualName(empMasterData.rs.getString("ADD_QUAL_2"),dataSource));
			} catch (Exception e) {
				//System.out.println("the error in getEmps()= " + e);
			}
			//System.out.println("Qualification data in getEmps() executed");
				
			empMaster.setHof(empMasterData.rs.getString("HEAD_OF_OFFICE"));
			empMaster.setPresentation(empMasterData.rs.getString("PRESENT_STATION_MANDAL"));
			////System.out.println("mandal details executed");
			//CODE ADDED FOR rws_EmpEntryList_frm.jsp
			//empMaster.setWorkSpecial(empMasterData.rs.getString("WORK_SPECIALIZATION"));
			try {
				empMaster.setWorkSpecial(getWorkSpecName(empMasterData.rs.getString("WORK_SPECIALIZATION"),dataSource));
				//System.out.println("getworkSpecial() Name  "+empMaster.getWorkSpecial());
				} catch (Exception e) {
					//System.out.println("Error in getworkSpecial(); " + e);
				}
			
				try//if(empMasterData.rs.getString("SENIORITY")!=null)
				{
					empMaster.setSeniority(empMasterData.rs.getString("SENIORITY"));
				}catch (Exception e) {
					//System.out.println("Error in getSeniority(); " + e);
				}
				
			empMaster.setRelation(empMasterData.rs.getString("FATHER_NAME"));
			
		try
			{
				empMaster.setNdist(getDistrictName(empMasterData.rs.getString("NATIVE_DISTRICT"),dataSource));
			}
			catch(Exception e)
			{
				//System.out.println(" error in Native District"+e);	
			}
			try {
				empMaster.setNmand(getMandalName(empMasterData.rs.getString("NATIVE_DISTRICT"),empMasterData.rs.getString("NATIVE_MANDAL"),dataSource));
				} catch(Exception e) {
					//System.out.println("the error in getEmps()= " + e);
				}
		
			////System.out.println("Nmand details executed");
			try
			{
			empMaster.setNarecruit(getRecName(empMasterData.rs.getString("RECRUIT_LOCAL_NONLOCAL")));
			}catch(Exception e)
			{
				//System.out.println("error in Narecruit"+e);
			}
			//empMaster.setNarecruit(empMasterData.rs.getString("RECRUIT_LOCAL_NONLOCAL"));
			if(empMasterData.rs.getDate("DATE_OF_COMMENCE_PROBATION")!=null)
			{
				empMaster.setDcommprob(df.format(empMasterData.rs.getDate("DATE_OF_COMMENCE_PROBATION")));
			}
			//empMaster.setDcommprob(empMasterData.rs.getString("DATE_OF_COMMENCE_PROBATION"));
			if(empMasterData.rs.getDate("DATE_OF_REGULARISATION")!=null)
			{
				empMaster.setDdeclprob(df.format(empMasterData.rs.getDate("DATE_OF_REGULARISATION")));					
			}
			//empMaster.setDdeclprob(empMasterData.rs.getString("DATE_OF_REGULARISATION"));
						
			if(empMasterData.rs.getDate("ACCTEST_PASS_DATE")!=null)
			{
				empMaster.setDacctest(df.format(empMasterData.rs.getDate("ACCTEST_PASS_DATE")));
			}
			////System.out.println("Acctest details executed");
			
			//empMaster.setTempdesig(empMasterData.rs.getString("TEMP_PERMNENT"));
			try{
			empMaster.setDesig(getTempPer(empMasterData.rs.getString("TEMP_PERMNENT")));
			}catch(Exception e){
				//System.out.println("error in Desig"+e);
			
			}
			try{
			empMaster.setDesgnCode(getDesigName(empMasterData.rs.getString("DESIGNATION_CODE"),dataSource));
			}catch(Exception e)
			{
				//System.out.println("error in Designation"+e);
			}
			try{
				empMaster.setTempdesgCode(getDesigName(empMasterData.rs.getString("DESIGNATION_CODE"),dataSource));
				}catch(Exception e)
				{
					//System.out.println("error in Designation"+e);
				}
			
			
			//empMaster.setPerdesig(empMasterData.rs.getString("TEMP_PERMNENT"));
			if(empMasterData.rs.getDate("CURRENT_POST_HELD_FROM")!=null)
				{
				empMaster.setCurrentpostdate(df.format(empMasterData.rs.getDate("CURRENT_POST_HELD_FROM")));
				}
			empMaster.setSurname(empMasterData.rs.getString("EMPLOYEE_SURNAME"));
			try {
				empMaster.setZone(getZoneName(empMasterData.rs.getString("ZONE_CODE"), dataSource));
				} catch (Exception e) {
					//System.out.println("the error in zone= " + e);
				}
			//empMaster.setZone(empMasterData.rs.getString("ZONE_CODE"));
			////System.out.println("zone details executed");
			try {
				empMaster.setApcatog(getCatogName(empMasterData.rs.getString("APCATEG_CODE"), dataSource));
				} catch (Exception e) {
					//System.out.println("the error in getEmps()= " + e);
				}
		//	empMaster.setApcatog(empMasterData.rs.getString("APCATEG_CODE"));
				try {
					empMaster.setMoap(getModeName(empMasterData.rs.getString("MOAP_CODE"), dataSource));
					} catch (Exception e) {
						//System.out.println("the error in getEmps()= " + e);
					}
					
			
			//Added on Aug 12
			try{
			empMaster.setGender(getGenderName(empMasterData.rs.getString("SEX")));
			}catch(Exception e){
				//System.out.println("error in Gender name"+e);
			}
			empMaster.setNrevenue(empMasterData.rs.getString("NATIVE_REV_DIVISION"));
			try{			
			empMaster.setTestpassed(getYesNo(empMasterData.rs.getString("ACCTEST_PASSED")));
			}catch(Exception e){
				//System.out.println("error in AccTest"+e);
			}
			
			////System.out.println("Sex acctest");
			try{
			empMaster.setDeputation(getYesNo(empMasterData.rs.getString("DEPUTATION")));
			}catch(Exception e)
			{
				//System.out.println("error in Deputaion"+e);
			}
			empMaster.setPanno(empMasterData.rs.getString("PAN_NO"));
			empMaster.setApgli(empMasterData.rs.getString("APGLI_NO"));
			////System.out.println("in the pan_no");
			empMaster.setPayscale(empMasterData.rs.getString("PAY_SCALE_PRESENT"));
			if(empMasterData.rs.getDate("UPDATE_DATE")!=null)
			{
				empMaster.setIncrementdate(df.format(empMasterData.rs.getDate("UPDATE_DATE")));
			}
			////System.out.println("payscale increment data");
			
			
			////System.out.println("designation details executed");
			empMaster.setOtherDet(empMasterData.rs.getString("OTHER_DETAILS"));
			empMaster.setDesgnCode(empMasterData.rs.getString("DESIGNATION_CODE"));
			empMaster.setCheckType(empMasterData.rs.getString("TYPE_OF_CHECK"));
			empMaster.setNoOfChecks(empMasterData.rs.getInt("NO_OF_CHECKS"));
			empMaster.setCheckPeriod(empMasterData.rs.getString("CHECK_PERIOD"));
			empMaster.setAppOrderRef(empMasterData.rs.getString("APPOINTMENT_ORDER_REF"));
			empMaster.setWorkSpecial(empMasterData.rs.getString("WORK_SPECIALIZATION"));
			empMaster.setPostCode(empMasterData.rs.getString("POST_JOINED_DESG_CODE"));

			//Added on Aug 2
			//empMaster.setReligion(empMasterData.rs.getString("RELG_CODE"));
			//empMaster.setReligion(empMasterData.rs.getString("RELG_CODE"));
			try {
				empMaster.setReligion(getReligionName(empMasterData.rs.getString("RELG_CODE"),dataSource));
				} catch (Exception e) {
					//System.out.println("the error in Religion getemps1= " + e);
				}
			
			empMaster.setDiststudied4(empMasterData.rs.getString("DIST_CLASS_IV"));
			try
			{
			empMaster.setDiststudied4(getDistrictName(empMasterData.rs.getString("DIST_CLASS_IV"), dataSource));
			}
			catch (Exception e) 
			{
				//System.out.println("the error in getEmps()= " + e);
			}
			empMaster.setDiststudied5(empMasterData.rs.getString("DIST_CLASS_V"));
			try
			{
			empMaster.setDiststudied5(getDistrictName(empMasterData.rs.getString("DIST_CLASS_V"), dataSource));
			}
			catch (Exception e) 
			{
				//System.out.println("the error in getEmps()= " + e);
			}
			
			empMaster.setDiststudied6(empMasterData.rs.getString("DIST_CLASS_VI"));
			try
			{
			empMaster.setDiststudied6(getDistrictName(empMasterData.rs.getString("DIST_CLASS_VI"), dataSource));
			}
			catch (Exception e) 
			{
				//System.out.println("the error in getEmps()= " + e);
			}
			empMaster.setDiststudied7(empMasterData.rs.getString("DIST_CLASS_VII"));
			try
			{
			empMaster.setDiststudied7(getDistrictName(empMasterData.rs.getString("DIST_CLASS_VII"), dataSource));
			}
			catch (Exception e) 
			{
				//System.out.println("the error in getEmps()= " + e);
			}
			empMaster.setDiststudied8(empMasterData.rs.getString("DIST_CLASS_VIII"));
			try
			{
			empMaster.setDiststudied8(getDistrictName(empMasterData.rs.getString("DIST_CLASS_VIII"), dataSource));
			}
			catch (Exception e) 
			{
				//System.out.println("the error in getEmps()= " + e);
			}
			empMaster.setDiststudied9(empMasterData.rs.getString("DIST_CLASS_IX"));
			try
			{
			empMaster.setDiststudied9(getDistrictName(empMasterData.rs.getString("DIST_CLASS_IX"), dataSource));
			}
			catch (Exception e) 
			{
				//System.out.println("the error in getEmps()= " + e);
			}
			empMaster.setDiststudied10(empMasterData.rs.getString("DIST_CLASS_X"));
			try
			{
			empMaster.setDiststudied10(getDistrictName(empMasterData.rs.getString("DIST_CLASS_X"), dataSource));
			}
			catch (Exception e) 
			{
				//System.out.println("the error in getEmps()= " + e);
			}
			/*empMaster.setDiststudied5(empMasterData.rs.getString("DIST_CLASS_V"));
			empMaster.setDiststudied6(empMasterData.rs.getString("DIST_CLASS_VI"));
			empMaster.setDiststudied7(empMasterData.rs.getString("DIST_CLASS_VII"));
			empMaster.setDiststudied8(empMasterData.rs.getString("DIST_CLASS_VIII"));
			empMaster.setDiststudied9(empMasterData.rs.getString("DIST_CLASS_IX"));
			empMaster.setDiststudied10(empMasterData.rs.getString("DIST_CLASS_X"));*/
			try
			{
				empMaster.setLocaldist(getDistrictName(empMasterData.rs.getString("LOCAL_DIST_AS_PER_SCH"),dataSource));
			}
			catch (Exception e) 
			{
				//System.out.println("the error in getEmps()= " + e);
			}
			
			
			empMaster.setNoofyrs(empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_DIST"));
			////System.out.println("the getemps Noofyrs"+empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_DIST"));
			try
			{
				empMaster.setLocalzone(getZoneName(empMasterData.rs.getString("LOCAL_ZONE"),dataSource));
			}
			catch (Exception e) 
			{
				//System.out.println("the error in getEmps()= " + e);
			}
			
			
			empMaster.setNoofyrs1(empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_ZONE"));
			////System.out.println("the getemps Noofyrs1"+empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_ZONE"));
			try
			{
				empMaster.setPvtdist(getDistrictName(empMasterData.rs.getString("PRIVATE_PASSED_DIST"),dataSource));
			}
			catch (Exception e) 
			{
				//System.out.println("the error in getEmps()= " + e);
			}
			
			try
			{
				empMaster.setPvtzone(getZoneName(empMasterData.rs.getString("PRIVATE_PASSED_ZONE"),dataSource));
			}
			catch (Exception e) 
			{
				//System.out.println("the error in getEmps()= " + e);
			}
			
		
						
			////System.out.println("end statement executed");
			emps.add(empMaster);
		}
	} catch (Exception e) {
		//System.out.println("The error in getEmps" + e);
	} finally {
		empMasterData.closeAll();
	}
	return emps;
}



public static String getTempPer(String rec) throws Exception
{
	String name=null;
	
	if(rec.equalsIgnoreCase("T"))
	{
		name="TEMPORARY";
	}
	else if(rec.equalsIgnoreCase("P"))
	{
	    name="PERMNENT";
	}
	return name;
}




public static String getRecName(String rec) throws Exception
{
	String name=null;
	
	if(rec.equalsIgnoreCase("L"))
	{
		name="Local";
	}
	else if(rec.equalsIgnoreCase("N"))
	{
	    name="NON-LOCAL";
	}
	return name;
}



public static String getWorkingName(String gen) throws Exception
{
	String name=null;
	
	if(gen.equalsIgnoreCase("C"))
	{
		name="CENTERAL";
	}
	else if(gen.equalsIgnoreCase("S"))
	{
	    name="STATE";
   	}
	else if(gen.equalsIgnoreCase("P"))
	{
	    name="PSU";
   	}
	
	return name;
}


public static String getGenderName(String gen) throws Exception
{
	String name=null;
	
	if(gen.equalsIgnoreCase("M"))
	{
		name="Male";
	}
	else if(gen.equalsIgnoreCase("F"))
	{
	    name="Female";
	}
	return name;
}

public static String getLeaveSus(String opt) throws Exception 
{
	String option=null;
	if(opt.equalsIgnoreCase("L"))
	{
		option="LEAVE";
	}
	else if(opt.equalsIgnoreCase("S"))
		{
			option="SUSPENDED";
		}
	return option;
}


public static String getYesNo(String opt) throws Exception 
{
	String option=null;
	if(opt.equalsIgnoreCase("Y"))
	{
		option="Yes";
	}
	else if(opt.equalsIgnoreCase("N"))
		{
			option="No";
		}
	return option;
}

public static String getModeName(String code,Connection conn)
throws Exception {   
EmpMasterData empMasterData=new EmpMasterData();
//connCount--;
empMasterData.conn=conn;
String name = null;
empMasterData.stmt1 = null;
empMasterData.rs1 = null;
try {
////System.out.println("in getCatName");
////System.out.println("ConnCount is "+connCount);
empMasterData.stmt1 = empMasterData.conn.createStatement();
if (code != null) {
	empMasterData.rs1 = empMasterData.stmt1
			.executeQuery("SELECT MOAP_NAME FROM RWS_MODEOFAPP_MST_TBL  WHERE MOAP_CODE ="
					+ code);
	empMasterData.rs1.next();
	name = empMasterData.rs1.getString(1);
}
} catch (Exception e) {
//System.out.println("Ther error in getCatName=" + e);
} finally {
empMasterData.stmt1.close();
}
return name;
}

public static String getCatogName(String code, Connection conn)
throws Exception {   
EmpMasterData empMasterData=new EmpMasterData();
//connCount--;
empMasterData.conn=conn;
String name = null;
empMasterData.stmt1 = null;
empMasterData.rs1 = null;
try {
////System.out.println("in getCatName");
////System.out.println("ConnCount is "+connCount);
empMasterData.stmt1 = empMasterData.conn.createStatement();
if (code != null) {
	empMasterData.rs1 = empMasterData.stmt1
			.executeQuery("SELECT APCATEG_NAME FROM RWS_APP_CATEGORY_MST_TBL  WHERE APCATEG_CODE ="
					+ code);
	empMasterData.rs1.next();
	name = empMasterData.rs1.getString(1);
}
} catch (Exception e) {
//System.out.println("Ther error in getCatName=" + e);
} finally {
empMasterData.stmt1.close();
}
return name;
}
//same code with dataSource
public static String getModeName(String code,DataSource dataSource)
throws Exception {   
EmpMasterData empMasterData=new EmpMasterData();
//connCount--;
empMasterData.conn=dataSource.getConnection();
String name = null;
empMasterData.stmt1 = null;
empMasterData.rs1 = null;
try {
////System.out.println("in getCatName");
////System.out.println("ConnCount is "+connCount);
empMasterData.stmt1 = empMasterData.conn.createStatement();
if (code != null) {
	empMasterData.rs1 = empMasterData.stmt1
			.executeQuery("SELECT MOAP_NAME FROM RWS_MODEOFAPP_MST_TBL  WHERE MOAP_CODE ="
					+ code);
	empMasterData.rs1.next();
	name = empMasterData.rs1.getString(1);
}
} catch (Exception e) {
//System.out.println("Ther error in getCatName=" + e);
} finally {
empMasterData.closeAll();
}
return name;
}


//same code with dataSource
public static String getCatogName(String code,DataSource dataSource) 
throws Exception {   
EmpMasterData empMasterData=new EmpMasterData();
//connCount--;
empMasterData.conn=dataSource.getConnection();
String name = null;
empMasterData.stmt1 = null;
empMasterData.rs1 = null;
try {
//System.out.println("in getCatName");
//System.out.println("ConnCount is "+connCount);
empMasterData.stmt1 = empMasterData.conn.createStatement();
if (code != null) {
	empMasterData.rs1 = empMasterData.stmt1
			.executeQuery("SELECT APCATEG_NAME FROM RWS_APP_CATEGORY_MST_TBL  WHERE APCATEG_CODE ="
					+ code);
	empMasterData.rs1.next();
	name = empMasterData.rs1.getString(1);
}
} catch (Exception e) {
//System.out.println("Ther error in getCatName=" + e);
} finally {
empMasterData.closeAll();
}
return name;
}



public static ArrayList getFromDate(DataSource dataSource)throws Exception
{  
EmpMasterData empMasterData=new EmpMasterData();
String query;
ArrayList fromDate = new ArrayList();
try {
//query = "select distinct to_char(access_date,'DD/MM/yy') from rws_log_tbl order by to_char(access_date,'DD/MM/yy')  desc";
query = "select distinct to_char(DATE_OF_JOINING,'dd/mm/yyyy') as a1 from rws_employee_tbl order by substr(a1,7,10) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";

//System.out.println("query for Date of Join "+query);
empMasterData.conn = dataSource.getConnection();
empMasterData.stmt = empMasterData.conn.createStatement();
empMasterData.rs =empMasterData.stmt.executeQuery(query);
EmpMaster empMaster = null;
while(empMasterData.rs.next())
{
	empMaster = new EmpMaster();
	empMaster.setFromDate(empMasterData.rs.getString(1));
	////System.out.println("EmpMaster fromDate"+empMaster.getFromDate());
	fromDate.add(empMaster);
}
empMasterData.conn.close();
} catch (Exception e) {
//System.out.println("Exception in GetDate in EmpMaster :" + e);
}

return fromDate;
}



public static ArrayList getFromDates1(DataSource dataSource)
throws Exception {  
EmpMasterData empMasterData=new EmpMasterData();
String query;
ArrayList fromDate = new ArrayList();
try {
//query = "select distinct to_char(access_date,'DD/MM/yy') from rws_log_tbl order by to_char(access_date,'DD/MM/yy')  desc";
query = "select distinct to_char(UPDATE_DATE,'dd/mm/yy') as a1 from rws_employee_tbl order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";

////System.out.println("query is "+query);
empMasterData.conn = dataSource.getConnection();
empMasterData.stmt = empMasterData.conn.createStatement();
empMasterData.rs =empMasterData.stmt.executeQuery(query);
EmpMaster empMaster = null;
while (empMasterData.rs.next()) {
	empMaster = new EmpMaster();
	empMaster.setFromDate(empMasterData.rs.getString(1));
	////System.out.println("EmpMaster fromDate"+empMaster.getFromDate());
	fromDate.add(empMaster);
}
empMasterData.conn.close();
} catch (Exception e) {
//System.out.println("Exception in GetDate in EmpMaster :" + e);
}

return fromDate;
}


public static ArrayList getToDates1(String fromDate, DataSource dataSource) {
String query;
ArrayList toDate = new ArrayList();
EmpMasterData empMasterData=new EmpMasterData();
////System.out.println("started getToDates in EmpMasterData before try");
try {

query = //"select distinct to_char(access_date,'DD/MM/yy') from rws_log_tbl where to_date(ACCESS_DATE,'dd/mm/yy') >= to_Date('"
		//+ fromDate + "','dd/mm/yy') order by to_char(access_date,'DD/MM/yy')  desc";
		
query = "select distinct to_char(UPDATE_DATE,'dd/mm/yy') as a1 from rws_employee_tbl where UPDATE_DATE>=to_Date('"+fromDate+"','dd/mm/yy') order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";

//System.out.println("query is "+query);
/*
 * query="select unique(to_char(access_date,'dd/mm/yyyy')) from
 * rws_log_tbl where to_date(ACCESS_DATE,'dd/mon/yyyy') >=
 * to_Date('"+fromDate+"','dd/mm/yyyy')";
 */

/*
 * query="select unique(to_Char(access_date,'dd/mm/yy')) from
 * rws_log_tbl where to_Date(ACCESS_DATE,'dd/mon/yyyy') >=
 * to_Date('"+fromDate+"','dd/mm/yyyy')";
 */

empMasterData.conn = dataSource.getConnection();
////System.out.println("empMasterData.conn" + empMasterData.conn);
empMasterData.stmt = empMasterData.conn.createStatement();
empMasterData.rs =empMasterData.stmt.executeQuery(query);
EmpMaster empMaster = null;
////System.out.println("empMasterData.rs.next() :"+empMasterData.rs.next());

while (empMasterData.rs.next()) 
{
	empMaster = new EmpMaster();
	empMaster.setToDate(empMasterData.rs.getString(1));
	////System.out.println("EmpMaster toDate" + empMaster.getToDate());
	toDate.add(empMaster);
}
empMasterData.conn.close();
} catch (Exception e) {
//System.out.println("Exception in getToDates in EmpMasterData :" + e);
}
return toDate;
}

//end of code added

//code added for Emp Status Report

public static ArrayList getEmpsReport(String hoc,String coc,String doc,String sdoc,String detailwise,String selected[],String sectors,DataSource dataSource) throws Exception 
{
	String str;
	EmpMasterData empMasterData=new EmpMasterData();
	EmpMaster empMaster = null;//Form bean
	ArrayList empsReport = new ArrayList();
	String tittle=null;
	
	try {
		empMasterData.conn = dataSource.getConnection();
		////System.out.println("connection established");
		empMasterData.stmt = empMasterData.conn.createStatement();
		
		////System.out.println("create statement executed");
		String query="";
	
		
		//Testing new Code 23-12-2007
		
		query="select * from rws_employee_tbl where ";
		
		if(!hoc.equals("0"))
		{
			query+=" substr(office_code,1,1)='"+hoc+"' ";
		}
		if(!coc.equals("00"))
		{
			query+=" and substr(office_code,2,2)='"+coc+"' ";
		}
		if(!doc.equals("0"))
		{
			query+=" and substr(office_code,4,1)='"+doc+"' ";
		}
		if(!sdoc.equals("00"))
		{
			query+=" and substr(office_code,5,2)='"+sdoc+"' ";
		}
		if(!sectors.equals("0") && sectors!=null)
		{
			query+=" and sector='"+sectors+"' ";
		}
		if(detailwise!=null && detailwise.equals("01"))
		{
			if(selected.length!=0)
			{
			query+=" and ( " ;
			for(int i=0;i<selected.length;i++)
			{ 
				query+="designation_code='"+selected[i]+"' ";
				if(i<selected.length-1)
				{
					query+=" or ";
				}
			}
			query+=") ";
			}
			
			

			
		}
		if(detailwise!=null && detailwise.equals("02"))
		{
			if(selected.length!=0)
			{
			query+=" and  (" ;
			for(int i=0;i<selected.length;i++)
			{
				query+="zone_code='"+selected[i]+"' ";
				if(i<selected.length-1)
				{
					query+=" or ";
				}	
			}
			query+=") ";
			}			
		}
		query+=" order by designation_code,zone_code,employee_code ";
																
		empMasterData.rs =empMasterData.stmt.executeQuery(query);
		//end of code added
		
		//empMasterData.rs =empMasterData.stmt.executeQuery(query);
		//System.out.println("executed Query "+query);
		while(empMasterData.rs.next()) 
		{
			empMaster = new EmpMaster();
			////System.out.println("rws statement executed");
						
			empMaster.setDesgnCode(empMasterData.rs.getString("DESIGNATION_CODE"));
			empMaster.setDesgnName(getDesgnName(empMasterData.rs.getString("DESIGNATION_CODE"),dataSource));
			
			empMaster.setEmpcode(empMasterData.rs.getString("EMPLOYEE_CODE"));
			empMaster.setEmpname(empMasterData.rs.getString("EMPLOYEE_NAME"));
			
			if(empMasterData.rs.getString("SECTOR")!=null)
			{
				empMaster.setRoc(getHeadName(empMasterData.rs.getString("SECTOR"),dataSource));
			}
						
		try//if(empMasterData.rs.getString("OFFICE_CODE")!=null)
		{
			String officeNames[]=new String[5];
			String hoc1=null;
			String coc1=null;
			String doc1=null;
			String sdoc1=null;
		if(officeNames!=null)
		{					
		nic.watersoft.commons.RwsOffices rwsOffices=new nic.watersoft.commons.RwsOffices(dataSource);
		officeNames=rwsOffices.getOfficeNames(empMasterData.rs.getString("OFFICE_CODE"),true,dataSource);
		hoc1=officeNames[0];
		coc1=officeNames[1];
		doc1=officeNames[2];
		sdoc1=officeNames[3];
		//empMaster.setHoc(hoc1+coc1+doc1+sdoc1);
		empMaster.setHoc(hoc1);
		empMaster.setCoc(coc1);
		empMaster.setDoc(doc1);
		empMaster.setSdoc(sdoc1);
		}
		//System.out.println();
		}catch(Exception e)
		{
			//System.out.println("error in office Code "+e);
		}
		////System.out.println("rwsOffices1");
		
			
			if (empMasterData.rs.getDate("DATE_OF_BIRTH") != null)
			{
				empMaster.setDob(df.format(empMasterData.rs.getDate("DATE_OF_BIRTH")));
			}
			if (empMasterData.rs.getDate("APPOINTMENT_DATE") != null) {
				empMaster.setAppointdate(df.format(empMasterData.rs.getDate("APPOINTMENT_DATE")));
			}
			if (empMasterData.rs.getDate("DATE_OF_JOINING") != null) {
				empMaster.setDoj(df.format(empMasterData.rs.getDate("DATE_OF_JOINING")));
			}
			empMaster.setRelation(empMasterData.rs.getString("FATHER_NAME"));
			empMaster.setZoneName(getZoneName(empMasterData.rs.getString("ZONE_CODE"),dataSource));
			//empMaster.setZone(empMasterData.rs.getString("ZONE_CODE"));
			empMaster.setLocalzone(getZoneName(empMasterData.rs.getString("LOCAL_ZONE"),dataSource));
			
			empsReport.add(empMaster);
		}
	} catch (Exception e) {
		//System.out.println("The error in getEmpsReport() " + e);
	} finally {
		empMasterData.closeAll();
	}
	return empsReport;
}

//end of code added
public static ArrayList getEmpDeptOpt(String dept,DataSource dataSource)
{
	EmpMasterData empMasterData=new EmpMasterData();
	EmpMaster empMaster = null;//Form bean
	ArrayList  DeptReport= new ArrayList();
	try
	{
		empMasterData.conn=dataSource.getConnection();
		////System.out.println("connection established");
		empMasterData.stmt = empMasterData.conn.createStatement();
		////System.out.println("create statement executed");
		String query="";
		////System.out.println("Department opted value in EmpMasterData"+dept);
		query="select * from rws_employee_tbl where DEPT_OPTED='"+dept+"' order by employee_code";
		
		empMasterData.rs =empMasterData.stmt.executeQuery(query);
		//System.out.println("query in DeptOpted wise report"+query);
		while(empMasterData.rs.next()) 
		{
			empMaster = new EmpMaster();
			////System.out.println("rws statement executed");
			empMaster.setEmpcode(empMasterData.rs.getString("EMPLOYEE_CODE"));
			empMaster.setEmpname(empMasterData.rs.getString("EMPLOYEE_NAME"));
			empMaster.setRoc(empMasterData.rs.getString("OFFICE_CODE"));
			if(empMasterData.rs.getString("SECTOR")!=null)
			{
				empMaster.setHoc(getHeadName(empMasterData.rs.getString("SECTOR"),dataSource));
			}
			////System.out.println("employee details executed");
			if(empMasterData.rs.getString("DESIGNATION_CODE")!=null)
			{
			empMaster.setDesgnName(getDesgnName(empMasterData.rs.getString("DESIGNATION_CODE"),dataSource));
			}
			if(empMasterData.rs.getString("DEPT_OPTED")!=null)
			{
			empMaster.setDeptopted(empMasterData.rs.getString("DEPT_OPTED"));
			}
			////System.out.println("end statement executed IN DEPT_OPTED");
			DeptReport.add(empMaster);
		}
	}
	catch (Exception e)
	{
		//System.out.println("The error in getEmps" + e);
	} 
	
	return DeptReport;
}


public static ArrayList getSpousework(String spousework,DataSource dataSource)
{
	EmpMasterData empMasterData=new EmpMasterData();
	EmpMaster empMaster = null;//Form bean
	ArrayList  spouseworking= new ArrayList();
	try
	{
		empMasterData.conn=dataSource.getConnection();
		////System.out.println("connection established");
		empMasterData.stmt = empMasterData.conn.createStatement();
		////System.out.println("create statement executed");
		String query="";
		////System.out.println("spouse work in EmpMasterData"+spousework);
		query="select * from rws_employee_tbl e,rws_employee_spouse_tbl s where e.employee_code=s.employee_code order by e.employee_code";
		empMasterData.rs =empMasterData.stmt.executeQuery(query);
		//System.out.println("query in DeptOpted wise report"+query);
		while(empMasterData.rs.next()) 
		{
			empMaster = new EmpMaster();
			//System.out.println("rws statement executed");
			empMaster.setEmpcode(empMasterData.rs.getString(2));
			empMaster.setEmpname(empMasterData.rs.getString("EMPLOYEE_NAME"));
			empMaster.setRoc(empMasterData.rs.getString("OFFICE_CODE"));
			if(empMasterData.rs.getString("SECTOR")!=null)
			{
				empMaster.setHoc(getHeadName(empMasterData.rs.getString("SECTOR"),empMasterData.conn));
			}
			//System.out.println("employee details executed");
			if(empMasterData.rs.getString("DESIGNATION_CODE")!=null)
			{
			empMaster.setDesgnName(getDesgnName(empMasterData.rs.getString("DESIGNATION_CODE"),empMasterData.conn));
			}
			if(empMasterData.rs.getString("DEPT_OPTED")!=null)
			{
			empMaster.setDeptopted(empMasterData.rs.getString("DEPT_OPTED"));
			}
			if(empMasterData.rs.getDate("DATE_OF_JOINING")!=null)
			{
				empMaster.setDoj(df.format(empMasterData.rs.getDate("DATE_OF_JOINING")));
			}
			if(empMasterData.rs.getString("SPOUSE_CENTRE_STATE")!=null)
			{
				empMaster.setSpouseworking((empMasterData.rs.getString("SPOUSE_CENTRE_STATE")));
			}
			if(empMasterData.rs.getString("SPOUSE_EMPLOYED")!=null)
			{
				empMaster.setSpouseemployd((empMasterData.rs.getString("SPOUSE_EMPLOYED")));
			}
			
			
			//System.out.println("end statement executed IN DEPT_OPTED");
			spouseworking.add(empMaster);
		}
	}
	catch (Exception e)
	{
		//System.out.println("The error in getEmps" + e);
	} 
	
	return spouseworking;
}

//code for Emp Department Opted Report

public static ArrayList getEmpDeptOpt(EmpMaster empMaster,String dept,String fdate,String spousework,String apcat,String desig,String semployd,DataSource dataSource)
{
	EmpMasterData empMasterData=new EmpMasterData();
	//EmpMaster empMaster = null;//Form bean
	ArrayList  DeptReport= new ArrayList();
	try
	{
		empMasterData.conn=dataSource.getConnection();
		////System.out.println("connection established");
		empMasterData.stmt = empMasterData.conn.createStatement();
		////System.out.println("create statement executed");
		String query="";
		////System.out.println("Department opted value in EmpMasterData"+dept);
		////System.out.println("fdate value"+fdate);
		////System.out.println("spouse work"+spousework);
		////System.out.println("APcatog value"+apcat);
		////System.out.println("Designation value"+desig);
		////System.out.println("spouse employed"+semployd);
		////System.out.println("qualification"+empMaster.getQual());
		////System.out.println("present designation"+empMaster.getPresentdesig());
		//query="select * from rws_employee_tbl";
		query="select * from rws_employee_tbl e,rws_employee_spouse_tbl s where e.employee_code=s.employee_code(+) "; 
		if(dept!=null)
		{
			query+=" and e.DEPT_OPTED='"+dept+"' ";
		}
		if(!fdate.equals(""))
		{
			query+=" and e.DATE_OF_JOINING=to_Date('"+fdate+"','dd/mm/yyyy') ";
		}
		if(spousework!=null )
		{
			query+=" and s.SPOUSE_CENTRE_STATE='"+spousework+"' ";
		}
		if(semployd!=null)
		{
			query+=" and s.SPOUSE_EMPLOYED='"+semployd+"' ";
		}
		if(!apcat.equals(""))
		{
			query+=" and e.APCATEG_CODE='"+apcat+"' ";
		}
		if(!desig.equals(""))
		{
			query+=" and e.DESIGNATION_CODE='"+desig+"' ";
		}
		if(!empMaster.getQual().equals(""))
		{
			query+=" and e.QUAL_CODE='"+empMaster.getQual()+"' ";
		}
		if(!empMaster.getPresentdesig().equals(""))
		{
			query+=" and e.PRESENT_DESIG='"+empMaster.getPresentdesig()+"' ";
		}
		query+=" order by e.employee_code";
	/*	if(dept!=null && fdate.equals("") && spousework==null)
		{
			query="select * from rws_employee_tbl where DEPT_OPTED='"+dept+"' order by employee_code";
		}
		else if(dept==null && fdate!=null && spousework==null)
		{
			query="select * from rws_employee_tbl where DATE_OF_JOINING=to_Date('"+fdate+"','dd/mm/yyyy') order by employee_code";
		}
		else if(dept!=null && fdate!="" && spousework!=null)
		{
			query="select * from rws_employee_tbl where DEPT_OPTED='"+dept+"' and DATE_OF_JOINING=to_Date('"+fdate+"','dd/mm/yyyy') order by employee_code";
		}*/
			
		empMasterData.rs =empMasterData.stmt.executeQuery(query);
		//System.out.println("query of Report in DeptOpted wise "+query);
		while(empMasterData.rs.next()) 
		{
			empMaster = new EmpMaster();
			//System.out.println("rws statement executed");
			empMaster.setEmpcode(empMasterData.rs.getString("EMPLOYEE_CODE"));
			empMaster.setEmpname(empMasterData.rs.getString("EMPLOYEE_NAME"));
			
			if(empMasterData.rs.getString("SECTOR")!=null)
			{
				empMaster.setRoc(getHeadName(empMasterData.rs.getString("SECTOR"),dataSource));
			}
						
		try//if(empMasterData.rs.getString("OFFICE_CODE")!=null)
		{
			String officeNames[]=new String[5];
			String hoc1=null;
			String coc1=null;
			String doc1=null;
			String sdoc1=null;
		if(officeNames!=null)
		{					
		nic.watersoft.commons.RwsOffices rwsOffices=new nic.watersoft.commons.RwsOffices(dataSource);
		officeNames=rwsOffices.getOfficeNames(empMasterData.rs.getString("OFFICE_CODE"),true,dataSource);
		hoc1=officeNames[0];
		coc1=officeNames[1];
		doc1=officeNames[2];
		sdoc1=officeNames[3];
		//empMaster.setHoc(hoc1+coc1+doc1+sdoc1);
		empMaster.setHoc(hoc1);
		empMaster.setCoc(coc1);
		empMaster.setDoc(doc1);
		empMaster.setSdoc(sdoc1);
		}
		//System.out.println();
		}catch(Exception e){
			//System.out.println("error in office Codes"+e);
		}
		////System.out.println("rwsOffices1");
		
			
			/*empMaster.setRoc(empMasterData.rs.getString("OFFICE_CODE"));
			if(empMasterData.rs.getString("SECTOR")!=null)
			{
				empMaster.setHoc(getHeadName(empMasterData.rs.getString("SECTOR"),empMasterData.conn));
			}*/
			////System.out.println("employee details executed");
			if(empMasterData.rs.getString("DESIGNATION_CODE")!=null)
			{
			empMaster.setDesgnName(getDesgnName(empMasterData.rs.getString("DESIGNATION_CODE"),dataSource));
			}
			if(empMasterData.rs.getString("DEPT_OPTED")!=null)
			{
			empMaster.setDeptopted(empMasterData.rs.getString("DEPT_OPTED"));
			}
			if(empMasterData.rs.getDate("DATE_OF_JOINING")!=null)
			{
				empMaster.setDoj(df.format(empMasterData.rs.getDate("DATE_OF_JOINING")));
			}
			if(empMasterData.rs.getString("SPOUSE_CENTRE_STATE")!=null)
			{
				empMaster.setSpouseworking(getWorkingName(empMasterData.rs.getString("SPOUSE_CENTRE_STATE")));
				////System.out.println("spouse working     "+empMasterData.rs.getString("SPOUSE_CENTRE_STATE"));
			}
			if(empMasterData.rs.getString("SPOUSE_EMPLOYED")!=null)
			{
				empMaster.setSpouseemployd(getYesNo(empMasterData.rs.getString("SPOUSE_EMPLOYED")));
			}
			if(empMasterData.rs.getString("APCATEG_CODE")!=null)
			{
			try {
				empMaster.setApcatog(getCatogName(empMasterData.rs.getString("APCATEG_CODE"), dataSource));
				} catch (Exception e) {
					//System.out.println("the error in getEmps()= " + e);
				}
			}
			try {
				empMaster.setQual(getQualName(empMasterData.rs.getString("QUAL_CODE"),dataSource));
				}
				catch (Exception e)
				{
					//System.out.println("the error in getEmps()= " + e);
				}
			
				try{
					empMaster.setPresentdesig(getDesigName(empMasterData.rs.getString("PRESENT_DESIG"),dataSource));
					}catch(Exception e)
					{
						//System.out.println("error in Designation"+e);
					}
				
			//System.out.println("end statement executed IN DEPT_OPTED");
			DeptReport.add(empMaster);
		}
	}
	catch (Exception e)
	{
		//System.out.println("The error in getEmps" + e);
	} 
	
	return DeptReport;
}


//end of code
public static ArrayList getEmpsView(DataSource dataSource) throws Exception 
{
	String str;
	EmpMasterData empMasterData=new EmpMasterData();
	EmpMaster empMaster = null;//Form bean
	ArrayList emps = new ArrayList();
	
	try {
		empMasterData.conn = dataSource.getConnection();
		////System.out.println("connection established");
		empMasterData.stmt = empMasterData.conn.createStatement();
		////System.out.println("create statement executed");
		String query=null;
						
		//code added
		query="select * from rws_employee_tbl e,rws_employee_spouse_tbl s where e.employee_code=s.employee_code(+) order by e.employee_code";
		//headOffice
					
		empMasterData.rs =empMasterData.stmt.executeQuery(query);
		////System.out.println("query in getEmps(hoc,coc,doc,sdoc) "+query);
		////System.out.println("select statement executed");
		while(empMasterData.rs.next()) 
		{
			empMaster = new EmpMaster();
			////System.out.println("rws statement executed");

			empMaster.setEmpcode(empMasterData.rs.getString(2));
			////System.out.println(empMasterData.rs.getString(2));
			empMaster.setSurname(empMasterData.rs.getString("EMPLOYEE_SURNAME"));
			empMaster.setEmpname(empMasterData.rs.getString("EMPLOYEE_NAME"));
			//empMaster.setRoc(empMasterData.rs.getString("OFFICE_CODE"));
			if(empMasterData.rs.getString("OFFICE_CODE")!=null)
			{
				String officeNames[]=new String[5];
				String hoc1=null;
				String coc1=null;
				String doc1=null;
				String sdoc1=null;
			if(officeNames!=null)
			{					
			nic.watersoft.commons.RwsOffices rwsOffices=new nic.watersoft.commons.RwsOffices(dataSource);
			officeNames=rwsOffices.getOfficeNames(empMasterData.rs.getString("OFFICE_CODE"),true,dataSource);
			hoc1=officeNames[0];
			coc1=officeNames[1];
			doc1=officeNames[2];
			sdoc1=officeNames[3];
			//empMaster.setHoc(hoc1+coc1+doc1+sdoc1);
			empMaster.setHoc(hoc1);
			empMaster.setCoc(coc1);
			empMaster.setDoc(doc1);
			empMaster.setSdoc(sdoc1);
			}
			//System.out.println();
			}
			////System.out.println("rwsOffices1");
			
			//empMaster.setHoc(empMasterData.rs.getString("SECTOR"));
			if(empMasterData.rs.getString("SECTOR")!=null)
			{
				empMaster.setRoc(getHeadName(empMasterData.rs.getString("SECTOR"),dataSource));
			}
			
			////System.out.println("sector");
			if (empMasterData.rs.getDate("DATE_OF_BIRTH") != null) {
				empMaster.setDob(df.format(empMasterData.rs.getDate("DATE_OF_BIRTH")));
			}
			if (empMasterData.rs.getDate("APPOINTMENT_DATE") != null) {
				empMaster.setAppointdate(df.format(empMasterData.rs.getDate("APPOINTMENT_DATE")));
			}
			if (empMasterData.rs.getDate("DATE_OF_JOINING") != null) {
				empMaster.setDoj(df.format(empMasterData.rs.getDate("DATE_OF_JOINING")));
			}
			if (empMasterData.rs.getDate("CURRENT_POST_HELD_FROM") != null) {
				empMaster.setCurrentpostdate(df.format(empMasterData.rs
						.getDate("CURRENT_POST_HELD_FROM")));
			}
			if(empMasterData.rs.getDate("DATE_OF_COMMENCE_PROBATION")!=null)
			{
				empMaster.setDcommprob(df.format(empMasterData.rs.getDate("DATE_OF_COMMENCE_PROBATION")));
			}
			//empMaster.setDcommprob(empMasterData.rs.getString("DATE_OF_COMMENCE_PROBATION"));
			if(empMasterData.rs.getDate("DATE_OF_REGULARISATION")!=null)
			{
				empMaster.setDdeclprob(df.format(empMasterData.rs.getDate("DATE_OF_REGULARISATION")));					
			}
			if(empMasterData.rs.getDate("ACCTEST_PASS_DATE")!=null)
			{
				empMaster.setDacctest(df.format(empMasterData.rs.getDate("ACCTEST_PASS_DATE")));
			}
			if(empMasterData.rs.getDate("UPDATE_DATE")!=null)
			{
				empMaster.setIncrementdate(df.format(empMasterData.rs.getDate("UPDATE_DATE")));
			}
			
			
			////System.out.println("all date details executed");
			//empMaster.setPhone(empMasterData.rs.getString("PHONE"));
			//empMaster.setMobile(empMasterData.rs.getString("MOBILE"));
			//empMaster.setTotalworkscomp(empMasterData.rs.getString("TOTAL_NO_WORKS_COMPLETED"));
			
			if(empMasterData.rs.getString("QUAL_CODE")!=null)
			{
			//empMaster.setQual(empMasterData.rs.getString("QUAL_CODE"));
			empMaster.setQualName(getQualName(empMasterData.rs.getString("QUAL_CODE"),dataSource));
			////System.out.println("Qualification details");
			}
			
			//if(empMasterData.rs.getString("ADD_QUAL_2")!=null)
			//{
			//////System.out.println("qual2"+empMasterData.rs.getString("ADD_QUAL_2"));
			empMaster.setAddqual2(empMasterData.rs.getString("ADD_QUAL_2"));
			
			try{
				empMaster.setAddqual2(getQualName(empMasterData.rs.getString("ADD_QUAL_2"),dataSource));
				////System.out.println("Qualification details2");
			}
			catch(Exception e)
			{
				//System.out.println("qual2"+e);
			}
			empMaster.setAddqual1(empMasterData.rs.getString("ADD_QUAL_1"));
			
			try{
				empMaster.setAddqual1(getQualName(empMasterData.rs.getString("ADD_QUAL_1"),dataSource));
				////System.out.println("Qualification details1");
			}
			catch(Exception e)
			{
				//System.out.println("qual1"+e);
			}
			
			empMaster.setPresentation(empMasterData.rs.getString("PRESENT_STATION_MANDAL"));
			////System.out.println("work");
			try {
				empMaster.setWorkSpecial(getWorkSpecName(empMasterData.rs.getString("WORK_SPECIALIZATION"),dataSource));
				} catch (Exception e) {
					//System.out.println("the error in getEmps()= " + e);
				}
			
			empMaster.setRelation(empMasterData.rs.getString("FATHER_NAME"));
			////System.out.println("relation details ");
			try {
				empMaster.setNdist(getDistName(dataSource,empMasterData.rs.getString("NATIVE_DISTRICT")));
				} catch (Exception e) {
					//System.out.println("the error in getEmps()= " + e);
				}
	
				try {
					empMaster.setNmand(getMandalName(empMasterData.rs.getString("NATIVE_DISTRICT"),empMasterData.rs.getString("NATIVE_MANDAL"),dataSource));
					} catch (Exception e) {
						//System.out.println("the error in getEmps()= " + e);
					}
						
			////System.out.println("Ndist,Nmand details ");
			try
			{
			empMaster.setNarecruit(getRecName(empMasterData.rs.getString("RECRUIT_LOCAL_NONLOCAL")));
			}catch(Exception e)
			{
				//System.out.println("error in Narecruit"+e);
			}
			try{
				empMaster.setDesig(getTempPer(empMasterData.rs.getString("TEMP_PERMNENT")));
				}catch(Exception e){
					//System.out.println("error in Desig"+e);
				
				}
				try{
				empMaster.setDesgnCode(getDesigName(empMasterData.rs.getString("DESIGNATION_CODE"),dataSource));
				}catch(Exception e)
				{
					//System.out.println("error in Designation"+e);
				}
				try{
					empMaster.setTempdesgCode(getDesigName(empMasterData.rs.getString("DESIGNATION_CODE"),dataSource));
					}catch(Exception e)
					{
						//System.out.println("error in Designation"+e);
					}
				try {
				empMaster.setMoap(getModeName(empMasterData.rs.getString("MOAP_CODE"), dataSource));
				} catch (Exception e) {
					//System.out.println("the error in getEmps()= " + e);
				}
			
			
			try {
				empMaster.setApcatog(getCatogName(empMasterData.rs.getString("APCATEG_CODE"),dataSource));
				} catch (Exception e) {
					//System.out.println("the error in getEmps()= " + e);
				}
		
			//empMaster.setZone(empMasterData.rs.getString("ZONE_CODE"));
			try {
					empMaster.setZone(getZoneName(empMasterData.rs.getString("ZONE_CODE"), dataSource));
					} catch (Exception e) {
						//System.out.println("the error in getEmps()= " + e);
					}
			try{
			empMaster.setGender(getGenderName(empMasterData.rs.getString("SEX")));
			} catch (Exception e) {
				//System.out.println("the error in Gender= " + e);
			}
	
			empMaster.setNrevenue(empMasterData.rs.getString("NATIVE_REV_DIVISION"));
			try{
			empMaster.setTestpassed(getYesNo(empMasterData.rs.getString("ACCTEST_PASSED")));
			}catch (Exception e) {
				//System.out.println("the error in getEmps()= " + e);
			}
	
			////System.out.println("Sex acctest");
			if(empMasterData.rs.getString("DEPUTATION")!=null){
			try{					
			empMaster.setDeputation(getYesNo(empMasterData.rs.getString("DEPUTATION")));
			} catch (Exception e) {
				//System.out.println("the error in getEmps()= " + e);
			}
			}
			empMaster.setPanno(empMasterData.rs.getString("PAN_NO"));
			empMaster.setApgli(empMasterData.rs.getString("APGLI_NO"));
			////System.out.println("pan_no,Deputaion");
			empMaster.setPayscale(empMasterData.rs.getString("PAY_SCALE_PRESENT"));
			////System.out.println("payscale increment data");
							
			empMaster.setOtherDet(empMasterData.rs.getString("OTHER_DETAILS"));
			empMaster.setDesgnCode(empMasterData.rs.getString("DESIGNATION_CODE"));
			empMaster.setCheckType(empMasterData.rs.getString("TYPE_OF_CHECK"));
			empMaster.setNoOfChecks(empMasterData.rs.getInt("NO_OF_CHECKS"));
			empMaster.setCheckPeriod(empMasterData.rs.getString("CHECK_PERIOD"));
			empMaster.setAppOrderRef(empMasterData.rs.getString("APPOINTMENT_ORDER_REF"));
			empMaster.setWorkSpecial(empMasterData.rs.getString("WORK_SPECIALIZATION"));
			empMaster.setPostCode(empMasterData.rs.getString("POST_JOINED_DESG_CODE"));

			//Added on Aug 2
			//empMaster.setReligion(empMasterData.rs.getString("RELG_CODE"));
			empMaster.setReligion(empMasterData.rs.getString("RELG_CODE"));
			try {
				empMaster.setReligion(getReligionName(empMasterData.rs.getString("RELG_CODE"), dataSource));
				} catch (Exception e) {
					//System.out.println("the error in getEmps()= " + e);
				}
			
			empMaster.setDiststudied4(empMasterData.rs.getString("DIST_CLASS_IV"));
			try
			{
			empMaster.setDiststudied4(getDistrictName(empMasterData.rs.getString("DIST_CLASS_IV"), dataSource));
			}
			catch (Exception e) 
			{
				//System.out.println("the error in getEmps()= " + e);
			}
			empMaster.setDiststudied5(empMasterData.rs.getString("DIST_CLASS_V"));
			try
			{
			empMaster.setDiststudied5(getDistrictName(empMasterData.rs.getString("DIST_CLASS_V"),  dataSource));
			}
			catch (Exception e) 
			{
				//System.out.println("the error in getEmps()= " + e);
			}
			
			empMaster.setDiststudied6(empMasterData.rs.getString("DIST_CLASS_VI"));
			try
			{
			empMaster.setDiststudied6(getDistrictName(empMasterData.rs.getString("DIST_CLASS_VI"), dataSource));
			}
			catch (Exception e) 
			{
				//System.out.println("the error in getEmps()= " + e);
			}
			empMaster.setDiststudied7(empMasterData.rs.getString("DIST_CLASS_VII"));
			try
			{
			empMaster.setDiststudied7(getDistrictName(empMasterData.rs.getString("DIST_CLASS_VII"),  dataSource));
			}
			catch (Exception e) 
			{
				//System.out.println("the error in getEmps()= " + e);
			}
			empMaster.setDiststudied8(empMasterData.rs.getString("DIST_CLASS_VIII"));
			try
			{
			empMaster.setDiststudied8(getDistrictName(empMasterData.rs.getString("DIST_CLASS_VIII"), dataSource));
			}
			catch (Exception e) 
			{
				//System.out.println("the error in getEmps()= " + e);
			}
			empMaster.setDiststudied9(empMasterData.rs.getString("DIST_CLASS_IX"));
			try
			{
			empMaster.setDiststudied9(getDistrictName(empMasterData.rs.getString("DIST_CLASS_IX"),  dataSource));
			}
			catch (Exception e) 
			{
				//System.out.println("the error in getEmps()= " + e);
			}
			empMaster.setDiststudied10(empMasterData.rs.getString("DIST_CLASS_X"));
			try
			{
			empMaster.setDiststudied10(getDistrictName(empMasterData.rs.getString("DIST_CLASS_X"), dataSource));
			}
			catch (Exception e) 
			{
				//System.out.println("the error in getEmps()= " + e);
			}
					
			empMaster.setLocaldist(empMasterData.rs.getString("LOCAL_DIST_AS_PER_SCH"));
			try {
				empMaster.setLocaldist(getDistName(dataSource,empMasterData.rs.getString("LOCAL_DIST_AS_PER_SCH")));
				} catch (Exception e) {
					//System.out.println("the error in getEmps()= " + e);
				}
			empMaster.setNoofyrs(empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_DIST"));
			
			empMaster.setLocalzone(empMasterData.rs.getString("LOCAL_ZONE"));
			try {
				empMaster.setLocalzone(getZoneName(empMasterData.rs.getString("LOCAL_ZONE"),  dataSource));
				} catch (Exception e) {
					//System.out.println("the error in getEmps()= " + e);
				}
			empMaster.setNoofyrs1(empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_ZONE"));
			
			
			try {
				empMaster.setPvtdist(getDistName(dataSource,empMasterData.rs.getString("PRIVATE_PASSED_DIST")));
				} catch (Exception e) {
				//System.out.println("the error in getEmps()= " + e);
				}
			
			try {
				empMaster.setPvtzone(getZoneName(empMasterData.rs.getString("PRIVATE_PASSED_ZONE"), dataSource));
				} catch (Exception e) {
					//System.out.println("the error in Pvtzone getEmps()= " + e);
				}
						
			//empMaster.setPvtdist(empMasterData.rs.getString("PRIVATE_PASSED_DIST"));
			//empMaster.setPvtzone(empMasterData.rs.getString("PRIVATE_PASSED_ZONE"));
			
			
			//code added to include spouse details
			if(empMasterData.rs.getString("DEPT_OPTED")!=null)
			{
			empMaster.setDept(empMasterData.rs.getString("DEPT_OPTED"));
			//System.out.println("DEPT OPTED");
			}
			
			if(empMasterData.rs.getString("DEPUTATION_DEPT")!=null)
			{
				empMaster.setDeputationDept(empMasterData.rs.getString("DEPUTATION_DEPT"));
			}
			if(empMasterData.rs.getDate("DEPUTATION_FROM")!=null)
			{
				empMaster.setDeputationDate(df.format(empMasterData.rs.getDate("DEPUTATION_FROM")));
			}
			if(empMasterData.rs.getString("PH")!=null)
			{
				try{
				empMaster.setPh(getYesNo(empMasterData.rs.getString("PH")));
				} catch (Exception e) {
					//System.out.println("the error in PH= " + e);
				}
		
			}
			if(empMasterData.rs.getString("APPOINT_CATEGORY")!=null)
			{
				empMaster.setApptcategory(empMasterData.rs.getString("APPOINT_CATEGORY"));
			}
			if(empMasterData.rs.getDate("PROMOTION_DT_PRESENT_DESG")!=null)
			{
				empMaster.setPromotedate(df.format(empMasterData.rs.getDate("PROMOTION_DT_PRESENT_DESG")));
			
			}
			
			if(empMasterData.rs.getString("SECTION")!=null)
			{
				empMaster.setSection(empMasterData.rs.getString("SECTION"));
			}
			if(empMasterData.rs.getString("SENIORITY")!=null)
			{
				empMaster.setSeniority(empMasterData.rs.getString("SENIORITY"));
			}
			if(empMasterData.rs.getString("DISCIPLINE_CASE")!=null)
			{
				empMaster.setDisciplinecase(getYesNo(empMasterData.rs.getString("DISCIPLINE_CASE")));
			}
			if(empMasterData.rs.getString("DISCIPLINE_TYPE")!=null)
			{
				empMaster.setDisciplinetype(empMasterData.rs.getString("DISCIPLINE_TYPE"));
			}
			if(empMasterData.rs.getString("LEAVE_SUSPENDED")!=null)
			{
				try{
				empMaster.setLeaveSuspend(getLeaveSus(empMasterData.rs.getString("LEAVE_SUSPENDED")));
				} catch (Exception e) {
					//System.out.println("the error in Leave= " + e);
				}
		
			}
			if(empMasterData.rs.getDate("DATE_OF_LEAVE")!=null)
			{
				empMaster.setLeavedate(df.format(empMasterData.rs.getDate("DATE_OF_LEAVE")));
			}
			//spouse details from rws_employee_spouse_tbl
			////System.out.println("CODE ADDED FORM");
			if(empMasterData.rs.getString("SPOUSE_EMPLOYED")!=null)
			{
				try{
			  empMaster.setSpouseemployd(getYesNo(empMasterData.rs.getString("SPOUSE_EMPLOYED")));	
				}catch(Exception e)
				{
					//System.out.println("error in spouse"+e);
				}
				
			}
			if(empMasterData.rs.getString("SPOUSE_CENTRE_STATE")!=null)
			{
				try{
			    empMaster.setSpouseworking(getWorkingName(empMasterData.rs.getString("SPOUSE_CENTRE_STATE")));
				}catch(Exception e)
				{
					//System.out.println("error in working"+e);
				}
			}
			if(empMasterData.rs.getString("SPOUSE_DISTRICT_WORK")!=null)
			{
			  empMaster.setSpouseworkdist(getDistrictName(empMasterData.rs.getString("SPOUSE_DISTRICT_WORK"), dataSource));	
			}
			if(empMasterData.rs.getString("SPOUSE_REV_DIV_WORK")!=null)
			{
			  empMaster.setSpouseworkmand(empMasterData.rs.getString("SPOUSE_REV_DIV_WORK"));	
			}
			if(empMasterData.rs.getString("SPOUSE_REV_MANDAL_WORK")!=null)
			{
			  empMaster.setSpouseworkdiv(empMasterData.rs.getString("SPOUSE_REV_MANDAL_WORK"));	
			}
													
			////System.out.println("spouse details");
		
			//end of code
							
		
			////System.out.println("end statement executed");
			emps.add(empMaster);
		}
	} catch (Exception e) {
		//System.out.println("The error in getEmps" + e);
	} finally {
		empMasterData.closeAll();
	}
	return emps;
}




public static ArrayList getEmps(DataSource dataSource) throws Exception 
{
		String str;
		EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;//Form bean
		ArrayList emps = new ArrayList();
		String query=null;
		String officeNames[]=new String[5];
		String hoc1=null;
		String coc1=null;
		String doc1=null;
		String sdoc1=null;
		
		try {
			empMasterData.conn = dataSource.getConnection();
			////System.out.println("connection established");
			empMasterData.stmt = empMasterData.conn.createStatement();
			////System.out.println("create statement executed");
			query="select * from rws_employee_tbl e,rws_employee_spouse_tbl s where e.employee_code=s.employee_code(+) order by e.employee_code ";
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			////System.out.println("just getemps() without arguments");
			////System.out.println("query in getEmps"+query);
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
						
			empMaster.setEmpcode(empMasterData.rs.getString(2));
			////System.out.println("EMPCODE getEmp"+empMasterData.rs.getString(2));
			empMaster.setSurname(empMasterData.rs.getString("EMPLOYEE_SURNAME"));
			////System.out.println("surname getEmp"+empMasterData.rs.getString("EMPLOYEE_SURNAME"));
			empMaster.setEmpname(empMasterData.rs.getString("EMPLOYEE_NAME"));
			////System.out.println("empname getEmp"+empMasterData.rs.getString("EMPLOYEE_NAME"));
			
			empMaster.setRelation(empMasterData.rs.getString("FATHER_NAME"));
			////System.out.println("relation getEmp"+empMasterData.rs.getString("FATHER_NAME"));
			empMaster.setReligion(empMasterData.rs.getString("RELG_CODE"));
			empMaster.setSocial(empMasterData.rs.getString("CASTE_CODE"));
			////System.out.println("caste getEmp"+empMasterData.rs.getString("CASTE_CODE"));
			empMaster.setNdist(empMasterData.rs.getString("NATIVE_DISTRICT"));
			////System.out.println("Ndistrict getEmp"+empMasterData.rs.getString("NATIVE_DISTRICT"));
			empMaster.setNmand(empMasterData.rs.getString("NATIVE_MANDAL"));
			////System.out.println("Nmand getEmp"+empMasterData.rs.getString("NATIVE_MANDAL"));
			if(empMasterData.rs.getString("SEX")!=null){
			empMaster.setGender(empMasterData.rs.getString("SEX"));
			}
			empMaster.setNrevenue(empMasterData.rs.getString("NATIVE_REV_DIVISION"));
			empMaster.setQual(empMasterData.rs.getString("QUAL_CODE"));
			if(empMasterData.rs.getDate("DATE_OF_BIRTH")!= null) 
			{
				empMaster.setDob(df.format(empMasterData.rs.getDate("DATE_OF_BIRTH")));
			}
			if(empMasterData.rs.getString("PH")!=null)
			{
				empMaster.setHandicap(empMasterData.rs.getString("PH"));
			}
			
			
			if(empMasterData.rs.getString("SPOUSE_EMPLOYED")!=null)
			{
			  empMaster.setSpouseemployd(empMasterData.rs.getString("SPOUSE_EMPLOYED"));	
			  ////System.out.println("Spouse Details in RWS getEmp"+empMasterData.rs.getString("SPOUSE_EMPLOYED"));
			}
			if(empMasterData.rs.getString("SPOUSE_CENTRE_STATE")!=null)
			{
			  empMaster.setSpouseworking(empMasterData.rs.getString("SPOUSE_CENTRE_STATE"));	
			}
			if(empMasterData.rs.getString("SPOUSE_DISTRICT_WORK")!=null)
			{
			  empMaster.setSpouseworkdist(empMasterData.rs.getString("SPOUSE_DISTRICT_WORK"));
			  ////System.out.println("DIstrict employeed getEmp"+empMasterData.rs.getString("SPOUSE_DISTRICT_WORK"));
			}
			if(empMasterData.rs.getString("SPOUSE_REV_DIV_WORK")!=null)
			{
			  empMaster.setSpouseworkmand(empMasterData.rs.getString("SPOUSE_REV_DIV_WORK"));
			  ////System.out.println("spouse Mandal getEmp"+empMasterData.rs.getString("SPOUSE_REV_DIV_WORK"));
			}
			if(empMasterData.rs.getString("SPOUSE_REV_MANDAL_WORK")!=null)
			{
			  empMaster.setSpouseworkdiv(empMasterData.rs.getString("SPOUSE_REV_MANDAL_WORK"));	
			  ////System.out.println("spouse work  Div getEmp"+empMasterData.rs.getString("SPOUSE_REV_MANDAL_WORK"));
			}
			////System.out.println("spouse details");
	
			empMaster.setDiststudied4(empMasterData.rs.getString("DIST_CLASS_IV"));
			try
			{
			empMaster.setDiststudied4(getDistrictName(empMasterData.rs.getString("DIST_CLASS_IV"),  dataSource));
			}
			catch (Exception e) 
			{
				//System.out.println("the error in getEmps()= " + e);
			}
			empMaster.setDiststudied5(empMasterData.rs.getString("DIST_CLASS_V"));
			try
			{
			empMaster.setDiststudied5(getDistrictName(empMasterData.rs.getString("DIST_CLASS_V"),  dataSource));
			}
			catch (Exception e) 
			{
				//System.out.println("the error in getEmps()= " + e);
			}
			
			empMaster.setDiststudied6(empMasterData.rs.getString("DIST_CLASS_VI"));
			try
			{
			empMaster.setDiststudied6(getDistrictName(empMasterData.rs.getString("DIST_CLASS_VI"),  dataSource));
			}
			catch (Exception e) 
			{
				//System.out.println("the error in getEmps()= " + e);
			}
			empMaster.setDiststudied7(empMasterData.rs.getString("DIST_CLASS_VII"));
			try
			{
			empMaster.setDiststudied7(getDistrictName(empMasterData.rs.getString("DIST_CLASS_VII"), empMasterData.conn));
			}
			catch (Exception e) 
			{
				//System.out.println("the error in getEmps()= " + e);
			}
			empMaster.setDiststudied8(empMasterData.rs.getString("DIST_CLASS_VIII"));
			try
			{
			empMaster.setDiststudied8(getDistrictName(empMasterData.rs.getString("DIST_CLASS_VIII"), dataSource));
			}
			catch (Exception e) 
			{
				//System.out.println("the error in getEmps()= " + e);
			}
			empMaster.setDiststudied9(empMasterData.rs.getString("DIST_CLASS_IX"));
			try
			{
			empMaster.setDiststudied9(getDistrictName(empMasterData.rs.getString("DIST_CLASS_IX"), empMasterData.conn));
			}
			catch (Exception e) 
			{
				//System.out.println("the error in getEmps()= " + e);
			}
			empMaster.setDiststudied10(empMasterData.rs.getString("DIST_CLASS_X"));
			try
			{
			empMaster.setDiststudied10(getDistrictName(empMasterData.rs.getString("DIST_CLASS_X"),  dataSource));
			}
			catch (Exception e) 
			{
				//System.out.println("the error in getEmps()= " + e);
			}
		empMaster.setLocaldist(empMasterData.rs.getString("LOCAL_DIST_AS_PER_SCH"));
			empMaster.setNoofyrs(empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_DIST"));
			////System.out.println("the getemps Noofyrs"+empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_DIST"));
			empMaster.setLocalzone(empMasterData.rs.getString("LOCAL_ZONE"));
			empMaster.setNoofyrs1(empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_ZONE"));
			////System.out.println("the getemps Noofyrs1"+empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_ZONE"));
			empMaster.setPvtdist(empMasterData.rs.getString("PRIVATE_PASSED_DIST"));
			empMaster.setPvtzone(empMasterData.rs.getString("PRIVATE_PASSED_ZONE"));
			////System.out.println("PVT ZONE VALUE"+empMasterData.rs.getString("PRIVATE_PASSED_ZONE"));

			if(empMasterData.rs.getString("TEMP_PERMNENT")!=null){
			empMaster.setDesig(empMasterData.rs.getString("TEMP_PERMNENT"));
			////System.out.println("Desig getEmp"+empMasterData.rs.getString("TEMP_PERMNENT"));
			}
			empMaster.setDesgnCode(empMasterData.rs.getString("DESIGNATION_CODE"));
			////System.out.println("Desgncode getEmp"+empMasterData.rs.getString("DESIGNATION_CODE"));
			if(empMasterData.rs.getString("APPOINT_CATEGORY")!=null)
			{
				empMaster.setApptcategory(empMasterData.rs.getString("APPOINT_CATEGORY"));
				////System.out.println("ApptCatergory getEmp"+empMasterData.rs.getString("APPOINT_CATEGORY"));
			}
			if(empMasterData.rs.getDate("APPOINTMENT_DATE")!= null) 
			{
				empMaster.setAppointdate(df.format(empMasterData.rs.getDate("APPOINTMENT_DATE")));
			}
							
			if (empMasterData.rs.getDate("DATE_OF_JOINING")!= null) 
			{
				empMaster.setDoj(df.format(empMasterData.rs.getDate("DATE_OF_JOINING")));
			}
			empMaster.setNarecruit(empMasterData.rs.getString("RECRUIT_LOCAL_NONLOCAL"));
			empMaster.setZone(empMasterData.rs.getString("ZONE_CODE"));
			////System.out.println("zone details executed");
			empMaster.setApcatog(empMasterData.rs.getString("APCATEG_CODE"));
			empMaster.setMoap(empMasterData.rs.getString("MOAP_CODE"));
			
			
			if(empMasterData.rs.getDate("DATE_OF_COMMENCE_PROBATION")!=null)
			{
				empMaster.setDcommprob(df.format(empMasterData.rs.getDate("DATE_OF_COMMENCE_PROBATION")));					
			}
			if(empMasterData.rs.getDate("DATE_OF_REGULARISATION")!=null)
			{
				empMaster.setDdeclprob(df.format(empMasterData.rs.getDate("DATE_OF_REGULARISATION")));					
			}
			if (empMasterData.rs.getDate("CURRENT_POST_HELD_FROM")!= null) 
			{
				empMaster.setCurrentpostdate(df.format(empMasterData.rs.getDate("CURRENT_POST_HELD_FROM")));
			}
			if(empMasterData.rs.getDate("PROMOTION_DT_PRESENT_DESG")!=null)
			{
			   empMaster.setPromotedate(df.format(empMasterData.rs.getDate("PROMOTION_DT_PRESENT_DESG")));
			}
			
			
			empMaster.setTestpassed(empMasterData.rs.getString("ACCTEST_PASSED"));
			if(empMasterData.rs.getDate("ACCTEST_PASS_DATE")!=null)
			{
				empMaster.setDacctest(df.format(empMasterData.rs.getDate("ACCTEST_PASS_DATE")));					
			}
			empMaster.setAddqual2(empMasterData.rs.getString("ADD_QUAL_2"));
			empMaster.setAddqual1(empMasterData.rs.getString("ADD_QUAL_1"));
			empMaster.setPresentdesig(empMasterData.rs.getString("PRESENT_DESIG"));
			empMaster.setWorkSpecial(empMasterData.rs.getString("WORK_SPECIALIZATION"));
			////System.out.println("work Special getEmp"+empMasterData.rs.getString("WORK_SPECIALIZATION"));
			/*try {
				empMaster.setWorkSpecial(empMasterData.rs.getString("WORK_SPECIALIZATION"));
				} catch (Exception e) {
					////System.out.println("the error in getEmps()= " + e);
				}*/
			
		
			empMaster.setOtherDet(empMasterData.rs.getString("OTHER_DETAILS"));
						
			empMaster.setHoc((empMasterData.rs.getString("OFFICE_CODE")).substring(0,1));				
			empMaster.setCoc((empMasterData.rs.getString("OFFICE_CODE")).substring(1,3));
			empMaster.setDoc((empMasterData.rs.getString("OFFICE_CODE")).substring(3,4));
			empMaster.setSdoc((empMasterData.rs.getString("OFFICE_CODE")).substring(4,6));
			if(empMasterData.rs.getString("SECTION")!=null)
			{
				empMaster.setSection(empMasterData.rs.getString("SECTION"));
			}
			if(empMasterData.rs.getString("DEPT_OPTED")!=null)
			{
			empMaster.setDept(empMasterData.rs.getString("DEPT_OPTED"));
			////System.out.println("DEPT OPTED");
			}
			empMaster.setRoc(empMasterData.rs.getString("OFFICE_CODE"));
			////System.out.println("officecode roc"+empMasterData.rs.getString("OFFICE_CODE"));
			empMaster.setDeputation(empMasterData.rs.getString("DEPUTATION"));
			if(empMasterData.rs.getDate("DEPUTATION_FROM")!=null)
			{
				empMaster.setDeputationDate(df.format(empMasterData.rs.getDate("DEPUTATION_FROM")));
				////System.out.println("Deputation Date getEmp"+df.format(empMasterData.rs.getDate("DEPUTATION_FROM")));
			}//Deputation Date names as Depu
			/*if(empMasterData.rs.getString("DEPUTATION_DEPT")!=null)
			{
				empMaster.setDeputationDept(empMasterData.rs.getString("DEPUTATION_DEPT"));
			}*/
			if(empMasterData.rs.getString("DEPUTATION_DEPT")!=null)
			{
			empMaster.setDeputationDept(empMasterData.rs.getString("DEPUTATION_DEPT"));
			////System.out.println("DEPUTATION_DEPT"+empMasterData.rs.getString("DEPUTATION_DEPT"));
			}
			
			
			if(empMasterData.rs.getString("SENIORITY")!=null)
			{
			empMaster.setSeniority(empMasterData.rs.getString("SENIORITY"));
			////System.out.println("Seniority getEmp"+empMasterData.rs.getString("SENIORITY"));
			}
			
			if(empMasterData.rs.getString("DISCIPLINE_CASE")!=null)
			{
				empMaster.setDisciplinecase(empMasterData.rs.getString("DISCIPLINE_CASE"));
			}
			if(empMasterData.rs.getString("DISCIPLINE_TYPE")!=null)
			{
				empMaster.setDisciplinetype(empMasterData.rs.getString("DISCIPLINE_TYPE"));
				////System.out.println("Discipline Type getEmp"+empMasterData.rs.getString("DISCIPLINE_TYPE"));
			}
			/*if(empMasterData.rs.getString("LEAVE_SUSPENDED")!=null)
			{
				empMaster.setLeaveSuspend(empMasterData.rs.getString("LEAVE_SUSPENDED"));
			}
			if(empMasterData.rs.getDate("DATE_OF_LEAVE")!=null)
			{
				empMaster.setLeavedate(df.format(empMasterData.rs.getDate("DATE_OF_LEAVE")));
			}*/
			empMaster.setPanno(empMasterData.rs.getString("PAN_NO"));
			empMaster.setApgli(empMasterData.rs.getString("APGLI_NO"));
			empMaster.setGpfno(empMasterData.rs.getString("GPF_NO"));
			////System.out.println("in the pan_no");
			empMaster.setPayscale(empMasterData.rs.getString("PAY_SCALE_PRESENT"));
			if(empMasterData.rs.getDate("UPDATE_DATE")!=null)
			{
				empMaster.setIncrementdate(df.format(empMasterData.rs.getDate("UPDATE_DATE")));
			}
						
				emps.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getEmps" + e);
		} finally {
			empMasterData.closeAll();
		}
		return emps;
	}



//Code Added for Water quality Test Reports

public static ArrayList getWQFromDates(DataSource dataSource)
throws Exception {  
EmpMasterData empMasterData=new EmpMasterData();
String query;
ArrayList fromDate = new ArrayList();
try {
//query = "select distinct to_char(access_date,'DD/MM/yy') from rws_log_tbl order by to_char(access_date,'DD/MM/yy')  desc";
query = "select distinct to_char(SAMP_COLLECT_DATE,'dd/mm/yy') as a1 from RWS_WATER_SAMPLE_COLLECT_TBL order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";

empMasterData.conn = dataSource.getConnection();
empMasterData.stmt = empMasterData.conn.createStatement();
empMasterData.rs =empMasterData.stmt.executeQuery(query);
//System.out.println("from date query is "+query);
EmpMaster empMaster = null;
while (empMasterData.rs.next()) {
	empMaster = new EmpMaster();
	empMaster.setFromDate(empMasterData.rs.getString(1));
	//System.out.println("the value of FromDate in query"+empMasterData.rs.getString(1));
	fromDate.add(empMaster);
}
empMasterData.conn.close();
} catch (Exception e) {
//System.out.println("Exception in GetDate in EmpMaster :" + e);
}
return fromDate;
}

public static ArrayList getWQToDates(String fromDate, DataSource dataSource) {
String query;
ArrayList toDate = new ArrayList();
EmpMasterData empMasterData=new EmpMasterData();
//System.out.println("the value of FromDate in ToDate"+fromDate);
//System.out.println("started getToDates in EmpMasterData before try");
try {

//query = "select distinct to_char(access_date,'DD/MM/yy') from rws_log_tbl where to_date(ACCESS_DATE,'dd/mm/yy') >= to_Date('"
		//+ fromDate + "','dd/mm/yy') order by to_char(access_date,'DD/MM/yy')  desc";
		
query = "select distinct to_char(SAMP_COLLECT_DATE,'dd/mm/yy') as a1 from RWS_WATER_SAMPLE_COLLECT_TBL where SAMP_COLLECT_DATE>=to_Date('"+fromDate+"','dd/mm/yy') order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";

empMasterData.conn = dataSource.getConnection();
//System.out.println("empMasterData.conn" + empMasterData.conn);
empMasterData.stmt = empMasterData.conn.createStatement();
empMasterData.rs =empMasterData.stmt.executeQuery(query);
//System.out.println("to Date Query"+query);
EmpMaster empMaster = null;
////System.out.println("empMasterData.rs.next() :"+empMasterData.rs.next());

while (empMasterData.rs.next()) 
{
	empMaster = new EmpMaster();
	empMaster.setToDate(empMasterData.rs.getString(1));
	toDate.add(empMaster);
}
empMasterData.conn.close();
}
catch (Exception e) {
//System.out.println("Exception in getToDates in EmpMasterData :" + e);
}

return toDate;
}


public static ArrayList WQsampleTest(String coc,String doc,String sdoc,String fromdate,String todate,String tname,DataSource dataSource) throws Exception 
{
	String str;
	EmpMasterData empMasterData=new EmpMasterData();
	WaterTestForm waterTestForm = null;//Form bean
	ArrayList sampletest = new ArrayList();
	
	try {
		empMasterData.conn = dataSource.getConnection();
		//System.out.println("connection established");
		empMasterData.stmt = empMasterData.conn.createStatement();
		//System.out.println("create statement executed");
		String query="";
		//System.out.println("coc="+coc+"doc="+doc+"sdoc="+sdoc+"fromdate="+fromdate+"todate="+todate);
		//System.out.println("test Name"+tname);
		
		
		//code added
		query="select * from rws_water_sample_collect_tbl s,rws_water_quality_lab_tbl q where s.lab_code=q.lab_code  ";
			
		if(!coc.equals("00"))
		{
			query+=" and s.CIRCLE_OFFICE_CODE='"+coc+"' ";
		}
		if(!doc.equals("0"))
		{
			query+=" and s.DIVISION_OFFICE_CODE ='"+doc+"' ";
		}
		if(!sdoc.equals("00"))
		{
			query+=" and s.SUBDIVISION_OFFICE_CODE ='"+sdoc+"' ";
		}
		if(!fromdate.equals("") && !todate.equals(""))
		{
			query+=" and s.SAMP_COLLECT_DATE >=to_Date('"+fromdate+"','dd/mm/yy') and s.SAMP_COLLECT_DATE <=to_Date('"+todate+"','dd/mm/yy')  ";
		}
		if(!tname.equals(""))
		{
			query+=" and s.TEST_CODE='"+tname+"'  ";
		}
		query+=" order by TEST_ID,SAMP_COLLECT_DATE desc ";
	
		
		//System.out.println("query of SAMPLE TEST "+query);
		empMasterData.rs =empMasterData.stmt.executeQuery(query);
		//end of code added
		
		//empMasterData.rs =empMasterData.stmt.executeQuery(query);
		//System.out.println("select statement executed");
		while(empMasterData.rs.next()) 
		{
			waterTestForm = new WaterTestForm();
			////System.out.println("rws statement executed");
		
	
		////System.out.println("rwsOffices1");
		//waterTestForm.setHoc("CE RWS");
				
		if(empMasterData.rs.getString("CIRCLE_OFFICE_CODE")!=null)
		{			
			waterTestForm.setCoc(getCircleOfficeName("1",empMasterData.rs.getString("CIRCLE_OFFICE_CODE"),empMasterData.conn)+"  Circle");				
		}
		
		if(empMasterData.rs.getString("DIVISION_OFFICE_CODE")!=null)
		{			
			waterTestForm.setDoc(getDivisionOfficeName("1",empMasterData.rs.getString("CIRCLE_OFFICE_CODE"),empMasterData.rs.getString("DIVISION_OFFICE_CODE"),empMasterData.conn)+"  Division");				
		}
		
		if(empMasterData.rs.getString("SUBDIVISION_OFFICE_CODE")!=null)
		{			
			waterTestForm.setSdoc(getSubDivisionOfficeName("1",empMasterData.rs.getString("CIRCLE_OFFICE_CODE"),empMasterData.rs.getString("DIVISION_OFFICE_CODE"),empMasterData.rs.getString("SUBDIVISION_OFFICE_CODE"),empMasterData.conn)+"  SubDivision");				
			
		}		
		
		if(empMasterData.rs.getString("TEST_CODE")!=null)
		{
			////System.out.println(empMasterData.rs.getString("TEST_CODE"));
			waterTestForm.setTestName(getTestName(empMasterData.rs.getString("TEST_CODE"),empMasterData.conn));				
		}
		
	 if(empMasterData.rs.getString("TEST_ID")!=null)
	 {
		
        waterTestForm.setTestID(empMasterData.rs.getString("TEST_ID"));
		}
		
		try
		{
		if(empMasterData.rs.getString("HAB_CODE")!=null)
		{
			waterTestForm.setHabCode(getHabNames(empMasterData.rs.getString("HAB_CODE"),empMasterData.conn));
		}
		}catch(Exception e)
		{
			//System.out.println("error at getting habname"+e);
		}
		
		if(empMasterData.rs.getString("NATURE_OF_TEST")!=null)
		{
			waterTestForm.setNatureOfTest(empMasterData.rs.getString("NATURE_OF_TEST"));
		}
				
		if(empMasterData.rs.getDate("SAMP_COLLECT_DATE")!=null)
		{
			waterTestForm.setSampcollectdate(df.format(empMasterData.rs.getDate("SAMP_COLLECT_DATE")));
		}		
		if(empMasterData.rs.getString("LAB_CODE")!=null)
		{
			waterTestForm.setLabCode(getLabName(empMasterData.rs.getString("LAB_CODE"),empMasterData.conn));
		}
		if(empMasterData.rs.getString("LOCATION")!=null)
		{
			waterTestForm.setLabLocation(empMasterData.rs.getString("LOCATION"));
		}
		
			//System.out.println("end statement executed");
			sampletest.add(waterTestForm);
		}
	} catch (Exception e) {
		//System.out.println("The error in getWQSampelTest" + e);
	} finally {
		empMasterData.closeAll();
	}
	return sampletest;
}

public static ArrayList WQTestNotDone(String coc,String doc,String sdoc,String fromdate,String todate,String tname,DataSource dataSource) throws Exception 
{
	String str;
	EmpMasterData empMasterData=new EmpMasterData();
	WaterTestForm waterTestForm = null;//Form bean
	ArrayList sampletest = new ArrayList();
	
	try {
		empMasterData.conn = dataSource.getConnection();
		//System.out.println("connection established");
		empMasterData.stmt = empMasterData.conn.createStatement();
		//System.out.println("create statement executed");
		String query="";
		//System.out.println("coc="+coc+"doc="+doc+"sdoc="+sdoc+"fromdate="+fromdate+"todate="+todate);
		//System.out.println("test Name"+tname);
		
		//code added
		//query="select * from rws_water_sample_collect_tbl where ";
		query="select * from rws_water_sample_collect_tbl samp,rws_water_quality_lab_tbl lab where samp.lab_code=lab.lab_code  ";
			
		if(!coc.equals("00"))
		{
			query+=" and samp.CIRCLE_OFFICE_CODE='"+coc+"' ";
		}
		if(!doc.equals("0"))
		{
			query+=" and samp.DIVISION_OFFICE_CODE ='"+doc+"' ";
		}
		if(!sdoc.equals("00"))
		{
			query+=" and samp.SUBDIVISION_OFFICE_CODE ='"+sdoc+"' ";
		}
		if(!fromdate.equals("") && !todate.equals(""))
		{
			query+=" and samp.SAMP_COLLECT_DATE >=to_Date('"+fromdate+"','dd/mm/yy') and samp.SAMP_COLLECT_DATE <=to_Date('"+todate+"','dd/mm/yy')  ";
		}
		if(!tname.equals(""))
		{
			query+=" and samp.TEST_CODE is null ";
		}
		query+=" order by samp.TEST_ID,samp.samp_collect_date ";
		
		//System.out.println("query of TEST Not Conducted"+query);
		empMasterData.rs =empMasterData.stmt.executeQuery(query);
		//end of code added
		
		//empMasterData.rs =empMasterData.stmt.executeQuery(query);
		//System.out.println("select statement executed");
		while(empMasterData.rs.next()) 
		{
			waterTestForm = new WaterTestForm();
			//System.out.println("rws statement executed");
		
		//System.out.println("rwsOffices1");
		//waterTestForm.setHoc("CE RWS");
				
		if(empMasterData.rs.getString("CIRCLE_OFFICE_CODE")!=null)
		{			
			waterTestForm.setCoc(getCircleOfficeName("1",empMasterData.rs.getString("CIRCLE_OFFICE_CODE"),empMasterData.conn)+"  Circle");				
		}
		if(empMasterData.rs.getString("DIVISION_OFFICE_CODE")!=null)
		{			
			waterTestForm.setDoc(getDivisionOfficeName("1",empMasterData.rs.getString("CIRCLE_OFFICE_CODE"),empMasterData.rs.getString("DIVISION_OFFICE_CODE"),empMasterData.conn)+"  Division");				
		}
		if(empMasterData.rs.getString("SUBDIVISION_OFFICE_CODE")!=null)
		{			
			waterTestForm.setSdoc(getSubDivisionOfficeName("1",empMasterData.rs.getString("CIRCLE_OFFICE_CODE"),empMasterData.rs.getString("DIVISION_OFFICE_CODE"),empMasterData.rs.getString("SUBDIVISION_OFFICE_CODE"),empMasterData.conn)+"  SubDivision");				
		}		
		if(empMasterData.rs.getString("TEST_CODE")==null)
		{
			waterTestForm.setTestName(empMasterData.rs.getString("TEST_CODE"));				
		}
		else
		{
			waterTestForm.setTestName(getTestName(empMasterData.rs.getString("TEST_CODE"),empMasterData.conn));
		}
		if(empMasterData.rs.getString("TEST_ID")!=null)
		{
			waterTestForm.setTestID(empMasterData.rs.getString("TEST_ID"));
		}
		if(empMasterData.rs.getString("HAB_CODE")!=null)
		{
			waterTestForm.setHabCode(empMasterData.rs.getString("HAB_CODE"));
		}
		if(empMasterData.rs.getString("NATURE_OF_TEST")==null)
		{
			waterTestForm.setNatureOfTest(empMasterData.rs.getString("NATURE_OF_TEST"));
		}
		else
		{
			waterTestForm.setNatureOfTest(empMasterData.rs.getString("NATURE_OF_TEST"));	
		}
		if(empMasterData.rs.getString("LAB_CODE")!=null)
		{
			waterTestForm.setLabCode(getLabName(empMasterData.rs.getString("LAB_CODE"),empMasterData.conn));
		}
		if(empMasterData.rs.getString("LOCATION")!=null)
		{
			waterTestForm.setLabLocation(empMasterData.rs.getString("LOCATION"));
		}
		if(empMasterData.rs.getDate("SAMP_COLLECT_DATE")!=null)
		{
			waterTestForm.setSampcollectdate(df.format(empMasterData.rs.getDate("SAMP_COLLECT_DATE")));
		}
			//System.out.println("end statement executed");
			sampletest.add(waterTestForm);
		}
	} catch (Exception e) {
		//System.out.println("The error in getWQSampelTest" + e);
	} finally {
		empMasterData.closeAll();
	}
	return sampletest;
}


public static ArrayList WQDataUpdated(String coc,String doc,String sdoc,String fromdate,String todate,String tname,DataSource dataSource) throws Exception 
{
	String str;
	EmpMasterData empMasterData=new EmpMasterData();
	WaterTestForm waterTestForm = null;//Form bean
	ArrayList sampletest = new ArrayList();
	
	try {
		empMasterData.conn = dataSource.getConnection();
		//System.out.println("connection established");
		empMasterData.stmt = empMasterData.conn.createStatement();
		//System.out.println("create statement executed");
		String query="";
		//System.out.println("coc="+coc+"doc="+doc+"sdoc="+sdoc+"fromdate="+fromdate+"todate="+todate);
		//System.out.println("test Name"+tname);
		
		//code added
		//query="select * from rws_water_sample_collect_tbl where ";
		
		//query="select * from rws_water_sample_collect_tbl samp,RWS_WQ_TEST_RESULTS_TBL testResults,rws_water_quality_lab_tbl lab where s.test_id=t.test_id  ";
		query="select * from rws_water_sample_collect_tbl samp,RWS_WQ_TEST_RESULTS_TBL test," +
				"rws_water_quality_lab_tbl lab where samp.test_id=test.test_id and samp.lab_code=lab.lab_code "  ;
		
		if(!coc.equals("00"))
		{
			query+=" and samp.CIRCLE_OFFICE_CODE='"+coc+"' ";
		}
		if(!doc.equals("0"))
		{
			query+=" and samp.DIVISION_OFFICE_CODE ='"+doc+"' ";
		}
		if(!sdoc.equals("00"))
		{
			query+=" and samp.SUBDIVISION_OFFICE_CODE ='"+sdoc+"' ";
		}
		if(!fromdate.equals("") && !todate.equals(""))
		{
			query+=" and samp.SAMP_COLLECT_DATE >=to_Date('"+fromdate+"','dd/mm/yy') and samp.SAMP_COLLECT_DATE <=to_Date('"+todate+"','dd/mm/yy')  ";
		}
		if(!tname.equals(""))
		{
			query+=" and samp.TEST_CODE='"+tname+"' and test.UPDATE_SOURCE_DATA='Y' ";
		}
		query+=" order by samp.test_id,samp.SAMP_COLLECT_DATE desc";
		
		//System.out.println("query of TEST Not Conducted"+query);
		empMasterData.rs =empMasterData.stmt.executeQuery(query);
		//end of code added
		
		//empMasterData.rs =empMasterData.stmt.executeQuery(query);
		//System.out.println("select statement executed");
		while(empMasterData.rs.next()) 
		{
			waterTestForm = new WaterTestForm();
			//System.out.println("rws statement executed");
		
		//System.out.println("rwsOffices1");
		//waterTestForm.setHoc("CE RWS");
			
		//System.out.println("test_id in resultset"+empMasterData.rs.getString(1)+" 2 "+empMasterData.rs.getString(2));
		//waterTestForm.rs.getString(empMasterData.rs.getString())
		
		if(empMasterData.rs.getString("CIRCLE_OFFICE_CODE")!=null)
		{			
			waterTestForm.setCoc(getCircleOfficeName("1",empMasterData.rs.getString("CIRCLE_OFFICE_CODE"),empMasterData.conn)+"  Circle");				
		}		
		if(empMasterData.rs.getString("DIVISION_OFFICE_CODE")!=null)
		{			
			waterTestForm.setDoc(getDivisionOfficeName("1",empMasterData.rs.getString("CIRCLE_OFFICE_CODE"),empMasterData.rs.getString("DIVISION_OFFICE_CODE"),empMasterData.conn)+"  Division");				
		}		
		if(empMasterData.rs.getString("SUBDIVISION_OFFICE_CODE")!=null)
		{			
			waterTestForm.setSdoc(getSubDivisionOfficeName("1",empMasterData.rs.getString("CIRCLE_OFFICE_CODE"),empMasterData.rs.getString("DIVISION_OFFICE_CODE"),empMasterData.rs.getString("SUBDIVISION_OFFICE_CODE"),empMasterData.conn)+"  SubDivision");				
		}		
		if(empMasterData.rs.getString("TEST_CODE")!=null)
		{
			waterTestForm.setTestName(getTestName(empMasterData.rs.getString("TEST_CODE"),empMasterData.conn));				
		}		
		if(empMasterData.rs.getString("TEST_ID")!=null)
		{
			waterTestForm.setTestID(empMasterData.rs.getString("TEST_ID"));
		}		
		if(empMasterData.rs.getString("HAB_CODE")!=null)
		{
			waterTestForm.setHabCode(empMasterData.rs.getString("HAB_CODE"));
		}		
		if(empMasterData.rs.getString("NATURE_OF_TEST")!=null)
		{
			waterTestForm.setNatureOfTest(empMasterData.rs.getString("NATURE_OF_TEST"));
		}				
		if(empMasterData.rs.getDate("SAMP_COLLECT_DATE")!=null)
		{
			waterTestForm.setSampcollectdate(df.format(empMasterData.rs.getDate("SAMP_COLLECT_DATE")));
		}
		if(empMasterData.rs.getString("UPDATE_SOURCE_DATA")!=null)
		{
			waterTestForm.setSampleUpdateData(getYesNo(empMasterData.rs.getString("UPDATE_SOURCE_DATA")));
		}
		if(empMasterData.rs.getString("LAB_CODE")!=null)
		{
			waterTestForm.setLabCode(getLabName(empMasterData.rs.getString("LAB_CODE"),empMasterData.conn));
		}
		if(empMasterData.rs.getString("LOCATION")!=null)
		{
			waterTestForm.setLabLocation(empMasterData.rs.getString("LOCATION"));
		}
		
			//System.out.println("end statement executed");
			sampletest.add(waterTestForm);
		}
	} catch (Exception e) {
		//System.out.println("The error in getWQSampelTest" + e);
	} finally {
		empMasterData.closeAll();
	}
	return sampletest;
}

public static ArrayList WQVariousTests(String coc,String doc,String sdoc,String fromdate,String todate,String sourceType,DataSource dataSource) throws Exception 
{
	String str;
	EmpMasterData empMasterData=new EmpMasterData();
	WaterTestForm waterTestForm = null;//Form bean
	ArrayList sampletest = new ArrayList();
	
	try {
		empMasterData.conn = dataSource.getConnection();
		//System.out.println("connection established");
		empMasterData.stmt = empMasterData.conn.createStatement();
		//System.out.println("create statement executed");
		String query="";
		//System.out.println("coc="+coc+"doc="+doc+"sdoc="+sdoc+"fromdate="+fromdate+"todate="+todate);
		//System.out.println("Source Type"+sourceType);
		  
		
		//code added
		//query="select * from rws_water_sample_collect_tbl where ";
		query="select * from rws_water_sample_collect_tbl samp,rws_water_quality_lab_tbl lab where samp.lab_code=lab.lab_code  ";
	//query="select * from rws_water_sample_collect_tbl s, RWS_WQ_TEST_RESULTS_TBL t where s.test_id=t.test_id  "; 	
	
		if(!coc.equals("00"))
		{
			query+=" and samp.CIRCLE_OFFICE_CODE='"+coc+"' ";
		}
		if(!doc.equals("0"))
		{
			query+=" and samp.DIVISION_OFFICE_CODE ='"+doc+"' ";
		}
		if(!sdoc.equals("00"))
		{
			query+=" and samp.SUBDIVISION_OFFICE_CODE ='"+sdoc+"' ";
		}
		if(!fromdate.equals("") && !todate.equals(""))
		{
			query+=" and samp.SAMP_COLLECT_DATE >=to_Date('"+fromdate+"','dd/mm/yy') and samp.SAMP_COLLECT_DATE <=to_Date('"+todate+"','dd/mm/yy')  ";
		}
		if(!sourceType.equals(""))
		{
			query+=" and samp.SOURCE_TYPE='"+sourceType+"' ";
		}
		query+=" order by samp.TEST_ID,samp.samp_collect_date ";
		
		//System.out.println("query of Various Tests"+query);
		empMasterData.rs =empMasterData.stmt.executeQuery(query);
		//end of code added
		
		//empMasterData.rs =empMasterData.stmt.executeQuery(query);
		//System.out.println("select statement executed");
		while(empMasterData.rs.next()) 
		{
			
			SubCompMetaData subCompMetaData=new SubCompMetaData(empMasterData.rs.getString("SOURCE_CODE"));
			//if(subCompMetaData.getAssetCompTypeCode().equals(sourceType.substring(0,2)) &&  subCompMetaData.getAssetSubCompTypeCode().equals(sourceType.substring(2,4)) && subCompMetaData.getTypeOfAssetCode().equals(sourceType.substring(4,7)))
			//{
			
			waterTestForm = new WaterTestForm();
			//System.out.println("rws statement executed");
		
		//System.out.println("rwsOffices1");
		//waterTestForm.setHoc("CE RWS");
			
		//System.out.println("test_id in resultset"+empMasterData.rs.getString(1)+" 2 "+empMasterData.rs.getString(2));
		//waterTestForm.rs.getString(empMasterData.rs.getString())
		
		if(empMasterData.rs.getString("CIRCLE_OFFICE_CODE")!=null)
		{			
			waterTestForm.setCoc(getCircleOfficeName("1",empMasterData.rs.getString("CIRCLE_OFFICE_CODE"),empMasterData.conn)+"  Circle");				
		}
		
		if(empMasterData.rs.getString("DIVISION_OFFICE_CODE")!=null)
		{			
			waterTestForm.setDoc(getDivisionOfficeName("1",empMasterData.rs.getString("CIRCLE_OFFICE_CODE"),empMasterData.rs.getString("DIVISION_OFFICE_CODE"),empMasterData.conn)+"  Division");				
		}
		
		if(empMasterData.rs.getString("SUBDIVISION_OFFICE_CODE")!=null)
		{			
			waterTestForm.setSdoc(getSubDivisionOfficeName("1",empMasterData.rs.getString("CIRCLE_OFFICE_CODE"),empMasterData.rs.getString("DIVISION_OFFICE_CODE"),empMasterData.rs.getString("SUBDIVISION_OFFICE_CODE"),empMasterData.conn)+"  SubDivision");				
		}		
		
		if(empMasterData.rs.getString("TEST_CODE")!=null)
		{
			waterTestForm.setTestName(getTestName(empMasterData.rs.getString("TEST_CODE"),empMasterData.conn));				
		}
		
		if(empMasterData.rs.getString("TEST_ID")!=null)
		{
			waterTestForm.setTestID(empMasterData.rs.getString("TEST_ID"));
		}
		
		if(empMasterData.rs.getString("HAB_CODE")!=null)
		{
			waterTestForm.setHabCode(empMasterData.rs.getString("HAB_CODE"));
		}
		
		if(empMasterData.rs.getString("SOURCE_CODE")!=null)
		{
			waterTestForm.setSourceCode(empMasterData.rs.getString("SOURCE_CODE"));
		}
				
		if(empMasterData.rs.getDate("SAMP_COLLECT_DATE")!=null)
		{
			waterTestForm.setSampcollectdate(df.format(empMasterData.rs.getDate("SAMP_COLLECT_DATE")));
		}
		
		if(empMasterData.rs.getString("SOURCE_TYPE")!=null)
		{
			waterTestForm.setSourceType(getSourceTypeName(empMasterData.rs.getString("SOURCE_TYPE")));
		}
		
		if(empMasterData.rs.getString("LAB_CODE")!=null)
		{
			waterTestForm.setLabCode(getLabName(empMasterData.rs.getString("LAB_CODE"),empMasterData.conn));
		}
		if(empMasterData.rs.getString("LOCATION")!=null)
		{
			waterTestForm.setLabLocation(empMasterData.rs.getString("LOCATION"));
		}
		/*if(empMasterData.rs.getString("UPDATE_SOURCE_DATA")!=null)
		{
			waterTestForm.setSampleUpdateDate(getYesNo(empMasterData.rs.getString("UPDATE_SOURCE_DATA")));
		}*/
			//System.out.println("end statement executed");
			sampletest.add(waterTestForm);
		}
	} 
	catch (Exception e) {
		//System.out.println("The error in getWQSampelTest" + e);
	} finally {
		empMasterData.closeAll();
	}
	return sampletest;
}

public static String getHabNames(String hcode,Connection conn) throws Exception
{
EmpMasterData empMasterData=new EmpMasterData();
empMasterData.conn=conn;
empMasterData.stmt1=null;
empMasterData.rs1=null;
String name="";
String query=null;
try{
	empMasterData.stmt1=empMasterData.conn.createStatement();
	if(hcode!=null)
	{
		query="select panch_name from RWS_PANCHAYAT_RAJ_TBL where panch_code='"+hcode+"' ";
        //System.out.println("query of HabName"+query); 
		empMasterData.rs1=empMasterData.stmt1.executeQuery(query);
		while(empMasterData.rs1.next())
		{
			name=empMasterData.rs1.getString(1);
			//System.out.println("habname"+name);
		}
	}
  } catch (Exception e) {
	//System.out.println("There is an error in getHabNames=" + e);
	} finally {
	empMasterData.stmt1.close();
	}
	return name;
}

public static ArrayList getWaterSample(String testId,DataSource dataSource) throws Exception 
{
	String str;
	EmpMasterData empMasterData=new EmpMasterData();
	WaterTestForm waterTestForm = null;//Form bean
	ArrayList testid = new ArrayList();
	int rowCount[] = null;
	
	try {
		empMasterData.conn = dataSource.getConnection();
		//System.out.println("connection established");
		empMasterData.stmt = empMasterData.conn.createStatement();
		//System.out.println("create statement executed");
		String query="";
		
		//System.out.println("test Name"+testId);
		
	query="select * from rws_water_sample_collect_tbl where test_id='"+testId+"' order by test_Id ";
    
		//empMasterData.rs =empMasterData.stmt.executeQuery(query);
		//System.out.println("query of rws_water_sample table   "+query);
		//end of code added
		empMasterData.rs =empMasterData.stmt.executeQuery(query);
		//System.out.println("select statement executed");
		while(empMasterData.rs.next()) 
		{
			waterTestForm = new WaterTestForm();
			//System.out.println("rws statement executed");
			//System.out.println("rwsOffices1");
			//waterTestForm.setHoc("CE RWS");
			
		//System.out.println("test_id in resultset"+empMasterData.rs.getString(1)+" 2 "+empMasterData.rs.getString(2));
		//waterTestForm.rs.getString(empMasterData.rs.getString())
		
		if(empMasterData.rs.getString("CIRCLE_OFFICE_CODE")!=null)
		{			
			waterTestForm.setCoc(getCircleOfficeName("1",empMasterData.rs.getString("CIRCLE_OFFICE_CODE"),empMasterData.conn)+"  Circle");				
		}		
		if(empMasterData.rs.getString("DIVISION_OFFICE_CODE")!=null)
		{			
			waterTestForm.setDoc(getDivisionOfficeName("1",empMasterData.rs.getString("CIRCLE_OFFICE_CODE"),empMasterData.rs.getString("DIVISION_OFFICE_CODE"),empMasterData.conn)+"  Division");				
		}		
		if(empMasterData.rs.getString("SUBDIVISION_OFFICE_CODE")!=null)
		{			
			waterTestForm.setSdoc(getSubDivisionOfficeName("1",empMasterData.rs.getString("CIRCLE_OFFICE_CODE"),empMasterData.rs.getString("DIVISION_OFFICE_CODE"),empMasterData.rs.getString("SUBDIVISION_OFFICE_CODE"),empMasterData.conn)+"  SubDivision");				
		}		
		if(empMasterData.rs.getString("TEST_CODE")!=null)
		{
			waterTestForm.setTestName(getTestName(empMasterData.rs.getString("TEST_CODE"),empMasterData.conn));				
		}				
		if(empMasterData.rs.getString("TEST_ID")!=null)
		{
			waterTestForm.setTestID(empMasterData.rs.getString("TEST_ID"));
		}
		if(empMasterData.rs.getString("SOURCE_CODE")!=null)
		{
			waterTestForm.setSourceCode(empMasterData.rs.getString("SOURCE_CODE"));
		}		
		if(empMasterData.rs.getString("LAB_CODE")!=null)
		{
			waterTestForm.setLabCode(empMasterData.rs.getString("LAB_CODE"));
		}
		if(empMasterData.rs.getString("SAMP_COLLECTOR_CODE")!=null)
		{
			waterTestForm.setSampCollectorCode(empMasterData.rs.getString("SAMP_COLLECTOR_CODE"));
		}		
		if(empMasterData.rs.getString("SAMP_COLLECT_TIME")!=null)
		{
			waterTestForm.setSampCollectTime(empMasterData.rs.getString("SAMP_COLLECT_TIME"));
		}
		if(empMasterData.rs.getDate("ASSIGNED_ON")!=null)
		{
			waterTestForm.setAssignOn(df.format(empMasterData.rs.getDate("ASSIGNED_ON")));
		}
		if(empMasterData.rs.getString("PREPARED_BY")!=null)
		{
			waterTestForm.setPreparedBy(empMasterData.rs.getString("PREPARED_BY"));
		}
		if(empMasterData.rs.getDate("PREPARED_ON")!=null)
		{
			waterTestForm.setPreparedOn(df.format(empMasterData.rs.getDate("PREPARED_ON")));
		}		
		if(empMasterData.rs.getString("SOURCE_TYPE")!=null)
		{
			waterTestForm.setSourceType(getSourceTypeName(empMasterData.rs.getString("SOURCE_TYPE")));
		}
		//System.out.println("1");
		try
		{
		if(empMasterData.rs.getString("HAB_CODE")!=null)
		{
			waterTestForm.setHabCode(getHabNames(empMasterData.rs.getString("HAB_CODE"),empMasterData.conn));
		}
		}catch(Exception e)
		{
			//System.out.println("error at getting habname"+e);
		}
				
		/*if(empMasterData.rs.getString("HAB_CODE")!=null)
		{
			waterTestForm.setHabCode(empMasterData.rs.getString("HAB_CODE"));
		}*/
		//System.out.println("2");
		if(empMasterData.rs.getString("NATURE_OF_TEST")!=null)
		{
			waterTestForm.setNatureOfTest(empMasterData.rs.getString("NATURE_OF_TEST"));
		}	
		//System.out.println("3");
		if(empMasterData.rs.getDate("SAMP_COLLECT_DATE")!=null)
		{
			waterTestForm.setSampcollectdate(df.format(empMasterData.rs.getDate("SAMP_COLLECT_DATE")));
		}		
		//System.out.println("end statement executed");
		testid.add(waterTestForm);
		}
	} catch (Exception e) {
		//System.out.println("The error in getWQSampelTest" + e);
	} finally {
		empMasterData.closeAll();
	}
	return testid;
}

public static ArrayList getWaterSample1(String testId,DataSource dataSource) throws Exception 
{
	String str;
	EmpMasterData empMasterData=new EmpMasterData();
	WaterTestForm waterTestForm = null;//Form bean
	ArrayList testids = new ArrayList();
	
	try {
		empMasterData.conn = dataSource.getConnection();
		//System.out.println("connection established");
		empMasterData.stmt = empMasterData.conn.createStatement();
		//System.out.println("create statement executed");
		String query="";
		
		//System.out.println("testID No "+testId);
	
		query="select testResults.test_id,samp.test_code,params.TESTING_PARAMETER_CODE,params.TESTING_PARAMETER_NAME,params.MIN_PERMISSIBLE_VALUE,params.MAX_PERMISSIBLE_VALUE,params.UNDESIRE_EFFECT,testLink.TESTING_PARAMETER_VALUE from RWS_WQ_TEST_RESULTS_TBL testResults,RWS_WQ_PARA_TEST_TBL  params,RWS_WQ_TEST_RESULTS_LNK_TBL testLink,rws_water_sample_collect_tbl samp where samp.test_id=testResults.test_id and testResults.test_id=testLink.test_id and testResults.test_code=params.test_code and testResults.test_id='"+testId+"' and params.TESTING_PARAMETER_CODE =testLink.TESTING_PARAMETER_CODE order by testResults.test_Id,params.test_code,params.TESTING_PARAMETER_CODE";
    	
    	empMasterData.rs =empMasterData.stmt.executeQuery(query);
    	//System.out.println("query of para,testResults,testLink table    "+query);
    	//System.out.println("select statement executed");
    	
		while(empMasterData.rs.next()) 
		{
			waterTestForm = new WaterTestForm();
			//System.out.println("rws statement executed");
			//System.out.println("rwsOffices1");
			//waterTestForm.setHoc("CE RWS");
			
		if(empMasterData.rs.getString("TEST_CODE")!=null)
		{
			//System.out.println("test Code No "+empMasterData.rs.getString("TEST_CODE"));
			waterTestForm.setTestName(getTestName(empMasterData.rs.getString("TEST_CODE"),empMasterData.conn));				
		}		
		if(empMasterData.rs.getString("TEST_ID")!=null)
		{
			waterTestForm.setTestID(empMasterData.rs.getString("TEST_ID"));
		}				
		if(empMasterData.rs.getString("TESTING_PARAMETER_CODE")!=null)
		{
			waterTestForm.setTestingParaCode(empMasterData.rs.getString("TESTING_PARAMETER_CODE"));
		}
		if(empMasterData.rs.getString("TESTING_PARAMETER_NAME")!=null)
		{
			waterTestForm.setTestingParaName(empMasterData.rs.getString("TESTING_PARAMETER_NAME"));
		}
		if(empMasterData.rs.getString("MIN_PERMISSIBLE_VALUE")!=null)
		{
			waterTestForm.setMinPermitValue(empMasterData.rs.getString("MIN_PERMISSIBLE_VALUE"));
		}
		if(empMasterData.rs.getString("MAX_PERMISSIBLE_VALUE")!=null)
		{
			waterTestForm.setMaxPermitValue(empMasterData.rs.getString("MAX_PERMISSIBLE_VALUE"));
		}
		if(empMasterData.rs.getString("UNDESIRE_EFFECT")!=null)
		{
			waterTestForm.setUndesireEffect(empMasterData.rs.getString("UNDESIRE_EFFECT"));
		}
			//System.out.println("end statement executed");
			testids.add(waterTestForm);
		}
	} catch (Exception e) {
		//System.out.println("The error in getWQSampelTest" + e);
	} finally {
		empMasterData.closeAll();
	}
	return testids;
}


//code added for Emp Form View part
public static String getReligionName(String code, Connection conn)
throws Exception {   
EmpMasterData empMasterData=new EmpMasterData();
//connCount--;
empMasterData.conn=conn;
String name = null;
empMasterData.stmt1 = null;
empMasterData.rs1 = null;
String query=null;
try {
//System.out.println("in getReligionName");
//System.out.println("ConnCount is "+connCount);
empMasterData.stmt1 = empMasterData.conn.createStatement();
if (code != null) {
	query="SELECT RELG_NAME FROM RWS_RELEGION_MST_TBL WHERE RELG_CODE ='"+code+"' ";
	empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
	//System.out.println("query in religion"+query);
	while(empMasterData.rs1.next())
	{
	name = empMasterData.rs1.getString(1);
	}
}
}catch (Exception e) {
//System.out.println("Ther error in getReligionName=" + e);
} finally {
empMasterData.stmt1.close();
}
return name;
}

//same code with dataSource
public static String getReligionName(String code, DataSource dataSource)
throws Exception {   
EmpMasterData empMasterData=new EmpMasterData();
//connCount--;
empMasterData.conn=dataSource.getConnection();
String name = null;
empMasterData.stmt1 = null;
empMasterData.rs1 = null;
String query=null;
try {
//System.out.println("in getReligionName");
//System.out.println("ConnCount is "+connCount);
empMasterData.stmt1 = empMasterData.conn.createStatement();
if (code != null) {
	query="SELECT RELG_NAME FROM RWS_RELEGION_MST_TBL WHERE RELG_CODE ='"+code+"' ";
	empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
	//System.out.println("query in religion"+query);
	while(empMasterData.rs1.next())
	{
	name = empMasterData.rs1.getString(1);
	}
}
}catch (Exception e) {
//System.out.println("Ther error in getReligionName=" + e);
} finally {
empMasterData.closeAll();
}
return name;
}


public static String getDesigName(String code,Connection conn)
throws Exception {   
EmpMasterData empMasterData=new EmpMasterData();
//connCount--;
conn=null;
Class.forName("oracle.jdbc.driver.OracleDriver");
conn =  DriverManager.getConnection("jdbc:oracle:thin:@10.160.0.20:1521:wsoft","preduser","preduser");
//System.out.println("New Connection is Opened  ");
empMasterData.conn=conn;
String name = null;
empMasterData.stmt1 = null;
empMasterData.rs1 = null;
String query=null;
try {
//System.out.println("in getDesigName");
//System.out.println("ConnCount is "+connCount);
empMasterData.stmt1 = empMasterData.conn.createStatement();
if (code != null) 
{
	query="SELECT DESIGNATION_NAME FROM RWS_DESIGNATION_TBL WHERE DESIGNATION_CODE ='"+code+"' ";
	empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
	//System.out.println("query in DESIGNATION "+query);
	while(empMasterData.rs1.next())
	{
	name = empMasterData.rs1.getString(1);
	}
}
}catch (Exception e) {
//System.out.println(" error in getDesigName=" + e);
} finally {
empMasterData.stmt1.close();
}
return name;
}
//same code with data source

public static String getDesigName(String code,DataSource dataSource )
throws Exception {   
EmpMasterData empMasterData=new EmpMasterData();
//connCount--;
//conn=null;
//Class.forName("oracle.jdbc.driver.OracleDriver");
//conn =  DriverManager.getConnection("jdbc:oracle:thin:@10.160.0.20:1521:wsoft","preduser","preduser");
//System.out.println("New Connection is Opened  ");
empMasterData.conn=dataSource.getConnection();
String name = null;
empMasterData.stmt1 = null;
empMasterData.rs1 = null;
String query=null;
try {
////System.out.println("in getDesigName");
////System.out.println("ConnCount is "+connCount);
empMasterData.stmt1 = empMasterData.conn.createStatement();
if (code != null) 
{
	query="SELECT DESIGNATION_NAME FROM RWS_DESIGNATION_TBL WHERE DESIGNATION_CODE ='"+code+"' ";
	empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
	//System.out.println("query in DESIGNATION "+query);
	while(empMasterData.rs1.next())
	{
	name = empMasterData.rs1.getString(1);
	}
}
}catch (Exception e) {
//System.out.println(" error in getDesigName=" + e);
} finally {
empMasterData.closeAll();
}
return name;
}

public static String getWorkName(String skillCode, DataSource dataSource)
throws Exception {   
EmpMasterData empMasterData=new EmpMasterData();
EmpMaster EmpMaster = null;
String name=null;
try {
	empMasterData.conn = dataSource.getConnection();
	empMasterData.stmt = empMasterData.conn.createStatement();

if(skillCode!=null)
{
String query="select SKILL_DESCRIPTION  from RWS_SPEC_SKILL_TBL where SKILL_CODE ='"+skillCode+"' ";
empMasterData.rs =empMasterData.stmt.executeQuery(query);
//System.out.println("query WORK SPECS Name"+query);
if (empMasterData.rs.next()) {
name=empMasterData.rs.getString(1);
}
}
}catch (Exception e) {
//System.out.println("The error in getWorkSpec" + e);
} finally {
empMasterData.closeAll();
}
return name;
}


public int Connection(DataSource dataSource)
{
	try
	{
		conn=null;
		if(conn == null)
		conn = dataSource.getConnection();
	}
	catch(Exception e)
	{	
		//System.out.println(e.getMessage());
	}
	return 1;
}

	//code Added for designation in EmpEntry
	
	public static ArrayList getDesgns(String desig,DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
	EmpMaster empMaster = null;
	ArrayList desgns = new ArrayList();
	
	try {
		
		//System.out.println("in getDesgns new Connection is opened");
		//System.out.println("ConnCount is "+connCount);
		empMasterData.conn = dataSource.getConnection();
		empMasterData.stmt = empMasterData.conn.createStatement();
		String query=null;
		if(desig.equalsIgnoreCase("P"))
		{
			//System.out.println("desig permanent P");
			query="select * from rws_designation_tbl where temp_permnent='P' order by designation_code" ;
		}
		else if(desig.equalsIgnoreCase("T"))
		{
			//System.out.println("desig Temporary T");
			query="select * from rws_designation_tbl where temp_permnent='T' order by designation_code";
		}
		else if(desig.equalsIgnoreCase("W"))
		{	
			//System.out.println("desig WorkCharged W");
			query="select * from rws_designation_tbl where temp_permnent='W' order by designation_code";
		
		}
		else 
		{
			//System.out.println("desig ALL A");
			query="select * from rws_designation_tbl order by designation_code";
		}
		empMasterData.rs =empMasterData.stmt.executeQuery(query);
		//System.out.println("getDesgns query"+query);	
			
		while (empMasterData.rs.next()) {
			empMaster = new EmpMaster();

			empMaster.setDesgnCode(empMasterData.rs.getString(1));
			empMaster.setDesgnAcr(empMasterData.rs.getString(2));
			empMaster.setDesgnName(empMasterData.rs.getString(3));

			desgns.add(empMaster);
		}
	} catch (Exception e) {
		//System.out.println("The error in getDesgns=" + e);
	} finally {
		empMasterData.closeAll();
		//System.out.println("ConnCount after closing is "+connCount);
	}
	return desgns;
}
	
//end of code added	


	public static int removeEmp(String empcode,DataSource dataSource) throws Exception {  
		EmpMasterData empMasterData=new EmpMasterData();
		int rcount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			String query="delete  from rws_employee_tbl where employee_code=?";
			preaparedStatement ps= empMasterData.conn.prepareStatement(query);
			ps.setString(1,empcode)
			rcount = ps.executeUpdate();
		} catch (Exception e) {
			//System.out.println("The error in removeEmp" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rcount;
	}

	public static String updateEmp(EmpMaster empMaster, DataSource dataSource)
			throws Exception {  
		EmpMasterData empMasterData=new EmpMasterData();
		
		int rowCount[] = null;
		boolean inserted = true;
		String var1;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt=empMasterData.conn.createStatement();
			
			String query="update rws_employee_tbl set employee_surname='"+empMaster.getSurname().toUpperCase()+"',employee_name='"+empMaster.getEmpname().toUpperCase()+"',father_name='"+empMaster.getRelation()+"',caste_code='"+empMaster.getSocial()+"',relg_code='"+empMaster.getReligion()+"',native_district='"+empMaster.getNdist()+"',"+
			"native_mandal='"+empMaster.getNmand()+"',qual_code='"+empMaster.getQual()+"',office_code='"+empMaster.getRoc()+"',sector='"+empMaster.getHoc()+"'," +
			"dist_class_IV='"+empMaster.getDiststudied4()+"',dist_class_V='"+empMaster.getDiststudied5()+"',dist_class_VI='"+empMaster.getDiststudied6()+"',dist_class_VII='"+empMaster.getDiststudied7()+"',dist_class_VIII='"+empMaster.getDiststudied8()+"',dist_class_IX='"+empMaster.getDiststudied9()+"',dist_class_X='"+empMaster.getDiststudied10()+"',"+
			"local_zone='"+empMaster.getLocalzone()+"',LOCAL_DIST_AS_PER_SCH='"+empMaster.getLocaldist()+"',NOOF_YEARS_STUDIED_IN_DIST='"+empMaster.getNoofyrs()+"',NOOF_YEARS_STUDIED_IN_ZONE='"+empMaster.getNoofyrs1()+"',PRIVATE_PASSED_DIST='"+empMaster.getPvtdist()+"',PRIVATE_PASSED_ZONE='"+empMaster.getPvtzone()+"',TEMP_PERMNENT='"+empMaster.getDesig()+"',"+
			"DESIGNATION_CODE='"+empMaster.getDesgnCode()+"',MOAP_CODE='"+empMaster.getMoap()+"',ZONE_CODE='"+empMaster.getZone()+"',RECRUIT_LOCAL_NONLOCAL='"+empMaster.getNarecruit()+"',APCATEG_CODE='"+empMaster.getApcatog()+"',"+
			"ADD_QUAL_2='"+empMaster.getAddqual2()+"',WORK_SPECIALIZATION='"+empMaster.getWorkSpecial()+"',OTHER_DETAILS='"+empMaster.getOtherDet()+"' where employee_code='"+empMaster.getEmpcode()+"'";
			//System.out.println("query is "+query);
			empMasterData.stmt.addBatch(query);				
				
			String query1="update rws_employee_spouse_tbl set SPOUSE_EMPLOYED='"+empMaster.getSpouseemployd()+"',SPOUSE_CENTRE_STATE='"+empMaster.getSpouseworking()+"',SPOUSE_DISTRICT_WORK='"+empMaster.getSpouseworkdist()+"'," + 
						 "SPOUSE_REV_DIV_WORK='"+empMaster.getSpouseworkdiv()+"',SPOUSE_REV_MANDAL_WORK='"+empMaster.getSpouseworkmand()+"' where EMPLOYEE_CODE='"+empMaster.getEmpcode()+"' ";
			
			//System.out.println("ps.setString(1,empMaster.getSpouseemployd()"+empMaster.getSpouseemployd());
			//System.out.println("ps.setString(2,empMaster.getSpouseworking())"+empMaster.getSpouseworking());
			//System.out.println("3,empMaster.getSpouseworkdist()"+empMaster.getSpouseworkdist());
			//System.out.println("ps.setString(4,empMaster.getSpouseworkdiv()"+empMaster.getSpouseworkdiv());
			//System.out.println("ps.setString(5,empMaster.getSpouseworkmand()"+empMaster.getSpouseworkmand());
			empMasterData.stmt.addBatch(query);
			
			//System.out.println("Spouse Table Updated");
			//System.out.println("end of Upadation fields");
		    rowCount = empMasterData.stmt.executeBatch();

			for (int j = 0; j < rowCount.length; j++)
			{
			        if (rowCount[j]== 0)
					inserted = false;
			}

			if (inserted){
				var1="record Updated successfully";
				empMasterData.conn.commit();
			}
			else
			{
				var1="record Cannot be Updated";
			}
			empMasterData.conn.setAutoCommit(true);
			
		} catch (Exception e) {
			//System.out.println("The error in updateEmp" + e);
			var1="record Not Updated";
		} finally {
			empMasterData.closeAll();
		}
		return var1;
	}
		

	//******************************************EmpWork
	// Methods*********************************s
	public static ArrayList getEmpCodes(String hoc, String coc, String doc,
			String sdoc, DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList empcodes = new ArrayList();

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT * FROM RWS_EMPLOYEE_TBL WHERE (SUBSTR(OFFICE_CODE, 1, 1) = "
							+ hoc
							+ ") AND (SUBSTR(OFFICE_CODE, 2, 2) = '"
							+ coc
							+ "') AND (SUBSTR(OFFICE_CODE, 4, 1) = "
							+ doc
							+ ") AND (SUBSTR(OFFICE_CODE, 5, 2) = '"
							+ sdoc + "')");

			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setEmpcode(empMasterData.rs.getString("employee_code"));
				empMaster.setEmpname(empMasterData.rs.getString("employee_name"));
				empMaster.setRoc(empMasterData.rs.getString("office_code"));
				String code = empMasterData.rs.getString("employee_code");
				String name = empMasterData.rs.getString("employee_name");
				empMaster.setDistNoName(code + " - " + name);
				empcodes.add(empMaster);

			}
		}

		catch (Exception e) {
			//System.out.println("The error in getEmpCodes=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empcodes;
	}

	//*********************************Head Office
	// Methods*****************************
	public static int insertHead(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps= empMasterData.conn.PrepareStatement("insert into rws_head_office_tbl values(?,?)");
			ps.setString(1,empMaster.getHoc());
			ps.setString(2,empMaster.getHon().toUpperCase());
			rowCount = ps.executeUpdate();
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println("The error in insertHead" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	
	public static String getHeadName(String hoc, Connection conn)
	throws Exception {   
		EmpMasterData empMasterData=new EmpMasterData();
		empMasterData.conn=conn;
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			if (hoc!= null) {
				String query="SELECT Head_office_name FROM RWS_HEAD_OFFICE_TBL where HEAD_OFFICE_CODE='"+hoc+"'";
				//System.out.println("query is "+query);
				empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
				while(empMasterData.rs1.next())
				{
				name = empMasterData.rs1.getString(1);
				//System.out.println("Head Name"+name);
				}
				}
			} 
			catch (Exception e) {
				//System.out.println("Ther error in getHeadName() =" + e);
			} finally {
				empMasterData.stmt1.close();
	
	
		}
			return name;
		}
	
	//same with dataSource
	public static String getHeadName(String hoc, DataSource dataSource)
	throws Exception {   
		EmpMasterData empMasterData=new EmpMasterData();
		empMasterData.conn=dataSource.getConnection();
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			if (hoc!= null) {
				String query="SELECT Head_office_name FROM RWS_HEAD_OFFICE_TBL where HEAD_OFFICE_CODE='"+hoc+"'";
				//System.out.println("query is "+query);
				empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
				while(empMasterData.rs1.next())
				{
				name = empMasterData.rs1.getString(1);
				//System.out.println("Head Name"+name);
				}
				}
			} 
			catch (Exception e) {
				//System.out.println("Ther error in getHeadName() =" + e);
			} finally {
				empMasterData.closeAll();
	
	
		}
			return name;
		}
	
	
	public static EmpMaster getHead(String hoc, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from rws_head_office_tbl where Head_office_code="
							+ hoc);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setHoc(empMasterData.rs.getString(1));
				empMaster.setHon(empMasterData.rs.getString(2));
			}
		} catch (Exception e) {
			//System.out.println("The error in getHead" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static int removeHead(String hoc, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
		PreparedStatement ps= empMasterData.conn.prepareStatement("delete  from rws_head_office_tbl where Head_office_code=?")
		ps.setString(1, hoc);	
		rowCount=ps.executeUpdate();
		} catch (Exception e) {
			//System.out.println("The error in removeHead=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static int updateHead(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int ans = 0;
		try {
			empMasterData.conn = dataSource.getConnection();

			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps= empMasterData.conn .prepareStatement("update rws_head_office_tbl set head_office_name=? where head_office_code=?");
			ps.setString(1,empMaster.getHon().toUpperCase());
			ps.setString(2, empMaster.getHoc());
			ans = ps.executeUpdate();
					
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			//System.out.println("The error in updateHead " + sqle);
		} catch (Exception e) {
			//System.out.println("The error in updateHead " + e);
		} finally {
			empMasterData.closeAll();
		}
		return ans;
	}

	public static String getHeadCode(DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String code = "";
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT MAX(to_number(HEAD_OFFICE_CODE))+1 FROM RWS_HEAD_OFFICE_TBL");
			empMasterData.rs.next();
			code = empMasterData.rs.getString(1);
			if (code == null)
				code = "1";
		} catch (Exception e) {
			//System.out.println("The error in getHeadCode" + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	//********************************Circle Office
	// Methods***********************************
	public static int insertCircle(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			ps=empMasterData.conn.prepareStatement("insert into rws_circle_office_tbl values(?,?,?)");
			ps.setString(1, empMaster.getHoc());
			ps.setString(2, empMaster.getCoc());
			ps.setString(3, empMaster.getCon().toUpperCase());
			rowCount = ps.executeUpdate();
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println("The error in insertCircle" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getCircle(String hoc, String coc,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from rws_circle_office_tbl where circle_office_code='"
							+ coc + "' and head_office_code=" + hoc);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setHoc(empMasterData.rs.getString(1));
				empMaster.setHon(getHeadOfficeName(empMasterData.rs.getString(1), empMasterData.conn));
				empMaster.setCoc(empMasterData.rs.getString(2));
				empMaster.setCon(empMasterData.rs.getString(3));
			}
		} catch (Exception e) {
			//System.out.println("The error in getCircle" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	
	public static int removeCircle(String hoc, String coc, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps=empMasterData.conn.PrepareStatement("delete  from rws_circle_office_tbl where circle_office_code=? and head_office_code=?"); 
			ps.setString(1,coc);
			ps.setString(2, hoc);
			rowCount = ps.executeUpdate();
					
		} catch (Exception e) {
			//System.out.println("The error in removeCircle" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static int updateCircle(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int ans = 0;
		try {
			empMasterData.conn = dataSource.getConnection();

			ps = empMasterData.conn
					.prepareStatement("UPDATE  RWS_CIRCLE_OFFICE_TBL SET CIRCLE_OFFICE_NAME=? WHERE CIRCLE_OFFICE_CODE=? AND HEAD_OFFICE_CODE=?");
			ps.setString(1, empMaster.getCon().toUpperCase());
			ps.setString(2, empMaster.getCoc());
			ps.setString(3, empMaster.getHoc());

			ans = ps.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			//System.out.println("The error in updateCircle " + sqle);
		} catch (Exception e) {
			//System.out.println("The error in updateCircle " + e);
		} finally {
			empMasterData.closeAll();
		}
		return ans;
	}

	public static String getCircleCode(DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String code = "";
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT MAX(to_number(CIRCLE_OFFICE_CODE))+1 FROM RWS_CIRCLE_OFFICE_TBL");
			empMasterData.rs.next();
			code = empMasterData.rs.getString(1);
			if (code == null)
				code = "01";
		} catch (Exception e) {
			//System.out.println("The error in getCircleCode" + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	//****************************************Division Office
	// Methods*********************************
	public static int insertDivision(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps=empMasterData.conn.prepareStatement("insert into rws_division_office_tbl values(?,?,?,?)")
			ps.setString(1, empMaster.getHoc());
			ps.setString(2, empMaster.getCoc());
			ps.setString(3,  empMaster.getDoc());
			ps.setString(4,  empMaster.getDon().toUpperCase());
			rowCount = ps.executeUpdate();
					
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println("The error in insertDivision" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getDivision(String hoc, String coc, String doc,
			DataSource dataSource) throws Exception { 
		EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from rws_division_office_tbl where division_office_code="
							+ doc
							+ "and circle_office_code='"
							+ coc
							+ "' and head_office_code=" + hoc);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setHoc(empMasterData.rs.getString(1));
				empMaster.setHon(getHeadOfficeName(empMasterData.rs.getString(1), empMasterData.conn));
				empMaster.setCoc(empMasterData.rs.getString(2));
				empMaster.setCon(getCircleOfficeName(empMasterData.rs.getString(1), empMasterData.rs
						.getString(2), empMasterData.conn));
				empMaster.setDoc(empMasterData.rs.getString(3));
				empMaster.setDon(empMasterData.rs.getString(4));
			}
		} catch (Exception e) {
			//System.out.println("The error in getDivision" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getDivisions(DataSource dataSource, String coc)
			throws Exception {   
		EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList divisions = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			//Statement stmt1 = empMasterData.conn.createStatement();
			//Statement stmt2 = empMasterData.conn.createStatement();
			//System.out.println("in the getDivision()");
			if (coc.equals("00"))
				empMasterData.rs =empMasterData.stmt
						.executeQuery("SELECT D.HEAD_OFFICE_CODE,H.HEAD_OFFICE_NAME,D.CIRCLE_OFFICE_CODE,C.CIRCLE_OFFICE_NAME,D.DIVISION_OFFICE_CODE,D.DIVISION_OFFICE_NAME FROM RWS_DIVISION_OFFICE_TBL D,RWS_CIRCLE_OFFICE_TBL C,RWS_HEAD_OFFICE_TBL H WHERE D.HEAD_OFFICE_CODE=H.HEAD_OFFICE_CODE AND D.CIRCLE_OFFICE_CODE=C.CIRCLE_OFFICE_CODE ORDER BY HEAD_OFFICE_CODE,CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE");
			else
				//System.out.println("in the else block of getDivision()");
				empMasterData.rs =empMasterData.stmt
						.executeQuery("SELECT D.HEAD_OFFICE_CODE,H.HEAD_OFFICE_NAME,D.CIRCLE_OFFICE_CODE,C.CIRCLE_OFFICE_NAME,D.DIVISION_OFFICE_CODE,D.DIVISION_OFFICE_NAME FROM RWS_DIVISION_OFFICE_TBL D,RWS_CIRCLE_OFFICE_TBL C,RWS_HEAD_OFFICE_TBL H WHERE D.HEAD_OFFICE_CODE=H.HEAD_OFFICE_CODE AND D.CIRCLE_OFFICE_CODE='"
								+ coc
								+ "' and D.CIRCLE_OFFICE_CODE=C.CIRCLE_OFFICE_CODE ORDER BY HEAD_OFFICE_CODE,CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setHoc(empMasterData.rs.getString(1));
				empMaster.setHon(empMasterData.rs.getString(2));
				empMaster.setCoc(empMasterData.rs.getString(3));
				empMaster.setCon(empMasterData.rs.getString(4));
				empMaster.setDoc(empMasterData.rs.getString(5));
				empMaster.setDon(empMasterData.rs.getString(6));
				divisions.add(empMaster);
				//System.out.println("end statement of getDivision()");
			}
		} catch (Exception e) {
			//System.out.println("The error in getDivisions" + e);
		} finally {
			empMasterData.closeAll();
		}
		return divisions;
	}

	public static int removeDivision(String hoc, String coc, String doc,
			DataSource dataSource) throws Exception {  
		EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps=empMasterData.conn.prepareStatement("delete  from rws_division_office_tbl where division_office_code=? and circle_office_code=? and head_office_code=?");
			ps.setString(1, doc);
			ps.setString(2, coc);
			ps.setString(3, hoc);
			rowCount = ps.executeUpdate();
		} catch (Exception e) {
			//System.out.println("The error in removeDivision" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static int updateDivision(EmpMaster empMaster, DataSource dataSource)
			throws Exception { 
		EmpMasterData empMasterData=new EmpMasterData();
		int ans = 0;
		try {
			empMasterData.conn = dataSource.getConnection();

			ps = empMasterData.conn
					.prepareStatement("update  rws_division_office_tbl set division_office_name=? where division_office_code=? and circle_office_code=? and head_office_code=?");

			ps.setString(1, (empMaster.getDon()).toUpperCase());
			ps.setString(2, empMaster.getDoc());
			ps.setString(3, empMaster.getCoc());
			ps.setString(4, empMaster.getHoc());

			ans = ps.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			//System.out.println("The error in updateDivision " + sqle);
		} catch (Exception e) {
			//System.out.println("The error in updateDivision" + e);
		} finally {
			empMasterData.closeAll();
		}
		return ans;
	}

	public static String getDivisionCode(String hoc, String coc,
			DataSource dataSource) throws Exception { 
		EmpMasterData empMasterData=new EmpMasterData();
		String code = "";
		if (coc != null) {
			try {
				empMasterData.conn = dataSource.getConnection();
				empMasterData.stmt = empMasterData.conn.createStatement();
				empMasterData.rs =empMasterData.stmt
						.executeQuery("SELECT MAX(to_number(DIVISION_OFFICE_CODE))+1 FROM RWS_DIVISION_OFFICE_TBL WHERE CIRCLE_OFFICE_CODE='"
								+ coc + "' and HEAD_OFFICE_CODE=" + hoc);
				empMasterData.rs.next();
				code = empMasterData.rs.getString(1);
				if (code == null)
					code = "1";
			} catch (Exception e) {
				//System.out.println("The error in getDivisionCode" + e);
			} finally {
				empMasterData.closeAll();
			}
		}
		return code;
	}

	//*********************************SubDivision
	// OfficeMethods*************************************
	public static int insertSubDivision(EmpMaster empMaster,
			DataSource dataSource) throws Exception {  
		EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps=empMasterData.conn.PrepredStatement("insert into rws_subdivision_office_tbl values(?,?,?,?,?)");
			ps.setString(1, empMaster.getHoc());
			ps.setString(2, empMaster.getCoc());
			ps.setString(3, empMaster.getDoc());
			ps.setString(4, empMaster.getSdoc());
			PS.SetString(5,empMaster.getSdon().toUpperCase())
			rowCount = ps.executeUpdate();
			
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println("The error in insertSubDivision" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getSubDivision(String hoc, String coc, String doc,
			String sdoc, DataSource dataSource) throws Exception {  
		EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from rws_subdivision_office_tbl where subdivision_office_code='"
							+ sdoc
							+ "' and division_office_code="
							+ doc
							+ " and circle_office_code='"
							+ coc
							+ "' and head_office_code=" + hoc);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setHoc(empMasterData.rs.getString(1));
				empMaster.setHon(getHeadOfficeName(empMasterData.rs.getString(1), empMasterData.conn));
				empMaster.setCoc(empMasterData.rs.getString(2));
				empMaster.setCon(getCircleOfficeName(empMasterData.rs.getString(1), empMasterData.rs
						.getString(2), empMasterData.conn));
				empMaster.setDoc(empMasterData.rs.getString(3));
				empMaster.setDon(getDivisionOfficeName(empMasterData.rs.getString(1), empMasterData.rs
						.getString(2), empMasterData.rs.getString(3), empMasterData.conn));
				empMaster.setSdoc(empMasterData.rs.getString(4));
				empMaster.setSdon(empMasterData.rs.getString(5));
			}
		} catch (Exception e) {
			//System.out.println("The error in getSubDivision" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getSubDivisions(DataSource dataSource, String coc,
			String doc) throws Exception { 
		EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList subdivisions = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			if (coc.equals("00") && doc.equals("0"))
				empMasterData.rs =empMasterData.stmt
						.executeQuery("SELECT S.HEAD_OFFICE_CODE,H.HEAD_OFFICE_NAME,S.CIRCLE_OFFICE_CODE,C.CIRCLE_OFFICE_NAME,S.DIVISION_OFFICE_CODE,D.DIVISION_OFFICE_NAME,S.SUBDIVISION_OFFICE_CODE,S.SUBDIVISION_OFFICE_NAME FROM RWS_SUBDIVISION_OFFICE_TBL S,RWS_DIVISION_OFFICE_TBL D,RWS_CIRCLE_OFFICE_TBL C,RWS_HEAD_OFFICE_TBL H WHERE  S.HEAD_OFFICE_CODE=H.HEAD_OFFICE_CODE AND D.CIRCLE_OFFICE_CODE=C.CIRCLE_OFFICE_CODE AND S.CIRCLE_OFFICE_CODE=C.CIRCLE_OFFICE_CODE AND S.DIVISION_OFFICE_CODE=D.DIVISION_OFFICE_CODE ORDER BY HEAD_OFFICE_CODE,CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE ");
			else if (!coc.equals("00") && doc.equals("0"))
				empMasterData.rs =empMasterData.stmt
						.executeQuery("SELECT S.HEAD_OFFICE_CODE,H.HEAD_OFFICE_NAME,S.CIRCLE_OFFICE_CODE,C.CIRCLE_OFFICE_NAME,S.DIVISION_OFFICE_CODE,D.DIVISION_OFFICE_NAME,S.SUBDIVISION_OFFICE_CODE,S.SUBDIVISION_OFFICE_NAME FROM RWS_SUBDIVISION_OFFICE_TBL S,RWS_DIVISION_OFFICE_TBL D,RWS_CIRCLE_OFFICE_TBL C,RWS_HEAD_OFFICE_TBL H WHERE S.CIRCLE_OFFICE_CODE='"
								+ coc
								+ "' and S.HEAD_OFFICE_CODE=H.HEAD_OFFICE_CODE AND D.CIRCLE_OFFICE_CODE='"
								+ coc
								+ "' and D.CIRCLE_OFFICE_CODE=C.CIRCLE_OFFICE_CODE AND S.CIRCLE_OFFICE_CODE=C.CIRCLE_OFFICE_CODE AND S.DIVISION_OFFICE_CODE=D.DIVISION_OFFICE_CODE ORDER BY HEAD_OFFICE_CODE,CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE ");
			else if (!coc.equals("00") && !doc.equals("0"))
				empMasterData.rs =empMasterData.stmt
						.executeQuery("SELECT S.HEAD_OFFICE_CODE,H.HEAD_OFFICE_NAME,S.CIRCLE_OFFICE_CODE,C.CIRCLE_OFFICE_NAME,S.DIVISION_OFFICE_CODE,D.DIVISION_OFFICE_NAME,S.SUBDIVISION_OFFICE_CODE,S.SUBDIVISION_OFFICE_NAME FROM RWS_SUBDIVISION_OFFICE_TBL S,RWS_DIVISION_OFFICE_TBL D,RWS_CIRCLE_OFFICE_TBL C,RWS_HEAD_OFFICE_TBL H WHERE S.CIRCLE_OFFICE_CODE='"
								+ coc
								+ "' and S.DIVISION_OFFICE_CODE='"
								+ doc
								+ "' and S.HEAD_OFFICE_CODE=H.HEAD_OFFICE_CODE AND D.CIRCLE_OFFICE_CODE=C.CIRCLE_OFFICE_CODE AND S.CIRCLE_OFFICE_CODE=C.CIRCLE_OFFICE_CODE AND S.DIVISION_OFFICE_CODE=D.DIVISION_OFFICE_CODE ORDER BY HEAD_OFFICE_CODE,CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE ");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setHoc(empMasterData.rs.getString(1));
				empMaster.setHon(empMasterData.rs.getString(2));
				empMaster.setCoc(empMasterData.rs.getString(3));
				empMaster.setCon(empMasterData.rs.getString(4));
				empMaster.setDoc(empMasterData.rs.getString(5));
				empMaster.setDon(empMasterData.rs.getString(6));
				empMaster.setSdoc(empMasterData.rs.getString(7));
				empMaster.setSdon(empMasterData.rs.getString(8));
				empMaster.setNoOfMandals(getNoOfMandals(empMasterData.rs.getString(3), empMasterData.rs
						.getString(5), empMasterData.rs.getString(7), empMasterData.conn));
				subdivisions.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getSubDivisions" + e);
		} finally {
			empMasterData.closeAll();
		}
		return subdivisions;
	}

	public static String getNoOfMandals(String coc, String doc, String sdoc,
			Connection conn) {
		
		String mcount = "0";
		EmpMasterData empMasterData=new EmpMasterData();
		empMasterData.conn=conn;
		try {

			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT count(MCODE) from RWS_MANDAL_SUBDIVISION_TBL  WHERE CIRCLE_OFFICE_CODE='"
							+ coc
							+ "' and DIVISION_OFFICE_CODE='"
							+ doc
							+ "' and SUBDIVISION_OFFICE_CODE='" + sdoc + "'");
			empMasterData.rs1.next();
			mcount = "" + empMasterData.rs1.getInt(1);
		} catch (Exception e) {
			//System.out.println("The error in getNoOfMandals" + e);
		}
		finally {
			try{
			   empMasterData.stmt1.close();
			   }
			catch(Exception e)
			{
				//System.out.println("Exception"+e);
			}
		}
		return mcount;
	}

	public static ArrayList getMandalSubDivisions(DataSource dataSource,
			String coc, String doc, String sdoc) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList mandalsubdivisions = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();

			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT M.MCODE,M.MNAME FROM RWS_SUBDIVISION_OFFICE_TBL SDO,RWS_MANDAL_TBL M,RWS_MANDAL_SUBDIVISION_TBL MS WHERE MS.CIRCLE_OFFICE_CODE='"
							+ coc
							+ "'AND MS.DIVISION_OFFICE_CODE='"
							+ doc
							+ "' AND SDO.SUBDIVISION_OFFICE_CODE='"
							+ sdoc
							+ "'"
							+ " AND MS.SUBDIVISION_OFFICE_CODE='"
							+ sdoc
							+ "' AND SDO.CIRCLE_OFFICE_CODE='"
							+ coc
							+ "' AND SDO.DIVISION_OFFICE_CODE='"
							+ doc
							+ "' and M.DCODE=MS.DCODE and M.MCODE=MS.MCODE");

			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setMandalCode(empMasterData.rs.getString(1));
				empMaster.setMandalName(empMasterData.rs.getString(2));
				mandalsubdivisions.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getMandalSubDivisions" + e);
		} finally {
			empMasterData.closeAll();
		}
		return mandalsubdivisions;
	}

	public static int removeSubDivision(String hoc, String coc, String doc,
			String sdoc, DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement pst=empMasterData.conn.PreparedStatement("delete  from rws_subdivision_office_tbl where subdivision_office_code=? and division_office_code=? and circle_office_code=? and head_office_code=?");
			ps.setString(1, sdoc);
			ps.setString(2, doc);
			ps.setString(3, coc);
			ps.setString(4, hoc);
			rowCount = ps.executeUpdate();
		} catch (Exception e) {
			//System.out.println("The error in removeSubDivision" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static int updateSubDivision(EmpMaster empMaster,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int ans = 0;
		try {
			empMasterData.conn = dataSource.getConnection();

			ps = empMasterData.conn
					.prepareStatement("UPDATE  RWS_SUBDIVISION_OFFICE_TBL SET SUBDIVISION_OFFICE_NAME=? WHERE SUBDIVISION_OFFICE_CODE=? AND DIVISION_OFFICE_CODE=? AND CIRCLE_OFFICE_CODE=? AND HEAD_OFFICE_CODE=?");

			ps.setString(1, (empMaster.getSdon()).toUpperCase());
			ps.setString(2, empMaster.getSdoc());
			ps.setString(3, empMaster.getDoc());
			ps.setString(4, empMaster.getCoc());
			ps.setString(5, empMaster.getHoc());

			ans = ps.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			//System.out.println("The error in updateDivision " + sqle);
		} catch (Exception e) {
			//System.out.println("The error in updateSubDivision" + e);
		} finally {
			empMasterData.closeAll();
		}

		return ans;
	}

	public static String getSubDivisionCode(String hoc, String coc, String doc,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String code = "";
		if (coc != null) {
			try {
				//System.out.println("hoc= " + hoc + "coc= " + coc + "  doc= "
						+ doc);
				empMasterData.conn = dataSource.getConnection();
				empMasterData.stmt = empMasterData.conn.createStatement();
				empMasterData.rs =empMasterData.stmt
						.executeQuery("SELECT MAX(to_number(SUBDIVISION_OFFICE_CODE))+1 FROM RWS_SUBDIVISION_OFFICE_TBL WHERE DIVISION_OFFICE_CODE="
								+ doc
								+ " and CIRCLE_OFFICE_CODE='"
								+ coc
								+ "' and HEAD_OFFICE_CODE=" + hoc);
				empMasterData.rs.next();
				code = empMasterData.rs.getString(1);
				if (code == null) {
					code = "01";
				} else if (code.length() == 1) {
					code = "0" + code;
				}
			} catch (Exception e) {
				//System.out.println("The error in getSubDivisionCode" + e);
			} finally {
				empMasterData.closeAll();
			}
		}
		//System.out.println("code= " + code);
		return code;
	}

	//*********************************Section Office
	// Methods*************************************
	public static int insertSection(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			ps = empMasterData.conn
					.prepareStatement("insert into RWS_SECTION_OFFICE_TBL values(?,?,?,?,?,?)");
			ps.setString(1, empMaster.getHoc());
			ps.setString(2, empMaster.getCoc());
			ps.setString(3, empMaster.getDoc());
			ps.setString(4, empMaster.getSdoc());
			ps.setString(5, empMaster.getSoc());
			ps.setString(6, empMaster.getSon().toUpperCase());

			rowCount = ps.executeUpdate();

		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println("The error in insertSection=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getSection(String hoc, String coc, String doc,
			String sdoc, String soc, DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from RWS_SECTION_OFFICE_TBL where SECTION_OFFICE_CODE='"
							+ soc
							+ "' and subdivision_office_code='"
							+ sdoc
							+ "' and division_office_code="
							+ doc
							+ " and circle_office_code='"
							+ coc
							+ "' and head_office_code='" + hoc + "'");
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setHoc(empMasterData.rs.getString("head_office_code"));
				empMaster.setCoc(empMasterData.rs.getString("circle_office_code"));
				empMaster.setDoc(empMasterData.rs.getString("division_office_code"));
				empMaster.setSdoc(empMasterData.rs.getString("subdivision_office_code"));
				empMaster.setSoc(empMasterData.rs.getString("section_office_code"));
				empMaster.setSon(empMasterData.rs.getString("section_office_name"));
			}
		} catch (Exception e) {
			//System.out.println("The error in getSection=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getSections(DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList subdivisions = new ArrayList();

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.stmt2 = empMasterData.conn.createStatement();
			empMasterData.stmt3 = empMasterData.conn.createStatement();
			Statement stmt4 = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT DISTINCT ST.HEAD_OFFICE_CODE,H.HEAD_OFFICE_NAME,ST.CIRCLE_OFFICE_CODE,C.CIRCLE_OFFICE_NAME,ST.DIVISION_OFFICE_CODE,D.DIVISION_OFFICE_NAME,ST.SUBDIVISION_OFFICE_CODE,S.SUBDIVISION_OFFICE_NAME,ST.SECTION_OFFICE_CODE,ST.SECTION_OFFICE_NAME FROM RWS_SECTION_OFFICE_TBL ST,RWS_SUBDIVISION_OFFICE_TBL S,RWS_DIVISION_OFFICE_TBL D,RWS_CIRCLE_OFFICE_TBL C,RWS_HEAD_OFFICE_TBL H WHERE ST.HEAD_OFFICE_CODE=H.HEAD_OFFICE_CODE AND ST.CIRCLE_OFFICE_CODE=C.CIRCLE_OFFICE_CODE AND S.CIRCLE_OFFICE_CODE=C.CIRCLE_OFFICE_CODE AND D.CIRCLE_OFFICE_CODE=C.CIRCLE_OFFICE_CODE AND ST.DIVISION_OFFICE_CODE=D.DIVISION_OFFICE_CODE AND S.DIVISION_OFFICE_CODE=D.DIVISION_OFFICE_CODE AND ST.SUBDIVISION_OFFICE_CODE=S.SUBDIVISION_OFFICE_CODE ORDER BY HEAD_OFFICE_CODE,CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE,SECTION_OFFICE_CODE");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setHoc(empMasterData.rs.getString(1));
				empMaster.setHon(empMasterData.rs.getString(2));
				empMaster.setCoc(empMasterData.rs.getString(3));
				empMaster.setCon(empMasterData.rs.getString(4));
				empMaster.setDoc(empMasterData.rs.getString(5));
				empMaster.setDon(empMasterData.rs.getString(6));
				empMaster.setSdoc(empMasterData.rs.getString(7));
				empMaster.setSdon(empMasterData.rs.getString(8));
				empMaster.setSoc(empMasterData.rs.getString(9));
				empMaster.setSon(empMasterData.rs.getString(10));

				subdivisions.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getSections" + e);
		} finally {
			empMasterData.closeAll();
		}
		return subdivisions;
	}

	public static int removeSection(String hoc, String coc, String doc,
			String sdoc, String soc, DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps=empMasterData.conn.prepareStatement("delete  from RWS_SECTION_OFFICE_TBL where section_office_code=? and subdivision_office_code=?"
					+ " and division_office_code=? and circle_office_code=? and head_office_code=?");
			ps.setString(1, soc);
			ps.setString(2,sdoc);
			ps.setString(3,doc);
			ps.setString(4,coc);
			ps.setString(5,hoc);
			rowCount = ps.executeUpdate();
		}

		catch (Exception e) {
			//System.out.println("The error in removeSection" + e);
		} finally {

			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static void updateSection(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		try {
			empMasterData.conn = dataSource.getConnection();

			ps = empMasterData.conn
					.prepareStatement("UPDATE  RWS_SECTION_OFFICE_TBL SET SECTION_OFFICE_NAME=? WHERE SECTION_OFFICE_CODE=? AND SUBDIVISION_OFFICE_CODE=? AND DIVISION_OFFICE_CODE=? AND CIRCLE_OFFICE_CODE=? AND HEAD_OFFICE_CODE=?");

			ps.setString(1, (empMaster.getSon()).toUpperCase());
			ps.setString(2, empMaster.getSoc());
			ps.setString(3, empMaster.getSdoc());
			ps.setString(4, empMaster.getDoc());
			ps.setString(5, empMaster.getCoc());
			ps.setString(6, empMaster.getHoc());

			ps.executeUpdate();
		} catch (Exception e) {
			//System.out.println("The error in updateSection=" + e);
		} finally {
			empMasterData.closeAll();
		}
	}

	public static String getSectionCode(String hoc, String coc, String doc,
			String sdoc, DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String code = "";
		if (sdoc != null) {
			try {
				empMasterData.conn = dataSource.getConnection();
				empMasterData.stmt = empMasterData.conn.createStatement();
				empMasterData.rs =empMasterData.stmt
						.executeQuery("SELECT MAX(to_number(SECTION_OFFICE_CODE))+1 FROM RWS_SECTION_OFFICE_TBL WHERE SUBDIVISION_OFFICE_CODE="
								+ sdoc
								+ "AND DIVISION_OFFICE_CODE="
								+ doc
								+ " and CIRCLE_OFFICE_CODE='"
								+ coc
								+ "' and HEAD_OFFICE_CODE=" + hoc);
				empMasterData.rs.next();
				code = empMasterData.rs.getString(1);
				if (code == null)
					code = "1";
			} catch (Exception e) {
				//System.out.println("The error in getSectionCode" + e);
			} finally {
				empMasterData.closeAll();
			}
		}
		return code;
	}

	//**************************************RWS Office
	// Methods****************************
	public static int insertOffice(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			ps = empMasterData.conn
					.prepareStatement("insert into RWS_OFFICE_TBL values(?,?,?,?,?,?,?,?,?,?,?,?)");
			ps.setString(1, empMaster.getRoc());
			ps.setString(2, empMaster.getAddress().toUpperCase());
			ps.setString(3, empMaster.getLocation().toUpperCase());
			ps.setString(4, empMaster.getArea().toUpperCase());
			ps.setString(5, empMaster.getCity().toUpperCase());
			ps.setString(6, empMaster.getPin());
			ps.setString(7, empMaster.getPhone());
			ps.setString(8, empMaster.getFax());
			ps.setString(9, empMaster.getEmail());
			ps.setString(10, empMaster.getBuilding());
			ps.setString(11, empMaster.getHof());
			ps.setString(12, empMaster.getProject());

			rowCount = ps.executeUpdate();
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Details for the selected office exists.";
		} catch (Exception e) {
			//System.out.println("The error in insertOffice" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getOffice(String roc, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from RWS_OFFICE_TBL where office_code='"
							+ roc + "'");
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				String oc = empMasterData.rs.getString("office_code");
				empMaster.setHoc(getHeadOfficeName(oc.substring(0, 1), empMasterData.conn));
				if (!oc.substring(1, 3).equals("00"))
					empMaster.setCoc(getCircleOfficeName(oc.substring(0, 1), oc
							.substring(1, 3), empMasterData.conn));
				if (!oc.substring(3, 4).equals("0"))
					empMaster.setDoc(getDivisionOfficeName(oc.substring(0, 1),
							oc.substring(1, 3), oc.substring(3, 4), empMasterData.conn));
				if (!oc.substring(4, 6).equals("00"))
					empMaster.setSdoc(getSubDivisionOfficeName(oc.substring(0,
							1), oc.substring(1, 3), oc.substring(3, 4), oc
							.substring(4, 6), empMasterData.conn));

				empMaster.setHoc(getHeadOfficeName(oc.substring(0, 1), empMasterData.conn));
				empMaster.setRoc(empMasterData.rs.getString("office_code"));
				empMaster.setAddress(empMasterData.rs.getString("address1"));
				empMaster.setArea(empMasterData.rs.getString("address2"));
				empMaster.setLocation(empMasterData.rs.getString("address3"));
				empMaster.setCity(empMasterData.rs.getString("city"));
				empMaster.setPin(empMasterData.rs.getString("pincode"));
				empMaster.setPhone(empMasterData.rs.getString("phone"));
				empMaster.setFax(empMasterData.rs.getString("fax"));
				empMaster.setEmail(empMasterData.rs.getString("email"));
				empMaster.setBuilding(empMasterData.rs.getString("building"));
				empMaster.setHof(empMasterData.rs.getString("head_of_office"));
				empMaster.setProject(empMasterData.rs.getString("project"));
			}
		} catch (Exception e) {
			//System.out.println("The error in getOffice=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getOffices(DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList offices = new ArrayList();

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt.executeQuery("select * from RWS_OFFICE_TBL");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setRoc(empMasterData.rs.getString("office_code"));
				empMaster.setAddress(empMasterData.rs.getString("address1"));
				empMaster.setArea(empMasterData.rs.getString("address2"));
				empMaster.setLocation(empMasterData.rs.getString("address3"));
				empMaster.setCity(empMasterData.rs.getString("city"));
				empMaster.setPin(empMasterData.rs.getString("pincode"));
				empMaster.setPhone(empMasterData.rs.getString("phone"));
				empMaster.setFax(empMasterData.rs.getString("fax"));
				empMaster.setEmail(empMasterData.rs.getString("email"));
				if (empMasterData.rs.getString("building").equalsIgnoreCase("O"))
					empMaster.setBuilding("OWN");
				else if (empMasterData.rs.getString("building").equalsIgnoreCase("R"))
					empMaster.setBuilding("RENTED");
				empMaster.setHof(getDesgnName(empMasterData.rs.getString("head_of_office"),
						empMasterData.conn));
				if (empMasterData.rs.getString("project").equalsIgnoreCase("P"))
					empMaster.setProject("PROJECT");
				else if (empMasterData.rs.getString("project").equalsIgnoreCase("R"))
					empMaster.setProject("REGULAR");

				offices.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getOffices=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return offices;
	}

	public static void removeOffice(String roc, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps=empMasterData.conn.prepareStatement("delete  from RWS_OFFICE_TBL where office_code=?");
			ps.setString(1, roc);
			ps.executeUpdate();
				
		} catch (Exception e) {
			//System.out.println("The error in removeOffice=" + e);
		} finally {

			empMasterData.closeAll();
		}
	}

	public static void updateOffice(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		try {
			empMasterData.conn = dataSource.getConnection();

			ps = empMasterData.conn
					.prepareStatement("update  RWS_OFFICE_TBL set address1=?,address2=?,address3=?,city=?,pincode=?,phone=?,fax=?,email=?,building=?,head_of_office=?,project=? where office_code=?");
			ps.setString(1, empMaster.getAddress().toUpperCase());
			ps.setString(2, empMaster.getArea().toUpperCase());
			ps.setString(3, empMaster.getLocation().toUpperCase());
			ps.setString(4, empMaster.getCity().toUpperCase());
			ps.setString(5, empMaster.getPin());
			ps.setString(6, empMaster.getPhone());
			ps.setString(7, empMaster.getFax());
			ps.setString(8, empMaster.getEmail());
			ps.setString(9, empMaster.getBuilding());
			ps.setString(10, empMaster.getHof());
			ps.setString(11, empMaster.getProject());
			ps.setString(12, empMaster.getRoc());

			ps.executeUpdate();
		} catch (Exception e) {
			//System.out.println("The error in updateOffice=" + e);
		} finally {
			empMasterData.closeAll();
		}
	}

	//*************************************Source
	// Methods**************************************
	public static boolean insertSource(EmpMaster empMaster,
			ArrayList checkedAssets, ArrayList checkedHabs,
			DataSource dataSource) throws Exception { 
		EmpMasterData empMasterData=new EmpMasterData();
		AssetSourceBean assetSourceBean = new AssetSourceBean();
		HabSourceBean habSourceBean = new HabSourceBean();
		int rowCount[] = null;
		boolean flag = false;
		String query = null;
		//System.out.println("in insertSource in EmpMasterData");
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.conn.setAutoCommit(false);
			empMasterData.stmt = empMasterData.conn.createStatement();
			if(empMaster.getSourceDepth()==null || ((String)empMaster.getSourceDepth()).equals(""))
			{
				empMaster.setSourceDepth("");
			}
			if(empMaster.getSourceDiameter()==null || ((String)empMaster.getSourceDiameter()).equals(""))
			{
				empMaster.setSourceDiameter("");
			}
			if(empMaster.getWaterQuality().equalsIgnoreCase("SS"))
			{
				empMaster.setFlouride(0);
				empMaster.setBrakish(0); 
				empMaster.setIron(0);
				empMaster.setOthers("");
				empMaster.setOthersType("");
			}
			int noOfHabs=getSourceHabitationsCount(empMasterData.conn,empMaster.getSourceCode());
			query= "insert into RWS_SOURCE_TBL(SOURCE_CODE,SOURCE_NAME,SOURCE_TYPE_CODE," 
				 + "SUBSOURCE_TYPE_CODE,HAB_CODE,NO_OF_HABITAITONS_COVERD," 
				 + "POPULATION_BENIFITED,SEASONAL,SOURCE_CONDITION,WATER_QUALITY," 
				 + "STATIC_WATER_LEVEL,SUMMER_WATER_LEVEL,YIELD,DIST_NEAR_PRIVATE_SOURCE,LOCATION," 
				 + "DEPTH,DIAMETER," 
				 //+ "TYPE," 
				 + "ASSET_CODE) values" + "('"
			+ empMaster.getSourceCode() + "','" 
			+ empMaster.getSourceName().toUpperCase() + "'," 
			+ "nvl('"+empMaster.getSourceTypeCode()+"',0),"
			+ "nvl('"+empMaster.getSubSourceTypeCode() +"',0),'"
			+ empMaster.getHabCode() + "'," 
			+ "nvl('"+empMaster.getNoOfHab() +"',0),"
			+ "nvl('"+empMaster.getPopbenefited() +"',0),'"
			+ empMaster.getSeasonal() + "','" 
			+ empMaster.getPresentCondition() + "','" 
			+ empMaster.getWaterQuality() + "'," 
			+ "nvl('"+empMaster.getStaticWaterLevel() +"',0),"
			+ "nvl('"+empMaster.getSummerWaterLevel()  +"',0),'"
			+ empMaster.getYield() + "'," 
			+ "nvl('"+empMaster.getDistFromSource() +"',0),'"
			+ empMaster.getLocation() + "',"
			+ "nvl('"+empMaster.getSourceDepth()+"',0),"
			+ "nvl('"+empMaster.getSourceDiameter()+"',0),'"
			//+ empMaster.getSourceType()
			+ empMaster.getAssetCode()+"')";
			//System.out.println("query1 in insesrtSource in EmpMaster is "+query);
			empMasterData.stmt.addBatch(query);
			
			if(empMaster.getWaterQuality().equalsIgnoreCase("NSS"))
			{
				String contaminationQuery="insert into RWS_SOURCE_CONTAMINATION_TBL(" 
					+ "SOURCE_CODE,CONT_TYPE,CONT_PERC) values(" 
					+ "'"+empMaster.getSourceCode() + "'," 
					+ "'FLOURIDE'," 
					+ "nvl('"+empMaster.getFlouride()+"',0) )"; 
				
				//System.out.println("query1 in insesrtSource in EmpMaster is "+contaminationQuery);
				empMasterData.stmt.addBatch(contaminationQuery);
				
				contaminationQuery="insert into RWS_SOURCE_CONTAMINATION_TBL(" 
					+ "SOURCE_CODE,CONT_TYPE,CONT_PERC) values(" 
					+ "'"+empMaster.getSourceCode() + "'," 
					+ "'BRAKISH'," 
					+ "nvl('"+ empMaster.getBrakish()+"',0) )"; 
				
				//System.out.println("query2 in insesrtSource in EmpMaster is "+contaminationQuery);
				empMasterData.stmt.addBatch(contaminationQuery);
				
				contaminationQuery="insert into RWS_SOURCE_CONTAMINATION_TBL(" 
					+ "SOURCE_CODE,CONT_TYPE,CONT_PERC) values(" 
					+ "'"+empMaster.getSourceCode() + "'," 
					+ "'IRON'," 
					+ "nvl('"+ empMaster.getIron()+"',0) )"; 
				
				//System.out.println("query3 in insesrtSource in EmpMaster is "+contaminationQuery);
				empMasterData.stmt.addBatch(contaminationQuery);
				
				if(empMaster.getOthersType()!=null || !empMaster.getOthersType().equals(""))
				{
					contaminationQuery="insert into RWS_SOURCE_CONTAMINATION_TBL(" 
						+ "SOURCE_CODE,CONT_TYPE,CONT_PERC) values(" 
						+ "'"+empMaster.getSourceCode() + "'," 
						+ "'"+format(empMaster.getOthersType()) + "'," 
						+ "'"+ format(empMaster.getOthers())+"')"; 
					
					//System.out.println("query3 in insesrtSource in EmpMaster is "+contaminationQuery);
					empMasterData.stmt.addBatch(contaminationQuery);
				}
			}
			/*if (checkedAssets != null) {
				
				for (int i = 0; i < checkedAssets.size(); i++) {
					assetSourceBean = (AssetSourceBean) checkedAssets.get(i);
					////System.out.println("assetSourceBean.getHabCode()= "	+ assetSourceBean.getHabCode());
					if (assetSourceBean.getHabCode().equalsIgnoreCase("on")) {
						query = " INSERT INTO rws_asset_source_tbl VALUES( "
								+ " '" + assetSourceBean.getAssetCode() + "','"
								+ empMaster.getSourceCode() + "')";
						////System.out.println(i + ": Asset Source Query is "	+ query);
						//System.out.println("query2["+i+"] is "+query);
						empMasterData.stmt.addBatch(query);
					}
				}
			}*/
			//rowCount = empMasterData.stmt.executeBatch();

			if (checkedHabs != null) {
				//System.out.println("checkedHabs.length is "+checkedHabs.size());
				for (int i = 0; i < checkedHabs.size(); i++) {
					//System.out.println("1");
					habSourceBean = (HabSourceBean) checkedHabs.get(i);
					//System.out.println("2");
					////System.out.println("habSourceBean.getHabCode()= "	+ habSourceBean.getHabCode());
					if (habSourceBean.getHabCode().equalsIgnoreCase("on")) {
						query = " INSERT INTO RWS_SOURCE_HABITATION_TBL  VALUES("
								+ "'"
								+ empMaster.getSourceCode()
								+ "','"
								+ habSourceBean.getPanchRajCode().substring(0,
										14) + "')";
						//Debug	.println(i + ": Hab Source Query is " + query);
						//System.out.println("query3["+i+"] is "+query);
						empMasterData.stmt.addBatch(query);
					}
				}
			}
			rowCount = empMasterData.stmt.executeBatch();

			for (int j = 0; j < rowCount.length; j++) {
				if (rowCount[j] != 0)
					flag = true;
			}

			if (flag)
			empMasterData.conn.commit();
			empMasterData.conn.setAutoCommit(true);
		} catch (Exception e) {
			//System.out.println("The error in insertSource= " + e);
		} finally {
			empMasterData.closeAll();
		}
		return flag;
	}

	public static EmpMaster getSource(String sourceCode, String mode,
			DataSource dataSource) throws Exception {
		EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;

		try {
			//System.out.println("in getSource in EmpMasterData");
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
				
			String query="select * from rws_source_tbl where source_code='"+sourceCode+"' ";
			//System.out.println("query in getSource is "+query);
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			if (empMasterData.rs.next()) {
				//System.out.println("in rs.next");
				empMaster = new EmpMaster();
				
				empMaster.setFlouride(0);
				empMaster.setBrakish(0);
				empMaster.setIron(0);
				
				empMaster.setSourceCode(empMasterData.rs.getString("SOURCE_CODE"));
				empMaster.setSourceName(empMasterData.rs.getString("SOURCE_NAME"));
				//if (mode.equalsIgnoreCase("get")) {
					//System.out.println("in mode.equals.get in EmpMasterData");
					
					
				empMaster.setSourceTypeCode(empMasterData.rs.getString("SOURCE_TYPE_CODE"));
				empMaster.setSubSourceTypeCode(empMasterData.rs.getString("SUBSOURCE_TYPE_CODE"));
				//} else if (mode.equalsIgnoreCase("viewSources")) {
					////System.out.println("mode.equals viewSources in EmpMasterData");
					//empMaster.setSourceTypeCode(getSourceTypeName(empMasterData.rs
						//	.getString("SOURCE_TYPE_CODE"), empMasterData.conn));
					//empMaster.setSubSourceTypeCode(getSubSourceName(empMasterData.rs
							//.getString("SOURCE_TYPE_CODE"), empMasterData.rs
							//.getString("SUBSOURCE_TYPE_CODE"), empMasterData.conn));
				//}
				//System.out.println("getting hab_code");
				empMaster.setHabCode(empMasterData.rs.getString("HAB_CODE"));
				//empMaster.setNoOfHab(empMasterData.rs.getString("NO_OF_HABITAITONS_COVERD"));
				//System.out.println("calling getSourceHabitationsCount");
				empMaster.setNoOfHab(getSourceHabitationsCount(empMasterData.conn,sourceCode)+"");
				empMaster.setPopbenefited(empMasterData.rs.getString("POPULATION_BENIFITED"));
				empMaster.setSeasonal(empMasterData.rs.getString("SEASONAL"));
				empMaster.setPresentCondition(empMasterData.rs.getString("SOURCE_CONDITION"));
				empMaster.setWaterQuality(empMasterData.rs.getString("WATER_QUALITY"));
				//empMaster.setContType(empMasterData.rs.getString("CONTAMINATION_TYPE"));
				//empMaster.setLevelOfCont(empMasterData.rs.getString("LEVEL_OF_CONTAMINATION"));
				empMaster.setStaticWaterLevel(empMasterData.rs
						.getString("STATIC_WATER_LEVEL"));
				empMaster.setSummerWaterLevel(empMasterData.rs
						.getString("SUMMER_WATER_LEVEL"));
				//empMaster.setYearOfDrilling(empMasterData.rs.getString("YEAR_OF_DRILLING"));
				//empMaster.setDiameterOfBorewell(empMasterData.rs.getString("DIAMETER_OF_BW"));
				//empMaster.setDepthOfBorewell(empMasterData.rs.getString("DEPTH_OF_BW"));
				empMaster.setYield(empMasterData.rs.getString("YIELD"));
				empMaster.setDistFromSource(empMasterData.rs
						.getString("DIST_NEAR_PRIVATE_SOURCE"));
				empMaster.setLocation(empMasterData.rs.getString("LOCATION"));
				empMaster.setAssetCode(empMasterData.rs.getString("ASSET_CODE"));
			}
			
			//retrieving contamination details
			query="select * from RWS_SOURCE_CONTAMINATION_TBL where source_code='"
				+ sourceCode+"'";
			//System.out.println("query in getSource is "+query);
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			while (empMasterData.rs.next()) {
				//System.out.println("cont_type is "+empMasterData.rs.getString("CONT_TYPE"));
				//System.out.println("cont_prec="+empMasterData.rs.getDouble("CONT_PERC"));
				//System.out.println("cont_prec="+empMasterData.rs.getString("CONT_PERC"));
				if(empMasterData.rs.getString("CONT_TYPE").equalsIgnoreCase("FLOURIDE"))
				{
					empMaster.setFlouride(empMasterData.rs.getDouble("CONT_PERC"));
					//System.out.println("assigning flouride");
				}
				else if(empMasterData.rs.getString("CONT_TYPE").equalsIgnoreCase("BRAKISH"))
				{
					//System.out.println("assigning brakisn");
					empMaster.setBrakish(empMasterData.rs.getDouble("CONT_PERC"));
				}
				else if(empMasterData.rs.getString("CONT_TYPE").equalsIgnoreCase("IRON"))
				{
					//System.out.println("assigning iron");
					empMaster.setIron(empMasterData.rs.getDouble("CONT_PERC"));
				}
				else
				{
					//System.out.println("assigning others");
					empMaster.setOthersType(format(empMasterData.rs.getString("CONT_TYPE")));
					empMaster.setOthers(empMasterData.rs.getString("CONT_PERC"));
				}
				
			}
			
		//end of contamination details
		} catch (Exception e) {
			//System.out.println("The error in getSource=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}
	
	

	public static ArrayList getSources(DataSource dataSource)
	{
		ArrayList sources=new ArrayList();
		
		EmpMaster empMaster=new EmpMaster();
		empMaster.setSourceCode("0101001");
		empMaster.setCodeName("PWS SUBSURFACE SOURCE");
		sources.add(empMaster);
		
		empMaster=new EmpMaster();
		empMaster.setSourceCode("0101002");
		empMaster.setCodeName("PWS SURFACE SOURCE");
		sources.add(empMaster);
		
		empMaster=new EmpMaster();
		empMaster.setSourceCode("0101003");
		empMaster.setCodeName("PWS PUMPSETS");
		sources.add(empMaster);
		
		empMaster=new EmpMaster();
		empMaster.setSourceCode("0201001");
		empMaster.setCodeName("MPWS SUBSURFACE SOURCE");
		sources.add(empMaster);
		
		empMaster=new EmpMaster();
		empMaster.setSourceCode("0201002");
		empMaster.setCodeName("MPWS SURFACE SOURCE");
		sources.add(empMaster);
		
		empMaster=new EmpMaster();
		empMaster.setSourceCode("0201003");
		empMaster.setCodeName("MPWS PUMPSETS");
		sources.add(empMaster);
		
		empMaster=new EmpMaster();
		empMaster.setSourceCode("0301001");
		empMaster.setCodeName("CPWS SUBSURFACE SOURCE");
		sources.add(empMaster);
		
		empMaster=new EmpMaster();
		empMaster.setSourceCode("0301002");
		empMaster.setCodeName("CPWS SURFACE SOURCE");
		sources.add(empMaster);
		
		empMaster=new EmpMaster();
		//empMaster.setSourceCode("0301003");
		empMaster.setSourceCode("0301003");
		empMaster.setCodeName("CPWS PUMPSETS");
		sources.add(empMaster);
		
		empMaster=new EmpMaster();
		empMaster.setSourceCode("0401001");
		empMaster.setCodeName("HANDPUMPS BOREWELL");
		sources.add(empMaster);
		
		empMaster=new EmpMaster();
		empMaster.setSourceCode("0501001");
		empMaster.setCodeName("SHALLOW HANDPUMPS");
		sources.add(empMaster);
		
		empMaster=new EmpMaster();
		empMaster.setSourceCode("0601001");
		empMaster.setCodeName("OPEN WELLS");
		sources.add(empMaster);
		
		empMaster=new EmpMaster();
		empMaster.setSourceCode("0701001");
		empMaster.setCodeName("PONDS");
		sources.add(empMaster);
		
		return sources;
	}
	public static String getSourceTypeName(String sourceType)
	{
		String sourceTypeName="";
	
		if(sourceType.equals("0101001"))
			sourceTypeName="PWS SUBSURFACE SOURCE";
		
		if(sourceType.equals("0101002"))
			sourceTypeName="PWS SURFACE SOURCE";
		
		if(sourceType.equals("0101003"))
			sourceTypeName="PWS PUMPSETS";
		
		if(sourceType.equals("0201001"))
			sourceTypeName="MPWS SUBSURFACE SOURCE";
		
		if(sourceType.equals("0201002"))
			sourceTypeName="MPWS SURFACE SOURCE";
		
		if(sourceType.equals("0201003"))
			sourceTypeName="MPWS PUMPSETS";
		
		if(sourceType.equals("0301001"))
			sourceTypeName="CPWS SUBSURFACE SOURCE";
		
		if(sourceType.equals("0301002"))
			sourceTypeName="CPWS SURFACE SOURCE";
		
		if(sourceType.equals("0301003"))
			sourceTypeName="CPWS PUMPSETS";
		
		if(sourceType.equals("0401001"))
			sourceTypeName="HANDPUMPS BOREWELL";
		
		if(sourceType.equals("0501001"))
			sourceTypeName="SHALLOW HANDPUMPS";
		
		if(sourceType.equals("0601001"))
			sourceTypeName="OPEN WELLS";
		
		if(sourceType.equals("0701001"))
			sourceTypeName="PONDS";
		
		return sourceTypeName;
	}

	
	public static ArrayList getSources(DataSource dataSource,String assetTypeCode, String sourceTypeCode) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList sources = new ArrayList();
		//System.out.println("sourceTypeCode is "+sourceTypeCode);
		String shortSchemeCode="";
		
		//System.out.println("in getSources in EmpMasterData");
		try {
			if(assetTypeCode.equals("01"))
				shortSchemeCode="6%";
			else if(assetTypeCode.equals("02"))
				shortSchemeCode="4%";
			else if(assetTypeCode.equals("03"))
				shortSchemeCode="8%";
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			String query="select * from rws_source_tbl where SOURCE_TYPE_CODE = '"+sourceTypeCode+"' and substr(source_code,17,3) like '"+shortSchemeCode+"' order by source_code";
			//System.out.println("query in getSources is "+query);
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setAssetTypeCode(assetTypeCode);
				empMaster.setSourceCode(empMasterData.rs.getString("SOURCE_CODE"));
				empMaster.setSourceName(empMasterData.rs.getString("SOURCE_NAME"));
				empMaster.setSourceTypeCode(empMasterData.rs.getString("SOURCE_TYPE_CODE"));
				empMaster.setSourceTypeName(getSourceTypeName(empMasterData.rs
						.getString("SOURCE_TYPE_CODE"), empMasterData.conn));
				empMaster.setSubSourceTypeCode(empMasterData.rs
						.getString("SUBSOURCE_TYPE_CODE"));
				empMaster.setSubSourceTypeName(getSubSourceName(empMasterData.rs
						.getString("SUBSOURCE_TYPE_CODE"), empMasterData.rs
						.getString("SOURCE_TYPE_CODE"), empMasterData.conn));
				empMaster.setHabName(getHabName(empMasterData.rs.getString("HAB_CODE"), empMasterData.conn));
				empMaster.setHabCode(empMasterData.rs.getString("HAB_CODE"));
				//empMaster.setNoOfHab(empMasterData.rs.getString("NO_OF_HABITAITONS_COVERD"));
				//System.out.println("calling getSourceHabitationsCount");
				empMaster.setNoOfHab(getSourceHabitationsCount(empMasterData.conn,empMasterData.rs.getString("SOURCE_CODE"))+"");
				empMaster.setPopbenefited(empMasterData.rs.getString("POPULATION_BENIFITED"));
				//here
				/*if (empMasterData.rs.getString("SEASONAL").equalsIgnoreCase("Y"))
					empMaster.setSeasonal("YES");
				else
					empMaster.setSeasonal("NO");*/
				//if (empMasterData.rs.getString("SOURCE_CONDITION").equalsIgnoreCase("W"))
					
				empMaster.setPresentCondition(empMasterData.rs.getString("SOURCE_CONDITION"));
					
				//else if (empMasterData.rs.getString("PRESENT_CONDITION")
						//.equalsIgnoreCase("N"))
					//empMaster.setPresentCondition("NOT WORKING");
				//else if (empMasterData.rs.getString("PRESENT_CONDITION")
						//.equalsIgnoreCase("D"))
					//empMaster.setPresentCondition("DRIED");
				String waterQuality=empMasterData.rs.getString("WATER_QUALITY");
				if(waterQuality==null)
					waterQuality="";
				empMaster.setWaterQuality(waterQuality);
				//System.out.println("waterQuality is "+waterQuality);
				empMaster.setStaticWaterLevel(empMasterData.rs
						.getString("STATIC_WATER_LEVEL"));
				empMaster.setSummerWaterLevel(empMasterData.rs
						.getString("SUMMER_WATER_LEVEL"));
				empMaster.setYield(empMasterData.rs.getString("YIELD"));
				empMaster.setDistFromSource(empMasterData.rs
						.getString("DIST_NEAR_PRIVATE_SOURCE"));
				empMaster.setCodeName(empMasterData.rs.getString("SOURCE_CODE") + " - "
						+ empMasterData.rs.getString("SOURCE_NAME"));
				empMaster.setLocation(empMasterData.rs.getString("location"));
				
				//getting contamination details
				if(waterQuality.equalsIgnoreCase("NSS"))
				{
					//System.out.println("getting waterQuality data");
					query="select * from RWS_SOURCE_CONTAMINATION_TBL where source_code='"
						+ empMasterData.rs.getString("SOURCE_CODE")+"'";
					//System.out.println("query in getSource is "+query);
					empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
					if (empMasterData.rs1.next()) {
						if(empMasterData.rs1.getString("CONT_TYPE").equalsIgnoreCase("FLOURIDE"))
						{
							//System.out.println("assigning flouride");
							empMaster.setFlouride(empMasterData.rs1.getDouble("CONT_PERC"));
						}
						else if(empMasterData.rs1.getString("CONT_TYPE").equalsIgnoreCase("BRAKISH"))
						{
							//System.out.println("assigning brakisn");
							empMaster.setBrakish(empMasterData.rs1.getDouble("CONT_PERC"));
						}
						else if(empMasterData.rs1.getString("CONT_TYPE").equalsIgnoreCase("IRON"))
						{
							//System.out.println("assigning iron");
							empMaster.setIron(empMasterData.rs1.getDouble("CONT_PERC"));
						}
						else 
						{
							//System.out.println("assigning others");
							empMaster.setOthersType(format(empMasterData.rs1.getString("CONT_TYPE")));
							empMaster.setOthers(empMasterData.rs1.getString("CONT_PERC"));
						}
						
						
					}
					else
					{
						empMaster.setFlouride(0);
						empMaster.setBrakish(0);
						empMaster.setIron(0);
					}
				}
				//end of contamination Detials
				sources.add(empMaster);
				//System.out.println("executed all");
			}
		} catch (Exception e) {
			//System.out.println("The error in getSources=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return sources;
	}
	
	//@code added on 220107
	
	/*
	public static EmpMaster getSource(DataSource dataSource,String sourceCode) throws Exception {   
	EmpMasterData empMasterData=new EmpMasterData();
	EmpMaster EmpMaster = null;
	//System.out.println("sourceCode in getSource in EmpMasterData is"+sourceCode);
	
	
	
	//System.out.println("in getSource in EmpMasterData");
	try {
		
		empMasterData.conn = dataSource.getConnection();
		empMasterData.stmt = empMasterData.conn.createStatement();
		String query="select * from rws_source_tbl  where source_code='"+sourceCode+"' order by source_code";
		//System.out.println("query in getSource is "+query);
		empMasterData.rs =empMasterData.stmt.executeQuery(query);
		while (empMasterData.rs.next()) {
			EmpMaster = new EmpMaster();

			empMaster.setSourceCode(empMasterData.rs.getString("SOURCE_CODE"));
			empMaster.setSourceName(empMasterData.rs.getString("SOURCE_NAME"));
			empMaster.setSourceTypeCode(empMasterData.rs.getString("SOURCE_TYPE_CODE"));
			empMaster.setSourceTypeName(getSourceTypeName(empMasterData.rs
					.getString("SOURCE_TYPE_CODE"), empMasterData.conn));
			empMaster.setSubSourceTypeCode(empMasterData.rs
					.getString("SUBSOURCE_TYPE_CODE"));
			//System.out.println("printing subSourceTypeName in EmpMasterData");
			empMaster.setSubSourceTypeName(getSubSourceName(empMasterData.rs
					.getString("SUBSOURCE_TYPE_CODE"), empMasterData.rs
					.getString("SOURCE_TYPE_CODE"), empMasterData.conn));
			EmpMaster
					.setHabName(getHabName(empMasterData.rs.getString("HAB_CODE"), empMasterData.conn));
			empMaster.setHabCode(empMasterData.rs.getString("HAB_CODE"));
			empMaster.setNoOfHab(empMasterData.rs.getString("NO_OF_HABITAITONS_COVERD"));
			empMaster.setPopbenefited(empMasterData.rs.getString("POPULATION_BENIFITED"));
			////if (empMasterData.rs.getString("SEASONAL").equalsIgnoreCase("Y"))
				//empMaster.setSeasonal("YES");
			//else
				empMaster.setSeasonal("NO");////
			//if (empMasterData.rs.getString("SOURCE_CONDITION").equalsIgnoreCase("W"))
				empMaster.setPresentCondition(empMasterData.rs.getString("SOURCE_CONDITION"));
				//System.out.println("10");
			//else if (empMasterData.rs.getString("PRESENT_CONDITION")
					//.equalsIgnoreCase("N"))
				//empMaster.setPresentCondition("NOT WORKING");
			//else if (empMasterData.rs.getString("PRESENT_CONDITION")
					//.equalsIgnoreCase("D"))
				//empMaster.setPresentCondition("DRIED");
			
				empMaster.setWaterQuality(empMasterData.rs.getString("WATER_QUALITY"));
			empMaster.setStaticWaterLevel(empMasterData.rs
					.getString("STATIC_WATER_LEVEL"));
			empMaster.setSummerWaterLevel(empMasterData.rs
					.getString("SUMMER_WATER_LEVEL"));
			empMaster.setYield(empMasterData.rs.getString("YIELD"));
			empMaster.setDistFromSource(empMasterData.rs
					.getString("DIST_NEAR_PRIVATE_SOURCE"));
			empMaster.setCodeName(empMasterData.rs.getString("SOURCE_CODE") + " - "
					+ empMasterData.rs.getString("SOURCE_NAME"));
			empMaster.setLocation(empMasterData.rs.getString("location"));
			
			
			//System.out.println("executedALL");
		}
	} catch (Exception e) {
		//System.out.println("The error in getSources=" + e);
	} finally {
		empMasterData.closeAll();
	}
	return empMaster;
}
	
*/	
	//@end of code

	public static int[] removeSource(String sourceCode, ArrayList tempSelectedSourceHabs,DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int[] rowCount = new int[10];
		try {
			String query;
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.conn.setAutoCommit(false);
			if (tempSelectedSourceHabs != null) 
			{
				//System.out.println("tempSelectedSourceHabs.length is "+tempSelectedSourceHabs.size());
			query="delete from RWS_SOURCE_HABITATION_TBL where source_code='"
				+ sourceCode+"'";
			//System.out.println("query1 in removeSource is "+query);
			empMasterData.stmt
					.addBatch(query);
			}
			/*query="delete from RWS_ASSET_SOURCE_TBL where source_code="
				+ sourceCode;
			//System.out.println("query2 in removeSource is "+query);
			empMasterData.stmt.addBatch(query);*/
			query="delete  from rws_source_tbl where source_code='"
				+ sourceCode+"'";
			//System.out.println("query3 in removeSource is "+query);
			empMasterData.stmt.addBatch(query);
			
			query="delete  from RWS_SOURCE_CONTAMINATION_TBL where source_code='"
				+ sourceCode+"'";
			//System.out.println("query to remove contaminations is "+query);
			empMasterData.stmt.addBatch(query);
			
			
			rowCount = empMasterData.stmt.executeBatch();
			empMasterData.conn.setAutoCommit(true);

		}

		catch (Exception e) {
			//System.out.println("The error in removeSource=" + e);
		} finally {

			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static int updateSource(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   
		EmpMasterData empMasterData=new EmpMasterData();
		int updcnt = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt2 = empMasterData.conn.createStatement();
			empMasterData.conn.setAutoCommit(false);
			//System.out.println("waterQuality is "+empMaster.getWaterQuality());
			if(empMaster.getWaterQuality().equalsIgnoreCase("SS"))
			{
				empMaster.setFlouride(0);
				empMaster.setBrakish(0); 
				empMaster.setIron(0);
				empMaster.setOthers("");
				empMaster.setOthersType("");
			}
			String query = "update  rws_source_tbl set " 
					     + "SOURCE_NAME=nvl(?,'')," 
						 + "SOURCE_TYPE_CODE=nvl(?,'')," 
						 + "SUBSOURCE_TYPE_CODE=nvl(?,'')," 
						 + "NO_OF_HABITAITONS_COVERD=nvl(?,0),"
						 + "seasonal=nvl(?,''),"
						 + "SOURCE_CONDITION=nvl(?,''),"
						 + "yield=nvl(?,''),"
						 + "POPULATION_BENIFITED=nvl(?,0),"
						 + "WATER_QUALITY=nvl(?,''),"
						 + "DIST_NEAR_PRIVATE_SOURCE=nvl(?,0),"
						 + "location=nvl(?,'')"
						 + " where source_code=?";
			//System.out.println("query in updateSource is "+query);
               PreparedStatement ps=empMasterData.conn.prepareStatement(query);
               ps.setString(1, empMaster.getSourceName().toUpperCase());
               ps.setString(2, empMaster.getSourceTypeCode());
               ps.setString(3, empMaster.getSubSourceTypeCode());
               ps.setString(4, empMaster.getNoOfHab());
               ps.setString(5, empMaster.getSeasonal());
               ps.setString(6, empMaster.getPresentCondition());
               ps.setString(7,  empMaster.getYield());
               ps.setString(8, empMaster.getPopbenefited());
               ps.setString(9, empMaster.getWaterQuality());
               ps.setString(10, empMaster.getDistFromSource());
               ps.setString(11, empMaster.getLocation());
               ps.setString(12, empMaster.getSourceCode());
			updcnt = ps.executeUpdate();
			
			if(updcnt>0)
			{
				int rowCount[] = null;
				
				String contaminationQuery="";
				String contaminationUpdateQuery="";
				int recUpdated=0;
				boolean flag=false;
				
				String contaminationDeleteQuery="DELETE FROM RWS_SOURCE_CONTAMINATION_TBL " 
					+ "WHERE SOURCE_CODE=? AND " 
					+ "CONT_TYPE NOT IN('FLOURIDE','BRAKISH','IRON')";
				PreparedStatement ps=empMasterData.conn.PreparedStatement(contaminationDeleteQuery); 
				//System.out.println("delete query is "+contaminationDeleteQuery);
				ps.setString(1,empMaster.getSourceCode());
				recUpdated=ps.executeUpdate();
			
				
				if(empMaster.getWaterQuality().equalsIgnoreCase("NSS"))
				{
					
					
				/*contaminationUpdateQuery="update  RWS_SOURCE_CONTAMINATION_TBL SET " 
					+ "CONT_PERC=nvl('"+empMaster.getFlouride()+"',0) " 
					+ "WHERE SOURCE_CODE='"+empMaster.getSourceCode() + "'" 
					+ " AND CONT_TYPE='FLOURIDE'" ;
				//System.out.println("contaminationUpdatequery is "+contaminationUpdateQuery);
				recUpdated=empMasterData.stmt2.executeUpdate(contaminationUpdateQuery);
				*/
				//if(recUpdated<1)
				//{
					contaminationQuery="insert into RWS_SOURCE_CONTAMINATION_TBL(" 
						+ "SOURCE_CODE,CONT_TYPE,CONT_PERC) values(" 
						+ "'"+empMaster.getSourceCode() + "'," 
						+ "'FLOURIDE'," 
						+ "nvl('"+empMaster.getFlouride()+"',0) )"; 
					
					//System.out.println("query1 in insesrtSource in EmpMaster is "+contaminationQuery);
					empMasterData.stmt.addBatch(contaminationQuery);
				//}
				
				/*
				contaminationUpdateQuery="update  RWS_SOURCE_CONTAMINATION_TBL SET " 
					+ "CONT_PERC=nvl('"+empMaster.getBrakish()+"',0) " 
					+ "WHERE SOURCE_CODE='"+empMaster.getSourceCode() + "'" 
					+ " AND CONT_TYPE='BRAKISH'" ;
				//System.out.println("contaminationUpdatequery is "+contaminationUpdateQuery);
				recUpdated=empMasterData.stmt2.executeUpdate(contaminationUpdateQuery);
				if(recUpdated<1)
				{
					*/
					contaminationQuery="insert into RWS_SOURCE_CONTAMINATION_TBL(" 
						+ "SOURCE_CODE,CONT_TYPE,CONT_PERC) values(" 
						+ "'"+empMaster.getSourceCode() + "'," 
						+ "'BRAKISH'," 
						+ "nvl('"+ empMaster.getBrakish()+"',0) )"; 
					
					//System.out.println("query2 in insesrtSource in EmpMaster is "+contaminationQuery);
					empMasterData.stmt.addBatch(contaminationQuery);
				
				/*}
				
				contaminationUpdateQuery="update  RWS_SOURCE_CONTAMINATION_TBL SET " 
					+ "CONT_PERC=nvl('"+empMaster.getIron()+"',0) " 
					+ "WHERE SOURCE_CODE='"+empMaster.getSourceCode() + "'" 
					+ " AND CONT_TYPE='IRON'" ;
				//System.out.println("contaminationUpdatequery is "+contaminationUpdateQuery);
				recUpdated=empMasterData.stmt2.executeUpdate(contaminationUpdateQuery);
				if(recUpdated<1)
				{*/
					contaminationQuery="insert into RWS_SOURCE_CONTAMINATION_TBL(" 
						+ "SOURCE_CODE,CONT_TYPE,CONT_PERC) values(" 
						+ "'"+empMaster.getSourceCode() + "'," 
						+ "'IRON'," 
						+ "nvl('"+ empMaster.getIron()+"',0) )"; 
					
					//System.out.println("query3 in insesrtSource in EmpMaster is "+contaminationQuery);
					empMasterData.stmt.addBatch(contaminationQuery);
				/*}
				
				if(empMaster.getOthersType()!=null && !empMaster.getOthersType().equals(""))
				{
					contaminationUpdateQuery="update  RWS_SOURCE_CONTAMINATION_TBL SET " 
						+ "CONT_PERC='"+empMaster.getOthers()+"' " 
						+ "WHERE SOURCE_CODE='"+empMaster.getSourceCode() + "'" 
						+ " AND CONT_TYPE='"+empMaster.getOthersType() + "'" ;
					//System.out.println("contaminationUpdatequery is "+contaminationUpdateQuery);
					recUpdated=empMasterData.stmt2.executeUpdate(contaminationUpdateQuery);
					if(recUpdated<1)
					{
						String contaminationDeleteQuery="DELETE FROM RWS_SOURCE_CONTAMINATION_TBL " 
							+ "WHERE SOURCE_CODE='"+empMaster.getSourceCode()+"' AND " 
							+ "CONT_TYPE NOT IN('FLOURIDE','BRAKISH','IRON')";
					//System.out.println("delete query is "+contaminationDeleteQuery);
						recUpdated=empMasterData.stmt2.executeUpdate(contaminationDeleteQuery);
					*/
					
					contaminationQuery="insert into RWS_SOURCE_CONTAMINATION_TBL(" 
							+ "SOURCE_CODE,CONT_TYPE,CONT_PERC) values(" 
							+ "'"+empMaster.getSourceCode() + "'," 
							+ "'"+format(empMaster.getOthersType()) + "'," 
							+ "'"+ format(empMaster.getOthers())+"' )"; 
						
					//System.out.println("query3 in insesrtSource in EmpMaster is "+contaminationQuery);
					empMasterData.stmt.addBatch(contaminationQuery);
					//}
				//}
				}
				
				rowCount = empMasterData.stmt.executeBatch();

				for (int j = 0; j < rowCount.length; j++) {
					if (rowCount[j] != 0)
						flag = true;
					
				}
				
				if(rowCount==null || rowCount.length==0)
					flag=true;
				
				if (flag)
				{
					empMasterData.conn.commit();					
				}
				else
					updcnt=0;
				empMasterData.conn.setAutoCommit(true);

			}
		} catch (Exception e) {
			//System.out.println("The error in updateSource=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return updcnt;
	}

	public static String getSourceCode(DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String scode = null;

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			//SELECT MAX(to_number(substr(SOURCE_CODE,22,3)))+1 FROM rws_source_tbl where substr(source_code,1,19)='1419223020011700800'
			//String query="SELECT MAX((SOURCE_CODE))+1 FROM rws_source_tbl";
			String query="SELECT MAX(substr(SOURCE_CODE,22,3)+1) FROM rws_source_tbl";
			
			//System.out.println("query in getSourceCode is "+query);
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			empMasterData.rs.next();
			scode = empMasterData.rs.getString(1);
			//String tmp=scode.substring(22,24);
			if (scode == null) {
				scode = "01";
			} else if (scode.length() == 1) {
				scode = "0" + scode;
			}
			
		} catch (Exception e) {
			//System.out.println("The error in getSourceCode=" + e);
		} finally {
			empMasterData.closeAll();
		}

		return scode;
		
	}
	public static ArrayList getSourceCode(DataSource dataSource,String habCode,String schemeCode, String sourceType) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String[] scode = null;
		ArrayList sourCode = new ArrayList();
		int i=0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			String query="SELECT SOURCE_CODE FROM rws_source_tbl where SOURCE_TYPE_CODE ="+sourceType+" and HAB_CODE='"+habCode+"'";
			//System.out.println("query in getSourceCode is "+query);
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			while(empMasterData.rs.next())
			{
				scode =new String[1];
				
				scode[i]= empMasterData.rs.getString("SOURCE_CODE");
				////System.out.println("value of surce code in rws materdata is  "+scode[i]);
				//sourCode.add(scode);
				sourCode.add(empMasterData.rs.getString("SOURCE_CODE"));
			}
		} catch (Exception e) {
			//System.out.println("The error in getSourceCode=" + e);
		} finally {
			empMasterData.closeAll();
		}

		return sourCode;
	}

	public static ArrayList getHabAsSources(String dcode, String mcode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList habSrcs = new ArrayList();

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			String query="select H.HAB_CODE,PR.HAB_CODE,PR.PANCH_NAME,(H.CENSUS_PLAIN_POPU +H.CENSUS_SC_POPU+H.CENSUS_ST_POPU ) TOTAL_POP,H.COVERAGE_STATUS from RWS_HABITATION_DIRECTORY_TBL  H ,"
							+ "RWS_PANCHAYAT_RAJ_TBL PR where  substr(PR.HAB_CODE,1,2)='"
							+ dcode
							+ "' and substr(PR.HAB_CODE,6,2)='"
							+ mcode
							+ "'"
							+ "and PR.HAB_CODE=substr(H.HAB_CODE,1,14) ORDER BY H.HAB_CODE";
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			//System.out.println("query is "+query);
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setHabCode(empMasterData.rs.getString(1));
				empMaster.setPanchRajCode(empMasterData.rs.getString(2));
				empMaster.setPanchRajName(empMasterData.rs.getString(3));
				empMaster.setTotalPop(empMasterData.rs.getInt(4));
				empMaster.setCoveredStatus(empMasterData.rs.getString(5));
				habSrcs.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getAssetsOnSource=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return habSrcs;
	}

	public static ArrayList getHabAsSourcesForReservoirs(DataSource dataSource,String schemeCode) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String dcode=schemeCode.substring(0,2);
		String mcode=schemeCode.substring(5,7);
			
		EmpMaster empMaster = null;
		ArrayList habSrcs = new ArrayList();

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			/*String query="select H.HAB_CODE,PR.HAB_CODE,PR.PANCH_NAME,(H.CENSUS_PLAIN_POPU +H.CENSUS_SC_POPU+H.CENSUS_ST_POPU ) TOTAL_POP,H.COVERAGE_STATUS from RWS_HABITATION_DIRECTORY_TBL  H ,"
							+ "RWS_PANCHAYAT_RAJ_TBL PR where  substr(PR.HAB_CODE,1,2)='"
							+ dcode
							+ "' and substr(PR.HAB_CODE,6,2)='"
							+ mcode
							+ "'"
							+ "and PR.HAB_CODE=substr(H.HAB_CODE,1,14) ORDER BY H.HAB_CODE";
			*/
			
			
			/*String query="select H.HAB_CODE,PR.PANCH_CODE,PR.PANCH_NAME,(H.CENSUS_PLAIN_POPU +H.CENSUS_SC_POPU+H.CENSUS_ST_POPU ) TOTAL_POP,H.COVERAGE_STATUS from RWS_HABITATION_DIRECTORY_TBL  H ,"
			+ "RWS_PANCHAYAT_RAJ_TBL PR where  substr(PR.HAB_CODE,1,2)='"
			+ dcode
			+ "' and substr(PR.HAB_CODE,6,2)='"
			+ mcode
			+ "'"
			+ "and PR.HAB_CODE=substr(H.HAB_CODE,1,14) ORDER BY H.HAB_CODE";
			*/
			
			String query="select H.HAB_CODE,PR.PANCH_CODE,PR.PANCH_NAME," 
				+ " (H.CENSUS_PLAIN_POPU +H.CENSUS_SC_POPU+H.CENSUS_ST_POPU ) TOTAL_POP," 
				+ " H.COVERAGE_STATUS  FROM RWS_PANCHAYAT_RAJ_TBL PR, RWS_HABITATION_DIRECTORY_TBL  H" 
				+ " where pr.PANCH_CODE=H.HAB_CODE " 
				+ " and pr.HAB_CODE in (SELECT hab_code FROM RWS_HABMAST_TBL " 
				+ " WHERE DCODE='"+dcode+"' and MCODE='"+mcode+"') order by panch_code";
			

			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			//System.out.println("query is "+query);
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				//empMaster.setHabCode(empMasterData.rs.getString(1));
				empMaster.setHabCode("off");
				empMaster.setPanchRajCode(empMasterData.rs.getString(2));
				empMaster.setPanchRajName(empMasterData.rs.getString(3));
				empMaster.setTotalPop(empMasterData.rs.getInt(4));
				empMaster.setCoveredStatus(empMasterData.rs.getString(5));
				habSrcs.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getAssetsOnSource=" + e);
		} finally {
			empMasterData.closeAll();
		}
		
		ArrayList selectedHabCodes=null;
		try{
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			String habCode=null;
			String query="select * from RWS_OHGLCI_HAB_LINK_TBL where SUBCOMP_CODE='"+schemeCode+"'";
			//System.out.println("query is "+query);
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			selectedHabCodes=new ArrayList();
			//System.out.println("getting selected habCode");
			while (empMasterData.rs.next()) {
				//System.out.println("got selected hab code in EmpMasterData");
				selectedHabCodes.add(empMasterData.rs.getString("hab_code"));
			}
		} catch (Exception e) {
			//System.out.println("The error in getAssetsOnSource=" + e);
		} finally {
			empMasterData.closeAll();
		}
	
		for(int i=0;i<habSrcs.size();i++)
		{
			empMaster=(EmpMaster)habSrcs.get(i);
			for(int j=0;j<selectedHabCodes.size();j++)
			{
				if(empMaster.getPanchRajCode().substring(0,16).equals((String)selectedHabCodes.get(j)))
				{
					//System.out.println("switched to on");
					empMaster.setHabCode("on");
					empMaster.setSaved(true);
					habSrcs.set(i,empMaster);
				}
				else
				{
					//System.out.println("not switched to on");
				
				}
			}
		}
		return habSrcs;
	}

	
	public static ArrayList getSelectedHabitationLinkageForAsset(DataSource dataSource,String assetCode) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		
			
		EmpMaster empMaster = null;
		ArrayList habSrcs = new ArrayList();

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			
			/*String query="select H.HAB_CODE,PR.HAB_CODE,PR.PANCH_NAME,(H.CENSUS_PLAIN_POPU +H.CENSUS_SC_POPU+H.CENSUS_ST_POPU ) TOTAL_POP,H.COVERAGE_STATUS from RWS_HABITATION_DIRECTORY_TBL  H ,"
							+ "RWS_PANCHAYAT_RAJ_TBL PR where  substr(PR.HAB_CODE,1,2)='"
							+ dcode
							+ "' and substr(PR.HAB_CODE,6,2)='"
							+ mcode
							+ "'"
							+ "and PR.HAB_CODE=substr(H.HAB_CODE,1,14) ORDER BY H.HAB_CODE";
			*/
			String query="select hab_code from rws_asset_hab_tbl where ASSET_CODE ='"+assetCode+"'";
			empMasterData.rs =empMasterData.stmt.executeQuery("select hab_code from rws_asset_hab_tbl where ASSET_CODE ='"+assetCode+"'");
			//System.out.println("query is "+query);
			////System.out.println("entering while");
			//empMasterData.rs.next();
			////System.out.println(empMasterData.rs.getString(1));
			while (empMasterData.rs.next()) {
				//System.out.println("in while");
				empMaster = new EmpMaster();
				//empMaster.setHabCode(empMasterData.rs.getString(1));
				empMaster.setHabCode(empMasterData.rs.getString(1));
				habSrcs.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getAssetsOnSource=" + e);
		} finally {
			empMasterData.closeAll();
		}
		
		
	
		
		return habSrcs;
	}
	public static ArrayList getHabsOnSource(String sourceCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList habSrcs = new ArrayList();

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			String query="select H.HAB_CODE,PR.HAB_CODE HABCODE,PR.PANCH_NAME,"
				+ "(H.CENSUS_PLAIN_POPU +H.CENSUS_SC_POPU+H.CENSUS_ST_POPU ) TOTAL_POP,H.COVERAGE_STATUS from RWS_HABITATION_DIRECTORY_TBL H,"
				+ "RWS_PANCHAYAT_RAJ_TBL PR,RWS_SOURCE_HABITATION_TBL SH,RWS_SOURCE_TBL S where PR.HAB_CODE=substr(H.HAB_CODE,1,14) and "
				+ "PR.HAB_CODE=SH.HAB_CODE AND substr(H.HAB_CODE,1,14)=SH.HAB_CODE AND SH.SOURCE_CODE=S.SOURCE_CODE AND S.SOURCE_CODE='"
				+ sourceCode
				+ "' AND substr(H.HAB_CODE,1,14)=SH.HAB_CODE ORDER BY H.HAB_CODE";
			//System.out.println("query is "+query);
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setHabCode(empMasterData.rs.getString(1));
				empMaster.setPanchRajCode(empMasterData.rs.getString(2));
				empMaster.setPanchRajName(empMasterData.rs.getString(3));
				empMaster.setTotalPop(empMasterData.rs.getInt(4));
				empMaster.setCoveredStatus(empMasterData.rs.getString(5));
				habSrcs.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getHabsOnSource=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return habSrcs;
	}

	public static ArrayList getAssetsOnSource(String sourceCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList assetSrcs = new ArrayList();

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			String query="select s.asset_code,a.asset_name from"
				+ " RWS_ASSET_SOURCE_TBL s,rws_asset_mast_tbl a "
				+ "where SOURCE_CODE='" + sourceCode
				+ "' and a.asset_code=s.asset_code"
				+ " order by ASSET_CODE";
			//System.out.println("query in getAssetsOnSource in EmpMasterData is "+query);
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setAssetCode(empMasterData.rs.getString(1));
				empMaster.setAssetName(empMasterData.rs.getString(2));
				assetSrcs.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getAssetsOnSource=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return assetSrcs;
	}

	public static ArrayList getAssetsOnSameHabAsSources(String habCode,
			String status, DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList assetSrcs = new ArrayList();
		////System.out.println("hab code=" + habCode + "status=" + status);

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			if (status.equals("hab")) {
				empMasterData.rs =empMasterData.stmt
						.executeQuery("select hab_code,type_of_asset_name,asset_code,"
								+ "asset_name from RWS_ASSET_mast_TBL a,rws_asset_type_tbl at "
								+ "where a.type_of_asset_code=at.type_of_asset_code and "
								+ "hab_code='"
								+ habCode
								+ "' order by ASSET_CODE");
			} else if (status.equals("notHab")) {
				empMasterData.rs =empMasterData.stmt
						.executeQuery("select hab_code,type_of_asset_name,asset_code,"
								+ "asset_name from RWS_ASSET_mast_TBL a,rws_asset_type_tbl at "
								+ "where a.type_of_asset_code=at.type_of_asset_code and "
								+ "hab_code!='"
								+ habCode
								+ "' order by ASSET_CODE");
			}
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setHabCode(empMasterData.rs.getString(1));
				empMaster.setAssetTypeName(empMasterData.rs.getString(2));
				empMaster.setAssetCode(empMasterData.rs.getString(3));
				empMaster.setAssetName(empMasterData.rs.getString(4));

				assetSrcs.add(empMaster);
			}

		} catch (Exception e) {
			//System.out.println("The error in getAssetsOnSameHabAsSources=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return assetSrcs;
	}

	//*************************************SubSource
	// Methods**********************************
	public static int insertSubSourceType(EmpMaster empMaster,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rowCount = empMasterData.stmt
					.executeUpdate("insert into rws_subSource_type_tbl values(?,?,?)"
							
			PreparedStatement ps=empMasterData.conn.prepareStatement(sql);
			ps.setString(1, empMaster.getSourceTypeCode());
			ps.setString(2,  empMaster.getSubSourceTypeCode());
			ps.setString(3, empMaster.getSubSourceTypeName().toUpperCase());
			rowCount =ps.executeUpdate();
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println("The error in insertSubSourceType" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getSubSourceType(String sourceTypeCode,
			String subSourceTypeCode, DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from rws_subSource_type_tbl where subSource_type_code="
							+ subSourceTypeCode
							+ " and source_type_code="
							+ sourceTypeCode);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setSourceTypeCode(empMasterData.rs.getString(1));
				empMaster.setSourceTypeName(getSourceTypeName(empMasterData.rs.getString(1),
						empMasterData.conn));
				empMaster.setSubSourceTypeCode(empMasterData.rs.getString(2));
				empMaster.setSubSourceTypeName(empMasterData.rs.getString(3));
			}
		} catch (Exception e) {
			//System.out.println("The error in getSubSourceType" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getSubSourceTypes(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList subSources = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT SUB.SOURCE_TYPE_CODE,S.SOURCE_TYPE_NAME,SUBSOURCE_TYPE_CODE,SUBSOURCE_TYPE_NAME FROM RWS_SUBSOURCE_TYPE_TBL SUB,RWS_SOURCE_TYPE_TBL S WHERE SUB.SOURCE_TYPE_CODE=S.SOURCE_TYPE_CODE ORDER BY SUB.SOURCE_TYPE_CODE,SUBSOURCE_TYPE_CODE");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setSourceTypeCode(empMasterData.rs.getString(1));
				empMaster.setSourceTypeName(empMasterData.rs.getString(2));
				empMaster.setSubSourceTypeCode(empMasterData.rs.getString(3));
				empMaster.setSubSourceTypeName(empMasterData.rs.getString(4));

				subSources.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getSubSourceTypes" + e);
		} finally {
			empMasterData.closeAll();
		}
		return subSources;
	}

	public static int removeSubSourceType(String sourceTypeCode,
			String subSourceTypeCode, DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rcount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement=empMasterData.conn.prepareStatement("delete  from rws_subSource_type_tbl where subSource_type_code=? and source_type_code=?");
			ps.setString(1, subSourceTypeCode);
			ps.setString(2, sourceTypeCode);
			rcount=ps.executeUpdate();
		} catch (Exception e) {
			//System.out.println("The error in removeSubSourceType" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rcount;
	}

	public static int updateSubSourceType(EmpMaster empMaster,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int updateCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();

			ps = empMasterData.conn
					.prepareStatement("update  rws_subSource_type_tbl set subSource_type_name=? where subSource_type_code=? and source_type_code=?");

			ps.setString(1, empMaster.getSubSourceTypeName().toUpperCase());
			ps.setString(2, empMaster.getSubSourceTypeCode());
			ps.setString(3, empMaster.getSourceTypeCode());

			updateCount = ps.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			//System.out.println("The error in updateSubSourceType " + sqle);
		} catch (Exception e) {
			//System.out.println("The error in updateSubSourceType" + e);
		} finally {
			empMasterData.closeAll();
		}
		return updateCount;
	}

	public static String getSubSourceTypeCode(String sourceTypeCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String subSourceTypeCode = "";
		if (sourceTypeCode != null) {
			try {
				empMasterData.conn = dataSource.getConnection();
				empMasterData.stmt = empMasterData.conn.createStatement();
				empMasterData.rs =empMasterData.stmt
						.executeQuery("SELECT MAX(to_number(SUBSOURCE_TYPE_CODE))+1 FROM RWS_SUBSOURCE_TYPE_TBL where SOURCE_TYPE_CODE="
								+ sourceTypeCode);
				empMasterData.rs.next();
				subSourceTypeCode = empMasterData.rs.getString(1);
				if (subSourceTypeCode == null) {
					subSourceTypeCode = "1";
				}
			} catch (Exception e) {
				//System.out.println("The error in getsubSourceTypeCode" + e);
			} finally {
				empMasterData.closeAll();
			}
		}
		return subSourceTypeCode;
	}

	public static ArrayList getSubSourceTypeCodes(String sourceTypeCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList subSourcecodes = new ArrayList();

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT SUBSOURCE_TYPE_CODE,SUBSOURCE_TYPE_NAME FROM RWS_SUBSOURCE_TYPE_TBL WHERE SOURCE_TYPE_CODE="
							+ sourceTypeCode
							+ "order by SUBSOURCE_TYPE_CODE,source_type_code");

			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setSubSourceTypeCode(empMasterData.rs.getString(1));
				empMaster.setSubSourceTypeName(empMasterData.rs.getString(2));
				empMaster.setSourceTypeNoName(empMasterData.rs.getString(1) + " - "
						+ empMasterData.rs.getString(2));

				subSourcecodes.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getSubSourceTypeCodes" + e);
		} finally {
			empMasterData.closeAll();
		}
		return subSourcecodes;
	}

	//*******************************SourceType
	// methods********************************************
	public static int insertSourceType(EmpMaster empMaster,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps=empMasterData.conn.prepareStatement("insert into rws_source_type_tbl values(?,?)");
			ps.getString(1,empMaster.getSourceTypeCode());
			ps.getString(2,empMaster.getSourceTypeName().toUpperCase());
			rowCount = ps.executeUpdate();
			
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println("The error in insertSourceType " + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getSourceType(String sourceTypeCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from rws_source_type_tbl where source_type_code='"
							+ sourceTypeCode + "'");
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setSourceTypeCode(empMasterData.rs.getString(1));
				empMaster.setSourceTypeName(empMasterData.rs.getString(2));
			}
		} catch (Exception e) {
			//System.out.println("The error in getSourceType" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getSourceTypes(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList sourceTypes = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from rws_source_type_tbl order by source_type_code");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setSourceTypeCode(empMasterData.rs.getString(1));
				empMaster.setSourceTypeName(empMasterData.rs.getString(2));
				empMaster.setSourceTypeNoName(empMasterData.rs.getString(1) + " - "
						+ empMasterData.rs.getString(2));

				sourceTypes.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getSourceTypes" + e);
		} finally {
			empMasterData.closeAll();
		}
		return sourceTypes;
	}

	public static int removeSourceType(String sourceTypeCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rcount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps=empMasterData.conn.prepareStatement("delete  from rws_source_type_tbl where source_type_code=?");
			ps.setString(1, sourceTypeCode);
			rcount = ps.executeUpdate();
					
		} catch (Exception e) {
			//System.out.println("The error in removeSourceType" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rcount;
	}

	public static int updateSourceType(EmpMaster empMaster,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int updateCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps=empMasterData.conn.PreparedStatement("update  rws_source_type_tbl set source_type_name=? where source_type_code=?");
		PreparedStatement ps=empMasterData.conn.PreparedStatement();
		ps.setString(1,empMaster.getSourceTypeName().toUpperCase());
		ps.setstring(2,empMaster.getSourceTypeCode() );
		updateCount =ps.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			//System.out.println("The error in updateSourceType " + sqle);
		} catch (Exception e) {
			//System.out.println("The error in updateSourceType" + e);
		} finally {
			empMasterData.closeAll();
		}
		return updateCount;
	}

	public static String getSourceTypeCode(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String scode = null;
		try {

			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT MAX(to_number(SOURCE_TYPE_CODE))+1 FROM rws_source_type_tbl");
			empMasterData.rs.next();
			scode = empMasterData.rs.getString(1);
			if (scode == null) {
				scode = "1";
			}
		} catch (Exception e) {
			//System.out.println("The error in getSourceTypeCode" + e);
		} finally {
			empMasterData.closeAll();
		}
		return scode;
	}

	//*******************************************************General
	// Methods********************//

	
	public static ArrayList getAddQualCodes(String qcode, DataSource dataSource) throws Exception 
	{   
		EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList addqualcodes = new ArrayList();

		try {
			//System.out.println("In the AddQualCodes() qcode=" + qcode);
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			if (qcode.length() >= 1 || qcode != null) {
			//System.out.println("the qcode value "+qcode);
			String query="select * from rws_qualification_tbl where qual_code='"+qcode+"' ";
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			//System.out.println("Qualification query"+query);
				
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setQualCode(empMasterData.rs.getString("qual_code"));
				empMaster.setQualName(empMasterData.rs.getString("qual_name"));
	empMaster.setQualNoName(empMasterData.rs.getString("qual_code") + " - "+ empMasterData.rs.getString("qual_name"));
				addqualcodes.add(empMaster);
				
				}
			}
		}

		catch (Exception e) {
			//System.out.println("The error in getAddQualCodes" + e);
		} finally {
			empMasterData.closeAll();
		}
		return addqualcodes;
	}

	//Added on Aug 1
	public static ArrayList getCastes(String code, DataSource dataSource)
		throws Exception {
	EmpMasterData empMasterData=new EmpMasterData();
	EmpMaster empMaster = null;
	ArrayList CasteCodes = new ArrayList();

	try {
		//System.out.println("in getCaste");
		//System.out.println("ConnCount is "+connCount);
		empMasterData.conn = dataSource.getConnection();
		empMasterData.stmt = empMasterData.conn.createStatement();
		if (code.length() >= 1 || code != null) 
		{
		//System.out.println("the qcode value "+code);
		empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT * FROM RWS_CAST_MST_TBL where CASTE_CODE<>'"+code+"'");
			
		while (empMasterData.rs.next())
		{
			empMaster = new EmpMaster();

			empMaster.setCasteCode(empMasterData.rs.getString("caste_code"));
			empMaster.setCasteName(empMasterData.rs.getString("caste_name"));

			String casteCode = empMasterData.rs.getString("caste_code");
			String casteName = empMasterData.rs.getString("caste_name");

			empMaster.setCasteNoName(casteCode + " - " + casteName);

			CasteCodes.add(empMaster);

		}
		}
	}
	catch (Exception e) {
		//System.out.println("The error in casteName" + e);
	} finally {
		empMasterData.closeAll();
		//System.out.println("ConnCount after closing is "+connCount);
	}
	return CasteCodes;
	}
		
public static ArrayList getCastes(DataSource dataSource)
	throws Exception {
EmpMasterData empMasterData=new EmpMasterData();
EmpMaster empMaster = null;
ArrayList castes= new ArrayList();

try {
	//System.out.println("in getCaste");
	//System.out.println("ConnCount is "+connCount);
	empMasterData.conn = dataSource.getConnection();
	empMasterData.stmt = empMasterData.conn.createStatement();
	empMasterData.rs =empMasterData.stmt
				.executeQuery("SELECT * FROM RWS_CAST_MST_TBL order by caste_code");
		
	while (empMasterData.rs.next())
	{
		empMaster = new EmpMaster();

		empMaster.setCasteCode(empMasterData.rs.getString("caste_code"));
		empMaster.setCasteName(empMasterData.rs.getString("caste_name"));

		String casteCode = empMasterData.rs.getString("caste_code");
		String casteName = empMasterData.rs.getString("caste_name");

		empMaster.setCasteNoName(casteCode + " - " + casteName);

		castes.add(empMaster);

	}
	
}
catch (Exception e) {
	//System.out.println("The error in casteName" + e);
} finally {
	empMasterData.closeAll();
	//System.out.println("ConnCount after closing is "+connCount);
}
return castes;
}
	
	
	public static String getEmpCode(DataSource dataSource) throws Exception {  
		EmpMasterData empMasterData=new EmpMasterData();
		String ecode = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			//empMasterData.rs =empMasterData.stmt.executeQuery("SELECT /*MAX(to_number(employee_CODE))+1 */FROM RWS_employee_TBL");
			empMasterData.rs =empMasterData.stmt.executeQuery("SELECT EMPLOYEE_CODE FROM RWS_employee_TBL");
			empMasterData.rs.next();
			ecode = empMasterData.rs.getString(1);
			if (ecode == null) {
				ecode = "1";
			}
		} catch (Exception e) {
			//System.out.println("Ther error in getEmpCode" + e);
		} finally {
			empMasterData.closeAll();
		}
		return ecode;
	}
	
	
	
	
	


// Added on Aug 1
	
	public static ArrayList getReligions(DataSource dataSource)
	throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
EmpMaster empMaster = null;
ArrayList religions = new ArrayList();

try {
	//System.out.println("in getReligion");
		//System.out.println("ConnCount is "+connCount);
	empMasterData.conn = dataSource.getConnection();
	empMasterData.stmt = empMasterData.conn.createStatement();
	String query="SELECT * FROM RWS_RELEGION_MST_TBL order by relg_code";
	empMasterData.rs =empMasterData.stmt.executeQuery(query);
	//System.out.println("get Religions"+query);
	while (empMasterData.rs.next()) {
		empMaster = new EmpMaster();

		empMaster.setRelgCode(empMasterData.rs.getString("relg_code"));
		empMaster.setRelgName(empMasterData.rs.getString("relg_name"));

		String relgCode = empMasterData.rs.getString("relg_code");
		String relgName = empMasterData.rs.getString("relg_name");

		empMaster.setRelgNoName(relgCode + " - " + relgName);

	religions.add(empMaster);

	}
}


catch (Exception e) {
	//System.out.println("The error in religionName" + e);
} finally {
	empMasterData.closeAll();
	//System.out.println("ConnCount after closing is "+connCount);
}
return religions;
}

//Added on Aug 1
	
public static String  getDistName(DataSource dataSource, String dcode) throws Exception  
{   
EmpMasterData empMasterData=new EmpMasterData();

String distname = "";
String query=null;
if(dcode!=null && !dcode.equals("00"))
{
try {
	//System.out.println("in getDistName");
	//System.out.println("ConnCount is "+connCount);
	//System.out.println("1");
	empMasterData.conn = dataSource.getConnection();
	//System.out.println("2");
	empMasterData.stmt = empMasterData.conn.createStatement();
	//System.out.println("3");
	query="select DNAME from rws_district_tbl where DCODE='"+dcode+"' ";
	empMasterData.rs =empMasterData.stmt.executeQuery(query);
	//System.out.println("District name "+query);
	while(empMasterData.rs.next())
	{
	distname = empMasterData.rs.getString(1);
	}
}
catch (Exception e) {
	//System.out.println("The error in getDistName=" + e);
} finally {
	empMasterData.closeAll();
	//System.out.println("ConnCount after closing is "+connCount);
}
}
return distname;
}

//Added on Aug 2

public static ArrayList getZones1(DataSource dataSource)
throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
EmpMaster empMaster = null;
ArrayList zonecodes= new ArrayList();

try {
//System.out.println("in getZones");
	//System.out.println("ConnCount is "+connCount);
empMasterData.conn = dataSource.getConnection();
empMasterData.stmt = empMasterData.conn.createStatement();
String query="SELECT distinct zone_code FROM RWS_ZONE_MST_TBL order by ZONE_CODE";
//System.out.println("query is "+query);
empMasterData.rs =empMasterData.stmt.executeQuery(query);
while (empMasterData.rs.next()) {
	empMaster = new EmpMaster();

	empMaster.setValue(empMasterData.rs.getString("ZONE_CODE"));
	empMaster.setLabel("zone"+empMasterData.rs.getString("ZONE_CODE"));

	String zoneCode = empMasterData.rs.getString("ZONE_CODE");
	String zoneName = "zone"+empMasterData.rs.getString("ZONE_CODE");

	empMaster.setZoneNoName(zoneCode + " - " + zoneName);

	zonecodes.add(empMaster);

}
}

catch (Exception e) {
//System.out.println("The error in getZones" + e);
} finally {
empMasterData.closeAll();
//System.out.println("ConnCount after closing is "+connCount);
}
return zonecodes;
}


//code for gettig Zone names
public static String getZoneName(String code, Connection conn)
throws Exception {   
	EmpMasterData empMasterData=new EmpMasterData();
	empMasterData.conn=conn;
	String name = null;
	empMasterData.stmt1 = null;
	empMasterData.rs1 = null;
	try {
		empMasterData.stmt1 = empMasterData.conn.createStatement();
		if (code!=null) {
			String query="SELECT distinct zone_code FROM RWS_ZONE_MST_TBL where ZONE_CODE='"+code+"' ";
			//System.out.println("query is "+query);
			empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
			while(empMasterData.rs1.next())
			{
			name="zone"+empMasterData.rs1.getString(1);
			}
			}
		} 
		catch (Exception e) {
			//System.out.println("Ther error in getDistrictName=" + e);
		} finally {
			empMasterData.stmt1.close();
			
		}
		return name;
	}
			/*String query="SELECT distinct zone_code FROM RWS_ZONE_MST_TBL order by ZONE_CODE";
			//System.out.println("query is "+query);
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			/*empMasterData.rs1 = empMasterData.stmt1
			.executeQuery("SELECT DESIGNATION_ACR,DESIGNATION_name FROM rws_designation_tbl WHERE designation_CODE ='"
					+ code + "'");
	empMasterData.rs1.next();
	name = empMasterData.rs1.getString(1);
} else
	name = "";
} catch (Exception e) {
//System.out.println("Ther error in getZoneName=" + e);
} finally {
empMasterData.stmt1.close();
}
return name;
}
*/


//same code with dataSource

public static String getZoneName(String code, DataSource dataSource)
throws Exception {   
	EmpMasterData empMasterData=new EmpMasterData();
	empMasterData.conn=dataSource.getConnection();
	String name = null;
	empMasterData.stmt1 = null;
	empMasterData.rs1 = null;
	try {
		empMasterData.stmt1 = empMasterData.conn.createStatement();
		if (code!=null) {
			String query="SELECT distinct zone_code FROM RWS_ZONE_MST_TBL where ZONE_CODE='"+code+"' ";
			//System.out.println("query is "+query);
			empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
			while(empMasterData.rs1.next())
			{
			name="zone"+empMasterData.rs1.getString(1);
			}
			}
		} 
		catch (Exception e) {
			//System.out.println("Ther error in getDistrictName=" + e);
		} finally {
			empMasterData.closeAll();
			
		}
		return name;
	}
public static ArrayList getZones(DataSource dataSource)
throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
EmpMaster empMaster = null;
ArrayList zonecodes= new ArrayList();

try {
//System.out.println("in getZones");
	//System.out.println("ConnCount is "+connCount);
empMasterData.conn = dataSource.getConnection();
empMasterData.stmt = empMasterData.conn.createStatement();
String query="SELECT distinct zone_code FROM RWS_ZONE_MST_TBL order by ZONE_CODE";
//System.out.println("query is "+query);
empMasterData.rs =empMasterData.stmt.executeQuery(query);
while (empMasterData.rs.next()) {
	empMaster = new EmpMaster();

	empMaster.setZoneCode(empMasterData.rs.getString("ZONE_CODE"));
	empMaster.setZoneName("zone"+empMasterData.rs.getString("ZONE_CODE"));

	String zoneCode = empMasterData.rs.getString("ZONE_CODE");
	String zoneName = "zone"+empMasterData.rs.getString("ZONE_CODE");

	empMaster.setZoneNoName(zoneCode + " - " + zoneName);


zonecodes.add(empMaster);

}
}

catch (Exception e) {
//System.out.println("The error in getZones" + e);
} finally {
empMasterData.closeAll();
//System.out.println("ConnCount after closing is "+connCount);
}
return zonecodes;
}


public static ArrayList getModeOfAppt(DataSource dataSource)
throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
EmpMaster empMaster = null;
ArrayList modes = new ArrayList();

try {
//System.out.println("in getModeOfAppt");
	//System.out.println("ConnCount is "+connCount);
empMasterData.conn = dataSource.getConnection();
empMasterData.stmt = empMasterData.conn.createStatement();
empMasterData.rs =empMasterData.stmt.executeQuery("SELECT * FROM RWS_MODEOFAPP_MST_TBL order by moap_code");
while (empMasterData.rs.next()) {
	empMaster = new EmpMaster();

	empMaster.setMoapCode(empMasterData.rs.getString("moap_code"));
	empMaster.setMoapName(empMasterData.rs.getString("moap_name"));

	String moapCode = empMasterData.rs.getString("moap_code");
	String moapName = empMasterData.rs.getString("moap_name");

	empMaster.setModeNoName(moapCode + " - " + moapName);

	modes.add(empMaster);

}
}

catch (Exception e) {
//System.out.println("The error in moapName" + e);
} finally {
empMasterData.closeAll();
//System.out.println("ConnCount after closing is "+connCount);
}
return modes;
}

public static ArrayList getCatogs(DataSource dataSource)
throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
EmpMaster empMaster = null;
ArrayList catcodes= new ArrayList();

try {
//System.out.println("in getCatogs");
	//System.out.println("ConnCount is "+connCount);
empMasterData.conn = dataSource.getConnection();
empMasterData.stmt = empMasterData.conn.createStatement();
empMasterData.rs =empMasterData.stmt.executeQuery("SELECT * FROM rws_app_category_mst_tbl order by APCATEG_CODE");
while (empMasterData.rs.next()) {
	empMaster = new EmpMaster();

	empMaster.setCatCode(empMasterData.rs.getString("APCATEG_CODE"));
	empMaster.setCatName(empMasterData.rs.getString("APCATEG_NAME"));

	String catCode = empMasterData.rs.getString("APCATEG_CODE");
	String catName = empMasterData.rs.getString("APCATEG_NAME");

	empMaster.setCatNoName(catCode + " - " + catName);

catcodes.add(empMaster);

}
}

catch (Exception e) {
//System.out.println("The error in catName" + e);
} finally {
empMasterData.closeAll();
//System.out.println("ConnCount after closing is "+connCount);
}
return catcodes;
}


public static ArrayList getQualNoName(DataSource dataSource) throws Exception {  
	EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList qualcodes = new ArrayList();

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT * FROM RWS_qualification_TBL order by qual_code");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setQualCode(empMasterData.rs.getString("qual_code"));
				empMaster.setQualName(empMasterData.rs.getString("qual_name"));

				String qualCode = empMasterData.rs.getString("qual_code");
				String qualName = empMasterData.rs.getString("qual_name");
				
				////System.out.println("the getQualNOName() EmpMasterData"+qualCode+" "+qualName);

				empMaster.setQualNoName(qualCode + " - " + qualName);

				qualcodes.add(empMaster);

			}
		}

		catch (Exception e) {
			//System.out.println("The error in QualNoName" + e);
		} finally {
			empMasterData.closeAll();
		}
		return qualcodes;
	}

	//**********************************Asset type
	// methods**********************************

	public static int insertAssetType(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps=empMasterData.conn.prepareStatement("insert into rws_asset_type_tbl values(?,?)");
			ps.setString(1, empMaster.getAssetTypeCode());
			ps.setString(2, empMaster.getAssetTypeName().toUpperCase());
			rowCount = ps.executeUpdate();
			
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println("The error in insertAssetType" + e);
		}

		finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getAssetType(String assetTypeCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from rws_asset_type_tbl where type_of_asset_code="
							+ assetTypeCode);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setAssetTypeCode(empMasterData.rs.getString(1));
				empMaster.setAssetTypeName(empMasterData.rs.getString(2));
			}
		} catch (Exception e) {
			//System.out.println("The error in getAssetType" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getAssetTypes(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList assetTypes = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from rws_asset_type_tbl order by type_of_asset_code");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setAssetTypeCode(empMasterData.rs.getString(1));
				empMaster.setAssetTypeName(empMasterData.rs.getString(2));

				empMaster.setAssetTypeNoName(empMasterData.rs.getString(1) + " - "
						+ empMasterData.rs.getString(2));

				assetTypes.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getAssetTypes" + e);
		} finally {
			empMasterData.closeAll();
		}
		return assetTypes;
	}

	public static int removeAssetType(String assetTypeCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rcount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps=empMasterData.conn.prepareStatement("delete  from rws_asset_type_tbl where type_of_asset_code=?")
			ps.setString(1, assetTypeCode);
			rcount =ps.executeUpdate();
							
		} catch (Exception e) {
			//System.out.println("The error in removeAssetType=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rcount;
	}

	public static int updateAssetType(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int updateCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps=empMasterData.conn.PreparedStatement("update  rws_asset_type_tbl set type_of_asset_name=? where type_of_asset_code=?");
			ps.setString(1, empMaster.getAssetTypeName().toUpperCase());
			ps.setString(2, empMaster.getAssetTypeCode());
			updateCount = ps.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			//System.out.println("The error in updateAssetType " + sqle);
		} catch (Exception e) {
			//System.out.println("The error in updateAssetType" + e);
		} finally {
			empMasterData.closeAll();
		}
		return updateCount;
	}

	public static String getAssetTypeCode(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String code = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT MAX(to_number(type_of_asset_code))+1 FROM rws_asset_type_tbl");
			empMasterData.rs.next();
			code = empMasterData.rs.getString(1);
			if (code == null) {
				code = "01";
			} else if (code.length() == 1) {
				code = "0" + code;
			}
		} catch (Exception e) {
			//System.out.println("The error in getAssetTypeCode=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	public static String getAssetTypeCode(String name, Connection conn)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String acode = null;
		try {
			empMasterData.conn=conn;
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT type_of_asset_code FROM rws_asset_type_tbl where type_of_asset_name='"
							+ name + "'");
			empMasterData.rs.next();
			acode = empMasterData.rs.getString(1);
		} catch (Exception e) {
			//System.out.println("The error in getAssetTypeCode=" + e);
		} finally {
			empMasterData.stmt.close();
			//empMasterData.closeAll();
		}
		return acode;
	}

	//***************************************************ASSET COMPONENT TYPE
	// METHODS**********************************

	public static int insertAssetCompType(EmpMaster empMaster,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps= empMasterData.conn.prepareStatement("insert into RWS_ASSET_COMPONENT_TYPE_TBL values(?,?,?)");
			ps.setString(1, empMaster.getAssetTypeCode());
			ps.setString(2,empMaster.getAssetCompTypeCode());
			ps.setString(3, empMaster.getAssetCompTypeName().toUpperCase());
			rowCount = ps.executeUpdate();
					
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			//System.out.println("The error in updateAssetCompType " + sqle);
		} catch (Exception e) {
			//System.out.println("The error in insertAssetCompType" + e);
		} finally {
			empMasterData.closeAll();
		}
		//System.out.println("rowcount in RwsMasetDate is  "+rowCount);
		return rowCount;
	}

	public static EmpMaster getAssetCompType(String assetTypeCode,
			String assetCompCode, DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from RWS_ASSET_COMPONENT_TYPE_TBL where type_of_asset_code="
							+ assetTypeCode
							+ " and asset_component_code="
							+ assetCompCode);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setAssetTypeCode(empMasterData.rs.getString(1));
				empMaster.setAssetTypeName(getAssetTypeName(empMasterData.rs.getString(1),
						empMasterData.conn));
				empMaster.setAssetCompTypeCode(empMasterData.rs.getString(2));
				empMaster.setAssetCompTypeName(empMasterData.rs.getString(3));
			}
		} catch (Exception e) {
			//System.out.println("The error in getAssetCompType" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getAssetCompTypes(String typeOfAsset,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList assetCompTypes = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			if (typeOfAsset.equals(""))
				empMasterData.rs =empMasterData.stmt
						.executeQuery("SELECT C.TYPE_OF_ASSET_CODE,T.TYPE_OF_ASSET_NAME,C.ASSET_COMPONENT_CODE,C.ASSET_COMPONENT_NAME FROM RWS_ASSET_COMPONENT_TYPE_TBL C, RWS_ASSET_TYPE_TBL T WHERE T.TYPE_OF_ASSET_CODE=C.TYPE_OF_ASSET_CODE ORDER BY C.TYPE_OF_ASSET_CODE,C.ASSET_COMPONENT_CODE");
			else
				empMasterData.rs =empMasterData.stmt
						.executeQuery("SELECT C.TYPE_OF_ASSET_CODE,T.TYPE_OF_ASSET_NAME,C.ASSET_COMPONENT_CODE,C.ASSET_COMPONENT_NAME FROM RWS_ASSET_COMPONENT_TYPE_TBL C, RWS_ASSET_TYPE_TBL T WHERE T.TYPE_OF_ASSET_CODE=C.TYPE_OF_ASSET_CODE AND C.TYPE_OF_ASSET_CODE='"
								+ typeOfAsset
								+ "' AND T.TYPE_OF_ASSET_CODE='"
								+ typeOfAsset
								+ "' ORDER BY C.TYPE_OF_ASSET_CODE,C.ASSET_COMPONENT_CODE");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setAssetTypeCode(empMasterData.rs.getString(1));
				empMaster.setAssetTypeName(empMasterData.rs.getString(2));
				empMaster.setAssetCompTypeCode(empMasterData.rs.getString(3));
				empMaster.setAssetCompTypeName(empMasterData.rs.getString(4));

				assetCompTypes.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getAssetCompTypes" + e);
		} finally {
			empMasterData.closeAll();
		}
		return assetCompTypes;
	}

	public static int removeAssetCompType(String assetTypeCode,
			String assetCompCode, DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rcount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps=empMasterData.conn.prepareStatement("delete  from RWS_ASSET_COMPONENT_TYPE_TBL where type_of_asset_code=? and asset_component_code=?");
			ps.setString(1,assetTypeCode);
			ps.setString(2, assetCompCode);
			rcount = ps.executeUpdate();
		
		} catch (Exception e) {
			//System.out.println("The error in removeAssetCompType" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rcount;
	}

	public static int updateAssetCompType(EmpMaster empMaster,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int updateCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps=empMasterData.conn.PreparedStatement();
			ps.setString(1, empMaster.getAssetCompTypeName().toUpperCase());
			ps.setString(2,  empMaster.getAssetCompTypeCode());
			ps.setString(3, empMaster.getAssetTypeCode());
			updateCount =ps .executeUpdate();
					
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			//System.out.println("The error in updateAssetCompType " + sqle);
		} catch (Exception e) {
			//System.out.println("The error in updateAssetCompType" + e);
		} finally {
			empMasterData.closeAll();
		}
		return updateCount;
	}

	public static String getAssetCompTypeCode(String assetTypeCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String code = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT MAX(to_number(asset_component_code))+1 FROM RWS_ASSET_COMPONENT_TYPE_TBL where type_of_asset_code="
							+ assetTypeCode);
			empMasterData.rs.next();
			code = empMasterData.rs.getString(1);
			//System.out.println("code in getAssetCompTypeCode =  " + code);
			if (code == null) {
				code = "01";
			} else if (code.length() == 1) {
				code = "0" + code;
			}
		} catch (Exception e) {
			//System.out.println("The error in getAssetCompTypeCode" + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	public static ArrayList getAssetCompTypeCodes(String assetTypeCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList assetCompTypes = new ArrayList();

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			if (assetTypeCode != null) {
				empMasterData.rs =empMasterData.stmt
						.executeQuery("SELECT * FROM RWS_ASSET_COMPONENT_TYPE_TBL where TYPE_OF_ASSET_CODE ='"
								+ assetTypeCode
								+ "' order by ASSET_COMPONENT_CODE");

				while (empMasterData.rs.next()) {
					empMaster = new EmpMaster();

					empMaster.setAssetCompTypeCode(empMasterData.rs
							.getString("ASSET_COMPONENT_CODE"));
					empMaster.setAssetTypeNoName(empMasterData.rs
							.getString("ASSET_COMPONENT_CODE")
							+ " - " + empMasterData.rs.getString("ASSET_COMPONENT_NAME"));
					assetCompTypes.add(empMaster);
				}
			}
		} catch (Exception e) {
			Debug
					.println("The error in getAssetCompTypeCodes EmpMasterData= "
							+ e);
		} finally {
			empMasterData.closeAll();
		}
		return assetCompTypes;
	}

	//***************************************************ASSET SUB COMPONENT
	// TYPE METHODS**********************************

	public static int insertAssetSubCompType(EmpMaster empMaster,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			
			PreparedStatement ps =empMasterData.conn.prepareStatement("insert into RWS_ASSET_SUBCOMPONENT_TBL values(?,?,?,?)");
				ps.setString(1,empMaster.getAssetTypeCode());
				ps.setString(2,empMaster.getAssetCompTypeCode());
				ps.setString(3,empMaster.getAssetSubCompTypeCode());
				ps.setString(4,empMaster.getAssetSubCompTypeName().toUpperCase());
			rowCount =ps.executeUpdate();
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println("The error in insertAssetSubCompType" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getAssetSubCompType(String assetTypeCode,
			String assetCompCode, String assetSubCompCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from RWS_ASSET_SUBCOMPONENT_TBL where type_of_asset_code='"
							+ assetTypeCode
							+ "' and asset_component_code='"
							+ assetCompCode
							+ "' and asset_subcomponent_code='"
							+ assetSubCompCode + "'");
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setAssetTypeCode(empMasterData.rs.getString(1));
				empMaster.setAssetTypeName(getAssetTypeName(empMasterData.rs.getString(1),
						empMasterData.conn));
				empMaster.setAssetCompTypeCode(empMasterData.rs.getString(2));
				empMaster.setAssetCompTypeName(getAssetCompTypeName(empMasterData.rs
						.getString(2), empMasterData.rs.getString(1), dataSource));
				empMaster.setAssetSubCompTypeCode(empMasterData.rs.getString(3));
				empMaster.setAssetSubCompTypeName(empMasterData.rs.getString(4));
			}
		} catch (Exception e) {
			//System.out.println("The error in getAssetSubCompType" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getAssetSubCompTypes(String typeOfAsset,
			String assetComp, DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList assetSubCompTypes = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			String query = null;
			if (typeOfAsset.equals("") && assetComp.equals(""))
				query = " SELECT DISTINCT S.TYPE_OF_ASSET_CODE, T.TYPE_OF_ASSET_NAME, "
						+ " S.ASSET_COMPONENT_CODE, C.ASSET_COMPONENT_NAME, "
						+ " S.ASSET_SUBCOMPONENT_CODE,S.ASSET_SUBCOMPONENT_NAME FROM "
						+ " RWS_ASSET_SUBCOMPONENT_TBL S, RWS_ASSET_COMPONENT_TYPE_TBL C,"
						+ " RWS_ASSET_TYPE_TBL T WHERE "
						+ " T.TYPE_OF_ASSET_CODE=S.TYPE_OF_ASSET_CODE "
						+ " AND S.ASSET_COMPONENT_CODE=C.ASSET_COMPONENT_CODE "
						+ " AND C.type_of_asset_code = T.type_of_asset_code "
						+ " ORDER BY S.TYPE_OF_ASSET_CODE,S.ASSET_COMPONENT_CODE,"
						+ " S.ASSET_SUBCOMPONENT_CODE ";
			else if (!typeOfAsset.equals("") && assetComp.equals(""))
				query = " SELECT DISTINCT S.TYPE_OF_ASSET_CODE, T.TYPE_OF_ASSET_NAME, "
						+ " S.ASSET_COMPONENT_CODE, C.ASSET_COMPONENT_NAME, "
						+ " S.ASSET_SUBCOMPONENT_CODE,S.ASSET_SUBCOMPONENT_NAME FROM "
						+ " RWS_ASSET_SUBCOMPONENT_TBL S, RWS_ASSET_COMPONENT_TYPE_TBL C,"
						+ " RWS_ASSET_TYPE_TBL T WHERE "
						+ " T.TYPE_OF_ASSET_CODE=S.TYPE_OF_ASSET_CODE "
						+ " AND S.ASSET_COMPONENT_CODE=C.ASSET_COMPONENT_CODE "
						+ " AND C.type_of_asset_code = T.type_of_asset_code  AND C.type_of_asset_code ='"
						+ typeOfAsset
						+ "'"
						+ " AND t.type_of_asset_code='"
						+ typeOfAsset
						+ "' ORDER BY S.TYPE_OF_ASSET_CODE,S.ASSET_COMPONENT_CODE,"
						+ " S.ASSET_SUBCOMPONENT_CODE ";
			else
				query = " SELECT DISTINCT S.TYPE_OF_ASSET_CODE, T.TYPE_OF_ASSET_NAME, "
						+ " S.ASSET_COMPONENT_CODE, C.ASSET_COMPONENT_NAME, "
						+ " S.ASSET_SUBCOMPONENT_CODE,S.ASSET_SUBCOMPONENT_NAME FROM "
						+ " RWS_ASSET_SUBCOMPONENT_TBL S, RWS_ASSET_COMPONENT_TYPE_TBL C,"
						+ " RWS_ASSET_TYPE_TBL T WHERE "
						+ " T.TYPE_OF_ASSET_CODE=S.TYPE_OF_ASSET_CODE "
						+ " AND S.ASSET_COMPONENT_CODE=C.ASSET_COMPONENT_CODE "
						+ " AND C.type_of_asset_code = T.type_of_asset_code  AND C.type_of_asset_code ='"
						+ typeOfAsset
						+ "'"
						+ " AND t.type_of_asset_code='"
						+ typeOfAsset
						+ "' AND S.ASSET_COMPONENT_CODE='"
						+ assetComp
						+ "' "
						+ "AND C.ASSET_COMPONENT_CODE='"
						+ assetComp
						+ "' ORDER BY S.TYPE_OF_ASSET_CODE,S.ASSET_COMPONENT_CODE,"
						+ " S.ASSET_SUBCOMPONENT_CODE ";
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setAssetTypeCode(empMasterData.rs.getString(1));
				empMaster.setAssetTypeName(empMasterData.rs.getString(2));
				empMaster.setAssetCompTypeCode(empMasterData.rs.getString(3));
				empMaster.setAssetCompTypeName(empMasterData.rs.getString(4));
				empMaster.setAssetSubCompTypeCode(empMasterData.rs.getString(5));
				empMaster.setAssetSubCompTypeName(empMasterData.rs.getString(6));

				assetSubCompTypes.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getAssetSubCompTypes" + e);
		} finally {
			empMasterData.closeAll();
		}
		return assetSubCompTypes;
	}

	public static int removeAssetSubCompType(String assetTypeCode,
			String assetCompCode, String assetSubCompCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rcount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			
			PreparedStatement ps = empMasterData.stmt.PreparedStatement("delete  from RWS_ASSET_SUBCOMPONENT_TBL where type_of_asset_code=? and asset_component_code=? and asset_subcomponent_code=?");
			ps.setString(1,assetTypeCode);
			ps.setString(2,assetCompCode);
			ps.setString(3,assetSubCompCode);
			rcount=ps.executeUpdate();
		} catch (Exception e) {
			//System.out.println("The error in removeAssetSubCompType" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rcount;
	}

	public static int updateAssetSubCompType(EmpMaster empMaster,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int updateCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();

			ps = empMasterData.conn
					.prepareStatement("update  RWS_ASSET_SUBCOMPONENT_TBL set asset_subcomponent_name=? where asset_subcomponent_code=? and asset_component_code=? and type_of_asset_code=?");
			ps.setString(4, empMaster.getAssetTypeCode());
			ps.setString(3, empMaster.getAssetCompTypeCode());
			ps.setString(2, empMaster.getAssetSubCompTypeCode());
			ps.setString(1, empMaster.getAssetSubCompTypeName().toUpperCase());

			updateCount = ps.executeUpdate();
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println("The error in updateAssetSubCompType" + e);
		} finally {
			empMasterData.closeAll();
		}

		return updateCount;
	}

	public static String getAssetSubCompTypeCode(String assetTypeCode,
			String assetCompType, DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String code = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT MAX(to_number(asset_subcomponent_code))+1 FROM RWS_ASSET_SUBCOMPONENT_TBL where type_of_asset_code='"
							+ assetTypeCode
							+ "' and asset_component_code='"
							+ assetCompType + "'");
			empMasterData.rs.next();
			code = empMasterData.rs.getString(1);
			if (code == null) {
				code = "001";
			} else if (code.length() == 1) {
				code = "00" + code;
			} else if (code.length() == 2) {
				code = "0" + code;
			}
		} catch (Exception e) {
			//System.out.println("The error in getAssetSubCompTypeCode" + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	//***************************************************ASSET SUB COMPONENT
	// PARAM METHODS**********************************

	public static int insertAssetSubCompParam(EmpMaster empMaster,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps=empMasterData.conn.prepareStatement("insert into RWS_SUBCOMP_PARAM_TBL values(?,?,?,?,?)");
					ps.setString(1,empMaster.getAssetTypeCode());
					ps.setString(2, empMaster.getAssetCompTypeCode());
					ps.setString(3, empMaster.getAssetSubCompTypeCode());
					ps.setString(4,empMaster.getDimension() ));
			        ps.setString(5,empMaster.getUom());
			        rowCount = ps.executeUpdate();
		} catch (Exception e) {
			//System.out.println("The error in insertAssetSubCompParam" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getAssetSubCompParam(String assetTypeCode,
			String assetCompCode, String assetSubCompCode, String measurment,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from RWS_SUBCOMP_PARAM_TBL where type_of_asset_code='"
							+ assetTypeCode
							+ "' and asset_component_code='"
							+ assetCompCode
							+ "' and asset_subcomponent_code='"
							+ assetSubCompCode
							+ "' and MEASUREMENT_TYPE='"
							+ measurment + "'");
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setAssetTypeCode(empMasterData.rs.getString(1));
				empMaster.setAssetTypeName(getAssetTypeName(empMasterData.rs.getString(1),
						empMasterData.conn));
				empMaster.setAssetCompTypeCode(empMasterData.rs.getString(2));
				empMaster.setAssetCompTypeName(getAssetCompTypeName(empMasterData.rs
						.getString(2), empMasterData.rs.getString(1), dataSource));
				empMaster.setAssetSubCompTypeCode(empMasterData.rs.getString(3));
				empMaster.setAssetSubCompTypeName(getAssetSubCompTypeName(empMasterData.rs
						.getString(3), empMasterData.rs.getString(2), empMasterData.rs.getString(1), empMasterData.conn));
				empMaster.setDimension(empMasterData.rs.getString(4));
				empMaster.setUom(empMasterData.rs.getString(5));
			}
		} catch (Exception e) {
			//System.out.println("The error in getAssetSubCompParam" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getAssetSubCompParmas(String typeOfAsset,
			String assetComp, String assetSubComp, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList assetSubCompTypes = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			if (typeOfAsset.equals("") && assetComp.equals("")
					&& assetSubComp.equals(""))
				empMasterData.rs =empMasterData.stmt
						.executeQuery("SELECT P.TYPE_OF_ASSET_CODE,T.TYPE_OF_ASSET_NAME,"
								+ "P.ASSET_COMPONENT_CODE,C.ASSET_COMPONENT_NAME,"
								+ "P.ASSET_SUBCOMPONENT_CODE,S.ASSET_SUBCOMPONENT_NAME,"
								+ "P.MEASUREMENT_TYPE,P.MEASUREMENT_UNIT "
								+ "FROM RWS_ASSET_SUBCOMPONENT_TBL S,RWS_ASSET_COMPONENT_TYPE_TBL C,"
								+ " RWS_ASSET_TYPE_TBL T,RWS_SUBCOMP_PARAM_TBL P WHERE "
								+ "P.TYPE_OF_ASSET_CODE=T.TYPE_OF_ASSET_CODE AND "
								+ "P.ASSET_COMPONENT_CODE=C.ASSET_COMPONENT_CODE AND "
								+ "P.ASSET_SUBCOMPONENT_CODE=S.ASSET_SUBCOMPONENT_CODE AND "
								+ "S.TYPE_OF_ASSET_CODE=T.TYPE_OF_ASSET_CODE AND "
								+ "S.ASSET_COMPONENT_CODE=C.ASSET_COMPONENT_CODE AND "
								+ "C.TYPE_OF_ASSET_CODE=T.TYPE_OF_ASSET_CODE "
								+ "ORDER BY P.TYPE_OF_ASSET_CODE,P.ASSET_COMPONENT_CODE,"
								+ "P.ASSET_SUBCOMPONENT_CODE");
			else if (!typeOfAsset.equals("") && assetComp.equals("")
					&& assetSubComp.equals(""))
				empMasterData.rs =empMasterData.stmt
						.executeQuery("SELECT P.TYPE_OF_ASSET_CODE,T.TYPE_OF_ASSET_NAME,"
								+ "P.ASSET_COMPONENT_CODE,C.ASSET_COMPONENT_NAME,"
								+ "P.ASSET_SUBCOMPONENT_CODE,S.ASSET_SUBCOMPONENT_NAME,"
								+ "P.MEASUREMENT_TYPE,P.MEASUREMENT_UNIT "
								+ "FROM RWS_ASSET_SUBCOMPONENT_TBL S,RWS_ASSET_COMPONENT_TYPE_TBL C,"
								+ " RWS_ASSET_TYPE_TBL T,RWS_SUBCOMP_PARAM_TBL P WHERE "
								+ "P.TYPE_OF_ASSET_CODE=T.TYPE_OF_ASSET_CODE AND "
								+ "P.ASSET_COMPONENT_CODE=C.ASSET_COMPONENT_CODE AND "
								+ "P.ASSET_SUBCOMPONENT_CODE=S.ASSET_SUBCOMPONENT_CODE AND "
								+ "S.TYPE_OF_ASSET_CODE=T.TYPE_OF_ASSET_CODE AND "
								+ "S.ASSET_COMPONENT_CODE=C.ASSET_COMPONENT_CODE AND "
								+ "C.TYPE_OF_ASSET_CODE=T.TYPE_OF_ASSET_CODE AND S.TYPE_OF_ASSET_CODE='"
								+ typeOfAsset
								+ "'"
								+ " AND T.TYPE_OF_ASSET_CODE='"
								+ typeOfAsset
								+ "' AND C.TYPE_OF_ASSET_CODE='"
								+ typeOfAsset
								+ "'"
								+ " ORDER BY P.TYPE_OF_ASSET_CODE,P.ASSET_COMPONENT_CODE,"
								+ "P.ASSET_SUBCOMPONENT_CODE");
			else if (!typeOfAsset.equals("") && !assetComp.equals("")
					&& assetSubComp.equals(""))
				empMasterData.rs =empMasterData.stmt
						.executeQuery("SELECT P.TYPE_OF_ASSET_CODE,T.TYPE_OF_ASSET_NAME,"
								+ "P.ASSET_COMPONENT_CODE,C.ASSET_COMPONENT_NAME,"
								+ "P.ASSET_SUBCOMPONENT_CODE,S.ASSET_SUBCOMPONENT_NAME,"
								+ "P.MEASUREMENT_TYPE,P.MEASUREMENT_UNIT "
								+ "FROM RWS_ASSET_SUBCOMPONENT_TBL S,RWS_ASSET_COMPONENT_TYPE_TBL C,"
								+ " RWS_ASSET_TYPE_TBL T,RWS_SUBCOMP_PARAM_TBL P WHERE "
								+ "P.TYPE_OF_ASSET_CODE=T.TYPE_OF_ASSET_CODE AND "
								+ "P.ASSET_COMPONENT_CODE=C.ASSET_COMPONENT_CODE AND "
								+ "P.ASSET_SUBCOMPONENT_CODE=S.ASSET_SUBCOMPONENT_CODE AND "
								+ "S.TYPE_OF_ASSET_CODE=T.TYPE_OF_ASSET_CODE AND "
								+ "S.ASSET_COMPONENT_CODE=C.ASSET_COMPONENT_CODE AND "
								+ "C.TYPE_OF_ASSET_CODE=T.TYPE_OF_ASSET_CODE AND S.TYPE_OF_ASSET_CODE='"
								+ typeOfAsset
								+ "'"
								+ " AND T.TYPE_OF_ASSET_CODE='"
								+ typeOfAsset
								+ "' AND C.TYPE_OF_ASSET_CODE='"
								+ typeOfAsset
								+ "'"
								+ " AND P.ASSET_COMPONENT_CODE='"
								+ assetComp
								+ "' AND C.ASSET_COMPONENT_CODE='"
								+ assetComp
								+ "' AND S.ASSET_COMPONENT_CODE='"
								+ assetComp
								+ "'"
								+ "ORDER BY P.TYPE_OF_ASSET_CODE,P.ASSET_COMPONENT_CODE,"
								+ "P.ASSET_SUBCOMPONENT_CODE");
			else if (!typeOfAsset.equals("") && !assetComp.equals("")
					&& !assetSubComp.equals(""))
				empMasterData.rs =empMasterData.stmt
						.executeQuery("SELECT P.TYPE_OF_ASSET_CODE,T.TYPE_OF_ASSET_NAME,"
								+ "P.ASSET_COMPONENT_CODE,C.ASSET_COMPONENT_NAME,"
								+ "P.ASSET_SUBCOMPONENT_CODE,S.ASSET_SUBCOMPONENT_NAME,"
								+ "P.MEASUREMENT_TYPE,P.MEASUREMENT_UNIT "
								+ "FROM RWS_ASSET_SUBCOMPONENT_TBL S,RWS_ASSET_COMPONENT_TYPE_TBL C,"
								+ " RWS_ASSET_TYPE_TBL T,RWS_SUBCOMP_PARAM_TBL P WHERE "
								+ "P.TYPE_OF_ASSET_CODE=T.TYPE_OF_ASSET_CODE AND "
								+ "P.ASSET_COMPONENT_CODE=C.ASSET_COMPONENT_CODE AND "
								+ "P.ASSET_SUBCOMPONENT_CODE=S.ASSET_SUBCOMPONENT_CODE AND "
								+ "S.TYPE_OF_ASSET_CODE=T.TYPE_OF_ASSET_CODE AND "
								+ "S.ASSET_COMPONENT_CODE=C.ASSET_COMPONENT_CODE AND "
								+ "C.TYPE_OF_ASSET_CODE=T.TYPE_OF_ASSET_CODE AND S.TYPE_OF_ASSET_CODE='"
								+ typeOfAsset
								+ "'"
								+ " AND T.TYPE_OF_ASSET_CODE='"
								+ typeOfAsset
								+ "' AND C.TYPE_OF_ASSET_CODE='"
								+ typeOfAsset
								+ "'"
								+ " AND P.ASSET_COMPONENT_CODE='"
								+ assetComp
								+ "' AND C.ASSET_COMPONENT_CODE='"
								+ assetComp
								+ "' AND S.ASSET_COMPONENT_CODE='"
								+ assetComp
								+ "'"
								+ " AND S.ASSET_SUBCOMPONENT_CODE='"
								+ assetSubComp
								+ "' AND P.ASSET_SUBCOMPONENT_CODE='"
								+ assetSubComp
								+ "'"
								+ " ORDER BY P.TYPE_OF_ASSET_CODE,P.ASSET_COMPONENT_CODE,"
								+ "P.ASSET_SUBCOMPONENT_CODE");

			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setAssetTypeCode(empMasterData.rs.getString(1));
				empMaster.setAssetTypeName(empMasterData.rs.getString(2));
				empMaster.setAssetCompTypeCode(empMasterData.rs.getString(3));
				empMaster.setAssetCompTypeName(empMasterData.rs.getString(4));
				empMaster.setAssetSubCompTypeCode(empMasterData.rs.getString(5));
				empMaster.setAssetSubCompTypeName(empMasterData.rs.getString(6));
				empMaster.setDimension(empMasterData.rs.getString(7));
				empMaster.setUom(empMasterData.rs.getString(8));

				assetSubCompTypes.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getAssetSubCompParmas" + e);
		} finally {
			empMasterData.closeAll();
		}
		return assetSubCompTypes;
	}

	/*
	 * public static int removeAssetSubCompParam(String assetTypeCode, String
	 * assetCompCode, String assetSubCompCode, String dimension, DataSource
	 * dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData(); int rcount = 0; try {
	 * //System.out.println("assettypecode=" + assetTypeCode);
	 * //System.out.println("assetCompCode=" + assetCompCode);
	 * //System.out.println("assetSubCompCode=" + assetSubCompCode); empMasterData.conn =
	 * dataSource.getConnection(); empMasterData.stmt = empMasterData.conn.createStatement(); rcount = empMasterData.stmt
	 * .executeUpdate("delete from RWS_SUBCOMP_PARAM_TBL where
	 * type_of_asset_code='" + assetTypeCode + "' and asset_component_code='" +
	 * assetCompCode + "' and asset_subcomponent_code='" + assetSubCompCode + "'
	 * and MEASUREMENT_TYPE='" + dimension + "'"); //System.out.println("rcount=" +
	 * rcount); } catch (Exception e) { //System.out.println("The error in
	 * removeAssetSubCompParam" + e); } finally { empMasterData.closeAll(); } return rcount; }
	 */
	public static int removeAssetSubCompParam(String assetTypeCode,
			String assetCompCode, String assetSubCompCode, String dimension,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rcount = 0;
		try {
			//System.out.println("assettypecode=" + assetTypeCode);
			//System.out.println("assetCompCode=" + assetCompCode);
			//System.out.println("assetSubCompCode=" + assetSubCompCode);
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
		   PreparedStatement ps=empMasterData.conn.prepareStatement("delete from RWS_SUBCOMP_PARAM_TBL where type_of_asset_code=?,and asset_component_code=? and asset_subcomponent_code=? and MEASUREMENT_TYPE=?");
			ps.setString(1,assetTypeCode);
			ps.setString(2,assetCompCode);
			ps.setString(3,assetSubCompCode);
			ps.setString(4,dimension);
			rcount=ps.executeUpdate();
			//System.out.println("rcount=" + rcount);
		} catch (Exception e) {
			//System.out.println("The error in removeAssetSubCompParam" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rcount;
	}

	public static void updateAssetSubCompParam(EmpMaster empMaster,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		try {
			empMasterData.conn = dataSource.getConnection();

			ps = empMasterData.conn
					.prepareStatement("update RWS_SUBCOMP_PARAM_TBL set measurement_type=?,measurement_unit=? where asset_subcomponent_code=? and asset_component_code=? and type_of_asset_code=?");
			ps.setString(5, empMaster.getAssetTypeCode());
			ps.setString(4, empMaster.getAssetCompTypeCode());
			ps.setString(3, empMaster.getAssetSubCompTypeCode());
			ps.setString(2, empMaster.getUom());
			ps.setString(1, empMaster.getDimension());

			ps.executeUpdate();
		} catch (Exception e) {
			//System.out.println("The error in updateAssetSubCompParam" + e);
		} finally {
			empMasterData.closeAll();
		}
	}

	//*************************************ASSET METHODS*********************

	public static int[] insertAsset(EmpMaster empMaster, ArrayList habs,
			ArrayList sources, ArrayList headworks, ArrayList pipeline,
			ArrayList reservior, String opType, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		PanchRaj panchRaj = new PanchRaj();
		Asset_SubComponent assetSources = new Asset_SubComponent();
		Asset_HeadWorks assetHeadworks = new Asset_HeadWorks();
		Asset_PipeLine assetPipeline = new Asset_PipeLine();
		Asset_Reservior assetReservior = new Asset_Reservior();
		int[] rowCount = new int[50];
		String habCode = "";
		String assetTypeCode = "";
		String assetCompTypeCode = "";
		String assetSubCompTypeCode = "";
		String query1 = "", query = "";
		String schemeCode = "";

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.conn.setAutoCommit(false);
			empMasterData.stmt = empMasterData.conn.createStatement();
			if (opType.equals("Modify")) {
				query = "update RWS_ASSET_MAST_TBL set ASSET_NAME='"
						+ empMaster.getAssetName().toUpperCase()
						+ "',LOCATION='"
						+ empMaster.getLocation().toUpperCase()
						+ "',DATE_CREATION=TO_DATE('"
						+ empMaster.getDateofCreation()
						+ "','dd/mm/yyyy'),ASSET_COST ="
						+ empMaster.getAssetCost() + ",START_YEAR='"
						+ empMaster.getStartYear() + "',END_YEAR='"
						+ empMaster.getEndYear() + "',ASSET_STATUS="
						+ empMaster.getAssetStatus() + " where asset_code='"
						+ empMaster.getAssetCode() + "'";
				//System.out.println("update asset query=" + query);
				empMasterData.stmt.addBatch(query);
				habCode = empMaster.getHabCode();
				//System.out.println("habCode=" + habCode + "hab size="
						+ habs.size());
				query = "delete from RWS_ASSET_HAB_TBL where asset_code='"
						+ empMaster.getAssetCode() + "'";
				//System.out.println("delete assethab query=" + query);
				empMasterData.stmt.addBatch(query);

				for (int i = 0; i < habs.size(); i++) {
					panchRaj = (PanchRaj) habs.get(i);
					if (panchRaj.getHabCode() != null) {
						//if (panchRaj.getHabCode().equals(habCode))
							//System.out.println("habCode in equal=" + habCode);
						//else {
							query = "insert into RWS_ASSET_HAB_TBL values('"
									+ empMaster.getAssetCode() + "','"
									+ panchRaj.getHabCode() + "')";
							//System.out.println("query=" + query);
							empMasterData.stmt.addBatch(query);
						//}
					}
				}
				
				/*
				 * for (int i=0;i <sources.size();i++) { assetSources =
				 * (Asset_SubComponent)sources.get(i);
				 * if(assetTypeCode.equals("04") &&
				 * assetCompTypeCode.equals("01") &&
				 * assetSubCompTypeCode.equals("001")) query1="update
				 * RWS_HP_SUBCOMP_PARAM_TBL set
				 * DRILL_YEAR='"+assetSources.getYearOfDrilling()+"',DIAMETER="+assetSources.getDiameter()+",CASING='"+assetSources.getCasing()+
				 * "',STATUS='"+assetSources.getStatus()+"',GEN_CONDITION='"+assetSources.getGenCondition()+"',GI_NO="+assetSources.getGino()+",PAINTED='"+assetSources.getPainted()+"',STATIC_WL
				 * ="+assetSources.getStaticWaterLevel()+ ",SUMMER_WL
				 * ="+assetSources.getSummerWaterLevel()+",P_COND='"+assetSources.getPcond()+"',DRY_DURING="+assetSources.getDryduring()+",SERVICE='"+assetSources.getService()+"',SER_NO="+assetSources.getSerno()+
				 * ",SER_HRS
				 * ="+assetSources.getSerhrs()+",REPAIRS='"+assetSources.getRepairs()+"',PLATFORM_CONDITION='"+assetSources.getPlatformCondition()+"',DRAIN='"+assetSources.getDrain()+"',DRAIN_CONDITION='"+assetSources.getDrainCondition()+
				 * "',DRAIN_SD='"+assetSources.getDrainsd()+"',DRAIN_LP='"+assetSources.getDrainlp()+"',HYGIENE='"+assetSources.getHygiene()+"',AVG_TIME="+assetSources.getAvgtime()+",P_YEILD="+assetSources.getPyield()+",PYEILD_LOCAL='"+assetSources.getPyieldLocal()+
				 * "',PERIOD='"+assetSources.getPeriod()+"' where
				 * ASSET_CODE='"+empMaster.getAssetCode()+"'"; //else
				 * if(assetTypeCode.equals("01") &&
				 * assetCompTypeCode.equals("04") &&
				 * assetSubCompTypeCode.equals("003")) // query1="update
				 * RWS_PWS_GLSR_SC_PARAM_TBL set
				 * GLSR_NO="+assetSources.getGlsrNo()+",GLSR_LOC='"+assetSources.getGlsrLocation()+"',GLSR_CAP_LTS="+assetSources.getGlsrCapacityInLts()+",GLSR_MADE='"+assetSources.getGlsrMade()+"',GLSR_COND='"+assetSources.getGlsrCondition()+ //
				 * "',GLSR_FILL_HRS="+assetSources.getGlsrFillHrs()+",GLSR_EMPTY_HRS="+assetSources.getGlsrEmptyHrs()+",GLSR_DRA_COND='"+assetSources.getGlsrDraCondition()+"',GLSR_HYG='"+assetSources.getGlsrHygiene()+"'
				 * where ASSET_CODE='"+empMaster.getAssetCode()+"'";
				 * 
				 * else if(assetTypeCode.equals("01") &&
				 * assetCompTypeCode.equals("01") &&
				 * assetSubCompTypeCode.equals("001")) query1="update
				 * RWS_PWS_SUBCOMP_PARAM_TBL set
				 * POP_DES="+assetSources.getPopDes()+",SOURCE
				 * ='"+assetSources.getSource()+"',SOUR_QLTY='"+assetSources.getSourceQuality()+"',SOUR_YEILD="+assetSources.getSourceYield()+",SOUR_DEPEN='"+assetSources.getSourceDepend()+"',SOUR_DEPTH="+assetSources.getSourceDepth()+
				 * ",SOUR_DIAMETER
				 * ="+assetSources.getSourceDiameter()+",SOUR_COND='"+assetSources.getSourceCondition()+"',SOUR_SWL
				 * ="+assetSources.getSourceSwl()+",SOUR_NWL="+assetSources.getSourceNwl()+
				 * ",PH_SIZE='"+assetSources.getPhSize()+"',PH_COND='"+assetSources.getPhCondition()+"',PH_TYPE='"+assetSources.getPhType()+"',PUMP_NAME
				 * ='"+assetSources.getPumpName()+"',PUMP_CPTY="+assetSources.getPumpCapacity()+
				 * ",PUMP_TYPE='"+assetSources.getPumpType()+"',YEAR_PUR="+assetSources.getPurYear()+",HR_RUN="+assetSources.getHrRun()+",HR_SIN="+assetSources.getHrSin()+",HR_MS
				 * ="+assetSources.getHrMs()+",STA_EXE='"+assetSources.getStaExe()+"',PUMP_DUTY_LPM="+assetSources.getPumpDutyLpm()+",PUMP_DUTY_HEAD="+assetSources.getPumpDutyHead()+ "
				 * where ASSET_CODE='"+empMaster.getAssetCode()+"'";
				 * //System.out.println("query1="+query1);
				 * 
				 * empMasterData.stmt.addBatch(query1); }
				 * 
				 * for (int i=0;i <pipeline.size();i++) { assetPipeline =
				 * (Asset_PipeLine)pipeline.get(i); String query3="update
				 * RWS_ASSET_SUBCOMP_PARAM_TBL set
				 * type='"+assetPipeline.getType()+"',class='"+assetPipeline.getPclass()+"',diameter='"+assetPipeline.getDiameter()+"',length='"+assetPipeline.getLength()+"',valves='"+assetPipeline.getValves()+"',PUBLIC_POSTS='"+assetPipeline.getPublicStandPosts()+"',HOUSE_CONN='"+assetPipeline.getHouseConnections()+"'
				 * where asset_code='"+empMaster.getAssetCode()+"' and
				 * ASSET_SUBCOMPONENT_CODE='"+getAssetSubCompCode(getAssetTypeCode(empMaster.getAssetTypeCode(),empMasterData.conn),"03",assetPipeline.getAssetSubComp(),empMasterData.conn)+"'
				 * and ASSET_COMPONENT_CODE='03'";
				 * 
				 * empMasterData.stmt.addBatch(query3); } for (int i=0;i
				 * <reservior.size();i++) { assetReservior =
				 * (Asset_Reservior)reservior.get(i);
				 * if(assetTypeCode.equals("01") &&
				 * assetCompTypeCode.equals("04") &&
				 * assetSubCompTypeCode.equals("001")) query1="update
				 * RWS_PWS_OHSR_SC_PARAM_TBL set
				 * OHSR_NO="+assetReservior.getOhsrNo()+",OHSR_LTS
				 * ="+assetReservior.getOhrsLts()+",OHSR_LOCATION
				 * ='"+assetReservior.getOhsrLocation()+"',OHSR_CAP_LTS="+assetReservior.getOhsrCapacityLts()+",OHSR_MADE='"+assetReservior.getOhsrMade()+"',OHSR_HT
				 * ="+assetReservior.getOhsrHt()+",OHSR_COND='"+assetReservior.getOhsrCond()+"',OHSR_FILL_HRS
				 * ="+assetReservior.getOhsrFillHrs()+",OHSR_EMPTY="+assetReservior.getOhsrEmptyHrs()+",OHSR_HYG='"+assetReservior.getOhsrHygiene()+"',OHSR_FEN='"+assetReservior.getOhsrFen()+"'";
				 * else if(assetTypeCode.equals("03") &&
				 * assetCompTypeCode.equals("04") &&
				 * assetSubCompTypeCode.equals("001")) query1="update
				 * RWS_CPWS_OHSR_SC_PARAM_TBL set
				 * OHSR_CODE='"+assetReservior.getOhsrCode()+"',OHSR_CAP_LTS
				 * ="+assetReservior.getOhsrCapacityLts()+",OHSR_LOC
				 * ='"+assetReservior.getOhsrLocation()+"',OHSR_SATGES
				 * ="+assetReservior.getOhsrStages()+",OHSR_LWL="+assetReservior.getOhsrLwl()+",OHSR_MWL
				 * ="+assetReservior.getOhsrMwl()+",OHSR_FILL_HR
				 * ="+assetReservior.getOhsrFillHrs()+",OHSR_EMPTY_HR="+assetReservior.getOhsrEmptyHrs()+"";
				 * else if(assetTypeCode.equals("03") &&
				 * assetCompTypeCode.equals("04") &&
				 * assetSubCompTypeCode.equals("002")) query1="update
				 * RWS_CPWS_OHBR_SC_PARAM_TBL set
				 * OHBR_CODE='"+assetReservior.getOhbrCode()+"',OHBR_CAP_LTS
				 * ="+assetReservior.getOhbrCapacityLts()+",OHBR_LOC
				 * ='"+assetReservior.getOhbrLocation()+"',OHBR_SATGES
				 * ="+assetReservior.getOhbrStages()+",OHBR_LWL="+assetReservior.getOhbrLwl()+",OHBR_MWL
				 * ="+assetReservior.getOhbrMwl()+",OHBR_FILL_HR
				 * ="+assetReservior.getOhbrFillHrs()+",OHBR_EMPTY_HR="+assetReservior.getOhbrEmptyHrs()+"";
				 * else if(assetTypeCode.equals("03") &&
				 * assetCompTypeCode.equals("04") &&
				 * assetSubCompTypeCode.equals("003")) query1="update
				 * RWS_CPWS_GLSR_SC_PARAM_TBL set
				 * GLSR_CODE='"+assetReservior.getGlsrCode()+"',GLSR_CAP_LTS
				 * ="+assetReservior.getGlsrCapacityInLts()+",GLSR_LOC
				 * ='"+assetReservior.getGlsrLocation()+"',GLSR_SATGES
				 * ="+assetReservior.getGlsrStages()+",GLSR_LWL
				 * ="+assetReservior.getGlsrLwl()+",GLSR_MWL
				 * ="+assetReservior.getGlsrMwl()+",GLSR_FILL_HR
				 * ="+assetReservior.getGlsrFillHrs()+",GLSR_EMPTY_HR="+assetReservior.getGlsrEmptyHrs()+"";
				 * else if(assetTypeCode.equals("03") &&
				 * assetCompTypeCode.equals("04") &&
				 * assetSubCompTypeCode.equals("004")) query1="update
				 * RWS_CPWS_GLBR_SC_PARAM_TBL set
				 * GLBR_CODE='"+assetReservior.getGlbrCode()+"',GLBR_CAP_LTS
				 * ="+assetReservior.getGlbrCapacityInLts()+",GLBR_LOC
				 * ='"+assetReservior.getGlbrLocation()+"',GLBR_LWL
				 * ="+assetReservior.getGlbrLwl()+",GLBR_MWL
				 * ="+assetReservior.getGlbrMwl()+",GLBR_FILL_HR
				 * ="+assetReservior.getGlbrFillHrs()+",GLBR_EMPTY_HR="+assetReservior.getGlbrEmptyHrs()+"";
				 * //System.out.println("query1="+query1); empMasterData.stmt.addBatch(query1); }
				 */

			}
			
			  if(opType.equals("Add New")) {
			  	query="select hab_code from	 RWS_ASSET_MAST_TBL where  asset_code='"+empMaster.getAssetCode()+"'";
			  empMasterData.stmt=empMasterData.conn.createStatement(); 
			  empMasterData.rs=empMasterData.stmt.executeQuery(query);
			  if(empMasterData.rs.next()) habCode=empMasterData.rs.getString(1);
			  schemeCode=empMaster.getHabCode()+empMaster.getPumpCode();
			  assetTypeCode=empMaster.getAssetTypeCode();
			  assetCompTypeCode=empMaster.getAssetCompTypeCode();
			  assetSubCompTypeCode=empMaster.getAssetSubCompTypeCode();
			  //System.out.println("query= "+query+"Scheme Code= "+schemeCode+"habCode="+habCode+"asset type="+assetTypeCode+"assetComptype="+assetCompTypeCode+"assetSubcompType="+assetSubCompTypeCode);
			  query="insert into RWS_ASSET_MAST_TBL values('"+empMaster.getAssetCode()+"','"+empMaster.getAssetName().toUpperCase()+"','"+empMaster.getAssetTypeCode()+"','"+empMaster.getHabCode()+"','"+empMaster.getLocation().toUpperCase()+"',TO_DATE('"+empMaster.getDateofCreation()+"','dd/mm/yyyy'),"+"nvl('"+empMaster.getAssetStatus()+"','')"+",nvl('"+empMaster.getAssetCost()+"',''),'"+empMaster.getStartYear()+"','"+empMaster.getEndYear()+"','"+empMaster.getCoc()+"',nvl('"+empMaster.getDoc()+"',''),'"+empMaster.getSdoc()+"')";
			  //System.out.println("query= "+query); 
			  empMasterData.stmt.addBatch(query);
			  query="insert into RWS_ASSET_SCHEME_TBL  values('"+empMaster.getAssetCode()+"','"+schemeCode+"')";
			  //System.out.println("query= "+query); empMasterData.stmt.addBatch(query);
			 
			  habCode = empMaster.getHabCode();
				//System.out.println("habCode=" + habCode + "hab size="
						+ habs.size());
				query = "delete from RWS_ASSET_HAB_TBL where asset_code='"
						+ empMaster.getAssetCode() + "'";
				//System.out.println("delete assethab query=" + query);
				empMasterData.stmt.addBatch(query);
				
			  if(habs!=null) for (int i=0;i <habs.size();i++)
			  {
				  	panchRaj = (PanchRaj)habs.get(i); 
				  	if(panchRaj.getHabCode() != null) 
				  	{
					  		if(!assetTypeCode.equals("04"))
					  		{
						  		query="insert into RWS_ASSET_HAB_TBL values('"+empMaster.getAssetCode()+"','"+panchRaj.getHabCode()+"')";
						  		empMasterData.stmt.addBatch(query); 
					  		}
				  	}
			  	}
			/*  if(sources!=null) for (int i=0;i <sources.size();i++) {
			  assetSources = (Asset_SubComponent)sources.get(i);
			  if(assetTypeCode.equals("04") && assetCompTypeCode.equals("01") &&
			  assetSubCompTypeCode.equals("001")) query1="insert into
			  RWS_HP_SUBCOMP_PARAM_TBL
			  values('"+empMaster.getAssetCode()+"','"+assetSources.getYearOfDrilling()+"',"+assetSources.getDiameter()+",'"+assetSources.getCasing()+
			  "','"+assetSources.getStatus()+"','"+assetSources.getGenCondition()+"',"+assetSources.getGino()+",'"+assetSources.getPainted()+"',"+assetSources.getStaticWaterLevel()+
			  ","+assetSources.getSummerWaterLevel()+",'"+assetSources.getPcond()+"',"+assetSources.getDryduring()+",'"+assetSources.getService()+"',"+assetSources.getSerno()+
			 * ","+assetSources.getSerhrs()+",'"+assetSources.getRepairs()+"','"+assetSources.getPlatformCondition()+"','"+assetSources.getDrain()+"','"+assetSources.getDrainCondition()+
			 * "','"+assetSources.getDrainsd()+"','"+assetSources.getDrainlp()+"','"+assetSources.getHygiene()+"',"+assetSources.getAvgtime()+","+assetSources.getPyield()+",'"+assetSources.getPyieldLocal()+
			 * "','"+assetSources.getPeriod()+"')"; //else
			 * if(assetTypeCode.equals("01") && assetCompTypeCode.equals("04") &&
			 * assetSubCompTypeCode.equals("003"))
			 * 
			 * else if(assetTypeCode.equals("01") &&
			 * assetCompTypeCode.equals("01") &&
			 * assetSubCompTypeCode.equals("001")) query1="insert into
			 * RWS_PWS_SUBCOMP_PARAM_TBL
			 * values('"+empMaster.getAssetCode()+"',"+assetSources.getPopDes()+",'"+assetSources.getSource()+"','"+assetSources.getSourceQuality()+"',"+assetSources.getSourceYield()+",'"+assetSources.getSourceDepend()+"',"+assetSources.getSourceDepth()+
			 * ","+assetSources.getSourceDiameter()+",'"+assetSources.getSourceCondition()+"',"+assetSources.getSourceSwl()+","+assetSources.getSourceNwl()+
			 * ",'"+assetSources.getPhSize()+"','"+assetSources.getPhCondition()+"','"+assetSources.getPhType()+"','"+assetSources.getPumpName()+"',"+assetSources.getPumpCapacity()+
			 * ",'"+assetSources.getPumpType()+"',"+assetSources.getPurYear()+","+assetSources.getHrRun()+","+assetSources.getHrSin()+","+assetSources.getHrMs()+",'"+assetSources.getStaExe()+"',"+assetSources.getPumpDutyLpm()+","+assetSources.getPumpDutyHead()+")";
			 * //System.out.println("query1="+query1); empMasterData.stmt.addBatch(query1); }
			 * if(reservior!=null) for (int i=0;i <reservior.size();i++) {
			 * assetReservior = (Asset_Reservior)reservior.get(i);
			 * if(assetTypeCode.equals("01") && assetCompTypeCode.equals("04") &&
			 * assetSubCompTypeCode.equals("001")) query1="insert into
			 * RWS_PWS_OHSR_SC_PARAM_TBL
			 * values('"+empMaster.getAssetCode()+"',"+assetReservior.getOhsrNo()+","+assetReservior.getOhrsLts()+",'"+assetReservior.getOhsrLocation()+"',"+assetReservior.getOhsrCapacityLts()+",'"+assetReservior.getOhsrMade()+"',"+assetReservior.getOhsrHt()+",'"+assetReservior.getOhsrCond()+"',"+assetReservior.getOhsrFillHrs()+","+assetReservior.getOhsrEmptyHrs()+",'"+assetReservior.getOhsrHygiene()+"','"+assetReservior.getOhsrFen()+"')";
			 * else if(assetTypeCode.equals("03") &&
			 * assetCompTypeCode.equals("04") &&
			 * assetSubCompTypeCode.equals("001")) query1="insert into
			 * RWS_CPWS_OHSR_SC_PARAM_TBL
			 * values('"+empMaster.getAssetCode()+"','"+assetReservior.getOhsrCode()+"',"+assetReservior.getOhsrCapacityLts()+",'"+assetReservior.getOhsrLocation()+"',"+assetReservior.getOhsrStages()+","+assetReservior.getOhsrLwl()+","+assetReservior.getOhsrMwl()+","+assetReservior.getOhsrFillHrs()+","+assetReservior.getOhsrEmptyHrs()+")";
			 * else if(assetTypeCode.equals("03") &&
			 * assetCompTypeCode.equals("04") &&
			 * assetSubCompTypeCode.equals("002")) query1="insert into
			 * RWS_CPWS_OHBR_SC_PARAM_TBL
			 * values('"+empMaster.getAssetCode()+"','"+assetReservior.getOhbrCode()+"',"+assetReservior.getOhbrCapacityLts()+",'"+assetReservior.getOhbrLocation()+"',"+assetReservior.getOhbrStages()+","+assetReservior.getOhbrLwl()+","+assetReservior.getOhbrMwl()+","+assetReservior.getOhbrFillHrs()+","+assetReservior.getOhbrEmptyHrs()+")";
			 * else if(assetTypeCode.equals("03") &&
			 * assetCompTypeCode.equals("04") &&
			 * assetSubCompTypeCode.equals("003")) query1="insert into
			 * RWS_CPWS_GLSR_SC_PARAM_TBL
			 * values('"+empMaster.getAssetCode()+"','"+assetReservior.getGlsrCode()+"',"+assetReservior.getGlsrCapacityInLts()
			 * +",'"+assetReservior.getGlsrLocation()+"',"+assetReservior.getGlsrStages()+","+assetReservior.getGlsrLwl()+","+assetReservior.getGlsrMwl()+","+assetReservior.getGlsrFillHrs()+","+assetReservior.getGlsrEmptyHrs()+")";
			 * else if(assetTypeCode.equals("03") &&
			 * assetCompTypeCode.equals("04") &&
			 * assetSubCompTypeCode.equals("004")) query1="insert into
			 * RWS_CPWS_GLBR_SC_PARAM_TBL
			 * values('"+empMaster.getAssetCode()+"','"+assetReservior.getGlbrCode()+"',"+assetReservior.getGlbrCapacityInLts()
			 * +",'"+assetReservior.getGlbrLocation()+"',"+assetReservior.getGlbrLwl()+","+assetReservior.getGlbrMwl()+","+assetReservior.getGlbrFillHrs()+","+assetReservior.getGlbrEmptyHrs()+")";
			 * 
			 * //System.out.println("query1= "+query1); empMasterData.stmt.addBatch(query1); }
			 * if(pipeline!=null) for (int i=0;i <pipeline.size();i++) {
			 * assetPipeline = (Asset_PipeLine)pipeline.get(i); String
			 * query3="insert into RWS_ASSET_SUBCOMP_PARAM_TBL
			 * (asset_code,ASSET_COMPONENT_CODE,ASSET_SUBCOMPONENT_CODE,type,class,diameter,length,valves,PUBLIC_POSTS,HOUSE_CONN)
			 * values
			 * ('"+empMaster.getAssetCode()+"','03','"+getAssetSubCompCode(empMaster.getAssetTypeCode(),"03",assetPipeline.getAssetSubComp(),empMasterData.conn)+"','"+assetPipeline.getType()+"','"+assetPipeline.getPclass()+"','"+assetPipeline.getDiameter()+"','"+assetPipeline.getLength()+"','"+assetPipeline.getValves()+"','"+assetPipeline.getPublicStandPosts()+"','"+assetPipeline.getHouseConnections()+"')";
			 * //System.out.println("query3= "+query3); empMasterData.stmt.addBatch(query3); } */
			 }
			  rowCount = empMasterData.stmt.executeBatch();
			  //System.out.println("ROW COUNT IS "+rowCount.length);			  
			  empMasterData.conn.commit();
			  empMasterData.conn.setAutoCommit(true); 

		}

		catch (Exception b) {
			//System.out.println("Error in insertAsset in EmpMasterData: " + b.getMessage());
		} finally {
			empMasterData.closeAll();

		}
		return rowCount;
	}
public static int[] insertAssetHab(EmpMaster empMaster, ArrayList habs, DataSource dataSource) throws Exception
{
	PanchRaj panchRaj = new PanchRaj();
	
	int[] rowCount = new int[50];
	String habCode = "";
	String assetTypeCode = "";
	String assetCompTypeCode = "";
	String assetSubCompTypeCode = "";
	String query1 = "", query = "";
	String schemeCode = "";
	EmpMasterData empMasterData=new EmpMasterData();
	try {
		empMasterData.conn = dataSource.getConnection();
		empMasterData.conn.setAutoCommit(false);
		empMasterData.stmt = empMasterData.conn.createStatement();
		//System.out.println( "hab size="
				+ habs.size());
		query = "delete from RWS_ASSET_HAB_TBL where asset_code='"
				+ empMaster.getAssetCode() + "'";
		//System.out.println("delete assethab query=" + query);
		empMasterData.stmt.addBatch(query);

		for (int i = 0; i < habs.size(); i++) {
			panchRaj = (PanchRaj) habs.get(i);
			if (panchRaj.getHabCode() != null) {
				//if (panchRaj.getHabCode().equals(habCode))
					//System.out.println("habCode in equal=" + habCode);
				//else {
					query = "insert into RWS_ASSET_HAB_TBL values('"
							+ empMaster.getAssetCode() + "','"
							+ panchRaj.getHabCode() + "')";
					//System.out.println("query=" + query);
					empMasterData.stmt.addBatch(query);
				//}
			}
		}
		 rowCount = empMasterData.stmt.executeBatch();
		  //System.out.println("ROW COUNT IS "+rowCount.length);			  
		  empMasterData.conn.commit();
		  empMasterData.conn.setAutoCommit(true); 
	}catch (Exception b) {
			//System.out.println("Error in insertAssetHab in EmpMasterData: " + b.getMessage());
		} finally {
			empMasterData.closeAll();

		}
		return rowCount;
}////**************######
	public static int insertAssetSubCompParams(DataSource dataSource,
			String assetCode, String assetCompTypeCode,
			String assetSubCompTypeCode, String assetTypeCode, String opType,
			ArrayList subComps, String compType) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
	
		//System.out.println("in insertAssetSubComparms() in EmpMasterData");
		int rowCount = 0;
		Asset_SubComponent assetSources = new Asset_SubComponent();
		//Asset_SubComponent assetSources ;
		Asset_HeadWorks assetHeadworks = new Asset_HeadWorks();
		Asset_PipeLine assetPipeline = new Asset_PipeLine();
		Asset_Reservior assetReservior = new Asset_Reservior();
		Asset_Pumpset assetPumpset = new Asset_Pumpset();
		String query1 = "";
		String query = "";
		String insertQuery="";
		Statement stm = null;
		//System.out.println("subComps size=" + subComps.size());
		//System.out.println("op type is" + opType);
		//System.out.println("op compType is" + compType);
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			stm = empMasterData.conn.createStatement();
			//@author santosh
			String Tab_Prifix = "";
			if(assetTypeCode.equals("01")) 
				Tab_Prifix = "RWS_PWS_";
			else if(assetTypeCode.equals("02") ) 
				Tab_Prifix = "RWS_MPWS_";
			else if(assetTypeCode.equals("03")) 
				Tab_Prifix = "RWS_CPWS_";
			
			////ponds
			if (assetTypeCode.equals("07")
					&& assetCompTypeCode.equals("01")
					&& assetSubCompTypeCode.equals("001"))
					{	
						Asset_Ponds assetPonds;
						//System.out.println("in EmpMasterData ponds");
						//System.out.println("subComps size= in save " + subComps.size());
						if (subComps != null)
						{
								
								for (int i = 0; i < subComps.size(); i++) 
								{
									Tab_Prifix="RWS_OPENWELL_POND_TBL";
									//System.out.println("in for");
									assetPonds = (Asset_Ponds) subComps.get(i);
									//System.out.println("hig in EmpMasterData is "+assetPonds.getHygeinity());
								 	//System.out.println("asset code in ponds   "+assetCode);
									////System.out.println("others code in ponds  "+ assetPumpset.getOtherCompCode());
									//System.out.println("sadiq in others");
									//System.out.println("assetCode in EmpMaster in assetPonds is '"+assetPonds.getAssetCode()+"'");				
									if(assetPonds.getAssetCode()!=null)
										//System.out.println("assetCode!=null");
									else
										//System.out.println("assetCode==null");
									/*if(assetPonds.getAssetCode()==null || ((String)assetPonds.getAssetCode()).equals(""))
									{
										//System.out.println("in if");
									query= "insert into "+Tab_Prifix+"  (" 
											 + "ASSET_CODE, HAB_CODE, POND_CODE, " 
											 + "POND_NAME, POND_LOCATION, SIZE_AREA, " 
											 + "STORAGE_VOL,HYGENITY ,USAGE_PURPOSE, " 
											 + "FED_BY, FED_NAME, " 
											 + "FED_OTHERS_NAME, WATER_QUALITY, FLORIDE, " 
											 + "BRAKISH, IRON, OTHER_TYPE, " 
											 + "OTHER_PER )   values('"
											
											 + assetCode+"','"
											 + format(assetPonds.getHabitation())+"','"
											 + format(assetPonds.getPondCode())+"','"
											 + format(assetPonds.getName())+"','"
											 
											 + format(assetPonds.getLocation())+"',"
											 + "nvl("+assetPonds.getAreaSize()+",0),"
											 + "nvl("+assetPonds.getVolumeOfStorage()+",0),'"
											 + format(assetPonds.getHygeinity())+"','"
											 
											 + format(assetPonds.getPurpose())+"','"
											 + format(assetPonds.getFedBy())+"','"
											 + format(assetPonds.getFedName())+"','"
											 + format(assetPonds.getFedOthersName())+"','"
											 
											 + format(assetPonds.getWaterQuality())+"',"
											
											 + "nvl("+assetPonds.getFloride()+",0),"
											 + "nvl("+assetPonds.getBrakish()+",0),"
											 + "nvl("+assetPonds.getIron()+",0),'"
											 + format(assetPonds.getOtherType())+"',"
											 + "nvl("+assetPonds.getOtherper()+",0)"
											 + ")";
										//System.out.println("query in rwc else  "+query);
										rowCount = empMasterData.stmt.executeUpdate(query);
										
											
									}else*/
									{
										if(assetPonds.getWaterQuality().equals("SAFE SOURCE"))
										{
											assetPonds.setFloride(""); 
											assetPonds.setBrakish(""); 
											assetPonds.setIron("");
											assetPonds.setOthers("");
											assetPonds.setOthersType("");
										}
										
										//System.out.println("executing query");
										query= "update  "+Tab_Prifix+"  set ASSET_CODE=?"
										
										 + ",HAB_CODE=?,POND_CODE=?"
										 +",POND_NAME=?,,POND_LOCATION=?"
										 + ",SIZE_AREA=nvl(?,0),STORAGE_VOL=nvl(?,0)"
										 +",HYGENITY=?,USAGE_PURPOSE=?"
										 + ",FED_BY=?,FED_NAME=?,FED_OTHERS_NAME="
										 + ",WATER_QUALITY=?,FLORIDE=nvl(?,0),BRAKISH=nvl(?,0)"
										 + ",IRON=nvl(?,0),OTHER_TYPE=?,OTHER_PER=?"
										 + "where POND_CODE=?";
										
									insertQuery= "INSERT INTO  "+Tab_Prifix+"  (ASSET_CODE," 
										+ "HAB_CODE,POND_CODE,POND_NAME,POND_LOCATION," 
										+ "SIZE_AREA,STORAGE_VOL,HYGENITY,USAGE_PURPOSE,FED_BY," 
										+ "FED_NAME,FED_OTHERS_NAME,WATER_QUALITY,FLORIDE,BRAKISH," 
										+ "IRON,OTHER_TYPE,OTHER_PER) VALUES(" 
										+"?,?,?,?,?,nvl(?,0),nvl(?,0),?,?,?,?,?,?,nvl(?,0),nvl(?,0),nvl(?,0),?,?)";
										 								      PreparedStatement ps1=conn.prepareStatement(query);
								      ps1.setString(1,assetCode);
								      ps1.setString(2,  format(assetPonds.getHabCode()));
										ps1.setString(3, format(assetPonds.getPondCode()));
										ps1.setString(4,format(assetPonds.getName()));
										ps1.setString(5, format(assetPonds.getLocation()));
										ps1.setString(6, assetPonds.getAreaSize());
										ps1.setString(7,assetPonds.getVolumeOfStorage());
										ps1.setString(8,format(assetPonds.getHygeinity()));
										ps1.setString(9, format(assetPonds.getPurpose()));
										ps1.setString(10,format(assetPonds.getFedBy()));
										ps1.setString(11, format(assetPonds.getFedName()));
										ps1.setString(12, format(assetPonds.getFedOthersName()));
										ps1.setString(13, format(assetPonds.getWaterQuality()));
										ps1.setString(14, assetPonds.getFloride());
										ps1.setString(15, assetPonds.getBrakish());
										ps1.setString(16, assetPonds.getIron());
										ps1.setString(17,format(assetPonds.getOthersType()));
										ps1.setString(18,  format(assetPonds.getOthers()));
										ps1.setString(19,assetPonds.getPondCode());
									//System.out.println("query in rwc else  "+query);
									rowCount = ps1.executeUpdate();
									}
										if(rowCount>0)
										//System.out.println("record inserted into rwc   ");
										if(rowCount<1)
										{
											//System.out.println("insert query is "+insertQuery);
											PreparedStatement psins=conn.prepareStatement(insertQuery);
										      psins.setString(1,assetCode);
										      psins.setString(2,  format(assetPonds.getHabCode()));
												psins.setString(3, format(assetPonds.getPondCode()));
												psins.setString(4,format(assetPonds.getName()));
												psins.setString(5, format(assetPonds.getLocation()));
												psins.setString(6, assetPonds.getAreaSize());
												psins.setString(7,assetPonds.getVolumeOfStorage());
												psins.setString(8,format(assetPonds.getHygeinity()));
												psins.setString(9, format(assetPonds.getPurpose()));
												psins.setString(10,format(assetPonds.getFedBy()));
												psins.setString(11, format(assetPonds.getFedName()));
												psins.setString(12, format(assetPonds.getFedOthersName()));
												psins.setString(13, format(assetPonds.getWaterQuality()));
												psins.setString(14, assetPonds.getFloride());
												psins.setString(15, assetPonds.getBrakish());
												psins.setString(16, assetPonds.getIron());
												psins.setString(17,format(assetPonds.getOthersType()));
												psins.setString(18,  format(assetPonds.getOthers()));
												
											rowCount = psins.executeUpdate();
											
											if(rowCount>0)
												//System.out.println("record inserted into "+Tab_Prifix);
										}
									
								}


							}
					}
			
			
			
			///end ponds
			//For Others Asset Type
			if (assetTypeCode.equals("05")
					&& assetCompTypeCode.equals("01")
					&& assetSubCompTypeCode.equals("001"))
					{	Tab_Prifix="RWS_SHALLOWHANDPUMPS_TBL";
						Asset_SHP assetSHP;
						//System.out.println("in EmpMasterData shallow handpumps");
						//System.out.println("subComps size= in save " + subComps.size());
						if (subComps != null)
						{
								
								for (int i = 0; i < subComps.size(); i++) 
								{
									
									//System.out.println("in for");
									assetSHP = (Asset_SHP) subComps.get(i);
									
								 	//System.out.println("asset code in ponds   "+assetCode);
									////System.out.println("others code in ponds  "+ assetPumpset.getOtherCompCode());
									//System.out.println("sadiq in others");
									//System.out.println("assetCode in EmpMaster in assetPonds is '"+assetSHP.getAssetCode()+"'");				
									if(assetSHP.getAssetCode()!=null)
										//System.out.println("assetCode!=null");
									else
										//System.out.println("assetCode==null");
									/*if(assetSHP.getAssetCode()==null || ((String)assetSHP.getAssetCode()).equals(""))
									{
										//System.out.println("in if");
										
										

									query= "insert into "+Tab_Prifix+"  (ASSET_CODE, " 
											 + "HAB_CODE, SHALLOWHP_CODE, LOCATION, " 
											 + "DIAMETER, DEPTH, HYGIENE, " 
											 + "AVERAGE_HOURS,AVERAGE_TIME ,YIELD, " 
											 + "WATER_QUALITY,  " 
											 + " FLORIDE_PER, " 
											 + "BRAKISH_PER, IRON_PER, OTHERS_PER " 
											 + ")   values('"
											
											 + assetCode+"','"
											 + format(assetSHP.getHabCode())+"','"
											 + format(assetSHP.getShallowHandPumpCode())+"','"
											
											 
											 + format(assetSHP.getLocation())+"',"
											 + "nvl("+assetSHP.getDiameter()+",0),"
											 + "nvl("+assetSHP.getDepth()+",0),'"
											 + format(assetSHP.getHygiene())+"',"
											 
											 + "nvl("+assetSHP.getAvgNoOfHoursWorkingPerDay()+",0),"
											 + "nvl("+assetSHP.getAvgTimeToFill()+",0),'"
											 + format(assetSHP.getYeild())+"','"
											 + format(assetSHP.getWaterQuality())+"',"
											 
											 + "nvl("+assetSHP.getFloride()+",0),"
											
											
											 + "nvl("+assetSHP.getBrakish()+",0),"
											 + "nvl("+assetSHP.getIron()+",0),"
											
											 + "nvl("+assetSHP.getOthers()+",0)"
											 + ")";
										//System.out.println("query in rwc else  "+query);
										rowCount = empMasterData.stmt.executeUpdate(query);
										
											
									}else*/
									{
										if(assetSHP.getWaterQuality().equals("SAFE SOURCE"))
										{
											assetSHP.setFloride("");
											assetSHP.setBrakish(""); 
											assetSHP.setIron("");
											assetSHP.setOthers("");
											assetSHP.setOthersType("");
										}
										
										query= "update  "+Tab_Prifix+"  set " 
										 + "ASSET_CODE=?,HAB_CODE=?"
										 + "SHALLOWHP_CODE=?,LOCATION=?,"
										 + "DIAMETER=nvl(?,0),DEPTH=nvl(?,0),HYGIENE=?"
										 + "AVERAGE_HOURS=nvl(?,0),"
										 + "AVERAGE_TIME=nvl(?,0),"
										 + "YIELD=?,"
										 + "WATER_QUALITY=?,"
										 + "FLORIDE_PER=nvl(?,0),"
										 + "BRAKISH_PER=nvl(?,0),"
										 + "IRON_PER=nvl(?,0),"
										 + "OTHERS=?,"
										 + "OTHERS_PER=?"
										 + " where SHALLOWHP_CODE=?";
										
								insertQuery	 = "INSERT INTO  "+Tab_Prifix+"(ASSET_CODE,HAB_CODE," 
											 + "SHALLOWHP_CODE,LOCATION,DIAMETER,DEPTH,HYGIENE," 
											 + "AVERAGE_HOURS,AVERAGE_TIME,YIELD,WATER_QUALITY," 
											 + "FLORIDE_PER,BRAKISH_PER,IRON_PER,OTHERS,OTHERS_PER)" 
											 + "VALUES(?,?,?,?,nvl(?,0),nvl(?,0),?,nvl(?,0),nvl(?,0),?,?,nvl(?,0),nvl(?,0),nvl(?,0),?,?)" ;
											
										//System.out.println("query in rwc else  "+query);

								PreparedStatement ps1=conn.prepareStatement(query);
							      ps1.setString(1,assetCode);
							      ps1.setString(2,  format(assetSHP.getHabCode()));
									ps1.setString(3,format(assetSHP.getShallowHandPumpCode()));
									ps1.setString(4,format(assetSHP.getLocation()));	
									ps1.setString(5,format(assetSHP.getDiameter()));
									ps1.setString(6, format(assetSHP.getDepth()));
									ps1.setString(7,format(assetSHP.getHygiene()));
									ps1.setString(8,format(assetSHP.getAvgNoOfHoursWorkingPerDay()));
									ps1.setString(9, format(assetSHP.getAvgTimeToFill()));
									ps1.setString(10,format(assetSHP.getYeild()));
									ps1.setString(11, format(assetSHP.getWaterQuality()));
									ps1.setString(12, format(assetSHP.getFloride()));
									ps1.setString(13, format(assetSHP.getBrakish()));
									ps1.setString(14, format(assetSHP.getIron()));
									ps1.setString(15, format(assetSHP.getOthersType()));
									ps1.setString(16, format(assetSHP.getOthers()));
									ps1.setString(17,assetSHP.getShallowHandPumpCode());
									
									rowCount = ps1.executeUpdate();
									
									}
										if(rowCount>0)
										//System.out.println("record UPDATED ");
										if(rowCount<1)
										{
											//System.out.println("insert query is "+insertQuery);
											PreparedStatement psins=conn.prepareStatement(query);
										      psins.setString(1,assetCode);
										      psins.setString(2,  format(assetSHP.getHabCode()));
												psins.setString(3,format(assetSHP.getShallowHandPumpCode()));
												psins.setString(4,format(assetSHP.getLocation()));	
												psins.setString(5,format(assetSHP.getDiameter()));
												psins.setString(6, format(assetSHP.getDepth()));
												psins.setString(7,format(assetSHP.getHygiene()));
												psins.setString(8,format(assetSHP.getAvgNoOfHoursWorkingPerDay()));
												psins.setString(9, format(assetSHP.getAvgTimeToFill()));
												psins.setString(10,format(assetSHP.getYeild()));
												psins.setString(11, format(assetSHP.getWaterQuality()));
												psins.setString(12, format(assetSHP.getFloride()));
												psins.setString(13, format(assetSHP.getBrakish()));
												psins.setString(14, format(assetSHP.getIron()));
												psins.setString(15, format(assetSHP.getOthersType()));
												psins.setString(16, format(assetSHP.getOthers()));
											rowCount = psins.executeUpdate(insertQuery);
											if(rowCount>0)
												//System.out.println("record inserted into "+Tab_Prifix);
										}
									
									
								}


							}
					}
			
			if (assetTypeCode.equals("06")
					&& assetCompTypeCode.equals("01")
					&& assetSubCompTypeCode.equals("001"))
					{	Tab_Prifix="RWS_OPEN_WELL_MAST_TBL";
						Asset_OpenWells assetOpenWells;
						//System.out.println("in EmpMasterData Open WElls");
						//System.out.println("subComps size= in save " + subComps.size());
						if (subComps != null)
						{
								
								for (int i = 0; i < subComps.size(); i++) 
								{
									
									//System.out.println("in for");
									assetOpenWells = (Asset_OpenWells) subComps.get(i);
									
								 	//System.out.println("asset code in openWells   "+assetCode);
									////System.out.println("others code in ponds  "+ assetPumpset.getOtherCompCode());
									//System.out.println("sadiq in others");
									//System.out.println("assetCode in EmpMaster in assetPonds is '"+assetOpenWells.getAssetCode()+"'");				
									if(assetOpenWells.getAssetCode()!=null)
										//System.out.println("assetCode!=null");
									else
										//System.out.println("assetCode==null");
									if(assetOpenWells.getOthers()==null || ((String)assetOpenWells.getOthers()).equals(""))
									{
										assetOpenWells.setOthers("");
									}
										
									/*if(assetOpenWells.getAssetCode()==null || ((String)assetOpenWells.getAssetCode()).equals(""))
									{
										//System.out.println("in if");
										
										query= "insert into "+Tab_Prifix+"  ("
											 + "ASSET_CODE,"
											 + "HABITATION_CODE, OPENWELL_CODE, LOCATION, " 
											 + "DIAMETER, DEPTH, NORMAL_WATER_LEVEL, " 
											 + "MIN_WATER_LEVEL,MAX_WATER_LEVEL ,PLATFORM_EXISTS," 
											 + "PLATFORM_CONDITION," 
											 + "PURPOSE, QUALITY, " 
											 + "FLOURIDE_PER, BRAKISH_PER, IRON_PER, " 
											 + "OTHER_PER"
											 + ")   values('"
											
											 + assetCode+"','"
											 + format(assetOpenWells.getHabCode())+"','"
											 + format(assetOpenWells.getOpenWellCode())+"','"
											
											 
											 + format(assetOpenWells.getLocation())+"',"
											 + "nvl('"+assetOpenWells.getDiameter()+"',0),"
											 + "nvl('"+assetOpenWells.getDepth()+"',0),"
											 + "nvl('"+assetOpenWells.getNormalWaterLevel()+"',0),"
											 
											 + "nvl('"+assetOpenWells.getMinimumWaterLevel()+"',0),"
											 + "nvl('"+assetOpenWells.getMaximumWaterLevel()+"',0),'"
											 + format(assetOpenWells.getPlatformExists())+"','"
											 + format(assetOpenWells.getPlatformCondition())+"','"
											 + format(assetOpenWells.getPurpose())+"','"
											 + format(assetOpenWells.getWaterQuality())+"',"
											 
											 + "nvl('"+assetOpenWells.getFloride()+"',0),"
											
											
											 + "nvl('"+assetOpenWells.getBrakish()+"',0),"
											 + "nvl('"+assetOpenWells.getIron()+"',0),"
											
											 + "nvl('"+assetOpenWells.getOthers()+"',0)"
											 + ")";
										//System.out.println("query in rwc else  "+query);
										rowCount = empMasterData.stmt.executeUpdate(query);
										
											
									}else*/
									{
										if(assetOpenWells.getWaterQuality().equals("SAFE SOURCE"))
										{
											assetOpenWells.setFloride("");
											assetOpenWells.setBrakish(""); 
											assetOpenWells.setIron("");
											assetOpenWells.setOthers("");
											assetOpenWells.setOthersType("");
										}
										query= "update  "+Tab_Prifix+"  set " 
										 + "ASSET_CODE=?,"
										 + "HABITATION_CODE=?,"
										 + "OPENWELL_CODE=?,"
										 + "LOCATION=?,"
										 + "DIAMETER=nvl(?,0),"
										 + "DEPTH=nvl(?,0),"
										 + "NORMAL_WATER_LEVEL=nvl(?,0),"
										 + "MIN_WATER_LEVEL=nvl(?,0),"
										 + "MAX_WATER_LEVEL=nvl(?,0),"
										 + "PLATFORM_EXISTS=?,"
										 //+ "PLATFORM_CONDITION='"+format(assetOpenWells.getPlatformCondition())+"',"
										 + "PURPOSE=?,"
										 + "QUALITY=?,"
										 + "FLOURIDE_PER=nvl(?,0),"
										 + "BRAKISH_PER=nvl(?,0),"
										 + "IRON_PER=nvl(?,0),"
										 + "OTHER_PER=?,"
										 + "OTHER_TYPE=?""
										 + " where OPENWELL_CODE=?";
										
										insertQuery= "INSERT INTO  "+Tab_Prifix+"  ( " 
										 + "ASSET_CODE,HABITATION_CODE,OPENWELL_CODE,LOCATION," 
										 + "DIAMETER,DEPTH,NORMAL_WATER_LEVEL,MIN_WATER_LEVEL," 
										 + "MAX_WATER_LEVEL,PLATFORM_EXISTS,PURPOSE,QUALITY," 
										 + "FLOURIDE_PER,BRAKISH_PER,IRON_PER,OTHER_TYPE,OTHER_PER) " 
										 + "VALUES(" 
										 + "'"+ assetCode+"',"
										 + "'"+format(assetOpenWells.getHabCode())+"',"
										 + "'"+format(assetOpenWells.getOpenWellCode())+"',"
										
										 
										 + "'"+format(assetOpenWells.getLocation())+"',"
										 + ""+"nvl('"+assetOpenWells.getDiameter()+"',0),"
										 + ""+"nvl('"+assetOpenWells.getDepth()+"',0),"
										 + ""+ "nvl('"+format(assetOpenWells.getNormalWaterLevel())+"',0),"
										 
										 + ""+ "nvl('"+assetOpenWells.getMinimumWaterLevel()+"',0),"
										 + ""+"nvl('"+assetOpenWells.getMaximumWaterLevel()+"',0),"
										 + "'"+format(assetOpenWells.getPlatformExists())+"',"
										 //+ "PLATFORM_CONDITION='"+format(assetOpenWells.getPlatformCondition())+"',"
										 + "'"+format(assetOpenWells.getPurpose())+"',"
										 + "'"+format(assetOpenWells.getWaterQuality())+"',"
										 + ""+"nvl('"+assetOpenWells.getFloride()+"',0),"
										 + ""+"nvl('"+assetOpenWells.getBrakish()+"',0),"
										 + ""+"nvl('"+assetOpenWells.getIron()+"',0),"
										 + ""+"'"+format(assetOpenWells.getOthersType())+"',"
										 + "'"+format(assetOpenWells.getOthers())+"' )";
										
									//System.out.println("query in rwc else  "+query);
										PreparedStatement ps1=conn.prepareStatement(query);
								        ps1.setString(1,assetCode);
								        ps1.setString(2, format(assetOpenWells.getHabCode()));
										ps1.setString(3,format(assetOpenWells.getOpenWellCode()));
										ps1.setString(4,format(assetOpenWells.getLocation()));	
										ps1.setString(5,assetOpenWells.getDiameter());
										ps1.setString(6, assetOpenWells.getDepth()));
										ps1.setString(7,format(assetOpenWells.getNormalWaterLevel()));
										ps1.setString(8,assetOpenWells.getMinimumWaterLevel());
										ps1.setString(9, assetOpenWells.getMaximumWaterLevel());
										ps1.setString(10,format(assetOpenWells.getPlatformExists()));
										ps1.setString(11, format(assetOpenWells.getPurpose()));
										ps1.setString(12, format(assetOpenWells.getWaterQuality()));
										ps1.setString(13, assetOpenWells.getFloride());
										ps1.setString(14,assetOpenWells.getBrakish());
										ps1.setString(15, assetOpenWells.getIron());
										ps1.setString(16,format(assetOpenWells.getOthers()));
										ps1.setString(17,format(assetOpenWells.getOthersType()));
										ps1.setString(18,assetOpenWells.getOpenWellCode());
									rowCount = ps1.executeUpdate();
									}
										if(rowCount>0)
										//System.out.println("record UPDATED into rwc   ");
										if(rowCount<1)
										{
											//System.out.println("insert query is "+insertQuery);
											PreparedStatement psins=conn.prepareStatement(insertQuery);
									        psins.setString(1,assetCode);
									        psins.setString(2, format(assetOpenWells.getHabCode()));
											psins.setString(3,format(assetOpenWells.getOpenWellCode()));
											psins.setString(4,format(assetOpenWells.getLocation()));	
											psins.setString(5,assetOpenWells.getDiameter());
											psins.setString(6, assetOpenWells.getDepth()));
											psins.setString(7,format(assetOpenWells.getNormalWaterLevel()));
											psins.setString(8,assetOpenWells.getMinimumWaterLevel());
											psins.setString(9, assetOpenWells.getMaximumWaterLevel());
											psins.setString(10,format(assetOpenWells.getPlatformExists()));
											psins.setString(11, format(assetOpenWells.getPurpose()));
											psins.setString(12, format(assetOpenWells.getWaterQuality()));
											psins.setString(13, assetOpenWells.getFloride());
											psins.setString(14,assetOpenWells.getBrakish());
											psins.setString(15, assetOpenWells.getIron());
											psins.setString(17,format(assetOpenWells.getOthers()));
											ps1.setString(16,format(assetOpenWells.getOthersType()));
											rowCount =psins.executeUpdate();
											if(rowCount>0)
												//System.out.println("record inserted into  "+Tab_Prifix);
										}
									
									
								}


							}
					}
			
			
			if (assetTypeCode.equals("08")
					&& assetCompTypeCode.equals("01")
					&& assetSubCompTypeCode.equals("001"))
					{	Tab_Prifix=" RWS_CPWS_OTHERS_PARAM_TBL";
						Asset_Others assetOthers;
						//System.out.println("in EmpMasterData Others");
						//System.out.println("subComps size= in save " + subComps.size());
						if (subComps != null)
						{
								
								for (int i = 0; i < subComps.size(); i++) 
								{
									
									//System.out.println("in for");
									assetOthers = (Asset_Others) subComps.get(i);
									
								 	//System.out.println("asset code in openWells   "+assetCode);
									////System.out.println("others code in ponds  "+ assetPumpset.getOtherCompCode());
									//System.out.println("sadiq in others");
									//System.out.println("assetCode in EmpMaster in assetPonds is '"+assetOthers.getAssetCode()+"'");				
									if(assetOthers.getAssetCode()!=null)
										//System.out.println("assetCode!=null");
									else
										//System.out.println("assetCode==null");
									
									{
										query= "update  "+Tab_Prifix+"  set " 
										 + "OTHER_COMP_CODE='"+assetOthers.getGeneralCode()+"',"
										 + "ASSET_CODE='"+ assetCode+"',"
										 + "COMP_NAME='"+format(assetOthers.getComponentName())+"',"
										 + "COMP_LOCATION='"+format(assetOthers.getLocation())+"',"
										 + "REMARKS='"+format(assetOthers.getRemarks())+"',"
										 + "HAB_CODE='"+format(assetOthers.getHabCode())+"'"
										 + " where OTHER_COMP_CODE='"+assetOthers.getGeneralCode()+"'";
									//System.out.println("query in rwc else  "+query);
									rowCount = empMasterData.stmt.executeUpdate(query);
									}
										if(rowCount>0)
										//System.out.println("record inserted into rwc   ");
									
									
								}


							}
					}
			/*if ((assetTypeCode.equals("03")||assetTypeCode.equals("03")||assetTypeCode.equals("03"))
					&& assetCompTypeCode.equals("01")
					&& assetSubCompTypeCode.equals("009"))*/
			if ((assetTypeCode.equals("01")||assetTypeCode.equals("02")||assetTypeCode.equals("03"))
			&& assetCompTypeCode.equals("01")
			&& assetSubCompTypeCode.equals("003"))
					{	//System.out.println("in EmpMasterData pumpsets 003");
						//System.out.println("subComps size= in save " + subComps.size());
						if (subComps != null)
						{
								
								for (int i = 0; i < subComps.size(); i++) 
								{
									//System.out.println("in for");
									assetPumpset = (Asset_Pumpset) subComps.get(i);
									//System.out.println("assetPumpset.getAssetCode() is '"+assetPumpset.getAssetCode()+"'");
									//System.out.println("asset code in RWC WELL   "+assetCode);
									//System.out.println("others code in RWC   "+ assetPumpset.getOtherCompCode());
									//System.out.println("sadiq in others");
													
									if(assetPumpset.getAssetCode()!=null)
										//System.out.println("assetCode!=null");
									else
										//System.out.println("assetCode==null");
									//if(assetPumpset.getAssetCode()!=null && !assetPumpset.getAssetCode().equals(""))
									{
										//System.out.println("in if");
										
										query1 = "update "+Tab_Prifix+"SUBCOMP_PARAM_TBL  set  " 
											   + "PUMP_CODE='"+assetPumpset.getPumpCode()+"',"  
											   + "ASSET_CODE='"+assetCode+"', " 
											   + "PUMP_MAKE='"+assetPumpset.getPumpMake()+"'," 
											   
											   + "PUMP_CPTY='"+assetPumpset.getPumpCapacity()+"',"  
											   + "PUMP_TYPE='"+assetPumpset.getPumpType()+"',"  
											   + "YEAR_COMM='"+assetPumpset.getPumpYearOfCommissioning()+"'," 
											   
											   + "HR_RUN='"+assetPumpset.getPumpHoursRunningPerDay()+"',"  
											   + "USAGE='"+assetPumpset.getPumpUsage()+"',"  
											   + "DESIGNED_LPM='"+assetPumpset.getPumpDesignedLpm()+"'," 
											   
											   + "DESIGNED_HEAD='"+assetPumpset.getPumpDesignedHead()+"',"  
											   + "CONTROL_PANEL='"+assetPumpset.getPumpControlPanel()+"',"  
											   + "LOW_VOLT_PROB='"+assetPumpset.getPumpLowVoltageProblems()+"'," 
											   
											   + "POWER_AVAIL_PER_DAY='"+assetPumpset.getPumpHoursOfPowerAvailability()+"',"  
											   + "FEAS_URBAN_LINE='"+assetPumpset.getPumpFeasiblityOfGettingUrbanLine()+"',"  
											   + "COST='"+assetPumpset.getPumpAppCostOfUrbanFeeder()+"'," 
											   
											   + "URBAN_LINE_DISTANCE='"+assetPumpset.getPumpDistanceFromWhereUrbanLineCanBeHad()+"',"  
											   + "SUGGESTIONS='"+assetPumpset.getPumpSuggestions()+"',"  
											   + "HAB_CODE='"+assetPumpset.getHabCode()+"'," 
											   
											   + "LOCATION='"+assetPumpset.getPumpLocation()+"',"  
											   + "FEEDER='"+assetPumpset.getPumpFeeder()+"'"  
											   + "where PUMP_CODE='"+assetPumpset.getPumpCode()+"' AND ASSET_CODE='"+assetCode+"'";
										
											insertQuery = "INSERT INTO "+Tab_Prifix+"SUBCOMP_PARAM_TBL(" 
											   + "PUMP_CODE,ASSET_CODE,PUMP_MAKE,PUMP_CPTY,PUMP_TYPE," 
											   + "YEAR_COMM,HR_RUN,USAGE,DESIGNED_LPM,DESIGNED_HEAD," 
											   + "CONTROL_PANEL,LOW_VOLT_PROB,POWER_AVAIL_PER_DAY," 
											   + "FEAS_URBAN_LINE,COST,URBAN_LINE_DISTANCE,SUGGESTIONS," 
											   + "HAB_CODE,LOCATION,FEEDER) " 
											   + " VALUES(  " 
											   + "'"+assetPumpset.getPumpCode()+"',"  
											   + "'"+assetCode+"', " 
											   + "'"+assetPumpset.getPumpMake()+"'," 
											   
											   + "'"+assetPumpset.getPumpCapacity()+"',"  
											   + "'"+assetPumpset.getPumpType()+"',"  
											   + "'"+assetPumpset.getPumpYearOfCommissioning()+"'," 
											   
											   + "'"+assetPumpset.getPumpHoursRunningPerDay()+"',"  
											   + "'"+assetPumpset.getPumpUsage()+"',"  
											   + "'"+assetPumpset.getPumpDesignedLpm()+"'," 
											   
											   + "'"+assetPumpset.getPumpDesignedHead()+"',"  
											   + "'"+assetPumpset.getPumpControlPanel()+"',"  
											   + "'"+assetPumpset.getPumpLowVoltageProblems()+"'," 
											   
											   + "'"+assetPumpset.getPumpHoursOfPowerAvailability()+"',"  
											   + "'"+assetPumpset.getPumpFeasiblityOfGettingUrbanLine()+"',"  
											   + "'"+assetPumpset.getPumpAppCostOfUrbanFeeder()+"'," 
											   
											   + "'"+assetPumpset.getPumpDistanceFromWhereUrbanLineCanBeHad()+"',"  
											   + "'"+assetPumpset.getPumpSuggestions()+"',"  
											   + "'"+assetPumpset.getHabCode()+"'," 
											   
											   + "'"+assetPumpset.getPumpLocation()+"',"  
											   + "'"+assetPumpset.getPumpFeeder()+"')";  
											   
												  
										//query1 = "update "+Tab_Prifix+"OTHERS_PARAM_TBL  set Ohsr_CAP_LTS="+ assetReservior.getOhsrCapacityLts() +", Ohsr_LOC='"+ assetReservior.getOhsrLocation() +"', Ohsr_SATGES="+ assetReservior.getOhsrStages() +", Ohsr_LWL="+ assetReservior.getOhsrLwl() +",  Ohsr_FILL_HR="+  assetReservior.getOhsrFillHrs() +", Ohsr_EMPTY_HR ="+ assetReservior.getOhsrEmptyHrs() +",Ohsr_MWL="+ assetReservior.getOhsrMwl() +", Ohsr_NO_OF_FILLING ="+assetReservior.getNoOfFillings() + " where asset_code ='" + assetReservior.getAssetCode() + "' and Ohsr_code ='"+assetReservior.getOhsrCode() +"'";
										//System.out.println("query1123=" + query1);
										rowCount = empMasterData.stmt.executeUpdate(query1);
										if(rowCount<1)
										{
											//System.out.println("insert query is "+insertQuery);
											rowCount = empMasterData.stmt.executeUpdate(insertQuery);
											if(rowCount>0)
												//System.out.println("record inserted into SUBCOMP_PARAM_TBL");
										}
									}
																	}


							}
					}
			

			
			
			
			if ((assetTypeCode.equals("01")||assetTypeCode.equals("02")||assetTypeCode.equals("03"))
					&& assetCompTypeCode.equals("05")
					&& assetSubCompTypeCode.equals("001"))
					{	//System.out.println("in EmpMasterData others");
						//System.out.println("subComps size= in save " + subComps.size());
						if (subComps != null)
						{
								
								for (int i = 0; i < subComps.size(); i++) 
								{
									//System.out.println("in for");
									assetPumpset = (Asset_Pumpset) subComps.get(i);
								 	//System.out.println("asset code in RWC WELL   "+assetCode);
									//System.out.println("others code in RWC   "+ assetPumpset.getOtherCompCode());
									//System.out.println("sadiq in others");
									//if(!assetPumpset.getAssetCode().equals(""))
									{
										query1 = "update "+Tab_Prifix+"OTHERS_PARAM_TBL  set  OTHER_COMP_CODE='"+assetPumpset.getOtherCompCode()+"', ASSET_CODE='"+assetCode+"', COMP_NAME='"+assetPumpset.getCompName()+"', COMP_LOCATION='"+assetPumpset.getCompLocation()+"', REMARKS='"+assetPumpset.getRemarks()+"', HAB_CODE='"+assetPumpset.getHabCode()+"'" 
												+"where OTHER_COMP_CODE='"+assetPumpset.getOtherCompCode()+"'"+
												"";
										//query1 = "update "+Tab_Prifix+"OTHERS_PARAM_TBL  set Ohsr_CAP_LTS="+ assetReservior.getOhsrCapacityLts() +", Ohsr_LOC='"+ assetReservior.getOhsrLocation() +"', Ohsr_SATGES="+ assetReservior.getOhsrStages() +", Ohsr_LWL="+ assetReservior.getOhsrLwl() +",  Ohsr_FILL_HR="+  assetReservior.getOhsrFillHrs() +", Ohsr_EMPTY_HR ="+ assetReservior.getOhsrEmptyHrs() +",Ohsr_MWL="+ assetReservior.getOhsrMwl() +", Ohsr_NO_OF_FILLING ="+assetReservior.getNoOfFillings() + " where asset_code ='" + assetReservior.getAssetCode() + "' and Ohsr_code ='"+assetReservior.getOhsrCode() +"'";
										//System.out.println("query1123=" + query1);
										rowCount=empMasterData.stmt.executeUpdate(query1);
									}
									/*else
									{
										query="insert into "+Tab_Prifix+"OTHERS_PARAM_TBL   (ASSET_CODE, OTHER_COMP_CODE, COMP_NAME, COMP_LOCATION, REMARKS ,HAB_CODE)  values('"+assetCode+"','"+assetPumpset.getOtherCompCode()+"','"+assetPumpset.getCompName()+"','"+assetPumpset.getCompLocation()+"','"+assetPumpset.getRemarks()+"','"+assetPumpset.getHabCode()+"')";
										//System.out.println("query in rwc else  "+query);
										rowCount = empMasterData.stmt.executeUpdate(query);
										if(rowCount>0)
										//System.out.println("record inserted into rwc   ");
									}*/
								}


							}
						return rowCount;
					}
			
			
			if (assetTypeCode.equals("03") 
					&& assetCompTypeCode.equals("02")
					&& assetSubCompTypeCode.equals("002") 
					&& opType.equalsIgnoreCase("Add New"))
					{
				//System.out.println("assetTypeCode 03 02 002 and opType=Add New");
				//System.out.println("subComps.size()="+subComps.size());
				try{
					assetHeadworks = (Asset_HeadWorks) subComps.get(0);
				}
				catch(Exception e){//System.out.println("error is"+e);}
				//System.out.println("subComps.size()="+subComps.size());
				//System.out.println("assetHeadworks.getAssetCode()   "+assetHeadworks.getAssetCode());
				if (!assetHeadworks.getAssetCode().equals("")) {
					//System.out.println("assetcode=''");
				
				
				}
				else {
					//System.out.println("in else");
					//System.out.println("assetCode is"+assetHeadworks.getAssetCode());
					}
				//rowCount = empMasterData.stmt.executeUpdate(query1);
				if(rowCount>0)
					//System.out.println("record inserted into rws_hp_subcomp_param_tbl  ");

			} 
						else if (assetTypeCode.equals("04") && assetCompTypeCode.equals("01")
					&& assetSubCompTypeCode.equals("001")) {

				assetSources = (Asset_SubComponent) subComps.get(0);
				//System.out.println("assetSources.getAssetCode()   "+assetSources.getAssetCode());
				//if (!assetSources.getAssetCode().equals("")) 
				//{
				if(assetSources.getQualityAffected().equals("N"))
				{
					assetSources.setBrakish(0); 
					assetSources.setIron(0);
					assetSources.setOthers("");
					assetSources.setOthersType("");
				}
				query1 = "update RWS_HP_SUBCOMP_PARAM_TBL set " 
					   + "ASSET_CODE='"+assetCode+"', " 
					   + "LOCATION = '"  + assetSources.getLocation() 
					   //+ "',DRILL_YEAR ='" + assetSources.getYearOfDrilling() + "'," 
					   + "',DIAMETER = nvl('"+ assetSources.getDiameter() 
					   + "',0),CASING ='"  + assetSources.getCasing() + "'," 
					   //+ "STATUS = '"+ assetSources.getStatus() 
					   + " GEN_CONDITION = '"+ assetSources.getGenCondition() 
					   + "', GI_NO = nvl('" 	+ assetSources.getGino() + "',0)," 
					   + " PAINTED = '"	+ assetSources.getPainted() 
					   + "', STATIC_WL=nvl('"	+ assetSources.getStaticWaterLevel() + "',0)" 
					   + ", SUMMER_WL=nvl('"+ assetSources.getSummerWaterLevel() 
					   + "',0), P_COND='"+ assetSources.getPcond() 
					   //+ "',DRY_DURING ='"+ assetSources.getDryduring() 
					   //+ "', SERVICE='"+ assetSources.getService() 
					   + "', SER_NO =nvl('"+ assetSources.getSerno() + "',0)," 
					   + " SER_HRS = nvl('"+ assetSources.getSerhrs() 
					   + "',0), REPAIRS='"+ assetSources.getRepairs() 
					   + "', PLATFORM_CONDITION='" + assetSources.getPlatformCondition() 
					   + "', DRAIN='"+ assetSources.getDrain() 
					   + "', DRAIN_CONDITION='"	+ assetSources.getDrainCondition() 
					   + "', DRAIN_SD='"+ assetSources.getDrainsd() 
					   + "', DRAIN_LP ='" + assetSources.getDrainlp() 
					   + "', HYGIENE ='"+ assetSources.getHygiene() 
					   + "', AVG_TIME = nvl('"+ assetSources.getAvgtime() 
					   + "',0), P_YEILD ="	+ assetSources.getPyield() 
					   + ", PYEILD_LOCAL = '"+ assetSources.getPyieldLocal() 
					   + "'," +	"PERIOD ='"+ assetSources.getPeriod() 
					   + "',DEPTH= nvl('"+ assetSources.getDepth() 
					   + "',0),QUALITY_AFFECTED='"+ format(assetSources.getQualityAffected()) 
					   + "'," +	" FLOURIDE =nvl('"+ assetSources.getFlouride() 
					   + "',0), BRAKISH =nvl('"+ assetSources.getBrakish() 
					   + "',0), IRON =nvl('"+ assetSources.getIron()
					   + "',0), CONT_OTHERS_PER  ='"+ format(assetSources.getOthers())
					   //+ "',0), cont_others_type = '"+assetSources.getOtherspecify()
					   + "', cont_others_type = '"+format(assetSources.getOthersType())
					   + "' where " 
					  // + " asset_code = '"+ assetSources.getAssetCode()+"' and " 
					   + "hp_code = '"+ assetSources.getHpCode() + "'";
					//System.out.println("update query is "+query1);
				//}
				
				insertQuery= "INSERT INTO RWS_HP_SUBCOMP_PARAM_TBL(HP_CODE,ASSET_CODE,LOCATION ,DIAMETER," 
					   + "CASING,GEN_CONDITION,GI_NO,PAINTED,STATIC_WL,SUMMER_WL,P_COND," 
					   + "SER_NO,SER_HRS,REPAIRS,PLATFORM_CONDITION,DRAIN,DRAIN_CONDITION," 
					   + "DRAIN_SD,DRAIN_LP,HYGIENE,AVG_TIME,P_YEILD,PYEILD_LOCAL,PERIOD," 
					   + "DEPTH,QUALITY_AFFECTED,FLOURIDE,BRAKISH,IRON,CONT_OTHERS_PER," 
					   + "cont_others_type) VALUES(" 
					   + "'"+ assetSources.getHpCode() + "',"
					   + "'"+ assetCode + "',"
					   + "'"  + assetSources.getLocation() 
					   //+ "',DRILL_YEAR ='" + assetSources.getYearOfDrilling() + "'," 
					   + "',nvl('"+ assetSources.getDiameter() 
					   + "',0),'"  + assetSources.getCasing() + "'," 
					   //+ "STATUS = '"+ assetSources.getStatus() 
					   + "  '"+ assetSources.getGenCondition() 
					   + "',  nvl('" 	+ assetSources.getGino() + "',0)," 
					   + "  '"	+ assetSources.getPainted() 
					   + "', nvl('"	+ assetSources.getStaticWaterLevel() + "',0)" 
					   + ", nvl('"+ assetSources.getSummerWaterLevel() 
					   + "',0), '"+ assetSources.getPcond() 
					   //+ "',DRY_DURING ='"+ assetSources.getDryduring() 
					   //+ "', SERVICE='"+ assetSources.getService() 
					   + "', nvl('"+ assetSources.getSerno() + "',0)," 
					   + "  nvl('"+ assetSources.getSerhrs() 
					   + "',0), '"+ assetSources.getRepairs() 
					   + "', '" + format(assetSources.getPlatformCondition()) 
					   + "', '"+ assetSources.getDrain() 
					   + "', '"	+ assetSources.getDrainCondition() 
					   + "', '"+ assetSources.getDrainsd() 
					   + "', '" + assetSources.getDrainlp() 
					   + "', '"+ assetSources.getHygiene() 
					   + "', nvl('"+ assetSources.getAvgtime() 
					   + "',0), "	+ assetSources.getPyield() 
					   + ",  '"+ assetSources.getPyieldLocal() 
					   + "'," +	"'"+ assetSources.getPeriod() 
					   + "',nvl('"+ assetSources.getDepth() 
					   + "',0),'"+ format(assetSources.getQualityAffected()) 
					   + "'," +	" nvl('"+ assetSources.getFlouride() 
					   + "',0), nvl('"+ assetSources.getBrakish() 
					   + "',0), nvl('"+ assetSources.getIron()
					   + "',0), '"+ format(assetSources.getOthers())
					   //+ "',0), cont_others_type = '"+assetSources.getOtherspecify()
					   + "',  '"+format(assetSources.getOthersType())
					   + "' ) " ;
					 
				
				
				rowCount = empMasterData.stmt.executeUpdate(query1);
				
				if(rowCount>0)
					//System.out.println("record updated into rws_hp_subcomp_param_tbl  ");
				if(rowCount<1)
				{
					//System.out.println("insert query is "+insertQuery);
					rowCount = empMasterData.stmt.executeUpdate(insertQuery);
					if(rowCount>0)
						//System.out.println("record inserted into rws_hp_subcomp_param_tbl  ");
				}
			} 
			
			
			//if (compType.equals("Reservoirs") &&( opType.equals("Modify"))
			if (compType.equals("Reservoirs") &&( opType.equals("Modify")||opType.equalsIgnoreCase("Add New"))) {
				int[] rowCounts;
				boolean flag=false;
				//System.out.println("subComps size= in modify" + subComps.size());
				if (subComps != null) {
					

						 if( ( assetTypeCode.equals("01")|| assetTypeCode.equals("02") ||assetTypeCode.equals("03"))
						 		&& assetCompTypeCode.equals("04") &&
								 assetSubCompTypeCode.equals("001")) 
								{
							for (int i = 0; i < subComps.size(); i++) {
								assetReservior = (Asset_Reservior) subComps.get(i);
								 	//System.out.println("asset code in RWC WELL   "+assetCode);
									//System.out.println("distri code in RWC   "+ assetHeadworks.getSsTankCode());
									//System.out.println("sadiq in cpws OHSR");
									//if(!assetReservior.getAssetCode().equals(""))
									{
										query = "update "+Tab_Prifix+"Ohsr_SC_PARAM_TBL set " 
											  +	"Ohsr_CAP_LTS=nvl('"+ assetReservior.getOhsrCapacityLts() 
											  +"',0), Ohsr_LOC='"+ assetReservior.getOhsrLocation() 
											  +"', Ohsr_SATGES=nvl('"+ assetReservior.getOhsrStages() 
											  +"',0), Ohsr_LWL=nvl('"+ assetReservior.getOhsrLwl() 
											  +"',0),  Ohsr_FILL_HR=nvl('"+  assetReservior.getOhsrFillHrs() 
											  +"',0), Ohsr_EMPTY_HR =nvl('"+ assetReservior.getOhsrEmptyHrs() 
											  +"',0),Ohsr_MWL=nvl('"+ assetReservior.getOhsrMwl() 
											  +"',0), Ohsr_NO_OF_FILLING =nvl('"+assetReservior.getNoOfFillings() 
											  +"',0),hab_code ='"+assetReservior.getHabCode()
											  + "' where asset_code ='" + assetCode 
											  + "' and Ohsr_code ='"+assetReservior.getOhsrCode() 
											   +"'";
										//System.out.println("query1123=" + query);
										empMasterData.stmt.addBatch(query);
									}
									/*else
									{
										query="insert into "+Tab_Prifix+"OHSR_SC_PARAM_TBL   (ASSET_CODE, ohsr_CODE, ohsr_CAP_LTS, ohsr_LOC, ohsr_SATGES, ohsr_LWL,  ohsr_FILL_HR, ohsr_EMPTY_HR ,ohsr_MWL, ohsr_NO_OF_FILLING )  values('"+assetCode+"','"+assetReservior.getOhsrCode()+"',"+assetReservior.getOhsrCapacityLts()+",'"+assetReservior.getOhsrLocation()+"',"+assetReservior.getOhsrStages()+","+assetReservior.getOhsrLwl()+","+assetReservior.getOhsrFillHrs()+","+assetReservior.getOhsrEmptyHrs()+","+assetReservior.getOhsrMwl()+","+assetReservior.getNoOfFillings()+")";
										//System.out.println("query in rwc else  "+query);
										}*/
									rowCount = stm.executeUpdate(query);
									if(rowCount>0)
									//System.out.println("record inserted into rwc   ");
								
							}

					}

					
						else if(( assetTypeCode.equals("01")|| assetTypeCode.equals("02") ||assetTypeCode.equals("03"))
								&& assetCompTypeCode.equals("04") &&
								 assetSubCompTypeCode.equals("002")) 
								{
							for (int i = 0; i < subComps.size(); i++) {
								assetReservior = (Asset_Reservior) subComps.get(i);
								 	//System.out.println("asset code in RWC WELL   "+assetCode);
									//System.out.println("distri code in RWC   "+ assetHeadworks.getSsTankCode());
									//System.out.println("sadiq in cpws OHSR");
									//if(!assetReservior.getAssetCode().equals(""))
									{
										query = "update "+Tab_Prifix+"Ohbr_SC_PARAM_TBL set " 
											  +	"Ohbr_CAP_LTS=nvl('"+ format(assetReservior.getOhbrCapacityLts()) 
											  +"',0), Ohbr_LOC='"+ format(assetReservior.getOhbrLocation()) 
											  +"', Ohbr_SATGES=nvl('"+ format(assetReservior.getOhbrStages())
											  +"',0), Ohbr_LWL=nvl("+ format(assetReservior.getOhbrLwl()) 
											  +"',0),  Ohbr_FILL_HR=nvl('"+  format(assetReservior.getOhbrFillHrs())
											  +"',0), Ohbr_EMPTY_HR =nvl('"+ format(assetReservior.getOhbrEmptyHrs()) 
											  +"',0),Ohbr_MWL=nvl('"+ format(assetReservior.getOhbrMwl()) 
											  + "',0),hab_code ='"+format(assetReservior.getHabCode())
											  +"' where asset_code ='" + format(assetCode )
											  + "' and Ohbr_code ='"+format(assetReservior.getOhbrCode())
											   +"'";
										//System.out.println("query1123=" + query);
										empMasterData.stmt.addBatch(query);
									}
									/*else
									{
										query="insert into "+Tab_Prifix+"Ohbr_SC_PARAM_TBL   (ASSET_CODE, Ohbr_CODE, Ohbr_CAP_LTS, Ohbr_LOC, Ohbr_SATGES, Ohbr_LWL,  Ohbr_FILL_HR, Ohbr_EMPTY_HR ,Ohbr_MWL)  values('"+assetCode+"','"+assetReservior.getOhbrCode()+"',"+assetReservior.getOhbrCapacityLts()+",'"+assetReservior.getOhbrLocation()+"',"+assetReservior.getOhbrStages()+","+assetReservior.getOhbrLwl()+","+assetReservior.getOhbrFillHrs()+","+assetReservior.getOhbrEmptyHrs()+","+assetReservior.getOhbrMwl()+")";
										//System.out.println("query in rwc else  "+query);
										}*/
									rowCount = stm.executeUpdate(query);
									if(rowCount>0)
									//System.out.println("record inserted into rwc   ");
								
							}
							}
						else if(( assetTypeCode.equals("01")|| assetTypeCode.equals("02") ||assetTypeCode.equals("03")) 
								&& assetCompTypeCode.equals("04") &&
								 assetSubCompTypeCode.equals("003")) 
								{
							for (int i = 0; i < subComps.size(); i++) {
								assetReservior = (Asset_Reservior) subComps.get(i);
								 	//System.out.println("asset code in RWC WELL   "+assetCode);
									//System.out.println("distri code in RWC   "+ assetHeadworks.getSsTankCode());
									//System.out.println("sadiq in cpws OHSR");
									//if(!assetReservior.getAssetCode().equals(""))
									{
										query = "update "+Tab_Prifix+"GLSR_SC_PARAM_TBL set " 
											  + "GLSR_CAP_LTS=nvl('"+ format(assetReservior.getGlsrCapacityInLts()) 
											  +"',0), GLSR_LOC='"+ format(assetReservior.getGlsrLocation()) 
											  +"', GLSR_SATGES=nvl('"+ format(assetReservior.getGlsrStages()) 
											  +"',0), GLSR_LWL=nvl('"+ format(assetReservior.getGlsrLwl()) 
											  +"',0),  GLSR_FILL_HR=nvl('"+ format(assetReservior.getGlsrCapacityInLts()) 
											  +"',0), GLSR_EMPTY_HR =nvl('"+ format(assetReservior.getGlsrEmptyHrs()) 
											  +"',0),GLSR_MWL=nvl('"+ format(assetReservior.getGlsrMwl()) 
											  +"',0), GLSR_NO_OF_FILLING =nvl('"+format(assetReservior.getGlsrNoOfFillings()) 
											  +"',0),hab_code ='"+format(assetReservior.getHabCode())
											  +"' where asset_code ='" + format(assetCode) 
											  +"' and glsr_code ='"+format(assetReservior.getGlsrCode()) 
											  +"'";
										//System.out.println("query1123=" + query);
										empMasterData.stmt.addBatch(query);
									}
									/*else
									{
										query="insert into "+Tab_Prifix+"GLSR_SC_PARAM_TBL (ASSET_CODE, GLSR_CODE, GLSR_CAP_LTS, GLSR_LOC, GLSR_SATGES, GLSR_LWL,  GLSR_FILL_HR, GLSR_EMPTY_HR ,GLSR_MWL, GLSR_NO_OF_FILLING )  values('"+assetCode+"','"+assetReservior.getGlsrCode()+"',"+assetReservior.getGlsrCapacityInLts()+",'"+assetReservior.getGlsrLocation()+"',"+assetReservior.getGlsrStages()+","+assetReservior.getGlsrLwl()+","+assetReservior.getGlsrFillHrs()+","+assetReservior.getGlsrEmptyHrs()+","+assetReservior.getGlsrMwl()+","+assetReservior.getGlsrNoOfFillings()+")";

										//System.out.println("query in rwc else  "+query);
										}*/
									rowCount = stm.executeUpdate(query);
									if(rowCount>0)
									//System.out.println("record inserted into rwc   ");
								
							}
							}
						else if(( assetTypeCode.equals("01")|| assetTypeCode.equals("02") ||assetTypeCode.equals("03")) 
								&& assetCompTypeCode.equals("04") &&
								 assetSubCompTypeCode.equals("004")) 
								{
							for (int i = 0; i < subComps.size(); i++) {
								assetReservior = (Asset_Reservior) subComps.get(i);
								 	//System.out.println("asset code in RWC WELL   "+assetCode);
									//System.out.println("distri code in RWC   "+ assetHeadworks.getSsTankCode());
									//System.out.println("sadiq in cpws OHSR");
									//if(!assetReservior.getAssetCode().equals(""))
									{
										query = "update "+Tab_Prifix+"Glbr_SC_PARAM_TBL set " 
											   + "Glbr_CAP_LTS=nvl('"+ format(assetReservior.getGlbrCapacityInLts())
											   +"',0), Glbr_LOC='"+ format(assetReservior.getGlbrLocation()) 
											   +"', Glbr_LWL=nvl('"+ format(assetReservior.getGlbrLwl()) 
											   +"',0),  Glbr_FILL_HR=nvl('"+  format(assetReservior.getGlbrFillHrs()) 
											   +"',0), Glbr_EMPTY_HR =nvl('"+ format(assetReservior.getGlbrEmptyHrs()) 
											   +"',0),Glbr_MWL=nvl('"+ format(assetReservior.getGlbrMwl()) 
											   +"',0),hab_code='"+ format(assetReservior.getHabCode()) 
											   +"' where asset_code ='" + format(assetCode) 
											   + "' and Glbr_code ='"+format(assetReservior.getGlbrCode()) +"'";
										//System.out.println("query1123=" + query);
										empMasterData.stmt.addBatch(query);
									}
									/*else
									{
										query= "insert into "+Tab_Prifix+"Glbr_SC_PARAM_TBL(ASSET_CODE, Glbr_CODE, Glbr_CAP_LTS, Glbr_LOC, Glbr_LWL,  Glbr_FILL_HR, Glbr_EMPTY_HR ,Glbr_MWL)  " 
											 + "values('"+assetCode+"','"
											 + assetReservior.getGlbrCode()+"',"
											 + assetReservior.getGlbrCapacityInLts()+",'"
											 + assetReservior.getGlbrLocation()+"',"
											 + assetReservior.getGlbrLwl()+","
											 + assetReservior.getGlbrFillHrs()+","
											 + assetReservior.getGlbrEmptyHrs()+","
											 + assetReservior.getGlbrMwl()+")";
										//System.out.println("query in glbr  "+query);
										}*/
									rowCount = stm.executeUpdate(query);
									if(rowCount>0)
									//System.out.println("record inserted into rwc   ");
								
							}
							}
						else if(( assetTypeCode.equals("01")|| assetTypeCode.equals("02") ||assetTypeCode.equals("03")) 
								&& assetCompTypeCode.equals("04") &&
								 assetSubCompTypeCode.equals("005")) 
								{
							for (int i = 0; i < subComps.size(); i++) {
								assetReservior = (Asset_Reservior) subComps.get(i);
								 	//System.out.println("asset code in RWC WELL   "+assetCode);
									//System.out.println("distri code in RWC   "+ assetHeadworks.getSsTankCode());
									//System.out.println("sadiq in cpws OHSR");
									//if(!assetReservior.getAssetCode().equals(""))
									{
										query = "update "+Tab_Prifix+"BPT_PARAM_TBL  set  " 
											   + "CAPACITY ='" + format(assetReservior.getBptCapacity()) 
											   +"',STAGING  =nvl('"+ format(assetReservior.getBptStaging()) 
											   + "',0),BPT_MWL =nvl('"+  format(assetReservior.getBptMaxwl()) 
											   + "',0), BPT_LWL =nvl('" +  format(assetReservior.getBptMinwl()) 
											   + "',0),LOCATION ='"+  format(assetReservior.getBptLocation()) 
											   + "',HAB_CODE ='"+  format(assetReservior.getHabCode()) 
											   +"' where asset_code ='" + format(assetCode)
											   + "' and BPT_CODE   ='" + format(assetReservior.getBptCode()) +"'";
										//System.out.println("query1123=" + query);
										empMasterData.stmt.addBatch(query);
									}
									/*else
									{
										query = "insert into "+Tab_Prifix+"BPT_PARAM_TBL (BPT_CODE , CAPACITY  " 
											  +	",STAGING,BPT_MWL,BPT_LWL,LOCATION,ASSET_CODE)  " 
											  +	"values('"+assetReservior.getBptCode()+"',"
											  + assetReservior.getBptCapacity()+","
											  + assetReservior.getBptStaging()+","
											  + assetReservior.getBptMaxwl()+","+assetReservior.getBptMinwl()
											  + ",'"+assetReservior.getBptLocation()
											  + "','"+assetCode+"')";
										//System.out.println("query in rwc else  "+query);
										}*/
									rowCount = stm.executeUpdate(query);
									if(rowCount>0)
									//System.out.println("record inserted into rwc   ");
								
							}
							}
						else if ( (assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03"))
								&& assetCompTypeCode.equals("04")
								&& assetSubCompTypeCode.equals("006")) {
							for (int i = 0; i < subComps.size(); i++) {
								assetReservior = (Asset_Reservior) subComps.get(i);
							//if (!assetReservior.getAssetCode().equals("")) 
								{
								
								query = "update  "+Tab_Prifix+"cis_sc_param_tbl set " 
										+"CIS_LOC ='"+ format(assetReservior.getCisLocation())
										+ "', CIS_CAP_LTS=nvl('"+ format(assetReservior.getCisCapLts())
										+ "',0), CIS_TAP=nvl('"+ format(assetReservior.getCisNoOfTaps())
										+ "',0),CIS_COND='"+ format(assetReservior.getCisCond())
										+ "',CIS_PF ='"+ format(assetReservior.getCisPf())
										+ "',CIS_PF_CON ='"+ format(assetReservior.getCisPfCond())
										+ "', CIS_DRAIN='"+ format(assetReservior.getCisDrain())
										+ "', CIS_TAP_COND ='"+ format(assetReservior.getCisTapCond())
										+ "', HAB_CODE ='"+ format(assetReservior.getHabCode())
										+ "',CIS_HR =nvl('"+ format(assetReservior.getCisHr())
										+ "',0) where asset_code ='"
										+ assetCode
										+ "' and  cissc_CODE='"
										+ assetReservior.getCisCode() + "'";
								//System.out.println("query1123=" + query);
								empMasterData.stmt.addBatch(query);
							} /*else {
								query = "INSERT  INTO "+Tab_Prifix+"cis_sc_param_tbl (ASSET_CODE,CIS_LOC, CIS_CAP_LTS, CIS_COND,CIS_PF, CIS_PF_CON, CIS_DRAIN, CIS_TAP_COND, CIS_HR, CIS_TAP, CISSC_CODE) VALUES('"
										+ assetCode
										+ "','"
										//+ assetReservior.getGlsrNo()
										//+ ","
										//+ assetReservior.getCisCapLts()
										//+ ",'"
										+ assetReservior.getCisLocation()
										+ "',"
										+ assetReservior.getCisCapLts()
										+ ",'"
										+ assetReservior.getCisCond()
										+ "','"
										+ assetReservior.getCisPf()
										+ "','"
										+ assetReservior.getCisPfCond()
										+ "','"
										+ assetReservior.getCisDrain()
										+ "','"
										+ assetReservior.getCisTapCond()
										+ "',"
										+ assetReservior.getCisHr()
										+ ",'"
										+ assetReservior.getCisNoOfTaps()
										+ "','"
										+ assetReservior.getCisCode()
										+ "' )";
								//System.out.println("query in GLSR else  "
										+ query);
								}*/
								rowCount = stm.executeUpdate(query);
								if (rowCount > 0)
									Debug
											.println("record inserted into pws glser  ");
							
						}
						}
				
				}
				int[] updateCounts = empMasterData.stmt.executeBatch();
				for (int j = 0; j < updateCounts.length; j++) {
					
					System.err.print(updateCounts[j] + " in update  ");
					rowCount=updateCounts.length;
				}
				
				empMasterData.conn.commit();
			}

			
			if (compType.equals("Pipeline") && opType.equals("Modify")) {
				//System.out.println("subComps size123  =" + subComps.size());
				if (subComps != null) {
										
						 if((assetTypeCode.equals("01") || assetTypeCode.equals("02") ||assetTypeCode.equals("03"))
								&& assetCompTypeCode.equals("03")
								&& assetSubCompTypeCode.equals("001")) {
							for (int i = 0; i < subComps.size(); i++) {
								assetPipeline = (Asset_PipeLine) subComps.get(i);
							//System.out.println("asset code in Stand post   "
									+ assetCode);
							//System.out.println("Stand post code in distribtion   "
											+ assetPipeline.getDisCode());
							//if (!assetPipeline.getAssetCode().equals("")) 
							{
								/*
								
								asset_pipeline = new Asset_PipeLine();
				       	asset_pipeline.setAssetCode(empMasterData.rs.getString("ASSET_CODE"));
				       	asset_pipeline.setPmCode(empMasterData.rs.getString("PUMPINGMAIN_CODE"));
				       	asset_pipeline.setHabCode(empMasterData.rs.getString("HAB_CODE"));
				        asset_pipeline.setPmLen(empMasterData.rs.getString("LENGTH"));
				       	asset_pipeline.setPmAvNo(empMasterData.rs.getString("AIRVALVE_NO"));
			     	 	asset_pipeline.setPmScrvNo(empMasterData.rs.getString("SCOUREVALVE"));		
			     	 	asset_pipeline.setPmRvNo (empMasterData.rs.getString("REFLEXVALVE"));
			     	 	asset_pipeline.setPmSvNo(empMasterData.rs.getString("SLUICEVALVE"));
			     	 	asset_pipeline.setNoOfPipes(empMasterData.rs.getString("NO_OF_PIPES"));
			     	 	asset_pipeline.setPmZeroVelocityValve(empMasterData.rs.getString("ZERO_VELOCITY_VALVE"));
			     	 	asset_pipeline.setPmAirCusionValve(empMasterData.rs.getString("AIR_CUSHION_VALVE"));
			     	 	asset_pipeline.setPmLocation(empMasterData.rs.getString("LOCATION"));
			     	 	 
						 parameters.add(asset_pipeline);	
								**/
								query = "UPDATE "+Tab_Prifix+"PUMPINGMAIN_TBL   set " 
										+ "HAB_CODE ='"
										+ assetPipeline.getHabCode()
										+ "', LENGTH ='"
										+ format(assetPipeline.getPmLen())
										+ "',AIRVALVE_NO=nvl('"
										+ assetPipeline.getPmAvNo()
										+ "',0),SCOUREVALVE=nvl('"
										+ assetPipeline.getPmScrvNo()
										+ "',0),REFLEXVALVE=nvl('"
										+ assetPipeline.getPmRvNo()
										+ "',0),SLUICEVALVE=nvl('"
										+ assetPipeline.getPmSvNo()
										+ "',0),NO_OF_PIPES =nvl('"
										+ format(assetPipeline.getNoOfPipes())
										+ "',0),ZERO_VELOCITY_VALVE =nvl('"
										+ assetPipeline.getPmZeroVelocityValve()
										+ "',0),AIR_CUSHION_VALVE =nvl('"
										+ assetPipeline.getPmAirCusionValve()
										+ "',0),LOCATION ='"
										+ assetPipeline.getPmLocation()
										+ "' where ASSET_CODE='"
										+ assetCode
										+ "' and PUMPINGMAIN_CODE  ='"
										+ assetPipeline.getPmCode() + "'";

								//System.out.println("query1123=" + query);
								empMasterData.stmt.addBatch(query);
							}
							/*else {
								
								
								
								query = "INSERT into "+Tab_Prifix+"PUMPINGMAIN_TBL (" +
										"ASSET_CODE, PUMPINGMAIN_CODE , HAB_CODE, LENGTH, AIRVALVE_NO, SCOUREVALVE, REFLEXVALVE, SLUICEVALVE, NO_OF_PIPES, ZERO_VELOCITY_VALVE,AIR_CUSHION_VALVE,LOCATION) " 
										+"VALUES('"
										+ assetCode
										+ "','"
										+ assetPipeline.getPmCode()
										+ "','"
										+ assetPipeline.getPmHabCode()
										+ "','"
										+ assetPipeline.getPmLen()
										+ "','"
										+ assetPipeline.getPmAvNo()
										+ "',"
										+ assetPipeline.getPmScrvNo()
										+ ","
										+ assetPipeline.getPmRvNo()
										+ ","
										+ assetPipeline.getPmSvNo()
										+ ","
										+ assetPipeline.getNoOfPipes()
										+ ","
										+ assetPipeline.getPmZeroVelocityValve()
										+ ","
										+ assetPipeline.getPmAirCusionValve()
										+ ","
										+ assetPipeline.getPmLocation()
										+ ")";
								//System.out.println("query in RWS_PWS_PM_SC_PARAM_TBL else  "
										+ query);
								}*/
							rowCount = stm.executeUpdate(query);
							if (rowCount > 0)
								Debug
										.println("record inserted into pws RWS_PWS_PM_SC_PARAM_TBL  ");
						
									
						}
					}
					
					else if((assetTypeCode.equals("01") || assetTypeCode.equals("02") ||assetTypeCode.equals("03"))
								&& assetCompTypeCode.equals("03")
								&& assetSubCompTypeCode.equals("002")) {
							for (int i = 0; i < subComps.size(); i++) {
								//System.out.println(" in for "+i);
								assetPipeline = (Asset_PipeLine) subComps.get(i);
							//System.out.println("asset code in gravity main   "
									+ assetCode);
							//System.out.println("gravity main code "
											+ assetPipeline.getGravitymain_code());
							//if (!assetPipeline.getAssetCode().equals("")) 
							{
								query = "UPDATE "+Tab_Prifix+"GRAVITYMAIN_TBL   set GRAVITYMAIN_CODE ='"
										+ assetPipeline.getGravitymain_code()
										+ "', HAB_CODE  ='"
										+ assetPipeline.getHabCode()
										+ "', LENGTH  =nvl('"
										+ assetPipeline.getLengths()
										+ "',0),AIRVALVE_NO =nvl('"
										+ assetPipeline.getAirvalve_no()
										+ "',0),SCOUREVALVE =nvl('"
										+ assetPipeline.getScourevalve()
										+ "',0),REFLEXVALVE=nvl('"
										+ assetPipeline.getReflexvalve()
										+ "',0),SLUICEVALVE =nvl('"
										+ assetPipeline.getSluicevalve()
										//+ "',0),MET_TYPE ='"
										//+ assetPipeline.getMet_type()
										+ "',0),NO_OF_PIPES =nvl('"
										+ format(assetPipeline.getNoOfPipes())
										+ "',0),LOCATION  ='"
										+ assetPipeline.getGravitymain_location()
										+ "' where ASSET_CODE='"
										+ assetCode
										+ "' and GRAVITYMAIN_CODE  ='"
										+ assetPipeline.getGravitymain_code() + "'";

								//System.out.println("query1123=" + query);
								empMasterData.stmt.addBatch(query);
							} 
							/*else {
								query = "INSERT into "+Tab_Prifix+"GRAVITYMAIN_TBL (ASSET_CODE, GRAVITYMAIN_CODE , HAB_CODE,LENGTH, AIRVALVE_NO, SCOUREVALVE, REFLEXVALVE, SLUICEVALVE, MET_TYPE, LOCATION) VALUES('"
										+ assetCode
										+ "','"
										+ assetPipeline.getGravitymain_code()
										+ "','"
										+ assetPipeline.getHabCode()
										+ "','"
										+ assetPipeline.getLengths()
										+ "','"
										+ assetPipeline.getAirvalve_no()
										+ "','"
										+ assetPipeline.getScourevalve()
										+ "',"
										+ assetPipeline.getReflexvalve()
										+ ","
										+ assetPipeline.getSluicevalve()
										+ ",'"
										+ assetPipeline.getMet_type()
										+ "','"
										+ assetPipeline.getGravitymain_location()
										+ ","
										+ assetPipeline.getNoOfPipes()
										+ "')";
								//System.out.println("query in RWS_PWS_PM_SC_PARAM_TBL else  "
										+ query);
									}*/
							rowCount = stm.executeUpdate(query);
							if (rowCount > 0)
								Debug
										.println("record inserted into "+Tab_Prifix+"GRAVITYMAIN_TBL  ");
					

						}
					}
					else if((assetTypeCode.equals("01") || assetTypeCode.equals("02") ||assetTypeCode.equals("03")) 
								&& assetCompTypeCode.equals("03")
								&& assetSubCompTypeCode.equals("003")) {
							for (int i = 0; i < subComps.size(); i++) {
								assetPipeline = (Asset_PipeLine) subComps.get(i);
							//System.out.println("asset code in distribtion   "
									+ assetCode);
							//System.out.println("distri code in distribtion   "
									+ assetPipeline.getDisCode());
							//if (!assetPipeline.getAssetCode().equals("")) 
							{
								query = "UPDATE "+Tab_Prifix+"DISTRI_SC_PARAM_TBL  set " 
										//+ "DIS_LEN ="
										//+ assetPipeline.getDisTotalLengthNeeded()
										+ "HAB_CODE ='"
										+ assetPipeline.getHabCode()
										+ "',DIS_COVE ='"
										+ assetPipeline.getDisFullVillagesCovered()
										+ "',DIS_LN=nvl('"
										+ assetPipeline.getDisTotalLengthNeeded()
										+ "',0),DIS_TLC=nvl('"
										+ assetPipeline.getDisTotalLengthProvided()
										+ "',0),DIS_BN=nvl('"
										+ assetPipeline.getDisBalanceNeeded()
										//+ ",DIS_MAT_CODE ='"
										//+ assetPipeline.getDisType()
										+ "',0),NO_OF_PIPES=nvl('"
										+ format(assetPipeline.getDisNoOfPipes())
										+ "',0),NO_AIRVALVES=nvl('"
										+ assetPipeline.getDisNoOfAirValves()
										+ "',0),NO_SCOURVALVES =nvl('"
										+ assetPipeline.getDisNoOfScourValves()
										+ "',0),NO_SLUICEVALVES=nvl('"
										+ assetPipeline.getDisNoOfSluiceValves()
										+ "',0),NO_PR_HC=nvl('"
										+ assetPipeline.getDisNoOfPrivateHouseConnections()
										+ "',0),LOCATION="
										+ assetPipeline.getDisLocation()
										+ ",NO_STANDPOSTS=nvl('"
										+ assetPipeline.getDisNoOfStandPosts()
+ "',0) where ASSET_CODE='"
										+ assetCode+ "' and DISTRISC_CODE ='"
										+ assetPipeline.getDisCode() + "'";

								//System.out.println("query1123=" + query);
								empMasterData.stmt.addBatch(query);
							} 
							/*else {
								query = "INSERT INTO "+Tab_Prifix+"DISTRI_SC_PARAM_TBL (ASSET_CODE,HAB_CODE,DIS_LEN,DIS_COVE,DIS_LN,DIS_TLC ,DIS_BN,DISTRISC_CODE,DIS_MAT_CODE,NO_OF_PIPES,HAB_CODE,NO_AIRVALVES,NO_SCOURVALVES,NO_SLUICEVALVES,NO_PR_HC,LOCATION,NO_STANDPOSTS) VALUES('"
										+ assetCode	+ "','"
										+ assetPipeline.getHabCode() + "',"
										+ ""	+ "','"
										+ assetPipeline.getDisFullVillagesCovered() + "',"
										+ assetPipeline.getDisTotalLengthNeeded()+ ","
										+ assetPipeline.getDisTotalLengthProvided()+ ","
										+ assetPipeline.getDisBalanceNeeded()+ ",'"
										+ assetPipeline.getDisCode()+ "',"
										+ "''"	+ ","
										+ assetPipeline.getDisNoOfPipes()+ ",'"
										+ assetPipeline.getDisHabCode()+"',"
										+ assetPipeline.getDisNoOfAirValves()+","
										+ assetPipeline.getDisNoOfScourValves()+","
										+ assetPipeline.getDisNoOfSluiceValves()+","
										+ assetPipeline.getDisNoOfPrivateHouseConnections()+",'"
										+ assetPipeline.getDisLocation()+"',"
										+ assetPipeline.getDisNoOfStandPosts()
										+ ")";
								//System.out.println("query in distri else  "
										+ query);
								}*/
							rowCount = stm.executeUpdate(query);
							if (rowCount > 0)
								Debug
										.println("record inserted into pws distribution  ");
						
						}
						}





					int[] updateCounts = empMasterData.stmt.executeBatch();
					for (int j = 0; j < updateCounts.length; j++) {
						
						System.err.print(updateCounts[j] + " in update  ");
						rowCount=updateCounts.length;
					}
					empMasterData.conn.commit();
					
				}
			}
			//System.out.println("before headworks modify");
			///***************
			//modified by santosh
			//if (compType.equals("Headworks") && opType.equals("Modify")) {
			if (compType.equals("Headworks") && (opType.equals("Modify")||opType.equals("Add New"))) {
				//System.out.println("subComps size= in modify  Headworks" + subComps.size());
				if (subComps != null)
				{
					for (int i = 0; i < subComps.size(); i++) {
						assetHeadworks = (Asset_HeadWorks) subComps.get(i);
						
						
						if((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03")) 
								&& assetCompTypeCode.equals("02") 
								&& assetSubCompTypeCode.equals("001")) 
							{
							 	//System.out.println("asset code in RWC WELL   "+assetCode);
								//System.out.println("distri code in RWC   "+ assetHeadworks.getCollectionWellCode());
								//System.out.println("sadiq in cpws OHSR");
								//if(!assetHeadworks.getAssetCode().equals(""))
								{
									query = "update "+ Tab_Prifix + "RW_COLLWELL_PARAM_TBL  set "
										   + "HAB_CODE= '"+assetHeadworks.getHabCode() 
										   + "',DIAMETER= nvl('"+assetHeadworks.getRwDiameter() 
										   + "',0) , DEPTH = nvl('" + assetHeadworks.getRwDepth() 
										   + "',0), TYPE_OF_FLOORING = '"+assetHeadworks.getRwTypeOfFlooring() 
										   +"', LOCATION ='"+assetHeadworks.getRwLocation()
										   +"', capacity=nvl('"+assetHeadworks.getRwCapacity()
										   +"',0)  where asset_code ='"  + assetCode 
										   + "' and RW_COLLWELL_CODE  ='"+assetHeadworks.getCollectionWellCode ()+"'";
									//System.out.println("query1123=" + query);
									empMasterData.stmt.addBatch(query);
								}
								/*else
								{
									query = "insert into "+ Tab_Prifix + "RW_COLLWELL_PARAM_TBL " 
										  +	"(RW_COLLWELL_CODE, ASSET_CODE, HAB_CODE,DIAMETER," 
										  +	" DEPTH, TYPE_OF_FLOORING,location,capacity)" 
										  +	" values('"+assetHeadworks.getCollectionWellCode() +"','"
										  + assetCode +"',"
										  + assetHeadworks.getHabCode() +", " 
										  + assetHeadworks.getRwDiameter() +", " 
										  + assetHeadworks.getRwDepth() +",'" 
										  + assetHeadworks.getRwTypeOfFlooring() +"','"
										  +assetHeadworks.getRwLocation()+"',"
										  +assetHeadworks.getRwCapacity()+")";
									//System.out.println("query in rwc else  "+query);
									
								}*/
								rowCount = stm.executeUpdate(query);
								if(rowCount>0)
								//System.out.println("record inserted into rwc   ");
							}
						else if((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03")) && assetCompTypeCode.equals("02") &&
							 assetSubCompTypeCode.equals("002")) 
							{
								//System.out.println("***********");
							 	//System.out.println("asset code in RWC WELL   "+assetCode);
								//System.out.println("distri code in RWC   "+ assetHeadworks.getSsTankCode());
								//System.out.println("sadiq in cpws OHSR");
								//if(!assetHeadworks.getAssetCode().equals(""))
								{
									query = "update "+ Tab_Prifix + "SS_SC_PARAM_TBL set " 
										  +	"SS_SIZE=nvl('"+assetHeadworks.getSsSize() 
										  +"',0), CAPACITY_DAYS=nvl('"+ assetHeadworks.getSsCapacityDays() 
										  +"',0), CAPACITY_MCUM=nvl('"+assetHeadworks.getSsCapacityMcum() 
										  +"',0), TANK_ADEQACY=nvl('"+ assetHeadworks.getSsTankAdeq() 
										  +"',0), LOCATION='"+assetHeadworks.getSsTankLocation() 
										  +"',  POWER_CON='"+  assetHeadworks.getPowerConn() 
										  +"',  HAB_CODE='"+  assetHeadworks.getHabCode() 
										  +"', OTHERS=NVL('"+assetHeadworks.getPowerConnOthers()
										  +"',''), DEPTH=NVL('"+assetHeadworks.getSsDepth()
										  +"',0), POWER_HRS=nvl('"+ assetHeadworks.getPowerHours()
										  +"',0) where asset_code='"+ assetCode
										  +"' and sssc_code ='"+   assetHeadworks.getSsTankCode() 
										  +"'";
									//System.out.println("query1123=" + query);
									empMasterData.stmt.addBatch(query);
								}
								/*else
								{
									query="insert into "+ Tab_Prifix + "SS_SC_PARAM_TBL (ASSET_CODE ,SSSC_CODE ,SS_SIZE, DEPTH ,CAPACITY_DAYS ,CAPACITY_MCUM,TANK_ADEQACY,LOCATION , POWER_CON ,POWER_HRS ,OTHERS ) values ('"+ assetCode+"','"+ assetHeadworks.getSsTankCode()+"',nvl('"+ assetHeadworks.getSsSize()+"',0),nvl('"+assetHeadworks.getSsDepth()+"',0), nvl('"+assetHeadworks.getSsCapacityDays() + "',0), nvl('" +assetHeadworks.getSsCapacityMcum()+"',0), '"+ assetHeadworks.getSsTankAdeq() +"','"+ assetHeadworks.getSsTankLocation()+"', '"+ assetHeadworks.getPowerConn()+"', nvl('"+ assetHeadworks.getPowerHours()+"',0),'"+assetHeadworks.getPowerConnOthers()+"')";
									//System.out.println("query in SSTANK  else  "+query);
									
								}*/
								rowCount = stm.executeUpdate(query);
								if(rowCount>0)
								//System.out.println("record inserted into rwc   ");
						}
						else if((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03")) && assetCompTypeCode.equals("02") &&
								 (assetSubCompTypeCode.equals("003") || assetSubCompTypeCode.equals("004"))) 
								{
								 	//System.out.println("asset code in wtp WELL   "+assetCode);
									//System.out.println("distri code in wtp   "+ assetHeadworks.getWtpCode());
									//System.out.println("sadiq in cpws OHSR");
									//if(!assetHeadworks.getAssetCode().equals(""))
									{	if(assetSubCompTypeCode.equals("003"))
										{
										String chkFilter=assetHeadworks.getWtpSedimentationTankValue()+assetHeadworks.getWtpHorizontalRoughingFilterValue()+assetHeadworks.getWtpVerticalRoughingFilterValue();
											query = "update "+ Tab_Prifix + "WTP_SC_PARAM_TBL set " 
												   + "WTP_TYPW ='"+assetHeadworks.getWtpType() 
												   +"', WTP_MLD =nvl('"+ assetHeadworks.getWtpMld() 
												   +"',0), UNITS_NO =nvl('"+assetHeadworks.getWtpUnits() 
												   +"',0), RATE_OF_FILTRATION  =nvl('"+assetHeadworks.getWtpRateOfFiltration() 
												   +"',0), WTP_SIZE ='"+assetHeadworks.getWtpSize() 
												   +"', UNITS_STANDBY =nvl('"+  assetHeadworks.getWtpUnitsStandby() 
												   //+"',0), BACKWASH_FEQ =nvl('"+ assetHeadworks.getWtpBackwashFreq() 
												   +"',0), PERFORMANCE ='"+ assetHeadworks.getWtpPerformance()
												   +"', WTP_MLD =nvl('"+ assetHeadworks.getWtpCapacityUse()
												   +"',0), USE_CAPACITYMLD  =nvl('"+ assetHeadworks.getWtpNoOfHoursOfUsage()
												   +"',0), EXTENTION_SCOPE ='"+ assetHeadworks.getWtpExtentionScope()
												
												   +"', LOCATION ='"+ assetHeadworks.getWtpLocation()
												   +"', HAB_CODE ='"+ assetHeadworks.getHabCode()
												   +"', CHK_FILTER ='"+ chkFilter 
												   +"', FREQ_SAND_SCRAP =nvl('"+ assetHeadworks.getWtpFreqSandScrap()
												   + "',0) where " 
												   //+ "asset_code='"+ assetHeadworks.getAssetCode() +"' and "
												   + "WTPSC_CODE ='"+ assetHeadworks.getWtpCode() +"'";
										}
										else if(assetSubCompTypeCode.equals("004"))
										{
											String chkFilter=assetHeadworks.getWtpClarifloculatorValue()+"0000";
											query = "update "+ Tab_Prifix + "WTP_SC_PARAM_TBL set " 
												   + "WTP_TYPW ='"+assetHeadworks.getWtpType() 
												   + "', WTP_MLD =nvl('"+ assetHeadworks.getWtpMld() 
												   + "',0), UNITS_NO =nvl('"+assetHeadworks.getWtpUnits() 
												   + "',0), RATE_OF_FILTRATION  =nvl('"+assetHeadworks.getWtpRateOfFiltration() 
												   + "',0), WTP_SIZE ='"+assetHeadworks.getWtpSize() 
												   + "', UNITS_STANDBY =nvl('"+  assetHeadworks.getWtpUnitsStandby() 
												   + "',0), BACKWASH_FEQ =nvl('"+ assetHeadworks.getWtpBackwashFreq() 
												   + "',0), PERFORMANCE ='"+ assetHeadworks.getWtpPerformance()
												   + "', USE_CAPACITYMLD =nvl('"+ assetHeadworks.getWtpCapacityUse()
												   + "',0), EXTENTION_SCOPE ='"+ assetHeadworks.getWtpExtentionScope()
												   + "', LOCATION ='"+ assetHeadworks.getWtpLocation()
												   + "', HAB_CODE ='"+ assetHeadworks.getHabCode()
												   + "', CHK_FILTER ='"+ chkFilter 
												   + "' where " 
												   //+ "asset_code='"+ assetHeadworks.getAssetCode() +"' and "
												   + "WTPSC_CODE ='"+ assetHeadworks.getWtpCode() +"'";
										}
										//System.out.println("query1123=" + query);
										empMasterData.stmt.addBatch(query);
										//System.out.println("query in rwc else  "+query);
										rowCount = stm.executeUpdate(query);
										if(rowCount>0)
										//System.out.println("record inserted into rwc   ");
									}
									/*else
									{
										if(assetSubCompTypeCode.equals("003"))
										{
											String chkFilter=assetHeadworks.getWtpSedimentationTankValue()+assetHeadworks.getWtpHorizontalRoughingFilterValue()+assetHeadworks.getWtpVerticalRoughingFilterValue();
											query = " insert into "+ Tab_Prifix + "WTP_SC_PARAM_TBL (ASSET_CODE , WTPSC_CODE,WTP_TYPW,WTP_MLD,UNITS_NO,RATE_OF_FILTRATION ,WTP_SIZE,UNITS_STANDBY, BACKWASH_FEQ,PERFORMANCE,	USE_CAPACITYMLD,EXTENTION_SCOPE,LOCATION,CHK_FILTER) " 
												  + " values( "	+"'"+ assetCode +"', '"
												  + assetHeadworks.getWtpCode() +"', '"
												  + assetHeadworks.getWtpType() +"', "
												  + assetHeadworks.getWtpMld() +","
												  + assetHeadworks.getWtpUnits() +","
												  + assetHeadworks.getWtpRateOfFiltration() +",'"
												  + assetHeadworks.getWtpSize() +"',"
												  + assetHeadworks.getWtpUnitsStandby() +", "
												  + assetHeadworks.getWtpBackwashFreq() +",'"
												  + assetHeadworks.getWtpPerformance()+"',"
												  + assetHeadworks.getWtpCapacityUse()+" ,'"
												  + assetHeadworks.getWtpExtentionScope()+"','"
												  + assetHeadworks.getWtpLocation()+"','"
												  + chkFilter +"')";
										}
										else if(assetSubCompTypeCode.equals("004"))
										{	
											String chkFilter=assetHeadworks.getWtpClarifloculatorValue()+"0000";
											query = "insert into "+ Tab_Prifix + "WTP_SC_PARAM_TBL (ASSET_CODE , WTPSC_CODE,WTP_TYPW,WTP_MLD,UNITS_NO,RATE_OF_FILTRATION ,WTP_SIZE,UNITS_STANDBY, BACKWASH_FEQ,PERFORMANCE,	USE_CAPACITYMLD,EXTENTION_SCOPE,LOCATION,CHK_FILTER) "
												  +	"values( '"+ assetCode +"', '"
												  + assetHeadworks.getWtpCode() +"', '"
												  + assetHeadworks.getWtpType() +"', "
												  + assetHeadworks.getWtpMld() +","
												  +assetHeadworks.getWtpUnits() +","
												  + assetHeadworks.getWtpRateOfFiltration() +",'"
												  +assetHeadworks.getWtpSize() +"',"
												  + assetHeadworks.getWtpUnitsStandby() +", "
												  + assetHeadworks.getWtpBackwashFreq() +",'"
												  + assetHeadworks.getWtpPerformance()+"',"
												  + assetHeadworks.getWtpCapacityUse()+" ,'"
												  + assetHeadworks.getWtpExtentionScope()+"','"
												  + assetHeadworks.getWtpLocation()+"','"
												  + chkFilter +"')";
										}
										//System.out.println("query in rwc else  "+query);
										
									}*/
									rowCount = stm.executeUpdate(query);
									if(rowCount>0)
									//System.out.println("record inserted into rwc   ");
							}
						else if((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03")) 
								&& assetCompTypeCode.equals("02") 
								&& assetSubCompTypeCode.equals("005")) 
								{
								 	//System.out.println("asset code in wtp WELL   "+assetCode);
									////System.out.println("distri code in wtp   "+ assetHeadworks.getWtpCode());
									//System.out.println("sadiq in cpws OHSR");
									//if(!assetHeadworks.getAssetCode().equals(""))
									{
										query = "update "+ Tab_Prifix + "SUMP_M_SC_PARAM_TBL  " 
												  + "set SUMP_CONDITION='"+ assetHeadworks.getSumpCondition() + "'," 
												  + "LOCATION='"+ assetHeadworks.getSumpLocation() + "',"
												  + "HAB_CODE='"+ assetHeadworks.getHabCode() + "',"
												  + "SUMP_MADE_OF='"+ assetHeadworks.getSumpMadeOf() + "',"
												  + "SUMP_DIAMETER="+ assetHeadworks.getSumpDiameter() + ","
												  + "SUMP_DEPTH="+ assetHeadworks.getSumpDepth() + ","
												  + "SUMP_TYPE='"+ assetHeadworks.getSumpType() + "',"
												  + "SUMP_CAPACITY="+  assetHeadworks.getSumpCapacity() +","
												  + "FILLING_HR ="+ assetHeadworks.getSumpFillHr() +","
												  + "EMPTY_TIME_HR="+ assetHeadworks.getSumpEmptyHr() 
												  + " where " 
												  //+	"asset_code ='" + assetHeadworks.getAssetCode() + "' and"
												  +" SUMPCODE ='"+ assetHeadworks.getSumpCode() +"'";
										//System.out.println("query1123=" + query);
										empMasterData.stmt.addBatch(query);
									}
									/*else
									{
										//System.out.println("sump lcoation"+assetHeadworks.getSumpLocation());
										//System.out.println("sump made of"+assetHeadworks.getSumpMadeOf());
										//System.out.println("sump depth"+assetHeadworks.getSumpDepth());
										//System.out.println("sump diameter"+assetHeadworks.getSumpDiameter());
										query = "insert into "+ Tab_Prifix + "SUMP_M_SC_PARAM_TBL" +
												"(ASSET_CODE, SUMPCODE, LOCATION, SUMP_TYPE, SUMP_MADE_OF," +
												" SUMP_DIAMETER, SUMP_DEPTH, SUMP_CAPACITY, FILLING_HR ,EMPTY_TIME_HR ," +
												"  SUMP_CONDITION)  values('"+assetCode+"','"+
												assetHeadworks.getSumpCode()+"','"+
												assetHeadworks.getSumpLocation()+"','"+assetHeadworks.getSumpType()+"','"+
												assetHeadworks.getSumpMadeOf()+"','"+assetHeadworks.getSumpDiameter()+"','"+
												assetHeadworks.getSumpDepth()+"',"+assetHeadworks.getSumpCapacity()+","+
												assetHeadworks.getSumpFillHr()+","+assetHeadworks.getSumpEmptyHr()+",'"+
												assetHeadworks.getSumpCondition()+"')";
												//System.out.println("query in SUMP else  "+query);
									}*/
									
									rowCount = stm.executeUpdate(query);
									if(rowCount>0)
									//System.out.println("record inserted into rwc   ");
							}
						else if((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03")) && assetCompTypeCode.equals("02") &&
								 assetSubCompTypeCode.equals("006")) 
								{
								 	//System.out.println("asset code in wtp WELL   "+assetCode);
									//System.out.println("distri code in wtp   "+ assetHeadworks.getWtpCode());
									//System.out.println("sadiq in cpws OHSR");
									//if(!assetHeadworks.getAssetCode().equals(""))
									{
										query = "update "+ Tab_Prifix + "FP_BRIDGE_PARAM_TBL  set " 
											  //+	"BRIDGE_TYPE='"+ assetHeadworks.getBridgeType() 
											  +	"HAB_CODE='"+ assetHeadworks.getHabCode() 
											  +"',BRIDGE_LENGTH=NVL("+ assetHeadworks.getBridgeLength() 
											  +",0), BRIDGE_WIDTH=NVL("+  assetHeadworks.getBridgeWidth() 
											  //+",0), BRIDGE_WALK_WAY_WIDTH  ="+ assetHeadworks.getBridgeWalkwaywidth() 
											  //+",LENGTH_OF_THE_BRIDGE=NVL("+ assetHeadworks.getBridgeLength() 
											  //+",0), BRIDGE_SPAN_LENGTH=NVL("+ assetHeadworks.getBridgeSpanLength() 
											  + ",0) where " 
											  //+	" asset_code ='" + assetCode + "' and " 
											  +	" BRIDGE_CODE  ='"+ assetHeadworks.getBridgeCode() +"'";
										//System.out.println("query1123=" + query);
										empMasterData.stmt.addBatch(query);
									}
									/*else
									{
										query = "insert into "+ Tab_Prifix + "FP_BRIDGE_PARAM_TBL " +
												"(ASSET_CODE, BRIDGE_CODE, BRIDGE_TYPE,BRIDGE_LENGTH, " +
												"BRIDGE_WIDTH ,BRIDGE_WALK_WAY_WIDTH,  BRIDGE_SPAN_LENGTH)  " +
												"values('"+assetCode+"','"+assetHeadworks.getBridgeCode()+"','"
												+assetHeadworks.getBridgeType()+"',NVL("
												+assetHeadworks.getBridgeLength()
												+",0),NVL("+assetHeadworks.getBridgeWidth()+",0),NVL("
												+assetHeadworks.getBridgeWalkwaywidth()+",0),NVL("
												+assetHeadworks.getBridgeSpanLength()+",0))";
												//System.out.println("query in rwc else  "+query);
									}*/
									
									rowCount = stm.executeUpdate(query);
									if(rowCount>0)
									//System.out.println("record inserted into rwc   ");
							}
						else if((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03")) 
								&& assetCompTypeCode.equals("02") &&
								 assetSubCompTypeCode.equals("007")) 
								{
								 	//System.out.println("asset code in wtp WELL   "+assetCode);
									////System.out.println("distri code in wtp   "+ assetHeadworks.getWtpCode());
									//System.out.println("sadiq in cpws OHSR");
									//if(!assetHeadworks.getAssetCode().equals(""))
									{
										query = "update "+ Tab_Prifix + "PUMPHOUSE_PARAM_TBL  set " 
											   + "TYPE ='"+ assetHeadworks.getPumpHouseType() +"'," 
											   + "LOCATION ='"+ assetHeadworks.getPumpHouseLocation() +"'," 
											   + "HAB_CODE ='"+ assetHeadworks.getHabCode() +"'," 
											   + "AREA ="+ assetHeadworks.getPumpHouseArea() +"," 
											   + "HEIGHT="+  assetHeadworks.getPumpHouseHeight() 
											   + " where " 
											   //+ "asset_code ='" + assetHeadworks.getAssetCode() + "' and " 
											   + " PUMPHOUSE_CODE  ='"+ assetHeadworks.getPumpHouseCode() +"'";
										//System.out.println("query1123=" + query);
										empMasterData.stmt.addBatch(query);
									}
									/*else
									{
										query = "insert into "+ Tab_Prifix + "PUMPHOUSE_PARAM_TBL  (TYPE ,AREA  ,LOCATION,HEIGHT,ASSET_CODE, PUMPHOUSE_CODE)  " 
											  +	"values('"+assetHeadworks.getPumpHouseType()+"','"
											  + assetHeadworks.getPumpHouseArea()+"',"
											  + assetHeadworks.getPumpHouseLocation()+","
											  + assetHeadworks.getPumpHouseHeight()+",'"
											  + assetCode+"','"
											  +assetHeadworks.getPumpHouseCode()+"')";
											  //System.out.println("query in rwc else  "+query);
									}*/
									
									rowCount = stm.executeUpdate(query);
									if(rowCount>0)
									//System.out.println("record inserted into rwc   ");
							}
						else if((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03")) && assetCompTypeCode.equals("02") &&
								  assetSubCompTypeCode.equals("008")) 
								{
								 	//System.out.println("asset code in ss filter    "+assetCode);
									//System.out.println("distri code in ss filter   "+ assetHeadworks.getWatchManCode());
									//System.out.println("sadiq in cpws ss filter");
									//if(!assetHeadworks.getAssetCode().equals(""))
									{
										query = "update "+ Tab_Prifix + "WATCHMAN_PARAM_TBL  set " 
											  +	"TYPE ='"+assetHeadworks.getWatchManType() 
											  +	"',HAB_CODE ='"+assetHeadworks.getHabCode() 
											  +	"',LOCATION ='"+assetHeadworks.getWatchManLocation() 
											  +"', AREA =nvl('"+ assetHeadworks.getWatchManArea() 
											  +"',0), NO_OF_QTRS =nvl('"+assetHeadworks.getWatchManNoOfQuarters() 
											  +"',0) where " 
											  //+	"asset_code ='"+ assetCode +"' and " 
											  +	" WATCHMAN_CODE ='"+ assetHeadworks.getWatchManCode() +"'";
										//System.out.println("query123=" + query);
										empMasterData.stmt.addBatch(query);
									}
									/*else
									{
										query = "insert into "+ Tab_Prifix + "WATCHMAN_PARAM_TBL (ASSET_CODE ,WATCHMAN_CODE,TYPE, AREA, NO_OF_QTRS) values( '"+ assetCode +"', '"+ assetHeadworks.getWatchManCode() +"','"+ assetHeadworks.getWatchManType() +"','"+ assetHeadworks.getWatchManArea() +"'," + assetHeadworks.getWatchManNoOfQuarters() +")"; 
										//System.out.println("query in rwc else  "+query);
										
									}*/
									rowCount = stm.executeUpdate(query);
									if(rowCount>0)
									//System.out.println("record inserted into ss filter   ");
							}

						else if((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03")) && assetCompTypeCode.equals("02") &&
								  assetSubCompTypeCode.equals("009")) 
								{
								 	//System.out.println("asset code in ss filter    "+assetCode);
									//System.out.println("distri code in ss filter   "+ assetReservior.getOhsrCode());
									//System.out.println("sadiq in cpws ss filter");
									//if(!assetHeadworks.getAssetCode().equals(""))
									{
										query = "update "+ Tab_Prifix + "CW_COLLWELL_PARAM_TBL  set " 
												+ "DIAMETER= "+ assetHeadworks.getRwDiameter() 
											    + " , DEPTH = " + assetHeadworks.getRwDepth() 
												+ ", TYPE_OF_FLOORING = '"+assetHeadworks.getRwTypeOfFlooring() 
												+ "', HAB_CODE = '"+assetHeadworks.getHabCode() 
												+ "', LOCATION = '"+assetHeadworks.getRwLocation()
												+ "', CAPACITY = '"+assetHeadworks.getRwCapacity()
												+ "'  where " 
												//+ "asset_code ='"  + assetHeadworks.getAssetCode()	+ "'  and"
												+ " CW_COLLWELL_CODE  ='"+assetHeadworks.getCollectionWellCode ()
												+"'";
										//System.out.println("query1123=" + query);
										empMasterData.stmt.addBatch(query);
									}
									/*else
									{	
										query = "insert into "+ Tab_Prifix 
										+ "CW_COLLWELL_PARAM_TBL (CW_COLLWELL_CODE, ASSET_CODE, DIAMETER, " 
										+ "DEPTH, TYPE_OF_FLOORING, LOCATION, CAPACITY) " 
										+ "values('"+assetHeadworks.getCollectionWellCode() +"','"
										+ assetCode +"',"
										+ assetHeadworks.getRwDiameter() +", " 
										+ assetHeadworks.getRwDepth() +",'" 
										+ assetHeadworks.getRwTypeOfFlooring()+"','"
										+ assetHeadworks.getRwLocation()+"','"
										+ assetHeadworks.getRwCapacity()+"'"
										+")";
										//System.out.println("query in rwc else  "+query);
										}*/
									rowCount = stm.executeUpdate(query);
									if(rowCount>0)
									//System.out.println("record inserted into ss filter   ");
								
							}
						
					}
				}
				int [] updateCounts = empMasterData.stmt.executeBatch();	
				for (int j = 0; j< updateCounts.length; j++) {
					
					System.err.print(updateCounts[j] + " in update  ");
				}
				empMasterData.conn.commit();
				
			}
			

		} catch (Exception e) {
			//System.out.println("Error in insertAssetSubCompParams="
					+ e);
		} finally {

			empMasterData.closeAll();
		}

		return rowCount;
	}
	public static int insertHabInSub(DataSource dataSource, String tabPrifix , String tempSubCode , String habCode,String subCompCode,String assetCode)
	{
		int rowCount=0;
		//System.out.println("in insertHabInSub");
		EmpMasterData empMasterData=new EmpMasterData();
		try
		{
			String query=null;
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs=null;
			String q1="select count(*) from "+tabPrifix+" where "+tempSubCode+"='"+subCompCode+"'";
			int cnt=0;
			//System.out.println("q1 is "+q1);
			empMasterData.rs=empMasterData.stmt.executeQuery(q1);
			if(empMasterData.rs.next())
			{
				cnt=empMasterData.rs.getInt(1);
			}
			if(cnt>0)
			{
			query="update "+tabPrifix+" set hab_code='"+habCode+"' where "+tempSubCode+"='"+subCompCode+"'";
			}
			else
				query="insert into "+tabPrifix+"("+tempSubCode+",hab_code,asset_code) values('"+subCompCode+"', '"+habCode+"' ,'"+assetCode+"')";
			//System.out.println("query in insertHabInSub  "+query);
			rowCount=empMasterData.stmt1.executeUpdate(query);	
			
			//System.out.println("rowcount in EmpMaster :"+rowCount);
		}
		catch(Exception e){//System.out.println("Error :"+e);}
		finally{
			try{
			//empMasterData.stmt1.close();
			//empMasterData.stmt.close();
			empMasterData.closeAll();}
			catch(Exception e){//System.out.println("Exception in closing connection"+e);}
		
		}
		
		
		return rowCount;
	}
	
	public static String getHabCode(DataSource dataSource, String tabPrifix , String tempSubCode ,String subCompCode)
	{
		String habCode="";
		//System.out.println("in getHabCode");
		EmpMasterData empMasterData=new EmpMasterData();
		try
		{
			String hab_code_field="hab_code";
			if(tabPrifix.equals("RWS_OPEN_WELL_MAST_TBL"))
				hab_code_field="HABITATION_CODE ";
			if(tabPrifix.equals("RWS_HP_SUBCOMP_PARAM_TBL"))
				hab_code_field="substr(HP_CODE,1,16) ";
			
			String query=null;
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs=null;
			String q1="select "+hab_code_field+" from "+tabPrifix+" where "+tempSubCode+"='"+subCompCode+"'";
			
			int cnt=0;
			//System.out.println("q1 is "+q1);
			empMasterData.rs=empMasterData.stmt.executeQuery(q1);
			if(empMasterData.rs.next())
			{
				habCode=empMasterData.rs.getString(1);
				cnt++;
			}
			if(cnt==0)
			{
			habCode="";
			}
			
			//System.out.println("query in getHabCode is  "+query);
		}
		catch(Exception e){//System.out.println("Error in getHabCode :"+e);}
		finally{
			try{
			//empMasterData.stmt.close();
			empMasterData.closeAll();}
			catch(Exception e){//System.out.println("Exception in closing connection"+e);}
		
		}
		
		
		
		return habCode;
	}
	
	public static EmpMaster getAsset(String assetCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		Collection panchRajs = new ArrayList();
		Collection sources = new ArrayList();
		Collection pipeLine = new ArrayList();
		Collection headWorks = new ArrayList();
		Collection reservior = new ArrayList();
		PanchRaj panchRaj = new PanchRaj();
		Asset_SubComponent assetSources = new Asset_SubComponent();
		Asset_HeadWorks assetHeadworks = new Asset_HeadWorks();
		Asset_PipeLine assetPipeline = new Asset_PipeLine();
		Asset_Reservior assetReservior = new Asset_Reservior();
		EmpMaster empMaster = null;
		String habCode = null;
		String assetTypeCode = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.stmt2 = empMasterData.conn.createStatement();

			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from RWS_ASSET_MAST_TBL where asset_code='"
							+ assetCode + "'");
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setAssetCode(empMasterData.rs.getString(1));
				empMaster.setAssetName(empMasterData.rs.getString(2));
				empMaster.setAssetTypeCode(empMasterData.rs.getString(3));
				empMaster.setAssetTypeName(getAssetTypeName(empMasterData.rs.getString(3),
						empMasterData.conn));
				//System.out.println("$$$$$$$$$$$$$$$$"
						+ getAssetTypeName(empMasterData.rs.getString(3), empMasterData.conn)
						+ "$$$$$$$$$$$$$");
				empMaster.setHabCode(empMasterData.rs.getString(4) + " "
						+ getHabName(empMasterData.rs.getString(4), empMasterData.conn));
				habCode = empMasterData.rs.getString(4);
				assetTypeCode = empMasterData.rs.getString(3);
				//System.out.println("assetTypeCode=" + assetTypeCode
						+ "habCode=" + habCode + "district="
						+ habCode.substring(0, 2) + "mandal="
						+ habCode.substring(5, 7) + "pcode="
						+ habCode.substring(12, 14) + "vcode="
						+ habCode.substring(7, 10));
				empMaster.setLocation(empMasterData.rs.getString(5));
				if (empMasterData.rs.getDate(6) != null)
					empMaster.setDateofCreation(df.format(empMasterData.rs.getDate(6)));
				empMaster.setAssetStatus(empMasterData.rs.getString(7));
				empMaster.setAssetCost(empMasterData.rs.getString(8));
				empMaster.setStartYear(empMasterData.rs.getString(9));
				empMaster.setEndYear(empMasterData.rs.getString(10));
				empMaster.setDcode(habCode.substring(0, 2));
				empMaster.setDistrict(getDistrictName(habCode.substring(0, 2),
						empMasterData.conn));
				empMaster.setMandal(habCode.substring(5, 7));
				empMaster.setMandalName(getMandalName(habCode.substring(0, 2),
						habCode.substring(5, 7), empMasterData.conn));
				empMaster.setPCode(getPanchayatName(habCode.substring(0, 2),
						habCode.substring(5, 7), habCode.substring(12, 14),
						empMasterData.conn));
				//System.out.println("pname="
						+ getPanchayatName(habCode.substring(0, 2), habCode
								.substring(5, 7), habCode.substring(12, 14),
								empMasterData.conn));
				empMaster.setVCode(getVillageName(habCode.substring(0, 2),
						habCode.substring(5, 7), habCode.substring(12, 14),
						habCode.substring(7, 10), empMasterData.conn));
				//System.out.println("vname="
						+ getVillageName(habCode.substring(0, 2), habCode
								.substring(5, 7), habCode.substring(12, 14),
								habCode.substring(7, 10), empMasterData.conn));
				empMaster.setCoc(empMasterData.rs.getString(11) + " "
						+ getCircleOfficeName("1", empMasterData.rs.getString(11), empMasterData.conn));
				empMaster.setDoc(empMasterData.rs.getString(12)
						+ " "
						+ getDivisionOfficeName("1", empMasterData.rs.getString(11), empMasterData.rs
								.getString(12), empMasterData.conn));
				empMaster.setSdoc(empMasterData.rs.getString(13)
						+ " "
						+ getSubDivisionOfficeName("1", empMasterData.rs.getString(11), empMasterData.rs
								.getString(12), empMasterData.rs.getString(13), empMasterData.conn));

			}
			ResultSet rset = empMasterData.stmt1
					.executeQuery("select SCHEME_CODE from RWS_ASSET_SCHEME_TBL where ASSET_CODE='"
							+ assetCode + "'");
			while (rset.next()) {
				empMaster.setSchemeCode(rset.getString(1));
			}
			String query="select * from rws_panchayat_raj_tbl where panch_code in(select hab_code from rws_asset_hab_tbl where asset_code='"
				+ assetCode + "')";
			//System.out.println("query in getAsset is "+query);
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery(query);
			
		
			int temp = 1;
			while (empMasterData.rs1.next()) {
				temp = 0;
				panchRaj = new PanchRaj();
				panchRaj.setHabCode(empMasterData.rs1.getString(2));
				panchRaj.setHabName(empMasterData.rs1.getString(3));
				panchRajs.add(panchRaj);
			}

			if (assetTypeCode.equals("04") || temp == 1) {
				ResultSet rs4 = empMasterData.stmt1
						.executeQuery("select * from rws_panchayat_raj_tbl where panch_code='"
								+ habCode + "'");
				while (rs4.next()) {
					panchRaj = new PanchRaj();
					panchRaj.setHabCode(rs4.getString(2));
					panchRaj.setHabName(rs4.getString(3));
					panchRajs.add(panchRaj);
				}
			}
			empMaster.setAssetHabs(panchRajs);

			/*
			 * ResultSet rs2=stmt2.executeQuery("select * from
			 * rws_asset_subcomp_param_tbl where asset_code='"+assetCode+"'");
			 * while(rs2.next()) { if(rs2.getInt(2) == 1) { assetSources =new
			 * Asset_SubComponent();
			 * assetSources.setAssetSubComp(getAssetSubComponentName("01",empMasterData.rs.getString(3),rs2.getString(3),empMasterData.conn));
			 * assetSources.setDiameter(rs2.getString(4));
			 * assetSources.setDepth(rs2.getString(5));
			 * assetSources.setYield(rs2.getString(6));
			 * assetSources.setType(rs2.getString(7));
			 * assetSources.setDemand(rs2.getString(8));
			 * assetSources.setCapacity(rs2.getString(9));
			 * assetSources.setHead(rs2.getString(10));
			 * sources.add(assetSources); } else if(rs2.getInt(2) == 2) {
			 * assetHeadworks = new Asset_HeadWorks();
			 * assetHeadworks.setAssetSubComp(getAssetSubComponentName("02",empMasterData.rs.getString(3),rs2.getString(3),empMasterData.conn));
			 * assetHeadworks.setDiameter(rs2.getString(4));
			 * assetHeadworks.setDepth(rs2.getString(5));
			 * assetHeadworks.setDesignPeriod(rs2.getString(11));
			 * assetHeadworks.setCapacity(rs2.getString(9));
			 * assetHeadworks.setSize(rs2.getString(12));
			 * assetHeadworks.setBedsPumpsets(rs2.getString(14));
			 * assetHeadworks.setRateOfFiltration(rs2.getString(15));
			 * assetHeadworks.setRemarks(rs2.getString(22));
			 * headWorks.add(assetHeadworks); } else if(rs2.getInt(2) == 3) {
			 * assetPipeline = new Asset_PipeLine();
			 * assetPipeline.setAssetSubComp(getAssetSubComponentName("03",empMasterData.rs.getString(3),rs2.getString(3),empMasterData.conn));
			 * assetPipeline.setType(rs2.getString(7));
			 * assetPipeline.setPclass(rs2.getString(17));
			 * assetPipeline.setDiameter(rs2.getString(4));
			 * assetPipeline.setLength(rs2.getString(18));
			 * assetPipeline.setValves(rs2.getString(19));
			 * assetPipeline.setPublicStandPosts(rs2.getString(20));
			 * assetPipeline.setHouseConnections(rs2.getString(21));
			 * pipeLine.add(assetPipeline); } else if(rs2.getInt(2) == 4) {
			 * assetReservior = new Asset_Reservior();
			 * assetReservior.setAssetSubComp(getAssetSubComponentName("04",empMasterData.rs.getString(3),rs2.getString(3),empMasterData.conn));
			 * assetReservior.setOhsr(rs2.getString(9));
			 * assetReservior.setOhbr(rs2.getString(22));
			 * reservior.add(assetReservior); } }
			 */
			empMaster.setAssetSubComponents(sources);
			empMaster.setAssetHeadWorks(headWorks);
			empMaster.setAssetPipeLine(pipeLine);
			empMaster.setAssetReservior(reservior);

		} catch (Exception e) {
			//System.out.println("The error in getAsset=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getAssetHabCodes(DataSource dataSource,
			String habCode, String pumpCode, String assetTypeCode)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		ArrayList panchRajs = new ArrayList();
		PanchRaj panchRaj = new PanchRaj();
		String schemeCode = habCode + pumpCode;
		//System.out.println("Scheme code=" + schemeCode + "typeOfAsset="
				+ assetTypeCode);

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			String query="select * from rws_panchayat_raj_tbl where panch_code in(select h.hab_code from rws_asset_hab_tbl h,rws_asset_scheme_tbl s where s.asset_code=h.asset_code and s.scheme_code='"
				+ schemeCode + "')";
			//System.out.println("query is "+query);
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery(query);
			int temp = 1;
			while (empMasterData.rs1.next()) {
				temp = 0;
				panchRaj = new PanchRaj();
				panchRaj.setHabCode(empMasterData.rs1.getString(2));
				panchRaj.setHabName(empMasterData.rs1.getString(3));
				panchRajs.add(panchRaj);
			}

			if (assetTypeCode.equals("04") || temp == 1) {
				ResultSet rs4 = empMasterData.stmt1
						.executeQuery("select * from rws_panchayat_raj_tbl where panch_code='"
								+ habCode + "'");
				while (rs4.next()) {
					panchRaj = new PanchRaj();
					panchRaj.setHabCode(rs4.getString(2));
					panchRaj.setHabName(rs4.getString(3));
					panchRajs.add(panchRaj);
				}
			}
		} catch (Exception e) {
			//System.out.println("Error in getAsset HabCodes=" + e.getMessage());
		}
		finally {
			empMasterData.closeAll();
		}
		return panchRajs;
	}

	public static ArrayList getAssets(String coc, String doc, String sdoc,
			String mcode, String pcode, String vcode, String habCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList assets = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			String dcode = coc;
			String query = "";
			//System.out.println("coc=" + coc + "doc=" + doc + "VALUE OF sdoc=" + sdoc
					+ "mcode=" + mcode + "pcode=" + pcode + "vcode=" + vcode);
			if ((coc != null && !coc.equals(""))
					&& (doc != null && !doc.equals(""))
					&& (sdoc != null && !sdoc.equals(""))
					&& (habCode != null && !habCode.equals("")))
				query = "select AM.ASSET_CODE,AM.ASSET_NAME,AM.TYPE_OF_ASSET_CODE,AM.HAB_CODE,AM.LOCATION,AM.DATE_CREATION,AM.ASSET_STATUS,AM.ASSET_COST ,AM.START_YEAR,AM.END_YEAR,AST.SCHEME_CODE from RWS_ASSET_MAST_TBL AM,RWS_ASSET_SCHEME_TBL AST where AM.CIRCLE_OFFICE_CODE='"
						+ coc
						+ "' and AM.DIVISION_OFFICE_CODE='"
						+ doc
						+ "' and AM.SUBDIVISION_OFFICE_CODE='"
						+ sdoc
						+ "' and AM.HAB_CODE='"
						+ habCode
						+ "' and AST.asset_code=AM.asset_code order by AM.asset_code";
			else if ((coc != null && !coc.equals(""))
					&& (doc != null && !doc.equals(""))
					&& (sdoc != null && !sdoc.equals("")) && (mcode != null))
				query = "select AM.ASSET_CODE,AM.ASSET_NAME,AM.TYPE_OF_ASSET_CODE,AM.HAB_CODE,AM.LOCATION,AM.DATE_CREATION,AM.ASSET_STATUS,AM.ASSET_COST ,AM.START_YEAR,AM.END_YEAR,AST.SCHEME_CODE from RWS_ASSET_MAST_TBL AM,RWS_ASSET_SCHEME_TBL AST where AM.CIRCLE_OFFICE_CODE='"
						+ coc
						+ "' and AM.DIVISION_OFFICE_CODE='"
						+ doc
						+ "' and AM.SUBDIVISION_OFFICE_CODE='"
						+ sdoc
						+ "' and substr(AM.HAB_CODE,1,2) ='"
						+ dcode
						+ "' and substr(AM.HAB_CODE,6,2)='"
						+ mcode
						+ "' and AST.asset_code=AM.asset_code order by AM.asset_code";
			else if ((coc != null && !coc.equals(""))
					&& (doc != null && !doc.equals(""))
					&& (sdoc != null && !sdoc.equals("")) && (mcode != null)
					&& (pcode != null && !pcode.equals("")))
				query = "select AM.ASSET_CODE,AM.ASSET_NAME,AM.TYPE_OF_ASSET_CODE,AM.HAB_CODE,AM.LOCATION,AM.DATE_CREATION,AM.ASSET_STATUS,AM.ASSET_COST ,AM.START_YEAR,AM.END_YEAR,AST.SCHEME_CODE from RWS_ASSET_MAST_TBL AM,RWS_ASSET_SCHEME_TBL AST where AM.CIRCLE_OFFICE_CODE='"
						+ coc
						+ "' and AM.DIVISION_OFFICE_CODE='"
						+ doc
						+ "' and AM.SUBDIVISION_OFFICE_CODE='"
						+ sdoc
						+ "' and substr(AM.HAB_CODE,1,2) ='"
						+ dcode
						+ "' and substr(AM.HAB_CODE,6,2)='"
						+ mcode
						+ "' and substr(AM.HAB_CODE,13,2)='"
						+ pcode
						+ "' and AST.asset_code=AM.asset_code order by AM.asset_code";
			else if ((coc != null && !coc.equals(""))
					&& (doc != null && !doc.equals(""))
					&& (sdoc != null && !sdoc.equals("")) && (mcode != null)
					&& (pcode != null && !pcode.equals(""))
					&& (vcode != null && !vcode.equals("")))
				query = "select AM.ASSET_CODE,AM.ASSET_NAME,AM.TYPE_OF_ASSET_CODE,AM.HAB_CODE,AM.LOCATION,AM.DATE_CREATION,AM.ASSET_STATUS,AM.ASSET_COST ,AM.START_YEAR,AM.END_YEAR,AST.SCHEME_CODE from RWS_ASSET_MAST_TBL AM,RWS_ASSET_SCHEME_TBL AST where AM.CIRCLE_OFFICE_CODE='"
						+ coc
						+ "' and AM.DIVISION_OFFICE_CODE='"
						+ doc
						+ "' and AM.SUBDIVISION_OFFICE_CODE='"
						+ sdoc
						+ "' and substr(AM.HAB_CODE,1,2) ='"
						+ dcode
						+ "' and substr(AM.HAB_CODE,6,2)='"
						+ mcode
						+ "' and substr(AM.HAB_CODE,13,2)='"
						+ pcode
						+ "' and substr(AM.HAB_CODE,8,3)='"
						+ vcode
						+ "' and AST.asset_code=AM.asset_code order by AM.asset_code";
			//System.out.println("query=" + query);
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			int i = 0;
			while (empMasterData.rs.next()) {
				i = i + 1;
				empMaster = new EmpMaster();
				empMaster.setAssetCode(empMasterData.rs.getString(1));
				empMaster.setAssetName(empMasterData.rs.getString(2));

				empMaster.setAssetTypeCode(empMasterData.rs.getString(3));
				empMaster.setAssetTypeName(getAssetTypeName(empMasterData.rs.getString(3),
						empMasterData.conn));

				empMaster.setHabCode(empMasterData.rs.getString(4));
				empMaster.setHabName(getHabName(empMasterData.rs.getString(4), empMasterData.conn));

				empMaster.setLocation(empMasterData.rs.getString(5));
				if (empMasterData.rs.getDate(6) != null)
					empMaster.setDateofCreation(df.format(empMasterData.rs.getDate(6)));
				empMaster.setAssetStatus(empMasterData.rs.getString(7));
				if (empMasterData.rs.getInt(7) == 1) {
					empMaster.setAssetStatusName("Working");
				} else if (empMasterData.rs.getInt(7) == 2) {
					empMaster.setAssetStatusName("Not Working");
				} else if (empMasterData.rs.getInt(7) == 3) {
					empMaster.setAssetStatusName("Dried");
				} else if (empMasterData.rs.getInt(7) == 4) {
					empMaster.setAssetStatusName("Seasonal");
				} else if (empMasterData.rs.getInt(7) == 5) {
					empMaster.setAssetStatusName("Condemed");
				}
				empMaster.setAssetCost(empMasterData.rs.getString(8));
				empMaster.setStartYear(empMasterData.rs.getString(9));
				empMaster.setEndYear(empMasterData.rs.getString(10));
				empMaster.setSchemeCode(empMasterData.rs.getString(11));
				assets.add(empMaster);
			}

			//System.out.println("count=" + i);
		} catch (Exception e) {
			//System.out.println("The error in getAssets is  " + e);
		} finally {
			empMasterData.closeAll();
		}
		return assets;
	}

	public static int[] removeAsset(String assetCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int[] count = new int[5];

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.conn.setAutoCommit(false);
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt
					.addBatch("delete from RWS_ASSET_SUBCOMP_PARAM_TBL where asset_code='"
							+ assetCode + "'");
			empMasterData.stmt.addBatch("delete from RWS_ASSET_HAB_TBL where asset_code='"
					+ assetCode + "'");
			empMasterData.stmt.addBatch("delete from RWS_ASSET_SCHEME_TBL where asset_code='"
					+ assetCode + "'");
			empMasterData.stmt.addBatch("delete from RWS_ASSET_MAST_TBL where asset_code='"
					+ assetCode + "'");
			count = empMasterData.stmt.executeBatch();
			empMasterData.conn.commit();
		} catch (Exception e) {
			//System.out.println("The error in removeAsset=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return count;
	}


	public static int[] updateAsset(EmpMaster empMaster, ArrayList habs,
			ArrayList sources, ArrayList headworks, ArrayList pipeline,
			ArrayList reservior, String assetCompTypeCode,
			String assetSubCompTypeCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		PanchRaj panchRaj = new PanchRaj();
		Asset_SubComponent assetSources = new Asset_SubComponent();
		Asset_HeadWorks assetHeadworks = new Asset_HeadWorks();
		Asset_PipeLine assetPipeline = new Asset_PipeLine();
		Asset_Reservior assetReservior = new Asset_Reservior();
		//System.out.println("habs.size()=" + habs.size());
		//System.out.println("sources.size()=" + sources.size());
		//System.out.println("headworks.size()=" + headworks.size());
		//System.out.println("pipeline.size()=" + pipeline.size());
		//System.out.println("reservior.size()=" + reservior.size());
		String habCode = "";
		String assetTypeCode = "";
		String query1 = "";
		String insertQuery="";
		int[] updateCounts = new int[50];
		try {
			assetTypeCode = empMaster.getAssetTypeCode();
			empMasterData.conn = dataSource.getConnection();
			String query = "select hab_code from RWS_ASSET_MAST_TBL where asset_code='"
					+ empMaster.getAssetCode() + "'";
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			if (empMasterData.rs.next())
				habCode = empMasterData.rs.getString(1);
			//System.out.println("select assetmast query=" + query + "habCode="
					+ habCode);
			empMasterData.conn.setAutoCommit(false);
			query = "update RWS_ASSET_MAST_TBL set ASSET_NAME='"
					+ empMaster.getAssetName().toUpperCase() + "',LOCATION='"
					+ empMaster.getLocation().toUpperCase()
					+ "',DATE_CREATION=TO_DATE('"
					+ empMaster.getDateofCreation()
					+ "','dd/mm/yyyy'),ASSET_COST =" + empMaster.getAssetCost()
					+ ",START_YEAR='" + empMaster.getStartYear()
					+ "',END_YEAR='" + empMaster.getEndYear()
					+ "',ASSET_STATUS=" + empMaster.getAssetStatus()
					+ " where asset_code='" + empMaster.getAssetCode() + "'";
			//System.out.println("update asset query=" + query);
			empMasterData.stmt.addBatch(query);
			query = "delete from RWS_ASSET_HAB_TBL where asset_code='"
					+ empMaster.getAssetCode() + "'";
			//System.out.println("delete assethab query=" + query);
			empMasterData.stmt.addBatch(query);

			for (int i = 0; i < habs.size(); i++) {
				panchRaj = (PanchRaj) habs.get(i);
				if (panchRaj.getHabCode() != null) {
					if (panchRaj.getHabCode().equals(habCode))
						//System.out.println("habCode in equal=" + habCode);
					else
						empMasterData.stmt.addBatch("insert into RWS_ASSET_HAB_TBL values('"
								+ empMaster.getAssetCode() + "','"
								+ panchRaj.getHabCode() + "'");
				}
			}

			for (int i = 0; i < sources.size(); i++) {
				assetSources = (Asset_SubComponent) sources.get(i);
				if (assetTypeCode.equals("04")
						&& assetCompTypeCode.equals("01")
						&& assetSubCompTypeCode.equals("001"))
					query1 = "update RWS_HP_SUBCOMP_PARAM_TBL set " 
						   + "LOCATION = '"  + assetSources.getLocation() 
						   //+ "',DRILL_YEAR ='" + assetSources.getYearOfDrilling() + "'," 
						   + "',DIAMETER = "+ assetSources.getDiameter() 
						   + ",CASING ='"  + assetSources.getCasing() + "'," 
						   //+ "STATUS = '"+ assetSources.getStatus() 
						   + ",GEN_CONDITION = '"+ assetSources.getGenCondition() 
						   + "', GI_NO = " 	+ assetSources.getGino() + "," 
						   + " PAINTED = '"	+ assetSources.getPainted() 
						   + "', STATIC_WL="	+ assetSources.getStaticWaterLevel() + "" 
						   + ", SUMMER_WL="+ assetSources.getSummerWaterLevel() 
						   + ", P_COND='"+ assetSources.getPcond() 
						   //+ "',DRY_DURING ='"+ assetSources.getDryduring() 
						   //+ "', SERVICE='"+ assetSources.getService() 
						   + "', SER_NO ="+ assetSources.getSerno() + "," 
						   + " SER_HRS = "+ assetSources.getSerhrs() 
						   + ", REPAIRS='"+ assetSources.getRepairs() 
						   + "', PLATFORM_CONDITION='" + format(assetSources.getPlatformCondition()) 
						   + "', DRAIN='"+ assetSources.getDrain() 
						   + "', DRAIN_CONDITION='"	+ assetSources.getDrainCondition() 
						   + "',DRAIN_SD='"+ assetSources.getDrainsd() 
						   + "', DRAIN_LP ='" + assetSources.getDrainlp() 
						   + "', HYGIENE ='"+ assetSources.getHygiene() 
						   + "', AVG_TIME = "+ assetSources.getAvgtime() 
						   + ", P_YEILD ="	+ assetSources.getPyield() 
						   + ", PYEILD_LOCAL = '"+ assetSources.getPyieldLocal() 
						   + "'," +	"PERIOD ='"+ assetSources.getPeriod() 
						   + "',DEPTH= "+ assetSources.getDepth() 
						   + ",QUALITY_AFFECTED='"+ assetSources.getQualityAffected() 
						   + "'," +	" FLOURIDE ="+ assetSources.getFlouride() 
						   + ", BRAKISH ="+ assetSources.getBrakish() 
						   + ", IRON ="+ assetSources.getIron()
						   +", cont_others_type = '"+assetSources.getOtherspecify()
						   + "' where ASSET_CODE='"
						   + empMaster.getAssetCode() + "'";
				
				else if (assetTypeCode.equals("01")
						&& assetCompTypeCode.equals("01")
						&& assetSubCompTypeCode.equals("001"))
					query1 = "update RWS_PWS_SUBCOMP_PARAM_TBL set POP_DES="
							+ assetSources.getPopDes() + ",SOURCE ='"
							+ assetSources.getSource() + "',SOUR_QLTY='"
							+ assetSources.getSourceQuality() + "',SOUR_YEILD="
							+ assetSources.getSourceYield() + ",SOUR_DEPEN='"
							+ assetSources.getSourceDepend() + "',SOUR_DEPTH="
							+ assetSources.getSourceDepth()
							+ ",SOUR_DIAMETER ="
							+ assetSources.getSourceDiameter() + ",SOUR_COND='"
							+ assetSources.getSourceCondition()
							+ "',SOUR_SWL =" + assetSources.getSourceSwl()
							+ ",SOUR_NWL=" + assetSources.getSourceNwl()
							+ ",PH_SIZE='" + assetSources.getPhSize()
							+ "',PH_COND='" + assetSources.getPhCondition()
							+ "',PH_TYPE='" + assetSources.getPhType()
							+ "',PUMP_NAME ='" + assetSources.getPumpName()
							+ "',PUMP_CPTY=" + assetSources.getPumpCapacity()
							+ ",PUMP_TYPE='" + assetSources.getPumpType()
							+ "',YEAR_PUR=" + assetSources.getPurYear()
							+ ",HR_RUN=" + assetSources.getHrRun() + ",HR_SIN="
							+ assetSources.getHrSin() + ",HR_MS ="
							+ assetSources.getHrMs() + ",STA_EXE='"
							+ assetSources.getStaExe() + "',PUMP_DUTY_LPM="
							+ assetSources.getPumpDutyLpm()
							+ ",PUMP_DUTY_HEAD="
							+ assetSources.getPumpDutyHead()
							+ " where ASSET_CODE='" + empMaster.getAssetCode()
							+ "'";
				//System.out.println("query1=" + query1);

				empMasterData.stmt.addBatch(query1);
			}
			
			for (int i = 0; i < pipeline.size(); i++) {
				assetPipeline = (Asset_PipeLine) pipeline.get(i);
				String query3 = "update  RWS_ASSET_SUBCOMP_PARAM_TBL set type='"
						+ assetPipeline.getType()
						+ "',class='"
						+ assetPipeline.getPclass()
						+ "',diameter='"
						+ assetPipeline.getDiameter()
						+ "',length='"
						+ assetPipeline.getLength()
						+ "',valves='"
						+ assetPipeline.getValves()
						+ "',PUBLIC_POSTS='"
						+ assetPipeline.getPublicStandPosts()
						+ "',HOUSE_CONN='"
						+ assetPipeline.getHouseConnections()
						+ "' where asset_code='"
						+ empMaster.getAssetCode()
						+ "' and ASSET_SUBCOMPONENT_CODE='"
						+ getAssetSubCompCode(getAssetTypeCode(empMaster.getAssetTypeCode(), empMasterData.conn), "03", assetPipeline
								.getAssetSubComp(), empMasterData.conn)
						+ "' and ASSET_COMPONENT_CODE='03'";

				empMasterData.stmt.addBatch(query3);
			}
			for (int i = 0; i < reservior.size(); i++) {
				assetReservior = (Asset_Reservior) reservior.get(i);
				if (assetTypeCode.equals("01")
						&& assetCompTypeCode.equals("04")
						&& assetSubCompTypeCode.equals("001"))
					query1 = "update RWS_PWS_OHSR_SC_PARAM_TBL  set  OHSR_NO="
							+ assetReservior.getOhsrNo() + ",OHSR_LTS ="
							+ assetReservior.getOhrsLts() + ",OHSR_LOCATION ='"
							+ assetReservior.getOhsrLocation()
							+ "',OHSR_CAP_LTS="
							+ assetReservior.getOhsrCapacityLts()
							+ ",OHSR_MADE='" + assetReservior.getOhsrMade()
							+ "',OHSR_HT =" + assetReservior.getOhsrHt()
							+ ",OHSR_COND='" + assetReservior.getOhsrCond()
							+ "',OHSR_FILL_HRS ="
							+ assetReservior.getOhsrFillHrs() + ",OHSR_EMPTY="
							+ assetReservior.getOhsrEmptyHrs() + ",OHSR_HYG='"
							+ assetReservior.getOhsrHygiene() + "',OHSR_FEN='"
							+ assetReservior.getOhsrFen() + "'";
				else if (assetTypeCode.equals("03")
						&& assetCompTypeCode.equals("04")
						&& assetSubCompTypeCode.equals("001"))
					query1 = "update RWS_CPWS_OHSR_SC_PARAM_TBL  set  OHSR_CODE='"
							+ assetReservior.getOhsrCode()
							+ "',OHSR_CAP_LTS ="
							+ assetReservior.getOhsrCapacityLts()
							+ ",OHSR_LOC ='"
							+ assetReservior.getOhsrLocation()
							+ "',OHSR_SATGES ="
							+ assetReservior.getOhsrStages()
							+ ",OHSR_LWL="
							+ assetReservior.getOhsrLwl()
							+ ",OHSR_MWL  ="
							+ assetReservior.getOhsrMwl()
							+ ",OHSR_FILL_HR ="
							+ assetReservior.getOhsrFillHrs()
							+ ",OHSR_EMPTY_HR="
							+ assetReservior.getOhsrEmptyHrs() + "";
				else if (assetTypeCode.equals("03")
						&& assetCompTypeCode.equals("04")
						&& assetSubCompTypeCode.equals("002"))
					query1 = "update RWS_CPWS_OHBR_SC_PARAM_TBL  set  OHBR_CODE='"
							+ assetReservior.getOhbrCode()
							+ "',OHBR_CAP_LTS  ="
							+ assetReservior.getOhbrCapacityLts()
							+ ",OHBR_LOC ='"
							+ assetReservior.getOhbrLocation()
							+ "',OHBR_SATGES ="
							+ assetReservior.getOhbrStages()
							+ ",OHBR_LWL="
							+ assetReservior.getOhbrLwl()
							+ ",OHBR_MWL  ="
							+ assetReservior.getOhbrMwl()
							+ ",OHBR_FILL_HR ="
							+ assetReservior.getOhbrFillHrs()
							+ ",OHBR_EMPTY_HR="
							+ assetReservior.getOhbrEmptyHrs() + "";
				else if (assetTypeCode.equals("03")
						&& assetCompTypeCode.equals("04")
						&& assetSubCompTypeCode.equals("003"))
					query1 = "update RWS_CPWS_GLSR_SC_PARAM_TBL  set  GLSR_CODE='"
							+ assetReservior.getGlsrCode()
							+ "',GLSR_CAP_LTS  ="
							+ assetReservior.getGlsrCapacityInLts()
							+ ",GLSR_LOC ='"
							+ assetReservior.getGlsrLocation()
							+ "',GLSR_SATGES ="
							+ assetReservior.getGlsrStages()
							+ ",GLSR_LWL ="
							+ assetReservior.getGlsrLwl()
							+ ",GLSR_MWL   ="
							+ assetReservior.getGlsrMwl()
							+ ",GLSR_FILL_HR ="
							+ assetReservior.getGlsrFillHrs()
							+ ",GLSR_EMPTY_HR="
							+ assetReservior.getGlsrEmptyHrs() + "";
				else if (assetTypeCode.equals("03")
						&& assetCompTypeCode.equals("04")
						&& assetSubCompTypeCode.equals("004"))
					query1 = "update RWS_CPWS_GLBR_SC_PARAM_TBL  set  GLBR_CODE='"
							+ assetReservior.getGlbrCode()
							+ "',GLBR_CAP_LTS  ="
							+ assetReservior.getGlbrCapacityInLts()
							+ ",GLBR_LOC ='"
							+ assetReservior.getGlbrLocation()
							+ "',GLBR_LWL ="
							+ assetReservior.getGlbrLwl()
							+ ",GLBR_MWL   ="
							+ assetReservior.getGlbrMwl()
							+ ",GLBR_FILL_HR ="
							+ assetReservior.getGlbrFillHrs()
							+ ",GLBR_EMPTY_HR="
							+ assetReservior.getGlbrEmptyHrs() + "";
				//System.out.println("query1=" + query1);
				empMasterData.stmt.addBatch(query1);
			}

			updateCounts = empMasterData.stmt.executeBatch();
			empMasterData.conn.commit();
		} catch (Exception b) {
			//System.out.println("Update counts in UpdateAsset is: " + b);
		} finally {
			empMasterData.closeAll();
		}
		return updateCounts;
	}
	


	public static String getAssetCode(String coc, String doc, String sdoc,
			String habCode, String typeOfAsset, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String assetCode = null;
		String query = "";

		try {

			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			/*query = "SELECT MAX(to_number(ASSET_CODE))+1 FROM RWS_ASSET_MAST_TBL where  TYPE_OF_ASSET_CODE='"
					+ typeOfAsset
					+ "' and CIRCLE_OFFICE_CODE='"
					+ coc
					+ "' and DIVISION_OFFICE_CODE='"
					+ doc
					+ "' and SUBDIVISION_OFFICE_CODE='"
					+ sdoc
					+ "' and substr(HAB_CODE,6,2)='" + habCode.substring(5,7) + "'";
			*/
			query = "SELECT MAX(to_number(ASSET_CODE))+1 FROM RWS_ASSET_MAST_TBL where  substr(asset_code,7,2)='"
			+ typeOfAsset
			+ "' and CIRCLE_OFFICE_CODE='"
			+ coc
			+ "' and DIVISION_OFFICE_CODE='"
			+ doc
			+ "' and SUBDIVISION_OFFICE_CODE='"
			+ sdoc
			+ "' and substr(HAB_CODE,6,2)='" + habCode.substring(5,7) + "'";
	
	
			//System.out.println("query in getAssetCode=" + query);
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			empMasterData.rs.next();
			assetCode = empMasterData.rs.getString(1);
			if (assetCode == null) {
				assetCode = "0001";
			} else if (assetCode.length() == 1) {
				assetCode = "000" + assetCode;
			} else if (assetCode.length() == 2) {
				assetCode = "00" + assetCode;
			} else if (assetCode.length() == 3) {
				assetCode = "0" + assetCode;
			}

		} catch (Exception e) {
			//System.out.println("The error in getAssetCode=" + e);
		} finally {
			empMasterData.closeAll();
		}

		return assetCode;
	}

	public static ArrayList getAssetCompTypesOnAssetType(String assetTypeCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList assets = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from RWS_ASSET_COMPONENT_TYPE_TBL where TYPE_OF_ASSET_CODE="
							+ assetTypeCode + " order by ASSET_COMPONENT_CODE");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setAssetCompTypeCode(empMasterData.rs
						.getString("ASSET_COMPONENT_CODE"));
				empMaster.setDistNoName(empMasterData.rs.getString("ASSET_COMPONENT_CODE")
						+ " - " + empMasterData.rs.getString("ASSET_COMPONENT_NAME"));
				assets.add(empMaster);
			}
		} catch (Exception e) {
			Debug
					.println("The error in getAssetCompTypesOnAssetType=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return assets;
	}

	//**********************************Public Represntatives
	// methods**********************************

	public static int insertPublicRep(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps=empMasterData.conn.PrepedStatement("insert into RWS_PUBLIC_REP_TBL values(?,?)"); 
			ps.setString(1,empMaster.getPublicRepCode());
			ps.setString(2, empMaster.getPublicRepName().toUpperCase() );
			rowCount = ps.executeUpdate();
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println("The error in insertPublicRep=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getPublicRep(String publicRepCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from RWS_PUBLIC_REP_TBL where REP_CODE="
							+ publicRepCode);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setPublicRepCode(empMasterData.rs.getString(1));
				empMaster.setPublicRepName(empMasterData.rs.getString(2));
			}
		} catch (Exception e) {
			//System.out.println("The error in getPublicRep=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getPublicReps(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList publicReps = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from RWS_PUBLIC_REP_TBL order by to_number(rep_code)");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setPublicRepCode(empMasterData.rs.getString(1));
				empMaster.setPublicRepName(empMasterData.rs.getString(2));

				publicReps.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getPublicReps=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return publicReps;
	}

	public static int removePublicRep(String publicRepCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int del = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement pst=empMasterData.conn.prepareStatement("delete  from RWS_PUBLIC_REP_TBL where REP_CODE=?");
			ps.setString(1,publicRepCode);
			del = ps.executeUpdate();
		} catch (Exception e) {
			//System.out.println("The error in removePublicRep=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return del;
	}

	public static int updatePublicRep(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int updateCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			updateCount = empMasterData.stmt
					.executeUpdate("update  RWS_PUBLIC_REP_TBL set REP_NAME='"
							+ empMaster.getPublicRepName().toUpperCase()
							+ "' where REP_CODE='"
							+ empMaster.getPublicRepCode() + "'");
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println("The error in updatePublicRep=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return updateCount;
	}

	public static String getPublicRepCode(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String code = null;
		try {
			empMasterData.conn = dataSource.getConnection();

			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT MAX(to_number(REP_CODE))+1 FROM RWS_PUBLIC_REP_TBL");
			empMasterData.rs.next();
			code = empMasterData.rs.getString(1);
			if (code == null) {
				code = "01";
			} else if (code.length() == 1) {
				code = "0" + code;
			}
		} catch (Exception e) {
			//System.out.println("The error in getPublicRepCode" + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	//**********************************Public Institution
	// methods**********************************

	public static int insertInstitute(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement pst=empMasterData.conn.prepareStatement("insert into RWS_PUBLIC_INSTITUTE_TBL values(?,?)");
			ps.setString(1, empMaster.getInstituteCode());
			ps.setString(2,empMaster.getInstituteName().toUpperCase() );
			rowCount = ps.executeUpdate();
			
		} catch (SQLException e) {
			//System.out.println("The error in insertInstitute" + e);
			//System.out.println("The error code is " + e.getErrorCode());
			int errorCode = e.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println("Error in insertInstitute " + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getInstitute(String instituteCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from RWS_PUBLIC_INSTITUTE_TBL where INST_CODE="
							+ instituteCode);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setInstituteCode(empMasterData.rs.getString(1));
				empMaster.setInstituteName(empMasterData.rs.getString(2));
			}
		} catch (Exception e) {
			//System.out.println("The error in getInstitute" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getInstitutes(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList institutes = new ArrayList();

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select inst_code,inst_name from RWS_PUBLIC_INSTITUTE_TBL order by to_number(INST_CODE)");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setInstituteCode(empMasterData.rs.getString(1));
				empMaster.setInstituteName(empMasterData.rs.getString(2));
				empMaster
						.setInsDisplay(empMasterData.rs.getString(1) + "-" + empMasterData.rs.getString(2));
				institutes.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getInstitutes=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return institutes;
	}

	public static int removeInstitute(String instituteCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rcount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rcount = empMasterData.stmt
					.executeUpdate("delete  from RWS_PUBLIC_INSTITUTE_TBL where INST_CODE='"
							+ instituteCode + "'");
		} catch (Exception e) {
			//System.out.println("The error in removeInstitute" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rcount;
	}

	public static int updateInstitute(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int updateCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps=empMasterData.conn.prepareStatement("update  RWS_PUBLIC_INSTITUTE_TBL set INST_NAME=?  where INST_CODE=?");
			ps.setString(1,empMaster.getInstituteName().toUpperCase());
			ps.setString(2,empMaster.getInstituteCode());
			updateCount = ps.executeUpdate();
					
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			//System.out.println("The error in updateHead " + sqle);
		} catch (Exception e) {
			//System.out.println("The error in updateInstitute" + e);
		} finally {
			empMasterData.closeAll();
		}
		return updateCount;
	}

	public static String getInstituteCode(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String code = null;
		try {
			empMasterData.conn = dataSource.getConnection();

			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT MAX(to_number(INST_CODE))+1 FROM RWS_PUBLIC_INSTITUTE_TBL");
			empMasterData.rs.next();
			code = empMasterData.rs.getString(1);
			if (code == null) {
				code = "1";
			} else if (code.length() == 1) {
				code = "0" + code;
			}
		} catch (Exception e) {
			//System.out.println("The error in getInstituteCode=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	//****************************************************************************************//
	public static int[] insertHabStatus(EmpMaster empMaster, ArrayList insts,
			ArrayList waterSupply, DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		HabInstitute habInstitute = new HabInstitute();
		ContaminationTypes contaminationTypes = null;
		HabWaterSupply habWS = new HabWaterSupply();
		int[] updateCounts = new int[insts.size()];
		String habCode = empMaster.getHabCode();
		boolean check = true,exists=false;
		boolean insUpdate = false, cnsUpdate = false, flag = false;
		String StatusDate = null;		
		
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.conn.setAutoCommit(false);
			empMasterData.stmt = empMasterData.conn.createStatement();
			//System.out.println("habCode=" + habCode);
			//String query = "select count(*) from RWS_HABITATION_DIRECTORY_TBL where hab_code='"+ habCode + "'";
			String query = "select * from RWS_HABITATION_DIRECTORY_TBL where hab_code='"
					+ habCode + "'";
			
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			if (empMasterData.rs.next()) {
				//if (empMasterData.rs.getInt(1) > 0)
					StatusDate =df.format(empMasterData.rs.getDate("STATUS_DATE"));
					check = false;
						}
			//System.out.println("qa "+empMaster.getQualityAffected()+  "con named"+empMaster.getContamName() +"perc "+empMaster.getPercent());
			String finyr = empMaster.getHabYear();
			//System.out.println("fin yrs 6666666 sliue  "+finyr);
			String finyrMon = finyr.substring(3,5);
			finyr = finyr.substring(6,10);
			//System.out.println("DT vsliue  "+finyrMon);
			//System.out.println("fin yrs  sliue  "+finyr);
			int fyr = Integer.parseInt(finyr);
			int fyrMon = Integer.parseInt(finyrMon);
			if(fyrMon>4)
			{
				fyr = fyr + 1;
				finyr = finyr +"-"+fyr;
				//System.out.println("fin yrs  sliue  "+finyr);
			}
			else
			{
				fyr = fyr - 1;
				finyr = fyr +"-"+finyr;
				//System.out.println("fin yrs  sliue  "+finyr);
				//System.out.println("circle code "+empMaster.getCircleOfficeCode());
			}
			
			if (check) {
				//System.out.println("Insert empMaster.getExistWaterLevel()"
						+ empMaster.getExistWaterLevel());
				query = "insert into RWS_HABITATION_DIRECTORY_TBL values("
						+ "'" + empMaster.getCircleOfficeCode() + "'," + empMaster.getDivisionOfficeCode()
						+ "," + "'" + empMaster.getSubdivisionOfficeCode() + "','"
						+ empMaster.getHabCode() + "'," + "'"
						+ empMaster.getCensusYear() + "',"
						+ empMaster.getCensusPop() + "," + ""
						+ empMaster.getCensusSc() + ","
						+ empMaster.getCensusSt() + "," + ""
						+ empMaster.getFloatPop() + ",'"
						+ empMaster.getFloatReason() + "'," + "TO_DATE('"
						+ empMaster.getHabYear() + "','dd/mm/yyyy')," + ""
						+ empMaster.getPopCovered() + ","
						+ empMaster.getScCovered() + "," + ""
						+ empMaster.getStCovered() + ","
						+ empMaster.getTotalWaterSupply() + "," + ""
						+ empMaster.getExistWaterLevel() + "," + "'"
						+ empMaster.getCoveredStatus() + "'," + ""
						+ empMaster.getNearWaterSource() + "," + ""
						+ empMaster.getNearWaterGroundSource() + "," + "'"
						+ empMaster.getRemarks() + "','"
						+ empMaster.getQualityAffected() + "'," + "TO_DATE('"
						+ empMaster.getUpdateDate() + "','dd/mm/yyyy'),'"
						//+ empMaster.getStatusAsOn1405() + "')";
						+ empMaster.getPrevYrStatus() + "','"
						+ empMaster.getPresentvYrStatus() + "','"
						+ empMaster.getProposedFcYr() + "',"
						+ empMaster.getProposedFCAmt() + ")";
				//System.out.println("Hab Directory Query is : \n" + query);
				empMasterData.stmt.addBatch(query);
				for (int i = 0; i < insts.size(); i++) {
					habInstitute = (HabInstitute) insts.get(i);
					//System.out.println("habInstitute.getInstituteNo()="
							+ habInstitute.getInstituteNo());
					if (habInstitute.getInstituteNo().length() != 0) {
						//System.out.println("habInstitute.getInstituteNo()="
								+ habInstitute.getInstituteNo());
						query = "insert into rws_hab_institute_tbl values("
								+ "'" + empMaster.getHabCode() + "'," + "'"
								+ habInstitute.getInstituteCode() + "'," + "'"
								+ habInstitute.getInstituteNo() + "'," + "'"
								+ habInstitute.getInstituteCovered() + "')";
						empMasterData.stmt.addBatch(query);
						//System.out.println("Hab Institute Query is : \n"
								+ query);
					}
				}
				if (empMaster.getQualityAffected().equals("Y") || empMaster.getCoveredStatus().equals("NSS"))
					if (Double.parseDouble(empMaster.getPercent()) != 0.0) {
						
							
						query = "insert into RWS_HAB_CONTAMINATION_TBL values("
								+ "'" + empMaster.getHabCode() + "'," + "'"
								+ empMaster.getContamName() + "'," + ""
								+ empMaster.getPercent() +"','"
								+ finyr +"',"
								+"TO_DATE('"+ empMaster.getUpdateDate() + "','dd/mm/yyyy'))";
						empMasterData.stmt.addBatch(query);
						//System.out.println("Hab Component Query is : \n"
								+ query);
					}
					
					String q1 = "select * from rws_hab_supply_status_tbl where hab_code='"
						+ habCode + "'";
				
				empMasterData.rs =empMasterData.stmt.executeQuery(query);
						if (empMasterData.rs.next())
						exists = true;
							
				if(!exists)
				{
				query = "insert into rws_hab_supply_status_tbl(hab_code,SHP_DK_SUPPLY,SHP_NO,HPS_OTH_SUPPLY,HPS_NO,PWS_SUPPLY,PWS_NO,CPWS_SUPPLY,CPWS_NO,MPWS_SUPPLY,MPWS_NO,DIRECT_PUMPING_SUPPLY,DIRECT_PUMPING_NO,OWS_OTH_SUPPLY,OWS_NO,PONDS_OTH_SUPPLY,PONDS_NO,DW_TANKS_SUPPLY,DW_TANKS_NO,STAT_OF_HAB) "
						+ "values('"
						+ empMaster.getHabCode()
						+ "','"
						+ empMaster.getShpSupply()
						+ "','"
						+ empMaster.getShpNo()
						+ "','"
						+ empMaster.getHpSupply()
						+ "','"
						+ empMaster.getHpNo()
						+ "','"
						+ empMaster.getPwsSupply()
						+ "','"
						+ empMaster.getPwsNo()
						+ "','"
						+ empMaster.getCpwsSupply()
						+ "','"
						+ empMaster.getCpwsNo()
						+ "',"
						+ "'"
						+ empMaster.getMpwsSupply()
						+ "','"
						+ empMaster.getMpwsNo()
						+ "','"
						+ empMaster.getDpSupply()
						+ "','"
						+ empMaster.getDpNo()
						+ "','"
						+ empMaster.getOwsSupply()
						+ "','"
						+ empMaster.getOwsNo()
						+ "','"
						+ empMaster.getPondsSupply()
						+ "','"
						+ empMaster.getPondsNo()
						+ "','"
						+ empMaster.getDwSupply()
						+ "',"
						+ "'"
						+ empMaster.getDwNo()
						+ "','"
						+ empMaster.getStatus()
						+ "')";
				//System.out.println("HabSupply query=" + query);
				empMasterData.stmt.addBatch(query);
			} 
			}else {

				query = " SELECT count(*) FROM rws_hab_contamination_tbl WHERE hab_code = '"
						+ habCode + "'";
				//System.out.println("query in contaminatin  "+query);
				empMasterData.rs =empMasterData.stmt.executeQuery(query);
				if (empMasterData.rs.next()) {
					if (empMasterData.rs.getInt(1) > 0)
						cnsUpdate = true;
				}

				empMasterData.conn.setAutoCommit(false);
				empMasterData.stmt = empMasterData.conn.createStatement();
				
				//System.out.println("sataus1"+StatusDate+"ali");
				//System.out.println("sataus2"+empMaster.getHabYear()+"sadiq");
				if(StatusDate!=null && !StatusDate.equals(empMaster.getHabYear().trim()))
				{
			String query1 = "insert into RWS_HABITATION_DIR_HIS_TBL values(?,?,?,?,?,?,?,?,?,?,TO_DATE(?,'dd/mm/yyyy'),?,?,?,?,?,?,?,?,?,?,TO_DATE(?,'dd/mm/yyyy'),?,?,?,?)";
			PreparedStatement ps=conn.PrepareStatement(query1);
			ps.setString(1, empMaster.getCircleOfficeCode());
			ps.setString(2, empMaster.getDivisionOfficeCode());
			ps.setString(3,  empMaster.getSubdivisionOfficeCode());
			ps.setString(4, empMaster.getHabCode());
			ps.setString(5,empMaster.getCensusYear());
			ps.setString(6,empMaster.getCensusPop());
			ps.setString(7,empMaster.getCensusSc());
			ps.setString(8, empMaster.getCensusSt());
			ps.setString(9, empMaster.getFloatPop());
			ps.setString(10, empMaster.getFloatReason()) ;
			ps.setString(11, empMaster.getHabYear());
			ps.setString(12, empMaster.getPopCovered());
			ps.setString(13, empMaster.getScCovered());
			ps.setString(14, empMaster.getStCovered());
			ps.setString(15, empMaster.getTotalWaterSupply());
			ps.setString(16, empMaster.getExistWaterLevel());
			ps.setString(17, empMaster.getStatus());
			ps.setString(18, empMaster.getNearWaterSource());
			ps.setString(19, empMaster.getNearWaterGroundSource());
			ps.setString(20, empMaster.getRemarks());
			ps.setString(21, empMaster.getQualityAffected());
			ps.setString(22, empMaster.getUpdateDate());
			ps.setString(23, empMaster.getPrevYrStatus());
			ps.setString(24, empMaster.getPresentvYrStatus());
			ps.setString(25, empMaster.getProposedFcYr());
			ps.setString(26, empMaster.getProposedFCAmt());
				//System.out.println("Hab Directory histroy Query is : \n" + query1);
				int i = ps.executeUpdate();
				if(i>0)
					//System.out.println("Record insert into dic his tab");
				else
					//System.out.println("Record not  inserted");

				}
				query = " UPDATE RWS_HABITATION_DIRECTORY_TBL "
						+ " SET CENSUS_YEAR='" + empMaster.getCensusYear()
						+ "'," + " CENSUS_PLAIN_POPU='"
						+ empMaster.getCensusPop() + "'," + " CENSUS_SC_POPU='"
						+ empMaster.getCensusSc() + "'," + " CENSUS_ST_POPU='"
						+ empMaster.getCensusSt() + "'," + " FLOAT_POP='"
						+ empMaster.getFloatPop() + "',"
						+ " FLOAT_POP_REASONS='" + empMaster.getFloatReason()
						+ "'," + " STATUS_DATE=TO_DATE('"
						+ empMaster.getHabYear() + "','dd/mm/yyyy'),"
						+ " PLAIN_POPU_COVERED='" + empMaster.getPopCovered()
						+ "'," + " SC_POP_COVERED='" + empMaster.getScCovered()
						+ "'," + " ST_POP_COVERED='" + empMaster.getStCovered()
						+ "'," + " TOTAL_WATER_SUPPLY='"
						+ empMaster.getTotalWaterSupply() + "',"
						+ " EXIST_WATER_LEVEL='"
						+ empMaster.getExistWaterLevel() + "',"
						+ " COVERAGE_STATUS='" + empMaster.getStatus() + "',"
						+ " NEAR_SURFACE_SOURCE='"
						+ empMaster.getNearWaterSource() + "',"
						+ " NEAR_GROUND_SOURCE='"
						+ empMaster.getNearWaterGroundSource() + "',"
						+ " REMARKS='" + empMaster.getRemarks() + "',"
						+ " quality_affected='"
						+ empMaster.getQualityAffected()
						+ "',UPDATE_DATE=TO_DATE('" + empMaster.getUpdateDate()
						+ "','dd/mm/yyyy'),PREVIOUS_YR_STATUS='"
						+ empMaster.getPrevYrStatus() + "',PRESENT_YR_STATUS='"
						+ empMaster.getPresentvYrStatus() + "', PROPOSED_FC_YEAR = '"
						+ empMaster.getProposedFcYr() +"', PROPOSED_FC_EST_AMT ="
						+ "nvl(PROPOSED_FC_EST_AMT,'"+ empMaster.getProposedFCAmt() + "') " +
						  "WHERE HAB_CODE='" + empMaster.getHabCode() + "'";
				//System.out.println("Hab Directory query=" + query);
				empMasterData.stmt.addBatch(query);

				for (int i = 0; i < insts.size(); i++) {
					habInstitute = (HabInstitute) insts.get(i);
					insUpdate = false;
					query = " SELECT count(*) FROM rws_hab_institute_tbl  WHERE P_INST_CODE = '"
							+ habInstitute.getInstituteCode()
							+ "'and  hab_code='" + habCode + "'";
					//System.out.println("habInst select query=" + query);
					empMasterData.stmt1 = empMasterData.conn.createStatement();
					empMasterData.rs =empMasterData.stmt1.executeQuery(query);
					if (empMasterData.rs.next()) {
						if (empMasterData.rs.getInt(1) > 0)
							insUpdate = true;
					}

					if (insUpdate)
						query = " UPDATE RWS_HAB_INSTITUTE_TBL "
								+ " SET P_INST_NO='"
								+ habInstitute.getInstituteNo() + "',"
								+ " P_INST_COVERED='"
								+ habInstitute.getInstituteCovered() + "'"
								+ " WHERE P_INST_CODE = '"
								+ habInstitute.getInstituteCode() + "'"
								+ " AND HAB_CODE='" + empMaster.getHabCode()
								+ "'";
					else
						query = " INSERT INTO rws_hab_institute_tbl VALUES('"
								+ habCode + "', " + " '"
								+ habInstitute.getInstituteCode() + "', '"
								+ habInstitute.getInstituteNo() + "', " + " '"
								+ habInstitute.getInstituteCovered() + "') ";

					//System.out.println("HabInstitute query=" + query);
					empMasterData.stmt.addBatch(query);
				}
				if(exists){
				query = " UPDATE rws_hab_supply_status_tbl SET "
						+ " hps_oth_supply = '" + empMaster.getHpSupply()
						+ "', " + " hps_no = '" + empMaster.getHpNo() + "', "
						+ " shp_dk_supply = '" + empMaster.getShpSupply()
						+ "', " + " shp_no = '" + empMaster.getShpNo() + "', "
						+ " pws_supply = '" + empMaster.getPwsSupply() + "', "
						+ " pws_no = '" + empMaster.getPwsNo() + "', "
						+ " cpws_supply = '" + empMaster.getCpwsSupply()
						+ "', " + " cpws_no = '" + empMaster.getCpwsNo()
						+ "', " + " mpws_supply = '"
						+ empMaster.getMpwsSupply() + "', " + " mpws_no = '"
						+ empMaster.getMpwsNo() + "', "
						+ " DIRECT_PUMPING_SUPPLY = '"
						+ empMaster.getDpSupply() + "', "
						+ " DIRECT_PUMPING_NO = '" + empMaster.getDpNo()
						+ "', " + " ows_oth_supply = '"
						+ empMaster.getOwsSupply() + "', " + " ows_no = '"
						+ empMaster.getOwsNo() + "', "
						+ " ponds_oth_supply = '" + empMaster.getPondsSupply()
						+ "', " + " ponds_no = '" + empMaster.getPondsNo()
						+ "', " + " DW_TANKS_SUPPLY = '"
						+ empMaster.getDwSupply() + "', " + " DW_TANKS_NO = '"
						+ empMaster.getDwNo() + "', " + " stat_of_hab = '"
						+ empMaster.getStatus() + "'" + " WHERE hab_code='"
						+ empMaster.getHabCode() + "'";

				//System.out.println(" Update habSuply query is " + query);
				empMasterData.stmt.addBatch(query);
				}
				//System.out.println("empMaster.getCoveredStatus()  "+empMaster.getCoveredStatus());
				if (empMaster.getQualityAffected().equals("Y") || empMaster.getStatus().equals("NSS") || empMaster.getCoveredStatus().equals("NSS"))
				{					
					if (cnsUpdate && (StatusDate!=null && StatusDate.equals(empMaster.getHabYear().trim())))
						/*query = " UPDATE rws_hab_contamination_tbl "
								+ " SET cont_perc = '" + empMaster.getPercent()
								+ "'" + " WHERE cont_type = '"
								+ empMaster.getContamName() + "'"
								+ " AND hab_code='" + empMaster.getHabCode()
								+ "'";*/
						query ="UPDATE rws_hab_contamination_tbl "
						+ " SET cont_perc = '" + empMaster.getPercent()
						+ "', cont_type ='" + empMaster.getContamName() + "' WHERE  hab_code='" + empMaster.getHabCode()
						+ "'";
						
					else
						query = " INSERT INTO rws_hab_contamination_tbl VALUES('"
								+ habCode
								+ "', "
								+ " '"
								+ empMaster.getContamName()
								+ "', '"
								+ empMaster.getPercent() +"','"
								+ finyr +"',"								
								+"TO_DATE('"+ empMaster.getUpdateDate() + "','dd/mm/yyyy'))";
					empMasterData.stmt.addBatch(query);
					//System.out.println("Update Hab Contam query=" + query);
				} else {
					query = " SELECT count(*) FROM rws_hab_contamination_tbl WHERE hab_code='"
							+ habCode + "'";
					//System.out.println("hab contam select query=" + query);
					empMasterData.stmt1 = empMasterData.conn.createStatement();
					empMasterData.rs =empMasterData.stmt1.executeQuery(query);
					if (empMasterData.rs.next()) {
						if (empMasterData.rs.getInt(1) > 0) {
							query = " DELETE FROM rws_hab_contamination_tbl WHERE hab_code='"
									+ habCode + "'";
							//System.out.println("Hab Contam Delete query="
									+ query);
							empMasterData.stmt.addBatch(query);
						}
					}
				}

			}
			updateCounts = empMasterData.stmt.executeBatch();
			flag = true;
			//System.out.println("updateCounts=" + updateCounts.length);
			for (int i = 0; i < updateCounts.length; i++) {
				if (updateCounts[i] == 0) {
					//System.out.println("update Count=" + i + "count[i]="
							+ updateCounts[i]);
					flag = false;
				}
			}
			//System.out.println("flag=" + flag);
			if (flag) {
				empMasterData.conn.commit();
				if (check)
					errorMessage = "Record Inserted Successfully.";
				else
					errorMessage = "Record Updated Successfully";
			} else if (check)
				errorMessage = "Record can't inserted.";
			else
				errorMessage = "Record can't updated";
			empMasterData.conn.setAutoCommit(true);

		} catch (BatchUpdateException b) {
			System.err.println("Update counts of successful commands: " + b);
		} catch (Exception e) {
			//System.out.println("The error in insertHabStatus " + e);
			e.printStackTrace();
		} finally {
			empMasterData.closeAll();
		}
		return updateCounts;
	}

	public static int[] updateHabStatus(EmpMaster empMaster, ArrayList insts,
			ArrayList waterSupply, ArrayList contaminations,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int[] updateCounts = new int[10];
		HabInstitute habInstitute = new HabInstitute();
		HabWaterSupply habWS = new HabWaterSupply();
		ContaminationTypes habCont = new ContaminationTypes();
		String habCode = empMaster.getHabCode();
		boolean insUpdate = false, cnsUpdate = false;
		//System.out.println("updateHabstatus() called.");
		try {
			empMasterData.conn = dataSource.getConnection();

			empMasterData.stmt = empMasterData.conn.createStatement();
			String query = " SELECT count(*) FROM rws_hab_institute_tbl WHERE hab_code='"
					+ habCode + "'";
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			if (empMasterData.rs.next()) {
				if (empMasterData.rs.getInt(1) > 0)
					insUpdate = true;
			}

			query = " SELECT count(*) FROM rws_hab_contamination_tbl WHERE hab_code = '"
					+ habCode + "'";
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			if (empMasterData.rs.next()) {
				if (empMasterData.rs.getInt(1) > 0)
					cnsUpdate = true;
			}

			empMasterData.conn.setAutoCommit(false);
			empMasterData.stmt = empMasterData.conn.createStatement();
			//add by ali
			String finyr = empMaster.getHabYear();
			//System.out.println("fin yrs 6666666 sliue  "+finyr);
			String finyrMon = finyr.substring(3,5);
			finyr = finyr.substring(6,10);
			//System.out.println("DT vsliue  "+finyrMon);
			//System.out.println("fin yrs  sliue  "+finyr);
			int fyr = Integer.parseInt(finyr);
			int fyrMon = Integer.parseInt(finyrMon);
			if(fyrMon>4)
			{
				fyr = fyr + 1;
				finyr = finyr +"-"+fyr;
				//System.out.println("fin yrs  sliue  "+finyr);
			}
			else
			{
				fyr = fyr - 1;
				finyr = fyr +"-"+finyr;
				//System.out.println("fin yrs  sliue  "+finyr);
			}
			//end
			query = " UPDATE RWS_HABITATION_DIRECTORY_TBL "
					+ " SET CENSUS_YEAR='" + empMaster.getCensusYear() + "',"
					+ " CENSUS_PLAIN_POPU='" + empMaster.getCensusPop() + "',"
					+ " CENSUS_SC_POPU='" + empMaster.getCensusSc() + "',"
					+ " CENSUS_ST_POPU='" + empMaster.getCensusSt() + "',"
					+ " FLOAT_POP='" + empMaster.getFloatPop() + "',"
					+ " FLOAT_POP_REASONS='" + empMaster.getFloatReason()
					+ "'," + " STATUS_DATE=TO_DATE('" + empMaster.getHabYear()
					+ "','dd/mm/yyyy')," + " PLAIN_POPU_COVERED='"
					+ empMaster.getPopCovered() + "'," + " SC_POP_COVERED='"
					+ empMaster.getScCovered() + "'," + " ST_POP_COVERED='"
					+ empMaster.getStCovered() + "'," + " TOTAL_WATER_SUPPLY='"
					+ empMaster.getTotalWaterSupply() + "',"
					+ " EXIST_WATER_LEVEL='" + empMaster.getExistWaterLevel()
					+ "'," + " COVERAGE_STATUS='" + empMaster.getStatus()
					+ "'," + " NEAR_SURFACE_SOURCE='"
					+ empMaster.getNearWaterSource() + "',"
					+ " NEAR_GROUND_SOURCE='"
					+ empMaster.getNearWaterGroundSource() + "',"
					+ " REMARKS='" + empMaster.getRemarks() + "',"
					+ " quality_affected='" + empMaster.getQualityAffected()
					+ "', PROPOSED_FC_YEAR = '"+ empMaster.getProposedFcYr() +"', PROPOSED_FC_EST_AMT ="
					+ empMaster.getProposedFCAmt() + " WHERE HAB_CODE='" + empMaster.getHabCode() + "'";
			//System.out.println("query=" + query);
			empMasterData.stmt.addBatch(query);

			for (int i = 0; i < insts.size(); i++) {
				habInstitute = (HabInstitute) insts.get(i);
				if (insUpdate)
					query = " UPDATE RWS_HAB_INSTITUTE_TBL "
							+ " SET P_INST_NO='"
							+ habInstitute.getInstituteNo() + "',"
							+ " P_INST_COVERED='"
							+ habInstitute.getInstituteCovered() + "'"
							+ " WHERE P_INST_CODE = '"
							+ habInstitute.getInstituteCode() + "'"
							+ " AND HAB_CODE='" + empMaster.getHabCode() + "'";
				else
					query = " INSERT INTO rws_hab_institute_tbl VALUES('"
							+ habCode + "', " + " '"
							+ habInstitute.getInstituteCode() + "', '"
							+ habInstitute.getInstituteNo() + "', " + " '"
							+ habInstitute.getInstituteCovered() + "') ";

				empMasterData.stmt.addBatch(query);
			}

			query = " UPDATE rws_hab_supply_status_tbl SET "
					+ " shp_dk_supply = '" + empMaster.getShpSupply() + "', "
					+ " shp_no = '" + empMaster.getShpNo() + "', "
					+ " cisterns_dk_supply = '" + empMaster.getCisternsSupply()
					+ "', " + " cisterns_no = '" + empMaster.getCisternsNo()
					+ "', " + " glsrs_dk_supply = '"
					+ empMaster.getGlsrSupply() + "', " + " glsrs_no = '"
					+ empMaster.getGlsrNo() + "', " + " ohsrs_dk_supply = '"
					+ empMaster.getOhsrSupply() + "', " + " ohsrs_no = '"
					+ empMaster.getOhsrNo() + "', " + " hps_oth_supply = '"
					+ empMaster.getHpSupply() + "', " + " hps_no = '"
					+ empMaster.getHpNo() + "', " + " ows_oth_supply = '"
					+ empMaster.getOwsSupply() + "', " + " ows_no = '"
					+ empMaster.getOwsNo() + "', " + " ponds_oth_supply = '"
					+ empMaster.getPondsSupply() + "', " + " ponds_no = '"
					+ empMaster.getPondsNo() + "', " + " shwell_oth_supply = '"
					+ empMaster.getShwSupply() + "', " + " shwell_no = '"
					+ empMaster.getShwNo() + "', " + " pcpd_drink = '"
					+ empMaster.getPcpdDrink() + "', " + " pcpd_others = '"
					+ empMaster.getPcpdOthers() + "', " + " stat_of_hab = '"
					+ empMaster.getStatus() + "'" + " WHERE hab_code='"
					+ habCode + "'";
			//System.out.println(" Update query is " + query);
			empMasterData.stmt.addBatch(query);

			for (int i = 0; i < contaminations.size(); i++) {
				habCont = (ContaminationTypes) contaminations.get(i);
				if (cnsUpdate)
					query = " UPDATE rws_hab_contamination_tbl "
							+ " SET cont_perc = '" + habCont.getPercent() + "'"
							+ " WHERE cont_type = '" + habCont.getContType()
							+ "'" + " AND hab_code='" + empMaster.getHabCode()
							+ "'";
				else
					query = " INSERT INTO rws_hab_contamination_tbl VALUES('"
							+ habCode + "', " + " '" + habCont.getContType()
							+ "', '" + habCont.getPercent() +"','"
							+ finyr +"',"
							+"TO_DATE('"+ empMaster.getUpdateDate() + "','dd/mm/yyyy'))";

				empMasterData.stmt.addBatch(query);
			}
			updateCounts = empMasterData.stmt.executeBatch();
			empMasterData.conn.commit();
		} catch (BatchUpdateException b) {
			System.err
					.println("Update counts of successful commands:updateHabStatus "
							+ b);
		} catch (Exception e) {
			//System.out.println("The error in updateHabStatus " + e);
		} finally {
			empMasterData.closeAll();
		}
		return updateCounts;
	}

	public static EmpMaster getHabStatus(String habCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		HabInstitute habInstitute = null;
		ContaminationTypes contaminationTypes = null;
		HabWaterSupply habWS = null;
		Collection institutes = new ArrayList();
		Collection waterSupply = new ArrayList();
		Collection contaminations = new ArrayList();
		empMasterData.stmt1 = null;
		empMasterData.stmt2 = null;
		empMasterData.stmt3 = null;
		Statement stmt4 = null;
		
		try {

			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT * FROM RWS_HABITATION_DIRECTORY_TBL WHERE HAB_CODE='"
							+ habCode + "'");
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster
						.setCoc(getCircleOfficeName("1", empMasterData.rs.getString(1), empMasterData.conn));
				empMaster.setDoc(getDivisionOfficeName("1", empMasterData.rs.getString(1), empMasterData.rs
						.getString(2), empMasterData.conn));
				empMaster.setSdoc(getSubDivisionOfficeName("1", empMasterData.rs.getString(1),
								empMasterData.rs.getString(2), empMasterData.rs.getString(3), empMasterData.conn));

				empMaster.setDistCode(habCode.substring(0, 2));
				empMaster.setMandalCode(habCode.substring(5, 7));
				empMaster.setVCode(habCode.substring(7, 10));
				empMaster.setPCode(habCode.substring(12, 14));

				empMaster.setHabName(getHabName(empMasterData.rs.getString(4), empMasterData.conn));
				empMaster.setCensusYear(empMasterData.rs.getString(5));
				empMaster.setCensusPop(empMasterData.rs.getInt(6));
				empMaster.setCensusSc(empMasterData.rs.getInt(7));
				empMaster.setCensusSt(empMasterData.rs.getInt(8));
				empMaster.setTotalPop(empMasterData.rs.getInt(6) + empMasterData.rs.getInt(7)
						+ empMasterData.rs.getInt(8));
				empMaster.setFloatPop(empMasterData.rs.getInt(9));
				empMaster.setNetPop(empMasterData.rs.getInt(6) + empMasterData.rs.getInt(7) + empMasterData.rs.getInt(8)
						+ empMasterData.rs.getInt(9));
				empMaster.setFloatReason(empMasterData.rs.getString(10));
				empMaster.setHabYear(df.format(empMasterData.rs.getDate(11)));
				empMaster.setPopCovered(empMasterData.rs.getInt(12));
				empMaster.setScCovered(empMasterData.rs.getInt(13));
				empMaster.setStCovered(empMasterData.rs.getInt(14));
				empMaster.setTotalCovered(empMasterData.rs.getInt(12) + empMasterData.rs.getInt(13)
						+ empMasterData.rs.getInt(14));
				empMaster.setTotalWaterSupply(empMasterData.rs.getInt(15));
				empMaster.setExistWaterLevel(empMasterData.rs.getInt(16));
				empMaster.setCoveredStatus(empMasterData.rs.getString(17));
				empMaster.setNearWaterSource(empMasterData.rs.getInt(18));
				empMaster.setNearWaterGroundSource(empMasterData.rs.getInt(19));
				empMaster.setRemarks(empMasterData.rs.getString(20));
				empMaster.setQualityAffected(empMasterData.rs.getString(21));
				empMaster.setUpdateDate(empMasterData.rs.getString(22));
				empMaster.setPrevYrStatus(empMasterData.rs.getString(23));
				empMaster.setPresentvYrStatus(empMasterData.rs.getString(24));
				empMaster.setProposedFcYr(empMasterData.rs.getString(25));
				empMaster.setProposedFCAmt(empMasterData.rs.getInt(26));
				
				
				empMasterData.stmt1 = empMasterData.conn.createStatement();

				empMasterData.rs1 = empMasterData.stmt1.executeQuery("SELECT P_INST_CODE,INST_NAME,P_INST_NO,P_INST_COVERED FROM RWS_HAB_INSTITUTE_TBL HI,RWS_PUBLIC_INSTITUTE_TBL I WHERE HI.P_INST_CODE=I.INST_CODE AND HAB_CODE='"+ habCode + "'");
				while (empMasterData.rs1.next()) {
					habInstitute = new HabInstitute();
					habInstitute.setInstituteCode(empMasterData.rs1.getString(1));
					habInstitute.setInstituteName(empMasterData.rs1.getString(2));
					habInstitute.setInstituteNo(empMasterData.rs1.getString(3));
					habInstitute.setInstituteCovered(empMasterData.rs1.getString(4));

					institutes.add(habInstitute);
				}

				empMaster.setHabInsts(institutes);

				empMasterData.stmt3 = empMasterData.conn.createStatement();

				String[] comps = { "HAND PUMPS", "SHALLOW HAND PUMPS",
						"OPEN WELLS", "PONDS", "PWS", "CPWS", "HOUSE HOLDS" };
				String q = null;
				int rowCount = 0;
				for (int j = 0; j < comps.length; j++) {

					rowCount = 0;
					q = " SELECT total_no,total_pop,plain_pop,sc_pop,st_pop,depth,yeild,platform,quality,portable "
							+ " FROM RWS_HAB_COMPONENT_TBL WHERE HAB_CODE='"
							+ habCode
							+ "' "
							+ " AND component = '"
							+ comps[j]
							+ "'";

					empMasterData.rs3 = empMasterData.stmt3.executeQuery(q);
					while (empMasterData.rs3.next()) {
						rowCount++;
						habWS = new HabWaterSupply();
						/*
						 * habWS.setComponent(comps[j]);
						 * habWS.setTotalNo(rs3.getInt(1));
						 * habWS.setTotalPop(rs3.getInt(2));
						 * habWS.setPlainPop(rs3.getInt(3));
						 * habWS.setScPop(rs3.getInt(4));
						 * habWS.setStPop(rs3.getInt(5));
						 * habWS.setDepth(rs3.getString(6));
						 * habWS.setYeild(empMasterData.rs3.getString(7));
						 * habWS.setPlatform(empMasterData.rs3.getString(8));
						 * habWS.setQuality(empMasterData.rs3.getString(9));
						 * habWS.setPortable(empMasterData.rs3.getString(10));
						 */
						waterSupply.add(habWS);
					}
					if (rowCount <= 0) {
						//habWS = new
						// HabWaterSupply(comps[j],0,0,0,0,0,"","","","","");
						waterSupply.add(habWS);
					}
				}
				empMaster.setHabWaterSupply(waterSupply);

				empMasterData.stmt3 = empMasterData.conn.createStatement();
				String query = " SELECT NVL(cont_type,''), NVL(cont_perc,0.0) "
						+ " FROM rws_hab_contamination_tbl"
						+ " WHERE hab_code = '" + habCode + "'";
				empMasterData.rs3 = empMasterData.stmt3.executeQuery(query);
				while (empMasterData.rs3.next()) {
					contaminationTypes = new ContaminationTypes();
					contaminationTypes.setContType(empMasterData.rs3.getString(1));
					contaminationTypes.setPercent(empMasterData.rs3.getDouble(2));
					contaminations.add(contaminationTypes);
				}
				empMaster.setContaminations(contaminations);
			}
		} catch (Exception e) {
			//System.out.println("The error in getHabStatus = " + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static EmpMaster getHabSupplyStatus(String habCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		HabInstitute habInstitute = null;
		ContaminationTypes contaminationTypes = null;
		HabWaterSupply habWS = null;
		Collection institutes = new ArrayList();
		Collection waterSupply = new ArrayList();
		Collection contaminations = new ArrayList();
		empMasterData.conn=dataSource.getConnection();
		empMasterData.stmt1 = null;
		empMasterData.stmt2 = null;
		empMasterData.stmt3 = null;
		Statement stmt4 = null;
		int pwsCount=0;
		int mpwsCount=0;
		int cpwsCount=0;
		int shpCount=0;
		int hpCount=0;
		int pondsCount=0;
		int openwellCount=0;
		//System.out.println("in getHabSupplyStatus() in EmpMasterData");
		String habcode = null;

		try {
			//code to get pwsCount
			empMasterData.stmt2=empMasterData.conn.createStatement();
			//System.out.println("1");
			String countQuery="select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s" 
				+ " where a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '6%'" 
				+ " and substr(s.scheme_code,1,16)='"+habCode+"'";
			//System.out.println("countQuery is "+countQuery);
			empMasterData.rs2=empMasterData.stmt2.executeQuery(countQuery);
			//System.out.println("2");
			if(empMasterData.rs2.next())
			{
				pwsCount=empMasterData.rs2.getInt("count");
				//System.out.println("pwsCount is "+pwsCount);
			}
			//System.out.println("3");
			countQuery="select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s" 
				+ " where a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '4%'" 
				+ " and substr(s.scheme_code,1,16)='"+habCode+"'";
			//System.out.println("countQuery is "+countQuery);
			empMasterData.rs2=empMasterData.stmt2.executeQuery(countQuery);
			if(empMasterData.rs2.next())
			{
				mpwsCount=empMasterData.rs2.getInt("count");
				//System.out.println("mpwsCount is "+mpwsCount);
			}
			
			countQuery="select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_HP_SUBCOMP_PARAM_TBL h" 
				+ " where a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '0%'" 
				+ " and h.asset_code=a.asset_code and substr(s.scheme_code,1,16)='"+habCode+"'";
			//System.out.println("countQuery is "+countQuery);
			empMasterData.rs2=empMasterData.stmt2.executeQuery(countQuery);
			if(empMasterData.rs2.next())
			{
				hpCount=empMasterData.rs2.getInt("count");
				//System.out.println("hpCount is "+hpCount);
			}
		
			
			countQuery="select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s," 
				+ " RWS_SHALLOWHANDPUMPS_TBL subcompTbl where a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '3%'" 
				+ " and substr(s.scheme_code,1,16)='"+habCode+"' and subcompTbl.asset_code=a.asset_code";
			//System.out.println("countQuery is "+countQuery);
			empMasterData.rs2=empMasterData.stmt2.executeQuery(countQuery);
			if(empMasterData.rs2.next())
			{
				shpCount=empMasterData.rs2.getInt("count");
				//System.out.println("shpCount is "+shpCount);
			}
			
			countQuery="select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s, RWS_OPEN_WELL_MAST_TBL subcompTbl" 
				+ " where a.asset_code=subcompTbl.asset_code and a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '2%'" 
				+ " and substr(s.scheme_code,1,16)='"+habCode+"'";
			//System.out.println("countQuery is "+countQuery);
			empMasterData.rs2=empMasterData.stmt2.executeQuery(countQuery);
			if(empMasterData.rs2.next())
			{
				openwellCount=empMasterData.rs2.getInt("count");
				//System.out.println("openwellCount is "+openwellCount);
			}
			
			countQuery="select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s,RWS_OPENWELL_POND_TBL SUBCOMPTBL" 
				+ " where a.asset_code=subcompTbl.asset_code and a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '7%'" 
				+ " and substr(s.scheme_code,1,16)='"+habCode+"'";
			//System.out.println("countQuery is "+countQuery);
			empMasterData.rs2=empMasterData.stmt2.executeQuery(countQuery);
			if(empMasterData.rs2.next())
			{
				pondsCount=empMasterData.rs2.getInt("count");
				//System.out.println("pondsCount is "+pondsCount);
			}
			
			//System.out.println("4");
		
			countQuery="select count(*) as count from rws_asset_mast_tbl a,rws_asset_scheme_tbl s" 
				+ " where a.asset_code=s.asset_code and substr(s.scheme_code,17,3) like '8%'" 
				+ " and substr(s.scheme_code,1,16)='"+habCode+"'";
			//System.out.println("countQuery is "+countQuery);
			empMasterData.rs2=empMasterData.stmt2.executeQuery(countQuery);
			if(empMasterData.rs2.next())
			{
				cpwsCount=empMasterData.rs2.getInt("count");
				//System.out.println("cpwsCount is "+cpwsCount);
			}
			//end of code
			//System.out.println("5");
			//System.out.println("in getHabSupplyStatus in EmpMasterData.java");
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			//System.out.println("6");
			//System.out.println("habCode=" + habCode);
			String query = "SELECT * FROM RWS_HABITATION_DIRECTORY_TBL WHERE HAB_CODE='"
					+ habCode + "'";
			//System.out.println("query=" + query);
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			int netPop = 0;
			double totpop = 0;
			int csyear;
			//System.out.println("7");
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				habcode = empMasterData.rs.getString(4);
				empMaster.setCoc(empMasterData.rs.getString(1));
				empMaster.setDoc(empMasterData.rs.getString(2));
				empMaster.setSdoc(empMasterData.rs.getString(3));
				//System.out.println("8");
				empMaster
						.setCon(getCircleOfficeName("1", empMasterData.rs.getString(1), empMasterData.conn));
				empMaster.setDon(getDivisionOfficeName("1", empMasterData.rs.getString(1), empMasterData.rs
						.getString(2), empMasterData.conn));
				empMaster
						.setSdon(getSubDivisionOfficeName("1", empMasterData.rs.getString(1),
								empMasterData.rs.getString(2), empMasterData.rs.getString(3), empMasterData.conn));
				empMaster.setDcode(habcode.substring(0, 2));
				empMaster.setDistrict(getDistrictName(habcode.substring(0, 2),
						empMasterData.conn));
				empMaster.setMandal(habcode.substring(5, 7));
				empMaster.setMandalName(getMandalName(habcode.substring(0, 2),
						habcode.substring(5, 7), empMasterData.conn));
				empMaster.setPCode(habcode.substring(12, 14));
				empMaster.setVCode(habcode.substring(7, 10));
				//System.out.println("9");
				empMaster.setPName(getPanchayatName(habcode.substring(0, 2),
						habcode.substring(5, 7), habcode.substring(12, 14),
						empMasterData.conn));
				empMaster.setVName(getVillageName(habcode.substring(0, 2),
						habcode.substring(5, 7), habcode.substring(12, 14),
						habcode.substring(7, 10), empMasterData.conn));
				empMaster.setHabCode(empMasterData.rs.getString(4));
				empMaster.setHabName(getHabName(empMasterData.rs.getString(4), empMasterData.conn));
				empMaster.setCensusYear(empMasterData.rs.getString(5));
				csyear = Integer.parseInt(empMasterData.rs.getString(5));
				empMaster.setCensusPop(empMasterData.rs.getInt(6));
				//System.out.println("9");
				empMaster.setCensusSc(empMasterData.rs.getInt(7));
				empMaster.setCensusSt(empMasterData.rs.getInt(8));
				empMaster.setTotalPop(empMasterData.rs.getInt(6) + empMasterData.rs.getInt(7)
						+ empMasterData.rs.getInt(8));
				empMaster.setFloatPop(empMasterData.rs.getInt(9));
				netPop = empMasterData.rs.getInt(6) + empMasterData.rs.getInt(7) + empMasterData.rs.getInt(8)
						+ empMasterData.rs.getInt(9);
				empMaster.setNetPop(netPop);
				empMaster.setFloatReason(empMasterData.rs.getString(10));
				empMaster.setHabYear(df.format(empMasterData.rs.getDate(11)));
				empMaster.setPopCovered(empMasterData.rs.getInt(12));
				//System.out.println("10");
				empMaster.setScCovered(empMasterData.rs.getInt(13));
				empMaster.setStCovered(empMasterData.rs.getInt(14));
				//System.out.println("11");
				empMaster.setTotalCovered(empMasterData.rs.getInt(12) + empMasterData.rs.getInt(13)
						+ empMasterData.rs.getInt(14));
				empMaster.setTotalWaterSupply(empMasterData.rs.getInt(15));
				empMaster.setExistWaterLevel(empMasterData.rs.getInt(16));
				//System.out.println("coverageStatus in EmpMasterData is "+empMasterData.rs.getString(17));
				empMaster.setCoveredStatus(empMasterData.rs.getString(17));
				//System.out.println("12");
				empMaster.setNearWaterSource(empMasterData.rs.getInt(18));
				empMaster.setNearWaterGroundSource(empMasterData.rs.getInt(19));
				empMaster.setRemarks(empMasterData.rs.getString(20));
				empMaster.setQualityAffected(empMasterData.rs.getString(21));
				//System.out.println("13");
				if (empMasterData.rs.getString(22) == null)
					empMaster.setUpdateDate("");
				else
					empMaster.setUpdateDate(df.format(empMasterData.rs.getDate(22)));
				if (empMasterData.rs.getString(21) == null)
				{
					empMaster.setPrevYrStatus("");
					empMaster.setPresentvYrStatus("");
				}
				else
				{
					empMaster.setPrevYrStatus(empMasterData.rs.getString(23));
					empMaster.setPresentvYrStatus(empMasterData.rs.getString(24));
				}
				//System.out.println("14");
				empMaster.setProposedFcYr(empMasterData.rs.getString(25));
				empMaster.setProposedFCAmt(empMasterData.rs.getInt(26));
				//System.out.println("15");
				empMasterData.stmt1 = empMasterData.conn.createStatement();
				query = "SELECT P_INST_CODE,INST_NAME,P_INST_NO,P_INST_COVERED FROM RWS_HAB_INSTITUTE_TBL HI,RWS_PUBLIC_INSTITUTE_TBL I WHERE HI.P_INST_CODE=I.INST_CODE AND HAB_CODE='"
						+ habCode + "'";
				//System.out.println("query for inst=" + query);
				empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
				//System.out.println("16");
				while (empMasterData.rs1.next()) {
					habInstitute = new HabInstitute();
					habInstitute.setInstituteCode(empMasterData.rs1.getString(1));
					habInstitute.setInstituteName(empMasterData.rs1.getString(2));
					habInstitute.setInstituteNo(empMasterData.rs1.getString(3));
					habInstitute.setInstituteCovered(empMasterData.rs1.getString(4));

					institutes.add(habInstitute);
				}
				//System.out.println("17");
				empMaster.setHabInsts(institutes);

				empMasterData.stmt3 = empMasterData.conn.createStatement();

				String q = null;
				//System.out.println("18");
				q = " SELECT NVL(shp_dk_supply,0), NVL(shp_no,0), cisterns_dk_supply, cisterns_no, glsrs_dk_supply, glsrs_no,"
						+ " ohsrs_dk_supply, ohsrs_no, (NVL(shp_dk_supply,0) "
						+ " + NVL(cisterns_dk_supply,0) + NVL(glsrs_dk_supply,0) + NVL(ohsrs_dk_supply,0)), "
						+ " ( NVL(shp_no,0) + NVL(cisterns_no,0) + NVL(glsrs_no,0) + NVL(ohsrs_no,0) ), "
						+ " NVL(hps_oth_supply,0), NVL(hps_no,0), ows_oth_supply, NVL(ows_no,0), NVL(ponds_oth_supply,0),NVL(ponds_no,0), shwell_oth_supply,"
						+ " shwell_no, (NVL(hps_oth_supply,0) + NVL(ows_oth_supply,0) + NVL(ponds_oth_supply,0)  "
						+ " + NVL(shwell_oth_supply,0)), (NVL(hps_no,0) + NVL(ows_no,0) + NVL(ponds_no,0) + NVL(shwell_no,0)), "
						+ " pcpd_drink, pcpd_others, (NVL(pcpd_drink,0) +NVL(pcpd_others,0)), stat_of_hab, "
						+ "NVL(PWS_NO,0),NVL(PWS_SUPPLY,0),NVL(MPWS_NO,0),NVL(MPWS_SUPPLY,0),NVL(CPWS_NO,0),NVL(CPWS_SUPPLY,0),NVL(DIRECT_PUMPING_NO,0),NVL(DIRECT_PUMPING_SUPPLY,0),NVL(DW_TANKS_NO,0),NVL(DW_TANKS_SUPPLY,0),NVL(CATTLE_NO,0),NVL(CATTLE_SUPPLY,0)"
						+ " FROM rws_hab_supply_status_tbl WHERE hab_code='"
						+ habCode + "'";
				//System.out.println(" SELECT QUERY is " + q);
				empMasterData.rs3 = empMasterData.stmt3.executeQuery(q);
				//System.out.println("19");
				while (empMasterData.rs3.next()) {
					habWS = new HabWaterSupply();
					empMaster.setShpSupply(empMasterData.rs3.getString(1));
					//empMaster.setShpNo(empMasterData.rs3.getString(2));
					empMaster.setShpNo(shpCount+"");
					empMaster.setCisternsSupply(empMasterData.rs3.getString(3));
					empMaster.setCisternsNo(empMasterData.rs3.getString(4));
					empMaster.setGlsrSupply(empMasterData.rs3.getString(5));
					empMaster.setGlsrNo(empMasterData.rs3.getString(6));
					empMaster.setOhsrSupply(empMasterData.rs3.getString(7));
					empMaster.setOhsrNo(empMasterData.rs3.getString(8));
					double drinkTotalSupply = empMasterData.rs3.getDouble(9);
					empMaster.setDrinkTotalSupply(String
							.valueOf(drinkTotalSupply));
					empMaster.setDrinkTotalNo(empMasterData.rs3.getString(10));
					empMaster.setHpSupply(empMasterData.rs3.getString(11));
					//System.out.println("20");
					//empMaster.setHpNo(empMasterData.rs3.getString(12));
					empMaster.setHpNo(hpCount+"");
					empMaster.setOwsSupply(empMasterData.rs3.getString(13));
					//empMaster.setOwsNo(empMasterData.rs3.getString(14));
					empMaster.setOwsNo(openwellCount+"");
					empMaster.setPondsSupply(empMasterData.rs3.getString(15));
					//empMaster.setPondsNo(empMasterData.rs3.getString(16));
					empMaster.setPondsNo(pondsCount+"");
					empMaster.setShwSupply(empMasterData.rs3.getString(17));
					empMaster.setShwNo(empMasterData.rs3.getString(18));
					double otherTotalSupply = empMasterData.rs3.getDouble(19);
					//System.out.println("21");
					empMaster.setOtherTotalSupply(String
							.valueOf(otherTotalSupply));
					empMaster.setOtherTotalNo(empMasterData.rs3.getString(20));

					empMaster.setPcpdDrink(empMasterData.rs3.getString(21));
					empMaster.setPcpdOthers(empMasterData.rs3.getString(22));
					empMaster.setPcpdTotal(empMasterData.rs3.getString(23));
					empMaster.setStatus(empMasterData.rs3.getString(24));
					//System.out.println("22");
					//empMaster.setPwsNo(empMasterData.rs3.getString(25));
					
					empMaster.setPwsNo(pwsCount+"");
					empMaster.setPwsSupply(empMasterData.rs3.getString(26));
					//empMaster.setMpwsNo(empMasterData.rs3.getString(27));
					empMaster.setMpwsNo(mpwsCount+"");
					empMaster.setMpwsSupply(empMasterData.rs3.getString(28));
					//empMaster.setCpwsNo(empMasterData.rs3.getString(29));
					empMaster.setCpwsNo(cpwsCount+"");
					empMaster.setCpwsSupply(empMasterData.rs3.getString(30));
					//System.out.println("23");
					empMaster.setDpNo(empMasterData.rs3.getString(31));
					empMaster.setDpSupply(empMasterData.rs3.getString(32));
					empMaster.setDwNo(empMasterData.rs3.getString(33));
					empMaster.setDpSupply(empMasterData.rs3.getString(34));
					empMaster.setCattleNo(empMasterData.rs3.getString(35));
					empMaster.setCattleSupply(empMasterData.rs3.getString(36));
					//System.out.println("24");

					double totalWaterSupply = drinkTotalSupply
							+ otherTotalSupply;
					empMaster.setTotalWaterSupply((int)(totalWaterSupply));

					Calendar rightNow = Calendar.getInstance();
					//System.out.println("25");
					int year = rightNow.get(Calendar.YEAR);
					//System.out.println("year="
							+ year
							+ "csyear="
							+ csyear
							+ "val="
							+ Math.pow(1.02, Double.parseDouble(""
									+ (year - csyear))));
					totpop = Double.parseDouble("" + netPop);
					//System.out.println("26");
					totpop = totpop
							* Math.pow(1.02, Double.parseDouble(""
									+ (year - csyear)));
					//System.out.println("netpop=" + totpop);

					empMaster.setLevelOfWaterSupply(String
							.valueOf(totalWaterSupply / totpop));
					waterSupply.add(empMaster);
				}
				//System.out.println("27");
				empMaster.setHabWaterSupply(waterSupply);

				empMasterData.stmt3 = empMasterData.conn.createStatement();
				query = " SELECT NVL(cont_type,''), NVL(cont_perc,0.0) "
						+ " FROM rws_hab_contamination_tbl"
						+ " WHERE hab_code = '" + habCode + "'";
				//System.out.println("contam query=" + query);
				//System.out.println("28");
				empMasterData.rs3 = empMasterData.stmt3.executeQuery(query);
				while (empMasterData.rs3.next()) {
					//System.out.println("29");
					contaminationTypes = new ContaminationTypes();
					contaminationTypes.setContType(empMasterData.rs3.getString(1));
					contaminationTypes.setPercent(empMasterData.rs3.getDouble(2));
					contaminations.add(contaminationTypes);
					empMaster.setContamName(empMasterData.rs3.getString(1));
					empMaster.setPercent(empMasterData.rs3.getString(2));
				}
				//System.out.println("30");
				empMaster.setContaminations(contaminations);
			}
		} catch (Exception e) {
			//System.out.println("The error in getHabSupplyStatus = " + e);
		} finally {
			empMasterData.closeAll();
		}
		//System.out.println("31");
		return empMaster;
	}

	public static ArrayList getContamNames(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList contaminations = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			String query = "SELECT CONTAMINATION_NAME FROM RWS_CONTAMINATION_TBL";
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setContamName(empMasterData.rs.getString("CONTAMINATION_NAME"));
				contaminations.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getContaminations=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return contaminations;
	}
	//add by sadiq on 24-08-06
	public static ArrayList getContamNames(DataSource dataSource,String contiType)
	throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
EmpMaster empMaster = null;
ArrayList contaminations = new ArrayList();
try {
	empMasterData.conn = dataSource.getConnection();
	empMasterData.stmt = empMasterData.conn.createStatement();
	String query = "SELECT CONTAMINATION_NAME FROM RWS_CONTAMINATION_TBL where CONTAMINATION_NAME ='"+contiType+"'";
	//System.out.println("query is  "+query);
	empMasterData.rs =empMasterData.stmt.executeQuery(query);
	while (empMasterData.rs.next()) {
		empMaster = new EmpMaster();

		empMaster.setContamName(empMasterData.rs.getString("CONTAMINATION_NAME"));
		contaminations.add(empMaster);
	}
} catch (Exception e) {
	//System.out.println("The error in getContaminations=" + e);
} finally {
	empMasterData.closeAll();
}
return contaminations;
}
	//end of funtion

	public static ArrayList getHabStatuss(String coc, String doc, String sdoc,
			String dcode, String mcode, String pcode, String vcode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList habstatuss = new ArrayList();

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			//System.out.println("coc=" + coc + "doc=" + doc + "sdoc Value=" + sdoc
					+ "dcode=" + dcode + "mcode=" + mcode + "pcode=" + pcode
					+ "vcode=" + vcode);
			String query = "";

			if ((coc != null && !coc.equals(""))
					&& (doc != null && !doc.equals(""))
					&& (sdoc != null && !sdoc.equals(""))
					&& (dcode != null && !dcode.equals(""))
					&& (mcode != null && !mcode.equals(""))
					&& (pcode == null || pcode.equals(""))
					&& (vcode == null || vcode.equals("")))
				query = " SELECT * FROM RWS_HABITATION_DIRECTORY_TBL "
						+ " WHERE SUBSTR(hab_code,1,2) = '" + dcode + "'"
						+ " AND SUBSTR(hab_code,6,2) = '" + mcode + "'"
						+ " AND CIRCLE_OFFICE_CODE = '" + coc + "'"
						+ " AND DIVISION_OFFICE_CODE  = '" + doc + "'"
						+ " AND SUBDIVISION_OFFICE_CODE  = '" + sdoc + "'"
						+ " ORDER BY HAB_CODE ";
			else if ((coc != null && !coc.equals(""))
					&& (doc != null && !doc.equals(""))
					&& (sdoc != null && !sdoc.equals(""))
					&& (dcode != null && !dcode.equals(""))
					&& (mcode != null && !mcode.equals(""))
					&& (pcode != null && !pcode.equals(""))
					&& (vcode == null || vcode.equals("")))
				query = " SELECT * FROM RWS_HABITATION_DIRECTORY_TBL "
						+ " WHERE SUBSTR(hab_code,1,2) = '" + dcode + "'"
						+ " AND SUBSTR(hab_code,6,2) = '" + mcode + "'"
						+ " AND SUBSTR(hab_code,13,2) = '" + pcode + "'"
						+ " AND CIRCLE_OFFICE_CODE = '" + coc + "'"
						+ " AND DIVISION_OFFICE_CODE  = '" + doc + "'"
						+ " AND SUBDIVISION_OFFICE_CODE  = '" + sdoc + "'"
						+ " ORDER BY HAB_CODE ";
			else if ((coc != null && !coc.equals(""))
					&& (doc != null && !doc.equals(""))
					&& (sdoc != null && !sdoc.equals(""))
					&& (dcode != null && !dcode.equals(""))
					&& (mcode != null && !mcode.equals(""))
					&& (pcode != null && !pcode.equals(""))
					&& (vcode != null && !vcode.equals("")))
				query = " SELECT * FROM RWS_HABITATION_DIRECTORY_TBL "
						+ " WHERE SUBSTR(hab_code,1,2) = '" + dcode + "'"
						+ " AND SUBSTR(hab_code,6,2) = '" + mcode + "'"
						+ " AND SUBSTR(hab_code,8,3) = '" + vcode + "'"
						+ " AND SUBSTR(hab_code,13,2) = '" + pcode + "'"
						+ " AND CIRCLE_OFFICE_CODE = '" + coc + "'"
						+ " AND DIVISION_OFFICE_CODE  = '" + doc + "'"
						+ " AND SUBDIVISION_OFFICE_CODE  = '" + sdoc + "'"
						+ " ORDER BY HAB_CODE ";
			//System.out.println(query);
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setCoc(empMasterData.rs.getString(1));
				empMaster.setDoc(empMasterData.rs.getString(2));
				empMaster.setSdoc(empMasterData.rs.getString(3));
				empMaster.setHabCode(empMasterData.rs.getString(4));
				empMaster.setHabName(getHabName(empMasterData.rs.getString(4), empMasterData.conn));
				empMaster.setCensusYear(empMasterData.rs.getString(5));
				empMaster.setCensusPop(empMasterData.rs.getInt(6));
				empMaster.setCensusSc(empMasterData.rs.getInt(7));
				empMaster.setCensusSt(empMasterData.rs.getInt(8));
				empMaster.setTotalPop(empMasterData.rs.getInt(6) + empMasterData.rs.getInt(7)
						+ empMasterData.rs.getInt(8));
				empMaster.setFloatPop(empMasterData.rs.getInt(9));
				empMaster.setNetPop(empMasterData.rs.getInt(6) + empMasterData.rs.getInt(7) + empMasterData.rs.getInt(8)
						+ empMasterData.rs.getInt(9));
				empMaster.setFloatReason(empMasterData.rs.getString(10));
				if (empMasterData.rs.getDate(11) != null) {
					empMaster.setHabYear(df.format(empMasterData.rs.getDate(11)));
				}
				empMaster.setPopCovered(empMasterData.rs.getInt(12));
				empMaster.setScCovered(empMasterData.rs.getInt(13));
				empMaster.setStCovered(empMasterData.rs.getInt(14));
				empMaster.setTotalCovered(empMasterData.rs.getInt(12) + empMasterData.rs.getInt(13)
						+ empMasterData.rs.getInt(14));
				empMaster.setTotalWaterSupply(empMasterData.rs.getInt(15));
				empMaster.setExistWaterLevel(empMasterData.rs.getInt(16));
				empMaster.setCoveredStatus(empMasterData.rs.getString(17));
				empMaster.setNearWaterSource(empMasterData.rs.getInt(18));
				empMaster.setNearWaterGroundSource(empMasterData.rs.getInt(19));
				empMaster.setRemarks(empMasterData.rs.getString(20));

				SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
				if (empMasterData.rs.getString(22) == null)
					empMaster.setUpdateDate("");
				else
					empMaster.setUpdateDate(sdf.format(empMasterData.rs.getDate(22)));
				empMaster.setProposedFcYr(empMasterData.rs.getString(25));
				empMaster.setProposedFCAmt(empMasterData.rs.getInt(26));
				habstatuss.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getHabStatuss=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return habstatuss;
	}

	public static int[] removeHabStatus(String habCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int[] updateCounts = new int[3];
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.conn.setAutoCommit(false);
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt.addBatch("DELETE  FROM RWS_HAB_INSTITUTE_TBL WHERE HAB_CODE='"
					+ habCode + "'");
			empMasterData.stmt.addBatch("DELETE  FROM RWS_HAB_COMPONENT_TBL WHERE HAB_CODE='"
					+ habCode + "'");
			empMasterData.stmt
					.addBatch("DELETE  FROM RWS_HABITATION_DIRECTORY_TBL WHERE HAB_CODE='"
							+ habCode + "'");
			updateCounts = empMasterData.stmt.executeBatch();
			empMasterData.conn.commit();
		} catch (Exception e) {
			//System.out.println("The error in removeHabStatus= " + e);
		} finally {
			empMasterData.closeAll();
		}
		return updateCounts;
	}

	//*********************************Priority
	// methods****************************
	public static int insertPriority(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
		    PreparedStatement ps=empMasterData.conn.prepareStatement("insert into RWS_PRIORITY_TBL values(?,?,?)");
			ps.setString(1, empMaster.getPriorityCode());
			ps.setString(2, empMaster.getPriorityDesc().toUpperCase());
			ps.setString(3,empMaster.getPriorityFrom().toUpperCase());
		    rowCount = ps.executeUpdate();

		} catch (Exception e) {
			//System.out.println("The error in insertPriority=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getPriority(String priorityCode,
			String priorityFrom, DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from RWS_PRIORITY_TBL where priority_code="
							+ priorityCode
							+ " and priority_from='"
							+ priorityFrom + "'");
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setPriorityCode(empMasterData.rs.getString(1));
				empMaster.setPriorityDesc(empMasterData.rs.getString(2));
				empMaster.setPriorityFrom(empMasterData.rs.getString(3));
			}
		} catch (Exception e) {
			//System.out.println("The error in getPriority=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getPrioritys(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList prioritys = new ArrayList();

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from RWS_PRIORITY_TBL order by to_number(priority_code)");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setPriorityCode(empMasterData.rs.getString(1));
				empMaster.setPriorityDesc(empMasterData.rs.getString(2));
				empMaster.setPriorityFrom(empMasterData.rs.getString(3));
				prioritys.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getPrioritys" + e);
		} finally {
			empMasterData.closeAll();
		}
		return prioritys;
	}

	public static int removePriority(String priorityCode, String priorityFrom,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rcount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
          PreparedStatement ps=empMasterData.conn .prepareStatement("delete  from RWS_PRIORITY_TBL where priority_code=? and priority_from=?");
		  ps.setString(1, priorityCode);
		  ps.setString(2,  priorityFrom );
		  rcount =ps.executeUpdate();
		} catch (Exception e) {
			//System.out.println("The error in removePriority" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rcount;
	}

	public static void updatePriority(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt.executeUpdate("UPDATE  RWS_PRIORITY_TBL SET PRIORITY_FROM='"
					+ empMaster.getPriorityFrom().toUpperCase()
					+ "',PRIORITY_DESCRIPTION='"
					+ empMaster.getPriorityDesc().toUpperCase()
					+ "' where priority_code='" + empMaster.getPriorityCode()
					+ "'");
		} catch (Exception e) {
			//System.out.println("The error in updatePriority" + e);
		} finally {
			empMasterData.closeAll();
		}
	}

	public static String getPriorityCode(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String code = null;
		try {
			empMasterData.conn = dataSource.getConnection();

			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT MAX(to_number(PRIORITY_CODE))+1 FROM RWS_PRIORITY_TBL");
			empMasterData.rs.next();
			code = empMasterData.rs.getString(1);
			if (code == null) {
				code = "01";
			} else if (code.length() == 1) {
				code = "0" + code;
			}
		} catch (Exception e) {
			//System.out.println("The error in getPriorityCode" + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	//**********************************Work Specialzation
	// methods**********************************

	public static int insertWorkSpec(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps=empMasterData.conn.prepareStatement("insert into RWS_SPEC_SKILL_TBL values(?,?)");
			ps.setString(1, empMaster.getWorkSpecCode());
			ps.setString(2, empMaster.getWorkSpecName().toUpperCase());
			rowCount = ps.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			//System.out.println("The error in insertWorkSpec " + sqle);
		} catch (Exception e) {
			//System.out.println("The error in insertWorkSpec" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static String getWorkSpecName(String code,Connection conn) throws Exception
	{
		EmpMasterData empMasterData=new EmpMasterData();
		empMasterData.conn=conn;
		String name = null;
		String query;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			if(code!= null)
			{
				query="select SKILL_DESCRIPTION from RWS_SPEC_SKILL_TBL where SKILL_CODE ='"+code+"' ";
				empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
				//System.out.println(" getWorkspecial() Name "+query);
				while(empMasterData.rs1.next())
				{
				name = empMasterData.rs1.getString(1);
				}
			}
		} catch (Exception e) {
			//System.out.println("Ther error in getQualName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}
	//same code with dataSource
	public static String getWorkSpecName(String code,DataSource dataSource) throws Exception
	{
		EmpMasterData empMasterData=new EmpMasterData();
		empMasterData.conn=dataSource.getConnection();
		String name = null;
		String query;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			if(code!= null)
			{
				query="select SKILL_DESCRIPTION from RWS_SPEC_SKILL_TBL where SKILL_CODE ='"+code+"' ";
				empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
				//System.out.println(" getWorkspecial() Name "+query);
				while(empMasterData.rs1.next())
				{
				name = empMasterData.rs1.getString(1);
				}
			}
		} catch (Exception e) {
			//System.out.println("Ther error in getQualName=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return name;
	}
	
	public static EmpMaster getWorkSpec(String skillCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			String query=null;
			query="select * from RWS_SPEC_SKILL_TBL where SKILL_CODE ='"+ skillCode+"' ";
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			//System.out.println("Work"+query);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setWorkSpecCode(empMasterData.rs.getString(1));
				empMaster.setWorkSpecName(empMasterData.rs.getString(2));
			}
		} catch (Exception e) {
			//System.out.println("The error in getWorkSpec" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}
	
     
	public static ArrayList getWorkSpecs(DataSource dataSource)
			throws Exception {   
		EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList workSpecs = new ArrayList();
		String query=null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			query="select * from RWS_SPEC_SKILL_TBL order by SKILL_CODE";
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			//System.out.println("query Work special "+query);
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setWorkSpecCode(empMasterData.rs.getString(1));
				empMaster.setWorkSpecName(empMasterData.rs.getString(2));
				empMaster.setWorkSpecNoName(empMasterData.rs.getString(1) + " - "+ empMasterData.rs.getString(2));
				workSpecs.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in workspecs "+ e);
		} finally {
			empMasterData.closeAll();
		}
		return workSpecs;
	}

	public static int removeWorkSpec(String skillCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rcount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rcount = empMasterData.stmt
					.executeUpdate("delete  from RWS_SPEC_SKILL_TBL where SKILL_CODE="
							+ skillCode);
		} catch (Exception e) {
			//System.out.println("The error in removeWorkSpec" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rcount;
	}

	public static int updateWorkSpec(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int updateCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();

			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps=empMasterData.conn.prepareStatement("update  RWS_SPEC_SKILL_TBL set SKILL_DESCRIPTION=? where SKILL_CODE=? ");
			ps.setString(1, empMaster.getWorkSpecName().toUpperCase());
			ps.setString(2,empMaster.getWorkSpecCode());
			updateCount = ps.executeUpdate();
				
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			//System.out.println("The error in updateHead " + sqle);
		} catch (Exception e) {
			//System.out.println("The error in updateWorkSpec" + e);
		} finally {
			empMasterData.closeAll();
		}
		return updateCount;
	}

	public static String getWorkSpecialCode(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String code = null;
		try {
			empMasterData.conn = dataSource.getConnection();

			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT MAX(to_number(SKILL_CODE))+1 FROM RWS_SPEC_SKILL_TBL");
			empMasterData.rs.next();
			code = empMasterData.rs.getString(1);
			if (code == null) {
				code = "1";
			}
		} catch (Exception e) {
			//System.out.println("The error in getWorkSpecialCode" + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	//**********************************General Data
	// Methods*************************

	public static ArrayList getSourceAssets(String habCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList assets = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from RWS_ASSET_TBL where HAB_CODE='"
							+ habCode + "' order by asset_code");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				String code = empMasterData.rs.getString("ASSET_CODE");
				String name = empMasterData.rs.getString("ASSET_NAME");

				empMaster.setAssetTypeNoName(code + " - " + name);
				assets.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getSourceAssets=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return assets;
	}

	public static ArrayList getAssetHabs(DataSource dataSource, String dcode,
			String mcode) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster;
		ArrayList assethabs = new ArrayList();
		//System.out.println("dcode=" + dcode + "mcode=" + mcode);
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			String query="select panch_code,panch_name,(H.census_plain_popu + H.census_st_popu + H.census_st_popu + H.FLOAT_POP), H.coverage_status from RWS_PANCHAYAT_RAJ_TBL pr, RWS_HABITATION_DIRECTORY_TBL H where pr.PANCH_CODE=H.HAB_CODE and pr.HAB_CODE in (SELECT hab_code FROM RWS_HABMAST_TBL WHERE DCODE='"
				+ dcode
				+ "' and MCODE='"
				+ mcode
				+ "') order by panch_code";
			//System.out.println("query is "+query);
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setHabitation(empMasterData.rs.getString(1));
				empMaster.setHabCode(empMasterData.rs.getString(1));
				empMaster.setHabName(empMasterData.rs.getString(2));
				empMaster.setTotPopu(empMasterData.rs.getString(3));
				empMaster.setCovStatus(empMasterData.rs.getString(4));
				assethabs.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getAssetHabs=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return assethabs;
	}

	public static ArrayList getAssetHabitations(String habCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster;
		ArrayList assethabs = new ArrayList();

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			String query="select panch_code,panch_name from RWS_PANCHAYAT_RAJ_TBL where panch_code='"
				+ habCode + "'";
			//System.out.println("query is "+query);
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setHabitation(empMasterData.rs.getString(1));
				empMaster.setHabCode(empMasterData.rs.getString(1));
				empMaster.setHabName(empMasterData.rs.getString(2));
				assethabs.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getAssetHabs=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return assethabs;
	}

	public static String getMandalName(String dcode, String mcode,DataSource dataSource) throws Exception {  
		EmpMasterData empMasterData=new EmpMasterData();
		String mname = null;
		String query="";
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			query="select MNAME from RWS_MANDAL_TBL where MCODE='"
				+ mcode + "' and DCODE='" + dcode + "'";
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			//System.out.println("query getMandal name"+query);
			while (empMasterData.rs.next()) {
				mname = empMasterData.rs.getString(1);
			}
		} catch (Exception e) {
			//System.out.println("The error in getMandal Name=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return mname;
	}
	
	
	

	//***************************Programme
	// Methods***************************************
	public static String getProgrammeCode(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String code = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT MAX(to_number(PROGRAMME_CODE))+1 FROM rws_programme_tbl");
			empMasterData.rs.next();
			code = empMasterData.rs.getString(1);
			if (code == null) {
				code = "01";
			} else if (code.length() == 1) {
				code = "0" + code;
			}
		} catch (Exception e) {
			//System.out.println("The error in getProgrammeCode" + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	public static int insertProgramme(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();

			rowCount = empMasterData.stmt
					.executeUpdate("insert into rws_programme_tbl values('"
							+ empMaster.getPrgmCode() + "','"
							+ empMaster.getPrgmName().toUpperCase() + "','"
							+ empMaster.getPrgmStartYr() + "','"
							+ empMaster.getCentralShare() + "','"
							+ empMaster.getStateShare() + "','"
							+ empMaster.getPublicShare() + "','"
							+ empMaster.getOtherShare() + "','"
							+ empMaster.getStatus() + "',TO_DATE('"
							+ empMaster.getPrgmEndDate() + "','dd/mm/yyyy'))");
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			//System.out.println("The error in updateHead " + sqle);
		} catch (Exception e) {
			//System.out.println("The error in insertProgramme is " + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getProgramme(String prgmCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from RWS_PROGRAMME_TBL where PROGRAMME_CODE="
							+ prgmCode);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setPrgmCode(empMasterData.rs.getString(1));
				empMaster.setPrgmName(empMasterData.rs.getString(2));
				empMaster.setPrgmStartYr(empMasterData.rs.getString(3));
				empMaster.setCentralShare(empMasterData.rs.getInt(4));
				empMaster.setStateShare(empMasterData.rs.getInt(5));
				empMaster.setPublicShare(empMasterData.rs.getInt(6));
				empMaster.setOtherShare(empMasterData.rs.getInt(7));
				empMaster.setStatus(empMasterData.rs.getString(8));
				empMaster.setPrgmEndDate(df.format(empMasterData.rs.getDate(9)));
			}
		} catch (Exception e) {
			//System.out.println("The error in getProgramme is " + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getProgrammes(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList programmes = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from RWS_PROGRAMME_TBL ORDER BY PROGRAMME_CODE");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setPrgmCode(empMasterData.rs.getString(1));
				empMaster.setPrgmName(empMasterData.rs.getString(2));
				empMaster.setPrgmStartYr(empMasterData.rs.getString(3));
				empMaster.setCentralShare(empMasterData.rs.getInt(4));
				empMaster.setStateShare(empMasterData.rs.getInt(5));
				empMaster.setPublicShare(empMasterData.rs.getInt(6));
				empMaster.setOtherShare(empMasterData.rs.getInt(7));
				if (empMasterData.rs.getString(8).equalsIgnoreCase("F"))
					empMaster.setStatus("FRESH");
				else
					empMaster.setStatus("ONGOING");

				if (empMasterData.rs.getDate(9) != null) {
					empMaster.setPrgmEndDate(df.format(empMasterData.rs.getDate(9)));
				}

				empMaster.setSubPrgDisplay(empMasterData.rs.getString(2));
				programmes.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getProgrammes is " + e);
		} finally {
			empMasterData.closeAll();
		}
		return programmes;
	}

	public static int removeProgramme(String prgmCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rcount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps=empMasterData.conn .prepareStatement("delete  from RWS_PROGRAMME_TBL where PROGRAMME_CODE=?");
			ps.setString(1, prgmCode);
			rcount =ps.executeUpdate();
					
		} catch (Exception e) {
			//System.out.println("The error in removeProgramme is " + e);
		} finally {
			empMasterData.closeAll();
		}
		return rcount;
	}

	public static int updateProgramme(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int updateCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			ps = empMasterData.conn
					.prepareStatement("update  RWS_PROGRAMME_TBL set PROGRAMME_NAME=?,PROGRAMME_START_YEAR=?,CENTRAL_SHARE=?,STATE_SHARE=?,PUBLIC_SHARE=?,OTHER_SHARE=?,FRESH_ONGOING=?,"
							+ "PROGRAMME_END_DATE=TO_DATE(?,'dd/mm/yyyy') where PROGRAMME_CODE=?");

			ps.setString(1, empMaster.getPrgmName().toUpperCase());
			ps.setString(2, empMaster.getPrgmStartYr());
			ps.setInt(3, empMaster.getCentralShare());
			ps.setInt(4, empMaster.getStateShare());
			ps.setInt(5, empMaster.getPublicShare());
			ps.setInt(6, empMaster.getOtherShare());
			ps.setString(7, empMaster.getStatus());
			ps.setString(8,empMaster.getPrgmEndDate());
			ps.setString(9, empMaster.getPrgmCode());
			updateCount = ps.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			//System.out.println("The error in updateHead " + sqle);
		} catch (Exception e) {
			//System.out.println("The error in updateProgramme is " + e);
		} finally {
			empMasterData.closeAll();
		}
		return updateCount;
	}

	//***************************SubProgramme
	// Methods***************************************
	public static int insertSubProgramme(EmpMaster empMaster,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps=empMasterData.conn.prepareStatement("insert into rws_subprogramme_tbl values(?,?,?)");
			ps.setString(1,empMaster.getPrgmCode());
			ps.setString(2, empMaster.getSubprgmCode());
			ps.setString(3,empMaster.getSubprgmName().toUpperCase());
			rowCount = ps.executeUpdate();
		} catch (SQLException sqle) {
			//System.out.println("The error in insertSubProgramme is " + sqle);
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println("The error in insertSubProgramme is " + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getSubProgramme(String prgmCode,
			String subprgmCode, DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from RWS_SUBPROGRAMME_TBL where SUBPROGRAMME_CODE='"
							+ subprgmCode
							+ "' and PROGRAMME_CODE='"
							+ prgmCode
							+ "'");
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setPrgmCode(empMasterData.rs.getString(1));
				empMaster.setPrgmName(getPrgmName(empMasterData.rs.getString(1), empMasterData.conn));
				empMaster.setSubprgmCode(empMasterData.rs.getString(2));
				empMaster.setSubprgmName(empMasterData.rs.getString(3));
			}
		} catch (Exception e) {
			//System.out.println("The error in getSubProgramme is " + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getSubProgrammes(String progCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList subprogrammes = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			if (progCode.equals(""))
				empMasterData.rs =empMasterData.stmt
						.executeQuery("SELECT S.PROGRAMME_CODE,P.PROGRAMME_NAME,S.SUBPROGRAMME_CODE,S.SUBPROGRAMME_NAME FROM RWS_SUBPROGRAMME_TBL S,RWS_PROGRAMME_TBL P WHERE P.PROGRAMME_CODE=S.PROGRAMME_CODE ORDER BY P.PROGRAMME_CODE,S.SUBPROGRAMME_CODE");
			else
				empMasterData.rs =empMasterData.stmt
						.executeQuery("SELECT S.PROGRAMME_CODE,P.PROGRAMME_NAME,S.SUBPROGRAMME_CODE,S.SUBPROGRAMME_NAME FROM RWS_SUBPROGRAMME_TBL S,RWS_PROGRAMME_TBL P WHERE P.PROGRAMME_CODE=S.PROGRAMME_CODE AND P.PROGRAMME_CODE='"
								+ progCode
								+ "' AND S.PROGRAMME_CODE='"
								+ progCode
								+ "' ORDER BY P.PROGRAMME_CODE,S.SUBPROGRAMME_CODE");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setPrgmCode(empMasterData.rs.getString(1));
				empMaster.setPrgmName(empMasterData.rs.getString(2));
				empMaster.setSubprgmCode(empMasterData.rs.getString(3));
				empMaster.setSubprgmName(empMasterData.rs.getString(4));

				subprogrammes.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getSubProgrammes is " + e);
		} finally {
			empMasterData.closeAll();
		}
		return subprogrammes;
	}

	public static int removeSubProgramme(String prgmCode, String subprgmCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rcount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps=empMasterData.conn.prepareStatement("delete  from RWS_SUBPROGRAMME_TBL where SUBPROGRAMME_CODE=? and PROGRAMME_CODE=?");
			ps.setString(1, subprgmCode);
			ps.setString(2, prgmCode);
			rcount = ps.executeUpdate();
					
		} catch (Exception e) {
			//System.out.println("The error in removeSubProgramme is " + e);
		} finally {
			empMasterData.closeAll();
		}
		return rcount;
	}

	public static int updateSubProgramme(EmpMaster empMaster,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int updateCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps=empMasterData.conn.prepareStatement("update  RWS_SUBPROGRAMME_TBL set SUBPROGRAMME_NAME=? where SUBPROGRAMME_CODE=? and PROGRAMME_CODE=?");
			ps.setString(1, empMaster.getSubprgmName().toUpperCase());
			ps.setString(2,  empMaster.getSubprgmCode());
			ps.setString(3,empMaster.getPrgmCode());
			updateCount = ps.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			//System.out.println("The error in updateSubProgramme " + sqle);
		} catch (Exception e) {
			//System.out.println("The error in updateSubProgramme is " + e);
		} finally {
			empMasterData.closeAll();
		}
		return updateCount;
	}

	public static String getSubProgrammeCode(String prgmCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String code = null;
		if (prgmCode != null) {
			try {
				empMasterData.conn = dataSource.getConnection();
				empMasterData.stmt = empMasterData.conn.createStatement();
				empMasterData.rs =empMasterData.stmt
						.executeQuery("SELECT MAX(to_number(SUBPROGRAMME_CODE))+1 FROM RWS_SUBPROGRAMME_TBL WHERE PROGRAMME_CODE='"
								+ prgmCode + "'");
				empMasterData.rs.next();
				code = empMasterData.rs.getString(1);
				if (code == null) {
					code = "01";
				} else if (code.length() == 1) {
					code = "0" + code;
				}
			} catch (Exception e) {
				//System.out.println("The error in getSubProgrammeCode" + e);
			} finally {
				empMasterData.closeAll();
			}
		}
		return code;
	}

	public static ArrayList getSubProgrammeCodes(DataSource dataSource,
			String prgmCode) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList subprogrammes = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT SUBPROGRAMME_CODE,SUBPROGRAMME_NAME FROM RWS_SUBPROGRAMME_TBL WHERE PROGRAMME_CODE='"
							+ prgmCode + "' ORDER BY SUBPROGRAMME_CODE");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setSubprgmCode(empMasterData.rs.getString(1));
				empMaster.setSubprgmName(empMasterData.rs.getString(2));

				subprogrammes.add(empMaster);
			}
		} catch (Exception e) {
			Debug
					.println("The error in getSubProgrammeCodes in EmpMasterData is==="
							+ e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return subprogrammes;
	}

	//*************************************Major Head
	// Methods****************************************
	public static int insertMajorHead(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
            PreparedStatement ps=empMasterData.conn.prepareStatement("insert into rws_majorhead_tbl values(?,?)");
			ps.setString(1,empMaster.getMajorHeadCode());
			ps.setString(2, empMaster.getMajorHeadName().toUpperCase());
            rowCount = ps.executeUpdate();
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			//System.out.println("Error Code=" + errorCode + "message="
					+ sqle.getMessage());
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println("The error in insertHead" + e);
		} finally {
			empMasterData.closeAll();
		}

		return rowCount;
	}

	public static EmpMaster getMajorHead(String majorHeadCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt.executeQuery("select * from rws_majorhead_tbl"
					+ " where major_head_code='" + majorHeadCode + "'");
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setMajorHeadCode(empMasterData.rs.getString(1));
				empMaster.setMajorHeadName(empMasterData.rs.getString(2));
			}
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getMajorHeads(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList majorheads = new ArrayList();

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt.executeQuery("select * from rws_majorhead_tbl"
					+ " order by major_head_code");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setMajorHeadCode(empMasterData.rs.getString(1));
				empMaster.setMajorHeadName(empMasterData.rs.getString(2));

				empMaster.setCodeName(empMasterData.rs.getString(1) + " - " + empMasterData.rs.getString(2));
				majorheads.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error is getMajorHeads= " + e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return majorheads;
	}

	public static int removeMajorHead(String majorHeadCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps=empMasterData.conn.prepareStatement("delete  from rws_majorhead_tbl where major_head_code=?"); 
		    ps.setString(1,majorHeadCode);
		    rowCount = ps.executeUpdate();
					
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static int updateMajorHead(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int ans = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
             PreparedStatement ps=empMasterData.conn.prepareStatement(sql);
             String query="update  rws_majorhead_tbl set major_head_name=? where major_head_code=?";
			ans = ps.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println("the error in updateMajorHead= "
					+ e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return ans;
	}

	//*************************************Sub Major Head
	// Methods****************************************
	public static int insertSubMajorHead(EmpMaster empMaster,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			PreparedStatement ps=empMasterData.conn.prepareStatement("insert into rws_submajorhead_tbl values(?,?,?)");
			ps.setString(1,empMaster.getMajorHeadCode());
			ps.setString(2,empMaster.getSubmajorHeadCode());
			ps.setString(3,empMaster.getSubmajorHeadName().toUpperCase());
			rowCount = ps.executeUpdate();
					
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println("The error is insertSubMajorHead= "
					+ e.getMessage());
		}

		finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getSubMajorHead(String majorHeadCode,
			String submajorHeadCode, DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt.executeQuery("select * from rws_submajorhead_tbl "
					+ "where submajor_head_code='" + submajorHeadCode + "' "
					+ "and major_head_code='" + majorHeadCode + "'");
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setMajorHeadCode(empMasterData.rs.getString(1));
				empMaster.setMajorHeadName(getMajorHeadName(empMasterData.rs.getString(1),
						empMasterData.conn));
				empMaster.setSubmajorHeadCode(empMasterData.rs.getString(2));
				empMaster.setSubmajorHeadName(empMasterData.rs.getString(3));
			}
		} catch (Exception e) {
			//System.out.println("the error is in getSubMajorHead= "
					+ e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getSubMajorHeads(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList submajorheads = new ArrayList();

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select m.major_head_code,m.major_head_name,"
							+ "s.submajor_head_code,s.submajor_head_name "
							+ "from rws_majorhead_tbl m,rws_submajorhead_tbl s "
							+ "where m.major_head_code=s.major_head_code "
							+ "order by major_head_code,submajor_head_code");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setMajorHeadCode(empMasterData.rs.getString(1));
				empMaster.setMajorHeadName(empMasterData.rs.getString(2));
				empMaster.setSubmajorHeadCode(empMasterData.rs.getString(3));
				empMaster.setSubmajorHeadName(empMasterData.rs.getString(4));

				submajorheads.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return submajorheads;
	}

	public static int removeSubMajorHead(String majorHeadCode,
			String submajorHeadCode, DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rowCount = empMasterData.stmt
					.executeUpdate("delete  from rws_submajorhead_tbl where submajor_head_code='"
							+ submajorHeadCode
							+ "' and major_head_code='"
							+ majorHeadCode + "'");
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static int updateSubMajorHead(EmpMaster empMaster,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int ans = 0;
		try {
			empMasterData.conn = dataSource.getConnection();

			ps = empMasterData.conn
					.prepareStatement("update  rws_submajorhead_tbl set submajor_head_name=? where submajor_head_code=? and major_head_code=?");
			ps.setString(1, empMaster.getSubmajorHeadName().toUpperCase());
			ps.setString(2, empMaster.getSubmajorHeadCode());
			ps.setString(3, empMaster.getMajorHeadCode());
			ans = ps.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return ans;
	}

	public static ArrayList getSubMajorHeadCodes(String majorHeadCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList submajorheads = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select submajor_head_code,submajor_head_name "
							+ "from rws_submajorhead_tbl "
							+ "where major_head_code='"
							+ majorHeadCode
							+ "'"
							+ "order by submajor_head_code");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setSubmajorHeadCode(empMasterData.rs.getString(1));
				empMaster.setSubmajorHeadName(empMasterData.rs.getString(2));

				empMaster
						.setCodeName(empMasterData.rs.getString(1) + " - " + empMasterData.rs.getString(2));
				submajorheads.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return submajorheads;
	}

	//*********************************Minor Head
	// Methods****************************************//

	public static int insertMinorHead(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rowCount = empMasterData.stmt
					.executeUpdate("insert into rws_minorhead_tbl values"
							+ "('" + empMaster.getMajorHeadCode() + "'," + "'"
							+ empMaster.getSubmajorHeadCode() + "'," + "'"
							+ empMaster.getMinorHeadCode() + "'," + "'"
							+ empMaster.getMinorHeadName().toUpperCase() + "')");
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println("The error in insertHead" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getMinorHead(String majorHeadCode,
			String submajorHeadCode, String minorHeadCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt.executeQuery("select * from rws_minorhead_tbl "
					+ "where minor_head_code='" + minorHeadCode + "' "
					+ "and major_head_code='" + majorHeadCode + "' "
					+ "and submajor_head_code='" + submajorHeadCode + "'");
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setMajorHeadCode(empMasterData.rs.getString(1));
				empMaster.setMajorHeadName(getMajorHeadName(empMasterData.rs.getString(1),
						empMasterData.conn));
				empMaster.setSubmajorHeadCode(empMasterData.rs.getString(2));
				empMaster.setSubmajorHeadName(getSubMajorHeadName(empMasterData.rs
						.getString(1), empMasterData.rs.getString(2), empMasterData.conn));
				empMaster.setMinorHeadCode(empMasterData.rs.getString(3));
				empMaster.setMinorHeadName(empMasterData.rs.getString(4));
			}
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getMinorHeads(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList minorHeads = new ArrayList();

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.stmt2 = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select mj.major_head_code,mj.major_head_name,"
							+ "s.submajor_head_code,s.submajor_head_name,"
							+ "mi.minor_head_code,mi.minor_head_name "
							+ "from rws_majorhead_tbl mj,rws_submajorhead_tbl s,"
							+ "rws_minorhead_tbl mi where mj.major_head_code=mi.major_head_code "
							+ "and s.submajor_head_code=mi.submajor_head_code "
							+ "and mj.major_head_code=s.major_head_code "
							+ "order by major_head_code,submajor_head_code,minor_head_code");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setMajorHeadCode(empMasterData.rs.getString(1));
				empMaster.setMajorHeadName(empMasterData.rs.getString(2));
				empMaster.setSubmajorHeadCode(empMasterData.rs.getString(3));
				empMaster.setSubmajorHeadName(empMasterData.rs.getString(4));
				empMaster.setMinorHeadCode(empMasterData.rs.getString(5));
				empMaster.setMinorHeadName(empMasterData.rs.getString(6));

				minorHeads.add(empMaster);
			}

		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return minorHeads;
	}

	public static int removeMinorHead(String majorHeadCode,
			String submajorHeadCode, String minorHeadCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rowCount = empMasterData.stmt
					.executeUpdate("delete  from rws_minorhead_tbl  where minor_head_code='"
							+ minorHeadCode
							+ "' and major_head_code='"
							+ majorHeadCode
							+ "' and submajor_head_code='"
							+ submajorHeadCode + "'");
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static int updateMinorHead(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int ans = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			ps = empMasterData.conn
					.prepareStatement("update  rws_minorhead_tbl set minor_head_name=? where minor_head_code=? and submajor_head_code=? and major_head_code=?");
			ps.setString(1, empMaster.getMinorHeadName().toUpperCase());
			ps.setString(2, empMaster.getMinorHeadCode());
			ps.setString(3, empMaster.getSubmajorHeadCode());
			ps.setString(4, empMaster.getMajorHeadCode());

			ans = ps.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return ans;
	}

	public static ArrayList getMinorHeadCodes(String majorHeadCode,
			String submajorHeadCode, DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList minorHeads = new ArrayList();

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select minor_head_code,minor_head_name from rws_minorhead_tbl where submajor_head_code='"
							+ submajorHeadCode
							+ "' and major_head_code='"
							+ majorHeadCode + "'");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setMinorHeadCode(empMasterData.rs.getString(1));
				empMaster.setMinorHeadName(empMasterData.rs.getString(2));

				empMaster
						.setCodeName(empMasterData.rs.getString(1) + " - " + empMasterData.rs.getString(2));
				minorHeads.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return minorHeads;
	}

	//******************************************************************************//

	public static int insertGrpSubHead(EmpMaster empMaster,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rowCount = empMasterData.stmt
					.executeUpdate("insert into rws_groupsubhead_tbl values('"
							+ empMaster.getMajorHeadCode() + "','"
							+ empMaster.getSubmajorHeadCode() + "','"
							+ empMaster.getMinorHeadCode() + "','"
							+ empMaster.getGrpSubHeadCode() + "','"
							+ empMaster.getGrpSubHeadName().toUpperCase()
							+ "')");

		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println("The error in insertHead" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getGrpSubHead(String majorHeadCode,
			String submajorHeadCode, String minorHeadCode,
			String grpSubHeadCode, DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from rws_groupsubhead_tbl where grp_subhead_code='"
							+ grpSubHeadCode
							+ "' and major_head_code='"
							+ majorHeadCode
							+ "' and submajor_head_code='"
							+ submajorHeadCode
							+ "' and minor_head_code='"
							+ minorHeadCode + "'");
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setMajorHeadCode(empMasterData.rs.getString("MAJOR_HEAD_CODE"));
				empMaster.setMajorHeadName(getMajorHeadName(empMasterData.rs
						.getString("MAJOR_HEAD_CODE"), empMasterData.conn));
				empMaster.setSubmajorHeadCode(empMasterData.rs
						.getString("SUBMAJOR_HEAD_CODE"));
				empMaster.setSubmajorHeadName(getSubMajorHeadName(empMasterData.rs
						.getString("MAJOR_HEAD_CODE"), empMasterData.rs
						.getString("SUBMAJOR_HEAD_CODE"), empMasterData.conn));
				empMaster.setMinorHeadCode(empMasterData.rs.getString("MINOR_HEAD_CODE"));
				empMaster.setMinorHeadName(getMinorHeadName(empMasterData.rs
						.getString("MAJOR_HEAD_CODE"), empMasterData.rs
						.getString("SUBMAJOR_HEAD_CODE"), empMasterData.rs
						.getString("MINOR_HEAD_CODE"), empMasterData.conn));
				empMaster.setGrpSubHeadCode(empMasterData.rs.getString("GRP_SUBHEAD_CODE"));
				empMaster.setGrpSubHeadName(empMasterData.rs.getString("GRPR_SUBHEAD_NAME"));
			}

		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getGrpSubHeads(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList grpSubHeads = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT MJ.MAJOR_HEAD_CODE,MJ.MAJOR_HEAD_NAME,S.SUBMAJOR_HEAD_CODE,S.SUBMAJOR_HEAD_NAME,M.MINOR_HEAD_CODE,M.MINOR_HEAD_NAME,G.GRP_SUBHEAD_CODE,G.GRPR_SUBHEAD_NAME FROM RWS_MAJORHEAD_TBL MJ,RWS_SUBMAJORHEAD_TBL S,RWS_MINORHEAD_TBL M,RWS_GROUPSUBHEAD_TBL G WHERE MJ.MAJOR_HEAD_CODE=G.MAJOR_HEAD_CODE AND S.MAJOR_HEAD_CODE=G.MAJOR_HEAD_CODE AND S.SUBMAJOR_HEAD_CODE=G.SUBMAJOR_HEAD_CODE AND M.MAJOR_HEAD_CODE=G.MAJOR_HEAD_CODE AND M.SUBMAJOR_HEAD_CODE=G.SUBMAJOR_HEAD_CODE AND M.MINOR_HEAD_CODE=G.MINOR_HEAD_CODE");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setMajorHeadCode(empMasterData.rs.getString(1));
				empMaster.setMajorHeadName(empMasterData.rs.getString(2));
				empMaster.setSubmajorHeadCode(empMasterData.rs.getString(3));
				empMaster.setSubmajorHeadName(empMasterData.rs.getString(4));
				empMaster.setMinorHeadCode(empMasterData.rs.getString(5));
				empMaster.setMinorHeadName(empMasterData.rs.getString(6));
				empMaster.setGrpSubHeadCode(empMasterData.rs.getString(7));
				empMaster.setGrpSubHeadName(empMasterData.rs.getString(8));

				grpSubHeads.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("the error is in getGrpSubHeads= "
					+ e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return grpSubHeads;
	}

	public static int removeGrpSubHead(String majorHeadCode,
			String submajorHeadCode, String minorHeadCode,
			String grpSubHeadCode, DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rowCount = empMasterData.stmt
					.executeUpdate("delete  from rws_groupsubhead_tbl where grp_subhead_code='"
							+ grpSubHeadCode
							+ "' and major_head_code='"
							+ majorHeadCode
							+ "' and submajor_head_code='"
							+ submajorHeadCode
							+ "' and minor_head_code='"
							+ minorHeadCode + "'");
		} catch (Exception e) {
			//System.out.println("the error is in removeGrpSubHead()="
					+ e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static int updateGrpSubHead(EmpMaster empMaster,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int ans = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			ps = empMasterData.conn
					.prepareStatement("update rws_groupsubhead_tbl set grpr_subhead_name=? where grp_subhead_code=? and minor_head_code=? and submajor_head_code=? and major_head_code=?");
			ps.setString(1, empMaster.getGrpSubHeadName().toUpperCase());
			ps.setString(2, empMaster.getGrpSubHeadCode());
			ps.setString(3, empMaster.getMinorHeadCode());
			ps.setString(4, empMaster.getSubmajorHeadCode());
			ps.setString(5, empMaster.getMajorHeadCode());
			ans = ps.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return ans;
	}

	public static ArrayList getGrpSubHeadCodes(String majorHeadCode,
			String submajorHeadCode, String minorHeadCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList grpSubHeads = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select grp_subhead_code,grpr_subhead_name from RWS_GROUPSUBHEAD_TBL where submajor_head_code='"
							+ submajorHeadCode
							+ "' and major_head_code='"
							+ majorHeadCode
							+ "' and minor_head_code='"
							+ minorHeadCode + "'");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setGrpSubHeadCode(empMasterData.rs.getString(1));
				empMaster.setGrpSubHeadName(empMasterData.rs.getString(2));

				empMaster
						.setCodeName(empMasterData.rs.getString(1) + " - " + empMasterData.rs.getString(2));
				grpSubHeads.add(empMaster);

			}
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return grpSubHeads;
	}

	//**********************************************************************************//

	public static int insertSubHead(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rowCount = empMasterData.stmt
					.executeUpdate("insert into rws_subhead_tbl values('"
							+ empMaster.getMajorHeadCode() + "','"
							+ empMaster.getSubmajorHeadCode() + "','"
							+ empMaster.getMinorHeadCode() + "','"
							+ empMaster.getGrpSubHeadCode() + "','"
							+ empMaster.getSubHeadCode() + "','"
							+ empMaster.getSubHeadName().toUpperCase() + "')");

		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println("The error in insertHead" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getSubHead(String majorHeadCode,
			String submajorHeadCode, String minorHeadCode,
			String grpSubHeadCode, String subHeadCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();

			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from rws_subhead_tbl where subhead_code='"
							+ subHeadCode
							+ "' and grp_subhead_code='"
							+ grpSubHeadCode
							+ "' and major_head_code='"
							+ majorHeadCode
							+ "' and submajor_head_code='"
							+ submajorHeadCode
							+ "' and minor_head_code='"
							+ minorHeadCode + "'");
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setMajorHeadCode(empMasterData.rs.getString("MAJOR_HEAD_CODE"));
				empMaster.setMajorHeadName(getMajorHeadName(empMasterData.rs
						.getString("MAJOR_HEAD_CODE"), empMasterData.conn));
				empMaster.setSubmajorHeadCode(empMasterData.rs
						.getString("SUBMAJOR_HEAD_CODE"));
				empMaster.setSubmajorHeadName(getSubMajorHeadName(empMasterData.rs
						.getString("MAJOR_HEAD_CODE"), empMasterData.rs
						.getString("SUBMAJOR_HEAD_CODE"), empMasterData.conn));
				empMaster.setMinorHeadCode(empMasterData.rs.getString("MINOR_HEAD_CODE"));
				empMaster.setMinorHeadName(getMinorHeadName(empMasterData.rs
						.getString("MAJOR_HEAD_CODE"), empMasterData.rs
						.getString("SUBMAJOR_HEAD_CODE"), empMasterData.rs
						.getString("MINOR_HEAD_CODE"), empMasterData.conn));
				empMaster.setGrpSubHeadCode(empMasterData.rs.getString("GRP_SUBHEAD_CODE"));
				empMaster.setGrpSubHeadName(getGrpSubHeadName(empMasterData.rs
						.getString("MAJOR_HEAD_CODE"), empMasterData.rs
						.getString("SUBMAJOR_HEAD_CODE"), empMasterData.rs
						.getString("MINOR_HEAD_CODE"), empMasterData.rs
						.getString("GRP_SUBHEAD_CODE"), empMasterData.conn));
				empMaster.setSubHeadCode(empMasterData.rs.getString("SUBHEAD_CODE"));
				empMaster.setSubHeadName(empMasterData.rs.getString("SUBHEAD_NAME"));
			}
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getSubHeads(DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList subHeads = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();

			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT MJ.MAJOR_HEAD_CODE,MJ.MAJOR_HEAD_NAME,"
							+ "S.SUBMAJOR_HEAD_CODE,S.SUBMAJOR_HEAD_NAME,"
							+ "M.MINOR_HEAD_CODE,M.MINOR_HEAD_NAME,"
							+ "G.GRP_SUBHEAD_CODE,G.GRPR_SUBHEAD_NAME,"
							+ "SH.SUBHEAD_CODE,SH.SUBHEAD_NAME "
							+ "FROM RWS_MAJORHEAD_TBL MJ,RWS_SUBMAJORHEAD_TBL S,RWS_MINORHEAD_TBL M,RWS_GROUPSUBHEAD_TBL G,RWS_SUBHEAD_TBL SH WHERE MJ.MAJOR_HEAD_CODE=G.MAJOR_HEAD_CODE AND S.MAJOR_HEAD_CODE=G.MAJOR_HEAD_CODE AND S.SUBMAJOR_HEAD_CODE=G.SUBMAJOR_HEAD_CODE AND M.MAJOR_HEAD_CODE=G.MAJOR_HEAD_CODE AND M.SUBMAJOR_HEAD_CODE=G.SUBMAJOR_HEAD_CODE AND M.MINOR_HEAD_CODE=G.MINOR_HEAD_CODE AND G.MAJOR_HEAD_CODE=SH.MAJOR_HEAD_CODE AND G.SUBMAJOR_HEAD_CODE=SH.SUBMAJOR_HEAD_CODE AND G.MINOR_HEAD_CODE=SH.MINOR_HEAD_CODE AND G.GRP_SUBHEAD_CODE=SH.GRP_SUBHEAD_CODE");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setMajorHeadCode(empMasterData.rs.getString(1));
				empMaster.setMajorHeadName(empMasterData.rs.getString(2));
				empMaster.setSubmajorHeadCode(empMasterData.rs.getString(3));
				empMaster.setSubmajorHeadName(empMasterData.rs.getString(4));
				empMaster.setMinorHeadCode(empMasterData.rs.getString(5));
				empMaster.setMinorHeadName(empMasterData.rs.getString(6));
				empMaster.setGrpSubHeadCode(empMasterData.rs.getString(7));
				empMaster.setGrpSubHeadName(empMasterData.rs.getString(8));
				empMaster.setSubHeadCode(empMasterData.rs.getString(9));
				empMaster.setSubHeadName(empMasterData.rs.getString(10));

				subHeads.add(empMaster);
			}

		} catch (Exception e) {
			//System.out.println("THE ERROR IS IN getSubHeads=" + e.getMessage());
		} finally {
			empMasterData.closeAll();

		}
		return subHeads;
	}

	public static int removeSubHead(String majorHeadCode,
			String submajorHeadCode, String minorHeadCode,
			String grpSubHeadCode, String subHeadCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int count = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT * FROM rws_detailhead_tbl where subhead_code='"
							+ subHeadCode
							+ "' and grp_subhead_code='"
							+ grpSubHeadCode
							+ "' and major_head_code='"
							+ majorHeadCode
							+ "' and submajor_head_code='"
							+ submajorHeadCode
							+ "' and minor_head_code='"
							+ minorHeadCode + "'");
			if (empMasterData.rs.next() == false) {
				count = empMasterData.stmt
						.executeUpdate("delete  from rws_subhead_tbl where subhead_code='"
								+ subHeadCode
								+ "' and grp_subhead_code='"
								+ grpSubHeadCode
								+ "' and major_head_code='"
								+ majorHeadCode
								+ "' and submajor_head_code='"
								+ submajorHeadCode
								+ "' and minor_head_code='"
								+ minorHeadCode + "'");
			}
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return count;
	}

	public static int updateSubHead(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int ans = 0;
		try {
			empMasterData.conn = dataSource.getConnection();

			ps = empMasterData.conn
					.prepareStatement("update  rws_subhead_tbl set subhead_name=? where subhead_code=? and grp_subhead_code=? and minor_head_code=? and submajor_head_code=? and major_head_code=?");
			ps.setString(1, empMaster.getSubHeadName().toUpperCase());
			ps.setString(2, empMaster.getSubHeadCode());
			ps.setString(3, empMaster.getGrpSubHeadCode());
			ps.setString(4, empMaster.getMinorHeadCode());
			ps.setString(5, empMaster.getSubmajorHeadCode());
			ps.setString(6, empMaster.getMajorHeadCode());
			ans = ps.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return ans;
	}

	public static ArrayList getSubHeadCodes(String majorHeadCode,
			String submajorHeadCode, String minorHeadCode,
			String grpSubHeadCode, DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList subHeads = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select subhead_code,subhead_name from RWS_SUBHEAD_TBL where grp_subhead_code='"
							+ grpSubHeadCode
							+ "' and submajor_head_code='"
							+ submajorHeadCode
							+ "' and major_head_code='"
							+ majorHeadCode
							+ "' and minor_head_code='"
							+ minorHeadCode + "'");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setSubHeadCode(empMasterData.rs.getString(1));
				empMaster.setSubHeadName(empMasterData.rs.getString(2));

				empMaster.setCodeName(empMasterData.rs.getString(1) + " - " + empMasterData.rs.getString(2));
				subHeads.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("the error is in getSubHeadCodes="
					+ e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return subHeads;
	}

	//*********************************************************************************//
	public static int insertDetailHead(EmpMaster empMaster,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			//System.out.println("empMaster.getMajorHeadCode()="
					+ empMaster.getMajorHeadCode());
			//System.out.println("empMaster.getSubMajorHeadCode()="
					+ empMaster.getSubmajorHeadCode());
			//System.out.println("empMaster.getMinorHeadCode()="
					+ empMaster.getMinorHeadCode());
			//System.out.println("empMaster.getGrpSubHeadCode()="
					+ empMaster.getGrpSubHeadCode());
			//System.out.println("empMaster.getSubHeadCode()="
					+ empMaster.getSubHeadCode());
			//System.out.println("empMaster.getDetailHeadCode()="
					+ empMaster.getDetailHeadCode());
			//System.out.println("empMaster.getDetailHeadName()="
					+ empMaster.getDetailHeadName());
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rowCount = empMasterData.stmt
					.executeUpdate("insert into rws_detailhead_tbl values("
							+ "'" + empMaster.getMajorHeadCode() + "'," + "'"
							+ empMaster.getSubmajorHeadCode() + "'," + "'"
							+ empMaster.getMinorHeadCode() + "'," + "'"
							+ empMaster.getGrpSubHeadCode() + "'," + "'"
							+ empMaster.getSubHeadCode() + "'," + "'"
							+ empMaster.getDetailHeadCode() + "'," + "'"
							+ empMaster.getDetailHeadName().toUpperCase()
							+ "')");
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println("The error is in insertDetailHead()= "
					+ e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getDetailHead(String majorHeadCode,
			String submajorHeadCode, String minorHeadCode,
			String grpSubHeadCode, String subHeadCode, String detailHeadCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from rws_detailhead_tbl where detail_head_code='"
							+ detailHeadCode
							+ "' and subhead_code='"
							+ subHeadCode
							+ "' and grp_subhead_code='"
							+ grpSubHeadCode
							+ "' and major_head_code='"
							+ majorHeadCode
							+ "' and submajor_head_code='"
							+ submajorHeadCode
							+ "' and minor_head_code='"
							+ minorHeadCode + "'");
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				//System.out.println("major head=" + empMasterData.rs.getString(1)
						+ "sub major code=" + empMasterData.rs.getString(2) + "minor code="
						+ empMasterData.rs.getString(3) + "grp subcode=" + empMasterData.rs.getString(4)
						+ "sub head=" + empMasterData.rs.getString(5) + "detail head="
						+ empMasterData.rs.getString(6));
				empMaster.setMajorHeadCode(empMasterData.rs.getString(1));
				empMaster.setMajorHeadName(getMajorHeadName(empMasterData.rs.getString(1),
						empMasterData.conn));
				empMaster.setSubmajorHeadCode(empMasterData.rs.getString(2));
				empMaster.setSubmajorHeadName(getSubMajorHeadName(empMasterData.rs
						.getString(1), empMasterData.rs.getString(2), empMasterData.conn));
				empMaster.setMinorHeadCode(empMasterData.rs.getString(3));
				empMaster.setMinorHeadName(getMinorHeadName(empMasterData.rs.getString(1), empMasterData.rs
						.getString(2), empMasterData.rs.getString(3), empMasterData.conn));
				empMaster.setGrpSubHeadCode(empMasterData.rs.getString(4));
				empMaster.setGrpSubHeadName(getGrpSubHeadName(empMasterData.rs.getString(1),
								empMasterData.rs.getString(2), empMasterData.rs.getString(3), empMasterData.rs
										.getString(4), empMasterData.conn));
				empMaster.setSubHeadCode(empMasterData.rs.getString(5));
				empMaster.setSubHeadName(getSubHeadName(empMasterData.rs.getString(1), empMasterData.rs
						.getString(2), empMasterData.rs.getString(3), empMasterData.rs.getString(4), empMasterData.rs
						.getString(5), empMasterData.conn));
				empMaster.setDetailHeadCode(empMasterData.rs.getString(6));
				empMaster.setDetailHeadName(empMasterData.rs.getString(7));
			}
		} catch (Exception e) {
			//System.out.println("the error is in getDetailHead="
					+ e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getDetailHeads(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList detailHeads = new ArrayList();

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT MJ.MAJOR_HEAD_CODE,MJ.MAJOR_HEAD_NAME,"
							+ "S.SUBMAJOR_HEAD_CODE,S.SUBMAJOR_HEAD_NAME,"
							+ "M.MINOR_HEAD_CODE,M.MINOR_HEAD_NAME,"
							+ "G.GRP_SUBHEAD_CODE,G.GRPR_SUBHEAD_NAME,"
							+ "SH.SUBHEAD_CODE,SH.SUBHEAD_NAME,"
							+ "D.DETAIL_HEAD_CODE,D.DETAIL_HEAD_NAME "
							+ "FROM RWS_MAJORHEAD_TBL MJ,"
							+ "RWS_SUBMAJORHEAD_TBL S,"
							+ "RWS_MINORHEAD_TBL M,"
							+ "RWS_GROUPSUBHEAD_TBL G,"
							+ "RWS_SUBHEAD_TBL SH,"
							+ "RWS_DETAILHEAD_TBL D "
							+ "WHERE MJ.MAJOR_HEAD_CODE=G.MAJOR_HEAD_CODE AND "
							+ "S.MAJOR_HEAD_CODE=G.MAJOR_HEAD_CODE AND "
							+ "S.SUBMAJOR_HEAD_CODE=G.SUBMAJOR_HEAD_CODE AND "
							+ "M.MAJOR_HEAD_CODE=G.MAJOR_HEAD_CODE AND "
							+ "M.SUBMAJOR_HEAD_CODE=G.SUBMAJOR_HEAD_CODE AND "
							+ "M.MINOR_HEAD_CODE=G.MINOR_HEAD_CODE AND "
							+ "G.MAJOR_HEAD_CODE=SH.MAJOR_HEAD_CODE AND "
							+ "G.SUBMAJOR_HEAD_CODE=SH.SUBMAJOR_HEAD_CODE AND "
							+ "G.MINOR_HEAD_CODE=SH.MINOR_HEAD_CODE AND "
							+ "G.GRP_SUBHEAD_CODE=SH.GRP_SUBHEAD_CODE AND "
							+ "SH.MAJOR_HEAD_CODE=D.MAJOR_HEAD_CODE AND "
							+ "SH.SUBMAJOR_HEAD_CODE=D.SUBMAJOR_HEAD_CODE AND "
							+ "SH.MINOR_HEAD_CODE=D.MINOR_HEAD_CODE AND "
							+ "SH.GRP_SUBHEAD_CODE=D.GRP_SUBHEAD_CODE AND "
							+ "SH.SUBHEAD_CODE=D.SUBHEAD_CODE");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setMajorHeadCode(empMasterData.rs.getString(1));
				empMaster.setMajorHeadName(empMasterData.rs.getString(2));
				empMaster.setSubmajorHeadCode(empMasterData.rs.getString(3));
				empMaster.setSubmajorHeadName(empMasterData.rs.getString(4));
				empMaster.setMinorHeadCode(empMasterData.rs.getString(5));
				empMaster.setMinorHeadName(empMasterData.rs.getString(6));
				empMaster.setGrpSubHeadCode(empMasterData.rs.getString(7));
				empMaster.setGrpSubHeadName(empMasterData.rs.getString(8));
				empMaster.setSubHeadCode(empMasterData.rs.getString(9));
				empMaster.setSubHeadName(empMasterData.rs.getString(10));
				empMaster.setDetailHeadCode(empMasterData.rs.getString(11));
				empMaster.setDetailHeadName(empMasterData.rs.getString(12));

				detailHeads.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("the error is in getDetailHeads="
					+ e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return detailHeads;
	}

	public static int removeDetailHead(String majorHeadCode,
			String submajorHeadCode, String minorHeadCode,
			String grpSubHeadCode, String subHeadCode, String detailHeadCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int count = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT * FROM rws_subdetail_tbl where detail_head_code='"
							+ detailHeadCode
							+ "' and subhead_code='"
							+ subHeadCode
							+ "' and grp_subhead_code='"
							+ grpSubHeadCode
							+ "' and major_head_code='"
							+ majorHeadCode
							+ "' and submajor_head_code='"
							+ submajorHeadCode
							+ "' and minor_head_code='"
							+ minorHeadCode + "'");
			if (empMasterData.rs.next() == false) {
				count = empMasterData.stmt
						.executeUpdate("delete  from rws_detailhead_tbl where detail_head_code='"
								+ detailHeadCode
								+ "' and subhead_code='"
								+ subHeadCode
								+ "' and grp_subhead_code='"
								+ grpSubHeadCode
								+ "' and major_head_code='"
								+ majorHeadCode
								+ "' and submajor_head_code='"
								+ submajorHeadCode
								+ "' and minor_head_code='"
								+ minorHeadCode + "'");
			}
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return count;
	}

	public static int updateDetailHead(EmpMaster empMaster,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int ans = 0;
		try {
			empMasterData.conn = dataSource.getConnection();

			ps = empMasterData.conn
					.prepareStatement("update  rws_detailhead_tbl set detail_head_name=? where detail_head_code=? and subhead_code=? and grp_subhead_code=? and minor_head_code=? and submajor_head_code=? and major_head_code=?");
			ps.setString(1, empMaster.getDetailHeadName().toUpperCase());
			ps.setString(2, empMaster.getDetailHeadCode());
			ps.setString(3, empMaster.getSubHeadCode());
			ps.setString(4, empMaster.getGrpSubHeadCode());
			ps.setString(5, empMaster.getMinorHeadCode());
			ps.setString(6, empMaster.getSubmajorHeadCode());
			ps.setString(7, empMaster.getMajorHeadCode());
			ans = ps.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println("the error is in updateDetailHead="
					+ e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return ans;
	}

	public static ArrayList getDetailHeadCodes(String majorHeadCode,
			String submajorHeadCode, String minorHeadCode,
			String grpSubHeadCode, String subHeadCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList detailHeads = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			////System.out.println("select detailhead_code,detailhead_name from
			// RWS_DETAILHEAD_TBL where subhead_code='"+subHeadCode+"' and
			// grp_subhead_code='"+grpSubHeadCode+"' and
			// submajor_head_code='"+submajorHeadCode+"' and
			// major_head_code='"+majorHeadCode+"' and
			// minor_head_code='"+minorHeadCode+"'");
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select DETAIL_HEAD_CODE,DETAIL_HEAD_NAME from RWS_DETAILHEAD_TBL where subhead_code='"
							+ subHeadCode
							+ "' and grp_subhead_code='"
							+ grpSubHeadCode
							+ "' and submajor_head_code='"
							+ submajorHeadCode
							+ "' and major_head_code='"
							+ majorHeadCode
							+ "' and minor_head_code='"
							+ minorHeadCode + "'");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setDetailHeadCode(empMasterData.rs.getString(1));
				empMaster.setDetailHeadName(empMasterData.rs.getString(2));

				empMaster.setCodeName(empMasterData.rs.getString(1) + " - " + empMasterData.rs.getString(2));
				detailHeads.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return detailHeads;
	}

	//********************************************************************************//

	public static int insertSubDetailHead(EmpMaster empMaster,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rowCount = empMasterData.stmt
					.executeUpdate("insert into rws_subdetail_tbl values("
							+ "'" + empMaster.getMajorHeadCode() + "'," + "'"
							+ empMaster.getSubmajorHeadCode() + "'," + "'"
							+ empMaster.getMinorHeadCode() + "'" + ",'"
							+ empMaster.getGrpSubHeadCode() + "'," + "'"
							+ empMaster.getSubHeadCode() + "'," + "'"
							+ empMaster.getDetailHeadCode() + "'," + "'"
							+ empMaster.getSubDetailHeadCode() + "'," + "'"
							+ empMaster.getSubDetailHeadName().toUpperCase()
							+ "')");
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println("The error is" + e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getSubDetailHead(String majorHeadCode,
			String submajorHeadCode, String minorHeadCode,
			String grpSubHeadCode, String subHeadCode, String detailHeadCode,
			String subDetailHeadCode, DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt.executeQuery("select * from rws_subdetail_tbl "
					+ "where subdetail_head_code='" + subDetailHeadCode
					+ "' and " + "detail_head_code='" + detailHeadCode + "'"
					+ " and subhead_code='" + subHeadCode + "' "
					+ "and grp_subhead_code='" + grpSubHeadCode + "'"
					+ " and major_head_code='" + majorHeadCode + "'"
					+ " and submajor_head_code='" + submajorHeadCode + "'"
					+ " and minor_head_code='" + minorHeadCode + "'");
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setMajorHeadCode(empMasterData.rs.getString(1));
				empMaster.setMajorHeadName(getMajorHeadName(empMasterData.rs.getString(1),
						empMasterData.conn));
				empMaster.setSubmajorHeadCode(empMasterData.rs.getString(2));
				empMaster.setSubmajorHeadName(getSubMajorHeadName(empMasterData.rs
						.getString(1), empMasterData.rs.getString(2), empMasterData.conn));
				empMaster.setMinorHeadCode(empMasterData.rs.getString(3));
				empMaster.setMinorHeadName(getMinorHeadName(empMasterData.rs.getString(1), empMasterData.rs
						.getString(2), empMasterData.rs.getString(3), empMasterData.conn));
				empMaster.setGrpSubHeadCode(empMasterData.rs.getString(4));
				empMaster
						.setGrpSubHeadName(getGrpSubHeadName(empMasterData.rs.getString(1),
								empMasterData.rs.getString(2), empMasterData.rs.getString(3), empMasterData.rs
										.getString(4), empMasterData.conn));
				empMaster.setSubHeadCode(empMasterData.rs.getString(5));
				empMaster.setSubHeadName(getSubHeadName(empMasterData.rs.getString(1), empMasterData.rs
						.getString(2), empMasterData.rs.getString(3), empMasterData.rs.getString(4), empMasterData.rs
						.getString(5), empMasterData.conn));
				empMaster.setDetailHeadCode(empMasterData.rs.getString(6));
				empMaster.setDetailHeadName(getDetailHeadName(empMasterData.rs.getString(1),
						empMasterData.rs.getString(2), empMasterData.rs.getString(3), empMasterData.rs.getString(4), empMasterData.rs
								.getString(5), empMasterData.rs.getString(6), empMasterData.conn));
				empMaster.setSubDetailHeadCode(empMasterData.rs.getString(7));
				empMaster.setSubDetailHeadName(empMasterData.rs.getString(8));
			}
		} catch (Exception e) {
			//System.out.println("the error is in getSubDetailHead="
					+ e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getSubDetailHeads(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList subDetailHeads = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT MJ.MAJOR_HEAD_CODE,MJ.MAJOR_HEAD_NAME,"
							+ "S.SUBMAJOR_HEAD_CODE,S.SUBMAJOR_HEAD_NAME,"
							+ "M.MINOR_HEAD_CODE,M.MINOR_HEAD_NAME,"
							+ "G.GRP_SUBHEAD_CODE,G.GRPR_SUBHEAD_NAME,"
							+ "SH.SUBHEAD_CODE,SH.SUBHEAD_NAME"
							+ ",D.DETAIL_HEAD_CODE,D.DETAIL_HEAD_NAME"
							+ ",SD.SUBDETAIL_HEAD_CODE,SD.SUBDETAIL_HEAD_NAME FROM RWS_MAJORHEAD_TBL MJ,RWS_SUBMAJORHEAD_TBL S,RWS_MINORHEAD_TBL M,RWS_GROUPSUBHEAD_TBL G,RWS_SUBHEAD_TBL SH,RWS_DETAILHEAD_TBL D,RWS_SUBDETAIL_TBL SD WHERE MJ.MAJOR_HEAD_CODE=G.MAJOR_HEAD_CODE AND S.MAJOR_HEAD_CODE=G.MAJOR_HEAD_CODE AND S.SUBMAJOR_HEAD_CODE=G.SUBMAJOR_HEAD_CODE AND M.MAJOR_HEAD_CODE=G.MAJOR_HEAD_CODE AND M.SUBMAJOR_HEAD_CODE=G.SUBMAJOR_HEAD_CODE AND M.MINOR_HEAD_CODE=G.MINOR_HEAD_CODE AND G.MAJOR_HEAD_CODE=SH.MAJOR_HEAD_CODE AND G.SUBMAJOR_HEAD_CODE=SH.SUBMAJOR_HEAD_CODE AND G.MINOR_HEAD_CODE=SH.MINOR_HEAD_CODE AND G.GRP_SUBHEAD_CODE=SH.GRP_SUBHEAD_CODE AND SH.MAJOR_HEAD_CODE=D.MAJOR_HEAD_CODE AND SH.SUBMAJOR_HEAD_CODE=D.SUBMAJOR_HEAD_CODE AND SH.MINOR_HEAD_CODE=D.MINOR_HEAD_CODE AND SH.GRP_SUBHEAD_CODE=D.GRP_SUBHEAD_CODE AND SH.SUBHEAD_CODE=D.SUBHEAD_CODE AND D.MAJOR_HEAD_CODE=SD.MAJOR_HEAD_CODE AND D.SUBMAJOR_HEAD_CODE=SD.SUBMAJOR_HEAD_CODE AND D.MINOR_HEAD_CODE=SD.MINOR_HEAD_CODE AND D.GRP_SUBHEAD_CODE=SD.GRP_SUBHEAD_CODE AND D.SUBHEAD_CODE=SD.SUBHEAD_CODE AND D.DETAIL_HEAD_CODE=SD.DETAIL_HEAD_CODE");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setMajorHeadCode(empMasterData.rs.getString(1));
				empMaster.setMajorHeadName(empMasterData.rs.getString(2));
				empMaster.setSubmajorHeadCode(empMasterData.rs.getString(3));
				empMaster.setSubmajorHeadName(empMasterData.rs.getString(4));
				empMaster.setMinorHeadCode(empMasterData.rs.getString(5));
				empMaster.setMinorHeadName(empMasterData.rs.getString(6));
				empMaster.setGrpSubHeadCode(empMasterData.rs.getString(7));
				empMaster.setGrpSubHeadName(empMasterData.rs.getString(8));
				empMaster.setSubHeadCode(empMasterData.rs.getString(9));
				empMaster.setSubHeadName(empMasterData.rs.getString(10));
				empMaster.setDetailHeadCode(empMasterData.rs.getString(11));
				empMaster.setDetailHeadName(empMasterData.rs.getString(12));
				empMaster.setSubDetailHeadCode(empMasterData.rs.getString(13));
				empMaster.setSubDetailHeadName(empMasterData.rs.getString(14));
				subDetailHeads.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("THE ERROR IS IN getSubDetailHeads="
					+ e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return subDetailHeads;
	}

	public static int removeSubDetailHead(String majorHeadCode,
			String submajorHeadCode, String minorHeadCode,
			String grpSubHeadCode, String subHeadCode, String detailHeadCode,
			String subDetailHeadCode, DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rowCount = empMasterData.stmt
					.executeUpdate("delete  from rws_subdetail_tbl where subdetail_head_code='"
							+ subDetailHeadCode
							+ "' and detail_head_code='"
							+ detailHeadCode
							+ "' and subhead_code='"
							+ subHeadCode
							+ "' and grp_subhead_code='"
							+ grpSubHeadCode
							+ "' and major_head_code='"
							+ majorHeadCode
							+ "' and submajor_head_code='"
							+ submajorHeadCode
							+ "' and minor_head_code='"
							+ minorHeadCode + "'");
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static int updateSubDetailHead(EmpMaster empMaster,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int ans = 0;
		try {
			empMasterData.conn = dataSource.getConnection();

			ps = empMasterData.conn
					.prepareStatement("update  rws_subdetail_tbl set subdetail_head_name=? where subdetail_head_code=? and detail_head_code=? and subhead_code=? and grp_subhead_code=? and minor_head_code=? and submajor_head_code=? and major_head_code=?");
			ps.setString(1, empMaster.getSubDetailHeadName().toUpperCase());
			ps.setString(2, empMaster.getSubDetailHeadCode());
			ps.setString(3, empMaster.getDetailHeadCode());
			ps.setString(4, empMaster.getSubHeadCode());
			ps.setString(5, empMaster.getGrpSubHeadCode());
			ps.setString(6, empMaster.getMinorHeadCode());
			ps.setString(7, empMaster.getSubmajorHeadCode());
			ps.setString(8, empMaster.getMajorHeadCode());

			ans = ps.executeUpdate();
		} catch (SQLException sqle) {
			//System.out.println(sqle.getMessage() + "ans=" + ans);
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return ans;
	}

	public static ArrayList getSubDetailHeadCodes(String majorHeadCode,
			String submajorHeadCode, String minorHeadCode,
			String grpSubHeadCode, String subHeadCode, String detailHeadCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList subDetailHeads = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select subdetail_head_code,subdetail_head_name from RWS_SUBDETAILHEAD_TBL where subhead_code='"
							+ subHeadCode
							+ "' and grp_subhead_code='"
							+ grpSubHeadCode
							+ "' and submajor_head_code='"
							+ submajorHeadCode
							+ "' and major_head_code='"
							+ majorHeadCode
							+ "' and minor_head_code='"
							+ minorHeadCode
							+ "' and detail_head_code='"
							+ detailHeadCode + "'");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setSubDetailHeadCode(empMasterData.rs.getString(1));
				empMaster.setSubDetailHeadCode(empMasterData.rs.getString(2));

				empMaster.setCodeName(empMasterData.rs.getString(1) + " - " + empMasterData.rs.getString(2));
				subDetailHeads.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return subDetailHeads;
	}

	//**************************************PAO Methods********************//

	public static int insertPao(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			ps = empMasterData.conn
					.prepareStatement("insert into RWS_PAO_TBL values(?,?,?,?,?,?,?,?,?,?)");
			ps.setString(1, empMaster.getDistcode());
			ps.setString(2, empMaster.getPaocode());
			ps.setString(3, empMaster.getAddress().toUpperCase());
			ps.setString(4, empMaster.getLocation().toUpperCase());
			ps.setString(5, empMaster.getArea().toUpperCase());
			ps.setString(6, empMaster.getCity().toUpperCase());
			ps.setString(7, empMaster.getPin());
			ps.setString(8, empMaster.getPhone());
			ps.setString(9, empMaster.getEmail());
			ps.setString(10, empMaster.getFax());

			rowCount = ps.executeUpdate();
		} catch (Exception e) {
			//System.out.println("The error is" + e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getPao(String paocode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt.executeQuery("select * from RWS_PAO_TBL where PAO_CODE="
					+ paocode);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setDistcode(empMasterData.rs.getString("DISTRICT_CODE"));
				empMaster.setPaocode(empMasterData.rs.getString("PAO_CODE"));
				empMaster.setAddress(empMasterData.rs.getString("PAO_ADDRESS1"));
				empMaster.setLocation(empMasterData.rs.getString("PAO_ADDRESS2"));
				empMaster.setArea(empMasterData.rs.getString("PAO_ADDRESS3"));
				empMaster.setCity(empMasterData.rs.getString("PAO_CITY"));
				empMaster.setPin(empMasterData.rs.getString("PAO_PIN"));
				empMaster.setPhone(empMasterData.rs.getString("PAO_PHONE"));
				empMaster.setEmail(empMasterData.rs.getString("PAO_EMAIL"));
				empMaster.setFax(empMasterData.rs.getString("PAO_FAX"));
			}
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getPaos(DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList paos = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt.executeQuery("select * from RWS_PAO_TBL");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setDistcode(empMasterData.rs.getString("DISTRICT_CODE"));
				empMaster.setPaocode(empMasterData.rs.getString("PAO_CODE"));
				empMaster.setAddress(empMasterData.rs.getString("PAO_ADDRESS1"));
				empMaster.setLocation(empMasterData.rs.getString("PAO_ADDRESS2"));
				empMaster.setArea(empMasterData.rs.getString("PAO_ADDRESS3"));
				empMaster.setCity(empMasterData.rs.getString("PAO_CITY"));
				empMaster.setPin(empMasterData.rs.getString("PAO_PIN"));
				empMaster.setPhone(empMasterData.rs.getString("PAO_PHONE"));
				empMaster.setEmail(empMasterData.rs.getString("PAO_EMAIL"));
				empMaster.setFax(empMasterData.rs.getString("PAO_FAX"));

				paos.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return paos;
	}

	public static void removePao(String paocode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt.executeUpdate("delete  from RWS_PAO_TBL where PAO_CODE='"
					+ paocode + "'");
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {

			empMasterData.closeAll();
		}
	}

	public static void updatePao(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		try {
			empMasterData.conn = dataSource.getConnection();

			ps = empMasterData.conn
					.prepareStatement("update  RWS_PAO_TBL set PAO_ADDRESS1=?,PAO_ADDRESS2=?,PAO_ADDRESS3=?,PAO_CITY=?,PAO_PIN=?,PAO_PHONE=?,PAO_EMAIL=?,PAO_FAX=? where PAO_CODE=?");
			ps.setString(1, empMaster.getAddress().toUpperCase());
			ps.setString(2, empMaster.getLocation().toUpperCase());
			ps.setString(3, empMaster.getArea().toUpperCase());
			ps.setString(4, empMaster.getCity().toUpperCase());
			ps.setString(5, empMaster.getPin());
			ps.setString(6, empMaster.getPhone());
			ps.setString(7, empMaster.getEmail());
			ps.setString(8, empMaster.getFax());
			ps.setString(9, empMaster.getPaocode());
			ps.executeUpdate();
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
	}

	//*******************************************Water Quality
	// Test***********************//

	public static int insertWaterTest(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			ps = empMasterData.conn
					.prepareStatement("insert into RWS_WATER_QUALITY_TEST_TBL values(?,?,?)");
			ps.setString(1, empMaster.getTestCode());
			ps.setString(2, empMaster.getTestName().toUpperCase());
			ps.setString(3, empMaster.getTestPeriod());

			rowCount = ps.executeUpdate();
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println("The error is" + e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getWaterTest(String testCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from RWS_WATER_QUALITY_TEST_TBL where TEST_CODE="
							+ testCode);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setTestCode(empMasterData.rs.getString("TEST_CODE"));
				empMaster.setTestName(empMasterData.rs.getString("TEST_NAME"));
				empMaster.setTestPeriod(empMasterData.rs.getString("TEST_PERIODCITY"));
			}
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getWaterTests(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList watertests = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT TEST_CODE,TEST_NAME,DECODE(TEST_PERIODCITY ,'M','MONTHLY','Q','QUARTERLY','H','HALFERLY','Y','YEARLY') FROM RWS_WATER_QUALITY_TEST_TBL");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setTestCode(empMasterData.rs.getString(1));
				empMaster.setTestName(empMasterData.rs.getString(2));
				empMaster.setTestPeriod(empMasterData.rs.getString(3));
				empMaster.setTestCodeDisplay(empMasterData.rs.getString(1) + "-"
						+ empMasterData.rs.getString(2));
				watertests.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return watertests;
	}

	public static int removeWaterTest(String testCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT * FROM RWS_WQ_PARA_TEST_TBL where TEST_CODE='"
							+ testCode + "'");
			if (empMasterData.rs.next() == false) {
				rowCount = empMasterData.stmt
						.executeUpdate("delete  from RWS_WATER_QUALITY_TEST_TBL where TEST_CODE='"
								+ testCode + "'");
			}
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static int updateWaterTest(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int ans = 0;
		try {
			empMasterData.conn = dataSource.getConnection();

			ps = empMasterData.conn
					.prepareStatement("update  RWS_WATER_QUALITY_TEST_TBL set TEST_NAME=?,TEST_PERIODCITY=? where TEST_CODE=?");

			ps.setString(1, empMaster.getTestName().toUpperCase());
			ps.setString(2, empMaster.getTestPeriod());
			ps.setString(3, empMaster.getTestCode());
			ans = ps.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return ans;
	}

	public static String getTestCode(DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String code = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT MAX(TEST_CODE)+1 FROM RWS_WATER_QUALITY_TEST_TBL");
			empMasterData.rs.next();
			code = empMasterData.rs.getString(1);
			if (code == null) {
				code = "1";
			}
		} catch (Exception e) {
			//System.out.println("Ther error in getTestCode" + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	//******************************Water Parameter
	// Test**********************************************//
	public static int insertWaterParameterTest(EmpMaster empMaster,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			ps = empMasterData.conn
					.prepareStatement("insert into RWS_WQ_PARA_TEST_TBL values(?,?,?,?,?)");
			ps.setString(1, empMaster.getTestCode());
			ps.setString(2, empMaster.getTestPCode());
			ps.setString(3, empMaster.getTestPName().toUpperCase());
			ps.setString(4, empMaster.getMinPerVal());
			ps.setString(5, empMaster.getMaxPerVal());

			rowCount = ps.executeUpdate();
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println("The error is" + e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getWaterParameterTest(String testCode,
			String testPCode, DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		//System.out.println("testCode=" + testCode + " testPCode=" + testPCode);
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from RWS_WQ_PARA_TEST_TBL where TESTING_PARAMETER_CODE='"
							+ testPCode + "' and TEST_CODE='" + testCode + "'");
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setTestCode(empMasterData.rs.getString(1));
				empMaster.setTestName(getTestName(empMasterData.rs.getString(1), empMasterData.conn));
				empMaster.setTestPCode(empMasterData.rs.getString(2));
				empMaster.setTestPName(empMasterData.rs.getString(3));
				empMaster.setMinPerVal(empMasterData.rs.getString(4));
				empMaster.setMaxPerVal(empMasterData.rs.getString(5));
			}
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getWaterParameterTests(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList waterptests = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT P.TEST_CODE,T.TEST_NAME,P.TESTING_PARAMETER_CODE,P.TESTING_PARAMETER_NAME,MIN_PERMISSIBLE_VALUE,MAX_PERMISSIBLE_VALUE FROM RWS_WQ_PARA_TEST_TBL P,RWS_WATER_QUALITY_TEST_TBL T WHERE T.TEST_CODE=P.TEST_CODE ORDER BY TEST_CODE,TESTING_PARAMETER_CODE");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setTestCode(empMasterData.rs.getString(1));
				empMaster.setTestName(empMasterData.rs.getString(2));
				empMaster.setTestPCode(empMasterData.rs.getString(3));
				empMaster.setTestPName(empMasterData.rs.getString(4));
				empMaster.setMinPerVal(empMasterData.rs.getString(5));
				empMaster.setMaxPerVal(empMasterData.rs.getString(6));

				waterptests.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return waterptests;
	}

	public static int removeWaterParameterTest(String testCode,
			String testPCode, DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rcount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rcount = empMasterData.stmt
					.executeUpdate("delete  from RWS_WQ_PARA_TEST_TBL where TESTING_PARAMETER_CODE='"
							+ testPCode + "' and TEST_CODE='" + testCode + "'");
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return rcount;
	}

	public static int updateWaterParameterTest(EmpMaster empMaster,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int ans = 0;
		try {
			empMasterData.conn = dataSource.getConnection();

			ps = empMasterData.conn
					.prepareStatement("update  RWS_WQ_PARA_TEST_TBL set TESTING_PARAMETER_NAME=?,MIN_PERMISSIBLE_VALUE=?,MAX_PERMISSIBLE_VALUE=? where TESTING_PARAMETER_CODE=? and TEST_CODE=?");

			ps.setString(1, empMaster.getTestPName().toUpperCase());
			ps.setString(2, empMaster.getMinPerVal());
			ps.setString(3, empMaster.getMaxPerVal());
			ps.setString(4, empMaster.getTestPCode());
			ps.setString(5, empMaster.getTestCode());

			ans = ps.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return ans;
	}

	public static String getWQPTestCode(String testCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String code = null;
		if (testCode != null) {
			try {
				empMasterData.conn = dataSource.getConnection();
				empMasterData.stmt = empMasterData.conn.createStatement();
				empMasterData.rs =empMasterData.stmt
						.executeQuery("SELECT MAX(TESTING_PARAMETER_CODE)+1 FROM RWS_WQ_PARA_TEST_TBL WHERE TEST_CODE='"
								+ testCode + "'");
				empMasterData.rs.next();
				code = empMasterData.rs.getString(1);
				if (code == null)
					code = "01";
				if (code.length() == 1)
					code = "0" + code;
			} catch (Exception e) {
				//System.out.println("The error in getWQPTestCode" + e);
			} finally {
				empMasterData.closeAll();
			}
		}
		return code;
	}

	//*****************************Contractor
	// Methods***********************************************//

	public static int insertContractor(EmpMaster empMaster,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			ps = empMasterData.conn
					.prepareStatement("insert into RWS_CONTRACTOR_TBL values(?,?,?,?,?,?,TO_DATE('"
							+ empMaster.getRegistrationDate()
							+ "','dd/mm/YYYY'),?,?,?,?,?,?,?,?,?,?,TO_DATE('"
							+ empMaster.getValidFrom()
							+ "','dd/mm/YYYY'),TO_DATE('"
							+ empMaster.getValidTo()
							+ "','dd/mm/YYYY'),?,?,?,?,?,?,?,?,?,?,?)");
			ps.setString(1, empMaster.getContractorCode());
			ps.setString(2, empMaster.getContractorName());
			ps.setString(3, empMaster.getContractorClass());
			ps.setString(4, empMaster.getContractorRating());
			ps.setString(5, empMaster.getContractorRegno());
			ps.setString(6, empMaster.getRegisterAt());
			//ps.setString(7,empMaster.getRegistrationDate());
			ps.setString(7, empMaster.getStreet());
			ps.setString(8, empMaster.getArea());
			ps.setString(9, empMaster.getCity());
			ps.setString(10, empMaster.getPin());
			ps.setString(11, empMaster.getPhone());
			ps.setString(12, empMaster.getMobile());
			ps.setString(13, empMaster.getFax());
			ps.setString(14, empMaster.getEmail());
			ps.setString(15, empMaster.getPanNo());
			ps.setString(16, empMaster.getTinNo());
			//ps.setString(18,empMaster.getValidFrom());
			//ps.setString(19,empMaster.getValidTo());
			ps.setString(17, empMaster.getProjectsExecuted());
			ps.setString(18, empMaster.getProjectsInhand());
			ps.setString(19, empMaster.getProjectsCompletedLastYear());
			ps.setString(20, empMaster.getProjectsCompletedInTime());
			ps.setString(21, empMaster.getProjectsAbandoned());
			ps.setString(22, empMaster.getNoofEoat());
			ps.setString(23, empMaster.getNoofSupplentary());
			ps.setString(24, empMaster.getNoofPenalised());
			ps.setString(25, empMaster.getRemarks());
			ps.setString(26, empMaster.getVatNo());
			ps.setString(27, empMaster.getSpecialize().toUpperCase());

			rowCount = ps.executeUpdate();
		} catch (Exception e) {
			//System.out.println("The error in insertContractor is " + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getContractor(String contractorCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from RWS_CONTRACTOR_TBL where CONTRACTOR_CODE='"
							+ contractorCode + "'");
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setContractorCode(empMasterData.rs.getString("CONTRACTOR_CODE"));
				if (empMasterData.rs.getString("CONTRACTOR_NAME_COMPANY") != null) {
					empMaster.setContractorName(empMasterData.rs.getString(
							"CONTRACTOR_NAME_COMPANY").toUpperCase());
				}
				empMaster.setContractorClass(empMasterData.rs.getString("CONTRACTOR_CLASS"));
				empMaster
						.setContractorRating(empMasterData.rs.getString("CONTRACTOR_RATING"));
				empMaster.setContractorRegno(empMasterData.rs.getString("CONTRACTOR_REG_NO"));
				empMaster.setRegisterAt(empMasterData.rs.getString("REGISTERED_AT"));
				if (empMasterData.rs.getDate("REGISTRATION_DATE") != null) {
					empMaster.setRegistrationDate(df.format(empMasterData.rs
							.getDate("REGISTRATION_DATE")));
				}
				if (empMasterData.rs.getString("CONTRACTOR_ADDRESS1") != null) {
					empMaster.setStreet(empMasterData.rs.getString("CONTRACTOR_ADDRESS1")
							.toUpperCase());
				}
				if (empMasterData.rs.getString("CONTRACTOR_ADDRESS2") != null) {
					empMaster.setArea(empMasterData.rs.getString("CONTRACTOR_ADDRESS2")
							.toUpperCase());
				}
				if (empMasterData.rs.getString("CONTRACTOR_ADDRESS3") != null) {
					empMaster.setCity(empMasterData.rs.getString("CONTRACTOR_ADDRESS3")
							.toUpperCase());
				}
				empMaster.setPin(empMasterData.rs.getString("CONTRACTOR_ADDRESS4"));
				empMaster.setPhone(empMasterData.rs.getString("CONTRACTOR_PHONE"));
				empMaster.setMobile(empMasterData.rs.getString("CONTRACTOR_MOBILE"));
				empMaster.setFax(empMasterData.rs.getString("CONTRACTOR_FAX"));
				empMaster.setEmail(empMasterData.rs.getString("CONTRACTOR_EMAIL"));
				empMaster.setPanNo(empMasterData.rs.getString("PAN_NO"));
				empMaster.setTinNo(empMasterData.rs.getString("TIN_NO"));
				if (empMasterData.rs.getDate("VALIDITY_FROM") != null) {
					empMaster.setValidFrom(df.format(empMasterData.rs
							.getDate("VALIDITY_FROM")));
				}
				if (empMasterData.rs.getDate("VALIDITY_TO") != null) {
					empMaster.setValidTo(df.format(empMasterData.rs.getDate("VALIDITY_TO")));
				}
				empMaster.setProjectsExecuted(empMasterData.rs.getString("PROJECTS_EXECUTED"));
				empMaster.setProjectsInhand(empMasterData.rs.getString("PROJECTS_INHAND"));
				empMaster.setProjectsCompletedLastYear(empMasterData.rs
						.getString("PROJECTS_COMPLETED_INLAST_5YRS"));
				empMaster.setProjectsCompletedInTime(empMasterData.rs
						.getString("PROJECTS_COMPLETED_INTIME"));
				empMaster.setProjectsAbandoned(empMasterData.rs
						.getString("PROJECTS_ABANDONED"));
				empMaster.setNoofEoat(empMasterData.rs.getString("NO_OF_EOAT"));
				empMaster.setNoofSupplentary(empMasterData.rs
						.getString("NO_OF_SUPPLEMENTARY"));
				empMaster.setNoofPenalised(empMasterData.rs.getString("NO_OF_PENALISED"));
				empMaster.setRemarks(empMasterData.rs.getString("REMARKS"));
				empMaster.setVatNo(empMasterData.rs.getString("VATNO"));
				if (empMasterData.rs.getString("SPECIALIZE") != null) {
					empMaster.setSpecialize(empMasterData.rs.getString("SPECIALIZE")
							.toUpperCase());
				}

			}
		} catch (Exception e) {
			//System.out.println("The error in getContractor is " + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getContractors(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList contrators = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from RWS_CONTRACTOR_TBL order by CONTRACTOR_CODE");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setContractorCode(empMasterData.rs.getString("CONTRACTOR_CODE"));
				if (empMasterData.rs.getString("CONTRACTOR_NAME_COMPANY") != null) {
					empMaster.setContractorName(empMasterData.rs.getString(
							"CONTRACTOR_NAME_COMPANY").toUpperCase());
				}
				empMaster.setContractorClass(empMasterData.rs.getString("CONTRACTOR_CLASS"));
				empMaster.setContractorRating(empMasterData.rs.getString("CONTRACTOR_RATING"));
				empMaster.setContractorRegno(empMasterData.rs.getString("CONTRACTOR_REG_NO"));
				empMaster.setRegisterAt(empMasterData.rs.getString("REGISTERED_AT"));
				if (empMasterData.rs.getDate("REGISTRATION_DATE") != null) {
					empMaster.setRegistrationDate(df.format(empMasterData.rs
							.getDate("REGISTRATION_DATE")));
				}
				if (empMasterData.rs.getString("CONTRACTOR_ADDRESS1") != null) {
					empMaster.setStreet(empMasterData.rs.getString("CONTRACTOR_ADDRESS1")
							.toUpperCase());
				}
				if (empMasterData.rs.getString("CONTRACTOR_ADDRESS2") != null) {
					empMaster.setArea(empMasterData.rs.getString("CONTRACTOR_ADDRESS2")
							.toUpperCase());
				}
				if (empMasterData.rs.getString("CONTRACTOR_ADDRESS3") != null) {
					empMaster.setCity(empMasterData.rs.getString("CONTRACTOR_ADDRESS3")
							.toUpperCase());
				}
				empMaster.setPin(empMasterData.rs.getString("CONTRACTOR_ADDRESS4"));
				empMaster.setPhone(empMasterData.rs.getString("CONTRACTOR_PHONE"));
				empMaster.setMobile(empMasterData.rs.getString("CONTRACTOR_MOBILE"));
				empMaster.setFax(empMasterData.rs.getString("CONTRACTOR_FAX"));
				empMaster.setEmail(empMasterData.rs.getString("CONTRACTOR_EMAIL"));
				empMaster.setPanNo(empMasterData.rs.getString("PAN_NO"));
				empMaster.setTinNo(empMasterData.rs.getString("TIN_NO"));
				if (empMasterData.rs.getDate("VALIDITY_FROM") != null) {
					empMaster.setValidFrom(df.format(empMasterData.rs
							.getDate("VALIDITY_FROM")));
				}
				if (empMasterData.rs.getDate("VALIDITY_TO") != null) {
					empMaster.setValidTo(df.format(empMasterData.rs.getDate("VALIDITY_TO")));
				}
				empMaster.setProjectsExecuted(empMasterData.rs.getString("PROJECTS_EXECUTED"));
				empMaster.setProjectsInhand(empMasterData.rs.getString("PROJECTS_INHAND"));
				empMaster.setProjectsCompletedLastYear(empMasterData.rs
						.getString("PROJECTS_COMPLETED_INLAST_5YRS"));
				empMaster.setProjectsCompletedInTime(empMasterData.rs
						.getString("PROJECTS_COMPLETED_INTIME"));
				empMaster.setProjectsAbandoned(empMasterData.rs
						.getString("PROJECTS_ABANDONED"));
				empMaster.setNoofEoat(empMasterData.rs.getString("NO_OF_EOAT"));
				empMaster.setNoofSupplentary(empMasterData.rs
						.getString("NO_OF_SUPPLEMENTARY"));
				empMaster.setNoofPenalised(empMasterData.rs.getString("NO_OF_PENALISED"));
				empMaster.setRemarks(empMasterData.rs.getString("REMARKS"));
				empMaster.setVatNo(empMasterData.rs.getString("VATNO"));
				if (empMasterData.rs.getString("SPECIALIZE") != null) {
					empMaster.setSpecialize(empMasterData.rs.getString("SPECIALIZE")
							.toUpperCase());
				}

				contrators.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getContractors is " + e);
		} finally {
			empMasterData.closeAll();
		}
		return contrators;
	}

	public static int removeContractor(String contractorCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rcount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rcount = empMasterData.stmt
					.executeUpdate("delete  from RWS_CONTRACTOR_TBL where CONTRACTOR_CODE='"
							+ contractorCode + "'");
		} catch (Exception e) {
			//System.out.println("The error in removeContractor is " + e);
		} finally {
			empMasterData.closeAll();
		}
		return rcount;
	}

	public static void updateContractor(EmpMaster empMaster,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		try {
			empMasterData.conn = dataSource.getConnection();

			ps = empMasterData.conn
					.prepareStatement("update  RWS_CONTRACTOR_TBL set CONTRACTOR_NAME_COMPANY=?,CONTRACTOR_CLASS=?,CONTRACTOR_RATING=?,CONTRACTOR_REG_NO=?,REGISTERED_AT=?,REGISTRATION_DATE=to_date('"
							+ empMaster.getRegistrationDate()
							+ "','dd/mm/yyyy'),CONTRACTOR_ADDRESS1=?,CONTRACTOR_ADDRESS2=?,CONTRACTOR_ADDRESS3=?,CONTRACTOR_ADDRESS4=?,CONTRACTOR_PHONE=?,CONTRACTOR_MOBILE=?,CONTRACTOR_FAX=?,CONTRACTOR_EMAIL=?,PAN_NO=?,TIN_NO=?,VALIDITY_FROM=to_date('"
							+ empMaster.getValidFrom()
							+ "','dd/mm/yyyy'),VALIDITY_TO=to_date('"
							+ empMaster.getValidTo()
							+ "','dd/mm/yyyy'),PROJECTS_EXECUTED=?,PROJECTS_INHAND=?,PROJECTS_COMPLETED_INLAST_5YRS=?,PROJECTS_COMPLETED_INTIME=?,PROJECTS_ABANDONED=?,NO_OF_EOAT=?,NO_OF_SUPPLEMENTARY=?,NO_OF_PENALISED=?,REMARKS=?,VATNO=?,SPECIALIZE=? where CONTRACTOR_CODE=?");
			ps.setString(1, empMaster.getContractorName().toUpperCase());
			ps.setString(2, empMaster.getContractorClass());
			ps.setString(3, empMaster.getContractorRating());
			ps.setString(4, empMaster.getContractorRegno());
			ps.setString(5, empMaster.getRegisterAt());
			ps.setString(6, empMaster.getStreet().toUpperCase());
			ps.setString(7, empMaster.getArea().toUpperCase());
			ps.setString(8, empMaster.getCity().toUpperCase());
			ps.setString(9, empMaster.getPin());
			ps.setString(10, empMaster.getPhone());
			ps.setString(11, empMaster.getMobile());
			ps.setString(12, empMaster.getFax());
			ps.setString(13, empMaster.getEmail());
			ps.setString(14, empMaster.getPanNo());
			ps.setString(15, empMaster.getTinNo());
			ps.setString(16, empMaster.getProjectsExecuted());
			ps.setString(17, empMaster.getProjectsInhand());
			ps.setString(18, empMaster.getProjectsCompletedLastYear());
			ps.setString(19, empMaster.getProjectsCompletedInTime());
			ps.setString(20, empMaster.getProjectsAbandoned());
			ps.setString(21, empMaster.getNoofEoat());
			ps.setString(22, empMaster.getNoofSupplentary());
			ps.setString(23, empMaster.getNoofPenalised());
			ps.setString(24, empMaster.getRemarks());
			ps.setString(25, empMaster.getVatNo());
			ps.setString(26, empMaster.getSpecialize());
			ps.setString(27, empMaster.getContractorCode().toUpperCase());

			ps.executeUpdate();
		} catch (Exception e) {
			//System.out.println("The error in updateContractor is " + e);
		} finally {
			empMasterData.closeAll();
		}
	}

	public static String getContractorCode(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String code = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT MAX(to_number(CONTRACTOR_CODE))+1 FROM RWS_CONTRACTOR_TBL");
			empMasterData.rs.next();
			code = empMasterData.rs.getString(1);
			if (code == null)
				code = "1";
			else if (code.length() == 1)
				code = "000" + code;
			else if (code.length() == 2)
				code = "00" + code;
			else if (code.length() == 3)
				code = "0" + code;
		} catch (Exception e) {
			//System.out.println("The error in getContractorCode" + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	//******************************Stores Methods*************************
	public static int insertStore(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			ps = empMasterData.conn
					.prepareStatement("insert into RWS_STORES_CURRENT_TBL values(?,?,?,?,?,?,?,TO_DATE('"
							+ empMaster.getPostheld() + "','dd/mm/yyyy'))");
			ps.setString(1, empMaster.getDistrict());
			ps.setString(2, empMaster.getMandal());
			ps.setString(3, empMaster.getSubdivision());
			ps.setString(4, empMaster.getStoreCode());
			ps.setString(5, empMaster.getLocation());
			ps.setString(6, empMaster.getStoreInCharge());
			ps.setString(7, empMaster.getEmpcode());

			rowCount = ps.executeUpdate();
		} catch (Exception e) {
			//System.out.println("The error is" + e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getStore(String storeCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from RWS_STORES_CURRENT_TBL where STORE_CODE="
							+ storeCode);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setDistrict(empMasterData.rs.getString("DCODE"));
				empMaster.setMandal(empMasterData.rs.getString("MCODE"));
				empMaster.setSubdivision(empMasterData.rs
						.getString("SUBDIVISION_OFFICE_CODE"));
				empMaster.setStoreCode(empMasterData.rs.getString("STORE_CODE"));
				empMaster.setLocation(empMasterData.rs.getString("STORE_LOCATION"));
				empMaster.setStoreInCharge(empMasterData.rs.getString("STORE_INCHARGE"));
				empMaster.setEmpcode(empMasterData.rs.getString("STORE_EMP_CODE"));
				if (empMasterData.rs.getDate("POST_HELD_SINCE") != null) {
					empMaster.setPostheld(df.format(empMasterData.rs
							.getDate("POST_HELD_SINCE")));
				}
			}
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getStores(DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList stores = new ArrayList();

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.stmt2 = empMasterData.conn.createStatement();
			empMasterData.stmt3 = empMasterData.conn.createStatement();
			Statement stmt4 = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt.executeQuery("select * from RWS_STORES_CURRENT_TBL");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				//empMaster.setDistrict(empMasterData.rs.getString("DCODE"));
				try {
					empMasterData.rs1 = empMasterData.stmt1
							.executeQuery("select * from RWS_DISTRICT_MASTER WHERE dcode ='"
									+ empMasterData.rs.getString("DCODE") + "'");
					empMasterData.rs1.next();
					empMaster.setDistrict(empMasterData.rs1.getString("dname"));
				} catch (Exception e) {
					//System.out.println("dname=" + e.getMessage());
				}
				//empMaster.setMandal(empMasterData.rs.getString("MCODE"));
				try {
					ResultSet rs2 = empMasterData.stmt2
							.executeQuery("select * from RWS_MANDAL_TBL WHERE mcode ='"
									+ empMasterData.rs.getString("MCODE") + "'");
					rs2.next();
					empMaster.setMandal(rs2.getString("mname"));
				} catch (Exception e) {
					//System.out.println("mname=" + e.getMessage());
				}
				//empMaster.setSubdivision(empMasterData.rs.getString("SUBDIVISION_OFFICE_CODE"));
				try {
					empMasterData.rs3 = empMasterData.stmt3
							.executeQuery("select * from RWS_SUBDIVISION_OFFICE_TBL WHERE SUBDIVISION_OFFICE_CODE ='"
									+ empMasterData.rs.getString("SUBDIVISION_OFFICE_CODE")
									+ "'");
					empMasterData.rs3.next();
					empMaster.setSubdivision(empMasterData.rs3
							.getString("SUBDIVISION_OFFICE_NAME"));
				} catch (Exception e) {
					//System.out.println("SUBDIVISION_OFFICE_NAME="
							+ e.getMessage());
				}
				empMaster.setStoreCode(empMasterData.rs.getString("STORE_CODE"));
				empMaster.setLocation(empMasterData.rs.getString("STORE_LOCATION"));
				empMaster.setStoreInCharge(empMasterData.rs.getString("STORE_INCHARGE"));
				//empMaster.setEmpcode(empMasterData.rs.getString("STORE_EMP_CODE"));
				try {
					ResultSet rs4 = stmt4
							.executeQuery("select EMPLOYEE_NAME from RWS_EMPLOYEE_TBL WHERE EMPLOYEE_CODE ='"
									+ empMasterData.rs.getString("STORE_EMP_CODE") + "'");
					rs4.next();
					empMaster.setEmpcode(rs4.getString("EMPLOYEE_NAME"));
				} catch (Exception e) {
					//System.out.println("EMPLOYEE_NAME=" + e.getMessage());
				}
				if (empMasterData.rs.getDate("POST_HELD_SINCE") != null) {
					empMaster.setPostheld(df.format(empMasterData.rs
							.getDate("POST_HELD_SINCE")));
				}

				stores.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return stores;
	}

	public static void removeStore(String storeCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt
					.executeUpdate("delete  from RWS_STORES_CURRENT_TBL where STORE_CODE="
							+ storeCode);
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
	}

	public static void updateStore(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		try {
			empMasterData.conn = dataSource.getConnection();

			ps = empMasterData.conn
					.prepareStatement("update RWS_STORES_CURRENT_TBL set DCODE=?,MCODE=?,SUBDIVISION_OFFICE_CODE=?,STORE_LOCATION=?,STORE_INCHARGE=?,STORE_EMP_CODE=?,POST_HELD_SINCE=TO_DATE('"
							+ empMaster.getPostheld()
							+ "','dd/mm/yyyy') where STORE_CODE=?");

			ps.setString(1, empMaster.getDistrict());
			ps.setString(2, empMaster.getMandal());
			ps.setString(3, empMaster.getSubdivision());
			ps.setString(4, empMaster.getLocation());
			ps.setString(5, empMaster.getStoreInCharge());
			ps.setString(6, empMaster.getEmpcode());
			//ps.setString(7,empMaster.getPostheld());
			ps.setString(7, empMaster.getStoreCode());

			ps.executeUpdate();
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
	}

	public static String getStoreCode(DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String code = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT MAX(to_number(STORE_CODE))+1 FROM RWS_STORES_CURRENT_TBL");
			empMasterData.rs.next();
			code = empMasterData.rs.getString(1);
			if (code == null) {
				code = "1";
			}
		} catch (Exception e) {
			//System.out.println("Ther error in STORE_CODE" + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	//******************************Supplier Methods*************************

	public static int insertSupplier(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			ps = empMasterData.conn
					.prepareStatement("insert into RWS_SUPPLIER_TBL values(?,?,?,?,?,?,?,?,?,?,?)");
			ps.setString(1, empMaster.getSupplierCode());
			ps.setString(2, empMaster.getSupplierName().toUpperCase());
			ps.setString(3, empMaster.getAddress().toUpperCase());
			ps.setString(4, empMaster.getArea().toUpperCase());
			ps.setString(5, empMaster.getLocation().toUpperCase());
			ps.setString(6, empMaster.getCity().toUpperCase());
			ps.setString(7, empMaster.getPin());
			ps.setString(8, empMaster.getPhone());
			ps.setString(9, empMaster.getFax());
			ps.setString(10, empMaster.getEmail());
			ps.setString(11, empMaster.getSupplierRegNo());

			rowCount = ps.executeUpdate();
		} catch (Exception e) {
			//System.out.println("The error is" + e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getSupplier(String supplierCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from RWS_SUPPLIER_TBL where SUPPLIER_CODE="
							+ supplierCode);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setSupplierCode(empMasterData.rs.getString("SUPPLIER_CODE"));
				empMaster.setSupplierName(empMasterData.rs.getString("SUPPLIER_NAME"));
				empMaster.setAddress(empMasterData.rs.getString("SUPPLIER_ADDRESS1"));
				empMaster.setArea(empMasterData.rs.getString("SUPPLIER_ADDRESS2"));
				empMaster.setLocation(empMasterData.rs.getString("SUPPLIER_ADDRESS3"));
				empMaster.setCity(empMasterData.rs.getString("SUPPLIER_CITY"));
				empMaster.setPin(empMasterData.rs.getString("SUPPLIER_PIN"));
				empMaster.setPhone(empMasterData.rs.getString("SUPPLIER_PHONE"));
				empMaster.setFax(empMasterData.rs.getString("SUPPLIER_FAX"));
				empMaster.setEmail(empMasterData.rs.getString("SUPPLIER_EMAIL"));
				empMaster.setSupplierRegNo(empMasterData.rs.getString("SUPPLIER_REG_NO"));
			}
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getSuppliers(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList suppliers = new ArrayList();

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt.executeQuery("select * from RWS_SUPPLIER_TBL");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setSupplierCode(empMasterData.rs.getString("SUPPLIER_CODE"));
				empMaster.setSupplierName(empMasterData.rs.getString("SUPPLIER_NAME"));
				empMaster.setAddress(empMasterData.rs.getString("SUPPLIER_ADDRESS1"));
				empMaster.setArea(empMasterData.rs.getString("SUPPLIER_ADDRESS2"));
				empMaster.setLocation(empMasterData.rs.getString("SUPPLIER_ADDRESS3"));
				empMaster.setCity(empMasterData.rs.getString("SUPPLIER_CITY"));
				empMaster.setPin(empMasterData.rs.getString("SUPPLIER_PIN"));
				empMaster.setPhone(empMasterData.rs.getString("SUPPLIER_PHONE"));
				empMaster.setFax(empMasterData.rs.getString("SUPPLIER_FAX"));
				empMaster.setEmail(empMasterData.rs.getString("SUPPLIER_EMAIL"));
				empMaster.setSupplierRegNo(empMasterData.rs.getString("SUPPLIER_REG_NO"));

				suppliers.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return suppliers;
	}

	public static void removeSupplier(String supplierCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt
					.executeUpdate("delete  from RWS_SUPPLIER_TBL where SUPPLIER_CODE="
							+ supplierCode);
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
	}

	public static void updateSupplier(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		try {
			empMasterData.conn = dataSource.getConnection();

			ps = empMasterData.conn
					.prepareStatement("update RWS_SUPPLIER_TBL set SUPPLIER_NAME=?,SUPPLIER_ADDRESS1=?,SUPPLIER_ADDRESS2=?,SUPPLIER_ADDRESS3=?,SUPPLIER_CITY=?,SUPPLIER_PIN=?,SUPPLIER_PHONE=?,SUPPLIER_FAX=?,SUPPLIER_EMAIL=?,SUPPLIER_REG_NO=? where SUPPLIER_CODE=?");

			ps.setString(1, empMaster.getSupplierName().toUpperCase());
			ps.setString(2, empMaster.getAddress().toUpperCase());
			ps.setString(3, empMaster.getArea().toUpperCase());
			ps.setString(4, empMaster.getLocation().toUpperCase());
			ps.setString(5, empMaster.getCity().toUpperCase());
			ps.setString(6, empMaster.getPin());
			ps.setString(7, empMaster.getPhone());
			ps.setString(8, empMaster.getFax());
			ps.setString(9, empMaster.getEmail());
			ps.setString(10, empMaster.getSupplierRegNo());
			ps.setString(11, empMaster.getSupplierCode());

			ps.executeUpdate();
			//System.out.println("hai in update Store");
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {

			empMasterData.closeAll();
		}
	}

	public static String getSupplierCode(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String code = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT MAX(to_number(SUPPLIER_CODE))+1 FROM RWS_SUPPLIER_TBL");
			empMasterData.rs.next();
			code = empMasterData.rs.getString(1);
			if (code == null) {
				code = "1";
			}
		} catch (Exception e) {
			//System.out.println("Ther error in SUPPLIER_CODE" + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	//*******************************Item Master
	// Methods********************************************//
	public static int insertItem(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			ps = empMasterData.conn
					.prepareStatement("insert into rws_item_tbl values(?,?,?,?,?,?)");
			ps.setString(1, empMaster.getItemCode());
			ps.setString(2, empMaster.getItemName().toUpperCase());
			ps.setString(3, empMaster.getDistCode());
			ps.setString(4, empMaster.getFinyear());
			ps.setString(5, empMaster.getUnits());
			ps.setString(6, empMaster.getRate());

			rowCount = ps.executeUpdate();

		} catch (Exception e) {
			//System.out.println("The error is" + e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getItem(String itemCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from rws_item_tbl where ITEM_CODE="
							+ itemCode);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setItemCode(empMasterData.rs.getString("ITEM_CODE"));
				empMaster.setItemName(empMasterData.rs.getString("ITEM_NAME"));
				empMaster.setDistCode(empMasterData.rs.getString("DCODE"));
				empMaster.setFinyear(empMasterData.rs.getString("FIN_YEAR"));
				empMaster.setUnits(empMasterData.rs.getString("UNITS"));
				empMaster.setRate(empMasterData.rs.getString("RATE"));
			}
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getItems(DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList items = new ArrayList();

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from RWS_ITEM_TBL order by ITEM_CODE");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setItemCode(empMasterData.rs.getString("ITEM_CODE"));
				empMaster.setItemName(empMasterData.rs.getString("ITEM_NAME"));
				empMaster.setDistCode(empMasterData.rs.getString("DCODE"));
				empMasterData.rs1 = empMasterData.stmt1
						.executeQuery("select * from RWS_DISTRICT_MASTER where dcode='"
								+ empMasterData.rs.getString("DCODE") + "'");
				empMasterData.rs1.next();
				empMaster.setDname(empMasterData.rs1.getString("DNAME"));
				empMaster.setFinyear(empMasterData.rs.getString("FIN_YEAR"));
				empMaster.setUnits(empMasterData.rs.getString("UNITS"));
				empMaster.setRate(empMasterData.rs.getString("RATE"));
				items.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return items;
	}

	public static void removeItem(String itemCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt.executeUpdate("delete  from RWS_ITEM_TBL where ITEM_CODE='"
					+ itemCode + "'");
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
	}

	public static void updateItem(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		try {
			empMasterData.conn = dataSource.getConnection();

			ps = empMasterData.conn
					.prepareStatement("update  RWS_ITEM_TBL set ITEM_NAME=?,DCODE=?,FIN_YEAR=?,UNITS=?,RATE=? where ITEM_CODE=?");

			ps.setString(1, empMaster.getItemName());
			ps.setString(2, empMaster.getDistCode());
			ps.setString(3, empMaster.getFinyear());
			ps.setString(4, empMaster.getUnits());
			ps.setString(5, empMaster.getRate());
			ps.setString(6, empMaster.getItemCode());

			ps.executeUpdate();
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
	}

	public static String getItemCode(DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String code = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT MAX(to_number(ITEM_CODE))+1 FROM RWS_ITEM_TBL");
			empMasterData.rs.next();
			code = empMasterData.rs.getString(1);
			if (code == null) {
				code = "1";
			}
		} catch (Exception e) {
			//System.out.println("Ther error in ITEM_CODE" + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	public static ArrayList getEmpCodesOnSubDiv(String coc, String sdoc,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList empcodes = new ArrayList();

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT * FROM RWS_EMPLOYEE_TBL WHERE  (SUBSTR(OFFICE_CODE, 2, 2) = '"
							+ coc
							+ "')  AND (SUBSTR(OFFICE_CODE, 5, 2) = '"
							+ sdoc + "') order by employee_code");

			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setEmpcode(empMasterData.rs.getString("employee_code"));
				empMaster.setEmpname(empMasterData.rs.getString("employee_name"));
				empMaster.setRoc(empMasterData.rs.getString("office_code"));
				String code = empMasterData.rs.getString("employee_code");
				String name = empMasterData.rs.getString("employee_name");
				empMaster.setDistNoName(code + " - " + name);
				empcodes.add(empMaster);
			}
		}
		catch (Exception e) {
			//System.out.println("The error in getEmpCodesOnSubDiv" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empcodes;
	}

	//*********************************Names on
	// Codes****************************************
	
	
	
	public static String getHeadOfficeName(String code, Connection conn)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT HEAD_OFFICE_NAME FROM RWS_HEAD_OFFICE_TBL WHERE HEAD_OFFICE_CODE='"
							+ code + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
		} catch (Exception e) {
			//System.out.println("Ther error in getHeadOfficeName=" + e);
		} finally {
			empMasterData.stmt1.close();
			
		}
		return name;
	}


public static String getDistrictName(String dcode, Connection conn)
			throws Exception {  
		EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		String query;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			query="SELECT DNAME FROM RWS_DISTRICT_TBL WHERE DCODE='"+dcode+"' ";
			empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
			while(empMasterData.rs1.next())
			{
			name = empMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			//System.out.println("Ther error in getDistrictName=" + e);
		} finally {
			empMasterData.stmt1.close();
			
		}
		return name;
	}


//same code with dataSource
public static String getDistrictName(String dcode, DataSource dataSource)
throws Exception {  
EmpMasterData empMasterData=new EmpMasterData();
empMasterData.conn=dataSource.getConnection();
String name = null;
empMasterData.stmt1 = null;
empMasterData.rs1 = null;
String query;
try {
empMasterData.stmt1 = empMasterData.conn.createStatement();
query="SELECT DNAME FROM RWS_DISTRICT_TBL WHERE DCODE='"+dcode+"' ";
empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
while(empMasterData.rs1.next())
{
name = empMasterData.rs1.getString(1);
}
} catch (Exception e) {
//System.out.println("Ther error in getDistrictName=" + e);
} finally {
empMasterData.closeAll();

}
return name;
}

	public static String getCircleOfficeName(String hoc, String coc,
			Connection conn) throws Exception {  
		EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT CIRCLE_OFFICE_NAME FROM RWS_CIRCLE_OFFICE_TBL WHERE HEAD_OFFICE_CODE='"
							+ hoc + "' and CIRCLE_OFFICE_CODE='" + coc + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
		} catch (Exception e) {
			//System.out.println("Ther error in getCircleOfficeName=" + e);
		} finally {
			empMasterData.stmt1.close();
			
		}
		return name;
	}

	public static String getDivisionOfficeName(String hoc, String coc,
			String doc, Connection conn) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		//System.out.println("hoc=" + hoc + "  coc=" + coc + "   doc=" + doc);
		try {
			if (doc != null || !(doc.equals("0"))) {
				empMasterData.stmt1 = empMasterData.conn.createStatement();
				empMasterData.rs1 = empMasterData.stmt1
						.executeQuery("SELECT DIVISION_OFFICE_NAME FROM RWS_DIVISION_OFFICE_TBL WHERE HEAD_OFFICE_CODE='"
								+ hoc
								+ "' and CIRCLE_OFFICE_CODE='"
								+ coc
								+ "' and DIVISION_OFFICE_CODE='" + doc + "'");
				empMasterData.rs1.next();
				name = empMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			//System.out.println("Ther error in getDivisionOfficeName=" + e);
		} finally {
			empMasterData.stmt1.close();
			}
		return name;
	}

	public static String getSubDivisionOfficeName(String hoc, String coc,
			String doc, String sdoc, Connection conn) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		//System.out.println("hoc=" + hoc + "  coc=" + coc + "   doc=" + doc
				+ "  sdoc=" + sdoc);
		try {
			if (doc != null || !(doc.equals("0"))) {
				empMasterData.stmt1 = empMasterData.conn.createStatement();
				empMasterData.rs1 = empMasterData.stmt1
						.executeQuery("SELECT SUBDIVISION_OFFICE_NAME FROM RWS_SUBDIVISION_OFFICE_TBL WHERE HEAD_OFFICE_CODE='"
								+ hoc
								+ "' and CIRCLE_OFFICE_CODE='"
								+ coc
								+ "' and DIVISION_OFFICE_CODE='"
								+ doc
								+ "' and SUBDIVISION_OFFICE_CODE='"
								+ sdoc
								+ "'");
				empMasterData.rs1.next();
				name = empMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			//System.out.println("Ther error in getSubDivisionOfficeName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getSectionOfficeName(String hoc, String coc,
			String doc, String sdoc, String soc, Connection conn)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT SECTION_OFFICE_NAME FROM RWS_SECTION_OFFICE_TBL WHERE HEAD_OFFICE_CODE='"
							+ hoc
							+ "' and CIRCLE_OFFICE_CODE='"
							+ coc
							+ "' and DIVISION_OFFICE_CODE='"
							+ doc
							+ "' and SUBDIVISION_OFFICE_CODE='"
							+ sdoc
							+ "' and SECTION_OFFICE_CODE='" + soc + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
		} catch (Exception e) {
			//System.out.println("Ther error in getSectionOfficeName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getMajorHeadName(String majorCode, Connection conn)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT MAJOR_HEAD_NAME FROM RWS_MAJORHEAD_TBL WHERE MAJOR_HEAD_CODE ='"
							+ majorCode + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
		} catch (Exception e) {
			//System.out.println("Ther error in getMajorHeadName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getSubMajorHeadName(String majorCode,
			String subMajorCode, Connection conn) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT SUBMAJOR_HEAD_NAME FROM RWS_SUBMAJORHEAD_TBL WHERE MAJOR_HEAD_CODE ='"
							+ majorCode
							+ "' and SUBMAJOR_HEAD_CODE='"
							+ subMajorCode + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
		} catch (Exception e) {
			//System.out.println("Ther error in getSubMajorHeadName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getMinorHeadName(String majorCode,
			String subMajorCode, String minorCode, Connection conn)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT MINOR_HEAD_NAME FROM RWS_MINORHEAD_TBL WHERE MAJOR_HEAD_CODE ='"
							+ majorCode
							+ "' and SUBMAJOR_HEAD_CODE='"
							+ subMajorCode
							+ "' and MINOR_HEAD_CODE='"
							+ minorCode + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
		} catch (Exception e) {
			//System.out.println("Ther error in getMinorHeadName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getGrpSubHeadName(String majorCode,
			String subMajorCode, String minorCode, String grpSubCode,
			Connection conn) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT GRPR_SUBHEAD_NAME FROM RWS_GROUPSUBHEAD_TBL WHERE MAJOR_HEAD_CODE ='"
							+ majorCode
							+ "' and SUBMAJOR_HEAD_CODE='"
							+ subMajorCode
							+ "' and MINOR_HEAD_CODE='"
							+ minorCode
							+ "' and GRP_SUBHEAD_CODE='"
							+ grpSubCode + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
		} catch (Exception e) {
			//System.out.println("The error in getSubDivisionOfficeName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getSubHeadName(String majorCode, String subMajorCode,
			String minorCode, String grpSubCode, String subCode, Connection conn)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT SUBHEAD_NAME FROM RWS_SUBHEAD_TBL WHERE MAJOR_HEAD_CODE ='"
							+ majorCode
							+ "' and SUBMAJOR_HEAD_CODE='"
							+ subMajorCode
							+ "' and MINOR_HEAD_CODE='"
							+ minorCode
							+ "' and GRP_SUBHEAD_CODE='"
							+ grpSubCode
							+ "' and SUBHEAD_CODE='"
							+ subCode
							+ "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
		} catch (Exception e) {
			//System.out.println("Ther error in getSubHeadName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getDetailHeadName(String majorCode,
			String subMajorCode, String minorCode, String grpSubCode,
			String subCode, String detailCode, Connection conn)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT DETAIL_HEAD_NAME  FROM RWS_DETAILHEAD_TBL WHERE MAJOR_HEAD_CODE ='"
							+ majorCode
							+ "' and SUBMAJOR_HEAD_CODE='"
							+ subMajorCode
							+ "' and MINOR_HEAD_CODE='"
							+ minorCode
							+ "' and GRP_SUBHEAD_CODE='"
							+ grpSubCode
							+ "' and SUBHEAD_CODE='"
							+ subCode
							+ "' and DETAIL_HEAD_CODE='" + detailCode + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
		} catch (Exception e) {
			//System.out.println("Ther error in getDetailHeadName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getSubDetailHeadName(String majorCode,
			String subMajorCode, String minorCode, String grpSubCode,
			String subCode, String detailCode, String subDetailCode,
			Connection conn) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT SUBDETAIL_HEAD_NAME FROM RWS_SUBDETAIL_TBL WHERE MAJOR_HEAD_CODE ='"
							+ majorCode
							+ "' and SUBMAJOR_HEAD_CODE='"
							+ subMajorCode
							+ "' and MINOR_HEAD_CODE='"
							+ minorCode
							+ "' and GRP_SUBHEAD_CODE='"
							+ grpSubCode
							+ "' and SUBHEAD_CODE='"
							+ subCode
							+ "' and DETAIL_HEAD_CODE='"
							+ detailCode
							+ "'and SUBDETAIL_HEAD_CODE='"
							+ subDetailCode
							+ "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
		} catch (Exception e) {
			//System.out.println("Ther error in getSectionOfficeName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getHabName(String habCode, Connection conn)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT PANCH_NAME FROM rws_panchayat_raj_tbl WHERE panch_code ='"
							+ habCode + "'");
			while (empMasterData.rs1.next()) {
				name = empMasterData.rs1.getString(1);

			}
		} catch (Exception e) {
			//System.out.println("The error in getHabName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getQualName(String code, Connection conn) throws Exception
	{
		EmpMasterData empMasterData=new EmpMasterData();
		empMasterData.conn=conn;
		String name = null;
		String query;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			if(code!= null)
			{
				query="SELECT QUAL_NAME FROM rws_qualification_tbl WHERE QUAL_CODE ='"+code+"' ";
				empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
				//System.out.println("qualification"+query);
				while(empMasterData.rs1.next())
				{
				name = empMasterData.rs1.getString(1);
				}
			}
		} catch (Exception e) {
			//System.out.println("Ther error in getQualName=" + e);
		} finally {
			empMasterData.stmt1.close();
			//System.out.println("connection count"+connCount);
		}
		return name;
	}

//same with dataSource
	public static String getQualName(String code,DataSource dataSource) throws Exception
	{
		EmpMasterData empMasterData=new EmpMasterData();
		empMasterData.conn=dataSource.getConnection();
		String name = null;
		String query;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			if(code!= null)
			{
				query="SELECT QUAL_NAME FROM rws_qualification_tbl WHERE QUAL_CODE ='"+code+"' ";
				empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
				//System.out.println("qualification"+query);
				while(empMasterData.rs1.next())
				{
				name = empMasterData.rs1.getString(1);
				}
			}
		} catch (Exception e) {
			//System.out.println("Ther error in getQualName=" + e);
		} finally {
			empMasterData.closeAll();
			//System.out.println("connection count"+connCount);
		}
		return name;
	}

	//code added 
	
	public static String getCasteName(String code, Connection conn) throws Exception {
			
		EmpMasterData empMasterData=new EmpMasterData();
		empMasterData.conn=conn;
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			if(code!=null) {
				String query="SELECT CASTE_NAME	FROM RWS_CAST_MST_TBL where CASTE_CODE ='"+code+"' ";
				empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
				//System.out.println("Caste Table"+query);
				while(empMasterData.rs1.next())
				{
					name = empMasterData.rs1.getString(1);
				}
			}
		} catch (Exception e) {
			//System.out.println("Ther error in getCasteName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}
	
	//end of code added
	
	public static String getDesgnName(String code, Connection conn)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			String query="SELECT DESIGNATION_ACR,DESIGNATION_NAME FROM rws_designation_tbl WHERE designation_CODE ='"+ code + "' ";
			if (code != null) {
				empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
				//System.out.println("desigantions query"+query);
				while(empMasterData.rs1.next())
				{
				name = empMasterData.rs1.getString(1);
				}
			    } else{
			    		name = "";
				       }
		} catch (Exception e) {
			//System.out.println("Ther error in getDesgnName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}
	//same code with dataSource
public static String getDesgnName(String code,DataSource dataSource)
	throws Exception { 
	EmpMasterData empMasterData=new EmpMasterData();
	empMasterData.conn=dataSource.getConnection();
	String name = null;
empMasterData.stmt1 = null;
empMasterData.rs1 = null;
try {
	empMasterData.stmt1 = empMasterData.conn.createStatement();
	String query="SELECT DESIGNATION_NAME,DESIGNATION_ACR FROM rws_designation_tbl WHERE designation_CODE ='"+ code + "' ";
	if (code != null) {
		empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
		//System.out.println("desigantions query"+query);
		while(empMasterData.rs1.next())
		{
		name = empMasterData.rs1.getString(1);
		}
	    } else{
	    		name = "";
		       }
} catch (Exception e) {
	//System.out.println("Ther error in getDesgnName=" + e);
} finally {
	empMasterData.closeAll();
}
return name;
}

	public static String getAssetTypeName(String code, Connection conn)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();

			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT TYPE_OF_ASSET_NAME  FROM RWS_ASSET_TYPE_TBL WHERE TYPE_OF_ASSET_CODE  ='"
							+ code + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);

		} catch (Exception e) {
			//System.out.println("Ther error in getAssetTypeName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getAssetTypeName(String code, DataSource dataSource)
			throws Exception {   
		//System.out.println("in getAssetTypeName in EmpMasterData");
		EmpMasterData empMasterData=new EmpMasterData();
		//System.out.println("1");
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			//System.out.println("2");
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt1 = empMasterData.conn.createStatement();

			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT TYPE_OF_ASSET_NAME  FROM RWS_ASSET_TYPE_TBL WHERE TYPE_OF_ASSET_CODE  ='"
							+ code + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);

		} catch (Exception e) {
			//System.out.println("Ther error in getAssetTypeName=" + e);
		} finally {
			empMasterData.closeAll();
			
		}
		return name;
	}

	public static String getAssetCompTypeName(String code, String code1,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		if(code1.equals("05")||code1.equals("06")||code1.equals("07")||code1.equals("08"))
			return "SOURCE";
		
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT ASSET_COMPONENT_NAME  FROM RWS_ASSET_COMPONENT_TYPE_TBL WHERE ASSET_COMPONENT_CODE  ='"
							+ code + "' and type_of_asset_code=" + code1);
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
			//System.out.println("name in getAssetCompTypeName= " + name);

		} catch (Exception e) {
			//System.out.println("Ther error in getAssetCompTypeName=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return name;
	}

	public static String getAssetSubComponentName(String code, String code1,
			String code2, Connection conn) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			if(code1.equals("05"))
			return "SHALLOW HAND PUMPS";
		if(code1.equals("06"))
			return "OPEN WELLS";
		if(code1.equals("07"))
			return "PONDS";
		if(code1.equals("08"))
			return "OTHERS";
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			//System.out.println("ASSET_COMPONENT_CODE=" + code
					+ "   type_of_asset_code=" + code1
					+ "  asset_subcomponent_code=" + code2);
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT ASSET_SUBCOMPONENT_NAME  FROM RWS_ASSET_SUBCOMPONENT_TBL WHERE ASSET_COMPONENT_CODE  ='"
							+ code
							+ "' and type_of_asset_code='"
							+ code1
							+ "' and asset_subcomponent_code='" + code2 + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
		} catch (Exception e) {
			//System.out.println("Ther error in getAssetCompTypeName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getSourceName(String code, Connection conn)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			//System.out.println("code=" + code);
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			if (code != null && !code.equals("null")) {
				empMasterData.rs1 = empMasterData.stmt1
						.executeQuery("SELECT SOURCE_NAME FROM RWS_SOURCE_TBL WHERE SOURCE_CODE="
								+ code);
				empMasterData.rs1.next();
				name = empMasterData.rs1.getString(1);
			}

		} catch (Exception e) {
			//System.out.println("Ther error in getSourceName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getPrgmName(String code, Connection conn)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			//System.out.println("getPrgmName=" + code);
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			if (code != null && !code.equals("null")) {
				empMasterData.rs1 = empMasterData.stmt1
						.executeQuery("SELECT PROGRAMME_NAME  FROM RWS_PROGRAMME_TBL WHERE PROGRAMME_CODE  ='"
								+ code + "'");
				empMasterData.rs1.next();
				name = empMasterData.rs1.getString(1);
			} else
				name = "";
		} catch (Exception e) {
			//System.out.println("Ther error in getPrgmName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getSubprgmName(String code, String code1,
			Connection conn) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			if (code != null && !code.equals("null")) {
				empMasterData.rs1 = empMasterData.stmt1
						.executeQuery("SELECT SUBPROGRAMME_NAME  FROM rws_SUBPROGRAMME_tbl WHERE PROGRAMME_CODE  ='"
								+ code + "' and SUBPROGRAMME_CODE=" + code1);
				empMasterData.rs1.next();
				name = empMasterData.rs1.getString(1);
			} else
				name = "";
		} catch (Exception e) {
			//System.out.println("Ther error in getSubprgm=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getSourceTypeName(String code, Connection conn)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = "";
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			String query="SELECT SOURCE_TYPE_NAME  FROM rws_source_type_tbl WHERE SOURCE_TYPE_CODE  ='"
				+ code + "'";
			//System.out.println("query in getSourceTypeName is "+query);
			empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
			while(empMasterData.rs1.next())
			name = empMasterData.rs1.getString(1);

		} catch (Exception e) {
			//System.out.println("Ther error in getSourceTypeName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getSubSourceName(String code, String code1,
			Connection conn) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = "";
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			String query="SELECT SUBSOURCE_TYPE_NAME  FROM rws_subsource_type_tbl WHERE SUBSOURCE_TYPE_CODE  ='"
				+ code + "' and SOURCE_TYPE_CODE=" + code1;
			//System.out.println("query in getSubSourceName is "+query);
			empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
			
			if(empMasterData.rs1.next())
			name = empMasterData.rs1.getString(1);
			//System.out.println("executedAll");
		} catch (Exception e) {
			//System.out.println("Ther error in getSubSourceName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getMandalName(String dcode, String mcode,
			Connection conn) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("select MNAME from RWS_MANDAL_TBL where DCODE='"
							+ dcode + "' and mcode='" + mcode + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
		} catch (Exception e) {
			//System.out.println("Ther error in getMandalName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getPanchayatName(String dcode, String mcode,
			String pcode, Connection conn) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("select PNAME from RWS_PANCHAYAT_TBL where DCODE='"
							+ dcode
							+ "' and mcode='"
							+ mcode
							+ "' and PCODE='"
							+ pcode + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
		} catch (Exception e) {
			//System.out.println("Ther error in getPanchayatName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getVillageName(String dcode, String mcode,
			String pcode, String vcode, Connection conn) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("select VNAME from RWS_VILLAGE_TBL where DCODE='"
							+ dcode
							+ "' and mcode='"
							+ mcode
							+ "' and PCODE='"
							+ pcode + "' and vcode='" + vcode + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
		} catch (Exception e) {
			//System.out.println("Ther error in getPanchayatName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getAssetSubCompCode(String assetTypeCode,
			String assetCompCode, String assetSubName, Connection conn)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String code = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		//System.out.println("assetTypeCode=" + assetTypeCode + "  assetSubName="
				+ assetSubName + "   assetCompCode= " + assetCompCode);
		try {

			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT ASSET_SUBCOMPONENT_CODE FROM RWS_ASSET_SUBCOMPONENT_TBL WHERE ASSET_SUBCOMPONENT_NAME=UPPER('"
							+ assetSubName
							+ "') AND TYPE_OF_ASSET_CODE='"
							+ assetTypeCode
							+ "' AND ASSET_COMPONENT_CODE='"
							+ assetCompCode + "'");
			empMasterData.rs1.next();
			code = empMasterData.rs1.getString(1);
			//System.out.println("getAssetSubCompTypeName=" + code);
		} catch (Exception e) {
			//System.out.println("The error in getAssetSubCompCode=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return code;
	}

	public static String getAssetSubCompTypeName(String assetSubComp,
			String assetComp, String assetType, Connection conn)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {

			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT ASSET_SUBCOMPONENT_NAME FROM RWS_ASSET_SUBCOMPONENT_TBL where type_of_asset_code='"
							+ assetType
							+ "' and asset_component_code='"
							+ assetComp
							+ "' and asset_subcomponent_code='"
							+ assetSubComp + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
		} catch (Exception e) {
			//System.out.println("The error in getAssetSubCompTypeName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	//****************************Lab
	// Methods*******************************************
	public static int insertWQLab(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			ps = empMasterData.conn
					.prepareStatement("insert into RWS_WATER_QUALITY_LAB_TBL values(?,?,?,?,?)");
			ps.setString(1, empMaster.getLabCode());
			ps.setString(2, empMaster.getLabName().toUpperCase());
			ps.setString(3, empMaster.getLocation().toUpperCase());
			ps.setString(4, empMaster.getHoc() + empMaster.getCoc()
					+ empMaster.getDoc() + empMaster.getSdoc());
			ps.setString(5, empMaster.getDesgnCode());

			rowCount = ps.executeUpdate();
		} catch (Exception e) {
			//System.out.println("The error is" + e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getWQLab(String labCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select * from RWS_WATER_QUALITY_LAB_TBL where LAB_CODE="
							+ labCode);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setLabCode(empMasterData.rs.getString(1));
				empMaster.setLabName(empMasterData.rs.getString(2));
				empMaster.setLocation(empMasterData.rs.getString(3));
				empMaster.setDesgnCode(empMasterData.rs.getString(5));

				empMaster.setHoc(empMasterData.rs.getString(4).substring(0, 1));
				//System.out.println("hoc= " + empMaster.getHoc());
				empMaster.setCoc(empMasterData.rs.getString(4).substring(1, 3));
				//System.out.println(empMaster.getCoc());
				empMaster.setDoc(empMasterData.rs.getString(4).substring(3, 4));
				//System.out.println(empMaster.getDoc());
				empMaster.setSdoc(empMasterData.rs.getString(4).substring(4, 6));
				//System.out.println(empMaster.getSdoc());
			}
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getWQLabs(DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList wqlabs = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select lab_code,lab_name,location,office_code,"
							+ "DESIGNATION_ACR from RWS_WATER_QUALITY_LAB_TBL wq,"
							+ "rws_designation_tbl d where "
							+ "wq.office_head_desgn=d.designation_code "
							+ "order by lab_code,location");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setLabCode(empMasterData.rs.getString(1));
				empMaster.setLabName(empMasterData.rs.getString(2));
				empMaster.setLocation(empMasterData.rs.getString(3));
				empMaster.setRoc(empMasterData.rs.getString(4));
				empMaster.setDesgnCode(empMasterData.rs.getString(5));
				//empMaster.setLabName(empMasterData.rs.getString(3)+" - "+empMasterData.rs.getString(2));
				wqlabs.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return wqlabs;
	}

	public static int removeWQLab(String labCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rowCount = empMasterData.stmt
					.executeUpdate("delete FROM RWS_WATER_QUALITY_LAB_TBL where LAB_CODE='"
							+ labCode + "'");

		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static void updateWQLab(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		try {
			empMasterData.conn = dataSource.getConnection();

			ps = empMasterData.conn
					.prepareStatement("update  RWS_WATER_QUALITY_LAB_TBL set LAB_NAME=?,LOCATION=?,OFFICE_CODE=?,OFFICE_HEAD_DESGN=? where LAB_CODE=?");

			ps.setString(1, empMaster.getLabName().toUpperCase());
			ps.setString(2, empMaster.getLocation().toUpperCase());
			ps.setString(3, empMaster.getHoc() + empMaster.getCoc()
					+ empMaster.getDoc() + empMaster.getSdoc());
			ps.setString(5, empMaster.getLabCode());
			ps.setString(4, empMaster.getDesgnCode());
			ps.executeUpdate();
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
	}

	public static String getLabCode(DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String code = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT MAX(LAB_CODE)+1 FROM RWS_WATER_QUALITY_LAB_TBL");
			empMasterData.rs.next();
			code = empMasterData.rs.getString(1);
			if (code == null) {
				code = "01";
			} else if (code.length() == 1) {
				code = "0" + code;
			}
		} catch (Exception e) {
			//System.out.println("Ther error in getTestCode" + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	public static String getWaterTestName(String code, Connection conn)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT test_name FROM RWS_WATER_QUALITY_TEST_TBL WHERE test_code ='"
							+ code + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
		} catch (Exception e) {
			//System.out.println("Ther error in getWaterTestName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getEmpName(String code, Connection conn)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			//System.out.println("getEmpName=" + code);
			empMasterData.stmt1 = empMasterData.conn.createStatement();

			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT EMPLOYEE_NAME  FROM rws_EMPLOYEE_tbl WHERE EMPLOYEE_CODE  ='"
							+ code + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);

		} catch (Exception e) {
			//System.out.println("Ther error in getEmpName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getTestName(String code, Connection conn)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			//System.out.println("getTestName=" + code);
			empMasterData.stmt1 = empMasterData.conn.createStatement();
String query="SELECT TEST_NAME FROM RWS_WATER_QUALITY_TEST_TBL WHERE TEST_CODE='"+ code +"' ";
			empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
			//System.out.println("get test name"+query);
			while(empMasterData.rs1.next()){
			name = empMasterData.rs1.getString(1);
			}

		} catch (Exception e) {
			//System.out.println("Ther error in getTestName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getLabName(String code, Connection conn)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name ="";
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		String query=null;
		try {
			//System.out.println(" inside the getLabName() "+ code);
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			query="SELECT LAB_NAME  FROM RWS_WATER_QUALITY_LAB_TBL WHERE LAB_CODE  ='"+ code + "' ";
			empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
			//System.out.println("GetLabName Query"+query);
			while(empMasterData.rs1.next())
			{
			name = empMasterData.rs1.getString(1);
			}

		} catch (Exception e) {
			//System.out.println("Ther error in getLabName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static ArrayList getAssetSubCompNames(String assetTypeCode,
			String assetCompCode, DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		ArrayList assetSubCompNames = new ArrayList();
		EmpMaster empMaster;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT ASSET_SUBCOMPONENT_NAME  FROM RWS_ASSET_SUBCOMPONENT_TBL WHERE ASSET_COMPONENT_CODE  ='"
							+ assetCompCode
							+ "' and type_of_asset_code='"
							+ assetTypeCode + "'");
			while (empMasterData.rs1.next()) {
				empMaster = new EmpMaster();
				empMaster.setAssetSubCompTypeName(empMasterData.rs1.getString(1));
				assetSubCompNames.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("Ther error in getAssetCompTypeName=" + e);
		} finally {
			empMasterData.closeAll();

		}
		return assetSubCompNames;
	}

	public static String getTestId(String test, String labCode, String yr,
			Connection conn) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			//System.out.println("  year=" + yr);
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			if (test.equals("sample")) {
				empMasterData.rs1 = empMasterData.stmt1
						.executeQuery("select max(substr(test_id,3,4)),max(to_number(substr(test_id,7,10))) from rws_water_sample_collect_tbl where substr(test_id,1,2)='"
								+ labCode + "'");
			} else if (test.equals("test")) {
				empMasterData.rs1 = empMasterData.stmt1
						.executeQuery("select max(substr(test_id,3,4)),max(to_number(substr(test_id,7,10))) from RWS_WQ_TEST_RESULTS_TBL where substr(test_id,1,2)='"
								+ labCode + "'");
			}
			empMasterData.rs1.next();
			if (empMasterData.rs1.getString(1) != null) {
				if (empMasterData.rs1.getString(1).equals(yr)) {
					if (empMasterData.rs1.getString(2).length() == 1) {
						name = "000" + (empMasterData.rs1.getInt(2) + 1);
					} else if (empMasterData.rs1.getString(2).length() == 2) {
						name = "00" + (empMasterData.rs1.getInt(2) + 1);
					} else if (empMasterData.rs1.getString(2).length() == 3) {
						name = "0" + (empMasterData.rs1.getInt(2) + 1);
					} else if (empMasterData.rs1.getString(2).length() == 4) {
						name = String.valueOf(empMasterData.rs1.getInt(2) + 1);
					}
				} else {
					name = "0001";
				}
			} else {
				name = "0001";
			}
		} catch (Exception e) {
			//System.out.println("Ther error in getLabName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return (labCode + yr + name);
	}

	public static ArrayList getTestParameterCodes(DataSource dataSource,
			String testCode) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList parameters = new ArrayList();
		//System.out.println("The testCode is-----------------" + testCode);
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT * FROM RWS_WQ_PARA_TEST_TBL WHERE TEST_CODE in (select test_code from RWS_WATER_QUALITY_TEST_TBL where test_name='"
							+ testCode + "')");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setTestCode(empMasterData.rs.getString(1));
				empMaster.setTestPCode(empMasterData.rs.getString(2));
				empMaster.setTestPName(empMasterData.rs.getString(3));
				empMaster.setTestName(getWaterTestName(empMasterData.rs.getString(1), empMasterData.conn));
				empMaster.setMinPerVal(empMasterData.rs.getString(4));
				empMaster.setMaxPerVal(empMasterData.rs.getString(5));

				parameters.add(empMaster);

			}

		} catch (Exception e) {
			//System.out.println("Imam:  " + e);
		} finally {
			empMasterData.closeAll();
		}
		return parameters;
	}

	public static ArrayList getHabitations(String dcode, String mcode,
			String pcode, String vcode, DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		ArrayList habs = new ArrayList();
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT HAB_CODE,HNAME FROM RWS_HABMAST_TBL WHERE"
							+ " SUBSTR(HAB_CODE,1,2)='"
							+ dcode
							+ "' AND SUBSTR(HAB_CODE,6,2)='"
							+ mcode
							+ "' AND "
							+ "SUBSTR(HAB_CODE,13,2)='"
							+ pcode
							+ "' AND SUBSTR(HAB_CODE,8,3)='" + vcode + "'");

			while (empMasterData.rs.next()) {
				//rwsLocation.setHabCode(empMasterData.rs.getString("HAB_CODE"));
				empMaster = new EmpMaster();
				empMaster.setHabCode(empMasterData.rs.getString(1));
				empMaster.setHabName(empMasterData.rs.getString(2));
				empMaster.setHabitationCode(empMasterData.rs.getString(1) + " - "
						+ empMasterData.rs.getString(2));
				habs.add(empMaster);
			}
		} catch (Exception e) {
			Debug
					.println("The error in EmpMasterData getHabitations=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return habs;
	}

	public static ArrayList getPRHabitations(String habCode,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		ArrayList habs = new ArrayList();
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			//System.out.println("habcode in getprhabs= " + habCode);
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT PANCH_CODE,PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL WHERE"
							+ " HAB_CODE='" + habCode + "' order by panch_code");

			while (empMasterData.rs.next()) {

				empMaster = new EmpMaster();
				empMaster.setHabitation(empMasterData.rs.getString(1));
				empMaster.setHabCode(empMasterData.rs.getString(1));
				empMaster.setHabName(empMasterData.rs.getString(2));
				habs.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in EmpMasterData getPRHabitations="
					+ e);
		} finally {
			empMasterData.closeAll();
		}
		return habs;
	}

	public static String getMaxPrHab(DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String code = null;
		try {
			empMasterData.conn = dataSource.getConnection();

			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT MAX(to_number(PANCH_CODE))+1 FROM RWS_PANCHAYAT_RAJ_TBL");
			empMasterData.rs.next();
			code = empMasterData.rs.getString(1);
		} catch (Exception e) {
			//System.out.println("The error in getMaxPrHab" + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	public static int getAssetSubCompCount(Connection conn, String tabName,
			String typeOfAssetName, String typeOfAssetCode, String habCode,
			String pumpCode) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			int count = 0;
		String query = "";
		try {
			//System.out.println("getassetsubcomp counnt    qeury   ");
			query = "select count(*) COUNT from rws_asset_mast_tbl a,rws_asset_scheme_tbl s,"
					+ tabName
					+ " h ,rws_asset_type_tbl t where a.asset_code=s.asset_code and a.asset_code=h.asset_code and "
					+ " substr(s.scheme_code,17,3)='"
					+ pumpCode
					+ "' and a.hab_code='"
					+ habCode
					+ "' and a.type_of_asset_code=t.type_of_asset_code and t.type_of_asset_name='"
					+ typeOfAssetName
					+ "' and a.type_of_asset_code='"
					+ typeOfAssetCode + "'";
			
			//System.out.println("getassetsubcomp counnt    qeury   " + query);
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
			if (empMasterData.rs1.next())
			{
				count = empMasterData.rs1.getInt("COUNT");
			}
		} catch (Exception e) {
			//System.out.println("Error=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return count;
	}
	
	public static int getAssetSubCompCountForSource(Connection conn, String tabName,
			String typeOfAssetName, String typeOfAssetCode,String typeOfSubCompName,
			String habCode,	String pumpCode) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			int count = 0;
		String query = "";
		try {
			//System.out.println("getassetsubcomp counnt    qeury   ");
			if(typeOfSubCompName.equals("SUBSURFACE SOURCE"))
			query = "select count(*) COUNT from rws_asset_mast_tbl a,rws_asset_scheme_tbl s,"
					+ tabName
					+ " h ,rws_asset_type_tbl t where a.asset_code=s.asset_code and a.asset_code=h.asset_code and "
					+ " substr(s.scheme_code,17,3)='"
					+ pumpCode
					+ "' and a.hab_code='"
					+ habCode
					+ "' and a.type_of_asset_code=t.type_of_asset_code and t.type_of_asset_name='"
					+ typeOfAssetName
					+ "' and a.type_of_asset_code='"
					+ typeOfAssetCode + "'"
					+ " and SOURCE_TYPE_CODE=1"; 
					//and SUBSOURCE_TYPE_CODE=1" ;
			
			else if(typeOfSubCompName.equals("SURFACE SOURCE"))
				query = "select count(*) COUNT from rws_asset_mast_tbl a,rws_asset_scheme_tbl s,"
						+ tabName
						+ " h ,rws_asset_type_tbl t where a.asset_code=s.asset_code and a.asset_code=h.asset_code and "
						+ " substr(s.scheme_code,17,3)='"
						+ pumpCode
						+ "' and a.hab_code='"
						+ habCode
						+ "' and a.type_of_asset_code=t.type_of_asset_code and t.type_of_asset_name='"
						+ typeOfAssetName
						+ "' and a.type_of_asset_code='"
						+ typeOfAssetCode + "'"
						+ " and SOURCE_TYPE_CODE=2";
						//and SUBSOURCE_TYPE_CODE=3" ;
			
			//System.out.println("getassetsubcomp counnt    qeury   " + query);
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
			if (empMasterData.rs1.next())
			{
				count = empMasterData.rs1.getInt("COUNT");
			}
		} catch (Exception e) {
			//System.out.println("Error=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return count;
	}
	
	public static int getAssetSubCompCountWTP(Connection conn, String tabName,
			String typeOfAssetName, String typeOfAssetCode, String habCode,
			String pumpCode,String wtp) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
			empMasterData.conn=conn;
			int count = 0;
		String query = "";
		try {
			//System.out.println("getassetsubcomp counnt    qeury   ");
			if(wtp.trim().equals("RS FILTER")||wtp.trim().equals("RS FILTERS"))
			{
			query = "select count(*) COUNT from rws_asset_mast_tbl a,rws_asset_scheme_tbl s,"
					+ tabName
					+ " h ,rws_asset_type_tbl t where a.asset_code=s.asset_code and a.asset_code=h.asset_code and "
					+ " substr(s.scheme_code,17,3)='"
					+ pumpCode
					+ "' and a.hab_code='"
					+ habCode
					+ "' and a.type_of_asset_code=t.type_of_asset_code and t.type_of_asset_name='"
					+ typeOfAssetName
					+ "' and a.type_of_asset_code='"
					+ typeOfAssetCode + "' AND WTP_TYPW ='RSF'";
			}
			else if(wtp.trim().equals("SS FILTER"))
			{
				query = "select count(*)COUNT from rws_asset_mast_tbl a,rws_asset_scheme_tbl s,"
					+ tabName
					+ " h ,rws_asset_type_tbl t where a.asset_code=s.asset_code and a.asset_code=h.asset_code and "
					+ " substr(s.scheme_code,17,3)='"
					+ pumpCode
					+ "' and a.hab_code='"
					+ habCode
					+ "' and a.type_of_asset_code=t.type_of_asset_code and t.type_of_asset_name='"
					+ typeOfAssetName
					+ "' and a.type_of_asset_code='"
					+ typeOfAssetCode + "' AND WTP_TYPW ='SSF'";
			}
			
			//System.out.println("getassetsubcomp counnt    qeury   " + query);
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
			if (empMasterData.rs1.next())
				count = empMasterData.rs1.getInt("COUNT");
		} catch (Exception e) {
			//System.out.println("Error=" + e.getMessage());
		} finally {
			empMasterData.stmt1.close();
		}
		return count;
	}

	//this function gets the subcomponents in the grid in asset form
	public static ArrayList getAssetSubComps(DataSource dataSource,
			String assetTypeCode, String assetTypeName,
			String assetComponentCode, String assetCompName, String habCode,
			String pumpCode, String opType) throws Exception 
	{
		EmpMasterData empMasterData=new EmpMasterData();
		ArrayList assetSubComponents = new ArrayList();
		String assetSubCompName = "";
		empMasterData.conn = dataSource.getConnection();
		empMasterData.stmt = empMasterData.conn.createStatement();
		try {
			LabelValueBean labelValueBean=null;
			//System.out.println("assetTypeCode is "+assetTypeCode);
			//System.out.println("checking assetTypeCode");
			if(!assetTypeCode.equals("05")&&!assetTypeCode.equals("06")&&!assetTypeCode.equals("07")&&!assetTypeCode.equals("08"))
			{
				//System.out.println("in first if");
				String query = " SELECT asset_subcomponent_code, trim(asset_subcomponent_name) "
							+ " FROM rws_asset_subcomponent_tbl WHERE type_of_asset_code='"
							+ assetTypeCode
							+ "' "
							+ " AND asset_component_code = '"
							+ assetComponentCode
							+ "' "
							+ " ORDER BY asset_subcomponent_code";
				
				empMasterData.rs =empMasterData.stmt.executeQuery(query);

				while (empMasterData.rs.next()) 
				{
					//System.out.println("in first while");
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue(empMasterData.rs.getString(1));
					assetSubCompName = empMasterData.rs.getString(2);
					labelValueBean.setLabel(assetSubCompName);
					//System.out.println("assetTypeName  is   '"+assetTypeName+"'");
					//System.out.println("assetCompName is   '"+assetCompName+"'");
					//System.out.println("asset sub comp name is   '"+assetSubCompName+"'");
					if (opType.equals("Modify")) 
					{
						//System.out.println("in first modify");
						String Tab_Prifix = "";
						
						if (assetTypeName.equals("PWS"))
								Tab_Prifix ="RWS_PWS_";
						else if (assetTypeName.equals("MPWS"))
								Tab_Prifix ="RWS_MPWS_";
						else if (assetTypeName.equals("CPWS"))
								Tab_Prifix ="RWS_CPWS_";
						//System.out.println("assetCompName="+assetCompName);
						//System.out.println("assetSubCompName="+assetSubCompName);
						//System.out.println("assetTypeName="+assetTypeName);
								
						if (assetTypeName.equals("HANDPUMPS")
								&& assetCompName.equals("SOURCE")
								&& assetSubCompName.equals("BORE WELL"))
								labelValueBean.setCount(getAssetSubCompCount(empMasterData.conn,
										"RWS_HP_SUBCOMP_PARAM_TBL", assetTypeName,
										assetTypeCode, habCode, pumpCode));
					
						else if(( assetTypeName.equals("PWS") || assetTypeName.equals("CPWS") || assetTypeName.equals("MPWS") )
								&& assetCompName.equals("SOURCE")
								&& assetSubCompName.equals("SUBSURFACE SOURCE"))
								labelValueBean.setCount(getAssetSubCompCountForSource(empMasterData.conn,
										"RWS_SOURCE_TBL", assetTypeName,
										assetTypeCode, assetSubCompName, habCode, pumpCode));
						
						else if(( assetTypeName.equals("PWS") || assetTypeName.equals("CPWS") || assetTypeName.equals("MPWS") )
							&& assetCompName.equals("SOURCE")
							&& assetSubCompName.equals("SURFACE SOURCE"))
							labelValueBean.setCount(getAssetSubCompCountForSource(empMasterData.conn,
									"RWS_SOURCE_TBL", assetTypeName,
									assetTypeCode, assetSubCompName, habCode, pumpCode));
						
						
						
						else if( (assetTypeName.equals("PWS") || assetTypeName.equals("CPWS") || assetTypeName.equals("MPWS") )
							&& assetCompName.equals("SOURCE")
							&& assetSubCompName.equals("PUMPSETS"))
							labelValueBean.setCount(getAssetSubCompCount(empMasterData.conn, Tab_Prifix+"SUBCOMP_PARAM_TBL", assetTypeName,
									assetTypeCode, habCode, pumpCode));
						
						else if( (assetTypeName.equals("PWS") || assetTypeName.equals("CPWS") || assetTypeName.equals("MPWS") )
								&& assetCompName.equals("OTHERS")
								&& assetSubCompName.equals("MISCELLANEOUS"))
								labelValueBean.setCount(getAssetSubCompCount(empMasterData.conn, Tab_Prifix+"OTHERS_PARAM_TBL", assetTypeName,
										assetTypeCode, habCode, pumpCode));
					
						else if( (assetTypeName.equals("PWS") || assetTypeName.equals("CPWS") || assetTypeName.equals("MPWS") )
								&& assetCompName.equals("HEADWORKS")
								&& assetSubCompName.equals("RAW WATER COLLECTION WELL"))
								labelValueBean.setCount(getAssetSubCompCount(empMasterData.conn,Tab_Prifix+"RW_COLLWELL_PARAM_TBL", assetTypeName,
								assetTypeCode, habCode, pumpCode));
						else if( (assetTypeName.equals("PWS") || assetTypeName.equals("CPWS") || assetTypeName.equals("MPWS") )
								&& assetCompName.equals("HEADWORKS")
								&& assetSubCompName.equals("SS TANK"))
								labelValueBean.setCount(getAssetSubCompCount(empMasterData.conn,Tab_Prifix+"SS_SC_PARAM_TBL", assetTypeName,
								assetTypeCode, habCode, pumpCode));
						else if( (assetTypeName.equals("PWS") || assetTypeName.equals("CPWS") || assetTypeName.equals("MPWS") )
								&& assetCompName.equals("HEADWORKS")
								&& assetSubCompName.equals("SUMP"))
							labelValueBean.setCount(getAssetSubCompCount(empMasterData.conn, Tab_Prifix+"SUMP_M_SC_PARAM_TBL", assetTypeName,
										assetTypeCode, habCode, pumpCode));
						else if( (assetTypeName.equals("PWS") || assetTypeName.equals("CPWS") || assetTypeName.equals("MPWS") )
								&& assetCompName.equals("HEADWORKS")
								&& (assetSubCompName.equals("SS FILTER")||assetSubCompName.equals("SS FILTERS")))
							labelValueBean.setCount(getAssetSubCompCountWTP(empMasterData.conn,Tab_Prifix+"WTP_SC_PARAM_TBL", assetTypeName,
								assetTypeCode, habCode, pumpCode,assetSubCompName));
						else if( (assetTypeName.equals("PWS") || assetTypeName.equals("CPWS") || assetTypeName.equals("MPWS") )
								&& assetCompName.equals("HEADWORKS")
								&& (assetSubCompName.equals("RS FILTER")||assetSubCompName.equals("RS FILTERS")))
						{
							//System.out.println("******calling setCount in RS FILTER");
							labelValueBean.setCount(getAssetSubCompCountWTP(empMasterData.conn,Tab_Prifix+"WTP_SC_PARAM_TBL", assetTypeName,
								assetTypeCode, habCode, pumpCode,assetSubCompName));
							
						}
						else if( (assetTypeName.equals("PWS") || assetTypeName.equals("CPWS") || assetTypeName.equals("MPWS") )
								&& assetCompName.equals("HEADWORKS")
								&& assetSubCompName.equals("FOOT PATH BRIDGE"))
							labelValueBean.setCount(getAssetSubCompCount(empMasterData.conn,Tab_Prifix+"FP_BRIDGE_PARAM_TBL", assetTypeName,
								assetTypeCode, habCode, pumpCode));
						else if( (assetTypeName.equals("PWS") || assetTypeName.equals("CPWS") || assetTypeName.equals("MPWS") )
								&& assetCompName.equals("HEADWORKS")
								&& assetSubCompName.equals("PUMP HOUSE"))
							labelValueBean.setCount(getAssetSubCompCount(empMasterData.conn,Tab_Prifix+"PUMPHOUSE_PARAM_TBL", assetTypeName,
									assetTypeCode, habCode, pumpCode));
						else if( (assetTypeName.equals("PWS") || assetTypeName.equals("CPWS") || assetTypeName.equals("MPWS") )
								&& assetCompName.equals("HEADWORKS")
								&& assetSubCompName.equals("WATCHMAN QUARTER"))
							labelValueBean.setCount(getAssetSubCompCount(empMasterData.conn,Tab_Prifix+"WATCHMAN_PARAM_TBL", assetTypeName,
									assetTypeCode, habCode, pumpCode));
						else if( (assetTypeName.equals("PWS") || assetTypeName.equals("CPWS") || assetTypeName.equals("MPWS") )
								&& assetCompName.equals("HEADWORKS")
								&& assetSubCompName.equals("CLEAR WATER COLLECTION WELL"))
							labelValueBean.setCount(getAssetSubCompCount(empMasterData.conn,Tab_Prifix+"CW_COLLWELL_PARAM_TBL", assetTypeName,
									assetTypeCode, habCode, pumpCode));
						
							
						else if( (assetTypeName.equals("PWS") || assetTypeName.equals("CPWS") || assetTypeName.equals("MPWS") )
									&& assetCompName.equals("SR. RESERVOIRS")
									&& assetSubCompName.equals("GLSR"))
								labelValueBean.setCount(getAssetSubCompCount(empMasterData.conn,Tab_Prifix+"GLSR_SC_PARAM_TBL", assetTypeName,
										assetTypeCode, habCode, pumpCode));
						else if( (assetTypeName.equals("PWS") || assetTypeName.equals("CPWS") || assetTypeName.equals("MPWS") )
									&& assetCompName.equals("SR. RESERVOIRS")
									&& assetSubCompName.equals("OHSR"))
								labelValueBean.setCount(getAssetSubCompCount(empMasterData.conn,Tab_Prifix+"OHSR_SC_PARAM_TBL", assetTypeName,
										assetTypeCode, habCode, pumpCode));
						else if( (assetTypeName.equals("PWS") || assetTypeName.equals("CPWS") || assetTypeName.equals("MPWS") )
									&& assetCompName.equals("SR. RESERVOIRS")
									&& assetSubCompName.equals("CISTERNS"))
								labelValueBean.setCount(getAssetSubCompCount(empMasterData.conn, Tab_Prifix+"CIS_SC_PARAM_TBL", assetTypeName,
										assetTypeCode, habCode, pumpCode));
						else if(( assetTypeName.equals("PWS") || assetTypeName.equals("CPWS") || assetTypeName.equals("MPWS") )
								&& assetCompName.equals("SR. RESERVOIRS")
								&& assetSubCompName.equals("GLBR"))
							labelValueBean.setCount(getAssetSubCompCount(empMasterData.conn, Tab_Prifix+"GLBR_SC_PARAM_TBL", assetTypeName,
									assetTypeCode, habCode, pumpCode));
						else if(( assetTypeName.equals("PWS") || assetTypeName.equals("CPWS") || assetTypeName.equals("MPWS") )
								&& assetCompName.equals("SR. RESERVOIRS")
								&& assetSubCompName.equals("OHBR"))
							labelValueBean.setCount(getAssetSubCompCount(empMasterData.conn, Tab_Prifix+"OHBR_SC_PARAM_TBL", assetTypeName,
									assetTypeCode, habCode, pumpCode));
						else if( (assetTypeName.equals("PWS") || assetTypeName.equals("CPWS") || assetTypeName.equals("MPWS") )
								&& assetCompName.equals("SR. RESERVOIRS")
								&& assetSubCompName.equals("BPT"))
							labelValueBean.setCount(getAssetSubCompCount(empMasterData.conn, Tab_Prifix+"BPT_PARAM_TBL", assetTypeName,
									assetTypeCode, habCode, pumpCode));
						else if( (assetTypeName.equals("PWS") || assetTypeName.equals("CPWS") || assetTypeName.equals("MPWS") )
							&& assetCompName.equals("SR. RESERVOIRS")
							&& assetSubCompName.equals("CISTERNS"))
						labelValueBean.setCount(getAssetSubCompCount(empMasterData.conn, Tab_Prifix+"CIS_SC_PARAM_TBL", assetTypeName,
								assetTypeCode, habCode, pumpCode));
						
						else if(( assetTypeName.equals("PWS") || assetTypeName.equals("CPWS") || assetTypeName.equals("MPWS") )
								&& assetCompName.trim().equals("PIPELINE")
								&& assetSubCompName.equals("PUMPING MAIN"))
							labelValueBean.setCount(getAssetSubCompCount(empMasterData.conn, Tab_Prifix+"PUMPINGMAIN_TBL", assetTypeName,
									assetTypeCode, habCode, pumpCode));
					
						else if( (assetTypeName.equals("PWS") || assetTypeName.equals("CPWS") || assetTypeName.equals("MPWS") )
								&& assetCompName.equals("PIPELINE")
								&& assetSubCompName.equals("GRAVITY MAIN"))
							labelValueBean.setCount(getAssetSubCompCount(empMasterData.conn, Tab_Prifix+"GRAVITYMAIN_TBL", assetTypeName,
									assetTypeCode, habCode, pumpCode));
						
						else if( (assetTypeName.equals("PWS") || assetTypeName.equals("CPWS") || assetTypeName.equals("MPWS") )
								&& assetCompName.equals("PIPELINE")
								&& assetSubCompName.equals("DISTRIBUTION"))
							labelValueBean.setCount(getAssetSubCompCount(empMasterData.conn, Tab_Prifix+"DISTRI_SC_PARAM_TBL", assetTypeName,
									assetTypeCode, habCode, pumpCode));
					
						else if( (assetTypeName.equals("PWS") || assetTypeName.equals("CPWS") || assetTypeName.equals("MPWS") )
								&& assetCompName.equals("OTHERS")
								&& assetSubCompName.equals("MISCELLANEOUS")){}
							//labelValueBean.setCount(getAssetSubCompCount(empMasterData.conn, Tab_Prifix+""RWS_PWS_PUMP_DET_SC_PARAM_TBL", assetTypeName,assetTypeCode, habCode, pumpCode));
							
						else
							labelValueBean.setCount(0);
						assetSubComponents.add(labelValueBean);
					}//end of modify if
				}//end of while
			
			}else
			{
				//System.out.println("in else");
				if(assetTypeCode.equals("05"))
				{
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue("001");
					labelValueBean.setLabel("SHALLOW HANDPUMPS");
					labelValueBean.setCount(getAssetSubCompCount(empMasterData.conn, "RWS_SHALLOWHANDPUMPS_TBL", assetTypeName,
							assetTypeCode, habCode, pumpCode));
				}
				if(assetTypeCode.equals("06"))
				{
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue("001");
					labelValueBean.setLabel("OPEN WELLS");
					labelValueBean.setCount(getAssetSubCompCount(empMasterData.conn, "RWS_OPEN_WELL_MAST_TBL", assetTypeName,
							assetTypeCode, habCode, pumpCode));
				}
				if(assetTypeCode.equals("07"))
				{
					assetSubCompName="PONDS";
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue("001");
					labelValueBean.setLabel("PONDS");
					labelValueBean.setCount(getAssetSubCompCount(empMasterData.conn, "RWS_OPENWELL_POND_TBL", assetTypeName,
							assetTypeCode, habCode, pumpCode));
				}
				if(assetTypeCode.equals("08"))
				{
					labelValueBean = new LabelValueBean();
					labelValueBean.setValue("001");
					labelValueBean.setLabel("OTHERS");
				}
				if (opType.equals("Modify")) 
				{
					//System.out.println("in second modify");
					String Tab_Prifix = "";
					
					if (assetTypeName.equals("PWS"))
							Tab_Prifix ="RWS_PWS_";
					else if (assetTypeName.equals("MPWS"))
							Tab_Prifix ="RWS_MPWS_";
					else if (assetTypeName.equals("CPWS"))
							Tab_Prifix ="RWS_CPWS_";
					//System.out.println("assetCompName="+assetCompName);
					//System.out.println("assetSubCompName="+assetSubCompName);
					//System.out.println("assetTypeName="+assetTypeName);
					
					if( assetTypeName.equals("PONDS") && assetCompName.equals("SOURCE"))
					{
						assetSubCompName="PONDS";
						labelValueBean.setCount(getAssetSubCompCount(empMasterData.conn,
								"RWS_OPENWELL_POND_TBL", assetTypeName,
								assetTypeCode, habCode, pumpCode));
						//System.out.println("count="+labelValueBean.getCount());
					}
					
					if( assetTypeName.equals("SHALLOW HAND PUMPS") && assetCompName.equals("SOURCE")
							&& assetSubCompName.equals("SHALLOW HAND PUMPS"))
						labelValueBean.setCount(getAssetSubCompCount(empMasterData.conn,
								"RWS_SHALLOWHANDPUMPS_TBL", assetTypeName,
								assetTypeCode, habCode, pumpCode));
					
					if( assetTypeName.equals("OPEN WELLS") && assetCompName.equals("SOURCE")
							&& assetSubCompName.equals("OPEN WELLS"))
						labelValueBean.setCount(getAssetSubCompCount(empMasterData.conn,
								"RWS_OPEN_WELL_MAST_TBL", assetTypeName,
								assetTypeCode, habCode, pumpCode));
					
					assetSubComponents.add(labelValueBean);
				}//end of modify if
				
			}//end of else
		}//end of try
		finally 
		{
			empMasterData.closeAll();
		}
		return assetSubComponents;
	}

	public static ArrayList getAssetSubCompParams(DataSource dataSource,
			String assetCode, String assetTypeCode, String assetCompCode,
			String assetSubCompCode, String habCode, String pumpCode)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		Asset_Pumpset asset_pumpset = null;
		Asset_PipeLine asset_pipeline = null;
		Asset_Ponds asset_ponds=null;
		Asset_SHP asset_SHP=null;
		Asset_OpenWells asset_openWells=null;
		Asset_Others asset_others=null;
		Asset_Reservior asset_reservoir=null;
		
		ArrayList parameters = new ArrayList();
		String query = "";
		try {
			/*
			 * Asset Types
			 * 
			 * 01-PWS 02-MPWS 03-CPWS 04-HANDPUMPS 05-DIRECT PUMPING
			 * 
			 * Asset Component Types
			 * 
			 * Asset Type-PWS 01-SOURCE 03-PIPELINE 04-RESERVOIRS 05-PUMPSETS
			 * 
			 * Asset Type-CPWS 01-SOURCE 02-HEADWORKS 03-PIPELINE
			 * 04-SR.RESERVOIRS 05-PUMPSETS
			 * 
			 * Asset Type-HANDPUMPS 01-SOURCE
			 * 
			 * Asset Type-MPWS
			 * 
			 * 01-SOURCE 03-PIPELINE 04-RESERVOIRS 05-PUMPSETS
			 * 
			 * Asset SubComponents
			 * 
			 * Asset Type-04-HANDPUMPS Asset Component-01-SOURCE Asset
			 * SubComponent-001-BOREWElL
			 * 
			 * Asset Type-01-PWS Asset Component-01-SOURCE Asset SubComponent-
			 * 001-BORE WELL
			 * 
			 * Asset Type-01-PWS Asset Component-01-SOURCE Asset SubComponent-
			 * 002-WATCHMAN QUARTER
			 * 
			 * Asset Type- 01-PWS Asset Component-03-PIPELINE Asset
			 * SubComponent-001-DISTRIBUTION
			 * 
			 * ASSET TYPE=01-PWS ASSET COMPONENT-03-PIPELINE ASSET
			 * SUBCOMPONENT-002-STANDPOSTS
			 * 
			 * ASSET TYPE=01-PWS ASSET COMPONENT-03-PIPELINE ASSET
			 * SUBCOMPONENT-003-PUMPING MAIN
			 * 
			 * ASSET TYPE=01-PWS ASSET COMPONENT-04-RESERVOIRS ASSET
			 * SUBCOMPONENT-001-OHSR
			 * 
			 * ASSET TYPE=01-PWS ASSET COMPONENT-04-RESERVOIRS ASSET
			 * SUBCOMPONENT-002-CISTERNS
			 * 
			 * ASSET TYPE=01-PWS ASSET COMPONENT-04-RESERVOIRS ASSET
			 * SUBCOMPONENT-003-GLSR
			 * 
			 * ASSET TYPE=01-PWS ASSET COMPONENT-05-PUMPSETS ASSET
			 * SUBCOMPONENT-002-PUMP HOUSE
			 * 
			 * ASSET TYPE=01-PWS ASSET COMPONENT-05-PUMPSETS ASSET
			 * SUBCOMPONENT-003-CAPACITORS
			 * 
			 * ASSET TYPE=03-CPWS ASSET COMPONENT-01-SOURCE ASSET
			 * SUBCOMPONENT-001-BOREWELL
			 * 
			 * ASSET TYPE=03-CPWS ASSET COMPONENT-01-SOURCE ASSET
			 * SUBCOMPONENT-002-ROTARY BOREWELL
			 * 
			 * ASSET TYPE=03-CPWS ASSET COMPONENT- 01-SOURCE ASSET
			 * SUBCOMPONENT-003- INTAKE WELL
			 * 
			 * ASSET TYPE=03-CPWS ASSET COMPONENT-01-SOURCE ASSET
			 * SUBCOMPONENT-004-INFILTRATION WELL
			 * 
			 * ASSET TYPE=03-CPWS ASSET COMPONENT-01-SOURCE ASSET
			 * SUBCOMPONENT-005-SOURCE TYPE
			 * 
			 * ASSET TYPE=03-CPWS ASSET COMPONENT-02-HEAD WORKS ASSET
			 * SUBCOMPONENT-001-RAW WATER COLLECTION WELL
			 * 
			 * ASSET TYPE=03-CPWS ASSET COMPONENT-02-HEADWORKS ASSET
			 * SUBCOMPONENT-003-SS TANK
			 * 
			 * ASSET TYPE=03-CPWS ASSET COMPONENT-02-HEADWORKS ASSET
			 * SUBCOMPONENT-004-SS FILTERS
			 * 
			 * ASSET TYPE=03-CPWS ASSET COMPONENT-02-HEADWORKS ASSET
			 * SUBCOMPONENT-005-empMasterData.rs FILTERS
			 * 
			 * ASSET TYPE=03-CPWS ASSET COMPONENT-02-HEADWORKS ASSET
			 * SUBCOMPONENT-006-SUMP
			 * 
			 * ASSET TYPE=03-CPWS ASSET COMPONENT-02-HEADWORKS ASSET
			 * SUBCOMPONENT-009-FOOT PATH BRIDGE
			 * 
			 * ASSET TYPE=03-CPWS ASSET COMPONENT-02-HEADWORKS ASSET
			 * SUBCOMPONENT-010-PUMP HOUSE
			 * 
			 * ASSET TYPE=03-CPWS ASSET COMPONENT-02-HEADWORKS ASSET
			 * SUBCOMPONENT-011-WATCHMAN QUARTER
			 * 
			 * ASSET TYPE=03-CPWS ASSET COMPONENT-02-HEADWORKS ASSET
			 * SUBCOMPONENT-012-CLEAR WATER COLLECTION WELL
			 * 
			 * ASSET TYPE=03-CPWS ASSET COMPONENT-03-PIPELINE ASSET
			 * SUBCOMPONENT-001-PUMPING MAIN
			 * 
			 * ASSET TYPE=03-CPWS ASSET COMPONENT-03-PIPELINE ASSET
			 * SUBCOMPONENT-002-GRAVITY MAIN
			 * 
			 * ASSET TYPE=03-CPWS ASSET COMPONENT-03-PIPELINE ASSET
			 * SUBCOMPONENT-003-DISTRIBUTION
			 * 
			 * ASSET TYPE=03-CPWS ASSET COMPONENT-04-SR.RESERVOIRS ASSET
			 * SUBCOMPONENT-001-OHSR
			 * 
			 * ASSET TYPE=03-CPWS ASSET COMPONENT-04-SR.RESERVOIRS ASSET
			 * SUBCOMPONENT-002-OHBR
			 * 
			 * ASSET TYPE=03-CPWS ASSET COMPONENT-04-SR.RESERVOIRS ASSET
			 * SUBCOMPONENT-003-GLSR
			 * 
			 * ASSET TYPE=03-CPWS ASSET COMPONENT-04-SR.RESERVOIRS ASSET
			 * SUBCOMPONENT-004-GLBR
			 * 
			 * ASSET TYPE=03-CPWS ASSET COMPONENT-04-SR.RESERVOIRS ASSET
			 * SUBCOMPONENT-005-BPT
			 * 
			 * ASSET TYPE=03-CPWS ASSET COMPONENT-05-PUMPSETS ASSET
			 * SUBCOMPONENT-001-PUMP DETAILS
			 */
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			String Tab_Prifix = "";
			if( assetTypeCode.equals("01"))
				Tab_Prifix =  "RWS_PWS_" ;
			else if( assetTypeCode.equals("02"))
				Tab_Prifix =  "RWS_MPWS_" ;
			else if( assetTypeCode.equals("03"))
				Tab_Prifix =  "RWS_CPWS_" ;
			else if( assetTypeCode.equals("05"))
				Tab_Prifix =  "RWS_SHALLOWHANDPUMPS_TBL" ;
			else if( assetTypeCode.equals("06"))
				Tab_Prifix =  "RWS_OPEN_WELL_MAST_TBL" ;
			else if( assetTypeCode.equals("07"))
				Tab_Prifix =  "RWS_OPENWELL_POND_TBL" ;
			else if( assetTypeCode.equals("08"))
				Tab_Prifix =  " RWS_CPWS_OTHERS_PARAM_TBL" ;
			
			//System.out.println("hiiiiiiiiiiiiiiii=" + assetTypeCode + "  "
					+ assetCompCode + "  " + assetSubCompCode + " " + pumpCode);
			
			if( assetTypeCode.equals("05") 
					&& assetCompCode.equals("01")
					&& assetSubCompCode.equals("001")) {
			
			query = "select * from "+Tab_Prifix+" OT, RWS_ASSET_MAST_TBL A where OT.ASSET_CODE=A.ASSET_CODE " 
					//+"AND A.HAB_CODE='"+ habCode
					+ " and OT.asset_code='"+ assetCode+ "'";
			//System.out.println("query shp  "+query);
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			
			
			if (empMasterData.rs == null)
				parameters.add(asset_SHP);
			else
				
				while (empMasterData.rs.next()) {
					
					asset_SHP = new Asset_SHP();
					asset_SHP.setAssetCode(empMasterData.rs.getString("ASSET_CODE"));
					asset_SHP.setHabCode(empMasterData.rs.getString("HAB_CODE"));
					asset_SHP.setShallowHandPumpCode(empMasterData.rs.getString("SHALLOWHP_CODE"));
					asset_SHP.setLocation(empMasterData.rs.getString("LOCATION"));
					asset_SHP.setDiameter(empMasterData.rs.getFloat("DIAMETER")+"");
					asset_SHP.setDepth(empMasterData.rs.getFloat("DEPTH")+"");
					asset_SHP.setHygiene(empMasterData.rs.getString("HYGIENE"));
					asset_SHP.setAvgNoOfHoursWorkingPerDay(empMasterData.rs.getFloat("AVERAGE_HOURS")+"");
					asset_SHP.setAvgTimeToFill(empMasterData.rs.getFloat("AVERAGE_TIME")+"");
					asset_SHP.setYeild(empMasterData.rs.getFloat("YIELD")+"");
					asset_SHP.setWaterQuality(empMasterData.rs.getString("WATER_QUALITY"));
					asset_SHP.setFloride(empMasterData.rs.getFloat("FLORIDE_PER")+"");
					asset_SHP.setBrakish(empMasterData.rs.getFloat("BRAKISH_PER")+"");
					asset_SHP.setIron(empMasterData.rs.getFloat("IRON_PER")+"");
					asset_SHP.setOthersType(format(empMasterData.rs.getString("OTHERS"))+"");
					asset_SHP.setOthers(empMasterData.rs.getFloat("OTHERS_PER")+"");
					
					
					parameters.add(asset_SHP);
				}
		
			
			}
			
			
			if( assetTypeCode.equals("06") 
					&& assetCompCode.equals("01")
					&& assetSubCompCode.equals("001")) {
			query = "select * from "+Tab_Prifix+" OT, RWS_ASSET_MAST_TBL A where OT.ASSET_CODE=A.ASSET_CODE " 
					//+"AND A.HAB_CODE='"+ habCode
					+ " and OT.asset_code='"+ assetCode+ "'";
			//System.out.println("query open wells  "+query);
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			
			
			if (empMasterData.rs == null)
				parameters.add(asset_openWells);
			else
				
				while (empMasterData.rs.next()) {
				
					asset_openWells = new Asset_OpenWells();
					asset_openWells.setAssetCode(empMasterData.rs.getString("ASSET_CODE"));
					asset_openWells.setHabCode(empMasterData.rs.getString("HABITATION_CODE"));
					asset_openWells.setOpenWellCode(empMasterData.rs.getString("OPENWELL_CODE"));
					asset_openWells.setLocation(empMasterData.rs.getString("LOCATION"));
					asset_openWells.setDiameter(empMasterData.rs.getFloat("DIAMETER")+"");
					asset_openWells.setDepth(empMasterData.rs.getFloat("DEPTH")+"");
					asset_openWells.setNormalWaterLevel(empMasterData.rs.getFloat("NORMAL_WATER_LEVEL")+"");
					asset_openWells.setMinimumWaterLevel(empMasterData.rs.getFloat("MIN_WATER_LEVEL")+"");
					asset_openWells.setMaximumWaterLevel(empMasterData.rs.getFloat("MAX_WATER_LEVEL")+"");
					asset_openWells.setPlatformExists(empMasterData.rs.getString("PLATFORM_EXISTS"));
					asset_openWells.setPlatformCondition(empMasterData.rs.getString("PLATFORM_CONDITION"));
					asset_openWells.setPurpose(empMasterData.rs.getString("PURPOSE"));
					asset_openWells.setWaterQuality(empMasterData.rs.getString("QUALITY"));
					asset_openWells.setFloride(empMasterData.rs.getFloat("FLOURIDE_PER")+"");
					asset_openWells.setBrakish(empMasterData.rs.getFloat("BRAKISH_PER")+"");
					asset_openWells.setIron(empMasterData.rs.getFloat("IRON_PER")+"");
					asset_openWells.setOthers(empMasterData.rs.getFloat("OTHER_PER")+"");
					asset_openWells.setOthersType(format(empMasterData.rs.getString("OTHER_TYPE"))+"");
					parameters.add(asset_openWells);
				}
		
			
			}
			
			
			if( assetTypeCode.equals("07") 
					&& assetCompCode.equals("01")
					&& assetSubCompCode.equals("001")) {
			query = "select * from "+Tab_Prifix+" OT, RWS_ASSET_MAST_TBL A where OT.ASSET_CODE=A.ASSET_CODE " 
					//+"AND A.HAB_CODE='"+ habCode
					+ " and OT.asset_code='"+ assetCode+ "'";
			//System.out.println("query ponds  "+query);
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			
			
			if (empMasterData.rs == null)
				parameters.add(asset_ponds);
			else
				
				while (empMasterData.rs.next()) {
					
					asset_ponds = new Asset_Ponds();
					asset_ponds.setPondCode(empMasterData.rs.getString("POND_CODE"));
					asset_ponds.setAssetCode(empMasterData.rs.getString("ASSET_CODE"));
					asset_ponds.setHabCode(empMasterData.rs.getString("HAB_CODE"));
					
					asset_ponds.setName(empMasterData.rs.getString("POND_NAME"));
					asset_ponds.setLocation(empMasterData.rs.getString("POND_LOCATION"));
					asset_ponds.setAreaSize(empMasterData.rs.getString("SIZE_AREA"));
					asset_ponds.setVolumeOfStorage(empMasterData.rs.getString("STORAGE_VOL"));
					asset_ponds.setHygeinity(empMasterData.rs.getString("HYGENITY"));
					asset_ponds.setPurpose(empMasterData.rs.getString("USAGE_PURPOSE"));
					asset_ponds.setFedBy(empMasterData.rs.getString("FED_BY"));
					asset_ponds.setFedName(empMasterData.rs.getString("FED_NAME"));
					asset_ponds.setFedOthersName(empMasterData.rs.getString("FED_OTHERS_NAME"));
					asset_ponds.setWaterQuality(empMasterData.rs.getString("WATER_QUALITY"));
					asset_ponds.setFloride(empMasterData.rs.getString("FLORIDE"));
					asset_ponds.setBrakish(empMasterData.rs.getString("BRAKISH"));
					asset_ponds.setIron(empMasterData.rs.getString("IRON"));
					asset_ponds.setOthersType(format(empMasterData.rs.getString("OTHER_TYPE")));
					asset_ponds.setOthers(empMasterData.rs.getString("OTHER_PER"));
					
					
					parameters.add(asset_ponds);
				}
		
			
			}
			
			if( assetTypeCode.equals("08") 
					&& assetCompCode.equals("01")
					&& assetSubCompCode.equals("001")) {
			query = "select * from "+Tab_Prifix+" OT, RWS_ASSET_MAST_TBL A where OT.ASSET_CODE=A.ASSET_CODE " 
					//+"AND A.HAB_CODE='"+ habCode
					+ " and OT.asset_code='"+ assetCode+ "'";
			//System.out.println("query others  "+query);
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			
			
			if (empMasterData.rs == null)
				parameters.add(asset_others);
			else
				
				while (empMasterData.rs.next()) {
					asset_others = new Asset_Others();
					asset_others.setAssetCode(empMasterData.rs.getString("ASSET_CODE"));
					asset_others.setHabCode(empMasterData.rs.getString("HAB_CODE"));
					
					asset_others.setGeneralCode(empMasterData.rs.getString("OTHER_COMP_CODE"));
					asset_others.setLocation(empMasterData.rs.getString("COMP_LOCATION"));
					asset_others.setComponentName(empMasterData.rs.getString("COMP_NAME"));
					asset_others.setRemarks(empMasterData.rs.getString("REMARKS"));

					
					parameters.add(asset_others);
				}
		
			
			}
			
			
			if( (assetTypeCode.equals("01")||assetTypeCode.equals("02")||assetTypeCode.equals("03")) 
					&& assetCompCode.equals("01")
					&& assetSubCompCode.equals("003")) {
			query = "select DT.ASSET_CODE,PUMP_CODE,PUMP_MAKE,PUMP_CPTY,PUMP_TYPE," +
					"YEAR_COMM,HR_RUN,USAGE,DESIGNED_LPM,DESIGNED_HEAD," 
				  +	"decode(CONTROL_PANEL,'Y','YES','N','NO','YES','YES','NO','NO')" 
				  +	"control_panel,LOW_VOLT_PROB,POWER_AVAIL_PER_DAY," 
				  +	"FEAS_URBAN_LINE,COST,URBAN_LINE_DISTANCE,SUGGESTIONS," 
				  +	"DT.HAB_CODE,DT.LOCATION,FEEDER from "
				  + Tab_Prifix+"SUBCOMP_PARAM_TBL DT" 
				  +	", RWS_ASSET_MAST_TBL A where DT.ASSET_CODE=A.ASSET_CODE " 
					//+"AND A.HAB_CODE='"+ habCode
				  + " and DT.asset_code='"+ assetCode+ "' order by PUMP_CODE";
			//System.out.println("query hp  "+query);
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			
			
			if (empMasterData.rs == null)
				parameters.add(empMaster);
			else
				
				while(empMasterData.rs.next()) {
					asset_pumpset = new Asset_Pumpset();
					asset_pumpset=getPumpsetsFromRs(dataSource,empMasterData.rs);
					parameters.add(asset_pumpset);
				}
				
				
			
			}	
			
			//miscelenaous 
			if( (assetTypeCode.equals("01")||assetTypeCode.equals("02")||assetTypeCode.equals("03")) 
					&& assetCompCode.equals("05")
					&& assetSubCompCode.equals("001")) {
			query = "select OT.OTHER_COMP_CODE,OT.ASSET_CODE,OT.COMP_NAME,OT.COMP_LOCATION,OT.REMARKS,OT.HAB_CODE from "+Tab_Prifix+"OTHERS_PARAM_TBL  OT, RWS_ASSET_MAST_TBL A where OT.ASSET_CODE=A.ASSET_CODE " 
					//+"AND A.HAB_CODE='"+ habCode
					+ " and OT.asset_code='"+ assetCode+ "'";
			//System.out.println("query hp  "+query);
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			
			
			if (empMasterData.rs == null)
				parameters.add(empMaster);
			else
				
				while (empMasterData.rs.next()) {
					asset_pumpset = new Asset_Pumpset();
					
					
					asset_pumpset.setOtherCompCode(empMasterData.rs.getString("OTHER_COMP_CODE"));
					asset_pumpset.setHabCode(empMasterData.rs.getString("HAB_CODE"));
					asset_pumpset.setAsssetCode(empMasterData.rs.getString("ASSET_CODE"));
					asset_pumpset.setCompName(empMasterData.rs.getString("COMP_NAME"));
					asset_pumpset.setCompLocation(empMasterData.rs.getString("REMARKS"));
					asset_pumpset.setRemarks(empMasterData.rs.getString("remarks"));
					parameters.add(asset_pumpset);
				}
		
			
			}
			else if (assetTypeCode.equals("04") 
					&& assetCompCode.equals("01")
					&& assetSubCompCode.equals("001")) {
				//query = "select  HP.LOCATION as \"Location\",HP.DRILL_YEAR as \"Year Of Drilling\",HP.DIAMETER as \"Diameter\",HP.CASING as \"Casing\",HP.STATUS as \"Status\",HP.GEN_CONDITION as \"General Condition\",HP.GI_NO as \"GI No\",HP.PAINTED as \"Painted\",HP.STATIC_WL as \"Static Water Level\" ,HP.SUMMER_WL as \"Summer Water Level\",HP.P_COND as \"Present Condition\",HP.DRY_DURING as \"Dry During\",HP.SERVICE  as \"Service\",HP.SER_NO as \"Service No\",HP.SER_HRS as \"Ser HRS\",HP.REPAIRS as \"Repairs\",HP.PLATFORM_CONDITION as \"Platform Condition\",HP.DRAIN as \"Drain\",HP.DRAIN_CONDITION as \"Drain Condition\",HP.DRAIN_SD as \"Drain SD\",HP.DRAIN_LP as \"Drain LP\",HP.HYGIENE as \"Hygiene\",HP.AVG_TIME as \"Average Time\",HP.P_YEILD as \"PYield\",HP.PYEILD_LOCAL as \"PYield Local\",HP.PERIOD as \"Local\" ,HP.ASSET_CODE as \"Asset Code\",hp_code,HP.depth,HP.QUALITY_AFFECTED, HP.FLOURIDE,HP.BRAKISH ,HP.IRON,HP.OTHERS_SPECIFY_TYPE from RWS_HP_SUBCOMP_PARAM_TBL HP,RWS_ASSET_MAST_TBL A,RWS_ASSET_SCHEME_TBL S where HP.ASSET_CODE=A.ASSET_CODE AND A.HAB_CODE='"
				query = "select  HP.LOCATION ,HP.DIAMETER ,HP.CASING ,HP.GEN_CONDITION ,HP.GI_NO ,HP.PAINTED,HP.STATIC_WL  ,HP.SUMMER_WL ,HP.P_COND ,HP.DRY_DURING,HP.SER_NO ,HP.SER_HRS ,HP.REPAIRS ,HP.PLATFORM_CONDITION ,HP.DRAIN ,HP.DRAIN_CONDITION ,HP.DRAIN_SD ,HP.DRAIN_LP ,HP.HYGIENE ,HP.AVG_TIME ,HP.P_YEILD ,HP.PYEILD_LOCAL ,HP.PERIOD ,HP.ASSET_CODE,hp_code,HP.depth,HP.QUALITY_AFFECTED, HP.FLOURIDE,HP.BRAKISH ,HP.IRON,HP.cont_others_type,HP.CONT_OTHERS_PER  from RWS_HP_SUBCOMP_PARAM_TBL HP,RWS_ASSET_MAST_TBL A,RWS_ASSET_SCHEME_TBL S where HP.ASSET_CODE=A.ASSET_CODE " 
						+ "AND A.HAB_CODE='"+ habCode
						+ "' AND SUBSTR(S.SCHEME_CODE,17,3)='"+ pumpCode
						+ "' AND A.ASSET_CODE=S.ASSET_CODE " 
						+ "AND A.TYPE_OF_ASSET_CODE='"+ assetTypeCode
						//+ "' AND substr(HP.asset_code,7,2)='"
						//+ assetTypeCode 
						+ "'";
				empMasterData.rs =empMasterData.stmt.executeQuery(query);
				//System.out.println("query hp  "+query);
				
				if (empMasterData.rs == null)
					parameters.add(empMaster);
				else
					
					while (empMasterData.rs.next()) {
						
						empMaster = new EmpMaster();
						empMaster.setLocation(empMasterData.rs.getString("LOCATION"));
						//empMaster.setYearOfDrilling(empMasterData.rs.getString(2));
						empMaster.setDiameter(empMasterData.rs.getString("DIAMETER"));
						empMaster.setCasing(empMasterData.rs.getString("CASING"));
						//empMaster.setStatus(empMasterData.rs.getString("5)");
						empMaster.setGenCondition(empMasterData.rs.getString("GEN_CONDITION"));
						empMaster.setGino(empMasterData.rs.getString("GI_NO"));
						empMaster.setPainted(empMasterData.rs.getString("PAINTED"));
						empMaster.setStaticWaterLevel(empMasterData.rs.getString("STATIC_WL"));
						empMaster.setSummerWaterLevel(empMasterData.rs.getString("SUMMER_WL"));
						empMaster.setPcond(empMasterData.rs.getString("P_COND"));
						//empMaster.setDryduring(empMasterData.rs.getString("12));
						//empMaster.setService(empMasterData.rs.getString(13));
						empMaster.setSerno(empMasterData.rs.getString("SER_NO"));
						empMaster.setSerhrs(empMasterData.rs.getString("SER_HRS"));
						empMaster.setRepairs(empMasterData.rs.getString("REPAIRS"));
						empMaster.setPlatformCondition(empMasterData.rs.getString("PLATFORM_CONDITION"));
						empMaster.setDrain(empMasterData.rs.getString("DRAIN"));
						empMaster.setDrainCondition(empMasterData.rs.getString("DRAIN_CONDITION"));
						empMaster.setDrainsd(empMasterData.rs.getString("DRAIN_SD"));
						empMaster.setDrainlp(empMasterData.rs.getString("DRAIN_LP"));
						empMaster.setHygiene(empMasterData.rs.getString("HYGIENE"));
						empMaster.setAvgtime(empMasterData.rs.getString("AVG_TIME"));
						empMaster.setPyield(empMasterData.rs.getString("P_YEILD"));
						empMaster.setPyieldLocal(empMasterData.rs.getString("PYEILD_LOCAL"));
						empMaster.setPeriod(empMasterData.rs.getString("PERIOD"));
						empMaster.setAssetCode(empMasterData.rs.getString("ASSET_CODE"));
						empMaster.setHpCode(empMasterData.rs.getString("HP_CODE"));
						empMaster.setHabCode(empMaster.getHpCode().substring(0,16));
						//System.out.println("hab code in handpumps is "+empMaster.getHabCode());
						empMaster.setDepth(empMasterData.rs.getInt("DEPTH"));
						empMaster.setQualityAffected(empMasterData.rs.getString("QUALITY_AFFECTED"));
						empMaster.setFlouride(empMasterData.rs.getDouble("FLOURIDE"));
						empMaster.setBrakish(empMasterData.rs.getDouble("BRAKISH"));
						empMaster.setIron(empMasterData.rs.getDouble("IRON"));
						empMaster.setOthersType(format(empMasterData.rs.getString("cont_others_type")));
						empMaster.setOthers(empMasterData.rs.getString("CONT_OTHERS_PER"));
						
						parameters.add(empMaster);
					}
					} else if (assetTypeCode.equals("01") 
							&& assetCompCode.equals("01")
							&& (assetSubCompCode.equals("001") || assetSubCompCode.equals("007") )) {
				query = "select  PB.POP_DES as \"Population Description\","
						+ "PB.SOURCE  as \"Source\",PB.SOUR_QLTY  as \"Source Quality\","
						+ "PB.SOUR_YEILD as \"Source Yield\",PB.SOUR_DEPEN as \"Source Dependency\","
						+ "PB.SOUR_DEPTH as \"Source Depth\",PB.SOUR_DIAMETER as \"Source Diameter\","
						+ "PB.SOUR_COND as \"Source Condition\",PB.SOUR_SWL  as \"Source Summer Water Level\" "
						+ ",PB.SOUR_NWL  as \"Source NWL\",PB.PH_SIZE as \"PH Size\",PB.PH_COND as \"PH Condition\","
						+ "PB.PH_TYPE  as \"PH Type\",PB.PUMP_NAME as \"Pump Name\",PB.PUMP_CPTY as \"Pump Capacity\","
						+ "PB.PUMP_TYPE  as \"Pump Type\",PB.YEAR_PUR as \"Pursuing Year \",PB.HR_RUN as \"HR RUN\","
						+ "PB.HR_SIN as \"HR SIN\",PB.HR_MS  as \"HR MS\",PB.STA_EXE as \"STA EXE\","
						+ "PB.PUMP_DUTY_LPM as \"Pump Duty LPM\",PB.PUMP_DUTY_HEAD as \"Pump Duty Head\","
						+ "PB.ASSET_CODE as \"Asset Code\",PB.IF_NSS AS  \"IF NSS\",PB.PUMP_NO AS \"Pump Number \","
						+ "PB.STAND_BY_PUMP_CAPACITY  AS \"Stand By Pump Capacity \", PB.STAND_BY_PUMP_NO as \"Stand By Pump No \","
						+ " PB.PUMP_CODE AS \"Pump Code \" , NUMBERS, TOTAL_HP, STAND_BY_NUMBERS, STAND_BY_TOTAL_HP from RWS_PWS_SUBCOMP_PARAM_TBL PB,RWS_ASSET_MAST_TBL A,RWS_ASSET_SCHEME_TBL S"
						+ " where PB.ASSET_CODE=A.ASSET_CODE AND A.HAB_CODE='"
						+ habCode
						+ "' AND SUBSTR(S.SCHEME_CODE,17,3)='"
						+ pumpCode
						+ "' "
						+ "AND A.ASSET_CODE=S.ASSET_CODE AND A.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode + "' AND "
						//+ "substr(PB.asset_code,7,2)='" + assetTypeCode 
						+ "'";
				//System.out.println("query in pws_borewell " + query);
				empMasterData.rs =empMasterData.stmt.executeQuery(query);

				while (empMasterData.rs.next()) {
					empMaster = new EmpMaster();
					empMaster.setPopDes(empMasterData.rs.getString(1));
					empMaster.setSource(empMasterData.rs.getString(2));
					empMaster.setSourceQuality(empMasterData.rs.getString(3));
					empMaster.setSourceYield(empMasterData.rs.getString(4));
					empMaster.setSourceDepend(empMasterData.rs.getString(5));
					empMaster.setSourceDepth(empMasterData.rs.getString(6));
					empMaster.setSourceDiameter(empMasterData.rs.getString(7));
					empMaster.setSourceCondition(empMasterData.rs.getString(8));
					empMaster.setSourceSwl(empMasterData.rs.getString(9));
					empMaster.setSourceNwl(empMasterData.rs.getString(10));
					empMaster.setPhSize(empMasterData.rs.getString(11));
					empMaster.setPhCondition(empMasterData.rs.getString(12));
					empMaster.setPhType(empMasterData.rs.getString(13));
					empMaster.setPumpName(empMasterData.rs.getString(14));
					empMaster.setPumpCapacity(empMasterData.rs.getString(15));
					empMaster.setPumpType(empMasterData.rs.getString(16));
					empMaster.setPurYear(empMasterData.rs.getString(17));
					empMaster.setHrRun(empMasterData.rs.getString(18));
					empMaster.setHrSin(empMasterData.rs.getString(19));
					empMaster.setHrMs(empMasterData.rs.getString(20));
					empMaster.setStaExe(empMasterData.rs.getString(21));
					empMaster.setPumpDutyLpm(empMasterData.rs.getString(22));
					empMaster.setPumpDutyHead(empMasterData.rs.getString(23));
					empMaster.setAssetCode(empMasterData.rs.getString(24));
					empMaster.setIfNss(empMasterData.rs.getString(25));
					empMaster.setPumpNo(empMasterData.rs.getString(26));
					empMaster.setStandByPumpCapacity(empMasterData.rs.getString(27));
					empMaster.setStandByPumpNo(empMasterData.rs.getString(28));
					empMaster.setPmpCode(empMasterData.rs.getString(29));
					empMaster.setNumber(empMasterData.rs.getString(30));
					empMaster.setTotal_hp(empMasterData.rs.getString(31));
					empMaster.setStand_by_numbers(empMasterData.rs.getString(32));
					empMaster.setStandby_hp(empMasterData.rs.getString(33));
					
					parameters.add(empMaster);
				}

			}
					

			
			
			else if( (assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03") ) 
					&& assetCompCode.equals("04")	
					&& assetSubCompCode.equals("001")) {
			query = "select OH.OHSR_CODE  as \"OHSR Code\",OH.OHSR_CAP_LTS  as \"OHSR  Capacity In Liters\",OH.OHSR_LOC  as \"OHSR Location \",OH.OHSR_SATGES  as \"OHSR Stages\",OH.OHSR_LWL  as \" OHSR LWL\",OH.OHSR_MWL as \" OHSR MWL \",OH.OHSR_FILL_HR  as \"OHSR Fill in Hours\",OH.OHSR_EMPTY_HR  as \"OHSR Empty in Hours\",OH.ASSET_CODE as \"Asset Code\",OH.OHSR_NO_OF_FILLING,OH.HAB_CODE from "+Tab_Prifix+"OHSR_SC_PARAM_TBL OH,RWS_ASSET_MAST_TBL A where OH.ASSET_CODE=A.ASSET_CODE " 
			    // +"AND A.HAB_CODE='"+ habCode
				//	+ "' and substr(OH.asset_code,7,2)='"
				//	+ assetTypeCode+"'"
					+ " and OH.asset_code='"
					+ assetCode
					+ "'";
			//System.out.println("query is"+query);
			empMasterData.rs =empMasterData.stmt.executeQuery(query);

			

			while (empMasterData.rs.next()) {
				asset_reservoir = new Asset_Reservior();
				asset_reservoir.setHabCode(empMasterData.rs.getString("HAB_CODE"));
				asset_reservoir.setOhsrCode(empMasterData.rs.getString(1));
				asset_reservoir.setOhsrCapacityLts(empMasterData.rs.getString(2));
				asset_reservoir.setOhsrLocation(empMasterData.rs.getString(3));
				asset_reservoir.setOhsrStages(empMasterData.rs.getString(4));
				asset_reservoir.setOhsrLwl(empMasterData.rs.getString(5));
				asset_reservoir.setOhsrMwl(empMasterData.rs.getString(6));
				asset_reservoir.setOhsrFillHrs(empMasterData.rs.getString(7));
				asset_reservoir.setOhsrEmptyHrs(empMasterData.rs.getString(8));
				asset_reservoir.setAssetCode(empMasterData.rs.getString(9));
				asset_reservoir.setNoOfFillings(empMasterData.rs.getString(10));
				parameters.add(asset_reservoir);
			}

		} 
			
		else if( (assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03") )
					&& assetCompCode.equals("04") 
					&& assetSubCompCode.equals("002")) {
				query = "select OH.OHBR_CODE   as \"OHBR Code\",OH.OHBR_CAP_LTS  as \"OHBR  Capacity In Liters\",OH.OHBR_LOC   as \"OHBR Location \",OH.OHBR_SATGES   as \"OHBR Stages\",OH.OHBR_LWL  as \" OHBR LWL\",OH.OHBR_MWL as \" OHBR MWL \",OH.OHBR_FILL_HR  as \"OHBR Fill in Hours\",OH.OHBR_EMPTY_HR   as \"OHBR Empty in Hours\",OH.ASSET_CODE as \"Asset Code\",OH.HAB_CODE from  "+Tab_Prifix+"OHBR_SC_PARAM_TBL OH,RWS_ASSET_MAST_TBL A where OH.ASSET_CODE=A.ASSET_CODE "
				   // +	"AND A.HAB_CODE='"+ habCode+"'"
						
						+ " and OH.asset_code='"
						+ assetCode
						+ "'";

				empMasterData.rs =empMasterData.stmt.executeQuery(query);

				

				while (empMasterData.rs.next()) {
					asset_reservoir = new Asset_Reservior();
					asset_reservoir.setHabCode(empMasterData.rs.getString("HAB_CODE"));
					asset_reservoir.setOhbrCode(empMasterData.rs.getString(1));
					asset_reservoir.setOhbrCapacityLts(empMasterData.rs.getString(2));
					asset_reservoir.setOhbrLocation(empMasterData.rs.getString(3));
					asset_reservoir.setOhbrStages(empMasterData.rs.getString(4));
					asset_reservoir.setOhbrLwl(empMasterData.rs.getString(5));
					asset_reservoir.setOhbrMwl(empMasterData.rs.getString(6));
					asset_reservoir.setOhbrFillHrs(empMasterData.rs.getString(7));
					asset_reservoir.setOhbrEmptyHrs(empMasterData.rs.getString(8));
					asset_reservoir.setAssetCode(empMasterData.rs.getString(9));
					parameters.add(asset_reservoir);
				}

			} 
		
		
		else if( (assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03") ) 
				&& assetCompCode.equals("04")
					&& assetSubCompCode.equals("003")) {
				query = "select GL.GLSR_CODE   as \"GLSR Code\",GL.GLSR_CAP_LTS  as \"GLSR  Capacity In Liters\",GL.GLSR_LOC   as \"GLSR Location \",GL.GLSR_SATGES  as \"GLSR Stages\",GL.GLSR_LWL  as \" GLSR LWL\",GL.GLSR_MWL  as \" GLSR MWL \",GL.GLSR_FILL_HR  as \"GLSR Fill in Hours\",GL.GLSR_EMPTY_HR   as \"GLSR Empty in Hours\",GL.ASSET_CODE as \"Asset Code\",GL.GLSR_NO_OF_FILLING,GL.HAB_CODE from  "+Tab_Prifix+"GLSR_SC_PARAM_TBL GL,RWS_ASSET_MAST_TBL A where GL.ASSET_CODE=A.ASSET_CODE "
				  // +"AND A.HAB_CODE='"+ habCode+"'"
						
						+ " and GL.asset_code='"
						+ assetCode
						+ "'";

				empMasterData.rs =empMasterData.stmt.executeQuery(query);

				

				while (empMasterData.rs.next()) {
					asset_reservoir = new Asset_Reservior();
					asset_reservoir.setHabCode(empMasterData.rs.getString("HAB_CODE"));
					asset_reservoir.setGlsrCode(empMasterData.rs.getString(1));
					asset_reservoir.setGlsrCapacityInLts(empMasterData.rs.getString(2));
					asset_reservoir.setGlsrLocation(empMasterData.rs.getString(3));
					asset_reservoir.setGlsrStages(empMasterData.rs.getString(4));
					asset_reservoir.setGlsrLwl(empMasterData.rs.getString(5));
					asset_reservoir.setGlsrMwl(empMasterData.rs.getString(6));
					asset_reservoir.setGlsrFillHrs(empMasterData.rs.getString(7));
					asset_reservoir.setGlsrEmptyHrs(empMasterData.rs.getString(8));
					asset_reservoir.setAssetCode(empMasterData.rs.getString(9));
					asset_reservoir.setNoOfFillings(empMasterData.rs.getString(10));
					parameters.add(asset_reservoir);
				}

			} else if( (assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03") ) 
					&& assetCompCode.equals("04")
					&& assetSubCompCode.equals("004")) {
				query = "select GL.GLBR_CODE   ,GL.GLBR_CAP_LTS  ,GL.GLBR_LOC   ,GL.GLBR_LWL  ,GL.GLBR_MWL  ,GL.GLBR_FILL_HR  ,GL.GLBR_EMPTY_HR  ,GL.ASSET_CODE,GL.HAB_CODE  from  "+Tab_Prifix+"GLBR_SC_PARAM_TBL GL,RWS_ASSET_MAST_TBL A where GL.ASSET_CODE=A.ASSET_CODE "
				   // +"AND A.HAB_CODE='"+ habCode"'"
						
						+ " and GL.asset_code='"
						+ assetCode
						+ "'";
				//System.out.println("query is "+query);
				empMasterData.rs =empMasterData.stmt.executeQuery(query);
				

				while (empMasterData.rs.next()) {
					asset_reservoir = new Asset_Reservior();
					asset_reservoir.setHabCode(empMasterData.rs.getString("HAB_CODE"));
					asset_reservoir.setGlbrCode(empMasterData.rs.getString(1));
					asset_reservoir.setGlbrCapacityInLts(empMasterData.rs.getString(2));
					//System.out.println("glbr capacity in lts is "+empMasterData.rs.getString(2));
					asset_reservoir.setGlbrLocation(empMasterData.rs.getString(3));
					asset_reservoir.setGlbrLwl(empMasterData.rs.getString(4));
					asset_reservoir.setGlbrMwl(empMasterData.rs.getString(5));
					asset_reservoir.setGlbrFillHrs(empMasterData.rs.getString(6));
					asset_reservoir.setGlbrEmptyHrs(empMasterData.rs.getString(7));
					asset_reservoir.setAssetCode(empMasterData.rs.getString(8));
					parameters.add(asset_reservoir);
				}

			} 
			else if ((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03") )
					&& assetCompCode.equals("04")
					&& assetSubCompCode.equals("005")) {
				query = "select * from  "+Tab_Prifix+"BPT_PARAM_TBL bpt,RWS_ASSET_MAST_TBL A where bpt.ASSET_CODE=A.ASSET_CODE "
				   // +"AND A.HAB_CODE='"+ habCode+"'"
					
						+ " and bpt.asset_code='"
						+ assetCode
						+ "'";
				//System.out.println("query in param  "+query);
				empMasterData.rs =empMasterData.stmt.executeQuery(query);
				//System.out.println("query in bpt "+query);	
				
				while (empMasterData.rs.next()) {
					asset_reservoir = new Asset_Reservior();
					asset_reservoir.setHabCode(empMasterData.rs.getString("HAB_CODE"));
					asset_reservoir.setBptCode(empMasterData.rs.getString("BPT_CODE"));
					asset_reservoir.setBptCapacity(empMasterData.rs.getString("CAPACITY"));
					asset_reservoir.setBptStaging(empMasterData.rs.getString("STAGING"));
					asset_reservoir.setBptMaxwl(empMasterData.rs.getString("BPT_MWL"));
					asset_reservoir.setBptMinwl(empMasterData.rs.getString("BPT_LWL"));
					asset_reservoir.setBptLocation(empMasterData.rs.getString("LOCATION"));
					asset_reservoir.setAssetCode(empMasterData.rs.getString("ASSET_CODE"));
					parameters.add(asset_reservoir);
				}
			} 
			else if( (assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03") ) 
					&& assetCompCode.equals("04")
					&& assetSubCompCode.equals("006")) {
				query = "select * from  "+Tab_Prifix+"CIS_SC_PARAM_TBL CIS,RWS_ASSET_MAST_TBL A where CIS.ASSET_CODE=A.ASSET_CODE "
				    // +"AND A.HAB_CODE='"+ habCode+"'"
					
						+ " and CIS.asset_code='"
						+ assetCode
						+ "'";

				empMasterData.rs =empMasterData.stmt.executeQuery(query);

				while (empMasterData.rs.next()) {
					asset_reservoir = new Asset_Reservior();
					asset_reservoir.setHabCode(empMasterData.rs.getString("HAB_CODE"));
					asset_reservoir.setAssetCode(empMasterData.rs.getString("ASSET_CODE"));
					asset_reservoir.setCisCode(empMasterData.rs.getString("CISSC_CODE"));
					asset_reservoir.setCisLocation(empMasterData.rs.getString("CIS_LOC"));
					asset_reservoir.setCisCapLts(empMasterData.rs.getString("CIS_CAP_LTS"));
					asset_reservoir.setCisCond(empMasterData.rs.getString("CIS_COND"));
					asset_reservoir.setCisPf(empMasterData.rs.getString("CIS_PF"));
					asset_reservoir.setCisPfCond(empMasterData.rs.getString("CIS_PF_CON"));
					asset_reservoir.setCisDrain(empMasterData.rs.getString("CIS_DRAIN"));
					asset_reservoir.setCisTap(empMasterData.rs.getString("CIS_TAP"));
					asset_reservoir.setCisTapCond(empMasterData.rs.getString("CIS_TAP_COND"));
					asset_reservoir.setCisHr(empMasterData.rs.getString("CIS_HR"));
					asset_reservoir.setCisNoOfTaps(empMasterData.rs.getString("CIS_TAP"));
					parameters.add(asset_reservoir);
				}
			}  else if ( (assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03") ) && assetCompCode.equals("02")
					&& assetSubCompCode.equals("001")) {
				/*
				 //@modified by santosh
				 query = "select * from "+Tab_Prifix+"RW_COLLWELL_PARAM_TBL RW,RWS_ASSET_MAST_TBL A where RW.ASSET_CODE=A.ASSET_CODE AND A.HAB_CODE='"
						+ habCode
					
						
						
						
						//+ "' and substr(RW.asset_code,7,2)='"
					//	+ assetTypeCode
						+ "' and RW.asset_code='"
						+ assetCode
						+ "'";
						
				*/	
				query = "select * from "+Tab_Prifix+"RW_COLLWELL_PARAM_TBL RW,RWS_ASSET_MAST_TBL A where RW.ASSET_CODE=A.ASSET_CODE "
				+ " and RW.asset_code='"
				+ assetCode
				+ "'";
					//System.out.println("query in rw collwell "+query);		
				empMasterData.rs =empMasterData.stmt.executeQuery(query);
				empMaster = new EmpMaster();

				while (empMasterData.rs.next()) {
					empMaster = new EmpMaster();
					
					empMaster.setCollectionWellCode(empMasterData.rs.getString("RW_COLLWELL_CODE"));
					empMaster.setHabCode(empMasterData.rs.getString("HAB_CODE"));
					empMaster.setRwDiameter(empMasterData.rs.getString("DIAMETER"));
					empMaster.setRwDepth(empMasterData.rs.getString("DEPTH"));
					empMaster.setRwTypeOfFlooring(empMasterData.rs.getString("TYPE_OF_FLOORING"));
					empMaster.setAssetCode(empMasterData.rs.getString("ASSET_CODE"));
					empMaster.setRwCapacity(empMasterData.rs.getString("CAPACITY"));
					empMaster.setRwLocation(empMasterData.rs.getString("LOCATION"));
					parameters.add(empMaster);
				}
			} else if ((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03") ) 
					&& assetCompCode.equals("02")
					&& (assetSubCompCode.equals("002") )) {
				

				//System.out.println("query in param  "+query);	
				query = "select * from "
					+Tab_Prifix+"SS_SC_PARAM_TBL SS,RWS_ASSET_MAST_TBL A where SS.ASSET_CODE=A.ASSET_CODE "
					//  +"AND A.HAB_CODE='"+ habCode
					//	+ "' and substr(SS.asset_code,7,2)='"
					//	+ assetTypeCode+"'"
						+ " and SS.asset_code='"
						+ assetCode
						+ "'";
				//System.out.println("query in param*******  "+query);		
				empMasterData.rs =empMasterData.stmt.executeQuery(query);
				

				while (empMasterData.rs.next()) {
					empMaster = new EmpMaster();
					empMaster.setAssetCode(empMasterData.rs.getString("ASSET_CODE"));
					empMaster.setSsTankCode(empMasterData.rs.getString("SSSC_CODE"));
					empMaster.setHabCode(empMasterData.rs.getString("HAB_CODE"));
					empMaster.setSsSize(empMasterData.rs.getString("SS_SIZE"));
					empMaster.setSsCapacityDays(empMasterData.rs.getString("CAPACITY_DAYS"));
					empMaster.setSsCapacityMcum(empMasterData.rs.getString("CAPACITY_MCUM"));
					empMaster.setSsTankAdeq(empMasterData.rs.getString("TANK_ADEQACY"));
					empMaster.setSsTankLocation(empMasterData.rs.getString("LOCATION"));
					empMaster.setSsDepth(empMasterData.rs.getFloat("DEPTH"));
					//empMaster.setSsTankYield(empMasterData.rs.getString("YIELD_CUM"));
					/*if (empMasterData.rs.getString("YIELD_TEST_DT") != null)
						empMaster.setSsTankYieldDate(df.format(empMasterData.rs.getString("YIELD_TEST_DT")));*/
					//empMaster.setSsTankYieldDate(empMasterData.rs.getString("YIELD_TEST_DT"));
					empMaster.setPowerConn(empMasterData.rs.getString("POWER_CON"));
					empMaster.setPowerConnOthers(empMasterData.rs.getString("OTHERS"));
					empMaster.setPowerHours(empMasterData.rs.getString("POWER_HRS"));
					parameters.add(empMaster);
				}
			} else if ((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03") ) 
					&& assetCompCode.equals("02")
					&& assetSubCompCode.equals("003")) {
				query = "select  SS.ASSET_CODE,WTPSC_CODE ,WTP_TYPW ,WTP_MLD,UNITS_NO," 
						+"WTP_SIZE,UNITS_STANDBY,FREQ_SAND_SCRAP,PERFORMANCE, "
						+"USE_CAPACITYMLD,EXTENTION_SCOPE,SS.LOCATION ,CHK_FILTER," 
						+"nvl(RATE_OF_FILTRATION,0)RATE_OF_FILTRATION,SS.HAB_CODE "
						+" from "+Tab_Prifix+"WTP_SC_PARAM_TBL SS,RWS_ASSET_MAST_TBL A where SS.ASSET_CODE=A.ASSET_CODE " 
				     // +"AND A.HAB_CODE='"	+ habCode
					//	+ "' and substr(SS.asset_code,7,2)='"
					//	+ assetTypeCode+"'"
						+ " and SS.asset_code='"
						+ assetCode
						+ "' and SS.WTP_TYPW='SSF'";
				//System.out.println("query in param  "+query);
				empMasterData.rs =empMasterData.stmt.executeQuery(query);
				

				while (empMasterData.rs.next()) {
					empMaster = new EmpMaster();
					empMaster.setAssetCode(empMasterData.rs.getString("ASSET_CODE"));
					empMaster.setWtpCode(empMasterData.rs.getString("WTPSC_CODE"));
					empMaster.setHabCode(empMasterData.rs.getString("HAB_CODE"));
					empMaster.setWtpType(empMasterData.rs.getString("WTP_TYPW"));
					empMaster.setWtpMld(empMasterData.rs.getString("WTP_MLD"));
					empMaster.setWtpUnits(empMasterData.rs.getString("UNITS_NO"));
					empMaster.setWtpRateOfFiltration(empMasterData.rs.getDouble("RATE_OF_FILTRATION"));
					//+"");
					//System.out.println("value is '"+format(empMasterData.rs.getString("RATE_OF_FILTRATION"))+"'");
					empMaster.setWtpSize(empMasterData.rs.getString("WTP_SIZE"));
					empMaster.setWtpUnitsStandby(empMasterData.rs.getString("UNITS_STANDBY"));
					//empMaster.setWtpBackwashFreq(empMasterData.rs.getString("BACKWASH_FEQ"));
					empMaster.setWtpPerformance(empMasterData.rs.getString("PERFORMANCE"));
					empMaster.setWtpCapacityUse(empMasterData.rs.getString("USE_CAPACITYMLD"));
					empMaster.setWtpExtentionScope(empMasterData.rs.getString("EXTENTION_SCOPE"));
					empMaster.setWtpLocation(empMasterData.rs.getString("LOCATION"));
					empMaster.setWtpFreqSandScrap(empMasterData.rs.getInt("FREQ_SAND_SCRAP"));
					String chkFilter=empMasterData.rs.getString("CHK_FILTER");
					
					if(chkFilter.substring(0,2).equals("01"))
					{
					empMaster.setWtpSedimentationTank(true);
					empMaster.setWtpHorizontalRoughingFilterValue("01");
					//System.out.println("s1 set");
					}
					if(chkFilter.substring(2,4).equals("02"))
					{
					empMaster.setWtpHorizontalRoughingFilter(true);
					empMaster.setWtpHorizontalRoughingFilterValue("02");
					//System.out.println("s2 set");
					}
					if(chkFilter.substring(4,6).equals("03"))
					{
					empMaster.setWtpVerticalRoughingFilterValue("03");
					empMaster.setWtpVerticalRoughingFilter(true);
					//System.out.println("s3 set");
					}
					parameters.add(empMaster);
				}
			}

			else if ((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03") ) 
					&& assetCompCode.equals("02")
					&& assetSubCompCode.equals("004")) {
				query = "select * from "+Tab_Prifix+"WTP_SC_PARAM_TBL SS,RWS_ASSET_MAST_TBL A where SS.ASSET_CODE=A.ASSET_CODE " 
				    //  +"AND A.HAB_CODE='"	+ habCode
					//	+ "' and substr(SS.asset_code,7,2)='"
						//+ assetTypeCode+"'"
						+ " and SS.asset_code='"
						+ assetCode
						+ "' and SS.WTP_TYPW='RSF'";
				//System.out.println("query in param  "+query);
				empMasterData.rs =empMasterData.stmt.executeQuery(query);
				

				while (empMasterData.rs.next()) {
					empMaster = new EmpMaster();
					empMaster.setAssetCode(empMasterData.rs.getString("ASSET_CODE"));
					empMaster.setWtpCode(empMasterData.rs.getString("WTPSC_CODE"));
					empMaster.setHabCode(empMasterData.rs.getString("HAB_CODE"));
					empMaster.setWtpType(empMasterData.rs.getString("WTP_TYPW"));
					empMaster.setWtpMld(empMasterData.rs.getString("WTP_MLD"));
					empMaster.setWtpUnits(empMasterData.rs.getString("UNITS_NO"));
					empMaster.setWtpRateOfFiltration(empMasterData.rs.getDouble("RATE_OF_FILTRATION"));
					empMaster.setWtpSize(empMasterData.rs.getString("WTP_SIZE"));
					empMaster.setWtpUnitsStandby(empMasterData.rs.getString("UNITS_STANDBY"));
					empMaster.setWtpBackwashFreq(empMasterData.rs.getString("BACKWASH_FEQ"));
					empMaster.setWtpPerformance(empMasterData.rs.getString("PERFORMANCE"));
					empMaster.setWtpCapacityUse(empMasterData.rs.getString("USE_CAPACITYMLD"));
					empMaster.setWtpExtentionScope(empMasterData.rs.getString("EXTENTION_SCOPE"));
					empMaster.setWtpLocation(empMasterData.rs.getString("LOCATION"));
					String chkFilter=empMasterData.rs.getString("CHK_FILTER");
					if(chkFilter.substring(0,2).equals("01"))
					{
					empMaster.setWtpClarifloculatorValue("01");
					empMaster.setWtpClarifloculator(true);
					}
					parameters.add(empMaster);
				}
			} else if ((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03") ) 
					&& assetCompCode.equals("02")
					&& assetSubCompCode.equals("005")) {
				query = "select * from "+Tab_Prifix+"SUMP_M_SC_PARAM_TBL SP,RWS_ASSET_MAST_TBL A where SP.ASSET_CODE=A.ASSET_CODE " 
				     // +"AND A.HAB_CODE='"+ habCode
					//	+ "' and substr(SP.asset_code,7,2)='"
					//	+ assetTypeCode+"'"
						+ " and SP.asset_code='"
						+ assetCode
						+ "'";
				//System.out.println("query in param  "+query);
				empMasterData.rs =empMasterData.stmt.executeQuery(query);
				
				while (empMasterData.rs.next()) {
					empMaster = new EmpMaster();
					empMaster.setAssetCode(empMasterData.rs.getString("ASSET_CODE"));
					empMaster.setSumpCode(empMasterData.rs.getString("SUMPCODE"));
					empMaster.setHabCode(empMasterData.rs.getString("HAB_CODE"));
					empMaster.setSumpType(empMasterData.rs.getString("SUMP_TYPE"));
					empMaster.setSumpCapacity(empMasterData.rs.getString("SUMP_CAPACITY"));
					empMaster.setSumpFillHr(empMasterData.rs.getString("FILLING_HR"));
					empMaster.setSumpEmptyHr(empMasterData.rs.getString("EMPTY_TIME_HR"));
					empMaster.setSumpCondition(empMasterData.rs.getString("SUMP_CONDITION"));
					empMaster.setSumpLocation(empMasterData.rs.getString("LOCATION"));
					empMaster.setSumpMadeOf(empMasterData.rs.getString("SUMP_MADE_OF"));
					empMaster.setSumpDiameter(empMasterData.rs.getFloat("SUMP_DIAMETER"));
					empMaster.setSumpDepth(empMasterData.rs.getFloat("SUMP_DEPTH"));
					parameters.add(empMaster);
				}
			} else if ((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03") ) 
					&& assetCompCode.equals("02")
					&& assetSubCompCode.equals("006")) {
				query = "select * from "+Tab_Prifix+"FP_BRIDGE_PARAM_TBL FP,RWS_ASSET_MAST_TBL A where FP.ASSET_CODE=A.ASSET_CODE " 
			           //	+"AND A.HAB_CODE='"+ habCode
						//+ "' and substr(FP.asset_code,7,2)='"
						//+ assetTypeCode+"'"
						+ " and FP.asset_code='"
						+ assetCode
						+ "'";
				//System.out.println("query in param  "+query);
				empMasterData.rs =empMasterData.stmt.executeQuery(query);
				
				while (empMasterData.rs.next()) {
					empMaster = new EmpMaster();
					empMaster.setBridgeCode(empMasterData.rs.getString("BRIDGE_CODE"));
					empMaster.setHabCode(empMasterData.rs.getString("HAB_CODE"));
					//empMaster.setBridgeType(empMasterData.rs.getString("BRIDGE_TYPE"));
					empMaster.setBridgeLength(empMasterData.rs.getString("BRIDGE_LENGTH"));
					empMaster.setBridgeWidth(empMasterData.rs.getString("BRIDGE_WIDTH"));
					//empMaster.setBridgeWalkwaywidth(empMasterData.rs
							//.getString("BRIDGE_WALK_WAY_WIDTH"));
					//empMaster.setBridgeSpanLength(empMasterData.rs
							//.getString("BRIDGE_SPAN_LENGTH"));
					empMaster.setAssetCode(empMasterData.rs.getString("ASSET_CODE"));
					parameters.add(empMaster);
				}
			} else if ((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03") ) 
					&& assetCompCode.equals("02")
					&& assetSubCompCode.equals("007")) {
				query = "select * from "+Tab_Prifix+"PUMPHOUSE_PARAM_TBL  PH,RWS_ASSET_MAST_TBL A where PH.ASSET_CODE=A.ASSET_CODE "
				    // +"AND A.HAB_CODE='"+ habCode
					//	+ "' and substr(PH.asset_code,7,2)='"
					//	+ assetTypeCode+"'"
						+ " and PH.asset_code='"
						+ assetCode
						+ "'";
				//System.out.println("query in param  "+query);
				empMasterData.rs =empMasterData.stmt.executeQuery(query);
				
				while (empMasterData.rs.next()) {
					empMaster = new EmpMaster();
					empMaster.setHabCode(empMasterData.rs.getString("HAB_CODE"));
					empMaster.setPumpHouseType(empMasterData.rs.getString("TYPE"));
					empMaster.setPumpHouseArea(empMasterData.rs.getString("AREA"));
					empMaster.setPumpHouseHeight(empMasterData.rs.getString("HEIGHT"));
					empMaster.setAssetCode(empMasterData.rs.getString("ASSET_CODE"));
					empMaster.setPumpHouseCode(empMasterData.rs.getString("PUMPHOUSE_CODE"));
					empMaster.setPumpHouseLocation(empMasterData.rs.getString("LOCATION"));
					parameters.add(empMaster);
				}
			} else if ((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03") ) 
					&& assetCompCode.equals("02")
					&& assetSubCompCode.equals("008")) {
				query = "select * from "+Tab_Prifix+"WATCHMAN_PARAM_TBL WQ,RWS_ASSET_MAST_TBL A where WQ.ASSET_CODE=A.ASSET_CODE "
				    // +"AND A.HAB_CODE='"+ habCode
					//	+ "' and substr(WQ.asset_code,7,2)='"
					//	+ assetTypeCode+"'"
						+ " and WQ.asset_code='"
						+ assetCode
						+ "'";
				//System.out.println("query in param  "+query);
				empMasterData.rs =empMasterData.stmt.executeQuery(query);
				
				while (empMasterData.rs.next()) {
					empMaster = new EmpMaster();
					empMaster.setHabCode(empMasterData.rs.getString("HAB_CODE"));
					empMaster.setWatchManLocation(format(empMasterData.rs.getString("LOCATION")));
					empMaster.setWatchManType(empMasterData.rs.getString("TYPE"));
					empMaster.setWatchManArea(empMasterData.rs.getString("AREA"));
					empMaster.setWatchManNoOfQuarters(empMasterData.rs
							.getString("NO_OF_QTRS"));
					empMaster.setAssetCode(empMasterData.rs.getString("ASSET_CODE"));
					empMaster.setWatchManCode(empMasterData.rs.getString("WATCHMAN_CODE"));
					parameters.add(empMaster);
				}
			} else if ((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03") ) 
					&& assetCompCode.equals("02")
					&& assetSubCompCode.equals("009")) {
				query = "select * from "+Tab_Prifix+"CW_COLLWELL_PARAM_TBL CW,RWS_ASSET_MAST_TBL A where CW.ASSET_CODE=A.ASSET_CODE "
				    // +"AND A.HAB_CODE='"+ habCode
					//	+ "' and substr(CW.asset_code,7,2)='"
					//	+ assetTypeCode+"'"
						+ " and CW.asset_code='"
						+ assetCode
						+ "'";
				//System.out.println("query in param  "+query);
				empMasterData.rs =empMasterData.stmt.executeQuery(query);
				
				//System.out.println("executed query");
				while (empMasterData.rs.next()) {
					//System.out.println("in while");
					empMaster = new EmpMaster();
					empMaster.setCollectionWellCode(empMasterData.rs
							.getString("CW_COLLWELL_CODE"));
					empMaster.setHabCode(empMasterData.rs.getString("HAB_CODE"));
					//System.out.println("location");
					empMaster.setRwLocation(empMasterData.rs.getString("LOCATION"));
					//System.out.println("assigning double value");
					empMaster.setRwCapacity(empMasterData.rs.getString("CAPACITY"));
					//System.out.println("printing capacity");
					//System.out.println("capacity is "+empMaster.getRwCapacity());
					empMaster.setRwDiameter(empMasterData.rs.getString("DIAMETER"));
					empMaster.setRwDepth(empMasterData.rs.getString("DEPTH"));
					empMaster.setRwTypeOfFlooring(empMasterData.rs.getString("TYPE_OF_FLOORING"));
					empMaster.setAssetCode(empMasterData.rs.getString("ASSET_CODE"));
					parameters.add(empMaster);
				}
			}
			
			//@author santosh code added on 281106
			/*else if( (assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03") ) 
					&& assetCompCode.equals("01") 
					&& assetSubCompCode.equals("009"))
			{	
				//System.out.println("in EmpMaster pumpset 009");
				query="select * from  "+Tab_Prifix+"PM_SC_PARAM_TBL CP,RWS_ASSET_MAST_TBL A where CP.ASSET_CODE=A.ASSET_CODE AND A.HAB_CODE='"+habCode+"'  and CP.asset_code='"+assetCode+"'";
				//System.out.println("the query is"+query);
				empMasterData.rs=empMasterData.stmt.executeQuery(query);
				
		       	 while(empMasterData.rs.next())
		    	 {		    		 
		       	 	empMaster = new EmpMaster();
		       	 	empMaster.setAssetCode(empMasterData.rs.getString(1));
		       	     empMaster.setPmMat(empMasterData.rs.getString(2));
		     	 	 empMaster.setPmCla(empMasterData.rs.getString(3));
		     	 	 empMaster.setPmDia(empMasterData.rs.getString(4));
		     	 	 empMaster.setPmLen(empMasterData.rs.getString(5));
		     	 	 empMaster.setPmCond(empMasterData.rs.getString(6));
		     	 	 empMaster.setPmRep(empMasterData.rs.getString(7));
		     	 	 empMaster.setPmNat(empMasterData.rs.getString(8));
		     	 	 empMaster.setPmNatLoc(empMasterData.rs.getString(9));
		     	 	 empMaster.setPmAvNo(empMasterData.rs.getString(10));
		     	 	 empMaster.setPmAvConG(empMasterData.rs.getString(11));
		     	 	 empMaster.setPmAvConB(empMasterData.rs.getString(12));
		     	 	 empMaster.setPmAvConNr(empMasterData.rs.getString(13));
		     	 	 empMaster.setPmAvConCp(empMasterData.rs.getString(14));
		     	 	 empMaster.setPmScrvNo(empMasterData.rs.getString(15));		
		     	 	 empMaster.setPmScrvCondG(empMasterData.rs.getString(16));
		     	 	 empMaster.setPmScrvCondB(empMasterData.rs.getString(17));
		     	 	 empMaster.setPmScrvCondNr(empMasterData.rs.getString(18));
		     	 	 empMaster.setPmScrvCondCp(empMasterData.rs.getString(19));
		     	 	 empMaster.setPmSvNo(empMasterData.rs.getString(20));
		     	 	 empMaster.setPmSvCondG(empMasterData.rs.getString(21));
		     	 	 empMaster.setPmSvCondB(empMasterData.rs.getString(22));
		     	 	 empMaster.setPmSvCondNr(empMasterData.rs.getString(23));
		     	 	 empMaster.setPmSvCondCp(empMasterData.rs.getString(24));
		     	 	 empMaster.setPmRvNo (empMasterData.rs.getString(25));
		     	 	 empMaster.setPmRvCondG(empMasterData.rs.getString(26));
		     	 	 empMaster.setPmRvCondB(empMasterData.rs.getString(27));
		     	 	 empMaster.setPmRvCondNr(empMasterData.rs.getString(28));
		     	 	 empMaster.setPmRvCondCp (empMasterData.rs.getString(29));
		     	 	 empMaster.setSsNo (empMasterData.rs.getString(30));
		     	 	 empMaster.setNoOfPipes(empMasterData.rs.getString(31));
		     	 	empMaster.setPmCode(empMasterData.rs.getString(32));
					 parameters.add(empMaster);	 
			     }
			 }*/
			
			//@end
			else if( (assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03") ) 
					&& assetCompCode.equals("03") 
					&& assetSubCompCode.equals("001"))
			{	
				query="select * from  "+Tab_Prifix+"PUMPINGMAIN_TBL CP,RWS_ASSET_MAST_TBL A where CP.ASSET_CODE=A.ASSET_CODE AND A.HAB_CODE='"+habCode+"'  and CP.asset_code='"+assetCode+"' order by PUMPINGMAIN_CODE";
				//System.out.println("the query is"+query);
				empMasterData.rs=empMasterData.stmt.executeQuery(query);
				
		       	 while(empMasterData.rs.next())
		    	 {		    		 
		       	 	empMaster = new EmpMaster();
		       	 
			       	empMaster.setAssetCode(empMasterData.rs.getString("ASSET_CODE"));
			       	empMaster.setPmCode(empMasterData.rs.getString("PUMPINGMAIN_CODE"));
			       	empMaster.setHabCode(empMasterData.rs.getString("HAB_CODE"));
			       	empMaster.setPmLen(empMasterData.rs.getString("LENGTH"));
			       	empMaster.setPmAvNo(empMasterData.rs.getString("AIRVALVE_NO"));
			       	empMaster.setPmScrvNo(empMasterData.rs.getString("SCOUREVALVE"));		
			       	empMaster.setPmRvNo (empMasterData.rs.getString("REFLEXVALVE"));
			       	empMaster.setPmSvNo(empMasterData.rs.getString("SLUICEVALVE"));
			       	empMaster.setNoOfPipes(getNoOfPipeTypes(dataSource,"01","001",empMasterData.rs.getString("PUMPINGMAIN_CODE"))+"");
			       	//empMaster.setNoOfPipes(empMasterData.rs.getString("NO_OF_PIPES"));
			       	empMaster.setPmZeroVelocityValve(empMasterData.rs.getString("ZERO_VELOCITY_VALVE"));
			       	empMaster.setPmAirCusionValve(empMasterData.rs.getString("AIR_CUSHION_VALVE"));
			     	empMaster.setPmLocation(empMasterData.rs.getString("LOCATION"));
		     	 	 
					 parameters.add(empMaster);	 
			     }
			 }
			else if( (assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03") ) 
					&& assetCompCode.equals("03")
					&& assetSubCompCode.equals("002")) {
				//System.out.println("in EmpMaster getting data 03 002");
				query = "select * from  "+Tab_Prifix+"GRAVITYMAIN_TBL GM,RWS_ASSET_MAST_TBL A where GM.ASSET_CODE=A.ASSET_CODE " 
					  //+	"AND A.HAB_CODE='"+ habCode+"'"
					  + " and GM.asset_code='"
					  + assetCode
					  + "' order by GRAVITYMAIN_CODE";
				//System.out.println("query in gravity main is  " + query);
				empMasterData.rs =empMasterData.stmt.executeQuery(query);

				while (empMasterData.rs.next()) {
					empMaster = new EmpMaster();
					empMaster.setAssetCode(empMasterData.rs.getString("ASSET_CODE"));
					empMaster.setGravitymain_code(empMasterData.rs
							.getString("GRAVITYMAIN_CODE"));
				    //empMaster.setLengths(empMasterData.rs.getString("LENGTH"));
					//empMaster.setMet_type(empMasterData.rs.getString("MET_TYPE"));
					empMaster.setHabCode(empMasterData.rs.getString("hab_code"));
					
					empMaster.setAirvalve_no(empMasterData.rs.getString("AIRVALVE_NO"));
					empMaster.setNoOfPipes(getNoOfPipeTypes(dataSource,"01","002",empMasterData.rs.getString("GRAVITYMAIN_CODE"))+"");
					
					empMaster.setScourevalve(empMasterData.rs.getString("SCOUREVALVE"));
					
					empMaster.setReflexvalve(empMasterData.rs.getString("REFLEXVALVE"));
					
					empMaster.setSluicevalve(empMasterData.rs.getString("SLUICEVALVE"));
					empMaster.setGravitymain_location(empMasterData.rs.getString("LOCATION"));
					empMaster.setLengths(empMasterData.rs.getString("LENGTH"));
					
					parameters.add(empMaster);

				}
			}
			else if( (assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03") ) 
					&& assetCompCode.equals("03")
					&& assetSubCompCode.equals("003")) {
				query = "select * from  "+Tab_Prifix+"DISTRI_SC_PARAM_TBL DIS,RWS_ASSET_MAST_TBL A where DIS.ASSET_CODE=A.ASSET_CODE " 
					 // +	"AND A.HAB_CODE='"+ habCode+"'"
					  + " and DIS.asset_code='"+ assetCode+"' order by DISTRISC_CODE";
				//System.out.println("in distributin query is " + query);
				empMasterData.rs =empMasterData.stmt.executeQuery(query);
				//empMaster = new EmpMaster();

				while (empMasterData.rs.next()) {
				
					asset_pipeline = new Asset_PipeLine();
					asset_pipeline.setAssetCode(empMasterData.rs.getString("ASSET_CODE"));
					asset_pipeline.setHabCode(empMasterData.rs.getString("HAB_CODE"));
					asset_pipeline.setNoOfPipes(getNoOfPipeTypes(dataSource,"01","003",empMasterData.rs.getString("DISTRISC_CODE"))+"");
					//asset_pipeline.setDisMaterial(empMasterData.rs.getString("DIS_MAT"));
					//asset_pipeline.setDisClass(empMasterData.rs.getString("DIS_CLA"));
					//asset_pipeline.setDisDiameter(empMasterData.rs.getString("DIS_DIA"));
					
					asset_pipeline.setDisLengths(empMasterData.rs.getInt("DIS_LEN")+"");
					asset_pipeline.setDisFullVillagesCovered(empMasterData.rs.getString("DIS_COVE"));
					asset_pipeline.setDisTotalLengthNeeded(empMasterData.rs.getFloat("DIS_LN")+"");
					asset_pipeline.setDisTotalLengthProvided(empMasterData.rs.getFloat("DIS_TLC")+"");
					asset_pipeline.setDisBalanceNeeded(empMasterData.rs.getFloat("DIS_BN")+"");
					asset_pipeline.setDisCode(empMasterData.rs.getString("DISTRISC_CODE"));
    				asset_pipeline.setDisMaterialCode(empMasterData.rs.getString("DIS_MAT_CODE"));
    				asset_pipeline.setDisNoOfPipes(empMasterData.rs.getInt("NO_OF_PIPES")+"");
    				
    				asset_pipeline.setDisNoOfAirValves(empMasterData.rs.getInt("NO_AIRVALVES")+"");
    				asset_pipeline.setDisNoOfScourValves(empMasterData.rs.getInt("NO_SCOURVALVES")+"");
    				asset_pipeline.setDisNoOfSluiceValves(empMasterData.rs.getInt("NO_SLUICEVALVES")+"");
    				asset_pipeline.setDisNoOfPrivateHouseConnections(empMasterData.rs.getInt("NO_PR_HC")+"");
    				asset_pipeline.setDisLocation(empMasterData.rs.getString("LOCATION"));
    				
    				asset_pipeline.setDisNoOfStandPosts(empMasterData.rs.getInt("NO_STANDPOSTS")+"");
    				
					parameters.add(asset_pipeline);
				}
			}
			

		
		
			

		} catch (Exception e) {
			//System.out.println("the error in getAssetSubCompParams= " + e);
		} finally {
			empMasterData.closeAll();
		}
		return parameters;
	}

	/*
	 * 
	 * @author sadiq
	 * 
	 * TODO To change the template for this generated type comment go to Window -
	 * Preferences - Java - Code Style - Code Templates
	 */
	/*
	 * public static ArrayList setAssetSubCompParamsValuesToform( DataSource
	 * dataSource, ArrayList assetsubCompBWParams) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
	 * 
	 * EmpMaster empMaster = null; //System.out.println("size in assetbw " +
	 * assetsubCompBWParams.size()); String[] record1 = (String[])
	 * assetsubCompBWParams.get(0);
	 * //System.out.println("sizeiiiiiiiiiiiiiiiiiiiiii " + record1[0]);
	 * 
	 * ArrayList parameters = new ArrayList(); empMaster = new EmpMaster();
	 * //System.out.println("/////////// " + record1[28]);
	 * empMaster.setPopDes(record1[0]); empMaster.setSource(record1[1]);
	 * empMaster.setSourceQuality(record1[2]);
	 * empMaster.setSourceYield(record1[3]);
	 * empMaster.setSourceDepend(record1[4]);
	 * empMaster.setSourceDepth(record1[5]);
	 * empMaster.setSourceDiameter(record1[6]);
	 * empMaster.setSourceCondition(record1[7]);
	 * empMaster.setSourceSwl(record1[8]); empMaster.setSourceNwl(record1[9]);
	 * empMaster.setPhSize(record1[10]); empMaster.setPhCondition(record1[11]);
	 * empMaster.setPhType(record1[12]); empMaster.setPumpName(record1[13]);
	 * empMaster.setPumpCapacity(record1[14]);
	 * empMaster.setPumpType(record1[15]); empMaster.setPurYear(record1[16]);
	 * empMaster.setHrRun(record1[17]); empMaster.setHrSin(record1[18]);
	 * empMaster.setHrMs(record1[19]); empMaster.setStaExe(record1[20]);
	 * empMaster.setPumpDutyLpm(record1[21]);
	 * empMaster.setPumpDutyHead(record1[22]);
	 * empMaster.setAssetCode(record1[23]); empMaster.setIfNss(record1[24]);
	 * empMaster.setPumpNo(record1[25]);
	 * empMaster.setStandByPumpCapacity(record1[26]);
	 * empMaster.setStandByPumpNo(record1[27]);
	 * empMaster.setPmpCode(record1[28]); parameters.add(empMaster); return
	 * parameters; }
	 */

	//	 create the link between mandal and subdivision
	public static int insertMandalSubDivision(EmpMaster empMaster,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			if (getMandalSubDivisionCount(empMaster.getCoc(), empMaster
					.getDoc(), empMaster.getSdoc(), empMaster.getDistrict(),
					empMaster.getMandal(), "", empMasterData.conn) != 1) {
				empMasterData.stmt = empMasterData.conn.createStatement();
				rowCount = empMasterData.stmt
						.executeUpdate("insert into rws_mandal_subdivision_tbl values("
								+ "'"
								+ empMaster.getCoc()
								+ "',"
								+ "'"
								+ empMaster.getDoc()
								+ "',"
								+ "'"
								+ empMaster.getSdoc()
								+ "',"
								+ "'"
								+ empMaster.getDistrict()
								+ "',"
								+ "'"
								+ empMaster.getMandal() + "')");
			} else
				errorMessage = "This Mandal Already Mapped To Another Sub Division";
		} catch (Exception e) {
			//System.out.println("The error in insertMandalSubDivision" + e);
		} finally {
			empMasterData.closeAll();
		}
		//System.out.println("row count in save=" + rowCount);
		return rowCount;
	}

	public static ArrayList getMandalSubDivisions(DataSource dataSource,
			String dcode) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList mandalSubdivisions = new ArrayList();
		

		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			if (dcode == null)
				empMasterData.rs =empMasterData.stmt
						.executeQuery("SELECT CO.CIRCLE_OFFICE_CODE,CO.CIRCLE_OFFICE_NAME,DO.DIVISION_OFFICE_CODE,"
								+ "DO.DIVISION_OFFICE_NAME,SDO.SUBDIVISION_OFFICE_CODE,SDO.SUBDIVISION_OFFICE_NAME,"
								+ "D.DCODE,D.DNAME,M.MCODE,M.MNAME FROM RWS_CIRCLE_OFFICE_TBL CO,RWS_DIVISION_OFFICE_TBL DO,"
								+ "RWS_SUBDIVISION_OFFICE_TBL SDO,RWS_DISTRICT_TBL D,RWS_MANDAL_TBL M,RWS_MANDAL_SUBDIVISION_TBL MS WHERE CO.CIRCLE_OFFICE_CODE=MS.CIRCLE_OFFICE_CODE AND CO.HEAD_OFFICE_CODE=1 AND DO.DIVISION_OFFICE_CODE=MS.DIVISION_OFFICE_CODE AND DO.CIRCLE_OFFICE_CODE=MS.CIRCLE_OFFICE_CODE AND SDO.SUBDIVISION_OFFICE_CODE=MS.SUBDIVISION_OFFICE_CODE AND SDO.CIRCLE_OFFICE_CODE=MS.CIRCLE_OFFICE_CODE AND SDO.DIVISION_OFFICE_CODE=MS.DIVISION_OFFICE_CODE AND D.DCODE=MS.DCODE AND M.MCODE=MS.MCODE AND M.DCODE=MS.DCODE ORDER BY MS.CIRCLE_OFFICE_CODE");
			else
				empMasterData.rs =empMasterData.stmt
						.executeQuery("SELECT CO.CIRCLE_OFFICE_CODE,CO.CIRCLE_OFFICE_NAME,DO.DIVISION_OFFICE_CODE,"
								+ "DO.DIVISION_OFFICE_NAME,SDO.SUBDIVISION_OFFICE_CODE,SDO.SUBDIVISION_OFFICE_NAME,"
								+ "D.DCODE,D.DNAME,M.MCODE,M.MNAME FROM RWS_CIRCLE_OFFICE_TBL CO,RWS_DIVISION_OFFICE_TBL DO,"
								+ "RWS_SUBDIVISION_OFFICE_TBL SDO,RWS_DISTRICT_TBL D,RWS_MANDAL_TBL M,RWS_MANDAL_SUBDIVISION_TBL MS WHERE MS.DCODE='"
								+ dcode
								+ "' and CO.CIRCLE_OFFICE_CODE=MS.CIRCLE_OFFICE_CODE AND CO.HEAD_OFFICE_CODE=1 AND DO.DIVISION_OFFICE_CODE=MS.DIVISION_OFFICE_CODE AND DO.CIRCLE_OFFICE_CODE=MS.CIRCLE_OFFICE_CODE AND SDO.SUBDIVISION_OFFICE_CODE=MS.SUBDIVISION_OFFICE_CODE AND SDO.CIRCLE_OFFICE_CODE=MS.CIRCLE_OFFICE_CODE AND SDO.DIVISION_OFFICE_CODE=MS.DIVISION_OFFICE_CODE AND D.DCODE=MS.DCODE AND M.MCODE=MS.MCODE AND M.DCODE=MS.DCODE ORDER BY MS.CIRCLE_OFFICE_CODE");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setCoc(empMasterData.rs.getString(1));
				empMaster.setCon(empMasterData.rs.getString(2));
				empMaster.setDoc(empMasterData.rs.getString(3));
				empMaster.setDon(empMasterData.rs.getString(4));
				empMaster.setSdoc(empMasterData.rs.getString(5));
				empMaster.setSdon(empMasterData.rs.getString(6));
				empMaster.setDcode(empMasterData.rs.getString(7));
				empMaster.setDname(empMasterData.rs.getString(8));
				empMaster.setMandalCode(empMasterData.rs.getString(9));
				empMaster.setMandalName(empMasterData.rs.getString(10));
				mandalSubdivisions.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("THE ERROR IS IN getMandalSubDivisions="
					+ e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return mandalSubdivisions;
	}

	public static EmpMaster getMandalSubdivision(String coc, String doc,
			String sdoc, String dcode, String mcode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		String query = null;
		try {
			empMasterData.conn = dataSource.getConnection();
			//empMasterData.stmt = empMasterData.conn.createStatement();
			
			query = "SELECT CO.CIRCLE_OFFICE_CODE,CO.CIRCLE_OFFICE_NAME,DO.DIVISION_OFFICE_CODE,"
							+ "DO.DIVISION_OFFICE_NAME,SDO.SUBDIVISION_OFFICE_CODE,SDO.SUBDIVISION_OFFICE_NAME,"
							+ "D.DCODE,D.DNAME,M.MCODE,M.MNAME FROM RWS_CIRCLE_OFFICE_TBL CO,RWS_DIVISION_OFFICE_TBL DO,"
							+ "RWS_SUBDIVISION_OFFICE_TBL SDO,RWS_DISTRICT_TBL D,RWS_MANDAL_TBL M," +
							"RWS_MANDAL_SUBDIVISION_TBL MS WHERE CO.CIRCLE_OFFICE_CODE=?" +
							" AND CO.HEAD_OFFICE_CODE=1 AND DO.DIVISION_OFFICE_CODE=? AND DO.CIRCLE_OFFICE_CODE=? " +
							"AND SDO.SUBDIVISION_OFFICE_CODE=? AND SDO.CIRCLE_OFFICE_CODE=? AND " +
							"SDO.DIVISION_OFFICE_CODE=? AND D.DCODE=? AND M.MCODE=? AND M.DCODE=?";
			ps = empMasterData.conn.prepareStatement(query);
			ps.setString(1,coc);
			ps.setString(2,doc);
			ps.setString(3,coc);
			ps.setString(4,sdoc);
			ps.setString(5,coc);
			ps.setString(6,doc);
			ps.setString(7,dcode);
			ps.setString(8,mcode);
			ps.setString(9,dcode);
			//System.out.println("query is  "+query);
			
			empMasterData.rs = ps.executeQuery();
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setCoc(empMasterData.rs.getString(1));
				empMaster.setCon(empMasterData.rs.getString(2));
				empMaster.setDoc(empMasterData.rs.getString(3));
				empMaster.setDon(empMasterData.rs.getString(4));
				empMaster.setSdoc(empMasterData.rs.getString(5));
				empMaster.setSdon(empMasterData.rs.getString(6));
				empMaster.setDcode(empMasterData.rs.getString(7));
				empMaster.setDname(empMasterData.rs.getString(8));
				empMaster.setMandalCode(empMasterData.rs.getString(9));
				empMaster.setMandalName(empMasterData.rs.getString(10));
			}
		} catch (Exception e) {
			//System.out.println("the error is in getSubDetailHead="
					+ e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getsubdivisionmandals(String coc, String doc,
			String sdoc, DataSource dataSource) throws Exception {  
		EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList mandalsub = new ArrayList();
		//System.out.println("coc=" + coc + "doc=" + doc + "sdoc=" + sdoc);
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			String query = "select M.MCODE,M.MNAME FROM RWS_MANDAL_SUBDIVISION_TBL MS,RWS_MANDAL_TBL M WHERE MS.CIRCLE_OFFICE_CODE='"
							+ coc
							+ "' AND MS.DCODE='"
							+ coc
							+ "' AND MS.DIVISION_OFFICE_CODE='"
							+ doc
							+ "' AND MS.SUBDIVISION_OFFICE_CODE='"
							+ sdoc
							+ "' AND M.MCODE=MS.MCODE AND M.DCODE='"
							+ coc
							+ "' ORDER BY M.MNAME";
		
			empMasterData.rs=empMasterData.stmt.executeQuery(query);
			//System.out.println("query in getsubdivisionmandals  "+query);
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setMandalCode(empMasterData.rs.getString(1));
				empMaster.setMandalName(empMasterData.rs.getString(2));
				mandalsub.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("the error is in getsubdivisionmandal="
					+ e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return mandalsub;
	}

	public static int updateMandalSubDivision(String mcode, String sdoc,
			String doc, String coc, EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int ans = 0;
		//System.out.println("old mcode=" + mcode + "new mcode="
				+ empMaster.getMandalCode() + "dcode="
				+ empMaster.getDistrict() + "new sdoc=" + empMaster.getSdoc()
				+ "old sdoc=" + sdoc + "doc=" + empMaster.getDoc() + "old doc="
				+ doc + "coc=" + empMaster.getCoc() + "old coc=" + coc
				+ "docde=" + empMaster.getDistrict() + "oldcode=" + coc);
		try {
			empMasterData.conn = dataSource.getConnection();
			if (getMandalSubDivisionCount(empMaster.getCoc(), empMaster
					.getDoc(), empMaster.getSdoc(), empMaster.getDistrict(),
					empMaster.getMandalCode(), mcode, empMasterData.conn) != 1) {
				if (mcode.equals(empMaster.getMandalCode())) {
					ps = empMasterData.conn
							.prepareStatement("update RWS_MANDAL_SUBDIVISION_TBL set SUBDIVISION_OFFICE_CODE =? where MCODE =? and DCODE=?  and SUBDIVISION_OFFICE_CODE =? and DIVISION_OFFICE_CODE=? and CIRCLE_OFFICE_CODE=?");
					ps.setString(1, empMaster.getSdoc());
					ps.setString(2, mcode);
					ps.setString(3, empMaster.getDistrict());
					ps.setString(4, sdoc);
					ps.setString(5, empMaster.getDoc());
					ps.setString(6, empMaster.getCoc());
				} else {
					ps = empMasterData.conn
							.prepareStatement("update  RWS_MANDAL_SUBDIVISION_TBL set SUBDIVISION_OFFICE_CODE =?,MCODE =?,DIVISION_OFFICE_CODE=?,CIRCLE_OFFICE_CODE=?,DCODE=? where MCODE =? and DCODE=?  and SUBDIVISION_OFFICE_CODE =? and DIVISION_OFFICE_CODE=? and CIRCLE_OFFICE_CODE=?");
					ps.setString(1, empMaster.getSdoc());
					ps.setString(2, empMaster.getMandalCode());
					ps.setString(3, empMaster.getDoc());
					ps.setString(4, empMaster.getCoc());
					ps.setString(5, empMaster.getDistrict());
					ps.setString(6, mcode);
					ps.setString(7, coc);
					ps.setString(8, sdoc);
					ps.setString(9, doc);
					ps.setString(10, coc);
				}
				ans = ps.executeUpdate();
				//System.out.println("ans=" + ans);
			} else
				errorMessage = "This Mandal Already Mapped To Another Sub Division";
		} catch (SQLException sqle) {
			//System.out.println("Exception is:" + sqle.getMessage());
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		//System.out.println("ans=" + ans);
		return ans;
	}

	public static int getMandalSubDivisionCount(String coc, String doc,
			String sdoc, String dcode, String mcode, String mandal,
			Connection conn) throws Exception {
		EmpMasterData empMasterData=new EmpMasterData();
		empMasterData.conn=conn;
		
		int c = 0;
		try {
			if (mcode.equals(mandal))
				return c;
			else {
				empMasterData.stmt = empMasterData.conn.createStatement();
				empMasterData.rs =empMasterData.stmt
						.executeQuery("select count(SUBDIVISION_OFFICE_CODE) from RWS_MANDAL_SUBDIVISION_TBL where CIRCLE_OFFICE_CODE='"
								+ coc
								+ "' and DIVISION_OFFICE_CODE='"
								+ doc
								+ "' and DCODE='"
								+ dcode
								+ "' and MCODE='"
								+ mcode + "'");
				empMasterData.rs.next();
				c = empMasterData.rs.getInt(1);
			}
		} catch (Exception e) {
			//System.out.println("Exception in getmandalsubdivision count="
					+ e.getMessage());

		} finally {
			empMasterData.stmt.close();
		}
		//System.out.println("count=" + c);
		return c;
	}

	public static int removeMandalSubDivision(String coc, String doc,
			String sdoc, String dcode, String mcode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			//empMasterData.stmt = empMasterData.conn.createStatement();
			String query = "delete  from RWS_MANDAL_SUBDIVISION_TBL  where CIRCLE_OFFICE_CODE=? and DIVISION_OFFICE_CODE= ?" +
					" and SUBDIVISION_OFFICE_CODE=?  and DCODE=?  and MCODE=?"; 
			rowCount = empMasterData.stmt
					.executeUpdate("delete  from RWS_MANDAL_SUBDIVISION_TBL  where CIRCLE_OFFICE_CODE='"
							+ coc
							+ "' and DIVISION_OFFICE_CODE='"
							+ doc
							+ "' and SUBDIVISION_OFFICE_CODE='"
							+ sdoc
							+ "' and DCODE='"
							+ dcode
							+ "' and MCODE='"
							+ mcode
							+ "'");
			ps = empMasterData.conn.prepareStatement(query);
			ps.setString(1,coc);
			ps.setString(2,doc);
			ps.setString(3,sdoc);
			ps.setString(4,dcode);
			ps.setString(5,mcode);
			rowCount = ps.executeUpdate();
			} catch (Exception e) {
			//System.out.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public int getAssetCount(String tabName, String typeOfAssetCode,
			String habCode, String assetCode) throws Exception {
		
		int count = 0;
		String query = "";
		try {
			query = "SELECT count(*)COUNT FROM rws_asset_mast_tbl A,rws_asset_scheme_tbl S ,"
					+ tabName
					+ " g WHERE A.asset_code = S.asset_code  AND type_of_asset_code='"
					+ typeOfAssetCode
					+ "'"
					+ " and g.asset_code=A.asset_code and g.asset_code='"
					+ assetCode + "'";
			//System.out.println("query in counts of " + query);
			stmt = conn.createStatement();
			rs1 = stmt.executeQuery(query);
			if (rs1.next())
			{
				count = rs1.getInt("COUNT");
				//System.out.println("count is "+count);
			}
		} catch (Exception e) {
			//System.out.println("Error=" + e);
		} finally {
			//closeAll();
		}
		return count;

	}

	public int getAssetCount(String tabName, String typeOfAssetCode,
			String habCode) throws Exception {
	
		int count = 0;
		String query = "";
		try {
			query = "SELECT count(*)COUNT FROM rws_asset_mast_tbl A,rws_asset_scheme_tbl S ,"
					+ tabName
					+ " g WHERE A.asset_code = S.asset_code  AND type_of_asset_code='"
					+ typeOfAssetCode
					+ "'"
					+ " and g.asset_code=A.asset_code and g.asset_code='";
				
			//System.out.println("query in counts of " + query);
			stmt = conn.createStatement();
			rs1 =stmt.executeQuery(query);
			if (rs1.next())
				count = rs1.getInt("COUNT");
		} catch (Exception e) {
			//System.out.println("Error=" + e);
		} finally {
			//closeAll();
		}
		return count;

	}

	
	//code modified
	public ArrayList getComponentDetails(String typeOfAssetCode,
			String habCode, DataSource dataSource) {
		ArrayList assets = new ArrayList();
		try {
			conn = dataSource.getConnection();
			Statement stmt1 = conn.createStatement();
			String query = "";
			if (typeOfAssetCode.equals("04"))
				query = " SELECT A.asset_code, S.scheme_code, asset_name, A.location, date_creation, "
						+ " DECODE(asset_status, '1', 'WORKING', '2', 'NOT WORKING', '3', 'DRIED', '4','CONDEMNED', '5', 'SEASONAL') AS ASSET_STATUS, "
						+ " asset_cost, start_year, end_year, h.P_YEILD, DECODE(H.QUALITY_AFFECTED,'Y','NSS','N','SAFE SOURCE')AS WATER_QUALITY,"
						+ " H.FLOURIDE AS FLOURIDE_PER,H.BRAKISH AS BRAKISH_PER,H.IRON AS IRON_PER,CONT_OTHERS_TYPE AS OTHERS,CONT_OTHERS_PER AS OTHERS_PER"
						+ " FROM RWS_HP_SUBCOMP_PARAM_TBL h,rws_asset_mast_tbl A, rws_asset_scheme_tbl S"
						+ " WHERE A.asset_code = S.asset_code AND a.asset_code=h.asset_code"
						+ " AND type_of_asset_code='"
						+ typeOfAssetCode
						+ "' "
						+ " AND hab_code = '" + habCode + "'";
			else if (typeOfAssetCode.equals("05"))
				query=" SELECT * from RWS_SHALLOWHANDPUMPS_TBL   p,RWS_HABITATION_DIRECTORY_TBL h,  "
					+ " RWS_ASSET_MAST_TBL A, rws_asset_scheme_tbl S where a.asset_code=s.asset_code and a.asset_code=p.asset_code and  h.hab_code=p.hab_code AND substr(s.scheme_code,1,16) = '"
					+ habCode + "'";
			else if (typeOfAssetCode.equals("06"))
				query = " SELECT * from RWS_OPEN_WELL_MAST_TBL   p,RWS_HABITATION_DIRECTORY_TBL h,  "
						+ "RWS_ASSET_MAST_TBL A  , rws_asset_scheme_tbl S where a.asset_code=s.asset_code and a.asset_code=p.asset_code and h.hab_code=p.HABITATION_CODE  AND p.HABITATION_CODE  = '"
						+ habCode + "'";
			else if (typeOfAssetCode.equals("07"))
				query = " SELECT * from RWS_OPENWELL_POND_TBL  p,RWS_HABITATION_DIRECTORY_TBL h , "
						+ "RWS_ASSET_MAST_TBL A  , rws_asset_scheme_tbl S where a.asset_code=s.asset_code and a.asset_code=p.asset_code and  h.hab_code=p.hab_code AND p.hab_code = '"
						+ habCode + "'";
			/*else if (typeOfAssetCode.equals("07"))
				query = " SELECT * from RWS_DWTANK_MST_TBL d,RWS_HABITATION_DIRECTORY_TBL h  "
						+ "  where h.hab_code=d.hab_code AND d.hab_code = '"
						+ habCode + "'";*/
			else if (typeOfAssetCode.equals("08"))
				query = " SELECT o.hab_code,o.habname,o.OW_CODE,o.LOCATION,o.DIA,o.DEPTH,o.MINWL,o.MAXWL from RWS_OPEN_WELL_MAST_TBL o,RWS_HABITATION_DIRECTORY_TBL h  "
						+ "  where h.hab_code=o.hab_code AND o.hab_code = '"
						+ habCode + "'";
			else
				query = " SELECT A.asset_code, S.scheme_code, asset_name, location, to_char(date_creation,'dd/mm/yy')date_creation, "
						+ " DECODE(asset_status, '1', 'WORKING', '2', 'NOT WORKING', '3', 'DRIED', '4','CONDEMNED', '5', 'SEASONAL') AS ASSET_STATUS, "
						+ " asset_cost, start_year, end_year FROM rws_asset_mast_tbl A, rws_asset_scheme_tbl S"
						+ " WHERE A.asset_code = S.asset_code"
						+ " AND type_of_asset_code='"
						+ typeOfAssetCode
						+ "' "
						+ " AND hab_code = '" + habCode + "'";
			//System.out.println("query=" + query);
			// empMaster.setPmCode(rs.getString(31));
			rs = stmt1.executeQuery(query);
			EmpMaster empMaster = null;
			String assetCode = "";
			while (rs.next() ) {
				empMaster = new EmpMaster();
				
				assetCode=rs.getString("ASSET_CODE");
				empMaster.setAssetCode(rs.getString("ASSET_CODE"));
				empMaster.setSchemeCode(rs.getString("SCHEME_CODE"));
				empMaster.setAssetName(rs.getString("ASSET_NAME"));
				empMaster.setLocation(rs.getString("LOCATION"));
				empMaster.setDateofCreation(rs.getString("DATE_CREATION"));
				empMaster.setAssetStatus(rs.getString("ASSET_STATUS"));
				empMaster.setAssetCost(rs.getString("ASSET_COST"));
				empMaster.setStartYear(rs.getString("START_YEAR"));
				empMaster.setEndYear(rs.getString("END_YEAR"));
				
				if (typeOfAssetCode.equals("01")) {
					//System.out.println("executing glsr");
					empMaster.setGlsrCount(getAssetCount(
							"RWS_PWS_GLSR_SC_PARAM_TBL", typeOfAssetCode,
							habCode, assetCode));
					//System.out.println("executed");
					//System.out.println("glsr count is "+empMaster.getGlsrCount());
					empMaster.setOhsrCount(getAssetCount(
							"RWS_PWS_OHSR_SC_PARAM_TBL", typeOfAssetCode,
							habCode, assetCode));
				}
				
				else if (typeOfAssetCode.equals("02")) {
					empMaster.setGlsrCount(getAssetCount(
							"RWS_MPWS_GLSR_SC_PARAM_TBL", typeOfAssetCode,
							habCode, assetCode));
					//System.out.println("glsr count is "+empMaster.getGlsrCount());
					empMaster.setOhsrCount(getAssetCount(
							"RWS_MPWS_OHSR_SC_PARAM_TBL", typeOfAssetCode,
							habCode, assetCode));
				}

				else if (typeOfAssetCode.equals("03")) {
					//System.out.println("in cpws");
					empMaster.setGlsrCount(getAssetCount(
							"RWS_CPWS_GLSR_SC_PARAM_TBL", typeOfAssetCode,
							habCode, assetCode));
					//System.out.println("1");
					empMaster.setOhsrCount(getAssetCount(
							"RWS_CPWS_OHSR_SC_PARAM_TBL", typeOfAssetCode,
							habCode, assetCode));
					//System.out.println("2");
					empMaster.setGlbrCount(getAssetCount(
							"RWS_CPWS_GLBR_SC_PARAM_TBL", typeOfAssetCode,
							habCode, assetCode));
					//System.out.println("3");
					empMaster.setOhbrCount(getAssetCount(
							"RWS_CPWS_OHBR_SC_PARAM_TBL", typeOfAssetCode,
							habCode, assetCode));
					//System.out.println("4");
				}
				else if (typeOfAssetCode.equals("04")) {
					
					empMaster.setPyield(rs.getString("P_YEILD"));
					empMaster.setWaterQuality(rs.getString("WATER_QUALITY"));
					empMaster.setFlouride(rs.getDouble("FLOURIDE_PER"));
					empMaster.setBrakish(rs.getDouble("BRAKISH_PER"));
					empMaster.setIron(rs.getDouble("IRON_PER"));
					empMaster.setOthersType(rs.getString("OTHERS"));
					empMaster.setOthers(rs.getString("OTHERS_PER"));
				} 
				else if (typeOfAssetCode.equals("05"))
				{
					empMaster.setHabCode(rs.getString("HAB_CODE"));
					//empMaster.setHabName(rs.getString(2));
					empMaster.setShpCode(rs.getString("SHALLOWHP_CODE"));
					empMaster.setShpLocation(rs.getString("LOCATION"));
					empMaster.setShpDiameter(rs.getString("DIAMETER"));
					empMaster.setShpDepth(rs.getString("DEPTH"));
					
					empMaster.setWaterQuality(rs.getString("WATER_QUALITY"));
					empMaster.setFlouride(rs.getDouble("FLORIDE_PER"));
					empMaster.setBrakish(rs.getDouble("BRAKISH_PER"));
					empMaster.setIron(rs.getDouble("IRON_PER"));
					empMaster.setOthersType(rs.getString("OTHERS"));
					empMaster.setOthers(rs.getString("OTHERS_PER"));
					
				
				  
				}
				else if (typeOfAssetCode.equals("06"))
				   {
						empMaster.setHabCode(rs.getString("HABITATION_CODE"));
						//empMaster.setHabName(rs.getString(2));
						empMaster.setOwCode(rs.getString("OPENWELL_CODE"));
						empMaster.setOwLocation(rs.getString("LOCATION"));
						empMaster.setOwDiameter(rs.getString("DIAMETER"));
						empMaster.setOwDepth(rs.getString("DEPTH"));
						empMaster.setOwMinwl(rs.getString("MIN_WATER_LEVEL"));
						empMaster.setOwMaxwl(rs.getString("MAX_WATER_LEVEL"));
						
						empMaster.setWaterQuality(rs.getString("QUALITY"));
						empMaster.setFlouride(rs.getDouble("FLOURIDE_PER"));
						empMaster.setBrakish(rs.getDouble("BRAKISH_PER"));
						empMaster.setIron(rs.getDouble("IRON_PER"));
						empMaster.setOthersType(format(rs.getString("OTHER_TYPE")));
						empMaster.setOthers(format(rs.getString("OTHER_PER")));
						
						//empMaster.setPondServiceMonths(rs.getString(11));
						
						
					}
				else if (typeOfAssetCode.equals("07"))
				{
					empMaster.setHabCode(rs.getString("HAB_CODE"));
					//empMaster.setHabName(rs.getString(2));
					empMaster.setPondCode(rs.getString("POND_CODE"));
					empMaster.setPondName(rs.getString("POND_NAME"));
					empMaster.setLocation(rs.getString("POND_LOCATION"));
					empMaster.setPondSize(rs.getString("SIZE_AREA"));
					empMaster.setPondVolume(rs.getString("STORAGE_VOL"));
					
					empMaster.setWaterQuality(rs.getString("WATER_QUALITY"));
					empMaster.setFlouride(rs.getDouble("FLORIDE"));
					empMaster.setBrakish(rs.getDouble("BRAKISH"));
					empMaster.setIron(rs.getDouble("IRON"));
					empMaster.setOthersType(format(rs.getString("OTHER_TYPE")));
					empMaster.setOthers(format(rs.getString("OTHER_PER")));
					//empMaster.setPondServiceMonths(rs.getString(11));

				} else if (typeOfAssetCode.equals("08")) {
					empMaster.setHabCode(rs.getString(1));
					empMaster.setHabName(rs.getString(2));
					empMaster.setOwCode(rs.getString(3));
					empMaster.setLocation(rs.getString(4));
					empMaster.setOwDiameter(rs.getString(5));
					empMaster.setOwDepth(rs.getString(6));
					empMaster.setOwMaxwl(rs.getString(7));
					empMaster.setOwMinwl(rs.getString(8));

				} else {
					assetCode = rs.getString(1);
					empMaster.setAssetCode(assetCode);
					empMaster.setSchemeCode(rs.getString(2));
					empMaster.setAssetName(rs.getString(3));
					empMaster.setLocation(rs.getString(4));
					if (rs.getString(5) == null)
						empMaster.setDateofCreation(rs.getString(5));
					else
						empMaster.setDateofCreation(df.format(rs.getDate(5)));
					empMaster.setAssetStatus(rs.getString(6));
					empMaster.setAssetCost(rs.getString(7));
					empMaster.setStartYear(rs.getString(8));
					empMaster.setEndYear(rs.getString(9));
					
				}
				assets.add(empMaster);

			}
		} catch (Exception e) {
			//System.out.println("Excpetion in getComponentDetails : "+e);
					
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException sqle) {
				}
			}

			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException sqle) {
				}
			}

			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException sqle) {
				}
			}
		}
		return assets;
	}	//end of code modified
	public static EmpMaster getAssetDetails(String habCode,
			String assetTypeCode, String pumpCode, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		String schemeCode = habCode + pumpCode;
		
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			//System.out.println("schemeCode=" + schemeCode);
			String query = "select a.ASSET_CODE,a.ASSET_NAME,a.LOCATION,a.DATE_CREATION,a.ASSET_COST,a.START_YEAR,a.END_YEAR,a.asset_status from rws_asset_mast_tbl a,rws_asset_scheme_tbl s where a.type_of_asset_code='"
					+ assetTypeCode
					+ "' and a.hab_code='"
					+ habCode
					+ "' and a.asset_code=s.asset_code and s.scheme_code='"
					+ schemeCode + "'";
				//System.out.println("getasset details query  "+query);
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setAssetCode(empMasterData.rs.getString(1));
				empMaster.setAssetName(empMasterData.rs.getString(2));
				//if(empMasterData.rs.getString(3)!=null)
				empMaster.setLocation(empMasterData.rs.getString(3));
				if (empMasterData.rs.getString(4) != null)
					empMaster.setDateofCreation(df.format(empMasterData.rs.getDate(4)));
				//if(empMasterData.rs.getString(5)!=null)
				empMaster.setAssetCost(empMasterData.rs.getString(5));
				//if(empMasterData.rs.getString(6)!=null)
				empMaster.setStartYear(empMasterData.rs.getString(6));
				//if(empMasterData.rs.getString(7)!=null)
				empMaster.setEndYear(empMasterData.rs.getString(7));
				//if(empMasterData.rs.getString(8)!=null)
				empMaster.setAssetStatus(empMasterData.rs.getString(8));

			}
			try {
				
				 query = "select count(h.hab_code),Sum(d.census_plain_popu + d.census_st_popu + d.census_st_popu + d.FLOAT_POP) from rws_asset_mast_tbl a, rws_asset_hab_tbl h, rws_habitation_directory_tbl d where d.hab_code=h.hab_code and h.asset_code= a.asset_code and a.asset_code='"+empMaster.getAssetCode()+"'";
				//System.out.println("details of population query  "+query);
				empMasterData.rs =empMasterData.stmt.executeQuery(query);
				if(empMasterData.rs.next())
						{
					empMaster.setTotHabs(empMasterData.rs.getInt(1));
					empMaster.setTotPopBenfit(empMasterData.rs.getDouble(2));
						}
			} catch (Exception e) {
				//System.out.println("Error in population" + e.getMessage());
			}
		} catch (Exception e) {
			//System.out.println("Error in getAssetDetails" + e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}
public static EmpMaster PopuCountInHab(String AssetCodes,DataSource dataSource) throws Exception
{
	EmpMaster empMaster = null;
	EmpMasterData empMasterData=new EmpMasterData();
	empMasterData.conn = dataSource.getConnection();
	empMasterData.stmt = empMasterData.conn.createStatement();
	try {
		
		String query = "select count(h.hab_code),Sum(d.census_plain_popu + d.census_st_popu + d.census_st_popu + d.FLOAT_POP) from rws_asset_mast_tbl a, rws_asset_hab_tbl h, rws_habitation_directory_tbl d where d.hab_code=h.hab_code and h.asset_code= a.asset_code and a.asset_code='"+AssetCodes+"'";
		//System.out.println("details of population query  "+query);
		empMasterData.rs =empMasterData.stmt.executeQuery(query);
		if(empMasterData.rs.next())
				{
			empMaster = new EmpMaster();
			empMaster.setTotHabs(empMasterData.rs.getInt(1));
			empMaster.setTotPopBenfit(empMasterData.rs.getInt(2));
				}
	} catch (Exception e) {
		//System.out.println("Error in population" + e.getMessage());
	} finally {
			empMasterData.closeAll();
}
return empMaster;
}
	public static int UpdateHoffice(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String query;
		int rowcount = 0;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			query = "update RWS_HEAD_OF_OFFICE_TBL set office='"
					+ empMaster.getOffice() + "',designation_code='"
					+ empMaster.getDesignation() + "' where office='"
					+ empMaster.getOffice() + "'";
			rowcount = empMasterData.stmt.executeUpdate(query);
		} catch (Exception e) {
			//System.out.println("The Error in UpdateHoffice :" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowcount;
	}

	public static ArrayList getHOData(DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		ArrayList datas = null;
		
		try {
			datas = new ArrayList();
			EmpMaster empMaster = null;
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select t.office,d.designation_acr from rws_head_of_office_tbl t,rws_designation_tbl d where d.designation_code=t.designation_code");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setOffice(empMasterData.rs.getString(1));
				empMaster.setDesignation(empMasterData.rs.getString(2));
				datas.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("Error in getLowerLimit" + e);
		} finally {
			empMasterData.closeAll();
		}
		return datas;
	}

	public static ArrayList getHoffice(DataSource datasource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		ArrayList office = null;
		try {
			office = new ArrayList();
			empMasterData.conn = datasource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select distinct office from rws_head_of_office_tbl");
			EmpMaster empMaster = null;
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setOffice(empMasterData.rs.getString(1));
				office.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("error in getOffice=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return office;
	}

	public static ArrayList getHoffices(DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList hoffices = new ArrayList();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select h.office,d.designation_acr from rws_head_of_office_tbl h,rws_designation_tbl d where h.designation_code=d.designation_code");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setOffice(empMasterData.rs.getString(1));
				empMaster.setDesignation(empMasterData.rs.getString(2));
				hoffices.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("The error in getContams" + e);
		} finally {
			empMasterData.closeAll();
		}
		return hoffices;
	}

	public static int updateTslimit(EmpMaster empMaster, DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		String office = empMaster.getOffice();
		String designation = empMaster.getDesignation();
		//int designation=Integer.parseInt(empMaster.getDesignation());

		String lowerLimit = empMaster.getLowerLimit();
		String upperLimit = empMaster.getUpperLimit();
		String query;
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();

			//System.out.println("before query");

			query = "update rws_est_ts_work_value_tbl set cost_lower_limit='"
					+ lowerLimit
					+ "',cost_upper_limit='"
					+ upperLimit
					+ "' where designation_code=(select designation_code from rws_designation_tbl where designation_acr='"
					+ designation + "')";

			rowCount = empMasterData.stmt.executeUpdate(query);
			//System.out.println("after query execution,rowcount:" + rowCount);
		} catch (Exception e) {
			//System.out.println("The Error In UpdateTslimit :" + e);
		} finally {
			empMasterData.closeAll();
		}

		return rowCount;
	}

	public static ArrayList getDesignation(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		//String acode=null;
		ArrayList designation = null;
		try {
			designation = new ArrayList();
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("SELECT designation_code, DESIGNATION_ACR FROM RWS_DESIGNATION_TBL ORDER BY DESIGNATION_NAME");
			EmpMaster empMaster = null;
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setDesgnCode(empMasterData.rs.getString(1));
				empMaster.setDesgnName(empMasterData.rs.getString(2));
				designation.add(empMaster);
			}

			//acode=empMasterData.rs.getString(1);
		} catch (Exception e) {
			//System.out.println("The error in getDesignation=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return designation;
	}

	public static ArrayList getTSData(DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		ArrayList datas = null;
		
		try {
			datas = new ArrayList();
			EmpMaster empMaster = null;
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select t.office,d.designation_acr,t.cost_lower_limit,t.cost_upper_limit from rws_est_ts_work_value_tbl t,rws_designation_tbl d where d.designation_code=t.designation_code");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setOffice(empMasterData.rs.getString(1));
				empMaster.setDesignation(empMasterData.rs.getString(2));
				empMaster.setLowerLimit(empMasterData.rs.getString(3));
				empMaster.setUpperLimit(empMasterData.rs.getString(4));
				datas.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("Error in getLowerLimit" + e);
		} finally {
			empMasterData.closeAll();
		}
		return datas;
	}

	public static ArrayList getOffice(DataSource datasource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		ArrayList office = null;
		try {
			office = new ArrayList();
			empMasterData.conn = datasource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select distinct office from rws_est_ts_work_value_tbl");
			EmpMaster empMaster = null;
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setOffice(empMasterData.rs.getString(1));
				office.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("error in getOffice=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return office;
	}

	public static ArrayList getLowerLimit(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		ArrayList lowerLimit = null;
		try {
			lowerLimit = new ArrayList();
			EmpMaster empMaster = null;
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select cost_lower_limit from rws_est_ts_work_value_tbl");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setLowerLimit(empMasterData.rs.getString(1));
				lowerLimit.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("Error in getLowerLimit" + e);
		} finally {
			empMasterData.closeAll();
		}
		return lowerLimit;
	}

	public static ArrayList getUpperLimit(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		ArrayList upperLimit = null;
		try {
			upperLimit = new ArrayList();
			EmpMaster empMaster = null;
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt
					.executeQuery("select cost_upper_limit from rws_est_ts_work_value_tbl");
			empMaster = new EmpMaster();
			while (empMasterData.rs.next()) {
				empMaster.setUpperLimit(empMasterData.rs.getString(1));
				upperLimit.add(empMaster);
			}
		} catch (Exception e) {
			//System.out.println("Exception in getUpperLimit" + e);
		} finally {
			empMasterData.closeAll();
		}
		return upperLimit;
	}

	public static ArrayList getFromDates(DataSource dataSource)
			throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		String query;
		ArrayList fromDate = new ArrayList();
		try {
			//query = "select distinct to_char(access_date,'DD/MM/yy') from rws_log_tbl order by to_char(access_date,'DD/MM/yy')  desc";
			query = "select distinct to_char(access_date,'DD/MM/yy') as a1 from rws_log_tbl order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";

			//System.out.println("query is "+query);
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			EmpMaster empMaster = null;
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setFromDate(empMasterData.rs.getString(1));
				//System.out.println("EmpMaster fromDate"+ empMaster.getFromDate());
				fromDate.add(empMaster);
			}
			empMasterData.conn.close();
		} catch (Exception e) {
			//System.out.println("Exception in GetDate in EmpMaster :" + e);
		}

		return fromDate;
	}

	public static ArrayList getToDates(String fromDate, DataSource dataSource) {
		String query;
		ArrayList toDate = new ArrayList();
		EmpMasterData empMasterData=new EmpMasterData();
		//System.out.println("started getToDates in EmpMasterData before try");
		try {
			//System.out.println("started getToDates in EmpMasterData try started");

			
			query = //"select distinct to_char(access_date,'DD/MM/yy') from rws_log_tbl where to_date(ACCESS_DATE,'dd/mm/yy') >= to_Date('"
					//+ fromDate + "','dd/mm/yy') order by to_char(access_date,'DD/MM/yy')  desc";
					
	query = "select distinct to_char(access_date,'DD/MM/yy') as a1 from rws_log_tbl where to_date(ACCESS_DATE,'dd/mm/yy') >= to_Date('"
					+ fromDate + "','dd/mm/yy')  order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";

			//System.out.println("query is "+query);
			/*
			 * query="select unique(to_char(access_date,'dd/mm/yyyy')) from
			 * rws_log_tbl where to_date(ACCESS_DATE,'dd/mon/yyyy') >=
			 * to_Date('"+fromDate+"','dd/mm/yyyy')";
			 */

			/*
			 * query="select unique(to_Char(access_date,'dd/mm/yy')) from
			 * rws_log_tbl where to_Date(ACCESS_DATE,'dd/mon/yyyy') >=
			 * to_Date('"+fromDate+"','dd/mm/yyyy')";
			 */

			//System.out.println("empMasterData.conn: "+empMasterData.conn);
			empMasterData.conn = dataSource.getConnection();
			//System.out.println("empMasterData.conn" + empMasterData.conn);
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs =empMasterData.stmt.executeQuery(query);
			EmpMaster empMaster = null;
			////System.out.println("empMasterData.rs.next() :"+empMasterData.rs.next());

			while (empMasterData.rs.next()) 
			{
				empMaster = new EmpMaster();
				empMaster.setToDate(empMasterData.rs.getString(1));
				//System.out.println("EmpMaster toDate" + empMaster.getToDate());
				toDate.add(empMaster);
			}
			empMasterData.conn.close();
		} catch (Exception e) {
			//System.out.println("Exception in getToDates in EmpMasterData :" + e);
		}
		return toDate;
	}

	public static ArrayList getUserAudit(EmpMaster empMaster,
			DataSource dataSource) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		//System.out.println("started getUserAudit in EmpMasterData before try");
		String toDate;
		String fromDate;
		String query;
		ArrayList uaudit = new ArrayList();

		try {
			//System.out.println("started getUserAudit in EmpMasterData try started");
			toDate = empMaster.getToDate();
			fromDate = empMaster.getFromDate();
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			if (fromDate.equals(toDate)) {
				query = "select distinct access_date,user_id,auth_type,access_time,module,page,address,host,browser from rws_log_tbl where to_date(access_date,'dd/mm/yy')=to_Date('"
						+ fromDate + "','dd/mm/yy')";
			} 
			else {

				query = "select distinct user_id,access_date,auth_type,access_time,module,page,address,host,browser from rws_log_tbl where to_date(access_date,'dd/mm/yy') >= to_Date('"
						+ fromDate
						+ "','dd/mm/yy') and to_date(access_date,'dd/mm/yy') <=to_Date('"
						+ toDate + "','dd/mm/yy') order by access_date";

			}
			empMasterData.rs =empMasterData.stmt.executeQuery(query);

			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setUserId(empMasterData.rs.getString("USER_ID"));
				//System.out.println("EmpMaster setUserId"
						+ empMaster.getUserId());
				empMaster.setAuthType(empMasterData.rs.getString("AUTH_TYPE"));
				//empMaster.setAccessDate(empMasterData.rs.getString("ACCESS_DATE"));
				empMaster.setAccessDate(df.format(empMasterData.rs.getDate("ACCESS_DATE")));
				//System.out.println("AccessDate" + empMaster.getAccessDate());
				empMaster.setAccessTime(empMasterData.rs.getString("ACCESS_TIME"));
				empMaster.setModule(empMasterData.rs.getString("MODULE"));
				empMaster.setPage(empMasterData.rs.getString("PAGE"));
				empMaster.setAddress(empMasterData.rs.getString("ADDRESS"));
				empMaster.setHost(empMasterData.rs.getString("HOST"));
				empMaster.setBrowser(empMasterData.rs.getString("BROWSER"));
				//System.out.println("EmpMaster setBrowser"
						+ empMaster.getBrowser());
				uaudit.add(empMaster);
			}
			empMasterData.conn.close();
		} catch (Exception e) {
			//System.out.println("Error in getUserAudit in EmpMasterData :" + e);
		}

		return uaudit;
	}

	/* DELETE SUNCOMPONANE MATHOD ADDed BY SADIQ ********** */
/*	public static int removeAssetSubComp(DataSource dataSource,
			String assetTypeCode, String assetCompCode,
			String assetSubCompCode, String pumpCode) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();

		int rcount = 0;
		try {
			String q1 = null;
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
		/*	if (assetTypeCode.equals("01") && assetCompCode.equals("01")
					&& assetSubCompCode.equals("001")) {

				q1 = "delete  from RWS_PWS_SUBCOMP_PARAM_TBL where PUMP_CODE='"
						+ pumpCode + "'";

			} else if (assetTypeCode.equals("01") && assetCompCode.equals("05")
					&& assetSubCompCode.equals("003")) {

				q1 = "delete  from RWS_PWS_CP_SC_PARAM_TBL  where CPSC_CODE='"
						+ pumpCode + "'";

			} else if (assetTypeCode.equals("03") && assetCompCode.equals("05")
					&& assetSubCompCode.equals("001")) {

				q1 = "delete  from RWS_CPWS_PUMP_DET_SC_PARAM_TBL  where PUMPDET_CODE='"
						+ pumpCode + "'";
			}

			//System.out.println("qury in remove   " + q1);
			rcount = empMasterData.stmt.executeUpdate(q1);

		} catch (Exception e) {
			//System.out.println("The error in removeContam=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rcount;
	}*/

	//@author santosh modified on 211106
	/*public static int removeAssetSubCompPipeType(DataSource dataSource,String code,
			ArrayList subComps) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		Asset_SubComponent assetSources = new Asset_SubComponent();
		//Asset_SubComponent assetSources ;
		Asset_HeadWorks assetHeadworks = new Asset_HeadWorks();
		Asset_PipeLine assetPipeline = new Asset_PipeLine();
		Asset_Reservior assetReservior = new Asset_Reservior();
		Asset_Pumpset assetPumpset = new Asset_Pumpset();
		String query1 = "";
		String query = "";
		Statement stm = null;
		
		try {
			String Tab_Prifix = "";
			String subComp=code.substring(19,20);
			//System.out.println("subComp="+subComp);
			String assetSchemeCode=code.substring(16,18);
			//System.out.println("assetSchemeCode="+assetSchemeCode);
			if(assetSchemeCode.substring(0,1).equals("6"))
				Tab_Prifix = "RWS_PWS_";
			else if(assetSchemeCode.substring(0,1).equals("4"))
				Tab_Prifix = "RWS_MPWS_";
			else if(assetSchemeCode.substring(0,1).equals("8"))
				Tab_Prifix = "RWS_CPWS_";
			
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			stm = empMasterData.conn.createStatement();
			
				assetSources = (Asset_SubComponent) subComps.get(0);
				query1 = "DELETE FROM rws_asset_pumpingmain_pipe_class_tbl   where pm_code='"
					+ code+ "'";
				//System.out.println("query1123=" + query1);
				rowCount = empMasterData.stmt.executeUpdate(query1);
				empMasterData.conn.commit();
			}catch(Exception e){//System.out.println("error in removeAssetSubCompPipeType "+e);}
			
		}
	//end @author santosh
	 * */

	
	//@authro santosh code added on 231106
	public static int removeAssetSubCompPipeTypes(DataSource dataSource,	
			ArrayList subComps,String code) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		Asset_PipeLine assetPipeline = new Asset_PipeLine();
		
		String query1 = "";
		String query = "";
		Statement stm = null;
		//System.out.println("subComps size=" + subComps.size());
		SubCompMetaData subCompMetaData=new SubCompMetaData(code);
		String subCompCode=subCompMetaData.getAssetSubCompTypeCode();
		try {
			String tabPrifix = "";
			String colName="";
			//Tab_Prifix="rws_asset_pipematerial_tbl";
			
			/*if(assetTypeCode.equals("01"))
				Tab_Prifix = "RWS_PWS_";
			else if(assetTypeCode.equals("02"))
				Tab_Prifix = "RWS_MPWS_";
			else if(assetTypeCode.equals("03"))
				Tab_Prifix = "RWS_CPWS_";
			*/
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			for (int i = 0; i < subComps.size(); i++) {
				assetPipeline = (Asset_PipeLine) subComps.get(i);
				if(subCompCode.equals("001")) 	
				query1 = "delete from rws_pumpingmain_pipes_tbl where pm_code='"
						   + code+"' and pm_mat='"+assetPipeline.getMaterial()
						   + "' and pm_cla='"+assetPipeline.getPclass()
						   + "' and pm_dia="+assetPipeline.getDiameter();
				
				if(subCompCode.equals("002")) 	
				query1 = "delete from rws_gravitymain_pipes_tbl where gm_code='"
				   + code+"' and pm_mat='"+assetPipeline.getMaterial()
				   + "' and pm_cla='"+assetPipeline.getPclass()
				   + "' and pm_dia="+assetPipeline.getDiameter();
				
				if(subCompCode.equals("003")) 	
				query1 = "delete from rws_distribution_pipes_tbl where distrisc_code='"
				   + code+"' and dis_mat='"+assetPipeline.getMaterial()
				   + "' and dis_cla='"+assetPipeline.getPclass()
				   + "' and dis_dia="+assetPipeline.getDiameter();
			
				//System.out.println("query is remove asset types is" + query1);
					empMasterData.stmt.addBatch(query1);
					}
			int[] updateCounts = empMasterData.stmt.executeBatch();
			//System.out.println("updateCounts.length   "+updateCounts.length);
			for (int j = 0; j < updateCounts.length; j++) {
					System.err.print(j + "recode iS DELETED  ");							
			}
			rowCount = updateCounts.length;
			empMasterData.conn.commit();
			}catch(Exception e){//System.out.println("exception in removeAssetSubCompPipeTypes "+e);}
			finally
			{
				
				empMasterData.closeAll();
			}
	return rowCount;	
	}
			
	//end @author		
	public static int removeAssetSubComp(DataSource dataSource,
			String assetCode, String assetCompTypeCode,
			String assetSubCompTypeCode, String assetTypeCode, String opType,
			ArrayList subComps, String compType) throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
		int rowCount = 0;
		Asset_SubComponent assetSources = new Asset_SubComponent();
		//Asset_SubComponent assetSources ;
		Asset_HeadWorks assetHeadworks = new Asset_HeadWorks();
		Asset_PipeLine assetPipeline = new Asset_PipeLine();
		Asset_Reservior assetReservior = new Asset_Reservior();
		Asset_Pumpset assetPumpset = new Asset_Pumpset();
		String query1 = "";
		String query = "";
		Statement stm = null;
		//System.out.println("subComps size=" + subComps.size());
		//System.out.println("op type is" + opType);
		//System.out.println("op compType is" + compType);
		try {
			String Tab_Prifix = "";
			
			if(assetTypeCode.equals("01"))
				Tab_Prifix = "RWS_PWS_";
			else if(assetTypeCode.equals("02"))
				Tab_Prifix = "RWS_MPWS_";
			else if(assetTypeCode.equals("03"))
				Tab_Prifix = "RWS_CPWS_";
			
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			stm = empMasterData.conn.createStatement();
			
			
			if (compType.equals("PumpSets") && (opType.equals("Modify")||opType.equalsIgnoreCase("Add New"))) {
				//System.out.println("subComps size= in modify  Pumpsets" + subComps.size());
				if (subComps != null)
				{
					
						if((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03")) 
							&& assetCompTypeCode.equals("05") &&
							 assetSubCompTypeCode.equals("001")) 
							{
							for (int i = 0; i < subComps.size(); i++) {
								assetPumpset = (Asset_Pumpset) subComps.get(i);
							 	query1 ="delete from "+Tab_Prifix+"OTHERS_PARAM_TBL  where  OTHER_COMP_CODE  ='"+assetPumpset.getOtherCompCode()+"'";
								//System.out.println("query1123=" + query1);
								empMasterData.stmt.addBatch(query1);											
							}
							
						
						int[] updateCounts = empMasterData.stmt.executeBatch();
						for (int j = 0; j < updateCounts.length; j++) {
								System.err.print(updateCounts[j] + " iS DELETED  ");
							}
						rowCount = updateCounts.length;
						empMasterData.conn.commit();
						return rowCount;
							}
						if((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03")) 
								&& assetCompTypeCode.equals("01") &&
								 assetSubCompTypeCode.equals("009")) 
								{
								//System.out.println("in pumpset delete");
								for (int i = 0; i < subComps.size(); i++) {
									assetPumpset = (Asset_Pumpset) subComps.get(i);
								 	query1 ="delete from "+Tab_Prifix+"SUBCOMP_PARAM_TBL  where  PUMP_CODE='"+assetPumpset.getPumpCode()+"' AND ASSET_CODE='"+assetPumpset.getAssetCode()+"'";
									//System.out.println("query1123=" + query1);
									rowCount = empMasterData.stmt.executeUpdate(query1);									
								}
								}
				}
			}
			if (assetTypeCode.equals("04")	
					&& assetCompTypeCode.equals("01")
					&& assetSubCompTypeCode.equals("001")) {
				assetSources = (Asset_SubComponent) subComps.get(0);
				//System.out.println("value assetCode is "+assetCode + "hp code is "+assetSources.getHpCode());
				query1 = "DELETE FROM RWS_HP_SUBCOMP_PARAM_TBL   where ASSET_CODE='"
					+ assetCode	+ "' and HP_CODE ='"
					+ assetSources.getHpCode() + "'";
				//System.out.println("query1123=" + query1);
				rowCount = empMasterData.stmt.executeUpdate(query1);
				empMasterData.conn.commit();
			
			}
			if (compType.equals("Headworks") && (opType.equals("Modify")||opType.equalsIgnoreCase("Add New"))) {
				//System.out.println("subComps size= in modify  Headworks" + subComps.size());
				if (subComps != null)
				{
					
						if((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03")) 
							&& assetCompTypeCode.equals("02") &&
							 assetSubCompTypeCode.equals("001")) 
							{
							for (int i = 0; i < subComps.size(); i++) {
								assetHeadworks = (Asset_HeadWorks) subComps.get(i);
							 	query1 ="delete from "+Tab_Prifix+"RW_COLLWELL_PARAM_TBL  " 
										+"where " 
										//+"asset_code ='"  + assetHeadworks.getAssetCode() + "' and" 
										+" RW_COLLWELL_CODE  ='"+assetHeadworks.getCollectionWellCode ()+"'";
								//System.out.println("query1123=" + query1);
								empMasterData.stmt.addBatch(query1);											
							}
							}
						else if((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03")) && assetCompTypeCode.equals("02") &&
							 assetSubCompTypeCode.equals("002")) 
							{	
							for (int i = 0; i < subComps.size(); i++) {
								assetHeadworks = (Asset_HeadWorks) subComps.get(i);
								query1 = "delete from "+Tab_Prifix+"SS_SC_PARAM_TBL  where " 
										+"asset_code='"+ assetHeadworks.getAssetCode()+"' and" 
										+" sssc_code ='"+   assetHeadworks.getSsTankCode() +"'";
								//System.out.println("query1123=" + query1);
								empMasterData.stmt.addBatch(query1);
								}
							}
						else if((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03")) &&
								 (assetSubCompTypeCode.equals("003") || assetSubCompTypeCode.equals("004"))) 
								{
							for (int i = 0; i < subComps.size(); i++) {
								assetHeadworks = (Asset_HeadWorks) subComps.get(i);
									//query1 = "delete from "+Tab_Prifix+"WTP_SC_PARAM_TBL   where asset_code='"+ assetHeadworks.getAssetCode() +"' and WTPSC_CODE ='"+ assetHeadworks.getWtpCode() +"'";
								query1 = "delete from "+Tab_Prifix+"WTP_SC_PARAM_TBL   where  " 
										+"WTPSC_CODE ='"+ assetHeadworks.getWtpCode() +"'";
									//System.out.println("query1123=" + query1);
									empMasterData.stmt.addBatch(query1);
								}
								}
						else if((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03")) && assetCompTypeCode.equals("02") &&
								 assetSubCompTypeCode.equals("005")) 
								{
							for (int i = 0; i < subComps.size(); i++) {
								assetHeadworks = (Asset_HeadWorks) subComps.get(i);
								 	query1 = "delete from "+Tab_Prifix+"SUMP_M_SC_PARAM_TBL   where " 
											//+"asset_code ='" + assetHeadworks.getAssetCode() + "' and" 
											+" SUMPCODE ='"+ assetHeadworks.getSumpCode() +"'";
									//System.out.println("query1123=" + query1);
									empMasterData.stmt.addBatch(query1);
								}
								}
						else if((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03")) && assetCompTypeCode.equals("02") &&
								 assetSubCompTypeCode.equals("006")) 
								{
							for (int i = 0; i < subComps.size(); i++) {
								assetHeadworks = (Asset_HeadWorks) subComps.get(i);
								 	query1 = "delete from "+Tab_Prifix+"FP_BRIDGE_PARAM_TBL   where " 
											//+"asset_code ='" + assetHeadworks.getAssetCode() + "' and" 
											+" BRIDGE_CODE  ='"+ assetHeadworks.getBridgeCode() +"'";
									//System.out.println("query1123=" + query1);
									empMasterData.stmt.addBatch(query1);
								}
								}
						else if((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03")) 
								&& assetCompTypeCode.equals("02") 
								&& assetSubCompTypeCode.equals("007")) 
								{
							for (int i = 0; i < subComps.size(); i++) {
								assetHeadworks = (Asset_HeadWorks) subComps.get(i);
								 		query1 = "delete from "+Tab_Prifix+"PUMPHOUSE_PARAM_TBL  where " 
												//+"asset_code ='" + assetHeadworks.getAssetCode() + "' and" 
												+" PUMPHOUSE_CODE  ='"+ assetHeadworks.getPumpHouseCode() +"'";
										//System.out.println("query1123=" + query1);
										empMasterData.stmt.addBatch(query1);
								}
								}
							else if((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03")) && assetCompTypeCode.equals("02") &&
								  assetSubCompTypeCode.equals("008")) 
								{
								for (int i = 0; i < subComps.size(); i++) {
									assetHeadworks = (Asset_HeadWorks) subComps.get(i);
								query1 = "delete from "+Tab_Prifix+"WATCHMAN_PARAM_TBL where " 
										//+"asset_code ='"+ assetHeadworks.getAssetCode() +"' and" 
										+" WATCHMAN_CODE ='"+ assetHeadworks.getWatchManCode() +"'";
								//System.out.println("query1123=" + query1);
								empMasterData.stmt.addBatch(query1);
								}
								}
							else if((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03")) && assetCompTypeCode.equals("02") &&
								  assetSubCompTypeCode.equals("009")) 
								{
								for (int i = 0; i < subComps.size(); i++) {
									assetHeadworks = (Asset_HeadWorks) subComps.get(i);
								 	query1 ="delete from "+Tab_Prifix+"CW_COLLWELL_PARAM_TBL where " 
											//+"asset_code ='"  + assetHeadworks.getAssetCode() + "' and" 
											+" CW_COLLWELL_CODE  ='"+assetHeadworks.getCollectionWellCode ()+"'";
									//System.out.println("query1123=" + query1);
									empMasterData.stmt.addBatch(query1);
									}
								 
								}
											
							int[] updateCounts = empMasterData.stmt.executeBatch();
							//System.out.println("updateCounts.length   "+updateCounts.length);
							for (int j = 0; j < updateCounts.length; j++) {
									System.err.print(j + "recode iS DELETED  ");							
							}
							rowCount = updateCounts.length;
							empMasterData.conn.commit();
							
						}
					}
			/*if (compType.equals("Pipeline") && (opType.equals("Modify")||opType.equalsIgnoreCase("Add New"))) {
				//System.out.println("subComps size123  =" + subComps.size());
				if (subComps != null) {
							 if((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03"))
								&& assetCompTypeCode.equals("03")
								&& assetSubCompTypeCode.equals("001")) 
								{
							for (int i = 0; i < subComps.size(); i++) 
							{
								assetPipeline = (Asset_PipeLine) subComps.get(i);
								
								query1 = "DELETE FROM "+Tab_Prifix+"PUMPINGMAIN_TBL   where " 
										//+" ASSET_CODE='"+ assetCode+ "' and" 
										+" pumpingmain_code ='"+ assetPipeline.getPmCode() + "'";
								//System.out.println("query1123=" + query1);
								empMasterData.stmt.addBatch(query1);
								
								query1 = "DELETE FROM rws_pumpingmain_pipes where PM_CODE="
								//+" ASSET_CODE='"+ assetCode+ "' and" 
								+"'"+ assetPipeline.getPmCode() + "'";
								//System.out.println("query1123=" + query1);
								empMasterData.stmt.addBatch(query1);
							}
					}
					 else if((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03"))
								&& assetCompTypeCode.equals("03")	&& assetSubCompTypeCode.equals("002")) {
											for (int i = 0; i < subComps.size(); i++) {
												assetPipeline = (Asset_PipeLine) subComps.get(i);
												//System.out.println("asset code in distribtion   "+ assetPipeline.getAssetCode());
												//System.out.println("distri code in distribtion   "+ assetPipeline.getDisCode());
												query1 = "DELETE FROM "+Tab_Prifix+"GRAVITYMAIN_TBL where " 
														//+"ASSET_CODE='"+ assetCode	+ "' and" 
														+" GRAVITYMAIN_CODE ='"	+ assetPipeline.getGravitymain_code() + "'";
												//System.out.println("query1123=" + query1);
												empMasterData.stmt.addBatch(query1);
												
												query1 = "DELETE FROM rws_gravitymain_pipes where GM_CODE="
												//+"ASSET_CODE='"+ assetCode	+ "' and" 
												+"'"+ assetPipeline.getGravitymain_code() + "'";
												//System.out.println("query1123=" + query1);
												empMasterData.stmt.addBatch(query1);
											} 
										}	 							 
						else if((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03"))
								&& assetCompTypeCode.equals("03")
									&& assetSubCompTypeCode.equals("003")) {
								for (int i = 0; i < subComps.size(); i++) {
									assetPipeline = (Asset_PipeLine) subComps.get(i);
									//System.out.println("asset code in distribtion   "+ assetPipeline.getAssetCode());
									//System.out.println("distri code in distribtion   "+ assetPipeline.getDisCode());
									query1 = "DELETE FROM "+Tab_Prifix+"DISTRI_SC_PARAM_TBL   where " 
											//+"ASSET_CODE='"+ assetCode	+ "' and" 
											+" DISTRISC_CODE ='"	+ assetPipeline.getDisCode() + "'";
									//System.out.println("query1123=" + query1);
									empMasterData.stmt.addBatch(query1);
									
									query1 = "DELETE FROM rws_distribution_pipes where DISTRISC_CODE="
									//+"ASSET_CODE='"+ assetCode	+ "' and" 
									+"'"	+ assetPipeline.getDisCode() + "'";
									//System.out.println("query1123=" + query1);
									empMasterData.stmt.addBatch(query1);
								} 
							}
							
									
					int[] updateCounts = empMasterData.stmt.executeBatch();
					for (int j = 0; j < updateCounts.length; j++) {
							System.err.print(updateCounts[j] + " iS DELETED  ");
						}
					rowCount = updateCounts.length;
					empMasterData.conn.commit();
					}					
			}*/
			if (compType.equals("Reservoirs") && (opType.equals("Modify")||opType.equalsIgnoreCase("Add New"))) {
				//System.out.println("subComps size= in modify" + subComps.size());
				if (subComps != null) {
					
						
						 if((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03")) 
						 	&& assetCompTypeCode.equals("04") &&
								 assetSubCompTypeCode.equals("001")) 
								{
									for (int i = 0; i < subComps.size(); i++) {
										assetReservior = (Asset_Reservior) subComps.get(i);
										query1 = "delete from  "+Tab_Prifix+"Ohsr_SC_PARAM_TBL  where " 
												//+"asset_code ='" + assetCode + "' and" 
												+" Ohsr_code ='"+assetReservior.getOhsrCode() +"'";
										//System.out.println("query1123=" + query1);
										empMasterData.stmt.addBatch(query1);
										
										//for deleting habitation linkage
										query1 = "delete from  RWS_OHGLCI_HAB_LINK_TBL   where " 
										//+"asset_code ='" + assetCode + "' and" 
										+" SUBCOMP_CODE ='"+assetReservior.getOhsrCode() +"'";
										//System.out.println("query1123=" + query1);
										empMasterData.stmt.addBatch(query1);
										
									}

								}
						else if((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03")) 
							&& assetCompTypeCode.equals("04") && assetSubCompTypeCode.equals("002")) 
								{
							for (int i = 0; i < subComps.size(); i++) {
								assetReservior = (Asset_Reservior) subComps.get(i);
								query1 = "delete from  "+Tab_Prifix+"Ohbr_SC_PARAM_TBL  where " 
										//+"asset_code ='" + assetReservior.getAssetCode() + "' and" 
										+" Ohbr_code ='"+assetReservior.getOhbrCode() +"'";
								//System.out.println("query1123=" + query1);
								empMasterData.stmt.addBatch(query1);
								}
								}
								if((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03")) && assetCompTypeCode.equals("04") &&
								 assetSubCompTypeCode.equals("003")) 
								{
							for (int i = 0; i < subComps.size(); i++) {
								assetReservior = (Asset_Reservior) subComps.get(i);
									query1 = "delete from  "+Tab_Prifix+"GLSR_SC_PARAM_TBL  where " 
											//+"asset_code ='" + assetReservior.getAssetCode() + "' and" 
											+" glsr_code ='"+assetReservior.getGlsrCode() +"'";
									//System.out.println("query1123=" + query1);
									empMasterData.stmt.addBatch(query1);
									
									
									//for deleting habitation linkage
									query1 = "delete from  RWS_OHGLCI_HAB_LINK_TBL   where " 
										//+"asset_code ='" + assetCode + "' and" 
										+" SUBCOMP_CODE ='"+assetReservior.getGlsrCode() +"'";
										//System.out.println("query1123=" + query1);
										empMasterData.stmt.addBatch(query1);
									}
								}
								else if((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03"))
										&& assetCompTypeCode.equals("04") &&
								 assetSubCompTypeCode.equals("004")) 
								{
							for (int i = 0; i < subComps.size(); i++) {
								assetReservior = (Asset_Reservior) subComps.get(i);
								 query1 = "delete from  "+Tab_Prifix+"Glbr_SC_PARAM_TBL  where " 
								 		//+"asset_code ='" + assetReservior.getAssetCode() + "' and" 
										+" Glbr_code ='"+assetReservior.getGlbrCode() +"'";
								//System.out.println("query1123=" + query1);
								empMasterData.stmt.addBatch(query1);
								}
								}
								else if((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03"))
										&& assetCompTypeCode.equals("04") &&
								 assetSubCompTypeCode.equals("005")) 
								{
							for (int i = 0; i < subComps.size(); i++) {
								assetReservior = (Asset_Reservior) subComps.get(i);
								 query1 = "delete from "+Tab_Prifix+"BPT_PARAM_TBL   where " 
								 		//+"asset_code ='" + assetReservior.getAssetCode() + "' and" 
										+" BPT_CODE   ='"+ assetReservior.getBptCode() +"'";
								//System.out.println("query1123=" + query1);
								empMasterData.stmt.addBatch(query1);
									}
								}
								else if((assetTypeCode.equals("01") || assetTypeCode.equals("02") || assetTypeCode.equals("03"))
										&& assetCompTypeCode.equals("04") &&
								 assetSubCompTypeCode.equals("006")) 
								{
							for (int i = 0; i < subComps.size(); i++) {
								assetReservior = (Asset_Reservior) subComps.get(i);
								 query1 = "delete from "+Tab_Prifix+"CIS_SC_PARAM_TBL  where " 
								 		//+"asset_code ='" + assetReservior.getAssetCode() + "' and" 
										+" CISSC_CODE    ='"+ assetReservior.getCisCode() +"'";
								//System.out.println("query1123=" + query1);
								empMasterData.stmt.addBatch(query1);
								
								
								//for deleting habitation linkage
								query1 = "delete from  RWS_OHGLCI_HAB_LINK_TBL   where " 
									//+"asset_code ='" + assetCode + "' and" 
									+" SUBCOMP_CODE ='"+assetReservior.getCisCode() +"'";
									//System.out.println("query1123=" + query1);
									empMasterData.stmt.addBatch(query1);
									}
								}
				
				
				int[] updateCounts = empMasterData.stmt.executeBatch();
				rowCount = updateCounts.length;
				empMasterData.conn.commit();
				
				}
				
			}
			} catch (Exception e) {
			//System.out.println("Error in insertAssetSubCompParams="
					+ e.getMessage());
		} finally {

			empMasterData.closeAll();
		}
		
		return rowCount;
	}
	public static int insertAssetSubCompPipeTypeParams(DataSource dataSource,String code,ArrayList subComps)
	{
		Asset_PipeLine assetPipeline = new Asset_PipeLine();
		String query1 = "";
		String query = "";
		int rowCount=0;
		Statement stm = null;
		//System.out.println("subComps size=" + subComps.size());
		EmpMasterData empMasterData=new EmpMasterData();
		try {
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			stm = empMasterData.conn.createStatement();
			empMasterData.conn.setAutoCommit(false);
			//System.out.println("entering for");
			SubCompMetaData subCompMetaData=new SubCompMetaData(code);
			String subCompCode=subCompMetaData.getAssetSubCompTypeCode();
			//System.out.println("subCompCode is "+subCompCode);
			for (int i = 0; i < subComps.size(); i++) 
			{
				//System.out.println("in for");
				assetPipeline = (Asset_PipeLine) subComps.get(i);
				String pipeClass=assetPipeline.getPclass();
				String pipeMaterial=assetPipeline.getMaterial();
				//System.out.println("doing float");
				float pipeDiameter=Float.parseFloat(formatString(assetPipeline.getDiameter()));
				float pipeLength=Float.parseFloat(formatString(assetPipeline.getLength()));
				//System.out.println("float done");
				String selectQuery =null;
				if(subCompCode.equals("001"))
				selectQuery = "select count(*)count from rws_pumpingmain_pipes_tbl " 
				 		           + "where pm_code='"+code+"' and pm_mat='"+pipeMaterial+"'"
				 		           + " and pm_cla='"+pipeClass+"' and pm_dia="+pipeDiameter;
				else if(subCompCode.equals("002"))
				selectQuery = "select count(*)count from rws_gravitymain_pipes_tbl " 
		 		           + "where gm_code='"+code+"' and pm_mat='"+pipeMaterial+"'"
		 		           + " and pm_cla='"+pipeClass+"' and pm_dia="+pipeDiameter;
		
				else if(subCompCode.equals("003"))
				selectQuery = "select count(*)count from rws_distribution_pipes_tbl " 
		 		           + "where distrisc_code='"+code+"' and dis_mat='"+pipeMaterial+"'"
		 		           + " and dis_cla='"+pipeClass+"' and dis_dia="+pipeDiameter;
		
				//System.out.println("select query is "+selectQuery);
				empMasterData.rs=stm.executeQuery(selectQuery);
				if(empMasterData.rs.next())
				{	//System.out.println("select count is"+empMasterData.rs.getInt("count"));
					if(empMasterData.rs.getInt("count")==0)
					{
						if(subCompCode.equals("001"))
						query = "insert into rws_pumpingmain_pipes_tbl(pm_code,pm_mat,pm_cla,pm_len,pm_dia)" 
							  + " values('"+code+"','"+pipeMaterial+"','"
							  + pipeClass+"',nvl('"+pipeLength+"',0),"+pipeDiameter+")";
						else if(subCompCode.equals("002"))
							query = "insert into rws_gravitymain_pipes_tbl(gm_code,pm_mat,pm_cla,pm_len,pm_dia)" 
								  + " values('"+code+"','"+pipeMaterial+"','"
								  + pipeClass+"',nvl('"+pipeLength+"',0),"+pipeDiameter+")";
						else if(subCompCode.equals("003"))
							query = "insert into rws_distribution_pipes_tbl(distrisc_code,dis_mat,dis_cla,dis_len,dis_dia)" 
								  + " values('"+code+"','"+pipeMaterial+"','"
								  + pipeClass+"',nvl('"+pipeLength+"',0),"+pipeDiameter+")";
								
						//System.out.println("query in rwc else  "+query);
						empMasterData.stmt.addBatch(query);
					}
					else
					{
						if(subCompCode.equals("001"))
							query = "update  rws_pumpingmain_pipes_tbl set pm_code='"+code+"',pm_mat='"+pipeMaterial+"',pm_cla='"+ pipeClass+"',pm_len="+"nvl('"+pipeLength+"',0),pm_dia="+pipeDiameter; 
						else if(subCompCode.equals("002"))
							query = "update  rws_gravitymain_pipes_tbl set gm_code='"+code+"',pm_mat='"+pipeMaterial+"',pm_cla='"+ pipeClass+"',pm_len="+"nvl('"+pipeLength+"',0),pm_dia="+pipeDiameter; 
						else if(subCompCode.equals("003"))
							query = "update  rws_distribution_pipes_tbl set distrisc_code='"+code+"',dis_mat='"+pipeMaterial+"',dis_cla='"+ pipeClass+"',dis_len="+"nvl('"+pipeLength+"',0),dis_dia="+pipeDiameter; 
								
						//System.out.println("query in rwc else  "+query);
						empMasterData.stmt.addBatch(query);
						
					}
				}	
			}
			int[] updateCounts = empMasterData.stmt.executeBatch();
			rowCount = updateCounts.length;
			if(rowCount>0)
				//System.out.println("record inserted into rwc   ");
				empMasterData.conn.commit();
	}catch(Exception e){//System.out.println("Exception in insertAssetSubCompPipeTypeParams "+e);}
	finally {
			try{
		empMasterData.closeAll();
			}catch(Exception e){//System.out.println("Exception in closing connections in insertAssetSubCompParams :"+e);}
	}
	return rowCount;
	}
	
	public static ArrayList getPipeMaterialList(DataSource dataSource,String code)
	{	
		ArrayList subcompParams=new ArrayList();	
		EmpMasterData empMasterData=new EmpMasterData();
		String query = "";
		empMasterData.stmt = null;
		SubCompMetaData subCompMetaData=new SubCompMetaData(code);
		String subCompCode=subCompMetaData.getAssetSubCompTypeCode();
		//System.out.println("code is "+code);
		//System.out.println("subCompCode is "+subCompCode);
		
			
		try {
				CommonLists commonLists=new CommonLists();
				Asset_PipeLine assetPipeline;
				empMasterData.conn = dataSource.getConnection();
				empMasterData.stmt = empMasterData.conn.createStatement();
				//System.out.println("1");
				if(subCompCode.equals("001"))
					query="select * from rws_pumpingmain_pipes_tbl where PM_CODE='"+code+"'";
				else if(subCompCode.equals("002"))
					query="select * from rws_gravitymain_pipes_tbl where GM_CODE='"+code+"'";
				else if(subCompCode.equals("003"))
					query="select * from rws_distribution_pipes_tbl where DISTRISC_CODE='"+code+"'";
				//System.out.println("2");	
				if(subCompCode.equals("001")||subCompCode.equals("002"))
				{
					//System.out.println("3");
				//System.out.println("query in getPipeMaterialList is "+query);
				empMasterData.rs=empMasterData.stmt.executeQuery(query);
					while(empMasterData.rs.next())
					{
						//System.out.println(" in while");
						assetPipeline = new Asset_PipeLine();
						assetPipeline.setMaterial(empMasterData.rs.getString("pm_mat"));
						assetPipeline.setPclass(empMasterData.rs.getString("pm_cla"));
						assetPipeline.setDiameter(empMasterData.rs.getInt("pm_dia")+"");
						assetPipeline.setLength(empMasterData.rs.getInt("pm_len")+"");
						//System.out.println("dimater is "+assetPipeline.getDiameter());
						//System.out.println("empMasterData.rs.getFloat(pm_dia) is "+empMasterData.rs.getFloat("pm_dia"));
						subcompParams.add(assetPipeline);
					}	
				}
				
				if(subCompCode.equals("003"))
				{
				//System.out.println("query in getPipeMaterialList is "+query);
				empMasterData.rs=empMasterData.stmt.executeQuery(query);
					while(empMasterData.rs.next())
					{
						//System.out.println(" in while");
						assetPipeline = new Asset_PipeLine();
						assetPipeline.setMaterial(empMasterData.rs.getString("dis_mat"));
						assetPipeline.setPclass(empMasterData.rs.getString("dis_cla"));
						assetPipeline.setDiameter(empMasterData.rs.getInt("dis_dia")+"");
						assetPipeline.setLength(empMasterData.rs.getInt("dis_len")+"");
						//System.out.println("dimater is "+assetPipeline.getDiameter());
						//System.out.println("empMasterData.rs.getFloat(dis_dia) is "+empMasterData.rs.getFloat("dis_dia"));
						subcompParams.add(assetPipeline);
					}	
				}
			}
			catch(Exception e){//System.out.println("Excetion in getPipeMaterialList "+e);}
			//System.out.println("size of subcompParams is EmpMaster is "+subcompParams.size());
			return subcompParams;
		}
	
	public static int deletePipeLineSubComp(DataSource dataSource,String code,String assetTypeCode,String assetCompTypeCode,String assetSubCompTypeCode) throws Exception
	{
		int rowCount=0;
		String TabPrifix="";
		String colName="";
		String pipesTbl="";
		String pipesTblColName="";
		EmpMasterData empMasterData=new EmpMasterData();
		if(assetTypeCode.equals("01")) 
			TabPrifix = "RWS_PWS_";
		else if(assetTypeCode.equals("02") ) 
			TabPrifix = "RWS_MPWS_";
		else if(assetTypeCode.equals("03")) 
			TabPrifix = "RWS_CPWS_";
		
		if(assetCompTypeCode.equals("03")&& assetSubCompTypeCode.equals("001"))
		{
			TabPrifix=TabPrifix+"PUMPINGMAIN_TBL";
			colName="PUMPINGMAIN_CODE";
			pipesTbl="rws_pumpingmain_pipes_tbl";
			pipesTblColName="PM_CODE";
		}
		else if(assetCompTypeCode.equals("03")&& assetSubCompTypeCode.equals("002"))
		{
			TabPrifix=TabPrifix+"GRAVITYMAIN_TBL";
			colName="GRAVITYMAIN_CODE";
			pipesTbl="rws_gravitymain_pipes_tbl";
			pipesTblColName="GM_CODE";
		}
		else if(assetCompTypeCode.equals("03")&& assetSubCompTypeCode.equals("003"))
		{
			TabPrifix=TabPrifix+"DISTRI_SC_PARAM_TBL ";
			colName="DISTRISC_CODE";
			pipesTbl="rws_distribution_pipes_tbl";
			pipesTblColName="DISTRISC_CODE";
		}
		
		try 
		{
			empMasterData.conn = dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			Asset_PipeLine assetPipeline;
			empMasterData.conn.setAutoCommit(false);
			//System.out.println("entering for");
			
				String deleteQuery = "delete from "+TabPrifix+" where "+colName+"='"+code+"'";
				//System.out.println("select query is "+deleteQuery);
				empMasterData.stmt.addBatch(deleteQuery);
				
				deleteQuery = "DELETE FROM "+pipesTbl+" where "+pipesTblColName+"='"+code+"'";
					
					//System.out.println("query1123=" + deleteQuery);
					empMasterData.stmt.addBatch(deleteQuery);
					
		
			int[] updateCounts = empMasterData.stmt.executeBatch();
			rowCount = updateCounts.length;
			if(rowCount>0)
				//System.out.println("record inserted into rwc   ");
			empMasterData.conn.commit();
		}catch(Exception e){//System.out.println("Exception in insertAssetSubCompPipeTypeParams "+e);}
		finally 
		{
			empMasterData.closeAll();
		}
	return rowCount;
	}
		
		
	public static ArrayList getAssetNextSubCompParams(DataSource dataSource, String assetCode, String assetTypeCode, String assetCompCode, String assetSubCompCode,String habCode, String pumpCode,String opType)
	{
		EmpMasterData empMasterData=new EmpMasterData();
		empMasterData.conn = null;
		empMasterData.stmt=null;
		empMasterData.rs=null;
		ArrayList parameters=new ArrayList();
		try{
			empMasterData.conn=dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement(
	                ResultSet.TYPE_SCROLL_INSENSITIVE,
	                ResultSet.CONCUR_UPDATABLE);
			String query="";
			String Tab_Prifix = "";
			

		
			if( assetTypeCode.equals("01"))
				Tab_Prifix =  "RWS_PWS_" ;
			else if( assetTypeCode.equals("02"))
				Tab_Prifix =  "RWS_MPWS_" ;
			else if( assetTypeCode.equals("03"))
				Tab_Prifix =  "RWS_CPWS_" ;
		
			//System.out.println("hiiiiiiiiiiiiiiii=" + assetTypeCode + "  "
					+ assetCompCode + "  " + assetSubCompCode + " " + pumpCode);
			
			if( (assetTypeCode.equals("01")||assetTypeCode.equals("02")||assetTypeCode.equals("03")) 
					&& assetCompCode.equals("01")
					&& assetSubCompCode.equals("003")) 
			{
				Asset_Pumpset asset_pumpset=new Asset_Pumpset();
				//System.out.println("in next function of EmpMaster 009");
			
				query = "select DT.ASSET_CODE,PUMP_CODE,PUMP_MAKE,PUMP_CPTY,PUMP_TYPE," +
				"YEAR_COMM,HR_RUN,USAGE,DESIGNED_LPM,DESIGNED_HEAD," 
			  +	"decode(CONTROL_PANEL,'Y','YES','N','NO','YES','YES','NO','NO')" 
			  +	"control_panel,LOW_VOLT_PROB,POWER_AVAIL_PER_DAY," 
			  +	"FEAS_URBAN_LINE,COST,URBAN_LINE_DISTANCE,SUGGESTIONS," 
			  +	"DT.HAB_CODE,DT.LOCATION,FEEDER from "
			  + Tab_Prifix+"SUBCOMP_PARAM_TBL DT" 
					  +	", RWS_ASSET_MAST_TBL A where DT.ASSET_CODE=A.ASSET_CODE " 
						//+"AND A.HAB_CODE='"+ habCode
					  + " and DT.asset_code='"+ assetCode+ "' order by PUMP_CODE";
			
				//System.out.println("query   "+query);
				empMasterData.rs =empMasterData.stmt.executeQuery(query);
		
				if(opType.equalsIgnoreCase("first"))
				{
					if(empMasterData.rs.first())
					{
						//System.out.println("in empMasterData.rs.first()");
						asset_pumpset = new Asset_Pumpset();
						asset_pumpset=getPumpsetsFromRs(dataSource,empMasterData.rs);
						
						asset_pumpset.setIsLast("false");
						parameters.add(asset_pumpset);
					}
					else
					{
						//System.out.println("not first");
					}
				}
				if(opType.equalsIgnoreCase("last"))
				{
					
					if(empMasterData.rs.last())
					{
						//System.out.println("in empMasterData.rs.last()");
						asset_pumpset = new Asset_Pumpset();
						asset_pumpset=getPumpsetsFromRs(dataSource,empMasterData.rs);
						asset_pumpset.setIsLast("true");
						parameters.add(asset_pumpset);
					}
					else
					{
						//System.out.println("not last");
					}
				}
				if(opType.equalsIgnoreCase("previous")||opType.equalsIgnoreCase("next"))
				{
					while (empMasterData.rs.next()) 
					{
						//System.out.println("in empMasterData.rs.next()");
						String code=empMasterData.rs.getString("PUMP_CODE");
						if(code.equals(pumpCode))
							break;
			
					}
				}
		
				if(opType.equalsIgnoreCase("previous"))
				{
					//System.out.println("in optype="+opType);
					if (empMasterData.rs.previous())
					{
						//System.out.println("in empMasterData.rs.previous()");
						asset_pumpset = new Asset_Pumpset();
						asset_pumpset=getPumpsetsFromRs(dataSource,empMasterData.rs);
						asset_pumpset.setIsLast("false");
						parameters.add(asset_pumpset);
						if(empMasterData.rs.previous())
						{
							asset_pumpset.setIsLast("false");
						}
						else
						{
							//System.out.println("*********NO MORE PREVIOUS RECORDS*********");
							asset_pumpset.setIsLast("true");
						}
					
					}
					else
					{
						//System.out.println("in empMasterData.rs.previous() else");
						//System.out.println("*********NO MORE PREVIOUS RECORDS*********");
						asset_pumpset.setIsLast("true");
					}
				}
			
					
				if(opType.equalsIgnoreCase("next"))
				{
					//System.out.println("in optype="+opType);
					if (empMasterData.rs.next()) 
					{
						//System.out.println("in empMasterData.rs.next()");
						asset_pumpset = new Asset_Pumpset();
						asset_pumpset=getPumpsetsFromRs(dataSource,empMasterData.rs);
						if(empMasterData.rs.next())
							asset_pumpset.setIsLast("false");
						else
						{
					
							asset_pumpset.setIsLast("true");
							//System.out.println("*********LAST RECORD*********");
						}
						parameters.add(asset_pumpset);
				
					
					}
					else
					{
						//System.out.println("in empMasterData.rs.next() else");
						asset_pumpset = new Asset_Pumpset();
						asset_pumpset.setIsLast("true");
					}
			
				}
			
			}
			
			if( (assetTypeCode.equals("01")||assetTypeCode.equals("02")||assetTypeCode.equals("03")) 
					&& assetCompCode.equals("03")
					&& assetSubCompCode.equals("001")) 
			{
				
				//%%%%%%rws_cpws_pm_sc_param_tbl changed to RWS_CPWS_PUMPINGMAIN_TBL
				
				

				//System.out.println("in next function of EmpMaster 009");
				Asset_PipeLine asset_pipeline=new Asset_PipeLine();
				
				query = "select * from  "+Tab_Prifix+"PUMPINGMAIN_TBL CP," 
					  +	"RWS_ASSET_MAST_TBL A where CP.ASSET_CODE=A.ASSET_CODE " 
					  //+	"AND A.HAB_CODE='"+habCode+"'"
					  + "  and CP.asset_code='"
					  + assetCode+"' order by PUMPINGMAIN_CODE";
				//System.out.println("the query is"+query);
				
				empMasterData.rs =empMasterData.stmt.executeQuery(query);
				
				asset_pipeline=null;
				
				//@rowcount - this code is for getting no. of rows in the resultset
				empMasterData.rs.last();
				int rowCount=empMasterData.rs.getRow();
				empMasterData.rs.beforeFirst();
				//end of @rowcount
				
				if(opType.equalsIgnoreCase("first"))
				{
					if(empMasterData.rs.first())
					{
						//System.out.println("in empMasterData.rs.first()");
						
						asset_pipeline=getPumpingMainFromRs(dataSource,empMasterData.rs);
						asset_pipeline.setRowCount(rowCount);
						asset_pipeline.setCurrentRow(empMasterData.rs.getRow());
						
						 if(empMasterData.rs.next())
						 	asset_pipeline.setIsLast("false");
						 else
						 	asset_pipeline.setIsLast("true");
						 
						 parameters.add(asset_pipeline);
						 
					}
					
				}
				if(opType.equalsIgnoreCase("last"))
				{
					
					if(empMasterData.rs.last())
					{
						//System.out.println("in empMasterData.rs.last()");
						asset_pipeline=null;
						asset_pipeline=getPumpingMainFromRs(dataSource,empMasterData.rs);
						asset_pipeline.setRowCount(rowCount);
						asset_pipeline.setCurrentRow(empMasterData.rs.getRow());
						
						 	asset_pipeline.setIsLast("true");
						 parameters.add(asset_pipeline);	 
					}
					
				}
				if(opType.equalsIgnoreCase("previous")||opType.equalsIgnoreCase("next"))
				{
					while (empMasterData.rs.next()) 
					{
						//System.out.println("in empMasterData.rs.next()");
						//System.out.println("current row in code comparision is "+empMasterData.rs.getRow());
						String code=empMasterData.rs.getString("PUMPINGMAIN_CODE");
						//System.out.println("code="+code);
						//System.out.println("pumpCode="+pumpCode);
						
						if(code.equals(pumpCode))
							break;
			
					}
				}
		
				if(opType.equalsIgnoreCase("previous"))
				{
					//System.out.println("in optype="+opType);
					if (empMasterData.rs.previous())
					{
						//System.out.println("in empMasterData.rs.previous()");
						asset_pipeline=null;
						asset_pipeline=getPumpingMainFromRs(dataSource,empMasterData.rs);
						asset_pipeline.setRowCount(rowCount);	
						asset_pipeline.setCurrentRow(empMasterData.rs.getRow());
			     	 	asset_pipeline.setIsLast("false");
						 parameters.add(asset_pipeline);
						if(empMasterData.rs.previous())
						{
							asset_pipeline.setIsLast("false");
						}
						else
						{
							
							//System.out.println("*********NO MORE PREVIOUS RECORDS*********");
							asset_pipeline.setIsLast("true");
						}
					
					}
					else
					{
						//System.out.println("in empMasterData.rs.previous() else");
						//System.out.println("*********NO MORE PREVIOUS RECORDS*********");
						asset_pipeline.setIsLast("true");
					}
				}
			
					
				if(opType.equalsIgnoreCase("next"))
				{
					//System.out.println("in optype="+opType);
					if (empMasterData.rs.next()) 
					{
						//System.out.println("in empMasterData.rs.next()");
						asset_pipeline=null;
						asset_pipeline=getPumpingMainFromRs(dataSource,empMasterData.rs);
						asset_pipeline.setCurrentRow(empMasterData.rs.getRow());
		     	 	 	asset_pipeline.setRowCount(rowCount);
		     	 	 	//System.out.println("currnet row in next is "+(empMasterData.rs.getRow()-1));
		     	 	 	
		     	 	 	
			     	 	 if(empMasterData.rs.next())
			     	 	 {
			     	 	 	asset_pipeline.setIsLast("false");
			     	 	 }
						else
						{
							asset_pipeline.setIsLast("true");
							//System.out.println("*********LAST RECORD*********");
						}
						parameters.add(asset_pipeline);
				
					
					}
					else
					{
						
						//System.out.println("in empMasterData.rs.next() else");
						asset_pipeline = new Asset_PipeLine();
						asset_pipeline.setCurrentRow(empMasterData.rs.getRow());
						asset_pipeline.setRowCount(rowCount);
						asset_pipeline.setIsLast("true");
					}
			
				}
		
			}
			
			if( (assetTypeCode.equals("01")||assetTypeCode.equals("02")||assetTypeCode.equals("03")) 
					&& assetCompCode.equals("03")
					&& assetSubCompCode.equals("002")) 
			{
				//System.out.println("in next function of EmpMaster 03 002");
				Asset_PipeLine asset_pipeline=new Asset_PipeLine();
				
				query = "select * from  "+Tab_Prifix+"GRAVITYMAIN_TBL CP," 
					  +	"RWS_ASSET_MAST_TBL A where CP.ASSET_CODE=A.ASSET_CODE " 
					  //+	"AND A.HAB_CODE='"+habCode+"'"
					  + "  and CP.asset_code='"
					  + assetCode+"' order by GRAVITYMAIN_CODE";
				//System.out.println("the query is"+query);
				
				
		      
			
				empMasterData.rs =empMasterData.stmt.executeQuery(query);
//				@rowcount - this code is for getting no. of rows in the resultset
				empMasterData.rs.last();
				int rowCount=empMasterData.rs.getRow();
				empMasterData.rs.beforeFirst();
				//end of @rowcount
				asset_pipeline=null;
				
				if(opType.equalsIgnoreCase("first")&&empMasterData.rs.first())
				{
						//System.out.println("in empMasterData.rs.first()");
						asset_pipeline=getGravityMainFromRs(dataSource,empMasterData.rs);
						asset_pipeline.setRowCount(rowCount);
						asset_pipeline.setCurrentRow(empMasterData.rs.getRow());
						parameters.add(asset_pipeline);
						if(empMasterData.rs.next())
						 	asset_pipeline.setIsLast("false");
						 else
						 	asset_pipeline.setIsLast("true");
						
				}
				if(opType.equalsIgnoreCase("last")&&empMasterData.rs.last())
				{
						//System.out.println("in empMasterData.rs.last()");
						asset_pipeline=getGravityMainFromRs(dataSource,empMasterData.rs);
						asset_pipeline.setRowCount(rowCount);
						asset_pipeline.setCurrentRow(empMasterData.rs.getRow());
						parameters.add(asset_pipeline);
						
						 	asset_pipeline.setIsLast("true");
				}
				if(opType.equalsIgnoreCase("previous")||opType.equalsIgnoreCase("next"))
				{
					while (empMasterData.rs.next()) 
					{
						//System.out.println("in empMasterData.rs.next()");
						String code=empMasterData.rs.getString("GRAVITYMAIN_CODE");
						//System.out.println("code="+code);
						//System.out.println("pumpCode="+pumpCode);
						if(code.equals(pumpCode))
							break;
			
					}
				}
		
				if(opType.equalsIgnoreCase("previous"))
				{
					//System.out.println("in optype="+opType);
					if (empMasterData.rs.previous())
					{
						//System.out.println("in empMasterData.rs.previous()");
						asset_pipeline=null;
						asset_pipeline=getGravityMainFromRs(dataSource,empMasterData.rs);
						asset_pipeline.setRowCount(rowCount);
						asset_pipeline.setCurrentRow(empMasterData.rs.getRow());
						
						asset_pipeline.setIsLast("false");
						parameters.add(asset_pipeline);
						if(empMasterData.rs.previous())
						{
							asset_pipeline.setIsLast("false");
						}
						else
						{
							//System.out.println("*********NO MORE PREVIOUS RECORDS*********");
							asset_pipeline.setIsLast("true");
						}
					
					}
					else
					{
						//System.out.println("in empMasterData.rs.previous() else");
						//System.out.println("*********NO MORE PREVIOUS RECORDS*********");
						asset_pipeline.setIsLast("true");
					}
				}
			
					
				if(opType.equalsIgnoreCase("next"))
				{
					//System.out.println("in optype="+opType);
					if (empMasterData.rs.next()) 
					{
						//System.out.println("in empMasterData.rs.next()");
						asset_pipeline=null;
						asset_pipeline=getGravityMainFromRs(dataSource,empMasterData.rs);
						asset_pipeline.setRowCount(rowCount);
						asset_pipeline.setCurrentRow(empMasterData.rs.getRow());
						
			     	 	 if(empMasterData.rs.next())
			     	 	 	asset_pipeline.setIsLast("false");
						else
						{
					
							asset_pipeline.setIsLast("true");
							//System.out.println("*********LAST RECORD*********");
						}
						parameters.add(asset_pipeline);
				
					
					}
					else
					{
						//System.out.println("in empMasterData.rs.next() else");
						asset_pipeline = new Asset_PipeLine();
						asset_pipeline.setIsLast("true");
					}
			
				}
		
			}
			
			//??????????
			
			
			
			
			if( (assetTypeCode.equals("01")||assetTypeCode.equals("02")||assetTypeCode.equals("03")) 
					&& assetCompCode.equals("03")
					&& assetSubCompCode.equals("003")) 
			{
				//System.out.println("in next function of EmpMaster 03 002");
				Asset_PipeLine asset_pipeline=new Asset_PipeLine();
				query = "select * from  "+Tab_Prifix+"DISTRI_SC_PARAM_TBL DIS,RWS_ASSET_MAST_TBL A where DIS.ASSET_CODE=A.ASSET_CODE " 
				 // +	"AND A.HAB_CODE='"+ habCode+"'"
				  + " and DIS.asset_code='"+ assetCode+"' order by DISTRISC_CODE";
				//System.out.println("the query is"+query);
				
				
		      
			
				empMasterData.rs =empMasterData.stmt.executeQuery(query);
				
				//@rowcount - this code is for getting no. of rows in the resultset
				empMasterData.rs.last();
				int rowCount=empMasterData.rs.getRow();
				empMasterData.rs.beforeFirst();
				//end of @rowcount
				asset_pipeline=null;
		
				if(opType.equalsIgnoreCase("first"))
				{
					if(empMasterData.rs.first())
					{
						//System.out.println("in empMasterData.rs.first()");
						asset_pipeline=null;
						asset_pipeline=getDistributionFromRs(dataSource,empMasterData.rs);
						asset_pipeline.setRowCount(rowCount);
						asset_pipeline.setCurrentRow(empMasterData.rs.getRow());
						if(empMasterData.rs.next())
						 	asset_pipeline.setIsLast("false");
						 else
						 	asset_pipeline.setIsLast("true");
						
						 parameters.add(asset_pipeline);	 
					}
					else
					{
						//System.out.println("not first");
					}
				}
				if(opType.equalsIgnoreCase("last"))
				{
					
					if(empMasterData.rs.last())
					{
						//System.out.println("in empMasterData.rs.last()");
						asset_pipeline=null;
						asset_pipeline=getDistributionFromRs(dataSource,empMasterData.rs);
						asset_pipeline.setRowCount(rowCount);
						asset_pipeline.setCurrentRow(empMasterData.rs.getRow());
						
						 	asset_pipeline.setIsLast("true");
						 parameters.add(asset_pipeline);	 
					}
					else
					{
						//System.out.println("not last");
					}
				}
				if(opType.equalsIgnoreCase("previous")||opType.equalsIgnoreCase("next"))
				{
					while (empMasterData.rs.next()) 
					{
						//System.out.println("in empMasterData.rs.next()");
						String code=empMasterData.rs.getString("DISTRISC_CODE");
						//System.out.println("code="+code);
						//System.out.println("pumpCode="+pumpCode);
						if(code.equals(pumpCode))
							break;
			
					}
				}
		
				if(opType.equalsIgnoreCase("previous"))
				{
					//System.out.println("in optype="+opType);
					if (empMasterData.rs.previous())
					{
						//System.out.println("in empMasterData.rs.previous()");
						asset_pipeline=null;
						asset_pipeline=getDistributionFromRs(dataSource,empMasterData.rs);
						asset_pipeline.setRowCount(rowCount);
						asset_pipeline.setCurrentRow(empMasterData.rs.getRow());
	    				
						
			     	 	asset_pipeline.setIsLast("false");
						 parameters.add(asset_pipeline);
						if(empMasterData.rs.previous())
						{
							asset_pipeline.setIsLast("false");
						}
						else
						{
							//System.out.println("*********NO MORE PREVIOUS RECORDS*********");
							asset_pipeline.setIsLast("true");
						}
					
					}
					else
					{
						//System.out.println("in empMasterData.rs.previous() else");
						//System.out.println("*********NO MORE PREVIOUS RECORDS*********");
						asset_pipeline.setIsLast("true");
					}
				}
			
					
				if(opType.equalsIgnoreCase("next"))
				{
					//System.out.println("in optype="+opType);
					if (empMasterData.rs.next()) 
					{
						//System.out.println("in empMasterData.rs.next()");
						asset_pipeline=null;
						asset_pipeline=getDistributionFromRs(dataSource,empMasterData.rs);
						asset_pipeline.setRowCount(rowCount);
						asset_pipeline.setCurrentRow(empMasterData.rs.getRow());
	    				
						
			     	 	 if(empMasterData.rs.next())
			     	 	 	asset_pipeline.setIsLast("false");
						else
						{
					
							asset_pipeline.setIsLast("true");
							//System.out.println("*********LAST RECORD*********");
						}
						parameters.add(asset_pipeline);
				
					
					}
					else
					{
						//System.out.println("in empMasterData.rs.next() else");
						asset_pipeline = new Asset_PipeLine();
						asset_pipeline.setIsLast("true");
					}
			
				}
		
			}
		}catch(Exception e){//System.out.println("Exception in Next of 009 :"+e);}
		finally
		{
			try{
			//empMasterData.rs.close();
			//empMasterData.stmt.close();
			empMasterData.closeAll();
			}catch(Exception e){//System.out.println("Exception in closing connection "+e);}
		}
		return parameters;
		
	}
		

	public static Asset_PipeLine getPumpingMainFromRs(DataSource dataSource,ResultSet rs) throws Exception
	{
		Asset_PipeLine asset_pipeline = new Asset_PipeLine();
		
		asset_pipeline.setAssetCode(rs.getString("ASSET_CODE"));
		asset_pipeline.setPmCode(rs.getString("PUMPINGMAIN_CODE"));
		asset_pipeline.setHabCode(rs.getString("HAB_CODE"));
		asset_pipeline.setPmLen(rs.getString("LENGTH"));
		asset_pipeline.setPmAvNo(rs.getString("AIRVALVE_NO"));
		asset_pipeline.setPmScrvNo(rs.getString("SCOUREVALVE"));		
		asset_pipeline.setPmRvNo (rs.getString("REFLEXVALVE"));
		asset_pipeline.setPmSvNo(rs.getString("SLUICEVALVE"));
		asset_pipeline.setNoOfPipes(getNoOfPipeTypes(dataSource,"01","001",rs.getString("PUMPINGMAIN_CODE"))+"");
		//asset_pipeline.setNoOfPipes(rs.getString("NO_OF_PIPES"));
		asset_pipeline.setPmZeroVelocityValve(rs.getString("ZERO_VELOCITY_VALVE"));
		asset_pipeline.setPmAirCusionValve(rs.getString("AIR_CUSHION_VALVE"));
		asset_pipeline.setPmLocation(rs.getString("LOCATION"));
		
		return asset_pipeline;
	}

	public static Asset_PipeLine getGravityMainFromRs(DataSource dataSource,ResultSet rs) throws Exception
	{
		Asset_PipeLine asset_pipeline = new Asset_PipeLine();
		
		asset_pipeline.setAssetCode(rs.getString("ASSET_CODE"));
		asset_pipeline.setGravitymain_code(rs
								.getString("GRAVITYMAIN_CODE"));
		asset_pipeline.setHabCode(rs.getString("HAB_CODE"));
		asset_pipeline.setLengths(rs.getString("LENGTH"));
						//asset_pipeline.setMet_type(rs.getString("MET_TYPE"));
		asset_pipeline.setAirvalve_no(rs.getString("AIRVALVE_NO"));
		asset_pipeline.setNoOfPipes(getNoOfPipeTypes(dataSource,"01","002",rs.getString("GRAVITYMAIN_CODE"))+"");
		asset_pipeline.setScourevalve(rs.getString("SCOUREVALVE"));
		asset_pipeline.setReflexvalve(rs.getString("REFLEXVALVE"));
		asset_pipeline.setSluicevalve(rs.getString("SLUICEVALVE"));

		return asset_pipeline;
						
	}

	

	public static Asset_PipeLine getDistributionFromRs(DataSource dataSource,ResultSet rs) throws Exception
	{
		Asset_PipeLine asset_pipeline = new Asset_PipeLine();
		asset_pipeline.setAssetCode(rs.getString("ASSET_CODE"));
		asset_pipeline.setHabCode(rs.getString("HAB_CODE"));
		asset_pipeline.setNoOfPipes(getNoOfPipeTypes(dataSource,"01","003",rs.getString("DISTRISC_CODE"))+"");
		//asset_pipeline.setDisMaterial(rs.getString("DIS_MAT"));
		//asset_pipeline.setDisClass(rs.getString("DIS_CLA"));
		//asset_pipeline.setDisDiameter(rs.getString("DIS_DIA"));
		asset_pipeline.setDisLengths(rs.getInt("DIS_LEN")+"");
		asset_pipeline.setDisFullVillagesCovered(rs.getString("DIS_COVE"));
		asset_pipeline.setDisTotalLengthNeeded(rs.getFloat("DIS_LN")+"");
		asset_pipeline.setDisTotalLengthProvided(rs.getFloat("DIS_TLC")+"");
		asset_pipeline.setDisBalanceNeeded(rs.getFloat("DIS_BN")+"");
		asset_pipeline.setDisCode(rs.getString("DISTRISC_CODE"));
	    asset_pipeline.setDisMaterialCode(rs.getString("DIS_MAT_CODE"));
	    asset_pipeline.setDisNoOfPipes(rs.getInt("NO_OF_PIPES")+"");
	    asset_pipeline.setDisHabCode(rs.getString("HAB_CODE"));
	    asset_pipeline.setDisNoOfAirValves(rs.getInt("NO_AIRVALVES")+"");
	    asset_pipeline.setDisNoOfScourValves(rs.getInt("NO_SCOURVALVES")+"");
	    asset_pipeline.setDisNoOfSluiceValves(rs.getInt("NO_SLUICEVALVES")+"");
	    asset_pipeline.setDisNoOfPrivateHouseConnections(rs.getInt("NO_PR_HC")+"");
	    asset_pipeline.setDisLocation(rs.getString("LOCATION"));
	    				
	    asset_pipeline.setDisNoOfStandPosts(rs.getInt("NO_STANDPOSTS")+"");

		return asset_pipeline;
	}

	public static Asset_Pumpset getPumpsetsFromRs(DataSource dataSource,ResultSet rs) throws Exception
	{
		Asset_Pumpset asset_pumpset=new Asset_Pumpset();
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
		
		asset_pumpset.setPumpHoursOfPowerAvailability(rs.getString("POWER_AVAIL_PER_DAY"));
		asset_pumpset.setPumpFeasiblityOfGettingUrbanLine(rs.getString("FEAS_URBAN_LINE"));
		asset_pumpset.setPumpAppCostOfUrbanFeeder(rs.getString("COST"));
		asset_pumpset.setPumpDistanceFromWhereUrbanLineCanBeHad(rs.getString("URBAN_LINE_DISTANCE"));
		
		asset_pumpset.setPumpSuggestions(rs.getString("SUGGESTIONS"));
		asset_pumpset.setHabCode(format(rs.getString("HAB_CODE")));
		
		asset_pumpset.setPumpLocation(rs.getString("LOCATION"));
		asset_pumpset.setPumpFeeder(rs.getString("FEEDER"));
	
		return asset_pumpset;
	}
	public static String formatString(String str)
	{
		//System.out.println("string in format string is before updating :"+str);
		if(str==null || str.equals(""))
		{
		str="0";
		//System.out.println("str=''");
		}
		return str;
	}
	
	public static int getNoOfPipeTypes(DataSource dataSource,String compCode,String subCompCode,String code)
	{
		int count=0;
		EmpMasterData empMasterData=new EmpMasterData();
		empMasterData.conn=null;
		String tabPrifix="";
		String colName="";
		empMasterData.stmt=null;
		empMasterData.rs=null;
		//System.out.println("subCompCode is "+subCompCode);
		if((compCode.equals("01")||compCode.equals("02")||compCode.equals("03"))
				&&subCompCode.equals("001"))
		{
			tabPrifix="RWS_PUMPINGMAIN_PIPES_TBL";
			colName="PM_CODE";
		}
		if((compCode.equals("01")||compCode.equals("02")||compCode.equals("03"))
				&&subCompCode.equals("002"))
		{
			tabPrifix="RWS_GRAVITYMAIN_PIPES_TBL";
			colName="GM_CODE";
		}
		if((compCode.equals("01")||compCode.equals("02")||compCode.equals("03"))
				&&subCompCode.equals("003"))
		{
			tabPrifix="RWS_DISTRIBUTION_PIPES_TBL";
			colName="DISTRISC_CODE";
		}
		try{
			empMasterData.conn=dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement(
	                ResultSet.TYPE_SCROLL_INSENSITIVE,
	                ResultSet.CONCUR_UPDATABLE);
			String query="select count(*)count from "+tabPrifix+" where "+colName+"='"+code+"'";
			empMasterData.rs=empMasterData.stmt.executeQuery(query);
			//System.out.println("query is "+query);
			if(empMasterData.rs.next())
			count=empMasterData.rs.getInt("count");
		
		}catch(Exception e){//System.out.println("Exception in getNoOfPipeTypes"+e);}
		finally{
			try{
				
				//resultSet.close();
				//statement.close();
				empMasterData.closeAll();
			}catch(Exception e){//System.out.println("exception in closing connection in getNoOfPipeTypes "+e);}
		}
			
			return count;	
	}
	
	static public String getNextNewSlNo(DataSource dataSource,String tableName,String schemeCodeField,String habCode,String shortSchemeCode)
	{
		String slNo=null;
		String code=null;
		EmpMasterData empMasterData=new EmpMasterData();
		try{
			empMasterData.conn=dataSource.getConnection();
			empMasterData.stmt = empMasterData.conn.createStatement();
			//String query="select max(to_number(substr("+schemeCodeField+",22,3)))+1 from "+tableName+" where hab_code="+habCode+" and substr(13,3)="+shortSchemeCode;
			String query="SELECT MAX(to_number(substr("+schemeCodeField+",22,3)))+1 FROM "+tableName+" where substr("+schemeCodeField+",1,16)='"+habCode+"' and substr("+schemeCodeField+",17,3)='"+shortSchemeCode+"'";

			//System.out.println("query is "+query);
			empMasterData.rs=empMasterData.stmt.executeQuery(query);
			if(empMasterData.rs.next())
			slNo=empMasterData.rs.getInt(1)+""; 
			if (slNo == null || slNo.equals("0") || slNo.equals("")) {
				slNo = "001";
			} else if (slNo.length() == 1) {
				slNo = "00" + slNo;
			}
			else if (slNo.length() == 2) {
				slNo = "0" + slNo;
			}
		
		}catch(Exception e){//System.out.println("Exception in getNextNewSlNo"+e);}
		finally{
			try{
			empMasterData.closeAll();
			}catch(Exception e){//System.out.println("Exception in closing connections");}
			}
			return slNo;
	}
	
	static public int  insertNextSchemeCode(DataSource dataSource,String tableName,String schemeCodeField,String nextSchemeCode,String assetCode)
	{
		int count=0;
		String query;
		EmpMasterData empMasterData=new EmpMasterData();
		try
		{
		empMasterData.conn=dataSource.getConnection();
		empMasterData.stmt=empMasterData.conn.createStatement();
		query="insert into ?(?,asset_code,hab_code) values(?,?,?)";
		//System.out.println("query is "+query);
		PreparedStatement ps = conn.prepareStatement(query);
		ps.setString(1, schemeCodeField);
		ps.setString(2, nextSchemeCode);
		ps.setString(3, assetCode);
		ps.setString(4,nextSchemeCode.substring(0,16));
		count=ps.executeUpdate();
		empMasterData.closeAll();
		return count;
		
		}
		catch(Exception e){//System.out.println("Exception in insertNextSchemeCode in EmpMasterData "+e);}
		
		return count;

	}
	static public String format(String val)
	{
		if(val==null||val.equals("null"))
			val="";
		return val;
	}
	 
	//@ocde added on 261206
	
	
	/*
	static public boolean insertHabLink(DataSource dataSource,String habLinkTable,ArrayList assetReservoirList,String subCompTypeCode)  throws Exception 
	{
		
		String query=null;
		int[] rowCount;
		boolean isInserted=true;
		String schemeCode=null;
		ArrayList checkedHabs;
		
		EmpMasterData empMasterData=new EmpMasterData();
		try{
			empMasterData.conn = dataSource.getConnection();
			empMasterData.conn.setAutoCommit(false);
			empMasterData.stmt = empMasterData.conn.createStatement();
			for(int j=0;j<assetReservoirList.size();j++)
			{
				//System.out.println("in assetReservoirList["+j+"] in EmpMasterData");
				checkedHabs=(((Asset_Reservior)assetReservoirList.get(j)).getSelectedHabLinks());
				if(subCompTypeCode.equals("001"))
				{
					
					schemeCode=(((Asset_Reservior)assetReservoirList.get(j)).getOhsrCode());
				}
				else if(subCompTypeCode.equals("003"))
					schemeCode=(((Asset_Reservior)assetReservoirList.get(j)).getGlsrCode());
				else if(subCompTypeCode.equals("006"))
					schemeCode=(((Asset_Reservior)assetReservoirList.get(j)).getCisCode());
				//System.out.println("scheme code in process is "+schemeCode);
				query = "DELETE FROM  "+habLinkTable+" where SUBCOMP_CODE='"
				+ schemeCode
				+ "'";
				empMasterData.stmt.addBatch(query);
				//System.out.println("query is "+query);
				if (checkedHabs != null) 
				{
					//System.out.println("checkedHabs.length is "+checkedHabs.size());
					for (int i = 0; i < checkedHabs.size(); i++) 
					{
						//System.out.println("1");
						HabSourceBean habSourceBean = (HabSourceBean) checkedHabs.get(i);
						//System.out.println("2");
						////System.out.println("habSourceBean.getHabCode()= "	+ habSourceBean.getHabCode());
						
						if (habSourceBean.getIsChecked().equals("true")) 
						{
							query = " INSERT INTO "+habLinkTable+"(SUBCOMP_CODE,HAB_CODE)  VALUES("
										+ "'"
										+ schemeCode
										+ "','"
										+ habSourceBean.getPanchRajCode().substring(0,
												16) + "')";
							//Debug	.println(i + ": Hab Source Query is " + query);
							//System.out.println("query3["+i+"] is "+query);
							empMasterData.stmt.addBatch(query);
						}//end of if
						
						
						
					}//end of for
				}//end of if
			}//end of for
				rowCount = empMasterData.stmt.executeBatch();

				for (int j = 0; j < rowCount.length; j++) {
					if (rowCount[j] == 0)
						isInserted = false;
				}

				if (isInserted)
					empMasterData.conn.commit();
				empMasterData.conn.setAutoCommit(true);
			} catch (Exception e) {
				//System.out.println("The error in insertSource= " + e);
				isInserted=false;
			} finally {
				empMasterData.closeAll();
			}
			return isInserted;
		}
*/
	
	static public boolean insertHabLink2(DataSource dataSource,String habLinkTable,ArrayList checkedHabs,String schemeCode)  throws Exception 
	{
		
		String query=null;
		int[] rowCount;
		boolean isInserted=true;
		
		
		//System.out.println("in insertHabLink2 in EmpMasterData");
		EmpMasterData empMasterData=new EmpMasterData();
		try{
			empMasterData.conn = dataSource.getConnection();
			empMasterData.conn.setAutoCommit(false);
			empMasterData.stmt = empMasterData.conn.createStatement();
			
				if (checkedHabs != null) 
				{
					//System.out.println("checkedHabs.length is "+checkedHabs.size());
					query = "DELETE FROM  "+habLinkTable+" where SUBCOMP_CODE='"
					+ schemeCode
					+ "'";
					empMasterData.stmt.addBatch(query);
					//System.out.println("query is "+query);
					
					for (int i = 0; i < checkedHabs.size(); i++) 
					{
						HabSourceBean habSourceBean = (HabSourceBean) checkedHabs.get(i);
						////System.out.println("habSourceBean.getHabCode()= "	+ habSourceBean.getHabCode());
						
						if (habSourceBean.getIsChecked().equals("true")) 
						{
							query = " INSERT INTO "+habLinkTable+"(SUBCOMP_CODE,HAB_CODE)  VALUES("
										+ "'"
										+ schemeCode
										+ "','"
										+ habSourceBean.getPanchRajCode().substring(0,
												16) + "')";
							//Debug	.println(i + ": Hab Source Query is " + query);
							//System.out.println("query3["+i+"] is "+query);
							empMasterData.stmt.addBatch(query);
						}//end of if
						
						
						
						
					}//end of for
				}//end of if
		
				rowCount = empMasterData.stmt.executeBatch();

				for (int j = 0; j < rowCount.length; j++) {
					if (rowCount[j] == 0)
						isInserted = false;
				}

				if (isInserted)
					empMasterData.conn.commit();
				empMasterData.conn.setAutoCommit(true);
			} catch (Exception e) {
				//System.out.println("The error in insertSource= " + e);
				isInserted=false;
			} finally {
				empMasterData.closeAll();
			}
			return isInserted;
		}
	
	
	public static String getHabName(DataSource dataSource,String habCode)
	throws Exception {   EmpMasterData empMasterData=new EmpMasterData();
	String name = null;
	empMasterData.conn=dataSource.getConnection();
	empMasterData.stmt1 = null;
	empMasterData.rs1 = null;
	try {
		empMasterData.stmt1 = empMasterData.conn.createStatement();
		empMasterData.rs1 = empMasterData.stmt1
				.executeQuery("SELECT PANCH_NAME FROM rws_panchayat_raj_tbl WHERE panch_code ='"
						+ habCode + "'");
		while (empMasterData.rs1.next()) {
			name = empMasterData.rs1.getString(1);

		}
	} catch (Exception e) {
		//System.out.println("The error in getHabName=" + e);
	} finally {
		empMasterData.closeAll();
	}
	return name;
	}
	
	public static String getDcode(DataSource dataSource,String dname) throws Exception
	{
		EmpMasterData empMasterData=new EmpMasterData();
		//System.out.println("in getDcode");
		String name = null;
		empMasterData.conn=dataSource.getConnection();
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			String query="select dcode from rws_district_tbl where dname='"
				+ dname + "'";
			//System.out.println("query in getDcode is "+query);
			empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
			while (empMasterData.rs1.next()) {
				name = empMasterData.rs1.getString(1);

			}
		} catch (Exception e) {
			//System.out.println("The error in getHabName=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return name;
		}
	
	public static int getSourceHabitationsCount(Connection conn,String sourceCode) throws Exception
	{
		//System.out.println("in getSourceHabitationsCount");
	int count=0;
	EmpMasterData empMasterData=new EmpMasterData();
	empMasterData.conn=conn;
	empMasterData.stmt1 = null;
	empMasterData.rs1 = null;
	
	try {
		empMasterData.stmt1 = empMasterData.conn.createStatement();
		String query="select count(SOURCE_CODE) from RWS_SOURCE_HABITATION_TBL where SOURCE_CODE='"
			+ sourceCode + "'";
		//System.out.println("count query in getSourceHabitationsCount is "+query);
		empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
		if(empMasterData.rs1.next()) {
			count = empMasterData.rs1.getInt(1);

		}
		//System.out.println("query in getDcode is "+query);
	}
	catch(Exception e){//System.out.println("exception in getSourceHabitaionsCount is "+e);}
		return count;
	}
}


