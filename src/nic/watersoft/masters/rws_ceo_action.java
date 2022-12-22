package nic.watersoft.masters;

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

public class rws_ceo_action extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String mode = "";
		if (request.getParameter("mode") != null) {
			mode = request.getParameter("mode");
		} else {
			mode = "ceoEntryFrm";
		}

		rws_panchayat_sarpanch_form myForm = (rws_panchayat_sarpanch_form) form;
		ArrayList districts = new ArrayList();

		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");

		if (user == null) {

			return mapping.findForward("expire");
		}

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
				mode = "sarpanchEntryFrm";

			}

			if (userId.equals("admin") || userId.equals("100000") || userId.equals("1000DR")) {
				districts = rwsOffices.getDistricts();
				session.setAttribute("districts", districts);
			} else {

				String dname = rwsOffices.getDistrictName(circle);
				myForm.setDistrict(circle);
				myForm.setDistrictName(dname);

			}
			if (mode != null && mode.equals("view")) {
				ArrayList ceoDetails = new ArrayList();
				ceoDetails = rws_panchayat_sarpanch_dao.getceoDetails(myForm.getDistrict(), getDataSource(request));

				session.setAttribute("ceoDetails", ceoDetails);
			}

		
			if (mode != null && mode.equals("ceoEdit")) {
				session = request.getSession();
				String storedToken = (String) session.getAttribute("csrfToken");
				String token = request.getParameter("token");
				if (storedToken.equals(token)) {
					myForm.setDistrict(request.getParameter("dcode"));
					myForm.setFrmDate(request.getParameter("frmDate"));
					myForm.setToDate(request.getParameter("toDate"));
					rws_panchayat_sarpanch_dao.getceoDetails(myForm);
					request.setAttribute("mode", "ceoEdit");
				}
			}

			if (mode != null && mode.equals("save")) {
				session = request.getSession();
				String storedToken = (String) session.getAttribute("csrfToken");
				String token = request.getParameter("token");
				if (storedToken.equals(token)) {

					int rcount = rws_panchayat_sarpanch_dao.insertceo(myForm);

					if (rcount > 0) {

						request.setAttribute("message", "Record Saved Successfully");

						mode = "close";
						reset(myForm);

					} else {
						request.setAttribute("message", "Record Cannot be Inserted");
						request.setAttribute("mode", "ceoEntryFrm");
					}
					mode = "ceoEntryFrm";
					reset(myForm);
				}
			}

			if (mode != null && mode.equals("update")) {
				session = request.getSession();
				String storedToken = (String) session.getAttribute("csrfToken");
				String token = request.getParameter("token");
				if (storedToken.equals(token)) {

					int rcount = rws_panchayat_sarpanch_dao.updateceo(myForm);

					if (rcount > 0) {

						request.setAttribute("message", "Record Updated Successfully");

						mode = "close";
						reset(myForm);

					} else {
						request.setAttribute("message", "Record Cannot be Updated");
						request.setAttribute("mode", "ceoEntryFrm");
					}
					mode = "ceoEntryFrm";
					reset(myForm);
				}
			}

			if (mode != null && mode.equals("addNew")) {

				myForm.setDistrict(request.getParameter("district"));

				request.setAttribute("mode", "ceoNew");
			}

			if (mode != null && mode.equals("get")) {

				reset1(myForm);
				myForm.setDistrict(request.getParameter("district"));

				rws_panchayat_sarpanch_dao.getceoDetails(myForm);

			}

		} catch (Exception e) {
			System.out.println("Exception in rws_panchayat_sarpanch_action is " + e);

		}

		return mapping.findForward(mode);

	}

	private void reset1(rws_panchayat_sarpanch_form myForm) {

		myForm.setCeoName("");
		myForm.setCeoMobile("");
		myForm.setStatus("");
		myForm.setCeoEmailId("");
		myForm.setDpoName("");
		myForm.setDpoMobile("");
		myForm.setDpoEmailId("");

	}

	private void reset(rws_panchayat_sarpanch_form myForm) {
		myForm.setDistrict("");
		myForm.setMandal("");

		myForm.setCeoName("");
		myForm.setCeoMobile("");

		myForm.setCeoEmailId("");
		myForm.setDpoName("");
		myForm.setDpoMobile("");
		myForm.setDpoEmailId("");

	}

}