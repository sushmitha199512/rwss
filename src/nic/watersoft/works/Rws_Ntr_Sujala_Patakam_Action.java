package nic.watersoft.works;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class Rws_Ntr_Sujala_Patakam_Action extends Action {

	String message = null;

	String page_to_be_displayed = " ";
	int ans = 0;

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		Rws_Ntr_Sujala_Patakam_Frm frm = (Rws_Ntr_Sujala_Patakam_Frm) form;

		RwsOffices rwsoffice = new RwsOffices(getDataSource(request));

		HttpSession session = request.getSession();

		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");

		if (user == null) {
			return mapping.findForward("expire");
		}
		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId()) ))) {
			return mapping.findForward("unAuthorise");	
		}

		session = request.getSession();

		Rws_Ntr_Sujala_Patakam_DAO dao = new Rws_Ntr_Sujala_Patakam_DAO();

		String mode = request.getParameter("mode");

		if (mode != null && mode.equalsIgnoreCase("init")) {

			reset(frm);
			page_to_be_displayed = "data";
		}

		if (mode != null && mode.equalsIgnoreCase("data")) {
			if (request.getParameter("special") != null && request.getParameter("special").equals("reset")) {
				reset(frm);
			}

			try {

				frm.setCircles(dao.getCircles());
				session.setAttribute("plantTypes", dao.getPlatTypes());
				session.setAttribute("circles", frm.getCircles());

			} catch (Exception e) {
				System.out.println("circles Display error in ntr_sujala_patakam_action " + e);
			}

			page_to_be_displayed = "data";
		}

		if (mode != null && mode.equalsIgnoreCase("mandals")) {
			if (request.getParameter("special") != null && request.getParameter("special").equals("reset")) {
				reset(frm);
			}
			try {

				if (frm.getCircleCode() != null)

				{
					frm.getSourceList().clear();
					frm.setMandals(rwsoffice.getMandals(frm.getCircleCode()));
					session.setAttribute("plantTypes", dao.getPlatTypes());

					session.setAttribute("mandals", frm.getMandals());

				} else {
					session.setAttribute("mandals", new ArrayList());
				}

			} catch (Exception e) {
				System.out.println("mandals display error  in ntr_sujala_patakam_action  " + e);
			}
			page_to_be_displayed = "data";
		}

		if (mode != null && mode.equalsIgnoreCase("panchayats")) {
			if (request.getParameter("special") != null && request.getParameter("special").equals("reset")) {
				reset(frm);
			}
			try {

				if (frm.getCircleCode() != null && frm.getMandal() != null)

				{
					frm.getSourceList().clear();
					frm.setPanchayats(rwsoffice.getPanchayats(frm.getCircleCode(), frm.getMandal()));
					session.setAttribute("panchayats", frm.getPanchayats());

				} else {
					session.setAttribute("panchayats", new ArrayList());
				}

			} catch (Exception e) {
				System.out.println("panchayats display error  in ntr_sujala_patakam_action  " + e);
			}
			page_to_be_displayed = "data";
		}

		if (mode != null && mode.equalsIgnoreCase("villages")) {
			if (request.getParameter("special") != null && request.getParameter("special").equals("reset")) {
				reset(frm);
			}
			try {

				if (frm.getCircleCode() != null && frm.getMandal() != null && frm.getPanchCode() != null)

				{
					frm.getSourceList().clear();
					frm.setVillages(rwsoffice.getVillages(frm.getCircleCode(), frm.getMandal(), frm.getPanchCode()));
					session.setAttribute("villages", frm.getVillages());

				} else {
					session.setAttribute("villages", new ArrayList());
				}

			} catch (Exception e) {
				System.out.println("villages display error  in ntr_sujala_patakam_action  " + e);
			}
			page_to_be_displayed = "data";
		}

		if (mode != null && mode.equalsIgnoreCase("prhabs")) {

			if (request.getParameter("special") != null && request.getParameter("special").equals("reset")) {
				reset(frm);
			}
			try {
				if (frm.getCircleCode() != null && frm.getMandal() != null && frm.getPanchCode() != null
						&& frm.getVillage() != null)

				{
					frm.getSourceList().clear();
					frm.setPrhabs(rwsoffice.getHabitations(frm.getCircleCode(), frm.getMandal(), frm.getPanchCode(),
							frm.getVillage()));
					session.setAttribute("prhabs", frm.getPrhabs());

				} else {
					session.setAttribute("prhabs", new ArrayList());
				}

			} catch (Exception e) {
				System.out.println("prhabs display error  in ntr_sujala_patakam_action " + e);
			}
			page_to_be_displayed = "data";
		}

		if (mode != null && mode.equalsIgnoreCase("sourceDetails")) {
			if (request.getParameter("special") != null && request.getParameter("special").equals("reset")) {
				reset(frm);
			}
			try {

				if (frm.getCircleCode() != null && frm.getMandal() != null && frm.getPanchCode() != null
						&& frm.getVillage() != null && frm.getHabCode() != null)

				{
					frm.setSourceList(dao.getSourceDetails(frm.getHabCode()));

				} else {
					session.setAttribute("sourceList", new ArrayList());
				}

			} catch (Exception e) {
				System.out.println("sourceDetails display error  in ntr_sujala_patakam_action " + e);
			}
			page_to_be_displayed = "data";
		}

		if (mode != null && mode.equalsIgnoreCase("save")) {
			session = request.getSession();
		     String storedToken = (String)session.getAttribute("csrfToken");
		     String token = request.getParameter("token");
		     if (storedToken.equals(token))
		     {	
			ArrayList resultData = new ArrayList();
			try {
				String h1 = request.getParameter("hab1");
				String h2 = h1.substring(1, h1.length());
				String[] records = h1.split("@");
				for (int i = 0; i < records.length - 1; i++) {

					Rws_Ntr_Sujala_Patakam_Records droughtHabitationRecords = new Rws_Ntr_Sujala_Patakam_Records();

					droughtHabitationRecords.setShabCode(records[i]);
					i++;
					droughtHabitationRecords.setSourceCode(records[i]);
					i++;
					droughtHabitationRecords.setTestid(records[i]);
					i++;
					droughtHabitationRecords.setTestDate(records[i]);
					i++;
					droughtHabitationRecords.setIssueIdent(records[i]);
					i++;
					droughtHabitationRecords.setPlantType(records[i]);
					i++;
					droughtHabitationRecords.setGenHealIssuesIdent(records[i]);
					i++;
					droughtHabitationRecords.setBuildingAvailability(records[i]);
					i++;
					droughtHabitationRecords.setBuildingName(records[i]);

					i++;
					droughtHabitationRecords.setBuildingLoc(records[i]);

					i++;
					droughtHabitationRecords.setBuildingSize(records[i]);

					i++;
					droughtHabitationRecords.setWaterAvailabilty(records[i]);

					i++;
					droughtHabitationRecords.setWaterAvalDist(records[i]);

					i++;
					droughtHabitationRecords.setPowerAvailability(records[i]);

					i++;
					droughtHabitationRecords.setAnyFirm(records[i]);
					i++;
					droughtHabitationRecords.setAnyFirmName(records[i]);
					i++;
					droughtHabitationRecords.setAnyFirmloc(records[i]);
					i++;
					droughtHabitationRecords.setAnyFirmExtPlantType(records[i]);
					i++;
					droughtHabitationRecords.setAnyFirmExtPlantCap(records[i]);
					i++;
					droughtHabitationRecords.setAnyCoporate(records[i]);
					i++;
					droughtHabitationRecords.setAnyCoporateName(records[i]);
					i++;
					droughtHabitationRecords.setAnyCoporateloc(records[i]);
					i++;
					droughtHabitationRecords.setPhaseImpl(records[i]);
					resultData.add(droughtHabitationRecords);

				}
				Rws_Ntr_Sujala_Patakam_DAO droughtMasterData = new Rws_Ntr_Sujala_Patakam_DAO();

				int[] count = droughtMasterData.saveHabitations(resultData);
				if (count.length > 0)
					request.setAttribute("message", "Selected Habitations Saved Successfully ");
				else
					request.setAttribute("message", "Failed to Save");

				page_to_be_displayed = "save";
			} catch (Exception e) {
				System.out.println("save error  in ntr_sujala_patakam_action " + e);
			}
			page_to_be_displayed = "save";
		}
		}

		return mapping.findForward(page_to_be_displayed);
	}

	public void reset(Rws_Ntr_Sujala_Patakam_Frm frm) {
		frm.setCircleCode("");

	}

}
