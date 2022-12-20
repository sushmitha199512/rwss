package nic.watersoft.reports;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Types;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;

import com.healthmarketscience.jackcess.ColumnBuilder;
import com.healthmarketscience.jackcess.Database;
import com.healthmarketscience.jackcess.DatabaseBuilder;
import com.healthmarketscience.jackcess.Table;
import com.healthmarketscience.jackcess.TableBuilder;
import com.healthmarketscience.jackcess.Database.FileFormat;

public class Rws_Wq_Ftk_Access_DAO {
	public static Database createDatabase(String databaseName) throws IOException {
		return DatabaseBuilder.create(FileFormat.V2007, new File(databaseName));
	}

	private static TableBuilder createTable(String tableName) {
		return new TableBuilder(tableName);
	}
	
	public static void addColumn(Database database, TableBuilder tableName, String columnName, Types sqlType) throws SQLException, IOException { 
		tableName.addColumn(new ColumnBuilder(columnName).setSQLType(Types.INTEGER).toColumn()).toTable(database);
	}

	public boolean createFirstFTKTable(String fromdate, String todate,Connection con) {
		PreparedStatement st = null, st1 = null, st2 = null, st3 = null, st4 = null, st5 = null, st6 = null, st7 = null, st8 = null, st9 = null;
		ResultSet rs = null, rs1 = null, rs2 = null, rs3 = null, rs4 = null ;
		boolean flag1 = false;
		int yesContaminated = 0;
		int noContaminated = 0;
		String query = "";
		String finYear = "";
		String WORK_ID = "", parameterId = "";
		String source_code = "", ftestId = "";
		String fieldtest="";
		String h2svial="";
		String ttype="";
		int total = 0;
		try {
			String selquery1 = "Select tname from tab where tname like 'RWS_WQ_BACKENDFTK_TESTTEMP_TBL'";
			st = con.prepareStatement(selquery1);			
			rs = st.executeQuery();
			if (!rs.next()) {
				String crquery = "create table Rws_WQ_BackendFTK_Testtemp_Tbl(TestId varchar2(50),StateId varchar2(3),DistrictId varchar2(4),HabitationId varchar(10),SourceId varchar2(24),Type varchar2(5),TestingDate Date,ContaminatedYes_No varchar2(50),ParameterType varchar2(50),PanchayatId varchar2(10))";
				st1 = con.prepareStatement(crquery);			
				st1.executeUpdate();
			} else {
				String delquery = "delete from Rws_WQ_BackendFTK_Testtemp_Tbl";
				st1 = con.prepareStatement(delquery);			
				st1.executeUpdate();
				con.commit();
			}			
			String selquery = "Select tname from tab where tname like 'RWS_WQ_BACKENDFTK_TESTDTLS_TBL'";
			st2 = con.prepareStatement(selquery);			
			rs1 = st2.executeQuery();
			if (!rs1.next()){
				String crquery = "create table RWS_WQ_BACKENDFTK_TESTDTLS_TBL(TestId varchar2(10),ParameterId varchar2(3))";
				st3 = con.prepareStatement(crquery);			
				st3.executeUpdate();				
			} else {
				String delquery = "delete from RWS_WQ_BACKENDFTK_TESTDTLS_TBL";
				st3 = con.prepareStatement(delquery);			
				st3.executeUpdate();
				con.commit();
			}
			String query1 = "select DISTINCT source_code,ftk_test_id,to_char(test_date,'dd/mon/yyyy') from rws_ftk_testing_tbl where test_date>=TO_DATE( ? ,'dd-mm-yyyy') and  test_date<=TO_DATE(? ,'dd-mm-yyyy') ORDER BY to_char(test_date,'dd/mon/yyyy')" ;
			st4 = con.prepareStatement(query1);		
			st4.setString(1, fromdate);
			st4.setString(2, todate);
			rs2 = st4.executeQuery();
			while (rs2.next()) {
				source_code = rs2.getString(1);	
				ftestId = rs2.getString(2);
            	String qq = "";
				WORK_ID = "asset_code";
				if (source_code.substring(19, 21).equals("HP")) {
					qq = "select  DISTINCT A.*,B.HabitationId,B.Stateid, B.DistrictId,B.PanchayatId,d.asset_code,FIELD_TEST_CHEMICAL,H2S_VIAL,to_date(a.test_date,'dd/mm/yyyy') FROM RWS_FTK_TESTING_TBL A,IMISMASTERDATA1 B,rws_hp_subcomp_param_tbl  C,RWS_ASSET_MAST_TBL D WHERE C.ASSET_CODE=D.ASSET_CODE AND D.HAB_CODE=B.HabCODE and c.hp_code= ? and a.source_code=c.hp_code and a.ftk_test_id= ? ";
				} else if (source_code.substring(19, 21).equals("OW")) {
					qq = "select  DISTINCT A.*,B.HabitationId,B.Stateid, B.DistrictId,B.PanchayatId,d.asset_code,FIELD_TEST_CHEMICAL,H2S_VIAL,to_date(a.test_date,'dd/mm/yyyy') FROM RWS_FTK_TESTING_TBL A,IMISMASTERDATA1 B,RWS_OPEN_WELL_MAST_TBL C,RWS_ASSET_MAST_TBL D WHERE C.ASSET_CODE=D.ASSET_CODE AND D.HAB_CODE=B.HabCODE and c.openwell_code= ? and a.source_code=c.openwell_code and a.ftk_test_id= ? ";
				} else if (source_code.substring(19, 21).equals("SH")) {
					qq = "select  DISTINCT A.*,B.HabitationId,B.Stateid, B.DistrictId,B.PanchayatId,d.asset_code,FIELD_TEST_CHEMICAL,H2S_VIAL,to_date(a.test_date,'dd/mm/yyyy') FROM RWS_FTK_TESTING_TBL A,IMISMASTERDATA1 B,RWS_SHALLOWHANDPUMPS_TBL C,RWS_ASSET_MAST_TBL D WHERE C.ASSET_CODE=D.ASSET_CODE AND D.HAB_CODE=B.HabCODE and c.shallowhp_code= ? and a.source_code=c.shallowhp_code and a.ftk_test_id= ? ";
				} else if (source_code.substring(19, 21).equals("SO")) {
					qq = "select  DISTINCT A.*,B.HabitationId,B.Stateid, B.DistrictId,B.PanchayatId,d.asset_code,FIELD_TEST_CHEMICAL,H2S_VIAL,to_date(a.test_date,'dd/mm/yyyy') FROM RWS_FTK_TESTING_TBL A,IMISMASTERDATA1 B,RWS_SOURCE_TBL C,RWS_ASSET_MAST_TBL D WHERE C.ASSET_CODE=D.ASSET_CODE AND D.HAB_CODE=B.HabCODE and c.source_code= ? and  a.source_code=c.source_code and a.ftk_test_id= ? ";
				} else {
					continue;
				}
				st5 = con.prepareStatement(qq);					
				st5.setString(1, source_code);
				st5.setString(2, ftestId);	
				rs3 = st5.executeQuery();
				String contaminated = "";
				boolean flag=false;
				while (rs3.next()){
                   fieldtest=rs3.getString("FIELD_TEST_CHEMICAL");
                   h2svial=rs3.getString("H2S_VIAL");   
                   if(fieldtest!=null && fieldtest.equals("Y") && h2svial !=null && h2svial.equals("Y")){
                	   ttype="BOTH";
	               } else if(fieldtest!=null && fieldtest.equals("Y")){
		               ttype="CHM";
		           } else if(h2svial !=null && h2svial.equals("Y")){
		               ttype="BAC";
		           }
					String tdate1 = rs3.getString("test_date");
					String FTK_ID = rs3.getString("FTK_TEST_ID");					
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
					if (value3 == null && value4 == null && value5 == null && value6 == null && value7 == null && value8 == null && value9 == null && value10 == null && value11 == null && value12 == null && value13 == null	&& value14 == null && value15 == null && value16 == null && value17 == null) {
						contaminated = "0";
						noContaminated++;
					} else {
						for (int i = 0; i < 15; i++) {
							if (value + "" + (i + 3) != null){
								switch (i + 3){ 
									case 3:
										parameterId = "002";
										break; //ARSENIC 
									case 4:
										parameterId = "006";
										break; //NITRATE
									case 5:
										parameterId = "003";
										break; //FLOURIDE
									case 6:
										parameterId = "014";
										break; //SALINITY
									case 7:
										parameterId = "004";
										break; //IRON
									case 8:
										parameterId = "012";
										break; //COLIFORM
									case 9:
										parameterId = "001";
										break; //TURBODITY
									case 10:
										parameterId = "005";
										break; //CHLORIDE
									case 11:
										parameterId = "010";
										break; //MANGANEESE
									case 12:
										parameterId = "007";
										break; //SULPHATES
									case 13:
										parameterId = "011";
										break; //COPPER
									case 14:
										parameterId = "008";
										break; //CALSIUM
									case 15:
										parameterId = "015";
										break; //TDS
									case 16:
										parameterId = "009";
										break; //MAGNINESIUM
									case 17:
										parameterId = "016";
										break; //HARDNESS
								}
								if (parameterId !=null && !parameterId.equals("")) {									
									query = "insert into RWS_WQ_BACKENDFTK_TESTDTLS_TBL(TestId,ParameterId)values( ? , ? )";
									st6 = con.prepareStatement(query);
									st6.setString(1, FTK_ID);
									st6.setString(2, parameterId);
									st6.executeUpdate();	
									if (st6 != null) {
										st6.close();
									}
								}
							}
						} 
						contaminated = "1";
						yesContaminated++;
					}
					String tdate = "-";
					String m1="";
					if (tdate1 != null)	{
						String year = tdate1.substring(0, 4);
						String month = tdate1.substring(5, 7);
						if(month.equals("01")){
							m1="JAN";
						}
						if(month.equals("02")){
							m1="FEB";
						}
						if(month.equals("03")){
							m1="MAR";
						}
						if(month.equals("04")){
							m1="APR";
						}
						if(month.equals("05")){
							m1="MAY";
						}
						if(month.equals("06")){
							m1="JUN";
						}
						if(month.equals("07")){
							m1="JUL";
						}
						if(month.equals("08")){
							m1="AUG";
						}
						if(month.equals("09")){
							m1="SEP";
						}
						if(month.equals("10")){
							m1="OCT";
						}
						if(month.equals("11")){
							m1="NOV";
						}
						if(month.equals("12")){
							m1="DEC";
						}						
						String day = tdate1.substring(8, 10);
						tdate = day + "/" + m1 + "/" + year;
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
					query = "insert into RWS_WQ_BACKENDFTK_TESTTEMP_TBL(TestId,StateId,DistrictId,HabitationId,SourceId,Type,TestingDate,ContaminatedYes_No,ParameterType,PanchayatId)values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
					st7 = con.prepareStatement(query);
					st7.setString(1, FTK_ID);
					st7.setString(2, "002");
					st7.setString(3, rs3.getString("DistrictId"));
					st7.setString(4, rs3.getString("HabitationId"));
					st7.setString(5, source_code);
					st7.setString(6, "SC");
					st7.setString(7, tdate);
					st7.setString(8, contaminated);
					st7.setString(9, ttype);
					st7.setString(10, rs3.getString("Panchayatid"));	
					total += st7.executeUpdate();					
					if (st7 != null) {
						st7.close();
					}
				}
				if (st5 != null) {
					st5.close();
				}
			}			
			String upquery="";			
			String imisDataQuery = "select SCHEMESSOURCESID_IMIS ,b.SourceId  from RWS_IMIS_SCHEMESOURCES_TBL  a,RWS_WQ_BACKENDFTK_TESTTEMP_TBL b where a.SCHEMESOURCEID_STATE=b.SourceId";
			st8 = con.prepareStatement(imisDataQuery);
			rs4 = st8.executeQuery();
			while (rs4.next()) {
				upquery = "update RWS_WQ_BACKENDFTK_TESTTEMP_TBL a set a.SourceId= ? where a.SourceId= ? ";
				st9 = con.prepareStatement(upquery);
				st9.setString(1, rs4.getString(1));
				st9.setString(2, rs4.getString(2));
				st9.executeUpdate();
				if (st9 != null) {
					st9.close();
				}	
			}
			if (total > 0){
				flag1 = true;
			}
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Wq_Ftk_Access_DAO createFirstFTKTable : "+e.getMessage());
			e.printStackTrace();
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (rs1 != null) {
					rs1.close();
				}
				if (rs2 != null) {
					rs2.close();
				}
				if (rs3 != null) {
					rs3.close();
				}
				if (rs4 != null) {
					rs4.close();
				}
				if (st != null) {
					st.close();
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
				if (st8 != null) {
					st8.close();
				}						
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Wq_Ftk_Access_DAO createFirstFTKTable : "+e.getMessage());
			}
		}
		return flag1;
	}
	
	public boolean writeWQ_FTKTestingDetails_Tbl(Database database,Connection conn) {
		boolean flag = false;
		PreparedStatement st = null;
		ResultSet rs = null;
		Statement stmt = null;		
		try {
			String tableName = "BackEnd_Schemes_WQ_FTKTestingDetails";
			Table table1 = createTable(tableName).addColumn(
					new ColumnBuilder("TestId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("ParameterId").setSQLType(Types.VARCHAR).toColumn()).toTable(database);
			st = conn.prepareStatement("SELECT  TESTID ,PARAMETERID  FROM RWS_WQ_BACKENDFTK_TESTDTLS_TBL");
			rs = st.executeQuery();
			flag = RwsProjectShelfDAO.importResultSet(rs, table1);
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Wq_Ftk_Access_DAO writeWQ_FTKTestingDetails_Tbl : "+e.getMessage());
		} finally {
			try {			
				if (rs != null) {
					rs.close();
				}
				if (st != null) {
					st.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Wq_Ftk_Access_DAO writeWQ_FTKTestingDetails_Tbl : "+e.getMessage());
			}
		}
		return flag;
	}
	
	public boolean writeWQ_FTKWaterQualityTesting_Tbl(Database database, Connection conn) {
		boolean flag = false;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			String tableName = "BackEnd_Schemes_WQ_WaterQualityTesting"; 
			Table table1 = createTable(tableName).addColumn(
					new ColumnBuilder("TestId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("StateId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("DistrictId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("HabitationId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("SourceId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("Type").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("TestingDate").setSQLType(Types.DATE).toColumn()).addColumn(
					new ColumnBuilder("ContaminatedYes_No").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("ParameterType").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("PanchayatId").setSQLType(Types.VARCHAR).toColumn()).toTable(database);
			st = conn.prepareStatement("SELECT  * FROM RWS_WQ_BACKENDFTK_TESTTEMP_TBL");			
			rs = st.executeQuery();
			flag = RwsProjectShelfDAO.importResultSet(rs, table1);			
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Wq_Ftk_Access_DAO writeWQ_FTKWaterQualityTesting_Tbl : "+e.getMessage());
		} finally {
			try {		
				if (rs != null) {
					rs.close();
				}
				if (st != null) {
					st.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Wq_Ftk_Access_DAO writeWQ_FTKWaterQualityTesting_Tbl : "+e.getMessage());
			}
		}
		return flag;
	}
	
	public void insertFTKTestidCount(Connection con) {		 
		Statement st = null, st1 = null;
		int testid = 0;
		String Query = "";
		try {
			st = con.createStatement();
			st1 = con.createStatement();
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Wq_Ftk_Access_DAO insertFTKTestidCount : "+e.getMessage());
		}		
		finally {
			try {
				if (st != null) {
					st.close();
				}
				if (st1 != null) {
					st1.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Wq_Ftk_Access_DAO insertFTKTestidCount : "+e.getMessage());
			}
		}
	}
}
