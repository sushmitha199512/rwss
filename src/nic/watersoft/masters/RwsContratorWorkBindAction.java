/*
 * Created on 29-05-2013
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.masters;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * @author RWSS_DPT1(Sai Prasad N)
 * 
 *         TODO To change the template for this generated type comment go to
 *         Window - Preferences - Java - Code Style - Code Templates
 */
public class RwsContratorWorkBindAction extends Action {

	DataSource dataSource = null;

	String circleCode = "";

	int divisionCode = 0;

	String subdivisionCode = "";

	String subdivisionName = "";

	String programmeCode = "";

	String subprogrammeCode = "";

	String mandal = "";

	String workCode = "";

	String assetCode = "";

	ArrayList divisions = null;

	ArrayList programs = null;

	ArrayList circles = null;

	ArrayList subdivisions = null;

	String circleName = "";

	String divisionName = "";

	String checking[] = null;

	/*
	 * (non-Javadoc)
	 * 
	 * @seeorg.apache.struts.action.Action#execute(org.apache.struts.action.
	 * ActionMapping, org.apache.struts.action.ActionForm,
	 * javax.servlet.http.HttpServletRequest,
	 * javax.servlet.http.HttpServletResponse)
	 */
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		dataSource = getDataSource(request);
		HttpSession session = request.getSession(true);
		String circleOfficeCode = request.getParameter("coc");
		String divisionOfficeCode = request.getParameter("doc");
		String subdivisionOfficeCode = request.getParameter("soc");
		String mode1 = request.getParameter("mode1");
		String userId = "";
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		userId = user.getUserId();
		RwsContratorWorkBindDAO rwsContratorWorkBindDAO = new RwsContratorWorkBindDAO();
		String officeCode = "1" + circleOfficeCode + divisionOfficeCode
				+ subdivisionOfficeCode;
		String mode = request.getParameter("mode");
		RwsContratorWorkBindBean workForm = (RwsContratorWorkBindBean) form;
		if (mode != null && mode.equals("data")) {

			try {
				RwsOffices offices = new RwsOffices(dataSource);
				String usercode = user.getCircleOfficeCode();
				String divusercode = user.getDivisionOfficeCode();
				String subusercode = user.getSubdivisionOfficeCode();
				System.out.println("UserCode" + usercode);

				if (workForm.getCircleCode() != null
						&& workForm.getCircleCode().equals("")) {
					workForm.setCircleCode(usercode);
				}

				if (mode1 != null && mode1.equalsIgnoreCase("clear")) {
					session.removeAttribute("allContractorsList");
					reset1(workForm, session);

				}

				offices = new RwsOffices(dataSource);

				if (mode1 != null && mode1.equals("workdetails")) {

					System.out.println("SSSworkId:" + workForm.getWorkIdList());
					System.out.println("SSSworkId:" + workForm.getWorkid());

					rwsContratorWorkBindDAO.getWorkDetails(workForm);

					if (session.getAttribute("allContractorsList") == null) {
						rwsContratorWorkBindDAO.getAllContractors(workForm);
						session.setAttribute("allContractorsList", workForm
								.getAllContractorsList());
					}

				}

				if (mode1 != null && mode1.equals("getworks")) {
					reset1(workForm, session);
					System.out.println("Circle Code:"
							+ workForm.getCircleCode() + "==="
							+ workForm.getCmbDivision());
					session.setAttribute("works", rwsContratorWorkBindDAO
							.getWorks(workForm.getCircleCode(), String
									.valueOf(workForm.getCmbDivision())));

				}
				if (mode1 != null && mode1.equalsIgnoreCase("save")) {

					rwsContratorWorkBindDAO.saveContractor(workForm, request);
					rwsContratorWorkBindDAO.getWorkDetails(workForm);
				}
				if (mode1 != null && mode1.equalsIgnoreCase("delete")) {
					String ccode = request.getParameter("contractor");
					rwsContratorWorkBindDAO.deleteContractor(workForm, ccode,
							request);
					rwsContratorWorkBindDAO.getWorkDetails(workForm);
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return mapping.findForward(mode);

	}

	/**
	 * @param workForm
	 * @param session
	 */
	private void reset1(RwsContratorWorkBindBean workForm, HttpSession session) {
		workForm.setAllContractorsList(new ArrayList());
		workForm.setContractorList(new ArrayList());
		workForm.setWorkIdList("");
		workForm.setWorkid("");
		workForm.setWorkName("");
		workForm.setBank("");
		workForm.setCircle("");
		workForm.setDivision("");
		workForm.setSanctionedAmount("");
		workForm.setSanctionedDate("");
		workForm.setProgram("");
		workForm.setSubProgName("");
		workForm.setMileStoneAmount("");

	}
}