package nic.watersoft.works;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsWorkDetailsDAO {

	/**
	 * 
	 * @return Circles List
	 */
	public ArrayList getCircles() {
		ArrayList circles = new ArrayList();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();
			String query = "select distinct substr(ne.office_code,2,2) as circleoffcode,circle_office_name  from rws_work_admn_tbl ne,"
					+ " rws_circle_office_tbl co where substr(ne.office_code,2,2)=co.circle_office_code and substr(ne.office_code,1,1)=? order by circle_office_name";
			Debug.println("query in getCircles is " + query);
			ps = conn.prepareStatement(query);
			ps.setString(1, "1");
			rset = ps.executeQuery();
			while (rset.next()) {
				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				circles.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("Exception in getCircles is " + e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (rset != null) {
					rset.close();
				}
			} catch (Exception e) {
				Debug.println("Get Circles Exception in Closing ");
			}
		}

		return circles;
	}

	public ArrayList getPrograms() {
		ArrayList programms = new ArrayList();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();
			String query = "select programme_code,programme_name from rws_programme_tbl order by programme_code";
			Debug.println("query in getCircles is " + query);
			ps = conn.prepareStatement(query);
			rset = ps.executeQuery();
			while (rset.next()) {
				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				programms.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("Exception in getCircles is " + e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (rset != null) {
					rset.close();
				}
			} catch (Exception e) {
				Debug.println("Get Circles Exception in Closing ");
			}
		}

		return programms;
	}

	public ArrayList getSchemes() {
		ArrayList schemes = new ArrayList();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();
			String query = "select *from rws_asset_type_tbl  order by TYPE_OF_ASSET_CODE";
			Debug.println("query in getCircles is " + query);
			ps = conn.prepareStatement(query);

			rset = ps.executeQuery();
			while (rset.next()) {
				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				schemes.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("Exception in getCircles is " + e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (rset != null) {
					rset.close();
				}
			} catch (Exception e) {
				Debug.println("Get Circles Exception in Closing ");
			}
		}

		return schemes;
	}

	/**
	 * 
	 * @param circleOfficeCode
	 * @param schemeCode
	 * @param string
	 */
	public ArrayList getWorks(String circleOfficeCode, String schemeCode,
			String programmeCode) {
		ArrayList works = new ArrayList();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();
			String query = "select work_id,work_name from rws_work_admn_tbl where substr(office_code,2,2)=? and type_of_asset=?";
			if (programmeCode != null && !programmeCode.equals("0")) {

				query += " and substr(work_id,1,2)= ?";
			}
			Debug.println("query in getWorks is " + query);
			ps = conn.prepareStatement(query);
			ps.setString(1, circleOfficeCode);
			ps.setString(2, schemeCode);

			if (programmeCode != null && !programmeCode.equals("0")) {
				ps.setString(3, programmeCode);
			}

			rset = ps.executeQuery();
			while (rset.next()) {
				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(1) + " - "
						+ rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				works.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("Exception in works is " + e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (rset != null) {
					rset.close();
				}
			} catch (Exception e) {
				Debug.println("Get Works Exception in Closing ");
			}
		}

		return works;
	}

	/**
	 * Get the Works List BY Work Name
	 * 
	 * @param searchString
	 * @return
	 */
	public ArrayList getWorksByName(String searchString) {
		ArrayList works = new ArrayList();
		Connection conn = null;
		Statement ps = null;
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();
			String query = "select work_id,work_name from rws_work_admn_tbl where upper(work_name) like'%"
					+ searchString.toUpperCase() + "%'";
			Debug.println("query in getWorks is " + query);
			ps = conn.createStatement();

			rset = ps.executeQuery(query);
			while (rset.next()) {
				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(1) + " - "
						+ rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				works.add(labelValueBean);
			}
		} catch (Exception e) {
			System.out.println("Exception in works is " + e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (ps != null) {
					ps.close();
				}
				if (rset != null) {
					rset.close();
				}
			} catch (Exception e) {
				Debug.println("Get Works Exception in Closing ");
			}
		}

		return works;
	}
}
