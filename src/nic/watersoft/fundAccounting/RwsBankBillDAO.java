package nic.watersoft.fundAccounting;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Hashtable;
import javax.servlet.http.HttpServletRequest;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;
import java.io.File;
import org.apache.struts.action.ActionServlet;
public class RwsBankBillDAO {
	public ArrayList<RwsBankBillRecord> getUnSelectedBillsList(String circleCode, RwsBankBillActionForm rwsBankBillActionForm, ActionServlet actionServlet) {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<RwsBankBillRecord> billsList = new ArrayList<RwsBankBillRecord>();
		Hashtable billAmountCentralHash = new Hashtable();
		Hashtable tempTableHash = new Hashtable();
		Hashtable bankTempHash = new Hashtable();
		//Hashtable<String, String> employeeHash = new Hashtable<String, String>();

		NumberFormat formatter = new DecimalFormat("#0.00");
		try {

			conn = RwsOffices.getConn();
	
			rwsBankBillActionForm.setSoFarProcessAmount("0.0");
			rwsBankBillActionForm.setSelectedBillCount("0");

			String dquery = "", dquery1 = "";
			if (circleCode != null && !circleCode.equals("00") && rwsBankBillActionForm.getDivCode() != null
					&& !rwsBankBillActionForm.getDivCode().equals("00")) {

				dquery = "  and  substr(b.office_code,2,2)='" + circleCode + "' and  substr(b.office_code,4,1)='"
						+ rwsBankBillActionForm.getDivCode() + "' and to_char(a.BILL_DATE,'yyyy')='"
						+ rwsBankBillActionForm.getYearCode() + "'and to_char(a.BILL_DATE,'mm')='"
						+ rwsBankBillActionForm.getMonthCode() + "'";

				dquery1 = "  where  substr(a.work_id,5,2)='" + circleCode + "'";
			}

			//loadEmployeeData(employeeHash, conn);
			loadProcessedAmount(billAmountCentralHash, conn, dquery1);

			loadTempRecords(tempTableHash, conn, dquery1, rwsBankBillActionForm);

			loadBankTempRecords(bankTempHash, conn, dquery1, rwsBankBillActionForm);


			String billsQuery = "select circle_office_name,division_office_name,b.work_id,work_name,admin_no,to_char (admin_date,'dd/mm/yyyy'),sanction_amount*100000 as samtt,programme_name,subprogramme_name,bill_no,to_char (bill_date,'dd/mm/yyyy'),bill_amt_contractor,bill_amt_admissible,(nvl(STATE_SHARE,0)*bill_amt_admissible)/100,(nvl(CENTRAL_SHARE,0)*bill_amt_admissible)/100,p.programme_code,nvl(STATE_SHARE,0)STATE_SHARE,nvl(CENTRAL_SHARE,0)CENTRAL_SHARE,bill_sl_no,'1'||d.circle_office_code||sd.division_office_code||'00' office_code,d.circle_office_code,sd.division_office_code,to_char (a.update_date,'dd/mm/yyyy') as update_date,nvl(to_char(EE_FWD_DATE,'dd/mm/yyyy'),'') as EE_FWD_DATE ,BILL_SL_NO  as billSLNO,nvl(CM_BY_DEE,'-') as CM_BY_DEE,nvl(CM_MBOOK_PG_NO,'-') as CM_MBOOK_PG_NO ,nvl(to_char(CM_DT,'dd/mm/yyyy'),'') as CM_DT,nvl(SCM_BY_EE,'-') as SCM_BY_EE ,nvl(SCM_MBOOK_PG_NO,'-') as SCM_MBOOK_PG_NO,nvl(to_char(SCM_DT,'dd/mm/yyyy'),'') as SCM_DT,nvl(SCM_BY_SE,'-') as SCM_BY_SE,nvl(SCM_SE_MBOOK_PG_NO,'-') as SCM_SE_MBOOK_PG_NO,nvl(to_char(SCM_SE_DT,'dd/mm/yyyy'),'') as SCM_SE_DT,length(PASS_ORDER_SCAN_COPY) as pCopy,BMS_TR_NO,b.SANCTION_AMOUNT as estCost,b.NO_OF_HABS,b.SUBPROGRAMME_CODE from rws_work_bill_tbl a,rws_programme_tbl p,rws_subprogramme_tbl sp,rws_circle_office_tbl d,rws_division_office_tbl sd,rws_work_admn_tbl b  where substr(b.office_code,2,2) =d.circle_office_code and d.circle_office_code=sd.circle_office_code and substr(b.office_code,2,2) =sd.circle_office_code and substr (b.office_code,4,1)=sd.division_office_code and b.programme_code=p.programme_code and p.programme_code=sp.programme_code and b.programme_code=sp.programme_code and b.subprogramme_code=sp.subprogramme_code and a.work_id=b.work_id and bill_sl_no<>0 "
					+ dquery
					+ " and p.central_share > 0  and b.block_payment<>'Y' order by to_date(EE_FWD_DATE,'dd/mm/yyyy') desc";
			stmt = conn.prepareStatement(billsQuery);
			rs = stmt.executeQuery();
			double billAmt = 0;
			int billCount = 0;
			while (rs.next()) {

				boolean flag = false, paoFlag = false;

				String val = "" + billAmountCentralHash.get(rs.getString("work_id") + rs.getString("bill_sl_no"));
				if (val != null && !val.equals("null")) {
				} else {
					val = "0@0";
				}
				String[] vals = val.split("@");

				double amtAdmissible = Double.parseDouble(rs.getString(13));
				//double centralPer = rs.getDouble("CENTRAL_SHARE");
				double remainAmount = amtAdmissible - (Double.parseDouble(vals[0]) + Double.parseDouble(vals[1]));

//				double statePaid = Double.parseDouble(vals[0]);
//				double centralPaid = Double.parseDouble(vals[1]);

				//double dueCentralAmount = (centralPer / 100) * remainAmount;

				if (remainAmount > 0) {
					flag = true;
				}

				if (bankTempHash.get(rs.getString("work_id") + rs.getString("bill_sl_no")) != null) {
					paoFlag = true;

				}
				if (flag) {

					RwsBankBillRecord record = new RwsBankBillRecord();

					if (paoFlag) {
						record.setPaoFlag("Y");
					} else {
						record.setPaoFlag("N");
					}
					
				
//					record.setOffieCode(rs.getString("office_code"));
//					record.setBillSlNo(rs.getString("bill_sl_no"));
//					String state = "" + Double.parseDouble(vals[0]);
//
					String central = "" + Double.parseDouble(vals[1]);

					record.setDivName(rs.getString(2));
					record.setWorkId(rs.getString(3));
					record.setWorkName(rs.getString(4));
					record.setSubProgramCode(rs.getString("SUBPROGRAMME_CODE"));
//					record.setSanctionAmount(rs.getString(7));
//					record.setPrograme(rs.getString(8));
//					record.setSubPrograme(rs.getString(9));
					record.setBillNo(rs.getString(10));
					record.setBillDate(rs.getString(11));
//					record.setBillAmtContractor(rs.getString(12));
					
					record.setBillSlNo(rs.getString("billSLNO"));
//
//					record.setDueActual(formatter.format(remainAmount));
//					record.setDueGOI(formatter.format(dueCentralAmount));
//
//					record.setPaidActual(formatter.format(Math.ceil(statePaid) + centralPaid));
//
//					record.setPaidState(formatter.format(statePaid));
//					record.setPaidGOI(formatter.format(centralPaid));
//
//					record.setRecomandedActual(formatter.format(remainAmount));
					//System.out.println("est Cost :"+rs.getString("estCost"));
					record.setEstCost(rs.getString("estCost"));

					String val1 = (String) tempTableHash.get(rs.getString("work_id") + rs.getString("bill_sl_no"));

					if (val1 != null && !val1.equals("null")) {
						String val1s[] = val1.split("@");
						if (Double.parseDouble(val1s[0]) > remainAmount) {
							record.setRecordStatus("Error");
						} else {

							record.setRecordStatus("NOError");
						}
						paoFlag = true;
						record.setChecks("on");
					} else {
						record.setRecordStatus("NOError");
//						if (centralPer > 0) {
//							record.setRecomandedStatePer(String.valueOf(rs.getString("CENTRAL_SHARE")));
//							record.setRecomandedGOI(formatter.format(dueCentralAmount));
//						}
						
					//	record.setbmsno(rs.getString("BMS_TR_NO"));
					}
					record.setEeFwdDate(rs.getString("EE_FWD_DATE") == null ? "-" : rs.getString("EE_FWD_DATE"));
					record.setBillEnterDate(rs.getString("update_date"));
					record.setNoOfHabs(rs.getString("NO_OF_HABS"));
					record.setBillAmtAdmissible(rs.getString(13));
					if(!paoFlag ){
						billsList.add(record);
					}
					
				}

			}

		} catch (Exception e) {
			System.out.println("Exception in getbillsList of RwsBankBillDAO-- " + e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in getbillsList of RwsBankBillDAO-- " + e);
			}
		}

		return billsList;
	}

	public ArrayList<RwsBankBillRecord> getBillsList(String circleCode, RwsBankBillActionForm rwsBankBillActionForm, ActionServlet actionServlet) {

		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		ArrayList<RwsBankBillRecord> billsList = new ArrayList<RwsBankBillRecord>();
		Hashtable billAmountCentralHash = new Hashtable();
		Hashtable tempTableHash = new Hashtable();
		Hashtable bankTempHash = new Hashtable();
		Hashtable<String, String> employeeHash = new Hashtable<String, String>();

		NumberFormat formatter = new DecimalFormat("#0.00");
		try {

			conn = RwsOffices.getConn();
	
			rwsBankBillActionForm.setSoFarProcessAmount("0.0");
			rwsBankBillActionForm.setSelectedBillCount("0");

			String dquery = "", dquery1 = "";
			if (circleCode != null && !circleCode.equals("00") && rwsBankBillActionForm.getDivCode() != null
					&& !rwsBankBillActionForm.getDivCode().equals("00")) {

				dquery = "  and  substr(b.office_code,2,2)='" + circleCode + "' and  substr(b.office_code,4,1)='"
						+ rwsBankBillActionForm.getDivCode() + "' and to_char(a.BILL_DATE,'yyyy')='"
						+ rwsBankBillActionForm.getYearCode() + "'and to_char(a.BILL_DATE,'mm')='"
						+ rwsBankBillActionForm.getMonthCode() + "'";

				dquery1 = "  where  substr(a.work_id,5,2)='" + circleCode + "'";
			}

			loadEmployeeData(employeeHash, conn);
			loadProcessedAmount(billAmountCentralHash, conn, dquery1);

			loadTempRecords(tempTableHash, conn, dquery1, rwsBankBillActionForm);

			loadBankTempRecords(bankTempHash, conn, dquery1, rwsBankBillActionForm);


			String billsQuery = "select circle_office_name,division_office_name,b.work_id,work_name,admin_no,to_char (admin_date,'dd/mm/yyyy'),sanction_amount*100000 as samtt,programme_name,subprogramme_name,bill_no,to_char (bill_date,'dd/mm/yyyy'),bill_amt_contractor,bill_amt_admissible,(nvl(STATE_SHARE,0)*bill_amt_admissible)/100,(nvl(CENTRAL_SHARE,0)*bill_amt_admissible)/100,p.programme_code,nvl(STATE_SHARE,0)STATE_SHARE,nvl(CENTRAL_SHARE,0)CENTRAL_SHARE,bill_sl_no,'1'||d.circle_office_code||sd.division_office_code||'00' office_code,d.circle_office_code,sd.division_office_code,to_char (a.update_date,'dd/mm/yyyy') as update_date,nvl(to_char(EE_FWD_DATE,'dd/mm/yyyy'),'') as EE_FWD_DATE ,BILL_SL_NO  as billSLNO,nvl(CM_BY_DEE,'-') as CM_BY_DEE,nvl(CM_MBOOK_PG_NO,'-') as CM_MBOOK_PG_NO ,nvl(to_char(CM_DT,'dd/mm/yyyy'),'') as CM_DT,nvl(SCM_BY_EE,'-') as SCM_BY_EE ,nvl(SCM_MBOOK_PG_NO,'-') as SCM_MBOOK_PG_NO,nvl(to_char(SCM_DT,'dd/mm/yyyy'),'') as SCM_DT,nvl(SCM_BY_SE,'-') as SCM_BY_SE,nvl(SCM_SE_MBOOK_PG_NO,'-') as SCM_SE_MBOOK_PG_NO,nvl(to_char(SCM_SE_DT,'dd/mm/yyyy'),'') as SCM_SE_DT,length(PASS_ORDER_SCAN_COPY) as pCopy,BMS_TR_NO  from rws_work_bill_tbl a,rws_programme_tbl p,rws_subprogramme_tbl sp,rws_circle_office_tbl d,rws_division_office_tbl sd,rws_work_admn_tbl b  where substr(b.office_code,2,2) =d.circle_office_code and d.circle_office_code=sd.circle_office_code and substr(b.office_code,2,2) =sd.circle_office_code and substr (b.office_code,4,1)=sd.division_office_code and b.programme_code=p.programme_code and p.programme_code=sp.programme_code and b.programme_code=sp.programme_code and b.subprogramme_code=sp.subprogramme_code and a.work_id=b.work_id and bill_sl_no<>0 "
					+ dquery
					+ " and p.central_share > 0  and b.block_payment<>'Y' order by to_date(EE_FWD_DATE,'dd/mm/yyyy') desc";
			stmt = conn.prepareStatement(billsQuery);
			rs = stmt.executeQuery();
			double billAmt = 0;
			int billCount = 0;
			while (rs.next()) {

				boolean flag = false, paoFlag = false;

				String val = "" + billAmountCentralHash.get(rs.getString("work_id") + rs.getString("bill_sl_no"));
				if (val != null && !val.equals("null")) {
				} else {
					val = "0@0";
				}
				String[] vals = val.split("@");

				double amtAdmissible = Double.parseDouble(rs.getString(13));
				double centralPer = rs.getDouble("CENTRAL_SHARE");
				double remainAmount = amtAdmissible - (Double.parseDouble(vals[0]) + Double.parseDouble(vals[1]));

				double statePaid = Double.parseDouble(vals[0]);
				double centralPaid = Double.parseDouble(vals[1]);

				double dueCentralAmount = (centralPer / 100) * remainAmount;

				if (remainAmount > 0) {
					flag = true;
				}

				if (bankTempHash.get(rs.getString("work_id") + rs.getString("bill_sl_no")) != null) {
					paoFlag = true;

				}
				if (flag) {

					RwsBankBillRecord record = new RwsBankBillRecord();

					if (paoFlag) {
						record.setPaoFlag("Y");
					} else {
						record.setPaoFlag("N");
					}

					String img_qry = "select WORK_IMAGE from RWS_WORK_IMAGE_TBL where work_id=? ";
					PreparedStatement stmt1 = conn.prepareStatement(img_qry);
					stmt1.setString(1,  rs.getString("work_id"));
					ResultSet rs1 = stmt1.executeQuery();
					if (rs1.next()) {
						java.sql.Blob b = rs1.getBlob("WORK_IMAGE");
						if (b == null)
							record.setWork_img("No");
						else
							record.setWork_img("Yes");
					} else {
						record.setWork_img("No");
					}
					rs1.close();
					stmt1.close();
					
					//String imagePath=servlet.getServletContext().getRealPath("/")+"PrivateSourceImages"; 
					String imagePath=actionServlet.getServletContext().getRealPath("/") ;
					 if(imagePath != null && !imagePath.isEmpty() && imagePath.contains(File.separator+"webapps"+File.separator)){
						 String sample[]  = imagePath.split( File.separator+"webapps"+File.separator);
						 //System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
						 imagePath = sample[0];
						 ////System.out.println("server split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
					 }else{
						 String sample[]  = imagePath.split( "webapps");
						// System.out.println("split 1 :"+sample[0]+" split 2 :"+sample[1]);
						 imagePath = sample[0];
						//// System.out.println(" local split 1 :"+sample[0]+" split 2 :"+sample[1]+" imagePath:"+imagePath);
					 }
					 imagePath = imagePath+ File.separator+"PassorderScanCopys";
					File myFilesDir = new File(imagePath);
					if (!myFilesDir.exists())
						myFilesDir.mkdirs();
					imagePath = imagePath + File.separator ;
					File filepath = new File(imagePath);
					//pstmt.setString(15, workId);
					//pstmt.setString(16,tenderMemoBean.getBillSlNo());
					//String billdates=tenderMemoBean.getBillDate().replace("/", "-");
					//				System.out.println("@@@@@@@@@@@@@"+rs.getString(11).replace("/", "-")+"$$$$"+rs.getString("work_id")+"#######"+rs.getString("bill_sl_no"));

					File filepathisExits = new File(filepath+File.separator+rs.getString("work_id")+"_"+rs.getString(11).replace("/", "-")+"_"+rs.getString("bill_sl_no")+".jpg");
					if(filepathisExits.getAbsoluteFile().exists()){
						//System.out.println("YYYYYYYYYYYYYYYY");
						record.setPassOrderScanCopyAvailable("Yes");	
					}
					else
					{
						//System.out.println("NNNNNNNNNNN");
						record.setPassOrderScanCopyAvailable("No");
					}
					
					
					
					
					
					
					
					
					
					
					record.setCheckMeasuredByDEE(
							employeeHash.get(rs.getString("CM_BY_DEE") != null ? rs.getString("CM_BY_DEE") : ""));
					record.setCheckMeasuredDateDEE(rs.getString("CM_DT"));
					record.setMbookNoDEE(rs.getString("CM_MBOOK_PG_NO"));

					record.setCheckMeasuredByEE(
							employeeHash.get(rs.getString("SCM_BY_EE") != null ? rs.getString("SCM_BY_EE") : ""));
					record.setCheckMeasuredDateEE(rs.getString("SCM_DT"));
					record.setMbookNoEE(rs.getString("SCM_MBOOK_PG_NO"));

					record.setCheckMeasuredBySE(
							employeeHash.get(rs.getString("SCM_BY_SE") != null ? rs.getString("SCM_BY_SE") : ""));
					record.setCheckMeasuredDateSE(rs.getString("SCM_SE_DT"));
					record.setMbookNoSE(rs.getString("SCM_SE_MBOOK_PG_NO"));

					record.setOffieCode(rs.getString("office_code"));
					record.setBillSlNo(rs.getString("bill_sl_no"));
					String state = "" + Double.parseDouble(vals[0]);

					String central = "" + Double.parseDouble(vals[1]);

					record.setDivName(rs.getString(2));
					record.setWorkId(rs.getString(3));
					record.setWorkName(rs.getString(4));
					record.setSanctionAmount(rs.getString(7));
					record.setPrograme(rs.getString(8));
					record.setSubPrograme(rs.getString(9));
					record.setBillNo(rs.getString(10));
					record.setBillDate(rs.getString(11));
					record.setBillAmtContractor(rs.getString(12));
					record.setBillAmtAdmissible(rs.getString(13));
					record.setBillSlNo(rs.getString("billSLNO"));

					record.setDueActual(formatter.format(remainAmount));
					record.setDueGOI(formatter.format(dueCentralAmount));

					record.setPaidActual(formatter.format(Math.ceil(statePaid) + centralPaid));

					record.setPaidState(formatter.format(statePaid));
					record.setPaidGOI(formatter.format(centralPaid));

					record.setRecomandedActual(formatter.format(remainAmount));

					String val1 = (String) tempTableHash.get(rs.getString("work_id") + rs.getString("bill_sl_no"));

					if (val1 != null && !val1.equals("null")) {
						String val1s[] = val1.split("@");
						double percentage = ((Double.parseDouble(val1s[0]) / (remainAmount)) * 100);

						record.setRecomandedStatePer(String.valueOf(percentage));
						record.setRecomandedGOI(formatter.format(Double.parseDouble(val1s[0])));

						billCount++;
						billAmt += Double.parseDouble(val1s[0]);

						rwsBankBillActionForm.setSoFarProcessAmount(String.valueOf(formatter.format(billAmt)));
						rwsBankBillActionForm.setSelectedBillCount(String.valueOf(billCount));

						if (Double.parseDouble(val1s[0]) > remainAmount) {
							record.setRecordStatus("Error");
						} else {

							record.setRecordStatus("NOError");
						}

						record.setChecks("on");
					} else {
						record.setRecordStatus("NOError");
						if (centralPer > 0) {
							record.setRecomandedStatePer(String.valueOf(rs.getString("CENTRAL_SHARE")));
							record.setRecomandedGOI(formatter.format(dueCentralAmount));
						}

					}

					record.setEeFwdDate(rs.getString("EE_FWD_DATE") == null ? "-" : rs.getString("EE_FWD_DATE"));
					record.setBillEnterDate(rs.getString("update_date"));
					record.setbmsno(rs.getString("BMS_TR_NO"));
					billsList.add(record);
				}

			}

		} catch (Exception e) {
			System.out.println("Exception in getbillsList of RwsBankBillDAO-- " + e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in getbillsList of RwsBankBillDAO-- " + e);
			}
		}

		return billsList;
	}


	private void loadEmployeeData(Hashtable<String, String> employeeHash, Connection conn) {
		try {
			Statement stmtN = conn.createStatement();
			String queryEmp = "select EMPLOYEE_CODE,EMPLOYEE_NAME,EMPLOYEE_SURNAME from rws_employee_tbl";
			ResultSet rsN = stmtN.executeQuery(queryEmp);
			while (rsN.next()) {
				employeeHash.put(rsN.getString(1), rsN.getString(2) + "  " + rsN.getString(3));
			}
			if (stmtN != null) {
				stmtN.close();
			}
			if (rsN != null) {
				rsN.close();
			}
		} catch (Exception e) {
			System.out.println("Exception in loadEmployeeData of RwsBankBillDAO-- " + e);
		}

	}



	private void loadBankTempRecords(Hashtable bankTempHash, Connection conn, String dquery1,
			RwsBankBillActionForm RwsBankBillActionForm) {

		try {
			PreparedStatement paoTemStmt = null;
			String paoTempQuery = "select WORK_ID ,BILL_SL_NO,BILL_AMOUT_STATE   from rws_bill_pao_bridge_temp_tbl "
					+ "where substr(office_code,2,2)=? and substr(office_code,4,1)=? ";
			
			paoTemStmt = conn.prepareStatement(paoTempQuery);
			paoTemStmt.setString(1, RwsBankBillActionForm.getCircleCode()  );
			paoTemStmt.setString(2,RwsBankBillActionForm.getDivCode() );

			ResultSet rsN = paoTemStmt.executeQuery();

			while (rsN.next()) {
				bankTempHash.put(rsN.getString(1) + rsN.getString(2), rsN.getString(3));

			}
			if (paoTemStmt != null) {
				paoTemStmt.close();
			}
			if (rsN != null) {
				rsN.close();
			}
		} catch (Exception e) {
			System.out.println("Exception in loadBankTempRecords of RwsBankBillDAO-- " + e);
		}

	}
	
	
	private void loadTempRecords(Hashtable tempTableHash, Connection conn, String dquery,
			RwsBankBillActionForm RwsBankBillActionForm) {

		int billCount = 0;
		double billAmt = 0;

		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			

			String q1 = "select work_id,bill_sl_no,bill_amount_central,bill_amout_state from rws_bill_bank_bridge_temp_tbl a "
					+ dquery + "";
			stmt = conn.prepareStatement(q1);
			rs = stmt.executeQuery();

			while (rs.next()) {
				tempTableHash.put(rs.getString(1) + rs.getString(2), rs.getString(3) + "@" + rs.getString(4));

			}

		} catch (Exception e) {
			System.out.println("Exception in loadTempRecords of RwsBankBillDAO-- " + e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in loadTempRecords of RwsBankBillDAO-- " + e);
			}
		}
	}


	
	private void loadProcessedAmount(Hashtable billAmountCentralHash, Connection conn, String dquery) {

		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			

			String q1 = "select work_id,bill_sl_no,nvl(sum(bill_amout_state),0),nvl(sum(bill_amount_central),0) from rws_bill_bank_bridge_tbl a "
					+ dquery + " group by work_id,bill_sl_no order by work_id desc";
			stmt = conn.prepareStatement(q1);
			rs = stmt.executeQuery();

			while (rs.next()) {
				billAmountCentralHash.put(rs.getString(1) + rs.getString(2), rs.getString(3) + "@" + rs.getString(4));
			}

		} catch (Exception e) {
			System.out.println("Exception in loadProcessedAmount of RwsBankBillDAO-- " + e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				System.out.println("Exception in loadProcessedAmount of RwsBankBillDAO-- " + e);
			}
		}
	}


	public void saveBills(RwsBankBillActionForm RwsBankBillActionForm, HttpServletRequest request) {

		PreparedStatement pstmt = null, pstmt1 = null, pstmt2 = null;
		Connection conn = null;

		try {
			conn = RwsOffices.getConn();
			conn.setAutoCommit(false);

			ArrayList selectedList = new ArrayList();
			if (request.getParameter("selectedRecords") != null) {
				String selectedRecords = request.getParameter("selectedRecords");
				if (selectedRecords.length() > 14) {
													
					selectedRecords = selectedRecords.substring(0, selectedRecords.length() - 1);
					String val[] = selectedRecords.split("@");
					for (int j = 0; j < val.length; j++) {
						selectedList.add(val[j]);
					}
				}

			}
			//System.out.println("selected List :"+selectedList.size());
			String deleteTempQuery = "delete from rws_bill_bank_bridge_temp_tbl where work_id=? and BILL_SL_NO=?";
			pstmt = conn.prepareStatement(deleteTempQuery);

			String insertQuery = "insert into rws_bill_bank_bridge_temp_tbl values(?,?,?,?,?,sysdate,'I')";
	
			pstmt1 = conn.prepareStatement(insertQuery);
		

			int totRecCount = 0;
			for (RwsBankBillRecord a : RwsBankBillActionForm.getBillsList()) {

				pstmt.setString(1, a.getWorkId());
				pstmt.setString(2, a.getBillSlNo());
				totRecCount += pstmt.executeUpdate();

				if (selectedList.contains(a.getWorkId() + a.getBillSlNo())) {
			//	if(a.getChecks() != null && a.getChecks().equalsIgnoreCase("on")){
					pstmt1.setString(1, a.getWorkId());
					pstmt1.setString(2, a.getOffieCode());
					pstmt1.setString(3, a.getBillSlNo());
					pstmt1.setString(4, "0");
					pstmt1.setString(5, a.getRecomandedGOI());
					pstmt1.addBatch();

				

				}

			}
			int updatedRecCount[] = pstmt1.executeBatch();
	
			if (updatedRecCount.length > 0 || totRecCount > 0) {
				request.setAttribute("message", "Records are Inserted Succesfully");
				conn.commit();
			} else {
				request.setAttribute("message", "Updation Failed.");
			}

		} catch (Exception e) {
			try {
				conn.rollback();
				conn.setAutoCommit(true);
			} catch (SQLException e1) {
				System.out.println("SQLException in saveBills of RwsBankBillDAO-- " + e1);
			}
			System.out.println("Exception in saveBills of RwsBankBillDAO-- " + e);
			e.printStackTrace();
		} finally {
			try {
				conn.setAutoCommit(true);
				if (pstmt != null) {
					pstmt.close();
				}
				if (conn != null) {
					conn.close();
				}

			} catch (Exception e) {
				System.out.println("Exception in saveBills of RwsBankBillDAO 123-- " + e);
				e.printStackTrace();

			}
		}

	}

	
	public ArrayList<LabelValueBean> getYears(RwsBankBillActionForm RwsBankBillActionForm) {

		PreparedStatement stmt = null;
		ResultSet rs = null;
		Connection conn = null;
		ArrayList<LabelValueBean> yearsList = new ArrayList<LabelValueBean>();
		try {
			conn = RwsOffices.getConn();

			String q1 = "select distinct to_char(BILL_DATE,'yyyy') from rws_work_bill_tbl  where to_char(BILL_DATE,'yyyy')  >= 2011 and "
					+ "to_char(BILL_DATE,'yyyy') <>'2080'  order by 1 desc";

			stmt = conn.prepareStatement(q1);
			rs = stmt.executeQuery();

			while (rs.next()) {
				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs.getString(1));
				labelValueBean.setLabel(rs.getString(1));
				labelValueBean.setLabelValue(rs.getString(1) + " - " + rs.getString(1));
				yearsList.add(labelValueBean);
			}

		} catch (Exception e) {
			System.out.println("Exception in getYears RwsBankBillDAO-- " + e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {

			}
		}
		return yearsList;

	}


	public ArrayList<LabelValueBean> getMonths(RwsBankBillActionForm RwsBankBillActionForm) {

		PreparedStatement stmt = null;
		ResultSet rs = null;
		Connection conn = null;
		ArrayList<LabelValueBean> monthsList = new ArrayList<LabelValueBean>();
		try {
			conn = RwsOffices.getConn();

			String q1 = "select distinct upper(to_char(BILL_DATE,'mon')),upper(to_char(BILL_DATE,'mm'))  from rws_work_bill_tbl  order by 2";
			stmt = conn.prepareStatement(q1);
			rs = stmt.executeQuery();

			while (rs.next()) {
				LabelValueBean labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rs.getString(2));
				labelValueBean.setLabel(rs.getString(1));
				labelValueBean.setLabelValue(rs.getString(1) + " - " + rs.getString(2));
				monthsList.add(labelValueBean);
			}

		} catch (Exception e) {
			System.out.println("Exception in getMonths RwsBankBillDAO-- " + e);
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
				if (rs != null) {
					rs.close();
				}
			} catch (Exception e) {

			}
		}
		return monthsList;

	}
}
