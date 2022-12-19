package nic.watersoft.smsmobile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.masters.RwsMaster;
import org.apache.struts.action.*;

import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.ValidationUtils;

public class Rws_Tanker_Registration_Entry_Action extends Action {

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		String page_to_be_displayed = " ";

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
		String circle = userId.substring(1, 3);
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));

		Rws_Tanker_Reg_DAO dao = new Rws_Tanker_Reg_DAO();

		String message = null;
		ArrayList districts = new ArrayList();

		ArrayList mandals = new ArrayList();
		ArrayList panchayats = new ArrayList();
		ArrayList habitations = new ArrayList();

		RwsMaster rwsMaster = new RwsMaster();

		ArrayList villages = new ArrayList();

		RwsTankerRegistrationForm frm = (RwsTankerRegistrationForm) form;

		String mode = request.getParameter("mode");

		RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
		if (mode != null && mode.equalsIgnoreCase("get2")) {

			if (request.getParameter("special") != null && request.getParameter("special").equals("reset")) {
				reset(frm);

				session.removeAttribute("compnos");
				session.removeAttribute("representatives");
			}
			try {

				if (userId.equals("admin") || userId.equals("100000") || userId.equals("1000DR")) {

					districts = rwsLocations.getDistricts();
					session.setAttribute("districts", districts);

				}

				else {
					String dname = rwsOffices.getDistrictName(circle);
					frm.setCircleOfficeCode(circle);
					frm.setDistrictName(dname);

				}

				if (frm.getCircleOfficeCode() != null && !frm.getCircleOfficeCode().equals("")) {
					mandals = rwsLocations.getMandals(frm.getCircleOfficeCode());
					session.setAttribute("mandals", mandals);
				} else {

					session.setAttribute("mandals", new ArrayList());

				}
				if (frm.getCircleOfficeCode() != null && frm.getMandal() != null && !frm.getMandal().equals("")) {
					panchayats = rwsLocations.getPanchayats(frm.getCircleOfficeCode(), frm.getMandal());
					session.setAttribute("panchayats", panchayats);
				} else {
					session.setAttribute("panchayats", new ArrayList());
				}
				if (frm.getCircleOfficeCode() != null && frm.getMandal() != null && frm.getPanchayat() != null
						&& !frm.getPanchayat().equals("")) {
					villages = rwsLocations.getVillages(frm.getCircleOfficeCode(), frm.getMandal(), frm.getPanchayat());
					session.setAttribute("villages", villages);
				} else {
					session.setAttribute("villages", new ArrayList());
				}
				if (frm.getCircleOfficeCode() != null && frm.getMandal() != null && frm.getPanchayat() != null) {
					habitations = dao.getHabitations(frm.getCircleOfficeCode(), frm.getMandal(), frm.getPanchayat());
					session.setAttribute("habitations", habitations);
				} else {
					session.setAttribute("habitations", new ArrayList());
				}
			

				page_to_be_displayed = "get2";
			} catch (Exception e) {
				System.out.println("the Exception in Tanker Registration get2 is " + e);
			}
		}

		if (mode != null && mode.equalsIgnoreCase("save")) {
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {

					ValidationUtils validation = new ValidationUtils();

					if (!validation.VehicleRegNumValidator(frm.getTankerRegNo())) {
						message = "Invalid Input (Reg No)";
						request.setAttribute("message", message);
						return mapping.findForward("get2");
					}
					if (!validation.alphaNumValidator(frm.getTankerRCNo())) {
						message = "Invalid Input (RC No)";
						request.setAttribute("message", message);
						return mapping.findForward("get2");
					}
					if (!validation.aphaWithSpaceValidator(frm.getTankerRCName())) {
						message = "Invalid Input (Rc Name)";
						request.setAttribute("message", message);
						return mapping.findForward("get2");
					}
					if (!validation.DecimalNumValidator(frm.getTankerCapacity()) && !validation.numValidator(frm.getTankerCapacity())) {
						message = "Invalid Input (Capacity)";
						request.setAttribute("message", message);
						return mapping.findForward("get2");
					}
					if (!validation.aphaWithSpaceValidator(frm.getTankerOwnerName())) {
						message = "Invalid Input (Owner Name)";
						request.setAttribute("message", message);
						return mapping.findForward("get2");
					}
					if (!validation.numValidator(frm.getTankerOwnerAadhar())) {
						message = "Invalid Input (Aadhaar Number)";
						request.setAttribute("message", message);
						return mapping.findForward("get2");
					}
					if (!validation.phoneValidator(frm.getTankerOwnerMobileNumber())) {
						message = "Invalid Input (Mobile Number)";
						request.setAttribute("message", message);
						return mapping.findForward("get2");
					}
					if (!validation.numValidator(frm.getTankerOwnerIMEINumber()) && frm.getTankerOwnerIMEINumber().length() != 15) {
						message = "Invalid Input (IMEI Number)";
						request.setAttribute("message", message);
						return mapping.findForward("get2");
					}

					message = dao.insertTankerDetails(frm);
					request.setAttribute("message", message);
					resetsave(frm);
				} catch (Exception e) {
					System.out.println("the Exception in Tanker Registration save is " + e);
				}

				page_to_be_displayed = "save";
			} else {
			}
		}

		if (mode != null && mode.equalsIgnoreCase("view")) {
			ArrayList tankerDetails = new ArrayList();
			try {
				tankerDetails = dao.getTankerDetailsAll(frm);
				session.setAttribute("tankerDetails", tankerDetails);
				resetsave(frm);

			} catch (Exception e) {
				System.out.println("the Exception in Tanker Registration view is " + e);
			}
			page_to_be_displayed = "view";
		}

		if (mode != null && mode.equalsIgnoreCase("delete")) {
			try {
				String hab_code = request.getParameter("habCode");
				String tankerRegNo = request.getParameter("tankerRegNo");
				message = dao.deleteTankerDetails(hab_code, tankerRegNo);
				request.setAttribute("message", message);
				resetsave(frm);
			} catch (Exception e) {
				System.out.println("the Exception in Tanker Registration delete is " + e);
			}

			page_to_be_displayed = "save";
		}

		if (mode != null && mode.equalsIgnoreCase("edit")) {
			try {
				String hab_code = request.getParameter("habCode");
				String tankerRegNo = request.getParameter("tankerRegNo");
				RwsTankerRegistrationForm form2 = dao.getTankerDetails(hab_code, tankerRegNo);

			
				frm.setTankerRegNo(form2.getTankerRegNo());
				frm.setTankerOwnerName(form2.getTankerOwnerName());
				frm.setTankerOwnerAadhar(form2.getTankerOwnerAadhar());
				frm.setTankerOwnerMobileNumber(form2.getTankerOwnerMobileNumber());
				frm.setRemarks(form2.getRemarks());
				frm.setDistrictName(form2.getDistrictName());
				frm.setMandal(form2.getMandal());
				frm.setPanchayat(form2.getPanchayat());
				frm.setHabCode(form2.getHabCode());
				frm.setHabName(form2.getHabName());
				frm.setTankerCapacity(form2.getTankerCapacity());
				frm.setTankerRCName(form2.getTankerRCName());
				frm.setTankerRCNo(form2.getTankerRCNo());
				frm.setTankerOwnerIMEINumber(form2.getTankerOwnerIMEINumber());

			} catch (Exception e) {
				System.out.println("the Exception in Tanker Registration edit is " + e);
			}

			page_to_be_displayed = "edit";
		}

		if (mode != null && mode.equalsIgnoreCase("update")) {
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {
					
					ValidationUtils validation = new ValidationUtils();

					if (!validation.VehicleRegNumValidator(frm.getTankerRegNo())) {
						message = "Invalid Input (Reg No)";
						request.setAttribute("message", message);
						return mapping.findForward("edit");
					}
					if (!validation.alphaNumValidator(frm.getTankerRCNo())) {
						message = "Invalid Input (RC No)";
						request.setAttribute("message", message);
						return mapping.findForward("edit");
					}
					if (!validation.aphaWithSpaceValidator(frm.getTankerRCName())) {
						message = "Invalid Input (Rc Name)";
						request.setAttribute("message", message);
						return mapping.findForward("edit");
					}
					if (!validation.DecimalNumValidator(frm.getTankerCapacity()) && !validation.numValidator(frm.getTankerCapacity())) {
						message = "Invalid Input (Capacity)";
						request.setAttribute("message", message);
						return mapping.findForward("edit");
					}
					if (!validation.aphaWithSpaceValidator(frm.getTankerOwnerName())) {
						message = "Invalid Input (Owner Name)";
						request.setAttribute("message", message);
						return mapping.findForward("edit");
					}
					if (!validation.numValidator(frm.getTankerOwnerAadhar())) {
						message = "Invalid Input (Aadhaar Number)";
						request.setAttribute("message", message);
						return mapping.findForward("edit");
					}
					if (!validation.phoneValidator(frm.getTankerOwnerMobileNumber())) {
						message = "Invalid Input (Mobile Number)";
						request.setAttribute("message", message);
						return mapping.findForward("edit");
					}
					if (!validation.numValidator(frm.getTankerOwnerIMEINumber()) && frm.getTankerOwnerIMEINumber().length() != 15) {
						message = "Invalid Input (IMEI Number)";
						request.setAttribute("message", message);
						return mapping.findForward("get2");
					}
					
					String hab_code = request.getParameter("habCode");

					message = dao.upadteTankerDetails(frm);
					request.setAttribute("message", message);
					resetsave(frm);
				} catch (Exception e) {
					System.out.println("the Exception in Tanker Registration update is " + e);
				}

				page_to_be_displayed = "save";
			} else {
			}
		}

		return mapping.findForward(page_to_be_displayed);

	}

	public void reset(RwsTankerRegistrationForm frm) {

		frm.setMandal("");
		frm.setPanchayat("");
		frm.setHabCode("");
		frm.setTankerOwnerMobileNumber("");
		frm.setTankerOwnerName("");
		frm.setTankerRegNo("");
		frm.setRemarks("");
		frm.setTankerOwnerAadhar("");
		frm.setTankerCapacity("");
		frm.setTankerRCNo("");
		frm.setTankerRCName("");
		frm.setTankerOwnerIMEINumber("");

	}

	public void resetsave(RwsTankerRegistrationForm frm) {

		frm.setMandal("");
		frm.setPanchayat("");
		frm.setHabCode("");
		frm.setTankerOwnerMobileNumber("");
		frm.setTankerOwnerName("");
		frm.setTankerRegNo("");
		frm.setRemarks("");
		frm.setTankerOwnerAadhar("");
		frm.setTankerCapacity("");

		frm.setTankerRCNo("");
		frm.setTankerRCName("");
		frm.setTankerOwnerIMEINumber("");
	}
}
