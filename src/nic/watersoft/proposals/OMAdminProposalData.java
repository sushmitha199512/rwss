package nic.watersoft.proposals;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class OMAdminProposalData extends Action
{
	ArrayList circles = null;
	ArrayList divisions = null;
	ArrayList subdivisions = null;
	
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
				HttpServletResponse response) throws Exception
	{
		String target = new String("success");
		ProposalForm myForm = (ProposalForm)form;
		String mode = myForm.getMode();
		//System.out.println("Mode in OMAdminProposalData.do is " + mode);
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
				
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
		
		String headOfficeCode = myForm.getHeadOfficeCode();
		String circleOfficeCode = myForm.getCircleOfficeCode();
		String divisionOfficeCode = myForm.getDivisionOfficeCode();
		String subdivisionOfficeCode = myForm.getSubdivisionOfficeCode();
		
		//System.out.println("HOC 1 : " + headOfficeCode);
		//System.out.println("COC 1 : " + circleOfficeCode);
		//System.out.println("DOC 1 : " + divisionOfficeCode);
		//System.out.println("SOC 1 : " + subdivisionOfficeCode);
		
		if(headOfficeCode == null)
			headOfficeCode = user.getHeadOfficeCode();
		if(circleOfficeCode == null)
			circleOfficeCode = user.getCircleOfficeCode();
		if(divisionOfficeCode == null)
			divisionOfficeCode = user.getDivisionOfficeCode();
		if(subdivisionOfficeCode == null)
			subdivisionOfficeCode = user.getSubdivisionOfficeCode();
		
		//System.out.println("HOC 2 : " + headOfficeCode);
		//System.out.println("COC 2 : " + circleOfficeCode);
		//System.out.println("DOC 2 : " + divisionOfficeCode);
		//System.out.println("SOC 2 : " + subdivisionOfficeCode);
		
		if(circleOfficeCode.equals("00"))
			circles = rwsOffices.getCircles(headOfficeCode);
		if(divisionOfficeCode.equals("0"))
			divisions = rwsOffices.getDivisions(headOfficeCode, circleOfficeCode);
		if(subdivisionOfficeCode.equals("00"))
			subdivisions = rwsOffices.getSubdivisions(headOfficeCode, circleOfficeCode, divisionOfficeCode);
		
		String actionFrom = "";
		String actionTo = user.getOfficeCode();
		
		if(mode != null && mode.equals("headoffice"))
		{
			headOfficeCode = myForm.getHeadOfficeCode();
			circles = rwsOffices.getCircles(headOfficeCode);
			myForm.setCircleOfficeCode("00");
			myForm.setDivisionOfficeCode("0");
			myForm.setSubdivisionOfficeCode("00");
			
		}
		if(mode != null && mode.equals("circle"))
		{
			headOfficeCode = myForm.getHeadOfficeCode();
			circleOfficeCode = myForm.getCircleOfficeCode();
			divisions = rwsOffices.getDivisions(headOfficeCode, circleOfficeCode);
			myForm.setDivisionOfficeCode("0");
			myForm.setSubdivisionOfficeCode("00");
			actionFrom = headOfficeCode + circleOfficeCode;
			
		}
		if(mode != null && mode.equals("division"))
		{
			headOfficeCode = myForm.getHeadOfficeCode();
			circleOfficeCode = myForm.getCircleOfficeCode();
			divisionOfficeCode = myForm.getDivisionOfficeCode();
			actionFrom = headOfficeCode + circleOfficeCode + divisionOfficeCode;
			myForm.setSubdivisionOfficeCode("00");
			subdivisions = rwsOffices.getSubdivisions(headOfficeCode, circleOfficeCode, divisionOfficeCode);
		}
		if(mode != null && mode.equals("subdivision"))
		{
			headOfficeCode = myForm.getHeadOfficeCode();
			circleOfficeCode = myForm.getCircleOfficeCode();
			divisionOfficeCode = myForm.getDivisionOfficeCode();
			subdivisionOfficeCode = myForm.getSubdivisionOfficeCode();
			actionFrom = headOfficeCode + circleOfficeCode + divisionOfficeCode;
		}
		
		String officeType = user.getOfficeName();
			
		ProposalDAO proposalDAO = new ProposalDAO(getDataSource(request));
		ArrayList pendingProposals = new ArrayList();	
		ArrayList forwardedProposals = new ArrayList();	
		ArrayList sanctionedProposals = new ArrayList();
		
		if(officeType != null && (officeType.equalsIgnoreCase("Head Office") || officeType.equalsIgnoreCase("GOVT") ))
			pendingProposals = proposalDAO.getOMPendingProposals(actionFrom, actionTo);
		
		if(officeType != null && (officeType.equalsIgnoreCase("Head Office") || officeType.equalsIgnoreCase("GOVT") ))
			sanctionedProposals = proposalDAO.getOMSanctionedProposals(actionTo);

		forwardedProposals = proposalDAO.getOMForwardedProposals(actionTo, "A");

		if(pendingProposals.size() != 0)
			request.setAttribute("pendingProposals", pendingProposals);
		if(forwardedProposals.size() != 0)
			request.setAttribute("forwardedProposals", forwardedProposals);
		if(sanctionedProposals.size() != 0)
			request.setAttribute("sanctionedProposals", sanctionedProposals);
				

		String tempOfficeCode = user.getOfficeCode();
		SimpleDateFormat dateFormatter = new SimpleDateFormat("dd/MM/yyyy");
		String currentDate = dateFormatter.format(new Date());
		myForm.setForwardDate(currentDate);
		myForm.setAdminDate(currentDate);
		
		if(officeType.equalsIgnoreCase("HEAD OFFICE"))
		{				
			myForm.setForwardTo(tempOfficeCode);
			myForm.setActionTo(tempOfficeCode);
			myForm.setForwardOffice("Circle");
		}
		else
		if(officeType.equalsIgnoreCase("CIRCLE OFFICE"))
		{
			myForm.setForwardTo(tempOfficeCode);
			myForm.setActionTo(tempOfficeCode);
			myForm.setForwardOffice("Division");
		}
		else
		if(officeType.equalsIgnoreCase("DIVISION OFFICE"))
		{
			myForm.setForwardTo(tempOfficeCode);
			myForm.setActionTo(tempOfficeCode);
			myForm.setForwardOffice("Sub Division");
		}
		else
		if(officeType.equalsIgnoreCase("SUB DIVISION OFFICE"))
		{	
			
		}
		
		request.setAttribute("circles", circles);
		request.setAttribute("divisions", divisions);
		request.setAttribute("subdivisions", subdivisions);
		
		return mapping.findForward(target);
	}
}
