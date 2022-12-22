package nic.watersoft.masters;


import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.drought.DroughtForm;
import nic.watersoft.drought.DroughtMasterData;
import nic.watersoft.sms.SMS;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class Rws_Employee_Mobile_Updation_Action extends Action {
	
	public  Rws_Employee_Mobile_Updation_Action()
	{
		
	}
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HttpSession session = request.getSession();
		
		String page_to_be_displayed="get2";	
		RwsUser rwsUser = (RwsUser)session.getAttribute("RWS_USER");
		String loggedUser = rwsUser.getUserId();
		//System.out.println("loggedUser in action"+loggedUser);
		String circle=loggedUser.substring(1,3);
		
		String message = null;
		
		ArrayList circles=new ArrayList();
		ArrayList divisions=new ArrayList();
		ArrayList subDivisions=new ArrayList();
		ArrayList employeeIds=new ArrayList();
		String mode = request.getParameter("mode");
		
		Rws_Employee_Mobile_Updation_Form frm = (Rws_Employee_Mobile_Updation_Form) form;
		RwsOffices offices=new RwsOffices();
		String headOfficeCode="1";
		Rws_Employee_Mobile_Updation_DAO employee_entry_dao=new  Rws_Employee_Mobile_Updation_DAO();
		if(mode!=null && mode.equalsIgnoreCase("get"))
 		{
			
 			try{
 				
 				
 				
 				if(loggedUser.equals("admin") || loggedUser.equals("100000") || loggedUser.equals("1000DR") || loggedUser.equals("secrwss"))
 				{
 					circles = offices.getCircles(headOfficeCode);
 					session.setAttribute("circles",circles);
 				
 				}
 				else
 				{
 					frm.setCircleOfficeCode(offices.getCircleName(circle));
 					
 				}
 				if(frm.getCircleOfficeCode() != null && !frm.getCircleOfficeCode().equals("")){
 				divisions=offices.getDivisions(headOfficeCode,frm.getCircleOfficeCode());
 				session.setAttribute("divisions",divisions);
 				}
 				else
                {
                    session.setAttribute("divisions", new ArrayList());
                }
 				
 				subDivisions=offices.getSubdivisions(headOfficeCode,frm.getCircleOfficeCode(),frm.getDivisionOfficeCode());
 				session.setAttribute("subDivisions",subDivisions);
 				
 				employeeIds=employee_entry_dao.getEmployeeIds(frm);
 				session.setAttribute("employeeIds",employeeIds);
 				
 				frm.setEmployeeName(employee_entry_dao.getEmployeeName(frm));
 				
 			   }
 			catch(Exception e)
			{
 				System.out.println("Exception"+e);
			}
 			page_to_be_displayed="get";
 		}
		
	
		if(mode!=null && mode.equalsIgnoreCase("ubdateMobile"))
		{
			
              try{
 			
            	  
 				
 				message=employee_entry_dao.updateMobile(frm);
 				
 					request.setAttribute("message", message);
 					reset(frm);
 				
 				
 			   }
 			catch(Exception e)
			{
 				e.printStackTrace();
			}
 			page_to_be_displayed="ubdateMobile";	
		} 
		
		
		 return mapping.findForward(page_to_be_displayed);
	}
	
	private void reset(Rws_Employee_Mobile_Updation_Form myForm) {
		myForm.setCircleOfficeCode("");
		myForm.setDivisionOfficeCode("");
		myForm.setSubDivisionOfficeCode("");
		myForm.setEmployeeId("");
		myForm.setEmployeeName("");
		myForm.setEmployeeMobile("");
		
		
		
		
	}

}
