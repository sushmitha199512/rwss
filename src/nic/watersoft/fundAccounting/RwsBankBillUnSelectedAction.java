package nic.watersoft.fundAccounting;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.works.WorksData1;
import nic.watersoft.works.rws_projectshelf_works_probabledt_frm;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class RwsBankBillUnSelectedAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		DataSource dataSource = getDataSource(request);
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		//System.out.println("mode bank bill unselected action :");
		if (user == null)
			return mapping.findForward("expire");
		
		/*if(!(user.getUserId()!=null &&((user.getUserId().equals(Constants.EE_BUDGET))|| (Constants.IsEEUser(user.getUserId()) )))) {
			return mapping.findForward("unAuthorise");
		}*/
	
		
		RwsBankBillActionForm rwsBankBillActionForm = (RwsBankBillActionForm) form;
		RwsOffices offices = null;
		offices = new RwsOffices(dataSource);
		String mode = request.getParameter("mode");
		String mode1 = request.getParameter("mode1");
		if(mode1==null || mode1==""){
			mode1="clear";
		}
		RwsBankBillDAO rwsBankBillActionDAO = new RwsBankBillDAO();
		// System.out.println("mode bank bill unselected action :"+mode);
		if (mode != null && mode.equals("data")) {

			if (mode1 != null && mode1.equalsIgnoreCase("clear")) {
				rwsBankBillActionForm.setDivisions(new ArrayList());
				session.setAttribute("divisions", new ArrayList());
				session.setAttribute("yearsList", new ArrayList());
				rwsBankBillActionForm.setCircleCode("");
				rwsBankBillActionForm.setDivCode("");
				rwsBankBillActionForm.setYearCode("");
				rwsBankBillActionForm.setMonthCode("");

				session.setAttribute("billsList", new ArrayList());
				rwsBankBillActionForm.setBillsList(new ArrayList());
				session.setAttribute("yearsList", new ArrayList());
				session.setAttribute("monthsList", new ArrayList());
				rwsBankBillActionForm.setSoFarProcessAmount("0.0");
				rwsBankBillActionForm.setSelectedBillCount("0");

			}
			ArrayList<LabelValueBean> circles = offices.CircleCombo("1");
			session.setAttribute("circles", circles);
			rwsBankBillActionForm.setCircles(circles);

		} else if (mode != null && mode.equals("divisions")) {

			rwsBankBillActionForm.setSoFarProcessAmount("0.0");
			rwsBankBillActionForm.setSelectedBillCount("0");

			session.setAttribute("billsList", new ArrayList());
			rwsBankBillActionForm.setBillsList(new ArrayList());
			ArrayList<LabelValueBean> divisions = offices.DivisionCombo("1",
					rwsBankBillActionForm.getCircleCode());
			session.setAttribute("divisions", divisions);
			rwsBankBillActionForm.setDivisions(divisions);
			ArrayList<LabelValueBean> yearsList = rwsBankBillActionDAO
					.getYears(rwsBankBillActionForm);
			session.setAttribute("yearsList", yearsList);

			ArrayList<LabelValueBean> monthsList = rwsBankBillActionDAO
					.getMonths(rwsBankBillActionForm);
			session.setAttribute("monthsList", monthsList);

			mode = "data";
		}

		else if (mode != null && mode.equals("billsList")) {

			rwsBankBillActionForm
					.setBillsList(rwsBankBillActionDAO.getBillsList(
							rwsBankBillActionForm.getCircleCode(),
							rwsBankBillActionForm,getServlet()));
			mode = "data";
		}else if (mode != null && mode.equals("billsUnselectedList")) {

			ArrayList<RwsBankBillRecord> unSelectedBillsList = rwsBankBillActionDAO.getUnSelectedBillsList(
					rwsBankBillActionForm.getCircleCode(),
					rwsBankBillActionForm,getServlet());
			rwsBankBillActionForm
					.setBillsList(unSelectedBillsList);
			session.setAttribute("billsList", unSelectedBillsList);
			mode = "data";
		}
	else if(mode != null && mode.equals("billsUnselectedListExcel")){
			
			ArrayList<RwsBankBillRecord> unSelectedBillsList = (ArrayList<RwsBankBillRecord>) session.getAttribute("billsList");
			
			rwsBankBillActionForm.setBillsList(unSelectedBillsList);
			System.out.println("excel mode"+unSelectedBillsList.size());
			for(RwsBankBillRecord b : rwsBankBillActionForm.getBillsList()){
				System.out.println("each record :"+b.toString());
			}
			mode = "excel";
			//session.removeAttribute("billsList");
		}
		else if (mode != null && mode.equals("save")) {

			 String storedToken = (String)session.getAttribute("csrfToken");
		     String token = request.getParameter("token");
		     if (storedToken.equals(token))
		     {	
			rwsBankBillActionDAO.saveBills(rwsBankBillActionForm, request);
			rwsBankBillActionForm.getBillsList().clear();
			rwsBankBillActionForm
					.setBillsList(rwsBankBillActionDAO.getBillsList(
							rwsBankBillActionForm.getCircleCode(),
							rwsBankBillActionForm,getServlet()));
			mode = "data";
		     }
			
		}else if (mode != null && mode.equals("milestones")) {
			rws_projectshelf_works_probabledt_frm frm = new rws_projectshelf_works_probabledt_frm();
			ArrayList mileStones =new ArrayList();
			String work_id=request.getParameter("workid");
			frm.setWorkId(work_id);
			WorksData1 wd = new WorksData1();
			mileStones=wd.getMileStoneCodesAndStages(frm);
			rwsBankBillActionForm.setMilestones(mileStones);
			session.setAttribute("milestones", mileStones);
		}
		
		
		return mapping.findForward(mode);
	}

}
