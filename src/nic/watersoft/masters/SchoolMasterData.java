package nic.watersoft.masters;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;

/* @author Vikas
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates*/

public class SchoolMasterData {

	public static int connCount = 0;
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

	static SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");

	public static String errorMessage;

	// static HttpSession session;

	public SchoolMasterData() {
		connCount++;
		// Debug.println("RwsMasterData Object Created");
		// Debug.println("connCount from RwsMasterData() is"+connCount);

	}

	public void closeAll() throws Exception {
		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				Debug.println("The error in rwsMasterData" + e);
			}
			rs = null;
		}
		if (rs1 != null) {
			try {
				rs1.close();
			} catch (Exception e) {
				Debug.println("The error in rwsMasterData" + e);
			}
			rs1 = null;
		}
		if (rs2 != null) {
			try {
				rs2.close();
			} catch (Exception e) {
				Debug.println("The error in rwsMasterData" + e);
			}
			rs2 = null;
		}
		if (rs3 != null) {
			try {
				rs3.close();
			} catch (Exception e) {
				Debug.println("The error in rwsMasterData" + e);
			}
			rs3 = null;
		}
		if (rs4 != null) {
			try {
				rs4.close();
			} catch (Exception e) {
				Debug.println("The error in rwsMasterData" + e);
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
		if (stmt1 != null) {
			try {
				stmt1.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt1 = null;
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
		if (conn != null) {
			try {

				// Debug.println("closing connection");
				conn.close();
				if (conn.isClosed())
					connCount--;
				// Debug.println("ConnCount is "+connCount);
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			conn = null;
		}

	}

	public int Save(DataSource dataSource, SchoolForm frm) throws Exception {
		int a = 0;
		SchoolMasterData sch = new SchoolMasterData();
		String query2 = null;
		String query3 = null, query4 = null;
		String insertDate = "";
		PreparedStatement ps = null, ps1 = null, ps2 = null;
		try {
			sch.conn = RwsOffices.getConn();

			sch.stmt3 = sch.conn.createStatement();
			query4 = "select to_char(sysdate,'dd-MON-yyyy') from dual";
			sch.rs4 = sch.stmt3.executeQuery(query4);
			if (sch.rs4.next()) {
				insertDate = sch.rs4.getString(1);
			}

			query3 = "select * from rws_school_master_tbl where hab_code=?  and school_name=? and NO_OF_STUDENTS=? ";
			ps = sch.conn.prepareStatement(query3);
			ps.setString(1, frm.getHabitation());
			ps.setString(2, frm.getSchoolName());
			ps.setString(3, frm.getNoStudents());
			sch.rs2 = ps.executeQuery();

			if (sch.rs2.isBeforeFirst()) {
				if (sch.rs2.next()) {
					a = 2;
				}
			} else {

				query2 = "select max(school_code)+1 from rws_school_master_tbl where hab_code=? ";

				ps1 = sch.conn.prepareStatement(query2);
				ps1.setString(1, frm.getHabitation());
				sch.rs1 = ps1.executeQuery();

				String scode = "";
				String temp = "";
				if (sch.rs1.next()) {
					temp = sch.rs1.getString(1);
					if (temp != null && temp.length() != 0) {
						if (temp.length() == 1) {
							scode = "00" + temp;
						} else if (temp.length() == 2) {
							scode = "0" + temp;
						} else {
							scode = temp;
						}
					} else {
						scode = "001";
					}
				}

				String query = "insert into rws_school_master_tbl  VALUES "
						+ "(?,?,?,?,?,?,?,?,nvl(?,''),nvl(?,''),nvl(?,''),nvl(?,''),nvl(?,''),nvl(?,''),nvl(?,''),nvl(?,''),'','',nvl(?,''),nvl(?,''),sysdate,nvl(?,'0'),nvl(?,'0'),nvl(?,'0'),"
						+ "nvl(?,'0'),nvl(?,''),nvl(?,''),to_date(?,'dd/mm/yyyy'),to_date(?,'dd/mm/yyyy'),nvl(?,'-'))";

				ps2 = sch.conn.prepareStatement(query);
				ps2.setString(1, frm.getHabitation());
				ps2.setString(2, scode);
				ps2.setString(3, frm.getSchoolName());
				ps2.setString(4, frm.getHabitation());
				ps2.setString(5, frm.getCategory());
				ps2.setString(6, frm.getClassify());
				ps2.setString(7, frm.getNoStudents());
				ps2.setString(8, frm.getFacilities());
				ps2.setString(9, frm.getToilets());
				ps2.setString(10, frm.getUrinals());
				ps2.setString(11, frm.getNonDrink());
				ps2.setString(12, frm.getNonSani());
				ps2.setString(13, frm.getDrkYear());
				ps2.setString(14, frm.getDrkMonth());
				ps2.setString(15, frm.getSaniYear());
				ps2.setString(16, frm.getSaniMonth());
				ps2.setString(17, frm.getNoBoys());
				ps2.setString(18, frm.getNoGirls());
				ps2.setString(19, frm.getSchoolLatitude());
				ps2.setString(20, frm.getSchoolLongitude());
				ps2.setString(21, frm.getSchoolElevation());
				ps2.setString(22, frm.getSchoolWaypoint());
				ps2.setString(23, frm.getSourceDrkFund());
				ps2.setString(24, frm.getSourceSaniFund());
				ps2.setString(25, frm.getComplDateDW());
				ps2.setString(26, frm.getComplDateSanitation());
				ps2.setString(27, frm.getRunningwater());
				a = ps2.executeUpdate();

			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Exception in Save part of schoolmasterdata -- " + e.getMessage());
		} finally {
			sch.closeAll();
			ps.close();
			ps1.close();
			ps2.close();
		}

		return a;
	}

	public static ArrayList viewHabsList(DataSource dataSource, SchoolForm frm1, HttpServletRequest request)
			throws Exception {
		ArrayList list = new ArrayList();
		SchoolMasterData sch = new SchoolMasterData();
		/*
		 * Stringquery=
		 * "select RAJ.Panch_CODE,sm.SCHOOL_CODE,sm.SCHOOL_NAME,RAJ.PANCH_NAME AS SCHOOL_NAME,sc.SCHOOL_CATEGORY_NAME,"
		 * +
		 * "nvl(sm.SCHOOL_CLASSIFICATION,'-'),nvl(sm.NO_OF_STUDENTS,0),nvl(sm.FACILITIES_AVAILABLE,'-'),nvl(sm.SEPARATE_TOILET_GIRLS_BOYS,'-'),nvl(sm.SEPARATE_URINAL_GIRLS_BOYS,'-'),"
		 * +
		 * "nvl(sm.REASON_NONAVAILABILITY_DW,'-'),nvl(sm.REASON_NONAVAILABILITY_SANI,'-'),nvl(sm.TARGET_YEAR_DW,'-'),nvl(sm.TARGET_MONTH_DW,'-'),nvl(sm.TARGET_YEAR_SANI,'-'),"
		 * +
		 * "nvl(sm.TARGET_MONTH_SANI,'-'),nvl(sm.SOURCE_OF_FUND_DW,'-'),nvl(sm.SOURCE_OF_FUND_SANI,'-'),nvl(sm.NO_OF_BOYS,0),nvl(sm.NO_OF_GIRLS,0),nvl(RAJ.PANCH_NAME,'-') from rws_school_master_tbl sm,rws_school_category_tbl sc,rws_panchayat_raj_tbl raj,rws_habitation_directory_tbl hd where sm.SCHOOL_CATEGORY_CODE =sc.school_category_code and hd.hab_code=raj.panch_code and hd.hab_code=sm.hab_code "
		 * ;
		 */
		// Debug.println("district " + frm1.getDistrict());
		/*
		 * if(frm1.getDistrict().equals("-1")) { request.setAttribute("dFlag1","true");
		 * } if(frm1.getMandal().equals("-1")) { request.setAttribute("mFlag1","true");
		 * } if(frm1.getPanchayat().equals("-1")) {
		 * request.setAttribute("pFlag1","true"); } if(frm1.getVillage().equals("-1")) {
		 * request.setAttribute("vFlag1","true"); }
		 */

		String query = "select d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,RAJ.Panch_CODE,sm.SCHOOL_CODE,sm.SCHOOL_NAME,sc.SCHOOL_CATEGORY_NAME, "
				+ "nvl(sm.SCHOOL_CLASSIFICATION,'-'),nvl(sm.NO_OF_STUDENTS,0),nvl(sm.FACILITIES_AVAILABLE,'-'),nvl(sm.SEPARATE_TOILET_GIRLS_BOYS,'-'), "
				+ "nvl(sm.SEPARATE_URINAL_GIRLS_BOYS,'-'),nvl(sm.REASON_NONAVAILABILITY_DW,'-'),nvl(sm.REASON_NONAVAILABILITY_SANI,'-'),nvl(sm.TARGET_YEAR_DW,'-'),nvl(sm.TARGET_MONTH_DW,'-'),nvl(sm.TARGET_YEAR_SANI,'-'), "
				+ "nvl(sm.TARGET_MONTH_SANI,'-'),nvl(sm.programe_dw,'-'),nvl(sm.programe_sw,'-'),nvl(sm.NO_OF_BOYS,0),nvl(sm.NO_OF_GIRLS,0),nvl(RAJ.PANCH_NAME,'-'),nvl(sm.latitude,'0'),nvl(sm.longitude,'0'),nvl(sm.elevation,'0'),nvl(sm.way_point,'0'),nvl(to_char(COMP_DATE_DW,'dd/mm/yy'),''),nvl(to_char(COMP_DATE_SANI,'dd/mm/yy'),''),nvl(sm.RUNNING_WATER_IN_TOILETS,'-') "
				+ "from rws_school_master_tbl sm,rws_school_category_tbl sc,rws_panchayat_raj_tbl raj,rws_habitation_directory_tbl hd,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v  where "
				+ "sm.SCHOOL_CATEGORY_CODE =sc.school_category_code and hd.hab_code=raj.panch_code and hd.hab_code=sm.hab_code  and d.dcode=m.dcode and m.dcode=p.dcode and "
				+ "m.mcode=p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr(hd.hab_code,1,2)=d.dcode and substr(hd.hab_code,6,2)=m.mcode and substr(hd.hab_code,13,2)=p.pcode and  "
				+ "substr(hd.hab_code,8,3)=v.vcode and hd.coverage_status<>'UI' and hd.coverage_status is not null ";

		try {
			if (!frm1.getDistrict().equals("-1")) {
				query += " and substr(raj.panch_code,1,2)='" + frm1.getDistrict() + "' ";
			}
			if (!frm1.getMandal().equals("-1")) {
				query += " and substr(raj.panch_code,6,2)='" + frm1.getMandal() + "' ";
			}
			if (!frm1.getPanchayat().equals("-1")) {
				query += " and substr(raj.panch_code,13,2)='" + frm1.getPanchayat() + "' ";
			}
			if (!frm1.getVillage().equals("-1")) {
				query += " and substr(raj.panch_code,8,3)='" + frm1.getVillage() + "' ";
			}
			if (!frm1.getHabitation().equals("-1")) {
				query += " and raj.panch_code='" + frm1.getHabitation() + "' ";
			}
			query += " order by raj.panch_code,sm.school_code ";

			sch.conn = RwsOffices.getConn();
			sch.stmt = sch.conn.createStatement();
			sch.rs = sch.stmt.executeQuery(query);
			if (sch.rs.isBeforeFirst()) {
				while (sch.rs.next()) {
					frm1 = new SchoolForm();
					frm1.setDistName(sch.rs.getString(2));
					frm1.setMandName(sch.rs.getString(4));
					frm1.setPanchName(sch.rs.getString(6));
					frm1.setVillName(sch.rs.getString(8));
					frm1.setHabitation(sch.rs.getString(9));
					frm1.setHabName(sch.rs.getString(28));
					frm1.setSchoolCode(sch.rs.getString(10));
					frm1.setSchoolName(sch.rs.getString(11));
					frm1.setCategory(sch.rs.getString(12));
					frm1.setClassify(sch.rs.getString(13));
					frm1.setNoStudents(sch.rs.getString(14));
					frm1.setFacilities(sch.rs.getString(15));
					frm1.setToilets(sch.rs.getString(16));
					frm1.setUrinals(sch.rs.getString(17));
					frm1.setNonDrink(sch.rs.getString(18));
					frm1.setNonSani(sch.rs.getString(19));
					frm1.setDrkYear(sch.rs.getString(20));
					frm1.setDrkMonth(sch.rs.getString(21));
					frm1.setSaniYear(sch.rs.getString(22));
					frm1.setSaniMonth(sch.rs.getString(23));
					frm1.setSourceDrkFund(sch.rs.getString(24));
					frm1.setSourceSaniFund(sch.rs.getString(25));
					frm1.setNoBoys(sch.rs.getString(26));
					frm1.setNoGirls(sch.rs.getString(27));
					frm1.setSchoolLatitude(sch.rs.getString(29));
					// Debug.println("longitude*********"+sch.rs.getString(30));
					frm1.setSchoolLongitude(sch.rs.getString(30));
					// Debug.println("longitude*********"+sch.rs.getString(31));
					frm1.setSchoolElevation(sch.rs.getString(31));
					// Debug.println("longitude*********"+sch.rs.getString(32));
					frm1.setSchoolWaypoint(sch.rs.getString(32));
					frm1.setComplDateDW(sch.rs.getString(33));
					frm1.setComplDateSanitation(sch.rs.getString(34));
					frm1.setRunningwater(sch.rs.getString(35));
					list.add(frm1);

				}
			}
		} catch (Exception e) {
			System.out.println("exception in view schools:" + e);
		} finally {
			sch.closeAll();
		}

		return list;
	}

	// added by ramesh on 200110

	public static ArrayList viewHabsList1(DataSource dataSource, SchoolForm frm1, HttpServletRequest request)
			throws Exception {
		ArrayList list = new ArrayList();
		SchoolMasterData sch = new SchoolMasterData();
		// Debug.println("district " + frm1.getDistrict());

		String query = "select d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,RAJ.Panch_CODE,sm.SCHOOL_CODE,"
				+ "sm.SCHOOL_NAME,sc.SCHOOL_CATEGORY_NAME, nvl(sm.SCHOOL_CLASSIFICATION,'-'),nvl(sm.NO_OF_STUDENTS,0),"
				+ "nvl(sm.FACILITIES_AVAILABLE,'-'),nvl(sm.SEPARATE_TOILET_GIRLS_BOYS,'-'),nvl(sm.SEPARATE_URINAL_GIRLS_BOYS,'-'),"
				+ "nvl(sm.REASON_NONAVAILABILITY_DW,'-'),nvl(sm.REASON_NONAVAILABILITY_SANI,'-'),nvl(sm.TARGET_YEAR_DW,'-'),"
				+ "nvl(sm.TARGET_MONTH_DW,'-'),nvl(sm.TARGET_YEAR_SANI,'-'), "
				+ "nvl(sm.TARGET_MONTH_SANI,'-'),nvl(sm.SOURCE_OF_FUND_DW,'-'),nvl(sm.SOURCE_OF_FUND_SANI,'-'),"
				+ "nvl(sm.NO_OF_BOYS,0),nvl(sm.NO_OF_GIRLS,0),nvl(RAJ.PANCH_NAME,'-') "
				+ "from rws_school_master_tbl sm,rws_school_category_tbl sc,rws_panchayat_raj_tbl raj,rws_habitation_directory_tbl hd,rws_district_tbl d,"
				+ "rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v where "
				+ "sm.SCHOOL_CATEGORY_CODE =sc.school_category_code and hd.hab_code=raj.panch_code and hd.hab_code=sm.hab_code  and "
				+ "d.dcode=m.dcode and m.dcode=p.dcode and "
				+ "m.mcode=p.mcode and p.dcode=v.dcode and p.mcode=v.mcode and p.pcode=v.pcode and substr(hd.hab_code,1,2)=d.dcode and "
				+ "substr(hd.hab_code,6,2)=m.mcode and substr(hd.hab_code,13,2)=p.pcode and  "
				+ "substr(hd.hab_code,8,3)=v.vcode and hd.coverage_status<>'UI' and hd.coverage_status is not null ";

		try {
			if (!frm1.getDistrict().equals("-1")) {
				query += " and substr(raj.panch_code,1,2)='" + frm1.getDistrict() + "' ";
			}
			if (!frm1.getMandal().equals("-1")) {
				query += " and substr(raj.panch_code,6,2)='" + frm1.getMandal() + "' ";
			}
			if (!frm1.getPanchayat().equals("-1")) {
				query += " and substr(raj.panch_code,13,2)='" + frm1.getPanchayat() + "' ";
			}
			if (!frm1.getVillage().equals("-1")) {
				query += " and substr(raj.panch_code,8,3)='" + frm1.getVillage() + "' ";
			}
			if (!frm1.getHabitation().equals("-1")) {
				query += " and raj.panch_code='" + frm1.getHabitation() + "' ";
			}
			query += " order by raj.panch_code,sm.school_code ";

			sch.conn = RwsOffices.getConn();
			sch.stmt = sch.conn.createStatement();
			sch.rs = sch.stmt.executeQuery(query);
			Rws_SchoolDetails sd = null;
			if (sch.rs.isBeforeFirst()) {
				while (sch.rs.next()) {
					frm1 = new SchoolForm();

					CommonLists commonLists = new CommonLists();
					ArrayList assetTypes = commonLists.getAssetTypes();

					sd = new Rws_SchoolDetails();

					sd.setDname(sch.rs.getString(2));
					sd.setMname(sch.rs.getString(4));
					sd.setPname(sch.rs.getString(6));
					sd.setVname(sch.rs.getString(8));
					sd.setHabname(sch.rs.getString(28));
					sd.setHabCode(sch.rs.getString(9));
					sd.setSchoolname(sch.rs.getString(11));
					sd.setSchoolcode(sch.rs.getString(10));
					sd.setStudents(sch.rs.getString(14));
					sd.setBoysgirls(sch.rs.getString(26) + "/" + sch.rs.getString(27));
					sd.setCategory(sch.rs.getString(12));
					sd.setClassification(sch.rs.getString(13));
					sd.setAssetTypes(assetTypes);
					String msg = "<font face=verdana size=2 color=red>Selection Criteria:-&nbsp; </font><font face=verdana size=2 color=MediumVioletRed>District:&nbsp;</font><font face=verdana size=2 color=blue>"
							+ sch.rs.getString(2)
							+ " <font face=verdana size=2 color=MediumVioletRed> Mandal:&nbsp;</font><font face=verdana size=2 color=blue>"
							+ sch.rs.getString(4)
							+ "</font> <font face=verdana size=2 color=MediumVioletRed>Panchayat:&nbsp;</font><font face=verdana size=2 color=blue>"
							+ sch.rs.getString(6)
							+ " </font><font face=verdana size=2 color=MediumVioletRed>Village:&nbsp;</font><font face=verdana size=2 color=blue>"
							+ sch.rs.getString(8)
							+ " </font><font face=verdana size=2 color=MediumVioletRed>Habitation:&nbsp;</font><font face=verdana size=2 color=blue>"
							+ sch.rs.getString(28)
							+ "</font> <font face=verdana size=2 color=MediumVioletRed>School:&nbsp;</font><font face=verdana size=2 color=blue>"
							+ sch.rs.getString(11) + "</font>";
					// Debug.println("Msg:" + msg);
					sd.setSelCriteria(msg);
					list.add(sd);
				}
			}
		} catch (Exception e) {
			System.out.println("exception in view schools:" + e.getMessage());
		} finally {
			sch.closeAll();
		}

		return list;
	}

	public static SchoolForm getSchoolEdit(String habcode, String scode, DataSource dataSource) throws Exception {
		SchoolForm sch = null;
		SchoolMasterData scm = new SchoolMasterData();
		PreparedStatement ps = null;
		try {
			scm.conn = RwsOffices.getConn();

			String query = "select d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,raj.panch_code,raj.panch_name,"
					+ "sm.SCHOOL_CODE,"
					+ "sm.SCHOOL_NAME,sc.SCHOOL_CATEGORY_CODE,nvl(sm.SCHOOL_CLASSIFICATION,'-'),nvl(sm.NO_OF_STUDENTS,0)"
					+ ",nvl(sm.FACILITIES_AVAILABLE,'-'),nvl(sm.SEPARATE_TOILET_GIRLS_BOYS,'-'),"
					+ "nvl(sm.SEPARATE_URINAL_GIRLS_BOYS,'-'),nvl(sm.REASON_NONAVAILABILITY_DW,'-'),"
					+ "nvl(sm.REASON_NONAVAILABILITY_SANI,'-'),nvl(sm.TARGET_YEAR_DW,'-'),nvl(sm.TARGET_MONTH_DW,'-'),"
					+ "nvl(sm.TARGET_YEAR_SANI,'-'),nvl(sm.TARGET_MONTH_SANI,'-'),nvl(sm.programe_dw,'-'),nvl(sm.programe_sw,'-'),"
					+ "nvl(sm.NO_OF_BOYS,0),nvl(sm.NO_OF_GIRLS,0),nvl(sm.latitude,'0'),nvl(sm.longitude,'0'),nvl(sm.elevation,'0'),nvl(sm.way_point,'0'),"
					+ "nvl(to_char(COMP_DATE_DW,'dd/mm/yy'),''),nvl(to_char(COMP_DATE_SANI,'dd/mm/yy'),''),"
					+ "nvl(RUNNING_WATER_IN_TOILETS,'-')"
					+ "from rws_school_master_tbl sm,rws_school_category_tbl sc,rws_panchayat_raj_tbl raj,rws_habitation_directory_tbl hd,"
					+ "rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v where"
					+ " sm.SCHOOL_CATEGORY_CODE =sc.school_category_code and hd.hab_code=raj.panch_code and hd.hab_code=sm.hab_code and "
					+ "sm.hab_code=? and sm.SCHOOL_CODE=? and d.dcode=substr(raj.panch_code,1,2) and m.mcode=substr(raj.panch_code,6,2) and"
					+ " p.pcode=substr(raj.panch_code,13,2) and v.vcode=substr(raj.panch_code,8,3) and d.dcode=m.dcode and p.dcode=m.dcode and"
					+ " p.mcode=m.mcode and v.dcode=p.dcode and v.mcode=p.mcode and v.pcode=p.pcode ";
			ps = scm.conn.prepareStatement(query);
			ps.setString(1, habcode);
			ps.setString(2, scode);
			scm.rs = ps.executeQuery();
			while (scm.rs.next()) {
				sch = new SchoolForm();
				sch.setDistrict(scm.rs.getString(1));
				sch.setMandal(scm.rs.getString(3));
				sch.setPanchayat(scm.rs.getString(5));
				sch.setVillage(scm.rs.getString(7));
				sch.setHabitation(scm.rs.getString(9));
				sch.setSchoolCode(scm.rs.getString(11));
				sch.setSchoolName(scm.rs.getString(12));
				sch.setCategory(scm.rs.getString(13));// getCategoryName(scm.rs.getString(13),scm.conn));
				sch.setClassify(scm.rs.getString(14));
				sch.setNoStudents(scm.rs.getString(15));
				sch.setFacilities(scm.rs.getString(16));
				sch.setToilets(scm.rs.getString(17));
				sch.setUrinals(scm.rs.getString(18));
				sch.setNonDrink(scm.rs.getString(19));
				sch.setNonSani(scm.rs.getString(20));
				sch.setDrkYear(scm.rs.getString(21));
				sch.setDrkMonth(scm.rs.getString(22));
				sch.setSaniYear(scm.rs.getString(23));
				sch.setSaniMonth(scm.rs.getString(24));
				sch.setSourceDrkFund(scm.rs.getString(25));
				sch.setSourceSaniFund(scm.rs.getString(26));
				sch.setNoBoys(scm.rs.getString(27));
				sch.setNoGirls(scm.rs.getString(28));
				sch.setSchoolLoc(scm.rs.getString(10));
				sch.setHabName(scm.rs.getString(10));
				sch.setSchoolLatitude(scm.rs.getString(29));
				sch.setSchoolLongitude(scm.rs.getString(30));
				sch.setSchoolElevation(scm.rs.getString(31));
				sch.setSchoolWaypoint(scm.rs.getString(32));
				sch.setComplDateDW(scm.rs.getString(33));
				sch.setComplDateSanitation(scm.rs.getString(34));
				sch.setRunningwater(scm.rs.getString(34));

			}

		} catch (Exception e) {
			System.out.println("Exception Edit in school master data -- " + e.getMessage());
		} finally {
			scm.closeAll();
		}
		return sch;

	}

	public static String getCategoryName(String catCode, Connection conn) throws Exception {

		SchoolMasterData scm = new SchoolMasterData();
		scm.conn = conn;
		String name = null;
		scm.stmt1 = null;
		scm.rs1 = null;
		try {
			scm.stmt1 = scm.conn.createStatement();
			if (catCode != null) {
				String q = "SELECT SCHOOL_CATEGORY_NAME  FROM rws_school_category_tbl WHERE SCHOOL_CATEGORY_Code ="
						+ catCode;
				scm.rs1 = scm.stmt1.executeQuery(q);
				Debug.println("category query" + q);
				scm.rs1.next();
				name = scm.rs1.getString(1);
			}
		} catch (Exception e) {
			Debug.println("Ther error in getQualName=" + e);
		} finally {
			scm.stmt1.close();
		}
		return name;
	}

	public String UpdateSchoolDetails(String habcode, String scode, SchoolForm frm, DataSource dataSource)
			throws Exception {
		String message = null;
		SchoolMasterData sch = new SchoolMasterData();
		sch.conn = RwsOffices.getConn();
		String query = null;
		PreparedStatement ps = null;
		int i = 0;
		try {

			query = "update rws_school_master_tbl set HAB_CODE=?,SCHOOL_CODE=?,SCHOOL_NAME=?,SCHOOL_LOCATION=?,"
					+ "SCHOOL_CATEGORY_CODE=?,SCHOOL_CLASSIFICATION=?,NO_OF_STUDENTS=?,FACILITIES_AVAILABLE=?,"
					+ "SEPARATE_TOILET_GIRLS_BOYS=?,SEPARATE_URINAL_GIRLS_BOYS=?,REASON_NONAVAILABILITY_DW=?,"
					+ "REASON_NONAVAILABILITY_SANI=?,TARGET_YEAR_DW=?,TARGET_MONTH_DW=?,TARGET_YEAR_SANI=?,"
					+ "TARGET_MONTH_SANI=?,SOURCE_OF_FUND_DW=?,SOURCE_OF_FUND_SANI=?,NO_OF_BOYS=?,"
					+ "NO_OF_GIRLS=? ,latitude=?,longitude=?,elevation=?,way_point=?,COMP_DATE_DW=to_date(?,'dd/mm/yyyy'),"
					+ "COMP_DATE_SANI=to_date(?,'dd/mm/yyyy'),RUNNING_WATER_IN_TOILETS=? where hab_code=? and school_code=? ";

			ps = sch.conn.prepareStatement(query);
			ps.setString(1, frm.getHabitation());
			ps.setString(2, frm.getSchoolCode());
			ps.setString(3, frm.getSchoolName());
			ps.setString(4, format(frm.getSchoolLoc()));
			ps.setString(5, frm.getCategory());
			ps.setString(6, frm.getClassify());
			ps.setString(7, frm.getNoStudents());
			ps.setString(8, frm.getFacilities());
			ps.setString(9, format(frm.getToilets()));
			ps.setString(10, format(frm.getUrinals()));
			ps.setString(11, format(frm.getNonDrink()));
			ps.setString(12, format(frm.getNonSani()));
			ps.setString(13, format(frm.getDrkYear()));
			ps.setString(14, format(frm.getDrkMonth()));
			ps.setString(15, format(frm.getSaniYear()));
			ps.setString(16, format(frm.getSaniMonth()));
			ps.setString(17, format(frm.getSourceDrkFund()));
			ps.setString(18, format(frm.getSourceSaniFund()));
			ps.setString(19, format(frm.getNoBoys()));
			ps.setString(20, format(frm.getNoGirls()));
			ps.setString(21, format(frm.getSchoolLatitude()));
			ps.setString(22, format(frm.getSchoolLongitude()));
			ps.setString(23, format(frm.getSchoolElevation()));
			ps.setString(24, format(frm.getSchoolWaypoint()));
			ps.setString(25, frm.getComplDateDW());
			ps.setString(26, frm.getComplDateDW());
			ps.setString(27, format(frm.getRunningwater()));
			ps.setString(28, habcode);
			ps.setString(29, scode);

			i = ps.executeUpdate();

			if (i == 1) {
				message = "Updated Record Successfully";
			} else {
				message = "Record Can't be Updated";
			}

		} catch (Exception e) {
			System.out.println("Exception in Update() " + e.getMessage());
		}

		return message;

	}

	public static String format(String val) {
		if (val == null || val.equals(null)) {
			val = "";
		}

		return val;
	}

	public String deleteSchoolDetails(String habcode, String scode, DataSource dataSource) throws Exception {
		String message = null;
		SchoolMasterData sch = new SchoolMasterData();
		sch.conn = RwsOffices.getConn();
		String query = null;
		int i = 0;
		PreparedStatement ps = null;
		try {

			query = "DELETE FROM RWS_SCHOOL_MASTER_TBL WHERE HAB_CODE=? and SCHOOL_CODE=? ";
			ps = sch.conn.prepareStatement(query);
			ps.setString(1, habcode);
			ps.setString(2, scode);

			i = ps.executeUpdate();

			if (i == 1) {
				message = "Record Deleted Successfully";
			} else {
				message = "Record Cannot be Deleted";
			}

		} catch (Exception e) {
			System.out.println("Exception in deleteSchoolDetails " + e.getMessage());
		}

		return message;

	}

	public ArrayList getSchoolViewDetails(SchoolForm frm, DataSource dataSource, HttpServletRequest request)
			throws Exception {
		ArrayList details = new ArrayList();
		SchoolMasterData sch1 = new SchoolMasterData();
		String query = "", query1 = "";
		String message = "Report";

		// Debug.println(frm.getDistrict());
		// Debug.println(frm.getMandal());
		// Debug.println(frm.getPanchayat());
		// Debug.println(frm.getVillage());

		if (frm.getDistrict().equals("-1")) {
			request.setAttribute("dFlag", "true");
		}
		if (frm.getMandal().equals("-1")) {
			request.setAttribute("mFlag", "true");
		}
		if (frm.getPanchayat().equals("-1")) {
			request.setAttribute("pFlag", "true");
		}
		if (frm.getVillage().equals("-1")) {
			request.setAttribute("vFlag", "true");
		}

		sch1.conn = RwsOffices.getConn();
		try {

			sch1.stmt = sch1.conn.createStatement();

			query = "select d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,raj.panch_code,raj.panch_name,sm.HAB_CODE,sm.SCHOOL_CODE,sm.SCHOOL_NAME,sc.SCHOOL_CATEGORY_NAME,nvl(sm.SCHOOL_CLASSIFICATION,'-'),nvl(sm.NO_OF_STUDENTS,0),nvl(sm.FACILITIES_AVAILABLE,'-'),nvl(sm.SEPARATE_TOILET_GIRLS_BOYS,'-'),nvl(sm.SEPARATE_URINAL_GIRLS_BOYS,'-'),nvl(sm.REASON_NONAVAILABILITY_DW,'-'),nvl(sm.REASON_NONAVAILABILITY_SANI,'-'),"
					+ "nvl(sm.TARGET_YEAR_DW,'-'),nvl(sm.TARGET_MONTH_DW,'-'),nvl(sm.TARGET_YEAR_SANI,'-'),nvl(sm.TARGET_MONTH_SANI,'-'),nvl(sm.SOURCE_OF_FUND_DW,'-'),nvl(sm.SOURCE_OF_FUND_SANI,'-'),nvl(sm.NO_OF_BOYS,0),nvl(sm.NO_OF_GIRLS,0),nvl(to_char(COMP_DATE_DW,'dd/mm/yy'),'-'),nvl(to_char(COMP_DATE_SANI,'dd/mm/yy'),'-'),nvl(sm.RUNNING_WATER_IN_TOILETS,'-') "
					+ "from rws_school_master_tbl sm,rws_school_category_tbl sc,rws_panchayat_raj_tbl raj,rws_habitation_directory_tbl hd,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v where sm.SCHOOL_CATEGORY_CODE =sc.school_category_code and hd.hab_code=raj.panch_code and hd.hab_code=sm.hab_code "
					+ "and d.dcode=substr(raj.panch_code,1,2) and m.mcode=substr(raj.panch_code,6,2) and p.pcode=substr(raj.panch_code,13,2) and v.vcode=substr(raj.panch_code,8,3) and d.dcode=m.dcode and p.dcode=m.dcode and p.mcode=m.mcode and v.dcode=p.dcode and v.mcode=p.mcode and v.pcode=p.pcode ";
			// from rws_school_master_tbl sm,rws_school_category_tbl sc where
			// sm.SCHOOL_CATEGORY_CODE =sc.SCHOOL_CATEGORY_CODE " ;

			if (!frm.getDistrict().equals("-1") || frm.getDistrict() != null) {
				query += " and substr(raj.panch_code,1,2)='" + frm.getDistrict() + "' ";
			}
			if (!frm.getMandal().equals("-1")) {
				query += " and substr(raj.panch_code,6,2)='" + frm.getMandal() + "' ";
			}
			if (!frm.getPanchayat().equals("-1")) {
				query += " and substr(raj.panch_code,13,2)='" + frm.getPanchayat() + "' ";
			}
			if (!frm.getVillage().equals("-1")) {
				query += " and substr(raj.panch_code,8,3)='" + frm.getVillage() + "' ";
			}
			if (!frm.getHabitation().equals("-1")) {
				query += " and raj.panch_code='" + frm.getHabitation() + "' ";
			}
			if (frm.getCategory() != null && !frm.getCategory().equals("00")) {
				if (message.equals("")) {
					String cat1 = "";
					int cat = Integer.parseInt(frm.getCategory());
					switch (cat) {
					case 01:
						cat1 = "Balwadi/Aganwadi";
						break;
					case 02:
						cat1 = "Primary";
						break;
					case 03:
						cat1 = "Upper Primary";
						break;
					case 04:
						cat1 = "Secondary";
						break;
					case 05:
						cat1 = "Sr. Secondary";
						break;
					}
					message = "Report School Category wise:'" + cat1 + "'";
				} else {
					// message+="Report School Category wise:'"+frm.getCategory()+"' ";

				}
				query += " and sm.school_category_code='" + frm.getCategory() + "' ";
			}
			if (frm.getClassify() != null && !frm.getClassify().equals("00")) {
				if (message.equals("")) {
					message = "Report School Classification wise:'" + frm.getClassify() + "'";
				} else {
					// message+=" School_Classification wise:'"+frm.getClassify()+"' ";
				}
				query += " AND sm.SCHOOL_CLASSIFICATION ='" + frm.getClassify() + "' ";
			}
			if (frm.getFacilities() != null && !frm.getFacilities().equals("00")) {
				if (message.equals("")) {
					message = "Report Facilities Available wise:'" + frm.getFacilities() + "'";
				} else {
					// message+=" Facilities Available wise:'"+frm.getFacilities()+"' '\n' ";
				}
				query += " AND sm.FACILITIES_AVAILABLE ='" + frm.getFacilities() + "' ";
			}
			if (!frm.getNoStudents().equals("")) {
				if (message.equals("")) {
					message = "Report No Of Students " + frm.getNoStudents1() + "'" + frm.getNoStudents() + "'";
				} else {
					// message+="No of Students "+frm.getNoStudents1()+"'"+frm.getNoStudents()+"'
					// '\n' ";
				}
				query += " AND sm.NO_OF_STUDENTS" + frm.getNoStudents1() + "'" + frm.getNoStudents() + "' ";
			}
			if (!frm.getNoBoys().equals("")) {
				if (message.equals("")) {
					message = "Report No Of Boys " + frm.getNoBoys1() + "'" + frm.getNoBoys() + "' ";
				} else {
					// message+=" and No of Boys "+frm.getNoBoys1()+"'"+frm.getNoBoys()+"' '\n' ";
				}
				query += " AND sm.NO_OF_BOYS" + frm.getNoBoys1() + "'" + frm.getNoBoys() + "' ";
			}
			if (!frm.getNoGirls().equals("")) {
				if (message.equals("")) {
					message = "Report No of Girls " + frm.getNoGirls1() + "'" + frm.getNoGirls() + "' ";
				} else {
					// message+=" and No of Girls "+frm.getNoGirls1()+"'"+frm.getNoGirls()+"' '\n'
					// ";
				}
				query += " AND sm.NO_OF_GIRLS" + frm.getNoGirls1() + "'" + frm.getNoGirls() + "' ";
			}
			if (!frm.getToilets().equals("") && !frm.getToilets().equals("00")) {
				if (message.equals("")) {
					message = "Report SEPARATE_TOILET_GIRLS_BOYS: '" + frm.getToilets() + "' ";
				} else {
					// message+=" SEPARATE_TOILET_GIRLS_BOYS: '"+frm.getToilets()+"' '\n' ";
				}
				query += " AND sm.SEPARATE TOILET GIRLS-BOYS='" + frm.getToilets() + "' ";
			}
			//
			/*
			 * if (!frm.getRunningwater().equals("") && !frm.getRunningwater().equals("00"))
			 * { if (message.equals("")) { message = "Report RUNNING_WATER_IN_TOILETS: '" +
			 * frm.getRunningwater()+ "' "; } else { //
			 * message+=" SEPARATE_TOILET_GIRLS_BOYS: '"+frm.getToilets()+"' '\n' "; } query
			 * += " AND sm.RUNNING_WATER_IN_TOILETS='" + frm.getRunningwater()+ "' "; }
			 */
			//
			if (!frm.getUrinals().equals("") && !frm.getUrinals().equals("00")) {
				if (message.equals("")) {
					message = "Report SEPARATE_URINAL_GIRLS_BOYS: '" + frm.getUrinals() + "' ";
				} else {
					// message+=" SEPARATE_URINAL_GIRLS_BOYS: '"+frm.getUrinals()+"' '\n' ";
				}
				query += " AND sm.SEPARATE_URINAL_GIRLS_BOYS='" + frm.getUrinals() + "' ";
			}
			if (!frm.getNonDrink().equals("") && !frm.getNonDrink().equals("00")) {
				if (message.equals("")) {
					message = "Report REASON_NONAVAILABILITY_DRINKING WATER: '" + frm.getNonDrink() + "' ";
				} else {
					// message+=" REASON_NONAVAILABILITY_DRINKING WATER: '"+frm.getNonDrink()+"'
					// '\n' ";
				}

				query += " AND sm.REASON_NONAVAILABILITY_DW='" + frm.getNonDrink() + "' ";
			}
			if (!frm.getNonSani().equals("") && !frm.getNonSani().equals("00")) {
				if (message.equals("")) {
					message = "Report REASON_NONAVAILABILITY SANITATION: '" + frm.getNonSani() + "' ";
				} else {
					// message+=" REASON_NONAVAILABILITY SANITATION: '"+frm.getNonSani()+"' '\n' ";
				}
				query += " AND sm.REASON_NONAVAILABILITY_SANI='" + frm.getNonSani() + "' ";
			}
			if (!frm.getDrkMonth().equals("") && !frm.getDrkMonth().equals("00")) {
				if (message.equals("")) {
					message = "Report TARGET_MONTH_DRINKING WATER: '" + frm.getDrkMonth() + "' ";
				} else {
					// message+=" TARGET_MONTH_DRINKING WATER: '"+frm.getDrkMonth()+"' '\n' ";
				}
				query += " AND sm.TARGET_MONTH_DW='" + frm.getDrkMonth() + "' ";
			}
			if (!frm.getDrkYear().equals("") && !frm.getDrkYear().equals("00")) {
				if (message.equals("")) {
					message = "Report TARGET_YEAR_DRINKING WATER: '" + frm.getDrkYear() + "' ";
				} else {
					// message+=" TARGET_YEAR_DRINKING WATER: '"+frm.getDrkYear()+"' '\n' ";
				}
				query += " AND sm.TARGET_YEAR_DW='" + frm.getDrkYear() + "' ";
			}
			if (!frm.getSaniMonth().equals("") && !frm.getSaniMonth().equals("00")) {
				if (message.equals("")) {
					message = "Report TARGET_MONTH SANITATION: '" + frm.getSaniMonth() + "' ";
				} else {
					// message+=" TARGET_MONTH SANITATION: '"+frm.getSaniMonth()+"' '\n' ";
				}
				query += " AND sm.TARGET_MONTH_SANI='" + frm.getSaniMonth() + "' ";
			}
			if (!frm.getSaniYear().equals("") && !frm.getSaniYear().equals("00")) {
				if (message.equals("")) {
					message = "Report TARGET_YEAR SANITATION: '" + frm.getSaniYear() + "' ";
				} else {
					// message+=" TARGET_YEAR SANITATION: '"+frm.getSaniYear()+"' '\n' ";
				}
				query += " AND sm.TARGET_YEAR_SANI='" + frm.getSaniYear() + "' ";
			}
			if (!frm.getSourceDrkFund().equals("") && !frm.getSourceDrkFund().equals("00")) {
				if (message.equals("")) {
					message = "Report SOURCE_OF_FUND_DRINKING WATER: '" + frm.getSourceDrkFund() + "' ";
				} else {
					// message+=" SOURCE_OF_FUND_DRINKING WATER: '"+frm.getSourceDrkFund()+"' '\n'
					// ";
				}

				query += " AND sm.SOURCE_OF_FUND_DW='" + frm.getSourceDrkFund() + "' ";
			}
			if (!frm.getSourceSaniFund().equals("") && !frm.getSourceSaniFund().equals("00")) {
				if (message.equals("")) {
					message = "Report SOURCE_OF_FUND SANITATION: '" + frm.getSourceSaniFund() + "' ";
				} else {
					// message+=" SOURCE_OF_FUND SANITATION: '"+frm.getSourceSaniFund()+"' '\n' ";
				}

				query += " AND sm.SOURCE_OF_FUND_SANI='" + frm.getSourceSaniFund() + "' ";
			}

			query += " order by d.dcode,m.mcode,v.vcode,p.pcode,raj.panch_code,sm.school_code ";
			sch1.rs = sch1.stmt.executeQuery(query);

			while (sch1.rs.next()) {

				try {
					frm = new SchoolForm();
					frm.setDistName(sch1.rs.getString(2));
					frm.setMandName(sch1.rs.getString(4));
					frm.setPanchName(sch1.rs.getString(6));
					frm.setVillName(sch1.rs.getString(8));
					frm.setHabitation(sch1.rs.getString(9));
					frm.setHabName(sch1.rs.getString(10));
					frm.setSchoolCode(sch1.rs.getString(12));
					frm.setSchoolName(sch1.rs.getString(13));
					frm.setCategory(sch1.rs.getString(14));
					frm.setClassify(sch1.rs.getString(15));
					frm.setNoStudents(sch1.rs.getString(16));
					frm.setFacilities(sch1.rs.getString(17));
					frm.setToilets(sch1.rs.getString(18));
					frm.setUrinals(sch1.rs.getString(19));
					frm.setNonDrink(sch1.rs.getString(20));
					frm.setNonSani(sch1.rs.getString(21));
					frm.setDrkYear(sch1.rs.getString(22));
					frm.setDrkMonth(sch1.rs.getString(23));
					frm.setSaniYear(sch1.rs.getString(24));
					frm.setSaniMonth(sch1.rs.getString(25));
					frm.setSourceDrkFund(sch1.rs.getString(26));
					frm.setSourceSaniFund(sch1.rs.getString(27));
					frm.setNoBoys(sch1.rs.getString(28));
					frm.setNoGirls(sch1.rs.getString(29));
					frm.setComplDateDW(sch1.rs.getString(30));
					frm.setComplDateSanitation(sch1.rs.getString(31));
					frm.setRunningwater(sch1.rs.getString(32));
					request.setAttribute("frmm", frm);
					details.add(frm);

				} catch (Exception e) {
					System.out.println("Exeception in viewdetails " + e.getMessage());
				}

			}
			request.setAttribute("message", message);

		} catch (Exception e) {
			System.out.println("Exception in view Details of school master data -- " + e.getMessage());

		}

		return details;

	}

	public ArrayList getPrograms() {
		Connection conn = null;
		ResultSet rs = null, rs1 = null;
		Statement stmt1 = null, stmt2 = null;
		ArrayList programs = new ArrayList();
		// LabelValueBean labelValueBean1 = new LabelValueBean();
		// labelValueBean1.setValue(Constants.NRDWP_RELATED);
		// labelValueBean1.setLabel("NRDDWP-RELATED");
		// programs.add(labelValueBean1);
		try {
			conn = RwsOffices.getConn();
			stmt1 = conn.createStatement();
			String query = "select distinct a.programme_code,a.PROGRAMME_NAME from rws_programme_tbl a order by a.programme_code";
			rs = stmt1.executeQuery(query);

			while (rs.next()) {

				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs.getString(1));
				labelValueBean.setLabel(rs.getString(2));
				labelValueBean.setLabelValue("");
				programs.add(labelValueBean);
			}

		} catch (Exception e) {
			System.out.println("Exception in getPrograms of school master data -- " + e.getMessage());
		}

		return programs;
	}

}