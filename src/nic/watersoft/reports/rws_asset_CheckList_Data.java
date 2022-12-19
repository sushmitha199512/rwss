package nic.watersoft.reports;

import java.sql.Connection;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.ArrayList;
import javax.sql.DataSource;

public class rws_asset_CheckList_Data {
	// used
	public static ArrayList getCircles(DataSource datasource) throws Exception {
		Connection conn = null;
		ArrayList circles = null;
		rws_asset_CheckList_Bean circle = null;
		try {
			circles = new ArrayList();
			// Debug.println("in getCircles ");
			String query = "select CIRCLE_OFFICE_CODE,CIRCLE_OFFICE_NAME from RWS_CIRCLE_OFFICE_TBL order by CIRCLE_OFFICE_CODE,CIRCLE_OFFICE_NAME";
			conn = RwsOffices.getConn();
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				circle = new rws_asset_CheckList_Bean();
				circle.setCircleCode(rs.getString("CIRCLE_OFFICE_CODE") + "");// circle.setCircleCode(rs.getString("CIRCLE_OFFICE_CODE")+"");
				// Debug.println("circle code is"+rs.getString("CIRCLE_OFFICE_CODE"));
				circle.setCircleName(rs.getString("CIRCLE_OFFICE_NAME"));
				circles.add(circle);
			}
		} catch (Exception e) {
			Debug.println("Exception while geting circles" + e);
		} finally {
			conn.close();
		}
		return circles;
	}

	public static ArrayList getStatusDate(DataSource datasource)
			throws Exception {
		Connection conn = null;
		ArrayList dates = null;
		rws_asset_CheckList_Bean date = null;
		try {
			dates = new ArrayList();
			Debug.println("in getCircles ");
			String query = "select distinct to_char(status_date,'dd-mon-yyyy')   from  rws_habitation_directory_tbl";
			conn = RwsOffices.getConn();
			PreparedStatement ps = conn.prepareStatement(query);
			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				date = new rws_asset_CheckList_Bean();
				date.setStatusDate(rs.getString(1) + "");
				dates.add(date);
			}
		} catch (Exception e) {
			Debug.println("Exception while geting circles" + e);
		} finally {
			try {
				if (conn != null) {

					conn.close();
				}
			} catch (SQLException e) {
				Debug.println("Exception " + e);
			}
		}
		return dates;
	}

	// added by ramesh on 161009

	public static String getCheckListAssetData(String assetCode,
			String assetTypeCode, Connection connn) throws Exception {
		ArrayList data = null;
		// Connection conn=null;
		// Connection connn = RwsOffices.getConn();
		StringBuffer buffer = new StringBuffer();
		ResultSet rs = null;
		PreparedStatement ps = null;
		String codeSeries = "";
		if (assetTypeCode.equals("01") || assetTypeCode.equals("02")
				|| assetTypeCode.equals("03") || assetTypeCode.equals("09")) {
			if (assetTypeCode.equals("01"))
				codeSeries = "6%";
			else if (assetTypeCode.equals("02"))
				codeSeries = "4%";
			else if (assetTypeCode.equals("03"))
				codeSeries = "8%";
			else if (assetTypeCode.equals("09"))
				codeSeries = "45%";
			try {
				rs = null;
				ps = null;
				String query = "select (select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_SOURCE_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode
						+ "' and subCompTbl. SOURCE_TYPE_CODE ='1')a,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_SOURCE_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode
						+ "' and subCompTbl. SOURCE_TYPE_CODE ='2')b,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_RW_COLLWELL_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR (S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode
						+ "')c,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_SS_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR (S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode
						+ "')d,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_WTP_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR (S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode
						+ "' and substr(subCompTbl.WTPSC_CODE,20,2)='SS') e, (select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_WTP_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode
						+ "' and substr(subCompTbl.WTPSC_CODE,20,2)='RS')f,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_SUMP_M_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode
						+ "')g,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_FP_BRIDGE_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode
						+ "')h,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_PUMPHOUSE_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode
						+ "')i,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_WATCHMAN_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode
						+ "')j,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_CW_COLLWELL_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode
						+ "')k,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_WTP_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode
						+ "' and substr(subCompTbl.WTPSC_CODE,20,2)='MS')l,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_WTP_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode
						+ "' and substr(subCompTbl.WTPSC_CODE,20,2)='RP')m,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_PUMPINGMAIN_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode
						+ "')n,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_GRAVITYMAIN_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode
						+ "')o,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_DISTRI_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode
						+ "')p,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_OHSR_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode
						+ "')q,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_OHBR_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode
						+ "')r,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_GLSR_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode
						+ "')s,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_GLBR_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode
						+ "')t,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_BPT_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode
						+ "')u,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_CIS_SC_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode
						+ "')v,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_OTHERS_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode
						+ "')w,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_CHLORINATION_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode
						+ "')x,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_OANDM_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode
						+ "')y,(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_SUBCOMP_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode + "')z from dual";
				// Debug.println("query:"+query);
				ps = connn.prepareStatement(query);
				rs = null;
				rs = ps.executeQuery();
				if (rs.next()) {
					for (int i = 1; i <= 26; i++) {
						buffer.append(checkValue(rs.getInt(i)) + "/");
					}
				}
			} catch (Exception e) {
				Debug.println("The error in getAssetData " + e);
			} finally {
				if (ps != null)
					ps.close();
				if (rs != null)
					rs.close();
				// if(connn!=null)connn.close();
			}
		} else if (assetTypeCode.equals("04")) {
			codeSeries = "0%";
			try {
				rs = null;
				ps = null;
				String query = "select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_HANDPUMP_ASSET_VIEW S,rws_hp_subcomp_param_tbl subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR (S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode + "'";
				// Debug.println("queryYYYY:"+query);
				ps = connn.prepareStatement(query);
				rs = null;
				rs = ps.executeQuery();
				if (rs.next()) {
					buffer.append(checkValue(rs.getInt(1)) + "/");
				}
			} catch (Exception e) {
				Debug.println("The error in getAssetData " + e);
			} finally {
				if (ps != null)
					ps.close();
				if (rs != null)
					rs.close();
				// if(connn!=null)connn.close();
			}
		} else if (assetTypeCode.equals("06")) {
			codeSeries = "5%";
			try {
				rs = null;
				ps = null;
				String query = "select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPEN_WELL_MAST_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR (S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode + "'";
				Debug.println("queryZZZZ:" + query);
				ps = connn.prepareStatement(query);
				rs = null;
				rs = ps.executeQuery();
				if (rs.next()) {
					buffer.append(checkValue(rs.getInt(1)) + "/");
				}
			} catch (Exception e) {
				Debug.println("The error in getAssetData " + e);
			} finally {
				if (ps != null)
					ps.close();
				if (rs != null)
					rs.close();
				// if(connn!=null)connn.close();
			}
		} else if (assetTypeCode.equals("07")) {
			codeSeries = "7%";
			try {
				rs = null;
				ps = null;
				String query = "select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPENWELL_POND_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR (S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode + "'";
				Debug.println("queryEEEEEEEEEEE:" + query);
				ps = connn.prepareStatement(query);
				rs = null;
				rs = ps.executeQuery();
				if (rs.next()) {
					buffer.append(checkValue(rs.getInt(1)) + "/");
				}
			} catch (Exception e) {
				Debug.println("The error in getAssetData " + e);
			} finally {
				if (ps != null)
					ps.close();
				if (rs != null)
					rs.close();
				// if(connn!=null)connn.close();
			}
		} else if (assetTypeCode.equals("08")) {
			codeSeries = "9%";
			try {
				rs = null;
				ps = null;
				String query = "select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_AST_OTHERS_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR (S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode + "'";
				Debug.println("queryOOOOOOOoooooooooooooooo:" + query);
				ps = connn.prepareStatement(query);
				rs = null;
				rs = ps.executeQuery();
				if (rs.next()) {
					buffer.append(checkValue(rs.getInt(1)) + "/");
				}
			} catch (Exception e) {
				Debug.println("The error in getAssetData " + e);
			} finally {
				if (ps != null)
					ps.close();
				if (rs != null)
					rs.close();
				// if(connn!=null)connn.close();
			}
		}

		else if (assetTypeCode.equals("05")) {
			codeSeries = "3%";
			try {
				rs = null;
				ps = null;
				String query = "select count(*) FROM RWS_ASSET_MAST_TBL M, rws_asset_scheme_tbl S,RWS_SHALLOWHANDPUMPS_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='"
						+ assetTypeCode
						+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR (S.SCHEME_CODE,17,3) LIKE '"
						+ codeSeries
						+ "' and SUBCOMPTBL.ASSET_CODE='"
						+ assetCode + "'";
				Debug.println("queryEEEEEEEEEEE:" + query);
				ps = connn.prepareStatement(query);
				rs = null;
				rs = ps.executeQuery();
				if (rs.next()) {
					buffer.append(checkValue(rs.getInt(1)) + "/");
				}
			} catch (Exception e) {
				Debug.println("The error in getAssetData " + e);
			} finally {
				if (ps != null)
					ps.close();
				if (rs != null)
					rs.close();
				// if(connn!=null)connn.close();
			}
		}

		return buffer.toString();
	}

	public static String getCpwsAssetData(String asset, String assetCode)
			throws Exception {
		ArrayList data = null;
		// Connection conn=null;
		Connection conn = RwsOffices.getConn();
		StringBuffer buffer = new StringBuffer();

		try {

			if (asset.equals("03"))// PWS && MPWS && CPWS --
									// asset.equals("01")||asset.equals("02")||
				for (int i = 0; i < 6; i++) {
					ResultSet rs = null;
					PreparedStatement ps = null;
					String assetCompcode = "";
					switch (i) {
					case 0:
						assetCompcode = "01";
						break;
					case 1:
						assetCompcode = "02";
						break;
					case 2:
						assetCompcode = "03";
						break;
					case 3:
						assetCompcode = "04";
						break;
					case 4:
						assetCompcode = "05";
						break;
					case 5:
						assetCompcode = "06";
						break;
					}
					String query = "";
					String[] aaa = query.split("/");

					if (assetCompcode.equals("01")) {
						query = "select  trim(ASSET_SUBCOMPONENT_NAME),ASSET_SUBCOMPONENT_CODE"
								+ " from rws_asset_subcomponent_tbl where asset_component_code='"
								+ assetCompcode
								+ "'"
								+ " and type_of_asset_code='"
								+ asset
								+ "' and  ASSET_SUBCOMPONENT_CODE<> '003' ORDER BY ASSET_SUBCOMPONENT_CODE ";
					} else {
						query = "select  trim(ASSET_SUBCOMPONENT_NAME),ASSET_SUBCOMPONENT_CODE"
								+ " from rws_asset_subcomponent_tbl where asset_component_code='"
								+ assetCompcode
								+ "'"
								+ " and type_of_asset_code='"
								+ asset
								+ "' ORDER BY ASSET_SUBCOMPONENT_CODE ";
					}

					// Debug.println("query is "+query);
					ps = conn.prepareStatement(query);
					// Debug.println("query is:**"+query );
					rs = null;
					rs = ps.executeQuery();

					while (rs.next()) {

						// Debug.println("COMpnet name:"+rs.getString(1));
						// Debug.println("COMpnet name111111:"+rs.getString(2));
						buffer.append(rs.getString(1) + "/");
						// buffer.append(rs.getString(2)+"<>");
						buffer.append(checkValue(getCpwsSubCompCount(asset,
								assetCompcode, (String) rs.getString(2),
								assetCode, conn))
								+ "/");
					}
					// buffer.append("<//>");

				}
		} catch (Exception e) {
			Debug.println("The error in getAssetData " + e);
		} finally {
			// conn.close();
		}

		return buffer.toString();
	}

	// used
	public static ArrayList getCounts(DataSource datasource) throws Exception {
		Connection conn = null;
		ArrayList counts = null;
		rws_asset_CheckList_Bean count = null;
		try {
			counts = new ArrayList();
			Debug.println("in getCounts  @@@@@@@@");
			String query = "";
			conn = RwsOffices.getConn();
			// /PWS COUNT
			query = "SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE "
					+ "M.ASSET_CODE=S.ASSET_CODE AND  M.TYPE_OF_ASSET_CODE='01'";
			Debug.println("QUEry 1 is:" + query);
			PreparedStatement ps1 = conn.prepareStatement(query);
			ResultSet rs1 = ps1.executeQuery();
			count = new rws_asset_CheckList_Bean();
			while (rs1.next()) {
				count.setPwsCount(rs1.getString(1) + "");
			}
			// MPWS COUNT
			query = "SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE "
					+ "M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='02'";
			Debug.println("QUEry 2 is:" + query);
			PreparedStatement ps2 = conn.prepareStatement(query);
			ResultSet rs2 = ps2.executeQuery();
			while (rs2.next()) {
				count.setMpwsCount(rs2.getString(1) + "");
			}
			// /CPWS COUNT
			/*
			 * query=
			 * "select count(*) from rws_asset_mast_tbl M where M.TYPE_OF_ASSET_CODE='03'"
			 * + "and m.asset_code is not null";
			 */
			query = "SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='03' ";
			Debug.println("QUEry 3 is:" + query);
			PreparedStatement ps3 = conn.prepareStatement(query);
			ResultSet rs3 = ps3.executeQuery();
			while (rs3.next()) {
				count.setCpwsCount(rs3.getString(1) + "");
			}
			// /HAND PUMPS COUNT
			query = "select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_HP_SUBCOMP_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
					+ "AND M.TYPE_OF_ASSET_CODE='04' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE ";
			// query="select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S WHERE  M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='04'";

			Debug.println("QUEry 4 is:" + query);
			PreparedStatement ps4 = conn.prepareStatement(query);
			ResultSet rs4 = ps4.executeQuery();
			while (rs4.next()) {
				count.setHandPumpCount(rs4.getString(1) + "");
			}
			// /SHALLOW HANDPUMPS COUNT
			query = "select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_SHALLOWHANDPUMPS_TBL "
					+ "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
					+ "AND M.TYPE_OF_ASSET_CODE='05' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE ";
			// query="select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S WHERE  M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='05' ";

			Debug.println("QUEry 5 is:" + query);
			PreparedStatement ps5 = conn.prepareStatement(query);
			ResultSet rs5 = ps5.executeQuery();
			while (rs5.next()) {
				count.setShallowHandPumps(rs5.getString(1) + "");
			}
			// /OPEN WELLS COUNT
			query = "select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPEN_WELL_MAST_TBL  "
					+ "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
					+ "AND M.TYPE_OF_ASSET_CODE='06' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE ";

			// query="select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S WHERE  M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='06' ";
			Debug.println("QUEry 6 is:" + query);
			PreparedStatement ps6 = conn.prepareStatement(query);
			ResultSet rs6 = ps6.executeQuery();
			while (rs6.next()) {
				count.setOpenWells(rs6.getString(1) + "");
			}
			// /ponds COUNT
			query = "select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPENWELL_POND_TBL  "
					+ "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
					+ "AND M.TYPE_OF_ASSET_CODE='07' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE ";

			// query="select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S WHERE M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='07' ";

			Debug.println("QUEry 7 is:" + query);
			PreparedStatement ps7 = conn.prepareStatement(query);
			ResultSet rs7 = ps7.executeQuery();
			while (rs7.next()) {
				count.setPonds(rs7.getString(1) + "");
			}
			// newly added by sridhar
			query = "SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='09'";
			Debug.println("QUEry 8 is:" + query);
			PreparedStatement ps8 = conn.prepareStatement(query);
			ResultSet rs8 = ps8.executeQuery();
			while (rs8.next()) {
				count.setDpCount(rs8.getString(1) + "");
			}
			counts.add(count);
			// Debug.println("counts size:"+counts.size());
			rs1.close();
			rs2.close();
			rs3.close();
			rs4.close();
			rs5.close();
			rs6.close();
			rs7.close();
			rs8.close();
			ps1.close();
			ps2.close();
			ps3.close();
			ps4.close();
			ps5.close();
			ps6.close();
			ps7.close();
			ps8.close();
		} catch (Exception e) {
			Debug.println("Exception while geting circles" + e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				Debug.println("Exception " + e);
			}
		}
		return counts;
	}

	public static ArrayList getAssetCounts(DataSource datasource,
			String circleOfficeCode) throws Exception {
		Connection conn = null;
		ArrayList counts = null;
		rws_asset_CheckList_Bean count = null;
		try {
			counts = new ArrayList();
			Debug.println("in getCounts 5");
			String query = "";
			conn = RwsOffices.getConn();

			query = "select ";

			/*
			 * ///PWS COUNT query+=
			 * "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE "
			 * +
			 * "M.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,17,3) LIKE '6%' AND M.TYPE_OF_ASSET_CODE='01' AND SUBSTR(SCHEME_CODE,1,2)='"
			 * +circleOfficeCode+"') as pwsCount,";
			 * 
			 * //MPWS COUNT query+=
			 * "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE"
			 * +
			 * " M.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,17,3) LIKE '4%' AND M.TYPE_OF_ASSET_CODE='02' AND SUBSTR(SCHEME_CODE,1,2)='"
			 * +circleOfficeCode+"') as mpwsCount,";
			 * 
			 * ///CPWS COUNT query+=
			 * "(select count(*) from RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S  where M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='03'"
			 * + " and m.asset_code is not null  AND SUBSTR(SCHEME_CODE,1,2)='"+
			 * circleOfficeCode+"') as cpwsCount,";
			 * 
			 * ///HAND PUMPS COUNT query+=
			 * "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_HP_SUBCOMP_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
			 * +
			 * "AND M.TYPE_OF_ASSET_CODE='04' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '0%'  AND SUBSTR(SCHEME_CODE,1,2)='"
			 * +circleOfficeCode+"')as hpCount,";
			 * 
			 * ///SHALLOW HANDPUMPS COUNT query+=
			 * "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_SHALLOWHANDPUMPS_TBL "
			 * +
			 * "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
			 * +
			 * " AND M.TYPE_OF_ASSET_CODE='05' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND "
			 * +
			 * "SUBSTR(S.SCHEME_CODE,17,3) LIKE '3%'  AND SUBSTR(SCHEME_CODE,1,2)='"
			 * +circleOfficeCode+"')as shpCount, ";
			 * 
			 * ///OPEN WELLS COUNT query+=
			 * "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPEN_WELL_MAST_TBL  "
			 * +
			 * "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
			 * +
			 * " AND M.TYPE_OF_ASSET_CODE='06' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND "
			 * +
			 * "SUBSTR(S.SCHEME_CODE,17,3) LIKE '2%'  AND SUBSTR(SCHEME_CODE,1,2)='"
			 * +circleOfficeCode+"')as openWellsCount, ";
			 * 
			 * ///PONDS COUNT query+=
			 * "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPENWELL_POND_TBL  "
			 * +
			 * "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
			 * +
			 * " AND M.TYPE_OF_ASSET_CODE='07' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND "
			 * +
			 * "SUBSTR(S.SCHEME_CODE,17,3) LIKE '7%'  AND SUBSTR(SCHEME_CODE,1,2)='"
			 * +circleOfficeCode+"')as pondsCount ";
			 */

			// PWS COUNT
			query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE "
					+ "M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='01' AND SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode + "') as pwsCount,";

			// MPWS COUNT
			query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE"
					+ " M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='02' AND SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode + "') as mpwsCount,";

			// /CPWS COUNT
			query += "(select count(*) from RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S  where M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='03' "
					+ "  AND SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode
					+ "') as cpwsCount,";

			// /HAND PUMPS COUNT
			query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S WHERE  M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='04'  AND SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode + "')as hpCount,";

			// /SHALLOW HANDPUMPS COUNT
			query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S WHERE M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='05' AND SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode + "')as shpCount, ";

			// /OPEN WELLS COUNT
			query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S WHERE M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='06' AND SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode + "')as openWellsCount, ";

			// /PONDS COUNT
			query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S WHERE M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='07' AND SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode + "')as pondsCount ";

			query += " from dual";

			Debug.println("query is " + query);
			PreparedStatement ps1 = conn.prepareStatement(query);
			ResultSet rs1 = ps1.executeQuery();
			count = new rws_asset_CheckList_Bean();
			while (rs1.next()) {
				count.setPwsCount(rs1.getString("pwsCount") + "");
				count.setMpwsCount(rs1.getString("mpwsCount") + "");
				count.setCpwsCount(rs1.getString("cpwsCount") + "");
				count.setHandPumpCount(rs1.getString("hpCount") + "");
				count.setShallowHandPumps(rs1.getString("shpCount") + "");
				count.setOpenWells(rs1.getString("openWellsCount") + "");
				count.setPonds(rs1.getString("pondsCount") + "");
			}

			counts.add(count);
			rs1.close();

		} catch (Exception e) {
			Debug.println("Exception while geting circles" + e);
		} finally {
			try {
				if (conn != null) {

					conn.close();
				}
			} catch (SQLException e) {
				Debug.println("Exception " + e);
			}
		}
		return counts;
	}

	public static ArrayList getAssetCounts(DataSource datasource,
			String circleOfficeCode, String mandalCode) throws Exception {
		Connection conn = null;
		ArrayList counts = null;
		rws_asset_CheckList_Bean count = null;
		try {
			counts = new ArrayList();
			Debug.println("in getCounts 4");
			String query = "";
			conn = RwsOffices.getConn();

			query = "select ";

			/*
			 * ///PWS COUNT query+=
			 * "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE "
			 * +
			 * "M.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,17,3) LIKE '6%' AND M.TYPE_OF_ASSET_CODE='01' AND SUBSTR(SCHEME_CODE,1,2)='"
			 * +circleOfficeCode+"'  AND SUBSTR(SCHEME_CODE,6,2)='"+mandalCode+
			 * "') as pwsCount,";
			 * 
			 * //MPWS COUNT query+=
			 * "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE"
			 * +
			 * " M.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,17,3) LIKE '4%' AND M.TYPE_OF_ASSET_CODE='02' AND SUBSTR(SCHEME_CODE,1,2)='"
			 * +circleOfficeCode+"'  AND SUBSTR(SCHEME_CODE,6,2)='"+mandalCode+
			 * "') as mpwsCount,";
			 * 
			 * ///CPWS COUNT query+=
			 * "(select count(*) from RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE"
			 * + " M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='03'" +
			 * " and m.asset_code is not null  AND SUBSTR(SCHEME_CODE,1,2)='"
			 * +circleOfficeCode
			 * +"'  AND SUBSTR(SCHEME_CODE,6,2)='"+mandalCode+"') as cpwsCount,"
			 * ;
			 * 
			 * ///HAND PUMPS COUNT query+=
			 * "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_HP_SUBCOMP_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
			 * +
			 * "AND M.TYPE_OF_ASSET_CODE='04' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '0%'  AND SUBSTR(SCHEME_CODE,1,2)='"
			 * +circleOfficeCode+"'  AND SUBSTR(SCHEME_CODE,6,2)='"+mandalCode+
			 * "')as hpCount,";
			 * 
			 * ///SHALLOW HANDPUMPS COUNT query+=
			 * "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_SHALLOWHANDPUMPS_TBL "
			 * +
			 * "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
			 * +
			 * " AND M.TYPE_OF_ASSET_CODE='05' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND "
			 * +
			 * "SUBSTR(S.SCHEME_CODE,17,3) LIKE '3%'  AND SUBSTR(SCHEME_CODE,1,2)='"
			 * +circleOfficeCode+"'  AND SUBSTR(SCHEME_CODE,6,2)='"+mandalCode+
			 * "')as shpCount, ";
			 * 
			 * ///OPEN WELLS COUNT query+=
			 * "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPEN_WELL_MAST_TBL  "
			 * +
			 * "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
			 * +
			 * " AND M.TYPE_OF_ASSET_CODE='06' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND "
			 * +
			 * "SUBSTR(S.SCHEME_CODE,17,3) LIKE '2%'  AND SUBSTR(SCHEME_CODE,1,2)='"
			 * +circleOfficeCode+"'  AND SUBSTR(SCHEME_CODE,6,2)='"+mandalCode+
			 * "')as openWellsCount, ";
			 * 
			 * ///PONDS COUNT query+=
			 * "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPENWELL_POND_TBL  "
			 * +
			 * "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
			 * +
			 * " AND M.TYPE_OF_ASSET_CODE='07' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND "
			 * +
			 * "SUBSTR(S.SCHEME_CODE,17,3) LIKE '7%'  AND SUBSTR(SCHEME_CODE,1,2)='"
			 * +circleOfficeCode+"'  AND SUBSTR(SCHEME_CODE,6,2)='"+mandalCode+
			 * "')as pondsCount ";
			 */

			// /PWS COUNT
			query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE "
					+ "M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='01' AND SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode
					+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
					+ mandalCode + "') as pwsCount,";

			// MPWS COUNT
			query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE"
					+ " M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='02' AND SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode
					+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
					+ mandalCode + "') as mpwsCount,";

			// /CPWS COUNT
			query += "(select count(*) from RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE"
					+ " M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='03'"
					+ " AND SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode
					+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
					+ mandalCode
					+ "') as cpwsCount,";

			// /HAND PUMPS COUNT
			query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S WHERE M.ASSET_CODE=S.ASSET_CODE "
					+ " AND M.TYPE_OF_ASSET_CODE='04' AND SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode
					+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
					+ mandalCode + "')as hpCount,";

			// /SHALLOW HANDPUMPS COUNT
			query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S WHERE M.ASSET_CODE=S.ASSET_CODE "
					+ " AND M.TYPE_OF_ASSET_CODE='05' AND "
					+ " SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode
					+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
					+ mandalCode
					+ "')as shpCount, ";

			// /OPEN WELLS COUNT
			query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S WHERE M.ASSET_CODE=S.ASSET_CODE "
					+ " AND M.TYPE_OF_ASSET_CODE='06' AND "
					+ " SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode
					+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
					+ mandalCode
					+ "')as openWellsCount, ";

			// /PONDS COUNT
			query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S WHERE  M.ASSET_CODE=S.ASSET_CODE "
					+ " AND M.TYPE_OF_ASSET_CODE='07' AND "
					+ " SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode
					+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
					+ mandalCode
					+ "')as pondsCount ";

			query += " from dual";

			Debug.println("query is " + query);
			PreparedStatement ps1 = conn.prepareStatement(query);
			ResultSet rs1 = ps1.executeQuery();
			count = new rws_asset_CheckList_Bean();
			while (rs1.next()) {
				count.setPwsCount(rs1.getString("pwsCount") + "");
				count.setMpwsCount(rs1.getString("mpwsCount") + "");
				count.setCpwsCount(rs1.getString("cpwsCount") + "");
				count.setHandPumpCount(rs1.getString("hpCount") + "");
				count.setShallowHandPumps(rs1.getString("shpCount") + "");
				count.setOpenWells(rs1.getString("openWellsCount") + "");
				count.setPonds(rs1.getString("pondsCount") + "");
			}

			counts.add(count);
			rs1.close();

		} catch (Exception e) {
			Debug.println("Exception while geting circles" + e);
		} finally {
			try {
				if (conn != null) {

					conn.close();
				}
			} catch (SQLException e) {
				Debug.println("Exception " + e);
			}
		}
		return counts;
	}

	public static ArrayList getAssetCounts(DataSource datasource,
			String circleOfficeCode, String mandalCode, String panchayatCode)
			throws Exception {
		Connection conn = null;
		ArrayList counts = null;
		rws_asset_CheckList_Bean count = null;
		try {
			counts = new ArrayList();
			Debug.println("in getCounts 3 ");
			String query = "";
			conn = RwsOffices.getConn();

			query = "select ";

			// /PWS COUNT
			query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE "
					+ "M.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,17,3) LIKE '6%' AND M.TYPE_OF_ASSET_CODE='01' AND SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode
					+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
					+ mandalCode
					+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
					+ panchayatCode + "') as pwsCount,";

			// MPWS COUNT
			query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE"
					+ " M.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,17,3) LIKE '4%' AND M.TYPE_OF_ASSET_CODE='02' AND SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode
					+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
					+ mandalCode
					+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
					+ panchayatCode + "') as mpwsCount,";

			// /CPWS COUNT
			query += "(select count(*) from RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE"
					+ " M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='03'"
					+ " AND SUBSTR(SCHEME_CODE,17,3) LIKE '8%' AND SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode
					+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
					+ mandalCode + "') as cpwsCount,";

			// /HAND PUMPS COUNT
			query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S WHERE  M.ASSET_CODE=S.ASSET_CODE "
					+ "AND M.TYPE_OF_ASSET_CODE='04' and (SUBSTR(S.SCHEME_CODE,17,3) LIKE '0%' or SUBSTR(S.SCHEME_CODE,17,3) LIKE '1%' or SUBSTR(S.SCHEME_CODE,17,3) LIKE '2%')  AND SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode
					+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
					+ mandalCode
					+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
					+ panchayatCode + "')as hpCount,";

			// /SHALLOW HANDPUMPS COUNT
			query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S "
					+ " WHERE  M.ASSET_CODE=S.ASSET_CODE "
					+ " AND M.TYPE_OF_ASSET_CODE='05' AND "
					+ "SUBSTR(S.SCHEME_CODE,17,3) LIKE '3%'  AND SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode
					+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
					+ mandalCode
					+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
					+ panchayatCode + "')as shpCount, ";

			// /OPEN WELLS COUNT
			query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S"
					+ " WHERE M.ASSET_CODE=S.ASSET_CODE "
					+ " AND M.TYPE_OF_ASSET_CODE='06' AND "
					+ "SUBSTR(S.SCHEME_CODE,17,3) LIKE '5%'  AND SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode
					+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
					+ mandalCode
					+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
					+ panchayatCode + "')as openWellsCount, ";

			// /PONDS COUNT
			query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S"
					+ " WHERE M.ASSET_CODE=S.ASSET_CODE "
					+ " AND M.TYPE_OF_ASSET_CODE='07' AND "
					+ "SUBSTR(S.SCHEME_CODE,17,3) LIKE '7%'  AND SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode
					+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
					+ mandalCode
					+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
					+ panchayatCode + "')as pondsCount ";

			query += " from dual";

			Debug.println("query is " + query);
			PreparedStatement ps1 = conn.prepareStatement(query);
			ResultSet rs1 = ps1.executeQuery();
			count = new rws_asset_CheckList_Bean();
			while (rs1.next()) {
				count.setPwsCount(rs1.getString("pwsCount") + "");
				count.setMpwsCount(rs1.getString("mpwsCount") + "");
				count.setCpwsCount(rs1.getString("cpwsCount") + "");
				count.setHandPumpCount(rs1.getString("hpCount") + "");
				count.setShallowHandPumps(rs1.getString("shpCount") + "");
				count.setOpenWells(rs1.getString("openWellsCount") + "");
				count.setPonds(rs1.getString("pondsCount") + "");
			}

			counts.add(count);
			rs1.close();

		} catch (Exception e) {
			Debug.println("Exception while geting circles" + e);
		} finally {
			try {
				if (conn != null) {

					conn.close();
				}
			} catch (SQLException e) {
				Debug.println("Exception " + e);
			}
		}
		return counts;
	}

	public static ArrayList getAssetCounts(DataSource datasource,
			String circleOfficeCode, String mandalCode, String panchayatCode,
			String villageCode) throws Exception {
		Connection conn = null;
		ArrayList counts = null;
		rws_asset_CheckList_Bean count = null;
		try {
			counts = new ArrayList();
			Debug.println("in getCounts 1");
			String query = "";
			conn = conn = RwsOffices.getConn();

			query = "select ";

			// /PWS COUNT
			query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE "
					+ "M.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,17,3) LIKE '6%' AND M.TYPE_OF_ASSET_CODE='01' AND SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode
					+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
					+ mandalCode
					+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
					+ panchayatCode
					+ "'  AND SUBSTR(SCHEME_CODE,8,3)='"
					+ villageCode + "') as pwsCount,";

			// MPWS COUNT
			query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE"
					+ " M.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,17,3) LIKE '4%' AND M.TYPE_OF_ASSET_CODE='02' AND SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode
					+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
					+ mandalCode
					+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
					+ panchayatCode
					+ "'  AND SUBSTR(SCHEME_CODE,8,3)='"
					+ villageCode + "') as mpwsCount,";

			// /CPWS COUNT
			query += "(select count(*) from RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE"
					+ " M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='03'"
					+ " AND SUBSTR(SCHEME_CODE,17,3) LIKE '8%' AND SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode
					+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
					+ mandalCode
					+ "'  AND SUBSTR(SCHEME_CODE,8,3)='"
					+ villageCode + "') as cpwsCount,";

			// /HAND PUMPS COUNT
			query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S WHERE  M.ASSET_CODE=S.ASSET_CODE "
					+ "AND M.TYPE_OF_ASSET_CODE='04'  and (SUBSTR(S.SCHEME_CODE,17,3) LIKE '0%' or SUBSTR(S.SCHEME_CODE,17,3) LIKE '1%' or SUBSTR(S.SCHEME_CODE,17,3) LIKE '2%')  AND SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode
					+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
					+ mandalCode
					+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
					+ panchayatCode
					+ "'  AND SUBSTR(SCHEME_CODE,8,3)='"
					+ villageCode + "')as hpCount,";

			// /SHALLOW HANDPUMPS COUNT
			query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S WHERE M.ASSET_CODE=S.ASSET_CODE "
					+ " AND M.TYPE_OF_ASSET_CODE='05'  AND "
					+ "SUBSTR(S.SCHEME_CODE,17,3) LIKE '3%'  AND SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode
					+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
					+ mandalCode
					+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
					+ panchayatCode
					+ "'  AND SUBSTR(SCHEME_CODE,8,3)='"
					+ villageCode + "')as shpCount, ";

			// /OPEN WELLS COUNT
			query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S"
					+ " WHERE M.ASSET_CODE=S.ASSET_CODE "
					+ " AND M.TYPE_OF_ASSET_CODE='06' AND "
					+ "SUBSTR(S.SCHEME_CODE,17,3) LIKE '5%'  AND SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode
					+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
					+ mandalCode
					+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
					+ panchayatCode
					+ "'  AND SUBSTR(SCHEME_CODE,8,3)='"
					+ villageCode + "')as openWellsCount, ";

			// /PONDS COUNT
			query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S"
					+ " WHERE M.ASSET_CODE=S.ASSET_CODE "
					+ " AND M.TYPE_OF_ASSET_CODE='07' AND "
					+ "SUBSTR(S.SCHEME_CODE,17,3) LIKE '7%'  AND SUBSTR(SCHEME_CODE,1,2)='"
					+ circleOfficeCode
					+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
					+ mandalCode
					+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
					+ panchayatCode
					+ "'  AND SUBSTR(SCHEME_CODE,8,3)='"
					+ villageCode + "')as pondsCount ";

			query += " from dual";

			Debug.println("query is " + query);
			PreparedStatement ps1 = conn.prepareStatement(query);
			ResultSet rs1 = ps1.executeQuery();
			count = new rws_asset_CheckList_Bean();
			while (rs1.next()) {
				count.setPwsCount(rs1.getString("pwsCount") + "");
				count.setMpwsCount(rs1.getString("mpwsCount") + "");
				count.setCpwsCount(rs1.getString("cpwsCount") + "");
				count.setHandPumpCount(rs1.getString("hpCount") + "");
				count.setShallowHandPumps(rs1.getString("shpCount") + "");
				count.setOpenWells(rs1.getString("openWellsCount") + "");
				count.setPonds(rs1.getString("pondsCount") + "");
			}

			counts.add(count);
			rs1.close();

		} catch (Exception e) {
			Debug.println("Exception while geting circles" + e);
		} finally {
			try {
				if (conn != null) {

					conn.close();
				}
			} catch (SQLException e) {
				Debug.println("Exception " + e);
			}
		}
		return counts;
	}

	// used
	public static ArrayList getAssetCounts(DataSource datasource,
			String circleOfficeCode, String mandalCode, String panchayatCode,
			String villageCode, String habitationCode) throws Exception {
		Connection conn = null;
		ArrayList counts = null;
		rws_asset_CheckList_Bean count = null;
		try {
			counts = new ArrayList();
			Debug.println("in getCounts 2");
			String query = "";
			conn = RwsOffices.getConn();

			if ((circleOfficeCode != null && !circleOfficeCode.equals(""))
					&& (mandalCode != null && !mandalCode.equals(""))
					&& (panchayatCode != null && !panchayatCode.equals(""))
					&& (villageCode != null && !villageCode.equals(""))
					&& (habitationCode != null && !habitationCode.equals(""))) {
				query = "select ";

				// /PWS COUNT
				query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE "
						+ "M.ASSET_CODE=S.ASSET_CODE AND  M.TYPE_OF_ASSET_CODE='01' AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode
						+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
						+ panchayatCode
						+ "'  AND SUBSTR(SCHEME_CODE,8,3)='"
						+ villageCode
						+ "'  AND SUBSTR(SCHEME_CODE,1,16)='"
						+ habitationCode + "') as pwsCount,";

				// MPWS COUNT
				query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE"
						+ " M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='02' AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode
						+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
						+ panchayatCode
						+ "'  AND SUBSTR(SCHEME_CODE,8,3)='"
						+ villageCode
						+ "'  AND SUBSTR(SCHEME_CODE,1,16)='"
						+ habitationCode + "') as mpwsCount,";

				// /CPWS COUNT
				query += "(select count(*) from RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE"
						+ " M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='03' AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode
						+ "'  AND SUBSTR(SCHEME_CODE,13,2)='"
						+ panchayatCode
						+ "' AND SUBSTR(SCHEME_CODE,8,3)='"
						+ villageCode
						+ "' AND SUBSTR(SCHEME_CODE,1,16)='"
						+ habitationCode + "') as cpwsCount,";// code added AND
																// SUBSTR(SCHEME_CODE,13,2)='"+panchayatCode+"'

				// /HAND PUMPS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_HP_SUBCOMP_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='04' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode
						+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
						+ panchayatCode
						+ "'  AND SUBSTR(SCHEME_CODE,8,3)='"
						+ villageCode
						+ "'  AND SUBSTR(SCHEME_CODE,1,16)='"
						+ habitationCode + "')as hpCount,";

				// /SHALLOW HANDPUMPS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_SHALLOWHANDPUMPS_TBL "
						+ "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='05' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode
						+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
						+ panchayatCode
						+ "'  AND SUBSTR(SCHEME_CODE,8,3)='"
						+ villageCode
						+ "'  AND SUBSTR(SCHEME_CODE,1,16)='"
						+ habitationCode + "')as shpCount, ";

				// /OPEN WELLS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPEN_WELL_MAST_TBL  "
						+ "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='06' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode
						+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
						+ panchayatCode
						+ "'  AND SUBSTR(SCHEME_CODE,8,3)='"
						+ villageCode
						+ "'  AND SUBSTR(SCHEME_CODE,1,16)='"
						+ habitationCode + "')as openWellsCount, ";

				// /PONDS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPENWELL_POND_TBL  "
						+ "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='07' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode
						+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
						+ panchayatCode
						+ "'  AND SUBSTR(SCHEME_CODE,8,3)='"
						+ villageCode
						+ "'  AND SUBSTR(SCHEME_CODE,1,16)='"
						+ habitationCode + "')as pondsCount, ";

				// Direct Pumping Count added by sridhar
				query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE"
						+ " M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='09' AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode
						+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
						+ panchayatCode
						+ "'  AND SUBSTR(SCHEME_CODE,8,3)='"
						+ villageCode
						+ "'  AND SUBSTR(SCHEME_CODE,1,16)='"
						+ habitationCode + "') as dpCount ";

				query += " from dual";

				Debug.println("query " + query);
			} else if ((circleOfficeCode != null && !circleOfficeCode
					.equals(""))
					&& (mandalCode != null && !mandalCode.equals(""))
					&& (panchayatCode != null && !panchayatCode.equals(""))
					&& (villageCode != null && !villageCode.equals(""))
					&& (habitationCode == null || habitationCode.equals(""))) {
				query = "select ";

				// /PWS COUNT
				query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE "
						+ "M.ASSET_CODE=S.ASSET_CODE AND  M.TYPE_OF_ASSET_CODE='01' AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode
						+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
						+ panchayatCode
						+ "'  AND SUBSTR(SCHEME_CODE,8,3)='"
						+ villageCode + "') as pwsCount,";

				// MPWS COUNT
				query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE"
						+ " M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='02' AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode
						+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
						+ panchayatCode
						+ "'  AND SUBSTR(SCHEME_CODE,8,3)='"
						+ villageCode + "') as mpwsCount,";

				// /CPWS COUNT
				query += "(select count(*) from RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE"
						+ " M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='03'  AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode
						+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
						+ panchayatCode
						+ "'  AND SUBSTR(SCHEME_CODE,8,3)='"
						+ villageCode + "') as cpwsCount,";// code added AND
															// SUBSTR(SCHEME_CODE,13,2)='"+panchayatCode+"'

				// /HAND PUMPS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_HP_SUBCOMP_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='04' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode
						+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
						+ panchayatCode
						+ "'  AND SUBSTR(SCHEME_CODE,8,3)='"
						+ villageCode + "')as hpCount,";

				// /SHALLOW HANDPUMPS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_SHALLOWHANDPUMPS_TBL "
						+ "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='05' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode
						+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
						+ panchayatCode
						+ "'  AND SUBSTR(SCHEME_CODE,8,3)='"
						+ villageCode + "')as shpCount, ";

				// /OPEN WELLS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPEN_WELL_MAST_TBL  "
						+ "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='06' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode
						+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
						+ panchayatCode
						+ "'  AND SUBSTR(SCHEME_CODE,8,3)='"
						+ villageCode + "')as openWellsCount, ";

				// /PONDS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPENWELL_POND_TBL  "
						+ "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='07' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode
						+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
						+ panchayatCode
						+ "'  AND SUBSTR(SCHEME_CODE,8,3)='"
						+ villageCode + "')as pondsCount, ";

				// Direct Pumping Count added by sridhar
				query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE"
						+ " M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='09' AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode
						+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
						+ panchayatCode
						+ "'  AND SUBSTR(SCHEME_CODE,8,3)='"
						+ villageCode + "') as dpCount ";

				query += " from dual";
				Debug.println("queryA " + query);

			} else if ((circleOfficeCode != null && !circleOfficeCode
					.equals(""))
					&& (mandalCode != null && !mandalCode.equals(""))
					&& (panchayatCode != null && !panchayatCode.equals(""))
					&& (villageCode == null || villageCode.equals(""))
					&& (habitationCode == null || habitationCode.equals(""))) {
				query = "select ";

				// /PWS COUNT
				query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE "
						+ "M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='01' AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode
						+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
						+ panchayatCode + "') as pwsCount,";

				// MPWS COUNT
				query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE"
						+ " M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='02' AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode
						+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
						+ panchayatCode + "') as mpwsCount,";

				// /CPWS COUNT
				query += "(select count(*) from RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE "
						+ "M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='03' AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode
						+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
						+ panchayatCode + "') as cpwsCount,";// CODE ADDED AND
																// SUBSTR(SCHEME_CODE,13,2)='"+panchayatCode+"'

				// /HAND PUMPS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_HP_SUBCOMP_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='04' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode
						+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
						+ panchayatCode + "')as hpCount,";

				// /SHALLOW HANDPUMPS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_SHALLOWHANDPUMPS_TBL "
						+ "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='05' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND  SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode
						+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
						+ panchayatCode + "')as shpCount, ";

				// /OPEN WELLS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPEN_WELL_MAST_TBL  "
						+ "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='06' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode
						+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
						+ panchayatCode + "')as openWellsCount, ";

				// /PONDS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPENWELL_POND_TBL  "
						+ "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='07' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode
						+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
						+ panchayatCode + "')as pondsCount, ";

				// Direct Pumping Count added by sridhar
				query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE"
						+ " M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='09' AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode
						+ "' AND SUBSTR(SCHEME_CODE,13,2)='"
						+ panchayatCode + "') as dpCount ";

				query += " from dual";

				Debug.println("queryB " + query);
			} else if ((circleOfficeCode != null && !circleOfficeCode
					.equals(""))
					&& (mandalCode != null && !mandalCode.equals(""))
					&& (panchayatCode == null || panchayatCode.equals(""))
					&& (villageCode == null || villageCode.equals(""))
					&& (habitationCode == null || habitationCode.equals(""))) {
				query = "select ";

				// /PWS COUNT
				query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE "
						+ "M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='01' AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode + "') as pwsCount,";

				// MPWS COUNT
				query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE "
						+ "M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='02' AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode + "') as mpwsCount,";

				// /CPWS COUNT
				query += "(select count(*) from RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE "
						+ "M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='03'  AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode + "') as cpwsCount,";

				// /HAND PUMPS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_HP_SUBCOMP_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='04' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode + "')as hpCount,";

				// /SHALLOW HANDPUMPS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_SHALLOWHANDPUMPS_TBL "
						+ "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='05' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode + "')as shpCount, ";

				// /OPEN WELLS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPEN_WELL_MAST_TBL  "
						+ "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='06' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode + "')as openWellsCount, ";

				// /PONDS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPENWELL_POND_TBL  "
						+ "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='07' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode + "')as pondsCount, ";

				// Direct Pumping Count added by sridhar
				query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE"
						+ " M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='09' AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "'  AND SUBSTR(SCHEME_CODE,6,2)='"
						+ mandalCode + "') as dpCount ";

				query += " from dual";

				Debug.println("queryC " + query);
			} else if ((circleOfficeCode != null && !circleOfficeCode
					.equals(""))
					&& (mandalCode == null || mandalCode.equals(""))
					&& (panchayatCode == null || panchayatCode.equals(""))
					&& (villageCode == null || villageCode.equals(""))
					&& (habitationCode == null || habitationCode.equals(""))) {
				query = "select ";

				// /PWS COUNT
				query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE "
						+ "M.ASSET_CODE=S.ASSET_CODE AND  M.TYPE_OF_ASSET_CODE='01' AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode + "') as pwsCount,";

				// MPWS COUNT
				query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE"
						+ " M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='02' AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode + "') as mpwsCount,";

				// /CPWS COUNT
				query += "(select count(*) from RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S  WHERE "
						+ "M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='03' AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode + "') as cpwsCount, ";

				// /HAND PUMPS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_HP_SUBCOMP_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='04' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode + "')as hpCount, ";

				// /SHALLOW HANDPUMPS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_SHALLOWHANDPUMPS_TBL "
						+ "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='05' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode + "')as shpCount, ";

				// /OPEN WELLS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPEN_WELL_MAST_TBL  "
						+ "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='06' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode + "')as openWellsCount, ";

				// /PONDS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPENWELL_POND_TBL  "
						+ "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='07' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode + "')as pondsCount, ";
				//
				// Direct Pumping Count added by sridhar
				query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE"
						+ " M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='09' AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode + "') as dpCount ";

				query += " from dual";

				Debug.println("queryD " + query);
			} else if ((circleOfficeCode == null || circleOfficeCode.equals(""))
					&& (mandalCode == null || mandalCode.equals(""))
					&& (panchayatCode == null || panchayatCode.equals(""))
					&& (villageCode == null || villageCode.equals(""))
					&& (habitationCode == null || habitationCode.equals(""))) {
				query = "select ";

				// /PWS COUNT
				query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE "
						+ "M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='01' ) as pwsCount,";

				// MPWS COUNT
				query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE "
						+ " M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='02' ) as mpwsCount,";

				// /CPWS COUNT
				query += "(select count(*) from RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S  WHERE "
						+ "M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='03' ) as cpwsCount,";

				// /HAND PUMPS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_HP_SUBCOMP_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='04' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE )as hpCount,";

				// /SHALLOW HANDPUMPS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_SHALLOWHANDPUMPS_TBL "
						+ "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='05' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE )as shpCount, ";

				// /OPEN WELLS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPEN_WELL_MAST_TBL  "
						+ "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='06' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE)as openWellsCount, ";

				// /PONDS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPENWELL_POND_TBL  "
						+ "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='07' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE )as pondsCount, ";

				// Direct Pumping Count added by sridhar
				query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE"
						+ " M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='09') as dpCount ";

				query += " from dual";

				Debug.println("queryE " + query);
			}
			Debug.println("query is " + query);
			PreparedStatement ps1 = conn.prepareStatement(query);
			ResultSet rs1 = ps1.executeQuery();
			count = new rws_asset_CheckList_Bean();
			while (rs1.next()) {
				count.setPwsCount(rs1.getString("pwsCount") + "");
				count.setMpwsCount(rs1.getString("mpwsCount") + "");
				count.setCpwsCount(rs1.getString("cpwsCount") + "");
				count.setHandPumpCount(rs1.getString("hpCount") + "");
				count.setShallowHandPumps(rs1.getString("shpCount") + "");
				count.setOpenWells(rs1.getString("openWellsCount") + "");
				count.setPonds(rs1.getString("pondsCount") + "");
				count.setDpCount(rs1.getString("dpCount") + "");
			}

			counts.add(count);
			rs1.close();

		} catch (Exception e) {
			Debug.println("Exception while geting circles" + e);
		} finally {
			try {
				if (conn != null) {

					conn.close();
				}
			} catch (SQLException e) {
				Debug.println("Exception " + e);
			}
		}
		return counts;
	}

	// used code added by sridhar for Division wise count
	public static ArrayList getAssetCounts1(DataSource datasource,
			String circleOfficeCode, String divisionOfficeCode,
			String mandalCode, String panchayatCode, String villageCode,
			String habitationCode) throws Exception {
		Connection conn = null;
		ArrayList counts = null;
		rws_asset_CheckList_Bean count = null;
		try {
			counts = new ArrayList();
			Debug.println("in getCounts 1 method ");
			String query = "";
			conn = RwsOffices.getConn();

			if ((circleOfficeCode != null && !circleOfficeCode.equals(""))
					&& (divisionOfficeCode != null && !divisionOfficeCode
							.equals(""))) {
				query = "select ";

				// /PWS COUNT
				query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE "
						+ "M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='01' AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' and division_office_code='"
						+ divisionOfficeCode + "' ) as pwsCount,";

				// MPWS COUNT
				query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE"
						+ " M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='02' AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' and division_office_code='"
						+ divisionOfficeCode + "') as mpwsCount,";

				// /CPWS COUNT
				query += "(select count(*) from RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S  WHERE "
						+ "M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='03' AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' and division_office_code='"
						+ divisionOfficeCode + "') as cpwsCount, ";

				// /HAND PUMPS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_HP_SUBCOMP_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='04' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' and division_office_code='"
						+ divisionOfficeCode + "')as hpCount, ";

				// /SHALLOW HANDPUMPS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_SHALLOWHANDPUMPS_TBL "
						+ "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='05' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE  AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' and division_office_code='"
						+ divisionOfficeCode + "')as shpCount, ";

				// /OPEN WELLS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPEN_WELL_MAST_TBL  "
						+ "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='06' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' and division_office_code='"
						+ divisionOfficeCode + "')as openWellsCount, ";

				// /PONDS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPENWELL_POND_TBL  "
						+ "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='07' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' and division_office_code='"
						+ divisionOfficeCode + "')as pondsCount, ";

				// Direct Pumping Count added by sridhar
				query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE"
						+ " M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='09' AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' and division_office_code='"
						+ divisionOfficeCode + "') as dpCount ";

				query += " from dual";

				Debug.println("queryD " + query);
			}

			Debug.println("query is " + query);
			PreparedStatement ps1 = conn.prepareStatement(query);
			ResultSet rs1 = ps1.executeQuery();
			count = new rws_asset_CheckList_Bean();
			while (rs1.next()) {
				count.setPwsCount(rs1.getString("pwsCount") + "");
				count.setMpwsCount(rs1.getString("mpwsCount") + "");
				count.setCpwsCount(rs1.getString("cpwsCount") + "");
				count.setHandPumpCount(rs1.getString("hpCount") + "");
				count.setShallowHandPumps(rs1.getString("shpCount") + "");
				count.setOpenWells(rs1.getString("openWellsCount") + "");
				count.setPonds(rs1.getString("pondsCount") + "");
				count.setDpCount(rs1.getString("dpCount") + "");
			}

			counts.add(count);
			rs1.close();

		} catch (Exception e) {
			Debug.println("Exception while geting Divisions" + e);
		} finally {
			try {
				if (conn != null) {

					conn.close();
				}
			} catch (SQLException e) {
				Debug.println("Exception " + e);
			}
		}
		return counts;
	}

	// code end
	// used code for sub div count
	public static ArrayList getAssetCounts2(DataSource datasource,
			String circleOfficeCode, String divisionOfficeCode,
			String subdivisionOfficeCode, String mandalCode,
			String panchayatCode, String villageCode, String habitationCode)
			throws Exception {
		Connection conn = null;
		ArrayList counts = null;
		rws_asset_CheckList_Bean count = null;
		try {
			counts = new ArrayList();
			Debug.println("in getCounts 2 method ");
			String query = "";
			conn = RwsOffices.getConn();

			if ((circleOfficeCode != null && !circleOfficeCode.equals(""))
					&& (divisionOfficeCode != null && !divisionOfficeCode
							.equals(""))
					&& (subdivisionOfficeCode != null && !subdivisionOfficeCode
							.equals(""))) {
				query = "select ";

				// /PWS COUNT
				query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE "
						+ "M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='01' AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' and division_office_code='"
						+ divisionOfficeCode
						+ "' and subdivision_office_code='"
						+ subdivisionOfficeCode + "' ) as pwsCount,";

				// MPWS COUNT
				query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE"
						+ " M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='02' AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' and division_office_code='"
						+ divisionOfficeCode
						+ "' and subdivision_office_code='"
						+ subdivisionOfficeCode + "') as mpwsCount,";

				// /CPWS COUNT
				query += "(select count(*) from RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S  WHERE "
						+ "M.ASSET_CODE=S.ASSET_CODE AND M.TYPE_OF_ASSET_CODE='03'  AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' and division_office_code='"
						+ divisionOfficeCode
						+ "' and subdivision_office_code='"
						+ subdivisionOfficeCode + "') as cpwsCount, ";

				// /HAND PUMPS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_HP_SUBCOMP_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='04' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' and division_office_code='"
						+ divisionOfficeCode
						+ "' and subdivision_office_code='"
						+ subdivisionOfficeCode + "')as hpCount, ";

				// /SHALLOW HANDPUMPS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_SHALLOWHANDPUMPS_TBL "
						+ "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='05' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' and division_office_code='"
						+ divisionOfficeCode
						+ "' and subdivision_office_code='"
						+ subdivisionOfficeCode + "' )as shpCount, ";

				// /OPEN WELLS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPEN_WELL_MAST_TBL  "
						+ "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='06' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' and division_office_code='"
						+ divisionOfficeCode
						+ "' and subdivision_office_code='"
						+ subdivisionOfficeCode + "')as openWellsCount, ";

				// /PONDS COUNT
				query += "(select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_OPENWELL_POND_TBL  "
						+ "subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='07' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND  SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' and division_office_code='"
						+ divisionOfficeCode
						+ "' and subdivision_office_code='"
						+ subdivisionOfficeCode + "')as pondsCount, ";

				// DIRECT PUMPING COUNT added by sridhar
				query += "(SELECT COUNT(*) FROM RWS_ASSET_MAST_TBL M,RWS_ASSET_SCHEME_TBL S WHERE"
						+ " M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='09' AND SUBSTR(SCHEME_CODE,1,2)='"
						+ circleOfficeCode
						+ "' and division_office_code='"
						+ divisionOfficeCode
						+ "' and subdivision_office_code='"
						+ subdivisionOfficeCode + "') as dpCount ";

				query += " from dual";

				Debug.println("queryD " + query);
			}

			Debug.println("subdivquery is " + query);
			PreparedStatement ps1 = conn.prepareStatement(query);
			ResultSet rs1 = ps1.executeQuery();
			count = new rws_asset_CheckList_Bean();
			while (rs1.next()) {
				count.setPwsCount(rs1.getString("pwsCount") + "");
				count.setMpwsCount(rs1.getString("mpwsCount") + "");
				count.setCpwsCount(rs1.getString("cpwsCount") + "");
				count.setHandPumpCount(rs1.getString("hpCount") + "");
				count.setShallowHandPumps(rs1.getString("shpCount") + "");
				count.setOpenWells(rs1.getString("openWellsCount") + "");
				count.setPonds(rs1.getString("pondsCount") + "");
				count.setDpCount(rs1.getString("dpCount") + "");
			}

			counts.add(count);
			rs1.close();

		} catch (Exception e) {
			Debug.println("Exception while geting Sub Divisions count " + e);
		} finally {
			try {
				if (conn != null) {

					conn.close();
				}
			} catch (SQLException e) {
				Debug.println("Exception " + e);
			}
		}
		return counts;
	}

	// code end
	// used
	public static String getDivisions(DataSource dataSource,
			String headOfficeCode, String circleOfficeCode) throws Exception {
		Connection conn = null;
		StringBuffer buffer = new StringBuffer();
		try {

			conn = RwsOffices.getConn();
			String query = " SELECT division_office_name, division_office_code "
					+ " FROM rws_division_office_tbl "
					+ " WHERE head_office_code = '"
					+ headOfficeCode
					+ "' "
					+ " AND circle_office_code = '"
					+ circleOfficeCode
					+ "' "
					+ " ORDER BY division_office_name ";
			PreparedStatement ps = conn.prepareStatement(query,
					ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			Debug.println("query is:**" + query);
			ResultSet rs = ps.executeQuery();
			rs.last();
			int rowCount = rs.getRow();
			if (rowCount == 0) {
				buffer.append("<//>");
			} else {
				rs.beforeFirst();

				while (rs.next()) {
					buffer.append(rs.getString(1) + "<>");
					buffer.append(rs.getString(2) + "</>");
				}
				buffer.append("<//>");

				query = "SELECT DNAME,DCODE FROM RWS_DISTRICT_TBL WHERE DCODE='"
						+ circleOfficeCode + "'";
				Debug.println("query is:**" + query);

				PreparedStatement ps1 = conn.prepareStatement(query);
				ResultSet rs1 = ps1.executeQuery();
				while (rs1.next()) {
					buffer.append(rs1.getString(1) + "<>");
					buffer.append(rs1.getString(2) + "</>");
				}
				buffer.append("<//>");

				query = "SELECT MNAME,MCODE FROM RWS_MANDAL_TBL WHERE DCODE='"
						+ circleOfficeCode + "' order by MNAME";
				Debug.println("query is:**" + query);
				PreparedStatement ps2 = conn.prepareStatement(query);
				ResultSet rs2 = ps2.executeQuery();
				while (rs2.next()) {
					buffer.append(rs2.getString(1) + "<>");
					buffer.append(rs2.getString(2) + "</>");
				}

			}

		}

		catch (Exception e) {
			Debug.println("Exception ..while getting divisions:" + e);
		}

		finally {
			try {
				if (conn != null) {

					conn.close();
				}
			} catch (SQLException e) {
				Debug.println("Exception " + e);
			}
		}
		return buffer.toString();

	}

	public static String getDivisions1(DataSource dataSource,
			String headOfficeCode, String circleOfficeCode) throws Exception {
		Connection conn = null;
		StringBuffer buffer = new StringBuffer();
		try {

			conn = RwsOffices.getConn();
			buffer.append("<//>");
			String query = "SELECT MNAME,MCODE FROM RWS_MANDAL_TBL WHERE DCODE='"
					+ circleOfficeCode + "' order by MNAME";
			Debug.println("query is:**" + query);
			PreparedStatement ps2 = conn.prepareStatement(query);
			ResultSet rs2 = ps2.executeQuery();
			while (rs2.next()) {
				buffer.append(rs2.getString(1) + "<>");
				buffer.append(rs2.getString(2) + "</>");
			}
		}

		catch (Exception e) {
			Debug.println("Exception ..while getting divisions:" + e);
		}

		finally {
			try {
				if (conn != null) {

					conn.close();
				}
			} catch (SQLException e) {
				Debug.println("Exception " + e);
			}
		}
		return buffer.toString();

	}

	// used
	public static String getSubDivisions(DataSource dataSource,
			String headOfficeCode, String circleOfficeCode,
			String divisionOfficeCode) {
		Connection conn = null;
		StringBuffer buffer = new StringBuffer();
		try {
			conn = RwsOffices.getConn();
			String query = " SELECT subdivision_office_name, subdivision_office_code "
					+ " FROM rws_subdivision_office_tbl "
					+ " WHERE head_office_code = '"
					+ headOfficeCode
					+ "' "
					+ " AND circle_office_code = '"
					+ circleOfficeCode
					+ "' "

					+ " AND division_office_code = '"
					+ divisionOfficeCode
					+ "' "

					+ " ORDER BY subdivision_office_name ";
			PreparedStatement ps = conn.prepareStatement(query,
					ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			Debug.println("query is:**" + query);
			ResultSet rs = ps.executeQuery();
			rs.last();
			int rowCount = rs.getRow();
			if (rowCount == 0) {

			} else {
				rs.beforeFirst();

				while (rs.next()) {
					buffer.append(rs.getString(1) + "<>");
					buffer.append(rs.getString(2) + "</>");
				}

				buffer.append("<//>");
				if (divisionOfficeCode != null
						&& !divisionOfficeCode.equals("")) {
					query = "SELECT  M.MNAME ,M.MCODE FROM RWS_MANDAL_TBL M, RWS_MANDAL_SUBDIVISION_TBL MM"
							+ " WHERE M.DCODE=MM.DCODE AND M.MCODE=MM.MCODE AND MM.CIRCLE_OFFICE_CODE='"
							+ circleOfficeCode
							+ "'"
							+ "AND MM.DIVISION_OFFICE_CODE='"
							+ divisionOfficeCode + "' ORDER BY MNAME";

					Debug.println("query is:**" + query);
					PreparedStatement ps1 = conn.prepareStatement(query);
					ResultSet rs1 = ps1.executeQuery();
					while (rs1.next()) {
						buffer.append(rs1.getString(1) + "<>");
						buffer.append(rs1.getString(2) + "</>");
					}
					rs1.close();
					ps1.close();
				}

			}

		}

		catch (Exception e) {
			Debug.println("Exception ..@@" + e);
		} finally {
			try {
				if (conn != null) {

					conn.close();
				}
			} catch (SQLException e) {
				Debug.println("Exception " + e);
			}
		}
		return buffer.toString();
	}

	// used
	public static String getMandals(DataSource dataSource,
			String headOfficeCode, String circleOfficeCode,
			String divisionOfficeCode, String subdiv) {
		Connection conn = null;
		StringBuffer buffer = new StringBuffer();
		try {
			conn = RwsOffices.getConn();
			String query = "SELECT M.MNAME, M.MCODE FROM RWS_MANDAL_TBL M, RWS_MANDAL_SUBDIVISION_TBL MM "
					+ "WHERE M.DCODE=MM.DCODE AND M.MCODE=MM.MCODE AND MM.CIRCLE_OFFICE_CODE='"
					+ circleOfficeCode
					+ "'AND "
					+ "MM.DIVISION_OFFICE_CODE='"
					+ divisionOfficeCode
					+ "' AND MM.SUBDIVISION_OFFICE_CODE='"
					+ subdiv + "' ORDER BY MNAME ";
			PreparedStatement ps = conn.prepareStatement(query,
					ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			Debug.println("query is:** " + query);
			ResultSet rs = ps.executeQuery();
			rs.last();
			int rowCount = rs.getRow();
			if (rowCount == 0) {

			} else {
				rs.beforeFirst();

				while (rs.next()) {
					buffer.append(rs.getString(1) + "<>");
					buffer.append(rs.getString(2) + "</>");
				}

			}

		}

		catch (Exception e) {
			Debug.println("Exception ..@@" + e);
		} finally {
			try {
				if (conn != null) {

					conn.close();
				}
			} catch (SQLException e) {
				Debug.println("Exception " + e);
			}
		}
		return buffer.toString();
	}

	// used
	public static String getpanchayats(DataSource dataSource,
			String circleOfficeCode, String mCode) {
		Connection conn = null;
		StringBuffer buffer = new StringBuffer();
		try {
			conn = RwsOffices.getConn();
			String query = "SELECT PNAME ,PCODE FROM RWS_PANCHAYAT_TBL WHERE DCODE='"
					+ circleOfficeCode
					+ "' and mcode='"
					+ mCode
					+ "' ORDER BY PNAME";
			PreparedStatement ps = conn.prepareStatement(query,
					ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			Debug.println("query is:**" + query);
			ResultSet rs = ps.executeQuery();
			rs.last();
			int rowCount = rs.getRow();
			if (rowCount == 0) {

			} else {
				rs.beforeFirst();

				while (rs.next()) {
					buffer.append(rs.getString(1) + "<>");
					buffer.append(rs.getString(2) + "</>");
				}

			}

		}

		catch (Exception e) {
			Debug.println("Exception ..@@" + e);
		} finally {
			try {
				if (conn != null) {

					conn.close();
				}
			} catch (SQLException e) {
				Debug.println("Exception " + e);
			}
		}
		return buffer.toString();
	}

	// used
	public static String getvillages(DataSource dataSource,
			String circleOfficeCode, String mCode, String panchayt) {
		Connection conn = null;
		StringBuffer buffer = new StringBuffer();
		try {
			conn = RwsOffices.getConn();
			String query = "SELECT VNAME,VCODE FROM RWS_VILLAGE_TBL WHERE "
					+ "DCODE='" + circleOfficeCode + "' and mcode='" + mCode
					+ "' AND" + " PCODE='" + panchayt + "' ORDER BY VNAME";
			PreparedStatement ps = conn.prepareStatement(query,
					ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			Debug.println("query is:**" + query);
			ResultSet rs = ps.executeQuery();
			rs.last();
			int rowCount = rs.getRow();
			if (rowCount == 0) {

			} else {
				rs.beforeFirst();

				while (rs.next()) {
					buffer.append(rs.getString(1) + "<>");
					buffer.append(rs.getString(2) + "</>");
				}

			}

		}

		catch (Exception e) {
			Debug.println("Exception ..@@" + e);
		} finally {
			try {
				if (conn != null) {

					conn.close();
				}
			} catch (SQLException e) {
				Debug.println("Exception " + e);
			}
		}
		return buffer.toString();
	}

	// used
	public static String getHabitations(DataSource dataSource,
			String circleOfficeCode, String mCode, String panchayt,
			String habitation) {
		Connection conn = null;
		StringBuffer buffer = new StringBuffer();
		try {
			conn = RwsOffices.getConn();
			String query = "SELECT PANCH_NAME ,PANCH_CODE FROM RWS_PANCHAYAT_RAJ_TBL "
					+ "WHERE substr(panch_code,1,2)='"
					+ circleOfficeCode
					+ "'"
					+ "and substr(panch_code,6,2)='"
					+ mCode
					+ "' "
					+ "and substr(panch_code,13,2)='"
					+ panchayt
					+ "'"
					+ " and substr(panch_code,8,3)='"
					+ habitation
					+ "' ORDER BY PANCH_NAME";
			PreparedStatement ps = conn.prepareStatement(query,
					ResultSet.TYPE_SCROLL_INSENSITIVE,
					ResultSet.CONCUR_READ_ONLY);
			Debug.println("query is:**" + query);
			ResultSet rs = ps.executeQuery();
			rs.last();
			int rowCount = rs.getRow();
			if (rowCount == 0) {

			} else {
				rs.beforeFirst();

				while (rs.next()) {
					buffer.append(rs.getString(1) + "<>");
					buffer.append(rs.getString(2) + "</>");
				}

			}

		}

		catch (Exception e) {
			Debug.println("Exception ..@@" + e);
		} finally {
			try {
				if (conn != null) {

					conn.close();
				}
			} catch (SQLException e) {
				Debug.println("Exception " + e);
			}
		}
		return buffer.toString();
	}

	public static String checkValue(int value) {
		String res = Integer.toString(value);
		if (res.equalsIgnoreCase("0")) {
			res = "--";
		}
		return res;
	}

	public static String checkValue(double value) {
		String res = Double.toString(value);
		if (res.equalsIgnoreCase("0")) {
			res = "--";
		}
		return res;
	}

	// used
	public static String getsubcomps(DataSource dataSource, String asset,
			String circle, String div, String subdiv, String mandal,
			String panchayat, String village, String habitation) {
		Connection conn = null;

		/*
		 * PWS-01 MPWS-02 CPWS-03 HAND PUMPS-04 SHALLOW HAND PUMPS-05 OPEN
		 * WELLS-06 PONDS-07
		 */
		Debug.println(" this is sub component counting .......");

		StringBuffer buffer = new StringBuffer();
		try {
			conn = RwsOffices.getConn();
			Debug.println("asset:" + asset);
			if (asset.equals("07"))// PONDS
			{
				ResultSet rs = null;
				PreparedStatement ps = null;
				String assetCompcode = "";
				String sucopmqry = "";
				String tempQuery = "select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,"
						+ "RWS_OPENWELL_POND_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND"
						+ " M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='07' and "
						+ "SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE ";
				if (!(circle.equals("")) || !(div.equals(""))
						|| !(subdiv.equals("")) || !(mandal.equals(""))
						|| !(panchayat.equals("")) || !(village.equals(""))) {
					if (!(circle.equals(""))) {

						sucopmqry = " and substr(M.HAB_CODE,1,2)='" + circle
								+ "'";
						if (!(mandal.equals(""))) {
							sucopmqry = sucopmqry
									+ "and substr(M.HAB_CODE,6,2)='" + mandal
									+ "'";
							if (!(panchayat.equals(""))) {
								sucopmqry = sucopmqry
										+ "and substr(M.HAB_code,13,2)='"
										+ panchayat + "'";
								if (!(village.equals(""))) {
									sucopmqry = sucopmqry
											+ "and substr(M.HAB_code,8,3)='"
											+ village + "'";
									if (!(habitation.equals(""))) {
										sucopmqry = sucopmqry
												+ "and M.HAB_code='"
												+ habitation + "'";
									}
								}
							}
						}
					}
					if (!(div.equals(""))) {
						sucopmqry = sucopmqry + "and M.division_office_code='"
								+ div + "'";
						if (!(subdiv.equals(""))) {
							sucopmqry = sucopmqry
									+ "and M.subdivision_office_code='"
									+ subdiv + "'";
						}
					}
				}
				sucopmqry = tempQuery + sucopmqry;
				try {
					Debug.println("query is " + sucopmqry);
					ps = conn.prepareStatement(sucopmqry);
					rs = ps.executeQuery();
					while (rs.next()) {
						buffer.append(rs.getString(1));
					}
				} catch (Exception e) {
					Debug.println("Exception:" + e);
				}
			}
			if (asset.equals("06"))// OPEN WELLS
			{
				ResultSet rs = null;
				PreparedStatement ps = null;
				String assetCompcode = "";
				String sucopmqry = "";
				String tempQuery = "select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,"
						+ "RWS_OPEN_WELL_MAST_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND"
						+ " M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='06' and"
						+ " SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE ";
				if (!(circle.equals("")) || !(div.equals(""))
						|| !(subdiv.equals("")) || !(mandal.equals(""))
						|| !(panchayat.equals("")) || !(village.equals(""))) {
					if (!(circle.equals(""))) {

						sucopmqry = " and substr(M.HAB_CODE,1,2)='" + circle
								+ "'";
						if (!(mandal.equals(""))) {
							sucopmqry = sucopmqry
									+ "and substr(M.HAB_CODE,6,2)='" + mandal
									+ "'";
							if (!(panchayat.equals(""))) {
								sucopmqry = sucopmqry
										+ "and substr(M.HAB_code,13,2)='"
										+ panchayat + "'";
								if (!(village.equals(""))) {
									sucopmqry = sucopmqry
											+ "and substr(M.HAB_code,8,3)='"
											+ village + "'";
									if (!(habitation.equals(""))) {
										sucopmqry = sucopmqry
												+ "and M.HAB_code='"
												+ habitation + "'";
									}
								}
							}
						}
					}
					if (!(div.equals(""))) {
						sucopmqry = sucopmqry + "and M.division_office_code='"
								+ div + "'";
						if (!(subdiv.equals(""))) {
							sucopmqry = sucopmqry
									+ "and M.subdivision_office_code='"
									+ subdiv + "'";
						}
					}
				}
				sucopmqry = tempQuery + sucopmqry;
				Debug.println("OPEN WELLS QURY is:::" + sucopmqry);
				try {
					Debug.println("query is " + sucopmqry);
					ps = conn.prepareStatement(sucopmqry);
					rs = ps.executeQuery();
					while (rs.next()) {
						buffer.append(rs.getString(1));
					}
				} catch (Exception e) {
					Debug.println("Exception:" + e);
				}
			}
			if (asset.equals("05"))// SHALLOW HANDPUMPS
			{
				ResultSet rs = null;
				PreparedStatement ps = null;
				String assetCompcode = "";
				String sucopmqry = "";
				String tempQuery = "select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,"
						+ "RWS_SHALLOWHANDPUMPS_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND "
						+ "M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='05' and "
						+ "SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE ";
				// String
				// tempQuery="select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S WHERE  M.ASSET_CODE=S.ASSET_CODE  AND M.TYPE_OF_ASSET_CODE='05' AND SUBSTR(S.SCHEME_CODE,17,3) LIKE '3%'";

				if (!(circle.equals("")) || !(div.equals(""))
						|| !(subdiv.equals("")) || !(mandal.equals(""))
						|| !(panchayat.equals("")) || !(village.equals(""))) {
					if (!(circle.equals(""))) {

						sucopmqry = " and substr(M.HAB_CODE,1,2)='" + circle
								+ "'";
						if (!(mandal.equals(""))) {
							sucopmqry = sucopmqry
									+ "and substr(M.HAB_CODE,6,2)='" + mandal
									+ "'";
							if (!(panchayat.equals(""))) {
								sucopmqry = sucopmqry
										+ "and substr(M.HAB_code,13,2)='"
										+ panchayat + "'";
								if (!(village.equals(""))) {
									sucopmqry = sucopmqry
											+ "and substr(M.HAB_code,8,3)='"
											+ village + "'";
									if (!(habitation.equals(""))) {
										sucopmqry = sucopmqry
												+ "and M.HAB_code='"
												+ habitation + "'";
									}
								}
							}
						}
					}
					if (!(div.equals(""))) {
						sucopmqry = sucopmqry + "and M.division_office_code='"
								+ div + "'";
						if (!(subdiv.equals(""))) {
							sucopmqry = sucopmqry
									+ "and M.subdivision_office_code='"
									+ subdiv + "'";
						}
					}
				}
				sucopmqry = tempQuery + sucopmqry;
				try {
					Debug.println("query is " + sucopmqry);
					ps = conn.prepareStatement(sucopmqry);
					rs = ps.executeQuery();
					while (rs.next()) {
						buffer.append(rs.getString(1));
					}
				} catch (Exception e) {
					Debug.println("Exception:" + e);
				}
			}
			if (asset.equals("04"))// HAND PUMPS
			{
				ResultSet rs = null;
				PreparedStatement ps = null;
				String assetCompcode = "";
				String sucopmqry = "";
				String tempQuery = "select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,RWS_HP_SUBCOMP_PARAM_TBL subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
						+ "AND M.TYPE_OF_ASSET_CODE='04' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE ";
				if (!(circle.equals("")) || !(div.equals(""))
						|| !(subdiv.equals("")) || !(mandal.equals(""))
						|| !(panchayat.equals("")) || !(village.equals(""))) {
					if (!(circle.equals(""))) {

						sucopmqry = " and substr(M.HAB_CODE,1,2)='" + circle
								+ "'";
						if (!(mandal.equals(""))) {
							sucopmqry = sucopmqry
									+ "and substr(M.HAB_CODE,6,2)='" + mandal
									+ "'";
							if (!(panchayat.equals(""))) {
								sucopmqry = sucopmqry
										+ "and substr(M.HAB_code,13,2)='"
										+ panchayat + "'";
								if (!(village.equals(""))) {
									sucopmqry = sucopmqry
											+ "and substr(M.HAB_code,8,3)='"
											+ village + "'";
									if (!(habitation.equals(""))) {
										sucopmqry = sucopmqry
												+ "and M.HAB_code='"
												+ habitation + "'";
									}
								}
							}
						}
					}
					if (!(div.equals(""))) {
						sucopmqry = sucopmqry + "and M.division_office_code='"
								+ div + "'";
						if (!(subdiv.equals(""))) {
							sucopmqry = sucopmqry
									+ "and M.subdivision_office_code='"
									+ subdiv + "'";
						}
					}
				}
				sucopmqry = tempQuery + sucopmqry;
				try {
					Debug.println("query is " + sucopmqry);
					ps = conn.prepareStatement(sucopmqry);
					rs = ps.executeQuery();
					while (rs.next()) {
						buffer.append(rs.getString(1));
					}
				} catch (Exception e) {
					Debug.println("Exception:" + e);
				}
			}

			if (asset.equals("01") || asset.equals("02") || asset.equals("03"))// PWS
																				// &&
																				// MPWS
																				// &&
																				// CPWS
			{

				for (int i = 0; i < 5; i++) {

					ResultSet rs = null;
					PreparedStatement ps = null;
					String assetCompcode = "";
					switch (i) {
					case 0:
						assetCompcode = "01";
						break;
					case 1:
						assetCompcode = "02";
						break;
					case 2:
						assetCompcode = "03";
						break;
					case 3:
						assetCompcode = "04";
						break;
					case 4:
						assetCompcode = "05";
						break;
					}

					String query = "select  trim(ASSET_SUBCOMPONENT_NAME),ASSET_SUBCOMPONENT_CODE"
							+ " from rws_asset_subcomponent_tbl where asset_component_code='"
							+ assetCompcode
							+ "'"
							+ " and type_of_asset_code='"
							+ asset + "' ORDER BY ASSET_SUBCOMPONENT_CODE ";
					Debug.println("query is " + query);
					ps = conn.prepareStatement(query);
					Debug.println("query is:**" + query);
					rs = null;
					rs = ps.executeQuery();

					while (rs.next()) {

						Debug.println("COMpnet name:" + rs.getString(1));
						Debug.println("COMpnet name111111:" + rs.getString(2));
						buffer.append(rs.getString(1) + "<>");
						buffer.append(rs.getString(2) + "<>");
						buffer.append(checkValue(getSubCompCount(asset,
								assetCompcode, (String) rs.getString(2),
								circle, div, subdiv, mandal, panchayat,
								village, habitation, conn)));

						if (assetCompcode.equals("03")) {

							buffer.append("&nbsp;&nbsp;&nbsp;");
							buffer.append(checkValue(getSubCompLength(asset,
									assetCompcode, (String) rs.getString(2),
									circle, div, subdiv, mandal, panchayat,
									village, habitation, conn))
									+ "</>");
						} else {

							buffer.append("</>");
						}

					}
					buffer.append("<//>");

				}
			}
			if (asset.equals("09")) {

				Debug.println("in dp ");
				for (int i = 0; i < 5; i++) {
					Debug.println("in dp 1");
					ResultSet rs = null;
					PreparedStatement ps = null;
					String assetCompcode = "";
					switch (i) {
					case 0:
						assetCompcode = "01";
						break;
					case 1:
						assetCompcode = "02";
						break;
					case 2:
						assetCompcode = "03";
						break;
					case 3:
						assetCompcode = "05";
						break;
					case 4:
						assetCompcode = "06";
						break;

					}

					String query = "select  trim(ASSET_SUBCOMPONENT_NAME),ASSET_SUBCOMPONENT_CODE"
							+ " from rws_asset_subcomponent_tbl where asset_component_code='"
							+ assetCompcode
							+ "'"
							+ " and type_of_asset_code='"
							+ asset + "' ORDER BY ASSET_SUBCOMPONENT_CODE ";
					Debug.println("query is " + query);
					ps = conn.prepareStatement(query);
					Debug.println("query is:**" + query);
					rs = null;
					rs = ps.executeQuery();

					while (rs.next()) {

						Debug.println("COMpnet name:" + rs.getString(1));
						Debug.println("COMpnet name111111:" + rs.getString(2));
						buffer.append(rs.getString(1) + "<>");
						buffer.append(rs.getString(2) + "<>");
						buffer.append(checkValue(getSubCompCount(asset,
								assetCompcode, (String) rs.getString(2),
								circle, div, subdiv, mandal, panchayat,
								village, habitation, conn))
								+ "</>");
					}
					buffer.append("<//>");

				}

			}

		}

		catch (Exception e) {
			Debug.println("Exception ..(@@)" + e);
		} finally {
			try {
				if (conn != null) {

					conn.close();
				}
			} catch (SQLException e) {
				Debug.println("Exception " + e);
			}
		}
		return buffer.toString();
	}

	private static double getSubCompLength(String asetCode, String CompCode,
			String assetSubComp, String circle, String div, String subdiv,
			String mandal, String panchayat, String village, String habitation,
			Connection con) {
		Debug.println(" this is @@@@@@@@@@@@@@@@@@@");

		Connection conn = null;
		// String series="";
		String sucopmqry = "";
		String subCompTbl = getTableName(CompCode, assetSubComp, asetCode);

		double count = 0;
		/*
		 * if(asetCode.equals("01")) {
		 * series=" SUBSTR(S.SCHEME_CODE,17,3) LIKE '6%' "; } else
		 * if(asetCode.equals("02")) { series=
		 * "(SUBSTR(S.SCHEME_CODE,17,3) LIKE '40%' or  SUBSTR(S.SCHEME_CODE,17,3) LIKE '41%' or  SUBSTR(S.SCHEME_CODE,17,3) LIKE '42%' or  SUBSTR(S.SCHEME_CODE,17,3) LIKE '43%' or  SUBSTR(S.SCHEME_CODE,17,3) LIKE '44%') "
		 * ; } else if(asetCode.equals("03")) {
		 * series="  SUBSTR(S.SCHEME_CODE,17,3) LIKE 8%"; } else
		 * if(asetCode.equals("09")) { series=
		 * "(SUBSTR(S.SCHEME_CODE,17,3) LIKE '45%' or  SUBSTR(S.SCHEME_CODE,17,3) LIKE '46%' or  SUBSTR(S.SCHEME_CODE,17,3) LIKE '47%' or  SUBSTR(S.SCHEME_CODE,17,3) LIKE '48%' or  SUBSTR(S.SCHEME_CODE,17,3) LIKE '49%') "
		 * ; }
		 */

		String feild = "";

		if (assetSubComp != null && assetSubComp.equals("003")) {
			feild += "  sum(nvl(DIS_LEN,0)) ";
		} else {
			feild += "  sum(nvl(length,0)) ";
		}

		String tempQuery = "select "
				+ feild
				+ " FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,"
				+ subCompTbl
				+ " subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
				+ "AND M.TYPE_OF_ASSET_CODE='" + asetCode
				+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE ";

		Debug.println("tempQuery:" + tempQuery);
		if (!(circle.equals("")) || !(div.equals("")) || !(subdiv.equals(""))
				|| !(mandal.equals("")) || !(panchayat.equals(""))
				|| !(village.equals(""))) {
			if (!(circle.equals(""))) {

				sucopmqry = " and substr(M.HAB_CODE,1,2)='" + circle + "'";
				if (!(mandal.equals(""))) {
					sucopmqry = sucopmqry + "and substr(M.HAB_CODE,6,2)='"
							+ mandal + "'";
					if (!(panchayat.equals(""))) {
						sucopmqry = sucopmqry + "and substr(M.HAB_code,13,2)='"
								+ panchayat + "'";
						if (!(village.equals(""))) {
							sucopmqry = sucopmqry
									+ "and substr(M.HAB_code,8,3)='" + village
									+ "'";
							if (!(habitation.equals(""))) {
								sucopmqry = sucopmqry + "and M.HAB_code='"
										+ habitation + "'";
							}
						}
					}
				}
			}
			if (!(div.equals(""))) {
				sucopmqry = sucopmqry + "and M.division_office_code='" + div
						+ "'";
				if (!(subdiv.equals(""))) {
					sucopmqry = sucopmqry + "and M.subdivision_office_code='"
							+ subdiv + "'";
				}
			}
		}
		if (CompCode.equals("02")) {
			if (assetSubComp.equals("003")) {
				sucopmqry = sucopmqry
						+ " and substr(subCompTbl.WTPSC_CODE,20,2)='SS'";
			}
			if (assetSubComp.equals("004")) {
				sucopmqry = sucopmqry
						+ " and substr(subCompTbl.WTPSC_CODE,20,2)='RS'";
			}
			if (assetSubComp.equals("010")) {
				sucopmqry = sucopmqry
						+ " and substr(subCompTbl.WTPSC_CODE,20,2)='MS'";
			}
			if (assetSubComp.equals("011")) {
				sucopmqry = sucopmqry
						+ " and substr(subCompTbl.WTPSC_CODE,20,2)='RP'";
			}
		}
		if (CompCode.equals("01")) {
			if (assetSubComp.equals("001")) {
				sucopmqry = sucopmqry
						+ " and subCompTbl. SOURCE_TYPE_CODE ='1'";
			}
			if (assetSubComp.equals("002")) {
				sucopmqry = sucopmqry
						+ " and subCompTbl. SOURCE_TYPE_CODE ='2'";
			}
		}
		sucopmqry = tempQuery + sucopmqry;
		Debug.println("THE COUNT(*)QRY:-" + sucopmqry);
		try {
			Debug.println("query is " + sucopmqry);
			PreparedStatement psmt = con.prepareStatement(sucopmqry);
			ResultSet rs = psmt.executeQuery();
			if (rs.next()) {
				count = Double.parseDouble(rs.getString(1));
			}
		} catch (Exception e) {
			Debug.println("EXCEPTION WHILE GETTING COUNTS OF SUBCOMPS :" + e);
		}
		return count;
	}

	public static int getSubCompCount(String asetCode, String CompCode,
			String assetSubComp, String circle, String div, String subdiv,
			String mandal, String panchayat, String village, String habitation,
			Connection con) {
		Debug.println(" this is @@@@@@@@@@@@@@@@@@@");

		Connection conn = null;
		// String series="";
		String sucopmqry = "";
		String subCompTbl = getTableName(CompCode, assetSubComp, asetCode);

		int count = 0;
		/*
		 * if(asetCode.equals("01")) {
		 * series=" SUBSTR(S.SCHEME_CODE,17,3) LIKE '6%' "; } else
		 * if(asetCode.equals("02")) { series=
		 * "(SUBSTR(S.SCHEME_CODE,17,3) LIKE '40%' or  SUBSTR(S.SCHEME_CODE,17,3) LIKE '41%' or  SUBSTR(S.SCHEME_CODE,17,3) LIKE '42%' or  SUBSTR(S.SCHEME_CODE,17,3) LIKE '43%' or  SUBSTR(S.SCHEME_CODE,17,3) LIKE '44%') "
		 * ; } else if(asetCode.equals("03")) {
		 * series="  SUBSTR(S.SCHEME_CODE,17,3) LIKE 8%"; } else
		 * if(asetCode.equals("09")) { series=
		 * "(SUBSTR(S.SCHEME_CODE,17,3) LIKE '45%' or  SUBSTR(S.SCHEME_CODE,17,3) LIKE '46%' or  SUBSTR(S.SCHEME_CODE,17,3) LIKE '47%' or  SUBSTR(S.SCHEME_CODE,17,3) LIKE '48%' or  SUBSTR(S.SCHEME_CODE,17,3) LIKE '49%') "
		 * ; }
		 */

		String tempQuery = "select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,"
				+ subCompTbl
				+ " subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
				+ "AND M.TYPE_OF_ASSET_CODE='"
				+ asetCode
				+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE ";

		Debug.println("tempQuery:" + tempQuery);
		if (!(circle.equals("")) || !(div.equals("")) || !(subdiv.equals(""))
				|| !(mandal.equals("")) || !(panchayat.equals(""))
				|| !(village.equals(""))) {
			if (!(circle.equals(""))) {

				sucopmqry = " and substr(M.HAB_CODE,1,2)='" + circle + "'";
				if (!(mandal.equals(""))) {
					sucopmqry = sucopmqry + "and substr(M.HAB_CODE,6,2)='"
							+ mandal + "'";
					if (!(panchayat.equals(""))) {
						sucopmqry = sucopmqry + "and substr(M.HAB_code,13,2)='"
								+ panchayat + "'";
						if (!(village.equals(""))) {
							sucopmqry = sucopmqry
									+ "and substr(M.HAB_code,8,3)='" + village
									+ "'";
							if (!(habitation.equals(""))) {
								sucopmqry = sucopmqry + "and M.HAB_code='"
										+ habitation + "'";
							}
						}
					}
				}
			}
			if (!(div.equals(""))) {
				sucopmqry = sucopmqry + "and M.division_office_code='" + div
						+ "'";
				if (!(subdiv.equals(""))) {
					sucopmqry = sucopmqry + "and M.subdivision_office_code='"
							+ subdiv + "'";
				}
			}
		}
		if (CompCode.equals("02")) {
			if (assetSubComp.equals("003")) {
				sucopmqry = sucopmqry
						+ " and substr(subCompTbl.WTPSC_CODE,20,2)='SS'";
			}
			if (assetSubComp.equals("004")) {
				sucopmqry = sucopmqry
						+ " and substr(subCompTbl.WTPSC_CODE,20,2)='RS'";
			}
			if (assetSubComp.equals("010")) {
				sucopmqry = sucopmqry
						+ " and substr(subCompTbl.WTPSC_CODE,20,2)='MS'";
			}
			if (assetSubComp.equals("011")) {
				sucopmqry = sucopmqry
						+ " and substr(subCompTbl.WTPSC_CODE,20,2)='RP'";
			}
		}
		if (CompCode.equals("01")) {
			if (assetSubComp.equals("001")) {
				sucopmqry = sucopmqry
						+ " and subCompTbl. SOURCE_TYPE_CODE ='1'";
			}
			if (assetSubComp.equals("002")) {
				sucopmqry = sucopmqry
						+ " and subCompTbl. SOURCE_TYPE_CODE ='2'";
			}
		}
		sucopmqry = tempQuery + sucopmqry;
		Debug.println("THE COUNT(*)QRY:-" + sucopmqry);
		try {
			Debug.println("query is " + sucopmqry);
			PreparedStatement psmt = con.prepareStatement(sucopmqry);
			ResultSet rs = psmt.executeQuery();
			if (rs.next()) {
				count = (int) rs.getInt(1);
			}
		} catch (Exception e) {
			Debug.println("EXCEPTION WHILE GETTING COUNTS OF SUBCOMPS :" + e);
		}
		return count;
	}

	// added by ramesh

	public static int getCpwsSubCompCount(String assetTypeCode,
			String CompCode, String assetSubComp, String assetCode,
			Connection con) {
		// Debug.println(" this is @@@@@@@@@@@@@@@@@@@");

		Connection conn = null;
		String series = "";
		String sucopmqry = "";
		String subCompTbl = getTableName(CompCode, assetSubComp, assetTypeCode);
		int count = 0;
		if (assetTypeCode.equals("01")) {
			series = "6%";
		} else if (assetTypeCode.equals("02")) {
			series = "4%";
		} else if (assetTypeCode.equals("03")) {
			series = "8%";
		}

		String tempQuery = "select count(*) FROM RWS_ASSET_MAST_TBL M, RWS_ASSET_SCHEME_TBL S,"
				+ subCompTbl
				+ " subCompTbl WHERE M.ASSET_CODE=subCompTbl.ASSET_CODE AND M.ASSET_CODE=S.ASSET_CODE "
				+ "AND M.TYPE_OF_ASSET_CODE='"
				+ assetTypeCode
				+ "' and SUBCOMPTBL.ASSET_CODE=S.ASSET_CODE AND SUBCOMPTBL.ASSET_CODE='"
				+ assetCode + "'";

		if (CompCode.equals("02")) {
			if (assetSubComp.equals("003")) {
				sucopmqry = sucopmqry
						+ " and substr(subCompTbl.WTPSC_CODE,20,2)='SS'";
			}
			if (assetSubComp.equals("004")) {
				sucopmqry = sucopmqry
						+ " and substr(subCompTbl.WTPSC_CODE,20,2)='RS'";
			}
			if (assetSubComp.equals("010")) {
				sucopmqry = sucopmqry
						+ " and substr(subCompTbl.WTPSC_CODE,20,2)='MS'";
			}
			if (assetSubComp.equals("011")) {
				sucopmqry = sucopmqry
						+ " and substr(subCompTbl.WTPSC_CODE,20,2)='RP'";
			}
		}
		if (CompCode.equals("01")) {
			if (assetSubComp.equals("001")) {
				sucopmqry = sucopmqry
						+ " and subCompTbl. SOURCE_TYPE_CODE ='1'";
			}
			if (assetSubComp.equals("002")) {
				sucopmqry = sucopmqry
						+ " and subCompTbl. SOURCE_TYPE_CODE ='2'";
			}
		}
		sucopmqry = tempQuery + sucopmqry;
		// Debug.println("THE COUNT(*)QRY:-"+sucopmqry);
		try {
			Debug.println("query is " + sucopmqry);
			PreparedStatement psmt = con.prepareStatement(sucopmqry);
			ResultSet rs = psmt.executeQuery();
			if (rs.next()) {
				count = (int) rs.getInt(1);
			}
		} catch (Exception e) {
			Debug.println("EXCEPTION WHILE GETTING COUNTS OF SUBCOMPS" + e);
		}
		return count;
	}

	public static String getTableName(String assetComponentCode,
			String assetSubComponentCode, String assetType) {
		String tableName = "";
		try {
			Debug.println("assetComponentCode" + assetComponentCode
					+ " assetSubComponentCode " + assetSubComponentCode
					+ "assetType" + assetType);

			if (assetType.equals("01"))// PWS
			{
				if (assetComponentCode.equals("01"))// SOURCE
				{
					if (assetSubComponentCode.equals("001"))// SUB SURFACE
															// SOURCE
					{
						tableName = "RWS_SOURCE_TBL";
					}
					if (assetSubComponentCode.equals("002"))// SURFACE SOURCE
					{
						tableName = "RWS_SOURCE_TBL";
					}
					if (assetSubComponentCode.equals("003"))// PUMP SETS
					{
						tableName = "RWS_AST_SUBCOMP_PARAM_TBL";
					}

				}
				if (assetComponentCode.equals("02"))// headWorks
				{
					if (assetSubComponentCode.equals("001"))// Rwcwell
					{
						tableName = "RWS_AST_RW_COLLWELL_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("002"))// sstank
					{
						tableName = "RWS_AST_SS_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("003"))// ssfilters
					{
						tableName = "RWS_AST_WTP_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("004"))// rsfilters
					{
						tableName = "RWS_AST_WTP_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("005"))// SUMP
					{
						tableName = "RWS_AST_SUMP_M_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("006"))// FOOT PATH BRIDGE
					{
						tableName = "RWS_AST_FP_BRIDGE_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("007"))// PUMP HOUSE
					{
						tableName = "RWS_AST_PUMPHOUSE_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("008"))// WATCHMAN QUARTER
					{
						tableName = "RWS_AST_WATCHMAN_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("009"))// CLEAR WATER
															// COLLECTION WELL
					{
						tableName = "RWS_AST_CW_COLLWELL_PARAM_TBL";
					}
					// code added by sridhar
					if (assetSubComponentCode.equals("010"))// MICRO FILTER
					{
						tableName = "RWS_AST_WTP_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("011"))// RO PLANTS
					{
						tableName = "RWS_AST_WTP_SC_PARAM_TBL";
					}
					// code end
				}
				if (assetComponentCode.equals("03"))// PIPELINE
				{
					if (assetSubComponentCode.equals("001"))// PUMPINGMAIN
					{
						tableName = "RWS_AST_PUMPINGMAIN_TBL";
					}
					if (assetSubComponentCode.equals("002"))// gravity main
					{
						tableName = "RWS_AST_GRAVITYMAIN_TBL";
					}
					if (assetSubComponentCode.equals("003"))// distribution
					{
						tableName = "RWS_AST_DISTRI_SC_PARAM_TBL";
					}

				}
				if (assetComponentCode.equals("04"))// RESERVOIRS
				{
					if (assetSubComponentCode.equals("001"))// OHSR
					{
						tableName = "RWS_AST_OHSR_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("002"))// OHBR
					{
						tableName = "RWS_AST_OHBR_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("003"))// GLSR
					{
						tableName = "RWS_AST_GLSR_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("004"))// GLBR
					{
						tableName = "RWS_AST_GLBR_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("005"))// GLBR
					{
						tableName = "RWS_AST_BPT_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("006"))// cisterns
					{
						tableName = "RWS_AST_CIS_SC_PARAM_TBL";
					}

				}
				if (assetComponentCode.equals("05"))// Others
				{
					if (assetSubComponentCode.equals("001"))// MISCELLANEOUS
					{
						tableName = "RWS_AST_OTHERS_PARAM_TBL";
					}
					// code added by sridhar
					if (assetSubComponentCode.equals("002"))// CHLORINATION
					{
						tableName = "RWS_AST_CHLORINATION_TBL";
					}
					if (assetSubComponentCode.equals("003"))// O AND M
					{
						tableName = "RWS_AST_OANDM_PARAM_TBL";
					}
					// code end
				}
			}

			if (assetType.equals("02"))// MPWS
			{
				if (assetComponentCode.equals("01"))// SOURCE
				{
					if (assetSubComponentCode.equals("001"))// SUB SURFACE
															// SOURCE
					{
						tableName = "RWS_SOURCE_TBL";
					}
					if (assetSubComponentCode.equals("002"))// SURFACE SOURCE
					{
						tableName = "RWS_SOURCE_TBL";
					}
					if (assetSubComponentCode.equals("003"))// PUMP SETS
					{
						tableName = "RWS_AST_SUBCOMP_PARAM_TBL";
					}
				}
				if (assetComponentCode.equals("02"))// SOURCE
				{
					if (assetSubComponentCode.equals("001"))// RWC WELL
					{
						tableName = "RWS_AST_RW_COLLWELL_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("002"))// SS TANKS
					{
						tableName = "RWS_AST_SS_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("003"))// SS FILTERS
					{
						tableName = "RWS_AST_WTP_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("004"))// RS FILTER
					{
						tableName = "RWS_AST_WTP_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("005"))// SSUMP
					{
						tableName = "RWS_AST_SUMP_M_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("006"))// FOOT PATH BRIDGE
					{
						tableName = "RWS_AST_FP_BRIDGE_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("007"))// PUMPHOUSE
					{
						tableName = "RWS_AST_PUMPHOUSE_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("008"))// WATCHMAN QUARTER
					{
						tableName = "RWS_AST_WATCHMAN_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("009"))// CWC WELL
															// COLLECTION
					{
						tableName = "RWS_AST_CW_COLLWELL_PARAM_TBL";
					}
					// code added by sridhar
					if (assetSubComponentCode.equals("010"))// MICRO FILTER
					{
						tableName = "RWS_AST_WTP_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("011"))// RO PLANTS
					{
						tableName = "RWS_AST_WTP_SC_PARAM_TBL";
					}
					// code end

				}
				if (assetComponentCode.equals("03"))// PIPELINE
				{
					if (assetSubComponentCode.equals("001"))// PUMPINGMAIN
					{
						tableName = "RWS_AST_PUMPINGMAIN_TBL";
					}
					if (assetSubComponentCode.equals("002"))// GRAVITYmain
					{
						tableName = "RWS_AST_GRAVITYMAIN_TBL ";
					}
					if (assetSubComponentCode.equals("003"))// DISTRIBUTION
					{
						tableName = "RWS_AST_DISTRI_SC_PARAM_TBL";
					}

				}
				if (assetComponentCode.equals("04"))// RESERVOIRS
				{
					if (assetSubComponentCode.equals("001"))// OHSR
					{
						tableName = "RWS_AST_OHSR_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("002"))// OHBR
					{
						tableName = "RWS_AST_OHBR_SC_PARAM_TBL ";
					}
					if (assetSubComponentCode.equals("003"))// GLSR
					{
						tableName = "RWS_AST_GLSR_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("004"))// GLBR
					{
						tableName = "RWS_AST_GLBR_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("005"))// BPT
					{
						tableName = "RWS_AST_BPT_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("006"))// CISTERNS
					{
						tableName = "RWS_AST_CIS_SC_PARAM_TBL";
					}

				}
				if (assetComponentCode.equals("05"))// OTHERS
				{
					if (assetSubComponentCode.equals("001"))// MISCELLANEOUS
					{
						tableName = "RWS_AST_OTHERS_PARAM_TBL";
					}
					// code added by sridhar
					if (assetSubComponentCode.equals("002"))// CHLORINATION
					{
						tableName = "RWS_AST_CHLORINATION_TBL";
					}
					if (assetSubComponentCode.equals("003"))// O AND M
					{
						tableName = "RWS_AST_OANDM_PARAM_TBL";
					}
					// code end

				}

			}
			if (assetType.equals("03"))// assetType='CPWS'
			{
				Debug.println("cpws .......");
				if (assetComponentCode.equals("01"))// SOURCE
				{

					if (assetSubComponentCode.equals("001"))// SUB SURFACE
															// SOURCE
					{
						tableName = "RWS_SOURCE_TBL";
					}
					if (assetSubComponentCode.equals("002"))// SURFACE SOURCE
					{
						tableName = "RWS_SOURCE_TBL";
					}
					if (assetSubComponentCode.equals("003"))// PUMP SETS
					{
						tableName = "RWS_AST_SUBCOMP_PARAM_TBL";
					}

				}

				if (assetComponentCode.equals("02"))// 02-HEADWORKS
				{

					if (assetSubComponentCode.equals("001"))// RAW WATER
															// COLLECTION WELL
					{

						tableName = "RWS_AST_RW_COLLWELL_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("002"))// SS TANK
					{
						tableName = "RWS_AST_SS_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("003"))// SS FILTERS
					{
						tableName = "RWS_AST_WTP_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("004"))// RS FILTERS
					{
						tableName = "RWS_AST_WTP_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("005"))// SUMP
					{
						tableName = "RWS_AST_SUMP_M_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("006"))// FOOT PATH BRIDGE
					{
						tableName = "RWS_AST_FP_BRIDGE_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("007"))// PUMP HOUSE
					{
						tableName = "RWS_AST_PUMPHOUSE_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("008"))// WATCHMAN QUARTER
					{
						tableName = "RWS_AST_WATCHMAN_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("009"))// CLEAR WATER
															// COLLECTION WELL
					{
						tableName = "RWS_AST_CW_COLLWELL_PARAM_TBL";
					}
					// code added by sridhar
					if (assetSubComponentCode.equals("010"))// MICRO FILTER
					{
						tableName = "RWS_AST_WTP_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("011"))// RO PLANTS
					{
						tableName = "RWS_AST_WTP_SC_PARAM_TBL";
					}
					// code end

				}
				if (assetComponentCode.equals("03"))// 03-PIPELINE
				{
					if (assetSubComponentCode.equals("001"))// PUMPING MAIN
					{
						tableName = "RWS_AST_PUMPINGMAIN_TBL";
					}
					if (assetSubComponentCode.equals("002"))// GRAVITY MAIN
					{
						tableName = "RWS_AST_GRAVITYMAIN_TBL";
					}
					if (assetSubComponentCode.equals("003"))// DISTRIBUTION
					{
						tableName = "RWS_AST_DISTRI_SC_PARAM_TBL";
					}

				}
				if (assetComponentCode.equals("04"))// 04-SR.RESERVOIRS
				{
					if (assetSubComponentCode.equals("001"))// OHSR
					{
						tableName = "RWS_AST_OHSR_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("002"))// OHBR
					{
						tableName = "RWS_AST_OHBR_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("003"))// GLSR
					{
						tableName = "RWS_AST_GLSR_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("004"))// GLBR
					{
						tableName = "RWS_AST_GLBR_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("005"))// BPT
					{
						tableName = "RWS_AST_BPT_PARAM_TBL ";
					}
					if (assetSubComponentCode.equals("006"))// cisterns
					{
						tableName = "RWS_AST_CIS_SC_PARAM_TBL";
					}
				}

				if (assetComponentCode.equals("05"))// 05-OTHERS
				{
					if (assetSubComponentCode.equals("001"))// MISCELLANEOUS
					{
						tableName = "RWS_AST_OTHERS_PARAM_TBL";
					}

					// code added by sridhar
					if (assetSubComponentCode.equals("002"))// CHLORINATION
					{
						tableName = "RWS_AST_CHLORINATION_TBL";
					}
					if (assetSubComponentCode.equals("003"))// O AND M
					{
						tableName = "RWS_AST_OANDM_PARAM_TBL";
					}

					// code end

				}
			}
			if (assetType.equals("04"))// assetType='HANDPUMPS'
			{
				if (assetComponentCode.equals("01"))// SOURCE
				{
					if (assetSubComponentCode.equals("001"))// BOREWELL
					{
						tableName = "RWS_HP_SUBCOMP_PARAM_TBL ";
					}
				}
			}
			if (assetType.equals("09")) // assetType=DIRECT PUMPING added by
										// sridhar
			{
				// Debug.println("assetComponentCode in dp:"+assetComponentCode);
				if (assetComponentCode.equals("01"))// SOURCE
				{
					if (assetSubComponentCode.equals("001"))// SUB SURFACE
															// SOURCE
					{
						tableName = "RWS_SOURCE_TBL";
					}
					if (assetSubComponentCode.equals("002"))// SURFACE SOURCE
					{
						tableName = "RWS_SOURCE_TBL";
					}
					if (assetSubComponentCode.equals("003"))// PUMP SETS
					{
						tableName = "RWS_AST_SUBCOMP_PARAM_TBL";
					}
				}
				if (assetComponentCode.equals("02"))// SOURCE
				{
					if (assetSubComponentCode.equals("001"))// RWC WELL
					{
						tableName = "RWS_AST_RW_COLLWELL_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("002"))// SS TANKS
					{
						tableName = "RWS_AST_SS_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("003"))// SS FILTERS
					{
						tableName = "RWS_AST_WTP_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("004"))// RS FILTER
					{
						tableName = "RWS_AST_WTP_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("005"))// SSUMP
					{
						tableName = "RWS_AST_SUMP_M_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("006"))// FOOT PATH BRIDGE
					{
						tableName = "RWS_AST_FP_BRIDGE_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("007"))// PUMPHOUSE
					{
						tableName = "RWS_AST_PUMPHOUSE_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("008"))// WATCHMAN QUARTER
					{
						tableName = "RWS_AST_WATCHMAN_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("009"))// CWC WELL
															// COLLECTION
					{
						tableName = "RWS_AST_CW_COLLWELL_PARAM_TBL";
					}
					// code added by sridhar
					if (assetSubComponentCode.equals("010"))// MICRO FILTER
					{
						tableName = "RWS_AST_WTP_SC_PARAM_TBL";
					}
					if (assetSubComponentCode.equals("011"))// RO PLANTS
					{
						tableName = "RWS_AST_WTP_SC_PARAM_TBL";
					}
					// code end

				}
				if (assetComponentCode.equals("03"))// PIPELINE
				{
					if (assetSubComponentCode.equals("001"))// PUMPINGMAIN
					{
						tableName = "RWS_AST_PUMPINGMAIN_TBL";
					}
					if (assetSubComponentCode.equals("002"))// GRAVITYmain
					{
						tableName = "RWS_AST_GRAVITYMAIN_TBL ";
					}
					if (assetSubComponentCode.equals("003"))// DISTRIBUTION
					{
						tableName = "RWS_AST_DISTRI_SC_PARAM_TBL";
					}

				}

				if (assetComponentCode.equals("05"))// OTHERS
				{
					if (assetSubComponentCode.equals("001"))// MISCELLANEOUS
					{
						tableName = "RWS_AST_OTHERS_PARAM_TBL";
					}
					// code added by sridhar
					if (assetSubComponentCode.equals("002"))// CHLORINATION
					{
						tableName = "RWS_AST_CHLORINATION_TBL";
					}
					if (assetSubComponentCode.equals("003"))// O AND M
					{
						tableName = "RWS_AST_OANDM_PARAM_TBL";
					}
					// code end

				}

				if (assetComponentCode.equals("06"))// Pumpsets
				{
					if (assetSubComponentCode.equals("001"))//
					{
						tableName = "RWS_AST_SUBCOMP_PARAM_TBL";
					}

				}

			}

		} catch (Exception e) {
		}
		return tableName;
	}
}
