package nic.watersoft.pushkar;

import java.util.ArrayList;
import java.util.Iterator;
import java.io.File;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.CommonLists;
import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.drought.DroughtDAOMessage;
import nic.watersoft.pushkar.PushkarHolder;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class Rws_PushkarGhat_WorkEntry_frm extends Action {
	
	

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.gc();
		
		ArrayList circles = null;
		ArrayList divisions = null;
		ArrayList subdivisions = null;
		ArrayList programmes = null;
		ArrayList subprogrammes = null;
		ArrayList proposals = null;
		ArrayList mandals = null;
		ArrayList subdivisions1=null;
		ArrayList habitations=null;
		ArrayList panchayats=null;
		ArrayList pushkars=null;
		HttpSession session = request.getSession();
		if (session == null)
			return mapping.findForward("expire");

		
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");

		String target = new String("data-success");
		
		

		Rws_PushkarWorkForm myForm = (Rws_PushkarWorkForm) form;

		if (myForm == null)
			return mapping.findForward("expire");
		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId()) ))) {
			return mapping.findForward("unAuthorise");	
		}
		DataSource dataSource = getDataSource(request);

		
		

		String mode = myForm.getMode();


		if (myForm.getWrktype() != null && myForm.getWrktype().equals("2")) {
			request.setAttribute("special", "1");
		} else {
			request.setAttribute("special", "0");
		}
		String headOfficeCode = myForm.getHeadOfficeCode();
		String circleOfficeCode = myForm.getCircleOfficeCode();
		String divisionOfficeCode = myForm.getDivisionOfficeCode();
		String subdivisionOfficeCode = myForm.getSubdivisionOfficeCode();
		String mandalcode=myForm.getMandalCode();
		String panchcode=myForm.getPanchCode();
		if (headOfficeCode == null)
			headOfficeCode = user.getHeadOfficeCode();
		if (circleOfficeCode == null)
			circleOfficeCode = user.getCircleOfficeCode();
		if (divisionOfficeCode == null)
			divisionOfficeCode = user.getDivisionOfficeCode();
		if (subdivisionOfficeCode == null)
			subdivisionOfficeCode = user.getSubdivisionOfficeCode();

		

		CommonLists commonLists = new CommonLists(dataSource);
		Rws_PushkarDAO proposalDAO = new Rws_PushkarDAO(dataSource);
		RwsOffices rwsOffices = new RwsOffices(dataSource);
		PushkarHolder proposalHolder = null;
		String nextProposalId = null;
		String ProgrammeCode = myForm.getPrograms();
		String subProgrammeCode = myForm.getSubPrograms();
		if (mode != null && mode.equals("null"))
		{
			reset(myForm);
			
			session.removeAttribute("programmes1");
			session.removeAttribute("SubPrograms1");
			session.removeAttribute("circles1");
			session.removeAttribute("divisions1");
			session.removeAttribute("subdivisions1");
			session.removeAttribute("selectedHabs");
			session.removeAttribute("proposalsHabs");
			session.removeAttribute("habsarray");
			session.removeAttribute("AddNewForRev");
			
			proposals = new ArrayList(1);
			proposalHolder = new PushkarHolder();
			proposalHolder.setProposalId(nextProposalId);
			proposals.add(proposalHolder);
			SimpleDateFormat fmt = new SimpleDateFormat("dd/MM/yyyy");
			String currentDate = fmt.format(new java.util.Date());
			myForm.setProposals(proposals);
			myForm.setInit(false);
		}
		
		if (mode != null && mode.equals("programmes")) {
			
			try {
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
					programmes = proposalDAO.getProgrammes1(myForm.getPlan(),
							myForm.getWrktype(), myForm.getWorkCat());				
			} catch (Exception e) {
				Debug.println("exception is " + e);
			}
			request.setAttribute("resetForm", "true");
		}
		if (mode != null && mode.equals("subprogrammes")) {
			System.out.println("inside");
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
			try {
				String programmeCode = myForm.getPrograms();
				
				subProgrammeCode = myForm.getSubPrograms();
				

				if (programmeCode != null && !programmeCode.equals("")) {
					circles = new ArrayList();
					circles = proposalDAO.getCircles(headOfficeCode);

					divisions = new ArrayList();
					divisions = rwsOffices.getDivisions(headOfficeCode,
							circleOfficeCode);

					subdivisions = new ArrayList();
					subdivisions = rwsOffices.getSubdivisions(headOfficeCode,
							circleOfficeCode, divisionOfficeCode);

					request.setAttribute("resetForm", "true");
				} else {
					resetProposal(myForm);
				}

				
				subprogrammes = proposalDAO.getSubprogrammes(programmeCode);
				if (circleOfficeCode != null && !circleOfficeCode.equals("")
						 && ProgrammeCode != null
						&& !ProgrammeCode.equals("")
						&& subProgrammeCode != null
						&& !subProgrammeCode.equals("")) {
					
					nextProposalId = proposalDAO
							.getNextProposalIdForAdminiStrative(headOfficeCode,
									circleOfficeCode, 
									ProgrammeCode, subProgrammeCode);
					if (nextProposalId.length() == 14) {
						proposals = myForm.getProposals();
						int size = proposals.size();
						String[] proposalIds = new String[size];
						String firstPart = nextProposalId.substring(0, 11);
						String secondPart = nextProposalId.substring(11, 14);
						int sno = Integer.parseInt(secondPart);
						String proposalId = null;
						for (int i = 0; i < size; i++) {
							if (sno < 10)
								secondPart = "00" + sno;
							else if (sno < 100)
								secondPart = "0" + sno;
							else
								secondPart = String.valueOf(sno);

							proposalId = firstPart + secondPart;
							proposalHolder = (PushkarHolder) proposals.get(i);
							proposalHolder.setProposalId(proposalId);
							proposals.set(i, proposalHolder);
							sno++;
						}
					}
				} else {
					resetProposal(myForm);
				}
			} catch (Exception e) {
				Debug.println("exception is " + e);
			}
			request.setAttribute("resetForm", "true");
		}
		if (mode != null && mode.equals("subprogrammes1")) {			
			session.removeAttribute("circles1");
			session.removeAttribute("divisions1");
			session.removeAttribute("subdivisions1");
			session.removeAttribute("selectedHabs");
			session.removeAttribute("tempSelectedAdmnHabs");
			session.removeAttribute("rwsWorkAdmnProgLnkTmp");
			try {
				String programmeCode = myForm.getPrograms();
				
				if (programmeCode != null && !programmeCode.equals("")) {
					circles = new ArrayList();
					circles = proposalDAO.getCircles(headOfficeCode);

					divisions = new ArrayList();
					divisions = rwsOffices.getDivisions(headOfficeCode,
							circleOfficeCode);

					subdivisions = new ArrayList();
					subdivisions = rwsOffices.getSubdivisions(headOfficeCode,
							circleOfficeCode, divisionOfficeCode);

					request.setAttribute("resetForm", "true");
				} else {
					resetProposal(myForm);
				}

			
				subprogrammes = commonLists.getSubprogrammes(programmeCode);
				if (circleOfficeCode != null && !circleOfficeCode.equals("")
						 && ProgrammeCode != null
						&& !ProgrammeCode.equals("")
						&& subProgrammeCode != null
						&& !subProgrammeCode.equals("")) {
					
					
					nextProposalId = proposalDAO
							.getNextProposalIdForAdminiStrative(headOfficeCode,
									circleOfficeCode,
									ProgrammeCode, subProgrammeCode);
					if (nextProposalId.length() == 14) {
						proposals = myForm.getProposals();
						int size = proposals.size();
						String[] proposalIds = new String[size];
						
						String firstPart = nextProposalId.substring(0, 11);
						String secondPart = nextProposalId.substring(11, 14);
						int sno = Integer.parseInt(secondPart);
						String proposalId = null;
						for (int i = 0; i < size; i++) {
							if (sno < 10)
								secondPart = "00" + sno;
							else if (sno < 100)
								secondPart = "0" + sno;

							else
								secondPart = String.valueOf(sno);

							proposalId = firstPart + secondPart;
							proposalHolder = (PushkarHolder) proposals.get(i);
							proposalHolder.setProposalId(proposalId);
							proposals.set(i, proposalHolder);
							sno++;
						}
					}
				} else {
					resetProposal(myForm);
				}
			} catch (Exception e) {
				Debug.println("exception is " + e);
			}
			request.setAttribute("resetForm", "true");
		}
		if (mode != null && mode.equals("divisions")) {
			session.removeAttribute("divisions1");
			session.removeAttribute("subdivisions1");
			session.removeAttribute("selectedHabs");
			session.removeAttribute("tempSelectedAdmnHabs");
			session.removeAttribute("rwsWorkAdmnProgLnkTmp");

			if (circleOfficeCode != null && !circleOfficeCode.equals("")
					
					&& ProgrammeCode != null && !ProgrammeCode.equals("")
					&& subProgrammeCode != null && !subProgrammeCode.equals("")) {
				nextProposalId = proposalDAO
						.getNextProposalIdForAdminiStrative(headOfficeCode,
								circleOfficeCode, 
								ProgrammeCode, subProgrammeCode);
				if (nextProposalId.length() == 14) {
					proposals = myForm.getProposals();
					int size = proposals.size();
					String[] proposalIds = new String[size];
					
					String firstPart = nextProposalId.substring(0, 11);
					String secondPart = nextProposalId.substring(11, 14);
					
					int sno = Integer.parseInt(secondPart);
					String proposalId = null;
					for (int i = 0; i < size; i++) {
						if (sno < 10)
							secondPart = "00" + sno;
						else if (sno < 100)
							secondPart = "0" + sno;

						else
							secondPart = String.valueOf(sno);

						proposalId = firstPart + secondPart;
						proposalHolder = (PushkarHolder) proposals.get(i);
						proposalHolder.setProposalId(proposalId);
						proposals.set(i, proposalHolder);
						sno++;
					}
				}
			} else {
				resetProposal(myForm);
			}
			divisions = new ArrayList();
			divisions = rwsOffices.getDivisions(headOfficeCode,
					circleOfficeCode);

			myForm.setDivisionOfficeCode("0");
			myForm.setSubdivisionOfficeCode("00");
			request.setAttribute("resetForm", "true");
		}
		
		
		
		
	
		
		if (mode != null && mode.equals("subdivisions")) {
			session.removeAttribute("subdivisions1");
			session.removeAttribute("selectedHabs");
			session.removeAttribute("tempSelectedAdmnHabs");
			session.removeAttribute("rwsWorkAdmnProgLnkTmp");

			if (circleOfficeCode != null && !circleOfficeCode.equals("")
					
					&& ProgrammeCode != null && !ProgrammeCode.equals("")
					&& subProgrammeCode != null && !subProgrammeCode.equals("")) {
				nextProposalId = proposalDAO
						.getNextProposalIdForAdminiStrative(headOfficeCode,
								circleOfficeCode, 
								ProgrammeCode, subProgrammeCode);
				if (nextProposalId.length() == 14) {
					proposals = myForm.getProposals();
					int size = proposals.size();
					String[] proposalIds = new String[size];
					
					String firstPart = nextProposalId.substring(0, 11);
					String secondPart = nextProposalId.substring(11, 14);
					int sno = Integer.parseInt(secondPart);
					String proposalId = null;
					for (int i = 0; i < size; i++) {
						if (sno < 10)
							secondPart = "00" + sno;
						else if (sno < 100)
							secondPart = "0" + sno;
						else
							secondPart = String.valueOf(sno);

						proposalId = firstPart + secondPart;
						proposalHolder = (PushkarHolder) proposals.get(i);
						proposalHolder.setProposalId(proposalId);
						proposals.set(i, proposalHolder);
						sno++;
					}
				}
			} else {
				resetProposal(myForm);
			}
			request.setAttribute("resetForm", "true");
			headOfficeCode = myForm.getHeadOfficeCode();
			circleOfficeCode = myForm.getCircleOfficeCode();
			divisionOfficeCode = myForm.getDivisionOfficeCode();
			myForm.setSubdivisionOfficeCode("00");
			subdivisions = rwsOffices.getSubdivisions(headOfficeCode,
					circleOfficeCode, divisionOfficeCode);
		}
		
		
		
		if (mode!= null && mode.equals("mandals")) {
			

			session.removeAttribute("mandals1");
			session.removeAttribute("selectedHabs");
			session.removeAttribute("tempSelectedAdmnHabs");
			session.removeAttribute("rwsWorkAdmnProgLnkTmp");

			if (circleOfficeCode != null && !circleOfficeCode.equals("")
					
					&& ProgrammeCode != null && !ProgrammeCode.equals("")
					&& subProgrammeCode != null && !subProgrammeCode.equals("")) {
				nextProposalId = proposalDAO
						.getNextProposalIdForAdminiStrative(headOfficeCode,
								circleOfficeCode, 
								ProgrammeCode, subProgrammeCode);
				if (nextProposalId.length() == 14) {
					proposals = myForm.getProposals();
					int size = proposals.size();
					String[] proposalIds = new String[size];
					
					String firstPart = nextProposalId.substring(0, 11);
					String secondPart = nextProposalId.substring(11, 14);
					int sno = Integer.parseInt(secondPart);
					String proposalId = null;
					for (int i = 0; i < size; i++) {
						if (sno < 10)
							secondPart = "00" + sno;
						else if (sno < 100)
							secondPart = "0" + sno;
						else
							secondPart = String.valueOf(sno);

						proposalId = firstPart + secondPart;
						proposalHolder = (PushkarHolder) proposals.get(i);
						proposalHolder.setProposalId(proposalId);
						proposals.set(i, proposalHolder);
						sno++;
					}
				}
			} else {
				resetProposal(myForm);
			}
			request.setAttribute("resetForm", "true");
			headOfficeCode = myForm.getHeadOfficeCode();
			circleOfficeCode = myForm.getCircleOfficeCode();
			divisionOfficeCode = myForm.getDivisionOfficeCode();
			subdivisionOfficeCode=myForm.getSubdivisionOfficeCode();
			myForm.setMandalCode("00");
		
	mandals =proposalDAO.getMandals(myForm.getCircleOfficeCode(),myForm.getDivisionOfficeCode(),myForm.getSubdivisionOfficeCode());	
			session.setAttribute("mandals", mandals);
			
		}
	
		if (mode!= null && mode.equals("panchayts")) {
			

			session.removeAttribute("panchayts1");
			session.removeAttribute("selectedHabs");
			session.removeAttribute("tempSelectedAdmnHabs");
			session.removeAttribute("rwsWorkAdmnProgLnkTmp");

			if (circleOfficeCode != null && !circleOfficeCode.equals("")
					
					&& ProgrammeCode != null && !ProgrammeCode.equals("")
					&& subProgrammeCode != null && !subProgrammeCode.equals("")) {
				nextProposalId = proposalDAO
						.getNextProposalIdForAdminiStrative(headOfficeCode,
								circleOfficeCode, 
								ProgrammeCode, subProgrammeCode);
				if (nextProposalId.length() == 14) {
					proposals = myForm.getProposals();
					int size = proposals.size();
					String[] proposalIds = new String[size];
					
					String firstPart = nextProposalId.substring(0, 11);
					String secondPart = nextProposalId.substring(11, 14);
					int sno = Integer.parseInt(secondPart);
					String proposalId = null;
					for (int i = 0; i < size; i++) {
						if (sno < 10)
							secondPart = "00" + sno;
						else if (sno < 100)
							secondPart = "0" + sno;
						else
							secondPart = String.valueOf(sno);

						proposalId = firstPart + secondPart;
						proposalHolder = (PushkarHolder) proposals.get(i);
						proposalHolder.setProposalId(proposalId);
						proposals.set(i, proposalHolder);
						sno++;
					}
				}
			} else {
				resetProposal(myForm);
			}
			request.setAttribute("resetForm", "true");
			headOfficeCode = myForm.getHeadOfficeCode();
			circleOfficeCode = myForm.getCircleOfficeCode();
			divisionOfficeCode = myForm.getDivisionOfficeCode();
			subdivisionOfficeCode=myForm.getSubdivisionOfficeCode();
			 mandalcode=myForm.getMandalCode();
		
			panchayats =proposalDAO.getpanchayts(mandalcode,myForm.getCircleOfficeCode());	
			session.setAttribute("panchayats", panchayats);
			
		}
	
		
		
		
		
		if (mode != null && mode.equals("habitations")) {
			session.removeAttribute("habitations1");
			session.removeAttribute("selectedHabs");
			session.removeAttribute("tempSelectedAdmnHabs");
			session.removeAttribute("rwsWorkAdmnProgLnkTmp");

			if (circleOfficeCode != null && !circleOfficeCode.equals("")
					
					&& ProgrammeCode != null && !ProgrammeCode.equals("")
					&& subProgrammeCode != null && !subProgrammeCode.equals("")) {
				nextProposalId = proposalDAO
						.getNextProposalIdForAdminiStrative(headOfficeCode,
								circleOfficeCode, 
								ProgrammeCode, subProgrammeCode);
				if (nextProposalId.length() == 14) {
					proposals = myForm.getProposals();
					int size = proposals.size();
					String[] proposalIds = new String[size];
					
					String firstPart = nextProposalId.substring(0, 11);
					String secondPart = nextProposalId.substring(11, 14);
					int sno = Integer.parseInt(secondPart);
					String proposalId = null;
					for (int i = 0; i < size; i++) {
						if (sno < 10)
							secondPart = "00" + sno;
						else if (sno < 100)
							secondPart = "0" + sno;
						else
							secondPart = String.valueOf(sno);

						proposalId = firstPart + secondPart;
						proposalHolder = (PushkarHolder) proposals.get(i);
						proposalHolder.setProposalId(proposalId);
						proposals.set(i, proposalHolder);
						sno++;
					}
				}
			} else {
				resetProposal(myForm);
			}
			request.setAttribute("resetForm", "true");
			headOfficeCode = myForm.getHeadOfficeCode();
			circleOfficeCode = myForm.getCircleOfficeCode();
			divisionOfficeCode = myForm.getDivisionOfficeCode();
			subdivisionOfficeCode=myForm.getSubdivisionOfficeCode();
			mandalcode=myForm.getMandalCode();
			panchcode=myForm.getPanchayatCode();
			
			habitations = proposalDAO.gethabitations(headOfficeCode,
					circleOfficeCode,mandalcode,panchcode);
			session.setAttribute("habitations", habitations);
			pushkars=proposalDAO.getpushkarcode(circleOfficeCode,mandalcode,panchcode);
			session.setAttribute("pushkars", pushkars);
		
		 
		}
		
		if(mode!=null&&mode.equals("pickhab"))
		{
	    	
	     String circle=myForm.getCircleOfficeCode();
	     String habindex=request.getParameter("index");
	  	 session.setAttribute("habindex",habindex);
	    
	     String proposalId=request.getParameter("proposalId");
	     String coc=request.getParameter("coc");
	     session.setAttribute("selectedWorkId",request.getParameter("proposalId"));
	  	
	  	 ArrayList mandals1=proposalDAO.getMandals(coc);
	 	 session.setAttribute("mandals1", mandals1);
	 	target="pickhab";
	 	
		}
		
		
		
		
		if (mode != null && mode.equals("save")) {
			session = request.getSession();
		    String storedToken = (String)session.getAttribute("csrfToken");
		    String token = request.getParameter("token");
		    if (storedToken.equals(token))
		    {	
			String targetPath = getServlet().getServletContext().getRealPath(
			"")
			+ File.separator + "temp.jpg";
			String pcode=request.getParameter("pushkarCode");
			
			myForm.setPushkarCode(pcode);
			String message =proposalDAO.insertPushkar(myForm,targetPath,getServlet());
			
			
			request.setAttribute("message", message);
			session.removeAttribute("divisions1");
			session.removeAttribute("subdivisions1");
			session.removeAttribute("selectedHabs");
			session.removeAttribute("tempSelectedAdmnHabs");
			session.removeAttribute("rwsWorkAdmnProgLnkTmp");
			session.removeAttribute("proposalsHabs");
			session.removeAttribute("habsarray");
		    }
			
		}

		if (mode != null && mode.equals("update")) {
			session = request.getSession();
		    String storedToken = (String)session.getAttribute("csrfToken");
		    String token = request.getParameter("token");
		    if (storedToken.equals(token))
		    {	
			String targetPath = getServlet().getServletContext().getRealPath(
			"")
			+ File.separator + "temp.jpg";
			String pcode=request.getParameter("pushkarCode");
			
			myForm.setPushkarCode(pcode);
			
			String message =proposalDAO.updatePushkar(myForm,targetPath,getServlet());
			
			request.setAttribute("message", message);
			ArrayList pushkarview=proposalDAO.pushkarview(myForm.getCircleOfficeCode());
			session.setAttribute("pushkarview", pushkarview);
			
		target="pushkarview";
		    }
			}
		
		
		
		if (mode != null && mode.equals("getSubDivisions1")) {
			
			 subdivisions1 = rwsOffices.getSubdivisions(
					headOfficeCode, circleOfficeCode, divisionOfficeCode);
			session.setAttribute("subdivisions2", subdivisions1);
		}

		

		if (mode != null && mode.equals("populateWorkId")) {
			request.setAttribute("resetForm", "false");
		}
		
		
		

		if (mode != null && mode.equals("pushkarview")) {
		
		session.removeAttribute("pushkarview");
		ArrayList pushkarview=proposalDAO.pushkarview(myForm.getCircleOfficeCode());
		
		session.setAttribute("pushkarview", pushkarview);
		myForm.setProposals(pushkarview);
		target="pushkarview";
		}
		
		
		
		
			
		
		
		
		
		
		
		if (mode != null && mode.equals("edit")) {
			String proposalId = request.getParameter("proposalId");
			String habId = request.getParameter("habId");
			
			
			ArrayList adminWork=new ArrayList();
			try {
				
				adminWork = proposalDAO.pushkarget(proposalId,habId);
				
				
				Rws_PushkarWorkForm proposalDTO = (Rws_PushkarWorkForm) adminWork.get(0);
				proposalDAO = new Rws_PushkarDAO(getDataSource(request));
				
				myForm.setPrograms(proposalDTO.getPrograms());
				myForm.setSubPrograms(proposalDTO.getSubPrograms());
				myForm.setHabCode(proposalDTO.getHabCode());
		    	myForm.setGhatType(proposalDTO.getGhatType());
		    	myForm.setPushkarCode(proposalDTO.getPushkarCode());
		    	myForm.setPreparedOn(proposalDTO.getPreparedOn());
		    	myForm.setProposalName(proposalDTO.getProposalName());
		    	myForm.setProposalId(proposalDTO.getProposalId());
		    	myForm.setWorkType(proposalDTO.getWorkType());
		    	myForm.setSanctionAmout(proposalDTO.getSanctionAmout());
		    	myForm.setAdminiStrativeNum(proposalDTO.getAdminiStrativeNum());
		    	myForm.setAdminiStrativeDate(proposalDTO.getAdminiStrativeDate());
		    	myForm.setTenderinvited(proposalDTO.getTenderinvited());
		    	myForm.setTsno(proposalDTO.getTsno());
		    	myForm.setTenderaprvd(proposalDTO.getTenderaprvd());
		    	myForm.setTenderappamount(proposalDTO.getTenderappamount());
		    	myForm.setAgreeconcluded(proposalDTO.getAgreeconcluded());
		    	myForm.setAgreeamount(proposalDTO.getAgreeamount());
		    	myForm.setPhysicaldetails(proposalDTO.getPhysicaldetails());
		    	myForm.setWorkdonevalue(proposalDTO.getWorkdonevalue());
		    	myForm.setWorkdonedate(proposalDTO.getWorkdonedate());
		    	myForm.setPrbleDateCompletion(proposalDTO.getPrbleDateCompletion());
		    	myForm.setDateOfCompletion(proposalDTO.getDateOfCompletion());
		    	myForm.setExpenditure(proposalDTO.getExpenditure());
		    	myForm.setRemarks(proposalDTO.getRemarks());
		    	myForm.setProgramName(proposalDTO.getProgramName());
		    	myForm.setSubProgramName(proposalDTO.getSubProgramName());
		    	myForm.setHabName(proposalDTO.getHabName());
		    	myForm.setMandalName(proposalDTO.getMandalName());
		    	myForm.setPanchayatName(proposalDTO.getPanchayatName());
		    	myForm.setCircleOfficeCode(proposalDTO.getCircleOfficeCode());
		    	myForm.setCircleOfficeName(proposalDTO.getCircleOfficeName());
		    	myForm.setDivisionOfficeCode(proposalDTO.getDivisionOfficeCode());
		    	myForm.setSubdivisionOfficeCode(proposalDTO.getSubdivisionOfficeCode());
		    	myForm.setDivisionOfficeName(proposalDTO.getDivisionOfficeName());
		    	myForm.setSubdivisionOfficeName(proposalDTO.getSubdivisionOfficeName());
				myForm.setCompleteddate(proposalDTO.getCompleteddate());
				myForm.setGrounddate(proposalDTO.getGrounddate());
				myForm.setTenderinvited(proposalDTO.getTenderinvited());
				myForm.setTsno(proposalDTO.getTsno());
				myForm.setTenderaprvd(proposalDTO.getTenderaprvd());
				myForm.setTenderappamount(proposalDTO.getTenderappamount());
			    myForm.setAgreeconcluded(proposalDTO.getAgreeconcluded());
			    myForm.setAgreeamount(proposalDTO.getAgreeamount());
			    
			   


			}

			catch (Exception e) {
				e.printStackTrace();
			}
			target = "edit";
		}
		
		
		if (mode != null && mode.equals("Delete")) {
			   ArrayList viewlist=myForm.getProposals();
		    
					String workId = request.getParameter("proposalId");
					DroughtDAOMessage daoMessage=proposalDAO.deletePushkarDetails(workId,viewlist);
					request.setAttribute("message",daoMessage.getMessage());
					
					ArrayList pushkarview=proposalDAO.pushkarview(myForm.getCircleOfficeCode());
					session.setAttribute("pushkarview", pushkarview);
				    myForm.setProposals(pushkarview);
				
					
					target = "pushkarview";
		}
		
		
	
		if (circles != null)
			session.setAttribute("circles1", circles);
		if (divisions != null)
			session.setAttribute("divisions1", divisions);
		if (subdivisions != null)
			session.setAttribute("subdivisions1", subdivisions);
	
		if (programmes != null)
			session.setAttribute("programmes1", programmes);
		if (subprogrammes != null)
			session.setAttribute("SubPrograms1", subprogrammes);
		
		

		System.gc();

		return mapping.findForward(target);
	}

	public void resetProposal(Rws_PushkarWorkForm myForm) {
		
		Iterator iterator = myForm.getProposals().iterator();
		PushkarHolder proposalHolder = null;
		while (iterator.hasNext()) {
			proposalHolder = (PushkarHolder) iterator.next();
			proposalHolder.setProposalId("");
		}
	}

	public void reset(Rws_PushkarWorkForm myForm) {

		
		myForm.setMandalCode("");
		myForm.setRepCode("");
		myForm.setPushkarCode("");
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
		myForm.setTsno("");
		myForm.setTsdate("");
		myForm.setTsamt("");
		myForm.setSsryr("");
		myForm.setSrhabcode("");
		myForm.setSrtypecode("");
		myForm.setAstcode("");
		myForm.setCommdate("");
		myForm.setCompdate("");
		myForm.setSubsrtypecode("");
		myForm.setSrname("");
		myForm.setScrcode("");
		myForm.setSrloc("");
		myForm.setSitedate("");
		myForm.setGrounddate("");
		myForm.setExpupto("");
		myForm.setExpuptodate("");
		myForm.setFincompdate("");
		myForm.setNewext("");
		myForm.setNotpaidvalue("");
		myForm.setScrcode("");
		myForm.setMandalCode("");
		myForm.setSitehab("");
		myForm.setSrhabcode("");
		myForm.setSrtypecode("");
		myForm.setSubsrtypecode("");
		myForm.setSouCode("");
		myForm.setSouName("");
		myForm.setSouLocation("");
		myForm.setAsttype("");
		myForm.setSourceCode("");
		myForm.setSubsourcecode("");

		Iterator iterator = myForm.getProposals().iterator();
		PushkarHolder proposalHolder = null;
		while (iterator.hasNext()) {
			proposalHolder = (PushkarHolder) iterator.next();
			proposalHolder.setMandalCode("");
			proposalHolder.setPushkarCode("");
			proposalHolder.setEstimateCost("");
			proposalHolder.setAdminiStrativeDate("");
			proposalHolder.setAdminiStrativeNum("");
			proposalHolder.setSpillOver("");
			proposalHolder.setNoOfHabs("");
			proposalHolder.setProposalName("");
			proposalHolder.setWorkType("");
			proposalHolder.setSanctionAmout("");
			proposalHolder.setProposalId("");
			proposalHolder.setProposalName("");
			proposalHolder.setRemarks("");
			proposalHolder.setAugmentation("");
			proposalHolder.setTsno("");
			proposalHolder.setTsdate("");
			proposalHolder.setTsamt("");
			proposalHolder.setSsryr("");
			proposalHolder.setSrhabcode("");
			proposalHolder.setSrtypecode("");
			proposalHolder.setAstcode("");
			proposalHolder.setCommdate("");
			proposalHolder.setCompdate("");
			proposalHolder.setSubsrtypecode("");
			proposalHolder.setSrname("");
			proposalHolder.setScrcode("");
			proposalHolder.setSrloc("");
			proposalHolder.setSitedate("");
			proposalHolder.setGrounddate("");
			proposalHolder.setExpupto("");
			proposalHolder.setExpuptodate("");
			proposalHolder.setFincompdate("");
			proposalHolder.setNewext("");
			proposalHolder.setNotpaidvalue("");
			proposalHolder.setScrcode("");
			proposalHolder.setNoOfSources("");
			proposalHolder.setMandalCode("");
			proposalHolder.setSitehab("");
			proposalHolder.setSrhabcode("");
			proposalHolder.setSrtypecode("");
			proposalHolder.setSubsrtypecode("");
			proposalHolder.setSouCode("");
			proposalHolder.setSouName("");
			proposalHolder.setSouLocation("");
			proposalHolder.setAsttype("");
			proposalHolder.setSourceCode("");
			proposalHolder.setSubsrcode("");

		}

	}

	



}
