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

public class rws_MinorHeadAccEntryAct_frm extends Action {
	protected ActionForm buildMinorHeadForm(String majorHeadCode, String submajorHeadCode, String minorHeadCode,
			HttpServletRequest request) throws Exception {
		MinorHeadForm form = null;
		RwsMaster rwsMaster = RwsMasterData.getMinorHead(majorHeadCode, submajorHeadCode, minorHeadCode,
				getDataSource(request));
		if (rwsMaster != null) {
			form = new MinorHeadForm();
			form.setMajorHeadCode(rwsMaster.getMajorHeadCode() + " " + rwsMaster.getMajorHeadName());
			form.setSubmajorHeadCode(rwsMaster.getSubmajorHeadCode() + " " + rwsMaster.getSubmajorHeadName());
			form.setMinorHeadCode(rwsMaster.getMinorHeadCode());
			form.setMinorHeadName(rwsMaster.getMinorHeadName());
		}
		return form;
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		int ans = 0;
		String message = null;
		String displaymess = null;
		ArrayList minorheads = null;
		ArrayList submajorheads = new ArrayList();
		ArrayList majorHeads = null;
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");	
		MinorHeadForm frm = (MinorHeadForm) form;
		String mode = frm.getMode();

		if (mode.equalsIgnoreCase("data")) {
			try {
				majorHeads = RwsMasterData.getMajorHeads(getDataSource(request));
				session.setAttribute("majorHeads", majorHeads);
				if (request.getParameter("majorHeadCode") != null) {
					submajorheads = RwsMasterData.getSubMajorHeadCodes(request.getParameter("majorHeadCode"),
							getDataSource(request));
				}
				session.setAttribute("submajorHeads", submajorheads);
			} catch (Exception e) {
				// System.out.println(e);
			}

		}
		if (mode.equalsIgnoreCase("view")) {
			try {
				minorheads = RwsMasterData.getMinorHeads(getDataSource(request));
				session.setAttribute("minorHeads", minorheads);
			} catch (Exception e) {
				// System.out.println(e);
			}
		}

		if (mode.equalsIgnoreCase("save")) {
			String storedToken = (String)session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {
					RwsMaster rwsMaster = new RwsMaster();
					rwsMaster.setMajorHeadCode(frm.getMajorHeadCode());
					rwsMaster.setSubmajorHeadCode(frm.getSubmajorHeadCode());
					rwsMaster.setMinorHeadCode(frm.getMinorHeadCode());
					rwsMaster.setMinorHeadName(frm.getMinorHeadName());
					ans = RwsMasterData.insertMinorHead(rwsMaster, getDataSource(request));
					frm.reset(mapping, request);
				} catch (Exception e) {
					// System.out.println("the error is"+e);
				}
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
				form = buildMinorHeadForm(request.getParameter("majorHeadCode"),
						request.getParameter("submajorHeadCode"), request.getParameter("minorHeadCode"), request);
				if ("request".equalsIgnoreCase(mapping.getScope())) {
					request.setAttribute(mapping.getAttribute(), form);
				} else {
					session.setAttribute(mapping.getAttribute(), form);
				}
			} catch (Exception e) {
				// System.out.println("the error is"+e);
			}
		}
		if (mode.equalsIgnoreCase("edit")) {
			String storedToken = (String)session.getAttribute("csrfToken");
		    String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {
					RwsMaster rwsMaster = new RwsMaster();
					rwsMaster
							.setMajorHeadCode(frm.getMajorHeadCode().substring(0, frm.getMajorHeadCode().indexOf(" ")));
					rwsMaster.setSubmajorHeadCode(
							frm.getSubmajorHeadCode().substring(0, frm.getSubmajorHeadCode().indexOf(" ")));
					rwsMaster.setMinorHeadCode(frm.getMinorHeadCode());
					rwsMaster.setMinorHeadName(frm.getMinorHeadName());
					ans = RwsMasterData.updateMinorHead(rwsMaster, getDataSource(request));
				} catch (Exception e) {
					// System.out.println("the error is"+e);
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
				int del = RwsMasterData.removeMinorHead(request.getParameter("majorHeadCode"),
						request.getParameter("submajorHeadCode"), request.getParameter("minorHeadCode"),
						getDataSource(request));
				if (del > 0) {
					displaymess = "Data deleted Succesfully";
				} else {
					displaymess = "Data cannot be deleted";
				}
				request.setAttribute("displaymess", displaymess);
			} catch (Exception e) {
				// System.out.println("the error is"+e);
			}
		}
		return (mapping.findForward(mode));
	}
}
