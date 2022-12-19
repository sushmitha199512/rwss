/*
 * Created on 6-06-2013
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.masters.RwsContractorHashDAO;

/**
 * @author RWSS_DPT1
 * 
 *         TODO To change the template for this generated type comment go to
 *         Window - Preferences - Java - Code Style - Code Templates
 */
public class RwsWorkBillDAOImpl {

	/**
	 * @return
	 */
	public ArrayList getAgencyList(String workId) {

		Connection conn = null;
		Statement stmt = null, stmt1 = null;
		ResultSet rs = null, rs1 = null;
		ArrayList agencyList = new ArrayList();

		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			stmt1 = conn.createStatement();

			// a.CONTRACTOR_CODE,nvl(a.CONTRACTOR_NAME_COMPANY,' '),nvl(a.CONTRACTOR_COMPANY_NAME1,' '),nvl(a.CONTRACTOR_COMPANY_NAME2,' ')
			// ,c.IFSC_CODE,c.ACCOUNT_NO,d.BANK,a.HASH_VALUE

			String query = "select b.CONTRACTOR_CODE,b.CONTRACTOR_NAME_COMPANY,nvl(CONTRACTOR_COMPANY_NAME1,' '),nvl(CONTRACTOR_COMPANY_NAME2,' '),c.IFSC_CODE,c.ACCOUNT_NO,d.BANK,b.HASH_VALUE from rws_contractor_selection_tbl a,rws_contractor_tbl b,rws_contractor_bank_lnk_tbl c ,rwS_BANK_IFSC_CODE_TBL  d  where a.contractor_code=b.contractor_code  and c.contractor_code=a.contractor_code and c.ifsc_code=d.ifsc_code and a.work_id='"
					+ workId + "'";
			rs = stmt.executeQuery(query);

			while (rs.next()) {
				String cDetails = rs.getString(1) + rs.getString(2)
						+ rs.getString(3) + rs.getString(4) + rs.getString(7)
						+ rs.getString(5) + rs.getString(6);

				/**
				 * Verify conrtractor to check whether it is cortrect contractor
				 * or not.
				 */
				if (verifyContractor(cDetails, rs.getString(8))) {
					LabelValueBean labelValueBean = new LabelValueBean();
					labelValueBean.setLabel(rs.getString(2) + rs.getString(3)
							+ rs.getString(4));
					labelValueBean.setValue(rs.getString(1));
					agencyList.add(labelValueBean);
				}

			}

			// Mapping Contractors

			query = "select b.CONTRACTOR_CODE,b.CONTRACTOR_NAME_COMPANY,nvl(CONTRACTOR_COMPANY_NAME1,' '),nvl(CONTRACTOR_COMPANY_NAME2,' '),c.IFSC_CODE,c.ACCOUNT_NO,d.BANK,b.HASH_VALUE  from RWS_WORK_CONTRACTOR_MAP_TBL a,rws_contractor_tbl b,rws_contractor_bank_lnk_tbl c ,rwS_BANK_IFSC_CODE_TBL  d  where a.contractor_code=b.contractor_code and c.contractor_code=a.contractor_code and c.ifsc_code=d.ifsc_code and a.work_id='"
					+ workId + "'";
			rs1 = stmt1.executeQuery(query);

			while (rs1.next()) {

				String cDetails = rs1.getString(1) + rs1.getString(2)
						+ rs1.getString(3) + rs1.getString(4) + rs1.getString(7)
						+ rs1.getString(5) + rs1.getString(6);

				/**
				 * Verify conrtractor to check whether it is cortrect contractor
				 * or not.
				 */
				if (verifyContractor(cDetails, rs1.getString(8))) {
					LabelValueBean labelValueBean = new LabelValueBean();
					labelValueBean.setLabel(rs1.getString(2) + rs1.getString(3)
							+ rs1.getString(4));
					labelValueBean.setValue(rs1.getString(1));
					agencyList.add(labelValueBean);

				}
			}

			// EE Account

			LabelValueBean labelValueBean = new LabelValueBean();
			labelValueBean.setLabel("EE-Acount");
			labelValueBean.setValue("EE");
			agencyList.add(labelValueBean);

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
				if (stmt1 != null) {
					stmt1.close();
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

		return agencyList;
	}

	/**
	 * 
	 * @param cDetails
	 * @param dbHashValue
	 * @return
	 */
	private boolean verifyContractor(String cDetails, String dbHashValue) {

		RwsContractorHashDAO contractorHashDAO = new RwsContractorHashDAO();

		String contractorHashValue = contractorHashDAO
				.getContractorEncodedValue(cDetails);

		if (dbHashValue == null || dbHashValue.equals("null")) {
			return false;
		}
		if (dbHashValue != null && contractorHashValue != null
				&& dbHashValue.equals(contractorHashValue)) {
			return true;
		}

		return false;
	}

}