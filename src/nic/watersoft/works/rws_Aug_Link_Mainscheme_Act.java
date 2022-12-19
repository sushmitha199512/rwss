/*
 * Created on Jan 29, 2010
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;

import java.util.ArrayList;
import java.util.StringTokenizer;

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
import org.apache.struts.action.DynaActionForm;

/**
 * @author sridhar
 *
 *         TODO To change the template for this generated type comment go to
 *         Window - Preferences - Java - Code Style - Code Templates
 */
public class rws_Aug_Link_Mainscheme_Act extends Action {

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		rws_works_WorkStatus_form workform = (rws_works_WorkStatus_form) form;
		HttpSession ses = request.getSession();
		String mode = "";
		String circleCode, divCode, subDivCode;
		String workid, workname, adminno, admindate, samount, assettype, astwork, assets;

		try {
			circleCode = workform.getCircleCode();
			divCode = workform.getDivCode();
			subDivCode = workform.getSubDivCode();
			RwsOffices rwsoffice = new RwsOffices(getDataSource(request));
			HttpSession session = request.getSession();
			RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
			if (user == null)
				return mapping.findForward("expire");

			if (!(user.getUserId() != null
					&& (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER)
							|| Constants.IsUser(user.getUserId()) || Constants.IsEEUser(user.getUserId())))) {
				return mapping.findForward("unAuthorise");
			}

			session = request.getSession();

			rws_Aug_Link_Mainscheme_Dao alm = new rws_Aug_Link_Mainscheme_Dao();
			mode = request.getParameter("mode");
			if (mode.equals("data")) {
				ArrayList circles = rwsoffice.getCircles();
				ArrayList divisions = rwsoffice.getDivisions1(circleCode);
				ArrayList subdivisions = rwsoffice.getSubDivisions1(circleCode, divCode);
				ses.setAttribute("circles", circles);
				ses.setAttribute("divisions", divisions);
				ses.setAttribute("subdivisions", subdivisions);
			}
			if (mode.equals("save")) {
				session = request.getSession();
				String storedToken = (String) session.getAttribute("csrfToken");
				String token = request.getParameter("token");
				if (storedToken.equals(token)) {
					String checking[] = null;
					int count = 0;
					try {
						int recno = 0;
						int delcnt = 0;
						recno = Integer.parseInt(request.getParameter("resultCount"));
						checking = new String[recno + 1];
						checking[0] = " ";
						recno = Integer.parseInt(request.getParameter("resultCount"));

						for (int i = 1; i < recno + 1; i++) {

							if (request.getParameter("assets" + i) != null) {
								checking[i] = "1";

								if ((request.getParameter("check[" + i + "]") != null
										&& !request.getParameter("check[" + i + "]").equals(""))
										&& (request.getParameter("assets" + i) != null
												&& !request.getParameter("assets" + i).equals(""))) {
									count += rws_Aug_Link_Mainscheme_Dao.insertData(
											request.getParameter("check[" + i + "]"),
											request.getParameter("assets" + i).substring(0, 14));
								}
							}
						}

					} catch (Exception e) {
						Debug.println("Exception in save mode of rws_Aug_Link_Mainscheme_Act: " + e);
					}
					String msgg = "";
					if (count > 0)
						request.setAttribute("message", count + " Work(s) Updated Successfully");
					else
						request.setAttribute("message", "Failed to Update");

					ses.setAttribute("default", request.getParameter("value"));
					mode = "viewwork";

				}
			}
			if (mode.equals("viewwork")) {
				String cir = request.getParameter("circleCode");
				String div = request.getParameter("divCode");
				String subdiv = request.getParameter("subDivCode");
				ArrayList rows;
				rows = alm.getWorkDetails(cir, div, subdiv, request);
				if (rows.size() == 0 || rows == null) {
					mode = "data";
					request.setAttribute("message", "No Record Matches with this Selection Criteria");
				} else {
					mode = "viewwork";
					request.setAttribute("rows", rows);
					workform.setRows(rows);
					ses.setAttribute("rows", rows);

				}

			}
		} catch (Exception e) {
			Debug.println("Exception in rws_Aug_Link_Mainscheme_Act  -- " + e);
		}
		return mapping.findForward(mode);
	}

}
