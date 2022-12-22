package nic.watersoft.BaseLineSurvey;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.RwsOffices;
import nic.watersoft.masters.RwsMasterData;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class bls_comm_santnAction extends Action {
	ArrayList districts = new ArrayList();
	ArrayList mandals = new ArrayList();
	ArrayList panchayats = new ArrayList();
	ArrayList villages = new ArrayList();
	ArrayList habs = new ArrayList();
	ArrayList commsantn = new ArrayList();

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		HttpSession session = request.getSession();
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		bls_comm_santnDAO commsantndao = new bls_comm_santnDAO(
				getDataSource(request));

		String district = "", mandal = "", panchayat = "", village = "", hab = "";
		bls_comm_santnForm frm = (bls_comm_santnForm) form;
		String mode = frm.getMode();

		System.out.println("mode is " + mode);
		if (mode.equals("data")) {

			districts = rwsOffices.getDistricts();
			session.setAttribute("districts", districts);
			reset(frm, session);
		}

		/* Getting Mandal Details */
		if (mode.equals("mandal")) {

			district = frm.getDistrict();
			mandals = rwsOffices.getDistrictMandals(district);
			session.setAttribute("mandals", mandals);
			reset(frm, session);

			System.out.println("mandals size is " + mandals.size());
		}
		/* Getting Panchayat Details */
		if (mode.equals("panchayat")) {
			district = frm.getDistrict();
			mandal = frm.getMandal();
			panchayats = rwsOffices.getPanchayats(district, mandal);
			session.setAttribute("panchayats", panchayats);
			reset(frm, session);

		}
		/* Getting village Details */
		if (mode.equals("village")) {
			district = frm.getDistrict();
			mandal = frm.getMandal();
			panchayat = frm.getPanchayat();
			villages = rwsOffices.getVillages(district, mandal, panchayat);
			session.setAttribute("villages", villages);
			reset(frm, session);

		}
		/* Getting Panchayat Details */
		if (mode.equals("hab")) {
			district = frm.getDistrict();
			mandal = frm.getMandal();
			panchayat = frm.getPanchayat();
			village = frm.getVillage();
			habs = RwsMasterData.getHabitations(district, mandal, panchayat,
					village, getDataSource(request));
			session.setAttribute("habitations", habs);
			reset(frm, session);
		}
		/* Getting habitation Details */
		if (mode.equals("habdetails")) {
			district = frm.getDistrict();
			mandal = frm.getMandal();
			panchayat = frm.getPanchayat();
			village = frm.getVillage();
			hab = frm.getHabCode();

			commsantndao.getHabdet(getDataSource(request), hab, frm);

		}
		/* For saving data */
		if (mode.equals("save")) {
System.out.println("in save method");
			int updatedstatus = commsantndao.updateData(frm,
					getDataSource(request));
			if (updatedstatus > 0) {
				request.setAttribute("message", "Updated Succesfully");

			} else {
				request.setAttribute("message", "Updation Failed");
			}

			session.setAttribute("panchayats", new ArrayList());
			frm.reset(mapping, request);

		}

		return mapping.findForward(mode);
	}

	private void reset(bls_comm_santnForm frm, HttpSession session) {
		frm.setTotalCscConstructed("");
		frm.setTotalFunctionalCsc("");
		frm.setTotalDefunctCsc("");
		frm.setNoofAdditionalCscRequired("");
		frm.setSurveyDate("");

	}
}
