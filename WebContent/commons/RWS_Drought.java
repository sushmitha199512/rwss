/*
 * Created on 21-Feb-2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.commons;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.sql.DataSource;

import com.ibm.icu.text.DateFormat;

import nic.watersoft.drought.DialyDroughtDetailsBean;
import nic.watersoft.drought.DroughtCumulativeFrm;
import nic.watersoft.drought.DroughtHabitationRecords;
import nic.watersoft.drought.WaterTransportFrm;

/**
 * @author NIC
 * 
 * TODO To change the template for this generated type comment go to Window -
 * Preferences - Java - Code Style - Code Templates
 */
public class RWS_Drought {
	public RWS_Drought() {

	}

	public HabDetails getDetailsByHabCode(String habcode) {

		String dcode = null, mcode = null, pcode = null, vcode = null;
		String query1 = null, query2 = null;
		Statement stmt1 = null, stmt2 = null, stmt3 = null, stmt4 = null, stmt5 = null, stmt6 = null;
		ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null, rs5 = null, rs6 = null;
		ArrayList result = new ArrayList();
		HabDetails habdetails = new HabDetails();
		habdetails.getHabworkdetails().clear();

		Connection conn = RwsOffices.getConn();
		try {
			stmt1 = conn.createStatement();
			stmt2 = conn.createStatement();
			stmt3 = conn.createStatement();
			stmt4 = conn.createStatement();
			stmt5 = conn.createStatement();
			stmt6 = conn.createStatement();

			//System.out.println(habcode);
			dcode = habcode.substring(0, 2);
			mcode = habcode.substring(5, 7);
			pcode = habcode.substring(12, 14);
			vcode = habcode.substring(7, 10);

			query1 = "select mname from rws_mandal_tbl where dcode='" + dcode
					+ "'and mcode='" + mcode + "'";
			rs1 = stmt1.executeQuery(query1);
			String mname = null;
			mname = "";
			if (rs1.next()) {
				mname = rs1.getString(1);
			}
			habdetails.setMname(mname);
			rs1.close();
			stmt1.close();

			query2 = "select pname,pcode from rws_panchayat_tbl where dcode='"
					+ dcode + "' and mcode='" + mcode + "'and pcode='" + pcode
					+ "'";
			rs2 = stmt2.executeQuery(query2);
			rs2.next();
			String pname = rs2.getString(1);
			habdetails.setPname(pname);
			String pcode1 = rs2.getString(2);
			rs2.close();
			stmt2.close();

			query2 = "select vname from rws_village_tbl where dcode='" + dcode
					+ "' and mcode='" + mcode + "'and pcode='" + pcode + "'";
			rs3 = stmt3.executeQuery(query2);
			rs3.next();
			String vname = rs3.getString(1);
			habdetails.setVname(vname);

			query2 = "select  distinct panch_name,COVERAGE_STATUS from rws_panchayat_raj_tbl,"
					+ "rws_habitation_directory_tbl c where c.coverage_status<>'UI'"
					+ " and c.coverage_status is not null  "
					+ "and c.hab_code='"
					+ habcode
					+ "' and panch_code='"
					+ habcode + "'";
			//System.out.println(query2);
			rs4 = stmt4.executeQuery(query2);

			rs4.next();
			String panch_name = rs4.getString(1);
			String coverageStatus = rs4.getString(2);
			habdetails.setHabName(panch_name);
			habdetails.setCoverageStatus(coverageStatus);
			rs4.close();
			stmt4.close();

			query2 = "select  distinct WORK_ID  from RWS_ADMN_HAB_LNK_TBL where hab_code='"
					+ habcode + "'";
			rs6 = stmt6.executeQuery(query2);
			while (rs6.next()) {
				query2 = "select distinct WORK_NAME,SANCTION_AMOUNT,to_char(PROBABLE_DATE,'dd/mm/yyyy')PROBABLE_DATE,TYPE_OF_ASSET_NAME from "
						+ "RWS_WORK_ADMN_TBL a,RWS_CONTRACTOR_SELECTION_TBL b,"
						+ " RWS_ASSET_TYPE_TBL c ,RWS_WORK_COMPLETION_TBL d where d.DATE_OF_COMM is null and a.work_id='"
						+ rs6.getString(1)
						+ "' and b.work_id='"
						+ rs6.getString(1)
						+ "' and  substr(a.work_id,7,2)=c.TYPE_OF_ASSET_CODE";
			//	System.out.println(query2);
				rs5 = stmt5.executeQuery(query2);

				while (rs5.next()) {

				//	System.out.println("comming");
					DroughtHabWorkDetails droughtHabWorkDetails = new DroughtHabWorkDetails();
					droughtHabWorkDetails.setName(rs5.getString(1));
					droughtHabWorkDetails.setAmount(Double.parseDouble(rs5
							.getString(2)));
					droughtHabWorkDetails.setPdate(rs5.getString(3));
					droughtHabWorkDetails.setType(rs5.getString(4));
					habdetails.getHabworkdetails().add(droughtHabWorkDetails);
				}
			}

			if (rs5 != null)
				rs5.close();
			stmt5.close();
			if (rs6 != null)
				rs6.close();
			stmt6.close();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return habdetails;

	}

	public String getAssetStatus(String status) {

		if (status == null)
			return "None";
		int value = Integer.parseInt(status);

		switch (value) {
		case 1:
			return "Working";
		case 2:
			return "NOT WORKING";
		case 3:
			return "DRIED";
		case 4:
			return "SEASONAL";
		case 5:
			return "CONDEMED";
		default:
			return "";

		}
	}

	/**
	 * @param string
	 * @return
	 */
	public String getPnamefromHab(String habcode) {
		Connection conn = RwsOffices.getConn();

		String dcode = habcode.substring(0, 2);
		String mcode = habcode.substring(5, 7);
		String pcode = habcode.substring(12, 14);
		String vcode = habcode.substring(7, 10);
		String pname = null;
		Statement stmt2 = null;
		ResultSet rs2 = null;
		try {
			stmt2 = conn.createStatement();

			String query2 = "select   panch_name from rws_panchayat_raj_tbl where panch_code='"
					+ habcode + "'";
			//System.out.println("QUERY2:" + query2);
			rs2 = stmt2.executeQuery(query2);
			rs2.next();
			pname = rs2.getString(1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
				if (stmt2 != null)
					stmt2.close();
				if (rs2 != null)
					rs2.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return pname;
	}

	/**
	 * @param habCode
	 * @param habName
	 * @param transportDetails
	 * @param droughtForm
	 */
	public void getExistingData(String habCode, String habName,
			ArrayList transportDetails, WaterTransportFrm droughtForm) {
		Connection conn = RwsOffices.getConn();
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat dateFormat = new SimpleDateFormat("dd/MM/yyyy");
		cal.add(Calendar.DATE, -1);
		String yesterDayDate = dateFormat.format(cal.getTime());
		cal.add(Calendar.DATE, -2);
		String dayBeforeYesterday = dateFormat.format(cal.getTime());

	//	System.out.println("Yesterday's date was "
		//		+ dateFormat.format(cal.getTime()));

		SimpleDateFormat dateFormatter = new SimpleDateFormat("dd/MM/yyyy");
		String currentDate = droughtForm.getCurrentDate();

		Statement stmt2 = null;
		ResultSet rs2 = null;
		Statement stmt = null;
		ResultSet rs = null;
		String query = null;

		try {
			stmt2 = conn.createStatement();
			String query2 = "select *from RWS_DROUGHT_HAB_TR_PVT_SO_TBL where HABITATION_CODE='"
					+ habCode
					+ "' and DATE_OF_ENTRY=to_date('"
					+ currentDate
					+ "','dd/mm/yyyy')";
		//	System.out.println("QUERY2:" + query2);
			rs2 = stmt2.executeQuery(query2);

			boolean r = rs2.next();
			DialyDroughtDetailsBean d = new DialyDroughtDetailsBean();
			d.setHabCode(habCode);
			d.setHabName(habName);

			if (r) {
				System.out.println("ISSS");
				d.setTransportPopulationServed(rs2.getInt("POPULATION_SER_TRANSPORT"));
				d.setNoOfTrips(rs2.getInt("TANKER_NO_OF_TRIPS"));
				d.setTanker_Capacity(rs2.getInt("TANKER_CAPACITY"));
				d.setTanker_QTY(rs2.getInt("TANKER_QTY"));
				d.setTanker_Remarks(rs2.getString("TANKER_REMARKS"));
				d.setAssetType(rs2.getString("ASSET_TYPE_CODE"));
				d.setPvtSourceHiredNo(rs2.getInt("PVT_SOURCES_HIRED_NO"));
				d.setPvtSourceQTY(rs2.getInt("PVT_SOURCES_QTY"));
				d.setPvtModeOfSupply(rs2.getString("PVT_MODE_OF_SUPPLY"));
				d.setPvtRemarks(rs2.getString("PVT_SOURCES_REMARKS"));
				d.setPowerProblemType(rs2.getString("POWER_SUPPLY_REG_IRREG_LOW"));
				d.setPowerSupplyRemarks(rs2.getString("POWER_SUPPLY_REMARKS"));
				
				d.setHiringPopulationServed(rs2.getInt("POPULATION_SER_PVT_HIRED"));
				d.setChecks("on");
				d.setUpdate(true);

			} else {
				stmt = conn.createStatement();
				query = "select *from RWS_DROUGHT_HAB_TR_PVT_SO_TBL where HABITATION_CODE='"
						+ habCode
						+ "' and DATE_OF_ENTRY=to_date('"
						+ yesterDayDate + "','dd/mm/yyyy')";
			//System.out.println("QUERYS:" + query);
				rs = stmt.executeQuery(query);

				boolean f = rs.next();
				if (f) {

					d.setTransportPopulationServed(rs.getInt("POPULATION_SER_TRANSPORT"));
					d.setNoOfTrips(rs.getInt("TANKER_NO_OF_TRIPS"));
					d.setTanker_Capacity(rs.getInt("TANKER_CAPACITY"));
					d.setTanker_QTY(rs.getInt("TANKER_QTY"));
					d.setTanker_Remarks(rs.getString("TANKER_REMARKS"));
					d.setAssetType(rs.getString("ASSET_TYPE_CODE"));
					d.setPvtSourceHiredNo(rs.getInt("PVT_SOURCES_HIRED_NO"));
					d.setPvtSourceQTY(rs.getInt("PVT_SOURCES_QTY"));
					d.setPvtModeOfSupply(rs.getString("PVT_MODE_OF_SUPPLY"));
					d.setPvtRemarks(rs.getString("PVT_SOURCES_REMARKS"));
					d.setPowerProblemType(rs.getString("POWER_SUPPLY_REG_IRREG_LOW"));
					d.setPowerSupplyRemarks(rs.getString("POWER_SUPPLY_REMARKS"));
					
					d.setHiringPopulationServed(rs.getInt("POPULATION_SER_PVT_HIRED"));

					d.setChecks("on");
					d.setUpdate(true);
				} else {
					stmt = conn.createStatement();
					query = "select *from RWS_DROUGHT_HAB_TR_PVT_SO_TBL where HABITATION_CODE='"
							+ habCode
							+ "' and DATE_OF_ENTRY=to_date('"
							+ dayBeforeYesterday + "','dd/mm/yyyy')";
					//System.out.println("QUERY2:" + query);
					rs = stmt.executeQuery(query);

					f = rs.next();
					if (f) {

						d.setTransportPopulationServed(rs.getInt("POPULATION_SER_TRANSPORT"));
						d.setNoOfTrips(rs.getInt("TANKER_NO_OF_TRIPS"));
						d.setTanker_Capacity(rs.getInt("TANKER_CAPACITY"));
						d.setTanker_QTY(rs.getInt("TANKER_QTY"));
						d.setTanker_Remarks(rs.getString("TANKER_REMARKS"));
						d.setAssetType(rs.getString("ASSET_TYPE_CODE"));
						d.setPvtSourceHiredNo(rs.getInt("PVT_SOURCES_HIRED_NO"));
						d.setPvtSourceQTY(rs.getInt("PVT_SOURCES_QTY"));
						d.setPvtModeOfSupply(rs.getString("PVT_MODE_OF_SUPPLY"));
						d.setPvtRemarks(rs.getString("PVT_SOURCES_REMARKS"));
						d.setPowerProblemType(rs.getString("POWER_SUPPLY_REG_IRREG_LOW"));
						d.setPowerSupplyRemarks(rs.getString("POWER_SUPPLY_REMARKS"));
						
						d.setHiringPopulationServed(rs.getInt("POPULATION_SER_PVT_HIRED"));
						d.setChecks("on");
						d.setUpdate(true);
					}
				}
			}

			transportDetails.add(d);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
				if (stmt2 != null)
					stmt2.close();
				if (rs2 != null)
					rs2.close();
				if (stmt != null)
					stmt.close();
				if (rs != null)
					rs.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	/**
	 * @param d
	 * @param m
	 * @param dataSource
	 * @return
	 */
	public ArrayList getHabitationstransport(String d, String m,
			DataSource dataSource) {
		ArrayList habs = new ArrayList();
		String query = null;
		String query1 = null;
		Statement stmt1 = null;
		ResultSet rs1 = null;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;

		String habCode = null;
		try {

			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			stmt1 = conn.createStatement();

			query = "SELECT DH.HABCODE FROM rws_drought_habitation_tbl DH WHERE SUBSTR(DH.HABCODE,1,2)='"
					+ d + "' AND SUBSTR(DH.HABCODE,6,2)='" + m + "'";
			//System.out.println("query1:" + query);
			rs = stmt.executeQuery(query);
			while (rs.next()) {

				habCode = rs.getString(1);
				query1 = "SELECT * FROM RWS_PANCHAYAT_RAJ_TBL WHERE panch_code='"
						+ habCode + "'";
			//	System.out.println("query2:" + query1);

				rs1 = stmt1.executeQuery(query1);

				while (rs1.next()) {
					DroughtCumulativeFrm frm = new DroughtCumulativeFrm();

					getExistRecords(frm, habCode);
					frm.setHabCode(rs1.getString(2));
					frm.setHabName(rs1.getString(3));
					habs.add(frm);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			try {
				if (conn != null)
					conn.close();
				if (stmt != null)
					stmt1.close();
				if (rs != null)
					rs.close();
				if (rs1 != null)
					rs1.close();

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return habs;
	}

	/**
	 * @param frm
	 * @param habCode
	 */
	private void getExistRecords(DroughtCumulativeFrm frm, String habCode) {
		String query = null;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		SimpleDateFormat dateFormatter = new SimpleDateFormat("dd/MM/yyyy");
		String currentDate = dateFormatter.format(new Date());

		try {

			conn = RwsOffices.getConn();
			stmt = conn.createStatement();

			query = "SELECT TRANSPORT_EXP,FLUSHING_EXP,HIRING_EXP,DEEPENING,FINANCIAL_YEAR FROM RWS_DROUGHT_CUM_EXP_TBL WHERE HABITATION_CODE ='"
					+ habCode
					+ "' and date_entered=to_date('"
					+ currentDate
					+ "','dd/mm/yyyy')";
		//	System.out.println("query1:" + query);
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				frm.setTransportationEST(Integer.parseInt(rs.getString(1)));
				frm.setFlushingEST(Integer.parseInt(rs.getString(2)));
				frm.setHiringOfSourcesEST(Integer.parseInt(rs.getString(3)));
				frm.setDeepeningEST(Integer.parseInt(rs.getString(4)));
				frm.setFinancialYear(rs.getString(5));
				frm.setChecks("on");

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
				if (stmt != null)
					stmt.close();
				if (rs != null)
					rs.close();

			} catch (Exception e) {
				e.printStackTrace();
			}

		}
	}

	/**
	 * @param resultData
	 * @param dd
	 * @param mm
	 * @return
	 */
	public int[] saveHabitations(List resultData, String dist, String mand) {
		int count[] = {};

		Connection conn = null;
		Statement stmt = null;
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			ResultSet rs1 = null;
			stmt = conn.createStatement();
			SimpleDateFormat dateFormatter = new SimpleDateFormat("dd/MM/yyyy");
			String currentDate = dateFormatter.format(new Date());
		//	System.out.println("resultData.size" + resultData.size());

			for (int i = 0; i < resultData.size(); i++) {
				DroughtHabitationRecords dr = (DroughtHabitationRecords) resultData
						.get(i);
				if (dr == null)
					continue;

				if (!checkIsExistsOrNot(dr.getHabCode(), dr.getToDate())) {

					String query = "insert into RWS_DROUGHT_CUM_EXP_TBL(HABITATION_CODE,DATE_ENTERED,TRANSPORT_EXP,FLUSHING_EXP,HIRING_EXP,DEEPENING,FINANCIAL_YEAR) values ('"
							+ dr.getHabCode()
							+ "',"
							+ "to_date('"
							+ dr.getToDate()
							+ "',"
							+ "'dd/mm/yyyy'),'"
							+ dr.getTransportationEST()
							+ "','"
							+ dr.getFlushingEST()
							+ "','"
							+ dr.getHiringOfSourcesEST()
							+ "','"
							+ dr.getDeepeningEST()
							+ "','"
							+ dr.getFinancialYear() + "')";

					//System.out.println("Query:" + query);
					stmt.addBatch(query);

				} else {
					String query = "update RWS_DROUGHT_CUM_EXP_TBL set TRANSPORT_EXP='"
							+ dr.getTransportationEST()
							+ "',FLUSHING_EXP='"
							+ dr.getFlushingEST()
							+ "',HIRING_EXP='"
							+ dr.getHiringOfSourcesEST()
							+ "',DEEPENING='"
							+ dr.getDeepeningEST()
							+ "',FINANCIAL_YEAR='"
							+ dr.getFinancialYear()
							+ "' where HABITATION_CODE='"
							+ dr.getHabCode()
							+ "'and date_entered=to_date('"
							+ dr.getToDate()
							+ "','dd/mm/yyyy')";
					//System.out.println("Query:" + query);
					stmt.addBatch(query);

				}
			}
			count = stmt.executeBatch();
			if (count.length > 0) {
				conn.setAutoCommit(true);
				conn.commit();
			} else
				conn.rollback();
		} catch (Exception e) {
			e.printStackTrace();
		}
		try {
			if (conn != null)
				conn.close();
			if (stmt != null)
				stmt.close();
		} catch (Exception e) {

		}
		return count;

	}

	/**
	 * @param habCode
	 * @param toDate
	 * @return
	 */
	private boolean checkIsExistsOrNot(String habCode, String toDate) {
		String query = null;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;

		try {

			conn = RwsOffices.getConn();
			stmt = conn.createStatement();

			query = "SELECT *FROM RWS_DROUGHT_CUM_EXP_TBL WHERE HABITATION_CODE ='"
					+ habCode
					+ "' and date_entered=to_date('"
					+ toDate
					+ "','dd/mm/yyyy')";
			//System.out.println("query1:" + query);
			rs = stmt.executeQuery(query);
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
				if (stmt != null)
					stmt.close();
				if (rs != null)
					rs.close();

			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		return false;
	}

	/**
	 * @param mandal
	 * @return
	 */
	public ArrayList getSelectedHabitations(String mandalCode, String distCode) {

		ArrayList habs = new ArrayList();
		String query = null;
		String query1 = null;
		Statement stmt1 = null;
		ResultSet rs1 = null;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;

		String habCode = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			stmt1 = conn.createStatement();

			query = "SELECT DH.HABCODE FROM rws_drought_habitation_tbl DH WHERE SUBSTR(DH.HABCODE,1,2)='"
					+ distCode
					+ "' AND SUBSTR(DH.HABCODE,6,2)='"
					+ mandalCode
					+ "'";

			/**
			 * query = "SELECT DH.panch_code FROM rws_complete_hab_view DH WHERE
			 * SUBSTR(DH.panch_code,1,2)='" + distCode + "' AND
			 * SUBSTR(DH.panch_code,6,2)='" + mandalCode + "'";
			 */

			//	System.out.println("query1:" + query);
			rs = stmt.executeQuery(query);
			while (rs.next()) {

				habCode = rs.getString(1);
				//System.out.println("habCode:" + habCode);
				query1 = "SELECT * FROM RWS_PANCHAYAT_RAJ_TBL WHERE panch_code='"
						+ habCode + "'";
				//System.out.println("query2:" + query1);

				rs1 = stmt1.executeQuery(query1);

				while (rs1.next()) {
					RwsLocationBean rwsLocation = new RwsLocationBean();
					rwsLocation.setHabCode(rs1.getString(2));
					rwsLocation.setHabName(rs1.getString(3));
					habs.add(rwsLocation);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null)
					conn.close();
				if (stmt != null)
					stmt.close();
				if (stmt1 != null)
					stmt1.close();
				if (rs != null)
					rs.close();
				if (rs1 != null)
					rs1.close();
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return habs;
	}

}

