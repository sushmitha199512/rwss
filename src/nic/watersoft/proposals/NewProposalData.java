package nic.watersoft.proposals;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.BaseAction;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class NewProposalData extends BaseAction 
{
	public ActionForward executeAction(ActionMapping mapping, ActionForm form, HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, Exception
	{
		String target = new String("data-success");
		
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
		ProposalDAO proposalDAO = new ProposalDAO(getDataSource(request));
		
		String officeCode = user.getOfficeCode();
		String officeType = user.getOfficeName();		
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		
		ProposalForm myForm = (ProposalForm) form;
		String higherOfficeCode = RwsOffices.getHigherOfficeCode(officeCode);
		//System.out.println("higherOfficeCode in NewProposalData : " + higherOfficeCode);
		String higherOfficeName = rwsOffices.getOfficeName(higherOfficeCode, true);
		
		SimpleDateFormat dateFormatter = new SimpleDateFormat("dd/MM/yyyy");
		String currentDate = dateFormatter.format(new Date());
		myForm.setForwardDate(currentDate);
		myForm.setSubmitDate(currentDate);
		
		// if the user is head office user	
		if(officeType.equalsIgnoreCase("HEAD OFFICE"))
		{
			myForm.setForwardTo(officeCode);
			myForm.setForwardOffice("Circle");
			myForm.setActionTo(officeCode);
		}
		else
		// if the user is circle office user
		if(officeType.equalsIgnoreCase("CIRCLE OFFICE"))
		{
			myForm.setSubmitTo(higherOfficeCode);
			myForm.setSubmitOffice(higherOfficeName);
			myForm.setForwardTo(officeCode);
			myForm.setForwardOffice("Division");
			myForm.setActionTo(officeCode);
		}
		else
		// if the user is division office user
		if(officeType.equalsIgnoreCase("DIVISION OFFICE"))
		{
			myForm.setSubmitTo(higherOfficeCode);
			myForm.setSubmitOffice(higherOfficeName);
			myForm.setForwardTo(officeCode);
			myForm.setForwardOffice("Sub Division");
			myForm.setActionTo(officeCode);
		}
		else
		if(officeType.equalsIgnoreCase("SUB DIVISION OFFICE"))
		{
			myForm.setSubmitTo(higherOfficeCode);
			myForm.setSubmitOffice(higherOfficeName);
		}
		
		
		ArrayList representativeProposals = proposalDAO.getRepresentativeProposals(officeCode);
		ArrayList consideredProposals = proposalDAO.getConsideredProposals(officeCode);
		ArrayList forwardedProposals = proposalDAO.getForwardedProposals(officeCode,"C");
		ArrayList submittedProposals = proposalDAO.getSubmittedProposals(officeCode,"C");
		ArrayList submittedProposalsForCircleOfficeSanction = proposalDAO.getSubmittedProposalsForCircleOfficeSanction(officeCode,"C");
				
		if(representativeProposals.size() > 0)
			request.setAttribute("representativeProposals", representativeProposals);
		
		if(consideredProposals.size() > 0)
			request.setAttribute("consideredProposals", consideredProposals);
		
		//if(consideredProposalsForSanction.size() > 0)
			//request.setAttribute("consideredProposalsForSanction", consideredProposalsForSanction);

		if(forwardedProposals.size() > 0)
			request.setAttribute("forwardedProposals", forwardedProposals);

		if(submittedProposals.size() > 0)
			request.setAttribute("submittedProposals", submittedProposals);
		
		if(submittedProposalsForCircleOfficeSanction.size() > 0)
			request.setAttribute("submittedProposalsForCircleOfficeSanction", submittedProposalsForCircleOfficeSanction);
			
		return (mapping.findForward(target));
	}
}