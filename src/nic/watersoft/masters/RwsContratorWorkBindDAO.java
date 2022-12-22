/*
 * Created on 29-05-2013
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.masters;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUtils;

/**
 * @author RWSS_DPT1(Sai Prasad N)
 * 
 *         TODO To change the template for this generated type comment go to
 *         Window - Preferences - Java - Code Style - Code Templates
 */
public class RwsContratorWorkBindDAO {

	/**
	 * @param string
	 * @param circleCode
	 * @return
	 */
	public ArrayList getWorks(String circle, String div) {

		ArrayList works = new ArrayList();
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs1 = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String query = "select a.work_id,a.work_name from rws_work_admn_tbl a,rws_contractor_selection_tbl b,rws_work_commencement_tbl c  where  substr(a.office_code,2,2)='"
					+ circle
					+ "' and substr(a.office_code,4,1)='"
					+ div
					+ "' and a.work_id=c.work_id and a.work_id=b.work_id and A.TYPE_OF_ASSET='03'  and GROUNDING_DATE is not null and a.work_id not in(select work_id from rws_work_completion_tbl where DT_FIN_COMPLETION is not null)";
			stmt.executeQuery(query);

			System.out.println("main Query:" + query);
			rs1 = stmt.executeQuery(query);
			while (rs1.next()) {
				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs1.getString(1));
				labelValueBean.setLabel(rs1.getString(1) + "--"
						+ rs1.getString(2));
				works.add(labelValueBean);

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs1 != null) {
					rs1.close();
				}
				if (conn != null) {
					conn.close();
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		return works;
	}

	/**
	 * @param workForm
	 */
	public void getWorkDetails(RwsContratorWorkBindBean workForm) {

		Connection conn = null;
		Statement stmt = null, stmt2 = null, stmt3 = null, stmt4 = null, stmt5 = null, stmt6 = null;
		ResultSet rs1 = null, rs2 = null, rs4 = null, rs3 = null, rs5 = null, rs6 = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			stmt2 = conn.createStatement();
			stmt3 = conn.createStatement();
			stmt4 = conn.createStatement();
			stmt5 = conn.createStatement();
			stmt6 = conn.createStatement();

			String query = "select a.work_id,a.work_name,c.programme_name,d.subprogramme_name,to_char(a.ADMIN_DATE,'dd/MM/yyyy'),a.SANCTION_AMOUNT,co.circle_office_name,do.division_office_name  from rws_work_admn_tbl a ,rws_programme_tbl c,rws_subprogramme_tbl d,rws_circle_office_tbl co,rws_division_office_tbl do where a.work_id='"
					+ workForm.getWorkIdList()
					+ "' and a.PROGRAMME_CODE=c.PROGRAMME_CODE and a.PROGRAMME_CODE=d.PROGRAMME_CODE and a.SUBPROGRAMME_CODE=d.SUBPROGRAMME_CODE  and co.circle_office_code=substr(a.office_code,2,2) and do.circle_office_code=co.circle_office_code and do.division_office_code=substr(a.office_code,4,1)";

			stmt.executeQuery(query);

			System.out.println("main Query:" + query);
			rs1 = stmt.executeQuery(query);
			while (rs1.next()) {
				workForm.setWorkid(rs1.getString(1));
				workForm.setWorkName(rs1.getString(2));
				workForm.setProgram(rs1.getString(3));
				workForm.setSubProgName(rs1.getString(4));
				workForm.setSanctionedDate(rs1.getString(5));
				workForm.setSanctionedAmount(rs1.getString(6));
				workForm.setCircle(rs1.getString(7));
				workForm.setDivision(rs1.getString(8));

			}

			String mileStoneQuery = "select (sum(PERCENT_COMPLETED_WORK_VAL)/100000) from rws_milestone_target_ach_tbl where work_id='"
					+ workForm.getWorkIdList() + "'";
			System.out.println("Mile" + mileStoneQuery);
			rs4 = stmt2.executeQuery(mileStoneQuery);
			if (rs4.next()) {
				workForm.setMileStoneAmount(rs4.getString(1));
			} else {
				workForm.setMileStoneAmount("0");
			}

			String contractorDet = "select b.CONTRACTOR_CODE, b.CONTRACTOR_NAME_COMPANY,nvl(CONTRACTOR_COMPANY_NAME1,' '),nvl(CONTRACTOR_COMPANY_NAME2,' ')   from rws_contractor_selection_tbl a,rws_contractor_tbl b where  a.work_id='"
					+ workForm.getWorkIdList()
					+ "' and a.CONTRACTOR_CODE=b.CONTRACTOR_CODE";
			System.out.println("contractorDet" + contractorDet);
			rs2 = stmt3.executeQuery(contractorDet);

			ArrayList contractRec = new ArrayList();

			workForm.setContractorList(contractRec);

			if (rs2.next()) {
				RwsContractorRecord rwsContractorRecord = new RwsContractorRecord();
				rwsContractorRecord.setContractorCode(rs2.getString(1));
				rwsContractorRecord.setContractorName(rs2.getString(2)
						+ rs2.getString(3) + rs2.getString(4));
				rwsContractorRecord.setPrimaryContractor("yes");

				String bankdet = "select  d.ifsc_code,d.bank,c.ACCOUNT_NO ,d.BRANCH_NAME from rws_contractor_tbl b,rws_contractor_bank_lnk_tbl c ,rwS_BANK_IFSC_CODE_TBL  D where  b.CONTRACTOR_CODE='"
						+ rs2.getString(1)
						+ "' and c.CONTRACTOR_CODE=b.CONTRACTOR_CODE and  c.ifsc_code=d.ifsc_code";
				System.out.println("bankdet" + bankdet);
				rs3 = stmt4.executeQuery(bankdet);
				if (rs3.next()) {
					rwsContractorRecord.setIfscCode(rs3.getString(1));
					rwsContractorRecord.setBankName(rs3.getString(2));
					rwsContractorRecord.setAccountNo(rs3.getString(3));
					rwsContractorRecord.setBranchName(rs3.getString(4));

				} else {

					rwsContractorRecord.setIfscCode("-");
					rwsContractorRecord.setBankName("-");
					rwsContractorRecord.setAccountNo("-");
					rwsContractorRecord.setBranchName("-");

				}
				contractRec.add(rwsContractorRecord);

			}

			String cQuery = "select b.contractor_code,b.CONTRACTOR_NAME_COMPANY,nvl(CONTRACTOR_COMPANY_NAME1,' '),nvl(CONTRACTOR_COMPANY_NAME2,' ')  from RWS_WORK_CONTRACTOR_MAP_TBL a,rws_contractor_tbl b where a.contractor_code=b.contractor_code and a.work_id='"
					+ workForm.getWorkIdList() + "'";

			rs5 = stmt5.executeQuery(cQuery);

			while (rs5.next()) {
				RwsContractorRecord rwsContractorRecord = new RwsContractorRecord();
				rwsContractorRecord.setContractorCode(rs5.getString(1));
				rwsContractorRecord.setContractorName(rs5.getString(2)
						+ rs5.getString(3) + rs5.getString(4));

				String bankdet = "select  d.ifsc_code,d.bank,c.ACCOUNT_NO,d.BRANCH_NAME  from rws_contractor_tbl b,rws_contractor_bank_lnk_tbl c ,rwS_BANK_IFSC_CODE_TBL  D where  b.CONTRACTOR_CODE='"
						+ rs5.getString(1)
						+ "' and c.CONTRACTOR_CODE=b.CONTRACTOR_CODE and  c.ifsc_code=d.ifsc_code";
				System.out.println("bankdet" + bankdet);
				rs6 = stmt6.executeQuery(bankdet);
				if (rs6.next()) {
					rwsContractorRecord.setIfscCode(rs6.getString(1));
					rwsContractorRecord.setBankName(rs6.getString(2));
					rwsContractorRecord.setAccountNo(rs6.getString(3));
					rwsContractorRecord.setBranchName(rs6.getString(4));

				} else {

					rwsContractorRecord.setIfscCode("-");
					rwsContractorRecord.setBankName("-");
					rwsContractorRecord.setAccountNo("-");
					rwsContractorRecord.setBranchName("-");

				}

				contractRec.add(rwsContractorRecord);
			}
			workForm.setContractorList(contractRec);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs1 != null) {
					rs1.close();
				}
				if (stmt2 != null) {
					stmt2.close();
				}
				if (stmt3 != null) {
					stmt3.close();
				}
				if (stmt4 != null) {
					stmt4.close();
				}
				if (stmt5 != null) {
					stmt5.close();
				}
				if (rs5 != null) {
					rs5.close();
				}
				if (rs4 != null) {
					rs4.close();
				}
				if (rs2 != null) {
					rs2.close();
				}
				if (rs3 != null) {
					rs3.close();
				}
				if (conn != null) {
					conn.close();
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

		}

	}

	public String hashString(String s) {
		byte[] hash = null;
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			hash = md.digest(s.getBytes());

		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < hash.length; ++i) {
			String hex = Integer.toHexString(hash[i]);
			if (hex.length() == 1) {
				sb.append(0);
				sb.append(hex.charAt(hex.length() - 1));
			} else {
				sb.append(hex.substring(hex.length() - 2));
			}
		}
		return sb.toString();
	}

	/**
	 * @param workForm
	 */
	public int audhendicate(RwsContratorWorkBindBean workForm) {

		String contractotDetails = workForm.getContractorId()
				+ workForm.getContractorName() + workForm.getBank()
				+ workForm.getBankIFSC() + workForm.getContractorACC();

		Connection conn = null;
		int count = 0;
		Statement stmt = null;
		String currentDate = RwsUtils.getCurrentDate("dd/MM/yyyy");
		try {
			String hashValue = hashString(contractotDetails);
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String insertQuery = "";
			PreparedStatement ps=null;
			if (!checkAudhendication(workForm, conn)) {
				insertQuery = "insert into rws_contractor_work_bind_tbl values(?,?,?,to_date(?,'dd/mm/yyyy')";
				 ps=conn.prepareStatement(insertQuery);
				 ps.setString(1, workForm.getWorkid());
				 ps.setString(2,  workForm.getContractorId());
				 ps.setString(3, hashValue);
				 ps.setString(4, currentDate);
				
			} else {
				insertQuery = "update rws_contractor_work_bind_tbl set CONTRACTOR_DETAILS=?"
						+ ",DATE_OF_APPROVAL =to_date(?"
						+ ",'dd/mm/yyyy') where  WORK_ID=?"
						+ " and CONTRACTOR_CODE=?";
				ps=conn.prepareStatement(insertQuery);
				 ps.setString(1, hashValue);
				 ps.setString(2,  currentDate);
				 ps.setString(3,workForm.getWorkid());
				 ps.setString(4,workForm.getContractorId());
			}
			System.out.println("insertQuery" + insertQuery);
			count = ps.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	/**
	 * @param workForm
	 * @param conn
	 * @return
	 */
	private boolean checkAudhendication(RwsContratorWorkBindBean workForm,
			Connection conn) {

		Statement stmt = null;
		ResultSet rs = null;
		try {

			stmt = conn.createStatement();
			String query = "select * from rws_contractor_work_bind_tbl where WORK_ID='"
					+ workForm.getWorkid()
					+ "' and CONTRACTOR_CODE='"
					+ workForm.getContractorId() + "'";
			rs = stmt.executeQuery(query);
			if (rs.next()) {
				return true;

			} else {
				return false;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}

				if (rs != null) {
					rs.close();
				}
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		return false;
	}

	/**
	 * To Check the Contractor Audhendicated Or Not
	 * 
	 * @param workForm
	 * @param conn
	 * @return
	 */
	public boolean isAdhendicated(RwsContratorWorkBindBean workForm,
			Connection conn) {

		String contractotDetails = workForm.getContractorId()
				+ workForm.getContractorName() + workForm.getBank()
				+ workForm.getBankIFSC() + workForm.getContractorACC();

		String hashValue = hashString(contractotDetails);

		Statement stmt = null;
		ResultSet rs = null;
		try {

			stmt = conn.createStatement();
			String query = "select CONTRACTOR_DETAILS   from rws_contractor_work_bind_tbl where WORK_ID='"
					+ workForm.getWorkid()
					+ "' and CONTRACTOR_CODE='"
					+ workForm.getContractorId() + "'";

			rs = stmt.executeQuery(query);
			if (rs.next()) {
				if (rs.getString(1) != null && !rs.getString(1).equals("")
						&& rs.getString(1).equals(hashValue)) {
					return true;
				} else {
					return false;
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}

				if (rs != null) {
					rs.close();
				}
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		return false;

	}

	/**
	 * @param workForm
	 */
	public void getAuthendicatedList(RwsContratorWorkBindBean workForm) {
		// TODO Auto-generated method stub

	}

	public void getAllContractors(RwsContratorWorkBindBean workForm) {

		if (workForm.getAllContractorsList() == null) {
			workForm.setAllContractorsList(new ArrayList());
		}

		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {

			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			String query = "select a.contractor_code,CONTRACTOR_NAME_COMPANY,nvl(CONTRACTOR_COMPANY_NAME1,' '),nvl(CONTRACTOR_COMPANY_NAME2,' ') from rws_contractor_tbl a,rws_contractor_bank_lnk_tbl b ,rwS_BANK_IFSC_CODE_TBL  c where a.contractor_code=b.contractor_code and b.IFSC_CODE=c.IFSC_CODE  order by CONTRACTOR_NAME_COMPANY asc";
			rs = stmt.executeQuery(query);

			while (rs.next()) {
				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setLabel(rs.getString(2) + rs.getString(3)
						+ rs.getString(4));
				labelValueBean.setValue(rs.getString(1));
				workForm.getAllContractorsList().add(labelValueBean);
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

				if (rs != null) {
					rs.close();
				}
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}

	}

	public void saveContractor(RwsContratorWorkBindBean workForm,
			HttpServletRequest request) {

		// RWS_WORK_CONTRACTOR_MAP_TBL

		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {

			conn = RwsOffices.getConn();
			stmt = conn.createStatement();

			if (!checkIsExists(conn, workForm)) {
				String insertQuery = "insert into RWS_WORK_CONTRACTOR_MAP_TBL values(?,?)";
				
				System.out.println("Insert Query:" + insertQuery);
				PreparedStatement ps=conn.prepareStatement(insertQuery);
				ps.setString(1, workForm.getWorkIdList());
				ps.setString(2,workForm.getCcode());

				int r = ps.executeUpdate();
				if (r > 0) {
					request.setAttribute("message", "Saved Successfully.");
				} else {
					request.setAttribute("message", "Saved Failed.");
				}
			} else {
				request.setAttribute("message", "Already Contractor Exists.");
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

				if (rs != null) {
					rs.close();
				}
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}

	}

	private boolean checkIsExists(Connection conn,
			RwsContratorWorkBindBean workForm) {
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			String selectQuery = "select *from RWS_WORK_CONTRACTOR_MAP_TBL where work_id='"
					+ workForm.getWorkIdList()
					+ "' and contractor_code='"
					+ workForm.getCcode() + "'";
			System.out.println("Sele:" + selectQuery);
			rs = stmt.executeQuery(selectQuery);
			if (rs.next()) {
				return true;
			} else {
				return false;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {

				if (stmt != null) {
					stmt.close();
				}

				if (rs != null) {
					rs.close();
				}
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		return false;
	}

	public void deleteContractor(RwsContratorWorkBindBean workForm,
			String ccode, HttpServletRequest request) {

		// RWS_WORK_CONTRACTOR_MAP_TBL

		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {

			conn = RwsOffices.getConn();
			stmt = conn.createStatement();

			if (checkIsDelete(conn, request, workForm.getWorkIdList(), ccode)) {

				String deleteQuery = "delete from RWS_WORK_CONTRACTOR_MAP_TBL where work_id=? And contractor_code=?";
				System.out.println("Delete Query:" + deleteQuery);
                PreparedStatement ps=conn.prepareStatement(deleteQuery);
                ps.setString(1, workForm.getWorkIdList());
                ps.setString(2, ccode);
				int r = ps.executeUpdate();
				if (r > 0) {
					request.setAttribute("message", "Deleted Successfully");
				} else {
					request.setAttribute("message", "Delete Failed");
				}
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

				if (rs != null) {
					rs.close();
				}
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}

	}

	private boolean checkIsDelete(Connection conn, HttpServletRequest request,
			String workId, String ccode) {

		Statement stmt = null;
		ResultSet rs = null;
		try {

			stmt = conn.createStatement();

			String selectQuery = "select  *from RWS_WORK_BILL_TBL  where work_id='"
					+ workId
					+ "' and AGENCY_TO_PAY <>'EE' AND AGENCY_TO_PAY='"
					+ ccode + "'";
			System.out.println("selectQuery Query:" + selectQuery);

			rs = stmt.executeQuery(selectQuery);
			if (rs.next()) {
				request
						.setAttribute("message",
								"Deletion Failed. Due To Selected Conrtactor Having Bills.");
				return false;
			} else {
				return true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}

				if (rs != null) {
					rs.close();
				}
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}

		return false;
	}
}