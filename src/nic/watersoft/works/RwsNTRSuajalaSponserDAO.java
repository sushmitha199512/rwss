package nic.watersoft.works;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;

import nic.watersoft.commons.RwsOffices;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsNTRSuajalaSponserDAO {

	public void saveRecord(RwsNTRSuajalaSponserForm rwsNTRSuajalaSponserForm,
			HttpServletRequest request) {

		System.out.println("rwsNTRSuajalaSponserForm"
				+ rwsNTRSuajalaSponserForm.getSponserName());

		Connection conn = null;
		PreparedStatement pstmt = null, pstmt1 = null;

		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			String insertQuery = "insert into rws_sujala_sponser_tbl values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
			String insertPlaceQuery = "insert into rws_sujala_sp_level_tbl values(?,?)";

			pstmt = conn.prepareStatement(insertQuery);
			pstmt1 = conn.prepareStatement(insertPlaceQuery);
			String sponsorId = getSponsorId(conn);
			pstmt.setString(1, sponsorId);
			pstmt.setString(2, rwsNTRSuajalaSponserForm.getSponserName());
			pstmt.setString(3, rwsNTRSuajalaSponserForm.getCategory());
			pstmt.setString(4, rwsNTRSuajalaSponserForm.getAddress());
			pstmt.setString(5, rwsNTRSuajalaSponserForm.getCity());
			pstmt.setString(6, rwsNTRSuajalaSponserForm.getState());
			pstmt.setString(7, rwsNTRSuajalaSponserForm.getCountry());
			pstmt.setString(8, rwsNTRSuajalaSponserForm.getMobileNo());
			pstmt.setString(9, rwsNTRSuajalaSponserForm.getEmailId());
			pstmt.setString(10, rwsNTRSuajalaSponserForm.getAmount());
			if (rwsNTRSuajalaSponserForm.getVillageSelection() != null
					&& rwsNTRSuajalaSponserForm.getVillageSelection().equals(
							"SelectedBySponser")) {
				pstmt.setString(11, "Y");

				pstmt.setString(12, "N");
			} else if (rwsNTRSuajalaSponserForm.getVillageSelection() != null
					&& rwsNTRSuajalaSponserForm.getVillageSelection().equals(
							"SelectedByGovt")) {
				pstmt.setString(11, "N");

				pstmt.setString(12, "Y");
			}

			pstmt.setString(13,
					getPlace(rwsNTRSuajalaSponserForm.getSelection()));

			if (rwsNTRSuajalaSponserForm.getVillageSelection() != null
					&& rwsNTRSuajalaSponserForm.getVillageSelection().equals(
							"SelectedBySponser")) {

				if (getPlace(rwsNTRSuajalaSponserForm.getSelection()).equals(
						"D")) {

					for (int i = 0; i < rwsNTRSuajalaSponserForm
							.getCircleCode().length; i++) {
						pstmt1.setString(1, sponsorId);
						pstmt1.setString(2,
								rwsNTRSuajalaSponserForm.getCircleCode()[i]);
						pstmt1.addBatch();
					}
				}
				/**
				 * Mandals
				 */
				if (getPlace(rwsNTRSuajalaSponserForm.getSelection()).equals(
						"M")) {

					for (int i = 0; i < rwsNTRSuajalaSponserForm
							.getMandalCode().length; i++) {
						pstmt1.setString(1, sponsorId);
						pstmt1.setString(
								2,
								getValues(rwsNTRSuajalaSponserForm
										.getCircleCode())
										+ rwsNTRSuajalaSponserForm
												.getMandalCode()[i]);
						pstmt1.addBatch();
					}
				}

				if (getPlace(rwsNTRSuajalaSponserForm.getSelection()).equals(
						"P")) {

					for (int i = 0; i < rwsNTRSuajalaSponserForm
							.getPanchayathCode().length; i++) {
						pstmt1.setString(1, sponsorId);
						pstmt1.setString(
								2,
								getValues(rwsNTRSuajalaSponserForm
										.getCircleCode())
										+ getValues(rwsNTRSuajalaSponserForm
												.getMandalCode())
										+ rwsNTRSuajalaSponserForm
												.getPanchayathCode()[i]);
						pstmt1.addBatch();
					}
				}

				if (getPlace(rwsNTRSuajalaSponserForm.getSelection()).equals(
						"V")) {

					for (int i = 0; i < rwsNTRSuajalaSponserForm
							.getVillageCode().length; i++) {
						pstmt1.setString(1, sponsorId);
						pstmt1.setString(
								2,
								getValues(rwsNTRSuajalaSponserForm
										.getCircleCode())
										+ getValues(rwsNTRSuajalaSponserForm
												.getMandalCode())
										+ getValues(rwsNTRSuajalaSponserForm
												.getPanchayathCode())
										+ rwsNTRSuajalaSponserForm
												.getVillageCode()[i]);
						pstmt1.addBatch();
					}
				}

				if (getPlace(rwsNTRSuajalaSponserForm.getSelection()).equals(
						"H")) {

					for (int i = 0; i < rwsNTRSuajalaSponserForm.getHabCode().length; i++) {
						pstmt1.setString(1, sponsorId);
						pstmt1.setString(2,
								rwsNTRSuajalaSponserForm.getHabCode()[i]);
						pstmt1.addBatch();
					}
				}

			}
			pstmt.executeUpdate();
			pstmt1.executeBatch();

			conn.commit();
			conn.setAutoCommit(true);
			request.setAttribute("message", "Saved Successfully");

			// rws_sujala_sponser_tbl
			// rws_sujala_sp_level_tbl

		} catch (Exception e) {
			request.setAttribute("message", "Updation Failed.");
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			if (conn != null) {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}

	}

	private String getValues(String[] circleCode) {

		String code = "";
		if (circleCode != null) {
			for (int j = 0; j < circleCode.length; j++) {

				code += circleCode[j];
				code += ",";
			}
			return code.substring(0, code.length() - 1);
		} else {
			return code;
		}
	}

	private String getPlace(String selection) {

		String place = "";
		int mode = Integer.parseInt(selection);
		switch (mode) {
		case 0: {
			place = "D";

		}
			break;
		case 1: {
			place = "M";

		}
			break;
		case 2: {
			place = "P";

		}
			break;
		case 3: {
			place = "V";

		}
			break;
		case 4: {
			place = "H";

		}
			break;
		}

		return place;
	}

	private String getSponsorId(Connection conn) {

		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			String getMaxIdQuery = "select max(nvl(SP_ID,0))+1 from rws_sujala_sponser_tbl";
			rs = stmt.executeQuery(getMaxIdQuery);
			if (rs.next()) {
				if (rs.getString(1) != null && !rs.getString(1).equals("null")) {
					return rs.getString(1);
				} else {
					return "1";
				}
			} else {
				return "1";
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
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
		return "1";
	}

}
