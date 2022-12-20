package nic.watersoft.drought;

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
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_WaterTransportHabAct_frm extends Action {
	public rws_WaterTransportHabAct_frm() {
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String page_to_be_displayed = " ";
		String message = null;
		ArrayList districts = new ArrayList();
		ArrayList mandals = new ArrayList();
		ArrayList panchayats = new ArrayList();
		ArrayList habs = new ArrayList();
		ArrayList categories = new ArrayList();
		int j = 0;
		String hab = "";
		ArrayList thabs = new ArrayList();

		DroughtForm droughtForm = new DroughtForm();
		DroughtForm frm = (DroughtForm) form;
		int i = 0;
		String mode = request.getParameter("mode");

		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		// Debug.println("user:" + user);
		if (user == null)
			return mapping.findForward("expire");

		if (!(user.getUserId() != null && (user.getUserId().equals(Constants.ADMIN) ||  user.getUserId().equals(Constants.DROUGHT_USER)
				|| user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId())|| Constants.IsEEUser(user.getUserId())))) {
			// System.out.println("USER IN ACTION"+user.getUserId());
			return mapping.findForward("unAuthorise");
		}

		RwsLocations rwsLocations = new RwsLocations(getDataSource(request));

		if (mode != null && mode.equalsIgnoreCase("get2")) {
			if (request.getParameter("special") != null && request.getParameter("special").equals("reset")) {
				reset(frm);
			}
			try {
				rwsLocations = new RwsLocations(getDataSource(request));
				districts = rwsLocations.getDistricts();

				session.setAttribute("districts", districts);

				if (frm.getDist() != null && !frm.getDist().equals("")) {
					mandals = rwsLocations.getMandals(frm.getDist());
					session.setAttribute("mandals", mandals);
				} else if (frm.getDist() != null && !frm.getDist().equals("") && frm.getMand() != null
						&& !frm.getMand().equals("")) {
					panchayats = rwsLocations.getPanchayats(frm.getDist(), frm.getMand());
					session.setAttribute("panchayat", panchayats);
				}

				else {
					session.setAttribute("mandals", new ArrayList());
					session.setAttribute("panchayats", new ArrayList());
				}

				page_to_be_displayed = "get2";
			}

			catch (Exception e) {
				System.out.println("the error in rws_watertransporthab get2 is " + e);
			}
		}
		if (mode != null && mode.equalsIgnoreCase("cview")) {
			try {

				// System.out.println("Comming");
				DroughtMasterData droughtMasterData = new DroughtMasterData();

				String d = request.getParameter("dist");
				session.setAttribute("d", d);
				String m = request.getParameter("mand");
				String p = request.getParameter("panchayath");
				String droughtYear = request.getParameter("droughtYear");
				session.setAttribute("m", m);
				session.setAttribute("p", p);
				habs.clear();

				categories = droughtMasterData.getCategories();
				session.setAttribute("categories", categories);

				habs = droughtMasterData.getHabitationstransport1(d, m, p, getDataSource(request), droughtYear);
				session.setAttribute("habs", habs);
				frm.setHabs(habs);
				String dname = DroughtMasterData.getDistName(frm.getDist());
				String mname = DroughtMasterData.getMandName(frm.getDist(), frm.getMand());
				String pname = DroughtMasterData.getPanchayatName(frm.getDist(), frm.getMand(), frm.getPanchayath());
				session.setAttribute("dname", dname);
				session.setAttribute("mname", mname);
				session.setAttribute("pname", pname);
				Date dt = new Date(System.currentTimeMillis());
				// System.out.println("DDDD"+droughtYear);
				String currentDate = "";

				if (frm.getDroughtYear() == null || frm.getDroughtYear().equals("null")) {
					currentDate = Integer.toString(dt.getYear() + 1900);
					droughtYear = currentDate;
				}
				String dmd = DroughtMasterData.isDroughtmandal(d, m, droughtYear);
				frm.setDroughtMandal(dmd);
				// session.setAttribute("droughtMandal",dmd);

			} catch (Exception z) {
				System.out.println("exception of rws_WaterTransportHabAct_frm cview " + z);
			}
			page_to_be_displayed = "cview";

		}
		//
		if (mode != null && mode.equalsIgnoreCase("view")) {
			try {

				DroughtMasterData droughtMasterData = new DroughtMasterData();

				String d = request.getParameter("dist");

				String m = request.getParameter("mandal");
				String p = request.getParameter("panchayath");

				thabs = droughtMasterData.getHabitationsdetails1(frm.getDist(), frm.getMand(), frm.getPanchayath(),
						getDataSource(request));

				session.setAttribute("thabs", thabs);
				frm.setThabs(thabs);
				String dname = DroughtMasterData.getDistName(frm.getDist());
				String mname = droughtMasterData.getMandName(frm.getDist(), frm.getMand());
				String pname = droughtMasterData.getPanchayatName(frm.getDist(), frm.getMand(), frm.getPanchayath());

				session.setAttribute("dname", dname);
				session.setAttribute("mname", mname);
				session.setAttribute("pname", pname);

			} catch (Exception z) {
				System.out.println("exception of rws_WaterTransportHabAct_frm view " + z);
			}
			page_to_be_displayed = "view";

		}

		//
		if (mode != null && mode.equalsIgnoreCase("save")) {
			
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				
			ArrayList resultData = new ArrayList();
			try {
				// System.out.println("mmode in save");

				String dd = request.getParameter("dist");
				String mm = request.getParameter("mand");
				String pp = request.getParameter("panchayath");
				// System.out.println("pp save" + pp);
				String h1 = request.getParameter("hab1");
				String h2 = h1.substring(1, h1.length());
				// System.out.println("h2" + h2);
				// Debug.println("Distrcit"+dd);
				// Debug.println("h1 anupama" + h1);
				// System.out.println("Drought Mandal:"+droughtForm.getDroughtMandal());
				String droughtYear = request.getParameter("droughtYear");
				String droughtMandal = request.getParameter("droughtMandal");
				if (droughtMandal != null && !droughtMandal.equals("")) {
					new DroughtMasterData().saveDroughtMandal(dd, mm, droughtYear, droughtMandal);

				}

				// System.out.println("Original String1:"+h1);
				// System.out.println("String Length:"+h1.length());

				// System.out.println("Original String:"+h2);
				// System.out.println("String Length:"+h2.length());

				String[] records = h1.split(",");

				// System.out.println("RecLength:" + records.length);

				for (i = 0; i < records.length - 1; i++) {

					DroughtHabitationRecords droughtHabitationRecords = new DroughtHabitationRecords();

					// System.out.println("Habcode@@@@:" + records[i]);
					droughtHabitationRecords.setHabCode(records[i]);
					i++;
					droughtHabitationRecords.setCauseOFScarcity(records[i]);
					i++;
					droughtHabitationRecords.setTransportation(records[i]);
					i++;
					droughtHabitationRecords.setHiringOfSources(records[i]);
					i++;
					droughtHabitationRecords.setFlushing(records[i]);
					i++;
					droughtHabitationRecords.setDeepening(records[i]);
					i++;
					droughtHabitationRecords.setPowerProblem(records[i]);
					i++;
					droughtHabitationRecords.setFrmDate(records[i]);
					i++;
					droughtHabitationRecords.setToDate(records[i]);

					i++;
					droughtHabitationRecords.setTransportationEST(records[i]);

					i++;
					droughtHabitationRecords.setHiringOfSourcesEST(records[i]);

					i++;
					droughtHabitationRecords.setFlushingEST(records[i]);

					i++;
					droughtHabitationRecords.setDeepeningEST(records[i]);

					i++;
					droughtHabitationRecords.setPowerProblemEST(records[i]);

					i++;
					droughtHabitationRecords.setTypeOfWork(records[i]);
					i++;
					droughtHabitationRecords.setWorkESTCOST(records[i]);
					i++;
					droughtHabitationRecords.setRemarks(records[i]);
					i++;
					droughtHabitationRecords.setDeepenOwNum(records[i]);
					i++;
					droughtHabitationRecords.setDeepenOwEst(records[i]);
					i++;
					droughtHabitationRecords.setSstNum(records[i]);
					i++;
					droughtHabitationRecords.setSstEst(records[i]);
					i++;
					droughtHabitationRecords.setSstScheme(records[i]);

					resultData.add(droughtHabitationRecords);

				}

				DroughtMasterData droughtMasterData = new DroughtMasterData();

				int[] count = droughtMasterData.saveHabitations(resultData, dd, mm, pp, droughtYear);
				if (count.length > 0)
					request.setAttribute("message", "Selected Habitations Saved Successfully ");
				else
					request.setAttribute("message", "Failed to Save");
				
				habs = droughtMasterData.getHabitationstransport(dd, mm, pp, getDataSource(request), droughtYear);
				// habs=droughtMasterData.getHabitationstransport(d1,m1,getDataSource(request));
				session.setAttribute("habs", habs);
				frm.setHabs(habs);

			} catch (Exception z) {
				System.out.println("exception of rws_WaterTransportHabAct_frm save " + z);
			}
				
			// Debug.println("1" + page_to_be_displayed);
			page_to_be_displayed = "save";
			// Debug.println("2" + page_to_be_displayed);
			}
		} 
		
		else if (mode != null && mode.equals("delete")) {
			
			DroughtMasterData droughtMasterData = new DroughtMasterData();
			page_to_be_displayed = "cview";
			System.out.println("DroughtHab:" + request.getParameter("habCode"));
			int res = droughtMasterData.deleteDroughtHab(request.getParameter("habCode"), frm.getDroughtYear());
			if (res > 0) {
				request.setAttribute("message", " Deleted Unchecked Habitations  Successfully ");
			}

			String dd = request.getParameter("dist");
			String mm = request.getParameter("mand");
			String pp = request.getParameter("panchayath");
			try {
				habs = droughtMasterData.getHabitationstransport(dd, mm, pp, getDataSource(request),
						frm.getDroughtYear());
				// habs=droughtMasterData.getHabitationstransport(d1,m1,getDataSource(request));
				session.setAttribute("habs", habs);
				frm.setHabs(habs);
			} catch (Exception e) {
				System.out.println("exception of rws_WaterTransportHabAct_frm delete " + e);
			}

		} else if (mode != null && mode.equals("redirect")) {

			page_to_be_displayed = "redirect";
		}

		return mapping.findForward(page_to_be_displayed);
	}

	public void reset(DroughtForm frm) {
		frm.setDist("");
		frm.setMand("");

	}

}
