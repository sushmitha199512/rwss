package nic.watersoft.drought;

import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.http.*;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.masters.RwsMaster;
import org.apache.struts.action.*;

import nic.watersoft.commons.Debug.*;
import nic.watersoft.complaints.CompForm;
import nic.watersoft.complaints.ComplaintMasterData;

public class Rws_FlushingDeepeningAct_frm extends Action {
	public Rws_FlushingDeepeningAct_frm() {
	}

	//

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String page_to_be_displayed = " ";
		int ans = 0;
		String message = null;
		ArrayList districts = new ArrayList();
		ArrayList mandals = new ArrayList();
		ArrayList panchayats = new ArrayList();
		ArrayList habitations = new ArrayList();
		//added on 16-02-2015
		ArrayList year = new ArrayList();
		//end 16/02/2015
		RwsMaster rwsMaster = new RwsMaster();
		String f1 = "";
		//String d1="";
		int f = 0;
		int d = 0;

		int j = 0;
		int deleteCount = 0;
		String hab = "";
		boolean exits = false;
		ans = 0;
		String habcode = "";
		String habname = "";
		String dasset = "";
		String assetu = "";
		String assetdel = "";

		ArrayList villages = new ArrayList();
		ArrayList hps = new ArrayList();

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
		if (mode != null && mode.equalsIgnoreCase("data")) {
			if (request.getParameter("special") != null
					&& request.getParameter("special").equals("reset")) {
				reset(frm);
			}
			try {

				DroughtMasterData droughtMasterData = new DroughtMasterData();
				districts = droughtMasterData
						.getDroughtDistricts(getDataSource(request));
				session.setAttribute("districts", districts);
				if (frm.getDist().equals("") || frm.getDist() == null) {
					session.setAttribute("hps", new ArrayList());
				}

				if (frm.getDist() != null && !frm.getDist().equals("")) {
					mandals = droughtMasterData.getDroughtMandals(
							frm.getDist(), getDataSource(request));
					session.setAttribute("mandals", mandals);
				} else {
					session.setAttribute("mandals", new ArrayList());
				}

				if (frm.getDist() != null && frm.getMand() != null
						&& !frm.getMand().equals("")) {
					panchayats = droughtMasterData.getDroughtPanchayats(frm
							.getDist(), frm.getMand(), getDataSource(request));
					session.setAttribute("panchayats", panchayats);
				} else {
					session.setAttribute("panchayats", new ArrayList());
				}
				if (frm.getDist() != null && frm.getMand() != null
						&& frm.getPanch() != null && !frm.getPanch().equals("")) {
					villages = droughtMasterData.getDroughtVillages(frm
							.getDist(), frm.getMand(), frm.getPanch(),
							getDataSource(request));
					session.setAttribute("villages", villages);
				} else {
					session.setAttribute("villages", new ArrayList());
				}

				if (frm.getDist() != null && frm.getMand() != null
						&& frm.getPanch() != null && !frm.getVill().equals("")
						&& frm.getVill() != null) {
					habitations = droughtMasterData.getDroughtHabitations(frm
							.getDist(), frm.getMand(), frm.getPanch(), frm
							.getVill(), getDataSource(request));
					int z = habitations.size();
				//	Debug.println("z**********" + z);
					session.setAttribute("habitations", habitations);
				} else {
					session.setAttribute("habitations", new ArrayList());
				}

			}

			catch (Exception e) {
				System.out.println("exception in rws_flushingdeepeningact_frm data-- "+e );
			}
			page_to_be_displayed = "data";
		}
		
		if (mode != null && mode.equalsIgnoreCase("view")) {

			try {

				if (frm.getHabCode() != null) {
					String year1=request.getParameter("year");
					DroughtMasterData droughtMasterData = new DroughtMasterData();
					//f=DroughtMasterData.getFlush(frm.getHabCode());
					//d=DroughtMasterData.getDeep(frm.getHabCode());
					//Debug.println("f*********"+f);
					hps = droughtMasterData.getDroughtHps(frm.getHabCode(),year1,
							getDataSource(request));
					frm.setHps(hps);
				//	int p = hps.size();
				//	Debug.println("p" + p);
					/*
					 * if(f>0 && d>0) { f1="2"; } else if(f>0) { f1="1"; } else
					 * if(d>0) { f1="3"; }
					 */

					session.setAttribute("hps", hps);
					//session.setAttribute("f1",f1);
				}

			}

			catch (Exception e) {
			System.out.println("exception in rws_flushingdeepeningact_frm view mode -- "+e);
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

				String dd = request.getParameter("dist");
				String mm = request.getParameter("mand");
				String h1 = request.getParameter("hab1");
				String habcode1 = request.getParameter("habcode");
				String year1=request.getParameter("year");

				String[] records = h1.split(",");

				hps = (ArrayList) session.getAttribute("hps");

				int k = 0;
				for (i = 0; i < records.length - 1; i++) {

					DroughtFlushRecords droughtFlushRecords = (DroughtFlushRecords) hps
							.get(k);

					droughtFlushRecords.setThabitationCode(records[i]);
					i++;
					droughtFlushRecords.setHpCode(records[i]);
					i++;
					droughtFlushRecords.setFlushDeepening(records[i]);
					i++;
					droughtFlushRecords.setFlushDate(records[i]);
					i++;
					droughtFlushRecords.setFlushRemarks(records[i]);
					i++;
					droughtFlushRecords.setFlushDepth(records[i]);

					resultData.add(droughtFlushRecords);
					k++;

				}

				DroughtMasterData droughtMasterData = new DroughtMasterData();

				habcode = request.getParameter("habCode");
				String s1 = request.getParameter("hpcode");

				int count = droughtMasterData.saveDroughtFlushHabitations(
						resultData, habcode,year1);
				if (count > 0)
					request
							.setAttribute("message",
									"Selected Borewells / Selected Openwells / Selected Sources  Saved Successfully ");
				else
					request.setAttribute("message", "Failed to Save");

				hps = droughtMasterData.getDroughtHps(habcode1,year1,
						getDataSource(request));
				frm.setHps(hps);

			} catch (Exception z) {
			System.out.println("exception in rws_flushingdeepeningact_frm save mode -- "+z);
			}

			page_to_be_displayed = "save";

		}
		}

		return mapping.findForward(page_to_be_displayed);
	}

	public void reset(DroughtForm frm) {
		frm.setDist("");
		frm.setMand("");
		frm.setPanch("");
		frm.setVill("");
		frm.setHabCode("");
		
	}

}

