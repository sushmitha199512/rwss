package nic.watersoft.masters;

import java.util.ArrayList;
import java.util.Collection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_masters_Direct_Bills_Action  extends Action {
	@SuppressWarnings("unchecked")
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		
		DataSource ds = null;
		ArrayList circles = null;
		ArrayList divisions = null;
		ArrayList subdivs = null;
		ArrayList programmes = null;
		ArrayList subprogrammes = null;
		String SUCCESS = "success";
		HttpSession session = request.getSession();
		RwsUser user = null;
		user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");
		Rws_Direct_Bills_Form fb = (Rws_Direct_Bills_Form) form;
		fb.setPreparedBy(user.getUserId());
		fb.setOfficeCode(user.getOfficeCode());
		Rws_Direct_Bills_Bean_Form bean = null;
		try {
			RwsOffices offices = new RwsOffices();
			String mode = fb.getMode();
			
			
			
			if (mode.equals("insContract")) {
				ArrayList contractor = offices.getContractorList();
				session.setAttribute("contractors", contractor);
				Debug.println("insContract");
			}
			if (mode.equals("saveBills")) {
				ArrayList vouchers = new ArrayList();
				vouchers = (ArrayList) fb.getVouchersList();
				Debug.println("vouchers details size before saving is :"
						+ vouchers.size());
				String removes[] = request.getParameterValues("remove");
				Collection remove = new ArrayList();
				for (int i = 0; i < removes.length; i++) {
					remove.add(removes[i]);
				}
				System.out.println("fb.getAssetName()  - "  +fb.getAssetName());
				
				RWS_Direct_Bills_DAO worksData = new RWS_Direct_Bills_DAO(ds);
				String value = worksData.saveBills(vouchers, fb.getAssetName(),remove , request);
				request.setAttribute("message", value);
				ArrayList vouchersList = worksData.getBills(fb.getAssetName());
				if (vouchersList != null && vouchersList.size() != 0) {
					fb.setVouchersList(vouchersList);
					session.setAttribute("vouchersList", vouchersList);
				} else {
					fb.setVouchersList(new ArrayList(0));
					session.setAttribute("vouchersList", new ArrayList(
							new ArrayList(0)));
				}
				mode = "BillForVoucher";
				return mapping.findForward(mode);
			}
			if (mode.equals("BillForVoucher")) {
				Debug.println("in BillForVoucher");
				fb.setAssetName(request.getParameter("workId"));
				RWS_Direct_Bills_DAO worksData = new RWS_Direct_Bills_DAO(ds);
				ArrayList emptyList = new ArrayList(0);
				ArrayList vouchersList = new ArrayList();
				vouchersList = worksData.getBills(request.getParameter("workId"));
				if (vouchersList != null && vouchersList.size() != 0) {
					fb.setVouchersList(vouchersList);
					session.setAttribute("vouchersList", vouchersList);
				} else {
					System.out.println("Empty List");
					fb.setVouchersList(emptyList);
					session.setAttribute("vouchersList", new ArrayList(
							emptyList));
				}
				fb.setNewsrcName(request.getParameter("workName"));
				fb.setHabsCode(request.getParameter("exp"));
				session.setAttribute("expWork", request.getParameter("exp"));
				Debug.println("in BillForVoucher end:" + mode);
				return mapping.findForward(mode);
			}
			if (mode.equals("addNewBill") && mode!=null) {
				Debug.println("in addNewBill");
				Rws_Direct_Bills_Bean tenderMemoBean = null;
				Debug.println("in addNew Bill mode:" + fb.getAssetName());
				ArrayList vouchers = new ArrayList();
				vouchers = (ArrayList) fb.getVouchersList();
				Debug.println("vouchers details size before adding is :"+ vouchers.size());
				RWS_Direct_Bills_DAO worksData = new RWS_Direct_Bills_DAO(ds);
				
					String billAmount = worksData.getNewBillAmount(fb.getAssetName(), request.getParameter("slNo"));
					System.out.println("Bill AMount:"+ Long.parseLong(billAmount));

					
					if (billAmount != null && !billAmount.equals("0")) {
						String value = "0";
						double val = 0.0;
						value = "" + val;
						Debug.println("value:" + value);
						tenderMemoBean = new Rws_Direct_Bills_Bean();
						tenderMemoBean.setBillSlNo(request.getParameter("slNo"));
						
						tenderMemoBean.setBillNo("");
						tenderMemoBean.setBillDate(request
								.getParameter("billNewDate"));
						tenderMemoBean.setGrossValueContractor(billAmount);
						tenderMemoBean.setGrossValueAdmissable("0");
						tenderMemoBean.setGrossValuePaidTotal("0");
						tenderMemoBean.setGrossValueOfBill("0");
						tenderMemoBean.setGrossValuePaid("0");
						tenderMemoBean.setPaymentAdmissable("0");
						tenderMemoBean.setPaymentInHand("0");
						tenderMemoBean.setBillVoucherAmount("0");
						
						vouchers.add(tenderMemoBean);
						fb.setVouchersList(vouchers);
						request.setAttribute("vouchersList", new ArrayList(vouchers));
						
					} else {
						request
								.setAttribute(
										"message",
										"There is No Additional Acheivement to raise the Bill - First Update the Acheivement Details in Program Schedule Phase");
					}
					mode = "BillForVoucher";
					Debug.println("in addNewBill end ");
					session = request.getSession(false); // so if no session is active no session is created
					return mapping.findForward(mode);
			}
			if (mode.equals("addNewFinalBill")) {
				Rws_Direct_Bills_Bean tenderMemoBean = null;
				Debug.println("in addNew Bill mode:" + fb.getAssetName());
				ArrayList vouchers = new ArrayList();
				vouchers = (ArrayList) fb.getVouchersList();
				Debug.println("vouchers details size before adding is :"
						+ vouchers.size());
				RWS_Direct_Bills_DAO worksData = new RWS_Direct_Bills_DAO(ds);
				String spillOverAmt = worksData.getNewBillAmount(fb
						.getAssetName(), "0");
				/*if (spillOverAmt != null && !spillOverAmt.equals("0")) {
					request
							.setAttribute(
									"message",
									"Before You add New Bill, You must save the Spill Over Bill By Clicking Add Last Fin.Year Bill button");
					mode = "BillForVoucher";
					return mapping.findForward(mode);
				} else {*/
					String billAmount = worksData.getNewBillAmount(fb
							.getAssetName(), request.getParameter("slNo"));
					if (billAmount != null && !billAmount.equals("0")) {
						String value = "0";
						double val = 0.0;
						value = "" + val;
						Debug.println("value:" + value);
						tenderMemoBean = new Rws_Direct_Bills_Bean();
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
						session.setAttribute("vouchersList", new ArrayList(
								vouchers));
					} else {
						request
								.setAttribute("message",
										"There is No Withheld amount to raise the Bill");
					}
					mode = "BillForVoucher";
					return mapping.findForward(mode);
				//}
			}
			if (mode.equals("addNewPrevBill")) {
				Rws_Direct_Bills_Bean tenderMemoBean = null;
				Debug.println("in addNewPrevBill mode:" + fb.getAssetName());
				ArrayList vouchers = new ArrayList();
				vouchers = (ArrayList) fb.getVouchersList();
				Debug.println("vouchers details size before adding is :"
						+ vouchers.size());

				RWS_Direct_Bills_DAO worksData = new RWS_Direct_Bills_DAO(ds);
				String billAmount = worksData.getNewBillAmount(fb
						.getAssetName(),request.getParameter("slNo"));
				if (billAmount != null && !billAmount.equals("")
						&& !billAmount.equals("0")) {
					String value = "0";
					double val = 0.0;
					value = "" + val;
					Debug.println("value:" + value);
					tenderMemoBean = new Rws_Direct_Bills_Bean();
					tenderMemoBean.setBillSlNo(request.getParameter("slNo"));
					tenderMemoBean.setBillNo("BILLS UPTO "
							+ request.getParameter("recDate"));
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
					session.setAttribute("vouchersList",
							new ArrayList(vouchers));
				} else {
					request
							.setAttribute(
									"message",
									"There are no Mile Stones Items for the Last Financial Year");
				}
				mode = "BillForVoucher";
				return mapping.findForward(mode);
			}
			if (mode.equals("removeBill")) {
				String removeList[] = request.getParameterValues("remove");
				for (int i = 0; i < removeList.length; i++) {
					Debug.println("I:" + i + " Value:" + removeList[i]);
				}
				ArrayList vouchers = new ArrayList();
				vouchers = (ArrayList) fb.getVouchersList();
				Debug.println("Bill details size before saving is :"+ vouchers.size());
				
				RWS_Direct_Bills_DAO worksData = new RWS_Direct_Bills_DAO(ds);
				String value = worksData.removeBills(vouchers, fb.getAssetName(), removeList,
							request.getParameter("remarks"), user.getUserId());
				
				request.setAttribute("message", value);
				ArrayList emptyList = new ArrayList(0);
				ArrayList vouchersList = new ArrayList();
				vouchersList = worksData.getBills(fb.getAssetName());
				if (vouchersList != null && vouchersList.size() != 0) {
					fb.setVouchersList(vouchersList);
					session.setAttribute("vouchersList", vouchersList);
				} else {
					fb.setVouchersList(emptyList);
					session.setAttribute("vouchersList", new ArrayList(
							emptyList));
				}
				mode = "BillForVoucher";
				return mapping.findForward(mode);
			}
			if (mode.equals("ExpVoucher")) {
				fb.setAssetName(request.getParameter("workId"));
				Debug.println("in ExpVoucher mode");
				RWS_Direct_Bills_DAO worksData = new RWS_Direct_Bills_DAO(ds);
				ArrayList employeesRecBy = worksData.getEmployees(fb
						.getAssetName().substring(4, 6), 7, 9);
				session.setAttribute("employeesRecBy", employeesRecBy);
				ArrayList employeesCheckMeasuredBy = worksData.getEmployees(fb
						.getAssetName().substring(4, 6), 6, 7);
				session.setAttribute("employeesCheckMeasuredBy",
						employeesCheckMeasuredBy);
				ArrayList employeesSuperCheckMeasuredBy = worksData
						.getEmployees(fb.getAssetName().substring(4, 6), 2, 6);
				session.setAttribute("employeesSuperCheckMeasuredBy",
						employeesSuperCheckMeasuredBy);
				ArrayList contractors = worksData.getContractors(fb
						.getAssetName());
				session.setAttribute("contractors", contractors);
				ArrayList progs = worksData.getAdminPrograms(request
						.getParameter("workId"));
				session.setAttribute("programs", progs);
				ArrayList emptyList = new ArrayList(0);
				ArrayList vouchersList = new ArrayList();
				vouchersList = worksData.getVouchers(request
						.getParameter("workId"));
				if (vouchersList != null && vouchersList.size() != 0) {
					fb.setVouchersList(vouchersList);
					session.setAttribute("vouchersList", vouchersList);
				} else {
					fb.setVouchersList(emptyList);
					session.setAttribute("vouchersList", new ArrayList(
							emptyList));
				}
				fb.setNewsrcName(request.getParameter("workName"));
				fb.setHabsCode(request.getParameter("exp"));
				session.setAttribute("expWork", request.getParameter("exp"));
				return mapping.findForward(mode);
			}
			if (mode.equals("addnewVoucher")) {
				Rws_Direct_Bills_Bean tenderMemoBean = null;
				Debug.println("in addNew voucher mode:" + fb.getAssetName());
				ArrayList vouchers = new ArrayList();
				
				vouchers = (ArrayList) fb.getVouchersList();
				Debug.println("vouchers details size before adding is :"
						+ vouchers.size());

				tenderMemoBean = new Rws_Direct_Bills_Bean();
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
				Debug.println("vouchers details size before saving is :"
						+ vouchers.size());
				RWS_Direct_Bills_DAO worksData = new RWS_Direct_Bills_DAO(ds);
				String value = worksData.saveVouchers(vouchers, fb.getAssetName(), (ArrayList) session.getAttribute("programs"));
				request.setAttribute("message", value);
				mode = "ExpVoucher";
				return mapping.findForward(mode);
			}
			if (mode.equals("removeVoucher")) {
				String removeList[] = request.getParameterValues("remove");
				for (int i = 0; i < removeList.length; i++) {
					Debug.println("I:" + i + " Value:" + removeList[i]);
				}
				ArrayList vouchers = new ArrayList();
				vouchers = (ArrayList) fb.getVouchersList();
				Debug.println("vouchers details size before saving is :"
						+ vouchers.size());
				RWS_Direct_Bills_DAO worksData = new RWS_Direct_Bills_DAO(ds);
				String value = worksData.removeVouchers(vouchers, fb
						.getAssetName(), removeList);
				request.setAttribute("message", value);
				ArrayList emptyList = new ArrayList(0);
				ArrayList vouchersList = new ArrayList();
				vouchersList = worksData.getVouchers(fb.getAssetName());
				if (vouchersList != null && vouchersList.size() != 0) {
					fb.setVouchersList(vouchersList);
					session.setAttribute("vouchersList", vouchersList);
				} else {
					fb.setVouchersList(emptyList);
					session.setAttribute("vouchersList", new ArrayList(
							emptyList));
				}
				mode = "ExpVoucher";
				return mapping.findForward(mode);
			}
			//Voucher from Contractor form
			if (mode.equals("ExpVoucherContractor") && mode!=null) {
				fb.setAssetName(request.getParameter("workId"));
				Debug.println("in ExpVoucher mode");
				RWS_Direct_Bills_DAO worksData = new RWS_Direct_Bills_DAO(ds);
				ArrayList employeesRecBy = worksData.getEmployees(fb.getAssetName().substring(4, 6), 7, 9);
				session.setAttribute("employeesRecBy", employeesRecBy);
				
				ArrayList employeesCheckMeasuredBy = worksData.getEmployees(fb.getAssetName().substring(4, 6), 6, 7);
				session.setAttribute("employeesCheckMeasuredBy",employeesCheckMeasuredBy);
				
				ArrayList employeesSuperCheckMeasuredBy = worksData.getEmployees(fb.getAssetName().substring(4, 6), 2, 6);
				session.setAttribute("employeesSuperCheckMeasuredBy",employeesSuperCheckMeasuredBy);
				
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
					session.setAttribute("vouchersList", new ArrayList(
							emptyList));
				}
				fb.setNewsrcName(request.getParameter("workName"));
				System.out.println("request.getParameter - - ->"+ request.getParameter("slNo"));
				fb.setHabsCode(request.getParameter("slNo"));				
				//fb.setAdminScPopu(request.getParameter("mstoneName"));
				//fb.setAdminSTPopu(request.getParameter("mstoneStageName"));
				return mapping.findForward(mode);
			}
			if (mode.equals("addnewVoucherContract")) {
				System.out.println("sdfslkdf- - ->" + fb.getMileStoneSno());
				Rws_Direct_Bills_Bean tenderMemoBean = null;
				Debug.println("in addnewVoucherContract mode:"
						+ fb.getAssetName());
				ArrayList vouchers = new ArrayList();	
				RWS_Direct_Bills_DAO worksData = new RWS_Direct_Bills_DAO(ds);
				vouchers = (ArrayList) fb.getVouchersList();
				
				Debug.println("vouchers details size before adding is :"+ vouchers.size() + "");
				
				if (worksData.getNewVoucherAmount(fb.getAssetName()) == 1) {
					request
							.setAttribute("message",
									"Before entering the New Voucher, You must add the Voucher for Bill Voucher");
				} else {
					
					int aaa = worksData.getNewVoucherAmount(fb.getAssetName());
					String ss = Integer.toString(aaa);
					tenderMemoBean = new Rws_Direct_Bills_Bean();
					tenderMemoBean.setMileStoneSno("0");
					tenderMemoBean.setBillSlNo("0");
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
					session.setAttribute("vouchersList",
							new ArrayList(vouchers));
				}
				mode = "ExpVoucherContractor";
				return mapping.findForward(mode);
			}
			if (mode.equals("addnewVoucherPrevContract")) {
				Rws_Direct_Bills_Bean tenderMemoBean = null;
				Debug.println("in addnewVoucherContract mode:"
						+ fb.getAssetName());
				ArrayList vouchers = new ArrayList();
				
				vouchers = (ArrayList) fb.getVouchersList();
				Debug.println("vouchers details size before adding is :"
						+ vouchers.size() + " and sno:" + fb.getHabsCode());
				RWS_Direct_Bills_DAO worksData = new RWS_Direct_Bills_DAO(ds);
				String amt = worksData.getBillVoucherAmountbyWorkId(fb.getAssetName(),
						"0");
				String[] amts = amt.split("/");
				if (Integer.parseInt(amts[0]) > 0) {
					tenderMemoBean = new Rws_Direct_Bills_Bean();
					tenderMemoBean.setMileStoneSno(fb.getHabsCode());
					tenderMemoBean.setProgCode("");
					tenderMemoBean.setMBookNo("");
					tenderMemoBean.setEmpCodeRecorded("");
					tenderMemoBean.setRecordedDate("");
					tenderMemoBean.setEmpCode("");
					tenderMemoBean.setCheckMesuaredDate("");
					tenderMemoBean.setVoucherNo("VOUCHERS UPTO "
							+ request.getParameter("recDate"));
					tenderMemoBean.setVoucherDate(request
							.getParameter("recDate"));
					tenderMemoBean.setChequeNo("");
					tenderMemoBean.setChequeDate("");
					tenderMemoBean.setEmpCodeSuper("");
					tenderMemoBean.setSuperCheckMesuaredDate("");
					tenderMemoBean.setCheckMesuaredRemarks("");
					tenderMemoBean.setPaymentAdmissable("0");
					tenderMemoBean.setBillVoucherAmount("0");
					tenderMemoBean.setBillSlNo("0");
					Debug.println("amt:" + amt);
					tenderMemoBean.setPaymentAdmissable(amts[0]);
					tenderMemoBean.setBillVoucherAmount(amts[1]);
					tenderMemoBean.setVoucherAmount(amts[0]);
					vouchers.add(tenderMemoBean);
					session.setAttribute("vouchersList",
							new ArrayList(vouchers));
				} else {
					request
							.setAttribute("message",
									"You cannot add the Voucher related bill");
				}
				mode = "ExpVoucherContractor";
				return mapping.findForward(mode);
			}
			if (mode.equals("saveVouchersContract")) {
				ArrayList vouchers = new ArrayList();
				vouchers = (ArrayList) fb.getVouchersList();
				String billslNo= request.getParameter("billSlNo");
				
				Debug.println("vouchers details size before saving is :"
						+ vouchers.size());				
				RWS_Direct_Bills_DAO worksData = new RWS_Direct_Bills_DAO(ds);
				
				String value = worksData.saveVouchers(vouchers, fb.getAssetName());
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
			if (mode.equals("removeVoucherContract")) {
				String removeList[] = request.getParameterValues("remove");
				for (int i = 0; i < removeList.length; i++) {
					Debug.println("I:" + i + " Value:" + removeList[i]);
				}
				ArrayList vouchers = new ArrayList();
				vouchers = (ArrayList) fb.getVouchersList();
				Debug.println("vouchers details size before saving is :"
						+ vouchers.size());
				RWS_Direct_Bills_DAO worksData = new RWS_Direct_Bills_DAO(ds);
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
					session.setAttribute("vouchersList", new ArrayList(
							emptyList));
				}
				mode = "ExpVoucherContractor";
				return mapping.findForward(mode);
			}
			if (mode.equals("vouchersIssue")) {
				ArrayList programMileStones = new ArrayList();
				RWS_Direct_Bills_DAO worksData = new RWS_Direct_Bills_DAO(ds);
				programMileStones = worksData.getProgramMileStones(ds, request
						.getParameter("workId"));
				Debug.println("milestones size:" + programMileStones.size());
				fb.setMileStones(programMileStones);
				return mapping.findForward(mode);
			}
			
			
		}
		 catch (Exception e) {
				Debug.println("Exception in action class" + e);
			}
		 
		return mapping.findForward(SUCCESS);
	}
}



			
					