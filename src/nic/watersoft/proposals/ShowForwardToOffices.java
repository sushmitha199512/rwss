package nic.watersoft.proposals;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletContext;


import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
public class ShowForwardToOffices extends Action
{
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		try{
		Debug.println("in showforwardTooffices class");
		ShowForwardToOfficesForm myForm = (ShowForwardToOfficesForm)form;
		String mode=request.getParameter("mode");
		RwsOffices rwsOffices=new RwsOffices(getDataSource(request));
		//code added
		if (mode != null && mode.equalsIgnoreCase("data")) 
		{
			String officeType=request.getParameter("officeType");
			request.setAttribute("officeType",officeType);
			
			ArrayList forwardToList = (ArrayList) myForm.getProposalForwardToList();
			forwardToList.clear();
			
			ProposalDTO forwardTo = new ProposalDTO();
			forwardTo.setCircle("");
			forwardTo.setDivision("");
			forwardTo.setSubDivision("");
			
			ArrayList comboList=new ArrayList();
			ArrayList circleList=rwsOffices.getCircles("1");
			myForm.setParamList(circleList);
			Debug.println("circle list size is "+circleList.size());
			forwardTo.setCircleList(circleList);
			forwardTo.setDivisionList(comboList);
			forwardTo.setSubDivisionList(comboList);
			forwardToList.add(forwardTo);
			
			myForm.setProposalForwardToList(forwardToList);
			request.setAttribute("display","circles");
		}
		if (mode != null && mode.equalsIgnoreCase("Divisions")) 
		{
			String officeType=request.getParameter("officeType");
			request.setAttribute("officeType",officeType);
			ArrayList forwardToList = (ArrayList) myForm.getProposalForwardToList();
			String selectedCircle=request.getParameter("circle");
			request.setAttribute("circle",selectedCircle);
			myForm.setCircle(selectedCircle);
			//String selectedCircle="01";
			forwardToList.clear();
			
			ProposalDTO forwardTo = new ProposalDTO();
			forwardTo.setCircle("");
			forwardTo.setDivision("");
			forwardTo.setSubDivision("");
			
			ArrayList comboList=new ArrayList();
			myForm.setParamList(rwsOffices.getCircles("1"));
			myForm.setDivisionList(rwsOffices.getDivisions("1",selectedCircle));
			forwardTo.setDivisionList(comboList);
			forwardTo.setSubDivisionList(comboList);
			forwardToList.add(forwardTo);
			
			myForm.setProposalForwardToList(forwardToList);
			request.setAttribute("display","divisions");
		}
		if (mode != null && mode.equalsIgnoreCase("subdivisions")) 
		{
			String officeType=request.getParameter("officeType");
			Debug.println("officeType is "+officeType);
			request.setAttribute("officeType",officeType);
			ArrayList forwardToList = (ArrayList) myForm.getProposalForwardToList();
			String selectedCircle=myForm.getCircle();
			String selectedDivision=request.getParameter("division");
			request.setAttribute("circle",selectedCircle);
			request.setAttribute("division",selectedDivision);
			Debug.println("selected circle in subdivisions is "+selectedCircle);
			Debug.println("selected division in subdivisions is "+selectedDivision);
			
			//String selectedCircle="01";
			//String selectedDivision="01";
			//String selectedDivision=request.getParameter("division");
			
			forwardToList.clear();
			
			ProposalDTO forwardTo = new ProposalDTO();
			
			
			ArrayList comboList=new ArrayList();
			myForm.setParamList(rwsOffices.getCircles("1"));
			myForm.setSubDivisionList(rwsOffices.getSubdivisions("1",selectedCircle,selectedDivision));
			Debug.println("size is "+myForm.getSubDivisionList().size());
			forwardTo.setDivisionList(comboList);
			forwardTo.setSubDivisionList(comboList);
			forwardToList.add(forwardTo);
			
			myForm.setProposalForwardToList(forwardToList);
			request.setAttribute("display","subdivisions");
		}
		
						
				Debug.println("returning to pickpipemat");
				
				
			}catch(Exception e){Debug.println("error in addNewPipeType"+e);}
			
		
		
		//end of code added
		String target = new String("data-success");
		return mapping.findForward(target);
	}
}
