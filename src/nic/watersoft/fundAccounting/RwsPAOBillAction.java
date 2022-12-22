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

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;


public class RwsPAOBillAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		DataSource dataSource = getDataSource(request);
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		RwsPAOBillActionForm rwsPAOBillActionForm = (RwsPAOBillActionForm) form;
		RwsOffices offices = null;
		if (user == null) {
			return mapping.findForward("expire");
		}
		if (!(user.getUserId() != null && (user.getUserId().equals(Constants.EE_BUDGET)))) {
			return mapping.findForward("unAuthorise");
		}
		String userId = user.getUserId();
		offices = new RwsOffices(dataSource);
		String mode = request.getParameter("mode");
		String mode1 = request.getParameter("mode1");
		RwsPAOBillActionDAO rwsPAOBillActionDAO = new RwsPAOBillActionDAO();

		if (mode != null && mode.equals("data")) {

			if (mode1 != null && mode1.equalsIgnoreCase("clear")) {
				rwsPAOBillActionForm.setDivisions(new ArrayList());
				session.setAttribute("divisions", new ArrayList());
				session.setAttribute("yearsList", new ArrayList());
				rwsPAOBillActionForm.setCircleCode("");
				rwsPAOBillActionForm.setDivCode("");
				rwsPAOBillActionForm.setYearCode("");
				rwsPAOBillActionForm.setMonthCode("");

				session.setAttribute("billsList", new ArrayList());
				rwsPAOBillActionForm.setBillsList(new ArrayList());
				session.setAttribute("yearsList", new ArrayList());
				session.setAttribute("monthsList", new ArrayList());
				rwsPAOBillActionForm.setSoFarProcessAmount("0.0");
				rwsPAOBillActionForm.setSelectedBillCount("0");

			}
			ArrayList<LabelValueBean> circles = offices.CircleCombo("1");
			session.setAttribute("circles", circles);
			rwsPAOBillActionForm.setCircles(circles);

		} else if (mode != null && mode.equals("divisions")) {

			rwsPAOBillActionForm.setSoFarProcessAmount("0.0");
			rwsPAOBillActionForm.setSelectedBillCount("0");

			session.setAttribute("billsList", new ArrayList());
			rwsPAOBillActionForm.setBillsList(new ArrayList());
			ArrayList<LabelValueBean> divisions = offices.DivisionCombo("1",
					rwsPAOBillActionForm.getCircleCode());
			session.setAttribute("divisions", divisions);
			rwsPAOBillActionForm.setDivisions(divisions);
			ArrayList<LabelValueBean> yearsList = rwsPAOBillActionDAO
					.getYears(rwsPAOBillActionForm);
			session.setAttribute("yearsList", yearsList);

			ArrayList<LabelValueBean> monthsList = rwsPAOBillActionDAO
					.getMonths(rwsPAOBillActionForm);
			session.setAttribute("monthsList", monthsList);

			mode = "data";
		}

		else if (mode != null && mode.equals("billsList")) {

			rwsPAOBillActionForm
					.setBillsList(rwsPAOBillActionDAO.getBillsList(
							rwsPAOBillActionForm.getCircleCode(),
							rwsPAOBillActionForm));
		

			mode = "data";
		} else if (mode != null && mode.equals("save")) {
		
		     String storedToken = (String)session.getAttribute("csrfToken");
		     String token = request.getParameter("token");
		     if (storedToken.equals(token))
		     {	
			rwsPAOBillActionDAO.saveBills(rwsPAOBillActionForm, request);
			rwsPAOBillActionForm.getBillsList().clear();
			rwsPAOBillActionForm
					.setBillsList(rwsPAOBillActionDAO.getBillsList(
							rwsPAOBillActionForm.getCircleCode(),
							rwsPAOBillActionForm));
			mode = "data";
		}
		}

		return mapping.findForward(mode);
	}
}
