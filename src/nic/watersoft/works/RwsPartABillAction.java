
package nic.watersoft.works;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class RwsPartABillAction extends Action {

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HttpSession session = request.getSession(true);
		RwsWorksDAO rwsWorksDAO = new RwsWorksDAO();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");	
		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || Constants.IsEEUser(user.getUserId()) || Constants.IsAOUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");	
		}
		String mode = request.getParameter("mode");
		RwspartABillForm parABillform = (RwspartABillForm) form;
		request.setAttribute("workCode", parABillform.getWorkId());
		WorksData1 worksData = new WorksData1();
		if (mode != null && mode.equals("BillsForPartA")) {
			String workId = request.getParameter("workId");
			String workName = request.getParameter("workName");
			parABillform.setWorkName(workName);
			parABillform.setWorkId(workId);
			request.setAttribute("workCode", parABillform.getWorkId());
			session.setAttribute("itemsList", rwsWorksDAO.getItemsList(workId));

			ArrayList billsList = new ArrayList();
			billsList = rwsWorksDAO.getBills(request.getParameter("workId"),
					Constants.TYPE_A_BILL);
			if (billsList != null && billsList.size() != 0) {
				parABillform.setBillsList(billsList);
				session.setAttribute("billsList", billsList);
			} else {
				parABillform.setBillsList(new ArrayList());
				session.setAttribute("billsList", new ArrayList());
			}
			ArrayList employeesRecBy = worksData.getEmployees(workId.substring(4, 6), 7, 9);
            session.setAttribute("employeesRecBy", employeesRecBy);
            ArrayList employeesCheckMeasuredBy = worksData.getEmployees(workId.substring(4, 6), 6, 7);
            session.setAttribute("employeesCheckMeasuredBy", employeesCheckMeasuredBy);
            ArrayList employeesSuperCheckMeasuredBy = worksData.getEmployees(workId.substring(4, 6), 2, 6);
            session.setAttribute("employeesSuperCheckMeasuredBy", employeesSuperCheckMeasuredBy);
		}
		if(mode!=null && mode.equals("editScannedCopy")){
			
			
			ArrayList billsList=(ArrayList)session.getAttribute("billsList");
			
			int index=Integer.parseInt(request.getParameter("recIndex"));
			
			if(billsList.get(index)!=null){
				
				RwsPartABillRecord tenderMemo=(RwsPartABillRecord)billsList.get(index);
				if(tenderMemo.getBillEEForwardDate()!=null && !tenderMemo.getBillEEForwardDate().equals("")){
					request.setAttribute("message","EE Forwarded Bill Not Allow to Edit.");
				}else{
					tenderMemo.setBillSaved("");
				}
			}
			
			mode = "BillsForPartA";
			return mapping.findForward(mode);
			
		}
		

		if (mode != null && mode.equals("showScannedCopy")) {
			
			String workId = parABillform.getWorkId();
			byte a[]=worksData.getScannedCopy(workId,request.getParameter("slNo"));
						
			session.setAttribute("copyData",a);

			mode = "showFile";
			return mapping.findForward(mode);
			
		}
		if (mode.equals("addNewBill")) {

			RwsPartABillRecord rwsPartABillRecord = null;
			ArrayList billsList = new ArrayList();

			billsList = (ArrayList) parABillform.getBillsList();

			rwsPartABillRecord = new RwsPartABillRecord();
				rwsPartABillRecord.setBillSlNo(rwsWorksDAO.getBillSlNo(parABillform.getWorkId()));

			String billAmount = "0";
			rwsPartABillRecord.setBillNo("");
			rwsPartABillRecord.setBillDate(request.getParameter("billDatee"));
			rwsPartABillRecord.setGrossValueUpToThisBill("0");
			rwsPartABillRecord.setGrossValueAsPerPayOrderUpToThisBill("0");
			rwsPartABillRecord.setGrossValueUpToThisBill("0");
			rwsPartABillRecord.setGrossValueAsPerPayOrderUpToThisBill("0");
			rwsPartABillRecord.setAmountReleased("0");
			rwsPartABillRecord.setAmountReleased("0");
			rwsPartABillRecord.setAmountPaid("0");
			billsList.add(rwsPartABillRecord);
			session.setAttribute("billsList", new ArrayList(billsList));
			parABillform.setBillsList(billsList);
			mode = "BillsForPartA";

		}

		if (mode != null && mode.equals("getItemAmount")) {


			ArrayList billsList = (ArrayList) parABillform.getBillsList();
			int i = 0;
			if (request.getParameter("index") != null) {
				i = Integer.parseInt(request.getParameter("index"));
			}

			RwsPartABillRecord rwsPartABillRecord = (RwsPartABillRecord) billsList
					.get(i);

			rwsWorksDAO.setBillAmount(rwsPartABillRecord, parABillform
					.getWorkId());

			request.setAttribute("workId", parABillform.getWorkId());

			mode = "BillsForPartA";
		}

		if (mode != null && mode.equals("saveBills")) {
			String storedToken = (String)session.getAttribute("csrfToken");
		    String token = request.getParameter("token");
		    if (storedToken.equals(token))
		    {
			String workId = parABillform.getWorkId();

			String value = rwsWorksDAO.saveBills(workId, parABillform,getServlet());
			
			request.setAttribute("message", value);
			ArrayList billsList = rwsWorksDAO.getBills(workId,
					Constants.TYPE_A_BILL);
			parABillform.setBillsList(new ArrayList());
			session.setAttribute("billsList", new ArrayList());
			if (billsList != null && billsList.size() != 0) {
				parABillform.setBillsList(billsList);
				session.setAttribute("billsList", billsList);
			} else {
				parABillform.setBillsList(new ArrayList());
				session.setAttribute("billsList", new ArrayList());
			}
			
			mode = "BillsForPartA";
		    }
		}

		if (mode != null && mode.equals("removeBill")) {

			String removeList[] = request.getParameterValues("remove");
			String reasonForDeletion = request.getParameter("remarks");
			String value = rwsWorksDAO.removeBill(parABillform, removeList,
					reasonForDeletion, user.getUserId());
			request.setAttribute("message", value);

			ArrayList billsList = new ArrayList();
			billsList = rwsWorksDAO.getBills(parABillform.getWorkId(),
					Constants.TYPE_A_BILL);
			if (billsList != null && billsList.size() != 0) {
				parABillform.setBillsList(billsList);
				session.setAttribute("billsList", billsList);
			} else {
				parABillform.setBillsList(new ArrayList());
				session.setAttribute("billsList", new ArrayList());
			}
			mode = "BillsForPartA";
		}

		if (mode.equals("VouchersForPartA")) {
			String work_id = request.getParameter("workId");
			
			ArrayList employeesRecBy = worksData.getEmployees(work_id
					.substring(4, 6), 7, 9);
			session.setAttribute("employeesRecBy", employeesRecBy);
			ArrayList employeesCheckMeasuredBy = worksData.getEmployees(work_id
					.substring(4, 6), 6, 7);
			session.setAttribute("employeesCheckMeasuredBy",
					employeesCheckMeasuredBy);
			ArrayList employeesSuperCheckMeasuredBy = worksData.getEmployees(
					work_id.substring(4, 6), 2, 6);
			session.setAttribute("employeesSuperCheckMeasuredBy",
					employeesSuperCheckMeasuredBy);
			ArrayList progs = worksData.getAdminPrograms(request
					.getParameter("workId"));
			session.setAttribute("programs", progs);
			ArrayList contractors = worksData.getContractors(work_id);

			LabelValueBean bean = new LabelValueBean();
			bean.setValue("Part-A");
			bean.setLabel("Part-A");
			contractors.add(bean);
			session.setAttribute("contractors", contractors);
			ArrayList bills = worksData.getAllBills(work_id);
			session.setAttribute("bills", bills);
			ArrayList emptyList = new ArrayList(0);
			ArrayList vouchersList = new ArrayList();
			vouchersList = rwsWorksDAO.getVouchers(request
					.getParameter("workId"));
			if (vouchersList != null && vouchersList.size() != 0) {
				parABillform.setVouchersList(vouchersList);
				session.setAttribute("vouchersList", vouchersList);
			} else {
				parABillform.setVouchersList(emptyList);
				session.setAttribute("vouchersList", new ArrayList(emptyList));
			}
			return mapping.findForward(mode);
		}

		if (mode.equals("addnewVoucher")) {

			ArrayList vouchers = new ArrayList();
			vouchers = (ArrayList) parABillform.getVouchersList();

			RwsPartABillRecord rwsPartABillRecord = new RwsPartABillRecord();
			rwsPartABillRecord.setProgCode("");
			rwsPartABillRecord.setMBookNo("");
			rwsPartABillRecord.setEmpCodeRecorded("");
			rwsPartABillRecord.setRecordedDate("");
			rwsPartABillRecord.setEmpCode("");
			rwsPartABillRecord.setCheckMesuaredDate("");
			rwsPartABillRecord.setVoucherNo("");
			rwsPartABillRecord.setVoucherDate("");
			rwsPartABillRecord.setVoucherAmount("");
			rwsPartABillRecord.setChequeNo("");
			rwsPartABillRecord.setChequeDate("");
			rwsPartABillRecord.setEmpCodeSuper("");
			rwsPartABillRecord.setSuperCheckMesuaredDate("");
			rwsPartABillRecord.setCheckMesuaredRemarks("");
			vouchers.add(rwsPartABillRecord);
			parABillform.setVouchersList(vouchers);
			session.setAttribute("vouchersList", vouchers);

			mode = "VouchersForPartA";
			return mapping.findForward(mode);
		}
		if (mode.equals("saveVouchers")) {
			String storedToken = (String)session.getAttribute("csrfToken");
		    String token = request.getParameter("token");
		    if (storedToken.equals(token))
		    {
			ArrayList vouchers = new ArrayList();
			String work_id = request.getParameter("workId");
			vouchers = (ArrayList) parABillform.getVouchersList();

			for (int i = 0; i < vouchers.size(); i++) {
				RwsPartABillRecord rwsPartABillRecord = (RwsPartABillRecord) vouchers
						.get(i);

			}
			String value = rwsWorksDAO.saveVouchers(vouchers, work_id,
					(ArrayList) session.getAttribute("programs"));
			request.setAttribute("message", value);
			mode = "VouchersForPartA";
			return mapping.findForward(mode);
		    }
		}

		if (mode.equals("removeVoucher")) {
			String removeList[] = request.getParameterValues("remove");
			String work_id = request.getParameter("workId");
			
			ArrayList vouchers = new ArrayList();
			vouchers = (ArrayList) parABillform.getVouchersList();

			String value = rwsWorksDAO.removeVouchers(vouchers, work_id,
					removeList);
			request.setAttribute("message", value);
			ArrayList emptyList = new ArrayList(0);
			ArrayList vouchersList = new ArrayList();
			vouchersList = rwsWorksDAO.getVouchers(work_id);
			if (vouchersList != null && vouchersList.size() != 0) {
				parABillform.setVouchersList(vouchersList);
				session.setAttribute("vouchersList", vouchersList);
			} else {
				parABillform.setVouchersList(emptyList);
				session.setAttribute("vouchersList", new ArrayList(emptyList));
			}
			mode = "VouchersForPartA";
			return mapping.findForward(mode);
		}

		return mapping.findForward(mode);
	}

}