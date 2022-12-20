package nic.watersoft.proposals;

import java.text.*;
import java.util.*;

import javax.sql.*;

import nic.watersoft.commons.CommonLists;
//import nic.watersoft.commons.Debug;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class Rws_work_wise_rpt_act extends Action 
{
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{ 
	
		RepresentativeProposalForm myForm = (RepresentativeProposalForm)form;
		String mode=myForm.getMode();
		Debug.println("in RWS_WORK_WISE_RPT_ACT");
		HttpSession session = request.getSession();
		DataSource dataSource = getDataSource(request);
		String page_to_be_forwarded="";
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
		RwsOffices rwsOffices = new RwsOffices(dataSource);
		CommonLists commonLists = new CommonLists(dataSource);
		
		String headOfficeCode = myForm.getHeadOfficeCode();
		String circleOfficeCode = myForm.getCircleOfficeCode();
		String divisionOfficeCode = myForm.getDivisionOfficeCode();
		String subdivisionOfficeCode = myForm.getSubdivisionOfficeCode();
		
		String programmeCode = myForm.getPrograms();
		String subProgCode=myForm.getSubPrograms();
		String typeOfAsset=myForm.getTypeOfAsset();
		 
		ArrayList workIds=null;
		ArrayList circles=null;
		ArrayList programmes=null;
	 	ArrayList assetTypes=null;
	 	ArrayList workcategories=null;
	 	
		if(headOfficeCode == null)
			headOfficeCode = user.getHeadOfficeCode();
		if(circleOfficeCode == null)
			circleOfficeCode = user.getCircleOfficeCode();
		if(divisionOfficeCode == null)
			divisionOfficeCode = user.getDivisionOfficeCode();
		if(subdivisionOfficeCode == null)
			subdivisionOfficeCode = user.getSubdivisionOfficeCode();
		ArrayList subprogrammes = new ArrayList(1);
		if(mode.equalsIgnoreCase("circles"))
		{
			Debug.println("GETTING CIRCLES");
			circles = rwsOffices.getCircles(headOfficeCode);
			session.setAttribute("circles",circles);
			session.removeAttribute("workCats");
			session.removeAttribute("assetTypes");
			session.removeAttribute("programmes");
			session.removeAttribute("SubPrograms");
			session.removeAttribute("WorkIds");
			page_to_be_forwarded="success";
			
		}
		if(mode.equalsIgnoreCase("workcategories"))
		{
			Debug.println("GETTING WORKCATEGORIES");
			workcategories=rwsOffices.getWorkCategory();
			session.setAttribute("workCats",workcategories);
			session.removeAttribute("assetTypes");
			session.removeAttribute("programmes");
			session.removeAttribute("SubPrograms");
			session.removeAttribute("WorkIds");
			page_to_be_forwarded="success";
		}
		if(mode.equalsIgnoreCase("scheme"))
		{
			Debug.println("GETTING SCHEMES");
			assetTypes = commonLists.getAssetTypes(myForm.getWorkCat(),myForm.getPlan());
			session.setAttribute("assetTypes",assetTypes);
			session.removeAttribute("programmes");
			session.removeAttribute("SubPrograms");
			session.removeAttribute("WorkIds");
			page_to_be_forwarded="success";
		}    
		if(mode.equalsIgnoreCase("programmes"))  
		{
			Debug.println("GETTING PROGRAMS");
    		programmes = commonLists.getProgrammes(myForm.getPlan(),myForm.getWrktype(),myForm.getWorkCat());
			session.setAttribute("programmes",programmes);
			session.removeAttribute("SubPrograms");
			session.removeAttribute("WorkIds");
			page_to_be_forwarded="success";
		}
		
		if(mode.equalsIgnoreCase("subprogrammes"))
		{
			session.removeAttribute("SubPrograms");
			Debug.println("GETTING SUBPROGRAMMES");
			subprogrammes = commonLists.getSubprogrammes(programmeCode);
			Debug.println("NO. OF SUBPROGRAMMES RETURNED"+subprogrammes.size());
			session.setAttribute("SubPrograms",subprogrammes);	
			session.removeAttribute("WorkIds");
			page_to_be_forwarded="success";
			mode="works";
		}
		if(mode.equalsIgnoreCase("works"))
		{
			Debug.println("GETTING WORKS");
			session.removeAttribute("WorkIds");
			ProposalDAO proposalDAO = new ProposalDAO(dataSource);
			workIds=proposalDAO.getWorkIds(circleOfficeCode, programmeCode,subProgCode,typeOfAsset,myForm.getWorkCat(),myForm.getPlan(),myForm.getWrktype());
			if(workIds.size()!=0)
			{
				session.setAttribute("WorkIds",workIds);
			}
			page_to_be_forwarded="success";
		}
		
		if(mode.equals("rpt"))
		{
			Debug.println("IN REPORT MODE");
			ProposalDAO proposalDAO = new ProposalDAO(dataSource);
			ArrayList workWiseList=proposalDAO.getWorkWiseList(myForm.getWorkId());
			request.setAttribute("workwiserpt",workWiseList);
			page_to_be_forwarded="rpt";
		}
		return mapping.findForward(page_to_be_forwarded);
	}
}
