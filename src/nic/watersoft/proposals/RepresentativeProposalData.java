package nic.watersoft.proposals;

import java.util.ArrayList;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.CommonLists;
//import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocationBean;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class RepresentativeProposalData extends Action 
{
	private ArrayList headOffices;
	private ArrayList circles;
	private ArrayList divisions;
	private ArrayList subdivisions;
	private ArrayList representatives;
	private ArrayList constituencies;
	private ArrayList assetTypes;
	private ArrayList programmes;
	private ArrayList subprogrammes;
	private ArrayList priorities;
	private ArrayList proposals;
	

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception
	{
		String target = new String("data-success");
		RepresentativeProposalForm myForm = (RepresentativeProposalForm)form;
		
		DataSource dataSource = getDataSource(request);
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser)session.getAttribute("RWS_USER");
		constituencies = new ArrayList();
		
		//String mode = myForm.getMode();
		String mode=request.getParameter("mode");
		boolean init = myForm.getInit();
		
		//System.out.println("RepresentativeProposalData called");
		
		//System.out.println("User pressed the " + mode + " button.");
				
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
		
		CommonLists commonLists = new CommonLists(dataSource);
		ProposalDAO proposalDAO = new ProposalDAO(dataSource);
		RwsLocations rwsLocations = new RwsLocations(dataSource);
		RwsOffices rwsOffices = new RwsOffices(dataSource);
		ProposalHolder proposalHolder = null;
		
		String nextProposalId = null;
		if(init)
		{
			//System.out.println("Inside if(init)");
			if(circleOfficeCode.equals("00"))
				circles = rwsOffices.getCircles(headOfficeCode);
			if(divisionOfficeCode.equals("0"))
				divisions = rwsOffices.getDivisions(headOfficeCode, circleOfficeCode);
			if(subdivisionOfficeCode.equals("00"))
				subdivisions = rwsOffices.getSubdivisions(headOfficeCode, circleOfficeCode, divisionOfficeCode);
			
			representatives = commonLists.getRepresentatives();
			programmes = commonLists.getProgrammes();
			subprogrammes = new ArrayList(1);
			assetTypes = commonLists.getAssetTypes();
			priorities = commonLists.getPriorities();
			proposalDAO.deleteTempSelectedHabs();
			proposals = new ArrayList(1);
			proposalHolder = new ProposalHolder();
			nextProposalId = proposalDAO.getNextProposalId(headOfficeCode, circleOfficeCode);
			proposalHolder.setProposalId(nextProposalId);
			proposals.add(proposalHolder);
			SimpleDateFormat fmt = new SimpleDateFormat("dd/MM/yyyy");
			String currentDate = fmt.format(new java.util.Date());
			myForm.setRepDate(currentDate);
			myForm.setEndorsementDate(currentDate);
			myForm.setProposals(proposals);
			myForm.setInit(false);
		}
		if(mode != null && mode.equals("init"))
		{
			//System.out.println("in init mode");
			//System.out.println("removing tempSelectedRepProposalHabs from session");
			session.removeAttribute("tempSelectedRepProposalHabs");
		}
		if(mode != null && mode.equals("circles"))
		{
			headOfficeCode = myForm.getHeadOfficeCode();
			circles = rwsOffices.getCircles(headOfficeCode);
			myForm.setCircleOfficeCode("00");
			myForm.setDivisionOfficeCode("0");
			myForm.setSubdivisionOfficeCode("00");
			session.removeAttribute("divisions");
			session.removeAttribute("subdivisions");
		}
		
		if(mode != null && mode.equals("divisions"))
		{
			headOfficeCode = myForm.getHeadOfficeCode();
			circleOfficeCode = myForm.getCircleOfficeCode();
			divisions = rwsOffices.getDivisions(headOfficeCode, circleOfficeCode);
			nextProposalId = proposalDAO.getNextProposalId(headOfficeCode, circleOfficeCode);
			
			proposals = myForm.getProposals();
			int size = proposals.size();
			String[] proposalIds = new String[size];
			String firstPart = nextProposalId.substring(0,8);
			String secondPart = nextProposalId.substring(8,12);
			int sno = Integer.parseInt(secondPart);
			String proposalId = null; 
			for(int i=0; i<size; i++)
			{
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
			
			myForm.setDivisionOfficeCode("0");
			myForm.setSubdivisionOfficeCode("00");
			session.removeAttribute("subdivisions");
		}
		if(mode != null && mode.equals("subdivisions"))
		{
			headOfficeCode = myForm.getHeadOfficeCode();
			circleOfficeCode = myForm.getCircleOfficeCode();
			divisionOfficeCode = myForm.getDivisionOfficeCode();
			myForm.setSubdivisionOfficeCode("00");
			subdivisions = rwsOffices.getSubdivisions(headOfficeCode, circleOfficeCode, divisionOfficeCode);
		}
		
		if(mode != null && mode.equals("constituencies"))
		{
			String repCode = myForm.getRepCode();
			constituencies = new ArrayList();
			if(repCode.equals("01") || repCode.equals("02"))
			{
				constituencies = commonLists.getConstituencies(repCode);
				myForm.setConstituencyCode("");
			}
			else
				session.removeAttribute("constituencies");
		}
		if(mode != null && mode.equals("repname"))
		{
			String repCode = myForm.getRepCode();
			String constituencyCode = myForm.getConstituencyCode();
			String[] details = commonLists.getRepresentativeDetails(repCode, constituencyCode);
			myForm.setRepName(details[0]);
			myForm.setRepAddress(details[1]);
		}

		if(mode != null && mode.equals("Add"))
		{
			proposals = myForm.getProposals();
			int size = proposals.size();
			if(size == 0)
				size = 1;
			//System.out.println("hoc in Add New Work is " + headOfficeCode);
			//System.out.println("coc in Add New Work is " + circleOfficeCode);
			if(circleOfficeCode == "")
				circleOfficeCode = "00";
			
			proposalHolder = (ProposalHolder)proposals.get(size-1);
			String prevProposalId = proposalHolder.getProposalId();
			String dbProposalId = proposalDAO.getNextProposalId(headOfficeCode, circleOfficeCode);
			//System.out.println("prevProposalId: " + prevProposalId);
			//System.out.println("dbProposalId: " + dbProposalId);
			String prevFirstPart = prevProposalId.substring(0,8);
			String prevSecondPart = prevProposalId.substring(8,12);
			String dbFirstPart = dbProposalId.substring(0,8);
			String dbSecondPart = dbProposalId.substring(8,12);
			int prevSNo = Integer.parseInt(prevSecondPart);
			int dbSNo = Integer.parseInt(dbSecondPart);

			//System.out.println("prevFirstPart: " + prevFirstPart);
			//System.out.println("prevSecondPart: " + prevSecondPart);
			//System.out.println("dbFirstPart: " + dbFirstPart);
			//System.out.println("dbSecondPart: " + dbSecondPart);

			//System.out.println("prevSNo: " + prevSNo);
			//System.out.println("dbSNo: " + dbSNo);
			
			nextProposalId = dbProposalId;
			if(prevFirstPart.equals(dbFirstPart))
			{
				if(prevSNo >= dbSNo)
				{
					String temp = null;
					prevSNo = prevSNo+1;
					if(prevSNo < 10)
						temp = "000" + (prevSNo);
					else
					if(prevSNo < 100)
						temp = "00" + (prevSNo);
					else
					if(prevSNo < 1000)
						temp = "0" + (prevSNo);
					else
					if(prevSNo < 10000)
						temp = String.valueOf(prevSNo);	
						
					nextProposalId = prevFirstPart + temp;
				}
			}
			//System.out.println("Next ProposalId: " + nextProposalId);
			
			proposalHolder = new ProposalHolder();
			proposalHolder.setProposalId(nextProposalId);
			proposals.add(proposalHolder);
			myForm.setProposals(proposals);
		}
		if(mode != null && mode.equals("Remove"))
		{
			ArrayList selectedHabs = null;
			proposals = myForm.getProposals();
						
			String[] removeIds = request.getParameterValues("remove");
			if(removeIds != null && removeIds.length != 0)
			{
				for(int p=0; p<removeIds.length; p++)
				{
					//System.out.println("removeIds["+p+"] : " + removeIds[p]);
				}
				selectedHabs = (ArrayList)session.getAttribute("selectedHabs");
				if(selectedHabs != null && selectedHabs.size()!=0)
				{
					RwsLocationBean rwsLocationBean = null; 
					String proposalId = null;			
					for(int i=removeIds.length; i>0; i--)
					{
						//System.out.println("ONE removeIds["+(i-1)+"] : " + removeIds[(i-1)]);
						proposalHolder = (ProposalHolder)proposals.get(Integer.parseInt(removeIds[(i-1)]));
						proposalId = proposalHolder.getProposalId();
						//System.out.println("remove Proposal Id is " + proposalId);
						boolean flag = false;
						for(int j=selectedHabs.size(); j>0; j--)
						{
							rwsLocationBean = (RwsLocationBean)selectedHabs.get(j-1);
							if(rwsLocationBean.getProposalId().equals(proposalId))
							{
								selectedHabs.remove(j-1);
								flag = true;	
							}
							else
								flag = true;
						}
						if(flag)
						proposals.remove(Integer.parseInt(removeIds[(i-1)]));
					}
				}
				else
				{
					for(int i=removeIds.length; i>0; i--)
					{
						proposals.remove(Integer.parseInt(removeIds[i-1]));
					}
				}
				int size = proposals.size();
				
				String dbProposalId = proposalDAO.getNextProposalId(headOfficeCode, circleOfficeCode);
				String dbFirstPart = dbProposalId.substring(0,8);
				String dbSecondPart = dbProposalId.substring(8,12);
				int dbSNo = Integer.parseInt(dbSecondPart);
				String proposalIds[] = new String[size];
				String tempProposalId = null;
				RwsLocationBean rwsLocationBean = null; 
				for(int i=0; i<size; i++)
				{
					//System.out.println("dbSno " + dbSNo);	
					String temp = null;
					if(dbSNo <= 9)
						temp = "000" + (dbSNo);
					else
					if(dbSNo <= 99)
						temp = "00" + (dbSNo);
					else
					if(dbSNo <= 999)
						temp = "0" + (dbSNo);
					else
					if(dbSNo <= 9999)
						temp = String.valueOf(dbSNo);
										
					dbSNo++;
					nextProposalId = dbFirstPart + temp;
					//System.out.println("Next Proposal Id " + nextProposalId);
					proposalHolder = (ProposalHolder)proposals.get(i);
					tempProposalId = proposalHolder.getProposalId();
					//System.out.println("Temp ProposalId " + tempProposalId);
					if(selectedHabs != null)
					{
						for(int j=0; j<selectedHabs.size(); j++)
						{
							rwsLocationBean = (RwsLocationBean)selectedHabs.get(j);
							//System.out.println("rwsLocationBean.getProposalId() : " + rwsLocationBean.getProposalId());
							if(rwsLocationBean.getProposalId().equals(tempProposalId))
							{	//System.out.println("Coming " + j);
								rwsLocationBean.setProposalId(nextProposalId);
								selectedHabs.set(j,rwsLocationBean);
							}
						}
					}
					
					proposalHolder.setProposalId(nextProposalId);
					proposalIds[i] = nextProposalId;
					proposals.set(i,proposalHolder);
				}
				myForm.setProposals(proposals);
				
				session.setAttribute("selectedHabs",selectedHabs);
			}
			else
			{
				String message = "Please select atleast one proposal to remove.";
				session.setAttribute("GlobalConstants.Message",message);
			}
		}
		if(mode != null && mode.equals("subprogrammes"))
		{
			String index = request.getParameter("index");
			int ndx = 0;
			if(index != null)
			{
				try
				{	ndx = Integer.parseInt(index);
				}
				catch(NumberFormatException nfe)
				{	//System.out.println("Error converting index to ndx " + nfe);
				}
			}
			proposals = myForm.getProposals();
			proposalHolder = (ProposalHolder)proposals.get(ndx);
			String programmeCode = proposalHolder.getProgrammeCode();
			subprogrammes = commonLists.getSubprogrammes(programmeCode);
			proposalHolder.setSubprogrammes(subprogrammes);
			proposals.set(ndx, proposalHolder);
		}
		
		if(mode != null && mode.equals("showHabs"))
		{
			//System.out.println("In showHabs............");
			ArrayList tempSelectedHabs = proposalDAO.getTempSelectedHabs();
			session.setAttribute("selectedHabs", tempSelectedHabs);
			//session.setAttribute("tempSelectedRepProposalHabs",tempSelectedHabs);
		}
		
		if(circles != null)
			session.setAttribute("circles", circles);
		if(divisions != null)
			session.setAttribute("divisions", divisions);
		if(subdivisions != null)
			session.setAttribute("subdivisions", subdivisions);
		
		session.setAttribute("representatives", representatives);
		if(constituencies != null && constituencies.size()>0)
			session.setAttribute("constituencies", constituencies);
		session.setAttribute("assetTypes", assetTypes);
		session.setAttribute("programmes", programmes);
		session.setAttribute("priorities", priorities);
				
		return mapping.findForward(target);
	}
}
