package nic.watersoft.BaseLineSurvey;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.RwsOffices;
import nic.watersoft.masters.RwsMasterData;

import org.apache.struts.action.Action;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class BaseLineAbstractAction extends Action {

	String mode;
	ArrayList districts = new ArrayList();
	ArrayList mandals = new ArrayList();
	ArrayList panchayats = new ArrayList();
	ArrayList villages = new ArrayList();
	ArrayList habs = new ArrayList();
	ArrayList commsantn = new ArrayList();

	String district;
	String mandal;
	String panchayat;
	String village;
	String hab;

	public void process(HttpSession session, BaseLineAbstractActionForm frm,
			HttpServletRequest request) {
		bls_comm_santnDAO commsantndao = new bls_comm_santnDAO();
		RwsOffices rwsOffices = new RwsOffices();
		try {
			if (mode.equals("data")) {

				districts = rwsOffices.getDistricts();
				session.setAttribute("districts", districts);
				// reset(frm, session);
			}

			/* Getting Mandal Details */
			if (mode.equals("mandal")) {

				district = frm.getDistrict();
				mandals = rwsOffices.getDistrictMandals(district);
				session.setAttribute("mandals", mandals);
				// reset(frm, session);

				System.out.println("mandals size is " + mandals.size());
			}
			/* Getting Panchayat Details */
			if (mode.equals("panchayat")) {
				district = frm.getDistrict();
				mandal = frm.getMandal();
				panchayats = rwsOffices.getPanchayats(district, mandal);
				session.setAttribute("panchayats", panchayats);
				// reset(frm, session);

			}
			/* Getting village Details */
			if (mode.equals("village")) {
				district = frm.getDistrict();
				mandal = frm.getMandal();
				panchayat = frm.getPanchayat();
				villages = rwsOffices.getVillages(district, mandal, panchayat);
				session.setAttribute("villages", villages);
				// reset(frm, session);

			}
			/* Getting Panchayat Details */
			if (mode.equals("hab")) {
				district = frm.getDistrict();
				mandal = frm.getMandal();
				panchayat = frm.getPanchayat();
				village = frm.getVillage();

				habs = RwsMasterData.getHabitations(district, mandal,
						panchayat, village, getDataSource(request));
				session.setAttribute("habitations", habs);
				// reset(frm, session);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

}
