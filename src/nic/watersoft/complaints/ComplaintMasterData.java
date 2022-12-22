
package nic.watersoft.complaints;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintStream;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import nic.watersoft.commons.RwsUser;
import java.net.URLConnection;

import javax.imageio.IIOImage;
import javax.imageio.ImageIO;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;
import javax.imageio.stream.ImageOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import org.apache.struts.action.ActionServlet;
import org.apache.struts.upload.FormFile;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.ImageDocumentSanitizerImpl;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;

import oracle.jdbc.OracleDriver;

// Referenced classes of package nic.watersoft.complaints:
//            CompForm

public class ComplaintMasterData {

	public ComplaintMasterData() {
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
		
		try {
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			
			String url = "jdbc:odbc:DRIVER={Microsoft Access Driver  (*.mdb)};DBQ=G:/login.mdb;";
			con = DriverManager.getConnection(url, "", "");
			
		} catch (Exception o) {
			o.printStackTrace();
			Debug.println("Msaccess Exception");
		}
		return con;
	}

	//
	public static String getCreateTable(String tab, DataSource dataSource) {
		String message;
		
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
				
			}

			ptr = ptr.substring(0, ptr.lastIndexOf(","));
			if (tabExists(tab)) {
				Statement stmt2 = con.createStatement();
				stmt2.executeUpdate("drop table " + tab);
				
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
		
		return exists;
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
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		proposalId = headOfficeName + currentYear + districtCode;
		
		try {
			query = " SELECT MAX(SUBSTR(complaint_no,3,10)) as complaint_no FROM rws_complaints_register_tbl  WHERE complaint_no LIKE '"
					+ proposalId + "%'";
			complaintMasterData.conn = RwsOffices.getConn();
			stat = complaintMasterData.conn.createStatement();
			rset = stat.executeQuery(query);
			if (rset.next()) {
				int temp = rset.getInt(1);
				
				if (temp == 0) {
					proposalId = proposalId + "0001";
				} else {
					
					int sno = Integer.parseInt(String.valueOf(temp).substring(6, 10));
					
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
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		complaintNo = currentYear;
		
		try {
			query = " SELECT MAX(complaint_no)+1 as complaint_no FROM rws_complaints_register_tbl  WHERE complaint_no LIKE '"
					+ complaintNo + "%'";
			complaintMasterData.conn = RwsOffices.getConn();
			stat = complaintMasterData.conn.createStatement();
			rset = stat.executeQuery(query);
			if (rset.next()) {
				int temp = rset.getInt(1);
				
				if (temp == 0) {
					complaintNo = complaintNo + "00001";
				} else {
					
					int sno = Integer.parseInt(String.valueOf(temp).substring(6, 10));
					
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
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		int rowCount = 0;
		Date date = new Date();
		SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy");
		String currentYear = dateFormatter.format(date);
		complaintno = dist + currentYear;
		
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			
			String query = "";
			int i = 1;
			query = "select MAX(complaint_no)+1 from RWS_COMPLAINTS_REGISTER_TBL  ";
			
			complaintMasterData.rset = complaintMasterData.stmt.executeQuery(query);
			if (complaintMasterData.rset.next()) {
				
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
			
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			Debug.println("The error in deleteComplaints" + e);
		} finally {
			complaintMasterData.closeAll();
			
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
		ComplaintMasterData complaintMaster = new ComplaintMasterData();
		try {
			Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
			String url = "jdbc:odbc:master";
			con = DriverManager.getConnection(url, "", "");
			DriverManager.registerDriver(new OracleDriver());
			// conn =
			// DriverManager.getConnection("jdbc:oracle:thin:@10.160.2.209:1521:wsoft",
			// "preduser", "preduser");
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

	public static ArrayList getAsstsasts(String Habcode, String asstcode, DataSource dataSource) throws Exception {
		ArrayList assts;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		
		complaintMasterData.conn = RwsOffices.getConn();
		CompForm compForm = null;
		
		String query1 = null;
		String query2 = null;
		String dist = null;
		String man = null;
		String pan = null;
		String vill = null;
		String hcode = null;
		try {
			if (Habcode != null && !Habcode.equals("")) {
				dist = Habcode.substring(0, 2);
				
				man = Habcode.substring(5, 7);
				pan = Habcode.substring(12, 14);
				hcode = Habcode.substring(10, 12);
				vill = Habcode.substring(7, 10);
				
			}
			
		} catch (Exception e) {
			Debug.println(" exception String" + e);
		}
		assts = new ArrayList();
		try {
			
			
			query1 = "select distinct a.cissc_code,a.cis_loc,b.asset_code,b.asset_name from rws_ast_cis_sc_param_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and  a.hab_code=substr(s.scheme_code,1,16) and b.asset_code=a.asset_code   and b.type_of_asset_code='"
					+ asstcode + "' and a.hab_code='" + Habcode + "' order by cissc_code";
			complaintMasterData.stmt1 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs1 = complaintMasterData.stmt1.executeQuery(query1);
			
			for (; complaintMasterData.rs1.next(); assts.add(compForm)) {
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs1.getString(1));
				
				compForm.setAssetLocation(complaintMasterData.rs1.getString(2));
				
				compForm.setAssetCode(complaintMasterData.rs1.getString(3));
				
				compForm.setAssetName(complaintMasterData.rs1.getString(4));
				
			}

			query2 = "select distinct a.distrisc_code,nvl(a.location,'-'),b.asset_code,b.asset_name from rws_ast_distri_sc_param_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and  a.hab_code=substr(s.scheme_code,1,16) and b.asset_code=a.asset_code   and b.type_of_asset_code='"
					+ asstcode + "' and a.hab_code='" + Habcode + "' order by distrisc_code";
			complaintMasterData.stmt2 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs2 = complaintMasterData.stmt2.executeQuery(query2);
			
			for (; complaintMasterData.rs2.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs2.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs2.getString(2));
				compForm.setAssetCode(complaintMasterData.rs2.getString(3));
				compForm.setAssetName(complaintMasterData.rs2.getString(4));
			}

			String query3 = "select distinct a.BPT_CODE,nvl(a.location,'-'),b.asset_code,b.asset_name from RWS_ast_BPT_PARAM_TBL   a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  a.hab_code=substr(s.scheme_code,1,16) and b.asset_code=a.asset_code    and b.type_of_asset_code='"
					+ asstcode + "' and a.hab_code='" + Habcode + "' order by BPT_CODE";
			complaintMasterData.stmt3 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs3 = complaintMasterData.stmt3.executeQuery(query3);
			
			for (; complaintMasterData.rs3.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs3.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs3.getString(2));
				compForm.setAssetCode(complaintMasterData.rs3.getString(3));
				compForm.setAssetName(complaintMasterData.rs3.getString(4));
			}

			String query4 = "select distinct a.CW_COLLWELL_CODE,nvl(a.location,'-'),b.asset_code,b.asset_name from RWS_ast_CW_COLLWELL_PARAM_TBL     a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  a.hab_code=substr(s.scheme_code,1,16) and b.asset_code=a.asset_code   and b.type_of_asset_code='"
					+ asstcode + "' and a.hab_code='" + Habcode + "'  order by CW_COLLWELL_CODE";
			complaintMasterData.stmt4 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs4 = complaintMasterData.stmt4.executeQuery(query4);
			
			for (; complaintMasterData.rs4.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs4.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs4.getString(2));
				compForm.setAssetCode(complaintMasterData.rs4.getString(3));
				compForm.setAssetName(complaintMasterData.rs4.getString(4));
			}

			String query5 = "select distinct a.GLBR_CODE,nvl(a.GLBR_LOC,'-'),b.asset_code,b.asset_name from RWS_ast_GLBR_SC_PARAM_TBL    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  a.hab_code=substr(s.scheme_code,1,16) and b.asset_code=a.asset_code and     b.type_of_asset_code='"
					+ asstcode + "' and a.hab_code='" + Habcode + "'  order by GLBR_CODE";
			complaintMasterData.stmt5 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs5 = complaintMasterData.stmt5.executeQuery(query5);
			
			for (; complaintMasterData.rs5.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs5.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs5.getString(2));
				compForm.setAssetCode(complaintMasterData.rs5.getString(3));
				compForm.setAssetName(complaintMasterData.rs5.getString(4));
			}

			String query6 = "select distinct a.GLSR_CODE,nvl(a.GLSR_LOC,'-'),b.asset_code,b.asset_name from RWS_ast_GLSR_SC_PARAM_TBL    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  a.hab_code=substr(s.scheme_code,1,16) and b.asset_code=a.asset_code   and b.type_of_asset_code='"
					+ asstcode + "' and a.hab_code='" + Habcode + "' order by GLSR_CODE";
			complaintMasterData.stmt6 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs6 = complaintMasterData.stmt6.executeQuery(query6);
			
			for (; complaintMasterData.rs6.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs6.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs6.getString(2));
				compForm.setAssetCode(complaintMasterData.rs6.getString(3));
				compForm.setAssetName(complaintMasterData.rs6.getString(4));
			}

			String query7 = "select distinct a.OHSR_CODE,nvl(a.OHSR_LOC,'-'),b.asset_code,b.asset_name from RWS_ast_OHSR_SC_PARAM_TBL    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  a.hab_code=substr(s.scheme_code,1,16) and b.asset_code=a.asset_code   and b.type_of_asset_code='"
					+ asstcode + "' and a.hab_code='" + Habcode + "'  order by OHSR_CODE";
			complaintMasterData.stmt7 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs7 = complaintMasterData.stmt7.executeQuery(query7);
			
			for (; complaintMasterData.rs7.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs7.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs7.getString(2));
				compForm.setAssetCode(complaintMasterData.rs7.getString(3));
				compForm.setAssetName(complaintMasterData.rs7.getString(4));
			}

			String query8 = "select distinct a.OHBR_CODE,nvl(a.OHBR_LOC,'-'),b.asset_code,b.asset_name from RWS_ast_OHBR_SC_PARAM_TBL    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and   a.hab_code=subhstr(s.scheme_code,1,16) and b.asset_code=a.asset_code   and b.type_of_asset_code='"
					+ asstcode + "' and a.hab_code='" + Habcode + "' order by OHBR_CODE";
			complaintMasterData.stmt8 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs8 = complaintMasterData.stmt8.executeQuery(query8);
			
			for (; complaintMasterData.rs8.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs8.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs8.getString(2));
				compForm.setAssetCode(complaintMasterData.rs8.getString(3));
				compForm.setAssetName(complaintMasterData.rs8.getString(4));
			}

			String query9 = "select distinct a.RW_COLLWELL_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_RW_COLLWELL_PARAM_TBL   a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  a.hab_code=substr(s.scheme_code,1,16) and b.asset_code=a.asset_code   and b.type_of_asset_code='"
					+ asstcode + "' and a.hab_code='" + Habcode + "' order by RW_COLLWELL_CODE";
			complaintMasterData.stmt9 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs9 = complaintMasterData.stmt9.executeQuery(query9);
			
			for (; complaintMasterData.rs9.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs9.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs9.getString(2));
				compForm.setAssetCode(complaintMasterData.rs9.getString(3));
				compForm.setAssetName(complaintMasterData.rs9.getString(4));
			}

			String query10 = "select distinct a.SUMPCODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_SUMP_M_SC_PARAM_TBL        a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where  s.asset_code=b.asset_code and r.panch_code=a.hab_code and   a.hab_code=substr(s.scheme_code,1,16) and b.asset_code=a.asset_code and  b.type_of_asset_code='"
					+ asstcode + "' and a.hab_code='" + Habcode + "' order by SUMPCODE";
			complaintMasterData.stmt10 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs10 = complaintMasterData.stmt10.executeQuery(query10);
			
			for (; complaintMasterData.rs10.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs10.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs10.getString(2));
				compForm.setAssetCode(complaintMasterData.rs10.getString(3));
				compForm.setAssetName(complaintMasterData.rs10.getString(4));
			}

			String query11 = "select distinct a.OTHER_COMP_CODE ,nvl(a.COMP_LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_OTHERS_PARAM_TBL          a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and a.hab_code=substr(s.scheme_code,1,16) and b.asset_code=a.asset_code and b.type_of_asset_code='"
					+ asstcode + "' and a.hab_code='" + Habcode + "'  order by OTHER_COMP_CODE";
			complaintMasterData.stmt11 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs11 = complaintMasterData.stmt11.executeQuery(query11);
			
			for (; complaintMasterData.rs11.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs11.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs11.getString(2));
				compForm.setAssetCode(complaintMasterData.rs11.getString(3));
				compForm.setAssetName(complaintMasterData.rs11.getString(4));
			}

			String query12 = "select distinct a.BRIDGE_CODE ,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_FP_BRIDGE_PARAM_TBL            a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  a.hab_code=substr(s.scheme_code,1,16) and b.asset_code=a.asset_code  and b.type_of_asset_code='"
					+ asstcode + "' and a.hab_code='" + Habcode + "' order by BRIDGE_CODE";
			complaintMasterData.stmt12 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs12 = complaintMasterData.stmt12.executeQuery(query12);
			
			for (; complaintMasterData.rs12.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs12.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs12.getString(2));
				compForm.setAssetCode(complaintMasterData.rs12.getString(3));
				compForm.setAssetName(complaintMasterData.rs12.getString(4));
			}

			String query13 = "select distinct a.PUMP_CODE ,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_SUBCOMP_PARAM_TBL              a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  a.hab_code=substr(s.scheme_code,1,16) and b.asset_code=a.asset_code   and b.type_of_asset_code='"
					+ asstcode + "' and a.hab_code='" + Habcode + "' order by PUMP_CODE";
			complaintMasterData.stmt13 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs13 = complaintMasterData.stmt13.executeQuery(query13);
			
			for (; complaintMasterData.rs13.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs13.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs13.getString(2));
				compForm.setAssetCode(complaintMasterData.rs13.getString(3));
				compForm.setAssetName(complaintMasterData.rs13.getString(4));
			}

			String query14 = "select distinct a.PUMPHOUSE_CODE ,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_PUMPHOUSE_PARAM_TBL                a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  a.hab_code=substr(s.scheme_code,1,16) and b.asset_code=a.asset_code   and b.type_of_asset_code='"
					+ asstcode + "' and a.hab_code='" + Habcode + "' order by PUMPHOUSE_CODE";
			complaintMasterData.stmt14 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs14 = complaintMasterData.stmt13.executeQuery(query14);
			
			for (; complaintMasterData.rs14.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs14.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs14.getString(2));
				compForm.setAssetCode(complaintMasterData.rs14.getString(3));
				compForm.setAssetName(complaintMasterData.rs14.getString(4));
			}

			String query15 = "select distinct a.PUMPINGMAIN_CODE  ,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_PUMPINGMAIN_TBL                  a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where  s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  a.hab_code=substr(s.scheme_code,1,16) and b.asset_code=a.asset_code   and b.type_of_asset_code='"
					+ asstcode + "' and a.hab_code='" + Habcode + "' order by PUMPINGMAIN_CODE";
			complaintMasterData.stmt15 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs15 = complaintMasterData.stmt15.executeQuery(query15);
			
			for (; complaintMasterData.rs15.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs15.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs15.getString(2));
				compForm.setAssetCode(complaintMasterData.rs15.getString(3));
				compForm.setAssetName(complaintMasterData.rs15.getString(4));
			}

			String query16 = "select distinct a.SSSC_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_SS_SC_PARAM_TBL                  a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and   a.hab_code=substr(s.scheme_code,1,16) and b.asset_code=a.asset_code and   b.type_of_asset_code='"
					+ asstcode + "' and a.hab_code='" + Habcode + "' order by SSSC_CODE";
			complaintMasterData.stmt16 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs16 = complaintMasterData.stmt16.executeQuery(query16);
			
			for (; complaintMasterData.rs16.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs16.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs16.getString(2));
				compForm.setAssetCode(complaintMasterData.rs16.getString(3));
				compForm.setAssetName(complaintMasterData.rs16.getString(4));
			}

			String query17 = "select distinct a.WTPSC_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_WTP_SC_PARAM_TBL                    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and  a.hab_code=substr(s.scheme_code,1,16) and b.asset_code=a.asset_code   and b.type_of_asset_code='"
					+ asstcode + "' and a.hab_code='" + Habcode + "' order by WTPSC_CODE";
			complaintMasterData.stmt17 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs17 = complaintMasterData.stmt17.executeQuery(query17);
			
			for (; complaintMasterData.rs17.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs17.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs17.getString(2));
				compForm.setAssetCode(complaintMasterData.rs17.getString(3));
				compForm.setAssetName(complaintMasterData.rs17.getString(4));
			}

			String query19 = "select distinct a.GRAVITYMAIN_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_GRAVITYMAIN_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where  s.asset_code=b.asset_code and r.panch_code=a.hab_code and   a.hab_code=substr(s.scheme_code,1,16) and b.asset_code=a.asset_code    and b.type_of_asset_code='"
					+ asstcode + "' and a.hab_code='" + Habcode + "' order by GRAVITYMAIN_CODE";
			complaintMasterData.stmt19 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs19 = complaintMasterData.stmt19.executeQuery(query19);
			
			for (; complaintMasterData.rs19.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs19.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs19.getString(2));
				compForm.setAssetCode(complaintMasterData.rs19.getString(3));
				compForm.setAssetName(complaintMasterData.rs19.getString(4));
			}

			String query20 = "select distinct a.SOURCE_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_SOURCE_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  a.hab_code=substr(s.scheme_code,1,16) and b.asset_code=a.asset_code    and b.type_of_asset_code='"
					+ asstcode + "'   and a.hab_code='" + Habcode + "' order by SOURCE_CODE";
			complaintMasterData.stmt20 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs20 = complaintMasterData.stmt20.executeQuery(query20);
			
			for (; complaintMasterData.rs20.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs20.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs20.getString(2));
				compForm.setAssetCode(complaintMasterData.rs20.getString(3));
				compForm.setAssetName(complaintMasterData.rs20.getString(4));
			}

			String query21 = "select distinct a.PUMPDET_CODE,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_PUMP_DET_SC_PARAM_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  a.hab_code=substr(s.scheme_code,1,16) and b.asset_code=a.asset_code  and b.type_of_asset_code='"
					+ asstcode + "' and a.hab_code='" + Habcode + "'   order by PUMPDET_CODE";
			complaintMasterData.stmt21 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs21 = complaintMasterData.stmt21.executeQuery(query21);
			
			for (; complaintMasterData.rs21.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs21.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs21.getString(2));
				compForm.setAssetCode(complaintMasterData.rs21.getString(3));
				compForm.setAssetName(complaintMasterData.rs21.getString(4));
			}

			String query22 = "select distinct a.WATCHMAN_CODE,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_WATCHMAN_PARAM_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  a.hab_code=substr(s.scheme_code,1,16) and b.asset_code=a.asset_code    and b.type_of_asset_code='"
					+ asstcode + "' and a.hab_code='" + Habcode + "'   order by WATCHMAN_CODE";
			complaintMasterData.stmt22 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs22 = complaintMasterData.stmt22.executeQuery(query22);
			
			for (; complaintMasterData.rs22.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs22.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs22.getString(2));
				compForm.setAssetCode(complaintMasterData.rs22.getString(3));
				compForm.setAssetName(complaintMasterData.rs22.getString(4));
			}

			String query23 = "select distinct a.cl_code,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_chlorination_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  a.hab_code=substr(s.scheme_code,1,16) and b.asset_code=a.asset_code    and b.type_of_asset_code='"
					+ asstcode + "' and a.hab_code='" + Habcode + "'   order by cl_code";
			complaintMasterData.stmt23 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs23 = complaintMasterData.stmt23.executeQuery(query23);
			
			for (; complaintMasterData.rs23.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs23.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs23.getString(2));
				compForm.setAssetCode(complaintMasterData.rs23.getString(3));
				compForm.setAssetName(complaintMasterData.rs23.getString(4));
			}

			String query24 = "select distinct nvl(oandmcode,'-'),nvl(b.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_oandm_param_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=b.hab_code and  b.asset_code=a.asset_code and s.asset_code=a.asset_code and     and b.type_of_asset_code='"
					+ asstcode + "' and b.hab_code='" + Habcode + "'   ";
			complaintMasterData.stmt24 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs24 = complaintMasterData.stmt24.executeQuery(query24);
			
			for (; complaintMasterData.rs24.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs24.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs24.getString(2));
				compForm.setAssetCode(complaintMasterData.rs24.getString(3));
				compForm.setAssetName(complaintMasterData.rs24.getString(4));
			}

		} catch (Exception e) {
			Debug.println("The error in getassts***=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return assts;
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
			
			for (; rs1.next(); ) {
			
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
				Debug.println("The Exception in closeAll=" + e);
			}
			ps = null;
		}
		if (conn != null) {
			try {
				conn.close();
				if (conn.isClosed())
					connCount--;
			} catch (Exception e) {
				Debug.println("The Exception in closeAll=" + e);
			}
			conn = null;
		}
	}

	public ArrayList getDistricts(DataSource dataSource) throws Exception {
		ArrayList districts;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		districts = new ArrayList();
		CompForm compForm = null;
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			for (complaintMasterData.rs = complaintMasterData.stmt.executeQuery(
					"SELECT distinct d.dcode,d.dname FROM RWS_DISTRICT_TBL d ORDER BY d.DNAME"); complaintMasterData.rs
							.next(); districts.add(compForm)) {
				compForm = new CompForm();
				compForm.setDistrictCode(complaintMasterData.rs.getString(1));
				compForm.setDistrictName(complaintMasterData.rs.getString(2));
				compForm.setCodeName(complaintMasterData.rs.getString(2) + " - " + complaintMasterData.rs.getString(1));
			}

		} catch (Exception e) {
			System.out.println("Exception in getDistricts" + e);
		} finally {
			complaintMasterData.closeAll();
		}
		return districts;
	}

	public ArrayList getDistricts1(DataSource dataSource) throws Exception {
		ArrayList districts;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		districts = new ArrayList();
		CompForm compForm = null;
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			for (complaintMasterData.rs = complaintMasterData.stmt.executeQuery(
					"SELECT DISTINCT DCODE,DNAME FROM RWS_DISTRICT_TBL  ORDER BY DCODE"); complaintMasterData.rs
							.next(); districts.add(compForm)) {
				compForm = new CompForm();
				compForm.setDistrictCode(complaintMasterData.rs.getString(1));
				compForm.setDistrictName(complaintMasterData.rs.getString(2));
				compForm.setCodeName(complaintMasterData.rs.getString(2) + " - " + complaintMasterData.rs.getString(1));
			}

		} catch (Exception e) {
			System.out.println("Exceptionb in getDistricts1" + e);
		} finally {
			complaintMasterData.closeAll();
		}
		return districts;
	}

	public ArrayList getMandals(String dcode, DataSource dataSource) throws Exception {
		ArrayList mandals;
		CompForm compForm = null;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		mandals = new ArrayList();
		String query = "";
		try {
			query = "SELECT distinct m.mcode,m.mname FROM RWS_MANDAL_TBL M where  m.dcode='" + dcode
					+ "'   ORDER BY M.MNAME";
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			
			for (; complaintMasterData.rs.next(); mandals.add(compForm)) {
				compForm = new CompForm();
				compForm.setMandalCode(complaintMasterData.rs.getString(1));
				compForm.setMandalName(complaintMasterData.rs.getString(2));
				compForm.setCodeName(complaintMasterData.rs.getString(2) + " - " + complaintMasterData.rs.getString(1));
			}

		} catch (Exception e) {
			System.out.println("Exception in getMandals" + e);
		} finally {
			complaintMasterData.closeAll();
		}
		return mandals;
	}

	public ArrayList getPanchayats(String dcode, String mcode, DataSource dataSource) throws Exception {
		ArrayList panchayats;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		panchayats = new ArrayList();
		CompForm compForm = null;
		String query = "";
		try {
			query = "SELECT distinct p.pcode,p.pname FROM rws_panchayat_tbl p where p.dcode='" + dcode
					+ "' and p.mcode='" + mcode + "'   ORDER BY p.PNAME ";
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
		
			for (; complaintMasterData.rs.next(); panchayats.add(compForm)) {
				compForm = new CompForm();
				compForm.setPanchayatCode(complaintMasterData.rs.getString(1));
				compForm.setPanchayatName(complaintMasterData.rs.getString(2));
				compForm.setCodeName(complaintMasterData.rs.getString(2) + " - " + complaintMasterData.rs.getString(1));
			}

		} catch (Exception e) {
			System.out.println("Exception in getPanchayats" + e);
		} finally {
			complaintMasterData.closeAll();
		}
		return panchayats;
	}

	public ArrayList getCompDistricts(DataSource dataSource) throws Exception {
		ArrayList districts;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		LabelValueBean compForm = null;
		districts = new ArrayList();
		String query = "";
		try {
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select distinct d.dcode,d.dname from rws_district_tbl d,rws_complaints_register_tbl c where d.dcode=substr(c.component_code,1,2) order by d.dname";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			
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
			
		}
		return districts;
	}

	//
	public ArrayList getCompDistrictsgeneric(DataSource dataSource) throws Exception {
		ArrayList districts;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		LabelValueBean compForm = null;
		districts = new ArrayList();
		String query = "";
		try {
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select distinct d.dcode,d.dname from rws_district_tbl d,rws_generic_complaints_reg_tbl c where d.dcode=substr(c.habitation_code,1,2) order by d.dname";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			
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
			
		}
		return districts;
	}

	//

	public ArrayList getCompCircles(String headoffice, DataSource dataSource) throws Exception {
		ArrayList circles;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		LabelValueBean compForm = null;
		circles = new ArrayList();
		String query = "";
		try {
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select distinct d.circle_office_code,d.circle_office_name from rws_circle_office_tbl d,rws_complaints_register_tbl c where d.circle_office_code=substr(c.component_code,1,2) and head_office_code='"
					+ headoffice + "' order by d.circle_office_name";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			
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
			
		}
		return circles;
	}

	//
	public ArrayList getCompCirclesgeneric(String headoffice, DataSource dataSource) throws Exception {
		ArrayList circles;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		LabelValueBean compForm = null;
		circles = new ArrayList();
		String query = "";
		try {
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select distinct d.circle_office_code,d.circle_office_name from rws_circle_office_tbl d,rws_generic_complaints_reg_tbl c where d.circle_office_code=substr(c.habitation_code,1,2) and head_office_code='"
					+ headoffice + "' and complaint_status is null order by d.circle_office_name ";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			
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
			
		}
		return circles;
	}

	//

	public ArrayList getCompMandals(String dcode, DataSource dataSource) throws Exception {
		ArrayList mandals;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
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
			
		}
		return mandals;
	}

	//
	public ArrayList getCompMandalsgenericno(String dcode, DataSource dataSource) throws Exception {
		ArrayList mandals;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
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
			
		}
		return mandals;
	}

	//
	public ArrayList getCompMandalsgeneric(String dcode, DataSource dataSource) throws Exception {
		ArrayList mandals;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		LabelValueBean compForm = null;
		mandals = new ArrayList();
		String query = "";
		try {
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();

			query = "select distinct d.dcode,d.mcode,d.mname from rws_mandal_tbl d,rws_generic_complaints_reg_tbl c where  d.dcode='"
					+ dcode
					+ "' and d.mcode=substr(c.habitation_code,6,2) and d.dcode=substr(c.habitation_code,1,2) and complaint_status is null order by d.mname";
			
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			
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
			
		}
		return mandals;
	}

	//
	public ArrayList getCompMandalsgenerics(String dcode, DataSource dataSource) throws Exception {
		ArrayList mandals;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		LabelValueBean compForm = null;
		mandals = new ArrayList();
		String query = "";
		try {
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();

			query = "select distinct d.dcode,d.mcode,d.mname from rws_mandal_tbl d,rws_generic_complaints_reg_tbl c where  d.dcode='"
					+ dcode
					+ "' and d.mcode=substr(c.habitation_code,6,2) and d.dcode=substr(c.habitation_code,1,2)  order by d.mname";
			
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			
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
			
		}
		return mandals;
	}

	//

	public ArrayList getCompPanchayats(String dcode, String mcode, DataSource dataSource) throws Exception {
		ArrayList panchayats;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
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
			
		}
		return panchayats;
	}

	//
	public ArrayList getCompPanchayatsgenericno(String dcode, String mcode, DataSource dataSource) throws Exception {
		ArrayList panchayats;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
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
			
		}
		return panchayats;
	}

	//
	public ArrayList getCompPanchayatsgeneric(String dcode, String mcode, DataSource dataSource) throws Exception {
		ArrayList panchayats;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
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
			
		}
		return panchayats;
	}

	//
	public ArrayList getCompPanchayatsgenerics(String dcode, String mcode, DataSource dataSource) throws Exception {
		ArrayList panchayats;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
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
			
		}
		return panchayats;
	}

	//
	//

	public ArrayList getCompHabsgeneric(String dcode, String mcode, String pcode, DataSource dataSource)
			throws Exception {
		ArrayList habs;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
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
			
		}
		return habs;
	}

	public ArrayList getCompHabs(String dcode, String mcode, String pcode, DataSource dataSource) throws Exception {
		ArrayList habs;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
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
			
		}
		return habs;
	}

	public ArrayList getCompVillages(String dcode, String mcode, String pcode, DataSource dataSource) throws Exception {
		ArrayList villages;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
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
			
		}
		return villages;
	}

	//
	public ArrayList getCompVillagesgeneric(String dcode, String mcode, String pcode, DataSource dataSource)
			throws Exception {
		ArrayList villages;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
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
			
		}
		return villages;
	}

	//

	public ArrayList getCompHabitations(String dcode, String mcode, String pcode, String vcode, DataSource dataSource)
			throws Exception {
		ArrayList habs;
		habs = new ArrayList();
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		LabelValueBean compForm = null;
		String query = "";
		try {
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			// query = " SELECT distinct
			// H.HAB_CODE,P.PANCH_CODE,P.PANCH_NAME,H.COVERAGE_STATUS FROM
			// RWS_PANCHAYAT_RAJ_TBL P, RWS_HABITATION_DIRECTORY_TBL
			// H,rws_complaints_register_tbl c WHERE SUBSTR(P.PANCH_CODE,1,2)='" + dcode +
			// "' AND SUBSTR(P.PANCH_CODE,6,2)='" + mcode + "' AND
			// SUBSTR(P.PANCH_CODE,13,2)='" + pcode + "' AND " + " H.HAB_CODE=P.PANCH_CODE
			// AND H.COVERAGE_STATUS <> 'UI' and substr(c.component_code,1,16)=p.panch_code
			// and substr(c.component_code,8,3)='" + vcode + "' and
			// substr(c.component_code,1,16)=h.hab_code ORDER BY P.PANCH_NAME";
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
			
		}
		return habs;
	}

	//
	public ArrayList getCompHabitationsgeneric(String dcode, String mcode, String pcode, String vcode,
			DataSource dataSource) throws Exception {
		ArrayList habs;
		habs = new ArrayList();
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		LabelValueBean compForm = null;
		String query = "";
		try {
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			// query = " SELECT distinct
			// H.HAB_CODE,P.PANCH_CODE,P.PANCH_NAME,H.COVERAGE_STATUS FROM
			// RWS_PANCHAYAT_RAJ_TBL P, RWS_HABITATION_DIRECTORY_TBL
			// H,rws_complaints_register_tbl c WHERE SUBSTR(P.PANCH_CODE,1,2)='" + dcode +
			// "' AND SUBSTR(P.PANCH_CODE,6,2)='" + mcode + "' AND
			// SUBSTR(P.PANCH_CODE,13,2)='" + pcode + "' AND " + " H.HAB_CODE=P.PANCH_CODE
			// AND H.COVERAGE_STATUS <> 'UI' and substr(c.component_code,1,16)=p.panch_code
			// and substr(c.component_code,8,3)='" + vcode + "' and
			// substr(c.component_code,1,16)=h.hab_code ORDER BY P.PANCH_NAME";
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
			
		}
		return habs;
	}

	//

	public static ArrayList getrecComplaintsgeneric(String Habcode, DataSource dataSource) throws Exception {
		ArrayList reccomplaints;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		reccomplaints = new ArrayList();
		String dist = Habcode.substring(0, 2);
		
		String man = Habcode.substring(5, 7);
		String pan = Habcode.substring(12, 14);
		String hcode = Habcode.substring(10, 12);
		
		String vill = Habcode.substring(7, 10);
		
		String query = "";
		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			// query = "select distinct
			// a.asset_code,a.component_code,a.complaint_no,to_char(a.complaint_date,'dd/mm/yyyy'),nvl(a.complaint_desc,'-'),nvl(b.asset_name,'-'),decode(a.category_code,'01','LEAKING','02','PUMP
			// DAMAGED')result, from rws_complaints_register_tbl a,rws_asset_mast_tbl
			// b,rws_public_rep_tbl p where a.rep_code=p.rep_code and
			// substr(a.component_code,1,2)='" + dist + "' and
			// substr(a.component_code,6,2)='" + man + "' and
			// substr(a.component_code,13,2)='" + pan + "' and a.complaint_status is not
			// null and a.asset_code=b.asset_code \t and substr(a.component_code,11,2)='" +
			// hcode + "' and substr(a.component_code,8,3)='" + vill + "' ";
			query = "select distinct a.component_name,a.complaint_no,to_char (a.complaint_date,'dd/mm/yyyy'),nvl(a.complaint_desc,'-'),a.complaint_status,p.rep_name,a.name,a.address from rws_generic_complaints_reg_tbl a,rws_public_rep_tbl p where p.rep_code=a.rep_code and substr (a.habitation_code,1,2)='"
					+ dist + "' and substr(a.habitation_code,6,2)='" + man + "' and substr(a.habitation_code,13,2)='"
					+ pan + "' and substr (a.habitation_code,8,3)='" + vill
					+ "'  and a.complaint_status is  null   order by complaint_no ";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			
			while (complaintMasterData.rs.next()) {
				compForm = new CompForm();

				compForm.setComponentName(complaintMasterData.rs.getString(1));
				compForm.setComplntno(complaintMasterData.rs.getString(2));
				compForm.setComplntdt(complaintMasterData.rs.getString(3));
				compForm.setComplntdesc(complaintMasterData.rs.getString(4));
				compForm.setRepName(complaintMasterData.rs.getString(6));
				compForm.setName(complaintMasterData.rs.getString(7));
				compForm.setAddress(complaintMasterData.rs.getString(8));
				compForm.setComplntstatus(complaintMasterData.rs.getString(5));
				reccomplaints.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getRecComplaints1***=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return reccomplaints;
	}

	//
	public static ArrayList getrecComplaints(String Habcode, DataSource dataSource) throws Exception {
		ArrayList reccomplaints;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		reccomplaints = new ArrayList();
		String dist = Habcode.substring(0, 2);
		
		String man = Habcode.substring(5, 7);
		String pan = Habcode.substring(12, 14);
		String hcode = Habcode.substring(10, 12);
		
		String vill = Habcode.substring(7, 10);
		
		String query = "";
		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			// query = "select distinct
			// a.asset_code,a.component_code,a.complaint_no,to_char(a.complaint_date,'dd/mm/yyyy'),nvl(a.complaint_desc,'-'),nvl(b.asset_name,'-'),decode(a.category_code,'01','LEAKING','02','PUMP
			// DAMAGED')result, from rws_complaints_register_tbl a,rws_asset_mast_tbl
			// b,rws_public_rep_tbl p where a.rep_code=p.rep_code and
			// substr(a.component_code,1,2)='" + dist + "' and
			// substr(a.component_code,6,2)='" + man + "' and
			// substr(a.component_code,13,2)='" + pan + "' and a.complaint_status is not
			// null and a.asset_code=b.asset_code \t and substr(a.component_code,11,2)='" +
			// hcode + "' and substr(a.component_code,8,3)='" + vill + "' ";
			query = "select distinct a.asset_code,a.component_code,a.complaint_no,to_char (a.complaint_date,'dd/mm/yyyy'),nvl(a.complaint_desc,'-'),b.asset_name,comp_cat_name,a.complaint_status,p.rep_name,a.name,a.address from rws_complaints_register_tbl a,rws_asset_mast_tbl b,rws_public_rep_tbl p,rws_complaint_category_tbl c where p.rep_code=a.rep_code and substr (a.component_code,1,2)='"
					+ dist + "' and substr(a.component_code,6,2)='" + man + "' and substr(a.component_code,13,2)='"
					+ pan + "' and substr (a.component_code,8,3)='" + vill
					+ "' and a.asset_code=b.asset_code and a.complaint_status is  null  and a.comp_code=c.comp_code and a.category_code=c.com_category_code  and substr(a.asset_code,7,2)=type_of_asset  order by complaint_no ";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			
			for (; complaintMasterData.rs.next(); reccomplaints.add(compForm)) {
				compForm = new CompForm();
				compForm.setAssetCode(complaintMasterData.rs.getString(1));
				compForm.setSourceCode(complaintMasterData.rs.getString(2));
				compForm.setAssetName(complaintMasterData.rs.getString(6));
				compForm.setComplntno(complaintMasterData.rs.getString(3));
				compForm.setComplntdt(complaintMasterData.rs.getString(4));
				compForm.setComplntdesc(complaintMasterData.rs.getString(5));
				compForm.setCategoryName(complaintMasterData.rs.getString(7));
				compForm.setRepName(complaintMasterData.rs.getString("rep_name"));
				compForm.setName(complaintMasterData.rs.getString(9));
				compForm.setAddress(complaintMasterData.rs.getString(10));
				compForm.setComplntstatus(complaintMasterData.rs.getString(8));
			}

		} catch (Exception e) {
			Debug.println("The error in getRecComplaints1***=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return reccomplaints;
	}

	//

	public static ArrayList getAsstsPws(String Habcode, String asstcode, DataSource dataSource) throws Exception {
		ArrayList assts;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		
		complaintMasterData.closeAll();
		
		CompForm compForm = null;
		
		String query1 = null;
		String query2 = null;
		String dist = null;
		String man = null;
		String pan = null;
		try {
			if (Habcode != null && !Habcode.equals("")) {
				dist = Habcode.substring(0, 2);
				
				man = Habcode.substring(5, 7);
				pan = Habcode.substring(12, 14);
				
			}
			
		} catch (Exception e) {
			Debug.println(" exception String" + e);
		}
		assts = new ArrayList();
		try {
			
			compForm = new CompForm();
			query1 = "select distinct a.cissc_code,a.cis_loc,b.asset_code,b.asset_name from rws_pws_cis_sc_param_tbl a,rws_asset_mast_tbl b where substr(a.cissc_code,1,2)='"
					+ dist + "' and substr(a.cissc_code,6,2)='" + man
					+ "' and  substr(a.cissc_code,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.cissc_code,1,2) and substr(b.hab_code,6,2)=substr(a.cissc_code,6,2) and substr(b.hab_code,13,2)=substr(a.cissc_code,13,2) and substr(a.cissc_code,13,2)='"
					+ pan + "' and b.type_of_asset_code='" + asstcode + "' order by cissc_code";
			complaintMasterData.stmt1 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs1 = complaintMasterData.stmt1.executeQuery(query1);
			
			for (; complaintMasterData.rs1.next(); assts.add(compForm)) {
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs1.getString(1));
				
				compForm.setAssetLocation(complaintMasterData.rs1.getString(2));
				
				compForm.setAssetCode(complaintMasterData.rs1.getString(3));
				
				compForm.setAssetName(complaintMasterData.rs1.getString(4));
				
			}

			query2 = "select distinct a.distrisc_code,nvl(a.location,'-'),b.asset_code,b.asset_name from rws_pws_distri_sc_param_tbl a,rws_asset_mast_tbl b where substr(a.distrisc_code,1,2)='"
					+ dist + "' and substr(a.distrisc_code,6,2)='" + man
					+ "' and  substr(a.distrisc_code,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.distrisc_code,1,2) and substr(b.hab_code,6,2)=substr(a.distrisc_code,6,2) and substr(b.hab_code,13,2)=substr(a.distrisc_code,13,2) and substr(a.distrisc_code,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by distrisc_code";
			complaintMasterData.stmt2 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs2 = complaintMasterData.stmt2.executeQuery(query2);
			
			for (; complaintMasterData.rs2.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs2.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs2.getString(2));
				compForm.setAssetCode(complaintMasterData.rs2.getString(3));
				compForm.setAssetName(complaintMasterData.rs2.getString(4));
			}

			String query3 = "select distinct a.BPT_CODE,nvl(a.location,'-'),b.asset_code,b.asset_name from RWS_PWS_BPT_PARAM_TBL   a,rws_asset_mast_tbl b where substr(a.BPT_CODE,1,2)='"
					+ dist + "' and substr(a.BPT_CODE,6,2)='" + man
					+ "' and  substr(a.BPT_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.BPT_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.BPT_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.BPT_CODE,13,2) and substr(a.BPT_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by BPT_CODE";
			complaintMasterData.stmt3 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs3 = complaintMasterData.stmt3.executeQuery(query3);
			
			for (; complaintMasterData.rs3.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs3.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs3.getString(2));
				compForm.setAssetCode(complaintMasterData.rs3.getString(3));
				compForm.setAssetName(complaintMasterData.rs3.getString(4));
			}

			String query4 = "select distinct a.CW_COLLWELL_CODE,nvl(a.location,'-'),b.asset_code,b.asset_name from RWS_PWS_CW_COLLWELL_PARAM_TBL     a,rws_asset_mast_tbl b where substr(a.CW_COLLWELL_CODE,1,2)='"
					+ dist + "' and substr(a.CW_COLLWELL_CODE,6,2)='" + man
					+ "' and  substr(a.CW_COLLWELL_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.CW_COLLWELL_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.CW_COLLWELL_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.CW_COLLWELL_CODE,13,2) and substr(a.CW_COLLWELL_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by CW_COLLWELL_CODE";
			complaintMasterData.stmt4 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs4 = complaintMasterData.stmt4.executeQuery(query4);
			
			for (; complaintMasterData.rs4.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs4.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs4.getString(2));
				compForm.setAssetCode(complaintMasterData.rs4.getString(3));
				compForm.setAssetName(complaintMasterData.rs4.getString(4));
			}

			String query5 = "select distinct a.GLBR_CODE,nvl(a.GLBR_LOC,'-'),b.asset_code,b.asset_name from RWS_PWS_GLBR_SC_PARAM_TBL    a,rws_asset_mast_tbl b where substr(a.GLBR_CODE,1,2)='"
					+ dist + "' and substr(a.GLBR_CODE,6,2)='" + man
					+ "' and  substr(a.GLBR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.GLBR_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.GLBR_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.GLBR_CODE,13,2) and substr(a.GLBR_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by GLBR_CODE";
			complaintMasterData.stmt5 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs5 = complaintMasterData.stmt5.executeQuery(query5);
			
			for (; complaintMasterData.rs5.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs5.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs5.getString(2));
				compForm.setAssetCode(complaintMasterData.rs5.getString(3));
				compForm.setAssetName(complaintMasterData.rs5.getString(4));
			}

			String query6 = "select distinct a.GLSR_CODE,nvl(a.GLSR_LOC,'-'),b.asset_code,b.asset_name from RWS_PWS_GLSR_SC_PARAM_TBL    a,rws_asset_mast_tbl b where substr(a.GLSR_CODE,1,2)='"
					+ dist + "' and substr(a.GLSR_CODE,6,2)='" + man
					+ "' and  substr(a.GLSR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.GLSR_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.GLSR_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.GLSR_CODE,13,2) and substr(a.GLSR_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by GLSR_CODE";
			complaintMasterData.stmt6 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs6 = complaintMasterData.stmt6.executeQuery(query6);
			
			for (; complaintMasterData.rs6.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs6.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs6.getString(2));
				compForm.setAssetCode(complaintMasterData.rs6.getString(3));
				compForm.setAssetName(complaintMasterData.rs6.getString(4));
			}

			String query7 = "select distinct a.OHSR_CODE,nvl(a.OHSR_LOC,'-'),b.asset_code,b.asset_name from RWS_PWS_OHSR_SC_PARAM_TBL    a,rws_asset_mast_tbl b where substr(a.OHSR_CODE,1,2)='"
					+ dist + "' and substr(a.OHSR_CODE,6,2)='" + man
					+ "' and  substr(a.OHSR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.OHSR_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.OHSR_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.OHSR_CODE,13,2) and substr(a.OHSR_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by OHSR_CODE";
			complaintMasterData.stmt7 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs7 = complaintMasterData.stmt7.executeQuery(query7);
			
			for (; complaintMasterData.rs7.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs7.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs7.getString(2));
				compForm.setAssetCode(complaintMasterData.rs7.getString(3));
				compForm.setAssetName(complaintMasterData.rs7.getString(4));
			}

			String query8 = "select distinct a.OHBR_CODE,nvl(a.OHBR_LOC,'-'),b.asset_code,b.asset_name from RWS_PWS_OHBR_SC_PARAM_TBL    a,rws_asset_mast_tbl b where substr(a.OHBR_CODE,1,2)='"
					+ dist + "' and substr(a.OHBR_CODE,6,2)='" + man
					+ "' and  substr(a.OHBR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.OHBR_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.OHBR_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.OHBR_CODE,13,2) and substr(a.OHBR_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by OHBR_CODE";
			complaintMasterData.stmt8 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs8 = complaintMasterData.stmt8.executeQuery(query8);
			
			for (; complaintMasterData.rs8.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs8.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs8.getString(2));
				compForm.setAssetCode(complaintMasterData.rs8.getString(3));
				compForm.setAssetName(complaintMasterData.rs8.getString(4));
			}

			String query9 = "select distinct a.RW_COLLWELL_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_PWS_RW_COLLWELL_PARAM_TBL   a,rws_asset_mast_tbl b where substr(a.RW_COLLWELL_CODE,1,2)='"
					+ dist + "' and substr(a.RW_COLLWELL_CODE,6,2)='" + man
					+ "' and  substr(a.RW_COLLWELL_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.RW_COLLWELL_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.RW_COLLWELL_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.RW_COLLWELL_CODE,13,2) and substr(a.RW_COLLWELL_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by RW_COLLWELL_CODE";
			complaintMasterData.stmt9 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs9 = complaintMasterData.stmt9.executeQuery(query9);
			
			for (; complaintMasterData.rs9.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs9.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs9.getString(2));
				compForm.setAssetCode(complaintMasterData.rs9.getString(3));
				compForm.setAssetName(complaintMasterData.rs9.getString(4));
			}

			String query10 = "select distinct a.SUMPCODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_PWS_SUMP_M_SC_PARAM_TBL        a,rws_asset_mast_tbl b where substr(a.SUMPCODE,1,2)='"
					+ dist + "' and substr(a.SUMPCODE,6,2)='" + man
					+ "' and  substr(a.SUMPCODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.SUMPCODE,1,2) and substr(b.hab_code,6,2)=substr(a.SUMPCODE,6,2) and substr(b.hab_code,13,2)=substr(a.SUMPCODE,13,2) and substr(a.SUMPCODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by SUMPCODE";
			complaintMasterData.stmt10 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs10 = complaintMasterData.stmt10.executeQuery(query10);
			
			for (; complaintMasterData.rs10.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs10.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs10.getString(2));
				compForm.setAssetCode(complaintMasterData.rs10.getString(3));
				compForm.setAssetName(complaintMasterData.rs10.getString(4));
			}

			String query11 = "select distinct a.OTHER_COMP_CODE ,nvl(a.COMP_LOCATION,'-'),b.asset_code,b.asset_name from RWS_PWS_OTHERS_PARAM_TBL          a,rws_asset_mast_tbl b where substr(a.OTHER_COMP_CODE,1,2)='"
					+ dist + "' and substr(a.OTHER_COMP_CODE,6,2)='" + man
					+ "' and  substr(a.OTHER_COMP_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.OTHER_COMP_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.OTHER_COMP_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.OTHER_COMP_CODE,13,2) and substr(a.OTHER_COMP_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by OTHER_COMP_CODE";
			complaintMasterData.stmt11 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs11 = complaintMasterData.stmt11.executeQuery(query11);
			
			for (; complaintMasterData.rs11.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs11.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs11.getString(2));
				compForm.setAssetCode(complaintMasterData.rs11.getString(3));
				compForm.setAssetName(complaintMasterData.rs11.getString(4));
			}

			String query12 = "select distinct a.BRIDGE_CODE ,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name from RWS_PWS_FP_BRIDGE_PARAM_TBL            a,rws_asset_mast_tbl b where substr(a.BRIDGE_CODE,1,2)='"
					+ dist + "' and substr(a.BRIDGE_CODE,6,2)='" + man
					+ "' and  substr(a.BRIDGE_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.BRIDGE_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.BRIDGE_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.BRIDGE_CODE,13,2) and substr(a.BRIDGE_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by BRIDGE_CODE";
			complaintMasterData.stmt12 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs12 = complaintMasterData.stmt12.executeQuery(query12);
			
			for (; complaintMasterData.rs12.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs12.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs12.getString(2));
				compForm.setAssetCode(complaintMasterData.rs12.getString(3));
				compForm.setAssetName(complaintMasterData.rs12.getString(4));
			}

			String query13 = "select distinct a.PUMP_CODE ,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_PWS_SUBCOMP_PARAM_TBL              a,rws_asset_mast_tbl b where substr(a.PUMP_CODE,1,2)='"
					+ dist + "' and substr(a.PUMP_CODE,6,2)='" + man
					+ "' and  substr(a.PUMP_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.PUMP_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.PUMP_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.PUMP_CODE,13,2) and substr(a.PUMP_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by PUMP_CODE";
			complaintMasterData.stmt13 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs13 = complaintMasterData.stmt13.executeQuery(query13);
			
			for (; complaintMasterData.rs13.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs13.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs13.getString(2));
				compForm.setAssetCode(complaintMasterData.rs13.getString(3));
				compForm.setAssetName(complaintMasterData.rs13.getString(4));
			}

			String query14 = "select distinct a.PUMPHOUSE_CODE ,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_PWS_PUMPHOUSE_PARAM_TBL                a,rws_asset_mast_tbl b where substr(a.PUMPHOUSE_CODE,1,2)='"
					+ dist + "' and substr(a.PUMPHOUSE_CODE,6,2)='" + man
					+ "' and  substr(a.PUMPHOUSE_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.PUMPHOUSE_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.PUMPHOUSE_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.PUMPHOUSE_CODE,13,2) and substr(a.PUMPHOUSE_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by PUMPHOUSE_CODE";
			complaintMasterData.stmt14 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs14 = complaintMasterData.stmt13.executeQuery(query14);
			
			for (; complaintMasterData.rs14.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs14.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs14.getString(2));
				compForm.setAssetCode(complaintMasterData.rs14.getString(3));
				compForm.setAssetName(complaintMasterData.rs14.getString(4));
			}

			String query15 = "select distinct a.PUMPINGMAIN_CODE  ,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_PWS_PUMPINGMAIN_TBL                  a,rws_asset_mast_tbl b where substr(a.PUMPINGMAIN_CODE,1,2)='"
					+ dist + "' and substr(a.PUMPINGMAIN_CODE,6,2)='" + man
					+ "' and  substr(a.PUMPINGMAIN_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.PUMPINGMAIN_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.PUMPINGMAIN_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.PUMPINGMAIN_CODE,13,2) and substr(a.PUMPINGMAIN_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by PUMPINGMAIN_CODE";
			complaintMasterData.stmt15 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs15 = complaintMasterData.stmt15.executeQuery(query15);
			
			for (; complaintMasterData.rs15.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs15.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs15.getString(2));
				compForm.setAssetCode(complaintMasterData.rs15.getString(3));
				compForm.setAssetName(complaintMasterData.rs15.getString(4));
			}

			String query16 = "select distinct a.SSSC_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_PWS_SS_SC_PARAM_TBL                  a,rws_asset_mast_tbl b where substr(a.SSSC_CODE,1,2)='"
					+ dist + "' and substr(a.SSSC_CODE,6,2)='" + man
					+ "' and  substr(a.SSSC_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.SSSC_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.SSSC_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.SSSC_CODE,13,2) and substr(a.SSSC_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by SSSC_CODE";
			complaintMasterData.stmt16 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs16 = complaintMasterData.stmt16.executeQuery(query16);
			
			for (; complaintMasterData.rs16.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs16.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs16.getString(2));
				compForm.setAssetCode(complaintMasterData.rs16.getString(3));
				compForm.setAssetName(complaintMasterData.rs16.getString(4));
			}

			String query17 = "select distinct a.WTPSC_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_PWS_WTP_SC_PARAM_TBL                    a,rws_asset_mast_tbl b where substr(a.WTPSC_CODE,1,2)='"
					+ dist + "' and substr(a.WTPSC_CODE,6,2)='" + man
					+ "' and  substr(a.WTPSC_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.WTPSC_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.WTPSC_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.WTPSC_CODE,13,2) and substr(a.WTPSC_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by WTPSC_CODE";
			complaintMasterData.stmt17 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs17 = complaintMasterData.stmt17.executeQuery(query17);
			
			for (; complaintMasterData.rs17.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs17.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs17.getString(2));
				compForm.setAssetCode(complaintMasterData.rs17.getString(3));
				compForm.setAssetName(complaintMasterData.rs17.getString(4));
			}

			String query18 = "select distinct a.WTPSC_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_PWS_WTP_SC_PARAM_TBL                    a,rws_asset_mast_tbl b where substr(a.WTPSC_CODE,1,2)='"
					+ dist + "' and substr(a.WTPSC_CODE,6,2)='" + man
					+ "' and  substr(a.WTPSC_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.WTPSC_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.WTPSC_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.WTPSC_CODE,13,2) and substr(a.WTPSC_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by WTPSC_CODE";
			complaintMasterData.stmt18 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs18 = complaintMasterData.stmt18.executeQuery(query18);
			
			for (; complaintMasterData.rs18.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs18.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs18.getString(2));
				compForm.setAssetCode(complaintMasterData.rs18.getString(3));
				compForm.setAssetName(complaintMasterData.rs18.getString(4));
			}

			String query19 = "select distinct a.GRAVITYMAIN_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_PWS_GRAVITYMAIN_TBL      a,rws_asset_mast_tbl b where substr(a.GRAVITYMAIN_CODE,1,2)='"
					+ dist + "' and substr(a.GRAVITYMAIN_CODE,6,2)='" + man
					+ "' and  substr(a.GRAVITYMAIN_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.GRAVITYMAIN_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.GRAVITYMAIN_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.GRAVITYMAIN_CODE,13,2) and substr(a.GRAVITYMAIN_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by GRAVITYMAIN_CODE";
			complaintMasterData.stmt19 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs19 = complaintMasterData.stmt19.executeQuery(query19);
			
			for (; complaintMasterData.rs19.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs19.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs19.getString(2));
				compForm.setAssetCode(complaintMasterData.rs19.getString(3));
				compForm.setAssetName(complaintMasterData.rs19.getString(4));
			}

			String query20 = "select distinct a.SOURCE_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_SOURCE_TBL      a,rws_asset_mast_tbl b where substr(a.SOURCE_CODE,1,2)='"
					+ dist + "' and substr(a.SOURCE_CODE,6,2)='" + man
					+ "' and  substr(a.SOURCE_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.SOURCE_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.SOURCE_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.SOURCE_CODE,13,2) and substr(a.SOURCE_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode
					+ "'AND SUBSTR(A.SOURCE_CODE,17,3) LIKE '6%' order by SOURCE_CODE";
			complaintMasterData.stmt20 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs20 = complaintMasterData.stmt20.executeQuery(query20);
			
			for (; complaintMasterData.rs20.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs20.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs20.getString(2));
				compForm.setAssetCode(complaintMasterData.rs20.getString(3));
				compForm.setAssetName(complaintMasterData.rs20.getString(4));
			}

			String query21 = "select distinct a.PUMPDET_CODE,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name from RWS_PWS_PUMP_DET_SC_PARAM_TBL      a,rws_asset_mast_tbl b where substr(a.PUMPDET_CODE,1,2)='"
					+ dist + "' and substr(a.PUMPDET_CODE,6,2)='" + man
					+ "' and  substr(a.PUMPDET_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.PUMPDET_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.PUMPDET_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.PUMPDET_CODE,13,2) and substr(a.PUMPDET_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "'   order by PUMPDET_CODE";
			complaintMasterData.stmt21 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs21 = complaintMasterData.stmt21.executeQuery(query21);
			
			for (; complaintMasterData.rs21.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs21.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs21.getString(2));
				compForm.setAssetCode(complaintMasterData.rs21.getString(3));
				compForm.setAssetName(complaintMasterData.rs21.getString(4));
			}

			String query22 = "select distinct a.WATCHMAN_CODE,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name from RWS_PWS_WATCHMAN_PARAM_TBL      a,rws_asset_mast_tbl b where substr(a.WATCHMAN_CODE,1,2)='"
					+ dist + "' and substr(a.WATCHMAN_CODE,6,2)='" + man
					+ "' and  substr(a.WATCHMAN_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.WATCHMAN_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.WATCHMAN_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.WATCHMAN_CODE,13,2) and substr(a.WATCHMAN_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "'   order by WATCHMAN_CODE";
			complaintMasterData.stmt22 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs22 = complaintMasterData.stmt22.executeQuery(query22);
			
			for (; complaintMasterData.rs22.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs22.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs22.getString(2));
				compForm.setAssetCode(complaintMasterData.rs22.getString(3));
				compForm.setAssetName(complaintMasterData.rs22.getString(4));
			}

		} catch (Exception e) {
			Debug.println("The error in getassts=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return assts;
	}

	public static ArrayList getAsstsPwss(String Habcode, String asstcode, DataSource dataSource) throws Exception {
		ArrayList assts;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		
		complaintMasterData.closeAll();
		
		CompForm compForm = null;
		
		String query1 = null;
		String query2 = null;
		String dist = null;
		String man = null;
		String pan = null;
		try {
			if (Habcode != null && !Habcode.equals("")) {
				dist = Habcode.substring(0, 2);
				
				man = Habcode.substring(5, 7);
				pan = Habcode.substring(12, 14);
				
			}
			
		} catch (Exception e) {
			Debug.println(" exception String" + e);
		}
		assts = new ArrayList();
		String query = "";
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			int count = 0;
			compForm = new CompForm();
			query1 = "select distinct a.cissc_code,a.cis_loc,b.asset_code,b.asset_name from rws_pws_cis_sc_param_tbl a,rws_asset_mast_tbl b where substr(a.cissc_code,1,2)='"
					+ dist + "' and substr(a.cissc_code,6,2)='" + man
					+ "' and  substr(a.cissc_code,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.cissc_code,1,2) and substr(b.hab_code,6,2)=substr(a.cissc_code,6,2) and substr(b.hab_code,13,2)=substr(a.cissc_code,13,2) and substr(a.cissc_code,13,2)='"
					+ pan + "' and b.type_of_asset_code='" + asstcode + "' and substr(cissc_code,1,16)='" + Habcode
					+ "' order by cissc_code";
			complaintMasterData.stmt1 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs1 = complaintMasterData.stmt1.executeQuery(query1);
			for (; complaintMasterData.rs1.next(); assts.add(compForm)) {
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs1.getString(1));
				
				compForm.setAssetLocation(complaintMasterData.rs1.getString(2));
				
				compForm.setAssetCode(complaintMasterData.rs1.getString(3));
				
				compForm.setAssetName(complaintMasterData.rs1.getString(4));
				
			}

			query2 = "select distinct a.distrisc_code,nvl(a.location,'-'),b.asset_code,b.asset_name from rws_pws_distri_sc_param_tbl a,rws_asset_mast_tbl b where substr(a.distrisc_code,1,2)='"
					+ dist + "' and substr(a.distrisc_code,6,2)='" + man
					+ "' and  substr(a.distrisc_code,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.distrisc_code,1,2) and substr(b.hab_code,6,2)=substr(a.distrisc_code,6,2) and substr(b.hab_code,13,2)=substr(a.distrisc_code,13,2) and substr(a.distrisc_code,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' and substr(distrisc_code,1,16)='" + Habcode
					+ "'  order by distrisc_code";
			complaintMasterData.stmt2 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs2 = complaintMasterData.stmt2.executeQuery(query2);
			
			for (; complaintMasterData.rs2.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs2.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs2.getString(2));
				compForm.setAssetCode(complaintMasterData.rs2.getString(3));
				compForm.setAssetName(complaintMasterData.rs2.getString(4));
			}

			String query3 = "select distinct a.BPT_CODE,nvl(a.location,'-'),b.asset_code,b.asset_name from RWS_PWS_BPT_PARAM_TBL   a,rws_asset_mast_tbl b where substr(a.BPT_CODE,1,2)='"
					+ dist + "' and substr(a.BPT_CODE,6,2)='" + man
					+ "' and  substr(a.BPT_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.BPT_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.BPT_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.BPT_CODE,13,2) and substr(a.BPT_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' and substr(bpt_code,1,16)='" + Habcode
					+ "' order by BPT_CODE";
			complaintMasterData.stmt3 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs3 = complaintMasterData.stmt3.executeQuery(query3);
			
			for (; complaintMasterData.rs3.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs3.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs3.getString(2));
				compForm.setAssetCode(complaintMasterData.rs3.getString(3));
				compForm.setAssetName(complaintMasterData.rs3.getString(4));
			}

			String query4 = "select distinct a.CW_COLLWELL_CODE,nvl(a.location,'-'),b.asset_code,b.asset_name from RWS_PWS_CW_COLLWELL_PARAM_TBL     a,rws_asset_mast_tbl b where substr(a.CW_COLLWELL_CODE,1,2)='"
					+ dist + "' and substr(a.CW_COLLWELL_CODE,6,2)='" + man
					+ "' and  substr(a.CW_COLLWELL_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.CW_COLLWELL_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.CW_COLLWELL_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.CW_COLLWELL_CODE,13,2) and substr(a.CW_COLLWELL_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' and substr(cw_collwell_code,1,16)='"
					+ Habcode + "' order by CW_COLLWELL_CODE";
			complaintMasterData.stmt4 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs4 = complaintMasterData.stmt4.executeQuery(query4);
			
			for (; complaintMasterData.rs4.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs4.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs4.getString(2));
				compForm.setAssetCode(complaintMasterData.rs4.getString(3));
				compForm.setAssetName(complaintMasterData.rs4.getString(4));
			}

			String query5 = "select distinct a.GLBR_CODE,nvl(a.GLBR_LOC,'-'),b.asset_code,b.asset_name from RWS_PWS_GLBR_SC_PARAM_TBL    a,rws_asset_mast_tbl b where substr(a.GLBR_CODE,1,2)='"
					+ dist + "' and substr(a.GLBR_CODE,6,2)='" + man
					+ "' and  substr(a.GLBR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.GLBR_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.GLBR_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.GLBR_CODE,13,2) and substr(a.GLBR_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' and substr(glbr_code,1,16)='" + Habcode
					+ "' order by GLBR_CODE";
			complaintMasterData.stmt5 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs5 = complaintMasterData.stmt5.executeQuery(query5);
			
			for (; complaintMasterData.rs5.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs5.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs5.getString(2));
				compForm.setAssetCode(complaintMasterData.rs5.getString(3));
				compForm.setAssetName(complaintMasterData.rs5.getString(4));
			}

			String query6 = "select distinct a.GLSR_CODE,nvl(a.GLSR_LOC,'-'),b.asset_code,b.asset_name from RWS_PWS_GLSR_SC_PARAM_TBL    a,rws_asset_mast_tbl b where substr(a.GLSR_CODE,1,2)='"
					+ dist + "' and substr(a.GLSR_CODE,6,2)='" + man
					+ "' and  substr(a.GLSR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.GLSR_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.GLSR_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.GLSR_CODE,13,2) and substr(a.GLSR_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' and substr(glsr_code,1,16)='" + Habcode
					+ "' order by GLSR_CODE";
			complaintMasterData.stmt6 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs6 = complaintMasterData.stmt6.executeQuery(query6);
			
			for (; complaintMasterData.rs6.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs6.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs6.getString(2));
				compForm.setAssetCode(complaintMasterData.rs6.getString(3));
				compForm.setAssetName(complaintMasterData.rs6.getString(4));
			}

			String query7 = "select distinct a.OHSR_CODE,nvl(a.OHSR_LOC,'-'),b.asset_code,b.asset_name from RWS_PWS_OHSR_SC_PARAM_TBL    a,rws_asset_mast_tbl b where substr(a.OHSR_CODE,1,2)='"
					+ dist + "' and substr(a.OHSR_CODE,6,2)='" + man
					+ "' and  substr(a.OHSR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.OHSR_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.OHSR_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.OHSR_CODE,13,2) and substr(a.OHSR_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' and substr(ohsr_code,1,16)='" + Habcode
					+ "' order by OHSR_CODE";
			complaintMasterData.stmt7 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs7 = complaintMasterData.stmt7.executeQuery(query7);
			
			for (; complaintMasterData.rs7.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs7.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs7.getString(2));
				compForm.setAssetCode(complaintMasterData.rs7.getString(3));
				compForm.setAssetName(complaintMasterData.rs7.getString(4));
			}

			String query8 = "select distinct a.OHBR_CODE,nvl(a.OHBR_LOC,'-'),b.asset_code,b.asset_name from RWS_PWS_OHBR_SC_PARAM_TBL    a,rws_asset_mast_tbl b where substr(a.OHBR_CODE,1,2)='"
					+ dist + "' and substr(a.OHBR_CODE,6,2)='" + man
					+ "' and  substr(a.OHBR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.OHBR_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.OHBR_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.OHBR_CODE,13,2) and substr(a.OHBR_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "'  and substr(ohbr_code,1,16)='" + Habcode
					+ "'  order by OHBR_CODE";
			complaintMasterData.stmt8 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs8 = complaintMasterData.stmt8.executeQuery(query8);
			
			for (; complaintMasterData.rs8.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs8.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs8.getString(2));
				compForm.setAssetCode(complaintMasterData.rs8.getString(3));
				compForm.setAssetName(complaintMasterData.rs8.getString(4));
			}

			String query9 = "select distinct a.RW_COLLWELL_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_PWS_RW_COLLWELL_PARAM_TBL   a,rws_asset_mast_tbl b where substr(a.RW_COLLWELL_CODE,1,2)='"
					+ dist + "' and substr(a.RW_COLLWELL_CODE,6,2)='" + man
					+ "' and  substr(a.RW_COLLWELL_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.RW_COLLWELL_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.RW_COLLWELL_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.RW_COLLWELL_CODE,13,2) and substr(a.RW_COLLWELL_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' and substr(rw_collwell_code,1,16)='"
					+ Habcode + "' order by RW_COLLWELL_CODE";
			complaintMasterData.stmt9 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs9 = complaintMasterData.stmt9.executeQuery(query9);
			
			for (; complaintMasterData.rs9.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs9.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs9.getString(2));
				compForm.setAssetCode(complaintMasterData.rs9.getString(3));
				compForm.setAssetName(complaintMasterData.rs9.getString(4));
			}

			String query10 = "select distinct a.SUMPCODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_PWS_SUMP_M_SC_PARAM_TBL        a,rws_asset_mast_tbl b where substr(a.SUMPCODE,1,2)='"
					+ dist + "' and substr(a.SUMPCODE,6,2)='" + man
					+ "' and  substr(a.SUMPCODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.SUMPCODE,1,2) and substr(b.hab_code,6,2)=substr(a.SUMPCODE,6,2) and substr(b.hab_code,13,2)=substr(a.SUMPCODE,13,2) and substr(a.SUMPCODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by SUMPCODE";
			complaintMasterData.stmt10 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs10 = complaintMasterData.stmt10.executeQuery(query10);
			
			for (; complaintMasterData.rs10.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs10.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs10.getString(2));
				compForm.setAssetCode(complaintMasterData.rs10.getString(3));
				compForm.setAssetName(complaintMasterData.rs10.getString(4));
			}

			String query11 = "select distinct a.OTHER_COMP_CODE ,nvl(a.COMP_LOCATION,'-'),b.asset_code,b.asset_name from RWS_PWS_OTHERS_PARAM_TBL          a,rws_asset_mast_tbl b where substr(a.OTHER_COMP_CODE,1,2)='"
					+ dist + "' and substr(a.OTHER_COMP_CODE,6,2)='" + man
					+ "' and  substr(a.OTHER_COMP_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.OTHER_COMP_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.OTHER_COMP_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.OTHER_COMP_CODE,13,2) and substr(a.OTHER_COMP_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' and substr(other_comp_code,1,16)='"
					+ Habcode + "' order by OTHER_COMP_CODE";
			complaintMasterData.stmt11 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs11 = complaintMasterData.stmt11.executeQuery(query11);
			
			for (; complaintMasterData.rs11.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs11.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs11.getString(2));
				compForm.setAssetCode(complaintMasterData.rs11.getString(3));
				compForm.setAssetName(complaintMasterData.rs11.getString(4));
			}

			String query12 = "select distinct a.BRIDGE_CODE ,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name from RWS_PWS_FP_BRIDGE_PARAM_TBL            a,rws_asset_mast_tbl b where substr(a.BRIDGE_CODE,1,2)='"
					+ dist + "' and substr(a.BRIDGE_CODE,6,2)='" + man
					+ "' and  substr(a.BRIDGE_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.BRIDGE_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.BRIDGE_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.BRIDGE_CODE,13,2) and substr(a.BRIDGE_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' and substr(bridge_code,1,16)='" + Habcode
					+ "' order by BRIDGE_CODE";
			complaintMasterData.stmt12 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs12 = complaintMasterData.stmt12.executeQuery(query12);
			
			for (; complaintMasterData.rs12.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs12.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs12.getString(2));
				compForm.setAssetCode(complaintMasterData.rs12.getString(3));
				compForm.setAssetName(complaintMasterData.rs12.getString(4));
			}

			String query13 = "select distinct a.PUMP_CODE ,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_PWS_SUBCOMP_PARAM_TBL              a,rws_asset_mast_tbl b where substr(a.PUMP_CODE,1,2)='"
					+ dist + "' and substr(a.PUMP_CODE,6,2)='" + man
					+ "' and  substr(a.PUMP_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.PUMP_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.PUMP_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.PUMP_CODE,13,2) and substr(a.PUMP_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' and substr(pump_code,1,16)='" + Habcode
					+ "' order by PUMP_CODE";
			complaintMasterData.stmt13 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs13 = complaintMasterData.stmt13.executeQuery(query13);
			
			for (; complaintMasterData.rs13.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs13.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs13.getString(2));
				compForm.setAssetCode(complaintMasterData.rs13.getString(3));
				compForm.setAssetName(complaintMasterData.rs13.getString(4));
			}

			String query14 = "select distinct a.PUMPHOUSE_CODE ,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_PWS_PUMPHOUSE_PARAM_TBL                a,rws_asset_mast_tbl b where substr(a.PUMPHOUSE_CODE,1,2)='"
					+ dist + "' and substr(a.PUMPHOUSE_CODE,6,2)='" + man
					+ "' and  substr(a.PUMPHOUSE_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.PUMPHOUSE_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.PUMPHOUSE_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.PUMPHOUSE_CODE,13,2) and substr(a.PUMPHOUSE_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' and substr(pumphouse_code,1,16)='" + Habcode
					+ "' order by PUMPHOUSE_CODE";
			complaintMasterData.stmt14 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs14 = complaintMasterData.stmt13.executeQuery(query14);
			
			for (; complaintMasterData.rs14.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs14.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs14.getString(2));
				compForm.setAssetCode(complaintMasterData.rs14.getString(3));
				compForm.setAssetName(complaintMasterData.rs14.getString(4));
			}

			String query15 = "select distinct a.PUMPINGMAIN_CODE  ,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_PWS_PUMPINGMAIN_TBL                  a,rws_asset_mast_tbl b where substr(a.PUMPINGMAIN_CODE,1,2)='"
					+ dist + "' and substr(a.PUMPINGMAIN_CODE,6,2)='" + man
					+ "' and  substr(a.PUMPINGMAIN_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.PUMPINGMAIN_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.PUMPINGMAIN_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.PUMPINGMAIN_CODE,13,2) and substr(a.PUMPINGMAIN_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "'  and substr(pumpingmain_code,1,16)='"
					+ Habcode + "' order by PUMPINGMAIN_CODE";
			complaintMasterData.stmt15 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs15 = complaintMasterData.stmt15.executeQuery(query15);
			
			for (; complaintMasterData.rs15.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs15.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs15.getString(2));
				compForm.setAssetCode(complaintMasterData.rs15.getString(3));
				compForm.setAssetName(complaintMasterData.rs15.getString(4));
			}

			String query16 = "select distinct a.SSSC_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_PWS_SS_SC_PARAM_TBL                  a,rws_asset_mast_tbl b where substr(a.SSSC_CODE,1,2)='"
					+ dist + "' and substr(a.SSSC_CODE,6,2)='" + man
					+ "' and  substr(a.SSSC_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.SSSC_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.SSSC_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.SSSC_CODE,13,2) and substr(a.SSSC_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' and substr(sssc_code,1,16)='" + Habcode
					+ "' order by SSSC_CODE";
			complaintMasterData.stmt16 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs16 = complaintMasterData.stmt16.executeQuery(query16);
			
			for (; complaintMasterData.rs16.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs16.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs16.getString(2));
				compForm.setAssetCode(complaintMasterData.rs16.getString(3));
				compForm.setAssetName(complaintMasterData.rs16.getString(4));
			}

			String query17 = "select distinct a.WTPSC_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_PWS_WTP_SC_PARAM_TBL                    a,rws_asset_mast_tbl b where substr(a.WTPSC_CODE,1,2)='"
					+ dist + "' and substr(a.WTPSC_CODE,6,2)='" + man
					+ "' and  substr(a.WTPSC_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.WTPSC_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.WTPSC_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.WTPSC_CODE,13,2) and substr(a.WTPSC_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' and substr(wtpsc_code,1,16)='" + Habcode
					+ "'  order by WTPSC_CODE";
			complaintMasterData.stmt17 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs17 = complaintMasterData.stmt17.executeQuery(query17);
			
			for (; complaintMasterData.rs17.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs17.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs17.getString(2));
				compForm.setAssetCode(complaintMasterData.rs17.getString(3));
				compForm.setAssetName(complaintMasterData.rs17.getString(4));
			}

			String query19 = "select distinct a.GRAVITYMAIN_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_PWS_GRAVITYMAIN_TBL      a,rws_asset_mast_tbl b where substr(a.GRAVITYMAIN_CODE,1,2)='"
					+ dist + "' and substr(a.GRAVITYMAIN_CODE,6,2)='" + man
					+ "' and  substr(a.GRAVITYMAIN_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.GRAVITYMAIN_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.GRAVITYMAIN_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.GRAVITYMAIN_CODE,13,2) and substr(a.GRAVITYMAIN_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "'  and substr(gravitymain_code,1,16)='"
					+ Habcode + "' order by GRAVITYMAIN_CODE";
			complaintMasterData.stmt19 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs19 = complaintMasterData.stmt19.executeQuery(query19);
			
			for (; complaintMasterData.rs19.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs19.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs19.getString(2));
				compForm.setAssetCode(complaintMasterData.rs19.getString(3));
				compForm.setAssetName(complaintMasterData.rs19.getString(4));
			}

			String query20 = "select distinct a.SOURCE_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_SOURCE_TBL      a,rws_asset_mast_tbl b where substr(a.SOURCE_CODE,1,2)='"
					+ dist + "' and substr(a.SOURCE_CODE,6,2)='" + man
					+ "' and  substr(a.SOURCE_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.SOURCE_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.SOURCE_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.SOURCE_CODE,13,2) and substr(a.SOURCE_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode
					+ "'AND SUBSTR(A.SOURCE_CODE,17,3) LIKE '6%' and substr(source_code_code,1,16)='" + Habcode
					+ "' order by SOURCE_CODE";
			complaintMasterData.stmt20 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs20 = complaintMasterData.stmt20.executeQuery(query20);
			
			for (; complaintMasterData.rs20.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs20.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs20.getString(2));
				compForm.setAssetCode(complaintMasterData.rs20.getString(3));
				compForm.setAssetName(complaintMasterData.rs20.getString(4));
			}

			String query21 = "select distinct a.PUMPDET_CODE,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name from RWS_PWS_PUMP_DET_SC_PARAM_TBL      a,rws_asset_mast_tbl b where substr(a.PUMPDET_CODE,1,2)='"
					+ dist + "' and substr(a.PUMPDET_CODE,6,2)='" + man
					+ "' and  substr(a.PUMPDET_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.PUMPDET_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.PUMPDET_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.PUMPDET_CODE,13,2) and substr(a.PUMPDET_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "'  and substr(pumpdet_code,1,16)='" + Habcode
					+ "'  order by PUMPDET_CODE";
			complaintMasterData.stmt21 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs21 = complaintMasterData.stmt21.executeQuery(query21);
			
			for (; complaintMasterData.rs21.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs21.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs21.getString(2));
				compForm.setAssetCode(complaintMasterData.rs21.getString(3));
				compForm.setAssetName(complaintMasterData.rs21.getString(4));
			}

			String query22 = "select distinct a.WATCHMAN_CODE,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name from RWS_PWS_WATCHMAN_PARAM_TBL      a,rws_asset_mast_tbl b where substr(a.WATCHMAN_CODE,1,2)='"
					+ dist + "' and substr(a.WATCHMAN_CODE,6,2)='" + man
					+ "' and  substr(a.WATCHMAN_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(b.hab_code,1,2)=substr(a.WATCHMAN_CODE,1,2) and substr(b.hab_code,6,2)=substr(a.WATCHMAN_CODE,6,2) and substr(b.hab_code,13,2)=substr(a.WATCHMAN_CODE,13,2) and substr(a.WATCHMAN_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "'  and substr(watchman_code,1,16)='" + Habcode
					+ "'  order by WATCHMAN_CODE";
			complaintMasterData.stmt22 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs22 = complaintMasterData.stmt22.executeQuery(query22);
			
			for (; complaintMasterData.rs22.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs22.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs22.getString(2));
				compForm.setAssetCode(complaintMasterData.rs22.getString(3));
				compForm.setAssetName(complaintMasterData.rs22.getString(4));
			}

			assts.add(compForm);
		} catch (Exception e) {
			Debug.println("The error in getassts=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return assts;
	}

	public static String getNextComplaintNo(String districtCode, String typeOfAsset, String mandalCode,
			String panchayatCode, DataSource dataSource) {
		String complaintNo;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
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
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		Date date = new Date();
		SimpleDateFormat dateFormatter = new SimpleDateFormat("yy");
		String currentYear = dateFormatter.format(date);
		complaintNo = null;
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintNo = districtCode + mandalCode + panchayatCode + "GC" + currentYear;

			String query = " SELECT MAX(SUBSTR(complaint_no,11,4)) as complaint_no FROM RWS_generic_complaints_reg_tbl  "
					+ "WHERE complaint_no LIKE ?";
			
			complaintMasterData.ps = complaintMasterData.conn.prepareStatement(query);
			complaintMasterData.ps.setString(1, complaintNo+"%");
			
			complaintMasterData.rs1 = complaintMasterData.ps.executeQuery();
			
			if (complaintMasterData.rs1.next()) {
				int sno = complaintMasterData.rs1.getInt(1);

				if (sno == 0) {
					complaintNo = complaintNo + "0001";
				} else {
					if (sno >= 9999)
						throw new Exception("No more complaint no left.");
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
			System.out.println("Exception in getNextComplaintNoother : \n" + e);
		} finally {
			if (complaintMasterData.rs1 != null)
				try {
					complaintMasterData.rs1.close();
				} catch (SQLException sqlexception) {
				}
			if (complaintMasterData.ps != null)
				try {
					complaintMasterData.ps.close();
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
	
	public ArrayList getAssetMainDetails(String HabCode, String astcode) {
		ArrayList astlist = new ArrayList();
		CompForm compForm = null;
		try {
			String qry = "Select asset_name,nvl(location,'-'),to_char(date_creation,'dd/mm/yyyy'),asset_Code from rws_asset_mast_tbl where hab_code='"
					+ HabCode + "' and type_of_asset_code='" + astcode + "'";
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			
			for (rs = stmt.executeQuery(qry); rs.next(); astlist.add(compForm)) {
				compForm = new CompForm();
				compForm.setAssetName(rs.getString(1));
				compForm.setAssetLocation(rs.getString(2));
				compForm.setDateCreation(rs.getString(3));
				compForm.setAssetCode(rs.getString(4));
			}

		} catch (Exception e) {
			Debug.println("Exception in getting asset main Details:" + e);
		}
		return astlist;
	}

	//
	// code modified by sridhar
	public static ArrayList getAsstsastss(String Habcode, String asstcode, String dcode, DataSource dataSource)
			throws Exception {
		ArrayList assts, assts1, assts2, asst3;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		
		complaintMasterData.conn = RwsOffices.getConn();
		CompForm compForm1 = null;
		CompForm compForm = null;
		
		String query1 = null;
		String query2 = null;
		assts1 = new ArrayList();
		assts2 = new ArrayList();
		asst3 = new ArrayList();
		try {
			String qry = "Select asset_name,nvl(location,'-'),to_char(date_creation,'dd/mm/yyyy'),asset_Code from rws_asset_mast_tbl where  type_of_asset_code='"
					+ asstcode + "'";
			if (dcode != null && !dcode.equals("")) {
				qry += " and substr(hab_code,1,2)='" + dcode + "' ";
			}
			if (Habcode != null && !Habcode.equals("")) {
				qry += " and hab_code='" + Habcode + "' ";
			}
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			
			int i = 0;
			for (complaintMasterData.rs = complaintMasterData.stmt.executeQuery(qry); complaintMasterData.rs.next();) {
				assts = new ArrayList();
				compForm1 = new CompForm();
				compForm1.setAssetName(complaintMasterData.rs.getString(1));
				compForm1.setAssetLocation(complaintMasterData.rs.getString(2));
				compForm1.setDateCreation(complaintMasterData.rs.getString(3));
				compForm1.setAssetCode(complaintMasterData.rs.getString(4));
				compForm1.setAstCmpt("asset");
				assts1.add(compForm1);
				query1 = "select distinct a.cissc_code,a.cis_loc,b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from rws_ast_cis_sc_param_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and  substr(a.cissc_code,1,16)=b.hab_code and b.asset_code=a.asset_code   and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by cissc_code";
				complaintMasterData.stmt1 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs1 = complaintMasterData.stmt1.executeQuery(query1);
				
				for (; complaintMasterData.rs1.next(); assts.add(compForm)) {
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs1.getString(1));
					
					compForm.setAssetLocation(complaintMasterData.rs1.getString(2));
					
					compForm.setAssetCode(complaintMasterData.rs1.getString(3));
					
					compForm.setAssetName(complaintMasterData.rs1.getString(4));
					
					compForm.setDateCreation(complaintMasterData.rs1.getString(5));
					compForm.setName("Cisterns");
					compForm.setAstCmpt("component");
					compForm.setCompCode("20");
				}

				query2 = "select distinct a.distrisc_code,nvl(a.location,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from rws_ast_distri_sc_param_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.distrisc_code,1,16)=b.hab_code and b.asset_code=a.asset_code  and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by distrisc_code";
				complaintMasterData.stmt2 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs2 = complaintMasterData.stmt2.executeQuery(query2);
				
				for (; complaintMasterData.rs2.next(); assts.add(compForm)) {
				
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs2.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs2.getString(2));
					compForm.setAssetCode(complaintMasterData.rs2.getString(3));
					compForm.setAssetName(complaintMasterData.rs2.getString(4));
					compForm.setDateCreation(complaintMasterData.rs2.getString(5));
					compForm.setName("Distribution");
					compForm.setAstCmpt("component");
					compForm.setCompCode("14");
				}

				String query3 = "select distinct a.BPT_CODE,nvl(a.location,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_BPT_PARAM_TBL   a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and  substr(a.BPT_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by BPT_CODE";
				complaintMasterData.stmt3 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs3 = complaintMasterData.stmt3.executeQuery(query3);
				
				for (; complaintMasterData.rs3.next(); assts.add(compForm)) {
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs3.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs3.getString(2));
					compForm.setAssetCode(complaintMasterData.rs3.getString(3));
					compForm.setAssetName(complaintMasterData.rs3.getString(4));
					compForm.setDateCreation(complaintMasterData.rs3.getString(5));
					compForm.setName("Bpt");
					compForm.setCompCode("19");
					compForm.setAstCmpt("component");
				}

				String query4 = "select distinct a.CW_COLLWELL_CODE,nvl(a.location,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_CW_COLLWELL_PARAM_TBL     a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  substr(a.CW_COLLWELL_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "'  order by CW_COLLWELL_CODE";
				complaintMasterData.stmt4 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs4 = complaintMasterData.stmt4.executeQuery(query4);
				
				for (; complaintMasterData.rs4.next(); assts.add(compForm)) {
				
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs4.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs4.getString(2));
					compForm.setAssetCode(complaintMasterData.rs4.getString(3));
					compForm.setAssetName(complaintMasterData.rs4.getString(4));
					compForm.setDateCreation(complaintMasterData.rs4.getString(5));
					compForm.setName("Clear Water Collection Well");
					compForm.setCompCode("09");
					compForm.setAstCmpt("component");
				}

				String query5 = "select distinct a.GLBR_CODE,nvl(a.GLBR_LOC,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_GLBR_SC_PARAM_TBL    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  substr(a.GLBR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by GLBR_CODE";
				complaintMasterData.stmt5 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs5 = complaintMasterData.stmt5.executeQuery(query5);
				
				for (; complaintMasterData.rs5.next(); assts.add(compForm)) {
				
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs5.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs5.getString(2));
					compForm.setAssetCode(complaintMasterData.rs5.getString(3));
					compForm.setAssetName(complaintMasterData.rs5.getString(4));
					compForm.setDateCreation(complaintMasterData.rs5.getString(5));
					compForm.setName("GLBR");
					compForm.setCompCode("18");
					compForm.setAstCmpt("component");
				}

				String query6 = "select distinct a.GLSR_CODE,nvl(a.GLSR_LOC,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_GLSR_SC_PARAM_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and  substr(a.GLSR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by GLSR_CODE";
				complaintMasterData.stmt6 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs6 = complaintMasterData.stmt6.executeQuery(query6);
				
				for (; complaintMasterData.rs6.next(); assts.add(compForm)) {
					
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs6.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs6.getString(2));
					compForm.setAssetCode(complaintMasterData.rs6.getString(3));
					compForm.setAssetName(complaintMasterData.rs6.getString(4));
					compForm.setDateCreation(complaintMasterData.rs6.getString(5));
					compForm.setName("GLSR");
					compForm.setCompCode("17");
					compForm.setAstCmpt("component");
				}

				String query7 = "select distinct a.OHSR_CODE,nvl(a.OHSR_LOC,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_OHSR_SC_PARAM_TBL    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  substr(a.OHSR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by OHSR_CODE";
				complaintMasterData.stmt7 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs7 = complaintMasterData.stmt7.executeQuery(query7);
				
				for (; complaintMasterData.rs7.next(); assts.add(compForm)) {
				
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs7.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs7.getString(2));
					compForm.setAssetCode(complaintMasterData.rs7.getString(3));
					compForm.setAssetName(complaintMasterData.rs7.getString(4));
					compForm.setDateCreation(complaintMasterData.rs7.getString(5));
					compForm.setName("OHSR");
					compForm.setCompCode("15");
					compForm.setAstCmpt("component");
				}

				String query8 = "select distinct a.OHBR_CODE,nvl(a.OHBR_LOC,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_OHBR_SC_PARAM_TBL    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.OHBR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "'  order by OHBR_CODE";
				complaintMasterData.stmt8 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs8 = complaintMasterData.stmt8.executeQuery(query8);
			
				for (; complaintMasterData.rs8.next(); assts.add(compForm)) {
			
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs8.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs8.getString(2));
					compForm.setAssetCode(complaintMasterData.rs8.getString(3));
					compForm.setAssetName(complaintMasterData.rs8.getString(4));
					compForm.setDateCreation(complaintMasterData.rs8.getString(5));
					compForm.setName("OHBR");
					compForm.setCompCode("16");
					compForm.setAstCmpt("component");
				}

				String query9 = "select distinct a.RW_COLLWELL_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_RW_COLLWELL_PARAM_TBL   a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.RW_COLLWELL_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by RW_COLLWELL_CODE";
				complaintMasterData.stmt9 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs9 = complaintMasterData.stmt9.executeQuery(query9);
				
				for (; complaintMasterData.rs9.next(); assts.add(compForm)) {
				
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs9.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs9.getString(2));
					compForm.setAssetCode(complaintMasterData.rs9.getString(3));
					compForm.setAssetName(complaintMasterData.rs9.getString(4));
					compForm.setDateCreation(complaintMasterData.rs9.getString(5));
					compForm.setName("Raw Water Collection Well");
					compForm.setCompCode("03");
					compForm.setAstCmpt("component");
				}

				String query10 = "select distinct a.SUMPCODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_SUMP_M_SC_PARAM_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where  s.asset_code=b.asset_code and r.panch_code=a.hab_code and  substr(a.SUMPCODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by SUMPCODE";
				complaintMasterData.stmt10 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs10 = complaintMasterData.stmt10.executeQuery(query10);
				
				for (; complaintMasterData.rs10.next(); assts.add(compForm)) {
				
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs10.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs10.getString(2));
					compForm.setAssetCode(complaintMasterData.rs10.getString(3));
					compForm.setAssetName(complaintMasterData.rs10.getString(4));
					compForm.setDateCreation(complaintMasterData.rs10.getString(5));
					compForm.setName("Sump");
					compForm.setCompCode("07");
					compForm.setAstCmpt("component");
				}

				String query11 = "select distinct a.OTHER_COMP_CODE ,nvl(a.COMP_LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_OTHERS_PARAM_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  substr(a.OTHER_COMP_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by OTHER_COMP_CODE";
				complaintMasterData.stmt11 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs11 = complaintMasterData.stmt11.executeQuery(query11);
				
				for (; complaintMasterData.rs11.next(); assts.add(compForm)) {
				
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs11.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs11.getString(2));
					compForm.setAssetCode(complaintMasterData.rs11.getString(3));
					compForm.setAssetName(complaintMasterData.rs11.getString(4));
					compForm.setDateCreation(complaintMasterData.rs11.getString(5));
					compForm.setName("Others");
					compForm.setCompCode("");
					compForm.setAstCmpt("component");
				}

				String query12 = "select distinct a.BRIDGE_CODE ,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_FP_BRIDGE_PARAM_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.BRIDGE_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by BRIDGE_CODE";
				complaintMasterData.stmt12 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs12 = complaintMasterData.stmt12.executeQuery(query12);
				
				for (; complaintMasterData.rs12.next(); assts.add(compForm)) {
				
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs12.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs12.getString(2));
					compForm.setAssetCode(complaintMasterData.rs12.getString(3));
					compForm.setAssetName(complaintMasterData.rs12.getString(4));
					compForm.setDateCreation(complaintMasterData.rs12.getString(5));
					compForm.setCompCode("");
					compForm.setName("Foot Path Bridge");
					compForm.setAstCmpt("component");
				}

				String query13 = "select distinct a.PUMP_CODE ,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_SUBCOMP_PARAM_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and  substr(a.PUMP_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by PUMP_CODE";
				complaintMasterData.stmt13 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs13 = complaintMasterData.stmt13.executeQuery(query13);
				
				for (; complaintMasterData.rs13.next(); assts.add(compForm)) {
				
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs13.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs13.getString(2));
					compForm.setAssetCode(complaintMasterData.rs13.getString(3));
					compForm.setAssetName(complaintMasterData.rs13.getString(4));
					compForm.setDateCreation(complaintMasterData.rs13.getString(5));
					compForm.setName("PumpSet");
					compForm.setCompCode("23");
					compForm.setAstCmpt("component");
				}

				String query14 = "select distinct a.PUMPHOUSE_CODE ,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_PUMPHOUSE_PARAM_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and  substr(a.PUMPHOUSE_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and   b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by PUMPHOUSE_CODE";
				complaintMasterData.stmt14 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs14 = complaintMasterData.stmt13.executeQuery(query14);
				
				for (; complaintMasterData.rs14.next(); assts.add(compForm)) {
				
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs14.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs14.getString(2));
					compForm.setAssetCode(complaintMasterData.rs14.getString(3));
					compForm.setAssetName(complaintMasterData.rs14.getString(4));
					compForm.setDateCreation(complaintMasterData.rs14.getString(5));
					compForm.setName("Pump House");
					compForm.setCompCode("08");
					compForm.setAstCmpt("component");
				}

				String query15 = "select distinct a.PUMPINGMAIN_CODE  ,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_PUMPINGMAIN_TBL                  a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where  s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  substr(a.PUMPINGMAIN_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by PUMPINGMAIN_CODE";
				complaintMasterData.stmt15 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs15 = complaintMasterData.stmt15.executeQuery(query15);
				
				for (; complaintMasterData.rs15.next(); assts.add(compForm)) {
					
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs15.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs15.getString(2));
					compForm.setAssetCode(complaintMasterData.rs15.getString(3));
					compForm.setAssetName(complaintMasterData.rs15.getString(4));
					compForm.setDateCreation(complaintMasterData.rs15.getString(5));
					compForm.setName("Pumping Main");
					compForm.setCompCode("12");
					compForm.setAstCmpt("component");
				}

				String query16 = "select distinct a.SSSC_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_SS_SC_PARAM_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and  substr(a.SSSC_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by SSSC_CODE";
				complaintMasterData.stmt16 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs16 = complaintMasterData.stmt16.executeQuery(query16);
				
				for (; complaintMasterData.rs16.next(); assts.add(compForm)) {
				
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs16.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs16.getString(2));
					compForm.setAssetCode(complaintMasterData.rs16.getString(3));
					compForm.setAssetName(complaintMasterData.rs16.getString(4));
					compForm.setDateCreation(complaintMasterData.rs16.getString(5));
					compForm.setName("SS Tank");
					compForm.setCompCode("04");
					compForm.setAstCmpt("component");
				}

				String query18 = "select distinct a.WTPSC_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_WTP_SC_PARAM_TBL   a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where  s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  substr(a.WTPSC_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code   and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by WTPSC_CODE";
				complaintMasterData.stmt18 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs18 = complaintMasterData.stmt18.executeQuery(query18);
				
				for (; complaintMasterData.rs18.next(); assts.add(compForm)) {
					
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs18.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs18.getString(2));
					compForm.setAssetCode(complaintMasterData.rs18.getString(3));
					compForm.setAssetName(complaintMasterData.rs18.getString(4));
					compForm.setDateCreation(complaintMasterData.rs18.getString(5));
					compForm.setName("---");
					compForm.setCompCode("");
					compForm.setAstCmpt("component");
				}

				String query19 = "select distinct a.GRAVITYMAIN_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_GRAVITYMAIN_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where  s.asset_code=b.asset_code and r.panch_code=a.hab_code and  substr(a.GRAVITYMAIN_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by GRAVITYMAIN_CODE";
				complaintMasterData.stmt19 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs19 = complaintMasterData.stmt19.executeQuery(query19);
				
				for (; complaintMasterData.rs19.next(); assts.add(compForm)) {
					
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs19.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs19.getString(2));
					compForm.setAssetCode(complaintMasterData.rs19.getString(3));
					compForm.setAssetName(complaintMasterData.rs19.getString(4));
					compForm.setDateCreation(complaintMasterData.rs19.getString(5));
					compForm.setName("Gravity Main");
					compForm.setCompCode("13");
					compForm.setAstCmpt("component");
				}

				String query20 = "select distinct a.SOURCE_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_SOURCE_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and  substr(a.SOURCE_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "'   order by SOURCE_CODE";
				complaintMasterData.stmt20 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs20 = complaintMasterData.stmt20.executeQuery(query20);
				
				for (; complaintMasterData.rs20.next(); assts.add(compForm)) {
					
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs20.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs20.getString(2));
					compForm.setAssetCode(complaintMasterData.rs20.getString(3));
					compForm.setAssetName(complaintMasterData.rs20.getString(4));
					compForm.setDateCreation(complaintMasterData.rs20.getString(5));
					compForm.setName("SOURCE");
					compForm.setCompCode("01");
					compForm.setAstCmpt("component");
				}

				String query22 = "select distinct a.WATCHMAN_CODE,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_WATCHMAN_PARAM_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  substr(a.WATCHMAN_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by WATCHMAN_CODE";
				complaintMasterData.stmt22 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs22 = complaintMasterData.stmt22.executeQuery(query22);
				
				for (; complaintMasterData.rs22.next(); assts.add(compForm)) {
					
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs22.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs22.getString(2));
					compForm.setAssetCode(complaintMasterData.rs22.getString(3));
					compForm.setAssetName(complaintMasterData.rs22.getString(4));
					compForm.setDateCreation(complaintMasterData.rs22.getString(5));
					compForm.setName("Watch Man");
					compForm.setCompCode("");
					compForm.setAstCmpt("component");
				}

				String query23 = "select distinct a.cl_code,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_chlorination_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  a.hab_code=substr(s.scheme_code,1,16) and b.asset_code=a.asset_code  and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by cl_code";
				complaintMasterData.stmt23 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs23 = complaintMasterData.stmt23.executeQuery(query23);
			
				for (; complaintMasterData.rs23.next(); assts.add(compForm)) {
					
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs23.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs23.getString(2));
					compForm.setAssetCode(complaintMasterData.rs23.getString(3));
					compForm.setAssetName(complaintMasterData.rs23.getString(4));
					compForm.setDateCreation(complaintMasterData.rs23.getString(5));
					compForm.setName("Chlorination");
					compForm.setCompCode("22");
					compForm.setAstCmpt("component");
				}

				String query24 = "select distinct nvl(oandmcode,'-'),nvl(b.LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_oandm_param_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=b.hab_code and  b.asset_code=a.asset_code and s.asset_code=a.asset_code and  b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' ";
				complaintMasterData.stmt24 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs24 = complaintMasterData.stmt24.executeQuery(query24);
				
				for (; complaintMasterData.rs24.next(); assts.add(compForm)) {
				
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs24.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs24.getString(2));
					compForm.setAssetCode(complaintMasterData.rs24.getString(3));
					compForm.setAssetName(complaintMasterData.rs24.getString(4));
					compForm.setDateCreation(complaintMasterData.rs24.getString(5));
					compForm.setName("O AND M");
					compForm.setCompCode("");
					compForm.setAstCmpt("component");
				}
				asst3.add(i++, assts);
			}

		} catch (Exception e) {
			Debug.println("The error in getassts***=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		assts2.add(0, asst3);
		assts2.add(1, assts1);
		return assts2;
	}

	public static ArrayList getAsstsast1(String Habcode, String asstcode, DataSource dataSource) throws Exception {
		ArrayList assts;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		
		complaintMasterData.conn = RwsOffices.getConn();
		CompForm compForm = null;
		
		String query1 = null;
		String query2 = null;
		String dist = null;
		String man = null;
		String pan = null;
		try {
			if (Habcode != null && !Habcode.equals("")) {
				dist = Habcode.substring(0, 2);
				
				man = Habcode.substring(5, 7);
				pan = Habcode.substring(12, 14);
				
			}
			
		} catch (Exception e) {
			Debug.println(" exception String" + e);
		}
		assts = new ArrayList();
		try {
			
			query1 = "select distinct a.cissc_code,a.cis_loc,b.asset_code,b.asset_name from rws_ast_cis_sc_param_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.cissc_code,1,2)='"
					+ dist + "' and substr(a.cissc_code,6,2)='" + man
					+ "' and  substr(a.cissc_code,1,16)=b.hab_code and b.asset_code=a.asset_code  and substr(a.cissc_code,13,2)='"
					+ pan + "' and b.type_of_asset_code='" + asstcode + "' order by cissc_code";
			complaintMasterData.stmt1 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs1 = complaintMasterData.stmt1.executeQuery(query1);
			
			for (; complaintMasterData.rs1.next(); assts.add(compForm)) {
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs1.getString(1));
				
				compForm.setAssetLocation(complaintMasterData.rs1.getString(2));
				
				compForm.setAssetCode(complaintMasterData.rs1.getString(3));
				
				compForm.setAssetName(complaintMasterData.rs1.getString(4));
				
			}

			query2 = "select distinct a.distrisc_code,nvl(a.location,'-'),b.asset_code,b.asset_name from rws_ast_distri_sc_param_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.distrisc_code,1,2)='"
					+ dist + "' and substr(a.distrisc_code,6,2)='" + man
					+ "' and  substr(a.distrisc_code,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(a.distrisc_code,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by distrisc_code";
			complaintMasterData.stmt2 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs2 = complaintMasterData.stmt2.executeQuery(query2);
			
			for (; complaintMasterData.rs2.next(); assts.add(compForm)) {
			
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs2.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs2.getString(2));
				compForm.setAssetCode(complaintMasterData.rs2.getString(3));
				compForm.setAssetName(complaintMasterData.rs2.getString(4));
			}

			String query3 = "select distinct a.BPT_CODE,nvl(a.location,'-'),b.asset_code,b.asset_name from RWS_ast_BPT_PARAM_TBL   a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.BPT_CODE,1,2)='"
					+ dist + "' and substr(a.BPT_CODE,6,2)='" + man
					+ "' and  substr(a.BPT_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and substr(a.BPT_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by BPT_CODE";
			complaintMasterData.stmt3 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs3 = complaintMasterData.stmt3.executeQuery(query3);
			
			for (; complaintMasterData.rs3.next(); assts.add(compForm)) {
			
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs3.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs3.getString(2));
				compForm.setAssetCode(complaintMasterData.rs3.getString(3));
				compForm.setAssetName(complaintMasterData.rs3.getString(4));
			}

			String query4 = "select distinct a.CW_COLLWELL_CODE,nvl(a.location,'-'),b.asset_code,b.asset_name from RWS_ast_CW_COLLWELL_PARAM_TBL     a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.CW_COLLWELL_CODE,1,2)='"
					+ dist + "' and substr(a.CW_COLLWELL_CODE,6,2)='" + man
					+ "' and  substr(a.CW_COLLWELL_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(a.CW_COLLWELL_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by CW_COLLWELL_CODE";
			complaintMasterData.stmt4 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs4 = complaintMasterData.stmt4.executeQuery(query4);
			
			for (; complaintMasterData.rs4.next(); assts.add(compForm)) {
			
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs4.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs4.getString(2));
				compForm.setAssetCode(complaintMasterData.rs4.getString(3));
				compForm.setAssetName(complaintMasterData.rs4.getString(4));
			}

			String query5 = "select distinct a.GLBR_CODE,nvl(a.GLBR_LOC,'-'),b.asset_code,b.asset_name from RWS_ast_GLBR_SC_PARAM_TBL    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.GLBR_CODE,1,2)='"
					+ dist + "' and substr(a.GLBR_CODE,6,2)='" + man
					+ "' and  substr(a.GLBR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.GLBR_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by GLBR_CODE";
			complaintMasterData.stmt5 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs5 = complaintMasterData.stmt5.executeQuery(query5);
			
			for (; complaintMasterData.rs5.next(); assts.add(compForm)) {
			
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs5.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs5.getString(2));
				compForm.setAssetCode(complaintMasterData.rs5.getString(3));
				compForm.setAssetName(complaintMasterData.rs5.getString(4));
			}

			String query6 = "select distinct a.GLSR_CODE,nvl(a.GLSR_LOC,'-'),b.asset_code,b.asset_name from RWS_ast_GLSR_SC_PARAM_TBL    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.GLSR_CODE,1,2)='"
					+ dist + "' and substr(a.GLSR_CODE,6,2)='" + man
					+ "' and  substr(a.GLSR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.GLSR_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by GLSR_CODE";
			complaintMasterData.stmt6 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs6 = complaintMasterData.stmt6.executeQuery(query6);
			
			for (; complaintMasterData.rs6.next(); assts.add(compForm)) {
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs6.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs6.getString(2));
				compForm.setAssetCode(complaintMasterData.rs6.getString(3));
				compForm.setAssetName(complaintMasterData.rs6.getString(4));
			}

			String query7 = "select distinct a.OHSR_CODE,nvl(a.OHSR_LOC,'-'),b.asset_code,b.asset_name from RWS_ast_OHSR_SC_PARAM_TBL    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.OHSR_CODE,1,2)='"
					+ dist + "' and substr(a.OHSR_CODE,6,2)='" + man
					+ "' and  substr(a.OHSR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.OHSR_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by OHSR_CODE";
			complaintMasterData.stmt7 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs7 = complaintMasterData.stmt7.executeQuery(query7);
			for (; complaintMasterData.rs7.next(); assts.add(compForm)) {
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs7.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs7.getString(2));
				compForm.setAssetCode(complaintMasterData.rs7.getString(3));
				compForm.setAssetName(complaintMasterData.rs7.getString(4));
			}

			String query8 = "select distinct a.OHBR_CODE,nvl(a.OHBR_LOC,'-'),b.asset_code,b.asset_name from RWS_ast_OHBR_SC_PARAM_TBL    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.OHBR_CODE,1,2)='"
					+ dist + "' and substr(a.OHBR_CODE,6,2)='" + man
					+ "' and  substr(a.OHBR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.OHBR_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by OHBR_CODE";
			complaintMasterData.stmt8 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs8 = complaintMasterData.stmt8.executeQuery(query8);
			for (; complaintMasterData.rs8.next(); assts.add(compForm)) {
			
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs8.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs8.getString(2));
				compForm.setAssetCode(complaintMasterData.rs8.getString(3));
				compForm.setAssetName(complaintMasterData.rs8.getString(4));
			}

			String query9 = "select distinct a.RW_COLLWELL_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_RW_COLLWELL_PARAM_TBL   a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.RW_COLLWELL_CODE,1,2)='"
					+ dist + "' and substr(a.RW_COLLWELL_CODE,6,2)='" + man
					+ "' and  substr(a.RW_COLLWELL_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and substr(a.RW_COLLWELL_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by RW_COLLWELL_CODE";
			complaintMasterData.stmt9 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs9 = complaintMasterData.stmt9.executeQuery(query9);
			
			for (; complaintMasterData.rs9.next(); assts.add(compForm)) {
			
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs9.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs9.getString(2));
				compForm.setAssetCode(complaintMasterData.rs9.getString(3));
				compForm.setAssetName(complaintMasterData.rs9.getString(4));
			}

			String query10 = "select distinct a.SUMPCODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_SUMP_M_SC_PARAM_TBL        a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where  s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.SUMPCODE,1,2)='"
					+ dist + "' and substr(a.SUMPCODE,6,2)='" + man
					+ "' and  substr(a.SUMPCODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.SUMPCODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by SUMPCODE";
			complaintMasterData.stmt10 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs10 = complaintMasterData.stmt10.executeQuery(query10);
			
			for (; complaintMasterData.rs10.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs10.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs10.getString(2));
				compForm.setAssetCode(complaintMasterData.rs10.getString(3));
				compForm.setAssetName(complaintMasterData.rs10.getString(4));
			}

			String query11 = "select distinct a.OTHER_COMP_CODE ,nvl(a.COMP_LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_OTHERS_PARAM_TBL          a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.OTHER_COMP_CODE,1,2)='"
					+ dist + "' and substr(a.OTHER_COMP_CODE,6,2)='" + man
					+ "' and  substr(a.OTHER_COMP_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.OTHER_COMP_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by OTHER_COMP_CODE";
			complaintMasterData.stmt11 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs11 = complaintMasterData.stmt11.executeQuery(query11);
			
			for (; complaintMasterData.rs11.next(); assts.add(compForm)) {
			
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs11.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs11.getString(2));
				compForm.setAssetCode(complaintMasterData.rs11.getString(3));
				compForm.setAssetName(complaintMasterData.rs11.getString(4));
			}

			String query12 = "select distinct a.BRIDGE_CODE ,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_FP_BRIDGE_PARAM_TBL            a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.BRIDGE_CODE,1,2)='"
					+ dist + "' and substr(a.BRIDGE_CODE,6,2)='" + man
					+ "' and  substr(a.BRIDGE_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and   substr(a.BRIDGE_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by BRIDGE_CODE";
			complaintMasterData.stmt12 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs12 = complaintMasterData.stmt12.executeQuery(query12);
			
			for (; complaintMasterData.rs12.next(); assts.add(compForm)) {
			
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs12.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs12.getString(2));
				compForm.setAssetCode(complaintMasterData.rs12.getString(3));
				compForm.setAssetName(complaintMasterData.rs12.getString(4));
			}

			String query13 = "select distinct a.PUMP_CODE ,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_SUBCOMP_PARAM_TBL              a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.PUMP_CODE,1,2)='"
					+ dist + "' and substr(a.PUMP_CODE,6,2)='" + man
					+ "' and  substr(a.PUMP_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.PUMP_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by PUMP_CODE";
			complaintMasterData.stmt13 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs13 = complaintMasterData.stmt13.executeQuery(query13);
			
			for (; complaintMasterData.rs13.next(); assts.add(compForm)) {
			
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs13.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs13.getString(2));
				compForm.setAssetCode(complaintMasterData.rs13.getString(3));
				compForm.setAssetName(complaintMasterData.rs13.getString(4));
			}

			String query14 = "select distinct a.PUMPHOUSE_CODE ,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_PUMPHOUSE_PARAM_TBL                a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.PUMPHOUSE_CODE,1,2)='"
					+ dist + "' and substr(a.PUMPHOUSE_CODE,6,2)='" + man
					+ "' and  substr(a.PUMPHOUSE_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.PUMPHOUSE_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by PUMPHOUSE_CODE";
			complaintMasterData.stmt14 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs14 = complaintMasterData.stmt13.executeQuery(query14);
			
			for (; complaintMasterData.rs14.next(); assts.add(compForm)) {
			
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs14.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs14.getString(2));
				compForm.setAssetCode(complaintMasterData.rs14.getString(3));
				compForm.setAssetName(complaintMasterData.rs14.getString(4));
			}

			String query15 = "select distinct a.PUMPINGMAIN_CODE  ,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_PUMPINGMAIN_TBL                  a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where  s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.PUMPINGMAIN_CODE,1,2)='"
					+ dist + "' and substr(a.PUMPINGMAIN_CODE,6,2)='" + man
					+ "' and  substr(a.PUMPINGMAIN_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(a.PUMPINGMAIN_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by PUMPINGMAIN_CODE";
			complaintMasterData.stmt15 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs15 = complaintMasterData.stmt15.executeQuery(query15);
			
			for (; complaintMasterData.rs15.next(); assts.add(compForm)) {
			
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs15.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs15.getString(2));
				compForm.setAssetCode(complaintMasterData.rs15.getString(3));
				compForm.setAssetName(complaintMasterData.rs15.getString(4));
			}

			String query16 = "select distinct a.SSSC_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_SS_SC_PARAM_TBL                  a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.SSSC_CODE,1,2)='"
					+ dist + "' and substr(a.SSSC_CODE,6,2)='" + man
					+ "' and  substr(a.SSSC_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.SSSC_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by SSSC_CODE";
			complaintMasterData.stmt16 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs16 = complaintMasterData.stmt16.executeQuery(query16);
			
			for (; complaintMasterData.rs16.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs16.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs16.getString(2));
				compForm.setAssetCode(complaintMasterData.rs16.getString(3));
				compForm.setAssetName(complaintMasterData.rs16.getString(4));
			}

			String query18 = "select distinct a.WTPSC_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_WTP_SC_PARAM_TBL                    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where  s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.WTPSC_CODE,1,2)='"
					+ dist + "' and substr(a.WTPSC_CODE,6,2)='" + man
					+ "' and  substr(a.WTPSC_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and substr(a.WTPSC_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by WTPSC_CODE";
			complaintMasterData.stmt18 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs18 = complaintMasterData.stmt18.executeQuery(query18);
			
			for (; complaintMasterData.rs18.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs18.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs18.getString(2));
				compForm.setAssetCode(complaintMasterData.rs18.getString(3));
				compForm.setAssetName(complaintMasterData.rs18.getString(4));
			}

			String query19 = "select distinct a.GRAVITYMAIN_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_GRAVITYMAIN_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where  s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.GRAVITYMAIN_CODE,1,2)='"
					+ dist + "' and substr(a.GRAVITYMAIN_CODE,6,2)='" + man
					+ "' and  substr(a.GRAVITYMAIN_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and substr(a.GRAVITYMAIN_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by GRAVITYMAIN_CODE";
			complaintMasterData.stmt19 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs19 = complaintMasterData.stmt19.executeQuery(query19);
			
			for (; complaintMasterData.rs19.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs19.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs19.getString(2));
				compForm.setAssetCode(complaintMasterData.rs19.getString(3));
				compForm.setAssetName(complaintMasterData.rs19.getString(4));
			}

			String query20 = "select distinct a.SOURCE_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_SOURCE_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.SOURCE_CODE,1,2)='"
					+ dist + "' and substr(a.SOURCE_CODE,6,2)='" + man
					+ "' and  substr(a.SOURCE_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and substr(a.SOURCE_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "'   order by SOURCE_CODE";
			complaintMasterData.stmt20 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs20 = complaintMasterData.stmt20.executeQuery(query20);
			
			for (; complaintMasterData.rs20.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs20.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs20.getString(2));
				compForm.setAssetCode(complaintMasterData.rs20.getString(3));
				compForm.setAssetName(complaintMasterData.rs20.getString(4));
			}

			String query21 = "select distinct a.PUMPDET_CODE,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_PUMP_DET_SC_PARAM_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=substr(a.pumpdet_code,1,16) and  substr(a.PUMPDET_CODE,1,2)='"
					+ dist + "' and substr(a.PUMPDET_CODE,6,2)='" + man
					+ "' and  substr(a.PUMPDET_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.PUMPDET_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "'   order by PUMPDET_CODE";
			complaintMasterData.stmt21 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs21 = complaintMasterData.stmt21.executeQuery(query21);
			
			for (; complaintMasterData.rs21.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs21.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs21.getString(2));
				compForm.setAssetCode(complaintMasterData.rs21.getString(3));
				compForm.setAssetName(complaintMasterData.rs21.getString(4));
			}

			String query22 = "select distinct a.WATCHMAN_CODE,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_WATCHMAN_PARAM_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and  substr(a.WATCHMAN_CODE,1,2)='"
					+ dist + "' and substr(a.WATCHMAN_CODE,6,2)='" + man
					+ "' and  substr(a.WATCHMAN_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and substr(a.WATCHMAN_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "'   order by WATCHMAN_CODE";
			complaintMasterData.stmt22 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs22 = complaintMasterData.stmt22.executeQuery(query22);
			
			for (; complaintMasterData.rs22.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs22.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs22.getString(2));
				compForm.setAssetCode(complaintMasterData.rs22.getString(3));
				compForm.setAssetName(complaintMasterData.rs22.getString(4));
			}

			String query23 = "select distinct a.cl_code,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_chlorination_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  a.hab_code=substr(s.scheme_code,1,16) and b.asset_code=a.asset_code    and b.type_of_asset_code='"
					+ asstcode + "' and substr(a.cl_code,1,2)='" + dist + "' and substr(a.cl_code,6,2)='" + man
					+ "' and substr(a.cl_code,13,2)='" + pan + "'  and a.hab_code='" + Habcode + "'  order by cl_code";
			complaintMasterData.stmt23 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs23 = complaintMasterData.stmt23.executeQuery(query23);
			for (; complaintMasterData.rs23.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs23.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs23.getString(2));
				compForm.setAssetCode(complaintMasterData.rs23.getString(3));
				compForm.setAssetName(complaintMasterData.rs23.getString(4));
			}

			String query24 = "select distinct nvl(oandmcode,'-'),nvl(b.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_oandm_param_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=b.hab_code and  b.asset_code=a.asset_code and s.asset_code=a.asset_code and      b.type_of_asset_code='"
					+ asstcode + "' and substr(b.hab_code,1,2)='" + dist + "' and substr(b.hab_code,6,2)='" + man
					+ "' and substr(b.hab_code,13,2)='" + pan + "'   ";
			complaintMasterData.stmt24 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs24 = complaintMasterData.stmt24.executeQuery(query24);
			for (; complaintMasterData.rs24.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs24.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs24.getString(2));
				compForm.setAssetCode(complaintMasterData.rs24.getString(3));
				compForm.setAssetName(complaintMasterData.rs24.getString(4));
			}

		} catch (Exception e) {
			Debug.println("The error in getassts***=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return assts;
	}

	//
	// code modified by sridhar
	public static ArrayList getAsstsastss(String Habcode, String asstcode, DataSource dataSource) throws Exception {
		ArrayList assts, assts1, assts2, asst3;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		complaintMasterData.conn = RwsOffices.getConn();
		CompForm compForm1 = null;
		CompForm compForm = null;
		
		String query1 = null;
		String query2 = null;
		assts1 = new ArrayList();
		assts2 = new ArrayList();
		asst3 = new ArrayList();
		try {
			
			String qry = "Select asset_name,nvl(location,'-'),to_char(date_creation,'dd/mm/yyyy'),asset_Code from rws_asset_mast_tbl where  type_of_asset_code='"
					+ asstcode + "'";

			if (Habcode != null && !Habcode.equals("")) {
				qry += " and hab_code='" + Habcode + "' ";
			}
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			int i = 0;
			for (complaintMasterData.rs = complaintMasterData.stmt.executeQuery(qry); complaintMasterData.rs.next();) {
				assts = new ArrayList();
				compForm1 = new CompForm();
				compForm1.setAssetName(complaintMasterData.rs.getString(1));
				compForm1.setAssetLocation(complaintMasterData.rs.getString(2));
				compForm1.setDateCreation(complaintMasterData.rs.getString(3));
				compForm1.setAssetCode(complaintMasterData.rs.getString(4));
				compForm1.setAstCmpt("asset");
				assts1.add(compForm1);
				query1 = "select distinct a.cissc_code,a.cis_loc,b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from rws_ast_cis_sc_param_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and  substr(a.cissc_code,1,16)=b.hab_code and b.asset_code=a.asset_code   and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by cissc_code";
				complaintMasterData.stmt1 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs1 = complaintMasterData.stmt1.executeQuery(query1);
				for (; complaintMasterData.rs1.next(); assts.add(compForm)) {
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs1.getString(1));
					
					compForm.setAssetLocation(complaintMasterData.rs1.getString(2));
					
					compForm.setAssetCode(complaintMasterData.rs1.getString(3));
					
					compForm.setAssetName(complaintMasterData.rs1.getString(4));
					
					compForm.setDateCreation(complaintMasterData.rs1.getString(5));
					compForm.setName("Cisterns");
					compForm.setAstCmpt("component");
					compForm.setCompCode("20");
				}

				query2 = "select distinct a.distrisc_code,nvl(a.location,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from rws_ast_distri_sc_param_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.distrisc_code,1,16)=b.hab_code and b.asset_code=a.asset_code  and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by distrisc_code";
				complaintMasterData.stmt2 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs2 = complaintMasterData.stmt2.executeQuery(query2);
				
				for (; complaintMasterData.rs2.next(); assts.add(compForm)) {
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs2.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs2.getString(2));
					compForm.setAssetCode(complaintMasterData.rs2.getString(3));
					compForm.setAssetName(complaintMasterData.rs2.getString(4));
					compForm.setDateCreation(complaintMasterData.rs2.getString(5));
					compForm.setName("Distribution");
					compForm.setAstCmpt("component");
					compForm.setCompCode("14");
				}

				String query3 = "select distinct a.BPT_CODE,nvl(a.location,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_BPT_PARAM_TBL   a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and  substr(a.BPT_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by BPT_CODE";
				complaintMasterData.stmt3 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs3 = complaintMasterData.stmt3.executeQuery(query3);
				
				for (; complaintMasterData.rs3.next(); assts.add(compForm)) {
					
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs3.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs3.getString(2));
					compForm.setAssetCode(complaintMasterData.rs3.getString(3));
					compForm.setAssetName(complaintMasterData.rs3.getString(4));
					compForm.setDateCreation(complaintMasterData.rs3.getString(5));
					compForm.setName("Bpt");
					compForm.setCompCode("19");
					compForm.setAstCmpt("component");
				}

				String query4 = "select distinct a.CW_COLLWELL_CODE,nvl(a.location,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_CW_COLLWELL_PARAM_TBL     a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  substr(a.CW_COLLWELL_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "'  order by CW_COLLWELL_CODE";
				complaintMasterData.stmt4 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs4 = complaintMasterData.stmt4.executeQuery(query4);
				
				for (; complaintMasterData.rs4.next(); assts.add(compForm)) {
					
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs4.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs4.getString(2));
					compForm.setAssetCode(complaintMasterData.rs4.getString(3));
					compForm.setAssetName(complaintMasterData.rs4.getString(4));
					compForm.setDateCreation(complaintMasterData.rs4.getString(5));
					compForm.setName("Clear Water Collection Well");
					compForm.setCompCode("09");
					compForm.setAstCmpt("component");
				}

				String query5 = "select distinct a.GLBR_CODE,nvl(a.GLBR_LOC,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_GLBR_SC_PARAM_TBL    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  substr(a.GLBR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by GLBR_CODE";
				complaintMasterData.stmt5 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs5 = complaintMasterData.stmt5.executeQuery(query5);
				
				for (; complaintMasterData.rs5.next(); assts.add(compForm)) {
					
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs5.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs5.getString(2));
					compForm.setAssetCode(complaintMasterData.rs5.getString(3));
					compForm.setAssetName(complaintMasterData.rs5.getString(4));
					compForm.setDateCreation(complaintMasterData.rs5.getString(5));
					compForm.setName("GLBR");
					compForm.setCompCode("18");
					compForm.setAstCmpt("component");
				}

				String query6 = "select distinct a.GLSR_CODE,nvl(a.GLSR_LOC,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_GLSR_SC_PARAM_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and  substr(a.GLSR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by GLSR_CODE";
				complaintMasterData.stmt6 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs6 = complaintMasterData.stmt6.executeQuery(query6);
				
				for (; complaintMasterData.rs6.next(); assts.add(compForm)) {
					
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs6.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs6.getString(2));
					compForm.setAssetCode(complaintMasterData.rs6.getString(3));
					compForm.setAssetName(complaintMasterData.rs6.getString(4));
					compForm.setDateCreation(complaintMasterData.rs6.getString(5));
					compForm.setName("GLSR");
					compForm.setCompCode("17");
					compForm.setAstCmpt("component");
				}

				String query7 = "select distinct a.OHSR_CODE,nvl(a.OHSR_LOC,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_OHSR_SC_PARAM_TBL    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  substr(a.OHSR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by OHSR_CODE";
				complaintMasterData.stmt7 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs7 = complaintMasterData.stmt7.executeQuery(query7);
				
				for (; complaintMasterData.rs7.next(); assts.add(compForm)) {
					
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs7.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs7.getString(2));
					compForm.setAssetCode(complaintMasterData.rs7.getString(3));
					compForm.setAssetName(complaintMasterData.rs7.getString(4));
					compForm.setDateCreation(complaintMasterData.rs7.getString(5));
					compForm.setName("OHSR");
					compForm.setCompCode("15");
					compForm.setAstCmpt("component");
				}

				String query8 = "select distinct a.OHBR_CODE,nvl(a.OHBR_LOC,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_OHBR_SC_PARAM_TBL    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.OHBR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "'  order by OHBR_CODE";
				complaintMasterData.stmt8 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs8 = complaintMasterData.stmt8.executeQuery(query8);
				
				for (; complaintMasterData.rs8.next(); assts.add(compForm)) {
					
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs8.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs8.getString(2));
					compForm.setAssetCode(complaintMasterData.rs8.getString(3));
					compForm.setAssetName(complaintMasterData.rs8.getString(4));
					compForm.setDateCreation(complaintMasterData.rs8.getString(5));
					compForm.setName("OHBR");
					compForm.setCompCode("16");
					compForm.setAstCmpt("component");
				}

				String query9 = "select distinct a.RW_COLLWELL_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_RW_COLLWELL_PARAM_TBL   a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.RW_COLLWELL_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by RW_COLLWELL_CODE";
				complaintMasterData.stmt9 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs9 = complaintMasterData.stmt9.executeQuery(query9);
				
				for (; complaintMasterData.rs9.next(); assts.add(compForm)) {
					
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs9.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs9.getString(2));
					compForm.setAssetCode(complaintMasterData.rs9.getString(3));
					compForm.setAssetName(complaintMasterData.rs9.getString(4));
					compForm.setDateCreation(complaintMasterData.rs9.getString(5));
					compForm.setName("Raw Water Collection Well");
					compForm.setCompCode("03");
					compForm.setAstCmpt("component");
				}

				String query10 = "select distinct a.SUMPCODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_SUMP_M_SC_PARAM_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where  s.asset_code=b.asset_code and r.panch_code=a.hab_code and  substr(a.SUMPCODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by SUMPCODE";
				complaintMasterData.stmt10 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs10 = complaintMasterData.stmt10.executeQuery(query10);
				
				for (; complaintMasterData.rs10.next(); assts.add(compForm)) {
					
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs10.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs10.getString(2));
					compForm.setAssetCode(complaintMasterData.rs10.getString(3));
					compForm.setAssetName(complaintMasterData.rs10.getString(4));
					compForm.setDateCreation(complaintMasterData.rs10.getString(5));
					compForm.setName("Sump");
					compForm.setCompCode("07");
					compForm.setAstCmpt("component");
				}

				String query11 = "select distinct a.OTHER_COMP_CODE ,nvl(a.COMP_LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_OTHERS_PARAM_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  substr(a.OTHER_COMP_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by OTHER_COMP_CODE";
				complaintMasterData.stmt11 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs11 = complaintMasterData.stmt11.executeQuery(query11);
				
				for (; complaintMasterData.rs11.next(); assts.add(compForm)) {
					
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs11.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs11.getString(2));
					compForm.setAssetCode(complaintMasterData.rs11.getString(3));
					compForm.setAssetName(complaintMasterData.rs11.getString(4));
					compForm.setDateCreation(complaintMasterData.rs11.getString(5));
					compForm.setName("Others");
					compForm.setCompCode("");
					compForm.setAstCmpt("component");
				}

				String query12 = "select distinct a.BRIDGE_CODE ,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_FP_BRIDGE_PARAM_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.BRIDGE_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by BRIDGE_CODE";
				complaintMasterData.stmt12 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs12 = complaintMasterData.stmt12.executeQuery(query12);
				
				for (; complaintMasterData.rs12.next(); assts.add(compForm)) {
					
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs12.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs12.getString(2));
					compForm.setAssetCode(complaintMasterData.rs12.getString(3));
					compForm.setAssetName(complaintMasterData.rs12.getString(4));
					compForm.setDateCreation(complaintMasterData.rs12.getString(5));
					compForm.setCompCode("");
					compForm.setName("Foot Path Bridge");
					compForm.setAstCmpt("component");
				}

				String query13 = "select distinct a.PUMP_CODE ,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_SUBCOMP_PARAM_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and  substr(a.PUMP_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by PUMP_CODE";
				complaintMasterData.stmt13 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs13 = complaintMasterData.stmt13.executeQuery(query13);
				
				for (; complaintMasterData.rs13.next(); assts.add(compForm)) {
					
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs13.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs13.getString(2));
					compForm.setAssetCode(complaintMasterData.rs13.getString(3));
					compForm.setAssetName(complaintMasterData.rs13.getString(4));
					compForm.setDateCreation(complaintMasterData.rs13.getString(5));
					compForm.setName("PumpSet");
					compForm.setCompCode("23");
					compForm.setAstCmpt("component");
				}

				String query14 = "select distinct a.PUMPHOUSE_CODE ,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_PUMPHOUSE_PARAM_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and  substr(a.PUMPHOUSE_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and   b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by PUMPHOUSE_CODE";
				complaintMasterData.stmt14 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs14 = complaintMasterData.stmt13.executeQuery(query14);
				
				for (; complaintMasterData.rs14.next(); assts.add(compForm)) {
					
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs14.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs14.getString(2));
					compForm.setAssetCode(complaintMasterData.rs14.getString(3));
					compForm.setAssetName(complaintMasterData.rs14.getString(4));
					compForm.setDateCreation(complaintMasterData.rs14.getString(5));
					compForm.setName("Pump House");
					compForm.setCompCode("08");
					compForm.setAstCmpt("component");
				}

				String query15 = "select distinct a.PUMPINGMAIN_CODE  ,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_PUMPINGMAIN_TBL                  a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where  s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  substr(a.PUMPINGMAIN_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by PUMPINGMAIN_CODE";
				complaintMasterData.stmt15 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs15 = complaintMasterData.stmt15.executeQuery(query15);
				
				for (; complaintMasterData.rs15.next(); assts.add(compForm)) {
					
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs15.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs15.getString(2));
					compForm.setAssetCode(complaintMasterData.rs15.getString(3));
					compForm.setAssetName(complaintMasterData.rs15.getString(4));
					compForm.setDateCreation(complaintMasterData.rs15.getString(5));
					compForm.setName("Pumping Main");
					compForm.setCompCode("12");
					compForm.setAstCmpt("component");
				}

				String query16 = "select distinct a.SSSC_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_SS_SC_PARAM_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and  substr(a.SSSC_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by SSSC_CODE";
				complaintMasterData.stmt16 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs16 = complaintMasterData.stmt16.executeQuery(query16);
				
				for (; complaintMasterData.rs16.next(); assts.add(compForm)) {
					
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs16.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs16.getString(2));
					compForm.setAssetCode(complaintMasterData.rs16.getString(3));
					compForm.setAssetName(complaintMasterData.rs16.getString(4));
					compForm.setDateCreation(complaintMasterData.rs16.getString(5));
					compForm.setName("SS Tank");
					compForm.setCompCode("04");
					compForm.setAstCmpt("component");
				}

				String query18 = "select distinct a.WTPSC_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_WTP_SC_PARAM_TBL   a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where  s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  substr(a.WTPSC_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code   and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by WTPSC_CODE";
				complaintMasterData.stmt18 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs18 = complaintMasterData.stmt18.executeQuery(query18);
				
				for (; complaintMasterData.rs18.next(); assts.add(compForm)) {
					
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs18.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs18.getString(2));
					compForm.setAssetCode(complaintMasterData.rs18.getString(3));
					compForm.setAssetName(complaintMasterData.rs18.getString(4));
					compForm.setDateCreation(complaintMasterData.rs18.getString(5));
					compForm.setName("---");
					compForm.setCompCode("");
					compForm.setAstCmpt("component");
				}

				String query19 = "select distinct a.GRAVITYMAIN_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_GRAVITYMAIN_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where  s.asset_code=b.asset_code and r.panch_code=a.hab_code and  substr(a.GRAVITYMAIN_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by GRAVITYMAIN_CODE";
				complaintMasterData.stmt19 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs19 = complaintMasterData.stmt19.executeQuery(query19);
				
				for (; complaintMasterData.rs19.next(); assts.add(compForm)) {
					
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs19.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs19.getString(2));
					compForm.setAssetCode(complaintMasterData.rs19.getString(3));
					compForm.setAssetName(complaintMasterData.rs19.getString(4));
					compForm.setDateCreation(complaintMasterData.rs19.getString(5));
					compForm.setName("Gravity Main");
					compForm.setCompCode("13");
					compForm.setAstCmpt("component");
				}

				String query20 = "select distinct a.SOURCE_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_SOURCE_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and  substr(a.SOURCE_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "'   order by SOURCE_CODE";
				complaintMasterData.stmt20 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs20 = complaintMasterData.stmt20.executeQuery(query20);
				
				for (; complaintMasterData.rs20.next(); assts.add(compForm)) {
					
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs20.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs20.getString(2));
					compForm.setAssetCode(complaintMasterData.rs20.getString(3));
					compForm.setAssetName(complaintMasterData.rs20.getString(4));
					compForm.setDateCreation(complaintMasterData.rs20.getString(5));
					compForm.setName("SOURCE");
					compForm.setCompCode("01");
					compForm.setAstCmpt("component");
				}

				String query22 = "select distinct a.WATCHMAN_CODE,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_WATCHMAN_PARAM_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  substr(a.WATCHMAN_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by WATCHMAN_CODE";
				complaintMasterData.stmt22 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs22 = complaintMasterData.stmt22.executeQuery(query22);
				
				for (; complaintMasterData.rs22.next(); assts.add(compForm)) {
					
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs22.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs22.getString(2));
					compForm.setAssetCode(complaintMasterData.rs22.getString(3));
					compForm.setAssetName(complaintMasterData.rs22.getString(4));
					compForm.setDateCreation(complaintMasterData.rs22.getString(5));
					compForm.setName("Watch Man");
					compForm.setCompCode("");
					compForm.setAstCmpt("component");
				}

				String query23 = "select distinct a.cl_code,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_chlorination_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  a.hab_code=substr(s.scheme_code,1,16) and b.asset_code=a.asset_code  and b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' order by cl_code";
				complaintMasterData.stmt23 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs23 = complaintMasterData.stmt23.executeQuery(query23);
				for (; complaintMasterData.rs23.next(); assts.add(compForm)) {
					
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs23.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs23.getString(2));
					compForm.setAssetCode(complaintMasterData.rs23.getString(3));
					compForm.setAssetName(complaintMasterData.rs23.getString(4));
					compForm.setDateCreation(complaintMasterData.rs23.getString(5));
					compForm.setName("Chlorination");
					compForm.setCompCode("22");
					compForm.setAstCmpt("component");
				}

				String query24 = "select distinct nvl(oandmcode,'-'),nvl(b.LOCATION,'-'),b.asset_code,b.asset_name,to_char(b.date_creation,'dd/mm/yyyy') from RWS_ast_oandm_param_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=b.hab_code and  b.asset_code=a.asset_code and s.asset_code=a.asset_code and  b.asset_code='"
						+ complaintMasterData.rs.getString(4) + "' ";
				complaintMasterData.stmt24 = complaintMasterData.conn.createStatement();
				complaintMasterData.rs24 = complaintMasterData.stmt24.executeQuery(query24);
				
				for (; complaintMasterData.rs24.next(); assts.add(compForm)) {
					
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs24.getString(1));
					compForm.setAssetLocation(complaintMasterData.rs24.getString(2));
					compForm.setAssetCode(complaintMasterData.rs24.getString(3));
					compForm.setAssetName(complaintMasterData.rs24.getString(4));
					compForm.setDateCreation(complaintMasterData.rs24.getString(5));
					compForm.setName("O AND M");
					compForm.setCompCode("");
					compForm.setAstCmpt("component");
				}
				asst3.add(i++, assts);
			}

		} catch (Exception e) {
			Debug.println("The error in getassts***=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		assts2.add(0, asst3);
		assts2.add(1, assts1);
		return assts2;
	}

	public static ArrayList getAsstsast(String Habcode, String asstcode, DataSource dataSource) throws Exception {
		ArrayList assts;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		complaintMasterData.conn = RwsOffices.getConn();
		CompForm compForm = null;
		
		String query1 = null;
		String query2 = null;
		String dist = null;
		String man = null;
		String pan = null;
		try {
			if (Habcode != null && !Habcode.equals("")) {
				dist = Habcode.substring(0, 2);
				
				man = Habcode.substring(5, 7);
				pan = Habcode.substring(12, 14);
				
			}
		} catch (Exception e) {
			Debug.println(" exception String" + e);
		}
		assts = new ArrayList();
		try {
			
			query1 = "select distinct a.cissc_code,a.cis_loc,b.asset_code,b.asset_name from rws_ast_cis_sc_param_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.cissc_code,1,2)='"
					+ dist + "' and substr(a.cissc_code,6,2)='" + man
					+ "' and  substr(a.cissc_code,1,16)=b.hab_code and b.asset_code=a.asset_code  and substr(a.cissc_code,13,2)='"
					+ pan + "' and b.type_of_asset_code='" + asstcode + "' order by cissc_code";
			complaintMasterData.stmt1 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs1 = complaintMasterData.stmt1.executeQuery(query1);
			for (; complaintMasterData.rs1.next(); assts.add(compForm)) {
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs1.getString(1));
				
				compForm.setAssetLocation(complaintMasterData.rs1.getString(2));
				
				compForm.setAssetCode(complaintMasterData.rs1.getString(3));
				
				compForm.setAssetName(complaintMasterData.rs1.getString(4));
				
			}

			query2 = "select distinct a.distrisc_code,nvl(a.location,'-'),b.asset_code,b.asset_name from rws_ast_distri_sc_param_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.distrisc_code,1,2)='"
					+ dist + "' and substr(a.distrisc_code,6,2)='" + man
					+ "' and  substr(a.distrisc_code,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(a.distrisc_code,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by distrisc_code";
			complaintMasterData.stmt2 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs2 = complaintMasterData.stmt2.executeQuery(query2);
			
			for (; complaintMasterData.rs2.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs2.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs2.getString(2));
				compForm.setAssetCode(complaintMasterData.rs2.getString(3));
				compForm.setAssetName(complaintMasterData.rs2.getString(4));
			}

			String query3 = "select distinct a.BPT_CODE,nvl(a.location,'-'),b.asset_code,b.asset_name from RWS_ast_BPT_PARAM_TBL   a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.BPT_CODE,1,2)='"
					+ dist + "' and substr(a.BPT_CODE,6,2)='" + man
					+ "' and  substr(a.BPT_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and substr(a.BPT_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by BPT_CODE";
			complaintMasterData.stmt3 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs3 = complaintMasterData.stmt3.executeQuery(query3);
			
			for (; complaintMasterData.rs3.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs3.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs3.getString(2));
				compForm.setAssetCode(complaintMasterData.rs3.getString(3));
				compForm.setAssetName(complaintMasterData.rs3.getString(4));
			}

			String query4 = "select distinct a.CW_COLLWELL_CODE,nvl(a.location,'-'),b.asset_code,b.asset_name from RWS_ast_CW_COLLWELL_PARAM_TBL     a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.CW_COLLWELL_CODE,1,2)='"
					+ dist + "' and substr(a.CW_COLLWELL_CODE,6,2)='" + man
					+ "' and  substr(a.CW_COLLWELL_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(a.CW_COLLWELL_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by CW_COLLWELL_CODE";
			complaintMasterData.stmt4 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs4 = complaintMasterData.stmt4.executeQuery(query4);
			
			for (; complaintMasterData.rs4.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs4.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs4.getString(2));
				compForm.setAssetCode(complaintMasterData.rs4.getString(3));
				compForm.setAssetName(complaintMasterData.rs4.getString(4));
			}

			String query5 = "select distinct a.GLBR_CODE,nvl(a.GLBR_LOC,'-'),b.asset_code,b.asset_name from RWS_ast_GLBR_SC_PARAM_TBL    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.GLBR_CODE,1,2)='"
					+ dist + "' and substr(a.GLBR_CODE,6,2)='" + man
					+ "' and  substr(a.GLBR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.GLBR_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by GLBR_CODE";
			complaintMasterData.stmt5 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs5 = complaintMasterData.stmt5.executeQuery(query5);
			
			for (; complaintMasterData.rs5.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs5.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs5.getString(2));
				compForm.setAssetCode(complaintMasterData.rs5.getString(3));
				compForm.setAssetName(complaintMasterData.rs5.getString(4));
			}

			String query6 = "select distinct a.GLSR_CODE,nvl(a.GLSR_LOC,'-'),b.asset_code,b.asset_name from RWS_ast_GLSR_SC_PARAM_TBL    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.GLSR_CODE,1,2)='"
					+ dist + "' and substr(a.GLSR_CODE,6,2)='" + man
					+ "' and  substr(a.GLSR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.GLSR_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by GLSR_CODE";
			complaintMasterData.stmt6 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs6 = complaintMasterData.stmt6.executeQuery(query6);
			
			for (; complaintMasterData.rs6.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs6.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs6.getString(2));
				compForm.setAssetCode(complaintMasterData.rs6.getString(3));
				compForm.setAssetName(complaintMasterData.rs6.getString(4));
			}

			String query7 = "select distinct a.OHSR_CODE,nvl(a.OHSR_LOC,'-'),b.asset_code,b.asset_name from RWS_ast_OHSR_SC_PARAM_TBL    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.OHSR_CODE,1,2)='"
					+ dist + "' and substr(a.OHSR_CODE,6,2)='" + man
					+ "' and  substr(a.OHSR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.OHSR_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by OHSR_CODE";
			complaintMasterData.stmt7 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs7 = complaintMasterData.stmt7.executeQuery(query7);
			
			for (; complaintMasterData.rs7.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs7.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs7.getString(2));
				compForm.setAssetCode(complaintMasterData.rs7.getString(3));
				compForm.setAssetName(complaintMasterData.rs7.getString(4));
			}

			String query8 = "select distinct a.OHBR_CODE,nvl(a.OHBR_LOC,'-'),b.asset_code,b.asset_name from RWS_ast_OHBR_SC_PARAM_TBL    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.OHBR_CODE,1,2)='"
					+ dist + "' and substr(a.OHBR_CODE,6,2)='" + man
					+ "' and  substr(a.OHBR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.OHBR_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by OHBR_CODE";
			complaintMasterData.stmt8 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs8 = complaintMasterData.stmt8.executeQuery(query8);
			
			for (; complaintMasterData.rs8.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs8.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs8.getString(2));
				compForm.setAssetCode(complaintMasterData.rs8.getString(3));
				compForm.setAssetName(complaintMasterData.rs8.getString(4));
			}

			String query9 = "select distinct a.RW_COLLWELL_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_RW_COLLWELL_PARAM_TBL   a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.RW_COLLWELL_CODE,1,2)='"
					+ dist + "' and substr(a.RW_COLLWELL_CODE,6,2)='" + man
					+ "' and  substr(a.RW_COLLWELL_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and substr(a.RW_COLLWELL_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by RW_COLLWELL_CODE";
			complaintMasterData.stmt9 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs9 = complaintMasterData.stmt9.executeQuery(query9);
			
			for (; complaintMasterData.rs9.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs9.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs9.getString(2));
				compForm.setAssetCode(complaintMasterData.rs9.getString(3));
				compForm.setAssetName(complaintMasterData.rs9.getString(4));
			}

			String query10 = "select distinct a.SUMPCODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_SUMP_M_SC_PARAM_TBL        a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where  s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.SUMPCODE,1,2)='"
					+ dist + "' and substr(a.SUMPCODE,6,2)='" + man
					+ "' and  substr(a.SUMPCODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.SUMPCODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by SUMPCODE";
			complaintMasterData.stmt10 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs10 = complaintMasterData.stmt10.executeQuery(query10);
			
			for (; complaintMasterData.rs10.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs10.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs10.getString(2));
				compForm.setAssetCode(complaintMasterData.rs10.getString(3));
				compForm.setAssetName(complaintMasterData.rs10.getString(4));
			}

			String query11 = "select distinct a.OTHER_COMP_CODE ,nvl(a.COMP_LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_OTHERS_PARAM_TBL          a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.OTHER_COMP_CODE,1,2)='"
					+ dist + "' and substr(a.OTHER_COMP_CODE,6,2)='" + man
					+ "' and  substr(a.OTHER_COMP_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.OTHER_COMP_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by OTHER_COMP_CODE";
			complaintMasterData.stmt11 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs11 = complaintMasterData.stmt11.executeQuery(query11);
			
			for (; complaintMasterData.rs11.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs11.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs11.getString(2));
				compForm.setAssetCode(complaintMasterData.rs11.getString(3));
				compForm.setAssetName(complaintMasterData.rs11.getString(4));
			}

			String query12 = "select distinct a.BRIDGE_CODE ,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_FP_BRIDGE_PARAM_TBL            a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.BRIDGE_CODE,1,2)='"
					+ dist + "' and substr(a.BRIDGE_CODE,6,2)='" + man
					+ "' and  substr(a.BRIDGE_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and   substr(a.BRIDGE_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by BRIDGE_CODE";
			complaintMasterData.stmt12 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs12 = complaintMasterData.stmt12.executeQuery(query12);
			
			for (; complaintMasterData.rs12.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs12.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs12.getString(2));
				compForm.setAssetCode(complaintMasterData.rs12.getString(3));
				compForm.setAssetName(complaintMasterData.rs12.getString(4));
			}

			String query13 = "select distinct a.PUMP_CODE ,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_SUBCOMP_PARAM_TBL              a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.PUMP_CODE,1,2)='"
					+ dist + "' and substr(a.PUMP_CODE,6,2)='" + man
					+ "' and  substr(a.PUMP_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.PUMP_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by PUMP_CODE";
			complaintMasterData.stmt13 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs13 = complaintMasterData.stmt13.executeQuery(query13);
			
			for (; complaintMasterData.rs13.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs13.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs13.getString(2));
				compForm.setAssetCode(complaintMasterData.rs13.getString(3));
				compForm.setAssetName(complaintMasterData.rs13.getString(4));
			}

			String query14 = "select distinct a.PUMPHOUSE_CODE ,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_PUMPHOUSE_PARAM_TBL                a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.PUMPHOUSE_CODE,1,2)='"
					+ dist + "' and substr(a.PUMPHOUSE_CODE,6,2)='" + man
					+ "' and  substr(a.PUMPHOUSE_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.PUMPHOUSE_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by PUMPHOUSE_CODE";
			complaintMasterData.stmt14 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs14 = complaintMasterData.stmt13.executeQuery(query14);
			
			for (; complaintMasterData.rs14.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs14.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs14.getString(2));
				compForm.setAssetCode(complaintMasterData.rs14.getString(3));
				compForm.setAssetName(complaintMasterData.rs14.getString(4));
			}

			String query15 = "select distinct a.PUMPINGMAIN_CODE  ,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_PUMPINGMAIN_TBL                  a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where  s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.PUMPINGMAIN_CODE,1,2)='"
					+ dist + "' and substr(a.PUMPINGMAIN_CODE,6,2)='" + man
					+ "' and  substr(a.PUMPINGMAIN_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(a.PUMPINGMAIN_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by PUMPINGMAIN_CODE";
			complaintMasterData.stmt15 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs15 = complaintMasterData.stmt15.executeQuery(query15);
			
			for (; complaintMasterData.rs15.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs15.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs15.getString(2));
				compForm.setAssetCode(complaintMasterData.rs15.getString(3));
				compForm.setAssetName(complaintMasterData.rs15.getString(4));
			}

			String query16 = "select distinct a.SSSC_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_SS_SC_PARAM_TBL                  a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.SSSC_CODE,1,2)='"
					+ dist + "' and substr(a.SSSC_CODE,6,2)='" + man
					+ "' and  substr(a.SSSC_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.SSSC_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by SSSC_CODE";
			complaintMasterData.stmt16 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs16 = complaintMasterData.stmt16.executeQuery(query16);
			
			for (; complaintMasterData.rs16.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs16.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs16.getString(2));
				compForm.setAssetCode(complaintMasterData.rs16.getString(3));
				compForm.setAssetName(complaintMasterData.rs16.getString(4));
			}

			String query18 = "select distinct a.WTPSC_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_WTP_SC_PARAM_TBL                    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where  s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.WTPSC_CODE,1,2)='"
					+ dist + "' and substr(a.WTPSC_CODE,6,2)='" + man
					+ "' and  substr(a.WTPSC_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and substr(a.WTPSC_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by WTPSC_CODE";
			complaintMasterData.stmt18 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs18 = complaintMasterData.stmt18.executeQuery(query18);
			
			for (; complaintMasterData.rs18.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs18.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs18.getString(2));
				compForm.setAssetCode(complaintMasterData.rs18.getString(3));
				compForm.setAssetName(complaintMasterData.rs18.getString(4));
			}

			String query19 = "select distinct a.GRAVITYMAIN_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_GRAVITYMAIN_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where  s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.GRAVITYMAIN_CODE,1,2)='"
					+ dist + "' and substr(a.GRAVITYMAIN_CODE,6,2)='" + man
					+ "' and  substr(a.GRAVITYMAIN_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and substr(a.GRAVITYMAIN_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by GRAVITYMAIN_CODE";
			complaintMasterData.stmt19 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs19 = complaintMasterData.stmt19.executeQuery(query19);
			
			for (; complaintMasterData.rs19.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs19.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs19.getString(2));
				compForm.setAssetCode(complaintMasterData.rs19.getString(3));
				compForm.setAssetName(complaintMasterData.rs19.getString(4));
			}

			String query20 = "select distinct a.SOURCE_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_SOURCE_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.SOURCE_CODE,1,2)='"
					+ dist + "' and substr(a.SOURCE_CODE,6,2)='" + man
					+ "' and  substr(a.SOURCE_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and substr(a.SOURCE_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "'   order by SOURCE_CODE";
			complaintMasterData.stmt20 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs20 = complaintMasterData.stmt20.executeQuery(query20);
			
			for (; complaintMasterData.rs20.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs20.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs20.getString(2));
				compForm.setAssetCode(complaintMasterData.rs20.getString(3));
				compForm.setAssetName(complaintMasterData.rs20.getString(4));
			}

			String query21 = "select distinct a.PUMPDET_CODE,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_PUMP_DET_SC_PARAM_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=substr(a.pumpdet_code,1,16) and  substr(a.PUMPDET_CODE,1,2)='"
					+ dist + "' and substr(a.PUMPDET_CODE,6,2)='" + man
					+ "' and  substr(a.PUMPDET_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.PUMPDET_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "'   order by PUMPDET_CODE";
			complaintMasterData.stmt21 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs21 = complaintMasterData.stmt21.executeQuery(query21);
			
			for (; complaintMasterData.rs21.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs21.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs21.getString(2));
				compForm.setAssetCode(complaintMasterData.rs21.getString(3));
				compForm.setAssetName(complaintMasterData.rs21.getString(4));
			}

			String query22 = "select distinct a.WATCHMAN_CODE,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_WATCHMAN_PARAM_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and  substr(a.WATCHMAN_CODE,1,2)='"
					+ dist + "' and substr(a.WATCHMAN_CODE,6,2)='" + man
					+ "' and  substr(a.WATCHMAN_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and substr(a.WATCHMAN_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "'   order by WATCHMAN_CODE";
			complaintMasterData.stmt22 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs22 = complaintMasterData.stmt22.executeQuery(query22);
			
			for (; complaintMasterData.rs22.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs22.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs22.getString(2));
				compForm.setAssetCode(complaintMasterData.rs22.getString(3));
				compForm.setAssetName(complaintMasterData.rs22.getString(4));
			}

			String query23 = "select distinct a.cl_code,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_chlorination_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code  and  a.hab_code=substr(s.scheme_code,1,16) and b.asset_code=a.asset_code    and b.type_of_asset_code='"
					+ asstcode + "' and substr(a.cl_code,1,2)='" + dist + "' and substr(a.cl_code,6,2)='" + man
					+ "' and substr(a.cl_code,13,2)='" + pan + "'  and a.hab_code='" + Habcode + "'  order by cl_code";
			complaintMasterData.stmt23 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs23 = complaintMasterData.stmt23.executeQuery(query23);
			for (; complaintMasterData.rs23.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs23.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs23.getString(2));
				compForm.setAssetCode(complaintMasterData.rs23.getString(3));
				compForm.setAssetName(complaintMasterData.rs23.getString(4));
			}

			String query24 = "select distinct nvl(oandmcode,'-'),nvl(b.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_oandm_param_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=b.hab_code and  b.asset_code=a.asset_code and s.asset_code=a.asset_code and      b.type_of_asset_code='"
					+ asstcode + "' and substr(b.hab_code,1,2)='" + dist + "' and substr(b.hab_code,6,2)='" + man
					+ "' and substr(b.hab_code,13,2)='" + pan + "'   ";
			complaintMasterData.stmt24 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs24 = complaintMasterData.stmt24.executeQuery(query24);
			
			for (; complaintMasterData.rs24.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs24.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs24.getString(2));
				compForm.setAssetCode(complaintMasterData.rs24.getString(3));
				compForm.setAssetName(complaintMasterData.rs24.getString(4));
			}

		} catch (Exception e) {
			Debug.println("The error in getassts***=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return assts;
	}

	public static ArrayList getAsstsastd(String Habcode, String asstcode, DataSource dataSource) throws Exception {
		ArrayList assts;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		complaintMasterData.conn = RwsOffices.getConn();
		CompForm compForm = null;
		
		String query1 = null;
		String query2 = null;
		String dist = null;
		String man = null;
		String pan = null;
		try {
			if (Habcode != null && !Habcode.equals("")) {
				dist = Habcode.substring(0, 2);
				
				man = Habcode.substring(5, 7);
				pan = Habcode.substring(12, 14);
			}
		} catch (Exception e) {
			Debug.println(" exception String" + e);
		}
		assts = new ArrayList();
		try {
			
			query2 = "select distinct a.distrisc_code,nvl(a.location,'-'),b.asset_code,b.asset_name from rws_ast_distri_sc_param_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.distrisc_code,1,2)='"
					+ dist + "' and substr(a.distrisc_code,6,2)='" + man
					+ "' and  substr(a.distrisc_code,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(a.distrisc_code,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by distrisc_code";
			complaintMasterData.stmt2 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs2 = complaintMasterData.stmt2.executeQuery(query2);
			
			for (; complaintMasterData.rs2.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs2.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs2.getString(2));
				compForm.setAssetCode(complaintMasterData.rs2.getString(3));
				compForm.setAssetName(complaintMasterData.rs2.getString(4));
			}

			String query4 = "select distinct a.CW_COLLWELL_CODE,nvl(a.location,'-'),b.asset_code,b.asset_name from RWS_ast_CW_COLLWELL_PARAM_TBL     a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.CW_COLLWELL_CODE,1,2)='"
					+ dist + "' and substr(a.CW_COLLWELL_CODE,6,2)='" + man
					+ "' and  substr(a.CW_COLLWELL_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(a.CW_COLLWELL_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by CW_COLLWELL_CODE";
			complaintMasterData.stmt4 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs4 = complaintMasterData.stmt4.executeQuery(query4);
			
			for (; complaintMasterData.rs4.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs4.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs4.getString(2));
				compForm.setAssetCode(complaintMasterData.rs4.getString(3));
				compForm.setAssetName(complaintMasterData.rs4.getString(4));
			}

			String query9 = "select distinct a.RW_COLLWELL_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_RW_COLLWELL_PARAM_TBL   a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.RW_COLLWELL_CODE,1,2)='"
					+ dist + "' and substr(a.RW_COLLWELL_CODE,6,2)='" + man
					+ "' and  substr(a.RW_COLLWELL_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and substr(a.RW_COLLWELL_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by RW_COLLWELL_CODE";
			complaintMasterData.stmt9 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs9 = complaintMasterData.stmt9.executeQuery(query9);
			
			for (; complaintMasterData.rs9.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs9.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs9.getString(2));
				compForm.setAssetCode(complaintMasterData.rs9.getString(3));
				compForm.setAssetName(complaintMasterData.rs9.getString(4));
			}

			String query10 = "select distinct a.SUMPCODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_SUMP_M_SC_PARAM_TBL        a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where  s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.SUMPCODE,1,2)='"
					+ dist + "' and substr(a.SUMPCODE,6,2)='" + man
					+ "' and  substr(a.SUMPCODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.SUMPCODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by SUMPCODE";
			complaintMasterData.stmt10 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs10 = complaintMasterData.stmt10.executeQuery(query10);
			
			for (; complaintMasterData.rs10.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs10.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs10.getString(2));
				compForm.setAssetCode(complaintMasterData.rs10.getString(3));
				compForm.setAssetName(complaintMasterData.rs10.getString(4));
			}

			String query11 = "select distinct a.OTHER_COMP_CODE ,nvl(a.COMP_LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_OTHERS_PARAM_TBL          a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.OTHER_COMP_CODE,1,2)='"
					+ dist + "' and substr(a.OTHER_COMP_CODE,6,2)='" + man
					+ "' and  substr(a.OTHER_COMP_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.OTHER_COMP_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by OTHER_COMP_CODE";
			complaintMasterData.stmt11 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs11 = complaintMasterData.stmt11.executeQuery(query11);
			
			for (; complaintMasterData.rs11.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs11.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs11.getString(2));
				compForm.setAssetCode(complaintMasterData.rs11.getString(3));
				compForm.setAssetName(complaintMasterData.rs11.getString(4));
			}

			String query12 = "select distinct a.BRIDGE_CODE ,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_FP_BRIDGE_PARAM_TBL            a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.BRIDGE_CODE,1,2)='"
					+ dist + "' and substr(a.BRIDGE_CODE,6,2)='" + man
					+ "' and  substr(a.BRIDGE_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and   substr(a.BRIDGE_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by BRIDGE_CODE";
			complaintMasterData.stmt12 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs12 = complaintMasterData.stmt12.executeQuery(query12);
			
			for (; complaintMasterData.rs12.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs12.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs12.getString(2));
				compForm.setAssetCode(complaintMasterData.rs12.getString(3));
				compForm.setAssetName(complaintMasterData.rs12.getString(4));
			}

			String query13 = "select distinct a.PUMP_CODE ,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_SUBCOMP_PARAM_TBL              a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.PUMP_CODE,1,2)='"
					+ dist + "' and substr(a.PUMP_CODE,6,2)='" + man
					+ "' and  substr(a.PUMP_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.PUMP_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by PUMP_CODE";
			complaintMasterData.stmt13 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs13 = complaintMasterData.stmt13.executeQuery(query13);
			
			for (; complaintMasterData.rs13.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs13.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs13.getString(2));
				compForm.setAssetCode(complaintMasterData.rs13.getString(3));
				compForm.setAssetName(complaintMasterData.rs13.getString(4));
			}

			String query14 = "select distinct a.PUMPHOUSE_CODE ,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_PUMPHOUSE_PARAM_TBL                a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.PUMPHOUSE_CODE,1,2)='"
					+ dist + "' and substr(a.PUMPHOUSE_CODE,6,2)='" + man
					+ "' and  substr(a.PUMPHOUSE_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.PUMPHOUSE_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by PUMPHOUSE_CODE";
			complaintMasterData.stmt14 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs14 = complaintMasterData.stmt13.executeQuery(query14);
			
			for (; complaintMasterData.rs14.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs14.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs14.getString(2));
				compForm.setAssetCode(complaintMasterData.rs14.getString(3));
				compForm.setAssetName(complaintMasterData.rs14.getString(4));
			}

			String query15 = "select distinct a.PUMPINGMAIN_CODE  ,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_PUMPINGMAIN_TBL                  a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where  s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.PUMPINGMAIN_CODE,1,2)='"
					+ dist + "' and substr(a.PUMPINGMAIN_CODE,6,2)='" + man
					+ "' and  substr(a.PUMPINGMAIN_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(a.PUMPINGMAIN_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by PUMPINGMAIN_CODE";
			complaintMasterData.stmt15 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs15 = complaintMasterData.stmt15.executeQuery(query15);
			
			for (; complaintMasterData.rs15.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs15.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs15.getString(2));
				compForm.setAssetCode(complaintMasterData.rs15.getString(3));
				compForm.setAssetName(complaintMasterData.rs15.getString(4));
			}

			String query16 = "select distinct a.SSSC_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_SS_SC_PARAM_TBL                  a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.SSSC_CODE,1,2)='"
					+ dist + "' and substr(a.SSSC_CODE,6,2)='" + man
					+ "' and  substr(a.SSSC_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.SSSC_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by SSSC_CODE";
			complaintMasterData.stmt16 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs16 = complaintMasterData.stmt16.executeQuery(query16);
			
			for (; complaintMasterData.rs16.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs16.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs16.getString(2));
				compForm.setAssetCode(complaintMasterData.rs16.getString(3));
				compForm.setAssetName(complaintMasterData.rs16.getString(4));
			}

			String query18 = "select distinct a.WTPSC_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_WTP_SC_PARAM_TBL                    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where  s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.WTPSC_CODE,1,2)='"
					+ dist + "' and substr(a.WTPSC_CODE,6,2)='" + man
					+ "' and  substr(a.WTPSC_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and substr(a.WTPSC_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by WTPSC_CODE";
			complaintMasterData.stmt18 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs18 = complaintMasterData.stmt18.executeQuery(query18);
			
			for (; complaintMasterData.rs18.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs18.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs18.getString(2));
				compForm.setAssetCode(complaintMasterData.rs18.getString(3));
				compForm.setAssetName(complaintMasterData.rs18.getString(4));
			}

			String query19 = "select distinct a.GRAVITYMAIN_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_GRAVITYMAIN_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where  s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.GRAVITYMAIN_CODE,1,2)='"
					+ dist + "' and substr(a.GRAVITYMAIN_CODE,6,2)='" + man
					+ "' and  substr(a.GRAVITYMAIN_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and substr(a.GRAVITYMAIN_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by GRAVITYMAIN_CODE";
			complaintMasterData.stmt19 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs19 = complaintMasterData.stmt19.executeQuery(query19);
			
			for (; complaintMasterData.rs19.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs19.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs19.getString(2));
				compForm.setAssetCode(complaintMasterData.rs19.getString(3));
				compForm.setAssetName(complaintMasterData.rs19.getString(4));
			}

			String query20 = "select distinct a.SOURCE_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_SOURCE_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.SOURCE_CODE,1,2)='"
					+ dist + "' and substr(a.SOURCE_CODE,6,2)='" + man
					+ "' and  substr(a.SOURCE_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and substr(a.SOURCE_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "'   order by SOURCE_CODE";
			complaintMasterData.stmt20 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs20 = complaintMasterData.stmt20.executeQuery(query20);
			
			for (; complaintMasterData.rs20.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs20.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs20.getString(2));
				compForm.setAssetCode(complaintMasterData.rs20.getString(3));
				compForm.setAssetName(complaintMasterData.rs20.getString(4));
			}

			String query21 = "select distinct a.PUMPDET_CODE,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_PUMP_DET_SC_PARAM_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and  substr(a.PUMPDET_CODE,1,2)='"
					+ dist + "' and substr(a.PUMPDET_CODE,6,2)='" + man
					+ "' and  substr(a.PUMPDET_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.PUMPDET_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "'   order by PUMPDET_CODE";
			complaintMasterData.stmt21 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs21 = complaintMasterData.stmt21.executeQuery(query21);
			
			for (; complaintMasterData.rs21.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs21.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs21.getString(2));
				compForm.setAssetCode(complaintMasterData.rs21.getString(3));
				compForm.setAssetName(complaintMasterData.rs21.getString(4));
			}

			String query22 = "select distinct a.WATCHMAN_CODE,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_WATCHMAN_PARAM_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and  substr(a.WATCHMAN_CODE,1,2)='"
					+ dist + "' and substr(a.WATCHMAN_CODE,6,2)='" + man
					+ "' and  substr(a.WATCHMAN_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and substr(a.WATCHMAN_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "'   order by WATCHMAN_CODE";
			complaintMasterData.stmt22 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs22 = complaintMasterData.stmt22.executeQuery(query22);
			
			for (; complaintMasterData.rs22.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs22.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs22.getString(2));
				compForm.setAssetCode(complaintMasterData.rs22.getString(3));
				compForm.setAssetName(complaintMasterData.rs22.getString(4));
			}

		} catch (Exception e) {
			Debug.println("The error in getassts***=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return assts;
	}

	public static ArrayList getAsstsastnew(String Habcode, String asstcode, DataSource dataSource) throws Exception {
		ArrayList assts;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		complaintMasterData.closeAll();
		CompForm compForm = null;
		
		String query1 = null;
		String query2 = null;
		String dist = null;
		String man = null;
		String pan = null;
		try {
			if (Habcode != null && !Habcode.equals("")) {
				dist = Habcode.substring(0, 2);
				
				man = Habcode.substring(5, 7);
				pan = Habcode.substring(12, 14);
				
			}
			
		} catch (Exception e) {
			Debug.println(" exception String" + e);
		}
		assts = new ArrayList();
		try {
			
			compForm = new CompForm();
			query1 = "select distinct a.cissc_code,a.cis_loc,b.asset_code,b.asset_name from rws_ast_cis_sc_param_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.cissc_code,1,2)='"
					+ dist + "' and substr(a.cissc_code,6,2)='" + man
					+ "' and  substr(a.cissc_code,1,16)=b.hab_code and b.asset_code=a.asset_code  and substr(a.cissc_code,13,2)='"
					+ pan + "' and b.type_of_asset_code='" + asstcode + "' order by cissc_code";
			complaintMasterData.stmt1 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs1 = complaintMasterData.stmt1.executeQuery(query1);
			for (; complaintMasterData.rs1.next(); assts.add(compForm)) {
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs1.getString(1));
				
				compForm.setAssetLocation(complaintMasterData.rs1.getString(2));
				
				compForm.setAssetCode(complaintMasterData.rs1.getString(3));
				
				compForm.setAssetName(complaintMasterData.rs1.getString(4));
				
			}

			query2 = "select distinct a.distrisc_code,nvl(a.location,'-'),b.asset_code,b.asset_name from rws_ast_distri_sc_param_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.distrisc_code,1,2)='"
					+ dist + "' and substr(a.distrisc_code,6,2)='" + man
					+ "' and  substr(a.distrisc_code,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(a.distrisc_code,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by distrisc_code";
			complaintMasterData.stmt2 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs2 = complaintMasterData.stmt2.executeQuery(query2);
			
			for (; complaintMasterData.rs2.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs2.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs2.getString(2));
				compForm.setAssetCode(complaintMasterData.rs2.getString(3));
				compForm.setAssetName(complaintMasterData.rs2.getString(4));
			}

			String query3 = "select distinct a.BPT_CODE,nvl(a.location,'-'),b.asset_code,b.asset_name from RWS_ast_BPT_PARAM_TBL   a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.BPT_CODE,1,2)='"
					+ dist + "' and substr(a.BPT_CODE,6,2)='" + man
					+ "' and  substr(a.BPT_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and substr(a.BPT_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by BPT_CODE";
			complaintMasterData.stmt3 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs3 = complaintMasterData.stmt3.executeQuery(query3);
			
			for (; complaintMasterData.rs3.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs3.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs3.getString(2));
				compForm.setAssetCode(complaintMasterData.rs3.getString(3));
				compForm.setAssetName(complaintMasterData.rs3.getString(4));
			}

			String query4 = "select distinct a.CW_COLLWELL_CODE,nvl(a.location,'-'),b.asset_code,b.asset_name from RWS_ast_CW_COLLWELL_PARAM_TBL     a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.CW_COLLWELL_CODE,1,2)='"
					+ dist + "' and substr(a.CW_COLLWELL_CODE,6,2)='" + man
					+ "' and  substr(a.CW_COLLWELL_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(a.CW_COLLWELL_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by CW_COLLWELL_CODE";
			complaintMasterData.stmt4 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs4 = complaintMasterData.stmt4.executeQuery(query4);
			
			for (; complaintMasterData.rs4.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs4.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs4.getString(2));
				compForm.setAssetCode(complaintMasterData.rs4.getString(3));
				compForm.setAssetName(complaintMasterData.rs4.getString(4));
			}

			String query5 = "select distinct a.GLBR_CODE,nvl(a.GLBR_LOC,'-'),b.asset_code,b.asset_name from RWS_ast_GLBR_SC_PARAM_TBL    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.GLBR_CODE,1,2)='"
					+ dist + "' and substr(a.GLBR_CODE,6,2)='" + man
					+ "' and  substr(a.GLBR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.GLBR_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by GLBR_CODE";
			complaintMasterData.stmt5 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs5 = complaintMasterData.stmt5.executeQuery(query5);
			
			for (; complaintMasterData.rs5.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs5.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs5.getString(2));
				compForm.setAssetCode(complaintMasterData.rs5.getString(3));
				compForm.setAssetName(complaintMasterData.rs5.getString(4));
			}

			String query6 = "select distinct a.GLSR_CODE,nvl(a.GLSR_LOC,'-'),b.asset_code,b.asset_name from RWS_ast_GLSR_SC_PARAM_TBL    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.GLSR_CODE,1,2)='"
					+ dist + "' and substr(a.GLSR_CODE,6,2)='" + man
					+ "' and  substr(a.GLSR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.GLSR_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by GLSR_CODE";
			complaintMasterData.stmt6 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs6 = complaintMasterData.stmt6.executeQuery(query6);
			
			for (; complaintMasterData.rs6.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs6.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs6.getString(2));
				compForm.setAssetCode(complaintMasterData.rs6.getString(3));
				compForm.setAssetName(complaintMasterData.rs6.getString(4));
			}

			String query7 = "select distinct a.OHSR_CODE,nvl(a.OHSR_LOC,'-'),b.asset_code,b.asset_name from RWS_ast_OHSR_SC_PARAM_TBL    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.OHSR_CODE,1,2)='"
					+ dist + "' and substr(a.OHSR_CODE,6,2)='" + man
					+ "' and  substr(a.OHSR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.OHSR_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by OHSR_CODE";
			complaintMasterData.stmt7 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs7 = complaintMasterData.stmt7.executeQuery(query7);
			
			for (; complaintMasterData.rs7.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs7.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs7.getString(2));
				compForm.setAssetCode(complaintMasterData.rs7.getString(3));
				compForm.setAssetName(complaintMasterData.rs7.getString(4));
			}

			String query8 = "select distinct a.OHBR_CODE,nvl(a.OHBR_LOC,'-'),b.asset_code,b.asset_name from RWS_ast_OHBR_SC_PARAM_TBL    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.OHBR_CODE,1,2)='"
					+ dist + "' and substr(a.OHBR_CODE,6,2)='" + man
					+ "' and  substr(a.OHBR_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.OHBR_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by OHBR_CODE";
			complaintMasterData.stmt8 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs8 = complaintMasterData.stmt8.executeQuery(query8);
			
			for (; complaintMasterData.rs8.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs8.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs8.getString(2));
				compForm.setAssetCode(complaintMasterData.rs8.getString(3));
				compForm.setAssetName(complaintMasterData.rs8.getString(4));
			}

			String query9 = "select distinct a.RW_COLLWELL_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_RW_COLLWELL_PARAM_TBL   a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.RW_COLLWELL_CODE,1,2)='"
					+ dist + "' and substr(a.RW_COLLWELL_CODE,6,2)='" + man
					+ "' and  substr(a.RW_COLLWELL_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and substr(a.RW_COLLWELL_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by RW_COLLWELL_CODE";
			complaintMasterData.stmt9 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs9 = complaintMasterData.stmt9.executeQuery(query9);
			
			for (; complaintMasterData.rs9.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs9.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs9.getString(2));
				compForm.setAssetCode(complaintMasterData.rs9.getString(3));
				compForm.setAssetName(complaintMasterData.rs9.getString(4));
			}

			String query10 = "select distinct a.SUMPCODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_SUMP_M_SC_PARAM_TBL        a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where  s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.SUMPCODE,1,2)='"
					+ dist + "' and substr(a.SUMPCODE,6,2)='" + man
					+ "' and  substr(a.SUMPCODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.SUMPCODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by SUMPCODE";
			complaintMasterData.stmt10 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs10 = complaintMasterData.stmt10.executeQuery(query10);
			
			for (; complaintMasterData.rs10.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs10.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs10.getString(2));
				compForm.setAssetCode(complaintMasterData.rs10.getString(3));
				compForm.setAssetName(complaintMasterData.rs10.getString(4));
			}

			String query11 = "select distinct a.OTHER_COMP_CODE ,nvl(a.COMP_LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_OTHERS_PARAM_TBL          a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.OTHER_COMP_CODE,1,2)='"
					+ dist + "' and substr(a.OTHER_COMP_CODE,6,2)='" + man
					+ "' and  substr(a.OTHER_COMP_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.OTHER_COMP_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by OTHER_COMP_CODE";
			complaintMasterData.stmt11 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs11 = complaintMasterData.stmt11.executeQuery(query11);
			
			for (; complaintMasterData.rs11.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs11.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs11.getString(2));
				compForm.setAssetCode(complaintMasterData.rs11.getString(3));
				compForm.setAssetName(complaintMasterData.rs11.getString(4));
			}

			String query12 = "select distinct a.BRIDGE_CODE ,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_FP_BRIDGE_PARAM_TBL            a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.BRIDGE_CODE,1,2)='"
					+ dist + "' and substr(a.BRIDGE_CODE,6,2)='" + man
					+ "' and  substr(a.BRIDGE_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and   substr(a.BRIDGE_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by BRIDGE_CODE";
			complaintMasterData.stmt12 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs12 = complaintMasterData.stmt12.executeQuery(query12);
			
			for (; complaintMasterData.rs12.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs12.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs12.getString(2));
				compForm.setAssetCode(complaintMasterData.rs12.getString(3));
				compForm.setAssetName(complaintMasterData.rs12.getString(4));
			}

			String query13 = "select distinct a.PUMP_CODE ,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_SUBCOMP_PARAM_TBL              a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.PUMP_CODE,1,2)='"
					+ dist + "' and substr(a.PUMP_CODE,6,2)='" + man
					+ "' and  substr(a.PUMP_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.PUMP_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by PUMP_CODE";
			complaintMasterData.stmt13 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs13 = complaintMasterData.stmt13.executeQuery(query13);
			
			for (; complaintMasterData.rs13.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs13.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs13.getString(2));
				compForm.setAssetCode(complaintMasterData.rs13.getString(3));
				compForm.setAssetName(complaintMasterData.rs13.getString(4));
			}

			String query14 = "select distinct a.PUMPHOUSE_CODE ,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_PUMPHOUSE_PARAM_TBL                a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.PUMPHOUSE_CODE,1,2)='"
					+ dist + "' and substr(a.PUMPHOUSE_CODE,6,2)='" + man
					+ "' and  substr(a.PUMPHOUSE_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.PUMPHOUSE_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by PUMPHOUSE_CODE";
			complaintMasterData.stmt14 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs14 = complaintMasterData.stmt13.executeQuery(query14);
			
			for (; complaintMasterData.rs14.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs14.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs14.getString(2));
				compForm.setAssetCode(complaintMasterData.rs14.getString(3));
				compForm.setAssetName(complaintMasterData.rs14.getString(4));
			}

			String query15 = "select distinct a.PUMPINGMAIN_CODE  ,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_PUMPINGMAIN_TBL                  a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where  s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.PUMPINGMAIN_CODE,1,2)='"
					+ dist + "' and substr(a.PUMPINGMAIN_CODE,6,2)='" + man
					+ "' and  substr(a.PUMPINGMAIN_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and substr(a.PUMPINGMAIN_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by PUMPINGMAIN_CODE";
			complaintMasterData.stmt15 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs15 = complaintMasterData.stmt15.executeQuery(query15);
			
			for (; complaintMasterData.rs15.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs15.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs15.getString(2));
				compForm.setAssetCode(complaintMasterData.rs15.getString(3));
				compForm.setAssetName(complaintMasterData.rs15.getString(4));
			}

			String query16 = "select distinct a.SSSC_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_SS_SC_PARAM_TBL                  a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.SSSC_CODE,1,2)='"
					+ dist + "' and substr(a.SSSC_CODE,6,2)='" + man
					+ "' and  substr(a.SSSC_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.SSSC_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by SSSC_CODE";
			complaintMasterData.stmt16 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs16 = complaintMasterData.stmt16.executeQuery(query16);
			
			for (; complaintMasterData.rs16.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs16.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs16.getString(2));
				compForm.setAssetCode(complaintMasterData.rs16.getString(3));
				compForm.setAssetName(complaintMasterData.rs16.getString(4));
			}

			String query17 = "select distinct a.WTPSC_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_WTP_SC_PARAM_TBL                    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.WTPSC_CODE,1,2)='"
					+ dist + "' and substr(a.WTPSC_CODE,6,2)='" + man
					+ "' and  substr(a.WTPSC_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and substr(a.WTPSC_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by WTPSC_CODE";
			complaintMasterData.stmt17 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs17 = complaintMasterData.stmt17.executeQuery(query17);
			
			for (; complaintMasterData.rs17.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs17.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs17.getString(2));
				compForm.setAssetCode(complaintMasterData.rs17.getString(3));
				compForm.setAssetName(complaintMasterData.rs17.getString(4));
			}

			String query18 = "select distinct a.WTPSC_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_WTP_SC_PARAM_TBL                    a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where  s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.WTPSC_CODE,1,2)='"
					+ dist + "' and substr(a.WTPSC_CODE,6,2)='" + man
					+ "' and  substr(a.WTPSC_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and substr(a.WTPSC_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by WTPSC_CODE";
			complaintMasterData.stmt18 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs18 = complaintMasterData.stmt18.executeQuery(query18);
			
			for (; complaintMasterData.rs18.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs18.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs18.getString(2));
				compForm.setAssetCode(complaintMasterData.rs18.getString(3));
				compForm.setAssetName(complaintMasterData.rs18.getString(4));
			}

			String query19 = "select distinct a.GRAVITYMAIN_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_GRAVITYMAIN_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where  s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.GRAVITYMAIN_CODE,1,2)='"
					+ dist + "' and substr(a.GRAVITYMAIN_CODE,6,2)='" + man
					+ "' and  substr(a.GRAVITYMAIN_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and substr(a.GRAVITYMAIN_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "' order by GRAVITYMAIN_CODE";
			complaintMasterData.stmt19 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs19 = complaintMasterData.stmt19.executeQuery(query19);
			
			for (; complaintMasterData.rs19.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs19.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs19.getString(2));
				compForm.setAssetCode(complaintMasterData.rs19.getString(3));
				compForm.setAssetName(complaintMasterData.rs19.getString(4));
			}

			String query20 = "select distinct a.SOURCE_CODE,nvl(a.LOCATION,'-'),b.asset_code,b.asset_name from RWS_SOURCE_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and substr(a.SOURCE_CODE,1,2)='"
					+ dist + "' and substr(a.SOURCE_CODE,6,2)='" + man
					+ "' and  substr(a.SOURCE_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and substr(a.SOURCE_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "'   order by SOURCE_CODE";
			complaintMasterData.stmt20 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs20 = complaintMasterData.stmt20.executeQuery(query20);
			
			for (; complaintMasterData.rs20.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs20.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs20.getString(2));
				compForm.setAssetCode(complaintMasterData.rs20.getString(3));
				compForm.setAssetName(complaintMasterData.rs20.getString(4));
			}

			String query21 = "select distinct a.PUMPDET_CODE,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_PUMP_DET_SC_PARAM_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and  substr(a.PUMPDET_CODE,1,2)='"
					+ dist + "' and substr(a.PUMPDET_CODE,6,2)='" + man
					+ "' and  substr(a.PUMPDET_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code and  substr(a.PUMPDET_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "'   order by PUMPDET_CODE";
			complaintMasterData.stmt21 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs21 = complaintMasterData.stmt21.executeQuery(query21);
			
			for (; complaintMasterData.rs21.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs21.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs21.getString(2));
				compForm.setAssetCode(complaintMasterData.rs21.getString(3));
				compForm.setAssetName(complaintMasterData.rs21.getString(4));
			}

			String query22 = "select distinct a.WATCHMAN_CODE,nvl(b.LOCATION,'-'),b.asset_code,b.asset_name from RWS_ast_WATCHMAN_PARAM_TBL      a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and r.panch_code=a.hab_code and  substr(a.WATCHMAN_CODE,1,2)='"
					+ dist + "' and substr(a.WATCHMAN_CODE,6,2)='" + man
					+ "' and  substr(a.WATCHMAN_CODE,1,16)=b.hab_code and b.asset_code=a.asset_code  and substr(a.WATCHMAN_CODE,13,2)='"
					+ pan + "'  and b.type_of_asset_code='" + asstcode + "'   order by WATCHMAN_CODE";
			complaintMasterData.stmt22 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs22 = complaintMasterData.stmt22.executeQuery(query22);
			
			for (; complaintMasterData.rs22.next(); assts.add(compForm)) {
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs22.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs22.getString(2));
				compForm.setAssetCode(complaintMasterData.rs22.getString(3));
				compForm.setAssetName(complaintMasterData.rs22.getString(4));
			}

		} catch (Exception e) {
			Debug.println("The error in getassts=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return assts;
	}

	public static ArrayList getAsstsnew(String Habcode, String asstcode, DataSource dataSource) throws Exception {
		ArrayList assts;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		
		complaintMasterData.closeAll();
		
		CompForm compForm = null;
		
		String query1 = null;
		String query2 = null;
		String dist = null;
		String man = null;
		String pan = null;
		try {
			if (Habcode != null && !Habcode.equals("")) {
				dist = Habcode.substring(0, 2);
				
				man = Habcode.substring(5, 7);
				pan = Habcode.substring(12, 14);
				
				
			}
			
		} catch (Exception e) {
			Debug.println(" exception String" + e);
		}
		assts = new ArrayList();
		String query = "";
		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			if (asstcode.equals("01") || asstcode.equals("02") || asstcode.equals("03"))
				query = "select distinct a.GLBR_CODE,nvl(a.GLBR_LOC,'-'),b.asset_code,nvl(b.asset_name,'-') from RWS_AST_GLBR_SC_PARAM_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and a.asset_code=b.asset_code and r.panch_code=a.hab_code and a.hab_code='"
						+ Habcode
						+ "'  union (select distinct a.GLSR_CODE,nvl(a.GLSR_LOC,'-'),b.asset_code,nvl(b.asset_name,'-') from RWS_AST_GLSR_SC_PARAM_TBL a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=b.asset_code and a.asset_code=b.asset_code and r.panch_code=a.hab_code and a.hab_code='"
						+ Habcode + "' ";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			
			int count = 0;
			for (; complaintMasterData.rs.next(); assts.add(compForm)) {
				compForm = new CompForm();
				
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs.getString(1));
				compForm.setAssetLocation(complaintMasterData.rs.getString(2));
				compForm.setAssetCode(complaintMasterData.rs.getString(3));
				compForm.setAssetName(complaintMasterData.rs.getString(4));
				assts.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getassts=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return assts;
	}

	public static String getHabname(String Habcode) throws Exception {
		String complaintno;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		int rowCount = 0;
		complaintno = "";
		String com = "";
		String temp = "";
		PreparedStatement pst = null;
		String query = "";
		int i = 1;
		try {
			complaintMasterData.conn = RwsOffices.getConn();

			query = "select panch_name  from rws_complete_hab_view where panch_code=?  ";
			pst = complaintMasterData.conn.prepareStatement(query);
			pst.setString(1, Habcode);
			complaintMasterData.rset = pst.executeQuery();

			if (complaintMasterData.rset.next()) {

				temp = complaintMasterData.rset.getString(1);

			}

		}

		catch (Exception e) {
			System.out.println("The Exception in  getHabname of compaints -- " + e);
		} finally {
			complaintMasterData.closeAll();
			pst.close();
		}
		return temp;
	}

	public static String getLocation(String Habcode) throws Exception {
		String complaintno;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		int rowCount = 0;
		complaintno = "";
		String com = "";
		String temp = "";
		
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			String query = "";
			int i = 1;
			query = "select LOCALITY  from URBAN_LOCALITY where HAB_CODE='" + Habcode + "'  ";
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
			
		}
		return temp;
	}

	public ArrayList getRepresentatives(DataSource dataSource) throws Exception {
		ArrayList representatives;
		representatives = new ArrayList();
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		String query = null;
		LabelValueBean compForm = null;
		try {

			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt1 = complaintMasterData.conn.createStatement();

			query = " SELECT rep_code, rep_name  FROM rws_public_rep_tbl  where rep_code not in('11','13','14','15','16') ORDER BY rep_name";

			complaintMasterData.rs1 = complaintMasterData.stmt1.executeQuery(query);
			while (complaintMasterData.rs1.next()) {
				compForm = new LabelValueBean();
				compForm.setValue(complaintMasterData.rs1.getString(1));
				compForm.setLabel(complaintMasterData.rs1.getString(2));
				compForm.setLabelValue(
						complaintMasterData.rs1.getString(2) + " - " + complaintMasterData.rs1.getString(1));
				representatives.add(compForm);
			}

		} catch (Exception e) {
			System.out.println("exception in getRepresentatives -- " + e);
		} finally {
			complaintMasterData.closeAll();
		}
		return representatives;
	}

	public static ArrayList getAssts(String Habcode, String asstcode, DataSource dataSource) throws Exception {
		ArrayList assts;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		
		complaintMasterData.closeAll();
		CompForm compForm = null;
		
		String query1 = null;
		String query2 = null;
		String dist = null;
		String man = null;
		String pan = null;
		String hcode = null;
		String vill = null;
		try {
			if (Habcode != null && !Habcode.equals("")) {
				dist = Habcode.substring(0, 2);
				
				man = Habcode.substring(5, 7);
				pan = Habcode.substring(12, 14);
				vill = Habcode.substring(7, 10);
				hcode = Habcode.substring(10, 12);
				
				
			}
			
		} catch (Exception e) {
			Debug.println(" exception String" + e);
		}
		assts = new ArrayList();
		String query = "";
		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			if (asstcode.equals("04"))
				query = "select distinct h.hp_code,nvl(h.location,'-'),nvl(h.diameter,'0'),decode(h.status,'S','Seasonal','D','Dried','W','Working','N','Not Working','C','Condemed','','-')result,decode(h.gen_condition,'G','Good','B','Bad','','-')result1,nvl(h.static_wl,'0'),nvl(h.summer_wl,'0'),nvl(h.drill_year,'-'),a.asset_code,a.asset_name from rws_asset_mast_tbl a,RWS_HP_SUBCOMP_PARAM_TBL h,rws_asset_scheme_tbl s,rws_complete_hab_view hr where substr(s.scheme_code,1,16)=hr.panch_code and a.asset_code=s.asset_code and hr.panch_code=a.hab_code and a.asset_code=h.asset_code  and a.type_of_asset_code='"
						+ asstcode + "'  and  a.hab_code='" + Habcode + "'";
			else if (asstcode.equals("05"))
				query = "select distinct h.SHALLOWHP_CODE,nvl(h.LOCATION,'-'),nvl(h.DIAMETER,'0'),nvl(h.DEPTH,'0'),nvl(h.YIELD,'0'),nvl(h.AVERAGE_HOURS,'0'),nvl(h.AVERAGE_TIME,'0'),nvl(h.HYGIENE,'-'),a.asset_code,nvl(a.asset_name,'-') from rws_asset_mast_tbl a,RWS_shallowhandpumps_TBL h,rws_asset_scheme_tbl b,rws_complete_hab_view r where r.panch_code=a.hab_code  and substr(b.scheme_code,1,16)=r.panch_code and b.asset_code=a.asset_code and  a.asset_code=h.asset_code and  a.type_of_asset_code='"
						+ asstcode + "' and a.hab_code='" + Habcode + "'";
			else if (asstcode.equals("06"))
				query = "select distinct h.openwell_code,nvl(h.location,'-'),nvl(h.diameter,'0'),nvl(h.depth,'0'),nvl(h.normal_water_level,'0'),nvl(h.min_water_level,'0'),nvl(h.max_water_level,'0'),nvl(h.quality,'-'),a.asset_code,nvl(a.asset_name,'-') from rws_asset_mast_tbl a,RWS_OPEN_WELL_MAST_TBL h,rws_complete_hab_view r,rws_asset_scheme_tbl s where s.asset_code=a.asset_code and substr(s.scheme_code,1,16)=r.panch_code and r.panch_code=a.hab_code and  a.asset_code=h.asset_code and  a.type_of_asset_code='"
						+ asstcode + "' and a.hab_code='" + Habcode + "'";
			else if (asstcode.equals("07"))
				query = "select distinct h.pond_code,nvl(h.pond_name,'-'),nvl(h.size_area,'0'),nvl(h.storage_vol,'0'),a.asset_code,a.asset_name from rws_asset_mast_tbl a,RWS_OPENWELL_POND_TBL h,rws_asset_scheme_tbl s,rws_complete_hab_view r where s.asset_code=a.asset_code and r.panch_code=substr(s.scheme_code,1,16) and h.hab_code=a.hab_code and  r.panch_code=a.hab_code and  a.asset_code=h.asset_code  and a.type_of_asset_code='"
						+ asstcode + "' and substr(h.pond_code,1,16)='" + Habcode + "'";
			
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			
			int count = 0;
			for (; complaintMasterData.rs.next(); assts.add(compForm)) {
				compForm = new CompForm();
				String assetcode = complaintMasterData.rs.getString(1);
				if (asstcode.equals("04")) {
					String s = complaintMasterData.rs.getString(8);
					if (s.equals("null")) {
						s = "-";
					} else {
						s = complaintMasterData.rs.getString(8);
					}
					compForm.setSourceCode(complaintMasterData.rs.getString(1));
					compForm.setLocation(complaintMasterData.rs.getString(2));
					compForm.setDiameterOfBorewell(complaintMasterData.rs.getString(3));
					compForm.setStatus(complaintMasterData.rs.getString(4));
					compForm.setCond(complaintMasterData.rs.getString(5));
					compForm.setStaticWaterLevel(complaintMasterData.rs.getString(6));
					compForm.setSummerWaterLevel(complaintMasterData.rs.getString(7));
					compForm.setDrillYear(s);
					compForm.setAssetCode(complaintMasterData.rs.getString(9));
					compForm.setAssetName(complaintMasterData.rs.getString(10));
					compForm.setCompCode("01");
				} else if (asstcode.equals("05")) {
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs.getString(1));
					compForm.setShpLocation(complaintMasterData.rs.getString(2));
					compForm.setShpDiameter(complaintMasterData.rs.getString(3));
					compForm.setShpDepth(complaintMasterData.rs.getString(4));
					compForm.setShpYield(complaintMasterData.rs.getString(5));
					compForm.setShpAvgHours(complaintMasterData.rs.getString(6));
					compForm.setShpAvgTime(complaintMasterData.rs.getString(7));
					compForm.setShpHygiene(complaintMasterData.rs.getString(8));
					compForm.setAssetCode(complaintMasterData.rs.getString(9));
					compForm.setAssetName(complaintMasterData.rs.getString(10));
					compForm.setCompCode("01");
				} else if (asstcode.equals("06")) {
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs.getString(1));
					compForm.setOwLocation(complaintMasterData.rs.getString(2));
					compForm.setOwDiameter(complaintMasterData.rs.getString(3));
					compForm.setOwDepth(complaintMasterData.rs.getString(4));
					compForm.setOwNormalwl(complaintMasterData.rs.getString(5));
					compForm.setOwMinwl(complaintMasterData.rs.getString(6));
					compForm.setOwMaxwl(complaintMasterData.rs.getString(7));
					compForm.setOwQuality(complaintMasterData.rs.getString(8));
					compForm.setAssetCode(complaintMasterData.rs.getString(9));
					compForm.setAssetName(complaintMasterData.rs.getString(10));
					compForm.setCompCode("01");
				} else if (asstcode.equals("07")) {
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs.getString(1));
					compForm.setPondName(complaintMasterData.rs.getString(2));
					compForm.setPondSize(complaintMasterData.rs.getString(3));
					compForm.setPondVolume(complaintMasterData.rs.getString(4));
					compForm.setAssetCode(complaintMasterData.rs.getString(5));
					compForm.setAssetName(complaintMasterData.rs.getString(6));
					compForm.setCompCode("01");
				}
			}

		} catch (Exception e) {
			Debug.println("The error in getassts=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return assts;
	}

	public static CompForm getComplaint(String gassetcode, DataSource dataSource) throws Exception {
		CompForm compForm;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		compForm = null;
		String query = "";
		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select distinct asset_code,component_code,complaint_no,to_char(complaint_date,'dd/mm/yyyy'),complaint_desc  from rws_complaints_register_tbl where asset_code='"
					+ gassetcode + "'";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			
			for (; complaintMasterData.rs.next(); compForm.setComplntdesc(complaintMasterData.rs.getString(5))) {
				compForm = new CompForm();
				compForm.setAssetCode(complaintMasterData.rs.getString(1));
				compForm.setSourceCode(complaintMasterData.rs.getString(2));
				compForm.setComplntno(complaintMasterData.rs.getString(3));
				compForm.setComplntdt(complaintMasterData.rs.getString(4));
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return compForm;
	}

	public static ArrayList getdistrictrecComplaints(String districtcode, String asset, DataSource dataSource)
			throws Exception {
		ArrayList reccomplaints;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		reccomplaints = new ArrayList();
		String query = "";
		try {
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select distinct a.asset_code,a.component_code,a.complaint_no,to_char(a.complaint_date,'dd/mm/yyyy'),a.complaint_desc,b.asset_name  from rws_complaints_register_tbl a,rws_asset_mast_tbl b where substr(a.component_code,1,2)='"
					+ districtcode + "'  and b.type_of_asset_code='" + asset
					+ "' and a.asset_code=b.asset_code  order by 4 desc ";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			
			for (; complaintMasterData.rs.next(); reccomplaints.add(compForm)) {
				compForm = new CompForm();
				compForm.setAssetCode(complaintMasterData.rs.getString(1));
				compForm.setSourceCode(complaintMasterData.rs.getString(2));
				compForm.setAssetName(complaintMasterData.rs.getString(6));
				compForm.setComplntno(complaintMasterData.rs.getString(3));
				compForm.setComplntdt(complaintMasterData.rs.getString(4));
				compForm.setComplntdesc(complaintMasterData.rs.getString(5));
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return reccomplaints;
	}

	public static ArrayList getmandalrecComplaints(String districtcode, String mandalcode, String asset,
			DataSource dataSource) throws Exception {
		ArrayList reccomplaints;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		reccomplaints = new ArrayList();
		String query = "";
		try {
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select distinct a.asset_code,a.component_code,a.complaint_no,to_char(a.complaint_date,'dd/mm/yyyy'),a.complaint_desc,b.asset_name  from rws_complaints_register_tbl a,rws_asset_mast_tbl b where substr(a.component_code,1,2)='"
					+ districtcode + "'  and substr(a.component_code,6,2)='" + mandalcode
					+ "' and a.asset_code=b.asset_code and b.type_of_asset_code='" + asset + "'  order by 4 desc ";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			
			for (; complaintMasterData.rs.next(); reccomplaints.add(compForm)) {
				compForm = new CompForm();
				compForm.setAssetCode(complaintMasterData.rs.getString(1));
				compForm.setSourceCode(complaintMasterData.rs.getString(2));
				compForm.setAssetName(complaintMasterData.rs.getString(6));
				compForm.setComplntno(complaintMasterData.rs.getString(3));
				compForm.setComplntdt(complaintMasterData.rs.getString(4));
				compForm.setComplntdesc(complaintMasterData.rs.getString(5));
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return reccomplaints;
	}

	public static ArrayList getpanchayatrecComplaints(String districtcode, String mandalcode, String panchayatcode,
			String asset, DataSource dataSource) throws Exception {
		ArrayList reccomplaints;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		reccomplaints = new ArrayList();
		String query = "";
		try {
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select  distinct a.asset_code,a.component_code,a.complaint_no,to_char(a.complaint_date,'dd/mm/yyyy'),a.complaint_desc,b.asset_name  from rws_complaints_register_tbl a,rws_asset_mast_tbl b where substr(a.component_code,1,2)='"
					+ districtcode + "'  and substr(a.component_code,6,2)='" + mandalcode
					+ "' and substr(a.component_code,13,2)='" + panchayatcode
					+ "' and  a.asset_code=b.asset_code and b.type_of_asset_code='" + asset + "'  order by 4 desc ";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			
			for (; complaintMasterData.rs.next(); reccomplaints.add(compForm)) {
				compForm = new CompForm();
				compForm.setAssetCode(complaintMasterData.rs.getString(1));
				compForm.setSourceCode(complaintMasterData.rs.getString(2));
				compForm.setAssetName(complaintMasterData.rs.getString(6));
				compForm.setComplntno(complaintMasterData.rs.getString(3));
				compForm.setComplntdt(complaintMasterData.rs.getString(4));
				compForm.setComplntdesc(complaintMasterData.rs.getString(5));
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return reccomplaints;
	}

	// code modified by sridhar
	public static ArrayList getNotAttendedComplaints(String Habcode, DataSource dataSource) throws Exception {
		ArrayList notattendedcomplaints;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		notattendedcomplaints = new ArrayList();
		String dist = null;
		String man = null;
		String pan = null;
		String vill = null;
		String hcode = null;
		String query = "";
		try {
			dist = Habcode.substring(0, 2);
			
			man = Habcode.substring(5, 7);
			pan = Habcode.substring(12, 14);
			hcode = Habcode.substring(10, 12);
			vill = Habcode.substring(7, 10);
			
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			
			query = "select distinct a.asset_code,a.component_code,a.complaint_no,to_char (a.complaint_date,'dd/mm/yyyy'),nvl(a.complaint_desc,'-'),b.asset_name,a.complaint_status,p.rep_name,a.name,a.address,comp_cat_name from rws_complaints_register_tbl a,rws_asset_mast_tbl b,rws_public_rep_tbl p,rws_complaint_category_tbl c where p.rep_code=a.rep_code and substr (a.component_code,1,2)='"
					+ dist + "' and substr(a.component_code,6,2)='" + man + "' and substr(a.component_code,13,2)='"
					+ pan + "' and substr (a.component_code,8,3)='" + vill
					+ "' and a.asset_code=b.asset_code and a.complaint_status is null  and a.comp_code=c.comp_code and a.category_code=c.com_category_code  and substr(a.asset_code,7,2)=type_of_asset  order by complaint_no ";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			for (; complaintMasterData.rs.next(); notattendedcomplaints.add(compForm)) {
				compForm = new CompForm();
				compForm.setAssetCode(complaintMasterData.rs.getString(1));
				compForm.setSourceCode(complaintMasterData.rs.getString(2));
				compForm.setAssetName(complaintMasterData.rs.getString(6));
				compForm.setComplntno(complaintMasterData.rs.getString(3));
				compForm.setComplntdt(complaintMasterData.rs.getString(4));
				compForm.setComplntdesc(complaintMasterData.rs.getString(5));
				compForm.setComplntstatus(complaintMasterData.rs.getString(7));
				compForm.setCategoryName(complaintMasterData.rs.getString("comp_cat_name"));
				compForm.setRepName(complaintMasterData.rs.getString("rep_name"));
				compForm.setName(complaintMasterData.rs.getString("name"));
				compForm.setAddress(complaintMasterData.rs.getString("address"));
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return notattendedcomplaints;
	}

	//
	public static ArrayList getNotAttendedComplaintsgeneric(String Habcode, DataSource dataSource) throws Exception {
		ArrayList notattendedcomplaints;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		notattendedcomplaints = new ArrayList();
		String dist = null;
		String man = null;
		String pan = null;
		String vill = null;
		String hcode = null;
		String query = "";
		try {
			dist = Habcode.substring(0, 2);
			
			man = Habcode.substring(5, 7);
			pan = Habcode.substring(12, 14);
			hcode = Habcode.substring(10, 12);
			vill = Habcode.substring(7, 10);
			
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select distinct a.component_name,a.complaint_no,to_char (a.complaint_date,'dd/mm/yyyy'),nvl(a.complaint_desc,'-'),a.complaint_status,p.rep_name,a.name,a.address from rws_generic_complaints_reg_tbl a,rws_public_rep_tbl p where p.rep_code=a.rep_code and substr (a.habitation_code,1,2)='"
					+ dist + "' and substr(a.habitation_code,6,2)='" + man + "' and substr(a.habitation_code,13,2)='"
					+ pan + "' and substr (a.habitation_code,8,3)='" + vill
					+ "'  and a.complaint_status is null     order by complaint_no ";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			for (; complaintMasterData.rs.next(); notattendedcomplaints.add(compForm)) {
				compForm = new CompForm();
				compForm.setComponentName(complaintMasterData.rs.getString(1));
				compForm.setComplntno(complaintMasterData.rs.getString(2));
				compForm.setComplntdt(complaintMasterData.rs.getString(3));
				compForm.setComplntdesc(complaintMasterData.rs.getString(4));
				compForm.setComplntstatus(complaintMasterData.rs.getString(5));

				compForm.setRepName(complaintMasterData.rs.getString("rep_name"));
				compForm.setName(complaintMasterData.rs.getString("name"));
				compForm.setAddress(complaintMasterData.rs.getString("address"));
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return notattendedcomplaints;
	}

	//

	public static ArrayList getComplaints(String asset, String dis, DataSource dataSource) throws Exception {
		ArrayList complaints;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		complaints = new ArrayList();
		String query = "";
		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			// query = "select distinct
			// a.asset_code,a.component_code,a.complaint_no,to_char(a.complaint_date,'dd/mm/yyyy'),a.complaint_desc,a.complaint_status,nvl(b.asset_name,'-'),nvl(b.location,'-'),b.type_of_asset_code,a.categor_code,a.name,a.address,p.rep_name,nvl(a.phone_no,'-'),nvl(a.inward_no,'-')
			// from rws_complaints_register_tbl a,rws_asset_mast_tbl b,rws_public_rep_tbl p
			// where p.rep_code=a.rep_code and b.asset_code=a.asset_code and
			// a.complaint_status is null and b.type_of_asset_code='" + asset + "' and
			// substr(a.component_code,1,2)='" + dis + "' order by a.complaint_no";
			// query="select distinct a.asset_code,a.component_code,a.complaint_no,to_char
			// (a.complaint_date,'dd/mm/yyyy'),nvl(a.complaint_desc,'-') as
			// complaint_desc,a.complaint_status,nvl(b.asset_name,'-'),nvl(b.location,'-
			// '),b.type_of_asset_code,COMP_CAT_NAME,a.name,a.address,p.rep_name,nvl(a.phone_no,'-'),nvl(a.inward_no,'-')
			// as inward_no,COMP_CAT_NAME from rws_complaints_register_tbl
			// a,rws_asset_mast_tbl b,rws_public_rep_tbl p,RWS_COMPLAINT_CATEGORY_TBL c
			// where p.rep_code=a.rep_code and b.asset_code=a.asset_code and
			// a.complaint_status is null and b.type_of_asset_code='"+asset+"' and
			// substr(a.component_code,1,2)='"+dis+"' and
			// b.type_of_asset_code=c.type_of_asset and a.COMP_CODE=c.COMP_CODE and
			// c.COM_CATEGORY_CODE=a.category_code order by a.complaint_no ";
			query = "select distinct a.asset_code,a.component_code,a.complaint_no,to_char (a.complaint_date,'dd/mm/yyyy'),nvl(a.complaint_desc,'-') as complaint_desc,a.complaint_status,nvl(b.asset_name,'-'),nvl(b.location,'- '),b.type_of_asset_code,CATEGORY_NAME,a.name,a.address,p.rep_name,nvl(a.phone_no,'-'),nvl(a.inward_no,'-') as inward_no,CATEGORY_NAME from rws_complaints_register_tbl a,rws_asset_mast_tbl b,rws_public_rep_tbl p,RWS_COMPLAINT_CATEGORY_TBL c where p.rep_code=a.rep_code and b.asset_code=a.asset_code and a.complaint_status is null and b.type_of_asset_code='"
					+ asset + "'  and substr(a.component_code,1,2)='" + dis
					+ "'  and b.type_of_asset_code=c.type_of_asset_code and a.COMP_CODE=c.COMP_CODE and c.CATEGORY_CODE=a.category_code order by a.complaint_no ";

			for (complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query); complaintMasterData.rs
					.next(); complaints.add(compForm)) {
				compForm = new CompForm();
				compForm.setAssetCode(complaintMasterData.rs.getString(1));
				compForm.setSourceCode(complaintMasterData.rs.getString(2));
				compForm.setComplntno(complaintMasterData.rs.getString(3));
				compForm.setComplntdt(complaintMasterData.rs.getString(4));
				compForm.setComplntdesc(complaintMasterData.rs.getString(5));
				compForm.setComplntstatus(complaintMasterData.rs.getString(6));
				compForm.setAssetName(complaintMasterData.rs.getString(7));
				compForm.setAssetLocation(complaintMasterData.rs.getString(8));
				compForm.setTypeofAsset(complaintMasterData.rs.getString(9));
				compForm.setCategoryName(complaintMasterData.rs.getString(10));
				compForm.setName(complaintMasterData.rs.getString(11));
				compForm.setAddress(complaintMasterData.rs.getString(12));
				compForm.setRepName(complaintMasterData.rs.getString(13));
				compForm.setPhoneNo(complaintMasterData.rs.getString(14));
				compForm.setInwardNo(complaintMasterData.rs.getString(15));
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return complaints;
	}

	//
	public static ArrayList getComplaintsgeneric(String dis, DataSource dataSource) throws Exception {
		ArrayList complaints;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		complaints = new ArrayList();
		String query = "";
		PreparedStatement pst = null;
		try {

			complaintMasterData.conn = RwsOffices.getConn();

			
			query = "select distinct a.complaint_no,to_char (a.complaint_date,'dd/mm/yyyy'),nvl(a.complaint_desc,'-') as complaint_desc,a.complaint_status,"
					+ "a.name,a.address,p.rep_name,nvl(a.phone_no,'-') from RWS_GENERIC_COMPLAINTS_REG_TBL a,rws_public_rep_tbl p "
					+ "where p.rep_code=a.rep_code  and a.complaint_status is null   and substr(a.complaint_no,1,2)=?  order by a.complaint_no ";
			pst = complaintMasterData.conn.prepareStatement(query);
			pst.setString(1, dis);
			complaintMasterData.rs = pst.executeQuery();

			while (complaintMasterData.rs.next()) {
				compForm = new CompForm();
				compForm.setComplntno(complaintMasterData.rs.getString(1));
				compForm.setComplntdt(complaintMasterData.rs.getString(2));
				compForm.setComplntdesc(complaintMasterData.rs.getString(3));
				compForm.setComplntstatus(complaintMasterData.rs.getString(4));
				compForm.setName(complaintMasterData.rs.getString(5));
				compForm.setAddress(complaintMasterData.rs.getString(6));
				compForm.setRepName(complaintMasterData.rs.getString(7));
				compForm.setPhoneNo(complaintMasterData.rs.getString(8));
				complaints.add(compForm);
			}

		} catch (Exception e) {
			System.out.println("The Exception in getComplaintsgeneric= " + e);
		} finally {
			complaintMasterData.closeAll();
			pst.close();
		}
		return complaints;
	}

	public static ArrayList getUrbanComplaintsgeneric(String dis, DataSource dataSource) throws Exception {
		ArrayList complaints;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		UrbanCompForm compForm = null;
		complaints = new ArrayList();
		String query = "";
		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			// query = "select distinct
			// a.asset_code,a.component_code,a.complaint_no,to_char(a.complaint_date,'dd/mm/yyyy'),a.complaint_desc,a.complaint_status,nvl(b.asset_name,'-'),nvl(b.location,'-'),b.type_of_asset_code,a.categor_code,a.name,a.address,p.rep_name,nvl(a.phone_no,'-'),nvl(a.inward_no,'-')
			// from rws_complaints_register_tbl a,rws_asset_mast_tbl b,rws_public_rep_tbl p
			// where p.rep_code=a.rep_code and b.asset_code=a.asset_code and
			// a.complaint_status is null and b.type_of_asset_code='" + asset + "' and
			// substr(a.component_code,1,2)='" + dis + "' order by a.complaint_no";
			query = "select distinct a.complaint_no,to_char (a.complaint_date,'dd/mm/yyyy'),nvl(a.complaint_desc,'-') as complaint_desc,a.complaint_status,a.name,a.address,p.rep_name,nvl(a.phone_no,'-') from RWS_GENERIC_COMPLAINTS_REG_TBL a,rws_public_rep_tbl p where p.rep_code=a.rep_code  and a.complaint_status is null   and substr(a.complaint_no,1,2)='"
					+ dis + "' and URBAN_WATER ='U'  order by a.complaint_no ";
			
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			while (complaintMasterData.rs.next()) {

				compForm = new UrbanCompForm();

				compForm.setComplntno(complaintMasterData.rs.getString(1));

				compForm.setComplntdt(complaintMasterData.rs.getString(2));

				compForm.setComplntdesc(complaintMasterData.rs.getString(3));

				compForm.setComplntstatus(complaintMasterData.rs.getString(4));

				compForm.setName(complaintMasterData.rs.getString(5));
				compForm.setAddress(complaintMasterData.rs.getString(6));
				compForm.setRepName(complaintMasterData.rs.getString(7));
				compForm.setPhoneNo(complaintMasterData.rs.getString(8));

				complaints.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return complaints;
	}

	//
	public static int deletegeneric(String complaintno, DataSource dataSource) throws Exception {
		ArrayList complaints;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		int count = 0;
		String query = "";
		PreparedStatement pst=null;
		try {
			
			complaintMasterData.conn = RwsOffices.getConn();
		

			query = "delete  from RWS_GENERIC_COMPLAINTS_REG_tbl where complaint_status is null and complaint_no=? ";
			pst = complaintMasterData.conn.prepareStatement(query);
			pst.setString(1, complaintno);
			count = pst.executeUpdate();

		} catch (Exception e) {
			System.out.println("The Exception in deletegeneric=" + e);
		} finally {
			complaintMasterData.closeAll();
	
		}
		return count;
	}

	public static int deleteUrbangeneric(String complaintno, DataSource dataSource) throws Exception {
		ArrayList complaints;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		UrbanCompForm compForm = null;
		int count = 0;
		String query = "";
		PreparedStatement stmt = null;
		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();

			query = "delete  from RWS_GENERIC_COMPLAINTS_REG_tbl where complaint_status is null and complaint_no=?";
			stmt = complaintMasterData.conn.prepareStatement(query);
			stmt.setString(1, complaintno);
			count = stmt.executeUpdate(query);

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return count;
	}

	//
	public static ArrayList getComplaintsout(String asset, String dis, DataSource dataSource) throws Exception {
		ArrayList complaints;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		complaints = new ArrayList();
		String query = "";
		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			// query = "select distinct
			// a.asset_code,a.component_code,a.complaint_no,to_char(a.complaint_date,'dd/mm/yyyy'),a.complaint_desc,a.complaint_status,nvl(b.asset_name,'-'),nvl(b.location,'-'),b.type_of_asset_code,a.categor_code,a.name,a.address,p.rep_name,nvl(a.phone_no,'-'),nvl(a.inward_no,'-')
			// from rws_complaints_register_tbl a,rws_asset_mast_tbl b,rws_public_rep_tbl p
			// where p.rep_code=a.rep_code and b.asset_code=a.asset_code and
			// a.complaint_status is null and b.type_of_asset_code='" + asset + "' and
			// substr(a.component_code,1,2)='" + dis + "' order by a.complaint_no";
			query = "select distinct a.asset_code,a.component_code,a.complaint_no,to_char (a.complaint_date,'dd/mm/yyyy'),nvl(a.complaint_desc,'_') ,a.complaint_status,nvl(b.asset_name,'-'),nvl(b.location,'- '),b.type_of_asset_code,COMP_CAT_NAME,a.name,a.address,p.rep_name,nvl(a.phone_no,'-'),COMP_CAT_NAME from rws_complaints_register_tbl a,rws_asset_mast_tbl b,rws_public_rep_tbl p,RWS_COMPLAINT_CATEGORY_TBL c where p.rep_code=a.rep_code and b.asset_code=a.asset_code and a.complaint_status is null and b.type_of_asset_code='"
					+ asset + "'  and substr(a.component_code,1,2)='" + dis
					+ "'  and b.type_of_asset_code=c.type_of_asset and a.COMP_CODE=c.COMP_CODE and c.COM_CATEGORY_CODE=a.category_code order by a.complaint_no ";
			for (complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query); complaintMasterData.rs
					.next(); complaints.add(compForm)) {
				compForm = new CompForm();
				compForm.setAssetCode(complaintMasterData.rs.getString(1));
				compForm.setSourceCode(complaintMasterData.rs.getString(2));
				compForm.setComplntno(complaintMasterData.rs.getString(3));
				compForm.setComplntdt(complaintMasterData.rs.getString(4));
				compForm.setComplntdesc(complaintMasterData.rs.getString(5));
				compForm.setComplntstatus(complaintMasterData.rs.getString(6));
				compForm.setAssetName(complaintMasterData.rs.getString(7));
				compForm.setAssetLocation(complaintMasterData.rs.getString(8));
				compForm.setTypeofAsset(complaintMasterData.rs.getString(9));
				compForm.setCategoryName(complaintMasterData.rs.getString(10));
				compForm.setName(complaintMasterData.rs.getString(11));
				compForm.setAddress(complaintMasterData.rs.getString(12));
				compForm.setRepName(complaintMasterData.rs.getString(13));
				compForm.setPhoneNo(complaintMasterData.rs.getString(14));

			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return complaints;
	}

	//

	public static String getComplaintsNo1(String complaintno, DataSource dataSource) throws Exception {
		String complaintstatus;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		ArrayList complaints = new ArrayList();
		String query = "";
		String status = "";
		complaintstatus = "";
		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select nvl(complaint_status,'-') from rws_complaints_register_tbl where complaint_no='"
					+ complaintno + "'";
			
			for (complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query); complaintMasterData.rs
					.next(); ) {
				status = complaintMasterData.rs.getString(1);
				if (status.equals("-"))
					complaintstatus = "Not Attended";
				else
					complaintstatus = complaintMasterData.rs.getString(1);
				compForm = new CompForm();
				compForm.setStatus(complaintstatus);
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return complaintstatus;
	}

	//
	public static String getComplaintsNogeneric1(String complaintno, DataSource dataSource) throws Exception {
		String complaintstatus;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		ArrayList complaints = new ArrayList();
		String query = "";
		String status = "";
		complaintstatus = "";
		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select nvl(complaint_status,'-') from rws_generic_complaints_reg_tbl where complaint_no='"
					+ complaintno + "'";
			
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			while (complaintMasterData.rs.next()) {
				status = complaintMasterData.rs.getString(1);
				if (status.equals("-"))
					complaintstatus = "Not Attended";
				else
					complaintstatus = complaintMasterData.rs.getString(1);
				compForm = new CompForm();
				compForm.setStatus(complaintstatus);
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return complaintstatus;
	}

	//

	public static ArrayList getComplaintsNo(String complaintno, DataSource dataSource) throws Exception {
		ArrayList complaints;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		complaints = new ArrayList();
		String query = "";
		String st = null;
		String s = null;

		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			// query = "select distinct
			// a.component_code,nvl(m.asset_name,'-'),a.complaint_no,to_char(a.complaint_date,'dd/mm/yyyy'),a.complaint_desc,nvl(a.attended_by,'-'),nvl(to_char(a.attended_date,'dd/mm/yyyy'),'-'),nvl(a.complaint_status,'-'),nvl(a.remarks,'-'),r.rep_name,a.name,a.address
			// from rws_complaints_register_tbl a,rws_asset_mast_tbl m,rws_public_rep_tbl r
			// where r.rep_code=a.rep_code and m.asset_code=a.asset_code and
			// a.complaint_no='" + complaintno + "'";
			query = "select distinct a.component_code,nvl(m.asset_name,'-'),a.complaint_no,to_char (a.complaint_date,'dd/mm/yyyy'),CATEGORY_NAME ,a.complaint_desc,nvl(a.attended_by,'-'),nvl(to_char (a.attended_date,'dd/mm/yyyy'),'-'),nvl(a.complaint_status,'-'),nvl(a.remarks,'-'),r.rep_name,a.name,a.address from rws_complaints_register_tbl a,rws_asset_mast_tbl m,rws_public_rep_tbl r,rws_complaint_category_tbl c where r.rep_code=a.rep_code and m.asset_code=a.asset_code and a.comp_code=c.CATEGORY_CODE  and a.category_code=c.CATEGORY_CODE  and substr(a.asset_code,7,2)=c.TYPE_OF_ASSET_CODE and a.complaint_no='"
					+ complaintno + "'";
			for (complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query); complaintMasterData.rs
					.next(); complaints.add(compForm)) {
				compForm = new CompForm();
				st = complaintMasterData.rs.getString(8);
				if (st.equals("-"))
					s = "NOT ATTENDED";
				else
					s = complaintMasterData.rs.getString(9);
				compForm.setSourceCode(complaintMasterData.rs.getString(1));
				compForm.setAssetName(complaintMasterData.rs.getString(2));
				compForm.setComplntno(complaintMasterData.rs.getString(3));
				compForm.setComplntdt(complaintMasterData.rs.getString(4));
				compForm.setCategoryName(complaintMasterData.rs.getString(5));
				compForm.setComplntdesc(complaintMasterData.rs.getString(6));
				compForm.setAttenby(complaintMasterData.rs.getString(7));
				compForm.setAttendt(complaintMasterData.rs.getString(8));
				compForm.setStatus(s);
				compForm.setRemarksby(complaintMasterData.rs.getString(10));
				compForm.setRepName(complaintMasterData.rs.getString(11));
				compForm.setName(complaintMasterData.rs.getString(12));
				compForm.setAddress(complaintMasterData.rs.getString(13));
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return complaints;
	}

	//
	public static ArrayList getComplaintsNogeneric(String complaintno, DataSource dataSource) throws Exception {
		ArrayList complaints;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		complaints = new ArrayList();
		String query = "";
		String st = null;
		String s = null;

		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			// query = "select distinct
			// a.component_code,nvl(m.asset_name,'-'),a.complaint_no,to_char(a.complaint_date,'dd/mm/yyyy'),a.complaint_desc,nvl(a.attended_by,'-'),nvl(to_char(a.attended_date,'dd/mm/yyyy'),'-'),nvl(a.complaint_status,'-'),nvl(a.remarks,'-'),r.rep_name,a.name,a.address
			// from rws_complaints_register_tbl a,rws_asset_mast_tbl m,rws_public_rep_tbl r
			// where r.rep_code=a.rep_code and m.asset_code=a.asset_code and
			// a.complaint_no='" + complaintno + "'";
			query = "select distinct a.component_name,a.complaint_no,to_char (a.complaint_date,'dd/mm/yyyy'),a.complaint_desc,nvl(a.attended_by,'-'),nvl(to_char (a.attended_date,'dd/mm/yyyy'),'-'),nvl(a.ACTION_TAKEN,'-'),nvl(a.remarks,'-'),r.rep_name,a.name,a.address from rws_generic_complaints_reg_tbl a,rws_public_rep_tbl r where r.rep_code=a.rep_code  and a.complaint_no='"
					+ complaintno + "'";
			
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			while (complaintMasterData.rs.next()) {
				compForm = new CompForm();
				st = complaintMasterData.rs.getString(7);
				if (st.equals("-"))
					s = "NOT ATTENDED";
				else
					s = complaintMasterData.rs.getString(7);
				compForm.setComponentName(complaintMasterData.rs.getString(1));
				compForm.setComplntno(complaintMasterData.rs.getString(2));
				compForm.setComplntdt(complaintMasterData.rs.getString(3));
				compForm.setComplntdesc(complaintMasterData.rs.getString(4));
				compForm.setAttenby(complaintMasterData.rs.getString(5));
				compForm.setAttendt(complaintMasterData.rs.getString(6));
				compForm.setStatus(s);
				compForm.setRemarksby(complaintMasterData.rs.getString(8));
				compForm.setRepName(complaintMasterData.rs.getString(9));
				compForm.setName(complaintMasterData.rs.getString(10));
				compForm.setAddress(complaintMasterData.rs.getString(11));
				complaints.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return complaints;
	}

	//

	public static ArrayList getComplaintsdates(DataSource dataSource) throws Exception {
		ArrayList complaints;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		complaints = new ArrayList();
		String query = "";
		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select distinct   to_char(complaint_date,'dd/mm/yyyy') from rws_complaints_register_tbl ";
			for (complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query); complaintMasterData.rs
					.next(); complaints.add(compForm)) {
				compForm = new CompForm();
				compForm.setComplntdt(complaintMasterData.rs.getString(1));
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return complaints;
	}

	public static ArrayList getComplaintnodates(String dcode, String mcode, String pcode, DataSource dataSource)
			throws Exception {
		ArrayList complaints;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		complaints = new ArrayList();
		String query = "";
		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			// query = "select distinct
			// complaint_no,to_char(complaint_date,'dd/mm/yyyy'),nvl(m.asset_name,'-'),complaint_desc,decode(category_code,'01','PUMP
			// DAMAGED','02','LEAKING')result,r.rep_name from rws_complaints_register_tbl
			// a,rws_asset_mast_tbl m,rws_public_rep_tbl r where r.rep_code=a.rep_code and
			// m.asset_code=a.asset_code and substr(component_code,1,2)='" + dcode + "' and
			// substr(component_code,6,2)='" + mcode + "' and substr(component_code,13,2)='"
			// + pcode + "' order by complaint_no";
			query = "select distinct complaint_no,to_char(complaint_date,'dd/mm/yyyy'),nvl(m.asset_name,'-'),complaint_desc,c.CATEGORY_NAME, r.rep_name from rws_complaints_register_tbl a,rws_asset_mast_tbl m,rws_public_rep_tbl r,rws_complaint_category_tbl c where r.rep_code=a.rep_code and m.asset_code=a.asset_code and a.comp_code=c.CATEGORY_CODE  and a.category_code=c.CATEGORY_CODE  and substr(a.asset_code,7,2)=c.TYPE_OF_ASSET_CODE  and substr(component_code,1,2)='"
					+ dcode + "' and substr(component_code,6,2)='" + mcode + "' and substr(component_code,13,2)='"
					+ pcode + "' order by complaint_no ";

			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			while (complaintMasterData.rs.next()) {
				compForm = new CompForm();
				compForm.setComplntno(complaintMasterData.rs.getString(1));
				compForm.setComplntdt(complaintMasterData.rs.getString(2));
				compForm.setAssetName(complaintMasterData.rs.getString(3));
				compForm.setComplntdesc(complaintMasterData.rs.getString(4));
				compForm.setCategory(complaintMasterData.rs.getString(5));
				compForm.setRepName(complaintMasterData.rs.getString(6));
				complaints.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return complaints;
	}

	//
	public static ArrayList getComplaintnodatesgeneric(String dcode, String mcode, String pcode, DataSource dataSource)
			throws Exception {
		ArrayList complaints;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		complaints = new ArrayList();
		String query = "";
		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			// query = "select distinct
			// complaint_no,to_char(complaint_date,'dd/mm/yyyy'),nvl(m.asset_name,'-'),complaint_desc,decode(category_code,'01','PUMP
			// DAMAGED','02','LEAKING')result,r.rep_name from rws_complaints_register_tbl
			// a,rws_asset_mast_tbl m,rws_public_rep_tbl r where r.rep_code=a.rep_code and
			// m.asset_code=a.asset_code and substr(component_code,1,2)='" + dcode + "' and
			// substr(component_code,6,2)='" + mcode + "' and substr(component_code,13,2)='"
			// + pcode + "' order by complaint_no";
			query = "select distinct complaint_no,to_char(complaint_date,'dd/mm/yyyy'),component_name,complaint_desc,r.rep_name from rws_generic_complaints_reg_tbl a,rws_public_rep_tbl r where r.rep_code=a.rep_code  and substr(habitation_code,1,2)='"
					+ dcode + "' and substr(habitation_code,6,2)='" + mcode + "' and substr(habitation_code,13,2)='"
					+ pcode + "' order by complaint_no ";

			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			while (complaintMasterData.rs.next()) {
				compForm = new CompForm();
				compForm.setComplntno(complaintMasterData.rs.getString(1));
				compForm.setComplntdt(complaintMasterData.rs.getString(2));
				compForm.setComponentName(complaintMasterData.rs.getString(3));
				compForm.setComplntdesc(complaintMasterData.rs.getString(4));
				compForm.setRepName(complaintMasterData.rs.getString(5));
				complaints.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return complaints;
	}

	//

	public static ArrayList getComplaintsall(String asset, String dis, String man, String pan, String hab,
			DataSource dataSource) throws Exception {
		ArrayList complaints;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		complaints = new ArrayList();
		String query = "";
		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select distinct a.asset_code,a.component_code,a.complaint_no,to_char(a.complaint_date,'dd/mm/yyyy'),a.complaint_desc,a.complaint_status,nvl(b.asset_name,'-'),nvl(b.location,'-'),b.type_of_asset_code,d.dcode,m.category_name  from rws_complaints_register_tbl a,rws_asset_mast_tbl b,rws_asset_type_tbl t,rws_district_tbl d,rws_complaints_category_tbl m,rws_mandal_tbl m,rws_panchayat_tbl  p,rws_habitation_directory_tbl h where b.asset_code=a.asset_code and t.type_of_asset_code=b.type_of_asset_code and a.complaint_status is null and b.type_of_asset_code='"
					+ asset + "' and substr(a.component_code,1,2)='" + dis
					+ "' and  d.dcode=substr(a.component_code,1,2) and  m.mcode=substr(a.component_code,6,2) and substr(a.component_code,6,2)='"
					+ man + "' and p.pcode=substr(a.component_code,13,2) and substr(a.component_code,13,2)='" + pan
					+ "' and substr(a.component_code,1,16)=h.hab_code and substr(a.component_code,1,16)='" + hab
					+ "' and m.category_code=a.category_code order by a.complaint_no";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			for (; complaintMasterData.rs.next(); complaints.add(compForm)) {
				compForm = new CompForm();
				compForm.setAssetCode(complaintMasterData.rs.getString(1));
				compForm.setSourceCode(complaintMasterData.rs.getString(2));
				compForm.setComplntno(complaintMasterData.rs.getString(3));
				compForm.setComplntdt(complaintMasterData.rs.getString(4));
				compForm.setComplntdesc(complaintMasterData.rs.getString(5));
				compForm.setComplntstatus(complaintMasterData.rs.getString(6));
				compForm.setAssetName(complaintMasterData.rs.getString(7));
				compForm.setAssetLocation(complaintMasterData.rs.getString(8));
				compForm.setTypeofAsset(complaintMasterData.rs.getString(9));
				compForm.setDcode(complaintMasterData.rs.getString(10));
				compForm.setCategoryName(complaintMasterData.rs.getString(11));
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return complaints;
	}

	public static ArrayList getComplaintsd(String asset, String dis, DataSource dataSource) throws Exception {
		ArrayList complaints;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		complaints = new ArrayList();
		String query = "";
		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select distinct a.asset_code,a.component_code,a.complaint_no,to_char(a.complaint_date,'dd/mm/yyyy'),a.complaint_desc,a.complaint_status,nvl(b.asset_name,'-'),nvl(b.location,'-'),b.type_of_asset_code,d.dcode  from rws_complaints_register_tbl a,rws_asset_mast_tbl b,rws_asset_type_tbl t,rws_district_tbl d where b.asset_code=a.asset_code and t.type_of_asset_code=b.type_of_asset_code and a.complaint_status is null and b.type_of_asset_code='"
					+ asset + "' and substr(a.component_code,1,2)='" + dis
					+ "'and  d.dcode=substr(a.component_code,1,2) order by a.complaint_no";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			
			for (; complaintMasterData.rs.next(); complaints.add(compForm)) {
				compForm = new CompForm();
				compForm.setAssetCode(complaintMasterData.rs.getString(1));
				compForm.setSourceCode(complaintMasterData.rs.getString(2));
				compForm.setComplntno(complaintMasterData.rs.getString(3));
				compForm.setComplntdt(complaintMasterData.rs.getString(4));
				compForm.setComplntdesc(complaintMasterData.rs.getString(5));
				compForm.setComplntstatus(complaintMasterData.rs.getString(6));
				compForm.setAssetName(complaintMasterData.rs.getString(7));
				compForm.setAssetLocation(complaintMasterData.rs.getString(8));
				compForm.setTypeofAsset(complaintMasterData.rs.getString(9));
				compForm.setDcode(complaintMasterData.rs.getString(10));
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return complaints;
	}

	public static ArrayList getComplaintslist(DataSource dataSource) throws Exception {
		ArrayList complaints;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		complaints = new ArrayList();
		String query = "";
		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select distinct a.asset_code,a.component_code,a.complaint_no,to_char(a.complaint_date,'dd/mm/yyyy'),a.complaint_desc,a.complaint_status,nvl(b.asset_name,'-'),nvl(b.location,'-'),a.name,a.address  from rws_complaints_register_tbl a,rws_asset_mast_tbl b,rws_asset_type_tbl t where b.asset_code=a.asset_code and b.type_of_asset_code=t.type_of_asset_code and a.complaint_status is  null and a. order by a.complaint_no";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			
			for (; complaintMasterData.rs.next(); complaints.add(compForm)) {
				compForm = new CompForm();
				compForm.setAssetCode(complaintMasterData.rs.getString(1));
				compForm.setSourceCode(complaintMasterData.rs.getString(2));
				compForm.setComplntno(complaintMasterData.rs.getString(3));
				compForm.setComplntdt(complaintMasterData.rs.getString(4));
				compForm.setComplntdesc(complaintMasterData.rs.getString(5));
				compForm.setComplntstatus(complaintMasterData.rs.getString(6));
				compForm.setAssetName(complaintMasterData.rs.getString(7));
				compForm.setAssetLocation(complaintMasterData.rs.getString(8));
				compForm.setName(complaintMasterData.rs.getString(9));
				compForm.setAddress(complaintMasterData.rs.getString(10));
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return complaints;
	}

	public static ArrayList getAssetTypes(DataSource dataSource) throws Exception {
		ArrayList assettypes;
		assettypes = new ArrayList();
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			String query = "SELECT DISTINCT TYPE_OF_ASSET_CODE,TYPE_OF_ASSET_NAME  FROM RWS_ASSET_TYPE_TBL WHERE ORDER BY TYPE_OF_ASSET_CODE";
			for (complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query); complaintMasterData.rs
					.next(); assettypes.add(compForm)) {
				compForm = new CompForm();
				compForm.setTypeofAsset(complaintMasterData.rs.getString(1));
				compForm.setTypeofAssetName(complaintMasterData.rs.getString(2));
				compForm.setCodeName(complaintMasterData.rs.getString(2) + " - " + complaintMasterData.rs.getString(1));
			}

		} catch (Exception exception) {
		} finally {
			complaintMasterData.closeAll();
		}
		return assettypes;
	}

	public static ArrayList getCategoryTypes1(DataSource dataSource) throws Exception {
		ArrayList categorytypes;
		categorytypes = new ArrayList();
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			String query = "SELECT DISTINCT CATEGORY_CODE,CATEGORY_NAME  FROM RWS_COMPLAINTS_CATEGORY_TBL WHERE ORDER BY CATEGORY_CODE";
			for (complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query); complaintMasterData.rs
					.next(); categorytypes.add(compForm)) {
				compForm = new CompForm();
				compForm.setCategory(complaintMasterData.rs.getString(1));
				compForm.setCategoryCode(complaintMasterData.rs.getString(2));
				compForm.setCategoryName(
						complaintMasterData.rs.getString(2) + " - " + complaintMasterData.rs.getString(1));
			}

		} catch (Exception e) {
			System.out.println("The Exception in getCategoryTypes ==in==  CompForm " + e);
		} finally {
			complaintMasterData.closeAll();
		}
		return categorytypes;
	}

	//
	public static ArrayList getCategoryTypes(String typeofAsset, String compCode) throws Exception {
		ArrayList categorytypes;
		categorytypes = new ArrayList();
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();

		LabelValueBean compForm = null;
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt1 = complaintMasterData.conn.createStatement();
			// String query = "SELECT DISTINCT category_code,category_name FROM
			// RWS_complaints_category_tbl ORDER BY category_code";
			// String query="Select Distinct com_category_code ,comp_cat_name from
			// rws_complaint_category_tbl where type_of_asset='"+typeofAsset+"' and
			// comp_code='"+compCode+"' order by com_category_code";
			String query = "select category_code,category_name from rws_complaint_category_tbl where TYPE_OF_ASSET_CODE='"
					+ typeofAsset + "' ";
			complaintMasterData.rs1 = complaintMasterData.stmt1.executeQuery(query);
			while (complaintMasterData.rs1.next()) {
				compForm = new LabelValueBean();
				compForm.setValue(complaintMasterData.rs1.getString(1));
				compForm.setLabel(complaintMasterData.rs1.getString(2));
				compForm.setLabelValue(
						complaintMasterData.rs1.getString(2) + " - " + complaintMasterData.rs1.getString(1));
				categorytypes.add(compForm);

			}
		} catch (Exception exception) {
		} finally {
			complaintMasterData.closeAll();
		}
		return categorytypes;
	}

	//
	public static ArrayList getCategoryTypes(String typeofAsset) throws Exception {
		ArrayList categorytypes;
		categorytypes = new ArrayList();
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			// String query = "SELECT DISTINCT category_code,category_name FROM
			// RWS_complaints_category_tbl ORDER BY category_code";
			String query = "Select Distinct com_category_code ,comp_cat_name from rws_complaint_category_tbl where type_of_asset='"
					+ typeofAsset + "'  order by com_category_code";
			for (complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query); complaintMasterData.rs
					.next(); categorytypes.add(compForm)) {
				compForm = new CompForm();
				compForm.setCategoryCode(complaintMasterData.rs.getString(1));
				compForm.setCategoryName(complaintMasterData.rs.getString(2).toLowerCase());
				compForm.setCodeName(complaintMasterData.rs.getString(2) + " - " + complaintMasterData.rs.getString(1));
			}

		} catch (Exception exception) {
		} finally {
			complaintMasterData.closeAll();
		}
		return categorytypes;
	}

	//
	public static String getCpcode(String complaintno) throws Exception {
		String code = "";

		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		PreparedStatement pst = null;
		try {
			complaintMasterData.conn = RwsOffices.getConn();

			// String query = "SELECT DISTINCT category_code,category_name FROM
			// RWS_complaints_category_tbl ORDER BY category_code";
			String query = "Select Distinct comp_code from rws_complaints_register_tbl where complaint_no=? ";
			pst = complaintMasterData.conn.prepareStatement(query);
			pst.setString(1, complaintno);
			complaintMasterData.rs = pst.executeQuery();
			while (complaintMasterData.rs.next()) {
				compForm = new CompForm();
				code = complaintMasterData.rs.getString(1);
			}

		} catch (Exception e) {
			System.out.println("exception in getCpcode -- " + e);
		} finally {
			complaintMasterData.closeAll();
			pst.close();
		}
		return code;
	}

	//

	public static ArrayList getComplaintprint(String complaintno, DataSource dataSource) throws Exception {
		ArrayList complaintprint;
		complaintprint = new ArrayList();
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			String query = "SELECT complaint_no,NVL(INWARD_NO,'-'),to_char(complaint_date,'dd/mm/yyyy'),complaint_desc,decode(category_code,'01','LEAKING','02','PUMP DAMAGED')RESULT,B.REP_NAME,NAME,ADDRESS,c.dname,c.mname,c.pname,c.panch_name from rws_complaints_register_tbl A ,RWS_PUBLIC_REP_TBL B,rws_complete_hab_view c where c.panch_code=substr(a.component_code,1,16) and B.REP_CODE=A.REP_CODE AND  complaint_no='"
					+ complaintno + "'";

			for (complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query); complaintMasterData.rs
					.next(); complaintprint.add(compForm)) {
				compForm = new CompForm();
				compForm.setDistrictName(complaintMasterData.rs.getString(9));
				compForm.setMandalName(complaintMasterData.rs.getString(10));
				compForm.setPanchayatName(complaintMasterData.rs.getString(11));
				compForm.setHabName(complaintMasterData.rs.getString(12));
				compForm.setComplntno(complaintMasterData.rs.getString(1));
				compForm.setInwardNo(complaintMasterData.rs.getString(2));
				compForm.setComplntdt(complaintMasterData.rs.getString(3));
				compForm.setComplntdesc(complaintMasterData.rs.getString(4));
				compForm.setCategoryName(complaintMasterData.rs.getString(5));
				compForm.setRepName(complaintMasterData.rs.getString(6));
				compForm.setName(complaintMasterData.rs.getString(7));
				compForm.setAddress(complaintMasterData.rs.getString(8));
			}

		} catch (Exception exception) {
		} finally {
			complaintMasterData.closeAll();
		}
		return complaintprint;
	}

	public ArrayList getTypeAssetTypes(String dcode, String mcode, String pcode, DataSource dataSource)
			throws Exception {
		ArrayList assets;
		assets = new ArrayList();
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		LabelValueBean compForm = null;
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			String query = "SELECT DISTINCT type_of_asset_code,type_of_asset_name  FROM RWS_ASSET_TYPE_TBL,rws_complaints_register_tbl c  where substr(complaint_no,7,2)=type_of_asset_code and substr(complaint_no,1,2)='"
					+ dcode + "' and substr(complaint_no,3,2)='" + mcode + "' and substr(complaint_no,5,2)='" + pcode
					+ "'  ORDER BY TYPE_OF_ASSET_CODE";
			
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			while (complaintMasterData.rs.next()) {
				compForm = new LabelValueBean();
				compForm.setValue(complaintMasterData.rs.getString(1));
				compForm.setLabel(complaintMasterData.rs.getString(2));
				compForm.setLabelValue(complaintMasterData.rs.getString(2) + "-" + complaintMasterData.rs.getString(1));
				assets.add(compForm);
			}

		} catch (Exception exception) {
		} finally {
			complaintMasterData.closeAll();
		}
		return assets;
	}

	public static CompForm getComplaintnoout(String complaintno, DataSource dataSource) throws Exception {
		CompForm compForm;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		compForm = null;
		try {
			
			String query = "select distinct c.complaint_no,to_char(c.complaint_date,'dd/mm/yyyy'),c.complaint_desc,z.type_of_asset_name,d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,pr.panch_code,pr.panch_name,c.category_code,c.name,c.address,c.rep_code,c.phone_no,t.type_of_asset_code from rws_complaints_register_tbl c,rws_district_tbl d,rws_asset_mast_tbl t,rws_habitation_directory_tbl h,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl pr,rws_asset_type_tbl z where z.type_of_asset_code=t.type_of_asset_code and c.complaint_no='"
					+ complaintno + "'  "
					+ " and d.dcode=substr(c.component_code,1,2) and t.asset_code=c.asset_code and d.dcode=substr(c.component_code,1,2) and    "
					+ " m.mcode=substr(c.Component_code,6,2) and p.pcode=substr(c.component_code,13,2) and pr.panch_code=substr(c.component_code,1,16) and "
					+ " d.dcode=m.dcode and " + " d.dcode=p.dcode and " + " m.mcode=p.mcode and "
					+ " h.hab_code=pr.panch_code and " + " substr(h.hab_code,1,2)=d.dcode and "
					+ " substr(h.hab_code,6,2)=m.mcode and " + " substr(h.hab_code,13,2)=p.pcode and "
					+ " t.asset_code=c.asset_code  ";
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			if (complaintMasterData.rs.next()) {
				compForm = new CompForm();
				compForm.setAsset(complaintMasterData.rs.getString(18));
				compForm.setComplntno(complaintMasterData.rs.getString(1));
				compForm.setComplntdt(complaintMasterData.rs.getString(2));
				compForm.setComplntdesc(complaintMasterData.rs.getString(3));
				compForm.setDistrictName(complaintMasterData.rs.getString(6));
				compForm.setMandalName(complaintMasterData.rs.getString(8));
				compForm.setPanchayatName(complaintMasterData.rs.getString(10));
				compForm.setHabName(complaintMasterData.rs.getString(12));
				compForm.setCategory(complaintMasterData.rs.getString(13));
				compForm.setName(complaintMasterData.rs.getString(14));
				compForm.setAddress(complaintMasterData.rs.getString(15));
				compForm.setRepCode(complaintMasterData.rs.getString(16));
				compForm.setPhoneNo(complaintMasterData.rs.getString(17));
				// compForm.setInwardNo(complaintMasterData.rs.getString(18));
				compForm.setAssetName(complaintMasterData.rs.getString(4));
			}
		} catch (Exception e) {
			Debug.println("The error in getQual=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return compForm;
	}

	//
	public static CompForm getComplaintnooutgeneric(String complaintno, DataSource dataSource) throws Exception {
		CompForm compForm;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		compForm = null;
		PreparedStatement pst = null;
		try {

			String query = "select distinct c.complaint_no,to_char(c.complaint_date,'dd/mm/yyyy'),c.complaint_desc,d.dcode,d.dname,d.mcode,d.mname,"
					+ "d.pcode,d.pname,d.panch_code,d.panch_name,c.name,c.address,c.rep_code,c.phone_no,c.component_name,EMAILID,"
					+ "GRIEVANCE_ENTRY_CATEGORY,GRIEVANCE_RELATED_TO,GRIEVANCE_CATEGORY from "
					+ "RWS_GENERIC_COMPLAINTS_REG_tbl c,rws_complete_hab_view d where substr(complaint_no,1,2)=d.dcode and "
					+ "c.complaint_no=? ";
			complaintMasterData.conn = RwsOffices.getConn();

			pst = complaintMasterData.conn.prepareStatement(query);
			pst.setString(1, complaintno);
			complaintMasterData.rs = pst.executeQuery();
			if (complaintMasterData.rs.next()) {
				compForm = new CompForm();

				compForm.setComplntno(complaintMasterData.rs.getString(1));
				compForm.setComplntdt(complaintMasterData.rs.getString(2));
				compForm.setComplntdesc(complaintMasterData.rs.getString(3));
				compForm.setDistrictName(complaintMasterData.rs.getString(5));
				compForm.setMandalName(complaintMasterData.rs.getString(7));
				compForm.setPanchayatName(complaintMasterData.rs.getString(9));
				compForm.setHabName(complaintMasterData.rs.getString(11));

				compForm.setName(complaintMasterData.rs.getString(12));
				compForm.setAddress(complaintMasterData.rs.getString(13));
				compForm.setRepCode(complaintMasterData.rs.getString(14));
				compForm.setPhoneNo(complaintMasterData.rs.getString(15));

				compForm.setComponentName(complaintMasterData.rs.getString("component_name"));
				compForm.setEmailId(complaintMasterData.rs.getString("EMAILID"));
				compForm.setGrievanceEntryCategory(complaintMasterData.rs.getString("GRIEVANCE_ENTRY_CATEGORY"));
				compForm.setGrievanceRelatedTo(complaintMasterData.rs.getString("GRIEVANCE_RELATED_TO"));
				compForm.setGrievanceCategory(complaintMasterData.rs.getString("GRIEVANCE_CATEGORY"));
			}
		} catch (Exception e) {
			System.out.println("The Exception in getComplaintnooutgeneric= " + e);
		} finally {
			complaintMasterData.closeAll();
		pst.close();
		}
		return compForm;
	}

	public static UrbanCompForm getUrbanComplaintnooutgeneric(String complaintno, DataSource dataSource)
			throws Exception {
		UrbanCompForm compForm;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		compForm = null;
		try {
			
			String query = "select distinct c.complaint_no,to_char(c.complaint_date,'dd/mm/yyyy'),c.complaint_desc,d.dcode,d.dname,d.mcode,d.mname,d.pcode,d.pname,d.panch_code,d.panch_name,c.name,c.address,c.rep_code,c.phone_no,c.component_name,EMAILID,GRIEVANCE_ENTRY_CATEGORY,GRIEVANCE_RELATED_TO,GRIEVANCE_CATEGORY from RWS_GENERIC_COMPLAINTS_REG_tbl c,rws_complete_hab_view d where substr(complaint_no,1,2)=d.dcode and c.complaint_no='"
					+ complaintno + "'";
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			if (complaintMasterData.rs.next()) {
				compForm = new UrbanCompForm();

				compForm.setComplntno(complaintMasterData.rs.getString(1));
				compForm.setComplntdt(complaintMasterData.rs.getString(2));
				compForm.setComplntdesc(complaintMasterData.rs.getString(3));
				compForm.setDistrictName(complaintMasterData.rs.getString(5));
				compForm.setMandalName(complaintMasterData.rs.getString(7));
				compForm.setPanchayatName(complaintMasterData.rs.getString(9));
				compForm.setHabName(complaintMasterData.rs.getString(11));

				compForm.setName(complaintMasterData.rs.getString(12));
				compForm.setAddress(complaintMasterData.rs.getString(13));
				compForm.setRepCode(complaintMasterData.rs.getString(14));
				compForm.setPhoneNo(complaintMasterData.rs.getString(15));

				compForm.setComponentName(complaintMasterData.rs.getString("component_name"));
				compForm.setEmailId(complaintMasterData.rs.getString("EMAILID"));
				compForm.setGrievanceEntryCategory(complaintMasterData.rs.getString("GRIEVANCE_ENTRY_CATEGORY"));
				compForm.setGrievanceRelatedTo(complaintMasterData.rs.getString("GRIEVANCE_RELATED_TO"));
				compForm.setGrievanceCategory(complaintMasterData.rs.getString("GRIEVANCE_CATEGORY"));
			}
		} catch (Exception e) {
			Debug.println("The error in getQual=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return compForm;
	}

	public static String insertUrbanComplaintgeneric(UrbanCompForm frm, String targetPath, ActionServlet actionServlet,
			String userid) throws Exception {
		String districtCode = frm.getUrbandist();
		String mandalCode = frm.getUrbanmand();

		int rowCount;
		String message = "";
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		rowCount = 0;
		PreparedStatement preparedStatement = null;
		Connection conn = null;
		try {

			FileOutputStream outputStream = null;
			FormFile formFile = null;
			FileInputStream fis = null;
			File scannedFile = null;
			File targetFile = null;

			String complaintno = frm.getComplntno();
			String date = frm.getComplntdt();
			String desc = frm.getComplntdesc();
			String givenby = frm.getRepCode();
			String name = frm.getName();
			String address = frm.getAddress();
			String phone = frm.getPhoneNo();
			String componentname = frm.getComponentName();
			if (districtCode.length() == 1)
				districtCode = "0" + districtCode;
			if (mandalCode.length() == 1)
				mandalCode = "0" + mandalCode;
			String habitationcode = frm.getLocalCode();
			String grievanceRelatedTo = frm.getGrievanceRelatedTo();
			String grievanceCategory = frm.getGrievanceCategory();
			String email = frm.getEmailId();
			String grievanceEntryCategory = frm.getGrievanceEntryCategory();
			String query = "";
			conn = RwsOffices.getConn();
			/* complaintMasterData.stmt = complaintMasterData.conn.createStatement(); */
			formFile = frm.getUploadGrievance();

			if (formFile.getFileName() == null || formFile.getFileName().equals("")) {
				query = "insert into RWS_generic_COMPLAINTS_REG_TBL(COMPLAINT_NO,COMPLAINT_DATE,COMPLAINT_DESC,REP_CODE,NAME,ADDRESS,PHONE_NO,habitation_code,grievance_related_to,grievance_Category,emailId,GRIEVANCE_ENTRY_CATEGORY,USER_ID,URBAN_WATER) values (?,to_date(?,'dd/mm/yyyy'),?,?,?,?,?,?,?,?,?,?,?,'U')";
			} else {

				query = "insert into RWS_generic_COMPLAINTS_REG_TBL(COMPLAINT_NO,COMPLAINT_DATE,COMPLAINT_DESC,REP_CODE,NAME,ADDRESS,PHONE_NO,habitation_code,grievance_related_to,grievance_Category,emailId,GRIEVANCE_ENTRY_CATEGORY,UPLOADGRIEVANCE,USER_ID,URBAN_WATER) values (?,to_date(?,'dd/mm/yyyy'),?,?,?,?,?,?,?,?,?,?,?,?,'U')";
			}
			preparedStatement = conn.prepareStatement(query);
			preparedStatement.setString(1, complaintno);
			preparedStatement.setString(2, date);
			preparedStatement.setString(3, desc.toUpperCase());
			preparedStatement.setString(4, givenby);
			preparedStatement.setString(5, name.toUpperCase());
			preparedStatement.setString(6, address.toUpperCase());
			preparedStatement.setString(7, phone);
			preparedStatement.setString(8, habitationcode);
			preparedStatement.setString(9, grievanceRelatedTo);
			preparedStatement.setString(10, grievanceCategory);
			preparedStatement.setString(11, email);
			preparedStatement.setString(12, grievanceEntryCategory);
			preparedStatement.setString(13, userid);
			if (formFile.getFileName() == null || formFile.getFileName().equals("")) {
			} else {
				try {
					
					String mimeType= URLConnection.guessContentTypeFromName(formFile.getFileName());
					if(!mimeType.equalsIgnoreCase("image/jpeg"))
					{
						message="Allowed only jpg file extensions only.";
						return message;
					}
					/*else
					{
						System.out.println("$$$$$$$$$$$$$$$$$$$");
					}*/
					
					String path = actionServlet.getServletContext().getRealPath("") + File.separator
							+ formFile.getFileName();
					
					scannedFile = new File(path);
					outputStream = new FileOutputStream(scannedFile);
					if (outputStream != null) {
						outputStream.write(formFile.getFileData());
					}

					targetFile = new File(targetPath);

					compressImage(scannedFile, targetFile);

					fis = new FileInputStream(targetFile);
					if (fis != null) {
					}

				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					if (fis != null) {
						// fis.close();
					}
				}

				double fileSizeMB = ((frm.getUploadGrievance().getFileSize() / 1024.0) / 1024.0);

				if (fileSizeMB > 0.2) {
					message = "Scanned Copy File Size Shoud Not Be Allowed More Than 200 KB";
					conn.setAutoCommit(true);
					scannedFile.delete();
					outputStream.close();
					targetFile.delete();
					return message;

				}
				preparedStatement.setBinaryStream(13, fis, (int) targetFile.length());

				if (scannedFile != null) {
					scannedFile.delete();

				}
				if (targetFile != null) {
					targetFile.delete();
				}
				if (outputStream != null) {
					// outputStream.close();
				}
				if (fis != null) {
					// fis.close();
				}

			}
			rowCount = preparedStatement.executeUpdate();
			String co = frm.getComplntno();
			if (rowCount < 1) {
				message = "Record Can't be inserted";
			} else {
				message = "Your Complaint is Registered with Complaint Number : " + co;


			}
		}

		catch (Exception e) {
			e.printStackTrace();
		} finally {
			complaintMasterData.closeAll();
			
		}
		return message;
	}

	public static int updateUrbanComplaintnooutgeneric(UrbanCompForm compForm, String complaintno,
			DataSource dataSource) throws Exception {
		int ans;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		ans = 0;
		try {
			
			complaintMasterData.conn = RwsOffices.getConn();
			String query = "update  RWS_GENERIC_COMPLAINTS_REG_TBL  set complaint_desc=?,"
					     + "complaint_date=to_date(?,'dd/mm/yyyy'),rep_code=?,name=?,"
					     + "address=?,phone_no=?,GRIEVANCE_ENTRY_CATEGORY=?," 
					     + "GRIEVANCE_RELATED_TO= ?,GRIEVANCE_CATEGORY=?," 
					     + "EMAILID=?  where complaint_no=? ";
			
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			PreparedStatement ps=complaintMasterData.conn.prepareStatement(query);  
			ps.setString(1, compForm.getComplntdesc().toUpperCase() );
			ps.setString(2,compForm.getComplntdt());
			ps.setString(3, compForm.getRepCode());
			ps.setString(4, compForm.getName().toUpperCase());
			ps.setString(5, compForm.getAddress().toUpperCase());
			ps.setString(6, compForm.getPhoneNo());
			ps.setString(7, compForm.getGrievanceEntryCategory());
			ps.setString(8, compForm.getGrievanceRelatedTo());
			ps.setString(9, compForm.getGrievanceCategory());
			/*ps.setString(10, compForm.getGrievanceRelatedTo() );
			ps.setString(11, compForm.getGrievanceCategory());*/
			ps.setString(10, compForm.getEmailId());
			ps.setString(11, complaintno);
			ans = ps.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			Debug.println("The error in updateQual " + sqle);
		} catch (Exception e) {
			Debug.println("The error in updatecomplaint" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return ans;
	}

	//
	public static CompForm getComplaintno(String complaintno, DataSource dataSource) throws Exception {
		CompForm compForm;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		compForm = null;
		try {
			
			String query = "select distinct c.complaint_no,to_char(c.complaint_date,'dd/mm/yyyy'),c.complaint_desc,z.type_of_asset_name,d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,pr.panch_code,pr.panch_name,c.category_code,c.name,c.address,c.rep_code,c.phone_no,c.inward_no,t.type_of_asset_code from rws_complaints_register_tbl c,rws_district_tbl d,rws_asset_mast_tbl t,rws_habitation_directory_tbl h,rws_mandal_tbl m,rws_panchayat_tbl p,rws_panchayat_raj_tbl pr,rws_asset_type_tbl z where z.type_of_asset_code=t.type_of_asset_code and c.complaint_no='"
					+ complaintno + "'  "
					+ " and d.dcode=substr(c.component_code,1,2) and t.asset_code=c.asset_code and d.dcode=substr(c.component_code,1,2) and    "
					+ " m.mcode=substr(c.Component_code,6,2) and p.pcode=substr(c.component_code,13,2) and pr.panch_code=substr(c.component_code,1,16) and "
					+ " d.dcode=m.dcode and " + " d.dcode=p.dcode and " + " m.mcode=p.mcode and "
					+ " h.hab_code=pr.panch_code and " + " substr(h.hab_code,1,2)=d.dcode and "
					+ " substr(h.hab_code,6,2)=m.mcode and " + " substr(h.hab_code,13,2)=p.pcode and "
					+ " t.asset_code=c.asset_code  ";
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			if (complaintMasterData.rs.next()) {
				compForm = new CompForm();
				compForm.setAsset(complaintMasterData.rs.getString(19));
				compForm.setComplntno(complaintMasterData.rs.getString(1));
				compForm.setComplntdt(complaintMasterData.rs.getString(2));
				compForm.setComplntdesc(complaintMasterData.rs.getString(3));
				compForm.setDistrictName(complaintMasterData.rs.getString(6));
				compForm.setMandalName(complaintMasterData.rs.getString(8));
				compForm.setPanchayatName(complaintMasterData.rs.getString(10));
				compForm.setHabName(complaintMasterData.rs.getString(12));
				compForm.setCategory(complaintMasterData.rs.getString(13));
				compForm.setName(complaintMasterData.rs.getString(14));
				compForm.setAddress(complaintMasterData.rs.getString(15));
				compForm.setRepCode(complaintMasterData.rs.getString(16));
				compForm.setPhoneNo(complaintMasterData.rs.getString(17));
				compForm.setInwardNo(complaintMasterData.rs.getString(18));
				compForm.setAssetName(complaintMasterData.rs.getString(4));
			}
		} catch (Exception e) {
			Debug.println("The error in getQual=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return compForm;
	}

	//

	public static int updateComplaintno(CompForm compForm, String complaintno, DataSource dataSource) throws Exception {
		int ans;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		ans = 0;
		try {
			
			complaintMasterData.conn = RwsOffices.getConn();
			String query = "update  RWS_COMPLAINTS_REGISTER_TBL  set complaint_desc=?,"
					   +  "complaint_date=to_date(?,'dd/mm/yyyy'),category_code=? ,"
					   + "rep_code=?,name=?,address=? ,phone_no=?," 
					   + "inward_no=?  where complaint_no=? ";
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			PreparedStatement pst= complaintMasterData.conn.prepareStatement(query);
			pst.setString(1, compForm.getComplntdesc().toUpperCase());
			pst.setString(2, compForm.getComplntdt());
			pst.setString(3, compForm.getCategory());
			pst.setString(4, compForm.getRepCode());
			pst.setString(5, compForm.getName().toUpperCase());
			pst.setString(6, compForm.getAddress().toUpperCase());
			pst.setString(7, compForm.getPhoneNo());
			pst.setString(8,  compForm.getInwardNo());
			pst.setString(9,complaintno );
			ans =pst.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			Debug.println("The error in updateQual " + sqle);
		} catch (Exception e) {
			Debug.println("The error in updatecomplaint" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return ans;
	}

	//
	public static int updateComplaintnooutgeneric(CompForm compForm, String complaintno, DataSource dataSource)
			throws Exception {
		int ans;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		ans = 0;
		PreparedStatement pst = null;
		try {

			complaintMasterData.conn = RwsOffices.getConn();

			String query = "update  RWS_GENERIC_COMPLAINTS_REG_TBL  set complaint_desc=?,complaint_date=to_date(?,'dd/mm/yyyy')"
					+ ",rep_code=?,name=? ,address=?,phone_no=?,GRIEVANCE_ENTRY_CATEGORY=?,GRIEVANCE_RELATED_TO=?"
					+ ",GRIEVANCE_CATEGORY=?,EMAILID=? where complaint_no=? ";

			pst = complaintMasterData.conn.prepareStatement(query);
			pst.setString(1, compForm.getComplntdesc().toUpperCase());
			pst.setString(2, compForm.getComplntdt());
			pst.setString(3, compForm.getRepCode());
			pst.setString(4, compForm.getName().toUpperCase());
			pst.setString(5, compForm.getAddress().toUpperCase());
			pst.setString(6, compForm.getPhoneNo());
			pst.setString(7, compForm.getGrievanceEntryCategory());
			pst.setString(8, compForm.getGrievanceRelatedTo());
			pst.setString(9, compForm.getGrievanceCategory());
			pst.setString(10, compForm.getEmailId());
			pst.setString(11, complaintno);

			ans = pst.executeUpdate();

		} catch (Exception e) {

			System.out.println("The Exception in updateComplaintnooutgeneric -- " + e);
		} finally {
			complaintMasterData.closeAll();

		}
		return ans;
	}

	//

	public static int updateComplaintnoout(CompForm compForm, String complaintno, DataSource dataSource)
			throws Exception {
		int ans;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		ans = 0;
		try {
			
			complaintMasterData.conn = RwsOffices.getConn();
			String query = "update  RWS_COMPLAINTS_REGISTER_TBL  set complaint_desc=?,"
					+ "complaint_date=to_date(?,'dd/mm/yyyy'),category_code=?," 
					+ "rep_code=?,name=?,address=?,phone_no=?"
					+ " where complaint_no=?";
					
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			PreparedStatement ps= complaintMasterData.conn.prepareStatement(query);
			ps.setString(1,compForm.getComplntdesc().toUpperCase()); 
			ps.setString(2,compForm.getComplntdt()); 
			ps.setString(3,compForm.getCategory()); 
			ps.setString(4,compForm.getRepCode()); 
			ps.setString(5,compForm.getName().toUpperCase()); 
			ps.setString(6, compForm.getAddress().toUpperCase()); 
			ps.setString(7,compForm.getPhoneNo()); 
			ps.setString(8,complaintno); 
			ans = ps.executeUpdate();
		} catch (SQLException sqle) {
			if (sqle.getErrorCode() == 1)
				errorMessage = "Record with this name exists.";
			Debug.println("The error in updateComplaint " + sqle);
		} catch (Exception e) {
			Debug.println("The error in updatecomplaint" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return ans;
	}

	// code modified byu sridhar
	public static ArrayList getComplaintsattended(String Habcode, DataSource dataSource) throws Exception {
		ArrayList complaintsalist;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		complaintsalist = new ArrayList();
		String query = "";
		String dist = null;
		String man = null;
		String pan = null;
		String vill = null;
		String hcode = null;
		try {
			dist = Habcode.substring(0, 2);
			
			man = Habcode.substring(5, 7);
			pan = Habcode.substring(12, 14);
			hcode = Habcode.substring(10, 12);
			vill = Habcode.substring(7, 10);
			
			
		} catch (Exception p) {
			p.printStackTrace();
		}
		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			// query = "select distinct
			// a.component_code,a.complaint_no,a.attended_by,to_char(a.attended_date,'dd/mm/yyyy'),a.complaint_status,a.remarks,b.asset_name,to_char(a.complaint_date,'dd/mm/yyyy'),a.complaint_desc,decode(a.category_code,'01','LEAKING','02','PUMP
			// DAMAGED')result,p.rep_name,a.name,a.address from rws_complaints_register_tbl
			// a,rws_asset_mast_tbl b,rws_public_rep_tbl p where p.rep_code=a.rep_code and
			// b.asset_code=a.asset_code and a.complaint_status is not null and
			// substr(a.component_code,1,2)='" + dist + "' and
			// substr(a.component_code,6,2)='" + man + "' and
			// substr(a.component_code,13,2)='" + pan + "' and
			// substr(a.component_code,8,3)='" + vill + "' and
			// substr(a.component_code,11,2)='" + hcode + "' order by a.complaint_no ";
			query = "select  distinct a.component_code,a.complaint_no,a.attended_by,to_char(a.attended_date,'dd/mm/yyyy'),a.complaint_status,a.remarks,b.asset_name,to_char(a.complaint_date,'dd/mm/yyyy'),nvl(a.complaint_desc,'-'),comp_cat_name,p.rep_name,a.name,a.address  from rws_complaints_register_tbl a,rws_asset_mast_tbl b,rws_public_rep_tbl p,rws_complaint_category_tbl c where p.rep_code=a.rep_code and    b.asset_code=a.asset_code and a.category_code=c.com_category_code  and a.comp_code=c.comp_code and b.type_of_asset_code=c.type_of_asset and a.complaint_status is not null and substr(a.component_code,1,2)='"
					+ dist + "' and substr(a.component_code,6,2)='" + man + "' and substr(a.component_code,13,2)='"
					+ pan + "' and substr(a.component_code,8,3)='" + vill + "' and substr(a.component_code,11,2)='"
					+ hcode + "'  order by a.complaint_no";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);

			for (; complaintMasterData.rs.next(); complaintsalist.add(compForm)) {
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs.getString(1));
				compForm.setComplntno(complaintMasterData.rs.getString(2));
				compForm.setAttenby(complaintMasterData.rs.getString(3));
				compForm.setAttendt(complaintMasterData.rs.getString(4));
				compForm.setStatus(complaintMasterData.rs.getString(5));
				compForm.setRemarksby(complaintMasterData.rs.getString(6));
				compForm.setAssetName(complaintMasterData.rs.getString(7));
				compForm.setComplntdt(complaintMasterData.rs.getString(8));
				compForm.setComplntdesc(complaintMasterData.rs.getString(9));
				compForm.setCategoryName(complaintMasterData.rs.getString(10));
				compForm.setRepName(complaintMasterData.rs.getString(11));
				compForm.setName(complaintMasterData.rs.getString(12));
				compForm.setAddress(complaintMasterData.rs.getString(13));
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return complaintsalist;
	}

	//
	public static ArrayList getComplaintsattendedgeneric(String Habcode, DataSource dataSource) throws Exception {
		ArrayList complaintsalist;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		complaintsalist = new ArrayList();
		String query = "";
		String dist = null;
		String man = null;
		String pan = null;
		String vill = null;
		String hcode = null;
		try {
			dist = Habcode.substring(0, 2);
			
			man = Habcode.substring(5, 7);
			pan = Habcode.substring(12, 14);
			hcode = Habcode.substring(10, 12);
			vill = Habcode.substring(7, 10);
			
			
		} catch (Exception p) {
			p.printStackTrace();
		}
		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			// query = "select distinct
			// a.component_code,a.complaint_no,a.attended_by,to_char(a.attended_date,'dd/mm/yyyy'),a.complaint_status,a.remarks,b.asset_name,to_char(a.complaint_date,'dd/mm/yyyy'),a.complaint_desc,decode(a.category_code,'01','LEAKING','02','PUMP
			// DAMAGED')result,p.rep_name,a.name,a.address from rws_complaints_register_tbl
			// a,rws_asset_mast_tbl b,rws_public_rep_tbl p where p.rep_code=a.rep_code and
			// b.asset_code=a.asset_code and a.complaint_status is not null and
			// substr(a.component_code,1,2)='" + dist + "' and
			// substr(a.component_code,6,2)='" + man + "' and
			// substr(a.component_code,13,2)='" + pan + "' and
			// substr(a.component_code,8,3)='" + vill + "' and
			// substr(a.component_code,11,2)='" + hcode + "' order by a.complaint_no ";
			query = "select  distinct a.component_name,a.complaint_no,a.attended_by,to_char(a.attended_date,'dd/mm/yyyy'),a.complaint_status,a.remarks,to_char(a.complaint_date,'dd/mm/yyyy'),nvl(a.complaint_desc,'-'),p.rep_name,a.name,a.address  from rws_generic_complaints_reg_tbl a,rws_public_rep_tbl p where p.rep_code=a.rep_code and    a.complaint_status is not null and substr(a.habitation_code,1,2)='"
					+ dist + "' and substr(a.habitation_code,6,2)='" + man + "' and substr(a.habitation_code,13,2)='"
					+ pan + "' and substr(a.habitation_code,8,3)='" + vill + "' and substr(a.habitation_code,11,2)='"
					+ hcode + "'  order by a.complaint_no";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);

			while (complaintMasterData.rs.next()) {

				compForm = new CompForm();
				compForm.setComponentName(complaintMasterData.rs.getString(1));
				compForm.setComplntno(complaintMasterData.rs.getString(2));
				compForm.setAttenby(complaintMasterData.rs.getString(3));
				compForm.setAttendt(complaintMasterData.rs.getString(4));
				compForm.setStatus(complaintMasterData.rs.getString(5));
				compForm.setRemarksby(complaintMasterData.rs.getString(6));
				compForm.setComplntdt(complaintMasterData.rs.getString(7));
				compForm.setComplntdesc(complaintMasterData.rs.getString(8));

				compForm.setRepName(complaintMasterData.rs.getString(9));
				compForm.setName(complaintMasterData.rs.getString(10));
				compForm.setAddress(complaintMasterData.rs.getString(11));
				complaintsalist.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return complaintsalist;
	}

	//

	public static ArrayList getComplaintsattendedlist(String Habcode, String fdate, String tdate, DataSource dataSource)
			throws Exception {
		ArrayList complaintsalist;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		complaintsalist = new ArrayList();
		String dist = Habcode.substring(0, 2);
		
		String man = Habcode.substring(5, 7);
		String pan = Habcode.substring(12, 14);
		String vill = Habcode.substring(7, 10);
		String hcode = Habcode.substring(10, 12);
		
		String query = "";
		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			// query = "select distinct
			// a.component_code,to_char(a.complaint_date,'dd/mm/yyyy'),a.complaint_no,a.attended_by,to_char(a.attended_date,'dd/mm/yyyy'),a.complaint_status,a.remarks,nvl(b.asset_name,'-'),a.complaint_desc,decode(a.category_code,'01','LEAKING','02','PUMP
			// DAMAGED')result,p.rep_name,a.name,a.address from rws_complaints_register_tbl
			// a,rws_asset_mast_tbl b,rws_public_rep_tbl p where p.rep_code=a.rep_code and
			// a.complaint_status is not null and a.attended_date BETWEEN to_date('" + fdate
			// + "','dd/mm/yyyy') AND to_date('" + tdate + "','dd/mm/yyyy') and
			// substr(a.component_code,1,2)='" + dist + "' and
			// substr(a.component_code,11,2)='" + hcode + "' and
			// substr(a.component_code,6,2)='" + man + "' and
			// substr(a.component_code,13,2)='" + pan + "' and
			// substr(a.component_code,8,3)='" + vill + "' and
			// substr(a.component_code,11,2)='" + hcode + "' and a.asset_code=b.asset_code
			// order by a.complaint_no ";
			query = "select distinct a.component_code,to_char(a.complaint_date,'dd/mm/yyyy'),a.complaint_no,a.attended_by,to_char(a.attended_date,'dd/mm/yyyy'),a.complaint_status,a.remarks,nvl(b.asset_name,'-'),nvl(a.complaint_desc,'-'),comp_cat_name,p.rep_name,a.name,a.address   from rws_complaints_register_tbl a,rws_asset_mast_tbl b,rws_public_rep_tbl p,rws_complaint_category_tbl c where p.rep_code=a.rep_code and substr (a.component_code,1,2)='"
					+ dist + "' and substr(a.component_code,6,2)='" + man + "' and substr(a.component_code,13,2)='"
					+ pan + "' and substr (a.component_code,8,3)='" + vill + "'and  a.attended_date BETWEEN to_date('"
					+ fdate + "','dd/mm/yyyy') AND to_date('" + tdate
					+ "','dd/mm/yyyy') and a.asset_code=b.asset_code and a.complaint_status is not null  and a.comp_code=c.comp_code and a.category_code=c.com_category_code  and substr(a.asset_code,7,2)=type_of_asset  order by complaint_no ";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			
			for (; complaintMasterData.rs.next(); complaintsalist.add(compForm)) {
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs.getString(1));
				compForm.setComplntdt(complaintMasterData.rs.getString(2));
				compForm.setComplntno(complaintMasterData.rs.getString(3));
				compForm.setAttenby(complaintMasterData.rs.getString(4));
				compForm.setAttendt(complaintMasterData.rs.getString(5));
				compForm.setStatus(complaintMasterData.rs.getString(6));
				compForm.setAssetName(complaintMasterData.rs.getString(8));
				compForm.setRemarksby(complaintMasterData.rs.getString(7));
				compForm.setComplntdesc(complaintMasterData.rs.getString(9));
				compForm.setCategoryName(complaintMasterData.rs.getString(10));
				compForm.setRepName(complaintMasterData.rs.getString(11));
				compForm.setName(complaintMasterData.rs.getString(12));
				compForm.setAddress(complaintMasterData.rs.getString(13));
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return complaintsalist;
	}

	//
	public static ArrayList getComplaintsattendedlistgeneric(String Habcode, String fdate, String tdate,
			DataSource dataSource) throws Exception {
		ArrayList complaintsalist;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		complaintsalist = new ArrayList();
		String dist = Habcode.substring(0, 2);
		
		String man = Habcode.substring(5, 7);
		String pan = Habcode.substring(12, 14);
		String vill = Habcode.substring(7, 10);
		String hcode = Habcode.substring(10, 12);
		
		String query = "";
		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			// query = "select distinct
			// a.component_code,to_char(a.complaint_date,'dd/mm/yyyy'),a.complaint_no,a.attended_by,to_char(a.attended_date,'dd/mm/yyyy'),a.complaint_status,a.remarks,nvl(b.asset_name,'-'),a.complaint_desc,decode(a.category_code,'01','LEAKING','02','PUMP
			// DAMAGED')result,p.rep_name,a.name,a.address from rws_complaints_register_tbl
			// a,rws_asset_mast_tbl b,rws_public_rep_tbl p where p.rep_code=a.rep_code and
			// a.complaint_status is not null and a.attended_date BETWEEN to_date('" + fdate
			// + "','dd/mm/yyyy') AND to_date('" + tdate + "','dd/mm/yyyy') and
			// substr(a.component_code,1,2)='" + dist + "' and
			// substr(a.component_code,11,2)='" + hcode + "' and
			// substr(a.component_code,6,2)='" + man + "' and
			// substr(a.component_code,13,2)='" + pan + "' and
			// substr(a.component_code,8,3)='" + vill + "' and
			// substr(a.component_code,11,2)='" + hcode + "' and a.asset_code=b.asset_code
			// order by a.complaint_no ";
			query = "select distinct a.component_name,to_char(a.complaint_date,'dd/mm/yyyy'),a.complaint_no,a.attended_by,to_char(a.attended_date,'dd/mm/yyyy'),a.complaint_status,a.remarks,nvl(a.complaint_desc,'-'),p.rep_name,a.name,a.address   from rws_generic_complaints_reg_tbl a,rws_public_rep_tbl p where p.rep_code=a.rep_code and substr (a.habitation_code,1,2)='"
					+ dist + "' and substr(a.habitation_code,6,2)='" + man + "' and substr(a.habitation_code,13,2)='"
					+ pan + "' and substr (a.habitation_code,8,3)='" + vill + "'and  a.attended_date BETWEEN to_date('"
					+ fdate + "','dd/mm/yyyy') AND to_date('" + tdate
					+ "','dd/mm/yyyy')  and a.complaint_status is not null    order by complaint_no ";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			
			for (; complaintMasterData.rs.next(); complaintsalist.add(compForm)) {
				compForm = new CompForm();
				compForm.setComponentName(complaintMasterData.rs.getString(1));
				compForm.setComplntdt(complaintMasterData.rs.getString(2));
				compForm.setComplntno(complaintMasterData.rs.getString(3));
				compForm.setAttenby(complaintMasterData.rs.getString(4));
				compForm.setAttendt(complaintMasterData.rs.getString(5));
				compForm.setStatus(complaintMasterData.rs.getString(6));

				compForm.setRemarksby(complaintMasterData.rs.getString(7));
				compForm.setComplntdesc(complaintMasterData.rs.getString(8));

				compForm.setRepName(complaintMasterData.rs.getString(9));
				compForm.setName(complaintMasterData.rs.getString(10));
				compForm.setAddress(complaintMasterData.rs.getString(11));
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return complaintsalist;
	}

	//

	public static ArrayList getHpdetails(String asstcode, String sourcecode, String assetcode, DataSource dataSource)
			throws Exception {
		ArrayList complaints;
		CompForm compForm = null;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		complaints = new ArrayList();
		String query = "";
		try {
			if (asstcode.equals("04")) {
				query = "select distinct h.hp_code,nvl(h.location,'-'),nvl(h.diameter,'0'),decode(h.status,'S','Seasonal','D','Dried','W','Working','N','Not Working','C','Condemed','','-')result,decode(h.gen_condition,'G','Good','B','Bad','','-')result1,nvl(h.static_wl,'0'),nvl(h.summer_wl,'0'),nvl(h.drill_year,'-'),a.asset_code,a.asset_name from RWS_HP_SUBCOMP_PARAM_TBL h,rws_asset_mast_tbl a where a.asset_code=h.asset_code and h.hp_code='"
						+ sourcecode + "' and  a.type_of_asset_code='" + asstcode + "' and  h.asset_code='" + assetcode
						+ "'";
				complaintMasterData.conn = RwsOffices.getConn();
				complaintMasterData.stmt = complaintMasterData.conn.createStatement();
				complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
				
				if (complaintMasterData.rs.next()) {
					compForm = new CompForm();
					String s = complaintMasterData.rs.getString(8);
					if (s.equals("null")) {
						s = "-";
					} else {
						s = complaintMasterData.rs.getString(8);
					}
					compForm.setSourceCode(complaintMasterData.rs.getString(1));
					compForm.setLocation(complaintMasterData.rs.getString(2));
					compForm.setDiameterOfBorewell(complaintMasterData.rs.getString(3));
					compForm.setStatus(complaintMasterData.rs.getString(4));
					compForm.setCond(complaintMasterData.rs.getString(5));
					compForm.setStaticWaterLevel(complaintMasterData.rs.getString(6));
					compForm.setSummerWaterLevel(complaintMasterData.rs.getString(7));
					compForm.setDrillYear(s);
					compForm.setAssetCode(complaintMasterData.rs.getString(9));
					compForm.setAssetName(complaintMasterData.rs.getString(10));
					complaints.add(compForm);
				}
			}
		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return complaints;
	}
	//

	//

	public static ArrayList getPwsdetails(String sourcecode, String asst, String dist, String man, String pan,
			String assetcode, DataSource dataSource) throws Exception {
		ArrayList complaints;
		CompForm compForm = null;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		complaints = new ArrayList();
		try {
			compForm = new CompForm();
			String query1 = "select distinct c.component_code,nvl(b.location,'-'),c.asset_code,nvl(b.asset_name,'-') from rws_asset_mast_tbl b,rws_complaints_register_tbl c  where c.asset_code=b.asset_code  and   b.type_of_asset_code='"
					+ asst + "' and c.asset_code='" + assetcode + "' and   substr(component_code,1,2)='" + dist
					+ "' and substr(component_code,6,2)='" + man + "' and substr(component_code,13,2)='" + pan
					+ "' and c.complaint_no='" + sourcecode + "' ";
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt1 = complaintMasterData.conn.createStatement();
			complaintMasterData.rs1 = complaintMasterData.stmt1.executeQuery(query1);
			if (complaintMasterData.rs1.isBeforeFirst())
				for (; complaintMasterData.rs1.next(); complaints.add(compForm)) {
					compForm = new CompForm();
					compForm.setSourceCode(complaintMasterData.rs1.getString(1));
					
					compForm.setAssetLocation(complaintMasterData.rs1.getString(2));
					
					compForm.setAssetCode(complaintMasterData.rs1.getString(3));
					
					compForm.setAssetName(complaintMasterData.rs1.getString(4));
					
				}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return complaints;
	}

	//
	public static ArrayList getComplaintsAll(String dist, String mand, String panch, String asset, String from,
			String to, DataSource dataSource) throws Exception {
		ArrayList complaints;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		complaints = new ArrayList();
		String query = "";
		String s = null;
		try {
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select  distinct a.component_code,to_char(a.complaint_date,'dd/mm/yyyy'),a.complaint_no,nvl(a.attended_by,'-'),nvl(to_char(a.attended_date,'dd/mm/yyyy'),'-'),nvl(a.complaint_status,'-'),nvl(a.remarks,'-'),nvl(b.location,'-'),b.asset_name,a.asset_code,substr(a.component_code,1,2),substr(a.component_code,6,2),substr(a.component_code,13,2),b.type_of_asset_code  from rws_complaints_register_tbl a,rws_asset_mast_tbl b,rws_asset_scheme_tbl s where  s.asset_code=a.asset_code and substr(s.scheme_code,1,19)=substr(a.component_code,1,19) and   substr(a.component_code,1,2)='"
					+ dist + "' and substr(a.component_code,6,2)='" + mand + "' and substr(a.component_code,13,2)='"
					+ panch + "' and b.type_of_asset_code='" + asset + "' and complaint_date  between to_date('" + from
					+ "','dd/mm/yyyy')  and to_date('" + to
					+ "','dd/mm/yyyy')  and a.asset_code=b.asset_code  order by a.complaint_no ";
			
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);

			while (complaintMasterData.rs.next()) {
				if (complaintMasterData.rs.getString(6).equals("-")) {
					s = "Not Attended";
				} else {
					s = complaintMasterData.rs.getString(6);
				}
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs.getString(1));
				compForm.setComplntdt(complaintMasterData.rs.getString(2));
				compForm.setComplntno(complaintMasterData.rs.getString(3));
				compForm.setAttenby(complaintMasterData.rs.getString(4));
				compForm.setAttendt(complaintMasterData.rs.getString(5));
				compForm.setComplntstatus(s);
				compForm.setRemarksby(complaintMasterData.rs.getString(7));
				compForm.setAssetLocation(complaintMasterData.rs.getString(8));
				compForm.setAssetName(complaintMasterData.rs.getString(9));
				compForm.setAssetCode(complaintMasterData.rs.getString(10));
				compForm.setDist(complaintMasterData.rs.getString(11));
				compForm.setMand(complaintMasterData.rs.getString(12));
				compForm.setPanch(complaintMasterData.rs.getString(13));
				compForm.setTypeofAsset(complaintMasterData.rs.getString(14));
				complaints.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return complaints;
	}

	//
	public static ArrayList getComplaintsAllgeneric(String dist, String mand, String panch, String from, String to,
			DataSource dataSource) throws Exception {
		ArrayList complaints;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		complaints = new ArrayList();
		String query = "";
		try {
			
			
			String s = null;
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select  distinct a.component_name,to_char(a.complaint_date,'dd/mm/yyyy'),a.complaint_no,nvl(a.attended_by,'-'),nvl(to_char(a.attended_date,'dd/mm/yyyy'),'-'),nvl(a.complaint_status,'-'),nvl(a.remarks,'-'),substr(a.habitation_code,1,2),substr(a.habitation_code,6,2),substr(a.habitation_code,13,2)  from rws_generic_complaints_reg_tbl a where   substr(a.habitation_code,1,2)='"
					+ dist + "' and substr(a.habitation_code,6,2)='" + mand + "' and substr(a.habitation_code,13,2)='"
					+ panch + "'  and complaint_date  between to_date('" + from + "','dd/mm/yyyy')  and to_date('" + to
					+ "','dd/mm/yyyy')   order by a.complaint_no ";
			
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);

			while (complaintMasterData.rs.next()) {
				if (complaintMasterData.rs.getString(6).equals("-")) {
					s = "Not Attended";
				} else {
					s = complaintMasterData.rs.getString(6);
				}
				compForm = new CompForm();
				compForm.setComponentName(complaintMasterData.rs.getString(1));
				compForm.setComplntdt(complaintMasterData.rs.getString(2));
				compForm.setComplntno(complaintMasterData.rs.getString(3));
				compForm.setAttenby(complaintMasterData.rs.getString(4));
				compForm.setAttendt(complaintMasterData.rs.getString(5));
				compForm.setComplntstatus(s);
				compForm.setRemarksby(complaintMasterData.rs.getString(7));

				compForm.setDist(complaintMasterData.rs.getString(8));
				compForm.setMand(complaintMasterData.rs.getString(9));
				compForm.setPanch(complaintMasterData.rs.getString(10));

				complaints.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return complaints;
	}
	//

	//

	public static ArrayList getComplaintstotalAll(String dist, String mand, String panch, DataSource dataSource)
			throws Exception {
		ArrayList complaints;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		complaints = new ArrayList();
		String query = "";
		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select  distinct a.source_code,to_char(a.complaint_date,'dd/mm/yyyy'),a.complaint_no,nvl(a.attended_by,'-'),nvl(to_char(a.attended_date,'dd/mm/yyyy'),'-'),nvl(a.complaint_status,'-'),nvl(a.remarks,'-'),nvl(b.location,'-'),b.asset_name,substr(a.source_code,1,2),substr(a.source_code,6,2),substr(a.source_code,13,2),b.type_of_asset_code,a.asset_code  from rws_complaints_register_tbl a,rws_asset_mast_tbl b where   substr(a.source_code,1,2)='"
					+ dist + "' and substr(a.source_code,6,2)='" + mand + "' and substr(a.source_code,13,2)='" + panch
					+ "'  and a.asset_code=b.asset_code  order by a.complaint_no ";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			
			for (; complaintMasterData.rs.next(); complaints.add(compForm)) {
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs.getString(1));
				compForm.setComplntdt(complaintMasterData.rs.getString(2));
				compForm.setComplntno(complaintMasterData.rs.getString(3));
				compForm.setAttenby(complaintMasterData.rs.getString(4));
				compForm.setAttendt(complaintMasterData.rs.getString(5));
				compForm.setComplntstatus(complaintMasterData.rs.getString(6));
				compForm.setRemarksby(complaintMasterData.rs.getString(7));
				compForm.setAssetLocation(complaintMasterData.rs.getString(8));
				compForm.setAssetName(complaintMasterData.rs.getString(9));
				compForm.setDist(complaintMasterData.rs.getString(10));
				compForm.setMand(complaintMasterData.rs.getString(11));
				compForm.setPanch(complaintMasterData.rs.getString(12));
				compForm.setTypeofAsset(complaintMasterData.rs.getString(13));
				compForm.setAssetCode(complaintMasterData.rs.getString(14));
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return complaints;
	}

	public static ArrayList getComplaintsDistrictAll(String asset, DataSource dataSource) throws Exception {
		ArrayList complaints;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		complaints = new ArrayList();
		String query = "";
		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select  distinct a.component_code,to_char(a.complaint_date,'dd/mm/yyyy'),a.complaint_no,nvl(a.attended_by,'-'),nvl(to_char(a.attended_date,'dd/mm/yyyy'),'-'),nvl(a.complaint_status,'-'),nvl(a.remarks,'-'),nvl(b.location,'-'),b.asset_name,d.dcode,d.dname  from rws_complaints_register_tbl a,rws_asset_mast_tbl b,rws_asset_type_tbl t,rws_district_tbl d  where b.type_of_asset_code='"
					+ asset
					+ "' and  t.type_of_asset_code=b.type_of_asset_code and   a.asset_code=b.asset_code  substr(a.component,1,2)=d.dcode =m.mcode and  order by d.dcode";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			
			for (; complaintMasterData.rs.next(); complaints.add(compForm)) {
				compForm = new CompForm();
				compForm.setSourceCode(complaintMasterData.rs.getString(1));
				compForm.setComplntdt(complaintMasterData.rs.getString(2));
				compForm.setComplntno(complaintMasterData.rs.getString(3));
				compForm.setAttenby(complaintMasterData.rs.getString(4));
				compForm.setAttendt(complaintMasterData.rs.getString(5));
				compForm.setComplntstatus(complaintMasterData.rs.getString(6));
				compForm.setRemarksby(complaintMasterData.rs.getString(7));
				compForm.setAssetLocation(complaintMasterData.rs.getString(8));
				compForm.setAssetName(complaintMasterData.rs.getString(9));
				compForm.setDistrictCode(complaintMasterData.rs.getString(10));
				compForm.setDistrictName(complaintMasterData.rs.getString(11));
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return complaints;
	}

	public static String getComplaintno(DataSource dataSource) throws Exception {
		String complaintno;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		int rowCount = 0;
		complaintno = "";
		String com = "";
		
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			String query = "";
			int i = 1;
			query = "select MAX(complaint_no)+1 from RWS_COMPLAINTS_REGISTER_TBL  ";
			complaintMasterData.rset = complaintMasterData.stmt.executeQuery(query);
			if (complaintMasterData.rset.next()) {
				String temp = complaintMasterData.rset.getString(1);
				if (temp != null && temp.length() != 0) {
					if (temp.length() == 1)
						complaintno = "00" + temp;
					else if (temp.length() == 2)
						complaintno = "0" + temp;
					else
						complaintno = temp;
				} else {
					complaintno = "001";
				}
			}
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			Debug.println("The error in deleteComplaints" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return complaintno;
	}

	public static int deleteComplaints(String cono, DataSource dataSource) throws Exception {
		int rowCount;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		rowCount = 0;
		
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			String query = "";
			query = "delete from RWS_COMPLAINTS_REGISTER_TBL where complaint_no=? and COMPLAINT_STATUS is null";
			PreparedStatement ps=complaintMasterData.conn.prepareStatement(query);
			ps.setString(1, cono);
			rowCount = ps.executeUpdate();
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			Debug.println("The error in deleteComplaints" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return rowCount;
	}

	public static int updateComplaint(CompForm compForm, String gassetcode, DataSource dataSource) throws Exception {
		int rowCount;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		rowCount = 0;
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			String query = "";
			query = "update RWS_COMPLAINTS_REGISTER_TBL set complaint_no=?,"
					+ " complaint_date=to_date(?,'dd/mm/yyyy'),"
					+ compForm.getComplntdesc().toUpperCase() + " where asset_code=?";
			PreparedStatement ps=complaintMasterData.conn.prepareStatement(query);
			ps.setString(1, compForm.getComplntno());
			ps.setString(2, compForm.getComplntdt());
			ps.setString(3, gassetcode);
			rowCount = ps.executeUpdate();
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			Debug.println("The error in insertComplaints" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return rowCount;
	}

	public String getDistrictName(String dcode, DataSource dataSource) throws Exception {
		String districtName;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		districtName = "";
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			String query = " select dname FROM rws_district_tbl where dcode='" + dcode + "' ";
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			complaintMasterData.rset = complaintMasterData.stmt.executeQuery(query);
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
			String name, String address, String phone, CompForm compForm, String assetcd, String hpcd,
			String officecode, String compcode, DataSource dataSource) throws Exception {
		int rowCount;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		rowCount = 0;

		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			String query = "insert into RWS_COMPLAINTS_REGISTER_TBL (ASSET_CODE,COMPLAINT_NO,COMPLAINT_DATE,COMPLAINT_DESC,CATEGORY_CODE,REP_CODE,NAME,ADDRESS,INWARD_NO,COMPONENT_CODE,office_code,PHONE_NO,comp_code) values("
					+" ?,?,to_date(?,'dd/mm/yyyy'),?,?,?,?,?,?,?,?,?,? )";
			PreparedStatement ps=complaintMasterData.conn.prepareStatement(query); 
			ps.setString(1, assetcd);
			ps.setString(2, no);
			ps.setString(3,date);
			ps.setString(4,desc.toUpperCase());
			ps.setString(5,category);
		    ps.setString(6,givenby);
			ps.setString(7, name.toUpperCase());
		    ps.setString(8,address.toUpperCase());
		    ps.setString(9,ino);
		    ps.setString(10, hpcd);
		    ps.setString(11,officecode);
		    ps.setString(12,phone);
			ps.setString(13,compcode);
		    rowCount = ps.executeUpdate();
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			Debug.println("The error in insertComplaints" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return rowCount;
	}

	//
	//
	public static String insertComplaintgeneric(CompForm frm, String targetPath, ActionServlet actionServlet,
			String userid) throws Exception {

		int rowCount;
		String message = "";
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		rowCount = 0;
		PreparedStatement preparedStatement = null;
		Connection conn = null;
		try {
			ImageDocumentSanitizerImpl documentSanitizerImpl = new ImageDocumentSanitizerImpl();
			FileOutputStream outputStream = null;
			FormFile formFile = null;
			FileInputStream fis = null;
			File scannedFile = null;
			File targetFile = null;

			String complaintno = frm.getComplntno();
			String date = frm.getComplntdt();
			String desc = frm.getComplntdesc();

			String givenby = frm.getRepCode();
			String name = frm.getName();
			String address = frm.getAddress();
			String phone = frm.getPhoneNo();
			String componentname = frm.getComponentName();
			String habitationcode = frm.getHabCode();
			String grievanceRelatedTo = frm.getGrievanceRelatedTo();
			String grievanceCategory = frm.getGrievanceCategory();
			String email = frm.getEmailId();
			String grievanceEntryCategory = frm.getGrievanceEntryCategory();
			String query = "";
			conn = RwsOffices.getConn();
			
			formFile = frm.getUploadGrievance();

			if (formFile.getFileName() == null || formFile.getFileName().equals("")) {

				query = "insert into RWS_generic_COMPLAINTS_REG_TBL(COMPLAINT_NO,COMPLAINT_DATE,COMPLAINT_DESC,"
						+ "REP_CODE,NAME,ADDRESS,PHONE_NO,habitation_code,grievance_related_to,grievance_Category,emailId,"
						+ "GRIEVANCE_ENTRY_CATEGORY,USER_ID) values (?,to_date(?,'dd/mm/yyyy'),?,?,?,?,?,?,?,?,?,?,?)";
			} else {

				query = "insert into RWS_generic_COMPLAINTS_REG_TBL(COMPLAINT_NO,COMPLAINT_DATE,COMPLAINT_DESC,"
						+ "REP_CODE,NAME,ADDRESS,PHONE_NO,habitation_code,grievance_related_to,grievance_Category,emailId,"
						+ "GRIEVANCE_ENTRY_CATEGORY,USER_ID) values (?,to_date(?,'dd/mm/yyyy'),?,?,?,?,?,?,?,?,?,?,?)";

						//+ "GRIEVANCE_ENTRY_CATEGORY,USER_ID,UPLOADGRIEVANCE) values (?,to_date(?,'dd/mm/yyyy'),?,?,?,?,?,?,?,?,?,?,?,?)";
			}

			preparedStatement = conn.prepareStatement(query);
			preparedStatement.setString(1, complaintno);
			preparedStatement.setString(2, date);
			preparedStatement.setString(3, desc.toUpperCase());
			preparedStatement.setString(4, givenby);
			preparedStatement.setString(5, name.toUpperCase());
			preparedStatement.setString(6, address.toUpperCase());
			preparedStatement.setString(7, phone);
			preparedStatement.setString(8, habitationcode);
			preparedStatement.setString(9, grievanceRelatedTo);
			preparedStatement.setString(10, grievanceCategory);
			preparedStatement.setString(11, email);
			preparedStatement.setString(12, grievanceEntryCategory);
			preparedStatement.setString(13, userid);
			if (formFile.getFileName() == null || formFile.getFileName().equals("")) {
			} else {
				try {

					String mimeType= URLConnection.guessContentTypeFromName(formFile.getFileName());
					if(!mimeType.equalsIgnoreCase("image/jpeg"))
					{
						message="Allowed only jpg file extensions only.";
						return message;
					}
					/*else
					{
						System.out.println("$$$$$$$$$$$$$$$$$$$");
					}*/
					String path = actionServlet.getServletContext().getRealPath("") + formFile.getFileName();
					
					scannedFile = new File(path);
					outputStream = new FileOutputStream(scannedFile);
					if (outputStream != null) {
						outputStream.write(formFile.getFileData());
					}

					targetFile = new File(targetPath);

					if (!documentSanitizerImpl.madeSafe(scannedFile)) {
						message = "Image File is Corrupted";
						conn.setAutoCommit(true);
						scannedFile.delete();
						outputStream.close();
						targetFile.delete();
						return message;
					}

					compressImage(scannedFile, targetFile);

					fis = new FileInputStream(targetFile);
					if (fis != null) {
					}

				} catch (Exception e) {
					System.out.println("exception in fileinput complaintform -- " + e);
				} finally {
					if (fis != null) {
						// fis.close();
					}
				}

				double fileSizeMB = ((frm.getUploadGrievance().getFileSize() / 1024.0) / 1024.0);

				if (fileSizeMB > 0.2) {
					message = "Image File Size Shoud Not Be Allowed More Than 200 KB";
					conn.setAutoCommit(true);
					scannedFile.delete();
					outputStream.close();
					targetFile.delete();
					return message;

				}
				//String imagePath=servlet.getServletContext().getRealPath("/")+"PrivateSourceImages"; 
				String mimeType= URLConnection.guessContentTypeFromName(formFile.getFileName());
				if(!mimeType.equalsIgnoreCase("image/jpeg"))
				{
					message="Allowed only jpg file extensions only.";
					return message;
				}
				/*else
				{
					System.out.println("$$$$$$$$$$$$$$$$$$$");
				}*/
				String imagePath=actionServlet.getServletContext().getRealPath("/") ;
				 if(imagePath != null && !imagePath.isEmpty() && imagePath.contains(File.separator+"webapps"+File.separator)){
					 String sample[]  = imagePath.split( File.separator+"webapps"+File.separator);
					 //System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
					 imagePath = sample[0];
					 ////System.out.println("server split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
				 }else{
					 String sample[]  = imagePath.split( "webapps");
					// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
					 imagePath = sample[0];
					//// System.out.println(" local split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
				 }
				 imagePath = imagePath+ File.separator+"GrievanceComplaintImages";
				 
				 System.out.println(imagePath);
				File myFilesDir = new File(imagePath);
				if (!myFilesDir.exists())
					myFilesDir.mkdirs();
				imagePath = imagePath + File.separator ;
				File filepath = new File(imagePath);
				File filepathisExits = new File(filepath+File.separator+complaintno+".jpg");
				if(filepathisExits.getAbsoluteFile().exists()){
					filepathisExits.delete();
				}
				 byte[] readData = new byte[1024];
					FileOutputStream fout=new FileOutputStream(filepath+File.separator+complaintno+".jpg"); 	
					int k = fis.read(readData);
				      while (k != -1) {
				    	  fout.write(readData, 0, k);
				        k = fis.read(readData);
				      }   			            
				    fout.close();
				
				
				
				//preparedStatement.setBinaryStream(14, fis, (int) targetFile.length());

				if (scannedFile != null) {
					scannedFile.delete();

				}
				if (targetFile != null) {
					targetFile.delete();
				}
				if (outputStream != null) {
					// outputStream.close();
				}
				if (fis != null) {
					// fis.close();
				}

			}
			rowCount = preparedStatement.executeUpdate();

			String co = frm.getComplntno();
			if (rowCount < 1) {
				message = "Record Can't be inserted";
			} else {
				message = "Your Complaint is Registered with Complaint Number : " + co;
			}
		}

		catch (Exception e) {
			System.out.println("exception in insertComplaintgeneric -- " + e);
		} finally {
			complaintMasterData.closeAll();

		}
		return message;
	}

	
	public static int insertComplaintout(String assetcd, String no, String date, String category, String desc,
			String givenby, String name, String address, String phone, CompForm compForm, String hpcd, String compcode,
			DataSource dataSource) throws Exception {
		int rowCount;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		rowCount = 0;

		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			String query = "insert into RWS_COMPLAINTS_REGISTER_TBL (ASSET_CODE,COMPLAINT_NO,COMPLAINT_DATE,COMPLAINT_DESC,CATEGORY_CODE,REP_CODE,NAME,ADDRESS,COMPONENT_CODE,PHONE_NO,comp_code) values("
					 + "?,?,to_date( ? ,'dd/mm/yyyy'),?,?,?,?,?,?,?,? )"; 
					
			PreparedStatement ps= complaintMasterData.conn.prepareStatement(query);
			ps.setString(1, assetcd);
			ps.setString(2,no);
			ps.setString(3,date);
			ps.setString(4,desc.toUpperCase());
			ps.setString(5,category);
		    ps.setString(6,givenby);
			ps.setString(7, name.toUpperCase());
		    ps.setString(8,address.toUpperCase());
		    ps.setString(9,hpcd);
		    ps.setString(10, phone);
		    ps.setString(11,compcode);
			rowCount = ps.executeUpdate();
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			Debug.println("The error in insertComplaints" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return rowCount;
	}

	public static int insertNewComplaint(CompForm compForm, String assetcd, String hpcd, DataSource dataSource)
			throws Exception {
		int rowCount;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		rowCount = 0;
		
		
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			String query = "";
			String na = "NOTATTENDED";
			query = "insert into RWS_COMPLAINTS_REGISTER_TBL (ASSET_CODE,SOURCE_CODE,COMPLAINT_NO,COMPLAINT_DATE,COMPLAINT_DESC,COMPLAINT_STATUS) values("
					+" ?,?,?,to_date(?,'dd/mm/yyyy'), ?,?)";
			PreparedStatement ps= complaintMasterData.conn.prepareStatement(query);
			ps.setString(1, assetcd);
			ps.setString(2,hpcd);
			ps.setString(3,compForm.getComplntno());
			ps.setString(4, compForm.getComplntdt() );
			ps.setString(5,compForm.getComplntdesc().toUpperCase());
		    ps.setString(6,na.toUpperCase());
			
			rowCount =ps.executeUpdate();
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			Debug.println("The error in insertComplaints" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return rowCount;
	}

	public static String getDistrictname(String dcode, DataSource dataSource) throws Exception {
		String message = null;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
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
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
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
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
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
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
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

	public static int insertComplaintAttended(CompForm compForm, String complaintno, DataSource dataSource)
			throws Exception {
		int rowCount;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		rowCount = 0;
		
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			String query = "";
			query = "update  RWS_COMPLAINTS_REGISTER_TBL SET ATTENDED_DATE=to_date(?,'dd/mm/yyyy'),ATTENDED_BY=?,COMPLAINT_STATUS=?,"
					+" ?,REMARKS=?,"
					+ "MESSAGE='ATTENDED',cost_incurred= ? WHERE complaint_no=?";
				
			PreparedStatement ps= complaintMasterData.conn.prepareStatement(query);
			ps.setString(1,compForm.getAttendt());
			ps.setString(2,compForm.getAttenby().toUpperCase());
			ps.setString(3,compForm.getComplntstatus().toUpperCase());
			ps.setString(4,compForm.getRemarksby().toUpperCase());
			ps.setString(5,compForm.getCostIncurred() );
			ps.setString(6,complaintno);
			rowCount = ps.executeUpdate();
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			Debug.println("The error in insertComplaints" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return rowCount;
	}

	//
	public static int insertComplaintAttendedgeneric(CompForm compForm, String complaintno, DataSource dataSource)
			throws Exception {
		int rowCount;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		rowCount = 0;
		
		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			String query = "";
			query = "update  RWS_generic_COMPLAINTS_REG_TBL SET ATTENDED_DATE=to_date(? ,'dd/mm/yyyy'),ATTENDED_BY=?,COMPLAINT_STATUS=?,"
					+"REMARKS=?,cost_incurred=?,message='ATTENDED' WHERE complaint_no=?";
					
			PreparedStatement ps= complaintMasterData.conn.prepareStatement(query);
			ps.setString(1,compForm.getAttendt());
			ps.setString(2,compForm.getAttenby().toUpperCase());
			ps.setString(3,compForm.getComplntstatus().toUpperCase());
			ps.setString(4,compForm.getRemarksby().toUpperCase());
			ps.setString(5,compForm.getCostIncurred() );
			ps.setString(6,complaintno);
			rowCount = ps.executeUpdate();
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			Debug.println("The error in insertComplaints" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return rowCount;
	}

	//
	public static String getAssetType(String dist, String man, String pan, DataSource dataSource) throws Exception {
		String s = "";
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();

		try {
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			String query = "";
			query = "select distinct substr(complaint_no,7,2) from rws_complaints_register_tbl where substr(component_code,1,2)='"
					+ dist + "' and substr(component_code,6,2)='" + man + "' and substr(component_code,13,2)='" + pan
					+ "' ";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			while (complaintMasterData.rs.next()) {
				s = complaintMasterData.rs.getString(1);
			}
		} catch (SQLException sqle) {
			int errorCode = sqle.getErrorCode();
			if (errorCode == 1)
				errorMessage = "Record with this name exists.";
		} catch (Exception e) {
			Debug.println("The error in query" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return s;
	}

	//

	public static ArrayList getToDates(String hab, String fromDate, DataSource dataSource) {
		ArrayList todates = new ArrayList();
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		try {
			String query;
			query = query = "select distinct to_char(attended_date,'dd/mm/yyyy') as a1 from rws_complaints_register_tbl where substr(source_code,1,16)='"
					+ hab + "' and  attended_date>=to_Date('" + fromDate
					+ "','dd/mm/yyyy') order by substr(a1,7,10) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			CompForm compForm = null;
			for (; complaintMasterData.rs.next(); todates.add(compForm)) {
				compForm = new CompForm();
				compForm.setToDate(complaintMasterData.rs.getString(1));
			}

			complaintMasterData.conn.close();
		} catch (Exception e) {
			Debug.println("Exception in getToDates1 in complaintMasterData :" + e);
		}
		return todates;
	}

	public static ArrayList getToDatesdist(String dist, String hab, String fromDate, DataSource dataSource) {
		ArrayList todates = new ArrayList();
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		try {
			String query;
			query = query = "select distinct to_char(attended_date,'dd/mm/yyyy') as a1 from rws_complaints_register_tbl where substr(component_code,1,16)='"
					+ hab + "' and substr(component_code,1,2)='" + dist + "' and  attended_date>=to_Date('" + fromDate
					+ "','dd/mm/yyyy') and complaint_status is not null order by substr(a1,7,10) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			LabelValueBean compForm = null;
			while (complaintMasterData.rs.next()) {
				compForm = new LabelValueBean();
				compForm.setValue(complaintMasterData.rs.getString(1));
				compForm.setLabel(complaintMasterData.rs.getString(1));
				compForm.setLabelValue(complaintMasterData.rs.getString(1));
				todates.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("Exception in getToDates1 in complaintMasterData :" + e);
		} finally {
			try {
				complaintMasterData.closeAll();
				
			} catch (Exception o) {
				o.printStackTrace();
			}
		}
		return todates;
	}

	//
	public static ArrayList getToDatesdistgeneric(String dist, String hab, String fromDate, DataSource dataSource) {
		ArrayList todates = new ArrayList();
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		try {
			String query;
			query = query = "select distinct to_char(attended_date,'dd/mm/yyyy') as a1 from rws_generic_complaints_reg_tbl where habitation_code='"
					+ hab + "' and substr(habitation_code,1,2)='" + dist + "' and  attended_date>=to_Date('" + fromDate
					+ "','dd/mm/yyyy') and complaint_status is not null order by substr(a1,7,10) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			LabelValueBean compForm = null;
			while (complaintMasterData.rs.next()) {
				compForm = new LabelValueBean();
				compForm.setValue(complaintMasterData.rs.getString(1));
				compForm.setLabel(complaintMasterData.rs.getString(1));
				compForm.setLabelValue(complaintMasterData.rs.getString(1));
				todates.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("Exception in getToDates1 in complaintMasterData :" + e);
		} finally {
			try {
				complaintMasterData.closeAll();
				
			} catch (Exception o) {
				o.printStackTrace();
			}
		}
		return todates;
	}

	//
	public static ArrayList getToDatesdistreport(String dist, String man, String pan, String asset,
			DataSource dataSource) {
		ArrayList todates = new ArrayList();
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		Debug.println("started getToDates in RwsMasterData before try");
		try {
			String query;
			// query = query = "select distinct to_char(complaint_date,'dd/mm/yyyy') as a1
			// from rws_complaints_register_tbl where substr(component_code,1,2)='" + dist +
			// "' and substr(component_code,6,2)='" + man + "' and
			// substr(component_code,11,2)='" + pan + "' and
			// substr(complaint_no,7,8)='"+asset+"' and complaint_date>=to_Date('" +
			// fromDate + "','dd/mm/yyyy') and complaint_status is null order by
			// substr(a1,7,10) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";
			query = "select distinct to_char(sysdate,'dd/mm/yyyy') as a1 from rws_complaints_register_tbl where  substr(component_code,1,2)='"
					+ dist + "' and substr(component_code,6,2)='" + man + "' and substr(component_code,13,2)='" + pan
					+ "' and  substr(complaint_no,7,2)='" + asset
					+ "'   order by substr(a1,7,10) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			LabelValueBean compForm = null;
			while (complaintMasterData.rs.next()) {
				compForm = new LabelValueBean();
				compForm.setValue(complaintMasterData.rs.getString(1));
				compForm.setLabel(complaintMasterData.rs.getString(1));
				compForm.setLabelValue(complaintMasterData.rs.getString(1));
				todates.add(compForm);
			}

			complaintMasterData.conn.close();
		} catch (Exception e) {
			Debug.println("Exception in getToDates1 in complaintMasterData :" + e);
		}
		return todates;
	}

	//
	public static ArrayList getToDatesdistreportgeneric(String dist, String man, String pan, DataSource dataSource) {
		ArrayList todates = new ArrayList();
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		try {
			String query;
			// query = query = "select distinct to_char(complaint_date,'dd/mm/yyyy') as a1
			// from rws_complaints_register_tbl where substr(component_code,1,2)='" + dist +
			// "' and substr(component_code,6,2)='" + man + "' and
			// substr(component_code,11,2)='" + pan + "' and
			// substr(complaint_no,7,8)='"+asset+"' and complaint_date>=to_Date('" +
			// fromDate + "','dd/mm/yyyy') and complaint_status is null order by
			// substr(a1,7,10) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";
			query = "select distinct to_char(sysdate,'dd/mm/yyyy') as a1 from rws_generic_complaints_reg_tbl where  substr(habitation_code,1,2)='"
					+ dist + "' and substr(habitation_code,6,2)='" + man + "' and substr(habitation_code,13,2)='" + pan
					+ "'    order by substr(a1,7,10) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			LabelValueBean compForm = null;
			while (complaintMasterData.rs.next()) {
				compForm = new LabelValueBean();
				compForm.setValue(complaintMasterData.rs.getString(1));
				compForm.setLabel(complaintMasterData.rs.getString(1));
				compForm.setLabelValue(complaintMasterData.rs.getString(1));
				todates.add(compForm);
			}

			complaintMasterData.conn.close();
		} catch (Exception e) {
			Debug.println("Exception in getToDates1 in complaintMasterData :" + e);
		}
		return todates;
	}

	//
	public static ArrayList getToDatesdistreporttot(String dist, DataSource dataSource) {
		ArrayList todates = new ArrayList();
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		try {
			String query;
			// query = query = "select distinct to_char(complaint_date,'dd/mm/yyyy') as a1
			// from rws_complaints_register_tbl where substr(component_code,1,2)='" + dist +
			// "' and substr(component_code,6,2)='" + man + "' and
			// substr(component_code,11,2)='" + pan + "' and
			// substr(complaint_no,7,8)='"+asset+"' and complaint_date>=to_Date('" +
			// fromDate + "','dd/mm/yyyy') and complaint_status is null order by
			// substr(a1,7,10) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";
			query = "select distinct to_char(sysdate,'dd/mm/yyyy') as a1 from rws_complaints_register_tbl where  substr(component_code,1,2)='"
					+ dist + "'    order by substr(a1,7,10) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			LabelValueBean compForm = null;
			while (complaintMasterData.rs.next()) {
				compForm = new LabelValueBean();
				compForm.setValue(complaintMasterData.rs.getString(1));
				compForm.setLabel(complaintMasterData.rs.getString(1));
				compForm.setLabelValue(complaintMasterData.rs.getString(1));
				todates.add(compForm);
			}

			complaintMasterData.conn.close();
		} catch (Exception e) {
			Debug.println("Exception in getToDates1 in complaintMasterData :" + e);
		}
		return todates;
	}

	//

	public static ArrayList getToDates1(String dis, String fdate, DataSource dataSource) {
		ArrayList todates = new ArrayList();
		String mon[] = { "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC" };
		String compdate = "";
		compdate = fdate.substring(0, 2) + "-" + mon[Integer.parseInt(fdate.substring(3, 5)) - 1] + "-"
				+ fdate.substring(8, 10);
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		try {
			String query;
			query = query = "select distinct to_char(attended_date,'dd/mm/yyyy') as a1 from rws_complaints_register_tbl where substr(component_code,1,2)='"
					+ dis + "' and attended_date>=to_Date('" + compdate
					+ "','dd/mon/yy') order by substr(a1,7,10) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			CompForm compForm = null;
			for (; complaintMasterData.rs.next(); todates.add(compForm)) {
				compForm = new CompForm();
				compForm.setAttendt(complaintMasterData.rs.getString(1));
			}

			complaintMasterData.conn.close();
		} catch (Exception e) {
			Debug.println("Exception in getToDates1 in complaintMasterData :" + e);
		}
		return todates;
	}

	public ArrayList getComplaintViewDetails(CompForm frm, ArrayList columns, DataSource dataSource,
			HttpServletRequest request) throws Exception {
		ArrayList details = new ArrayList();
		ComplaintMasterData sch1 = new ComplaintMasterData();
		String query = "";
		String query1 = "";
		String message = "Report";
		String ord = "";
		boolean added = true;
		boolean ordadded = false;
		if (frm.getDist().equals("-1"))
			request.setAttribute("dFlag", "true");
		if (frm.getMand().equals("-1"))
			request.setAttribute("mFlag", "true");
		if (frm.getPanch().equals("-1"))
			request.setAttribute("pFlag", "true");
		if (frm.getVillage().equals("-1"))
			request.setAttribute("vFlag", "true");
		if (frm.getHabCode().equals("-1"))
			request.setAttribute("hFlag", "true");
		sch1.conn = RwsOffices.getConn();
		try {
			query = "select d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,c.asset_code,c.source_code,c.complaint_no,to_char(c.complaint_date,'dd/mm/yyyy'),to_char(c.attended_date,'dd/mm/yyyy'),nvl(c.attended_by,'-'),nvl(c.complaint_status,'-'),nvl(c.remarks,'-'),c1.category_code,c1.category_name,raj.panch_code,raj.panch_name,a.asset_name from rws_complaints_register_tbl c,rws_complaints_category_tbl c1,rws_district_tbl d,rws_mandal_tbl m,rws_village_tbl v,rws_panchayat_tbl p,rws_panchayat_raj_tbl raj,rws_asset_mast_tbl a where a.asset_code=c.asset_code and c1.category_code=c.category_code and substr(c.source_code,1,16)=raj.panch_code  and  d.dcode=substr(c.source_code,1,2) and m.mcode=substr(c.source_code,6,2) and p.pcode=substr(c.source_code,13,2) and v.vcode=substr(c.source_code,8,3) and d.dcode=m.dcode and p.dcode=m.dcode and p.mcode=m.mcode and v.dcode=p.dcode and v.mcode=p.mcode and v.pcode=p.pcode";
			if (columns.contains("ComplaintDescription")) {
				query = query + ",";
				query = query + "c.complaint_desc";
				if (added)
					ord = ord + "order by ";
				if (ordadded)
					ord = ord + ",";
				ord = ord + "c.complaint_desc";
				ordadded = true;
				added = false;
			}
			if (!frm.getDist().equals("-1") || frm.getDist() != null)
				query = query + " and substr(c.source_code,1,2)='" + frm.getDist() + "' ";
			if (!frm.getMand().equals("-1"))
				query = query + " and substr(c.source_code,6,2)='" + frm.getMand() + "' ";
			if (!frm.getPanch().equals("-1"))
				query = query + " and substr(c.source_code,13,2)='" + frm.getPanch() + "' ";
			if (!frm.getVillage().equals("-1"))
				query = query + " and substr(c.source_code,8,3)='" + frm.getVillage() + "' ";
			if (!frm.getHabCode().equals("-1"))
				query = query + " and substr(c.source_code,1,16)='" + frm.getHabCode() + "' ";
			if (frm.getCategory() != null && !frm.getCategory().equals(""))
				query = query + " and c1.category_code='" + frm.getCategory() + "' ";
			if (!frm.getComplntdt().equals("") || !frm.getComplntdt().equals("")) {
				String mon[] = { "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC" };
				String compdate = "";
				compdate = frm.getComplntdt().substring(0, 2) + "-"
						+ mon[Integer.parseInt(frm.getComplntdt().substring(3, 5)) - 1] + "-"
						+ frm.getComplntdt().substring(8, 10);
				query = query + " and c.complaint_date=to_date('" + compdate + "','dd/mon/yy') ";
			}
			if (!frm.getAttendt().equals("") || !frm.getAttendt().equals("")) {
				String mon[] = { "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC" };
				String compdate = "";
				compdate = frm.getAttendt().substring(0, 2) + "-"
						+ mon[Integer.parseInt(frm.getAttendt().substring(3, 5)) - 1] + "-"
						+ frm.getAttendt().substring(8, 10);
				query = query + " and c.attended_date=to_date('" + compdate + "','dd/mon/yy') ";
			}
			if (!frm.getComplntstatus().equals("") || !frm.getComplntstatus().equals(""))
				query = query + " and c.complaint_status='" + frm.getComplntstatus().toUpperCase() + "'";
			query = query + " order by d.dcode,m.mcode,v.vcode,p.pcode,c.complaint_no ";
			sch1.stmt = sch1.conn.createStatement();
			sch1.rs = sch1.stmt.executeQuery(query);
			
			while (sch1.rs.next())
				try {
					frm = new CompForm();
					frm.setDistrictName(sch1.rs.getString(2));
					frm.setMandalName(sch1.rs.getString(4));
					frm.setPanchayatName(sch1.rs.getString(6));
					frm.setVillageName(sch1.rs.getString(8));
					frm.setHabCode(sch1.rs.getString(20));
					frm.setHabName(sch1.rs.getString(21));
					frm.setSourceCode(sch1.rs.getString(10));
					frm.setCategoryName(sch1.rs.getString(19));
					frm.setComplntno(sch1.rs.getString(11));
					frm.setComplntdt(sch1.rs.getString(12));
					frm.setAttendt(sch1.rs.getString(14));
					frm.setAssetName(sch1.rs.getString(22));
					frm.setComplntstatus(sch1.rs.getString(16));
					frm.setComplntdesc(sch1.rs.getString("complaint_desc"));
					request.setAttribute("frmm", frm);
					details.add(frm);
				} catch (Exception e) {
					Debug.println("Exeception in viewdetails " + e.getMessage());
				}
			request.setAttribute("message", message);
		} catch (Exception e) {
			Debug.println("Exception in view Details" + e.getMessage());
		}
		return details;
	}

	public ArrayList getComplaintViewDetails1(CompForm frm, ArrayList columns, DataSource dataSource,
			HttpServletRequest request) throws Exception {
		ArrayList details = new ArrayList();
		ComplaintMasterData sch1 = new ComplaintMasterData();
		String query = "";
		String query1 = "";
		String message = "Report";
		String ord = "";
		boolean added = true;
		boolean ordadded = false;
		if (frm.getDist().equals("-1"))
			request.setAttribute("dFlag", "true");
		if (frm.getMand().equals("-1"))
			request.setAttribute("mFlag", "true");
		if (frm.getPanch().equals("-1"))
			request.setAttribute("pFlag", "true");
		if (frm.getVillage().equals("-1"))
			request.setAttribute("vFlag", "true");
		if (frm.getHabCode().equals("-1"))
			request.setAttribute("hFlag", "true");
		if (frm.getComplntstatus().equals("-1"))
			request.setAttribute("sFlag", "true");
		sch1.conn = RwsOffices.getConn();
		try {
			query = "select d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,c.complaint_no,to_char(c.complaint_date,'dd/mm/yyyy'),nvl(to_char(c.attended_date,'dd/mm/yyyy'),'-'),nvl(c.complaint_status,'-'),nvl(c.remarks,'-'),nvl(c1.category_name,'-'),nvl(a.asset_name,'-'),c.source_code,raj.panch_name";
			if (columns.contains("d"))
				query = query + ",c.complaint_desc";
			query = query
					+ " from rws_panchayat_raj_tbl raj,rws_asset_mast_tbl a,rws_complaints_category_tbl c1,rws_complaints_register_tbl c,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v where   d.dcode=m.dcode and  p.mcode=m.mcode and p.dcode=d.dcode and c.category_code=c1.category_code and raj.panch_code=substr(c.source_code,1,16) and v.dcode=d.dcode and v.mcode=m.mcode and v.pcode=p.pcode and d.dcode=substr(c.source_code,1,2) and m.mcode=substr(c.source_code,6,2) and p.pcode=substr(c.source_code,13,2) and v.vcode=substr(c.source_code,8,3) and a.asset_code=c.asset_code";
			if (!frm.getDist().equals("-1") || frm.getDist() != null)
				query = query + " and substr(c.source_code,1,2)='" + frm.getDist() + "' ";
			if (!frm.getMand().equals("-1"))
				query = query + " and substr(c.source_code,6,2)='" + frm.getMand() + "' ";
			if (!frm.getPanch().equals("-1"))
				query = query + " and substr(c.source_code,13,2)='" + frm.getPanch() + "' ";
			if (!frm.getVillage().equals("-1"))
				query = query + " and substr(c.source_code,8,3)='" + frm.getVillage() + "' ";
			if (!frm.getHabCode().equals("-1"))
				query = query + " and substr(c.source_code,1,16)='" + frm.getHabCode() + "' ";
			if (frm.getCategory() != null && !frm.getCategory().equals(""))
				query = query + " and c1.category_code='" + frm.getCategory() + "' ";
			if (!frm.getComplntdt().equals("") || !frm.getComplntdt().equals("")) {
				String mon[] = { "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC" };
				String compdate = "";
				compdate = frm.getComplntdt().substring(0, 2) + "-"
						+ mon[Integer.parseInt(frm.getComplntdt().substring(3, 5)) - 1] + "-"
						+ frm.getComplntdt().substring(8, 10);
				query = query + " and c.complaint_date=to_date('" + compdate + "','dd/mon/yy') ";
			}
			if (!frm.getAttendt().equals("") || !frm.getAttendt().equals("")) {
				String mon[] = { "JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC" };
				String compdate = "";
				compdate = frm.getAttendt().substring(0, 2) + "-"
						+ mon[Integer.parseInt(frm.getAttendt().substring(3, 5)) - 1] + "-"
						+ frm.getAttendt().substring(8, 10);
				query = query + " and c.attended_date=to_date('" + compdate + "','dd/mon/yy') ";
			}
			if (!frm.getComplntstatus().equals("") || !frm.getComplntstatus().equals(""))
				query = query + " and c.complaint_status='" + frm.getComplntstatus().toUpperCase() + "'";
			query = query + "  order by d.dcode,d.dname,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname";
			sch1.stmt = sch1.conn.createStatement();
			sch1.rs = sch1.stmt.executeQuery(query);
			
			while (sch1.rs.next())
				try {
					frm = new CompForm();
					frm.setDistrictName(sch1.rs.getString(2));
					frm.setMandalName(sch1.rs.getString(4));
					frm.setPanchayatName(sch1.rs.getString(6));
					frm.setVillageName(sch1.rs.getString(8));
					frm.setComplntno(sch1.rs.getString(9));
					frm.setComplntdt(sch1.rs.getString(10));
					frm.setAttendt(sch1.rs.getString(11));
					frm.setComplntstatus(sch1.rs.getString(12));
					frm.setAssetName(sch1.rs.getString(15));
					frm.setCategoryName(sch1.rs.getString(14));
					frm.setSourceCode(sch1.rs.getString(16));
					frm.setHabName(sch1.rs.getString(17));
					frm.setComplntdesc(sch1.rs.getString("complaint_desc"));
					request.setAttribute("frmm", frm);
					details.add(frm);
				} catch (Exception e) {
					Debug.println("Exeception in viewdetails " + e.getMessage());
				}
			request.setAttribute("message", message);
		} catch (Exception e) {
			Debug.println("Exception in view Details" + e.getMessage());
		}
		return details;
	}

	public static ArrayList getFromDates(String hab, DataSource dataSource) throws Exception {
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		ArrayList fromdates = new ArrayList();
		try {
			String query = "select distinct to_char(attended_date,'dd/mm/yyyy') as a1 from rws_complaints_register_tbl where substr(component_code,1,16)='"
					+ hab + "'  order by substr(a1,7,10) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			CompForm compForm = null;
			for (; complaintMasterData.rs.next(); fromdates.add(compForm)) {
				compForm = new CompForm();
				compForm.setFromDate(complaintMasterData.rs.getString(1));
			}

			complaintMasterData.conn.close();
		} catch (Exception e) {
			Debug.println("Exception in GetDate in CompForm :" + e);
		}
		return fromdates;
	}

	public static ArrayList getFromDatesdist(String dist, String Habcode, DataSource dataSource) throws Exception {
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		ArrayList fromdates = new ArrayList();
		String man = null;
		String pan = null;
		String hcode = null;
		try {
			if (Habcode != null && !Habcode.equals("")) {
				man = Habcode.substring(5, 7);
				pan = Habcode.substring(12, 14);
				
				
				hcode = Habcode.substring(10, 12);
			}
		} catch (Exception e) {
			Debug.println(" exception String" + e);
		}
		try {
			String query = "select distinct to_char(complaint_date,'dd/mm/yyyy') as a1 from rws_complaints_register_tbl where substr(component_code,1,16)='"
					+ Habcode + "' and substr(component_code,1,2)='" + dist + "' and substr(component_code,6,2)='" + man
					+ "' and substr(component_code,13,2)='" + pan + "' and substr(component_code,11,2)='" + hcode
					+ "' and complaint_status is not null  order by substr(a1,7,10) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";
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

		} catch (Exception e) {
			Debug.println("Exception in GetDate in CompForm :" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return fromdates;
	}

	//
	public static ArrayList getFromDatesdistgeneric(String dist, String Habcode, DataSource dataSource)
			throws Exception {
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		ArrayList fromdates = new ArrayList();
		String man = null;
		String pan = null;
		String hcode = null;
		try {
			if (Habcode != null && !Habcode.equals("")) {
				man = Habcode.substring(5, 7);
				pan = Habcode.substring(12, 14);
				
				
				hcode = Habcode.substring(10, 12);
			}
		} catch (Exception e) {
			Debug.println(" exception String" + e);
		}
		try {
			String query = "select distinct to_char(complaint_date,'dd/mm/yyyy') as a1 from rws_generic_complaints_reg_tbl where habitation_code='"
					+ Habcode + "' and substr(habitation_code,1,2)='" + dist + "' and substr(habitation_code,6,2)='"
					+ man + "' and substr(habitation_code,13,2)='" + pan + "' and substr(habitation_code,11,2)='"
					+ hcode
					+ "' and complaint_status is not null  order by substr(a1,7,10) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";
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

		} catch (Exception e) {
			Debug.println("Exception in GetDate in CompForm :" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return fromdates;
	}

	//
	public static ArrayList getFromDatesdistreport(String dist, String man, String pan, String asset,
			DataSource dataSource) throws Exception {
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		ArrayList fromdates = new ArrayList();
		// String man = null;
		// String pan = null;
		// String hcode = null;
		try {
			/*
			 * if(Habcode != null && !Habcode.equals("")) { man = Habcode.substring(5, 7);
			 * pan = Habcode.substring(12, 14); 
			 *  hcode = Habcode.substring(10, 12); }
			 */
		} catch (Exception e) {
			Debug.println(" exception String" + e);
		}
		try {
			String query = "select distinct to_char(complaint_date,'dd/mm/yyyy') as a1 from rws_complaints_register_tbl where  substr(component_code,1,2)='"
					+ dist + "' and substr(component_code,6,2)='" + man + "' and substr(component_code,13,2)='" + pan
					+ "' and  substr(complaint_no,7,2)='" + asset
					+ "'   order by substr(a1,7,10) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";
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

	//
	public static ArrayList getFromDatesdistreportgeneric(String dist, String man, String pan, DataSource dataSource)
			throws Exception {

		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		ArrayList fromdates = new ArrayList();
		// String man = null;
		// String pan = null;
		// String hcode = null;
		try {
			/*
			 * if(Habcode != null && !Habcode.equals("")) { man = Habcode.substring(5, 7);
			 * pan = Habcode.substring(12, 14); 
			 *  hcode = Habcode.substring(10, 12); }
			 */
		} catch (Exception e) {
			Debug.println(" exception String" + e);
		}
		try {
			String query = "select distinct to_char(complaint_date,'dd/mm/yyyy') as a1 from rws_generic_complaints_reg_tbl where  substr(habitation_code,1,2)='"
					+ dist + "' and substr(habitation_code,6,2)='" + man + "' and substr(habitation_code,13,2)='" + pan
					+ "'    order by substr(a1,7,10) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";
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

	//
	public static ArrayList getFromDatesdistreporttot(String dist, DataSource dataSource) throws Exception {
		
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		ArrayList fromdates = new ArrayList();
		// String man = null;
		// String pan = null;
		// String hcode = null;
		try {
			/*
			 * if(Habcode != null && !Habcode.equals("")) { man = Habcode.substring(5, 7);
			 * pan = Habcode.substring(12, 14); 
			 *  hcode = Habcode.substring(10, 12); }
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
	//

	public static ArrayList getFromDates1(String dis, DataSource dataSource) throws Exception {
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		String query = null;
		ArrayList fromdates = new ArrayList();
		try {
			if (dis != null)
				query = "select distinct to_char(complaint_date,'dd/mm/yyyy') as a1 from rws_complaints_register_tbl where substr(component_code,1,2)='"
						+ dis + "'  order by substr(a1,7,10) desc,substr(a1,4,2) desc,substr(a1,1,2) desc";
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			CompForm compForm = null;
			for (; complaintMasterData.rs.next(); fromdates.add(compForm)) {
				compForm = new CompForm();
				compForm.setComplntdt(complaintMasterData.rs.getString(1));
			}

			complaintMasterData.conn.close();
		} catch (Exception e) {
			Debug.println("Exception in GetDate in CompForm :" + e);
		}
		return fromdates;
	}

	public static String getUrbComplaintsNogeneric1(String complaintno, DataSource dataSource) throws Exception {
		String complaintstatus;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		ArrayList complaints = new ArrayList();
		String query = "";
		String status = "";
		complaintstatus = "";
		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select nvl(complaint_status,'-') from rws_generic_complaints_reg_tbl where complaint_no='"
					+ complaintno + "' and URBAN_WATER='U'";
			
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			while (complaintMasterData.rs.next()) {
				status = complaintMasterData.rs.getString(1);
				if (status.equals("-"))
					complaintstatus = "Not Attended";
				else
					complaintstatus = complaintMasterData.rs.getString(1);
				compForm = new CompForm();
				compForm.setStatus(complaintstatus);
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return complaintstatus;
	}

	public static ArrayList getUrbComplaintsNogeneric(String complaintno, DataSource dataSource) throws Exception {
		ArrayList complaints;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		complaints = new ArrayList();
		String query = "";
		String st = null;
		String s = null;

		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			// query = "select distinct
			// a.component_code,nvl(m.asset_name,'-'),a.complaint_no,to_char(a.complaint_date,'dd/mm/yyyy'),a.complaint_desc,nvl(a.attended_by,'-'),nvl(to_char(a.attended_date,'dd/mm/yyyy'),'-'),nvl(a.complaint_status,'-'),nvl(a.remarks,'-'),r.rep_name,a.name,a.address
			// from rws_complaints_register_tbl a,rws_asset_mast_tbl m,rws_public_rep_tbl r
			// where r.rep_code=a.rep_code and m.asset_code=a.asset_code and
			// a.complaint_no='" + complaintno + "'";
			query = "select distinct a.component_name,a.complaint_no,to_char (a.complaint_date,'dd/mm/yyyy'),a.complaint_desc,nvl(a.attended_by,'-'),nvl(to_char (a.attended_date,'dd/mm/yyyy'),'-'),nvl(a.ACTION_TAKEN,'-'),nvl(a.remarks,'-'),r.rep_name,a.name,a.address from rws_generic_complaints_reg_tbl a,rws_public_rep_tbl r where r.rep_code=a.rep_code  and a.complaint_no='"
					+ complaintno + "' and URBAN_WATER='U'";
			
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			while (complaintMasterData.rs.next()) {
				compForm = new CompForm();
				st = complaintMasterData.rs.getString(7);
				if (st.equals("-"))
					s = "NOT ATTENDED";
				else
					s = complaintMasterData.rs.getString(7);
				compForm.setComponentName(complaintMasterData.rs.getString(1));
				compForm.setComplntno(complaintMasterData.rs.getString(2));
				compForm.setComplntdt(complaintMasterData.rs.getString(3));
				compForm.setComplntdesc(complaintMasterData.rs.getString(4));
				compForm.setAttenby(complaintMasterData.rs.getString(5));
				compForm.setAttendt(complaintMasterData.rs.getString(6));
				compForm.setStatus(s);
				compForm.setRemarksby(complaintMasterData.rs.getString(8));
				compForm.setRepName(complaintMasterData.rs.getString(9));
				compForm.setName(complaintMasterData.rs.getString(10));
				compForm.setAddress(complaintMasterData.rs.getString(11));
				complaints.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return complaints;
	}

	public ArrayList getUrbCompDistrictsgeneric(DataSource dataSource) throws Exception {
		ArrayList districts;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		LabelValueBean compForm = null;
		districts = new ArrayList();
		String query = "";
		try {
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			query = "select distinct d.dcode,d.dname from urban_district_tbl d,rws_generic_complaints_reg_tbl c where d.dcode=substr(c.habitation_code,1,2) order by d.dname";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			
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
			
		}
		return districts;
	}

	public ArrayList getUrbCompMandalsgenericno(String dcode, DataSource dataSource) throws Exception {
		ArrayList mandals;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		LabelValueBean compForm = null;
		mandals = new ArrayList();
		String query = "";
		try {
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();

			query = "select distinct d.dcode,d.mcode,d.mname from urban_mandal_tbl d,rws_generic_complaints_reg_tbl c where  d.dcode='"
					+ dcode
					+ "' and d.mcode=substr(c.habitation_code,3,2) and d.dcode=substr(c.habitation_code,1,2) order by d.mname";
			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			
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
			
		}
		return mandals;
	}

	public ArrayList getUrbComplaintnodatesgeneric(String dcode, String mcode, DataSource dataSource) throws Exception {
		ArrayList complaints;
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		CompForm compForm = null;
		complaints = new ArrayList();
		String query = "";
		try {
			
			
			complaintMasterData.conn = RwsOffices.getConn();
			complaintMasterData.stmt = complaintMasterData.conn.createStatement();
			// query = "select distinct
			// complaint_no,to_char(complaint_date,'dd/mm/yyyy'),nvl(m.asset_name,'-'),complaint_desc,decode(category_code,'01','PUMP
			// DAMAGED','02','LEAKING')result,r.rep_name from rws_complaints_register_tbl
			// a,rws_asset_mast_tbl m,rws_public_rep_tbl r where r.rep_code=a.rep_code and
			// m.asset_code=a.asset_code and substr(component_code,1,2)='" + dcode + "' and
			// substr(component_code,6,2)='" + mcode + "' and substr(component_code,13,2)='"
			// + pcode + "' order by complaint_no";
			query = "select distinct complaint_no,to_char(complaint_date,'dd/mm/yyyy'),component_name,complaint_desc,r.rep_name from rws_generic_complaints_reg_tbl a,rws_public_rep_tbl r where r.rep_code=a.rep_code  and substr(habitation_code,1,2)='"
					+ dcode + "' and substr(habitation_code,3,2)='" + mcode + "'  order by complaint_no ";
			

			complaintMasterData.rs = complaintMasterData.stmt.executeQuery(query);
			while (complaintMasterData.rs.next()) {
				compForm = new CompForm();
				compForm.setComplntno(complaintMasterData.rs.getString(1));
				compForm.setComplntdt(complaintMasterData.rs.getString(2));
				compForm.setComponentName(complaintMasterData.rs.getString(3));
				compForm.setComplntdesc(complaintMasterData.rs.getString(4));
				compForm.setRepName(complaintMasterData.rs.getString(5));
				complaints.add(compForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getcomplaints=" + e);
		} finally {
			complaintMasterData.closeAll();
			
		}
		return complaints;
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

}
