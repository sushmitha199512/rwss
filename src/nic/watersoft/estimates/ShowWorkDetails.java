package nic.watersoft.estimates;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import nic.watersoft.proposals.ProposalDTO;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class ShowWorkDetails extends Action 
{
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String target = null;
		String workId = request.getParameter("workId");
		String type = request.getParameter("type");
		EstimateDAO estimateDAO = new EstimateDAO(getDataSource(request));
		ProposalDTO proposalDTO = null;
		if(type != null)
		{
			if(type.equals("new"))
			{
				proposalDTO = estimateDAO.getWorkDetails(workId);
				target = new String("new-success");
			}
			else
			if(type.equals("om"))
			{
				proposalDTO = estimateDAO.getOMWorkDetails(workId);
				target = new String("om-success");
			}
		}
		
		request.setAttribute("proposalDTO", proposalDTO);
		return mapping.findForward(target);
	}
}
