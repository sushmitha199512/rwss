package nic.watersoft.works;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.DAOMessage;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_works_WorkStatus_Act extends Action {

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		System.gc();
		DataSource ds = null;
		ArrayList circles = null;
		ArrayList divisions = null;
		ArrayList subdivs = null;
		ArrayList programmes = null;
		ArrayList subprogrammes = null;
		ArrayList workCategory = null;
		ArrayList assettypes = null;
		boolean mb = false;
		Runtime s_runtime = Runtime.getRuntime();
		long Used_memory = s_runtime.totalMemory() - s_runtime.freeMemory();
		System.gc();
		String SUCCESS = "success";
		Used_memory = s_runtime.totalMemory() - s_runtime.freeMemory();
		System.gc();
		HttpSession session = request.getSession();
		RwsUser user = null;
		user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || user.getUserId().equals(Constants.EE_BUDGET) || Constants.IsUser(user.getUserId()) || Constants.IsEEUser(user.getUserId()) || Constants.IsAOUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");	
		}
		String headOfficeCode = user.getHeadOfficeCode();
		rws_works_WorkStatus_form fb = (rws_works_WorkStatus_form) form;
		fb.setPreparedBy(user.getUserId());
		fb.setOfficeCode(user.getOfficeCode());
		rws_works_WorkStatus_bean bean = null;
		WorksDAO dao = null;
		try {

			RwsOffices offices = new RwsOffices();
			String mode = fb.getMode();
			String nmode = fb.getNmode();
			String workStage = fb.getWorkStage();

			String months = offices.getMonthFromDual();
			String monthsNo = "";

			if (months.equals("APR")) {
				months = "APRIL";
				monthsNo = "1";
			}
			if (months.equals("MAY")) {
				months = "MAY";
				monthsNo = "2";
			}
			if (months.equals("JUN")) {
				months = "JUNE";
				monthsNo = "3";
			}
			if (months.equals("JUL")) {
				months = "JULY";
				monthsNo = "4";
			}
			if (months.equals("AUG")) {
				months = "AUGUST";
				monthsNo = "5";
			}
			if (months.equals("SEP")) {
				months = "SEPTEMBER";
				monthsNo = "6";
			}
			if (months.equals("OCT")) {
				months = "OCTOBER";
				monthsNo = "7";
			}
			if (months.equals("NOV")) {
				months = "NOVEMBER";
				monthsNo = "8";
			}
			if (months.equals("DEC")) {
				months = "DECEMBER";
				monthsNo = "9";
			}
			if (months.equals("JAN")) {
				months = "JANUARY";
				monthsNo = "10";
			}
			if (months.equals("FEB")) {
				months = "FEBRUARY";
				monthsNo = "11";
			}
			if (months.equals("MAR")) {
				months = "MARCH";
				monthsNo = "12";
			}

			request.setAttribute("month", months);
			request.setAttribute("monthNo", monthsNo);

			if (mode.equals("insContract")) {
				ArrayList contractor = offices.getContractorList();
				session.setAttribute("contractors", contractor);

				fb.setConName(request.getParameter("conCode"));

			}
			if (mode.equals("saveBills")) {
				String storedToken = (String)session.getAttribute("csrfToken");
			    String token = request.getParameter("token");
			    if (storedToken.equals(token))
			    {

				ArrayList vouchers = new ArrayList();
				vouchers = (ArrayList) fb.getVouchersList();
				String removes[] = request.getParameterValues("remove");
				Collection remove = new ArrayList();
				for (int i = 0; i < removes.length; i++) {

					remove.add(removes[i]);
				}

				WorksData1 worksData = new WorksData1(ds);
				String value = worksData.saveBills(vouchers, fb.getAssetName(), remove, getServlet());
				request.setAttribute("message", value);
				ArrayList vouchersList = worksData.getBills(fb.getAssetName(), getServlet());
				if (vouchersList != null && vouchersList.size() != 0) {
					fb.setVouchersList(vouchersList);
					session.setAttribute("vouchersList", vouchersList);
				} else {
					fb.setVouchersList(new ArrayList(0));
					session.setAttribute("vouchersList", new ArrayList(new ArrayList(0)));
				}
				mode = "BillForVoucher";
				return mapping.findForward(mode);
			    }
			}

			if (mode.equals("refundamount")) {

				long refundAmount = new RwsRefundsDAO().getBillAmount(fb.getWorkId());
				String partAamount = new RwsWorksDAO().getPartAAMount(fb.getWorkId());
				long spillamount = new RwsSpillRefundsDAO().getSpillAmount(fb.getWorkId());

				request.setAttribute("refundAmount", refundAmount);
				request.setAttribute("partAamount", partAamount);
				request.setAttribute("spillamount", spillamount);
			}


			if (mode != null && mode.equals("editScannedCopy")) {

				ArrayList vouchers = (ArrayList) session.getAttribute("vouchersList");

				int index = Integer.parseInt(request.getParameter("recIndex"));

				if (vouchers.get(index) != null) {

					tenderMemo tenderMemo = (tenderMemo) vouchers.get(index);
					if (tenderMemo.getBillDateEE() != null && !tenderMemo.getBillDateEE().equals("")) {
						request.setAttribute("message", "EE Forwarded Bill Not Allow to Edit.");
					} else {
						tenderMemo.setBillSaved("");
					}
				}

				mode = "BillForVoucher";
				return mapping.findForward(mode);

			}

			if (mode != null && mode.equals("showScannedCopy")) {
				
				
				/*WorksData1 worksData = new WorksData1(ds);

				byte a[] = worksData.getScannedCopy(request.getParameter("workId"), request.getParameter("slNo"));

				session.setAttribute("copyData", a);

				mode = "showFile";
				return mapping.findForward(mode);*/
				session.setAttribute("work_id", request.getParameter("workId"));
				session.setAttribute("bill_date", request.getParameter("billDate").replace("/", "-"));
				session.setAttribute("bill_sl_no", request.getParameter("slNo"));
				mode = "showFile";
				return mapping.findForward(mode);

			}
			if (mode.equals("BillForVoucher")) {

				fb.setAssetName(request.getParameter("workId"));
				WorksData1 worksData = new WorksData1(ds);
				ArrayList emptyList = new ArrayList(0);
				ArrayList vouchersList = new ArrayList();
				vouchersList = worksData.getBills(request.getParameter("workId"), getServlet());
				if (vouchersList != null && vouchersList.size() != 0) {
					fb.setVouchersList(vouchersList);
					session.setAttribute("vouchersList", vouchersList);
				} else {

					fb.setVouchersList(emptyList);
					session.setAttribute("vouchersList", new ArrayList(emptyList));
				}
				ArrayList employeesCheckMeasuredBy = worksData.getEmployees(fb.getAssetName().substring(4, 6), 7, 7);
				session.setAttribute("employeesCheckMeasuredBy", employeesCheckMeasuredBy);
				ArrayList employeesSuperCheckMeasuredBy = worksData.getEmployees(fb.getAssetName().substring(4, 6), 6,
						6);
				session.setAttribute("employeesSuperCheckMeasuredBy", employeesSuperCheckMeasuredBy);

				ArrayList employeesSuperCheckMeasuredBySE = worksData.getEmployees("all", 5, 5);
				session.setAttribute("employeesSuperCheckMeasuredBySE", employeesSuperCheckMeasuredBySE);

				fb.setNewsrcName(request.getParameter("workName"));
				fb.setHabsCode(request.getParameter("exp"));
				session.setAttribute("expWork", request.getParameter("exp"));

				return mapping.findForward(mode);
			}
			if (mode.equals("addNewBill")) {

				tenderMemo tenderMemoBean = null;

				ArrayList vouchers = new ArrayList();
				vouchers = (ArrayList) fb.getVouchersList();

				WorksData1 worksData = new WorksData1(ds);

				String errorMesg = "";

				if (fb.getAssetName() != null && fb.getAssetName().substring(6, 8).equals("11")) {
					errorMesg = "Schools are Not Linked With this Scheme.Please Add/Remove  Schools in WorksMonitoring->Work Progress Form.";
				} else if (fb.getAssetName() != null && fb.getAssetName().substring(6, 8).equals("12")) {
					errorMesg = "labs are Not Linked With this Scheme.Please Add/Remove  Labs in WorksMonitoring->Work Progress Form.";
				} else {
					errorMesg = "Habitations are Not Linked With this Scheme.Please Add/Remove  Habitations in WorksMonitoring->Work Hab Link Form.";
				}

				if (!worksData.checkHabitaionIsExixts(fb.getAssetName())) {
					request.setAttribute("message", errorMesg);
					mode = "BillForVoucher";
					return mapping.findForward(mode);
				}

				if (!worksData.checkSourceIsExists(fb.getAssetName())) {
					request.setAttribute("message",
							"Source is Not Linked with this Scheme.Please Add/Remove Source in WorksMonitoring->Work Progress Form->Source Identification.");
					mode = "BillForVoucher";
					return mapping.findForward(mode);
				}

				String spillOverAmt = worksData.getSpillOverAmount(fb.getAssetName(), "");
				if (spillOverAmt != null && !spillOverAmt.equals("0")) {
					request.setAttribute("message",
							"Before You add New Bill, You must save the Spill Over Bill By Clicking Add Last Fin.Year Bill button");
					mode = "BillForVoucher";
					return mapping.findForward(mode);
				} else {
					String billAmount = worksData.getNewBillAmount(fb.getAssetName(), request.getParameter("slNo"));

					long refundAmount = new RwsRefundsDAO().getBillAmount(fb.getAssetName());

					long spillamount = new RwsSpillRefundsDAO().getSpillAmount(fb.getWorkId());
					
					
					String billContractorAmt= worksData.getBillAmountCon(fb.getWorkId());
					
					
					String partAamount = new RwsWorksDAO().getPartAAMount(fb.getWorkId());
					if(refundAmount!=0 && refundAmount>0){
					long  billAmountSoFar=(Long.parseLong(billContractorAmt)+Long.parseLong(partAamount));
					dao = rws_works_factory.createWorksDAO(ds);
					rws_works_WorkStatus_form frm = dao.getAdminAndRevisedDetails(fb.getWorkId());
					long adminSancAmnt = (int) (Float.parseFloat(frm.getAdminAmnt()) * 100000);
					dao = rws_works_factory.createWorksDAO(ds);
					adminSancAmnt = adminSancAmnt + dao.getAdminOtherGrantsAmnt(fb.getWorkId());
					if(billAmountSoFar<=adminSancAmnt){
						//refundAmount=refundAmount;
					}
					else if(billAmountSoFar<refundAmount+adminSancAmnt){
						if(Long.parseLong(billAmount)<0){
							
						}else{
							refundAmount=(refundAmount+adminSancAmnt)-billAmountSoFar;
						}
					}
					else if(billAmountSoFar>adminSancAmnt){
					billAmount=billAmount+Long.parseLong(partAamount);
					}
					}
					//System.out.println("billAmount---"+billAmount);
					//System.out.println("refundAmount---"+refundAmount);
					//System.out.println("spillamount---"+spillamount);

					billAmount = String.valueOf(Long.parseLong(billAmount) + refundAmount + spillamount);

					if (billAmount != null && !billAmount.equals("0") && Long.parseLong(billAmount)>0) {
						String value = "0";
						double val = 0.0;
						value = "" + val;

						tenderMemoBean = new tenderMemo();
						tenderMemoBean.setBillSlNo(request.getParameter("slNo"));
						tenderMemoBean.setBillNo("");
						tenderMemoBean.setBillDate(request.getParameter("billNewDate"));
						tenderMemoBean.setGrossValueContractor(billAmount);
						tenderMemoBean.setGrossValueAdmissable("0");
						tenderMemoBean.setGrossValuePaidTotal("0");
						tenderMemoBean.setGrossValueOfBill("0");
						tenderMemoBean.setGrossValuePaid("0");
						tenderMemoBean.setPaymentAdmissable("0");
						tenderMemoBean.setPaymentInHand("0");
						tenderMemoBean.setBillVoucherAmount("0");
						vouchers.add(tenderMemoBean);
						session.setAttribute("vouchersList", new ArrayList(vouchers));
					} else {
						request.setAttribute("message",
								"There is No Additional Acheivement to raise the Bill - First Update the Acheivement Details in Program Schedule Phase");
					}
					mode = "BillForVoucher";

					return mapping.findForward(mode);
				}
			}
			if (mode.equals("addNewFinalBill")) {
				tenderMemo tenderMemoBean = null;

				ArrayList vouchers = new ArrayList();
				vouchers = (ArrayList) fb.getVouchersList();

				WorksData1 worksData = new WorksData1(ds);
				String spillOverAmt = worksData.getNewBillAmount(fb.getAssetName(), "0");
				if (spillOverAmt != null && !spillOverAmt.equals("0")) {
					request.setAttribute("message",
							"Before You add New Bill, You must save the Spill Over Bill By Clicking Add Last Fin.Year Bill button");
					mode = "BillForVoucher";
					return mapping.findForward(mode);
				} else {
					String billAmount = worksData.getNewBillAmount(fb.getAssetName(), "-1");
					if (billAmount != null && !billAmount.equals("0")) {
						String value = "0";
						double val = 0.0;
						value = "" + val;

						tenderMemoBean = new tenderMemo();
						tenderMemoBean.setBillSlNo(request.getParameter("slNo"));

						tenderMemoBean.setBillNo("");
						tenderMemoBean.setBillDate(request.getParameter("billNewDate"));
						tenderMemoBean.setGrossValueContractor(billAmount);
						tenderMemoBean.setGrossValueAdmissable("0");
						tenderMemoBean.setGrossValuePaidTotal("0");
						tenderMemoBean.setGrossValueOfBill("0");
						tenderMemoBean.setGrossValuePaid("0");
						tenderMemoBean.setPaymentAdmissable("0");
						tenderMemoBean.setPaymentInHand("0");
						tenderMemoBean.setBillVoucherAmount("0");
						vouchers.add(tenderMemoBean);
						session.setAttribute("vouchersList", new ArrayList(vouchers));
					} else {
						request.setAttribute("message", "There is No Withheld amount to raise the Bill");
					}
					mode = "BillForVoucher";
					return mapping.findForward(mode);
				}
			}
			if (mode.equals("addNewPrevBill")) {
				tenderMemo tenderMemoBean = null;
				ArrayList vouchers = new ArrayList();
				vouchers = (ArrayList) fb.getVouchersList();

				WorksData1 worksData = new WorksData1(ds);
				String billAmount = worksData.getNewBillAmount(fb.getAssetName(), "0");
				if (billAmount != null && !billAmount.equals("") && !billAmount.equals("0")) {
					String value = "0";
					double val = 0.0;
					value = "" + val;

					tenderMemoBean = new tenderMemo();
					tenderMemoBean.setBillSlNo(request.getParameter("slNo"));
					tenderMemoBean.setBillNo("BILLS UPTO " + request.getParameter("recDate"));
					tenderMemoBean.setBillDate(request.getParameter("recDate"));
					tenderMemoBean.setGrossValueContractor(billAmount);
					tenderMemoBean.setGrossValueAdmissable(billAmount);
					tenderMemoBean.setGrossValuePaidTotal("0");
					tenderMemoBean.setGrossValueOfBill("0");
					tenderMemoBean.setGrossValuePaid("0");
					tenderMemoBean.setPaymentAdmissable("0");
					tenderMemoBean.setPaymentInHand("0");
					tenderMemoBean.setBillVoucherAmount("0");
					vouchers.add(tenderMemoBean);
					session.setAttribute("vouchersList", new ArrayList(vouchers));
				} else {
					request.setAttribute("message",
							"There are no Mile Stones Items Under Spill Over Category for the Last Financial Year");
				}
				mode = "BillForVoucher";
				return mapping.findForward(mode);
			}
			if (mode.equals("removeBill")) {
				String removeList[] = request.getParameterValues("remove");

				ArrayList vouchers = new ArrayList();
				vouchers = (ArrayList) fb.getVouchersList();

				WorksData1 worksData = new WorksData1(ds);
				String value = worksData.removeBills(vouchers, fb.getAssetName(), removeList,
						request.getParameter("remarks"), user.getUserId());
				request.setAttribute("message", value);
				ArrayList emptyList = new ArrayList(0);
				ArrayList vouchersList = new ArrayList();
				vouchersList = worksData.getBills(fb.getAssetName(), getServlet());
				if (vouchersList != null && vouchersList.size() != 0) {
					fb.setVouchersList(vouchersList);
					session.setAttribute("vouchersList", vouchersList);
				} else {
					fb.setVouchersList(emptyList);
					session.setAttribute("vouchersList", new ArrayList(emptyList));
				}
				mode = "BillForVoucher";
				return mapping.findForward(mode);
			}
			if (mode.equals("ExpVoucher")) {
				fb.setAssetName(request.getParameter("workId"));

				WorksData1 worksData = new WorksData1(ds);
				ArrayList employeesRecBy = worksData.getEmployees(fb.getAssetName().substring(4, 6), 7, 9);
				session.setAttribute("employeesRecBy", employeesRecBy);
				ArrayList employeesCheckMeasuredBy = worksData.getEmployees(fb.getAssetName().substring(4, 6), 6, 7);
				session.setAttribute("employeesCheckMeasuredBy", employeesCheckMeasuredBy);
				ArrayList employeesSuperCheckMeasuredBy = worksData.getEmployees(fb.getAssetName().substring(4, 6), 2,
						6);
				session.setAttribute("employeesSuperCheckMeasuredBy", employeesSuperCheckMeasuredBy);
				ArrayList contractors = worksData.getContractors(fb.getAssetName());
				session.setAttribute("contractors", contractors);
				ArrayList progs = worksData.getAdminPrograms(request.getParameter("workId"));
				session.setAttribute("programs", progs);
				ArrayList emptyList = new ArrayList(0);
				ArrayList vouchersList = new ArrayList();
				vouchersList = worksData.getVouchers(request.getParameter("workId"));
				if (vouchersList != null && vouchersList.size() != 0) {
					fb.setVouchersList(vouchersList);
					session.setAttribute("vouchersList", vouchersList);
				} else {
					fb.setVouchersList(emptyList);
					session.setAttribute("vouchersList", new ArrayList(emptyList));
				}
				fb.setNewsrcName(request.getParameter("workName"));
				fb.setHabsCode(request.getParameter("exp"));
				session.setAttribute("expWork", request.getParameter("exp"));
				return mapping.findForward(mode);
			}
			if (mode.equals("addnewVoucher")) {
				tenderMemo tenderMemoBean = null;

				ArrayList vouchers = new ArrayList();
				vouchers = (ArrayList) fb.getVouchersList();

				tenderMemoBean = new tenderMemo();
				tenderMemoBean.setProgCode("");
				tenderMemoBean.setMBookNo("");
				tenderMemoBean.setEmpCodeRecorded("");
				tenderMemoBean.setRecordedDate("");
				tenderMemoBean.setEmpCode("");
				tenderMemoBean.setCheckMesuaredDate("");
				tenderMemoBean.setVoucherNo("");
				tenderMemoBean.setVoucherDate("");
				tenderMemoBean.setVoucherAmount("");
				tenderMemoBean.setChequeNo("");
				tenderMemoBean.setChequeDate("");
				tenderMemoBean.setEmpCodeSuper("");
				tenderMemoBean.setSuperCheckMesuaredDate("");
				tenderMemoBean.setCheckMesuaredRemarks("");
				vouchers.add(tenderMemoBean);
				session.setAttribute("vouchersList", new ArrayList(vouchers));
				mode = "ExpVoucher";
				return mapping.findForward(mode);
			}
			if (mode.equals("saveVouchers")) {
				ArrayList vouchers = new ArrayList();
				vouchers = (ArrayList) fb.getVouchersList();

				WorksData1 worksData = new WorksData1(ds);
				String value = worksData.saveVouchers(vouchers, fb.getAssetName(),
						(ArrayList) session.getAttribute("programs"));
				request.setAttribute("message", value);
				mode = "ExpVoucher";
				return mapping.findForward(mode);
			}
			if (mode.equals("removeVoucher")) {
				String removeList[] = request.getParameterValues("remove");

				ArrayList vouchers = new ArrayList();
				vouchers = (ArrayList) fb.getVouchersList();

				WorksData1 worksData = new WorksData1(ds);
				String value = worksData.removeVouchers(vouchers, fb.getAssetName(), removeList);
				request.setAttribute("message", value);
				ArrayList emptyList = new ArrayList(0);
				ArrayList vouchersList = new ArrayList();
				vouchersList = worksData.getVouchers(fb.getAssetName());
				if (vouchersList != null && vouchersList.size() != 0) {
					fb.setVouchersList(vouchersList);
					session.setAttribute("vouchersList", vouchersList);
				} else {
					fb.setVouchersList(emptyList);
					session.setAttribute("vouchersList", new ArrayList(emptyList));
				}
				mode = "ExpVoucher";
				return mapping.findForward(mode);
			}

			if (mode.equals("ExpVoucherContractor")) {
				
				fb.setAssetName(request.getParameter("workId"));

				WorksData1 worksData = new WorksData1(ds);
				ArrayList employeesRecBy = worksData.getEmployees(fb.getAssetName().substring(4, 6), 7, 9);
				session.setAttribute("employeesRecBy", employeesRecBy);
				ArrayList employeesCheckMeasuredBy = worksData.getEmployees(fb.getAssetName().substring(4, 6), 6, 7);
				session.setAttribute("employeesCheckMeasuredBy", employeesCheckMeasuredBy);
				ArrayList employeesSuperCheckMeasuredBy = worksData.getEmployees(fb.getAssetName().substring(4, 6), 2,
						6);
				session.setAttribute("employeesSuperCheckMeasuredBy", employeesSuperCheckMeasuredBy);
				ArrayList progs = worksData.getAdminPrograms(request.getParameter("workId"));
				session.setAttribute("programs", progs);
				ArrayList contractors = worksData.getContractors(fb.getAssetName());
				session.setAttribute("contractors", contractors);
				ArrayList bills = worksData.getAllBills(fb.getAssetName());
				session.setAttribute("bills", bills);

				ArrayList emptyList = new ArrayList(0);
				ArrayList vouchersList = new ArrayList();
				vouchersList = worksData.getVouchers(request.getParameter("workId"));
				if (vouchersList != null && vouchersList.size() != 0) {
					fb.setVouchersList(vouchersList);
					session.setAttribute("vouchersList", vouchersList);
				} else {
					fb.setVouchersList(emptyList);
					session.setAttribute("vouchersList", new ArrayList(emptyList));
				}
				fb.setNewsrcName(request.getParameter("workName"));
				fb.setHabsCode(request.getParameter("slNo"));

				fb.setAdminScPopu(request.getParameter("mstoneName"));
				fb.setAdminSTPopu(request.getParameter("mstoneStageName"));
				return mapping.findForward(mode);
				
			}
			if (mode.equals("addnewVoucherContract")) {
				tenderMemo tenderMemoBean = null;

				ArrayList vouchers = new ArrayList();

				vouchers = (ArrayList) fb.getVouchersList();

				WorksData1 worksData = new WorksData1(ds);
				if (worksData.getNewVoucherAmount(fb.getAssetName()) == 1) {
					request.setAttribute("message",
							"Before entering the New Voucher, You must add the Voucher for Spill Over Bill By Clicking the Add Last Fin.Year Voucher");
				} else {
					tenderMemoBean = new tenderMemo();
					tenderMemoBean.setIsApproved("NA");
					tenderMemoBean.setMileStoneSno(fb.getHabsCode());
					tenderMemoBean.setProgCode("");
					tenderMemoBean.setMBookNo("");
					tenderMemoBean.setEmpCodeRecorded("");
					tenderMemoBean.setRecordedDate("");
					tenderMemoBean.setEmpCode("");
					tenderMemoBean.setCheckMesuaredDate("");
					tenderMemoBean.setVoucherNo("");
					tenderMemoBean.setVoucherDate("");
					tenderMemoBean.setVoucherAmount("");
					tenderMemoBean.setChequeNo("");
					tenderMemoBean.setChequeDate("");
					tenderMemoBean.setEmpCodeSuper("");
					tenderMemoBean.setSuperCheckMesuaredDate("");
					tenderMemoBean.setCheckMesuaredRemarks("");
					tenderMemoBean.setPaymentAdmissable("0");
					tenderMemoBean.setBillVoucherAmount("0");
					vouchers.add(tenderMemoBean);
					session.setAttribute("vouchersList", new ArrayList(vouchers));
				}
				mode = "ExpVoucherContractor";
				return mapping.findForward(mode);
			}
			if (mode.equals("addnewVoucherPrevContract")) {
				tenderMemo tenderMemoBean = null;

				ArrayList vouchers = new ArrayList();

				vouchers = (ArrayList) fb.getVouchersList();

				WorksData1 worksData = new WorksData1(ds);
				String amt = worksData.getBillVoucherAmount(fb.getAssetName(), "0");
				String[] amts = amt.split("/");
				if (Integer.parseInt(amts[0]) > 0) {
					tenderMemoBean = new tenderMemo();
					tenderMemoBean.setMileStoneSno(fb.getHabsCode());
					tenderMemoBean.setProgCode("");
					tenderMemoBean.setMBookNo("");
					tenderMemoBean.setEmpCodeRecorded("");
					tenderMemoBean.setRecordedDate("");
					tenderMemoBean.setEmpCode("");
					tenderMemoBean.setCheckMesuaredDate("");
					tenderMemoBean.setVoucherNo("VOUCHERS UPTO " + request.getParameter("recDate"));
					tenderMemoBean.setVoucherDate(request.getParameter("recDate"));
					tenderMemoBean.setChequeNo("");
					tenderMemoBean.setChequeDate("");
					tenderMemoBean.setEmpCodeSuper("");
					tenderMemoBean.setSuperCheckMesuaredDate("");
					tenderMemoBean.setCheckMesuaredRemarks("");
					tenderMemoBean.setPaymentAdmissable("0");
					tenderMemoBean.setBillVoucherAmount("0");
					tenderMemoBean.setBillSlNo("0");

					tenderMemoBean.setPaymentAdmissable(amts[0]);
					tenderMemoBean.setBillVoucherAmount(amts[1]);
					tenderMemoBean.setVoucherAmount(amts[0]);
					vouchers.add(tenderMemoBean);
					session.setAttribute("vouchersList", new ArrayList(vouchers));
				} else {
					request.setAttribute("message",
							"You cannot add the Voucher for Spill Over Bill because there is no spill over related bill");
				}
				mode = "ExpVoucherContractor";
				return mapping.findForward(mode);
			}
			if (mode.equals("saveVouchersContract")) {
				String storedToken = (String)session.getAttribute("csrfToken");
			    String token = request.getParameter("token");
			    if (storedToken.equals(token))
			    {
				ArrayList vouchers = new ArrayList();
				vouchers = (ArrayList) fb.getVouchersList();

				WorksData1 worksData = new WorksData1(ds);
				String value = worksData.saveVouchers(vouchers, fb.getAssetName(),
						(ArrayList) session.getAttribute("programs"), fb.getHabsCode());
				request.setAttribute("message", value);
				ArrayList vouchersList = new ArrayList();
				vouchersList = worksData.getVouchers(fb.getAssetName());
				if (vouchersList != null && vouchersList.size() != 0) {
					fb.setVouchersList(vouchersList);
					session.setAttribute("vouchersList", vouchersList);
				} else {
					fb.setVouchersList(new ArrayList(0));
					session.setAttribute("vouchersList", new ArrayList(0));
				}
				mode = "ExpVoucherContractor";
				
				return mapping.findForward(mode);
			    }
			}
			if (mode.equals("removeVoucherContract")) {
				String removeList[] = request.getParameterValues("remove");

				ArrayList vouchers = new ArrayList();
				vouchers = (ArrayList) fb.getVouchersList();

				WorksData1 worksData = new WorksData1(ds);
				String value = worksData.removeVouchers(vouchers, fb.getAssetName(), removeList);
				request.setAttribute("message", value);
				ArrayList emptyList = new ArrayList(0);
				ArrayList vouchersList = new ArrayList();
				vouchersList = worksData.getVouchers(fb.getAssetName(), fb.getHabsCode());
				if (vouchersList != null && vouchersList.size() != 0) {
					fb.setVouchersList(vouchersList);
					session.setAttribute("vouchersList", vouchersList);
				} else {
					fb.setVouchersList(emptyList);
					session.setAttribute("vouchersList", new ArrayList(emptyList));
				}
				mode = "ExpVoucherContractor";
				return mapping.findForward(mode);
			}
			if (mode.equals("vouchersIssue")) {
				ArrayList programMileStones = new ArrayList();
				WorksData1 worksData = new WorksData1(ds);
				programMileStones = worksData.getProgramMileStones(ds, request.getParameter("workId"));

				fb.setMileStones(programMileStones);
				return mapping.findForward(mode);
			}
			String mode1 = request.getParameter("mode1");

			String checking[] = null;

			if (mode != null && mode.equals("contractorUpdate")) {

				
				if (user == null) {
					return mapping.findForward("expire");
				}
				
				if (!(user.getUserId() != null
						&& (user.getUserId().equals(Constants.ADMIN)  || user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId())))) {
					return mapping.findForward("unAuthorise");
				}
				
				try {
					DataSource dataSource = getDataSource(request);
					RwsOffices officess = new RwsOffices(dataSource);
					WorksData1 worksData = new WorksData1(dataSource);
					if (mode1 == null) {
						fb.setContractorList(new ArrayList());
						session.setAttribute("contractorList", new ArrayList());
						fb.setCircleOfficeCode("");
						fb.setDivisionOfficeCode("");
						if (!(user.getUserId().equals("admin") || user.getUserId().equals("100000"))) {

							session.setAttribute("fixcircle", "yes");
							String userId = user.getUserId();
							if (mode1 == null)
								mode1 = "Divisions";
						} else {
							session.setAttribute("fixcircle", null);
						}
						offices = new RwsOffices(dataSource);

						circles = offices.CircleCombo("1");
						session.setAttribute("circles", circles);
					}
					if (mode1 != null && mode1.equalsIgnoreCase("Divisions")) {
						dataSource = getDataSource(request);
						offices = new RwsOffices(dataSource);
						divisions = offices.getDivisions1(fb.getCircleOfficeCode());
						session.setAttribute("divisions", divisions);
						mode1 = "workcategory";
					}
					if (mode1 != null && mode1.equals("fnSave")) {

						session = request.getSession();
					     String storedToken = (String)session.getAttribute("csrfToken");
					     String token = request.getParameter("token");
					     if (storedToken.equals(token))
					     {	
						
						int recno = 0;
						int upCount = 0;
						recno = Integer.parseInt(request.getParameter("resultCount"));
						checking = new String[recno + 1];
						checking[0] = " ";
						recno = Integer.parseInt(request.getParameter("resultCount"));
						ArrayList vouchers = (ArrayList) fb.getContractorList();
						int checked = 0;
						for (int i = 0; i < vouchers.size(); i++) {
							tenderMemo tenderMemoBean = (tenderMemo) vouchers.get(i);
							if (request.getParameter("check" + (i + 1)) != null) {
								checking[i] = "1";
								checked++;
								upCount += worksData.updateContractor(request.getParameter("check" + (i + 1)),
										tenderMemoBean.getProgName(), tenderMemoBean.getSubprogName());
							}
						}
						String message = "";
						if (upCount > 0) {
							message = upCount + " Contractor(s) Updated Successfully";
							if (checked - upCount > 0) {
								message += " and " + (checked - upCount)
										+ " Contractor(s) Failed to Update Due to Existance of PAN NO (or) VOTER ID";
							}
							request.setAttribute("message", message);
						} else {
							request.setAttribute("message",
									"No Contractor(s) Updated Due to Existance of PAN NO (or) VOTER ID");
						}

					}
					}
					if (mode1 != null && mode1.equalsIgnoreCase("getWorks")) {
						ArrayList conts = worksData.getContractorsForUpdation(fb.getCircleOfficeCode(),
								fb.getDivisionOfficeCode(), "1");
						tenderMemo tendermemo = new tenderMemo();

						if (conts != null) {
							fb.setContractorList(conts);
							session.setAttribute("contractorList", conts);
						} else {
							fb.setContractorList(new ArrayList());
							session.setAttribute("contractorList", new ArrayList());
						}
					}
					if (mode1 != null && mode1.equalsIgnoreCase("getWorks1")) {
						ArrayList conts = worksData.getContractorsForUpdation(fb.getCircleOfficeCode(),
								fb.getDivisionOfficeCode(), "2");
						tenderMemo tendermemo = new tenderMemo();

						if (conts != null) {
							fb.setContractorList(conts);
							session.setAttribute("contractorList", conts);
						} else {
							fb.setContractorList(new ArrayList());
							session.setAttribute("contractorList", new ArrayList());
						}
					}
					if (mode1 != null && mode1.equals("showWorks")) {

						String selContCode = request.getParameter("contractorCode");
						if (selContCode != null && selContCode.length() > 0) {
							ArrayList habs = worksData.getWorks(selContCode, fb.getCircleOfficeCode(),
									fb.getDivisionOfficeCode());
							request.setAttribute("selectedWorks", habs);
						}
						mode = "showWorks1";
					}
				} catch (Exception e) {
					Debug.println("Exception in update Contractor:" + e.getMessage());
				}
				return mapping.findForward(mode);
			}
			if (workStage != null && workStage.equals("")) {
				if (mode.equals("circles")) {
					session.removeAttribute("divs");
					session.removeAttribute("subdivs");
					session.removeAttribute("workCategory");
					session.removeAttribute("programmes");
					session.removeAttribute("subprogrammes");
					session.removeAttribute("rwsWorks");
					session.removeAttribute("assettypes");
					session.removeAttribute("expyears");
					fb.setFinancialyear("");
					circles = offices.CircleCombo(headOfficeCode);
					if (circles != null)
						session.setAttribute("circles", circles);
					DataSource dataSource = getDataSource(request);
					offices = new RwsOffices(dataSource);
					session.setAttribute("expyears", offices.getExpYears());

					if (user.getUserId().equals("admin") || user.getUserId().equals("100000")) {
						session.setAttribute("fixcircle", null);
						fb.setDivCode("");
						fb.setSubdivisioncode("");
						fb.setProgram("");
						fb.setSubprogram("");
						fb.setScheme("");
						fb.setWorkName("");
						fb.setSchemelist("");
					}

					if (!(user.getUserId().equals("admin") || user.getUserId().equals("100000"))) {
						mode = "div";
						fb.setCircleCode(user.getUserId().substring(1, 3));
						session.setAttribute("fixcircle", "yes");
						fb.setDivCode("");
						fb.setProgram("");
						fb.setSubprogram("");
						fb.setScheme("");
					}
					fb.setPhysicalStatus("");
					fb.setPhysicalStatusDetails("");
				}
				if (mode.equals("div")) {
					session.removeAttribute("divs");
					fb.setWorkId("");
					fb.setNmode("");
					fb.setNwork("");
					divisions = offices.DivisionCombo(headOfficeCode, fb.getCircleCode());
					session.setAttribute("divs", divisions);
					session.removeAttribute("workCategory");
					session.removeAttribute("subdivs");
					session.removeAttribute("programmes");
					session.removeAttribute("subprogrammes");
					session.removeAttribute("assettypes");
					session.removeAttribute("rwsWorks");
					fb.setScheme(null);
					fb.setWorkCat("");
					fb.setDivCode("");
					fb.setSubDivCode("");
					fb.setProgCode("");
					fb.setSubProgCode("");
					fb.setPhysicalStatus("");
					fb.setPhysicalStatusDetails("");
				}
				if (mode.equals("subdiv")) {
					workCategory = offices.getWorkCategory();
					session.setAttribute("workCategory", workCategory);

					offices = null;
					offices = new RwsOffices();
					subdivs = offices.SubDivisionCombo(headOfficeCode, fb.getCircleCode(), fb.getDivCode());

					fb.setWorkCat("");
					fb.setProgCode("");
					fb.setSubProgCode("");
					if (subdivs != null) {
						session.setAttribute("subdivs", subdivs);
						session.removeAttribute("programmes");
						session.removeAttribute("subprogrammes");
						session.removeAttribute("rwsWorks");
						session.removeAttribute("assettypes");
						fb.setScheme(null);
					}
					fb.setPhysicalStatus("");
					fb.setPhysicalStatusDetails("");
				}
				if (mode.equals("program")) {

					session.removeAttribute("subprogrammes");
					session.removeAttribute("rwsWorks");
					session.removeAttribute("programmes");
					session.removeAttribute("assettypes");
					programmes = offices.getProgrammes1(fb.getPlan(), fb.getWrktype(), fb.getWorkCat());

					if (programmes.size() != 0) {
						session.setAttribute("programmes", programmes);
						fb.setScheme(null);
					}
					fb.setProgram("");
					fb.setProgCode("");
					fb.setSubProgCode("");


					bean = new rws_works_WorkStatus_bean();
					dao = rws_works_factory.createWorksDAO(ds);
					ArrayList worksList = new ArrayList();
					worksList = dao.getWorks22(fb, user.getUserId());
					session.removeAttribute("assettypes");
					assettypes = offices.getAssetTypes(fb.getWorkCat(), fb.getPlan());

					if (assettypes != null) {
						session.setAttribute("assettypes", assettypes);
						session.removeAttribute("rwsWorks");
						fb.setScheme(null);
						fb.setProgram("");
					}

					if (worksList != null) {
						session.setAttribute("rwsWorks", worksList);
						fb.setScheme(null);
					}

					fb.setPhysicalStatus("");
					fb.setPhysicalStatusDetails("");

				}
				if (mode.equals("subprogram")) {

					session.removeAttribute("subprogrammes");
					subprogrammes = offices.getSubProgrammes(fb.getProgram());

					if (subprogrammes != null) {
						session.setAttribute("subprogrammes", subprogrammes);
						session.removeAttribute("rwsWorks");
						fb.setScheme(null);
					}
					fb.setSubprogram("");
					fb.setSubProgCode("");
					fb.setSchemelist("");
					fb.setFinancialyear("");
					fb.setPhysicalStatus("");
					fb.setPhysicalStatusDetails("");
				}
				if (mode.equals("schemeslist")) {
					session.removeAttribute("assettypes");
					assettypes = offices.getAssetTypes(fb.getWorkCat(), fb.getPlan());
					if (assettypes != null) {
						session.setAttribute("assettypes", assettypes);
						session.removeAttribute("rwsWorks");
						fb.setScheme(null);
					}

					fb.setPhysicalStatus("");
					fb.setPhysicalStatusDetails("");
				}
				if (mode.equals("workcombo")) {
					bean = new rws_works_WorkStatus_bean();
					fb.setNwork("");
					dao = rws_works_factory.createWorksDAO(ds);
					ArrayList worksList = new ArrayList();
					worksList = dao.getWorks22(fb, user.getUserId());

					if (worksList != null) {
						session.setAttribute("rwsWorks", worksList);
						fb.setScheme(null);
					}
					fb.setPhysicalStatus("");
					fb.setPhysicalStatusDetails("");
				}
				if (mode.equals("circles1")) {
					circles = offices.CircleCombo(headOfficeCode);
					if (circles != null)
						session.setAttribute("circles", circles);

					fb.setCircleCode(request.getParameter("circleCode"));

					divisions = offices.DivisionCombo(headOfficeCode, fb.getCircleCode());
					if (divisions != null)
						session.setAttribute("divs", divisions);
					fb.setDivCode(request.getParameter("divCode"));
					subdivs = offices.SubDivisionCombo(headOfficeCode, fb.getCircleCode(), fb.getDivCode());
					
					if (subdivs != null)
						session.setAttribute("subdivs", subdivs);

					bean = new rws_works_WorkStatus_bean();
					dao = rws_works_factory.createWorksDAO(ds);
					ArrayList worksList = new ArrayList();
					worksList = dao.getWorks22(fb, user.getUserId());

					if (worksList != null) {
						session.setAttribute("rwsWorks", worksList);

					}
				}
				if (mode != null && mode.equals("addRemarks")) {
					dao = rws_works_factory.createWorksDAO(ds);
					fb.setPhysicalStatusDetails(dao.getNotGroundRemarks(fb.getWorkId()));
					dao = rws_works_factory.createWorksDAO(ds);
					fb.setWorkName(dao.getWorkName(fb.getWorkId()));
					return mapping.findForward(mode);
				}
				if (mode != null && mode.equals("saveRemarks")) {
					dao = rws_works_factory.createWorksDAO(ds);
					boolean val = dao.addNotGroundRemarks(fb.getWorkId(), fb.getPhysicalStatusDetails());
					if (val)
						request.setAttribute("message", "Reasons Added Successfully");
					else
						request.setAttribute("message", "Reasons Cannot be Added");
					return mapping.findForward("close");
				}
				if (mode != null && mode.equals("enterStandPostsAndHouseConns")) {
					WorksData1 worksData = new WorksData1(ds);
					ArrayList selectedHabCodes = worksData.getHabsDetails(request.getParameter("workId"));

					SUCCESS = "enterStandPostsAndHouseConns";
					return mapping.findForward(SUCCESS);
				}
				if (mode != null && mode.equals("saveIndTap")) {
					//System.out.println("save IndTap :"+fb.getIndTapLocation()+" type :"+fb.getIndTapType()+" hab Code :"+fb.getHabCode());
					dao = rws_works_factory.createWorksDAO(ds);
					int val = dao.saveIndividualTapConn(fb.getIndTapLocation(),fb.getIndTapType(), fb.getHabCode());

					if(val>0){
						String workId = fb.getWorkId();
						System.out.println("workId :"+workId);
						WorksData1 worksData = new WorksData1(ds);
						ArrayList selectedHabCodes = worksData.getHabsDetails(fb.getWorkId());

						SUCCESS = "enterStandPostsAndHouseConns";
						return mapping.findForward(SUCCESS);
					}
					else
						request.setAttribute("message", "Individual Tap Conn Cannot be Added");
					return mapping.findForward(SUCCESS);
				}
				if (mode != null && mode.equals("schoolTapsList")) {
					//System.out.println("habCode :"+request.getParameter("habCode"));
					WorksData1 worksData = new WorksData1(ds);
					ArrayList schoolTaps = worksData.getSchoolsInHab(request.getParameter("habCode"));
					request.setAttribute("schoolTaps", schoolTaps);
					///fb.setSchoolTapDetailsList(schoolTaps);
					fb.setWorkId(request.getParameter("workId"));
					fb.setWorkName(request.getParameter("scheme"));
					SUCCESS = "schoolTapsList";
					return mapping.findForward(SUCCESS);
				}
				if (mode != null && mode.equals("saveSchoolTapsList")) { 
					String storedToken = (String)session.getAttribute("csrfToken");
			      String token = request.getParameter("token");
			     if (storedToken.equals(token))
			     {
			    	 int schoolCnt = Integer.parseInt(request.getParameter("resultCount"));
			    	
			    	 ArrayList<RWS_SCHOOL_BEAN> schols = new ArrayList<RWS_SCHOOL_BEAN>();
			    	 for(int i=1;i<=schoolCnt;i++){
			    		 RWS_SCHOOL_BEAN bn = new RWS_SCHOOL_BEAN();
			    		 bn.setSchoolDetails(request.getParameter("schoolDetails"+i));
			    		 bn.setSchoolCategory(request.getParameter("schoolCategory"+i));
			    		 bn.setSchoolClassification(request.getParameter("schoolClassification"+i));
			    		 bn.setHabCode(request.getParameter("habCode"+i));
			    		 if(request.getParameter("isSchoolHavingTap"+i) != null && request.getParameter("isSchoolHavingTap"+i).equals("on"))
			    		 bn.setIsSchoolHavingTap("Yes");
			    		 else bn.setIsSchoolHavingTap("No");
			    		 bn.setSchoolCode(request.getParameter("schoolCode"+i));
			    		 bn.setSchoolCategoryCode(request.getParameter("schoolCategoryCode"+i));
			    		 schols.add(bn);
			    	 } 
			    	 dao = rws_works_factory.createWorksDAO(ds);
					int savedSchools = dao.saveSchoolTapStatus(schols);
					if(savedSchools>0){
						String workId = fb.getWorkId();
						//System.out.println("workId :"+workId);
						request.setAttribute("workName", fb.getWorkName());
						WorksData1 worksData = new WorksData1(ds);
						ArrayList selectedHabCodes = worksData.getHabsDetails(fb.getWorkId());

						SUCCESS = "enterStandPostsAndHouseConns";
						return mapping.findForward(SUCCESS);
					}
			     }

				}
				if (mode != null && mode.equals("addSchool")) {
					RwsLocations rwsLocations = null;
					RwsOffices off = new RwsOffices();
					request.setAttribute("dname", off.getDistrictName(fb.getWorkId().substring(4, 6)));
					request.setAttribute("mname",
							off.getMandalName(fb.getWorkId().substring(4, 6), fb.getMandalCode()));
					WorksData1 worksData = new WorksData1(ds);
					dao = rws_works_factory.createWorksDAO(ds);
					fb.setWorkName(dao.getWorkName(fb.getWorkId()));
					if (request.getParameter("mode1") == null) {
						request.removeAttribute("schoolList");
						fb.setMandalCode("");
						rwsLocations = new RwsLocations(getDataSource(request));
						ArrayList mandals = worksData.getMandals(ds, fb.getWorkId().substring(4, 6));
						session.setAttribute("mandals", mandals);
						ArrayList schoolMandals = worksData.getSchoolMandals(fb.getWorkId());
						request.setAttribute("schoolMandals", schoolMandals);

						session.removeAttribute("panchayats");
						session.removeAttribute("villages");
						session.removeAttribute("habitations");
					} else if (request.getParameter("mode1") != null
							&& request.getParameter("mode1").equals("panchayats")) {
						rwsLocations = new RwsLocations(getDataSource(request));
						ArrayList panchayats = rwsLocations.getPanchayats(fb.getWorkId().substring(4, 6),
								fb.getMandalCode());
						session.setAttribute("panchayats", panchayats);
						session.removeAttribute("villages");
						session.removeAttribute("habitations");
					} else if (request.getParameter("mode1") != null
							&& request.getParameter("mode1").equals("villages")) {
						rwsLocations = new RwsLocations(getDataSource(request));
						ArrayList villages = rwsLocations.getVillages(fb.getWorkId().substring(4, 6),
								fb.getMandalCode(), fb.getPanchayatCode());
						session.setAttribute("villages", villages);
						session.removeAttribute("habitations");
					} else if (request.getParameter("mode1") != null && request.getParameter("mode1").equals("habs")) {
						rwsLocations = new RwsLocations(getDataSource(request));
						ArrayList habitations = rwsLocations.getHabitations(fb.getWorkId().substring(4, 6),
								fb.getMandalCode(), fb.getPanchayatCode(), fb.getVillageCode());
						session.setAttribute("habitations", habitations);
					} else if (request.getParameter("mode1") != null && request.getParameter("mode1").equals("yes")) {
						ArrayList list = worksData.viewSchoolList(fb.getWorkId(), fb.getMandalCode(),
								fb.getPanchayatCode(), fb.getVillageCode(), fb.getHabsCode());
						request.setAttribute("schoolList", list);
					}
					return mapping.findForward(mode);
				}
				if (mode != null && mode.equals("saveSchool")) {
					String storedToken = (String)session.getAttribute("csrfToken");
				    String token = request.getParameter("token");
				    if (storedToken.equals(token))
				    {
					dao = rws_works_factory.createWorksDAO(ds);
					if (request.getParameter("school") != null && !request.getParameter("school").equals("")) {
						String[] schools = request.getParameterValues("school");
						for (int i = 0; i < schools.length; i++) {
						}
						int savedSchools = 0;
						dao = rws_works_factory.createWorksDAO(ds);
						savedSchools = dao.saveSchoolLinkedToWork(fb.getWorkId(), schools);
						if (savedSchools > 0)
							request.setAttribute("message", savedSchools + " School Added Successfully");
						else
							request.setAttribute("message", "School Cannot be Added");
					} else {
						request.setAttribute("message", "Problem Occured - Please Select School Again");
					}

					return mapping.findForward("close");
				    }
				}
				if (mode != null && mode.equals("cancelWork")) {

					dao = rws_works_factory.createWorksDAO(ds);

					int val = dao.cancelTheWork(request.getParameter("workId"), request.getParameter("cancelDate"));

					if (val > 0)
						request.setAttribute("message", "Work Cancelled Successfully");
					else
						request.setAttribute("message", "Work Cancellation Failed");
					return mapping.findForward("showMsg");
				}
				if (mode != null && mode.equals("continueWork")) {

					dao = rws_works_factory.createWorksDAO(ds);

					int val = dao.cancelTheWork(request.getParameter("workId"), "");
					if (val > 0)
						request.setAttribute("message", "Work Continued Successfully");
					else
						request.setAttribute("message", "Work Continuation Failed");
					return mapping.findForward("showMsg");
				}
				if ((mode != null && mode.equals("works"))
						|| (request.getParameter("wMode") != null && request.getParameter("wMode").equals("works"))) {

					String divcode = fb.getSubdivisioncode();

					dao = rws_works_factory.createWorksDAO(ds);
					bean = new rws_works_WorkStatus_bean();
					rws_works_WorkStatus_form fb1 = dao.getWorkDetails(fb);
					fb.setProgName(fb1.getProgName());
					fb.setSubProgName(fb1.getSubProgName());
					fb.setScheme(fb1.getScheme());
					fb.setSchemeCode(fb1.getSchemeCode());
					fb.setProgCode(fb1.getProgCode());
					fb.setSubProgCode(fb1.getSubProgCode());

					dao = rws_works_factory.createWorksDAO(ds);
					bean = new rws_works_WorkStatus_bean();
					bean = dao.getPopulationDetails(fb.getWorkId(), "RWS_ADMN_HAB_LNK_TBL");
					fb.setAdminPlainPopu(bean.getAdminPlainPopu());
					fb.setAdminScPopu(bean.getAdminScPopu());
					fb.setAdminSTPopu(bean.getAdminSTPopu());
					fb.setAdminTotpopu(bean.getAdminTotpopu());

					/** TO get the population detials of revised admin sanction */
					dao = rws_works_factory.createWorksDAO(ds);
					bean = new rws_works_WorkStatus_bean();
					bean = dao.getPopulationDetails(fb.getWorkId(), "RWS_REV_ADM_SANC_HAB_LNK_TBL");
					fb.setRevPlainPopu(bean.getAdminPlainPopu());
					fb.setRevScPopu(bean.getAdminScPopu());
					fb.setRevSTPopu(bean.getAdminSTPopu());
					fb.setRevTotpopu(bean.getAdminTotpopu());
					fb.setSubdivisioncode(bean.getSubdivisioncode());

					bean = new rws_works_WorkStatus_bean();
					fb.setSubdivisioncode(divcode);
					bean.setSubdivisioncode(divcode);
					dao = rws_works_factory.createWorksDAO(ds);
					ArrayList worksList = new ArrayList();
					worksList = dao.getWorks(fb);
					if (worksList != null)
						session.setAttribute("rwsWorks", worksList);

				}
				if (mode.equals("details")) {

					session.removeAttribute("mileStonesList");
					fb.setFinancialyear("");
					fb.setMileStones(new ArrayList());
					dao = rws_works_factory.createWorksDAO(ds);
					bean = new rws_works_WorkStatus_bean();

					if (nmode != null && nmode.equals("nmode")) {
						if (fb.getNwork() != null && !fb.getNwork().equals("")) {
							fb.setWorkId(fb.getNwork());
							String mesg = new RwsWorksDAO().updateWorkDetails(fb);
							if (!mesg.equals("1")) {
								session.removeAttribute("divs");
								session.removeAttribute("subdivs");
								session.removeAttribute("workCategory");
								session.removeAttribute("programmes");
								session.removeAttribute("subprogrammes");
								session.removeAttribute("rwsWorks");
								session.removeAttribute("assettypes");
								session.removeAttribute("expyears");
								fb.setFinancialyear("");

								fb.setScheme(null);
								fb.setWorkCat("");
								fb.setDivCode("");
								fb.setSubDivCode("");
								fb.setProgCode("");
								fb.setSubProgCode("");
								fb.setPhysicalStatus("");
								fb.setPhysicalStatusDetails("");
								session.setAttribute("message", mesg);
								return mapping.findForward(SUCCESS);
							} else {
								fb.setCircleCode(fb.getNwork().substring(4, 6));
								divisions = offices.DivisionCombo(headOfficeCode, fb.getCircleCode());
								session.setAttribute("divs", divisions);
								workCategory = offices.getWorkCategory();
								session.setAttribute("workCategory", workCategory);
								subdivs = offices.SubDivisionCombo(headOfficeCode, fb.getCircleCode(), fb.getDivCode());

								if (subdivs != null) {
									session.setAttribute("subdivs", subdivs);
								}
								programmes = offices.getProgrammes1(fb.getPlan(), fb.getWrktype(), fb.getWorkCat());
								if (programmes.size() != 0) {
									session.setAttribute("programmes", programmes);
									fb.setScheme(null);
								}
								ArrayList worksList = new ArrayList();
								worksList = new RwsWorksDAO().getWorksForWorkProgress(fb, user.getUserId());
								session.removeAttribute("assettypes");
								assettypes = offices.getAssetTypes(fb.getWorkCat(), fb.getPlan());
								if (assettypes != null) {
									session.setAttribute("assettypes", assettypes);
									fb.setScheme(null);
									fb.setProgram("");
								}

								if (worksList != null) {
									session.setAttribute("rwsWorks", worksList);
									fb.setScheme(null);
								}


							}
						}
					}
					rws_works_WorkStatus_form fb1 = dao.getWorkDetails(fb);
					fb.setSchemelist(fb.getWorkId().substring(6, 8));
					String fyear = fb1.getAdminDate();

					String finalSancYear = "";
					int da = Integer.parseInt(fyear.substring(3, 5));
					int ye = Integer.parseInt(fyear.substring(6, 10));
					if (da <= 03)
						finalSancYear = "" + (ye - 1);// +"-"+ye;
					else
						finalSancYear = "" + ye;// +"-"+(ye+1);
					String sancyear = finalSancYear;

					fb.setFinancialyear(sancyear);
					fb.setProgName(fb1.getProgName());
					fb.setSubProgName(fb1.getSubProgName());
					fb.setScheme(fb1.getScheme());
					fb.setSchemeCode(fb1.getSchemeCode());
					fb.setProgCode(fb1.getProgCode());
					fb.setSubProgCode(fb1.getSubProgCode());
					fb.setProgram(fb1.getProgCode());
					fb.setWorkCancelledDate(fb1.getWorkCancelledDate());
					fb.setSamount(fb1.getSamount());
					session.setAttribute("adate", fb1.getAdminDate());
					if (fb.getProgram() != null && !fb.getProgram().equals("") && !workStage.equals("01")) {
						subprogrammes = offices.getSubProgrammes(fb.getProgram());
						session.setAttribute("subprogrammes", subprogrammes);
						fb.setSubprogram(fb1.getSubProgCode());
					} else if (!workStage.equals("01")) {
						session.removeAttribute("subprogrammes");
						fb.setSubprogram("");
					}
					/** TO get the population detials of admin sanction */
					dao = rws_works_factory.createWorksDAO(ds);
					bean = new rws_works_WorkStatus_bean();
					bean = dao.getPopulationDetails(fb.getWorkId(), "RWS_ADMN_HAB_LNK_TBL");
					fb.setAdminPlainPopu(bean.getAdminPlainPopu());
					fb.setAdminScPopu(bean.getAdminScPopu());
					fb.setAdminSTPopu(bean.getAdminSTPopu());
					fb.setAdminTotpopu(bean.getAdminTotpopu());

					/** TO get the population detials of revised admin sanction */
					dao = rws_works_factory.createWorksDAO(ds);
					bean = new rws_works_WorkStatus_bean();
					bean = dao.getPopulationDetails(fb.getWorkId(), "RWS_REV_ADM_SANC_HAB_LNK_TBL");
					fb.setRevPlainPopu(bean.getAdminPlainPopu());
					fb.setRevScPopu(bean.getAdminScPopu());
					fb.setRevSTPopu(bean.getAdminSTPopu());
					fb.setRevTotpopu(bean.getAdminTotpopu());
					session.removeAttribute("expenditureList");
					dao = rws_works_factory.createWorksDAO(ds);
					ArrayList status = dao.getWorkPhysicalStatus(fb.getWorkId());
					fb.setPhysicalStatus("" + status.get(0));
					fb.setPhysicalStatusDetails("" + status.get(1));
					ArrayList reasons = null;
					if (status.get(0).equals("Not Grounded")) {
						reasons = new ArrayList();
						WorksData1 worksData = new WorksData1(ds);
						reasons = worksData.reasonsCombo();
						session.setAttribute("reasons", reasons);

					}
					fb.setReasonCodeNotGround(fb1.getReasonCodeNotGround());
				}
			}
			/** To disaply the detials of admin adn revised sanction */
			if (request.getParameter("mode") != null && request.getParameter("mode").equals("saveCompletionRemarks")) {
				WorksData1 worksData = new WorksData1(ds);
				int inserted = worksData.insertWorksRemarks(fb.getWorkId(), request.getParameter("remarks"));
				if (inserted > 0)
					request.setAttribute("message", "Remarks Saved Successfully");
				else
					request.setAttribute("message", "Failed to Save");
				return mapping.findForward("showMsg");
			}
			if (request.getParameter("mode") != null && request.getParameter("mode").equals("saveNotGroundReason")) {
				 String storedToken = (String)session.getAttribute("csrfToken");
				    String token = request.getParameter("token");
				    if (storedToken.equals(token))
				    {
				WorksData1 worksData = new WorksData1(ds);
				int inserted = worksData.insertNotGroundWorksReason(fb.getWorkId(), fb.getReasonCodeNotGround());
				if (inserted > 0)
					session.setAttribute("message", "Reason Saved Successfully");
				else
					session.setAttribute("message", "Failed to Save");
				return mapping.findForward("success");
				    }
			}
			if (workStage != null && workStage.equals("01")) {
				if (mode.equals("details")) {

					dao = rws_works_factory.createWorksDAO(ds);
					bean = new rws_works_WorkStatus_bean();

					rws_works_WorkStatus_form fb1 = dao.getWorkDetails(fb);
					fb.setProgName(fb1.getProgName());
					fb.setSubProgName(fb1.getSubProgName());
					fb.setScheme(fb1.getScheme());
					fb.setSchemeCode(fb1.getSchemeCode());
					fb.setProgCode(fb1.getProgCode());
					fb.setSubProgCode(fb1.getSubProgCode());
					fb.setProgram(fb1.getProgCode());
					if (fb.getProgram() != null && !fb.getProgram().equals("") && !workStage.equals("01")) {
						subprogrammes = offices.getSubProgrammes(fb.getProgram());
						session.setAttribute("subprogrammes", subprogrammes);
						fb.setSubprogram(fb1.getSubProgCode());
					} else if (!workStage.equals("01")) {
						session.removeAttribute("subprogrammes");
						fb.setSubprogram("");
					}
					/** TO get the population detials of admin sanction */
					dao = rws_works_factory.createWorksDAO(ds);
					bean = new rws_works_WorkStatus_bean();
					bean = dao.getPopulationDetails(fb.getWorkId(), "RWS_ADMN_HAB_LNK_TBL");
					fb.setAdminPlainPopu(bean.getAdminPlainPopu());
					fb.setAdminScPopu(bean.getAdminScPopu());
					fb.setAdminSTPopu(bean.getAdminSTPopu());
					fb.setAdminTotpopu(bean.getAdminTotpopu());

					/** TO get the population detials of revised admin sanction */
					dao = rws_works_factory.createWorksDAO(ds);
					bean = new rws_works_WorkStatus_bean();
					bean = dao.getPopulationDetails(fb.getWorkId(), "RWS_REV_ADM_SANC_HAB_LNK_TBL");
					fb.setRevPlainPopu(bean.getAdminPlainPopu());
					fb.setRevScPopu(bean.getAdminScPopu());
					fb.setRevSTPopu(bean.getAdminSTPopu());
					fb.setRevTotpopu(bean.getAdminTotpopu());
				}

				dao = rws_works_factory.createWorksDAO(ds);
				rws_works_WorkStatus_form fb1 = dao.getAdminAndRevisedDetails(fb.getWorkId());
				fb.setAdminAmnt(fb1.getAdminAmnt());
				fb.setAdminDate(fb1.getAdminDate());
				fb.setAdminHabsBen(fb1.getAdminHabsBen());
				fb.setAdminNo(fb1.getAdminNo());
				fb.setRevAdminAmnt(fb1.getRevAdminAmnt());
				fb.setRevAdminDate(fb1.getRevAdminDate());
				fb.setRevAdminHabsBen(fb1.getRevAdminHabsBen());
				fb.setRevAdminNo(fb1.getRevAdminNo());
				request.setAttribute("Includepage", workStage);

				dao = rws_works_factory.createWorksDAO(ds);
				bean = new rws_works_WorkStatus_bean();
				ArrayList adminProg = dao.getAdminMoreThanOneProg(fb.getWorkId(), bean);
				if (adminProg != null)
					request.setAttribute("adminProg", adminProg);

				dao = rws_works_factory.createWorksDAO(ds);
				ArrayList revAdminProg = dao.getRevAdminMoreThanOneProg(fb.getWorkId(), bean);
				if (adminProg != null)
					request.setAttribute("revAdminProg", revAdminProg);

				return mapping.findForward(SUCCESS);
			}

			if (mode.equals("admnHabs")) {
				dao = rws_works_factory.createWorksDAO(ds);
				String code = fb.getWorkId().substring(6, 8);

				String tname = "";
				if (!(code.equals("11") || code.equals("12")|| code.equals("13")|| code.equals("14"))) {
					tname = "RWS_ADMN_HAB_LNK_TBL";
				} else if (code.equals("11")) {
					tname = "RWS_WORK_SCHOOL_LNK_TBL";
				} else if (code.equals("12")) {
					tname = "RWS_WORK_LAB_LNK_TBL";
				}else if (code.equals("14")) {
					tname = "RWS_WORK_PI_LNK_TBL";
				}
				else if (code.equals("13")) {
					tname = "rws_work_anganwadi_lnk_tbl";
				}
				ArrayList selectedHabCodes = dao.getAdminHabs(fb.getWorkId(), tname);
				if (selectedHabCodes != null)
					request.setAttribute("selectedHabs", selectedHabCodes);
				if (!(code.equals("11") || code.equals("12")|| code.equals("13")|| code.equals("14"))) {
					SUCCESS = "adminHabs";
				} else if (code.equals("11")) {
					SUCCESS = "adminSchools";
				} else if (code.equals("12")) {
					SUCCESS = "adminLabs";
				}else if (code.equals("14")) {
					SUCCESS = "adminPis";
				}
				else if (code.equals("13")) {
					//System.out.println("@@@@@@@@@@");
					SUCCESS = "adminAnganwadis";
				}

			}

			/** To get the habitaions view from revised sanction */
			if (mode.equals("revAdmnHabs")) {

				dao = rws_works_factory.createWorksDAO(ds);
				String code = fb.getWorkId().substring(6, 8);

				String tname = "";
				if (!(code.equals("11") || code.equals("12")|| code.equals("13")|| code.equals("14"))) {
					tname = "RWS_REV_ADM_SANC_HAB_LNK_TBL";
				} else if (code.equals("11")) {
					tname = " RWS_REV_SCHOOL_LNK_TBL";
				} else if (code.equals("12")) {
					tname = " RWS_REV_LAB_LNK_TBL";
				}else if (code.equals("14")) {
					tname = "RWS_WORK_PI_LNK_TBL";
				}
				else if (code.equals("13")) {
					tname = "rws_work_anganwadi_lnk_tbl";
				}
				ArrayList selectedHabCodes = dao.getAdminHabs(fb.getWorkId(), tname);
				if (selectedHabCodes != null)
					request.setAttribute("selectedHabs", selectedHabCodes);
				if (!(code.equals("11") || code.equals("12")|| code.equals("13") || code.equals("14"))) {
					SUCCESS = "adminHabs";
				} else if (code.equals("11")) {
					SUCCESS = "adminSchools";
				} else if (code.equals("12")) {
					SUCCESS = "adminLabs";
				} else if (code.equals("14")) {
					SUCCESS = "adminPis";
				}
				else if (code.equals("13")) {
					//System.out.println("@@@@@@@@@@");
					SUCCESS = "adminAnganwadis";
				}
			}

			/** To get the habitaions view from revised sanction */
			if (mode.equals("tsHabs")) {
				String code1 = fb.getWorkId().substring(6, 8);

				dao = rws_works_factory.createWorksDAO(ds);
				ArrayList selectedHabCodes = dao.getTsHabsDetails(fb.getWorkId());
				if (selectedHabCodes != null)
					request.setAttribute("selectedHabs", selectedHabCodes);

				if (!(code1.equals("11") || code1.equals("12")|| code1.equals("13") || code1.equals("14"))) {

					SUCCESS = "adminHabs";
				} else if (code1.equals("11")) {

					SUCCESS = "adminSchools";
				} else if (code1.equals("12")) {
					SUCCESS = "adminLabs";
				}else if (code1.equals("14")) {
					SUCCESS = "adminPis";
				}
					else if (code1.equals("13")) {
					
					SUCCESS = "adminAnganwadis";
				}
			}
			if (mode.equals("saveHabFHTC")) {
				String storedToken = (String)session.getAttribute("csrfToken");
			    String token = request.getParameter("token");
			    if (storedToken.equals(token))
			    {
				ArrayList vouchers = new ArrayList();
				vouchers = (ArrayList) fb.getSelectedHabs();
				String removes[] = request.getParameterValues("remove");
				Collection remove = new ArrayList();
				for (int i = 0; i < removes.length; i++) {
					remove.add(removes[i]);
				}
				WorksData1 worksData = new WorksData1(ds);
				String value = worksData.saveFHTCHab(vouchers,  remove);
				request.setAttribute("message", value);
				mode = "compShowHabs";
			    }
			}
			if (mode.equals("compShowHabs")) {
				String code2 = fb.getWorkId().substring(6, 8);

				dao = rws_works_factory.createWorksDAO(ds);
				WorksData1 worksData = new WorksData1(ds);
				rws_works_WorkStatus_form worksBean = worksData.getWorksCompletionData(getDataSource(request),
						fb.getWorkId());

				ArrayList selectedHabCodes = new ArrayList();
				if (worksBean.getWorkCompDateCompleted() != null && !worksBean.getWorkCompDateCompleted().equals(""))
					selectedHabCodes = dao.getCompHabsDetails(fb.getWorkId());
				else
					selectedHabCodes = dao.getTsHabsDetails(fb.getWorkId());
				if (selectedHabCodes != null){
					request.setAttribute("selectedHabs", selectedHabCodes);
					fb.setSelectedHabs(selectedHabCodes);
				}
				if (!(code2.equals("11") || code2.equals("12")|| code2.equals("13") || code2.equals("14"))) {

					SUCCESS = "compHabs";
				} else if (code2.equals("11")) {

					SUCCESS = "adminSchools";
				} else if (code2.equals("12")) {

					SUCCESS = "adminLabs";
				} else if (code2.equals("14")) {

					SUCCESS = "adminPis";
				}
				else if (code2.equals("13")) {
					//System.out.println("@@@@@@@@@@");
					SUCCESS = "adminAnganwadis";
				}
			}
			if (mode.equals("revTsHabs")) {
				dao = rws_works_factory.createWorksDAO(ds);
				ArrayList selectedHabCodes = dao.getHabsDetails((ArrayList) session.getAttribute("SanctionedRevHabs"));
				if (selectedHabCodes != null)
					request.setAttribute("selectedHabs", selectedHabCodes);
				SUCCESS = "adminHabs";
			}
			/**
			 * ----------------------------------------------Technical Sanction
			 * Detials-----------------------------------------
			 */
			/** To display the detials of technical sanction */
			if (workStage != null && workStage.equals("02")) {
				request.setAttribute("Includepage", workStage);
				/** Revised Technical Sanction Detials */
				if (fb.getRevTsMode() != null && fb.getRevTsMode().equals("Delete")) {
					dao = rws_works_factory.createWorksDAO(ds);
					DAOMessage daoMessage = dao.delRevTsDetails(fb.getWorkId());
					if (daoMessage.isOperationSussess()) {
						request.setAttribute("message", daoMessage.getMessage());
						fb.setTsMode("data");
						fb.setRevTsMode("data");
					} else
						request.setAttribute("message", daoMessage.getMessage());
				}
				int revSwitch = 0;
				dao = rws_works_factory.createWorksDAO(ds);
				boolean Status = dao.chkRevTsDetails(fb.getWorkId());
				if (Status == true)
					revSwitch = 1;

				if (fb.getRevTsMode() != null && fb.getRevTsMode().equals("addNewRevTsApproval")) {
					
					rws_works_WorkStatus_bean revTsBean = null;
					ArrayList revTsBeans = new ArrayList(20);
					int noOfRevTechnicalApprovals = 0;
					if (request.getParameter("noOfRevTechnicalApprovals") == null)
						noOfRevTechnicalApprovals = 5;
					else
						noOfRevTechnicalApprovals = Integer.parseInt(request.getParameter("noOfRevTechnicalApprovals"));

					for (int i = 0; i < noOfRevTechnicalApprovals; i++) {

						revTsBean = new rws_works_WorkStatus_bean();
						revTsBean.setRevTsAmnt(request.getParameter("revTsSanction[" + i + "].revTsAmnt"));
						revTsBean.setRevTsNo(request.getParameter("revTsSanction[" + i + "].revTsNo"));
						revTsBean.setRevTsDate(request.getParameter("revTsSanction[" + i + "].revTsDate"));
						revTsBean.setSyr1(request.getParameter("revTsSanction[" + i + "].syr1"));
						revTsBeans.add(revTsBean);

					}
					revTsBeans.add(new rws_works_WorkStatus_bean());
					request.setAttribute("RevTs", revTsBeans);
					
				}
				if (fb.getRevTsMode() != null && fb.getRevTsMode().equals("Save")) {

					 String storedToken = (String)session.getAttribute("csrfToken");
					    String token = request.getParameter("token");
					    if (storedToken.equals(token))
					    {
					ArrayList revTsAmnt = new ArrayList();
					ArrayList revTsDate = new ArrayList();
					ArrayList revTsNo = new ArrayList();
					ArrayList revTsSsryear = new ArrayList();
					rws_works_WorkStatus_bean revTsBean = null;
					ArrayList revTsBeans = new ArrayList();
					int noOfRevTechnicalApprovals = 0;
					if (request.getParameter("noOfRevTechnicalApprovals") == null)
						noOfRevTechnicalApprovals = 1;
					else
						noOfRevTechnicalApprovals = Integer.parseInt(request.getParameter("noOfRevTechnicalApprovals"));

					for (int i = 0; i < noOfRevTechnicalApprovals; i++) {

						revTsBean = new rws_works_WorkStatus_bean();
						revTsBean.setRevTsAmnt(request.getParameter("revTsSanction[" + i + "].revTsAmnt"));
						revTsBean.setRevTsNo(request.getParameter("revTsSanction[" + i + "].revTsNo"));
						revTsBean.setRevTsDate(request.getParameter("revTsSanction[" + i + "].revTsDate"));
						revTsBean.setSyr1(request.getParameter("revTsSanction[" + i + "].syr1"));
						revTsBeans.add(revTsBean);

					}

					bean = new rws_works_WorkStatus_bean();
					dao = rws_works_factory.createWorksDAO(ds);
					String status = dao.insertRevTsDetails(revTsBeans,
							(ArrayList) session.getAttribute("SanctionedRevHabs"), fb);

					if (status != null && status.equals("true")) {
						request.setAttribute("message", "Saved Successfully");
						fb.setTsMode("data");
						fb.setRevTsMode("data");
						revSwitch = 1;

					} else
						request.setAttribute("message", "Failed to save");
					    }
				}
				if (fb.getRevTsMode() != null && fb.getRevTsMode().equals("data")) {

					ArrayList revTsDetails = new ArrayList(20);
					if (revSwitch == 0) {
						bean = new rws_works_WorkStatus_bean();
						bean = new rws_works_WorkStatus_bean();
						revTsDetails.add(bean);

						dao = rws_works_factory.createWorksDAO(ds);
						bean = dao.getPopulationDetails(fb.getWorkId(), " RWS_EST_NEW_HAB_LNK_TBL ");
						fb.setRevTsPlainPopu(bean.getAdminPlainPopu());
						fb.setRevTsScPopu(bean.getAdminScPopu());
						fb.setRevTsSTPopu(bean.getAdminSTPopu());
						fb.setRevTsTotpopu(bean.getAdminTotpopu());
						fb.setRevTsHabsBen(bean.getRevTsNoOfHabs());
						dao = rws_works_factory.createWorksDAO(ds);
						ArrayList revhabs = dao.getTshabs(fb.getWorkId());
						session.setAttribute("SanctionedRevHabs", revhabs);
					}
					if (revSwitch == 1) {
						dao = rws_works_factory.createWorksDAO(ds);
						revTsDetails = dao.getRevTsDetails(fb.getWorkId());
						if (revTsDetails.size() == 0) {
							revTsDetails.add(new rws_works_WorkStatus_bean());
						}
						request.setAttribute("RevTs", revTsDetails);
						request.setAttribute("REVTSDELTE", "YES");
						dao = rws_works_factory.createWorksDAO(ds);
						ArrayList revhabs = dao.getRevTsHabs(fb.getWorkId());
						if (revhabs != null) {

							session.setAttribute("SanctionedRevHabs", revhabs);
							fb.setRevTsHabsBen(revhabs.size() + "");
						}
						bean = new rws_works_WorkStatus_bean();
						dao = rws_works_factory.createWorksDAO(ds);
						bean = dao.getPopulationDetails(fb.getWorkId(), " RWS_REV_EST_NEW_HAB_LNK_TBL ");
						fb.setRevTsPlainPopu(bean.getAdminPlainPopu());
						fb.setRevTsScPopu(bean.getAdminScPopu());
						fb.setRevTsSTPopu(bean.getAdminSTPopu());
						fb.setRevTsTotpopu(bean.getAdminTotpopu());
					}
					request.setAttribute("RevTs", revTsDetails);
				}

				String workAssignedTo = null;

				fb.setTsOffice(headOfficeCode + fb.getCircleCode() + fb.getDivCode());
				if (fb.getSubDivCode() != null)
					fb.setTsOffice(fb.getTsOffice() + fb.getSubDivCode());
				/** To save the tecnical Sanction Details */
				if (fb.getTsMode() != null && fb.getTsMode().equals("save")) {
					String storedToken = (String)session.getAttribute("csrfToken");
				    String token = request.getParameter("token");
				    if (storedToken.equals(token))
				    {
					dao = rws_works_factory.createWorksDAO(ds);
					bean = new rws_works_WorkStatus_bean();

					String status = dao.insertTsDetails(fb, (ArrayList) session.getAttribute("SanctionedHabs"));
					request.setAttribute("habitations", request.getAttribute("habitations"));
					if (status != null && status.equals("true")) {
						request.setAttribute("message", "Saved Successfully");
						fb.setTsMode("data");
					} else
						request.setAttribute("message", "Failed to save");

					dao = rws_works_factory.createWorksDAO(ds);
					bean = dao.getPopulationDetails(fb.getWorkId(), " RWS_EST_NEW_HAB_LNK_TBL ");
					fb.setRevTsPlainPopu(bean.getAdminPlainPopu());
					fb.setRevTsScPopu(bean.getAdminScPopu());
					fb.setRevTsSTPopu(bean.getAdminSTPopu());
					fb.setRevTsTotpopu(bean.getAdminTotpopu());
					fb.setRevTsHabsBen(bean.getRevTsNoOfHabs());
					dao = rws_works_factory.createWorksDAO(ds);
					ArrayList revhabs = dao.getTshabs(fb.getWorkId());
					session.setAttribute("SanctionedRevHabs", revhabs);
				    }
				}
				if (fb.getTsMode() != null && fb.getTsMode().equals("Update")) {

					 String storedToken = (String)session.getAttribute("csrfToken");
					    String token = request.getParameter("token");
					    if (storedToken.equals(token))
					    {
					dao = rws_works_factory.createWorksDAO(ds);
					bean = new rws_works_WorkStatus_bean();

					String status = dao.updateTsDetails(fb, (ArrayList) session.getAttribute("SanctionedHabs"));
					if (status != null && status.equals("true")) {
						request.setAttribute("message", "Updated Successfully");
						fb.setTsMode("data");
					} else
						request.setAttribute("message", "Failed to Update");
					    }

				}
				if (fb.getTsMode() != null && fb.getTsMode().equals("Delete")) {

					dao = rws_works_factory.createWorksDAO(ds);
					DAOMessage daoMessage = dao.delTsDetails(fb.getWorkId());

					if (daoMessage.isOperationSussess()) {
						request.setAttribute("message", daoMessage.getMessage());
						fb.setTsMode("data");
					} else {
						fb.setTsMode("data");
						request.setAttribute("message", daoMessage.getMessage());
					}
				}

				if (fb.getTsMode() != null && fb.getTsMode().equals("data")) {

					fb.setRevTsMode("data");

					fb.setTsAccBy("");
					fb.setTsAmnt("");
					fb.setTsDate("");
					fb.setTsNo("");
					/** Tecnical sanction */
					fb.setTsPlainPop(fb.getAdminPlainPopu());

					fb.setTsScPop(fb.getAdminScPopu());
					fb.setTsStPop(fb.getAdminSTPopu());
					fb.setTsTotPop(fb.getAdminTotpopu());

					mb = dao.chkMilestoneBillDetails(fb.getWorkId());
					String mbvalue = "";
					if (mb == false) {
						mbvalue = "Disable";
					} else {
						mbvalue = "enable";
					}

					session.setAttribute("mbvalue", mbvalue);

					ArrayList SanctionedHabs = (ArrayList) session.getAttribute("SanctionedHabs");
					if (SanctionedHabs == null) {
						dao = rws_works_factory.createWorksDAO(ds);
						SanctionedHabs = dao.getAdminSanctionedHabs(fb.getWorkId());
						session.setAttribute("SanctionedHabs", SanctionedHabs);
					}

					/** Trying to get the details of ts already saved details */
					dao = rws_works_factory.createWorksDAO(ds);

					bean = dao.getTsDetails(fb.getWorkId());

					if (bean != null) {

						fb.setTsAccBy(bean.getTsAccBy());
						fb.setTsAmnt(bean.getTsAmnt());
						fb.setTsDate(bean.getTsDate());
						fb.setTsNo(bean.getTsNo());
						fb.setSyr(bean.getSyr());
						dao = rws_works_factory.createWorksDAO(ds);
						rws_works_WorkStatus_bean beanNew = new rws_works_WorkStatus_bean();

						beanNew = dao.getPopulationDetails(fb.getWorkId(), " RWS_EST_NEW_HAB_LNK_TBL ");
						/** Tecnical sanction */
						fb.setTsPlainPop(beanNew.getAdminPlainPopu());
						fb.setTsScPop(beanNew.getAdminScPopu());
						fb.setTsStPop(beanNew.getAdminSTPopu());
						fb.setTsTotPop(beanNew.getAdminTotpopu());

						try {
							if (bean.getTsOffice() != null || !bean.getTsOffice().equals("")) {

								if (bean.getTsOffice().length() > 4)
									fb.setSubDivCode(bean.getTsOffice().substring(4, 6));
							}
						} catch (Exception e) {
							Debug.println("Exception in rws_work_WorkStatus_Act::::" + e);
						}
						/** Admin Details */
						dao = rws_works_factory.createWorksDAO(ds);
						rws_works_WorkStatus_form fb1 = dao.getAdminAndRevisedDetails(fb.getWorkId());

						fb.setAdminNo(fb1.getAdminNo());
						fb.setAdminDate(fb1.getAdminDate());
						workAssignedTo = fb1.getOfficeCode();

						long adminSancAmnt = (int) (Float.parseFloat(fb1.getAdminAmnt()) * 100000);
						/** To get the other grants amount for the same work */
						dao = rws_works_factory.createWorksDAO(ds);
						adminSancAmnt = adminSancAmnt + dao.getAdminOtherGrantsAmnt(fb.getWorkId());
						fb.setAdminAmnt(adminSancAmnt / 100000.00 + "");

						dao = rws_works_factory.createWorksDAO(ds);
						SanctionedHabs = dao.getTshabs(fb.getWorkId());
						if (SanctionedHabs != null) {
							session.setAttribute("SanctionedHabs", SanctionedHabs);
							fb.setTsHabsBen(Integer.toString(SanctionedHabs.size()));
							request.setAttribute("UPDATE", "TS-DETAILS");
						}
					}

					else {
						/** To get the details of technical Sanction accored by */

						dao = rws_works_factory.createWorksDAO(ds);
						rws_works_WorkStatus_form fb1 = dao.getAdminAndRevisedDetails(fb.getWorkId());

						if (fb1.getAdminAmnt() != null) {
							long adminSancAmnt = (long) (Float.parseFloat(fb1.getAdminAmnt()) * 100000);
							/** To get the other grants amount for the same work */
							dao = rws_works_factory.createWorksDAO(ds);
							adminSancAmnt = adminSancAmnt + dao.getAdminOtherGrantsAmnt(fb.getWorkId());
							/**
							 * To get the details of technical Sanction accored by
							 */
							dao = rws_works_factory.createWorksDAO(ds);
							String tcAccbY = dao.getTsAccordedBy(Long.toString(adminSancAmnt));
							/**
							 * To give the information abt admin sanction in tecnical snaction
							 */

							dao = rws_works_factory.createWorksDAO(ds);
							rws_works_WorkStatus_form fb2 = dao.getAdminAndRevisedDetails(fb.getWorkId());

							fb.setAdminAmnt(adminSancAmnt / 100000.00 + "");

							fb.setAdminNo(fb2.getAdminNo());
							fb.setAdminDate(fb2.getAdminDate());
							fb.setTsHabsBen(fb2.getAdminHabsBen());
							fb.setTsAmnt(fb.getAdminAmnt());
							workAssignedTo = fb2.getOfficeCode();

							/** To show the list of habitions to add or remove */
							dao = rws_works_factory.createWorksDAO(ds);
							SanctionedHabs = dao.getAdminSanctionedHabs(fb.getWorkId());
							if (SanctionedHabs != null) {
								session.setAttribute("SanctionedHabs", SanctionedHabs);

							}
							fb.setTsAccBy(tcAccbY);

						}
					}
					if (fb.getTsAccBy().equals("AEE") || fb.getTsAccBy().equals("DEE")) {
						ArrayList SubDivs = offices.SubDivisionCombo(headOfficeCode, workAssignedTo.substring(1, 3),
								workAssignedTo.substring(3, 4));
						if (SubDivs != null)
							request.setAttribute("SubDivs", SubDivs);
					}
					if (fb.getTsAccBy().equals("EE")) {
						String Divs = offices.getDivisionOfficeName(ds, headOfficeCode, workAssignedTo.substring(1, 3),
								workAssignedTo.substring(3, 4));
						if (Divs != null)
							request.setAttribute("officeName", Divs);
					}
					if (fb.getTsAccBy().equals("SE")) {
						String cirlceName = offices.getCircleOfficeName(ds, headOfficeCode,
								workAssignedTo.substring(1, 3));
						if (cirlceName != null)
							request.setAttribute("officeName", cirlceName);
					}
					request.setAttribute("Includepage", workStage);
				}

			}

			/**
			 * ---------------------------------------------END of Technical
			 * Sanction-------------------------------------------
			 */

			/**
			 * ---------------------------------------------SOURCE
			 * IDENTIFICATION-------------------------------------------
			 */

			if (workStage != null && workStage.equals("03")) {
				fb.setSchemeCode(fb.getWorkId().substring(6, 8));
				request.setAttribute("assetCodee", fb.getSchemeCode());
				String srcCode = "";
				ArrayList mandalCode = null;
				ArrayList scTypes = null;
				ArrayList srcCodes = new ArrayList();
				ArrayList siteHab1 = null;
				WorksData1 worksData = new WorksData1(ds);
				String subcompcode = fb.getSubcompType() + fb.getSubSourceType();
				String sourceType = fb.getSchemeCode() + "01" + subcompcode;
				try {
					if (fb.getSiMode() != null && fb.getSiMode().equals("data")) {
						dao = rws_works_factory.createWorksDAO(ds);
						bean = dao.getTsDetails(fb.getWorkId());
						user = new RwsUser();
						String officeCode = user.getOfficeCode();
						mandalCode = worksData.getMandals(ds, fb.getCircleCode());
						session.setAttribute("mandalCode", mandalCode);
						WorksMonitoringActionBean beans = worksData.SrcIdenRetrieve(ds, officeCode, fb.getSchemeCode(),
								fb.getWorkId());
						if (!beans.getSrcCode().equals("")) {
							scTypes = worksData.SubCompType(ds, fb.getSchemeCode());
							session.setAttribute("scTypes", scTypes);
							siteHab1 = worksData.SiteHab1(ds, fb.getCircleCode(), fb.getDivCode(), fb.getSubDivCode(),
									beans.getMandalCode());
							session.setAttribute("siteHab1", siteHab1);
							fb.setMandalCode(beans.getMandalCode());
							fb.setSitehab(beans.getSitehab());
							fb.setSubcompType(beans.getSubcompType());
							fb.setSubSourceType(beans.getSubSourceType());
							fb.setSrcCode(beans.getSrcCode() + "-" + beans.getSrcName());
							fb.setSrcName(beans.getSrcName());
							fb.setNewsrcCode(beans.getNewsrcCode() + "-" + beans.getNewsrcName());
							fb.setNewsrcName(beans.getNewsrcName());
							fb.setSiteHODate(beans.getSiteHODate());
							
							fb.setSrcIdby(beans.getSrcIdby());
							fb.setRecommend(beans.getRecommend());
							fb.setSpradgroup("existSrc");
							sourceType = fb.getSchemeCode() + "01" + beans.getSubcompType() + beans.getSubSourceType();
							
							srcCodes = worksData.getSourceCodes(ds, sourceType, beans.getSitehab());
							session.setAttribute("srcCodes", srcCodes);
							ArrayList subSources = worksData.getSubSourceTypes(ds, beans.getSubcompType(),
									fb.getSchemeCode());
							session.setAttribute("subSources", subSources);
						} else {
							session.removeAttribute("scTypes");
							session.removeAttribute("siteHab1");
							session.removeAttribute("scTypes");
							session.removeAttribute("srcCodes");
							session.removeAttribute("subSources");

							fb.setCodeStatus("");
							fb.setMandalCode("");
							fb.setSitehab("");
							fb.setSubcompType("");
							fb.setSubSourceType("");
							fb.setSpradgroup("");
							fb.setSrcCode("");
							fb.setSrcName("");
							fb.setNewsrcCode("");
							fb.setNewsrcName("");
							fb.setSrcIdby("");
							fb.setSiteHODate("");
							fb.setRecommend("");
							session.removeAttribute("srcCodes");
						}
					} else if (fb.getSiMode() != null && fb.getSiMode().equals("mandals")) {
						siteHab1 = worksData.SiteHab1(ds, fb.getCircleCode(), fb.getDivCode(), fb.getSubDivCode(),
								fb.getMandalCode());
						session.setAttribute("siteHab1", siteHab1);
						session.removeAttribute("subSources");
						session.removeAttribute("scTypes");
						session.removeAttribute("srcCodes");
						fb.setSrcCode("");
						fb.setSpradgroup("");
						fb.setSrcName("");
						fb.setNewsrcCode("");
						fb.setNewsrcName("");
					} else if (fb.getSiMode() != null && fb.getSiMode().equals("source")) {
						scTypes = worksData.SubCompType(ds, fb.getSchemeCode());
						session.setAttribute("scTypes", scTypes);
						session.removeAttribute("subSources");
						session.removeAttribute("srcCodes");
						fb.setSubcompType("");
						fb.setSrcCode("");
						fb.setSrcName("");
						fb.setNewsrcCode("");
						fb.setNewsrcName("");
						fb.setSpradgroup("");
					} else if (fb.getSiMode() != null && fb.getSiMode().equals("sourceType")) {
						ArrayList subSources = worksData.getSubSourceTypes(ds, fb.getSubcompType(), fb.getSchemeCode());
						session.setAttribute("subSources", subSources);
						session.removeAttribute("srcCodes");
						fb.setSubSourceType("");
						fb.setSpradgroup("");
						fb.setSrcCode("");
						fb.setSrcName("");
						fb.setNewsrcCode("");
						fb.setNewsrcName("");
					} else if (fb.getSiMode() != null && fb.getSiMode().equals("sources")) {
						session.removeAttribute("srcCodes");
						fb.setSpradgroup("");
						fb.setSrcCode("");
						fb.setSrcName("");
						fb.setNewsrcCode("");
						fb.setNewsrcName("");
					} else if (request.getParameter("spradgroup") != null
							&& request.getParameter("spradgroup").equals("existSrc")
							&& fb.getSiMode().equals("existNew") && !fb.getSiMode().equals("save")
							&& !fb.getSiMode().equals("delete")) {
						
						srcCodes = worksData.getSourceCodes(ds, sourceType, fb.getSitehab());
						session.setAttribute("srcCodes", srcCodes);
						request.setAttribute("spradgroup", "existSrc");
					} else if (request.getParameter("spradgroup") != null
							&& request.getParameter("spradgroup").equals("newSrc") && fb.getSiMode().equals("existNew")
							&& !fb.getSiMode().equals("save") && !fb.getSiMode().equals("delete")) {
						srcCode = worksData.getSourceCode(ds, sourceType, fb.getSitehab(), fb.getWorkId());
						if (srcCode.length() == 24) {
							fb.setNewsrcCode(srcCode);
							request.setAttribute("spradgroup", "newSrc");
						} else
							fb.setNewsrcCode("");
					} else if (fb.getSiMode() != null && fb.getSiMode().equals("save")) {
						 String storedToken = (String)session.getAttribute("csrfToken");
						    String token = request.getParameter("token");
						    if (storedToken.equals(token))
						    {
						request.setAttribute("spradgroup", request.getParameter("spradgroup"));
						int i = worksData.SrcIdenInsert(ds, fb, user.getOfficeCode());
						if (i == 1) {
							fb.setCodeStatus("existCode");
							request.setAttribute("message", "Inserted Successfully");
						} else if (i == 2) {
							fb.setCodeStatus("existCode");
							request.setAttribute("message", "Updated Successfully");
						} else {
							request.setAttribute("message", "Insertion Failed");
						}
						    }
					} else if (fb.getSiMode() != null && fb.getSiMode().equals("delete")) {
						user = new RwsUser();
						int i = worksData.SrcIdenDelete(ds, user.getOfficeCode(), fb);
						if (i > 0) {
							request.setAttribute("message", "Deleted Successfully");
							session.removeAttribute("scTypes");
							session.removeAttribute("siteHab1");
							session.removeAttribute("scTypes");
							session.removeAttribute("srcCodes");
							session.removeAttribute("subSources");
							fb.setSitehab("");
							fb.setSubcompType("");
							fb.setSpradgroup("");
							fb.setSrcCode("");
							fb.setSrcName("");
							fb.setNewsrcCode("");
							fb.setNewsrcName("");
							fb.setSrcIdby("");
							fb.setSiteHODate("");
							fb.setRecommend("");
							fb.setMandalCode("");
							session.removeAttribute("srcCodes");
						} else if (i == -2) {
							request.setAttribute("message",
									"Data Exists in Other Work Stages! Record Cannot be Deleted!!");
						} else if (i == -1) {
							request.setAttribute("message", "Deletion Failed");
						}
						request.setAttribute("spradgroup", request.getParameter("spradgroup"));
					}
				} catch (Exception e) {
					e.printStackTrace();
					Debug.println("Exception in source Identification:" + e.getMessage());
				}
				request.setAttribute("Includepage", workStage);
			}

			/**
			 * --------------------------------------------- END of SOURCE
			 * IDENTIFICATION-------------------------------------------
			 */

			/**
			 * ------------------------------------------------PROGRAM
			 * SCHEDULE-------------------------------------------------------
			 */

			if (workStage != null && workStage.equals("05")) {
				fb.setPartASanAMount(new RwsWorksDAO().getPartAAMount(fb.getWorkId()));
				WorksData1 worksData = new WorksData1(ds);
				ArrayList employeesRecBy = worksData.getEmployees(fb.getWorkId().substring(4, 6), 5, 9);
				session.setAttribute("engAssignedBy", employeesRecBy);
				request.setAttribute("billRaisedAmt", worksData.getBillAmount(fb.getWorkId()));
				request.setAttribute("billContractorAmt", worksData.getBillAmountCon(fb.getWorkId()));
				dao = rws_works_factory.createWorksDAO(ds);
				rws_works_WorkStatus_form frm = dao.getAdminAndRevisedDetails(fb.getWorkId());
				fb.setRevAdminAmnt(frm.getRevAdminAmnt());

				WorksMonitoringActionBean worksBean = null;
				RwsOffices of = new RwsOffices(getDataSource(request));
				ArrayList subDivs = of.SubDivisionCombo("1", fb.getCircleCode(), fb.getDivCode());
				request.setAttribute("subDivisions", subDivs);
				try {
					if (fb.getPsMode() != null && fb.getPsMode().equals("save")) {
						 String storedToken = (String)session.getAttribute("csrfToken");
						    String token = request.getParameter("token");
						    if (storedToken.equals(token))
						    {
						    	System.out.println("inside psmode");
						worksBean = new WorksMonitoringActionBean();
						user = new RwsUser();
						user = (RwsUser) session.getAttribute("RWS_USER");
						ArrayList programMileStones = new ArrayList();
						programMileStones = worksData.getProgramMileStones(getDataSource(request), fb.getWorkId());
						fb.setMileStones(programMileStones);
						programMileStones = fb.getMileStones();
						int staus = worksData.saveProgramScheduleDetails(getDataSource(request), fb, user,
								programMileStones);
						for (int i = 0; i < programMileStones.size(); i++) {
							String milestone = request.getParameter("WORK[" + i + "].mstoneCode");
							String perComp = request.getParameter("WORK[" + i + "].percentComp");
							String majorMileStone = request.getParameter("WORK[" + i + "].majorMileStone");
							String mileStagestone = request.getParameter("WORK[" + i + "].mstoneStageCode");
							String achDate = request.getParameter("WORK[" + i + "].achievementDate");
							String mileStoneSno = request.getParameter("WORK[" + i + "].mileStoneSno");
							String pStage = request.getParameter("WORK[" + i + "].mileStoneProgress");
							String compNoAch = request.getParameter("WORK[" + i + "].compInNoAch");
							String perCompValue = request.getParameter("WORK[" + i + "].perCompValue");
							worksData.saveMileStonesForProg(getDataSource(request), milestone, mileStagestone, achDate,
									fb.getWorkId(), perComp, majorMileStone, mileStoneSno, pStage, compNoAch,
									perCompValue);
						}
						programMileStones = worksData.getProgramMileStones(getDataSource(request), fb.getWorkId());
						fb.setMileStones(programMileStones);
						if (staus == 1) {
							request.setAttribute("message", "Saved Sucessfully");
							session.setAttribute("savePs", "Y");
							fb.setRevflag("");
						} else if (staus == 2) {
							request.setAttribute("message", "Updated Sucessfully");
							fb.setRevflag("");
						} else {
							request.setAttribute("message", "Failed to save");
							fb.setRevflag("");
						}
						fb.setPsMode("data");
						    }
					}
					if (fb.getPsMode() != null && fb.getPsMode().equals("data")) {
						dao = rws_works_factory.createWorksDAO(ds);
						if (!fb.getWorkCat().equals("3")) {
							bean = dao.getContractorDetails(fb.getWorkId());
							if (bean != null) {
								session.setAttribute("contractorStatus", "yes");
							} else {
								request.setAttribute("openStatus", "N");
								request.setAttribute("message",
										"This work not yet having Contractor Management Details");
								session.removeAttribute("contractorStatus");
							}
						} else {
							session.setAttribute("contractorStatus", "yes");
						}
						worksBean = new WorksMonitoringActionBean();
						ArrayList programMileStones = new ArrayList();
						String amt = "0";
						programMileStones = worksData.getProgramMileStones(getDataSource(request), fb.getWorkId());
						fb.setMileStones(programMileStones);
						worksBean = worksData.getProgramScheduleDetails(getDataSource(request), fb.getWorkId());
						dao = rws_works_factory.createWorksDAO(ds);
						rws_works_WorkStatus_bean fb1 = dao.getTsDetails(fb.getWorkId());
						if (fb1 != null)
							fb.setTsDate(fb1.getTsDate());
						else
							fb.setTsDate("");
						if (worksBean != null) {
							fb.setSubDivAssign(worksBean.getSubDivAssign());
							fb.setEngineerAssign(worksBean.getEngineerAssign());
							fb.setEngineerAssign1(worksBean.getEngineerAssign1());
							fb.setEngineerAssign2(worksBean.getEngineerAssign2());
							fb.setEngineerAssign3(worksBean.getEngineerAssign3());
							fb.setWorkGndDate(worksBean.getWorkGndDate());
							fb.setAgreeDate(worksBean.getAgreeDate());
						} else if (worksBean == null) {
							fb.setWorkGndDate("");
							fb.setEngineerAssign("");
							fb.setEngineerAssign1("");
							fb.setEngineerAssign2("");
							fb.setEngineerAssign3("");
							fb.setSubDivAssign("");
						}
					}
					if (fb.getPsMode() != null && fb.getPsMode().equals("delete")) {
						boolean staus = worksData.deleteProgramScheduleDetails(getDataSource(request), fb.getWorkId());
						tenderMemo tMemo = new tenderMemo();
						if (staus == true) {
							request.setAttribute("message", "Deleted Sucessfully");
							fb.setRevflag("");
							ArrayList programMileStones = new ArrayList();
							programMileStones = fb.getMileStones();
							for (int i = 0; i < programMileStones.size(); i++) {
								tMemo = (tenderMemo) programMileStones.get(i);
								tMemo.setAchievementDate("");
							}
							fb.setSubDivAssign("");
							fb.setWorkGndDate("");
							fb.setEngineerAssign("");
							fb.setEngineerAssign1("");
							fb.setEngineerAssign2("");
							fb.setEngineerAssign3("");
						} else {
							request.setAttribute("message",
									"Data Exists in Other Work Stages! Record Cannot Be Deleted!!");
							fb.setRevflag("");
						}
						request.setAttribute("Includepage", workStage);
					}
				} catch (Exception e) {
					Debug.println("Error in Programme Schedule:" + e.getMessage());
				}
				request.setAttribute("Includepage", workStage);
			}

			/**
			 * --------------------------------------------- END of PRORAM
			 * SCHEDULE-------------------------------------------
			 */

			/**
			 * ------------------------------------------------WORK EXPENDITURE--
			 * -------------------------------------------------------------
			 */

			if (workStage != null && workStage.equals("06")) {
				WorksData1 worksData = new WorksData1(ds);
				String adminCost = "" + worksData.getAdminAmount(ds, fb.getWorkId());
				request.setAttribute("adminCost", adminCost);
				String finYear = "";
				ArrayList programmsList = (ArrayList) session.getAttribute("PROGRAMS");
				programmsList = (ArrayList) session.getAttribute("PROGRAMS");
				tenderMemo beanInSession = null;
				if (programmsList != null) {
					for (int j = 0; j < programmsList.size(); j++) {
						beanInSession = (tenderMemo) programmsList.get(j);
						int tmpIndx = 0;
						String[] aaa = request.getParameterValues("aggrigateExpenditureForProg");
						while (request.getParameter("progExp[" + tmpIndx + "].progCode") != null) {
							if (beanInSession.getProgCode()
									.equals(request.getParameter("progExp[" + tmpIndx + "].progCode"))) {
								beanInSession.setExpUptoPrevYear(
										request.getParameter("progExp[" + tmpIndx + "].expUptoPrevYear"));
								beanInSession.setAggrigateExpenditureForProg(aaa[tmpIndx]);
								beanInSession.setWorkid(fb.getWorkId());
							}
							tmpIndx++;
						}
						programmsList.set(j, beanInSession);
					}
				}
				try {
					ArrayList emptyList = new ArrayList(0);
					ArrayList allMonths = new ArrayList();
					allMonths.add("APRIL");
					allMonths.add("MAY");
					allMonths.add("JUNE");
					allMonths.add("JULY");
					allMonths.add("AUGUST");
					allMonths.add("SEPTEMBER");
					allMonths.add("OCTOBER");
					allMonths.add("NOVEMBER");
					allMonths.add("DECEMBER");
					allMonths.add("JANUARY");
					allMonths.add("FEBRUARY");
					allMonths.add("MARCH");
					request.setAttribute("AllMonths", allMonths);
					ArrayList expYears = new ArrayList();
					String groundDate = worksData.getGroundDate(getDataSource(request), fb.getWorkId());
					int groundYear = 2005;
					if (groundDate != null && groundDate.length() == 10) {
						if (groundDate.substring(3, 5).equals("01") || groundDate.substring(3, 5).equals("02")
								|| groundDate.substring(3, 5).equals("03")) {
							groundYear = Integer.parseInt(groundDate.substring(6, 10)) - 1;
						} else
							groundYear = Integer.parseInt(groundDate.substring(6, 10));
					}
					Calendar rightNow = Calendar.getInstance();
					int year = rightNow.get(Calendar.YEAR);
					int month = rightNow.get(Calendar.MONTH);
					if (month >= 3) {
						year = year + 1;
					}
					String year1 = "" + year;
					String cYear = (year - 1) + "-" + (year1.substring(2, 4));
					request.setAttribute("cYear", cYear);
					for (int i = 1; year > groundYear; i++) {
						expYears.add((year - 1) + "-" + (year1.substring(2, 4)));
						year = year - 1;
						year1 = "" + year;
					}
					if (request.getParameter("expYears") != null) {
						finYear = request.getParameter("expYears");
					} else {
						finYear = (String) expYears.get(0);
					}
					fb.setExpYears(finYear);
					request.setAttribute("AllYears", expYears);
					request.setAttribute("AllMonths", allMonths);
					ArrayList expendetures = new ArrayList();
					ArrayList programmeList = new ArrayList();
					if (fb.getWeMode() != null && fb.getWeMode().equals("data")) {
						dao = rws_works_factory.createWorksDAO(ds);
						bean = dao.getGroundingDetails(fb.getWorkId());
						if (bean != null) {
							session.setAttribute("groundingStatus", "yes");
						} else {
							request.setAttribute("message", "This Work Not Yet Grounded");
							session.removeAttribute("groundingStatus");
						}
						double expTot = 0.0;
						request.setAttribute("finYears", finYear);
						ArrayList expenditureList = worksData.getExpenditureDetails(getDataSource(request),
								fb.getWorkId(), request, finYear);
						ArrayList progs = worksData.getAdminPrograms(getDataSource(request), fb.getWorkId());
						programmsList = worksData.getExpenditureUptoPrevYear(getDataSource(request), fb.getWorkId(),
								request, finYear, progs);
						if (expenditureList != null && expenditureList.size() != 0) {
							sortExpenditureList(expenditureList, finYear);// added
							tenderMemo tt = (tenderMemo) expenditureList.get(expenditureList.size() - 1);
							tenderMemo tt1 = new tenderMemo();
							if (programmsList != null && programmsList.size() > 0) {
								tt1 = (tenderMemo) programmsList.get(programmsList.size() - 1);
								expTot = Double.parseDouble(tt1.getExpUptoPrevYear())
										+ Double.parseDouble(tt.getExpMonthUp())
										+ Double.parseDouble(tt.getExpMonthDuring());
							}
							expTot = WorksData1.round(expTot, 2);
						}
						if (programmsList != null && programmsList.size() != 0) {
							session.setAttribute("PROGRAMS", programmsList);
							session.setAttribute("valueBut", programmsList);
						} else {
							ArrayList prog = progs;
							if (prog != null) {
								session.setAttribute("PROGRAMS", prog);
								session.setAttribute("valueBut", prog);
							}
						}
						circles = offices.CircleCombo("1");
						if (expenditureList == null || expenditureList.size() == 0) {
							expenditureList = new ArrayList();
						} else {
							try {
								tenderMemo t = null;
								t = (tenderMemo) expenditureList.get(0);
								fb.setExpUptoPrevYear(t.getExpUptoPrevYear());
							} catch (Exception ee) {
								Debug.println("Exception in rws_works_WorkStatus_Act:" + ee.getMessage());
							}
						}
						session.setAttribute("expenditureList", expenditureList);
						fb.setExpenditureList(emptyList);
						session.setAttribute("circles", circles);
					}
					if (fb.getWeMode() != null && fb.getWeMode().equals("addNew")) {
						tenderMemo tenderMemoBean = null;
						finYear = request.getParameter("expYears");
						request.setAttribute("finYears", finYear);
						if (session.getAttribute("expenditureList") != null)
							expendetures = (ArrayList) session.getAttribute("expenditureList");
						else
							expendetures = new ArrayList();
						tenderMemoBean = new tenderMemo();
						tenderMemoBean.setExpYear("");
						tenderMemoBean.setExpMonth("");
						tenderMemoBean.setExpMonthUp("");
						tenderMemoBean.setExpMonthDuring("");
						expendetures.add(tenderMemoBean);
						sortExpenditureList(expendetures, finYear);
						session.setAttribute("expenditureList", new ArrayList(expendetures));
						ArrayList aggExpList = worksData.getAggExpenditure(getDataSource(request), fb.getWorkId(),
								request);
						double expTot = Double.parseDouble((String) request.getAttribute("exps"));
					}
					if (fb.getWeMode() != null && fb.getWeMode().equals("remove")) {
						String removeList[] = request.getParameterValues("remove");

						int rValue = worksData
								.removeExpenditure(getDataSource(request),
										getSelectedList((ArrayList) session.getAttribute("expenditureList"),
												request.getParameterValues("remove")),
										fb.getWorkId(), fb.getExpYears());
						if (rValue == -1)
							request.setAttribute("message", "Cannot Remove");
						else {
							request.setAttribute("message", "Removed Successfully");
							expendetures = removeFromList((ArrayList) session.getAttribute("expenditureList"),
									removeList);
							fb.setExpenditureList(expendetures);
						}
						ArrayList expenditureList = worksData.getExpenditureDetails(getDataSource(request),
								fb.getWorkId(), request, finYear);
						ArrayList progs = worksData.getAdminPrograms(getDataSource(request), fb.getWorkId());
						programmsList = worksData.getExpenditureUptoPrevYear(getDataSource(request), fb.getWorkId(),
								request, finYear, progs);
						double expTot = 0.0;
						if (expenditureList != null && expenditureList.size() != 0) {
							sortExpenditureList(expenditureList, finYear);// added
							// newly
							tenderMemo tt = (tenderMemo) expenditureList.get(expenditureList.size() - 1);
							tenderMemo tt1 = (tenderMemo) programmsList.get(programmsList.size() - 1);
							expTot = Double.parseDouble(tt1.getExpUptoPrevYear())
									+ Double.parseDouble(tt.getExpMonthUp())
									+ Double.parseDouble(tt.getExpMonthDuring());
							expTot = worksData.round(expTot, 2);
							for (int h = 0; h < programmsList.size(); h++) {
								tenderMemo tt3 = (tenderMemo) programmsList.get(h);
								tt3.setAggrigateExpenditureForProg(
										"" + worksData.round((Double.parseDouble(tt3.getExpUptoPrevYear())
												+ Double.parseDouble(tt.getExpMonthUp())
												+ Double.parseDouble(tt.getExpMonthDuring())), 2));
								programmsList.set(h, tt3);
							}
						}
						fb.setTotalExp(expTot);
						if (programmsList != null && programmsList.size() != 0) {
							session.setAttribute("PROGRAMS", programmsList);
						} else {
							ArrayList prog = worksData.getAdminPrograms(getDataSource(request), fb.getWorkId());
							if (prog != null)
								session.setAttribute("PROGRAMS", prog);
						}
						circles = offices.CircleCombo("1");
						if (expenditureList == null || expenditureList.size() == 0) {
							expenditureList = new ArrayList();
						} else {
							try {
								tenderMemo t = null;
								t = (tenderMemo) expenditureList.get(0);
								fb.setExpUptoPrevYear(t.getExpUptoPrevYear());
							} catch (Exception ee) {
								Debug.println("Exception in rws_works_WorkStatus_Act:" + ee.getMessage());
							}
						}
						finYear = request.getParameter("expYears");
						request.setAttribute("finYears", finYear);
					}
					if (fb.getWeMode() != null && fb.getWeMode().equals("sort")) {

						tenderMemo tenderMemoBean = null;
						finYear = request.getParameter("expYears");
						request.setAttribute("finYears", finYear);
						expendetures = (ArrayList) fb.getExpenditureList();

						sortExpenditureList(expendetures, finYear);
						session.setAttribute("expenditureList", expendetures);
						ArrayList aggExpList = worksData.getAggExpenditure(getDataSource(request), fb.getWorkId(),
								request);
						double expTot = Double.parseDouble((String) request.getAttribute("exps"));
					}
					tenderMemo tenderMemoBean = null;
					if (fb.getWeMode() != null && fb.getWeMode().equals("expMonthChanged")) {
						finYear = request.getParameter("expYears");
						request.setAttribute("finYears", finYear);
						ArrayList selectedList = new ArrayList(expendetures);
						ArrayList expUpToPervYear = null;
						ArrayList programsList = new ArrayList();
						try {

							tenderMemo beann = null;
							int i = 0;
							while (request.getParameter("progExp[" + i + "].progCode") != null) {
								beann = new tenderMemo();
								beann.setProgCode(request.getParameter("progExp[" + i + "].progCode"));
								beann.setExpUptoPrevYear(request.getParameter("progExp[" + i + "].expUptoPrevYear"));
								programsList.add(bean);
								i++;
							}
						} catch (Exception e) {
							Debug.println("Exception in rws_works_WorkStatus_Act " + e);
						}

						selectedList.remove(Integer.parseInt(request.getParameter("index")));
						ArrayList status = (ArrayList) session.getAttribute("disableStatus");
						int rvalue = worksData.saveExpenditure(getDataSource(request), selectedList, fb.getWorkId(),
								fb.getValueOFWorkDone(), programsList, finYear, "", status);
						int index = Integer.parseInt(request.getParameter("index"));
						tenderMemo tenderMemoObj = new tenderMemo();
						float expUptoPrevMonth = worksData.getExpUptoPrevMonth(getDataSource(request), fb.getWorkId(),
								request.getParameter("year"), request.getParameter("month"));
						tenderMemoObj = (tenderMemo) expendetures.get(index);
						tenderMemoObj.setExpMonthUp(expUptoPrevMonth + "");
						expendetures.set(index, tenderMemoObj);
						session.setAttribute("expenditureList", expendetures);
						ArrayList aggExpList = worksData.getAggExpenditure(getDataSource(request), fb.getWorkId(),
								request);
						double expTot = Double.parseDouble((String) request.getAttribute("exps"));
					}
					if (fb.getWeMode() != null && fb.getWeMode().equals("save")) {
						finYear = request.getParameter("expYears");
						request.setAttribute("finYears", finYear);
						expendetures = (ArrayList) fb.getExpenditureList();
						programmeList = fb.getProgrammeList();
						ArrayList expUpToPervYear = new ArrayList();
						ArrayList selectedList = expendetures;
						ArrayList programsList = new ArrayList();
						ArrayList status = (ArrayList) session.getAttribute("disableStatus");
						try {
							int i = 0;
							programsList = (ArrayList) session.getAttribute("PROGRAMS");
							beanInSession = null;
							for (int j = 0; j < programsList.size(); j++) {
								beanInSession = (tenderMemo) programsList.get(j);
								int tmpIndx = 0;
								String[] aaa = request.getParameterValues("aggrigateExpenditureForProg");
								String[] aaaa = request.getParameterValues("valueOFWorkDoneButnotPaid");
								while (request.getParameter("progExp[" + tmpIndx + "].progCode") != null) {
									if (beanInSession.getProgCode()
											.equals(request.getParameter("progExp[" + tmpIndx + "].progCode"))) {
										beanInSession.setExpUptoPrevYear(
												request.getParameter("progExp[" + tmpIndx + "].expUptoPrevYear"));
										beanInSession.setAggrigateExpenditureForProg(aaa[tmpIndx]);
										beanInSession.setValueOFWorkDoneButnotPaid(aaaa[tmpIndx]);
										beanInSession.setWorkid(fb.getWorkId());
									}
									tmpIndx++;
								}
								programsList.set(j, beanInSession);
							}
							if (programsList != null && programsList.size() != 0)
								session.setAttribute("PROGRAMS", programsList);
						} catch (Exception e) {
							Debug.println("Exception in rws_works_WorkStatus_Act " + e);
						}
						String prev = request.getParameter("expUptoPrevYears");
						int rvalue = worksData.saveExpenditure(getDataSource(request), selectedList, fb.getWorkId(),
								fb.getValueOFWorkDone(), programsList, finYear, cYear, status);
						if (rvalue == -1)
							request.setAttribute("message", "Cannot Save");
						else if (rvalue == 1)
							request.setAttribute("message", "Saved Successfully");
						else if (rvalue == 2)
							request.setAttribute("message", "Updated Successfully");
						displayWorkExpenditureGridValues(fb.getExpenditureList());
						displayWorkExpenditureGridValues((ArrayList) session.getAttribute("expenditureList"));

						sortExpenditureList(expendetures, finYear);

						session.setAttribute("expenditureList", expendetures);
						ArrayList aggExpList = worksData.getAggExpenditure(getDataSource(request), fb.getWorkId(),
								request);
						ArrayList expenditureList = worksData.getExpenditureDetails(getDataSource(request),
								fb.getWorkId(), request, finYear);
						ArrayList progs = worksData.getAdminPrograms(getDataSource(request), fb.getWorkId());
						programmsList = worksData.getExpenditureUptoPrevYear(getDataSource(request), fb.getWorkId(),
								request, finYear, progs);
						double expTot = 0.0;
						if (expenditureList != null && expenditureList.size() != 0) {
							sortExpenditureList(expenditureList, finYear);// added
							// newly
							tenderMemo tt = (tenderMemo) expenditureList.get(expenditureList.size() - 1);
							tenderMemo tt1 = (tenderMemo) programmsList.get(programmsList.size() - 1);
							expTot = Double.parseDouble(tt1.getExpUptoPrevYear())
									+ Double.parseDouble(tt.getExpMonthUp())
									+ Double.parseDouble(tt.getExpMonthDuring());
							expTot = worksData.round(expTot, 2);
							for (int h = 0; h < programmsList.size(); h++) {
								tenderMemo tt3 = (tenderMemo) programmsList.get(h);
								tt3.setAggrigateExpenditureForProg(
										"" + worksData.round((Double.parseDouble(tt3.getExpUptoPrevYear())
												+ Double.parseDouble(tt.getExpMonthUp())
												+ Double.parseDouble(tt.getExpMonthDuring())), 2));
								programmsList.set(h, tt3);
							}
						}
						circles = offices.CircleCombo("1");
						if (expenditureList == null || expenditureList.size() == 0) {
							expenditureList = new ArrayList();
						} else {
							try {
								tenderMemo t = null;
								t = (tenderMemo) expenditureList.get(0);
								fb.setExpUptoPrevYear(t.getExpUptoPrevYear());
							} catch (Exception ee) {
								Debug.println("Exception in rws_works_WorkStatus_Act:" + ee.getMessage());
							}
						}
					}
					if (fb.getWeMode() != null && fb.getWeMode().equals("delete")) {
						finYear = request.getParameter("expYears");
						request.setAttribute("finYears", finYear);
						int rvalue = worksData.deleteExpenditure(getDataSource(request), fb.getWorkId());
						if (rvalue == -1) {
							request.setAttribute("message", "Cannot Delete");
						} else if (rvalue == -2) {
							request.setAttribute("message",
									"Data Exists in Other Work Stages! Record Cannot be Deleted!!");
						} else if (rvalue >= 0) {
							programmsList = (ArrayList) session.getAttribute("PROGRAMS");
							programmsList = resetProgrammsList(programmsList);
							request.setAttribute("message", "Deleted Successfully");
							session.setAttribute("expenditureList", new ArrayList());
							session.setAttribute("PROGRAMS", programmsList);
						}
						ArrayList aggExpList = worksData.getAggExpenditure(getDataSource(request), fb.getWorkId(),
								request);
						session.setAttribute("PROGRAMSS", aggExpList);
						double expTot = Double.parseDouble((String) request.getAttribute("exps"));
						fb.setTotalExp(expTot);
					}
				} catch (Exception e) {
					Debug.println("Error in Work Expenditure:" + e.getMessage());
				}
				request.setAttribute("Includepage", workStage);
			}

			/**
			 * --------------------------------------------- END of WORK
			 * EXPENDITURE-------------------------------------------
			 */

			/**
			 * ------------------------------------------------WORK COMPLETION----
			 * -----------------------------------------------------------
			 */

			if (workStage != null && workStage.equals("07")) {
				WorksData1 worksData = new WorksData1(ds);
				String[] selHabCodes = new String[20];
				int count = 0;
				ArrayList habnames = null;
				String val = "";
				int habs = 0;
				if (fb.getWcMode() != null && fb.getWcMode().equals("data")) {
					dao = rws_works_factory.createWorksDAO(ds);
					bean = dao.getGroundingDetails(fb.getWorkId());
					if (bean != null) {
						session.setAttribute("groundingStatus", "yes");
					} else {
						request.setAttribute("message", "This Work Not Yet Grounded");
						session.removeAttribute("groundingStatus");
					}
					String workCode = fb.getWorkId();
					rws_works_WorkStatus_form worksBean = worksData.getWorksCompletionData(getDataSource(request),
							workCode);
					if (worksBean.getWorkCompDateCompleted() != null
							&& !worksBean.getWorkCompDateCompleted().equals(""))
						request.setAttribute("saveDone", "Y");
					else
						request.setAttribute("saveDone", "N");
					fb.setWorkCompStartDate(worksBean.getWorkCompStartDate());
					fb.setWorkCompActualDtOfComp(worksBean.getWorkCompDateCompleted());
					fb.setWorkCompStipulatedDtOfComp(worksBean.getWorkCompStipulatedDateOfCompletion());
					fb.setProbCompDate(worksBean.getProbCompDate());
					fb.setDateOfComm(worksBean.getDateOfComm());
					fb.setWorkCompFinDtOfComp(worksBean.getWorkCompFinDtOfComp());
					fb.setPriYesOrNo(worksBean.getPriYesOrNo());
					fb.setRemarks(worksBean.getRemarks());
					if (worksBean.getWorkCompDateCompleted() != null
							|| worksBean.getPartialDateOfCompletion() != null) {
						selHabCodes = worksData.getWorkCompHabs(getDataSource(request), workCode, count,
								"RWS_WORK_COMP_HAB_LNK_TBL", request);
						session.setAttribute("selHabCodes", selHabCodes);

					} else {

						selHabCodes = worksData.getWorkCompHabs(getDataSource(request), workCode, count,
								"RWS_EST_NEW_HAB_LNK_TBL", request);
						session.setAttribute("selHabCodes", selHabCodes);

					}
					int habsBen = Integer.parseInt((String) request.getAttribute("tothabsben"));
					if (habsBen == 0) {
						request.setAttribute("benCount", "0");
						session.removeAttribute("selHabCodes");
					} else {
						request.setAttribute("benCount", "1");
					}
					fb.setTechHabsBen("" + habsBen);

					fb.setEplainPop(worksBean.getPlainPop());
					fb.setEscPop(worksBean.getScPop());
					fb.setEstPop(worksBean.getStPop());
					int plainPop = 0, scPop = 0, stPop = 0;
					if (worksBean.getPlainPop() != null && !worksBean.getPlainPop().equals("")) {
						plainPop = Integer.parseInt(worksBean.getPlainPop());
					}
					if (worksBean.getStPop() != null && !worksBean.getStPop().equals("")) {
						stPop = Integer.parseInt(worksBean.getStPop());
					}
					if (worksBean.getScPop() != null && !worksBean.getScPop().equals("")) {
						scPop = Integer.parseInt(worksBean.getScPop());
					}
					fb.setEstTotPop(plainPop + scPop + stPop + "");

					int revTecCount = 0;

					try {
					} catch (Exception e) {
						Debug.println("Exception in rws_works_WorkStatus_Act " + e);
					}
					if (revTecCount > 0) {
						worksData = new WorksData1();
						selHabCodes = worksData.revTechWorksHabsRetrieve(getDataSource(request), workCode, count);
					}

					try {
						int habsCount = 0;
						worksData = new WorksData1();
					} catch (Exception e) {
						Debug.println("Exception in rws_works_WorkStatus_Act is trying to get workcomhabs" + e);
					}

					habnames = worksData.insertProposalTempHabs(ds, selHabCodes, workCode);
					tenderMemo tenderTmp;

					for (int i = 0; i < habnames.size(); i++) {
						tenderTmp = (tenderMemo) habnames.get(i);
						val = val + tenderTmp.getSelHabNames() + "\n";
					}
					fb.setTechHabNames(val);
					fb.setTechHabsBen("" + habnames.size());

					if (session.getAttribute("habNames") != null
							&& session.getAttribute("habNames").equals("selHabNames")) {
						habnames = (ArrayList) session.getAttribute("selHabNames");

						for (int i = 0; i < habnames.size(); i++) {
							tenderTmp = (tenderMemo) habnames.get(i);
							val = val + tenderTmp.getSelHabNames() + "\n";
						}
						fb.setTechHabNames(val);
						fb.setTechHabsBen("" + habs);
						session.setAttribute("habNames", "exselHabNames");

					}
					session.removeAttribute("abc");
				}
				if (fb.getWcMode() != null && fb.getWcMode().equals("saveRemarks")) {
					int inserted = worksData.insertWorksRemarks(fb.getWorkId(), request.getParameter("remarks"));
					if (inserted > 0)
						request.setAttribute("message", "Remarks Saved Successfully");
					else
						request.setAttribute("message", "Failed to Save");
					return mapping.findForward("showMsg");
				}
				if (fb.getWcMode() != null && fb.getWcMode().equals("save")) {
					 String storedToken = (String)session.getAttribute("csrfToken");
					    String token = request.getParameter("token");
					    if (storedToken.equals(token))
					    {
					    	
					if (session.getAttribute("selHabCodes") != null)
						selHabCodes = (String[]) session.getAttribute("selHabCodes");
					int inserted = worksData.insertWorkCompData(getDataSource(request), fb.getWorkId(), fb,
							fb.getWorkId(), selHabCodes, fb.getRemarks());
					if (inserted == 1) {
						request.setAttribute("message", "inserted successfully");
						request.setAttribute("saveDone", "Y");
					} else if (inserted == 2) {
						request.setAttribute("message", "Updated successfully");
						request.setAttribute("saveDone", "Y");
					}else if(inserted == 3){
						request.setAttribute("message", "Record Cannot be Inserted,Update FHTC provided in show habs");
						request.setAttribute("saveDone", "N");
					} else {
						request.setAttribute("message", "Record Cannot be Inserted");
						request.setAttribute("saveDone", "N");
					}

					rws_works_WorkStatus_form worksBean = new rws_works_WorkStatus_form();
					worksBean = worksData.getPopBenfitedOnWorkComPletion(getDataSource(request), fb.getWorkId());
					fb.setEplainPop(worksBean.getPlainPop());
					fb.setEscPop(worksBean.getScPop());
					fb.setEstPop(worksBean.getStPop());
					int plainPop = 0, scPop = 0, stPop = 0;
					if (worksBean.getPlainPop() != null && !worksBean.getPlainPop().equals("")) {
						plainPop = Integer.parseInt(worksBean.getPlainPop());
					}
					if (worksBean.getStPop() != null && !worksBean.getStPop().equals("")) {
						stPop = Integer.parseInt(worksBean.getStPop());
					}
					if (worksBean.getScPop() != null && !worksBean.getScPop().equals("")) {
						scPop = Integer.parseInt(worksBean.getScPop());
					}
					fb.setEstTotPop(plainPop + scPop + stPop + "");
					String hh = (String) session.getAttribute("abc");
					request.setAttribute("benCount", hh);
				}
				}
				if (fb.getWcMode() != null && fb.getWcMode().equals("delete")) {
					int deleted = worksData.deleteWorkCompData(getDataSource(request), fb.getWorkId(),
							fb.getDateOfComm(), fb.getWorkCompActualDtOfComp());
					if (deleted == 1) {
						request.setAttribute("message", "Deleted successfully");
						request.setAttribute("saveDone", "N");
						fb.setWorkCompActualDtOfComp("");
						fb.setDateOfComm("");
						fb.setRemarks("");
					} else if (deleted == -2) {
						request.setAttribute("message", "Record Cannot be Deleted!!");
						request.setAttribute("saveDone", "Y");
					} else if (deleted == -1) {
						request.setAttribute("message", "Work Already Commissioned! Record Cannot be Deleted!!");
						request.setAttribute("saveDone", "Y");
					}
					String hh = (String) session.getAttribute("abc");
					request.setAttribute("benCount", hh);
				}
				if (fb.getWcMode() != null && fb.getWcMode().equals("addRemoveHabitations")) {
					String success = "";
					String mcodes[] = null;
					String habCodes[] = null;
					RwsLocations rwsLocations = null;
					rwsLocations = new RwsLocations(getDataSource(request));
					String circleOfficeCode = null;
					if (fb.getWorkId() != null)
						circleOfficeCode = fb.getWorkId().substring(4, 6);
					String revTs = request.getParameter("revTs");

					request.setAttribute("revTs", revTs);
					ArrayList habsList = new ArrayList();
					if (revTs != null & revTs.equals("Yes"))
						habsList = (ArrayList) session.getAttribute("SanctionedRevHabs");
					if (revTs != null & revTs.equals("No"))
						habsList = (ArrayList) session.getAttribute("SanctionedHabs");
					if (request.getParameter("selectedMcodes") == null) {
						ArrayList mandals = rwsLocations.getMandals(circleOfficeCode);
						session.setAttribute("mandals", mandals);
						success = "pick-man";
					} else {
						String all = request.getParameter("All");
						if (all == null || all.equals("")) {
							String temp = request.getParameter("selectedMcodes");
							mcodes = temp.split("<>");
							dao = rws_works_factory.createWorksDAO(ds);
							ArrayList habitations = dao.getHabsInMandals(fb.getWorkId(), habsList, mcodes);
							if (habitations != null)
								request.setAttribute("habitations", habitations);

						}
						if (all != null && all.equals("yes")) {
							dao = rws_works_factory.createWorksDAO(ds);
							ArrayList habitations = dao.getTotHabs(fb.getWorkId(), habsList);
							if (habitations != null)
								request.setAttribute("habitations", habitations);
						}
						success = "pick-habs";
						if (revTs != null & revTs.equals("Yes"))
							success = "pick-habs-rev";
					}
				}
				request.setAttribute("Includepage", workStage);
			}

			/**
			 * --------------------------------------------- END of WORK
			 * COMPETION-------------------------------------------
			 */

			/**
			 * --------------------------------------------- CONTRACTOR MANAGEMENT
			 * -------------------------------------------
			 */
			if (workStage != null && workStage.equals("04")) {
				dao = rws_works_factory.createWorksDAO(ds);
				rws_works_WorkStatus_form frm = dao.getAdminAndRevisedDetails(fb.getWorkId());
				fb.setRevAdminAmnt(frm.getRevAdminAmnt());
				fb.setPartASanAMount(new RwsWorksDAO().getPartAAMount(fb.getWorkId()));

				if (session.getAttribute("mileStonesList") == null) {
					dao = rws_works_factory.createWorksDAO(ds);
					ArrayList Milestones = dao.getMileStones();
					if (Milestones != null)
						session.setAttribute("MILESTONES", Milestones);
					ArrayList MileStone = new ArrayList(1);
					bean = new rws_works_WorkStatus_bean();
					MileStone.add(bean);
					session.setAttribute("mileStonesList", MileStone);
				}
				if (fb.getConMode() != null && fb.getConMode().equals("stages")) {
					String index = request.getParameter("index");
					int ndx = 0;
					if (index != null) {
						try {
							ndx = Integer.parseInt(index);
						} catch (NumberFormatException nfe) {
							Debug.println("Exception in rws_works_WorkStatus_Act converting index to ndx " + nfe);
						}
					}
					ArrayList Milestones = new ArrayList(fb.getMileStones());
					bean = (rws_works_WorkStatus_bean) Milestones.get(ndx);
					String mileStoneCode = bean.getMileStone();
					dao = rws_works_factory.createWorksDAO(ds);
					ArrayList stages = dao.getStages(mileStoneCode);
					bean.setStages(stages);
					Milestones.set(ndx, bean);
					session.setAttribute("mileStonesList", Milestones);
				}
				if (fb.getConMode() != null && fb.getConMode().equals("data")) {
					dao = rws_works_factory.createWorksDAO(ds);
					bean = dao.getTsDetails(fb.getWorkId());

					if (bean != null) {
						fb.setTsDate(bean.getTsDate());
						session.setAttribute("tsStatus", "yes");
					} else {
						session.setAttribute("tsStatus", "no");
						request.setAttribute("message", "This work not yet Technically Sanctioned");
					}
					bean = new rws_works_WorkStatus_bean();
					dao = rws_works_factory.createWorksDAO(ds);
					bean = dao.getContractorData(fb.getWorkId());

					String workper = "", tenper = "";

					if (bean.getTenPer() != null && !bean.getTenPer().equals("") && !bean.getTenPer().equals("null")) {
						if (bean.getTenPer().substring(0, 1).equals("-")) {
							tenper = tenper.concat(bean.getTenPer().substring(1));
							workper = workper.concat("-");
						} else if (bean.getTenPer().equals("0")) {
							tenper = tenper.concat("0");
							workper = workper.concat("");
						} else {
							tenper = tenper.concat(bean.getTenPer());
							workper = workper.concat("+");
						}
					} else {
						workper = workper.concat("");
						tenper = tenper.concat("0");
					}

					if (bean.getWorkEnt() != null && bean.getWorkEnt().equals("N")) {
						fb.setTenId("");
						fb.setTenId1("NOMINATION");
						fb.setWorkEnt("N");
					} else if (bean.getWorkEnt() != null && bean.getWorkEnt().equals("T")) {
						fb.setTenId(bean.getTenId());
						fb.setTenId1("");
						fb.setWorkEnt("T");
					} else {
						fb.setTenId("");
						fb.setTenId1("");
						fb.setWorkEnt("");
					}
					fb.setAgrRefNo(bean.getAgrRefNo());
					fb.setAgrDuration(bean.getAgrDuration());
					fb.setAgrValue(bean.getAgrValue());
					fb.setSiteHandOverDate(bean.getSiteHandOverDate());
					fb.setAgrDate(bean.getAgrDate());
					fb.setLoaIssued(bean.getLoaIssued());
					fb.setStipulatedDate(bean.getStipulatedDate());
					fb.setProbCompDate(bean.getProbCompDate());
					if (request.getParameter("conCode") != null && !request.getParameter("conCode").equals("")) {
						fb.setConName(request.getParameter("conCode"));
					} else {
						fb.setConName(bean.getConName());
					}
					ArrayList contractor = offices.getContractorList(bean.getConName());
					session.setAttribute("contractors", contractor);
					fb.setTenCost(bean.getTenCost());
					fb.setTenAcceptedDate(bean.getTenAcceptedDate());
					fb.setTenCompetentAuthority(bean.getTenCompetentAuthority());
					fb.setTenCommiteeArr(bean.getTenCommiteeArr());
					fb.setTenPer(tenper);
					fb.setWorkPer1(workper);
					String amt = "0";
					dao = rws_works_factory.createWorksDAO(ds);
					session.removeAttribute("mileStonesList");
					fb.setMileStones(new ArrayList());
					ArrayList Milestones = dao.getContractorMileStonesData(ds, fb.getWorkId());
					session.setAttribute("mileStonesList", Milestones);
				}
				if (fb.getConMode() != null && fb.getConMode().equals("addNew")) {
					ArrayList contractor = offices.getContractorList(fb.getConName());
					session.setAttribute("contractors", contractor);
					ArrayList Milestones = fb.getMileStones();
					int sno = 1;
					if (Milestones.size() != 0) {
						bean = (rws_works_WorkStatus_bean) Milestones.get(Milestones.size() - 1);
						sno = Integer.parseInt(bean.getMileStoneSno());
						sno++;
					}
					bean = new rws_works_WorkStatus_bean();
					if (request.getParameter("majorCode") != null && !request.getParameter("majorCode").equals("")) {
						int majorCode = Integer.parseInt(request.getParameter("majorCode"));
						if (request.getParameter("special") != null && request.getParameter("special").equals("y")) {
						}
						bean.setMajorMileStone("" + majorCode);
						bean.setMileStoneSno("" + sno);
					}
					Milestones.add(bean);
					for (int i = 0; i < Milestones.size(); i++) {
						bean = (rws_works_WorkStatus_bean) Milestones.get(i);
						if (bean.getMileStone() != null && !bean.getMileStone().equals("")) {
							dao = rws_works_factory.createWorksDAO(ds);
							bean.setStages(dao.getStages(bean.getMileStone()));
						}
					}
					session.setAttribute("mileStonesList", Milestones);
				}
				if (fb.getConMode() != null && fb.getConMode().equals("remove")) {

					ArrayList Milestones = new ArrayList(fb.getMileStones());
					String index[] = request.getParameterValues("remove");
					int removedMs = 0;
					for (int i = 0; i < index.length; i++) {
						int ndx = 0;
						if (index[i] != null) {
							try {
								ndx = Integer.parseInt(index[i]);
								bean = (rws_works_WorkStatus_bean) Milestones.get(Integer.parseInt(index[i]));
								dao = rws_works_factory.createWorksDAO(ds);
								int removedMs1 = dao.removeMileStones(fb.getWorkId(), bean.getMileStoneSno());
								if (removedMs1 == 1)
									Milestones.set(ndx, null);
								removedMs += removedMs1;
							} catch (NumberFormatException nfe) {
								Debug.println("Exception in rws_works_WorkStatus_Act converting index to ndx " + nfe);
							}
						}
					}
					for (int i = 0; i < Milestones.size(); i++) {
						bean = (rws_works_WorkStatus_bean) Milestones.get(i);
						if (bean == null) {
							Milestones.remove(i);
							i--;
						}
					}
					for (int i = 0; i < Milestones.size(); i++) {
						bean = (rws_works_WorkStatus_bean) Milestones.get(i);
						dao = rws_works_factory.createWorksDAO(ds);
						bean.setStages(dao.getStages(bean.getMileStone()));
					}
					if (removedMs == index.length) {
						request.setAttribute("message", removedMs + "Selected Mile Stone(s) Removed Successfully");// Temporarily

					} else if (removedMs != index.length) {
						if (removedMs == 0)
							request.setAttribute("message",
									"No Mile Stone(s) Removed because Mile Stone(s) Having Achievement(s)");
						else
							request.setAttribute("message", removedMs + " Mile Stone(s) Removed Successfully because "
									+ (index.length - removedMs) + " Mile Stone(s) Having Voucher(s)");

					}

					session.setAttribute("mileStonesList", Milestones);
					fb.setMileStones(Milestones);

				}

				if (fb.getConMode() != null && fb.getConMode().equals("save")) {
					 String storedToken = (String)session.getAttribute("csrfToken");
					    String token = request.getParameter("token");
					    if (storedToken.equals(token))
					    {
					String conCode = request.getParameter("conNamee");
					bean = new rws_works_WorkStatus_bean();
					bean.setWorkEnt(fb.getWorkEnt());
					if (fb.getWorkEnt().equals("N")) {
						bean.setTenId("NOMINATION");
					} else if (fb.getWorkEnt().equals("T")) {
						bean.setTenId(fb.getTenId());
					}
					bean.setTenCost(fb.getTenCost());
					bean.setTenAcceptedDate(fb.getTenAcceptedDate());
					bean.setTenPer(fb.getWorkPer1() + "" + fb.getTenPer());
					fb.setConName(conCode);
					bean.setConName(conCode);
					bean.setLoaIssued(fb.getLoaIssued());
					bean.setTenApprovedBy(fb.getTenApprovedBy());
					bean.setAgrRefNo(fb.getAgrRefNo());
					bean.setAgrDate(fb.getAgrDate());
					bean.setAgrDuration(fb.getAgrDuration());
					bean.setAgrValue(fb.getAgrValue());
					bean.setSiteHandOverDate(fb.getSiteHandOverDate());
					bean.setStipulatedDate(fb.getStipulatedDate());
					bean.setTenCommitee(fb.getTenCommitee());
					bean.setProbCompDate(fb.getProbCompDate());
					bean.setTenCompetentAuthority(fb.getTenCompetentAuthority());
					String[] arrTmp = request.getParameterValues("tenCommiteeArr");
					if (arrTmp != null) {
						for (int i = 0; i < arrTmp.length; i++) {
							if (arrTmp[i].equals("01"))
								bean.setTenCommitee(arrTmp[i]);
							else if (arrTmp[i].equals("02"))
								bean.setTenCompetentAuthority(arrTmp[i]);
						}
					} else {
						fb.setTenCommiteeArr(new String[2]);
					}

					ArrayList mileStones = fb.getMileStones();

					dao = rws_works_factory.createWorksDAO(ds);
					int rvalue = dao.saveContMgtMileStones(getDataSource(request), mileStones, fb.getWorkId(), bean);
					if (rvalue == -1)
						request.setAttribute("message", "Cannot Save");
					else
						request.setAttribute("message", "Saved Successfully");
					for (int i = 0; i < mileStones.size(); i++) {
						bean = (rws_works_WorkStatus_bean) mileStones.get(i);
						dao = rws_works_factory.createWorksDAO(ds);
						bean.setStages(dao.getStages(bean.getMileStone()));
					}
					session.setAttribute("mileStonesList", mileStones);
					ArrayList contractor = offices.getContractorList(fb.getConName());
					session.setAttribute("contractors", contractor);
					fb.setMileStones(mileStones);
				}
				}
				if (fb.getConMode() != null && fb.getConMode().equals("delete")) {
					dao = rws_works_factory.createWorksDAO(ds);
					int rvalue = dao.deleteContractorData(fb.getWorkId());
					if (rvalue == -1)
						request.setAttribute("message", "Cannot Delete");
					if (rvalue == -2)
						request.setAttribute("message", "Data Exists in Other Work Stages!Record Cannot Be Deleted!!");
					else if (rvalue >= 0) {
						request.setAttribute("message", "Deleted Successfully");
						fb.setTenId("");
						fb.setTenCost("");
						fb.setTenAcceptedDate("");
						fb.setTenPer("");
						fb.setConName("");
						fb.setLoaIssued("");
						fb.setTenApprovedBy("");
						fb.setAgrRefNo("");
						fb.setAgrDate("");
						fb.setAgrDuration("");
						fb.setAgrValue("");
						fb.setSiteHandOverDate("");
						fb.setStipulatedDate("");
						fb.setTenCommitee("");
						fb.setTenCompetentAuthority("");
						fb.setTenCommiteeArr(new String[0]);
						fb.setMileStones(new ArrayList());
						session.setAttribute("mileStonesList", new ArrayList());
					}
				}
				request.setAttribute("Includepage", workStage);
			}

			if (fb.getWorkId() != null && !fb.getWorkId().equals("")) {
				dao = rws_works_factory.createWorksDAO(ds);
				fb.setPartialDateOfCompletion("");
				ArrayList statuss = dao.getWorkPhysicalStatus(fb.getWorkId());
				WorksData1 worksData1 = new WorksData1();
				request.setAttribute("isDdwsWork", "");
				if (statuss != null) {
					fb.setPhysicalStatus("" + statuss.get(0));
					fb.setPhysicalStatusDetails("" + statuss.get(1));
					if (statuss.size() > 3) {
						fb.setPartialDateOfCompletion("" + statuss.get(3));
					}
				}
				dao = rws_works_factory.createWorksDAO(ds);
				ArrayList details = dao.getSchoolDetails(fb.getWorkId());
				if (details != null && !details.equals("")) {
					fb.setSchoolDetails("" + details.get(0));
					session.removeAttribute("workLinkedSchools");
					session.setAttribute("workLinkedSchools", details.get(1));
					request.setAttribute("isDdwsWork", details.get(2));
				}
			} else {
				fb.setPhysicalStatus("");
				fb.setPhysicalStatusDetails("");
				fb.setSchoolDetails("Please Select Work");
			}
		} catch (Exception e) {
			Debug.println("EException in rws_works_WorkStatus_Act" + e);
		}
		System.gc();
		return mapping.findForward(SUCCESS);

	}

	public void sortExpenditureList(ArrayList expenditureList, final String finYear) {
		try {
			// code to sort arrayList
			Collections.sort(expenditureList, new Comparator() {
				public int compare(Object o1, Object o2) {
					String s = finYear;
					tenderMemo d1 = (tenderMemo) o1;
					tenderMemo d2 = (tenderMemo) o2;

					String progCode1 = d1.getProgCode();
					String progCode2 = d2.getProgCode();
					Integer expYear1 = new Integer(0);
					Integer expYear2 = new Integer(0);
					try {
						expYear1 = new Integer(Integer.parseInt(finYear.substring(0, 4)));
						expYear2 = new Integer(Integer.parseInt(finYear.substring(0, 4)));
					} catch (Exception e) {
						Debug.println("Exception in rws_works_WorkStatus_Act sorting exp while parsing year to Integer" + e);
					}
					Integer month1 = new Integer(0);
					Integer month2 = new Integer(0);
					try {
						month1 = new Integer(Integer.parseInt(d1.getExpMonth()));
						month2 = new Integer(Integer.parseInt(d2.getExpMonth()));
					} catch (Exception e) {
						Debug.println("Exception in rws_works_WorkStatus_Act sorting Exp while parsing month to Integer" + e);
					}
					if (progCode1 != null && !progCode1.equals("") && progCode2 != null && !progCode2.equals("")
							&& month1.intValue() != 0 && month2.intValue() != 0) {
						if (progCode1.equalsIgnoreCase(progCode2)) {
							if (expYear1.intValue() == expYear2.intValue()) {
								return month1.compareTo(month2);
							} else {
								return expYear1.compareTo(expYear2);
							}
						} else {
							return progCode1.compareTo(progCode2);
						}

					} else if ((progCode1 == null || progCode1.equals(""))
							&& (progCode2 != null && !progCode2.equals(""))) {
						return 1;
					} else if ((progCode1 != null && !progCode1.equals(""))
							&& (progCode2 == null || progCode2.equals(""))) {
						return -1;
					} else if ((progCode1 == null || progCode1.equals(""))
							&& (progCode2 == null || progCode2.equals(""))) {
						return 0;
					}
					return -1;
				}
			});

		} catch (Exception e) {
			Debug.println("Exception in rws_works_WorkStatus_Act soreExpenditureList is " + e);
		}
	}

	public ArrayList removeFromList(ArrayList list, String indexes[]) {
		ArrayList newList = new ArrayList();
		try {
			for (int i = 0; i < indexes.length; i++) {
				list.set(Integer.parseInt(indexes[i]), null);
			}
			for (int i = 0; i < list.size(); i++) {
				if (list.get(i) != null)
					newList.add(list.get(i));

			}
		} catch (Exception e) {
			Debug.println("Exception in rws_works_WorkStatus_Act removeFromList is " + e);
		}
		return newList;
	}

	public ArrayList getSelectedList(ArrayList list, String indexes[]) {
		ArrayList newList = new ArrayList();
		try {
			for (int i = 0; i < indexes.length; i++) {
				newList.add(list.get(Integer.parseInt(indexes[i])));
			}
		} catch (Exception e) {
			Debug.println("Exception in rws_works_WorkStatus_Act getSelectedLIst is " + e);
		}

		return newList;
	}

	public void displayWorkExpenditureGridValues(ArrayList expenditureList) {
		try {
			tenderMemo tenderMemoBean = new tenderMemo();
			for (int i = 0; i < expenditureList.size(); i++) {
				tenderMemoBean = (tenderMemo) expenditureList.get(i);

			}
		} catch (Exception e) {

			Debug.println("Exception in rws_works_WorkStatus_Act while displaying the values" + e);
		}
	}

	public ArrayList resetProgrammsList(ArrayList programmsList) {
		tenderMemo tenderMemoObj = null;
		for (int i = 0; i < programmsList.size(); i++) {
			tenderMemoObj = (tenderMemo) programmsList.get(i);
			tenderMemoObj.setExpUptoPrevYear("");

		}

		return programmsList;
	}
}