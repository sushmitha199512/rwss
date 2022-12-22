package nic.watersoft.estimates;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.ArrayList;

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

public class OMEstSanctionData extends BaseAction
{
	CommonLists commonLists;
	public ActionForward executeAction(ActionMapping mapping, ActionForm form, HttpServletRequest request,
					HttpServletResponse response) throws Exception 
	{
		String target = new String("data-success");
		commonLists = new CommonLists(getDataSource(request));
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
		
		EstimateForm myForm = (EstimateForm)form;
		
		String designation = user.getDesignationName();
		String tsOffice = user.getOfficeName();
		String officeName = user.getOfficeName();
		
		if(designation != null)
			designation = designation.toUpperCase();
		if(tsOffice != null)
			tsOffice = tsOffice.toUpperCase();
		
		myForm.setTsGivenBy(designation);
		myForm.setTsOffice(tsOffice);
				
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		String tempOfficeCode = user.getOfficeCode();
		String higherOfficeCode = RwsOffices.getHigherOfficeCode(tempOfficeCode);
		String higherOfficeName = rwsOffices.getOfficeName(higherOfficeCode, true);
		
		ArrayList ssrYears = commonLists.getFinancialYears(2);
		
		SimpleDateFormat dateFormatter = new SimpleDateFormat("dd/MM/yyyy");
		String currentDate = dateFormatter.format(new Date());
		myForm.setTsEndtDate(currentDate);
		myForm.setSubmitDate(currentDate);
		if(officeName.equalsIgnoreCase("HEAD OFFICE"))
		{				
			myForm.setForwardTo(tempOfficeCode);
			myForm.setActionTo(tempOfficeCode);
			myForm.setForwardOffice("Circles");
		}
		else
		if(officeName.equalsIgnoreCase("CIRCLE OFFICE"))
		{
			myForm.setForwardTo(tempOfficeCode);
			myForm.setActionTo(tempOfficeCode);
			myForm.setForwardOffice("Divisions");
			myForm.setSubmitTo(higherOfficeCode);
			myForm.setSubmitOffice(higherOfficeName);
		}
		else
		if(officeName.equalsIgnoreCase("DIVISION OFFICE"))
		{
			myForm.setForwardTo(tempOfficeCode);
			myForm.setActionTo(tempOfficeCode);
			myForm.setForwardOffice("Sub Divisions");
			myForm.setSubmitTo(higherOfficeCode);
			myForm.setSubmitOffice(higherOfficeName);
		}
		else
		if(officeName.equalsIgnoreCase("SUB DIVISION OFFICE"))
		{	
			myForm.setSubmitTo(higherOfficeCode);
			myForm.setSubmitOffice(higherOfficeName);
		}

		EstimateDAO estimateDAO = new EstimateDAO(getDataSource(request));
		
		ArrayList pendingEstimates = estimateDAO.getOMPendingEstimates(tempOfficeCode);
		if(pendingEstimates.size() > 0)
			request.setAttribute("pendingEstimates", pendingEstimates);

		
		ArrayList submittedEstimates = estimateDAO.getOMSubmittedEstimates(tempOfficeCode);
		if(submittedEstimates.size() > 0)
			request.setAttribute("submittedEstimates", submittedEstimates);
		
		request.setAttribute("ssrYears", ssrYears);
		
		return mapping.findForward(target);
	}
}