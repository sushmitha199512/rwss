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
		String insertqry = "insert into rws_bls_water_fac_Inhab_tbl values(?,?,?,?,?,?,?,?,?,to_date(?,'dd/mm/yyyy'))";
		String qry = "update rws_bls_water_fac_Inhab_tbl set TOTAL_STANDPOSTS=?"
				+ ",TOTAL_HOUSEHOLDS=?"
				+ ",TOTAL_MULTI_STANDPOST=?"
				+ ",TOTAL_MULTI_HOUSEHOLDS=?"
				+ ",TOTAL_PUMPS=?"
				+ ",TOTAL_OPENWELL=?"
				+ ",SEASONAL=?"
				+ ",THROUGH_OUT_YEAR =?"
				+ ",SURVEY_DATE=to_date(?,'dd/mm/yyyy') "
				+ " where HABITATION_CODE=?";
		try {
			System.out.println("query is" + qry);
			conn1 = RwsOffices.getConn();
			stmt1 = conn1.createStatement();
			rst = stmt1.executeQuery(srchqry);
			if (rst.next()) {

				stmt = conn1.createStatement();
                PreparedStatement ps=conn1.prepareStatement(qry);
                ps.setInt(1,Integer.parseInt(wf.getTotalStandposts()));
                ps.setInt(2, Integer.parseInt(wf.getTotalHouseholds()));
                ps.setInt(3, Integer.parseInt(wf.getTotalMultiStandposts()));
                ps.setInt(4, Integer.parseInt(wf.getTotalMultiHouseholds()));
                ps.setInt(5, Integer.parseInt(wf.getTotalPumps()));
                ps.setInt(6, Integer.parseInt(wf.getTotalOpenwell()));
                ps.setInt(7,Integer.parseInt(wf.getSeasonal()));
                ps.setInt(8, Integer.parseInt(wf.getThroughOutYear()));
                ps.setString(9, wf.getSurveyDate());
                ps.setString(10, wf.getHabCode());
				i = ps.executeUpdate();
			} else {
				stmt = conn1.createStatement();
				PreparedStatement ps=conn1.prepareStatement(insertqry);
                ps.setString(1, wf.getHabCode()); 
                ps.setInt(2, Integer.parseInt(wf.getTotalHouseholds()));
                ps.setInt(3, Integer.parseInt(wf.getTotalMultiStandposts()));
                ps.setInt(4, Integer.parseInt(wf.getTotalMultiHouseholds()));
                ps.setInt(5, Integer.parseInt(wf.getTotalPumps()));
                ps.setInt(6, Integer.parseInt(wf.getTotalOpenwell()));
                ps.setInt(7,Integer.parseInt(wf.getSeasonal()));
                ps.setInt(8, Integer.parseInt(wf.getThroughOutYear()));
                ps.setString(9, wf.getSurveyDate());
				i = ps.executeUpdate();
			}

		} catch (Exception e) {
			e.getMessage();
		} finally {
			closeAll();
		}
		return i;
	}
	
	
	
}
