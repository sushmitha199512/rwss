package nic.watersoft.masters;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class Rws_Ddws_Lnk_Entry_Act extends Action {

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String message=null;
		ArrayList ddwsComponents=null;
		HttpSession session=request.getSession();
		String storedToken = (String)session.getAttribute("csrfToken");
	    String token = request.getParameter("token");
	    RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}
		RwsMileStoneStageForm frm=(RwsMileStoneStageForm) form;
		String mode=frm.getMode();
		RwsDDWSMileStoneDAO rwsMileStoneDAO=new RwsDDWSMileStoneDAO();
		CommonLists commonLists = new CommonLists();
		if(mode!=null && mode.equalsIgnoreCase("data")){
			if(request.getParameter("special")!=null && request.getParameter("special").equals("Y")){
				reset(frm);				
			}
			try	{
				String mode1=request.getParameter("mode1");				
				if(mode1!=null && mode1.equals("stageCode")){ 					
					request.setAttribute("mileStoneStageList",rwsMileStoneDAO.getMileStoneStageList(frm.getMileStoneCode()));
				}				
				request.setAttribute("ddwsCompList",rwsMileStoneDAO.getDdwsCompList());
				request.setAttribute("mileStonesList",rwsMileStoneDAO.getMileStonesList());
				request.setAttribute("sourceTypes", commonLists.getSourceTypes());
				if(mode1!=null && mode1.equals("subSource")){ 
					request.setAttribute("mileStoneStageList",rwsMileStoneDAO.getMileStoneStageList(frm.getMileStoneCode()));
					request.setAttribute("subSourceTypes", commonLists.getSubsourceTypes(frm.getSourceType()));
				}				 
			}			
			catch(Exception e){
				System.out.println("The Exception in Rws_Ddws_Lnk_Entry_Act in Data is  = "+e.getMessage());
			}
		}
		if(mode!=null && mode.equalsIgnoreCase("editStatus"))
		{
			 String res=rwsMileStoneDAO.editDisplayStatus(frm.getDdwsComp(),frm.getDisplayStatus());
				 request.setAttribute("message",res);
				 mode="View";
		}
		if(mode!=null && mode.equalsIgnoreCase("save"))	{			
			if (storedToken.equals(token)) {	
				message=rwsMileStoneDAO.saveDdwsCompLink(frm.getDdwsCompCode(),frm.getMileStoneCode(),frm.getMileStoneStageCode(),frm.getSourceType(),frm.getSubSourceType(),frm.getDisplayStatus());
				reset(frm);
				request.setAttribute("ddwsCompList",rwsMileStoneDAO.getDdwsCompList());
				request.setAttribute("mileStonesList",rwsMileStoneDAO.getMileStonesList());
				request.setAttribute("message",message);	
			}
		}
		if(mode!=null && mode.equalsIgnoreCase("View")){			
			ddwsComponents=rwsMileStoneDAO.getDdwsComponents();
			session.setAttribute("ddwsComponents",ddwsComponents);
		}
		if(mode!=null && mode.equalsIgnoreCase("get")){	
			request.setAttribute("mileStoneStageList",rwsMileStoneDAO.getMileStoneStageList(frm.getMileStoneCode()));
			request.setAttribute("ddwsCompList",rwsMileStoneDAO.getDdwsCompList());
			request.setAttribute("mileStonesList",rwsMileStoneDAO.getMileStonesList());
			request.setAttribute("sourceTypes", commonLists.getSourceTypes());
			request.setAttribute("subSourceTypes", commonLists.getSubsourceTypes(frm.getSourceType()));
			String mode1=request.getParameter("mode1");
			if(mode1!=null && mode1.equals("stageCode")){ 						
				request.setAttribute("mileStoneStageList",rwsMileStoneDAO.getMileStoneStageList(frm.getMileStoneCode()));
			}
			if(mode1!=null && mode1.equals("subSource")){ 
				request.setAttribute("mileStoneStageList",rwsMileStoneDAO.getMileStoneStageList(frm.getMileStoneCode()));
				request.setAttribute("subSourceTypes", commonLists.getSubsourceTypes(frm.getSourceType()));
			}	
			if(frm.getDisplayStatus().equals("YES"))
				frm.setDisplayStatus("Y");
			else
				frm.setDisplayStatus("N");
		}

		if(mode!=null && mode.equalsIgnoreCase("edit"))	{	
			if (storedToken.equals(token)) {	
				 String res=rwsMileStoneDAO.editDdwsCompLink(frm.getDdwsCompCode(),frm.getMileStoneCode(),frm.getMileStoneStageCode(),frm.getSourceType(),frm.getSubSourceType(),frm.getDdwsComp(),frm.getDisplayStatus());
				 request.setAttribute("message",res);		
			}
		}
		return mapping.findForward(mode);
	}

	private void reset(RwsMileStoneStageForm frm) {
		frm.setDdwsCompCode("");
		frm.setMileStoneCode("");
		frm.setMileStoneStageName("");
		frm.setMileStoneStageCode("");
		frm.setDisplayStatus("");
	}
}