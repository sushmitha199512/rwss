package nic.watersoft.proposals;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Iterator;
//import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.CommonLists;
//import nic.watersoft.commons.Debug;
//import nic.watersoft.commons.RwsLocationBean;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class Rws_revised_sanction_act extends Action {
	private ArrayList headOffices;
	private ArrayList circles;
	private ArrayList divisions;
	private ArrayList subdivisions;
 	private ArrayList assetTypes;
	private ArrayList programmes;
	private ArrayList subprogrammes;
    private ArrayList proposals;
	private ArrayList workIds=null;
	private ArrayList workcategory;	

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		String target = new String("data-success");
		String fromMode="";
		try{
			RepresentativeProposalForm myForm = (RepresentativeProposalForm)form;			
			ArrayList admnSelectedHabs=new ArrayList();
			DataSource dataSource = getDataSource(request);
			HttpSession session = request.getSession();
			RwsUser user = (RwsUser)session.getAttribute("RWS_USER");		 
			String mode = request.getParameter("mode");
			boolean init = myForm.getInit();
			String headOfficeCode = myForm.getHeadOfficeCode();
			String circleOfficeCode = myForm.getCircleOfficeCode();
			String divisionOfficeCode = myForm.getDivisionOfficeCode();
			String subdivisionOfficeCode = myForm.getSubdivisionOfficeCode();
			String typeOfAssetCode=myForm.getTypeOfAsset();
		    String programmeCode=myForm.getPrograms();
		    String subProgrammeCode=myForm.getSubPrograms();
			String plan=myForm.getPlan();
			String wrkType=myForm.getWrktype();
			String workCat=myForm.getWorkCat();		
			if(headOfficeCode == null)
				headOfficeCode = user.getHeadOfficeCode();
			if(circleOfficeCode == null)
				circleOfficeCode = user.getCircleOfficeCode();
			if(divisionOfficeCode == null)
				divisionOfficeCode = user.getDivisionOfficeCode();
			if(subdivisionOfficeCode == null)
				subdivisionOfficeCode = user.getSubdivisionOfficeCode();		
			CommonLists commonLists = new CommonLists(dataSource);
			ProposalDAO proposalDAO = new ProposalDAO(dataSource);
			RwsOffices rwsOffices = new RwsOffices(dataSource);
			ProposalHolder proposalHolder = null;			    
		    String nextProposalId = null;
		    if(init){
		    	if(headOfficeCode.equals("1"))
					circles = rwsOffices.getCircles(headOfficeCode);
				if(circleOfficeCode.equals("00"))
					circles = rwsOffices.getCircles(headOfficeCode);
				if(divisionOfficeCode.equals("0"))
					divisions = rwsOffices.getDivisions(headOfficeCode, circleOfficeCode);
				if(subdivisionOfficeCode.equals("00"))
					subdivisions = rwsOffices.getSubdivisions(headOfficeCode, circleOfficeCode, divisionOfficeCode);
				subprogrammes = new ArrayList(1);
				workcategory=commonLists.getWorkCategory();
				proposals = new ArrayList(1);
				proposalHolder = new ProposalHolder();
			  	proposals.add(proposalHolder); 
				myForm.setProposals(proposals);				
				myForm.setInit(false);
			}
		    if(request.getParameter("initial")!=null && request.getParameter("initial").equals("true"))	{
		    	if(headOfficeCode.equals("1"))
					circles = rwsOffices.getCircles(headOfficeCode);
				if(circleOfficeCode.equals("00"))
					circles = rwsOffices.getCircles(headOfficeCode);
				if(divisionOfficeCode.equals("0"))
					divisions = rwsOffices.getDivisions(headOfficeCode, circleOfficeCode);
				if(subdivisionOfficeCode.equals("00"))
					subdivisions = rwsOffices.getSubdivisions(headOfficeCode, circleOfficeCode, divisionOfficeCode);		 	
				subprogrammes = new ArrayList(1);
				workcategory=commonLists.getWorkCategory();
				proposals = new ArrayList(1);
				proposalHolder = new ProposalHolder();
			  	proposals.add(proposalHolder); 
				myForm.setProposals(proposals);			
				myForm.setInit(false);		
				session.removeAttribute("selectedHabCodesForRevisedAdmnSanc");
				session.removeAttribute("tempSelectedAdmnHabs");
				session.removeAttribute("selectedHabs");
				reset(myForm);
		    }
		    
		    if(mode==null) {
		    	reset(myForm);
		    	session.removeAttribute("workcategory");
		    	session.removeAttribute("assetTypes");
		    	session.removeAttribute("programmes");
				session.removeAttribute("SubPrograms");
		    	session.removeAttribute("circles");
		    	session.removeAttribute("divisions");
		    	session.removeAttribute("subdivisions");
				session.removeAttribute("selectedHabs");
				session.removeAttribute("tempSelectedAdmnHabs");
				session.removeAttribute("rwsWorkAdmnProgLnkTmp");
				session.removeAttribute("proposalsHabs");
				session.removeAttribute("habsarray");
				session.removeAttribute("WorkIds");		  
				proposals = new ArrayList(1);
				proposalHolder = new ProposalHolder();
		    	proposalHolder.setProposalId(nextProposalId);
				proposals.add(proposalHolder);
				SimpleDateFormat fmt = new SimpleDateFormat("dd/MM/yyyy");
				String currentDate = fmt.format(new java.util.Date());
	 			myForm.setProposals(proposals);
				myForm.setInit(false);			
			}
		    
		    if(mode!=null && mode.equals("scheme"))	{
				session.removeAttribute("assetTypes");
				session.removeAttribute("workcategory");
				session.removeAttribute("programmes");
				session.removeAttribute("SubPrograms");
				session.removeAttribute("divisions");
				session.removeAttribute("subdivisions");
				session.removeAttribute("WorkIds");
				assetTypes=commonLists.getAssetTypes(myForm.getWorkCat(),myForm.getPlan());
				request.setAttribute("resetForm","true");
			}
		    
			if(mode != null && mode.equals("programmes")){
				session.removeAttribute("programmes");
				session.removeAttribute("SubPrograms");
				session.removeAttribute("divisions");
				session.removeAttribute("subdivisions");
				session.removeAttribute("WorkIds");
				programmes = commonLists.getProgrammes1(myForm.getPlan(),myForm.getWrktype(),myForm.getWorkCat());
	     	    request.setAttribute("resetForm","true");
			}
			
			if(mode != null && mode.equals("subprogrammes")){
				session.removeAttribute("divisions");
				session.removeAttribute("subdivisions");
				session.removeAttribute("WorkIds");	
			    subprogrammes = commonLists.getSubprogrammes(programmeCode);
			    request.setAttribute("resetForm","true");
			}
			
			if(mode != null && mode.equals("circles")){
				session.removeAttribute("divisions");
				session.removeAttribute("subdivisions");
				session.removeAttribute("WorkIds");
				headOfficeCode = myForm.getHeadOfficeCode();
				circles = rwsOffices.getCircles(headOfficeCode);
				myForm.setCircleOfficeCode("00");
				myForm.setDivisionOfficeCode("0");
				myForm.setSubdivisionOfficeCode("00");
				request.setAttribute("resetForm","true");				
			}
			
			if(mode != null && mode.equals("divisions")){
				session.removeAttribute("divisions");
				session.removeAttribute("subdivisions");
			    session.removeAttribute("WorkIds");
			    session.removeAttribute("rwsWorkAdmnProgLnkTmp");			    
			    divisions = rwsOffices.getDivisions(headOfficeCode, circleOfficeCode);
				myForm.setDivisionOfficeCode("0");
				myForm.setSubdivisionOfficeCode("00");
				request.setAttribute("resetForm","true");
			}
			
			if(mode != null && mode.equals("subdivisions"))	{
				 session.removeAttribute("subdivisions");
				 session.removeAttribute("WorkIds");
				 headOfficeCode = myForm.getHeadOfficeCode();
				 circleOfficeCode = myForm.getCircleOfficeCode();
				 divisionOfficeCode = myForm.getDivisionOfficeCode();
				 subdivisions = rwsOffices.getSubdivisions(headOfficeCode, circleOfficeCode, divisionOfficeCode);
				 request.setAttribute("resetForm","true");
			}
			
			if(mode != null && mode.equals("getWorks")){			 
			  session.removeAttribute("WorkIds");	
			  workIds=proposalDAO.getAdminstativeSanctionedWorkIds(headOfficeCode, circleOfficeCode, divisionOfficeCode,subdivisionOfficeCode,typeOfAssetCode,programmeCode,subProgrammeCode,plan,wrkType,workCat);
			  request.setAttribute("resetForm","true");
			}
		
			if(mode != null && mode.equals("workDetails")){
				target="data-success";
				proposals=new ArrayList();
			 	proposals.add(proposalDAO.getWorkDetails(request.getParameter("workId"),request.getParameter("workName")));
				myForm.setProposals(proposals);
				ProposalDTO proposalDTO = new ProposalDTO();
				proposalDTO=proposalDAO.getWorkDetails1(request.getParameter("workId"),request.getParameter("workName"));
				session.setAttribute("leads",proposalDTO.getLeadHabitation());
				admnSelectedHabs=proposalDAO.getHabsForWorkId2(request.getParameter("workId"),request.getParameter("workName"));
				session.setAttribute("tempSelectedAdmnHabs",admnSelectedHabs);
				session.setAttribute("selectedHabCodesForRevisedAdmnSanc",admnSelectedHabs);
				session.setAttribute("selectedHabs",admnSelectedHabs);
				fromMode="workDetails";
				String work=request.getParameter("workId");
				session.setAttribute("workid",work);
				mode="showHabs";
			}
		
			if(mode != null && mode.equals("showHabs")){
				ArrayList selectedHabs=null;
				if(!fromMode.equals("workDetails"))
					selectedHabs=(ArrayList)session.getAttribute("selectedHabCodesForRevisedAdmnSanc");
				else {
					selectedHabs=admnSelectedHabs;
					session.setAttribute("selectedHabCodesForRevisedAdmnSanc",selectedHabs);
				}
				ArrayList tempSelectedHabs=proposalDAO.getRevisedSelectedHabs(selectedHabs,myForm.getWorkId());
				session.setAttribute("tempSelectedAdmnHabs",tempSelectedHabs);
				session.setAttribute("selectedHabs", tempSelectedHabs);
				request.setAttribute("resetForm","true");
			}
			 
			if(circles != null)
				session.setAttribute("circles", circles);
			if(divisions != null)
				session.setAttribute("divisions", divisions);
			if(subdivisions != null)
				session.setAttribute("subdivisions", subdivisions);
			if(assetTypes != null)
			   session.setAttribute("assetTypes", assetTypes);
			if(workcategory != null)
			   session.setAttribute("workcategory",workcategory);
			if(programmes != null)
			   session.setAttribute("programmes", programmes);
			if(subprogrammes != null)
				session.setAttribute("SubPrograms",subprogrammes);	
			if(workIds != null)
				session.setAttribute("WorkIds",workIds);
		}
		catch(Exception e){
			System.out.println("The Exception is in Rws_revised_sanction_act : "+e.getMessage());
		}
		return mapping.findForward(target);
	}
	
	public void reset(RepresentativeProposalForm myForm){
		myForm.setRepCode("");
		myForm.setConstituencyCode("");
		myForm.setRepName("");
		myForm.setRepAddress("");
		myForm.setRepDate("");
		myForm.setDescription("");
		myForm.setEndorsementNo("");
		myForm.setEndorsementDate("");
		myForm.setEndorsedBy("");
		myForm.setRecommendations("");
		myForm.setInit(true);
		myForm.setSelectedHabCode("");
		myForm.setCircleOfficeCode("");
		myForm.setDivisionOfficeCode("");
		myForm.setTypeOfAsset("");
		myForm.setWorkCat("");
		myForm.setPrograms("");
		myForm.setSubPrograms("");
		myForm.setSubdivisionOfficeCode("");
		myForm.setPlan("");
		myForm.setWrktype("");
		myForm.setAugsch("");
		myForm.setProoved("");
		myForm.setSustainDetails("");
		if(myForm.getProposals()!=null){
			Iterator iterator = myForm.getProposals().iterator();		
			ProposalHolder proposalHolder = null;
			while(iterator.hasNext()){
				proposalHolder = (ProposalHolder)iterator.next();
				proposalHolder.setEstimateCost("");
				proposalHolder.setAdminiStrativeDate("");
				proposalHolder.setAdminiStrativeNum("");
				proposalHolder.setSpillOver("");
				proposalHolder.setNoOfHabs("");
				proposalHolder.setProposalName("");
				proposalHolder.setSanctionAmout("");
				proposalHolder.setProposalId("");
				proposalHolder.setProposalName("");
				proposalHolder.setRemarks("");
				proposalHolder.setAugmentation("");				
			}
		}		
	}
}
