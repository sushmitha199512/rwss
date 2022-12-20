package nic.watersoft.masters;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import nic.watersoft.commons.RwsUser;

public class rws_PriorityEntryAct_frm extends Action {
	protected ActionForm buildPriorityForm(String priorityCode, String priorityFrom, HttpServletRequest request)
			throws Exception {
		PriorityForm form = null;
		RwsMaster rwsMaster = RwsMasterData.getPriority(priorityCode, priorityFrom, getDataSource(request));
		if (rwsMaster != null) {
			form = new PriorityForm();
			form.setPriorityCode(rwsMaster.getPriorityCode());
			form.setPriorityDesc(rwsMaster.getPriorityDesc());
			form.setPriorityFrom(rwsMaster.getPriorityFrom());
		}
		return form;
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		int ans = 0;
		String message = null;
		String displaymess = null;
		ArrayList prioritys = null;
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");
		PriorityForm frm = (PriorityForm) form;
		String mode = frm.getMode();
		if (mode.equalsIgnoreCase("data")) {
			try {
				request.setAttribute("code", RwsMasterData.getPriorityCode(getDataSource(request)));
			} catch (Exception e) {
				System.err.println("The error in rws_PriorityEntryAct_frm in inc is " + e);
			}
		}
		if (mode.equalsIgnoreCase("view")) {
			try {
				prioritys = RwsMasterData.getPrioritys(getDataSource(request));
				session.setAttribute("prioritys", prioritys);
			} catch (Exception e) {
				System.err.println("The error in rws_PriorityEntryAct_frm in view is " + e);
			}
		}
		if (mode.equalsIgnoreCase("save")) {
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {
					RwsMaster rwsMaster = new RwsMaster();
					rwsMaster.setPriorityCode(frm.getPriorityCode());
					rwsMaster.setPriorityDesc(frm.getPriorityDesc());
					rwsMaster.setPriorityFrom(frm.getPriorityFrom());
					ans = RwsMasterData.insertPriority(rwsMaster, getDataSource(request));
					request.setAttribute("code", RwsMasterData.getPriorityCode(getDataSource(request)));
				} catch (Exception e) {
					System.err.println("The error in rws_PriorityEntryAct_frm in insert is " + e);
				}
			}
			if (ans < 1) {
				message = "The Record Cant be inserted   ";
			} else {
				message = "Record Inserted Successfully";
			}
			request.setAttribute("message", message);
		}
		if (mode.equalsIgnoreCase("get")) {
			try {
				form = buildPriorityForm(request.getParameter("priorityCode"), request.getParameter("priorityFrom"),
						request);
				if ("request".equalsIgnoreCase(mapping.getScope())) {
					request.setAttribute(mapping.getAttribute(), form);
				} else {
					session.setAttribute(mapping.getAttribute(), form);
				}
			} catch (Exception e) {
				System.err.println("The error in rws_PriorityEntryAct_frm in get is " + e);
			}
		}
		if (mode.equalsIgnoreCase("edit")) {
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {
					RwsMaster rwsMaster = new RwsMaster();
					rwsMaster.setPriorityCode(frm.getPriorityCode());
					rwsMaster.setPriorityDesc(frm.getPriorityDesc());
					rwsMaster.setPriorityFrom(frm.getPriorityFrom());
					RwsMasterData.updatePriority(rwsMaster, getDataSource(request));
				} catch (Exception e) {
					System.err.println("The error in rws_PriorityEntryAct_frm in edit is " + e);
				}
			}
		}
		if (mode.equalsIgnoreCase("delete")) {
			try {
				ans = RwsMasterData.removePriority(request.getParameter("priorityCode"),
						request.getParameter("priorityFrom"), getDataSource(request));
				if (ans > 0) {
					displaymess = "Data deleted Succesfully";
				} else {
					displaymess = "Data cannot be deleted";
				}
				request.setAttribute("displaymess", displaymess);
			} catch (Exception e) {
				System.err.println("The error in rws_PriorityEntryAct_frm in delete is " + e);
			}
		}
		return (mapping.findForward(mode));
	}
}
