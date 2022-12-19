package nic.watersoft.proposals;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.RwsLocations;
//import nic.watersoft.commons.Debug;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class PickHabitation extends Action
{
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
				HttpServletResponse response) throws Exception 
	{
		String target = new String("data-success");
		
		String headOfficeCode = request.getParameter("hoc");
		String circleOfficeCode = request.getParameter("coc");
		String divisionOfficeCode = request.getParameter("doc");
		String subdivisionOfficeCode = request.getParameter("soc");
		String search = request.getParameter("search");
		String proposalId = request.getParameter("proposalId");
		String officeCode = headOfficeCode + circleOfficeCode 
						  + divisionOfficeCode + subdivisionOfficeCode;
		
		RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
		ArrayList habitations = rwsLocations.getHabitations(proposalId, officeCode, search);
		HttpSession session = request.getSession();
		session.setAttribute("habitations", habitations);
		
		ProposalDAO proposalDAO = new ProposalDAO(getDataSource(request));
		ArrayList tempSelectedHabs = proposalDAO.getTempSelectedHabs(proposalId);
		request.setAttribute("tempSelectedHabs", tempSelectedHabs);
		//System.out.println("setting operationFrom value "+request.getParameter("operationFrom")+"to session");
		session.setAttribute("operationFrom",request.getParameter("operationFrom"));
		return mapping.findForward(target);
	}
}
