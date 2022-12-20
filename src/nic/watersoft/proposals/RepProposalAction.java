package nic.watersoft.proposals;

import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import nic.watersoft.commons.RwsUser;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class RepProposalAction extends Action 
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
				//System.out.println("Endorsement Date is " + endorsementDate);
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
				
				//System.out.println("dRepDate " + dRepDate);
				//System.out.println("currentDate " + currentDate);
				boolean flag1 = true;
				
				//System.out.println("dRepDate.compareTo(currentDate): "+ dRepDate.compareTo(currentDate));
				if(dRepDate.compareTo(currentDate) > 0)
				{	//System.out.println("YYYYYYYYYY");
					flag1 = false;
					message = "Representative Date cannot be greater than current date.\\n";
					target = "failure";
				}
				
				if(dEndtDate != null && dEndtDate.compareTo(currentDate) > 0)
				{	//System.out.println("ZZZZZZZZZZ");
					flag1 = false;
					message += "Endorsement Date cannot be greater than current date.\\n";
					target = "failure";
				}
				
				if(flag1)
				{
					if(dEndtDate.compareTo(dRepDate) > 0)
					{
						flag1 = false;
						message += "Endorsement Date cannot be greater than Representative Date.\\n";
						target = "failure";
					}
				}
				session.setAttribute("GlobalConstants.Message", message);
				
				if(flag1)
				{
				int total = 0;
				String augmentedWorkId = null;
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
					if(ministerFor == null)
						ministerFor = "";
					if(others == null)
						others = "";
					
					query = " INSERT INTO rws_rep_proposal_tbl(office_code, rep_code, "
						  + " rep_name, rep_address, rep_date, description, endorsement_no, "
						  + " endorsement_date, endorsed_by, recommendations, proposal_id,"
						  + " proposal_name, no_of_habs, lead_hab_code, "
						  + " type_of_asset, programme_code, subprogramme_code, priority_code, "
						  + " estimate_cost, remarks, augmented_work_id, flag, prepared_by, "
						  + " prepared_on, prepared_at,minister_for,others) VALUES("
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
						  + " '" + myForm.getEmployeeCode() + "', SYSDATE, "
						  + " '" + myForm.getOfficeCode() + "',"
						  + " '" + ministerFor + "',"
						  + " UPPER('" + others + "'))";
						  
					stat.addBatch(query);
					//System.out.println("The Representative Proposal Insert Query is : ");
					//System.out.println(query);
					
					String[] habCodes = request.getParameterValues("H_"+proposalHolder.getProposalId());
					int noOfHabs = 0;
					for (int i = 0; i < habCodes.length; i++)
					{
						query = " INSERT INTO rws_proposal_hab_lnk_tbl(proposal_id, hab_code)" 
							  + " VALUES('" + proposalHolder.getProposalId() + "', " 
							  + " '" + habCodes[i] + "')";
						//System.out.println("HAB query is ");
						//System.out.println(query);
						noOfHabs++;
						total++;
						stat.addBatch(query);
					}
				}
			
				int[] updateCounts = stat.executeBatch();
				//System.out.println("Total is : " + total);
				boolean flag = true;
				for(int i=0; i< total; i++)
				{
					if(updateCounts[i] != 1)
						flag = false;
				}
				if(flag)
				{
					conn.commit();
					conn.setAutoCommit(true);
					Enumeration attributeNames = session.getAttributeNames();
					//System.out.println("Before Removing Attributes");
					while(attributeNames.hasMoreElements())
					{
						//System.out.println("Attribute Name: " + attributeNames.nextElement());
					}
					
					session.removeAttribute("selectedHabs");
					session.removeAttribute("constituencies");
					session.removeAttribute("RepresentativeProposalForm");
					attributeNames = session.getAttributeNames();
					//System.out.println("After Removing Attributes");
					while(attributeNames.hasMoreElements())
					{
						//System.out.println("Attribute Name: " + attributeNames.nextElement());
					}
					session.setAttribute("GlobalConstants.Message", "Record(s) inserted successfully!");
				}
			}
			}
			catch(Exception e)
			{	//System.out.println("Exception in RepresentativeProposalAction " + e);
				message = "Cannot insert record!";
				message = "\\n"+e.getMessage();
				session.setAttribute("GlobalConstants.Message", message);
				target = "failure";
			}
			finally
			{
				if(stat != null)
				{	try
					{	stat.close();
					}
					catch(SQLException sqle)
					{	//System.out.println(sqle);
					}
				}
				if(conn != null)
				{	try
					{	conn.close();
					}
					catch(SQLException sqle)
					{	//System.out.println(sqle);
					}
				}
			}
		}
		else
		if(mode != null && mode.equals("View"))
		{
			RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
			officeCode = user.getOfficeCode();
			//System.out.println("officeCode in rep view is " + officeCode);
			ProposalDAO proposalDAO = new ProposalDAO(dataSource);
			ArrayList representativeProposals = proposalDAO.getRepresentativeProposals(officeCode);
			request.setAttribute("representativeProposals", representativeProposals);

			target = new String("view-success");
		}
			
		return mapping.findForward(target);
	}
}
