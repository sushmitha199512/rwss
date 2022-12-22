
package nic.watersoft.masters;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class Rws_Ddws_Milestone_Entry_Act extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ArrayList mileStones=null;
		HttpSession session=request.getSession();
		String storedToken = (String)session.getAttribute("csrfToken");
	    String token = request.getParameter("token");
	    RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}		
		RwsMileStoneForm frm=(RwsMileStoneForm) form;
		String mode=frm.getMode();
		RwsDDWSMileStoneDAO rwsMileStoneDAO=new RwsDDWSMileStoneDAO();
		
		if(mode!=null && mode.equalsIgnoreCase("data")){
			if(request.getParameter("special")!=null && request.getParameter("special").equals("Y")){
				reset(frm);
			}
			try	{
				request.setAttribute("mileStoneCode",RwsDDWSMileStoneDAO.getMileStoneCode());
			}
			catch(Exception e) {
				System.out.println("The Exception in Rws_Ddws_Milestone_Entry_Act in Data is  = "+e.getMessage());
			}
		}
		
		if(mode!=null && mode.equalsIgnoreCase("save")){
			if (storedToken.equals(token)) {	
				try	{				
					int res=rwsMileStoneDAO.saveMileStone(frm.getMileStoneCode(),frm.getMileStoneName(),frm.getPhyPercentage());
					reset(frm);
					request.setAttribute("mileStoneCode",RwsDDWSMileStoneDAO.getMileStoneCode());
					if(res>0){
							request.setAttribute("message","Added Successfully");
					}
				}
				catch(Exception e) {
					System.out.println("The Exception in Rws_Ddws_Milestone_Entry_Act in Save is  = "+e.getMessage());
				}
			}
		}
		
		if(mode!=null && mode.equalsIgnoreCase("View")) {
			mileStones=rwsMileStoneDAO.getMileStones();
			request.setAttribute("mileStones",mileStones);
		}
		
		if(mode!=null && mode.equalsIgnoreCase("edit")){
			System.out.println("in Edit");
			if (storedToken.equals(token)) {	
				System.out.println("in Edithgj ");
				 int res=rwsMileStoneDAO.editMileStone(frm.getMileStoneCode(),frm.getMileStoneName(),frm.getPhyPercentage());
					System.out.println("in Edithgj "+res);
				 if(res>0){
					session.setAttribute("message","Edit Successfully");
				 }	
			}
		}
		
		return mapping.findForward(mode);
	}

	private void reset(RwsMileStoneForm frm) {		
		frm.setMileStoneCode("");
		frm.setMileStoneName("");
		frm.setDdwsStatus("");
	}
}