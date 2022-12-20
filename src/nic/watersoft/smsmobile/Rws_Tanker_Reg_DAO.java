package nic.watersoft.smsmobile;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.sql.DataSource;

import nic.watersoft.commons.RwsLocationBean;
import nic.watersoft.commons.RwsOffices;

public class Rws_Tanker_Reg_DAO {

	public ArrayList getHabitations(String dcode, String mcode, String pcode) throws Exception {

		ArrayList habs = new ArrayList();
		String query = "";
		RwsLocationBean rwsLocation = null;
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();

			query = "SELECT HAB_CODE,PANCH_CODE,PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL "
					+ "WHERE SUBSTR(HAB_CODE,1,2)=? AND SUBSTR(HAB_CODE,6,2)=? AND " + "SUBSTR(HAB_CODE,13,2)=?";
			stmt = conn.prepareStatement(query);
			stmt.setString(1, dcode);
			stmt.setString(2, mcode);
			stmt.setString(3, pcode);

			rs = stmt.executeQuery();

			while (rs.next()) {
				rwsLocation = new RwsLocationBean();
				rwsLocation.setHabitationCode(rs.getString(1));
				rwsLocation.setHabCode(rs.getString(2));
				rwsLocation.setHabName(rs.getString(3) + " - " + rs.getString(2));
				habs.add(rwsLocation);

			}
			rs.close();
			stmt.close();
		} catch (Exception e) {
			System.out.println("Exception in getHabitations of Rws_Tanker_Reg_DAO-- "+e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				
			} catch (Exception e) {
				System.out.println("Exception in getHabitations of Rws_Tanker_Reg_DAO-- "+e);
			}
		}
		return habs;
	}

	public String insertTankerDetails(RwsTankerRegistrationForm frm) {
		String mes = "";
		Connection connection = null;
		PreparedStatement pstmt = null;
		String query = "";
		try {
			connection = RwsOffices.getConn();
			if (!isTankerRegisteredInLoc(frm, connection)) {
				query = "insert into RWS_TANKER_REG_TBL values(?,?,?,?,?,?,?,?,?,?)";
				pstmt = connection.prepareStatement(query);
				pstmt.setString(1, frm.getTankerRegNo());
				pstmt.setString(2, frm.getTankerCapacity());
				pstmt.setString(3, frm.getTankerOwnerName());
				pstmt.setString(4, frm.getTankerOwnerAadhar());
				pstmt.setString(5, frm.getTankerOwnerMobileNumber());
				pstmt.setString(6, frm.getHabCode());
				pstmt.setString(7, frm.getRemarks());
				pstmt.setString(8, frm.getTankerRCNo());
				pstmt.setString(9, frm.getTankerRCName());
				pstmt.setString(10, frm.getTankerOwnerIMEINumber());
			} else {

				mes = "Tanker already Registered in this Panchayat";
				return mes;
			}
			int n = pstmt.executeUpdate();
			if (n > 0) {
				mes = "Tanker Details Saved Sucessfully";
			} else {
				mes = "Failed to Save Tanker Details";
			}
		} catch (Exception e) {
			System.out.println("Exception in insertTankerDetails of Rws_Tanker_Reg_DAO-- "+e);
		} finally {
			try {
				if (connection != null) {
					connection.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in insertTankerDetails of Rws_Tanker_Reg_DAO-- "+e);
			}
		}
		return mes;
	}

	public String upadteTankerDetails(RwsTankerRegistrationForm frm) {
		String mes = "";
		Connection connection = null;
		PreparedStatement pstmt = null;
		String query = "";
		try {
			connection = RwsOffices.getConn();
			
			query = "update RWS_TANKER_REG_TBL set TANKER_REG_NO=?,TANKER_OWNER_NAME=?,TANKER_OWNER_AADHAAR=?,TANKER_OWNER_MOBILE =?,REMARKS=?,TANKER_CAPACITY_IN_KLTS=?,TANKER_RC_NO=?,TANKER_RC_NAME =?,IMEI_NO=? where HABITATION_CODE=? and TANKER_REG_NO=?";
			pstmt = connection.prepareStatement(query);
			pstmt.setString(1, frm.getTankerRegNo());
			pstmt.setString(2, frm.getTankerOwnerName());
			pstmt.setString(3, frm.getTankerOwnerAadhar());
			pstmt.setString(4, frm.getTankerOwnerMobileNumber());
			pstmt.setString(5, frm.getRemarks());
			pstmt.setString(6, frm.getTankerCapacity());
			pstmt.setString(7, frm.getTankerRCNo());
			pstmt.setString(8, frm.getTankerRCName());
			pstmt.setString(9, frm.getTankerOwnerIMEINumber());
			pstmt.setString(10, frm.getHabCode());
			pstmt.setString(11, frm.getTankerRegNo());
			int n = pstmt.executeUpdate();
			if (n > 0) {
				mes = "Tanker Details Updated Sucessfully";
			} else {
				mes = "Failed to update Tanker Details";
			}
		} catch (Exception e) {
			System.out.println("Exception in upadteTankerDetails of Rws_Tanker_Reg_DAO-- "+e);
		} finally {
			try {
				if (connection != null) {
					connection.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in upadteTankerDetails of Rws_Tanker_Reg_DAO-- "+e);
			}
		}
		return mes;
	}

	private boolean isExists(RwsTankerRegistrationForm frm, Connection connection) {
		ResultSet rs = null;
		String query = "";
		PreparedStatement stmt1 = null;

		try {

			query = "select * from RWS_TANKER_REG_TBL where TANKER_REG_NO=?";
			stmt1 = connection.prepareStatement(query);
			stmt1.setString(1, frm.getTankerRegNo());
			rs = stmt1.executeQuery();
			if (rs.next()) {
				return true;

			} else {
				return false;
			}

		} catch (Exception e) {
			System.out.println("Exception in isExists of Rws_Tanker_Reg_DAO-- "+e);
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in isExists of Rws_Tanker_Reg_DAO-- "+e);
			}
		}

		return false;
	}

	public RwsTankerRegistrationForm getTankerDetails(String habcode, String tankerRegNo) {
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet resultSet = null;
		RwsTankerRegistrationForm frm = null;
		try {
			connection = RwsOffices.getConn();
			String query = "select TANKER_REG_NO,TANKER_OWNER_NAME,TANKER_OWNER_AADHAAR,TANKER_OWNER_MOBILE,REMARKS,dname,dcode,mname,mcode,pname,pcode,panch_name,panch_code,TANKER_CAPACITY_IN_KLTS,TANKER_RC_NO,TANKER_RC_NAME,a.IMEI_NO from RWS_TANKER_REG_TBL a,rws_complete_hab_view b where b.panch_code=a.HABITATION_CODE and a.HABITATION_CODE=? and TANKER_REG_NO=?";
			pstmt = connection.prepareStatement(query);
			pstmt.setString(1, habcode);
			pstmt.setString(2, tankerRegNo);
			resultSet = pstmt.executeQuery();
			if (resultSet.next()) {
				frm = new RwsTankerRegistrationForm();

				frm.setTankerRegNo(resultSet.getString(1));
				frm.setTankerOwnerName(resultSet.getString(2));
				frm.setTankerOwnerAadhar(resultSet.getString(3));
				frm.setTankerOwnerMobileNumber(resultSet.getString(4));
				frm.setRemarks(resultSet.getString(5));
				frm.setDistrictName(resultSet.getString(6));
				frm.setMandal(resultSet.getString(8));
				frm.setPanchayat(resultSet.getString(10));
				frm.setHabName(resultSet.getString(12));
				frm.setHabCode(resultSet.getString(13));
				frm.setTankerCapacity(resultSet.getString(14));
				frm.setTankerRCNo(resultSet.getString(15));
				frm.setTankerRCName(resultSet.getString(16));
				frm.setTankerOwnerIMEINumber(resultSet.getString(17));

			}
			resultSet.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println("Exception in getTankerDetails of Rws_Tanker_Reg_DAO-- "+e);
		} finally {
			try {
				if (connection != null) {
					connection.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in getTankerDetails of Rws_Tanker_Reg_DAO-- "+e);
			}
		}
		return frm;
	}

	public ArrayList getTankerDetailsAll(RwsTankerRegistrationForm frm) {
		ArrayList tankerDetails = new ArrayList();
		Connection connection = null;
		PreparedStatement pstmt = null;
		ResultSet resultSet = null;
		String query = "";
		try {
			connection = RwsOffices.getConn();

			if (!frm.getCircleOfficeCode().equals("") && !frm.getCircleOfficeCode().equals(null)
					&& frm.getMandal().equals("") && frm.getPanchayat().equals("") && frm.getHabCode().equals("")) {
				query = "select TANKER_REG_NO,TANKER_OWNER_NAME,TANKER_OWNER_AADHAAR,TANKER_OWNER_MOBILE,REMARKS,dname,mname,pname,panch_name,panch_code,TANKER_CAPACITY_IN_KLTS,TANKER_RC_NO,TANKER_RC_NAME from RWS_TANKER_REG_TBL a,rws_complete_hab_view b where b.panch_code=a.HABITATION_CODE and dcode=?";
				pstmt = connection.prepareStatement(query);
				pstmt.setString(1, frm.getCircleOfficeCode());
			} else if (!frm.getCircleOfficeCode().equals("") && !frm.getCircleOfficeCode().equals(null)
					&& !frm.getMandal().equals("") && !frm.getMandal().equals(null) && frm.getPanchayat().equals("")
					&& frm.getHabCode().equals("")) {
				query = "select TANKER_REG_NO,TANKER_OWNER_NAME,TANKER_OWNER_AADHAAR,TANKER_OWNER_MOBILE,REMARKS,dname,mname,pname,panch_name,panch_code,TANKER_CAPACITY_IN_KLTS,TANKER_RC_NO,TANKER_RC_NAME from RWS_TANKER_REG_TBL a,rws_complete_hab_view b where b.panch_code=a.HABITATION_CODE and dcode=? and mcode=?";
				pstmt = connection.prepareStatement(query);
				pstmt.setString(1, frm.getCircleOfficeCode());
				pstmt.setString(2, frm.getMandal());
			} else if (!frm.getCircleOfficeCode().equals("") && !frm.getCircleOfficeCode().equals(null)
					&& !frm.getMandal().equals("") && !frm.getMandal().equals(null) && !frm.getPanchayat().equals("")
					&& !frm.getPanchayat().equals(null) && frm.getHabCode().equals("")) {
				query = "select TANKER_REG_NO,TANKER_OWNER_NAME,TANKER_OWNER_AADHAAR,TANKER_OWNER_MOBILE,REMARKS,dname,mname,pname,panch_name,panch_code,TANKER_CAPACITY_IN_KLTS,TANKER_RC_NO,TANKER_RC_NAME from RWS_TANKER_REG_TBL a,rws_complete_hab_view b where b.panch_code=a.HABITATION_CODE and dcode=? and mcode=? and pcode=?";
				pstmt = connection.prepareStatement(query);
				pstmt.setString(1, frm.getCircleOfficeCode());
				pstmt.setString(2, frm.getMandal());
				pstmt.setString(3, frm.getPanchayat());
			} else if (!frm.getCircleOfficeCode().equals("") && !frm.getCircleOfficeCode().equals(null)
					&& !frm.getMandal().equals("") && !frm.getMandal().equals(null) && !frm.getPanchayat().equals("")
					&& !frm.getPanchayat().equals(null) && !frm.getHabCode().equals("")
					&& !frm.getHabCode().equals(null)) {
				query = "select TANKER_REG_NO,TANKER_OWNER_NAME,TANKER_OWNER_AADHAAR,TANKER_OWNER_MOBILE,REMARKS,dname,mname,pname,panch_name,panch_code,TANKER_CAPACITY_IN_KLTS,TANKER_RC_NO,TANKER_RC_NAME from RWS_TANKER_REG_TBL a,rws_complete_hab_view b where b.panch_code=a.HABITATION_CODE and a.HABITATION_CODE=?";
				pstmt = connection.prepareStatement(query);
				pstmt.setString(1, frm.getHabCode());
			}

			resultSet = pstmt.executeQuery();
			while (resultSet.next()) {
				RwsTankerRegistrationForm form = new RwsTankerRegistrationForm();
				form.setTankerRegNo(resultSet.getString(1));
				form.setTankerOwnerName(resultSet.getString(2));
				form.setTankerOwnerAadhar(resultSet.getString(3));
				form.setTankerOwnerMobileNumber(resultSet.getString(4));
				form.setRemarks(resultSet.getString(5));
				form.setDistrictName(resultSet.getString(6));
				form.setMandal(resultSet.getString(7));
				form.setPanchayat(resultSet.getString(8));
				form.setHabName(resultSet.getString(9));
				form.setHabCode(resultSet.getString(10));
				form.setTankerCapacity(resultSet.getString(11));
				form.setTankerRCNo(resultSet.getString(12));
				form.setTankerRCName(resultSet.getString(13));
				tankerDetails.add(form);
			}
			resultSet.close();
			pstmt.close();
		} catch (Exception e) {
			System.out.println("Exception in getTankerDetailsAll of Rws_Tanker_Reg_DAO-- "+e);
		} finally {
			try {
				if (connection != null) {
					connection.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in getTankerDetailsAll of Rws_Tanker_Reg_DAO-- "+e);
			}
		}
		return tankerDetails;
	}

	public String deleteTankerDetails(String habCode, String tankerRegNo) {
		String mes = "";
		Connection connection = null;
		PreparedStatement pstmt = null, pstmt1 = null;
		ResultSet rs = null;
		String query = "";
		try {
			connection = RwsOffices.getConn();

			query = "select TANKER_REG_NO from rws_tanker_movement_tbl where TANKER_REG_NO=?";
			pstmt1 = connection.prepareStatement(query);
			pstmt1.setString(1, tankerRegNo);
			rs = pstmt1.executeQuery();
			if (rs.next()) {
				mes = "Tanker Details Can't be Deleted ";
			} else {
				query = "delete from RWS_TANKER_REG_TBL where HABITATION_CODE=? and TANKER_REG_NO=?";
				pstmt = connection.prepareStatement(query);
				pstmt.setString(1, habCode);
				pstmt.setString(2, tankerRegNo);
				int n = pstmt.executeUpdate();
				if (n > 0) {
					mes = "Tanker Details are Deleted Sucessfully";
				} else {
					mes = "Tanker Details Can't be Deleted ";
				}
			}
		} catch (Exception e) {
			System.out.println("Exception in deleteTankerDetails of Rws_Tanker_Reg_DAO-- "+e);
		} finally {
			try {
				if (connection != null) {
					connection.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in deleteTankerDetails of Rws_Tanker_Reg_DAO-- "+e);
			}
		}
		return mes;
	}
	private boolean isTankerRegisteredInLoc(RwsTankerRegistrationForm frm, Connection connection) {
		ResultSet rs = null;
		String query = "";
		PreparedStatement stmt1 = null;

		try {

			String dcode = frm.getHabCode().substring(0, 2);
			String mcode = frm.getHabCode().substring(5, 7);
			String pcode = frm.getHabCode().substring(12, 14);
			query = "select * from RWS_TANKER_REG_TBL where TANKER_REG_NO=? and TANKER_OWNER_MOBILE=? and "
					+"substr(HABITATION_CODE,1,2)=? and  substr(HABITATION_CODE,6,2) =? and  substr(HABITATION_CODE,13,2)=?";
					//+ "HABITATION_CODE=?";
			stmt1 = connection.prepareStatement(query);
			stmt1.setString(1, frm.getTankerRegNo());
			stmt1.setString(2, frm.getTankerOwnerMobileNumber());
			stmt1.setString(3, dcode);
			stmt1.setString(4, mcode);
			stmt1.setString(5, pcode);
			rs = stmt1.executeQuery();
			if (rs.next()) {
				return true;

			} else {
				return false;
			}

		} catch (Exception e) {
			System.out.println("Exception in isExists of Rws_Tanker_Reg_DAO-- "+e);
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in isExists of Rws_Tanker_Reg_DAO-- "+e);
			}
		}

		return false;
	}
}
