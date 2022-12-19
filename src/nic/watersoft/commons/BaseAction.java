package nic.watersoft.commons;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public abstract class BaseAction extends Action
{
	private HttpSession session;
	private ArrayList headOffices, circles, divisions, subdivisions;
	private String officeCode, headOfficeCode, circleOfficeCode, divisionOfficeCode, subdivisionOfficeCode; 

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
					HttpServletResponse response) throws Exception
	{
		executeBefore(mapping, form, request, response);

		ActionForward forward = executeAction(mapping, form, request, response);

		executeAfter();
		
		return forward;
	}

	protected abstract ActionForward executeAction(ActionMapping mapping, ActionForm form, 
		HttpServletRequest request, HttpServletResponse response) throws Exception;

	private void executeBefore(ActionMapping mapping, ActionForm form, 
				HttpServletRequest request, HttpServletResponse response) throws Exception
	{

		//System.out.println("in executeBefore");
		session = request.getSession();
		BaseActionForm myForm = (BaseActionForm) form;
		//System.out.println("myForm: " + myForm);
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if(user == null)
			response.sendError(403,"User login required");
		
		//System.out.println("myForm.getInit(): " + myForm.getInit());

		if(!myForm.getInit())
		{
			officeCode = user.getOfficeCode();
			headOfficeCode = user.getHeadOfficeCode();
			circleOfficeCode = user.getCircleOfficeCode();
			divisionOfficeCode = user.getDivisionOfficeCode();
			subdivisionOfficeCode = user.getSubdivisionOfficeCode();

			myForm.setHeadOfficeCode(headOfficeCode);
			myForm.setCircleOfficeCode(circleOfficeCode);
			myForm.setDivisionOfficeCode(divisionOfficeCode);
			myForm.setSubdivisionOfficeCode(subdivisionOfficeCode);

			myForm.setInit(true);
		}
		else
		{
			headOfficeCode = myForm.getHeadOfficeCode();
			circleOfficeCode = myForm.getCircleOfficeCode();
			divisionOfficeCode = myForm.getDivisionOfficeCode();
			subdivisionOfficeCode = myForm.getSubdivisionOfficeCode();
		}
		
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		
		//System.out.println("headOfficeCode is "+headOfficeCode);
		//System.out.println("circleOfficeCode is "+circleOfficeCode);
		//System.out.println("divisionOfficeCode is "+divisionOfficeCode);
		//System.out.println("subdivisionOfficeCode is "+subdivisionOfficeCode);
		if( headOfficeCode != null && (headOfficeCode.equals("0")||headOfficeCode.equals("00")) )
			headOffices = rwsOffices.getHeads();
		
		/*
		if( circleOfficeCode != null && (circleOfficeCode.equals("0")||circleOfficeCode.equals("00")||circleOfficeCode.equals("")) )
			circles = rwsOffices.getCircles(headOfficeCode);

		if( divisionOfficeCode != null && (divisionOfficeCode.equals("0")||divisionOfficeCode.equals("00")||divisionOfficeCode.equals("")) )
			divisions = rwsOffices.getDivisions(headOfficeCode, circleOfficeCode);

		if( subdivisionOfficeCode != null && (subdivisionOfficeCode.equals("0")||subdivisionOfficeCode.equals("00")||subdivisionOfficeCode.equals("")) )
			subdivisions = rwsOffices.getSubdivisions(headOfficeCode,circleOfficeCode,divisionOfficeCode);
		
		*/
		
			circles = rwsOffices.getCircles(headOfficeCode);

			divisions = rwsOffices.getDivisions(headOfficeCode, circleOfficeCode);

			subdivisions = rwsOffices.getSubdivisions(headOfficeCode,circleOfficeCode,divisionOfficeCode);
		
		
		request.setAttribute("headOffices", headOffices);
		request.setAttribute("circles", circles);
		request.setAttribute("divisions", divisions);
		request.setAttribute("subdivisions", subdivisions);
		//System.out.println("end of executeBefore");

	}
	private void executeAfter()
	{
	}
}