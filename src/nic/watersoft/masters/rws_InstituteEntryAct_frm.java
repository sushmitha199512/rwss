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

public class rws_InstituteEntryAct_frm extends Action {
	protected ActionForm buildInstituteForm(String instituteCode, HttpServletRequest request) throws Exception {
		InstituteForm form = null;
		RwsMaster rwsMaster = RwsMasterData.getInstitute(instituteCode, getDataSource(request));
		if (rwsMaster != null) {
			form = new InstituteForm();
			form.setInstituteCode(rwsMaster.getInstituteCode());
			form.setInstituteName(rwsMaster.getInstituteName());
		}
		return form;
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		int ans = 0;
		String message = null;
		String displaymess = null;
		ArrayList institutes = null;
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");
		InstituteForm frm = (InstituteForm) form;
		String mode = frm.getMode();
		if (mode.equalsIgnoreCase("data")) {
			try {
				request.setAttribute("instcode", RwsMasterData.getInstituteCode(getDataSource(request)));
			} catch (Exception e) {
				System.err.println("The error in rws_InstituteEntryAct_frm in inc is " + e);
			}
		}
		if (mode.equalsIgnoreCase("view")) {
			try {
				RwsMasterData rwsMasterData = new RwsMasterData();
				institutes = rwsMasterData.getInstitutes(getDataSource(request));
				session.setAttribute("institutes", institutes);
			} catch (Exception e) {
				System.err.println("The error in rws_InstituteEntryAct_frm in view is " + e);
			}
		}
		if (mode.equalsIgnoreCase("save")) {			
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {
					RwsMaster rwsMaster = new RwsMaster();
					rwsMaster.setInstituteCode(frm.getInstituteCode());
					rwsMaster.setInstituteName(frm.getInstituteName());
					ans = RwsMasterData.insertInstitute(rwsMaster, getDataSource(request));
					request.setAttribute("instcode", RwsMasterData.getInstituteCode(getDataSource(request)));
				}
				catch (Exception e) {
					System.err.println("The error in rws_InstituteEntryAct_frm in insert is " + e);
				}
			}
			if (ans < 1) {
				if (RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() > 0)
					message = RwsMasterData.errorMessage;
				else
					message = "The Record can't be inserted.";
			} else {
				message = "Record Inserted Successfully";
			}
			request.setAttribute("message", message);
		}
		if (mode.equalsIgnoreCase("get")) {
			try {
				form = buildInstituteForm(request.getParameter("instituteCode"), request);
				if ("request".equalsIgnoreCase(mapping.getScope())) {
					request.setAttribute(mapping.getAttribute(), form);
				} else {
					session.setAttribute(mapping.getAttribute(), form);
				}
			} catch (Exception e) {
				System.err.println("The error in rws_InstituteEntryAct_frm in get is " + e);
			}
		}
		if (mode.equalsIgnoreCase("edit")) {
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {
					RwsMaster rwsMaster = new RwsMaster();
					rwsMaster.setInstituteCode(frm.getInstituteCode());
					rwsMaster.setInstituteName(frm.getInstituteName());
					ans = RwsMasterData.updateInstitute(rwsMaster, getDataSource(request));
				} catch (Exception e) {
					System.err.println("The error in rws_InstituteEntryAct_frm in edit is " + e);
				}
			}
			if (ans < 1) {
				if (RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() > 0)
					message = RwsMasterData.errorMessage;
				else
					message = "The record cannot be updated.";
				mode = "get";
				request.setAttribute("message", message);
			}
		}
		if (mode.equalsIgnoreCase("delete")) {
			try {
				ans = RwsMasterData.removeInstitute(request.getParameter("instituteCode"), getDataSource(request));
				if (ans > 0) {
					displaymess = "Data deleted Succesfully";
				} else {
					displaymess = "Data cannot be deleted";
				}
				request.setAttribute("displaymess", displaymess);
			} catch (Exception e) {
				System.err.println("The error in rws_InstituteEntryAct_frm in delete is " + e);
			}
		}
		return (mapping.findForward(mode));
	}
}
