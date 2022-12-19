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

public class Rws_Ddws_MilestoneStage_Entry_Act extends Action {
	
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ArrayList mileStoneSages=null;
		HttpSession session=request.getSession();
		String storedToken = (String)session.getAttribute("csrfToken");
	    String token = request.getParameter("token");
	    RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");			}
		RwsMileStoneStageForm frm=(RwsMileStoneStageForm) form;
		String mode=frm.getMode();
		RwsDDWSMileStoneDAO rwsMileStoneDAO=new RwsDDWSMileStoneDAO();
		if(mode!=null && mode.equalsIgnoreCase("data")) {
			if(request.getParameter("special")!=null && request.getParameter("special").equals("Y")){
				reset(frm);				
			}
			try	{
				String mode1=request.getParameter("mode1");				
				if(mode1!=null && mode1.equals("stageCode")){ 
					request.setAttribute("mileStoneStageCode","");
					request.setAttribute("mileStoneStageCode",RwsDDWSMileStoneDAO.getMileStoneStageCode(frm.getMileStoneCode()));
				}				
				request.setAttribute("mileStonesList",rwsMileStoneDAO.getMileStonesList());
			}
			catch(Exception e){
				System.out.println("The Exception in Rws_Ddws_MilestoneStage_Entry_Act.jsp in data is  = "+e.getMessage());
			}
		}
		
		if(mode!=null && mode.equalsIgnoreCase("save"))	{		
			if (storedToken.equals(token)) {	
				int res=rwsMileStoneDAO.saveMileStoneStage(frm.getMileStoneCode(),frm.getMileStoneStageCode(),frm.getMileStoneStageName(),frm.getMileStoneStagePercentage());
				reset(frm);
				request.setAttribute("mileStonesList",rwsMileStoneDAO.getMileStonesList());
				if(res>0){
						request.setAttribute("message","Added Successfully");
				}	
				if(res==-1){
					request.setAttribute("message","Milestone Stage Cumulative Percentage Exceeded from Milestone Percentage");
				}
			}
		}
		
		if(mode!=null && mode.equalsIgnoreCase("View"))	{
			mileStoneSages=rwsMileStoneDAO.getMileStoneStages();
			session.setAttribute("mileStoneSages",mileStoneSages);
		}	

		if(mode!=null && mode.equalsIgnoreCase("edit"))	{
			if (storedToken.equals(token)) {	
				 int res=rwsMileStoneDAO.editMileStoneStage(frm.getMileStoneCode(),frm.getMileStoneStageName(),frm.getMileStoneStageCode(),frm.getDdwsLinked(),frm.getMileStoneStagePercentage());			
				 if(res>0){
					 request.setAttribute("message","Edit Successfully");
				 }		
				 if(res==-1){
						request.setAttribute("message","Milestone Stage Cumulative Percentage Exceeded from Milestone Percentage");
				 }
			}
		}		
		return mapping.findForward(mode);
	}

	private void reset(RwsMileStoneStageForm frm) {		
		frm.setMileStoneCode("");
		frm.setMileStoneStageName("");
		frm.setMileStoneStageCode("");
		frm.setMileStoneStagePercentage(0);
	}
}