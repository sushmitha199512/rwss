package nic.watersoft.masters;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.sql.DataSource;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;

public class rws_panchayat_sarpanch_dao

{
	public int insertSarpanch(rws_panchayat_sarpanch_form myForm) throws Exception {
		String query = "";
		int rcount = 0;
		Connection conn = null;
		PreparedStatement stmt = null;

		try {
			conn = RwsOffices.getConn();

			String location = myForm.getDistrict() + myForm.getMandal() + myForm.getPanchayat();
			String fromDate = myForm.getFrmDate();

			if (!isExists(location, conn, fromDate) && !isExists1(location, conn, fromDate)) {

				query = "insert into rws_panchayat_sarpanch_tbl(LOCATION,SARPANCH_NAME,MOBILE_NO,STATUS,FRM_DATE,TODATE,EMAIL)"
						+ " values(?,?,?,?,to_date(?,'dd/mm/yyyy'),to_date(?,'dd/mm/yyyy'),?)";

				stmt = conn.prepareStatement(query);
				stmt.setString(1, location);
				stmt.setString(2, myForm.getSarpanchName());
				stmt.setString(3, myForm.getSarpanchMobile());
				stmt.setString(4, myForm.getStatus());
				stmt.setString(5, myForm.getFrmDate());
				stmt.setString(6, myForm.getToDate());
				stmt.setString(7, myForm.getSarpanchEmailId());

				rcount = stmt.executeUpdate();
			}

		} catch (Exception e) {

			System.out.println("The Exception in insertSarpanch=" + e);

		} finally {
			if (conn != null) {

				conn.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return rcount;
	}

	public int updateSarpanch(rws_panchayat_sarpanch_form myForm) throws Exception {
		String query = "";
		int rcount = 0;
		Connection conn = null;
		PreparedStatement stmt = null;

		try {
			conn = RwsOffices.getConn();

			String location = myForm.getDistrict() + myForm.getMandal() + myForm.getPanchayat();

			String status = myForm.getStatus();
			String toDate = myForm.getToDate();
			if (toDate == null) {
				myForm.setToDate("");
			}
			if (status.equals("N")) {
				query = "update rws_panchayat_sarpanch_tbl set sarpanch_name=?, mobile_no=?, status=?,FRM_DATE=to_date(?,'dd/mm/yyyy'),"
						+ "TODATE=to_date(?,'dd/mm/yyyy'),email=? where location=? and FRM_DATE=to_date(?,'dd/mm/yyyy')";
			}

			else {

				query = "update rws_panchayat_sarpanch_tbl set sarpanch_name=?, mobile_no=?, status=?,FRM_DATE=to_date(?,'dd/mm/yyyy'),"
						+ "TODATE=to_date(?,'dd/mm/yyyy'),email=? where location=? and FRM_DATE=to_date(?,'dd/mm/yyyy')";
			}
			stmt = conn.prepareStatement(query);
			stmt.setString(1, myForm.getSarpanchName());
			stmt.setString(2, myForm.getSarpanchMobile());
			stmt.setString(3, myForm.getStatus());
			stmt.setString(4, myForm.getFrmDate());
			stmt.setString(5, myForm.getToDate());
			stmt.setString(6, myForm.getSarpanchEmailId());
			stmt.setString(7, location);
			stmt.setString(8, myForm.getFrmDate1());

			rcount = stmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("exception in updateSarpanch=" + e);
		} finally {
			if (conn != null) {

				conn.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return rcount;
	}

	private boolean isExists(String location, Connection conn, String fromDate) {

		ResultSet rs = null;
		String query = "";
		PreparedStatement stmt1 = null;

		try {

			query = "select * from rws_panchayat_sarpanch_tbl where location=? and  FRM_DATE=? ";

			stmt1 = conn.prepareStatement(query);
			stmt1.setString(1, location);
			stmt1.setString(2, fromDate);

			rs = stmt1.executeQuery();

			if (rs.next()) {
				return true;

			} else {
				return false;
			}

		} catch (Exception e) {
			System.out.println("exception in isExists--" + e);
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
			} catch (Exception e) {
				System.out.println("exception in isExists ==" + e);
			}
		}

		return false;
	}

	private boolean isExists1(String location, Connection conn, String fromDate) {
		ResultSet rs = null;
		String query = "";
		PreparedStatement stmt1 = null;

		try {

			query = "select max(FRM_DATE),todate from rws_panchayat_sarpanch_tbl where location=?  group by todate";

			stmt1 = conn.prepareStatement(query);
			stmt1.setString(1, location);

			rs = stmt1.executeQuery();
			if (rs.next()) {
				String todate = rs.getString("todate");

				if (todate == null) {
					return true;

				} else {
					return false;
				}

			} else {
				return false;
			}

		} catch (Exception e) {
			System.out.println("exception in isExists1--" + e);
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
			} catch (Exception e) {
				System.out.println("exception in isExists1--" + e);
			}
		}

		return false;
	}

	public rws_panchayat_sarpanch_form getDetails(String dcode, String mcode, String pcode, String frmDate,
			String toDate) {
		ArrayList sarpanchList = new ArrayList();
		ResultSet rs = null;
		String query = "";
		String location = dcode + mcode + pcode;
		Connection conn = null;
		PreparedStatement stmt = null;
		rws_panchayat_sarpanch_form frm = null;
		try {
			conn = RwsOffices.getConn();

			query = "select  d.dcode,d.DNAME,m.mcode,m.mname,p.pcode,p.pname,a.SARPANCH_NAME,a.MOBILE_no,a.email,a.Status,"
					+ "to_char(a.FRM_DATE,'dd/mm/yyyy'),to_char(a.TODATE,'dd/mm/yyyy') from rws_panchayat_sarpanch_tbl a,rws_district_tbl d,"
					+ "rws_mandal_tbl m,rws_panchayat_tbl p where d.dcode=substr(location,1,2) and m.mcode =substr(location,3,2) and "
					+ "p.pcode=substr(location,5,2) and m.dcode=d.dcode and p.dcode=d.dcode and p.mcode=m.mcode and d.dcode=? "
					+ "and m.mcode=? and p.pcode=? and location=? and frm_date=to_date(?,'dd/mm/yyyy')";

			stmt = conn.prepareStatement(query);

			stmt.setString(1, dcode);
			stmt.setString(2, mcode);
			stmt.setString(3, pcode);
			stmt.setString(4, location);
			stmt.setString(5, frmDate);

			rs = stmt.executeQuery();
			while (rs.next()) {
				frm = new rws_panchayat_sarpanch_form();
				frm.setDcode(rs.getString(1));
				frm.setDname(rs.getString(2));
				frm.setMcode(rs.getString(3));
				frm.setMname(rs.getString(4));
				frm.setPcode(rs.getString(5));
				frm.setPname(rs.getString(6));
				frm.setSarpanchName(rs.getString(7));
				frm.setSarpanchMobile(rs.getString(8));
				frm.setSarpanchEmailId(rs.getString(9));
				frm.setStatus(rs.getString(10));
				frm.setFrmDate(rs.getString(11));
				frm.setToDate(rs.getString(12));
			}

		} catch (Exception e) {
			System.out.println("exception in editSarpanch=" + e);
		} finally {
			if (conn != null) {

				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println("exception in editSarpanch=" + e);
				}
			}
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					System.out.println("exception in editSarpanch=" + e);
				}
			}
		}
		return frm;
	}



	public ArrayList getSarpanchDetails(String dcode, String mcode, String pcode, DataSource dataSource) {
		String query1 = "";
		Connection conn = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		ArrayList sarpanchDetails = new ArrayList();
		try {
			conn = RwsOffices.getConn();

			query1 = "select  d.dcode,d.DNAME ,m.mcode,m.mname,p.pcode,p.pname,a.SARPANCH_NAME,a.MOBILE_no,"
					+ "decode(a.Status,'W','Working','N','Not Working'),to_char(a.FRM_DATE,'dd/mm/yyyy'),to_char(a.TODATE,'dd/mm/yyyy'),"
					+ "a.email  from rws_panchayat_sarpanch_tbl a,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p where"
					+ " d.dcode=substr(location,1,2) and m.mcode =substr(location,3,2) and p.pcode=substr(location,5,2) and m.dcode=d.dcode and"
					+ " p.dcode=d.dcode and p.mcode=m.mcode and d.dcode=? and m.mcode=? and p.pcode=? ";

			stmt1 = conn.prepareStatement(query1);
			stmt1.setString(1, dcode);
			stmt1.setString(2, mcode);
			stmt1.setString(3, pcode);

			rs1 = stmt1.executeQuery();
			while (rs1.next()) {
				rws_panchayat_sarpanch_form frm = new rws_panchayat_sarpanch_form();

				frm.setDcode(rs1.getString("DCODE"));
				frm.setDname(rs1.getString("DNAME"));
				frm.setMcode(rs1.getString("MCODE"));
				frm.setMname(rs1.getString("MNAME"));
				frm.setPcode(rs1.getString("PCODE"));
				frm.setPname(rs1.getString("PNAME"));
				frm.setSarpanchName(rs1.getString("SARPANCH_NAME"));
				frm.setSarpanchMobile(rs1.getString("MOBILE_no"));
				frm.setStatus(rs1.getString(9));
				frm.setFrmDate(rs1.getString(10));
				frm.setToDate(rs1.getString(11));
				frm.setSarpanchEmailId(rs1.getString(12));
				sarpanchDetails.add(frm);

			}

		}

		catch (SQLException e) {
			System.err.println("exception in getSarpanchDetails--" + e);
		}

		return sarpanchDetails;

	}

	public ArrayList getSarpanchDetails(String dcode) {
		String query1 = "";
		Connection conn = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		ArrayList sarpanchDetails = new ArrayList();
		try {
			conn = RwsOffices.getConn();

			query1 = "select  d.dcode,d.DNAME ,m.mcode,m.mname,p.pcode,p.pname,a.SARPANCH_NAME,a.MOBILE_no,"
					+ "decode(a.Status,'W','Working','N','Not Working'),to_char(a.FRM_DATE,'dd-mm-yyyy'),to_char(a.TODATE,'dd-mm-yyyy'),"
					+ "a.email from rws_panchayat_sarpanch_tbl a,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p where "
					+ "d.dcode=substr(location,1,2) and m.mcode =substr(location,3,2) and p.pcode=substr(location,5,2) and m.dcode=d.dcode and "
					+ "p.dcode=d.dcode and p.mcode=m.mcode and d.dcode=? ";

			stmt1 = conn.prepareStatement(query1);
			stmt1.setString(1, dcode);

			rs1 = stmt1.executeQuery();

			while (rs1.next()) {
				rws_panchayat_sarpanch_form frm = new rws_panchayat_sarpanch_form();

				frm.setDcode(rs1.getString("DCODE"));
				frm.setDname(rs1.getString("DNAME"));
				frm.setMcode(rs1.getString("MCODE"));
				frm.setMname(rs1.getString("MNAME"));
				frm.setPcode(rs1.getString("PCODE"));
				frm.setPname(rs1.getString("PNAME"));
				frm.setSarpanchName(rs1.getString("SARPANCH_NAME"));
				frm.setSarpanchMobile(rs1.getString("MOBILE_no"));
				frm.setStatus(rs1.getString(9));
				frm.setFrmDate(rs1.getString(10));
				frm.setToDate(rs1.getString(11));
				frm.setSarpanchEmailId(rs1.getString(12));
				sarpanchDetails.add(frm);

			}

		}

		catch (SQLException e) {
			System.out.println("sqlexception in getSarpanchDetails--" + e);
		}

		return sarpanchDetails;

	}

	public ArrayList getSarpanchDetails(String dcode, String mcode) {
		String query1 = "";
		Connection conn = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		ArrayList sarpanchDetails = new ArrayList();
		try {
			conn = RwsOffices.getConn();

			query1 = "select  d.dcode,d.DNAME ,m.mcode,m.mname,p.pcode,p.pname,a.SARPANCH_NAME,a.MOBILE_no,"
					+ "decode(a.Status,'W','Working','N','Not Working'),to_char(a.FRM_DATE,'dd/mm/yyyy'),to_char(a.TODATE,'dd/mm/yyyy'),"
					+ "a.email from rws_panchayat_sarpanch_tbl a,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p where "
					+ "d.dcode=substr(location,1,2) and m.mcode =substr(location,3,2) and p.pcode=substr(location,5,2) and m.dcode=d.dcode and"
					+ " p.dcode=d.dcode and p.mcode=m.mcode and d.dcode=? and m.mcode=? ";

			stmt1 = conn.prepareStatement(query1);
			stmt1.setString(1, dcode);
			stmt1.setString(2, mcode);

			rs1 = stmt1.executeQuery();
			while (rs1.next()) {
				rws_panchayat_sarpanch_form frm = new rws_panchayat_sarpanch_form();

				frm.setDcode(rs1.getString("DCODE"));
				frm.setDname(rs1.getString("DNAME"));
				frm.setMcode(rs1.getString("MCODE"));
				frm.setMname(rs1.getString("MNAME"));
				frm.setPcode(rs1.getString("PCODE"));
				frm.setPname(rs1.getString("PNAME"));
				frm.setSarpanchName(rs1.getString("SARPANCH_NAME"));
				frm.setSarpanchMobile(rs1.getString("MOBILE_no"));
				frm.setStatus(rs1.getString(9));
				frm.setFrmDate(rs1.getString(10));
				frm.setToDate(rs1.getString(11));
				frm.setSarpanchEmailId(rs1.getString(12));
				sarpanchDetails.add(frm);

			}

		}

		catch (SQLException e) {
			System.out.println("sqlexception in getSarpanchDetails----" + e);
		}

		return sarpanchDetails;

	}

	public void getSarpanchDetails(rws_panchayat_sarpanch_form myForm) {
		String query1 = "";
		Connection conn = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		try {
			conn = RwsOffices.getConn();

			query1 = "select  d.dcode,d.DNAME ,m.mcode,m.mname,p.pcode,p.pname,a.SARPANCH_NAME,a.MOBILE_no,"
					+ "decode(a.Status,'W','Working','N','Not Working'),to_char(a.FRM_DATE,'dd-mm-yyyy'),to_char(a.TODATE,'dd-mm-yyyy') from "
					+ "rws_panchayat_sarpanch_tbl a,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p where d.dcode=substr(location,1,2) and"
					+ " m.mcode =substr(location,3,2) and p.pcode=substr(location,5,2) and m.dcode=d.dcode and p.dcode=d.dcode and"
					+ " p.mcode=m.mcode and d.dcode=? and m.mcode=? and p.pcode=? ";

			stmt1 = conn.prepareStatement(query1);
			stmt1.setString(1, myForm.getDistrict());
			stmt1.setString(2, myForm.getMandal());
			stmt1.setString(3, myForm.getPanchayat());

			rs1 = stmt1.executeQuery();

			while (rs1.next()) {
				myForm.setSarpanchName(rs1.getString("SARPANCH_NAME"));
				myForm.setSarpanchMobile(rs1.getString("MOBILE_no"));
				myForm.setStatus(rs1.getString(9));
				myForm.setFrmDate(rs1.getString(10));
				myForm.setToDate(rs1.getString(11));

			}
		} catch (SQLException e) {
			System.out.println("exception in getSarpanchDetails with form --" + e);
		}
	}

	/* CEO ENTRY */

	public int insertceo(rws_panchayat_sarpanch_form myForm) throws Exception {
		String query = "";
		int rcount = 0;
		Connection conn = null;
		PreparedStatement stmt = null, stmt1 = null;

		try {
			conn = RwsOffices.getConn();
			String dcode = myForm.getDistrict();
			String fromDate = myForm.getFrmDate();

			if (!isExistsceo(dcode, conn, "CEO")) {

				query = "insert into rws_ceo_tbl(DCODE,CEO_DPO,CEO_NAME,MOBILE_NO,EMAIL) values(?,?,?,?,?)";
				stmt = conn.prepareStatement(query);
				stmt.setString(1, dcode);
				stmt.setString(2, "CEO");
				stmt.setString(3, myForm.getCeoName());
				stmt.setString(4, myForm.getCeoMobile());
				stmt.setString(5, myForm.getCeoEmailId());

			}

			else {
				query = "update rws_ceo_tbl set ceo_name=?, mobile_no=?, EMAIL=? where dcode=? and  CEO_DPO=? ";
				stmt = conn.prepareStatement(query);
				stmt.setString(1, myForm.getCeoName());
				stmt.setString(2, myForm.getCeoMobile());
				stmt.setString(3, myForm.getCeoEmailId());
				stmt.setString(4, dcode);
				stmt.setString(5, "CEO");

			}
			rcount = stmt.executeUpdate();

			if (!isExistsDPO(dcode, conn, "DPO")) {

				query = "insert into rws_ceo_tbl(DCODE,CEO_DPO,CEO_NAME,MOBILE_NO,EMAIL) values(?,?,?,?,?)";
				stmt1 = conn.prepareStatement(query);
				stmt1.setString(1, dcode);
				stmt1.setString(2, "DPO");
				stmt1.setString(3, myForm.getDpoName());
				stmt1.setString(4, myForm.getDpoMobile());
				stmt1.setString(5, myForm.getDpoEmailId());

			}

			else {
				query = "update rws_ceo_tbl set ceo_name=?,mobile_no=?, EMAIL=? where dcode=? and  CEO_DPO=? ";
				stmt1 = conn.prepareStatement(query);
				stmt1.setString(1, myForm.getDpoName());
				stmt1.setString(2, myForm.getDpoMobile());
				stmt1.setString(3, myForm.getDpoEmailId());
				stmt1.setString(4, dcode);
				stmt1.setString(5, "DPO");

			}

			rcount += stmt1.executeUpdate();

		} catch (Exception e) {
			System.out.println("exception in insertceo --" + e);
		} finally {
			if (conn != null) {

				conn.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return rcount;
	}

	public int updateceo(rws_panchayat_sarpanch_form myForm) throws Exception {
		String query = "";
		int rcount = 0;
		Connection conn = null;
		PreparedStatement stmt = null;

		try {
			conn = RwsOffices.getConn();

			String location = myForm.getDistrict();
			String status = myForm.getStatus();

			String toDate = myForm.getToDate();
			if (toDate == null) {
				myForm.setToDate("");
			}
			if (status.equals("N")) {

				query = "update rws_ceo_tbl set ceo_name=?,mobile_no=? ,status=?,FRM_DATE=to_date(?,'dd/mm/yyyy') ,"
						+ "TODATE=to_date(?,'dd/mm/yyyy'),EMAIL=? where dcode=? and FRM_DATE=to_date(?,'dd/mm/yyyy') ";

				stmt = conn.prepareStatement(query);
				stmt.setString(1, myForm.getCeoName());
				stmt.setString(2, myForm.getCeoMobile());
				stmt.setString(3, myForm.getStatus());
				stmt.setString(4, myForm.getFrmDate());
				stmt.setString(5, myForm.getToDate());
				stmt.setString(6, myForm.getCeoEmailId());
				stmt.setString(7, location);
				stmt.setString(8, myForm.getFrmDate());

			} else {

				query = "update rws_ceo_tbl set ceo_name=?,mobile_no=?,status=?,FRM_DATE=to_date(?,'dd/mm/yyyy') ,"
						+ "TODATE=to_date(?,'dd/mm/yyyy'),EMAIL=? where dcode=? and FRM_DATE=to_date(?,'dd/mm/yyyy') ";

				stmt = conn.prepareStatement(query);
				stmt.setString(1, myForm.getCeoName());
				stmt.setString(2, myForm.getCeoMobile());
				stmt.setString(3, myForm.getStatus());
				stmt.setString(4, myForm.getFrmDate());
				stmt.setString(5, myForm.getToDate());
				stmt.setString(6, myForm.getCeoEmailId());
				stmt.setString(7, location);
				stmt.setString(8, myForm.getFrmDate());
			}

			rcount = stmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("exception in updateceo" + e);
		} finally {
			if (conn != null) {

				conn.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return rcount;
	}

	private boolean isExistsceo(String dcode, Connection conn, String CEO) {

		ResultSet rs = null;
		String query = "";
		PreparedStatement stmt1 = null;

		try {

			query = "select * from rws_CEO_tbl where dcode=? and CEO_DPO =? ";

			stmt1 = conn.prepareStatement(query);
			stmt1.setString(1, dcode);
			stmt1.setString(2, CEO);


			rs = stmt1.executeQuery();
			if (rs.next()) {
				return true;

			} else {
				return false;
			}

		} catch (Exception e) {
			System.out.println("exception in isExistsceo" + e);
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
			} catch (Exception e) {
				System.out.println("exception in isExistsceo" + e);
			}
		}

		return false;
	}

	private boolean isExistsDPO(String dcode, Connection conn, String DPO) {

		ResultSet rs = null;
		String query = "";
		PreparedStatement stmt1 = null;

		try {

			query = "select * from rws_CEO_tbl where dcode=?  and CEO_DPO =? ";
			stmt1 = conn.prepareStatement(query);
			stmt1.setString(1, dcode);
			stmt1.setString(2, DPO);
			rs = stmt1.executeQuery();
			if (rs.next()) {
				return true;

			} else {
				return false;
			}

		} catch (Exception e) {
			System.out.println("exception in isExistsDPO" + e);
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
			} catch (Exception e) {
				System.out.println("exception in isExistsDPO" + e);
			}
		}

		return false;
	}

	private boolean isExistsceo1(String location, Connection conn) {

		ResultSet rs = null;
		String query = "";
		Statement stmt1 = null;

		try {
			stmt1 = conn.createStatement();
			query = "select max(FRM_DATE),todate from rws_CEO_tbl where dcode='" + location + "' group by todate";
			rs = stmt1.executeQuery(query);
			if (rs.next()) {
				String todate = rs.getString("todate");
				if (todate == null) {
					return true;

				} else {
					return false;
				}

			} else {
				return false;
			}

		} catch (Exception e) {
			Debug.println("exception in isExistsceo1=" + e);
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
			} catch (Exception e) {
				Debug.println("exception in isExistsceo1=" + e);
			}
		}

		return false;
	}

	public ArrayList getceoDetails(String dcode, DataSource dataSource) {
		String query1 = "";
		Connection conn = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		ArrayList ceoDetails = new ArrayList();
		try {
			conn = RwsOffices.getConn();

			query1 = "select b.dcode,b.dname,a.CEO_NAME,a.MOBILE_no,a.email,a.CEO_DPO from "
					+ "rws_ceo_tbl a,rws_district_tbl b	where a.dcode=b.dcode and a.dcode=?  ";
			stmt1 = conn.prepareStatement(query1);
			stmt1.setString(1, dcode);
			rs1 = stmt1.executeQuery();

			while (rs1.next()) {
				rws_panchayat_sarpanch_form frm = new rws_panchayat_sarpanch_form();

				frm.setDcode(rs1.getString("DCODE"));
				frm.setDname(rs1.getString("DNAME"));
				frm.setCeoName(rs1.getString("CEO_NAME"));
				frm.setCeoMobile(rs1.getString("MOBILE_no"));
				frm.setCeoEmailId(rs1.getString("EMAIL"));
				frm.setDesignation1(rs1.getString("CEO_DPO"));
				ceoDetails.add(frm);

			}

		}

		catch (SQLException e) {
			System.out.println("Exception in getceoDetails of rws_panchayat_sarpanch_dao -- " + e);
		}

		return ceoDetails;

	}

	public ArrayList getceoDetails() {
		String query1 = "";
		Connection conn = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		ArrayList sarpanchDetails = new ArrayList();
		try {
			conn = RwsOffices.getConn();

			query1 = "select a.dcode,b.dname,a.CEO_NAME,a.MOBILE_no,decode(a.Status,'W','Working','N','Not Working') "
					+ "as status,to_char(a.FRM_DATE,'dd-mm-yyyy') as frm_date,to_char(a.TODATE,'dd-mm-yyyy') "
					+ "as todate,a.email from rws_ceo_tbl a,rws_district_tbl b	where a.dcode=b.dcode and status=? ";
			stmt1 = conn.prepareStatement(query1);
			stmt1.setString(1, "W");
			rs1 = stmt1.executeQuery();
			while (rs1.next()) {
				rws_panchayat_sarpanch_form frm = new rws_panchayat_sarpanch_form();

				frm.setDcode(rs1.getString("DCODE"));
				frm.setDname(rs1.getString("DNAME"));
				frm.setCeoName(rs1.getString("CEO_NAME"));
				frm.setCeoMobile(rs1.getString("MOBILE_NO"));
				frm.setStatus(rs1.getString("STATUS"));
				frm.setFrmDate(rs1.getString("FRM_DATE"));
				frm.setToDate(rs1.getString("TODATE"));
				frm.setCeoEmailId(rs1.getString("EMAIL"));
				sarpanchDetails.add(frm);

			}

		}

		catch (SQLException e) {
			System.out.println("exception in getceoDetails method of rws_panchayat_sarpanch_dao  " + e);
		}

		return sarpanchDetails;

	}

	public void getceoDetails(rws_panchayat_sarpanch_form myForm) {
		String query1 = "";
		Connection conn = null;
		PreparedStatement stmt1 = null, stmt = null;
		ResultSet rs1 = null, rs = null;
		try {
			conn = RwsOffices.getConn();

			query1 = " select a.dcode,b.dname,a.CEO_NAME,a.MOBILE_no,a.email from rws_ceo_tbl a,rws_district_tbl b"
					+ " where a.dcode=b.dcode  and a.dcode=? and a.CEO_DPO=? ";
			stmt = conn.prepareStatement(query1);
			stmt.setString(1, myForm.getDistrict());
			stmt.setString(2, "CEO");
			rs = stmt.executeQuery();

			while (rs.next()) {
				myForm.setCeoName(rs.getString("CEO_NAME"));
				myForm.setCeoMobile(rs.getString("MOBILE_no"));

				myForm.setCeoEmailId(rs.getString("EMAIL"));
			}

			query1 = " select a.dcode,b.dname,a.CEO_NAME,a.MOBILE_no,a.email from rws_ceo_tbl a,rws_district_tbl b "
					+ "where a.dcode=b.dcode  and a.dcode=? and a.CEO_DPO=? ";
			stmt1 = conn.prepareStatement(query1);
			stmt1.setString(1, myForm.getDistrict());
			stmt1.setString(2, "DPO");
			rs1 = stmt1.executeQuery();

			while (rs1.next()) {
				myForm.setDpoName(rs1.getString("CEO_NAME"));
				myForm.setDpoMobile(rs1.getString("MOBILE_no"));

				myForm.setDpoEmailId(rs1.getString("EMAIL"));
			}

		} catch (SQLException e) {
			System.out.println("exception in getceoDetails with form method of rws_panchayat_sarpanch_dao  " + e);
		}
	}

	/* END OF CEO ENTRY */

	/* MPDO ENTRY */
	public int insertmpdo(rws_panchayat_sarpanch_form myForm) throws Exception {
		String query = "";
		int rcount = 0;
		Connection conn = null;
		PreparedStatement stmt = null;

		try {
			conn = RwsOffices.getConn();

			String dist = myForm.getDistrict();
			String mandal = myForm.getMandal();
			String mpdomro = myForm.getDesignation();
			String status = myForm.getStatus();
			String fromDate = myForm.getFrmDate();
			String toDate = myForm.getToDate();

			if (!isExistsmpdo(dist, mandal, conn, "MPDO")) {

				query = "insert into RWS_MRO_MPDO_TBL (DCODE,MCODE,NAME,MRO_MPDO_SECTION,MOBILE_NO,STATUS,EMAIL) "
						+ " values(?,?,?,?,?,?,?)";
				stmt = conn.prepareStatement(query);
				stmt.setString(1, dist);
				stmt.setString(2, mandal);
				stmt.setString(3, myForm.getMpdoName());
				stmt.setString(4, "MPDO");
				stmt.setString(5, myForm.getMpdoMobile());
				stmt.setString(6, "W");
				stmt.setString(7, myForm.getMpdoEmailId());
				rcount = stmt.executeUpdate();
			} else {
				query = "update RWS_MRO_MPDO_TBL set name=?,mobile_no=?,email=?,status=? where dcode=? and "
						+ "mcode=? and MRO_MPDO_SECTION =? ";
				stmt = conn.prepareStatement(query);

				stmt.setString(1, myForm.getMpdoName());
				stmt.setString(2, myForm.getMpdoMobile());
				stmt.setString(3, myForm.getMpdoEmailId());
				stmt.setString(4, "W");
				stmt.setString(5, dist);
				stmt.setString(6, mandal);
				stmt.setString(7, "MPDO");

				rcount = stmt.executeUpdate();
			}

			if (!isExistsmpdo(dist, mandal, conn, "MRO")) {

				query = "insert into RWS_MRO_MPDO_TBL  (DCODE,MCODE,NAME,MRO_MPDO_SECTION,MOBILE_NO,STATUS,EMAIL) "
						+ "values(?,?,?,?,?,?,?)";

				stmt = conn.prepareStatement(query);

				stmt.setString(1, dist);
				stmt.setString(2, mandal);
				stmt.setString(3, myForm.getMroName());
				stmt.setString(4, "MRO");
				stmt.setString(5, myForm.getMroMobile());
				stmt.setString(6, "W");
				stmt.setString(7, myForm.getMroEmailId());

				rcount += stmt.executeUpdate();

			} else {
				query = "update RWS_MRO_MPDO_TBL set name=?,mobile_no=?,email=?,status=? where dcode=? and "
						+ "mcode=? and MRO_MPDO_SECTION =? ";

				stmt = conn.prepareStatement(query);

				stmt.setString(1, myForm.getMroName());
				stmt.setString(2, myForm.getMroMobile());
				stmt.setString(3, myForm.getMroEmailId());
				stmt.setString(4, "W");
				stmt.setString(5, dist);
				stmt.setString(6, mandal);
				stmt.setString(7, "MRO");
				rcount = stmt.executeUpdate();
			}

			if (!isExistsmpdo(dist, mandal, conn, "Section Officer")) {

				query = "insert into RWS_MRO_MPDO_TBL  (DCODE,MCODE,NAME,MRO_MPDO_SECTION,MOBILE_NO,STATUS,EMAIL) "
						+ "values(?,?,?,?,?,?,?)";

				stmt = conn.prepareStatement(query);

				stmt.setString(1, dist);
				stmt.setString(2, mandal);
				stmt.setString(3, myForm.getSfName());
				stmt.setString(4, "Section Officer");
				stmt.setString(5, myForm.getSfMobile());
				stmt.setString(6, "W");
				stmt.setString(7, myForm.getSfEmailId());

				rcount += stmt.executeUpdate();

			} else {
				query = "update RWS_MRO_MPDO_TBL set name=?,mobile_no=?,email=?,status=? where dcode=? and "
						+ "mcode=? and MRO_MPDO_SECTION =? ";

				stmt = conn.prepareStatement(query);

				stmt.setString(1, myForm.getSfName());
				stmt.setString(2, myForm.getSfMobile());
				stmt.setString(3, myForm.getSfEmailId());
				stmt.setString(4, "W");
				stmt.setString(5, dist);
				stmt.setString(6, mandal);
				stmt.setString(7, "Section Officer");

				rcount = stmt.executeUpdate();
			}

			if (!isExistsmpdo(dist, mandal, conn, "EORD")) {

				query = "insert into RWS_MRO_MPDO_TBL  (DCODE,MCODE,NAME,MRO_MPDO_SECTION,MOBILE_NO,STATUS,EMAIL) "
						+ "values(?,?,?,?,?,?,?)";

				stmt = conn.prepareStatement(query);

				stmt.setString(1, dist);
				stmt.setString(2, mandal);
				stmt.setString(3, myForm.getEordName());
				stmt.setString(4, "EORD");
				stmt.setString(5, myForm.getEordMobile());
				stmt.setString(6, "W");
				stmt.setString(7, myForm.getEordEmailId());

				rcount += stmt.executeUpdate();
			} else {
				query = "update RWS_MRO_MPDO_TBL set name=?,mobile_no=?,email=?,status=? where dcode=? and "
						+ "mcode=? and MRO_MPDO_SECTION =? ";

				stmt = conn.prepareStatement(query);

				stmt.setString(1, myForm.getEordName());
				stmt.setString(2, myForm.getEordMobile());
				stmt.setString(3, myForm.getEordEmailId());
				stmt.setString(4, "W");
				stmt.setString(5, dist);
				stmt.setString(6, mandal);
				stmt.setString(7, "EORD");

				rcount = stmt.executeUpdate();
			}

		} catch (Exception e) {
			System.out.println("exception in insertMPDO=" + e);
		} finally {
			if (conn != null) {

				conn.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return rcount;
	}


	public int updatempdo(rws_panchayat_sarpanch_form myForm) throws Exception {
		String query = "";
		int rcount = 0;
		Connection conn = null;
		PreparedStatement stmt = null;

		try {
			conn = RwsOffices.getConn();

			String dist = myForm.getDistrict();
			String mandal = myForm.getMandal();
			String mpdomro = myForm.getDesignation();
			String status = myForm.getStatus();
			String toDate = myForm.getToDate();

			if (toDate == null) {
				myForm.setToDate("");
			}
			if (status.equals("N")) {

				query = "update RWS_MRO_MPDO_TBL set name=?,MRO_MPDO_SECTION =?, mobile_no=?,email=?,status=?,"
						+ "FRM_DATE=to_date(?,'dd/mm/yyyy') ,TODATE=to_date(?,'dd/mm/yyyy') where dcode=? and mcode=?"
						+ " and MRO_MPDO_SECTION =? and FRM_DATE=to_date(?,'dd/mm/yyyy') ";
				stmt = conn.prepareStatement(query);
				stmt.setString(1, myForm.getMpdoName());
				stmt.setString(2, myForm.getDesignation());
				stmt.setString(3, myForm.getMpdoMobile());
				stmt.setString(4, myForm.getMpdoEmailId());
				stmt.setString(5, myForm.getStatus());
				stmt.setString(6, myForm.getFrmDate());
				stmt.setString(7, myForm.getToDate());
				stmt.setString(8, dist);
				stmt.setString(9, mandal);
				stmt.setString(10, mpdomro);
				stmt.setString(11, myForm.getFrmDate());

			}

			else {

				query = "update RWS_MRO_MPDO_TBL set name=?,MRO_MPDO_SECTION =?,mobile_no=?,email=?,status=? ,"
						+ "TODATE=to_date(?,'dd/mm/yyyy') where dcode=? and mcode=? and MRO_MPDO_SECTION=? and"
						+ " FRM_DATE=to_date(?,'dd/mm/yyyy')";
				stmt = conn.prepareStatement(query);
				stmt.setString(1, myForm.getMpdoName());
				stmt.setString(2, myForm.getDesignation());
				stmt.setString(3, myForm.getMpdoMobile());
				stmt.setString(4, myForm.getMpdoEmailId());
				stmt.setString(5, myForm.getStatus());
				stmt.setString(6, myForm.getToDate());
				stmt.setString(7, dist);
				stmt.setString(8, mandal);
				stmt.setString(9, mpdomro);
				stmt.setString(10, myForm.getFrmDate());


			}
			rcount = stmt.executeUpdate();

		} catch (Exception e) {
			System.out.println("exception in updateMPDO=" + e);
		} finally {
			if (conn != null) {

				conn.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return rcount;
	}

	private boolean isExistsmpdo(String dcode, String mandal, Connection conn, String mpdomro) throws Exception {

		ResultSet rs = null;
		String query = "";
		PreparedStatement stmt1 = null;

		try {

			query = "select * from RWS_MRO_MPDO_TBL where dcode=? and mcode=? and MRO_MPDO_SECTION =? ";
			stmt1 = conn.prepareStatement(query);
			stmt1.setString(1, dcode);
			stmt1.setString(2, mandal);
			stmt1.setString(3, mpdomro);

			rs = stmt1.executeQuery();
			if (rs.next()) {

				return true;

			} else {
				return false;
			}

		} catch (Exception e) {
			System.out.println("exception in isExistsmpdo ---" + e);
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
			} catch (Exception e) {
				System.out.println("exception in isExistsmpdo ---" + e);
			}
		}

		return false;
	}

	private boolean isExistsmpdo1(String dcode, String mandal, Connection conn, String mpdomro, String toDate) {

		ResultSet rs = null;
		String query = "";
		Statement stmt1 = null;

		try {
			stmt1 = conn.createStatement();
			query = "select max(FRM_DATE),todate from RWS_MRO_MPDO_TBL where dcode='" + dcode + "' and mcode='" + mandal
					+ "' and MRO_MPDO_SECTION ='" + mpdomro + "'  group by todate";

			rs = stmt1.executeQuery(query);
			if (rs.next()) {

				String todate = rs.getString("todate");
				if (todate == null) {
					return true;

				} else {
					return false;
				}

			} else {
				return false;
			}

		} catch (Exception e) {
			System.out.println("exception in isExistsmpdo1 ---" + e);
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
			} catch (Exception e) {
				System.out.println("exception in isExistsmpdo1---" + e);
			}
		}

		return false;
	}

	public ArrayList getmpdoDetails(String dist, String mand, DataSource dataSource) {
		String query1 = "";
		Connection conn = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		ArrayList sarpanchDetails = new ArrayList();
		try {
			conn = RwsOffices.getConn();

			query1 = "select  d.dcode,d.DNAME ,m.mcode,m.mname,a.MRO_MPDO_SECTION,a.name,a.mobile_no,"
					+ "decode(a.Status,'W','Working','N','Not Working') as status,to_char(a.FRM_DATE,'dd-mm-yyyy') as frm_date,"
					+ "to_char(a.TODATE,'dd-mm-yyyy') as todate,a.email from RWS_MRO_MPDO_TBL a , rws_district_tbl d,rws_mandal_tbl m where "
					+ "a.dcode=m.dcode and a.mcode=m.mcode and m.dcode =d.dcode and a.dcode=? and a.mcode=? ";
			stmt1 = conn.prepareStatement(query1);
			stmt1.setString(1, dist);
			stmt1.setString(2, mand);
			rs1 = stmt1.executeQuery();

			while (rs1.next()) {
				rws_panchayat_sarpanch_form frm = new rws_panchayat_sarpanch_form();

				frm.setDcode(rs1.getString("DCODE"));
				frm.setDname(rs1.getString("DNAME"));
				frm.setMcode(rs1.getString("MCODE"));
				frm.setMname(rs1.getString("MNAME"));
				frm.setDesignation(rs1.getString("MRO_MPDO_SECTION"));
				frm.setMpdoName(rs1.getString("NAME"));
				frm.setMpdoMobile(rs1.getString("MOBILE_NO"));
				frm.setMpdoEmailId(rs1.getString("EMAIL"));
				frm.setStatus(rs1.getString("STATUS"));
				frm.setFrmDate(rs1.getString("FRM_DATE"));
				frm.setToDate(rs1.getString("TODATE"));
				sarpanchDetails.add(frm);

			}

		}

		catch (SQLException e) {
			System.out.println("exception in getmpdoDetails " + e);
		}

		return sarpanchDetails;

	}

	public ArrayList getmpdoDetails(String dist) {
		String query1 = "";
		Connection conn = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		@SuppressWarnings("rawtypes")
		ArrayList sarpanchDetails = new ArrayList();
		try {
			conn = RwsOffices.getConn();

			query1 = "select  d.dcode,d.DNAME ,m.mcode,m.mname,a.MRO_MPDO_SECTION ,a.name,a.mobile_no,"
					+ "decode(a.Status,'W','Working','N','Working') as status,to_char(a.FRM_DATE,'dd-mm-yyyy') as frm_date,"
					+ "to_char(a.TODATE,'dd-mm-yyyy') "
					+ " as todate,a.email from RWS_MRO_MPDO_TBL a,rws_district_tbl d,rws_mandal_tbl m "
					+ "where a.dcode=m.dcode and a.mcode=m.mcode and m.dcode=d.dcode and d.dcode=? ";
			stmt1 = conn.prepareStatement(query1);
			stmt1.setString(1, dist);
			rs1 = stmt1.executeQuery();
			while (rs1.next()) {
				rws_panchayat_sarpanch_form frm = new rws_panchayat_sarpanch_form();

				frm.setDcode(rs1.getString("DCODE"));
				frm.setDname(rs1.getString("DNAME"));
				frm.setMcode(rs1.getString("MCODE"));
				frm.setMname(rs1.getString("MNAME"));
				frm.setDesignation(rs1.getString("MRO_MPDO_SECTION"));
				frm.setMpdoName(rs1.getString("NAME"));
				frm.setMpdoMobile(rs1.getString("MOBILE_NO"));
				frm.setMpdoEmailId(rs1.getString("EMAIL"));
				frm.setStatus(rs1.getString("STATUS"));
				frm.setFrmDate(rs1.getString("FRM_DATE"));
				frm.setToDate(rs1.getString("TODATE"));
				sarpanchDetails.add(frm);

			}

		}

		catch (SQLException e) {
			System.out.println("exception in getmpdoDetails--" + e);
		}

		return sarpanchDetails;

	}

	public ArrayList getmpdoDetails(String dist, String mandal) {
		String query1 = "";
		Connection conn = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		ArrayList sarpanchDetails = new ArrayList();
		try {
			conn = RwsOffices.getConn();

			query1 = "select  d.dcode,d.DNAME ,m.mcode,m.mname,a.name,a.MRO_MPDO_SECTION,a.MOBILE_no,"
					+ "decode(a.Status,'W','Working','N','Not Working') as status ,to_char(a.FRM_DATE,'dd-mm-yyyy') as frm_date,"
					+ "to_char(a.TODATE,'dd-mm-yyyy')  as todate,a.email from RWS_MRO_MPDO_TBL a,rws_district_tbl d,rws_mandal_tbl m where "
					+ "a.dcode=m.dcode and a.mcode=m.mcode and m.dcode=d.dcode and a.dcode=?  and a.mcode =? ";
			stmt1 = conn.prepareStatement(query1);
			stmt1.setString(1, dist);
			stmt1.setString(2, mandal);

			rs1 = stmt1.executeQuery();
			while (rs1.next()) {
				rws_panchayat_sarpanch_form frm = new rws_panchayat_sarpanch_form();

				frm.setDcode(rs1.getString("DCODE"));
				frm.setDname(rs1.getString("DNAME"));
				frm.setMcode(rs1.getString("MCODE"));
				frm.setMname(rs1.getString("MNAME"));
				frm.setDesignation(rs1.getString("MRO_MPDO_SECTION"));
				frm.setMpdoName(rs1.getString("NAME"));
				frm.setMpdoMobile(rs1.getString("MOBILE_NO"));
				frm.setMpdoEmailId(rs1.getString("EMAIL"));
				frm.setStatus(rs1.getString("STATUS"));
				frm.setFrmDate(rs1.getString("FRM_DATE"));
				frm.setToDate(rs1.getString("TODATE"));
				sarpanchDetails.add(frm);

			}

		}

		catch (SQLException e) {
			System.out.println("exeception in getmpdoDetails--" + e);
		}

		return sarpanchDetails;

	}

	public void getmpdoDetails(rws_panchayat_sarpanch_form myForm) {
		String query1 = "";
		Connection conn = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		try {
			conn = RwsOffices.getConn();

			query1 = "select  d.dcode,d.DNAME ,m.mcode,m.mname,a.NAME,a.MRO_MPDO_SECTION,a.MOBILE_no,decode(a.Status,'W','Working','R','Retired') as status,"
					+ "to_char(a.FRM_DATE,'dd-mm-yyyy') as frm_date ,to_char(a.TODATE,'dd-mm-yyyy') as todate,a.email from RWS_MRO_MPDO_TBL a,"
					+ "rws_district_tbl d,rws_mandal_tbl m where a.dcode=m.dcode and a.mcode=m.mcode and m.dcode=d.dcode and "
					+ "d.dcode=? and m.mcode=? ";
			stmt1 = conn.prepareStatement(query1);
			stmt1.setString(1, myForm.getDistrict());
			stmt1.setString(2, myForm.getMandal());
			rs1 = stmt1.executeQuery();
			while (rs1.next()) {
				myForm.setDcode(rs1.getString("DCODE"));
				myForm.setDname(rs1.getString("DNAME"));
				myForm.setMcode(rs1.getString("MCODE"));
				myForm.setMname(rs1.getString("MNAME"));
				myForm.setDesignation(rs1.getString("MRO_MPDO_SECTION"));
				myForm.setMpdoName(rs1.getString("NAME"));
				myForm.setMpdoMobile(rs1.getString("MOBILE_NO"));
				myForm.setMpdoEmailId(rs1.getString("EMAIL"));
				myForm.setStatus(rs1.getString("STATUS"));
				myForm.setFrmDate(rs1.getString("FRM_DATE"));
				myForm.setToDate(rs1.getString("TODATE"));

			}
		} catch (SQLException e) {
			System.out.println("exeception in getmpdoDetails with form--" + e);
		}
	}

	public void getmpdoDetails1(rws_panchayat_sarpanch_form myForm) {
		String query1 = "";
		Connection conn = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		try {
			conn = RwsOffices.getConn();

			query1 = "select  d.dcode,d.DNAME ,m.mcode,m.mname,a.NAME,a.MRO_MPDO_SECTION,a.MOBILE_no,a.Status,"
					+ "to_char(a.FRM_DATE,'dd/mm/yyyy') as frm_date ,to_char(a.TODATE,'dd/mm/yyyy') as todate,a.email from "
					+ "RWS_MRO_MPDO_TBL a,rws_district_tbl d,rws_mandal_tbl m where a.dcode=m.dcode and a.mcode=m.mcode "
					+ "and m.dcode=d.dcode and d.dcode=? and m.mcode=? and a.MRO_MPDO_SECTION =? and  FRM_DATE=to_date(?,'dd-mm-yyyy') ";
			stmt1 = conn.prepareStatement(query1);
			stmt1.setString(1, myForm.getDistrict());
			stmt1.setString(2, myForm.getMandal());
			stmt1.setString(3, myForm.getDesignation());
			stmt1.setString(4, myForm.getFrmDate());

			rs1 = stmt1.executeQuery();
			while (rs1.next()) {
				myForm.setDcode(rs1.getString("DCODE"));
				myForm.setDname(rs1.getString("DNAME"));
				myForm.setMcode(rs1.getString("MCODE"));
				myForm.setMname(rs1.getString("MNAME"));
				myForm.setDesignation(rs1.getString("MRO_MPDO_SECTION"));
				myForm.setMpdoName(rs1.getString("NAME"));
				myForm.setMpdoMobile(rs1.getString("MOBILE_NO"));
				myForm.setMpdoEmailId(rs1.getString("EMAIL"));
				myForm.setStatus(rs1.getString("STATUS"));
				myForm.setFrmDate(rs1.getString("FRM_DATE"));
				myForm.setToDate(rs1.getString("TODATE"));

			}
		} catch (Exception e) {
			System.out.println("exception in getmpdoDetails1--" + e);
		}
	}

	/* END OF MPDO ENTRY */
	/* Village Sec ENTRY */
	public int insertVillageSec(rws_panchayat_sarpanch_form myForm) throws Exception {
		String query = "";
		int rcount = 0;
		Connection conn = null;
		PreparedStatement preparedStatement = null;

		try {
			conn = RwsOffices.getConn();

			String dcode = myForm.getDistrict();
			String mcode = myForm.getMandal();
			String pcode = myForm.getPanchayat();
			String vcode = myForm.getVillage();
			String fromDate = myForm.getFrmDate();

			String status = myForm.getStatus();

			if (!isExists(dcode, mcode, pcode, vcode, fromDate, conn)
					&& !isExists1(dcode, mcode, pcode, vcode, fromDate, conn)) {

			

				query = "insert into rws_village_sec_tbl values(?,?,?,?,?,?,?,to_date(?,'dd/mm/yyyy'),to_date(?,'dd/mm/yyyy'),?)";
				preparedStatement = conn.prepareStatement(query);
				preparedStatement.setString(1, dcode);
				preparedStatement.setString(2, mcode);
				preparedStatement.setString(3, pcode);
				preparedStatement.setString(4, vcode);
				preparedStatement.setString(5, myForm.getVillageSecName());
				preparedStatement.setString(6, myForm.getVillageSecMobile());
				preparedStatement.setString(7, myForm.getStatus());
				preparedStatement.setString(8, myForm.getFrmDate());
				preparedStatement.setString(9, myForm.getToDate());
				preparedStatement.setString(10, myForm.getVillageSecEmailId());
				rcount = preparedStatement.executeUpdate();

			}

		

		} catch (Exception e) {
			System.out.println("The Exception  in insertVillageSec=" + e);
		} finally {
			if (conn != null) {

				conn.close();
			}
			if (preparedStatement != null) {
				preparedStatement.close();
			}
		}
		return rcount;
	}

	public int updateVillageSec(rws_panchayat_sarpanch_form myForm) throws Exception {
		String query = "";
		int rcount = 0;
		Connection conn = null;
		PreparedStatement preparedStatement = null;

		try {
			conn = RwsOffices.getConn();

			String dcode = myForm.getDistrict();
			String mcode = myForm.getMandal();
			String pcode = myForm.getPanchayat();
			String vcode = myForm.getVillage();
			String fromDate = myForm.getFrmDate();
			String toDate = myForm.getToDate();
			if (toDate == null) {
				myForm.setToDate("");
			}
			String status = myForm.getStatus();
			if (status.equals("R")) {
				query = "update rws_village_sec_tbl set VSEC_NAME =?,mobile_NO=?,status=?,FRM_DATE=to_date(?,'dd/mm/yyyy'),"
						+ "TODATE=to_date(?,'dd/mm/yyyy'),email=? where dcode=? and mcode=? and pcode=? and vcode=? and"
						+ " FRM_DATE=to_date(?,'dd/mm/yyyy')";
				preparedStatement = conn.prepareStatement(query);
				preparedStatement.setString(1, myForm.getVillageSecName());
				preparedStatement.setString(2, myForm.getVillageSecMobile());
				preparedStatement.setString(3, myForm.getStatus());
				preparedStatement.setString(4, myForm.getFrmDate());
				preparedStatement.setString(5, myForm.getToDate());
				preparedStatement.setString(6, myForm.getVillageSecEmailId());
				preparedStatement.setString(7, dcode);
				preparedStatement.setString(8, mcode);
				preparedStatement.setString(9, pcode);
				preparedStatement.setString(10, vcode);
				preparedStatement.setString(11, fromDate);
			} else {

				query = "update rws_village_sec_tbl set VSEC_NAME =?,mobile_NO=?,status=?,FRM_DATE=to_date(?,'dd/mm/yyyy'),"
						+ "TODATE=to_date(?,'dd/mm/yyyy'),email=? where dcode=? and mcode=? and pcode=? and vcode=? and "
						+ "FRM_DATE=to_date(?,'dd/mm/yyyy')";
				preparedStatement = conn.prepareStatement(query);
				preparedStatement.setString(1, myForm.getVillageSecName());
				preparedStatement.setString(2, myForm.getVillageSecMobile());
				preparedStatement.setString(3, myForm.getStatus());
				preparedStatement.setString(4, myForm.getFrmDate());
				preparedStatement.setString(5, myForm.getToDate());
				preparedStatement.setString(6, myForm.getVillageSecEmailId());
				preparedStatement.setString(7, dcode);
				preparedStatement.setString(8, mcode);
				preparedStatement.setString(9, pcode);
				preparedStatement.setString(10, vcode);
				preparedStatement.setString(11, fromDate);
			}

			rcount = preparedStatement.executeUpdate();
		} catch (Exception e) {
			System.out.println("exception in updateSarpanch=" + e);
		} finally {
			if (conn != null) {
				conn.close();
			}
			if (preparedStatement != null) {
				preparedStatement.close();
			}
		}
		return rcount;

	}

	private boolean isExists(String dcode, String mcode, String pcode, String vcode, String fromDate, Connection conn) {

		ResultSet rs = null;
		String query = "";
		PreparedStatement prepareStatement = null;

		try {

			query = "select * from rws_village_sec_tbl where dcode=? and mcode=? and pcode=? and vcode=? and FRM_DATE=?";
			prepareStatement = conn.prepareStatement(query);
			prepareStatement.setString(1, dcode);
			prepareStatement.setString(2, mcode);
			prepareStatement.setString(3, pcode);
			prepareStatement.setString(4, vcode);
			prepareStatement.setString(5, fromDate);
			rs = prepareStatement.executeQuery();
			if (rs.next()) {
				return true;

			} else {
				return false;
			}

		} catch (Exception e) {
			System.out.println("Exception in isExists -- "+e);
		} finally {
			try {
				if (prepareStatement != null) {
					prepareStatement.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in isExists -- "+e);
			}
		}

		return false;
	}

	private boolean isExists1(String dcode, String mcode, String pcode, String vcode, String fromDate,
			Connection conn) {

		ResultSet rs = null;
		String query = "";
		PreparedStatement prepareStatement = null;

		try {

			query = "select max(FRM_DATE),todate from rws_village_sec_tbl where dcode=? and mcode=? and pcode=? and vcode=? group by todate";
			prepareStatement = conn.prepareStatement(query);
			prepareStatement.setString(1, dcode);
			prepareStatement.setString(2, mcode);
			prepareStatement.setString(3, pcode);
			prepareStatement.setString(4, vcode);
			rs = prepareStatement.executeQuery();
			if (rs.next()) {
				String todate = rs.getString("todate");
				if (todate == null) {
					return true;

				} else {
					return false;
				}

			} else {
				return false;
			}

		} catch (Exception e) {
System.out.println("Exception in isExists1 -- "+e);
		} finally {
			try {
				if (prepareStatement != null) {
					prepareStatement.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in isExists1 -- "+e);
			}
		}

		return false;
	}

	public ArrayList getVillageSecDetails(String dcode, String mcode, String pcode, String vcode,
			DataSource dataSource) {
		String query1 = "";
		Connection conn = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		ArrayList villageSecDetails = new ArrayList();
		try {
			conn = RwsOffices.getConn();

			query1 = "select  d.dcode,d.DNAME ,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,a.VSEC_NAME,a.MOBILE_no,"
					+ "decode(a.Status,'W','Working','N','Not Working'),to_char(a.FRM_DATE,'dd/mm/yyyy'),to_char(a.TODATE,'dd/mm/yyyy'),"
					+ "a.email  from rws_village_sec_tbl a,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p, rws_village_tbl v where "
					+ "d.dcode=a.dcode and m.mcode =a.mcode and p.pcode=a.pcode and v.vcode=a.vcode and m.dcode=d.dcode and p.dcode=d.dcode "
					+ "and v.dcode=d.dcode and p.mcode=m.mcode and v.mcode=m.mcode and v.pcode=p.pcode and d.dcode=? and m.mcode=?"
					+ " and p.pcode=? and v.vcode=? ";

			stmt1 = conn.prepareStatement(query1);
			stmt1.setString(1, dcode);
			stmt1.setString(2, mcode);
			stmt1.setString(3, pcode);
			stmt1.setString(4, vcode);

			rs1 = stmt1.executeQuery();
			while (rs1.next()) {
				rws_panchayat_sarpanch_form frm = new rws_panchayat_sarpanch_form();

				frm.setDcode(rs1.getString("DCODE"));
				frm.setDname(rs1.getString("DNAME"));
				frm.setMcode(rs1.getString("MCODE"));
				frm.setMname(rs1.getString("MNAME"));
				frm.setPcode(rs1.getString("PCODE"));
				frm.setPname(rs1.getString("PNAME"));
				frm.setVcode(rs1.getString("VCODE"));
				frm.setVname(rs1.getString("VNAME"));
				frm.setVillageSecName(rs1.getString("VSEC_NAME"));
				frm.setVillageSecMobile(rs1.getString("MOBILE_no"));
				frm.setStatus(rs1.getString(11));
				frm.setFrmDate(rs1.getString(12));
				frm.setToDate(rs1.getString(13));
				frm.setVillageSecEmailId(rs1.getString(14));
				villageSecDetails.add(frm);

			}

		}

		catch (Exception e) {
			System.out.println("exception in getVillageSecDetails--" + e);
		}

		return villageSecDetails;

	}

	public ArrayList getVillageSecDetails(String dcode, String mcode, String pcode, DataSource dataSource) {
		String query1 = "";
		Connection conn = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		ArrayList villageSecDetails = new ArrayList();
		try {
			conn = RwsOffices.getConn();

			query1 = "select  d.dcode,d.DNAME ,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,a.VSEC_NAME,a.MOBILE_no,"
					+ "decode(a.Status,'W','Working','N','Not Working'),to_char(a.FRM_DATE,'dd/mm/yyyy'),to_char(a.TODATE,'dd/mm/yyyy'),"
					+ "a.email  from rws_village_sec_tbl a,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v where "
					+ "d.dcode=a.dcode and m.mcode =a.mcode and p.pcode=a.pcode and v.vcode=a.vcode and m.dcode=d.dcode and p.dcode=d.dcode"
					+ " and v.dcode=d.dcode and p.mcode=m.mcode and v.mcode=m.mcode and v.pcode=p.pcode and d.dcode=? and m.mcode=?"
					+ " and p.pcode=? ";

			stmt1 = conn.prepareStatement(query1);
			stmt1.setString(1, dcode);
			stmt1.setString(2, mcode);
			stmt1.setString(3, pcode);

			rs1 = stmt1.executeQuery();
			while (rs1.next()) {
				rws_panchayat_sarpanch_form frm = new rws_panchayat_sarpanch_form();

				frm.setDcode(rs1.getString("DCODE"));
				frm.setDname(rs1.getString("DNAME"));
				frm.setMcode(rs1.getString("MCODE"));
				frm.setMname(rs1.getString("MNAME"));
				frm.setPcode(rs1.getString("PCODE"));
				frm.setPname(rs1.getString("PNAME"));
				frm.setVcode(rs1.getString("VCODE"));
				frm.setVname(rs1.getString("VNAME"));
				frm.setVillageSecName(rs1.getString("VSEC_NAME"));
				frm.setVillageSecMobile(rs1.getString("MOBILE_no"));
				frm.setStatus(rs1.getString(11));
				frm.setFrmDate(rs1.getString(12));
				frm.setToDate(rs1.getString(13));
				frm.setVillageSecEmailId(rs1.getString(14));
				villageSecDetails.add(frm);

			}

		}

		catch (SQLException e) {
			System.out.println("SQLexception in getVillageSecDetails--" + e);
		}

		return villageSecDetails;

	}

	public ArrayList getVillageSecDetails(String dcode) {
		String query1 = "";
		Connection conn = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		ArrayList villageSecDetails = new ArrayList();
		try {
			conn = RwsOffices.getConn();

			query1 = "select  d.dcode,d.DNAME ,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,a.VSEC_NAME,a.MOBILE_no,"
					+ "decode(a.Status,'W','Working','N','Not Working'),to_char(a.FRM_DATE,'dd/mm/yyyy'),to_char(a.TODATE,'dd/mm/yyyy'),a.email  from"
					+ " rws_village_sec_tbl a,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v where d.dcode=a.dcode and "
					+ "m.mcode =a.mcode and p.pcode=a.pcode and v.vcode=a.vcode and m.dcode=d.dcode and p.dcode=d.dcode and v.dcode=d.dcode "
					+ "and p.mcode=m.mcode and v.mcode=m.mcode and v.pcode=p.pcode and d.dcode=?";

			stmt1 = conn.prepareStatement(query1);
			stmt1.setString(1, dcode);

			rs1 = stmt1.executeQuery();
			while (rs1.next()) {
				rws_panchayat_sarpanch_form frm = new rws_panchayat_sarpanch_form();

				frm.setDcode(rs1.getString("DCODE"));
				frm.setDname(rs1.getString("DNAME"));
				frm.setMcode(rs1.getString("MCODE"));
				frm.setMname(rs1.getString("MNAME"));
				frm.setPcode(rs1.getString("PCODE"));
				frm.setPname(rs1.getString("PNAME"));
				frm.setVcode(rs1.getString("VCODE"));
				frm.setVname(rs1.getString("VNAME"));
				frm.setVillageSecName(rs1.getString("VSEC_NAME"));
				frm.setVillageSecMobile(rs1.getString("MOBILE_no"));
				frm.setStatus(rs1.getString(11));
				frm.setFrmDate(rs1.getString(12));
				frm.setToDate(rs1.getString(13));
				frm.setVillageSecEmailId(rs1.getString(14));
				villageSecDetails.add(frm);

			}

		}

		catch (SQLException e) {
			System.out.println("exception in getVillageSecDetails dcode only----" + e);
		}

		return villageSecDetails;

	}

	public ArrayList getVillageSecDetails(String dcode, String mcode) {
		String query1 = "";
		Connection conn = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		ArrayList villageSecDetails = new ArrayList();
		try {
			conn = RwsOffices.getConn();

			query1 = "select  d.dcode,d.DNAME ,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,a.VSEC_NAME,a.MOBILE_no,"
					+ "decode(a.Status,'W','Working','N','Not Working'),to_char(a.FRM_DATE,'dd/mm/yyyy'),to_char(a.TODATE,'dd/mm/yyyy'),a.email  "
					+ "from rws_village_sec_tbl a,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v where d.dcode=a.dcode and "
					+ "m.mcode =a.mcode and p.pcode=a.pcode and v.vcode=a.vcode and m.dcode=d.dcode and p.dcode=d.dcode and v.dcode=d.dcode "
					+ "and p.mcode=m.mcode and v.mcode=m.mcode and v.pcode=p.pcode and d.dcode=? and m.mcode=? ";

			stmt1 = conn.prepareStatement(query1);
			stmt1.setString(1, dcode);
			stmt1.setString(2, mcode);

			rs1 = stmt1.executeQuery();
			while (rs1.next()) {
				rws_panchayat_sarpanch_form frm = new rws_panchayat_sarpanch_form();

				frm.setDcode(rs1.getString("DCODE"));
				frm.setDname(rs1.getString("DNAME"));
				frm.setMcode(rs1.getString("MCODE"));
				frm.setMname(rs1.getString("MNAME"));
				frm.setPcode(rs1.getString("PCODE"));
				frm.setPname(rs1.getString("PNAME"));
				frm.setVcode(rs1.getString("VCODE"));
				frm.setVname(rs1.getString("VNAME"));
				frm.setVillageSecName(rs1.getString("VSEC_NAME"));
				frm.setVillageSecMobile(rs1.getString("MOBILE_no"));
				frm.setStatus(rs1.getString(11));
				frm.setFrmDate(rs1.getString(12));
				frm.setToDate(rs1.getString(13));
				frm.setVillageSecEmailId(rs1.getString(14));
				villageSecDetails.add(frm);

			}

		}

		catch (SQLException e) {
			System.out.println("exception in getVillageSecDetails dcode mcode----" + e);
		}

		return villageSecDetails;

	}

	public void getVillageSecDetails(rws_panchayat_sarpanch_form myForm) {
		String query1 = "";
		Connection conn = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		try {
			conn = RwsOffices.getConn();

			query1 = "select  d.dcode,d.DNAME ,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,a.VSEC_NAME,a.MOBILE_no,"
					+ "decode(a.Status,'W','Working','N','Not Working'),to_char(a.FRM_DATE,'dd/mm/yyyy'),to_char(a.TODATE,'dd/mm/yyyy'),a.email "
					+ " from rws_village_sec_tbl a,rws_district_tbl d,rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v where d.dcode=a.dcode and "
					+ "m.mcode =a.mcode and p.pcode=a.pcode and v.vcode=a.vcode and m.dcode=d.dcode and p.dcode=d.dcode and v.dcode=d.dcode "
					+ "and p.mcode=m.mcode and v.mcode=m.mcode and v.pcode=p.pcode and d.dcode=? and m.mcode=? and p.pcode=?"
					+ " and v.vcode=? ";

			stmt1 = conn.prepareStatement(query1);
			stmt1.setString(1, myForm.getDistrict());
			stmt1.setString(2, myForm.getMandal());
			stmt1.setString(3, myForm.getPanchayat());
			stmt1.setString(4, myForm.getVillage());


			rs1 = stmt1.executeQuery();
			while (rs1.next()) {
				myForm.setVillageSecName(rs1.getString("VSEC_NAME"));
				myForm.setVillageSecMobile(rs1.getString("MOBILE_no"));
				myForm.setStatus(rs1.getString(11));
				myForm.setFrmDate(rs1.getString(12));
				myForm.setToDate(rs1.getString(13));
				myForm.setVillageSecEmailId(rs1.getString(14));

			}
		} catch (SQLException e) {
			System.out.println("exception in getVillageSecDetails form--" + e);
		}
	}

	public void getVillageSecDetails1(rws_panchayat_sarpanch_form myForm) {
		String query1 = "";
		Connection conn = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		try {
			conn = RwsOffices.getConn();

			query1 = "select  d.dcode,d.DNAME ,m.mcode,m.mname,p.pcode,p.pname,v.vcode,v.vname,a.VSEC_NAME,a.MOBILE_no,a.Status,"
					+ "to_char(a.FRM_DATE,'dd/mm/yyyy'),to_char(a.TODATE,'dd/mm/yyyy'),a.email  from rws_village_sec_tbl a,rws_district_tbl d,"
					+ "rws_mandal_tbl m,rws_panchayat_tbl p,rws_village_tbl v where d.dcode=a.dcode and m.mcode =a.mcode and p.pcode=a.pcode and "
					+ "v.vcode=a.vcode and m.dcode=d.dcode and p.dcode=d.dcode and v.dcode=d.dcode and p.mcode=m.mcode and v.mcode=m.mcode"
					+ " and v.pcode=p.pcode and d.dcode=? and m.mcode=? and p.pcode=? and v.vcode=? and FRM_DATE=to_date(?,'dd/mm/yyyy')";

			stmt1 = conn.prepareStatement(query1);
			stmt1.setString(1, myForm.getDistrict());
			stmt1.setString(2, myForm.getMandal());
			stmt1.setString(3, myForm.getPanchayat());
			stmt1.setString(4, myForm.getVillage());
			stmt1.setString(5, myForm.getFrmDate());


			rs1 = stmt1.executeQuery();
			while (rs1.next()) {
				myForm.setDcode(rs1.getString(1));
				myForm.setDname(rs1.getString(2));
				// myForm.setDistrict(rs1.getString(2));
				myForm.setMcode(rs1.getString(3));
				myForm.setMname(rs1.getString(4));
				// myForm.setMandal(rs1.getString(4));
				myForm.setPcode(rs1.getString(5));
				myForm.setPname(rs1.getString(6));
				// myForm.setPanchayat(rs1.getString(6));
				myForm.setVcode(rs1.getString(7));
				myForm.setVname(rs1.getString(8));
				// myForm.setVillage(rs1.getString(8));
				myForm.setVillageSecName(rs1.getString(9));
				myForm.setVillageSecMobile(rs1.getString(10));

				myForm.setStatus(rs1.getString(11));
				myForm.setFrmDate(rs1.getString(12));
				myForm.setToDate(rs1.getString(13));
				myForm.setVillageSecEmailId(rs1.getString(14));

			}

		} catch (SQLException e) {
			System.out.println("exception in getVillageSecDetails1 form--" + e);
		}
	}

	public rws_panchayat_sarpanch_form getSectionOfficer(String district, String mandal) {
		String query1 = "";
		Connection conn = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		rws_panchayat_sarpanch_form form = null;
		try {
			conn = RwsOffices.getConn();

			form = new rws_panchayat_sarpanch_form();
			query1 = "select NAME,MOBILE_NO,EMAIL,STATUS from RWS_MRO_MPDO_TBL where dcode=? and mcode=? and MRO_MPDO_SECTION=? ";
			stmt1 = conn.prepareStatement(query1);
			stmt1.setString(1, district);
			stmt1.setString(2, mandal);
			stmt1.setString(3, "MRO");
			rs1 = stmt1.executeQuery();
			if (rs1.next()) {
				form.setMroName(rs1.getString(1));
				form.setMroMobile(rs1.getString(2));
				form.setMroEmailId(rs1.getString(3));
				form.setStatus(rs1.getString(4));
			}

			query1 = "select NAME,MOBILE_NO,EMAIL from RWS_MRO_MPDO_TBL where dcode=? and mcode=? and MRO_MPDO_SECTION=?";
			stmt1 = conn.prepareStatement(query1);
			stmt1.setString(1, district);
			stmt1.setString(2, mandal);
			stmt1.setString(3, "MPDO");
			rs1 = stmt1.executeQuery();
			if (rs1.next()) {
				form.setMpdoName(rs1.getString(1));
				form.setMpdoMobile(rs1.getString(2));
				form.setMpdoEmailId(rs1.getString(3));
			}

			query1 = "select NAME,MOBILE_NO,EMAIL from RWS_MRO_MPDO_TBL where dcode=? and mcode=? and MRO_MPDO_SECTION=?";
			stmt1 = conn.prepareStatement(query1);
			stmt1.setString(1, district);
			stmt1.setString(2, mandal);
			stmt1.setString(3, "Section Officer");
			rs1 = stmt1.executeQuery();
			if (rs1.next()) {
				form.setSfName(rs1.getString(1));
				form.setSfMobile(rs1.getString(2));
				form.setSfEmailId(rs1.getString(3));
			}
			query1 = "select NAME,MOBILE_NO,EMAIL from RWS_MRO_MPDO_TBL where dcode=? and mcode=? and MRO_MPDO_SECTION=?";
			stmt1 = conn.prepareStatement(query1);
			stmt1.setString(1, district);
			stmt1.setString(2, mandal);
			stmt1.setString(3, "EORD");
			rs1 = stmt1.executeQuery();
			if (rs1.next()) {
				form.setEordName(rs1.getString(1));
				form.setEordMobile(rs1.getString(2));
				form.setEordEmailId(rs1.getString(3));
			} else {

				query1 = "select nvl(EMPLOYEE_NAME,' '),nvl(MOBILE,' ') from rws_employee_tbl a,rws_mandal_subdivision_tbl b where "
						+ "DESIGNATION_CODE in('8') and substr(office_code,2,2)=CIRCLE_OFFICE_CODE and "
						+ "substr(office_code,4,1)=DIVISION_OFFICE_CODE and substr(office_code,5,2)=SUBDIVISION_OFFICE_CODE and "
						+ "dcode=? and mcode=? ";
				stmt1 = conn.prepareStatement(query1);
				stmt1.setString(1, district);
				stmt1.setString(2, mandal);
				rs1 = stmt1.executeQuery();

				if (rs1.next()) {

					form.setSfName(rs1.getString(1));
					form.setSfMobile(rs1.getString(2));

				}
			}
			stmt1.close();
			rs1.close();
		} catch (Exception e) {
			System.out.println("exception in rws_panchayat_sarpanch_form getSectionOfficer" + e);
		}
		return form;

	}

	/* END OF Village Sec ENTRY */

}
