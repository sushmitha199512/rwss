
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

import javax.servlet.http.HttpSession;

import nic.watersoft.commons.Debug;
import nic.watersoft.commons.RwsOffices;

import com.healthmarketscience.jackcess.ColumnBuilder;
import com.healthmarketscience.jackcess.Database;
import com.healthmarketscience.jackcess.DatabaseBuilder;
import com.healthmarketscience.jackcess.Table;
import com.healthmarketscience.jackcess.TableBuilder;
import com.healthmarketscience.jackcess.Database.FileFormat;
import com.healthmarketscience.jackcess.util.ImportUtil;

public class Rws_Mdb_File_Porting_DAO {

	public void createBankRelatedMdb(String filename){
		Connection conn=null;
		PreparedStatement stmt=null,stmt1=null,stmt2=null;
		ResultSet rs=null,rs1=null,rs2=null;
		String query="";
		try{
			conn=RwsOffices.getConn();	
			
			query="select * from RWS_BILL_BANK_BRIDGE_DET_TBL";
			stmt=conn.prepareStatement(query);			
			rs=stmt.executeQuery();
			Database db1 = DatabaseBuilder.create(Database.FileFormat.V2007, new File(filename));
			Database db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_BILL_BANK_BRIDGE_DET_TBL").importResultSet(rs);
			
			query="select * from RWS_BILL_PAO_BRIDGE_DET_TBL";
			stmt1=conn.prepareStatement(query);
			rs1=stmt1.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_BILL_PAO_BRIDGE_DET_TBL").importResultSet(rs1);			
			
			query="select WORK_ID,BILL_SL_NO,BILL_NO,BILL_DATE,BILL_AMT_CONTRACTOR,BILL_AMT_ADMISSIBLE,UPDATE_DATE,EE_FWD_DATE,BILL_TYPE,PARTA_ITEM_CODE,CM_BY_DEE,CM_MBOOK_PG_NO,CM_DT,SCM_BY_EE,SCM_MBOOK_PG_NO,SCM_DT,SCM_BY_SE,SCM_SE_MBOOK_PG_NO,SCM_SE_DT,BMS_TR_NO,BMS_TR_DATE  from RWS_WORK_BILL_TBL";
			stmt2=conn.prepareStatement(query);
			rs2=stmt2.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_WORK_BILL_TBL").importResultSet(rs2);
			
			db.close();
		}
		catch(Exception e){
			System.out.println("The Exception in Rws_Mdb_File_Porting_DAO in createBankRelatedMdb is  = "+e.getMessage());
		}
		finally{
			try{
				if(conn!=null){
					conn.close();
					stmt.close();
					stmt1.close();
					stmt2.close();
					rs.close();
					rs1.close();
					rs2.close();
				}
			}
			catch(Exception e){
				System.out.println("The Exception in Rws_Mdb_File_Porting_DAO in createBankRelatedMdb is  = "+e.getMessage());
			}
		}				
	}

	public void createWorkRelatedMdb(String filename){
		Connection conn=null;
		PreparedStatement stmt=null,stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null;
		ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null;
		String query="";
		try {
			conn=RwsOffices.getConn();	
			
			query="select * from RWS_WORK_ADMN_TBL";
			stmt=conn.prepareStatement(query);
			rs=stmt.executeQuery();
			Database db1 = DatabaseBuilder.create(Database.FileFormat.V2007,new File(filename));
			Database db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_WORK_ADMN_TBL").importResultSet(rs);	
	
			query="select * from RWS_WORK_COMMENCEMENT_TBL";
			stmt1=conn.prepareStatement(query);
			rs1=stmt1.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_WORK_COMMENCEMENT_TBL").importResultSet(rs1);	
	
			query="select * from RWS_WORK_COMPLETION_TBL";
			stmt2=conn.prepareStatement(query);
			rs2=stmt2.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_WORK_COMPLETION_TBL").importResultSet(rs2);			
			
			query="select * from RWS_WORK_EXP_VOUCHER_TBL";
			stmt3=conn.prepareStatement(query);
			rs3=stmt3.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_WORK_EXP_VOUCHER_TBL").importResultSet(rs3);	
	
			query="select WORK_ID,HAB_CODE,HOUSE_CONN,STAND_POSTS,round(DISTRIBUTION_LENGTH) as DISTRIBUTION_LENGTH from  RWS_WORK_COMP_HAB_LNK_TBL";
			stmt4=conn.prepareStatement(query);
			rs4=stmt4.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_WORK_COMP_HAB_LNK_TBL").importResultSet(rs4);			
			
			query="select * from RWS_ADMN_HAB_LNK_TBL";
			stmt5=conn.prepareStatement(query);
			rs5=stmt5.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_ADMN_HAB_LNK_TBL").importResultSet(rs5);
						
			query="select * from RWS_SOURCE_IDEN_FIN_TBL";
			stmt6=conn.prepareStatement(query);
			rs6=stmt6.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_SOURCE_IDEN_FIN_TBL").importResultSet(rs6);
			
			query="select * from RWS_CONTRACTOR_SELECTION_TBL";
			stmt7=conn.prepareStatement(query);
			rs7=stmt7.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_CONTRACTOR_SELECTION_TBL").importResultSet(rs7);
	
			
	
			db.close();
		}
		catch(Exception e){
			System.out.println("The Exception in Rws_Mdb_File_Porting_DAO in createWorkRelatedMdb is  = "+e.getMessage());
		}
		finally{
			try{
				if(conn!=null){					
					conn.close();
					stmt.close();
					stmt1.close();
					stmt2.close();
					stmt3.close();
					stmt4.close();
					stmt5.close();
					stmt6.close();
					stmt7.close();
					rs.close();
					rs1.close();
					rs2.close();
					rs3.close();
					rs4.close();
					rs5.close();
					rs6.close();
					rs7.close();
				}
			}
			catch(Exception e){
				System.out.println("The Exception in Rws_Mdb_File_Porting_DAO in createWorkRelatedMdb is  = "+e.getMessage());
			}
		}					
	}

	public void createHabRelatedMdb(String filename){
		Connection conn=null;
		PreparedStatement stmt=null,stmt1=null,stmt2=null;
		ResultSet rs=null,rs1=null,rs2=null;
		String query="";
		try{
			conn=RwsOffices.getConn();
			
			query="select CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE,HAB_CODE,CENSUS_YEAR,round(CENSUS_PLAIN_POPU) as CENSUS_PLAIN_POPU,round(CENSUS_SC_POPU) as CENSUS_SC_POPU,round(CENSUS_ST_POPU) as CENSUS_ST_POPU,round(FLOAT_POP) as FLOAT_POP,FLOAT_POP_REASONS,STATUS_DATE,round(PLAIN_POPU_COVERED) as PLAIN_POPU_COVERED,round(SC_POP_COVERED) as SC_POP_COVERED,round(ST_POP_COVERED) as ST_POP_COVERED,round(TOTAL_WATER_SUPPLY) as TOTAL_WATER_SUPPLY,EXIST_WATER_LEVEL,COVERAGE_STATUS,round(NEAR_SURFACE_SOURCE) as NEAR_SURFACE_SOURCE,round(NEAR_GROUND_SOURCE) as NEAR_GROUND_SOURCE,REMARKS,QUALITY_AFFECTED,UPDATE_DATE,PREVIOUS_YR_STATUS,PRESENT_YR_STATUS,PROPOSED_FC_YEAR,PROPOSED_FC_EST_AMT,HABITATION_TYPE,HOUSEHOLD_NO,SLIPPAGE_CODE,NO_OF_CATTLE,HABITATION_CATEGORY,EXISTING_SOURCES_NO,SAFE_SOURCES_NO,HABITATION_SUB_TYPE,NC_SOURCE_TYPE,SOURCE_DISTANCE,LPCD_COOKING,POPU_PERCENT_COVERED,MINORITY_DOMINATED,LWE,UNSAFE_LPCD,SAFE_LPCD,HAB_SUB_TYPE_40PC_CALC,TSP_NTSP, DDWS_HAB_CODE,NO_OF_HOUSECONN_GIVEN,IS_ITDA,round(HOUSEHOLDS_SC) as HOUSEHOLDS_SC,round(HOUSEHOLDS_ST) as HOUSEHOLDS_ST,round(HOUSEHOLDS_PLAIN) as HOUSEHOLDS_PLAIN,round(CON_SC) as CON_SC,round(CON_ST) as CON_ST,round(CON_PLAIN) as CON_PLAIN,HOUSEHOLDS_MINORITY,CON_MINORITY,MINORITY_POP_COVERED,CENSUS_MINORITY_POPU,NO_OF_PUBLIC_TAPS,NO_OF_TAPS_WITH_STANDPOSTS,NO_CHECKDAMS_REQ,NO_CHECKDAMS_EXIST,GLSR_NO,GLSR_QTY,OHSR_NO,OHSR_QTY,SCHEMESOURCE,ACT_PLAIN_POPU,ACT_SC_POPU,ACT_ST_POPU,ACT_HOUSE_HOLD,ACT_HOUSE_CONN,ACT_TOT_POPU,LPCD_ACT_POPU,ACT_COVERAGE_STATUS  from RWS_HABITATION_DIRECTORY_TBL";
			stmt=conn.prepareStatement(query);		
			rs=stmt.executeQuery();
			Database db1 = DatabaseBuilder.create(Database.FileFormat.V2007, new File(filename));
			Database db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_HABITATION_DIRECTORY_TBL").importResultSet(rs);		
			
			query="select * from RWS_HAB_SUPPLY_STATUS_TBL";
			stmt1=conn.prepareStatement(query);
			rs1=stmt1.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_HAB_SUPPLY_STATUS_TBL").importResultSet(rs1);
		
			query="select CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE,HAB_CODE,CENSUS_YEAR,round(CENSUS_PLAIN_POPU) as CENSUS_PLAIN_POPU,round(CENSUS_SC_POPU) as CENSUS_SC_POPU,round(CENSUS_ST_POPU) as CENSUS_ST_POPU,round(FLOAT_POP) as FLOAT_POP,FLOAT_POP_REASONS,STATUS_DATE,round(PLAIN_POPU_COVERED) as PLAIN_POPU_COVERED,round(SC_POP_COVERED) as SC_POP_COVERED,round(ST_POP_COVERED) as ST_POP_COVERED,round(TOTAL_WATER_SUPPLY) as TOTAL_WATER_SUPPLY,EXIST_WATER_LEVEL,COVERAGE_STATUS,round(NEAR_SURFACE_SOURCE) as NEAR_SURFACE_SOURCE,round(NEAR_GROUND_SOURCE) as NEAR_GROUND_SOURCE,REMARKS,QUALITY_AFFECTED,UPDATE_DATE,PREVIOUS_YR_STATUS,PRESENT_YR_STATUS,PROPOSED_FC_YEAR,PROPOSED_FC_EST_AMT,HABITATION_TYPE,HOUSEHOLD_NO,SLIPPAGE_CODE,NO_OF_CATTLE,HABITATION_CATEGORY,EXISTING_SOURCES_NO,SAFE_SOURCES_NO,HABITATION_SUB_TYPE,NC_SOURCE_TYPE,SOURCE_DISTANCE,LPCD_COOKING,POPU_PERCENT_COVERED,MINORITY_DOMINATED,LWE,UNSAFE_LPCD,SAFE_LPCD,HAB_SUB_TYPE_40PC_CALC,TSP_NTSP, DDWS_HAB_CODE,NO_OF_HOUSECONN_GIVEN,IS_ITDA,round(HOUSEHOLDS_SC) as HOUSEHOLDS_SC,round(HOUSEHOLDS_ST) as HOUSEHOLDS_ST,round(HOUSEHOLDS_PLAIN) as HOUSEHOLDS_PLAIN,round(CON_SC) as CON_SC,round(CON_ST) as CON_ST,round(CON_PLAIN) as CON_PLAIN,HOUSEHOLDS_MINORITY,CON_MINORITY,MINORITY_POP_COVERED,CENSUS_MINORITY_POPU,NO_OF_PUBLIC_TAPS,NO_OF_TAPS_WITH_STANDPOSTS,NO_CHECKDAMS_REQ,NO_CHECKDAMS_EXIST,GLSR_NO,GLSR_QTY,OHSR_NO,OHSR_QTY,SCHEMESOURCE,ACT_PLAIN_POPU,ACT_SC_POPU,ACT_ST_POPU,ACT_HOUSE_HOLD,ACT_HOUSE_CONN,ACT_TOT_POPU,LPCD_ACT_POPU,ACT_COVERAGE_STATUS  from RWS_HABITATION_DIR_DYNA_TBL";
			stmt2=conn.prepareStatement(query);
			rs2=stmt2.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_HABITATION_DIR_DYNA_TBL").importResultSet(rs2);
			
			db.close();
		}		
		catch(Exception e){
			System.out.println("The Exception in Rws_Mdb_File_Porting_DAO in createHabRelatedMdb is  = "+e.getMessage());
		}		
		finally{
			try{
				if(conn!=null){
					conn.close();
				}
			}
			catch(Exception e){
				System.out.println("The Exception in Rws_Mdb_File_Porting_DAO in createHabRelatedMdb is  = "+e.getMessage());
			}
		}			
	}
	
	public void createSourceRelatedMdb(String filename){
		Connection conn=null;
		PreparedStatement stmt=null,stmt1=null,stmt2=null,stmt3=null,stmt4=null,stmt5=null,stmt6=null,stmt7=null,stmt8=null,stmt9=null,stmt10=null,stmt11=null,stmt12=null,stmt13=null,stmt14=null,stmt15=null,stmt16=null,stmt17=null,stmt18=null,stmt19=null,stmt20=null,stmt21=null,stmt22=null,stmt23=null;
		ResultSet rs=null,rs1=null,rs2=null,rs3=null,rs4=null,rs5=null,rs6=null,rs7=null,rs8=null,rs9=null,rs10=null,rs11=null,rs12=null,rs13=null,rs14=null,rs15=null,rs16=null,rs17=null,rs18=null,rs19=null,rs20=null,rs21=null,rs22=null,rs23=null;
		String query="";
		try{
			conn=RwsOffices.getConn();
			
			Database db1 = DatabaseBuilder.create(Database.FileFormat.V2007, new File(filename));
			
			query="select SOURCE_CODE,SOURCE_NAME,SOURCE_TYPE_CODE,SUBSOURCE_TYPE_CODE,HAB_CODE,NO_OF_HABITAITONS_COVERD,POPULATION_BENIFITED,SEASONAL,WATER_QUALITY,STATIC_WATER_LEVEL,SUMMER_WATER_LEVEL,YIELD,DIST_NEAR_PRIVATE_SOURCE,LOCATION,CIRCLE_OFFICE_CODE,DIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_CODE,DEPTH,DIAMETER,SOURCE_CONDITION,TYPE,ASSET_CODE,ALT_WATER_SOURCE_DET,LATITUDE,LONGITUDE,ELEVATION,WAY_POINT,STATUS,round(SAFE_LPD) as SAFE_LPD,round(UNSAFE_LPD) as UNSAFE_LPD,FLOURIDE,BRAKISH,IRON,NITRATE,REMARKS,UPDATE_DATE,SOURCE_DETAILS,PLATFORM_EXISTING,SOAK_PIT from RWS_SOURCE_TBL";
			stmt=conn.prepareStatement(query);
			rs=stmt.executeQuery();
			Database db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_SOURCE_TBL").importResultSet(rs);	
	
			query="select * from RWS_OPENWELL_POND_TBL";
			stmt1=conn.prepareStatement(query);
			rs1=stmt1.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_OPENWELL_POND_TBL").importResultSet(rs1);	
	
			query="select HABITATION_CODE,OPENWELL_CODE,LOCATION,DIAMETER,DEPTH,NORMAL_WATER_LEVEL,MIN_WATER_LEVEL,MAX_WATER_LEVEL,PLATFORM_EXISTS,PLATFORM_CONDITION,PURPOSE,QUALITY,FLOURIDE_PER,BRAKISH_PER,IRON_PER,OTHER_TYPE,OTHER_PER,RAD_FLOURIDE,RAD_BRAKISH,RAD_IRON,RAD_OTHERS,ASSET_CODE,LATITUDE,LONGITUDE,ELEVATION,WAY_POINT,round(SAFE_LPD) as SAFE_LPD,round(UNSAFE_LPD) as UNSAFE_LPD,NITRATE,REMARKS,STATUS,UPDATE_DATE,REPAIR_DATE,PLATFORM_EXISTING,SOAK_PIT from RWS_OPEN_WELL_MAST_TBL";
			stmt2=conn.prepareStatement(query);
			rs2=stmt2.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_OPEN_WELL_MAST_TBL").importResultSet(rs2);			
			
			query="select * from RWS_AST_SUBCOMP_PARAM_TBL";
			stmt3=conn.prepareStatement(query);
			rs3=stmt3.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_AST_SUBCOMP_PARAM_TBL").importResultSet(rs3);	
	
			query="select * from  RWS_AST_RW_COLLWELL_PARAM_TBL";
			stmt4=conn.prepareStatement(query);
			rs4=stmt4.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_AST_RW_COLLWELL_PARAM_TBL").importResultSet(rs4);				
			
			query="select * from RWS_AST_SS_SC_PARAM_TBL";
			stmt5=conn.prepareStatement(query);
			rs5=stmt5.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_AST_SS_SC_PARAM_TBL").importResultSet(rs5);
			
			query="select * from RWS_AST_WTP_SC_PARAM_TBL";
			stmt6=conn.prepareStatement(query);
			rs6=stmt6.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_AST_WTP_SC_PARAM_TBL").importResultSet(rs6);
			
			query="select * from RWS_AST_SUMP_M_SC_PARAM_TBL";
			stmt7=conn.prepareStatement(query);
			rs7=stmt7.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_AST_SUMP_M_SC_PARAM_TBL").importResultSet(rs7);
			
			query="select * from RWS_AST_FP_BRIDGE_PARAM_TBL";
			stmt8=conn.prepareStatement(query);
			rs8=stmt8.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_AST_FP_BRIDGE_PARAM_TBL").importResultSet(rs8);
			
			query="select * from RWS_AST_PUMPHOUSE_PARAM_TBL";
			stmt9=conn.prepareStatement(query);
			rs9=stmt9.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_AST_PUMPHOUSE_PARAM_TBL").importResultSet(rs9);
			
			query="select * from RWS_AST_WATCHMAN_PARAM_TBL";
			stmt10=conn.prepareStatement(query);
			rs10=stmt10.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_AST_WATCHMAN_PARAM_TBL").importResultSet(rs10);
			
			query="select * from RWS_AST_CW_COLLWELL_PARAM_TBL";
			stmt11=conn.prepareStatement(query);
			rs11=stmt11.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_AST_CW_COLLWELL_PARAM_TBL").importResultSet(rs11);
			
			query="select * from RWS_AST_PUMPINGMAIN_TBL";
			stmt12=conn.prepareStatement(query);
			rs12=stmt12.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_AST_PUMPINGMAIN_TBL").importResultSet(rs12);
			
			query="select * from RWS_AST_GRAVITYMAIN_TBL";
			stmt13=conn.prepareStatement(query);
			rs13=stmt13.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_AST_GRAVITYMAIN_TBL").importResultSet(rs13);
			
			query="select * from RWS_AST_DISTRI_SC_PARAM_TBL";
			stmt14=conn.prepareStatement(query);
			rs14=stmt14.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_AST_DISTRI_SC_PARAM_TBL").importResultSet(rs14);
			
			query="select * from RWS_AST_OHSR_SC_PARAM_TBL";
			stmt15=conn.prepareStatement(query);
			rs15=stmt15.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_AST_OHSR_SC_PARAM_TBL").importResultSet(rs15);
			
			query="select * from RWS_AST_OHBR_SC_PARAM_TBL";
			stmt16=conn.prepareStatement(query);
			rs16=stmt16.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_AST_OHBR_SC_PARAM_TBL").importResultSet(rs16);
			
			query="select * from RWS_AST_GLSR_SC_PARAM_TBL";
			stmt17=conn.prepareStatement(query);
			rs17=stmt17.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_AST_GLSR_SC_PARAM_TBL").importResultSet(rs17);
			
			query="select * from RWS_AST_GLBR_SC_PARAM_TBL";
			stmt18=conn.prepareStatement(query);
			rs18=stmt18.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_AST_GLBR_SC_PARAM_TBL").importResultSet(rs18);
			
			query="select * from RWS_AST_BPT_PARAM_TBL";
			stmt19=conn.prepareStatement(query);
			rs19=stmt19.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_AST_BPT_PARAM_TBL").importResultSet(rs19);
			
			query="select * from RWS_AST_CIS_SC_PARAM_TBL";
			stmt20=conn.prepareStatement(query);
			rs20=stmt20.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_AST_CIS_SC_PARAM_TBL").importResultSet(rs20);
			
			query="select * from RWS_AST_OTHERS_PARAM_TBL";
			stmt21=conn.prepareStatement(query);
			rs21=stmt21.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_AST_OTHERS_PARAM_TBL").importResultSet(rs21);
			
			query="select LOCATION,DRILL_YEAR,DIAMETER,CASING,STATUS,GEN_CONDITION,GI_NO,PAINTED,STATIC_WL,SUMMER_WL,P_COND,DRY_DURING,SERVICE,SER_NO,SER_HRS,REPAIRS,PLATFORM_CONDITION,DRAIN,DRAIN_CONDITION,DRAIN_SD,DRAIN_LP,HYGIENE,AVG_TIME,P_YEILD,PYEILD_LOCAL,PERIOD,ASSET_CODE,DEPTH,HP_CODE,QUALITY_AFFECTED,FLOURIDE,BRAKISH,IRON,OTHERS_SPECIFY_TYPE,CONT_OTHERS_TYPE,CONT_OTHERS_PER,PLATFORM_EXISTING,WATERQUALITY,PIPE_LENGTH,LATITUDE,LONGITUDE,ELEVATION,WAY_POINT,round(SAFE_LPD) as SAFE_LPD,round(UNSAFE_LPD) as UNSAFE_LPD,NITRATE,REMARKS,UPDATE_DATE,REPAIR_DATE,REPAIR_DESC,SOAK_PIT from RWS_HP_SUBCOMP_PARAM_TBL";
			stmt22=conn.prepareStatement(query);
			rs22=stmt22.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_HP_SUBCOMP_PARAM_TBL").importResultSet(rs22);
			
			query="select HAB_CODE,SHALLOWHP_CODE,LOCATION,DIAMETER,DEPTH,HYGIENE,AVERAGE_HOURS,AVERAGE_TIME,YIELD,WATER_QUALITY,FLORIDE_PER,BRAKISH_PER,IRON_PER,OTHERS_PER,ASSET_CODE,FLORIDE,BRAKISH,IRON,OTHERS,LATITUDE,LONGITUDE,ELEVATION,WAY_POINT,round(SAFE_LPD) as SAFE_LPD,round(UNSAFE_LPD) as UNSAFE_LPD,NITRATE_PER,REMARKS,STATUS,UPDATE_DATE,REPAIR_DATE,REPAIR_DESC,PLATFORM_EXISTING,SOAK_PIT from RWS_SHALLOWHANDPUMPS_TBL";
			stmt23=conn.prepareStatement(query);
			rs23=stmt23.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_SHALLOWHANDPUMPS_TBL").importResultSet(rs23);
			db.close();
		}
		catch(Exception e){
			System.out.println("The Exception in Rws_Mdb_File_Porting_DAO in createSourceRelatedMdb is  = "+e.getMessage());
		}
		finally{
			try{
				if(conn!=null){
					conn.close();
					stmt.close();
					stmt1.close();
					stmt2.close();
					stmt3.close();
					stmt4.close();
					stmt5.close();
					stmt6.close();
					stmt7.close();
					stmt8.close();
					stmt9.close();
					stmt10.close();
					stmt11.close();
					stmt12.close();
					stmt13.close();
					stmt14.close();
					stmt15.close();
					stmt16.close();
					stmt17.close();
					stmt18.close();
					stmt19.close();
					stmt20.close();
					stmt21.close();
					stmt22.close();
					stmt23.close();					
					rs.close();
					rs1.close();
					rs2.close();
					rs3.close();
					rs4.close();
					rs5.close();
					rs6.close();
					rs7.close();
					rs8.close();
					rs9.close();
					rs10.close();
					rs11.close();
					rs12.close();
					rs13.close();
					rs14.close();
					rs15.close();
					rs16.close();
					rs17.close();
					rs18.close();
					rs19.close();
					rs20.close();
					rs21.close();
					rs22.close();
					rs23.close();					
				}
			}
			catch(Exception e){
				System.out.println("The Exception in Rws_Mdb_File_Porting_DAO in createSourceRelatedMdb is  = "+e.getMessage());
			}
		}				
	}
	
	public void createAssetRelatedMdb(String filename){
		Connection conn=null;
		PreparedStatement stmt=null,stmt1=null;
		ResultSet rs=null,rs1=null;
		String query="";
		try{
			conn=RwsOffices.getConn();			
			
			query="select * from RWS_ASSET_MAST_TBL where substr(HAB_CODE,1,2) in ('01','02','03','04','05','06','07','08','09','10','11','12','13')";
			stmt=conn.prepareStatement(query);
			rs=stmt.executeQuery();
			Database db1 = DatabaseBuilder.create(Database.FileFormat.V2007, new File(filename));
			Database db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_ASSET_MAST_TBL").importResultSet(rs);
			
			query="select * from RWS_ASSET_HAB_TBL";
			stmt1=conn.prepareStatement(query);
			rs1=stmt1.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_ASSET_HAB_TBL").importResultSet(rs1);
	
			db.close();
		}
		catch(Exception e){
			System.out.println("The Exception in Rws_Mdb_File_Porting_DAO in createAssetRelatedMdb is  = "+e.getMessage());
		}
		finally{
			try{
				if(conn!=null){
					conn.close();
					stmt.close();
					stmt1.close();					
					rs.close();
					rs1.close();					
				}
			}
			catch(Exception e){
				System.out.println("The Exception in Rws_Mdb_File_Porting_DAO in createAssetRelatedMdb is  = "+e.getMessage());
			}
		}				
	}
	
	public void createDroughtRelatedMdb(String filename){
		Connection conn=null;
		PreparedStatement stmt=null,stmt1=null,stmt2=null;
		ResultSet rs=null,rs1=null,rs2=null;
		String query="";
		try{
			conn=RwsOffices.getConn();			
			
			query="select * from RWS_DROUGHT_WORKS_TBL";
			stmt=conn.prepareStatement(query);
			rs=stmt.executeQuery();
			Database db1 = DatabaseBuilder.create(Database.FileFormat.V2007, new File(filename));
			Database db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_DROUGHT_WORKS_TBL").importResultSet(rs);
			
			query="select * from RWS_DROUGHT_FLUSH_DEEPEN_TBL";
			stmt1=conn.prepareStatement(query);
			rs1=stmt1.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_DROUGHT_FLUSH_DEEPEN_TBL").importResultSet(rs1);
			
			query="select * from RWS_DROUGHT_HABITATION_TBL";
			stmt2=conn.prepareStatement(query);
			rs2=stmt2.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_DROUGHT_HABITATION_TBL").importResultSet(rs2);		
	
			db.close();
		}
		catch(Exception e){
			System.out.println("The Exception in Rws_Mdb_File_Porting_DAO in createDroughtRelatedMdb is  = "+e.getMessage());
		}
		finally{
			try{
				if(conn!=null){
					conn.close();
					stmt.close();
					stmt1.close();
					stmt2.close();					
					rs.close();
					rs1.close();
					rs2.close();					
				}
			}
			catch(Exception e){
				System.out.println("The Exception in Rws_Mdb_File_Porting_DAO in createDroughtRelatedMdb is  = "+e.getMessage());
			}
		}				
	}
	
	public void createSchoolRelatedMdb(String filename){  
		Connection conn=null;
		PreparedStatement stmt=null,stmt1=null,stmt2=null;
		ResultSet rs=null,rs1=null,rs2=null;
		String query="";
		try{
			conn=RwsOffices.getConn();
			
			query="select * from RWS_SCHOOL_MASTER_TBL";
			stmt=conn.prepareStatement(query);
			rs=stmt.executeQuery();
			Database db1 = DatabaseBuilder.create(Database.FileFormat.V2007, new File(filename));
			Database db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_SCHOOL_MASTER_TBL").importResultSet(rs);
	
			query="select * from RWS_WORK_SCHOOL_LNK_TBL";
			stmt1=conn.prepareStatement(query);
			rs1=stmt1.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_WORK_SCHOOL_LNK_TBL").importResultSet(rs1);	
			
			query="select * from RWS_SCHOOL_ASSET_LNK_TBL";
			stmt2=conn.prepareStatement(query);
			rs2=stmt2.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_SCHOOL_ASSET_LNK_TBL").importResultSet(rs2);		
			
			db.close();
		}
		catch(Exception e){
			System.out.println("The Exception in Rws_Mdb_File_Porting_DAO in createSchoolRelatedMdb is  = "+e.getMessage());
		}
		finally{
			try{
				if(conn!=null){
					conn.close();
					stmt.close();
					stmt1.close();
					stmt2.close();					
					rs.close();
					rs1.close();
					rs2.close();					
				}
			}
			catch(Exception e){
				System.out.println("The Exception in Rws_Mdb_File_Porting_DAO in createSchoolRelatedMdb is  = "+e.getMessage());
			}
		}			
	}
	
	public void createYDURelatedMdb(String filename){  
		Connection conn=null;
		PreparedStatement stmt=null,stmt1=null,stmt2=null,stmt3=null;
		ResultSet rs=null,rs1=null,rs2=null,rs3=null;
		String query="";
		try{
			conn=RwsOffices.getConn();		
			//			query="select DCODE,DNAME,MCODE,MNAME,PCODE,PNAME,VCODE,VNAME,PANCH_CODE,PANCH_NAME,PREVIOUS_YR_STATUS,COVERAGE_STATUS,round(CENSUS_PLAIN_POPU),round(CENSUS_SC_POPU),round(CENSUS_ST_POPU),EXIST_WATER_LEVEL,UNSAFE_LPCD,SAFE_LPCD,HABITATION_SUB_TYPE,HAB_SUB_TYPE_40PC_CALC from RWS_COMPLETE_HAB_VIEW";

			query="select DCODE,DNAME,MCODE,MNAME,PCODE,PNAME,VCODE,VNAME,PANCH_CODE,PANCH_NAME,PREVIOUS_YR_STATUS,COVERAGE_STATUS,round(CENSUS_PLAIN_POPU),round(CENSUS_SC_POPU),round(CENSUS_ST_POPU),EXIST_WATER_LEVEL,UNSAFE_LPCD,SAFE_LPCD,HABITATION_SUB_TYPE,HAB_SUB_TYPE_40PC_CALC,ACT_PLAIN_POPU,ACT_SC_POPU,ACT_ST_POPU,ACT_HOUSE_HOLD,ACT_HOUSE_CONN,ACT_TOT_POPU,LPCD_ACT_POPU,ACT_COVERAGE_STATUS from RWS_COMPLETE_HAB_VIEW";
			stmt=conn.prepareStatement(query);
			rs=stmt.executeQuery();
			Database db1 = DatabaseBuilder.create(Database.FileFormat.V2007, new File(filename));
			Database db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_COMPLETE_HAB_VIEW").importResultSet(rs);
	
			//query="select * from RWS_PANCHAYAT_RAJ_TBL";
			query="select HAB_CODE,PANCH_CODE,PANCH_NAME,LATITUDE,LONGITUDE,ELEVATION,WAY_POINT,LANDMARK from RWS_PANCHAYAT_RAJ_TBL";

			//query="select * from RWS_PANCHAYAT_RAJ_TBL";
			stmt1=conn.prepareStatement(query);
			rs1=stmt1.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_PANCHAYAT_RAJ_TBL").importResultSet(rs1);
			
			query="select * from  RWS_HAB_CONTAMINATION_TBL";
			stmt2=conn.prepareStatement(query);
			rs2=stmt2.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_HAB_CONTAMINATION_TBL").importResultSet(rs2);
			
			//query="select DCODE,DNAME,MCODE,MNAME,PCODE,PNAME,VCODE,VNAME,PANCH_CODE,PANCH_NAME,PREVIOUS_YR_STATUS,COVERAGE_STATUS,round(CENSUS_PLAIN_POPU),round(CENSUS_SC_POPU),round(CENSUS_ST_POPU),EXIST_WATER_LEVEL,UNSAFE_LPCD,SAFE_LPCD,HABITATION_SUB_TYPE,HAB_SUB_TYPE_40PC_CALC from RWS_COMPLETE_HAB_DYNA_VIEW";
			query="select DCODE,DNAME,MCODE,MNAME,PCODE,PNAME,VCODE,VNAME,PANCH_CODE,PANCH_NAME,PREVIOUS_YR_STATUS,COVERAGE_STATUS,round(CENSUS_PLAIN_POPU),round(CENSUS_SC_POPU),round(CENSUS_ST_POPU),EXIST_WATER_LEVEL,UNSAFE_LPCD,SAFE_LPCD,HABITATION_SUB_TYPE,HAB_SUB_TYPE_40PC_CALC,ACT_PLAIN_POPU,ACT_SC_POPU,ACT_ST_POPU,ACT_HOUSE_HOLD,ACT_HOUSE_CONN,ACT_TOT_POPU,LPCD_ACT_POPU,ACT_COVERAGE_STATUS from RWS_COMPLETE_HAB_DYNA_VIEW";
			stmt3=conn.prepareStatement(query);
			rs3=stmt3.executeQuery();
			db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_COMPLETE_HAB_DYNA_VIEW").importResultSet(rs3);
			
			db.close();
		}
		catch(Exception e){
			System.out.println("The Exception in Rws_Mdb_File_Porting_DAO in createYDURelatedMdb is  = "+e.getMessage());
		}
		finally{
			try{
				if(conn!=null){
					rs.close();
					rs3.close();
					rs1.close();
					rs2.close();
					
					stmt3.close();
					stmt.close();
					stmt1.close();
					stmt2.close();
					
					conn.close();
				}
			}
			catch(Exception e){
				System.out.println("The Exception in Rws_Mdb_File_Porting_DAO in createYDURelatedMdb is  = "+e.getMessage());
			}
		}				
	}
	
	public void createTotalHabitationsRelatedTable(String filename){
		Connection conn=null;
		PreparedStatement stmt=null,stmt1=null,stmt2=null;
		ResultSet rs=null,rs1=null,rs2=null;
		String query="";
		try{
			conn=RwsOffices.getConn();			
			
			query="select DCODE,DNAME,MCODE,MNAME,PCODE,PNAME,VCODE,VNAME,PANCH_CODE,PANCH_NAME, COVERAGE_STATUS,DIVISION_OFFICE_CODE,DIVISION_OFFICE_NAME,SUBDIVISION_OFFICE_CODE,SUBDIVISION_OFFICE_NAME,CONSTITUENCY_CODE,CONSTITUENCY_NAME,CENSUS_PLAIN_POPU,CENSUS_SC_POPU ,CENSUS_ST_POPU,CENSUS_MINORITY_POPU,CENSUS_TOT_POPU,HOUSEHOLD_NO,NO_OF_HOUSECONN_GIVEN,CPWS_NO,CPWS_NAME,CPWS_HAB_SCHEME_NO,CPWS_HAB_SCHEME_NAME,CPWS_SUPPLY,PWS_NO,PWS_NAME,PWS_HAB_SCHEME_NO,PWS_HAB_SCHEME_NAME,PWS_SUPPLY_SAFE,PWS_SUPPLY_UNSAFE,MPWS_NO,MPWS_NAME,MPWS_HAB_SCHEME_NO,MPWS_HAB_SCHEME_NAME,MPWS_SUPPLY_SAFE,MPWS_SUPPLY_UNSAFE,HANDPUMP_NO,HANDPUMP_SUPPLY_SAFE,HANDPUMP_SUPPLY_UNSAFE,SHALLOW_HANDPUMP_NO,SHALLOW_HP_SUPPLY_SAFE,SHALLOW_HP_SUPPLY_UNSAFE,DIRECT_PUMPING_NO,DIRECT_PUMPING_SUPPLY_SAFE,OPENWELL_NO,OPENWELL_SUPPLY,SPRINGS_NO,SPRINGS_SUPPLY,OTHERS_NO,OTHERS_SUPPLY,NO_OF_GLSRS,NO_OF_CISTERNS,NO_OF_OHSRS,NO_OF_PUMPSETS,NO_OF_SSF,NO_OF_RSF,NO_OF_SSTANKS,NO_OF_MICROFILTERS,NO_OF_ROPLANTS,NO_OF_SOLARSCHEMES,CONTAMINATION_TYPE,STRESSED_HABS from RWS_HAB_SCHEME_SRC_DATA_TBL";
			stmt=conn.prepareStatement(query);
			rs=stmt.executeQuery();
			Database db1 = DatabaseBuilder.create(Database.FileFormat.V2007, new File(filename));
			Database db = DatabaseBuilder.open(new File(filename));
			new ImportUtil.Builder(db, "RWS_HAB_SCHEME_SRC_DATA_TBL").importResultSet(rs);	
			
			db.close();
		}
		catch(Exception e){
			System.out.println("The Exception in Rws_Mdb_File_Porting_DAO in createTotalHabitationsRelatedTable is  = "+e.getMessage());
		}
		finally{
			try{
				if(conn!=null){
					conn.close();
					stmt.close();					
					rs.close();					
				}
			}
			catch(Exception e){
				System.out.println("The Exception in Rws_Mdb_File_Porting_DAO in createTotalHabitationsRelatedTable is  = "+e.getMessage());
			}
		}				
	}
}