/*
 * Created on Aug 29, 2011
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
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

//import com.healthmarketscience.jackcess.Database;
/**
 * @jyothi
 * 
 * TODO To change the template for this generated type comment go to Window -
 * Preferences - Java - Code Style - Code Templates
 */
public class Rws_Excel_Action extends Action {
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String mode = "data", query = "";

		if (request.getParameter("mode") != null) {
			mode = request.getParameter("mode");
			Debug.println("mode is 22" + mode);
		}

		Rws_ExcelSheet_Form myForm = (Rws_ExcelSheet_Form) form;
		boolean init = true, myflag = false, flag1 = false, flag2 = false, flag3 = false, flag4 = false, flag5 = false, flag6 = false, flag7 = false, flag8 = false, flag9 = false, flag10 = false;
		String d1 = request.getParameter("fdate");
		String d2 = request.getParameter("todate");
		System.out.println("dates:::::::::" + d1 + "..." + d2);
		HttpSession session = request.getSession();
		RwsUser user = (RwsUser) session.getAttribute("RWS_USER");
		final String userId = user.getOfficeCode();
		RwsOffices rwsOffices = new RwsOffices(getDataSource(request));
		Rws_ExcelSheet myExcel = new Rws_ExcelSheet();
		Rws_Access myAccess = new Rws_Access();
		WorksData1 wd = new WorksData1();
		String mydate = wd.getServerDate();
		SimpleDateFormat sdfDestination = new SimpleDateFormat("dd-MM-yyyy");
		SimpleDateFormat sdfSource = new SimpleDateFormat("dd/MM/yy");
		try {
			java.util.Date date = sdfSource.parse(mydate);
			mydate = sdfDestination.format(date);
		} catch (Exception pe) {
			System.out.println("Parse Exception : " + pe);
		}
		
		
		System.out.println("d1 : " + d1);
		System.out.println("d2 : " + d2);
		System.out.println("mydate : " + mydate);
	
		Connection conn = RwsOffices.getConn();

		String filepath = "", filepath1 = "", filename = "";
		Debug.println("my context path"
				+ request.getSession().getServletContext().getRealPath("/"));
		String message = "";

		FileOutputStream fileOut = null;
		File file = null, file1 = null;
		try {

			if (mode.equals("get")) {
				try {

					System.gc();
					myflag = myExcel.createFinalSources(d1, d2);//true;//
					System.gc();
					if (myflag) {
						flag1 = myExcel.createFirstTable();//true;//
						System.gc();
						Debug.println("my firsttable creation status:" + flag1);
						if (flag1) {
							flag2 = myExcel.createSecondTable();//true;//
							System.gc();
							Debug.println("my secondtable creation status:"
									+ flag2);
							if (flag2) {
								flag3 = myExcel.createThirdTable();//true;//
								System.gc();
								Debug.println("my thirdtable creation status:"
										+ flag3);
								if (flag3) {
									flag4 = myExcel.createFourthTable();//true;//
									System.gc();
									Debug
											.println("my fourthtable creation status:"
													+ flag4);
									if (flag4) {
										flag5 = myExcel.createFifthTable();
										System.gc();
										Debug
												.println("my fifthtable creation status:"
														+ flag5);

									}//5th

								}//4th
							}//3rd
						}//2nd

					}//1st

					else //finalsources doestnot exits
					{
						message = "Sorry cant create Excel...";
						mode = "fail";
					}

					if (flag5) {
						filepath1 = request.getSession().getServletContext()
						.getRealPath("/")
						+ "portings";
						file1 = new File(filepath1);
						if (file1.exists()) {
							FileUtils.cleanDirectory(file1);
						} else {
							File f = new File(filepath1);
							f.mkdir();
		
						}
						Debug.println("my dir deleted" + filepath1);
		
						///////////////////Directory
						// Creation//////////////////////////////
		
						//////////////File
						// Creation//////////////////////////////
						filepath = request.getSession().getServletContext()
								.getRealPath("/")
								+ "portings"  ;
						Debug.println("my dynamic path" + filepath);
						filename = filepath + "\\" + "WQLABPORTINFILE.mdb";

						//directory creation
						file = new File(filepath);
						boolean success = file.mkdir();
						if (success) {
							System.out.println("Directory: " + mydate
									+ " created");
						}

						/////////////Access Code////////////////////////////
						Database database = Rws_Access.createDatabase(filename);
						if (database != null) {
							myAccess.writeWQM_WaterQualityTesting_Tbl1(
									database, conn);
							myAccess.writeWQM_WaterTestingSamples_Tbl2(
									database, conn);
							myAccess.writeWQM_LabTestingDetails_Tbl3(database,
									conn);
							myAccess.writeWQ_QualityYParameter_Tbl4(database,
									conn);
							flag6 = myAccess.writeRwss_Sources_Tbl5(database,
									conn);
							if (flag6) {
								message = "Successfully MDB Created!...";
								myExcel.insertTestidCount();
								database.flush();
								database.close();
							} else //finalsources doestnot exits
							{
								message = "Sorry cant create MDB...";
								mode = "fail";
							}
						}
					}

					else {
						message = "Sorry MDB cannot be created!...";
						mode = "fail";
					}
					//////////////////////////////////////////////

					request.setAttribute("message", message);
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try {
						//myExcel.deleteFinalSources();

					} catch (Exception e) {
						e.printStackTrace();
					}

				}

			}//get mode end

		} catch (Exception e) {
			e.printStackTrace();
		}

		return mapping.findForward(mode);

	}

}