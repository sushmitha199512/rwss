package nic.watersoft.works;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_spillwork_admn_amt_change_act extends Action {
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
	ArrayList releaseDates = null;

	ArrayList programs = null;
	ArrayList circles = null;

	ArrayList subdivisions = null;

	String circleName = "";

	String divisionName = "";

	ArrayList refundWorks = new ArrayList();
	ArrayList financialYears = null;

	String checking[] = null;

	RefundWork refundWork = null;

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession(true);
		dataSource = getDataSource(request);

		RwsSpillRefundsDAO refundsDAO = new RwsSpillRefundsDAO();
		String circleOfficeCode = request.getParameter("coc");
		String divisionOfficeCode = request.getParameter("doc");
		String subdivisionOfficeCode = request.getParameter("soc");
		String workId = request.getParameter("workId");
		String search = request.getParameter("search");
		String mode1 = request.getParameter("mode1");
		String releaseDate = request.getParameter("releaseDate");
		int recCount = 0;
		String officeCode = "1" + circleOfficeCode + divisionOfficeCode + subdivisionOfficeCode;
		String mode = request.getParameter("mode");
		if (mode != null && mode.equals("data")) {

			RwsSpillRefundActionForm refundForm = (RwsSpillRefundActionForm) form;
			try {
				dataSource = getDataSource(request);

				RwsOffices offices = new RwsOffices(dataSource);

				RwsUser user = (RwsUser) session.getAttribute("RWS_USER");

				if (user == null)
					return mapping.findForward("expire");

				if (!(user.getUserId() != null && (user.getUserId().equals(Constants.EE_BUDGET)))) {
					return mapping.findForward("unAuthorise");
				}

				String usercode = user.getCircleOfficeCode();
				String divusercode = user.getDivisionOfficeCode();
				String subusercode = user.getSubdivisionOfficeCode();

				if (mode1 != null && mode1.equalsIgnoreCase("clear")) {

					session.setAttribute("releaseDates", new ArrayList());
					session.setAttribute("financialYears", new ArrayList());
					session.setAttribute("programs", new ArrayList());
				}

				if (!(user.getUserId().equals("admin") || user.getUserId().equals("100000")
						|| user.getUserId().equals("EE-Budget"))) {
					session.setAttribute("fixcircle", "yes");

					String userId = user.getUserId();

					circleCode = userId.substring(1, 3);
					divisionCode = refundForm.getCmbDivision();
					if (mode1 == null)
						mode1 = "Divisions";
				} else {
					session.setAttribute("fixcircle", null);
					circleCode = refundForm.getCircleCode();

					divisionCode = refundForm.getCmbDivision();

				}
				offices = new RwsOffices(dataSource);
				circles = offices.CircleCombo("1");
				session.setAttribute("circles", circles);

				if ((circleCode != null && mode1 != null && mode1.equalsIgnoreCase("Divisions"))) {

					dataSource = getDataSource(request);
					refundForm.setCircleCode(circleCode);
					offices = new RwsOffices(dataSource);

					divisions = offices.getDivisions1(refundForm.getCircleCode());
					session.setAttribute("divisions", divisions);

					programs = refundsDAO.getPrograms();
					session.setAttribute("programs", programs);

				}
				if (mode1 != null && mode1.equalsIgnoreCase("finYears")) {
					session.setAttribute("releaseDates", new ArrayList());
					session.setAttribute("programs", new ArrayList());
					refundForm.setFinYear("");
					financialYears = refundsDAO.getFinancialYears(refundForm.getBankOrPao());
					session.setAttribute("financialYears", financialYears);

				}
				if (mode1 != null && mode1.equalsIgnoreCase("releaseDates")) {
					circleCode = refundForm.getCircleCode();
					divisionCode = refundForm.getCmbDivision();
					releaseDates = refundsDAO.getReleaseDates(refundForm.getBankOrPao(), refundForm.getFinYear(),
							circleCode, Integer.toString(refundForm.getCmbDivision()));
					session.setAttribute("releaseDates", releaseDates);

				}

				circleCode = refundForm.getCircleCode();
				divisionCode = refundForm.getCmbDivision();
				if (mode1 != null && mode1.equalsIgnoreCase("getWorks")) {
					refundForm.setProgramCode("0");
					refundWorks = refundsDAO.getRefundWorks(circleCode, Integer.toString(refundForm.getCmbDivision()),
							refundForm.getBankOrPao(), releaseDate);
					refundForm.setRefundWorks(refundWorks);
				}
				if (mode1 != null && mode1.equalsIgnoreCase("getWorks1")) {
					refundWorks = refundsDAO.getAmountChangeWorks(refundForm.getCircleCode());
					refundForm.setRefundWorks(refundWorks);
				}
				if (mode1 != null && mode1.equalsIgnoreCase("save")) {

					String storedToken = (String) session.getAttribute("csrfToken");
					String token = request.getParameter("token");
					if (storedToken.equals(token)) {

						int recno = Integer.parseInt(request.getParameter("resultCount"));
						checking = new String[recno + 1];
						checking[0] = " ";
						recno = Integer.parseInt(request.getParameter("resultCount"));

						for (int i = 1; i < recno + 1; i++) {
							if (request.getParameter("check" + i) != null) {
								checking[i] = "1";

								String remarks = (request.getParameter("refundForm[" + (i - 1) + "].remarks") == null
										? "-"
										: request.getParameter("refundForm[" + (i - 1) + "].remarks"));
								String conamount = (request
										.getParameter("refundForm[" + (i - 1) + "].contractorAmountInRs") == null ? "-"
												: request.getParameter(
														"refundForm[" + (i - 1) + "].contractorAmountInRs"));
								String admamount = (request
										.getParameter("refundForm[" + (i - 1) + "].admissibleAmountInRs") == null ? "-"
												: request.getParameter(
														"refundForm[" + (i - 1) + "].admissibleAmountInRs"));
								String billNo = (request.getParameter("refundForm[" + (i - 1) + "].billNo") == null
										? "-"
										: request.getParameter("refundForm[" + (i - 1) + "].billNo"));

								String tablename = "RWS_DIV_WORK_SPILL_REFUND_TBL";

								recCount += refundsDAO.updateAdmissibleAmount(request.getParameter("check" + i),
										user.getUserId(), conamount, admamount, remarks, billNo);

							}

						}
						if (recCount >= 1) {

							session.setAttribute("message", "Saved Successfully");

							refundWorks = refundsDAO.getAmountChangeWorks(refundForm.getCircleCode());
							refundForm.setRefundWorks(refundWorks);

						} else {
							session.setAttribute("message", "Failed");
						}

					}
				}

				if (mode1 != null && mode1.equalsIgnoreCase("forwardenc")) {

					int recno = Integer.parseInt(request.getParameter("resultCount"));
					checking = new String[recno + 1];
					checking[0] = " ";
					recno = Integer.parseInt(request.getParameter("resultCount"));

					for (int i = 1; i < recno + 1; i++) {
						if (request.getParameter("check" + i) != null) {
							checking[i] = "1";
							String amount = request.getParameter("refundForm[" + (i - 1) + "].refundAmount");
							String chequeDate = (request.getParameter("refundForm[" + (i - 1) + "].chequeDate") == null
									? "-"
									: request.getParameter("refundForm[" + (i - 1) + "].chequeDate"));

							String tablename = "RWS_DIV_WORK_SPILL_REFUND_TBL";
							recCount += refundsDAO.forwardRefund(request.getParameter("check" + i), tablename);

						}

					}
					if (recCount >= 1) {

						session.setAttribute("message", "Forward Successfully");
					} else if (recCount == 0) {
						session.setAttribute("message", "You must save before forwarded to ENC");

					} else {
						session.setAttribute("message", "Failed");
					}

				}

			} catch (Exception e) {
				System.out.println("Exception in rws_spillwork_admn_amt_change_act-- " + e);
			}
		}

		return mapping.findForward(mode);

	}

}