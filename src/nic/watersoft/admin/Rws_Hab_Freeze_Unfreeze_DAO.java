package nic.watersoft.admin;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import nic.watersoft.commons.RwsOffices;

public class Rws_Hab_Freeze_Unfreeze_DAO {
	
	private Connection conn;
	private PreparedStatement stat, stat1, stat2, stat3;
	private ResultSet rset, rset1, rset2;;
	private String query, que, qry;

	private void closeAll() {
		if (rset != null) {
			try {
				rset.close();
			} catch (SQLException sqle) {
			}
		}
		if (stat != null) {
			try {
				stat.close();
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
	public boolean getHabFreezUnfreez(int hyear, String pyear, String fyear) {
		Connection conn = null;
		Statement stat = null;
		int[] mycount = null;
		boolean flag = true;
		String myresult = "";
		String extbl = "", stdt1 = "", stdt2 = "";
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			
			stat=conn.createStatement();
			
			query = "SELECT TNAME FROM TAB WHERE TNAME=?";
			stat1 = conn.prepareStatement(query);
			stat1.setString(1, "RWS_HABITATION_DIR_HIS"+hyear+"_TBL");			
			rset = stat1.executeQuery();
			if (rset.next()) {
				extbl = rset.getString(1);
			}
			
			qry = "SELECT DISTINCT SUBSTR((TO_CHAR(STATUS_DATE,'DD-MM-YYYY')),9,10) AS TDT FROM RWS_HABITATION_DIR_HIS_TBL WHERE STATUS_DATE IS NOT NULL";
			stat2 = conn.prepareStatement(qry);
			rset1 = stat2.executeQuery();
			if (rset1.next()) {
				stdt1 = rset1.getString(1);
			}
			
			que = "SELECT DISTINCT SUBSTR((TO_CHAR(STATUS_DATE,'DD-MM-YYYY')),9,10) FROM RWS_HABITATION_DIRECTORY_TBL WHERE STATUS_DATE IS NOT NULL";
			stat3 = conn.prepareStatement(que);
			rset2 = stat3.executeQuery();
			if (rset2.next()) {
				stdt2 = rset2.getString(1);
			}
			
			if (!extbl.equals("")) {
				flag = false;
			}
			else if (stdt1.equals(pyear)) {
				flag = false;

			} else if (stdt2.equals(fyear)) {
				flag = false;

			} else {
				String query1 = "create table RWS_HABITATION_DIR_HIS" + hyear + "_TBL as select * from RWS_HABITATION_DIR_HIS_TBL";
				stat.addBatch(query1);
				String query2 = "drop table RWS_HABITATION_DIR_HIS_TBL";
				stat.addBatch(query2);
				String query3 = "create table RWS_HABITATION_DIR_HIS_TBL as select * from rws_habitation_directory_tbl";
				stat.addBatch(query3);
				String query4 = "update rws_habitation_dir_dyna_tbl set status_date='01-APR-"+ fyear + "',PREVIOUS_YR_STATUS=coverage_status";
	            stat.addBatch(query4);
				String query5 = "update RWS_HABITATION_DIRECTORY_TBL a set(CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE,CENSUS_YEAR,CENSUS_PLAIN_POPU,CENSUS_SC_POPU,"						
						+ "CENSUS_ST_POPU,FLOAT_POP,FLOAT_POP_REASONS,STATUS_DATE,PLAIN_POPU_COVERED,SC_POP_COVERED,ST_POP_COVERED,TOTAL_WATER_SUPPLY,EXIST_WATER_LEVEL,COVERAGE_STATUS,"
						+ "NEAR_SURFACE_SOURCE,NEAR_GROUND_SOURCE,REMARKS,QUALITY_AFFECTED,UPDATE_DATE,PREVIOUS_YR_STATUS,PRESENT_YR_STATUS,PROPOSED_FC_YEAR,PROPOSED_FC_EST_AMT,HABITATION_TYPE,"
						+ "HOUSEHOLD_NO,SLIPPAGE_CODE,NO_OF_CATTLE,HABITATION_CATEGORY,EXISTING_SOURCES_NO,SAFE_SOURCES_NO,HABITATION_SUB_TYPE,NC_SOURCE_TYPE,SOURCE_DISTANCE,LPCD_COOKING,"
						+ "POPU_PERCENT_COVERED,MINORITY_DOMINATED,LWE,UNSAFE_LPCD,SAFE_LPCD,HAB_SUB_TYPE_40PC_CALC,TSP_NTSP,DDWS_HAB_CODE,NO_OF_HOUSECONN_GIVEN,IS_ITDA,HOUSEHOLDS_SC,HOUSEHOLDS_ST,"
						+ "HOUSEHOLDS_PLAIN,CON_SC,CON_ST,CON_PLAIN,HOUSEHOLDS_MINORITY,CON_MINORITY,MINORITY_POP_COVERED,CENSUS_MINORITY_POPU,NO_OF_PUBLIC_TAPS,NO_OF_TAPS_WITH_STANDPOSTS,"
						+ "NO_CHECKDAMS_REQ,NO_CHECKDAMS_EXIST,GLSR_NO,GLSR_QTY,OHSR_NO,OHSR_QTY,SCHEMESOURCE,ACT_COVERAGE_STATUS,ACT_PLAIN_POPU,ACT_SC_POPU,ACT_ST_POPU,ACT_HOUSE_HOLD,ACT_HOUSE_CONN,ACT_TOT_POPU,LPCD_ACT_POPU,previous_yr_status_act )"
						+ "=(select CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE,CENSUS_YEAR,CENSUS_PLAIN_POPU,CENSUS_SC_POPU,CENSUS_ST_POPU,FLOAT_POP,FLOAT_POP_REASONS,STATUS_DATE,"
						+ "PLAIN_POPU_COVERED,SC_POP_COVERED,ST_POP_COVERED,TOTAL_WATER_SUPPLY,EXIST_WATER_LEVEL,COVERAGE_STATUS,NEAR_SURFACE_SOURCE,NEAR_GROUND_SOURCE,REMARKS,QUALITY_AFFECTED,"
						+ "UPDATE_DATE,PREVIOUS_YR_STATUS,PRESENT_YR_STATUS,PROPOSED_FC_YEAR,PROPOSED_FC_EST_AMT,HABITATION_TYPE,HOUSEHOLD_NO,SLIPPAGE_CODE,NO_OF_CATTLE,HABITATION_CATEGORY,"
						+ "EXISTING_SOURCES_NO,SAFE_SOURCES_NO,HABITATION_SUB_TYPE,NC_SOURCE_TYPE,SOURCE_DISTANCE,LPCD_COOKING,POPU_PERCENT_COVERED,MINORITY_DOMINATED,LWE,UNSAFE_LPCD,SAFE_LPCD,"
						+ "HAB_SUB_TYPE_40PC_CALC,TSP_NTSP,DDWS_HAB_CODE,NO_OF_HOUSECONN_GIVEN,IS_ITDA,HOUSEHOLDS_SC,HOUSEHOLDS_ST,HOUSEHOLDS_PLAIN,CON_SC,CON_ST,CON_PLAIN,HOUSEHOLDS_MINORITY,"
						+ "CON_MINORITY,MINORITY_POP_COVERED,CENSUS_MINORITY_POPU,NO_OF_PUBLIC_TAPS,NO_OF_TAPS_WITH_STANDPOSTS,NO_CHECKDAMS_REQ,NO_CHECKDAMS_EXIST,GLSR_NO,GLSR_QTY,OHSR_NO,OHSR_QTY,"
						+ "SCHEMESOURCE,ACT_COVERAGE_STATUS,ACT_PLAIN_POPU,ACT_SC_POPU,ACT_ST_POPU,ACT_HOUSE_HOLD,ACT_HOUSE_CONN,ACT_TOT_POPU,LPCD_ACT_POPU,previous_yr_status_act "
						+ "from RWS_HABITATION_DIR_DYNA_TBL b where a.HAB_CODE=b.HAB_CODE)";
				
				
				stat.addBatch(query5);
				mycount = stat.executeBatch();
				for (int i = 0; i < mycount.length; i++) {
					if(mycount[i] == 1)
						flag = false;
				}
				flag = true;
				if (flag)
					conn.commit();
				conn.setAutoCommit(true);
				myresult = "success";
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("The Exception is in AdminDAO getHabFreezUnfreez = " + e.getMessage());
		} finally {
			closeAll();
		}
		return flag;
	}

	public String getHYear() {
		String cyear = "";
		Connection conn = null;
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			query = "SELECT TO_CHAR(SYSDATE,'DD-MM-YYYY') FROM DUAL";
			stat1 = conn.prepareStatement(query);
			rset = stat1.executeQuery();
			if (rset.next()) {
				cyear = rset.getString(1);
			}	
		} catch (Exception e) {
			System.out.println("The Exception is in AdminDAO getHYear : " + e.getMessage());
		} finally{
			closeAll();
		}
		return cyear;
	}
	/*				String query5 = "update RWS_HABITATION_DIRECTORY_TBL a set(CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE,CENSUS_YEAR,CENSUS_PLAIN_POPU,CENSUS_SC_POPU,"						
	+ "CENSUS_ST_POPU,FLOAT_POP,FLOAT_POP_REASONS,STATUS_DATE,PLAIN_POPU_COVERED,SC_POP_COVERED,ST_POP_COVERED,TOTAL_WATER_SUPPLY,EXIST_WATER_LEVEL,COVERAGE_STATUS,"
	+ "NEAR_SURFACE_SOURCE,NEAR_GROUND_SOURCE,REMARKS,QUALITY_AFFECTED,UPDATE_DATE,PREVIOUS_YR_STATUS,PRESENT_YR_STATUS,PROPOSED_FC_YEAR,PROPOSED_FC_EST_AMT,HABITATION_TYPE,"
	+ "HOUSEHOLD_NO,SLIPPAGE_CODE,NO_OF_CATTLE,HABITATION_CATEGORY,EXISTING_SOURCES_NO,SAFE_SOURCES_NO,HABITATION_SUB_TYPE,NC_SOURCE_TYPE,SOURCE_DISTANCE,LPCD_COOKING,"
	+ "POPU_PERCENT_COVERED,MINORITY_DOMINATED,LWE,UNSAFE_LPCD,SAFE_LPCD,HAB_SUB_TYPE_40PC_CALC,TSP_NTSP,DDWS_HAB_CODE,NO_OF_HOUSECONN_GIVEN,IS_ITDA,HOUSEHOLDS_SC,HOUSEHOLDS_ST,"
	+ "HOUSEHOLDS_PLAIN,CON_SC,CON_ST,CON_PLAIN,HOUSEHOLDS_MINORITY,CON_MINORITY,MINORITY_POP_COVERED,CENSUS_MINORITY_POPU,NO_OF_PUBLIC_TAPS,NO_OF_TAPS_WITH_STANDPOSTS,"
	+ "NO_CHECKDAMS_REQ,NO_CHECKDAMS_EXIST,GLSR_NO,GLSR_QTY,OHSR_NO,OHSR_QTY,SCHEMESOURCE)"
	+ "=(select CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE,CENSUS_YEAR,CENSUS_PLAIN_POPU,CENSUS_SC_POPU,CENSUS_ST_POPU,FLOAT_POP,FLOAT_POP_REASONS,STATUS_DATE,"
	+ "PLAIN_POPU_COVERED,SC_POP_COVERED,ST_POP_COVERED,TOTAL_WATER_SUPPLY,EXIST_WATER_LEVEL,COVERAGE_STATUS,NEAR_SURFACE_SOURCE,NEAR_GROUND_SOURCE,REMARKS,QUALITY_AFFECTED,"
	+ "UPDATE_DATE,PREVIOUS_YR_STATUS,PRESENT_YR_STATUS,PROPOSED_FC_YEAR,PROPOSED_FC_EST_AMT,HABITATION_TYPE,HOUSEHOLD_NO,SLIPPAGE_CODE,NO_OF_CATTLE,HABITATION_CATEGORY,"
	+ "EXISTING_SOURCES_NO,SAFE_SOURCES_NO,HABITATION_SUB_TYPE,NC_SOURCE_TYPE,SOURCE_DISTANCE,LPCD_COOKING,POPU_PERCENT_COVERED,MINORITY_DOMINATED,LWE,UNSAFE_LPCD,SAFE_LPCD,"
	+ "HAB_SUB_TYPE_40PC_CALC,TSP_NTSP,DDWS_HAB_CODE,NO_OF_HOUSECONN_GIVEN,IS_ITDA,HOUSEHOLDS_SC,HOUSEHOLDS_ST,HOUSEHOLDS_PLAIN,CON_SC,CON_ST,CON_PLAIN,HOUSEHOLDS_MINORITY,"
	+ "CON_MINORITY,MINORITY_POP_COVERED,CENSUS_MINORITY_POPU,NO_OF_PUBLIC_TAPS,NO_OF_TAPS_WITH_STANDPOSTS,NO_CHECKDAMS_REQ,NO_CHECKDAMS_EXIST,GLSR_NO,GLSR_QTY,OHSR_NO,OHSR_QTY,"
	+ "SCHEMESOURCE from RWS_HABITATION_DIR_DYNA_TBL b where a.HAB_CODE=b.HAB_CODE)";*/
}
