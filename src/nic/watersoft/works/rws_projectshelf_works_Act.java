/*
 * Created on Jun 15, 2007
 * 
 * TODO To change the template for this generated file go to Window -
 * Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;
import nic.watersoft.commons.RwsUser;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionForm;
import nic.watersoft.commons.Debug;
import javax.servlet.http.HttpSession;
import javax.sql.*;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;

import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.commons.DAOMessage;
import nic.watersoft.works.WorksData1;

public class rws_projectshelf_works_Act extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		DataSource dataSource = null;
		System.gc();
		DataSource ds = null;
		ArrayList circles = null;
		ArrayList divisions = null;
		ArrayList subdivs = null;
		ArrayList programmes = null;
		ArrayList subprogrammes = null;
		ArrayList workCategory = null;

		Runtime s_runtime = Runtime.getRuntime();
		long Used_memory = s_runtime.totalMemory() - s_runtime.freeMemory();
		System.gc();
		String SUCCESS = "success";

		Used_memory = s_runtime.totalMemory() - s_runtime.freeMemory();

		System.gc();
		HttpSession session = request.getSession();
		RwsUser user = null;
		user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");
		rws_projectshelf_works_frm frm = (rws_projectshelf_works_frm)form;
		String mode = frm.getMode();
		String mode1 = request.getParameter("mode1");
		RwsOffices offices=new RwsOffices(dataSource);
		try
		{
			if(mode!=null && mode.equals("data") && mode1!=null && mode1.equals("circles"))
			{
				Debug.println("in circle");
				session.removeAttribute("divisions");
				session.removeAttribute("worksList");
				session.removeAttribute("programs");
				session.removeAttribute("schemes");
				circles = offices.CircleCombo("1");
				if (circles != null)
					session.setAttribute("circles", circles);
				if (!(user.getUserId().equals("admin") || user.getUserId().equals("100000")))
				{
					mode1 = "divisions";
					frm.setCircleOfficeCode(user.getUserId().substring(1,3));
					frm.setDivisionOfficeCode("");
			   }
			}
			if(mode!=null && mode.equals("data") && mode1!=null && mode1.equals("divisions"))
			{
				Debug.println("in circle3");
				session.removeAttribute("divisions");
				divisions = offices.DivisionCombo("1", frm.getCircleOfficeCode());
				session.setAttribute("divisions",divisions);
				Debug.println("user.getUserId():ssseee" + user.getUserId());
				session.removeAttribute("worksList");
				frm.setDivisionOfficeCode("");
				Debug.println("user.getUserId():sss" + user.getUserId());
			}
			if(mode!=null && mode.equals("data") && mode1!=null && mode1.equals("getWorks"))
			{
				WorksData1 wd = new WorksData1();
				Debug.println("dcode:"+frm.getCircleOfficeCode());
				Debug.println("div code:"+frm.getDivisionOfficeCode());
				ArrayList works = wd.getWorksforAap(frm.getCircleOfficeCode(),frm.getDivisionOfficeCode(),frm.getType(),frm.getCategory(),frm.getProgramCode(),frm.getSchemeCode());
				session.setAttribute("worksList",works);
				Debug.println("works size:"+works.size());
				frm.setPsWorks(works);
			}
			if (mode1 != null && mode1.equals("getPrograms")) {
				session.setAttribute("programs", new ArrayList());
				session.setAttribute("programs", new RwsWorksDAO().getProgramsForNotCompletedWotks(
						frm.getCircleOfficeCode(), Integer.parseInt(frm
								.getDivisionOfficeCode()), frm.getCategory()));
				session.setAttribute("schemes", new ArrayList());
				session.setAttribute("schemes", new RwsWorksDAO().getSchemes(
						frm.getCircleOfficeCode(), Integer.parseInt(frm
								.getDivisionOfficeCode()), frm.getCategory()));

			}
			if(mode!=null && mode.equals("data") && mode1!=null && mode1.equals("showHabs"))
			{
				WorksData1 wd = new WorksData1();
				String selworkId = request.getParameter("workID");
	 			if( selworkId != null && selworkId.length() > 0)
	 			{
	 			 	ArrayList habs = wd.getHabs(getDataSource(request),selworkId);
	 				request.setAttribute("selectedHabs", habs);
	 				return mapping.findForward(mode1);
	 			}
			}
			if(mode!=null && mode.equals("data") && mode1!=null && mode1.equals("saveWorks"))
			{
			
				//Debug.println("saveWorks mode"+request.getParameter("work"));
				String works1=request.getParameter("work");
				String works2 = works1.substring(1,works1.length());
				String[] works3 = works2.split(",");
				for(int i=0;i<works3.length;i++)
				{
					Debug.println(works3[i]);
				}
				WorksData1 wd = new WorksData1();
				int[] count = wd.saveWorksforAap(works3,frm.getCircleOfficeCode(),frm.getDivisionOfficeCode(),frm.getType());
				if(count.length>0)request.setAttribute("message","Selected work(s) Saved Successfully under AAP 2011-2012");
				else request.setAttribute("message","Failed to Save");
				ArrayList works = wd.getWorksforAap(frm.getCircleOfficeCode(),frm.getDivisionOfficeCode(),frm.getType(),frm.getCategory(),frm.getProgramCode(),frm.getSchemeCode());
				session.setAttribute("worksList",works);
				Debug.println("works size:"+works.size());
				frm.setPsWorks(works);
				
				/*
				ArrayList worksList = (ArrayList) frm.getPsWorks();
				if(worksList!=null)
					Debug.println("worksList size:"+worksList.size());
				if(worksList.size()==0)
					worksList = (ArrayList)session.getAttribute("worksList");
				Debug.println("worksList size1:"+worksList.size());
				rws_projectshelf_works_bean beanInSession = null;
					if (worksList != null) {
						for (int j = 0; j < worksList.size(); j++) {
							Debug.println(":" + worksList.get(j));
							beanInSession = (rws_projectshelf_works_bean)worksList.get(j);
							Debug.println(":----" + beanInSession.getChecks());
						}
					}
				*/
				}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		Debug.println("Before Returning Mode:"+mode);
		return mapping.findForward(mode);
	}
}
