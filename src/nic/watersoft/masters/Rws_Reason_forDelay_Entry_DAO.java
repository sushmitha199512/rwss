package nic.watersoft.masters;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;

public class Rws_Reason_forDelay_Entry_DAO {

	public static String getReasonCode() {
		Connection conn = null;
		conn = RwsOffices.getConn();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement("SELECT nvl(max(DELAY_REASON_CODE),0)+1 FROM RWS_WORK_DELAY_REASONS");
			rs = stmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			System.out.println("The Exception in Rws_Reason_forDelay_Entry_DAO in getReasonCode is  = "+e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception in Rws_Reason_forDelay_Entry_DAO in getReasonCode is  = "+e.getMessage());
			}
		}
		return "";
	}
	
	public int saveReason(String reasonCode, String reasonName) {
		Connection conn = null;
		conn = RwsOffices.getConn();
		PreparedStatement stmt = null;
		int count = 0;
		try {
			String q = "insert into  RWS_WORK_DELAY_REASONS values( ? , ?)";
			stmt = conn.prepareStatement(q);
			stmt.setString(1, reasonCode);
			stmt.setString(2, reasonName);
			count = stmt.executeUpdate();
			return count;
		} catch (Exception e) {
			System.out.println("The Exception in Rws_Reason_forDelay_Entry_DAO in saveReason is  = "+e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception in Rws_Reason_forDelay_Entry_DAO in saveReason is  = "+e.getMessage());
			}
		}
		return 0;
	}

	
	public int editReason(String reasonCode, String reasonName) {
		Connection conn = null;
		conn = RwsOffices.getConn();
		PreparedStatement stmt = null;
		int count = 0;
		try {
			String q = "update  RWS_WORK_DELAY_REASONS set DELAY_REASON_NAME= ? where DELAY_REASON_CODE= ? ";			
			stmt = conn.prepareStatement(q);
			stmt.setString(1, reasonName);
			stmt.setString(2, reasonCode);
			count = stmt.executeUpdate();
			return count;
		} catch (Exception e) {
			System.out.println("The Exception in Rws_Reason_forDelay_Entry_DAO in editReason is  = "+e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception in Rws_Reason_forDelay_Entry_DAO in editReason is  = "+e.getMessage());
			}
		}
		return 0;
	}
	
	public ArrayList getReasons() {
		ArrayList reasons = new ArrayList();
		Connection conn = null;
		conn = RwsOffices.getConn();
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.prepareStatement("SELECT DELAY_REASON_CODE,DELAY_REASON_NAME FROM RWS_WORK_DELAY_REASONS order by DELAY_REASON_CODE");
			rs = stmt.executeQuery();
			while (rs.next()) {
				Rws_Reason_forDelay_Entry_Form delay_Entry_Form = new Rws_Reason_forDelay_Entry_Form();
				delay_Entry_Form.setReasonCode(rs.getString("DELAY_REASON_CODE"));
				delay_Entry_Form.setReasonName(rs.getString("DELAY_REASON_NAME"));
				reasons.add(delay_Entry_Form);
			}
			return reasons;
		} catch (Exception e) {
			System.out.println("The Exception in Rws_Reason_forDelay_Entry_DAO in getReasons is  = "+e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception in Rws_Reason_forDelay_Entry_DAO in getReasons is  = "+e.getMessage());
			}
		}
		return null;
	}




}