/*
 * Created on Feb 17, 2006
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.proposals;


import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class ShowSanctionDetails extends Action 
{
	
	public ActionForward execute(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String target = new String("data-success");
		
		String type = request.getParameter("type");
		String proposalId = request.getParameter("proposalId");
		ProposalDAO proposalDAO = new ProposalDAO(getDataSource(request));
		
		ProposalDTO proposalDTO = proposalDAO.getSanctionDetails(proposalId, type);
		ArrayList selectedHabitations = null;
		if(type!=null && type.equals("new"))
		{
			selectedHabitations = proposalDAO.getSelectedHabitations(proposalId);
			request.setAttribute("selectedHabitationss", selectedHabitations);
			
			
		}
		
		request.setAttribute("type", type);
		request.setAttribute("proposalDTO", proposalDTO);
		return mapping.findForward(target);
	}
}
