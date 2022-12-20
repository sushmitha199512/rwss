package nic.watersoft.reports;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
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

import com.healthmarketscience.jackcess.Database;

public class Rws_Mpr_Access_Action extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mode = "data";
		if (request.getParameter("mode") != null){
			mode = request.getParameter("mode");			
		}
		boolean flag1 = false, flag2 = false, flag3 = false, flag4 = false, flag5 = false, flag6 = false;
		String fromDate = request.getParameter("fdate");
		String toDate = request.getParameter("todate");
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if((user.getUserId()!=null && !(user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}
		Rws_Mpr_Access_DAO myDao = new Rws_Mpr_Access_DAO();
		WorksData1 wd = new WorksData1();
		String mydate = wd.getServerDate();
		SimpleDateFormat sdfDestination = new SimpleDateFormat("dd-MMM-yyyy");
		SimpleDateFormat sdfSource = new SimpleDateFormat("dd/MM/yy");
		Connection conn = RwsOffices.getConn();
		try {
			java.util.Date date = sdfSource.parse(mydate);
			mydate = sdfDestination.format(date);
		} catch (Exception pe) {
			System.out.println("The Exception is in Rws_Mpr_Access_Action Parse : " +pe.getMessage());			
		}
		String filepath = "", filename = "";
		String message = "", mymsg = "";
		
		
		try {
			if (mode.equals("get")) {
				try {
					flag1 = myDao.createWorksMPR(fromDate, toDate, conn, session);
					flag2 = myDao.createHabsMPR(fromDate, toDate, conn, session);
					flag3 = myDao.createSchoolsMPR(fromDate, toDate, conn, session);
					request.setAttribute("mymsg", mymsg);
					if (flag1 || flag2 || flag3) {
						filepath = request.getSession().getServletContext().getRealPath("/")+ "portings";
						filename = filepath + File.separator + "BackEndMPR.mdb";
						Database database = Rws_Mpr_Access_DAO.createDatabase(filename);
						if (database != null) {
							flag4 = myDao.writeFinancialMPR(database, conn);
							flag5 = myDao.writePhysicalMPR(database, conn);
							flag6 = myDao.writeSchoolMPR(database, conn);
						} if (flag4 || flag5 || flag6) {
							message = "MDB File Successfully created...";
							database.flush();
							database.close();
						} else {
							message = "Sorry can't create MDB...";
							mode = "fail";
						}
					}
					else {
						message = "Sorry can't create MDB...";
						mode = "fail";
					}
				} catch (Exception e) {
					message = "Sorry can't create MDB...";
					request.setAttribute("message", message);
					mode = "fail";
					System.out.println("The Exception is in Rws_Mpr_Access_Action : " +e.getMessage());	
				} finally {
					try {
						if (conn != null) {
							conn.close();
						}
					} catch (Exception e) {
						message = "Sorry cant create MDB...";
						request.setAttribute("message", message);
						mode = "fail";
						System.out.println("The Exception is in Rws_Mpr_Access_Action : " +e.getMessage());	
					}
				}
				request.setAttribute("message", message);
			}
		} catch (Exception e) {
			message = "Sorry cant create MDB...";
			request.setAttribute("message", message);
			mode = "failure";
			System.out.println("The Exception is in Rws_Mpr_Access_Action : " +e.getMessage());			
		}
		return mapping.findForward(mode);
	}
}