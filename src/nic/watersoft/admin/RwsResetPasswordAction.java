package nic.watersoft.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class RwsResetPasswordAction extends Action {	
	public static final String VIEW = "view";
	public static final String DATA = "data";
	public static final String RESET = "reset";
	public static final String DEFAULT_PASSWORD = "watersoft";

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)	throws Exception {

		RwsResetPaswordFrm resetPaswordFrm = (RwsResetPaswordFrm) form;
		HttpSession session = request.getSession(true);
		String storedToken = (String)session.getAttribute("csrfToken");
	    String token = request.getParameter("token");
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}
		String mode = request.getParameter("mode");
		RwsPasswordDAO rwsPasswordDAO = new RwsPasswordDAO();
		if (mode != null && mode.equals(VIEW)) {
			session.setAttribute("users", rwsPasswordDAO.getUSers());
			return mapping.findForward(VIEW);
		}
		if (mode != null && mode.equals(DATA)) {
			if (resetPaswordFrm.getUserId() != null && !resetPaswordFrm.equals(Constants.ADMIN)	&& resetPaswordFrm.getUserId().length() == 6) {
				rwsPasswordDAO.getUserInfo(resetPaswordFrm);
			} else {
				resetPaswordFrm.setCircleOfficeName("-");
				resetPaswordFrm.setDivOfficeName("-");
			}
			return mapping.findForward(VIEW);
		}
		if (mode != null && mode.equals(RESET)) {
			return mapping.findForward(VIEW);
		}
		return mapping.findForward(VIEW);
	}
}
