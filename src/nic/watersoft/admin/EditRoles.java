
package nic.watersoft.admin;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;


public class EditRoles extends Action 
{
	public ActionForward execute(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String target = new String("success");
		UserForm myForm = (UserForm)form;
		String mode = myForm.getMode();
		String roleId = myForm.getRoleId();
		String roleName = myForm.getRoleName();
		String roleDesc = myForm.getRoleDesc();
		
		AdminDAO  adminDAO = new AdminDAO(getDataSource(request));
		AdminDTO adminDTO = null;
		String message = null;
		if(mode != null)
		{
			if(mode.equals("Edit"))
			{			
				adminDTO = adminDAO.getRoleDetails(roleId);
				myForm.setRoleId(adminDTO.getRoleId());
				myForm.setRoleName(adminDTO.getRoleName());
				myForm.setRoleDesc(adminDTO.getRoleDesc());
				target = new String("data-success");
			}
			else
			if(mode.equals("Delete"))
			{	int updateCount = adminDAO.removeRole(roleId);
				if(updateCount == 0)
					message = "Cannot delete the specified role.";
				else
					message = "Record deleted successfully.";
				ArrayList roles = adminDAO.getRoles();
				request.setAttribute("roles", roles);
				target = new String("success");
			}
			else
			if(mode.equals("Save"))
			{
				int updateCount = adminDAO.updateRole(roleId, roleName, roleDesc);
				ArrayList roles = adminDAO.getRoles();
				request.setAttribute("roles", roles);
				target = new String("success");
			}
			else
			if(mode.equals("Print"))
			{
				ArrayList roles = adminDAO.getRoles();
				request.setAttribute("roles", roles);
				target = new String("print-success");
			}
			else
			if(mode.equals("Excel"))
			{
				ArrayList roles = adminDAO.getRoles();
				request.setAttribute("roles", roles);
				target = new String("excel-success");
			}
		}
		else
			target = new String("unknown");
		
		HttpSession session = request.getSession();
		session.setAttribute("GlobalConstants.Message",message);
		return mapping.findForward(target);
	}
}
