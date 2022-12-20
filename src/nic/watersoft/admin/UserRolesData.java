package nic.watersoft.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class UserRolesData extends Action
{
	public ActionForward execute(ActionMapping mapping, ActionForm form, 
		HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String target = new String("data-success");
		AdminDAO adminDAO = new AdminDAO(getDataSource(request));
		int roleId = adminDAO.getNextRoleId();

		UserForm myForm = (UserForm)form;
		myForm.setRoleId(String.valueOf(roleId));
		return mapping.findForward(target);
	}
}
