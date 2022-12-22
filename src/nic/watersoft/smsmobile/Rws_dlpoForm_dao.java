package nic.watersoft.smsmobile;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.sql.DataSource;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.masters.rws_panchayat_sarpanch_form;

public class Rws_dlpoForm_dao {
	private LabelValueBean labelValueBean = null;

	public ArrayList getDLPOMandalDetails(Rws_dlpoForm myForm, String districtName) {
		String query1 = "";
		Connection conn = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		@SuppressWarnings("rawtypes")
		ArrayList dlpoMandalDetails = new ArrayList();
		try {
			conn = RwsOffices.getConn();
		
		
			query1 = "select DIVISION_OFFICE_NAME,MNAME,DIVISION_OFFICE_CODE,MCODE  from rws_dlpo_division_TBL where "
					+ "CIRCLE_OFFICE_CODE=? ";
			stmt1 = conn.prepareStatement(query1);
			stmt1.setString(1,  myForm.getDistrict() );
		
			rs1 = stmt1.executeQuery();
			while (rs1.next()) {
				Rws_dlpoForm frm = new Rws_dlpoForm();

				frm.setDistrictName(districtName);
				frm.setDivisionName(rs1.getString(1));
				frm.setMandal(rs1.getString(2));
				frm.setDistrict(myForm.getDistrict());
				frm.setDivision(rs1.getString(3));
				frm.setDivmandals(rs1.getString(4));
				dlpoMandalDetails.add(frm);

			}
			stmt1.close();
			rs1.close();

		}

		catch (SQLException e) {
			System.out.println("exception in getDLPOMandalDetails-- "+e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("exception in getDLPOMandalDetails-- "+e);
			}
		}

		return dlpoMandalDetails;

	}

	public String insertDlpoMandal(Rws_dlpoForm myForm, DataSource dataSource) throws Exception {
		String query = "";
		int rcount = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		String message = "";
		try {
			conn = RwsOffices.getConn();
		
			RwsOffices rwsOffices = new RwsOffices();
			String dist = myForm.getDistrict();
			String division = myForm.getDivision();
			String[] mandalsar = myForm.getDivmandals1();
			for (int i = 0; i < mandalsar.length; i++) {

				if (!isExistsDlpoMandal(dist, mandalsar[i], conn)) {
					String mName = rwsOffices.getMandalName(dist, mandalsar[i]);
					query = "insert into rws_dlpo_division_TBL(CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE,DIVISION_OFFICE_NAME,MCODE,MNAME) "
							+ "values(?,?,?,?,?)";
					stmt = conn.prepareStatement(query);
					stmt.setString(1, dist);
					stmt.setString(2, division);
					stmt.setString(3,  myForm.getDivisionName());
					stmt.setString(4,  mandalsar[i]);
					stmt.setString(5, mName);
					
				} else {
					return "DLPO Mandal Already Mapped";
				}

				rcount = stmt.executeUpdate();
			}
			if (rcount > 0) {
				message = "Inserted Succesfully";
			} else {
				message = "Failed to Insert";
			}
		} catch (Exception e) {
			System.out.println("exception in insertDlpoMandal-- "+e);
		} finally {
			if (conn != null) {

				conn.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return message;
	}

	public String updateDlpoMandal(Rws_dlpoForm myForm, DataSource dataSource) throws Exception {
		String query = "";
		int rcount = 0;
		Connection conn = null;
		PreparedStatement stmt = null;
		String message = "";
		try {
			conn = RwsOffices.getConn();
		
			RwsOffices rwsOffices = new RwsOffices();
			String dist = myForm.getDistrict();
			String division = myForm.getDivision();
			String mandal = myForm.getDivmandals();

			if (!isExistsDlpoMandal(dist, mandal, conn)) {
				String mName = rwsOffices.getMandalName(dist, mandal);
				query = "update rws_dlpo_division_TBL set MCODE=?,MNAME=? where CIRCLE_OFFICE_CODE=? and "
						+ "DIVISION_OFFICE_CODE=?  and MCODE=? ";
				stmt = conn.prepareStatement(query);
				stmt.setString(1, mandal);
				stmt.setString(2, mName);
				stmt.setString(3,  myForm.getOldCircle() );
				stmt.setString(4, myForm.getOldDivision() );
				stmt.setString(5, myForm.getOldMandal());
				
			} else {
				return "DLPO Mandal Already Mapped";
			}

			rcount = stmt.executeUpdate();
			if (rcount > 0) {
				message = "Inserted Succesfully";
			} else {
				message = "Failed to Insert";
			}
		} catch (Exception e) {
			System.out.println("exception in updateDlpoMandal-- "+e);
		} finally {
			if (conn != null) {

				conn.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return message;
	}

	public String deleteDlpoMandal(String dcode, String mcode, String divcode) {
		String message = "";
		Connection conn = null;
		PreparedStatement stmt = null;
		String query = "";
		try {
			conn = RwsOffices.getConn();
			
			query = "delete from rws_dlpo_division_TBL where CIRCLE_OFFICE_CODE=? and DIVISION_OFFICE_CODE=?"
					+ " and MCODE=? ";
			stmt = conn.prepareStatement(query);
			stmt.setString(1, dcode);
			stmt.setString(2, divcode);
			stmt.setString(3, mcode);
			
			int rcount = stmt.executeUpdate();
			if (rcount > 0) {
				message = "Deleted Succesfully";
			} else {
				message = "Failed to Delete";
			}

		} catch (Exception e) {
			System.out.println("exception in deleteDlpoMandal-- "+e);
		}
		return message;
	}

	private boolean isExistsDlpoMandal(String dcode, String division, String mandal, Connection conn) {

		ResultSet rs = null;
		String query = "";
		Statement stmt1 = null;

		try {
			stmt1 = conn.createStatement();
			query = "select * from rws_dlpo_division_TBL where CIRCLE_OFFICE_CODE='" + dcode
					+ "' and DIVISION_OFFICE_CODE='" + division + "' and mcode='" + mandal + "' ";
			rs = stmt1.executeQuery(query);
			if (rs.next()) {
				return true;

			} else {
				return false;
			}

		} catch (Exception e) {
			System.out.println("exception in isExistsDlpoMandal (String dcode, String division, String mandal, Connection conn-- "+e);
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
			} catch (Exception e) {
				System.out.println("exception in isExistsDlpoMandal(String dcode, String division, String mandal, Connection conn-- "+e);
			}
		}

		return false;
	}

	private boolean isExistsDlpoMandal(String dcode, String mandal, Connection conn) {

		ResultSet rs = null;
		String query = "";
		PreparedStatement stmt1 = null;

		try {
			
			query = "select * from rws_dlpo_division_TBL where CIRCLE_OFFICE_CODE=? and mcode=? ";
			
			stmt1 = conn.prepareStatement(query);
			stmt1.setString(1, dcode);
			stmt1.setString(2, mandal);
			rs = stmt1.executeQuery();
			
			if (rs.next()) {
				return true;

			} else {
				return false;
			}

		} catch (Exception e) {
			System.err.println("exception in isExistsDlpoMandal-- "+e);
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
			} catch (Exception e) {
			System.err.println("exception in isExistsDlpoMandal-- "+e);
			}
		}

		return false;
	}

	public int insertmpdo(Rws_dlpoForm myForm) throws Exception {
		String query = "";
		int rcount = 0;
		Connection conn = null;
		PreparedStatement stmt = null;

		try {
			conn = RwsOffices.getConn();
			

			String dist = myForm.getDistrict();
			String division = myForm.getMandal();
			String mandal = myForm.getDivmandals();

			if (!isExistsmpdo(dist, division, conn)) {

				query = "insert into rws_dlpo_tbl(CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE,DLPO_CODE,DLPO_NAME,DLPO_MOBILE) "
						+ "values(?,?,?,?,?)";
				stmt = conn.prepareStatement(query);
				stmt.setString(1, dist);
				stmt.setString(2, division);
				stmt.setString(3, myForm.getDlpoNo());
				stmt.setString(4, myForm.getSarpanchName() );
				stmt.setString(5,  myForm.getSarpanchMobile());
				
			} else {

				query = "update rws_dlpo_tbl set DLPO_NAME=?, DLPO_MOBILE=? ,DLPO_CODE=? where CIRCLE_OFFICE_CODE=?"
						+ " and DIVISION_OFFICE_CODE =? ";
				stmt = conn.prepareStatement(query);
			
				stmt.setString(1, myForm.getSarpanchName() );
				stmt.setString(2,  myForm.getSarpanchMobile());
				stmt.setString(3, myForm.getDlpoNo());
				stmt.setString(4, dist);
				stmt.setString(5, division);
			}

			rcount = stmt.executeUpdate();

		} catch (Exception e) {
		System.out.println("exception in insertmpdo-- "+e);
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


	private boolean isExistsmpdo(String dcode, String division, Connection conn) {

		ResultSet rs = null;
		String query = "";
		PreparedStatement stmt1 = null;

		try {
		
			query = "select * from rws_DLPO_tbl where CIRCLE_OFFICE_CODE=? and DIVISION_OFFICE_CODE=?";
			
			stmt1 = conn.prepareStatement(query);
			stmt1.setString(1, dcode);
			stmt1.setString(2, division);
			
			
			rs = stmt1.executeQuery();
			if (rs.next()) {
				return true;

			} else {
				return false;
			}

		} catch (Exception e) {
			System.out.println("execption in isExistsmpdo-- "+e);
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
			} catch (Exception e) {
				System.out.println("execption in isExistsmpdo-- "+e);
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
		
		

			query1 = "select C.CIRCLE_OFFICE_CODE,C.CIRCLE_OFFICE_NAME,D.DIVISION_OFFICE_CODE,D.DIVISION_OFFICE_NAME,"
					+ "a.DLPO_CODE,a.DLPO_NAME ,a.DLPO_MOBILE,mname  FROM RWS_DLPO_TBL a,rws_circle_office_tbl c,"
					+ "rws_dlpo_division_TBL d where a.circle_office_code=c.circle_office_code and a.circle_office_code=d.circle_office_code and"
					+ " a.division_office_code=d.division_office_code and a.mcode=d.mcode and a.circle_office_code=? and a.division_office_code=? ";
			stmt1 = conn.prepareStatement(query1);
			stmt1.setString(1, dist);
			stmt1.setString(2, mand);
			
			rs1 = stmt1.executeQuery();

			while (rs1.next()) {
				Rws_dlpoForm frm = new Rws_dlpoForm();

				frm.setDcode(rs1.getString(1));
				frm.setDname(rs1.getString(2));
				frm.setMcode(rs1.getString(3));
				frm.setMname(rs1.getString(4));
				frm.setDlpoNo(rs1.getString(5));
				frm.setSarpanchName(rs1.getString(6));
				frm.setSarpanchMobile(rs1.getString(7));
				frm.setDivmandals(rs1.getString(8));
				sarpanchDetails.add(frm);

			}

		}

		catch (SQLException e) {
			System.out.println("execption in getmpdoDetails-- "+e);
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
		
	
			
			query1 = " select distinct  C.CIRCLE_OFFICE_CODE,C.CIRCLE_OFFICE_NAME,D.DIVISION_OFFICE_CODE,"
					+ "D.DIVISION_OFFICE_NAME,a.DLPO_CODE,a.DLPO_NAME,a.DLPO_MOBILE  FROM RWS_DLPO_TBL a,"
					+ "rws_circle_office_tbl c,rws_dlpo_division_TBL d where a.circle_office_code=c.circle_office_code and "
					+ "a.circle_office_code=d.circle_office_code and a.division_office_code=d.division_office_code and  a.circle_office_code=?  ";
			stmt1 = conn.prepareStatement(query1);
			stmt1.setString(1, dist);
			
			rs1 = stmt1.executeQuery();
			while (rs1.next()) {
				Rws_dlpoForm frm = new Rws_dlpoForm();

				frm.setDcode(rs1.getString(1));
				frm.setDname(rs1.getString(2));
				frm.setMcode(rs1.getString(3));
				frm.setMname(rs1.getString(4));
				frm.setDlpoNo(rs1.getString(5));
				frm.setSarpanchName(rs1.getString(6));
				frm.setSarpanchMobile(rs1.getString(7));
				sarpanchDetails.add(frm);

			}

		}

		catch (SQLException e) {
			System.out.println("exception in getmpdoDetails--"+e);
		}

		return sarpanchDetails;

	}

	public Rws_dlpoForm getdlpoDetails(String dist, String divcode, String mandal) {
		String query1 = "";
		Connection conn = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		ArrayList sarpanchDetails = new ArrayList();
		Rws_dlpoForm frm = new Rws_dlpoForm();
		try {

			conn = RwsOffices.getConn();

		
			query1 = " select distinct  C.CIRCLE_OFFICE_CODE,C.CIRCLE_OFFICE_NAME,D.DIVISION_OFFICE_CODE,"
					+ "D.DIVISION_OFFICE_NAME,a.DLPO_CODE,a.DLPO_NAME,a.DLPO_MOBILE  FROM RWS_DLPO_TBL a,"
					+ "rws_circle_office_tbl c,rws_dlpo_division_TBL d where a.circle_office_code=c.circle_office_code and "
					+ "a.circle_office_code=d.circle_office_code and a.division_office_code=d.division_office_code and  a.circle_office_code=? and "
					+ " a.division_office_code=? ";
			stmt1 = conn.prepareStatement(query1);

			stmt1.setString(1, dist);
			stmt1.setString(2, divcode);
			rs1 = stmt1.executeQuery();

			while (rs1.next()) {

				frm.setDlpoNo(rs1.getString(5));
				frm.setSarpanchName(rs1.getString(6));
				frm.setSarpanchMobile(rs1.getString(7));

			}

		}

		catch (SQLException e) {
			System.out.println("exception in getdlpoDetails-- " + e);
		}

		return frm;

	}

	public void getmpdoDetails(Rws_dlpoForm myForm) {
		String query1 = "";
		Connection conn = null;
		Statement stmt1 = null;
		ResultSet rs1 = null;
		try {
			conn = RwsOffices.getConn();
			stmt1 = conn.createStatement();

			query1 = "select C.CIRCLE_OFFICE_CODE,C.CIRCLE_OFFICE_NAME,D.DIVISION_OFFICE_CODE,D.DIVISION_OFFICE_NAME,a.DLPO_CODE,a.DLPO_NAME ,a.DLPO_MOBILE  FROM RWS_DLPO_TBL a,rws_circle_office_tbl c,rws_division_office_tbl d where a.circle_office_code=c.circle_office_code and a.circle_office_code=d.circle_office_code and a.division_office_code=d.division_office_code and a.circle_office_code='"
					+ myForm.getDistrict() + "' and a.division_office_code='" + myForm.getMandal() + "'  ";

			rs1 = stmt1.executeQuery(query1);
			while (rs1.next()) {
				myForm.setDcode(rs1.getString("CIRCLE_OFFICE_CODE"));
				myForm.setDname(rs1.getString("CIRCLE_OFFICE_NAME"));
				myForm.setMcode(rs1.getString("DIVISION_OFFICE_CODE"));
				myForm.setMname(rs1.getString("DIVISION_OFFICE_NAME"));
				myForm.setDlpoNo(rs1.getString("DLPO_CODE"));
				myForm.setSarpanchName(rs1.getString("DLPO_NAME"));
				myForm.setSarpanchMobile(rs1.getString("DLPO_MOBILE"));

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public ArrayList getDivisions(String circleOfficeCode) throws Exception {
		ArrayList divisions = new ArrayList();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();
			String query = " SELECT DISTINCT division_office_code, division_office_name "
					+ " FROM rws_dlpo_division_TBL " + " WHERE  circle_office_code = ? ORDER BY division_office_name ";


			ps = conn.prepareStatement(query);
			ps.setString(1, circleOfficeCode);
			rset = ps.executeQuery();

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - " + rset.getString(1));
				divisions.add(labelValueBean);
			}
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("exception in getDivisions method of Rws_dlpoForm_dao" + e);
			}
		}
		return divisions;
	}

	public ArrayList getDivmandals(String circode, String divcode) throws Exception {
		ArrayList mandals = new ArrayList();
		String query = null;
		Connection conn = null;
		PreparedStatement stat = null;
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();


			if (circode != null && !circode.equals("")) {

				query = "SELECT MNAME,MCODE FROM rws_dlpo_division_TBL WHERE  CIRCLE_OFFICE_CODE=? ORDER BY MNAME";
				stat = conn.prepareStatement(query);
				stat.setString(1, circode);
			} else if (divcode != null && !divcode.equals("")) {

				query = "SELECT MNAME,MCODE FROM rws_dlpo_division_TBL WHERE  AND DIVISION_OFFICE_CODE=? "
						+ "ORDER BY MNAME";
				stat = conn.prepareStatement(query);
				stat.setString(1, divcode);
			}


			rset = stat.executeQuery();
			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(2));
				labelValueBean.setLabel(rset.getString(1));
				labelValueBean.setLabelValue(rset.getString(1) + " - " + rset.getString(2));
				mandals.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("exception in getDivmandals method of Rws_dlpoForm_dao" + e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("exception in getDivmandals method of Rws_dlpoForm_dao" + e);
			}
		}
		return mandals;
	}

	public Integer getMaxValue(String district) {

		String query = null;
		Connection conn = null;
		Statement stat = null;
		ResultSet rset = null;
		int maxValue = 0;
		try {
			conn = RwsOffices.getConn();


			query = "SELECT max(DIVISION_OFFICE_CODE) FROM rws_dlpo_division_TBL WHERE  CIRCLE_OFFICE_CODE ='"
					+ district + "'";

			stat = conn.createStatement();
			rset = stat.executeQuery(query);
			if (rset.next()) {
				maxValue = rset.getInt(1) + 1;
			}
		} catch (Exception e) {

			System.out.println("exception in getMaxValue method of Rws_dlpoForm_dao" + e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("exception in getMaxValue method of Rws_dlpoForm_dao" + e);
			}
		}
		return maxValue;
	}

}
