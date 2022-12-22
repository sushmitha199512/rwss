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

public class AddRemoveHabs extends Action 
{
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, 
		HttpServletResponse response) throws Exception
	{
		String target = new String("data-success");
		String proposalId = request.getParameter("proposalId");
		ProposalForm myForm = (ProposalForm)form;
		String mode = myForm.getMode();
		HttpSession session = request.getSession();
		RwsLocations rwsLocations = null;
		//System.out.println("The mode in AddRemoveHabs is " + mode);
		if(mode != null)
		{
			ProposalDAO proposalDAO = new ProposalDAO(getDataSource(request));
			if(mode.equals("addRemoveHabs"))
			{
				if(proposalId != null && proposalId.length() >0)
				{
					
					ProposalDTO proposalDTO = proposalDAO.getProposalDetails(proposalId);
					String officeCode = proposalDTO.getOfficeCode();
					if(officeCode == null || officeCode.length() ==0)
					{
						officeCode = request.getParameter("officeCode");
					}
					//System.out.println("officeCode :" + officeCode);
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
					request.setAttribute("from", request.getParameter("from"));
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
		return mapping.findForward(target);
	}
}