package nic.watersoft.proposals;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Date;
import java.util.GregorianCalendar;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.upload.FormFile;

public class OMAdminProposalAction extends Action
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
		HttpSession session = request.getSession();
		boolean passed = true;
		ProposalForm myForm = (ProposalForm)form;
		
		if(form != null)
		{
			mode = myForm.getMode();
			proposalDTO = new ProposalDTO();
			BeanUtils.copyProperties(proposalDTO, myForm);
			proposalDAO = new ProposalDAO(getDataSource(request));
		}
		
		//System.out.println("Mode is OMAdminProposalAction: " + mode);
		
		if(mode != null && mode.equals("Save"))
		{
			String adminDate = myForm.getAdminDate();
			String sDate = adminDate.substring(0,2);
			String sMonth = adminDate.substring(3,5);
			String sYear = adminDate.substring(6,10);
			int iDate = Integer.parseInt(sDate);
			int iMonth = Integer.parseInt(sMonth);
			int iYear = Integer.parseInt(sYear);
			GregorianCalendar gCal = new GregorianCalendar(iYear, iMonth-1, iDate);
			Date currentDate = new Date();
						
			if(gCal.getTime().compareTo(currentDate) > 0)
			{
				message = "Admin. Date cannot be greater than current date.";
				session.setAttribute("GlobalConstants.Message", message);
				passed = false;
				target = "failure";
			}
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
						String fileExtension = fileName.substring(fileName.lastIndexOf("."),fileName.length());
//						///
						ServletContext servletContext=session.getServletContext();
						String path=servletContext.getRealPath("uploads/proposals");
						String fileLocation = path+"/GO_"+goNo+fileExtension;
						//System.out.println("fileLocation is "+fileLocation);
						///
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
						if(proposalDAO.omSanction(proposalIds, sanctionAmounts, proposalDTO))
							message = proposalIds.length + " O&M proposal(s) sanctioned successfully!";
						else
							message = "O&M Proposal(s) cannot be sanctioned!";
					}
					else
						message = "Please select atleast one proposal to sanction";
				}
			}
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
					if(proposalDAO.omForward(proposalIds, proposalDTO))
						message = proposalIds.length + " O&M proposal(s) forwarded successfully!";
					else
					{
						count = proposalDAO.HEAD_OF_OFFICE_COUNT;
						
						if(count != 1)
						{
							message = "O&M proposal(s) cannot be forwarded.\\n";
							message += count + " Head of Office exist.";
						}
						else
						message = "O&M proposal(s) cannot be forwarded!";
					}
				}
				else
					message = "Date cannot be greater than be current date.";
			}
			else
				message = "Please select atleast one proposal to forward.";
		}
		
		if(message != null)
			session.setAttribute("GlobalConstants.Message", message);
		
		return mapping.findForward(target);
	}
}
