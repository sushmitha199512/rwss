
package nic.watersoft.admin;

import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsUser;


public class HabFreezUnfreez_act extends Action {	
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {	
		System.out.println("hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
			  HabFreezUnfreezForm frm=new HabFreezUnfreezForm();
              String mode = request.getParameter("mode");
              String fyear= request.getParameter("finyear");
			  HttpSession session= request.getSession();
			  String storedToken = (String)session.getAttribute("csrfToken");
			  String token = request.getParameter("token");
			  RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
			  if (user == null)
				  return mapping.findForward("expire");		
			  if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
				  return mapping.findForward("unAuthorise");	
			  }
			  String message=null;
			  String page_to_be_displayed="";
			  String hyear="";
			  boolean myqry=false;
			  Statement stat1 = null,stat2=null,stat3=null,stat4=null;			  
			  Rws_Hab_Freeze_Unfreeze_DAO dao=new Rws_Hab_Freeze_Unfreeze_DAO();
			  if(mode!=null && mode.equals("display")){	
				  System.out.println("inside display     sssssssssssssssssssssssssssssssssssssssssssssssss");
				 	try	{
				 		hyear=dao.getHYear();
				 		String cyear=hyear.substring(6,10);
				 		session.setAttribute("cyear",cyear);					
					}
				 	catch(Exception p){
				 		p.printStackTrace();
				 		System.out.println("The Exception in HabFreezUnfreez in display is  = "+p.getMessage());
					}
					page_to_be_displayed="display";
				 }
					
				if(mode!=null && mode.equals("view")) {
					 if (storedToken.equals(token)) {	
					 	try	{
					 		int hisyear=Integer.parseInt(fyear)-2;
						 	int preyear=Integer.parseInt(fyear)-1;					 	
						 	String pyear=String.valueOf(preyear);
						 	String upyear=fyear.substring(2,4);
						 	myqry= dao.getHabFreezUnfreez(hisyear,pyear,upyear);						 	
						 	if(myqry==true){						
						 		message="Batch processed Successfully";
							}
							else {	
								message="Batch cannot be processed.Already habitation data was processed for "+fyear;
							}
						} catch(Exception e)	{
							System.out.println("The Exception in HabFreezUnfreez in view is  = "+e.getMessage());
						}
						page_to_be_displayed="view";
				     }
				  }	
				request.setAttribute("message",message);		     
				
			return mapping.findForward(page_to_be_displayed);				 
 		 }	
	 }