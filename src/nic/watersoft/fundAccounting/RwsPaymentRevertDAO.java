package nic.watersoft.fundAccounting;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.works.WorksData1;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsPaymentRevertDAO {

	/**
	 * Return the Transaction Dates which are not processed at Bank.
	 * 
	 * @param rwsPaymentRevertActionForm
	 * 
	 * @return
	 */
	public ArrayList<LabelValueBean> getTxDates(
			RwsPaymentRevertActionForm rwsPaymentRevertActionForm) {

		ArrayList<LabelValueBean> txDates = new ArrayList<LabelValueBean>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String serverDate = new WorksData1().getServerDate();

		try {
			conn = RwsOffices.getConn();
			String txDateQuery = "";
			if (rwsPaymentRevertActionForm.getTxType() != null
					&& rwsPaymentRevertActionForm.getTxType().equals(
							RwsPaymentRevertAction.TX_BANK)) {
			    txDateQuery = "select distinct to_char(max(send_date),'dd/mm/yyyy') from rws_bill_bank_settlement_tbl where sysdate-send_date <7 and SUCCESS_TXID  is null  and BILL_ACTIVATION_FLAG ='I' order by 1 desc";
				
			} else if (rwsPaymentRevertActionForm.getTxType() != null
					&& rwsPaymentRevertActionForm.getTxType().equals(
							RwsPaymentRevertAction.TX_PAO)) {
				txDateQuery = "select distinct to_char(max(send_date),'dd/mm/yyyy') from rws_bill_PAO_settlement_tbl where sysdate-send_date <7 ";
			}
			else if	(rwsPaymentRevertActionForm.getTxType() != null
			&& rwsPaymentRevertActionForm.getTxType().equals(
					RwsPaymentRevertAction.TX_FORWARD_PAO)) {
				
				
				
			txDateQuery = "select distinct to_char(max(send_date),'dd/mm/yyyy') from rws_bill_bank_settlement_tbl where  sysdate-send_date <27 and SUCCESS_TXID is null and BILL_ACTIVATION_FLAG ='P' order by 1 desc";
			
			
			}
			
			pstmt = conn.prepareStatement(txDateQuery);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {

				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setLabel(rs.getString(1));
				labelValueBean.setValue(rs.getString(1));
				labelValueBean.setLabelValue(rs.getString(1));

				txDates.add(labelValueBean);
				
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return txDates;
	}

	/**
	 * 
	 * @param rwsPaymentRevertActionForm
	 *            .getTxDate()
	 * @return
	 */
	public ArrayList<LabelValueBean> getTxIds(
			RwsPaymentRevertActionForm rwsPaymentRevertActionForm) {

		ArrayList<LabelValueBean> txIds = new ArrayList<LabelValueBean>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = RwsOffices.getConn();
			String txDateQuery = "";

			if (rwsPaymentRevertActionForm.getTxType() != null
					&& rwsPaymentRevertActionForm.getTxType().equals(
							RwsPaymentRevertAction.TX_BANK)) {
				txDateQuery = "select distinct TXID from rws_bill_bank_bridge_tbl where to_char(BANK_SEND_DATE,'dd/mm/yyyy')=?";
			} else if (rwsPaymentRevertActionForm.getTxType() != null
					&& rwsPaymentRevertActionForm.getTxType().equals(
							RwsPaymentRevertAction.TX_PAO)) {
				txDateQuery = "select distinct STATE_TXID from rws_bill_bank_bridge_tbl where to_char(STATE_SEND_DATE ,'dd/mm/yyyy')=?";
			}
			
			else if (rwsPaymentRevertActionForm.getTxType() != null
					&& rwsPaymentRevertActionForm.getTxType().equals(
							RwsPaymentRevertAction.TX_FORWARD_PAO)) {	
				System.out.println("txDateQuery");
				txDateQuery = "select distinct a.TXID from rws_bill_bank_bridge_tbl a, rws_bill_bank_settlement_tbl  b  where SUCCESS_TXID is null  and to_char(BANK_SEND_DATE ,'dd/mm/yyyy')=?";
				System.out.println("txDateQuery"+txDateQuery);
			}
			
			
			pstmt = conn.prepareStatement(txDateQuery);
			pstmt.setString(1, rwsPaymentRevertActionForm.getTxDate());
			rs = pstmt.executeQuery();
			while (rs.next()) {

				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setLabel(rs.getString(1));
				labelValueBean.setValue(rs.getString(1));
				labelValueBean.setLabelValue(rs.getString(1));

				txIds.add(labelValueBean);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return txIds;
	}

	/**
	 * 
	 * @param rwsPaymentRevertActionForm
	 * @param request
	 */

	public void getTxDetails(
			RwsPaymentRevertActionForm rwsPaymentRevertActionForm,
			HttpServletRequest request) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<RwsTxBillRecord> txBillsList = new ArrayList<RwsTxBillRecord>();

		try {
			conn = RwsOffices.getConn();
			String txDateQuery = "";
			if (rwsPaymentRevertActionForm.getTxType() != null
					&& rwsPaymentRevertActionForm.getTxType().equals(
							RwsPaymentRevertAction.TX_BANK)) {
				txDateQuery = "select a.WORK_ID,b.work_name,a.OFFICE_CODE,a.BILL_SL_NO ,a.BILL_AMOUNT_CENTRAL ,to_char(BANK_SEND_DATE ,'dd/mm/yyyy') ,a.TXID  from rws_bill_bank_bridge_det_tbl a,rws_work_admn_tbl b  where  a.work_id=b.work_id and to_char(BANK_SEND_DATE,'dd/mm/yyyy')=? and txid=?";
			} else if (rwsPaymentRevertActionForm.getTxType() != null
					&& rwsPaymentRevertActionForm.getTxType().equals(
							RwsPaymentRevertAction.TX_PAO)) {
				txDateQuery = "select a.WORK_ID,b.work_name,a.OFFICE_CODE,a.BILL_SL_NO ,a.BILL_AMOUT_STATE ,to_char(STATE_SEND_DATE ,'dd/mm/yyyy') ,a.STATE_TXID   from rws_bill_pao_bridge_det_tbl a,rws_work_admn_tbl b  where  a.work_id=b.work_id and  to_char(STATE_SEND_DATE ,'dd/mm/yyyy')=? and STATE_TXID =?";
			}
			else if (rwsPaymentRevertActionForm.getTxType() != null
					&& rwsPaymentRevertActionForm.getTxType().equals(
							RwsPaymentRevertAction.TX_FORWARD_PAO)) {
				txDateQuery = "select a.WORK_ID,b.work_name,a.OFFICE_CODE,a.BILL_SL_NO ,a.BILL_AMOUNT_CENTRAL ,to_char(BANK_SEND_DATE ,'dd/mm/yyyy') ,a.TXID  from rws_bill_bank_bridge_det_tbl a,rws_work_admn_tbl b  where  forward_bank_pao='PAO' and a.work_id=b.work_id and to_char(BANK_SEND_DATE,'dd/mm/yyyy')=? and txid=?";
				
				System.out.println("bank forwardpao select"+txDateQuery);
			}
			
			
			
			pstmt = conn.prepareStatement(txDateQuery);
			pstmt.setString(1, rwsPaymentRevertActionForm.getTxDate());
			pstmt.setString(2, rwsPaymentRevertActionForm.getTxId());

			rs = pstmt.executeQuery();
			double totAmount = 0;
			int totRecords = 0;
			while (rs.next()) {

				RwsTxBillRecord rwsTxBillRecord = new RwsTxBillRecord();
				rwsTxBillRecord.setWorkId(rs.getString(1));
				rwsTxBillRecord.setWorkName(rs.getString(2));
				rwsTxBillRecord.setOfficeCode(rs.getString(3));
				rwsTxBillRecord.setBillSlNo(rs.getString(4));
				rwsTxBillRecord.setBillAmount(rs.getString(5));
				rwsTxBillRecord.setBankSendDate(rs.getString(6));
				rwsTxBillRecord.setTxId(rs.getString(7));

				txBillsList.add(rwsTxBillRecord);

				totRecords++;
				totAmount += Double.parseDouble(rs.getString(5));

			}

			DecimalFormat ndf = new DecimalFormat("#######");
			rwsPaymentRevertActionForm
					.setTotalBills(String.valueOf(totRecords));
			rwsPaymentRevertActionForm.setTotalProccessedAmount(String
					.valueOf(ndf.format(totAmount)));
			rwsPaymentRevertActionForm.setTxBillsList(txBillsList);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (pstmt != null) {
					pstmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	/**
	 * 1.delete from rws_bill_bank_bridge_temp_tbl; 2.delete from
	 * rws_bill_bank_bridge_det_tbl where TXID ='2014000027'; 3.delete from
	 * rws_bill_bank_bridge_tbl where TXID ='2014000027' and STATE_TXID is null;
	 * 4.delete from rws_bill_bank_settlement_tbl where TXID ='2014000027';
	 * 5.update rws_bill_bank_bridge_tbl set
	 * TXID='',BILL_AMOUNT_CENTRAL='',BANK_SEND_DATE='',CENTRAL_FLAG='N' where
	 * TXID ='2014000027' and STATE_TXID is not null; 6.delete * from
	 * rws_bill_sett_send_file_tbl where to_char(TDATE,'dd/mm/yy')='02/09/14'
	 * AND TXID='2014000027';
	 * 
	 * @param rwsPaymentRevertActionForm
	 * @param request
	 * @param userId
	 */
	public void processBankRevertion(
			RwsPaymentRevertActionForm rwsPaymentRevertActionForm,
			HttpServletRequest request, String userId, String ipAddress) {
		Connection conn = null;
		Statement stmt = null, stmt1 = null;
		ResultSet rs = null;
		String txFilePath = "";

		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			stmt1 = conn.createStatement();
			String serverDate = new WorksData1().getServerDate();

			String txFileQuery = "select TXT_FILE_PATH from  rws_bill_sett_send_file_tbl WHERE to_char(TDATE,'dd/mm/yyyy')='"
					+ rwsPaymentRevertActionForm.getTxDate()
					+ "' AND TXID='"
					+ rwsPaymentRevertActionForm.getTxId() + "' ";

			Debug.println("Query1:" + txFileQuery);
			rs = stmt1.executeQuery(txFileQuery);

			while (rs.next()) {
				txFilePath = rs.getString(1);
			}
			/*
			 * Capture the revert transaction details in bank revert table.
			 */
			String txRevertQuery = "insert into rws_bank_revert_tbl select work_id,OFFICE_CODE,BILL_SL_NO ,BILL_AMOUNT_CENTRAL,BANK_SEND_DATE ,TXID,'"
					+ userId
					+ "',to_date('"
					+ serverDate
					+ "','dd/mm/yyyy'),'"
					+ ipAddress
					+ "' from rws_bill_bank_bridge_tbl where  TXID ='"
					+ rwsPaymentRevertActionForm.getTxId()
					+ "' and to_char(BANK_SEND_DATE,'dd/mm/yyyy')='"
					+ rwsPaymentRevertActionForm.getTxDate() + "'";
			Debug.println("Query2:" + txRevertQuery);
			stmt.addBatch(txRevertQuery);

			/*
			 * Delete the records in Temp Table
			 */
			String txTempQuery = "delete from rws_bill_bank_bridge_temp_tbl";
			Debug.println("Query3:" + txTempQuery);
			stmt.addBatch(txTempQuery);

			/*
			 * Delete the records in Bill Bank Bridge Details Table
			 */
			String txBankDetQuery = "delete from rws_bill_bank_bridge_det_tbl where TXID ='"
					+ rwsPaymentRevertActionForm.getTxId()
					+ "' and to_char(BANK_SEND_DATE,'dd/mm/yyyy')='"
					+ rwsPaymentRevertActionForm.getTxDate() + "'";
			Debug.println("Query4:" + txBankDetQuery);
			stmt.addBatch(txBankDetQuery);

			/*
			 * Delete the records in Bill Bank Bridge Table where statetxid is
			 * null
			 */
			String txQuery = "delete from rws_bill_bank_bridge_tbl where TXID ='"
					+ rwsPaymentRevertActionForm.getTxId()
					+ "' and   STATE_TXID is null";
			Debug.println("Query5:" + txQuery);
			stmt.addBatch(txQuery);

			String txSettlementQuery = "delete from rws_bill_bank_settlement_tbl where TXID ='"
					+ rwsPaymentRevertActionForm.getTxId() + "'";
			Debug.println("Query6:" + txSettlementQuery);
			stmt.addBatch(txSettlementQuery);

			String txUpdateQuery = "update rws_bill_bank_bridge_tbl set TXID='',BILL_AMOUNT_CENTRAL='',BANK_SEND_DATE='',CENTRAL_FLAG='N'  where TXID ='"
					+ rwsPaymentRevertActionForm.getTxId()
					+ "' and STATE_TXID is not null";
			Debug.println("Query7:" + txUpdateQuery);
			stmt.addBatch(txUpdateQuery);

			/*
			 * 
			 */
			String txFile = "delete from   rws_bill_sett_send_file_tbl where to_char(TDATE,'dd/mm/yyyy')='"
					+ rwsPaymentRevertActionForm.getTxDate()
					+ "' AND TXID='"
					+ rwsPaymentRevertActionForm.getTxId() + "'";
			Debug.println("Query8:" + txFile);
			stmt.addBatch(txFile);

			int resCount[] = stmt.executeBatch();

			StringBuffer mesg = new StringBuffer();
			mesg.append("BANK Transaction Reverted Successfully with following detais:");
			mesg.append("Total No OF Records Inserted:" + resCount[0]);
			mesg.append("Total No OF Records Deleted Temp Table:" + resCount[1]);
			mesg.append("Total No OF Records Deleted from Details Table :"
					+ resCount[2]);
			mesg.append("Total No OF Records Deleted from bridge table:"
					+ resCount[3]);
			mesg.append("Total No OF Records Deleted from Settlement table:"
					+ resCount[4]);
			mesg.append("Total No OF Records Updated from bridge  table:"
					+ resCount[5]);

			if (resCount.length > 0) {

				request.setAttribute("message", mesg.toString());
				conn.commit();
				conn.setAutoCommit(true);
				// if (moveServerFile(rwsPaymentRevertActionForm, txFilePath,
				// request)) {
				//
				// }
			}

		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
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
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	/**
	 * /usr/local/tomcat2/webapps/pred/downloads/bank/2014/JUL-2014/24-07-2014/
	 * RWANDB20140724.02
	 * 
	 * @param rwsPaymentRevertActionForm
	 * @param txFilePath
	 * @param request
	 * @return
	 */
	public static boolean moveServerFile(
			RwsPaymentRevertActionForm rwsPaymentRevertActionForm,
			String txFilePath, HttpServletRequest request) {

		String reqFilePath = request.getRealPath("");
		String dirs[] = reqFilePath.split("/");
		if (dirs[3] != null && dirs[3].equals("tomcat1")) {

		}

		String fList[] = txFilePath.split("/");

		createTargetDirectory(fList);

		StringBuffer strBuffer1 = new StringBuffer();
		strBuffer1.append("/usr/local/tomcat2/webapps/pred/downloads/revert/");
		strBuffer1.append(fList[8]);
		strBuffer1.append("/");
		strBuffer1.append(fList[9]);
		strBuffer1.append("/");
		strBuffer1.append(fList[10]);
		strBuffer1.append("/");
		strBuffer1.append(fList[11]);

		// System.out.println(strBuffer.toString());
		System.out.println(strBuffer1.toString());
		return false;

	}

	private static void createTargetDirectory(String[] fList) {
		StringBuffer strBuffer = new StringBuffer();
		strBuffer.append("/usr/local/tomcat1/webapps/pred/downloads/revert/");
		strBuffer.append(fList[8]);
		strBuffer.append("/");
		strBuffer.append(fList[9]);
		strBuffer.append("/");
		strBuffer.append(fList[10]);
		strBuffer.append("/");
		strBuffer.append(fList[11]);

	}

	public static void main(String[] args) {
		String res[] = "/usr/local/tomcat1/webapps/pred".split("/");
		System.out.println(res[0]);
		System.out.println(res[1]);
		System.out.println(res[2]);
		System.out.println(res[3]);
		System.out.println(res[4]);
		System.out.println(res[5]);
	}

	private boolean isFileExixts(
			RwsPaymentRevertActionForm rwsPaymentRevertActionForm) {

		return false;
	}

	/**
	 * 
	 * @param rwsPaymentRevertActionForm
	 * @param request
	 * @param userId
	 */

	public void processPAORevertion(
			RwsPaymentRevertActionForm rwsPaymentRevertActionForm,
			HttpServletRequest request, String userId, String ipAddress) {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;

		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			String serverDate = new WorksData1().getServerDate();

			/*
			 * Capture the revert transaction details in bank revert table.
			 */
			String txRevertQuery = "insert into rws_pao_revert_tbl select work_id,OFFICE_CODE,BILL_SL_NO ,BILL_AMOUT_STATE,STATE_SEND_DATE ,STATE_TXID,'"
					+ userId
					+ "',to_date('"
					+ serverDate
					+ "','dd/mm/yyyy'),'"
					+ ipAddress
					+ "' from rws_bill_bank_bridge_tbl where  STATE_TXID ='"
					+ rwsPaymentRevertActionForm.getTxId()
					+ "' and to_char(STATE_SEND_DATE,'dd/mm/yyyy')='"
					+ rwsPaymentRevertActionForm.getTxDate() + "'";
			Debug.println("Query2:" + txRevertQuery);
			stmt.addBatch(txRevertQuery);

			/*
			 * Delete the records in Temp Table
			 */
			String txTempQuery = "delete from rws_bill_pao_bridge_temp_tbl";
			Debug.println("Query3:" + txTempQuery);
			stmt.addBatch(txTempQuery);

			/*
			 * Delete the records in Bill Bank Bridge Details Table
			 */
			String txBankDetQuery = "delete from rws_bill_pao_bridge_det_tbl where STATE_TXID ='"
					+ rwsPaymentRevertActionForm.getTxId()
					+ "' and to_char(STATE_SEND_DATE,'dd/mm/yyyy')='"
					+ rwsPaymentRevertActionForm.getTxDate() + "'";
			Debug.println("Query4:" + txBankDetQuery);
			stmt.addBatch(txBankDetQuery);

			/*
			 * Delete the records in Bill Bank Bridge Table where statetxid is
			 * null
			 */
			String txQuery = "delete from rws_bill_bank_bridge_tbl where STATE_TXID ='"
					+ rwsPaymentRevertActionForm.getTxId()
					+ "' and  TXID is null";
			Debug.println("Query5:" + txQuery);
			stmt.addBatch(txQuery);

			String txSettlementQuery = "delete from rws_bill_pao_settlement_tbl where TXID ='"
					+ rwsPaymentRevertActionForm.getTxId() + "'";
			Debug.println("Query6:" + txSettlementQuery);
			stmt.addBatch(txSettlementQuery);

			String txUpdateQuery = "update rws_bill_bank_bridge_tbl set STATE_TXID='',BILL_AMOUT_STATE='',STATE_SEND_DATE='',STATE_FLAG='N'  where STATE_TXID ='"
					+ rwsPaymentRevertActionForm.getTxId()
					+ "' and TXID is not null";
			Debug.println("Query7:" + txUpdateQuery);
			stmt.addBatch(txUpdateQuery);

			int resCount[] = stmt.executeBatch();

			StringBuffer mesg = new StringBuffer();
			mesg.append("PAO Transaction Reverted Successfully with following detais:");
		//	mesg.append("Total No OF Records Deleted Temp Table:" + resCount[0]);
			mesg.append("Total No OF Records Deleted from Details Table :"
					+ resCount[1]);
			mesg.append("Total No OF Records Deleted from bridge table:"
					+ resCount[2]);
			mesg.append("Total No OF Records Deleted from Settlement table:"
					+ resCount[3]);
			mesg.append("Total No OF Records Updated from bridge  table:"
					+ resCount[4]);

			if (resCount.length > 0) {

				request.setAttribute("message", mesg.toString());
				conn.commit();
				conn.setAutoCommit(true);
			}

		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
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
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}
	
	
	
	// ADDED FORWARD TO PAO BANK TRANSACTIONS  ----- 07-02-2015//
	
	public void processFORWARDPAORevertion(
			RwsPaymentRevertActionForm rwsPaymentRevertActionForm,
			HttpServletRequest request, String userId, String ipAddress) {
		Connection conn = null;
		Statement stmt = null, stmt1 = null;
		ResultSet rs = null;
	//	String txFilePath = "";

		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			stmt1 = conn.createStatement();
			String serverDate = new WorksData1().getServerDate();

			/*String txFileQuery = "select TXT_FILE_PATH from  rws_bill_sett_send_file_tbl WHERE to_char(TDATE,'dd/mm/yy')='"
					+ rwsPaymentRevertActionForm.getTxDate()
					+ "' AND TXID='"
					+ rwsPaymentRevertActionForm.getTxId() + "' ";

			Debug.println("Query1:" + txFileQuery);
			rs = stmt1.executeQuery(txFileQuery);

			while (rs.next()) {
				txFilePath = rs.getString(1);
			}*/
			/*
			 * Capture the revert transaction details in bank revert table.
			 */
			String txRevertQuery = "insert into rws_bank_revert_tbl select work_id,OFFICE_CODE,BILL_SL_NO ,BILL_AMOUNT_CENTRAL,BANK_SEND_DATE ,TXID,'"
					+ userId
					+ "',to_date('"
					+ serverDate
					+ "','dd/mm/yyyy'),'"
					+ ipAddress
					+ "' from rws_bill_bank_bridge_tbl where  TXID ='"
					+ rwsPaymentRevertActionForm.getTxId()
					+ "' and to_char(BANK_SEND_DATE,'dd/mm/yyyy')='"
					+ rwsPaymentRevertActionForm.getTxDate() + "'";
			Debug.println("Query2:" + txRevertQuery);
			stmt.addBatch(txRevertQuery);

			/*
			 * Delete the records in Temp Table
			 */
			String txTempQuery = "delete from rws_bill_bank_bridge_temp_tbl";
			Debug.println("Query3:" + txTempQuery);
			stmt.addBatch(txTempQuery);

			/*
			 * Delete the records in Bill Bank Bridge Details Table
			 */
			String txBankDetQuery = "delete from rws_bill_bank_bridge_det_tbl where FORWARD_BANK_PAO='PAO' and  TXID ='"
					+ rwsPaymentRevertActionForm.getTxId()
					+ "' and to_char(BANK_SEND_DATE,'dd/mm/yyyy')='"
					+ rwsPaymentRevertActionForm.getTxDate() + "'";
			Debug.println("Query4:" + txBankDetQuery);
			stmt.addBatch(txBankDetQuery);

			/*
			 * Delete the records in Bill Bank Bridge Table where statetxid is
			 * null
			 */
			String txQuery = "delete from rws_bill_bank_bridge_tbl where TXID ='"
					+ rwsPaymentRevertActionForm.getTxId()
					+ "' and   STATE_TXID is null";
			Debug.println("Query5:" + txQuery);
			stmt.addBatch(txQuery);

			String txSettlementQuery = "delete from rws_bill_bank_settlement_tbl where TXID ='"
					+ rwsPaymentRevertActionForm.getTxId() + "'";
			Debug.println("Query6:" + txSettlementQuery);
			stmt.addBatch(txSettlementQuery);

			String txUpdateQuery = "update rws_bill_bank_bridge_tbl set TXID='',BILL_AMOUNT_CENTRAL='',BANK_SEND_DATE='',CENTRAL_FLAG='N'  where TXID ='"
					+ rwsPaymentRevertActionForm.getTxId()
					+ "' and STATE_TXID is not null";
			Debug.println("Query7:" + txUpdateQuery);
			stmt.addBatch(txUpdateQuery);

			/*
			 * 
			 */
			/*String txFile = "delete from   rws_bill_sett_send_file_tbl where to_char(TDATE,'dd/mm/yy')='"
					+ rwsPaymentRevertActionForm.getTxDate()
					+ "' AND TXID='"
					+ rwsPaymentRevertActionForm.getTxId() + "'";
			Debug.println("Query8:" + txFile);
			stmt.addBatch(txFile);*/

			int resCount[] = stmt.executeBatch();

			StringBuffer mesg = new StringBuffer();
			mesg.append("FORWARD PAO FOR BANK Transaction Reverted Successfully with following detais:");
			mesg.append("Total No OF Records Inserted:" + resCount[0]);
			//mesg.append("Total No OF Records Deleted Temp Table:" + resCount[1]);
			mesg.append("Total No OF Records Deleted from Details Table :"
					+ resCount[2]);
			mesg.append("Total No OF Records Deleted from bridge table:"
					+ resCount[3]);
			mesg.append("Total No OF Records Deleted from Settlement table:"
					+ resCount[4]);
			mesg.append("Total No OF Records Updated from bridge  table:"
					+ resCount[5]);

			if (resCount.length > 0) {

				request.setAttribute("message", mesg.toString());
				conn.commit();
				conn.setAutoCommit(true);
				// if (moveServerFile(rwsPaymentRevertActionForm, txFilePath,
				// request)) {
				//
				// }
			}

		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (SQLException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
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
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	
	//END//
	

}
