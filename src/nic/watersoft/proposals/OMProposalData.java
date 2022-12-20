package nic.watersoft.proposals;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.CommonLists;
//import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class OMProposalData extends Action 
{
	ArrayList circles = null;
	ArrayList divisions = null;
	ArrayList subdivisions = null;
	ArrayList assets = null;
	
	public ActionForward execute(ActionMapping mapping, ActionForm form, 
		HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		
		String target = new String("success");
		
		DataSource dataSource = getDataSource(request);
			
		ProposalForm myForm = (ProposalForm) form;
		String mode = myForm.getMode();
		ProposalDAO proposalDAO = new ProposalDAO(dataSource);
		CommonLists commonLists = new CommonLists(dataSource);
		RwsOffices rwsOffices = new RwsOffices(dataSource);

		HttpSession session = request.getSession();
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
				
		String headOfficeCode = myForm.getHeadOfficeCode();
		String circleOfficeCode = myForm.getCircleOfficeCode();
		String divisionOfficeCode = myForm.getDivisionOfficeCode();
		String subdivisionOfficeCode = myForm.getSubdivisionOfficeCode();
		
		if(headOfficeCode == null)
			headOfficeCode = user.getHeadOfficeCode();
		if(circleOfficeCode == null)
			circleOfficeCode = user.getCircleOfficeCode();
		if(divisionOfficeCode == null)
			divisionOfficeCode = user.getDivisionOfficeCode();
		if(subdivisionOfficeCode == null)
			subdivisionOfficeCode = user.getSubdivisionOfficeCode();
		
		if(circleOfficeCode.equals("00"))
			circles = rwsOffices.getCircles(headOfficeCode);
		if(divisionOfficeCode.equals("0"))
			divisions = rwsOffices.getDivisions(headOfficeCode, circleOfficeCode);
		if(subdivisionOfficeCode.equals("00"))
			subdivisions = rwsOffices.getSubdivisions(headOfficeCode, circleOfficeCode, divisionOfficeCode);
		
		String officeCode = headOfficeCode + circleOfficeCode + divisionOfficeCode
										   + subdivisionOfficeCode;
			
		boolean init = myForm.getInit();
		//System.out.println("Init in OMProposalData is " + init);
		
		if(!init)
		{
			myForm.setInit(true);
			proposalDAO.deleteOMTempProposalHabs();
		}
		
				
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
						
		}
		if(mode != null && mode.equals("division"))
		{
			headOfficeCode = myForm.getHeadOfficeCode();
			circleOfficeCode = myForm.getCircleOfficeCode();
			divisionOfficeCode = myForm.getDivisionOfficeCode();
			myForm.setSubdivisionOfficeCode("00");
			subdivisions = rwsOffices.getSubdivisions(headOfficeCode, circleOfficeCode, divisionOfficeCode);
		}
		if(mode != null && mode.equals("subdivision"))
		{
			headOfficeCode = myForm.getHeadOfficeCode();
			circleOfficeCode = myForm.getCircleOfficeCode();
			divisionOfficeCode = myForm.getDivisionOfficeCode();
			subdivisionOfficeCode = myForm.getSubdivisionOfficeCode();
		}
				
		assets = proposalDAO.getAssets(circleOfficeCode, divisionOfficeCode, subdivisionOfficeCode);

		ArrayList financialYears = commonLists.getFinancialYears(2);

		ArrayList programmeSubProgrammes = null;
		String programmeCode = myForm.getProgrammeCode();
		programmeSubProgrammes = commonLists.getAllProgrammesSubProgrammes();
				
		if(assets.size() > 0)
			request.setAttribute("assets", assets);
		
		String tempOfficeCode = user.getOfficeCode();

		ArrayList consideredProposals = proposalDAO.getOMConsideredProposals(tempOfficeCode);
		if(consideredProposals.size() > 0)
			request.setAttribute("consideredProposals", consideredProposals);
				
		//System.out.println("tempOfficeCode: " + tempOfficeCode);
		
		ArrayList submittedProposals = proposalDAO.getOMSubmittedProposals(tempOfficeCode, "C");
		if(submittedProposals.size() > 0)
			request.setAttribute("submittedProposals", submittedProposals);
		
		ArrayList forwardedProposals = proposalDAO.getOMForwardedProposals(tempOfficeCode, "C");
		if(forwardedProposals.size() > 0)
			request.setAttribute("forwardedProposals", forwardedProposals);
		
		String higherOfficeCode = RwsOffices.getHigherOfficeCode(tempOfficeCode);
		String higherOfficeName = rwsOffices.getOfficeName(higherOfficeCode, true);
		
		SimpleDateFormat dateFormatter = new SimpleDateFormat("dd/MM/yyyy");
		String currentDate = dateFormatter.format(new Date());
		myForm.setSubmitDate(currentDate);
		myForm.setForwardDate(currentDate);
		
		String officeName = user.getOfficeName();
		
		if(officeName.equalsIgnoreCase("HEAD OFFICE"))
		{				
			myForm.setForwardTo(tempOfficeCode);
			myForm.setActionTo(tempOfficeCode);
			
			myForm.setForwardOffice("Circle");
		}
		else
		if(officeName.equalsIgnoreCase("CIRCLE OFFICE"))
		{
			myForm.setForwardTo(tempOfficeCode);
			myForm.setActionTo(tempOfficeCode);
			myForm.setForwardOffice("Division");
			myForm.setSubmitTo(higherOfficeCode);
			myForm.setSubmitOffice(higherOfficeName);
		}
		else
		if(officeName.equalsIgnoreCase("DIVISION OFFICE"))
		{
			myForm.setForwardTo(tempOfficeCode);
			myForm.setActionTo(tempOfficeCode);
			myForm.setForwardOffice("Sub Division");
			myForm.setSubmitTo(higherOfficeCode);
			myForm.setSubmitOffice(higherOfficeName);
		}
		else
		if(officeName.equalsIgnoreCase("SUB DIVISION OFFICE"))
		{	
			myForm.setSubmitTo(higherOfficeCode);
			myForm.setSubmitOffice(higherOfficeName);
		}
				
		request.setAttribute("financialYears",financialYears);
		request.setAttribute("programmeSubProgrammes",programmeSubProgrammes);
		request.setAttribute("circles", circles);
		request.setAttribute("divisions", divisions);
		request.setAttribute("subdivisions", subdivisions);
		
		return (mapping.findForward(target));
	}
}