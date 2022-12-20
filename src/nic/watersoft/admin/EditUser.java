package nic.watersoft.admin;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsUser;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;


public class EditUser extends Action 
{
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String target = new String("success");
		HttpSession session = request.getSession();
		String storedToken = (String)session.getAttribute("csrfToken");
	    String token = request.getParameter("token");
	    RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}
		UserForm myForm = (UserForm)form;
		AdminDAO adminDAO = new AdminDAO(getDataSource(request));
		AdminDTO adminDTO = null;
		String mode = myForm.getMode();
		String userid = myForm.getUserId();
		String message = null;
		String t = (String)session.getAttribute("SessionToken");
		if(mode != null)
		{	
			if(mode.equals("Edit"))
			{
				session.removeAttribute("key");
				String capstr = adminDAO.getCaptchaCode();
				session.setAttribute("key",capstr);
				adminDTO = adminDAO.getUserDetails(userid);
				myForm.setHeadOfficeName(adminDTO.getHeadOfficeName());
				myForm.setCircleOfficeName(adminDTO.getCircleOfficeName());
				myForm.setDivisionOfficeName(adminDTO.getDivisionOfficeName());
				myForm.setSubdivisionOfficeName(adminDTO.getSubdivisionOfficeName());
				myForm.setUserId(adminDTO.getUserid());
				myForm.setDesignationCode(adminDTO.getDesignation());
				myForm.setHint(adminDTO.getHint());
				myForm.setProposals(adminDTO.getProposals());
				myForm.setEstimates(adminDTO.getEstimates());
				myForm.setWaterquality(adminDTO.getWaterquality());
				myForm.setContractor(adminDTO.getContractor());
				myForm.setWorks(adminDTO.getWorks());
				myForm.setAssets(adminDTO.getAssets());
				myForm.setFunds(adminDTO.getFunds());
				myForm.setMasters(adminDTO.getMasters());
				myForm.setWrite(adminDTO.getWrite());
				myForm.setRead(adminDTO.getRead());
				myForm.setDel(adminDTO.getDel());
				myForm.setMandal(adminDTO.getMandal());
				target = new String("data-success");
			}
			else
			if(mode.equals("Save")){
				 if (storedToken.equals(token)) {	
					String key=(String)session.getAttribute("key");
					String userr = request.getParameter("number");
					if(key.compareTo(userr)==0)	{
						adminDTO = new AdminDTO();
						BeanUtils.copyProperties(adminDTO, myForm);
						int updateCount = adminDAO.updateUser(adminDTO);
						if(updateCount == 0)
							message = "Cannot update user details.";
						ArrayList users = adminDAO.findAllUsers("");
						request.setAttribute("users", users);	
						message = "Updated Successfully";
						target = "view";
					}
					else{
						session.removeAttribute("key");
						message = "You have entered wrong verification code!! Please re-enter proper value.";
						target = "failure";
					}
					request.setAttribute("message",message);
					session.setAttribute("key",adminDAO.getCaptchaCode());
					return mapping.findForward(target);
				 }
			}
			else
			if(mode.equals("Del")){				
				String key=(String)session.getAttribute("key");
				String userr = request.getParameter("number");
				if(key.compareTo(userr)==0){
					int updateCount = adminDAO.removeUser(myForm.getUserid());
					if(updateCount == 0)
						message = "Cannot delete user.";
					else
						message = "User deleted successfully.";
					/*ArrayList users = adminDAO.findAllUsers("");
					request.setAttribute("users", users);*/
					target = "close";
					request.setAttribute("message",message);
				}
				else{
					session.removeAttribute("key");
					message = "You have entered wrong verification code!! Please re-enter proper value.";
					request.setAttribute("message",message);
					target = "close";
				}
				session.setAttribute("key",adminDAO.getCaptchaCode());
				return mapping.findForward(target);
			}
			else
			if(mode.equals("Print"))
			{
				ArrayList users = adminDAO.findAllUsers("");
				request.setAttribute("users", users);
				target = new String("print-success");
			}
			else
			if(mode.equals("Excel"))
			{
				ArrayList users = adminDAO.findAllUsers("");
				request.setAttribute("users", users);
				target = new String("excel-success");
			}
		}
		else
		{	target = new String("unknown");
		}
		session.setAttribute("GlobalConstants.Message", message);
		return mapping.findForward(target);
	}
}
