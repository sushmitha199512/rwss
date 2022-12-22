package nic.watersoft.smsmobile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.drought.DroughtForm;
import nic.watersoft.drought.DroughtMasterData;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class AuthorisedMobileUserDetailsAction extends Action {

	public AuthorisedMobileUserDetailsAction() {

	}

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HttpSession session = request.getSession();
		
		String page_to_be_displayed="get2";	
		RwsUser rwsUser = (RwsUser)session.getAttribute("RWS_USER");
		
		if (rwsUser == null) {

			return mapping.findForward("expire");
		}

		if (!(rwsUser.getUserId() != null && (rwsUser.getUserId().equals(Constants.ADMIN) 	|| rwsUser.getUserId().equals(Constants.DROUGHT_USER)
				|| rwsUser.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(rwsUser.getUserId()) || Constants.IsEEUser(rwsUser.getUserId())))) {
			return mapping.findForward("unAuthorise");
		}

		
		String loggedUser = rwsUser.getUserId();
		String circle=loggedUser.substring(1,3);
		String message = null;
		ArrayList users=new ArrayList();
		ArrayList circles=new ArrayList();
		ArrayList divisions=new ArrayList();
		ArrayList subDivisions=new ArrayList();
		String mode = request.getParameter("mode");
		
		AuthorisedMobileUserDetailsForm frm = (AuthorisedMobileUserDetailsForm) form;
		RwsOffices offices=new  RwsOffices();
		String headOfficeCode="1";
		
		if(mode!=null && mode.equalsIgnoreCase("get2"))
 		{
			
 			try{
 				
 				
 				if(loggedUser.equals("admin") || loggedUser.equals("100000") || loggedUser.equals("1000DR") || loggedUser.equals("secrwss"))
 				{
 					circles = offices.getCircles(headOfficeCode);
 					session.setAttribute("circles",circles);
 				
 				}
 				else
 				{
 					frm.setCircleOfficeName(offices.getCircleName(circle));
 					frm.setCircleOfficeCode(circle);
 					
 					
 				}
 				
	 				session.setAttribute("divisions",divisions);
				
				session.setAttribute("subDivisions",subDivisions);
				
				
 				if(frm.getCircleOfficeCode()!=null && !frm.getCircleOfficeCode().equals("")){
 					divisions=offices.getDivisions(headOfficeCode,frm.getCircleOfficeCode());
 	 				session.setAttribute("divisions",divisions);
 				}
 				if(frm.getCircleOfficeCode()!=null && !frm.getCircleOfficeCode().equals("") 
 						&& frm.getDivisionOfficeCode()!=null && !frm.getDivisionOfficeCode().equals("")){
 					
 					divisions=offices.getDivisions(headOfficeCode,frm.getCircleOfficeCode());
 	 				session.setAttribute("divisions",divisions);
 				subDivisions=offices.getSubdivisions(headOfficeCode,frm.getCircleOfficeCode(),frm.getDivisionOfficeCode());
 				session.setAttribute("subDivisions",subDivisions);
 				}
 				
 			   }
 			catch(Exception e)
			{
 				System.out.println("Exception in authorisedmobileuserdetailsaction-- "+e);
			}
 			page_to_be_displayed="get2";
 		}
		
		
		if(mode!=null && mode.equalsIgnoreCase("userData"))
		{
              try{
 			
            	  AuthorisedMobileUserDetailsDAO userActionDAO=new AuthorisedMobileUserDetailsDAO();
 				if (frm.getUsers() != null && frm.getUsers().size() > 1) {
					frm.getUsers().clear();
				}
 				
 				users=userActionDAO.getuserDetails(frm);
 					
 				frm.setUsers(users);
 				session.setAttribute("users", users);
 				
 				
 			   }
 			catch(Exception e)
			{
 				System.out.println("Exception in authorizedmobileuseraction"+e);
			}
 			page_to_be_displayed="userData";	
		} 
		
		if(mode!=null && mode.equalsIgnoreCase("Save"))
 		{
			
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				
			String habcode=request.getParameter("habcode");
			String imeiNo=request.getParameter("imeiNo");
			
			String habcode1[]=habcode.split(",");
			String imeiNo1[]=imeiNo.split(",");
					
 			try{
 			
 				AuthorisedMobileUserDetailsDAO userActionDAO=new AuthorisedMobileUserDetailsDAO();
 					
 			message=userActionDAO.updateUserDetails(frm,loggedUser,habcode1,imeiNo1);
 				
 				 request.setAttribute("message", message);
 				 
 				if (frm.getUsers() != null && frm.getUsers().size() > 1) {
					frm.getUsers().clear();
				} 
 				
 				users=userActionDAO.getuserDetails(frm);
 					
 				frm.setUsers(users);
 				session.setAttribute("users", users);
 			   }
 			catch(Exception e)
			{
 				System.out.println("Exception"+e);
			}
 			mode="userData";
 		} 
	}

	if(mode!=null&&mode.equalsIgnoreCase("userDataView"))

	{
		try {

			AuthorisedMobileUserDetailsDAO genericActionDAO = new AuthorisedMobileUserDetailsDAO();
			if (frm.getUsers() != null && frm.getUsers().size() > 1) {
				frm.getUsers().clear();
			}

			users = genericActionDAO.getuserDetailsAll(frm);

			frm.setUsers(users);
			session.setAttribute("users", users);

		} catch (Exception e) {
			System.out.println("Exception in authorizedmobileuserdetailsaction" + e);
		}
		page_to_be_displayed = "userDataView";
	}

	return mapping.findForward(page_to_be_displayed);
	}

	private void reset(AuthorisedMobileUserDetailsForm frm,
			HttpSession session) {
		frm.setUsers(new ArrayList());
	}

}
