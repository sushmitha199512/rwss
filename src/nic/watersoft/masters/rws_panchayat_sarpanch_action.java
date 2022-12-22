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

public class rws_panchayat_sarpanch_action extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String mode = "";
		if (request.getParameter("mode") != null) {
			mode = request.getParameter("mode");
		} else {
			mode = "sarpanchEntryFrm";
		}

		rws_panchayat_sarpanch_form myForm = (rws_panchayat_sarpanch_form) form;
		ArrayList districts = new ArrayList();
		ArrayList mandals = new ArrayList();
		ArrayList panchayats = new ArrayList();
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
			session.setAttribute("panchayats", panchayats);
			session.setAttribute("mandals", mandals);

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
			if (mode != null && mode.equals("view")) {

				ArrayList SarpanchDetails = new ArrayList();

				String districtName = rwsOffices.getDistrictName(myForm.getDistrict());
				String mandalName = rwsOffices.getMandalName(myForm.getDistrict(), myForm.getMandal());
				String panchayatName = rwsOffices.getPanchayatName(myForm.getDistrict(), myForm.getMandal(),
						myForm.getPanchayat());
				request.setAttribute("selectedDistrict", districtName);
				request.setAttribute("selectedMandal", mandalName);
				request.setAttribute("selectedPanchayat", panchayatName);

				if (myForm.getMandal() != null && !myForm.getMandal().equals("") && myForm.getPanchayat() != null
						&& !myForm.getPanchayat().equals("")) {
					SarpanchDetails = rws_panchayat_sarpanch_dao.getSarpanchDetails(myForm.getDistrict(),
							myForm.getMandal(), myForm.getPanchayat(), getDataSource(request));
				} else if (myForm.getMandal().equals("") && myForm.getPanchayat().equals("")) {
					SarpanchDetails = rws_panchayat_sarpanch_dao.getSarpanchDetails(myForm.getDistrict());
				} else if (myForm.getPanchayat().equals("")) {
					SarpanchDetails = rws_panchayat_sarpanch_dao.getSarpanchDetails(myForm.getDistrict(),
							myForm.getMandal());
				}
				session.setAttribute("sarpanchDetails", SarpanchDetails);

			}

			if (mode != null && mode.equals("excelView")) {
				ArrayList SarpanchDetails;
				rws_panchayat_sarpanch_dao rwsHabStatusData = new rws_panchayat_sarpanch_dao();
				String districtName = rwsOffices.getDistrictName(request.getParameter("dcode"));
				String mandalName = rwsOffices.getMandalName(request.getParameter("dcode"),
						request.getParameter("mcode"));
				String panchayatName = rwsOffices.getPanchayatName(request.getParameter("dcode"),
						request.getParameter("mcode"), request.getParameter("pcode"));
				request.setAttribute("selectedDistrict", districtName);
				request.setAttribute("selectedMandal", mandalName);
				request.setAttribute("selectedPanchayat", panchayatName);
				SarpanchDetails = rwsHabStatusData.getSarpanchDetails(request.getParameter("dcode"),
						request.getParameter("mcode"), request.getParameter("pcode"), getDataSource(request));
				session.setAttribute("sarpanchDetails", SarpanchDetails);
			}

			if (mode != null && mode.equals("sarpanchEdit")) {
			

					String location = request.getParameter("dcode") + request.getParameter("mcode")
							+ request.getParameter("pcode");
					String dcode = request.getParameter("dcode");
					String mcode = request.getParameter("mcode");
					String pcode = request.getParameter("pcode");
					myForm.setDistrict(request.getParameter("dcode"));
					myForm.setMandal(request.getParameter("mcode"));
					mandals = rwsOffices.getDistrictMandals(request.getParameter("dcode"));
					session.setAttribute("mandals", mandals);
					myForm.setPanchayat(request.getParameter("pcode"));
					panchayats = rwsOffices.getPanchayats(request.getParameter("dcode"), request.getParameter("mcode"));
					request.setAttribute("panchayats", panchayats);

					request.setAttribute("pcode", request.getParameter("pcode"));

					String vname = rwsOffices.getVillageName(getDataSource(request), request.getParameter("dcode"),
							request.getParameter("mcode"), request.getParameter("pcode"),
							request.getParameter("vcode"));
					String frmDate = request.getParameter("frmDate");
					String toDate = request.getParameter("toDate");

					rws_panchayat_sarpanch_dao dao = new rws_panchayat_sarpanch_dao();

					rws_panchayat_sarpanch_form sarpanchDetails = dao.getDetails(dcode, mcode, pcode, frmDate, toDate);

					myForm.setSarpanchName(sarpanchDetails.getSarpanchName());
					myForm.setSarpanchMobile(sarpanchDetails.getSarpanchMobile());
					myForm.setSarpanchEmailId(sarpanchDetails.getSarpanchEmailId());
					myForm.setStatus(sarpanchDetails.getStatus());
					myForm.setFrmDate(sarpanchDetails.getFrmDate());
					myForm.setToDate(sarpanchDetails.getToDate());
					myForm.setFrmDate1(sarpanchDetails.getFrmDate());
					request.setAttribute("mode", "sarpanchEntry");

			
			}

			if (mode != null && mode.equals("save")) {
				session = request.getSession();
				String storedToken = (String) session.getAttribute("csrfToken");
				String token = request.getParameter("token");
				if (storedToken.equals(token)) {
					mandals = rwsOffices.getDistrictMandals(district);
					session.setAttribute("mandals", mandals);

					panchayats = rwsOffices.getPanchayats(district, myForm.getMandal());
					session.setAttribute("panchayats", panchayats);

					int rcount = rws_panchayat_sarpanch_dao.insertSarpanch(myForm);

					if (rcount > 0) {

						request.setAttribute("message", "Record Saved Successfully");

						mode = "close";
						reset(myForm);
					} else {
						request.setAttribute("message", "Only One Panchayt Sarpanch Can Exist");
						request.setAttribute("mode", "sarpanchEntryFrm");
						reset(myForm);
					}
					mode = "sarpanchEntryFrm";
				}
			}
			if (mode != null && mode.equals("update")) {
				session = request.getSession();
				String storedToken = (String) session.getAttribute("csrfToken");
				String token = request.getParameter("token");
				if (storedToken.equals(token)) {
					mandals = rwsOffices.getDistrictMandals(district);
					session.setAttribute("mandals", mandals);

					panchayats = rwsOffices.getPanchayats(district, myForm.getMandal());
					session.setAttribute("panchayats", panchayats);

					int rcount = rws_panchayat_sarpanch_dao.updateSarpanch(myForm);

					if (rcount > 0) {

						request.setAttribute("message", "Record Updated Successfully");

						mode = "close";
						reset(myForm);

					}

					else {
						request.setAttribute("message", "Record Cannot be Updated");
						request.setAttribute("mode", "sarpanchEntryFrm");
						reset(myForm);
					}

					mode = "sarpanchEntryFrm";

				}
			}

			if (mode != null && mode.equals("addNew")) {

				myForm.setDistrict(request.getParameter("district"));

				myForm.setMandal(request.getParameter("mandal"));
				mandals = rwsOffices.getDistrictMandals(request.getParameter("district"));
				session.setAttribute("mandals", mandals);

				myForm.setPanchayat(request.getParameter("panchayat"));
				panchayats = rwsOffices.getPanchayats(district, request.getParameter("mandal"));
				session.setAttribute("panchayats", panchayats);

				request.setAttribute("mode", "sarpanchNew");
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

				rws_panchayat_sarpanch_dao.getSarpanchDetails(myForm);

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
		myForm.setSarpanchName("");
		myForm.setSarpanchMobile("");
		myForm.setStatus("");

	}

	private void reset(rws_panchayat_sarpanch_form myForm) {
		myForm.setDistrict("");
		myForm.setMandal("");
		myForm.setStatus("");
		myForm.setFrmDate("");
		myForm.setToDate("");
		myForm.setPanchayat("");
		myForm.setSarpanchName("");
		myForm.setSarpanchEmailId("");
		myForm.setSarpanchMobile("");
		myForm.setStatus("");

	}

}