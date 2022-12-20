package nic.watersoft.BaseLineSurvey;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.sql.DataSource;

import nic.watersoft.commons.RwsOffices;

public class water_facDAO {
	Connection conn = null;
	ResultSet rst = null;
	PreparedStatement pstmt = null;
	Statement stmt = null, stmt1 = null, stmt2 = null;
	DataSource datasource = null;
	water_facDAO() {
	}

	water_facDAO(DataSource datasource) {
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
 * Retrieving columns in rws_bls_water_fac_Inhab_tbl using habcode
 * @param dataSource
 * @param habcode
 * @param frm
 */
	public void getHabdet(DataSource dataSource, String habcode,water_facForm frm) {

		Connection conn;
		String qry = "select TOTAL_STANDPOSTS,TOTAL_HOUSEHOLDS,TOTAL_MULTI_STANDPOST,TOTAL_MULTI_HOUSEHOLDS,TOTAL_PUMPS,TOTAL_OPENWELL,(case when SEASONAL='NULL' then 0 else 1 end),(case when THROUGH_OUT_YEAR='NULL' then 0 else 1 end),to_char(SURVEY_DATE,'dd/mm/yyyy') from rws_bls_water_fac_Inhab_tbl where HABITATION_CODE="+ habcode + "";
		try {
			System.out.println("query is" + qry);
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			rst = stmt.executeQuery(qry);
			if (rst.next()) {
				frm.setHabCode(habcode);
				if (rst.getString(1) != null) {
					frm.setTotalStandposts(rst.getString(1));
				}
				if (rst.getString(2) != null) {
					frm.setTotalHouseholds(rst.getString(2));
				}
				if (rst.getString(3) != null) {
					frm.setTotalMultiStandposts(rst.getString(3));
				}
				if (rst.getString(4) != null) {
					frm.setTotalMultiHouseholds(rst.getString(4));
				}
				if (rst.getString(5) != null) {
					frm.setTotalPumps(rst.getString(5));
				}
				if (rst.getString(6) != null) {
					frm.setTotalOpenwell(rst.getString(6));
				}
				if (rst.getString(7) != null) {
					frm.setSeasonal(rst.getString(7));
				}
				if (rst.getString(8) != null) {
					frm.setThroughOutYear(rst.getString(8));
				}
				
				if (rst.getString(9) != null) {
					frm.setSurveyDate(rst.getString(9));
				}
			
			}
		} catch (Exception e) {
			e.getMessage();
		} finally {
			closeAll();
		}

	}
	
	public int updateData(water_facForm wf, DataSource dataSource) {
		int i = 0;
		Connection conn1;
		String srchqry = "select * from rws_bls_water_fac_Inhab_tbl where HABITATION_CODE='"+ wf.getHabCode() + "' ";
		String insertqry = "insert into rws_bls_water_fac_Inhab_tbl values('"+ wf.getHabCode() + "',"
			    + Integer.parseInt(wf.getTotalStandposts()) + ","
			    + Integer.parseInt(wf.getTotalHouseholds()) + ","
				+ Integer.parseInt(wf.getTotalMultiStandposts()) + ","
				+ Integer.parseInt(wf.getTotalMultiHouseholds())+","
				+ Integer.parseInt(wf.getTotalPumps())+","
				+ Integer.parseInt(wf.getTotalOpenwell())+","
				+ Integer.parseInt(wf.getSeasonal())+","
				+ Integer.parseInt(wf.getThroughOutYear())+","
				+ ",to_date('" + wf.getSurveyDate() + "','dd/mm/yyyy'))";
		String qry = "update rws_bls_water_fac_Inhab_tbl set TOTAL_STANDPOSTS="
				+ Integer.parseInt(wf.getTotalStandposts())
				+ ",TOTAL_HOUSEHOLDS="
				+ Integer.parseInt(wf.getTotalHouseholds())
				+ ",TOTAL_MULTI_STANDPOST="
				+ Integer.parseInt(wf.getTotalMultiStandposts())
				+ ",TOTAL_MULTI_HOUSEHOLDS="
				+ Integer.parseInt(wf.getTotalMultiHouseholds())
				+ ",TOTAL_PUMPS="
				+ Integer.parseInt(wf.getTotalPumps())
				+ ",TOTAL_OPENWELL="
				+ Integer.parseInt(wf.getTotalOpenwell())
				+ ",SEASONAL="
				+ Integer.parseInt(wf.getSeasonal())
				+ ",THROUGH_OUT_YEAR ="
				+ Integer.parseInt(wf.getThroughOutYear())
				+ ",SURVEY_DATE=to_date('"
				+ wf.getSurveyDate()
				+ "','dd/mm/yyyy')  where HABITATION_CODE='"
				+ wf.getHabCode()
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
