package nic.watersoft.masters;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_mpdo_action extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String mode = "";
		if (request.getParameter("mode") != null) {
			mode = request.getParameter("mode");
		} else {
			mode = "mpdoEntryFrm";
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
			if (mode != null && mode.equals("encryptPasswords")) {
				long count = 0;
				try {
					nic.watersoft.commons.MakeHashUtils utilHash = new nic.watersoft.commons.MakeHashUtils();
				
					count = utilHash.encryptAllPwds();
				} catch (Exception e) {
					e.printStackTrace();
				}
			}

			if (mode != null && mode.equals("init")) {

				reset(myForm);
				mode = "mpdoEntryFrm";

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

			if (district == null || district.equals("")) {
				district = user.getCircleOfficeCode();
				String dname = rwsOffices.getDistrictName(circle);
				myForm.setDistrict(circle);
				myForm.setDistrictName(dname);
				mandals = rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals", mandals);
			}

			if (mode != null && mode.equals("mandals")) {
				mandals = rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals", mandals);

			}

			if (mode != null && mode.equals("sectionOfficer")) {
				mandals = rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals", mandals);
				rws_panchayat_sarpanch_form form1 = rws_panchayat_sarpanch_dao.getSectionOfficer(district,
						myForm.getMandal());
				if (form1 != null) {
					myForm.setMroName(form1.getMroName());
					myForm.setMroMobile(form1.getMroMobile());
					myForm.setMroEmailId(form1.getMroEmailId());
					myForm.setMpdoName(form1.getMpdoName());
					myForm.setMpdoMobile(form1.getMpdoMobile());
					myForm.setMpdoEmailId(form1.getMpdoEmailId());
					myForm.setSfName(form1.getSfName());
					myForm.setSfMobile(form1.getSfMobile());
					myForm.setSfEmailId(form1.getSfEmailId());
					myForm.setEordName(form1.getEordName());
					myForm.setEordMobile(form1.getEordMobile());
					myForm.setEordEmailId(form1.getEordEmailId());
					myForm.setStatus(form1.getStatus());
				}
			}
			if (mode != null && mode.equals("panchayats")) {
				mandals = rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals", mandals);
				panchayats = rwsOffices.getPanchayats(district, myForm.getMandal());
				session.setAttribute("panchayats", panchayats);

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
					mpdoDetails = rws_panchayat_sarpanch_dao.getmpdoDetails(myForm.getDistrict());
				}
				session.setAttribute("mpdoDetails", mpdoDetails);
			}

			if (mode != null && mode.equals("excelView")) {
				ArrayList mpdoDetails;
				rws_panchayat_sarpanch_dao rwsHabStatusData = new rws_panchayat_sarpanch_dao();
				String districtName = rwsOffices.getDistrictName(request.getParameter("dcode"));
				String mandalName = rwsOffices.getMandalName(request.getParameter("dcode"),
						request.getParameter("mcode"));

				request.setAttribute("selectedDistrict", districtName);
				request.setAttribute("selectedMandal", mandalName);
				mpdoDetails = rwsHabStatusData.getmpdoDetails(request.getParameter("dcode"),
						request.getParameter("mcode"), getDataSource(request));

				session.setAttribute("sarpanchDetails", mpdoDetails);
			}

			if (mode != null && mode.equals("mpdoEdit")) {
				
			
			    	
			     
				
				myForm.setDistrict(request.getParameter("dcode"));
				myForm.setMandal(request.getParameter("mcode"));
				myForm.setDesignation(request.getParameter("designation"));
				myForm.setFrmDate(request.getParameter("frmDate"));
				myForm.setToDate(request.getParameter("toDate"));

				mandals = rwsOffices.getDistrictMandals(request.getParameter("dcode"));
				session.setAttribute("mandals", mandals);

				rws_panchayat_sarpanch_dao.getmpdoDetails1(myForm);
				request.setAttribute("mode", "mpdoEdit");

			}
			

			if (mode != null && mode.equals("save")) {
				session = request.getSession();
			     String storedToken = (String)session.getAttribute("csrfToken");
			     String token = request.getParameter("token");
			     if (storedToken.equals(token))
			     {
				mandals = rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals", mandals);

				int rcount = rws_panchayat_sarpanch_dao.insertmpdo(myForm);

				if (rcount > 0) {
					request.setAttribute("message", "Record Saved Successfully");
					mode = "close";
					reset(myForm);
				} else {
					request.setAttribute("message", "Only One MPDO/MRO/Section Officer Can Exist");
					request.setAttribute("mode", "mpdoEdit");
					reset(myForm);
				}
				mode = "mpdoEntryFrm";
			}
			}
			if (mode != null && mode.equals("update")) {
				session = request.getSession();
			     String storedToken = (String)session.getAttribute("csrfToken");
			     String token = request.getParameter("token");
			     if (storedToken.equals(token))
			     {
				mandals = rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals", mandals);

				int rcount = rws_panchayat_sarpanch_dao.updatempdo(myForm);

				if (rcount > 0) {
					request.setAttribute("message", "Record Updated Successfully");
					mode = "close";
					reset(myForm);
				} else {
					request.setAttribute("message", "Record Cannot be Updated");
					request.setAttribute("mode", "mpdoEdit");
					reset(myForm);
				}
				mode = "mpdoEntryFrm";
			}
			}

			if (mode != null && mode.equals("addNew")) {

				myForm.setDistrict(request.getParameter("district"));

				myForm.setMandal(request.getParameter("mandal"));
				mandals = rwsOffices.getDistrictMandals(request.getParameter("district"));
				session.setAttribute("mandals", mandals);

				request.setAttribute("mode", "mpdoNew");
			}

			if (mode != null && mode.equals("get")) {
				reset1(myForm);
				myForm.setDistrict(request.getParameter("district"));

				myForm.setMandal(request.getParameter("mandal"));
				mandals = rwsOffices.getDistrictMandals(request.getParameter("district"));
				session.setAttribute("mandals", mandals);
				rws_panchayat_sarpanch_dao.getmpdoDetails(myForm);

			}

		} catch (Exception e) {
			System.out.println("exception in rws_mpdo_action"+e);
		}
		return mapping.findForward(mode);

	}

	private void reset1(rws_panchayat_sarpanch_form myForm) {
		myForm.setDistrict("");
		myForm.setMandal("");
		myForm.setStatus("");
		myForm.setFrmDate("");
		myForm.setToDate("");
		myForm.setMpdoName("");
		myForm.setMpdoMobile("");
		myForm.setMpdoEmailId("");
		myForm.setMroName("");
		myForm.setMroMobile("");
		myForm.setMroEmailId("");
		myForm.setSfName("");
		myForm.setSfMobile("");
		myForm.setSfEmailId("");
		myForm.setEordName("");
		myForm.setEordMobile("");
		myForm.setEordEmailId("");
		myForm.setStatus("");
		myForm.setDesignation("");
	}

	private void reset(rws_panchayat_sarpanch_form myForm) {
		myForm.setDistrict("");
		myForm.setMandal("");
		myForm.setStatus("");
		myForm.setFrmDate("");
		myForm.setToDate("");
		myForm.setMpdoName("");
		myForm.setMpdoMobile("");
		myForm.setMpdoEmailId("");
		myForm.setMroName("");
		myForm.setMroMobile("");
		myForm.setMroEmailId("");
		myForm.setSfName("");
		myForm.setSfMobile("");
		myForm.setSfEmailId("");
		myForm.setEordName("");
		myForm.setEordMobile("");
		myForm.setEordEmailId("");
		myForm.setStatus("");
		myForm.setToDate("");
		myForm.setDesignation("");

	}

}