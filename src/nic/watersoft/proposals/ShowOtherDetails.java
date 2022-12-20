package nic.watersoft.proposals;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class ShowOtherDetails extends Action 
{
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception 
	{
		String target = new String("data-success");
		String proposalId = request.getParameter("proposalId");
		if( proposalId != null && proposalId.length() > 0)
		{
			ProposalDAO proposalDAO = new ProposalDAO(getDataSource(request)); 
			ProposalDTO proposalDTO = proposalDAO.getOtherDetails(proposalId); 
			request.setAttribute("proposalDTO", proposalDTO);
		}
		return mapping.findForward(target);
	}
}
