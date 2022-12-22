package nic.watersoft.proposals;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.GregorianCalendar;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletContext;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;

//import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;

public class NewAdminProposalAction extends Action
{
	private String mode;
	private String message;
	
	ProposalDAO proposalDAO;
	ProposalDTO proposalDTO;
	int count = 0;
	boolean isAllowed = true;
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
				HttpServletResponse response) throws Exception
	{
		String target = new String("success");
		HttpSession session=request.getSession();
		RwsUser rwsUser=new RwsUser();
		rwsUser=(RwsUser)session.getAttribute("RWS_USER");
		boolean passed = true;
		ProposalForm myForm = (ProposalForm)form;
		
		//System.out.println("MyForm in  NewAdminProposalAction " + myForm);
		mode = myForm.getMode();
		proposalDTO = new ProposalDTO();
		BeanUtils.copyProperties(proposalDTO, myForm);
		proposalDAO = new ProposalDAO(getDataSource(request));
		
		//System.out.println("Mode is NewAdminProposalAction: " + mode);
		
		if(mode != null && mode.equals("Save"))
		{
			String adminDate = myForm.getAdminDate();
			String sDate = adminDate.substring(0,2);
			String sMonth = adminDate.substring(3,5);
			String sYear = adminDate.substring(6,10);
			ServletContext servletContext=null;
			int iDate = Integer.parseInt(sDate);
			int iMonth = Integer.parseInt(sMonth);
			int iYear = Integer.parseInt(sYear);
			GregorianCalendar gCal = new GregorianCalendar(iYear, iMonth-1, iDate);
			Date currentDate = new Date();
			
			//System.out.println("in save mode");
			if(gCal.getTime().compareTo(currentDate) > 0)
			{
				message = "Admin. Date cannot be greater than current date.";
				session.setAttribute("GlobalConstants.Message", message);
				passed = false;
				target = "failure";
			}
			boolean filePassed = false;
			if(passed)
			{
				String goNo = myForm.getGoNo();
				InputStream in = null;
				OutputStream out = null;
				try
				{
					FormFile govtOrder = myForm.getGovtOrder();
					
					String fileName = govtOrder.getFileName();
					
					File file = new File(fileName);
					
					if(fileName != null && fileName.length() > 0)
					{
						servletContext=session.getServletContext();
						String path=servletContext.getRealPath("uploads/proposals");
						String fileExtension = fileName.substring(fileName.lastIndexOf("."),fileName.length());
						//String fileLocation = "/apd8/watersoftLatest/app/uploads/proposals/GO_"+goNo+fileExtension;
						String fileLocation = path+"/GO_"+goNo+fileExtension;
						//System.out.println("fileLocation is "+fileLocation);
						in = govtOrder.getInputStream();
						out = new BufferedOutputStream (new FileOutputStream(fileLocation));
						
						byte[] buffer = new byte[512];
						while (in.read(buffer) != -1)
						{
							out.write(buffer);
						}
					}
				}
				catch(Exception e)
				{
					message = "An error occurred while trying to attach the specified file.";
					//System.out.println("exception is:"+e);
					session.setAttribute("GlobalConstants.Message", message);
					//System.out.println(message);
					e.printStackTrace();
					target = "failure";
					passed = false;
				}
				finally
				{	try
					{	if(out != null)
						{	out.close();						
						}
					}
					catch(Exception e){
					}
					try
					{	if(in != null)
						{	in.close();						
						}
					}
					catch(Exception e){
					}
				}
				
				if(passed)
				{
					String[] proposalIds = request.getParameterValues("sel");
					
					String[] sanctionAmounts = null;					
					if(proposalIds != null && proposalIds.length > 0)
					{	
						sanctionAmounts = new String[proposalIds.length];
						for(int i=0; i<proposalIds.length; i++)
						{
							sanctionAmounts[i] = request.getParameter(proposalIds[i]+"_SA");
						}
						if(proposalDAO.sanction(proposalIds, sanctionAmounts, proposalDTO))
							message = proposalIds.length + " proposal(s) sanctioned successfully!";
						else
							message = "Proposal(s) cannot be sanctioned!";
					}
					else
						message = "Please select atleast one proposal to sanction";
				}
			}
		}
		else
		if(mode != null && mode.equals("Forward"))
		{
			//System.out.println("in forward mode");
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
					if(!rwsUser.getOfficeName().equalsIgnoreCase("Head Office"))
					{
						if(proposalDAO.forward(proposalIds, proposalDTO))
							message = proposalIds.length + " proposal(s) forwarded successfully!";
						else
						{
							count = proposalDAO.HEAD_OF_OFFICE_COUNT;
							
							if(count != 1)
							{
								message = "Proposal(s) cannot be forwarded.\\n";
								message += count + " Head of Office exist.";
							}
							else
							message = "Proposal(s) cannot be forwarded!";
						}
					}
					else
					{
						//System.out.println("calling forwardFromHeadOffice()");
						if(proposalDAO.forwardFromHeadOffice(proposalIds, proposalDTO))
							message = proposalIds.length + " proposal(s) forwarded successfully!";
						else
						{
							count = proposalDAO.HEAD_OF_OFFICE_COUNT;
							
							if(count != 1)
							{
								message = "Proposal(s) cannot be forwarded.\\n";
								message += count + " Head of Office exist.";
							}
							else
							message = "Proposal(s) cannot be forwarded!";
						}
					}
				}
				else
					message = "Date cannot be greater than current date.";
			}
			else
				message = "Please select atleast one proposal to forward.";
				
		}
		else
		if(mode != null && mode.equals("Send to Source Investigation"))
		{
			String[] proposalIds = request.getParameterValues("sel");
			if(proposalIds != null && proposalIds.length > 0)
			{
				
				if(proposalDAO.siteIdentification(proposalIds, myForm.getOfficeCode()))
					message = proposalIds.length + " proposal(s) submitted for site identification!";
				else
				{
					//System.out.println("ProposalDAO " + proposalDAO.errorMessage);
					if(proposalDAO.errorMessage.equals(""))
						message = "Proposal(s) cannot be submmitted for site identification!";
					else
						message = proposalDAO.errorMessage;
				}
			}
			else
				message = "Please select atleast one proposal for site identification.";
		}

	if(message != null)
		session.setAttribute("GlobalConstants.Message", message);

	return mapping.findForward(target);
}
}