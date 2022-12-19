package nic.watersoft.proposals;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import nic.watersoft.commons.CommonLists;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class OMProposalTrackingData extends Action 
{
	private DataSource dataSource;

	public ActionForward execute(ActionMapping mapping, ActionForm form, 
		HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		dataSource = getDataSource(request);
		CommonLists commonLists = new CommonLists(dataSource);
		ProposalDAO proposalDAO = new ProposalDAO(dataSource);
		
		ArrayList financialYears = proposalDAO.getOMProposalYears();
		request.setAttribute("financialYears", financialYears);

		ProposalForm myForm = (ProposalForm)form;
		if(myForm != null)
		{
			String financialYear = myForm.getFinancialYear();
			if(financialYear != null)
			{
				ArrayList proposalIds = commonLists.getOMProposalIds(financialYear);
				if(proposalIds.size() > 0)
				request.setAttribute("proposalIds", proposalIds);
			}
		}		
		return mapping.findForward("success");
	}
}
