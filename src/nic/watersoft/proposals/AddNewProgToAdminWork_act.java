package nic.watersoft.proposals;

import java.util.ArrayList;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.Debug;
//import nic.watersoft.commons.Debug;
 
 
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class AddNewProgToAdminWork_act extends Action { 
	private ArrayList subprogrammes;	 
	private ArrayList proposals;
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception{
		String target = new String("data-success");
		try{
			RepresentativeProposalForm myForm = (RepresentativeProposalForm)form;
			String mode = myForm.getMode();
			DataSource dataSource = getDataSource(request);
			HttpSession session = request.getSession();
			RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
			boolean init = myForm.getInit();
			ArrayList subPrograms=null;
			String workId=request.getParameter("workId");
			String workName=request.getParameter("workName");
			myForm.setWorkId(workId);
			ProposalHolder proposalHolder = new ProposalHolder();
			CommonLists commonLists = new CommonLists(dataSource);
			if(request.getParameter("UpdateProg")!=null&&request.getParameter("UpdateProg").equals("YES")){
				request.setAttribute("UpdateAddedProgras","UpdateAddedProgras");
			}
			if(init){		
				proposalHolder.setWorkId(workId);
				proposalHolder.setProgrammeCode("57");
				proposals = new ArrayList(1);
				proposalHolder.setWorkName(workName);
			 	proposals.add(proposalHolder);
				SimpleDateFormat fmt = new SimpleDateFormat("dd/MM/yyyy");
				String currentDate = fmt.format(new java.util.Date());
			 	myForm.setProposals(proposals);
			 	myForm.setInit(false);
			 	myForm.setMode("");
			}
			if(mode != null && mode.equals("subprogrammes")){
				String index = request.getParameter("index");
				int ndx = 0;
				if(index != null){
					try{	
						ndx = Integer.parseInt(index);
					}
					catch(NumberFormatException nfe){	
						System.out.println("Error converting index to ndx " + nfe);
					}
				}
				proposals = myForm.getProposals();
				proposalHolder = (ProposalHolder)proposals.get(ndx);
				String programmeCode = proposalHolder.getProgrammeCode();
				subprogrammes = commonLists.getSubprogrammes(programmeCode);
				proposalHolder.setSubprogrammes(subprogrammes);
				proposals.set(ndx, proposalHolder);
				myForm.setProposals(proposals);
			}
			
			if(mode != null && mode.equals("Add")){
				proposals = myForm.getProposals();
				int size = proposals.size();
				if(size == 0)
					size = 1;
			 	proposalHolder = (ProposalHolder)proposals.get(size-1);
			  	proposalHolder = new ProposalHolder();
			  	proposalHolder.setWorkId(workId);
			  	proposalHolder.setWorkName(workName);
			 	proposals.add(proposalHolder);
				myForm.setProposals(proposals);
				if(request.getParameter("AddNewForRev")!=null){
					request.setAttribute("UpdateAddedProgragsForRevise","");
				}
			}
		
			if(mode != null && mode.equals("Remove")){
				ArrayList selectedHabs = null;
				proposals = myForm.getProposals();						
				String[] removeIds = request.getParameterValues("remove");
				if(removeIds != null && removeIds.length != 0){
					for(int p=0; p<removeIds.length; p++){
						System.out.println("removeIds["+p+"] : " + removeIds[p]);
					}
					for(int p=0; p<removeIds.length; p++){
						proposals.remove(Integer.parseInt(removeIds[p]));
					}
					myForm.setProposals(proposals);
			  		String message = "Programme Temporarily Removed - Click Update Button to Remove Permanently";
			  		request.setAttribute("message",message);
			 	}
				else{
					String message = "Please select atleast one proposal to remove.";
					request.setAttribute("message",message);
				}
				if(request.getParameter("AddNewForRev")!=null){
					request.setAttribute("UpdateAddedProgragsForRevise","");
				}
			}
			
			if(mode != null && mode.equals("Add Programs")){
				String staus=request.getParameter("status");
				proposals = myForm.getProposals();
				ProposalDAO proposalDAO = new ProposalDAO(dataSource);			
				boolean status=false;
				if(staus!=null)	{
					if(myForm.getWorkId()!=null && !myForm.getWorkId().equals("")){}
					else
						myForm.setWorkId(request.getParameter("workId"));
				   status=proposalDAO.saveAddminWorkIdAddedProgs2(getDataSource(request),proposals,myForm.getWorkId(),staus);
				}
				else{
					proposalDAO.deleteTempAddProgramsTable(session,myForm.getWorkId());
					proposalDAO.saveAddminWorkIdAddedProgsToSession(session,getDataSource(request),proposals,myForm.getWorkId());
					status=true;				
					ArrayList list=new ArrayList((ArrayList)session.getAttribute("rwsWorkAdmnProgLnkTmp"));
					ProposalHolder proposalHolderTmp=null;
					for(int i=0;i<list.size();i++){
						proposalHolderTmp=(ProposalHolder)list.get(i);					
					}
					java.util.Collections.sort(list, new java.util.Comparator() {
						public int compare(Object o1, Object o2){
					        String str1=((ProposalHolder)o1).getWorkId();
					        String str2=((ProposalHolder)o2).getWorkId();
					        return str1.compareTo(str2);
					    }
					});
					for(int i=0;i<list.size();i++){
						proposalHolderTmp=(ProposalHolder)list.get(i);					
					}
					session.setAttribute("rwsWorkAdmnProgLnkTmp",list);
					list=null;				
				}
				if(status==true){
					request.setAttribute("message","Programs Added Successfully");
				}
				else{ 				
					request.setAttribute("message","Failed To add");
				}			
			}
			
			if(mode != null && mode.equalsIgnoreCase("Add Rev Programs")){
				String staus=request.getParameter("revstaus");
				proposals = myForm.getProposals();
				ProposalDAO proposalDAO = new ProposalDAO(dataSource);
				boolean status=proposalDAO.saveRevisedWorkIdAddedProgs2(session,getDataSource(request),proposals,myForm.getWorkId(),staus);
				if(status==true){
					request.setAttribute("message","Revised Programs Added Successfully");
		 		}
				else{
					request.setAttribute("message","Failed To add");				 
				}
				request.removeAttribute("UpdateAddedProgras");
				request.setAttribute("UpdateAddedProgragsForRevise","");			
			}
			
			if(mode != null && mode.equalsIgnoreCase("AddRevFromViewPrograms")){
				String staus=request.getParameter("revstaus");
				proposals = myForm.getProposals();
				ProposalDAO proposalDAO = new ProposalDAO(dataSource);
				boolean status=proposalDAO.saveRevisedWorkIdAddedProgsFromView(getDataSource(request),proposals,myForm.getWorkId());
				if(status==true){
					request.setAttribute("message","Revised Programs Added Successfully");				 
				}
				else{
					request.setAttribute("message","Failed To add");				 
				}
				request.removeAttribute("UpdateAddedProgras");
				request.removeAttribute("UpdateAddedProgragsForRevise");
				request.setAttribute("FromViewUpdateRevProgs","");			
			}
			
			if(mode != null && mode.equals("UpdatePrograms")){
				ProposalDAO proposalDAO = new ProposalDAO(dataSource);
				proposals=new ArrayList();
				if(request.getParameter("revisedList")==null){
					proposalDAO.deleteTempAddRevProgramsTable(session,workId);
					proposals=proposalDAO.getAddedProgramsList(getDataSource(request),workId);				
					if(proposals.size()>0){
						myForm.setProposals(proposals);
					}
					else{   
						proposalHolder.setWorkId(workId);
					    proposalHolder.setWorkName(workName);
						proposals.add(proposalHolder);
						myForm.setProposals(proposals);
				 	}				
					session.setAttribute("addedProgrammes",new ArrayList(myForm.getProposals()));
					request.setAttribute("UpdateAddedProgras","UpdateAddedProgras");				
				}			
				else{
					proposals=proposalDAO.getAddedProgramsListForRevised(getDataSource(request),workId);
					request.removeAttribute("UpdateAddedProgras");
					request.setAttribute("UpdateAddedProgragsForRevise","");
					if(proposals.size()>0){
					   myForm.setProposals(proposals);
					}
					else{
				 		proposals.add(proposalHolder);
						myForm.setProposals(proposals);
					}
				}			
				if(request.getParameter("AddrevisedProgs")!=null&&request.getParameter("AddrevisedProgs").equalsIgnoreCase("YES")){
					request.removeAttribute("UpdateAddedProgras");
					request.setAttribute("UpdateAddedProgragsForRevise","");
			 	}			
			}
			
			if(mode != null && mode.equals("UpdateRevPrograms")){ 
			 	ProposalDAO proposalDAO = new ProposalDAO(dataSource);
			 	proposals=proposalDAO.getAddedProgramsListForRevised(getDataSource(request),workId);
				request.removeAttribute("UpdateAddedProgras");
				request.removeAttribute("UpdateAddedProgragsForRevise");
				request.setAttribute("FromViewUpdateRevProgs","");
				if(proposals.size()>0){
				   myForm.setProposals(proposals);
				}
				else{
					myForm.setProposals(proposals);
				}
			}
			if(mode != null && mode.equals("Add New")){
		 		ProposalDAO proposalDAO = new ProposalDAO(dataSource);
		 		proposals = new ArrayList();
			 	proposalHolder = new ProposalHolder();
			 	proposalHolder.setWorkId(myForm.getWorkId());
			 	proposalHolder.setWorkName(request.getParameter("workName"));
			 	proposals.add(proposalHolder);	 	
			 	myForm.setProposals(proposals);
			 	proposalDAO.deleteTempAddProgramsTable(session,workId);
			}
			if(mode != null && mode.equals("UpdateAdmnPrograms")){
		 		ProposalDAO proposalDAO = new ProposalDAO(dataSource);
		 	 	proposalDAO.deleteTempAddProgramsTable(session,workId);
			}
		}
		catch(Exception e){
			System.out.println("The Exception is in AddNewProgTOAdminWork_Act : "+e.getMessage());
		}
		return mapping.findForward(target);
	}
}
