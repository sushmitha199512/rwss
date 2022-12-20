package nic.watersoft.works;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
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

public class Rws_Rfd_Trainings_Action extends Action {

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Rws_Rfd_Trainings_Frm frm = (Rws_Rfd_Trainings_Frm) form;

		String page_to_be_displayed = " ";
		ArrayList districts = new ArrayList();
		ArrayList mandals = new ArrayList();
		ArrayList panchayats = new ArrayList();
		DataSource dataSource = null;
		ArrayList hps = new ArrayList();

		RwsOffices rwsoffice = new RwsOffices(getDataSource(request));

		HttpSession session = request.getSession();

		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");

		if (user == null)
			return mapping.findForward("expire");
		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId()) || Constants.IsEEUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");	
		}

		session = request.getSession();

		Rws_Rfd_Trainings_Dao dao = new Rws_Rfd_Trainings_Dao();

		String mode = request.getParameter("mode");

		if (mode != null && mode.equalsIgnoreCase("init")) {

			reset(frm);
			page_to_be_displayed = "data";
		}

		if (mode != null && mode.equalsIgnoreCase("data")) {
			if (request.getParameter("special") != null
					&& request.getParameter("special").equals("reset")) {
				reset(frm);
			}
			try {

				districts = rwsoffice.getDistricts();
				session.setAttribute("districts", districts);

			} catch (Exception e) {
				e.printStackTrace();
			}
			page_to_be_displayed = "data";
		}

		if (mode != null && mode.equalsIgnoreCase("mandal")) {
			if (request.getParameter("special") != null
					&& request.getParameter("special").equals("reset")) {
				reset(frm);
			}
			try {

				if (frm.getDist() != null && !frm.getDist().equals("")) {
					mandals = rwsoffice.getMandals(frm.getDist());
					session.setAttribute("mandals", mandals);

				} else {
					session.setAttribute("mandals", new ArrayList());
				}
			} catch (Exception e) {
				System.out.println("Exceptionr in Rws_Rfd_Trainings_Action" + e);
			}
			page_to_be_displayed = "data";
		}

		if (mode != null && mode.equalsIgnoreCase("panch")) {
			if (request.getParameter("special") != null
					&& request.getParameter("special").equals("reset")) {
				reset(frm);
			}
			try {

				if (frm.getDist() != null && frm.getMand() != null
						&& !frm.getMand().equals("")) {
					panchayats = rwsoffice.getPanchayats(frm.getDist(), frm
							.getMand());
					session.setAttribute("panchayats", panchayats);
				} else {
					session.setAttribute("panchayats", new ArrayList());
				}
			} catch (Exception e) {
				System.out.println("Exceptionr in Rws_Rfd_Trainings_Action" + e);
			}
			page_to_be_displayed = "data";
		}


		if (mode != null && mode.equalsIgnoreCase("save")) {
			session = request.getSession();
		    String storedToken = (String)session.getAttribute("csrfToken");
		    String token = request.getParameter("token");
		    if (storedToken.equals(token))
		    {
			try {
				
				dataSource = getDataSource(request);
				Rws_Rfd_Trainings_Dao wd = new Rws_Rfd_Trainings_Dao();
				int count = wd.insertWQTrainingDetails(dataSource, frm, user
						.getUserId());
				if (count > 0) {
					request.setAttribute("message", " Saved Successfully");
					frm.setFtkAchmt("");
					frm.setVwscAchmt("");
				} else {
					request.setAttribute("message", "Failed to Save");
				}

			} catch (Exception z) {
				z.printStackTrace();
			}
		    }
			page_to_be_displayed = "save";

		}

		if (mode != null && mode.equalsIgnoreCase("view")) {

			if (frm.getDist() != null && !frm.getDist().equals(" ")) {
				try {

					hps = dao.WQTrainedList(dataSource, frm.getDist());
					frm.setHps(hps);
					int p = hps.size();
					session.setAttribute("wqList", hps);
				}

				catch (Exception e) {
					System.out.println("Exceptionr in Rws_Rfd_Trainings_Action" + e);
				}
				page_to_be_displayed = "view";

			}

			if ((frm.getDist() != null && !frm.getDist().equals(" "))
					&& (frm.getMand() != null && !frm.getMand().equals(""))) {
				try {
					hps = dao.WQTrainedList(dataSource, frm.getDist(), frm
							.getMand());
					frm.setHps(hps);
					int p = hps.size();
					session.setAttribute("wqList", hps);
				}

				catch (Exception e) {
					System.out.println("Exceptionr in Rws_Rfd_Trainings_Action" + e);
				}
				page_to_be_displayed = "view";

			}

			if ((frm.getDist() != null && !frm.getDist().equals(" "))
					&& (frm.getMand() != null && !frm.getMand().equals(""))
					&& (frm.getPanch() != null && !frm.getPanch().equals(""))) {
				try {

					hps = dao.WQTrainedList(dataSource, frm.getDist(), frm
							.getMand(), frm.getPanch());
					frm.setHps(hps);
					int p = hps.size();
					session.setAttribute("wqList", hps);
				}

				catch (Exception e) {
					System.out.println("Exceptionr in Rws_Rfd_Trainings_Action" + e);
				}
				page_to_be_displayed = "view";

			}

		}

		if (mode != null && mode.equalsIgnoreCase("getData")) {

			if ((frm.getDist() != null && !frm.getDist().equals(" "))
					&& (frm.getMand() != null && !frm.getMand().equals(""))
					&& (frm.getPanch() != null && !frm.getPanch().equals("")))

			{
				try {

					frm.setFtkAchmt("");
					frm.setVwscAchmt("");
					dao.WQTrainedMembersData(dataSource, frm);

				}

				catch (Exception e) {
					System.out.println("Exceptionr in Rws_Rfd_Trainings_Action" + e);
				}
				page_to_be_displayed = "data";

			}
		}

		return mapping.findForward(page_to_be_displayed);
	}

	public void reset(Rws_Rfd_Trainings_Frm frm) {
		frm.setDist("");
		frm.setMand("");
		frm.setPanch("");

	}

}
