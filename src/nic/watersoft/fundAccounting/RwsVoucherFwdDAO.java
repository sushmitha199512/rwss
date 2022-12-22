package nic.watersoft.fundAccounting;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import nic.watersoft.commons.RwsOffices;


public class RwsVoucherFwdDAO {

	public ArrayList<RwsVoucher> getVouchersList(String circle, String division) {

		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		ArrayList<RwsVoucher> vouchersList = new ArrayList<RwsVoucher>();

		try {

			conn = RwsOffices.getConn();

			HashMap<String, String> employeeHash = getAllEmployes(conn);

			String vouchersQuery = "select a.work_id,a.work_name,nvl(b.CHECK_MEASURED_BY,''),nvl(to_char(b.CHECK_MEASURE_DT,'dd/mm/yyyy'),''),nvl(b.SUPER_CHECK_MEASURED_BY ,''),nvl(b.SUPER_CHECK_MEASURE_DT ,''),b.VOUCHER_NO,b.VOUCHER_DT ,b.VOUCHER_AMT ,b.CHEQUE_NO,b.CHEQUE_DT,nvl(b.PAO_ADMISSABLE,0) as paoadmissible ,bill.BILL_SL_NO ,bill.BILL_NO,bill.BILL_AMT_CONTRACTOR,bill.BILL_AMT_ADMISSIBLE from rws_work_admn_tbl a,rws_work_exp_voucher_tbl b,rws_work_bill_tbl bill  where a.work_id=b.work_id   and  bill.work_id=b.work_id and bill.work_id=a.work_id and bill.BILL_SL_NO=b.BILL_SL_NO  and   substr(a.office_code,2,2)=? and substr(a.office_code,4,1)=? and PAO_ADMISSABLE>0 and b.ee_approved_date is null";
			psmt = conn.prepareStatement(vouchersQuery);
			psmt.setString(1, circle);
			psmt.setString(2, division);
			rs = psmt.executeQuery();
			while (rs.next()) {
				RwsVoucher rwsVoucher = new RwsVoucher();
				rwsVoucher.setWorkId(rs.getString(1));
				rwsVoucher.setWorkName(rs.getString(2));
				rwsVoucher
						.setCheckMeasuredBy(employeeHash.get(rs.getString(3)) == null ? "NA"
								: employeeHash.get(rs.getString(3)));
				rwsVoucher.setCheckMeasuredDate(rs.getString(4));
				rwsVoucher.setSuperCheckMeasuredBy(employeeHash.get(rs
						.getString(5)) == null ? "NA" : employeeHash.get(rs
						.getString(5)));
				rwsVoucher.setSuperCheckMeasuredDate(rs.getString(6));
				rwsVoucher.setVoucherDate(rs.getString(8));
				rwsVoucher.setPaoInAdmissible(rs.getString("paoadmissible"));
				rwsVoucher.setVoucherAmt(rs.getString(9));
				rwsVoucher.setBillSlNo(rs.getString(13));
				rwsVoucher.setBillNo(rs.getString(14));
				rwsVoucher.setBillAmountContractor(rs.getString(15));
				rwsVoucher.setBillAmountAdmissible(rs.getString(16));

				vouchersList.add(rwsVoucher);

			}

		} catch (Exception e) {
			//e.printStackTrace();
			System.out.println("Exception in getVouchersList of RwsVoucherFwdDAO "+e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (psmt != null) {
					psmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in getVouchersList of RwsVoucherFwdDAO finally "+e);
			}
		}

		return vouchersList;
	}

	private HashMap<String, String> getAllEmployes(Connection conn) {

		Statement stmt = null;
		ResultSet rs = null;
		HashMap<String, String> employeeList = new HashMap<String, String>();
		try {
			stmt = conn.createStatement();
			String empQuery = "select EMPLOYEE_CODE,nvl(EMPLOYEE_NAME,''),nvl(EMPLOYEE_SURNAME,'') from RWS_EMPLOYEE_TBL where EMPLOYEE_CODE is not null";

			rs = stmt.executeQuery(empQuery);
			while (rs.next()) {

				employeeList.put(rs.getString(1),
						rs.getString(2) + rs.getString(3));
			}

		} catch (Exception e) {
			System.out.println("Exception in getAllEmployes of RwsVoucherFwdDAO "+e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in getAllEmployes of RwsVoucherFwdDAO finally "+e);
			}
		}

		return employeeList;
	}

	/**
	 * 
	 * @param rwsVoucherFwdActionForm
	 * @param request
	 */
	public void updateVouchers(RwsVoucherFwdActionForm rwsVoucherFwdActionForm,
			HttpServletRequest request) {
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;

		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			String updateQuery = "update rws_work_exp_voucher_tbl set ee_approved_date=sysdate where work_id=? and BILL_SL_NO =?";
			psmt = conn.prepareStatement(updateQuery);
			int selectedCount = 0;
			for (RwsVoucher rwsVoucher : rwsVoucherFwdActionForm
					.getVouchersList()) {
				if (rwsVoucher.getChecks() != null
						&& rwsVoucher.getChecks().equals("on")) {
					selectedCount++;
					psmt.setString(1, rwsVoucher.getWorkId());
					psmt.setString(2, rwsVoucher.getBillSlNo());
					psmt.addBatch();
				}

			}

			int recCount[] = psmt.executeBatch();
			if (recCount.length == selectedCount) {
				request.setAttribute("message",
						"Selected Voucher(s) Approved Successfully");
				conn.commit();
				conn.setAutoCommit(true);
			} else {
				request.setAttribute("message", "Failed");
			}

		} catch (Exception e) {
			System.out.println("Exception in updateVouchers of RwsVoucherFwdDAO "+e);
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				System.out.println("Exception in updateVouchers of RwsVoucherFwdDAO roolback "+e1);
			}
		} finally {

			
			try {
				conn.setAutoCommit(true);
				if (psmt != null) {
					psmt.close();
				}
				if (conn != null) {
					conn.close();
				}

			} catch (Exception e) {
				System.out.println("Exception in updateVouchers of RwsVoucherFwdDAO finally "+e);
			}
		}
	}
}
