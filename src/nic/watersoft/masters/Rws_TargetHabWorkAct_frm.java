package nic.watersoft.masters;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class Rws_TargetHabWorkAct_frm extends Action {
	public Rws_TargetHabWorkAct_frm() {}

	protected ActionForm buildTargetForm(String dist, String finYear, HttpServletRequest request) throws Exception {
		TargetHabWorkMasterData targetMasterData = new TargetHabWorkMasterData();
		TargetHabWorkForm targetForm = null;
		TargetBean targetBean = TargetHabWorkMasterData.getTargetsedit(dist, finYear);
		if (targetBean != null) {
			targetForm = new TargetHabWorkForm();
			targetForm.setDist(targetBean.getDist());
			targetForm.setDistrictName(targetBean.getDistrictName());
			targetForm.setFinYear(targetBean.getFinYear());
			targetForm.setSvsHabs(targetBean.getSvsHabs());
			targetForm.setSvsExp(targetBean.getSvsExp());
			targetForm.setMvsHabs(targetBean.getMvsHabs());
			targetForm.setMvsExp(targetBean.getMvsExp());
			targetForm.setSchHabs(targetBean.getSchHabs());
			targetForm.setAngHabs(targetBean.getAngHabs());
			targetForm.setNoofVwsctrained(targetBean.getNoofVwsctrained());
			targetForm.setTrtoFtkkits(targetBean.getTrtoFtkkits());
			targetForm.setWqftkTests(targetBean.getWqftkTests());
			targetForm.setPcHabs(targetBean.getPcHabs());
			targetForm.setQaHabs(targetBean.getQaHabs());			
			targetForm.setPwsHabitations(targetBean.getPwsHabitations());
			targetForm.setHouseConnections(targetBean.getHouseConnections());			
		}
		return targetForm;
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String page_to_be_displayed = "data";
		String message = null;
		int targetcount = 0;
		int count = 0;
		TargetHabWorkForm frm = (TargetHabWorkForm) form;
		String mode = request.getParameter("mode");
		HttpSession session = request.getSession();
		String storedToken = (String)session.getAttribute("csrfToken");
	    String token = request.getParameter("token");
	    RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}
		ArrayList districts = new ArrayList();
		ArrayList targets = new ArrayList();
		ArrayList expyears = new ArrayList();
		if (mode != null && mode.equalsIgnoreCase("data")) {			
			try {
				reset(frm);
				if (request.getParameter("special") != null	&& request.getParameter("special").equals("reset")) {
					session.removeAttribute("districts");
					session.removeAttribute("expyears");
					reset(frm);
				}
				TargetHabWorkMasterData targetMasterData = new TargetHabWorkMasterData();
				districts = targetMasterData.getDistricts(getDataSource(request));
				session.setAttribute("districts", districts);
				expyears = targetMasterData.getExpYears();
				session.setAttribute("expyears", expyears);
			} catch (Exception e) {
				System.out.println("The Exception in Rws_TargetHabWorkAct_frm in data is  = "+e.getMessage());
			}
			page_to_be_displayed = "data";
		}
		
		if (mode != null && mode.equalsIgnoreCase("viewdata")) {
			try {				
				String target = "";
				String year = frm.getFinYear();
				String dcode = frm.getDist();
				TargetHabWorkMasterData targetMasterData = new TargetHabWorkMasterData();				
				target = targetMasterData.getTargetDetails(frm);
			} catch (Exception e) {
				System.out.println("The Exception in Rws_TargetHabWorkAct_frm in viewdata is  = "+e.getMessage());
			}
			page_to_be_displayed = "data";
		}
				
		if (mode != null && mode.equalsIgnoreCase("view")) {
			try {				
				TargetHabWorkMasterData targetMasterData = new TargetHabWorkMasterData();
				targets = targetMasterData.getTargets(frm);
				frm.setTargets(targets);
				session.setAttribute("targets", targets);
			} catch (Exception e) {
				System.out.println("The Exception in Rws_TargetHabWorkAct_frm in view is  = "+e.getMessage());
			}
			page_to_be_displayed = "view";
		}
		if (mode != null && mode.equalsIgnoreCase("delete")) {
			try {
				String finyear = request.getParameter("finYear");
				String dcode = request.getParameter("dist");
				TargetHabWorkMasterData targetMasterData = new TargetHabWorkMasterData();
				count = targetMasterData.delTarget(dcode, finyear);
				if (count > 0) {
					message = "Record Deleted Successfully";
				} else {
					message = "Record Not Deleted ";
				}
				request.setAttribute("message", message);
			} catch (Exception e) {
				System.out.println("The Exception in Rws_TargetHabWorkAct_frm in delete is  = "+e.getMessage());
			}
			TargetHabWorkMasterData targetMasterData = new TargetHabWorkMasterData();
			TargetBean targetBean = new TargetBean();
			try {
				targets = targetMasterData.getTargets1(targetBean);
				targetBean.setTargets(targets);
				session.setAttribute("targets", targets);
			} catch (Exception e) {
				System.out.println("The Exception in Rws_TargetHabWorkAct_frm in delete is  = "+e.getMessage());
			}
			page_to_be_displayed = "view";
		}
		
		if (mode != null && mode.equalsIgnoreCase("Edit")) {
			if (storedToken.equals(token)) {	
				try {
					String finyear = request.getParameter("finYear");
					String dcode = request.getParameter("dist");
					TargetHabWorkMasterData targetMasterData = new TargetHabWorkMasterData();
					count = targetMasterData.updateTarget(finyear, frm);
					if (count > 0) {
						message = "Targets for Financial Year Updated Successfully";
					} else {
						message = "Targets for Finanacial Year Not Updated ";
					}
					request.setAttribute("message", message);
				} catch (Exception e) {
					System.out.println("The Exception in Rws_TargetHabWorkAct_frm in Edit is  = "+e.getMessage());
				}
				TargetHabWorkMasterData targetMasterData = new TargetHabWorkMasterData();
				TargetBean targetBean = new TargetBean();
				try {
					targets = targetMasterData.getTargets1(targetBean);
					targetBean.setTargets(targets);
					session.setAttribute("targets", targets);
				} catch (Exception e) {
					System.out.println("The Exception in Rws_TargetHabWorkAct_frm in Edit is  = "+e.getMessage());
				}
				page_to_be_displayed = "view";
			}
		}
		
		if (mode.equalsIgnoreCase("get")) {
			try {
				form = buildTargetForm(request.getParameter("dist"),
				request.getParameter("finYear"), request);
				String s1 = request.getParameter("dist");
				String f1 = request.getParameter("finYear");
				if ("request".equalsIgnoreCase(mapping.getScope())) {
					request.setAttribute(mapping.getAttribute(), form);
				} else {
					session.setAttribute(mapping.getAttribute(), form);
				}
			} catch (Exception e) {
				System.out.println("The Exception in Rws_TargetHabWorkAct_frm in get is  = "+e.getMessage());
			}
			page_to_be_displayed = "get";
		}

		if(mode != null && mode.equalsIgnoreCase("Save")) {
			 if (storedToken.equals(token)) {	
				try {
					TargetHabWorkMasterData targetMasterData = new TargetHabWorkMasterData();
					String finyear = frm.getFinYear();
					targetcount = targetMasterData.saveTarget(frm, finyear);
					if (targetcount > 0) {
						message = "Saved Succesfully  Targets for Financial Year ";
					} else {
						message = "Not Saved ";
					}
					request.setAttribute("message", message);
					reset1(frm);
	
				} catch (Exception e) {
					System.out.println("The Exception in Rws_TargetHabWorkAct_frm in save is  = "+e.getMessage());
				}
				page_to_be_displayed = "Save";	
			 }
		}
		return mapping.findForward(page_to_be_displayed);
	}

	public void reset1(TargetHabWorkForm frm) {
		frm.setSvsHabs("");
		frm.setSvsExp("");
		frm.setMvsHabs("");
		frm.setMvsExp("");
		frm.setSchHabs("");
		frm.setAngHabs("");
		frm.setNoofVwsctrained("");
		frm.setWqftkTests("");
		frm.setTrtoFtkkits("");	
		frm.setPcHabs("");
		frm.setQaHabs("");		
		frm.setPwsHabitations("");
		frm.setHouseConnections("");
	}

	public void reset(TargetHabWorkForm frm) {
		frm.setDist("");
		frm.setSvsHabs("");
		frm.setSvsExp("");
		frm.setMvsHabs("");
		frm.setMvsExp("");
		frm.setSchHabs("");
		frm.setAngHabs("");
		frm.setNoofVwsctrained("");
		frm.setWqftkTests("");
		frm.setTrtoFtkkits("");		
		frm.setPcHabs("");
		frm.setQaHabs("");
		frm.setPwsHabitations("");
		frm.setHouseConnections("");
	}
}
