package nic.watersoft.complaints;


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
import nic.watersoft.smsmobile.Rws_Employee_Mobile_Updation_DAO;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class Ur_Employee_Mobile_Updation_Action extends Action {
	
	public  Ur_Employee_Mobile_Updation_Action()
	{
		
	}
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HttpSession session = request.getSession();
		
		String page_to_be_displayed="get2";	
		RwsUser rwsUser = (RwsUser)session.getAttribute("RWS_USER");
		String loggedUser = rwsUser.getUserId();
System.out.println("loggedUser in action");
		String circle=loggedUser.substring(1,3);
		
		String message = null;
		
		ArrayList circles=new ArrayList();
		ArrayList divisions=new ArrayList();
		ArrayList subDivisions=new ArrayList();
		ArrayList employeeIds=new ArrayList();
		ArrayList designations=new ArrayList();
		ArrayList divisions1=new ArrayList();
		ArrayList subDivisions1=new ArrayList();
		ArrayList circles1=new ArrayList();
		String mode = request.getParameter("mode");
		
		Ur_Employee_Mobile_Updation_Form frm = (Ur_Employee_Mobile_Updation_Form) form;
		RwsOffices offices=new RwsOffices();
		String headOfficeCode="2";
		Rws_Employee_Mobile_Updation_DAO employee_entry_dao=new  Rws_Employee_Mobile_Updation_DAO();
		if(mode!=null && mode.equalsIgnoreCase("get"))
 		{
			//reset(frm);
 			try{
 				
 				
 				
 				if(loggedUser.equals("admin") || loggedUser.equals("200000") || loggedUser.equals("1000DR") || loggedUser.equals("secrwss"))
 				{
 					circles = offices.getUrbanCircles(headOfficeCode);
 					session.setAttribute("circles",circles);
 				
 				}
 				else
 				{
 					frm.setCircleOfficeName(offices.getCircleName(circle));
 					frm.setCircleOfficeCode(circle);
 					
 					
 				}
 				
	 				session.setAttribute("divisions",divisions);
				
				session.setAttribute("subDivisions",subDivisions);
				System.out.println(frm.getDivisionOfficeCode());
				System.out.println(frm.getCircleOfficeCode());
				session.setAttribute("employeeIds",employeeIds);
				
 				if(frm.getCircleOfficeCode()!=null && !frm.getCircleOfficeCode().equals("")){
 					divisions=offices.getUrbanDivisions(headOfficeCode,frm.getCircleOfficeCode());
 	 				session.setAttribute("divisions",divisions);
 				}
 				if(frm.getCircleOfficeCode()!=null && !frm.getCircleOfficeCode().equals("") 
 						&& frm.getDivisionOfficeCode()!=null && !frm.getDivisionOfficeCode().equals("")){
 					System.out.println("inside subdivision");
 					divisions=offices.getUrbanDivisions(headOfficeCode,frm.getCircleOfficeCode());
 	 				session.setAttribute("divisions",divisions);
 				subDivisions=offices.getUrbanSubdivisions(headOfficeCode,frm.getCircleOfficeCode(),frm.getDivisionOfficeCode());
 				session.setAttribute("subDivisions",subDivisions);
 				}
 				if(frm.getCircleOfficeCode()!=null && !frm.getCircleOfficeCode().equals("")
 						&& frm.getDivisionOfficeCode()!=null && !frm.getDivisionOfficeCode().equals("")
 						&& frm.getSubDivisionOfficeCode()!=null && !frm.getSubDivisionOfficeCode().equals("")){
 					System.out.println("inside employeeIds");
 					divisions=offices.getUrbanDivisions(headOfficeCode,frm.getCircleOfficeCode());
 	 				session.setAttribute("divisions",divisions);
 				subDivisions=offices.getUrbanSubdivisions(headOfficeCode,frm.getCircleOfficeCode(),frm.getDivisionOfficeCode());
 				session.setAttribute("subDivisions",subDivisions);
 				employeeIds=employee_entry_dao.getUrbanEmployeeIds(frm,mode);
 				session.setAttribute("employeeIds",employeeIds);
 				}
 				if(frm.getCircleOfficeCode()!=null && !frm.getCircleOfficeCode().equals("")
 						&& frm.getDivisionOfficeCode()!=null && !frm.getDivisionOfficeCode().equals("")
 						&& frm.getSubDivisionOfficeCode()!=null && !frm.getSubDivisionOfficeCode().equals("")
 						&& frm.getEmployeeId()!=null && !frm.getEmployeeId().equals("")){
 					divisions=offices.getUrbanDivisions(headOfficeCode,frm.getCircleOfficeCode());
 	 				session.setAttribute("divisions",divisions);
 				subDivisions=offices.getUrbanSubdivisions(headOfficeCode,frm.getCircleOfficeCode(),frm.getDivisionOfficeCode());
 				session.setAttribute("subDivisions",subDivisions);
 				employeeIds=employee_entry_dao.getUrbanEmployeeIds(frm,mode);
 				session.setAttribute("employeeIds",employeeIds);
 				String NameMobile=employee_entry_dao.getUrbanEmployeeName(frm);
 				String ar[]=NameMobile.split("/");
 				frm.setEmployeeName(ar[0]);
 				frm.setEmployeeMobile(ar[1]);
 				}
 			   }
 			catch(Exception e)
			{
 				System.out.println("Exception"+e);
			}
 			page_to_be_displayed="get";
 		}
		
		if(mode!=null && mode.equalsIgnoreCase("headOffice"))
 		{
			
 			try{
 				
 				employeeIds=employee_entry_dao.getUrbanEmployeeIds(frm,mode);
 				session.setAttribute("employeeIds",employeeIds);
 				
 				
 			   }
 			catch(Exception e)
			{
 				System.out.println("Exception"+e);
			}
 			page_to_be_displayed="get";
 		}
		if(mode!=null && mode.equalsIgnoreCase("circleOffice"))
 		{
			
 			try{
 				divisions=offices.getDivisions(headOfficeCode,frm.getCircleOfficeCode());
 				session.setAttribute("divisions",divisions);
 				employeeIds=employee_entry_dao.getUrbanEmployeeIds(frm,mode);
 				session.setAttribute("employeeIds",employeeIds);
 				
 				
 			   }
 			catch(Exception e)
			{
 				System.out.println("Exception"+e);
			}
 			page_to_be_displayed="get";
 		}
		
		
		if(mode!=null && mode.equalsIgnoreCase("circleOffice1"))
 		{
			
 			try{
 				
 				
 				
 				divisions1=offices.getDivisions(headOfficeCode,frm.getCircleOfficeCode1());
 				session.setAttribute("divisions1",divisions1);
 				designations=employee_entry_dao.getUrbandisignatons(frm);
 				session.setAttribute("designations",designations);
 				
 				
 			   }
 			catch(Exception e)
			{
 				e.printStackTrace();
			}
 			page_to_be_displayed="officechnges";
 		}
		
		
		if(mode!=null && mode.equalsIgnoreCase("divisionOffice"))
 		{
			
 			try{
 				divisions=offices.getDivisions(headOfficeCode,frm.getCircleOfficeCode());
	 			session.setAttribute("divisions",divisions);
				subDivisions=offices.getSubdivisions(headOfficeCode,frm.getCircleOfficeCode(),frm.getDivisionOfficeCode());
				session.setAttribute("subDivisions",subDivisions);
 				employeeIds=employee_entry_dao.getUrbanEmployeeIds(frm,mode);
 				session.setAttribute("employeeIds",employeeIds);
 				
 				
 			   }
 			catch(Exception e)
			{
 				System.out.println("Exception"+e);
			}
 			page_to_be_displayed="get";
 		}
		
		if(mode!=null && mode.equalsIgnoreCase("divisionOffice1"))
 		{
			
 			try{
 				
 				
 				divisions1=offices.getDivisions(headOfficeCode,frm.getCircleOfficeCode1());
	 				session.setAttribute("divisions1",divisions1);
				subDivisions1=offices.getSubdivisions(headOfficeCode,frm.getCircleOfficeCode1(),frm.getDivisionOfficeCode1());
				session.setAttribute("subDivisions1",subDivisions1);
				designations=employee_entry_dao.getUrbandisignatons(frm);
 				session.setAttribute("designations",designations);
 				
 				
 			   }
 			catch(Exception e)
			{
 				e.printStackTrace();
			}
 			page_to_be_displayed="officechnges";
 		}
		
		
		if(mode!=null && mode.equalsIgnoreCase("subDivisionOffice"))
 		{
			
 			try{
 				
 				employeeIds=employee_entry_dao.getUrbanEmployeeIds(frm,mode);
 				session.setAttribute("employeeIds",employeeIds);
 				
 				
 				
 				
 				
 				
 			   }
 			catch(Exception e)
			{
 				System.out.println("Exception"+e);
			}
 			page_to_be_displayed="get";
 		}
		
		
		if(mode!=null && mode.equalsIgnoreCase("subDivisionOffice1"))
 		{
			
 			try{
 				
 				String NameMobile=employee_entry_dao.getUrbanEmployeeName(frm);
 				String ar[]=NameMobile.split("/");
 				
 				frm.setDesignation(ar[2]);
 				System.out.println("ar[1]"+ar[2]);
 				
 				designations=employee_entry_dao.getUrbandisignatons(frm);
 				session.setAttribute("designations",designations);
 				
 				
 			   }
 			catch(Exception e)
			{
 				e.printStackTrace();
			}
 			page_to_be_displayed="officechnges";
 		}
		
		if(mode!=null && mode.equalsIgnoreCase("officechnges"))
		{
			
			System.out.println("officechnges action");
			
 			try{
 				frm.setHeadOfficeCode(frm.getHeadOfficeCode());
 				frm.setCircleOfficeCode(frm.getCircleOfficeCode());
 				frm.setCircleOfficeName(frm.getCircleOfficeName());
 				frm.setDivisionOfficeCode(frm.getDivisionOfficeCode());
 				frm.setSubDivisionOfficeCode(frm.getSubDivisionOfficeCode());
 				frm.setEmployeeId(frm.getEmployeeId());
 				frm.setDesignations(frm.getDesignations());
 				String circle1=frm.getCircleOfficeCode();
 				System.out.println("circle1"+circle1);
 				
 				
 				
 					circles1 = offices.getCircles(headOfficeCode);
 					session.setAttribute("circles1",circles1);
 				
 				
 				
	 				session.setAttribute("divisions1",divisions1);
	 				session.setAttribute("subDivisions1",subDivisions1);
	 				session.setAttribute("designations",designations);
				
 				if(frm.getCircleOfficeCode1()!=null && !frm.getCircleOfficeCode1().equals("")){
 					divisions1=offices.getDivisions(headOfficeCode,frm.getCircleOfficeCode1());
 	 				session.setAttribute("divisions1",divisions1);
 				}
 				if(frm.getCircleOfficeCode1()!=null && !frm.getCircleOfficeCode1().equals("") 
 						&& frm.getDivisionOfficeCode1()!=null && !frm.getDivisionOfficeCode1().equals("")){
 					System.out.println("inside subdivision");
 					divisions1=offices.getDivisions(headOfficeCode,frm.getCircleOfficeCode1());
 	 				session.setAttribute("divisions1",divisions1);
 				subDivisions1=offices.getSubdivisions(headOfficeCode,frm.getCircleOfficeCode1(),frm.getDivisionOfficeCode1());
 				session.setAttribute("subDivisions1",subDivisions1);
 				}
 				if(frm.getCircleOfficeCode1()!=null && !frm.getCircleOfficeCode1().equals("")
 						&& frm.getDivisionOfficeCode1()!=null && !frm.getDivisionOfficeCode1().equals("")
 						&& frm.getSubDivisionOfficeCode1()!=null && !frm.getSubDivisionOfficeCode1().equals("")){
 					System.out.println("inside employeeIds");
 					divisions1=offices.getDivisions(headOfficeCode,frm.getCircleOfficeCode1());
 	 				session.setAttribute("divisions1",divisions1);
 				subDivisions1=offices.getSubdivisions(headOfficeCode,frm.getCircleOfficeCode1(),frm.getDivisionOfficeCode1());
 				session.setAttribute("subDivisions1",subDivisions1);
 				
 				}
 				
 				if(frm.getCircleOfficeCode1()!=null && !frm.getCircleOfficeCode1().equals("")
 						&& frm.getDivisionOfficeCode1()!=null && !frm.getDivisionOfficeCode1().equals("")
 						&& frm.getSubDivisionOfficeCode1()!=null && !frm.getSubDivisionOfficeCode1().equals("")
 						&& frm.getEmployeeId()!=null && !frm.getEmployeeId().equals("")){
 					divisions1=offices.getDivisions(headOfficeCode,frm.getCircleOfficeCode1());
 	 				session.setAttribute("divisions1",divisions1);
 				subDivisions1=offices.getSubdivisions(headOfficeCode,frm.getCircleOfficeCode1(),frm.getDivisionOfficeCode1());
 				session.setAttribute("subDivisions1",subDivisions1);
 				designations=employee_entry_dao.getUrbandisignatons(frm);
 				session.setAttribute("designations",designations);
 				/*employeeIds=employee_entry_dao.getEmployeeIds(frm,mode);
 				session.setAttribute("employeeIds",employeeIds);*/
 				/*String NameMobile=employee_entry_dao.getEmployeeName(frm);
 				String ar[]=NameMobile.split("/");
 				frm.setEmployeeName(ar[0]);
 				frm.setEmployeeMobile(ar[1]);*/
 				}
 			   }
 			catch(Exception e)
			{
 				e.printStackTrace();
			}
 			page_to_be_displayed="officechnges";
 		}
		
		if(mode!=null && mode.equalsIgnoreCase("employeeId"))
 		{
			
 			try{
 				
 				
 				String NameMobile=employee_entry_dao.getUrbanEmployeeName(frm);
 				String ar[]=NameMobile.split("/");
 				frm.setEmployeeName(ar[0]);
 				frm.setEmployeeMobile(ar[1]);
 				frm.setDesignation(ar[2]);
 				frm.setOfficecode(ar[3]);
 				System.out.println("ar[1]"+ar[3]);
 				
 				
 				
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
 			
            	  
 				
 				message=employee_entry_dao.updateUrbanMobile(frm);
 				
 					request.setAttribute("message", message);
 					reset(frm);
 				
 				
 			   }
 			catch(Exception e)
			{
 				e.printStackTrace();
			}
 			page_to_be_displayed="ubdateMobile";	
		} 
		
		
		
		if(mode!=null && mode.equalsIgnoreCase("officedetailsup"))
		{
			
              try{
 			
            	  
 				
 				message=employee_entry_dao.updateUrbanofficedetils(frm);
 				
 					request.setAttribute("message", message);
 					reset(frm);
 				
 				
 			   }
 			catch(Exception e)
			{
 				e.printStackTrace();
			}
 			page_to_be_displayed="close";	
		} 
		if(mode!=null && mode.equalsIgnoreCase("viewMobile"))
		{
			
              try{
 			
            	  ArrayList list=new ArrayList();
 				
 			list=(ArrayList) employee_entry_dao.viewUrbanMobile(frm);
 				
 					session.setAttribute("list", list);
 					reset(frm);
 				
 				
 			   }
 			catch(Exception e)
			{
 				e.printStackTrace();
			}
 			page_to_be_displayed="viewMobile";	
		}	
		
		 return mapping.findForward(page_to_be_displayed);
	}
	
	private void reset(Ur_Employee_Mobile_Updation_Form myForm) {
		myForm.setCircleOfficeCode("");
		myForm.setDivisionOfficeCode("");
		myForm.setSubDivisionOfficeCode("");
		myForm.setEmployeeId("");
		myForm.setEmployeeName("");
		myForm.setEmployeeMobile("");
		
		
		
	}
	
	
	
	private void reset1(Ur_Employee_Mobile_Updation_Form myForm) {
		
		myForm.setEmployeeId("");
		myForm.setEmployeeName("");
		myForm.setEmployeeMobile("");
		myForm.setEmployeeName("");
		myForm.setEmployeeMobile("");
		
		
	}
	

}
