package nic.watersoft.masters;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;

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
//import java.util.Calendar;
//import java.util.Collection;

import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

//import nic.watersoft.commons.LabelValueBean;
//import nic.watersoft.commons.Debug;
import nic.watersoft.commons.CommonLists;
//import nic.watersoft.reports.rws_asset_CheckList_Bean;
//import nic.watersoft.wquality.RwsWQuality;

public class EmpMasterData {

	public static int connCount = 0;

	Connection conn = null;

	Statement stmt = null;

	Statement stmt1 = null;

	Statement stmt2 = null;

	Statement stmt3 = null;

	Statement stmt4 = null;

	ResultSet rs = null;

	PreparedStatement pstmt = null,pstmt1=null;

	static ResultSetMetaData rsm = null;

	ResultSet rs1 = null;

	ResultSet rs2 = null;

	ResultSet rs3 = null;

	ResultSet rs4 = null;

	static PreparedStatement ps = null;

	static SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");

	public static String errorMessage;

	static HttpSession session;

	// private static final RwsOffices RwsOffice = null;

	public void closeAll() throws Exception {
		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				Debug.println("The error in EmpMasterData" + e);
			}
			rs = null;
		}
		if (rs1 != null) {
			try {
				rs1.close();
			} catch (Exception e) {
				Debug.println("The error in EmpMasterData" + e);
			}
			rs1 = null;
		}
		if (rs2 != null) {
			try {
				rs2.close();
			} catch (Exception e) {
				Debug.println("The error in EmpMasterData" + e);
			}
			rs2 = null;
		}
		if (rs3 != null) {
			try {
				rs3.close();
			} catch (Exception e) {
				Debug.println("The error in EmpMasterData" + e);
			}
			rs3 = null;
		}
		if (rs4 != null) {
			try {
				rs4.close();
			} catch (Exception e) {
				Debug.println("The error in EmpMasterData" + e);
			}
			rs4 = null;
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt = null;
		}
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			pstmt = null;
		}
		if (stmt1 != null) {
			try {
				stmt1.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt1 = null;
		}
		if (pstmt1 != null) {
			try {
				pstmt1.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			pstmt1 = null;
		}
		if (stmt2 != null) {
			try {
				stmt2.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt2 = null;
		}
		if (stmt3 != null) {
			try {
				stmt3.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt3 = null;
		}
		if (stmt4 != null) {
			try {
				stmt4.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt4 = null;
		}
		if (ps != null) {
			try {
				ps.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			ps = null;
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			conn = null;
		}

	}

	// *******************************Contam
	// methods**********************************

	public static int insertContam(RwsMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rowCount = 0;

		try {

			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rowCount = empMasterData.stmt.executeUpdate("insert into RWS_CONTAMINATION_TBL values(" + "'"
					+ empMaster.getContamCode() + "'," + "'" + empMaster.getContamName().toUpperCase() + "')");
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			Debug.println("The error in insertContam" + e);
		}

		finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getContam(String contamCode, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt
					.executeQuery("select * from RWS_CONTAMINATION_TBL where CONTAMINATION_CODE=" + contamCode);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setContamCode(empMasterData.rs.getString(1));
				empMaster.setContamName(empMasterData.rs.getString(2));
			}
		} catch (Exception e) {
			Debug.println("The error in getContam" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getContams(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList contams = new ArrayList();

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt
					.executeQuery("select * from RWS_CONTAMINATION_TBL order by CONTAMINATION_CODE");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setContamCode(empMasterData.rs.getString(1));
				empMaster.setContamName(empMasterData.rs.getString(2));

				empMaster.setContamNoName(empMasterData.rs.getString(1) + " - " + empMasterData.rs.getString(2));

				contams.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println("The error in getContams" + e);
		} finally {
			empMasterData.closeAll();
		}
		return contams;
	}

	public static int removeContam(String contamCode, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rcount = 0;

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rcount = empMasterData.stmt
					.executeUpdate("delete  from RWS_CONTAMINATION_TBL where CONTAMINATION_CODE='" + contamCode + "'");
		} catch (Exception e) {
			Debug.println("The error in removeContam=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rcount;
	}

	public static int updateContam(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int updateCount = 0;

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			updateCount = empMasterData.stmt.executeUpdate(
					"update  RWS_CONTAMINATION_TBL set CONTAMINATION_NAME='" + empMaster.getContamName().toUpperCase()
							+ "' where CONTAMINATION_CODE='" + empMaster.getContamCode() + "'");
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			Debug.println("The error in updateContam " + sqle);
		} catch (Exception e) {
			Debug.println("The error in updateContam" + e);
		} finally {
			empMasterData.closeAll();
		}
		return updateCount;
	}

	public static String getContamCode(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		String code = null;

		try {
			empMasterData.conn = RwsOffices.getConn();
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
			Debug.println("The error in getContamCode=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	public static String getContamCode(String name, Connection conn) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = conn;
		String acode = null;
		try {
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt.executeQuery(
					"SELECT CONTAMINATION_CODE FROM RWS_CONTAMINATION_TBL where CONTAMINATION_NAME='" + name + "'");
			empMasterData.rs.next();
			acode = empMasterData.rs.getString(1);
		} catch (Exception e) {
			Debug.println("The error in getContamCode=" + e);
		} finally {
			empMasterData.stmt.close();
		}
		return acode;
	}

	// ***********************Designation
	// Methods**************************************************
	public static int insertDesgn(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rowCount = 0;
		String query = "";

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.pstmt = empMasterData.conn.prepareStatement( "insert into rws_designation_tbl values(?,?,?,?) ");
			empMasterData.pstmt.setString(1, empMaster.getDesgnCode() );
			empMasterData.pstmt.setString(2, empMaster.getDesgnAcr().toUpperCase() );
			empMasterData.pstmt.setString(3, empMaster.getDesgnName().toUpperCase() );
			empMasterData.pstmt.setString(4, empMaster.getDesgnType().toUpperCase() );
			rowCount = empMasterData.pstmt.executeUpdate();
			//Debug.println("insert query Desig " + query);
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			Debug.println("The error in insertDesgn " + sqle);
		} catch (Exception e) {
			Debug.println("The error in insertDesgn in RwsMsterData " + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getDesgn(String desgnCode, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.pstmt = empMasterData.conn.prepareStatement("select * from rws_designation_tbl where designation_code=?");
			empMasterData.pstmt .setString(1, desgnCode);
			empMasterData.rs = empMasterData.pstmt.executeQuery();
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setDesgnCode(empMasterData.rs.getString(1));
				empMaster.setDesgnAcr(empMasterData.rs.getString(2));
				empMaster.setDesgnName(empMasterData.rs.getString(3));
				empMaster.setDesgnType(empMasterData.rs.getString(4));
				//Debug.println("Desgn Type in Edit Part " + empMaster.getDesgnType());
			}
		} catch (Exception e) {
			Debug.println("The error in getDesgn in EmpMasterData " + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getDesgns() throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList desgns = new ArrayList();

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.pstmt = empMasterData.conn.prepareStatement("select * from rws_designation_tbl order by designation_code");
			empMasterData.rs = empMasterData.pstmt.executeQuery();
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setDesgnCode(empMasterData.rs.getString(1));
				empMaster.setDesgnAcr(empMasterData.rs.getString(2));
				empMaster.setDesgnName(empMasterData.rs.getString(3));
				empMaster.setDesgnType(empMasterData.rs.getString(4));
				desgns.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println("The error in getDesgns in EmpMasterData " + e);
		} finally {
			empMasterData.closeAll();
		}
		return desgns;
	}

	public static ArrayList getDesgns1(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList desgns = new ArrayList();

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt.executeQuery(
					"select DESIGNATION_CODE ,DESIGNATION_NAME  from rws_designation_tbl order by designation_code");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setLabel(empMasterData.rs.getString("DESIGNATION_NAME"));
				empMaster.setValue(empMasterData.rs.getString("DESIGNATION_CODE"));
				desgns.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println("The error in getDesgns=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return desgns;
	}

	public static ArrayList getSector1(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList sectorcode = new ArrayList();
		String query = null;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			query = "SELECT * FROM RWS_HEAD_OFFICE_TBL ORDER BY HEAD_OFFICE_CODE ";
			empMasterData.rs = empMasterData.stmt.executeQuery(query);
			Debug.println(query);
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setLabel(empMasterData.rs.getString("HEAD_OFFICE_NAME"));
				empMaster.setValue(empMasterData.rs.getString("HEAD_OFFICE_CODE"));
				sectorcode.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println("The error in getSector1=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return sectorcode;
	}
	// code added for Emp Status Form

	public static String[] getDesignations(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		String designations[] = new String[50];

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt
					.executeQuery("select * from rws_designation_tbl order by designation_code");
			int i = 0;
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setDesgnName(empMasterData.rs.getString(3));
				designations[i] = empMaster.getDesgnName();
			}
		} catch (Exception e) {
			Debug.println("The error in getDesgns=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return designations;
	}

	// for getting the Zones
	public static String[] getEmpZones(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		String designations[] = new String[50];

		try {
			Debug.println("in getZones");
			Debug.println("ConnCount is " + connCount);
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt.executeQuery("SELECT * FROM RWS_ZONE_MST_TBL order by ZONE_CODE");
			int i = 0;
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setZoneName(empMasterData.rs.getString(3));
				designations[i] = empMaster.getZoneName();
			}
		}

		catch (Exception e) {
			Debug.println("The error in zoneName" + e);
		} finally {
			empMasterData.closeAll();
		}
		return designations;
	}

	// end of Code added

	public static int removeDesgn(String desgnCode, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rcount = 0;

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			String qry = "SELECT COUNT(*) FROM rws_employee_tbl a,rws_designation_tbl b,rws_work_exp_voucher_tbl C where a.designation_code=b.designation_code AND (A.EMPLOYEE_CODE=RECORDED_BY OR A.EMPLOYEE_CODE=CHECK_MEASURED_BY OR A.EMPLOYEE_CODE=SUPER_CHECK_MEASURED_BY)and a.DESIGNATION_CODE='"
					+ desgnCode + "'";
			Debug.println("qry:" + qry);
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt1.executeQuery(qry);
			if (empMasterData.rs.next()) {
				if (empMasterData.rs.getInt(1) != 0)
					rcount = 0;
				else {
					String query = "delete from rws_designation_tbl where designation_code='" + desgnCode + "' ";
					rcount = empMasterData.stmt.executeUpdate(query);
					Debug.println("delete query " + query);
				}
			}
		} catch (Exception e) {
			Debug.println("The error in removeDesgn=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rcount;
	}

	public static int updateDesgn(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int updateCount = 0;

		try {
			empMasterData.conn = RwsOffices.getConn();
			ps = empMasterData.conn.prepareStatement("update rws_designation_tbl set designation_name=?,designation_acr=?,TEMP_PERMNENT=?  where designation_code=?");
			ps.setString(1, empMaster.getDesgnName().toUpperCase());
			ps.setString(2, empMaster.getDesgnAcr().toUpperCase());
			ps.setString(4, empMaster.getDesgnCode());
			ps.setString(3, empMaster.getDesgnType());
			updateCount = ps.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			Debug.println("The error in updateDesgn " + sqle);
		} catch (Exception e) {
			Debug.println("The error in updateDesgn in EmpMasterData " + e);
		} finally {
			empMasterData.closeAll();
		}
		return updateCount;
	}

	public static String getDesgnCode(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		String code = null;

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.pstmt = empMasterData.conn.prepareStatement("SELECT MAX(to_number(DESIGNATION_CODE))+1 FROM rws_designation_tbl");
			empMasterData.rs = empMasterData.pstmt.executeQuery();
			empMasterData.rs.next();
			code = empMasterData.rs.getString(1);
			if (code == null)
				code = "1";
		} catch (Exception e) {
			Debug.println("The error in getDesgnCode in EmpMasterData  " + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	public static int insertQual(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.pstmt = empMasterData.conn.prepareStatement("insert into RWS_QUALIFICATION_TBL values(?,?)");
			empMasterData.pstmt.setString(1, empMaster.getQualCode());
			empMasterData.pstmt.setString(2, empMaster.getQualName().toUpperCase() );
			rowCount = empMasterData.pstmt.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			Debug.println("The error in insertQual " + sqle);
		} catch (Exception e) {
			Debug.println("The error in insertQual in EmpMasterData " + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getQual(String qualCode, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.pstmt = empMasterData.conn
					.prepareStatement("select * from RWS_QUALIFICATION_TBL where qual_code=?");
			empMasterData.pstmt.setString(1, qualCode);
			empMasterData.rs = empMasterData.pstmt.executeQuery();
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setQualCode(empMasterData.rs.getString(1));
				empMaster.setQualName(empMasterData.rs.getString(2));
			}
		} catch (Exception e) {
			Debug.println("The error in getQual in EmpMasterData " + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getQuals(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList quals = new ArrayList();
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.pstmt = empMasterData.conn.prepareStatement("select * from RWS_QUALIFICATION_TBL order by qual_code");
			empMasterData.rs = empMasterData.pstmt.executeQuery();
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setQualCode(empMasterData.rs.getString(1));
				empMaster.setQualName(empMasterData.rs.getString(2));
				quals.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println("The error in getQuals in EmpMaterData " + e);
		} finally {
			empMasterData.closeAll();
		}
		return quals;
	}

	public static int removeQual(String qualCode, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rcount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.pstmt = empMasterData.conn.prepareStatement("delete  from RWS_QUALIFICATION_TBL where qual_code=?");
			empMasterData.pstmt.setString(1, qualCode);
			rcount = empMasterData.pstmt.executeUpdate();
		} catch (Exception e) {
			Debug.println("The error in removeQual in EmpMasterData " + e);
		} finally {
			empMasterData.closeAll();
		}
		return rcount;
	}

	public static int updateQual(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int ans = 0;

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.pstmt = empMasterData.conn.prepareStatement("update  RWS_QUALIFICATION_TBL set qual_name=?  where qual_code=?");
			empMasterData.pstmt.setString(1, empMaster.getQualName().toUpperCase());
			empMasterData.pstmt.setString(2, empMaster.getQualCode());
			ans = empMasterData.pstmt.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			Debug.println("The error in updateQual " + sqle);
		} catch (Exception e) {
			Debug.println("The error in updateQual in EmpMasterdata " + e);
		} finally {
			empMasterData.closeAll();
		}
		return ans;
	}

	public static String getQualCode(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		String qcode = null;

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.pstmt = empMasterData.conn.prepareStatement("SELECT MAX(to_number(QUAL_CODE))+1 FROM RWS_QUALIFICATION_TBL");
			empMasterData.rs = empMasterData.pstmt.executeQuery();
			empMasterData.rs.next();
			qcode = empMasterData.rs.getString(1);
			if (qcode == null) {
				qcode = "1";
			}
		} catch (Exception e) {
			Debug.println("The error in getQualCode in EmpMasterData " + e);
		} finally {
			empMasterData.closeAll();
		}
		return qcode;
	}

	public static int[] insertEmp(EmpMaster empMaster, DataSource dataSource, HttpSession session) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster1 = new EmpMaster();
		int rowCount[] = null;
		String desgcode = null;
		boolean inserted = false;
		String var1 = null;
		ResultSet rs1 = null;
		session.removeAttribute("var1");
		try {
			
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt1 = empMasterData.conn.createStatement();
		
			// empMaster1=EmpMasterData.getEmp(empMaster.getEmpcode(),dataSource);
			String qry = "select * from rws_employee_tbl e,rws_employee_spouse_tbl s where e.employee_code=s.employee_code(+) and  e.employee_code='"
					+ empMaster.getEmpcode() + "' ";
			rs1 = empMasterData.stmt1.executeQuery(qry);
			if (rs1.next()) {			
				var1 = "Employee_code already Exists";			
				session.setAttribute("var1", var1);				
			} else {
			
				String query = "insert into rws_employee_tbl(EMPLOYEE_CODE,EMPLOYEE_SURNAME,EMPLOYEE_NAME,SEX,FATHER_NAME,DATE_OF_BIRTH,RELG_CODE,CASTE_CODE,NATIVE_DISTRICT,NATIVE_MANDAL,"
						+ "NATIVE_REV_DIVISION,QUAL_CODE,PH,DIST_CLASS_IV,DIST_CLASS_V,DIST_CLASS_VI,DIST_CLASS_VII,DIST_CLASS_VIII,DIST_CLASS_IX,DIST_CLASS_X,LOCAL_DIST_AS_PER_SCH,"
						+ "LOCAL_ZONE,NOOF_YEARS_STUDIED_IN_DIST,NOOF_YEARS_STUDIED_IN_ZONE,PRIVATE_PASSED_DIST,PRIVATE_PASSED_ZONE,TEMP_PERMNENT,DESIGNATION_CODE,APPOINT_CATEGORY,"
						+ "APPOINTMENT_DATE,DATE_OF_JOINING,MOAP_CODE,ZONE_CODE,RECRUIT_LOCAL_NONLOCAL,APCATEG_CODE,DATE_OF_COMMENCE_PROBATION,DATE_OF_REGULARISATION,CURRENT_POST_HELD_FROM,"
						+ "PROMOTION_DT_PRESENT_DESG,ACCTEST_PASSED,ACCTEST_PASS_DATE,ADD_QUAL_1,ADD_QUAL_2,PRESENT_DESIG,WORK_SPECIALIZATION,OTHER_DETAILS,OFFICE_CODE,SECTION,DEPT_OPTED,"
						+ "SECTOR,DEPUTATION,DEPUTATION_FROM,SENIORITY,DISCIPLINE_CASE,DISCIPLINE_TYPE,PAN_NO,APGLI_NO,GPF_NO,PRESENT_PAY_SCALE,INCREMENT_DATE,UPDATE_DATE,"
						+ "DEPUTATION_DEPT,DATE_OF_LEAVE,LEAVE_SUSPENDED)values('" + empMaster.getEmpcode() + "','"
						+ empMaster.getSurname().toUpperCase() + "','" + empMaster.getEmpname().toUpperCase() + "','"
						+ empMaster.getGender() + "','" + empMaster.getRelation() + "',TO_DATE('" + empMaster.getDob()
						+ "','dd/mm/yyyy')," + "'" + empMaster.getReligion() + "','" + empMaster.getSocial() + "','"
						+ empMaster.getNdist() + "','" + format(empMaster.getNmand()) + "','" + empMaster.getNrevenue()
						+ "','" + format(empMaster.getQual()) + "','" + format(empMaster.getHandicap()) + "','"
						+ empMaster.getDiststudied4() + "','" + empMaster.getDiststudied5() + "','"
						+ empMaster.getDiststudied6() + "','" + empMaster.getDiststudied7() + "','"
						+ empMaster.getDiststudied8() + "','" + empMaster.getDiststudied9() + "','"
						+ empMaster.getDiststudied10() + "','" + empMaster.getLocaldist() + "','"
						+ empMaster.getLocalzone() + "','" + empMaster.getNoofyrs() + "','" + empMaster.getNoofyrs1()
						+ "','" + empMaster.getPvtdist() + "','" + empMaster.getPvtzone() + "','" + empMaster.getDesig()
						+ "','" + empMaster.getDesgnCode() + "','" + empMaster.getApptcategory() + "',TO_DATE('"
						+ empMaster.getAppointdate() + "','dd/mm/yyyy'),TO_DATE('" + empMaster.getDoj()
						+ "','dd/mm/yyyy'),'" + empMaster.getMoap() + "','" + empMaster.getZone() + "','"
						+ empMaster.getNarecruit() + "','" + empMaster.getApcatog() + "',TO_DATE('"
						+ empMaster.getDcommprob() + "','dd/mm/yyyy'),TO_DATE('" + empMaster.getDdeclprob()
						+ "','dd/mm/yyyy'),TO_DATE('" + empMaster.getCurrentpostdate() + "','dd/mm/yyyy'),TO_DATE('"
						+ empMaster.getPromotedate() + "','dd/mm/yyyy'),'" + empMaster.getTestpassed() + "',TO_DATE('"
						+ empMaster.getDacctest() + "','dd/mm/yyyy'),'" + empMaster.getAddqual1() + "','"
						+ empMaster.getAddqual2() + "','" + empMaster.getPresentdesig() + "','"
						+ empMaster.getWorkSpecial() + "','" + empMaster.getOtherDet() + "','" + empMaster.getRoc()
						+ "','" + empMaster.getSection() + "','" + format(empMaster.getDept()) + "','"
						+ empMaster.getHoc() + "','" + format(empMaster.getDeputation()) + "',TO_DATE('"
						+ empMaster.getDeputationDate() + "','dd/mm/yyyy'),'" + empMaster.getSeniority() + "','"
						+ format(empMaster.getDisciplinecase()) + "','" + empMaster.getDisciplinetype() + "','"
						+ empMaster.getPanno() + "','" + empMaster.getApgli() + "','" + empMaster.getGpfno() + "','"
						+ empMaster.getPayscale() + "',TO_DATE('" + empMaster.getIncrementdate()
						+ "','dd/mm/yyyy'),TO_DATE('" + empMaster.getUpdatedate() + "','dd/mm/yyyy'),'"
						+ empMaster.getDepudept() + "',TO_DATE('" + empMaster.getLeavedate() + "','dd/mm/yyyy'),'"
						+ format(empMaster.getLeavesuspend()) + "')";

				
				
				empMasterData.stmt.addBatch(query);
			

				query = "insert into rws_employee_spouse_tbl(EMPLOYEE_CODE,SPOUSE_EMPLOYED,SPOUSE_CENTRE_STATE,"
						+ "SPOUSE_DISTRICT_WORK,SPOUSE_REV_DIV_WORK,SPOUSE_REV_MANDAL_WORK)values('"
						+ empMaster.getEmpcode() + "','" + format(empMaster.getSpouseemployd()) + "','"
						+ format(empMaster.getSpouseworking()) + "','" + empMaster.getSpouseworkdist() + "','"
						+ empMaster.getSpouseworkdiv() + "','" + empMaster.getSpouseworkmand() + "')";

				empMasterData.stmt.addBatch(query);
				

				rowCount = empMasterData.stmt.executeBatch();
			

				for (int j = 0; j < rowCount.length; j++) {
					// Debug.println("j value"+rowCount[j]);
					if (rowCount[j] == 0)
						inserted = false;
				}
				Debug.println("4");
				if (inserted) {
					var1 = "Record Inserted Successfully";
					empMasterData.conn.commit();
				} else {
					var1 = "Record Not Inserted";
				}
				empMasterData.conn.setAutoCommit(true);
			}

		} catch (Exception e) {
			for (int j = 0; j < rowCount.length; j++) {
				// Debug.println("j value"+rowCount[j]);
				if (rowCount[j] == 0)
					inserted = false;
			}
			Debug.println("error in Insert " + e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;

	}

	public static EmpForm getEmpEdit(String empcode, HttpSession session) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpForm form = new EmpForm();
		try {
			
			RwsOffices rwsOffices = new RwsOffices();
			empMasterData.conn = RwsOffices.getConn();			
			String query = "select * from rws_employee_tbl e,rws_employee_spouse_tbl s where e.employee_code=s.employee_code(+) and e.employee_code=? ";			
			empMasterData.pstmt = empMasterData.conn.prepareStatement(query);
			empMasterData.pstmt.setString(1, empcode);
			empMasterData.rs = empMasterData.pstmt.executeQuery();
			
			while (empMasterData.rs.next()) {
		
				form = new EmpForm();
				form.setEmpcode(empMasterData.rs.getString("EMPLOYEE_CODE"));
				form.setSurname(empMasterData.rs.getString("EMPLOYEE_SURNAME"));
				form.setEmpname(empMasterData.rs.getString("EMPLOYEE_NAME"));
				form.setGender(empMasterData.rs.getString("SEX"));
				if (empMasterData.rs.getString("FATHER_NAME") != null) {
					form.setRelation(empMasterData.rs.getString("FATHER_NAME"));
				}
				if (empMasterData.rs.getString("RELG_CODE") != null) {
					form.setReligion(empMasterData.rs.getString("RELG_CODE"));
				}				
				form.setSocial(empMasterData.rs.getString("CASTE_CODE"));
				ArrayList districts = rwsOffices.getDistricts();
				session.setAttribute("districts", districts);

				if (empMasterData.rs.getString("NATIVE_DISTRICT") != null) {
					form.setNdist(empMasterData.rs.getString("NATIVE_DISTRICT"));
				}
				// Debug.println("sdsadsadsdasdsa.ssss:"+empMasterData.rs.getString("NATIVE_MANDAL"));

				if (empMasterData.rs.getString("NATIVE_MANDAL") != null) {
					form.setNmand(empMasterData.rs.getString("NATIVE_MANDAL"));
				}

			
				form.setNrevenue(empMasterData.rs.getString("NATIVE_REV_DIVISION"));
			
				form.setQual(empMasterData.rs.getString("QUAL_CODE"));
				
				form.setSpouseemployd(empMasterData.rs.getString("SPOUSE_EMPLOYED"));
			
				form.setSpouseworkdist(empMasterData.rs.getString("SPOUSE_DISTRICT_WORK"));
				form.setSpouseworkdiv(empMasterData.rs.getString("SPOUSE_REV_DIV_WORK"));
				form.setSpouseworkmand(empMasterData.rs.getString("SPOUSE_REV_MANDAL_WORK"));
			
				form.setDiststudied4(empMasterData.rs.getString("DIST_CLASS_IV"));
				form.setDiststudied5(empMasterData.rs.getString("DIST_CLASS_V"));
				form.setDiststudied6(empMasterData.rs.getString("DIST_CLASS_VI"));
				form.setDiststudied7(empMasterData.rs.getString("DIST_CLASS_VII"));
				form.setDiststudied8(empMasterData.rs.getString("DIST_CLASS_VIII"));
				form.setDiststudied9(empMasterData.rs.getString("DIST_CLASS_IX"));
				form.setDiststudied10(empMasterData.rs.getString("DIST_CLASS_X"));
				form.setLocaldist(empMasterData.rs.getString("LOCAL_DIST_AS_PER_SCH"));
				form.setLocalzone(empMasterData.rs.getString("LOCAL_ZONE"));
				form.setNoofyrs(empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_DIST"));
				form.setNoofyrs1(empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_ZONE"));
				form.setPvtdist(empMasterData.rs.getString("PRIVATE_PASSED_DIST"));
				form.setPvtzone(empMasterData.rs.getString("PRIVATE_PASSED_ZONE"));
				form.setAddqual1(empMasterData.rs.getString("ADD_QUAL_1"));
				form.setAddqual2(empMasterData.rs.getString("ADD_QUAL_2"));

				ArrayList circles = rwsOffices.getCircles();
				session.setAttribute("circles", circles);
				form.setCircleOfficeCode(empMasterData.rs.getString(4).substring(1, 3));
				ArrayList divisions = rwsOffices
						.getDivisions1(empMasterData.rs.getString("office_code").substring(1, 3));
				session.setAttribute("divisions", divisions);
				form.setDivisionOfficeCode(empMasterData.rs.getString("office_code").substring(3, 4));
				// Debug.println("office code:"+empMasterData.rs.getString("office_code"));
				ArrayList subdivisions = rwsOffices.getSubDivisions1(
						empMasterData.rs.getString("office_code").substring(1, 3),
						empMasterData.rs.getString("office_code").substring(3, 4));
				session.setAttribute("subdivisions", subdivisions);
				form.setSubdivisionOfficeCode(empMasterData.rs.getString("office_code").substring(4, 6));

				form.setHoc(empMasterData.rs.getString("SECTOR"));
				// Debug.println("11111111.4");

				if (empMasterData.rs.getDate("DATE_OF_BIRTH") != null) {
					form.setDob(df.format(empMasterData.rs.getDate("DATE_OF_BIRTH")));
				}
				if (empMasterData.rs.getDate("APPOINTMENT_DATE") != null) {
					form.setAppointdate(df.format(empMasterData.rs.getDate("APPOINTMENT_DATE")));
				}
				if (empMasterData.rs.getDate("DATE_OF_JOINING") != null) {
					form.setDoj(df.format(empMasterData.rs.getDate("DATE_OF_JOINING")));
				}
				
				if (empMasterData.rs.getString("WORK_SPECIALIZATION") != null) {
					form.setWorkSpecial(empMasterData.rs.getString("WORK_SPECIALIZATION"));
				}
			

				if (empMasterData.rs.getString("RECRUIT_LOCAL_NONLOCAL") != null) {
					form.setNarecruit(empMasterData.rs.getString("RECRUIT_LOCAL_NONLOCAL"));
				}
				if (empMasterData.rs.getString("TEMP_PERMNENT") != null
						&& !empMasterData.rs.getString("TEMP_PERMNENT").equals(""))
					form.setDesig(empMasterData.rs.getString("TEMP_PERMNENT"));
				else
					form.setDesig("P");
				try {
					ArrayList desgns = EmpMasterData.getDesgns();
					session.setAttribute("desgns", desgns);
					form.setDesgnCode(empMasterData.rs.getString("DESIGNATION_CODE"));
				} catch (Exception e) {
					// Debug.println("exception in desg code"+e);
				}				
				if (empMasterData.rs.getString("MOAP_CODE") != null) {
					form.setMoap(empMasterData.rs.getString("MOAP_CODE"));
				}
				if (empMasterData.rs.getString("APCATEG_CODE") != null) {
					form.setApcatog(empMasterData.rs.getString("APCATEG_CODE"));
				}				
				if (empMasterData.rs.getString("ZONE_CODE") != null) {
					form.setZone(empMasterData.rs.getString("ZONE_CODE"));
				}			
				try {
					if (empMasterData.rs.getString("PAN_NO") != null) {
						form.setPanno(empMasterData.rs.getString("PAN_NO"));
					}
					if (empMasterData.rs.getString("APGLI_NO") != null) {
						form.setApgli(empMasterData.rs.getString("APGLI_NO"));
					}
					if (empMasterData.rs.getString("GPF_NO") != null) {
						form.setGpfno(empMasterData.rs.getString("GPF_NO"));
					}
					if (empMasterData.rs.getString("PRESENT_STATION_MANDAL") != null) {
						form.setPresentation(empMasterData.rs.getString("PRESENT_STATION_MANDAL"));
					}
					if (empMasterData.rs.getString("OTHER_DETAILS") != null) {
						form.setOtherDet(empMasterData.rs.getString("OTHER_DETAILS"));
					}
				} catch (Exception e) {
					// Debug.println("sdgfsdgfh:"+e);
				}
			

				if (empMasterData.rs.getString("DEPT_OPTED") != null) {
					form.setDept(empMasterData.rs.getString("DEPT_OPTED"));
				}
			
				try {
					if (empMasterData.rs.getString("PH") != null) {
						form.setHandicap(empMasterData.rs.getString("PH"));
					}
				} catch (Exception e) {
					// Debug.println("in exception ph"+e);
				}
				if (empMasterData.rs.getString("SECTION") != null) {
					form.setSection(empMasterData.rs.getString("SECTION"));
				}
				// Debug.println("sfddddddd");
				if (empMasterData.rs.getString("APPOINT_CATEGORY") != null) {
					form.setApptcategory(empMasterData.rs.getString("APPOINT_CATEGORY"));
				}
				if (empMasterData.rs.getDate("DATE_OF_COMMENCE_PROBATION") != null)
					form.setDcommprob(df.format(empMasterData.rs.getDate("DATE_OF_COMMENCE_PROBATION")));
				if (empMasterData.rs.getDate("DATE_OF_REGULARISATION") != null)
					form.setDdeclprob(df.format(empMasterData.rs.getDate("DATE_OF_REGULARISATION")));
				if (empMasterData.rs.getDate("CURRENT_POST_HELD_FROM") != null)
					form.setCurrentpostdate(df.format(empMasterData.rs.getDate("CURRENT_POST_HELD_FROM")));
				if (empMasterData.rs.getString("PROMOTION_DT_PRESENT_DESG") != null)
					form.setPromotedate(df.format(empMasterData.rs.getDate("PROMOTION_DT_PRESENT_DESG")));
			
				form.setTestpassed(empMasterData.rs.getString("ACCTEST_PASSED"));
			
				form.setPresentdesig(empMasterData.rs.getString("PRESENT_DESIG"));
			
				form.setSection(empMasterData.rs.getString("SECTION"));
				
				form.setDept(empMasterData.rs.getString("DEPT_OPTED"));
			
				form.setDeputation(empMasterData.rs.getString("DEPUTATION"));
			
				if (empMasterData.rs.getDate("DEPUTATION_FROM") != null)
					form.setDeputationDate(df.format(empMasterData.rs.getDate("DEPUTATION_FROM")));
			
				form.setSeniority(empMasterData.rs.getString("SENIORITY"));
			
				form.setDisciplinecase(empMasterData.rs.getString("DISCIPLINE_CASE"));
				
				form.setDisciplinetype(empMasterData.rs.getString("DISCIPLINE_TYPE"));
				
				form.setPayscale(empMasterData.rs.getString("PRESENT_PAY_SCALE"));
			
				if (empMasterData.rs.getDate("INCREMENT_DATE") != null)
					form.setIncrementdate(df.format(empMasterData.rs.getDate("INCREMENT_DATE")));
				if (empMasterData.rs.getDate("UPDATE_DATE") != null)
					form.setUpdatedate(df.format(empMasterData.rs.getDate("UPDATE_DATE")));
				form.setDepudept(empMasterData.rs.getString("DEPUTATION_DEPT"));
			
				if (empMasterData.rs.getDate("DATE_OF_LEAVE") != null)
					form.setLeavedate(df.format(empMasterData.rs.getDate("DATE_OF_LEAVE")));
			
				form.setLeavesuspend(empMasterData.rs.getString("LEAVE_SUSPENDED"));
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			empMasterData.closeAll();
		}
		return form;
	}

	// code added by sridhar for view of emp search

	public static ArrayList getEmpsSearch(String hoc, String coc, String zcode, String des, String descode,
			String empcode) throws Exception {
		String str;
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;// Form bean
		ArrayList emps = new ArrayList();

		try {
			empMasterData.conn = RwsOffices.getConn();
			//Debug.println("connection established");
			empMasterData.stmt = empMasterData.conn.createStatement();
	//		Debug.println("create statement executed");
			String query = "";
			if (empcode != null && !empcode.equals("")) {
				query = " select e.employee_code,e.EMPLOYEE_SURNAME,e.office_code,e.employee_name,c.circle_office_name,d.division_office_name, sub.subdivision_office_name, e.QUAL_CODE,e.ADD_QUAL_1,e.ADD_QUAL_2,DATE_OF_BIRTH,APPOINTMENT_DATE, DATE_OF_JOINING,SKILL_DESCRIPTION,MNAME,FATHER_NAME, RECRUIT_LOCAL_NONLOCAL,e.TEMP_PERMNENT,DESIGNATION_NAME, MOAP_NAME,APCATEG_NAME,SEX,ZONE_NAME,PAN_NO, APGLI_NO,GPF_NO,PRESENT_STATION_MANDAL,OTHER_DETAILS, RELG_NAME,DEPT_OPTED,PH,SECTION,APPOINT_CATEGORY,e.NATIVE_DISTRICT,sector from rws_employee_tbl e,rws_employee_spouse_tbl s,rws_circle_office_tbl c ,rws_division_office_tbl d, rws_subdivision_office_tbl sub,RWS_SPEC_SKILL_TBL k, RWS_MODEOFAPP_MST_TBL m,RWS_ZONE_MST_TBL z, RWS_RELEGION_MST_TBL r,rws_mandal_tbl mn,RWS_APP_CATEGORY_MST_TBL cat,RWS_DESIGNATION_TBL des where e.employee_code=s.employee_code(+) and substr(e.office_code,2,2) =c.circle_office_code and c.circle_office_code=d.circle_office_code and c.circle_office_code=sub. circle_office_code and d.division_office_code=sub.division_office_code and substr(e.office_code,4,1)=d.division_office_code and substr (e.office_code,5,2)=sub.subdivision_office_code and e.WORK_SPECIALIZATION=k.skill_code(+)and e.MOAP_CODE=m.MOAP_CODE (+) and e.zone_code=z.zone_code(+) and e.relg_code=r.relg_code(+) and e.NATIVE_DISTRICT =mn.dcode(+) and e.NATIVE_MANDAL=mn.mcode(+) and e.APCATEG_CODE=cat.APCATEG_CODE(+) and e.DESIGNATION_CODE=des.DESIGNATION_CODE(+) and e.EMPLOYEE_CODE='"
						+ empcode
						+ "' UNION select e.employee_code,e.EMPLOYEE_SURNAME,e.office_code,e.employee_name,c.circle_office_name, '-' as division_office_name,'-' as subdivision_office_name,e.QUAL_CODE,e.ADD_QUAL_1,e.ADD_QUAL_2,DATE_OF_BIRTH,APPOINTMENT_DATE,DATE_OF_JOINING, SKILL_DESCRIPTION,MNAME,FATHER_NAME, RECRUIT_LOCAL_NONLOCAL,e.TEMP_PERMNENT,DESIGNATION_NAME,MOAP_NAME, APCATEG_NAME,SEX,ZONE_NAME,PAN_NO, APGLI_NO,GPF_NO,PRESENT_STATION_MANDAL,OTHER_DETAILS, RELG_NAME,DEPT_OPTED,PH,SECTION,APPOINT_CATEGORY,e.NATIVE_DISTRICT,sector from rws_employee_tbl e,rws_employee_spouse_tbl s,rws_circle_office_tbl c,RWS_SPEC_SKILL_TBL k, RWS_MODEOFAPP_MST_TBL m,RWS_ZONE_MST_TBL z, RWS_RELEGION_MST_TBL r,rws_mandal_tbl mn,RWS_APP_CATEGORY_MST_TBL cat,RWS_DESIGNATION_TBL des where e.employee_code=s.employee_code(+) and substr(e.office_code,2,2)=c.circle_office_code and e.WORK_SPECIALIZATION=k.skill_code(+) and e.MOAP_CODE=m.MOAP_CODE (+) and e.zone_code=z.zone_code(+) and e.relg_code=r.relg_code(+) and e.NATIVE_DISTRICT =mn.dcode(+) and e.NATIVE_MANDAL=mn.mcode(+) and e.APCATEG_CODE=cat.APCATEG_CODE(+) and e.DESIGNATION_CODE=des.DESIGNATION_CODE(+)  and e.EMPLOYEE_CODE='"
						+ empcode + "' and (substr(office_code,4,1)='0' or substr(office_code,5,2)='00')";
			} else {
				query = "select e.employee_code,e.EMPLOYEE_SURNAME,e.office_code,e.employee_name,c.circle_office_name,d.division_office_name, sub.subdivision_office_name, e.QUAL_CODE,e.ADD_QUAL_1,e.ADD_QUAL_2,DATE_OF_BIRTH,APPOINTMENT_DATE, DATE_OF_JOINING,SKILL_DESCRIPTION,MNAME,FATHER_NAME, RECRUIT_LOCAL_NONLOCAL,e.TEMP_PERMNENT,DESIGNATION_NAME, MOAP_NAME,APCATEG_NAME,SEX,ZONE_NAME,PAN_NO, APGLI_NO,GPF_NO,PRESENT_STATION_MANDAL,OTHER_DETAILS, RELG_NAME,DEPT_OPTED,PH,SECTION,APPOINT_CATEGORY,e.NATIVE_DISTRICT,sector from rws_employee_tbl e,rws_employee_spouse_tbl s,rws_circle_office_tbl c ,rws_division_office_tbl d, rws_subdivision_office_tbl sub,RWS_SPEC_SKILL_TBL k, RWS_MODEOFAPP_MST_TBL m,RWS_ZONE_MST_TBL z, RWS_RELEGION_MST_TBL r,rws_mandal_tbl mn,RWS_APP_CATEGORY_MST_TBL cat,RWS_DESIGNATION_TBL des where e.employee_code=s.employee_code(+) and substr(e.office_code,2,2) =c.circle_office_code and c.circle_office_code=d.circle_office_code and c.circle_office_code=sub. circle_office_code and d.division_office_code=sub.division_office_code and substr(e.office_code,4,1)=d.division_office_code and substr (e.office_code,5,2)=sub.subdivision_office_code and e.WORK_SPECIALIZATION=k.skill_code(+)and e.MOAP_CODE=m.MOAP_CODE (+) and e.zone_code=z.zone_code(+) and e.relg_code=r.relg_code(+) and e.NATIVE_DISTRICT =mn.dcode(+) and e.NATIVE_MANDAL=mn.mcode(+) and e.APCATEG_CODE=cat.APCATEG_CODE(+) and e.DESIGNATION_CODE=des.DESIGNATION_CODE(+)";

				if (hoc != null && !hoc.equals("") && !hoc.equals("0")) {
					query += " and substr(e.office_code,1,1)='" + hoc + "' ";
				}
				if (coc != null && !coc.equals("") && !coc.equals("00")) {
					query += " and substr(e.office_code,2,2)='" + coc + "' ";
				}
				if (zcode != null && !zcode.equals("")) {
					query += " and e.zone_code='" + zcode + "' ";
				}
				if (des != null && !des.equals("")) {
					query += " and e.TEMP_PERMNENT='" + des + "' ";
				}
				if (descode != null && !descode.equals("")) {
					query += " and e.DESIGNATION_CODE='" + descode + "'  ";
				}

				query += " union select e.employee_code,e.EMPLOYEE_SURNAME,e.office_code,e.employee_name,c.circle_office_name, '-' as division_office_name,'-' as subdivision_office_name,e.QUAL_CODE,e.ADD_QUAL_1,e.ADD_QUAL_2,DATE_OF_BIRTH,APPOINTMENT_DATE,DATE_OF_JOINING, SKILL_DESCRIPTION,MNAME,FATHER_NAME, RECRUIT_LOCAL_NONLOCAL,e.TEMP_PERMNENT,DESIGNATION_NAME,MOAP_NAME, APCATEG_NAME,SEX,ZONE_NAME,PAN_NO, APGLI_NO,GPF_NO,PRESENT_STATION_MANDAL,OTHER_DETAILS, RELG_NAME,DEPT_OPTED,PH,SECTION,APPOINT_CATEGORY,e.NATIVE_DISTRICT,sector from rws_employee_tbl e,rws_employee_spouse_tbl s,rws_circle_office_tbl c,RWS_SPEC_SKILL_TBL k, RWS_MODEOFAPP_MST_TBL m,RWS_ZONE_MST_TBL z, RWS_RELEGION_MST_TBL r,rws_mandal_tbl mn,RWS_APP_CATEGORY_MST_TBL cat,RWS_DESIGNATION_TBL des where e.employee_code=s.employee_code(+) and substr(e.office_code,2,2)=c.circle_office_code and e.WORK_SPECIALIZATION=k.skill_code(+) and e.MOAP_CODE=m.MOAP_CODE (+) and e.zone_code=z.zone_code(+) and e.relg_code=r.relg_code(+) and e.NATIVE_DISTRICT =mn.dcode(+) and e.NATIVE_MANDAL=mn.mcode(+) and e.APCATEG_CODE=cat.APCATEG_CODE(+) and e.DESIGNATION_CODE=des.DESIGNATION_CODE(+)";
				if (hoc != null && !hoc.equals("") && !hoc.equals("0")) {
					query += " and substr(e.office_code,1,1)='" + hoc + "' ";
				}
				if (coc != null && !coc.equals("") && !coc.equals("00")) {
					query += " and substr(e.office_code,2,2)='" + coc + "' ";
				}
				if (zcode != null && !zcode.equals("")) {
					query += " and e.zone_code='" + zcode + "' ";
				}
				if (des != null && !des.equals("")) {
					query += " and e.TEMP_PERMNENT='" + des + "' ";
				}
				if (descode != null && !descode.equals("")) {
					query += " and e.DESIGNATION_CODE='" + descode + "'  ";
				}

				query += " and (substr(office_code,4,1)='0' or substr(office_code,5,2)='00')";
				query += " order by 1 ";
			}
		//	Debug.println("query in getEmps  " + query);
			empMasterData.rs = empMasterData.stmt.executeQuery(query);

			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				// Debug.println("empcode:"+empMasterData.rs.getString("EMPLOYEE_CODE"));
				empMaster.setEmpcode(empMasterData.rs.getString("EMPLOYEE_CODE"));
				empMaster.setSurname(empMasterData.rs.getString("EMPLOYEE_SURNAME"));
				empMaster.setEmpname(empMasterData.rs.getString("EMPLOYEE_NAME"));
				if (empMasterData.rs.getString("sector").equals("1"))
					empMaster.setRoc("CE RWS");
				else if (empMasterData.rs.getString("sector").equals("2"))
					empMaster.setRoc("PR");
				else if (empMasterData.rs.getString("sector").equals("3"))
					empMaster.setRoc("VIGLANCE");
				empMaster.setHoc(empMasterData.rs.getString("OFFICE_CODE"));
				empMaster.setCoc(empMasterData.rs.getString("circle_office_name"));
				empMaster.setDoc(empMasterData.rs.getString("division_office_name"));
				empMaster.setSdoc(empMasterData.rs.getString("subdivision_office_name"));				
				if (empMasterData.rs.getDate("DATE_OF_BIRTH") != null) {
					empMaster.setDob(df.format(empMasterData.rs.getDate("DATE_OF_BIRTH")));
				}
				if (empMasterData.rs.getDate("APPOINTMENT_DATE") != null) {
					empMaster.setAppointdate(df.format(empMasterData.rs.getDate("APPOINTMENT_DATE")));
				}
				if (empMasterData.rs.getDate("DATE_OF_JOINING") != null) {
					empMaster.setDoj(df.format(empMasterData.rs.getDate("DATE_OF_JOINING")));
				}
				if (empMasterData.rs.getString("QUAL_CODE") == null && empMasterData.rs.getString("ADD_QUAL_1") == null
						&& empMasterData.rs.getString("ADD_QUAL_2") == null) {
					empMaster.setQualName("-");
					empMaster.setAddqual1("-");
					empMaster.setAddqual2("-");
				} else {
					String[] values = getQualNames(empMasterData.rs.getString("QUAL_CODE"),
							empMasterData.rs.getString("ADD_QUAL_1"), empMasterData.rs.getString("ADD_QUAL_2"));
					empMaster.setQualName(values[0]);
					empMaster.setAddqual1(values[1]);
					empMaster.setAddqual2(values[2]);
				}
				if (empMasterData.rs.getString("SKILL_DESCRIPTION") != null) {
					empMaster.setWorkSpecial(empMasterData.rs.getString("SKILL_DESCRIPTION"));
				}				
				if (empMasterData.rs.getString("FATHER_NAME") != null) {
					empMaster.setRelation(empMasterData.rs.getString("FATHER_NAME"));
				}
				if (empMasterData.rs.getString("NATIVE_DISTRICT") != null) {
					empMaster.setNdist(empMasterData.rs.getString("circle_office_name"));
				}			
				try {
					empMaster.setNmand(empMasterData.rs.getString("MNAME"));
				} catch (Exception e) {
				}
				if (empMasterData.rs.getString("RECRUIT_LOCAL_NONLOCAL") != null) {
					empMaster.setNarecruit(getRecName(empMasterData.rs.getString("RECRUIT_LOCAL_NONLOCAL")));
				}
				if (empMasterData.rs.getString("TEMP_PERMNENT") != null) {
					empMaster.setDesig(getTempPer(empMasterData.rs.getString("TEMP_PERMNENT")));
				}
				try {
					empMaster.setDesgnName(empMasterData.rs.getString("DESIGNATION_NAME"));
				} catch (Exception e) {
				}				
				if (empMasterData.rs.getString("MOAP_NAME") != null) {
					empMaster.setMoap(empMasterData.rs.getString("MOAP_NAME"));
				}
				if (empMasterData.rs.getString("APCATEG_NAME") != null) {
					empMaster.setApcatog(empMasterData.rs.getString("APCATEG_NAME"));
				}			
				if (empMasterData.rs.getString("ZONE_NAME") != null) {
					empMaster.setZone(empMasterData.rs.getString("ZONE_NAME"));
				}
				if (empMasterData.rs.getString("SEX") != null) {
					empMaster.setGender(getGenderName(empMasterData.rs.getString("SEX")));
				}			
				try {
					if (empMasterData.rs.getString("PAN_NO") != null) {
						empMaster.setPanno(empMasterData.rs.getString("PAN_NO"));
					}
					if (empMasterData.rs.getString("APGLI_NO") != null) {
						empMaster.setApgli(empMasterData.rs.getString("APGLI_NO"));
					}
					if (empMasterData.rs.getString("GPF_NO") != null) {
						empMaster.setGpfno(empMasterData.rs.getString("GPF_NO"));
					}
					if (empMasterData.rs.getString("PRESENT_STATION_MANDAL") != null) {
						empMaster.setPresentation(empMasterData.rs.getString("PRESENT_STATION_MANDAL"));
					}
					if (empMasterData.rs.getString("OTHER_DETAILS") != null) {
						empMaster.setOtherDet(empMasterData.rs.getString("OTHER_DETAILS"));
					}
				} catch (Exception e) {
				}			
				if (empMasterData.rs.getString("RELG_NAME") != null) {
					empMaster.setReligion(empMasterData.rs.getString("RELG_NAME"));
				}
				if (empMasterData.rs.getString("DEPT_OPTED") != null) {
					empMaster.setDept(empMasterData.rs.getString("DEPT_OPTED"));
				}			
				try {
					if (empMasterData.rs.getString("PH") != null) {
						empMaster.setHandicap(getYesNo(empMasterData.rs.getString("PH")));
					}
				} catch (Exception e) {
				}
				if (empMasterData.rs.getString("SECTION") != null) {
					empMaster.setSection(empMasterData.rs.getString("SECTION"));
				}
				if (empMasterData.rs.getString("APPOINT_CATEGORY") != null) {
					empMaster.setApptcategory(empMasterData.rs.getString("APPOINT_CATEGORY"));
				}
				emps.add(empMaster);
			}

		} catch (Exception e) {
			Debug.println("The error in getEmpsSearch in EmpMasterData " + e);
		} finally {
			empMasterData.closeAll();
		}
		return emps;
	}

	public static String getPayScales(String desgcode, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		String payscale = null;
		try {		
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.pstmt = empMasterData.conn.prepareStatement("select DISTINCT REVISED_PAY_SCALE  from RWS_PAY_SCALE_TBL P,RWS_DESIGNATION_TBL D WHERE P.DESIGNATION_CODE=D.DESIGNATION_CODE AND P.DESIGNATION_CODE=?");	
			empMasterData.pstmt .setString(1, desgcode);
			empMasterData.rs = empMasterData.pstmt.executeQuery();
			if (empMasterData.rs.next()) {
				if (empMasterData.rs.getString(1) != null) {
					payscale = empMasterData.rs.getString(1);				
				} else {
					payscale = "-";					
				}
			} else {
				payscale = "-";				
			}
		} catch (Exception e) {
			Debug.println("The error in getPayScales in EmpMasterData " + e);
		} finally {
			empMasterData.closeAll();
		}
		return payscale;
	}

	public static ArrayList getCircles(DataSource datasource) throws Exception {
		Connection conn = null;
		ArrayList circles = null;
		EmpForm circle = null;
		try {
			circles = new ArrayList();
			Debug.println("in getCircles ");
			String query = "select CIRCLE_OFFICE_CODE,CIRCLE_OFFICE_NAME  from RWS_CIRCLE_OFFICE_TBL order by CIRCLE_OFFICE_NAME";
			conn = RwsOffices.getConn();
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				circle = new EmpForm();
				circle.setCircleCode(rs.getString("CIRCLE_OFFICE_CODE") + "");
				Debug.println("circle code is" + rs.getString("CIRCLE_OFFICE_CODE"));
				circle.setCircleName(rs.getString("CIRCLE_OFFICE_NAME"));
				circles.add(circle);
			}

		} catch (Exception e) {
			Debug.println("Exception while geting circles" + e);
		} finally {
			conn.close();
		}
		return circles;
	}

	// ens of code

	public static ArrayList getCircleCodes(DataSource datasource) throws Exception {
		Connection conn = null;
		ArrayList circles = null;
		EmpForm circle = null;

		try {
			circles = new ArrayList();
			Debug.println("in getCircles ");
			String query = "select CIRCLE_OFFICE_CODE,CIRCLE_OFFICE_NAME  from RWS_CIRCLE_OFFICE_TBL order by CIRCLE_OFFICE_NAME";
			conn = RwsOffices.getConn();
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				circle = new EmpForm();
				circle.setCircleCode(rs.getString("CIRCLE_OFFICE_CODE") + "");
				Debug.println("circle code is" + rs.getString("CIRCLE_OFFICE_CODE"));
				circle.setCircleName(rs.getString("CIRCLE_OFFICE_NAME"));
				circles.add(circle);
			}

		} catch (Exception e) {
			Debug.println("Exception while geting circles" + e);
		} finally {
			conn.close();
		}
		return circles;
	}

	public static String getEmployee(String hoc, String coc, String doc, String sdoc, DataSource dataSource)
			throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.pstmt = empMasterData.conn.prepareStatement("select count(*) from  rws_employee_tbl where substr(OFFICE_CODE,1,1)=? and substr(OFFICE_CODE,2,2)=? and substr(OFFICE_CODE,4,1)=? and substr(OFFICE_CODE,5,2)=?");
			empMasterData.pstmt .setString(1, hoc);
			empMasterData.pstmt .setString(2, coc);
			empMasterData.pstmt .setString(3, doc);
			empMasterData.pstmt .setString(4, sdoc);
			empMasterData.rs = empMasterData.pstmt.executeQuery();
			if (empMasterData.rs.next()) {
				rowCount = empMasterData.rs.getInt(1);
			}
		} catch (Exception e) {
			Debug.println("error in getEmployee in EmpMasterData  " + e);
		} finally {
			empMasterData.closeAll();
		}
		if (rowCount >= 1)
			return "1";
		else
			return "0";
	}

	// code added
	public static ArrayList getEmps(String hoc, String coc, String doc, String sdoc, DataSource dataSource)
			throws Exception {
		String str;
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;// Form bean
		ArrayList emps = new ArrayList();

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			String query = "";
			// query="select * from rws_employee_tbl e,rws_employee_spouse_tbl s where
			// e.employee_code=s.employee_code(+) " ;
			query = "select e.employee_code,e.EMPLOYEE_SURNAME,e.office_code,e.employee_name,c.circle_office_name,d.division_office_name, sub.subdivision_office_name, e.QUAL_CODE,e.ADD_QUAL_1,e.ADD_QUAL_2,DATE_OF_BIRTH,APPOINTMENT_DATE, DATE_OF_JOINING,SKILL_DESCRIPTION,MNAME,FATHER_NAME, RECRUIT_LOCAL_NONLOCAL,e.TEMP_PERMNENT,DESIGNATION_NAME, MOAP_NAME,APCATEG_NAME,SEX,ZONE_NAME,PAN_NO, APGLI_NO,GPF_NO,PRESENT_STATION_MANDAL,OTHER_DETAILS, RELG_NAME,DEPT_OPTED,PH,SECTION,APPOINT_CATEGORY,e.NATIVE_DISTRICT,sector from rws_employee_tbl e,rws_employee_spouse_tbl s,rws_circle_office_tbl c ,rws_division_office_tbl d, rws_subdivision_office_tbl sub,RWS_SPEC_SKILL_TBL k, RWS_MODEOFAPP_MST_TBL m,RWS_ZONE_MST_TBL z, RWS_RELEGION_MST_TBL r,rws_mandal_tbl mn,RWS_APP_CATEGORY_MST_TBL cat,RWS_DESIGNATION_TBL des where e.employee_code=s.employee_code(+) and substr(e.office_code,2,2) =c.circle_office_code and c.circle_office_code=d.circle_office_code and c.circle_office_code=sub. circle_office_code and d.division_office_code=sub.division_office_code and substr(e.office_code,4,1)=d.division_office_code and substr (e.office_code,5,2)=sub.subdivision_office_code and e.WORK_SPECIALIZATION=k.skill_code(+)and e.MOAP_CODE=m.MOAP_CODE (+) and e.zone_code=z.zone_code(+) and e.relg_code=r.relg_code(+) and e.NATIVE_DISTRICT =mn.dcode(+) and e.NATIVE_MANDAL=mn.mcode(+) and e.APCATEG_CODE=cat.APCATEG_CODE(+) and e.DESIGNATION_CODE=des.DESIGNATION_CODE(+) and  substr(office_code,4,3)<>'000'";
			if (hoc != null && !hoc.equals("0")) {
				query += " and substr(office_code,1,1)='" + hoc + "' ";
			}
			if (coc != null && !coc.equals("00")) {
				query += " and substr(office_code,2,2)='" + coc + "'";
			}
			if (doc != null && !doc.equals("0")) {
				query += " and substr(office_code,4,1) ='" + doc + "'";
			}
			/*
			 * else { query += " and substr(office_code,4,1)='0'"; }
			 */
			if (sdoc != null && !sdoc.equals("00")) {
				query += " and substr(office_code,5,2)='" + sdoc + "' ";
			}
			/*
			 * else { query += " and substr(office_code,5,2)='00'"; }
			 */

			query += " union select e.employee_code,e.EMPLOYEE_SURNAME,e.office_code,e.employee_name,c.circle_office_name, '-' as division_office_name,'-' as subdivision_office_name,e.QUAL_CODE,e.ADD_QUAL_1,e.ADD_QUAL_2,DATE_OF_BIRTH,APPOINTMENT_DATE,DATE_OF_JOINING, SKILL_DESCRIPTION,MNAME,FATHER_NAME, RECRUIT_LOCAL_NONLOCAL,e.TEMP_PERMNENT,DESIGNATION_NAME,MOAP_NAME, APCATEG_NAME,SEX,ZONE_NAME,PAN_NO, APGLI_NO,GPF_NO,PRESENT_STATION_MANDAL,OTHER_DETAILS, RELG_NAME,DEPT_OPTED,PH,SECTION,APPOINT_CATEGORY,e.NATIVE_DISTRICT,sector from rws_employee_tbl e,rws_employee_spouse_tbl s,rws_circle_office_tbl c,RWS_SPEC_SKILL_TBL k, RWS_MODEOFAPP_MST_TBL m,RWS_ZONE_MST_TBL z, RWS_RELEGION_MST_TBL r,rws_mandal_tbl mn,RWS_APP_CATEGORY_MST_TBL cat,RWS_DESIGNATION_TBL des where e.employee_code=s.employee_code(+) and substr(e.office_code,2,2)=c.circle_office_code and e.WORK_SPECIALIZATION=k.skill_code(+) and e.MOAP_CODE=m.MOAP_CODE (+) and e.zone_code=z.zone_code(+) and e.relg_code=r.relg_code(+) and e.NATIVE_DISTRICT =mn.dcode(+) and e.NATIVE_MANDAL=mn.mcode(+) and e.APCATEG_CODE=cat.APCATEG_CODE(+) and e.DESIGNATION_CODE=des.DESIGNATION_CODE(+)";
			if (hoc != null && !hoc.equals("0")) {
				query += " and substr(office_code,1,1)='" + hoc + "' ";
			}
			if (coc != null && !coc.equals("00")) {
				query += " and substr(office_code,2,2)='" + coc + "'";
			}
			if (doc != null && !doc.equals("0")) {
				query += " and substr(office_code,4,1) ='" + doc + "'";
			}

			if (sdoc != null && !sdoc.equals("00")) {
				query += " and substr(office_code,5,2)='" + sdoc + "' ";
			}
			if ((doc != null && !doc.equals("0")) || (sdoc != null && !sdoc.equals("0"))) {
				query += " and (substr(office_code,4,1)='0' or substr(office_code,5,2)='00') ";
			}
			query += " order by 1 ";
		//	Debug.println("view qry:" + query);
			empMasterData.rs = empMasterData.stmt.executeQuery(query);

			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
			//	Debug.println("empcode:" + empMasterData.rs.getString("EMPLOYEE_CODE"));
				empMaster.setEmpcode(empMasterData.rs.getString("EMPLOYEE_CODE"));
				empMaster.setSurname(empMasterData.rs.getString("EMPLOYEE_SURNAME"));
				empMaster.setEmpname(empMasterData.rs.getString("EMPLOYEE_NAME"));
				if (empMasterData.rs.getString("sector").equals("1"))
					empMaster.setRoc("CE RWS");
				else if (empMasterData.rs.getString("sector").equals("2"))
					empMaster.setRoc("PR");
				else if (empMasterData.rs.getString("sector").equals("3"))
					empMaster.setRoc("VIGLANCE");
				// Debug.println("11111111.1");
				empMaster.setHoc(empMasterData.rs.getString("OFFICE_CODE"));
				// Debug.println("11111111.2");
				empMaster.setCoc(empMasterData.rs.getString("circle_office_name"));
				empMaster.setDoc(empMasterData.rs.getString("division_office_name"));
				empMaster.setSdoc(empMasterData.rs.getString("subdivision_office_name"));
				// Debug.println("11111111.3");
				// empMaster.setRoc("CERWS");
				// Debug.println("11111111.4");
				if (empMasterData.rs.getDate("DATE_OF_BIRTH") != null) {
					empMaster.setDob(df.format(empMasterData.rs.getDate("DATE_OF_BIRTH")));
				}
				if (empMasterData.rs.getDate("APPOINTMENT_DATE") != null) {
					empMaster.setAppointdate(df.format(empMasterData.rs.getDate("APPOINTMENT_DATE")));
				}
				if (empMasterData.rs.getDate("DATE_OF_JOINING") != null) {
					empMaster.setDoj(df.format(empMasterData.rs.getDate("DATE_OF_JOINING")));
				}

				if (empMasterData.rs.getString("QUAL_CODE") == null && empMasterData.rs.getString("ADD_QUAL_1") == null
						&& empMasterData.rs.getString("ADD_QUAL_2") == null) {
					empMaster.setQualName("-");
					empMaster.setAddqual1("-");
					empMaster.setAddqual2("-");
				} else {
				//	Debug.println("in else");
					String[] values = getQualNames(empMasterData.rs.getString("QUAL_CODE"),
							empMasterData.rs.getString("ADD_QUAL_1"), empMasterData.rs.getString("ADD_QUAL_2"));

					empMaster.setQualName(values[0]);
					empMaster.setAddqual1(values[1]);
					empMaster.setAddqual2(values[2]);
				}

				if (empMasterData.rs.getString("SKILL_DESCRIPTION") != null) {
					empMaster.setWorkSpecial(empMasterData.rs.getString("SKILL_DESCRIPTION"));
				}
				// Debug.println("11111111.6");
				if (empMasterData.rs.getString("FATHER_NAME") != null) {
					empMaster.setRelation(empMasterData.rs.getString("FATHER_NAME"));
				}
				if (empMasterData.rs.getString("NATIVE_DISTRICT") != null) {
					empMaster.setNdist(empMasterData.rs.getString("circle_office_name"));
				}
				// Debug.println("11111111.7");
				try {
					empMaster.setNmand(empMasterData.rs.getString("MNAME"));
				} catch (Exception e) {
				}

				if (empMasterData.rs.getString("RECRUIT_LOCAL_NONLOCAL") != null) {
					empMaster.setNarecruit(getRecName(empMasterData.rs.getString("RECRUIT_LOCAL_NONLOCAL")));
				}
				if (empMasterData.rs.getString("TEMP_PERMNENT") != null) {
					empMaster.setDesig(getTempPer(empMasterData.rs.getString("TEMP_PERMNENT")));
				}
				try {
					empMaster.setDesgnName(empMasterData.rs.getString("DESIGNATION_NAME"));
				} catch (Exception e) {
				}
				// Debug.println("11111111.8");
				if (empMasterData.rs.getString("MOAP_NAME") != null) {
					empMaster.setMoap(empMasterData.rs.getString("MOAP_NAME"));
				}

				if (empMasterData.rs.getString("APCATEG_NAME") != null) {
					empMaster.setApcatog(empMasterData.rs.getString("APCATEG_NAME"));
				}
				// Debug.println("11111111.9");
				if (empMasterData.rs.getString("ZONE_NAME") != null) {
					empMaster.setZone(empMasterData.rs.getString("ZONE_NAME"));
				}
				if (empMasterData.rs.getString("SEX") != null) {
					empMaster.setGender(getGenderName(empMasterData.rs.getString("SEX")));
				}
				// Debug.println("11111111.10");
				try {
					if (empMasterData.rs.getString("PAN_NO") != null) {
						empMaster.setPanno(empMasterData.rs.getString("PAN_NO"));
					}
					if (empMasterData.rs.getString("APGLI_NO") != null) {
						empMaster.setApgli(empMasterData.rs.getString("APGLI_NO"));
					}
					if (empMasterData.rs.getString("GPF_NO") != null) {
						empMaster.setGpfno(empMasterData.rs.getString("GPF_NO"));
					}
					if (empMasterData.rs.getString("PRESENT_STATION_MANDAL") != null) {
						empMaster.setPresentation(empMasterData.rs.getString("PRESENT_STATION_MANDAL"));
					}
					if (empMasterData.rs.getString("OTHER_DETAILS") != null) {
						empMaster.setOtherDet(empMasterData.rs.getString("OTHER_DETAILS"));
					}
				} catch (Exception e) {
				}
				// Debug.println("11111111.11");
				if (empMasterData.rs.getString("RELG_NAME") != null) {
					empMaster.setReligion(empMasterData.rs.getString("RELG_NAME"));
				}

				if (empMasterData.rs.getString("DEPT_OPTED") != null) {
					empMaster.setDept(empMasterData.rs.getString("DEPT_OPTED"));
				}
				// Debug.println("11111111.12");
				try {
					if (empMasterData.rs.getString("PH") != null) {
						empMaster.setHandicap(getYesNo(empMasterData.rs.getString("PH")));
					}
				} catch (Exception e) {
				}
				if (empMasterData.rs.getString("SECTION") != null) {
					empMaster.setSection(empMasterData.rs.getString("SECTION"));
				}
				if (empMasterData.rs.getString("APPOINT_CATEGORY") != null) {
					empMaster.setApptcategory(empMasterData.rs.getString("APPOINT_CATEGORY"));
				}
				// Debug.println("11111111.13");
				emps.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println("The error in getEmps" + e);
			e.printStackTrace();
		} finally {
			empMasterData.closeAll();
		}
		return emps;
	}

	// code added for EmpCheckList Report

	public static ArrayList getEmps1(String hoc, String coc, String doc, String sdoc, String fromdate, String todate,
			DataSource dataSource) throws Exception {
		String str;
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;// Form bean
		ArrayList emps = new ArrayList();

		try {
			empMasterData.conn = RwsOffices.getConn();								
			if (!hoc.equals("0") && coc.equals("00") && doc.equals("0") && sdoc.equals("00") && fromdate.equals("")
					&& todate.equals("")) {
				empMasterData.pstmt = empMasterData.conn.prepareStatement( "selec * from rws_employee_tbl where substr(office_code,1,1)=? order by EMPLOYEE_CODE");		
				empMasterData.pstmt.setString(1, hoc);
			} else if (!hoc.equals("0") && coc.equals("00") && doc.equals("0") && sdoc.equals("00")) {
				empMasterData.pstmt = empMasterData.conn.prepareStatement("select * from rws_employee_tbl where substr(office_code,1,1)=? "
						+ "and UPDATE_DATE>=to_Date(?,'dd/mm/yy') and UPDATE_DATE<=to_Date(?,'dd/mm/yy') order by EMPLOYEE_CODE,UPDATE_DATE desc");		
				empMasterData.pstmt.setString(1, hoc);		
				empMasterData.pstmt.setString(2, fromdate);
				empMasterData.pstmt.setString(3, todate);
			}else if (!hoc.equals("0") && !coc.equals("00") && doc.equals("0") && sdoc.equals("00")
					&& fromdate.equals("") && todate.equals("")) {
				empMasterData.pstmt = empMasterData.conn.prepareStatement( "select * from rws_employee_tbl where substr(office_code,1,1)=? "
						+ " and substr(office_code,2,2)=? order by EMPLOYEE_CODE desc");		
				empMasterData.pstmt.setString(1, hoc);	
				empMasterData.pstmt.setString(2, coc);
			}else if (!hoc.equals("0") && !coc.equals("00") && doc.equals("0") && sdoc.equals("00")) {
				empMasterData.pstmt = empMasterData.conn.prepareStatement("select * from rws_employee_tbl where substr(office_code,1,1)=? "
						+ " and substr(office_code,2,2)=? and UPDATE_DATE >= to_Date(?,'dd/mm/yy') and UPDATE_DATE<=to_Date(?,'dd/mm/yy') order by EMPLOYEE_CODE,UPDATE_DATE desc");		
				empMasterData.pstmt.setString(1, hoc);	
				empMasterData.pstmt.setString(2, coc);		
				empMasterData.pstmt.setString(3, fromdate);
				empMasterData.pstmt.setString(4, todate);
			}else if (!hoc.equals("0") && !coc.equals("00") && !doc.equals("0") && sdoc.equals("00")
					&& fromdate.equals("") && todate.equals("")) {
				empMasterData.pstmt = empMasterData.conn.prepareStatement("select * from rws_employee_tbl where substr(office_code,1,1)=?"
						+ " and substr(office_code,2,2)=? and substr(office_code,4,1)=?  order by EMPLOYEE_CODE desc");		
				empMasterData.pstmt.setString(1, hoc);		
				empMasterData.pstmt.setString(2, coc);		
				empMasterData.pstmt.setString(3, doc);		
			}
			else if (!hoc.equals("0") && !coc.equals("00") && !doc.equals("0") && sdoc.equals("00")) {
				empMasterData.pstmt = empMasterData.conn.prepareStatement( "select * from rws_employee_tbl where substr(office_code,1,1)=?"
						+ " and substr(office_code,2,2)=? and substr(office_code,4,1)=? and UPDATE_DATE >= to_Date(?,'dd/mm/yy') and "
						+ "UPDATE_DATE<=to_Date(?,'dd/mm/yy') order by EMPLOYEE_CODE,UPDATE_DATE desc");		
				empMasterData.pstmt.setString(1, hoc);	
				empMasterData.pstmt.setString(2, coc);		
				empMasterData.pstmt.setString(3, doc);		
				empMasterData.pstmt.setString(4, fromdate);
				empMasterData.pstmt.setString(5, todate);
			}		
			else if (!hoc.equals("0") && !coc.equals("00") && !doc.equals("0") && !sdoc.equals("00")
					&& fromdate.equals("") && todate.equals("")) {
				empMasterData.pstmt = empMasterData.conn.prepareStatement( "select * from rws_employee_tbl where substr(office_code,1,1)=?"
						+ " and substr(office_code,2,2)=? and substr(office_code,4,1)=? and substr(office_code,5,2)=? order by EMPLOYEE_CODE desc");		
				empMasterData.pstmt.setString(1, hoc);	
				empMasterData.pstmt.setString(2, coc);		
				empMasterData.pstmt.setString(3, doc);	
				empMasterData.pstmt.setString(4, sdoc);	
			}

			else if (!hoc.equals("0") && !coc.equals("00") && !doc.equals("0") && !sdoc.equals("00")) {
				empMasterData.pstmt = empMasterData.conn.prepareStatement(  "select * from rws_employee_tbl where substr(office_code,1,1)='" + hoc
						+ "' and substr(office_code,2,2)=? and substr(office_code,4,1)=? and substr(office_code,5,2)=?"
						+ " and UPDATE_DATE >= to_Date(?,'dd/mm/yy') and UPDATE_DATE<=to_Date(?,'dd/mm/yy') order by EMPLOYEE_CODE,UPDATE_DATE desc");		
				empMasterData.pstmt.setString(1, hoc);				
				empMasterData.pstmt.setString(2, coc);		
				empMasterData.pstmt.setString(3, doc);	
				empMasterData.pstmt.setString(4, sdoc);	
				empMasterData.pstmt.setString(5, fromdate);
				empMasterData.pstmt.setString(6, todate);
			}			
			empMasterData.rs = empMasterData.pstmt.executeQuery();		
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setEmpcode(empMasterData.rs.getString("EMPLOYEE_CODE"));
				empMaster.setSurname(empMasterData.rs.getString("EMPLOYEE_SURNAME"));
				empMaster.setEmpname(empMasterData.rs.getString("EMPLOYEE_NAME"));
				if (empMasterData.rs.getString("SECTOR") != null) {
					empMaster.setRoc(getHeadName(empMasterData.rs.getString("SECTOR")));
				}
				if (empMasterData.rs.getString("OFFICE_CODE") != null) {
					String officeNames[] = new String[5];
					String hoc1 = null;
					String coc1 = null;
					String doc1 = null;
					String sdoc1 = null;
					if (officeNames != null) {
						nic.watersoft.commons.RwsOffices rwsOffices = new nic.watersoft.commons.RwsOffices(dataSource);
						officeNames = rwsOffices.getOfficeNames(empMasterData.rs.getString("OFFICE_CODE"), true,
								dataSource);
						hoc1 = officeNames[0];
						coc1 = officeNames[1];
						doc1 = officeNames[2];
						sdoc1 = officeNames[3];
						empMaster.setHoc(hoc1);
						empMaster.setCoc(coc1);
						empMaster.setDoc(doc1);
						empMaster.setSdoc(sdoc1);
					}
				}
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
					empMaster.setCurrentpostdate(df.format(empMasterData.rs.getDate("CURRENT_POST_HELD_FROM")));
				}
				empMaster.setQual(empMasterData.rs.getString("QUAL_CODE"));
				try {
					empMaster.setQualName(getQualName(empMasterData.rs.getString("QUAL_CODE")));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}
				empMaster.setAddqual2(empMasterData.rs.getString("ADD_QUAL_2"));
				try {
					empMaster.setAddqual2(getQualName(empMasterData.rs.getString("ADD_QUAL_2")));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}
				
				empMaster.setHof(empMasterData.rs.getString("HEAD_OF_OFFICE"));
				empMaster.setPresentation(empMasterData.rs.getString("PRESENT_STATION_MANDAL"));
					// empMaster.setWorkSpecial(empMasterData.rs.getString("WORK_SPECIALIZATION"));
				try {
					empMaster.setWorkSpecial(
							getWorkSpecName(empMasterData.rs.getString("WORK_SPECIALIZATION"), dataSource));
					
				} catch (Exception e) {
					Debug.println("Error in getworkSpecial(); " + e);
				}

				try// if(empMasterData.rs.getString("SENIORITY")!=null)
				{
					empMaster.setSeniority(empMasterData.rs.getString("SENIORITY"));
				} catch (Exception e) {
					Debug.println("Error in getSeniority(); " + e);
				}

				empMaster.setRelation(empMasterData.rs.getString("FATHER_NAME"));

				try {
					empMaster.setNdist(getDistrictName(empMasterData.rs.getString("NATIVE_DISTRICT"), dataSource));
				} catch (Exception e) {
					Debug.println(" error in Native District" + e);
				}
				try {
					empMaster.setNmand(getMandalName(empMasterData.rs.getString("NATIVE_DISTRICT"),
							empMasterData.rs.getString("NATIVE_MANDAL")));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				// Debug.println("Nmand details executed");
				try {
					empMaster.setNarecruit(getRecName(empMasterData.rs.getString("RECRUIT_LOCAL_NONLOCAL")));
				} catch (Exception e) {
					Debug.println("error in Narecruit" + e);
				}
				// empMaster.setNarecruit(empMasterData.rs.getString("RECRUIT_LOCAL_NONLOCAL"));
				if (empMasterData.rs.getDate("DATE_OF_COMMENCE_PROBATION") != null) {
					empMaster.setDcommprob(df.format(empMasterData.rs.getDate("DATE_OF_COMMENCE_PROBATION")));
				}
				// empMaster.setDcommprob(empMasterData.rs.getString("DATE_OF_COMMENCE_PROBATION"));
				if (empMasterData.rs.getDate("DATE_OF_REGULARISATION") != null) {
					empMaster.setDdeclprob(df.format(empMasterData.rs.getDate("DATE_OF_REGULARISATION")));
				}
				// empMaster.setDdeclprob(empMasterData.rs.getString("DATE_OF_REGULARISATION"));

				if (empMasterData.rs.getDate("ACCTEST_PASS_DATE") != null) {
					empMaster.setDacctest(df.format(empMasterData.rs.getDate("ACCTEST_PASS_DATE")));
				}
				try {
					empMaster.setDesig(getTempPer(empMasterData.rs.getString("TEMP_PERMNENT")));
				} catch (Exception e) {
					Debug.println("error in Desig" + e);

				}
				try {
					empMaster.setDesgnName(getDesigName(empMasterData.rs.getString("DESIGNATION_CODE")));
				} catch (Exception e) {
					Debug.println("error in Designation" + e);
				}
				try {
					empMaster.setTempdesgCode(getDesigName(empMasterData.rs.getString("DESIGNATION_CODE")));
				} catch (Exception e) {
					Debug.println("error in Designation" + e);
				}

				// empMaster.setPerdesig(empMasterData.rs.getString("TEMP_PERMNENT"));
				if (empMasterData.rs.getDate("CURRENT_POST_HELD_FROM") != null) {
					empMaster.setCurrentpostdate(df.format(empMasterData.rs.getDate("CURRENT_POST_HELD_FROM")));
				}
				empMaster.setSurname(empMasterData.rs.getString("EMPLOYEE_SURNAME"));
				try {
					empMaster.setZone(getZoneName(empMasterData.rs.getString("ZONE_CODE"), dataSource));
				} catch (Exception e) {
					Debug.println("the error in zone= " + e);
				}
				// empMaster.setZone(empMasterData.rs.getString("ZONE_CODE"));
				// Debug.println("zone details executed");
				try {
					empMaster.setApcatog(getCatogName(empMasterData.rs.getString("APCATEG_CODE"), dataSource));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}
				// empMaster.setApcatog(empMasterData.rs.getString("APCATEG_CODE"));
				try {
					empMaster.setMoap(getModeName(empMasterData.rs.getString("MOAP_CODE"), dataSource));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				// Added on Aug 12
				try {
					empMaster.setGender(getGenderName(empMasterData.rs.getString("SEX")));
				} catch (Exception e) {
					Debug.println("error in Gender name" + e);
				}
				empMaster.setNrevenue(empMasterData.rs.getString("NATIVE_REV_DIVISION"));
				try {
					empMaster.setTestpassed(getYesNo(empMasterData.rs.getString("ACCTEST_PASSED")));
				} catch (Exception e) {
					Debug.println("error in AccTest" + e);
				}

				// Debug.println("Sex acctest");
				try {
					empMaster.setDeputation(getYesNo(empMasterData.rs.getString("DEPUTATION")));
				} catch (Exception e) {
					Debug.println("error in Deputaion" + e);
				}
				empMaster.setPanno(empMasterData.rs.getString("PAN_NO"));
				empMaster.setApgli(empMasterData.rs.getString("APGLI_NO"));
				// Debug.println("in the pan_no");
				empMaster.setPayscale(empMasterData.rs.getString("PAY_SCALE_PRESENT"));
				if (empMasterData.rs.getDate("UPDATE_DATE") != null) {
					empMaster.setIncrementdate(df.format(empMasterData.rs.getDate("UPDATE_DATE")));
				}
				// Debug.println("payscale increment data");

				// Debug.println("designation details executed");
				empMaster.setOtherDet(empMasterData.rs.getString("OTHER_DETAILS"));
				empMaster.setDesgnCode(empMasterData.rs.getString("DESIGNATION_CODE"));
				empMaster.setCheckType(empMasterData.rs.getString("TYPE_OF_CHECK"));
				empMaster.setNoOfChecks(empMasterData.rs.getInt("NO_OF_CHECKS"));
				empMaster.setCheckPeriod(empMasterData.rs.getString("CHECK_PERIOD"));
				empMaster.setAppOrderRef(empMasterData.rs.getString("APPOINTMENT_ORDER_REF"));
				empMaster.setWorkSpecial(empMasterData.rs.getString("WORK_SPECIALIZATION"));
				empMaster.setPostCode(empMasterData.rs.getString("POST_JOINED_DESG_CODE"));

				// Added on Aug 2
				// empMaster.setReligion(empMasterData.rs.getString("RELG_CODE"));
				// empMaster.setReligion(empMasterData.rs.getString("RELG_CODE"));
				try {
					empMaster.setReligion(getReligionName(empMasterData.rs.getString("RELG_CODE"), dataSource));
				} catch (Exception e) {
					Debug.println("the error in Religion getemps1= " + e);
				}

				empMaster.setDiststudied4(empMasterData.rs.getString("DIST_CLASS_IV"));
				try {
					empMaster.setDiststudied4(getDistrictName(empMasterData.rs.getString("DIST_CLASS_IV"), dataSource));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}
				empMaster.setDiststudied5(empMasterData.rs.getString("DIST_CLASS_V"));
				try {
					empMaster.setDiststudied5(getDistrictName(empMasterData.rs.getString("DIST_CLASS_V"), dataSource));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				empMaster.setDiststudied6(empMasterData.rs.getString("DIST_CLASS_VI"));
				try {
					empMaster.setDiststudied6(getDistrictName(empMasterData.rs.getString("DIST_CLASS_VI"), dataSource));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}
				empMaster.setDiststudied7(empMasterData.rs.getString("DIST_CLASS_VII"));
				try {
					empMaster
							.setDiststudied7(getDistrictName(empMasterData.rs.getString("DIST_CLASS_VII"), dataSource));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}
				empMaster.setDiststudied8(empMasterData.rs.getString("DIST_CLASS_VIII"));
				try {
					empMaster.setDiststudied8(
							getDistrictName(empMasterData.rs.getString("DIST_CLASS_VIII"), dataSource));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}
				empMaster.setDiststudied9(empMasterData.rs.getString("DIST_CLASS_IX"));
				try {
					empMaster.setDiststudied9(getDistrictName(empMasterData.rs.getString("DIST_CLASS_IX"), dataSource));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}
				empMaster.setDiststudied10(empMasterData.rs.getString("DIST_CLASS_X"));
				try {
					empMaster.setDiststudied10(getDistrictName(empMasterData.rs.getString("DIST_CLASS_X"), dataSource));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}
				try {
					empMaster.setLocaldist(
							getDistrictName(empMasterData.rs.getString("LOCAL_DIST_AS_PER_SCH"), dataSource));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				empMaster.setNoofyrs(empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_DIST"));
				// Debug.println("the getemps
				// Noofyrs"+empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_DIST"));
				try {
					empMaster.setLocalzone(getZoneName(empMasterData.rs.getString("LOCAL_ZONE"), dataSource));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				empMaster.setNoofyrs1(empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_ZONE"));
				// Debug.println("the getemps
				// Noofyrs1"+empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_ZONE"));
				try {
					empMaster
							.setPvtdist(getDistrictName(empMasterData.rs.getString("PRIVATE_PASSED_DIST"), dataSource));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				try {
					empMaster.setPvtzone(getZoneName(empMasterData.rs.getString("PRIVATE_PASSED_ZONE"), dataSource));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				// Debug.println("end statement executed");
				emps.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println("The error in getEmps" + e);
		} finally {
			empMasterData.closeAll();
		}
		return emps;
	}

	public static String getTempPer(String rec) throws Exception {
		String name = null;

		if (rec.equalsIgnoreCase("T")) {
			name = "TEMPORARY";
		} else if (rec.equalsIgnoreCase("P")) {
			name = "PERMNENT";
		}
		return name;
	}

	public static String getRecName(String rec) throws Exception {
		String name = null;

		if (rec.equalsIgnoreCase("L")) {
			name = "Local";
		} else if (rec.equalsIgnoreCase("N")) {
			name = "NON-LOCAL";
		}
		return name;
	}

	public static String getWorkingName(String gen) throws Exception {
		String name = null;

		if (gen.equalsIgnoreCase("C")) {
			name = "CENTERAL";
		} else if (gen.equalsIgnoreCase("S")) {
			name = "STATE";
		} else if (gen.equalsIgnoreCase("P")) {
			name = "PSU";
		}

		return name;
	}

	public static String getGenderName(String gen) throws Exception {
		String name = null;

		if (gen.equalsIgnoreCase("M")) {
			name = "Male";
		} else if (gen.equalsIgnoreCase("F")) {
			name = "Female";
		}
		return name;
	}

	public static String getLeaveSus(String opt) throws Exception {
		String option = null;
		if (opt.equalsIgnoreCase("L")) {
			option = "LEAVE";
		} else if (opt.equalsIgnoreCase("S")) {
			option = "SUSPENDED";
		}
		return option;
	}

	public static String getYesNo(String opt) throws Exception {
		String option = null;
		if (opt.equalsIgnoreCase("Y")) {
			option = "Yes";
		} else if (opt.equalsIgnoreCase("N")) {
			option = "No";
		}
		return option;
	}

	public static String getModeName(String code) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = RwsOffices.getConn();
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			// Debug.println("in getCatName");
			// Debug.println("ConnCount is "+connCount);
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			if (code != null) {
				empMasterData.rs1 = empMasterData.stmt1
						.executeQuery("SELECT MOAP_NAME FROM RWS_MODEOFAPP_MST_TBL  WHERE MOAP_CODE =" + code);
				empMasterData.rs1.next();
				name = empMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			Debug.println("Ther error in getCatName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getCatogName(String code) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		// connCount--;
		empMasterData.conn = RwsOffices.getConn();
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			// Debug.println("in getCatName");
			// Debug.println("ConnCount is "+connCount);
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			if (code != null) {
				empMasterData.rs1 = empMasterData.stmt1
						.executeQuery("SELECT APCATEG_NAME FROM RWS_APP_CATEGORY_MST_TBL  WHERE APCATEG_CODE =" + code);
				empMasterData.rs1.next();
				name = empMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			Debug.println("Ther error in getCatName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	// same code with dataSource
	public static String getModeName(String code, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		// connCount--;
		empMasterData.conn = RwsOffices.getConn();
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			// Debug.println("in getCatName");
			// Debug.println("ConnCount is "+connCount);
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			if (code != null) {
				empMasterData.rs1 = empMasterData.stmt1
						.executeQuery("SELECT MOAP_NAME FROM RWS_MODEOFAPP_MST_TBL  WHERE MOAP_CODE =" + code);
				empMasterData.rs1.next();
				name = empMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			Debug.println("Ther error in getCatName=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return name;
	}

	// same code with dataSource
	public static String getCatogName(String code, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		// connCount--;
		empMasterData.conn = RwsOffices.getConn();
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			Debug.println("in getCatName");
			Debug.println("ConnCount is " + connCount);
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			if (code != null) {
				empMasterData.rs1 = empMasterData.stmt1
						.executeQuery("SELECT APCATEG_NAME FROM RWS_APP_CATEGORY_MST_TBL  WHERE APCATEG_CODE =" + code);
				empMasterData.rs1.next();
				name = empMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			Debug.println("Ther error in getCatName=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return name;
	}

	public static ArrayList getFromDate(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		String query;
		ArrayList fromDate = new ArrayList();
		try {
			// query = "select distinct to_char(access_date,'DD/MM/yy') from rws_log_tbl
			// order by to_char(access_date,'DD/MM/yy') desc";
			query = "select distinct to_char(DATE_OF_JOINING,'dd/mm/yyyy') as a1 from rws_employee_tbl order by substr(a1,7,10) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";

			// Debug.println("query for Date of Join "+query);
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt.executeQuery(query);
			EmpMaster empMaster = null;
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setFromDate(empMasterData.rs.getString(1));
				// Debug.println("EmpMaster fromDate"+empMaster.getFromDate());
				fromDate.add(empMaster);
			}
			empMasterData.conn.close();
		} catch (Exception e) {
			Debug.println("Exception in GetDate in EmpMaster :" + e);
		}

		return fromDate;
	}

	public static ArrayList getFromDates1(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		String query;
		ArrayList fromDate = new ArrayList();
		try {
			query = "select distinct to_char(UPDATE_DATE,'dd/mm/yy') as a1 from rws_employee_tbl where to_char(UPDATE_DATE,'dd/mm/yy') is not null order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt.executeQuery(query);
			EmpMaster empMaster = null;
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setFromDate(empMasterData.rs.getString(1));			
				fromDate.add(empMaster);
			}			
		} catch (Exception e) {
			Debug.println("Exception in getFromDates1in EmpMasterData  : " + e);
		}finally {
			empMasterData.closeAll();
		}
		return fromDate;
	}

	public static ArrayList getToDates1(String fromDate, DataSource dataSource) {
		String query;
		ArrayList toDate = new ArrayList();
		EmpMasterData empMasterData = new EmpMasterData();
	
		try {	

					query = "select distinct to_char(UPDATE_DATE,'dd/mm/yy') as a1 from rws_employee_tbl where UPDATE_DATE>=to_Date('"
							+ fromDate
							+ "','dd/mm/yy') order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";

	
			/*
			 * query="select unique(to_char(access_date,'dd/mm/yyyy')) from rws_log_tbl
			 * where to_date(ACCESS_DATE,'dd/mon/yyyy') >=
			 * to_Date('"+fromDate+"','dd/mm/yyyy')";
			 */

			/*
			 * query="select unique(to_Char(access_date,'dd/mm/yy')) from rws_log_tbl where
			 * to_Date(ACCESS_DATE,'dd/mon/yyyy') >= to_Date('"+fromDate+"','dd/mm/yyyy')";
			 */

			empMasterData.conn = RwsOffices.getConn();
			// Debug.println("empMasterData.conn" + empMasterData.conn);
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt.executeQuery(query);
			EmpMaster empMaster = null;
			// Debug.println("empMasterData.rs.next() :"+empMasterData.rs.next());

			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setToDate(empMasterData.rs.getString(1));
				// Debug.println("EmpMaster toDate" + empMaster.getToDate());
				toDate.add(empMaster);
			}
			empMasterData.conn.close();
		} catch (Exception e) {
			Debug.println("Exception in getToDates in EmpMasterData :" + e);
		}
		return toDate;
	}

	// end of code added

	// code added for Emp Status Report

	public static ArrayList getEmpsReport(String hoc, String coc, String doc, String sdoc, String detailwise,
			String selected[], String sectors, DataSource dataSource) throws Exception {
		String str;
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;// Form bean
		ArrayList empsReport = new ArrayList();
		String tittle = null;

		try {
			empMasterData.conn = RwsOffices.getConn();
			// Debug.println("connection established");
			empMasterData.stmt = empMasterData.conn.createStatement();

			// Debug.println("create statement executed");
			String query = "";

			// Testing new Code 23-12-2007

			query = "select * from rws_employee_tbl where ";

			if (!hoc.equals("0")) {
				query += " substr(office_code,1,1)='" + hoc + "' ";
			}
			if (!coc.equals("00")) {
				query += " and substr(office_code,2,2)='" + coc + "' ";
			}
			if (!doc.equals("0")) {
				query += " and substr(office_code,4,1)='" + doc + "' ";
			}
			if (!sdoc.equals("00")) {
				query += " and substr(office_code,5,2)='" + sdoc + "' ";
			}
			if (!sectors.equals("0") && sectors != null) {
				query += " and sector='" + sectors + "' ";
			}
			if (detailwise != null && detailwise.equals("01")) {
				if (selected.length != 0) {
					query += " and ( ";
					for (int i = 0; i < selected.length; i++) {
						query += "designation_code='" + selected[i] + "' ";
						if (i < selected.length - 1) {
							query += " or ";
						}
					}
					query += ") ";
				}

			}
			if (detailwise != null && detailwise.equals("02")) {
				if (selected.length != 0) {
					query += " and  (";
					for (int i = 0; i < selected.length; i++) {
						query += "zone_code='" + selected[i] + "' ";
						if (i < selected.length - 1) {
							query += " or ";
						}
					}
					query += ") ";
				}
			}
			query += " order by designation_code,zone_code,employee_code ";

			empMasterData.rs = empMasterData.stmt.executeQuery(query);
			// end of code added

			// empMasterData.rs =empMasterData.stmt.executeQuery(query);
			// Debug.println("executed Query "+query);
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				// Debug.println("rws statement executed");

				empMaster.setDesgnCode(empMasterData.rs.getString("DESIGNATION_CODE"));
				empMaster.setDesgnName(getDesgnName(empMasterData.rs.getString("DESIGNATION_CODE"), dataSource));

				empMaster.setEmpcode(empMasterData.rs.getString("EMPLOYEE_CODE"));
				empMaster.setEmpname(empMasterData.rs.getString("EMPLOYEE_NAME"));

				if (empMasterData.rs.getString("SECTOR") != null) {
					empMaster.setRoc(getHeadName(empMasterData.rs.getString("SECTOR")));
				}

				if (empMasterData.rs.getString("OFFICE_CODE") != null) {
					String officeNames[] = new String[5];
					String hoc1 = null;
					String coc1 = null;
					String doc1 = null;
					String sdoc1 = null;
					if (officeNames != null) {
						nic.watersoft.commons.RwsOffices rwsOffices = new nic.watersoft.commons.RwsOffices(dataSource);
						officeNames = rwsOffices.getOfficeNames(empMasterData.rs.getString("OFFICE_CODE"), true,
								dataSource);
						hoc1 = officeNames[0];
						coc1 = officeNames[1];
						doc1 = officeNames[2];
						sdoc1 = officeNames[3];
						// empMaster.setHoc(hoc1+coc1+doc1+sdoc1);
						empMaster.setHoc(hoc1);
						empMaster.setCoc(coc1);
						empMaster.setDoc(doc1);
						empMaster.setSdoc(sdoc1);
					}
					Debug.println("");
				} // catch(Exception e)
					// {
					// Debug.println("error in office Code "+e);
					// }
					// Debug.println("rwsOffices1");

				if (empMasterData.rs.getDate("DATE_OF_BIRTH") != null) {
					empMaster.setDob(df.format(empMasterData.rs.getDate("DATE_OF_BIRTH")));
				}
				if (empMasterData.rs.getDate("APPOINTMENT_DATE") != null) {
					empMaster.setAppointdate(df.format(empMasterData.rs.getDate("APPOINTMENT_DATE")));
				}
				if (empMasterData.rs.getDate("DATE_OF_JOINING") != null) {
					empMaster.setDoj(df.format(empMasterData.rs.getDate("DATE_OF_JOINING")));
				}
				empMaster.setRelation(empMasterData.rs.getString("FATHER_NAME"));
				empMaster.setZoneName(getZoneName(empMasterData.rs.getString("ZONE_CODE"), dataSource));
				// empMaster.setZone(empMasterData.rs.getString("ZONE_CODE"));
				empMaster.setLocalzone(getZoneName(empMasterData.rs.getString("LOCAL_ZONE"), dataSource));

				empsReport.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println("The error in getEmpsReport() " + e);
		} finally {
			empMasterData.closeAll();
		}
		return empsReport;
	}

	// end of code added
	public static ArrayList getEmpDeptOpt(String dept, DataSource dataSource) {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;// Form bean
		ArrayList DeptReport = new ArrayList();
		try {
			empMasterData.conn = RwsOffices.getConn();
			// Debug.println("connection established");
			empMasterData.stmt = empMasterData.conn.createStatement();
			// Debug.println("create statement executed");
			String query = "";
			// Debug.println("Department opted value in EmpMasterData"+dept);
			query = "select * from rws_employee_tbl where DEPT_OPTED='" + dept + "' order by employee_code";

			empMasterData.rs = empMasterData.stmt.executeQuery(query);
			// Debug.println("query in DeptOpted wise report"+query);
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				// Debug.println("rws statement executed");
				empMaster.setEmpcode(empMasterData.rs.getString("EMPLOYEE_CODE"));
				empMaster.setEmpname(empMasterData.rs.getString("EMPLOYEE_NAME"));
				empMaster.setRoc(empMasterData.rs.getString("OFFICE_CODE"));
				if (empMasterData.rs.getString("SECTOR") != null) {
					empMaster.setHoc(getHeadName(empMasterData.rs.getString("SECTOR")));
				}
				// Debug.println("employee details executed");
				if (empMasterData.rs.getString("DESIGNATION_CODE") != null) {
					empMaster.setDesgnName(getDesgnName(empMasterData.rs.getString("DESIGNATION_CODE"), dataSource));
				}
				if (empMasterData.rs.getString("DEPT_OPTED") != null) {
					empMaster.setDeptopted(empMasterData.rs.getString("DEPT_OPTED"));
				}
				// Debug.println("end statement executed IN DEPT_OPTED");
				DeptReport.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println("The error in getEmps" + e);
		}

		return DeptReport;
	}

	public static ArrayList getSpousework(String spousework, DataSource dataSource) {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;// Form bean
		ArrayList spouseworking = new ArrayList();
		try {
			empMasterData.conn = RwsOffices.getConn();
			// Debug.println("connection established");
			empMasterData.stmt = empMasterData.conn.createStatement();
			// Debug.println("create statement executed");
			String query = "";
			// Debug.println("spouse work in EmpMasterData"+spousework);
			query = "select * from rws_employee_tbl e,rws_employee_spouse_tbl s where e.employee_code=s.employee_code order by e.employee_code";
			empMasterData.rs = empMasterData.stmt.executeQuery(query);
			// Debug.println("query in DeptOpted wise report"+query);
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				// Debug.println("rws statement executed");
				empMaster.setEmpcode(empMasterData.rs.getString(2));
				empMaster.setEmpname(empMasterData.rs.getString("EMPLOYEE_NAME"));
				empMaster.setRoc(empMasterData.rs.getString("OFFICE_CODE"));
				if (empMasterData.rs.getString("SECTOR") != null) {
					empMaster.setHoc(getHeadName(empMasterData.rs.getString("SECTOR")));
				}
				// Debug.println("employee details executed");
				if (empMasterData.rs.getString("DESIGNATION_CODE") != null) {
					empMaster.setDesgnName(
							getDesgnName(empMasterData.rs.getString("DESIGNATION_CODE"), empMasterData.conn));
				}
				if (empMasterData.rs.getString("DEPT_OPTED") != null) {
					empMaster.setDeptopted(empMasterData.rs.getString("DEPT_OPTED"));
				}
				if (empMasterData.rs.getDate("DATE_OF_JOINING") != null) {
					empMaster.setDoj(df.format(empMasterData.rs.getDate("DATE_OF_JOINING")));
				}
				if (empMasterData.rs.getString("SPOUSE_CENTRE_STATE") != null) {
					empMaster.setSpouseworking((empMasterData.rs.getString("SPOUSE_CENTRE_STATE")));
				}
				if (empMasterData.rs.getString("SPOUSE_EMPLOYED") != null) {
					empMaster.setSpouseemployd((empMasterData.rs.getString("SPOUSE_EMPLOYED")));
				}

				// Debug.println("end statement executed IN DEPT_OPTED");
				spouseworking.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println("The error in getEmps" + e);
		}

		return spouseworking;
	}

	// code for Emp Department Opted Report
	public static ArrayList getEmpDeptOpt(EmpMaster empMaster, String dept, String fdate, String spousework,
			String apcat, String desig, String semployd, DataSource dataSource) {
		EmpMasterData empMasterData = new EmpMasterData();
		// EmpMaster empMaster = null;//Form bean
		ArrayList DeptReport = new ArrayList();
		try {
			empMasterData.conn = RwsOffices.getConn();
			// Debug.println("connection established");
			empMasterData.stmt = empMasterData.conn.createStatement();
			// Debug.println("create statement executed");
			String query = "";
		
			query = "select e.employee_code,e.EMPLOYEE_SURNAME,e.office_code,e.employee_name,c.circle_office_name,d.division_office_name, sub.subdivision_office_name, e.QUAL_CODE,e.ADD_QUAL_1,e.ADD_QUAL_2,DATE_OF_BIRTH,APPOINTMENT_DATE, DATE_OF_JOINING,SKILL_DESCRIPTION,MNAME,FATHER_NAME, RECRUIT_LOCAL_NONLOCAL,e.TEMP_PERMNENT,DESIGNATION_NAME, MOAP_NAME,APCATEG_NAME,SEX,ZONE_NAME,PAN_NO, APGLI_NO,GPF_NO,PRESENT_STATION_MANDAL,OTHER_DETAILS, RELG_NAME,DEPT_OPTED,PH,SECTION,APPOINT_CATEGORY,e.NATIVE_DISTRICT,sector,SPOUSE_CENTRE_STATE,SPOUSE_EMPLOYED from rws_employee_tbl e,rws_employee_spouse_tbl s,rws_circle_office_tbl c ,rws_division_office_tbl d, rws_subdivision_office_tbl sub,RWS_SPEC_SKILL_TBL k, RWS_MODEOFAPP_MST_TBL m,RWS_ZONE_MST_TBL z, RWS_RELEGION_MST_TBL r,rws_mandal_tbl mn,RWS_APP_CATEGORY_MST_TBL cat,RWS_DESIGNATION_TBL des where e.employee_code=s.employee_code(+) and substr(e.office_code,2,2) =c.circle_office_code and c.circle_office_code=d.circle_office_code and c.circle_office_code=sub. circle_office_code and d.division_office_code=sub.division_office_code and substr(e.office_code,4,1)=d.division_office_code and substr (e.office_code,5,2)=sub.subdivision_office_code and e.WORK_SPECIALIZATION=k.skill_code(+)and e.MOAP_CODE=m.MOAP_CODE (+) and e.zone_code=z.zone_code(+) and e.relg_code=r.relg_code(+) and e.NATIVE_DISTRICT =mn.dcode(+) and e.NATIVE_MANDAL=mn.mcode(+) and e.APCATEG_CODE=cat.APCATEG_CODE(+) and e.DESIGNATION_CODE=des.DESIGNATION_CODE(+) and  substr(office_code,4,3)<>'000'";
			if (dept != null) {
				query += " and e.DEPT_OPTED='" + dept + "' ";
			}
			if (!fdate.equals("")) {
				query += " and e.DATE_OF_JOINING=to_Date('" + fdate + "','dd/mm/yyyy') ";
			}
			if (spousework != null) {
				query += " and s.SPOUSE_CENTRE_STATE='" + spousework + "' ";
			}
			if (semployd != null) {
				query += " and s.SPOUSE_EMPLOYED='" + semployd + "' ";
			}
			if (!apcat.equals("")) {
				query += " and e.APCATEG_CODE='" + apcat + "' ";
			}
			if (!desig.equals("")) {
				query += " and e.DESIGNATION_CODE='" + desig + "' ";
			}
			if (!empMaster.getQual().equals("")) {
				query += " and e.QUAL_CODE='" + empMaster.getQual() + "' ";
			}
			if (!empMaster.getPresentdesig().equals("")) {
				query += " and e.PRESENT_DESIG='" + empMaster.getPresentdesig() + "' ";
			}

			query += " union select e.employee_code,e.EMPLOYEE_SURNAME,e.office_code,e.employee_name,c.circle_office_name, '-' as division_office_name,'-' as subdivision_office_name,e.QUAL_CODE,e.ADD_QUAL_1,e.ADD_QUAL_2,DATE_OF_BIRTH,APPOINTMENT_DATE,DATE_OF_JOINING, SKILL_DESCRIPTION,MNAME,FATHER_NAME, RECRUIT_LOCAL_NONLOCAL,e.TEMP_PERMNENT,DESIGNATION_NAME,MOAP_NAME, APCATEG_NAME,SEX,ZONE_NAME,PAN_NO, APGLI_NO,GPF_NO,PRESENT_STATION_MANDAL,OTHER_DETAILS, RELG_NAME,DEPT_OPTED,PH,SECTION,APPOINT_CATEGORY,e.NATIVE_DISTRICT,sector,SPOUSE_CENTRE_STATE,SPOUSE_EMPLOYED from rws_employee_tbl e,rws_employee_spouse_tbl s,rws_circle_office_tbl c,RWS_SPEC_SKILL_TBL k, RWS_MODEOFAPP_MST_TBL m,RWS_ZONE_MST_TBL z, RWS_RELEGION_MST_TBL r,rws_mandal_tbl mn,RWS_APP_CATEGORY_MST_TBL cat,RWS_DESIGNATION_TBL des where e.employee_code=s.employee_code(+) and substr(e.office_code,2,2)=c.circle_office_code and e.WORK_SPECIALIZATION=k.skill_code(+) and e.MOAP_CODE=m.MOAP_CODE (+) and e.zone_code=z.zone_code(+) and e.relg_code=r.relg_code(+) and e.NATIVE_DISTRICT =mn.dcode(+) and e.NATIVE_MANDAL=mn.mcode(+) and e.APCATEG_CODE=cat.APCATEG_CODE(+) and e.DESIGNATION_CODE=des.DESIGNATION_CODE(+) and (substr(office_code,4,1)='0' or substr(office_code,5,2)='00')";
			if (dept != null) {
				query += " and e.DEPT_OPTED='" + dept + "' ";
			}
			if (!fdate.equals("")) {
				query += " and e.DATE_OF_JOINING=to_Date('" + fdate + "','dd/mm/yyyy') ";
			}
			if (spousework != null) {
				query += " and s.SPOUSE_CENTRE_STATE='" + spousework + "' ";
			}
			if (semployd != null) {
				query += " and s.SPOUSE_EMPLOYED='" + semployd + "' ";
			}
			if (!apcat.equals("")) {
				query += " and e.APCATEG_CODE='" + apcat + "' ";
			}
			if (!desig.equals("")) {
				query += " and e.DESIGNATION_CODE='" + desig + "' ";
			}
			if (!empMaster.getQual().equals("")) {
				query += " and e.QUAL_CODE='" + empMaster.getQual() + "' ";
			}
			if (!empMaster.getPresentdesig().equals("")) {
				query += " and e.PRESENT_DESIG='" + empMaster.getPresentdesig() + "' ";
			}
			query += " order by 1";

		//	Debug.println("query of Report in DeptOpted wise: " + query);
			empMasterData.rs = empMasterData.stmt.executeQuery(query);

			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				//Debug.println("rws statement executed");
				empMaster.setEmpcode(empMasterData.rs.getString("EMPLOYEE_CODE"));
				empMaster.setEmpname(empMasterData.rs.getString("EMPLOYEE_NAME"));
				if (empMasterData.rs.getString("sector").equals("1"))
					empMaster.setRoc("CE RWS");
				else if (empMasterData.rs.getString("sector").equals("2"))
					empMaster.setRoc("PR");
				else if (empMasterData.rs.getString("sector").equals("3"))
					empMaster.setRoc("VIGLANCE");
				//Debug.println("ssssss 1111111111111111111");
				empMaster.setHoc(empMasterData.rs.getString("OFFICE_CODE"));
				empMaster.setCoc(empMasterData.rs.getString("circle_office_name"));
				empMaster.setDoc(empMasterData.rs.getString("division_office_name"));
				empMaster.setSdoc(empMasterData.rs.getString("subdivision_office_name"));
			//	Debug.println("ssssss 111111111111.1");
				if (empMasterData.rs.getString("DESIGNATION_Name") != null) {
					empMaster.setDesgnName(empMasterData.rs.getString("DESIGNATION_Name"));
				}
		//		Debug.println("ssssss 111111111111.2");
				if (empMasterData.rs.getString("DEPT_OPTED") != null) {
					empMaster.setDeptopted(empMasterData.rs.getString("DEPT_OPTED"));
				}
			//	Debug.println("ssssss 111111111111.3");
				if (empMasterData.rs.getDate("DATE_OF_JOINING") != null) {
					empMaster.setDoj(df.format(empMasterData.rs.getDate("DATE_OF_JOINING")));
				}
			//	Debug.println("ssssss 11111111111141");
				if (empMasterData.rs.getString("SPOUSE_CENTRE_STATE") != null) {
					empMaster.setSpouseworking(empMasterData.rs.getString("SPOUSE_CENTRE_STATE"));
				}
			//	Debug.println("ssssss");
				if (empMasterData.rs.getString("SPOUSE_EMPLOYED") != null) {
					empMaster.setSpouseemployd(getYesNo(empMasterData.rs.getString("SPOUSE_EMPLOYED")));
				}
				//Debug.println("after ssssssss");
				if (empMasterData.rs.getString("APCATEG_NAME") != null) {
					empMaster.setApcatog(empMasterData.rs.getString("APCATEG_NAME"));
				}
			//	Debug.println("ssssss 22222222");
				try {
					if (empMasterData.rs.getString("QUAL_CODE") == null
							&& empMasterData.rs.getString("ADD_QUAL_1") == null
							&& empMasterData.rs.getString("ADD_QUAL_2") == null) {
						empMaster.setQualName("-");
						empMaster.setAddqual1("-");
						empMaster.setAddqual2("-");
					} else {
				//		Debug.println("in else");
						String[] values = getQualNames(empMasterData.rs.getString("QUAL_CODE"),
								empMasterData.rs.getString("ADD_QUAL_1"), empMasterData.rs.getString("ADD_QUAL_2"));

						empMaster.setQual(values[0]);
						empMaster.setAddqual1(values[1]);
						empMaster.setAddqual2(values[2]);
					}
				} catch (Exception e) {
				//	Debug.println("the error in getEmps()= " + e);
				}

				DeptReport.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println("The error in getEmps" + e);
		}

		return DeptReport;
	}
	//

	public static ArrayList getEmpsView(DataSource dataSource) throws Exception {
		String str;
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;// Form bean
		ArrayList emps = new ArrayList();

		try {
			empMasterData.conn = RwsOffices.getConn();
			// Debug.println("connection established");
			empMasterData.stmt = empMasterData.conn.createStatement();
			// Debug.println("create statement executed");
			String query = null;

			// code added
			query = "select * from rws_employee_tbl e,rws_employee_spouse_tbl s where e.employee_code=s.employee_code(+) order by e.employee_code";

			empMasterData.rs = empMasterData.stmt.executeQuery(query);
			// Debug.println("query in getEmps(hoc,coc,doc,sdoc) "+query);
			// Debug.println("select statement executed");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				// Debug.println("rws statement executed");
				try {
					empMaster.setEmpcode(empMasterData.rs.getString(2));
					empMaster.setSurname(empMasterData.rs.getString("EMPLOYEE_SURNAME"));
					empMaster.setEmpname(empMasterData.rs.getString("EMPLOYEE_NAME"));
				} catch (Exception e) {
					Debug.println("Error in Empname" + e);
				}

				if (empMasterData.rs.getString("OFFICE_CODE") != null) {
					String officeNames[] = new String[5];
					String hoc1 = null;
					String coc1 = null;
					String doc1 = null;
					String sdoc1 = null;
					if (officeNames != null) {
						nic.watersoft.commons.RwsOffices rwsOffices = new nic.watersoft.commons.RwsOffices(dataSource);
						officeNames = rwsOffices.getOfficeNames(empMasterData.rs.getString("OFFICE_CODE"), true,
								dataSource);
						hoc1 = officeNames[0];
						coc1 = officeNames[1];
						doc1 = officeNames[2];
						sdoc1 = officeNames[3];
						// empMaster.setHoc(hoc1+coc1+doc1+sdoc1);
						empMaster.setHoc(hoc1);
						empMaster.setCoc(coc1);
						empMaster.setDoc(doc1);
						empMaster.setSdoc(sdoc1);
					}
					//Debug.println("");
				}
				try {
					if (empMasterData.rs.getString("SECTOR") != null) {
						empMaster.setRoc(getHeadName(empMasterData.rs.getString("SECTOR")));
					}
				} catch (Exception e) {
					Debug.println("Error in sector" + e);
				}

				try {
					if (empMasterData.rs.getDate("DATE_OF_BIRTH") != null) {
						empMaster.setDob(df.format(empMasterData.rs.getDate("DATE_OF_BIRTH")));
					}
				} catch (Exception e) {
					Debug.println("Error in DOB" + e);
				}

				try {
					if (empMasterData.rs.getDate("APPOINTMENT_DATE") != null) {
						empMaster.setAppointdate(df.format(empMasterData.rs.getDate("APPOINTMENT_DATE")));
					}
				} catch (Exception e) {
					Debug.println("Error in AppointDate" + e);
				}

				try {
					if (empMasterData.rs.getDate("DATE_OF_JOINING") != null) {
						empMaster.setDoj(df.format(empMasterData.rs.getDate("DATE_OF_JOINING")));
					}
				} catch (Exception e) {
					Debug.println("Error in Doj" + e);
				}

				try {
					if (empMasterData.rs.getDate("CURRENT_POST_HELD_FROM") != null) {
						empMaster.setCurrentpostdate(df.format(empMasterData.rs.getDate("CURRENT_POST_HELD_FROM")));
					}
				} catch (Exception e) {
					Debug.println("Error in currentPost" + e);
				}
				try {
					if (empMasterData.rs.getDate("DATE_OF_COMMENCE_PROBATION") != null) {
						empMaster.setDcommprob(df.format(empMasterData.rs.getDate("DATE_OF_COMMENCE_PROBATION")));
					}
				} catch (Exception e) {
					Debug.println("Error in dcomprob" + e);
				}

				try {
					if (empMasterData.rs.getDate("DATE_OF_REGULARISATION") != null) {
						empMaster.setDdeclprob(df.format(empMasterData.rs.getDate("DATE_OF_REGULARISATION")));
					}
				} catch (Exception e) {
					Debug.println("Error in ddecl" + e);
				}
				try// if(empMasterData.rs.getDate("ACCTEST_PASS_DATE")!=null)
				{
					empMaster.setDacctest(df.format(empMasterData.rs.getDate("ACCTEST_PASS_DATE")));
				} catch (Exception e) {
					Debug.println("Error in testpass" + e);
				}
				try// if(empMasterData.rs.getDate("UPDATE_DATE")!=null)
				{
					empMaster.setIncrementdate(df.format(empMasterData.rs.getDate("UPDATE_DATE")));
				} catch (Exception e) {
					Debug.println("Error in IncrementDate" + e);
				}

				try// if(empMasterData.rs.getString("QUAL_CODE")!=null)
				{
					empMaster.setQualName(getQualName(empMasterData.rs.getString("QUAL_CODE")));
				} catch (Exception e) {
					Debug.println("Error in Qual" + e);
				}

				// empMaster.setAddqual2(empMasterData.rs.getString("ADD_QUAL_2"));

				try {
					empMaster.setAddqual2(getQualName(empMasterData.rs.getString("ADD_QUAL_2")));
					// Debug.println("Qualification details2");
				} catch (Exception e) {
					Debug.println("Error in  qual2" + e);
				}
				empMaster.setAddqual1(empMasterData.rs.getString("ADD_QUAL_1"));

				try {
					empMaster.setAddqual1(getQualName(empMasterData.rs.getString("ADD_QUAL_1")));
					// Debug.println("Qualification details1");
				} catch (Exception e) {
					Debug.println("qual1" + e);
				}
				try {
					empMaster.setPresentation(empMasterData.rs.getString("PRESENT_STATION_MANDAL"));
				} catch (Exception e) {
					Debug.println("Error in Present" + e);
				}
				// Debug.println("work");
				try {
					empMaster.setWorkSpecial(
							getWorkSpecName(empMasterData.rs.getString("WORK_SPECIALIZATION"), dataSource));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				empMaster.setRelation(empMasterData.rs.getString("FATHER_NAME"));
				// Debug.println("relation details ");
				try {
					empMaster.setNdist(getDistName(empMasterData.rs.getString("NATIVE_DISTRICT")));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				try {
					empMaster.setNmand(getMandalName(empMasterData.rs.getString("NATIVE_DISTRICT"),
							empMasterData.rs.getString("NATIVE_MANDAL")));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				// Debug.println("Ndist,Nmand details ");
				try {
					empMaster.setNarecruit(getRecName(empMasterData.rs.getString("RECRUIT_LOCAL_NONLOCAL")));
				} catch (Exception e) {
					Debug.println("error in Narecruit" + e);
				}
				try {
					empMaster.setDesig(getTempPer(empMasterData.rs.getString("TEMP_PERMNENT")));
				} catch (Exception e) {
					Debug.println("error in Desig" + e);

				}
				try {
					empMaster.setDesgnName(getDesigName(empMasterData.rs.getString("DESIGNATION_CODE")));
					Debug.println("Designation Name  " + empMaster.getDesgnCode());
				} catch (Exception e) {
					Debug.println("error in Designation" + e);
				}

				try {
					empMaster.setMoap(getModeName(empMasterData.rs.getString("MOAP_CODE"), dataSource));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				try {
					empMaster.setApcatog(getCatogName(empMasterData.rs.getString("APCATEG_CODE"), dataSource));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				// empMaster.setZone(empMasterData.rs.getString("ZONE_CODE"));
				try {
					empMaster.setZone(getZoneName(empMasterData.rs.getString("ZONE_CODE"), dataSource));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}
				try {
					empMaster.setGender(getGenderName(empMasterData.rs.getString("SEX")));
				} catch (Exception e) {
					Debug.println("the error in Gender= " + e);
				}
				try {
					empMaster.setNrevenue(empMasterData.rs.getString("NATIVE_REV_DIVISION"));
				} catch (Exception e) {
					Debug.println("the error in nrevenue()= " + e);
				}

				try {
					empMaster.setTestpassed(getYesNo(empMasterData.rs.getString("ACCTEST_PASSED")));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				// Debug.println("Sex acctest");

				try {
					if (empMasterData.rs.getString("DEPUTATION") != null) {
						empMaster.setDeputation(getYesNo(empMasterData.rs.getString("DEPUTATION")));
					}
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				try {

					empMaster.setPanno(empMasterData.rs.getString("PAN_NO"));
					empMaster.setApgli(empMasterData.rs.getString("APGLI_NO"));
					empMaster.setPayscale(empMasterData.rs.getString("PAY_SCALE_PRESENT"));
					empMaster.setOtherDet(empMasterData.rs.getString("OTHER_DETAILS"));
					// empMaster.setDesgnCode(empMasterData.rs.getString("DESIGNATION_CODE"));
					empMaster.setCheckType(empMasterData.rs.getString("TYPE_OF_CHECK"));
					empMaster.setNoOfChecks(empMasterData.rs.getInt("NO_OF_CHECKS"));
					empMaster.setCheckPeriod(empMasterData.rs.getString("CHECK_PERIOD"));
					empMaster.setAppOrderRef(empMasterData.rs.getString("APPOINTMENT_ORDER_REF"));
					// empMaster.setWorkSpecial(empMasterData.rs.getString("WORK_SPECIALIZATION"));
					empMaster.setPostCode(empMasterData.rs.getString("POST_JOINED_DESG_CODE"));
				} catch (Exception e) {
					Debug.println("Error in OtherDetails" + e);
				}

				try {
					if (empMasterData.rs.getString("RELG_CODE") != null) {
						empMaster.setReligion(getReligionName(empMasterData.rs.getString("RELG_CODE"), dataSource));
					}
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				try {
					if (empMasterData.rs.getString("DIST_CLASS_IV") != null) {
						empMaster.setDiststudied4(
								getDistrictName(empMasterData.rs.getString("DIST_CLASS_IV"), dataSource));
					}
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				try {
					if (empMasterData.rs.getString("DIST_CLASS_V") != null) {
						empMaster.setDiststudied5(
								getDistrictName(empMasterData.rs.getString("DIST_CLASS_V"), dataSource));
					}
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				try {
					if (empMasterData.rs.getString("DIST_CLASS_VI") != null) {
						empMaster.setDiststudied6(
								getDistrictName(empMasterData.rs.getString("DIST_CLASS_VI"), dataSource));
					}
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				try {
					if (empMasterData.rs.getString("DIST_CLASS_VII") != null) {
						empMaster.setDiststudied7(
								getDistrictName(empMasterData.rs.getString("DIST_CLASS_VII"), dataSource));
					}
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				try {
					if (empMasterData.rs.getString("DIST_CLASS_VIII") != null) {
						empMaster.setDiststudied8(
								getDistrictName(empMasterData.rs.getString("DIST_CLASS_VIII"), dataSource));
					}
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				try {
					if (empMasterData.rs.getString("DIST_CLASS_IX") != null) {
						empMaster.setDiststudied9(
								getDistrictName(empMasterData.rs.getString("DIST_CLASS_IX"), dataSource));
					}
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				try {
					if (empMasterData.rs.getString("DIST_CLASS_X") != null) {
						empMaster.setDiststudied10(
								getDistrictName(empMasterData.rs.getString("DIST_CLASS_X"), dataSource));
					}
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				try {
					if (empMasterData.rs.getString("LOCAL_DIST_AS_PER_SCH") != null) {
						empMaster.setLocaldist(getDistName(empMasterData.rs.getString("LOCAL_DIST_AS_PER_SCH")));
					}
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				try {
					if (empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_DIST") != null) {
						empMaster.setNoofyrs(empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_DIST"));
					}
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				try {
					if (empMasterData.rs.getString("LOCAL_ZONE") != null) {
						empMaster.setLocalzone(empMasterData.rs.getString("LOCAL_ZONE"));
					}
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				try {
					if (empMasterData.rs.getString("LOCAL_ZONE") != null) {
						empMaster.setLocalzone(getZoneName(empMasterData.rs.getString("LOCAL_ZONE"), dataSource));
					}
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				try {
					if (empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_ZONE") != null) {
						empMaster.setNoofyrs1(empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_ZONE"));
					}
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				try {
					if (empMasterData.rs.getString("PRIVATE_PASSED_DIST") != null) {
						empMaster.setPvtdist(getDistName(empMasterData.rs.getString("PRIVATE_PASSED_DIST")));
					}
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}

				try {
					if (empMasterData.rs.getString("PRIVATE_PASSED_ZONE") != null) {
						empMaster
								.setPvtzone(getZoneName(empMasterData.rs.getString("PRIVATE_PASSED_ZONE"), dataSource));
					}
				} catch (Exception e) {
					Debug.println("the error in Pvtzone getEmps()= " + e);
				}
				try {
					if (empMasterData.rs.getString("DEPT_OPTED") != null) {
						empMaster.setDept(empMasterData.rs.getString("DEPT_OPTED"));
						Debug.println("DEPT OPTED");
					}
				} catch (Exception e) {
					Debug.println("the error in PH= " + e);
				}

				try {
					if (empMasterData.rs.getString("DEPUTATION_DEPT") != null) {
						empMaster.setDeputationDept(empMasterData.rs.getString("DEPUTATION_DEPT"));
					}
				} catch (Exception e) {
					Debug.println("the error in PH= " + e);
				}
				try {
					if (empMasterData.rs.getDate("DEPUTATION_FROM") != null) {
						empMaster.setDeputationDate(df.format(empMasterData.rs.getDate("DEPUTATION_FROM")));
					}
				} catch (Exception e) {
					Debug.println("the error in PH= " + e);
				}

				try {
					if (empMasterData.rs.getString("PH") != null) {
						empMaster.setHandicap(getYesNo(empMasterData.rs.getString("PH")));
					}
				} catch (Exception e) {
					Debug.println("the error in PH= " + e);
				}

				try {
					if (empMasterData.rs.getString("APPOINT_CATEGORY") != null) {
						empMaster.setApptcategory(empMasterData.rs.getString("APPOINT_CATEGORY"));
					}
				} catch (Exception e) {
					Debug.println("the error in PH= " + e);
				}

				try {
					if (empMasterData.rs.getDate("PROMOTION_DT_PRESENT_DESG") != null) {
						empMaster.setPromotedate(df.format(empMasterData.rs.getDate("PROMOTION_DT_PRESENT_DESG")));
					}
				} catch (Exception e) {
					Debug.println("the error in PH= " + e);
				}

				try {
					if (empMasterData.rs.getString("SECTION") != null) {
						empMaster.setSection(empMasterData.rs.getString("SECTION"));
					}
				} catch (Exception e) {
					Debug.println("the error in PH= " + e);
				}

				try {
					if (empMasterData.rs.getString("SENIORITY") != null) {
						empMaster.setSeniority(empMasterData.rs.getString("SENIORITY"));
					}
				} catch (Exception e) {
					Debug.println("the error in PH= " + e);
				}

				try {
					if (empMasterData.rs.getString("DISCIPLINE_CASE") != null) {
						empMaster.setDisciplinecase(getYesNo(empMasterData.rs.getString("DISCIPLINE_CASE")));
					}
				} catch (Exception e) {
					Debug.println("the error in PH= " + e);
				}

				try {
					if (empMasterData.rs.getString("DISCIPLINE_TYPE") != null) {
						empMaster.setDisciplinetype(empMasterData.rs.getString("DISCIPLINE_TYPE"));
					}
				} catch (Exception e) {
					Debug.println("the error in PH= " + e);
				}

				try {

					if (empMasterData.rs.getString("LEAVE_SUSPENDED") != null) {
						empMaster.setLeaveSuspend(getLeaveSus(empMasterData.rs.getString("LEAVE_SUSPENDED")));
					}
				} catch (Exception e) {
					Debug.println("the error in Leave= " + e);
				}

				try {
					if (empMasterData.rs.getDate("DATE_OF_LEAVE") != null) {
						empMaster.setLeavedate(df.format(empMasterData.rs.getDate("DATE_OF_LEAVE")));
					}
				} catch (Exception e) {
					Debug.println("the error in PH= " + e);
				}

				try {

					if (empMasterData.rs.getString("SPOUSE_EMPLOYED") != null) {
						empMaster.setSpouseemployd(getYesNo(empMasterData.rs.getString("SPOUSE_EMPLOYED")));
					}
				} catch (Exception e) {
					Debug.println("error in spouse" + e);
				}

				try {

					if (empMasterData.rs.getString("SPOUSE_CENTRE_STATE") != null) {
						empMaster.setSpouseworking(getWorkingName(empMasterData.rs.getString("SPOUSE_CENTRE_STATE")));
					}
				} catch (Exception e) {
					Debug.println("error in working" + e);
				}

				try {
					if (empMasterData.rs.getString("SPOUSE_DISTRICT_WORK") != null) {
						empMaster.setSpouseworkdist(
								getDistrictName(empMasterData.rs.getString("SPOUSE_DISTRICT_WORK"), dataSource));
					}
				} catch (Exception e) {
					Debug.println("the error in PH= " + e);
				}

				try {
					if (empMasterData.rs.getString("SPOUSE_REV_DIV_WORK") != null) {
						empMaster.setSpouseworkmand(empMasterData.rs.getString("SPOUSE_REV_DIV_WORK"));
					}
				} catch (Exception e) {
					Debug.println("the error in PH= " + e);
				}

				try {
					if (empMasterData.rs.getString("SPOUSE_REV_MANDAL_WORK") != null) {
						empMaster.setSpouseworkdiv(empMasterData.rs.getString("SPOUSE_REV_MANDAL_WORK"));
					}
				} catch (Exception e) {
					Debug.println("the error in PH= " + e);
				}

				// Debug.println("end statement executed");
				emps.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println("The error in getEmps" + e);
		} finally {
			empMasterData.closeAll();
		}
		return emps;
	}

	public static ArrayList getEmps(DataSource dataSource) throws Exception {
		String str;
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;// Form bean
		ArrayList emps = new ArrayList();
		String query = null;
		String officeNames[] = new String[5];
		String hoc1 = null;
		String coc1 = null;
		String doc1 = null;
		String sdoc1 = null;

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			query = "select * from rws_employee_tbl e,rws_employee_spouse_tbl s where e.employee_code=s.employee_code(+) order by e.employee_code ";
			empMasterData.rs = empMasterData.stmt.executeQuery(query);		
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setEmpcode(empMasterData.rs.getString(2));			
				empMaster.setSurname(empMasterData.rs.getString("EMPLOYEE_SURNAME"));
				empMaster.setEmpname(empMasterData.rs.getString("EMPLOYEE_NAME"));			
				empMaster.setRelation(empMasterData.rs.getString("FATHER_NAME"));			
				empMaster.setReligion(empMasterData.rs.getString("RELG_CODE"));
				empMaster.setSocial(empMasterData.rs.getString("CASTE_CODE"));			
				empMaster.setNdist(empMasterData.rs.getString("NATIVE_DISTRICT"));			
				empMaster.setNmand(empMasterData.rs.getString("NATIVE_MANDAL"));			
				if (empMasterData.rs.getString("SEX") != null) {
					empMaster.setGender(empMasterData.rs.getString("SEX"));
				}
				empMaster.setNrevenue(empMasterData.rs.getString("NATIVE_REV_DIVISION"));
				empMaster.setQual(empMasterData.rs.getString("QUAL_CODE"));
				if (empMasterData.rs.getDate("DATE_OF_BIRTH") != null) {
					empMaster.setDob(df.format(empMasterData.rs.getDate("DATE_OF_BIRTH")));
				}
				if (empMasterData.rs.getString("PH") != null) {
					empMaster.setHandicap(empMasterData.rs.getString("PH"));
				}
				if (empMasterData.rs.getString("SPOUSE_EMPLOYED") != null) {
					empMaster.setSpouseemployd(empMasterData.rs.getString("SPOUSE_EMPLOYED"));			
				}
				if (empMasterData.rs.getString("SPOUSE_CENTRE_STATE") != null) {
					empMaster.setSpouseworking(empMasterData.rs.getString("SPOUSE_CENTRE_STATE"));
				}
				if (empMasterData.rs.getString("SPOUSE_DISTRICT_WORK") != null) {
					empMaster.setSpouseworkdist(empMasterData.rs.getString("SPOUSE_DISTRICT_WORK"));			
				}
				if (empMasterData.rs.getString("SPOUSE_REV_DIV_WORK") != null) {
					empMaster.setSpouseworkmand(empMasterData.rs.getString("SPOUSE_REV_DIV_WORK"));			
				}
				if (empMasterData.rs.getString("SPOUSE_REV_MANDAL_WORK") != null) {
					empMaster.setSpouseworkdiv(empMasterData.rs.getString("SPOUSE_REV_MANDAL_WORK"));			
				}			
				if (empMasterData.rs.getString("DIST_CLASS_IV") != null) {
					empMaster.setDiststudied4(empMasterData.rs.getString("DIST_CLASS_IV"));
				}
				try {
					empMaster.setDiststudied4(getDistrictName(empMasterData.rs.getString("DIST_CLASS_IV"), dataSource));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}
				empMaster.setDiststudied5(empMasterData.rs.getString("DIST_CLASS_V"));
				try {
					empMaster.setDiststudied5(getDistrictName(empMasterData.rs.getString("DIST_CLASS_V"), dataSource));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}
				empMaster.setDiststudied6(empMasterData.rs.getString("DIST_CLASS_VI"));
				try {
					empMaster.setDiststudied6(getDistrictName(empMasterData.rs.getString("DIST_CLASS_VI"), dataSource));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}
				empMaster.setDiststudied7(empMasterData.rs.getString("DIST_CLASS_VII"));
				try {
					empMaster.setDiststudied7(
							getDistrictName(empMasterData.rs.getString("DIST_CLASS_VII"), empMasterData.conn));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}
				empMaster.setDiststudied8(empMasterData.rs.getString("DIST_CLASS_VIII"));
				try {
					empMaster.setDiststudied8(
							getDistrictName(empMasterData.rs.getString("DIST_CLASS_VIII"), dataSource));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}
				empMaster.setDiststudied9(empMasterData.rs.getString("DIST_CLASS_IX"));
				try {
					empMaster.setDiststudied9(
							getDistrictName(empMasterData.rs.getString("DIST_CLASS_IX"), empMasterData.conn));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}
				if (empMasterData.rs.getString("DIST_CLASS_X") != null) {
					empMaster.setDiststudied10(empMasterData.rs.getString("DIST_CLASS_X"));
				}
				try {
					empMaster.setDiststudied10(getDistrictName(empMasterData.rs.getString("DIST_CLASS_X"), dataSource));
				} catch (Exception e) {
					Debug.println("the error in getEmps()= " + e);
				}
				if (empMasterData.rs.getString("LOCAL_DIST_AS_PER_SCH") != null) {
					empMaster.setLocaldist(empMasterData.rs.getString("LOCAL_DIST_AS_PER_SCH"));
				}
				if (empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_DIST") != null) {
					empMaster.setNoofyrs(empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_DIST"));
				}
				if (empMasterData.rs.getString("LOCAL_ZONE") != null) {
					empMaster.setLocalzone(empMasterData.rs.getString("LOCAL_ZONE"));
				}
				if (empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_ZONE") != null) {
					empMaster.setNoofyrs1(empMasterData.rs.getString("NOOF_YEARS_STUDIED_IN_ZONE"));
				}
				if (empMasterData.rs.getString("PRIVATE_PASSED_DIST") != null) {
					empMaster.setPvtdist(empMasterData.rs.getString("PRIVATE_PASSED_DIST"));
				}
				if (empMasterData.rs.getString("PRIVATE_PASSED_ZONE") != null) {
					empMaster.setPvtzone(empMasterData.rs.getString("PRIVATE_PASSED_ZONE"));
				}
				if (empMasterData.rs.getString("TEMP_PERMNENT") != null) {
					empMaster.setDesig(empMasterData.rs.getString("TEMP_PERMNENT"));
				}
				if (empMasterData.rs.getString("DESIGNATION_CODE") != null) {
					empMaster.setDesgnCode(empMasterData.rs.getString("DESIGNATION_CODE"));
				}

				if (empMasterData.rs.getString("APPOINT_CATEGORY") != null) {
					empMaster.setApptcategory(empMasterData.rs.getString("APPOINT_CATEGORY"));
					Debug.println("ApptCatergory getEmp" + empMasterData.rs.getString("APPOINT_CATEGORY"));
				}
				if (empMasterData.rs.getDate("APPOINTMENT_DATE") != null) {
					empMaster.setAppointdate(df.format(empMasterData.rs.getDate("APPOINTMENT_DATE")));
				}

				if (empMasterData.rs.getDate("DATE_OF_JOINING") != null) {
					empMaster.setDoj(df.format(empMasterData.rs.getDate("DATE_OF_JOINING")));
				}
				if (empMasterData.rs.getString("RECRUIT_LOCAL_NONLOCAL") != null) {
					empMaster.setNarecruit(empMasterData.rs.getString("RECRUIT_LOCAL_NONLOCAL"));
				}
				if (empMasterData.rs.getString("ZONE_CODE") != null) {
					empMaster.setZone(empMasterData.rs.getString("ZONE_CODE"));
				}
				Debug.println("zone details executed");
				if (empMasterData.rs.getString("APCATEG_CODE") != null) {
					empMaster.setApcatog(empMasterData.rs.getString("APCATEG_CODE"));
				}
				if (empMasterData.rs.getString("MOAP_CODE") != null)
					empMaster.setMoap(empMasterData.rs.getString("MOAP_CODE"));

				if (empMasterData.rs.getDate("DATE_OF_COMMENCE_PROBATION") != null) {
					empMaster.setDcommprob(df.format(empMasterData.rs.getDate("DATE_OF_COMMENCE_PROBATION")));
				}
				if (empMasterData.rs.getDate("DATE_OF_REGULARISATION") != null) {
					empMaster.setDdeclprob(df.format(empMasterData.rs.getDate("DATE_OF_REGULARISATION")));
				}
				if (empMasterData.rs.getDate("CURRENT_POST_HELD_FROM") != null) {
					empMaster.setCurrentpostdate(df.format(empMasterData.rs.getDate("CURRENT_POST_HELD_FROM")));
				}
				if (empMasterData.rs.getDate("PROMOTION_DT_PRESENT_DESG") != null) {
					empMaster.setPromotedate(df.format(empMasterData.rs.getDate("PROMOTION_DT_PRESENT_DESG")));
				}
				if (empMasterData.rs.getString("ACCTEST_PASSED") != null) {
					empMaster.setTestpassed(empMasterData.rs.getString("ACCTEST_PASSED"));
				}
				if (empMasterData.rs.getDate("ACCTEST_PASS_DATE") != null) {
					empMaster.setDacctest(df.format(empMasterData.rs.getDate("ACCTEST_PASS_DATE")));
				}
				if (empMasterData.rs.getString("ADD_QUAL_2") != null)
					empMaster.setAddqual2(empMasterData.rs.getString("ADD_QUAL_2"));
				if (empMasterData.rs.getString("ADD_QUAL_1") != null)
					empMaster.setAddqual1(empMasterData.rs.getString("ADD_QUAL_1"));
				if (empMasterData.rs.getString("PRESENT_DESIG") != null) {
					empMaster.setPresentdesig(empMasterData.rs.getString("PRESENT_DESIG"));
				}
				if (empMasterData.rs.getString("WORK_SPECIALIZATION") != null) {
					empMaster.setWorkSpecial(empMasterData.rs.getString("WORK_SPECIALIZATION"));
				}

				if (empMasterData.rs.getString("OTHER_DETAILS") != null) {
				
					empMaster.setOtherDet(empMasterData.rs.getString("OTHER_DETAILS"));
				}
				if ((empMasterData.rs.getString("OFFICE_CODE")).substring(0, 1) != null) {
			
					empMaster.setHoc((empMasterData.rs.getString("OFFICE_CODE")).substring(0, 1));
				}
				if ((empMasterData.rs.getString("OFFICE_CODE")).substring(1, 3) != null) {
		
					empMaster.setCoc((empMasterData.rs.getString("OFFICE_CODE")).substring(1, 3));
				}
				if ((empMasterData.rs.getString("OFFICE_CODE")).substring(3, 4) != null) {
			
					empMaster.setDoc((empMasterData.rs.getString("OFFICE_CODE")).substring(3, 4));
				}
				if ((empMasterData.rs.getString("OFFICE_CODE")).substring(4, 6) != null) {
			
					empMaster.setSdoc((empMasterData.rs.getString("OFFICE_CODE")).substring(4, 6));
				}
				if (empMasterData.rs.getString("SECTION") != null) {
					empMaster.setSection(empMasterData.rs.getString("SECTION"));
				}
				if (empMasterData.rs.getString("DEPT_OPTED") != null) {
					empMaster.setDept(empMasterData.rs.getString("DEPT_OPTED"));
		
				}
				empMaster.setRoc(empMasterData.rs.getString("OFFICE_CODE"));
			
				empMaster.setDeputation(empMasterData.rs.getString("DEPUTATION"));
				if (empMasterData.rs.getDate("DEPUTATION_FROM") != null) {
					empMaster.setDeputationDate(df.format(empMasterData.rs.getDate("DEPUTATION_FROM")));
			
				} 
				/*
				 * if(empMasterData.rs.getString("DEPUTATION_DEPT")!=null) {
				 * empMaster.setDeputationDept(empMasterData.rs.getString("DEPUTATION_DEPT")); }
				 */
		
				if (empMasterData.rs.getString("DEPUTATION_DEPT") != null) {
					empMaster.setDeputationDept(empMasterData.rs.getString("DEPUTATION_DEPT"));
					
				}
			

				if (empMasterData.rs.getString("SENIORITY") != null) {
					empMaster.setSeniority(empMasterData.rs.getString("SENIORITY"));
				}

				if (empMasterData.rs.getString("DISCIPLINE_CASE") != null) {
					empMaster.setDisciplinecase(empMasterData.rs.getString("DISCIPLINE_CASE"));
				}
				if (empMasterData.rs.getString("DISCIPLINE_TYPE") != null) {
					empMaster.setDisciplinetype(empMasterData.rs.getString("DISCIPLINE_TYPE"));
				
				}
				/*
				 * if(empMasterData.rs.getString("LEAVE_SUSPENDED")!=null) {
				 * empMaster.setLeaveSuspend(empMasterData.rs.getString("LEAVE_SUSPENDED")); }
				 * if(empMasterData.rs.getDate("DATE_OF_LEAVE")!=null) {
				 * empMaster.setLeavedate(df.format(empMasterData.rs.getDate("DATE_OF_LEAVE")));
				 * }
				 */
			
				empMaster.setPanno(empMasterData.rs.getString("PAN_NO"));
				empMaster.setApgli(empMasterData.rs.getString("APGLI_NO"));
				empMaster.setGpfno(empMasterData.rs.getString("GPF_NO"));
				empMaster.setPayscale(empMasterData.rs.getString("PAY_SCALE_PRESENT"));
				if (empMasterData.rs.getDate("UPDATE_DATE") != null) {
					empMaster.setIncrementdate(df.format(empMasterData.rs.getDate("UPDATE_DATE")));
				}
				emps.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println("The error in getEmps " + e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return emps;
	}

	// Code Added for Water quality Test Reports

	public static ArrayList getWQFromDates(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		String query;
		ArrayList fromDate = new ArrayList();
		try {
			// query = "select distinct to_char(access_date,'DD/MM/yy') from rws_log_tbl
			// order by to_char(access_date,'DD/MM/yy') desc";
			query = "select distinct to_char(SAMP_COLLECT_DATE,'dd/mm/yy') as a1 from RWS_WATER_SAMPLE_COLLECT_TBL order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";

			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt.executeQuery(query);
			// Debug.println("from date query is "+query);
			EmpMaster empMaster = null;
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setFromDate(empMasterData.rs.getString(1));
				// Debug.println("the value of FromDate in
				// query"+empMasterData.rs.getString(1));
				fromDate.add(empMaster);
			}
			empMasterData.conn.close();
		} catch (Exception e) {
			Debug.println("Exception in GetDate in EmpMaster :" + e);
		}
		return fromDate;
	}

	public static ArrayList getWQToDates(String fromDate, DataSource dataSource) {
		String query;
		ArrayList toDate = new ArrayList();
		EmpMasterData empMasterData = new EmpMasterData();
		// Debug.println("the value of FromDate in ToDate"+fromDate);
		// Debug.println("started getToDates in EmpMasterData before try");
		try {

			// query = "select distinct to_char(access_date,'DD/MM/yy') from rws_log_tbl
			// where to_date(ACCESS_DATE,'dd/mm/yy') >= to_Date('"
			// + fromDate + "','dd/mm/yy') order by to_char(access_date,'DD/MM/yy') desc";

			query = "select distinct to_char(SAMP_COLLECT_DATE,'dd/mm/yy') as a1 from RWS_WATER_SAMPLE_COLLECT_TBL where SAMP_COLLECT_DATE>=to_Date('"
					+ fromDate + "','dd/mm/yy') order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";

			empMasterData.conn = RwsOffices.getConn();
			// Debug.println("empMasterData.conn" + empMasterData.conn);
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt.executeQuery(query);
			// Debug.println("to Date Query"+query);
			EmpMaster empMaster = null;
			// Debug.println("empMasterData.rs.next() :"+empMasterData.rs.next());

			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setToDate(empMasterData.rs.getString(1));
				toDate.add(empMaster);
			}
			empMasterData.conn.close();
		} catch (Exception e) {
			Debug.println("Exception in getToDates in EmpMasterData :" + e);
		}

		return toDate;
	}

	public static String getHabNames(String hcode, Connection conn) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = conn;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		String name = "";
		String query = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			if (hcode != null) {
				query = "select panch_name from RWS_PANCHAYAT_RAJ_TBL where panch_code='" + hcode + "' ";
				// Debug.println("query of HabName"+query);
				empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
				while (empMasterData.rs1.next()) {
					name = empMasterData.rs1.getString(1);
					// Debug.println("habname"+name);
				}
			}
		} catch (Exception e) {
			Debug.println("There is an error in getHabNames=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	// code added for Emp Form View part
	public static String getReligionName(String code) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = RwsOffices.getConn();
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		String query = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			if (code != null) {
				query = "SELECT RELG_NAME FROM RWS_RELEGION_MST_TBL WHERE RELG_CODE ='" + code + "' ";
				empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
				// Debug.println("query in religion"+query);
				while (empMasterData.rs1.next()) {
					name = empMasterData.rs1.getString(1);
				}
			}
		} catch (Exception e) {
			Debug.println("Ther error in getReligionName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	// same code with dataSource
	public static String getReligionName(String code, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		// connCount--;
		empMasterData.conn = RwsOffices.getConn();
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		String query = null;
		try {
			// Debug.println("in getReligionName");
			// Debug.println("ConnCount is "+connCount);
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			if (code != null) {
				query = "SELECT RELG_NAME FROM RWS_RELEGION_MST_TBL WHERE RELG_CODE ='" + code + "' ";
				empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
				// Debug.println("query in religion"+query);
				while (empMasterData.rs1.next()) {
					name = empMasterData.rs1.getString(1);
				}
			}
		} catch (Exception e) {
			Debug.println("Ther error in getReligionName=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return name;
	}

	public static String getDesigName(String code) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();		
		String name = null;		
		try {
			empMasterData.conn = RwsOffices.getConn();					
			if (code != null) {
				empMasterData.pstmt1 = empMasterData.conn.prepareStatement("SELECT DESIGNATION_NAME FROM RWS_DESIGNATION_TBL WHERE DESIGNATION_CODE =? ");
				empMasterData.pstmt1.setString(1, code);
				empMasterData.rs1 = empMasterData.pstmt1.executeQuery();
				while (empMasterData.rs1.next()) {
					name = empMasterData.rs1.getString(1);
				}
			}
		} catch (Exception e) {
			Debug.println(" error in getDesigName in EmpMasterData " + e);
		} finally {
			empMasterData.pstmt1.close();
			empMasterData.rs1.close();
		}
		return name;
	}

	// same code with data source
	/*
	 * public static String getDesigName(String code,DataSource dataSource ) throws
	 * Exception { EmpMasterData empMasterData=new EmpMasterData();
	 * empMasterData.conn=RwsOffices.getConn(); String name = null;
	 * empMasterData.stmt1 = null; empMasterData.rs1 = null; String query=null; try
	 * { //Debug.println("in getDesigName");
	 * //Debug.println("ConnCount is "+connCount); empMasterData.stmt1 =
	 * empMasterData.conn.createStatement(); if (code != null) {
	 * query="SELECT DESIGNATION_NAME FROM RWS_DESIGNATION_TBL WHERE DESIGNATION_CODE ='"
	 * +code+"' "; empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
	 * //Debug.println("query in DESIGNATION "+query);
	 * while(empMasterData.rs1.next()) { name = empMasterData.rs1.getString(1); } }
	 * }catch (Exception e) { Debug.println(" error in getDesigName=" + e); }
	 * finally { empMasterData.closeAll(); } return name; }
	 */
	public static String getWorkName(String skillCode, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster EmpMaster = null;
		String name = null;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();

			if (skillCode != null) {
				String query = "select SKILL_DESCRIPTION  from RWS_SPEC_SKILL_TBL where SKILL_CODE ='" + skillCode
						+ "' ";
				empMasterData.rs = empMasterData.stmt.executeQuery(query);
				// Debug.println("query WORK SPECS Name"+query);
				if (empMasterData.rs.next()) {
					name = empMasterData.rs.getString(1);
				}
			}
		} catch (Exception e) {
			Debug.println("The error in getWorkSpec" + e);
		} finally {
			empMasterData.closeAll();
		}
		return name;
	}

	public int Connection(DataSource dataSource) {
		try {
			conn = null;
			if (conn == null)
				conn = RwsOffices.getConn();
		} catch (Exception e) {
			Debug.println(e.getMessage());
		}
		return 1;
	}

	// code added by sridhar for getting desg of temp/permeant
	public static ArrayList getDesgns1(String desig, String coc) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList desgns = new ArrayList();

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();

			// query="select * from rws_designation_tbl" ;
			// query+=" where temp_permnent='"+desig+"'";
			// query+=" order by designation_name";
			String query = "select distinct d.designation_code,d.designation_acr,d.designation_name from rws_designation_tbl d,rws_employee_tbl e where d.designation_code=e.designation_code and e.temp_permnent='"
					+ desig + "'";
			if (coc != null && !coc.equals("") && !coc.equals("00")) {
				query += " and substr(office_code,2,2)='" + coc + "' ";
			}
			query += " order by designation_name ";
			empMasterData.rs = empMasterData.stmt.executeQuery(query);
			//Debug.println("getDesgns query " + query);
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setDesgnCode(empMasterData.rs.getString(1));
				empMaster.setDesgnAcr(empMasterData.rs.getString(2));
				empMaster.setDesgnName(empMasterData.rs.getString(3));
				desgns.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println("The error in getDesgns=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return desgns;
	}

	// code Added by sridhar designation in EmpEntry

	public static ArrayList getDesgns(String desig) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList desgns = new ArrayList();

		try {	
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.pstmt = empMasterData.conn.prepareStatement( "select distinct designation_code,designation_acr,designation_name from rws_designation_tbl where temp_permnent=? order by 1");
			empMasterData.pstmt.setString(1, desig);
			empMasterData.rs = empMasterData.pstmt.executeQuery();
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setDesgnCode(empMasterData.rs.getString(1));
				empMaster.setDesgnAcr(empMasterData.rs.getString(2));
				empMaster.setDesgnName(empMasterData.rs.getString(3));
				desgns.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println("The error in getDesgns in EmpMasterData " + e);
		} finally {
			empMasterData.closeAll();
			//Debug.println("ConnCount after closing is " + connCount);
		}
		return desgns;
	}

	// end of code added

	public static String removeEmp(String empcode, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rcount[] = null;
		boolean inserted = true;
		String var1 = "";
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			String query = " delete from rws_employee_spouse_tbl where employee_code='" + empcode + "' ";
			empMasterData.stmt.addBatch(query);
			query = "delete  from rws_employee_tbl where employee_code='" + empcode + "' ";
			empMasterData.stmt.addBatch(query);
			rcount = empMasterData.stmt.executeBatch();
			//Debug.println("rcount:" + rcount.length);
			for (int j = 0; j < rcount.length; j++) {
				if (rcount[j] == 0)
					inserted = false;
			}

			if (inserted) {
				var1 = "Record Deleted successfully";
				empMasterData.conn.commit();
			} else {
				var1 = "Record Cannot be Deleted";
			}
			empMasterData.conn.setAutoCommit(true);
		} catch (Exception e) {
			var1 = "Employee Have Voucher details,You cant not Deleted ";
			Debug.println("The error in removeEmp");
		} finally {
			empMasterData.closeAll();
		}
		return var1;
	}

	public static String updateEmp(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		String query = "";
		int rowCount[] = null;
		boolean inserted = true;
		String var1;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.conn.setAutoCommit(false);
			empMasterData.stmt = empMasterData.conn.createStatement();
			String accounttest = empMaster.getTestPassed();
			java.util.Date d = new java.util.Date();			
			query = " update rws_employee_tbl set EMPLOYEE_SURNAME='" + empMaster.getSurname().toUpperCase()
					+ "',EMPLOYEE_NAME='" + empMaster.getEmpname().toUpperCase() + "',SEX='"
					+ format(empMaster.getGender()) + "',FATHER_NAME='" + empMaster.getRelation()
					+ "',DATE_OF_BIRTH=TO_DATE('" + empMaster.getDob() + "','dd/mm/yyyy'),RELG_CODE='"
					+ empMaster.getReligion() + "',CASTE_CODE='" + empMaster.getSocial() + "',NATIVE_DISTRICT='"
					+ empMaster.getNdist() + "',NATIVE_MANDAL='" + format(empMaster.getNmand()) + "',"
					+ "NATIVE_REV_DIVISION='" + empMaster.getNrevenue().toUpperCase() + "',QUAL_CODE='"
					+ format(empMaster.getQual()) + "',PH='" + format(empMaster.getHandicap()) + "',DIST_CLASS_IV='"
					+ empMaster.getDiststudied4() + "',DIST_CLASS_V='" + empMaster.getDiststudied5()
					+ "',DIST_CLASS_VI='" + empMaster.getDiststudied6() + "',DIST_CLASS_VII='"
					+ empMaster.getDiststudied7() + "',DIST_CLASS_VIII='" + empMaster.getDiststudied8()
					+ "',DIST_CLASS_IX='" + empMaster.getDiststudied9() + "',DIST_CLASS_X='"
					+ empMaster.getDiststudied10() + "',LOCAL_DIST_AS_PER_SCH='" + empMaster.getLocaldist() + "',"
					+ "LOCAL_ZONE='" + empMaster.getLocalzone() + "',NOOF_YEARS_STUDIED_IN_DIST='"
					+ empMaster.getNoofyrs() + "',NOOF_YEARS_STUDIED_IN_ZONE='" + empMaster.getNoofyrs1()
					+ "',PRIVATE_PASSED_DIST='" + empMaster.getPvtdist() + "',PRIVATE_PASSED_ZONE='"
					+ empMaster.getPvtzone() + "',TEMP_PERMNENT='" + empMaster.getDesig() + "',DESIGNATION_CODE='"
					+ empMaster.getDesgnCode() + "',APPOINT_CATEGORY='" + empMaster.getApptcategory() + "',"
					+ "APPOINTMENT_DATE=TO_DATE('" + empMaster.getAppointdate()
					+ "','dd/mm/yyyy'),DATE_OF_JOINING=TO_DATE('" + empMaster.getDoj() + "','dd/mm/yyyy'),MOAP_CODE='"
					+ empMaster.getMoap() + "',ZONE_CODE='" + empMaster.getZone() + "',RECRUIT_LOCAL_NONLOCAL='"
					+ empMaster.getNarecruit() + "',APCATEG_CODE='" + empMaster.getApcatog()
					+ "',DATE_OF_COMMENCE_PROBATION=TO_DATE('" + empMaster.getDcommprob()
					+ "','dd/mm/yyyy'),DATE_OF_REGULARISATION=TO_DATE('" + empMaster.getDdeclprob()
					+ "','dd/mm/yyyy'),CURRENT_POST_HELD_FROM=TO_DATE('" + empMaster.getCurrentpostdate()
					+ "','dd/mm/yyyy')," + "PROMOTION_DT_PRESENT_DESG=TO_DATE('" + empMaster.getPromotedate()
					+ "','dd/mm/yyyy'),ACCTEST_PASSED='" + format(empMaster.getTestPassed())
					+ "',ACCTEST_PASS_DATE=TO_DATE('" + empMaster.getDacctest() + "','dd/mm/yyyy'),ADD_QUAL_1='"
					+ empMaster.getAddqual1() + "',ADD_QUAL_2='" + empMaster.getAddqual2() + "',PRESENT_DESIG='"
					+ empMaster.getPresentdesig() + "',WORK_SPECIALIZATION='" + empMaster.getWorkSpecial()
					+ "',OTHER_DETAILS='" + empMaster.getOtherDet() + "',OFFICE_CODE='" + empMaster.getRoc()
					+ "',SECTION='" + empMaster.getSection() + "',DEPT_OPTED='" + empMaster.getDept() + "',"
					+ "SECTOR='" + empMaster.getHoc() + "',DEPUTATION='" + format(empMaster.getDeputation())
					+ "',DEPUTATION_FROM=TO_DATE('" + empMaster.getDeputationDate() + "','dd/mm/yyyy'),SENIORITY='"
					+ empMaster.getSeniority() + "',DISCIPLINE_CASE='" + empMaster.getDisciplinecase()
					+ "',DISCIPLINE_TYPE='" + empMaster.getDisciplinetype() + "',PAN_NO='" + empMaster.getPanno()
					+ "',APGLI_NO='" + empMaster.getApgli() + "',GPF_NO='" + empMaster.getGpfno()
					+ "',PRESENT_PAY_SCALE= '" + empMaster.getPayscale() + "',INCREMENT_DATE=TO_DATE('"
					+ empMaster.getIncrementdate() + "','dd/mm/yyyy'),UPDATE_DATE=TO_DATE('" + empMaster.getUpdatedate()
					+ "','dd/mm/yyyy'),DEPUTATION_DEPT='" + empMaster.getDepudept() + "',DATE_OF_LEAVE=TO_DATE('"
					+ empMaster.getLeavedate() + "','dd/mm/yyyy'),LEAVE_SUSPENDED='"
					+ format(empMaster.getLeavesuspend()) + "' where employee_code='" + empMaster.getEmpcode() + "' ";

			empMasterData.stmt.addBatch(query);
			d = new java.util.Date();
			
			// if(empMaster.getSpouseemployd()!=null &&
			// !empMaster.getSpouseemployd().equals("")){
			query = "update rws_employee_spouse_tbl set SPOUSE_EMPLOYED='" + empMaster.getSpouseemployd()
					+ "',SPOUSE_CENTRE_STATE='" + empMaster.getSpouseworking() + "',SPOUSE_DISTRICT_WORK='"
					+ empMaster.getSpouseworkdist() + "'," + "SPOUSE_REV_DIV_WORK='" + empMaster.getSpouseworkdiv()
					+ "',SPOUSE_REV_MANDAL_WORK='" + empMaster.getSpouseworkmand() + "' where EMPLOYEE_CODE='"
					+ empMaster.getEmpcode() + "' ";
		
			empMasterData.stmt.addBatch(query);
			// }
			d = new java.util.Date();
		
			rowCount = empMasterData.stmt.executeBatch();
			d = new java.util.Date();
		
			if (rowCount.length > 0) {
				var1 = "Record Updated successfully";
				empMasterData.conn.setAutoCommit(true);
				empMasterData.conn.commit();
			} else {
				var1 = "Record Cannot be Updated";
			}

		} catch (Exception e) {
			Debug.println("The error in updateEmp " + e.getMessage());
			empMasterData.conn.rollback();
			var1 = " Record Not Updated";
		} finally {
			empMasterData.closeAll();
		}
		return var1;
	}

	// ******************************************EmpWork
	// Methods*********************************s
	public static ArrayList getEmpCodes(String hoc, String coc, String doc, String sdoc, DataSource dataSource)
			throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList empcodes = new ArrayList();

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt
					.executeQuery("SELECT * FROM RWS_EMPLOYEE_TBL WHERE (SUBSTR(OFFICE_CODE, 1, 1) = " + hoc
							+ ") AND (SUBSTR(OFFICE_CODE, 2, 2) = '" + coc + "') AND (SUBSTR(OFFICE_CODE, 4, 1) = "
							+ doc + ") AND (SUBSTR(OFFICE_CODE, 5, 2) = '" + sdoc + "')");

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
			Debug.println("The error in getEmpCodes=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empcodes;
	}

	// *********************************Head Office
	// Methods*****************************
	public static int insertHead(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rowCount = empMasterData.stmt.executeUpdate("insert into rws_head_office_tbl values('" + empMaster.getHoc()
					+ "','" + empMaster.getHon().toUpperCase() + "')");
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			Debug.println("The error in insertHead" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	/*
	 * public static String getHeadName(String hoc) throws Exception { EmpMasterData
	 * empMasterData=new EmpMasterData(); empMasterData.conn=RwsOffices.getConn();
	 * String name = null; empMasterData.stmt1 = null; empMasterData.rs1 = null; try
	 * { empMasterData.stmt1 = empMasterData.conn.createStatement(); if (hoc!= null)
	 * { String
	 * query="SELECT Head_office_name FROM RWS_HEAD_OFFICE_TBL where HEAD_OFFICE_CODE='"
	 * +hoc+"'"; //Debug.println("query is "+query); empMasterData.rs1 =
	 * empMasterData.stmt1.executeQuery(query); while(empMasterData.rs1.next()) {
	 * name = empMasterData.rs1.getString(1); //Debug.println("Head Name"+name); } }
	 * } catch (Exception e) { Debug.println("Ther error in getHeadName() =" + e); }
	 * finally { empMasterData.stmt1.close();
	 * 
	 * 
	 * } return name; }
	 */

	// same with dataSource
	public static String getHeadName(String hoc) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = RwsOffices.getConn();
		String name = null;
		empMasterData.pstmt1 = null;
		empMasterData.rs1 = null;
		try {
			
			if (hoc != null) {
				empMasterData.pstmt1 = empMasterData.conn.prepareStatement("SELECT Head_office_name FROM RWS_HEAD_OFFICE_TBL where HEAD_OFFICE_CODE=?");
				empMasterData.pstmt1.setString(1, hoc);
				empMasterData.rs1 = empMasterData.pstmt1.executeQuery();
				while (empMasterData.rs1.next()) {
					name = empMasterData.rs1.getString(1);					
				}
			}
		} catch (Exception e) {
			Debug.println("Ther error in getHeadName  in EmpMasterData " + e);
		} finally {
			empMasterData.closeAll();
		}
		return name;
	}

	public static EmpMaster getHead(String hoc, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt
					.executeQuery("select * from rws_head_office_tbl where Head_office_code=" + hoc);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setHoc(empMasterData.rs.getString(1));
				empMaster.setHon(empMasterData.rs.getString(2));
			}
		} catch (Exception e) {
			Debug.println("The error in getHead" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static int removeHead(String hoc, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rowCount = empMasterData.stmt
					.executeUpdate("delete  from rws_head_office_tbl where Head_office_code=" + hoc);
		} catch (Exception e) {
			Debug.println("The error in removeHead=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static int updateHead(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int ans = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();

			empMasterData.stmt = empMasterData.conn.createStatement();
			ans = empMasterData.stmt.executeUpdate("update rws_head_office_tbl set head_office_name='"
					+ empMaster.getHon().toUpperCase() + "' where head_office_code='" + empMaster.getHoc() + "'");
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			// Debug.println("The error in updateHead " + sqle);
		} catch (Exception e) {
			Debug.println("The error in updateHead " + e);
		} finally {
			empMasterData.closeAll();
		}
		return ans;
	}

	public static String getHeadCode(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		String code = "";
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt
					.executeQuery("SELECT MAX(to_number(HEAD_OFFICE_CODE))+1 FROM RWS_HEAD_OFFICE_TBL");
			empMasterData.rs.next();
			code = empMasterData.rs.getString(1);
			if (code == null)
				code = "1";
		} catch (Exception e) {
			Debug.println("The error in getHeadCode" + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	// ********************************Circle Office
	// Methods***********************************
	public static int insertCircle(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rowCount = empMasterData.stmt
					.executeUpdate("insert into rws_circle_office_tbl values('" + empMaster.getHoc() + "','"
							+ empMaster.getCoc() + "','" + empMaster.getCon().toUpperCase() + "')");
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			Debug.println("The error in insertCircle" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getCircle(String hoc, String coc, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt
					.executeQuery("select * from rws_circle_office_tbl where circle_office_code='" + coc
							+ "' and head_office_code=" + hoc);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setHoc(empMasterData.rs.getString(1));
				empMaster.setHon(getHeadOfficeName(empMasterData.rs.getString(1), empMasterData.conn));
				empMaster.setCoc(empMasterData.rs.getString(2));
				empMaster.setCon(empMasterData.rs.getString(3));
			}
		} catch (Exception e) {
			Debug.println("The error in getCircle" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static int removeCircle(String hoc, String coc, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rowCount = empMasterData.stmt.executeUpdate("delete  from rws_circle_office_tbl where circle_office_code='"
					+ coc + "' and head_office_code=" + hoc);
		} catch (Exception e) {
			Debug.println("The error in removeCircle" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static int updateCircle(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int ans = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();

			ps = empMasterData.conn.prepareStatement(
					"UPDATE  RWS_CIRCLE_OFFICE_TBL SET CIRCLE_OFFICE_NAME=? WHERE CIRCLE_OFFICE_CODE=? AND HEAD_OFFICE_CODE=?");
			ps.setString(1, empMaster.getCon().toUpperCase());
			ps.setString(2, empMaster.getCoc());
			ps.setString(3, empMaster.getHoc());

			ans = ps.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			Debug.println("The error in updateCircle " + sqle);
		} catch (Exception e) {
			Debug.println("The error in updateCircle " + e);
		} finally {
			empMasterData.closeAll();
		}
		return ans;
	}

	public static String getCircleCode(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		String code = "";
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt
					.executeQuery("SELECT MAX(to_number(CIRCLE_OFFICE_CODE))+1 FROM RWS_CIRCLE_OFFICE_TBL");
			empMasterData.rs.next();
			code = empMasterData.rs.getString(1);
			if (code == null)
				code = "01";
		} catch (Exception e) {
			Debug.println("The error in getCircleCode" + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	// ****************************************Division Office
	// Methods*********************************
	public static int insertDivision(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rowCount = empMasterData.stmt.executeUpdate(
					"insert into rws_division_office_tbl values('" + empMaster.getHoc() + "','" + empMaster.getCoc()
							+ "','" + empMaster.getDoc() + "','" + empMaster.getDon().toUpperCase() + "')");
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			Debug.println("The error in insertDivision" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getDivision(String hoc, String coc, String doc, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt
					.executeQuery("select * from rws_division_office_tbl where division_office_code=" + doc
							+ "and circle_office_code='" + coc + "' and head_office_code=" + hoc);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setHoc(empMasterData.rs.getString(1));
				empMaster.setHon(getHeadOfficeName(empMasterData.rs.getString(1), empMasterData.conn));
				empMaster.setCoc(empMasterData.rs.getString(2));
				empMaster.setCon(getCircleOfficeName(empMasterData.rs.getString(1), empMasterData.rs.getString(2),
						empMasterData.conn));
				empMaster.setDoc(empMasterData.rs.getString(3));
				empMaster.setDon(empMasterData.rs.getString(4));
			}
		} catch (Exception e) {
			Debug.println("The error in getDivision" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getDivisions(DataSource dataSource, String coc) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList divisions = new ArrayList();
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			// Statement stmt1 = empMasterData.conn.createStatement();
			// Statement stmt2 = empMasterData.conn.createStatement();
			// Debug.println("in the getDivision()");
			if (coc.equals("00"))
				empMasterData.rs = empMasterData.stmt.executeQuery(
						"SELECT D.HEAD_OFFICE_CODE,H.HEAD_OFFICE_NAME,D.CIRCLE_OFFICE_CODE,C.CIRCLE_OFFICE_NAME,D.DIVISION_OFFICE_CODE,D.DIVISION_OFFICE_NAME FROM RWS_DIVISION_OFFICE_TBL D,RWS_CIRCLE_OFFICE_TBL C,RWS_HEAD_OFFICE_TBL H WHERE D.HEAD_OFFICE_CODE=H.HEAD_OFFICE_CODE AND D.CIRCLE_OFFICE_CODE=C.CIRCLE_OFFICE_CODE ORDER BY HEAD_OFFICE_CODE,CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE");
			else
				// Debug.println("in the else block of getDivision()");
				empMasterData.rs = empMasterData.stmt.executeQuery(
						"SELECT D.HEAD_OFFICE_CODE,H.HEAD_OFFICE_NAME,D.CIRCLE_OFFICE_CODE,C.CIRCLE_OFFICE_NAME,D.DIVISION_OFFICE_CODE,D.DIVISION_OFFICE_NAME FROM RWS_DIVISION_OFFICE_TBL D,RWS_CIRCLE_OFFICE_TBL C,RWS_HEAD_OFFICE_TBL H WHERE D.HEAD_OFFICE_CODE=H.HEAD_OFFICE_CODE AND D.CIRCLE_OFFICE_CODE='"
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
				// Debug.println("end statement of getDivision()");
			}
		} catch (Exception e) {
			Debug.println("The error in getDivisions" + e);
		} finally {
			empMasterData.closeAll();
		}
		return divisions;
	}

	public static int removeDivision(String hoc, String coc, String doc, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rowCount = empMasterData.stmt
					.executeUpdate("delete  from rws_division_office_tbl where division_office_code=" + doc
							+ " and circle_office_code='" + coc + "' and head_office_code=" + hoc);
		} catch (Exception e) {
			Debug.println("The error in removeDivision" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static int updateDivision(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int ans = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();

			ps = empMasterData.conn.prepareStatement(
					"update  rws_division_office_tbl set division_office_name=? where division_office_code=? and circle_office_code=? and head_office_code=?");

			ps.setString(1, (empMaster.getDon()).toUpperCase());
			ps.setString(2, empMaster.getDoc());
			ps.setString(3, empMaster.getCoc());
			ps.setString(4, empMaster.getHoc());

			ans = ps.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			Debug.println("The error in updateDivision " + sqle);
		} catch (Exception e) {
			Debug.println("The error in updateDivision" + e);
		} finally {
			empMasterData.closeAll();
		}
		return ans;
	}

	public static String getDivisionCode(String hoc, String coc, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		String code = "";
		if (coc != null) {
			try {
				empMasterData.conn = RwsOffices.getConn();
				empMasterData.stmt = empMasterData.conn.createStatement();
				empMasterData.rs = empMasterData.stmt.executeQuery(
						"SELECT MAX(to_number(DIVISION_OFFICE_CODE))+1 FROM RWS_DIVISION_OFFICE_TBL WHERE CIRCLE_OFFICE_CODE='"
								+ coc + "' and HEAD_OFFICE_CODE=" + hoc);
				empMasterData.rs.next();
				code = empMasterData.rs.getString(1);
				if (code == null)
					code = "1";
			} catch (Exception e) {
				Debug.println("The error in getDivisionCode" + e);
			} finally {
				empMasterData.closeAll();
			}
		}
		return code;
	}

	// *********************************SubDivision
	// OfficeMethods*************************************
	public static int insertSubDivision(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rowCount = empMasterData.stmt.executeUpdate("insert into rws_subdivision_office_tbl values('"
					+ empMaster.getHoc() + "','" + empMaster.getCoc() + "','" + empMaster.getDoc() + "','"
					+ empMaster.getSdoc() + "','" + empMaster.getSdon().toUpperCase() + "')");
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			Debug.println("The error in insertSubDivision" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getSubDivision(String hoc, String coc, String doc, String sdoc, DataSource dataSource)
			throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt
					.executeQuery("select * from rws_subdivision_office_tbl where subdivision_office_code='" + sdoc
							+ "' and division_office_code=" + doc + " and circle_office_code='" + coc
							+ "' and head_office_code=" + hoc);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setHoc(empMasterData.rs.getString(1));
				empMaster.setHon(getHeadOfficeName(empMasterData.rs.getString(1), empMasterData.conn));
				empMaster.setCoc(empMasterData.rs.getString(2));
				empMaster.setCon(getCircleOfficeName(empMasterData.rs.getString(1), empMasterData.rs.getString(2),
						empMasterData.conn));
				empMaster.setDoc(empMasterData.rs.getString(3));
				empMaster.setDon(getDivisionOfficeName(empMasterData.rs.getString(1), empMasterData.rs.getString(2),
						empMasterData.rs.getString(3), empMasterData.conn));
				empMaster.setSdoc(empMasterData.rs.getString(4));
				empMaster.setSdon(empMasterData.rs.getString(5));
			}
		} catch (Exception e) {
			Debug.println("The error in getSubDivision" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getSubDivisions(DataSource dataSource, String coc, String doc) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList subdivisions = new ArrayList();
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			if (coc.equals("00") && doc.equals("0"))
				empMasterData.rs = empMasterData.stmt.executeQuery(
						"SELECT S.HEAD_OFFICE_CODE,H.HEAD_OFFICE_NAME,S.CIRCLE_OFFICE_CODE,C.CIRCLE_OFFICE_NAME,S.DIVISION_OFFICE_CODE,D.DIVISION_OFFICE_NAME,S.SUBDIVISION_OFFICE_CODE,S.SUBDIVISION_OFFICE_NAME FROM RWS_SUBDIVISION_OFFICE_TBL S,RWS_DIVISION_OFFICE_TBL D,RWS_CIRCLE_OFFICE_TBL C,RWS_HEAD_OFFICE_TBL H WHERE  S.HEAD_OFFICE_CODE=H.HEAD_OFFICE_CODE AND D.CIRCLE_OFFICE_CODE=C.CIRCLE_OFFICE_CODE AND S.CIRCLE_OFFICE_CODE=C.CIRCLE_OFFICE_CODE AND S.DIVISION_OFFICE_CODE=D.DIVISION_OFFICE_CODE ORDER BY HEAD_OFFICE_CODE,CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE ");
			else if (!coc.equals("00") && doc.equals("0"))
				empMasterData.rs = empMasterData.stmt.executeQuery(
						"SELECT S.HEAD_OFFICE_CODE,H.HEAD_OFFICE_NAME,S.CIRCLE_OFFICE_CODE,C.CIRCLE_OFFICE_NAME,S.DIVISION_OFFICE_CODE,D.DIVISION_OFFICE_NAME,S.SUBDIVISION_OFFICE_CODE,S.SUBDIVISION_OFFICE_NAME FROM RWS_SUBDIVISION_OFFICE_TBL S,RWS_DIVISION_OFFICE_TBL D,RWS_CIRCLE_OFFICE_TBL C,RWS_HEAD_OFFICE_TBL H WHERE S.CIRCLE_OFFICE_CODE='"
								+ coc + "' and S.HEAD_OFFICE_CODE=H.HEAD_OFFICE_CODE AND D.CIRCLE_OFFICE_CODE='" + coc
								+ "' and D.CIRCLE_OFFICE_CODE=C.CIRCLE_OFFICE_CODE AND S.CIRCLE_OFFICE_CODE=C.CIRCLE_OFFICE_CODE AND S.DIVISION_OFFICE_CODE=D.DIVISION_OFFICE_CODE ORDER BY HEAD_OFFICE_CODE,CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE ");
			else if (!coc.equals("00") && !doc.equals("0"))
				empMasterData.rs = empMasterData.stmt.executeQuery(
						"SELECT S.HEAD_OFFICE_CODE,H.HEAD_OFFICE_NAME,S.CIRCLE_OFFICE_CODE,C.CIRCLE_OFFICE_NAME,S.DIVISION_OFFICE_CODE,D.DIVISION_OFFICE_NAME,S.SUBDIVISION_OFFICE_CODE,S.SUBDIVISION_OFFICE_NAME FROM RWS_SUBDIVISION_OFFICE_TBL S,RWS_DIVISION_OFFICE_TBL D,RWS_CIRCLE_OFFICE_TBL C,RWS_HEAD_OFFICE_TBL H WHERE S.CIRCLE_OFFICE_CODE='"
								+ coc + "' and S.DIVISION_OFFICE_CODE='" + doc
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
				empMaster.setNoOfMandals(getNoOfMandals(empMasterData.rs.getString(3), empMasterData.rs.getString(5),
						empMasterData.rs.getString(7), empMasterData.conn));
				subdivisions.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println("The error in getSubDivisions" + e);
		} finally {
			empMasterData.closeAll();
		}
		return subdivisions;
	}

	public static String getNoOfMandals(String coc, String doc, String sdoc, Connection conn) {

		String mcount = "0";
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = conn;
		try {

			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1.executeQuery(
					"SELECT count(MCODE) from RWS_MANDAL_SUBDIVISION_TBL  WHERE CIRCLE_OFFICE_CODE='" + coc
							+ "' and DIVISION_OFFICE_CODE='" + doc + "' and SUBDIVISION_OFFICE_CODE='" + sdoc + "'");
			empMasterData.rs1.next();
			mcount = "" + empMasterData.rs1.getInt(1);
		} catch (Exception e) {
			Debug.println("The error in getNoOfMandals" + e);
		} finally {
			try {
				empMasterData.stmt1.close();
			} catch (Exception e) {
				Debug.println("Exception" + e);
			}
		}
		return mcount;
	}

	public static ArrayList getMandalSubDivisions(DataSource dataSource, String coc, String doc, String sdoc)
			throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList mandalsubdivisions = new ArrayList();
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();

			empMasterData.rs = empMasterData.stmt.executeQuery(
					"SELECT M.MCODE,M.MNAME FROM RWS_SUBDIVISION_OFFICE_TBL SDO,RWS_MANDAL_TBL M,RWS_MANDAL_SUBDIVISION_TBL MS WHERE MS.CIRCLE_OFFICE_CODE='"
							+ coc + "'AND MS.DIVISION_OFFICE_CODE='" + doc + "' AND SDO.SUBDIVISION_OFFICE_CODE='"
							+ sdoc + "'" + " AND MS.SUBDIVISION_OFFICE_CODE='" + sdoc + "' AND SDO.CIRCLE_OFFICE_CODE='"
							+ coc + "' AND SDO.DIVISION_OFFICE_CODE='" + doc
							+ "' and M.DCODE=MS.DCODE and M.MCODE=MS.MCODE");

			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setMandalCode(empMasterData.rs.getString(1));
				empMaster.setMandalName(empMasterData.rs.getString(2));
				mandalsubdivisions.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println("The error in getMandalSubDivisions" + e);
		} finally {
			empMasterData.closeAll();
		}
		return mandalsubdivisions;
	}

	public static int removeSubDivision(String hoc, String coc, String doc, String sdoc, DataSource dataSource)
			throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rowCount = empMasterData.stmt
					.executeUpdate("delete  from rws_subdivision_office_tbl where subdivision_office_code='" + sdoc
							+ "' and division_office_code=" + doc + " and circle_office_code='" + coc
							+ "' and head_office_code=" + hoc);
		} catch (Exception e) {
			Debug.println("The error in removeSubDivision" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static int updateSubDivision(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int ans = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();

			ps = empMasterData.conn.prepareStatement(
					"UPDATE  RWS_SUBDIVISION_OFFICE_TBL SET SUBDIVISION_OFFICE_NAME=? WHERE SUBDIVISION_OFFICE_CODE=? AND DIVISION_OFFICE_CODE=? AND CIRCLE_OFFICE_CODE=? AND HEAD_OFFICE_CODE=?");

			ps.setString(1, (empMaster.getSdon()).toUpperCase());
			ps.setString(2, empMaster.getSdoc());
			ps.setString(3, empMaster.getDoc());
			ps.setString(4, empMaster.getCoc());
			ps.setString(5, empMaster.getHoc());

			ans = ps.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			Debug.println("The error in updateDivision " + sqle);
		} catch (Exception e) {
			Debug.println("The error in updateSubDivision" + e);
		} finally {
			empMasterData.closeAll();
		}

		return ans;
	}

	public static String getSubDivisionCode(String hoc, String coc, String doc, DataSource dataSource)
			throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		String code = "";
		if (coc != null) {
			try {
				// Debug.println("hoc= " + hoc + "coc= " + coc + " doc= " + doc);
				empMasterData.conn = RwsOffices.getConn();
				empMasterData.stmt = empMasterData.conn.createStatement();
				empMasterData.rs = empMasterData.stmt.executeQuery(
						"SELECT MAX(to_number(SUBDIVISION_OFFICE_CODE))+1 FROM RWS_SUBDIVISION_OFFICE_TBL WHERE DIVISION_OFFICE_CODE="
								+ doc + " and CIRCLE_OFFICE_CODE='" + coc + "' and HEAD_OFFICE_CODE=" + hoc);
				empMasterData.rs.next();
				code = empMasterData.rs.getString(1);
				if (code == null) {
					code = "01";
				} else if (code.length() == 1) {
					code = "0" + code;
				}
			} catch (Exception e) {
				Debug.println("The error in getSubDivisionCode" + e);
			} finally {
				empMasterData.closeAll();
			}
		}
		// Debug.println("code= " + code);
		return code;
	}

	// *********************************Section Office
	// Methods*************************************
	public static int insertSection(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			ps = empMasterData.conn.prepareStatement("insert into RWS_SECTION_OFFICE_TBL values(?,?,?,?,?,?)");
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
			Debug.println("The error in insertSection=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getSection(String hoc, String coc, String doc, String sdoc, String soc,
			DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt
					.executeQuery("select * from RWS_SECTION_OFFICE_TBL where SECTION_OFFICE_CODE='" + soc
							+ "' and subdivision_office_code='" + sdoc + "' and division_office_code=" + doc
							+ " and circle_office_code='" + coc + "' and head_office_code='" + hoc + "'");
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
			Debug.println("The error in getSection=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getSections(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList subdivisions = new ArrayList();

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.stmt2 = empMasterData.conn.createStatement();
			empMasterData.stmt3 = empMasterData.conn.createStatement();
			Statement stmt4 = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt.executeQuery(
					"SELECT DISTINCT ST.HEAD_OFFICE_CODE,H.HEAD_OFFICE_NAME,ST.CIRCLE_OFFICE_CODE,C.CIRCLE_OFFICE_NAME,ST.DIVISION_OFFICE_CODE,D.DIVISION_OFFICE_NAME,ST.SUBDIVISION_OFFICE_CODE,S.SUBDIVISION_OFFICE_NAME,ST.SECTION_OFFICE_CODE,ST.SECTION_OFFICE_NAME FROM RWS_SECTION_OFFICE_TBL ST,RWS_SUBDIVISION_OFFICE_TBL S,RWS_DIVISION_OFFICE_TBL D,RWS_CIRCLE_OFFICE_TBL C,RWS_HEAD_OFFICE_TBL H WHERE ST.HEAD_OFFICE_CODE=H.HEAD_OFFICE_CODE AND ST.CIRCLE_OFFICE_CODE=C.CIRCLE_OFFICE_CODE AND S.CIRCLE_OFFICE_CODE=C.CIRCLE_OFFICE_CODE AND D.CIRCLE_OFFICE_CODE=C.CIRCLE_OFFICE_CODE AND ST.DIVISION_OFFICE_CODE=D.DIVISION_OFFICE_CODE AND S.DIVISION_OFFICE_CODE=D.DIVISION_OFFICE_CODE AND ST.SUBDIVISION_OFFICE_CODE=S.SUBDIVISION_OFFICE_CODE ORDER BY HEAD_OFFICE_CODE,CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE,SECTION_OFFICE_CODE");
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
			Debug.println("The error in getSections" + e);
		} finally {
			empMasterData.closeAll();
		}
		return subdivisions;
	}

	public static int removeSection(String hoc, String coc, String doc, String sdoc, String soc, DataSource dataSource)
			throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rowCount = empMasterData.stmt
					.executeUpdate("delete  from RWS_SECTION_OFFICE_TBL where section_office_code='" + soc
							+ "' and subdivision_office_code='" + sdoc + "' and division_office_code=" + doc
							+ " and circle_office_code='" + coc + "' and head_office_code=" + hoc);
		}

		catch (Exception e) {
			Debug.println("The error in removeSection" + e);
		} finally {

			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static void updateSection(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		try {
			empMasterData.conn = RwsOffices.getConn();

			ps = empMasterData.conn.prepareStatement(
					"UPDATE  RWS_SECTION_OFFICE_TBL SET SECTION_OFFICE_NAME=? WHERE SECTION_OFFICE_CODE=? AND SUBDIVISION_OFFICE_CODE=? AND DIVISION_OFFICE_CODE=? AND CIRCLE_OFFICE_CODE=? AND HEAD_OFFICE_CODE=?");

			ps.setString(1, (empMaster.getSon()).toUpperCase());
			ps.setString(2, empMaster.getSoc());
			ps.setString(3, empMaster.getSdoc());
			ps.setString(4, empMaster.getDoc());
			ps.setString(5, empMaster.getCoc());
			ps.setString(6, empMaster.getHoc());

			ps.executeUpdate();
		} catch (Exception e) {
			Debug.println("The error in updateSection=" + e);
		} finally {
			empMasterData.closeAll();
		}
	}

	public static String getSectionCode(String hoc, String coc, String doc, String sdoc, DataSource dataSource)
			throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		String code = "";
		if (sdoc != null) {
			try {
				empMasterData.conn = RwsOffices.getConn();
				empMasterData.stmt = empMasterData.conn.createStatement();
				empMasterData.rs = empMasterData.stmt.executeQuery(
						"SELECT MAX(to_number(SECTION_OFFICE_CODE))+1 FROM RWS_SECTION_OFFICE_TBL WHERE SUBDIVISION_OFFICE_CODE="
								+ sdoc + "AND DIVISION_OFFICE_CODE=" + doc + " and CIRCLE_OFFICE_CODE='" + coc
								+ "' and HEAD_OFFICE_CODE=" + hoc);
				empMasterData.rs.next();
				code = empMasterData.rs.getString(1);
				if (code == null)
					code = "1";
			} catch (Exception e) {
				Debug.println("The error in getSectionCode" + e);
			} finally {
				empMasterData.closeAll();
			}
		}
		return code;
	}

	// **************************************RWS Office
	// Methods****************************
	public static int insertOffice(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			ps = empMasterData.conn.prepareStatement("insert into RWS_OFFICE_TBL values(?,?,?,?,?,?,?,?,?,?,?,?)");
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
			Debug.println("The error in insertOffice" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getOffice(String roc, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt
					.executeQuery("select * from RWS_OFFICE_TBL where office_code='" + roc + "'");
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				String oc = empMasterData.rs.getString("office_code");
				empMaster.setHoc(getHeadOfficeName(oc.substring(0, 1), empMasterData.conn));
				if (!oc.substring(1, 3).equals("00"))
					empMaster.setCoc(getCircleOfficeName(oc.substring(0, 1), oc.substring(1, 3), empMasterData.conn));
				if (!oc.substring(3, 4).equals("0"))
					empMaster.setDoc(getDivisionOfficeName(oc.substring(0, 1), oc.substring(1, 3), oc.substring(3, 4),
							empMasterData.conn));
				if (!oc.substring(4, 6).equals("00"))
					empMaster.setSdoc(getSubDivisionOfficeName(oc.substring(0, 1), oc.substring(1, 3),
							oc.substring(3, 4), oc.substring(4, 6), empMasterData.conn));

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
			Debug.println("The error in getOffice=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getOffices(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList offices = new ArrayList();

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt.executeQuery("select * from RWS_OFFICE_TBL");
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
				empMaster.setHof(getDesgnName(empMasterData.rs.getString("head_of_office"), empMasterData.conn));
				if (empMasterData.rs.getString("project").equalsIgnoreCase("P"))
					empMaster.setProject("PROJECT");
				else if (empMasterData.rs.getString("project").equalsIgnoreCase("R"))
					empMaster.setProject("REGULAR");

				offices.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println("The error in getOffices=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return offices;
	}

	public static void removeOffice(String roc, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt.executeUpdate("delete  from RWS_OFFICE_TBL where office_code='" + roc + "'");
		} catch (Exception e) {
			Debug.println("The error in removeOffice=" + e);
		} finally {

			empMasterData.closeAll();
		}
	}

	public static void updateOffice(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		try {
			empMasterData.conn = RwsOffices.getConn();

			ps = empMasterData.conn.prepareStatement(
					"update  RWS_OFFICE_TBL set address1=?,address2=?,address3=?,city=?,pincode=?,phone=?,fax=?,email=?,building=?,head_of_office=?,project=? where office_code=?");
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
			Debug.println("The error in updateOffice=" + e);
		} finally {
			empMasterData.closeAll();
		}
	}

	public static ArrayList getAddQualCodes(String qcode, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList addqualcodes = new ArrayList();

		try {
			empMasterData.conn = RwsOffices.getConn();		
			if (qcode.length() >= 1 || qcode != null) {
				empMasterData.pstmt = empMasterData.conn.prepareStatement("select * from rws_qualification_tbl where qual_code=?");
				empMasterData.pstmt.setString(1, qcode);
				empMasterData.rs = empMasterData.pstmt.executeQuery();			
				while (empMasterData.rs.next()) {
					empMaster = new EmpMaster();
					empMaster.setQualCode(empMasterData.rs.getString("qual_code"));
					empMaster.setQualName(empMasterData.rs.getString("qual_name"));
					empMaster.setQualNoName(
							empMasterData.rs.getString("qual_code") + " - " + empMasterData.rs.getString("qual_name"));
					addqualcodes.add(empMaster);
				}
			}
		}

		catch (Exception e) {
			Debug.println("The error in getAddQualCodes in empMasterData " + e);
		} finally {
			empMasterData.closeAll();
		}
		return addqualcodes;
	}

	// Added on Aug 1
	public static ArrayList getCastes(String code) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList CasteCodes = new ArrayList();

		try {
			// Debug.println("in getCaste");
			// Debug.println("ConnCount is "+connCount);
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			if (code.length() >= 1 || code != null) {
				// Debug.println("the qcode value "+code);
				empMasterData.rs = empMasterData.stmt
						.executeQuery("SELECT * FROM RWS_CAST_MST_TBL where CASTE_CODE<>'" + code + "'");

				while (empMasterData.rs.next()) {
					empMaster = new EmpMaster();

					empMaster.setCasteCode(empMasterData.rs.getString("caste_code"));
					empMaster.setCasteName(empMasterData.rs.getString("caste_name"));

					String casteCode = empMasterData.rs.getString("caste_code");
					String casteName = empMasterData.rs.getString("caste_name");

					empMaster.setCasteNoName(casteCode + " - " + casteName);

					CasteCodes.add(empMaster);

				}
			}
		} catch (Exception e) {
			Debug.println("The error in casteName" + e);
		} finally {
			empMasterData.closeAll();
		}
		return CasteCodes;
	}

	public static ArrayList getCastes() throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList castes = new ArrayList();

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt.executeQuery("SELECT * FROM RWS_CAST_MST_TBL order by caste_code");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setCasteCode(empMasterData.rs.getString("caste_code"));
				empMaster.setCasteName(empMasterData.rs.getString("caste_name"));
				String casteCode = empMasterData.rs.getString("caste_code");
				String casteName = empMasterData.rs.getString("caste_name");
				empMaster.setCasteNoName(casteCode + " - " + casteName);
				castes.add(empMaster);
			}

		} catch (Exception e) {
			Debug.println("The error in casteName" + e);
		} finally {
			empMasterData.closeAll();
		}
		return castes;
	}

	public static String getEmpCode(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		String ecode = null;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			// empMasterData.rs =empMasterData.stmt.executeQuery("SELECT
			// /*MAX(to_number(employee_CODE))+1 */FROM RWS_employee_TBL");
			empMasterData.rs = empMasterData.stmt.executeQuery("SELECT EMPLOYEE_CODE FROM RWS_employee_TBL");
			empMasterData.rs.next();
			ecode = empMasterData.rs.getString(1);
			if (ecode == null) {
				ecode = "1";
			}
		} catch (Exception e) {
			Debug.println("Ther error in getEmpCode" + e);
		} finally {
			empMasterData.closeAll();
		}
		return ecode;
	}

	// Added on Aug 1

	public static ArrayList getReligions() throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList religions = new ArrayList();
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			String query = "SELECT * FROM RWS_RELEGION_MST_TBL order by relg_code";
			empMasterData.rs = empMasterData.stmt.executeQuery(query);
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
			Debug.println("The error in getReligions in EmpMasterData " + e);
		} finally {
			empMasterData.closeAll();
		}
		return religions;
	}

	// Added on Aug 1

	public static String getDistName(String dcode) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();

		String distname = "";
		String query = null;
		if (dcode != null && !dcode.equals("00")) {
			try {
				// Debug.println("in getDistName");
				// Debug.println("ConnCount is "+connCount);
				// Debug.println("1");
				empMasterData.conn = RwsOffices.getConn();
				// Debug.println("2");
				empMasterData.stmt = empMasterData.conn.createStatement();
				// Debug.println("3");
				query = "select DNAME from rws_district_tbl where DCODE='" + dcode + "' ";
				empMasterData.rs = empMasterData.stmt.executeQuery(query);
				// Debug.println("District name "+query);
				while (empMasterData.rs.next()) {
					distname = empMasterData.rs.getString(1);
				}
			} catch (Exception e) {
				Debug.println("The error in getDistName=" + e);
			} finally {
				empMasterData.closeAll();
			}
		}
		return distname;
	}

	// Added on Aug 2

	public static ArrayList getZones1(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList zonecodes = new ArrayList();

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			String query = "SELECT distinct zone_code FROM RWS_ZONE_MST_TBL order by ZONE_CODE";			
			empMasterData.rs = empMasterData.stmt.executeQuery(query);
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setValue(empMasterData.rs.getString("ZONE_CODE"));
				empMaster.setLabel("zone" + empMasterData.rs.getString("ZONE_CODE"));
				String zoneCode = empMasterData.rs.getString("ZONE_CODE");
				String zoneName = "zone" + empMasterData.rs.getString("ZONE_CODE");
				empMaster.setZoneNoName(zoneCode + " - " + zoneName);
				zonecodes.add(empMaster);
			}
		}
		catch (Exception e) {
			Debug.println("The error in getZones" + e);
		} finally {
			empMasterData.closeAll();
			//Debug.println("ConnCount after closing is " + connCount);
		}
		return zonecodes;
	}

	// code for gettig Zone names
	public static String getZoneName(String code) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = RwsOffices.getConn();
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			if (code != null) {
				String query = "SELECT distinct zone_code FROM RWS_ZONE_MST_TBL where ZONE_CODE='" + code + "' ";
				Debug.println("query is " + query);
				empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
				while (empMasterData.rs1.next()) {
					name = "zone" + empMasterData.rs1.getString(1);
				}
			}
		} catch (Exception e) {
			Debug.println("Ther error in getDistrictName=" + e);
		} finally {
			empMasterData.stmt1.close();

		}
		return name;
	}
	/*
	 * String
	 * query="SELECT distinct zone_code FROM RWS_ZONE_MST_TBL order by ZONE_CODE";
	 * Debug.println("query is "+query); empMasterData.rs
	 * =empMasterData.stmt.executeQuery(query); /*empMasterData.rs1 =
	 * empMasterData.stmt1
	 * .executeQuery("SELECT DESIGNATION_ACR,DESIGNATION_name FROM rws_designation_tbl WHERE designation_CODE ='"
	 * + code + "'"); empMasterData.rs1.next(); name =
	 * empMasterData.rs1.getString(1); } else name = ""; } catch (Exception e) {
	 * Debug.println("Ther error in getZoneName=" + e); } finally {
	 * empMasterData.stmt1.close(); } return name; }
	 */

	// same code with dataSource

	public static String getZoneName(String code, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = RwsOffices.getConn();
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			if (code != null) {
				String query = "SELECT distinct zone_code FROM RWS_ZONE_MST_TBL where ZONE_CODE='" + code + "' ";
				// Debug.println("query is "+query);
				empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
				while (empMasterData.rs1.next()) {
					name = "zone" + empMasterData.rs1.getString(1);
				}
			}
		} catch (Exception e) {
			Debug.println("Ther error in getDistrictName=" + e);
		} finally {
			empMasterData.closeAll();

		}
		return name;
	}

	public static ArrayList getZones() throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList zonecodes = new ArrayList();
		try {		
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			String query = "SELECT distinct zone_code FROM RWS_ZONE_MST_TBL order by ZONE_CODE";
			empMasterData.rs = empMasterData.stmt.executeQuery(query);
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setZoneCode(empMasterData.rs.getString("ZONE_CODE"));
				empMaster.setZoneName("zone" + empMasterData.rs.getString("ZONE_CODE"));
				String zoneCode = empMasterData.rs.getString("ZONE_CODE");
				String zoneName = "zone" + empMasterData.rs.getString("ZONE_CODE");
				empMaster.setZoneNoName(zoneCode + " - " + zoneName);
				zonecodes.add(empMaster);
			}
		}
		catch (Exception e) {
			Debug.println("The error in getZones in EmpMasterData " + e);
		} finally {
			empMasterData.closeAll();
		}
		return zonecodes;
	}

	public static ArrayList getModeOfAppt(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList modes = new ArrayList();
		try {			
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.pstmt = empMasterData.conn.prepareStatement("SELECT * FROM RWS_MODEOFAPP_MST_TBL order by moap_code");
			empMasterData.rs = empMasterData.pstmt.executeQuery();
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
			Debug.println("The error in getModeOfAppt in EmpMasterData  " + e);
		} finally {
			empMasterData.closeAll();
		}
		return modes;
	}

	public static ArrayList getCatogs(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList catcodes = new ArrayList();
		try {			
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt	.executeQuery("SELECT distinct APCATEG_CODE,APCATEG_NAME FROM rws_app_category_mst_tbl order by APCATEG_CODE");
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
			Debug.println("The error in getCatogs in EmpMasterData " + e);
		} finally {
			empMasterData.closeAll();
		}
		return catcodes;
	}

	public static ArrayList getQualNoName(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList qualcodes = new ArrayList();

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt	.executeQuery("SELECT * FROM RWS_qualification_TBL order by qual_code");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setQualCode(empMasterData.rs.getString("qual_code"));
				empMaster.setQualName(empMasterData.rs.getString("qual_name"));
				String qualCode = empMasterData.rs.getString("qual_code");
				String qualName = empMasterData.rs.getString("qual_name");				
				empMaster.setQualNoName(qualCode + " - " + qualName);
				qualcodes.add(empMaster);
			}
		}catch (Exception e) {
			Debug.println("The error in getQualNoName" + e);
		} finally {
			empMasterData.closeAll();
		}
		return qualcodes;
	}

	// **********************************Asset type
	// methods**********************************

	public static int insertAssetType(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rowCount = empMasterData.stmt.executeUpdate("insert into rws_asset_type_tbl values(" + "'"
					+ empMaster.getAssetTypeCode() + "'," + "'" + empMaster.getAssetTypeName().toUpperCase() + "')");
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			Debug.println("The error in insertAssetType" + e);
		}

		finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getAssetType(String assetTypeCode, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt
					.executeQuery("select * from rws_asset_type_tbl where type_of_asset_code=" + assetTypeCode);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setAssetTypeCode(empMasterData.rs.getString(1));
				empMaster.setAssetTypeName(empMasterData.rs.getString(2));
			}
		} catch (Exception e) {
			Debug.println("The error in getAssetType" + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getAssetTypes(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList assetTypes = new ArrayList();
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt
					.executeQuery("select * from rws_asset_type_tbl order by type_of_asset_code");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setAssetTypeCode(empMasterData.rs.getString(1));
				empMaster.setAssetTypeName(empMasterData.rs.getString(2));

				empMaster.setAssetTypeNoName(empMasterData.rs.getString(1) + " - " + empMasterData.rs.getString(2));

				assetTypes.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println("The error in getAssetTypes" + e);
		} finally {
			empMasterData.closeAll();
		}
		return assetTypes;
	}

	public static int removeAssetType(String assetTypeCode, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rcount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rcount = empMasterData.stmt
					.executeUpdate("delete  from rws_asset_type_tbl where type_of_asset_code='" + assetTypeCode + "'");
		} catch (Exception e) {
			Debug.println("The error in removeAssetType=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return rcount;
	}

	public static int updateAssetType(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int updateCount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			updateCount = empMasterData.stmt.executeUpdate(
					"update  rws_asset_type_tbl set type_of_asset_name='" + empMaster.getAssetTypeName().toUpperCase()
							+ "' where type_of_asset_code='" + empMaster.getAssetTypeCode() + "'");
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			Debug.println("The error in updateAssetType " + sqle);
		} catch (Exception e) {
			Debug.println("The error in updateAssetType" + e);
		} finally {
			empMasterData.closeAll();
		}
		return updateCount;
	}

	public static String getAssetTypeCode(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		String code = null;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt
					.executeQuery("SELECT MAX(to_number(type_of_asset_code))+1 FROM rws_asset_type_tbl");
			empMasterData.rs.next();
			code = empMasterData.rs.getString(1);
			if (code == null) {
				code = "01";
			} else if (code.length() == 1) {
				code = "0" + code;
			}
		} catch (Exception e) {
			Debug.println("The error in getAssetTypeCode=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	public static String getAssetTypeCode(String name, Connection conn) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		String acode = null;
		try {
			empMasterData.conn = conn;
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt.executeQuery(
					"SELECT type_of_asset_code FROM rws_asset_type_tbl where type_of_asset_name='" + name + "'");
			empMasterData.rs.next();
			acode = empMasterData.rs.getString(1);
		} catch (Exception e) {
			Debug.println("The error in getAssetTypeCode=" + e);
		} finally {
			empMasterData.stmt.close();
			// empMasterData.closeAll();
		}
		return acode;
	}

	public static int insertWorkSpec(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.pstmt = empMasterData.conn.prepareStatement("insert into RWS_SPEC_SKILL_TBL values(?,?)");
			empMasterData.pstmt.setString(1,  empMaster.getWorkSpecCode() );
			empMasterData.pstmt.setString(2,  empMaster.getWorkSpecName().toUpperCase() );
			rowCount = empMasterData.pstmt.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			Debug.println("The error in insertWorkSpec " + sqle);
		} catch (Exception e) {
			Debug.println("The error in insertWorkSpec in EmpMaterData " + e);
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static String getWorkSpecName(String code) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = RwsOffices.getConn();
		String name = null;
		String query;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			if (code != null) {
				query = "select SKILL_DESCRIPTION from RWS_SPEC_SKILL_TBL where SKILL_CODE ='" + code + "' ";
				empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
				// Debug.println(" getWorkspecial() Name "+query);
				while (empMasterData.rs1.next()) {
					name = empMasterData.rs1.getString(1);
				}
			}
		} catch (Exception e) {
			Debug.println("Ther error in getQualName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	// same code with dataSource
	public static String getWorkSpecName(String code, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();		
		String name = null;
		String query;		
		try {
			empMasterData.conn = RwsOffices.getConn();			
			if (code != null) {
				empMasterData.pstmt1 = empMasterData.conn.prepareStatement("select SKILL_DESCRIPTION from RWS_SPEC_SKILL_TBL where SKILL_CODE =? ");
				empMasterData.pstmt1.setString(1, code);
				empMasterData.rs1 = empMasterData.pstmt1.executeQuery();
				// Debug.println(" getWorkspecial() Name "+query);
				while (empMasterData.rs1.next()) {
					name = empMasterData.rs1.getString(1);
				}
			}
		} catch (Exception e) {
			Debug.println("Ther error in getWorkSpecName in EmpMasterData " + e);
		} finally {
			empMasterData.closeAll();
		}
		return name;
	}

	public static EmpMaster getWorkSpec(String skillCode, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.pstmt = empMasterData.conn.prepareStatement("select * from RWS_SPEC_SKILL_TBL where SKILL_CODE =? ");
			empMasterData.pstmt.setString(1, skillCode);
			empMasterData.rs = empMasterData.pstmt.executeQuery();
			// Debug.println("Work"+query);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setWorkSpecCode(empMasterData.rs.getString(1));
				empMaster.setWorkSpecName(empMasterData.rs.getString(2));
			}
		} catch (Exception e) {
			Debug.println("The error in getWorkSpec in EmpMasterData " + e);
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getWorkSpecs(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList workSpecs = new ArrayList();
		String query = null;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.pstmt = empMasterData.conn.prepareStatement("select * from RWS_SPEC_SKILL_TBL order by SKILL_CODE");
			empMasterData.rs = empMasterData.pstmt.executeQuery();
			// Debug.println("query Work special "+query);
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setWorkSpecCode(empMasterData.rs.getString(1));
				empMaster.setWorkSpecName(empMasterData.rs.getString(2));
				empMaster.setWorkSpecNoName(empMasterData.rs.getString(1) + " - " + empMasterData.rs.getString(2));
				workSpecs.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println("The error in getWorkSpecs  in EmpMasterData " + e);
		} finally {
			empMasterData.closeAll();
		}
		return workSpecs;
	}

	public static int removeWorkSpec(String skillCode, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rcount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.pstmt = empMasterData.conn.prepareStatement("delete  from RWS_SPEC_SKILL_TBL where SKILL_CODE=?");
			empMasterData.pstmt.setString(1, skillCode);
			rcount = empMasterData.pstmt.executeUpdate();
		} catch (Exception e) {
			Debug.println("The error in removeWorkSpec in EmpMasterData " + e);
		} finally {
			empMasterData.closeAll();
		}
		return rcount;
	}

	public static int updateWorkSpec(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int updateCount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.pstmt = empMasterData.conn.prepareStatement("update  RWS_SPEC_SKILL_TBL set SKILL_DESCRIPTION=? where SKILL_CODE=?");
			empMasterData.pstmt.setString(1, empMaster.getWorkSpecName().toUpperCase() );			
			empMasterData.pstmt.setString(2, empMaster.getWorkSpecCode() );
			updateCount = empMasterData.pstmt.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			Debug.println("The error in updateHead " + sqle);
		} catch (Exception e) {
			Debug.println("The error in updateWorkSpec in EmpMaterData " + e);
		} finally {
			empMasterData.closeAll();
		}
		return updateCount;
	}

	public static String getWorkSpecialCode(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		String code = null;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.pstmt = empMasterData.conn.prepareStatement("SELECT MAX(to_number(SKILL_CODE))+1 FROM RWS_SPEC_SKILL_TBL");
			empMasterData.rs = empMasterData.pstmt.executeQuery();
			empMasterData.rs.next();
			code = empMasterData.rs.getString(1);
			if (code == null) {
				code = "1";
			}
		} catch (Exception e) {
			Debug.println("The error in getWorkSpecialCode in EmpMasterData " + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	public static String getMandalName(String dcode, String mcode) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		String mname = null;
		String query = "";
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.pstmt = empMasterData.conn.prepareStatement("select MNAME from RWS_MANDAL_TBL where MCODE='" + mcode + "' and DCODE='" + dcode + "'");
			empMasterData.rs = empMasterData.stmt.executeQuery(query);
			// Debug.println("query getMandal name"+query);
			while (empMasterData.rs.next()) {
				mname = empMasterData.rs.getString(1);
			}
		} catch (Exception e) {
			Debug.println("The error in getMandal Name=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return mname;
	}

	public static int insertWaterTest(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			ps = empMasterData.conn.prepareStatement("insert into RWS_WATER_QUALITY_TEST_TBL values(?,?,?)");
			ps.setString(1, empMaster.getTestCode());
			ps.setString(2, empMaster.getTestName().toUpperCase());
			ps.setString(3, empMaster.getTestPeriod());

			rowCount = ps.executeUpdate();
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			Debug.println("The error is" + e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getWaterTest(String testCode, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt
					.executeQuery("select * from RWS_WATER_QUALITY_TEST_TBL where TEST_CODE=" + testCode);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setTestCode(empMasterData.rs.getString("TEST_CODE"));
				empMaster.setTestName(empMasterData.rs.getString("TEST_NAME"));
				empMaster.setTestPeriod(empMasterData.rs.getString("TEST_PERIODCITY"));
			}
		} catch (Exception e) {
			Debug.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getWaterTests(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList watertests = new ArrayList();
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt.executeQuery(
					"SELECT TEST_CODE,TEST_NAME,DECODE(TEST_PERIODCITY ,'M','MONTHLY','Q','QUARTERLY','H','HALFERLY','Y','YEARLY') FROM RWS_WATER_QUALITY_TEST_TBL");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setTestCode(empMasterData.rs.getString(1));
				empMaster.setTestName(empMasterData.rs.getString(2));
				empMaster.setTestPeriod(empMasterData.rs.getString(3));
				empMaster.setTestCodeDisplay(empMasterData.rs.getString(1) + "-" + empMasterData.rs.getString(2));
				watertests.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return watertests;
	}

	public static int removeWaterTest(String testCode, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt
					.executeQuery("SELECT * FROM RWS_WQ_PARA_TEST_TBL where TEST_CODE='" + testCode + "'");
			if (empMasterData.rs.next() == false) {
				rowCount = empMasterData.stmt
						.executeUpdate("delete  from RWS_WATER_QUALITY_TEST_TBL where TEST_CODE='" + testCode + "'");
			}
		} catch (Exception e) {
			Debug.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static int updateWaterTest(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int ans = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();

			ps = empMasterData.conn.prepareStatement(
					"update  RWS_WATER_QUALITY_TEST_TBL set TEST_NAME=?,TEST_PERIODCITY=? where TEST_CODE=?");

			ps.setString(1, empMaster.getTestName().toUpperCase());
			ps.setString(2, empMaster.getTestPeriod());
			ps.setString(3, empMaster.getTestCode());
			ans = ps.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			Debug.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return ans;
	}

	public static String getTestCode(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		String code = null;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt
					.executeQuery("SELECT MAX(TEST_CODE)+1 FROM RWS_WATER_QUALITY_TEST_TBL");
			empMasterData.rs.next();
			code = empMasterData.rs.getString(1);
			if (code == null) {
				code = "1";
			}
		} catch (Exception e) {
			Debug.println("Ther error in getTestCode" + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	// ******************************Water Parameter
	// Test**********************************************//
	public static int insertWaterParameterTest(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			ps = empMasterData.conn.prepareStatement("insert into RWS_WQ_PARA_TEST_TBL values(?,?,?,?,?)");
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
			Debug.println("The error is" + e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getWaterParameterTest(String testCode, String testPCode, DataSource dataSource)
			throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		// Debug.println("testCode=" + testCode + " testPCode=" + testPCode);
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt
					.executeQuery("select * from RWS_WQ_PARA_TEST_TBL where TESTING_PARAMETER_CODE='" + testPCode
							+ "' and TEST_CODE='" + testCode + "'");
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
			Debug.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getWaterParameterTests(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList waterptests = new ArrayList();
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt.executeQuery(
					"SELECT P.TEST_CODE,T.TEST_NAME,P.TESTING_PARAMETER_CODE,P.TESTING_PARAMETER_NAME,MIN_PERMISSIBLE_VALUE,MAX_PERMISSIBLE_VALUE FROM RWS_WQ_PARA_TEST_TBL P,RWS_WATER_QUALITY_TEST_TBL T WHERE T.TEST_CODE=P.TEST_CODE ORDER BY TEST_CODE,TESTING_PARAMETER_CODE");
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
			Debug.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return waterptests;
	}

	public static int removeWaterParameterTest(String testCode, String testPCode, DataSource dataSource)
			throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rcount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rcount = empMasterData.stmt.executeUpdate("delete  from RWS_WQ_PARA_TEST_TBL where TESTING_PARAMETER_CODE='"
					+ testPCode + "' and TEST_CODE='" + testCode + "'");
		} catch (Exception e) {
			Debug.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return rcount;
	}

	public static int updateWaterParameterTest(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int ans = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();

			ps = empMasterData.conn.prepareStatement(
					"update  RWS_WQ_PARA_TEST_TBL set TESTING_PARAMETER_NAME=?,MIN_PERMISSIBLE_VALUE=?,MAX_PERMISSIBLE_VALUE=? where TESTING_PARAMETER_CODE=? and TEST_CODE=?");

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
			Debug.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return ans;
	}

	public static String getWQPTestCode(String testCode, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		String code = null;
		if (testCode != null) {
			try {
				empMasterData.conn = RwsOffices.getConn();
				empMasterData.stmt = empMasterData.conn.createStatement();
				empMasterData.rs = empMasterData.stmt
						.executeQuery("SELECT MAX(TESTING_PARAMETER_CODE)+1 FROM RWS_WQ_PARA_TEST_TBL WHERE TEST_CODE='"
								+ testCode + "'");
				empMasterData.rs.next();
				code = empMasterData.rs.getString(1);
				if (code == null)
					code = "01";
				if (code.length() == 1)
					code = "0" + code;
			} catch (Exception e) {
				Debug.println("The error in getWQPTestCode" + e);
			} finally {
				empMasterData.closeAll();
			}
		}
		return code;
	}

	// *********************************Names on
	// Codes****************************************

	public static String getHeadOfficeName(String code, Connection conn) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = conn;
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1.executeQuery(
					"SELECT HEAD_OFFICE_NAME FROM RWS_HEAD_OFFICE_TBL WHERE HEAD_OFFICE_CODE='" + code + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
		} catch (Exception e) {
			Debug.println("Ther error in getHeadOfficeName=" + e);
		} finally {
			empMasterData.stmt1.close();

		}
		return name;
	}

	public static String getDistrictName(String dcode, Connection conn) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = conn;
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		String query;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			query = "SELECT DNAME FROM RWS_DISTRICT_TBL WHERE DCODE='" + dcode + "' ";
			empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
			while (empMasterData.rs1.next()) {
				name = empMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			Debug.println("Ther error in getDistrictName=" + e);
		} finally {
			empMasterData.stmt1.close();

		}
		return name;
	}

	public static String getDistrictName(String dcode, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		String query;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.pstmt = empMasterData.conn.prepareStatement( "SELECT DNAME FROM RWS_DISTRICT_TBL WHERE DCODE=? ");
			empMasterData.pstmt.setString(1, dcode);
			empMasterData.rs1 = empMasterData.pstmt.executeQuery();
			while (empMasterData.rs1.next()) {
				name = empMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			Debug.println("Ther error in getDistrictName in EmpMasterData " + e);
		} finally {
			empMasterData.closeAll();
		}
		return name;
	}

	public static String getCircleOfficeName(String hoc, String coc, Connection conn) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = conn;
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT CIRCLE_OFFICE_NAME FROM RWS_CIRCLE_OFFICE_TBL WHERE HEAD_OFFICE_CODE='" + hoc
							+ "' and CIRCLE_OFFICE_CODE='" + coc + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
		} catch (Exception e) {
			Debug.println("Ther error in getCircleOfficeName=" + e);
		} finally {
			empMasterData.stmt1.close();

		}
		return name;
	}

	public static String getDivisionOfficeName(String hoc, String coc, String doc, Connection conn) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = conn;
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		// Debug.println("hoc=" + hoc + " coc=" + coc + " doc=" + doc);
		try {
			if (doc != null || !(doc.equals("0"))) {
				empMasterData.stmt1 = empMasterData.conn.createStatement();
				empMasterData.rs1 = empMasterData.stmt1.executeQuery(
						"SELECT DIVISION_OFFICE_NAME FROM RWS_DIVISION_OFFICE_TBL WHERE HEAD_OFFICE_CODE='" + hoc
								+ "' and CIRCLE_OFFICE_CODE='" + coc + "' and DIVISION_OFFICE_CODE='" + doc + "'");
				empMasterData.rs1.next();
				name = empMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			Debug.println("Ther error in getDivisionOfficeName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getSubDivisionOfficeName(String hoc, String coc, String doc, String sdoc, Connection conn)
			throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = conn;
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		// Debug.println("hoc=" + hoc + " coc=" + coc + " doc=" + doc+ " sdoc=" + sdoc);
		try {
			if (doc != null || !(doc.equals("0"))) {
				empMasterData.stmt1 = empMasterData.conn.createStatement();
				empMasterData.rs1 = empMasterData.stmt1.executeQuery(
						"SELECT SUBDIVISION_OFFICE_NAME FROM RWS_SUBDIVISION_OFFICE_TBL WHERE HEAD_OFFICE_CODE='" + hoc
								+ "' and CIRCLE_OFFICE_CODE='" + coc + "' and DIVISION_OFFICE_CODE='" + doc
								+ "' and SUBDIVISION_OFFICE_CODE='" + sdoc + "'");
				empMasterData.rs1.next();
				name = empMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			Debug.println("Ther error in getSubDivisionOfficeName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getSectionOfficeName(String hoc, String coc, String doc, String sdoc, String soc,
			Connection conn) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = conn;
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT SECTION_OFFICE_NAME FROM RWS_SECTION_OFFICE_TBL WHERE HEAD_OFFICE_CODE='"
							+ hoc + "' and CIRCLE_OFFICE_CODE='" + coc + "' and DIVISION_OFFICE_CODE='" + doc
							+ "' and SUBDIVISION_OFFICE_CODE='" + sdoc + "' and SECTION_OFFICE_CODE='" + soc + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
		} catch (Exception e) {
			Debug.println("Ther error in getSectionOfficeName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getMajorHeadName(String majorCode, Connection conn) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = conn;
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1.executeQuery(
					"SELECT MAJOR_HEAD_NAME FROM RWS_MAJORHEAD_TBL WHERE MAJOR_HEAD_CODE ='" + majorCode + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
		} catch (Exception e) {
			Debug.println("Ther error in getMajorHeadName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getSubMajorHeadName(String majorCode, String subMajorCode, Connection conn) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT SUBMAJOR_HEAD_NAME FROM RWS_SUBMAJORHEAD_TBL WHERE MAJOR_HEAD_CODE ='"
							+ majorCode + "' and SUBMAJOR_HEAD_CODE='" + subMajorCode + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
		} catch (Exception e) {
			Debug.println("Ther error in getSubMajorHeadName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getMinorHeadName(String majorCode, String subMajorCode, String minorCode, Connection conn)
			throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = conn;
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT MINOR_HEAD_NAME FROM RWS_MINORHEAD_TBL WHERE MAJOR_HEAD_CODE ='" + majorCode
							+ "' and SUBMAJOR_HEAD_CODE='" + subMajorCode + "' and MINOR_HEAD_CODE='" + minorCode
							+ "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
		} catch (Exception e) {
			Debug.println("Ther error in getMinorHeadName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String[] getQualNames(String code, String code1, String code2) throws Exception {
	//	Debug.println("1111111");
		EmpMasterData empMasterData = new EmpMasterData();
	
		String name[] = new String[3];
		String query;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.conn = RwsOffices.getConn();
			//Debug.println("111111122222222");
		
			if (code == null)
				code = "";
			if (code1 == null)
				code1 = "";
			if (code2 == null)
				code2 = "";
			query = "select (SELECT nvl(QUAL_NAME,'-') FROM rws_qualification_tbl   where qual_code=?),"
					+ "(SELECT nvl(QUAL_NAME,'-')  FROM rws_qualification_tbl   where qual_code=?),"
					+ "(SELECT nvl(QUAL_NAME,'-')  FROM rws_qualification_tbl   where qual_code=?) from dual";
			empMasterData.pstmt1 = empMasterData.conn.prepareStatement(query);
			empMasterData.pstmt1.setString(1, code);
			empMasterData.pstmt1.setString(2, code1);
			empMasterData.pstmt1.setString(3, code2);
			empMasterData.rs1 = empMasterData.pstmt1.executeQuery();

			if (empMasterData.rs1.next()) {
				if (empMasterData.rs1.getString(1) != null)
					code = empMasterData.rs1.getString(1);
				else
					code = "-";
				if (empMasterData.rs1.getString(2) != null)
					code1 = empMasterData.rs1.getString(2);
				else
					code1 = "-";
				if (empMasterData.rs1.getString(3) != null)
					code2 = empMasterData.rs1.getString(3);
				else
					code2 = "-";
				// Debug.println("1:"+empMasterData.rs1.getString(1));
				// Debug.println("2:"+empMasterData.rs1.getString(2));
				// Debug.println("3:"+empMasterData.rs1.getString(3));
				// Debug.println("code:"+code);
				// Debug.println("code1:"+code1);Debug.println("code2:"+code2);
				name[0] = code;
				// Debug.println("name[0]:"+name[0]);
				name[1] = code1;
				// Debug.println("name[1]:"+name[1]);
				name[2] = code2;
				// Debug.println("name[2]:"+name[2]);
			} else {
				name[0] = "-";
				name[1] = "-";
				name[2] = "-";
			}

		} catch (Exception e) {
			Debug.println("Ther error in getQualName=" + e);
		} finally {
			if(empMasterData.pstmt1 != null)
			empMasterData.pstmt1.close();
			if(empMasterData.rs1 != null)
			empMasterData.rs1.close();
			//Debug.println("connection count" + connCount);
		}
		return name;
	}

	public static String getQualName(String code) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = RwsOffices.getConn();
		String name = null;
		String query;
		try {
				if (code != null) {
				empMasterData.pstmt1 = empMasterData.conn.prepareStatement("SELECT QUAL_NAME FROM rws_qualification_tbl WHERE QUAL_CODE =? ");
				empMasterData.pstmt1.setString(1, code);
				empMasterData.rs1 = empMasterData.pstmt1.executeQuery();
				// Debug.println("qualification"+query);
				while (empMasterData.rs1.next()) {
					name = empMasterData.rs1.getString(1);
				}
			}
		} catch (Exception e) {
			Debug.println("Ther error in getQualName in EmpMasterData " + e);
		} finally {
			
			empMasterData.pstmt1.close();
			empMasterData.rs1.close();
			//Debug.println("connection count" + connCount);
		}
		return name;
	}

	// same with dataSource
	/*
	 * public static String getQualName(String code,DataSource dataSource) throws
	 * Exception { EmpMasterData empMasterData=new EmpMasterData();
	 * empMasterData.conn=RwsOffices.getConn(); String name = null; String query;
	 * empMasterData.stmt1 = null; empMasterData.rs1 = null; try {
	 * empMasterData.stmt1 = empMasterData.conn.createStatement(); if(code!= null) {
	 * query="SELECT QUAL_NAME FROM rws_qualification_tbl WHERE QUAL_CODE ='"
	 * +code+"' "; empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
	 * //Debug.println("qualification"+query); while(empMasterData.rs1.next()) {
	 * name = empMasterData.rs1.getString(1); } } } catch (Exception e) {
	 * Debug.println("Ther error in getQualName=" + e); } finally {
	 * empMasterData.closeAll(); Debug.println("connection count"+connCount); }
	 * return name; }
	 */
	// code added

	public static String getCasteName(String code, Connection conn) throws Exception {

		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = conn;
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			if (code != null) {
				String query = "SELECT CASTE_NAME	FROM RWS_CAST_MST_TBL where CASTE_CODE ='" + code + "' ";
				empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
				// Debug.println("Caste Table"+query);
				while (empMasterData.rs1.next()) {
					name = empMasterData.rs1.getString(1);
				}
			}
		} catch (Exception e) {
			Debug.println("Ther error in getCasteName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	// end of code added

	public static String getDesgnName(String code, Connection conn) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = conn;
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			String query = "SELECT DESIGNATION_ACR,DESIGNATION_NAME FROM rws_designation_tbl WHERE designation_CODE ='"
					+ code + "' ";
			if (code != null) {
				empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
				// Debug.println("desigantions query"+query);
				while (empMasterData.rs1.next()) {
					name = empMasterData.rs1.getString(1);
				}
			} else {
				name = "";
			}
		} catch (Exception e) {
			Debug.println("Ther error in getDesgnName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	// same code with dataSource
	public static String getDesgnName(String code, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = RwsOffices.getConn();
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			String query = "SELECT DESIGNATION_NAME,DESIGNATION_ACR FROM rws_designation_tbl WHERE designation_CODE ='"
					+ code + "' ";
			if (code != null) {
				empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
				// Debug.println("desigantions query"+query);
				while (empMasterData.rs1.next()) {
					name = empMasterData.rs1.getString(1);
				}
			} else {
				name = "";
			}
		} catch (Exception e) {
			Debug.println("Ther error in getDesgnName=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return name;
	}

	public static String getAssetTypeName(String code, Connection conn) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = conn;
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();

			empMasterData.rs1 = empMasterData.stmt1.executeQuery(
					"SELECT TYPE_OF_ASSET_NAME  FROM RWS_ASSET_TYPE_TBL WHERE TYPE_OF_ASSET_CODE  ='" + code + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);

		} catch (Exception e) {
			Debug.println("Ther error in getAssetTypeName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getAssetTypeName(String code, DataSource dataSource) throws Exception {
		// Debug.println("in getAssetTypeName in EmpMasterData");
		EmpMasterData empMasterData = new EmpMasterData();
		// Debug.println("1");
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			// Debug.println("2");
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt1 = empMasterData.conn.createStatement();

			empMasterData.rs1 = empMasterData.stmt1.executeQuery(
					"SELECT TYPE_OF_ASSET_NAME  FROM RWS_ASSET_TYPE_TBL WHERE TYPE_OF_ASSET_CODE  ='" + code + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);

		} catch (Exception e) {
			Debug.println("Ther error in getAssetTypeName=" + e);
		} finally {
			empMasterData.closeAll();

		}
		return name;
	}

	public static String getAssetCompTypeName(String code, String code1, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		if (code1.equals("05") || code1.equals("06") || code1.equals("07") || code1.equals("08"))
			return "SOURCE";

		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1.executeQuery(
					"SELECT ASSET_COMPONENT_NAME  FROM RWS_ASSET_COMPONENT_TYPE_TBL WHERE ASSET_COMPONENT_CODE  ='"
							+ code + "' and type_of_asset_code=" + code1);
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
			// Debug.println("name in getAssetCompTypeName= " + name);

		} catch (Exception e) {
			Debug.println("Ther error in getAssetCompTypeName=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return name;
	}

	public static String getMandalName(String dcode, String mcode, Connection conn) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = conn;
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1.executeQuery(
					"select MNAME from RWS_MANDAL_TBL where DCODE='" + dcode + "' and mcode='" + mcode + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
		} catch (Exception e) {
			Debug.println("Ther error in getMandalName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getPanchayatName(String dcode, String mcode, String pcode, Connection conn) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = conn;
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1.executeQuery("select PNAME from RWS_PANCHAYAT_TBL where DCODE='"
					+ dcode + "' and mcode='" + mcode + "' and PCODE='" + pcode + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
		} catch (Exception e) {
			Debug.println("Ther error in getPanchayatName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getVillageName(String dcode, String mcode, String pcode, String vcode, Connection conn)
			throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = conn;
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1.executeQuery("select VNAME from RWS_VILLAGE_TBL where DCODE='"
					+ dcode + "' and mcode='" + mcode + "' and PCODE='" + pcode + "' and vcode='" + vcode + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
		} catch (Exception e) {
			Debug.println("Ther error in getPanchayatName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getAssetSubCompCode(String assetTypeCode, String assetCompCode, String assetSubName,
			Connection conn) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = conn;
		String code = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		// Debug.println("assetTypeCode=" + assetTypeCode + " assetSubName="+
		// assetSubName + " assetCompCode= " + assetCompCode);
		try {

			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1.executeQuery(
					"SELECT ASSET_SUBCOMPONENT_CODE FROM RWS_ASSET_SUBCOMPONENT_TBL WHERE ASSET_SUBCOMPONENT_NAME=UPPER('"
							+ assetSubName + "') AND TYPE_OF_ASSET_CODE='" + assetTypeCode
							+ "' AND ASSET_COMPONENT_CODE='" + assetCompCode + "'");
			empMasterData.rs1.next();
			code = empMasterData.rs1.getString(1);
			// Debug.println("getAssetSubCompTypeName=" + code);
		} catch (Exception e) {
			Debug.println("The error in getAssetSubCompCode=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return code;
	}

	public static String getAssetSubCompTypeName(String assetSubComp, String assetComp, String assetType,
			Connection conn) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = conn;
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {

			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1.executeQuery(
					"SELECT ASSET_SUBCOMPONENT_NAME FROM RWS_ASSET_SUBCOMPONENT_TBL where type_of_asset_code='"
							+ assetType + "' and asset_component_code='" + assetComp + "' and asset_subcomponent_code='"
							+ assetSubComp + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
		} catch (Exception e) {
			Debug.println("The error in getAssetSubCompTypeName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	// ****************************Lab
	// Methods*******************************************
	public static int insertWQLab(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			ps = empMasterData.conn.prepareStatement("insert into RWS_WATER_QUALITY_LAB_TBL values(?,?,?,?,?)");
			ps.setString(1, empMaster.getLabCode());
			ps.setString(2, empMaster.getLabName().toUpperCase());
			ps.setString(3, empMaster.getLocation().toUpperCase());
			ps.setString(4, empMaster.getHoc() + empMaster.getCoc() + empMaster.getDoc() + empMaster.getSdoc());
			ps.setString(5, empMaster.getDesgnCode());

			rowCount = ps.executeUpdate();
		} catch (Exception e) {
			Debug.println("The error is" + e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static EmpMaster getWQLab(String labCode, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt
					.executeQuery("select * from RWS_WATER_QUALITY_LAB_TBL where LAB_CODE=" + labCode);
			if (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setLabCode(empMasterData.rs.getString(1));
				empMaster.setLabName(empMasterData.rs.getString(2));
				empMaster.setLocation(empMasterData.rs.getString(3));
				empMaster.setDesgnCode(empMasterData.rs.getString(5));

				empMaster.setHoc(empMasterData.rs.getString(4).substring(0, 1));
				// Debug.println("hoc= " + empMaster.getHoc());
				empMaster.setCoc(empMasterData.rs.getString(4).substring(1, 3));
				// Debug.println(empMaster.getCoc());
				empMaster.setDoc(empMasterData.rs.getString(4).substring(3, 4));
				// Debug.println(empMaster.getDoc());
				empMaster.setSdoc(empMasterData.rs.getString(4).substring(4, 6));
				// Debug.println(empMaster.getSdoc());
			}
		} catch (Exception e) {
			Debug.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getWQLabs(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList wqlabs = new ArrayList();
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt.executeQuery("select lab_code,lab_name,location,office_code,"
					+ "DESIGNATION_ACR from RWS_WATER_QUALITY_LAB_TBL wq," + "rws_designation_tbl d where "
					+ "wq.office_head_desgn=d.designation_code " + "order by lab_code,location");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();

				empMaster.setLabCode(empMasterData.rs.getString(1));
				empMaster.setLabName(empMasterData.rs.getString(2));
				empMaster.setLocation(empMasterData.rs.getString(3));
				empMaster.setRoc(empMasterData.rs.getString(4));
				empMaster.setDesgnCode(empMasterData.rs.getString(5));
				// empMaster.setLabName(empMasterData.rs.getString(3)+" -
				// "+empMasterData.rs.getString(2));
				wqlabs.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return wqlabs;
	}

	public static int removeWQLab(String labCode, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			rowCount = empMasterData.stmt
					.executeUpdate("delete FROM RWS_WATER_QUALITY_LAB_TBL where LAB_CODE='" + labCode + "'");

		} catch (Exception e) {
			Debug.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public static void updateWQLab(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		try {
			empMasterData.conn = RwsOffices.getConn();

			ps = empMasterData.conn.prepareStatement(
					"update  RWS_WATER_QUALITY_LAB_TBL set LAB_NAME=?,LOCATION=?,OFFICE_CODE=?,OFFICE_HEAD_DESGN=? where LAB_CODE=?");

			ps.setString(1, empMaster.getLabName().toUpperCase());
			ps.setString(2, empMaster.getLocation().toUpperCase());
			ps.setString(3, empMaster.getHoc() + empMaster.getCoc() + empMaster.getDoc() + empMaster.getSdoc());
			ps.setString(5, empMaster.getLabCode());
			ps.setString(4, empMaster.getDesgnCode());
			ps.executeUpdate();
		} catch (Exception e) {
			Debug.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
	}

	public static String getLabCode(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		String code = null;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt.executeQuery("SELECT MAX(LAB_CODE)+1 FROM RWS_WATER_QUALITY_LAB_TBL");
			empMasterData.rs.next();
			code = empMasterData.rs.getString(1);
			if (code == null) {
				code = "01";
			} else if (code.length() == 1) {
				code = "0" + code;
			}
		} catch (Exception e) {
			Debug.println("Ther error in getTestCode" + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	public static String getWaterTestName(String code, Connection conn) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = conn;
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT test_name FROM RWS_WATER_QUALITY_TEST_TBL WHERE test_code ='" + code + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);
		} catch (Exception e) {
			Debug.println("Ther error in getWaterTestName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getEmpName(String code, Connection conn) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = conn;
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			// Debug.println("getEmpName=" + code);
			empMasterData.stmt1 = empMasterData.conn.createStatement();

			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT EMPLOYEE_NAME  FROM rws_EMPLOYEE_tbl WHERE EMPLOYEE_CODE  ='" + code + "'");
			empMasterData.rs1.next();
			name = empMasterData.rs1.getString(1);

		} catch (Exception e) {
			Debug.println("Ther error in getEmpName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getTestName(String code, Connection conn) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = conn;
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			// Debug.println("getTestName=" + code);
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			String query = "SELECT TEST_NAME FROM RWS_WATER_QUALITY_TEST_TBL WHERE TEST_CODE='" + code + "' ";
			empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
			// Debug.println("get test name"+query);
			while (empMasterData.rs1.next()) {
				name = empMasterData.rs1.getString(1);
			}

		} catch (Exception e) {
			Debug.println("Ther error in getTestName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static String getLabName(String code, Connection conn) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = conn;
		String name = "";
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		String query = null;
		try {
			Debug.println(" inside the getLabName() " + code);
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			query = "SELECT LAB_NAME  FROM RWS_WATER_QUALITY_LAB_TBL WHERE LAB_CODE  ='" + code + "' ";
			empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
			Debug.println("GetLabName Query" + query);
			while (empMasterData.rs1.next()) {
				name = empMasterData.rs1.getString(1);
			}

		} catch (Exception e) {
			Debug.println("Ther error in getLabName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return name;
	}

	public static ArrayList getAssetSubCompNames(String assetTypeCode, String assetCompCode, DataSource dataSource)
			throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		ArrayList assetSubCompNames = new ArrayList();
		EmpMaster empMaster;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1.executeQuery(
					"SELECT ASSET_SUBCOMPONENT_NAME  FROM RWS_ASSET_SUBCOMPONENT_TBL WHERE ASSET_COMPONENT_CODE  ='"
							+ assetCompCode + "' and type_of_asset_code='" + assetTypeCode + "'");
			while (empMasterData.rs1.next()) {
				empMaster = new EmpMaster();
				empMaster.setAssetSubCompTypeName(empMasterData.rs1.getString(1));
				assetSubCompNames.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println("Ther error in getAssetCompTypeName=" + e);
		} finally {
			empMasterData.closeAll();

		}
		return assetSubCompNames;
	}

	public static String getTestId(String test, String labCode, String yr, Connection conn) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = conn;
		String name = null;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			Debug.println("  year=" + yr);
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			if (test.equals("sample")) {
				empMasterData.rs1 = empMasterData.stmt1.executeQuery(
						"select max(substr(test_id,3,4)),max(to_number(substr(test_id,7,10))) from rws_water_sample_collect_tbl where substr(test_id,1,2)='"
								+ labCode + "'");
			} else if (test.equals("test")) {
				empMasterData.rs1 = empMasterData.stmt1.executeQuery(
						"select max(substr(test_id,3,4)),max(to_number(substr(test_id,7,10))) from RWS_WQ_TEST_RESULTS_TBL where substr(test_id,1,2)='"
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
			Debug.println("Ther error in getLabName=" + e);
		} finally {
			empMasterData.stmt1.close();
		}
		return (labCode + yr + name);
	}

	public static ArrayList getTestParameterCodes(DataSource dataSource, String testCode) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList parameters = new ArrayList();
		Debug.println("The testCode is-----------------" + testCode);
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt.executeQuery(
					"SELECT * FROM RWS_WQ_PARA_TEST_TBL WHERE TEST_CODE in (select test_code from RWS_WATER_QUALITY_TEST_TBL where test_name='"
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
			Debug.println("Imam:  " + e);
		} finally {
			empMasterData.closeAll();
		}
		return parameters;
	}

	public static ArrayList getHabitations(String dcode, String mcode, String pcode, String vcode,
			DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		ArrayList habs = new ArrayList();
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt.executeQuery("SELECT HAB_CODE,HNAME FROM RWS_HABMAST_TBL WHERE"
					+ " SUBSTR(HAB_CODE,1,2)='" + dcode + "' AND SUBSTR(HAB_CODE,6,2)='" + mcode + "' AND "
					+ "SUBSTR(HAB_CODE,13,2)='" + pcode + "' AND SUBSTR(HAB_CODE,8,3)='" + vcode + "'");

			while (empMasterData.rs.next()) {
				// rwsLocation.setHabCode(empMasterData.rs.getString("HAB_CODE"));
				empMaster = new EmpMaster();
				empMaster.setHabCode(empMasterData.rs.getString(1));
				empMaster.setHabName(empMasterData.rs.getString(2));
				empMaster.setHabitationCode(empMasterData.rs.getString(1) + " - " + empMasterData.rs.getString(2));
				habs.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println("The error in EmpMasterData getHabitations=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return habs;
	}

	public static ArrayList getPRHabitations(String habCode, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		ArrayList habs = new ArrayList();
		EmpMaster empMaster = null;
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			Debug.println("habcode in getprhabs= " + habCode);
			empMasterData.rs = empMasterData.stmt
					.executeQuery("SELECT PANCH_CODE,PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL WHERE" + " HAB_CODE='"
							+ habCode + "' order by panch_code");

			while (empMasterData.rs.next()) {

				empMaster = new EmpMaster();
				empMaster.setHabitation(empMasterData.rs.getString(1));
				empMaster.setHabCode(empMasterData.rs.getString(1));
				empMaster.setHabName(empMasterData.rs.getString(2));
				habs.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println("The error in EmpMasterData getPRHabitations=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return habs;
	}

	public static String getMaxPrHab(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		String code = null;
		try {
			empMasterData.conn = RwsOffices.getConn();

			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt
					.executeQuery("SELECT MAX(to_number(PANCH_CODE))+1 FROM RWS_PANCHAYAT_RAJ_TBL");
			empMasterData.rs.next();
			code = empMasterData.rs.getString(1);
		} catch (Exception e) {
			Debug.println("The error in getMaxPrHab" + e);
		} finally {
			empMasterData.closeAll();
		}
		return code;
	}

	// create the link between mandal and subdivision
	public static int insertMandalSubDivision(EmpMaster empMaster, DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			if (getMandalSubDivisionCount(empMaster.getCoc(), empMaster.getDoc(), empMaster.getSdoc(),
					empMaster.getDistrict(), empMaster.getMandal(), "", empMasterData.conn) != 1) {
				empMasterData.stmt = empMasterData.conn.createStatement();
				rowCount = empMasterData.stmt.executeUpdate("insert into rws_mandal_subdivision_tbl values(" + "'"
						+ empMaster.getCoc() + "'," + "'" + empMaster.getDoc() + "'," + "'" + empMaster.getSdoc() + "',"
						+ "'" + empMaster.getDistrict() + "'," + "'" + empMaster.getMandal() + "')");
			} else
				errorMessage = "This Mandal Already Mapped To Another Sub Division";
		} catch (Exception e) {
			Debug.println("The error in insertMandalSubDivision" + e);
		} finally {
			empMasterData.closeAll();
		}
		Debug.println("row count in save=" + rowCount);
		return rowCount;
	}

	public static ArrayList getMandalSubDivisions(DataSource dataSource, String dcode) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList mandalSubdivisions = new ArrayList();

		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			if (dcode == null)
				empMasterData.rs = empMasterData.stmt
						.executeQuery("SELECT CO.CIRCLE_OFFICE_CODE,CO.CIRCLE_OFFICE_NAME,DO.DIVISION_OFFICE_CODE,"
								+ "DO.DIVISION_OFFICE_NAME,SDO.SUBDIVISION_OFFICE_CODE,SDO.SUBDIVISION_OFFICE_NAME,"
								+ "D.DCODE,D.DNAME,M.MCODE,M.MNAME FROM RWS_CIRCLE_OFFICE_TBL CO,RWS_DIVISION_OFFICE_TBL DO,"
								+ "RWS_SUBDIVISION_OFFICE_TBL SDO,RWS_DISTRICT_TBL D,RWS_MANDAL_TBL M,RWS_MANDAL_SUBDIVISION_TBL MS WHERE CO.CIRCLE_OFFICE_CODE=MS.CIRCLE_OFFICE_CODE AND CO.HEAD_OFFICE_CODE=1 AND DO.DIVISION_OFFICE_CODE=MS.DIVISION_OFFICE_CODE AND DO.CIRCLE_OFFICE_CODE=MS.CIRCLE_OFFICE_CODE AND SDO.SUBDIVISION_OFFICE_CODE=MS.SUBDIVISION_OFFICE_CODE AND SDO.CIRCLE_OFFICE_CODE=MS.CIRCLE_OFFICE_CODE AND SDO.DIVISION_OFFICE_CODE=MS.DIVISION_OFFICE_CODE AND D.DCODE=MS.DCODE AND M.MCODE=MS.MCODE AND M.DCODE=MS.DCODE ORDER BY MS.CIRCLE_OFFICE_CODE");
			else
				empMasterData.rs = empMasterData.stmt
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
			Debug.println("THE ERROR IS IN getMandalSubDivisions=" + e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return mandalSubdivisions;
	}

	public static EmpMaster getMandalSubdivision(String coc, String doc, String sdoc, String dcode, String mcode,
			DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		String query = null;
		try {
			empMasterData.conn = RwsOffices.getConn();
			// empMasterData.stmt = empMasterData.conn.createStatement();

			query = "SELECT CO.CIRCLE_OFFICE_CODE,CO.CIRCLE_OFFICE_NAME,DO.DIVISION_OFFICE_CODE,"
					+ "DO.DIVISION_OFFICE_NAME,SDO.SUBDIVISION_OFFICE_CODE,SDO.SUBDIVISION_OFFICE_NAME,"
					+ "D.DCODE,D.DNAME,M.MCODE,M.MNAME FROM RWS_CIRCLE_OFFICE_TBL CO,RWS_DIVISION_OFFICE_TBL DO,"
					+ "RWS_SUBDIVISION_OFFICE_TBL SDO,RWS_DISTRICT_TBL D,RWS_MANDAL_TBL M,"
					+ "RWS_MANDAL_SUBDIVISION_TBL MS WHERE CO.CIRCLE_OFFICE_CODE=?"
					+ " AND CO.HEAD_OFFICE_CODE=1 AND DO.DIVISION_OFFICE_CODE=? AND DO.CIRCLE_OFFICE_CODE=? "
					+ "AND SDO.SUBDIVISION_OFFICE_CODE=? AND SDO.CIRCLE_OFFICE_CODE=? AND "
					+ "SDO.DIVISION_OFFICE_CODE=? AND D.DCODE=? AND M.MCODE=? AND M.DCODE=?";
			ps = empMasterData.conn.prepareStatement(query);
			ps.setString(1, coc);
			ps.setString(2, doc);
			ps.setString(3, coc);
			ps.setString(4, sdoc);
			ps.setString(5, coc);
			ps.setString(6, doc);
			ps.setString(7, dcode);
			ps.setString(8, mcode);
			ps.setString(9, dcode);
			// Debug.println("query is "+query);

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
			Debug.println("the error is in getSubDetailHead=" + e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return empMaster;
	}

	public static ArrayList getsubdivisionmandals(String coc, String doc, String sdoc, DataSource dataSource)
			throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList mandalsub = new ArrayList();
		// Debug.println("coc=" + coc + "doc=" + doc + "sdoc=" + sdoc);
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			String query = "select M.MCODE,M.MNAME FROM RWS_MANDAL_SUBDIVISION_TBL MS,RWS_MANDAL_TBL M WHERE MS.CIRCLE_OFFICE_CODE='"
					+ coc + "' AND MS.DCODE='" + coc + "' AND MS.DIVISION_OFFICE_CODE='" + doc
					+ "' AND MS.SUBDIVISION_OFFICE_CODE='" + sdoc + "' AND M.MCODE=MS.MCODE AND M.DCODE='" + coc
					+ "' ORDER BY M.MNAME";

			empMasterData.rs = empMasterData.stmt.executeQuery(query);
			// Debug.println("query in getsubdivisionmandals "+query);
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setMandalCode(empMasterData.rs.getString(1));
				empMaster.setMandalName(empMasterData.rs.getString(2));
				mandalsub.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println("the error is in getsubdivisionmandal=" + e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return mandalsub;
	}

	public static int updateMandalSubDivision(String mcode, String sdoc, String doc, String coc, EmpMaster empMaster,
			DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int ans = 0;
		Debug.println("old mcode=" + mcode + "new mcode=" + empMaster.getMandalCode() + "dcode="
				+ empMaster.getDistrict() + "new sdoc=" + empMaster.getSdoc() + "old sdoc=" + sdoc + "doc="
				+ empMaster.getDoc() + "old doc=" + doc + "coc=" + empMaster.getCoc() + "old coc=" + coc + "docde="
				+ empMaster.getDistrict() + "oldcode=" + coc);
		try {
			empMasterData.conn = RwsOffices.getConn();
			if (getMandalSubDivisionCount(empMaster.getCoc(), empMaster.getDoc(), empMaster.getSdoc(),
					empMaster.getDistrict(), empMaster.getMandalCode(), mcode, empMasterData.conn) != 1) {
				if (mcode.equals(empMaster.getMandalCode())) {
					ps = empMasterData.conn.prepareStatement(
							"update RWS_MANDAL_SUBDIVISION_TBL set SUBDIVISION_OFFICE_CODE =? where MCODE =? and DCODE=?  and SUBDIVISION_OFFICE_CODE =? and DIVISION_OFFICE_CODE=? and CIRCLE_OFFICE_CODE=?");
					ps.setString(1, empMaster.getSdoc());
					ps.setString(2, mcode);
					ps.setString(3, empMaster.getDistrict());
					ps.setString(4, sdoc);
					ps.setString(5, empMaster.getDoc());
					ps.setString(6, empMaster.getCoc());
				} else {
					ps = empMasterData.conn.prepareStatement(
							"update  RWS_MANDAL_SUBDIVISION_TBL set SUBDIVISION_OFFICE_CODE =?,MCODE =?,DIVISION_OFFICE_CODE=?,CIRCLE_OFFICE_CODE=?,DCODE=? where MCODE =? and DCODE=?  and SUBDIVISION_OFFICE_CODE =? and DIVISION_OFFICE_CODE=? and CIRCLE_OFFICE_CODE=?");
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
				// Debug.println("ans=" + ans);
			} else
				errorMessage = "This Mandal Already Mapped To Another Sub Division";
		} catch (SQLException sqle) {
			Debug.println("Exception is:" + sqle.getMessage());
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			Debug.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		Debug.println("ans=" + ans);
		return ans;
	}

	public static int getMandalSubDivisionCount(String coc, String doc, String sdoc, String dcode, String mcode,
			String mandal, Connection conn) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = conn;

		int c = 0;
		try {
			if (mcode.equals(mandal))
				return c;
			else {
				empMasterData.stmt = empMasterData.conn.createStatement();
				empMasterData.rs = empMasterData.stmt.executeQuery(
						"select count(SUBDIVISION_OFFICE_CODE) from RWS_MANDAL_SUBDIVISION_TBL where CIRCLE_OFFICE_CODE='"
								+ coc + "' and DIVISION_OFFICE_CODE='" + doc + "' and DCODE='" + dcode + "' and MCODE='"
								+ mcode + "'");
				empMasterData.rs.next();
				c = empMasterData.rs.getInt(1);
			}
		} catch (Exception e) {
			Debug.println("Exception in getmandalsubdivision count=" + e.getMessage());

		} finally {
			empMasterData.stmt.close();
		}
		Debug.println("count=" + c);
		return c;
	}

	public static int removeMandalSubDivision(String coc, String doc, String sdoc, String dcode, String mcode,
			DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		int rowCount = 0;
		try {
			empMasterData.conn = RwsOffices.getConn();
			// empMasterData.stmt = empMasterData.conn.createStatement();
			String query = "delete  from RWS_MANDAL_SUBDIVISION_TBL  where CIRCLE_OFFICE_CODE=? and DIVISION_OFFICE_CODE= ?"
					+ " and SUBDIVISION_OFFICE_CODE=?  and DCODE=?  and MCODE=?";
			rowCount = empMasterData.stmt
					.executeUpdate("delete  from RWS_MANDAL_SUBDIVISION_TBL  where CIRCLE_OFFICE_CODE='" + coc
							+ "' and DIVISION_OFFICE_CODE='" + doc + "' and SUBDIVISION_OFFICE_CODE='" + sdoc
							+ "' and DCODE='" + dcode + "' and MCODE='" + mcode + "'");
			ps = empMasterData.conn.prepareStatement(query);
			ps.setString(1, coc);
			ps.setString(2, doc);
			ps.setString(3, sdoc);
			ps.setString(4, dcode);
			ps.setString(5, mcode);
			rowCount = ps.executeUpdate();
		} catch (Exception e) {
			Debug.println(e.getMessage());
		} finally {
			empMasterData.closeAll();
		}
		return rowCount;
	}

	public int getAssetCount(String tabName, String typeOfAssetCode, String habCode, String assetCode)
			throws Exception {

		int count = 0;
		String query = "";
		try {
			query = "SELECT count(*)COUNT FROM rws_asset_mast_tbl A,rws_asset_scheme_tbl S ," + tabName
					+ " g WHERE A.asset_code = S.asset_code  AND type_of_asset_code='" + typeOfAssetCode + "'"
					+ " and g.asset_code=A.asset_code and g.asset_code='" + assetCode + "'";
			Debug.println("query in counts of " + query);
			stmt = conn.createStatement();
			rs1 = stmt.executeQuery(query);
			if (rs1.next()) {
				count = rs1.getInt("COUNT");
				// Debug.println("count is "+count);
			}
		} catch (Exception e) {
			Debug.println("Error=" + e);
		} finally {
			// closeAll();
		}
		return count;

	}

	public int getAssetCount(String tabName, String typeOfAssetCode, String habCode) throws Exception {

		int count = 0;
		String query = "";
		try {
			query = "SELECT count(*)COUNT FROM rws_asset_mast_tbl A,rws_asset_scheme_tbl S ," + tabName
					+ " g WHERE A.asset_code = S.asset_code  AND type_of_asset_code='" + typeOfAssetCode + "'"
					+ " and g.asset_code=A.asset_code and g.asset_code='";

			// Debug.println("query in counts of " + query);
			stmt = conn.createStatement();
			rs1 = stmt.executeQuery(query);
			if (rs1.next())
				count = rs1.getInt("COUNT");
		} catch (Exception e) {
			Debug.println("Error=" + e);
		} finally {
			// closeAll();
		}
		return count;

	}

	public static ArrayList getHoffice(DataSource datasource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		ArrayList office = null;
		try {
			office = new ArrayList();
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt.executeQuery("select distinct office from rws_head_of_office_tbl");
			EmpMaster empMaster = null;
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setOffice(empMasterData.rs.getString(1));
				office.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println("error in getOffice=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return office;
	}

	public static ArrayList getHoffices(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		EmpMaster empMaster = null;
		ArrayList hoffices = new ArrayList();
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt.executeQuery(
					"select h.office,d.designation_acr from rws_head_of_office_tbl h,rws_designation_tbl d where h.designation_code=d.designation_code");
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setOffice(empMasterData.rs.getString(1));
				empMaster.setDesignation(empMasterData.rs.getString(2));
				hoffices.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println("The error in getContams" + e);
		} finally {
			empMasterData.closeAll();
		}
		return hoffices;
	}

	public static ArrayList getDesignation(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		// String acode=null;
		ArrayList designation = null;
		try {
			designation = new ArrayList();
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt.executeQuery(
					"SELECT designation_code, DESIGNATION_ACR FROM RWS_DESIGNATION_TBL ORDER BY DESIGNATION_NAME");
			EmpMaster empMaster = null;
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setDesgnCode(empMasterData.rs.getString(1));
				empMaster.setDesgnName(empMasterData.rs.getString(2));
				designation.add(empMaster);
			}

			// acode=empMasterData.rs.getString(1);
		} catch (Exception e) {
			Debug.println("The error in getDesignation=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return designation;
	}

	public static ArrayList getOffice(DataSource datasource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		ArrayList office = null;
		try {
			office = new ArrayList();
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt.executeQuery("select distinct office from rws_est_ts_work_value_tbl");
			EmpMaster empMaster = null;
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setOffice(empMasterData.rs.getString(1));
				office.add(empMaster);
			}
		} catch (Exception e) {
			Debug.println("error in getOffice=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return office;
	}

	public static ArrayList getFromDates(DataSource dataSource) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		String query;
		ArrayList fromDate = new ArrayList();
		try {
			// query = "select distinct to_char(access_date,'DD/MM/yy') from rws_log_tbl
			// order by to_char(access_date,'DD/MM/yy') desc";
			query = "select distinct to_char(access_date,'DD/MM/yy') as a1 from rws_log_tbl order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";

			Debug.println("query is " + query);
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt.executeQuery(query);
			EmpMaster empMaster = null;
			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setFromDate(empMasterData.rs.getString(1));
				// Debug.println("EmpMaster fromDate"+ empMaster.getFromDate());
				fromDate.add(empMaster);
			}
			empMasterData.conn.close();
		} catch (Exception e) {
			Debug.println("Exception in GetDate in EmpMaster :" + e);
		}

		return fromDate;
	}

	public static ArrayList getToDates(String fromDate, DataSource dataSource) {
		String query;
		ArrayList toDate = new ArrayList();
		EmpMasterData empMasterData = new EmpMasterData();
		// Debug.println("started getToDates in EmpMasterData before try");
		try {
			// Debug.println("started getToDates in EmpMasterData try started");

			query = // "select distinct to_char(access_date,'DD/MM/yy') from rws_log_tbl where
					// to_date(ACCESS_DATE,'dd/mm/yy') >= to_Date('"
					// + fromDate + "','dd/mm/yy') order by to_char(access_date,'DD/MM/yy') desc";

					query = "select distinct to_char(access_date,'DD/MM/yy') as a1 from rws_log_tbl where to_date(ACCESS_DATE,'dd/mm/yy') >= to_Date('"
							+ fromDate
							+ "','dd/mm/yy')  order by substr(a1,7,8) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";

			// Debug.println("query is "+query);
			/*
			 * query="select unique(to_char(access_date,'dd/mm/yyyy')) from rws_log_tbl
			 * where to_date(ACCESS_DATE,'dd/mon/yyyy') >=
			 * to_Date('"+fromDate+"','dd/mm/yyyy')";
			 */

			/*
			 * query="select unique(to_Char(access_date,'dd/mm/yy')) from rws_log_tbl where
			 * to_Date(ACCESS_DATE,'dd/mon/yyyy') >= to_Date('"+fromDate+"','dd/mm/yyyy')";
			 */

			// Debug.println("empMasterData.conn: "+empMasterData.conn);
			empMasterData.conn = RwsOffices.getConn();
			// Debug.println("empMasterData.conn" + empMasterData.conn);
			empMasterData.stmt = empMasterData.conn.createStatement();
			empMasterData.rs = empMasterData.stmt.executeQuery(query);
			EmpMaster empMaster = null;
			// Debug.println("empMasterData.rs.next() :"+empMasterData.rs.next());

			while (empMasterData.rs.next()) {
				empMaster = new EmpMaster();
				empMaster.setToDate(empMasterData.rs.getString(1));
				// Debug.println("EmpMaster toDate" + empMaster.getToDate());
				toDate.add(empMaster);
			}
			empMasterData.conn.close();
		} catch (Exception e) {
			Debug.println("Exception in getToDates in EmpMasterData :" + e);
		}
		return toDate;
	}

	static public String getNextNewSlNo(DataSource dataSource, String tableName, String schemeCodeField, String habCode,
			String shortSchemeCode) {
		String slNo = null;
		String code = null;
		EmpMasterData empMasterData = new EmpMasterData();
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			// String query="select max(to_number(substr("+schemeCodeField+",22,3)))+1 from
			// "+tableName+" where hab_code="+habCode+" and substr(13,3)="+shortSchemeCode;
			String query = "SELECT MAX(to_number(substr(" + schemeCodeField + ",22,3)))+1 FROM " + tableName
					+ " where substr(" + schemeCodeField + ",1,16)='" + habCode + "' and substr(" + schemeCodeField
					+ ",17,3)='" + shortSchemeCode + "'";

			// Debug.println("query is "+query);
			empMasterData.rs = empMasterData.stmt.executeQuery(query);
			if (empMasterData.rs.next())
				slNo = empMasterData.rs.getInt(1) + "";
			if (slNo == null || slNo.equals("0") || slNo.equals("")) {
				slNo = "001";
			} else if (slNo.length() == 1) {
				slNo = "00" + slNo;
			} else if (slNo.length() == 2) {
				slNo = "0" + slNo;
			}

		} catch (Exception e) {
			Debug.println("Exception in getNextNewSlNo" + e);
		}

		finally {
			try {
				empMasterData.closeAll();
			} catch (Exception e) {
				Debug.println("Exception in closing connections");
			}

		}
		return slNo;
	}

	static public int insertNextSchemeCode(DataSource dataSource, String tableName, String schemeCodeField,
			String nextSchemeCode, String assetCode) {
		int count = 0;
		String query;
		EmpMasterData empMasterData = new EmpMasterData();
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.stmt = empMasterData.conn.createStatement();
			query = "insert into " + tableName + "(" + schemeCodeField + ",asset_code,hab_code) values('"
					+ nextSchemeCode + "','" + assetCode + "','" + nextSchemeCode.substring(0, 16) + "')";
			// Debug.println("query is "+query);
			count = empMasterData.stmt.executeUpdate(query);
			empMasterData.closeAll();
			return count;

		} catch (Exception e) {
			Debug.println("Exception in insertNextSchemeCode in EmpMasterData " + e);
		}

		return count;

	}

	static public String format(String val) {
		if (val == null || val.equals("null"))
			val = "";
		return val;
	}

	// @ocde added on 261206

	/*
	 * static public boolean insertHabLink(DataSource dataSource,String
	 * habLinkTable,ArrayList assetReservoirList,String subCompTypeCode) throws
	 * Exception {
	 * 
	 * String query=null; int[] rowCount; boolean isInserted=true; String
	 * schemeCode=null; ArrayList checkedHabs;
	 * 
	 * EmpMasterData empMasterData=new EmpMasterData(); try{ empMasterData.conn =
	 * RwsOffices.getConn(); empMasterData.conn.setAutoCommit(false);
	 * empMasterData.stmt = empMasterData.conn.createStatement(); for(int
	 * j=0;j<assetReservoirList.size();j++) {
	 * Debug.println("in assetReservoirList["+j+"] in EmpMasterData");
	 * checkedHabs=(((Asset_Reservior)assetReservoirList.get(j)).getSelectedHabLinks
	 * ()); if(subCompTypeCode.equals("001")) {
	 * 
	 * schemeCode=(((Asset_Reservior)assetReservoirList.get(j)).getOhsrCode()); }
	 * else if(subCompTypeCode.equals("003"))
	 * schemeCode=(((Asset_Reservior)assetReservoirList.get(j)).getGlsrCode()); else
	 * if(subCompTypeCode.equals("006"))
	 * schemeCode=(((Asset_Reservior)assetReservoirList.get(j)).getCisCode());
	 * Debug.println("scheme code in process is "+schemeCode); query =
	 * "DELETE FROM  "+habLinkTable+" where SUBCOMP_CODE='" + schemeCode + "'";
	 * empMasterData.stmt.addBatch(query); Debug.println("query is "+query); if
	 * (checkedHabs != null) {
	 * Debug.println("checkedHabs.length is "+checkedHabs.size()); for (int i = 0; i
	 * < checkedHabs.size(); i++) { Debug.println("1"); HabSourceBean habSourceBean
	 * = (HabSourceBean) checkedHabs.get(i); Debug.println("2");
	 * //Debug.println("habSourceBean.getHabCode()= " + habSourceBean.getHabCode());
	 * 
	 * if (habSourceBean.getIsChecked().equals("true")) { query =
	 * " INSERT INTO "+habLinkTable+"(SUBCOMP_CODE,HAB_CODE)  VALUES(" + "'" +
	 * schemeCode + "','" + habSourceBean.getPanchRajCode().substring(0, 16) + "')";
	 * //Debug .println(i + ": Hab Source Query is " + query);
	 * Debug.println("query3["+i+"] is "+query); empMasterData.stmt.addBatch(query);
	 * }//end of if
	 * 
	 * 
	 * 
	 * }//end of for }//end of if }//end of for rowCount =
	 * empMasterData.stmt.executeBatch();
	 * 
	 * for (int j = 0; j < rowCount.length; j++) { if (rowCount[j] == 0) isInserted
	 * = false; }
	 * 
	 * if (isInserted) empMasterData.conn.commit();
	 * empMasterData.conn.setAutoCommit(true); } catch (Exception e) {
	 * Debug.println("The error in insertSource= " + e); isInserted=false; } finally
	 * { empMasterData.closeAll(); } return isInserted; }
	 */

	static public boolean insertHabLink2(DataSource dataSource, String habLinkTable, ArrayList checkedHabs,
			String schemeCode) throws Exception {

		String query = null;
		int[] rowCount;
		boolean isInserted = true;

		Debug.println("in insertHabLink2 in EmpMasterData");
		EmpMasterData empMasterData = new EmpMasterData();
		try {
			empMasterData.conn = RwsOffices.getConn();
			empMasterData.conn.setAutoCommit(false);
			empMasterData.stmt = empMasterData.conn.createStatement();

			if (checkedHabs != null) {
				Debug.println("checkedHabs.length is " + checkedHabs.size());
				query = "DELETE FROM  " + habLinkTable + " where SUBCOMP_CODE='" + schemeCode + "'";
				empMasterData.stmt.addBatch(query);
				Debug.println("query is " + query);

				for (int i = 0; i < checkedHabs.size(); i++) {
					HabSourceBean habSourceBean = (HabSourceBean) checkedHabs.get(i);
					// Debug.println("habSourceBean.getHabCode()= " + habSourceBean.getHabCode());

					if (habSourceBean.getIsChecked().equals("true")) {
						query = " INSERT INTO " + habLinkTable + "(SUBCOMP_CODE,HAB_CODE)  VALUES(" + "'" + schemeCode
								+ "','" + habSourceBean.getPanchRajCode().substring(0, 16) + "')";
						// Debug .println(i + ": Hab Source Query is " + query);
						Debug.println("query3[" + i + "] is " + query);
						empMasterData.stmt.addBatch(query);
					} // end of if

				} // end of for
			} // end of if

			rowCount = empMasterData.stmt.executeBatch();

			for (int j = 0; j < rowCount.length; j++) {
				if (rowCount[j] == 0)
					isInserted = false;
			}

			if (isInserted)
				empMasterData.conn.commit();
			empMasterData.conn.setAutoCommit(true);
		} catch (Exception e) {
			Debug.println("The error in insertSource= " + e);
			isInserted = false;
		} finally {
			empMasterData.closeAll();
		}
		return isInserted;
	}

	public static String getHabName(DataSource dataSource, String habCode) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		String name = null;
		empMasterData.conn = RwsOffices.getConn();
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;
		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			empMasterData.rs1 = empMasterData.stmt1
					.executeQuery("SELECT PANCH_NAME FROM rws_panchayat_raj_tbl WHERE panch_code ='" + habCode + "'");
			while (empMasterData.rs1.next()) {
				name = empMasterData.rs1.getString(1);

			}
		} catch (Exception e) {
			Debug.println("The error in getHabName=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return name;
	}

	public static String getDcode(DataSource dataSource, String dname) throws Exception {
		EmpMasterData empMasterData = new EmpMasterData();
		Debug.println("in getDcode");
		String name = null;
		empMasterData.conn = RwsOffices.getConn();
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;

		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			String query = "select dcode from rws_district_tbl where dname='" + dname + "'";
			Debug.println("query in getDcode is " + query);
			empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
			while (empMasterData.rs1.next()) {
				name = empMasterData.rs1.getString(1);

			}
		} catch (Exception e) {
			Debug.println("The error in getHabName=" + e);
		} finally {
			empMasterData.closeAll();
		}
		return name;
	}

	public static int getSourceHabitationsCount(Connection conn, String sourceCode) throws Exception {
		Debug.println("in getSourceHabitationsCount");
		int count = 0;
		EmpMasterData empMasterData = new EmpMasterData();
		empMasterData.conn = conn;
		empMasterData.stmt1 = null;
		empMasterData.rs1 = null;

		try {
			empMasterData.stmt1 = empMasterData.conn.createStatement();
			String query = "select count(SOURCE_CODE) from RWS_SOURCE_HABITATION_TBL where SOURCE_CODE='" + sourceCode
					+ "'";
			Debug.println("count query in getSourceHabitationsCount is " + query);
			empMasterData.rs1 = empMasterData.stmt1.executeQuery(query);
			if (empMasterData.rs1.next()) {
				count = empMasterData.rs1.getInt(1);

			}
			Debug.println("query in getDcode is " + query);
		} catch (Exception e) {
			Debug.println("exception in getSourceHabitaionsCount is " + e);
		}
		return count;

	}
}
