package nic.watersoft.pushkar;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;
//added by 
import nic.watersoft.commons.RwsUser;
import nic.watersoft.drought.DroughtDAO;
//

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class PickAdminStrativeHabitation  extends Action{
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception 
{
		Rws_PushkarDAO	proposalDAO=new Rws_PushkarDAO(getDataSource(request));
	Debug.println("in PickAdminStrativeHabitation Action class");
	    String target = new String("data-success");
 	String headOfficeCode = request.getParameter("hoc");
	String circleOfficeCode = request.getParameter("coc");
 	String search = request.getParameter("search");
	//System.out.println("in pick habs: "+search);
	String proposalId = request.getParameter("proposalId");
	
	String officeCode = headOfficeCode + circleOfficeCode ;
//	
	boolean flag = true;
	if(request.getParameter("flag")!=null && request.getParameter("flag").equals("false"))flag=false;
	//
	String mode=request.getParameter("mode");
	
	//System.out.println("MODE VALUE IS---------->"+request.getParameter("mode"));
	RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
	HttpSession session = request.getSession();
	
	
	if(mode!=null&&mode.equals("pickhab"))
	{
     Debug.println("i am in pickadmin action class......anupama.................");
	

  	
  	 String habindex=request.getParameter("index");
  	 session.setAttribute("habindex",habindex);
     
  	 session.setAttribute("selectedWorkId",request.getParameter("proposalId"));
  	String coc=request.getParameter("coc");
  	 ArrayList mandals=rwsLocations.getMandals(coc);
 	 session.setAttribute("mandals", mandals);
 	Debug.println("mandals"+mandals.size());
 	 target="Mandal-view";
 	 
 	 System.out.println("target-view"+target);
 	 String[] mcodes=null;
 	
 	 mcodes=proposalDAO.getMandalCodesFormAdmn(coc);
 	 session.setAttribute("H_"+proposalId,mcodes);
 	 session.setAttribute("proposalId",proposalId);
  	
 	 return mapping.findForward(target);
 	
	}
	

	

	if(mode!=null && mode.equals("getHabss"))
	{
		System.out.println("getHabssgetHabssgetHabssgetHabssgetHabss##########");
		String[] a = request.getParameterValues("mandalss");
		System.out.println("a length:"+a.length);
	}
	
 	else
 	{
 		System.out.println("in else******************************8");
 		String all=request.getParameter("All");
 		String[] mcodes=null;
 		try{
 		String temp=request.getParameter("selectedMcodes");
 		 mcodes=temp.split("@");
		 session.setAttribute("H_"+proposalId,mcodes);
	 
 		}
 		catch(Exception e)
		{
 			
		}
	 ArrayList habitations = proposalDAO.getAdminStrativeHabitations((String)session.getAttribute("selectedWorkId"), officeCode, search ,mcodes,all);
 	 session.setAttribute("habitations", habitations);
 	 System.out.println("habitations"+habitations.size());
 	} 
	
	
	/*ArrayList tempSelectedHabs=getSelectedHabs((ArrayList)session.getAttribute("tempSelectedAdmnHabs"),(String)session.getAttribute("selectedWorkId"));
	if(tempSelectedHabs==null)
		tempSelectedHabs=new ArrayList();
 	System.out.println("tempSelectedHabs size is anupama"+tempSelectedHabs.size());
 	request.setAttribute("tempSelectedHabs", tempSelectedHabs); 
	
 	
 	String code = ((String)session.getAttribute("selectedWorkId")).substring(4,6);
 	System.out.println("code "+code);
 	String tabName1 = "";
 	RwsUser user=new RwsUser();
	user=(RwsUser)session.getAttribute("RWS_USER");

 	if((code.equals("11")))
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
 	*/
 	
 	//proposalDAO.insertProposalTempHabsForAdmin(proposalId,aa,tabName1,flag);
 //	ArrayList tempSelectedHabs1 = proposalDAO.getTempSelectedHabsForAdminSancEdit(proposalId,tabName1);
	// Debug.println("tempSelectedHabs1"+tempSelectedHabs1);
	// Debug.println("selected habs length:"+tempSelectedHabs.size());
	//	ArrayList selectedHabs = null;
	//	Debug.println(tempSelectedHabs1.size()+"dddddddddddd");
	//	if(tempSelectedHabs1.size() <= 0)
		//{	
		//	System.out.println("-----------All Selected Habitations are----------");
		//	selectedHabs = proposalDAO.getSelectedHabitations(proposalId);
		//	request.setAttribute("selectedHabs", selectedHabs);
		//}
		//else
		//.setAttribute("selectedHabs", tempSelectedHabs1);
	   
 	
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
