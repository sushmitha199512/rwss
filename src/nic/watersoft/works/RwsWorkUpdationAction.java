package nic.watersoft.works;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class RwsWorkUpdationAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		String MODE = "view";

		System.gc();

		int mb = 1024 * 1024;


		Runtime s_runtime = Runtime.getRuntime();
		long Used_memory = s_runtime.totalMemory() - s_runtime.freeMemory();
		System.gc();

		Used_memory = s_runtime.totalMemory() - s_runtime.freeMemory();
		System.gc();
		System.gc();


		DataSource dataSource = getDataSource(request);
		HttpSession session = request.getSession();

		RwsWorkUpdationActionForm actionForm = (RwsWorkUpdationActionForm) form;
		RwsWorkUpdationActionDAO rwsWorkUpdationActionDAO = new RwsWorkUpdationActionDAO();

		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		String circleCode = "";
		int divisionCode = 0;
		RwsOffices offices = null;
		if (user == null) {
			return mapping.findForward("expire");
		}
		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId()) || Constants.IsEEUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");	
		}
		
		String userId = user.getUserId();
		offices = new RwsOffices(dataSource);
		String mode = request.getParameter("mode");
		String mode1 = request.getParameter("mode1");

		if (mode != null && mode.equals("data")) {

			if (mode1 != null && mode1.equalsIgnoreCase("clear")) {
				reset(actionForm, session, true);
				session.setAttribute("specialCatList", new ArrayList());
				session.setAttribute("finYears", rwsWorkUpdationActionDAO
						.getFinYears());

				if (!(user.getUserId().equals("admin") || user.getUserId()
						.equals("100000"))) {
					session.setAttribute("fixcircle", "yes");

					circleCode = userId.substring(1, 3);
					divisionCode = actionForm.getCmbDivision();
					session.setAttribute("divisions", offices.getDivisions("1",
							circleCode));
					actionForm.setCircleCode(circleCode);
					if (mode1 == null)
						mode1 = "Divisions";
				} else {
					session.setAttribute("fixcircle", null);
					circleCode = actionForm.getCircleCode();
					divisionCode = actionForm.getCmbDivision();
				}

				ArrayList circles = offices.CircleCombo("1");
				session.setAttribute("circles", circles);

			}

			if (mode1 != null && mode1.equals("Divisions")) {

				reset(actionForm, session, true);

				ArrayList divisions = getDivisions(actionForm.getCircleCode());

				session.setAttribute("divisions", divisions);

			}
			if (mode1 != null && mode1.equals("programmes")) {

				ArrayList programms = rwsWorkUpdationActionDAO.getProgramms(
						actionForm.getCircleCode(),
						actionForm.getCmbDivision(), actionForm.getCategory());
				session.setAttribute("programs", new ArrayList());
				session.setAttribute("programs", programms);
			}

			if (mode1 != null && mode1.equals("works")) {

				ArrayList works = rwsWorkUpdationActionDAO.getWorks(actionForm
						.getCircleCode(), actionForm.getCmbDivision(),
						actionForm.getCategory(), actionForm.getProgramCode());
				session.setAttribute("works", new ArrayList());
				session.setAttribute("works", works);
			}

			if (mode1 != null && mode1.equals("workdetails")) {

				actionForm.setWorkIdList(actionForm.getWorkIdList1());
				rwsWorkUpdationActionDAO.getWorkDetails(actionForm, request);
				MODE = "view";

			}


			if (mode1 != null && mode1.equals("getSanctionedHabs")) {

				String workId = actionForm.getWorkid();
				ArrayList habitations = rwsWorkUpdationActionDAO
						.getSanctionedHabs(workId);
				if (habitations != null)
					request.setAttribute("habitations", habitations);

				return mapping.findForward("HabView");

			}


			if (mode1 != null && mode1.equals("close")) {
				request.setAttribute("message", "");
				return mapping.findForward("close");
			}


			if (mode1 != null && mode1.equals("saveTarget")) {
				session = request.getSession();
			    String storedToken = (String)session.getAttribute("csrfToken");
			    String token = request.getParameter("token");
			    if (storedToken.equals(token))
			    {	
				String vals = request.getParameter("selectedHabs");
				String habsList[] = vals.split(",");
				String finYear = request.getParameter("aapTargetYear");
				actionForm.setAapFinYear(finYear);

				rwsWorkUpdationActionDAO.saveAAPTargetHabitations(actionForm,
						habsList, request);
			    }
				return mapping.findForward("view");
				
			}

			if (mode1 != null && mode1.equals("deleteHabs")) {

				String vals = request.getParameter("selectedHabs");
				String habsList[] = vals.split(",");

				rwsWorkUpdationActionDAO.deleteAAPTargetHabitations(actionForm,
						habsList, request);
				return mapping.findForward("view");
				
			}

			if (mode1 != null && mode1.equals("workdetailsQuick")) {

				ArrayList circles = offices.CircleCombo("1");
				session.setAttribute("circles", circles);
				circleCode = userId.substring(1, 3);
				divisionCode = actionForm.getCmbDivision();
				session.setAttribute("divisions", offices.getDivisions("1",	circleCode));
				rwsWorkUpdationActionDAO.getWorkDetails(actionForm, request);
				MODE = "view";
			}

			if (mode1 != null && mode1.equals("update")) {
				session = request.getSession();
			    String storedToken = (String)session.getAttribute("csrfToken");
			    String token = request.getParameter("token");
			    if (storedToken.equals(token))
			    {	
				rwsWorkUpdationActionDAO.updateWork(actionForm, request,user.getUserId());
				reset(actionForm, session, true);
			    }
			}
		}
		return mapping.findForward(MODE);
	}

	private ArrayList getDivisions(String circleCode) {
		ArrayList divisions = new ArrayList();
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rset = null;
		try {
			conn = RwsOffices.getConn();
			String query = " SELECT division_office_code, division_office_name"
					+ " FROM rws_division_office_tbl "
					+ " where circle_office_code=? "
					+ " ORDER BY division_office_name";

			ps = conn.prepareStatement(query);
			ps.setString(1, circleCode);
			rset = ps.executeQuery();

			LabelValueBean labelValueBean = new LabelValueBean();
			labelValueBean.setValue("0");
			labelValueBean.setLabel("ALL");
			labelValueBean.setLabelValue("ALL");
			divisions.add(labelValueBean);

			while (rset.next()) {
				labelValueBean = new LabelValueBean();
				labelValueBean.setValue(rset.getString(1));
				labelValueBean.setLabel(rset.getString(2));
				labelValueBean.setLabelValue(rset.getString(2) + " - "
						+ rset.getString(1));
				divisions.add(labelValueBean);
			}
		} catch (Exception e) {
			Debug.println("Exception in getDivisions is "
					+ e);
		} finally {
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return divisions;
	}

	public void reset(RwsWorkUpdationActionForm actionForm,
			HttpSession session, boolean flag) {

		actionForm.setWorkid("");
		actionForm.setCcode("");
		actionForm.setCircle("");
		actionForm.setMileStoneAmount("");
		actionForm.setWorkIdList("");
		actionForm.setWorkIdList1("");
		actionForm.setWorkid("");
		actionForm.setWorkName("");
		actionForm.setCircle("");
		actionForm.setDivision("");
		actionForm.setSanctionedAmount("");
		actionForm.setSanctionedDate("");
		actionForm.setProgram("");
		actionForm.setSubProgName("");
		actionForm.setMileStoneAmount("");
		session.setAttribute("programs", new ArrayList());
		session.setAttribute("works", new ArrayList());
		actionForm.setCompletionDate("");
		actionForm.setBalanceEst("");
		actionForm.setCategory("");
		actionForm.setGroundingDate("");
		actionForm.setExpDuring("");
		actionForm.setPlain("");
		actionForm.setSc("");
		actionForm.setSt("");
		actionForm.setProbDateOfComp("");
		actionForm.setProbExp("");
		actionForm.setSpecialCatCode("");
		actionForm.setSubplanSubmitted("");
		actionForm.setProbExpNextYear("");
		actionForm.setSlsccDate("");
		actionForm.setpExp("");
		actionForm.setpExp1("");
		actionForm.setSanctionHabs("");
	}
}
