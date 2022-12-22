package nic.watersoft.works;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
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

public class Rws_Ntr_Sujala_HabSponsor_Details_Action extends Action {
	String message = null;

	String page_to_be_displayed = " ";
	int ans = 0;

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		Rws_Ntr_Sujala_HabSponsor_Details_Form frm = (Rws_Ntr_Sujala_HabSponsor_Details_Form) form;

		HttpSession session = request.getSession();

		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null) {
			return mapping.findForward("expire");
		}
		if (!(user.getUserId() != null && (user.getUserId().equals(Constants.ADMIN)
				|| user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");
		}

		session = request.getSession();

		Rws_Ntr_Sujala_HabSponsor_Details_DAO dao = new Rws_Ntr_Sujala_HabSponsor_Details_DAO();

		String mode = request.getParameter("mode");
		Connection conn = RwsOffices.getConn();

		if (mode != null && mode.equalsIgnoreCase("init")) {

			reset(frm);
			frm.getHabList().clear();
			page_to_be_displayed = "data";
		}

		if (mode != null && mode.equalsIgnoreCase("data")) {
			if (request.getParameter("special") != null && request.getParameter("special").equals("reset")) {
				reset(frm);
			}
			try {
				frm.getHabList().clear();
				frm.setCircles(dao.getCircles(conn));
				session.setAttribute("circles", frm.getCircles());

			} catch (Exception e) {
				System.out.println("circles Display exception in ntr_sujala_habsponsor_action--  " + e);
			} finally {
				try {
					if (conn != null) {
						conn.close();
					}
				} catch (Exception e) {
					System.out.println("circles Display exception in ntr_sujala_habsponsor_action finally--  " + e);
				}

			}

			page_to_be_displayed = "data";
		}

		if (mode != null && mode.equalsIgnoreCase("mandals")) {
			if (request.getParameter("special") != null && request.getParameter("special").equals("reset")) {
				reset(frm);
				frm.getHabList().clear();
			}
			try {

				if (frm.getCircleCode() != null)

				{
					frm.getHabList().clear();
					frm.setMandals(dao.getMandals(frm.getCircleCode(), conn));
					session.setAttribute("mandals", frm.getMandals());

				} else {
					session.setAttribute("mandals", new ArrayList());
				}

			} catch (Exception e) {
				System.out.println("mandals display exception in ntr_sujala_habsponsor_action--  " + e);
			} finally {
				try {
					if (conn != null) {
						conn.close();
					}
				} catch (Exception e) {
					System.out.println("mandals display exception in ntr_sujala_habsponsor_action finally--  " + e);
				}

			}
			page_to_be_displayed = "data";
		}

		if (mode != null && mode.equalsIgnoreCase("panchayats")) {
			if (request.getParameter("special") != null && request.getParameter("special").equals("reset")) {
				reset(frm);

			}
			try {

				if (frm.getCircleCode() != null && frm.getMandal() != null)

				{
					frm.getHabList().clear();
					frm.setPanchayats(dao.getConstituencies(frm.getCircleCode(), frm.getMandal(), conn));
					session.setAttribute("panchayats", frm.getPanchayats());

				} else {
					session.setAttribute("panchayats", new ArrayList());
				}

			} catch (Exception e) {
				System.out.println("panchayats display exception in ntr_sujala_habsponsor_action -- " + e);
			} finally {
				try {
					if (conn != null) {
						conn.close();
					}
				} catch (Exception e) {
					System.out.println("panchayats display exception in ntr_sujala_habsponsor_action finally--  " + e);
				}

			}
			page_to_be_displayed = "data";
		}

		if (mode != null && mode.equalsIgnoreCase("habList")) {
			if (request.getParameter("special") != null && request.getParameter("special").equals("reset")) {
				reset(frm);
			}
			try {
				if (frm.getCircleCode() != null && frm.getMandal() != null && frm.getPanchCode() != null
						&& frm.getCurrentDate() != null && !frm.getCircleCode().equals("")
						&& !frm.getMandal().equals("") && !frm.getPanchCode().equals("")
						&& !frm.getCurrentDate().equals(""))

				{
					frm.setHabList(dao.getHabitations(frm.getCircleCode(), frm.getMandal(), frm.getPanchCode(), conn,
							frm.getCurrentDate()));

				} else {
					frm.getHabList().clear();
				}

			} catch (Exception e) {
				System.out.println("habList  exception in ntr_sujala_habsponsor_action -- " + e);
			} finally {
				try {
					if (conn != null) {
						conn.close();
					}
				} catch (Exception e) {
					System.out.println("habList  exception in ntr_sujala_habsponsor_action finally -- " + e);
				}

			}
			page_to_be_displayed = "data";
		}

		if (mode != null && mode.equalsIgnoreCase("save")) {
			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			if (storedToken.equals(token)) {
				ArrayList resultData = new ArrayList();
				try {
					String h1 = request.getParameter("hab1");
					String h2 = h1.substring(1, h1.length());
					String[] records = h1.split("@");
					String mydate = frm.getCurrentDate();

					for (int i = 0; i < records.length - 1; i++) {

						frm.setShabCode(records[i]);
						i++;
						frm.setSplantType(records[i]);
						i++;
						frm.setSplantCapacity(records[i]);
						i++;
						frm.setSagencyType(records[i]);
						i++;
						frm.setSinstAgencyName(records[i]);
						i++;
						frm.setSmaintenanceType(records[i]);
						i++;
						frm.setSmainAgencyName(records[i]);

						frm.setCurrentDate(mydate);

						resultData.add(frm);

					}
					int[] count = dao.saveHabitations(resultData, frm, conn, user, mydate, request);
					if (count.length > 0)

					{
						request.setAttribute("message",
								"Selected Habitations " + request.getAttribute("message1") + "   Successfully");
					} else {
						request.setAttribute("message", "Failed to Save");
					}

					page_to_be_displayed = "save";
				} catch (Exception e) {
					System.out.println("exception in save of ntr_sujala_habsponsor_action-- " + e);
				} finally {
					try {
						if (conn != null) {
							conn.close();
						}
					} catch (Exception e) {
						System.out.println("exception in save of ntr_sujala_habsponsor_action finally-- " + e);
					}

				}
				page_to_be_displayed = "save";
			}
		}

		return mapping.findForward(page_to_be_displayed);

	}

	public void reset(Rws_Ntr_Sujala_HabSponsor_Details_Form frm) {
		frm.setCircleCode("");
		frm.setMandal("");
		frm.setPanchCode("");
		frm.setCurrentDate("");
		frm.setHabList(new ArrayList());
	}

}
