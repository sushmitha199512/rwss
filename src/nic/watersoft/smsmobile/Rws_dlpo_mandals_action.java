package nic.watersoft.smsmobile;

import org.apache.struts.action.Action;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class Rws_dlpo_mandals_action extends Action{
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String mode = "";
		if (request.getParameter("mode") != null) {
			mode = request.getParameter("mode");
		} else {
			mode = "dlpoMandalEntryFrm";
		}

		Rws_dlpoForm myForm = (Rws_dlpoForm) form;
		ArrayList districts = new ArrayList();
		ArrayList mandals = new ArrayList();
		ArrayList divisions = new ArrayList();
		ArrayList panchayats = new ArrayList();
		ArrayList divmandals = new ArrayList();
		
		
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
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		Rws_dlpoForm_dao dlpo = new Rws_dlpoForm_dao();

		String district = myForm.getDistrict();

		try {

			
			if (mode != null && mode.equals("init")) {
				
				reset1(myForm);
				mode="dlpoMandalEntryFrm";
			
			}
			districts = rwsOffices.getDistricts();
			session.setAttribute("districts", districts);
			session.setAttribute("divisions", divisions);
			session.setAttribute("divmandals", divmandals);

			if (district == null || district.equals("")) {
				district = user.getCircleOfficeCode();
				String dname = rwsOffices.getDistrictName(district);
				myForm.setDistrict(district);
				myForm.setDistrictName(dname);
				 String divCode=dlpo.getMaxValue(district).toString();
				myForm.setDivision(divCode);
				
				divmandals = rwsOffices.getMandals(district);
				session.setAttribute("divmandals", divmandals);
			}
			if (district != null || !district.equals("")) {
				 String divCode=dlpo.getMaxValue(district).toString();
					myForm.setDivision(divCode);
				divmandals = rwsOffices.getMandals(district);
				session.setAttribute("divmandals", divmandals);
			}

			
			if (mode != null && mode.equals("mandals")) {
				
				divmandals = rwsOffices.getMandals(district);
				session.setAttribute("divmandals", divmandals);

			}
			if (mode != null && mode.equals("editdivisions")) {
				String divcode="1";
				divisions = rwsOffices.getDivisions(divcode,district);
				session.setAttribute("divisions", divisions);

			}
			
			if (mode != null && mode.equals("editmandals")) {
				String divcode="1";
				divisions = rwsOffices.getDivisions(divcode,district);
				session.setAttribute("divisions", divisions);
				String subdiv="";
				
				divmandals = rwsOffices.getDivmandals(district,myForm.getDivision(),subdiv);
				session.setAttribute("divmandals", divmandals);

			}
			if (mode != null && mode.equals("view")) {
				ArrayList dlpoMandalDetails = new ArrayList();

				String districtName = rwsOffices.getDistrictName(myForm.getDistrict());
				
				request.setAttribute("selectedDistrict", districtName);
				session.setAttribute("dcode", myForm.getDistrict());
				session.setAttribute("divcode", myForm.getDivision());
				session.setAttribute("mcode", myForm.getDivmandals());
				dlpoMandalDetails = dlpo
						.getDLPOMandalDetails(myForm,districtName);
				session.setAttribute("dlpoMandalDetails", dlpoMandalDetails);
			}


			if (mode != null && mode.equals("save")) {
				session = request.getSession();
				String storedToken = (String) session.getAttribute("csrfToken");
				String token = request.getParameter("token");
				if (storedToken.equals(token)) {
				String hoc="1";
				divisions = rwsOffices.getDivisions(hoc,district);
				session.setAttribute("divisions", divisions);
				
				String  message = dlpo.insertDlpoMandal(myForm,getDataSource(request));
				request.setAttribute("message",message);
					
				reset(myForm);
				session.setAttribute("divmandals", new ArrayList());
			
			}
			}
			if (mode != null && mode.equals("update")) {
				session = request.getSession();
				String storedToken = (String) session.getAttribute("csrfToken");
				String token = request.getParameter("token");
				if (storedToken.equals(token)) {

				String hoc="1";
				divisions = rwsOffices.getDivisions(hoc,district);
				session.setAttribute("divisions", divisions);

				String  message = dlpo.updateDlpoMandal(myForm,getDataSource(request));
				request.setAttribute("message",message);
					
				reset(myForm);
				session.setAttribute("divmandals", new ArrayList());
			
			}
			}
			
			if (mode != null && mode.equals("Edit")) {
				
				myForm.setDistrict(request.getParameter("dcode"));
				myForm.setDivision(request.getParameter("divcode"));
				myForm.setDivisionName(request.getParameter("divisionName"));
				myForm.setOldCircle(request.getParameter("dcode"));
				myForm.setOldDivision(request.getParameter("divcode"));
				myForm.setOldMandal(request.getParameter("mcode"));
				
				
				String subdiv="";
				myForm.setDivmandals(request.getParameter("mcode"));
				divmandals = rwsOffices.getMandals(request.getParameter("dcode"));
				session.setAttribute("divmandals", divmandals);

				
			}

			if (mode != null && mode.equals("Delete")) {
				String dcode=request.getParameter("dcode");
				String mcode=request.getParameter("mcode");
				String divcode=request.getParameter("divcode");
				
				String  message = dlpo.deleteDlpoMandal(dcode,mcode,divcode);
				request.setAttribute("message",message);
				ArrayList dlpoMandalDetails = new ArrayList();
				String districtName = rwsOffices.getDistrictName(dcode);
				
				
				myForm.setDistrict(dcode);
				dlpoMandalDetails = dlpo
						.getDLPOMandalDetails(myForm,districtName);
				session.setAttribute("dlpoMandalDetails", dlpoMandalDetails);
				reset(myForm);
				session.setAttribute("divmandals", new ArrayList());
			}
			

		} catch (Exception e) {
			System.out.println("exception in rws_dlpo_mandals_action "+e);
			
		}
		return mapping.findForward(mode);

	}

	private void reset1(Rws_dlpoForm myForm) {
		String ar[] = null;
		myForm.setDistrict("");
		myForm.setDivision("");
		myForm.setDivisionName("");
		myForm.setDivmandals1(ar);
		
			
	}

	private void reset(Rws_dlpoForm myForm) {
		
		String ar[] = null;
		myForm.setDistrict("");
		myForm.setDivision("");
		myForm.setDivisionName("");
		myForm.setDivmandals1(ar);
		
		
		
	}

}
