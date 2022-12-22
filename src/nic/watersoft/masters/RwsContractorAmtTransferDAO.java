/*
 * Created on 30-05-2013
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.masters;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.Writer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Hashtable;

import javax.servlet.http.HttpServletRequest;

import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RWSBankUtills;
import nic.watersoft.commons.RwsDigitalSignatureToken;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUtils;
import nic.watersoft.works.WorksData1;

/**
 * @author RWSS_DPT1(Sai Prasad N)
 * 
 *         TODO To change the template for this generated type comment go to
 *         Window - Preferences - Java - Code Style - Code Templates
 */
public class RwsContractorAmtTransferDAO {

	public void getTransfersList(ArrayList transfersList, Connection conn,
			long ftrNo) {
		Statement stmt = null;
		ResultSet rs = null;
		int count = 1;

		String serverDate = new WorksData1().getServerDate();
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();

			/**
			 * Setting Group Transcation ID
			 */
			// long ftrNo = getGroupTransanctionID(conn);
			// amtTransferBean.setGroupTransacationID(gTxId);
			// and b.type_of_asset='03'
			String query = "select dname,division_office_name, c.CONTRACTOR_NAME_COMPANY ,h.bank,h.branch_name,g.ifsc_code,g.account_no ,SUM(BILL_AMOUNT_CENTRAL),c.contractor_code,a.office_code,nvl(CONTRACTOR_ADDRESS1,' '),nvl(CONTRACTOR_ADDRESS2,' '),nvl(CONTRACTOR_ADDRESS3,' '),nvl(CONTRACTOR_ADDRESS4,' '),nvl(CONTRACTOR_MOBILE,' '),nvl(CONTRACTOR_EMAIL ,' '),d.work_id  from rws_bill_bank_bridge_temp_tbl a,rws_work_bill_tbl wb,rws_work_admn_tbl b,RWS_CONTRACTOR_TBL c,rws_work_contractor_map_tbl d ,rws_district_tbl e,rws_division_office_tbl f,rws_contractor_bank_lnk_tbl g,rws_bank_ifsc_code_tbl h where a.work_id=b.work_id  and wb.work_id=b.work_id and a.BILL_SL_NO=wb.BILL_SL_NO and wb.AGENCY_TO_PAY <>'EE' and d.work_id=b.work_id and c.contractor_code=d.contractor_code and g.contractor_code=c.contractor_code   and  substr(a.office_code,2,2)=e.dcode and substr(a.office_code,4,1)=f.division_office_code and  e.dcode=f.circle_office_code and h.ifsc_code=g.ifsc_code and a.PAYMENT_MADE_TO='C' group by dname,division_office_name, c.CONTRACTOR_NAME_COMPANY ,h.bank,h.branch_name,g.ifsc_code,g.account_no,c.contractor_code,a.office_code,nvl(CONTRACTOR_ADDRESS1,' '),nvl(CONTRACTOR_ADDRESS2,' '),nvl(CONTRACTOR_ADDRESS3,' '),nvl(CONTRACTOR_ADDRESS4,' '),nvl(CONTRACTOR_MOBILE,' '),nvl(CONTRACTOR_EMAIL ,' '),d.work_id ";
			System.out.println("enter2:" + query);
			rs = stmt.executeQuery(query);

			while (rs.next()) {
				String conrtactorAddress = rs.getString(11) + rs.getString(12)
						+ rs.getString(13) + rs.getString(14);
				RwsContractorAmtRecord amtRecord = new RwsContractorAmtRecord();

				String groupTransctionID = "" + ftrNo;
				if (groupTransctionID == null
						|| (groupTransctionID != null && (groupTransctionID
								.equals("") || groupTransctionID.equals("0")))) {
					groupTransctionID = "000000001";
				}
				if (groupTransctionID.length() == 1)
					groupTransctionID = "00000000" + groupTransctionID;
				else if (groupTransctionID.length() == 2)
					groupTransctionID = "0000000" + groupTransctionID;
				else if (groupTransctionID.length() == 3)
					groupTransctionID = "000000" + groupTransctionID;
				else if (groupTransctionID.length() == 4)
					groupTransctionID = "00000" + groupTransctionID;
				else if (groupTransctionID.length() == 5)
					groupTransctionID = "0000" + groupTransctionID;
				else if (groupTransctionID.length() == 6)
					groupTransctionID = "000" + groupTransctionID;
				else if (groupTransctionID.length() == 7)
					groupTransctionID = "00" + groupTransctionID;
				else if (groupTransctionID.length() == 8)
					groupTransctionID = "0" + groupTransctionID;

				groupTransctionID = serverDate.substring(6, 10)
						+ groupTransctionID;

				amtRecord.setFtrNo(groupTransctionID); // TODOS
				amtRecord.setCircle(rs.getString(1));
				amtRecord.setDivision(rs.getString(2));
				amtRecord.setContractorName(rs.getString(3));
				amtRecord.setContractorBankName(rs.getString(4));
				amtRecord.setContractorBranchName(rs.getString(5));
				amtRecord.setContractorIFSCCode(rs.getString(6));
				amtRecord.setContractorACCNO(rs.getString(7));
				amtRecord
						.setTxType(gettxType(rs.getString(8), rs.getString(6)));
				amtRecord.setTransferAmount(rs.getString(8));
				amtRecord.setContractorCode(rs.getString(9));
				amtRecord.setOfficeCode(rs.getString(10));
				amtRecord.setContractorAddress(conrtactorAddress);
				amtRecord.setContractorMobile(rs.getString(15));
				amtRecord.setConractorEmail(rs.getString(16));
				amtRecord.setFileNumber(getFileNumber(amtRecord.getTxType(),
						conn));
				amtRecord.setWorkId(rs.getString(17));
				setRemmiterDetails(amtRecord, conn);

				transfersList.add(amtRecord);

				count++;
				ftrNo++;

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
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * @param amtTransferBean
	 * @return transfers List
	 */
	public ArrayList getTransfersList(
			RwsContractorAmtTransferBean amtTransferBean) {

		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		int count = 1;

		String serverDate = new WorksData1().getServerDate();

		ArrayList transfersList = new ArrayList();
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();

			/**
			 * Setting Group Transcation ID
			 */
			long ftrNo = getGroupTransanctionID(conn);
			// amtTransferBean.setGroupTransacationID(gTxId);
			// and b.type_of_asset='03'
			String query = "select dname,division_office_name, c.CONTRACTOR_NAME_COMPANY ,h.bank,h.branch_name,g.ifsc_code,g.account_no ,SUM(BILL_AMOUNT_CENTRAL),c.contractor_code,a.office_code,nvl(CONTRACTOR_ADDRESS1,' '),nvl(CONTRACTOR_ADDRESS2,' '),nvl(CONTRACTOR_ADDRESS3,' '),nvl(CONTRACTOR_ADDRESS4,' '),nvl(CONTRACTOR_MOBILE,' '),nvl(CONTRACTOR_EMAIL ,' ') ,d.work_id from rws_bill_bank_bridge_temp_tbl a,rws_work_bill_tbl wb,rws_work_admn_tbl b,RWS_CONTRACTOR_TBL c,rws_contractor_selection_tbl d ,rws_district_tbl e,rws_division_office_tbl f,rws_contractor_bank_lnk_tbl g,rws_bank_ifsc_code_tbl h where a.work_id=b.work_id  and wb.work_id=b.work_id and a.BILL_SL_NO=wb.BILL_SL_NO and wb.AGENCY_TO_PAY <>'EE' and d.work_id=b.work_id and c.contractor_code=d.contractor_code and g.contractor_code=c.contractor_code   and  substr(a.office_code,2,2)=e.dcode and substr(a.office_code,4,1)=f.division_office_code and  e.dcode=f.circle_office_code and h.ifsc_code=g.ifsc_code and a.PAYMENT_MADE_TO='C' group by dname,division_office_name, c.CONTRACTOR_NAME_COMPANY ,h.bank,h.branch_name,g.ifsc_code,g.account_no,c.contractor_code,a.office_code,nvl(CONTRACTOR_ADDRESS1,' '),nvl(CONTRACTOR_ADDRESS2,' '),nvl(CONTRACTOR_ADDRESS3,' '),nvl(CONTRACTOR_ADDRESS4,' '),nvl(CONTRACTOR_MOBILE,' '),nvl(CONTRACTOR_EMAIL ,' '),d.work_id ";
			System.out.println("enter1:" + query);
			rs = stmt.executeQuery(query);

			while (rs.next()) {
				String conrtactorAddress = rs.getString(11) + rs.getString(12)
						+ rs.getString(13) + rs.getString(14);
				RwsContractorAmtRecord amtRecord = new RwsContractorAmtRecord();

				String groupTransctionID = "" + ftrNo;
				if (groupTransctionID == null
						|| (groupTransctionID != null && (groupTransctionID
								.equals("") || groupTransctionID.equals("0")))) {
					groupTransctionID = "000000001";
				}
				if (groupTransctionID.length() == 1)
					groupTransctionID = "00000000" + groupTransctionID;
				else if (groupTransctionID.length() == 2)
					groupTransctionID = "0000000" + groupTransctionID;
				else if (groupTransctionID.length() == 3)
					groupTransctionID = "000000" + groupTransctionID;
				else if (groupTransctionID.length() == 4)
					groupTransctionID = "00000" + groupTransctionID;
				else if (groupTransctionID.length() == 5)
					groupTransctionID = "0000" + groupTransctionID;
				else if (groupTransctionID.length() == 6)
					groupTransctionID = "000" + groupTransctionID;
				else if (groupTransctionID.length() == 7)
					groupTransctionID = "00" + groupTransctionID;
				else if (groupTransctionID.length() == 8)
					groupTransctionID = "0" + groupTransctionID;

				groupTransctionID = serverDate.substring(6, 10)
						+ groupTransctionID;

				amtRecord.setFtrNo(groupTransctionID); // TODOS
				amtRecord.setCircle(rs.getString(1));
				amtRecord.setDivision(rs.getString(2));
				amtRecord.setContractorName(rs.getString(3));
				amtRecord.setContractorBankName(rs.getString(4));
				amtRecord.setContractorBranchName(rs.getString(5));
				amtRecord.setContractorIFSCCode(rs.getString(6));
				amtRecord.setContractorACCNO(rs.getString(7));
				amtRecord
						.setTxType(gettxType(rs.getString(8), rs.getString(6)));
				amtRecord.setTransferAmount(rs.getString(8));
				amtRecord.setContractorCode(rs.getString(9));
				amtRecord.setOfficeCode(rs.getString(10));
				amtRecord.setContractorAddress(conrtactorAddress);
				amtRecord.setContractorMobile(rs.getString(15));
				amtRecord.setConractorEmail(rs.getString(16));
				amtRecord.setWorkId(rs.getString(17));
				amtRecord.setFileNumber(getFileNumber(amtRecord.getTxType(),
						conn));
				setRemmiterDetails(amtRecord, conn);

				transfersList.add(amtRecord);

				count++;
				ftrNo++;

			}

			getTransfersList(transfersList, conn, ftrNo + 1);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (conn != null) {
					conn.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return transfersList;
	}

	private void setRemmiterDetails(RwsContractorAmtRecord amtRecord,
			Connection conn) {

		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			String query = "select IFSC_CODE,ACCOUNT_NUMBER ,NAME from RWS_REMITTER_TBL";
			rs = stmt.executeQuery(query);
			while (rs.next()) {
				amtRecord.setDebitIfscCode(rs.getString(1));
				amtRecord.setDebitAccNo(rs.getString(2));
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
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	private String gettxType(String amount, String contractorIfscCode) {

		double transferAmount = 0;
		if (amount != null && !amount.equals("")) {
			transferAmount = Double.parseDouble(amount);
		}
		if (contractorIfscCode != null
				&& contractorIfscCode.substring(0, 4).equals("ANDB")) {
			return RWSBankUtills.INTR;
		}
		if (transferAmount >= 200000) {
			return RWSBankUtills.RTGS;
		}
		if (transferAmount < 200000) {
			return RWSBankUtills.NEFT;

		}

		return null;
	}

	public long getGroupTransanctionID(Connection conn) {

		String serverDate = new WorksData1().getServerDate();

		Statement stmt = null;
		ResultSet rs = null;
		int groupTransctionIDd = 0;
		long groupTransctionID = 0;
		try {

			stmt = conn.createStatement();
			String q1 = "select max(substr(TXID_CONTRACTOR,5,9)) from rws_contractor_settlement_tbl where substr(TXID_CONTRACTOR,1,4)='"
					+ serverDate.substring(6, 10) + "'";
			rs = stmt.executeQuery(q1);
			if (rs.next()) {
				if (rs.getString(1) != null && !rs.getString(1).equals(""))
					groupTransctionIDd = rs.getInt(1);
			}
			groupTransctionIDd++;

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
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return groupTransctionID;

	}

	/**
	 * @param amtTransferBean
	 * @param request
	 */
	public void processDB(RwsContractorAmtTransferBean amtTransferBean,
			HttpServletRequest request) {

		String ipAddress = request.getRemoteAddr();
		Connection conn = null;
		Statement stmt = null, stmt1 = null, stmt2 = null, stmt3 = null, stmt4 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		WorksData1 worksData1 = new WorksData1();
		String currentDate = worksData1.getServerDate();
		String newLine = "\r\n";
		String neftData = "", rtgsData = "", intrData = "", neftSummary = "", rtgsSummary = "", intrSummary = "";
		int noOfNeftTxns = 0, noOfRtgsTxns = 0, noOfintrTxns = 0;
		double totNEFTAmount = 0, totRTGSAmount = 0, totINTRAmount = 0;
		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);
			stmt = conn.createStatement();
			stmt1 = conn.createStatement();
			stmt2 = conn.createStatement();
			stmt3 = conn.createStatement();
			stmt4 = conn.createStatement();
			String vardiv = "C";
			int count = 0;

			ArrayList recordsList = amtTransferBean.getTransfersList();
			for (int i = 0; i < recordsList.size(); i++) {
				RwsContractorAmtRecord amtRecord = (RwsContractorAmtRecord) recordsList
						.get(i);
				amtRecord.setNarration(request.getParameter("amtRecord[" + i
						+ "].narration"));
				amtRecord.setRemarks(request.getParameter("amtRecord[" + i
						+ "].remarks"));

				String query1 = "select nvl(sum(case when programme_code='60' or programme_code='02' or  programme_code='01' or programme_code='48' or programme_code='32' or programme_code='23' or programme_code='49' or programme_code='51' or programme_code='18' or  programme_code='59' or  programme_code='58' or  programme_code='50'  then bill_amount_central else 0 end),0) as a from rws_bill_bank_bridge_temp_tbl a,rws_work_admn_tbl b where a.work_id=b.work_id and a.PAYMENT_MADE_TO='C'";
				System.out.println("Query1:" + query1);
				rs = stmt4.executeQuery(query1);
				if (rs.next()) {
					String query2 = "update RWS_BANK_GRANT_AMT_TBL set AMOUNT=AMOUNT-"
							+ rs.getString(1) + " where code='1'";
					System.out.println("Query2:" + query2);
					count++;
					stmt.addBatch(query2);
				}

				String query3 = "insert into rws_contractor_settlement_tbl values ('"
						+ amtRecord.getTxType()
						+ "',sysdate,'"
						+ amtRecord.getFtrNo()
						+ "','"
						+ amtRecord.getDebitAccNo()
						+ "','"
						+ amtRecord.getDebitIfscCode()
						+ "','"
						+ amtRecord.getContractorMobile()
						+ "','"
						+ amtRecord.getTransferAmount()
						+ "','"
						+ amtRecord.getContractorCode()
						+ "','"
						+ amtRecord.getContractorACCNO()
						+ "','"
						+ amtRecord.getContractorIFSCCode()
						+ "','O','','','','','"
						+ amtRecord.getRemarks()
						+ "',"
						+ amtRecord.getFileNumber() + ")";

				System.out.println("Query3:" + query3);
				// create file data here TODOs

				// FTR RECORD FOR BANK PROCESS
				if (amtRecord.getTxType() != null
						&& amtRecord.getTxType().equals(RWSBankUtills.NEFT)) {
					noOfNeftTxns++;
					totNEFTAmount += Double.parseDouble(amtRecord
							.getTransferAmount());
					neftData += amtRecord.getTxType()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ RwsUtils.getCurrentDate("dd/MM/yyyy")
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getFtrNo()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getDebitAccNo()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getDebitIfscCode()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getContractorMobile()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getTransferAmount()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getContractorACCNO()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getContractorName()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getContractorAddress()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getContractorBankName()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getContractorIFSCCode()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ RWSBankUtills.BANK_STATUS_OPEN
							+ RWSBankUtills.BANK_FILE_CHAR
							+ RWSBankUtills.BANK_FILE_CHAR
							+ RWSBankUtills.BANK_FILE_CHAR
							+ RWSBankUtills.BANK_FILE_CHAR
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getConractorEmail()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ RWSBankUtills.BANK_FILE_CHAR
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getRemarks()
							+ RWSBankUtills.BANK_FILE_CHAR;
					neftData += newLine;
				}
				if (amtRecord.getTxType() != null
						&& amtRecord.getTxType().equals(RWSBankUtills.RTGS)) {

					noOfRtgsTxns++;
					totRTGSAmount += Double.parseDouble(amtRecord
							.getTransferAmount());
					rtgsData += amtRecord.getTxType()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ RwsUtils.getCurrentDate("dd/MM/yyyy")
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getFtrNo()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getDebitAccNo()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getDebitIfscCode()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getContractorMobile()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getTransferAmount()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getContractorACCNO()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getContractorName()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getContractorAddress()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getContractorBankName()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getContractorIFSCCode()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ RWSBankUtills.BANK_STATUS_OPEN
							+ RWSBankUtills.BANK_FILE_CHAR
							+ RWSBankUtills.BANK_FILE_CHAR
							+ RWSBankUtills.BANK_FILE_CHAR
							+ RWSBankUtills.BANK_FILE_CHAR
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getConractorEmail()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ RWSBankUtills.BANK_FILE_CHAR
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getRemarks()
							+ RWSBankUtills.BANK_FILE_CHAR;
					rtgsData += newLine;

				}
				if (amtRecord.getTxType() != null
						&& amtRecord.getTxType().equals(RWSBankUtills.INTR)) {

					noOfintrTxns++;
					totINTRAmount += Double.parseDouble(amtRecord
							.getTransferAmount());
					intrData += amtRecord.getTxType()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ RwsUtils.getCurrentDate("dd/MM/yyyy")
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getFtrNo()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getDebitAccNo()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getDebitIfscCode()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getContractorMobile()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getTransferAmount()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getContractorACCNO()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getContractorName()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getContractorAddress()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getContractorBankName()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getContractorIFSCCode()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ RWSBankUtills.BANK_STATUS_OPEN
							+ RWSBankUtills.BANK_FILE_CHAR
							+ RWSBankUtills.BANK_FILE_CHAR
							+ RWSBankUtills.BANK_FILE_CHAR
							+ RWSBankUtills.BANK_FILE_CHAR
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getConractorEmail()
							+ RWSBankUtills.BANK_FILE_CHAR
							+ RWSBankUtills.BANK_FILE_CHAR
							+ RWSBankUtills.BANK_FILE_CHAR
							+ amtRecord.getRemarks()
							+ RWSBankUtills.BANK_FILE_CHAR;
					intrData += newLine;
				}

				count++;
				stmt.addBatch(query3);

				String query4 = "insert into rws_bill_bank_bridge_det_tbl SELECT WORK_ID,OFFICE_CODE,BILL_SL_NO,BILL_AMOUNT_CENTRAL,SYSDATE,'Y','"
						+ amtRecord.getFtrNo()
						+ "',BILL_ACTIVATION_FLAG,'"
						+ vardiv
						+ "'TOKEN_SLNO,'"
						+ amtTransferBean.getTokenSLNO()
						+ "','"
						+ ipAddress
						+ "' from rws_bill_bank_bridge_temp_tbl where PAYMENT_MADE_TO='C' and work_id='"
						+ amtRecord.getWorkId() + "'";

				System.out.println("Query4:" + query4);
				count++;
				stmt.addBatch(query4);

				String query5 = "select distinct work_id,bill_sl_no,BILL_AMOUT_STATE from rws_bill_bank_bridge_tbl";

				Hashtable allBills = new Hashtable();
				stmt2 = conn.createStatement();
				rs1 = stmt2.executeQuery(query5);
				while (rs1.next()) {
					allBills.put(rs1.getString(1) + rs1.getString(2), rs1
							.getString(3));
				}

				String query9 = "select * from rws_bill_bank_bridge_temp_tbl where PAYMENT_MADE_TO='C' and work_id='"
						+ amtRecord.getWorkId() + "'";
				System.out.println("query9:" + query9);
				rs2 = stmt3.executeQuery(query9);
				while (rs2.next()) {
					String val = (String) allBills.get(rs2.getString("work_id")
							+ rs2.getString("bill_sl_no"));

					if (val != null && !val.equals("null")) {
						String query6 = "update rws_bill_bank_bridge_tbl set BILL_AMOUNT_central=BILL_AMOUNT_central+'"
								+ rs2.getString(5)
								+ "',BANK_SEND_DATE=sysdate,TXID='"
								+ amtRecord.getFtrNo()
								+ "',central_flag='Y',office_code='"
								+ rs2.getString(2)
								+ "' where work_id='"
								+ rs2.getString(1)
								+ "' and bill_sl_no = '"
								+ rs2.getString(3) + "'";
						System.out.println("Query6:" + query6);
						count++;
						stmt.addBatch(query6);
					} else {
						String query7 = "insert into rws_bill_bank_bridge_tbl values('"
								+ rs2.getString(1)
								+ "','"
								+ rs2.getString(2)
								+ "','"
								+ rs2.getString(3)
								+ "','0','"
								+ rs2.getString(5)
								+ "',sysdate,'N','Y','"
								+ amtRecord.getFtrNo() + "','I','','','C')";

						System.out.println("Query7:" + query7);
						count++;
						stmt.addBatch(query7);
					}
				}
				String query8 = "delete from rws_bill_bank_bridge_temp_tbl where PAYMENT_MADE_TO='C' and work_id='"
						+ amtRecord.getWorkId() + "'";
				count++;
				stmt.addBatch(query8);
			}

			if (neftData != null && !neftData.equals("")) {
				neftSummary = RWSBankUtills.BANK_SUMMARY_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ String.valueOf(noOfNeftTxns)
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ String.valueOf(totNEFTAmount)
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_SUMMARY_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR;
				// neftData += newLine;
				neftData += neftSummary;
			}
			if (rtgsData != null && !rtgsData.equals("")) {
				rtgsSummary = RWSBankUtills.BANK_SUMMARY_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ String.valueOf(noOfRtgsTxns)
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ String.valueOf(totRTGSAmount)
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_SUMMARY_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR;
				// rtgsData += newLine;
				rtgsData += rtgsSummary;
			}
			if (intrData != null && !intrData.equals("")) {
				intrSummary = RWSBankUtills.BANK_SUMMARY_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ String.valueOf(noOfintrTxns)
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ String.valueOf(totINTRAmount)
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR
						+ RWSBankUtills.BANK_SUMMARY_CHAR
						+ RWSBankUtills.BANK_FILE_CHAR;
				// intrData += newLine;
				intrData += intrSummary;
			}
			int resCount[] = stmt.executeBatch();
			if (resCount.length == count) {
				conn.commit();
				conn.setAutoCommit(true);
				createRootDirectories();
				if (neftData != null && !neftData.equals("")) {
					createNEFTFile(neftData, currentDate);
				}
				if (rtgsData != null && !rtgsData.equals("")) {
					createRTGSFile(rtgsData, currentDate);
				}
				if (intrData != null && !intrData.equals("")) {
					createINTRFile(intrData, currentDate);
				}
				request.setAttribute("message", "File Sent Successfully");
				amtTransferBean.getTransfersList().clear();

			}

		} catch (Exception e) {

			request.setAttribute("message", "Failed Transfer.");
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (Exception ee) {
				ee.printStackTrace();
			}

		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
				if (stmt != null) {
					stmt.close();
				}
				if (stmt1 != null) {
					stmt1.close();
				}
				if (stmt2 != null) {
					stmt2.close();
				}
				if (stmt3 != null) {
					stmt3.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (rs1 != null) {
					rs1.close();
				}
				if (rs2 != null) {
					rs2.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	private int getFileNumber(String type, Connection conn) {

		Statement stmt = null;
		ResultSet rs = null;
		int fileNumber = 0;
		try {

			stmt = conn.createStatement();
			String query = "select  nvl(max(file_number),0) from rws_contractor_settlement_tbl where FTX_DATE=sysdate and NEFT_RTGS_INTR ='"
					+ type + "'";

			rs = stmt.executeQuery(query);
			if (rs.next()) {
				fileNumber = rs.getInt(1);
				fileNumber++;
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
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return fileNumber;
	}

	private void createINTRFile(String intrData, String currentDate) {

		boolean createdFlag = true;
		String currentYear = currentDate.substring(6, 10);
		String cuurentMonth = RwsUtils.getCurrentMont();
		String fileCreateDate = RwsUtils.getCurrentDate("dd-MM-yyyy");

		String requestFilePath = RWSBankUtills.BANK_INTR_PATH
				+ File.separatorChar + currentYear + File.separatorChar
				+ cuurentMonth + "-" + currentYear + File.separatorChar
				+ fileCreateDate + File.separatorChar
				+ RWSBankUtills.BANK_REQUEST_FOLDER;
		File intrReqDir = new File(requestFilePath);
		if (!intrReqDir.exists()) {
			createdFlag = intrReqDir.mkdirs();
		}

		// If Request Folder is created then go for Response Folder and other
		// logic
		if (createdFlag) {

			String respFilePath = RWSBankUtills.BANK_INTR_PATH
					+ File.separatorChar + currentYear + File.separatorChar
					+ cuurentMonth + "-" + currentYear + File.separatorChar
					+ fileCreateDate + File.separatorChar
					+ RWSBankUtills.BANK_RESPONSE_FOLDER;
			File neftRespDir = new File(respFilePath);
			if (!neftRespDir.exists()) {
				createdFlag = neftRespDir.mkdirs();
			}

			File[] contents = intrReqDir.listFiles();
			int count = contents.length;
			count++;
			String dcount = "";
			if (count <= 9)
				dcount = "0" + count;
			else
				dcount = Integer.toString(count);

			String fileName = requestFilePath + File.separatorChar + "ANDB"
					+ RWSBankUtills.INTR + RWSBankUtills.RWS_PROGRAM
					+ RwsUtils.getCurrentDate("ddMMyyyy") + "." + dcount;
			System.out.println("INTR data:" + intrData);
			File neftFile = new File(fileName);

			try {
				if (neftFile.createNewFile()) {

					Writer output = new BufferedWriter(new FileWriter(neftFile));
					output.write(intrData);
					output.close();
					updateFileSentStatus(fileName, currentDate, "INTR");

				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	private void updateFileSentStatus(String fileName, String currentDate,
			String type) {
		Connection conn = null;
		Statement stmt = null;
		try {
			conn = RwsOffices.getConn();
			stmt = conn.createStatement();
			int fileNumber = getFileNumber(type, conn);
			String insertQuery = "insert into  rws_bill_sett_send_file_tbl  values( ?,?,sysdate,'N')";
			PreparedStatement ps=conn.prepareStatement(insertQuery);
			ps.setLong(1, fileNumber);
			ps.setString(2, fileName);
			ps.executeUpdate();
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
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	private void createRTGSFile(String rtgsData, String currentDate) {

		boolean createdFlag = true;
		String currentYear = currentDate.substring(6, 10);
		String cuurentMonth = RwsUtils.getCurrentMont();
		String fileCreateDate = RwsUtils.getCurrentDate("dd-MM-yyyy");

		String requestFilePath = RWSBankUtills.BANK_RTGS_PATH
				+ File.separatorChar + currentYear + File.separatorChar
				+ cuurentMonth + "-" + currentYear + File.separatorChar
				+ fileCreateDate + File.separatorChar
				+ RWSBankUtills.BANK_REQUEST_FOLDER;
		File neftReqDir = new File(requestFilePath);
		if (!neftReqDir.exists()) {
			createdFlag = neftReqDir.mkdirs();
		}

		// If Request Folder is created then go for Response Folder and other
		// logic
		if (createdFlag) {

			String respFilePath = RWSBankUtills.BANK_RTGS_PATH
					+ File.separatorChar + currentYear + File.separatorChar
					+ cuurentMonth + "-" + currentYear + File.separatorChar
					+ fileCreateDate + File.separatorChar
					+ RWSBankUtills.BANK_RESPONSE_FOLDER;
			File neftRespDir = new File(respFilePath);
			if (!neftRespDir.exists()) {
				createdFlag = neftRespDir.mkdirs();
			}

			File[] contents = neftReqDir.listFiles();
			int count = contents.length;
			count++;
			String dcount = "";
			if (count <= 9)
				dcount = "0" + count;
			else
				dcount = Integer.toString(count);

			String fileName = requestFilePath + File.separatorChar + "ANDB"
					+ RWSBankUtills.RTGS + RWSBankUtills.RWS_PROGRAM
					+ RwsUtils.getCurrentDate("ddMMyyyy") + "." + dcount;
			System.out.println("rtgsData data:" + rtgsData);
			File neftFile = new File(fileName);

			try {
				if (neftFile.createNewFile()) {

					Writer output = new BufferedWriter(new FileWriter(neftFile));
					output.write(rtgsData);
					output.close();
					updateFileSentStatus(fileName, currentDate, "RTGS");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	private void createRootDirectories() {

		boolean flag = false;

		File andbDIR = new File(RWSBankUtills.BANK_FILES_PATH);

		if (!andbDIR.exists()) {
			flag = andbDIR.mkdir();
		}

		if (flag) {
			File neftDIR = new File(RWSBankUtills.BANK_NEFT_PATH);

			if (!neftDIR.exists()) {
				neftDIR.mkdir();
			}

			File rtgsDIR = new File(RWSBankUtills.BANK_RTGS_PATH);

			if (!rtgsDIR.exists()) {
				rtgsDIR.mkdir();
			}

			File intrDIR = new File(RWSBankUtills.BANK_INTR_PATH);

			if (!intrDIR.exists()) {
				intrDIR.mkdir();
			}

		}
	}

	/**
	 * @author Sai Prasad N Creating NEFT Transaction File for Bank Process
	 * @param neftData
	 * @param currentDate
	 */
	private void createNEFTFile(String neftData, String currentDate) {

		boolean createdFlag = true;
		String currentYear = currentDate.substring(6, 10);
		String cuurentMonth = RwsUtils.getCurrentMont();
		String fileCreateDate = RwsUtils.getCurrentDate("dd-MM-yyyy");

		String requestFilePath = RWSBankUtills.BANK_NEFT_PATH
				+ File.separatorChar + currentYear + File.separatorChar
				+ cuurentMonth + "-" + currentYear + File.separatorChar
				+ fileCreateDate + File.separatorChar
				+ RWSBankUtills.BANK_REQUEST_FOLDER;
		File neftReqDir = new File(requestFilePath);
		if (!neftReqDir.exists()) {
			createdFlag = neftReqDir.mkdirs();
		}

		// If Request Folder is created then go for Response Folder and other
		// logic
		if (createdFlag) {

			String respFilePath = RWSBankUtills.BANK_NEFT_PATH
					+ File.separatorChar + currentYear + File.separatorChar
					+ cuurentMonth + "-" + currentYear + File.separatorChar
					+ fileCreateDate + File.separatorChar
					+ RWSBankUtills.BANK_RESPONSE_FOLDER;
			File neftRespDir = new File(respFilePath);
			if (!neftRespDir.exists()) {
				createdFlag = neftRespDir.mkdirs();
			}

			File[] contents = neftReqDir.listFiles();
			int count = contents.length;
			count++;
			String dcount = "";
			if (count <= 9)
				dcount = "0" + count;
			else
				dcount = Integer.toString(count);

			String fileName = requestFilePath + File.separatorChar + "ANDB"
					+ RWSBankUtills.NEFT + RWSBankUtills.RWS_PROGRAM
					+ RwsUtils.getCurrentDate("ddMMyyyy") + "." + dcount;
			System.out.println("NEFT data:" + neftData);
			File neftFile = new File(fileName);

			try {
				if (neftFile.createNewFile()) {

					Writer output = new BufferedWriter(new FileWriter(neftFile));
					output.write(neftData);
					output.close();
					updateFileSentStatus(fileName, currentDate, "NEFT");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	/**
	 * 
	 * @author RWSS_DPT1
	 * 
	 *         TODO To change the template for this generated type comment go to
	 *         Window - Preferences - Java - Code Style - Code Templates
	 * 
	 *         File Name: BBBBTTTTPPPDDMMYYYY.XX BBBB – First Four Characters of
	 *         the Banks’ IFSC Code. TTTT – Transaction Type. Values: INTR -
	 *         Internal, RTGS, NEFT PPP – Program Name RWS – Rural Water Supply
	 *         DDMMYYYY – Date of file generation at Server XX – Serial Number
	 *         of files of particular File Type generated on that day to that
	 *         Nodal bank. Values – 01, 02, 03 ….99
	 * 
	 *         1 M rem_type char(4)RTGS/NEFT/INTR 2 M ftr_date dd/mm/yyyy 3 M
	 *         ftr_no number(13) 4 M debit_ac_no char(32) 5 M debit_ac_ifsc
	 *         char(11) 6 O benef_mobileno char(12) 7 M tranamt number(16) 8 M
	 *         benef_accno char(32) 9 M benef_name char(80) 10 M benef_address
	 *         char(80) 11 M benef_bankname char(50) 12 M ifsccode char(11) 13 M
	 *         status char(1) O – Open 14 TransDate dd/mm/yyyy blank value 15
	 *         BankRefNo char(20) blank value 16 RejectionLevel char(1) blank
	 *         value 17 Remarks char(240) blank value 18 O benef_email char(50)
	 *         19 O MPDO_email char(50) 20 O No_of_Labour Number 21 M
	 *         Description char(150)
	 */

	/**
	 * TODOs
	 */

	public void responseUpdateDB(File file) {
		Connection conn = null;
		Statement stmt = null;

		try {
			conn = RwsOffices.getConn();

			if (conn != null) {

				conn.setAutoCommit(false);

				stmt = conn.createStatement();

				BufferedReader br = new BufferedReader(new FileReader(file));
				String line = "";
				while ((line = br.readLine()) != null) {
					String val[] = splitTotokens(line, "^");
					if (val != null && val.length > 1) {

						if (!val[0].equals("T")) {
							String ftrNo = val[2]; // File Transaction Number
							String status = val[12]; // File Updation
							// Status(O,A,P, Etc...)
							String fileProcessedDate = val[13]; // File
							// Processed
							// Date at Bank
							String bankRefNo = val[14]; // Bank Reference
							// Number(Like UTR No
							// For NEFT Transactions
							// etc....)
							String rejectionLevel = val[15]; // Bank Rejection
							// Level
							String remarks = val[16]; // Remarks

							String updateDBQuery = "update RWS_CONTRACTOR_SETTLEMENT_TBL set TX_STATUS='"
									+ status
									+ "',BANK_TX_DATE=to_date('"
									+ fileProcessedDate
									+ "','dd/MM/yyyy'),BANK_REF_NO='"
									+ bankRefNo
									+ "',REJECTION_LEVEL='"
									+ rejectionLevel
									+ "',REMARKS='"
									+ remarks
									+ "' where TXID_CONTRACTOR='" + ftrNo + "'";
							// System.out.println("Updating...." +
							// updateDBQuery);
							stmt.addBatch(updateDBQuery);

							// TODOS

							if (status != null && !status.equals("O")) {
								String updateBankDet = "update rws_bill_bank_bridge_det_tbl set BILL_ACTIVATION_FLAG='"
										+ status
										+ "' where TXID='"
										+ ftrNo
										+ "'";
								stmt.addBatch(updateBankDet);

								String updatebankBridge = "update rws_bill_bank_bridge_tbl set BILL_ACTIVATION_FLAG='"
										+ status
										+ "' where TXID='"
										+ ftrNo
										+ "'";
								stmt.addBatch(updatebankBridge);

							}

						}
					}

					int res[] = stmt.executeBatch();
					if (res.length > 0) {
						conn.setAutoCommit(true);
						conn.commit();
						// file.delete();
					}
					// System.out.println("val length:" + val[12]);

				}
				br.close();
			} // conn close
		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	public static void main(String[] args) {

		String value = "2013000000001";
		long lvalue = Long.parseLong(value.substring(4, 13));
		int i = 0;
		while (i < 10) {
			System.out.println("Lvalue:" + lvalue);
			lvalue++;
			i++;
		}

	}

	public static String[] splitTotokens(String line, String delim) {
		String s = line;
		int i = 0;

		while (s.contains(delim)) {
			s = s.substring(s.indexOf(delim) + delim.length());
			i++;
		}
		String token = null;
		String remainder = null;
		String[] tokens = new String[i];

		for (int j = 0; j < i; j++) {
			token = line.substring(0, line.indexOf(delim));
			// System.out.print("#" + token + "#");
			tokens[j] = token;
			remainder = line.substring(line.indexOf(delim) + delim.length());
			// System.out.println("#" + remainder + "#");

			line = remainder;
		}
		return tokens;
	}

	public boolean isAudhorizetoProcessBill(
			RwsContractorAmtTransferBean amtTransferBean,
			HttpServletRequest request) {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		conn = RwsOffices.getConn();
		try {
			stmt = conn.createStatement();

			String query = "select certificate from rws_enc_ds_reg_tbl where OFFICER_DESIGNATION='ENC'";

			rs = stmt.executeQuery(query);
			if (rs.next()) {
				String certificate = rs.getString(1);
				if (certificate != null
						&& certificate.equals(amtTransferBean.getCertificate())) {

					RwsDigitalSignatureToken rwsToken = new RwsDigitalSignatureToken();
					RwsUtils.prepareX509Certificate(amtTransferBean
							.getCertificate(), rwsToken);
					amtTransferBean.setTokenSLNO(rwsToken.getSerialNumber()
							.toString());

					request
							.setAttribute("message",
									"Audhendication Success.Now you can Process the bills.");
					return true;
				} else {
					request.setAttribute("message", "Audhendication Failed.");
					return false;
				}

			} else {
				request.setAttribute("message", "ENC Not Yet Register.");
				return false;
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

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return false;
	}

	/**
	 * 
	 * @return
	 */

	public ArrayList getSourcebankDetails() {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		conn = RwsOffices.getConn();
		ArrayList bankDetails = new ArrayList();

		try {
			stmt = conn.createStatement();

			String query = "select IFSC_CODE ,NAME ,ACCOUNT_NUMBER  from RWS_REMITTER_TBL";

			rs = stmt.executeQuery(query);
			while (rs.next()) {

				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setLabel(rs.getString(1) + "-" + rs.getString(2)
						+ "-" + rs.getString(3));
				bankDetails.add(labelValueBean);

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

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return bankDetails;
	}

	public String getTolAvailableGrant() {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		conn = RwsOffices.getConn();
		String grant = "0";
		try {
			stmt = conn.createStatement();

			String query = "select AMOUNT from RWS_BANK_GRANT_AMT_TBL";

			rs = stmt.executeQuery(query);
			if (rs.next()) {

				grant = rs.getString(1);
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

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return grant;
	}
}