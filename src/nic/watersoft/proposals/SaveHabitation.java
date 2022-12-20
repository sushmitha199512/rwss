package nic.watersoft.proposals;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import nic.watersoft.commons.Debug;

public class SaveHabitation extends Action{
	
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String target = new String("save-success");
		HttpSession session=request.getSession();
		String[] selectedHabCodes = request.getParameterValues("habCodes");
		String proposalId = request.getParameter("proposalId");		
		ProposalDAO proposalDAO = new ProposalDAO(getDataSource(request));
		proposalDAO.removeHabsFromSession(session,proposalId);
		if(session.getAttribute("operationFrom")==null)	{
			if(proposalDAO.insertProposalTempHabsToSession(session,proposalId, selectedHabCodes))
				request.setAttribute("insert-success", "inserted");
			else
				request.setAttribute("insert-success", "not-inserted");
		}
		else{
			String sessionVar="";
			if(session.getAttribute("operationFrom").equals("representativeProposalForm"))
				sessionVar="tempSelectedRepProposalHabs";
			if(proposalDAO.insertProposalTempHabsToSessionVar(session,proposalId, selectedHabCodes,sessionVar))
				request.setAttribute("insert-success", "inserted");
			else
				request.setAttribute("insert-success", "not-inserted");
			session.removeAttribute("operationFrom");
		}
		return mapping.findForward(target);
	}
}