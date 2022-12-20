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

public class rws_DetailHeadAccEntryAct_frm extends Action {
	protected ActionForm buildDetailHeadForm(String majorHeadCode, String submajorHeadCode, String minorHeadCode,
			String grpSubHeadCode, String subHeadCode, String detailHeadCode, HttpServletRequest request)
			throws Exception {
		DetailHeadForm form = null;
		RwsMaster rwsMaster = RwsMasterData.getDetailHead(majorHeadCode, submajorHeadCode, minorHeadCode,
				grpSubHeadCode, subHeadCode, detailHeadCode, getDataSource(request));

		if (rwsMaster != null) {
			form = new DetailHeadForm();

			form.setMajorHeadCode(rwsMaster.getMajorHeadCode() + " " + rwsMaster.getMajorHeadName());
			form.setSubmajorHeadCode(rwsMaster.getSubmajorHeadCode() + " " + rwsMaster.getSubmajorHeadName());
			form.setMinorHeadCode(rwsMaster.getMinorHeadCode() + " " + rwsMaster.getMinorHeadName());
			form.setGrpSubHeadCode(rwsMaster.getGrpSubHeadCode() + " " + rwsMaster.getGrpSubHeadName());
			form.setSubHeadCode(rwsMaster.getSubHeadCode() + " " + rwsMaster.getSubHeadName());
			form.setDetailHeadCode(rwsMaster.getDetailHeadCode());
			form.setDetailHeadName(rwsMaster.getDetailHeadName());

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
		String displaymess = null;
		ArrayList detailheads = null;
		ArrayList subheads = new ArrayList();
		ArrayList grpsubheads = new ArrayList();
		ArrayList minorheads = new ArrayList();
		ArrayList submajorheads = new ArrayList();
		ArrayList majorHeads = null;
		DetailHeadForm frm = (DetailHeadForm) form;
		String mode = frm.getMode();
		if (mode.equalsIgnoreCase("data")) {
			try {
				majorHeads = RwsMasterData.getMajorHeads(getDataSource(request));
				session.setAttribute("majorHeads", majorHeads);
				if (request.getParameter("majorHeadCode") != null) {
					submajorheads = RwsMasterData.getSubMajorHeadCodes(request.getParameter("majorHeadCode"),
							getDataSource(request));
					// System.out.println("submajorheads="+submajorheads.size());
				}
				session.setAttribute("submajorHeads", submajorheads);
				if (request.getParameter("majorHeadCode") != null && request.getParameter("submajorHeadCode") != null) {
					minorheads = RwsMasterData.getMinorHeadCodes(request.getParameter("majorHeadCode"),
							request.getParameter("submajorHeadCode"), getDataSource(request));
					// System.out.println("minorheads="+minorheads.size());
				}
				session.setAttribute("minorheads", minorheads);
				if (request.getParameter("majorHeadCode") != null && request.getParameter("submajorHeadCode") != null
						&& request.getParameter("minorHeadCode") != null) {
					grpsubheads = RwsMasterData.getGrpSubHeadCodes(request.getParameter("majorHeadCode"),
							request.getParameter("submajorHeadCode"), request.getParameter("minorHeadCode"),
							getDataSource(request));
					// System.out.println("grpsubheads="+grpsubheads.size());
				}
				session.setAttribute("grpsubheads", grpsubheads);
				if (request.getParameter("grpSubHeadCode") != null) {
					subheads = RwsMasterData.getSubHeadCodes(request.getParameter("majorHeadCode"),
							request.getParameter("submajorHeadCode"), request.getParameter("minorHeadCode"),
							request.getParameter("grpSubHeadCode"), getDataSource(request));
					// System.out.println("subheads="+subheads.size());
				}
				session.setAttribute("subheads", subheads);

			} catch (Exception e) {
				// System.out.println(e);
			}
		}
		if (mode.equalsIgnoreCase("view")) {
			try {
				detailheads = RwsMasterData.getDetailHeads(getDataSource(request));
				session.setAttribute("detailheads", detailheads);
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
					rwsMaster.setDetailHeadCode(frm.getDetailHeadCode());
					rwsMaster.setDetailHeadName(frm.getDetailHeadName());
					ans = RwsMasterData.insertDetailHead(rwsMaster, getDataSource(request));
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
				form = buildDetailHeadForm(request.getParameter("majorHeadCode"),
						request.getParameter("submajorHeadCode"), request.getParameter("minorHeadCode"),
						request.getParameter("grpSubHeadCode"), request.getParameter("subHeadCode"),
						request.getParameter("detailHeadCode"), request);
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
					rwsMaster.setSubHeadCode(frm.getSubHeadCode().substring(0, frm.getSubHeadCode().indexOf(" ")));
					rwsMaster.setDetailHeadCode(frm.getDetailHeadCode());
					rwsMaster.setDetailHeadName(frm.getDetailHeadName());
					ans = RwsMasterData.updateDetailHead(rwsMaster, getDataSource(request));
				} catch (Exception e) {
					System.out.println("the error in edit is" + e);
				}
			}
			if (ans < 1) {
				if (RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() > 0)
					message = RwsMasterData.errorMessage;
				else
					message = "The record cannot be updated.";
				mode = "get";
				request.setAttribute("message", message);
			} else {
				message = "Record Updated Successfully";
				mode = "edit";
				request.setAttribute("message", message);
			}
		}
		if (mode.equalsIgnoreCase("delete")) {
			try {
				int del = RwsMasterData.removeDetailHead(request.getParameter("majorHeadCode"),
						request.getParameter("submajorHeadCode"), request.getParameter("minorHeadCode"),
						request.getParameter("grpSubHeadCode"), request.getParameter("subHeadCode"),
						request.getParameter("detailHeadCode"), getDataSource(request));
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
