package nic.watersoft.proposals;

import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.ArrayList;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class RepresentativeProposalAction extends Action 
{
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String target = new String("insert-success");
		RepresentativeProposalForm myForm = (RepresentativeProposalForm)form;
		
		Connection conn = null;
		Statement stat = null;
		DataSource dataSource = getDataSource(request);
		
		String mode = myForm.getMode();
		String query = null;
		String officeCode = myForm.getHeadOfficeCode() 
						  + myForm.getCircleOfficeCode()
						  + myForm.getDivisionOfficeCode()
						  + myForm.getSubdivisionOfficeCode();
		
		//System.out.println("RepresentativeProposalAction called");
		//System.out.println("User pressed the " + mode + " button.");

		HttpSession session = request.getSession();
		String message = "";
		if(mode != null && mode.equals("Save"))
		{
			try
			{
				conn = dataSource.getConnection();
				conn.setAutoCommit(false);
				stat = conn.createStatement();
										
				Iterator iterator = myForm.getProposals().iterator();
				ProposalHolder proposalHolder = null;
				
				String repDate = myForm.getRepDate();
				
				String datePartRep = repDate.substring(0,2);
				String monthPartRep = repDate.substring(3,5);
				String yearPartRep = repDate.substring(6,10);
				int ddRep = Integer.parseInt(datePartRep);
				int mmRep = Integer.parseInt(monthPartRep);
				int yyRep = Integer.parseInt(yearPartRep);
				GregorianCalendar gCal = new GregorianCalendar(yyRep,mmRep-1,ddRep);
				Date dRepDate = gCal.getTime();
				
				String endorsementDate = myForm.getEndorsementDate();
				
				Date dEndtDate = null;
				int ddEndt = 0, mmEndt = 0, yyEndt =0;
				//System.out.println("1");
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
				//System.out.println("2");
				if(dRepDate.compareTo(currentDate) > 0)
				{	
					flag1 = false;
					message = "Representation Date cannot be greater than current date.\\n";
					target = "failure";
				}
				
				if(dEndtDate != null && dEndtDate.compareTo(currentDate) > 0)
				{	
					flag1 = false;
					message += "Endorsement Date cannot be greater than current date.\\n";
					target = "failure";
				}
				//System.out.println("3");
				if(flag1)
				{
					if(dEndtDate.compareTo(dRepDate) > 0)
					{
						flag1 = false;
						message += "Endorsement Date cannot be greater than Representation Date.\\n";
						target = "failure";
					}
				}
				session.setAttribute("GlobalConstants.Message", message);
				//System.out.println("4");
				if(flag1)
				{
				int total = 0;
				String augmentedWorkId = null;
				//System.out.println("entering while");
				while(iterator.hasNext())
				{
					total++;
					augmentedWorkId = "";
					proposalHolder = (ProposalHolder)iterator.next();
					String isAugmentedWork = proposalHolder.getAugmentation();
					if(isAugmentedWork != null && isAugmentedWork.equals("Y")) 
						augmentedWorkId = proposalHolder.getWorkId();
					
					String ministerFor = myForm.getMinisterFor();
					String others = myForm.getOthers();
					String constituencyCode = myForm.getConstituencyCode();
					if(ministerFor == null)
						ministerFor = "";
					if(others == null)
						others = "";
					if(constituencyCode == null)
						constituencyCode = "";
					
					query = " INSERT INTO rws_rep_proposal_tbl(office_code, rep_code, "
						  + " rep_name, rep_address, rep_date, description, endorsement_no, "
						  + " endorsement_date, endorsed_by, recommendations, proposal_id,"
						  + " proposal_name, no_of_habs, lead_hab_code, "
						  + " type_of_asset, programme_code, subprogramme_code, priority_code, "
						  + " estimate_cost, remarks, augmented_work_id, flag, prepared_by, "
						  + " prepared_on, prepared_at,minister_for,others, constituency_code) VALUES("
						  + " '" + officeCode + "', '" + myForm.getRepCode() + "', "  
						  + " UPPER('" + myForm.getRepName() + "'), " 
						  + " UPPER('" + myForm.getRepAddress() + "'), " 
						  + " TO_DATE('" + myForm.getRepDate() + "', 'dd/mm/yyyy'),"
						  + " UPPER('" + myForm.getDescription() + "'), " 
						  + " UPPER('" + myForm.getEndorsementNo() + "'), "
						  + " TO_DATE('" + myForm.getEndorsementDate() + "', 'dd/mm/yyyy'), "
						  + " UPPER('" + myForm.getEndorsedBy() + "'), " 
						  + " UPPER('" + myForm.getRecommendations() + "'), "  
						  + " '" + proposalHolder.getProposalId() + "', " 
						  + " UPPER('" + proposalHolder.getProposalName() + "'), " 
						  + proposalHolder.getNoOfHabs() + ", "
						  + " '" + request.getParameter(proposalHolder.getProposalId())+"',"
						  + " '" + proposalHolder.getTypeOfAsset() + "', "
						  + " '" + proposalHolder.getProgrammeCode() + "', "
						  + " '" + proposalHolder.getSubprogrammeCode() + "', "
						  + " '" + proposalHolder.getPriorityCode() + "', "
						  + " '" + proposalHolder.getEstimateCost() + "', "
						  + " UPPER('" + proposalHolder.getRemarks() + "'), "
						  + " '" + augmentedWorkId + "', 'N', "
						  + " '" + myForm.getUserId() + "', SYSDATE, "
						  + " '" + myForm.getOfficeCode() + "',"
						  + " '" + ministerFor + "',"
						  + " UPPER('" + others + "'), "
						  + " '" + constituencyCode + "')";
					//System.out.println("query is "+query);
					stat.addBatch(query);
					//System.out.println("testa");			
					String[] habCodes = request.getParameterValues("H_"+proposalHolder.getProposalId());
					//System.out.println("code is "+"H_"+proposalHolder.getProposalId());
					int noOfHabs = 0;
					//System.out.println("testb");
					for (int i = 0; i < habCodes.length; i++)
					{
						//System.out.println("testc");
						query = " INSERT INTO rws_proposal_hab_lnk_tbl(proposal_id, hab_code)" 
							  + " VALUES('" + proposalHolder.getProposalId() + "', " 
							  + " '" + habCodes[i] + "')";
						//System.out.println("query is "+query);
						noOfHabs++;
						total++;
						stat.addBatch(query);
					}
				}
				//System.out.println("out of while");
				int[] updateCounts = stat.executeBatch();

				boolean flag = true;
				for(int i=0; i< total; i++)
				{
					if(updateCounts[i] != 1)
						flag = false;
				}
				//System.out.println("entering if flag");
				if(flag)
				{
					conn.commit();
					conn.setAutoCommit(true);
										
					session.removeAttribute("selectedHabs");
					session.removeAttribute("constituencies");
					session.removeAttribute("RepresentativeProposalForm");
					ProposalDAO proposalDAO = new ProposalDAO(dataSource);
					proposalDAO.deleteTempSelectedHabs();
										
					session.setAttribute("GlobalConstants.Message", "Record(s) inserted successfully!");
				}
			}
				
				session.removeAttribute("tempSelectedRepProposalHabs");
			}
			catch(Exception e)
			{	Debug.writeln("Exception in RepresentativeProposalAction " + e);
				message = "Cannot insert record!";
				session.setAttribute("GlobalConstants.Message", message);
				target = "failure";
			}
			finally
			{
				if(stat != null)
				{	try
					{	stat.close();
					}
					catch(SQLException sqle){ }
				}
				if(conn != null)
				{	try
					{	conn.close();
					}
					catch(SQLException sqle){ }
				}
			}
		}
		else
		if(mode != null && mode.equals("View"))
		{
			RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
			session.removeAttribute("selectedHabs");
			officeCode = user.getOfficeCode();
			ProposalDAO proposalDAO = new ProposalDAO(dataSource);
			ArrayList representativeProposals = proposalDAO.getRepresentativeProposals(officeCode);
			request.setAttribute("representativeProposals", representativeProposals);
			
			target = new String("view-success");
		}
			
		return mapping.findForward(target);
	}
}
