package nic.watersoft.admin;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class UserRolesAction extends Action 
{
	private String target;
	private String mode;
	private int updateCount = 0;
	private String roleId ;
	private String roleName;
	private String roleDesc;
	
	public ActionForward execute(ActionMapping mapping, ActionForm form, 
		HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		UserForm myForm = (UserForm)form;
		AdminDAO adminDAO = new AdminDAO(getDataSource(request));

		mode = myForm.getMode();
		roleId = myForm.getRoleId();
		roleName = myForm.getRoleName();
		roleDesc = myForm.getRoleDesc();
		
		if(mode!= null)
		{
			if(mode.equals("Save"))
			{
				updateCount = adminDAO.insertRole(roleId, roleName, roleDesc);
				if(updateCount == 0)
					target = new String("failure");
				else
					target = new String("success");
			}
			else
			if(mode.equals("View"))
			{
				ArrayList roles = adminDAO.getRoles();
				request.setAttribute("roles", roles);
				target = new String("view-success");
			}
			else
			if(mode.equals("Update"))
				updateCount = adminDAO.updateRole(roleId, roleName, roleDesc);

		}
		else
			target = new String("unknown");

		return (mapping.findForward(target));
	}
	
}
