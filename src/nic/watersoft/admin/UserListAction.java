package nic.watersoft.admin;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class UserListAction extends Action {
	@SuppressWarnings("unchecked")
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		UserListForm bean = (UserListForm) form;
		ArrayList users = new ArrayList();
		ArrayList usersList = new ArrayList();
		UserListDAO dao = null;
		String mode = request.getParameter("mode");
		HttpSession session = request.getSession();
		String storedToken = (String)session.getAttribute("csrfToken");
	    String token = request.getParameter("token");
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if( !(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || user.getUserId().equals(Constants.MINISTER) || user.getUserId().equals(Constants.EE_BUDGET) || user.getUserId().equals(Constants.RWS_USER) || user.getUserId().equals(Constants.SEC_USER) || user.getUserId().equals(Constants.GUEST) || user.getUserId().equals(Constants.ENC) || user.getUserId().equals(Constants.HO_ADMN) || Constants.IsWaterQualityUser(user.getUserId()) == false  || Constants.IsUser(user.getUserId()) == false))) {
			return mapping.findForward("unAuthorise");	
		}
		RwsUser userObj = (RwsUser) session.getAttribute("RWS_USER");
		if (userObj.getUserId() != null	&& (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER))) {
			bean.setSuperUser("yes");
		} else {
			bean.setSuperUser("no");
		}		
		if (mode != null && mode.equalsIgnoreCase("data")) {
			bean.setUserId(userObj.getUserId());
			dao = new UserListDAO();
			dao.getUserDetails(userObj.getUserId(), bean);
			try {
				users = dao.getUsers();
				session.setAttribute("users", users);
			} catch (Exception e) {
				System.out.println("The Exception in UserListAction in data is  = "+e.getMessage());
			}
		}
		
		if (mode != null && mode.equalsIgnoreCase("get")) {
			dao = new UserListDAO();
			try {
				reset(bean);
				String userId = request.getParameter("userId");				
				usersList = dao.getUsersList(userId, bean);
				bean.setUsersList(usersList);
			} catch (Exception e) {
				System.out.println("The Exception in UserListAction in get is  = "+e.getMessage());
			}
		}
		
		if (mode != null && mode.equalsIgnoreCase("view")) {
			dao = new UserListDAO();
			try {
				usersList = dao.viewUsersList();
				bean.setUsersList(usersList);
			} catch (Exception e) {
				System.out.println("The Exception in UserListAction in view is  = "+e.getMessage());
			}
		}
		if (mode != null && mode.equalsIgnoreCase("save")) {
			if(storedToken.equals(token)){				
				dao = new UserListDAO();
				try {
					int count = dao.updateUsersDetails(request, bean);
					if (count == 1) {
						request.setAttribute("message", "Updated successfully ");
					} else {
						session.setAttribute("message", "Not Updated.");
					}
				} catch (Exception e) {
					System.out.println("The Exception in UserListAction in Save is  = "+e.getMessage());
				}
			}
		}
		return mapping.findForward(mode);
	}
	
	private void reset(UserListForm bean) {
		bean.setCircle("");
		bean.setDivision("");
		bean.setMobileNo("");
		bean.setMailId("");		
	}
}
