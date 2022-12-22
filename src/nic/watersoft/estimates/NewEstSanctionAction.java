package nic.watersoft.estimates;

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

public class NewEstSanctionAction extends Action
{
	private String message;
	boolean isAllowed = true;
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
					HttpServletResponse response) throws Exception 
	{
		String target = new String("success");
				
		EstimateForm myForm = (EstimateForm)form;
		String mode = myForm.getMode();
		//System.out.println("In NewEstSanctionAction ..");
		//System.out.println("The user pressed the " + mode + " button.");
		HttpSession session = request.getSession();

		EstimateDAO estimateDAO = new EstimateDAO(getDataSource(request));
		EstimateDTO estimateDTO = new EstimateDTO();
		BeanUtils.copyProperties(estimateDTO, myForm);

		if(mode != null && mode.equals("Sanction"))
		{	
			String[] workIds = request.getParameterValues("sel");
			//System.out.println("work Id Length="+workIds.length);
			 
			if(workIds != null && workIds.length > 0)
			{
				String tsDate = estimateDTO.getTsEndtDate();
				String datePart = tsDate.substring(0,2);
				String monthPart = tsDate.substring(3,5);
				String yearPart = tsDate.substring(6,10);
				int dd = Integer.parseInt(datePart);
				int mm = Integer.parseInt(monthPart);
				int yy = Integer.parseInt(yearPart);
				GregorianCalendar gCal = new GregorianCalendar(yy,mm-1,dd);
				Date dTsDate = gCal.getTime();
				Date currentDate = new Date();
				if(dTsDate.compareTo(currentDate) > 0)
					isAllowed = false;
				else
					isAllowed = true;
				if(isAllowed)
				{   	//System.out.println("work Id Length="+workIds.length);
					if(estimateDAO.sanction(workIds, estimateDTO))
						message = workIds.length + " estimate(s) sanctioned.";
					else
						message = "Estimate(s) cannot be sanctioned.";
				}
				else
				{
					message = "TS. Date cannot be greater than current date.";
					target = new String("validation-failed");
				}
			}
			else
				message = "Please select atleast one estimate to sanction.";
		}
		else
		if(mode != null && mode.equals("Submit"))
		{	
			String[] workIds = request.getParameterValues("sel");
			
			if(workIds != null && workIds.length > 0)
			{
				String submitDate = estimateDTO.getSubmitDate();
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
					if(estimateDAO.submit(workIds, estimateDTO))
						message = workIds.length + " estimate(s) submitted.";
					else
					{
						int count = estimateDAO.HEAD_OF_OFFICE_COUNT;
						
						if(count != 1)
						{
							message = "Estimate(s) cannot be submitted.\\n";
							message += count + " Head of Office exist.";
						}
						else
						message = "Estimates(s) cannot be submitted.";
					}
				}
				else
				{
					message = "Date cannot be greater than current date.";
					target = new String("validation-failed");
				}
			}
			else
				message = "Please select atleast one estimate to submit.";
		}
		
		
		if(message != null)
		{
			session.setAttribute("GlobalConstants.Message", message);
		}
		return mapping.findForward(target);
	}


	



}

