package nic.watersoft.proposals;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class ShowFunctionalHabs extends Action
{
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
				HttpServletResponse response) throws Exception 
	{
		String target = new String("data-success");
		String assetCode = request.getParameter("assetCode");
		ProposalDAO proposalDAO = new ProposalDAO(getDataSource(request));
					
		ArrayList functionalHabs = proposalDAO.showFunctionalHabs(assetCode);
		request.setAttribute("functionalHabs", functionalHabs);
				
		return mapping.findForward(target);
	}
}
