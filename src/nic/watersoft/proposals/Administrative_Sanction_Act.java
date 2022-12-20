package nic.watersoft.proposals;

import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocationBean;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.wquality.RwsWQualityData;



import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.commons.beanutils.PropertyUtils;

import java.beans.Introspector;

public class Administrative_Sanction_Act extends Action {	 
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
	    System.gc();		
	    ArrayList headOffices=null;
	    ArrayList circles=null;
	    ArrayList divisions=null;
	    ArrayList subdivisions=null;
 	    ArrayList assetTypes=null;
	    ArrayList programmes=null;
	    ArrayList subprogrammes=null;
	    ArrayList proposals=null;
	    ArrayList workcategory=null;		
	  	HttpSession session = request.getSession();
	  	RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if((user.getUserId()!=null && !(user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || Constants.IsEEUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");	
		}
		String target = new String("data-success");		
		RepresentativeProposalForm myForm = (RepresentativeProposalForm)form;		
		if (myForm == null)
			return mapping.findForward("expire");		
		DataSource dataSource = getDataSource(request);		
		String mode = myForm.getMode();	 	
		boolean init = myForm.getInit();		
		if(myForm.getWrktype() != null && myForm.getWrktype().equals("2")){
			request.setAttribute("special","1");
		} else {
			request.setAttribute("special","0");
		}
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
 		if(session.getAttribute("subdivisionOfficeCode") !=null){
 			subdivisionOfficeCode=(String)session.getAttribute("subdivisionOfficeCode");
 		}		
		CommonLists commonLists = new CommonLists(dataSource);
		ProposalDAO proposalDAO = new ProposalDAO(dataSource);
		RwsOffices rwsOffices = new RwsOffices(dataSource);
		ProposalHolder proposalHolder = null;
		String nextProposalId = null;
		String typeOfAssetCode=myForm.getTypeOfAsset();
	    String ProgrammeCode=myForm.getPrograms();
	    String subProgrammeCode=myForm.getSubPrograms();
	    if(mode!=null && mode.equals("null")){	
	    	reset(myForm);
	    	session.removeAttribute("workcategory1");
	    	session.removeAttribute("assetTypes1");
	    	session.removeAttribute("programmes1");
			session.removeAttribute("SubPrograms1");
	    	session.removeAttribute("circles1");
	    	session.removeAttribute("divisions1");
	    	session.removeAttribute("subdivisions1");
			session.removeAttribute("selectedHabs");
			session.removeAttribute("tempSelectedAdmnHabs");
			session.removeAttribute("rwsWorkAdmnProgLnkTmp");
			session.removeAttribute("proposalsHabs");
			session.removeAttribute("habsarray");
			session.removeAttribute("proposalId");			
		    try	{
				ArrayList rwsWorkAdmnProgLnkTmp=(ArrayList)session.getAttribute("rwsWorkAdmnProgLnkTmp");
				if(rwsWorkAdmnProgLnkTmp!=null)	{
					proposalDAO.deleteTempAddProgramsTable(session,myForm.getWorkId());
				}
			}
		    catch(Exception e){
		    	System.out.println("The Exceptionis in the Administrative_Sanction_Act remove : "+e.getMessage());
		    }
			proposals = new ArrayList(1);
			proposalHolder = new ProposalHolder();
	    	proposalHolder.setProposalId(nextProposalId);
			proposals.add(proposalHolder);
			SimpleDateFormat fmt = new SimpleDateFormat("dd/MM/yyyy");
			String currentDate = fmt.format(new java.util.Date());
 			myForm.setProposals(proposals);
			myForm.setInit(false);
		}
	    
	    if(mode!=null && mode.equals("workCategory")) {
	    	reset1(myForm);
	    	session.removeAttribute("programmes1");
			session.removeAttribute("SubPrograms1");
	    	session.removeAttribute("circles1");
	    	session.removeAttribute("divisions1");
	    	session.removeAttribute("subdivisions1");
			session.removeAttribute("selectedHabs");
			session.removeAttribute("tempSelectedAdmnHabs");
			session.removeAttribute("rwsWorkAdmnProgLnkTmp");
			session.removeAttribute("proposalsHabs");
			session.removeAttribute("habsarray");			
		    workcategory=new ArrayList();
	    	workcategory=commonLists.getWorkCategory();
	    }
	    
	    if(mode!=null && mode.equals("scheme")){
	    	resetProposal(myForm);
	    	session.removeAttribute("programmes1");
			session.removeAttribute("SubPrograms1");
	    	session.removeAttribute("circles1");
	    	session.removeAttribute("divisions1");
	    	session.removeAttribute("subdivisions1");
			session.removeAttribute("selectedHabs");
			session.removeAttribute("tempSelectedAdmnHabs");
			session.removeAttribute("rwsWorkAdmnProgLnkTmp");
			session.removeAttribute("proposalsHabs");
			session.removeAttribute("habsarray");
			try	{
				assetTypes=commonLists.getAssetTypes(myForm.getWorkCat(),myForm.getPlan());
			}
			catch(Exception e) {
				Debug.println("The Exception is in Adminisrative_Sanction_Act Scheme : "+e.getMessage());
			}
			request.setAttribute("resetForm","true");
		}
	    
	    if(mode !=null && mode.equals("programmes")){
	    	try	{
				session.removeAttribute("SubPrograms1");
		    	session.removeAttribute("circles1");
		    	session.removeAttribute("divisions1");
		    	session.removeAttribute("subdivisions1");
				session.removeAttribute("selectedHabs");
				session.removeAttribute("tempSelectedAdmnHabs");
				session.removeAttribute("rwsWorkAdmnProgLnkTmp");
				session.removeAttribute("proposalsHabs");
				session.removeAttribute("habsarray");
				resetProposal(myForm);
				if(!myForm.getTypeOfAsset().equals("")){
					programmes = commonLists.getProgrammes1(myForm.getPlan(),myForm.getWrktype(),myForm.getWorkCat());
				}
			}
		 	catch(Exception e){
			 	Debug.println("The Exception is in Adminisrative_Sanction_Act programmes "+e.getMessage());
			}
			request.setAttribute("resetForm","true");
		}
	    
	    if(mode != null && mode.equals("subprogrammes")){
	    	session.removeAttribute("SubPrograms1");
	    	session.removeAttribute("circles1");
	    	session.removeAttribute("divisions1");
	    	session.removeAttribute("subdivisions1");
			session.removeAttribute("selectedHabs");
			session.removeAttribute("tempSelectedAdmnHabs");
			session.removeAttribute("rwsWorkAdmnProgLnkTmp");
			session.removeAttribute("proposalsHabs");
			session.removeAttribute("habsarray");
			myForm.setSubPrograms("");
			resetProposal(myForm);
			try	{
				String programmeCode = myForm.getPrograms();
				subProgrammeCode = myForm.getSubPrograms();
				if(programmeCode!=null && !programmeCode.equals("")){
					circles=new ArrayList();
			 		circles = rwsOffices.getCircles(headOfficeCode);				
					divisions=new ArrayList();
					divisions = rwsOffices.getDivisions(headOfficeCode, circleOfficeCode);				
					subdivisions=new ArrayList();
					subdivisions = rwsOffices.getSubdivisions(headOfficeCode, circleOfficeCode, divisionOfficeCode);					
					request.setAttribute("resetForm","true");
				} else {
					resetProposal(myForm);
				}				
				subprogrammes = commonLists.getSubprogrammes(programmeCode);
				if(circleOfficeCode!=null && !circleOfficeCode.equals("") && typeOfAssetCode!=null && !typeOfAssetCode.equals("") && ProgrammeCode!=null && !ProgrammeCode.equals("") && subProgrammeCode!=null && !subProgrammeCode.equals("")){
					nextProposalId = proposalDAO.getNextProposalIdForAdminiStrative(headOfficeCode, circleOfficeCode,typeOfAssetCode,ProgrammeCode,subProgrammeCode);
					if(nextProposalId.length()==14)	{
						proposals = myForm.getProposals();
						int size = proposals.size();
						String[] proposalIds = new String[size];
						String firstPart = nextProposalId.substring(0,10);
						String secondPart = nextProposalId.substring(10,14);
						int sno = Integer.parseInt(secondPart);
						String proposalId = null; 
						for(int i=0; i<size; i++) {
							if(sno<10)
								secondPart = "000"+sno;
							else if(sno<100)
								secondPart = "00"+sno;
							else if(sno<1000)
								secondPart = "0"+sno;
							else
								secondPart = String.valueOf(sno);							
							proposalId = firstPart + secondPart;
							proposalHolder = (ProposalHolder)proposals.get(i);
							proposalHolder.setProposalId(proposalId);
							proposals.set(i,proposalHolder);
							sno++;
						}
					}
				} else {
					resetProposal(myForm);
				}
			 }
			 catch(Exception e) {
			 	Debug.println("The Exception is in Adminisrative_Sanction_Act Subprogrammes : "+e.getMessage());
			 }
			 request.setAttribute("resetForm","true");
		}
	    
	    if(mode != null && mode.equals("subprogrammes1")){
	    	session.removeAttribute("SubPrograms1");
	    	session.removeAttribute("circles1");
	    	session.removeAttribute("divisions1");
	    	session.removeAttribute("subdivisions1");
			session.removeAttribute("selectedHabs");
			session.removeAttribute("tempSelectedAdmnHabs");
			session.removeAttribute("rwsWorkAdmnProgLnkTmp");
			try	{
				String programmeCode = myForm.getPrograms();
				if(programmeCode!=null && !programmeCode.equals("")){
					circles=new ArrayList();
			 		circles = rwsOffices.getCircles(headOfficeCode);				
					divisions=new ArrayList();
					divisions = rwsOffices.getDivisions(headOfficeCode, circleOfficeCode);				
					subdivisions=new ArrayList();
					subdivisions = rwsOffices.getSubdivisions(headOfficeCode, circleOfficeCode, divisionOfficeCode);					
					request.setAttribute("resetForm","true");
				} else {
					resetProposal(myForm);
				}
				subprogrammes = commonLists.getSubprogrammes(programmeCode);
				if(circleOfficeCode!=null && !circleOfficeCode.equals("") && typeOfAssetCode!=null && !typeOfAssetCode.equals("") && ProgrammeCode!=null && !ProgrammeCode.equals("") && subProgrammeCode!=null && !subProgrammeCode.equals("")){
					nextProposalId = proposalDAO.getNextProposalIdForAdminiStrative(headOfficeCode, circleOfficeCode,typeOfAssetCode,ProgrammeCode,subProgrammeCode);
					if(nextProposalId.length()==14)	{
						proposals = myForm.getProposals();
						int size = proposals.size();
						String[] proposalIds = new String[size];
						String firstPart = nextProposalId.substring(0,10);
						String secondPart = nextProposalId.substring(10,14);
						int sno = Integer.parseInt(secondPart);
						String proposalId = null; 
						for(int i=0; i<size; i++){
							if(sno<10)
								secondPart = "000"+sno;
							else
							if(sno<100)
								secondPart = "00"+sno;
							else
							if(sno<1000)
								secondPart = "0"+sno;
							else
								secondPart = String.valueOf(sno);							
							proposalId = firstPart + secondPart;
							proposalHolder = (ProposalHolder)proposals.get(i);
							proposalHolder.setProposalId(proposalId);
							proposals.set(i,proposalHolder);
							sno++;
						}
					}
				}
				else{
					resetProposal(myForm);
				}
			 }
			 catch(Exception e) {
			 	Debug.println("The Exception is in Adminisrative_Sanction_Act Subprogrammes1 "+e.getMessage());
			 }
			request.setAttribute("resetForm","true");
		}
	    
	    if(mode != null && mode.equals("divisions")){
	    	session.removeAttribute("divisions1");
	    	session.removeAttribute("subdivisions1");
			session.removeAttribute("selectedHabs");
			session.removeAttribute("tempSelectedAdmnHabs");
			session.removeAttribute("rwsWorkAdmnProgLnkTmp");
			if(circleOfficeCode!=null && !circleOfficeCode.equals("") && typeOfAssetCode!=null && !typeOfAssetCode.equals("") && ProgrammeCode!=null && !ProgrammeCode.equals("") && subProgrammeCode!=null && !subProgrammeCode.equals("")){
				nextProposalId = proposalDAO.getNextProposalIdForAdminiStrative(headOfficeCode, circleOfficeCode,typeOfAssetCode,ProgrammeCode,subProgrammeCode);
				if(nextProposalId.length()==14)	{
					proposals = myForm.getProposals();
					int size = proposals.size();
					String[] proposalIds = new String[size];
					String firstPart = nextProposalId.substring(0,10);
					String secondPart = nextProposalId.substring(10,14);
					int sno = Integer.parseInt(secondPart);
					String proposalId = null; 
					for(int i=0; i<size; i++){
						if(sno<10)
							secondPart = "000"+sno;
						else
						if(sno<100)
							secondPart = "00"+sno;
						else
						if(sno<1000)
							secondPart = "0"+sno;
						else
							secondPart = String.valueOf(sno);						
						proposalId = firstPart + secondPart;
						proposalHolder = (ProposalHolder)proposals.get(i);
						proposalHolder.setProposalId(proposalId);
						proposals.set(i,proposalHolder);
						sno++;
					}
				}
			}
			else {
				resetProposal(myForm);
			}
			divisions=new ArrayList();
			divisions = rwsOffices.getDivisions(headOfficeCode, circleOfficeCode);
			myForm.setDivisionOfficeCode("0");
			myForm.setSubdivisionOfficeCode("00");
			request.setAttribute("resetForm","true");
		}
	    
	    if(mode != null && mode.equals("subdivisions"))	{
	    	if(!myForm.getSubdivisionOfficeCode().equals("")&& myForm.getSubdivisionOfficeCode()!=null && !myForm.getSubdivisionOfficeCode().equals("00")){
	    		
	    	}else{
		    	session.removeAttribute("subdivisions1");
				session.removeAttribute("selectedHabs");
				session.removeAttribute("tempSelectedAdmnHabs");
				session.removeAttribute("rwsWorkAdmnProgLnkTmp");			
				if(circleOfficeCode!=null && !circleOfficeCode.equals("") && typeOfAssetCode!=null && !typeOfAssetCode.equals("") && ProgrammeCode!=null && !ProgrammeCode.equals("") && subProgrammeCode!=null && !subProgrammeCode.equals("")){
				nextProposalId = proposalDAO.getNextProposalIdForAdminiStrative(headOfficeCode, circleOfficeCode,typeOfAssetCode,ProgrammeCode,subProgrammeCode);
				if(nextProposalId.length()==14)	{
					proposals = myForm.getProposals();
					int size = proposals.size();
					String[] proposalIds = new String[size];
					String firstPart = nextProposalId.substring(0,10);
					String secondPart = nextProposalId.substring(10,14);
					int sno = Integer.parseInt(secondPart);
					String proposalId = null; 
					for(int i=0; i<size; i++){
						if(sno<10)
							secondPart = "000"+sno;
						else
						if(sno<100)
							secondPart = "00"+sno;
						else
						if(sno<1000)
							secondPart = "0"+sno;
						else
							secondPart = String.valueOf(sno);						
						proposalId = firstPart + secondPart;
						proposalHolder = (ProposalHolder)proposals.get(i);
						proposalHolder.setProposalId(proposalId);
						proposals.set(i,proposalHolder);
						sno++;
					}
				}
			}
			else {
				resetProposal(myForm);
			}
			request.setAttribute("resetForm","true");
			headOfficeCode = myForm.getHeadOfficeCode();
			circleOfficeCode = myForm.getCircleOfficeCode();
			divisionOfficeCode = myForm.getDivisionOfficeCode();
			myForm.setSubdivisionOfficeCode("00");
			subdivisions = rwsOffices.getSubdivisions(headOfficeCode, circleOfficeCode, divisionOfficeCode);
	    	}
		}
	    
	    if(mode!=null && mode.equals("assign")){}
	    
	    if(mode!=null && mode.equals("Save")){
	    	session.removeAttribute("divisions1");
	    	session.removeAttribute("subdivisions1");
			session.removeAttribute("selectedHabs");
			session.removeAttribute("tempSelectedAdmnHabs");
			session.removeAttribute("rwsWorkAdmnProgLnkTmp");
			session.removeAttribute("proposalsHabs");
			session.removeAttribute("habsarray");
	    	reset(myForm);	    
	    }
	    
	    if(mode!=null && mode.equals("getSubDivisions1")){
	    	ArrayList subdivisions1 = rwsOffices.getSubdivisions(headOfficeCode, circleOfficeCode, divisionOfficeCode);
	    	session.setAttribute("subdivisions2", subdivisions1);
	    }
	    
	    if(mode!=null && mode.equals("getWorks")){
	    	circles = rwsOffices.getCircles(headOfficeCode);
	 		session.setAttribute("circles",circles);
	 		if(request.getParameter("someCond1")!=null && request.getParameter("someCond1").equals("div")){
	 			ArrayList divisions1 = rwsOffices.getDivisions(headOfficeCode, myForm.getCcode());
		    	session.setAttribute("divisions2", divisions1);
		    	session.removeAttribute("subdivisions2");
	 		}
	 		if(request.getParameter("someCond1")!=null && request.getParameter("someCond1").equals("subdiv")){
		 		ArrayList subdivisions1 = rwsOffices.getSubdivisions(headOfficeCode, myForm.getCcode(), myForm.getDivCode());
		    	session.setAttribute("subdivisions2", subdivisions1);
	 		}
	 		ArrayList expyears = rwsOffices.getExpYears1();
    		session.setAttribute("expyears",expyears);
    		ArrayList schemes = rwsOffices.getAllAssetTypes();
    		session.setAttribute("schemes",schemes);
    		if(request.getParameter("someCond1")!=null && request.getParameter("someCond1").equals("yes")){
	    		ArrayList workslist = rwsOffices.getWorksList(myForm.getCcode(),myForm.getExpyear(),myForm.getScheme(),myForm,myForm.getDivCode(),myForm.getSubDivCode());
	    		myForm.setWorks(workslist);
	    		ArrayList sss = (ArrayList)myForm.getWorks();
	    		session.setAttribute("works",workslist);
	 		}
    		else {
    			session.removeAttribute("works");
    		}
    		target = "getWorks";
	    }
	    
	    if(mode!=null && mode.equals("populateWorkId")){
	    	request.setAttribute("resetForm","false");
	    }
	   if(mode!=null && mode.equals("carryHabs")){
			proposals = myForm.getProposals();
			proposalHolder = (ProposalHolder)proposals.get(0);
			String noHabs = request.getParameter("noOfHabs");
			String proposalId = request.getParameter("proposalId");
			String totHabs = request.getParameter("selHabs");
			String[] habsarray={};
			int lengthHab = 0;
			String tabName1 = "";
		 	user=(RwsUser)session.getAttribute("RWS_USER");			
			if(totHabs!=null){
				if(proposalId!=null){
					String code = proposalId.substring(6,8);				
					habsarray=totHabs.split("@@");				
					session.setAttribute("habsarray",habsarray);				
			 	if(!(code.equals("11")|| code.equals("12"))){
					tabName1 = "rws_hab_selected_temp_tbl";
				}
				else if(code.equals("11")){
					tabName1 = "rws_sch_selected_temp_tbl";
				}
				else if(code.equals("12")){
					tabName1 = "rws_lab_selected_temp_tbl";
				}				
				proposalDAO.saveHabsToTempTable(tabName1,habsarray,session.getId(),proposalId);				
				}
				String[] habCodesarray=new String[habsarray.length];
				lengthHab = habsarray.length;
				for(int arr = 0;arr<lengthHab;arr++){
					if(proposalId.substring(6,8).equals("12") ){
						habCodesarray[arr] = habsarray[arr].substring(0,2);
					}
					else if(proposalId.substring(6,8).equals("11") ){
						if(habsarray[arr]!=null && !habsarray[arr].equals(""))
						habCodesarray[arr] = habsarray[arr].substring(0,20);
					}
					else{
						habCodesarray[arr] = habsarray[arr].substring(0,16);
					}
				}
				session.setAttribute("proposalsHabs",habCodesarray);
				session.setAttribute("proposalId",proposalId);
				proposalHolder.setNoOfHabs(noHabs);
				myForm.setTypeOfAsset(proposalId.substring(6,8));				
				proposalHolder.setProoved(request.getParameter("prooved"));
				session.setAttribute("adminflag",session.getId()+"true");				
			}		 
		}
		
		if(mode != null && mode.equals("showHabs")){
    		ArrayList selectedHabCodes=(ArrayList)session.getAttribute("tempSelectedAdmnHabs");
    		GregorianCalendar gc=new GregorianCalendar();
    		String curr_time=""+gc.getTimeInMillis();
    		String sesid=session.getId()+curr_time.substring(8);
    		ArrayList tempSelectedHabs=proposalDAO.getTempSelectedHabsForAdminSanc2(selectedHabCodes,myForm.getCircleOfficeCode(),sesid);
    		session.setAttribute("selectedHabs", tempSelectedHabs);
			request.setAttribute("resetForm","true");         
		}
		if(circles != null)
			session.setAttribute("circles1", circles);
		if(divisions != null)
			session.setAttribute("divisions1", divisions);
		if(subdivisions != null)
			session.setAttribute("subdivisions1", subdivisions);
		if(assetTypes != null)
			session.setAttribute("assetTypes1", assetTypes);
		if(programmes != null)
			session.setAttribute("programmes1", programmes);
		if(subprogrammes != null)
			session.setAttribute("SubPrograms1", subprogrammes);
		if(workcategory != null)
			session.setAttribute("workcategory1",workcategory);				
		System.gc();			
		return mapping.findForward(target);
	}
	
	public void resetProposal(RepresentativeProposalForm myForm){
		Iterator iterator = myForm.getProposals().iterator();
		ProposalHolder proposalHolder = null;
		while(iterator.hasNext()){
			proposalHolder = (ProposalHolder)iterator.next();
			proposalHolder.setProposalId("");
		} 
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
		myForm.setPrograms("");
		myForm.setSubPrograms("");
		myForm.setWorkCat("");
		myForm.setSubdivisionOfficeCode("");
		myForm.setPlan("");
		myForm.setWrktype("");
		myForm.setAugsch("");
		myForm.setProoved("");
		myForm.setSustainDetails("");
		myForm.setApprooved("");
		myForm.setCoreDashboardStatus("");
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
	
	public void reset1(RepresentativeProposalForm myForm){
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
		myForm.setPrograms("");
		myForm.setSubPrograms("");
		myForm.setWorkCat("");
		myForm.setSubdivisionOfficeCode("");
		myForm.setWrktype("");
		myForm.setAugsch("");
		myForm.setProoved("");
		myForm.setSustainDetails("");
		myForm.setApprooved("");
		myForm.setCoreDashboardStatus("");
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
