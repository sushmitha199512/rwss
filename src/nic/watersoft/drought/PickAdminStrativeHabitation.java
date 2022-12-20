package nic.watersoft.drought;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class PickAdminStrativeHabitation extends Action
{
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
				HttpServletResponse response) throws Exception 
	{
  	    String target = new String("data-success");
	 	String headOfficeCode = request.getParameter("hoc");
		String circleOfficeCode = request.getParameter("coc");
	 	String search = request.getParameter("search");
		String proposalId = request.getParameter("proposalId");
		
		String officeCode = headOfficeCode + circleOfficeCode ;
		boolean flag = true;
		if(request.getParameter("flag")!=null && request.getParameter("flag").equals("false"))flag=false;
		String mode=request.getParameter("mode");
		
		RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
		HttpSession session = request.getSession();
		if(mode!=null&&mode.equals("pickhab"))
		{
	     String editvar=request.getParameter("editvar");
	     session.setAttribute("editvar",editvar);
	  	 String code=request.getParameter("assetcode");
	  	 String habindex=request.getParameter("index");
	  	 session.setAttribute("habindex",habindex);
	  	 session.setAttribute("selectedWorkId",request.getParameter("proposalId"));
	  	 if(!(code.equals("11")||code.equals("12")))
	  	 {
	  	 ArrayList mandals=rwsLocations.getMandals(circleOfficeCode);
	 	 session.setAttribute("mandals", mandals);
	 	 target="Mandal-view";
	 	 String[] mcodes=null;
	 	 DroughtDAO	proposalDAO=new DroughtDAO(getDataSource(request));
	 	 mcodes=proposalDAO.getMandalCodesFormAdmn(proposalId);
	 	 session.setAttribute("H_"+proposalId,mcodes);
	  	 }
	  	 else if(code.equals("11"))
	  	 {
	  	 	ArrayList mandals=rwsLocations.getMandals(circleOfficeCode); 
		 	session.setAttribute("mandals", mandals);
		 	 target="Mandal-school";
		 	String[] mcodes=null;
		 	DroughtDAO	proposalDAO=new DroughtDAO(getDataSource(request));
		 	 mcodes=proposalDAO.getMandalCodesFormAdmn(proposalId);
		 	 session.setAttribute("H_"+proposalId,mcodes);
	  	 }
	  	else if(code.equals("12"))
	  	 {
	  		ArrayList divisions=rwsLocations.getDivisions(circleOfficeCode);
	  		session.setAttribute("divisions", divisions);
		 	target="Mandal-lab";
	  	 }
	  	
	  	
	  	
	  	
	 	 session.setAttribute("proposalId",proposalId);
		}

		if(mode != null && mode.equals("pickSources"))
		{   String ccode=(String)request.getParameter("coc");
			DroughtDAO	proposalDAO=new DroughtDAO(getDataSource(request));
			ArrayList mandalCode = proposalDAO.getMandals(circleOfficeCode);
			int size=mandalCode.size();
	    	session.setAttribute("mandalCode",mandalCode);	
			target = "pickSources";
		}	

		if(mode!=null && mode.equals("getHabss"))
		{
			String[] a = request.getParameterValues("mandalss");
		}
		
	 	else
	 	{
	 		String all=request.getParameter("All");
	 		String[] mcodes=null;
	 		try{
	 		String temp=request.getParameter("selectedMcodes");
	 		 mcodes=temp.split("@");
			 session.setAttribute("H_"+proposalId,mcodes);
	 		}
	 		catch(Exception e)
			{
	 			Debug.println("Exception in PickHabs in Drought");
			}
		 ArrayList habitations = rwsLocations.getAdminStrativeHabitations((String)session.getAttribute("selectedWorkId"), officeCode, search ,mcodes,all);
	 	 session.setAttribute("habitations", habitations);
	 	} 
		
		DroughtDAO proposalDAO = new DroughtDAO(getDataSource(request));
		ArrayList tempSelectedHabs=getSelectedHabs((ArrayList)session.getAttribute("tempSelectedAdmnHabs"),(String)session.getAttribute("selectedWorkId"));
		if(tempSelectedHabs==null)
			tempSelectedHabs=new ArrayList();
	 	request.setAttribute("tempSelectedHabs", tempSelectedHabs); 
	 	
	 	String code = ((String)session.getAttribute("selectedWorkId")).substring(6,8);
	 	String tabName1 = "";
	 	RwsUser user=new RwsUser();
		user=(RwsUser)session.getAttribute("RWS_USER");

	 	if(!(code.equals("11")|| code.equals("12")))
		{
			tabName1 = "tab_"+user.getUserId()+"_temp";
		}
		else if(code.equals("11"))
		{
			tabName1 = "tab_"+user.getUserId()+"_temp_school";
		}
		else if(code.equals("12"))
		{
			tabName1 = "tab_"+user.getUserId()+"_temp_lab";
		}
	 	String[] aa = new String[0];
	 	
	 	
	 	proposalDAO.insertProposalTempHabsForAdmin(proposalId,aa,tabName1,flag);
	 	ArrayList tempSelectedHabs1 = proposalDAO.getTempSelectedHabsForAdminSancEdit(proposalId,tabName1);
			ArrayList selectedHabs = null;
			if(tempSelectedHabs1.size() <= 0)
			{	
				selectedHabs = proposalDAO.getSelectedHabitations(proposalId);
				request.setAttribute("selectedHabs", selectedHabs);
			}
			else
				request.setAttribute("selectedHabs", tempSelectedHabs1);
 	   
	 	
 	    return mapping.findForward(target);
	}
	
	public ArrayList getSelectedHabs(ArrayList selectedHabsForAllWorks,String proposalId)
	{
	
		ArrayList selectedHabs=new ArrayList();
		if(selectedHabsForAllWorks!=null)
		{
			
			for(int i=0;i<selectedHabsForAllWorks.size();i++)
			{
				nic.watersoft.commons.RwsLocationBean rwsLocationBean=(nic.watersoft.commons.RwsLocationBean)selectedHabsForAllWorks.get(i);
				if(rwsLocationBean.getProposalId().equals(proposalId))
					selectedHabs.add(rwsLocationBean);
				
			}
		}
		return selectedHabs;
	}
}
