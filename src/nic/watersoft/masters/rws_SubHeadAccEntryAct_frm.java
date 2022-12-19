package nic.watersoft.masters;

import java.io.IOException;
import java.sql.SQLException;
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

public class rws_SubHeadAccEntryAct_frm extends Action {
	protected ActionForm buildSubHeadForm(String majorHeadCode, String submajorHeadCode, String minorHeadCode,
			String grpSubHeadCode, String subHeadCode, HttpServletRequest request) throws Exception {
		SubHeadForm form = null;
		RwsMaster rwsMaster = RwsMasterData.getSubHead(majorHeadCode, submajorHeadCode, minorHeadCode, grpSubHeadCode,
				subHeadCode, getDataSource(request));
		if (rwsMaster != null) {
			form = new SubHeadForm();
			form.setMajorHeadCode(rwsMaster.getMajorHeadCode() + " " + rwsMaster.getMajorHeadName());
			form.setSubmajorHeadCode(rwsMaster.getSubmajorHeadCode() + " " + rwsMaster.getSubmajorHeadName());
			form.setMinorHeadCode(rwsMaster.getMinorHeadCode() + " " + rwsMaster.getMinorHeadName());
			form.setGrpSubHeadCode(rwsMaster.getGrpSubHeadCode() + " " + rwsMaster.getGrpSubHeadName());
			form.setSubHeadCode(rwsMaster.getSubHeadCode());
			form.setSubHeadName(rwsMaster.getSubHeadName());
		}
		return form;
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");
		int ans = 0;
		String message = null;
		ArrayList subheads = null;
		ArrayList grpsubheads = new ArrayList();
		ArrayList minorheads = new ArrayList();
		ArrayList submajorheads = new ArrayList();
		ArrayList majorHeads = null;
		SubHeadForm frm = (SubHeadForm) form;
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
				if (request.getParameter("majorHeadCode") != null && request.getParameter("submajorHeadCode") != null) {
					minorheads = RwsMasterData.getMinorHeadCodes(request.getParameter("majorHeadCode"),
							request.getParameter("submajorHeadCode"), getDataSource(request));
				}
				session.setAttribute("minorheads", minorheads);
				if (request.getParameter("majorHeadCode") != null && request.getParameter("submajorHeadCode") != null
						&& request.getParameter("minorHeadCode") != null) {
					grpsubheads = RwsMasterData.getGrpSubHeadCodes(request.getParameter("majorHeadCode"),
							request.getParameter("submajorHeadCode"), request.getParameter("minorHeadCode"),
							getDataSource(request));
				}
				session.setAttribute("grpsubheads", grpsubheads);
			} catch (Exception e) {
				// System.out.println(e);
			}
		}
		if (mode.equalsIgnoreCase("view")) {
			try {
				subheads = RwsMasterData.getSubHeads(getDataSource(request));
				session.setAttribute("subheads", subheads);
			} catch (Exception e) {
				System.err.println(e);
			}
		}

		if (mode.equalsIgnoreCase("save")) {
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {
					RwsMaster rwsMaster = new RwsMaster();
					rwsMaster.setMajorHeadCode(frm.getMajorHeadCode());
					rwsMaster.setSubmajorHeadCode(frm.getSubmajorHeadCode());
					rwsMaster.setMinorHeadCode(frm.getMinorHeadCode());
					rwsMaster.setGrpSubHeadCode(frm.getGrpSubHeadCode());
					rwsMaster.setSubHeadCode(frm.getSubHeadCode());
					rwsMaster.setSubHeadName(frm.getSubHeadName());
					ans = RwsMasterData.insertSubHead(rwsMaster, getDataSource(request));
					frm.reset(mapping, request);
				} catch (SQLException e) {
					// System.out.println("the error is"+e);
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
				form = buildSubHeadForm(request.getParameter("majorHeadCode"), request.getParameter("submajorHeadCode"),
						request.getParameter("minorHeadCode"), request.getParameter("grpSubHeadCode"),
						request.getParameter("subHeadCode"), request);
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
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {
					RwsMaster rwsMaster = new RwsMaster();
					rwsMaster
							.setMajorHeadCode(frm.getMajorHeadCode().substring(0, frm.getMajorHeadCode().indexOf(" ")));
					rwsMaster.setSubmajorHeadCode(
							frm.getSubmajorHeadCode().substring(0, frm.getSubmajorHeadCode().indexOf(" ")));
					rwsMaster
							.setMinorHeadCode(frm.getMinorHeadCode().substring(0, frm.getMinorHeadCode().indexOf(" ")));
					rwsMaster.setGrpSubHeadCode(
							frm.getGrpSubHeadCode().substring(0, frm.getGrpSubHeadCode().indexOf(" ")));
					rwsMaster.setSubHeadCode(frm.getSubHeadCode());
					rwsMaster.setSubHeadName(frm.getSubHeadName());
					ans = RwsMasterData.updateSubHead(rwsMaster, getDataSource(request));
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
				RwsMasterData.removeSubHead(request.getParameter("majorHeadCode"),
						request.getParameter("submajorHeadCode"), request.getParameter("minorHeadCode"),
						request.getParameter("grpSubHeadCode"), request.getParameter("subHeadCode"),
						getDataSource(request));
			} catch (Exception e) {
			}
		}
		return (mapping.findForward(mode));
	}
}
