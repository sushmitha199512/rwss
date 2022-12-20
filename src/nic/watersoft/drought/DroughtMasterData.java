package nic.watersoft.drought;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;

import javax.sql.DataSource;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RWS_Drought;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUtils;
import nic.watersoft.works.WorksData1;

// Referenced classes of package nic.watersoft.complaints:
//            CompForm

public class DroughtMasterData {
	Connection conn = null;

	Statement stmt = null;

	Statement stmt1 = null;

	Statement stmt2 = null;

	Statement stmt3 = null;

	Statement stmt4 = null;

	Statement stmt5 = null;

	Statement stmt6 = null;

	Statement stmt7 = null;

	Statement stmt8 = null;

	Statement stmt9 = null;

	Statement stmt10 = null;

	Statement stmt11 = null;

	Statement stmt12 = null;

	Statement stmt13 = null;

	Statement stmt14 = null;

	Statement stmt15 = null;

	Statement stmt16 = null;

	Statement stmt17 = null;

	Statement stmt18 = null;

	Statement stmt19 = null;

	Statement stmt20 = null;

	Statement stmt21 = null;

	Statement stmt22 = null;

	Statement stmt23 = null;

	Statement stmt24 = null;

	ResultSet rs = null;

	ResultSet rset = null;

	ResultSet rs1 = null;

	ResultSet rs2 = null;

	ResultSet rs3 = null;

	ResultSet rs4 = null;

	ResultSet rs5 = null;

	ResultSet rs6 = null;

	ResultSet rs7 = null;

	ResultSet rs8 = null;

	ResultSet rs9 = null;

	ResultSet rs10 = null;

	ResultSet rs11 = null;

	ResultSet rs12 = null;

	ResultSet rs13 = null;

	ResultSet rs14 = null;

	ResultSet rs15 = null;

	ResultSet rs16 = null;

	ResultSet rs17 = null;

	ResultSet rs18 = null;

	ResultSet rs19 = null;

	ResultSet rs20 = null;

	ResultSet rs21 = null;

	ResultSet rs22 = null;

	ResultSet rs23 = null;

	ResultSet rs24 = null;

	int connCount = 0;

	PreparedStatement ps = null;

	public DroughtMasterData() {
	}

	public void closeAll() throws Exception {
		Connection conn = null;
		Statement stmt = null;
		Statement stmt1 = null;
		Statement stmt2 = null;
		Statement stmt3 = null;
		Statement stmt4 = null;
		Statement stmt5 = null;
		Statement stmt6 = null;
		Statement stmt7 = null;
		Statement stmt8 = null;
		Statement stmt9 = null;
		Statement stmt10 = null;
		Statement stmt11 = null;
		Statement stmt12 = null;
		Statement stmt13 = null;
		Statement stmt14 = null;
		Statement stmt15 = null;
		Statement stmt16 = null;
		Statement stmt17 = null;
		Statement stmt18 = null;
		Statement stmt19 = null;
		Statement stmt20 = null;
		Statement stmt21 = null;
		Statement stmt22 = null;
		Statement stmt23 = null;
		Statement stmt24 = null;
		ResultSet rs = null;
		ResultSet rset = null;
		ResultSet rs1 = null;
		ResultSet rs2 = null;
		ResultSet rs3 = null;
		ResultSet rs4 = null;
		ResultSet rs5 = null;
		ResultSet rs6 = null;
		ResultSet rs7 = null;
		ResultSet rs8 = null;
		ResultSet rs9 = null;
		ResultSet rs10 = null;
		ResultSet rs11 = null;
		ResultSet rs12 = null;
		ResultSet rs13 = null;
		ResultSet rs14 = null;
		ResultSet rs15 = null;
		ResultSet rs16 = null;
		ResultSet rs17 = null;
		ResultSet rs18 = null;
		ResultSet rs19 = null;
		ResultSet rs20 = null;
		ResultSet rs21 = null;
		ResultSet rs22 = null;
		ResultSet rs23 = null;
		ResultSet rs24 = null;
		int connCount = 0;
		PreparedStatement ps = null;

		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				System.out.println("The error in complaintMasterData" + e);
			}
			rs = null;
		}
		if (rs1 != null) {
			try {
				rs1.close();
			} catch (Exception e) {
				System.out.println("The error in complaintMasterData" + e);
			}
			rs1 = null;
		}
		if (rs2 != null) {
			try {
				rs2.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs2 = null;
		}
		if (rs3 != null) {
			try {
				rs3.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs3 = null;
		}
		if (rs4 != null) {
			try {
				rs4.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs4 = null;
		}
		if (rs5 != null) {
			try {
				rs5.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs5 = null;
		}
		if (rs6 != null) {
			try {
				rs6.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs6 = null;
		}
		if (rs7 != null) {
			try {
				rs7.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs7 = null;
		}
		if (rs8 != null) {
			try {
				rs8.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs8 = null;
		}
		if (rs9 != null) {
			try {
				rs9.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs9 = null;
		}
		if (rs10 != null) {
			try {
				rs10.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs10 = null;
		}
		if (rs11 != null) {
			try {
				rs11.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs11 = null;
		}
		if (rs12 != null) {
			try {
				rs12.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs12 = null;
		}
		if (rs13 != null) {
			try {
				rs13.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs13 = null;
		}
		if (rs14 != null) {
			try {
				rs14.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs14 = null;
		}
		if (rs15 != null) {
			try {
				rs15.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs15 = null;
		}
		if (rs16 != null) {
			try {
				rs16.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs16 = null;
		}
		if (rs17 != null) {
			try {
				rs17.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs17 = null;
		}
		if (rs18 != null) {
			try {
				rs18.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs18 = null;
		}
		if (rs19 != null) {
			try {
				rs19.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs19 = null;
		}
		if (rs20 != null) {
			try {
				rs20.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs20 = null;
		}
		if (rs21 != null) {
			try {
				rs21.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs21 = null;
		}
		if (rs22 != null) {
			try {
				rs22.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs22 = null;
		}
		if (rs23 != null) {
			try {
				rs23.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs23 = null;
		}
		if (rs24 != null) {
			try {
				rs24.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rs24 = null;
		}
		if (rset != null) {
			try {
				rset.close();
			} catch (Exception e) {
				Debug.println("The error in complaintMasterData" + e);
			}
			rset = null;
		}
		if (stmt != null) {
			try {
				stmt.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt = null;
		}
		if (stmt1 != null) {
			try {
				stmt1.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt1 = null;
		}
		if (stmt2 != null) {
			try {
				stmt2.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt2 = null;
		}
		if (stmt3 != null) {
			try {
				stmt3.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt3 = null;
		}
		if (stmt4 != null) {
			try {
				stmt4.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt4 = null;
		}
		if (stmt5 != null) {
			try {
				stmt5.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt5 = null;
		}
		if (stmt6 != null) {
			try {
				stmt6.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt6 = null;
		}
		if (stmt7 != null) {
			try {
				stmt7.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt7 = null;
		}
		if (stmt8 != null) {
			try {
				stmt8.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt8 = null;
		}
		if (stmt9 != null) {
			try {
				stmt9.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt9 = null;
		}
		if (stmt10 != null) {
			try {
				stmt10.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt10 = null;
		}
		if (stmt11 != null) {
			try {
				stmt11.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt11 = null;
		}
		if (stmt12 != null) {
			try {
				stmt12.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt12 = null;
		}
		if (stmt13 != null) {
			try {
				stmt13.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt13 = null;
		}
		if (stmt14 != null) {
			try {
				stmt14.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt14 = null;
		}
		if (stmt15 != null) {
			try {
				stmt15.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt15 = null;
		}
		if (stmt16 != null) {
			try {
				stmt16.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt16 = null;
		}
		if (stmt17 != null) {
			try {
				stmt17.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt17 = null;
		}
		if (stmt18 != null) {
			try {
				stmt18.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt18 = null;
		}
		if (stmt19 != null) {
			try {
				stmt19.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt19 = null;
		}
		if (stmt20 != null) {
			try {
				stmt20.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt20 = null;
		}
		if (stmt21 != null) {
			try {
				stmt21.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt21 = null;
		}
		if (stmt22 != null) {
			try {
				stmt22.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt22 = null;
		}
		if (stmt23 != null) {
			try {
				stmt23.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt23 = null;
		}
		if (stmt24 != null) {
			try {
				stmt24.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			stmt24 = null;
		}
		if (ps != null) {
			try {
				ps.close();
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			ps = null;
		}
		if (conn != null) {
			try {
				conn.close();
				if (conn.isClosed())
					connCount--;
			} catch (Exception e) {
				Debug.println("The error in closeAll=" + e);
			}
			conn = null;
		}
	}

	// Added on 14-03-2012 by srilaxmi
	/// Added by srilaxmi on 25/02/2012
	// Added by srilaxmi on 25-02-2012 added for scarcity reasons for data mode

	public static String getScarcityCode(DataSource dataSource) throws Exception {
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		String scode = null;

		try {

			droughtMasterData.conn = RwsOffices.getConn();

			droughtMasterData.stmt = droughtMasterData.conn.createStatement();
			droughtMasterData.rs = droughtMasterData.stmt
					.executeQuery("SELECT MAX(to_number(SCARCITY_CODE))+1 FROM RWS_DROUGHT_SCAR_REASONS_TBL");
			droughtMasterData.rs.next();
			scode = droughtMasterData.rs.getString(1);
			if (scode == null) {
				scode = "1";
			}
		} catch (Exception e) {
			System.out.println("The error in getScarcityCode=" + e);
		} finally {
			droughtMasterData.closeAll();

		}
		return scode;
	}

	// /Added by srilaxmi on 25/02/2012 for insert
	public static int insertScarcity(DroughtBean droughtBean, DataSource dataSource) throws Exception {
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		int rowCount = 0;
		PreparedStatement pst = null;

		try {

			droughtMasterData.conn = RwsOffices.getConn();
			String query = "insert into rws_drought_scar_reasons_tbl values(?,?)";

			pst = droughtMasterData.conn.prepareStatement(query);
			pst.setString(1, droughtBean.getScarcityCode());
			pst.setString(2, droughtBean.getScarcityName().toUpperCase());

			rowCount = pst.executeUpdate();
		} catch (Exception e) {
			System.out.println("The error in insertScarcity= " + e);
		} finally {
			droughtMasterData.closeAll();

		}
		return rowCount;
	}

	//// Added by srilaxmi on 25/02/2012 for delete
	public static int removeScarcity(String scarcitycode, DataSource dataSource) throws Exception {
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		int rcount = 0;
		PreparedStatement pst = null;
		try {

			droughtMasterData.conn = RwsOffices.getConn();
			String query = "delete  from rws_drought_scar_reasons_tbl where SCARCITY_CODE =? ";
			pst = droughtMasterData.conn.prepareStatement(query);
			pst.setString(1, scarcitycode);

			rcount = pst.executeUpdate();
		} catch (Exception e) {
			System.out.println("The error in removeScarcity= " + e);
		} finally {
			droughtMasterData.closeAll();

		}
		return rcount;
	}

	// Added on 20-04-2012 by sreelaxmi for sources-inclusin
	public ArrayList getDroughtHps(String habcode, String year1, DataSource dataSource) throws Exception {

		ArrayList habs = new ArrayList();
		DroughtMasterData droughtMasterData = new DroughtMasterData();

		boolean exists = false;
		DroughtFlushRecords droughtFlushRecords = null;
		String querysources = "";
		String query = "";
		String queryow = "";
		PreparedStatement pst = null, pst1 = null;
		try {

			exists = false;

			droughtMasterData.conn = RwsOffices.getConn();

			// for getting details of hps

			query = "select distinct panch_code,panch_name,hp_code,nvl(c.location,'-'),"
					+ "decode(c.asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED')  from "
					+ " rws_complete_hab_view a,rws_hp_subcomp_param_tbl b,rws_asset_mast_tbl c  where a.panch_code=substr(b.hp_code,1,16) and "
					+ "  c.asset_code=b.asset_code and c.hab_code=a.panch_code and  substr(panch_code,1,16)=?"
					+ " and a.panch_code=substr(b.hp_code,1,16) order by panch_code";

			pst = droughtMasterData.conn.prepareStatement(query);
			pst.setString(1, habcode);
			droughtMasterData.rs = pst.executeQuery();

			// Debug.println("Query***********for habitationshps****" + query);
			while (droughtMasterData.rs.next()) {

				droughtFlushRecords = new DroughtFlushRecords();
				droughtFlushRecords.setThabitationCode(droughtMasterData.rs.getString(1));
				getExistingData(droughtFlushRecords, droughtMasterData.rs.getString(3));

				droughtFlushRecords.setThabName(droughtMasterData.rs.getString(2));
				droughtFlushRecords.setHpCode(droughtMasterData.rs.getString(3));
				droughtFlushRecords.setLocation(droughtMasterData.rs.getString(4));
				droughtFlushRecords.setStatus(droughtMasterData.rs.getString(5));

				habs.add(droughtFlushRecords);

			}

			// Added for openwells
			queryow = "select distinct  panch_code,panch_name,openwell_code,nvl(c.location,'-'),"
					+ "decode(c.asset_status,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED') from  "
					+ "rws_complete_hab_view a,rws_open_well_mast_tbl b,rws_asset_mast_tbl c  where    c.asset_code=b.asset_code and"
					+ " c.hab_code=a.panch_code and substr(b.openwell_code,1,16)=a.panch_code and   substr(panch_code,1,16)=?"
					+ " and a.panch_code=substr(b.openwell_code,1,16) order by panch_code";

			pst1 = droughtMasterData.conn.prepareStatement(queryow);
			pst1.setString(1, habcode);
			droughtMasterData.rs3 = pst1.executeQuery();

			while (droughtMasterData.rs3.next()) {

				droughtFlushRecords = new DroughtFlushRecords();

				droughtFlushRecords.setThabitationCode(droughtMasterData.rs3.getString(1));
				getExistingData(droughtFlushRecords, droughtMasterData.rs3.getString(3));

				droughtFlushRecords.setThabName(droughtMasterData.rs3.getString(2));
				droughtFlushRecords.setHpCode(droughtMasterData.rs3.getString(3));
				droughtFlushRecords.setLocation(droughtMasterData.rs3.getString(4));
				droughtFlushRecords.setStatus(droughtMasterData.rs3.getString(5));
				habs.add(droughtFlushRecords);

			}

			// Added for sources on 20-04-2012 by sreelaxmi
			querysources = "select distinct panch_code,panch_name,source_code,nvl(c.location,'-'),"
					+ "nvl(decode(c.asset_status,'1','WORKING','2','DEFUNCT'),'-')  from  rws_complete_hab_view a,rws_source_tbl b,"
					+ "rws_asset_mast_tbl c  where a.panch_code=substr(b.source_code,1,16) and   c.asset_code=b.asset_code and"
					+ " c.hab_code=a.panch_code and source_type_code='1' and  substr(panch_code,1,16)=?"
					+ " and a.panch_code=substr(b.source_code,1,16) order by panch_code";

			pst = droughtMasterData.conn.prepareStatement(querysources);
			pst.setString(1, habcode);
			droughtMasterData.rs5 = pst.executeQuery();

			while (droughtMasterData.rs5.next()) {

				droughtFlushRecords = new DroughtFlushRecords();
				droughtFlushRecords.setThabitationCode(droughtMasterData.rs5.getString(1));
				getExistingData(droughtFlushRecords, droughtMasterData.rs5.getString(3));

				droughtFlushRecords.setThabName(droughtMasterData.rs5.getString(2));
				droughtFlushRecords.setHpCode(droughtMasterData.rs5.getString(3));
				droughtFlushRecords.setLocation(droughtMasterData.rs5.getString(4));
				droughtFlushRecords.setStatus(droughtMasterData.rs5.getString(5));

				habs.add(droughtFlushRecords);

			}

			//

			//

		} catch (Exception e) {
			System.out.println("The error in getHabitationstransportdrought=" + e);
		} finally {
			droughtMasterData.closeAll();
			// Debug.println("ConnCount after closing is " + connCount);
		}
		return habs;
	}

	//////// Added by srilaxmi on 25/02/2012 for view
	public static ArrayList getScarcity(DataSource dataSource) throws Exception {
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		DroughtForm droughtForm = null;
		ArrayList scarcity = new ArrayList();
		String query = "";

		try {
			droughtMasterData.conn = RwsOffices.getConn();
			droughtMasterData.stmt = droughtMasterData.conn.createStatement();
			query = "select * from rws_drought_scar_reasons_tbl order by SCARCITY_CODE ";
			droughtMasterData.rs = droughtMasterData.stmt.executeQuery(query);
			while (droughtMasterData.rs.next()) {
				droughtForm = new DroughtForm();

				droughtForm.setScarcityCode(droughtMasterData.rs.getString(1));
				droughtForm.setScarcityName(droughtMasterData.rs.getString(2));

				scarcity.add(droughtForm);
			}
		} catch (Exception e) {
			System.out.println("The error in getScarcity" + e);
		} finally {
			droughtMasterData.closeAll();

		}
		return scarcity;
	}

	//// Added by srilaxmi on 25/02/2012 update
	public static int updateScarcity(DroughtBean droughtBean, DataSource dataSource) throws Exception {
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		int ans = 0;
		PreparedStatement pst = null;
		try {

			String query = "";
			query = "update  rws_drought_scar_reasons_tbl set SCARCITY_NAME =?  where scarcity_code=? ";

			droughtMasterData.conn = RwsOffices.getConn();
			pst = droughtMasterData.conn.prepareStatement(query);
			pst.setString(1,  droughtBean.getScarcityName().toUpperCase());
			pst.setString(2, droughtBean.getScarcityCode());
			ans = pst.executeUpdate();
		} 
		catch (Exception e) {
			System.out.println("The error in updateScarcity" + e);
		} finally {
			droughtMasterData.closeAll();

		}
		return ans;
	}

	////////////// Added by srilaxmi for get
	public static DroughtBean getScarcity1(String scarcityCode, DataSource dataSource) throws Exception {
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		DroughtBean droughtBean = null;
		String query = "";
		PreparedStatement pst = null;
		try {

			droughtMasterData.conn = RwsOffices.getConn();

			query = "select *  from rws_drought_scar_reasons_tbl where scarcity_code=? ";
			// Debug.println("**query"+query);
			pst = droughtMasterData.conn.prepareStatement(query);
			pst.setString(1, scarcityCode);
			droughtMasterData.rs = pst.executeQuery();
			if (droughtMasterData.rs.next()) {
				// System.out.println("ddd");
				droughtBean = new DroughtBean();

				droughtBean.setScarcityCode(droughtMasterData.rs.getString(1));
				// Debug.println("Enter
				// ScarcityName******"+droughtMasterData.rs.getString(2));
				droughtBean.setScarcityName(droughtMasterData.rs.getString(2));
				// Debug.println("Enter
				// SacrcityCode****"+droughtMasterData.rs.getString(1));
			}
		} catch (Exception e) {
			System.out.println("The error in getScarcity=" + e);
		} finally {
			droughtMasterData.closeAll();

		}
		return droughtBean;
	}

	//// Added on 25/02/2012 by srilaxmi
	public String HabName(String habcode) {

		DroughtMasterData droughtMasterData = new DroughtMasterData();
		String query = "";
		String name = "";

		try {
			droughtMasterData.conn = RwsOffices.getConn();
			query = "select panch_name  from rws_complete_hab_tbl where panch_code='" + habcode + "'";

			droughtMasterData.stmt1 = droughtMasterData.conn.createStatement();
			Debug.println("habname***********" + query);
			droughtMasterData.rs1 = droughtMasterData.stmt1.executeQuery(query);
			while (rs1.next()) {
				name = rs1.getString(1);

			}
		} catch (Exception e) {
		}
		return name;
	}

	//
	public static boolean habExists(String habcode) {
		boolean exists;
		exists = false;
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		DroughtForm droughtForm = null;
		String query = "";

		try {
			droughtMasterData.conn = RwsOffices.getConn();
			query = "select hab_code from rws_test_tbl where hab_code='" + habcode + "'";

			droughtMasterData.stmt1 = droughtMasterData.conn.createStatement();
			Debug.println("habcode***********" + query);
			droughtMasterData.rs1 = droughtMasterData.stmt1.executeQuery(query);
			if (droughtMasterData.rs1.next()) {
				exists = true;
			}
		} catch (Exception e) {
			exists = false;
		} finally {
			try {
				if (droughtMasterData.rs1 != null)
					droughtMasterData.rs1.close();
				if (droughtMasterData.stmt1 != null)
					droughtMasterData.stmt1.close();
				if (droughtMasterData.conn != null)
					droughtMasterData.conn.close();
			} catch (Exception e) {
			}
		}
		System.out.println("finally Exists:" + exists);
		return exists;
	}

	//
	public static String getHabName(String habcode) {

		DroughtMasterData droughtMasterData = new DroughtMasterData();
		DroughtForm droughtForm = null;
		String query = "";
		String habname = "";

		try {
			droughtMasterData.conn = RwsOffices.getConn();
			query = "select panch_name from rws_panchayat_raj_tbl where panch_code='" + habcode + "'";

			droughtMasterData.stmt1 = droughtMasterData.conn.createStatement();
			// Debug.println("habname***********" + query);
			droughtMasterData.rs1 = droughtMasterData.stmt1.executeQuery(query);
			while (droughtMasterData.rs1.next()) {
				habname = droughtMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (droughtMasterData.rs1 != null)
					droughtMasterData.rs1.close();
				if (droughtMasterData.stmt1 != null)
					droughtMasterData.stmt1.close();
				if (droughtMasterData.conn != null)
					droughtMasterData.conn.close();
			} catch (Exception e) {
			}
		}
		// System.out.println("finally ");
		return habname;
	}

	public static String getDistName(String dist) {
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		String query = "";
		String distname = "";
		PreparedStatement pst = null;
		try {
			droughtMasterData.conn = RwsOffices.getConn();
			query = "select dname from rws_district_tbl where dcode=? ";

			pst = droughtMasterData.conn.prepareStatement(query);
			pst.setString(1, dist);

			droughtMasterData.rs1 = pst.executeQuery();
			while (droughtMasterData.rs1.next()) {
				distname = droughtMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			System.out.println("exception in getDistName of drought " + e);
		} finally {
			try {
				if (droughtMasterData.rs1 != null)
					droughtMasterData.rs1.close();
				if (pst != null)
					pst.close();
				if (droughtMasterData.conn != null)
					droughtMasterData.conn.close();
			} catch (Exception e) {
			}
		}

		return distname;
	}

	//
	public static String getMandName(String dist, String mand) {

		DroughtMasterData droughtMasterData = new DroughtMasterData();
		DroughtForm droughtForm = null;
		String query = "";
		String mname = "";
		PreparedStatement pst = null;

		try {
			droughtMasterData.conn = RwsOffices.getConn();
			query = "select mname from rws_mandal_tbl where dcode=? and mcode=? ";

			pst = droughtMasterData.conn.prepareStatement(query);
			pst.setString(1, dist);
			pst.setString(2, mand);

			droughtMasterData.rs1 = pst.executeQuery();
			while (droughtMasterData.rs1.next()) {
				mname = droughtMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			System.out.println("excepion in getMandName of drought " + e);
		} finally {
			try {
				if (droughtMasterData.rs1 != null)
					droughtMasterData.rs1.close();
				if (pst != null)
					pst.close();
				if (droughtMasterData.conn != null)
					droughtMasterData.conn.close();
			} catch (Exception e) {
			}
		}
		// System.out.println("finally ");
		return mname;
	}

	public static String getPanchayatName(String dist, String mand, String panchayath) {
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		String query = "";
		String pname = "";
		PreparedStatement pst = null;
		try {

			droughtMasterData.conn = RwsOffices.getConn();
			query = "select pname from rws_panchayat_tbl where dcode=? and mcode=? and pcode=? ";

			pst = droughtMasterData.conn.prepareStatement(query);
			pst.setString(1, dist);
			pst.setString(2, mand);
			pst.setString(3, panchayath);

			droughtMasterData.rs1 = pst.executeQuery();
			while (droughtMasterData.rs1.next()) {
				pname = droughtMasterData.rs1.getString(1);
			}
		} catch (Exception e) {
			System.out.println("exception in  getPanchayatName of drought " + e);
		} finally {
			try {
				if (droughtMasterData.rs1 != null)
					droughtMasterData.rs1.close();
				if (pst != null)
					pst.close();
				if (droughtMasterData.conn != null)
					droughtMasterData.conn.close();
			} catch (Exception e) {
			}
		}

		return pname;
	}

	//

	public static int getPopulation(String habcode) {

		DroughtMasterData droughtMasterData = new DroughtMasterData();
		DroughtForm droughtForm = null;
		String query = "";
		int population = 0;

		try {
			droughtMasterData.conn = RwsOffices.getConn();
			query = "select  sum(CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU ) from rws_complete_hab_view where panch_code='"
					+ habcode + "'";

			droughtMasterData.stmt1 = droughtMasterData.conn.createStatement();
			Debug.println("population***********" + query);
			droughtMasterData.rs1 = droughtMasterData.stmt1.executeQuery(query);
			while (droughtMasterData.rs1.next()) {
				population = droughtMasterData.rs1.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (droughtMasterData.rs1 != null)
					droughtMasterData.rs1.close();
				if (droughtMasterData.stmt1 != null)
					droughtMasterData.stmt1.close();
				if (droughtMasterData.conn != null)
					droughtMasterData.conn.close();
			} catch (Exception e) {
			}
		}
		System.out.println("finally ");
		return population;
	}

	//
	public ArrayList getHabitationstransport(String district, String mandal, String panchayat, DataSource dataSource,
			String droughtYear) throws Exception {
		ArrayList habs;
		ArrayList result;
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		DroughtForm droughtForm = null;
		habs = new ArrayList();
		result = new ArrayList();
		boolean exists = false;
		String query = "";
		ArrayList c = new ArrayList();
		try {

			Date dt = new Date(System.currentTimeMillis());
			String currentDate = "";
			if (droughtYear == null) {
				currentDate = Integer.toString(dt.getYear() + 1900);
			} else {
				currentDate = droughtYear;
			}

			exists = false;
			droughtMasterData.conn = RwsOffices.getConn();
			//
			PreparedStatement stmt = null;

			String qq = "select HABCODE,SCARCITY_CODE,TRANSPORTATION,HIRING_OF_SOURCES,FLUSHING,DEEPENING,"
					+ "POWER_PROBLEM,to_char(to_date,'dd/mm/yyyy'),to_char(frm_date,'dd/mm/yyyy'),TRANSPORT_EST ,HIRING_EST ,"
					+ "FLUSHING_EST,DEEPENING_EST ,POWER_EST ,TYPE_OF_WORK ,WORK_EST_COST ,REMARKS,DEEP_OW_NUM,"
					+ "DEEP_OW_EST,SST_NUM,SST_EST,SST_SCHEME  from RWS_DROUGHT_HABITATION_TBL   where substr(habcode,1,2)=? "
					+ " and substr(habcode,6,2)=? and substr(habcode,13,2)=? and year=? ";

			stmt = droughtMasterData.conn.prepareStatement(qq);
			stmt.setString(1, district);
			stmt.setString(2, mandal);
			stmt.setString(3, panchayat);
			stmt.setString(4, currentDate);
			c.clear();

			droughtMasterData.rs1 = stmt.executeQuery();

			while (droughtMasterData.rs1.next()) {

				RWS_Drought rd = new RWS_Drought();

				String pname = rd.getPnamefromHab(droughtMasterData.rs1.getString(1));

				droughtForm = new DroughtForm();
				droughtForm.setThabitationCode(droughtMasterData.rs1.getString(1));

				droughtForm.setCauseOfScarcity(droughtMasterData.rs1.getString(2));
				droughtForm.setTransportation(droughtMasterData.rs1.getString(3));
				droughtForm.setHiringOfSources(droughtMasterData.rs1.getString(4));
				droughtForm.setFlushing(droughtMasterData.rs1.getString(5));
				droughtForm.setDeepening(droughtMasterData.rs1.getString(6));
				droughtForm.setPowerProblem(droughtMasterData.rs1.getString(7));

				droughtForm.setToDate(droughtMasterData.rs1.getString(8));
				droughtForm.setFrmDate(droughtMasterData.rs1.getString(9));

				droughtForm.setTransportationEST(droughtMasterData.rs1.getString(10));
				droughtForm.setHiringOfSourcesEST(droughtMasterData.rs1.getString(11));
				droughtForm.setFlushingEST(droughtMasterData.rs1.getString(12));
				droughtForm.setDeepeningEST(droughtMasterData.rs1.getString(13));
				droughtForm.setPowerProblemEST(droughtMasterData.rs1.getString(14));
				droughtForm.setTypeOfWork(droughtMasterData.rs1.getString(15));
				droughtForm.setWorkESTCOST(droughtMasterData.rs1.getString(16));
				droughtForm.setRemarks(droughtMasterData.rs1.getString(17));
				droughtForm.setDeepenOwNum(droughtMasterData.rs1.getString(18));
				droughtForm.setDeepenOwEst(droughtMasterData.rs1.getString(19));
				droughtForm.setSstNum(droughtMasterData.rs1.getString(20));
				droughtForm.setSstEst(droughtMasterData.rs1.getString(21));
				droughtForm.setSstScheme(droughtMasterData.rs1.getString(22));
				droughtForm.setChecks("on");
				droughtForm.setAlreadyExists("on");
				droughtForm.setThabName(pname);
				droughtForm.setSchemes(droughtMasterData.getSchemes(droughtMasterData.rs1.getString(1)));
				c.add(droughtForm);

			}

			// Debug.println("c size**********" + c.size());
			habs.clear();
			stmt.close();

			query = "select  panch_code,panch_name,dcode,mcode from  rws_complete_hab_view  where substr(panch_code,1,2)=?"
					+ " and substr(panch_code,6,2)=? and substr(panch_code,13,2)=? order by panch_code";
			stmt = droughtMasterData.conn.prepareStatement(query);
			stmt.setString(1, district);
			stmt.setString(2, mandal);
			stmt.setString(3, panchayat);

			droughtMasterData.rs = stmt.executeQuery();
			// Debug.println("Query***********for habitations" + query);

			int i = 0;
			boolean flag = false;
			while (droughtMasterData.rs.next()) {
				flag = false;
				for (i = 0; i < c.size(); i++) {
					droughtForm = (DroughtForm) c.get(i);
					if (droughtForm.getThabitationCode().equals(droughtMasterData.rs.getString(1))) {
						// System.out.println("CCC");
						flag = true;
						break;
					}
				}
				if (!flag) {
					droughtForm = new DroughtForm();
					droughtForm.setThabitationCode(droughtMasterData.rs.getString(1));
					droughtForm.setThabName(droughtMasterData.rs.getString(2));
					droughtForm.setDist(droughtMasterData.rs.getString(3));
					droughtForm.setMand(droughtMasterData.rs.getString(4));
					droughtForm.setChecks("off");
					droughtForm.setAlreadyExists("off");

					c.add(droughtForm);
				}
			}

		} catch (Exception e) {

			System.out.println("The error in getHabitationstransportdrought=" + e);
		} finally {
			droughtMasterData.closeAll();
			// System.out.println("ConnCount after closing is " + connCount);
		}
		return c;
	}

	///////////////////// Added for to display panchayat habitations on
	///////////////////// 12022015/////////////

	public ArrayList getHabitationstransport1(String district, String mandal, String panchayat, DataSource dataSource,
			String droughtYear) throws Exception {

		ArrayList habs;
		ArrayList result;
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		DroughtForm droughtForm = null;
		habs = new ArrayList();
		result = new ArrayList();
		boolean exists = false;
		String query = "";
		ArrayList c = new ArrayList();
		PreparedStatement pst = null, pst1 = null;
		try {

			Date dt = new Date(System.currentTimeMillis());
			String currentDate = "";
			if (droughtYear == null) {
				currentDate = Integer.toString(dt.getYear() + 1900);
			} else {
				currentDate = droughtYear;
			}

			exists = false;
			conn = RwsOffices.getConn();
			//

			String qq = "select HABCODE,SCARCITY_CODE,TRANSPORTATION,HIRING_OF_SOURCES,FLUSHING,DEEPENING,"
					+ "POWER_PROBLEM,to_char(to_date,'dd/mm/yyyy'),to_char(frm_date,'dd/mm/yyyy'),TRANSPORT_EST ,HIRING_EST ,"
					+ "FLUSHING_EST,DEEPENING_EST ,POWER_EST ,TYPE_OF_WORK ,WORK_EST_COST ,REMARKS,DEEP_OW_NUM,"
					+ "DEEP_OW_EST,SST_NUM,SST_EST,SST_SCHEME";
			if (panchayat.equals(null) || panchayat.equals("")) {
				qq = qq + ",substr(habcode,13,2)";
			}
			qq = qq + "  from RWS_DROUGHT_HABITATION_TBL   where substr(habcode,1,2)='" + district
					+ "' and substr(habcode,6,2)='" + mandal + "'";
			if (!panchayat.equals(null) && !panchayat.equals("")) {
				qq = qq + " and substr(habcode,13,2)='" + panchayat + "' ";
			}
			qq = qq + " and year='" + currentDate + "'";
			// Debug.println("qq:anuuu" + qq);

			c.clear();

			pst = conn.prepareStatement(qq);
			droughtMasterData.rs1 = pst.executeQuery();
			while (droughtMasterData.rs1.next()) {
				RWS_Drought rd = new RWS_Drought();

				String pname = rd.getPnamefromHab(droughtMasterData.rs1.getString(1));

				droughtForm = new DroughtForm();
				droughtForm.setThabitationCode(droughtMasterData.rs1.getString(1));

				droughtForm.setCauseOfScarcity(droughtMasterData.rs1.getString(2));
				droughtForm.setTransportation(droughtMasterData.rs1.getString(3));
				droughtForm.setHiringOfSources(droughtMasterData.rs1.getString(4));
				droughtForm.setFlushing(droughtMasterData.rs1.getString(5));
				droughtForm.setDeepening(droughtMasterData.rs1.getString(6));
				droughtForm.setPowerProblem(droughtMasterData.rs1.getString(7));

				droughtForm.setToDate(droughtMasterData.rs1.getString(8));
				droughtForm.setFrmDate(droughtMasterData.rs1.getString(9));

				droughtForm.setTransportationEST(droughtMasterData.rs1.getString(10));
				droughtForm.setHiringOfSourcesEST(droughtMasterData.rs1.getString(11));
				droughtForm.setFlushingEST(droughtMasterData.rs1.getString(12));
				droughtForm.setDeepeningEST(droughtMasterData.rs1.getString(13));
				droughtForm.setPowerProblemEST(droughtMasterData.rs1.getString(14));
				droughtForm.setTypeOfWork(droughtMasterData.rs1.getString(15));
				droughtForm.setWorkESTCOST(droughtMasterData.rs1.getString(16));
				droughtForm.setRemarks(droughtMasterData.rs1.getString(17));
				droughtForm.setDeepenOwNum(droughtMasterData.rs1.getString(18));
				droughtForm.setDeepenOwEst(droughtMasterData.rs1.getString(19));
				droughtForm.setSstNum(droughtMasterData.rs1.getString(20));
				droughtForm.setSstEst(droughtMasterData.rs1.getString(21));
				droughtForm.setSstScheme(droughtMasterData.rs1.getString(22));
				droughtForm.setChecks("on");
				droughtForm.setAlreadyExists("on");
				droughtForm.setThabName(pname);
				droughtForm.setSchemes(droughtMasterData.getSchemes(droughtMasterData.rs1.getString(1)));
				if (panchayat.equals(null) || panchayat.equals("")) {
					// System.out.println("panchayath name
					// yyyyyyyyyy"+rs1.getString("substr(habcode,13,2)"));
					droughtForm.setPanchayatName(droughtMasterData.getPanchayatName(district, mandal,
							droughtMasterData.rs1.getString("substr(habcode,13,2)")));
				}
				c.add(droughtForm);

			}

			// Debug.println("c size**********" + c.size());
			habs.clear();
			query = "select  panch_code,panch_name,dcode,mcode";
			if (panchayat.equals(null) || panchayat.equals("")) {
				query = query + ",substr(panch_code,13,2)";
			}
			query = query + " from  rws_complete_hab_view  where substr(panch_code,1,2)='" + district
					+ "' and substr(panch_code,6,2)='" + mandal + "'";
			if (!panchayat.equals(null) && !panchayat.equals("")) {
				query = query + " and substr(panch_code,13,2)='" + panchayat + "' ";
			}
			query = query + "order by panch_code ";
			pst1 = conn.prepareStatement(query);
			droughtMasterData.rs = pst1.executeQuery();
			// Debug.println("Query***********for habitations in view anuu123" + query);
			int i = 0;
			boolean flag = false;
			while (droughtMasterData.rs.next()) {
				flag = false;
				for (i = 0; i < c.size(); i++) {
					droughtForm = (DroughtForm) c.get(i);
					if (droughtForm.getThabitationCode().equals(droughtMasterData.rs.getString(1))) {
						// System.out.println("CCC");
						flag = true;
						break;
					}
				}
				if (!flag) {
					droughtForm = new DroughtForm();
					droughtForm.setThabitationCode(droughtMasterData.rs.getString(1));
					droughtForm.setThabName(droughtMasterData.rs.getString(2));
					droughtForm.setDist(droughtMasterData.rs.getString(3));
					droughtForm.setMand(droughtMasterData.rs.getString(4));
					droughtForm.setChecks("off");
					droughtForm.setAlreadyExists("off");
					if (panchayat.equals(null) || panchayat.equals("")) {
						// System.out.println("panchayath name
						// yyyyyyyyyy"+rs1.getString("substr(habcode,13,2)"));
						droughtForm.setPanchayatName(droughtMasterData.getPanchayatName(district, mandal,
								droughtMasterData.rs.getString(5)));
					}

					c.add(droughtForm);
				}
			}

		} catch (Exception e) {

			System.out.println("The error in getHabitationstransportdrought= " + e);
		} finally {
			droughtMasterData.closeAll();
			// Debug.println("ConnCount after closing is " + connCount);
		}
		return c;

	}

	/////////////////////////////
	/**
	 * @param string
	 * @return
	 */
	private ArrayList getSchemes(String habcode) {

		ArrayList schemes = new ArrayList();
		LabelValueBean labelValueBean = new LabelValueBean();
		labelValueBean.setValue("1");
		labelValueBean.setLabel("ssss");
		schemes.add(labelValueBean);

		return schemes;
	}

	//
	public ArrayList getHabitationsdetails(String district, DataSource dataSource) throws Exception {
		ArrayList habd;
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		DroughtForm droughtForm = null;
		habd = new ArrayList();
		boolean exists = false;
		String query = "";
		ArrayList c = new ArrayList();
		try {
			Debug.println("ConnCount is " + connCount);
			exists = false;
			droughtMasterData.conn = RwsOffices.getConn();
			droughtMasterData.stmt = droughtMasterData.conn.createStatement();
			query = "select  b.habcode,a.panch_name,b.frm_date,b.to_date from  rws_panchayat_raj_tbl a,RWS_DROUGHT_HABITATION_TMP_TBL b  where substr(habcode,1,2)='"
					+ district + "' and a.panch_code=b.habcode   order by b.habcode";
			droughtMasterData.rs = droughtMasterData.stmt.executeQuery(query);
			Debug.println("Query***********for habitations in temporary  table " + query);
			while (droughtMasterData.rs.next()) {
				droughtForm = new DroughtForm();

				droughtForm.setThabitationCode(droughtMasterData.rs.getString(1));
				droughtForm.setThabName(droughtMasterData.rs.getString(2));
				System.out.println("FromDate:" + droughtMasterData.rs.getString(3));
				droughtForm.setFrmDate(droughtMasterData.rs.getString(3));
				System.out.println("FromDate:" + droughtMasterData.rs.getString(4));
				droughtForm.setToDate(droughtMasterData.rs.getString(4));

				habd.add(droughtForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getHabitationstransportdrought=" + e);
		} finally {
			droughtMasterData.closeAll();
			Debug.println("ConnCount after closing is " + connCount);
		}
		return habd;
	}

	public ArrayList getHabitationsdetails1(String district, String mandal, String panchayat, DataSource dataSource)
			throws Exception {
		ArrayList habd;
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		DroughtForm droughtForm = null;
		habd = new ArrayList();
		boolean exists = false;
		String query = "";
		ArrayList c = new ArrayList();
		try {
			Debug.println("ConnCount is " + connCount);
			exists = false;
			droughtMasterData.conn = RwsOffices.getConn();
			droughtMasterData.stmt = droughtMasterData.conn.createStatement();
			query = "select  b.habcode,a.panch_name,b.frm_date,b.to_date from  rws_panchayat_raj_tbl a,RWS_DROUGHT_HABITATION_TMP_TBL b  where substr(habcode,1,2)='"
					+ district + "' and substr(habcode,6,2)='" + mandal + "' and substr(habcode,13,2)='" + panchayat
					+ "' and a.panch_code=b.habcode   order by b.habcode";
			droughtMasterData.rs = droughtMasterData.stmt.executeQuery(query);
			Debug.println("Query***********for habitations in view anu " + query);
			while (droughtMasterData.rs.next()) {
				droughtForm = new DroughtForm();

				droughtForm.setThabitationCode(droughtMasterData.rs.getString(1));
				droughtForm.setThabName(droughtMasterData.rs.getString(2));
				System.out.println("FromDate:" + droughtMasterData.rs.getString(3));
				droughtForm.setFrmDate(droughtMasterData.rs.getString(3));
				System.out.println("FromDate:" + droughtMasterData.rs.getString(4));
				droughtForm.setToDate(droughtMasterData.rs.getString(4));

				habd.add(droughtForm);
			}

		} catch (Exception e) {
			Debug.println("The error in getHabitationstransportdrought=" + e);
		} finally {
			droughtMasterData.closeAll();
			Debug.println("ConnCount after closing is " + connCount);
		}
		return habd;
	}

	//

	public int[] saveHabitations(ArrayList resultData, String dist, String mand, String panchayath, String droughtYear)
			throws Exception {
		// System.out.println("drought master data in save habitations");
		int count[] = {};
		String allhabs[] = new String[1000];

		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);

			Statement pstmt = conn.createStatement();
			ResultSet rs1 = null;

			PreparedStatement stmt = null;

			Date dt = new Date(System.currentTimeMillis());
			String currentDate = Integer.toString(dt.getYear() + 1900);

			String aa = "select panch_code from rws_complete_hab_view where substr(panch_code,1,2)=? and substr(panch_code,6,2)=? "
					+ " and substr(panch_code,13,2)=? ";

			stmt = conn.prepareStatement(aa);
			stmt.setString(1, dist);
			stmt.setString(2, mand);
			stmt.setString(3, panchayath);

			rs1 = stmt.executeQuery();
			int i = 0;

			while (rs1.next()) {
				allhabs[i] = rs1.getString(1);
				i += 1;

			}
			rs1.close();
			for (i = 0; i < allhabs.length; i++) {

				pstmt.addBatch("delete from RWS_DROUGHT_HABITATION_TBL  where habcode='" + allhabs[i] + "' and year='"
						+ droughtYear + "'");
			}
			count = pstmt.executeBatch();
			// System.out.println("resultData.size" + resultData.size());
			for (i = 0; i < resultData.size(); i++) {

				DroughtHabitationRecords dr = (DroughtHabitationRecords) resultData.get(i);

				// System.out.println("Habcode:" + dr.getHabCode());

				String query = "insert into RWS_DROUGHT_HABITATION_TBL (habcode,YEAR,SCARCITY_CODE,TRANSPORTATION,HIRING_OF_SOURCES,FLUSHING,DEEPENING,POWER_PROBLEM,TO_DATE,FRM_DATE,TRANSPORT_EST,HIRING_EST,FLUSHING_EST,DEEPENING_EST,POWER_EST,TYPE_OF_WORK,WORK_EST_COST,REMARKS,DEEP_OW_NUM,DEEP_OW_EST,SST_NUM,SST_EST,SST_SCHEME ) values ('"
						+ dr.getHabCode() + "','" + droughtYear + "','" + dr.getCauseOFScarcity() + "','"
						+ dr.getTransportation() + "','" + dr.getHiringOfSources() + "','" + dr.getFlushing() + "','"
						+ dr.getDeepening() + "','" + dr.getPowerProblem() + "'," + "to_date('" + dr.getToDate() + "',"
						+ "'dd/mm/yyyy')," + "to_date('" + dr.getFrmDate() + "'," + "'dd/mm/yyyy'),'"
						+ dr.getTransportationEST() + "','" + dr.getHiringOfSourcesEST() + "','" + dr.getFlushingEST()
						+ "','" + dr.getDeepeningEST() + "','" + dr.getPowerProblemEST() + "','" + dr.getTypeOfWork()
						+ "','" + dr.getWorkESTCOST() + "','" + dr.getRemarks() + "','" + dr.getDeepenOwNum() + "','"
						+ dr.getDeepenOwEst() + "','" + dr.getSstNum() + "','" + dr.getSstEst() + "','"
						+ dr.getSstScheme() + "')";

				// System.out.println("Insert Query:" + query);
				pstmt.addBatch(query);

			}
			count = pstmt.executeBatch();
			if (count.length > 0) {
				conn.setAutoCommit(true);
				conn.commit();
			} else
				conn.rollback();
		} catch (Exception e) {
			System.out.println("exception in saveHabitations of droughtmasterdata --" + e);
		}
		return count;

	}

	/**
	 * @param habs
	 * @return
	 */
	public ArrayList getCategories() {

		ArrayList result = new ArrayList();

		try {

			conn = RwsOffices.getConn();

			ResultSet rs1 = null;

			PreparedStatement pst = null;
			String aa = "select * from RWS_DROUGHT_SCAR_REASONS_TBL ";
			pst = conn.prepareStatement(aa);
			rs1 = pst.executeQuery();

			while (rs1.next()) {
				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs1.getString(1));
				labelValueBean.setLabel(rs1.getString(2));
				result.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("exception in droughtmasterdata getcategories-- " + e);
			// e.printStackTrace();
		}

		return result;

	}

	public ArrayList getDroughtDistricts(DataSource dataSource) throws Exception {
		ArrayList districts;
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		LabelValueBean droughtForm = null;
		districts = new ArrayList();
		String query = "";
		try {

			droughtMasterData.conn = RwsOffices.getConn();
			droughtMasterData.stmt = droughtMasterData.conn.createStatement();
			query = "select distinct d.dcode,d.dname from rws_district_tbl d,rws_drought_habitation_tbl c where (flushing>0 or deepening>0) and "
					+ "d.dcode=substr(c.habcode,1,2) order by d.dname";
			droughtMasterData.rs = droughtMasterData.stmt.executeQuery(query);
			// Debug.println("Query" + query);
			while (droughtMasterData.rs.next()) {
				droughtForm = new LabelValueBean();
				droughtForm.setValue(droughtMasterData.rs.getString(1));
				droughtForm.setLabel(droughtMasterData.rs.getString(2));
				droughtForm
						.setLabelValue(droughtMasterData.rs.getString(2) + " - " + droughtMasterData.rs.getString(1));
				districts.add(droughtForm);
			}

		} catch (Exception e) {
			System.out.println("The error in getDroughtdistricts = " + e);
		} finally {
			droughtMasterData.closeAll();

		}
		return districts;
	}

	//
	public ArrayList getDroughtMandals(String dcode, DataSource dataSource) throws Exception {
		ArrayList mandals;
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		LabelValueBean droughtForm = null;
		mandals = new ArrayList();
		String query = "";
		PreparedStatement pst = null;
		try {

			droughtMasterData.conn = RwsOffices.getConn();

			query = "select distinct d.dcode,d.mcode,d.mname from rws_mandal_tbl d,rws_drought_habitation_tbl c where (flushing>0 or deepening>0) "
					+ "and  d.dcode=? and d.mcode=substr(c.habcode,6,2) and d.dcode=substr(c.habcode,1,2) order by d.mname";

			pst = droughtMasterData.conn.prepareStatement(query);
			pst.setString(1, dcode);

			droughtMasterData.rs = pst.executeQuery();

			// Debug.println("MandalQuery********" + query);
			while (droughtMasterData.rs.next()) {
				droughtForm = new LabelValueBean();
				droughtForm.setValue(droughtMasterData.rs.getString(2));
				droughtForm.setLabel(droughtMasterData.rs.getString(3));
				droughtForm
						.setLabelValue(droughtMasterData.rs.getString(3) + " - " + droughtMasterData.rs.getString(2));
				mandals.add(droughtForm);
			}

		} catch (Exception e) {
			System.out.println("The error in getDroughtMandals= " + e);
		} finally {
			droughtMasterData.closeAll();

		}
		return mandals;
	}

	//
	public ArrayList getDroughtPanchayats(String dcode, String mcode, DataSource dataSource) throws Exception {
		ArrayList panchayats;
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		LabelValueBean droughtForm = null;
		panchayats = new ArrayList();
		String query = "";
		PreparedStatement pst = null;
		try {

			droughtMasterData.conn = RwsOffices.getConn();
			droughtMasterData.stmt = droughtMasterData.conn.createStatement();
			query = "select distinct d.dcode,d.mcode,d.pcode,d.pname from rws_panchayat_tbl d,rws_drought_habitation_tbl c where (flushing>0 or deepening>0) "
					+ "and   d.dcode=? and d.mcode=? and substr(c.habcode,13,2)=d.pcode and substr(c.habcode,1,2)=d.dcode and "
					+ "substr(c.habcode,6,2)=d.mcode order by d.pname";

			pst = droughtMasterData.conn.prepareStatement(query);
			pst.setString(1, dcode);
			pst.setString(2, mcode);

			droughtMasterData.rs = pst.executeQuery();

			//
			while (droughtMasterData.rs.next()) {
				droughtForm = new LabelValueBean();
				droughtForm.setValue(droughtMasterData.rs.getString(3));
				droughtForm.setLabel(droughtMasterData.rs.getString(4));
				droughtForm
						.setLabelValue(droughtMasterData.rs.getString(4) + " - " + droughtMasterData.rs.getString(3));
				panchayats.add(droughtForm);
			}

		} catch (Exception e) {
			System.out.println("The error in getDroughtPanchayats=" + e);
		} finally {
			droughtMasterData.closeAll();

		}
		return panchayats;
	}

	//
	public ArrayList getDroughtVillages(String dcode, String mcode, String pcode, DataSource dataSource)
			throws Exception {
		ArrayList villages;
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		LabelValueBean droughtForm = null;
		villages = new ArrayList();
		String query = "";
		PreparedStatement pst = null;
		try {

			droughtMasterData.conn = RwsOffices.getConn();
			query = "select distinct d.dcode,d.mcode,d.pcode,d.vcode,d.vname from rws_village_tbl d,rws_drought_habitation_tbl c where "
					+ " (flushing>0 or deepening>0) and  d.dcode=? and d.mcode=? and d.pcode=? and substr(c.habcode,8,3)=d.vcode and "
					+ "substr(c.habcode,1,2)=d.dcode and substr(c.habcode,6,2)=d.mcode and substr(c.habcode,13,2)=d.pcode"
					+ " order by d.vname";

			pst = droughtMasterData.conn.prepareStatement(query);
			pst.setString(1, dcode);
			pst.setString(2, mcode);
			pst.setString(3, pcode);
			droughtMasterData.rs = pst.executeQuery();

			while (droughtMasterData.rs.next()) {
				droughtForm = new LabelValueBean();
				droughtForm.setValue(droughtMasterData.rs.getString(4));
				droughtForm.setLabel(droughtMasterData.rs.getString(5));
				droughtForm
						.setLabelValue(droughtMasterData.rs.getString(5) + " - " + droughtMasterData.rs.getString(4));
				villages.add(droughtForm);
			}

		} catch (Exception e) {
			System.out.println("The error in getDroughtVillages= " + e);
		} finally {
			droughtMasterData.closeAll();

		}
		return villages;
	}

	//
	public ArrayList getDroughtHabitations(String dcode, String mcode, String pcode, String vcode,
			DataSource dataSource) throws Exception {
		ArrayList habs;
		habs = new ArrayList();
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		LabelValueBean droughtForm = null;
		String query = "";
		PreparedStatement pst = null;
		try {

			droughtMasterData.conn = RwsOffices.getConn();
			droughtMasterData.stmt = droughtMasterData.conn.createStatement();
			// query = " SELECT distinct
			// H.HAB_CODE,P.PANCH_CODE,P.PANCH_NAME,H.COVERAGE_STATUS FROM
			// RWS_PANCHAYAT_RAJ_TBL P, RWS_HABITATION_DIRECTORY_TBL
			// H,rws_complaints_register_tbl c WHERE SUBSTR(P.PANCH_CODE,1,2)='"
			// + dcode + "' AND SUBSTR(P.PANCH_CODE,6,2)='" + mcode + "' AND
			// SUBSTR(P.PANCH_CODE,13,2)='" + pcode + "' AND " + "
			// H.HAB_CODE=P.PANCH_CODE AND H.COVERAGE_STATUS <> 'UI' and
			// substr(c.component_code,1,16)=p.panch_code and
			// substr(c.component_code,8,3)='" + vcode + "' and
			// substr(c.component_code,1,16)=h.hab_code ORDER BY P.PANCH_NAME";
			query = " SELECT distinct  P.PANCH_CODE,P.PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL P, "
					+ "RWS_HABITATION_DIRECTORY_TBL H,rws_drought_habitation_tbl c WHERE (flushing > 0 or deepening > 0) and  "
					+ "SUBSTR(P.PANCH_CODE,1,2)=? AND SUBSTR(P.PANCH_CODE,6,2)=? AND SUBSTR(P.PANCH_CODE,13,2)=? AND "
					+ " H.HAB_CODE=P.PANCH_CODE AND H.COVERAGE_STATUS <> 'UI' and c.habcode=p.panch_code and "
					+ "substr(c.habcode,8,3)=? and c.habcode=h.hab_code  ORDER BY P.PANCH_NAME";

			pst = droughtMasterData.conn.prepareStatement(query);
			pst.setString(1, dcode);
			pst.setString(2, mcode);
			pst.setString(3, pcode);
			pst.setString(4, vcode);
			droughtMasterData.rs = pst.executeQuery();

			while (droughtMasterData.rs.next()) {
				droughtForm = new LabelValueBean();
				droughtForm.setValue(droughtMasterData.rs.getString(1));
				droughtForm.setLabel(droughtMasterData.rs.getString(2));
				droughtForm
						.setLabelValue(droughtMasterData.rs.getString(2) + " - " + droughtMasterData.rs.getString(1));
				habs.add(droughtForm);
			}

		} catch (Exception e) {
			System.out.println("The error in getDroughtHabitations= " + e);
		} finally {
			droughtMasterData.closeAll();

		}
		return habs;
	}

	//
	public static int getFlush(String habcode) {

		DroughtMasterData droughtMasterData = new DroughtMasterData();
		DroughtForm droughtForm = null;
		String query = "";
		int flush = 0;

		try {
			droughtMasterData.conn = RwsOffices.getConn();
			query = "select flushing from rws_drought_habitation_tbl where habcode='" + habcode + "'";

			droughtMasterData.stmt1 = droughtMasterData.conn.createStatement();
			Debug.println("habname***********" + query);
			droughtMasterData.rs1 = droughtMasterData.stmt1.executeQuery(query);
			while (droughtMasterData.rs1.next()) {
				flush = droughtMasterData.rs1.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (droughtMasterData.rs1 != null)
					droughtMasterData.rs1.close();
				if (droughtMasterData.stmt1 != null)
					droughtMasterData.stmt1.close();
				if (droughtMasterData.conn != null)
					droughtMasterData.conn.close();
			} catch (Exception e) {
			}
		}
		return flush;
	}

	//
	public static int getDeep(String habcode) {

		DroughtMasterData droughtMasterData = new DroughtMasterData();
		DroughtForm droughtForm = null;
		String query = "";
		int deep = 0;

		try {
			droughtMasterData.conn = RwsOffices.getConn();
			query = "select deepening from rws_drought_habitation_tbl where habcode='" + habcode + "'";

			droughtMasterData.stmt1 = droughtMasterData.conn.createStatement();
			Debug.println("habname***********" + query);
			droughtMasterData.rs1 = droughtMasterData.stmt1.executeQuery(query);
			while (droughtMasterData.rs1.next()) {
				deep = droughtMasterData.rs1.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (droughtMasterData.rs1 != null)
					droughtMasterData.rs1.close();
				if (droughtMasterData.stmt1 != null)
					droughtMasterData.stmt1.close();
				if (droughtMasterData.conn != null)
					droughtMasterData.conn.close();
			} catch (Exception e) {
			}
		}
		return deep;
	}

	public ArrayList getSSTankDroughtDistricts(DataSource dataSource) throws Exception {

		ArrayList districts;
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		LabelValueBean droughtForm = null;
		districts = new ArrayList();
		String query = "";
		try {

			conn = RwsOffices.getConn();

			stmt = conn.createStatement();

			query = "select distinct a.dcode,a.dname from rws_district_tbl a,RWS_AST_SS_SC_PARAM_TBL b,rws_asset_mast_tbl c  where"
					+ " a.dcode=substr(b.hab_code,1,2) and a.dcode=substr(c.hab_code,1,2)order by a.dname";

			rs = stmt.executeQuery(query);

			while (rs.next()) {
				droughtForm = new LabelValueBean();
				droughtForm.setValue(rs.getString(1));
				droughtForm.setLabel(rs.getString(2));
				droughtForm.setLabelValue(rs.getString(2) + " - " + rs.getString(1));
				districts.add(droughtForm);
			}

		} catch (Exception e) {
			System.out.println("The error in getDroughtdistricts=" + e);
		} finally {
			rs.close();
			stmt.close();
			conn.close();

		}
		return districts;
	}

	public ArrayList getSSTankDroughtMandals(String dcode, DataSource dataSource) throws Exception {
		ArrayList mandals;
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		LabelValueBean droughtForm = null;
		mandals = new ArrayList();
		String query = "";
		PreparedStatement pst = null;
		try {

			conn = RwsOffices.getConn();

			query = "select distinct a.dcode,a.mcode,a.mname from rws_mandal_tbl a,RWS_AST_SS_SC_PARAM_TBL b ,rws_asset_mast_tbl c where"
					+ "  a.dcode=? and a.mcode=substr(b.hab_code,6,2) and a.dcode=substr(b.hab_code,1,2) and a.mcode=substr(c.hab_code,6,2) and "
					+ "a.dcode=substr(c.hab_code,1,2) order by a.mname";

			pst = conn.prepareStatement(query);
			pst.setString(1, dcode);
			rs = pst.executeQuery();

			while (rs.next()) {
				droughtForm = new LabelValueBean();
				droughtForm.setValue(rs.getString(2));
				droughtForm.setLabel(rs.getString(3));
				droughtForm.setLabelValue(rs.getString(3) + " - " + rs.getString(2));
				mandals.add(droughtForm);
			}

		} catch (Exception e) {
			System.out.println("The error in getCompMandals=" + e);
		} finally {
			rs.close();
			pst.close();
			conn.close();
		}
		return mandals;
	}

	public ArrayList getSSTankDroughtPanchayats(String dcode, String mcode, DataSource dataSource) throws Exception {
		ArrayList panchayats;
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		LabelValueBean droughtForm = null;
		panchayats = new ArrayList();
		String query = "";
		PreparedStatement pst = null;
		try {

			conn = RwsOffices.getConn();

			query = "select distinct d.dcode,d.mcode,d.pcode,d.pname from rws_panchayat_tbl d,rws_ast_ss_sc_param_tbl s,rws_asset_mast_tbl c where"
					+ " d.dcode=? and d.mcode=? and substr(s.hab_code,13,2)=d.pcode and substr(s.hab_code,1,2)=d.dcode and "
					+ "substr(s.hab_code,6,2)=d.mcode and substr(c.hab_code,13,2)=d.pcode and substr(c.hab_code,1,2)=d.dcode and"
					+ " substr(c.hab_code,6,2)=d.mcode order by d.pname";

			pst = conn.prepareStatement(query);
			pst.setString(1, dcode);
			pst.setString(2, mcode);
			rs = pst.executeQuery();

			while (rs.next()) {
				droughtForm = new LabelValueBean();
				droughtForm.setValue(rs.getString(3));
				droughtForm.setLabel(rs.getString(4));
				droughtForm.setLabelValue(rs.getString(4) + " - " + rs.getString(3));
				panchayats.add(droughtForm);
			}

		} catch (Exception e) {
			System.out.println("The error in getDroughtPanchayats=" + e);
		} finally {

			rs.close();
			pst.close();
			conn.close();

		}
		return panchayats;
	}

	public ArrayList getSSTankDroughtVillages(String dcode, String mcode, String pcode, DataSource dataSource)
			throws Exception {

		ArrayList villages;
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		LabelValueBean droughtForm = null;
		villages = new ArrayList();
		String query = "";
		PreparedStatement pst = null;

		try {

			conn = RwsOffices.getConn();

			query = "select distinct d.dcode,d.mcode,d.pcode,d.vcode,d.vname from rws_village_tbl d,RWS_AST_SS_SC_PARAM_TBL c,"
					+ "rws_asset_mast_tbl a where  d.dcode=? and d.mcode=? and d.pcode=? and substr(c.hab_code,8,3)=d.vcode and "
					+ "substr(c.hab_code,1,2)=d.dcode and substr(c.hab_code,6,2)=d.mcode and substr(c.hab_code,13,2)=d.pcode and "
					+ "substr(a.hab_code,8,3)=d.vcode and substr(a.hab_code,1,2)=d.dcode and substr(a.hab_code,6,2)=d.mcode and "
					+ "substr(a.hab_code,13,2)=d.pcode order by d.vname";

			pst = conn.prepareStatement(query);
			pst.setString(1, dcode);
			pst.setString(2, mcode);
			pst.setString(3, pcode);
			rs = pst.executeQuery();

			while (rs.next()) {
				droughtForm = new LabelValueBean();
				droughtForm.setValue(rs.getString(4));
				droughtForm.setLabel(rs.getString(5));
				droughtForm.setLabelValue(rs.getString(5) + " - " + rs.getString(4));
				villages.add(droughtForm);
			}

		} catch (Exception e) {
			System.out.println("The error in getSSTankDroughtVillages=" + e);
		} finally {

			rs.close();
			pst.close();
			conn.close();
		}
		return villages;
	}

	public ArrayList getSSTankDroughtHabitations(String dcode, String mcode, String pcode, String vcode,
			DataSource dataSource) throws Exception {

		ArrayList habs;
		habs = new ArrayList();
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		LabelValueBean droughtForm = null;
		String query = "";
		PreparedStatement pst = null;

		try {

			conn = RwsOffices.getConn();

			query = " SELECT distinct  P.PANCH_CODE,P.PANCH_NAME FROM RWS_PANCHAYAT_RAJ_TBL P, "
					+ "RWS_HABITATION_DIRECTORY_TBL H,rws_asset_mast_tbl c ,RWS_AST_SS_SC_PARAM_TBL  s,"
					+ "RWS_ASSET_HAB_TBL L  WHERE SUBSTR(P.PANCH_CODE,1,2)=? AND SUBSTR(P.PANCH_CODE,6,2)=?"
					+ " AND SUBSTR(P.PANCH_CODE,13,2)=? AND "
					+ " H.HAB_CODE=P.PANCH_CODE AND H.COVERAGE_STATUS <> 'UI'  "
					+ "and  substr(c.hab_code,8,3)=? and l.hab_code=s.hab_code and c.asset_code=s.asset_code and"
					+ " P.PANCH_CODE in(select substr(sssc_code,1,16) from RWS_AST_SS_SC_PARAM_TBL) ORDER BY P.PANCH_NAME";

			pst = conn.prepareStatement(query);
			pst.setString(1, dcode);
			pst.setString(2, mcode);
			pst.setString(3, pcode);
			pst.setString(4, vcode);
			rs = pst.executeQuery();

			while (rs.next()) {
				droughtForm = new LabelValueBean();
				droughtForm.setValue(rs.getString(1));
				droughtForm.setLabel(rs.getString(2));
				droughtForm.setLabelValue(rs.getString(2) + " - " + rs.getString(1));
				habs.add(droughtForm);
			}

		} catch (Exception e) {
			System.out.println("The error in getSSTankHabitations=" + e);
		} finally {
			rs.close();
			pst.close();
			conn.close();
		}
		return habs;
	}

	public ArrayList getDroughtSSTanks(String habcode, DataSource dataSource) throws Exception {
		ArrayList habs;
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		habs = new ArrayList();
		boolean exists = false;
		DroughtForm droughtBean = null;
		String query = "";
		ArrayList c = new ArrayList();
		PreparedStatement pst = null, pst1 = null;

		try {
			exists = false;
			conn = RwsOffices.getConn();
			String qq = "select distinct a.asset_code,sssc_code,a.hab_code,panch_name,popu_served,asset_name,count(c.hab_code),river_name,"
					+ "canal_name,tank_capacity,no_of_days_serve,present_status,to_char(fill_date,'dd/mm/yyyy'),to_char(prob_canal_clos_dt,'dd/mm/yyyy') ,"
					+ "to_char(prob_canal_reopen_dt,'dd/mm/yyyy'),steps_taken,steps_taken_reason,identified_alternative,identified_alternative_reason,"
					+ "a.remarks,to_char(drought_date,'dd/mm/yyyy') from rws_drought_sstank_tbl a,rws_panchayat_raj_tbl b ,rws_asset_mast_tbl c ,"
					+ "rws_asset_hab_tbl d where a.hab_code=d.hab_code and a.asset_code=c.asset_code and "
					+ " a.hab_code=b.panch_code and  c.asset_code=d.asset_code and a.hab_code=?  group by a.asset_code,sssc_code,a.hab_code,"
					+ "panch_name,popu_served,asset_name,river_name,canal_name,tank_capacity,no_of_days_serve,present_status,"
					+ "to_char(fill_date,'dd/mm/yyyy'),to_char(prob_canal_clos_dt,'dd/mm/yyyy') ,to_char(prob_canal_reopen_dt,'dd/mm/yyyy'),"
					+ "steps_taken,steps_taken_reason,identified_alternative,identified_alternative_reason,a.remarks,to_char(drought_date,'dd/mm/yyyy')";

			pst = conn.prepareStatement(qq);
			pst.setString(1, habcode);
			rs = pst.executeQuery();

			while (rs.next()) {
				droughtBean = new DroughtForm();
				droughtBean.setAssetCode(rs.getString(1));
				droughtBean.setSsscCode(rs.getString(2));
				droughtBean.setShabCode(rs.getString(3));
				droughtBean.setShabName(rs.getString(4));
				droughtBean.setSpopServed(rs.getString(5));
				droughtBean.setSschemeName(rs.getString(6));
				droughtBean.setHabCount(rs.getString(7));
				droughtBean.setSriverVaguName(rs.getString(8));
				droughtBean.setScanalName(rs.getString(9));
				droughtBean.setStankCapacity(rs.getString(10));
				droughtBean.setSwaterSupplyDays(rs.getString(11));
				droughtBean.setSfillingStatus(rs.getString(12));
				droughtBean.setSfillDate(rs.getString(13));
				droughtBean.setScanalPrbDate(rs.getString(14));
				droughtBean.setSreopenPrbData(rs.getString(15));
				droughtBean.setSstepsTaken(rs.getString(16));
				droughtBean.setStakenReasons(rs.getString(17));
				droughtBean.setSidentifiedAlternative(rs.getString(18));
				droughtBean.setSidentifiedReasons(rs.getString(19));
				droughtBean.setStankRemarks(rs.getString(20));
				droughtBean.setSdroughtDate(rs.getString(21));
				//droughtBean.setChecks("on");
				droughtBean.setUpdate(true);
				habs.add(droughtBean);
			}

			query = "	select a.panch_code,a.panch_name,b.sssc_code,c.asset_code,c.asset_name,count(d.hab_code) from  rws_complete_hab_view a,"
					+ "RWS_AST_SS_SC_PARAM_TBL  b,rws_asset_mast_tbl c ,rws_asset_hab_tbl d where d.asset_code=c.asset_code  and"
					+ " b.asset_code=c.asset_code and d.hab_code=a.panch_code and substr(a.panch_code,1,16)=? and "
					+ "a.panch_code=substr(b.sssc_code,1,16) group by a.panch_code,a.panch_name,b.sssc_code,c.asset_code,c.asset_name order by "
					+ "a.panch_code";

			pst1 = conn.prepareStatement(query);
			pst1.setString(1, habcode);
			rs1 = pst1.executeQuery();

			int i = 0;
			while (rs1.next()) {

				if (i < habs.size()) {
					droughtBean = (DroughtForm) habs.get(i);
				} else {
					droughtBean = new DroughtForm();
					habs.add(droughtBean);
				}

				droughtBean.setShabCode(rs1.getString(1));
				droughtBean.setShabName(rs1.getString(2));
				droughtBean.setSsscCode(rs1.getString(3));
				droughtBean.setAssetCode(rs1.getString(4));
				droughtBean.setSschemeName(rs1.getString(5));
				droughtBean.setHabCount(rs1.getString(6));
				i++;
			}

		} catch (Exception e) {
			System.out.println("The error in getDroughtSSTanksHabitations=" + e);
		} finally {
			rs.close();
			rs1.close();
			pst.close();
			pst1.close();
			conn.close();

		}
		return habs;
	}

	public ArrayList getDroughtAssetSources(String habcode, DataSource dataSource) throws Exception {

		ArrayList asstsources;
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		LabelValueBean droughtForm = null;
		asstsources = new ArrayList();
		String query = "";

		PreparedStatement pst = null;

		try {
			conn = RwsOffices.getConn();

			query = "select distinct source_name,nvl(a.LOCATION,'--') from rws_source_tbl a,rws_asset_mast_tbl b where a.hab_code=b.hab_code and a.hab_code=?"
					+ " and source_name is not null";

			pst = conn.prepareStatement(query);
			pst.setString(1, habcode);
			rs = pst.executeQuery();

			while (rs.next()) {
				droughtForm = new LabelValueBean();
				droughtForm.setValue(rs.getString(1));
				droughtForm.setLabel(rs.getString(1));
				droughtForm.setLabelValue(rs.getString(1)+" @ "+rs.getString(2));
				asstsources.add(droughtForm);
			}

		} catch (Exception e) {
			System.out.println("The error in getDroughtAssetSources=" + e);
		} finally {
			rs.close();
			pst.close();
			conn.close();
		}
		return asstsources;
	}
	
	public int saveDroughtSSTankHabitations(ArrayList resultData, String habcode, String finyear,DroughtForm frm) throws Exception {
		int count = 0, k = 0;
		PreparedStatement pstmt = null;
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(true);
			WorksData1 worksData = new WorksData1();
			String d = worksData.getServerDate();
			String dd = finyear;
			int i = 0;
			for ( i =0 ; i < frm.getHps().size(); i++) {
				DroughtForm dr= (DroughtForm)frm.getHps().get(i);
				if (dr.getChecks() != null && dr.getChecks().equals("on")) {	
				if (!isExistsRecord(dr, dd)) {
					String query = "insert into rws_drought_sstank_tbl(ASSET_CODE,SSSC_CODE,hab_code,drought_date,popu_served,river_name,"
							+ "canal_name,tank_capacity,no_of_days_serve,present_status,fill_date,prob_canal_clos_dt ,prob_canal_reopen_dt ,steps_taken,"
							+ "STEPS_TAKEN_REASON,identified_alternative,IDENTIFIED_ALTERNATIVE_REASON,update_date,remarks)"
							+ " values (?,?,?,to_date(?,'dd/mm/yyyy'),?,?,?,?,?,?,"
							+ "to_date(?,'dd/mm/yyyy'),to_date(?,'dd/mm/yyyy'),to_date(?,'dd/mm/yyyy'),?,?,?,?,to_date(?,'dd/mm/yyyy'),?)";
					pstmt = conn.prepareStatement(query);
					pstmt.setString(1, dr.getAssetCode());
					pstmt.setString(2, dr.getSsscCode());
					pstmt.setString(3, dr.getShabCode());
					pstmt.setString(4, finyear);
					pstmt.setString(5, dr.getSpopServed());
					pstmt.setString(6, dr.getSriverVaguName());
					pstmt.setString(7, dr.getScanalName());
					pstmt.setString(8, dr.getStankCapacity());
					pstmt.setString(9, dr.getSwaterSupplyDays());
					pstmt.setString(10, dr.getSfillingStatus());
					pstmt.setString(11, dr.getSfillDate());
					pstmt.setString(12, dr.getScanalPrbDate());
					pstmt.setString(13, dr.getSreopenPrbData());
					pstmt.setString(14, dr.getSstepsTaken());
					pstmt.setString(15, dr.getStakenReasons());
					pstmt.setString(16, dr.getSidentifiedAlternative());
					pstmt.setString(17, dr.getSidentifiedReasons());
					pstmt.setString(18, d);
					pstmt.setString(19, dr.getStankRemarks());
					count = pstmt.executeUpdate();
					k = 1;
				} else {

					String query = "update rws_drought_sstank_tbl set hab_code=? , popu_served=?,river_name=?,canal_name=?,"
							+ "tank_capacity=?,no_of_days_serve=?,present_status=?,fill_date=to_date(?,'dd/mm/yyyy'),"
							+ "prob_canal_clos_dt=to_date(?,'dd/mm/yyyy'),prob_canal_reopen_dt=to_date(?,'dd/mm/yyyy'),steps_taken=?,"
							+ "steps_taken_reason=?,identified_alternative=?,identified_alternative_reason=?,remarks=? where ASSET_CODE=?"
							+ " and SSSC_CODE=? and drought_date=to_date(?,'dd/mm/yyyy')";
					pstmt = conn.prepareStatement(query);
					pstmt.setString(1, dr.getShabCode());
					pstmt.setString(2, dr.getSpopServed());
					pstmt.setString(3, dr.getSriverVaguName());
					pstmt.setString(4, dr.getScanalName());
					pstmt.setString(5, dr.getStankCapacity());
					pstmt.setString(6, dr.getSwaterSupplyDays());
					pstmt.setString(7, dr.getSfillingStatus());
					pstmt.setString(8, dr.getSfillDate());
					pstmt.setString(9, dr.getScanalPrbDate());
					pstmt.setString(10, dr.getSreopenPrbData());
					pstmt.setString(11, dr.getSstepsTaken());
					pstmt.setString(12, dr.getStakenReasons());
					pstmt.setString(13, dr.getSidentifiedAlternative());
					pstmt.setString(14, dr.getSidentifiedReasons());
					pstmt.setString(15, dr.getStankRemarks());
					pstmt.setString(16, dr.getAssetCode());
					pstmt.setString(17, dr.getSsscCode());
					pstmt.setString(18, finyear);
					count = pstmt.executeUpdate();
					k = 2;
				}
			}
				}
			if (count > 0) {
				conn.setAutoCommit(true);
				conn.commit();
			} else
				conn.rollback();

		} catch (Exception e) {
			System.out.println("exception in saveDroughtSSTankHabitations of droughtmasterdata -- " + e);
		}finally{
			pstmt.close();
			conn.close();
		}
		return k;
	}

	public boolean isExistsRecord(DroughtForm dr, String ddate) throws Exception {
		boolean exists = false;
		String query = "";
		PreparedStatement stmt1=null;
		try {
			conn = RwsOffices.getConn();
			query = "select * from rws_drought_sstank_tbl where asset_code=? and sssc_code=? and drought_date=to_date(?,'dd/mm/yyyy')";
			stmt1 = conn.prepareStatement(query);
			stmt1.setString(1, dr.getAssetCode());
			stmt1.setString(2, dr.getSsscCode());
			stmt1.setString(3, ddate);
			rs1 = stmt1.executeQuery();

			if (rs1.next()) {
				exists = true;
			}
		} catch (Exception e) {
			exists = false;
			System.out.println("Exception at isExistsRecord of DroughtMasyterdata is : "+e);
		}finally{
			stmt1.close();
		}

		return exists;
	}

	// end

	/*
	 * public ArrayList getDroughtHps(String habcode, DataSource dataSource) throws
	 * Exception { ArrayList habs; DroughtMasterData droughtMasterData = new
	 * DroughtMasterData(); habs = new ArrayList(); boolean exists = false;
	 * DroughtFlushRecords droughtFlushRecords = null; String query = ""; String
	 * queryow = ""; int i = 0; ArrayList c = new ArrayList(); try {
	 * Debug.println("ConnCount is " + connCount);
	 * 
	 * exists = false; droughtMasterData.conn = RwsOffices.getConn();
	 * 
	 * droughtMasterData.stmt = droughtMasterData.conn.createStatement();
	 * droughtMasterData.stmt3 = droughtMasterData.conn.createStatement();
	 * 
	 * //for getting details of hps
	 * 
	 * query = "select distinct
	 * panch_code,panch_name,hp_code,nvl(c.location,'-'),decode(c.asset_status,'1','
	 * WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED') from
	 * rws_complete_hab_view a,rws_hp_subcomp_param_tbl b,rws_asset_mast_tbl c where
	 * a.panch_code=substr(b.hp_code,1,16) and c.asset_code=b.asset_code and
	 * c.hab_code=a.panch_code and substr(panch_code,1,16)='" + habcode + "' and
	 * a.panch_code=substr(b.hp_code,1,16) order by panch_code";
	 * droughtMasterData.rs = droughtMasterData.stmt.executeQuery(query);
	 * //Debug.println("Query***********for habitationshps****" + query); i = 0;
	 * while (droughtMasterData.rs.next()) {
	 * 
	 * droughtFlushRecords = new DroughtFlushRecords();
	 * droughtFlushRecords.setThabitationCode(droughtMasterData.rs .getString(1));
	 * getExistingData(droughtFlushRecords, droughtMasterData.rs .getString(3));
	 * 
	 * droughtFlushRecords.setThabName(droughtMasterData.rs .getString(2));
	 * droughtFlushRecords .setHpCode(droughtMasterData.rs.getString(3));
	 * droughtFlushRecords.setLocation(droughtMasterData.rs .getString(4));
	 * droughtFlushRecords .setStatus(droughtMasterData.rs.getString(5));
	 * 
	 * habs.add(droughtFlushRecords); } //Added for openwells queryow = "select
	 * distinct
	 * panch_code,panch_name,openwell_code,nvl(c.location,'-'),decode(c.asset_status
	 * ,'1','WORKING','2','NOT WORKING','3','DRIED','4','SEASONAL','5','CONDEMED')
	 * from rws_complete_hab_view a,rws_open_well_mast_tbl b,rws_asset_mast_tbl c
	 * where c.asset_code=b.asset_code and c.hab_code=a.panch_code and
	 * substr(b.openwell_code,1,16)=a.panch_code and substr(panch_code,1,16)='" +
	 * habcode + "' and a.panch_code=substr(b.openwell_code,1,16) order by
	 * panch_code"; droughtMasterData.rs3 = droughtMasterData.stmt3
	 * .executeQuery(queryow); //Debug.println("Query***********for
	 * habitationsow**************" // + queryow); //i = 0; while
	 * (droughtMasterData.rs3.next()) {
	 * 
	 * droughtFlushRecords = new DroughtFlushRecords();
	 * 
	 * droughtFlushRecords.setThabitationCode(droughtMasterData.rs3 .getString(1));
	 * getExistingData(droughtFlushRecords, droughtMasterData.rs3 .getString(3));
	 * 
	 * droughtFlushRecords.setThabName(droughtMasterData.rs3 .getString(2));
	 * droughtFlushRecords.setHpCode(droughtMasterData.rs3 .getString(3));
	 * droughtFlushRecords.setLocation(droughtMasterData.rs3 .getString(4));
	 * droughtFlushRecords.setStatus(droughtMasterData.rs3 .getString(5));
	 * habs.add(droughtFlushRecords); } // } catch (Exception e) {
	 * Debug.println("The error in getHabitationstransportdrought=" + e); } finally
	 * { droughtMasterData.closeAll(); Debug.println("ConnCount after closing is " +
	 * connCount); } return habs; }
	 */
	/**
	 * @param droughtFlushRecords
	 * @param h
	 * @return
	 */
	private void getExistingData(DroughtFlushRecords droughtFlushRecords, String hpcode) {

		DroughtMasterData droughtMasterData = new DroughtMasterData();
		PreparedStatement pst = null;

		try {
			droughtMasterData.conn = RwsOffices.getConn();

			String qq = "select to_char(date_of_completion,'dd/mm/yyyy'),DEEPEN_FLUSH,nvl(remarks,'-'),nvl(depth,'0'),SUBSTR(HP_CODE,20,2) ,"
					+ "hp_code from RWS_DROUGHT_FLUSH_DEEPEN_TBL  where habitation_code=? and hp_code=? ";
			pst = droughtMasterData.conn.prepareStatement(qq);
			pst.setString(1, droughtFlushRecords.getThabitationCode());
			pst.setString(2, hpcode);

			// Debug.println("3333:" + qq);
			droughtMasterData.rs1 = pst.executeQuery();

			while (droughtMasterData.rs1.next()) {

				droughtFlushRecords.setFlushDate(droughtMasterData.rs1.getString(1));
				droughtFlushRecords.setHpCode(droughtMasterData.rs1.getString(6));
				droughtFlushRecords.setFlushDepth(droughtMasterData.rs1.getString(4));
				droughtFlushRecords.setFlushRemarks(droughtMasterData.rs1.getString(3));

				droughtFlushRecords.setFlushDeepening(droughtMasterData.rs1.getString(2));
				droughtFlushRecords.setChecks("on");

				droughtFlushRecords.setUpdate(true);

			}
		} catch (Exception e) {
			System.out.println("exception in getExistingData of droughtmasterdata-- " + e);
		}

	}

	public int saveDroughtFlushHabitations(ArrayList resultData, String habcode, String year) throws Exception {
		int count = 0;
		int value = 0;

		// String allhabs[] = new String[1000];

		try {
			conn = RwsOffices.getConn();

			PreparedStatement pstmt = null;
			ResultSet rs1 = null;

			int i = 0;
			for (i = 0; i < resultData.size(); i++) {

				DroughtFlushRecords dr = (DroughtFlushRecords) resultData.get(i);
				value++;
				if (!isExists(dr)) {
					// System.out.println("Habcode:" + dr.getThabitationCode());

					String query = "insert into RWS_DROUGHT_FLUSH_DEEPEN_TBL values (?,?,to_date(?, 'dd/mm/yyyy'),?,?,?,?)";

					pstmt = conn.prepareStatement(query);
					pstmt.setString(1, dr.getThabitationCode());
					pstmt.setString(2, dr.getHpCode());
					pstmt.setString(3, dr.getFlushDate());
					pstmt.setString(4, dr.getFlushDeepening());
					pstmt.setString(5, dr.getFlushDepth());
					pstmt.setString(6, dr.getFlushRemarks());
					pstmt.setString(7, year);

					count = pstmt.executeUpdate();

				} else {

					String query = "update RWS_DROUGHT_FLUSH_DEEPEN_TBL set DATE_OF_COMPLETION =to_date(?,'dd/mm/yyyy')"

							+ ",DEEPEN_FLUSH =?,remarks=?,depth=?,DROUGHT_YEAR=? where habitation_code=? and hp_code=? and "
							+ "DATE_OF_COMPLETION =to_date(?,'dd/mm/yyyy')"

							+ " and DROUGHT_YEAR=? ";

					pstmt = conn.prepareStatement(query);
					pstmt.setString(1, dr.getFlushDate());
					pstmt.setString(2, dr.getFlushDeepening());
					pstmt.setString(3, dr.getFlushRemarks());
					pstmt.setString(4, dr.getFlushDepth());
					pstmt.setString(5, year);
					pstmt.setString(6, habcode);
					pstmt.setString(7, dr.getHpCode());
					pstmt.setString(8, dr.getFlushDate());
					pstmt.setString(9, year);

					count = pstmt.executeUpdate();
				}
			}

			if (count > 0) {

				conn.commit();
			} else
				conn.rollback();
		} catch (Exception e) {
			System.out.println("exception in drought master data  saveDroughtFlushHabitations -- " + e);
		}
		return value;

	}

	/**
	 * @param dr
	 * @return
	 */
	private boolean isExists(DroughtFlushRecords dr) {

		try {
			conn = RwsOffices.getConn();
			PreparedStatement pstmt = null;
			ResultSet rs1 = null;

			String query = "select *from  RWS_DROUGHT_FLUSH_DEEPEN_TBL where habitation_code=? and hp_code=? and "
					+ "date_of_completion=to_date(?, 'dd/mm/yyyy')";

			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, dr.getThabitationCode());
			pstmt.setString(2, dr.getHpCode());
			pstmt.setString(3, dr.getFlushDate());

			rs1 = pstmt.executeQuery();

			if (rs1.next())
				return true;
			else
				return false;
		} catch (Exception e) {
			System.out.println("exception in droughtmasterdata isExists method -- " + e);
		}

		return false;
	}

	/**
	 * @param dd
	 * @param mm
	 * @param droughtYear
	 */
	public int saveDroughtMandal(String dd, String mm, String droughtYear, String droughtMandal) {

		PreparedStatement stmt = null;
		Connection conn = null;
		ResultSet rrs = null;
		try {

			conn = RwsOffices.getConn();

			String q2 = "select count(*) from rws_drought_mandal_tbl where year=? and dcode=? and mcode =? ";

			// System.out.println("Q2:" + q2);
			stmt = conn.prepareStatement(q2);
			stmt.setString(1, droughtYear);
			stmt.setString(2, dd);
			stmt.setString(3, mm);

			rrs = stmt.executeQuery();
			int count = 0;
			if (rrs.next()) {
				count = rrs.getInt(1);
			}
			stmt.close();

			if (count == 0) {
				String q1 = "insert into rws_drought_mandal_tbl values (?,?,?,?)";
				stmt = conn.prepareStatement(q1);
				stmt.setString(1, dd);
				stmt.setString(2, mm);
				stmt.setString(3, droughtYear);
				stmt.setString(4, droughtMandal);

				return stmt.executeUpdate();
			} else {

				String q1 = "update rws_drought_mandal_tbl set drought_mandal =? where year=? and dcode=? and mcode =? ";
				stmt = conn.prepareStatement(q1);
				stmt.setString(1, droughtMandal);
				stmt.setString(2, droughtYear);
				stmt.setString(3, dd);
				stmt.setString(4, mm);
				return stmt.executeUpdate();
			}

		} catch (Exception e) {
			System.out.println("exception in saveDroughtMandal -- " + e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
			} catch (Exception e) {

			}
		}
		return 0;
	}

	/**
	 * @param d
	 * @param m
	 * @param droughtYear
	 * @return
	 */
	public static String isDroughtmandal(String d, String m, String droughtYear) {
		PreparedStatement stmt = null;
		Connection conn = null;
		ResultSet rrs = null;
		try {

			conn = RwsOffices.getConn();

			String q2 = "select DROUGHT_MANDAL  from rws_drought_mandal_tbl where year=? and dcode=? and mcode =? ";

			stmt = conn.prepareStatement(q2);
			stmt.setString(1, droughtYear);
			stmt.setString(2, d);
			stmt.setString(3, m);

			rrs = stmt.executeQuery();
			if (rrs.next()) {
				return rrs.getString(1);
			}

		} catch (Exception e) {
			System.out.println("exception in isDroughtmandal of droughtmaster data " + e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
			} catch (Exception e) {

			}
		}
		return "";
	}

	//// Added for Daily abstract entry Districts on04-01-2013 by jyothi

	public ArrayList getDistricts(DataSource dataSource) throws Exception {
		ArrayList districts;
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		LabelValueBean droughtForm = null;
		districts = new ArrayList();
		String query = "";
		PreparedStatement ps = null;
		try {

			droughtMasterData.conn = RwsOffices.getConn();

			query = "select distinct a.dcode,a.dname from rws_district_tbl a where dcode <>'16' order by a.dname";
			ps = droughtMasterData.conn.prepareStatement(query);
			droughtMasterData.rs = ps.executeQuery();
			// Debug.println("Query" + query);
			while (droughtMasterData.rs.next()) {
				droughtForm = new LabelValueBean();
				droughtForm.setValue(droughtMasterData.rs.getString(1));
				droughtForm.setLabel(droughtMasterData.rs.getString(2));
				droughtForm
						.setLabelValue(droughtMasterData.rs.getString(2) + " - " + droughtMasterData.rs.getString(1));
				districts.add(droughtForm);
			}

		} catch (Exception e) {
			System.out.println("The error in getDroughtdistricts=" + e);
			// e.printStackTrace();
		} finally {
			droughtMasterData.closeAll();

		}
		return districts;
	}

	// Added for view for drought sstanks on 26-03-2012
	public ArrayList getDroughtDailyAbstractDetails(String dcode, String absdate, DataSource dataSource)
			throws Exception {
		ArrayList habs;
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		habs = new ArrayList();
		boolean exists = false;
		DroughtBean droughtBean = null;
		String query = "";
		ArrayList c = new ArrayList();
		PreparedStatement ps = null;
		try {
			// Debug.println("ConnCount is " + connCount);

			exists = false;
			droughtMasterData.conn = RwsOffices.getConn();

			String qq = "select NO_OF_HABS_TR,POP_SERVED_TR,QTY_TR,NO_OF_HABS_HR,NO_OF_SOURCES,POP_SERVED_HR,"
					+ "NO_OF_HABS_POW,HUMAN_TANKER_TRIPS,NO_OF_HABS_CAT,POP_SERVED_CAT,QTY_CAT,"
					+ "CATTLE_TANKER_TRIPS from rws_drought_con_tr_hir_tbl where dcode=?  and DR_DATE=to_date(?,'dd/mm/yyyy') ";

			// Debug.println("3333:" + qq);
			ps = droughtMasterData.conn.prepareStatement(qq);
			ps.setString(1, dcode);
			ps.setString(2, absdate);
			droughtMasterData.rs1 = ps.executeQuery();

			while (droughtMasterData.rs1.next()) {
				droughtBean = new DroughtBean();
				droughtBean.setTrhabs(droughtMasterData.rs1.getString(1));
				droughtBean.setTrpopserv(droughtMasterData.rs1.getString(2));
				droughtBean.setTrqty(droughtMasterData.rs1.getString(3));
				droughtBean.setHshabs(droughtMasterData.rs1.getString(4));
				droughtBean.setHssour(droughtMasterData.rs1.getString(5));
				droughtBean.setHspopserv(droughtMasterData.rs1.getString(6));
				droughtBean.setPowhabs(droughtMasterData.rs1.getString(7));
				droughtBean.setTrnooftrips(droughtMasterData.rs1.getString(8));
				droughtBean.setCathabs(droughtMasterData.rs1.getString(9));
				droughtBean.setCatpopserv(droughtMasterData.rs1.getString(10));
				droughtBean.setCatqty(droughtMasterData.rs1.getString(11));
				droughtBean.setCatnooftrips(droughtMasterData.rs1.getString(12));
				droughtBean.setTothabs(droughtMasterData.rs1.getInt(1) + droughtMasterData.rs1.getInt(4)
						+ droughtMasterData.rs1.getInt(7));
				droughtBean.setChecks("on");
				droughtBean.setUpdate(true);
				habs.add(droughtBean);
			}

		} catch (Exception e) {
			System.out.println("The error in getDroughtDailyAbstractDetails=" + e);
		} finally {
			droughtMasterData.closeAll();
			ps.close();
			// Debug.println("ConnCount after closing is " + connCount);
		}
		return habs;
	}

	public String saveDroughtDailyAbstractEntry(ArrayList resultData, String dcode, String absdate, String loggedUser)
			throws Exception {
		int count = 0;
		// String allhabs[] = new String[1000];
		String message = "";
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(true);
			PreparedStatement pstmt = null;
			ResultSet rs1 = null;
			WorksData1 worksData = new WorksData1();
			String sysdate = worksData.getDate();

			int i = 0;
			for (i = 0; i < resultData.size(); i++) {

				DroughtBean dr = (DroughtBean) resultData.get(i);

				if (!isExistsRecord1(dr, dcode, absdate)) {
					// System.out.println("Habcode:" + dr.getThabitationCode());

					String query = "insert into  rws_drought_con_tr_hir_tbl(dcode,DR_DATE,no_of_habs_tr,pop_served_tr,HUMAN_TANKER_TRIPS,"
							+ "qty_tr,NO_OF_HABS_CAT,POP_SERVED_CAT,QTY_CAT,CATTLE_TANKER_TRIPS,no_of_habs_hr,NO_OF_SOURCES,"
							+ "pop_served_hr,no_of_habs_pow) values (?,to_date(?,'dd/mm/yyyy'),?,?,?,?,?,?,?,?,?,?,?,?)";
					pstmt = conn.prepareStatement(query);
					pstmt.setString(1, dcode);
					pstmt.setString(2, absdate);
					pstmt.setString(3, dr.getTrhabs());
					pstmt.setString(4, dr.getTrpopserv());
					pstmt.setString(5, dr.getTrnooftrips());
					pstmt.setString(6, dr.getTrqty());
					pstmt.setString(7, dr.getCathabs());
					pstmt.setString(8, dr.getCatpopserv());
					pstmt.setString(9, dr.getCatqty());
					pstmt.setString(10, dr.getCatnooftrips());
					pstmt.setString(11, dr.getHshabs());
					pstmt.setString(12, dr.getHssour());
					pstmt.setString(13, dr.getHspopserv());
					pstmt.setString(14, dr.getPowhabs());

					count = pstmt.executeUpdate();
					message = "Record(s) Saved Successfully";

				} else if (loggedUser.equals("1000DR")) {

					String query = "update rws_drought_con_tr_hir_tbl set NO_OF_HABS_TR=? , POP_SERVED_TR=? , QTY_TR=?"
							+ " ,NO_OF_HABS_HR=? ,NO_OF_SOURCES=? ,POP_SERVED_HR=?, NO_OF_HABS_POW=?"
							+ " ,HUMAN_TANKER_TRIPS =? ,NO_OF_HABS_CAT =?,POP_SERVED_CAT=?,QTY_CAT=?"
							+ ",CATTLE_TANKER_TRIPS=? where DCODE=? and DR_DATE=to_date(?,'dd/mm/yyyy')";

					pstmt = conn.prepareStatement(query);

					pstmt.setString(1, dr.getTrhabs());
					pstmt.setString(2, dr.getTrpopserv());
					pstmt.setString(3, dr.getTrqty());
					pstmt.setString(4, dr.getHshabs());
					pstmt.setString(5, dr.getHssour());
					pstmt.setString(6, dr.getHspopserv());
					pstmt.setString(7, dr.getPowhabs());
					pstmt.setString(8, dr.getTrnooftrips());
					pstmt.setString(9, dr.getCathabs());
					pstmt.setString(10, dr.getCatpopserv());
					pstmt.setString(11, dr.getCatqty());
					pstmt.setString(12, dr.getCatnooftrips());
					pstmt.setString(13, dcode);
					pstmt.setString(14, absdate);
					count = pstmt.executeUpdate();
					message = "Record(s) Updated Successfully";
					// }
					// else
					// {
					// message="Sorry Cannot Updated the Records(Update Date is
					// Greater than the Entry Date)";
					// }
				}

				else {

					message = "Sorry Cannot Updated the Records(" + loggedUser
							+ " User is not Permitted to Edit the Record(s))";

				}

			}

			if (count > 0) {
				conn.setAutoCommit(true);
				conn.commit();
			} else
				conn.rollback();
		} catch (Exception e) {
			System.out.println("exception in saveDroughtDailyAbstractEntry -- " + e);
		}
		return message;

	}

	public static boolean isExistsRecord1(DroughtBean dr, String dcode, String ddate) {
		boolean exists;
		exists = false;
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		String query = "";
		PreparedStatement ps = null;

		try {

			droughtMasterData.conn = RwsOffices.getConn();
			query = "select * from rws_drought_con_tr_hir_tbl where dcode=? and dr_date=to_date(?,'dd/mm/yyyy')";
			ps = droughtMasterData.conn.prepareStatement(query);
			ps.setString(1, dcode);
			ps.setString(2, ddate);

			droughtMasterData.rs1 = ps.executeQuery();
			if (droughtMasterData.rs1.next()) {
				exists = true;
			}
		} catch (Exception e) {
			System.out.println("exception in isExistsRecord1 --" + e);
			exists = false;
		}

		return exists;
	}

	/**
	 * @param parameter
	 * @param droughtYear
	 * @return
	 */
	public int deleteDroughtHab(String habCode, String droughtYear) {

		Statement stmt = null;
		Connection conn = null;

		try {

			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String q2 = "delete from RWS_DROUGHT_HABITATION_TBL where habcode='" + habCode + "' and year='"
					+ droughtYear + "'";
			System.out.println("Q2:" + q2);
			return stmt.executeUpdate(q2);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return 0;

	}

	/**
	 * @return
	 */
	public ArrayList getWeekDates() {
		ArrayList weedates;
		DroughtMasterData droughtMasterData = new DroughtMasterData();
		LabelValueBean droughtForm = null;
		weedates = new ArrayList();
		String query = "";
		try {

			String cDate = RwsUtils.getCurrentDate("dd/MMM/yyyy");
			String cDate1 = RwsUtils.getCurrentDate("dd/MM/yyyy");

			String res[] = cDate1.split("/");

			String dValues[] = cDate.split("/");
			// System.out.println("CDatae" + cDate);
			int k = 1;
			String mesg = "";
			for (int i = 0; i < 4; i++) {

				if (i == 0) {
					mesg = "st";
				} else {
					mesg = "th";
				}
				LabelValueBean labelValueBean = new LabelValueBean();

				labelValueBean.setLabelValue("As on " + k + mesg + " Month(" + dValues[1] + ")-" + dValues[2]);

				String dd = k + "/" + res[1] + "/" + dValues[2];
				labelValueBean.setValue(dd);
				k = k + 7;

				weedates.add(labelValueBean);

			}

		} catch (Exception e) {
			System.out.println("exception in getWeekDates of droughtmasterdata -- " + e);
		} finally {

		}
		return weedates;
	}

}

//
