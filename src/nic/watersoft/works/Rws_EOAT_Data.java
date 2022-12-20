package nic.watersoft.works;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import javax.sql.DataSource;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.DAOMessage;
import nic.watersoft.commons.RwsOffices;

public class Rws_EOAT_Data {

	public Connection conn;
	public Statement stmt;
	public Statement stmt2;
	public Statement stmt3;
	public PreparedStatement pstmt;
	public ResultSet rs;
	public ResultSet rs1;
	public ResultSet rs2;
	public ResultSet rs3;
	public ResultSet rs4;

	public void closeAll() {

		if (rs != null) {
			try {
				rs.close();
			} catch (Exception e) {
				// System.out.println("The error in rwsMasterData" + e);
			}
			rs = null;
		}
		if (rs1 != null) {
			try {
				rs1.close();
			} catch (Exception e) {
				// System.out.println("The error in rwsMasterData" + e);
			}
			rs1 = null;
		}
		if (rs2 != null) {
			try {
				rs2.close();
			} catch (Exception e) {
				// System.out.println("The error in rwsMasterData" + e);
			}
			rs2 = null;
		}
		if (rs3 != null) {
			try {
				rs3.close();
			} catch (Exception e) {
				// System.out.println("The error in rwsMasterData" + e);
			}
			rs3 = null;
		}
		if (rs4 != null) {
			try {
				rs4.close();
			} catch (Exception e) {
				// System.out.println("The error in rwsMasterData" + e);
			}
			rs4 = null;
		}

		if (stmt != null) {
			try {
				stmt.close();
			} catch (Exception e) {
				// System.out.println("The error in closeAll=" + e);
			}
			stmt = null;
		}

		if (stmt2 != null) {
			try {
				stmt2.close();
			} catch (Exception e) {
				// System.out.println("The error in closeAll=" + e);
			}
			stmt2 = null;
		}
		if (stmt3 != null) {
			try {
				stmt3.close();
			} catch (Exception e) {
				// System.out.println("The error in closeAll=" + e);
			}
			stmt3 = null;
		}

		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (Exception e) {
				// System.out.println("The error in closeAll=" + e);
			}
			pstmt = null;
		}

		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
				// System.out.println("The error in closeAll=" + e);
			}
			conn = null;
		}

	}

	public ArrayList getWorkIdsEligibleForEoat(String circleOfficeCode, String divisionOfficeCode,
			String subDivisionOfficeCode, String date_of_completion, String workcategory) {

		Connection conn = null;
		LabelValueBean labelValueBean = null;
		ArrayList workIdList = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			StringBuffer sqlQuery = new StringBuffer();
			stmt = conn.createStatement();

			sqlQuery.append(
					"select admn.work_id,admn.work_name  from rws_work_admn_tbl ADMN,RWS_CONTRACTOR_SELECTION_TBL C WHERE ADMN.WORK_ID=C.WORK_ID"
							+ " AND ADMN.CATEGORY_CODE='" + workcategory
							+ "' AND ADMN.WORK_ID NOT IN (SELECT WORK_ID FROM rws_work_completion_tbl com where com.DATE_OF_COMPLETION is not null) and"
							+ " substr(admn.office_code,2,2)='" + circleOfficeCode
							+ "' and substr(admn.office_code,4,1)='" + divisionOfficeCode + "'");

			if (subDivisionOfficeCode != null && !subDivisionOfficeCode.equals("")) {
				sqlQuery.append(" and substr(admn.office_code,5,2)='" + subDivisionOfficeCode + "'");

			}
			sqlQuery.append(
					" and C.DATE_OF_COMPLETION is not null and C.DATE_OF_COMPLETION < '" + date_of_completion + "'");

			rs = stmt.executeQuery(sqlQuery.toString());
			while (rs.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs.getString("work_id"));
				labelValueBean.setLabel(rs.getString("work_id") + "-" + rs.getString("work_name"));
				workIdList.add(labelValueBean);
			}
		} catch (Exception e) {
			Debug.println("Exception occured in getWorkIdsEligibleForEoat in Rws_EOAT_Data -- " + e);
		} finally {
			closeAll();
		}
		return workIdList;
	}

	public ArrayList getProgrammes(String workid) throws Exception {
		ArrayList programmes = new ArrayList();
		LabelValueBean labelValueBean = null;
		try {
			conn = RwsOffices.getConn();
			String query = "select a.programme_code,a.programme_name FROM rws_programme_tbl a,rws_work_admn_tbl b "
					+ "where a.programme_code=b.programme_code and work_id=? ";

			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, workid);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs.getString(1));
				labelValueBean.setLabel(rs.getString(2));
				programmes.add(labelValueBean);
			}
		} catch (Exception e) {
			Debug.println("Exception in getprogrammes of Rws_EOAT_Data -- " + e);
		} finally {
			closeAll();
		}
		return programmes;
	}

	public ArrayList getOfficers(String ccode, String divcode, String sdcode) throws Exception {
		ArrayList officers = new ArrayList();
		LabelValueBean labelValueBean = null;
		try {

			conn = RwsOffices.getConn();
			String query = "select employee_code,employee_name from rws_employee_tbl where substr(office_code,2,2)=? "
					+ "order by employee_code DESC";

			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, ccode);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs.getString(1));
				labelValueBean.setLabel(rs.getString(1) + "-" + rs.getString(2));
				officers.add(labelValueBean);
			}
		} catch (Exception e) {
			Debug.println("Exception in getOfficers of Rws_EOAT_Data -- " + e);
		} finally {
			closeAll();
		}
		return officers;
	}

	public String getCostList(String workid) {
		String cost = null;
		try {
			conn = RwsOffices.getConn();
			String qry = "select nvl(sanction_amount,'0') from rws_work_admn_tbl where work_id=? ";
			pstmt = conn.prepareStatement(qry);
			pstmt.setString(1, workid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				cost = rs.getString(1);
			}

		} catch (Exception e) {
			Debug.println("exception in Getting cost of work in Rws_EOAT_Data--" + e);
		} finally {
			closeAll();
		}

		return cost;
	}

	public String getDoc(String workid) throws Exception {
		String doc = null;
		try {
			conn = RwsOffices.getConn();
			String qry = "select to_char(date_of_completion,'dd/mm/yyyy') from rws_contractor_selection_tbl where work_id=? ";
			pstmt = conn.prepareStatement(qry);
			pstmt.setString(1, workid);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				doc = rs.getString(1);
			}

		} catch (Exception e) {
			Debug.println("Exception in getDoc of Rws_EOAT_Data :" + e);
		} finally {
			closeAll();
		}

		return doc;
	}

	public DAOMessage insertEoat(Rws_EOAT_bean bean) {
		Connection conn = null;
		DAOMessage daoMessage = new DAOMessage();
		int rowsEffected = 0;
		PreparedStatement ps = null;
		try {
			conn = RwsOffices.getConn();

			String sqlQuery = "";

			String sqlQuery1 = "select * from rws_eoat_tbl where work_id=? and EOAT_ORDER_NO=? ";
			pstmt = conn.prepareStatement(sqlQuery1);
			pstmt.setString(1, bean.getWorkId());
			pstmt.setString(2, bean.getEoatOrderNo());
			rs = pstmt.executeQuery();
			if (!rs.next()) {

				sqlQuery = "insert into rws_eoat_tbl(" + "CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE,"
						+ "SUBDIVISION_OFFICE_CODE,WORK_ID," + "VALUE_OF_WORK_DONE,COST_OF_WORK,"
						+ "VALUE_OF_WORK_BEYOND_AGREE,VALUE_OF_WORK_TO_BE_DONE,"
						+ "EOAT_ORDER_NO,EOAT_DATE,COST_ESCALATION_SOUGHT,"
						+ "EOAT_PERIOD,EOAT_OLD_REF_NO1,EOAT_OLD_REF_DT1,"
						+ "EOAT_OLD_REF_NO2,EOAT_OLD_RED_DT2,FINE_IMPOSED,"
						+ "FINE_RECOVERED,REASONS_FOR_NOT_RECOV_FINE,OFFICER_RESP1,"
						+ "OFFICER_RESP2,OFFICER_RESP3,EXEMPT_RECOMM_BY_SE,"
						+ "TOTAL_DAYS_EXEMPT_BY_SE,RATE_OF_PENALTY,TOTAL_PENALITY,"
						+ "REASONS_BY_CONTRACTOR,CONTRACTOR_REP_MADE_UPD,AGREEMENT_COPY_PENALITY_UPD,"
						+ "SUPP_DOCUMENT_FOR_EXEMP_UPD,AEE_RECOMMEND,DEE_RECOMMEND,"
						+ "EE_RECOMMEND,SE_RECOMMEND,CE_RECOMMEND,"
						+ "EOAT_GRANT_AUTHORITY,SUPP_AGREE_NO,SUPP_AGREE_DT,"
						+ "PREPARED_BY,PREPARED_DATE,PROGRAMME_CODE) values(?,?,?,?,?,?,?,?,?,"
						+ "to_date(?,'dd/mm/yyyy'),?,?,?," + "to_date(?,'dd/mm/yyyy'),?,"
						+ "to_date(?,'dd/mm/yyyy'),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,"
						+ "to_date(?,'dd/mm/yyyy'),?," + "to_date(?,'dd/mm/yyyy'),?)";

				ps = conn.prepareStatement(sqlQuery);
				ps.setString(1, bean.getCircleOfficeCode());
				ps.setString(2, bean.getDivisionOfficeCode());
				ps.setString(3, bean.getSubDivisionOfficeCode());
				ps.setString(4, bean.getWorkId());
				ps.setString(5, bean.getValueOfWorkDone());
				ps.setString(6, bean.getCostOfWork());
				ps.setString(7, bean.getValueOfWorkBeyondAgreement());
				ps.setString(8, bean.getValueOfWorkToBeDone());
				ps.setString(9, bean.getEoatOrderNo());
				ps.setString(10, bean.getEoatDate());
				ps.setString(11, bean.getCostEsclationSought());
				ps.setString(12, bean.getEoatPeriod());
				ps.setString(13, bean.getEoatOldRefNo1());
				ps.setString(14, bean.getEoatOldRefDate1());
				ps.setString(15, bean.getEoatOldRefNo2());
				ps.setString(16, bean.getEoatOldRefDate2());
				ps.setString(17, bean.getFineImposed());
				ps.setString(18, bean.getFineRecovered());
				ps.setString(19, bean.getReasonsForNotRecoveringFine());
				ps.setString(20, bean.getOfficerResponsible1());
				ps.setString(21, bean.getOfficerResponsible2());
				ps.setString(22, bean.getOfficerResponsible3());
				ps.setString(23, bean.getExemptRecommendedBySE());
				ps.setString(24, bean.getTotalDaysExemptBySe());
				ps.setString(25, bean.getRateOfPenalty());
				ps.setString(26, bean.getTotalPenalty());
				ps.setString(27, bean.getReasonsByContractor());
				ps.setString(28, bean.getContractorRepMadeUpd());
				ps.setString(29, bean.getAgreementCopyPenaltyUpd());
				ps.setString(30, bean.getSuppDocumentForExempUpd());
				ps.setString(31, bean.getAeeRecommend());
				ps.setString(32, bean.getDeeRecommend());
				ps.setString(33, bean.getEeRecommend());
				ps.setString(34, bean.getSeRecommend());
				ps.setString(35, bean.getCeRecommend());
				ps.setString(36, bean.getEoatGrantAuthority());
				ps.setString(37, bean.getSuppAgreeNo());
				ps.setString(38, bean.getSuppAgreeDt());
				ps.setString(39, bean.getPreparedBy());
				ps.setString(40, bean.getPreparedDate());
				ps.setString(41, bean.getProgrammeCode());

				rowsEffected = ps.executeUpdate();

			}
			daoMessage.setRowCount(rowsEffected);
			if (rowsEffected > 0) {
				daoMessage.setOperationSussess(true);
				daoMessage.setMessage("Record Inserted Successfully");
			} else {
				daoMessage.setOperationSussess(false);
				daoMessage.setMessage("EOAT already Existed with this work ");

			}

		} catch (Exception e) {
			Debug.println("Exception occured in insertEoat of Rws_EOAT_Data -- " + e);

		} finally {
			closeAll();
		}
		return daoMessage;
	}

	public DAOMessage updateEoat(Rws_EOAT_bean bean) {
		Connection conn = null;
		DAOMessage daoMessage = new DAOMessage();
		int rowsEffected = 0;
		PreparedStatement ps = null;
		try {
			conn = RwsOffices.getConn();

			String sqlQuery = "";
			sqlQuery = "update rws_eoat_tbl set "

					+ "VALUE_OF_WORK_DONE=? ,VALUE_OF_WORK_BEYOND_AGREE=?,VALUE_OF_WORK_TO_BE_DONE=?,"
					+ "EOAT_DATE=to_date(?,'dd/mm/yyyy')" + ",COST_ESCALATION_SOUGHT=?,EOAT_PERIOD=?,"
					+ "EOAT_OLD_REF_NO1=?, EOAT_OLD_REF_DT1=to_date(?,'dd/mm/yyyy')"
					+ ",EOAT_OLD_REF_NO2=?,EOAT_OLD_RED_DT2=to_date(?,'dd/mm/yyyy')" + ",FINE_IMPOSED=?,"
					+ "FINE_RECOVERED=?,REASONS_FOR_NOT_RECOV_FINE=?,OFFICER_RESP1=?,OFFICER_RESP2=?,"
					+ "OFFICER_RESP3=?,EXEMPT_RECOMM_BY_SE=?,TOTAL_DAYS_EXEMPT_BY_SE=?,RATE_OF_PENALTY=?,"
					+ "TOTAL_PENALITY=?,REASONS_BY_CONTRACTOR=?,CONTRACTOR_REP_MADE_UPD=?,"
					+ "AGREEMENT_COPY_PENALITY_UPD=?,SUPP_DOCUMENT_FOR_EXEMP_UPD=?,AEE_RECOMMEND=?,"
					+ "DEE_RECOMMEND=?,EE_RECOMMEND=?,SE_RECOMMEND=?,CE_RECOMMEND=?,"
					+ "EOAT_GRANT_AUTHORITY=?,SUPP_AGREE_NO=?,SUPP_AGREE_DT=to_date(?,'dd/mm/yyyy'), "
					+ "PREPARED_BY=?,PREPARED_DATE=to_date(?,'dd/mm/yyyy'),PROGRAMME_CODE=? "
					+ " where work_id=? and EOAT_ORDER_NO=? ";

			ps = conn.prepareStatement(sqlQuery);
			ps.setString(1, bean.getValueOfWorkDone());
			ps.setString(2, bean.getValueOfWorkBeyondAgreement());
			ps.setString(3, bean.getValueOfWorkToBeDone());
			ps.setString(4, bean.getEoatDate());
			ps.setString(5, bean.getCostEsclationSought());
			ps.setString(6, bean.getEoatPeriod());
			ps.setString(7, bean.getEoatOldRefNo1());
			ps.setString(8, bean.getEoatOldRefDate1());
			ps.setString(9, bean.getEoatOldRefNo2());
			ps.setString(10, bean.getEoatOldRefDate2());
			ps.setString(11, bean.getFineImposed());
			ps.setString(12, bean.getFineRecovered());
			ps.setString(13, bean.getReasonsForNotRecoveringFine());
			ps.setString(14, bean.getOfficerResponsible1());
			ps.setString(15, bean.getOfficerResponsible2());
			ps.setString(16, bean.getOfficerResponsible3());
			ps.setString(17, bean.getExemptRecommendedBySE());
			ps.setString(18, bean.getTotalDaysExemptBySe());
			ps.setString(19, bean.getRateOfPenalty());
			ps.setString(20, bean.getTotalPenalty());
			ps.setString(21, bean.getReasonsByContractor());
			ps.setString(22, bean.getContractorRepMadeUpd());
			ps.setString(23, bean.getAgreementCopyPenaltyUpd());
			ps.setString(24, bean.getSuppDocumentForExempUpd());
			ps.setString(25, bean.getAeeRecommend());
			ps.setString(26, bean.getDeeRecommend());
			ps.setString(27, bean.getEeRecommend());
			ps.setString(28, bean.getSeRecommend());
			ps.setString(29, bean.getCeRecommend());
			ps.setString(30, bean.getEoatGrantAuthority());
			ps.setString(31, bean.getSuppAgreeNo());
			ps.setString(32, bean.getSuppAgreeDt());
			ps.setString(33, bean.getPreparedBy());
			ps.setString(34, bean.getPreparedDate());
			ps.setString(35, bean.getProgrammeCode());
			ps.setString(36, bean.getWorkId().substring(0, 14));
			ps.setString(37, bean.getEoatOrderNo());

			rowsEffected = ps.executeUpdate();

			if (rowsEffected > 0) {
				daoMessage.setOperationSussess(true);
				daoMessage.setMessage("Record Updated Successfully");
			} else {
				daoMessage.setOperationSussess(false);
				daoMessage.setMessage("Record Cant be Updated");

			}

		} catch (Exception e) {
			Debug.println("Exception in EOAT update method of rws_eoat_data:" + e);
		} finally {
			closeAll();
		}
		return daoMessage;
	}

	public ArrayList getEoatView(String ccode, String divcode, String sdcode, String workid) throws Exception {
		ArrayList eoatList = new ArrayList();
		try {
			StringBuffer qry = new StringBuffer();
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			qry.append("select eoat.WORK_ID,admn.work_name,P.PROGRAMME_NAME,eoat.VALUE_OF_WORK_DONE,eoat.COST_OF_WORK,"
					+ "eoat.EOAT_ORDER_NO,to_char (c.DATE_OF_COMPLETION,'dd/mm/yyyy')DATE_OF_COMPLETION,"
					+ "to_char (eoat.EOAT_DATE,'dd/mm/yyyy') EOAT_DATE,eoat.COST_ESCALATION_SOUGHT, eoat.EOAT_PERIOD,"
					+ "OFFICER_RESP1,eoat.PREPARED_BY,to_char (eoat.PREPARED_DATE,'dd/mm/yyyy')PREPARED_DATE,cat.category_name "
					+ "from rws_eoat_tbl eoat,rws_programme_tbl p, RWS_WORK_ADMN_TBL ADMN,rws_contractor_selection_tbl c,"
					+ "rws_work_category_tbl cat WHERE admn.programme_code=p.programme_code(+) and ADMN.WORK_ID=eoat.WORK_ID"
					+ " and admn.work_id=c.work_id and cat.category_code=admn.category_code");
			if (ccode != null && !ccode.equals("")) {
				qry.append(" and substr (admn.office_code,2,2)='" + ccode + "'");
			}
			if (divcode != null && !divcode.equals("")) {
				qry.append(" and substr (admn.office_code,4,1)='" + divcode + "'");
			}
			if (sdcode != null && !sdcode.equals("")) {
				qry.append(" and substr (admn.office_code,5,2)='" + sdcode + "'");
			}
			if (workid != null && !workid.equals("")) {
				qry.append(" and eoat.work_id='" + workid + "'");
			}
			qry.append(" order by eoat.EOAT_ORDER_NO");

			rs = stmt.executeQuery(qry.toString());

			Rws_EOAT_bean bean = null;

			while (rs.next()) {
				bean = new Rws_EOAT_bean();
				bean.setEoatOrderNo(rs.getString("eoat_order_no"));
				bean.setWorkId(rs.getString("work_id"));
				bean.setWorkName(rs.getString("work_name"));
				bean.setProgrammeName(rs.getString("programme_name"));
				bean.setValueOfWorkDone(rs.getString("value_of_work_done"));
				bean.setCostOfWork(rs.getString("cost_of_work"));
				bean.setDateOfCompletion(rs.getString("date_of_completion"));
				bean.setEoatDate(rs.getString("eoat_date"));
				bean.setCostEsclationSought(rs.getString("COST_ESCALATION_SOUGHT"));
				bean.setEoatPeriod(rs.getString("eoat_period"));
				bean.setOfficerResponsible1(rs.getString("officer_resp1"));
				bean.setPreparedBy(rs.getString("prepared_by"));
				bean.setPreparedDate(rs.getString("prepared_date"));
				bean.setSno(rs.getString("category_name"));
				eoatList.add(bean);

			}

		} catch (Exception e) {
			Debug.println("Exception in EOAT View of Rws_EOAT_Data -- : " + e);
		} finally {
			closeAll();
		}

		return eoatList;
	}

	public Rws_EOAT_bean getEoat(String orderno) {

		Rws_EOAT_bean bean = null;

		try {

			conn = RwsOffices.getConn();

			String sqlQuery = " select "
					+ " eoat.CIRCLE_OFFICE_CODE,eoat.DIVISION_OFFICE_CODE,eoat.SUBDIVISION_OFFICE_CODE,eoat.WORK_ID,"
					+ "P.PROGRAMME_NAME," + " eoat.VALUE_OF_WORK_DONE,eoat.COST_OF_WORK,"
					+ " eoat.VALUE_OF_WORK_BEYOND_AGREE,eoat.VALUE_OF_WORK_TO_BE_DONE,"
					+ " eoat.EOAT_ORDER_NO,to_char(eoat.EOAT_DATE,'dd/mm/yyyy')EOAT_DATE,eoat.COST_ESCALATION_SOUGHT,"
					+ " eoat.EOAT_PERIOD,eoat.EOAT_OLD_REF_NO1,to_char(eoat.EOAT_OLD_REF_DT1,'dd/mm/yyyy')EOAT_OLD_REF_DT1,"
					+ " eoat.EOAT_OLD_REF_NO2,to_char(eoat.EOAT_OLD_RED_DT2,'dd/mm/yyyy')EOAT_OLD_RED_DT2,eoat.FINE_IMPOSED,"
					+ " eoat.FINE_RECOVERED,eoat.REASONS_FOR_NOT_RECOV_FINE,eoat.OFFICER_RESP1,"
					+ " eoat.OFFICER_RESP2,eoat.OFFICER_RESP3,eoat.EXEMPT_RECOMM_BY_SE,"
					+ " eoat.TOTAL_DAYS_EXEMPT_BY_SE,eoat.RATE_OF_PENALTY,eoat.TOTAL_PENALITY,"
					+ " eoat.REASONS_BY_CONTRACTOR,eoat.CONTRACTOR_REP_MADE_UPD,eoat.AGREEMENT_COPY_PENALITY_UPD,"
					+ " eoat.SUPP_DOCUMENT_FOR_EXEMP_UPD,eoat.AEE_RECOMMEND,eoat.DEE_RECOMMEND,"
					+ " eoat.EE_RECOMMEND,eoat.SE_RECOMMEND,eoat.CE_RECOMMEND,"
					+ " eoat.EOAT_GRANT_AUTHORITY,eoat.SUPP_AGREE_NO,to_char(eoat.SUPP_AGREE_DT,'dd/mm/yyyy')SUPP_AGREE_DT,"
					+ " eoat.PREPARED_BY,to_char(eoat.PREPARED_DATE,'dd/mm/yyyy')PREPARED_DATE, "
					+ " admn.work_name,cat.category_name,to_char(c.DATE_OF_COMPLETION,'dd/mm/yyyy')DATE_OF_COMPLETION, "
					+ "admn.PROGRAMME_CODE  from  rws_eoat_tbl eoat,rws_programme_tbl p,"
					+ " RWS_WORK_ADMN_TBL ADMN,rws_work_category_tbl cat,rws_contractor_selection_tbl c WHERE eoat.work_id=admn.work_id "
					+ "and admn.programme_code=p.programme_code and cat.category_code=admn.category_code and "
					+ " c.work_id=admn.work_id and eoat.EOAT_ORDER_NO=? ";
			pstmt = conn.prepareStatement(sqlQuery);
			pstmt.setString(1, orderno);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				bean = new Rws_EOAT_bean();
				bean.setCircleOfficeCode(rs.getString("CIRCLE_OFFICE_CODE"));
				bean.setDivisionOfficeCode(rs.getString("DIVISION_OFFICE_CODE"));
				bean.setSubDivisionOfficeCode(rs.getString("SUBDIVISION_OFFICE_CODE"));
				bean.setWorkId(rs.getString("WORK_ID") + "-" + rs.getString("WORK_NAME"));
				bean.setSno(rs.getString("category_name"));
				bean.setProgrammeName(rs.getString("PROGRAMME_NAME"));
				bean.setProgrammeCode(rs.getString("PROGRAMME_CODE"));
				bean.setValueOfWorkDone(rs.getString("VALUE_OF_WORK_DONE"));
				bean.setCostOfWork(rs.getString("COST_OF_WORK"));
				bean.setValueOfWorkBeyondAgreement(rs.getString("VALUE_OF_WORK_BEYOND_AGREE"));
				bean.setValueOfWorkToBeDone(rs.getString("VALUE_OF_WORK_TO_BE_DONE"));
				bean.setEoatOrderNo(rs.getString("EOAT_ORDER_NO"));
				bean.setEoatDate(rs.getString("EOAT_DATE"));
				bean.setCostEsclationSought(rs.getString("COST_ESCALATION_SOUGHT"));
				bean.setEoatPeriod(rs.getString("EOAT_PERIOD"));
				bean.setEoatOldRefNo1(rs.getString("EOAT_OLD_REF_NO1"));
				bean.setEoatOldRefDate1(rs.getString("EOAT_OLD_REF_DT1"));
				bean.setEoatOldRefNo2(rs.getString("EOAT_OLD_REF_NO2"));
				bean.setEoatOldRefDate2(rs.getString("EOAT_OLD_RED_DT2"));
				bean.setFineImposed(rs.getString("FINE_IMPOSED"));
				bean.setFineRecovered(rs.getString("FINE_RECOVERED"));
				bean.setReasonsForNotRecoveringFine(rs.getString("REASONS_FOR_NOT_RECOV_FINE"));
				bean.setOfficerResponsible1(rs.getString("OFFICER_RESP1"));
				bean.setOfficerResponsible2(rs.getString("OFFICER_RESP2"));
				bean.setOfficerResponsible3(rs.getString("OFFICER_RESP3"));
				bean.setExemptRecommendedBySE(rs.getString("EXEMPT_RECOMM_BY_SE"));
				bean.setTotalDaysExemptBySe(rs.getString("TOTAL_DAYS_EXEMPT_BY_SE"));
				bean.setRateOfPenalty(rs.getString("RATE_OF_PENALTY"));
				bean.setTotalPenalty(rs.getString("TOTAL_PENALITY"));
				bean.setReasonsByContractor(rs.getString("REASONS_BY_CONTRACTOR"));
				bean.setContractorRepMadeUpd(rs.getString("CONTRACTOR_REP_MADE_UPD"));
				bean.setAgreementCopyPenaltyUpd(rs.getString("AGREEMENT_COPY_PENALITY_UPD"));
				bean.setSuppDocumentForExempUpd(rs.getString("SUPP_DOCUMENT_FOR_EXEMP_UPD"));
				bean.setAeeRecommend(rs.getString("AEE_RECOMMEND"));
				bean.setDeeRecommend(rs.getString("DEE_RECOMMEND"));
				bean.setEeRecommend(rs.getString("EE_RECOMMEND"));
				bean.setSeRecommend(rs.getString("SE_RECOMMEND"));
				bean.setCeRecommend(rs.getString("CE_RECOMMEND"));
				bean.setEoatGrantAuthority(rs.getString("EOAT_GRANT_AUTHORITY"));
				bean.setSuppAgreeNo(rs.getString("SUPP_AGREE_NO"));
				bean.setSuppAgreeDt(rs.getString("SUPP_AGREE_DT"));
				bean.setPreparedBy(rs.getString("PREPARED_BY"));
				bean.setPreparedDate(rs.getString("PREPARED_DATE"));
				bean.setDateOfCompletion(rs.getString("DATE_OF_COMPLETION"));
			}
		} catch (Exception e) {
			Debug.println("Exception occured in get to editing form of rws_eoat_data -- " + e);
		} finally {
			closeAll();
		}
		return bean;
	}

	public int deleteEoat(String workid, String orderno) throws Exception {
		int rcount = 0;
		try {
			conn = RwsOffices.getConn();

			String qry = "delete from rws_eoat_tbl where work_id=? and eoat_order_no =? ";
			pstmt = conn.prepareStatement(qry);
			pstmt.setString(1, workid);
			pstmt.setString(2, orderno);
			rcount = pstmt.executeUpdate();
		} catch (Exception e) {
			Debug.println(" Exception in Deleting EOAT details of rws_eoat_data: " + e);
		} finally {
			closeAll();
		}

		return rcount;
	}

}
