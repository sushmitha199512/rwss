package nic.watersoft.works;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Constants;
import nic.watersoft.commons.RwsLocations;
import nic.watersoft.commons.RwsUser;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class RwsQualityControlEntryAction extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm frm,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		QualityControlEntryActionBean bean = (QualityControlEntryActionBean) frm;
		HttpSession session = request.getSession(true);
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");

		if (!(user.getUserId() != null && (user.getUserId().equals(
				Constants.ADMIN)
				|| user.getUserId().equals(Constants.LAKH_USER)
				|| Constants.IsUser(user.getUserId()) || Constants
					.IsEEUser(user.getUserId())))) {
			return mapping.findForward("unAuthorise");
		}

		RwsQualityControlDAO rwsHabLinkDAO = new RwsQualityControlDAO();
		String message = "";
		
		if (bean.getWorkId() != null) {
			request.setAttribute("workId", bean.getWorkId());
		}
		String type = request.getParameter("type");
		String table = "";
		if (type != null && type.equals("admin")) {
			if (bean.getWorkId() != null
					&& bean.getWorkId().substring(6, 8).equals("11")) {
				table = "rws_work_school_lnk_tbl ";
			} else if (bean.getWorkId() != null
					&& bean.getWorkId().substring(6, 8).equals("12")) {
				table = "rws_work_lab_lnk_tbl";
			} else {
				table = "RWS_ADMN_HAB_LNK_TBL";
			}
		} else if (type != null && type.equals("tech")) {
			table = "RWS_EST_NEW_HAB_LNK_TBL";
		} else if (type != null && type.equals("comp")) {
			table = "RWS_WORK_COMP_HAB_LNK_TBL";
		}
		String mode = request.getParameter("mode");
		if (mode != null && mode.equals("data")) {
			reset(bean);
			//bean.setWorkId("01010101080034");
		}
		
		if (mode != null && mode.equals("showQcCertificate")) {
			
			
			/*WorksData1 worksData = new WorksData1(ds);

			byte a[] = worksData.getScannedCopy(request.getParameter("workId"), request.getParameter("slNo"));

			session.setAttribute("copyData", a);

			mode = "showFile";
			return mapping.findForward(mode);*/
			session.setAttribute("work_id", request.getParameter("workId"));
			//session.setAttribute("bill_date", request.getParameter("billDate").replace("/", "-"));
			//session.setAttribute("bill_sl_no", request.getParameter("slNo"));
			mode = "showFile";
			return mapping.findForward(mode);

		}
		
		if (mode != null && mode.equals("showTptCertificate")) {
			
			
			/*WorksData1 worksData = new WorksData1(ds);

			byte a[] = worksData.getScannedCopy(request.getParameter("workId"), request.getParameter("slNo"));

			session.setAttribute("copyData", a);

			mode = "showFile";
			return mapping.findForward(mode);*/
			session.setAttribute("work_id", request.getParameter("workId"));
			//session.setAttribute("bill_date", request.getParameter("billDate").replace("/", "-"));
			//session.setAttribute("bill_sl_no", request.getParameter("slNo"));
			mode = "showFile1";
			return mapping.findForward(mode);

		}
		
		
		if (mode != null && mode.equals("details")) {
			//System.out.println("$$$$$$$********");
			reset(bean);
			//String wType = bean.getWorkId().substring(6, 8);
			
				message = rwsHabLinkDAO.getWorkDetails(bean, request, getServlet());
				
				///////
				if(!bean.getWorkId().equals(null) && !bean.getWorkId().equals("")){
				ArrayList employeesRecBy = rwsHabLinkDAO.getEmployees(bean.getWorkId().substring(4, 6), 5, 9);
				session.setAttribute("engAssignedBy", employeesRecBy);
				}
				QualityControlEntryActionBean worksBean = rwsHabLinkDAO.getProgramScheduleDetails(getDataSource(request), bean.getWorkId());
				if (worksBean != null) {
					//fb.setSubDivAssign(worksBean.getSubDivAssign());
					bean.setEngineerAssign(worksBean.getEngineerAssign());
					bean.setEngineerAssign1(worksBean.getEngineerAssign1());
					bean.setEngineerAssign2(worksBean.getEngineerAssign2());
					bean.setEngineerAssign3(worksBean.getEngineerAssign3());
					//fb.setWorkGndDate(worksBean.getWorkGndDate());
					//fb.setAgreeDate(worksBean.getAgreeDate());
				} else if (worksBean == null) {
					//fb.setWorkGndDate("");
					bean.setEngineerAssign("");
					bean.setEngineerAssign1("");
					bean.setEngineerAssign2("");
					bean.setEngineerAssign3("");
					//bean.setWorkId("");
					
					//fb.setSubDivAssign("");
				}
				
				//bean.setTypeOfWork("hab");
			
			if (!message.equals("")) {
				request.setAttribute("message", message);
			}

		}
		if (mode != null && mode.equals("upddetails")) {
			String targetPath = getServlet().getServletContext().getRealPath("")  + "temp.jpg";
			System.out.println("bean daete.........."+bean.getCertDate()+"  -- "+bean.getIssueDate());
			 message=rwsHabLinkDAO.updateDetails(bean, targetPath, getServlet());
			 System.out.println("******"+bean.getEngineerAssign());
			 request.setAttribute("message", message);
			
			
		}
				return mapping.findForward("data");
	}
//updatedetails
	
	
	
	/**
	 * @param bean
	 */
	private void reset(QualityControlEntryActionBean bean) {
		//bean.setWorkId("");
		bean.setWorkName("");
		bean.setSanctionedAmount("");
		bean.setSanctionedDate("");
		bean.setSanctionedHabs("");
		bean.setProgramName("");
		bean.setSubProgName("");
		bean.setSanctionedDate("");
		bean.setIsAdmnSanction("");
		bean.setEngineerAssign("");
		bean.setEngineerAssign1("");
		bean.setEngineerAssign2("");
		bean.setEngineerAssign3("");
		bean.setCertDate("");
		bean.setIssueDate("");
		//////////////
		


	}

}