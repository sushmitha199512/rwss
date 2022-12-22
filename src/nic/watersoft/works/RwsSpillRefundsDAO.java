package nic.watersoft.works;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUtils;

public class RwsSpillRefundsDAO {

	public ArrayList getRefundWorks(String circleCode, String divoffice, String type, String releaseDate) {

		Connection conn = null;
		PreparedStatement stmt = null;
		RefundWork refundWork = null;
		ResultSet rs2 = null;
		ArrayList refundList = new ArrayList();
		String tableName = "";
		DecimalFormat ndf = new DecimalFormat("##.##");
		try {
			String query = "";
			conn = RwsOffices.getConn();

			if (type.equals("1")) {

				query = "select a.work_id,a.work_name,to_char(a.admin_date,'dd/mm/yyyy'),a.sanction_amount ,c.programme_name,"
						+ "d.subprogramme_name,a.office_code ,sum(BILL_AMOUNT_CENTRAL) from rws_work_admn_tbl a,"
						+ "rws_bill_bank_bridge_det_tbl b,rws_programme_tbl c, rws_subprogramme_tbl d where  substr(a.work_id,5,2)=?"
						+ " and TRUNC(b.bank_send_date)=TO_DATE(?,'dd-MM-yyyy')and a.work_id=b.work_id and "
						+ "a.programme_code=c.programme_code and c.programme_code=d.programme_code and "
						+ "a.subprogramme_code=d.subprogramme_code and substr(a.office_code,4,1)=? ";
				query += " group by a.work_id,a.work_name,to_char(a.admin_date,'dd/mm/yyyy'),a.sanction_amount ,c.programme_name,d.subprogramme_name,a.office_code";
				tableName = "rws_div_work_bank_refund_tbl";

			} else {

				query = "select a.work_id,a.work_name,to_char(a.admin_date,'dd/mm/yyyy'),a.sanction_amount ,c.programme_name,"
						+ "d.subprogramme_name,a.office_code, sum(BILL_AMOUT_STATE) from rws_work_admn_tbl a,"
						+ "rws_bill_pao_bridge_det_tbl b,rws_programme_tbl c, rws_subprogramme_tbl d where  substr(a.work_id,5,2)=?"
						+ " and TRUNC(b.state_send_date)=TO_DATE(?,'dd/MM/yy')and a.work_id=b.work_id and "
						+ "a.programme_code=c.programme_code and c.programme_code=d.programme_code and "
						+ "a.subprogramme_code=d.subprogramme_code and substr(a.office_code,4,1)=? ";
				query += " group by a.work_id,a.work_name,to_char(a.admin_date,'dd/mm/yyyy'),a.sanction_amount ,c.programme_name,d.subprogramme_name,a.office_code";
				tableName = "rws_div_work_pao_refund_tbl";
			}

			stmt = conn.prepareStatement(query);
			stmt.setString(1, circleCode);
			stmt.setString(2, releaseDate);
			stmt.setString(3, divoffice);
			rs2 = stmt.executeQuery();

			while (rs2.next()) {

				refundWork = new RefundWork();

				isRefundTotalAvialable(rs2.getString(1), refundWork, tableName);
				getRefundAmount(rs2.getString(1), refundWork, tableName);
				refundWork.setWork_id(rs2.getString(1));
				refundWork.setWork_name(rs2.getString(2));
				refundWork.setSanctionDate(rs2.getString(3));
				refundWork.setSanctionAmoount(rs2.getString(4));
				refundWork.setProgramme_name(rs2.getString(5));
				refundWork.setSubProgramme_name(rs2.getString(6));
				refundWork.setOfficeCode(rs2.getString(7));
				refundWork.setReleaseAmount(ndf.format(Double.parseDouble(rs2.getString(8))));
				refundList.add(refundWork);

			}

		} catch (Exception e) {
			System.out.println("Exception in getRefundWorks of  RwsSpillRefundsDAO-- " + e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs2 != null) {
					rs2.close();
				}
				if (conn != null) {
					conn.close();
				}

			} catch (Exception e) {
				System.out.println("Exception in getRefundWorks of  RwsSpillRefundsDAO-- " + e);
			}
		}

		return refundList;
	}

	public void getRefundAmount(String work_id, RefundWork refundWork, String tableName) {
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement stmt1 = null;
		try {
			conn = RwsOffices.getConn();

			long totAmount = 0;
			String query = "select refund_bill_amount,REFUND_CHQ_NO,to_char(REFUND_CHQ_DT,'dd/mm/yyyy'),REMARKS from "
					+ tableName + " where work_id=? and refund_flag='I' and EE_FORWARD_DATE is null";

			stmt1 = conn.prepareStatement(query);
			stmt1.setString(1, work_id);

			rs = stmt1.executeQuery();

			while (rs.next()) {
				totAmount += Long.parseLong(rs.getString(1));
				refundWork.setRefundAmount(totAmount);
				refundWork.setChequeDate(rs.getString(3));
				refundWork.setChequeNo(rs.getString(2));
				refundWork.setRemarks(rs.getString(4));
				refundWork.setChecks("on");

			}

		} catch (Exception e) {
			System.out.println("Exception in getRefundAmount of  RwsSpillRefundsDAO-- " + e);
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null) {
					conn.close();
				}

			} catch (Exception e) {
				System.out.println("Exception in getRefundAmount of  RwsSpillRefundsDAO-- " + e);
			}
		}

	}

	private void isRefundTotalAvialable(String work_id, RefundWork refundWork, String tableName) {
		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement stmt1 = null;
		try {
			conn = RwsOffices.getConn();

			long totAmount = 0;
			String query = "select refund_bill_amount from " + tableName + " where work_id=? ";
			stmt1 = conn.prepareStatement(query);
			stmt1.setString(1, work_id);
			rs = stmt1.executeQuery();

			while (rs.next()) {
				totAmount += Long.parseLong(rs.getString(1));
			}
			refundWork.setSoFarRefundAmount(totAmount);

		} catch (Exception e) {
			System.out.println("Exception in isRefundTotalAvialable of  RwsSpillRefundsDAO-- " + e);
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null) {
					conn.close();
				}

			} catch (Exception e) {
				System.out.println("Exception in isRefundTotalAvialable of  RwsSpillRefundsDAO-- " + e);
			}
		}

	}

	public int saveRefund(String workId, String userId, String amount, String chequeDate, String chequeNo,
			String remarks, String tableName) {

		Connection conn = null;
		PreparedStatement stmt = null;
		int count = 0;
		try {

			conn = RwsOffices.getConn();

			String currentDate = RwsUtils.getCurrentDate("dd/MM/yyyy");
			String refundflag = "I";

			if (!checkIsExists(workId, tableName)) {
				String query = "insert into " + tableName
						+ "(work_id,entered_by,update_date,refund_bill_amount,refund_chq_no,refund_chq_dt,remarks,REFUND_FLAG ) "
						+ " values(?,?,to_date(?," + "'dd/mm/yyyy'),?,?," + "to_date(?," + "'dd-mm-yyyy'),?,?)";

				stmt = conn.prepareStatement(query);
				stmt.setString(1, workId);
				stmt.setString(2, userId);
				stmt.setString(3, currentDate);
				stmt.setString(4, amount);
				stmt.setString(5, chequeNo);
				stmt.setString(6, chequeDate);
				stmt.setString(7, remarks);
				stmt.setString(8, refundflag);

				count = stmt.executeUpdate();

			} else {
				String uQuery = "update " + tableName + " set update_date=" + "to_date(?,"
						+ "'dd/mm/yyyy'),refund_bill_amount=?,refund_chq_no=?,refund_chq_dt=" + "to_date(?,"
						+ "'dd-mm-yyyy'),"
						+ "remarks=? where work_id=? and refund_flag='I' and EE_FORWARD_DATE is null";

				stmt = conn.prepareStatement(uQuery);

				stmt.setString(1, currentDate);
				stmt.setString(2, amount);
				stmt.setString(3, chequeNo);
				stmt.setString(4, chequeDate);
				stmt.setString(5, remarks);
				stmt.setString(6, workId);

				count = stmt.executeUpdate();

			}

		} catch (Exception e) {
			System.out.println("Exception in saveRefund of  RwsSpillRefundsDAO-- " + e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in saveRefund of  RwsSpillRefundsDAO-- " + e);
			}
		}
		return count;

	}

	public boolean checkIsExists(String workId, String tableName) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			conn = RwsOffices.getConn();

			String query = "select work_id from " + tableName
					+ " where work_id=? and refund_flag='I' and EE_FORWARD_DATE is null";
			stmt = conn.prepareStatement(query);
			stmt.setString(1, workId);
			rs = stmt.executeQuery();

			if (rs.next()) {
				return true;
			}

		} catch (Exception e) {
			System.out.println("Exception in checkIsExists of  RwsSpillRefundsDAO-- " + e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in checkIsExists of  RwsSpillRefundsDAO-- " + e);
			}
		}
		return false;
	}

	public ArrayList getReleaseDates(String bankOrPao, String finYear, String circleCode, String divCode) {
		ArrayList releaseDates = new ArrayList();
		String query = "";

		if (bankOrPao.equals("1")) {
			query = "select  distinct to_date(bank_send_date,'dd/MM/yy') from rws_bill_bank_bridge_det_tbl   where "
					+ " to_char(bank_send_date,'yyyy') in (" + finYear.substring(0, 4) + "," + finYear.substring(5, 9)
					+ ")   and substr(office_code,2,2)=? and substr(office_code,4,1)=? order by to_date(bank_send_date,'dd/MM/yy') desc";

		} else if (bankOrPao.equals("2")) {

			query = "select  distinct to_date(state_send_date,'dd/MM/yy') from rws_bill_pao_bridge_det_tbl   where  to_char(state_send_date,'yyyy') in ("
					+ finYear.substring(0, 4) + "," + finYear.substring(5, 9)
					+ ")    and substr(office_code,2,2)=? and substr(office_code,4,1)=? order by to_date(state_send_date,'dd/MM/yy') desc";
		}
		Connection conn = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;

		try {
			conn = RwsOffices.getConn();
			stmt1 = conn.prepareStatement(query);
			stmt1.setString(1, circleCode);
			stmt1.setString(2, divCode);
			rs1 = stmt1.executeQuery();
			while (rs1.next()) {

				String day = rs1.getString(1).substring(8, 10);
				String month = rs1.getString(1).substring(5, 7);
				String year = rs1.getString(1).substring(0, 4);
				String date = day + "/" + month + "/" + year;
				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setValue(date);
				labelValueBean.setLabel(date);
				labelValueBean.setLabelValue(date + " - " + date);
				releaseDates.add(labelValueBean);
			}

		} catch (Exception e) {
			System.out.println("Exception in getReleaseDates of  RwsSpillRefundsDAO-- " + e);
		}
		return releaseDates;
	}

	public ArrayList getFinancialYears(String bankOrPao) {
		ArrayList financialYears = new ArrayList();
		String query = "";
		if (bankOrPao.equals("1")) {
			query = "select distinct  substr(to_char(SEND_DATE,'dd/mm/yyyy'),7,4)  from RWS_BILL_bank_SETTLEMENT_TBL  "
					+ "where SEND_DATE is not null order by substr(to_char(SEND_DATE,'dd/mm/yyyy'),7,4) desc ";

		} else if (bankOrPao.equals("2")) {

			query = "select distinct  substr(to_char(SEND_DATE,'dd/mm/yyyy'),7,4)  from RWS_BILL_pao_SETTLEMENT_TBL  "
					+ "where SEND_DATE is not null order by substr(to_char(SEND_DATE,'dd/mm/yyyy'),7,4) desc ";
		}
		Connection conn = null;
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;

		try {
			conn = RwsOffices.getConn();
			stmt1 = conn.prepareStatement(query);
			rs1 = stmt1.executeQuery();
			String fyear = "";
			while (rs1.next()) {
				String f1 = rs1.getString(1);

				int fy1 = Integer.parseInt(f1) + 1;
				fyear = f1 + "-" + fy1;

				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setValue(fyear);
				labelValueBean.setLabel(fyear);
				labelValueBean.setLabelValue(fyear);
				financialYears.add(labelValueBean);
			}

		} catch (Exception e) {
			System.out.println("Exception in getFinancialYears of  RwsSpillRefundsDAO-- " + e);
		}
		return financialYears;
	}

	public int forwardRefund(String work_id, String tableName) {
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		int count = 0;
		try {
			conn = RwsOffices.getConn();

			String currentDate = RwsUtils.getCurrentDate("dd/MM/yyyy");

			if (!checkIsExists(work_id, tableName)) {
				return 0;
			}
			String query = "update " + tableName + " set  ee_forward_date=to_date(?,"
					+ "'dd/mm/yyyy') where work_id=? ";

			stmt = conn.prepareStatement(query);
			stmt.setString(1, currentDate);
			stmt.setString(2, work_id);
			count = stmt.executeUpdate();

		} catch (Exception e) {

			System.out.println("Exception in forwardRefund of  RwsSpillRefundsDAO-- " + e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in forwardRefund of  RwsSpillRefundsDAO-- " + e);
			}
		}

		return count;
	}

	public void getBillAmount(String work_id, tenderMemo tenderMemoBean) {
		Connection conn = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		Statement stmt1 = null, stmt2 = null, stmt3 = null;
		try {
			conn = RwsOffices.getConn();
			stmt1 = conn.createStatement();
			stmt2 = conn.createStatement();
			stmt3 = conn.createStatement();
			long totalRefundAmount = 0;
			String query = "select refund_bill_amount from rws_div_work_bank_refund_tbl where work_id='" + work_id
					+ "' and refund_flag='p'";
			rs = stmt1.executeQuery(query);
			while (rs.next()) {
				totalRefundAmount += Long.parseLong(rs.getString(1));
			}

			String query1 = "select refund_bill_amount from rws_div_work_pao_refund_tbl where work_id='" + work_id
					+ "' and refund_flag='p'";
			rs1 = stmt2.executeQuery(query1);
			while (rs1.next()) {
				totalRefundAmount += Long.parseLong(rs1.getString(1));
			}

			String query2 = "select BILL_AMT_ADMISSIBLE from rws_work_bill_tbl  where work_id='" + work_id
					+ "' and refund_bill='Y'";
			rs2 = stmt3.executeQuery(query2);
			long workBillAmount = 0;
			while (rs2.next()) {
				workBillAmount += Long.parseLong(rs2.getString(1));
			}

			tenderMemoBean.setGrossValueContractor(String.valueOf(totalRefundAmount - workBillAmount));

		} catch (Exception e) {
			System.out.println("Exception in getBillAmount of  RwsSpillRefundsDAO-- " + e);
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (stmt2 != null) {
					stmt2.close();
				}
				if (rs1 != null) {
					rs1.close();
				}
				if (stmt3 != null) {
					stmt3.close();
				}
				if (rs2 != null) {
					rs2.close();
				}
				if (conn != null) {
					conn.close();
				}

			} catch (Exception e) {
				System.out.println("Exception in getBillAmount of  RwsSpillRefundsDAO-- " + e);
			}
		}

	}

	
	public long getBillAmount(String work_id) {
		Connection conn = null;
		ResultSet rs = null, rs1 = null;
		Statement stmt1 = null, stmt2 = null;
		long totalRefundAmount = 0;
		try {
			conn = RwsOffices.getConn();
			stmt1 = conn.createStatement();
			stmt2 = conn.createStatement();
			String query = "select refund_bill_amount from rws_div_work_bank_refund_tbl where work_id='" + work_id
					+ "' and refund_flag='p' and ee_forward_date is not null";
			rs = stmt1.executeQuery(query);
			while (rs.next()) {
				totalRefundAmount += Long.parseLong(rs.getString(1));
			}

			String query1 = "select refund_bill_amount from rws_div_work_pao_refund_tbl where work_id='" + work_id
					+ "' and refund_flag='p' and ee_forward_date is not null";
			rs1 = stmt2.executeQuery(query1);
			while (rs1.next()) {
				totalRefundAmount += Long.parseLong(rs1.getString(1));
			}

		} catch (Exception e) {
			System.out.println("Exception in getBillAmount of  RwsSpillRefundsDAO-- " + e);
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (stmt2 != null) {
					stmt2.close();
				}
				if (rs1 != null) {
					rs1.close();
				}

				if (conn != null) {
					conn.close();
				}

			} catch (Exception e) {
				System.out.println("Exception in getBillAmount of  RwsSpillRefundsDAO-- " + e);
			}

		}
		return totalRefundAmount;

	}

	public ArrayList getPrograms() {

		Connection conn = null;
		ResultSet rs = null;
		PreparedStatement stmt1 = null;
		ArrayList programs = new ArrayList();
		LabelValueBean labelValueBean1 = new LabelValueBean();
		labelValueBean1.setValue(Constants.NRDWP_RELATED);
		labelValueBean1.setLabel("NRDDWP-RELATED");
		programs.add(labelValueBean1);
		try {
			conn = RwsOffices.getConn();

			String query = "select *from rws_programme_tbl where programme_code not in(" + Constants.NRDWP_RELATED
					+ ") order by programme_code";
			stmt1 = conn.prepareStatement(query);
			rs = stmt1.executeQuery();

			while (rs.next()) {

				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs.getString(1));
				labelValueBean.setLabel(rs.getString(2));
				labelValueBean.setLabelValue("");
				programs.add(labelValueBean);
			}

		} catch (Exception e) {
			System.out.println("Exception in getPrograms of  RwsSpillRefundsDAO-- " + e);
		}

		return programs;
	}

	public ArrayList getRefundWorksPrograms(String circleCode, String divoffice, String type, String programCode,
			String finYear, String programmeCode, String releaseDate) {
		Connection conn = null;
		PreparedStatement stmt = null;
		RefundWork refundWork = null;
		ResultSet rs2 = null;
		ArrayList refundList = new ArrayList();
		String tableName = "";

		try {
			String query = "";
			conn = RwsOffices.getConn();

			query = "select a.work_id,a.work_name,to_char(a.admin_date,'dd/mm/yyyy'),a.sanction_amount ,c.programme_name,"
					+ "d.subprogramme_name,a.office_code,sum(BILL_AMT_CONTRACTOR) from rws_work_admn_tbl a,rws_work_bill_tbl b,"
					+ "rws_programme_tbl c, rws_subprogramme_tbl d where  substr(a.work_id,5,2)=? and a.work_id=b.work_id and a.programme_code in ("
					+ programCode + ") and a.programme_code=c.programme_code "
					+ "and c.programme_code=d.programme_code and a.subprogramme_code=d.subprogramme_code and"
					+ " substr(a.office_code,4,1)=? AND BILL_SL_NO='0'  and a.work_id not in(select WORK_ID from RWS_WORK_COMPLETION_TBL)";

			query += " group by a.work_id,a.work_name,to_char(a.admin_date,'dd/mm/yyyy'),a.sanction_amount ,c.programme_name,d.subprogramme_name,a.office_code";
			tableName = "RWS_DIV_WORK_SPILL_REFUND_TBL ";

			DecimalFormat ndf = new DecimalFormat("##.##");

			stmt = conn.prepareStatement(query);
			stmt.setString(1, circleCode);
			stmt.setString(2, divoffice);
			rs2 = stmt.executeQuery();
			while (rs2.next()) {

				refundWork = new RefundWork();
				isRefundTotalAvialable(rs2.getString(1), refundWork, tableName);
				getRefundAmount(rs2.getString(1), refundWork, tableName);
				refundWork.setWork_id(rs2.getString(1));
				refundWork.setWork_name(rs2.getString(2));
				refundWork.setSanctionDate(rs2.getString(3));
				refundWork.setSanctionAmoount(rs2.getString(4));
				refundWork.setProgramme_name(rs2.getString(5));
				refundWork.setSubProgramme_name(rs2.getString(6));
				refundWork.setOfficeCode(rs2.getString(7));

				refundWork.setReleaseAmount(ndf.format(Double.parseDouble(rs2.getString(8))));

				refundList.add(refundWork);

			}

		} catch (Exception e) {
			System.out.println("Exception in getRefundWorksPrograms of  RwsSpillRefundsDAO-- " + e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs2 != null) {
					rs2.close();
				}
				if (conn != null) {
					conn.close();
				}

			} catch (Exception e) {
				System.out.println("Exception in getRefundWorksPrograms of  RwsSpillRefundsDAO-- " + e);
			}
		}

		return refundList;
	}

	public long getSpillAmount(String work_id) {

		Connection conn = null;
		ResultSet rs = null;
		Statement stmt1 = null;
		long totalRefundAmount = 0;
		try {
			conn = RwsOffices.getConn();
			stmt1 = conn.createStatement();

			String query = "select refund_bill_amount from RWS_DIV_WORK_SPILL_REFUND_TBL  where work_id='" + work_id
					+ "' and REFUND_FLAG ='p' ";
			rs = stmt1.executeQuery(query);

			while (rs.next()) {
				totalRefundAmount += Long.parseLong(rs.getString(1));
			}

		} catch (Exception e) {
			System.out.println("Exception in getSpillAmount of  RwsSpillRefundsDAO-- " + e);
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
				if (rs != null) {
					rs.close();
				}

				if (conn != null) {
					conn.close();
				}

			} catch (Exception e) {
				System.out.println("Exception in getSpillAmount of  RwsSpillRefundsDAO-- " + e);
			}

		}
		return totalRefundAmount;

	}

	public ArrayList getAmountChangeWorks(String circleCode) {
		Connection conn = null;
		PreparedStatement stmt = null;
		RefundWork refundWork = null;
		ResultSet rs2 = null;
		ArrayList refundList = new ArrayList();
		String tableName = "";

		try {
			String query = "";
			conn = RwsOffices.getConn();
			

			query = "select a.work_id,a.work_name,to_char(a.admin_date,'dd/mm/yyyy'),a.sanction_amount ,c.programme_name,"
					+ "d.subprogramme_name,a.office_code,sum(BILL_AMT_CONTRACTOR),sum(BILL_AMT_ADMISSIBLE),BILL_SL_NO,"
					+ "BILL_NO from rws_work_admn_tbl a,rws_work_bill_tbl b,rws_programme_tbl c, rws_subprogramme_tbl d where "
					+ " substr(a.work_id,5,2)=? and a.work_id=b.work_id and  a.programme_code=c.programme_code and "
					+ "c.programme_code=d.programme_code and a.subprogramme_code=d.subprogramme_code "

					+ " AND BILL_SL_NO='0' and  BILL_AMT_ADMISSIBLE < BILL_AMT_CONTRACTOR and WORK_CANCEL_DT is null ";

			query += " group by a.work_id,a.work_name,to_char(a.admin_date,'dd/mm/yyyy'),a.sanction_amount ,c.programme_name,d.subprogramme_name,a.office_code,BILL_SL_NO,BILL_NO";
			tableName = "RWS_DIV_WORK_SPILL_REFUND_TBL ";

			DecimalFormat ndf = new DecimalFormat("##.##");
			stmt = conn.prepareStatement(query);
			stmt.setString(1, circleCode);
			rs2 = stmt.executeQuery();
			while (rs2.next()) {
				refundWork = new RefundWork();

				isRefundTotalAvialable(rs2.getString(1), refundWork, tableName);
				getRefundAmount(rs2.getString(1), refundWork, tableName);
				refundWork.setWork_id(rs2.getString(1));
				refundWork.setWork_name(rs2.getString(2));
				refundWork.setSanctionDate(rs2.getString(3));
				refundWork.setSanctionAmoount(rs2.getString(4));
				refundWork.setProgramme_name(rs2.getString(5));
				refundWork.setSubProgramme_name(rs2.getString(6));
				refundWork.setOfficeCode(rs2.getString(7));

				refundWork.setReleaseAmount(ndf.format(Double.parseDouble(rs2.getString(8)) / 100000));
				refundWork.setAdmissibleAmount(ndf.format(Double.parseDouble(rs2.getString(9)) / 100000));
				refundWork.setContractorAmountInRs(rs2.getString(8));
				refundWork.setAdmissibleAmountInRs(rs2.getString(9));

				refundWork.setBillSNo(rs2.getString(10));
				refundWork.setBillNo(rs2.getString(11));
				refundList.add(refundWork);

			}

		} catch (Exception e) {
			System.out.println("Exception in getAmountChangeWorks of  RwsSpillRefundsDAO-- " + e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs2 != null) {
					rs2.close();
				}
				if (conn != null) {
					conn.close();
				}

			} catch (Exception e) {
				System.out.println("Exception in getAmountChangeWorks of  RwsSpillRefundsDAO-- " + e);
			}
		}

		return refundList;
	}

	public int updateAdmissibleAmount(String workId, String userId, String conamount, String admamount, String remarks,
			String billNo) {

		Connection conn = null;
		Statement stmt = null;
		int count = 0;
		try {

			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			String currentDate = RwsUtils.getCurrentDate("dd/MM/yyyy");
			String updateQuery = "update rws_work_bill_tbl set bill_amt_admissible = bill_Amt_contractor where bill_sl_no ='0' and  work_id='"
					+ workId + "' and bill_no ='" + billNo + "'";
			stmt.addBatch(updateQuery);

			String insertQuery = "insert into RWS_SPILL_AMT_ADM_CONT_HIS_TBL values ('" + workId + "','0','" + billNo
					+ "','" + conamount + "','" + admamount + "',to_date('" + currentDate + "','dd/mm/yyyy'),'" + userId
					+ "','" + remarks + "')";
			stmt.addBatch(insertQuery);

			
			int[] countt = stmt.executeBatch();
			count = countt.length;
			if (count > 0) {
				conn.setAutoCommit(true);
				conn.commit();
			}
		} catch (Exception e) {
			System.out.println("Exception in updateAdmissibleAmount of  RwsSpillRefundsDAO-- " + e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in updateAdmissibleAmount of  RwsSpillRefundsDAO-- " + e);
			}
		}
		return count;

	}
}