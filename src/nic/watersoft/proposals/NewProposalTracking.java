package nic.watersoft.proposals;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class NewProposalTracking extends Action 
{
	public ActionForward execute(ActionMapping mapping, ActionForm form, 
		HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		
		String target = new String("success");
		DataSource dataSource = getDataSource(request);
			
		ProposalForm myForm = (ProposalForm) form;
		if(myForm != null)
		{
			ProposalDAO proposalDAO = new ProposalDAO(dataSource);
			String proposalId = myForm.getProposalId();
			ArrayList proposalTracks = proposalDAO.getProposalTracking(proposalId);
			
			ArrayList consideredTracks = (ArrayList)proposalTracks.get(0);
			ArrayList actualTracks = (ArrayList)proposalTracks.get(1);
			ArrayList sanctionedTracks = (ArrayList)proposalTracks.get(2);

			if(consideredTracks.size() == 1)
				request.setAttribute("consideredTracks", consideredTracks);
			if(actualTracks.size() >= 1)
				request.setAttribute("actualTracks", actualTracks);
			if(sanctionedTracks.size() == 1)
				request.setAttribute("sanctionedTracks", sanctionedTracks);
	
		}	
		
		return (mapping.findForward(target));
	}
}