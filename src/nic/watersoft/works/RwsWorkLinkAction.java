/*
 * Created on 20-03-2013
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * @author RWSS_DPT1(Sai Prasad N)
 * 
 * TODO To change the template for this generated type comment go to Window -
 * Preferences - Java - Code Style - Code Templates
 */
public class RwsWorkLinkAction extends Action {

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.apache.struts.action.Action#execute(org.apache.struts.action.ActionMapping,
	 *      org.apache.struts.action.ActionForm,
	 *      javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse)
	 */
	public ActionForward execute(ActionMapping mapping, ActionForm frm,
			HttpServletRequest request, HttpServletResponse res)
			throws Exception {
		RwsWorkLinkActionForm bean = (RwsWorkLinkActionForm) frm;
		HttpSession session = request.getSession(true);
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		String userId = user.getUserId();
		RwsWorkLinkDAO rwsWorkLinkDAO = new RwsWorkLinkDAO();
		String message = "";
		String mode = request.getParameter("mode");
		if (mode != null && mode.equals("data")) {
			reset(bean);
		}
		if (mode != null && mode.equals("oldwork")) {
			//reset(bean);
			message = rwsWorkLinkDAO.getWorkDetails(bean, "oldwork", request);
			if (!message.equals("")) {
				request.setAttribute("message", message);
			}

		} else if (mode != null && mode.equals("newwork")) {
			message = rwsWorkLinkDAO.getWorkDetails(bean, "newwork", request);
			if (!message.equals("")) {
				request.setAttribute("message", message);
			}
		} else if (mode != null && mode.equals("save")) {
			message = rwsWorkLinkDAO.saveWork(bean, userId);
			if (!message.equals("")) {
				request.setAttribute("message", message);
				reset(bean);
			}

		} else if (mode != null && mode.equals("update")) {
			message = rwsWorkLinkDAO.updateWork(bean, userId);
			if (!message.equals("")) {
				request.setAttribute("message", message);
				reset(bean);
			}
		}
		return mapping.findForward("data");
	}

	/**
	 * @param bean
	 */
	private void reset(RwsWorkLinkActionForm bean) {

		bean.setOldWorkName("");
		bean.setOldSanctionedAmount("");
		bean.setOldSanctionedDate("");
		bean.setOldProgram("");
		bean.setOldSubProgName("");

		bean.setNewWorkName("");
		bean.setNewSanctionedAmount("");
		bean.setNewSanctionedDate("");
		bean.setNewProgram("");
		bean.setNewSubProgName("");
		bean.setOldWorkId("");
		bean.setOldReleasesSoFar("");
		bean.setNewWorkId("");

	}

}