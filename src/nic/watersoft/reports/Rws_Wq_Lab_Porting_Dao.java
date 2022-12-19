package nic.watersoft.reports;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;
import java.util.Hashtable;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;

import com.healthmarketscience.jackcess.ColumnBuilder;
import com.healthmarketscience.jackcess.Database;
import com.healthmarketscience.jackcess.DatabaseBuilder;
import com.healthmarketscience.jackcess.Table;
import com.healthmarketscience.jackcess.TableBuilder;
import com.healthmarketscience.jackcess.Database.FileFormat;

public class Rws_Wq_Lab_Porting_Dao {

	public static Database createDatabase(String databaseName) throws IOException {
		return DatabaseBuilder.create(FileFormat.V2007, new File(databaseName));
	}

	private static TableBuilder createTable(String tableName) {
		return new TableBuilder(tableName);
	}

	public static void addColumn(Database database, TableBuilder tableName, String columnName, Types sqlType) throws SQLException, IOException { 
		tableName.addColumn(new ColumnBuilder(columnName).setSQLType(Types.INTEGER).toColumn()).toTable(database);
	}

	public boolean createFinalSources(String fromdate, String todate) {
		boolean flag = false;
		PreparedStatement st = null, st1 = null, st2 = null, st3 = null, st4 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		Connection con = RwsOffices.getConn();
		try {
			String selquery = "Select tname from tab where tname like 'FINALSOURCES_TEMP_TBL'";
			st = con.prepareStatement(selquery);
			rs = st.executeQuery();
			if (!rs.next()) {
				String crquery = "create table  finalSources_temp_tbl (SOURCE_CODE varchar2(50),HAB_CODE varchar2(50),TEST_ID varchar2(50),HabitationId varchar2(50),DistrictId varchar2(50),PREPARED_ON varchar2(50),SourceTypeCode varchar2(50),ASSET_CODE varchar2(50),Lab_Code varchar2(4),test_code varchar2(1),potable varchar2(1))";
				st1 = con.prepareStatement(crquery);				
				st1.executeUpdate();
			} else {
				String delquery = "delete from finalSources_temp_tbl";
				st1 = con.prepareStatement(delquery);	
				st1.executeUpdate();
				con.commit();
			}

			String qry = "select distinct b.SOURCE_CODE,substr(b.source_code,1,16),b.TEST_ID,c.HabitationId,c.DistrictId,to_char(b.PREPARED_ON,'dd/mm/yyyy'),nvl(b.LAB_CODE,'-'), b.TEST_CODE ,nvl(POTABLE,'-') from  RWS_WQ_TEST_RESULTS_TBL b, IMISMASTERDATA1  c where ( b.PREPARED_ON>=TO_DATE( ? ,'dd-mm-yy') and a.PREPARED_ON<=TO_DATE(? ,'dd-mm-yy') ) and c.habcode=substr(b.source_code,1,16)";
			st2 = con.prepareStatement(qry);	
			st2.setString(1, fromdate);
			st2.setString(2, todate);
			rs2 = st2.executeQuery();
			int total = 0;
			while (rs2.next()) {
				String insertqry = "insert into finalSources_temp_tbl(SOURCE_CODE,HAB_CODE,TEST_ID ,HabitationId,DistrictId,PREPARED_ON,lab_code,test_code,potable) values( ? , ?, ?, ?, ?, ?, ?, ?, ?)";
				st3 = con.prepareStatement(insertqry);	
				st3.setString(1, rs2.getString(1));
				st3.setString(2, rs2.getString(2));
				st3.setString(3, rs2.getString(3));
				st3.setString(4, rs2.getString(4));
				st3.setString(5, rs2.getString(5));
				st3.setString(6, rs2.getString(6));
				st3.setString(7, rs2.getString(7));
				st3.setString(8, rs2.getString(8));
				st3.setString(9, rs2.getString(9));
				total += st3.executeUpdate();
			}			
			if (total > 0) {
				String updateqry = "update finalSources_temp_tbl t set SourceTypeCode=(select source_type_code from rws_source_tbl where source_code=t.source_code)";
				st4 = con.prepareStatement(updateqry);	
				int up = st4.executeUpdate();
				if (up > 0) {
					con.commit();
					flag = true;
				} else
					Debug.println("failed to update............");
			}
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Wq_Lab_Porting_Dao createFinalSources : "+e.getMessage());
		} finally {
			try {
				rs.close();
				st.close();
				st1.close();
				rs2.close();
				st2.close();
				st3.close();
				st4.close();
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Wq_Lab_Porting_Dao createFinalSources : "+e.getMessage());
			}
		}
		return flag;
	}
	
	public boolean createFirstTable(String fromDate, String toDate,Connection con) {
		Statement  st3 = null,  up_st = null;
		PreparedStatement st = null, st1 = null, st2 = null, st4 = null, st5 = null;
		ResultSet rs = null, rs1 = null, rs4 = null, rs5 = null;
		String testid = "", ptype = "", fitunfit = "", ActionTaken = "";
		boolean flag = false;
		try {
			st3 = con.createStatement();
			up_st = con.createStatement();
			Hashtable<String, String> labHash = new Hashtable<String, String>();
			String selquery = "Select tname from tab where tname like 'BACKEND_SCHEMES_WQM_TESTING'";
			st = con.prepareStatement(selquery);
			rs = st.executeQuery();
			if (!rs.next()) {
				String crquery = "create table BackEnd_Schemes_WQM_Testing(TestId VARCHAR2(10),StateId VARCHAR2(3),DistrictId VARCHAR2(4),HabitationId VARCHAR2(16),Type VARCHAR2(3),SourceId VARCHAR2(30),LabId VARCHAR2(6),ParameterType VARCHAR2(3),SampleName VARCHAR2(50),SampleNameBact  VARCHAR2(50),TestingDate Date,ActionTaken VARCHAR2(50),FitUnfit VARCHAR2(15),STATE_SOURCECODE VARCHAR2(24))";
				st1 = con.prepareStatement(crquery);				
				st1.executeUpdate();
			} else {
				String delquery = "delete from BackEnd_Schemes_WQM_Testing";
				st1 = con.prepareStatement(delquery);				
				st1.executeUpdate();
				con.commit();
			}
			String labQuery = "select nvl(AP_LABCODE,''),nvl(IMISLABID,'') from  rws_imis_wq_lab_tbl where AP_LABCODE is not null";
			st5 = con.prepareStatement(labQuery);				
			rs5 = st5.executeQuery();
			while (rs5.next()) {
				labHash.put(rs5.getString(1), rs5.getString(2));
			}
			String qry = "select distinct b.SOURCE_CODE,substr(b.source_code,1,16),b.TEST_ID,c.HabitationId,c.DistrictId,to_char(b.PREPARED_ON,'dd/mm/yyyy'),b.lab_code as labCode, b.TEST_CODE ,nvl(POTABLE,'-')  from  RWS_WQ_TEST_RESULTS_TBL b, IMISMASTERDATA1  c  where ( b.PREPARED_ON>=TO_DATE('"+fromDate+"','dd-mm-yy') and b.PREPARED_ON<=TO_DATE('"+toDate+"','dd-mm-yy') ) and c.habcode=substr(b.source_code,1,16)";
			st2 = con.prepareStatement(qry);			
			rs1 = st2.executeQuery();
			while (rs1.next()) {
				String sCode = rs1.getString(1);
				String type = "SC";
				String para_type = rs1.getString(8);
				String port_type = rs1.getString(9);
				testid = rs1.getString(3);
				String sCode1 = "";
				String apLabCode = rs1.getString("labCode");
				String ddwsLabId = labHash.get(apLabCode);
				if (para_type != null && para_type.equals("1")) {
					ptype = "CHM";
				} else if (para_type != null && para_type.equals("2")) {
					ptype = "BAC";
				}
				if (port_type != null && port_type.equals("Y")) {
					ActionTaken = "PORTBLE";
					fitunfit = "FIT";
				} else if (port_type != null && port_type.equals("N")) {
					ActionTaken = "NON PORTBLE";
					fitunfit = "UNFIT";
				} else {
					fitunfit = "NO OPINION";
					ActionTaken = "";
				}
				String Query = "insert into BackEnd_Schemes_WQM_Testing(TestId,SourceId,HabitationId,Districtid,SampleName,StateId,Type,TestingDate,Labid,ParameterType,ActionTaken,FitUnfit,STATE_SOURCECODE )values('"+testid+"','"+sCode1+"','"+rs1.getString(4)+"','"+rs1.getString(5)+"','"+rs1.getString(3)+"','002','"+type+"',to_date('"+rs1.getString(6)+"','dd/mm/yyyy'),'"+ddwsLabId+"','"+ptype+"','"+ActionTaken+"','"+fitunfit+"','"+sCode+ "')";
				st3.addBatch(Query);
			}
			st3.executeBatch();
			String sourceUpdateQ = "select SCHEMESOURCEID_STATE,SCHEMESSOURCESID_IMIS from rws_imis_schemesources_tbl a,BackEnd_Schemes_WQM_Testing b where a.SCHEMESOURCEID_STATE=b.STATE_SOURCECODE";
			st4 = con.prepareStatement(sourceUpdateQ);				
			rs4 = st4.executeQuery();
			while (rs4.next()) {
				String upquery = "update BackEnd_Schemes_WQM_Testing a set SourceId='"+rs4.getString(2)+"' where a.STATE_SOURCECODE='"+rs4.getString(1)+"' ";
				up_st.addBatch(upquery);
			}
			up_st.executeBatch();
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Wq_Lab_Porting_Dao createFirstTable : "+e.getMessage());
		} 
		return true;
	}

	public boolean secondThirdTable(Connection con ) {
		Statement  st3 = null;
		PreparedStatement st = null, st1 = null, st2 = null;
		ResultSet rs = null, rs1 = null;
		boolean flag = false;
		String Query = "";
		try {
			st3 = con.createStatement();
			String selquery = "Select tname from tab where tname like 'BACKEND_SCHEMES_WQM_LAB'";
			st = con.prepareStatement(selquery);
			rs = st.executeQuery();
			if (!rs.next()) {
				String crquery = "create table BackEnd_Schemes_WQM_Lab(TestId VARCHAR2(50),ParameterId VARCHAR2(50),TESTING_PARAMETER_VALUE VARCHAR2(50))";
				st1 = con.prepareStatement(crquery);
				st1.executeUpdate();
			} else {
				String delquery = "delete from BackEnd_Schemes_WQM_Lab";
				st1 = con.prepareStatement(delquery);
				st1.executeUpdate();
				con.commit();
			}
			String Query1 = "SELECT distinct BackEnd_Schemes_WQM_Testing.TestId, WQQualityParameter.ParameterId,RWS_WQ_TEST_RESULTS_LNK_TBL.TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_TBL INNER JOIN ((WQQualityParameter INNER JOIN RWS_WQ_TEST_RESULTS_LNK_TBL ON WQQualityParameter.pcode = RWS_WQ_TEST_RESULTS_LNK_TBL.TESTING_PARAMETER_CODE) INNER JOIN BackEnd_Schemes_WQM_Testing ON RWS_WQ_TEST_RESULTS_LNK_TBL.TEST_ID = BackEnd_Schemes_WQM_Testing.SAMPLENAME) ON (BackEnd_Schemes_WQM_Testing.SAMPLENAME  = RWS_WQ_TEST_RESULTS_TBL.TEST_ID) AND (RWS_WQ_TEST_RESULTS_TBL.TEST_CODE = WQQualityParameter.TestId) WHERE (((RWS_WQ_TEST_RESULTS_LNK_TBL.TESTING_PARAMETER_VALUE) Is Not Null))";
			st2= con.prepareStatement(Query1);
			rs1 = st2.executeQuery();
			int salcount = 0;
			while (rs1.next()) {
				String value1 = rs1.getString(1);
				String value2 = rs1.getString(2);
				String value3 = rs1.getString(3);
				if (value2.equals("005")) {
					double value = Double.parseDouble(value3);
					value = 0.03 + ((1.806 * value) / 1000);
					if (value > 1.836) {
						if (value3 != null && !value3.equals(" ")) {
							salcount++;
							Query = "insert into BackEnd_Schemes_WQM_Lab values ('"+value1+"','014','"+value+"')";
						}
					} else {
						if (value3 != null && !value3.equals(" ")) {
							Query = "insert into BackEnd_Schemes_WQM_Lab values ('"+value1+"','"+value2+"','"+value3+"')";
						}
					}
				} else {
					if (value3 != null && !value3.equals(" ")) {
						Query = "insert into BackEnd_Schemes_WQM_Lab values ('"+value1+"','"+value2+"','"+value3+"')";
					}
				}
				st3.addBatch(Query);				
			} 
			st3.executeBatch();
			flag = true;
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Wq_Lab_Porting_Dao secondThirdTable : "+e.getMessage());
		} finally {
			try {
				rs.close();
				rs1.close();				
				st.close();
				st1.close();
				st2.close();
				st3.close();
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Wq_Lab_Porting_Dao secondThirdTable : "+e.getMessage());
			}
		}
		return true;
	}

	public boolean writeBACKEND_SCHEMES_WQM_WATERQUALITYTESTING(Database database, Connection conn) {
		boolean flag = true;
		ResultSet rrs = null;
		PreparedStatement stmt = null;
		try {
			String tableName = "BackEnd_Schemes_WQM_WaterQualityTesting"; 
			Table table1 = createTable(tableName).addColumn(
					new ColumnBuilder("TestId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("StateId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("DistrictId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("HabitationId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("Type").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("SourceId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("LabId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("ParameterType").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("SampleName").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("SampleNameBact").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("TestingDate").setSQLType(Types.DATE).toColumn()).addColumn(
					new ColumnBuilder("ActionTaken").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("FitUnfit").setSQLType(Types.VARCHAR).toColumn()).toTable(database);
			stmt = conn.prepareStatement("SELECT  * FROM BACKEND_SCHEMES_WQM_TESTING");			
			rrs = stmt.executeQuery();
			flag = RwsProjectShelfDAO.importResultSet(rrs, table1);
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Wq_Lab_Porting_Dao writeBACKEND_SCHEMES_WQM_WATERQUALITYTESTING : "+e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Wq_Lab_Porting_Dao writeBACKEND_SCHEMES_WQM_WATERQUALITYTESTING : "+e.getMessage());
			}
		}
		return flag;
	}

	public boolean writeBACKEND_SCHEMES_WQM_LABTESTINGDETAILS(Database database, Connection conn) {
		boolean flag = false;
		PreparedStatement stmt = null;
		try {
			String tableName = "BackEnd_Schemes_WQM_LabTestingDetails"; 
			Table table1 = createTable(tableName).addColumn(
					new ColumnBuilder("TestId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("ParameterId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("ActualLevel").setSQLType(Types.DOUBLE).toColumn()).toTable(database);
			stmt = conn.prepareStatement("SELECT *  FROM BACKEND_SCHEMES_WQM_LAB");			
			ResultSet rrs = stmt.executeQuery();
			flag = RwsProjectShelfDAO.importResultSet(rrs, table1);
			flag = true;
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Wq_Lab_Porting_Dao writeBACKEND_SCHEMES_WQM_LABTESTINGDETAILS : "+e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Wq_Lab_Porting_Dao writeBACKEND_SCHEMES_WQM_LABTESTINGDETAILS : "+e.getMessage());
			}
		}
		return true;
	}
}
