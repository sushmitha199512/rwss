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
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUser;
import nic.watersoft.works.WorksData1;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.healthmarketscience.jackcess.Database;

public class Rws_Wq_Lab_Porting_Action extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mode = "data";
		if (request.getParameter("mode") != null) {
			mode = request.getParameter("mode");
		}
		boolean flag1 = false, flag2 = false, flag6 = false;
		String fromDate = request.getParameter("fdate");
		String toDate = request.getParameter("todate");
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if((user.getUserId()!=null && !(user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER)|| user.getUserId().equals("pdswsm") ))) {
			return mapping.findForward("unAuthorise");	
		}
		Rws_Wq_Lab_Porting_Dao myDao = new Rws_Wq_Lab_Porting_Dao();
		WorksData1 wd = new WorksData1();
		String mydate = wd.getServerDate();
		SimpleDateFormat sdfDestination = new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat sdfSource = new SimpleDateFormat("dd/MM/yy");
		try {
			java.util.Date date = sdfSource.parse(mydate);
			mydate = sdfDestination.format(date);
		} catch (Exception pe) {
			System.out.println("The Exception is in Rws_Wq_Lab_Porting_Action Parse : " + pe.getMessage());
		}
		Connection conn = RwsOffices.getConn();
		String filepath = "", filename = "";
		String message = "";
		try {
			if (mode.equals("get")) {
				try {
					flag1 = myDao.createFirstTable(fromDate, toDate,conn);
					if (flag1) {
						flag2 = myDao.secondThirdTable(conn);
					}
					else {
						message = "Sorry can't create Excel...";
						mode = "fail";
					}
					if (flag2) {
						filepath = request.getSession().getServletContext().getRealPath("/") + "portings";
						filename = filepath + File.separator + "BackendLabTestingDB.mdb";
						session.setAttribute("fname", "BackendLabTestingDB.mdb");
						Database database = Rws_Wq_Lab_Porting_Dao.createDatabase(filename);
						if (database != null) {
							myDao.writeBACKEND_SCHEMES_WQM_WATERQUALITYTESTING(database, conn);
							flag6 = myDao.writeBACKEND_SCHEMES_WQM_LABTESTINGDETAILS(database, conn);
							if (flag6) {
								message = "MDB File Successfully Created!...";
								database.flush();
								database.close();
							} else {
								message = "Sorry can't create MDB file...";
								mode = "fail";
							}
						}
					}
					else {
						message = "Sorry MDB File cannot be created!...";
						mode = "fail";
					}
					request.setAttribute("message", message);
				} catch (Exception e) {
					System.out.println("The Exception is in Rws_Wq_Lab_Porting_Action : " + e.getMessage());
				} 
			}
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Wq_Lab_Porting_Action : " + e.getMessage());
		}
		return mapping.findForward(mode);
	}
}
