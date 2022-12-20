package nic.watersoft.complaints;


import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;



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
		if (rwsUser == null) {
			return mapping.findForward("expire");
		}
		if (!(rwsUser.getUserId() != null && (rwsUser.getUserId().equals(Constants.ADMIN)
				|| rwsUser.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(rwsUser.getUserId()) || Constants.IsWaterQualityUser(rwsUser.getUserId()) || rwsUser.getUserId().equals(Constants.DROUGHT_USER) ))) {
			
			return mapping.findForward("unAuthorise");
		}
		String loggedUser = rwsUser.getUserId();
		
			
		
		String circle=loggedUser.substring(1,3);
		
		String message = null;
		ArrayList generic=new ArrayList();
		ArrayList districts=new ArrayList();
		String mode = request.getParameter("mode");
		
		GenericActionForm frm = (GenericActionForm) form;
		GenericActionDAO genericActionDAO=new GenericActionDAO();
		
		if(mode!=null && mode.equalsIgnoreCase("get2"))
 		{
			
 			try{		
 				
 				
 				
 				
 				if(loggedUser.equals("admin") || loggedUser.equals("100000") || loggedUser.equals("1000DR") || loggedUser.equals("1000WQ"))
 				{
 					districts = genericActionDAO.getDistricts();
 					session.setAttribute("districts",districts);
 				
 				}
 				else
 				{
 					districts = genericActionDAO.getDistricts1(circle);
 					session.setAttribute("districts",districts);
 				}
 				
 				
 			   }
 			catch(Exception e)
			{
 				Debug.write("Exception in GenericActionTaken_Act mode get2"+e);
			}
 			page_to_be_displayed="get2";
 		}
		if(mode!=null && mode.equalsIgnoreCase("imageView"))
 		{
			
			page_to_be_displayed="imageView";
 		}
		
		
		
		if(mode!=null && mode.equalsIgnoreCase("cmplaintData"))
		{
			
              try{
 			
 				
 				if (frm.getGeneric() != null && frm.getGeneric().size() > 1) {
					frm.getGeneric().clear();
				}
 				String dcode=request.getParameter("district");
					String date=request.getParameter("date");
					
 				if(loggedUser.equals("admin") || loggedUser.equals("100000") || loggedUser.equals("1000DR") )
 				{
 					
 					
 					generic=genericActionDAO.getgenericDetails(circle,dcode,date,loggedUser);
 					
 				}
 				else
 				{
 					generic=genericActionDAO.getgenericDetails(circle,dcode,date,loggedUser);
 				}
 				
 				
 				
 				frm.setGeneric(generic);
 				session.setAttribute("generic", generic);
 				
 				
 				
 				
 			   }
 			catch(Exception e)
			{
 				Debug.write("Exception in GenericActionTaken_Act mode cmplaintData"+e);
			}
 			page_to_be_displayed="get2";	
		}
		
			
		
		
		if(mode!=null && mode.equalsIgnoreCase("Save"))
 		{
			session = request.getSession();
		    String storedToken = (String)session.getAttribute("csrfToken");
		    String token = request.getParameter("token");
		    if (storedToken.equals(token))
		    {		
 			try{
 			
 				int genericcomp=GenericActionDAO.insertActiontaken(frm,getDataSource(request),request);
 				if(genericcomp < 1)
 				{
                	message = "Record Can't be inserted";
 				}  
                else
                {
                	message = "Record Inserted Successfully";                               	
               
                request.setAttribute("message", message);
                }
 				
 			   }
 			catch(Exception e)
			{
 				Debug.write("Exception in GenericActionTaken_Act mode cmplaintData"+e);
			}
		    }
 			page_to_be_displayed="Save";
		    
 		}
		
		
		 return mapping.findForward(page_to_be_displayed);
	}
	
	

}
