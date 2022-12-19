package nic.watersoft.smsmobile;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.stream.ImageOutputStream;
import javax.sql.DataSource;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsLocationBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.complaints.ComplaintMasterData;
import oracle.jdbc.OracleDriver;

public class SmsRegistrationDAO {

	public SmsRegistrationDAO() {
		conn = null;
		stmt = null;
		stmt1 = null;
		stmt2 = null;
		stmt3 = null;
		stmt4 = null;
		stmt5 = null;
		stmt6 = null;
		stmt7 = null;
		stmt8 = null;
		stmt9 = null;
		stmt10 = null;
		stmt11 = null;
		stmt12 = null;
		stmt13 = null;
		stmt14 = null;
		stmt15 = null;
		stmt16 = null;
		stmt17 = null;
		stmt18 = null;
		stmt19 = null;
		stmt20 = null;
		stmt21 = null;
		stmt22 = null;
		stmt23 = null;
		stmt24 = null;
		rs = null;
		rset = null;
		rs1 = null;
		rs2 = null;
		rs3 = null;
		rs4 = null;
		rs5 = null;
		rs6 = null;
		rs7 = null;
		rs8 = null;
		rs9 = null;
		rs10 = null;
		rs11 = null;
		rs12 = null;
		rs13 = null;
		rs14 = null;
		rs15 = null;
		rs16 = null;
		rs17 = null;
		rs18 = null;
		rs19 = null;
		rs20 = null;
		rs21 = null;
		rs22 = null;
		rs23 = null;
		rs24 = null;
		connCount++;
	}

	public static Connection getConnmsaccess() {
		Connection con = null;
		Debug.println("Msaccess Connection");
		try {
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			Debug.println("MsaccescalssforName");
			String url = "jdbc:odbc:DRIVER={Microsoft Access Driver  (*.mdb)};DBQ=G:/login.mdb;";
			con = DriverManager.getConnection(url, "", "");
			Debug.println("Msaccess getConnection");
		} catch (Exception o) {
			o.printStackTrace();
			Debug.println("Msaccess Exception");
		}
		return con;
	}

	//
	public static String getCreateTable(String tab, DataSource dataSource) {
		String message;
		// Debug.println("tablesmethod" + tab);
		Connection conn = null;
		Connection con = null;
		Statement stmt = null;
		Statement stmt1 = null;
		ResultSet rs = null;
		ResultSet rs1 = null;
		String p = "";
		String ptr = "";
		int z = 0;
		int columncount = 0;
		message = "";
		int width = 0;
		String r = "";
		int columnwidth = 0;
		String database = "";
		ComplaintMasterData complaintMaster = new ComplaintMasterData();
		try {
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			String url = "jdbc:odbc:master";
			con = DriverManager.getConnection(url, "", "");
			DriverManager.registerDriver(new OracleDriver());
			conn = DriverManager.getConnection("jdbc:oracle:thin:@10.160.2.209:1521:wsoft", "preduser", "preduser");
			stmt = conn.createStatement();
			String query = "select * from " + tab + " order by 1";
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);
			ResultSetMetaData rsmd = rs.getMetaData();
			columncount = rsmd.getColumnCount();
			for (int q = 1; q <= columncount; q++) {
				if (rsmd.getColumnTypeName(q).equals("VARCHAR2"))
					p = " text ";
				else if (rsmd.getColumnTypeName(q).equals("DATE"))
					p = " date ";
				else if (rsmd.getColumnTypeName(q).equals("NUMBER"))
					p = " number ";
				if (rsmd.getColumnTypeName(q).equals("VARCHAR2")) {
					columnwidth = rsmd.getColumnDisplaySize(q);
					p = p + "(" + columnwidth + "),";
				} else {
					p = p + ",";
				}
				ptr = ptr + rsmd.getColumnName(q) + p;
				Debug.println("ptr" + ptr);
			}

			ptr = ptr.substring(0, ptr.lastIndexOf(","));
			if (tabExists(tab)) {
				Statement stmt2 = con.createStatement();
				stmt2.executeUpdate("drop table " + tab);
				// System.out.println("deleted");
			}
			String query1 = "create table " + tab + " (" + ptr + ")";
			Statement stmt3 = con.createStatement();
			z = stmt3.executeUpdate(query1);
			if (z == -1)
				message = "Tablecreated";
			else
				message = "Table Not Created";
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (stmt != null)
					stmt.close();
				if (stmt1 != null)
					stmt1.close();
				if (conn != null)
					conn.close();
				if (con != null)
					con.close();
			} catch (Exception o) {
				o.printStackTrace();
			}
		}
		return message;
	}

	public void getMsaccessDatabase() {
		Debug.println("1111111111");
	}

	public static boolean tabExists(String tab) {
		boolean exists;
		exists = false;
		Connection conn = null;
		Statement st1 = null;
		ResultSet rs1 = null;
		try {
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			String url = "jdbc:odbc:master";
			conn = DriverManager.getConnection(url, "", "");
			st1 = conn.createStatement();
			rs1 = st1.executeQuery("select * from " + tab);
			exists = true;
		} catch (Exception e) {
			exists = false;
		} finally {
			try {
				if (rs1 != null)
					rs1.close();
				if (st1 != null)
					st1.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		// System.out.println("finally Exists:" + exists);
		return exists;
	}

	public void getRegistredDetails(String phone, String habCode, String serviceReq, RwsSmsRegistrationForm myForm) {

		String query1 = "";
		Connection conn = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		try {
			conn = RwsOffices.getConn();
		


			if (serviceReq.equals("SMS")) {
				query1 = "select dname,mname,pname,vname,panch_name,IMEI_NO,DATA_COLLECTOR_NAME,MOBILE,DESIGNATION,GENDER,"
						+ "EMAILID,ADDRESS,to_char(DATE_OF_REQUEST,'dd/mm/yyyy'),HABITATION_CODE,Location,USER_ID,PASSWORD,"
						+ "SERVICE_REQUEST  from RWS_MOBILE_SMS_REGISTER_TBL a,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,"
						+ "rws_village_tbl v,rws_panchayat_raj_tbl pr  where substr(a.HABITATION_CODE,1,2)=d.dcode and "
						+ "substr(a.HABITATION_CODE,1,2)=m.dcode and substr(a.HABITATION_CODE,6,2)=m.mcode and "
						+ "substr(a.HABITATION_CODE,1,2)=p.dcode and substr(a.HABITATION_CODE,6,2)=p.mcode and "
						+ "substr(a.HABITATION_CODE,13,2)=p.pcode and substr(a.HABITATION_CODE,1,2)=v.dcode and "
						+ "substr(a.HABITATION_CODE,6,2)=v.mcode and substr(a.HABITATION_CODE,13,2)=v.pcode and "
						+ "substr(a.HABITATION_CODE,8,3)=v.VCODE and PANCH_CODE=a.habitation_code and HABITATION_CODE=? "
						+ "and mobile=?";
			} else {
				query1 = "select dname,mname,pname,vname,panch_name,IMEI_NO,DATA_COLLECTOR_NAME,MOBILE,DESIGNATION,GENDER,"
						+ "EMAILID,ADDRESS,to_char(DATE_OF_REQUEST,'dd/mm/yyyy'),HABITATION_CODE,Location,"
						+ "TASK_AUTHORISED_NAME,a.TASK_AUTHORISED_CODE,USER_ID,PASSWORD,SERVICE_REQUEST "
						+ " from RWS_MOBILE_SMS_REGISTER_TBL a,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v,"
						+ "rws_panchayat_raj_tbl pr,RWS_TASK_AUTHORISED_TBL ts  where substr(a.HABITATION_CODE,1,2)=d.dcode and "
						+ "substr(a.HABITATION_CODE,1,2)=m.dcode and substr(a.HABITATION_CODE,6,2)=m.mcode and "
						+ "substr(a.HABITATION_CODE,1,2)=p.dcode and substr(a.HABITATION_CODE,6,2)=p.mcode and"
						+ " substr(a.HABITATION_CODE,13,2)=p.pcode and substr(a.HABITATION_CODE,1,2)=v.dcode and "
						+ "substr(a.HABITATION_CODE,6,2)=v.mcode and substr(a.HABITATION_CODE,13,2)=v.pcode and "
						+ "substr(a.HABITATION_CODE,8,3)=v.VCODE and PANCH_CODE=a.habitation_code and "
						+ "a.TASK_AUTHORISED_CODE=ts.TASK_AUTHORISED_CODE and HABITATION_CODE=? and mobile=?";
			}
			
			stmt1 = conn.prepareStatement(query1);
			stmt1.setString(1, habCode);
			stmt1.setString(2, phone);
			rs1 = stmt1.executeQuery();

			while (rs1.next()) {
				String mob = rs1.getString("MOBILE");

				String mob1 = mob.substring(2, 12);
				myForm.setImeino(rs1.getString("IMEI_NO"));
				myForm.setDatecollname(rs1.getString("DATA_COLLECTOR_NAME"));
				myForm.setPhoneNo(mob1);
				myForm.setDistrictName(rs1.getString("dname"));
				myForm.setMand(rs1.getString("mname"));
				myForm.setPanch(rs1.getString("pname"));
				myForm.setHabCode(rs1.getString("panch_name"));
				myForm.setLocation(rs1.getString("Location"));
				myForm.setDesgnation(rs1.getString("DESIGNATION"));
				myForm.setGender(rs1.getString("GENDER"));
				myForm.setEmailId(rs1.getString("EMAILID"));
				myForm.setAddress(rs1.getString("ADDRESS"));
				myForm.setHabName(rs1.getString("panch_name"));
				myForm.setHabCode(rs1.getString("HABITATION_CODE"));
				myForm.setOldMobile(rs1.getString("MOBILE"));
				if (!serviceReq.equals("SMS")) {
					myForm.setModAuth(rs1.getString("TASK_AUTHORISED_CODE"));
					myForm.setTaskName(rs1.getString("TASK_AUTHORISED_NAME"));
				}
				myForm.setUsername(rs1.getString("USER_ID"));
				myForm.setPassword(rs1.getString("PASSWORD"));
				myForm.setServicereq(rs1.getString("SERVICE_REQUEST"));
			}

		} catch (SQLException e) {
			System.out.println("sql exception in getRegistredDetails method of SmsRegistrationDAO -- "+e);
		}
	}

	public String updateRegistrationDetails(RwsSmsRegistrationForm frm) {

		int rowCount;
		String message = "";

		rowCount = 0;
		PreparedStatement stmt4 = null;
		Connection conn = null;
		String qry = null;
	
		Rws_Encrypt_Random_Generation encrypt_Random_Generation = new Rws_Encrypt_Random_Generation();
		try {
			conn = RwsOffices.getConn();
			

			String mobile = "91" + frm.getPhoneNo();
			long rNo = encrypt_Random_Generation.createRandomInteger();

			if (frm.getServicereq().equals("S")) {
				
				qry = "update RWS_MOBILE_SMS_REGISTER_TBL set IMEI_NO= ? ,DATA_COLLECTOR_NAME=?,MOBILE=?,DESIGNATION=?,"
						+ "GENDER=? ,EMAILID=?,ADDRESS=?,Location=?,SERVICE_REQUEST=?  where Habitation_code=? and MOBILE=?";
			
				stmt4 = conn.prepareStatement(qry);
				
				stmt4.setString(1, frm.getImeino());
				stmt4.setString(2, frm.getDatecollname());
				stmt4.setString(3, mobile);
				stmt4.setString(4, frm.getDesgnation());
				stmt4.setString(5, frm.getGender());
				stmt4.setString(6, frm.getEmailId());
				stmt4.setString(7, frm.getAddress());
				stmt4.setString(8,  frm.getLocation());
				stmt4.setString(9,  frm.getServicereq());
				stmt4.setString(10, frm.getHabCode());
				stmt4.setString(11,  frm.getOldMobile());
				
			} else {

				qry = "update RWS_MOBILE_SMS_REGISTER_TBL set IMEI_NO= ? ,DATA_COLLECTOR_NAME=?,MOBILE=?,DESIGNATION=?,"
						+ "GENDER=? ,EMAILID=?,ADDRESS=?,Location=?,SERVICE_REQUEST=?  ,  USER_ID=?,PASSWORD=?,"
						+ "TASK_AUTHORISED_CODE=? where Habitation_code=? and MOBILE=?";
				
				stmt4 = conn.prepareStatement(qry);
				
				stmt4.setString(1, frm.getImeino());
				stmt4.setString(2, frm.getDatecollname());
				stmt4.setString(3, mobile);
				stmt4.setString(4, frm.getDesgnation());
				stmt4.setString(5, frm.getGender());
				stmt4.setString(6, frm.getEmailId());
				stmt4.setString(7, frm.getAddress());
				stmt4.setString(8,  frm.getLocation());
				stmt4.setString(9,  frm.getServicereq());
				stmt4.setString(10, frm.getUsername());
				stmt4.setString(11, frm.getPassword());
				stmt4.setString(12, frm.getModAuth());
				stmt4.setString(13, frm.getHabCode());
				stmt4.setString(14,  frm.getOldMobile());
		
			}
			
			rowCount = stmt4.executeUpdate();

			if (rowCount > 0) {
				encrypt_Random_Generation.generateEncryptRandomNumberUpdate(frm.getImeino(), rNo, mobile);
				message = "Record Updated Successfully";
			} else {
				message = "Record Cannot be Updated";
			}

		}

		catch (Exception e) {
			System.out.println(" exception in updateRegistrationDetails method of SmsRegistrationDAO -- "+e);
		}

		return message;

	}

	public ArrayList getHabitations(String dcode, String mcode, String pcode, String vcode)
			throws Exception {
		ArrayList habs = new ArrayList();

		String query = "";
		RwsLocationBean rwsLocation = null;
		try {
			conn = RwsOffices.getConn();
		
			query = "SELECT HAB_CODE,PANCH_CODE,PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL WHERE"
					+ " SUBSTR(HAB_CODE,1,2)=? AND SUBSTR(HAB_CODE,6,2)= ? AND " + "SUBSTR(HAB_CODE,13,2)=?";
			
			PreparedStatement stmt1 = conn.prepareStatement(query);
			stmt1.setString(1,dcode );
			stmt1.setString(2,mcode );
			stmt1.setString(3,pcode );
			rs = stmt1.executeQuery();

			while (rs.next()) {
				rwsLocation = new RwsLocationBean();
				rwsLocation.setHabitationCode(rs.getString(1));
				rwsLocation.setHabCode(rs.getString(2));
				rwsLocation.setHabName(rs.getString(3));
				habs.add(rwsLocation);

			}
		} catch (Exception e) {
		System.out.println("Exception in getHabitations of SmsRegistrationDAO-- "+e);
		} finally {
			closeAll();
		}
		return habs;
	}

	//

	public String getNextProposalId(String districtCode, DataSource dataSource) {
		String proposalId;
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		Date date = new Date();
		SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy");
		String currentYear = dateFormatter.format(date);
		String headOfficeName = "CM";
		String query = "";
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		proposalId = headOfficeName + currentYear + districtCode;
		Debug.println("Actual Complaintno " + proposalId);
		try {
			query = " SELECT MAX(SUBSTR(complaint_no,3,10)) as complaint_no FROM rws_complaints_register_tbl  WHERE complaint_no LIKE '"
					+ proposalId + "%'";
			complaintMasterData.conn = RwsOffices.getConn();
			stat = complaintMasterData.conn.createStatement();
			rset = stat.executeQuery(query);
			if (rset.next()) {
				int temp = rset.getInt(1);
				Debug.println("temp: " + temp);
				if (temp == 0) {
					proposalId = proposalId + "0001";
				} else {
					Debug.println("String.valueOf(temp).substring(6,10)" + String.valueOf(temp).substring(6, 10));
					int sno = Integer.parseInt(String.valueOf(temp).substring(6, 10));
					Debug.println("SNO is " + sno);
					String tempSNo = "";
					if (sno < 9)
						tempSNo = "000" + ++sno;
					else if (sno < 99)
						tempSNo = "00" + ++sno;
					else if (sno < 999)
						tempSNo = "0" + ++sno;
					else if (sno < 9999)
						tempSNo = String.valueOf(++sno);
					proposalId = proposalId + tempSNo;
				}
			}
			Debug.println("The Proposal ID Query is: " + query);
			Debug.println("The Proposal ID is: " + proposalId);
		} catch (Exception e) {
			Debug.writeln("Exception in getNextProposalId : \n" + e);
		} finally {
			if (rset != null)
				try {
					rset.close();
				} catch (SQLException sqlexception) {
				}
			if (stat != null)
				try {
					stat.close();
				} catch (SQLException sqlexception1) {
				}
			if (complaintMasterData.conn != null)
				try {
					complaintMasterData.conn.close();
				} catch (SQLException sqle) {
				}
		}
		return proposalId;
	}

	public String getNextComplaintNo(String districtCode, DataSource dataSource) {
		String complaintNo;
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		Date date = new Date();
		SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy");
		String currentYear = dateFormatter.format(date);
		String complaintName = "CM";
		String query = "";
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		complaintNo = currentYear;
		Debug.println("Actual Complaintno " + complaintNo);
		try {
			query = " SELECT MAX(complaint_no)+1 as complaint_no FROM rws_complaints_register_tbl  WHERE complaint_no LIKE '"
					+ complaintNo + "%'";
			complaintMasterData.conn = RwsOffices.getConn();
			stat = complaintMasterData.conn.createStatement();
			rset = stat.executeQuery(query);
			if (rset.next()) {
				int temp = rset.getInt(1);
				Debug.println("temp: " + temp);
				if (temp == 0) {
					complaintNo = complaintNo + "00001";
				} else {
					Debug.println("String.valueOf(temp).substring(6,10)" + String.valueOf(temp).substring(6, 10));
					int sno = Integer.parseInt(String.valueOf(temp).substring(6, 10));
					Debug.println("SNO is " + sno);
					String tempSNo = "";
					if (sno < 9)
						tempSNo = "000" + ++sno;
					else if (sno < 99)
						tempSNo = "00" + ++sno;
					else if (sno < 999)
						tempSNo = "0" + ++sno;
					else if (sno < 9999)
						tempSNo = String.valueOf(++sno);
					complaintNo = complaintNo + tempSNo;
				}
			}
			Debug.println("The Complaint No Query is: " + query);
			Debug.println("The Complaint No is: " + complaintNo);
		} catch (Exception e) {
			Debug.writeln("Exception in getNextComplaintNo : \n" + e);
		} finally {
			if (rset != null)
				try {
					rset.close();
				} catch (SQLException sqlexception) {
				}
			if (stat != null)
				try {
					stat.close();
				} catch (SQLException sqlexception1) {
				}
			if (complaintMasterData.conn != null)
				try {
					complaintMasterData.conn.close();
				} catch (SQLException sqle) {
				}
		}
		return complaintNo;
	}

	public static String getComplaintnonext(String dist, DataSource dataSource) throws Exception {
		String complaintno;
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		int rowCount = 0;
		Date date = new Date();
		SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy");
		String currentYear = dateFormatter.format(date);
		complaintno = dist + currentYear;
		 
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			Debug.println("Before Delete");
			String query = "";
			int i = 1;
			query = "select MAX(complaint_no)+1 from RWS_COMPLAINTS_REGISTER_TBL  ";
			Debug.println("After Delete" + query);
			complaintMasterData.rset = complaintMasterData.stmt.executeQuery(query);
			if (complaintMasterData.rset.next()) {
				Debug.println("max" + complaintMasterData.rset.getString(1));
				String temp = complaintMasterData.rset.getString(1);
				if (temp != null && temp.length() != 0) {
					if (temp.length() == 1)
						complaintno = "00" + temp;
					else if (temp.length() == 2)
						complaintno = "0" + temp;
					else
						complaintno = complaintno + temp;
				} else {
					complaintno = complaintno + "001";
				}
			}
			Debug.println("complaint No." + complaintno);
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			Debug.println("The error in deleteComplaints" + e);
		} finally {
			complaintMasterData.closeAll();
			Debug.println("ConnCount after closing is " + connCount);
		}
		return complaintno;
	}

	public static String getInserttablesw1(String tab, String dcode, DataSource dataSource, String resulthab) {
		String message;
		Connection conn = null;
		Connection con = null;
		Statement stmt = null;
		Statement stmt1 = null;
		Statement stmt3 = null;
		PreparedStatement ps = null;
		PreparedStatement ps1 = null;
		PreparedStatement ps2 = null;
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		String p = "";
		String ptr = "";
		int z = 0;
		int i = 0;
		String query2 = "";
		String query22 = "";
		String query33 = "";
		String query44 = "";
		String r = "";
		int r1 = 0;
		int columncount = 0;
		String a = "";
		String b = "";
		String c = "";
		String d = "";
		message = "";
		int count = 1;
		int columncount1 = 0;
		String r2 = "";
		String b1 = "";
		int k = 0;
		String database = "";
		SmsRegistrationDAO complaintMaster = new SmsRegistrationDAO();
		try {
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			String url = "jdbc:odbc:master";
			con = DriverManager.getConnection(url, "", "");
			DriverManager.registerDriver(new OracleDriver());
			conn = DriverManager.getConnection("jdbc:oracle:thin:@10.160.2.209:1521:wsoft", "preduser", "preduser");
			String query = "select * from " + tab + " ";
			if (resulthab.equals("panraj") || resulthab.equals("habitation"))
				query = query + " where substr(hab_code,1,2)='" + dcode + "'";
			else if (resulthab.equals("admn") || resulthab.equals("workexpenditure"))
				query = query + " where substr(work_id,5,2)='" + dcode + "'";
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
			columncount = rsmd.getColumnCount();
			while (rs.next()) {
				b = "";
				query22 = "";
				int pp = 1;
				for (int q = 1; q <= columncount; q++) {
					r = rs.getString(q);
					if (r != null && !r.equals("")) {
						b = b + rsmd.getColumnName(q) + ",";
						if (rsmd.getColumnTypeName(q).equals("DATE") && r != null && !r.equals("")) {
							String year = r.substring(0, 4);
							String month = r.substring(5, 7);
							String sdate = r.substring(8, 10);
							r = sdate + "/" + month + "/" + year;
						}
						query22 = query22 + "'" + r + "',";
					}
					pp++;
				}

				c = b.substring(0, b.lastIndexOf(","));
				d = tab + "(" + c + ")";
				query2 = "insert into " + d + "  values (";
				query33 = query22.substring(0, query22.lastIndexOf(","));
				query2 = query2 + query33 + ")";
				ps1 = con.prepareStatement(query2);
				i += ps1.executeUpdate();
			}
			if (i > 0)
				message = i + "Records are inserted & Downloading Completed";
			else
				message = "Records are not inserted";
		} catch (Exception g) {
			g.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (ps1 != null)
					ps1.close();
				if (conn != null)
					conn.close();
				if (con != null)
					con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return message;
	}

	public static String getInserttables(String tab, DataSource dataSource) {
		String message;
		Connection conn = null;
		Connection con = null;
		Statement stmt = null;
		Statement stmt1 = null;
		Statement stmt3 = null;
		PreparedStatement ps = null;
		PreparedStatement ps1 = null;
		PreparedStatement ps2 = null;
		ResultSet rs = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		String p = "";
		String ptr = "";
		int z = 0;
		int i = 0;
		String query2 = "";
		String query22 = "";
		String query33 = "";
		String query44 = "";
		String r = "";
		int r1 = 0;
		int columncount = 0;
		String a = "";
		String b = "";
		String c = "";
		String d = "";
		message = "";
		int count = 1;
		int columncount1 = 0;
		String r2 = "";
		String b1 = "";
		int k = 0;
		ComplaintMasterData complaintMaster = new ComplaintMasterData();
		try {
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			String url = "jdbc:odbc:master";
			con = DriverManager.getConnection(url, "", "");
			DriverManager.registerDriver(new OracleDriver());
			conn = DriverManager.getConnection("jdbc:oracle:thin:@10.160.2.209:1521:wsoft", "preduser", "preduser");
			String query = "select * from " + tab + " ";
			ps = conn.prepareStatement(query);
			rs = ps.executeQuery();
			ResultSetMetaData rsmd = rs.getMetaData();
			columncount = rsmd.getColumnCount();
			while (rs.next()) {
				ptr = "";
				for (k = 1; k <= columncount; k++) {
					r = rs.getString(k);
					if (r != null && r.equals(""))
						ptr = ptr + "'" + r + "'" + ",";
				}

				b1 = ptr.substring(0, ptr.lastIndexOf(","));
				query2 = "insert into " + tab + " values(";
				query22 = query2 + b1 + ")";
				ps1 = con.prepareStatement(query22);
				i += ps1.executeUpdate();
			}
			if (i > 0)
				message = i + "Records are inserted & Downloading Completed";
			else
				message = "Records are not inserted";
		} catch (Exception g) {
			g.printStackTrace();
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (ps != null)
					ps.close();
				if (ps1 != null)
					ps1.close();
				if (conn != null)
					conn.close();
				if (con != null)
					con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return message;
	}

	public static int tabExistsdata(String tab, String dcode, DataSource dataSource, String resulthab) {
		int count;
		Connection conn = null;
		Statement st1 = null;
		ResultSet rs1 = null;
		count = 0;
		try {
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			String url = "jdbc:odbc:master";
			conn = DriverManager.getConnection(url, "", "");
			String query = null;
			query = "select count(*) from " + tab + " ";
			if (resulthab.equals("panraj") || resulthab.equals("habitation"))
				query = query + " where mid(hab_code,1,2)='" + dcode + "'";
			else if (resulthab.equals("admn") || resulthab.equals("workcomp"))
				query = query + " where mid(work_id,5,2)='" + dcode + "'";
			st1 = conn.createStatement();
			rs1 = st1.executeQuery(query);
			for (; rs1.next();) {
				count = rs1.getInt(1);
			}

		} catch (Exception o) {
			o.printStackTrace();
		} finally {
			try {
				if (rs1 != null)
					rs1.close();
				if (st1 != null)
					st1.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return count;
	}

	public static String tabExistsdel(String tab, String dcode, DataSource dataSource, String resulthab) {
		boolean exists;
		String message;
		exists = false;
		message = null;
		Connection conn = null;
		Statement st1 = null;
		ResultSet rs1 = null;
		int i = 0;
		try {
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			String url = "jdbc:odbc:master";
			conn = DriverManager.getConnection(url, "", "");
			String query = "delete * from " + tab + " ";
			if (resulthab.equals("panraj") || resulthab.equals("habitation"))
				query = query + " where mid(hab_code,1,2)='" + dcode + "'";
			if (resulthab.equals("admn") || resulthab.equals("workexpenditure"))
				query = query + " where mid(work_id,5,2)='" + dcode + "'";
			st1 = conn.createStatement();
			i += st1.executeUpdate(query);
			if (i > 0)
				message = "Recordsaredeleted";
			else
				message = "Recordsarenotdeleted";
		} catch (Exception e) {
			exists = false;
		} finally {
			try {
				if (rs1 != null)
					rs1.close();
				if (st1 != null)
					st1.close();
				if (conn != null)
					conn.close();
			} catch (Exception e) {
			}
		}
		return message;
	}

	public void closeAll() throws Exception {
		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs = null;
		}
		if (rs1 != null) {
			try {
				rs1.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs1 = null;
		}
		if (rs2 != null) {
			try {
				rs2.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs2 = null;
		}
		if (rs3 != null) {
			try {
				rs3.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs3 = null;
		}
		if (rs4 != null) {
			try {
				rs4.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs4 = null;
		}
		if (rs5 != null) {
			try {
				rs5.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs5 = null;
		}
		if (rs6 != null) {
			try {
				rs6.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs6 = null;
		}
		if (rs7 != null) {
			try {
				rs7.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs7 = null;
		}
		if (rs8 != null) {
			try {
				rs8.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs8 = null;
		}
		if (rs9 != null) {
			try {
				rs9.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs9 = null;
		}
		if (rs10 != null) {
			try {
				rs10.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs10 = null;
		}
		if (rs11 != null) {
			try {
				rs11.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs11 = null;
		}
		if (rs12 != null) {
			try {
				rs12.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs12 = null;
		}
		if (rs13 != null) {
			try {
				rs13.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs13 = null;
		}
		if (rs14 != null) {
			try {
				rs14.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs14 = null;
		}
		if (rs15 != null) {
			try {
				rs15.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs15 = null;
		}
		if (rs16 != null) {
			try {
				rs16.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs16 = null;
		}
		if (rs17 != null) {
			try {
				rs17.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs17 = null;
		}
		if (rs18 != null) {
			try {
				rs18.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs18 = null;
		}
		if (rs19 != null) {
			try {
				rs19.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs19 = null;
		}
		if (rs20 != null) {
			try {
				rs20.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs20 = null;
		}
		if (rs21 != null) {
			try {
				rs21.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs21 = null;
		}
		if (rs22 != null) {
			try {
				rs22.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs22 = null;
		}
		if (rs23 != null) {
			try {
				rs23.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs23 = null;
		}
		if (rs24 != null) {
			try {
				rs24.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs24 = null;
		}
		if (rset != null) {
			try {
				rset.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rset = null;
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
		if (stmt5 != null) {
			try {
				stmt5.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt5 = null;
		}
		if (stmt6 != null) {
			try {
				stmt6.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt6 = null;
		}
		if (stmt7 != null) {
			try {
				stmt7.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt7 = null;
		}
		if (stmt8 != null) {
			try {
				stmt8.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt8 = null;
		}
		if (stmt9 != null) {
			try {
				stmt9.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt9 = null;
		}
		if (stmt10 != null) {
			try {
				stmt10.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt10 = null;
		}
		if (stmt11 != null) {
			try {
				stmt11.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt11 = null;
		}
		if (stmt12 != null) {
			try {
				stmt12.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt12 = null;
		}
		if (stmt13 != null) {
			try {
				stmt13.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt13 = null;
		}
		if (stmt14 != null) {
			try {
				stmt14.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt14 = null;
		}
		if (stmt15 != null) {
			try {
				stmt15.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt15 = null;
		}
		if (stmt16 != null) {
			try {
				stmt16.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt16 = null;
		}
		if (stmt17 != null) {
			try {
				stmt17.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt17 = null;
		}
		if (stmt18 != null) {
			try {
				stmt18.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt18 = null;
		}
		if (stmt19 != null) {
			try {
				stmt19.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt19 = null;
		}
		if (stmt20 != null) {
			try {
				stmt20.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt20 = null;
		}
		if (stmt21 != null) {
			try {
				stmt21.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt21 = null;
		}
		if (stmt22 != null) {
			try {
				stmt22.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt22 = null;
		}
		if (stmt23 != null) {
			try {
				stmt23.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt23 = null;
		}
		if (stmt24 != null) {
			try {
				stmt24.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt24 = null;
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
				if (conn.isClosed())
					connCount--;
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			conn = null;
		}
	}

	public ArrayList getDistricts(DataSource dataSource) throws Exception {
		ArrayList districts;
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		districts = new ArrayList();
		RwsSmsRegistrationForm compForm = null;
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			for (complaintMasterData.rs = complaintMasterData.stmt.executeQuery(
					"SELECT distinct d.dcode,d.dname FROM RWS_DISTRICT_TBL d ORDER BY d.DNAME"); complaintMasterData.rs
							.next(); districts.add(compForm)) {
				compForm = new RwsSmsRegistrationForm();
				compForm.setDistrictCode(complaintMasterData.rs.getString(1));
				compForm.setDistrictName(complaintMasterData.rs.getString(2));
				compForm.setCodeName(complaintMasterData.rs.getString(2) + " - " + complaintMasterData.rs.getString(1));
			}

		} catch (Exception e) {
			System.out.println("Exception" + e);
		} finally {
			complaintMasterData.closeAll();
		}
		return districts;
	}

	public ArrayList getDistricts1(DataSource dataSource) throws Exception {
		ArrayList districts;
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		districts = new ArrayList();
		RwsSmsRegistrationForm compForm = null;
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			for (complaintMasterData.rs = complaintMasterData.stmt.executeQuery(
					"SELECT DISTINCT DCODE,DNAME FROM RWS_DISTRICT_TBL  ORDER BY DCODE"); complaintMasterData.rs
							.next(); districts.add(compForm)) {
				compForm = new RwsSmsRegistrationForm();
				compForm.setDistrictCode(complaintMasterData.rs.getString(1));
				compForm.setDistrictName(complaintMasterData.rs.getString(2));
				compForm.setCodeName(complaintMasterData.rs.getString(2) + " - " + complaintMasterData.rs.getString(1));
			}

		} catch (Exception e) {
			System.out.println("Exception" + e);
		} finally {
			complaintMasterData.closeAll();
		}
		return districts;
	}

	public ArrayList getMandals(String dcode, DataSource dataSource) throws Exception {
		ArrayList mandals;
		RwsSmsRegistrationForm compForm = null;
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		mandals = new ArrayList();
		String query = "";
		try {
			query = "SELECT distinct m.mcode,m.mname FROM RWS_MANDAL_TBL M where  m.dcode='" + dcode
					+ "'   ORDER BY M.MNAME";
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			Debug.println("Mandalquery" + query);
			for (; complaintMasterData.rs.next(); mandals.add(compForm)) {
				compForm = new RwsSmsRegistrationForm();
				compForm.setMandalCode(complaintMasterData.rs.getString(1));
				compForm.setMandalName(complaintMasterData.rs.getString(2));
				compForm.setCodeName(complaintMasterData.rs.getString(2) + " - " + complaintMasterData.rs.getString(1));
			}

		} catch (Exception e) {
			System.out.println("Exception" + e);
		} finally {
			complaintMasterData.closeAll();
		}
		return mandals;
	}

	public ArrayList getPanchayats(String dcode, String mcode, DataSource dataSource) throws Exception {
		ArrayList panchayats;
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		panchayats = new ArrayList();
		RwsSmsRegistrationForm compForm = null;
		String query = "";
		try {
			query = "SELECT distinct p.pcode,p.pname FROM rws_panchayat_tbl p where p.dcode='" + dcode
					+ "' and p.mcode='" + mcode + "'   ORDER BY p.PNAME ";
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			Debug.println("Panchayatquery" + query);
			for (; complaintMasterData.rs.next(); panchayats.add(compForm)) {
				compForm = new RwsSmsRegistrationForm();
				compForm.setPanchayatCode(complaintMasterData.rs.getString(1));
				compForm.setPanchayatName(complaintMasterData.rs.getString(2));
				compForm.setCodeName(complaintMasterData.rs.getString(2) + " - " + complaintMasterData.rs.getString(1));
			}

		} catch (Exception e) {
			System.out.println("Exception" + e);
		} finally {
			complaintMasterData.closeAll();
		}
		return panchayats;
	}

	public ArrayList getCompDistricts(DataSource dataSource) throws Exception {
		ArrayList districts;
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		LabelValueBean compForm = null;
		districts = new ArrayList();
		String query = "";
		try {
			 
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select distinct d.dcode,d.dname from rws_district_tbl d,rws_complaints_register_tbl c where d.dcode=substr(c.component_code,1,2) order by d.dname";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			Debug.println("Query" + query);
			while (complaintMasterData.rs.next()) {
				compForm = new LabelValueBean();
				compForm.setValue(complaintMasterData.rs.getString(1));
				compForm.setLabel(complaintMasterData.rs.getString(2));
				compForm.setLabelValue(
						complaintMasterData.rs.getString(2) + " - " + complaintMasterData.rs.getString(1));
				districts.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getCompdistricts=" + e);
		} finally {
			complaintMasterData.closeAll();
			Debug.println("ConnCount after closing is " + connCount);
		}
		return districts;
	}

	//
	public ArrayList getCompDistrictsgeneric(DataSource dataSource) throws Exception {
		ArrayList districts;
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		LabelValueBean compForm = null;
		districts = new ArrayList();
		String query = "";
		try {
			 
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select distinct d.dcode,d.dname from rws_district_tbl d,rws_generic_complaints_reg_tbl c where d.dcode=substr(c.habitation_code,1,2) order by d.dname";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			Debug.println("Query" + query);
			while (complaintMasterData.rs.next()) {
				compForm = new LabelValueBean();
				compForm.setValue(complaintMasterData.rs.getString(1));
				compForm.setLabel(complaintMasterData.rs.getString(2));
				compForm.setLabelValue(
						complaintMasterData.rs.getString(2) + " - " + complaintMasterData.rs.getString(1));
				districts.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getCompdistricts=" + e);
		} finally {
			complaintMasterData.closeAll();
			Debug.println("ConnCount after closing is " + connCount);
		}
		return districts;
	}

	//

	public ArrayList getCompCircles(String headoffice, DataSource dataSource) throws Exception {
		ArrayList circles;
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		LabelValueBean compForm = null;
		circles = new ArrayList();
		String query = "";
		try {
			 
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select distinct d.circle_office_code,d.circle_office_name from rws_circle_office_tbl d,rws_complaints_register_tbl c where d.circle_office_code=substr(c.component_code,1,2) and head_office_code='"
					+ headoffice + "' order by d.circle_office_name";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			Debug.println("Query" + query);
			while (complaintMasterData.rs.next()) {
				compForm = new LabelValueBean();
				compForm.setValue(complaintMasterData.rs.getString(1));
				compForm.setLabel(complaintMasterData.rs.getString(2));
				compForm.setLabelValue(
						complaintMasterData.rs.getString(2) + " - " + complaintMasterData.rs.getString(1));
				circles.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getCompcircles=" + e);
		} finally {
			complaintMasterData.closeAll();
			Debug.println("ConnCount after closing is " + connCount);
		}
		return circles;
	}

	//
	public ArrayList getCompCirclesgeneric(String headoffice, DataSource dataSource) throws Exception {
		ArrayList circles;
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		LabelValueBean compForm = null;
		circles = new ArrayList();
		String query = "";
		try {
			 
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select distinct d.circle_office_code,d.circle_office_name from rws_circle_office_tbl d,rws_generic_complaints_reg_tbl c where d.circle_office_code=substr(c.habitation_code,1,2) and head_office_code='"
					+ headoffice + "' and complaint_status is null order by d.circle_office_name ";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			Debug.println("Query" + query);
			while (complaintMasterData.rs.next()) {
				compForm = new LabelValueBean();
				compForm.setValue(complaintMasterData.rs.getString(1));
				compForm.setLabel(complaintMasterData.rs.getString(2));
				compForm.setLabelValue(
						complaintMasterData.rs.getString(2) + " - " + complaintMasterData.rs.getString(1));
				circles.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getCompcircles=" + e);
		} finally {
			complaintMasterData.closeAll();
			Debug.println("ConnCount after closing is " + connCount);
		}
		return circles;
	}

	//

	public ArrayList getCompMandals(String dcode, DataSource dataSource) throws Exception {
		ArrayList mandals;
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		LabelValueBean compForm = null;
		mandals = new ArrayList();
		String query = "";
		try {
			 
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();

			query = "select distinct d.dcode,d.mcode,d.mname from rws_mandal_tbl d,rws_complaints_register_tbl c where  d.dcode='"
					+ dcode
					+ "' and d.mcode=substr(c.component_code,6,2) and d.dcode=substr(c.component_code,1,2) order by d.mname";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			Debug.println("Query" + query);
			while (complaintMasterData.rs.next()) {
				compForm = new LabelValueBean();
				compForm.setValue(complaintMasterData.rs.getString(2));
				compForm.setLabel(complaintMasterData.rs.getString(3));
				compForm.setLabelValue(
						complaintMasterData.rs.getString(3) + " - " + complaintMasterData.rs.getString(2));
				mandals.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getCompMandals=" + e);
		} finally {
			complaintMasterData.closeAll();
			Debug.println("ConnCount after closing is " + connCount);
		}
		return mandals;
	}

	//
	public ArrayList getCompMandalsgenericno(String dcode, DataSource dataSource) throws Exception {
		ArrayList mandals;
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		LabelValueBean compForm = null;
		mandals = new ArrayList();
		String query = "";
		try {
			 
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();

			query = "select distinct d.dcode,d.mcode,d.mname from rws_mandal_tbl d,rws_generic_complaints_reg_tbl c where  d.dcode='"
					+ dcode
					+ "' and d.mcode=substr(c.habitation_code,6,2) and d.dcode=substr(c.habitation_code,1,2) order by d.mname";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			Debug.println("Query" + query);
			while (complaintMasterData.rs.next()) {
				compForm = new LabelValueBean();
				compForm.setValue(complaintMasterData.rs.getString(2));
				compForm.setLabel(complaintMasterData.rs.getString(3));
				compForm.setLabelValue(
						complaintMasterData.rs.getString(3) + " - " + complaintMasterData.rs.getString(2));
				mandals.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getCompMandals=" + e);
		} finally {
			complaintMasterData.closeAll();
			Debug.println("ConnCount after closing is " + connCount);
		}
		return mandals;
	}

	//
	public ArrayList getCompMandalsgeneric(String dcode, DataSource dataSource) throws Exception {
		ArrayList mandals;
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		LabelValueBean compForm = null;
		mandals = new ArrayList();
		String query = "";
		try {
			 
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();

			query = "select distinct d.dcode,d.mcode,d.mname from rws_mandal_tbl d,rws_generic_complaints_reg_tbl c where  d.dcode='"
					+ dcode
					+ "' and d.mcode=substr(c.habitation_code,6,2) and d.dcode=substr(c.habitation_code,1,2) and complaint_status is null order by d.mname";
			Debug.println("query" + query);
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			Debug.println("Query" + query);
			while (complaintMasterData.rs.next()) {
				compForm = new LabelValueBean();
				compForm.setValue(complaintMasterData.rs.getString(2));
				compForm.setLabel(complaintMasterData.rs.getString(3));
				compForm.setLabelValue(
						complaintMasterData.rs.getString(3) + " - " + complaintMasterData.rs.getString(2));
				mandals.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getCompMandals=" + e);
		} finally {
			complaintMasterData.closeAll();
			Debug.println("ConnCount after closing is " + connCount);
		}
		return mandals;
	}

	//
	public ArrayList getCompMandalsgenerics(String dcode, DataSource dataSource) throws Exception {
		ArrayList mandals;
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		LabelValueBean compForm = null;
		mandals = new ArrayList();
		String query = "";
		try {
			 
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();

			query = "select distinct d.dcode,d.mcode,d.mname from rws_mandal_tbl d,rws_generic_complaints_reg_tbl c where  d.dcode='"
					+ dcode
					+ "' and d.mcode=substr(c.habitation_code,6,2) and d.dcode=substr(c.habitation_code,1,2)  order by d.mname";
			Debug.println("query" + query);
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			Debug.println("Query" + query);
			while (complaintMasterData.rs.next()) {
				compForm = new LabelValueBean();
				compForm.setValue(complaintMasterData.rs.getString(2));
				compForm.setLabel(complaintMasterData.rs.getString(3));
				compForm.setLabelValue(
						complaintMasterData.rs.getString(3) + " - " + complaintMasterData.rs.getString(2));
				mandals.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getCompMandals=" + e);
		} finally {
			complaintMasterData.closeAll();
			Debug.println("ConnCount after closing is " + connCount);
		}
		return mandals;
	}

	//

	public ArrayList getCompPanchayats(String dcode, String mcode, DataSource dataSource) throws Exception {
		ArrayList panchayats;
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		LabelValueBean compForm = null;
		panchayats = new ArrayList();
		String query = "";
		try {
			 
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select distinct d.dcode,d.mcode,d.pcode,d.pname from rws_panchayat_tbl d,rws_complaints_register_tbl c where  d.dcode='"
					+ dcode + "' and d.mcode='" + mcode
					+ "' and substr(c.component_code,13,2)=d.pcode and substr(c.component_code,1,2)=d.dcode and substr(c.component_code,6,2)=d.mcode order by d.pname";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			Debug.println("Query" + query);
			//
			while (complaintMasterData.rs.next()) {
				compForm = new LabelValueBean();
				compForm.setValue(complaintMasterData.rs.getString(3));
				compForm.setLabel(complaintMasterData.rs.getString(4));
				compForm.setLabelValue(
						complaintMasterData.rs.getString(4) + " - " + complaintMasterData.rs.getString(3));
				panchayats.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getCompPanchayats=" + e);
		} finally {
			complaintMasterData.closeAll();
			Debug.println("ConnCount after closing is " + connCount);
		}
		return panchayats;
	}

	//
	public ArrayList getCompPanchayatsgenericno(String dcode, String mcode, DataSource dataSource) throws Exception {
		ArrayList panchayats;
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		LabelValueBean compForm = null;
		panchayats = new ArrayList();
		String query = "";
		try {
			 
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select distinct d.dcode,d.mcode,d.pcode,d.pname from rws_panchayat_tbl d,rws_generic_complaints_reg_tbl c where  d.dcode='"
					+ dcode + "' and d.mcode='" + mcode
					+ "' and substr(c.habitation_code,13,2)=d.pcode and substr(c.habitation_code,1,2)=d.dcode and substr(c.habitation_code,6,2)=d.mcode order by d.pname";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			Debug.println("Query" + query);
			//
			while (complaintMasterData.rs.next()) {
				compForm = new LabelValueBean();
				compForm.setValue(complaintMasterData.rs.getString(3));
				compForm.setLabel(complaintMasterData.rs.getString(4));
				compForm.setLabelValue(
						complaintMasterData.rs.getString(4) + " - " + complaintMasterData.rs.getString(3));
				panchayats.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getCompPanchayats=" + e);
		} finally {
			complaintMasterData.closeAll();
			Debug.println("ConnCount after closing is " + connCount);
		}
		return panchayats;
	}

	//
	public ArrayList getCompPanchayatsgeneric(String dcode, String mcode, DataSource dataSource) throws Exception {
		ArrayList panchayats;
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		LabelValueBean compForm = null;
		panchayats = new ArrayList();
		String query = "";
		try {
			 
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select distinct d.dcode,d.mcode,d.pcode,d.pname from rws_panchayat_tbl d,rws_generic_complaints_reg_tbl c where  d.dcode='"
					+ dcode + "' and d.mcode='" + mcode
					+ "' and substr(c.habitation_code,13,2)=d.pcode and substr(c.habitation_code,1,2)=d.dcode and substr(c.habitation_code,6,2)=d.mcode and complaint_status is null order by d.pname";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			//
			while (complaintMasterData.rs.next()) {
				compForm = new LabelValueBean();
				compForm.setValue(complaintMasterData.rs.getString(3));
				compForm.setLabel(complaintMasterData.rs.getString(4));
				compForm.setLabelValue(
						complaintMasterData.rs.getString(4) + " - " + complaintMasterData.rs.getString(3));
				panchayats.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getCompPanchayats=" + e);
		} finally {
			complaintMasterData.closeAll();
			Debug.println("ConnCount after closing is " + connCount);
		}
		return panchayats;
	}

	//
	public ArrayList getCompPanchayatsgenerics(String dcode, String mcode, DataSource dataSource) throws Exception {
		ArrayList panchayats;
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		LabelValueBean compForm = null;
		panchayats = new ArrayList();
		String query = "";
		try {
			 
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select distinct d.dcode,d.mcode,d.pcode,d.pname from rws_panchayat_tbl d,rws_generic_complaints_reg_tbl c where  d.dcode='"
					+ dcode + "' and d.mcode='" + mcode
					+ "' and substr(c.habitation_code,13,2)=d.pcode and substr(c.habitation_code,1,2)=d.dcode and substr(c.habitation_code,6,2)=d.mcode  order by d.pname";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			//
			while (complaintMasterData.rs.next()) {
				compForm = new LabelValueBean();
				compForm.setValue(complaintMasterData.rs.getString(3));
				compForm.setLabel(complaintMasterData.rs.getString(4));
				compForm.setLabelValue(
						complaintMasterData.rs.getString(4) + " - " + complaintMasterData.rs.getString(3));
				panchayats.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getCompPanchayats=" + e);
		} finally {
			complaintMasterData.closeAll();
			Debug.println("ConnCount after closing is " + connCount);
		}
		return panchayats;
	}

	//
	//

	public ArrayList getCompHabsgeneric(String dcode, String mcode, String pcode, DataSource dataSource)
			throws Exception {
		ArrayList habs;
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		LabelValueBean compForm = null;
		habs = new ArrayList();
		String query = "";
		try {
			 
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "SELECT distinct  P.PANCH_CODE,P.PANCH_NAME FROM "
					+ "RWS_PANCHAYAT_RAJ_TBL P, RWS_HABITATION_DIRECTORY_TBL H,rws_generic_complaints_reg_tbl c WHERE SUBSTR(P.PANCH_CODE,1,2)='"
					+ dcode + "' AND SUBSTR(P.PANCH_CODE,6,2)='" + mcode + "' AND SUBSTR(P.PANCH_CODE,13,2)='" + pcode
					+ "' AND "
					+ " H.HAB_CODE=P.PANCH_CODE AND H.COVERAGE_STATUS <> 'UI' and c.habitation_code=p.panch_code  and c.habitation_code=h.hab_code and complaint_status is null ORDER BY P.PANCH_NAME";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			while (complaintMasterData.rs.next()) {
				compForm = new LabelValueBean();
				compForm.setValue(complaintMasterData.rs.getString(1));
				compForm.setLabel(complaintMasterData.rs.getString(2));
				compForm.setLabelValue(
						complaintMasterData.rs.getString(2) + " - " + complaintMasterData.rs.getString(1));
				habs.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getCompHabitations=" + e);
		} finally {
			complaintMasterData.closeAll();
			Debug.println("ConnCount after closing is " + connCount);
		}
		return habs;
	}

	public ArrayList getCompHabs(String dcode, String mcode, String pcode, DataSource dataSource) throws Exception {
		ArrayList habs;
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		LabelValueBean compForm = null;
		habs = new ArrayList();
		String query = "";
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = " SELECT distinct  P.PANCH_CODE,P.PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL P, RWS_HABITATION_DIRECTORY_TBL H,rws_complaints_register_tbl c WHERE SUBSTR(P.PANCH_CODE,1,2)='"
					+ dcode + "' AND SUBSTR(P.PANCH_CODE,6,2)='" + mcode + "' AND SUBSTR(P.PANCH_CODE,13,2)='" + pcode
					+ "' AND "
					+ " H.HAB_CODE=P.PANCH_CODE AND H.COVERAGE_STATUS <> 'UI' and substr(c.component_code,1,16)=p.panch_code  and substr(c.component_code,1,16)=h.hab_code  ORDER BY P.PANCH_NAME";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			while (complaintMasterData.rs.next()) {
				compForm = new LabelValueBean();
				compForm.setValue(complaintMasterData.rs.getString(1));
				compForm.setLabel(complaintMasterData.rs.getString(2));
				compForm.setLabelValue(
						complaintMasterData.rs.getString(2) + " - " + complaintMasterData.rs.getString(1));
				habs.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getCompHabitations=" + e);
		} finally {
			complaintMasterData.closeAll();
			Debug.println("ConnCount after closing is " + connCount);
		}
		return habs;
	}

	public ArrayList getCompVillages(String dcode, String mcode, String pcode, DataSource dataSource) throws Exception {
		ArrayList villages;
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		LabelValueBean compForm = null;
		villages = new ArrayList();
		String query = "";
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select distinct d.dcode,d.mcode,d.pcode,d.vcode,d.vname from rws_village_tbl d,rws_complaints_register_tbl c where  d.dcode='"
					+ dcode + "' and d.mcode='" + mcode + "' and d.pcode='" + pcode
					+ "' and substr(c.component_code,8,3)=d.vcode and substr(c.component_code,1,2)=d.dcode and substr(c.component_code,6,2)=d.mcode and substr(c.component_code,13,2)=d.pcode"
					+ " order by d.vname";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			while (complaintMasterData.rs.next()) {
				compForm = new LabelValueBean();
				compForm.setValue(complaintMasterData.rs.getString(4));
				compForm.setLabel(complaintMasterData.rs.getString(5));
				compForm.setLabelValue(
						complaintMasterData.rs.getString(5) + " - " + complaintMasterData.rs.getString(4));
				villages.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getCompVillages=" + e);
		} finally {
			complaintMasterData.closeAll();
			Debug.println("ConnCount after closing is " + connCount);
		}
		return villages;
	}

	//
	public ArrayList getCompVillagesgeneric(String dcode, String mcode, String pcode, DataSource dataSource)
			throws Exception {
		ArrayList villages;
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		LabelValueBean compForm = null;
		villages = new ArrayList();
		String query = "";
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select distinct d.dcode,d.mcode,d.pcode,d.vcode,d.vname from rws_village_tbl d,rws_generic_complaints_reg_tbl c where  d.dcode='"
					+ dcode + "' and d.mcode='" + mcode + "' and d.pcode='" + pcode
					+ "' and substr(c.habitation_code,8,3)=d.vcode and substr(c.habitation_code,1,2)=d.dcode and substr(c.habitation_code,6,2)=d.mcode and substr(c.habitation_code,13,2)=d.pcode"
					+ " order by d.vname";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			while (complaintMasterData.rs.next()) {
				compForm = new LabelValueBean();
				compForm.setValue(complaintMasterData.rs.getString(4));
				compForm.setLabel(complaintMasterData.rs.getString(5));
				compForm.setLabelValue(
						complaintMasterData.rs.getString(5) + " - " + complaintMasterData.rs.getString(4));
				villages.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getCompVillages=" + e);
		} finally {
			complaintMasterData.closeAll();
			Debug.println("ConnCount after closing is " + connCount);
		}
		return villages;
	}

	//

	public ArrayList getCompHabitations(String dcode, String mcode, String pcode, String vcode, DataSource dataSource)
			throws Exception {
		ArrayList habs;
		habs = new ArrayList();
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		LabelValueBean compForm = null;
		String query = "";
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			// query =
			// " SELECT distinct H.HAB_CODE,P.PANCH_CODE,P.PANCH_NAME,H.COVERAGE_STATUS FROM
			// RWS_PANCHAYAT_RAJ_TBL P, RWS_HABITATION_DIRECTORY_TBL
			// H,rws_complaints_register_tbl c WHERE SUBSTR(P.PANCH_CODE,1,2)='"
			// + dcode + "' AND SUBSTR(P.PANCH_CODE,6,2)='" + mcode +
			// "' AND SUBSTR(P.PANCH_CODE,13,2)='" + pcode + "' AND " +
			// " H.HAB_CODE=P.PANCH_CODE AND H.COVERAGE_STATUS <> 'UI' and
			// substr(c.component_code,1,16)=p.panch_code and
			// substr(c.component_code,8,3)='"
			// + vcode +
			// "' and substr(c.component_code,1,16)=h.hab_code ORDER BY P.PANCH_NAME";
			query = " SELECT distinct  P.PANCH_CODE,P.PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL P, RWS_HABITATION_DIRECTORY_TBL H,rws_complaints_register_tbl c WHERE SUBSTR(P.PANCH_CODE,1,2)='"
					+ dcode + "' AND SUBSTR(P.PANCH_CODE,6,2)='" + mcode + "' AND SUBSTR(P.PANCH_CODE,13,2)='" + pcode
					+ "' AND "
					+ " H.HAB_CODE=P.PANCH_CODE AND H.COVERAGE_STATUS <> 'UI' and substr(c.component_code,1,16)=p.panch_code and substr(c.component_code,8,3)='"
					+ vcode + "' and substr(c.component_code,1,16)=h.hab_code  ORDER BY P.PANCH_NAME";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			while (complaintMasterData.rs.next()) {
				compForm = new LabelValueBean();
				compForm.setValue(complaintMasterData.rs.getString(1));
				compForm.setLabel(complaintMasterData.rs.getString(2));
				compForm.setLabelValue(
						complaintMasterData.rs.getString(2) + " - " + complaintMasterData.rs.getString(1));
				habs.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getCompHabitations=" + e);
		} finally {
			complaintMasterData.closeAll();
			Debug.println("ConnCount after closing is " + connCount);
		}
		return habs;
	}

	//
	public ArrayList getCompHabitationsgeneric(String dcode, String mcode, String pcode, String vcode,
			DataSource dataSource) throws Exception {
		ArrayList habs;
		habs = new ArrayList();
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		LabelValueBean compForm = null;
		String query = "";
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			// query =
			// " SELECT distinct H.HAB_CODE,P.PANCH_CODE,P.PANCH_NAME,H.COVERAGE_STATUS FROM
			// RWS_PANCHAYAT_RAJ_TBL P, RWS_HABITATION_DIRECTORY_TBL
			// H,rws_complaints_register_tbl c WHERE SUBSTR(P.PANCH_CODE,1,2)='"
			// + dcode + "' AND SUBSTR(P.PANCH_CODE,6,2)='" + mcode +
			// "' AND SUBSTR(P.PANCH_CODE,13,2)='" + pcode + "' AND " +
			// " H.HAB_CODE=P.PANCH_CODE AND H.COVERAGE_STATUS <> 'UI' and
			// substr(c.component_code,1,16)=p.panch_code and
			// substr(c.component_code,8,3)='"
			// + vcode +
			// "' and substr(c.component_code,1,16)=h.hab_code ORDER BY P.PANCH_NAME";
			query = " SELECT distinct  P.PANCH_CODE,P.PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL P, RWS_HABITATION_DIRECTORY_TBL H,rws_generic_complaints_reg_tbl c WHERE SUBSTR(P.PANCH_CODE,1,2)='"
					+ dcode + "' AND SUBSTR(P.PANCH_CODE,6,2)='" + mcode + "' AND SUBSTR(P.PANCH_CODE,13,2)='" + pcode
					+ "' AND "
					+ " H.HAB_CODE=P.PANCH_CODE AND H.COVERAGE_STATUS <> 'UI' and c.habitation_code=p.panch_code and substr(c.habitation_code,8,3)='"
					+ vcode + "' and c.habitation_code=h.hab_code  ORDER BY P.PANCH_NAME";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			while (complaintMasterData.rs.next()) {
				compForm = new LabelValueBean();
				compForm.setValue(complaintMasterData.rs.getString(1));
				compForm.setLabel(complaintMasterData.rs.getString(2));
				compForm.setLabelValue(
						complaintMasterData.rs.getString(2) + " - " + complaintMasterData.rs.getString(1));
				habs.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getCompHabitations=" + e);
		} finally {
			complaintMasterData.closeAll();
			Debug.println("ConnCount after closing is " + connCount);
		}
		return habs;
	}

	public static String getNextComplaintNo(String districtCode, String typeOfAsset, String mandalCode,
			String panchayatCode, DataSource dataSource) {
		String complaintNo;
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		Date date = new Date();
		SimpleDateFormat dateFormatter = new SimpleDateFormat("yy");
		String currentYear = dateFormatter.format(date);
		complaintNo = null;
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt1 = complaintMasterData.conn.createStatement();
			complaintNo = districtCode + mandalCode + panchayatCode + typeOfAsset + currentYear;
			String query = " SELECT MAX(SUBSTR(complaint_no,11,4)) as complaint_no FROM RWS_complaints_register_tbl  WHERE complaint_no LIKE '"
					+ complaintNo + "%'";
			complaintMasterData.rs1 = complaintMasterData.stmt1.executeQuery(query);
			if (complaintMasterData.rs1.next()) {
				int sno = complaintMasterData.rs1.getInt(1);
				if (sno == 0) {
					complaintNo = complaintNo + "0001";
				} else {
					if (sno >= 9999)
						throw new Exception("No more WORK ID left.");
					String tempSno = null;
					if (sno < 9)
						tempSno = "000" + (sno + 1);
					else if (sno < 99)
						tempSno = "00" + (sno + 1);
					else if (sno < 999)
						tempSno = "0" + (sno + 1);
					else
						tempSno = String.valueOf(sno + 1);
					complaintNo = complaintNo + String.valueOf(tempSno);
				}
			}
		} catch (Exception e) {
			Debug.writeln("Exception in getComplaintNo : \n" + e);
		} finally {
			if (complaintMasterData.rs1 != null)
				try {
					complaintMasterData.rs1.close();
				} catch (SQLException sqlexception) {
				}
			if (complaintMasterData.stmt1 != null)

				try {
					complaintMasterData.stmt1.close();
				} catch (SQLException sqlexception1) {
				}
			if (complaintMasterData.conn != null)
				try {
					complaintMasterData.conn.close();
				} catch (SQLException sqle) {
				}
		}
		return complaintNo;
	}

	//
	public static String getNextComplaintNoother(String districtCode, String mandalCode, String panchayatCode,
			DataSource dataSource) {
		String complaintNo;
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		Date date = new Date();
		SimpleDateFormat dateFormatter = new SimpleDateFormat("yy");
		String currentYear = dateFormatter.format(date);
		complaintNo = null;
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt1 = complaintMasterData.conn.createStatement();
			complaintNo = districtCode + mandalCode + panchayatCode + "GC" + currentYear;
			String query = " SELECT MAX(SUBSTR(complaint_no,11,4)) as complaint_no FROM RWS_generic_complaints_reg_tbl  WHERE complaint_no LIKE '"
					+ complaintNo + "%'";
			complaintMasterData.rs1 = complaintMasterData.stmt1.executeQuery(query);
			if (complaintMasterData.rs1.next()) {
				int sno = complaintMasterData.rs1.getInt(1);
				if (sno == 0) {
					complaintNo = complaintNo + "0001";
				} else {
					if (sno >= 9999)
						throw new Exception("No more WORK ID left.");
					String tempSno = null;
					if (sno < 9)
						tempSno = "000" + (sno + 1);
					else if (sno < 99)
						tempSno = "00" + (sno + 1);
					else if (sno < 999)
						tempSno = "0" + (sno + 1);
					else
						tempSno = String.valueOf(sno + 1);
					complaintNo = complaintNo + String.valueOf(tempSno);
				}
			}
		} catch (Exception e) {
			Debug.writeln("Exception in getComplaintNo : \n" + e);
		} finally {
			if (complaintMasterData.rs1 != null)
				try {
					complaintMasterData.rs1.close();
				} catch (SQLException sqlexception) {
				}
			if (complaintMasterData.stmt1 != null)
				try {
					complaintMasterData.stmt1.close();
				} catch (SQLException sqlexception1) {
				}
			if (complaintMasterData.conn != null)
				try {
					complaintMasterData.conn.close();
				} catch (SQLException sqle) {
				}
		}
		return complaintNo;
	}

	public static String getHabname(String Habcode) throws Exception {
		String complaintno;
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		int rowCount = 0;
		complaintno = "";
		String com = "";
		String temp = "";
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			String query = "";
			int i = 1;
			query = "select panch_name  from rws_complete_hab_view where panch_code='" + Habcode + "'  ";
			complaintMasterData.rset = complaintMasterData.stmt.executeQuery(query);
			if (complaintMasterData.rset.next()) {
				temp = complaintMasterData.rset.getString(1);

			}
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			Debug.println("The error in temp inpanchname" + e);
		} finally {
			complaintMasterData.closeAll();
			Debug.println("ConnCount after closing is " + connCount);
		}
		return temp;
	}

	public String getDistrictName(String dcode, DataSource dataSource) throws Exception {
		String districtName;
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		districtName = "";
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			String query = " select dname FROM rws_district_tbl where dcode='" + dcode + "' ";
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			complaintMasterData.rset = complaintMasterData.stmt.executeQuery(query);
			Debug.println("query in getDistrictName is " + query);
			while (complaintMasterData.rset.next())
				districtName = complaintMasterData.rset.getString(1);
		} catch (Exception e) {
			Debug.println("Exception in getDistrictName is " + e);
		} finally {
			closeAll();
		}
		return districtName;
	}

	public static int insertComplaint(String no, String ino, String date, String category, String desc, String givenby,
			String name, String address, String phone, RwsSmsRegistrationForm compForm, String assetcd, String hpcd,
			String officecode, String compcode, DataSource dataSource) throws Exception {
		int rowCount;
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		rowCount = 0;

		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			Debug.println("Before Insert");
			// String query =
			// "insert into RWS_COMPLAINTS_REGISTER_TBL
			// (ASSET_CODE,COMPLAINT_NO,COMPLAINT_DATE,COMPLAINT_DESC,CATEGORY_CODE,REP_CODE,NAME,ADDRESS,INWARD_NO,COMPONENT_CODE,office_code,PHONE_NO,comp_code)
			// values('"
			// + assetcd + "'," + "'" + no + "',to_date('" + date +
			// "','dd/mm/yyyy')," + "'" + desc.toUpperCase() + "'," + " '" +
			// category + "' ,'" + givenby + "','" + name.toUpperCase() + "'," +
			// "'" + address.toUpperCase() + "','" + ino + "','" + hpcd + "','"
			// + officecode + "','" + phone + "','"+compcode+"')";
			// Debug.println("After Insert" + query);
			// rowCount = complaintMasterData.stmt.executeUpdate(query);
			// Debug.println("After Insert" + query);
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			//Debug.println("The error in insertComplaints" + e);
		} finally {
			complaintMasterData.closeAll();
			//Debug.println("ConnCount after closing is " + connCount);
		}
		return rowCount;
	}

	//

	public ArrayList getRegistredMobiles(String dis, DataSource dataSource) throws Exception {
		ArrayList registredmobile;
		SmsRegistrationDAO smsRegistrationDAO = new SmsRegistrationDAO();
		RwsSmsRegistrationForm compForm = null;
		registredmobile = new ArrayList();
		String query = "";
		PreparedStatement stmt = null;
		ResultSet rs = null;
		Connection conn = null;
		try {

			conn = RwsOffices.getConn();
			
			
			
			query = "select IMEI_NO,USER_ID,PASSWORD,DATA_COLLECTOR_NAME,MOBILE,DESIGNATION,"
					+ "decode(GENDER,'F','FeMale','M','Male'),EMAILID,ADDRESS,to_char(DATE_OF_REQUEST,'dd/mm/yyyy'),"
					+ "decode(SERVICE_REQUEST,'M','Mobile','S','SMS','B','Both'),HABITATION_CODE,Location "
					+ "from RWS_MOBILE_SMS_REGISTER_TBL where substr(HABITATION_CODE,1,2)=? ";
			
			
			
			stmt = conn.prepareStatement(query);
			stmt.setString(1, dis);
			rs = stmt.executeQuery();
			while (rs.next()) {

				compForm = new RwsSmsRegistrationForm();

				compForm.setImeino(rs.getString(1));
				compForm.setUsername(rs.getString(2));
				compForm.setPassword(rs.getString(3));
				compForm.setDatecollname(rs.getString(4));
				compForm.setPhoneNo(rs.getString(5));
				compForm.setDesgnation(rs.getString(6));
				compForm.setGender(rs.getString(7));
				compForm.setEmailId(rs.getString(8));
				compForm.setAddress(rs.getString(9));
				compForm.setDateCreation(rs.getString(10));
				compForm.setServicereq(rs.getString(11));
				compForm.setHabCode(rs.getString(12));
				compForm.setLocation(rs.getString(13));

				registredmobile.add(compForm);
			}

		} catch (Exception e) {
			System.out.println( " exeception in getRegistredMobiles method of SmsRegistrationDAO--"+e);
		} finally {
			smsRegistrationDAO.closeAll();

		}
		return registredmobile;
	}

	public String insertComplaintgeneric(RwsSmsRegistrationForm frm, String req) throws Exception {
		int rowCount;
		String message = "";
		SmsRegistrationDAO smsregistration = new SmsRegistrationDAO();
		rowCount = 0;
		PreparedStatement stmt4 = null;
		Connection conn = null;
		String qry = null;
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
		Date date = new Date();
		String today = dateFormat.format(date);
		try {
			conn = RwsOffices.getConn();

			Rws_Encrypt_Random_Generation encrypt_Random_Generation = new Rws_Encrypt_Random_Generation();

			long rNo = encrypt_Random_Generation.createRandomInteger();

			if (!isExists(frm, conn)) {

				if (!ismobileExists(frm, conn)) {

					String mobile = "91" + frm.getPhoneNo();

					qry = "insert into RWS_MOBILE_SMS_REGISTER_TBL(IMEI_NO,USER_ID,PASSWORD,DATA_COLLECTOR_NAME,MOBILE,DESIGNATION,GENDER,EMAILID,ADDRESS,SERVICE_REQUEST,HABITATION_CODE,DATE_OF_REQUEST,Location,AUTH_USER_REGISTRATION,TASK_AUTHORISED_code,MAPPING_CODE) "
							+ "values( ?,?,?,?,?,?,?,?,?,?,?,to_date( ?,'dd/MM/YYYY'),?,?,?,?)";

					stmt4 = conn.prepareStatement(qry);
					stmt4.setString(1, frm.getImeino());
					stmt4.setString(2, frm.getUsername());
					stmt4.setString(3, frm.getPassword());
					stmt4.setString(4, frm.getDatecollname());
					stmt4.setString(5, mobile);
					stmt4.setString(6, frm.getDesgnation());
					stmt4.setString(7, frm.getGender());
					stmt4.setString(8, frm.getEmailId());
					stmt4.setString(9, frm.getAddress());
					stmt4.setString(10, req);
					stmt4.setString(11, frm.getHabCode());
					stmt4.setString(12, today);
					stmt4.setString(13, frm.getLocation());
					stmt4.setString(14, "Y");
					stmt4.setString(15, frm.getModAuth());
					stmt4.setLong(16, rNo);

				} else {
					message = "The  Mobile Number is Already Registred ";
					return message;
				}
			} else {

				message = "The IMEI Number and Mobile Number is Already Registred for This '" + frm.getHabCode1()
						+ "' ";
				return message;

			}

			rowCount = stmt4.executeUpdate();
			if (rowCount > 0) {
				encrypt_Random_Generation.generateEncryptRandomNumber(frm.getImeino(), rNo);
				message = "Record Inserted Successfully";
			} else {
				message = "Record Cannot be inserted";
			}

		}

		catch (Exception e) {
			System.out.println("Exception in insertComplaintgeneric of SMSRegistrationDAO--"+e);
		}

		return message;
	}

	private boolean isExists(RwsSmsRegistrationForm frm, Connection conn) {

		ResultSet rs = null;
		String query = "";
		PreparedStatement stmt1 = null;

		try {

			query = "select HABITATION_CODE  from RWS_MOBILE_SMS_REGISTER_TBL where IMEI_NO=? and MOBILE=? ";
			stmt1 = conn.prepareStatement(query);
			stmt1.setString(1, frm.getImeino());
			stmt1.setString(2, "91" + frm.getPhoneNo());
			rs = stmt1.executeQuery();


			if (rs.next()) {
				frm.setHabCode1(rs.getString(1));
				return true;

			} else {
				return false;
			}

		} catch (Exception e) {
			System.out.println("Exception in isExists of SMSRegistrationDAO--"+e);
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in isExists of SMSRegistrationDAO--"+e);
			}
		}

		return false;
	}

	private boolean ismobileExists(RwsSmsRegistrationForm frm, Connection conn) {

		ResultSet rs = null;
		String query = "";
		PreparedStatement stmt1 = null;

		try {

			query = "select MOBILE  from RWS_MOBILE_SMS_REGISTER_TBL where  MOBILE=? ";
			stmt1 = conn.prepareStatement(query);
			stmt1.setString(1, "91" + frm.getPhoneNo());

			rs = stmt1.executeQuery();


			if (rs.next()) {
				frm.setPhoneNo(rs.getString(1));
				return true;

			} else {
				return false;
			}

		} catch (Exception e) {
			System.out.println("Exception in ismobileExists of SMSRegistrationDAO--"+e);
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in ismobileExists of SMSRegistrationDAO--"+e);
			}
		}

		return false;
	}

	public static String getDistrictname(String dcode, DataSource dataSource) throws Exception {
		String message = null;
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		String s;
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			String distname = null;
			String query = "select dname from rws_district_tbl where dcode='" + dcode + "'";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			while (complaintMasterData.rs.next())
				distname = complaintMasterData.rs.getString(1);
			s = distname;
		} finally {
			if (complaintMasterData.rs != null)
				complaintMasterData.rs.close();
			if (complaintMasterData.stmt != null)
				complaintMasterData.stmt.close();
			if (complaintMasterData.conn != null)
				complaintMasterData.conn.close();
		}
		return s;
	}

	public static String getMandalname(String dcode, String mcode, DataSource dataSource) throws Exception {
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		String message = null;
		String s;
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			String mandname = null;
			String query = "select m.mname from rws_mandal_tbl m,rws_district_tbl d where d.dcode=m.dcode and  d.dcode='"
					+ dcode + "' and m.mcode='" + mcode + "'";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			while (complaintMasterData.rs.next())
				mandname = complaintMasterData.rs.getString(1);
			s = mandname;
		} finally {
			if (complaintMasterData.rs != null)
				complaintMasterData.rs.close();
			if (complaintMasterData.stmt != null)
				complaintMasterData.stmt.close();
			if (complaintMasterData.conn != null)
				complaintMasterData.conn.close();
		}
		return s;
	}

	public static String getPanchayatname(String dcode, String mcode, String pcode, DataSource dataSource)
			throws Exception {
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		String message = null;
		String s;
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			String panchname = null;
			String query = "select p.pname from rws_panchayat_tbl p where p.dcode='" + dcode + "' and p.mcode='" + mcode
					+ "' and p.pcode='" + pcode + "' ";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			while (complaintMasterData.rs.next())
				panchname = complaintMasterData.rs.getString(1);
			s = panchname;
		} finally {
			if (complaintMasterData.rs != null)
				complaintMasterData.rs.close();
			if (complaintMasterData.stmt != null)
				complaintMasterData.stmt.close();
			if (complaintMasterData.conn != null)
				complaintMasterData.conn.close();
		}
		return s;
	}

	public static String getTypename(String type, DataSource dataSource) throws Exception {
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		String message = null;
		String s;
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			String typename = null;
			String query = "select type_of_asset_name from rws_asset_type_tbl where type_of_asset_code='" + type + "'";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			while (complaintMasterData.rs.next())
				typename = complaintMasterData.rs.getString(1);
			s = typename;
		} finally {
			if (complaintMasterData.rs != null)
				complaintMasterData.rs.close();
			if (complaintMasterData.stmt != null)
				complaintMasterData.stmt.close();
			if (complaintMasterData.conn != null)
				complaintMasterData.conn.close();
		}
		return s;
	}

	public static ArrayList getFromDatesdistreporttot(String dist, DataSource dataSource) throws Exception {
		// System.out.println("ssss");
		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		ArrayList fromdates = new ArrayList();
		// String man = null;
		// String pan = null;
		// String hcode = null;
		try {
			/*
			 * if(Habcode != null && !Habcode.equals("")) { man = Habcode.substring(5, 7);
			 * pan = Habcode.substring(12, 14); Debug.println("pan" + pan);
			 * Debug.println("man" + man); hcode = Habcode.substring(10, 12); }
			 */
		} catch (Exception e) {
			Debug.println(" exception String" + e);
		}
		try {
			String query = "select distinct to_char(complaint_date,'dd/mm/yyyy') as a1 from rws_complaints_register_tbl where  substr(component_code,1,2)='"
					+ dist + "'   order by substr(a1,7,10) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			LabelValueBean compForm = null;

			while (complaintMasterData.rs.next()) {
				compForm = new LabelValueBean();
				compForm.setValue(complaintMasterData.rs.getString(1));
				compForm.setLabel(complaintMasterData.rs.getString(1));
				compForm.setLabelValue(complaintMasterData.rs.getString(1));
				fromdates.add(compForm);
			}

			complaintMasterData.conn.close();
		} catch (Exception e) {
			Debug.println("Exception in GetDate in CompForm :" + e);
		}
		return fromdates;
	}

	public static void compressImage(File srcFile, File targetFile) throws IOException {

		InputStream is = new FileInputStream(srcFile);
		OutputStream os = new FileOutputStream(targetFile);

		float quality = 0.5f;

		// create a BufferedImage as the result of decoding the supplied
		// InputStream
		BufferedImage image = ImageIO.read(is);

		// get all image writers for JPG format
		Iterator<ImageWriter> writers = ImageIO.getImageWritersByFormatName("jpg");

		if (!writers.hasNext())
			throw new IllegalStateException("No writers found");

		ImageWriter writer = (ImageWriter) writers.next();
		ImageOutputStream ios = ImageIO.createImageOutputStream(os);
		writer.setOutput(ios);

		ImageWriteParam param = writer.getDefaultWriteParam();
		// compress to a given quality
		param.setCompressionMode(ImageWriteParam.MODE_EXPLICIT);
		param.setCompressionQuality(quality);

		// appends a complete image stream containing a single image and
		// associated stream and image metadata and thumbnails to the output
		writer.write(null, new IIOImage(image, null, null), param);

		// close all streams
		is.close();
		os.close();
		ios.close();
		writer.dispose();
	}

	public static int connCount = 0;
	Connection conn;
	Statement stmt;
	Statement stmt1;
	Statement stmt2;
	Statement stmt3;
	Statement stmt4;
	Statement stmt5;
	Statement stmt6;
	Statement stmt7;
	Statement stmt8;
	Statement stmt9;
	Statement stmt10;
	Statement stmt11;
	Statement stmt12;
	Statement stmt13;
	Statement stmt14;
	Statement stmt15;
	Statement stmt16;
	Statement stmt17;
	Statement stmt18;
	Statement stmt19;
	Statement stmt20;
	Statement stmt21;
	Statement stmt22;
	Statement stmt23;
	Statement stmt24;
	ResultSet rs;
	static ResultSetMetaData rsm = null;
	ResultSet rset;
	ResultSet rs1;
	ResultSet rs2;
	ResultSet rs3;
	ResultSet rs4;
	ResultSet rs5;
	ResultSet rs6;
	ResultSet rs7;
	ResultSet rs8;
	ResultSet rs9;
	ResultSet rs10;
	ResultSet rs11;
	ResultSet rs12;
	ResultSet rs13;
	ResultSet rs14;
	ResultSet rs15;
	ResultSet rs16;
	ResultSet rs17;
	ResultSet rs18;
	ResultSet rs19;
	ResultSet rs20;
	ResultSet rs21;
	ResultSet rs22;
	ResultSet rs23;
	ResultSet rs24;
	static PreparedStatement ps = null;
	static SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	public static String errorMessage;

	public String deleteRegistrationDetails(String phone, String hab) {

		int rowCount;
		String message = "";

		rowCount = 0;
		PreparedStatement stmt4 = null;
		Connection conn = null;
		String qry = null;

		try {
			conn = RwsOffices.getConn();
		

			if (!isExistsSMS(conn, hab, phone)) {
				
				qry = "delete from RWS_MOBILE_SMS_REGISTER_TBL where Habitation_code=? and MOBILE=?";
				
				stmt4 = conn.prepareStatement(qry);
				stmt4.setString(1, hab);
				stmt4.setString(2, phone);
				rowCount = stmt4.executeUpdate();
			}
			if (rowCount > 0) {
				message = "Record Deleted Successfully";
			} else {
				message = "Record Cannot be Deleted";
			}

		}

		catch (Exception e) {
			System.out.println("exception in deleteRegistrationDetails of SMSRegistrationDAO-- "+e);
		}

		return message;

	}

	public String getTaskNo() {
		String taskNo = "";
		Statement statement = null;
		try {
			conn = RwsOffices.getConn();
			statement = conn.createStatement();
			String maxQuery = "select max(TASK_AUTHORISED_CODE) from RWS_TASK_AUTHORISED_TBL";
			ResultSet resultSet = statement.executeQuery(maxQuery);
			if (resultSet.next()) {
				int n = resultSet.getInt(1);
				n++;
				taskNo = n + "";
				if (taskNo.length() > 1) {
					taskNo = taskNo;
				} else {
					taskNo = "0" + taskNo;
				}
			} else {
				taskNo = "01";
			}
		} catch (Exception e) {
			System.out.println("exception in getTaskNo of SMSRegistrationDAO-- "+e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("exception in getTaskNo of SMSRegistrationDAO-- "+e);
			}
		}
		return taskNo;
	}

	public String saveTaskDetails(RwsSmsRegistrationForm frm) {
		String mes = "";
		PreparedStatement statement = null;
		String query = "";
		try {
			conn = RwsOffices.getConn();
			
		
			
			if (!isExists(conn, frm.getTaskAuthorizationCode())) {
				
				query = "insert into RWS_TASK_AUTHORISED_TBL (TASK_AUTHORISED_NAME,TASK_AUTHORISED_CODE) values (?,?) ";
				
			} else {
				
				query = "update RWS_TASK_AUTHORISED_TBL set TASK_AUTHORISED_NAME=? where TASK_AUTHORISED_CODE=?";
		
			}
			
			statement = conn.prepareStatement(query);
			statement.setString(1, frm.getTaskAuthorizationName() );
			statement.setString(2, frm.getTaskAuthorizationCode() );
			
			int n = statement.executeUpdate();
			if (n > 0) {
				mes = "Task Details Saved Successfully";
			} else {
				mes = "Failed to Save Task Details";
			}
		} catch (Exception e) {
		System.out.println("exception in saveTaskDetails of SMSRegistrationDAO-- "+e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (statement != null) {
					statement.close();
				}
			} catch (Exception e) {
				System.out.println("exception in saveTaskDetails of SMSRegistrationDAO-- "+e);
			}
		}
		return mes;
	}

	public ArrayList getTaskDetails() {
		ArrayList taskDetails = new ArrayList();
		Statement statement = null;
		RwsSmsRegistrationForm frm = null;
		try {
			conn = RwsOffices.getConn();
			statement = conn.createStatement();
			String query = "select * from RWS_TASK_AUTHORISED_TBL order by TASK_AUTHORISED_CODE";
			ResultSet resultSet = statement.executeQuery(query);
			while (resultSet.next()) {
				frm = new RwsSmsRegistrationForm();
				frm.setTaskAuthorizationCode(resultSet.getString(1));
				frm.setTaskAuthorizationName(resultSet.getString(2));
				taskDetails.add(frm);
			}

		} catch (Exception e) {
			System.out.println("exception in getTaskDetails of SMSRegistrationDAO-- "+e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("exception in getTaskDetails of SMSRegistrationDAO-- "+e);
			}
		}
		return taskDetails;
	}

	public String getTaskData(String taskCode) {
		String taskName = "";
		PreparedStatement statement = null;
		try {
			conn = RwsOffices.getConn();
		
			String query = "select TASK_AUTHORISED_NAME from RWS_TASK_AUTHORISED_TBL where TASK_AUTHORISED_CODE=?";
			statement = conn.prepareStatement(query);
			statement.setString(1, taskCode);
		
			ResultSet resultSet = statement.executeQuery();
			if (resultSet.next()) {
				taskName = resultSet.getString(1);
			}
		} catch (Exception e) {
			System.out.println("exception in getTaskData of SMSRegistrationDAO-- "+e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("exception in getTaskData of SMSRegistrationDAO-- "+e);
			}
		}
		return taskName;
	}

	private boolean isExists(Connection conn, String taskCode) {

		ResultSet rs = null;
		String query = "";
		PreparedStatement stmt1 = null;

		try {
	
			query = "select * from RWS_TASK_AUTHORISED_TBL where TASK_AUTHORISED_CODE=?";
			stmt1 = conn.prepareStatement(query);
			stmt1.setString(1, taskCode);
			rs = stmt1.executeQuery();
			if (rs.next()) {
				return true;

			} else {

				return false;
			}

		} catch (Exception e) {

		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return false;
	}

	private boolean isUnameExists(Connection conn, String uname) {

		ResultSet rs = null;
		String query = "";
		PreparedStatement stmt1 = null;

		try {
			
			query = "select * from RWS_MOBILE_SMS_REGISTER_TBL where USER_ID=?";
			stmt1 = conn.prepareStatement(query);
			stmt1.setString(1, uname);
			rs = stmt1.executeQuery();


			if (rs.next()) {

				return true;

			} else {
				return false;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return false;
	}

	private boolean isExistsSMS(Connection conn, String hab, String mobile) {

		ResultSet rs = null;
		String query = "";
		PreparedStatement stmt1 = null;

		try {
			
			query = "select *  from RWS_SMS_IN_OUT_STATUS_TBL where mobile=? and HABITATION_CODE=?";
			stmt1 = conn.prepareStatement(query);
			stmt1.setString(1, mobile);
			stmt1.setString(2, hab);
			rs = stmt1.executeQuery();


			if (rs.next()) {

				return true;

			} else {
				return false;
			}

		} catch (Exception e) {
			System.out.println("Exception in isExistsSMS of SMSRegistrationDAO--"+e);
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in isExistsSMS of SMSRegistrationDAO--"+e);
			}
		}

		return false;
	}

	public ArrayList getTasksForAuthorisation() throws Exception {

		ArrayList tasks = new ArrayList();
		RwsSmsRegistrationForm rwsLocation = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String query = "SELECT TASK_AUTHORISED_CODE,TASK_AUTHORISED_NAME FROM "
					+ "RWS_TASK_AUTHORISED_TBL order by TASK_AUTHORISED_CODE";
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				rwsLocation = new RwsSmsRegistrationForm();
				rwsLocation.setTaskCode(rs.getString(1));
				rwsLocation.setTaskName(rs.getString(2));
				rwsLocation.setTaskcodename(rs.getString(2) + " - " + rs.getString(1));
				tasks.add(rwsLocation);
			}
		} catch (Exception e) {
			System.out.println("Exception in getTasksForAuthorisation of SMSRegistrationDAO--"+e);
		} finally {
			closeAll();
		}
		return tasks;

	}

	public String insertMobileRegDetails(RwsSmsRegistrationForm frm, String req) {

		int rowCount;
		String message = "";
		SmsRegistrationDAO smsregistration = new SmsRegistrationDAO();
		rowCount = 0;
		PreparedStatement stmt4 = null;
		Connection conn = null;
		String qry = null;
		DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
		Date date = new Date();
		String today = dateFormat.format(date);
		try {
			conn = RwsOffices.getConn();

			Rws_Encrypt_Random_Generation encrypt_Random_Generation = new Rws_Encrypt_Random_Generation();
			long rNo = encrypt_Random_Generation.createRandomInteger();

			//if (isVillageExists(frm, conn)) {
			if(!isRegisteredInLoc(frm, conn)){

				String mobile = "91" + frm.getPhoneNo();

				qry = "insert into RWS_MOBILE_SMS_REGISTER_TBL(IMEI_NO,USER_ID,PASSWORD,DATA_COLLECTOR_NAME,MOBILE,DESIGNATION,GENDER,EMAILID,ADDRESS,SERVICE_REQUEST,HABITATION_CODE,DATE_OF_REQUEST,Location,AUTH_USER_REGISTRATION,TASK_AUTHORISED_code,MAPPING_CODE) "
						+ "values( ?,?,?,?,?,?,?,?,?,?,?,to_date( ?,'dd/MM/YYYY'),?,?,?,?)";

				stmt4 = conn.prepareStatement(qry);
				stmt4.setString(1, frm.getImeino());
				stmt4.setString(2, frm.getUsername());
				stmt4.setString(3, frm.getPassword());
				stmt4.setString(4, frm.getDatecollname());
				stmt4.setString(5, mobile);
				stmt4.setString(6, frm.getDesgnation());
				stmt4.setString(7, frm.getGender());
				stmt4.setString(8, frm.getEmailId());
				stmt4.setString(9, frm.getAddress());
				stmt4.setString(10, req);
				stmt4.setString(11, frm.getHabCode());
				stmt4.setString(12, today);
				stmt4.setString(13, frm.getLocation());
				stmt4.setString(14, "Y");
				stmt4.setString(15, frm.getModAuth());
				stmt4.setLong(16, rNo);

			} else {
				//message = "The  IMEI Number is Already Registred With '" + frm.getHabCode1() + "' Village";
				message = "The IMEI number is already registred in this location ";
				return message;
			}
			rowCount = stmt4.executeUpdate();
			if (rowCount > 0) {
				encrypt_Random_Generation.generateEncryptRandomNumber(frm.getImeino(), rNo);
				message = "Record Inserted Successfully";
			} else {
				message = "Record Cannot be inserted";
			}

		}

		catch (Exception e) {
			System.out.println("Exception in insertMobileRegDetails of SMSRegistrationDAO--"+e);
		}

		return message;
	}

	private boolean isVillageExists(RwsSmsRegistrationForm frm, Connection conn) {

		ResultSet rs = null, rs1 = null;
		String query = "";
		PreparedStatement stmt1 = null, stmt2 = null;
		String dcode = frm.getHabCode().substring(0, 2);
		String mcode = frm.getHabCode().substring(5, 7);
		String pcode = frm.getHabCode().substring(12, 14);
		String vcode = frm.getHabCode().substring(7, 10);
		try {

			query = "select *  from RWS_MOBILE_SMS_REGISTER_TBL where  substr(HABITATION_CODE,1,2)=? and substr(HABITATION_CODE,6,2)=?and substr(HABITATION_CODE,13,2)=? and substr(HABITATION_CODE,8,3)=? and IMEI_NO=?";
			stmt1 = conn.prepareStatement(query);
			stmt1.setString(1, dcode);
			stmt1.setString(2, mcode);
			stmt1.setString(3, pcode);
			stmt1.setString(4, vcode);
			stmt1.setString(5, frm.getImeino());
			rs = stmt1.executeQuery();


			if (rs.next()) {

				return true;

			} else {

				query = "select HABITATION_CODE  from RWS_MOBILE_SMS_REGISTER_TBL where  IMEI_NO= ?";


				stmt2 = conn.prepareStatement(query);
				stmt2.setString(1, frm.getImeino());

				rs1 = stmt2.executeQuery();

				if (rs1.next()) {
					frm.setHabCode1(getVillageName(rs1.getString(1).substring(0, 2), rs1.getString(1).substring(5, 7),
							rs1.getString(1).substring(12, 14), rs1.getString(1).substring(7, 10)));
					return false;

				} else {
					return true;

				}
			}

		} catch (Exception e) {
			System.out.println("Exception in isVillageExists of SMSRegistrationDAO--"+e);
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in isVillageExists of SMSRegistrationDAO--"+e);
			}
		}

		return false;
	}

	private String getVillageName(String dcode, String mcode, String pcode, String vcode) {
		String villageName = "";
		try {

			conn = RwsOffices.getConn();

			String query = " select vname  from "
					+ " rws_village_tbl where dcode=? and mcode=? and pcode=? and vcode=?";

			PreparedStatement stmt = conn.prepareStatement(query);
			stmt.setString(1, dcode);
			stmt.setString(2, mcode);
			stmt.setString(3, pcode);
			stmt.setString(4, vcode);

			rset = stmt.executeQuery();
			while (rset.next())
				villageName = rset.getString("vname");

		} catch (Exception e) {
			System.out.println("Exception in getVillageName of SMSRegistrationDAO--"+e);
		} finally {
			try {
				closeAll();
			} catch (Exception e) {
				System.out.println("Exception in getVillageName of SMSRegistrationDAO--"+e);
			}
		}
		return villageName;
	}
	private boolean isRegisteredInLoc(RwsSmsRegistrationForm frm, Connection connection) {
		ResultSet rs = null;
		String query = "";
		PreparedStatement stmt1 = null;

		try {

			query = "select * from RWS_MOBILE_SMS_REGISTER_TBL where HABITATION_CODE=? and IMEI_NO=? and TASK_AUTHORISED_CODE=?";
			stmt1 = connection.prepareStatement(query);
			stmt1.setString(1, frm.getHabCode());
			stmt1.setString(2, frm.getImeino());
			stmt1.setString(3, frm.getModAuth());
			rs = stmt1.executeQuery();
			if (rs.next()) {
				return true;

			} else {
				return false;
			}

		} catch (Exception e) {
			System.out.println("Exception in isExists of SMSRegistrationDAO-- "+e);
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
				
			} catch (Exception e) {
				System.out.println("Exception in isExists of SMSRegistrationDAO-- "+e);
			}
		}

		return false;
	}
}
