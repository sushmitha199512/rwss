package nic.watersoft.proposals;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class SaveAssetHab extends Action
{
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, 
			HttpServletResponse resposne) throws ServletException
	{
		String target = new String("success");
		String assetCode = request.getParameter("assetCode");
		String[] habCodes = request.getParameterValues("selectedHabCode");
		ProposalDAO proposalDAO = new ProposalDAO(getDataSource(request));
		if(proposalDAO.insertOMProposalTempHabs(assetCode, habCodes))
			request.setAttribute("insert-success", "inserted");
		else
			request.setAttribute("insert-success", "not-inserted");
		return mapping.findForward(target);
	}
}