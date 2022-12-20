package nic.watersoft.admin;

import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class RWSHOUserManagementData extends Action {
	
	
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws ServletException, Exception {
		saveToken(request);
		String target = new String("data-success");
		HttpSession session = request.getSession();
		RWSHOUserForm myForm = (RWSHOUserForm)form;
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		String userId = user.getUserId();
		if(userId.equals("admin")|| userId.equals("100000")){
			String mode = myForm.getMode();
			if(mode==null){
				target = new String("unAuthorise");
				return mapping.findForward("target");
			}
			if(mode != null)
			{
				if(mode.equals("rwshopage"))
				{
					target = new String("data-success");
					return mapping.findForward(target);
				}
				else if(!mode.equals("rwshopage"))
				{
					target = new String("unAuthorise");
					return mapping.findForward("target");
				}	
			}
			System.out.println("target"+target);
		}
		else
			target = new String("unauthorized-access");
			return mapping.findForward(target);
	
		
	}
}
