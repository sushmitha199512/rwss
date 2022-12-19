
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
import org.apache.struts.action.ActionMessages;

import com.healthmarketscience.jackcess.Database;

public class Rws_ProjectShelf_Excel_Action extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.gc();
		String mode = "data";
		if (request.getParameter("mode") != null) {
			mode = request.getParameter("mode");
		}
		ActionMessages messages = new ActionMessages();
		Rws_Projectshelf_ExcelSheet_Form myForm = (Rws_Projectshelf_ExcelSheet_Form) form;
		boolean flag1=false, flag2=false, flag3=false, flag4=false, flag5=false, flag7=false, flag8=false, flag6=false;
		String rtype = request.getParameter("type");
		String rvalue = request.getParameter("rvalue");
		String fromDate = request.getParameter("fdate");
		String toDate = request.getParameter("todate");
		String works = request.getParameter("worklist");
		String wrkList[] = null;
		if (works != null && !works.equals("")) {
			wrkList = works.split(",");
		}
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		if (user == null)
			return mapping.findForward("expire");		
		if((user.getUserId()!=null && !(user.getUserId().equals(Constants.ADMIN) || user.getUserId().equals(Constants.LAKH_USER) ))) {
			return mapping.findForward("unAuthorise");	
		}
		RwsProjectShelfDAO rwsProjectShelfDAO = new RwsProjectShelfDAO();
		WorksData1 wd = new WorksData1();
		String mydate = wd.getServerDate();
		SimpleDateFormat sdfDestination = new SimpleDateFormat("dd-MMM-yyyy");
		SimpleDateFormat sdfSource = new SimpleDateFormat("dd/MM/yy");
		Connection conn = RwsOffices.getConn();
		try {
			java.util.Date date = sdfSource.parse(mydate);
			mydate = sdfDestination.format(date);
		} catch (Exception pe) {
			System.out.println("The Exception is in Rws_projectShelf_Excel_Action Parse : " + pe);
		}
		String filepath = "", filename = "", message = "", tablename = "", mdbdname = "";
		try {
			if (rvalue != null && rvalue.equals("finmpr")) {
				tablename = "Backend_FinMPRScheme";
			}
			if (rvalue != null && rvalue.equals("phympr")) {
				tablename = "Backend_HabsMPR";
			}
			if (rvalue != null && rvalue.equals("schmpr")) {
				tablename = "Backend_SchoolMPR";
			}
			if (mode != null && mode.equals("get")) {
				try {
					if (rtype != null && rtype.equals("dates")) {
						flag1 = rwsProjectShelfDAO.createPrjShelfFirstTable(fromDate, toDate, conn, messages, myForm);
						mdbdname = "BackEndSchemes.mdb";
					}
					if (rtype != null && rtype.equals("list")) {
						flag1 = rwsProjectShelfDAO.createPrjShelfFirstTable(wrkList, conn, messages, myForm);
						mdbdname = "BackEndSchemes.mdb";
					}
					if (rtype != null && rtype.equals("mpr")) {
						flag1 = rwsProjectShelfDAO.createPrjShelfFirstTablewithTbl(tablename, conn, messages, myForm);
						mdbdname = "BackEndSchemes.mdb";
					}
					if (flag1) {
						flag2 = rwsProjectShelfDAO.createPrjShelfSecondTable(fromDate, toDate, conn, messages, myForm);
						if (flag2) {
							flag3 = rwsProjectShelfDAO.createPrjShelfThirdTable(fromDate, toDate, conn, messages, myForm);
							if (flag3) {
								flag4 = rwsProjectShelfDAO.createPrjShelfFourthTable(conn); 
								if (flag4) {
									flag5 = rwsProjectShelfDAO.createPrjShelfFifthTable(conn);
									if (flag5) {
										flag6 = rwsProjectShelfDAO.createPrjShelfSixthTable(conn);
										if (flag6) {
											flag7 = rwsProjectShelfDAO.createPrjShelfSeventhTable(conn,wrkList); 
											if (flag7) {
												if (rwsProjectShelfDAO.createPrjShelfEigthTable(conn)) { 
													flag8 = rwsProjectShelfDAO.updateTbls(conn);
												}
											}
										}
									}
								}
							}
						}
					}					
					if (flag8) {
						filepath = request.getSession().getServletContext().getRealPath("/")+ "portings";
						filename = filepath + File.separator + mdbdname;
						session.setAttribute("fname", mdbdname);
						Database database = RwsProjectShelfDAO.createDatabase(filename);
						if (database != null) {
							rwsProjectShelfDAO.writeRws_Schemes_Tbl1(database,conn);
							rwsProjectShelfDAO.writeRWS_SchemeSources_Tbl2(database, conn);
							rwsProjectShelfDAO.writeRWS_SchemesProgrammes_Tbl3(database, conn);
							rwsProjectShelfDAO.writeRWS_SchemeHabs_Tbl4(database, conn);
							rwsProjectShelfDAO.writeRWS_SchemesAgencyResForOM_Tbl6(database, conn);
							rwsProjectShelfDAO.writeSchemeContaminationTackledTbl(database, conn);
							rwsProjectShelfDAO.writeRWS_SchemesImplementingAgency_Tbl5(database, conn);
							flag5 = rwsProjectShelfDAO.writeSchemeSustainbilityMeasuresTakenTbl(database, conn);
						}
						if (flag5) {
							message = "MDB File Successfully Created...";
							database.flush();
							database.close();
						} else{
							message = "Sorry can't create MDB...";
							mode = "fail";
						}
					} else {
						message = "Sorry cannot create MDB, Tables Creation Failure...";
						mode = "fail";
					}

					request.setAttribute("message", message);
				} catch (Exception e) {
					message = "Sorry can't create MDB..., Get Mode Failure";
					request.setAttribute("message", message);
					mode = "fail";
					System.out.println("The Exception is in Rws_projectShelf_Excel_Action get : " + e.getMessage());
				} finally {
					try {
						if (conn != null) {
							conn.close();
						}
					} catch (Exception e) {
						message = "Sorry can't create MDB... Finally Failure";
						request.setAttribute("message", message);
						mode = "fail";
						System.out.println("The Exception is in Rws_projectShelf_Excel_Action get : " + e.getMessage());
					}
				}
			}
		} catch (Exception e) {
			mode = "fail";
			System.out.println("The Exception is in Rws_projectShelf_Excel_Action : " + e.getMessage());
		}
		saveMessages(request, messages);
		return mapping.findForward(mode);
	}
}
