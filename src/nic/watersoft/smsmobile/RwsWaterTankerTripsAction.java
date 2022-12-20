package nic.watersoft.smsmobile;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.drought.DroughtMasterData;

public class RwsWaterTankerTripsAction extends Action {	
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String mode="";
		mode = request.getParameter("mode");
	//System.out.println("mode"+mode);
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");
		if (!(user.getUserId() != null && (user.getUserId().equals(Constants.ADMIN) ||  user.getUserId().equals(Constants.DROUGHT_USER)
				|| user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId())|| Constants.IsEEUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");
		}		
		RwsWaterTankerTripsForm frm=(RwsWaterTankerTripsForm) form;
		RwsWaterTankerTripsDao dao=new  RwsWaterTankerTripsDao();
		ArrayList districts=new ArrayList();
		ArrayList mandals=new ArrayList();
		ArrayList habitations=new ArrayList();
		if (mode != null && mode.equalsIgnoreCase("data")) {
			if (request.getParameter("special") != null && request.getParameter("special").equals("reset")) {
				reset(frm);
			}
			try {
				districts = dao.getDroughtDistricts();
				session.setAttribute("districts", districts);
				frm.setFlag("save");
				if (frm.getDist() != null && !frm.getDist().equals("")) {
					mandals = dao.getDroughtMandals(frm.getDist());
					session.setAttribute("mandals", mandals);
				} else {
					session.setAttribute("mandals", new ArrayList());
				}
			/*	if (frm.getDist() != null && frm.getMand() != null && !frm.getMand().equals("")) {
					panchayats = dao.getDroughtPanchayats(frm
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
					int z = habitations.size();*/
				
				if (frm.getDist() != null && frm.getMand() != null) {
					habitations = dao.getDroughtHabitations(frm
							.getDist(), frm.getMand(), "", "");
					session.setAttribute("habitations", habitations);
				} else {
					session.setAttribute("habitations", new ArrayList());
				}
			}
			catch (Exception e) {
				System.out.println("exception in data mode of RwsWaterTankerTripsAction "+e );
			}
			mode = "data";		
		}else if (mode != null && mode.equalsIgnoreCase("save")) {
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {
				String msg = dao.saveWaterTankerTrips(frm);
				request.setAttribute("message",msg);	
				}catch (Exception e) {
					System.out.println("Exception in save mode of RwsWaterTankerTripsAction  "+e);
				}
			}
			mode="data";
			reset(frm);
		}
		else if (mode != null && mode.equalsIgnoreCase("view")) {
			try {
				frm.setTankerTripDetails(dao.getTankerTripDetails(frm));			
				frm.setDistrictName(DroughtMasterData.getDistName(frm.getDist()));
				frm.setMandalName(DroughtMasterData.getMandName(frm.getDist(),frm.getMand()));
			}catch (Exception e) {
				System.out.println("Exception in view mode of RwsWaterTankerTripsAction  "+e);
			}			
		}else if (mode != null && mode.equalsIgnoreCase("get")) {
			String habCode=request.getParameter("habCode");
			try {
				RwsWaterTankerTripsForm editfrm=new RwsWaterTankerTripsForm();
				editfrm = dao.getTankerTripDetailsForEdit(habCode);
				frm.setDist(editfrm.getDist());
				frm.setMand(editfrm.getMand());
				frm.setHabCode(editfrm.getHabCode());
				frm.setNoOfTrips(editfrm.getNoOfTrips());
				frm.setDate(editfrm.getDate());
				frm.setFlag("edit");
				}catch (Exception e) {
					System.out.println("Exception in save mode of RwsWaterTankerTripsAction  "+e);
				}		
			mode="data";			
		}else if (mode != null && mode.equalsIgnoreCase("modify")) {
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				try {
				String msg = dao.modifyWaterTankerTrips(frm);
				request.setAttribute("message",msg);	
				frm.setTankerTripDetails(dao.getTankerTripDetails(frm));			
				frm.setDistrictName(DroughtMasterData.getDistName(frm.getDist()));
				frm.setMandalName(DroughtMasterData.getMandName(frm.getDist(),frm.getMand()));
				}catch (Exception e) {
					System.out.println("Exception in save mode of RwsWaterTankerTripsAction  "+e);
				}
			}
			mode="view";
		}		
		return mapping.findForward(mode);
	}	
		public void reset(RwsWaterTankerTripsForm frm) {
			frm.setDist("");
			frm.setMand("");
			frm.setHabCode("");
			frm.setDate("");
			frm.setNoOfTrips(0);
		}	
}
