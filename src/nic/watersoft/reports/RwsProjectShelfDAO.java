package nic.watersoft.reports;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ActionMessages;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsUtils;

import com.healthmarketscience.jackcess.ColumnBuilder;
import com.healthmarketscience.jackcess.DataType;
import com.healthmarketscience.jackcess.Database;
import com.healthmarketscience.jackcess.DatabaseBuilder;
import com.healthmarketscience.jackcess.PropertyMap;
import com.healthmarketscience.jackcess.Table;
import com.healthmarketscience.jackcess.TableBuilder;
import com.healthmarketscience.jackcess.Database.FileFormat;

public class RwsProjectShelfDAO {

	private static final int COPY_TABLE_BATCH_SIZE = 200;

	private void isTableExists(String tableName, Connection conn, String tableQuery) throws SQLException {
		String qry7 = "SELECT TNAME FROM TAB WHERE TNAME LIKE ? ";
		PreparedStatement stmt = conn.prepareStatement(qry7);
		stmt.setString(1,tableName);
		ResultSet rs7 = stmt.executeQuery();
		if (!rs7.next()) {
			stmt = conn.prepareStatement(tableQuery);
			stmt.executeUpdate();
		}else	{
			String qry8 = "DELETE FROM "+tableName;
			stmt = conn.prepareStatement(qry8);
			stmt.executeUpdate();
		}
		if (stmt != null) {
			stmt.close();
		}
		if (rs7 != null) {
			rs7.close();
		}
	}

	public static boolean importResultSet(ResultSet source, Table table) throws SQLException, IOException {
		boolean flag = false;
		ResultSetMetaData md = source.getMetaData();
		List<Object[]> rows = new ArrayList<Object[]>(COPY_TABLE_BATCH_SIZE);
		int numColumns = md.getColumnCount();
		while (source.next()) {
			Object[] row = new Object[numColumns];
			for (int i = 0; i < row.length; i++) {
				if (md.getColumnType(i + 1) == java.sql.Types.DATE) {
					row[i] = parseDate(source.getDate(i + 1), source, i + 1);
				} else {
					row[i] = source.getObject(i + 1);
				}
			}
			rows.add(row);
			if (rows.size() == COPY_TABLE_BATCH_SIZE){
				table.addRows(rows);
				rows.clear();
			}
		}
		if (rows.size() > 0){
			table.addRows(rows);
			flag = true;
		}
		return flag;
	}

	private static Object parseDate(Date date, ResultSet source, int index) {
		if (date != null && !date.equals("null")) {
			java.util.Date dt = null;
			SimpleDateFormat dateFormatter = new SimpleDateFormat("MM/dd/yyyy");
			String currentDate = dateFormatter.format(date);
			int year = Integer.parseInt(currentDate.substring(6, 10));
			int month = Integer.parseInt(currentDate.substring(0, 2));
			int day = Integer.parseInt(currentDate.substring(3, 5));
			try {
				dt = dateFormatter.parse(currentDate);
			} catch (ParseException e) {
				System.out.println("The Exception is in RwsProjetShelfDAO parseDate : "+ e.getMessage());
			}
			return dt;
		} else {
			try {
				return source.getObject(index);
			} catch (SQLException e) {
				System.out.println("The Exception is in RwsProjetShelfDAO parseDate : "+ e.getMessage());
			}
		}
		return null;
	}

	public static Database createDatabase(String databaseName) throws IOException {
		return DatabaseBuilder.create(FileFormat.V2007, new File(databaseName));
	}

	private static TableBuilder createTable(String tableName) {
		return new TableBuilder(tableName);
	}

	public boolean createPrjShelfFirstTable(String[] wrkList, Connection con, ActionMessages messages, Rws_Projectshelf_ExcelSheet_Form myForm) {
		boolean flag = false;
		PreparedStatement st1 = null;
		Statement st2 = null;
		ResultSet rs = null, rs2 = null;
		String query = "";
		String workid = "", main = "0", workname = "", stateid = "002", dcode = "", schemetypeid = "", type = "", sancyear = "", estcost = "0", revestcost = "0", goicost = "0", statecost = "0", commcont = "0", capacity = "0", service = "", exp = "0", moreexp = "0", dofcomm = "", dofcomp = "", psy = "", atm = "No";
		double popcov = 0;
		String year = RwsUtils.getCurrentYear();
		int nextyear = Integer.parseInt(year) + 1;
		String finyear = year + "-" + nextyear;
		String sysdate = RwsUtils.getCurrentDate("dd/MM/yy");
		int recCount = 0;
		try {
			st2 = con.createStatement();
			isTableExists("RWS_SCHEMES_TEMP_TBL", con, "create table RWS_Schemes_TEMP_TBL(SchemeIdOfState varchar2(14),MainSchemeId_IMIS varchar2(30),SchemeName varchar2(200),StateId varchar2(50),DistrictId varchar2(50),SchemeTypeId varchar2(50),Type varchar2(50),SanctionYear varchar2(50),EstimatedCost number(30,2),RevisedEstimatedCost number(30,2),GOICost number(30,2),StateCost number(30,2),CommCont number(30,2),PopulationCovered number(30,2),Capacity  varchar2(50),ServiceLevel number(11,2),Expenditure number(30,2),ExpMoreReason number(30,2),DateOfCommencement Date,DateOfCompletion Date,PhysicalCompletionDate date,FinancialCompletionDate date ,HandedCommunityDate date,IsFullyPRI varchar2(10),Category varchar2(10),IsWasteWaterMgmt number(1),WasteWaterMNREGAS number(11,2),WasteWaterTSC number(11,2),WasteWaterOTH number(11,2),programme_code varchar2(3))");
			for (int k = 0; k < wrkList.length; k++) {
				String qry = "select  a.work_id,a.work_name,a.sanction_amount,decode(substr (a.work_id,7,2),'01','0378','02','0378','03','0176','08','0900','04','0004','07','0378','11','0378','10','0479','06','0922') as schemetypeid,decode (aug_new_code,'1','PWS','2','Augmentation') as type,to_char(a.admin_date,'dd/mm/yyyy') as sancyear,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20','0022','21','0023','22','0024','23','0025')as dcode"
						+ " , a.programme_code as progCode, a.subprogramme_code,category_code,aug_new_code,AUG_WORKID  as augWork,admin_no from rws_work_admn_tbl a where  a.work_id = ? ";
				st1 = con.prepareStatement(qry);
				st1.setString(1, wrkList[k]);
				rs2 = st1.executeQuery();
				while (rs2.next()) {
					String augWorkId = rs2.getString("augWork");
					workid = rs2.getString("WORK_ID");
					workname = rs2.getString("WORK_NAME");
					dcode = rs2.getString("dcode");
					schemetypeid = rs2.getString("SCHEMETYPEID");
					type = rs2.getString("TYPE");
					String dates = rs2.getString("SANCYEAR");
					String progCode = rs2.getString("progCode");					
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
						estcost = "" + rs2.getDouble("SANCTION_AMOUNT")	* 100000;
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
						schemetypeid="0393";
						if (augWorkId != null && !augWorkId.equals("null")) {
							main = augWorkId;
						} else {
							main = "1";
							type = "PWS";
						}
					}
					if(progCode.equals("76")){
						schemetypeid="1026";
						type="Treatment Plant";
					}
					if(progCode.equals("75")){
						schemetypeid="0431";						
					}
					atm = "No";
					recCount++;
					query = "insert into RWS_Schemes_TEMP_TBL(SchemeIdOfState,MainSchemeId_IMIS,SchemeName,StateId,DistrictId,SchemeTypeId,Type,SanctionYear,EstimatedCost,RevisedEstimatedCost,GOICost,StateCost,CommCont,PopulationCovered,Capacity,ServiceLevel,Expenditure,ExpMoreReason,programme_code,DATEOFCOMMENCEMENT,DATEOFCOMPLETION,PHYSICALCOMPLETIONDATE,FINANCIALCOMPLETIONDATE,HANDEDCOMMUNITYDATE,ISFULLYPRI) values('"+workid+"','"+main+"','"+workname+"','"+stateid+"','"+dcode+"','"+schemetypeid+"','"+type+"','"+sancyear+"','"+estcost+"','"+revestcost+"','"+goicost+"','"+statecost+"','"+commcont+"','"+popcov+"','"+capacity+"','"+service+"','"+exp+"','"+moreexp+"','"+progCode+ "','','','','','','0')";
					st2.addBatch(query);
				} 
			} 
			st2.executeBatch();
			myForm.setTotalSchemes(recCount);
			messages.add("Schemes Table", new ActionMessage("app.totalSchemes",	recCount));
		} catch (Exception e) {
			System.out.println("The Exception is in RwsProjetShelfDAO createPrjShelfFirstTable : "+ e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}				
				if (rs != null) {
					st1.close();
				}				
				if (rs != null) {
					st2.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in RwsProjetShelfDAO createPrjShelfFirstTable : "+ e.getMessage());
			}
		}
		return true;
	}

	public boolean createPrjShelfFirstTablewithTbl(String tblname, Connection con, ActionMessages messages,	Rws_Projectshelf_ExcelSheet_Form myForm) {
		boolean flag = false;
		Statement st1 = null;
		PreparedStatement st2 = null;
		ResultSet rs2 = null;
		String query = "";
		String workid = "", main = "0", workname = "", stateid = "002", dcode = "", schemetypeid = "", type = "", sancyear = "", estcost = "0", revestcost = "0", goicost = "0", statecost = "0", commcont = "0", capacity = "0", service = "", exp = "0", moreexp = "0", dofcomm = "", dofcomp = "", psy = "", atm = "No";
		double popcov = 0;
		String year = RwsUtils.getCurrentYear();
		String sysdate = RwsUtils.getCurrentDate("dd/MM/yy");
		int nextyear = Integer.parseInt(year) + 1;
		String finyear = year + "-" + nextyear;
		int recCount = 0;
		try {
			st1 = con.createStatement();
			isTableExists("RWS_SCHEMES_TEMP_TBL", con, "create table RWS_Schemes_TEMP_TBL(SchemeIdOfState varchar2(14),MainSchemeId_IMIS varchar2(30),SchemeName varchar2(200),StateId varchar2(50),DistrictId varchar2(50),SchemeTypeId varchar2(50),Type varchar2(50),SanctionYear varchar2(50),EstimatedCost number(30,2),RevisedEstimatedCost number(30,2),GOICost number(30,2),StateCost number(30,2),CommCont number(30,2),PopulationCovered number(30,2),Capacity  varchar2(50),ServiceLevel number(11,2),Expenditure number(30,2),ExpMoreReason number(30,2),DateOfCommencement Date,DateOfCompletion Date,PhysicalCompletionDate date,FinancialCompletionDate date ,HandedCommunityDate date,IsFullyPRI varchar2(10),Category varchar2(10),IsWasteWaterMgmt number(1),WasteWaterMNREGAS number(11,2),WasteWaterTSC number(11,2),WasteWaterOTH number(11,2),programme_code varchar2(3))");
			String qry = "select distinct a.work_id,a.work_name,a.sanction_amount,decode(substr (a.work_id,7,2),'01','0378','02','0378','03','0176','08','0900','04','0004','07','0378','11','0378','10','0479','06','0922') as schemetypeid,decode (aug_new_code,'1','PWS','2','Augmentation') as type,to_char(a.admin_date,'dd/mm/yyyy') as sancyear,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20','0022','21','0023','22','0024','23','0025')as dcode,a.programme_code as progCode,a.subprogramme_code,category_code,aug_new_code,AUG_WORKID  as augWork,admin_no from rws_work_admn_tbl a, "
						+tblname+ " b where  a.work_id =b.schemeid_state and b.IMIS_SchemeId is null";
			st2 = con.prepareStatement(qry);	
			rs2 = st2.executeQuery();
			while (rs2.next()) {
				String augWorkId = rs2.getString("augWork");
				workid = rs2.getString("WORK_ID");
				workname = rs2.getString("WORK_NAME");
				dcode = rs2.getString("dcode");
				schemetypeid = rs2.getString("SCHEMETYPEID");
				String progCode = rs2.getString("progCode");
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
					schemetypeid="0393";					
					if (augWorkId != null && !augWorkId.equals("null"))	{
						main = augWorkId;						
					} else 	{
						main = "1";
						type = "PWS";
					}
				}
				atm = "No";
				recCount++;
				query = "insert into RWS_Schemes_TEMP_TBL(SchemeIdOfState,MainSchemeId_IMIS,SchemeName,StateId,DistrictId,SchemeTypeId,Type,SanctionYear,EstimatedCost,RevisedEstimatedCost,GOICost,StateCost,CommCont,PopulationCovered,Capacity,ServiceLevel,Expenditure,ExpMoreReason,programme_code,DATEOFCOMMENCEMENT,DATEOFCOMPLETION,PHYSICALCOMPLETIONDATE,FINANCIALCOMPLETIONDATE,HANDEDCOMMUNITYDATE,ISFULLYPRI) values('"+workid+"','"+main+"','"+workname+"','"+stateid+"','"+dcode+"','"+schemetypeid+"','"+type+"','"+sancyear+"','"+estcost+"','"+revestcost+"','"+goicost+"','"+statecost+"','"+commcont+"','"+popcov+"','"+capacity+"','"+service+"','"+exp+"','"+moreexp+"','"+progCode+"','','','','','','0')";
				st1.addBatch(query);
			}
			int resCount[] = st1.executeBatch();
			if (resCount.length == recCount) {
				flag = true;
			}
			myForm.setTotalSchemes(recCount);
			messages.add("Schemes Table", new ActionMessage("app.totalSchemes",	recCount));
		} catch (Exception e) {
			System.out.println("The Exception is in RwsProjetShelfDAO createPrjShelfFirstTablewithTbl : "+ e.getMessage());
		}
		return flag;
	}

	public boolean createPrjShelfFirstTable(String fromdate, String todate,	Connection con, ActionMessages messages, Rws_Projectshelf_ExcelSheet_Form myForm) {
		boolean flag = false;
		PreparedStatement  st2 = null;
		Statement  st1 = null;
		ResultSet rs2 = null;
		String query = "";
		String workid = "", main = "0", workname = "", stateid = "002", dcode = "", schemetypeid = "", type = "", sancyear = "", estcost = "0", revestcost = "0", goicost = "0", statecost = "0", commcont = "0", capacity = "0", service = "", exp = "0", moreexp = "0", dofcomm = "", dofcomp = "", psy = "", atm = "No";
		double popcov = 0;
		String year = RwsUtils.getCurrentYear();
		int nextyear = Integer.parseInt(year) + 1;
		String finyear = year + "-" + nextyear;
		String sysdate = RwsUtils.getCurrentDate("dd/MM/yy");
		int recCount = 0;
		try {
			st1 = con.createStatement();
			isTableExists("RWS_SCHEMES_TEMP_TBL", con, "create table RWS_Schemes_TEMP_TBL(SchemeIdOfState varchar2(14),MainSchemeId_IMIS varchar2(30),SchemeName varchar2(200),StateId varchar2(50),DistrictId varchar2(50),SchemeTypeId varchar2(50),Type varchar2(50),SanctionYear varchar2(50),EstimatedCost number(30,2),RevisedEstimatedCost number(30,2),GOICost number(30,2),StateCost number(30,2),CommCont number(30,2),PopulationCovered number(30,2),Capacity  varchar2(50),ServiceLevel number(11,2),Expenditure number(30,2),ExpMoreReason number(30,2),DateOfCommencement Date,DateOfCompletion Date,PhysicalCompletionDate date,FinancialCompletionDate date ,HandedCommunityDate date,IsFullyPRI varchar2(10),Category varchar2(10),IsWasteWaterMgmt number(1),WasteWaterMNREGAS number(11,2),WasteWaterTSC number(11,2),WasteWaterOTH number(11,2),programme_code varchar2(3))");
			String qry = "select distinct a.work_id,a.work_name,a.sanction_amount,decode(substr (a.work_id,7,2),'01','0378','02','0378','03','0176','08','0900','04','0004','07','0378','11','0378','10','0479','06','0922') as schemetypeid,decode (aug_new_code,'1','PWS','2','Augmentation') as type,to_char(a.admin_date,'dd/mm/yyyy') as sancyear,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20','0022','21','0023','22','0024','23','0025')as dcode,a.programme_code as progCode,a.subprogramme_code,category_code,aug_new_code,AUG_WORKID  as augWork , a.ADMIN_NO from rws_work_admn_tbl a where a.ADMIN_DATE>=to_date( ? ,'dd-mm-yyyy') and  a.ADMIN_DATE<=to_date( ? ,'dd-mm-yyyy')";
			st2 = con.prepareStatement(qry);
			st2.setString(1, fromdate);
			st2.setString(2, todate);
			rs2 = st2.executeQuery();
			int total = 0;
			while (rs2.next()) {
				String augWorkId = rs2.getString("augWork");
				workid = rs2.getString("WORK_ID");
				workname = rs2.getString("WORK_NAME");
				dcode = rs2.getString("dcode");
				schemetypeid = rs2.getString("SCHEMETYPEID");
				type = rs2.getString("TYPE");
				String dates = rs2.getString("SANCYEAR");
				String progCode = rs2.getString("progCode");
				String finalSancYear = "";
				int da = Integer.parseInt(dates.substring(3, 5));
				int ye = Integer.parseInt(dates.substring(6, 10));
				if (da <= 03)
					finalSancYear = ye - 1 + "-" + ye;
				else
					finalSancYear = ye + "-" + (ye + 1);
				sancyear = finalSancYear;
				if (rs2.getInt("sanction_amount") > 100)
					estcost = ""+rs2.getLong("sanction_amount")*100000;
				else
					estcost = ""+rs2.getDouble("sanction_amount")*100000;
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
					schemetypeid="0393";
					if (augWorkId != null && !augWorkId.equals("null")) {
						main = augWorkId;
					} else {
						main = "1";
						type = "PWS";
					}
				}
				atm = "No";
				recCount++;
				query = "insert into RWS_Schemes_TEMP_TBL(SchemeIdOfState,MainSchemeId_IMIS,SchemeName,StateId,DistrictId,SchemeTypeId,Type,SanctionYear,EstimatedCost,RevisedEstimatedCost,GOICost,StateCost,CommCont,PopulationCovered,Capacity,ServiceLevel,Expenditure,ExpMoreReason,programme_code,DATEOFCOMMENCEMENT,DATEOFCOMPLETION,PHYSICALCOMPLETIONDATE,FINANCIALCOMPLETIONDATE,HANDEDCOMMUNITYDATE,ISFULLYPRI) values('"+workid+"','"+main+"','"+workname+"','"+stateid+"','"+dcode+"','"+schemetypeid+"','"+type+"','"+sancyear+"','"+estcost+"','"+revestcost+"','"+goicost+"','"+statecost+"','"+commcont+"','"+popcov+"','"+capacity+"','"+service+"','"+exp+"','"+moreexp+"','"+progCode+"','','','','','','0')";
				st1.addBatch(query);
			}
			st1.executeBatch();
			flag = true;
			myForm.setTotalSchemes(recCount);
			messages.add("Schemes Table", new ActionMessage("app.totalSchemes",	recCount));
		} catch (Exception e){
			System.out.println("The Exception is in RwsProjetShelfDAO createPrjShelfFirstTable : "+ e.getMessage());
		} finally {
			try {
				if (st1 != null) {
					st1.close();
				}
				if (st2 != null) {
					st2.close();
				}				
			} catch (Exception e) {
				System.out.println("The Exception is in RwsProjetShelfDAO createPrjShelfFirstTable : "+ e.getMessage());
			}
		}
		return flag;
	}
	
	public boolean createPrjShelfSecondTable(String fromdate, String todate, Connection con, ActionMessages messages, Rws_Projectshelf_ExcelSheet_Form myForm) {
		PreparedStatement st2=null;
		Statement st1=null;
		ResultSet rs = null, rs1 = null;
		String query = "";
		String location = "", date_of_comm = "";
		int recCount = 0;
		try {
			st1 = con.createStatement();
			isTableExists("RWS_SCHEMESOURCES_TEMP_TBL", con, "create table RWS_SchemeSources_TEMP_TBL(SourcesIdOfState varchar2(24),SchemeIdOfState varchar2(14),SourceTypeId varchar2(14) ,SourceTypeCategoryId varchar2(4),StateID varchar2(14),DistrictId varchar2(14),HabitationId varchar2(20),Location varchar2(50),SchoolId varchar2(50),IsInSchool number(1),DateOfCommissioning Date,Latitude float,Longitude float,Elevation number(10))");
			String qq = "select rws_source_iden_fin_tbl.WORK_ID,case when rws_source_iden_fin_tbl.source_type_code=1 and rws_source_iden_fin_tbl.subsource_type_code=1 then 10 "
					+ " when rws_source_iden_fin_tbl.source_type_code=1 and rws_source_iden_fin_tbl.subsource_type_code=2 then 27 "
					+ " when rws_source_iden_fin_tbl.source_type_code=1 and rws_source_iden_fin_tbl.subsource_type_code=3 then 13 "
					+ " when rws_source_iden_fin_tbl.source_type_code=1 and rws_source_iden_fin_tbl.subsource_type_code=4 then 09 "
					+ " when rws_source_iden_fin_tbl.source_type_code=2 and rws_source_iden_fin_tbl.subsource_type_code=1 then 18 "
					+ " when rws_source_iden_fin_tbl.source_type_code=2 and rws_source_iden_fin_tbl.subsource_type_code=2 then 15 "
					+ " when rws_source_iden_fin_tbl.source_type_code=2 and rws_source_iden_fin_tbl.subsource_type_code=3 then 15 "
					+ " when rws_source_iden_fin_tbl.source_type_code=2 and rws_source_iden_fin_tbl.subsource_type_code=4 then 19 "
					+ " when rws_source_iden_fin_tbl.source_type_code=2 and rws_source_iden_fin_tbl.subsource_type_code=5 then 18 end as sourcetypeid, "
					+ " IMISMASTERDATA1.Stateid,IMISMASTERDATA1.DistrictId,IMISMASTERDATA1.BlockId,IMISMASTERDATA1.PanchayatId,IMISMASTERDATA1.Villageid,IMISMASTERDATA1.HabitationId,"
					+ " rws_source_tbl.LOCATION,to_char(rws_work_completion_tbl.DATE_OF_COMM,'dd/mm/yyyy') , rws_source_iden_fin_tbl.source_code ,IMISMASTERDATA1.HABITATIONNAME as HabName,nvl(rws_source_tbl.LATITUDE,0) as lat,nvl(rws_source_tbl.LONGITUDE,0) as longitude,nvl(rws_source_tbl.ELEVATION,0) as elevation   from  "
					+ " (((RWS_Schemes_temp_tbl INNER JOIN rws_source_iden_fin_tbl ON RWS_Schemes_temp_tbl.SCHEMEIDOFSTATE = rws_source_iden_fin_tbl.WORK_ID) "
					+ " INNER JOIN IMISMASTERDATA1 ON rws_source_iden_fin_tbl.HAB_CODE = IMISMASTERDATA1.HabCode) "
					+ " LEFT JOIN rws_source_tbl ON rws_source_iden_fin_tbl.SOURCE_CODE = rws_source_tbl.SOURCE_CODE) "
					+ " LEFT JOIN rws_work_completion_tbl ON RWS_Schemes_temp_tbl.SCHEMEIDOFSTATE = rws_work_completion_tbl.WORK_ID";
			st2 = con.prepareStatement(qq);
			rs1 = st2.executeQuery();
			while (rs1.next()){
				location = rs1.getString(9);
				if (location == null)
					location = "";
				date_of_comm = rs1.getString(10);
				int IsInSchool = 0;
				int sourceTypeId = rs1.getInt("sourcetypeid");
				String habName = rs1.getString("HabName");
				if (location != null && location.equals("")){
					location = habName;
				}
				String latitude = rs1.getString("lat");
				String longitude = rs1.getString("longitude");
				String elevation = rs1.getString("elevation");
				String stateid="002";
				StringBuilder sType = new StringBuilder();
				if (sourceTypeId < 10) {
					sType.append("0");
					sType.append(sourceTypeId);
				} 
				else {
				  sType.append(sourceTypeId);
				}
				String sCatId = "";
				switch (sourceTypeId) {
				case 9:
				case 10:
				case 11:
				case 12:
				case 13:
					sCatId = "01";
					break;
				case 14:
				case 15:
				case 16:
				case 17:
				case 18:
				case 19:
				case 26:
				case 28:
					sCatId = "02";
					break;
				case 20:
				case 21:
				case 24:
				case 25:
					sCatId = "03";
					break;
				case 22:
					sCatId = "04";
					break;
				case 23:
				case 27:
					sCatId = "05";
					break;
				}
				if (date_of_comm == null || date_of_comm.equals("null") || date_of_comm.equals("")) {
					date_of_comm = "";
				}
				query = "insert into RWS_SchemeSources_TEMP_TBL(SourcesIdOfState,SchemeIdOfState,SourceTypeId,SourceTypeCategoryId,StateID,DistrictId,HabitationId,Location,DateOfCommissioning,LATITUDE,LONGITUDE,ELEVATION,IsInSchool) values('"+rs1.getString(11)+"','"+rs1.getString(1)+"','"+sType+"','"+sCatId+"','"+stateid+"','"+rs1.getString(4)+"','"+rs1.getString(8)+"','"+location+"',to_date('"+date_of_comm+"','dd/mm/yyyy'),'"+latitude+"','"+longitude+"','"+elevation+"',"+IsInSchool+")";
				recCount++;
				st1.addBatch(query);
			}
			st1.executeBatch();
			myForm.setSchemesNotHavingSources(myForm.getTotalSchemes()- recCount);
			messages.add("Schemes Table", new ActionMessage("app.totalSchemeSources", recCount));
			messages.add("Schemes Table", new ActionMessage("app.schemesNotHavingSources", myForm.getSchemesNotHavingSources()));
		} catch (Exception e) {
			System.out.println("The Exception is in RwsProjetShelfDAO createPrjShelfSecondTable : "+ e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}				
				if (rs1 != null) {
					rs1.close();
				}
				if (st1 != null) {
					st1.close();
				}
				if (st2 != null) {
					st2.close();
				}				
			} catch (Exception e) {
				System.out.println("The Exception is in RwsProjetShelfDAO createPrjShelfSecondTable : "+ e.getMessage());
			}
		}
		return true;
	}
	
	public boolean createPrjShelfThirdTable(String fromdate, String todate,	Connection con, ActionMessages messages, Rws_Projectshelf_ExcelSheet_Form myForm) {
		boolean flag = false;
		PreparedStatement st2 = null;
		Statement st1 = null;
		ResultSet rs = null, rs1 = null;
		String query = "";
		try {
			st1 = con.createStatement();
			isTableExists("RWS_SCHEMESPROGRAMMES_TEMP_TBL",	con, "create table RWS_SchemesProgrammes_TEMP_TBL(SchemeId varchar2(14),ProgrammeId varchar2(5))");
			String qq = "select SCHEMEIDOFSTATE,"
					+ "case  when(a.programme_code='00') then 00"
					+ " when (a.programme_code='26' or a.programme_code='35') then 12"
					+ " when (a.programme_code='18') then 14"
					+ " when (a.programme_code='09' or a.programme_code='10' or a.programme_code='12' or a.programme_code='13' or a.programme_code='16' or a.programme_code='20' or a.programme_code='21' or a.programme_code='38' or a.programme_code='39' or a.programme_code='41' or a.programme_code='42' or a.programme_code='43' or a.programme_code='44' or a.programme_code='45' or a.programme_code='46' or a.programme_code='54' or a.programme_code='56' or a.programme_code='64' or a.programme_code='66' or a.programme_code='67' or a.programme_code='68') then 15 "
					+ " when (a.programme_code='01' or a.programme_code='02' or a.programme_code='11' or a.programme_code='23' or a.programme_code='32' or a.programme_code='33' or a.programme_code='37' or a.programme_code='49' or a.programme_code='58' or a.programme_code='61' or a.programme_code='62' or a.programme_code='63' or a.programme_code='73' ) then 19"
					+ " when (a.programme_code='24') then 2 "
					+ " when (a.programme_code='01' or a.programme_code='50'  ) then 20 "
					+ " when (a.programme_code='51') then 21 "
					+ " when (a.programme_code='72') then 38 "
					+ " when (a.programme_code='04' or a.programme_code='06'  ) then 22 "
					+ " when (a.programme_code='36' or a.programme_code='53' or a.programme_code='59' ) then 24 "
					+ " when (a.programme_code='57') then 25 "
					+ " when (a.programme_code='01' or a.programme_code='27' or a.programme_code='60') then 27 "
					+ " when (a.programme_code='03' or a.programme_code='05'  ) then 3 "
					+ " when (a.programme_code='65' or a.programme_code='70' ) then 31 "
					+ " when (a.programme_code='29') then 4 "
					+ " when (a.programme_code='15') then 7 "
					+ " when (a.programme_code='75') then 45 "
					+ " when (a.programme_code='76') then 47 "
					+ " when (a.programme_code='14' or a.programme_code='25' or a.programme_code='34') then 9 "
					+ " end as programme_code1 from rws_schemes_TEMP_TBL a";
			st2 = con.prepareStatement(qq);			
			rs1 = st2.executeQuery();
			while (rs1.next()) {
				String data1 = rs1.getString(1);
				String data2 = rs1.getString(2);
				if (data2 == null || data2.equals("null")) {
					data2 = "00";
				}
				query = "insert into RWS_SchemesProgrammes_TEMP_TBL values('"+data1+"','"+data2+"')";
				st1.addBatch(query);
			}
			st1.executeBatch();
			flag = true;
		} catch (Exception e) {
			System.out.println("The Exception is in RwsProjetShelfDAO createPrjShelfThirdTable : "+ e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (st1 != null) {
					st1.close();
				}
				if (st2 != null) {
					st2.close();
				}				
			} catch (Exception e) {
				System.out.println("The Exception is in RwsProjetShelfDAO createPrjShelfThirdTable : "+ e.getMessage());
			}
		}
		return true;
	}
	
	public boolean createPrjShelfFourthTable(Connection con) {
		PreparedStatement st1 = null, st3 = null;
		Statement st2 = null, st4 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		String query = "";
		try {
			st2 = con.createStatement();
			st4 = con.createStatement();
			isTableExists("RWS_SCHEMEHABS_TEMP_TBL", con,	"create table RWS_SchemeHabs_TEMP_TBL(DeleveryPointId varchar2(10),SchemeIdOfState varchar2(14),StateId varchar2(14),DistrictId varchar2(14),HabitationId varchar2(20),Location varchar2(50),SchoolId varchar2(50),IsInSchool varchar2(50),DateOfCommissioning Date,Latitude number(4,10),Longitude number(4,10),Elevation number(4,10),Del_House varchar2(1))");
			String qq = "select  a.SCHEMEIDOFSTATE,b.HabitationId,b.STATEID,b.DISTRICTID  from RWS_Schemes_TEMP_TBL a,IMISMASTERDATA1 b ,RWS_ADMN_HAB_LNK_TBL c where b.habcode=c.hab_code and c.work_id=a.SCHEMEIDOFSTATE";
			st1 = con.prepareStatement(qq);
			rs1 = st1.executeQuery();
			while (rs1.next()) {
				String data1 = rs1.getString(1);
				String data2 = rs1.getString(2);
				String stateId =rs1.getString(3);
				String districtId = rs1.getString(4);
				if(data1.substring(0,2).equals("75") || data1.substring(0,2).equals("76")){
	            	query = "insert into RWS_SchemeHabs_TEMP_TBL values('','"+data1+"','"+stateId+"','"+districtId+"','"+data2+"','','','0','','','','','')";   
	            } else{
	            	query = "insert into RWS_SchemeHabs_TEMP_TBL values('','"+data1+"','"+stateId+"','"+districtId+"','"+data2+"','','','0','','','','','H')";
	            }
				st2.addBatch(query);
			}
			st2.executeBatch();
			String qq1 = "select a.SCHEMEIDOFSTATE,b.HabitationId,b.STATEID,b.DISTRICTID,d.SCHOOLID  from RWS_Schemes_TEMP_TBL a,IMISMASTERDATA1 b ,RWS_WORK_SCHOOL_LNK_TBL c ,imisschoolmaster d where  c.work_id=a.SCHEMEIDOFSTATE and  b.habcode=c.hab_code and d.HABITATIONID=b.HABITATIONID and substr(a.SCHEMEIDOFSTATE,7,2)='11'";
			st3 = con.prepareStatement(qq1);
			rs2 = st3.executeQuery();
			while (rs2.next()) {
				String data1 = rs2.getString(1);
				String data2 = rs2.getString(2);
				String stateId =rs2.getString(3);
				String districtId = rs2.getString(4);
				String schoolCode = rs2.getString(5);
				query = "insert into RWS_SchemeHabs_TEMP_TBL values('','"+data1+"','"+stateId+"','"+districtId+"','"+data2+"','','"+schoolCode+"','1','','','','','')";
				st4.addBatch(query);
			}
			st4.executeBatch();
		} catch (Exception e) {
			System.out.println("The Exception is in RwsProjetShelfDAO createPrjShelfFourthTable : "+ e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (rs2 != null) {
					rs2.close();
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
				if (st4 != null) {
					st4.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in RwsProjetShelfDAO createPrjShelfFourthTable : "+ e.getMessage());
			}
		}
		return true;
	}
	
	public boolean createPrjShelfFifthTable(Connection con) {
		boolean flag = false;
		PreparedStatement st1 = null;
		Statement st2 = null;
		ResultSet rs1 = null;
		String query = "";
		try {
			st2 = con.createStatement();
			isTableExists("RWS_SCHIMPAGENCY_TEMP_TBL", con, "create table Rws_SchImpAgency_TEMP_TBL(SchemeId varchar2(14),AgencyId varchar2(5))");
			String qq = "SELECT a.SCHEMEIDOFSTATE, '002' AS AgencyId FROM RWS_Schemes_TEMP_TBL a";
			st1 = con.prepareStatement(qq);
			rs1 = st1.executeQuery(qq);
			while (rs1.next()) {
				String data1 = rs1.getString(1);
				String data2 = rs1.getString(2);
				query = "INSERT INTO Rws_SchImpAgency_TEMP_TBL values('"+data1+"','"+data2+"')";
				st2.addBatch(query);
			}
			st2.executeBatch();
		} catch (Exception e) {
			System.out.println("The Exception is in RwsProjetShelfDAO createPrjShelfFifthTable : "+ e.getMessage());
		} finally {
			try {
				if (rs1 != null) {
					rs1.close();
				}
				if (st1 != null) {
					st1.close();
				}
				if (st2 != null) {
					st2.close();
				}				
			} catch (Exception e) {
				System.out.println("The Exception is in RwsProjetShelfDAO createPrjShelfFifthTable : "+ e.getMessage());
			}
		}
		return true;
	}

	public boolean createPrjShelfSixthTable(Connection con) {
		PreparedStatement st1 = null;
		Statement st2 = null;
		ResultSet rs1 = null;
		String query = "";
		try {
			st2 = con.createStatement();
			isTableExists("RWS_SCHAGENCYRESFOROM_TEMP_TBL",	con, "create table Rws_SchAgencyResForOM_TEMP_TBL(SchemeId varchar2(14),AgencyResponsibleForOMID number(10))");
			String qq = "SELECT a.SCHEMEIDOFSTATE, 1 AS AgencyResponsibleForOMID  FROM RWS_Schemes_TEMP_TBL a";
			st1 = con.prepareStatement(qq);
			rs1 = st1.executeQuery();
			while (rs1.next()) {
				String data1 = rs1.getString(1);
				String data2 = rs1.getString(2);
				query = "INSERT INTO Rws_SchAgencyResForOM_TEMP_TBL values('"+data1+"','"+data2+"')";
				st2.addBatch(query);
			}
			st2.executeBatch();
		} catch (Exception e) {
			System.out.println("The Exception is in RwsProjetShelfDAO createPrjShelfSixthTable : "+ e.getMessage());
		} finally {
			try {
				if (st1 != null) {
					st1.close();
				}
				if (st2 != null) {
					st2.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in RwsProjetShelfDAO createPrjShelfSixthTable : "+ e.getMessage());
			}
		}
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
					query = "insert into RWS_aaaaa_TEMP_TBL values( ? , ? )";
					st3 = con.prepareStatement(query);
					st3.setString(1, data1);
					st3.setString(2, data2);
					total += st3.executeUpdate();
				} catch (Exception e) {
					System.out.println("The Exception is in RwsProjetShelfDAO createTB1 : " + e.getMessage());
				} 
			}
			String qq1 = "select distinct a.SCHEMEIDOFSTATE ,b.hab_code from rws_schemes_TEMP_TBL a ,RWS_WORK_SCHOOL_LNK_TBL b where a.SCHEMEIDOFSTATE =b.work_id";
			st4 = con.prepareStatement(qq1);
			rs2 = st4.executeQuery();
			while (rs2.next()) {
				try {
					String data11 = rs2.getString(1);
					String data21 = rs2.getString(2);
					query = "insert into RWS_aaaaa_TEMP_TBL values( ? , ? )";
					st5 = con.prepareStatement(query);
					st5.setString(1, data11);
					st5.setString(2, data21);
					total1 += st5.executeUpdate();
				} catch (Exception e) {
					System.out.println("The Exception is in RwsProjetShelfDAO createTB1 : " + e.getMessage());
				} 
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsProjetShelfDAO createTB1 : " + e.getMessage());
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
				st5.close();
			} catch (Exception e) {
				System.out.println("The Exception is in RwsProjetShelfDAO createTB1 : "+ e.getMessage());
			}
		}
	}

	public void createTB2(Connection con) {
		PreparedStatement st = null, st1 = null, st2 = null, st3 = null, st4 = null, st5 = null;
		ResultSet rs = null, rs1 = null, rs11 = null;
		int total = 0, total1 = 0;
		String query = "";
		try {
			String selquery = "Select tname from tab where tname like 'RWS_BBB_TEMP_TBL'";
			st = con.prepareStatement(selquery);
			rs = st.executeQuery();
			if (!rs.next()) {
				String crquery = "create table RWS_bbb_TEMP_TBL(work_id varchar2(14),hab_pop varchar2(25))";
				st1 = con.prepareStatement(crquery);
				st1.executeUpdate();
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
					query = "insert into RWS_bbb_TEMP_TBL(work_id) values(?)";
					st3 = con.prepareStatement(query);
					st3.setString(1, data1);
					total += st3.executeUpdate();
				} catch (Exception e) {
					System.out.println("Exception in conn1:" + e.getMessage());
				} 
			}
			String qq1 = "select distinct a.SCHEMEIDOFSTATE  from rws_schemes_TEMP_TBL a ,RWS_WORK_SCHOOL_LNK_TBL b where a.SCHEMEIDOFSTATE =b.work_id";
			st4 = con.prepareStatement(qq1);
			rs11 = st4.executeQuery();
			while (rs11.next()) {
				try {
					String data1 = rs11.getString(1);
					query = "insert into RWS_bbb_TEMP_TBL(work_id) values(?)";
					st5 = con.prepareStatement(query);
					st5.setString(1,data1);
					total1 += st5.executeUpdate();
				} catch (Exception e) {
					System.out.println("Exception in conn1:" + e.getMessage());
				} 
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsProjetShelfDAO createTB2 : "+ e.getMessage());
		} finally {
			try {
				rs.close();
				st.close();
				st1.close();
				rs1.close();
				st2.close();
				st3.close();
				st4.close();
				rs11.close();
				st5.close();
			} catch (Exception e) {
				System.out.println("The Exception is in RwsProjetShelfDAO createTB2 : "+ e.getMessage());
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
					query = "insert into RWS_cccc_TEMP_TBL values(? , ?)";
					st3 = con.prepareStatement(query);
					st3.setString(1, data1);
					st3.setString(2, data2);
					total += st3.executeUpdate();
				} catch (Exception e) {
					System.out.println("Exception in conn1:" + e.getMessage());
				} 
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsProjetShelfDAO createTB3 : "+ e.getMessage());
		} finally {
			try {
				rs.close();
				st.close();
				st1.close();
				rs1.close();
				st2.close();
				st3.close();				
			} catch (Exception e) {
				System.out.println("The Exception is in RwsProjetShelfDAO createTB3 : "+ e.getMessage());
			}

		}
	}

	
	public boolean updateTbls(Connection con) throws SQLException {
		PreparedStatement st1 = null, st2 = null;
		Statement up_st = null;
		ResultSet rs1 = null, rs2 = null;
		int total[] = null;
		boolean flag = false, flag1 = false;
		String query2 = "", query4 = "", query5 = "", query6 = "", query7 = "", query8 = "", upquery = "";
		con.setAutoCommit(false);
		up_st = con.createStatement();
		String imisDataQuery = "select SCHEMEID_IMIS,a.MAINSCHEMEID_IMIS from rws_Schemes_TEMP_TBL a,rws_imis_schemes_tbl b where a.MAINSCHEMEID_IMIS =b.SCHEMEID_STATE and a.MAINSCHEMEID_IMIS<>'1' ";
		st1 = con.prepareStatement(imisDataQuery);
		rs1 = st1.executeQuery();
		while (rs1.next()) {
			upquery = "update rws_Schemes_TEMP_TBL a set a.MAINSCHEMEID_IMIS='"+rs1.getString(1)+"' where a.MAINSCHEMEID_IMIS='"+rs1.getString(2)+"' ";
			up_st.addBatch(upquery);
		}
		String habPopQuery = "select nvl(sum(CAL_POP),0),b.work_id from rws_Schemes_TEMP_TBL a,rws_admn_hab_lnk_tbl b,IMISMASTERDATA1 c where a.SCHEMEIDOFSTATE=b.work_id and b.hab_code=c.habcode group by b.work_id";
		st1 = con.prepareStatement(habPopQuery);
		rs1 = st1.executeQuery();
		while (rs1.next()) {
			upquery = "update rws_Schemes_TEMP_TBL a set a.POPULATIONCOVERED='"+rs1.getString(1)+"' where a.SCHEMEIDOFSTATE='"+rs1.getString(2)+"'";
			up_st.addBatch(upquery);
		}
		String schoolHabPopQuery = "select nvl(sum(CAL_POP),0),b.work_id from rws_Schemes_TEMP_TBL a,RWS_WORK_SCHOOL_LNK_TBL b,IMISMASTERDATA1 c where a.SCHEMEIDOFSTATE=b.work_id and b.hab_code=c.habcode group by b.work_id";
		st1 = con.prepareStatement(schoolHabPopQuery);
		rs1 = st1.executeQuery();
		while (rs1.next()) {
			upquery = "update rws_Schemes_TEMP_TBL a set a.POPULATIONCOVERED='"+rs1.getString(1)+"'where a.SCHEMEIDOFSTATE='"+rs1.getString(2)+"' ";
			up_st.addBatch(upquery);
		}
		query4 = "update rws_Schemes_TEMP_TBL a set a.DATEOFCOMMENCEMENT=(select distinct b.GROUNDING_DATE from RWS_WORK_COMMENCEMENT_TBL b where a.SCHEMEIDOFSTATE =b.work_id)";
		up_st.addBatch(query4);
		query5 = "update rws_Schemes_TEMP_TBL a set a.DateOfCompletion=(select distinct b.TARGET_DATE_COMP from RWS_WORK_ADMN_TBL b where a.SCHEMEIDOFSTATE =b.work_id)";
		up_st.addBatch(query5);
		query5 = "update rws_Schemes_TEMP_TBL a set a.PHYSICALCOMPLETIONDATE =(select distinct b.DATE_OF_COMPLETION from RWS_WORK_COMPLETION_TBL b where a.SCHEMEIDOFSTATE =b.work_id)";
		up_st.addBatch(query5);
		query5 = "update rws_Schemes_TEMP_TBL a set a.FINANCIALCOMPLETIONDATE=(select distinct b.DT_FIN_COMPLETION from RWS_WORK_COMPLETION_TBL b where a.SCHEMEIDOFSTATE =b.work_id)";
		up_st.addBatch(query5);
		query2 = "update rws_Schemes_TEMP_TBL a set a.capacity=round(((a.populationcovered*40)/1000000),2),a.Expenditure =0";
		up_st.addBatch(query2);
		query6 = "update RWS_Schemes_TEMP_TBL a set a.StateCost=a.EstimatedCost where a.programme_code in('00','03','04','05','06','08','09','10','12','13','14','15','16','17','21','25','26','28','29','31','34','35','38','39','40','41','42','43','44','45','46','47','54','55','56','57','20','64','65','66','67','68')";
		up_st.addBatch(query6);
		query7 = "UPDATE RWS_Schemes_TEMP_TBL a SET a.GOICost = a.EstimatedCost WHERE a.programme_code in('01','02','11','18','23','24','27','32','33','36','37','48','49','50','51','53','58','59','60','61','62','63','72','73','75','76')";
		up_st.addBatch(query7);
		query8 = "UPDATE RWS_Schemes_TEMP_TBL a SET a.ISFULLYPRI ='1' where a.DATEOFCOMMENCEMENT is not null";
		up_st.addBatch(query8);
		String schoolIDQuery = "select b.SCHOOLID, a.HABITATIONID from RWS_SchemeSources_TEMP_TBL a,imisschoolmaster b where a.HABITATIONID=b.HABITATIONID and substr(SCHEMEIDOFSTATE,7,2)='11'";
		st1 = con.prepareStatement(schoolIDQuery);
		rs1 = st1.executeQuery();
		while (rs1.next()){
			upquery = "update RWS_SchemeSources_TEMP_TBL a set a.ISINSCHOOL='1',a.SCHOOLID='"+rs1.getString(1)+"' where a.HABITATIONID='"+rs1.getString(2)+"' ";
			up_st.addBatch(upquery);
		}				
		String schoolIDQuery_habs = "select b.SCHOOLID,b.SCH_NAME, a.HABITATIONID  from RWS_SchemeHabs_TEMP_TBL a,imisschoolmaster b where a.HABITATIONID=b.HABITATIONID and substr(SCHEMEIDOFSTATE,7,2)='11'";
		st2 = con.prepareStatement(schoolIDQuery_habs);
		rs2 = st2.executeQuery();
		while (rs2.next()){
			upquery = "update RWS_SchemeHabs_TEMP_TBL a set a.ISINSCHOOL='1',a.SCHOOLID='"+rs2.getString(1)+"',a.location='"+rs2.getString(2)+"'  where a.HABITATIONID='"+rs2.getString(3)+"'";
			up_st.addBatch(upquery);
		}
		total = up_st.executeBatch();
		for (int j = 0; j < total.length; j++) {
			if (total[j] != 0) {
				flag = true;
			}
		}
		if (flag) {
			flag1 = true;
			con.commit();
			con.setAutoCommit(true);
		} else {
			flag1 = false;
			con.rollback();
		}
		try {
			if (up_st != null) {
				up_st.close();
			}
			if (st1 != null) {
				st1.close();
			}
			if (st2 != null) {
				st2.close();
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsProjetShelfDAO updateTbls : "+ e.getMessage());
		}
		return flag1;
	}

	public boolean writeRws_Schemes_Tbl1(Database database, Connection conn) throws IOException, SQLException {
		boolean flag = false;
		PreparedStatement stmt = null;
		String tableName = "Backend_Schemes_Schemes"; 
		Table table1 = createTable(tableName).addColumn(new ColumnBuilder("SchemeIdOfState").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("MainSchemeId_IMIS").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("SchemeName").setSQLType(Types.LONGVARCHAR).toColumn()).addColumn(
			new ColumnBuilder("StateId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("DistrictId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("SchemeTypeId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("Type").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("SanctionYear").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("EstimatedCost").setSQLType(Types.NUMERIC).toColumn()).addColumn(
			new ColumnBuilder("RevisedEstimatedCost").setSQLType(Types.NUMERIC).toColumn()).addColumn(
			new ColumnBuilder("GOICost").setSQLType(Types.NUMERIC).toColumn()).addColumn(
			new ColumnBuilder("StateCost").setSQLType(Types.NUMERIC).toColumn()).addColumn(
			new ColumnBuilder("CommCont").setSQLType(Types.NUMERIC).toColumn()).addColumn(
			new ColumnBuilder("PopulationCovered").setSQLType(Types.NUMERIC).toColumn()).addColumn(
			new ColumnBuilder("Capacity").setSQLType(Types.FLOAT).toColumn()).addColumn(
			new ColumnBuilder("ServiceLevel").setSQLType(Types.NUMERIC).toColumn()).addColumn(
			new ColumnBuilder("Expenditure").setSQLType(Types.NUMERIC).toColumn()).addColumn(
			new ColumnBuilder("ExpMoreReason").setSQLType(Types.NUMERIC).toColumn()).addColumn(
			new ColumnBuilder("DateOfCommencement").setSQLType(Types.DATE).toColumn()).addColumn(
			new ColumnBuilder("DateOfCompletion").setSQLType(Types.DATE).toColumn()).addColumn(
			new ColumnBuilder("PhysicalCompletionDate").setSQLType(Types.DATE).toColumn()).addColumn(
			new ColumnBuilder("FinancialCompletionDate").setSQLType(Types.DATE).toColumn()).addColumn(
			new ColumnBuilder("HandedCommunityDate").setSQLType(Types.DATE).toColumn()).addColumn(
			new ColumnBuilder("IsFullyPRI").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("Category").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("IsWasteWaterMgmt").setSQLType(Types.NUMERIC).toColumn()).addColumn(
			new ColumnBuilder("WasteWaterMNREGAS").setSQLType(Types.NUMERIC).toColumn()).addColumn(
			new ColumnBuilder("WasteWaterTSC").setSQLType(Types.NUMERIC).toColumn()).addColumn(
			new ColumnBuilder("WasteWaterOTH").setSQLType(Types.NUMERIC).toColumn()).toTable(database);
			stmt = conn.prepareStatement("SELECT distinct * FROM RWS_SCHEMES_TEMP_TBL ");			
			ResultSet rrs = stmt.executeQuery();
			flag = RwsProjectShelfDAO.importResultSet(rrs, table1);
		try {
			if (stmt != null) {
				stmt.close();
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsProjetShelfDAO writeRws_Schemes_Tbl1 : "+ e.getMessage());
		}
		return flag;
	}

	public boolean writeRWS_SchemeSources_Tbl2(Database database, Connection conn) throws IOException, SQLException {
		boolean flag = false;
		PreparedStatement stmt = null;
		String tableName = "Backend_Schemes_SchemesSources";
		Table table1 = createTable(tableName).addColumn(
			new ColumnBuilder("SourcesIdOfState").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("SchemeIdOfState").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("SourceTypeId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("SourceTypeCategoryId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("StateID").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("DistrictId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("HabitationId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("Location").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("SchoolId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("IsInSchool").setSQLType(Types.INTEGER).toColumn()).addColumn(
			new ColumnBuilder("DateOfCommissioning").setSQLType(Types.DATE).toColumn()).addColumn(
			new ColumnBuilder("Latitude").setSQLType(Types.DOUBLE).toColumn()).addColumn(
			new ColumnBuilder("Longitude").setSQLType(Types.DOUBLE).toColumn()).addColumn(
			new ColumnBuilder("Elevation").setSQLType(Types.DOUBLE).toColumn()).toTable(database);
			stmt = conn.prepareStatement("SELECT distinct *  FROM RWS_SCHEMESOURCES_TEMP_TBL ");				
			ResultSet rrs = stmt.executeQuery();
			flag = RwsProjectShelfDAO.importResultSet(rrs, table1);
			try {
				if (stmt != null) {
					stmt.close();
				}	
			} catch (Exception e) {
				System.out.println("The Exception is in RwsProjetShelfDAO writeRWS_SchemeSources_Tbl2 : "+ e.getMessage());
			}
		return flag;
	}

	public boolean writeRWS_SchemesProgrammes_Tbl3(Database database, Connection conn) throws SQLException, IOException {
		boolean flag = false;
		PreparedStatement stmt = null;
		String tableName = "Backend_Schemes_SchemesProgrammes"; 
		Table table1 = createTable(tableName).addColumn(
			new ColumnBuilder("SchemeIdOfState").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("ProgrammeId").setSQLType(Types.NUMERIC).toColumn()).toTable(database);
			stmt = conn.prepareStatement("SELECT distinct a.schemeid,a.programmeid FROM RWS_SCHEMESPROGRAMMES_TEMP_TBL a , Rws_schemes_temp_tbl b where b.SchemeIdOfState=a.SchemeId");
			ResultSet rrs = stmt.executeQuery();
			flag = RwsProjectShelfDAO.importResultSet(rrs, table1);
		try {
			if (stmt != null) {
				stmt.close();
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsProjetShelfDAO writeRWS_SchemesProgrammes_Tbl3 : "+ e.getMessage());
		}
		return flag;
	}

	public boolean writeRWS_SchemeHabs_Tbl4(Database database, Connection conn)	throws IOException, SQLException {
		boolean flag = false;
		PreparedStatement stmt = null;
		String tableName = "Backend_Schemes_HabitationsCovered";
		Table table1 = createTable(tableName).addColumn(
			new ColumnBuilder("DeleveryPointId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("SchemeIdOfState").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("StateID").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("DistrictId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("HabitationId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("Location").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("SchoolId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("IsInSchool").setSQLType(Types.INTEGER).toColumn()).addColumn(
			new ColumnBuilder("DateOfCommissioning").setSQLType(Types.DATE).toColumn()).addColumn(
			new ColumnBuilder("Latitude").setSQLType(Types.DOUBLE).toColumn()).addColumn(
			new ColumnBuilder("Longitude").setSQLType(Types.DOUBLE).toColumn()).addColumn(
			new ColumnBuilder("Elevation").setSQLType(Types.DOUBLE).toColumn()).addColumn(
			new ColumnBuilder("Del_House").setSQLType(Types.VARCHAR).toColumn()).toTable(database);
		stmt = conn.prepareStatement("SELECT  distinct b.* FROM RWS_SCHEMES_TEMP_TBL a,RWS_SCHEMEHABS_TEMP_TBL b where a.SCHEMEIDOFSTATE =b.SCHEMEIDOFSTATE ");		
		ResultSet rrs = stmt.executeQuery();
		flag = RwsProjectShelfDAO.importResultSet(rrs, table1);
		try {
			if (stmt != null) {
				stmt.close();
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsProjetShelfDAO writeRWS_SchemeHabs_Tbl4 : "+ e.getMessage());
		}
		return flag;
	}

	public boolean writeRWS_SchemesImplementingAgency_Tbl5(Database database, Connection conn) throws IOException, SQLException {
		boolean flag = false;
		PreparedStatement stmt = null;
		String tableName = "Backend_Schemes_SchemesImplementingAgency"; 
		Table table1 = createTable(tableName).addColumn(
			new ColumnBuilder("SchemeIdOfState").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("AgencyId").setSQLType(Types.VARCHAR).toColumn()).toTable(database);
		stmt = conn.prepareStatement("SELECT distinct * FROM Rws_SchImpAgency_TEMP_TBL ");		
		ResultSet rrs = stmt.executeQuery();
		flag = RwsProjectShelfDAO.importResultSet(rrs, table1);
		try {
			if (stmt != null) {
				stmt.close();
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsProjetShelfDAO writeRWS_SchemesImplementingAgency_Tbl5 : "+ e.getMessage());
		}
		return flag;
	}

	public boolean writeRWS_SchemesAgencyResForOM_Tbl6(Database database, Connection conn) throws SQLException, IOException {
		boolean flag = false;
		PreparedStatement stmt = null;
		String tableName = "Backend_Schemes_SchemesAgencyResponsibleForOM"; 
		Table table1 = createTable(tableName).addColumn(
			new ColumnBuilder("SchemeIdOfState").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("AgencyResponsibleForOMID").setSQLType(Types.NUMERIC).toColumn()).toTable(database);
		stmt = conn.prepareStatement("SELECT distinct * FROM Rws_SchAgencyResForOM_TEMP_TBL  ");		
		ResultSet rrs = stmt.executeQuery();
		flag = RwsProjectShelfDAO.importResultSet(rrs, table1);
		try {
			if (stmt != null) {
				stmt.close();
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsProjetShelfDAO writeRWS_SchemesAgencyResForOM_Tbl6 : "+ e.getMessage());
		}
		return flag;
	}
	
	public boolean writeSchemeContaminationTackledTbl(Database database, Connection conn) throws SQLException, IOException {
		boolean flag = true;
		PreparedStatement stmt = null;
		String tableName = "Backend_Schemes_SchemesContaminationTackeled"; 
		Table table = createTable(tableName).addColumn(
			new ColumnBuilder("SchemeIdOfState").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("ParameterId").setSQLType(Types.VARCHAR).toColumn()).toTable(database);
		try {
			stmt = conn.prepareStatement("SELECT distinct * FROM Rws_SCHCONT_TEMP_TBL");			
			ResultSet rrs = stmt.executeQuery();
			flag = RwsProjectShelfDAO.importResultSet(rrs, table);		
			if (stmt != null) {
				stmt.close();
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsProjetShelfDAO writeSchemeContaminationTackledTbl : "+ e.getMessage());
		}
		return flag;
	}

	public boolean writeSchemeSustainbilityMeasuresTakenTbl(Database database, Connection conn) throws IOException, SQLException {
		boolean flag = true;
		Statement stmt = null;
		stmt = conn.createStatement();
		String tableName = "Backend_Schemes_SchemesSustainibilityMeasuresTaken";
		Debug.println("Writing Eigth Table....... ");
		Table table = createTable(tableName).addColumn(
			new ColumnBuilder("SchemeIdOfState").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("StateID").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("DistrictId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("HabitationId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("SMActivityId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("Location").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("SchoolId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
			new ColumnBuilder("IsInSchool").setSQLType(Types.NUMERIC).toColumn()).toTable(database);
		// flag = RwsProjectShelfDAO.importResultSet(rrs, table1);
		try {
			if (stmt != null) {
				stmt.close();
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsProjetShelfDAO writeSchemeSustainbilityMeasuresTakenTbl : "+ e.getMessage());
		}
		return flag;
	}
	
	public boolean createPrjShelfSeventhTable(Connection con,String[] wrkList) {
		Statement st1 = null;
		ResultSet rs1 = null,resset=null;
		PreparedStatement preparedStatement=null,  st2 = null;
		String query = "";
		String preparedOn="";
		String source_code="";
		String typeOfContamination="",parameterId="",workid="";
		try {
			st1 = con.createStatement();
			isTableExists("RWS_SCHCONT_TEMP_TBL", con, "create table Rws_SCHCONT_TEMP_TBL(SchemeIdOfState varchar2(14),ParameterId varchar2(10))");
			for (int k = 0; k < wrkList.length; k++) {
				workid=wrkList[k];
				String qq = "select to_char(max(prepared_on),'dd/mm/yyyy'),s.source_code from rws_wq_test_results_tbl a,rws_source_tbl s where a.source_code=s.source_code and asset_code= ? group by s.source_code";
				st2 = con.prepareStatement(qq);
				st2.setString(1, workid);
				rs1 = st2.executeQuery();
				while (rs1.next()) {
					preparedOn=rs1.getString(1);
					source_code=rs1.getString(2);
					String flouride="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE='13' AND A.TESTING_PARAMETER_VALUE > 1.5 AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";			
					preparedStatement=con.prepareStatement(flouride);
					preparedStatement.setString(1, source_code);
					preparedStatement.setString(2, preparedOn);
					resset=preparedStatement.executeQuery();
					if(resset.next()){
						 typeOfContamination="FLOURIDE"; 
						 parameterId="003";
					}
					 resset.close();
					 preparedStatement.close();
					 if(typeOfContamination.equals("")){
						 String brakish="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE='05' AND A.TESTING_PARAMETER_VALUE > 2000 AND SOURCE_CODE= ? AND B.PREPARED_ON=to_date( ? ,'dd/mm/yyyy')";			
						 preparedStatement=con.prepareStatement(brakish);
						 preparedStatement.setString(1, source_code);
						 preparedStatement.setString(2, preparedOn);
						 resset=preparedStatement.executeQuery();
						 if(resset.next()){
							 typeOfContamination="SALINITY"; 
							 parameterId="014";
						 }
						 resset.close();
						 preparedStatement.close();
					 }
					 if(typeOfContamination.equals("")){
						 String brakish="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE='16' AND A.TESTING_PARAMETER_VALUE > 0.3 AND SOURCE_CODE= ? AND B.PREPARED_ON=to_date( ? ,'dd/mm/yyyy')";			
						 preparedStatement=con.prepareStatement(brakish);
						 preparedStatement.setString(1, source_code);
						 preparedStatement.setString(2, preparedOn);
						 resset=preparedStatement.executeQuery();
						 if(resset.next()){
							 typeOfContamination="IRON"; 
							 parameterId="004";
						 }
						 resset.close();
						 preparedStatement.close();
					 }
					 if(typeOfContamination.equals("")){
						 String brakish="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE='15' AND A.TESTING_PARAMETER_VALUE > 45 AND SOURCE_CODE= ? AND B.PREPARED_ON=to_date( ? ,'dd/mm/yyyy')";			
						 preparedStatement=con.prepareStatement(brakish);
						 preparedStatement.setString(1, source_code);
						 preparedStatement.setString(2, preparedOn);
						 resset=preparedStatement.executeQuery();
						 if(resset.next()){
							 typeOfContamination="NITRATE";
							 parameterId="006";
						 }
						 resset.close();
						 preparedStatement.close();
					 }
					query = "INSERT INTO Rws_SCHCONT_TEMP_TBL values('"+ workid + "','" + parameterId + "')";
					st1.addBatch(query);
				}
			}
			st1.executeBatch();

		} catch (Exception e) {
			System.out.println("The Exception is in RwsProjetShelfDAO createPrjShelfSeventhTable : "+ e.getMessage());			
		} finally {
			try {
				if (st1 != null) {
					st1.close();
				}
				if (st2 != null) {
					st2.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in RwsProjetShelfDAO createPrjShelfSeventhTable : "+ e.getMessage());
			}
		}
		return true;
	}
	
	public boolean createPrjShelfEigthTable(Connection conn) {
		return true;
	}

	public boolean createPrjShelfFirstTableFromExcel(HSSFSheet sheet, Connection con, ActionMessages messages, Rws_Projectshelf_ExcelSheet_Form myForm) {
		boolean flag = false;
		PreparedStatement st2 = null;
		Statement st1 = null;
		ResultSet rs = null, rs2 = null;
		String query = "";
		String workid = "", main = "0", workname = "", stateid = "002", dcode = "", schemetypeid = "", type = "", sancyear = "", estcost = "0", revestcost = "0", goicost = "0", statecost = "0", commcont = "0", capacity = "0", service = "", exp = "0", moreexp = "0", dofcomm = "", dofcomp = "", psy = "", atm = "No";
		double popcov = 0;
		String year = RwsUtils.getCurrentYear();
		int nextyear = Integer.parseInt(year) + 1;
		String finyear = year + "-" + nextyear;
		String sysdate = RwsUtils.getCurrentDate("dd/MM/yy");
		int recCount = 0;
		try {
			st1 = con.createStatement();
			isTableExists("RWS_SCHEMES_TEMP_TBL", con, "create table RWS_Schemes_TEMP_TBL(SchemeIdOfState varchar2(14),MainSchemeId_IMIS varchar2(30),SchemeName varchar2(200),StateId varchar2(50),DistrictId varchar2(50),SchemeTypeId varchar2(50),Type varchar2(50),SanctionYear varchar2(50),EstimatedCost number(30,2),RevisedEstimatedCost number(30,2),GOICost number(30,2),StateCost number(30,2),CommCont number(30,2),PopulationCovered number(30,2),Capacity  varchar2(50),ServiceLevel number(11,2),Expenditure number(30,2),ExpMoreReason number(30,2),DateOfCommencement Date,DateOfCompletion Date,PhysicalCompletionDate date,FinancialCompletionDate date ,HandedCommunityDate date,IsFullyPRI varchar2(10),Category varchar2(10),IsWasteWaterMgmt number(1),WasteWaterMNREGAS number(11,2),WasteWaterTSC number(11,2),WasteWaterOTH number(11,2),programme_code varchar2(3))");
			for (int j = 0; j <= sheet.getLastRowNum(); j++) {
				HSSFRow row = sheet.getRow(j);
				String workId = row.getCell((short) 0).getStringCellValue();
				String qry = "select  a.work_id,a.work_name,a.sanction_amount,decode(substr (a.work_id,7,2),'01','0378','02','0378','03','0176','08','0900','04','0004','07','0378','11','0378','10','0479') as schemetypeid,decode (aug_new_code,'1','PWS','2','Augmentation') as type,to_char(a.admin_date,'dd/mm/yyyy') as sancyear,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20','0022','21','0023','22','0024','23','0025')as dcode"
						+ " , a.programme_code as progCode,a.subprogramme_code,category_code,aug_new_code,AUG_WORKID  as augWork,admin_no from rws_work_admn_tbl a where  a.work_id = ? ";
				st2 = con.prepareStatement(qry);
				st2.setString(1, workId);
				rs2 = st2.executeQuery();
				int i = 1, total = 0;
				while (rs2.next()) {
					String slipreason = "";
					int prstatus = 0, prestatus = 0;
					String augWorkId = rs2.getString("augWork");
					workid = rs2.getString("WORK_ID");
					workname = rs2.getString("WORK_NAME");
					dcode = rs2.getString("dcode");
					schemetypeid = rs2.getString("SCHEMETYPEID");
					type = rs2.getString("TYPE");
					String dates = rs2.getString("SANCYEAR");
					String progCode = rs2.getString("progCode");
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
						estcost = "" + rs2.getDouble("SANCTION_AMOUNT")* 100000;
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
					recCount++;
					query = "insert into RWS_Schemes_TEMP_TBL(SchemeIdOfState,MainSchemeId_IMIS,SchemeName,StateId,DistrictId,SchemeTypeId,Type,SanctionYear,EstimatedCost,RevisedEstimatedCost,GOICost,StateCost,CommCont,PopulationCovered,Capacity,ServiceLevel,Expenditure,ExpMoreReason,programme_code,DATEOFCOMMENCEMENT,DATEOFCOMPLETION,PHYSICALCOMPLETIONDATE,FINANCIALCOMPLETIONDATE,HANDEDCOMMUNITYDATE,ISFULLYPRI)	values('"+workid+"','"+main+"','"+workname+"','"+stateid+"','"+dcode+"','"+schemetypeid+"','"+type+"','"+sancyear+"','"+estcost+"','"+revestcost+"','"+goicost+"','"+statecost+"','"+commcont+"','"+popcov+"','"+capacity+"','"+service+"','"+exp+"','"+moreexp+"','"+progCode+"','','','','','','0')";
					st1.addBatch(query);
				}
			} 
			st1.executeBatch();
			myForm.setTotalSchemes(recCount);
			messages.add("Schemes Table", new ActionMessage("app.totalSchemes",	recCount));
		} catch (Exception e) {
			System.out.println("The Exception is in RwsProjetShelfDAO createPrjShelfFirstTableFromExcel : "+ e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}				
				if (st1 != null) {
					st1.close();
				}
				if (st2 != null) {
					st2.close();
				}				
			} catch (Exception e) {
				System.out.println("The Exception is in RwsProjetShelfDAO createPrjShelfFirstTableFromExcel : "+ e.getMessage());
			}
		}
		return true;
	}
	
	public static boolean importResultSet1(ResultSet source, Table table,String DistrictName) throws SQLException, IOException {
		boolean flag = false;
		ResultSetMetaData md = source.getMetaData();
		List<Object[]> rows = new ArrayList<Object[]>(COPY_TABLE_BATCH_SIZE);
		int numColumns = md.getColumnCount();
		while (source.next()) {
			Object[] row = new Object[numColumns];
			for (int i = 0; i < row.length; i++) {
				if (md.getColumnType(i + 1) == java.sql.Types.DATE) {
					row[i] = parseDateSS(source.getDate(i + 1), source, i + 1);
				} else {
					if((i + 1)==6){
						String Path=DistrictName+"\\";
						row[i]=Path+source.getObject(i + 1)+".jpg";
					}
					else{				
						row[i] = source.getObject(i + 1);
					}					
				}
			}
			rows.add(row);
			if (rows.size() == COPY_TABLE_BATCH_SIZE){
				table.addRows(rows);
				rows.clear();
			}
		}
		if (rows.size() > 0){
			table.addRows(rows);
			flag = true;
		}
		return flag;
	}
	
	private static Object parseDateSS(Date date, ResultSet source, int index)  {
		if (date != null && !date.equals("null")) {
			java.util.Date dt = null;				
			SimpleDateFormat dateFormatter = new SimpleDateFormat("yyyy-MM-dd");
			String currentDate = dateFormatter.format(date);
			try {
				dt = dateFormatter.parse(currentDate);
			} catch (ParseException e) {
				System.out.println("The Exception is in RwsProjetShelfDAO parseDateSS : "+ e.getMessage());
			}
			return dt;
		} else {
			try {
				return source.getObject(index);
			} catch (SQLException e) {
				System.out.println("The Exception is in RwsProjetShelfDAO parseDateSS : "+ e.getMessage());
			}
		}
		return null;
	}
	public static boolean importResultSetForGeoTagging(ResultSet source, Table table,String DistrictName) throws SQLException, IOException {
		boolean flag = false;
		ResultSetMetaData md = source.getMetaData();
		List<Object[]> rows = new ArrayList<Object[]>(COPY_TABLE_BATCH_SIZE);
		int numColumns = md.getColumnCount();
		while (source.next()) {
			Object[] row = new Object[numColumns];
			for (int i = 0; i < row.length; i++) {
				if (md.getColumnType(i + 1) == java.sql.Types.DATE) {
					row[i] = parseDateSS(source.getDate(i + 1), source, i + 1);
				} else {
					if((i + 1)==18){
						String Path=DistrictName+"\\";
						row[i]=Path+source.getObject(i + 1)+".jpg";
					}
					else{			
						row[i] = source.getObject(i + 1);
					}				
				}
			}
			rows.add(row);
			if (rows.size() == COPY_TABLE_BATCH_SIZE){
				table.addRows(rows);
				rows.clear();
			}
		}
		if (rows.size() > 0){
			table.addRows(rows);
			flag = true;
		}
		return flag;
	}
}
