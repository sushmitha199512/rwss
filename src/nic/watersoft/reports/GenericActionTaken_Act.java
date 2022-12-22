package nic.watersoft.reports;


import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.drought.DroughtForm;
import nic.watersoft.drought.DroughtMasterData;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class GenericActionTaken_Act extends Action {
	
	public  GenericActionTaken_Act()
	{
		
	}
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HttpSession session = request.getSession();
		
		String page_to_be_displayed="get2";	
		RwsUser rwsUser = (RwsUser)session.getAttribute("RWS_USER");
		String loggedUser = rwsUser.getUserId();
		System.out.println("loggedUser in action"+loggedUser);
		String circle=loggedUser.substring(1,3);
		System.out.println("circle"+circle);
		String message = null;
		ArrayList generic=new ArrayList();
		
		String mode = request.getParameter("mode");
		System.out.println("mode"+mode);
		GenericActionForm genericActionForm = new GenericActionForm();
		GenericActionForm frm = (GenericActionForm) form;
		if(mode!=null && mode.equalsIgnoreCase("get2"))
 		{
			
 			try{
 			
 				GenericActionDAO genericActionDAO=new GenericActionDAO();
 				generic=genericActionDAO.getgenericDetails(circle);
 				
 				frm.setGeneric(generic);
 				session.setAttribute("generic", generic);
 				System.out.println("generic in action anu"+generic.size());
 			   }
 			catch(Exception e)
			{
 				System.out.println("Exception"+e);
			}
 			page_to_be_displayed="get2";
 		}
		
		
		
		
		
		
		
		if(mode!=null && mode.equalsIgnoreCase("Save"))
 		{
			System.out.println("hello i am save");
 			try{
 			
 				GenericActionDAO genericActionDAO=new GenericActionDAO();
 					String complaintnumber=request.getParameter("comnum");
 					String pnum=request.getParameter("phonenumber");
 					String actiontaken=request.getParameter("actiontaken");
 					String sctiondesc=request.getParameter("sctiondesc");
 					String attendedby=request.getParameter("attendedby");
 					String attendedate=request.getParameter("attendedate");
 					String messentgrevence=request.getParameter("messentgrevence");
 					String dateofsent=request.getParameter("dateofsent");
 					String category=request.getParameter("category");
 					System.out.println("complaintnumber"+complaintnumber);
 					System.out.println("pnum"+pnum);
 					System.out.println("actiontaken"+actiontaken);
 					System.out.println("sctiondesc"+sctiondesc);
 					System.out.println("attendedby"+attendedby);
 					System.out.println("attendedate"+attendedate);
 					System.out.println("messentgrevence"+messentgrevence);
 					System.out.println("dateofsent"+dateofsent);
 					System.out.println("category"+category);
 					
 				int genericcomp=genericActionDAO.insertActiontaken(complaintnumber,pnum,actiontaken,sctiondesc,attendedby,attendedate,messentgrevence,dateofsent,category,getDataSource(request));
 				if(genericcomp < 1)
                	message = "Record Can't be inserted";
                    
                else
                	message = "Record Inserted Successfully";
                Debug.println("message" + message);
                request.setAttribute("message", message);
 				
 				System.out.println("generic in action an324u"+genericcomp);
 			   }
 			catch(Exception e)
			{
 				System.out.println("Exception"+e);
			}
 			page_to_be_displayed="Save";
 		}
		
		
		 return mapping.findForward(page_to_be_displayed);
	}
	

}
