
package nic.watersoft.drought;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RWS_Drought;
import nic.watersoft.commons.RwsLocationBean;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class WaterTransportAction extends Action {
	String PAGE_TO_BE_DISPLAY = "get2";

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest httpRequest,
			HttpServletResponse httpResponse) throws Exception {

		ArrayList districts = new ArrayList();
		ArrayList mandals = new ArrayList();
		ArrayList waterTransportDetails = new ArrayList();
		DroughtOperaions dop = new DroughtOperaions();
		WaterTransportFrm droughtForm = (WaterTransportFrm) form;
		ArrayList transportDetails = droughtForm.getTransportDetails();
		SimpleDateFormat dateFormatter = new SimpleDateFormat("dd/MM/yyyy");
		String currentDate = dateFormatter.format(new Date());
		String message = null;

		String mode = httpRequest.getParameter("mode");
		HttpSession session = httpRequest.getSession(true);

		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");

		if (user == null)
			return mapping.findForward("expire");

		if (!(user.getUserId() != null
				&& (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.DROUGHT_USER)
						|| user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId())|| Constants.IsEEUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");
		}
		if (mode != null && !mode.equalsIgnoreCase("save")) {

			session.setAttribute("transportDetails", droughtForm.getTransportDetails());
		}

		RwsLocations rwsLocations = new RwsLocations(getDataSource(httpRequest));

		if (mode != null && mode.equalsIgnoreCase("districts")) {

			session.setAttribute("districts", dop.getDistricts());

		} else if (mode != null && mode.equalsIgnoreCase("divisions")) {

			session.setAttribute("divisions", dop.getDivisions(droughtForm.getDistrict()));

		} else if (mode != null && mode.equalsIgnoreCase("mandals")) {

			session.setAttribute("mandals", dop.getMandals(droughtForm.getDistrict(), droughtForm.getDivision()));

		} else if (mode != null && mode.equalsIgnoreCase("get2")) {

			if (httpRequest.getParameter("special") != null && httpRequest.getParameter("special").equals("reset")) {
				reset(droughtForm, session);
			}

			try {
				rwsLocations = new RwsLocations(getDataSource(httpRequest));

				droughtForm.getTransportDetails().clear();
				waterTransportDetails.clear();
				transportDetails.clear();

				if (httpRequest.getParameter("currentDate") != null) {
					droughtForm.setCurrentDate(httpRequest.getParameter("currentDate"));

					droughtRecords(droughtForm, waterTransportDetails, session);
				}

				PAGE_TO_BE_DISPLAY = "get2";

			}

			catch (Exception e) {
				System.out.println("exception in watertransportAction get2 mode -- " + e);
			}

		} else if (mode != null && mode.equalsIgnoreCase("save")) {

			session = httpRequest.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = httpRequest.getParameter("token");
			if (storedToken.equals(token)) {
				int count = 0;
				transportDetails = (ArrayList) session.getAttribute("transportDetails");
				if (transportDetails != null) {

					for (int i = 0; i < transportDetails.size(); i++) {
						DialyDroughtDetailsBean droughtBean = (DialyDroughtDetailsBean) transportDetails.get(i);

						droughtBean.setDateEntered(httpRequest.getParameter("currentDate"));
						droughtBean.setDateOfEntry(httpRequest.getParameter("currentDate"));

						droughtBean.setTransportPopulationServed(Integer
								.parseInt(httpRequest.getParameter("item[" + i + "].transportPopulationServed")));

						droughtBean.setHiringPopulationServed(
								Integer.parseInt(httpRequest.getParameter("item[" + i + "].hiringPopulationServed")));

						droughtBean
								.setNoOfTrips(Float.parseFloat(httpRequest.getParameter("item[" + i + "].noOfTrips")));
						droughtBean.setTanker_Capacity(
								Float.parseFloat(httpRequest.getParameter("item[" + i + "].tanker_Capacity")));
						droughtBean.setTanker_QTY(
								Float.parseFloat(httpRequest.getParameter("item[" + i + "].tanker_QTY")));

						droughtBean.setTankerCostPerTrip(
								Double.parseDouble(httpRequest.getParameter("item[" + i + "].tankerCostPerTrip")));
						droughtBean.setTankerCost(
								Double.parseDouble(httpRequest.getParameter("item[" + i + "].tankerCost")));

						droughtBean.setTanker_Remarks(httpRequest.getParameter("item[" + i + "].tanker_Remarks"));

						droughtBean.setCattle_transportPopulationServed(Integer.parseInt(
								httpRequest.getParameter("item[" + i + "].cattle_transportPopulationServed")));
						droughtBean.setCattle_noOfTrips(
								Float.parseFloat(httpRequest.getParameter("item[" + i + "].cattle_noOfTrips")));
						droughtBean.setCattle_tanker_Capacity(
								Float.parseFloat(httpRequest.getParameter("item[" + i + "].cattle_tanker_Capacity")));
						droughtBean.setCattle_tanker_QTY(
								Float.parseFloat(httpRequest.getParameter("item[" + i + "].cattle_tanker_QTY")));

						droughtBean.setCattle_tankerCostPerTrip(Double
								.parseDouble(httpRequest.getParameter("item[" + i + "].cattle_tankerCostPerTrip")));
						droughtBean.setCattle_tankerCost(
								Double.parseDouble(httpRequest.getParameter("item[" + i + "].cattle_tankerCost")));

						droughtBean.setCattle_tanker_Remarks(
								httpRequest.getParameter("item[" + i + "].cattle_tanker_Remarks"));

						droughtBean.setAssetType(httpRequest.getParameter("item[" + i + "].assetType"));

						droughtBean.setPvtSourceHiredNo(
								Integer.parseInt(httpRequest.getParameter("item[" + i + "].pvtSourceHiredNo")));

						droughtBean.setPvtSourceQTY(
								Float.parseFloat(httpRequest.getParameter("item[" + i + "].pvtSourceQTY")));
						droughtBean.setPvtModeOfSupply(httpRequest.getParameter("item[" + i + "].pvtModeOfSupply"));

						droughtBean.setPvtRemarks(httpRequest.getParameter("item[" + i + "].pvtRemarks"));
						droughtBean.setPowerProblemType(httpRequest.getParameter("item[" + i + "].powerProblemType"));

						droughtBean
								.setPowerSupplyRemarks(httpRequest.getParameter("item[" + i + "].powerSupplyRemarks"));
						droughtBean.setChecks(httpRequest.getParameter("item[" + i + "].checks"));
					}
				}

				count = dop.insertRecords(transportDetails);

				if (count > 0) {
					message = "Saved Successfully";
					reset(droughtForm, session);

				} else {
					message = "Failed to save";
				}
				dop.close();

				httpRequest.setAttribute("message", message);
			}

		} else if (mode != null && mode.equalsIgnoreCase("addNew")) {

			RwsLocationBean rwsLocationBean = new RwsLocationBean();
			waterTransportDetails = (ArrayList) session.getAttribute("habtitions");
			waterTransportDetails.add(rwsLocationBean);
			session.setAttribute("habtitions", waterTransportDetails);

		}
		if (mode != null && mode.equalsIgnoreCase("delete")) {

			String habCode = httpRequest.getParameter("habCode");
			session.setAttribute("transportDetails", new ArrayList());

			waterTransportDetails.clear();
			if (dop.deleteDroughtHabitaionFromDialyEntry(habCode, droughtForm.getDataDate())) {
				message = "Deleted Successfully";
				transportDetails.clear();
				droughtRecords(droughtForm, waterTransportDetails, session);
			} else {
				message = "Delete Failed";
			}
			httpRequest.setAttribute("message", message);
			PAGE_TO_BE_DISPLAY = "get2";
		}

		return mapping.findForward(PAGE_TO_BE_DISPLAY);
	}

	public void droughtRecords(WaterTransportFrm droughtForm, ArrayList waterTransportDetails, HttpSession session) {

		session.setAttribute("transportDetails", new ArrayList());
		RWS_Drought rd = new RWS_Drought();
		ArrayList transportDetails = droughtForm.getTransportDetails();
		transportDetails.clear();
		waterTransportDetails.clear();

		if (droughtForm.getDistrict() != null && droughtForm.getDivision() != null) {
			transportDetails = rd.getSelectedHabitations(droughtForm.getMandal(), droughtForm.getDistrict(),
					droughtForm.getDivision());

			rd.getExistingData(transportDetails, null, transportDetails, droughtForm, session);

			session.setAttribute("transportDetails", transportDetails);

		}

	}

	private void reset(WaterTransportFrm form, HttpSession session) {
		form.setDistrict("");
		form.setMandal("");
		form.setDivision("");
		form.setCurrentDate("");
		ArrayList t = new ArrayList();
		t = (ArrayList) session.getAttribute("transportDetails");
		t.clear();
		session.setAttribute("transportDetails", new ArrayList());

	}
}