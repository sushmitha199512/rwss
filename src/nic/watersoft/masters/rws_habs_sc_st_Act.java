package nic.watersoft.masters;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_habs_sc_st_Act extends Action {

	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");	
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}	
		String mode = request.getParameter("mode");
		if (mode != null && mode.equals("Habsave")) {
			 String storedToken = (String)session.getAttribute("csrfToken");
			    String token = request.getParameter("token");
			    if (storedToken.equals(token))
			    {	
			int recno = 0;
			String checking[] = null;
			int count = 0;
			try {
				recno = Integer.parseInt(request.getParameter("resultCount"));
				checking = new String[recno + 1];
				checking[0] = " ";
				recno = Integer.parseInt(request.getParameter("resultCount"));
				//System.out.println("rc:" + recno);
				for (int i = 1; i < recno + 1; i++) {
					if (request.getParameter("tsp" + i) != null) {
						checking[i] = "1";
						if ((request.getParameter("check[" + i + "]") != null
								&& !request.getParameter("check[" + i + "]").equals(""))
								&& request.getParameter("tsp" + i) != null
								&& !request.getParameter("tsp" + i).equals("")) {
							count += RwsHabStatusData.insertHabsData(request.getParameter("check[" + i + "]"),
									request.getParameter("tsp" + i));
						}
					}
				}
			} catch (Exception e) {
				Debug.println("Exception in Habsave mode:" + e.getMessage());
			}
			if (count > 0)
				request.setAttribute("message", count + " Habitation(s) Updated Successfully");
			else
				request.setAttribute("message", "Failed to Update");
			    }
			mode = "view";
		}
		if (mode != null && mode.equals("lcSave")) {
			 String storedToken = (String)session.getAttribute("csrfToken");
			    String token = request.getParameter("token");
			    if (storedToken.equals(token))
			    {	
			String habcode = request.getParameter("habcode");
			String type = request.getParameter("type");
			int sno = Integer.parseInt(request.getParameter("sno"));
			String sc = "";
			int count = 0;
			try {
				for (int i = 1; i <= sno; i++) {
					if (i <= 9)
						sc = type + "0" + i;
					else
						sc = type + i;
					if (request.getParameter("locname" + i) != null
							&& !request.getParameter("locname" + i).equals("")) {
						count += RwsHabStatusData.insertScData(habcode, sc, request.getParameter("locname" + i));
					}
				}
			} catch (Exception e) {
				Debug.println("Exception in lcSave mode:" + e);
			}
			if (count > 0)
				request.setAttribute("message", count + " Localites(s) Inserted/Updated Successfully");
			else
				request.setAttribute("message", "Failed to Insert/Update");
			    }
			mode = "close";
		}
		if (mode.equals("assetSave")) {
			 String storedToken = (String)session.getAttribute("csrfToken");
			    String token = request.getParameter("token");
			    if (storedToken.equals(token))
			    {	
			String astcode = request.getParameter("astcode");
			int recno = Integer.parseInt(request.getParameter("sno"));
			int count = 0;
			try {
				for (int i = 1; i < recno + 1; i++) {
					if ((request.getParameter("check[" + i + "]") != null
							&& !request.getParameter("check[" + i + "]").equals(""))
							&& request.getParameter("popser" + i) != null
							&& !request.getParameter("popser" + i).equals("")) {
						count += RwsHabStatusData.insertAssetData(request.getParameter("check[" + i + "]"), astcode,
								request.getParameter("code" + i), request.getParameter("popser" + i));
					}
				}
			} catch (Exception e) {
				Debug.println("Exception in assetSave mode:" + e);
			}
			
			if (count > 0)
				request.setAttribute("message", count + " Asset Localites(s) Inserted Successfully");
			else
				request.setAttribute("message", "Failed to Insert");
			    }
			mode = "close";
		}
		return mapping.findForward(mode);
	}

}
