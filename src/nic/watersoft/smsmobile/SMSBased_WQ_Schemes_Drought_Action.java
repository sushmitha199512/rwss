package nic.watersoft.smsmobile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.ValidationUtils;
import nic.watersoft.drought.DroughtForm;
import nic.watersoft.drought.DroughtMasterData;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class SMSBased_WQ_Schemes_Drought_Action extends Action {

	public SMSBased_WQ_Schemes_Drought_Action() {

	}

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String page_to_be_displayed = "get";
		RwsUser rwsUser = (RwsUser) session.getAttribute("RWS_USER");

		if (rwsUser == null) {

			return mapping.findForward("expire");
		}

		if (!(rwsUser.getUserId() != null && (rwsUser.getUserId().equals(Constants.ADMIN) 	|| rwsUser.getUserId().equals(Constants.DROUGHT_USER)
				|| rwsUser.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(rwsUser.getUserId()) || Constants.IsEEUser(rwsUser.getUserId())))) {
			return mapping.findForward("unAuthorise");
		}


		String loggedUser = rwsUser.getUserId();
		String circle = loggedUser.substring(1, 3);
		String message = null;
		ArrayList chlorides = new ArrayList();
		ArrayList sources = new ArrayList();
		ArrayList schemes = new ArrayList();
		ArrayList drought = new ArrayList();
		ArrayList districts = new ArrayList();
		ArrayList mandals = new ArrayList();
		ArrayList panchayats = new ArrayList();
		ArrayList villages = new ArrayList();
		ArrayList habitations = new ArrayList();
		ArrayList ohsr = new ArrayList();
		String mode = request.getParameter("mode");
		SMSBased_WQ_Schemes_Drought_Form frm = (SMSBased_WQ_Schemes_Drought_Form) form;
		SMSBased_WQ_Schemes_Drought_DAO residualChlorineDAO = new SMSBased_WQ_Schemes_Drought_DAO();
		RwsOffices offices = new RwsOffices();
		if (mode == null || mode.equals("")) {
			reset(frm);
			mode = "get";
		}
		if (mode != null && mode.equalsIgnoreCase("get")) {
			try {
				if (loggedUser.equals("admin") || loggedUser.equals("100000") || loggedUser.equals("1000DR")
						|| loggedUser.equals("secrwss")) {
					districts = offices.getDistricts();
					session.setAttribute("districts", districts);
				} else {
					frm.setDistrict(circle);
					frm.setDistrictName(offices.getDistrictName(circle));
				}
				session.setAttribute("mandals", mandals);
				session.setAttribute("panchayats", panchayats);
				session.setAttribute("villages", villages);
				session.setAttribute("habitations", habitations);

				if (frm.getDistrict() != null && !frm.getDistrict().equals("")) {
					mandals = offices.getMandals(frm.getDistrict());
					session.setAttribute("mandals", mandals);
				}
				if (frm.getDistrict() != null && !frm.getDistrict().equals("") && frm.getMandal() != null
						&& !frm.getMandal().equals("")) {
					panchayats = offices.getPanchayats(frm.getDistrict(), frm.getMandal());
					session.setAttribute("panchayats", panchayats);
				}
				if (frm.getDistrict() != null && !frm.getDistrict().equals("") && frm.getMandal() != null
						&& !frm.getMandal().equals("") && frm.getPanchayat() != null
						&& !frm.getPanchayat().equals("")) {
					villages = offices.getVillages(frm.getDistrict(), frm.getMandal(), frm.getPanchayat());
					session.setAttribute("villages", villages);
				}
				if (frm.getDistrict() != null && !frm.getDistrict().equals("") && frm.getMandal() != null
						&& !frm.getMandal().equals("") && frm.getPanchayat() != null && !frm.getPanchayat().equals("")
						&& frm.getVillage() != null && !frm.getVillage().equals("")) {
					habitations = offices.getHabitations(frm.getDistrict(), frm.getMandal(), frm.getPanchayat(),
							frm.getVillage());
					session.setAttribute("habitations", habitations);
				}
			} catch (Exception e) {
				System.out.println("exception-- " + e);
			}
			page_to_be_displayed = "get";
		}

		if (mode != null && mode.equalsIgnoreCase("chlorideData")) {
			try {

				if (frm.getChlorides() != null && frm.getChlorides().size() > 1) {
					frm.getChlorides().clear();
				}

				chlorides = residualChlorineDAO.getChlorideDetails(frm);
				frm.setChlorides(chlorides);
				session.setAttribute("chlorides", chlorides);

			} catch (Exception e) {
				System.out.println("exception in chlorideData mode-- " + e);
			}
			page_to_be_displayed = "chlorideData";
		}

		if (mode != null && mode.equalsIgnoreCase("Save")) {
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {

					ValidationUtils validation = new ValidationUtils();

					if (frm.getChecks() != null && frm.getChecks().equals("on")) {


						if (frm.getAssetCode() == null) {
							message = "Invalid Input (Asset Code)";
							request.setAttribute("message", message);
							return mapping.findForward("chlorideData");

						}
						if (frm.getAssetName() == null) {
							message = "Invalid Input (Asset Name)";
							request.setAttribute("message", message);
							return mapping.findForward("chlorideData");
						}
						if (frm.getSourceName() == null) {
							message = "Invalid Input (Source Name)";
							request.setAttribute("message", message);
							return mapping.findForward("chlorideData");
						}
						if (frm.getDateOfAction() == null) {
							message = "Invalid Input (Date of Action)";
							request.setAttribute("message", message);
							return mapping.findForward("chlorideData");
						}
					}

					message = residualChlorineDAO.updateUserDetails(frm, loggedUser);

					request.setAttribute("message", message);

					if (frm.getChlorides() != null && frm.getChlorides().size() > 1) {
						frm.getChlorides().clear();
					}

					chlorides = residualChlorineDAO.getChlorideDetails(frm);
					frm.setChlorides(chlorides);
					session.setAttribute("chlorides", chlorides);
				} catch (Exception e) {
					System.out.println("exception in save mode-- " + e);
				}
				page_to_be_displayed = "chlorideData";
			}
		}

		if (mode != null && mode.equalsIgnoreCase("chlorideDataView")) {
			try {

				if (frm.getChlorides1() != null && frm.getChlorides1().size() > 1) {
					frm.getChlorides1().clear();
				}
				chlorides = residualChlorineDAO.getChlorideDetailsAll(frm);
				frm.setChlorides1(chlorides);
				session.setAttribute("chlorides1", chlorides);
			} catch (Exception e) {
				System.out.println("exception in chlorideDataView mode-- " + e);
			}
			page_to_be_displayed = "chlorideDataView";
		}

		if (mode != null && mode.equalsIgnoreCase("chloridesourceprint")) {
			try {
				schemes = (ArrayList) session.getAttribute("chlorides");
				frm.setSchemes(schemes);
			} catch (Exception e) {
				System.out.println("exception in chloridesourceprint mode-- " + e);
			}
			page_to_be_displayed = "chlorideData";
		}

		if (mode != null && mode.equalsIgnoreCase("schemesData")) {
			try {

				if (frm.getSchemes() != null && frm.getSchemes().size() > 1) {
					frm.getSchemes().clear();
				}
				schemes = residualChlorineDAO.getSchemeDetails(frm);
				frm.setSchemes(schemes);
				session.setAttribute("schemes", schemes);
			} catch (Exception e) {
				System.out.println("exception in schemesData mode-- " + e);
			}
			page_to_be_displayed = "schemesData";
		}

		if (mode != null && mode.equalsIgnoreCase("SaveSchemes")) {
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {
					for (int i = 0; i < frm.getSchemes().size(); i++) {
					SMSBased_WQ_Schemes_Drought_Bean bean = frm.getSchemes().get(i);
					if (bean.getChecks() != null && bean.getChecks().equals("on")) {	
					
			

							if (bean.getAssetCode() == null || bean.getAssetCode() .equals("")) {
								message = "Invalid Input (Asset Code)";
								request.setAttribute("message", message);
								return mapping.findForward("schemesData");//
							}
							if (bean.getAssetName() == null) {
								message = "Invalid Input (Asset Name)";
								request.setAttribute("message", message);
								return mapping.findForward("schemesData");
							}
							if (bean.getSourceName() == null) {
								message = "Invalid Input (Source Name)";
								request.setAttribute("message", message);
								return mapping.findForward("schemesData");
							}
							if (bean.getSourceName() == null) {
								message = "Invalid Input (Source Name/Location)";
								request.setAttribute("message", message);
								return mapping.findForward("schemesData");
							}
							if (bean.getDateOfAction() == null) {
								message = "Invalid Input (Date of Action)";
								request.setAttribute("message", message);
								return mapping.findForward("schemesData");
							}
						}
					}
					
					message = residualChlorineDAO.updateSchemesDetails(frm, loggedUser);

					request.setAttribute("message", message);

					if (frm.getSchemes() != null && frm.getSchemes().size() > 1) {
						frm.getSchemes().clear();
					}


					schemes = residualChlorineDAO.getSchemeDetails(frm);
					frm.setSchemes(schemes);
					session.setAttribute("schemes", schemes);

				} catch (Exception e) {
					System.out.println("exception in SaveSchemes mode-- " + e);
				}
				page_to_be_displayed = "schemesData";
			}
		}

		if (mode != null && mode.equalsIgnoreCase("updateSchemes")) {
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {
					message = residualChlorineDAO.updateSchemesDetails(frm, loggedUser);

					request.setAttribute("message", message);

					if (frm.getSchemes() != null && frm.getSchemes().size() > 1) {
						frm.getSchemes().clear();
					}


					schemes = residualChlorineDAO.getSchemeDetails(frm);
					frm.setSchemes(schemes);
					session.setAttribute("schemes", schemes);

				} catch (Exception e) {
					System.out.println("exception in updateSchemes mode-- " + e);
				}
				page_to_be_displayed = "schemesDataView";
			}
		}

		if (mode != null && mode.equalsIgnoreCase("schemesDataView")) {
			try {

				if (frm.getSchemes1() != null && frm.getSchemes1().size() > 1) {
					frm.getSchemes1().clear();
				}

				schemes = residualChlorineDAO.getSchemeDetailsAll(frm);
				frm.setSchemes1(schemes);
				session.setAttribute("schemes1", schemes);

			} catch (Exception e) {
				System.out.println("exception in schemesDataView mode-- " + e);
			}
			page_to_be_displayed = "schemesDataView";
		}
		if (mode != null && mode.equalsIgnoreCase("schemesEdit")) {
			try {

				if (frm.getSchemes() != null && frm.getSchemes().size() > 1) {
					frm.getSchemes().clear();
				}

				String mobilenum = request.getParameter("smsmobile");
				String mesid = request.getParameter("mesid");
				sources = residualChlorineDAO.getAllSourcesDetails(frm);
				session.setAttribute("sources", sources);

				schemes = residualChlorineDAO.getSchemeDetailsEdit(frm, mobilenum, mesid);
				frm.setSchemes(schemes);
				session.setAttribute("schemes", schemes);

			}

			catch (Exception e) {
				System.out.println("exception in schemesEdit mode-- " + e);
			}
			page_to_be_displayed = "schemesEdit";
		}

		if (mode != null && mode.equalsIgnoreCase("droughtData")) {
			try {

				if (frm.getDrought() != null && frm.getDrought().size() > 1) {
					frm.getDrought().clear();
				}

				drought = residualChlorineDAO.getDroughtDetails(frm);
				frm.setDrought(drought);
				session.setAttribute("drought", drought);

			} catch (Exception e) {
				System.out.println("exception in droughtData mode-- " + e);
			}
			page_to_be_displayed = "droughtData";
		}

		if (mode != null && mode.equalsIgnoreCase("SaveDrought")) {
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {
					message = residualChlorineDAO.updateDroughtDetails(frm, loggedUser);

					request.setAttribute("message", message);

					if (frm.getDrought() != null && frm.getDrought().size() > 1) {
						frm.getDrought().clear();
					}

					drought = residualChlorineDAO.getDroughtDetails(frm);
					frm.setDrought(drought);
					session.setAttribute("drought", drought);

				} catch (Exception e) {
					System.out.println("exception in SaveDrought mode-- " + e);
				}
				page_to_be_displayed = "droughtData";
			}
		}
		if (mode != null && mode.equalsIgnoreCase("droughtDataView")) {

			try {

				if (frm.getDrought1() != null && frm.getDrought1().size() > 1) {
					frm.getDrought1().clear();
				}

				drought = residualChlorineDAO.getDroughtDetailsView(frm);
				frm.setDrought1(drought);
				session.setAttribute("drought1", drought);

			} catch (Exception e) {
				System.out.println("exception in droughtDataView mode-- " + e);
			}
			page_to_be_displayed = "droughtDataView";
		}

		if (mode != null && mode.equalsIgnoreCase("droughtEdit")) {

			try {

				if (frm.getDrought() != null && frm.getDrought().size() > 1) {
					frm.getDrought().clear();
				}

				drought = residualChlorineDAO.getDroughtDetailsEdit(frm);
				frm.setDrought(drought);
				session.setAttribute("drought", drought);

			} catch (Exception e) {
				System.out.println("exception in droughtEdit mode-- " + e);
			}
			page_to_be_displayed = "droughtEdit";
		}

		if (mode != null && mode.equalsIgnoreCase("ohsrData")) {
			try {

				if (frm.getOhsr() != null && frm.getOhsr().size() > 1) {
					frm.getOhsr().clear();
				}

				ohsr = residualChlorineDAO.getohsrDetails(frm);
				frm.setOhsr(ohsr);
				session.setAttribute("ohsr", ohsr);

			} catch (Exception e) {
				System.out.println("exception in ohsrData mode-- " + e);
			}
			page_to_be_displayed = "ohsrData";
		}

		if (mode != null && mode.equalsIgnoreCase("SaveOhsr")) {
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
			try {
				message = residualChlorineDAO.updateohsrDetails(frm, loggedUser);

				request.setAttribute("message", message);

				if (frm.getOhsr() != null && frm.getOhsr().size() > 1) {
					frm.getOhsr().clear();
				}

				ohsr = residualChlorineDAO.getohsrDetails(frm);
				frm.setOhsr(ohsr);
				session.setAttribute("ohsr", ohsr);

			} catch (Exception e) {
				System.out.println("exception in SaveOhsr mode-- " + e);
			}
			page_to_be_displayed = "ohsrData";
		}
		}

		if (mode != null && mode.equalsIgnoreCase("ohsrDataView")) {
			try {

				if (frm.getOhsr1() != null && frm.getOhsr1().size() > 1) {
					frm.getOhsr1().clear();
				}

				ohsr = residualChlorineDAO.getohsrView(frm);
				frm.setOhsr1(ohsr);
				session.setAttribute("ohsr1", ohsr);

			} catch (Exception e) {
				System.out.println("exception in ohsrDataView mode-- " + e);
			}
			page_to_be_displayed = "ohsrDataView";
		}

		if (mode != null && mode.equalsIgnoreCase("sourceprint")) {
			try {
				schemes = (ArrayList) session.getAttribute("schemes");
				frm.setSchemes(schemes);
			} catch (Exception e) {
				System.out.println("exception in sourceprint mode-- " + e);
			}
			page_to_be_displayed = "schemesData";
		}
		return mapping.findForward(page_to_be_displayed);
	}

	private void reset(SMSBased_WQ_Schemes_Drought_Form frm) {

		frm.setDistrict("");
		frm.setMandal("");
		frm.setPanchayat("");
		frm.setSchemes(new ArrayList<SMSBased_WQ_Schemes_Drought_Bean>());
		frm.setChlorides(new ArrayList<SMSBased_WQ_Schemes_Drought_Bean>());
		frm.setChlorides1(new ArrayList<SMSBased_WQ_Schemes_Drought_Bean>());
	}


}
