package nic.watersoft.masters;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_DivisionEntryAct_frm extends Action {
	protected ActionForm buildDivisionForm(String hoc, String coc, String doc, HttpServletRequest request)
			throws Exception {
		DivisionForm form = null;
		RwsMaster rwsMaster = RwsMasterData.getDivision(hoc, coc, doc, getDataSource(request));

		if (rwsMaster != null) {
			form = new DivisionForm();

			form.setHoc(rwsMaster.getHoc() + " " + rwsMaster.getHon());
			form.setCoc(rwsMaster.getCoc() + " " + rwsMaster.getCon());
			form.setDoc(rwsMaster.getDoc());
			form.setDon(rwsMaster.getDon());
			form.setDivStatus(rwsMaster.getDivStatus());

		}
		return form;
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {		
		int ans = 0;
		String message = null;
		String displaymess = null;
		ArrayList divisions = null;
		ArrayList circles = new ArrayList();
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");	
		DivisionForm frm = (DivisionForm) form;
		String mode = frm.getMode();
		if (mode.equalsIgnoreCase("data")) {
			try {
				RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
				circles = rwsOffices.getCircles("1");
				session.setAttribute("circles", circles);
				request.setAttribute("code", RwsMasterData.getDivisionCode(request.getParameter("hoc"),
				request.getParameter("coc"), getDataSource(request)));
			} catch (Exception e) {
				// System.out.println("The error in Division inc is "+e);
			}
		}
		if (mode.equalsIgnoreCase("view")) {
			try {
				String coc = frm.getCoc();
				if (coc.indexOf(" ") != -1)
					coc = coc.substring(0, 2);
				divisions = RwsMasterData.getDivisions(getDataSource(request), coc);
				session.setAttribute("divisions", divisions);
			} catch (Exception e) {
				// System.out.println("The error in Division View is "+e);
			}
		}
		if (mode.equalsIgnoreCase("save")) {
			try {
				session = request.getSession();
				String storedToken = (String) session.getAttribute("csrfToken");
				String token = request.getParameter("token");
				if (storedToken.equals(token)) {
					RwsMaster rwsMaster = new RwsMaster();
					rwsMaster.setHoc(frm.getHoc());
					rwsMaster.setCoc(frm.getCoc());
					rwsMaster.setDoc(frm.getDoc());
					rwsMaster.setDon(frm.getDon());
					rwsMaster.setDivStatus(frm.getDivStatus());
					ans = RwsMasterData.insertDivision(rwsMaster, getDataSource(request));
					frm.reset(mapping, request);
				}
			} catch (Exception e) {
				// System.out.println("the error in Division Insert is "+e);
			}
			if (ans < 1) {
				if (RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() > 0)
					message = RwsMasterData.errorMessage;
				else
					message = "The Record Cant be inserted   ";
			} else {
				message = "Record Inserted Successfully";
			}
			request.setAttribute("message", message);
		}
		if (mode.equalsIgnoreCase("get")) {
			try {
				form = buildDivisionForm(request.getParameter("hoc"), request.getParameter("coc"),
						request.getParameter("doc"), request);
				if ("request".equalsIgnoreCase(mapping.getScope())) {
					request.setAttribute(mapping.getAttribute(), form);
				} else {
					session.setAttribute(mapping.getAttribute(), form);
				}
			} catch (Exception e) {
				// System.out.println("the error in Division get is "+e);
			}
		}
		if (mode.equalsIgnoreCase("edit")) {
			try {
				session = request.getSession();
				String storedToken = (String) session.getAttribute("csrfToken");
				String token = request.getParameter("token");
				if (storedToken.equals(token)) {
					RwsMaster rwsMaster = new RwsMaster();
					rwsMaster.setHoc(frm.getHoc().substring(0, frm.getHoc().indexOf(" ")));
					rwsMaster.setCoc(frm.getCoc().substring(0, frm.getCoc().indexOf(" ")));
					rwsMaster.setDoc(frm.getDoc());
					rwsMaster.setDon(frm.getDon());
					ans = RwsMasterData.updateDivision(rwsMaster, getDataSource(request), frm.getDivStatus());
				}
			} catch (Exception e) {
				// System.out.println("the error in Division edit is "+e);
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
				int del = RwsMasterData.removeDivision(request.getParameter("hoc"), request.getParameter("coc"),
						request.getParameter("doc"), getDataSource(request));
				if (del > 0) {
					displaymess = "Data deleted Succesfully";
				} else {
					displaymess = "Data cannot be deleted";
				}
				request.setAttribute("displaymess", displaymess);
			} catch (Exception e) {
				// System.out.println("the error in Division delete is "+e);
			}
		}
		return (mapping.findForward(mode));
	}

}
