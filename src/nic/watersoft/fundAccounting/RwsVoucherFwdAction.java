package nic.watersoft.fundAccounting;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsVoucherFwdAction extends Action {

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		DataSource dataSource = null;
		DataSource ds = null;
		String SUCCESS = "success";
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null) {
			return mapping.findForward("expire");
		}
		
		if (!(user.getUserId() != null
				&& ( Constants.IsEEUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");
		}
		
		String userId = user.getUserId();
		RwsVoucherFwdActionForm rwsVoucherFwdActionForm = (RwsVoucherFwdActionForm) form;
		RwsVoucherFwdDAO rwsVoucherFwdDAO = new RwsVoucherFwdDAO();
		String mode = request.getParameter("mode");
		RwsOffices offices = new RwsOffices(dataSource);
		try {

			if (mode != null && mode.equals("data")) {

				if (userId != null && userId.contains("EE")) {
					rwsVoucherFwdActionForm.setVouchersList(rwsVoucherFwdDAO
							.getVouchersList(userId.substring(1, 3),
									userId.substring(3, 4)));
				}
			}

			if (mode != null && mode.equals("save")) {
				session = request.getSession();
				String storedToken = (String) session.getAttribute("csrfToken");
				String token = request.getParameter("token");
				if (storedToken.equals(token)) {
				rwsVoucherFwdDAO.updateVouchers(rwsVoucherFwdActionForm,
						request);
				rwsVoucherFwdActionForm.setVouchersList(rwsVoucherFwdDAO
						.getVouchersList(userId.substring(1, 3),
								userId.substring(3, 4)));
				mode = "data";

			}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return mapping.findForward(mode);
	}
}