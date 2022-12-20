
package nic.watersoft.masters;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsUser;

public class Rws_Imis_Programme_Entry_Act extends Action {
	
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		ArrayList imisPrograms = null;
		Rws_Imis_Programme_Entry_Form frm = (Rws_Imis_Programme_Entry_Form) form;
		String mode = frm.getMode();
		HttpSession session = request.getSession();
		String storedToken = (String) session.getAttribute("csrfToken");
		String token = request.getParameter("token");
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");
		if (!(user.getUserId() != null
				&& (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER)))) {
			return mapping.findForward("unAuthorise");
		}
		Rws_Imis_Programme_Entry_DAO dao = new Rws_Imis_Programme_Entry_DAO();
		if (mode != null && mode.equalsIgnoreCase("data")) {
			if (request.getParameter("special") != null && request.getParameter("special").equals("Y")) {
				reset(frm);
			}
		}
		if (mode != null && mode.equalsIgnoreCase("save")) {
			if (storedToken.equals(token)) {
				try {
					int res = dao.saveImisProgramme(frm.getImisProgrammeCode(), frm.getImisProgrammeName(),	frm.getFundSupport());
					reset(frm);
					if (res > 0) {
						request.setAttribute("message", "Added Successfully");
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		if (mode != null && mode.equalsIgnoreCase("View")) {
			imisPrograms = dao.getImisProgrammes();
			session.setAttribute("imisPrograms", imisPrograms);
		}
		if (mode != null && mode.equalsIgnoreCase("edit")) {
			if (storedToken.equals(token)) {
							int res = dao.editImisProgramme(frm.getImisProgrammeCode(), frm.getImisProgrammeName(),	frm.getFundSupport());
				if (res > 0) {
					session.setAttribute("message", "Edit Successfully");
				}
			}
		}
		return mapping.findForward(mode);
	}

	private void reset(Rws_Imis_Programme_Entry_Form frm) {
		frm.setImisProgrammeCode("");
		frm.setImisProgrammeName("");
		frm.setFundSupport("");
	}
}