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

public class UserManagementData extends Action {
	ArrayList headOffices =  new ArrayList();
	ArrayList circles  =  new ArrayList();
	ArrayList divisions =  new ArrayList();
	ArrayList subdivisions =  new ArrayList();
	ArrayList designations =  new ArrayList();
	ArrayList mandals =  new ArrayList();
	
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws ServletException, Exception {
		saveToken(request);
		
		String target = new String("data-success");
		HttpSession session = request.getSession();
		UserForm myForm = (UserForm)form;
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		String userId = user.getUserId();
		
		System.out.println("UserManagementData userId :"+userId);
		String mode = myForm.getMode();System.out.println("mode :"+mode);
		
		if(userId.equals("admin")|| userId.equals("100000")){
			RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
			AdminDAO adminDAO = new AdminDAO(getDataSource(request));
			CommonLists commonLists = new CommonLists(getDataSource(request));
			headOffices = rwsOffices.getHeads();			
			String headOfficeCode = myForm.getHeadOfficeCode();
			String circleOfficeCode = myForm.getCircleOfficeCode();
			String divisionOfficeCode = myForm.getDivisionOfficeCode();
			String subdivisionOfficeCode = myForm.getSubdivisionOfficeCode();
			//String mode = myForm.getMode();System.out.println("mode :"+mode);
			String mandal=myForm.getMandal();			
			int heirarchyCode = 0;
			System.out.println("mode :"+mode);
			if(mode==null){
				session.removeAttribute("key");
				request.removeAttribute("circles");
				session.removeAttribute("circles");
				request.removeAttribute("divisions");
				request.removeAttribute("subdivisions");
				request.removeAttribute("mandals");
				String capstr = adminDAO.getCaptchaCode();				
				session.setAttribute("key",capstr);
				myForm.setHeadOfficeCode("");
				myForm.setCircleOfficeCode("00");
				myForm.setDivisionOfficeCode("0");
				myForm.setSubdivisionOfficeCode("00");
				myForm.setMandal("00");
				myForm.setDesignationCode("");
				myForm.setUserId("");
			}
			if(mode != null)
			{
				myForm.setUserId(adminDAO.getNewUserId(headOfficeCode,circleOfficeCode,divisionOfficeCode,subdivisionOfficeCode,mandal));
				if(mode.equals("headOffice"))
				{
					circles = rwsOffices.getCircles(headOfficeCode);System.out.println("circles :"+circles);
					heirarchyCode = 5;
					designations = adminDAO.getDesignations(heirarchyCode);	
					myForm.setCircleOfficeCode("00");
					myForm.setDivisionOfficeCode("0");
					myForm.setSubdivisionOfficeCode("00");
					myForm.setMandal("00");
					myForm.setDesignationCode("");
					myForm.setUserId("");
				}
				else if(mode.equals("circle"))
				{
					divisions = rwsOffices.getDivisions(headOfficeCode, circleOfficeCode);
					heirarchyCode = 7;
					designations = adminDAO.getDesignations(heirarchyCode);	
					myForm.setDivisionOfficeCode("0");
					myForm.setSubdivisionOfficeCode("00");
					myForm.setMandal("00");
					myForm.setDesignationCode("");
				}
				else if(mode.equals("division"))	{
					subdivisions = rwsOffices.getSubdivisions(headOfficeCode, circleOfficeCode, divisionOfficeCode);					
					heirarchyCode = 8;
					designations = adminDAO.getDesignations(heirarchyCode);	
					myForm.setSubdivisionOfficeCode("00");
					myForm.setMandal("00");
					myForm.setDesignationCode("");
				}
				else if(mode.equals("subdivision"))
				{
					mandals=rwsOffices.getDivmandals(circleOfficeCode, divisionOfficeCode, subdivisionOfficeCode);					
					heirarchyCode = 9;
					designations = adminDAO.getDesignations(heirarchyCode);
					myForm.setMandal("00");
					myForm.setDesignationCode("");
				}
				else if(mode.equals("rwshopage"))
				{
					return mapping.findForward("data-success");
				}
				/*else if(!mode.equals("rwshopage"))
				{
					return mapping.findForward("unAuthorise");
				}	*/
			}
			ArrayList roles = adminDAO.getRoles();
			request.setAttribute("designations", designations);
			request.setAttribute("headOffices", headOffices);
			request.setAttribute("circles", circles);
			request.setAttribute("divisions", divisions);
			request.setAttribute("subdivisions", subdivisions);
			request.setAttribute("mandals", mandals);
			request.setAttribute("roles", roles);
		}
		else
		{
			System.out.println("User management else");
			target = new String("unauthorized-access");
		}
		//System.out.println("target :"+target);
		return mapping.findForward(target);
	}
}
