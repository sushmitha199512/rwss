package nic.watersoft.masters;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.ValidationUtils;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_repair_type_entry_frm extends Action{
	
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)  {
		String message=null;
		ArrayList repairs=null;
		HttpSession session=request.getSession();
		String storedToken = (String)session.getAttribute("csrfToken");
	     String token = request.getParameter("token");
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}
		rws_functional_repair_frm frm=(rws_functional_repair_frm) form;
		String displaymess=null;
		String mode = frm.getMode();	
		Rws_Functional_Status_Dao dao=new Rws_Functional_Status_Dao();
		ValidationUtils validate = new ValidationUtils ();
		
		try	{
			if(mode!=null && mode.equalsIgnoreCase("data"))	{			
				if(request.getParameter("special")!=null && request.getParameter("special").equals("Y")){
					reset(frm);
				}								
					request.setAttribute("repairCode",dao.getRepairCode());							
			}	
			
			if(mode!=null && mode.equalsIgnoreCase("save"))	{
				if (storedToken.equals(token)) {
					if(frm.getRepairName() != null && validate.alphaNumWithSpaceValidator(frm.getRepairName()) != true){
						request.setAttribute("message","Repair Name Only Contains Alphabets with Space");
					}else{
						int res=dao.saveRepair(frm.getRepairCode(),frm.getRepairName());
						reset(frm);
						if(res>0){
							request.setAttribute("repairCode",dao.getRepairCode());
							request.setAttribute("message","Added Successfully");
						}
					}
				}
			}		
			
			if(mode!=null && mode.equalsIgnoreCase("View"))	{
				repairs=dao.getRepairs();
				session.setAttribute("repairs",repairs);
			}	
			
			if(mode!=null && mode.equalsIgnoreCase("edit"))	{
				if (storedToken.equals(token)) {	
					 int res=dao.editRepair(frm.getRepairCode(),frm.getRepairName());
					 if(res>0){
						session.setAttribute("message","Edit Successfully");
					 }		
				}
			}	
		} catch(Exception e) {
			System.out.println("The Exception in rws_Repair_type_entry_frm is  : "+e.getMessage());
		}
		return mapping.findForward(mode);	
	}
	
	private void reset(rws_functional_repair_frm frm) {		
		frm.setRepairCode("");
		frm.setRepairName("");
	}	
}
