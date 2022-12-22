package nic.watersoft.masters;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class RwsUiHabActionData extends Action{
	
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)  {
		HttpSession session = request.getSession();
		String storedToken = (String)session.getAttribute("csrfToken");
	    String token = request.getParameter("token");
	    RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}
		String username=user.getUserId();
		String page_to_be_displayed="";
		HabStatusForm habFrm =(HabStatusForm)form;
		String mode = (String) request.getParameter("mode");
		Rws_Habitation_Dyna_DAO dynaDao=new Rws_Habitation_Dyna_DAO();
		ArrayList districts = new ArrayList();
		ArrayList mandals = new ArrayList();		
		ArrayList panchayats=new ArrayList();
		ArrayList villages=new ArrayList();		
		ArrayList uiHabs=new ArrayList();
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		try{			
			if (mode != null && mode.equalsIgnoreCase("data")) {			
				districts=rwsOffices.getDistricts();
				session.setAttribute("dists",districts);			  
				mandals=rwsOffices.getMandals(habFrm.getDcode());
				session.setAttribute("mandals",mandals);
				uiHabs=dynaDao.getUiHabitations(habFrm.getDcode(),habFrm.getMcode());
			    session.setAttribute("uiHabs",uiHabs);
			    page_to_be_displayed="data";
			}
		
			if (mode != null && mode.equalsIgnoreCase("save")) {
				 if (storedToken.equals(token)) {	
					int i=dynaDao.setStatusUItoNC(habFrm.getHabCode());
					if(i==1)
						request.setAttribute("message", "SuccessFully Changed");
					reset(habFrm);
					page_to_be_displayed="data";
				 }
			}
		}catch (Exception e) {
			System.out.println("The Exception is in RwsUiHabActionData  : "+e.getMessage());
		}
		return mapping.findForward(page_to_be_displayed);
	}
	
	public void reset(HabStatusForm myForm)	{
		myForm.setDcode("");
		myForm.setMandal("");	
		myForm.setHabCode("");
	
	}
}
