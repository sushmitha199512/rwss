package nic.watersoft.smsmobile;

import org.apache.struts.action.Action;
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

public class Rws_dlpo_action extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String mode = "";
		if (request.getParameter("mode") != null) {
			mode = request.getParameter("mode");
			// Debug.println("mode is " + mode);
		} else {
			mode = "mpdoEntryFrm";
		}

		Rws_dlpoForm myForm = (Rws_dlpoForm) form;
		ArrayList districts = new ArrayList();
		ArrayList mandals = new ArrayList();
		ArrayList panchayats = new ArrayList();
		ArrayList divmandals = new ArrayList();

		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null) {

			return mapping.findForward("expire");
		}

		if (!(user.getUserId() != null && (user.getUserId().equals(Constants.ADMIN) 	|| user.getUserId().equals(Constants.DROUGHT_USER)
				|| user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId()) || Constants.IsEEUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");
		}

		final String userId = user.getUserId();
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		Rws_dlpoForm_dao rws_panchayat_sarpanch_dao = new Rws_dlpoForm_dao();

		String district = myForm.getDistrict();

		try {

			if (mode != null && mode.equals("init")) {

				reset1(myForm);
				mode = "mpdoEntryFrm";

			}
			// Debug.println("Inside if(init)");
			districts = rwsOffices.getDistricts();
			session.setAttribute("districts", districts);
			session.setAttribute("mandals", mandals);
			session.setAttribute("divmandals", divmandals);

			if (district == null || district.equals("")) {
				district = user.getCircleOfficeCode();
				// Debug.println("circleOfficeCode1 " + district);
				String dname = rwsOffices.getDistrictName(district);
				myForm.setDistrict(district);
				myForm.setDistrictName(dname);
				mandals = rws_panchayat_sarpanch_dao.getDivisions(district);
				session.setAttribute("mandals", mandals);
			}
			if (district != null || !district.equals("")) {
				mandals = rws_panchayat_sarpanch_dao.getDivisions(district);
				session.setAttribute("mandals", mandals);
			}
			if (mode != null && mode.equals("divisions")) {
				String divcode = "1";
				mandals = rws_panchayat_sarpanch_dao.getDivisions(district);
				session.setAttribute("mandals", mandals);

			}

			if (mode != null && mode.equals("mandals")) {
				String divcode = "1";
				mandals = rws_panchayat_sarpanch_dao.getDivisions(district);
				session.setAttribute("mandals", mandals);
				String subdiv = "";

				divmandals = rws_panchayat_sarpanch_dao.getDivmandals(district, request.getParameter("mandal"));
				session.setAttribute("divmandals", divmandals);

			}

			if (mode != null && mode.equals("view")) {
				ArrayList mpdoDetails = new ArrayList();

				String districtName = rwsOffices.getDistrictName(myForm.getDistrict());
				String mandalName = rwsOffices.getMandalName(myForm.getDistrict(), myForm.getMandal());

				request.setAttribute("selectedDistrict", districtName);
				request.setAttribute("selectedMandal", mandalName);

				if (myForm.getMandal() != null && !myForm.getMandal().equals("")) {
					mpdoDetails = rws_panchayat_sarpanch_dao.getmpdoDetails(myForm.getDistrict(), myForm.getMandal(),
							getDataSource(request));
				} else if (myForm.getMandal().equals("")) {
					mpdoDetails = rws_panchayat_sarpanch_dao

							.getmpdoDetails(myForm.getDistrict());
				}
				session.setAttribute("sarpanchDetails", mpdoDetails);
			}



			if (mode != null && mode.equals("save")) {
				session = request.getSession();
				String storedToken = (String) session.getAttribute("csrfToken");
				String token = request.getParameter("token");
				if (storedToken.equals(token)) {
					/*
					 * mandals = rwsOffices.getDistrictMandals(district);
					 * session.setAttribute("mandals", mandals);
					 */
					String divcode = "1";
					mandals = rws_panchayat_sarpanch_dao.getDivisions(district);
					session.setAttribute("mandals", mandals);

					int rcount = rws_panchayat_sarpanch_dao.insertmpdo(myForm);

					if (rcount > 0) {
						request.setAttribute("message", "Record Saved Successfully");
						mode = "close";
					} else {
						request.setAttribute("message", "Record Cannot be Updated");
						// request.setAttribute("mode", "mpdoEdit");
					}
					reset1(myForm);
					mode = "mpdoEntryFrm";

				}
			}

			if (mode != null && mode.equals("addNew")) {

				// Debug.println("in addNew mode");
				myForm.setDistrict(request.getParameter("district"));
				// Debug.println("dcode is " + request.getParameter("district"));

				myForm.setMandal(request.getParameter("mandal"));
				mandals = rwsOffices.getDistrictMandals(request.getParameter("district"));
				session.setAttribute("mandals", mandals);

				request.setAttribute("mode", "mpdoNew");
			}

			if (mode != null && mode.equals("get")) {
				// Debug.println("in addNew mode gettt");
				String divcode = "1", subdiv = "";

				myForm.setDistrict(request.getParameter("district"));
				// Debug.println("dcode is " + request.getParameter("district"));

				myForm.setMandal(request.getParameter("mandal"));
				mandals = rws_panchayat_sarpanch_dao.getDivisions(district);
				session.setAttribute("mandals", mandals);
				reset(myForm);
				divmandals = rws_panchayat_sarpanch_dao.getDivmandals(district, request.getParameter("mandal"));
				session.setAttribute("divmandals", divmandals);

				Rws_dlpoForm myForm1 = rws_panchayat_sarpanch_dao.getdlpoDetails(request.getParameter("district"),
						request.getParameter("mandal"), request.getParameter("divmandals"));
				myForm.setDlpoNo(myForm1.getDlpoNo());
				myForm.setSarpanchName(myForm1.getSarpanchName());
				myForm.setSarpanchMobile(myForm1.getSarpanchMobile());

			}

		} catch (Exception e) {
			System.out.println("exception in rws_dlpo_action-- " + e);

		}
		// System.out.println("MOde::::" + mode);
		return mapping.findForward(mode);

	}

	private void reset1(Rws_dlpoForm myForm) {

		myForm.setSarpanchName("");
		myForm.setSarpanchMobile("");
		myForm.setDlpoNo("");
		myForm.setDistrict("");
		myForm.setMandal("");

	}

	private void reset(Rws_dlpoForm myForm) {

		myForm.setSarpanchName("");
		myForm.setSarpanchMobile("");
		myForm.setDlpoNo("");

	}

}
