package nic.watersoft.smsmobile;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import java.util.Date;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;

public class AuthorisedMobileUserDetailsDAO {

	private String query = null;
	private PreparedStatement ps;
	private PreparedStatement ps1;
	private PreparedStatement ps2;
	private Connection conn;
	private Statement stmt;
	private LabelValueBean labelValueBean = null;
	public static String errorMessage;
	private ResultSet rset = null;

	public ArrayList getuserDetails(AuthorisedMobileUserDetailsForm form) {
		ArrayList habs = new ArrayList();
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null, rs = null;
		PreparedStatement preparedStatement = null;
		try {
			conn = RwsOffices.getConn();

			query = "select dcode,mcode from rws_mandal_subdivision_tbl where CIRCLE_OFFICE_CODE=?"
					+ " and DIVISION_OFFICE_CODE =? and SUBDIVISION_OFFICE_CODE=? order by mcode";


			ps = conn.prepareStatement(query);
			ps.setString(1, form.getCircleOfficeCode());
			ps.setString(2, form.getDivisionOfficeCode());
			ps.setString(3, form.getSubDivisionOfficeCode());

			rset = ps.executeQuery();

			while (rset.next()) {
				String userDeatailsQuery = "select IMEI_NO,USER_ID,DATA_COLLECTOR_NAME,MOBILE,DESIGNATION,"
						+ "decode(GENDER,'M','Male','F','FeMale'),EMAILID,ADDRESS,to_char(DATE_OF_REQUEST,'dd/mm/yyyy'),"
						+ "decode(SERVICE_REQUEST,'M','Mobile','S','SMS','B','BOTH'),HABITATION_CODE,nvl(AUTH_USER_REGISTRATION,' ') "
						+ "from rws_mobile_sms_register_tbl where substr(HABITATION_CODE,1,2)=? and substr(HABITATION_CODE,6,2)=? ";

				preparedStatement = conn.prepareStatement(userDeatailsQuery);
				preparedStatement.setString(1, rset.getString(1));
				preparedStatement.setString(2, rset.getString(2));

				rs = preparedStatement.executeQuery();

				while (rs.next()) {
					AuthorisedMobileUserBean habMandal = new AuthorisedMobileUserBean();
					habMandal.setIMEINo(rs.getString(1));
					habMandal.setUserName(rs.getString(2));
					habMandal.setDataCollectorName(rs.getString(3));
					habMandal.setMobileNumber(rs.getString(4));
					habMandal.setDesignation(rs.getString(5));
					habMandal.setGender(rs.getString(6));
					habMandal.setEmailId(rs.getString(7));
					habMandal.setAddress(rs.getString(8));
					habMandal.setDateofRequest(rs.getString(9));
					habMandal.setServiceRequest(rs.getString(10));
					habMandal.setHabCode(rs.getString(11));
					habMandal.setStatus(rs.getString(12));
					if (rs.getString(12).equals("Y")) {

						habMandal.setChecks("on");
					}

					habs.add(habMandal);
				}
				preparedStatement.close();
				rs.close();
			}
			ps.close();
			rset.close();
		} catch (Exception e) {
			System.out.println("exception in getuserDetails=- " + e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {

					System.out.println("exception in getuserDetails=- " + e);
			
				}
			}
		}
		return habs;
	}

	public ArrayList getuserDetailsAll(AuthorisedMobileUserDetailsForm form) {
		ArrayList habs = new ArrayList();
		String query = "";
		Connection conn = null;
		Statement stmt = null;
		ResultSet rset = null, rs = null;
		PreparedStatement preparedStatement = null;
		try {
			conn = RwsOffices.getConn();

			query = "select dcode,mcode from rws_mandal_subdivision_tbl where CIRCLE_OFFICE_CODE=?"
					+ " and DIVISION_OFFICE_CODE =? and SUBDIVISION_OFFICE_CODE=? order by mcode";


			ps = conn.prepareStatement(query);
			ps.setString(1, form.getCircleOfficeCode());
			ps.setString(2, form.getDivisionOfficeCode());
			ps.setString(3, form.getSubDivisionOfficeCode());
			
			rset = ps.executeQuery();

			while (rset.next()) {
				
				String userDeatailsQuery = "select IMEI_NO,USER_ID,DATA_COLLECTOR_NAME,MOBILE,DESIGNATION,"
						+ "decode(GENDER,'M','Male','F','FeMale'),EMAILID,ADDRESS,to_char(DATE_OF_REQUEST,'dd/mm/yyyy'),"
						+ "decode(SERVICE_REQUEST,'M','Mobile','S','SMS','B','BOTH'),HABITATION_CODE,"
						+ "decode(AUTH_USER_REGISTRATION,'Y','Yes','N','No'),AUTHORIZED_BY,"
						+ "to_char(DATE_OF_AUTHORISATION,'dd/mm/yyyy') from rws_mobile_sms_register_tbl where "
						+ "substr(HABITATION_CODE,1,2)=? and substr(HABITATION_CODE,6,2)=? ";
				
				preparedStatement = conn.prepareStatement(userDeatailsQuery);
				preparedStatement.setString(1, rset.getString(1));
				preparedStatement.setString(2, rset.getString(2));
				rs = preparedStatement.executeQuery();

				while (rs.next()) {
					AuthorisedMobileUserBean habMandal = new AuthorisedMobileUserBean();
					habMandal.setIMEINo(rs.getString(1));
					habMandal.setUserName(rs.getString(2));
					habMandal.setDataCollectorName(rs.getString(3));
					habMandal.setMobileNumber(rs.getString(4));
					habMandal.setDesignation(rs.getString(5));
					habMandal.setGender(rs.getString(6));
					habMandal.setEmailId(rs.getString(7));
					habMandal.setAddress(rs.getString(8));
					habMandal.setDateofRequest(rs.getString(9));
					habMandal.setServiceRequest(rs.getString(10));
					habMandal.setHabCode(rs.getString(11));
					habMandal.setStatus(rs.getString(12));
					habMandal.setAuthorisedBy(rs.getString(13));
					habMandal.setDateOfAuthorization(rs.getString(14));

					habs.add(habMandal);
				}
				preparedStatement.close();
				rs.close();
			}
			ps.close();
			rset.close();
		} catch (Exception e) {
			System.out.println("exception in getuserDetailsAll=- " + e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println("exception in getuserDetailsAll=- " + e);
				}
			}
		}
		return habs;
	}

	public String updateUserDetails(AuthorisedMobileUserDetailsForm form, String loggedUser, String habcode[],
			String imeiNo[]) throws Exception {

		int recCount = 0;

		String message = "";
		Connection conn = null;
		PreparedStatement stmt = null;

		try {

			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);

			DateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			Date date = new Date();
			String cDate = dateFormat.format(date);
			String habCodes[] = habcode;
			String imeiNos[] = imeiNo;

			String query = "update rws_mobile_sms_register_tbl set AUTH_USER_REGISTRATION=?,AUTHORIZED_BY =?,"
					+ "DATE_OF_AUTHORISATION=to_date(?,'dd/MM/yyyy') where  MOBILE=?  and HABITATION_CODE=?";
			stmt = conn.prepareStatement(query);

			for (int i = 0; i < form.getUsers().size(); i++) {

				AuthorisedMobileUserBean frm = form.getUsers().get(i);
				for (int h = 0; h < habCodes.length; h++) {
					if (frm.getHabCode().equals(habCodes[h])) {
						for (int m = 0; m < imeiNos.length; m++) {
							if (frm.getIMEINo().equals(imeiNos[m])) {
								frm.setChecks("");
							}
						}
					}
				}

				if (frm.getChecks() != null && frm.getChecks().equals("on")) {

					stmt.setString(1, "Y");
					stmt.setString(2, loggedUser);
					stmt.setString(3, cDate);

					stmt.setString(4, frm.getMobileNumber());
					stmt.setString(5, frm.getHabCode());

					stmt.addBatch();
					recCount++;


				} else {
					if (frm.getStatus().equals("Y")) {
						stmt.setString(1, "N");
						stmt.setString(2, loggedUser);
						stmt.setString(3, cDate);

						stmt.setString(4, frm.getMobileNumber());
						stmt.setString(5, frm.getHabCode());

						stmt.addBatch();
						recCount++;
					}
				}
			}
			int res[] = stmt.executeBatch();
			if (res.length == recCount) {
				message = "Records Updated Successfully";
				conn.commit();
				conn.setAutoCommit(true);
			} else {
				conn.rollback();
				message = "Updation Failed";
			}
		}

		catch (Exception e) {
			Debug.println("The error in updateUserDetails " + e);
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					System.out.println("exception in updateUserDetails=- " + e);
				}
			}
		}
		return message;
	}

}
