
package nic.watersoft.masters;

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


public class Rws_Reason_forDelay_Entry_Act extends Action {

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {		
		String message=null;
		ArrayList reasons=null;
		HttpSession session=request.getSession();
		String storedToken = (String)session.getAttribute("csrfToken");
	    String token = request.getParameter("token");
	    RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}
		Rws_Reason_forDelay_Entry_Form frm=(Rws_Reason_forDelay_Entry_Form) form;
		String displaymess=null;
		String mode=frm.getMode();		
		Rws_Reason_forDelay_Entry_DAO dao=new Rws_Reason_forDelay_Entry_DAO();
		if(mode!=null && mode.equalsIgnoreCase("data")){			
			if(request.getParameter("special")!=null && request.getParameter("special").equals("Y")){
				reset(frm);
			}
			try	{				
				request.setAttribute("reasonCode",dao.getReasonCode());				
			}
			catch(Exception e) {
				System.out.println("The Exception in Rws_Reason_forDelay_Entry_Act in Data is  = "+e.getMessage());
			}
		}
		
		if(mode!=null && mode.equalsIgnoreCase("save")){
			try	{				
				int res=dao.saveReason(frm.getReasonCode(),frm.getReasonName());
				reset(frm);
				if(res>0){
					request.setAttribute("reasonCode",dao.getReasonCode());
					request.setAttribute("message","Added Successfully");
				}
			}
			catch(Exception e){
				System.out.println("The Exception in Rws_Reason_forDelay_Entry_Act in Save is  = "+e.getMessage());
			}		
		}
		
		if(mode!=null && mode.equalsIgnoreCase("View")){
			reasons=dao.getReasons();
			session.setAttribute("reasons",reasons);
		}	

		if(mode!=null && mode.equalsIgnoreCase("edit"))	{
			 int res=dao.editReason(frm.getReasonCode(),frm.getReasonName());
			 if(res>0){
				session.setAttribute("message","Edit Successfully");
			 }	
		}	
		return mapping.findForward(mode);
	}

	private void reset(Rws_Reason_forDelay_Entry_Form frm) {		
		frm.setReasonCode("");
		frm.setReasonName("");
	}
}