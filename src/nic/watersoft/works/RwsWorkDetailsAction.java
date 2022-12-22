package nic.watersoft.works;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * 
 * @author Sai Praasd N
 * 
 */
public class RwsWorkDetailsAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String VIEW = "view";

		HttpSession session = request.getSession();
		RwsWorkDetailsForm rwsWorkDetailsForm = (RwsWorkDetailsForm) form;

		String mode = request.getParameter("mode");

		RwsWorkDetailsDAO rwsWorkDetailsDAO = new RwsWorkDetailsDAO();
		if (mode != null && mode.equals("initReport")) {

			resetFormData(rwsWorkDetailsForm, session);

			session.setAttribute("circles", rwsWorkDetailsDAO.getCircles());
			session.setAttribute("programs", rwsWorkDetailsDAO.getPrograms());
			session.setAttribute("schemes", rwsWorkDetailsDAO.getSchemes());
			session.setAttribute("works", new ArrayList());

		}

		if (mode != null && mode.equals("getSchemeWorks")) {

			session.removeAttribute("works");

			session.setAttribute("works", rwsWorkDetailsDAO.getWorks(
					rwsWorkDetailsForm.getCircleOfficeCode(),
					rwsWorkDetailsForm.getSchemeCode(), rwsWorkDetailsForm
							.getProgramCode()));

		}
		if (mode != null && mode.equals("viewReport")) {

			return mapping.findForward("viewReport");
		}

		if (mode != null && mode.equals("quickSearch")) {

			session.removeAttribute("works");
			session.setAttribute("works", rwsWorkDetailsDAO
					.getWorksByName(rwsWorkDetailsForm.getSearchString()));
		}

		return mapping.findForward(VIEW);

	}

	private void resetFormData(RwsWorkDetailsForm rwsWorkDetailsForm,
			HttpSession session) {

		rwsWorkDetailsForm.setCircleOfficeCode("");
		rwsWorkDetailsForm.setSchemeCode("");
		rwsWorkDetailsForm.setSchemeCode("");
		rwsWorkDetailsForm.setSearchString("");

	}
}
