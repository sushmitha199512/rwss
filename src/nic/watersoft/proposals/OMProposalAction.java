package nic.watersoft.proposals;

import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.BaseAction;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class OMProposalAction extends BaseAction 
{
	private String mode;
	private String[] assetCodes, proposalIds;
	private boolean flag;
	private String message;
	private ProposalDTO proposalDTO;
	private ProposalDAO proposalDAO;
	private ProposalForm myForm;
	int count = 0;	
	boolean isAllowed = true;
	public ActionForward executeAction(ActionMapping mapping, ActionForm form, 
		HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		String target = new String("success");
		
		DataSource dataSource = getDataSource(request);
		HttpSession session = request.getSession();
		myForm = (ProposalForm)form;
		
		if(myForm != null)
		{
			mode = myForm.getMode();
			flag = false;
			proposalDAO = new ProposalDAO(dataSource);
			proposalDTO = new ProposalDTO();
			BeanUtils.copyProperties(proposalDTO, myForm);
			Debug.println("User pressed the : " + mode + " button");
		}
		
		if(mode != null && mode.equals("Save"))
		{
			assetCodes = request.getParameterValues("assetCode");
			for(int i=0;i<assetCodes.length;i++)
				Debug.println("in save, assetcode=:"+assetCodes[i]);
			String[] programmeCodes = request.getParameterValues("programmeCodes");
			
			String subprogrammeCode = null;
			String others = myForm.getOthers();
			String otherCode = "";
			if(programmeCodes!=null && programmeCodes.length > 0)
			{
				for(int i=0; i<programmeCodes.length; i++)
				{
					if(programmeCodes[i].equals("00"))
						otherCode = proposalDAO.insertProgramme(others);
				}
				
				for(int i=0; i<programmeCodes.length; i++)
				{
					subprogrammeCode = request.getParameter("subprogrammeCode_"+programmeCodes[i]);
					if(programmeCodes[i].equals("00"))
						programmeCodes[i] = otherCode;
					
					if(subprogrammeCode!=null && subprogrammeCode.length()>0 && subprogrammeCode!="")
						programmeCodes[i] = programmeCodes[i]+"_"+subprogrammeCode;
				}
			}
			
			if(assetCodes != null && assetCodes.length > 0)
			{
				 if(proposalDAO.omConsider(assetCodes, programmeCodes, proposalDTO))
					message = assetCodes.length + " O&M Proposal(s) saved successfully.";
				 else	
					message = "O&M Proposal(s) cannot be saved.";
			}
			else
				message = "Please select atleast one asset to save.";
		}
		else
		if(mode != null && mode.equals("Submit"))
		{
			proposalIds = request.getParameterValues("sel");
			if(proposalIds != null && proposalIds.length > 0)
			{
				String submitDate = proposalDTO.getSubmitDate();
				if(submitDate != null && submitDate.length() == 10)
				{
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
						if(proposalDAO.omSubmit(proposalIds, proposalDTO))
							message = proposalIds.length + " O&M Proposal(s) submitted successfully.";
						else
						{
							count = proposalDAO.HEAD_OF_OFFICE_COUNT;
							if(count != 1)
							{
								message = "O&M Proposal(s) cannot be submitted.\\n";
								message += count + " Head of Office exist.";
							}
							message = "O&M Proposal(s) cannot be submitted.";
						}
					}
					else
						message = "Date cannot be greater than current date."; 
				}
				else
					message = "Invalid Date.";
			}
			else
				message = "Please select atleast one proposal to submit.";
		}
		else
		if(mode != null && mode.equals("Forward"))
		{
			proposalIds = request.getParameterValues("sel");
			if(proposalIds != null && proposalIds.length > 0)
			{	
				String forwardDate = proposalDTO.getForwardDate();
				if(forwardDate != null && forwardDate.length() == 10)
				{
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
						if(proposalDAO.omForward(proposalIds, proposalDTO))
							message = proposalIds.length + " O&M Proposal(s) forwarded successfully.";
						else
						{
							count = proposalDAO.HEAD_OF_OFFICE_COUNT;
							Debug.println("proposalDAO.HEAD_OF_OFFICE_COUNT : " + proposalDAO.HEAD_OF_OFFICE_COUNT);
							if(count != 1)
							{
								message = "O&M Proposal(s) cannot be submitted.\\n";
								message += count + " Head of Office exist.";
							}
							else
							message = "O&M Proposal(s) cannot be forwarded.";	
						}
					}
					else
						message = "Date cannot be greater than be current date.";
				}
				else
					message = "Invalid Date.";
			}
			else
				message = "Please select atleast one proposal to forward.";
		}
		else
		if(mode != null && mode.equals("Others"))
		{
			String[] proposalIds = request.getParameterValues("sel");
			String actionType = proposalDTO.getActionType();
			String otherType1 = "", otherType2="";
			if(actionType.equals("D"))
			{	otherType1 = "deferred.";
				otherType2 = "defer.";
			}
			else
			if(actionType.equals("T"))
			{	otherType1 = "transmitted.";
				otherType2 = "transmit.";
			}
				
			if(proposalIds != null && proposalIds.length > 0)
			{
				if(proposalDAO.omOthers(proposalIds, proposalDTO))
					message = proposalIds.length + " proposal(s) " + otherType1;
				else
					message = "Proposal(s) cannot be " + otherType1;
			}
			else
				message = "Please select atleast one proposal to " + otherType2;
		}
		else
		if(mode != null && mode.equals("Delete"))	
		{
			
			String[] proposalIds = request.getParameterValues("sel");
			if(proposalIds != null && proposalIds.length > 0)
			{
				if(proposalDAO.omDeleteConsidered(proposalIds))
					message = proposalIds.length + " proposal(s) deleted.";
				else
					message = "Proposal(s) cannot be deleted.";
			}
		}
		else
		if(mode != null && mode.equals("Consider for Sanction"))
		{
			Debug.println("In Consider For Sanction");
			String[] proposalIds = request.getParameterValues("sel");
			if(proposalIds != null && proposalIds.length > 0)
			{
				if(proposalDAO.omConsiderForSanction(proposalIds, proposalDTO))
					message = proposalIds.length + " proposal(s) considered for administrative sanction. ";
				else
					message = "Proposal(s) cannot be considered for administrative sanction.";
			}
			else
				message = "Please select atleast one proposal to consider.";
		}
		
		// @author santosh
		if(mode != null && mode.equals("PreviousDetails"))
		{   
			Debug.println("in PreviousDetails");

			assetCodes = request.getParameterValues("assetCode");
			Debug.println("got assetCodes"+assetCodes);
			for(int i=0;i<assetCodes.length;i++)
				Debug.println(assetCodes[i]);
			RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
			String tempOfficeCode = user.getOfficeCode();
			Debug.println("calling proposalDao");
			
			ArrayList administrativeSanctionedProposals = proposalDAO.getOMProposalsAdministrativeSanctioned(tempOfficeCode,assetCodes);
			Debug.println("called proposalDao");
			if(administrativeSanctionedProposals.size() > 0)
				request.setAttribute("administrativeSanctionedProposals", administrativeSanctionedProposals);
				
			ArrayList assetDetails = proposalDAO.getOMProposalsAssetDetails(tempOfficeCode,assetCodes);
			Debug.println("called proposalDao for assetDetails");
			if(assetDetails.size() > 0)
			{
				request.setAttribute("assetDetails", assetDetails);
				Debug.println("assetDetails.length>0");
			}
			
			
			Debug.println("tempOfficeCode: " + tempOfficeCode);
		
			ArrayList technicallySanctionedProposals = proposalDAO.getOMProposalsTechnicallySanctioned(tempOfficeCode);
			if(technicallySanctionedProposals.size() > 0)
				request.setAttribute("technicallySanctionedProposals", technicallySanctionedProposals);
		
			ArrayList proposalsPendingForAdministrativeSanction = proposalDAO.getOMProposalsPendingForAdministrativeSanction(tempOfficeCode);
			if(proposalsPendingForAdministrativeSanction.size() > 0)
				request.setAttribute("proposalsPendingForAdministrativeSanction", proposalsPendingForAdministrativeSanction);
		
			target="previousDetails";
		}
		
		if(message != null)
			session.setAttribute("GlobalConstants.Message",message);	

		return (mapping.findForward(target));
	}
}