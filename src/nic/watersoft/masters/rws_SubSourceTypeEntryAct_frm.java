package nic.watersoft.masters;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_SubSourceTypeEntryAct_frm extends Action {
	protected ActionForm buildSubSourceTypeForm(String sourceTypeCode, String subSourceTypeCode,
			HttpServletRequest request) throws Exception {
		SubSourceTypeForm form = null;
		RwsMaster rwsMaster = RwsMasterData.getSubSourceType(sourceTypeCode, subSourceTypeCode, getDataSource(request));
		if (rwsMaster != null) {
			form = new SubSourceTypeForm();
			form.setSourceTypeCode(rwsMaster.getSourceTypeCode() + " " + rwsMaster.getSourceTypeName());
			form.setSubSourceTypeCode(rwsMaster.getSubSourceTypeCode());
			form.setSubSourceTypeName(rwsMaster.getSubSourceTypeName());
		}
		return form;
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		int ans = 0;
		String message = null;
		String displaymess = null;
		ArrayList subSourceTypes = null;
		ArrayList sourceTypeCodes = null;
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");
		SubSourceTypeForm frm = (SubSourceTypeForm) form;
		String mode = frm.getMode();

		if (mode.equalsIgnoreCase("data")) {
			try {
				CommonLists commonLists = new CommonLists(getDataSource(request));
				sourceTypeCodes = commonLists.getSourceTypes();
				session.setAttribute("sourceTypeCodes", sourceTypeCodes);

				request.setAttribute("scode", RwsMasterData.getSubSourceTypeCode(request.getParameter("sourceTypeCode"),
						getDataSource(request)));
			} catch (Exception e) {
				System.err.println("The error in rws_SubSourceTypeEntryAct_frm in inc is " + e);
			}
		}
		if (mode.equalsIgnoreCase("view")) {
			try {
				subSourceTypes = RwsMasterData.getSubSourceTypes(getDataSource(request));
				session.setAttribute("subSourceTypes", subSourceTypes);
			} catch (Exception e) {
				System.err.println("The error in rws_SubSourceTypeEntryAct_frm in view is " + e);
			}
		}
		if (mode.equalsIgnoreCase("save")) {
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {
					RwsMaster rwsMaster = new RwsMaster();
					rwsMaster.setSourceTypeCode(frm.getSourceTypeCode());
					rwsMaster.setSubSourceTypeCode(frm.getSubSourceTypeCode());
					rwsMaster.setSubSourceTypeName(frm.getSubSourceTypeName());
					ans = RwsMasterData.insertSubSourceType(rwsMaster, getDataSource(request));
					frm.reset(mapping, request);

				} catch (Exception e) {
					System.err.println("The error in rws_SubSourceTypeEntryAct_frm in insert is " + e);
				}
			}
			if (ans < 1) {
				if (RwsMasterData.errorMessage != null && RwsMasterData.errorMessage.length() > 0)
					message = RwsMasterData.errorMessage;
				else
					message = "The Record cannot be inserted.";
			} else {
				message = "Record inserted successfully";
			}
			request.setAttribute("message", message);
		}
		if (mode.equalsIgnoreCase("get")) {
			try {
				form = buildSubSourceTypeForm(request.getParameter("sourceTypeCode"),
						request.getParameter("subSourceTypeCode"), request);
				if ("request".equalsIgnoreCase(mapping.getScope())) {
					request.setAttribute(mapping.getAttribute(), form);
				} else {
					session.setAttribute(mapping.getAttribute(), form);
				}
			} catch (Exception e) {
				System.err.println("The error in rws_SubSourceTypeEntryAct_frm in get is " + e);
			}
		}
		if (mode.equalsIgnoreCase("edit")) {
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {
					RwsMaster rwsMaster = new RwsMaster();
					rwsMaster.setSourceTypeCode(	frm.getSourceTypeCode().substring(0, frm.getSourceTypeCode().indexOf(" ")));
					rwsMaster.setSubSourceTypeCode(frm.getSubSourceTypeCode());
					rwsMaster.setSubSourceTypeName(frm.getSubSourceTypeName());
					ans = RwsMasterData.updateSubSourceType(rwsMaster, getDataSource(request));
				} catch (Exception e) {
					System.err.println("The error in rws_SubSourceTypeEntryAct_frm in edit is " + e);
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
				ans = RwsMasterData.removeSubSourceType(request.getParameter("sourceTypeCode"),
						request.getParameter("subSourceTypeCode"), getDataSource(request));
				if (ans > 0) {
					displaymess = "Data deleted Succesfully";
				} else {
					displaymess = "Data cannot be deleted";
				}
				request.setAttribute("displaymess", displaymess);
			} catch (Exception e) {
				System.err.println("The error in rws_SubSourceTypeEntryAct_frm in delete is " + e);
			}
		}
		return (mapping.findForward(mode));
	}
}