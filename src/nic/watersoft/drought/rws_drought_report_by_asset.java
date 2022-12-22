/*
 * Created on 15-Feb-2012
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.drought;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.RwsLocations;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 * @author NIC
 * 
 * TODO To change the template for this generated type comment go to Window -
 * Preferences - Java - Code Style - Code Templates
 */
public class rws_drought_report_by_asset extends Action {

	/*
	 * (non-Javadoc)
	 * 
	 * @see org.apache.struts.action.Action#execute(org.apache.struts.action.ActionMapping,
	 *      org.apache.struts.action.ActionForm,
	 *      javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse)
	 */
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse arg3)
			throws Exception {
		String page_to_be_displayed = "get2";
		String message = null;
		ArrayList districts = new ArrayList();
		ArrayList years=new ArrayList();
		ArrayList mandals = new ArrayList();
		ArrayList habs = new ArrayList();
		int j = 0;
		String hab = "";
		System.out.println("comming");

		DroughtForm droughtForm = new DroughtForm();
		DroughtForm frm = (DroughtForm) form;
		int i = 0;
		String mode = request.getParameter("mode");

		HttpSession session = request.getSession();
		RwsLocations rwsLocations = new RwsLocations(getDataSource(request));
		if (mode != null && mode.equalsIgnoreCase("get2")) {
			if (request.getParameter("special") != null
					&& request.getParameter("special").equals("reset")) {
				reset(frm);
			}
			try {
				rwsLocations = new RwsLocations(getDataSource(request));
				districts = rwsLocations.getDistricts();
				years=rwsLocations.getyears();

				session.setAttribute("districts", districts);
				session.setAttribute("years", years);

				if (frm.getDist() != null && !frm.getDist().equals("")) {
					mandals = rwsLocations.getMandals(frm.getDist());
					session.setAttribute("districtCode", frm.getDist());
					session.setAttribute("year", frm.getYear());
					
				} else {
					session.setAttribute("mandals", new ArrayList());
				}

				page_to_be_displayed = "get2";
			}

			catch (Exception e) {
				System.out.println("the error in Complaint get2 is " + e);
			}
		} else if (mode != null && mode.equals("getReport")) {
			
			page_to_be_displayed = "getReport";
		}
		return mapping.findForward(page_to_be_displayed);
	}

	/**
	 * @param frm
	 */
	private void reset(DroughtForm frm) {
		if(frm!=null)
		{
			frm.setDist("");
			frm.setYear("");
		}
		
	}

}