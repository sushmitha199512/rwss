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
import com.healthmarketscience.jackcess.Database.FileFormat;
import com.healthmarketscience.jackcess.DatabaseBuilder;

public class Rws_Drought_ProjectShelf_Action extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mode = "data", query = "";
		if (request.getParameter("mode") != null) {
			mode = request.getParameter("mode");
		}
		Rws_Projectshelf_ExcelSheet_Form myForm = (Rws_Projectshelf_ExcelSheet_Form) form;
		boolean init = true, tt = false, myflag = false, flag1 = false, flag2 = false, flag3 = false, flag4 = false, flag5 = false, flag6 = false, flag7 = false, flag8 = false, flag9 = false, flag10 = false;
		String rtype = request.getParameter("type");
		String rvalue = request.getParameter("rvalue");
		String d1 = request.getParameter("fdate");
		String d2 = request.getParameter("todate");
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if((user.getUserId()!=null && !(user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}
		final String userId = user.getOfficeCode();
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		Rws_ExcelSheet myExcel = new Rws_ExcelSheet();
		Rws_Access myAccess = new Rws_Access();
		WorksData1 wd = new WorksData1();
		String mydate = wd.getServerDate();
		SimpleDateFormat sdfDestination = new SimpleDateFormat("dd-MMM-yyyy");
		SimpleDateFormat sdfSource = new SimpleDateFormat("dd/MM/yy");
		try {
			java.util.Date date = sdfSource.parse(mydate);
			mydate = sdfDestination.format(date);
		} catch (Exception pe) {
			System.out.println("The Rws_Drought_ProjectShelf_Action Parse Exception : " + pe);
		}
		Connection conn = RwsOffices.getConn();
		String filepath = "", filename = "", filepath1 = "";
		String message = "", tablename = "";
		FileOutputStream fileOut = null;
		File file = null, file1 = null;
		try {
			if (mode.equals("get")) {
				try {
					System.gc();
					flag1 = myExcel.createDrPrjShelfFirstTable(d1, d2, conn);
					if (flag1) {
						flag2 = myExcel.createDrPrjShelfSecondTable(d1, d2, conn);
						if (flag2) {
							flag3 = myExcel.createDrPrjShelfThirdTable(d1, d2, conn);
							if (flag3) {
								flag4 = myExcel.createDrPrjShelfFourthTable(conn);
								if (flag4) {
									flag5 = myExcel.createDrPrjShelfFifthTable(conn);
									if (flag5) {
										flag6 = myExcel.createDrPrjShelfSixthTable(conn);
										if (flag6) {
											flag7 = myExcel.createDrPrjShelfSeventhTable(conn);
											if (flag7) {
												myExcel.createDrTB1(conn);
												myExcel.createDrTB2(conn);
												myExcel.createDrTB3(conn);
												flag9 = myExcel.updateDrTbls(conn);
											}
										}
									}
								}
							}
						}
					}
					if (flag9){
						filepath = request.getSession().getServletContext().getRealPath("/")+ "portings"  ;
						filename = filepath + File.separator + "DROUGHTPROJECTSHELFFILE.mdb";
						File dbFile = new File(filename);
						Database database = DatabaseBuilder.create(FileFormat.V2007, dbFile);						
						if (database != null){
							myAccess.writeRws_Dr_Schemes_Tbl1(database, conn);
							myAccess.writeRWS_Dr_SchemeSources_Tbl2(database, conn);
							myAccess.writeRWS_Dr_SchemesProgrammes_Tbl3(database, conn);
							myAccess.writeRWS_Dr_SchemeHabs_Tbl4(database, conn);
							myAccess.writeRWS_Dr_SchemesImplementingAgency_Tbl5(database, conn);
							myAccess.writeRWS_Dr_SchemesAgencyResForOM_Tbl6(database, conn);
							flag10 = myAccess.writeRWS_Dr_TargetHabs_Tbl7(database,	conn);							
						}						
						if (flag10)	{
							message = "Successfully MDB created...";
							database.flush();
							database.close();
						} else {
							message = "Sorry cant create MDB... ";
							mode = "fail";
						}
					} else {
						message = "Sorry can't create MDB...Tables Creation Failure";
						mode = "fail";
					}
					request.setAttribute("message", message);					
				} catch (Exception e) {
					System.out.println("The Exception is in Rws_Drought_ProjectShelf_Action : "+e.getMessage());
				} finally {
					try {						
						if (conn != null) {
							conn.close();
						}
					} catch (Exception e){
						message = "Sorry can't create MDB...Finally Creation Failure";
						mode = "fail";
						System.out.println("The Exception is in Rws_Drought_ProjectShelf_Action : "+e.getMessage());
					}
				}
			}
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Drought_ProjectShelf_Action : "+e.getMessage());
		}
		return mapping.findForward(mode);
	}
}

