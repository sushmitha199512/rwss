package nic.watersoft.proposals;

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

public class PickAdminStrativeHabitation extends Action{
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
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
		try{
			if(mode!=null&&mode.equals("pickhab")){
			  	 String code=request.getParameter("assetcode");	    
			  	 session.setAttribute("selectedWorkId",request.getParameter("proposalId"));
			  	 if(!(code.equals("11")||code.equals("12")||code.equals("13")||code.equals("14"))) {
				  	 ArrayList mandals=rwsLocations.getMandals(circleOfficeCode);
				 	 session.setAttribute("mandals", mandals);
				 	 target="Mandal-view";
				 	 String[] mcodes=null;
				 	 ProposalDAO	proposalDAO=new ProposalDAO(getDataSource(request));
				 	 mcodes=proposalDAO.getMandalCodesFormAdmn(proposalId);	
				 	 session.setAttribute("H_"+proposalId,mcodes);
			  	 }
			  	 else if(code.equals("11")){
			  	 	 ArrayList mandals=rwsLocations.getMandals(circleOfficeCode); 
				 	 session.setAttribute("mandals", mandals);
				 	 target="Mandal-school";
				 	 String[] mcodes=null;
				 	 ProposalDAO	proposalDAO=new ProposalDAO(getDataSource(request));
				 	 mcodes=proposalDAO.getMandalCodesFormAdmn(proposalId);
				 	 session.setAttribute("H_"+proposalId,mcodes);
			  	 }
			  	else if(code.equals("12")){
			  		ArrayList divisions=rwsLocations.getDivisions(circleOfficeCode);
			  		session.setAttribute("divisions", divisions);
				 	target="Mandal-lab";
			  	 }	else if(code.equals("13")){
			  	 	 ArrayList mandals=rwsLocations.getMandals(circleOfficeCode); 
				 	 session.setAttribute("mandals", mandals);
				 	 target="Mandal-anganwadi";
				 	 String[] mcodes=null;
				 	 ProposalDAO	proposalDAO=new ProposalDAO(getDataSource(request));
				 	 mcodes=proposalDAO.getMandalCodesFormAdmn(proposalId);
				 	 session.setAttribute("H_"+proposalId,mcodes);
			  	 }
			  	else if(code.equals("14")){
			  	 	 ArrayList mandals=rwsLocations.getMandals(circleOfficeCode); 
				 	 session.setAttribute("mandals", mandals);
				 	 target="Mandal-PI";
				 	 String[] mcodes=null;
				 	 ProposalDAO	proposalDAO=new ProposalDAO(getDataSource(request));
				 	 mcodes=proposalDAO.getMandalCodesFormAdmn(proposalId);
				 	 session.setAttribute("H_"+proposalId,mcodes);
			  	 }
			}
			
			if(mode!=null && mode.equals("getHabss")){
				String[] a = request.getParameterValues("mandalss");
			}
			
			if(mode!=null&&mode.equals("pickRevhab")){
					String code=request.getParameter("assetcode");
				 	session.setAttribute("selectedWorkId",request.getParameter("proposalId"));
				  	if(!(code.equals("11")||code.equals("12"))){
					  	 ArrayList mandals=rwsLocations.getMandals(circleOfficeCode);
					 	 session.setAttribute("mandals", mandals);
					 	 target="Mandal-view";
					 	 String[] mcodes=null;
					 	 ProposalDAO	proposalDAO=new ProposalDAO(getDataSource(request));
					 	 mcodes=proposalDAO.getMandalCodesFormAdmn(proposalId);
					 	 session.setAttribute("H_"+proposalId,mcodes);
				  	 }
				  	 else if(code.equals("11")) {
			  	 		 ArrayList mandals=rwsLocations.getMandals(circleOfficeCode); 
			  	 		 session.setAttribute("mandals", mandals);
			  	 		 target="Mandal-school";
			  	 		 String[] mcodes=null;
			  	 		 ProposalDAO	proposalDAO=new ProposalDAO(getDataSource(request));
					 	 mcodes=proposalDAO.getMandalCodesFormAdmn(proposalId);
					 	 session.setAttribute("H_"+proposalId,mcodes);
				  	 }
				  	 else if(code.equals("12")){
				  		 ArrayList districts=rwsLocations.getDistricts();
					 	 session.setAttribute("districts", districts);
				  		 target="Mandal-lab";
					 	 String[] mcodes=null;
					 	 ProposalDAO	proposalDAO=new ProposalDAO(getDataSource(request));
					 	 mcodes=proposalDAO.getMandalCodesFormAdmn(proposalId);
					 	 session.setAttribute("H_"+proposalId,mcodes);			 	
				  	 }
			} else {
		 		String all=request.getParameter("All");
		 		String[] mcodes=null;
		 		try{
		 			String temp=request.getParameter("selectedMcodes");
		 			if(temp !=null){
		 				mcodes=temp.split("@");
			 		}
		 			session.setAttribute("H_"+proposalId,mcodes);
		 		}
		 		catch(Exception e){
		 			System.out.println("The Exception is in PickAdminStrativeHabitations : "+e.getMessage());
				}
		 		ArrayList habitations = rwsLocations.getAdminStrativeHabitations((String)session.getAttribute("selectedWorkId"), officeCode, search ,mcodes,all);
		 		session.setAttribute("habitations", habitations);
		 	}
		 	ProposalDAO proposalDAO = new ProposalDAO(getDataSource(request));
			ArrayList tempSelectedHabs=getSelectedHabs((ArrayList)session.getAttribute("tempSelectedAdmnHabs"),(String)session.getAttribute("selectedWorkId"));
			if(tempSelectedHabs==null)
				tempSelectedHabs=new ArrayList();
		 	request.setAttribute("tempSelectedHabs", tempSelectedHabs); 
			String code = ((String)session.getAttribute("selectedWorkId")).substring(6,8);
			String tabName1 = "";
			RwsUser user=new RwsUser();
			user=(RwsUser)session.getAttribute("RWS_USER");
		 	if(!(code.equals("11")|| code.equals("12"))) {
				tabName1 = "tab_"+user.getUserId()+"_temp";
			}
			else if(code.equals("11")) {
				tabName1 = "tab_"+user.getUserId()+"_temp_school";
			}
			else if(code.equals("12")){
				tabName1 = "tab_"+user.getUserId()+"_temp_lab";
			}
		 	String[] aa = new String[0];	 	
		 	proposalDAO.insertProposalTempHabsForAdmin(proposalId,aa,tabName1,flag);
		 	ArrayList tempSelectedHabs1 = proposalDAO.getTempSelectedHabsForAdminSancEdit(proposalId,tabName1);
			ArrayList selectedHabs = null;
				if(tempSelectedHabs1.size() <= 0) {	
					selectedHabs = proposalDAO.getSelectedHabitations(proposalId);
					request.setAttribute("selectedHabs", selectedHabs);
				}
				else
					request.setAttribute("selectedHabs", tempSelectedHabs1);
		}catch(Exception e){
			System.out.println("The Exception is in PickAdminStrativeHabitation : "+e.getMessage());
		}
		return mapping.findForward(target);
	}
	
	public ArrayList getSelectedHabs(ArrayList selectedHabsForAllWorks,String proposalId){	
		ArrayList selectedHabs=new ArrayList();
		if(selectedHabsForAllWorks!=null){			
			for(int i=0;i<selectedHabsForAllWorks.size();i++){
				nic.watersoft.commons.RwsLocationBean rwsLocationBean=(nic.watersoft.commons.RwsLocationBean)selectedHabsForAllWorks.get(i);
				if(rwsLocationBean.getProposalId().equals(proposalId))
					selectedHabs.add(rwsLocationBean);				
			}
		}
		return selectedHabs;
	}
}
