package nic.watersoft.drought;

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
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.drought.DroughtDAO;
import nic.watersoft.drought.DroughtHolder;
import nic.watersoft.drought.Rws_Drought_Admin_Sanction_Frm;
import nic.watersoft.works.WorksDAO;
import nic.watersoft.works.rws_works_factory;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;


public class Rws_Drought_Admin_Sanction_Act extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		System.gc();

		ArrayList circles = null;
		ArrayList divisions = null;
		ArrayList subdivisions = null;
		ArrayList assetTypes = null;
		ArrayList programmes = null;
		ArrayList subprogrammes = null;
		ArrayList proposals = null;
		ArrayList workcategory = null;
		ArrayList mandals = null;
		ArrayList scTypes = null;
		ArrayList sourceHabs = null;
		ArrayList subSources = null;
		String newSourceCode = null;
		ArrayList sourceDetails = null;
		ArrayList proposals1 = null;
		ArrayList sustypes=null;
		ArrayList divisions1=null;
		ArrayList subdivisions1=null;
		ArrayList divmandals1=null;
		ArrayList habitations1=null;
		HttpSession session = request.getSession();
		if (session == null)
			return mapping.findForward("expire");


		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");
		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || user.getUserId().equals(Constants.DROUGHT_USER) || Constants.IsUser(user.getUserId()) || Constants.IsEEUser(user.getUserId()) ))) {
			return mapping.findForward("unAuthorise");	
		}
		String target = new String("data-success");
		

		Rws_Drought_Admin_Sanction_Frm myForm = (Rws_Drought_Admin_Sanction_Frm) form;

		if (myForm == null)
			return mapping.findForward("expire");

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

		if (headOfficeCode == null)
			headOfficeCode = user.getHeadOfficeCode();
		if (circleOfficeCode == null)
			circleOfficeCode = user.getCircleOfficeCode();
		if (divisionOfficeCode == null)
			divisionOfficeCode = user.getDivisionOfficeCode();
		if (subdivisionOfficeCode == null)
			subdivisionOfficeCode = user.getSubdivisionOfficeCode();


		CommonLists commonLists = new CommonLists(dataSource);
		DroughtDAO proposalDAO = new DroughtDAO(dataSource);
		RwsOffices rwsOffices = new RwsOffices(dataSource);
		DroughtHolder proposalHolder = null;
		DroughtWorksEditFrm editHolder = null;
		String nextProposalId = null;
		String typeOfAssetCode = myForm.getTypeOfAsset();
		String ProgrammeCode = myForm.getPrograms();
		String subProgrammeCode = myForm.getSubPrograms();
		if (mode != null && mode.equals("null"))//for init=true
		{
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
			session.removeAttribute("sourceHabs");
			session.removeAttribute("scTypes");
			session.removeAttribute("subSources");
			session.removeAttribute("UpdateAddedProgragsForRevise");
			session.removeAttribute("AddNewForRev");
			
			
			session.removeAttribute("AddNewForRev");

			workcategory = new ArrayList();
			try {
				workcategory = commonLists.getWorkCategory();
			} catch (Exception e) {
				Debug.println("exception is " + e);
			}
			
			sustypes = new ArrayList();
			try {
				sustypes = proposalDAO.getsusWorkTypes();
			} catch (Exception e) {
				Debug.println("exception in sustypes " + e);
			}

			try {
				ArrayList rwsWorkAdmnProgLnkTmp = (ArrayList) session
						.getAttribute("rwsWorkAdmnProgLnkTmp");
				if (rwsWorkAdmnProgLnkTmp != null) {
					proposalDAO.deleteTempAddProgramsTable(session, myForm
							.getWorkId());
				}
			} catch (Exception e) {
				Debug.println("remove rwsWorkAdmnProgLnkTmp");
			}
			proposals = new ArrayList(1);
			proposalHolder = new DroughtHolder();
			proposalHolder.setProposalId(nextProposalId);
			proposals.add(proposalHolder);
			SimpleDateFormat fmt = new SimpleDateFormat("dd/MM/yyyy");
			myForm.setProposals(proposals);
			myForm.setInit(false);
		}
		if (mode != null && mode.equals("workCategory")) {
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
			session.removeAttribute("sourceHabs");
			session.removeAttribute("scTypes");
			session.removeAttribute("subSources");
			session.removeAttribute("UpdateAddedProgragsForRevise");
			session.removeAttribute("AddNewForRev");

			workcategory = new ArrayList();
			try {
				workcategory = commonLists.getWorkCategory();
			} catch (Exception e) {
				Debug.println("exception is " + e);
			}

		}
		
		if (mode != null && mode.equals("susTypes")) {
			reset1(myForm);
			sustypes = new ArrayList();
			try {
				sustypes = proposalDAO.getsusWorkTypes();
			} catch (Exception e) {
				Debug.println("exception in sustypes " + e);
			}

		}
		
			
		
		if (mode != null && mode.equals("scheme")) {
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
			session.removeAttribute("sourceHabs");
			session.removeAttribute("scTypes");
			session.removeAttribute("subSources");
			session.removeAttribute("UpdateAddedProgragsForRevise");
			session.removeAttribute("proposalsList");
			try {
				assetTypes = proposalDAO.getAssetTypes(myForm.getWorkCat(),
						myForm.getPlan());
			} catch (Exception e) {
				Debug.println("exception is " + e);
			}
			request.setAttribute("resetForm", "true");
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
				if (!myForm.getTypeOfAsset().equals("")) {
					programmes = commonLists.getProgrammes1(myForm.getPlan(),
							myForm.getWrktype(), myForm.getWorkCat());
				}
			} catch (Exception e) {
				Debug.println("exception is " + e);
			}
			request.setAttribute("resetForm", "true");
		}
		if (mode != null && mode.equals("subprogrammes")) {
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
					circles = rwsOffices.getCircles(headOfficeCode);

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
						&& typeOfAssetCode != null
						&& !typeOfAssetCode.equals("") && ProgrammeCode != null
						&& !ProgrammeCode.equals("")
						&& subProgrammeCode != null
						&& !subProgrammeCode.equals("")) {
					nextProposalId = proposalDAO
							.getNextProposalIdForAdminiStrative(headOfficeCode,
									circleOfficeCode, typeOfAssetCode,
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
							proposalHolder = (DroughtHolder) proposals.get(i);
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
			session.removeAttribute("SubPrograms1");
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
					circles = rwsOffices.getCircles(headOfficeCode);

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
						&& typeOfAssetCode != null
						&& !typeOfAssetCode.equals("") && ProgrammeCode != null
						&& !ProgrammeCode.equals("")
						&& subProgrammeCode != null
						&& !subProgrammeCode.equals("")) {
					nextProposalId = proposalDAO
							.getNextProposalIdForAdminiStrative(headOfficeCode,
									circleOfficeCode, typeOfAssetCode,
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
							proposalHolder = (DroughtHolder) proposals.get(i);
							proposalHolder.setProposalId(proposalId);
							proposals.set(i, proposalHolder);
							sno++;
						}
					}
				} else {
					resetProposal(myForm);
				}
			} catch (Exception e) {
				Debug.println("exception in subprogrammes1" + e);
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
					&& typeOfAssetCode != null && !typeOfAssetCode.equals("")
					&& ProgrammeCode != null && !ProgrammeCode.equals("")
					&& subProgrammeCode != null && !subProgrammeCode.equals("")) {
				nextProposalId = proposalDAO
						.getNextProposalIdForAdminiStrative(headOfficeCode,
								circleOfficeCode, typeOfAssetCode,
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
						proposalHolder = (DroughtHolder) proposals.get(i);
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
					&& typeOfAssetCode != null && !typeOfAssetCode.equals("")
					&& ProgrammeCode != null && !ProgrammeCode.equals("")
					&& subProgrammeCode != null && !subProgrammeCode.equals("")) {
				nextProposalId = proposalDAO
						.getNextProposalIdForAdminiStrative(headOfficeCode,
								circleOfficeCode, typeOfAssetCode,
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
						proposalHolder = (DroughtHolder) proposals.get(i);
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
		if (mode != null && mode.equals("Save")) {
			session.removeAttribute("divisions1");
			session.removeAttribute("subdivisions1");
			session.removeAttribute("selectedHabs");
			session.removeAttribute("tempSelectedAdmnHabs");
			session.removeAttribute("rwsWorkAdmnProgLnkTmp");
			session.removeAttribute("proposalsHabs");
			session.removeAttribute("habsarray");
			reset(myForm);
		}

		if (mode != null && mode.equals("getSubDivisions1")) {
			 subdivisions1 = rwsOffices.getSubdivisions(
					headOfficeCode, circleOfficeCode, divisionOfficeCode);
			session.setAttribute("subdivisions2", subdivisions1);
		}

		if (mode != null && mode.equals("getWorks")) {
			circles = rwsOffices.getCircles(headOfficeCode);
			session.setAttribute("circles", circles);
			if (request.getParameter("someCond1") != null
					&& request.getParameter("someCond1").equals("div")) {
			      divisions1 = rwsOffices.getDivisions(headOfficeCode,
						myForm.getCcode());
				session.setAttribute("divisions2", divisions1);
				session.removeAttribute("subdivisions2");
			}
			if (request.getParameter("someCond1") != null
					&& request.getParameter("someCond1").equals("subdiv")) {
				 subdivisions1 = rwsOffices.getSubdivisions(
						headOfficeCode, myForm.getCcode(), myForm.getDivCode());
				session.setAttribute("subdivisions2", subdivisions1);
			}
			ArrayList expyears = rwsOffices.getExpYears1();
			session.setAttribute("expyears", expyears);
			ArrayList schemes = rwsOffices.getAllAssetTypes();
			session.setAttribute("schemes", schemes);
			if (request.getParameter("someCond1") != null
					&& request.getParameter("someCond1").equals("yes")) {
				ArrayList workslist = proposalDAO.getDroughtWorksList(myForm.getCcode(), myForm.getExpyear(), myForm.getScheme(),myForm, myForm.getDivCode(), myForm.getSubDivCode(),myForm.getMandalCode(),myForm.getHabCode());
				ArrayList sss = (ArrayList) myForm.getWorks();
				session.setAttribute("works", workslist);
			} else {
				session.removeAttribute("works");
			}
			target = "getWorks";
		}

		if (mode != null && mode.equals("populateWorkId")) {
			request.setAttribute("resetForm", "false");
		}

		if (mode != null && mode.equals("carryHabs")) {
			String type = request.getParameter("editvar");
			proposals = myForm.getProposals();
			int index = Integer.parseInt(request.getParameter("habindex"));
			session.setAttribute("habindex", request.getParameter("habindex"));
			proposalHolder = (DroughtHolder) proposals.get(index);
			String noHabs = request.getParameter("noOfHabs");
			String proposalId = request.getParameter("workid");
			String sproposalId = (String) session.getAttribute("proposalId");
			session.setAttribute("proposalId", proposalId);
			String totHabs = request.getParameter("selHabs");
			String[] habsarray = {};
			int lengthHab = 0;
			if (totHabs != null)
			{
				habsarray = totHabs.split("@@");
				session.setAttribute("habsarray", habsarray);
				String[] habCodesarray = new String[habsarray.length];
				lengthHab = habsarray.length;
				for (int arr = 0; arr < lengthHab; arr++) {
					if (proposalId.substring(6, 8).equals("12")) {
						habCodesarray[arr] = habsarray[arr].substring(0, 2);
					} else if (proposalId.substring(6, 8).equals("11")) {
						if (habsarray[arr] != null
								&& !habsarray[arr].equals(""))
							habCodesarray[arr] = habsarray[arr]
									.substring(0, 20);
					} else {
						habCodesarray[arr] = habsarray[arr].substring(0, 16);
					}
				}
				session.setAttribute("proposalsHabs", habCodesarray);
				myForm.setTypeOfAsset(proposalId.substring(6, 8));
				proposalHolder.setHabDetails(habsarray[0]);

				session.setAttribute("proposalsList", proposals);

				if (type != null && type.equals("edit"))
					target = "edit";
			}

		}

		if (mode != null && mode.equals("showHabs")) {
			ArrayList selectedHabCodes = (ArrayList) session
					.getAttribute("tempSelectedAdmnHabs");
			GregorianCalendar gc = new GregorianCalendar();
			String curr_time = "" + gc.getTimeInMillis();
			String sesid = session.getId() + curr_time.substring(8);
			ArrayList tempSelectedHabs = proposalDAO
					.getTempSelectedHabsForAdminSanc2(selectedHabCodes, myForm
							.getCircleOfficeCode(), sesid);
			session.setAttribute("selectedHabs", tempSelectedHabs);
		}

		if (mode != null && mode.equals("pickSources")) {
			try {
				String type = request.getParameter("editvar");
				session.setAttribute("sourcetype", type);
				session.setAttribute("index", request.getParameter("index"));
				String sourceproposalId = request.getParameter("proposalId");
				session.setAttribute("sourceproposalId", sourceproposalId);
				String ccode = request.getParameter("coc");
				mandals = proposalDAO.getMandals(ccode);
				session.setAttribute("mandals", mandals);

			} catch (Exception e) {
				Debug.println("exception is " + e);
			}
			target = "pickSources";
			resetProposal(myForm);
		}

		if (mode != null && mode.equals("sourceHabs")) {
			try {
				String ccode = myForm.getCircleOfficeCode();
				String divcode = myForm.getDivisionOfficeCode();
				String subdivcode = myForm.getSubdivisionOfficeCode();
				sourceHabs = proposalDAO.SiteHab1(ccode, divcode, subdivcode,
						myForm.getMandalCode());
				session.setAttribute("sourceHabs", sourceHabs);

			} catch (Exception e) {
				Debug.println("exception is " + e);
			}
			target = "sourceHabs";
		}

		if (mode != null && mode.equals("sourceTypes")) {
			try {
				scTypes = proposalDAO.SubCompType();
				session.setAttribute("scTypes", scTypes);
				String sourceHabCode = request.getParameter("sitehab");
				sourceDetails = proposalDAO.getSourceDetails(sourceHabCode);
				
				request.setAttribute("sourceDetails", sourceDetails);
				myForm.setSourceDetails(sourceDetails);

			} catch (Exception e) {
				Debug.println("exception is " + e);
			}
			target = "sourceTypes";
		}

		if (mode != null && mode.equals("subSourceTypes")) {
			try {
				String subcompType = request.getParameter("subcompType");
				String scode = myForm.getTypeOfAsset();
				subSources = proposalDAO.getSubSourceTypes(subcompType, scode);
				int s = subSources.size();
				session.setAttribute("subSources", subSources);

			} catch (Exception e) {
				Debug.println("exception is " + e);
			}
			target = "subSourceTypes";
		}

		if (mode != null && mode.equals("newSource")) {
			try {
				String sourceType = request.getParameter("subcompType");
				String habCode = request.getParameter("sitehab");
				String workId = "";
				newSourceCode = proposalDAO.getSourceCode(sourceType, habCode,
						workId);
				session.setAttribute("newSourceCode", newSourceCode);

			} catch (Exception e) {
				Debug.println("exception is " + e);
			}
			target = "newSource";
		}

		if (mode != null && mode.equals("addSource")) {

			try {
				String type = request.getParameter("type");
				int id = Integer.parseInt((String) session
						.getAttribute("index"));
				proposals = myForm.getProposals();
				proposalHolder = (DroughtHolder) proposals.get(id);
				String sourceHabCode = request.getParameter("sourceHabCode");
				String sourceType = request.getParameter("sourceType");
				String subsourceType = request.getParameter("subsourceType");

				String sourceID = request.getParameter("sourceId");
				String sourceName = request.getParameter("sourceName");
				String sourceLocation = request.getParameter("sourceLocation");

				session.setAttribute("sourceHabCode", sourceHabCode);
				session.setAttribute("sourceType", sourceType);
				session.setAttribute("subsourceType", subsourceType);

				session.setAttribute("sourceID", sourceID);
				session.setAttribute("sourceName", sourceName);
				session.setAttribute("sourceLocation", sourceLocation);

				String sourceTypeName = proposalDAO.SubCompTypeName(sourceType);
				String subSourceTypeName = proposalDAO.SubSourceCompTypeName(
						sourceType, subsourceType);

				session.setAttribute("sourceTypeName", sourceTypeName);
				session.setAttribute("subSourceTypeName", subSourceTypeName);

				String ppid = proposalHolder.getProposalId();

				proposalHolder.setSrhabcode(sourceHabCode);
				proposalHolder.setSrtypecode(sourceTypeName);
				proposalHolder.setSubsrtypecode(subSourceTypeName);
				proposalHolder.setScrcode(sourceID);
				proposalHolder.setSrname(sourceName);
				proposalHolder.setSrloc(sourceLocation);

				if (type != null && type.equals("edit")) {

					proposals1 = myForm.getProposals1();
					editHolder = (DroughtWorksEditFrm) proposals1.get(id);
					editHolder.setSrhabcode(sourceHabCode);
					editHolder.setSrtypecode(sourceTypeName);
					editHolder.setSubsrtypecode(subSourceTypeName);
					editHolder.setScrcode(sourceID);
					editHolder.setSrname(sourceName);
					editHolder.setSrloc(sourceLocation);
					target = "edit";

				}

			} catch (Exception e) {
				Debug.println("exception is " + e);
			}

			session.removeAttribute("sourceType");
			session.removeAttribute("subsourceType");

		}

		if (mode != null && mode.equals("getSourceDetails")) {
			try {
				String sourceHabCode = request.getParameter("sourceHabCode");
				String sourceType = request.getParameter("sourceType");
				String subsourceType = request.getParameter("subsourceType");
				sourceDetails = proposalDAO.getSourceDetails(sourceHabCode,
						sourceType, subsourceType);
				int s = sourceDetails.size();
				request.setAttribute("sourceDetails", sourceDetails);
				myForm.setSourceDetails(sourceDetails);
			} catch (Exception e) {
				Debug.println("exception is " + e);
			}
			target = "getSourceDetails";
		}


		if (mode != null && mode.equals("getAssets"))
		{
			circles = proposalDAO.getCircles(headOfficeCode, circleOfficeCode);

			String pid = request.getParameter("proposalId");
			session.setAttribute("asstindex", request.getParameter("asstindex"));

			String dtype = request.getParameter("aedittype");
			session.setAttribute("dtype", dtype);

			session.setAttribute("pid", pid);
			session.setAttribute("circles", circles);
			
			if (request.getParameter("someCond1") != null && request.getParameter("someCond1").equals("div"))
			{
				divisions1 = rwsOffices.getDivisions(headOfficeCode,myForm.getCcode());
				session.setAttribute("divisions2", divisions1);
				session.removeAttribute("subdivisions2");
			}
						
			if (request.getParameter("someCond1") != null && request.getParameter("someCond1").equals("subdiv")) {
				subdivisions1 = rwsOffices.getSubdivisions(
						headOfficeCode, myForm.getCcode(), myForm.getDivCode());
				session.setAttribute("subdivisions2", subdivisions1);
				session.removeAttribute("divmandals2");
				}
			
			if (request.getParameter("someCond1") != null && request.getParameter("someCond1").equals("man")) {
				divmandals1 = rwsOffices.getDivmandals(myForm.getCcode(), myForm.getDivCode(),myForm.getSubDivCode());
				session.setAttribute("divmandals2", divmandals1);
				session.removeAttribute("habitations");
				}
			
			if (request.getParameter("someCond1") != null && request.getParameter("someCond1").equals("habs"))
			{
				 habitations1 = new DroughtDAO().getManHabitations(myForm.getCcode(), myForm.getDivCode(),myForm.getSubDivCode(),myForm.getMandalCode());
				 session.setAttribute("habitations2", habitations1);
		    }
			
			ArrayList expyears = rwsOffices.getExpYears1();
			session.setAttribute("expyears", expyears);
			ArrayList schemes = proposalDAO.getAllAssetTypes();
			session.setAttribute("schemes", schemes);
			if (request.getParameter("someCond1") != null && request.getParameter("someCond1").equals("yes")) 
			{
         	ArrayList workslist = proposalDAO.getDroughtWorksList(myForm.getCcode(), myForm.getExpyear(), myForm.getScheme(),myForm, myForm.getDivCode(), myForm.getSubDivCode(),myForm.getMandalCode(),myForm.getHabCode());
				myForm.setWorks(workslist);
				ArrayList sss = (ArrayList) myForm.getWorks();
				session.setAttribute("works", workslist);

			} else 
			{
				session.removeAttribute("works");
			}

			target = "getAssets";
		}

		if (mode != null && mode.equals("getAssetCode")) {
			try {
				String pid = request.getParameter("proposalId");
				session.setAttribute("pid", pid);
				String AssetCode = request.getParameter("astcode");
				String pagetype = request.getParameter("pagetypevalue");
				proposals = myForm.getProposals();
				int aid = Integer.parseInt((String) session
						.getAttribute("asstindex"));
				proposalHolder = (DroughtHolder) proposals.get(aid);
				proposalHolder.setAstcode(AssetCode);

				if (pagetype != null && pagetype.equals("edit")) {
					proposals1 = myForm.getProposals1();
					editHolder = (DroughtWorksEditFrm) proposals1.get(aid);
					editHolder.setAstcode(AssetCode);
					editHolder.setNewext("on");
					target = "edit";

				}

			} catch (Exception e) {
				Debug.println("exception is " + e);
				e.printStackTrace();
			}

		}

		if (mode != null && mode.equals("Add")) {
			proposals = myForm.getProposals();
			int size = proposals.size();
			if (size == 0)
				size = 1;
			
			proposalHolder = new DroughtHolder();
			proposals.add(proposalHolder);
			myForm.setProposals(proposals);
			if (request.getParameter("AddNewForRev") != null) {
				request.setAttribute("UpdateAddedProgragsForRevise", "");
				session.setAttribute("UpdateAddedProgragsForRevise", request
						.getParameter("AddNewForRev"));
			}

			session.removeAttribute("selectedHabs");
			session.removeAttribute("tempSelectedAdmnHabs");
			session.removeAttribute("rwsWorkAdmnProgLnkTmp");
			session.removeAttribute("UpdateAddedProgragsForRevise");

			if (circleOfficeCode != null && !circleOfficeCode.equals("")
					&& typeOfAssetCode != null && !typeOfAssetCode.equals("")
					&& ProgrammeCode != null && !ProgrammeCode.equals("")
					&& subProgrammeCode != null && !subProgrammeCode.equals("")) {
				nextProposalId = proposalDAO
						.getNextProposalIdForAdminiStrative(headOfficeCode,
								circleOfficeCode, typeOfAssetCode,
								ProgrammeCode, subProgrammeCode);
				if (nextProposalId.length() == 14) {
					proposals = myForm.getProposals();
					size = proposals.size();
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
						proposalHolder = (DroughtHolder) proposals.get(i);
						proposalHolder.setProposalId(proposalId);
						proposals.set(i, proposalHolder);
						sno++;
					}
				}
			}

		}

		if (mode != null && mode.equals("Remove")) {
			ArrayList selectedHabs = null;
			proposals = myForm.getProposals();

			String[] removeIds = ((String) request.getParameter("proposalId"))
					.split(",");

			if (removeIds != null && removeIds.length != 0) {
				for (int p = 0; p < removeIds.length; p++) {
					
				}
				for (int p = 0; p < removeIds.length; p++) {
					for (int j = 0; j < proposals.size(); j++) {
						DroughtHolder dh = (DroughtHolder) proposals.get(j);
						if (dh.getProposalId().equals(removeIds[p])) {
							proposals.remove(dh);
						}
					}
				}
				myForm.setProposals(proposals);
				String message = "Successfully Works(s) Removed";
				request.setAttribute("message", message);
			} else {
				String message = "Please select atleast one proposal to remove.";
				request.setAttribute("message", message);
			}
			if (request.getParameter("AddNewForRev") != null) {
				request.setAttribute("UpdateAddedProgragsForRevise", "");
			}
		}

		if (mode != null && mode.equals("edit")) {
			String proposalId = request.getParameter("proposalId");
			String habId = request.getParameter("habId");
			
			int index = Integer.parseInt(request.getParameter("index"));

			try {
				WorksDAO dao = rws_works_factory
						.createWorksDAO(getDataSource(request));
				ArrayList statuss = dao.getWorkPhysicalStatus(request
						.getParameter("proposalId"));
				if (statuss != null) {
					if (statuss.get(0).equals("Financially Completed")
							|| statuss.get(0).equals("Commissioned")
							|| statuss.get(0).equals("Completed")) {
						request
								.setAttribute(
										"message",
										"This work Cannot be Edited - This work already Completed or Commissioned or FinanciallyCompleted");
						return mapping.findForward("edit-failed");
					}
				}
				ArrayList adminWork = proposalDAO
						.getDroughtAdminstrativeSanctionList(request
								.getParameter("proposalId"));
				DroughtDTO proposalDTO = (DroughtDTO) adminWork.get(0);
				proposalDAO = new DroughtDAO(getDataSource(request));
				myForm.setTypeOfAsset(proposalDTO.getTypeOfAsset());
				myForm.setPrograms(proposalDTO.getProgrammeName());
				myForm.setSubPrograms(proposalDTO.getSubprogrammeName());
				myForm.setCircleOfficeCode(proposalDTO.getCircleOfficeCode());
				myForm.setCircleOfficeName(proposalDTO.getCircleOfficeName());
				myForm.setDivisionOfficeCode(proposalDTO
						.getDivisionOfficeCode());
				myForm.setDivisionOfficeName(proposalDTO
						.getDivisionOfficeName());
				myForm.setSubdivisionOfficeCode(proposalDTO
						.getSubdivisionOfficeCode());
				myForm.setSubdivisionOfficeName(proposalDTO
						.getSubdivisionOfficeName());
				myForm.setWorkCat(proposalDTO.getWorkCat());
				myForm.setPlan(proposalDTO.getPlan());
				request.setAttribute("plan", myForm.getPlan());
				myForm.setProoved(proposalDTO.getProoved());
				myForm.setWrktype(proposalDTO.getWrkType());
				myForm.setAugsch(proposalDTO.getAugsch());
				editHolder = new DroughtWorksEditFrm();
				editHolder.setProposalName(proposalDTO.getProposalName());
				editHolder.setWorkType(proposalDTO.getWorkType());
				editHolder.setSusType(proposalDTO.getSusType());
				editHolder.setProposalId(proposalDTO.getProposalId());
				String programmeCode = "0";
				String habitationCode = proposalDAO.getHabCode(request
						.getParameter("proposalId"));
				editHolder.setNoOfHabs(proposalDTO.getNoOfHabs());
				editHolder.setSanctionAmout(proposalDTO.getSanctionedAmount());
				editHolder.setRemarks(proposalDTO.getRemarks());
				editHolder.setAdminiStrativeNum(proposalDTO.getAdminNo());
				editHolder.setAdminiStrativeDate(proposalDTO.getAdminDate());
				editHolder.setTsno(proposalDTO.getTsno());
				editHolder.setTsdate(proposalDTO.getTsdate());
				editHolder.setTsamt(proposalDTO.getTsamt());
				editHolder.setSsryr(proposalDTO.getSsryr());
				editHolder.setSrhabcode(proposalDTO.getSrhabcode());
				editHolder.setSrtypecode(proposalDTO.getSrtypecode());
				editHolder.setSubsrtypecode(proposalDTO.getSubsrtypecode());
				editHolder.setScrcode(proposalDTO.getScrcode());
				editHolder.setSrname(proposalDTO.getSrname());
				editHolder.setSrloc(proposalDTO.getSrloc());
				editHolder.setAstcode(proposalDTO.getAstcode());
				if (proposalDTO.getNewext().equals("Y")) {
					editHolder.setNewext("on");
					session.setAttribute("newext", editHolder.getNewext());
				} else {
					editHolder.setNewext("");
					session.setAttribute("newext", editHolder.getNewext());
				}
				editHolder.setSitedate(proposalDTO.getSitedate());
				editHolder.setGrounddate(proposalDTO.getGrounddate());
				editHolder.setExpupto(proposalDTO.getExpupto());
				editHolder.setExpuptodate(proposalDTO.getExpuptodate());
				editHolder.setNotpaidvalue(proposalDTO.getNotpaidvalue());
				editHolder.setCompdate(proposalDTO.getCompdate());
				editHolder.setFincompdate(proposalDTO.getFincompdate());
				editHolder.setCommdate(proposalDTO.getCommdate());
				editHolder.setWorkCat(proposalDTO.getWorkCat());
				editHolder.setAugsch(proposalDTO.getAugsch());

				proposals1 = new ArrayList();
				proposals1.add(editHolder);
				myForm.setProposals1(proposals1);
				session.setAttribute("testproposals", myForm.getProposals1());
				session.setAttribute("programmes", commonLists.getProgrammes());
				ArrayList subprogrammes1 = commonLists
						.getSubprogrammes(programmeCode);
				session.setAttribute("assetTypes", commonLists.getAssetTypes());
				String type = request.getParameter("type");
				request.setAttribute("type", type);

			}

			catch (Exception e) {
				e.printStackTrace();
			}
			target = "edit";
		}

		if (circles != null)
			session.setAttribute("circles1", circles);
		if (divisions != null)
			session.setAttribute("divisions1", divisions);
		if (subdivisions != null)
			session.setAttribute("subdivisions1", subdivisions);
		if (assetTypes != null)
			session.setAttribute("assetTypes1", assetTypes);
		if (programmes != null)
			session.setAttribute("programmes1", programmes);
		if (subprogrammes != null)
			session.setAttribute("SubPrograms1", subprogrammes);
		if (workcategory != null)
			session.setAttribute("workcategory1", workcategory);
		if (sustypes != null)
			session.setAttribute("sustypes1", sustypes);

		System.gc();

		return mapping.findForward(target);
	}

	public void resetProposal(Rws_Drought_Admin_Sanction_Frm myForm) {
		Iterator iterator = myForm.getProposals().iterator();
		DroughtHolder proposalHolder = null;
		while (iterator.hasNext()) {
			proposalHolder = (DroughtHolder) iterator.next();
			proposalHolder.setProposalId("");
		}
	}

	public void reset(Rws_Drought_Admin_Sanction_Frm myForm) {

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
		DroughtHolder proposalHolder = null;
		while (iterator.hasNext()) {
			proposalHolder = (DroughtHolder) iterator.next();
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

	public void reset1(Rws_Drought_Admin_Sanction_Frm myForm) {

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
		DroughtHolder proposalHolder = null;
		while (iterator.hasNext()) {
			proposalHolder = (DroughtHolder) iterator.next();
			proposalHolder.setEstimateCost("");
			proposalHolder.setAdminiStrativeDate("");
			proposalHolder.setAdminiStrativeNum("");
			proposalHolder.setSpillOver("");
			proposalHolder.setNoOfHabs("");
			proposalHolder.setProposalName("");
			proposalHolder.setSanctionAmout("");
			proposalHolder.setProposalId("");
			proposalHolder.setProposalName("");
			proposalHolder.setWorkType("");
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
		}

	}

}