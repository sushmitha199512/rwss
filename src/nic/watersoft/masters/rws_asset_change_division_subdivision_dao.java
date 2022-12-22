package nic.watersoft.masters;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

public class rws_asset_change_division_subdivision_dao

{
	public ArrayList getDetails(rws_asset_change_division_subdivision_form myForm, HttpServletRequest request)
			throws Exception {
		String query = "";
		int rcount = 0;
		Connection conn = null;
		PreparedStatement stmt = null, stmt1 = null, stmt2 = null, stmt3 = null, stmt4 = null, stmt5 = null;
		ResultSet resultSet = null, resultSet1 = null, resultSet2 = null, resultSet3 = null, resultSet4 = null,
				resultSet5 = null;
		Hashtable hashtable = new Hashtable();
		ArrayList assetChangeDetails = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query = "select distinct hab_code,asset_code from rws_asset_mast_tbl where circle_office_code=? and division_office_code=? and subdivision_office_code=?";
			stmt = conn.prepareStatement(query);
			stmt.setString(1, myForm.getCircle());
			stmt.setString(2, myForm.getDivision());
			stmt.setString(3, myForm.getSubDivision());
			resultSet = stmt.executeQuery();
			while (resultSet.next()) {
				hashtable.put(resultSet.getString(2), resultSet.getString(1));
			}
			stmt.close();
			resultSet.close();
			int size = hashtable.size();
			Vector v = new Vector(hashtable.keySet());
			Collections.sort(v);
			Iterator it = v.iterator();
			while (it.hasNext()) {
				String element = (String) it.next();
				String assetCode = element;
				String habCode = (String) hashtable.get(element);
				String dcode = habCode.substring(0, 2);
				String mcode = habCode.substring(5, 7);
				query = "select a.ASSET_CODE,a.ASSET_NAME,a.TYPE_OF_ASSET_CODE,a.HAB_CODE,a.LOCATION,a.ASSET_COST,a.DIVISION_OFFICE_CODE,"
						+ "a.SUBDIVISION_OFFICE_CODE,b.DIVISION_OFFICE_CODE,b.SUBDIVISION_OFFICE_CODE from  rws_asset_mast_tbl a,rws_mandal_subdivision_tbl b "
						+ "where asset_code=? and substr(a.hab_code,1,2)=b.dcode and substr(a.HAB_CODE,6,2)=b.MCODE and a.circle_office_code=b.circle_office_code and "
						+ "(a.division_office_code <> b.division_office_code or a.subdivision_office_code <> b.subdivision_office_code)";
				stmt = conn.prepareStatement(query);
				stmt.setString(1, assetCode);
				resultSet = stmt.executeQuery();
				if (resultSet.next()) {
					String ctdCode = resultSet.getString(9);
					String ctsdCode = resultSet.getString(10);
					String query5 = "select a.division_office_code from RWS_DIVISION_OFFICE_TBL a,rws_mandal_subdivision_tbl b where a.circle_office_code=? and "
							+ "a.division_office_code=? and b.subdivision_office_code=? and a.circle_office_code=b.circle_office_code and a.division_office_code=b.division_office_code  "
							+ "and a.status <> 'UI' ";
					stmt5 = conn.prepareStatement(query5);
					stmt5.setString(1, myForm.getCircle());
					stmt5.setString(2, ctdCode);
					stmt5.setString(3, ctsdCode);
					resultSet5 = stmt5.executeQuery();
					if (resultSet5.next()) {
						rws_asset_change_division_subdivision_form asset_change_division_subdivision_form = new rws_asset_change_division_subdivision_form();
						rcount++;
						asset_change_division_subdivision_form.setAssetCode(resultSet.getString(1));
						asset_change_division_subdivision_form.setAssetName(resultSet.getString(2));
						asset_change_division_subdivision_form.setLocation(resultSet.getString(5));
						asset_change_division_subdivision_form.setDivision(resultSet.getString(7));
						asset_change_division_subdivision_form.setSubDivision(resultSet.getString(8));
						asset_change_division_subdivision_form.setAssetCost(resultSet.getString(6));
						asset_change_division_subdivision_form.setHabCode(habCode);
						String query1 = "select DIVISION_OFFICE_NAME from rws_division_office_tbl where CIRCLE_OFFICE_CODE=? and"
								+ " DIVISION_OFFICE_CODE=?";
						stmt1 = conn.prepareStatement(query1);
						stmt1.setString(1, myForm.getCircle());
						stmt1.setString(2, resultSet.getString(7));
						resultSet1 = stmt1.executeQuery();
						if (resultSet1.next()) {
							asset_change_division_subdivision_form.setPrasentDivision(resultSet1.getString(1));
						}
						stmt1.close();
						resultSet1.close();
						String query2 = "select SUBDIVISION_OFFICE_NAME from rws_subdivision_office_tbl where CIRCLE_OFFICE_CODE=? and DIVISION_OFFICE_CODE=?"
								+ " and SUBDIVISION_OFFICE_CODE=?";
						stmt2 = conn.prepareStatement(query2);
						stmt2.setString(1, myForm.getCircle());
						stmt2.setString(2, resultSet.getString(7));
						stmt2.setString(3, resultSet.getString(8));
						resultSet2 = stmt2.executeQuery();
						if (resultSet2.next()) {
							asset_change_division_subdivision_form.setPrasentSubDivision(resultSet2.getString(1));
						}
						stmt2.close();
						resultSet2.close();
						String query3 = "select PANCH_NAME from rws_complete_hab_view where PANCH_CODE=?";
						stmt3 = conn.prepareStatement(query3);
						stmt3.setString(1, habCode);
						resultSet3 = stmt3.executeQuery();
						if (resultSet3.next()) {
							asset_change_division_subdivision_form.setHabName(resultSet3.getString(1));
						}
						stmt3.close();
						resultSet3.close();
						assetChangeDetails.add(asset_change_division_subdivision_form);
					}
					stmt5.close();
					resultSet5.close();
				}
				stmt.close();
				resultSet.close();
			}
			String query4 = "select CIRCLE_OFFICE_NAME,CIRCLE_OFFICE_CODE from rws_circle_office_tbl where CIRCLE_OFFICE_CODE=?";
			stmt4 = conn.prepareStatement(query4);
			stmt4.setString(1, myForm.getCircle());
			resultSet4 = stmt4.executeQuery();
			if (resultSet4.next()) {
				request.setAttribute("circleName", resultSet4.getString(1));
				request.setAttribute("circleCode", resultSet4.getString(2));
			}
			stmt4.close();
			resultSet4.close();
		} catch (Exception e) {
			System.out.println("Exception at getDetails in asset division subdivision change form : " + e);
		} finally {
			if (conn != null) {
				conn.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return assetChangeDetails;
	}

	public ArrayList getAssetDetails(rws_asset_change_division_subdivision_form myForm, HttpServletRequest request)
			throws Exception {
		String query = "";
		Connection conn = null;
		PreparedStatement stmt = null, stmt1 = null, stmt2 = null, stmt3 = null, stmt4 = null, stmt5 = null,
				stmt6 = null;
		ResultSet resultSet = null, resultSet1 = null, resultSet2 = null, resultSet3 = null, resultSet4 = null,
				resultSet5 = null, resultSet6 = null;
		Hashtable hashtable = new Hashtable();
		ArrayList assetChangeDetails = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			query = "select a.ASSET_CODE,a.ASSET_NAME,a.TYPE_OF_ASSET_CODE,a.HAB_CODE,a.LOCATION,a.ASSET_COST,a.DIVISION_OFFICE_CODE,"
					+ "a.SUBDIVISION_OFFICE_CODE,b.DIVISION_OFFICE_CODE,b.SUBDIVISION_OFFICE_CODE from  rws_asset_mast_tbl a,rws_mandal_subdivision_tbl b "
					+ "where asset_code=? and substr(a.hab_code,1,2)=b.dcode and substr(a.HAB_CODE,6,2)=b.MCODE and"
					+ " a.circle_office_code=b.circle_office_code and (a.division_office_code <> b.division_office_code or a.subdivision_office_code <> b.subdivision_office_code)";
			stmt = conn.prepareStatement(query);
			stmt.setString(1, myForm.getAssetCode());
			resultSet = stmt.executeQuery();
			if (resultSet.next()) {
				rws_asset_change_division_subdivision_form asset_change_division_subdivision_form = new rws_asset_change_division_subdivision_form();
				String habCode = resultSet.getString(4);
				asset_change_division_subdivision_form.setAssetCode(resultSet.getString(1));
				asset_change_division_subdivision_form.setAssetName(resultSet.getString(2));
				asset_change_division_subdivision_form.setLocation(resultSet.getString(5));
				asset_change_division_subdivision_form.setDivision(resultSet.getString(7));
				asset_change_division_subdivision_form.setSubDivision(resultSet.getString(8));
				asset_change_division_subdivision_form.setHabCode(habCode);
				asset_change_division_subdivision_form.setAssetCost(resultSet.getString(6));
				asset_change_division_subdivision_form.setCircle(myForm.getCircle());
				asset_change_division_subdivision_form.setWorkasset("A");
				String typeOfAssetCode = resultSet.getString(3);
				String ctdCode = resultSet.getString(9);
				String ctsdCode = resultSet.getString(10);
				String query4 = "select * from RWS_ASSET_TYPE_TBL where TYPE_OF_ASSET_CODE=?";
				stmt4 = conn.prepareStatement(query4);
				stmt4.setString(1, typeOfAssetCode);
				resultSet4 = stmt4.executeQuery();
				if (resultSet4.next()) {
					asset_change_division_subdivision_form.setTypeOfAsset(resultSet4.getString(2));
				}
				stmt4.close();
				resultSet4.close();
				String query1 = "select DIVISION_OFFICE_NAME from rws_division_office_tbl where CIRCLE_OFFICE_CODE=? and DIVISION_OFFICE_CODE=?";
				stmt1 = conn.prepareStatement(query1);
				stmt1.setString(1, myForm.getCircle());
				stmt1.setString(2, resultSet.getString(7));
				resultSet1 = stmt1.executeQuery();
				if (resultSet1.next()) {
					asset_change_division_subdivision_form.setPrasentDivision(resultSet1.getString(1));
				}
				stmt1.close();
				resultSet1.close();
				String query2 = "select SUBDIVISION_OFFICE_NAME from rws_subdivision_office_tbl where CIRCLE_OFFICE_CODE=? and DIVISION_OFFICE_CODE=? and "
						+ "SUBDIVISION_OFFICE_CODE=?";
				stmt2 = conn.prepareStatement(query2);
				stmt2.setString(1, myForm.getCircle());
				stmt2.setString(2, resultSet.getString(7));
				stmt2.setString(3, resultSet.getString(8));
				resultSet2 = stmt2.executeQuery();
				if (resultSet2.next()) {
					asset_change_division_subdivision_form.setPrasentSubDivision(resultSet2.getString(1));
				}
				stmt2.close();
				resultSet2.close();
				String query3 = "select PANCH_NAME from rws_complete_hab_view where PANCH_CODE=?";
				stmt3 = conn.prepareStatement(query3);
				stmt3.setString(1, resultSet.getString(4));
				resultSet3 = stmt3.executeQuery();
				if (resultSet3.next()) {
					asset_change_division_subdivision_form.setHabName(resultSet3.getString(1));
				}
				stmt3.close();
				resultSet3.close();
				String query5 = "select DIVISION_OFFICE_CODE,DIVISION_OFFICE_NAME from rws_division_office_tbl where CIRCLE_OFFICE_CODE=? "
						+ "and DIVISION_OFFICE_CODE=?";
				stmt5 = conn.prepareStatement(query5);
				stmt5.setString(1, myForm.getCircle());
				stmt5.setString(2, ctdCode);
				resultSet5 = stmt5.executeQuery();
				if (resultSet5.next()) {
					asset_change_division_subdivision_form.setChangeToDivisionCode(resultSet5.getString(1));
					asset_change_division_subdivision_form.setChangeToDivision(resultSet5.getString(2));
				}
				stmt5.close();
				resultSet5.close();
				String query6 = "select SUBDIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_NAME  from rws_subdivision_office_tbl where CIRCLE_OFFICE_CODE=? "
						+ "and DIVISION_OFFICE_CODE=? and SUBDIVISION_OFFICE_CODE=?";
				stmt6 = conn.prepareStatement(query6);
				stmt6.setString(1, myForm.getCircle());
				stmt6.setString(2, ctdCode);
				stmt6.setString(3, ctsdCode);
				resultSet6 = stmt6.executeQuery();
				if (resultSet6.next()) {
					asset_change_division_subdivision_form.setChangeToSubDivisionCode(resultSet6.getString(1));
					asset_change_division_subdivision_form.setChangeToSubDivision(resultSet6.getString(2));
				}
				stmt6.close();
				resultSet6.close();
				assetChangeDetails.add(asset_change_division_subdivision_form);
			}
			stmt.close();
			resultSet.close();
		} catch (Exception e) {
			System.out.println("Exception at getAssetDetails in asset division subdivision change form : " + e);
		} finally {
			if (conn != null) {
				conn.close();
			}
			if (stmt != null) {
				stmt.close();
			}
		}
		return assetChangeDetails;
	}

	public String saveAssetDetails(rws_asset_change_division_subdivision_form myForm, HttpSession session)
			throws Exception {
		String query = "";

		Connection conn = null;
		PreparedStatement pstmt = null, pstmt1 = null;
		int n = 0;
		String message = "";
		try {
			RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
			final String userId = user.getUserId();
			/*Date systemdate = new java.util.Date(System.currentTimeMillis());
			java.text.DateFormat dateFormat = new java.text.SimpleDateFormat("dd/MM/yyyy");
			String transdate = dateFormat.format(systemdate);*/
			conn = RwsOffices.getConn();
			if (!isExists(myForm.getAssetCode(), conn)) {
				query = "insert into RWS_ASSET_OFF_CHANGE_HIST_TBL values(?,?,?,?,?,?,sysdate,?)";
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, myForm.getAssetCode());
				pstmt.setString(2, myForm.getWorkasset());
				pstmt.setString(3, myForm.getDivision());
				pstmt.setString(4, myForm.getSubDivision());
				pstmt.setString(5, myForm.getChangeToDivisionCode());
				pstmt.setString(6, myForm.getChangeToSubDivisionCode());
				//pstmt.setString(7, transdate);
				pstmt.setString(7, userId);
				n = pstmt.executeUpdate();
				if (n > 0) {
					query = "update rws_asset_mast_tbl set DIVISION_OFFICE_CODE=?,SUBDIVISION_OFFICE_CODE=? where ASSET_CODE=?";
					pstmt1 = conn.prepareStatement(query);
					pstmt1.setString(1, myForm.getChangeToDivisionCode());
					pstmt1.setString(2, myForm.getChangeToSubDivisionCode());
					pstmt1.setString(3, myForm.getAssetCode());
					n = pstmt1.executeUpdate();
					if (n > 0) {
						message = "Asset Changed Successfully ";
					} else {
						message = "Failed To Change Asset ";
					}
				} else {
					message = "Failed To Change Asset ";
				}
			} else {
				message = "Asset Aleredy Changed";
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Exception at saveAssetDetails in asset division subdivision change form : " + e);
		} finally {
			if (conn != null) {
				conn.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
		}
		return message;
	}

	private boolean isExists(String assetCode, Connection conn) {
		ResultSet rs = null;
		String query = "";
		PreparedStatement stmt1 = null;
		try {
			query = "select ASSET_CODE from RWS_ASSET_OFF_CHANGE_HIST_TBL where ASSET_CODE=?";
			stmt1 = conn.prepareStatement(query);
			stmt1.setString(1, assetCode);
			rs = stmt1.executeQuery();
			if (rs.next()) {
				return true;
			} else {
				return false;
			}
		} catch (Exception e) {
			System.out.println("Exception at isExists in asset division subdivision change form : " + e);
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
			} catch (Exception e) {
				// e.printStackTrace();
			}
		}
		return false;
	}

}