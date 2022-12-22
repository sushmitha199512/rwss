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

public class Rws_SmsRegistration_Entry_frm extends Action {

	public Rws_SmsRegistration_Entry_frm() {

	}

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

		SmsRegistrationDAO complaintMasterData = new SmsRegistrationDAO();
		SmsRegistrationDAO dao = new SmsRegistrationDAO();

		String message = null;
		ArrayList districts = new ArrayList();
		ArrayList tasks = new ArrayList();
		ArrayList mandals = new ArrayList();
		ArrayList panchayats = new ArrayList();
		ArrayList habitations = new ArrayList();
		Collection reccomplaints = null;
		reccomplaints = new ArrayList();
		Collection complaints = new ArrayList();
		RwsMaster rwsMaster = new RwsMaster();
		Collection districtcomplaints = new ArrayList();
		Collection mandalcomplaints = new ArrayList();
		Collection panchayatcomplaints = new ArrayList();
		ArrayList villages = new ArrayList();
		ArrayList fromdates = new ArrayList();
		ArrayList todates = new ArrayList();

		Collection attendedcomplaints = new ArrayList();
		ArrayList representatives = new ArrayList();
		String compnos = "";
		RwsSmsRegistrationForm frm = (RwsSmsRegistrationForm) form;
		ArrayList phonenumbers = new ArrayList();
		Collection smsreg = new ArrayList();
		String mode = request.getParameter("mode");

		RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
		if (mode != null && mode.equalsIgnoreCase("get2")) {

			if (request.getParameter("special") != null && request.getParameter("special").equals("reset")) {
				reset(frm);

				session.removeAttribute("compnos");
				session.removeAttribute("representatives");
			}
			try {
				complaintMasterData = new SmsRegistrationDAO();
				if (userId.equals("admin") || userId.equals("100000") || userId.equals("1000DR")) {

					districts = rwsLocations.getDistricts();
					session.setAttribute("districts", districts);
					tasks = dao.getTasksForAuthorisation();
					session.setAttribute("tasks", tasks);
				}

				else {
					String dname = rwsOffices.getDistrictName(circle);
					frm.setCircleOfficeCode(circle);
					frm.setDistrictName(dname);
					tasks = dao.getTasksForAuthorisation();
					session.setAttribute("tasks", tasks);
				}

				if (frm.getCircleOfficeCode() != null && !frm.getCircleOfficeCode().equals("")) {
					mandals = rwsLocations.getMandals(frm.getCircleOfficeCode());
					session.setAttribute("mandals", mandals);

				} else {

					session.setAttribute("mandals", new ArrayList());
				}
				if (frm.getCircleOfficeCode() != null && frm.getMand() != null && !frm.getMand().equals("")) {
					panchayats = rwsLocations.getPanchayats(frm.getCircleOfficeCode(), frm.getMand());
					session.setAttribute("panchayats", panchayats);
				} else {
					session.setAttribute("panchayats", new ArrayList());
				}
				if (frm.getCircleOfficeCode() != null && frm.getMand() != null && frm.getPanch() != null
						&& !frm.getPanch().equals("")) {
					villages = rwsLocations.getVillages(frm.getCircleOfficeCode(), frm.getMand(), frm.getPanch());
					session.setAttribute("villages", villages);
				} else {
					session.setAttribute("villages", new ArrayList());
				}
				if (frm.getCircleOfficeCode() != null && frm.getMand() != null && frm.getPanch() != null) {
					habitations = dao.getHabitations(frm.getCircleOfficeCode(), frm.getMand(), frm.getPanch(),
							frm.getVill());
					session.setAttribute("habitations", habitations);
				} else {
					session.setAttribute("habitations", new ArrayList());
				}

				page_to_be_displayed = "get2";
			} catch (Exception e) {
				System.out.println("the error in Complaint get2 is " + e);
			}
		}

		if (mode != null && mode.equalsIgnoreCase("save")) {

			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {
					String req = request.getParameter("service");
					ValidationUtils validation = new ValidationUtils();

					if (!req.equals("S")) {
						if (!validation.alphaNumValidator(frm.getUsername())) {
							message = "Invalid Input (User Name)";
							request.setAttribute("message", message);
							return mapping.findForward("get2");
						}
					}
					if (!validation.aphaWithSpaceDotValidator(frm.getDatecollname())) {
						message = "Invalid Input (Name)";
						request.setAttribute("message", message);
						return mapping.findForward("get2");
					}
					if (!validation.aphaNumWithSpaceDotValidator(frm.getLocation())) {
					//if (!validation.aphaWithSpaceValidator(frm.getLocation())) {
						message = "Invalid Input (Location)";
						request.setAttribute("message", message);
						return mapping.findForward("get2");
					}
					if (!validation.phoneValidator(frm.getPhoneNo())) {
						message = "Invalid Input (Mobile Number)";
						request.setAttribute("message", message);
						return mapping.findForward("get2");
					}


					if (!frm.getEmailId().equals("") &&  frm.getEmailId() != null)  {

						if (!validation.emailValidator(frm.getEmailId())) {
							message = "Invalid Input (Email id)";
							request.setAttribute("message", message);
							return mapping.findForward("get2");
						}
					}

					if (req.equals("S")) {
						message = dao.insertComplaintgeneric(frm, req);
					} else {
						message = dao.insertMobileRegDetails(frm, req);
					}
					request.setAttribute("message", message);
					resetsave(frm);
				} catch (Exception e) {
					System.out.println("the error in SMS Registration save is " + e);
				}

				page_to_be_displayed = "save";
			} else {
			}
		}

		if (mode != null && mode.equalsIgnoreCase("view")) {

			try {
				smsreg = dao.getRegistredMobiles(frm.getCircleOfficeCode(), getDataSource(request));

				session.setAttribute("smsreg", smsreg);
				resetsave(frm);


			} catch (Exception e) {
				System.out.println("the error in SMS Registration view is " + e);
			}
			page_to_be_displayed = "view";
		}

		if (mode != null && mode.equalsIgnoreCase("update")) {

			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {

					ValidationUtils validation = new ValidationUtils();

					if (!frm.getServicereq().equals("S")) {
						if (!validation.alphaNumValidator(frm.getUsername())) {
							message = "Invalid Input (User Name)";
							request.setAttribute("message", message);
							return mapping.findForward("get");
						}
					}
					if (!validation.aphaWithSpaceDotValidator(frm.getDatecollname())) {
						message = "Invalid Input (Name)";
						request.setAttribute("message", message);
						return mapping.findForward("get");
					}
					if (!validation.aphaNumWithSpaceDotValidator(frm.getLocation())) {
					//if (!validation.aphaWithSpaceValidator(frm.getLocation())) {
						message = "Invalid Input (Location)";
						request.setAttribute("message", message);
						return mapping.findForward("get");
					}
					if (!validation.phoneValidator(frm.getPhoneNo())) {
						message = "Invalid Input (Mobile Number)";
						request.setAttribute("message", message);
						return mapping.findForward("get");
					}

					if (!frm.getEmailId().equals("") ) {

						if (!validation.emailValidator(frm.getEmailId())) {
							message = "Invalid Input (Email id)";
							request.setAttribute("message", message);
							return mapping.findForward("get");
						}
					}


					message = dao.updateRegistrationDetails(frm);
					request.setAttribute("message", message);
					resetsave(frm);
				} catch (Exception e) {
					System.out.println("Exception in Rws_SmsRegistration_entry_frm_action"+e);
				}

				page_to_be_displayed = "view";
			} else {
			}
		}

		if (mode != null && mode.equalsIgnoreCase("delete")) {
			try {

				message = dao.deleteRegistrationDetails(request.getParameter("phone"), request.getParameter("hab"));
				request.setAttribute("message", message);
				resetsave(frm);
			} catch (Exception e) {
				System.out.println("Exception in Rws_SmsRegistration_entry_frm_action"+e);
			}

			page_to_be_displayed = "view";
		}

		if (mode != null && mode.equalsIgnoreCase("get")) {
			try {


				dao.getRegistredDetails(request.getParameter("phone"), request.getParameter("hab"),
						request.getParameter("serviceReq"), frm);

			} catch (Exception e) {
				System.out.println("Exception in Rws_SmsRegistration_entry_frm_action");
			}
			page_to_be_displayed = "get";
		}

		if (mode != null && mode.equalsIgnoreCase("taskauth")) {

			try {

				String taskNo = dao.getTaskNo();
				frm.setTaskAuthorizationCode(taskNo);

			} catch (Exception e) {
				System.out.println("Exception in Rws_SmsRegistration_entry_frm_action");
			}
			page_to_be_displayed = "taskauth";
		}
		if (mode != null && mode.equalsIgnoreCase("saveTask")) {

			try {

				message = dao.saveTaskDetails(frm);
				request.setAttribute("message", message);
				resetTask(frm, dao);
			} catch (Exception e) {
				System.out.println("Exception in Rws_SmsRegistration_entry_frm_action");
			}
			page_to_be_displayed = "taskauth";
		}
		if (mode != null && mode.equalsIgnoreCase("viewTask")) {
			ArrayList taskList = new ArrayList();
			try {

				taskList = dao.getTaskDetails();

				session.setAttribute("taskList", taskList);
				resetTask(frm, dao);


			} catch (Exception e) {
				System.out.println("Exception in Rws_SmsRegistration_entry_frm_action");
			}
			page_to_be_displayed = "viewTask";
		}
		if (mode != null && mode.equalsIgnoreCase("editTask")) {

			try {
				String taskCode = request.getParameter("taskCode");

				String taskName = dao.getTaskData(taskCode);
				frm.setTaskAuthorizationCode(taskCode);
				frm.setTaskAuthorizationName(taskName);

			} catch (Exception e) {
				System.out.println("Exception in Rws_SmsRegistration_entry_frm_action");
			}
			page_to_be_displayed = "editTask";
		}

		return mapping.findForward(page_to_be_displayed);

	}

	public void reset(RwsSmsRegistrationForm frm) {
		frm.setDist("");
		frm.setMand("");
		frm.setPanch("");
		frm.setVill("");
		frm.setHabCode("");

		frm.setName("");
		frm.setAddress("");
		frm.setPhoneNo("");

		frm.setEmailId("");
		frm.setServicereq("");
		frm.setImeino("");
		frm.setUsername("");
		frm.setPassword("");
		frm.setDatecollname("");
		frm.setDesgnation("");
		frm.setLocation("");

	}

	public void resetsave(RwsSmsRegistrationForm frm) {
		frm.setDist("");
		frm.setMand("");
		frm.setPanch("");
		frm.setVill("");
		frm.setHabCode("");
		frm.setLocation("");
		frm.setName("");
		frm.setAddress("");
		frm.setPhoneNo("");

		frm.setEmailId("");
		frm.setServicereq("");
		frm.setImeino("");
		frm.setUsername("");
		frm.setPassword("");
		frm.setDatecollname("");
		frm.setDesgnation("");
	}

	private void resetTask(RwsSmsRegistrationForm frm, SmsRegistrationDAO dao) {
		frm.setTaskAuthorizationCode(dao.getTaskNo());
		frm.setTaskAuthorizationName("");

	}
}
