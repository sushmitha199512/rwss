package nic.watersoft.contractor;

import java.io.IOException;
import java.io.PrintStream;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_ContractorCodeEntryChangeAct_frm extends Action {
	public rws_ContractorCodeEntryChangeAct_frm() {
	}

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		boolean exists = false;
		String message = null;
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		
		if (user == null) {

			return mapping.findForward("expire");
		}

		if (!(user.getUserId() != null && (user.getUserId().equals(Constants.ADMIN)
				|| user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");
		}
		
		ContractorForm frm = (ContractorForm) form;
		String mode = request.getParameter("mode");
		ArrayList contractors = new ArrayList();
		ArrayList works = new ArrayList();
		String headOfficeCode = "";
		String circleOfficeCode = "";
		ArrayList circles = new ArrayList();
		ArrayList divisions = new ArrayList();
		String circlename = "";
		ArrayList workscircles = new ArrayList();
		ContractorMasterData contractorMasterData = new ContractorMasterData();
		RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		if ((mode != null) && (mode.equalsIgnoreCase("get2"))) {
			contractorMasterData = new ContractorMasterData();
			try {
				headOfficeCode = user.getHeadOfficeCode();
				circleOfficeCode = user.getCircleOfficeCode();

				circlename = contractorMasterData.getCircleName(headOfficeCode,
						circleOfficeCode);
				frm.setCircleOfficeName(circlename);
				divisions = contractorMasterData.getDivisions(headOfficeCode,
						circleOfficeCode);
				session.setAttribute("divisions", divisions);
				workscircles = contractorMasterData
						.getWorkdetailscircledivisionwise(circleOfficeCode,
								frm.getDivisionOfficeCode());
				request.setAttribute("workscircles", workscircles);
				frm.setWorkscircles(workscircles);

				if ((circleOfficeCode != null)
						&& (circleOfficeCode.equals("00"))
						&& (!circleOfficeCode.equals(" "))) {
					circles = contractorMasterData.getCircles(headOfficeCode);
					session.setAttribute("circles", circles);
					divisions = contractorMasterData.getDivisions(
							headOfficeCode, frm.getCircleOfficeCode());
					session.setAttribute("divisions", divisions);
					workscircles = contractorMasterData
							.getWorkdetailscircledivisionwise(
									frm.getCircleOfficeCode(),
									frm.getDivisionOfficeCode());
					request.setAttribute("workscircles", workscircles);
					frm.setWorkscircles(workscircles);
				}

			} catch (Exception o) {
				System.out.println("Exception in get2 of rws_ContractorCodeEntryChangeAct_frm" + o);
			}

			mode = "get2";
		}

		if ((mode != null) && (mode.equalsIgnoreCase("data"))) {

			try {
				if ((request.getParameter("special") != null)
						&& (request.getParameter("special").equals("reset"))) {
					reset(frm);
				}

				String workid = request.getParameter("workId");
				request.setAttribute("workid", workid);
				contractorMasterData = new ContractorMasterData();

				works = contractorMasterData.getWorkcontractordetails(workid);
				session.setAttribute("works", works);
				frm.setWorks(works);

			} catch (Exception p) {
				System.out.println("Exception in data of rws_ContractorCodeEntryChangeAct_frm" + p);
			}

			mode = "data";
		}
		if ((mode != null) && (mode.equalsIgnoreCase("display"))) {
			try {
				String dd = request.getParameter("contractorName");
				contractors = contractorMasterData.getContractordetails(dd);
				request.setAttribute("contractors", contractors);

			} catch (Exception o) {
				System.out.println("Exception in display of rws_ContractorCodeEntryChangeAct_frm" + o);
			}
			mode = "display";
		}

		if ((mode != null) && (mode.equalsIgnoreCase("update"))) {
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
			try {
				exists = contractorMasterData.workidExists(frm.getWorkId());

				int count = contractorMasterData.updateContractorworks(
						frm.getWorkId(), frm.getContractorCode());
				if (count > 0) {
					message = "Contractor Updated";
				} else {
					message = "Contractor Not Updated";
				}

				request.setAttribute("message", message);

				works = contractorMasterData.getWorkcontractordetails(frm
						.getWorkId());
				session.setAttribute("works", works);
				frm.setWorks(works);

			} catch (Exception p) {
				System.out.println("Exception in update of rws_ContractorCodeEntryChangeAct_frm" + p);
			}
			mode = "closeWithMessage";
			
		}
		}

		return mapping.findForward(mode);
	}

	public void reset(ContractorForm frm) {
		frm.setCircleOfficeCode("");
		frm.setDivisionOfficeCode("");
		frm.setContractorCode("");
	}
}
