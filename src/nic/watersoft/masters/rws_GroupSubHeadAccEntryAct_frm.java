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

public class rws_GroupSubHeadAccEntryAct_frm extends Action {
	protected ActionForm buildGroupSubHeadForm(String majorHeadCode, String submajorHeadCode, String minorHeadCode,
			String grpSubHeadCode, HttpServletRequest request) throws Exception {
		GroupSubHeadForm form = null;
		RwsMaster rwsMaster = RwsMasterData.getGrpSubHead(majorHeadCode, submajorHeadCode, minorHeadCode,
				grpSubHeadCode, getDataSource(request));
		if (rwsMaster != null) {
			form = new GroupSubHeadForm();
			form.setMajorHeadCode(rwsMaster.getMajorHeadCode() + " " + rwsMaster.getMajorHeadName());
			form.setSubmajorHeadCode(rwsMaster.getSubmajorHeadCode() + " " + rwsMaster.getSubmajorHeadName());
			form.setMinorHeadCode(rwsMaster.getMinorHeadCode() + " " + rwsMaster.getMinorHeadName());
			form.setGrpSubHeadCode(rwsMaster.getGrpSubHeadCode());
			form.setGrpSubHeadName(rwsMaster.getGrpSubHeadName());
		}
		return form;
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		int ans = 0;
		String message = null;
		ArrayList grpsubheads = null;
		ArrayList minorheads = new ArrayList();
		ArrayList submajorheads = new ArrayList();
		ArrayList majorHeads = null;
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");
		GroupSubHeadForm frm = (GroupSubHeadForm) form;
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
			} catch (Exception e) {
				// System.out.println(e);
			}

		}
		if (mode.equalsIgnoreCase("view")) {
			String plannonplan = request.getParameter("plannonplan");
			try {
				grpsubheads = RwsMasterData.getGrpSubHeads(getDataSource(request), plannonplan);
				session.setAttribute("grpSubHeads", grpsubheads);
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
					rwsMaster.setGrpSubHeadName(frm.getGrpSubHeadName());
					ans = RwsMasterData.insertGrpSubHead(rwsMaster, getDataSource(request));
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
				form = buildGroupSubHeadForm(request.getParameter("majorHeadCode"),
						request.getParameter("submajorHeadCode"), request.getParameter("minorHeadCode"),
						request.getParameter("grpSubHeadCode"), request);
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
			session = request.getSession();
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
					rwsMaster.setGrpSubHeadCode(frm.getGrpSubHeadCode());
					rwsMaster.setGrpSubHeadName(frm.getGrpSubHeadName());
					ans = RwsMasterData.updateGrpSubHead(rwsMaster, getDataSource(request));
				} catch (SQLException sqle) {
					if (sqle.getErrorCode() == 1)
						message = "Record with this name exists.";
				} catch (Exception e) {
					// System.out.println("the error is"+e);
				}
			}
		}
		if (mode.equalsIgnoreCase("delete")) {
			try {
				RwsMasterData.removeGrpSubHead(request.getParameter("majorHeadCode"),
						request.getParameter("submajorHeadCode"), request.getParameter("minorHeadCode"),
						request.getParameter("grpSubHeadCode"), getDataSource(request));
			} catch (Exception e) {
				// System.out.println("the error is"+e);
			}

		}
		return (mapping.findForward(mode));
	}
}
