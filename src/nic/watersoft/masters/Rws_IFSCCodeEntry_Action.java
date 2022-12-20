/*
 * Created on Jan 11, 2011
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.masters;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
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

public class Rws_IFSCCodeEntry_Action extends Action {
	
	public ActionForward execute(ActionMapping mapping,ActionForm form,HttpServletRequest request,HttpServletResponse response)throws ServletException,IOException {		
		String message=null;
		ArrayList ifscdetails=null;
		HttpSession session=request.getSession();
		String storedToken = (String)session.getAttribute("csrfToken");
	    String token = request.getParameter("token");
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		System.out.println("user id :"+user.getUserId().substring(user.getUserId().length()-2));
		if (user == null)
			return mapping.findForward("expire");		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER)
				|| user.getUserId().substring(user.getUserId().length()-2).equals("EE") ))) {
			
			return mapping.findForward("unAuthorise");	
		}
		Rws_IFSCCode_Form frm=(Rws_IFSCCode_Form) form;
		String mode=frm.getMode();
		Rws_IFSCCode_DAO ifscCode_DAO=new Rws_IFSCCode_DAO();		
		try{
			if(mode!=null && mode.equalsIgnoreCase("data")) {
				if(request.getParameter("special")!=null && request.getParameter("special").equals("Y")){
					reset(frm);
				}
			}
				
			if(mode!=null && mode.equalsIgnoreCase("save")){
				 if (storedToken.equals(token)) {	
					message=ifscCode_DAO.saveIFSCCode(frm);
					request.setAttribute("message",message);
					reset(frm);	
				 }
			}
			
			if(mode.equalsIgnoreCase("view") || mode.equalsIgnoreCase("ViewReport")){
					ifscdetails=ifscCode_DAO.getIfscDetails();
					session.setAttribute("ifscdetails",ifscdetails);	
			}
			
			if(mode.equalsIgnoreCase("get")){
				form = ifscCode_DAO.getIfsc(request.getParameter("ifscCode"));
				if ("request".equalsIgnoreCase(mapping.getScope())){
					request.setAttribute(mapping.getAttribute(), form);
				}
				else {
					session.setAttribute(mapping.getAttribute(), form);
				}			
			}
			
			if(mode.equalsIgnoreCase("Update")){
				 if (storedToken.equals(token)) {	
					message=ifscCode_DAO.updateIfscDetails(frm);
					request.setAttribute("message",message);
				 }
			}
			
			if(mode.equalsIgnoreCase("delete")){			
				message=ifscCode_DAO.removeIfscDetails(request.getParameter("ifscCode"));
				request.setAttribute("message",message);			
			}			
		}
		catch(Exception e){
			System.out.println("The Exception in Rws_IFSCCodeEntry is  = "+e.getMessage());
		}
		return(mapping.findForward(mode));
	}
	
	void reset(Rws_IFSCCode_Form frm){
		frm.setBankName("");
		frm.setBranchName("");
		frm.setIfscCode("");
		frm.setMicrCode("");
		frm.setContactNumber("");
		frm.setAddress("");
		frm.setCity("");
		frm.setDistrict("");
	}
}
	