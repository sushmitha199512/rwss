package nic.watersoft.reports;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.Globals;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsHabScoreCardAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		HttpSession session = request.getSession();

		/**
		 * RwsUser user = (RwsUser) session.getAttribute("RWS_USER"); RwsOffices
		 * offices = null; if (user == null) { return
		 * mapping.findForward("expire"); }
		 */
		RwsHabScoreCardActionForm rhsfrm = (RwsHabScoreCardActionForm) form;
		String mode = request.getParameter("mode");
		System.out.println("mode is " + mode);
		String langMode = rhsfrm.getLanguage();

		// System.out.println("language is " + langMode);

		if (langMode == null || langMode.equals("English")) {
			rhsfrm.setLanguage("English");
			request.getSession().setAttribute(Globals.LOCALE_KEY,
					new Locale("en", "IN"));

		} else {
			rhsfrm.setLanguage("Telugu");
			request.getSession().setAttribute(Globals.LOCALE_KEY,
					new Locale("te", "IN"));

		}

		if (mode != null && mode.equals("home")) {
			return mapping.findForward("home");
		}
		if (mode != null && mode.equals("SVS")) {
			return mapping.findForward("SVS");
		}
		if (mode != null && mode.equals("MVS")) {
			return mapping.findForward("MVS");
		}
		if (mode != null && mode.equals("SCH")) {

			return mapping.findForward("SCH");
		}
		if (mode != null && mode.equals("ANG")) {
			return mapping.findForward("ANG");
		}
		return null;
	}
}
