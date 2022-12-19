package nic.watersoft.masters;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import nic.watersoft.commons.RwsOffices;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsPaymentConfirmationDAO {

	public ArrayList getFilesToBeSentList() {

		Statement stmt = null;
		ResultSet rs = null;
		Connection conn = null;
		ArrayList filesTobeSentList = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String query = "select TXID ,TXT_FILE_PATH,to_char(TDATE,'dd/MM/yyyy')   from rws_bill_sett_send_file_tbl where sent_status='N'";
			System.out.println("querysssss" + query);
			rs = stmt.executeQuery(query);

			while (rs.next()) {
				RwsFileStatusRecord rFileStatusRecord = new RwsFileStatusRecord();
				rFileStatusRecord.setFileNumber(Integer.parseInt(rs
						.getString(1)));
				rFileStatusRecord.setFileName(rs.getString(2));
				rFileStatusRecord.setFileDate(rs.getString(3));
				filesTobeSentList.add(rFileStatusRecord);

			}

		} catch (Exception e) {
			e.printStackTrace();
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
				e.printStackTrace();
			}
		}

		return filesTobeSentList;
	}

	public void updateDB(String fileName) {
		Statement stmt = null;
		Connection conn = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String query = "update rws_bill_sett_send_file_tbl set sent_status='Y' where TXT_FILE_PATH=?";
			PreparedStatement ps = conn.prepareStatement(query);
			ps.setString(1,fileName);
			ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (stmt != null) {
					stmt.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}
}
