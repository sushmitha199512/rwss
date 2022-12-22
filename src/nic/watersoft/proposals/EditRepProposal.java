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
//import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class EditRepProposal extends Action
{
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse resposne) throws Exception
	{
		String target = new String("success");
		String query = null;
		RepresentativeProposalForm myForm = (RepresentativeProposalForm)form;
		DataSource dataSource = getDataSource(request);
		CommonLists commonLists = new CommonLists(dataSource);
		ProposalDAO proposalDAO = new ProposalDAO(dataSource);
				
		String proposalId = request.getParameter("proposalId");
		//System.out.println("proposalId is " + proposalId);
		String mode = myForm.getMode();
		//System.out.println("User action is " + mode);

		HttpSession session = request.getSession();
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");

		String officeCode = user.getOfficeCode();
		String repCode = null, constituencyCode = null;
		if(mode != null)
		{
			if(mode.equals("View"))
			{
				ArrayList representativeProposals = proposalDAO.getRepView(officeCode);
				request.setAttribute("representativeProposals", representativeProposals);
				target = new String("view-success");
			}
			else
			if(mode.equals("ENDRS"))
			{	
				request.setAttribute("type",request.getParameter("type"));
				target = new String("edit-success");
			}
			else
			if(mode.equals("constituencies"))
			{	
				request.setAttribute("type",request.getParameter("type"));
				repCode = myForm.getRepCode();
				if(repCode.equals("01") || repCode.equals("02"))
					session.setAttribute("constituencies",commonLists.getConstituencies(repCode));
				else
					session.removeAttribute("constituencies");
				myForm.setRepName("");
				myForm.setRepAddress("");
				target = new String("edit-success");
			}
			else
			if(mode.equals("repname"))
			{
				request.setAttribute("type",request.getParameter("type"));
				repCode = myForm.getRepCode();
				constituencyCode = myForm.getConstituencyCode();
				String[] repDetails = commonLists.getRepresentativeDetails(repCode, constituencyCode);
				myForm.setRepName(repDetails[0]);
				myForm.setRepAddress(repDetails[1]);
				target = new String("edit-success");
			}
			else
			if(mode.equals("subprogrammes"))
			{
				request.setAttribute("type",request.getParameter("type"));
				ArrayList proposals = myForm.getProposals();
				ProposalHolder proposalHolder = (ProposalHolder)proposals.get(0);
				String programmeCode = proposalHolder.getProgrammeCode();
				ArrayList subprogrammes = commonLists.getSubprogrammes(programmeCode);
				proposalHolder.setSubprogrammes(subprogrammes);
				target = new String("edit-success");
			}
			else
			if(mode.equals("showHabs"))
			{	
				request.setAttribute("type",request.getParameter("type"));
				proposalId = request.getParameter("proposalId");
				//System.out.println("Proposal Id in showhabs " + proposalId);
				//System.out.println("proposalDAO.getTempSelectedHabs(proposalId)" + proposalDAO.getTempSelectedHabs(proposalId).size());
				session.removeAttribute("newhabitations");
				session.setAttribute("habs", proposalDAO.getTempSelectedHabs(proposalId));
				target = new String("edit-success");
			}
			else
			if(mode.equals("Update"))
			{
				//System.out.println("In Update");
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
				if(endorsementDate != null && endorsementDate.length() == 10)
				{
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
				if(dRepDate.compareTo(currentDate) > 0)
				{	
					flag1 = false;
					message = "Representation Date cannot be greater than current date.\\n";
					target = "edit-success";
				}
				
				if(dEndtDate != null && dEndtDate.compareTo(currentDate) > 0)
				{	
					flag1 = false;
					message += "Endorsement Date cannot be greater than current date.\\n";
					target = "edit-success";
				}
				
				if(flag1)
				{
					if(dEndtDate.compareTo(dRepDate) > 0)
					{
						flag1 = false;
						message += "Endorsement Date cannot be greater than Representation Date.\\n";
						target = "edit-success";
					}
				}
				if(message != null && message.length() > 0)
				session.setAttribute("GlobalConstants.Message", message);
				if(flag1)
				{
					Connection conn = dataSource.getConnection();
					Statement stat = conn.createStatement(); 
					ArrayList works = myForm.getProposals();
					Iterator iter = works.iterator();
					String[] habCodes = request.getParameterValues("habCodes");
					int habCount = habCodes.length;
					while (iter.hasNext())
					{
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
							  //+ " augmented_work_id = '" + element.getAugemented + "', "
							  + " WHERE proposal_id = '" + element.getProposalId() + "'";
						//System.out.println("The Update Query is " + query);
						stat.addBatch(query);
											
						for(int i=0; i<habCodes.length; i++)
						{
							query = " DELETE FROM rws_proposal_hab_lnk_tbl "
								  + " WHERE proposal_id='" + element.getProposalId() + "'";
							stat.addBatch(query);
						}
						for(int i=0; i<habCodes.length; i++)
						{
							query = " INSERT INTO rws_proposal_hab_lnk_tbl "
								  + " (proposal_id,hab_code) VALUES("
								  + " '" + element.getProposalId() + "',"
								  + " '" + habCodes[i] + "')";
								  
							stat.addBatch(query);
						}
						int[] updateCounts = stat.executeBatch();
						boolean flag = true;
						for(int i=0; i<updateCounts.length; i++)
						{
							if(updateCounts[i] != 1)
								flag = false;
						}
						
						if(flag)
						{
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
			else
			if(proposalId != null && mode != null)
			{
				if(mode.equals("Delete"))
				{
					
					boolean flag = proposalDAO.deleteRepProposal(proposalId);
					ArrayList representativeProposals = proposalDAO.getRepView(officeCode);
					if(flag)
						session.setAttribute("GlobalConstants.Message","Proposal successfully deleted!");
					else
						session.setAttribute("GlobalConstants.Message","Cannot delete proposal!");
					
					request.setAttribute("representativeProposals", representativeProposals);
				}
				else
				if(mode.equals("Edit"))
				{
					//System.out.println("In Edit");
					
					ProposalDTO proposalDTO = proposalDAO.getRepEditData(proposalId);
					ArrayList habs = proposalDAO.getSelectedHabitations(proposalId);
					//System.out.println("habs size is "+habs.size());
					repCode = proposalDTO.getRepCode();
					constituencyCode = proposalDTO.getConstituencyCode();
					proposalDAO.deleteTempSelectedHabs();
					myForm.setRepCode(repCode);
					myForm.setRepName(proposalDTO.getRepName());
					myForm.setRepAddress(proposalDTO.getRepAddress());
					myForm.setRepDate(proposalDTO.getRepDate());
					myForm.setDescription(proposalDTO.getDescription());
					myForm.setEndorsedBy(proposalDTO.getEndorsedBy());
					myForm.setEndorsementNo(proposalDTO.getEndorsementNo());
					myForm.setEndorsementDate(proposalDTO.getEndorsementDate());
					myForm.setRecommendations(proposalDTO.getRecommendations());
					myForm.setLeadHabitation(proposalDTO.getLeadHabitation());
					
					ProposalHolder proposalHolder = new ProposalHolder();
					proposalHolder.setProposalName(proposalDTO.getProposalName());
					proposalHolder.setProposalId(proposalDTO.getProposalId());
					proposalHolder.setNoOfHabs(proposalDTO.getNoOfHabs());
					
					String programmeCode = "0";
					if(proposalDTO.getProgrammeCode() != null && proposalDTO.getProgrammeCode().length()>0)
						programmeCode = proposalDTO.getProgrammeCode();
					
					//System.out.println("Programme Code is " + programmeCode);
					//System.out.println("Sub Programme Code is " + proposalDTO.getSubprogrammeCode());
					proposalHolder.setProgrammeCode(programmeCode);
					proposalHolder.setSubprogrammeCode(proposalDTO.getSubprogrammeCode());
					proposalHolder.setPriorityCode(proposalDTO.getPriorityCode());
					proposalHolder.setTypeOfAsset(proposalDTO.getTypeOfAsset());
					proposalHolder.setEstimateCost(proposalDTO.getEstimateCost());
					proposalHolder.setRemarks(proposalDTO.getRemarks());
					
					ArrayList proposals = new ArrayList();
					proposals.add(proposalHolder);
					myForm.setProposals(proposals);
					
					session.setAttribute("representatives", commonLists.getRepresentatives());
					
					if(repCode.equals("01") || repCode.equals("02"))
					{
						session.setAttribute("constituencies",commonLists.getConstituencies(repCode));
						myForm.setConstituencyCode(constituencyCode);
					}
					
					session.setAttribute("programmes", commonLists.getProgrammes());
					ArrayList subprogrammes = commonLists.getSubprogrammes(programmeCode);
					//System.out.println("subprogrammes.size() " + subprogrammes.size());
					if(subprogrammes!=null && subprogrammes.size()>0)
						proposalHolder.setSubprogrammes(subprogrammes);
					
					session.setAttribute("priorities", commonLists.getPriorities());
					session.setAttribute("assetTypes", commonLists.getAssetTypes());
					
					//code commented on 171207
					//if(session.getAttribute("habs") == null)
					session.setAttribute("habs", habs);
					
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