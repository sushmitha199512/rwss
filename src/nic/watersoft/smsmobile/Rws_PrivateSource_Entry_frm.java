package nic.watersoft.smsmobile;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsLocationBean;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.ValidationUtils;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import antlr.collections.List;

public class Rws_PrivateSource_Entry_frm extends Action {

	public Rws_PrivateSource_Entry_frm() {

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

		SmsRegistrationDAO dao = new SmsRegistrationDAO();
		Rws_privateSourceDAO privateDAO = new Rws_privateSourceDAO();

		String message = null;
		ArrayList<RwsLocationBean> districts = new ArrayList<RwsLocationBean>();

		ArrayList<RwsLocationBean> mandals = new ArrayList<RwsLocationBean>();
		ArrayList<List> panchayats = new ArrayList<List>();
		ArrayList<List> habitations = new ArrayList<List>();
		ArrayList<List> villages = new ArrayList<List>();
		ArrayList<List> sources = new ArrayList<List>();
		Rws_PrivateSourceForm frm = (Rws_PrivateSourceForm) form;

		ArrayList<Rws_PrivateSourceForm> SourceDetails = new ArrayList<Rws_PrivateSourceForm>();
		String nextSourceCode = "";
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

				if (frm.getCircleOfficeCode() != null && frm.getMand() != null && !frm.getMand().equals("")) {
					panchayats = rwsLocations.getPanchayats(frm.getCircleOfficeCode(), frm.getMand());
					session.setAttribute("panchayats", panchayats);
				} else {
					session.setAttribute("panchayats", new ArrayList());
				}
				//
				if (frm.getCircleOfficeCode() != null && frm.getMand() != null && frm.getPanch() != null
						&& !frm.getPanch().equals("")) {
					villages = rwsLocations.getVillages(frm.getCircleOfficeCode(), frm.getMand(), frm.getPanch());
					session.setAttribute("villages", villages);
				} else {
					session.setAttribute("villages", new ArrayList());
				}
				//
				if (frm.getCircleOfficeCode() != null && frm.getMand() != null && frm.getPanch() != null) {
					habitations = dao.getHabitations(frm.getCircleOfficeCode(), frm.getMand(), frm.getPanch(),
							frm.getVill());
					session.setAttribute("habitations", habitations);
				} else {
					session.setAttribute("habitations", new ArrayList());
				}

				if (frm.getHabCode() != null && !frm.getHabCode().equals("")) {
					nextSourceCode = privateDAO.getNextSource(frm.getHabCode());
					session.setAttribute("nextSourceCode", nextSourceCode);
					frm.setPsourceCode(nextSourceCode);
				} else {
					frm.setPsourceCode(nextSourceCode);
				}

				if (frm.getHabCode() != null && !frm.getHabCode().equals("")) {
					sources = privateDAO.getSources(frm.getCircleOfficeCode(), frm.getMand(), frm.getPanch(),
							frm.getVill(), frm.getHabCode());
					session.setAttribute("sources", sources);
				}

				page_to_be_displayed = "get2";

			} catch (Exception e) {
				System.out.println("exeception in Rws_PrivateSource_entry_frm " + e);
			}
		}

		if (mode != null && mode.equalsIgnoreCase("save")) {
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {


					ValidationUtils validation = new ValidationUtils();

					if (!validation.aphaWithSpaceValidator(frm.getPsourceLoc())) {
						message = "Invalid Input (location)";
						request.setAttribute("message", message);
						return mapping.findForward("get2");
					}
					if (!validation.aphaWithSpaceValidator(frm.getPsourceName())) {
						message = "Invalid Input (owner name)";
						request.setAttribute("message", message);
						return mapping.findForward("get2");
					}
					if (!validation.phoneValidator(frm.getPsourceMob())) {
						message = "Invalid Input (Mobile Number)";
						request.setAttribute("message", message);
						return mapping.findForward("get2");
					}
					if (!validation.ValidLatitude(frm.getPsourceLat())) {
						message = "Invalid Input (Latitude)";
						request.setAttribute("message", message);
						return mapping.findForward("get2");
					}
					if (!validation.ValidLongitude(frm.getPsourceLong())) {
						message = "Invalid Input (Longitude)";
						request.setAttribute("message", message);
						return mapping.findForward("get2");
					}
					if (!validation.teluguDataValidator(frm.getPsourceLocT())) {
						message = "Please enter only telugu alphabets in Private Source Location in Telugu";
						request.setAttribute("message", message);
						return mapping.findForward("get2");
					}


					String targetPath = getServlet().getServletContext().getRealPath("")  + "temp.jpg";

					message = Rws_privateSourceDAO.insertSourceDetails(frm, targetPath, getServlet());
					request.setAttribute("message", message);
					resetsave(frm);
					nextSourceCode = privateDAO.getNextSource(frm.getHabCode());

					session.setAttribute("nextSourceCode", nextSourceCode);

				} catch (Exception e) {
					System.out.println("exeception in Rws_PrivateSource_entry_frm " + e);
				}

				page_to_be_displayed = "save";
			} else {
			}
		}

		if (mode != null && mode.equalsIgnoreCase("view")) {

			try {

				SourceDetails = privateDAO.getPVTSourceDetails(frm.getCircleOfficeCode(), getDataSource(request));
				session.setAttribute("SourceDetails", SourceDetails);
				resetsave(frm);


			} catch (Exception e) {
				System.out.println("exception in view mode "+e);
			}
			page_to_be_displayed = "view";
		}

		if (mode != null && mode.equalsIgnoreCase("get")) {

			try {

				privateDAO.getPrivateDetails(request.getParameter("psourceCode"), frm);
				StringBuffer result = new StringBuffer();
				
				if(frm.getPsourceLocT()!=null){
				
		        for (char temp : frm.getPsourceLocT().toCharArray()) {
		            int decimal = (int) temp;
		            result.append("&#"+(decimal)+";");
		        }
				session.setAttribute("tname", result.toString());
				
				}else
				{
					session.setAttribute("tname", "");
				}

			} catch (Exception e) {
				System.out.println("exception in get mode "+e);
			}
			page_to_be_displayed = "get";
		}

		if (mode != null && mode.equalsIgnoreCase("update")) {
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {
					ValidationUtils validation = new ValidationUtils();

					if (!validation.aphaWithSpaceValidator(frm.getPsourceLoc())) {
						message = "Invalid Input (location)";
						request.setAttribute("message", message);
						return mapping.findForward("get");
					}
					if (!validation.aphaWithSpaceValidator(frm.getPsourceName())) {
						message = "Invalid Input (owner name)";
						request.setAttribute("message", message);
						return mapping.findForward("get");
					}
					if (!validation.phoneValidator(frm.getPsourceMob())) {
						message = "Invalid Input (Mobile Number)";
						request.setAttribute("message", message);
						return mapping.findForward("get");
					}
					if (!validation.ValidLatitude(frm.getPsourceLat())) {
						message = "Invalid Input (Latitude)";
						request.setAttribute("message", message);
						return mapping.findForward("get");
					}
					if (!validation.ValidLongitude(frm.getPsourceLong())) {
						message = "Invalid Input (Longitude)";
						request.setAttribute("message", message);
						return mapping.findForward("get");
					}
					if (!validation.teluguDataValidator(frm.getPsourceLocT())) {
						message = "Please enter only telugu alphabets in Private Source Location in Telugu";
						request.setAttribute("message", message);
						return mapping.findForward("get");
					}
					String targetPath = getServlet().getServletContext().getRealPath("") +"temp.jpg";

					message = Rws_privateSourceDAO.updateSourceDetails(frm, targetPath, getServlet());
					request.setAttribute("message", message);
					String sourceCode = request.getParameter("psourceCode");

					String dist = sourceCode.substring(0, 2);

					SourceDetails = privateDAO.getPVTSourceDetails(dist, getDataSource(request));

					session.setAttribute("SourceDetails", SourceDetails);

				} catch (Exception e) {
				System.out.println("exception in update mode "+e);
				}
				page_to_be_displayed = "view";

			}
		}

		if (mode != null && mode.equalsIgnoreCase("delete")) {

			try {

				String sourceCode = request.getParameter("psourceCode");

				message = Rws_privateSourceDAO.deleteSourceDetails(sourceCode);
				request.setAttribute("message", message);

				String dist = sourceCode.substring(0, 2);

				SourceDetails = privateDAO.getPVTSourceDetails(dist, getDataSource(request));

				session.setAttribute("SourceDetails", SourceDetails);

			} catch (Exception e) {
				System.out.println("exeception in Rws_PrivateSource_entry_frm " + e);
			}
			page_to_be_displayed = "view";

		}
		//added by nagendra 09-07-2020
		if (mode != null && mode.equals("privateSourceImagesDownload")) {
			//System.out.println("in action class downloadImages");
			////String message1 = privateDAO.downloadPrivateSourceImages(request);
			//System.out.println("message"+message);
			////request.setAttribute("message", message1);
			//reset(rwsDroughtNewsItemForm, session);
			page_to_be_displayed="privateSourceImagesDownload";
		}
		
		
		if (mode != null && mode.equals("privateSourceImagesDownloada")) {
			//System.out.println("in action class downloadImages&&&&&&&&&");
			String message1 = privateDAO.downloadPrivateSourceImages(request);
			//System.out.println("message"+message);
			request.setAttribute("message", message1);
			//reset(rwsDroughtNewsItemForm, session);
			page_to_be_displayed="privateSourceImagesDownloada";
		}
		
		//completed

		if (mode != null && mode.equalsIgnoreCase("sourceDestinationSave")) {
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {

				try {
					
					ValidationUtils validation = new ValidationUtils();

					if (!validation.aphaWithSpaceValidator(frm.getDestination())) {
						message = "Invalid Input (Destination)";
						request.setAttribute("message", message);
						return mapping.findForward("get2");
					}
					if (!validation.DecimalNumValidator(frm.getDistance())&& !validation.numValidator(frm.getDistance())) {
						message = "Invalid Input (distance)";
						request.setAttribute("message", message);
						return mapping.findForward("get2");
					}
					
					message = privateDAO.insertSourceDestinationDetails(frm);
					request.setAttribute("message", message);
					resetsave(frm);

				} catch (Exception e) {
					System.out.println("exeception in Rws_PrivateSource_entry_frm " + e);
				}

				page_to_be_displayed = "save";
			}
		}

		if (mode != null && mode.equalsIgnoreCase("sddview")) {

			try {

				SourceDetails = privateDAO.getSourceDestDetails(frm.getCircleOfficeCode(), getDataSource(request));
				session.setAttribute("SourceDetails", SourceDetails);
				resetsave(frm);

			} catch (Exception e) {
				System.out.println("exeception in Rws_PrivateSource_entry_frm " + e);
			}
			page_to_be_displayed = "view";
		}

		return mapping.findForward(page_to_be_displayed);

	}

	public void reset(Rws_PrivateSourceForm frm) {

		frm.setMand("");
		frm.setPanch("");
		frm.setHabCode("");
		frm.setCircleOfficeCode("");
		frm.setPsourceCode("");
		frm.setPsourceLat("");
		frm.setPsourceLoc("");
		frm.setPsourceLocT("");
		frm.setPsourceLong("");
		frm.setPsourceMob("");
		frm.setPsourceName("");
		frm.setDistance("");
		frm.setDestination("");
		frm.setFromDate("");
		frm.setToDate("");

	}

	public void resetsave(Rws_PrivateSourceForm frm) {

		frm.setMand("");
		frm.setPanch("");
		frm.setHabCode("");
		frm.setCircleOfficeCode("");
		frm.setPsourceCode("");
		frm.setPsourceLat("");
		frm.setPsourceLoc("");
		frm.setPsourceLocT("");
		frm.setPsourceLong("");
		frm.setPsourceMob("");
		frm.setPsourceName("");
		frm.setDistance("");
		frm.setDestination("");
		frm.setFromDate("");
		frm.setToDate("");
	}
}
