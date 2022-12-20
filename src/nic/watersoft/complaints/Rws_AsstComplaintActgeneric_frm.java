
package nic.watersoft.complaints;

import java.io.File;
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

// Referenced classes of package nic.watersoft.complaints:
//            ComplaintMasterData, CompForm

public class Rws_AsstComplaintActgeneric_frm extends Action {

	public Rws_AsstComplaintActgeneric_frm() {
	}

	protected ActionForm buildCompForm(String complaintno, String mode, HttpServletRequest request) throws Exception {
		CompForm form = null;

		CompForm compForm = ComplaintMasterData.getComplaintnooutgeneric(complaintno, getDataSource(request));
		ArrayList districts = new ArrayList();
		ArrayList mandals = new ArrayList();
		ArrayList panchayats = new ArrayList();
		HttpSession session = request.getSession();
		ArrayList habitations = new ArrayList();

		ArrayList representatives = new ArrayList();

		RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
		if (compForm != null) {

			form = new CompForm();
			ComplaintMasterData complaintMasterData = new ComplaintMasterData();

			districts = rwsLocations.getDistricts();
			session.setAttribute("districts", districts);

			form.setDistrictName(compForm.getDistrictName());
			mandals = rwsLocations.getMandals(compForm.getDist());
			session.setAttribute("mandals", mandals);
			form.setMandalName(compForm.getMandalName());
			panchayats = rwsLocations.getPanchayats(compForm.getDist(), compForm.getMand());
			session.setAttribute("panchayats", panchayats);

			form.setPanchayatName(compForm.getPanchayatName());
			habitations = rwsLocations.getPanchayatHabitations(compForm.getDist(), compForm.getMand(),
					compForm.getPanch());
			session.setAttribute("habitations", habitations);

			form.setHabName(compForm.getHabName());
			
			form.setComplntno(compForm.getComplntno());
			
			form.setComplntdt(compForm.getComplntdt());
			
			form.setComplntdesc(compForm.getComplntdesc());
			
			form.setRepCode(compForm.getRepCode());
			representatives = complaintMasterData.getRepresentatives(getDataSource(request));
			session.setAttribute("representatives", representatives);
			
			form.setName(compForm.getName());
			
			form.setAddress(compForm.getAddress());
			
			form.setPhoneNo(compForm.getPhoneNo());
			form.setComponentName(compForm.getComponentName());
			form.setEmailId(compForm.getEmailId());
			form.setGrievanceEntryCategory(compForm.getGrievanceEntryCategory());
			form.setGrievanceRelatedTo(compForm.getGrievanceRelatedTo());
			form.setGrievanceCategory(compForm.getGrievanceCategory());

		}
		return form;
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");

		if (user == null) {
			return mapping.findForward("expire");
		}

		if (!(user.getUserId() != null && (user.getUserId().equals(Constants.ADMIN)
				|| user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId())))) {
			
			return mapping.findForward("unAuthorise");
		}

		String loggedUser = user.getUserId();

		String page_to_be_displayed = " ";
		ComplaintMasterData complaintMasterData = new ComplaintMasterData();
		int ans = 0;
		String message = null;
		ArrayList districts = new ArrayList();
		
		ArrayList mandals = new ArrayList();
		ArrayList panchayats = new ArrayList();
		ArrayList habitations = new ArrayList();
		
		
		ArrayList villages = new ArrayList();
		
		ArrayList representatives = new ArrayList();
		String compnos = "";
		CompForm frm = (CompForm) form;
		
		int p = 0;
		
		Collection complaintsgeneric = new ArrayList();
		String mode = request.getParameter("mode");

		RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
		if (mode != null && mode.equalsIgnoreCase("get2")) {
			if (request.getParameter("special") != null && request.getParameter("special").equals("reset")) {
				reset(frm);

				session.removeAttribute("compnos");
				session.removeAttribute("representatives");
			}
			try {
				complaintMasterData = new ComplaintMasterData();
				districts = rwsLocations.getDistricts();
				session.setAttribute("districts", districts);
				if (frm.getDist() == null || frm.getDist().equals("")) {
					session.removeAttribute("mandals");
					session.removeAttribute("panchayats");
					session.removeAttribute("villages");
					session.removeAttribute("habitations");
				}
				if (frm.getDist() != null && !frm.getDist().equals("")) {
					mandals = rwsLocations.getMandals(frm.getDist());
					session.setAttribute("mandals", mandals);

				} else {
					session.setAttribute("mandals", new ArrayList());
				}
				if (frm.getDist() != null && frm.getMand() != null && !frm.getMand().equals("")) {
					panchayats = rwsLocations.getPanchayats(frm.getDist(), frm.getMand());
					session.setAttribute("panchayats", panchayats);
				} else {
					session.setAttribute("panchayats", new ArrayList());
				}
				//
				if (frm.getDist() != null && frm.getMand() != null && frm.getPanch() != null
						&& !frm.getPanch().equals("")) {
					villages = rwsLocations.getVillages(frm.getDist(), frm.getMand(), frm.getPanch());
					session.setAttribute("villages", villages);
				} else {
					session.setAttribute("villages", new ArrayList());
				}
				//
				if (frm.getDist() != null && frm.getMand() != null && frm.getPanch() != null && frm.getVill() != null
						&& !frm.getVill().equals("")) {
					habitations = rwsLocations.getHabitations(frm.getDist(), frm.getMand(), frm.getPanch(),
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
		if (mode != null && mode.equalsIgnoreCase("view")) {
			complaintMasterData = new ComplaintMasterData();
			session.removeAttribute("compnos");

			
			try {

				String habitationcode = request.getParameter("habitationcode");
				

				String habitation = ComplaintMasterData.getHabname(habitationcode);
				request.setAttribute("habitation", habitation);

				representatives = complaintMasterData.getRepresentatives(getDataSource(request));
				session.setAttribute("representatives", representatives);

				if (frm.getHabCode() != null && !frm.getHabCode().equals("")) {
					compnos = ComplaintMasterData.getNextComplaintNoother(frm.getDist(), frm.getMand(), frm.getPanch(),
							getDataSource(request));
					
					session.setAttribute("compnos", compnos);
				}
			} catch (Exception e) {
				System.out.println("Exception in view mode:" + e);
			}
			page_to_be_displayed = "view";
		}

		if (mode != null && mode.equalsIgnoreCase("save")) {
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {

				

				try {

					String targetPath = getServlet().getServletContext().getRealPath("") + "temp.jpg";

					message = ComplaintMasterData.insertComplaintgeneric(frm, targetPath, getServlet(), loggedUser);
					request.setAttribute("message", message);

					resetsave(frm);
					compnos = ComplaintMasterData.getNextComplaintNoother(frm.getDist(), frm.getMand(), frm.getPanch(),
							getDataSource(request));

					session.setAttribute("compnos", compnos);

				} catch (Exception e) {
					System.out.println("The error is  Complaints Save" + e);
				}
			}
			page_to_be_displayed = "openNew";
		}

		if (mode != null && mode.equalsIgnoreCase("openNew"))
			page_to_be_displayed = "openNew";

		if (mode != null && mode.equalsIgnoreCase("cdelete")) {

			try {
				String comp = request.getParameter("complntno");
				complaintMasterData = new ComplaintMasterData();
				p = ComplaintMasterData.deletegeneric(comp, getDataSource(request));

				if (p > 0) {
					message = "Record Deleted Successfully";
				} else {
					message = "Record Cannot be Deleted";
				}
				request.setAttribute("message", message);

				
			} catch (Exception e) {
				System.out.println("Exception in cdelete mode:" + e);
			}
			page_to_be_displayed = "cview";
			
		}
		
		if (mode.equalsIgnoreCase("get"))
			try {
				form = buildCompForm(request.getParameter("complntno"), mode, request);
				if ("request".equalsIgnoreCase(mapping.getScope()))
					request.setAttribute(mapping.getAttribute(), form);
				else
					session.setAttribute(mapping.getAttribute(), form);
				page_to_be_displayed = "get";
			} catch (Exception e) {
				System.out.println("Exception in get mode:" + e);
			}
		
		if (mode.equalsIgnoreCase("edit")) {
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
			try {
				CompForm compForm = new CompForm();
				compForm.setComplntdesc(frm.getComplntdesc());
				compForm.setComplntdt(frm.getComplntdt());

				compForm.setRepCode(frm.getRepCode());
				compForm.setName(frm.getName());
				compForm.setAddress(frm.getAddress());
				compForm.setPhoneNo(frm.getPhoneNo());
				compForm.setComponentName(frm.getComponentName());
				String comp = frm.getComplntno();
				ans = ComplaintMasterData.updateComplaintnooutgeneric(compForm, comp, getDataSource(request));

				if (ans == 1)
					message = "Record Updated Successfully";
				else
					message = "Record Not Updated";
				request.setAttribute("message", message);
			} catch (Exception o) {
				System.out.println("Exception" + o);
			}
			return mapping.findForward("closeWithMessage");
		}
		}
		//
		if (mode != null && mode.equalsIgnoreCase("cview")) {

			try {

				complaintMasterData = new ComplaintMasterData();
				complaintsgeneric = ComplaintMasterData.getComplaintsgeneric(frm.getDist(), getDataSource(request));

				session.setAttribute("complaintsgeneric", complaintsgeneric);
				frm.setComplaintsgeneric(complaintsgeneric);

			} catch (Exception e) {
				System.out.println("Exception in cview mode:" + e);
			}
			page_to_be_displayed = "cview";
		}

		return mapping.findForward(page_to_be_displayed);
	}

	public void reset(CompForm frm) {
		frm.setDist("");
		frm.setMand("");
		frm.setPanch("");
		frm.setVill("");
		frm.setHabCode("");
		frm.setComplntdesc("");
		frm.setRepCode("");
		frm.setName("");
		frm.setAddress("");
		frm.setPhoneNo("");
		frm.setComponentName("");
		frm.setGrievanceCategory("");
		frm.setGrievanceRelatedTo("");
		frm.setEmailId("");
	}

	public void resetsave(CompForm frm) {
		frm.setDist("");
		frm.setMand("");
		frm.setPanch("");
		frm.setVill("");
		frm.setHabCode("");

		frm.setComplntdesc("");
		frm.setRepCode("");
		frm.setName("");
		frm.setAddress("");
		frm.setPhoneNo("");
		frm.setComponentName("");
		frm.setGrievanceCategory("");
		frm.setGrievanceRelatedTo("");
		frm.setGrievanceEntryCategory("");
		frm.setEmailId("");
	}
}
