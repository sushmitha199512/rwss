package nic.watersoft.reports;

import java.io.File;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.sql.DataSource;

import jxl.write.DateFormats;
import jxl.write.Formula;
import jxl.write.Label;
import jxl.write.Number;
import jxl.write.NumberFormat;
import jxl.write.NumberFormats;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableImage;
import jxl.write.WritableSheet;
import jxl.write.WriteException;
import nic.watersoft.commons.Debug;
import nic.watersoft.commons.LabelValueBean;
import nic.watersoft.commons.RwsOffices;
import nic.watersoft.commons.RwsUtils;

public class Rws_ExcelSheet {
	Connection con = null;
	ResultSet rst = null, rs1 = null;
	PreparedStatement pstmt = null;
	Statement stmt = null, stmt1 = null;
	DataSource datasource = null;
	private LabelValueBean labelValueBean;

	Rws_ExcelSheet() {}

	Rws_ExcelSheet(DataSource datasource) {
		this.datasource = datasource;
	}

	public boolean createFinalSources(String fromdate, String todate) {
		boolean flag = false;
		Statement st = null, st1 = null, st2 = null, st3 = null, st4 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		Connection con = RwsOffices.getConn();
		try {
			st = con.createStatement();
			st1 = con.createStatement();
			st2 = con.createStatement();
			st3 = con.createStatement();
			st4 = con.createStatement();

			String selquery = "Select tname from tab where tname like 'FINALSOURCES_TEMP_TBL'";
			rs = st.executeQuery(selquery);
			if (!rs.next()) {
				String crquery = "create table  finalSources_temp_tbl (SOURCE_CODE varchar2(50),HAB_CODE varchar2(50),TEST_ID varchar2(50),HabitationId varchar2(50),DistrictId varchar2(50),PREPARED_ON varchar2(50),SourceTypeCode varchar2(50),ASSET_CODE varchar2(50))";
				st1.executeUpdate(crquery);				
			} else {
				String delquery = "delete from finalSources_temp_tbl";
				st1.executeUpdate(delquery);
				con.commit();
			}

			String qry = "select distinct a.SOURCE_CODE,a.HAB_CODE,a.TEST_ID,c.HabitationId,c.DistrictId,to_char(a.PREPARED_ON,'dd/mm/yyyy') from  rws_water_sample_collect_tbl a,RWS_WQ_TEST_RESULTS_TBL b, IMISMASTERDATA1  c where a.test_id=b.test_id and ( a.PREPARED_ON>=TO_DATE('"
					+ fromdate
					+ "','dd-mm-yy') and a.PREPARED_ON<=TO_DATE('"
					+ todate
					+ "','dd-mm-yy') ) and c.habcode=a.hab_code and a.ftk_test_id is null";
			rs2 = st2.executeQuery(qry);
			int i = 1, total = 0;
			while (rs2.next()) {

				String insertqry = "insert into finalSources_temp_tbl(SOURCE_CODE,HAB_CODE,TEST_ID ,HabitationId,DistrictId,PREPARED_ON) values('"
						+ rs2.getString(1)
						+ "','"
						+ rs2.getString(2)
						+ "','"
						+ rs2.getString(3)
						+ "','"
						+ rs2.getString(4)
						+ "','"
						+ rs2.getString(5) + "','" + rs2.getString(6) + "')";
				total += st3.executeUpdate(insertqry);

			}
			Debug.println("insert susscessfully............" + total);

			if (total > 0) {
				String updateqry = "update finalSources_temp_tbl t set SourceTypeCode=(select source_type_code from rws_source_tbl where source_code=t.source_code)";
				int up = st4.executeUpdate(updateqry);
				Debug.println("update qry............" + updateqry);
				if (up > 0) {
					Debug.println("updated susscessfully............" + up);
					con.commit();
					flag = true;
				} else
					Debug.println("failed to update............");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				st.close();
				st1.close();
				rs2.close();
				st2.close();
				st3.close();
				st4.close();
				// con.close();

			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		return flag;
	}// end of createExcel

	/**
	 * @param hwb
	 * @param filename
	 * @param fileOut2
	 */
	/*
	 * public void writeTable1(HSSFWorkbook hwb, FileOutputStream fileOut,
	 * String filename) { // TODO Auto-generated method stub boolean flag=false;
	 * Connection con=RwsOffices.getConn(); Statement st=null; ResultSet
	 * rs=null;
	 * 
	 * try {
	 * 
	 * fileOut= new FileOutputStream(filename);
	 * 
	 * System.out.println("Your firsttable.writing started..!"); HSSFSheet sheet
	 * = hwb.createSheet("WQM_WaterQualityTesting"); HSSFRow rowhead=
	 * sheet.createRow((short)0); rowhead.createCell((short)
	 * 0).setCellValue("SNo"); rowhead.createCell((short)
	 * 1).setCellValue("TestId"); rowhead.createCell((short)
	 * 2).setCellValue("Source"); rowhead.createCell((short)
	 * 3).setCellValue("HabitationId"); rowhead.createCell((short)
	 * 4).setCellValue("DistrictId"); rowhead.createCell((short)
	 * 5).setCellValue("ContaminatedYes_No"); rowhead.createCell((short)
	 * 6).setCellValue("TestCode"); st=con.createStatement(); String
	 * qry="select * from WQM_WaterQualityTesting"; rs=st.executeQuery(qry);
	 * //System.out.println("qry"+qry); int i=1; while(rs.next()){ HSSFRow row=
	 * sheet.createRow((short)i); row.createCell((short)
	 * 0).setCellValue(Integer.toString(i)); row.createCell((short)
	 * 1).setCellValue(rs.getString(1)); row.createCell((short)
	 * 2).setCellValue(rs.getString(2)); row.createCell((short)
	 * 3).setCellValue(rs.getString(3)); row.createCell((short)
	 * 4).setCellValue(rs.getString(4)); row.createCell((short)
	 * 5).setCellValue(rs.getString(5)); row.createCell((short)
	 * 6).setCellValue(rs.getString(6)); i++; }
	 * 
	 * hwb.write(fileOut); fileOut.close();
	 * ///System.out.println("Your excel file has been generated!");
	 * System.out.println("Your firsttable writing to excel over..!");
	 * 
	 * } catch(Exception e) { e.printStackTrace(); } finally { try{
	 * 
	 * rs.close(); st.close();con.close(); } catch(Exception e) {
	 * e.printStackTrace(); } }
	 * 
	 * }
	 */
	/**
	 * @param hwb
	 * @param fileOut
	 * @param filename
	 */
	/*
	 * public void writeTable2(HSSFWorkbook hwb, FileOutputStream fileOut,
	 * String filename) { Connection con=RwsOffices.getConn(); Statement
	 * st=null; ResultSet rs=null; boolean flag=false; try { fileOut= new
	 * FileOutputStream(filename);
	 * 
	 * 
	 * System.out.println("Your secondtable...!"); HSSFSheet sheet1 =
	 * hwb.createSheet("WQM_WaterTestingSamples"); HSSFRow rowhead1=
	 * sheet1.createRow((short)0); rowhead1.createCell((short)
	 * 0).setCellValue("SNo"); rowhead1.createCell((short)
	 * 1).setCellValue("TestId"); rowhead1.createCell((short)
	 * 2).setCellValue("TestingDate"); rowhead1.createCell((short)
	 * 3).setCellValue("LabId"); rowhead1.createCell((short)
	 * 4).setCellValue("Sample"); rowhead1.createCell((short)
	 * 5).setCellValue("AP_LABID"); st=con.createStatement(); String
	 * qry="select * from WQM_WaterTestingSamples"; rs=st.executeQuery(qry); int
	 * i1=1; while(rs.next()){ HSSFRow row1= sheet1.createRow((short)i1);
	 * row1.createCell((short) 0).setCellValue(Integer.toString(i1));
	 * row1.createCell((short) 1).setCellValue(rs.getString(1));
	 * row1.createCell((short) 2).setCellValue(rs.getString(2));
	 * row1.createCell((short) 3).setCellValue(rs.getString(3));
	 * row1.createCell((short) 4).setCellValue(rs.getString(4));
	 * row1.createCell((short) 5).setCellValue(rs.getString(5)); i1++; }
	 * 
	 * hwb.write(fileOut); fileOut.close();
	 * //System.out.println("Your excel file has been generated!");
	 * System.out.println("Your secondtable.over..!");
	 * 
	 * } catch(Exception e) { e.printStackTrace(); } // TODO Auto-generated
	 * method stub finally { try{
	 * 
	 * rs.close(); st.close();con.close(); } catch(Exception e) {
	 * e.printStackTrace(); } }
	 * 
	 * }
	 * 
	 * 
	 * public void writeTable3(HSSFWorkbook hwb, FileOutputStream fileOut,
	 * String filename) { Connection con=RwsOffices.getConn(); Statement
	 * st=null; ResultSet rs=null; boolean flag=false; try {
	 * 
	 * fileOut= new FileOutputStream(filename);
	 * 
	 * System.out.println("Your thirdtable...!"); HSSFSheet sheet2 =
	 * hwb.createSheet("WQM_LabTestingDetails"); HSSFRow rowhead2=
	 * sheet2.createRow((short)0); rowhead2.createCell((short)
	 * 0).setCellValue("SNo"); rowhead2.createCell((short)
	 * 1).setCellValue("TestId"); rowhead2.createCell((short)
	 * 2).setCellValue("ParameterId"); rowhead2.createCell((short)
	 * 3).setCellValue("TESTING_PARAMETER_VALUE"); st=con.createStatement();
	 * String qry="select * from WQM_LabTestingDetails";
	 * rs=st.executeQuery(qry); int i2=1; while(rs.next()){ HSSFRow row2=
	 * sheet2.createRow((short)i2); row2.createCell((short)
	 * 0).setCellValue(Integer.toString(i2)); row2.createCell((short)
	 * 1).setCellValue(rs.getString(1)); row2.createCell((short)
	 * 2).setCellValue(rs.getString(2)); row2.createCell((short)
	 * 3).setCellValue(rs.getString(3)); i2++; }
	 * 
	 * hwb.write(fileOut); fileOut.close();
	 * System.out.println("Your thirdtable.over..!");
	 * 
	 * } catch(Exception e) { e.printStackTrace(); } // TODO Auto-generated
	 * method stub finally { try{
	 * 
	 * rs.close(); st.close();con.close(); } catch(Exception e) {
	 * e.printStackTrace(); } }
	 * 
	 * }
	 * 
	 * 
	 * public void writeTable4(HSSFWorkbook hwb, FileOutputStream fileOut,
	 * String filename) { Connection con=RwsOffices.getConn(); Statement
	 * st=null; ResultSet rs=null; boolean flag=false; try { fileOut= new
	 * FileOutputStream(filename);
	 * 
	 * System.out.println("Your fourthtable...!"); HSSFSheet sheet3 =
	 * hwb.createSheet("WQM_QUALITYPARAMETER"); HSSFRow rowhead3=
	 * sheet3.createRow((short)0); rowhead3.createCell((short)
	 * 0).setCellValue("SNo"); rowhead3.createCell((short)
	 * 1).setCellValue("TestId"); rowhead3.createCell((short)
	 * 2).setCellValue("ParameterId"); rowhead3.createCell((short)
	 * 3).setCellValue("ParameterType"); rowhead3.createCell((short)
	 * 4).setCellValue("Description"); rowhead3.createCell((short)
	 * 5).setCellValue("UnitOfMeasurement"); rowhead3.createCell((short)
	 * 6).setCellValue("BISPermissibleLimit"); rowhead3.createCell((short)
	 * 7).setCellValue("BISDesirableLimit"); rowhead3.createCell((short)
	 * 8).setCellValue("TESTING_PARAMETER_VALUE"); st=con.createStatement();
	 * String qry="select * from WQM_QUALITYPARAMETER"; rs=st.executeQuery(qry);
	 * int i3=1; while(rs.next()){ HSSFRow row3= sheet3.createRow((short)i3);
	 * row3.createCell((short) 0).setCellValue(Integer.toString(i3));
	 * row3.createCell((short) 1).setCellValue(rs.getString(1));
	 * row3.createCell((short) 2).setCellValue(rs.getString(2));
	 * row3.createCell((short) 3).setCellValue(rs.getString(3));
	 * row3.createCell((short) 4).setCellValue(rs.getString(4));
	 * row3.createCell((short) 5).setCellValue(rs.getString(5));
	 * row3.createCell((short) 6).setCellValue(rs.getString(6));
	 * row3.createCell((short) 7).setCellValue(rs.getString(7));
	 * row3.createCell((short) 8).setCellValue(rs.getString(8)); i3++; }
	 * 
	 * hwb.write(fileOut); fileOut.close();
	 * System.out.println("Your fourthtable.over..!");
	 * 
	 * //System.out.println("Your excel file has been generated!");
	 * 
	 * } catch(Exception e) { e.printStackTrace(); } // TODO Auto-generated
	 * method stub finally { try{
	 * 
	 * rs.close(); st.close();con.close(); } catch(Exception e) {
	 * e.printStackTrace(); } }
	 * 
	 * }
	 * 
	 * 
	 * public void writeTable5(HSSFWorkbook hwb, FileOutputStream fileOut,
	 * String filename) { Connection con=RwsOffices.getConn(); Statement
	 * st=null; ResultSet rs=null; boolean flag=false; try {
	 * 
	 * fileOut= new FileOutputStream(filename);
	 * 
	 * System.out.println("Your fifthtable...!"); HSSFSheet sheet4 =
	 * hwb.createSheet("Rwss_Sources"); HSSFRow rowhead4=
	 * sheet4.createRow((short)0); rowhead4.createCell((short)
	 * 0).setCellValue("SNo"); rowhead4.createCell((short)
	 * 1).setCellValue("Source"); rowhead4.createCell((short)
	 * 2).setCellValue("ASSET_CODE"); rowhead4.createCell((short)
	 * 3).setCellValue("SOURCE_CODE"); st=con.createStatement(); String
	 * qry="select * from Rwss_Sources"; rs=st.executeQuery(qry); int i4=1;
	 * while(rs.next()){ HSSFRow row4= sheet4.createRow((short)i4);
	 * row4.createCell((short) 0).setCellValue(Integer.toString(i4));
	 * row4.createCell((short) 1).setCellValue(rs.getString(1));
	 * row4.createCell((short) 2).setCellValue(rs.getString(2));
	 * row4.createCell((short) 3).setCellValue(rs.getString(3)); i4++; }
	 * 
	 * hwb.write(fileOut); fileOut.close();
	 * System.out.println("Your fifthtable.over..!");
	 * //System.out.println("Your excel file has been generated!");
	 * 
	 * } catch(Exception e) { e.printStackTrace(); } // TODO Auto-generated
	 * method stub finally { try{
	 * 
	 * rs.close(); st.close();con.close(); } catch(Exception e) {
	 * e.printStackTrace(); } }
	 * 
	 * }
	 */

	// /////////////////////////////////////////////////

	public void writeDataSheet(WritableSheet s) throws WriteException {
		RwsOffices rwsOffices = new RwsOffices();
		/* Format the Font */
		WritableFont wf = new WritableFont(WritableFont.ARIAL, 10,
				WritableFont.BOLD);
		WritableCellFormat cf = new WritableCellFormat(wf);
		cf.setWrap(true);

		/* Creates Label and writes date to one cell of sheet */
		Label l = new Label(0, 0, "Date", cf);
		s.addCell(l);
		WritableCellFormat cf1 = new WritableCellFormat(DateFormats.FORMAT9);

		/* Creates Label and writes float number to one cell of sheet */
		l = new Label(2, 0, "Float", cf);
		s.addCell(l);
		WritableCellFormat cf2 = new WritableCellFormat(NumberFormats.FLOAT);
		Number n = new Number(2, 1, 3.1415926535, cf2);
		s.addCell(n);

		n = new Number(2, 2, -3.1415926535, cf2);
		s.addCell(n);

		/*
		 * Creates Label and writes float number upto 3 decimal to one cell of
		 * sheet
		 */
		l = new Label(3, 0, "3dps", cf);
		s.addCell(l);
		NumberFormat dp3 = new NumberFormat("#.###");
		WritableCellFormat dp3cell = new WritableCellFormat(dp3);
		n = new Number(3, 1, 3.1415926535, dp3cell);
		s.addCell(n);

		/* Creates Label and adds 2 cells of sheet */
		l = new Label(4, 0, "Add 2 cells", cf);
		s.addCell(l);
		n = new Number(4, 1, 10);
		s.addCell(n);
		n = new Number(4, 2, 16);
		s.addCell(n);
		Formula f = new Formula(4, 3, "E1+E2");
		s.addCell(f);

		/* Creates Label and multipies value of one cell of sheet by 2 */
		l = new Label(5, 0, "Multipy by 2", cf);
		s.addCell(l);
		n = new Number(5, 1, 10);
		s.addCell(n);
		f = new Formula(5, 2, "F1 * 3");
		s.addCell(f);

		/* Creates Label and divide value of one cell of sheet by 2.5 */
		l = new Label(6, 0, "Divide", cf);
		s.addCell(l);
		n = new Number(6, 1, 12);
		s.addCell(n);
		f = new Formula(6, 2, "F1/2.5");
		s.addCell(f);
	}

	private static void writeImageSheet(WritableSheet s) throws WriteException {
		/* Creates Label and writes image to one cell of sheet */
		Label l = new Label(0, 0, "Image");
		s.addCell(l);
		WritableImage wi = new WritableImage(0, 3, 5, 7, new File("image.png"));
		s.addImage(wi);

		/* Creates Label and writes hyperlink to one cell of sheet */
		l = new Label(0, 15, "HYPERLINK");
		s.addCell(l);
		Formula f = new Formula(1, 15,
				"HYPERLINK(\"http://www.andykhan.com/jexcelapi\", "
						+ "\"JExcelApi Home Page\")");
		s.addCell(f);

	}

	/**
 * 
 */
	public boolean createFirstTable() {
		Connection con = RwsOffices.getConn();
		Statement st = null, st1 = null, st2 = null, st3 = null, st4 = null, st5 = null;
		ResultSet rs = null, rs1 = null, rs2 = null, rs3 = null, rs4 = null, rs5 = null;
		String sno = "";
		String testid = "";
		long rcount = 0;
		int rowcount = 0;
		boolean flag = false;
		try {
			//System.out.println("first table creation started..........");
			st = con.createStatement();
			st1 = con.createStatement();
			st2 = con.createStatement();
			st3 = con.createStatement();
			st4 = con.createStatement();
			st5 = con.createStatement();

			String countquery = "Select testid from WQ_Last_Testid_Temp_Tbl where testtype='1'";
			rs5 = st5.executeQuery(countquery);
			while (rs5.next()) {
				rcount = rs5.getInt(1);
			}
			// rcount=404418;
			//System.out.println("my testid starat from" + rcount);

			String selquery = "Select tname from tab where tname like 'WQM_WATERQUALITYTESTING'";
			rs = st.executeQuery(selquery);
			if (!rs.next()) {
				String crquery = "create table WQM_WaterQualityTesting(TestId VARCHAR2(50),Source  VARCHAR2(50),HabitationId  VARCHAR2(50),DistrictId  VARCHAR2(50),ContaminatedYes_No  VARCHAR2(50),TestCode  VARCHAR2(50))";
				st1.executeUpdate(crquery);
				// System.out.println("crquery"+crquery);
			} else {
				String delquery = "delete from WQM_WaterQualityTesting";
				st1.executeUpdate(delquery);
				con.commit();
				// System.out.println("delquery"+delquery);
			}

			String query1 = "SELECT * FROM FINALSOURCES_TEMP_TBL";
			// System.out.println("qyery1:"+query1);
			rs1 = st2.executeQuery(query1);

			while (rs1.next()) {
				rcount++;
				// System.out.println("rcount1:"+rcount);
				sno = "" + rcount;
				String sCode = rs1.getString(1);
				String type = rs1.getString(7);

				// System.out.println("sCode:"+sCode);
				// System.out.println("type:"+type);
				if (sno.length() == 1) {
					testid = "000000000" + sno;
				} else if (sno.length() == 2) {
					testid = "00000000" + sno;
				} else if (sno.length() == 3) {
					testid = "0000000" + sno;
				} else if (sno.length() == 4) {
					testid = "000000" + sno;
				} else if (sno.length() == 5) {
					testid = "00000" + sno;
				} else if (sno.length() == 6) {
					testid = "0000" + sno;
				} else if (sno.length() == 7) {
					testid = "000" + sno;
				} else if (sno.length() == 8) {
					testid = "00" + sno;
				} else if (sno.length() == 9) {
					testid = "0" + sno;
				}
				if (sCode != null && sCode.substring(19, 21).equals("SO")) {
					if (type != null && type.equals("2")) {
						sCode = "S" + sCode;
					} else if (type != null && type.equals("1")) {
						sCode = "SC" + sCode;
					}

				} else if (sCode != null
						&& sCode.substring(19, 21).equals("HP")) {
					sCode = "H" + sCode;
				}

				String Query = "insert into WQM_WaterQualityTesting(TestId,Source,HabitationId,Districtid,TestCode)values('"
						+ testid
						+ "','"
						+ sCode
						+ "','"
						+ rs1.getString(4)
						+ "','"
						+ rs1.getString(5)
						+ "','"
						+ rs1.getString(3)
						+ "')";
				// System.out.println("Query"+Query);
				rowcount += st3.executeUpdate(Query);
			}
			if (rowcount > 0) {
				flag = true;
			}
			//System.out.println("first table creation..over....");

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {

				rs.close();
				st.close();
				rs1.close();
				st1.close();
				st2.close();
				st3.close();
				// con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return flag;
	}

	public boolean createSecondTable() {
		//System.out.println("second table creation started......");
		Connection con = RwsOffices.getConn();
		Statement st = null, st1 = null, st2 = null, st3 = null, st4 = null;
		ResultSet rs = null, rs1 = null, rs2 = null, rs3 = null, rs4 = null;
		boolean flag = false;
		try {
			int rcount = 0;
			String empty = "";
			int contaminated = 0, rowcount = 0;

			st = con.createStatement();
			st1 = con.createStatement();
			st2 = con.createStatement();
			st3 = con.createStatement();
			st4 = con.createStatement();

			String selquery = "Select tname from tab where tname like 'WQM_WATERTESTINGSAMPLES'";
			rs3 = st3.executeQuery(selquery);
			if (!rs3.next()) {
				String crquery = "create table WQM_WaterTestingSamples(TestId VARCHAR2(50),TestingDate VARCHAR2(50),LabId VARCHAR2(50),Sample VARCHAR2(50),AP_LABID VARCHAR2(50))";
				st2.executeUpdate(crquery);
				// System.out.println("crquery"+crquery);
			} else {
				String delquery = "delete from WQM_WaterTestingSamples";
				st2.executeUpdate(delquery);
				con.commit();
				// System.out.println("delquery"+delquery);
			}

			// String Query1 =
			// "SELECT DISTINCT to_char(RWS_WQ_TEST_RESULTS_TBL.FORWARDED_ON,'dd/mm/yyyy'), wslab_ddwslab.LabId, WQM_WaterQualityTesting.TestId,WQM_WaterQualityTesting.TestCode,RWS_WQ_TEST_RESULTS_TBL.LAB_CODE FROM WQM_WaterQualityTesting INNER JOIN (RWS_WQ_TEST_RESULTS_TBL INNER JOIN wslab_ddwslab ON RWS_WQ_TEST_RESULTS_TBL.LAB_CODE = wslab_ddwslab.LAB_CODE) ON WQM_WaterQualityTesting.TestCode = RWS_WQ_TEST_RESULTS_TBL.TEST_ID";
			// String
			// Query1="SELECT distinct RWS_WATER_SAMPLE_COLLECT_TBL.PREPARED_ON, [wslab-ddwslab].LabId, RWS_WQ_TEST_RESULTS_TBL.TEST_ID, RWS_WQ_TEST_RESULTS_TBL.TEST_CODE, RWS_WQ_TEST_RESULTS_TBL.LAB_CODE FROM RWS_WATER_SAMPLE_COLLECT_TBL INNER JOIN (WQM_WaterQualityTesting INNER JOIN (RWS_WQ_TEST_RESULTS_TBL INNER JOIN [wslab-ddwslab] ON RWS_WQ_TEST_RESULTS_TBL.LAB_CODE = [wslab-ddwslab].LAB_CODE) ON WQM_WaterQualityTesting.TestCode = RWS_WQ_TEST_RESULTS_TBL.TEST_ID) ON RWS_WATER_SAMPLE_COLLECT_TBL.TEST_ID = WQM_WaterQualityTesting.TestCode";
			String Query1 = "SELECT distinct b.TESTID,a.PREPARED_ON,c.test_code,a.lab_code FROM RWS_WATER_SAMPLE_COLLECT_TBL a,WQM_WaterQualityTesting b,RWS_WQ_TEST_RESULTS_TBL c  where a.test_id=b.testcode and a.test_id=c.test_id";
			//System.out.println("query1wwwww:" + Query1);
			rs = st.executeQuery(Query1);
			String sno = "";
			String testid = "";
			while (rs.next()) {
				// String
				// Query="insert into WQM_WaterTestingSamples(TestId,TestingDate,LabId,Sample,AP_LABID) values ('"+rs.getString(3)+"','"+rs.getString(1)+"','"+rs.getString(2)+"','"+rs.getString(4)+"','"+rs.getString(5)+"')";
				String Query = "insert into WQM_WaterTestingSamples(TestId,TestingDate,Sample,AP_LABID) values ('"
						+ rs.getString(1)
						+ "','"
						+ rs.getString(2)
						+ "','"
						+ rs.getString(3) + "','" + rs.getString(4) + "')";
				// System.out.println("Query"+Query);
				rowcount += st1.executeUpdate(Query);
			}
			// System.out.println("inserted rows"+rowcount);
			if (rowcount > 0) {
				// flag=true;
				String updateqry = "update WQM_WaterTestingSamples t set LabId=(select LabId from  wslab_ddwslab where LAB_CODE=t.AP_LABID)";
				int up = st4.executeUpdate(updateqry);
				//System.out.println("Update QRY" + updateqry);
				Debug.println("update qry............" + updateqry);
				if (up > 0) {
					Debug.println("updated susscessfully............" + up);
					con.commit();
					flag = true;
				} else
					Debug.println("failed to update............");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {

				rs3.close();
				st3.close();
				// rs2.close();
				st2.close();
				rs.close();
				st.close();
				st1.close();
				st4.close();
				// con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		//System.out.println("second table creation over.........");
		return flag;

	}

	public boolean createThirdTable() {
		//System.out.println("Third table creation started......");
		Connection con = RwsOffices.getConn();
		Statement st = null, st1 = null, st2 = null, st3 = null;
		ResultSet rs = null, rs1 = null, rs2 = null, rs3 = null;
		boolean flag = false;
		String Query = "";
		try {
			int rcount = 0;
			int contaminated = 0, rowcount = 0;

			st = con.createStatement();
			st1 = con.createStatement();
			st2 = con.createStatement();
			st3 = con.createStatement();

			String selquery = "Select tname from tab where tname like 'WQM_LABTESTINGDETAILS'";
			rs = st.executeQuery(selquery);
			if (!rs.next()) {
				String crquery = "create table WQM_LabTestingDetails(TestId VARCHAR2(50),ParameterId VARCHAR2(50),TESTING_PARAMETER_VALUE VARCHAR2(50))";
				st1.executeUpdate(crquery);
				// System.out.println("crquery"+crquery);
			} else {
				String delquery = "delete from WQM_LabTestingDetails";
				st1.executeUpdate(delquery);
				con.commit();
				// System.out.println("delquery"+delquery);
			}

			String Query1 = "SELECT WQM_WaterQualityTesting.TestId, WQQualityParameter.ParameterId, RWS_WQ_TEST_RESULTS_LNK_TBL.TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_TBL INNER JOIN ((WQQualityParameter INNER JOIN RWS_WQ_TEST_RESULTS_LNK_TBL ON WQQualityParameter.pcode = RWS_WQ_TEST_RESULTS_LNK_TBL.TESTING_PARAMETER_CODE) INNER JOIN WQM_WaterQualityTesting ON RWS_WQ_TEST_RESULTS_LNK_TBL.TEST_ID = WQM_WaterQualityTesting.TestCode) ON (WQM_WaterQualityTesting.TestCode = RWS_WQ_TEST_RESULTS_TBL.TEST_ID) AND (RWS_WQ_TEST_RESULTS_TBL.TEST_CODE = WQQualityParameter.TestId) WHERE (((RWS_WQ_TEST_RESULTS_LNK_TBL.TESTING_PARAMETER_VALUE) Is Not Null))";
			// System.out.println("Query111:"+Query1);
			rs1 = st2.executeQuery(Query1);

			String sno = "";
			String testid = "";
			int salcount = 0;
			while (rs1.next()) {
				String value1 = rs1.getString(1);
				String value2 = rs1.getString(2);
				String value3 = rs1.getString(3);
				if (value2.equals("005")) {
					double value = Double.parseDouble(value3);
					value = 0.03 + ((1.806 * value) / 1000);
					if (value > 1.836) {
						salcount++;
						Query = "insert into WQM_LabTestingDetails values ('"
								+ value1 + "','014','" + value + "')";
					} else {
						Query = "insert into WQM_LabTestingDetails values ('"
								+ value1 + "','" + value2 + "','" + value3
								+ "')";
					}
				} else {
					Query = "insert into WQM_LabTestingDetails values ('"
							+ value1 + "','" + value2 + "','" + value3 + "')";
				}
				// System.out.println("Query222:"+Query);
				rowcount += st3.executeUpdate(Query);
				// System.out.println("inserted rows"+rowcount);

			}
			// System.out.println("Salinity Count"+salcount);
			if (rowcount > 0) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			// System.out.println("Query333"+Query);
		} finally {
			try {

				rs.close();
				st.close();
				rs1.close();
				st1.close();
				st2.close();
				st3.close();
				// con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		System.out.println("Third table creation over.........");
		return flag;

	}

	public boolean createFourthTable() {
		System.out.println("Fourth table creation started......");
		Connection con = RwsOffices.getConn();
		Statement st = null, st1 = null, st2 = null, st3 = null;
		ResultSet rs = null, rs1 = null, rs2 = null, rs3 = null;
		boolean flag = false;
		String Query = "";
		try {
			int rcount = 0;
			int contaminated = 0, rowcount = 0;

			st = con.createStatement();
			st1 = con.createStatement();
			st2 = con.createStatement();
			st3 = con.createStatement();

			String selquery = "Select tname from tab where tname like 'WQM_QUALITYPARAMETER'";
			rs = st.executeQuery(selquery);
			if (!rs.next()) {
				String crquery = "create table WQM_QUALITYPARAMETER(TestId VARCHAR2(50),ParameterId VARCHAR2(50),ParameterType VARCHAR2(50),Description VARCHAR2(200),UnitOfMeasurement VARCHAR2(50),BISPermissibleLimit VARCHAR2(50),BISDesirableLimit VARCHAR2(50),TESTING_PARAMETER_VALUE VARCHAR2(50))";
				st1.executeUpdate(crquery);
				// System.out.println("crquery"+crquery);
			} else {
				String delquery = "delete from WQM_QUALITYPARAMETER";
				st1.executeUpdate(delquery);
				con.commit();
				// System.out.println("delquery"+delquery);
			}

			String Query1 = "select a.TestId,b.ParameterId,b.ParameterType,b.Description, decode(b.UnitOfMeasurement,'null',' '),b.BISPermissibleLimit,b.BISDesirableLimit,a.TESTING_PARAMETER_VALUE from WQM_LabTestingDetails a,WQQualityParameter b where a.ParameterId=b.ParameterId";
			// System.out.println("Query111:"+Query1);
			rs1 = st2.executeQuery(Query1);
			while (rs1.next()) {
				String value1 = rs1.getString(1);
				String value2 = rs1.getString(2);
				String value3 = rs1.getString(3);
				String value4 = rs1.getString(4);
				String value5 = rs1.getString(5);
				String value6 = rs1.getString(6);
				String value7 = rs1.getString(7);
				String value8 = rs1.getString(8);

				Query = "insert into WQM_QUALITYPARAMETER values ('" + value1
						+ "','" + value2 + "','" + value3 + "','" + value4
						+ "','" + value5 + "','" + value6 + "','" + value7
						+ "','" + value8 + "')";

				// System.out.println("Query222:"+Query);
				rowcount += st3.executeUpdate(Query);
				// System.out.println("inserted rows"+rowcount);

			}
			if (rowcount > 0) {
				flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
			// System.out.println("Query333"+Query);
		} finally {
			try {

				rs.close();
				st.close();
				st1.close();
				rs1.close();
				st2.close();
				st3.close();
				// con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		System.out.println(" Fourth table creation over.........");
		return flag;

	}

	public boolean createFifthTable() {
		System.out.println("Fifth table creation started......");
		Connection con = RwsOffices.getConn();
		Statement st = null, st1 = null, st2 = null, st3 = null, st4 = null, st5 = null, st6 = null, st7 = null;
		ResultSet rs = null, rs1 = null, rs2 = null, rs3 = null, rs6 = null;
		boolean flag = false;
		String Query = "", sourcetype = "", upquery = "", insquery = "";
		try {
			int rcount = 0;
			int contaminated = 0, rowcount = 0;

			st = con.createStatement();
			st1 = con.createStatement();
			st2 = con.createStatement();
			st3 = con.createStatement();
			st4 = con.createStatement();
			st5 = con.createStatement();
			st6 = con.createStatement();
			st7 = con.createStatement();
			String selquery = "Select tname from tab where tname like 'RWSS_SOURCES'";
			rs = st.executeQuery(selquery);
			if (!rs.next()) {
				String crquery = "create table Rwss_Sources(Source VARCHAR2(50),ASSET_CODE VARCHAR2(50),SOURCE_CODE VARCHAR2(50))";
				st1.executeUpdate(crquery);
				// System.out.println("crquery"+crquery);
			} else {
				String delquery = "delete from Rwss_Sources";
				st1.executeUpdate(delquery);
				con.commit();
				// System.out.println("delquery"+delquery);
			}

			String selqry = "select source_code from FINALSOURCES_TEMP_TBL";
			rs1 = st2.executeQuery(selqry);
			while (rs1.next()) {
				sourcetype = rs1.getString(1);
				// System.out.println("sourcetype"+sourcetype.substring(19,21));

				if (sourcetype.substring(19, 21).equals("HP")) {
					// upquery="update FINALSOURCES_TEMP_TBL t set ASSET_CODE=(select ASSET_CODE from RWS_HP_SUBCOMP_PARAM_TBL where HP_CODE=t.source_code)";
					// rcount=st3.executeUpdate(upquery);
					// System.out.println("HP update count");

					String qry1 = "select ASSET_CODE from RWS_HP_SUBCOMP_PARAM_TBL where HP_CODE='"
							+ sourcetype + "'";
					rs6 = st6.executeQuery(qry1);
					if (rs6.next()) {
						upquery = "update FINALSOURCES_TEMP_TBL t set ASSET_CODE='"
								+ rs6.getString(1)
								+ "' where source_code='"
								+ sourcetype + "'";
						rcount = st7.executeUpdate(upquery);

					}

					System.out.println("HP update count");

				}

				else if (sourcetype.substring(19, 21).equals("SO")) {
					// upquery="update FINALSOURCES_TEMP_TBL t set ASSET_CODE=(select ASSET_CODE from rws_source_tbl where source_code=t.source_code)";
					// rcount=st3.executeUpdate(upquery);
					// System.out.println("SO update count");

					String qry1 = "select ASSET_CODE from rws_source_tbl where Source_CODE='"
							+ sourcetype + "'";
					rs6 = st6.executeQuery(qry1);
					if (rs6.next()) {
						upquery = "update FINALSOURCES_TEMP_TBL t set ASSET_CODE='"
								+ rs6.getString(1)
								+ "' where source_code='"
								+ sourcetype + "'";
						rcount = st7.executeUpdate(upquery);

					}
					System.out.println("SO update count");
				}

				else if (sourcetype.substring(19, 21).equals("OW")) {
					// upquery="update FINALSOURCES_TEMP_TBL t set ASSET_CODE=(select ASSET_CODE from RWS_OPEN_WELL_MAST_TBL where OPENWELL_CODE=t.source_code)";
					// rcount=st3.executeUpdate(upquery);
					// System.out.println("OW update count");

					String qry1 = "select ASSET_CODE from RWS_OPEN_WELL_MAST_TBL where OPENWELL_CODE='"
							+ sourcetype + "'";
					rs6 = st6.executeQuery(qry1);
					if (rs6.next()) {
						upquery = "update FINALSOURCES_TEMP_TBL t set ASSET_CODE='"
								+ rs6.getString(1)
								+ "' where source_code='"
								+ sourcetype + "'";
						rcount = st7.executeUpdate(upquery);

					}
					System.out.println("OW update count");

				} else if (sourcetype.substring(19, 21).equals("SH")) {
					// upquery="update FINALSOURCES_TEMP_TBL t set ASSET_CODE=(select ASSET_CODE from  RWS_SHALLOWHANDPUMPS_TBL where SHALLOWHP_CODE=t.source_code)";
					// rcount=st3.executeUpdate(upquery);
					// System.out.println("SH update count");

					String qry1 = "select ASSET_CODE from RWS_SHALLOWHANDPUMPS_TBL where SHALLOWHP_CODE='"
							+ sourcetype + "'";
					rs6 = st6.executeQuery(qry1);
					if (rs6.next()) {
						upquery = "update FINALSOURCES_TEMP_TBL t set ASSET_CODE='"
								+ rs6.getString(1)
								+ "' where source_code='"
								+ sourcetype + "'";
						rcount = st7.executeUpdate(upquery);

					}
					System.out.println("SHP update count");

				}

			}

			// System.out.println("update count"+rcount);

			if (rcount > 0) {
				String selqry2 = "select a.Source,b.ASSET_CODE,b.SOURCE_CODE from WQM_WaterQualityTesting a,FINALSOURCES_TEMP_TBL b where b.TEST_ID=a.TestCode ";
				rs2 = st4.executeQuery(selqry2);
				while (rs2.next()) {

					insquery = "insert into Rwss_Sources values('"
							+ rs2.getString(1) + "','" + rs2.getString(2)
							+ "','" + rs2.getString(3) + "')";
					rowcount += st5.executeUpdate(insquery);
				}
				System.out.println("insert count" + rowcount);
			}

			if (rowcount > 1) {
				flag = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
			// System.out.println("Query333"+Query);
		} finally {
			try {

				rs.close();
				st.close();
				st1.close();
				rs1.close();
				st2.close();
				st3.close();
				st4.close();
				// rs2.close();
				st5.close();
				// con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		System.out.println(" Fifth table creation over.........");
		return flag;

	}

	// TODO Auto-generated method stub

	public void insertTestidCount() {

		Connection con = RwsOffices.getConn();
		Statement st = null, st1 = null;
		ResultSet rs = null, rs1 = null;
		int testid = 0;

		String Query = "";
		try {
			st = con.createStatement();
			st1 = con.createStatement();

			String selqry = "select max(testid) from WQM_WATERQUALITYTESTING ";
			rs = st.executeQuery(selqry);
			while (rs.next()) {
				testid = rs.getInt(1);
			}
			Debug.println("selqry qry............" + selqry);

			String insqry = "update WQ_Last_Testid_Temp_Tbl set TestId='"
					+ testid + "' where testtype='1'";
			st1.executeUpdate(insqry);
			Debug.println("insert qry............" + insqry);

		} catch (Exception e) {
			e.printStackTrace();
			// System.out.println("Query333"+Query);
		} finally {
			try {

				rs.close();
				st.close();

				// con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	public void insertFTKTestidCount() {

		Connection con = RwsOffices.getConn();
		Statement st = null, st1 = null;
		ResultSet rs = null, rs1 = null;
		int testid = 0;

		String Query = "";
		try {
			st = con.createStatement();
			st1 = con.createStatement();

			String selqry = "select max(DDWS_TEST_ID) from WQ_FTKTestingDetails_Temp_Tbl ";
			rs = st.executeQuery(selqry);
			while (rs.next()) {
				testid = rs.getInt(1);
			}
			Debug.println("selqry qry............" + selqry);

			String insqry = "update WQ_Last_Testid_Temp_Tbl set TestId='"
					+ testid + "' where testtype='2'";
			st1.executeUpdate(insqry);
			Debug.println("insert qry............" + insqry);

		} catch (Exception e) {
			e.printStackTrace();
			// System.out.println("Query333"+Query);
		} finally {
			try {

				rs.close();
				st.close();

				// con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}

	public void deleteFinalSources() {
		Statement st = null, st1 = null, st2 = null, st3 = null, st4 = null, st5 = null, st6 = null;
		ResultSet rs = null, rs1 = null, rs2 = null, rs3 = null, rs4 = null, rs5 = null;
		Debug.println("i am deleting...........");
		Connection con = RwsOffices.getConn();
		try {
			st = con.createStatement();
			st1 = con.createStatement();
			st2 = con.createStatement();
			st3 = con.createStatement();
			st4 = con.createStatement();
			st5 = con.createStatement();
			st6 = con.createStatement();

			String selquery = "Select tname from tab where tname like 'FINALSOURCES'";
			rs = st.executeQuery(selquery);
			if (rs.next()) {
				String delquery = "drop table finalSources";
				st6.executeUpdate(delquery);
				con.commit();
				System.out.println("delquery" + delquery);
			}

			selquery = "Select tname from tab where tname like 'WQM_WATERQUALITYTESTING'";
			rs1 = st1.executeQuery(selquery);
			if (rs1.next()) {
				String delquery1 = "drop table WQM_WaterQualityTesting";
				st6.executeUpdate(delquery1);
				con.commit();
				System.out.println("delquery" + delquery1);
			}

			selquery = "Select tname from tab where tname like 'WQM_WATERTESTINGSAMPLES'";
			rs2 = st2.executeQuery(selquery);
			if (rs2.next()) {
				String delquery2 = "drop table WQM_WaterTestingSamples";
				st6.executeUpdate(delquery2);
				con.commit();
				System.out.println("delquery" + delquery2);
			}

			selquery = "Select tname from tab where tname like 'WQM_LABTESTINGDETAILS'";
			rs3 = st3.executeQuery(selquery);
			if (rs3.next()) {
				String delquery3 = "drop table WQM_LabTestingDetails";
				st6.executeUpdate(delquery3);
				con.commit();
				System.out.println("delquery" + delquery3);
			}

			selquery = "Select tname from tab where tname like 'WQM_QUALITYPARAMETER'";
			rs4 = st4.executeQuery(selquery);
			if (rs4.next()) {
				String delquery4 = "drop table WQM_QualityParameter";
				st6.executeUpdate(delquery4);
				con.commit();
				System.out.println("delquery" + delquery4);
			}

			selquery = "Select tname from tab where tname like 'RWSS_SOURCES'";
			rs5 = st5.executeQuery(selquery);
			if (rs5.next()) {
				String delquery5 = "drop table Rwss_Sources";
				st6.executeUpdate(delquery5);
				con.commit();
				System.out.println("delquery" + delquery5);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				st.close();
				rs1.close();
				st1.close();
				rs2.close();
				st2.close();
				rs3.close();
				st3.close();
				rs4.close();
				st4.close();
				rs5.close();
				st5.close();
				st6.close();
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

	}

	public boolean deleteDir(File dir) {
		if (dir.isDirectory()) {
			String[] children = dir.list();
			for (int i = 0; i < children.length; i++) {
				boolean success = deleteDir(new File(dir, children[i]));
				if (!success) {
					return false;
				}
			}
		}

		// The directory is now empty so delete it
		return dir.delete();
	}

	// //////////////////////////////ProjectShelf///////////////////////////////////

	public boolean createPrjShelfFirstTable(String fromdate, String todate,
			Connection con) {
		boolean flag = false;
		Statement st = null, st1 = null, st2 = null, st3 = null, st4 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		String query = "";
		String workid = "", main = "0", workname = "", stateid = "002", dcode = "", schemetypeid = "", type = "", sancyear = "", estcost = "0", revestcost = "0", goicost = "0", statecost = "0", commcont = "0", capacity = "0", service = "", exp = "0", moreexp = "0", dofcomm = "", dofcomp = "", psy = "", atm = "No";
		double popcov = 0;
		String year = RwsUtils.getCurrentYear();
		int nextyear = Integer.parseInt(year) + 1;
		String finyear = year + "-" + nextyear;
		String sysdate = RwsUtils.getCurrentDate("dd/MM/yy");

		try {
			st = con.createStatement();
			st1 = con.createStatement();
			st2 = con.createStatement();
			st3 = con.createStatement();
			st4 = con.createStatement();

			String selquery = "Select tname from tab where tname like 'RWS_SCHEMES_TEMP_TBL'";
			rs = st.executeQuery(selquery);
			if (!rs.next()) {
				// //adding on 21082013
				// SLSCCMeetingDate,SLSCCMeetingDate,TotalExpectedGOIExp13,TotalExpectedSTATEExp13,AdminDate
				// String
				// crquery="create table RWS_Schemes_TEMP_TBL(SchemeId varchar2(14),work_id varchar2(14),MainSchemeId varchar2(30),SchemeName varchar2(200),StateId varchar2(50),DistrictId varchar2(50),SchemeTypeId varchar2(50),Type varchar2(50),SanctionYear varchar2(50),EstimatedCost number(11,2),RevisedEstimatedCost number(11,2),GOICost number(11,2),StateCost number(11,2),CommCont number(11,2),PopulationCovered number(11,2),Capacity  varchar2(50),ServiceLevel number(11,2),Expenditure number(11,2),ExpMoreReason number(11,2),DateOfCommencement Date,DateOfCompletion Date,ProjectShelfYear varchar2(10),Atmarpan varchar2(3),ProbableExpenditure number(11,2),programme_code  varchar2(50),subprogramme_code  varchar2(50),category_code  varchar2(50),old_new  varchar2(50),aug_new_code  varchar2(50),APSCHOOLID varchar2(50),SLSCCMeetingDate varchar2(50),TotalExpectedGOIExp13 number(30),TotalExpectedSTATEExp13 number(30),AdminDate Date)";
				String crquery = "create table RWS_Schemes_TEMP_TBL(SchemeIdOfState varchar2(14),MainSchemeId_IMIS varchar2(30),SchemeName varchar2(200),StateId varchar2(50),DistrictId varchar2(50),SchemeTypeId varchar2(50),Type varchar2(50),SanctionYear varchar2(50),EstimatedCost number(11,2),RevisedEstimatedCost number(11,2),GOICost number(11,2),StateCost number(11,2),CommCont number(11,2),PopulationCovered number(11,2),Capacity  varchar2(50),ServiceLevel number(11,2),Expenditure number(11,2),ExpMoreReason number(11,2),DateOfCommencement Date,DateOfCompletion Date,PhysicalCompletionDate date,FinancialCompletionDate date ,HandedCommunityDate date,IsFullyPRI varchar2(10),Category varchar2(10),IsWasteWaterMgmt number(1),WasteWaterMNREGAS number(11,2),WasteWaterTSC number(11,2),WasteWaterOTH number(11,2),programme_code varchar2(3))";
				st1.executeUpdate(crquery);
				System.out.println("crquery" + crquery);
			} else {
				String delquery = "delete from RWS_Schemes_TEMP_TBL";
				st1.executeUpdate(delquery);
				con.commit();
				System.out.println("delquery" + delquery);
			}

			String qry = "select distinct a.work_id,a.work_name,a.sanction_amount,decode(substr (a.work_id,7,2),'01','0378','02','0378','03','0176','08','0900','04','0004','07','0378','11','0378') as schemetypeid,decode (aug_new_code,'1','PWS','2','Augmentation') as type,to_char(a.admin_date,'dd/mm/yyyy') as sancyear,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20','0022','21','0023','22','0024','23','0025')as dcode,a.programme_code as progCode,a.subprogramme_code,category_code,aug_new_code,AUG_WORKID  as augWork , a.ADMIN_NO from rws_work_admn_tbl a where a.ADMIN_DATE>=to_date('"
					+ fromdate
					+ "','dd-mm-yyyy') and  a.ADMIN_DATE<=to_date('"
					+ todate + "','dd-mm-yyyy')";

			rs2 = st2.executeQuery(qry);
			// System.out.println("tbl1"+qry);
			int i = 1, total = 0;
			while (rs2.next()) {
				String slipreason = "";
				int prstatus = 0, prestatus = 0;
				try {

					String augWorkId = rs2.getString("augWork");
					workid = rs2.getString("WORK_ID");
					workname = rs2.getString("WORK_NAME");
					dcode = rs2.getString("dcode");
					schemetypeid = rs2.getString("SCHEMETYPEID");
					type = rs2.getString("TYPE");
					String dates = rs2.getString("SANCYEAR");
					String progCode = rs2.getString("progCode");
					// System.out.println("dates"+dates);
					String finalSancYear = "";
					int da = Integer.parseInt(dates.substring(3, 5));
					int ye = Integer.parseInt(dates.substring(6, 10));
					if (da <= 03)
						finalSancYear = ye - 1 + "-" + ye;
					else
						finalSancYear = ye + "-" + (ye + 1);
					sancyear = finalSancYear;
					if (rs2.getInt("sanction_amount") > 100)
						estcost = "" + rs2.getLong("sanction_amount") * 100000;
					else
						estcost = "" + rs2.getDouble("sanction_amount")
								* 100000;
					BigDecimal bd = new BigDecimal(estcost);
					bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
					estcost = "" + bd.doubleValue();
					revestcost = "0";
					capacity = "0";
					service = "40";
					exp = "0";
					moreexp = "0";
					// int y1=Integer.parseInt(finyear.substring(0,4));
					// System.out.println("schemetypeid:::::::::::::::"+schemetypeid);
					int cmonth = Integer.parseInt(sysdate.substring(3, 5));
					if (cmonth > 03) {
						int y1 = Integer.parseInt(finyear.substring(0, 4));
						int y2 = Integer.parseInt(finyear.substring(0, 4)) + 1;
						// System.out.println("Project Shelf Year:::::::::::::::"+y1+"-"+y2);
						psy = y1 + "-" + y2;// finyear;
					} else {
						int y1 = Integer.parseInt(finyear.substring(0, 4)) - 1;
						int y2 = Integer.parseInt(finyear.substring(0, 4));
						// System.out.println("Project Shelf Year:::::::::::::::"+y1+"-"+y2);
						psy = y1 + "-" + y2;// finyear;
					}
					// Added on 21/08/2013 for mainSchemeId
					String mainscheme = rs2.getString("aug_new_code");
					if (mainscheme != null && !mainscheme.equals("")
							&& mainscheme.equals("1")) {
						main = "1";
					} else {
						if (augWorkId != null && !augWorkId.equals("null")) {
							main = augWorkId;
						} else {
							main = "1";
							type = "PWS";
						}
					}
					// Added on 19/08/2013
					// psy=finyear;
					atm = "No";
					// query =
					// "insert into RWS_Schemes_TEMP_TBL(SchemeId,work_id,MainSchemeId,SchemeName,StateId,DistrictId,SchemeTypeId,Type,SanctionYear,EstimatedCost,RevisedEstimatedCost,GOICost,StateCost,CommCont,PopulationCovered,Capacity,ServiceLevel,Expenditure,ExpMoreReason,ProjectShelfYear,programme_code,subprogramme_code,category_code,old_new,aug_new_code,admin_no)	values('"+workid+"','"+workid+"','"+main+"','"+workname+"','"+stateid+"','"+dcode+"','"+schemetypeid+"','"+type+"','"+sancyear+"','"+estcost+"','"+revestcost+"','"+goicost+"','"+statecost+"','"+commcont+"','"+popcov+"','"+capacity+"','"+service+"','"+exp+"','"+moreexp+"','"+psy+"','"+rs2.getString("programme_code")+"','"+rs2.getString("subprogramme_code")+"','"+rs2.getString("category_code")+"','1','"+rs2.getString("aug_new_code")+"','"+rs2.getString("admin_no")+"')";

					query = "insert into RWS_Schemes_TEMP_TBL(SchemeIdOfState,MainSchemeId_IMIS,SchemeName,StateId,DistrictId,SchemeTypeId,Type,SanctionYear,EstimatedCost,RevisedEstimatedCost,GOICost,StateCost,CommCont,PopulationCovered,Capacity,ServiceLevel,Expenditure,ExpMoreReason,programme_code)	values('"
							+ workid
							+ "','"
							+ main
							+ "','"
							+ workname
							+ "','"
							+ stateid
							+ "','"
							+ dcode
							+ "','"
							+ schemetypeid
							+ "','"
							+ type
							+ "','"
							+ sancyear
							+ "','"
							+ estcost
							+ "','"
							+ revestcost
							+ "','"
							+ goicost
							+ "','"
							+ statecost
							+ "','"
							+ commcont
							+ "','"
							+ popcov
							+ "','"
							+ capacity
							+ "','"
							+ service
							+ "','"
							+ exp
							+ "','" + moreexp + "','" + progCode + "')";
					// System.out.println("final querysreeeeeeeee:"+query);
					total += st1.executeUpdate(query);
					// System.out.println("first tbl count:"+total);
				}

				catch (Exception e) {

					System.out.println("Exception in conn1:" + e.getMessage());
				} finally {
					try {
						// if(st1!=null)st1.close();
					} catch (Exception e) {
					}
				}

			}
			// Debug.println("insert susscessfully............"+total);
			if (total > 0) {
				flag = true;
			}
			// }
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				st.close();
				st1.close();
				rs2.close();
				st2.close();
				st3.close();
				st4.close();
				// // con.close();

			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		return flag;
	}// end of createExcel

	//Deepak Modified
	public boolean createPrjShelfSecondTable(String fromdate, String todate, Connection con) {
		boolean flag = false;
		PreparedStatement st = null, st1 = null, st2 = null, st3 = null;
		ResultSet rs = null, rs1 = null;
		int total = 0;
		String query = "";
		String location = "", date_of_comm = "";
		int i = 0;
		try {
			String selquery = "Select tname from tab where tname like 'RWS_SCHEMESOURCES_TEMP_TBL'";
			st = con.prepareStatement(selquery);
			rs = st.executeQuery();
			if (!rs.next()) {
				String crquery = "create table RWS_SchemeSources_TEMP_TBL(SourcesIdOfState varchar2(24),SchemeIdOfState varchar2(14),SourceTypeId varchar2(14) ,SourceTypeCategoryId varchar2(4),StateID varchar2(14),DistrictId varchar2(14),HabitationId varchar2(20),Location varchar2(50),SchoolId varchar2(50),IsInSchool varchar2(50),DateOfCommissioning Date,Latitude number(4,10),Longitude number(4,10),Elevation number(4))";
				st1 = con.prepareStatement(crquery);
				st1.executeUpdate();
			} else {
				String delquery = "delete from RWS_SchemeSources_TEMP_TBL";
				st1 = con.prepareStatement(delquery);
				st1.executeUpdate();
				con.commit();
			}
			String qq = "select rws_source_iden_fin_tbl.WORK_ID,case when rws_source_iden_fin_tbl.source_type_code=1 and rws_source_iden_fin_tbl.subsource_type_code=1 then 10 "
					+ " when rws_source_iden_fin_tbl.source_type_code=1 and rws_source_iden_fin_tbl.subsource_type_code=2 then 27 "
					+ " when rws_source_iden_fin_tbl.source_type_code=1 and rws_source_iden_fin_tbl.subsource_type_code=3 then 13 "
					+ " when rws_source_iden_fin_tbl.source_type_code=1 and rws_source_iden_fin_tbl.subsource_type_code=4 then 09 "
					+ " when rws_source_iden_fin_tbl.source_type_code=2 and rws_source_iden_fin_tbl.subsource_type_code=1 then 18 "
					+ " when rws_source_iden_fin_tbl.source_type_code=2 and rws_source_iden_fin_tbl.subsource_type_code=2 then 15 "
					+ " when rws_source_iden_fin_tbl.source_type_code=2 and rws_source_iden_fin_tbl.subsource_type_code=3 then 15 "
					+ " when rws_source_iden_fin_tbl.source_type_code=2 and rws_source_iden_fin_tbl.subsource_type_code=4 then 19 "
					+ " when rws_source_iden_fin_tbl.source_type_code=2 and rws_source_iden_fin_tbl.subsource_type_code=5 then 18 end as sourcetypeid, "
					+ " IMISMASTERDATA1.Stateid,IMISMASTERDATA1.DistrictId,IMISMASTERDATA1.BlockId,IMISMASTERDATA1.PanchayatId,IMISMASTERDATA1.Villageid,IMISMASTERDATA1.HabitationId, "
					+ " rws_source_tbl.LOCATION,to_char(rws_work_completion_tbl.DATE_OF_COMM,'dd/mm/yyyy') , rws_source_iden_fin_tbl.source_code    from  "
					+ " (((RWS_Schemes_temp_tbl INNER JOIN rws_source_iden_fin_tbl ON RWS_Schemes_temp_tbl.SCHEMEIDOFSTATE = rws_source_iden_fin_tbl.WORK_ID) "
					+ " INNER JOIN IMISMASTERDATA1 ON rws_source_iden_fin_tbl.HAB_CODE = IMISMASTERDATA1.HabCode) "
					+ " LEFT JOIN rws_source_tbl ON rws_source_iden_fin_tbl.SOURCE_CODE = rws_source_tbl.SOURCE_CODE) "
					+ " LEFT JOIN rws_work_completion_tbl ON RWS_Schemes_temp_tbl.SCHEMEIDOFSTATE = rws_work_completion_tbl.WORK_ID";
			st2 = con.prepareStatement(qq);			
			rs1 = st2.executeQuery();
			while (rs1.next()) {
				i++;
				location = rs1.getString(9);
				if (location == null)
					location = "";
				date_of_comm = rs1.getString(10);
				if (date_of_comm == null)
					date_of_comm = "";
				if (!date_of_comm.equals("")) {
					query = "insert into RWS_SchemeSources_TEMP_TBL(SourcesIdOfState,SchemeIdOfState,SourceTypeId,SourceTypeCategoryId,StateID,DistrictId,HabitationId,Location,DateOfCommissioning)values('"+rs1.getString(11)+"','"+rs1.getString(1)+"','"+rs1.getString(2)+"','','"+rs1.getString(3)+"','"+rs1.getString(4)+"','"+rs1.getString(8)+"','"+location+"',to_date('"+date_of_comm+"','dd/mm/yyyy'))";
				} else if (date_of_comm.equals("")) {
					query = "insert into RWS_SchemeSources_TEMP_TBL(SourcesIdOfState,SchemeIdOfState,SourceTypeId,SourceTypeCategoryId,StateID,DistrictId,HabitationId,Location)values('"+rs1.getString(11)+"','"+rs1.getString(1)+"','"+rs1.getString(2)+"','','"+rs1.getString(3)+"','"+rs1.getString(4)+"','"+rs1.getString(8)+"','"+location+"')";
				}
				st3 = con.prepareStatement(query);
				total += st3.executeUpdate();
				if(st3 != null){
					st3.close();
				}
				if (total > 0) {
					flag = true;
				}
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsExcelSheet createPrjShelfSecondTable : " + e.getMessage());
		} finally {
			try {
				rs.close();
				st.close();
				if (rs1 != null) {
					rs1.close();
				}
				if (st1 != null) {
					st1.close();
				}
				if (st2 != null) {
					st2.close();
				}
				if (st3 != null) {

					st3.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in RwsExcelSheet createPrjShelfSecondTable : " + e.getMessage());
			}
		}
		return flag;
	}
	
	public boolean createPrjShelfThirdTable(String fromdate, String todate, Connection con) {
		boolean flag = false;
		PreparedStatement st = null, st1 = null, st2 = null, st3 = null, st4 = null;
		ResultSet rs = null, rs1 = null;
		int total = 0;
		String query = "";
		try {
			String selquery = "Select tname from tab where tname like 'RWS_SCHEMESPROGRAMMES_TEMP_TBL'";
			st = con.prepareStatement(selquery);
			rs = st.executeQuery();
			if (!rs.next()) {
				String crquery = "create table RWS_SchemesProgrammes_TEMP_TBL(SchemeId varchar2(14),ProgrammeId varchar2(5))";
				st1 = con.prepareStatement(crquery);
				st1.executeUpdate();
			} else {
				String delquery = "delete from RWS_SchemesProgrammes_TEMP_TBL";
				st1 = con.prepareStatement(delquery);
				st1.executeUpdate();
				con.commit();
			}
			String qq = "select SCHEMEIDOFSTATE,"
					+ "case  when(a.programme_code='00') then 00"
					+ " when (a.programme_code='26' or a.programme_code='35') then 12"
					+ " when (a.programme_code='18') then 14"
					+ " when (a.programme_code='09' or a.programme_code='10' or a.programme_code='12' or a.programme_code='13' or a.programme_code='16' or a.programme_code='20' or a.programme_code='21' or a.programme_code='38' or a.programme_code='39' or a.programme_code='41' or a.programme_code='42' or a.programme_code='43' or a.programme_code='44' or a.programme_code='45' or a.programme_code='46' or a.programme_code='54' or a.programme_code='56' or a.programme_code='64' or a.programme_code='66' or a.programme_code='67') then 15 "
					+ " when (a.programme_code='01' or a.programme_code='02' or a.programme_code='11' or a.programme_code='23' or a.programme_code='32' or a.programme_code='33' or a.programme_code='37' or a.programme_code='49' or a.programme_code='58' or a.programme_code='61' or a.programme_code='62' or a.programme_code='63' ) then 19"
					+ " when (a.programme_code='24') then 2 "
					+ " when (a.programme_code='01' or a.programme_code='50'  ) then 20 "
					+ " when (a.programme_code='51') then 21 "
					+ " when (a.programme_code='04' or a.programme_code='06'  ) then 22 "
					+ " when (a.programme_code='36' or a.programme_code='53' or a.programme_code='59' ) then 24 "
					+ " when (a.programme_code='57') then 25 "
					+ " when (a.programme_code='01' or a.programme_code='27' or a.programme_code='60') then 27 "
					+ " when (a.programme_code='03' or a.programme_code='05'  ) then 3 "
					+ " when (a.programme_code='65') then 31 "
					+ " when (a.programme_code='29') then 4 "
					+ " when (a.programme_code='15') then 7 "
					+ " when (a.programme_code='14' or a.programme_code='25' or a.programme_code='34') then 9 "
					+ " end as programme_code1 from rws_schemes_TEMP_TBL a";
			st2 = con.prepareStatement(qq);
			rs1 = st2.executeQuery();
			while (rs1.next()) {
				try {
					String data1 = rs1.getString(1);
					String data2 = rs1.getString(2);
					query = "insert into RWS_SchemesProgrammes_TEMP_TBL values(?, ?)";
					st3 = con.prepareStatement(query);
					st3.setString(1, data1);
					st3.setString(2, data2);
					total += st3.executeUpdate();
					if(st3 != null){
						st3.close();
					}
					if (total > 0) {
						flag = true;
					}
				} catch (Exception e) {
					System.out.println("The Exception is in RwsExcelSheet createPrjShelfThirdTable : " + e.getMessage());
				} 
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsExcelSheet createPrjShelfThirdTable : " + e.getMessage());
		} finally {
			try {
				rs.close();
				st.close();
				st1.close();
				rs1.close();
				st2.close();
				st3.close();
			} catch (Exception e) {
				System.out.println("The Exception is in RwsExcelSheet createPrjShelfThirdTable : " + e.getMessage());
			}
		}
		return flag;
	}

	public boolean createPrjShelfFourthTable(Connection con) {
		boolean flag = false;
		PreparedStatement st = null, st1 = null, st2 = null, st3 = null, st4 = null, st5 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		int total = 0;
		String query = "";
		try {			
			String selquery = "Select tname from tab where tname like 'RWS_SCHEMEHABS_TEMP_TBL'";
			st = con.prepareStatement(selquery);
			rs = st.executeQuery();
			if (!rs.next()) {
				String crquery = "create table RWS_SchemeHabs_TEMP_TBL(SCHEMEIDOFSTATE varchar2(14),HabitationId varchar2(16),SchoolId varchar(10))";
				st1 = con.prepareStatement(crquery);
				st1.executeUpdate();
			} else {
				String delquery = "delete from RWS_SchemeHabs_TEMP_TBL";
				st1 = con.prepareStatement(delquery);
				st1.executeUpdate();
				con.commit();
			}
			String qq = "select distinct a.SCHEMEIDOFSTATE,b.HabitationId from RWS_Schemes_TEMP_TBL a,IMISMASTERDATA1 b ,RWS_ADMN_HAB_LNK_TBL c where b.habcode=c.hab_code and c.work_id=a.SCHEMEIDOFSTATE";
			st2 = con.prepareStatement(qq);
			rs1 = st2.executeQuery();
			while (rs1.next()) {
				try {
					String data1 = rs1.getString(1);
					String data2 = rs1.getString(2);
					query = "insert into RWS_SchemeHabs_TEMP_TBL(SCHEMEIDOFSTATE ,HabitationId ) values( ?, ?)";
					st3 = con.prepareStatement(query);
					st3.setString(1, data1);
					st3.setString(2, data2);
					total += st3.executeUpdate();
					if(st3 != null){
						st3.close();
					}
				} catch (Exception e) {
					System.out.println("The Exception is in RwsExcelSheet createPrjShelfFourthTable : " + e.getMessage());
				} 
			}
			String qq1 = "select a.SCHEMEIDOFSTATE,b.HabitationId from RWS_Schemes_TEMP_TBL a,IMISMASTERDATA1 b ,RWS_WORK_SCHOOL_LNK_TBL c where b.habcode=c.hab_code and c.work_id=a.SCHEMEIDOFSTATE";
			st4 = con.prepareStatement(qq1);
			rs2 = st4.executeQuery();
			while (rs2.next()) {
				try {
					String data1 = rs2.getString(1);
					String data2 = rs2.getString(2);
					query = "insert into RWS_SchemeHabs_TEMP_TBL(SCHEMEIDOFSTATE , HabitationId) values( ?, ?)";
					st5 = con.prepareStatement(query);
					st5.setString(1, data1);
					st5.setString(2, data2);
					total += st5.executeUpdate();
					if(st5 != null){
						st5.close();
					}
				} catch (Exception e) {
					System.out.println("The Exception is in RwsExcelSheet createPrjShelfFourthTable : " + e.getMessage());
				} 
			}
			if (total > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsExcelSheet createPrjShelfFourthTable : " + e.getMessage());
		} finally {
			try {
				rs.close();
				st.close();
				st1.close();
				rs1.close();
				st2.close();
				st3.close();
				st4.close();
			} catch (Exception e) {
				System.out.println("The Exception is in RwsExcelSheet createPrjShelfFourthTable : " + e.getMessage());
			}
		}
		return flag;
	}

	public boolean createPrjShelfFifthTable(Connection con) {
		boolean flag = false;
		PreparedStatement st = null, st1 = null, st2 = null, st3 = null;
		ResultSet rs = null, rs1 = null;
		int total = 0;
		String query = "";
		try {
			String selquery = "Select tname from tab where tname like 'RWS_SCHIMPAGENCY_TEMP_TBL'";
			st = con.prepareStatement(selquery);
			rs = st.executeQuery();
			if (!rs.next()) {
				String crquery = "create table Rws_SchImpAgency_TEMP_TBL(SchemeId varchar2(14),AgencyId varchar2(5))";
				st1 = con.prepareStatement(crquery);
				st1.executeUpdate();
			} else {
				String delquery = "delete from Rws_SchImpAgency_TEMP_TBL";
				st1 = con.prepareStatement(delquery);
				st1.executeUpdate();
				con.commit();
			}
			String qq = "SELECT a.SCHEMEIDOFSTATE, '002' AS AgencyId FROM RWS_Schemes_TEMP_TBL a";
			st2 = con.prepareStatement(qq);
			rs1 = st2.executeQuery();
			while (rs1.next()) {
				try {
					String data1 = rs1.getString(1);
					String data2 = rs1.getString(2);
					query = "INSERT INTO Rws_SchImpAgency_TEMP_TBL values( ?, ?)";
					st3 = con.prepareStatement(query);
					st3.setString(1, data1);
					st3.setString(2, data2);
					total += st3.executeUpdate();
					if(st3 != null){
						st3.close();
					}
					if (total > 0) {
						flag = true;
					}
				} catch (Exception e) {
					System.out.println("The Exception is in RwsExcelSheet createPrjShelfFifthTable : " + e.getMessage());
				} 
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsExcelSheet createPrjShelfFifthTable : " + e.getMessage());
		} finally {
			try {
				rs.close();
				st.close();
				st1.close();
				rs1.close();
				st2.close();
				st3.close();
			} catch (Exception e) {
				System.out.println("The Exception is in RwsExcelSheet createPrjShelfFifthTable : " + e.getMessage());
			}
		}
		return flag;
	}

	public boolean createPrjShelfSixthTable(Connection con) {
		boolean flag = false;
		PreparedStatement st = null, st1 = null, st2 = null, st3 = null, st4 = null, st5 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		int total = 0;
		String query = "";
		try {
			String selquery = "Select tname from tab where tname like 'RWS_SCHAGENCYRESFOROM_TEMP_TBL'";
			st = con.prepareStatement(selquery);
			rs = st.executeQuery();
			if (!rs.next()) {
				String crquery = "create table Rws_SchAgencyResForOM_TEMP_TBL(SchemeId varchar2(14),AgencyResponsibleForOMID number(10))";
				st1 = con.prepareStatement(crquery);
				st1.executeUpdate();
			} else {
				String delquery = "delete from Rws_SchAgencyResForOM_TEMP_TBL";
				st1 = con.prepareStatement(delquery);
				st1.executeUpdate();
				con.commit();
			}
			String qq = "SELECT a.SCHEMEIDOFSTATE, 1 AS AgencyResponsibleForOMID  FROM RWS_Schemes_TEMP_TBL a";
			st2 = con.prepareStatement(qq);
			rs1 = st2.executeQuery();
			while (rs1.next()) {
				try {
					String data1 = rs1.getString(1);
					String data2 = rs1.getString(2);
					query = "INSERT INTO Rws_SchAgencyResForOM_TEMP_TBL values( ?, ?)";
					st3 = con.prepareStatement(query);
					st3.setString(1, data1);
					st3.setString(2, data2);
					total += st3.executeUpdate();
					if(st3 != null){
						st3.close();
					}
					if (total > 0) {
						flag = true;
					}
				} catch (Exception e) {
					System.out.println("The Exception is in RwsExcelSheet createPrjShelfSixthTable : " + e.getMessage());
				} 
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsExcelSheet createPrjShelfSixthTable : " + e.getMessage());
		} finally {
			try {
				rs.close();
				st.close();
				st1.close();
				rs1.close();
				st2.close();
				st3.close();
			} catch (Exception e) {
				System.out.println("The Exception is in RwsExcelSheet createPrjShelfSixthTable : " + e.getMessage());
			}
		}
		return flag;
	}
	
	public boolean createPrjShelfSeventhTable(Connection con) {
		return true;
	}

	public void createTB1(Connection con) {
		PreparedStatement st = null, st1 = null, st2 = null, st3 = null, st4 = null, st5 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		int total = 0, total1 = 0;
		String query = "";
		try {
			String selquery = "Select tname from tab where tname like 'RWS_AAAAA_TEMP_TBL'";
			st = con.prepareStatement(selquery);			
			rs = st.executeQuery();
			if (!rs.next()) {
				String crquery = "create table RWS_aaaaa_TEMP_TBL(work_id varchar2(14),HAB_CODE varchar2(20))";
				st1 = con.prepareStatement(crquery);			
				st1.executeUpdate();
			} else {
				String delquery = "delete from RWS_aaaaa_TEMP_TBL";
				st1 = con.prepareStatement(delquery);			
				st1.executeUpdate();
				con.commit();
			}
			String qq = "select distinct a.SCHEMEIDOFSTATE,b.hab_code from rws_schemes_TEMP_TBL a ,rws_admn_hab_lnk_tbl b where a.SCHEMEIDOFSTATE =b.work_id";
			st2 = con.prepareStatement(qq);			
			rs1 = st2.executeQuery();
			while (rs1.next()) {
				try {
					String data1 = rs1.getString(1);
					String data2 = rs1.getString(2);
					query = "insert into RWS_aaaaa_TEMP_TBL values( ?, ? )";
					st3 = con.prepareStatement(query);
					st3.setString(1, data1);
					st3.setString(2, data2);
					total += st3.executeUpdate();
					if(st3 != null){
						st3.close();
					}
				} catch (Exception e) {
					System.out.println("The Exception is in RwsExcelSheet createTB1 : " + e.getMessage());
				}
			}
			String qq1 = "select distinct a.SCHEMEIDOFSTATE ,b.hab_code from rws_schemes_TEMP_TBL a ,RWS_WORK_SCHOOL_LNK_TBL b where a.SCHEMEIDOFSTATE =b.work_id";
			st4 = con.prepareStatement(qq1);			
			rs2 = st4.executeQuery();
			while (rs2.next()) {

				try {
					String data11 = rs2.getString(1);
					String data21 = rs2.getString(2);

					query = "insert into RWS_aaaaa_TEMP_TBL values( ?, ?)";
					st5 = con.prepareStatement(query);			
					st5.setString(1, data11);
					st5.setString(2, data21);
					total1 += st5.executeUpdate();
					if(st5 != null){
						st5.close();
					}
				} catch (Exception e) {
					System.out.println("The Exception is in RwsExcelSheet createTB1 : " + e.getMessage());
				} 
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsExcelSheet createTB1 : " + e.getMessage());
		} finally {
			try {
				rs.close();
				st.close();
				st1.close();
				rs1.close();
				st2.close();
				st3.close();
				st4.close();
				rs2.close();
			} catch (Exception e) {
				System.out.println("The Exception is in RwsExcelSheet createTB1 : " + e.getMessage());
			}
		}
	}

	public void createTB2(Connection con) {
		PreparedStatement st = null, st1 = null, st2 = null, st3 = null, st4 = null, st5 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		int total = 0, total1 = 0;
		String query = "";
		try {
			String selquery = "Select tname from tab where tname like 'RWS_BBB_TEMP_TBL'";
			st = con.prepareStatement(selquery);
			rs = st.executeQuery();
			if (!rs.next()) {
				String crquery = "create table RWS_bbb_TEMP_TBL(work_id varchar2(14),hab_pop varchar2(25))";
				st1 = con.prepareStatement(selquery);
				st1.executeUpdate(crquery);
			} else {
				String delquery = "delete from RWS_bbb_TEMP_TBL";
				st1 = con.prepareStatement(delquery);
				st1.executeUpdate();
				con.commit();
			}
			String qq = "select distinct a.SCHEMEIDOFSTATE  from rws_schemes_TEMP_TBL a ,RWS_ADMN_HAB_LNK_TBL b where a.SCHEMEIDOFSTATE =b.work_id";
			st2 = con.prepareStatement(qq);
			rs1 = st2.executeQuery();
			while (rs1.next()) {
				try {
					String data1 = rs1.getString(1);
					query = "insert into RWS_bbb_TEMP_TBL(work_id) values( ? )";
					st3 = con.prepareStatement(query);
					st3.setString(1, data1);
					total += st3.executeUpdate();
					if(st3 != null){
						st3.close();
					}
				} catch (Exception e) {
					System.out.println("The Exception is in RwsExcelSheet createTB2 : " + e.getMessage());
				} 
			}
			String qq1 = "select distinct a.SCHEMEIDOFSTATE  from rws_schemes_TEMP_TBL a ,RWS_WORK_SCHOOL_LNK_TBL b where a.SCHEMEIDOFSTATE =b.work_id";
			st4 = con.prepareStatement(qq1);
			rs2 = st4.executeQuery();
			while (rs2.next()) {
				try {
					String data1 = rs2.getString(1);
					query = "insert into RWS_bbb_TEMP_TBL(work_id) values( ? )";
					st5 = con.prepareStatement(query);
					st5.setString(1, data1);
					total1 += st5.executeUpdate();
					if(st5 != null){
						st5.close();
					}
				} catch (Exception e) {
					System.out.println("The Exception is in RwsExcelSheet createTB2 : " + e.getMessage());
				} 
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsExcelSheet createTB2 : " + e.getMessage());
		} finally {
			try {
				rs.close();
				st.close();
				st1.close();
				rs1.close();
				st2.close();
				st3.close();
				st4.close();
				rs2.close();
			} catch (Exception e) {
				System.out.println("The Exception is in RwsExcelSheet createTB2 : " + e.getMessage());
			}
		}
	}

	public void createTB3(Connection con) {
		PreparedStatement st = null, st1 = null, st2 = null, st3 = null;
		ResultSet rs = null, rs1 = null;
		int total = 0;
		String query = "";
		try {
			String selquery = "Select tname from tab where tname like 'RWS_CCCC_TEMP_TBL'";
			st = con.prepareStatement(selquery);
			rs = st.executeQuery();
			if (!rs.next()) {
				String crquery = "create table RWS_cccc_TEMP_TBL(Expr1 varchar2(25),work_id varchar2(20))";
				st1 = con.prepareStatement(crquery);
				st1.executeUpdate();
			} else {
				String delquery = "delete from RWS_cccc_TEMP_TBL";
				st1 = con.prepareStatement(delquery);
				st1.executeUpdate();
				con.commit();
			}
			String qq = "select distinct sum(a.cal_pop) as expr1,c.work_id  from IMISMASTERDATA1 a,RWS_aaaaa_TEMP_TBL b ,RWS_bbb_TEMP_TBL c where a.habcode=b.hab_code and b.work_id=c.work_id  group by c.work_id";
			st2 = con.prepareStatement(qq);
			rs1 = st2.executeQuery();
			while (rs1.next()) {
				try {
					String data1 = rs1.getString(1);
					String data2 = rs1.getString(2);
					query = "insert into RWS_cccc_TEMP_TBL values( ?, ?)";
					st3 = con.prepareStatement(query);
					st3.setString(1, data1);
					st3.setString(2, data2);
					total += st3.executeUpdate();
					if(st3 != null){
						st3.close();
					}
				} catch (Exception e) {
					System.out.println("The Exception is in RwsExcelSheet createTB3 : " + e.getMessage());
				} 
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsExcelSheet createTB3 : " + e.getMessage());
		} finally {
			try {
				rs.close();
				st.close();
				st1.close();
				rs1.close();
				st2.close();
				st3.close();
			} catch (Exception e) {
				System.out.println("The Exception is in RwsExcelSheet createTB3 : " + e.getMessage());
			}
		}
	}

	public boolean updateTbls(Connection con) {
		PreparedStatement st1 = null, st2 = null, st3 = null, st4 = null, st5 = null, st6 = null;
		Statement st = null;
		ResultSet rs = null, rs1 = null;
		int total[] = null;
		boolean flag = false, flag1 = false;
		String query = "", query1 = "", query2 = "", query3 = "", query4 = "", query5 = "", query6 = "", query7 = "", query8 = "", upquery = "";
		try {
			st = con.createStatement();
			try {
				query = "select distinct b.work_id,expr1 from RWS_cccc_TEMP_TBL b where expr1 is not null";
				st1 = con.prepareStatement(query);
				rs = st1.executeQuery();
				while (rs.next()) {
					upquery = "update RWS_bbb_TEMP_TBL a set a.hab_pop= ? where a.work_id= ? ";
					st2 = con.prepareStatement(upquery);
					st2.setString(1, rs.getString(2));
					st2.setString(2, rs.getString(1));
					st2.executeUpdate();
					if(st2 != null){
						st2.close();
					}
				}
				query1 = "select distinct b.work_id, b.hab_pop from RWS_bbb_TEMP_TBL b where b.hab_pop is not null";
				st3 = con.prepareStatement(query1);
				rs1 =st3.executeQuery();
				while (rs1.next()) {
					upquery = "update rws_Schemes_TEMP_TBL a set a.PopulationCovered= ? where a.SCHEMEIDOFSTATE = ? ";
					st4 = con.prepareStatement(upquery);
					st4.setString(1, rs1.getString(2));
					st4.setString(2, rs1.getString(1));
					st4.executeUpdate();
					if(st4 != null){
						st4.close();
					}
				}
				query2 = "update rws_Schemes_TEMP_TBL a set a.DATEOFCOMMENCEMENT=(select distinct to_char(b.GROUNDING_DATE,'dd/mon/yyyy') from RWS_WORK_COMMENCEMENT_TBL b where a.SCHEMEIDOFSTATE =b.work_id)";
				st5 = con.prepareStatement(query2);
				st5.executeUpdate();
				con.commit();
				con.setAutoCommit(true);

				query3 = "update rws_Schemes_TEMP_TBL a set a.DateOfCompletion=(select distinct to_char(b.DATE_OF_COMPLETION,'dd/mon/yyyy') from RWS_WORK_COMPLETION_TBL b where a.SCHEMEIDOFSTATE =b.work_id)";
				st6 = con.prepareStatement(query3);
				st1.executeUpdate();
				con.commit();
				con.setAutoCommit(true);

				query4 = "update rws_Schemes_TEMP_TBL a set a.capacity=(a.populationcovered*40)/1000000";
				st.addBatch(query4);
				
				query5 = "update rws_Schemes_TEMP_TBL a set a.capacity=round(a.capacity,2)";
				st.addBatch(query5);
				
				query6 = "update RWS_Schemes_TEMP_TBL a set a.StateCost=a.EstimatedCost where a.programme_code in('00','03','04','05','06','08','09','10','12','13','14','15','16','17','21','25','26','28','29','31','34','35','38','39','40','41','42','43','44','45','46','47','54','55','56','57','20','64','65','66','67')";
				st.addBatch(query6);

				query7 = "UPDATE RWS_Schemes_TEMP_TBL a SET a.GOICost = a.EstimatedCost WHERE a.programme_code in('01','02','11','18','23','24','27','32','33','36','37','48','49','50','51','53','58','59','60','61','62','63')";
				st.addBatch(query7);
				
				query8 = "UPDATE RWS_Schemes_TEMP_TBL a SET a.Expenditure =a.EstimatedCost*0.9";
				st.addBatch(query8);
				
				total = st.executeBatch();
				for (int j = 0; j < total.length; j++) {
					if (total[j] != 0)
						flag = true;
				}
				if (flag) {
					flag1 = true;
					con.commit();
					con.setAutoCommit(true);
				} else {
					flag1 = false;
					con.rollback();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in RwsExcelSheet updateTbls : " + e.getMessage());
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsExcelSheet updateTbls : " + e.getMessage());
		} finally {
			try {
				rs.close();
				rs1.close();
				st.close();
				st1.close();
				st2.close();
				st3.close();
				st4.close();
				st5.close();
				st6.close();				
			} catch (Exception e) {
				System.out.println("The Exception is in RwsExcelSheet updateTbls : " + e.getMessage());
			}
		}
		return flag1;
	}

	/**
	 * @param wrkList
	 * @return
	 */
	public boolean createPrjShelfFirstTable(String[] wrkList, Connection con) {
		boolean flag = false;
		Statement st = null, st1 = null, st2 = null, st3 = null, st4 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		String query = "";
		String workid = "", main = "0", workname = "", stateid = "002", dcode = "", schemetypeid = "", type = "", sancyear = "", estcost = "0", revestcost = "0", goicost = "0", statecost = "0", commcont = "0", capacity = "0", service = "", exp = "0", moreexp = "0", dofcomm = "", dofcomp = "", psy = "", atm = "No";
		double popcov = 0;
		String year = RwsUtils.getCurrentYear();
		int nextyear = Integer.parseInt(year) + 1;
		String finyear = year + "-" + nextyear;
		String sysdate = RwsUtils.getCurrentDate("dd/MM/yy");
		try {
			st = con.createStatement();
			st1 = con.createStatement();
			st2 = con.createStatement();
			st3 = con.createStatement();
			st4 = con.createStatement();

			String selquery = "Select tname from tab where tname like 'RWS_SCHEMES_TEMP_TBL'";
			rs = st.executeQuery(selquery);
			if (!rs.next()) {

				// adding on 21082013
				// SLSCCMeetingDate,SLSCCMeetingDate,TotalExpectedGOIExp13,TotalExpectedSTATEExp13,AdminDate
				// String
				// crquery="create table RWS_Schemes_TEMP_TBL(SchemeId varchar2(14),work_id varchar2(14),MainSchemeId number(8),SchemeName varchar2(200),StateId varchar2(50),DistrictId varchar2(50),SchemeTypeId varchar2(50),Type varchar2(50),SanctionYear varchar2(50),EstimatedCost number(11,2),RevisedEstimatedCost number(11,2),GOICost number(11,2),StateCost number(11,2),CommCont number(11,2),PopulationCovered number(11,2),Capacity  varchar2(50),ServiceLevel number(11,2),Expenditure number(11,2),ExpMoreReason number(11,2),DateOfCommencement Date,DateOfCompletion Date,ProjectShelfYear varchar2(10),Atmarpan varchar2(3),ProbableExpenditure number(11,2),programme_code  varchar2(50),subprogramme_code  varchar2(50),category_code  varchar2(50),old_new  varchar2(50),aug_new_code  varchar2(50),APSCHOOLID varchar2(50),SLSCCMeetingDate varchar2(50),TotalExpectedGOIExp13 number(30),TotalExpectedSTATEExp13 number(30),AdminDate Date)";
				String crquery = "create table RWS_Schemes_TEMP_TBL(SchemeIdOfState varchar2(14),MainSchemeId_IMIS varchar2(30),SchemeName varchar2(200),StateId varchar2(50),DistrictId varchar2(50),SchemeTypeId varchar2(50),Type varchar2(50),SanctionYear varchar2(50),EstimatedCost number(11,2),RevisedEstimatedCost number(11,2),GOICost number(11,2),StateCost number(11,2),CommCont number(11,2),PopulationCovered number(11,2),Capacity  varchar2(50),ServiceLevel number(11,2),Expenditure number(11,2),ExpMoreReason number(11,2),DateOfCommencement Date,DateOfCompletion Date,PhysicalCompletionDate date,FinancialCompletionDate date ,IsFullyPRI varchar2(10),Category varchar2(10),IsWasteWaterMgmt number(1),WasteWaterMNREGAS number(11,2),WasteWaterTSC number(11,2),WasteWaterOTH number(11,2))";
				st1.executeUpdate(crquery);
				System.out.println("crquery" + crquery);
			} else {
				String delquery = "delete from RWS_Schemes_TEMP_TBL";
				st1.executeUpdate(delquery);
				con.commit();
				System.out.println("delquery" + delquery);
			}

			for (int k = 0; k < wrkList.length; k++) {

				System.out.println("Workid:" + wrkList[k]);

				String qry = "select distinct a.work_id,a.work_name,a.sanction_amount,decode(substr (a.work_id,7,2),'01','0378','02','0378','03','0176','08','0900','04','0004','07','0378','11','0378') as schemetypeid,decode (aug_new_code,'1','PWS','2','Augmentation') as type,to_char(a.admin_date,'dd/mm/yyyy') as sancyear,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20','0022','21','0023','22','0024','23','0025')as dcode"
						+ ",a.programme_code,a.subprogramme_code,category_code,aug_new_code,AUG_WORKID  as augWork,admin_no "
						+ " from rws_work_admn_tbl a where a.work_id ='"
						+ wrkList[k].trim() + "'";
				System.out.println("tbl1" + qry);
				rs2 = st2.executeQuery(qry);

				int i = 1, total = 0;
				while (rs2.next()) {
					String slipreason = "";
					int prstatus = 0, prestatus = 0;
					try {
						String augWorkId = rs2.getString("augWork");
						workid = rs2.getString("WORK_ID");
						workname = rs2.getString("WORK_NAME");
						dcode = rs2.getString("dcode");
						schemetypeid = rs2.getString("SCHEMETYPEID");
						type = rs2.getString("TYPE");
						String dates = rs2.getString("SANCYEAR");
						String finalSancYear = "";
						int da = Integer.parseInt(dates.substring(3, 5));
						int ye = Integer.parseInt(dates.substring(6, 10));
						if (da <= 03)
							finalSancYear = ye - 1 + "-" + ye;
						else
							finalSancYear = ye + "-" + (ye + 1);
						sancyear = finalSancYear;
						if (rs2.getInt("SANCTION_AMOUNT") > 100)
							estcost = "" + rs2.getLong("SANCTION_AMOUNT")
									* 100000;
						else
							estcost = "" + rs2.getDouble("SANCTION_AMOUNT")
									* 100000;
						BigDecimal bd = new BigDecimal(estcost);
						bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
						estcost = "" + bd.doubleValue();
						revestcost = "0";
						capacity = "0";
						service = "40";
						exp = "0";
						moreexp = "0";
						int cmonth = Integer.parseInt(sysdate.substring(3, 5));
						if (cmonth > 03) {
							int y1 = Integer.parseInt(finyear.substring(0, 4));
							int y2 = Integer.parseInt(finyear.substring(0, 4)) + 1;
							// System.out.println("Project Shelf Year:::::::::::::::"+y1+"-"+y2);
							psy = y1 + "-" + y2;// finyear;
						} else {
							int y1 = Integer.parseInt(finyear.substring(0, 4)) - 1;
							int y2 = Integer.parseInt(finyear.substring(0, 4));
							// System.out.println("Project Shelf Year:::::::::::::::"+y1+"-"+y2);
							psy = y1 + "-" + y2;// finyear;
						}
						// Added on 21/08/2013 for mainSchemeId
						String mainscheme = rs2.getString("aug_new_code");
						if (mainscheme != null && !mainscheme.equals("")
								&& mainscheme.equals("1")) {
							main = "1";
						} else {
							if (augWorkId != null && !augWorkId.equals("null")) {
								main = augWorkId;
							} else {
								main = "1";
								type = "PWS";
							}
						}
						atm = "No";
						query = "insert into RWS_Schemes_TEMP_TBL(SchemeIdOfState,MainSchemeId_IMIS,SchemeName,StateId,DistrictId,SchemeTypeId,Type,SanctionYear,EstimatedCost,RevisedEstimatedCost,GOICost,StateCost,CommCont,PopulationCovered,Capacity,ServiceLevel,Expenditure,ExpMoreReason)	values('"
								+ workid
								+ "','"
								+ main
								+ "','"
								+ workname
								+ "','"
								+ stateid
								+ "','"
								+ dcode
								+ "','"
								+ schemetypeid
								+ "','"
								+ type
								+ "','"
								+ sancyear
								+ "','"
								+ estcost
								+ "','"
								+ revestcost
								+ "','"
								+ goicost
								+ "','"
								+ statecost
								+ "','"
								+ commcont
								+ "','"
								+ popcov
								+ "','"
								+ capacity
								+ "','"
								+ service
								+ "','"
								+ exp + "','" + moreexp + "')";

						System.out.println("final querysreeeeeeeee:" + query);
						total += st1.executeUpdate(query);
						// System.out.println("first tbl count:"+total);
					}

					catch (Exception e) {

						System.out.println("Exception in conn1:"
								+ e.getMessage());
					} finally {
						try {
							// if(st1!=null)st1.close();
						} catch (Exception e) {
						}
					}

				}
				// Debug.println("insert susscessfully............"+total);
				if (total > 0) {
					flag = true;
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (rs != null) {
					st.close();
				}
				if (rs != null) {
					st1.close();
				}
				// rs2.close();
				if (rs != null) {
					st2.close();
				}
				if (rs != null) {
					st3.close();
				}
				if (rs != null) {
					st4.close();
				}
				// con.close();

			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		return flag;
	}

	public boolean createPrjShelfFirstTablewithTbl(String tblname, Connection con) {
		boolean flag = false;
		PreparedStatement st = null, st1 = null, st2 = null, st3 = null, st4 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		String query = "";
		String workid = "", main = "0", workname = "", stateid = "002", dcode = "", schemetypeid = "", type = "", sancyear = "", estcost = "0", revestcost = "0", goicost = "0", statecost = "0", commcont = "0", capacity = "0", service = "", exp = "0", moreexp = "0", dofcomm = "", dofcomp = "", psy = "", atm = "No";
		double popcov = 0;
		String year = RwsUtils.getCurrentYear();
		String sysdate = RwsUtils.getCurrentDate("dd/MM/yy");
		int nextyear = Integer.parseInt(year) + 1;
		String finyear = year + "-" + nextyear;
		try {
			String selquery = "Select tname from tab where tname like 'RWS_SCHEMES_TEMP_TBL'";
			st = con.prepareStatement(selquery);
			rs = st.executeQuery();
			if (!rs.next()) {
				String crquery = "create table RWS_Schemes_TEMP_TBL(SchemeIdOfState varchar2(14),MainSchemeId_IMIS varchar2(30),SchemeName varchar2(200),StateId varchar2(50),DistrictId varchar2(50),SchemeTypeId varchar2(50),Type varchar2(50),SanctionYear varchar2(50),EstimatedCost number(11,2),RevisedEstimatedCost number(11,2),GOICost number(11,2),StateCost number(11,2),CommCont number(11,2),PopulationCovered number(11,2),Capacity  varchar2(50),ServiceLevel number(11,2),Expenditure number(11,2),ExpMoreReason number(11,2),DateOfCommencement Date,DateOfCompletion Date,PhysicalCompletionDate date,FinancialCompletionDate date ,IsFullyPRI varchar2(10),Category varchar2(10),IsWasteWaterMgmt number(1),WasteWaterMNREGAS number(11,2),WasteWaterTSC number(11,2),WasteWaterOTH number(11,2))";
				st1 = con.prepareStatement(crquery);
				st1.executeUpdate();
			} else {
				String delquery = "delete from RWS_Schemes_TEMP_TBL";
				st1 = con.prepareStatement(delquery);
				st1.executeUpdate();
				con.commit();
			}
			String q1 = "select SCHEMEID_STATE from " + tblname + " ";
			st2 = con.prepareStatement(q1);
			rs1 = st2.executeQuery();
			while (rs1.next()) {
				String qry = "select distinct a.work_id,a.work_name,a.sanction_amount,decode(substr(a.work_id,7,2),'01','0378','02','0378','03','0176','08','0900','04','0004','07','0378','11','0378') as schemetypeid,decode (aug_new_code,'1','PWS','2','Augmentation') as type,to_char(a.admin_date,'dd/mm/yyyy') as sancyear,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20','0022','21','0023','22','0024','23','0025')as dcode,a.programme_code,a.subprogramme_code,category_code,aug_new_code,AUG_WORKID  as augWork,admin_no from rws_work_admn_tbl a where a.work_id = ? ";
				st3 = con.prepareStatement(qry);
				st3.setString(1, rs1.getString(1));
				rs2 = st3.executeQuery();
				int i = 1, total = 0;
				while (rs2.next()) {
					String slipreason = "";
					int prstatus = 0, prestatus = 0;
					try {
						String augWorkId = rs2.getString("augWork");
						workid = rs2.getString("WORK_ID");
						workname = rs2.getString("WORK_NAME");
						dcode = rs2.getString("dcode");
						schemetypeid = rs2.getString("SCHEMETYPEID");
						type = rs2.getString("TYPE");
						String dates = rs2.getString("SANCYEAR");
						String finalSancYear = "";
						int da = Integer.parseInt(dates.substring(3, 5));
						int ye = Integer.parseInt(dates.substring(6, 10));
						if (da <= 03)
							finalSancYear = ye - 1 + "-" + ye;
						else
							finalSancYear = ye + "-" + (ye + 1);
						sancyear = finalSancYear;
						if (rs2.getInt("SANCTION_AMOUNT") > 100)
							estcost = "" + rs2.getLong("SANCTION_AMOUNT") * 100000;
						else
							estcost = "" + rs2.getDouble("SANCTION_AMOUNT") * 100000;
						BigDecimal bd = new BigDecimal(estcost);
						bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
						estcost = "" + bd.doubleValue();
						revestcost = "0";
						capacity = "0";
						service = "40";
						exp = "0";
						moreexp = "0";
						int cmonth = Integer.parseInt(sysdate.substring(3, 5));
						if (cmonth > 03) {
							int y1 = Integer.parseInt(finyear.substring(0, 4));
							int y2 = Integer.parseInt(finyear.substring(0, 4)) + 1;
							psy = y1 + "-" + y2;
						} else {
							int y1 = Integer.parseInt(finyear.substring(0, 4)) - 1;
							int y2 = Integer.parseInt(finyear.substring(0, 4));
							psy = y1 + "-" + y2;
						}
						String mainscheme = rs2.getString("aug_new_code");
						if (mainscheme != null && !mainscheme.equals("") && mainscheme.equals("1")) {
							main = "1";
						} else {
							if (augWorkId != null && !augWorkId.equals("null")) {
								main = augWorkId;
							} else {
								main = "1";
								type = "PWS";
							}
						}
						atm = "No";
						query = "insert into RWS_Schemes_TEMP_TBL(SchemeIdOfState,MainSchemeId_IMIS,SchemeName,StateId,DistrictId,SchemeTypeId,Type,SanctionYear,EstimatedCost,RevisedEstimatedCost,GOICost,StateCost,CommCont,PopulationCovered,Capacity,ServiceLevel,Expenditure,ExpMoreReason) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
						st4 = con.prepareStatement(query);
						st4.setString(1, workid);
						st4.setString(2, main);	
						st4.setString(3, workname);	
						st4.setString(4, stateid);	
						st4.setString(5, dcode);	
						st4.setString(6, schemetypeid);	
						st4.setString(7, type);	
						st4.setString(8, sancyear);	
						st4.setString(9, estcost);	
						st4.setString(10, revestcost);	
						st4.setString(11, goicost);	
						st4.setString(12, statecost);	
						st4.setString(13, commcont);	
						st4.setDouble(14, popcov);	
						st4.setString(15, capacity);	
						st4.setString(16, service);	
						st4.setString(17, exp);	
						st4.setString(18, moreexp);	
						total += st4.executeUpdate();
						if(st4 != null){
							st4.close();
						}
					}
					catch (Exception e) {
						System.out.println("Exception in conn1:"+ e.getMessage());
					}					
				}
				if(st3 != null){
					st3.close();
				}
				if (total > 0) {
					flag = true;
				}
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsExcelSheet createPrjShelfFirstTablewithTbl : " + e.getMessage());
		} finally {
			try {
				rs.close();
				rs1.close();
				rs2.close();
				st.close();
				st1.close();				
				st2.close();
				st3.close();
				st4.close();
			} catch (Exception e) {
				System.out.println("The Exception is in RwsExcelSheet createPrjShelfFirstTablewithTbl : " + e.getMessage());
			}
		}
		return flag;
	}

	//Deepak Modified
	public boolean createDrPrjShelfFirstTable(String fromdate, String todate, Connection con) {
		boolean flag = false;
		PreparedStatement st = null, st1 = null, st2 = null, st3 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		String query = "";
		String sourcecode = "", workid = "", main = "0", workname = "", stateid = "002", dcode = "", schemetypeid = "", type = "", sancyear = "", estcost = "0", revestcost = "0", goicost = "0", statecost = "0", commcont = "0", capacity = "0", service = "", exp = "0", moreexp = "0", dofcomm = "", dofcomp = "", psy = "", atm = "No";
		double popcov = 0;
		String year = RwsUtils.getCurrentYear();
		int nextyear = Integer.parseInt(year) + 1;
		String finyear = year + "-" + nextyear;
		String sysdate = RwsUtils.getCurrentDate("dd/MM/yy");
		try {
			String selquery = "Select tname from tab where tname like 'RWS_DR_SCHEMES_TEMP_TBL'";
			st = con.prepareStatement(selquery);
			rs = st.executeQuery();
			if (!rs.next()) {
				String crquery = "create table RWS_DR_Schemes_TEMP_TBL(SchemeId varchar2(14),work_id varchar2(14),MainSchemeId varchar2(14),SchemeName varchar2(200),StateId varchar2(50),DistrictId varchar2(50),SchemeTypeId varchar2(50),Type varchar2(50),SanctionYear varchar2(50),EstimatedCost number(11,2),RevisedEstimatedCost number(11,2),GOICost number(11,2),StateCost number(11,2),CommCont varchar(50),PopulationCovered number(11,2),Capacity  varchar2(50),ServiceLevel number(11,2),Expenditure number(11,2),ExpMoreReason number(11,2),DateOfCommencement Date,DateOfCompletion Date,ProjectShelfYear varchar2(10),Atmarpan varchar2(3),ProbableExpenditure number(11,2),programme_code  varchar2(50),subprogramme_code  varchar2(50),category_code  varchar2(50),old_new  varchar2(50),aug_new_code  varchar2(50),APSCHOOLID varchar2(50),SourceCode varchar2(50))";
				st1 = con.prepareStatement(crquery);
				st1.executeUpdate();
			} else {
				String delquery = "delete from RWS_DR_Schemes_TEMP_TBL";
				st1 = con.prepareStatement(delquery);
				st1.executeUpdate();
				con.commit();
			}
			String qry = "select distinct a.work_id,a.work_name,a.ADMIN_AMOUNT,decode(substr (a.work_id,7,2),'01','0378','02','0378','03','0176','08','0900','04','0004','07','0378','11','0378') as schemetypeid,decode (aug_new_code,'1','PWS','2','PWS') as type,to_char(a.admin_date,'dd/mm/yyyy') as sancyear,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20','0022','21','0023','22','0024','23','0025')as dcode,a.programme_code,a.subprogramme_code,category_code,aug_new_code,SOURCE_CODE  from rws_drought_works_tbl a where a.UPDATE_DATE>=to_date( ? ,'dd-mm-yyyy') and  a.UPDATE_DATE<=to_date( ? ,'dd-mm-yyyy')";
			st2 = con.prepareStatement(qry);
			st2.setString(1, fromdate);
			st2.setString(2, todate);
			rs2 = st2.executeQuery();
			int i = 1, total = 0;
			while (rs2.next()) {
				String slipreason = "";
				int prstatus = 0, prestatus = 0;
				try {
					workid = rs2.getString("WORK_ID");
					workname = rs2.getString("WORK_NAME");
					dcode = rs2.getString("dcode");
					schemetypeid = rs2.getString("SCHEMETYPEID");
					type = "SUSTAINABILITY";
					String dates = rs2.getString("SANCYEAR");
					String finalSancYear = "";
					int da = Integer.parseInt(dates.substring(3, 5));
					int ye = Integer.parseInt(dates.substring(6, 10));
					if (da <= 03)
						finalSancYear = ye - 1 + "-" + ye;
					else
						finalSancYear = ye + "-" + (ye + 1);
					sancyear = finalSancYear;
					estcost = rs2.getString("ADMIN_AMOUNT");
					revestcost = "0";
					capacity = "0";
					service = "40";
					exp = "0";
					moreexp = "0";
					int cmonth = Integer.parseInt(sysdate.substring(3, 5));
					if (cmonth > 03) {
						int y1 = Integer.parseInt(finyear.substring(0, 4));
						int y2 = Integer.parseInt(finyear.substring(0, 4)) + 1;
						psy = y1 + "-" + y2;
					} else {
						int y1 = Integer.parseInt(finyear.substring(0, 4)) - 1;
						int y2 = Integer.parseInt(finyear.substring(0, 4));
						psy = y1 + "-" + y2;
					}
					atm = "No";
					sourcecode = rs2.getString("SOURCE_CODE");
					if (sourcecode != null && !sourcecode.equals("")) {
						query = "insert into RWS_DR_Schemes_TEMP_TBL(SchemeId,work_id,MainSchemeId,SchemeName,StateId,DistrictId,SchemeTypeId,Type,SanctionYear,EstimatedCost,RevisedEstimatedCost,GOICost,StateCost,CommCont,PopulationCovered,Capacity,ServiceLevel,Expenditure,ExpMoreReason,ProjectShelfYear,programme_code,subprogramme_code,category_code,old_new,aug_new_code,SOURCECODE) values('"+workid+"','"+workid+"','"+main+"','"+workname+"','"+stateid+"','"+dcode+"','"+schemetypeid+"','"+type+"','"+sancyear+"','"+estcost+"','"+revestcost+"','"+goicost+"','"+statecost+"','"+commcont+"','"+popcov+"','"+capacity+"','"+service+"','"+exp+"','"+moreexp+"','"+psy+"','"+rs2.getString("programme_code")+"','"+rs2.getString("subprogramme_code")+"','"+rs2.getString("category_code")+"','1','"+rs2.getString("aug_new_code")+"','"+sourcecode+"')";
					} else {
						query = "insert into RWS_DR_Schemes_TEMP_TBL(SchemeId,work_id,MainSchemeId,SchemeName,StateId,DistrictId,SchemeTypeId,Type,SanctionYear,EstimatedCost,RevisedEstimatedCost,GOICost,StateCost,CommCont,PopulationCovered,Capacity,ServiceLevel,Expenditure,ExpMoreReason,ProjectShelfYear,programme_code,subprogramme_code,category_code,old_new,aug_new_code) values('"+workid+"','"+workid+"','"+main+"','"+workname+"','"+stateid+"','"+dcode+"','"+schemetypeid+"','"+type+"','"+sancyear+"','"+estcost+"','"+revestcost+"','"+goicost+"','"+statecost+"','"+commcont+"','"+popcov+"','"+capacity+"','"+service+"','"+exp+"','"+moreexp+"','"+psy+"','"+rs2.getString("programme_code")+"','"+rs2.getString("subprogramme_code")+"','"+rs2.getString("category_code")+"','1','"+rs2.getString("aug_new_code")+"')";
					}					
					st3 = con.prepareStatement(query);
					total += st3.executeUpdate();
				}
				catch (Exception e) {
					System.out.println("The Exception is in RwsExcelSheet createDrPrjShelfFirstTable : " + e.getMessage());
				} 
			}
			if (total > 0) {flag = true;}			
		} catch (Exception e) {
			System.out.println("The Exception is in RwsExcelSheet createDrPrjShelfFirstTable : " + e.getMessage());
		} finally {
			try {
				rs.close();
				st.close();
				st1.close();
				rs2.close();
				st2.close();				
			} catch (Exception e) {
				System.out.println("The Exception is in RwsExcelSheet createDrPrjShelfFirstTable : " + e.getMessage());
			}
		}
		return flag;
	}
	
	public boolean createDrPrjShelfSecondTable(String fromdate, String todate, Connection con) {
		boolean flag = false;
		PreparedStatement st = null, st1 = null, st2 = null, st3 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		int total = 0;
		String query = "";
		String location = "", date_of_comm = "";
		int i = 0;
		try {
			String selquery = "Select tname from tab where tname like 'RWS_DR_SCHSOU_TEMP_TBL'";
			st = con.prepareStatement(selquery);
			rs = st.executeQuery();
			if (!rs.next()) {
				String crquery = "create table RWS_DR_SchSou_TEMP_TBL(SchemesSourcesId number(11),SchemeId varchar2(14),SourceTypeId varchar2(14) ,StateID varchar2(14),DistrictId varchar2(14),BlockId varchar2(14),PanchayatId varchar2(14),VillageId varchar2(14),HabitationId varchar2(20),Location varchar2(50),SchoolId varchar2(50),IsInSchool varchar2(50),DateOfCommissioning Date)";
				st1 = con.prepareStatement(crquery);
				st1.executeUpdate();
			} else {
				String delquery = "delete from RWS_DR_SchSou_TEMP_TBL";
				st1 = con.prepareStatement(delquery);
				st1.executeUpdate();
				con.commit();
			}
			String qq = "select a.WORK_ID, case "
					+ " when a.source_type_code=1 and a.subsource_type_code=1 then 10  "
					+ " when a.source_type_code=1 and a.subsource_type_code=2 then 27  "
					+ " when a.source_type_code=1 and a.subsource_type_code=3 then 13 "
					+ " when a.source_type_code=1 and a.subsource_type_code=4 then 09 "
					+ " when a.source_type_code=2 and a.subsource_type_code=1 then 18 "
					+ " when a.source_type_code=2 and a.subsource_type_code=2 then 15  "
					+ " when a.source_type_code=2 and a.subsource_type_code=3 then 15 "
					+ " when a.source_type_code=2 and a.subsource_type_code=4 then 19  "
					+ " when a.source_type_code=2 and a.subsource_type_code=5 then 18 end as type, "
					+ " b.Stateid,b.DistrictId,b.BlockId,b.PanchayatId,b.Villageid,b.HabitationId,a.SOURCE_LOCATION,to_char(a.DATE_OF_COMM,'dd/mm/yyyy')"
					+ " from rws_drought_works_tbl a, IMISMASTERDATA1 b, RWS_DR_SCHEMES_TEMP_TBL e where a.work_id=e.work_id and a.HABITATION_CODE=b.habcode ";
			st2 = con.prepareStatement(qq);			
			rs1 = st2.executeQuery();
			while (rs1.next()) {
				i++;
				location = rs1.getString(9);
				if (location == null)
					location = "";
				date_of_comm = rs1.getString(10);
				if (date_of_comm == null)
					date_of_comm = "";
				if (!date_of_comm.equals("")) {
					query = "insert into RWS_DR_SchSou_TEMP_TBL(SCHEMESSOURCESID,SchemeId,SourceTypeId,StateID,DistrictId,BlockId,PanchayatId,VillageId,HabitationId,Location,DateOfCommissioning)values('"
							+i+"','"+rs1.getString(1)+"','"+rs1.getString(2)+"','"+rs1.getString(3)+"','"+rs1.getString(4)+"','"+rs1.getString(5)+"','"+rs1.getString(6)+"','"+rs1.getString(7)+"','"+rs1.getString(8)+"','"+location+"',to_date('"+date_of_comm+"','dd/mm/yyyy'))";
				} else if (date_of_comm.equals("")) {
					query = "insert into RWS_DR_SchSou_TEMP_TBL(SCHEMESSOURCESID,SchemeId,SourceTypeId,StateID,DistrictId,BlockId,PanchayatId,VillageId,HabitationId,Location)values('"+i+"','"+rs1.getString(1)+"','"+rs1.getString(2)+"','"+rs1.getString(3)+"','"+rs1.getString(4)+"','"+rs1.getString(5)+"','"+rs1.getString(6)+"','"+rs1.getString(7)+"','"+rs1.getString(8)+"','"+location+"')";
				}
				st3 = con.prepareStatement(query);	
				total += st3.executeUpdate();
				if (total > 0) {
					flag = true;
				}
			}			
		} catch (Exception e) {
			System.out.println("The Exception is in RwsExcelSheet createDrPrjShelfSecondTable : " + e.getMessage());
		} finally {
			try {
				rs.close();
				st.close();
				rs1.close();
				st1.close();
				st2.close();
				st3.close();
			} catch (Exception e) {
				System.out.println("The Exception is in RwsExcelSheet createDrPrjShelfSecondTable : " + e.getMessage());
			}
		}
		return flag;
	}

	public boolean createDrPrjShelfThirdTable(String fromdate, String todate, Connection con) {
		boolean flag = false;
		PreparedStatement st = null, st1 = null, st2 = null, st3 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		int total = 0;
		String query = "";
		String location = "", date_of_comm = "";
		try {
			String selquery = "Select tname from tab where tname like 'RWS_DR_SCHPROG_TEMP_TBL'";
			st = con.prepareStatement(selquery);
			rs = st.executeQuery();
			if (!rs.next()) {
				String crquery = "create table RWS_DR_SchProg_TEMP_TBL(SchemeId varchar2(14),ProgrammeId varchar2(5))";
				st1 = con.prepareStatement(crquery);
				st1.executeUpdate();
			} else {
				String delquery = "delete from RWS_DR_SchProg_TEMP_TBL";
				st1 = con.prepareStatement(delquery);
				st1.executeUpdate();
				con.commit();
			}
			String qq = "select SchemeId, case  when(a.programme_code='00') then 00"
					+ " when (a.programme_code='26' or a.programme_code='35') then 12"
					+ " when (a.programme_code='18') then 14"
					+ " when (a.programme_code='09' or a.programme_code='10' or a.programme_code='12' or a.programme_code='13' or a.programme_code='16' or a.programme_code='20' or a.programme_code='21' or a.programme_code='38' or a.programme_code='39' or a.programme_code='41' or a.programme_code='42' or a.programme_code='43' or a.programme_code='44' or a.programme_code='45' or a.programme_code='46' or a.programme_code='54' or a.programme_code='56' or a.programme_code='64' or a.programme_code='66' or a.programme_code='67') then 15 "
					+ " when (a.programme_code='01' or a.programme_code='02' or a.programme_code='11' or a.programme_code='23' or a.programme_code='32' or a.programme_code='33' or a.programme_code='37' or a.programme_code='49' or a.programme_code='58' or a.programme_code='61' or a.programme_code='62' or a.programme_code='63' ) then 19"
					+ " when (a.programme_code='24') then 2 "
					+ " when (a.programme_code='01' or a.programme_code='50'  ) then 20 "
					+ " when (a.programme_code='51') then 21 "
					+ " when (a.programme_code='04' or a.programme_code='06'  ) then 22 "
					+ " when (a.programme_code='36' or a.programme_code='53' or a.programme_code='59' ) then 24 "
					+ " when (a.programme_code='57') then 25 "
					+ " when (a.programme_code='01' or a.programme_code='27' or a.programme_code='60') then 27 "
					+ " when (a.programme_code='03' or a.programme_code='05'  ) then 3 "
					+ " when (a.programme_code='65') then 13 "
					+ " when (a.programme_code='29') then 4 "
					+ " when (a.programme_code='15') then 7 "
					+ " when (a.programme_code='14' or a.programme_code='25' or a.programme_code='34') then 9 "
					+ " end as programme_code1 from rws_DR_schemes_TEMP_TBL a";
			st2 = con.prepareStatement(qq);
			rs1 = st2.executeQuery();
			while (rs1.next()) {
				try {
					String data1 = rs1.getString(1);
					String data2 = rs1.getString(2);
					query = "insert into RWS_DR_SchProg_TEMP_TBL values( ?, ?)";
					st3 = con.prepareStatement(query);
					st3.setString(1, data1);
					st3.setString(2, data2);
					total += st3.executeUpdate();
					if (total > 0) {
						flag = true;
					}
				} catch (Exception e) {
					System.out.println("The Exception is in RwsExcelSheet createDrPrjShelfThirdTable : " + e.getMessage());
				} 
			}			
		} catch (Exception e) {
			System.out.println("The Exception is in RwsExcelSheet createDrPrjShelfThirdTable : " + e.getMessage());
		} finally {
			try {
				rs.close();
				st.close();
				st1.close();
				rs1.close();
				st2.close();
				st3.close();				
			} catch (Exception e) {
				System.out.println("The Exception is in RwsExcelSheet createDrPrjShelfThirdTable : " + e.getMessage());
			}
		}
		return flag;
	}
	
	public boolean createDrPrjShelfFourthTable(Connection con) {
		boolean flag = false;
		PreparedStatement st = null, st1 = null, st2 = null, st3 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		int total = 0;
		String query = "";
		String location = "", date_of_comm = "";
		try {
			String selquery = "Select tname from tab where tname like 'RWS_DR_SCHEMEHABS_TEMP_TBL'";
			st = con.prepareStatement(selquery);
			rs = st.executeQuery();
			if (!rs.next()) {
				String crquery = "create table RWS_DR_SchemeHabs_TEMP_TBL(SchemeId varchar2(14),HabitationId varchar2(16),SCHOOLID varchar2(10) )";
				st1 = con.prepareStatement(crquery);
				st1.executeUpdate();
			} else {
				String delquery = "delete from RWS_DR_SchemeHabs_TEMP_TBL";
				st1 = con.prepareStatement(delquery);
				st1.executeUpdate();
				con.commit();
			}
			String qq = "select distinct a.SchemeId,b.HabitationId from RWS_DR_Schemes_temp_tbl a,IMISMASTERDATA1 b ,RWS_drought_works_TBL c where a.SchemeId=c.work_id and c.HABITATION_CODE=b.habcode";
			st2 = con.prepareStatement(qq);
			rs1 = st2.executeQuery();
			while (rs1.next()) {
				try {
					String data1 = rs1.getString(1);
					String data2 = rs1.getString(2);
					query = "insert into RWS_DR_SchemeHabs_TEMP_TBL(SchemeId,HabitationId) values( ? , ? )";
					st3 = con.prepareStatement(query);
					st3.setString(1, data1);
					st3.setString(2, data2);
					total += st3.executeUpdate();
				} catch (Exception e) {
					System.out.println("The Exception is in RwsExcelSheet createDrPrjShelfFourthTable : " + e.getMessage());
				} 
			}
			if (total > 0) {
				flag = true;
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsExcelSheet createDrPrjShelfFourthTable : " + e.getMessage());
		} finally {
			try {
				rs.close();
				st.close();
				st1.close();
				rs1.close();
				st2.close();
				st3.close();				
			} catch (Exception e) {
				System.out.println("The Exception is in RwsExcelSheet createDrPrjShelfFourthTable : " + e.getMessage());
			}
		}
		return flag;
	}

	public boolean createDrPrjShelfFifthTable(Connection con) {
		boolean flag = false;
		PreparedStatement st = null, st1 = null, st2 = null, st3 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		int total = 0;
		String query = "";
		String location = "", date_of_comm = "";
		try {
			String selquery = "Select tname from tab where tname like 'RWS_DR_SCHIMPAGENCY_TEMP_TBL'";
			st = con.prepareStatement(selquery);
			rs = st.executeQuery();
			if (!rs.next()) {
				String crquery = "create table Rws_DR_SchImpAgency_TEMP_TBL(SchemeId varchar2(14),AgencyId varchar2(5))";
				st1 = con.prepareStatement(crquery);
				st1.executeUpdate();
			} else {
				String delquery = "delete from Rws_DR_SchImpAgency_TEMP_TBL";
				st1 = con.prepareStatement(delquery);
				st1.executeUpdate();
				con.commit();
			}
			String qq = "SELECT a.SchemeId, '002' AS AgencyId FROM RWS_DR_Schemes_TEMP_TBL a";
			st2 = con.prepareStatement(qq);			
			rs1 = st2.executeQuery();
			while (rs1.next()) {
				try {
					String data1 = rs1.getString(1);
					String data2 = rs1.getString(2);
					query = "INSERT INTO Rws_DR_SchImpAgency_TEMP_TBL values( ?, ?)";
					st3 = con.prepareStatement(query);
					st3.setString(1, data1);
					st3.setString(2, data2);					
					total += st3.executeUpdate();
					if(st3 != null){
						st3.close();	
					}					
					if (total > 0) {
						flag = true;
					}
				} catch (Exception e) {
					System.out.println("The Exception is in RwsExcelSheet createDrPrjShelfFifthTable : " + e.getMessage());
				} 
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsExcelSheet createDrPrjShelfFifthTable : " + e.getMessage());
		} finally {
			try {
				rs.close();
				st.close();
				st1.close();
				rs1.close();
				st2.close();
				st3.close();				
			} catch (Exception e) {
				System.out.println("The Exception is in RwsExcelSheet createDrPrjShelfFifthTable : " + e.getMessage());
			}
		}
		return flag;
	}

	public boolean createDrPrjShelfSixthTable(Connection con) {
		boolean flag = false;
		PreparedStatement st = null, st1 = null, st2 = null, st3 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		int total = 0;
		String query = "";
		String location = "", date_of_comm = "";
		try {
			String selquery = "Select tname from tab where tname like 'RWS_DR_SCHAGRESFOROM_TEMP_TBL'";
			st = con.prepareStatement(selquery);
			rs = st.executeQuery();
			if (!rs.next()) {
				String crquery = "create table RWS_DR_SCHAGRESFOROM_TEMP_TBL(SchemeId varchar2(14),AgencyResponsibleForOMID number(10))";
				st1 = con.prepareStatement(crquery);
				st1.executeUpdate();
			} else {
				String delquery = "delete from RWS_DR_SCHAGRESFOROM_TEMP_TBL";
				st1 = con.prepareStatement(delquery);
				st1.executeUpdate();
				con.commit();
			}
			String qq = "SELECT a.SchemeId, 1 AS AgencyResponsibleForOMID  FROM RWS_DR_Schemes_TEMP_TBL a";
			st2 = con.prepareStatement(qq);			
			rs1 = st2.executeQuery();
			while (rs1.next()) {
				try {
					String data1 = rs1.getString(1);
					String data2 = rs1.getString(2);
					query = "INSERT INTO RWS_DR_SCHAGRESFOROM_TEMP_TBL values( ?, ?)";
					st3 = con.prepareStatement(query);
					st3.setString(1, data1);
					st3.setString(2, data2);	
					total += st3.executeUpdate();
					if(st3 != null){
						st3.close();
					}
					if (total > 0) {
						flag = true;
					}
				} catch (Exception e) {
					System.out.println("The Exception is in RwsExcelSheet createDrPrjShelfSixthTable : " + e.getMessage());
				} 
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsExcelSheet createDrPrjShelfSixthTable : " + e.getMessage());
		} finally {
			try {
				rs.close();
				st.close();
				st1.close();
				rs1.close();
				st2.close();
				st3.close();				
			} catch (Exception e) {
				System.out.println("The Exception is in RwsExcelSheet createDrPrjShelfSixthTable : " + e.getMessage());
			}
		}
		return flag;
	}

	public boolean createDrPrjShelfSeventhTable(Connection con) {
		boolean flag = false;
		PreparedStatement st = null, st1 = null, st2 = null, st3 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		int total = 0;
		String query = "";
		String location = "", date_of_comm = "";
		try {
			String selquery = "Select tname from tab where tname like 'RWS_DR_TARGETHABS_TEMP_TBL'";
			st = con.prepareStatement(selquery);
			rs = st.executeQuery();
			if (!rs.next()) {
				String crquery = "create table Rws_DR_TargetHabs_TEMP_TBL(SchemeId varchar2(14),HabitationId varchar2(20),SCHOOLID varchar2(10))";
				st1 = con.prepareStatement(crquery);
				st1.executeUpdate();
			} else {
				String delquery = "delete from Rws_DR_TargetHabs_TEMP_TBL";
				st1 = con.prepareStatement(delquery);
				st1.executeUpdate();
				con.commit();
			}
			String qq = "SELECT distinct a.SchemeId, a.HabitationId FROM RWS_DR_SchemeHabs_TEMP_TBL a";
			st2 = con.prepareStatement(qq);			
			rs1 = st2.executeQuery();
			while (rs1.next()) {
				try {
					String data1 = rs1.getString(1);
					String data2 = rs1.getString(2);
					query = "INSERT INTO Rws_DR_TargetHabs_TEMP_TBL(SchemeId ,HabitationId) values( ?, ?)";
					st3 = con.prepareStatement(query);
					st3.setString(1, data1);
					st3.setString(2, data2);	
					total += st3.executeUpdate();
					if(st3 != null){
						st3.close();
					}
					if (total > 0) {
						flag = true;
					}
				} catch (Exception e) {
					System.out.println("The Exception is in RwsExcelSheet createDrPrjShelfSeventhTable : " + e.getMessage());
				} 
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsExcelSheet createDrPrjShelfSeventhTable : " + e.getMessage());
		} finally {
			try {
				rs.close();
				st.close();
				st1.close();
				rs1.close();
				st2.close();
				st3.close();
			} catch (Exception e) {
				System.out.println("The Exception is in RwsExcelSheet createDrPrjShelfSeventhTable : " + e.getMessage());
			}
		}
		return flag;
	}

	//Deepak Modified
	public void createDrTB1(Connection con) {
		PreparedStatement st = null, st1 = null, st2 = null, st3 = null;
		ResultSet rs = null, rs1 = null;
		int total = 0, total1 = 0;
		String query = "";
		try {
			String selquery = "Select tname from tab where tname like 'RWS_AAAAA_TEMP_TBL'";
			st = con.prepareStatement(selquery);			
			rs = st.executeQuery();
			if (!rs.next()) {
				String crquery = "create table RWS_aaaaa_TEMP_TBL(work_id varchar2(14),HAB_CODE varchar2(20))";
				st1 = con.prepareStatement(crquery);	
				st1.executeUpdate();
			} else {
				String delquery = "delete from RWS_aaaaa_TEMP_TBL";
				st1 = con.prepareStatement(delquery);	
				st1.executeUpdate();
				con.commit();
			}
			
			String qq = "select a.work_id,b.habitation_code from rws_DR_schemes_temp_tbl a ,rws_drought_works_tbl b where a.work_id=b.work_id";
			st2 = con.prepareStatement(qq);	
			rs1 = st2.executeQuery();
			while (rs1.next()) {
				try {
					String data1 = rs1.getString(1);
					String data2 = rs1.getString(2);
					query = "insert into RWS_aaaaa_TEMP_TBL values( ? , ?)";
					st3 = con.prepareStatement(query);	
					st3.setString(1, data1);
					st3.setString(2, data2);
					total += st3.executeUpdate();
					if(st3 != null){
						st3.close();
					}
				} catch (Exception e) {
					System.out.println("The Exception is in Rws_ExcelSheet createDrTB1 : " + e.getMessage());
				} 
			}
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_ExcelSheet createDrTB1 : " + e.getMessage());
		} finally {
			try {
				rs.close();
				rs1.close();
				st.close();
				st1.close();
				st2.close();
				st3.close();
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_ExcelSheet createDrTB1 : " + e.getMessage());
			}
		}
	}

	public void createDrTB2(Connection con) {
		PreparedStatement st = null, st1 = null, st2 = null, st3 = null;
		ResultSet rs = null, rs1 = null;
		int total = 0, total1 = 0;
		String query = "";
		try {
			String selquery = "Select tname from tab where tname like 'RWS_BBB_TEMP_TBL'";
			st = con.prepareStatement(selquery);
			rs = st.executeQuery();
			if (!rs.next()) {
				String crquery = "create table RWS_bbb_TEMP_TBL(work_id varchar2(14),hab_pop varchar2(20))";
				st1 = con.prepareStatement(crquery);				
				st1.executeUpdate();				
			} else {
				String delquery = "delete from RWS_bbb_TEMP_TBL";
				st1 = con.prepareStatement(delquery);
				st1.executeUpdate();
				con.commit();
			}

			String qq = "select a.work_id from rws_DR_schemes_temp_tbl a ,RWS_drought_works_TBL b where a.work_id=b.work_id";
			st2 = con.prepareStatement(qq);
			rs1 = st2.executeQuery();
			while (rs1.next()) {
				try {
					String data1 = rs1.getString(1);
					query = "insert into RWS_bbb_TEMP_TBL(work_id) values(?)";
					st3 = con.prepareStatement(query);
					st3.setString(1, data1);
					total += st3.executeUpdate();
					if(st3 != null){
						st3.close();
					}
				} catch (Exception e) {
					System.out.println("The Exception is in Rws_ExcelSheet createDrTB2 : " + e.getMessage());
				} 
			}
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_ExcelSheet createDrTB2 : " + e.getMessage());
		}finally {
			try {
				rs.close();
				rs1.close();
				st.close();
				st1.close();
				st2.close();
				st3.close();
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_ExcelSheet createDrTB2 : " + e.getMessage());
			}
		}
	}

	public void createDrTB3(Connection con) {
		PreparedStatement st = null, st1 = null, st2 = null, st3 = null;
		ResultSet rs = null, rs1 = null;
		int total = 0;
		String query = "";
		try {
			String selquery = "Select tname from tab where tname like 'RWS_CCCC_TEMP_TBL'";
			st = con.prepareStatement(selquery);
			rs = st.executeQuery();
			if (!rs.next()) {
				String crquery = "create table RWS_cccc_TEMP_TBL(Expr1 varchar2(14),work_id varchar2(20))";
				st1 = con.prepareStatement(crquery);
				st1.executeUpdate();
			} else {
				String delquery = "delete from RWS_cccc_TEMP_TBL";
				st1 = con.prepareStatement(delquery);
				st1.executeUpdate();
				con.commit();
			}

			String qq = "select sum(a.cal_pop) as expr1,c.work_id from IMISMASTERDATA1 a,RWS_aaaaa_TEMP_TBL b ,RWS_bbb_TEMP_TBL c where a.habcode=b.hab_code and b.work_id=c.work_id group by c.work_id";
			st2 = con.prepareStatement(qq);
			rs1 = st2.executeQuery();
			while (rs1.next()) {
				try {
					String data1 = rs1.getString(1);
					String data2 = rs1.getString(2);
					query = "insert into RWS_cccc_TEMP_TBL values( ? , ?)";
					st3 = con.prepareStatement(query);
					st3.setString(1, data1);
					st3.setString(2, data2);
					total += st3.executeUpdate();
					if(st3 != null){
						st3.close();
					}
				} catch (Exception e) {
					System.out.println("The Exception is in Rws_ExcelSheet createDrTB3 : " + e.getMessage());
				} 
			}
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_ExcelSheet createDrTB3 : " + e.getMessage());
		}finally {
			try {
				rs.close();
				rs1.close();
				st.close();
				st1.close();
				st2.close();
				st3.close();
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_ExcelSheet createDrTB3 : " + e.getMessage());
			}
		}
	}

	public boolean updateDrTbls(Connection con) {
		PreparedStatement st = null, st1 = null, st2 = null, st3 = null, st4 = null, st5 = null, st6 = null, st7 = null;
		Statement st8 = null;
		ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null;
		int total[] = null;
		boolean flag = false, flag1 = false, flag2 = false;
		String upquery = "", query = "", query1 = "", query2 = "", query3 = "", query4 = "", query5 = "", query6 = "", query7 = "", query8 = "", query9 = "", query10 = "", query11 = "", query12 = "", query13 = "", query14 = "";
		try {
			st8 = con.createStatement();
			try {
				String qry1 = "select distinct work_id,expr1 from RWS_cccc_TEMP_TBL b  ";
				st = con.prepareStatement(qry1);				
				rs1 = st.executeQuery();
				while (rs1.next()) {
					upquery = "update RWS_bbb_TEMP_TBL a set hab_pop= ? where a.work_id= ?";
					st1 = con.prepareStatement(upquery);
					st1.setString(1, rs1.getString(2));
					st1.setString(2, rs1.getString(1));
					st1.executeUpdate();
					if(st1 != null){
						st1.close();
					}
				}
				String qry2 = "select distinct work_id,b.hab_pop from RWS_bbb_TEMP_TBL b ";
				st2 = con.prepareStatement(qry2);
				rs2 = st2.executeQuery();
				while (rs2.next()) {
					upquery = "update rws_DR_Schemes_TEMP_TBL a set PopulationCovered= ? where a.work_id= ? ";
					st3 = con.prepareStatement(upquery);
					st3.setString(1, rs2.getString(2));
					st3.setString(2, rs2.getString(1));
					st3.executeUpdate();
					if(st3 != null){
						st3.close();
					}
				}
				String qry3 = "select distinct work_id,to_char(b.GROUNDING_DATE,'dd/mon/yyyy') from RWS_drought_works_TBL b where b.GROUNDING_DATE is not null ";
				st4 = con.prepareStatement(qry3);				
				rs3 = st4.executeQuery();
				while (rs3.next()) {
					upquery = "update rws_DR_Schemes_TEMP_TBL a set a.DateOfCommencement= ? where a.work_id= ? ";
					st5 = con.prepareStatement(upquery);
					st5.setString(1, rs3.getString(2));
					st5.setString(2, rs3.getString(1));
					st5.executeUpdate();
					if(st5 != null){
						st5.close();
					}
				}

				String qry4 = "select distinct work_id,to_char(b.DATE_OF_COMPLETION,'dd/mon/yyyy') from RWS_drought_works_TBL b where b.DATE_OF_COMPLETION is not null ";
				st6 = con.prepareStatement(qry4);
				rs4 = st6.executeQuery();
				while (rs4.next()) {
					upquery = "update rws_DR_Schemes_TEMP_TBL a set a.DateOfCompletion= ? where a.work_id= ? ";
					st7 = con.prepareStatement(upquery);
					st7.setString(1, rs4.getString(2));
					st7.setString(2, rs4.getString(1));
					st7.executeUpdate();
					if(st7 != null){
						st7.close();
					}
				}
				query2 = "update rws_DR_Schemes_TEMP_TBL a set a.capacity=(a.populationcovered*40)/1000000";
				st8.addBatch(query2);
				
				query3 = "update rws_DR_Schemes_TEMP_TBL a set a.capacity=round(a.capacity,2)";
				st8.addBatch(query3);
				
				query6 = "update RWS_DR_Schemes_TEMP_TBL a set a.StateCost=a.EstimatedCost where a.programme_code in('00','03','04','05','06','08','09','10','12','13','14','15','16','17','21','25','26','28','29','31','34','35','38','39','40','41','42','43','44','45','46','47','54','55','56','57','20','64','65','66','67')";
				st8.addBatch(query6);

				query7 = "UPDATE RWS_DR_Schemes_TEMP_TBL a SET a.GOICost = a.EstimatedCost WHERE a.programme_code in('01','02','11','18','23','24','27','32','33','36','37','48','49','50','51','53','58','59','60','61','62','63')";
				st8.addBatch(query7);
				
				query8 = "UPDATE RWS_DR_Schemes_TEMP_TBL a SET a.Expenditure =a.EstimatedCost*0.9";
				st8.addBatch(query8);
				
				query9 = "UPDATE RWS_DR_Schemes_TEMP_TBL a SET a.ProbableExpenditure = a.Expenditure";
				st8.addBatch(query9);
				
				total = st8.executeBatch();
				for (int j = 0; j < total.length; j++) {
					if (total[j] != 0)
						flag = true;
				}
				if (flag) {
					flag1 = true;
					con.commit();
					con.setAutoCommit(true);
				} else {
					flag1 = false;
					con.rollback();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_ExcelSheet updateDrTbls : " + e.getMessage());
			} 
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_ExcelSheet updateDrTbls : " + e.getMessage());
		} finally {
			try {
				rs1.close();
				rs2.close();
				rs3.close();
				rs4.close();
				st.close();
				st1.close();
				st2.close();
				st4.close();
				st5.close();
				st6.close();
				st7.close();
				st8.close();
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_ExcelSheet updateDrTbls : " + e.getMessage());
			}
		}
		return flag1;
	}

	public boolean createFinalTests(String fromdate, String todate) {
		boolean flag = false;
		Statement st = null, st1 = null, st2 = null, st3 = null, st4 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		Debug.println("hai i am in creatExcel method............");
		Connection con = RwsOffices.getConn();
		try {
			st = con.createStatement();
			st1 = con.createStatement();
			st2 = con.createStatement();
			st3 = con.createStatement();
			st4 = con.createStatement();

			String selquery = "Select tname from tab where tname like 'WQ_FINAL_TESTS_TEMP_TBL'";
			rs = st.executeQuery(selquery);
			if (!rs.next()) {
				String crquery = "create table WQ_Final_Tests_Temp_tbl(source_code varchar2(24),FTK_TEST_ID varchar2(10),TEST_DATE Date)";
				st1.executeUpdate(crquery);
				//System.out.println("crquery" + crquery);
			} else {
				String delquery = "delete from WQ_Final_Tests_Temp_tbl";
				st1.executeUpdate(delquery);
				con.commit();
				//System.out.println("delquery" + delquery);
			}

			String qry = "select source_code,ftk_test_id,to_char(test_date,'mm/dd/yyyy') from rws_ftk_testing_tbl where test_date>=TO_DATE('"
					+ fromdate
					+ "','dd-mon-yyyy') and  test_date<=TO_DATE('"
					+ todate + "','dd-mon-yyyy') order by test_date";
			rs2 = st2.executeQuery(qry);
			//System.out.println("qry" + qry);
			int i = 1, total = 0;
			//System.out
					//.println("finaltests tbl is being preapared please wait...");
			while (rs2.next()) {

				String insertqry = "insert into WQ_Final_Tests_Temp_tbl(SOURCE_CODE,FTK_TEST_ID,TEST_DATE) values('"
						+ rs2.getString(1)
						+ "','"
						+ rs2.getString(2)
						+ "',to_date('" + rs2.getString(3) + "','mm/dd/yyyy'))";
				// System.out.println("insert qry.."+insertqry);
				total += st3.executeUpdate(insertqry);

			}
			Debug.println("insert susscessfully............" + total);

			if (total > 0) {
				flag = true;
			} else {
				flag = false;
				Debug.println("failed to update............");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				rs.close();
				st.close();
				st1.close();
				rs2.close();
				st2.close();
				st3.close();
				st4.close();
				// con.close();

			} catch (Exception e) {
				e.printStackTrace();
			}

		}
		return flag;
	}// end of createExcel

	public boolean createFirstFTKTable(String fromdate, String todate,
			Connection con) {
		Statement st = null, st1 = null, st2 = null, st3 = null, st4 = null, st5 = null, st6 = null, st7 = null, st8 = null, st9 = null;
		ResultSet rs = null, rs1 = null, rs2 = null, rs3 = null, rs4 = null, rs5 = null, rs8 = null;
		String sno = "";
		String testid = "";
		long rcount = 0, rcount1 = 0;
		int rowcount = 0;
		boolean flag1 = false;
		int yesContaminated = 0;
		int noContaminated = 0;
		long ddws_test_id = 0;// 284440;
		String ddws_id = "";
		String query = "";
		String finYear = "";
		String WORK_ID = "", parameterId = "";
		String source_code = "", ftestId = "";
		String location = "", date_of_comm = "";

		try {
			//System.out.println("first table creation started..........");
			st = con.createStatement();
			st1 = con.createStatement();
			st2 = con.createStatement();
			st3 = con.createStatement();
			st4 = con.createStatement();
			st5 = con.createStatement();
			st6 = con.createStatement();
			st7 = con.createStatement();
			st8 = con.createStatement();
			st9 = con.createStatement();
			String countquery = "Select testid from WQ_Last_Testid_Temp_Tbl where testtype='2'";
			rs5 = st5.executeQuery(countquery);
			while (rs5.next()) {
				ddws_test_id = rs5.getInt(1);
			}
			// rcount=404418;
			//System.out.println("my testid starat from" + ddws_test_id);

			String selquery = "Select tname from tab where tname like 'WQ_FTKTESTINGDETAILS_TEMP_TBL'";
			rs = st.executeQuery(selquery);
			if (!rs.next()) {
				String crquery = "create table WQ_FTKTestingDetails_Temp_Tbl(APOLD_TestId varchar2(10),TestId varchar2(10),DDWS_TEST_ID varchar2(50),ParameterId varchar2(3))";
				st1.executeUpdate(crquery);
				// //System.out.println("crquery"+crquery);
			} else {
				String delquery = "delete from WQ_FTKTestingDetails_Temp_Tbl";
				st1.executeUpdate(delquery);
				con.commit();
				// System.out.println("delquery"+delquery);
			}

			// ///////////////////////////////////////////////////////////////////////////
			String selquery1 = "Select tname from tab where tname like 'WQ_WATERQTLYTESTING_TEMP_TBL'";
			rs8 = st8.executeQuery(selquery1);
			if (!rs8.next()) {
				String crquery = "create table WQ_WaterQtlyTesting_Temp_Tbl(APOLD_TestId varchar2(10),TestId varchar2(50),DDWS_TEST_ID varchar2(50),TestingDate Date,ContaminatedYes_No  varchar2(50),HabitationId varchar(10),StateId varchar2(3),DistrictId varchar2(4),SchemeNo varchar2(50),GPId_testingDone varchar2(10),FinYear varchar2(50) )";
				st9.executeUpdate(crquery);
				//System.out.println("crquery" + crquery);
			} else {
				String delquery = "delete from WQ_WaterQtlyTesting_Temp_Tbl";
				st9.executeUpdate(delquery);
				con.commit();
				//System.out.println("delquery" + delquery);
			}

			// ///////////////////////////////////////////////////////////////////////////////////////

			String query1 = "select DISTINCT source_code,ftk_test_id,to_char(test_date,'mm/dd/yyyy') from rws_ftk_testing_tbl where test_date>=TO_DATE('"
					+ fromdate
					+ "','dd-mm-yyyy') and  test_date<=TO_DATE('"
					+ todate + "','dd-mm-yyyy')";

			// String
			// query1="select DISTINCT source_code,ftk_test_id,to_char(test_date,'mm/dd/yyyy') from rws_ftk_testing_tbl ";
			//System.out.println("qyery1:" + query1);
			rs1 = st2.executeQuery(query1);

			while (rs1.next()) {
				source_code = rs1.getString(1);
				// System.out.println("Yes" + source_code);
				ftestId = rs1.getString(2);

				String q1 = "select DISTINCT work_id,hab_code from RWS_SOURCE_IDEN_FIN_TBL where source_code='"
						+ source_code + "'";
				// System.out.println("q1" + q1);
				rs2 = st3.executeQuery(q1);
				String qq = "";
				if (rs2.next()) {
					WORK_ID = "work_id";
					// System.out.println("Yes11");
					qq = "select  DISTINCT A.*,B.HabitationId,B.Stateid, B.DistrictId,B.PanchayatId,c.work_id FROM RWS_FTK_TESTING_TBL A,IMISMASTERDATA1 B,RWS_SOURCE_IDEN_FIN_TBL C WHERE C.HAB_CODE=B.HabCODE and A.SOURCE_CODE=C.SOURCE_CODE and C.SOURCE_CODE='"
							+ source_code + "'";
				} else {

					// System.out.println("Yes22");
					// System.out.print("" + source_code.substring(19, 21));
					WORK_ID = "asset_code";
					if (source_code != null
							&& source_code.substring(19, 21).equals("HP")) {
						qq = "select  DISTINCT A.*,B.HabitationId,B.Stateid, B.DistrictId,B.PanchayatId,d.asset_code FROM RWS_FTK_TESTING_TBL A,IMISMASTERDATA1 B,rws_hp_subcomp_param_tbl  C,RWS_ASSET_MAST_TBL D WHERE C.ASSET_CODE=D.ASSET_CODE AND D.HAB_CODE=B.HabCODE and c.hp_code='"
								+ source_code
								+ "' and a.source_code=c.hp_code and a.ftk_test_id='"
								+ ftestId + "'";
					} else if (source_code != null
							&& source_code.substring(19, 21).equals("OW")) {
						qq = "select  DISTINCT A.*,B.HabitationId,B.Stateid, B.DistrictId,B.PanchayatId,d.asset_code FROM RWS_FTK_TESTING_TBL A,IMISMASTERDATA1 B,RWS_OPEN_WELL_MAST_TBL C,RWS_ASSET_MAST_TBL D WHERE C.ASSET_CODE=D.ASSET_CODE AND D.HAB_CODE=B.HabCODE and c.openwell_code='"
								+ source_code
								+ "' and a.source_code=c.openwell_code and a.ftk_test_id='"
								+ ftestId + "'";
					} else if (source_code != null
							&& source_code.substring(19, 21).equals("SH")) {
						qq = "select  DISTINCT A.*,B.HabitationId,B.Stateid, B.DistrictId,B.PanchayatId,d.asset_code FROM RWS_FTK_TESTING_TBL A,IMISMASTERDATA1 B,RWS_SHALLOWHANDPUMPS_TBL C,RWS_ASSET_MAST_TBL D WHERE C.ASSET_CODE=D.ASSET_CODE AND D.HAB_CODE=B.HabCODE and c.shallowhp_code='"
								+ source_code
								+ "' and a.source_code=c.shallowhp_code and a.ftk_test_id='"
								+ ftestId + "'";
					} else if (source_code != null
							&& source_code.substring(19, 21).equals("SO")) {
						qq = "select  DISTINCT A.*,B.HabitationId,B.Stateid, B.DistrictId,B.PanchayatId,d.asset_code FROM RWS_FTK_TESTING_TBL A,IMISMASTERDATA1 B,RWS_SOURCE_TBL C,RWS_ASSET_MAST_TBL D WHERE C.ASSET_CODE=D.ASSET_CODE AND D.HAB_CODE=B.HabCODE and c.source_code='"
								+ source_code
								+ "' and  a.source_code=c.source_code and a.ftk_test_id='"
								+ ftestId + "'";
					} else {
						continue;
					}
				}
				// System.out.println(qq);
				rs3 = st4.executeQuery(qq);
				String contaminated = "";
				boolean flag = false;
				while (rs3.next()) {
					String tdate1 = rs3.getString(2);
					if (!(Integer.parseInt(tdate1.substring(0, 4)) == 2013 && Integer
							.parseInt(tdate1.substring(5, 7)) >= 1)) {
						continue;
					}
					String FTK_ID = rs3.getString("FTK_TEST_ID");
					String Old_FTK_ID = rs3.getString("OLD_FTK_ID");
					ddws_test_id++;
					if (ddws_test_id < 10) {
						ddws_id = "000000000";

					} else if (ddws_test_id < 100) {
						ddws_id = "00000000";
					} else if (ddws_test_id < 1000) {
						ddws_id = "0000000";
					} else if (ddws_test_id < 10000) {
						ddws_id = "000000";
					} else if (ddws_test_id < 100000) {
						ddws_id = "00000";
					} else if (ddws_test_id < 1000000) {
						ddws_id = "0000";
					} else if (ddws_test_id < 10000000) {
						ddws_id = "000";
					} else if (ddws_test_id < 100000000) {
						ddws_id = "00";
					} else if (ddws_test_id < 1000000000) {
						ddws_id = "0";
					}
					ddws_id = ddws_id + "" + ddws_test_id;
					String value = "";
					String value3 = rs3.getString(3);
					String value4 = rs3.getString(4);
					String value5 = rs3.getString(5);
					String value6 = rs3.getString(6);
					String value7 = rs3.getString(7);
					String value8 = rs3.getString(8);
					String value9 = rs3.getString(9);
					String value10 = rs3.getString(10);
					String value11 = rs3.getString(11);
					String value12 = rs3.getString(12);
					String value13 = rs3.getString(13);
					String value14 = rs3.getString(14);
					String value15 = rs3.getString(15);
					String value16 = rs3.getString(16);
					String value17 = rs3.getString(17);
					if (value3 == null && value4 == null && value5 == null
							&& value6 == null && value7 == null
							&& value8 == null && value9 == null
							&& value10 == null && value11 == null
							&& value12 == null && value13 == null
							&& value14 == null && value15 == null
							&& value16 == null && value17 == null) {
						// System.out.print("Yes comming");
						contaminated = "0";
						noContaminated++;
					} else {

						// System.out.print("Second ");

						// insert into second table

						for (int i = 0; i < 15; i++) {

							if (value + "" + (i + 3) != null) {
								switch (i + 3) { // 
								case 3:
									parameterId = "002";
									break; // ARSENIC
								case 4:
									parameterId = "006";
									break; // NITRATE
								case 5:
									parameterId = "003";
									break; // FLOURIDE
								case 6:
									parameterId = "014";
									break; // SALINITY
								case 7:
									parameterId = "004";
									break; // IRON
								case 8:
									parameterId = "012";
									break; // COLIFORM
								case 9:
									parameterId = "001";
									break; // TURBODITY
								case 10:
									parameterId = "005";
									break; // CHLORIDE
								case 11:
									parameterId = "010";
									break; // MANGANEESE
								case 12:
									parameterId = "007";
									break; // SULPHATES
								case 13:
									parameterId = "011";
									break; // COPPER
								case 14:
									parameterId = "008";
									break; // CALSIUM
								case 15:
									parameterId = "015";
									break; // TDS
								case 16:
									parameterId = "009";
									break; // MAGNINESIUM
								case 17:
									parameterId = "016";
									break; // HARDNESS

								}

								if (!parameterId.equals("")) {

									query = "insert into WQ_FTKTestingDetails_Temp_Tbl(APOLD_TestId,TestId,DDWS_TEST_ID,ParameterId)values('"
											+ Old_FTK_ID
											+ "','"
											+ FTK_ID
											+ "','"
											+ ddws_id
											+ "','"
											+ parameterId + "')";
									// System.out.println(query);
									rcount = st6.executeUpdate(query);

								}

							}
						} // end loop

						contaminated = "1";
						yesContaminated++;
						// System.out.print("rcount..............." + rcount);
					}

					// /////////////////////////////////Second table
					// ///////////////////////////////////////////

					String tdate = "-";
					// String tdate1=rsqq.getString(2);

					// System.out.print("Date:" + tdate);
					if (tdate1 != null) {
						String year = tdate1.substring(0, 4);
						String month = tdate1.substring(5, 7);
						String day = tdate1.substring(8, 10);
						tdate = day + "/" + month + "/" + year;

						int mnth = Integer.parseInt(month);
						int yr = Integer.parseInt(year);
						int yr1 = 0;
						if (mnth > 3) {
							yr1 = yr + 1;
							finYear = yr + "-" + yr1;
						} else {
							yr1 = yr - 1;
							finYear = yr1 + "-" + yr;
						}
					}
					// System.out.println("Ddws_id:" + ddws_id);
					// System.out.println("Finyear:" + finYear);

					query = "insert into WQ_WaterQtlyTesting_Temp_Tbl(APOLD_TestId,TestId,DDWS_TEST_ID,TestingDate,ContaminatedYes_No,HabitationId,StateID,DistrictId,SchemeNo,GPId_testingDone,FinYear)values('"
							+ Old_FTK_ID
							+ "','"
							+ FTK_ID
							+ "','"
							+ ddws_id
							+ "','"
							+ tdate
							+ "','"
							+ contaminated
							+ "','"
							+ rs3.getString("HabitationId")
							+ "','"
							+ rs3.getString("StateID")
							+ "','"
							+ rs3.getString("DistrictId")
							+ "','"

							+ rs3.getString(WORK_ID)
							+ "','"
							+ rs3.getString("Panchayatid")
							+ "','"
							+ finYear
							+ "')";

					// System.out.print("Insert 2" + query);
					rcount1 += st7.executeUpdate(query);

				}// rs3end
				// System.out.println("rcount1:" + rcount1);
				flag = false;

			}// main loop end

			if (rcount1 > 0) {
				flag1 = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {

				rs.close();
				st.close();
				rs1.close();
				rs2.close();
				rs3.close();
				rs8.close();
				st1.close();
				st2.close();
				st3.close();
				st4.close();
				st5.close();
				st6.close();
				st7.close();
				st8.close();
				st9.close();
				// con.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return flag1;
	}

	public boolean droughtSchemesUpdate() {
		Connection con = RwsOffices.getConn();
		Statement st = null, st1 = null, st2 = null, st3 = null, st4 = null, st5 = null;
		ResultSet rs = null, rs1 = null, rs2 = null, rs3 = null;
		boolean flag = false;
		String Query = "", sourcetype = "", upquery = "", insquery = "";
		try {
			int rcount[] = null;
			int contaminated = 0, rowcount = 0;
			con.setAutoCommit(false);
			st = con.createStatement();
			st1 = con.createStatement();
			st2 = con.createStatement();
			st3 = con.createStatement();
			st4 = con.createStatement();
			st5 = con.createStatement();

			String selqry = "select sourcecode from rws_dr_schemes_temp_tbl where sourcecode is not null";
			rs1 = st2.executeQuery(selqry);
			while (rs1.next()) {
				sourcetype = rs1.getString(1);
				// System.out.println("sourcetype"+sourcetype.substring(19,21));

				if (sourcetype != null
						&& sourcetype.substring(19, 21).equals("HP")) {

					String qry1 = "select ASSET_CODE from RWS_HP_SUBCOMP_PARAM_TBL where HP_CODE='"
							+ sourcetype + "'";
					rs2 = st4.executeQuery(qry1);
					if (rs2.next()) {
						upquery = "update rws_dr_schemes_temp_tbl t set mainschemeid='"
								+ rs2.getString(1)
								+ "' where sourcecode='"
								+ sourcetype + "'";
						st3.executeUpdate(upquery);
						//System.out.println("HP update count");
					}

				}

				else if (sourcetype != null && sourcetype.substring(19, 21).equals("SO")) {
					String qry1 = "select ASSET_CODE from rws_source_tbl where source_code='"+sourcetype+"'";
					rs2 = st4.executeQuery(qry1);
					if (rs2.next()) {
						upquery = "update rws_dr_schemes_temp_tbl t set mainschemeid='"+rs2.getString(1)+"'where sourcecode='"+sourcetype+"'";
						st3.executeUpdate(upquery);
					}
				}
				else if (sourcetype != null && sourcetype.substring(19, 21).equals("OW")) {
					String qry1 = "select ASSET_CODE from RWS_OPEN_WELL_MAST_TBL where openwell_CODE='" + sourcetype + "' ";
					rs2 = st4.executeQuery(qry1);
					if (rs2.next()) {
						upquery = "update rws_dr_schemes_temp_tbl t set mainschemeid='" + rs2.getString(1) + "' where sourcecode='" + sourcetype + "'";
						st3.executeUpdate(upquery);
					}
				} else if (sourcetype != null && sourcetype.substring(19, 21).equals("SH")) {
					String qry1 = "select ASSET_CODE from RWS_SHALLOWHANDPUMPS_TBL where SHALLOWHP_CODE='" + sourcetype + "' ";
					rs2 = st4.executeQuery(qry1);
					if (rs2.next()) {
						upquery = "update rws_dr_schemes_temp_tbl t set mainschemeid='"+ rs2.getString(1) +"' where sourcecode='"+sourcetype+"'";
						st3.executeUpdate(upquery);
					}
				}
				flag = true;
			}
			if (flag) {
				con.commit();
				con.setAutoCommit(true);
			} else {
				flag = false;
				con.rollback();
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				st.close();
				st1.close();
				rs1.close();
				st2.close();
				st3.close();
				st4.close();
				st5.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return flag;
	}
	public boolean createPrjShelfEigthTable(Connection conn) {
		return true;
	}
}

