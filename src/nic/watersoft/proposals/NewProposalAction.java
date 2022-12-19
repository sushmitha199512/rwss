package nic.watersoft.proposals;

import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class NewProposalAction extends Action
{
	private String message;
	private ProposalDAO proposalDAO;
	private ProposalDTO proposalDTO;
	int count = 0;
	boolean isAllowed = true;
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, 
		HttpServletResponse response) throws Exception
	{
		
		String target = new String("success");
		ProposalForm myForm = (ProposalForm) form;
		String mode = myForm.getMode();
		HttpSession session = request.getSession();
				
		proposalDTO = new ProposalDTO();
		BeanUtils.copyProperties(proposalDTO, myForm);
		proposalDAO = new ProposalDAO(getDataSource(request));
		
		if(mode != null && mode.equals("Consider"))
		{
			String[] proposalIds = request.getParameterValues("sel");
			//System.out.println("proposalIds: " + proposalIds);
			if(proposalIds != null && proposalIds.length > 0)
			{
				if(proposalDAO.consider(proposalIds, proposalDTO))
					message = proposalIds.length + " proposal(s) considered. ";
				else
					message = "Proposal(s) cannot be considered.";
			}
			else
				message = "Please select atleast at one proposal to consider.";
		}
		else
		if(mode != null && mode.equals("Submit"))
		{
			//System.out.println("In Submit");
					 
			String[] proposalIds = request.getParameterValues("sel");
			
			if(proposalIds != null && proposalIds.length > 0)
			{
				String submitDate = proposalDTO.getSubmitDate();
				String datePart = submitDate.substring(0,2);
				String monthPart = submitDate.substring(3,5);
				String yearPart = submitDate.substring(6,10);
				int dd = Integer.parseInt(datePart);
				int mm = Integer.parseInt(monthPart);
				int yy = Integer.parseInt(yearPart);
				GregorianCalendar gCal = new GregorianCalendar(yy,mm-1,dd);
				Date dSubmitDate = gCal.getTime();
				Date currentDate = new Date();
				if(dSubmitDate.compareTo(currentDate) > 0)
					isAllowed = false;
				else
					isAllowed = true;
				
				if(isAllowed)
				{
					if(proposalDAO.submit(proposalIds, proposalDTO))
						message = proposalIds.length + " proposal(s) submitted. ";
					else
					{
						count = proposalDAO.HEAD_OF_OFFICE_COUNT;
						
						if(count != 1)
						{
							message = "Proposal(s) cannot be submitted.\\n";
							message += count + " Head of Office exist.";
						}
						else
						message = "Proposal(s) cannot be submitted.";
					}
				}
				else
					message = "Date cannot be greater than current date.";
			}
			else
				message = "Please select atleast one proposal to submit.";
		}
		else
		if(mode != null && mode.equals("Forward"))
		{
			String[] proposalIds = request.getParameterValues("sel");
			if(proposalIds != null && proposalIds.length > 0)
			{
				String forwardDate = proposalDTO.getForwardDate();
				String datePart = forwardDate.substring(0,2);
				String monthPart = forwardDate.substring(3,5);
				String yearPart = forwardDate.substring(6,10);
				int dd = Integer.parseInt(datePart);
				int mm = Integer.parseInt(monthPart);
				int yy = Integer.parseInt(yearPart);
				GregorianCalendar gCal = new GregorianCalendar(yy,mm-1,dd);
				Date dForwardDate = gCal.getTime();
				Date currentDate = new Date();
				if(dForwardDate.compareTo(currentDate) > 0)
					isAllowed = false;
				else
					isAllowed = true;
				if(isAllowed)
				{
					if(proposalDAO.forward(proposalIds, proposalDTO))
						message = proposalIds.length + " proposal(s) forwarded. ";
					else
					{
						count = proposalDAO.HEAD_OF_OFFICE_COUNT;
						if(count != 1)
						{
							message = "Proposal(s) cannot be forwarded.\\n ";
							message += count + " Head of Office exist.";
						}
						else
						message = "Proposal(s) cannot be forwarded.";
					}
				}
				else
					message = "Date cannot be greater than current date.";
			}
			else
				message = "Please select atleast one proposal to forward.";
		}
		else
		if(mode != null && mode.equals("Others"))
		{
			String[] proposalIds = request.getParameterValues("sel");
			if(proposalIds != null && proposalIds.length > 0)
			{
				if(proposalDAO.others(proposalIds, proposalDTO))
					message = proposalIds.length + " proposal(s) deferred. ";
				else
				{
					count = proposalDAO.HEAD_OF_OFFICE_COUNT;
					if(count != 1)
					{
						message = "Proposal(s) cannot be deferred.\\n ";
						message += count + " Head of Office exist.";
					}
					else
					message = "Proposal(s) cannot be forwarded.";
				}
			}
			else
				message = "Please select atleast one proposal to forward.";
		}
		else
		if(mode != null && mode.equals("Consider for Sanction"))
		{
			String[] proposalIds = request.getParameterValues("sel");
			if(proposalIds != null && proposalIds.length > 0)
			{
				if(proposalDAO.considerForSanction(proposalIds, proposalDTO))
					message = proposalIds.length + " proposal(s) considered for administrative sanction. ";
				else
				{
					count = proposalDAO.HEAD_OF_OFFICE_COUNT;
					if(count != 1)
					{
						message = "Proposal(s) cannot be considered for administrative sanction.\\n ";
						message += count + " Head of Office exist.";
					}
					else
					message = "Proposal(s) cannot be considered for administrative sanction.";
				}
			}
			else
				message = "Please select atleast one proposal to consider.";
		}
		else
			if(mode != null && mode.equals("Existing"))
			{
				ArrayList works=new ArrayList();
				String officeCode=request.getParameter("officeCode");
				session.setAttribute("repWorks",proposalDAO.getExistingWorks(officeCode,1));
				session.setAttribute("adminSanctionWorks",proposalDAO.getExistingWorks(officeCode,2));
				session.setAttribute("techSanctionWorks",proposalDAO.getExistingWorks(officeCode,3));
				works=proposalDAO.getExistingWorks(officeCode,4);
				request.setAttribute("dataSource",getDataSource(request));
				if(works.size()>0)
				  session.setAttribute("completedWorks",works);
				else
					session.removeAttribute("completedWorks");
				target="existing";
			}
			
			if(mode != null && mode.equals("sources"))
			{
				ArrayList works=new ArrayList();
				String officeCode=request.getParameter("officeCode");
				works=proposalDAO.getExistingSources(officeCode);
				if(works.size()>0)
					session.setAttribute("existingSources",works);
				else
					session.removeAttribute("existingSources");
				target="sources";
			}

		if(message != null)
			session.setAttribute("GlobalConstants.Message", message);
		return mapping.findForward(target);
	}
}