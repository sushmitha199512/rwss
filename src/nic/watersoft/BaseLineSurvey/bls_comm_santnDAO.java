package nic.watersoft.BaseLineSurvey;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


import javax.sql.DataSource;

import nic.watersoft.commons.RwsOffices;
public class bls_comm_santnDAO {
	Connection conn = null;
	ResultSet rst = null;
	PreparedStatement pstmt = null;
	Statement stmt = null, stmt1 = null, stmt2 = null;
	DataSource datasource = null;

	bls_comm_santnDAO() {
	}

	bls_comm_santnDAO(DataSource datasource) {
		this.datasource = datasource;
	}

	private void closeAll() {
		if (rst != null) {
			try {
				rst.close();
			} catch (SQLException sqle) {
			}
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (SQLException sqle) {
			}
		}
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException sqle) {
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException sqle) {
			}
		}
	}

	/**
	 * Retrieving columns in rws_bls_comm_sani_comp_tbl using habcode
	 * @param dataSource
	 * @param habcode
	 * @param frm
	 * @throws Exception
	 */
	public void getHabdet(DataSource dataSource, String habcode,
			bls_comm_santnForm frm) {

		Connection conn;
		String qry = "select TOTAL_CSC_CONSTRUCTED,TOTAL_FUNCTIONAL_CSC,TOTAL_DEFUNCT_CSC,NO_OFF_ADDL_CSC_REQ,to_char(SURVEY_DATE,'dd/mm/yy') from rws_bls_comm_sani_comp_tbl where HABITATION_CODE="
				+ habcode + "";
		try {
			System.out.println("query is" + qry);
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			rst = stmt.executeQuery(qry);
			if (rst.next()) {
				frm.setHabCode(habcode);
				if (rst.getString("TOTAL_CSC_CONSTRUCTED") != null) {
					frm.setTotalCscConstructed(rst
							.getString("TOTAL_CSC_CONSTRUCTED"));
				}
				if (rst.getString("TOTAL_FUNCTIONAL_CSC") != null) {
					frm.setTotalFunctionalCsc(rst
							.getString("TOTAL_FUNCTIONAL_CSC"));
				}
				if (rst.getString("TOTAL_DEFUNCT_CSC") != null) {
					frm.setTotalDefunctCsc(rst.getString("TOTAL_DEFUNCT_CSC"));
				}
				if (rst.getString("NO_OFF_ADDL_CSC_REQ") != null) {
					frm.setNoofAdditionalCscRequired(rst
							.getString("NO_OFF_ADDL_CSC_REQ"));
				}
				if (rst.getString(5) != null) {
					frm.setSurveyDate(rst.getString(5));
				}
			}
		} catch (Exception e) {
			e.getMessage();
		} finally {
			closeAll();
		}

	}
/**
 * query for Updating and Saving Data
 * @param cs
 * @param dataSource
 * @return
 */

	public int updateData(bls_comm_santnForm cs, DataSource dataSource) {
		int i = 0;
		Connection conn1;
		String srchqry = "select * from rws_bls_comm_sani_comp_tbl where HABITATION_CODE='"
				+ cs.getHabCode() + "' ";
		String insertqry = "insert into rws_bls_comm_sani_comp_tbl values('"
				+ cs.getHabCode() + "',"
				+ Integer.parseInt(cs.getTotalCscConstructed()) + ","
				+ Integer.parseInt(cs.getTotalFunctionalCsc()) + ","
				+ Integer.parseInt(cs.getTotalDefunctCsc()) + ","
				+ Integer.parseInt(cs.getNoofAdditionalCscRequired())
				+ ",to_date('" + cs.getSurveyDate() + "','dd/mm/yyyy'))";
		String qry = "update rws_bls_comm_sani_comp_tbl set TOTAL_CSC_CONSTRUCTED="
				+ Integer.parseInt(cs.getTotalCscConstructed())
				+ ",TOTAL_FUNCTIONAL_CSC="
				+ Integer.parseInt(cs.getTotalFunctionalCsc())
				+ ",TOTAL_DEFUNCT_CSC="
				+ Integer.parseInt(cs.getTotalDefunctCsc())
				+ ",NO_OFF_ADDL_CSC_REQ="
				+ Integer.parseInt(cs.getNoofAdditionalCscRequired())
				+ ",SURVEY_DATE=to_date('"
				+ cs.getSurveyDate()
				+ "','dd/mm/yyyy')  where HABITATION_CODE='"
				+ cs.getHabCode()
				+ "' ";
		try {
			System.out.println("query is" + qry);
			conn1 = RwsOffices.getConn();
			stmt1 = conn1.createStatement();
			rst = stmt1.executeQuery(srchqry);
			if (rst.next()) {

				stmt = conn1.createStatement();

				i = stmt.executeUpdate(qry);
			} else {
				stmt = conn1.createStatement();

				i = stmt.executeUpdate(insertqry);
			}

		} catch (Exception e) {
			e.getMessage();
		} finally {
			closeAll();
		}
		return i;
	}

}
