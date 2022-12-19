package nic.watersoft.works;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class rws_projectshelf_works_probabledt_Act extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) {
		DataSource dataSource = null;
		System.gc();
		ArrayList circles = null;
		ArrayList divisions = null;
		ArrayList subdivs = null;
		Runtime s_runtime = Runtime.getRuntime();
		long Used_memory = s_runtime.totalMemory() - s_runtime.freeMemory();
		System.gc();

		Used_memory = s_runtime.totalMemory() - s_runtime.freeMemory();

		System.gc();
		HttpSession session = request.getSession();
		RwsUser user = null;
		user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");
				
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) || user.getUserId().equals(Constants.DROUGHT_USER) || Constants.IsUser(user.getUserId())  || Constants.IsEEUser(user.getUserId()) ))) {
			return mapping.findForward("unAuthorise");	
		}
		
		rws_projectshelf_works_probabledt_frm frm = (rws_projectshelf_works_probabledt_frm) form;
		String mode = frm.getMode();
		String mode1 = request.getParameter("mode1");
		
		RwsOffices offices = new RwsOffices(dataSource);
		ArrayList works =new ArrayList();
		ArrayList reasons =new ArrayList();
		ArrayList mileStones =new ArrayList();
		ArrayList workStauses =new ArrayList();
		String CMcore="";
		if(CMcore==null||CMcore.equals("")){
			CMcore=(String)request.getParameter("CMcore");
		}else{
			CMcore="No";
		}	
		try {
			if (mode != null && mode.equals("data") && mode1 != null
					&& mode1.equals("clear")) {
				if (frm.getPsWorks() != null && frm.getPsWorks().size() > 1) {
						frm.getPsWorks().clear();
					}
					
			}
			if (mode != null && mode.equals("data") && mode1 != null
					&& mode1.equals("circles")) {
				if (frm.getPsWorks() != null ) {
					frm.getPsWorks().clear();
				}
				
				session.removeAttribute("divisions");
				session.removeAttribute("worksList");
				session.removeAttribute("programs");
				session.removeAttribute("schemes");
				frm.setProgramCode("");
				frm.setSchemeCode("");
				frm.setCategory("0");

				circles = offices.CircleCombo("1");
				if (circles != null)
					session.setAttribute("circles", circles);
				if (!(user.getUserId().equals("admin") || user.getUserId().equals("100000"))) {
					mode1 = "divisions";
					frm.setCircleOfficeCode(user.getUserId().substring(1, 3));
					frm.setDivisionOfficeCode("");
					frm.setSubdivisionOfficeCode("");
				}
				else {
					frm.setDivisionOfficeCode("");
					frm.setSubdivisionOfficeCode("");
				}
			}
			if (mode != null && mode.equals("data") && mode1 != null
					&& mode1.equals("divisions")) {
				if (frm.getPsWorks() != null && frm.getPsWorks().size() > 1) {
					frm.getPsWorks().clear();
				}
				
				session.removeAttribute("divisions");
				session.removeAttribute("programs");
				session.removeAttribute("schemes");
				divisions = offices.DivisionCombo("1", frm
						.getCircleOfficeCode());
				session.setAttribute("divisions", divisions);
				session.removeAttribute("worksList");
				frm.setDivisionOfficeCode("");
			}
			
			if (mode != null && mode.equals("data") && mode1 != null
				&& mode1.equals("subDivisions")) {
				session.removeAttribute("subDivisions");
				session.removeAttribute("programs");
				session.removeAttribute("schemes");
				session.removeAttribute("worksList");
				subdivs = offices.SubDivisionCombo("1", frm
						.getCircleOfficeCode(), frm
						.getDivisionOfficeCode());
				session.setAttribute("subDivisions", subdivs);
				
				
				frm.setSubdivisionOfficeCode("");
				
			}
			
			if (mode != null && mode.equals("data") && mode1 != null
					&& mode1.equals("getWorks")) {
							
				if (frm.getPsWorks() != null && frm.getPsWorks().size() > 1) {
					frm.getPsWorks().clear();
				}
				WorksData1 wd = new WorksData1();
				 works = wd.getWorksforAap1(frm.getCircleOfficeCode(),
						frm.getDivisionOfficeCode(), frm.getType(), frm
								.getCategory(), frm.getProgramCode(), frm
								.getSchemeCode(),frm.getSubdivisionOfficeCode());
				frm.setPsWorks(works);
				session.setAttribute("psWorks", works);
				reasons=wd.reasonsCombo();
				
				session.setAttribute("reasons", reasons);
				workStauses=wd.workStatusCombo();
				session.setAttribute("workStauses", workStauses);
				
				
			
			}
			if (mode != null && mode.equals("data") && mode1 != null
					&& mode1.equals("getMVSWorks")) {
				
				frm.setPsWorks(new ArrayList<rws_projectshelf_works_probabledt_bean>());
				if (frm.getPsWorks() != null && frm.getPsWorks().size() > 1) {
					frm.getPsWorks().clear();
				}
				WorksData1 wd = new WorksData1();
				 works = wd.getWorksforMVS();
				frm.setPsWorks(works);
				session.setAttribute("psWorks", works);
				reasons=wd.reasonsCombo();
				
				session.setAttribute("reasons", reasons);
				workStauses=wd.workStatusCombo();
				session.setAttribute("workStauses", workStauses);
				
				
			}
			
			if (mode != null && mode.equals("milestones")) {
		
				String work_id=request.getParameter("workid");
				frm.setWorkId(work_id);
				WorksData1 wd = new WorksData1();
				mileStones=wd.getMileStoneCodesAndStages(frm);
				frm.setMilestones(mileStones);
				session.setAttribute("milestones", mileStones);
				
				frm.setCurrentMonthPer(wd.getMileStoneCumulativePer(frm, "current"));
				frm.setPreviousMonthPer(wd.getMileStoneCumulativePer(frm, "previous"));
				
			}
			if (mode != null && mode.equals("milestonesSave")) {
				
				session = request.getSession();
			    String storedToken = (String)session.getAttribute("csrfToken");
			    String token = request.getParameter("token");
			    if (storedToken.equals(token))
			    {
				WorksData1 wd = new WorksData1();
				int count[] = wd.saveMileStonesforWork(frm);
				
				mileStones=wd.getMileStoneCodesAndStages(frm);
				frm.setMilestones(mileStones);
				session.setAttribute("milestones", mileStones);
				frm.setCurrentMonthPer(wd.getMileStoneCumulativePer(frm, "current"));
				frm.setPreviousMonthPer(wd.getMileStoneCumulativePer(frm, "previous"));
				if (count.length > 0)
					request.setAttribute("message",
							"Selected Milestone(s) Updated Successfully");
				else
					request.setAttribute("message", "Failed to Save");
			    }
				
			}
			if (mode != null && mode.equals("excelFile")) {
		
				
				works=frm.getPsWorks();
				frm.setPsWorks(works);
				session.setAttribute("psWorks", works);
				
			}
			if (mode != null && mode.equals("data") && mode1 != null
					&& mode1.equals("showHabs")) {
				WorksData1 wd = new WorksData1();
				String selworkId = request.getParameter("workID");
				if (selworkId != null && selworkId.length() > 0) {
					
					ArrayList habs = wd.getHabs(getDataSource(request),
							selworkId);
					request.setAttribute("selectedHabs", habs);
					return mapping.findForward(mode1);
					
				}
				
			}
			if (mode != null && mode.equals("data") && mode1 != null
					&& mode1.equals("saveImage")) {
				String workid1=request.getParameter("workid");
				String status=request.getParameter("status");
				frm.setWorkId(workid1);
				frm.setImageStatus(status);
					return mapping.findForward(mode1);
									
			}
			if (mode != null && mode.equals("saveImage")) {
				
				session = request.getSession();
			    String storedToken = (String)session.getAttribute("csrfToken");
			    String token = request.getParameter("token");
			    if (storedToken.equals(token))
			    {
				String targetPath = getServlet().getServletContext().getRealPath(
						"")
						+ File.separator + "temp.jpg";
				WorksData1 wd = new WorksData1();
				
				String message= wd.saveWorkImage(frm,targetPath,getServlet());
					request.setAttribute("message",message);
			    }
									
			}
			if (mode1 != null && mode1.equals("getPrograms")) {
				session.setAttribute("programs", new ArrayList());
				session.setAttribute("programs", new RwsWorksDAO()
						.getProgramsForNotCompletedWotks(frm
								.getCircleOfficeCode(), Integer.parseInt(frm
								.getDivisionOfficeCode()), frm.getCategory()));
				session.setAttribute("schemes", new ArrayList());
				session.setAttribute("schemes", new RwsWorksDAO().getSchemes(
						frm.getCircleOfficeCode(), Integer.parseInt(frm
								.getDivisionOfficeCode()), frm.getCategory()));

			}

			if (mode != null && mode.equals("data") && mode1 != null
					&& mode1.equals("saveWorks")) {
				
				session = request.getSession();
			    String storedToken = (String)session.getAttribute("csrfToken");
			    String token = request.getParameter("token");
			    if (storedToken.equals(token))
			    {
			    	
				String targetPath = getServlet().getServletContext().getRealPath(
						"")
						+ File.separator + "temp.jpg";
				
				WorksData1 wd = new WorksData1();
				
				String message = wd.saveWorksforAap1(frm,targetPath,getServlet());
				
				request.setAttribute("message", message);
				 works = wd.getWorksforAap1(frm.getCircleOfficeCode(),
						frm.getDivisionOfficeCode(), frm.getType(), frm
								.getCategory(), frm.getProgramCode(), frm
								.getSchemeCode(),frm.getSubdivisionOfficeCode());
				session.setAttribute("worksList", works);
				frm.setPsWorks(works);
			    }
			}
			
			if (mode != null && mode.equals("showScannedCopy")) {
				WorksData1 worksData = new WorksData1();

				String workid=request.getParameter("workid");
				String status=request.getParameter("imageStatus");
				byte a[] = worksData.getWorkIdScannedCopy(workid,status);

				session.setAttribute("copyData", a);
				mode = "showFile";
				
			}
			if (mode != null && mode.equals("data") && mode1 != null
					&& mode1.equals("getCMCOREWorks")) {							
				if (frm.getPsWorks() != null && frm.getPsWorks().size() > 1) {
					frm.getPsWorks().clear();
				}
				WorksData1 wd = new WorksData1();
				 works = wd.getWorksforCMCOREAap1(frm.getCircleOfficeCode(),
						frm.getDivisionOfficeCode(), frm.getType(), frm
								.getCategory(), frm.getProgramCode(), frm
								.getSchemeCode(),frm.getSubdivisionOfficeCode(),CMcore);
				frm.setPsWorks(works);
				session.setAttribute("psWorks", works);
				reasons=wd.reasonsCombo();
				
				session.setAttribute("reasons", reasons);
				workStauses=wd.workStatusCombo();
				session.setAttribute("workStauses", workStauses);			
			}
			if (mode != null && mode.equals("data") && mode1 != null
					&& mode1.equals("getCMCOREMVSWorks")) {
				frm.setPsWorks(new ArrayList<rws_projectshelf_works_probabledt_bean>());
				if (frm.getPsWorks() != null && frm.getPsWorks().size() > 1) {
					frm.getPsWorks().clear();
				}
				WorksData1 wd = new WorksData1();
				 works = wd.getWorksforCMCOREMVS(CMcore);
				frm.setPsWorks(works);
				session.setAttribute("psWorks", works);
				reasons=wd.reasonsCombo();
				session.setAttribute("reasons", reasons);
				workStauses=wd.workStatusCombo();
				session.setAttribute("workStauses", workStauses);
				
			}
			ArrayList kpiHabs=new ArrayList();
			if (mode != null && mode.equals("kpiHabs")) {
				String workid=request.getParameter("workid");	
				WorksData1 wd = new WorksData1();
				kpiHabs=wd.getKpiHabs(workid);	
				session.setAttribute("kpiHabs",kpiHabs );				
			}
			ArrayList psworks=new ArrayList();
			if (mode != null && mode.equals("data") && mode1 != null && mode1.equals("AddKpiHabs")) {
				 try{
				     psworks=(ArrayList)session.getAttribute("psWorks");
		 			 frm.setPsWorks(psworks);			    
	 			   }
	 			catch(Exception e)
				{
	 				e.printStackTrace();
				}			
			}
			if (mode != null && mode.equals("data") && mode1 != null
					&& mode1.equals("saveW")) {		
				session = request.getSession();
			    String storedToken = (String)session.getAttribute("csrfToken");
			    String token = request.getParameter("token");
			    if (storedToken.equals(token))
			    {
				String targetPath = getServlet().getServletContext().getRealPath(
						"")
						+ File.separator + "temp.jpg";				
				WorksData1 wd = new WorksData1();				
				String message = wd.saveWorksforCMDB(frm,targetPath,getServlet());				
				request.setAttribute("message", message);
				 works = wd.getWorksforCMCOREAap1(frm.getCircleOfficeCode(),
						frm.getDivisionOfficeCode(), frm.getType(), frm
								.getCategory(), frm.getProgramCode(), frm
								.getSchemeCode(),frm.getSubdivisionOfficeCode(),CMcore);
				session.setAttribute("worksList", works);
				frm.setPsWorks(works);
			    }
			}
			
		} catch (Exception e) {
			Debug.println("Exception in rws_projectshelf_works_probabledt_Act:" + e);
		}
		return mapping.findForward(mode);
	}
}