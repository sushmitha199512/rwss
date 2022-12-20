package nic.watersoft.works;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import nic.watersoft.commons.*;

import org.apache.struts.action.*;

public class Rws_AssetWork_LeadHabEntryAct_frm extends Action {

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String message = null;
		int rcount = 0;
		Rws_AssetWork_LeadHabForm frm = (Rws_AssetWork_LeadHabForm) form;
		String mode = request.getParameter("mode");
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");

		if (user == null)
			return mapping.findForward("expire");

		if (!(user.getUserId() != null && (user.getUserId().equals(
				Constants.ADMIN)
				|| user.getUserId().equals(Constants.LAKH_USER) || Constants
					.IsUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");
		}

		ArrayList assets = new ArrayList();
		ArrayList districts = new ArrayList();
		ArrayList mandals = new ArrayList();
		ArrayList panchayats = new ArrayList();
		ArrayList habs = new ArrayList();
		boolean exists1 = false;
		boolean existsAsset = false;
		boolean existsWork = false;
		Rws_AssetWork_LeadHabData leadHabData = new Rws_AssetWork_LeadHabData();
		if (mode != null && mode.equalsIgnoreCase("data")) {
			try {
				if (request.getParameter("special") != null
						&& request.getParameter("special").equals("reset")) {
					reset(frm);
					session.removeAttribute("works");
					session.removeAttribute("habs");
					session.removeAttribute("districts");
					session.removeAttribute("mandals");
					session.removeAttribute("panchayats");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (mode != null && mode.equalsIgnoreCase("view")) {
			try {
				existsAsset = leadHabData.isExistsAsset(frm.getAssetCode());
				existsWork = leadHabData.isExistsWork(frm.getAssetCode());
				if (existsAsset == true && existsWork == true) {
					leadHabData = new Rws_AssetWork_LeadHabData();
					session.setAttribute("assethavinguihab", "No");
					Rws_AssetWork_LeadHabForm assetDta = leadHabData.getAssetWorkdetails(frm.getAssetCode());
					frm.setAssetCode1(assetDta.getAssetCode1());
					frm.setAssetName(assetDta.getAssetName());
					frm.setLeadHab(assetDta.getLeadHab());
					frm.setLeadName(assetDta.getLeadName());
					frm.setWorkId(assetDta.getWorkId());
					frm.setWorkName(assetDta.getWorkName());
					frm.setWorkHabCode(assetDta.getWorkHabCode());
					frm.setWorkHabName(assetDta.getWorkHabName());
					frm.setTypeOfAsset(assetDta.getTypeOfAsset());
					exists1 = leadHabData.isExists1(frm.getAssetCode());
					if (exists1 == true) {
						districts = leadHabData.getDistrictslead(frm.getAssetCode());
						session.setAttribute("districts", districts);
					} else {
						session.setAttribute("districts", new ArrayList());
					}
				} else if (existsAsset == true && existsWork == false) {
					leadHabData = new Rws_AssetWork_LeadHabData();
					session.setAttribute("assethavinguihab", "yes");
					Rws_AssetWork_LeadHabForm assetDta = leadHabData
							.getAssetdetails(frm.getAssetCode());
					frm.setAssetCode1(assetDta.getAssetCode1());
					frm.setAssetName(assetDta.getAssetName());
					frm.setLeadHab(assetDta.getLeadHab());
					frm.setLeadName(assetDta.getLeadName());
					frm.setTypeOfAsset(assetDta.getTypeOfAsset());
					exists1 = leadHabData.isExists1(frm.getAssetCode());
					if (exists1 == true) {
						districts = leadHabData.getDistrictslead(frm.getAssetCode());
						session.setAttribute("districts", districts);
					} else {
						session.setAttribute("districts", new ArrayList());
					}
					if (frm.getLeadName() == null || frm.getLeadName().equals("")) {
						message = "This Asset Lead Habitation is UI";
						request.setAttribute("message", message);
					}										
				} else {
					session.removeAttribute("districts");
					message = "Asset Not Exists ";
					request.setAttribute("message", message);
				}
			} catch (Exception p) {
				p.printStackTrace();
				Debug.println("Exception in Rws_AssetWork_LeadHabEntryAct_frm");
			}
		}
		if (mode != null && mode.equalsIgnoreCase("get2")) {
			try {
				if (frm.getDist() != null && !frm.getDist().equals("")
						&& !frm.getDist().equals("null")) {
					mandals = leadHabData.getMandalslead(frm.getDist());
					session.setAttribute("mandals", mandals);
				} else {
					session.setAttribute("mandals", new ArrayList());
				}
				if (frm.getDist() != null && !frm.getDist().equals("")
						&& !frm.getDist().equals("null")
						&& frm.getMcode() != null && !frm.getMcode().equals("")
						&& !frm.getMcode().equals("null")) {
					panchayats = leadHabData.getPanchayatslead(frm.getDist(),
							frm.getMcode());
					session.setAttribute("panchayats", panchayats);
				} else {
					session.setAttribute("panchayats", new ArrayList());
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (mode != null && mode.equalsIgnoreCase("lead")) {
			try {
				session.setAttribute("habs", new ArrayList());
				if (frm.getDist() != null && !frm.getDist().equals("")
						&& !frm.getDist().equals("null")
						&& frm.getMcode() != null && !frm.getMcode().equals("")
						&& !frm.getMcode().equals("null")
						&& frm.getPcode() != null && !frm.getPcode().equals("")
						&& !frm.getPcode().equals("null")) {
					habs = leadHabData.gethabdetails(frm.getDist(),	frm.getMcode(), frm.getPcode());
					session.setAttribute("habs", habs);
					frm.setHabs(habs);
				} else {
					session.setAttribute("habs", new ArrayList());
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		if (mode != null && mode.equalsIgnoreCase("modify")) {
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {
					existsWork = leadHabData.isExistsWork(frm.getAssetCode());
					String habcode = frm.getAssetCd1();
					if (habcode != null && !habcode.equals("")) {
						rcount = leadHabData.updateLeadHab(frm, habcode,existsWork);
					} else {
					}
					if (rcount > 0) {
						message = "Lead Habitation Updated Successfully";
					} else {
						message = "Lead Habitation is Not Updated";
					}
					request.setAttribute("message", message);
					reset(frm);
					session.removeAttribute("assets");
					session.removeAttribute("habs");
				} catch (Exception p) {
					p.printStackTrace();
				}
			}
		}
		return mapping.findForward(mode);
	}

	public void reset(Rws_AssetWork_LeadHabForm frm) {
		frm.setAssetCode("");
		frm.setDist("");
		frm.setMcode("");
		frm.setPcode("");
		frm.setAssetCd1("");
		frm.setAssetCode1("");
		frm.setAssetName("");
		frm.setHabCode("");
		frm.setHabName("");
		frm.setLeadHab("");
		frm.setLeadName("");
		frm.setTypeOfAsset("");
		frm.setWorkHabCode("");
		frm.setWorkHabName("");
		frm.setWorkId("");
		frm.setWorkName("");
	}
}
