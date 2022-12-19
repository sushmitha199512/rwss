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


public class Rws_Ddws_Phy_Comp_Entry_Act extends Action {

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ArrayList ddwsPhyComps=null;
		HttpSession session=request.getSession();
		String storedToken = (String)session.getAttribute("csrfToken");
	    String token = request.getParameter("token");
	    RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}
		Rws_Ddws_Phy_Comp_Form frm=(Rws_Ddws_Phy_Comp_Form) form;
		String mode=frm.getMode();
		Rws_Ddws_Phy_Comp_DAO ddws_Phy_Comp_DAO=new Rws_Ddws_Phy_Comp_DAO();
		if(mode!=null && mode.equalsIgnoreCase("data"))	{
			if(request.getParameter("special")!=null && request.getParameter("special").equals("Y")){
				reset(frm);
			}
			try	{
				request.setAttribute("compCode",Rws_Ddws_Phy_Comp_DAO.getDdwsPhyCompCode());
			}
			catch(Exception e){
				System.out.println("The Exception in Rws_Ddws_Phy_Comp_Entry_Act in data is : "+e.getMessage());
			}
		}
		
		if(mode!=null && mode.equalsIgnoreCase("save")){
			if (storedToken.equals(token)) {	
				try {				
					int res=ddws_Phy_Comp_DAO.saveDdwsPhyComp(frm.getDdwsPhyCode(),frm.getDdwsPhyName());
					reset(frm);
					request.setAttribute("compCode",Rws_Ddws_Phy_Comp_DAO.getDdwsPhyCompCode());
					if(res>0){
							request.setAttribute("message","Added Successfully");
					}
				}
				catch(Exception e){
					System.out.println("The Exception in Rws_Ddws_Phy_Comp_Entry_Act in Save is : "+e.getMessage());
				}
			}
		}
		
		if(mode!=null && mode.equalsIgnoreCase("View")){
			ddwsPhyComps=ddws_Phy_Comp_DAO.getDdwsPhyComps();
			request.setAttribute("ddwsPhyComps",ddwsPhyComps);
		}	

		if(mode!=null && mode.equalsIgnoreCase("edit")){
			if (storedToken.equals(token)) {	
				 int res=ddws_Phy_Comp_DAO.editDdwsPhyComp(frm.getDdwsPhyCode(),frm.getDdwsPhyName());
				 if(res>0){
					session.setAttribute("message","Deleted Successfully");
				 }	
			}
		}
		if(mode!=null && mode.equalsIgnoreCase("delete")){
			 int res=ddws_Phy_Comp_DAO.deleteDdwsPhyComp(frm.getDdwsPhyCode(),frm.getDdwsPhyName());
			 if(res>0){
				session.setAttribute("message","Edit Successfully");
			 }
		}
		
		return mapping.findForward(mode);
	}

	private void reset(Rws_Ddws_Phy_Comp_Form frm) {		
		frm.setDdwsPhyCode("");
		frm.setDdwsPhyName("");		
	}
}