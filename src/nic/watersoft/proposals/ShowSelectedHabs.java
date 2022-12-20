package nic.watersoft.proposals;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class ShowSelectedHabs extends Action 
{
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception 
	{
		String target = new String("data-success");
		String proposalId = request.getParameter("proposalId");
		if( proposalId != null && proposalId.length() > 0)
		{
			ProposalDAO proposalDAO = new ProposalDAO(getDataSource(request)); 
			ArrayList habs = proposalDAO.getSelectedHabitations(proposalId); 
			request.setAttribute("habs", habs);
		}
		return mapping.findForward(target);
	}
}
