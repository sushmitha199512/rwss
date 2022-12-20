/*
 * Created on 28-Feb-2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.drought;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RWS_Drought;
import nic.watersoft.commons.RwsLocations;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * @author NIC Sai Parasad N
 * 
 * TODO To change the template for this generated type comment go to Window -
 * Preferences - Java - Code Style - Code Templates
 */
public class DroughtCumulativeAction extends Action {

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.apache.struts.action.Action#execute(org.apache.struts.action.ActionMapping,
	 *      org.apache.struts.action.ActionForm,
	 *      javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse)
	 */
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse arg3)
			throws Exception {
		String mode = request.getParameter("mode");
		ArrayList habs = new ArrayList();
		String page_to_be_displayed = "get2";
		String message = null;
		ArrayList districts = new ArrayList();
		ArrayList mandals = new ArrayList();

		DroughtCumulativeFrm frm = (DroughtCumulativeFrm) form;

		HttpSession session = request.getSession();
		SimpleDateFormat dateFormatter = new SimpleDateFormat("dd/MM/yyyy");
		String currentDate = dateFormatter.format(new Date());
		frm.setToDate(currentDate);
		session.setAttribute("toDate", currentDate);

		RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
		if (mode != null && mode.equalsIgnoreCase("get2")) {
			if (request.getParameter("special") != null
					&& request.getParameter("special").equals("reset")) {
				reset(frm, session);
			}
			try {
				rwsLocations = new RwsLocations(getDataSource(request));
				districts = rwsLocations.getDistricts();

				session.setAttribute("districts", districts);

				if (frm.getDist() != null && !frm.getDist().equals("")) {
					mandals = rwsLocations.getMandals(frm.getDist());
					session.setAttribute("districtCode", frm.getDist());
					session.setAttribute("mandals", mandals);
					session.setAttribute("habs", habs);

				} else {
					session.setAttribute("mandals", new ArrayList());
					session.setAttribute("habs", new ArrayList());

				}

				page_to_be_displayed = "get2";
			}

			catch (Exception e) {
				System.out.println("the error in Complaint get2 is " + e);
			}
		}
		if (mode != null && mode.equals("view")) {

			page_to_be_displayed = "view";

			String d = request.getParameter("dist");
			session.setAttribute("d", d);
			String m = request.getParameter("mand");
			session.setAttribute("m", m);
			habs.clear();

			RWS_Drought rwsdrought = new RWS_Drought();
			habs = rwsdrought.getHabitationstransport(d, m,
					getDataSource(request));
			session.setAttribute("habs", habs);
			frm.setHabs(habs);
			String dname = DroughtMasterData.getDistName(frm.getDist());
			String mname = DroughtMasterData.getMandName(frm.getDist(), frm
					.getMand());
			session.setAttribute("dname", dname);
			session.setAttribute("mname", mname);

		}
		if (mode != null && mode.equals("save")) {

			List resultData = new ArrayList();

			String dd = request.getParameter("dist");
			String mm = request.getParameter("mand");
			String h1 = request.getParameter("hab1");

			String finiancialYear = request.getParameter("financialYear");
			String toDate = request.getParameter("toDate");

			String[] records = h1.split(",");

			for (int i = 0; i < records.length - 1; i++) {

				DroughtHabitationRecords droughtHabitationRecords = new DroughtHabitationRecords();

				droughtHabitationRecords.setHabCode(records[i]);
				i++;
				droughtHabitationRecords.setTransportationEST(records[i]);

				i++;
				droughtHabitationRecords.setHiringOfSourcesEST(records[i]);

				i++;
				droughtHabitationRecords.setFlushingEST(records[i]);

				i++;
				droughtHabitationRecords.setDeepeningEST(records[i]);

				droughtHabitationRecords.setFinancialYear(finiancialYear);
				droughtHabitationRecords.setToDate(toDate);

				resultData.add(droughtHabitationRecords);

			}

			RWS_Drought rwsdrought = new RWS_Drought();
			String d1 = (String) session.getAttribute("d");
			String m1 = (String) session.getAttribute("m");
			Debug.println("********" + request.getParameter("dist"));
			int[] count = rwsdrought.saveHabitations(resultData, dd, mm);
			if (count.length > 0) {
				Debug.println("Commings");

				request.setAttribute("message",
						"Selected records saved successfully ");
			} else {
				request.setAttribute("message", "Failed to Save");
			}
			habs = rwsdrought.getHabitationstransport(dd, mm,
					getDataSource(request));
			session.setAttribute("habs", habs);
			page_to_be_displayed = "save";
			frm.setHabs(habs);

		}
		return mapping.findForward(page_to_be_displayed);

	}

	/**
	 * @param frm
	 * @param session
	 */
	private void reset(DroughtCumulativeFrm frm, HttpSession session) {

		frm.setDist("");
		frm.setMand("");
		session.setAttribute("habs", new ArrayList());
	}
}