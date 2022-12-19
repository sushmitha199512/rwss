package nic.watersoft.proposals;

import java.sql.Connection;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
//import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.works.WorksDAO;
import nic.watersoft.works.rws_works_factory;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class EditAdminSanctionForm extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse resposne) throws Exception {
		String target = new String("success");
		String query = null;
		RepresentativeProposalForm myForm = (RepresentativeProposalForm)form;
		DataSource dataSource = getDataSource(request);
		CommonLists commonLists = new CommonLists(dataSource);
		ProposalDAO proposalDAO = new ProposalDAO(dataSource);				
		String proposalId = request.getParameter("proposalId");
		String mode = myForm.getMode();
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
		String officeCode = user.getOfficeCode();
		String repCode = null, constituencyCode = null;
		if(mode != null) {			
			if(mode != null && mode.equals("subprogrammes")) {
				 try {
					 String programmeCode = myForm.getPrograms();
					 ArrayList	subprogrammes = commonLists.getSubprogrammes(programmeCode);
					 session.setAttribute("SubPrograms",subprogrammes);
				 } catch(Exception e){
				 	System.out.println("The Exception is in EditAdminSanctionForm "+e.getMessage());
				 }
			}
			
			if(mode!=null && mode.equals("getWorks1")){
		    	RwsOffices RwsOffices = new RwsOffices();
		 		ArrayList circles = RwsOffices.getCircles("1");
		 		session.setAttribute("circles",circles);
		 		ArrayList expyears = RwsOffices.getExpYears();
	    		session.setAttribute("expyears",expyears);
	    		ArrayList schemes = RwsOffices.getAllAssetTypes();
	    		session.setAttribute("schemes",schemes);
	    		ArrayList workslist = RwsOffices.getWorksList(request.getParameter("dcode"),request.getParameter("expyear"),request.getParameter("scode"),myForm,"","");
	    		myForm.setWorks(workslist);
	    		ArrayList sss = (ArrayList)myForm.getWorks();
	    		session.setAttribute("works",workslist);
	    		target = new String("getWorks1");
		    }
			
			if(mode!=null && mode.equals("populateWorkId")){
		    	request.setAttribute("resetForm","false");
		    	target = new String("edit-success");
		    }
			
			if(mode!=null && mode.equals("carryHabs")){
				String habss = request.getParameter("habs");
				String[] habs = habss.split(",");
				ArrayList proposals = myForm.getProposals();
				proposals = myForm.getProposals();
				ProposalHolder proposalHolder = (ProposalHolder)proposals.get(0);
				String noHabs = request.getParameter("noOfHabs");
				proposalHolder.setNoOfHabs(noHabs);
				session.setAttribute("habs", proposalDAO.getTempSelectedHabsForAdminSancEdit1(habs));
				target = new String("edit-success");
			}
			
			if(mode!=null && mode.equals("carrySchools")){
				String schoolss = request.getParameter("habs");
				String[] schools = schoolss.split(",");
				ArrayList proposals = myForm.getProposals();
				proposals = myForm.getProposals();
				ProposalHolder proposalHolder = (ProposalHolder)proposals.get(0);
				String noSchools = request.getParameter("noOfSchools");
				proposalHolder.setNoOfHabs(noSchools);
			}
			
			if(mode!=null && mode.equals("carryLabs")){
				String labss = request.getParameter("habs");
				String[] labs = labss.split(",");
				ArrayList proposals = myForm.getProposals();
				proposals = myForm.getProposals();
				ProposalHolder proposalHolder = (ProposalHolder)proposals.get(0);
				String noLabs = request.getParameter("noOfLabs");
				proposalHolder.setNoOfHabs(noLabs);
			}

			if(mode.equals("View"))	{
				ArrayList representativeProposals = proposalDAO.getRepView(officeCode);
				request.setAttribute("representativeProposals", representativeProposals);
				target = new String("view-success");
			}
			
		  	else if(mode.equals("subprogrammes")){
				request.setAttribute("type",request.getParameter("type"));
				ArrayList proposals = myForm.getProposals();
				ProposalHolder proposalHolder = (ProposalHolder)proposals.get(0);
				String programmeCode = proposalHolder.getProgrammeCode();
				ArrayList subprogrammes = commonLists.getSubprogrammes(programmeCode);
				proposalHolder.setSubprogrammes(subprogrammes);
				target = new String("edit-success");
			}
			
			else if(mode.equals("showHabs")){	
				request.setAttribute("type",request.getParameter("type"));
				proposalId = request.getParameter("proposalId");
				String plan=proposalDAO.planName(proposalId);				
				String aug=proposalDAO.augName(proposalId);
				request.setAttribute("plan",plan);
				request.setAttribute("wrkType",aug);
				session.removeAttribute("newhabitations");
				target = new String("edit-success");
			}
			
			else if(mode.equals("Update"))	{
				String message = "";
				String repDate = myForm.getRepDate();
				String endorsementDate = myForm.getEndorsementDate();				
				String datePartRep = repDate.substring(0,2);
				String monthPartRep = repDate.substring(3,5);
				String yearPartRep = repDate.substring(6,10);
				int ddRep = Integer.parseInt(datePartRep);
				int mmRep = Integer.parseInt(monthPartRep);
				int yyRep = Integer.parseInt(yearPartRep);
				GregorianCalendar gCal = new GregorianCalendar(yyRep,mmRep-1,ddRep);
				Date dRepDate = gCal.getTime();								
				Date dEndtDate = null;
				int ddEndt = 0, mmEndt = 0, yyEndt =0;
				if(endorsementDate != null && endorsementDate.length() == 10){
					String datePartEndt = endorsementDate.substring(0,2);
					String monthPartEndt = endorsementDate.substring(3,5);
					String yearPartEndt = endorsementDate.substring(6,10);
					ddEndt = Integer.parseInt(datePartEndt);
					mmEndt = Integer.parseInt(monthPartEndt);
					yyEndt = Integer.parseInt(yearPartEndt);
					gCal = new GregorianCalendar(yyEndt,mmEndt-1,ddEndt);			
					dEndtDate = gCal.getTime();
				}												
				Date currentDate = new Date();				
				boolean flag1 = true;
				if(dRepDate.compareTo(currentDate) > 0)	{	
					flag1 = false;
					message = "Representation Date cannot be greater than current date.\\n";
					target = "edit-success";
				}				
				if(dEndtDate != null && dEndtDate.compareTo(currentDate) > 0){	
					flag1 = false;
					message += "Endorsement Date cannot be greater than current date.\\n";
					target = "edit-success";
				}				
				if(flag1){
					if(dEndtDate.compareTo(dRepDate) > 0){
						flag1 = false;
						message += "Endorsement Date cannot be greater than Representation Date.\\n";
						target = "edit-success";
					}
				}
				if(message != null && message.length() > 0)
				session.setAttribute("GlobalConstants.Message", message);
				if(flag1){
					Connection conn = dataSource.getConnection();
					Statement stat = conn.createStatement(); 
					ArrayList works = myForm.getProposals();
					Iterator iter = works.iterator();
					String[] habCodes = request.getParameterValues("habCodes");
					int habCount = habCodes.length;
					while (iter.hasNext()){
						ProposalHolder element = (ProposalHolder) iter.next();
						query = " UPDATE rws_rep_proposal_tbl SET "
							  + " rep_code = '" + myForm.getRepCode() + "', "
							  + " rep_name = '" + myForm.getRepName() + "', "
							  + " rep_address = '" + myForm.getRepAddress() + "', "
							  + " rep_date=TO_DATE('"+myForm.getRepDate()+"','dd/mm/yyyy'),"
							  + " description = '" + myForm.getDescription() + "', "
							  + " endorsement_no = '" + myForm.getEndorsementNo() + "', "
							  + " endorsement_date=TO_DATE('"+myForm.getEndorsementDate()+"','dd/mm/yyyy'),"
							  + " endorsed_by = '" + myForm.getEndorsedBy() + "', "
							  + " recommendations = '" + myForm.getRecommendations() + "', "
							  + " proposal_name = '" + element.getProposalName() + "', "
							  + " no_of_habs = " + habCount + ", "
							  + " lead_hab_code ='" + request.getParameter(element.getProposalId())+ "',"
							  + " type_of_asset = '" + element.getTypeOfAsset() + "', "
							  + " programme_code = '" + element.getProgrammeCode() + "', "
							  + " subprogramme_code = '" + element.getSubprogrammeCode() + "', "
							  + " priority_code = '" + element.getPriorityCode() + "', "
							  + " estimate_cost = '" + element.getEstimateCost() + "', "
							  + " remarks = '" + element.getRemarks() + "' "
							  + " WHERE proposal_id = '" + element.getProposalId() + "'";
						stat.addBatch(query);
						
						for(int i=0; i<habCodes.length; i++){
							query = " DELETE FROM rws_proposal_hab_lnk_tbl "
								  + " WHERE proposal_id='" + element.getProposalId() + "'";
							stat.addBatch(query);
						}
						
						for(int i=0; i<habCodes.length; i++){
							query = " INSERT INTO rws_proposal_hab_lnk_tbl "
								  + " (proposal_id,hab_code) VALUES(" + " '" + element.getProposalId() + "'," + " '" + habCodes[i] + "')";
							stat.addBatch(query);
						}
						
						int[] updateCounts = stat.executeBatch();
						boolean flag = true;
						
						for(int i=0; i<updateCounts.length; i++){
							if(updateCounts[i] != 1)
								flag = false;
						}
						
						if(flag){
							conn.commit();
							session.removeAttribute("habs");
						}
						
						conn.setAutoCommit(true);
					}
					String type= request.getParameter("type");
					if(type != null && !type.equals("null") && type.length()!=0)
						target = new String("cons-update-success");
					else
						target = new String("update-success");
				}
			}
			
			else if(proposalId != null && mode != null)	{
				if(mode.equals("Delete")){					
					boolean flag = proposalDAO.deleteRepProposal(proposalId);
					ArrayList representativeProposals = proposalDAO.getRepView(officeCode);
					if(flag)
						session.setAttribute("GlobalConstants.Message","Proposal successfully deleted!");
					else
						session.setAttribute("GlobalConstants.Message","Cannot delete proposal!");
					
					request.setAttribute("representativeProposals", representativeProposals);
				}
				else if(mode.equals("Edit")){
				    WorksDAO dao = rws_works_factory.createWorksDAO(getDataSource(request));
			       	ArrayList statuss = dao.getWorkPhysicalStatus(request.getParameter("proposalId"));
			       	if(statuss!=null) {
			       		if(statuss.get(0).equals("Financially Completed") || statuss.get(0).equals("Commissioned") || statuss.get(0).equals("Completed")){
		       				request.setAttribute("message","This work Cannot be Edited - This work already Completed or Commissioned or FinanciallyCompleted");
		       				return mapping.findForward("edit-failed");
		       			}
		       		}
					ArrayList adminWork = proposalDAO.getAdminstrativeSanctionList1(request.getParameter("proposalId"),officeCode,"",myForm.getCircleOfficeCode(),myForm.getDivisionOfficeCode(),myForm.getSubdivisionOfficeCode(),myForm.getWorkCat(),myForm.getTypeOfAsset(),myForm.getPrograms(),myForm.getSubPrograms());
					ProposalDTO proposalDTO =(ProposalDTO)adminWork.get(0);
					String pid=request.getParameter("proposalId");
					String code=pid.substring(6,8);
					String tabName1="";
					user=(RwsUser)session.getAttribute("RWS_USER");
					if(!(code.equals("11")|| code.equals("12"))){
						tabName1 = "tab_"+user.getUserId()+"_temp";
					}
					else if(code.equals("11")){
						tabName1 = "tab_"+user.getUserId()+"_temp_school";
					}
					else if(code.equals("12")){
						tabName1 = "tab_"+user.getUserId()+"_temp_lab";
					}
					proposalDAO.deleteTempSelectedHabs(tabName1);
					proposalDAO=new ProposalDAO(getDataSource(request));
					boolean flag = true;
					if(request.getParameter("flag")!=null && request.getParameter("flag").equals("false"))flag=false;
					ArrayList habs = proposalDAO.getSelectedHabitationsForAdminStrative(proposalId,tabName1,flag);
					String[] habs1 = proposalDAO.getSelectedHabitationsForAdminStrative1(proposalId,tabName1,habs.size());
					repCode = proposalDTO.getRepCode();
					myForm.setLeadHabitation(proposalDTO.getLeadHabitation());
					myForm.setTypeOfAsset(proposalDTO.getTypeOfAsset());
					myForm.setPrograms(proposalDTO.getProgrammeName());
					myForm.setSubPrograms(proposalDTO.getSubprogrammeName());
					myForm.setCircleOfficeCode(proposalDTO.getCircleOfficeCode());
					myForm.setCircleOfficeName(proposalDTO.getCircleOfficeName());
					myForm.setDivisionOfficeCode(proposalDTO.getDivisionOfficeCode());
					myForm.setDivisionOfficeName(proposalDTO.getDivisionOfficeName());
					myForm.setSubdivisionOfficeCode(proposalDTO.getSubdivisionOfficeCode());
					myForm.setSubdivisionOfficeName(proposalDTO.getSubdivisionOfficeName());
					myForm.setWorkCat(proposalDTO.getWorkCat());
					myForm.setPlan(proposalDTO.getPlan());
					myForm.setWrktype(proposalDTO.getWrkType());
					myForm.setAugsch(proposalDTO.getAugsch());
					myForm.setProoved(proposalDTO.getProoved());
					myForm.setLeadHabitation(proposalDTO.getLeadHabitation());
					myForm.setCoreDashboardStatus(proposalDTO.getCoreDashboardStatus());
					myForm.setApprooved(proposalDTO.getApprooved());
					session.setAttribute("leads",proposalDTO.getLeadHabitation());					
					ProposalHolder proposalHolder = new ProposalHolder();
					proposalHolder.setProposalName(proposalDTO.getProposalName());
					proposalHolder.setProposalId(proposalDTO.getProposalId());
					proposalHolder.setNoOfHabs(proposalDTO.getNoOfHabs());						
					String programmeCode = "0";									
					proposalHolder.setTypeOfAsset(proposalDTO.getTypeOfAsset());
					proposalHolder.setSanctionAmout(proposalDTO.getSanctionedAmount());
					proposalHolder.setSpillOver(proposalDTO.getSpillOver());
					proposalHolder.setEstimateCost(proposalDTO.getEstimateCost());
					proposalHolder.setRemarks(proposalDTO.getRemarks());
					proposalHolder.setAdminiStrativeNum(proposalDTO.getAdminNo());
					proposalHolder.setAdminiStrativeDate(proposalDTO.getAdminDate());
					proposalHolder.setWorkCat(proposalDTO.getWorkCat());
					proposalHolder.setAugsch(proposalDTO.getAugsch());
					proposalHolder.setProoved(proposalDTO.getProoved());
					proposalHolder.setCoreDashboardStatus(proposalDTO.getCoreDashboardStatus());
					proposalHolder.setApprooved(proposalDTO.getApprooved());
					ArrayList proposals = new ArrayList();
					proposals.add(proposalHolder);
					myForm.setProposals(proposals);						
					session.setAttribute("programmes", commonLists.getProgrammes());
					ArrayList subprogrammes = commonLists.getSubprogrammes(programmeCode);
					session.setAttribute("assetTypes", commonLists.getAssetTypes());
					session.setAttribute("habs", habs);
					session.setAttribute("habs1", habs1);
					session.setAttribute("nextProposalId", proposalId);
					String type = request.getParameter("type");
					request.setAttribute("type",type);
					target = new String("edit-success");						
				}				
			}
		}
		else
			target = new String("unknown-url");
       		return mapping.findForward(target);
		}
	}