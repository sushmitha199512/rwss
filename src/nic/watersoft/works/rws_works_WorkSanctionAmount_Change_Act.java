/*
 * Created on Jun 15, 2007
 * 
 * TODO To change the template for this generated file go to Window -
 * Preferences - Java - Code Style - Code Templates
 */
package nic.watersoft.works;

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

public class rws_works_WorkSanctionAmount_Change_Act extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) {
		System.gc();
		DataSource ds = null;
		ArrayList circles = null;
		ArrayList divisions = null;
		ArrayList subdivs = null;
		ArrayList programmes = null;
		ArrayList subprogrammes = null;
		ArrayList workCategory = null;
		ArrayList assettypes = null;
		boolean mb = false;
		Runtime s_runtime = Runtime.getRuntime();
		long Used_memory = s_runtime.totalMemory() - s_runtime.freeMemory();
		String SUCCESS = "success";
		Used_memory = s_runtime.totalMemory() - s_runtime.freeMemory();
		System.gc();
		HttpSession session = request.getSession();
		String storedToken = (String)session.getAttribute("csrfToken");
		String token = request.getParameter("token");
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if(!(user.getUserId()!=null && (user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}
		String headOfficeCode = user.getHeadOfficeCode();
		rws_works_WorkStatus_form fb = (rws_works_WorkStatus_form) form;
		fb.setPreparedBy(user.getUserId());
		fb.setOfficeCode(user.getOfficeCode());
		rws_works_WorkStatus_bean bean = null;
		WorksDAO dao = null;
		Rws_Sanction_Amount_Change_DAO change_DAO=new  Rws_Sanction_Amount_Change_DAO();
		try {
			RwsOffices offices = new RwsOffices();
			String mode = fb.getMode();
			String nmode = fb.getNmode();
			String workStage = fb.getWorkStage();
			String months = offices.getMonthFromDual();
			String monthsNo = "";
			if (months.equals("APR")) {
				months = "APRIL";
				monthsNo = "1";
			}
			if (months.equals("MAY")) {
				months = "MAY";
				monthsNo = "2";
			}
			if (months.equals("JUN")) {
				months = "JUNE";
				monthsNo = "3";
			}
			if (months.equals("JUL")) {
				months = "JULY";
				monthsNo = "4";
			}
			if (months.equals("AUG")) {
				months = "AUGUST";
				monthsNo = "5";
			}
			if (months.equals("SEP")) {
				months = "SEPTEMBER";
				monthsNo = "6";
			}
			if (months.equals("OCT")) {
				months = "OCTOBER";
				monthsNo = "7";
			}
			if (months.equals("NOV")) {
				months = "NOVEMBER";
				monthsNo = "8";
			}
			if (months.equals("DEC")) {
				months = "DECEMBER";
				monthsNo = "9";
			}
			if (months.equals("JAN")) {
				months = "JANUARY";
				monthsNo = "10";
			}
			if (months.equals("FEB")) {
				months = "FEBRUARY";
				monthsNo = "11";
			}
			if (months.equals("MAR")) {
				months = "MARCH";
				monthsNo = "12";
			}

			request.setAttribute("month", months);
			request.setAttribute("monthNo", monthsNo);
			String mode1 = request.getParameter("mode1");
			
			if (workStage != null && workStage.equals("")) {
				if (mode.equals("circles")) {
					session.removeAttribute("divs");
					session.removeAttribute("subdivs");
					session.removeAttribute("workCategory");
					session.removeAttribute("programmes");
					session.removeAttribute("subprogrammes");
					session.removeAttribute("rwsWorks");
					session.removeAttribute("assettypes");
					session.removeAttribute("expyears");
					fb.setFinancialyear("");
					circles = offices.CircleCombo(headOfficeCode);
					if (circles != null)
						session.setAttribute("circles", circles);
					DataSource dataSource = getDataSource(request);
					offices = new RwsOffices(dataSource);
					session.setAttribute("expyears", offices.getExpYears());
					if (user.getUserId().equals("admin") || user.getUserId().equals("100000")) {
						session.setAttribute("fixcircle", null);
						fb.setDivCode("");
						fb.setSubdivisioncode("");
						fb.setProgram("");
						fb.setSubprogram("");
						fb.setScheme("");
						fb.setWorkName("");
						fb.setSchemelist("");						
					}
					if (!(user.getUserId().equals("admin") || user.getUserId().equals("100000"))) {
						mode = "div";
						fb.setCircleCode(user.getUserId().substring(1, 3));
						session.setAttribute("fixcircle", "yes");
						fb.setDivCode("");
						fb.setProgram("");
						fb.setSubprogram("");
						fb.setScheme("");
					}
					fb.setPhysicalStatus("");
					fb.setPhysicalStatusDetails("");
				}
				
				if (mode.equals("div")) {
					session.removeAttribute("divs");
					fb.setWorkId("");
					fb.setNmode("");
					fb.setNwork("");
					divisions = offices.DivisionCombo(headOfficeCode, fb.getCircleCode());
					session.setAttribute("divs", divisions);
					session.removeAttribute("workCategory");
					session.removeAttribute("subdivs");
					session.removeAttribute("programmes");
					session.removeAttribute("subprogrammes");
					session.removeAttribute("assettypes");
					session.removeAttribute("rwsWorks");
					fb.setScheme(null);
					fb.setWorkCat("");
					fb.setDivCode("");
					fb.setSubDivCode("");
					fb.setProgCode("");
					fb.setSubProgCode("");
					fb.setPhysicalStatus("");
					fb.setPhysicalStatusDetails("");
				}
				
				if (mode.equals("subdiv")) {
					workCategory = offices.getWorkCategory();
					session.setAttribute("workCategory", workCategory);
					offices = null;
					offices = new RwsOffices();
					subdivs = offices.SubDivisionCombo(headOfficeCode, fb.getCircleCode(), fb.getDivCode());
					fb.setWorkCat("");
					fb.setProgCode("");
					fb.setSubProgCode("");
					if (subdivs != null) {
						session.setAttribute("subdivs", subdivs);
						session.removeAttribute("programmes");
						session.removeAttribute("subprogrammes");
						session.removeAttribute("rwsWorks");
						session.removeAttribute("assettypes");
						fb.setScheme(null);
					}
					fb.setPhysicalStatus("");
					fb.setPhysicalStatusDetails("");
				}
				
				if (mode.equals("program")) {
					session.removeAttribute("subprogrammes");
					session.removeAttribute("rwsWorks");
					session.removeAttribute("programmes");
					session.removeAttribute("assettypes");
					programmes = offices.getProgrammes1(fb.getPlan(), fb.getWrktype(), fb.getWorkCat());
					if (programmes.size() != 0) {
						session.setAttribute("programmes", programmes);
						fb.setScheme(null);
					}
					fb.setProgram("");
					fb.setProgCode("");
					fb.setSubProgCode("");

					bean = new rws_works_WorkStatus_bean();
					dao = rws_works_factory.createWorksDAO(ds);
					ArrayList worksList = new ArrayList();
					worksList = change_DAO.getWorks22(fb, user.getUserId());
					session.removeAttribute("assettypes");
					assettypes = offices.getAssetTypes(fb.getWorkCat(),	fb.getPlan());
					if (assettypes != null) {
						session.setAttribute("assettypes", assettypes);
						session.removeAttribute("rwsWorks");
						fb.setScheme(null);
						fb.setProgram("");
					}
					if (worksList != null) {
						session.setAttribute("rwsWorks", worksList);
						fb.setScheme(null);
					}
					fb.setPhysicalStatus("");
					fb.setPhysicalStatusDetails("");
				}
				
				if (mode.equals("subprogram")) {
					session.removeAttribute("subprogrammes");
					subprogrammes = offices.getSubProgrammes(fb.getProgram());
					if (subprogrammes != null) {
						session.setAttribute("subprogrammes", subprogrammes);
						session.removeAttribute("rwsWorks");
						fb.setScheme(null);
					}
					fb.setSubprogram("");
					fb.setSubProgCode("");
					fb.setSchemelist("");
					fb.setFinancialyear("");
					fb.setPhysicalStatus("");
					fb.setPhysicalStatusDetails("");
				}
				
				if (mode.equals("schemeslist")) {
					session.removeAttribute("assettypes");
					assettypes = offices.getAssetTypes(fb.getWorkCat(),	fb.getPlan());
					if (assettypes != null) {
						session.setAttribute("assettypes", assettypes);
						session.removeAttribute("rwsWorks");
						fb.setScheme(null);
					}
					fb.setPhysicalStatus("");
					fb.setPhysicalStatusDetails("");
				}
				
				if (mode.equals("workcombo")) {
					bean = new rws_works_WorkStatus_bean();
					fb.setNwork("");
					dao = rws_works_factory.createWorksDAO(ds);
					ArrayList worksList = new ArrayList();
					worksList = change_DAO.getWorks22(fb, user.getUserId());
					if (worksList != null) {
						session.setAttribute("rwsWorks", worksList);
						fb.setScheme(null);
					}
					fb.setPhysicalStatus("");
					fb.setPhysicalStatusDetails("");
				}
				
				if (mode.equals("circles1")) {
					circles = offices.CircleCombo(headOfficeCode);
					if (circles != null)
						session.setAttribute("circles", circles);
					fb.setCircleCode(request.getParameter("circleCode"));
					divisions = offices.DivisionCombo(headOfficeCode, fb.getCircleCode());
					if (divisions != null)
						session.setAttribute("divs", divisions);
					fb.setDivCode(request.getParameter("divCode"));
					subdivs = offices.SubDivisionCombo(headOfficeCode, fb.getCircleCode(), fb.getDivCode());
					if (subdivs != null)
						session.setAttribute("subdivs", subdivs);
					bean = new rws_works_WorkStatus_bean();
					dao = rws_works_factory.createWorksDAO(ds);
					ArrayList worksList = new ArrayList();
					worksList = change_DAO.getWorks22(fb, user.getUserId());

					if (worksList != null) {
						session.setAttribute("rwsWorks", worksList);
					}
					fb.setWorkId(request.getParameter("workId"));
				}
				
				if (mode != null && mode.equals("addRemarks")) {
					dao = rws_works_factory.createWorksDAO(ds);
					fb.setPhysicalStatusDetails(dao.getNotGroundRemarks(fb.getWorkId()));
					dao = rws_works_factory.createWorksDAO(ds);
					fb.setWorkName(dao.getWorkName(fb.getWorkId()));
					return mapping.findForward(mode);
				}
				
				if (mode != null && mode.equals("saveRemarks")) {
					dao = rws_works_factory.createWorksDAO(ds);
					boolean val = dao.addNotGroundRemarks(fb.getWorkId(),
							fb.getPhysicalStatusDetails());
					if (val)
						request.setAttribute("message", "Reasons Added Successfully");
					else
						request.setAttribute("message", "Reasons Cannot be Added");
					return mapping.findForward("close");
				}

				if (mode != null && mode.equals("continueWork")) {
					dao = rws_works_factory.createWorksDAO(ds);
					int val = dao.cancelTheWork(request.getParameter("workId"),	"");
					if (val > 0)
						request.setAttribute("message",	"Work Continued Successfully");
					else
						request.setAttribute("message",	"Work Continuation Failed");
					return mapping.findForward("showMsg");
				}
				
				if ((mode != null && mode.equals("works"))|| (request.getParameter("wMode") != null && request.getParameter("wMode").equals("works"))) {
					String divcode = fb.getSubdivisioncode();
					dao = rws_works_factory.createWorksDAO(ds);
					bean = new rws_works_WorkStatus_bean();
					rws_works_WorkStatus_form fb1 = dao.getWorkDetails(fb);
					fb.setProgName(fb1.getProgName());
					fb.setSubProgName(fb1.getSubProgName());
					fb.setScheme(fb1.getScheme());
					fb.setSchemeCode(fb1.getSchemeCode());
					fb.setProgCode(fb1.getProgCode());
					fb.setSubProgCode(fb1.getSubProgCode());

					/** TO get the population detials of admin sanction */
					dao = rws_works_factory.createWorksDAO(ds);
					bean = new rws_works_WorkStatus_bean();
					bean = dao.getPopulationDetails(fb.getWorkId(),	"RWS_ADMN_HAB_LNK_TBL");
					fb.setAdminPlainPopu(bean.getAdminPlainPopu());
					fb.setAdminScPopu(bean.getAdminScPopu());
					fb.setAdminSTPopu(bean.getAdminSTPopu());
					fb.setAdminTotpopu(bean.getAdminTotpopu());

					/** TO get the population detials of revised admin sanction */
					dao = rws_works_factory.createWorksDAO(ds);
					bean = new rws_works_WorkStatus_bean();
					bean = dao.getPopulationDetails(fb.getWorkId(),	"RWS_REV_ADM_SANC_HAB_LNK_TBL");
					fb.setRevPlainPopu(bean.getAdminPlainPopu());
					fb.setRevScPopu(bean.getAdminScPopu());
					fb.setRevSTPopu(bean.getAdminSTPopu());
					fb.setRevTotpopu(bean.getAdminTotpopu());
					fb.setSubdivisioncode(bean.getSubdivisioncode());

					bean = new rws_works_WorkStatus_bean();
					fb.setSubdivisioncode(divcode);
					bean.setSubdivisioncode(divcode);
					dao = rws_works_factory.createWorksDAO(ds);
					ArrayList worksList = new ArrayList();
					worksList = change_DAO.getWorks(fb);
					if (worksList != null)
						session.setAttribute("rwsWorks", worksList);
				}
				if (mode != null&& mode.equals("update")) {
					if (storedToken.equals(token)) {
						String ip=request.getRemoteAddr();
						int updated = change_DAO.updateSanctionAmount(fb.getWorkId(),fb.getSanctionAmountChange(),fb.getAdminAmnt(),fb.getPreparedBy(),ip);
						if (updated > 0){
							if(updated==99)
								request.setAttribute("message", "Entered Amount is Less than Admin Sanction Amount");
							else
								request.setAttribute("message", "Sanction Amount updated Successfully");
						}
						else
							request.setAttribute("message", "Failed to update Sanction Amount");
						mode="details";
					}
				}
				
				if (mode.equals("details")) {
					session.removeAttribute("mileStonesList");
					fb.setFinancialyear("");
					fb.setMileStones(new ArrayList());
					dao = rws_works_factory.createWorksDAO(ds);
					bean = new rws_works_WorkStatus_bean();
					if (nmode != null && nmode.equals("nmode")) {
						if (fb.getNwork() != null && !fb.getNwork().equals("")) {							
							fb.setWorkId(fb.getNwork());
							String mesg = new RwsWorksDAO().updateWorkDetails(fb);
							if (!mesg.equals("1")) {
								session.removeAttribute("divs");
								session.removeAttribute("subdivs");
								session.removeAttribute("workCategory");
								session.removeAttribute("programmes");
								session.removeAttribute("subprogrammes");
								session.removeAttribute("rwsWorks");
								session.removeAttribute("assettypes");
								session.removeAttribute("expyears");
								fb.setFinancialyear("");
								fb.setScheme(null);
								fb.setWorkCat("");
								fb.setDivCode("");
								fb.setSubDivCode("");
								fb.setProgCode("");
								fb.setSubProgCode("");
								fb.setPhysicalStatus("");
								fb.setPhysicalStatusDetails("");
								session.setAttribute("message", mesg);
								return mapping.findForward(SUCCESS);
							} else {
								fb.setCircleCode(fb.getNwork().substring(4, 6));
								divisions = offices.DivisionCombo(headOfficeCode, fb.getCircleCode());
								session.setAttribute("divs", divisions);
								workCategory = offices.getWorkCategory();
								session.setAttribute("workCategory", workCategory);
								subdivs = offices.SubDivisionCombo(headOfficeCode, fb.getCircleCode(), fb.getDivCode());
								if (subdivs != null) {
									session.setAttribute("subdivs", subdivs);
								}
								programmes = offices.getProgrammes1(fb.getPlan(), fb.getWrktype(), fb.getWorkCat());
								if (programmes.size() != 0) {
									session.setAttribute("programmes",	programmes);
									fb.setScheme(null);
								}
								ArrayList worksList = new ArrayList();
								worksList = change_DAO.getWorksForWorkProgress(fb,user.getUserId());
								session.removeAttribute("assettypes");
								assettypes = offices.getAssetTypes(	fb.getWorkCat(), fb.getPlan());
								if (assettypes != null) {
									session.setAttribute("assettypes",	assettypes);
									fb.setScheme(null);
									fb.setProgram("");
								}
								
								if (worksList != null) {
									session.setAttribute("rwsWorks", worksList);
									fb.setScheme(null);
								}								
							}
						}
					}
					reset(fb );
					rws_works_WorkStatus_form fb1 = dao.getWorkDetails(fb);
					fb.setSchemelist(fb.getWorkId().substring(6, 8));
					String fyear = fb1.getAdminDate();
					String finalSancYear = "";
					int da = Integer.parseInt(fyear.substring(3, 5));
					int ye = Integer.parseInt(fyear.substring(6, 10));
					if (da <= 03)
						finalSancYear = "" + (ye - 1);
					else
						finalSancYear = "" + ye;
					String sancyear = finalSancYear;
					fb.setFinancialyear(sancyear);
					fb.setProgName(fb1.getProgName());
					fb.setSubProgName(fb1.getSubProgName());
					fb.setScheme(fb1.getScheme());
					fb.setSchemeCode(fb1.getSchemeCode());
					fb.setProgCode(fb1.getProgCode());
					fb.setSubProgCode(fb1.getSubProgCode());
					fb.setProgram(fb1.getProgCode());
					fb.setWorkCancelledDate(fb1.getWorkCancelledDate());
					fb.setSamount(fb1.getSamount());
					session.setAttribute("adate", fb1.getAdminDate());
					if (fb.getProgram() != null && !fb.getProgram().equals("")&& !workStage.equals("01")) {
						subprogrammes = offices.getSubProgrammes(fb.getProgram());
						session.setAttribute("subprogrammes", subprogrammes);
						fb.setSubprogram(fb1.getSubProgCode());
					} else if (!workStage.equals("01")) {
						session.removeAttribute("subprogrammes");
						fb.setSubprogram("");
					}
					
					dao = rws_works_factory.createWorksDAO(ds);
					rws_works_WorkStatus_form fb2 = dao.getAdminAndRevisedDetails(fb.getWorkId());
					fb.setAdminNo(fb2.getAdminNo());
					fb.setAdminDate(fb2.getAdminDate());
					String workAssignedTo = fb2.getOfficeCode();
					long adminSancAmnt = (int) (Float.parseFloat(fb2.getAdminAmnt()) * 100000);
					fb.setAdminAmnt(fb2.getAdminAmnt());
					change_DAO=new  Rws_Sanction_Amount_Change_DAO();
					tenderMemo tenderMemo = new tenderMemo();
					ArrayList bills = change_DAO.getBillDetails(fb.getWorkId());
					if (bills != null)
						request.setAttribute("bills", bills);					
					dao = rws_works_factory.createWorksDAO(ds);
					ArrayList status = dao.getWorkPhysicalStatus(fb.getWorkId());
					fb.setPhysicalStatus("" + status.get(0));
					fb.setPhysicalStatusDetails("" + status.get(1));
				}				
			}			
		}
		catch (Exception e) {
			System.out.println("The Exception in rws_works_WorkSanctionAmount_Change_Act in Action is  = "+e.getMessage());
		}
		System.gc();
		return mapping.findForward(SUCCESS);
	}
	
	public void reset(rws_works_WorkStatus_form form){
		form.setAdminAmnt("");
		form.setAdminDate("");
		form.setAdminNo("");
		form.setProgName("");
		form.setSubProgName("");
		form.setSanctionAmountChange("");
	}
}