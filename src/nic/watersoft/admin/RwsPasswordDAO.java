package nic.watersoft.admin;

import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.EmailSender;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.MakeHashUtils;
import nic.watersoft.commons.Md5Impl;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsProperties;
import nic.watersoft.commons.RwsUtils;

public class RwsPasswordDAO {

	public ArrayList getUSers() {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList usersList = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			String q = "select USER_ID  from rws_password_tbl";
			stmt = conn.prepareStatement(q);
			rs = stmt.executeQuery();
			while (rs.next()) {
				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs.getString(1));
				labelValueBean.setLabel(rs.getString(1));
				usersList.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsPasswordDAO getUSers : "+e.getMessage());
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in RwsPasswordDAO getUSers : "+e.getMessage());
			}
		}
		return usersList;
	}

	public void getUserInfo(RwsPasswordBean resetPaswordFrm) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		resetPaswordFrm.setCircleOfficeName("");
		resetPaswordFrm.setDivOfficeName("");
		try {
			conn = RwsOffices.getConn();
			String q = "select CIRCLE_OFFICE_NAME,DIVISION_OFFICE_NAME from rws_circle_office_tbl a,rws_division_office_tbl b where a.CIRCLE_OFFICE_CODE =b.CIRCLE_OFFICE_CODE  and a.CIRCLE_OFFICE_CODE= ? and b.DIVISION_OFFICE_CODE= ? ";			
			stmt = conn.prepareStatement(q);
			stmt.setString(1, resetPaswordFrm.getUserId().substring(1, 3));
			stmt.setString(2, resetPaswordFrm.getUserId().substring(3, 4));
			rs = stmt.executeQuery();
			if (rs.next()) {
				resetPaswordFrm.setCircleOfficeName(rs.getString(1));
				resetPaswordFrm.setDivOfficeName(rs.getString(2));
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsPasswordDAO getUserInfo : "+e.getMessage());
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in RwsPasswordDAO getUserInfo Finally : "+e.getMessage());
			}
		}

	}

	public void getUserEmail(RwsPasswordBean resetPaswordFrm) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		resetPaswordFrm.setRegisteredMailId("Not Registered");
		resetPaswordFrm.setRegisteredMobileNo("Not Registered");
		try {
			conn = RwsOffices.getConn();
			String userQuery = "select email_id,mobile_no from rws_password_tbl where user_id= ? ";
			stmt = conn.prepareStatement(userQuery);
			stmt.setString(1, resetPaswordFrm.getUserId());
			rs = stmt.executeQuery();
			if (rs.next()) {
				resetPaswordFrm.setRegisteredMailId(rs.getString(1));
				resetPaswordFrm.setRegisteredMobileNo(rs.getString(2));
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsPasswordDAO getUserEmail :  "+e.getMessage());			
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in RwsPasswordDAO getUserEmail Finally :  "+e.getMessage());				
			}
		}

	}

	public void resetPassword(RwsPasswordBean rwsPasswordBean, HttpServletRequest request, String defaultPassword) throws NoSuchAlgorithmException {
		RwsProperties rwsProperties = new RwsProperties();
		Connection conn = null;
		PreparedStatement stmt = null;
		String passWord = MakeHashUtils.sha256(defaultPassword);
		rwsPasswordBean.setRandomPassword(defaultPassword);
		try {
			conn = RwsOffices.getConn();
			String q = "update rws_password_tbl set PASSWORD= ? , status='R' where user_id= ? ";
			stmt = conn.prepareStatement(q);
			stmt.setString(1, passWord);
			stmt.setString(2, rwsPasswordBean.getUserId());
			int updatedCount = stmt.executeUpdate();
			if (updatedCount > 0) {
					if (rwsProperties.isEmailEnabled()) {
						boolean status = new EmailSender().sendMail(rwsPasswordBean, rwsProperties);
						if (status) {
							request.setAttribute("message",	"Password sent to Email:"+ rwsPasswordBean.getRegisteredMailId()+ "  Successfully");
						} else {
							request.setAttribute("message","Password reset failed, please try again");
						}
					}
				/*} else if (rwsPasswordBean.getSelectOption().equals("mobile")) {
					if (rwsProperties.isSMSEnabled()) {
						
					request.setAttribute("message",
								"Password sent to Mobile:" + rwsPasswordBean.getRegisteredMobileNo() + "  Successfully");
						// s.send(rwsPasswordBean.getRegisteredMobileNo(),
						// rwsPasswordBean.getRandomPassword());
					}else {
						request.setAttribute("message","SMS Not yet Activate");
					}

				}*/
			} else {
				request.setAttribute("message", "Password Reset Failed. Please try again");				
			}

		} catch (Exception e) {
			System.out.println("The Exception is in RwsPasswordDAO resetPassword :  "+e.getMessage());
			request.setAttribute("message", "Password Reset Failed. Please try again");
			
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (stmt != null) {
					stmt.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in RwsPasswordDAO resetPassword Finally : "+e.getMessage());
			}
		}
	}
}
