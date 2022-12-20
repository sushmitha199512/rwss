package nic.watersoft.estimates;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.BaseAction;
import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class NewEstSanctionData extends BaseAction
{
	CommonLists commonLists;
	public ActionForward executeAction(ActionMapping mapping, ActionForm form, HttpServletRequest request,
					HttpServletResponse response) throws Exception 
	{
		String target = new String("data-success");
		commonLists = new CommonLists(getDataSource(request));
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
		String designation = user.getDesignationName();
		String tsOffice = user.getOfficeName();
		String assetType = "00";
		String workId = null;
		
		if(designation != null)
			designation = designation.toUpperCase();
		
		if(tsOffice != null)
			tsOffice = tsOffice.toUpperCase();
		
		EstimateForm myForm = (EstimateForm)form;

		if(myForm != null)
		{
			
			myForm.setTsGivenBy(designation);
			myForm.setTsOffice(tsOffice.toUpperCase());
		}
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		String tempOfficeCode = user.getOfficeCode();
		//System.out.println("tempOfficeCode: " + tempOfficeCode);
		String higherOfficeCode = RwsOffices.getHigherOfficeCode(tempOfficeCode);
		String higherOfficeName = rwsOffices.getOfficeName(higherOfficeCode, true);
			
		SimpleDateFormat dateFormatter = new SimpleDateFormat("dd/MM/yyyy");
		String currentDate = dateFormatter.format(new Date());
		myForm.setTsEndtDate(currentDate);
		myForm.setSubmitDate(currentDate);
				
		ArrayList ssrYears = commonLists.getFinancialYears(2);
		
		if(user.getOfficeName().equalsIgnoreCase("HEAD OFFICE"))
		{				
			myForm.setForwardTo(tempOfficeCode);
			myForm.setActionTo(tempOfficeCode);
			myForm.setForwardOffice("Circles");
		}
		else
		if(user.getOfficeName().equalsIgnoreCase("CIRCLE OFFICE"))
		{
			myForm.setForwardTo(tempOfficeCode);
			myForm.setActionTo(tempOfficeCode);
			myForm.setForwardOffice("Divisions");
			myForm.setSubmitTo(higherOfficeCode);
			myForm.setSubmitOffice(higherOfficeName);
		}
		else
		if(user.getOfficeName().equalsIgnoreCase("DIVISION OFFICE"))
		{
			myForm.setForwardTo(tempOfficeCode);
			myForm.setActionTo(tempOfficeCode);
			myForm.setForwardOffice("Sub Divisions");
			myForm.setSubmitTo(higherOfficeCode);
			myForm.setSubmitOffice(higherOfficeName);
		}
		else
		if(user.getOfficeName().equalsIgnoreCase("SUB DIVISION OFFICE"))
		{	
			myForm.setSubmitTo(higherOfficeCode);
			myForm.setSubmitOffice(higherOfficeName);
		}

		EstimateDAO estimateDAO = new EstimateDAO(getDataSource(request));

		
		
		ArrayList pendingEstimates = estimateDAO.getPendingEstimates(tempOfficeCode);
		if(pendingEstimates.size() > 0)
			request.setAttribute("pendingEstimates", pendingEstimates);

		
		ArrayList submittedEstimates = estimateDAO.getSubmittedEstimates(tempOfficeCode);
		if(submittedEstimates.size() > 0)
			request.setAttribute("submittedEstimates", submittedEstimates);
		
		request.setAttribute("ssrYears", ssrYears);		
		return mapping.findForward(target);
	}
}