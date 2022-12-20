package nic.watersoft.drought;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.works.WorksData1;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * 
 * @author Sai Prasad N
 * 
 */
public class RwsDroughtNewsItemAction extends Action {

	@Override
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		RwsOffices rwsOffices = new RwsOffices();
		ArrayList mandals = null, districts = null, panchayats = null, villages = null, habitations = null;
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		// Debug.println("user:" + user);
		if (user == null)
			return mapping.findForward("expire");

		if (!(user.getUserId() != null
				&& (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.DROUGHT_USER)
						|| user.getUserId().equals(Constants.LAKH_USER) || Constants.IsUser(user.getUserId())))) {
			// System.out.println("USER IN ACTION"+user.getUserId());
			return mapping.findForward("unAuthorise");
		}

		RwsDroughtNewsItemForm rwsDroughtNewsItemForm = (RwsDroughtNewsItemForm) form;
		// System.out.println("before mode");
		String mode = request.getParameter("mode");
		 //System.out.println("after mode"+mode);
		RwsDroughPaperItemDAO rwsDroughPaperItemDAO = new RwsDroughPaperItemDAO();

		if (mode != null && mode.equals("level")) {

			String currentDate = new WorksData1().getServerDate();

			rwsDroughtNewsItemForm.setPaperDt(currentDate);
			rwsDroughtNewsItemForm.setLevel(rwsDroughtNewsItemForm.getLevel());
			request.setAttribute("level", rwsDroughtNewsItemForm.getLevel());
			reset(rwsDroughtNewsItemForm, session);
			reset(rwsDroughtNewsItemForm);
			mode="view";
		}

		if (mode != null && mode.equals("districts")) {

			if (request.getParameter("special") != null && request.getParameter("special").equals("reset")) {

				String currentDate = new WorksData1().getServerDate();

				rwsDroughtNewsItemForm.setPaperDt(currentDate);
				rwsDroughtNewsItemForm.setLevel("State");
				request.setAttribute("level", "State");
				reset(rwsDroughtNewsItemForm, session);
				reset(rwsDroughtNewsItemForm);
			}
			districts = rwsOffices.getDistricts();
			request.setAttribute("level", rwsDroughtNewsItemForm.getLevel());

			session.setAttribute("districts", districts);
			mode="view";
		}
		if (mode != null && mode.equals("mandals")) {

			if (rwsDroughtNewsItemForm.getDistrict() != null && !rwsDroughtNewsItemForm.getDistrict().equals("")) {
				mandals = rwsOffices.getMandals(rwsDroughtNewsItemForm.getDistrict());
				reset(rwsDroughtNewsItemForm, session);
				session.setAttribute("mandals", mandals);
			} else {
				session.setAttribute("mandals", new ArrayList());
			}
			request.setAttribute("level", rwsDroughtNewsItemForm.getLevel());
			mode="view";
		}
		if (mode != null && mode.equals("panchayats")) {

			if (rwsDroughtNewsItemForm.getDistrict() != null && !rwsDroughtNewsItemForm.getDistrict().equals("")
					&& rwsDroughtNewsItemForm.getMandal() != null && !rwsDroughtNewsItemForm.getMandal().equals("")) {
				panchayats = rwsOffices.getPanchayats(rwsDroughtNewsItemForm.getDistrict(),
						rwsDroughtNewsItemForm.getMandal());
				reset(rwsDroughtNewsItemForm, session);
				session.setAttribute("panchayats", panchayats);
			} else {
				session.setAttribute("panchayats", new ArrayList());
			}
			request.setAttribute("level", rwsDroughtNewsItemForm.getLevel());
			mode="view";
		}
		if (mode != null && mode.equals("villages")) {

			if (rwsDroughtNewsItemForm.getDistrict() != null && !rwsDroughtNewsItemForm.getDistrict().equals("")
					&& rwsDroughtNewsItemForm.getMandal() != null && !rwsDroughtNewsItemForm.getMandal().equals("")
					&& rwsDroughtNewsItemForm.getPanchayat() != null
					&& !rwsDroughtNewsItemForm.getPanchayat().equals("")) {
				villages = rwsOffices.getVillages(rwsDroughtNewsItemForm.getDistrict(),
						rwsDroughtNewsItemForm.getMandal(), rwsDroughtNewsItemForm.getPanchayat());
				reset(rwsDroughtNewsItemForm, session);
				session.setAttribute("villages", villages);
			} else {
				session.setAttribute("villages", new ArrayList());
			}
			request.setAttribute("level", rwsDroughtNewsItemForm.getLevel());
			mode="view";
		}
		if (mode != null && mode.equals("habitations")) {

			if (rwsDroughtNewsItemForm.getDistrict() != null && !rwsDroughtNewsItemForm.getDistrict().equals("")
					&& rwsDroughtNewsItemForm.getMandal() != null && !rwsDroughtNewsItemForm.getMandal().equals("")
					&& rwsDroughtNewsItemForm.getPanchayat() != null
					&& !rwsDroughtNewsItemForm.getPanchayat().equals("") && rwsDroughtNewsItemForm.getVillage() != null
					&& !rwsDroughtNewsItemForm.getVillage().equals("")) {
				habitations = rwsOffices.getHabitations(rwsDroughtNewsItemForm.getDistrict(),
						rwsDroughtNewsItemForm.getMandal(), rwsDroughtNewsItemForm.getPanchayat(),
						rwsDroughtNewsItemForm.getVillage());
				reset(rwsDroughtNewsItemForm, session);
				session.setAttribute("habitations", habitations);
			} else {
				session.setAttribute("habitations", new ArrayList());
			}
			request.setAttribute("level", rwsDroughtNewsItemForm.getLevel());
			mode="view";
		}

		/**
		 * Fetching the habitaions
		 */

		if (mode != null && mode.equals("reqHabData")) {
			reset(rwsDroughtNewsItemForm, session);

			rwsDroughtNewsItemForm.setHabData(rwsDroughPaperItemDAO.getHabitaionsData(rwsDroughtNewsItemForm, request,getServlet()));
			request.setAttribute("level", rwsDroughtNewsItemForm.getLevel());
			mode="view";

		}
		if (mode != null && mode.equals("AddRow")) {
			reset(rwsDroughtNewsItemForm, session);
			request.setAttribute("AddRow", mode);
			rwsDroughtNewsItemForm
					.setHabData(rwsDroughPaperItemDAO.getHabitaionsData1(rwsDroughtNewsItemForm, request,getServlet()));
			request.setAttribute("level", rwsDroughtNewsItemForm.getLevel());
			mode="view";

		}
		if (mode != null && mode.equals("delete")) {

			String newsID = request.getParameter("newsId");
			String message = rwsDroughPaperItemDAO.deleteNewsClip(newsID);
			request.setAttribute("message", message);
			reset(rwsDroughtNewsItemForm, session);

			rwsDroughtNewsItemForm.setHabData(rwsDroughPaperItemDAO.getHabitaionsData(rwsDroughtNewsItemForm, request,getServlet()));
			request.setAttribute("level", rwsDroughtNewsItemForm.getLevel());
			mode="view";
		}

		/**
		 * Saving selected records
		 */

		if (mode != null && mode.equals("saveHabData")) {

			session = request.getSession();
			String storedToken = (String) session.getAttribute("csrfToken");
			String token = request.getParameter("token");
			
			if (storedToken.equals(token)) {
				try {
					//System.out.println("selectedNewsId :"+selectedNewsId);
					String targetPath = getServlet().getServletContext().getRealPath("") + "temp.jpg";
					// System.out.println("targetPath----"+targetPath);
					// String path=request.getParameter("path");
					// System.out.println("getScannedCopy"+path);
					String targetPath1 = getServlet().getServletContext().getRealPath("") + "temp1.jpg";

					// System.out.println("targetPath1----"+targetPath1);
					String message = rwsDroughPaperItemDAO.saveHabitaionsData(rwsDroughtNewsItemForm, request, session,
							targetPath, targetPath1, getServlet());

					request.setAttribute("message", message);
					reset(rwsDroughtNewsItemForm, session);

					rwsDroughtNewsItemForm
							.setHabData(rwsDroughPaperItemDAO.getHabitaionsData(rwsDroughtNewsItemForm, request,getServlet()));
					request.setAttribute("level", rwsDroughtNewsItemForm.getLevel());

				} catch (Exception e) {
					System.out.println("exception in drought news item -- " + e);
				}
			}
			mode="view";
		}
		if (mode != null && mode.equals("newsPaperDownload")) {
			
		}
		
		if (mode != null && mode.equals("downloadImages")) {
			//System.out.println("in action class downloadImages");
			String message = rwsDroughPaperItemDAO.downloadNewsClipImages(request);
			//System.out.println("message"+message);
			request.setAttribute("message", message);
			//reset(rwsDroughtNewsItemForm, session);
			mode="newsPaperDownload";
		}
		
		return mapping.findForward(mode);

	}

	private void reset(RwsDroughtNewsItemForm rwsDroughtNewsItemForm, HttpSession session) {
		rwsDroughtNewsItemForm.setHabData(new ArrayList());

	}

	private void reset(RwsDroughtNewsItemForm rwsDroughtNewsItemForm) {
		rwsDroughtNewsItemForm.setDistrict("");
		rwsDroughtNewsItemForm.setMandal("");
		rwsDroughtNewsItemForm.setPanchayat("");
		rwsDroughtNewsItemForm.setVillage("");
		rwsDroughtNewsItemForm.setHabitation("");
		/*
		 * RwsDroughPaperItemRecord droughPaperItemRecord=new
		 * RwsDroughPaperItemRecord(); droughPaperItemRecord.setScannedCopy(null);
		 */
	}

}
