package nic.watersoft.masters;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.text.html.HTMLDocument.Iterator;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_villagesec_action extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String mode = "";
		if (request.getParameter("mode") != null) {
			mode = request.getParameter("mode");
		} else {
			mode = "villagesecEntryFrm";
		}

		rws_panchayat_sarpanch_form myForm = (rws_panchayat_sarpanch_form) form;
		ArrayList districts = new ArrayList();
		ArrayList mandals = new ArrayList();
		ArrayList panchayats = new ArrayList();
		ArrayList villages = new ArrayList();
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		
		
		if (user == null)
			return mapping.findForward("expire");

		if (!(user.getUserId() != null
				&& (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId())|| Constants.IsEEUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");
		}
		
		final String userId = user.getUserId();
		String circle = userId.substring(1, 3);
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		rws_panchayat_sarpanch_dao rws_panchayat_sarpanch_dao = new rws_panchayat_sarpanch_dao();

		String district = myForm.getDistrict();

		try {

			if (mode != null && mode.equals("init")) {

				reset(myForm);
				mode = "villagesecEntryFrm";

			}

			if (userId.equals("admin") || userId.equals("100000") || userId.equals("1000DR")) {
				districts = rwsOffices.getDistricts();
				session.setAttribute("districts", districts);
				districts = rwsOffices.getDistricts();
				session.setAttribute("districts", districts);
				mandals = rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals", mandals);
			}

			else {
				String dname = rwsOffices.getDistrictName(circle);
				myForm.setDistrict(circle);
				myForm.setDistrictName(dname);
				mandals = rwsOffices.getDistrictMandals(circle);
				session.setAttribute("mandals", mandals);
			}

			districts = rwsOffices.getDistricts();
			session.setAttribute("districts", districts);
			mandals = rwsOffices.getDistrictMandals(district);
			session.setAttribute("mandals", mandals);
			panchayats = rwsOffices.getPanchayats(district, myForm.getMandal());
			session.setAttribute("panchayats", panchayats);
			villages = rwsOffices.getVillages(district, myForm.getMandal(), myForm.getPanchayat());

			session.setAttribute("villages", villages);

			if (district == null || district.equals("")) {
				district = user.getCircleOfficeCode();
				String dname = rwsOffices.getDistrictName(district);
				myForm.setDistrict(district);
				myForm.setDistrictName(dname);
				mandals = rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals", mandals);
			}

			if (mode != null && mode.equals("mandals")) {
				mandals = rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals", mandals);

			}
			if (mode != null && mode.equals("panchayats")) {
				mandals = rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals", mandals);
				panchayats = rwsOffices.getPanchayats(district, myForm.getMandal());
				session.setAttribute("panchayats", panchayats);

			}
			if (mode != null && mode.equals("villages")) {
				mandals = rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals", mandals);
				panchayats = rwsOffices.getPanchayats(district, myForm.getMandal());
				session.setAttribute("panchayats", panchayats);
				villages = rwsOffices.getVillages(district, myForm.getMandal(), myForm.getPanchayat());

				session.setAttribute("villages", villages);

			}
			if (mode != null && mode.equals("view")) {

				ArrayList VillageSecDetails = new ArrayList();

				String districtName = rwsOffices.getDistrictName(myForm.getDistrict());
				String mandalName = rwsOffices.getMandalName(myForm.getDistrict(), myForm.getMandal());
				String panchayatName = rwsOffices.getPanchayatName(myForm.getDistrict(), myForm.getMandal(),
						myForm.getPanchayat());
				String village = rwsOffices.getVillageName(getDataSource(request), myForm.getDistrict(),
						myForm.getMandal(), myForm.getPanchayat(), myForm.getVillage());

				session.setAttribute("villages", villages);
				request.setAttribute("selectedDistrict", districtName);
				request.setAttribute("selectedMandal", mandalName);
				request.setAttribute("selectedPanchayat", panchayatName);

				if (myForm.getMandal() != null && !myForm.getMandal().equals("") && myForm.getPanchayat() != null
						&& !myForm.getPanchayat().equals("") && myForm.getVillage() != null
						&& !myForm.getVillage().equals("")) {
					VillageSecDetails = rws_panchayat_sarpanch_dao.getVillageSecDetails(myForm.getDistrict(),
							myForm.getMandal(), myForm.getPanchayat(), myForm.getVillage(), getDataSource(request));
				} else if (myForm.getMandal() != null && !myForm.getMandal().equals("") && myForm.getPanchayat() != null
						&& !myForm.getPanchayat().equals("")) {
					VillageSecDetails = rws_panchayat_sarpanch_dao.getVillageSecDetails(myForm.getDistrict(),
							myForm.getMandal(), myForm.getPanchayat(), getDataSource(request));
				} else if (myForm.getMandal().equals("") && myForm.getPanchayat().equals("")) {
					VillageSecDetails = rws_panchayat_sarpanch_dao.getVillageSecDetails(myForm.getDistrict());
				} else if (myForm.getPanchayat().equals("")) {
					VillageSecDetails = rws_panchayat_sarpanch_dao.getVillageSecDetails(myForm.getDistrict(),
							myForm.getMandal());
				}
				session.setAttribute("VillageSecDetails", VillageSecDetails);

			}
			if (mode != null && mode.equals("villageSecEdit")) {

				String dcode = request.getParameter("dcode");
				String mcode = request.getParameter("mcode");
				String pcode = request.getParameter("pcode");
				String vcode = request.getParameter("vcode");
				myForm.setDistrict(request.getParameter("dcode"));
				myForm.setMandal(request.getParameter("mcode"));
				mandals = rwsOffices.getDistrictMandals(request.getParameter("dcode"));
				session.setAttribute("mandals", mandals);
				myForm.setPanchayat(request.getParameter("pcode"));
				panchayats = rwsOffices.getPanchayats(request.getParameter("dcode"), request.getParameter("mcode"));
				session.setAttribute("panchayats", panchayats);
				session.setAttribute("pcode", request.getParameter("pcode"));
				myForm.setVillage(request.getParameter("vcode"));
				villages = rwsOffices.getVillages(request.getParameter("dcode"), request.getParameter("mcode"),
						request.getParameter("pcode"));
				session.setAttribute("villages", villages);
				request.setAttribute("vcode", request.getParameter("vcode"));
				rws_panchayat_sarpanch_dao.getVillageSecDetails1(myForm);
				request.setAttribute("mode", "villageSecEdit");

			}

			if (mode != null && mode.equals("save")) {
				session = request.getSession();
				String storedToken = (String) session.getAttribute("csrfToken");
				String token = request.getParameter("token");
				if (storedToken.equals(token)) {

					int rcount = rws_panchayat_sarpanch_dao.insertVillageSec(myForm);

					if (rcount > 0) {

						request.setAttribute("message", "Record Saved Successfully");
						mode = "close";
						reset(myForm);

					} else {
						request.setAttribute("message", "Record Cannot be Updated");
						request.setAttribute("mode", "villagesecEntryFrm");
						reset(myForm);

					}
					mode = "villagesecEntryFrm";

				}
			}
			if (mode != null && mode.equals("update")) {

				session = request.getSession();
				String storedToken = (String) session.getAttribute("csrfToken");
				String token = request.getParameter("token");
				if (storedToken.equals(token)) {
					int rcount = rws_panchayat_sarpanch_dao.updateVillageSec(myForm);

					if (rcount > 0) {

						request.setAttribute("message", "Record Updated Successfully");
						mode = "close";
						reset(myForm);

					} else {
						request.setAttribute("message", "Only One Village Secretary Can Exist");
						request.setAttribute("mode", "villagesecEntryFrm");
						reset(myForm);

					}

					mode = "villagesecEntryFrm";

				}
			}

			if (mode != null && mode.equals("get")) {

				reset1(myForm);
				myForm.setDistrict(request.getParameter("district"));

				myForm.setMandal(request.getParameter("mandal"));
				mandals = rwsOffices.getDistrictMandals(request.getParameter("district"));
				session.setAttribute("mandals", mandals);

				myForm.setPanchayat(request.getParameter("panchayat"));
				panchayats = rwsOffices.getPanchayats(district, request.getParameter("mandal"));
				session.setAttribute("panchayats", panchayats);

				rws_panchayat_sarpanch_dao.getVillageSecDetails(myForm);

			}

		} catch (Exception e) {
			System.out.println("Exception in rws_panchayat_sarpanch_action is " + e);

		}
		return mapping.findForward(mode);

	}

	private void reset1(rws_panchayat_sarpanch_form myForm) {
		myForm.setStatus("");
		myForm.setFrmDate("");
		myForm.setToDate("");
		myForm.setVillageSecName("");
		myForm.setVillageSecEmailId("");
		myForm.setVillageSecMobile("");
		myForm.setStatus("");

	}

	private void reset(rws_panchayat_sarpanch_form myForm) {
		myForm.setDistrict("");
		myForm.setMandal("");
		myForm.setStatus("");
		myForm.setFrmDate("");
		myForm.setToDate("");
		myForm.setPanchayat("");
		myForm.setVillage("");
		myForm.setVillageSecName("");
		myForm.setVillageSecEmailId("");
		myForm.setVillageSecMobile("");
		myForm.setStatus("");
		// myForm.setToDate("");

	}

}