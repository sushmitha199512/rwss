
package nic.watersoft.reports;

import java.io.File;
import java.io.FileOutputStream;
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

import org.apache.commons.io.FileUtils;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.healthmarketscience.jackcess.Database;


public class Rws_Wq_Ftk_Access_Action extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mode = "data", query = "";
		if (request.getParameter("mode") != null) {
			mode = request.getParameter("mode");
		}
		Rws_ExcelSheet_Form myForm = (Rws_ExcelSheet_Form) form;
		boolean init = true, myflag = false, flag1 = false, flag2 = false, flag3 = false, flag4 = false, flag5 = false, flag6 = false, flag7 = false, flag8 = false, flag9 = false, flag10 = false;
		String fromDate = request.getParameter("fdate");
		String toDate = request.getParameter("todate");
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if((user.getUserId()!=null && !(user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER)|| user.getUserId().equals("pdswsm") ))) {
			return mapping.findForward("unAuthorise");	
		}
		final String userId = user.getOfficeCode();
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		Rws_Wq_Ftk_Access_DAO myDao = new Rws_Wq_Ftk_Access_DAO();		
		WorksData1 wd = new WorksData1();
		String mydate = wd.getServerDate();
		SimpleDateFormat sdfDestination = new SimpleDateFormat("dd-MMM-yyyy");
		SimpleDateFormat sdfSource = new SimpleDateFormat("dd/MM/yy");
		Connection conn = RwsOffices.getConn();
		try {
			java.util.Date date = sdfSource.parse(mydate);
			mydate = sdfDestination.format(date);
		} catch (Exception pe) {
			System.out.println("The Exception is in  Parse Exception : " + pe.getMessage());
		}
		String filepath = "", filepath1 = "", filename = "";
		String message = "";
		try {
			if (mode.equals("get")){
				try {
					flag1 = myDao.createFirstFTKTable(fromDate, toDate,conn);  
					if (flag1) {
						filepath = request.getSession().getServletContext().getRealPath("/")+"portings";
						filename = filepath + File.separator+"BackendFTKDB.mdb";
						session.setAttribute("fname", "BackendFTKDB.mdb");
						Database database = Rws_Wq_Ftk_Access_DAO.createDatabase(filename);
						if (database != null) {   
							myDao.writeWQ_FTKWaterQualityTesting_Tbl(database, conn);							
							flag6 = myDao.writeWQ_FTKTestingDetails_Tbl(database, conn);
							if (flag6){
								message = "MDB File Successfully Created!...";
								database.flush();
								database.close();
							} else {
								message = "Sorry can't create MDB file...";
								mode = "fail";
							}
						}
					} else {
						message = "Sorry MDB file cannot be created!...";
						mode = "fail";
					}
					request.setAttribute("message", message);
				} catch (Exception e) {
					System.out.println("The Exception is in Rws_Wq_Ftk_Access_Action : " + e.getMessage());
				} finally {
					try{
						if (conn != null) {
							conn.close();
						}
					} catch (Exception e) {
						System.out.println("The Exception is in Rws_Wq_Ftk_Access_Action : " + e.getMessage());
					}
				}
			}
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Wq_Ftk_Access_Action : " + e.getMessage());
		}
		return mapping.findForward(mode);
	}
}
