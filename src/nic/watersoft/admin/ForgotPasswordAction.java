package nic.watersoft.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;

import org.apache.commons.lang.RandomStringUtils;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * 
 * @author 
 * 
 */
public class ForgotPasswordAction extends Action {

	public static final String FORGOT = "forgot";
	public static final String RESET = "reset";
	public static final String GET = "get";
	public static final String SUCESS = "pwdsent";
	public static final String FAILURE = "pwdfail";
	public static final String SU_SUCESS = "supwdsent";
	public static final String CAPTCHA_ERROR = "forgot";

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		ForgotPasswordFormBean forgotPasswordFormBean = (ForgotPasswordFormBean) form;

		RwsPasswordDAO rwsPasswordDAO = new RwsPasswordDAO();
		HttpSession session = request.getSession(true);

		String mode = request.getParameter("mode");

		if (mode != null && mode.equals(FORGOT)) {

		}
		if (mode != null && mode.equals(GET)) {
			
			if (forgotPasswordFormBean.getUserId() != null) {
				rwsPasswordDAO.getUserEmail(forgotPasswordFormBean);
			}
			if (forgotPasswordFormBean.getUserId() != null && forgotPasswordFormBean.getUserId().length() == 6) {
				/*
					&& !forgotPasswordFormBean.getUserId().equals(
							Constants.ADMIN)
					&& !forgotPasswordFormBean.getUserId().equals(
							Constants.EE_BUDGET)
					&& !forgotPasswordFormBean.getUserId()
							.equals(Constants.ENC)
					&& !forgotPasswordFormBean.getUserId().equals(
							Constants.HO_ADMN)
				 */
				rwsPasswordDAO.getUserInfo(forgotPasswordFormBean);
			} else {
				forgotPasswordFormBean.setCircleOfficeName("-");
				forgotPasswordFormBean.setDivOfficeName("-");
			}
		}

		if (mode != null && mode.equals(RESET)) {

			/*if (session.getAttribute("forgotkey") != null) {

				String key = (String) session.getAttribute("forgotkey");
				String enteredKey = request.getParameter("number");
				if (!key.equals(enteredKey)) {
					request.setAttribute("message",
							"You are Entered Wrong Security Code");
					return mapping.findForward(SUCESS);
				}

			}*/

			new RandomStringUtils();
			rwsPasswordDAO.resetPassword(forgotPasswordFormBean, request,RandomStringUtils.randomAlphanumeric(8));

			if (forgotPasswordFormBean.getUserId() != null) {
/*				if(flag==1)
				{*/
					return mapping.findForward(SUCESS);
/*				}
				else
				{
					return mapping.findForward(SUCESS);
				}*/
			} else {
				return mapping.findForward(FAILURE);
			}
		}

		return mapping.findForward(FORGOT);

	}
}
