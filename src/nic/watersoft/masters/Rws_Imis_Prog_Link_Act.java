package nic.watersoft.masters;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsUser;

public class Rws_Imis_Prog_Link_Act extends Action {

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) {
		System.gc();
		ArrayList programs = null;
		ArrayList subPrograms = null;
		ArrayList imisPrograms = null;
		ArrayList imisList = null;
		HttpSession session = request.getSession();
		String storedToken = (String) session.getAttribute("csrfToken");
		String token = request.getParameter("token");
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");
		if (!(user.getUserId() != null
				&& (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER)))) {
			return mapping.findForward("unAuthorise");
		}
		Rws_Imis_Programme_Entry_Form frm = (Rws_Imis_Programme_Entry_Form) form;
		String mode = frm.getMode();
		Rws_Imis_Programme_Entry_DAO dao = new Rws_Imis_Programme_Entry_DAO();
		if (mode != null && mode.equalsIgnoreCase("data")) {
			if (request.getParameter("special") != null && request.getParameter("special").equals("Y")) {
				reset(frm);
			}
			programs = new ArrayList();
			programs = dao.getProgrammes();
			session.setAttribute("programs", programs);
			subPrograms = new ArrayList();
			if (frm.getProgramme() != null && !frm.getProgramme().equals("")) {
				subPrograms = dao.getSubProgrammes(frm.getProgramme());
				session.setAttribute("subPrograms", subPrograms);
			}
			imisPrograms = new ArrayList();
			imisPrograms = dao.getImisProgrammesNames();
			session.setAttribute("imisPrograms", imisPrograms);
		}
		if (mode.equals("save")) {
			if (storedToken.equals(token)) {
				if (frm.getProgramme() == null || frm.getProgramme().equals("")) {
					request.setAttribute("message", "Please select Programme");
				} else if (frm.getBelTo() == null || frm.getBelTo().equals("")) {
					request.setAttribute("message", "Please select State or Central");
				} else if (frm.getImisProgramme() == null || frm.getImisProgramme().equals("")) {
					request.setAttribute("message", "Please select Programme");
				} else {
					int i = dao.saveIMIS(frm);
					if (i == 1) {
						request.setAttribute("message", "Record inserted successfully");
					} else {
						request.setAttribute("message", "Already inserted");
					}
				}
			}
			mode = "data";
		}
		if (mode != null && mode.equals("delete")) {
			/*
			 * Debug.println("delete data Mode1:"+mode1);
			 * fb.setPlan(request.getParameter("plan"));
			 * fb.setWrktype(request.getParameter("wrktype"));
			 * fb.setWorkCategory(request.getParameter("category"));
			 * fb.setProgram(request.getParameter("program")); String
			 * msg=dao.getdeleteData(fb); Debug.println("deleted:"+msg);
			 * if(msg.equals("success"))
			 * request.setAttribute("message","Record Deleted Successfully"); else
			 * if(msg.equals("failure")) request.setAttribute("message","Failed to Delete");
			 * mode="close";
			 */
		}
		if (mode.equals("get")) {
			frm.setProgramme(request.getParameter("programme"));
			frm.setSubProgramme(request.getParameter("subprogramme"));
			frm.setImisProgramme(request.getParameter("imisProgramme"));
			frm.setAmtIn(request.getParameter("amtIn"));
			frm.setAmtInSvs(request.getParameter("amtInSvs"));
			frm.setBelTo(request.getParameter("belTo"));
			programs = new ArrayList();
			programs = dao.getProgrammes();
			session.setAttribute("programs", programs);
			subPrograms = new ArrayList();
			subPrograms = dao.getSubProgrammes(request.getParameter("programme"));
			session.setAttribute("subPrograms", subPrograms);
			imisPrograms = new ArrayList();
			imisPrograms = dao.getImisProgrammesNames();
			session.setAttribute("imisPrograms", imisPrograms);
		}
		if (mode.equals("update")) {
			if (storedToken.equals(token)) {
				String msg = dao.geteditData(frm);
				if (msg.equals("success"))
					request.setAttribute("message", "Record Updated Successfully");
				else if (msg.equals("failure"))
					request.setAttribute("message", "Record can not be Updated");
				else if (msg.equals("exist"))
					request.setAttribute("message", "The Combination not Exists");
				mode = "view";
			}
		}
		if (mode.equals("view")) {
			imisList = dao.getImisList(frm);
			session.setAttribute("imisList", imisList);
		}
		return mapping.findForward(mode);
	}

	private void reset(Rws_Imis_Programme_Entry_Form frm) {
		frm.setImisProgrammeCode("");
		frm.setImisProgrammeName("");
	}
}
