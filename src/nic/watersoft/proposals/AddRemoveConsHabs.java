
package nic.watersoft.proposals;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;


public class AddRemoveConsHabs extends Action
{
	
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, 
			HttpServletResponse response) throws Exception
	{
		String target = new String("data-success");
		String mode = request.getParameter("mode");
		String proposalId = request.getParameter("proposalId");
		String from = request.getParameter("from");
		//System.out.println("In AddRemoveConsHabs " + mode + "" + from + "" + proposalId);
		if(mode != null)
		{
			ProposalDAO proposalDAO = new ProposalDAO(getDataSource(request));
			RwsLocations rwsLocations = null;
			HttpSession session = request.getSession();
			
			if(mode.equals("addRemoveHabs"))
			{
				if(proposalId != null && proposalId.length() >0)
				{
					ProposalDTO proposalDTO = proposalDAO.getProposalDetails(proposalId);
					String officeCode = proposalDTO.getOfficeCode();
					if(officeCode == null || officeCode.length() == 0)
					{
						officeCode = request.getParameter("officeCode");
					}
					rwsLocations = new RwsLocations(getDataSource(request));
					
					ArrayList habs = rwsLocations.getHabitations(proposalId, officeCode,null);
					ArrayList tempSelectedHabs = proposalDAO.getTempSelectedHabs(proposalId);
					ArrayList selectedHabs = null;
					if(tempSelectedHabs.size() <= 0)
					{	
						selectedHabs = proposalDAO.getSelectedHabitations(proposalId);
						request.setAttribute("selectedHabs", selectedHabs);
					}
					else
						request.setAttribute("selectedHabs", tempSelectedHabs);
					
					session.setAttribute("newhabitations", habs);
					
					request.setAttribute("proposalId", proposalId);
					request.setAttribute("from", from);
				}
			}
			else
			if(mode.equals("Save"))
			{
				proposalId = request.getParameter("proposalId");
				String[] selectedHabs = request.getParameterValues("habCodes");
				if(proposalDAO.insertProposalTempHabs(proposalId, selectedHabs))
					request.setAttribute("insert-success", "inserted");
				else
					request.setAttribute("insert-success", "not-inserted");
				
				request.setAttribute("from", request.getParameter("from"));
				
				target = new String("save-success");
					
				request.setAttribute("proposalId", proposalId);
			}
		}
		else
			target = new String("unknown-url");
			
		return mapping.findForward(target);
	}
}
