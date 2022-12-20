/*
 * Created on 20-03-2013
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;

import nic.watersoft.commons.RwsOffices;

/**
 * @author RWSS_DPT1
 * 
 * TODO To change the template for this generated type comment go to Window -
 * Preferences - Java - Code Style - Code Templates
 */
public class RwsWorkLinkDAO {

	/**
	 * @param bean
	 * @param string
	 */
	public String getWorkDetails(RwsWorkLinkActionForm bean, String type,
			HttpServletRequest req) {

		Connection conn = null;
		Statement stmt = null, stmt1 = null;
		ResultSet rs = null, rs1 = null;
		String message = "";
		String query = "";
		String work_id = "";
		if (type.equals("oldwork")) {
			message = "Work ID Does Not Exists Or  Blocked";
			work_id = bean.getOldWorkId();
			query = "select work_name ,SANCTION_AMOUNT ,to_char(ADMIN_DATE,'dd/mm/yyyy'),p.programme_name,c.subprogramme_name from rws_work_admn_tbl a,rws_programme_tbl p,rws_subprogramme_tbl c where substr(a.work_id,1,2)=p.programme_code and p.programme_code=c.programme_code  and substr(a.work_id,3,2)= c.subprogramme_code and BLOCK_PAYMENT='Y'  and work_id='"
					+ bean.getOldWorkId() + "'";

		} else if (type.equals("newwork")) {
			message = "Should Not Allowed  Blocked Works";
			work_id = bean.getNewWorkId();
			query = "select work_name ,SANCTION_AMOUNT ,to_char(ADMIN_DATE,'dd/mm/yyyy'),p.programme_name,c.subprogramme_name from rws_work_admn_tbl a,rws_programme_tbl p,rws_subprogramme_tbl c where substr(a.work_id,1,2)=p.programme_code and p.programme_code=c.programme_code  and substr(a.work_id,3,2)= c.subprogramme_code and BLOCK_PAYMENT <> 'Y' and  work_id='"
					+ bean.getNewWorkId() + "'";
		}
		boolean flag = false;

		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);
			////System.out.println("Query:" + query);

			while (rs.next()) {
				flag = true;
				if (type.equals("oldwork")) {
					updateLinkDetails(bean, conn, req);
					bean.setOldWorkName(rs.getString(1));
					bean.setOldSanctionedAmount(rs.getString(2));
					bean.setOldSanctionedDate(rs.getString(3));
					bean.setOldProgram(rs.getString(4));
					bean.setOldSubProgName(rs.getString(5));

				} else if (type.equals("newwork")) {
					updateLinkNewDetails(bean, conn, req);
					bean.setNewWorkName(rs.getString(1));
					bean.setNewSanctionedAmount(rs.getString(2));
					bean.setNewSanctionedDate(rs.getString(3));
					bean.setNewProgram(rs.getString(4));
					bean.setNewSubProgName(rs.getString(5));

				}

			}
			if (type.equals("oldwork")) {
				String bankQuery = "select (select sum(BILL_AMOUNT_CENTRAL) from  RWS_bill_bank_bridge_det_TBL where work_id='"
						+ work_id
						+ "' and BILL_ACTIVATION_FLAG='P') a1,(select sum(BILL_AMOUT_STATE) from  RWS_bill_pao_bridge_det_TBL where work_id='"
						+ work_id
						+ "' and BILL_ACTIVATION_FLAG='P') a1 from dual";
				////System.out.println("bank" + bankQuery);
				stmt1 = conn.createStatement();
				rs1 = stmt.executeQuery(bankQuery);
				double tot = 0, bankAmount = 0, paoAmount = 0;
				while (rs1.next()) {
					if (rs1.getString(1) != null
							&& !rs1.getString(1).equals("")) {
						bankAmount = Double.parseDouble(rs1.getString(1));
					}
					if (rs1.getString(2) != null
							&& !rs1.getString(2).equals("")) {
						paoAmount = Double.parseDouble(rs1.getString(2));
					}
					tot = bankAmount + paoAmount;
					tot /= 100000;
				}
				bean.setOldReleasesSoFar(String.valueOf(tot));
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (stmt != null) {
					stmt.close();
				}
				if (stmt1 != null) {
					stmt.close();
				}
			} catch (Exception e) {
				e.printStackTrace();

			}
		}
		if (!flag) {
			return message;
		}
		return "";

	}

	/**
	 * @param bean
	 * @param conn
	 * @param req
	 */
	private void updateLinkNewDetails(RwsWorkLinkActionForm bean,
			Connection conn, HttpServletRequest req) {
		Statement stmt = null, stmt1 = null;
		ResultSet rs = null, rs1 = null;
		String query = "";
		String work_id = "";

		String q1 = "select WORK_ID_NEW from rws_work_prog_convert_lnk_tbl where work_id='"
				+ bean.getOldWorkId() + "'";
		try {
			stmt1 = conn.createStatement();
			rs1 = stmt1.executeQuery(q1);
			if (rs1.next()) {
				req.setAttribute("saved", "true");
			}
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

	}

	/**
	 * @param bean
	 * @param req
	 */
	private void updateLinkDetails(RwsWorkLinkActionForm bean, Connection conn,
			HttpServletRequest req) {
		Statement stmt = null, stmt1 = null;
		ResultSet rs = null, rs1 = null;
		String query = "";
		String work_id = "";

		String q1 = "select WORK_ID_NEW from rws_work_prog_convert_lnk_tbl where work_id='"
				+ bean.getOldWorkId() + "'";
		try {
			stmt1 = conn.createStatement();
			rs1 = stmt1.executeQuery(q1);
			while (rs1.next()) {
				work_id = rs1.getString(1);
			}

			query = "select work_name ,SANCTION_AMOUNT ,to_char(ADMIN_DATE,'dd/mm/yyyy'),p.programme_name,c.subprogramme_name,a.work_id from rws_work_admn_tbl a,rws_programme_tbl p,rws_subprogramme_tbl c   where  substr(a.work_id,1,2)=p.programme_code and p.programme_code=c.programme_code  and substr(a.work_id,3,2)= c.subprogramme_code  and a.work_id='"
					+ work_id + "'";
			//System.out.println("Query:" + query);

			stmt = conn.createStatement();
			rs = stmt.executeQuery(query);

			while (rs.next()) {
				req.setAttribute("saved", "true");
				bean.setNewWorkName(rs.getString(1));
				bean.setNewSanctionedAmount(rs.getString(2));
				bean.setNewSanctionedDate(rs.getString(3));
				bean.setNewProgram(rs.getString(4));
				bean.setNewSubProgName(rs.getString(5));
				bean.setNewWorkId(rs.getString(6));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (stmt1 != null) {
					stmt1.close();
				}

			} catch (Exception e) {
				e.printStackTrace();

			}
		}

	}

	/**
	 * @param bean
	 * @param userId
	 */
	public String saveWork(RwsWorkLinkActionForm bean, String userId) {
		Connection conn = null;
		Statement stmt = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String insertQuery = "insert into rws_work_prog_convert_lnk_tbl values('"
					+ bean.getOldWorkId()
					+ "','"
					+ bean.getNewWorkId()
					+ "','"
					+ userId + "',sysdate)";
			//System.out.println("Insert Query:" + insertQuery);
			int count = stmt.executeUpdate(insertQuery);
			if (count > 0) {
				return "Record Saved Successfully";
			} else {
				return "Failed....";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "Failed....";

	}

	/**
	 * @param bean
	 * @param userId
	 * @return
	 */
	public String updateWork(RwsWorkLinkActionForm bean, String userId) {
		Connection conn = null;
		Statement stmt = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String updateQuery = "update  rws_work_prog_convert_lnk_tbl  set WORK_ID_NEW='"
					+ bean.getNewWorkId()
					+ "',ENTERED_BY='"
					+ userId
					+ "',ENTERED_ON=sysdate where work_id='"
					+ bean.getOldWorkId() + "'";
			//System.out.println("Update Query:" + updateQuery);
			int count = stmt.executeUpdate(updateQuery);
			if (count > 0) {
				return "Record Updated Successfully";
			} else {
				return "Failed....";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "Failed....";
	}
}