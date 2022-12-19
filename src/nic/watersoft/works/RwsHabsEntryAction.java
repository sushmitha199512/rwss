package nic.watersoft.works;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class RwsHabsEntryAction extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm frm,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		RwsHabsEntryActionBean bean = (RwsHabsEntryActionBean) frm;
		HttpSession session = request.getSession(true);
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");

		if (!(user.getUserId() != null && (user.getUserId().equals(
				Constants.ADMIN)
				|| user.getUserId().equals(Constants.LAKH_USER)
				|| Constants.IsUser(user.getUserId()) || Constants
					.IsEEUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");
		}

		RwsHabLinkDAO rwsHabLinkDAO = new RwsHabLinkDAO();
		String message = "";
		String office_code="";
		String office_codez="";
		if (bean.getWorkId() != null) {
			request.setAttribute("workId", bean.getWorkId());
		}
		String type = request.getParameter("type");
		String table = "";
		if (type != null && type.equals("admin")) {
			if (bean.getWorkId() != null
					&& bean.getWorkId().substring(6, 8).equals("11")) {
				table = "rws_work_school_lnk_tbl ";
			} else if (bean.getWorkId() != null
					&& bean.getWorkId().substring(6, 8).equals("12")) {
				table = "rws_work_lab_lnk_tbl";
			} else {
				table = "RWS_ADMN_HAB_LNK_TBL";
			}
		} else if (type != null && type.equals("tech")) {
			table = "RWS_EST_NEW_HAB_LNK_TBL";
		} else if (type != null && type.equals("comp")) {
			table = "RWS_WORK_COMP_HAB_LNK_TBL";
		}
		String mode = request.getParameter("mode");
		if (mode != null && mode.equals("data")) {
			reset(bean);
		}
		
		if (mode != null && mode.equals("savesubdiv")) {
			String msg="";
			reset(bean);
			office_codez=rwsHabLinkDAO.getOfficeCode(bean, request);
			String subdivcode=bean.getSubdivname();
			String of_code=office_codez.substring(0,1)+""+office_codez.substring(1,3)+""+office_codez.substring(3,4)+""+subdivcode;
			int count=rwsHabLinkDAO.updateSubDivision( of_code, bean.getWorkId());
			if(count>=1){
			 msg="Subdivision Updated successfully.";
			}else
			{
				 msg="Please try again.";
			}
			
			
			if(msg!="")
			    request.setAttribute("message",msg);
		}
		if (mode != null && mode.equals("details")) {
			reset(bean);
			String wType = bean.getWorkId().substring(6, 8);
			if (wType != null && wType.equals("11")) {
				message = rwsHabLinkDAO.getSchoolDetails(bean, request);
				bean.setTypeOfWork("school");
			} else if (wType != null && wType.equals("12")) {
				message = rwsHabLinkDAO.getLabDetails(bean, request);
				bean.setTypeOfWork("lab");
			} else {
				//message = rwsHabLinkDAO.getWorkDetails(bean, request);
				office_code=rwsHabLinkDAO.getOfficeCode(bean, request);
				message = rwsHabLinkDAO.getWorkDetails(bean, request);
				ArrayList subdivisions = rwsHabLinkDAO.getSubdivisions(office_code.substring(0,1), office_code.substring(1,3), office_code.substring(3,4));
				session.setAttribute("subdivisions",subdivisions);
				
				
				bean.setTypeOfWork("hab");
			}
			if (!message.equals("")) {
				request.setAttribute("message", message);
			}

		}
		if (mode != null && mode.equals("adminhabs")) {

			ArrayList selectedHabCodes = rwsHabLinkDAO.getHabs(
					bean.getWorkId(), "RWS_ADMN_HAB_LNK_TBL");
			if (selectedHabCodes != null)
				request.setAttribute("selectedHabs", selectedHabCodes);

			return mapping.findForward("adminhabs");
		}
		if (mode != null && mode.equals("showschools")) {

			ArrayList selectedHabCodes = rwsHabLinkDAO.getSchools(
					bean.getWorkId(), "RWS_ADMN_HAB_LNK_TBL");
			if (selectedHabCodes != null)
				request.setAttribute("selectedHabs", selectedHabCodes);

			return mapping.findForward("showschools");
		}
		if (mode != null && mode.equals("techhabs")) {

			ArrayList selectedHabCodes = rwsHabLinkDAO.getHabs(
					bean.getWorkId(), "RWS_EST_NEW_HAB_LNK_TBL");
			if (selectedHabCodes != null)
				request.setAttribute("selectedHabs", selectedHabCodes);

			return mapping.findForward("adminhabs");
		}
		if (mode != null && mode.equals("comphabs")) {

			ArrayList selectedHabCodes = rwsHabLinkDAO.getHabs(
					bean.getWorkId(), "RWS_WORK_COMP_HAB_LNK_TBL");
			if (selectedHabCodes != null)
				request.setAttribute("selectedHabs", selectedHabCodes);

			return mapping.findForward("adminhabs");
		}

		if (mode != null && mode.equals("pickdistricts")) {
			String forwardName = "";
			RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
			ArrayList distss = rwsLocations.getDistricts();

			session.setAttribute("dists", distss);
			forwardName = "habLink";
			ArrayList workdists = rwsHabLinkDAO.getWorkDists(bean.getWorkId(),
					table);
			if (workdists == null
					|| (workdists != null && workdists.size() == 0)) {

				workdists.add(0, bean.getWorkId().substring(4, 6));
			}
			request.setAttribute("assetdists", workdists);
			return mapping.findForward(forwardName);
		}
		if (mode != null && mode.equals("carryHabs")) {
			session = request.getSession();
		    String storedToken = (String)session.getAttribute("csrfToken");
		    String token = request.getParameter("token");
		    if (storedToken.equals(token))
		    {
			String forwardName = "";
			String workId = request.getParameter("workId");
			String[] habs = request.getParameterValues("habs");
			message = rwsHabLinkDAO.saveHabs(workId, habs, type);
			forwardName = "close";
			request.setAttribute("message", message);
			return mapping.findForward(forwardName);
		    }
		}

		if (mode != null && mode.equals("pickmandals")) {
			String forwardName = "";
			String code = bean.getWorkId().substring(6, 8);
			request.setAttribute("SanctionedHabs",
					rwsHabLinkDAO.getSanctionedHabs(bean.getWorkId(), table));
			String circleOfficeCode = bean.getWorkId().substring(4, 6);
			ArrayList mandals = rwsHabLinkDAO.getMandals(circleOfficeCode);
			session.setAttribute("mandals", mandals);
			if (code != null && code.equals("11")) {
				forwardName = "Mandal-school";
			} else if (code != null && code.equals("11")) {
				forwardName = "Mandal-Lab";
			} else {
				forwardName = "pickmandals";
			}
			return mapping.findForward(forwardName);

		}

		if (mode != null && mode.equals("pickhabs")) {

			String workId = request.getParameter("workId");

			String temp = request.getParameter("selectedMcodes");
			String mcodes[] = temp.split("@@");
			for (int i = 0; i < mcodes.length; i++) {

			}

			ArrayList sanctionedHabs = rwsHabLinkDAO.getSanctionedHabs(
					bean.getWorkId(), table);
			ArrayList habitations = rwsHabLinkDAO.getHabsInMandals(workId,
					sanctionedHabs, mcodes);
			if (habitations != null)
				request.setAttribute("habitations", habitations);

			return mapping.findForward("pickhabs");

		}
		if (mode != null && mode.equals("District-Labs")) {
			RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
			ArrayList districts = rwsLocations.getDistricts();
			request.setAttribute("workId", bean.getWorkId());
			session.setAttribute("districts", districts);

			return mapping.findForward("District-Labs");

		}
		if (mode != null && mode.equals("pickschools")) {

			String workId = request.getParameter("workId");

			request.setAttribute("proposalId", workId);

			String temp = request.getParameter("selectedMcodes");
			String mcodes[] = temp.split("@@");
			for (int i = 0; i < mcodes.length; i++) {

			}
			ArrayList sanctionedHabs = rwsHabLinkDAO.getSanctionedSchools(
					bean.getWorkId(), table);

			request.setAttribute("selectedHabs", sanctionedHabs);
			ArrayList habitations = rwsHabLinkDAO.getHabsInMandals(workId,
					sanctionedHabs, mcodes);
			if (habitations != null)
				request.setAttribute("newhabitations", habitations);

			return mapping.findForward("pickschools");

		}
		if (mode != null && mode.equals("picklabs")) {

			String workId = request.getParameter("workId");

			request.setAttribute("proposalId", workId);

			String temp = request.getParameter("selectedMcodes");
			String mcodes[] = temp.split("@@");
			for (int i = 0; i < mcodes.length; i++) {

			}
			ArrayList sanctionedHabs = rwsHabLinkDAO.getSanctionedSchools(
					bean.getWorkId(), table);

			request.setAttribute("selectedHabs", sanctionedHabs);
			ArrayList habitations = rwsHabLinkDAO.getHabsInMandals(workId,
					sanctionedHabs, mcodes);
			if (habitations != null)
				request.setAttribute("newhabitations", habitations);

			return mapping.findForward("pickschools");

		}
		if (mode != null && mode.equals("showlabs")) {

			ArrayList selectedHabCodes = rwsHabLinkDAO.getLabs(
					bean.getWorkId(), "rws_work_lab_lnk_tbl");
			if (selectedHabCodes != null)
				request.setAttribute("selectedHabs", selectedHabCodes);

			return mapping.findForward("showlabs");
		}
		return mapping.findForward("data");
	}

	/**
	 * @param bean
	 */
	private void reset(RwsHabsEntryActionBean bean) {
		bean.setWorkName("");
		bean.setCoveredHabs("");
		bean.setPartialDate("");
		bean.setFinancialDate("");
		bean.setPhisicalDate("");
		bean.setIsTechSancationed("");
		bean.setIsCompletion("");
		bean.setSanctionedAmount("");
		bean.setSanctionedDate("");
		bean.setSanctionedHabs("");
		bean.setTsAmount("");
		bean.setTsDate("");
		bean.setTsNo("");
		bean.setProgramName("");
		bean.setSubProgName("");
		bean.setSanctionedDate("");
		bean.setIsAdmnSanction("");

	}

}