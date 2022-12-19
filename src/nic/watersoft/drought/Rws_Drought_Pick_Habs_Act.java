/*
 * Created on May 18, 2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.drought;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.drought.DroughtDAO;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * @author admin
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class Rws_Drought_Pick_Habs_Act extends Action
{
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception 
{
	Debug.println("in PickAdminStrativeHabitation Action class");
	String target = new String("data-success");
 	String headOfficeCode = request.getParameter("hoc");
	String circleOfficeCode = request.getParameter("coc");
 	String search = request.getParameter("search");
	//System.out.println("in pick habs: "+search);
	String proposalId = request.getParameter("proposalId");
	String officeCode = headOfficeCode + circleOfficeCode ;
//	added by 
	boolean flag = true;
	if(request.getParameter("flag")!=null && request.getParameter("flag").equals("false"))flag=false;
	//
	String mode=request.getParameter("mode");
	
	//System.out.println("MODE VALUE IS---------->"+request.getParameter("mode"));
	RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
	HttpSession session = request.getSession();
//	updated by  on 05-05-2011 for displaying labs
	if(mode!=null&&mode.equals("pickhab"))
	{
		//boolean flag= false;
  	 String code=request.getParameter("assetcode");
     Debug.println("scheme code::::::::"+code);
  	 session.setAttribute("selectedWorkId",request.getParameter("proposalId"));
  	 if(!(code.equals("11")||code.equals("12")))
  	 {
  	 ArrayList mandals=rwsLocations.getMandals(circleOfficeCode);
 	 session.setAttribute("mandals", mandals);
 	 System.out.println("mandals:"+mandals.size());
 	 target="Mandal-view";
 	 String[] mcodes=null;
 	 DroughtDAO	proposalDAO=new DroughtDAO(getDataSource(request));
 	 mcodes=proposalDAO.getMandalCodesFormAdmn(proposalId);
 	 session.setAttribute("H_"+proposalId,mcodes);
  	 }
  	 else if(code.equals("11"))
  	 {
  	 	Debug.println("in schools in pick administrative sanction form");
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
 	 Debug.println("Target:"+target);
	}
	//

	
	if(mode!=null && mode.equals("getHabss"))
	{
		System.out.println("getHabssgetHabssgetHabssgetHabssgetHabss##########");
		String[] a = request.getParameterValues("mandalss");
		System.out.println("a length:"+a.length);
	}
	//updated by 
	if(mode!=null&&mode.equals("pickRevhab"))
	{
			String code=request.getParameter("assetcode");
		 	Debug.println("scheme code::::::::ss"+code);
		  	 session.setAttribute("selectedWorkId",request.getParameter("proposalId"));
		  	 if(!(code.equals("11")||code.equals("12")))
		  	 {
		  	 ArrayList mandals=rwsLocations.getMandals(circleOfficeCode);
		 	 session.setAttribute("mandals", mandals);
		 	 System.out.println("mandals:"+mandals.size());
		 	 Debug.println("after mandal view>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		 	 target="Mandal-view";
		 	String[] mcodes=null;
		 	DroughtDAO	proposalDAO=new DroughtDAO(getDataSource(request));
		 	// mcodes=proposalDAO.getMandalCodesFormRevised(proposalId);
		 	 mcodes=proposalDAO.getMandalCodesFormAdmn(proposalId);
		 	 session.setAttribute("H_"+proposalId,mcodes);
		  	 }
		  	 else if(code.equals("11"))
		  	 {
		  	 	Debug.println("in schools in pick administrative sanction form");
		  	 	ArrayList mandals=rwsLocations.getMandals(circleOfficeCode); 
			 	session.setAttribute("mandals", mandals);
			 	 target="Mandal-school";
			 	String[] mcodes=null;
			 	DroughtDAO	proposalDAO=new DroughtDAO(getDataSource(request));
			 	// mcodes=proposalDAO.getMandalCodesFormRevised(proposalId);
			 	 mcodes=proposalDAO.getMandalCodesFormAdmn(proposalId);
			 	 session.setAttribute("H_"+proposalId,mcodes);
		  	 }
		  	else if(code.equals("12"))
		  	 {
		  		Debug.println("in pickrevhabs");
		  		//ArrayList divisions=rwsLocations.getDivisions(circleOfficeCode);
		  		//session.setAttribute("divisions", divisions);
		  		ArrayList districts=rwsLocations.getDistricts();
			 	 session.setAttribute("districts", districts);
		  		//ArrayList mandals=rwsLocations.getMandals(circleOfficeCode); 
			 	//session.setAttribute("mandals", mandals);
			 	target="Mandal-lab";
			 	String[] mcodes=null;
			 	DroughtDAO	proposalDAO=new DroughtDAO(getDataSource(request));
			 	// mcodes=proposalDAO.getMandalCodesFormRevised(proposalId);
			 	 mcodes=proposalDAO.getMandalCodesFormAdmn(proposalId);
			 	 session.setAttribute("H_"+proposalId,mcodes);
			 	
		  	 }
		 	 Debug.println("Targetdddlab:"+target);
	}
  //
 	else
 	{
 		System.out.println("in else******************************8");
 		String all=request.getParameter("All");
 		String[] mcodes=null;
 		try{
 		String temp=request.getParameter("selectedMcodes");
 		//updated by 
		  mcodes=temp.split("@");
		  session.setAttribute("H_"+proposalId,mcodes);
	  /*	for(int i=0;i<mcodes.length;i++)
		//System.out.println("MCODEs are:"+mcodes[i]);*/
 		}
 		catch(Exception e)
		{
 			//System.out.println("Exception is:"+e);
		}
	 ArrayList habitations = rwsLocations.getAdminStrativeHabitations((String)session.getAttribute("selectedWorkId"), officeCode, search ,mcodes,all);
 	 session.setAttribute("habitations", habitations);
 	}
	DroughtDAO proposalDAO = new DroughtDAO(getDataSource(request));
	//ArrayList tempSelectedHabs = proposalDAO.getTempSelectedHabs(proposalId);
 	
 	//commented as revised admin habs are showed for admin habs
 	//ArrayList tempSelectedHabs = (ArrayList)session.getAttribute("selectedHabCodesForRevisedAdmnSanc");
 	ArrayList tempSelectedHabs=getSelectedHabs((ArrayList)session.getAttribute("tempSelectedAdmnHabs"),(String)session.getAttribute("selectedWorkId"));
	if(tempSelectedHabs==null)
		tempSelectedHabs=new ArrayList();
 	//System.out.println("tempSelectedHabs size is "+tempSelectedHabs.size());
 	request.setAttribute("tempSelectedHabs", tempSelectedHabs); 
	//System.out.println("target is "+target);
 	//added by 
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
	 Debug.println("cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc");
	// Debug.println("selected habs length:"+tempSelectedHabs.size());
		ArrayList selectedHabs = null;
		Debug.println(tempSelectedHabs1.size()+"dddddddddddd");
		if(tempSelectedHabs1.size() <= 0)
		{	
			System.out.println("-----------All Selected Habitations are----------");
			selectedHabs = proposalDAO.getSelectedHabitations(proposalId);
			request.setAttribute("selectedHabs", selectedHabs);
		}
		else
			request.setAttribute("selectedHabs", tempSelectedHabs1);
	   
 	
 	//
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
