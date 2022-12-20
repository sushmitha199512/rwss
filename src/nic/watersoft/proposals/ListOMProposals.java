package nic.watersoft.proposals;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;


public class ListOMProposals extends Action
{
	public ActionForward execute(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		
		HttpSession session = request.getSession();
		
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
		String officeCode = user.getOfficeCode();
		ProposalDAO proposalDAO = new ProposalDAO(getDataSource(request));
		ArrayList omProposalList = proposalDAO.listOMProposals(officeCode);
		if(omProposalList.size() > 0)
			request.setAttribute("omProposalList", omProposalList);
	
		return mapping.findForward("data-success");
	}
}
