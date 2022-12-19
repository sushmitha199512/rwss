
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

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.healthmarketscience.jackcess.ColumnBuilder;
import com.healthmarketscience.jackcess.Database;
import com.healthmarketscience.jackcess.DatabaseBuilder;
import com.healthmarketscience.jackcess.Table;
import com.healthmarketscience.jackcess.TableBuilder;
import com.healthmarketscience.jackcess.Database.FileFormat;


public class Rws_Mpr_Access_DAO {
	
	public boolean createFinancialMPR(String fromDate, String toDate, Connection conn) throws SQLException {
		PreparedStatement bankStmt = null;
		Statement bankBatchStmt = conn.createStatement();
		PreparedStatement stateStmt = null;
		Statement stateBatchStmt =conn.createStatement();
		isTableExists("BACKEND_FINMPRSCHEME", conn, "create table Backend_FinMPRScheme(StateId varchar2(3) not null,DistrictId	varchar2(5) not null,IMIS_SchemeId varchar2(16) not null ,MonthId	number(2) not null,YearId	number(4)	not null,ProgrammeComponent	number(2) not null,SCGOIExpenditure 	number(11,2) ,STGOIExpenditure		number(11,2) ,GENGOIExpenditure	number(11,2) ,SCGOIExpenditureSchool number(11,2) ,STGOIExpenditureSchool number(11,2) ,GENGOIExpenditureSchool	number(11,2) ,SCStateExpenditure	number(11,2) ,STStateExpenditure	number(11,2) ,GENStateExpenditure	number(11,2) ,SCStateExpenditureSchool	number(11,2) ,STStateExpenditureSchool	number(11,2) ,GENStateExpenditureSchool	number(11,2) ,SCCommunityExpenditure number(11,2),STCommunityExpenditure	number(11,2) ,GENCommunityExpenditure	number(11,2) ,SCCommunityExpenditureSchool	number(11,2) ,STCommunityExpenditureSchool	number(11,2) ,GENCommunityExpenditureSchool	number(11,2) ,SCDDPExpenditure	number(11,2) ,STDDPExpenditure	number(11,2) ,GENDDPExpenditure	number(11,2) ,SCDDPExpenditureSchool	number(11,2) ,STDDPExpenditureSchool	number(11,2) ,GENDDPExpenditureSchool	number(11,2) , SCNCEFExpenditure number(11,2)  , STNCEFExpenditure  number(11,2), GENNCEFExpenditure number(11,2),SCNCEFExpenditureSchool number(11,2), STNCEFExpenditureSchool number(11,2),GENNCEFExpenditureSchool number(11,2), ExpectedDateOfCompletion	Date,PhysicalDateOfCompletion	Date,FinancialDateOfCompletion	Date,HandedOverToCommunityDate Date,FullyHandedOverToOM	number(4),FundingSupport number(4),schemeid_state varchar2(14))");
		isTableExists("create table SchemeExpenditure(SCHEMEID VARCHAR2(14),SCHEMENAME VARCHAR2(100),YEARID VARCHAR2(4) ,MONTHID VARCHAR2(4),DISTRICTID VARCHAR2(5),PROGRAMMEID VARCHAR2(2),PROGRAMMENAME VARCHAR2(100),GOISCEXPENDITURE NUMBER(11,2),GOISTEXPENDITURE NUMBER(11,2),GOIGENEXPENDITURE NUMBER(11,2),GOISCHOOLSCEXPENDITURE NUMBER(11,2),GOISCHOOLSTEXPENDITURE NUMBER(11,2),GOISCHOOLGENEXPENDITURE NUMBER(11,2),STATESCEXPENDITURE NUMBER(11,2),STATESTEXPENDITURE NUMBER(11,2),STATEGENEXPENDITURE NUMBER(11,2),STATESCHOOLSCEXPENDITURE NUMBER(11,2),STATESCHOOLSTEXPENDITURE NUMBER(11,2),STATESCHOOLGENEXPENDITURE NUMBER(11,2),DDPSCEXPENDITURE NUMBER(11,2),DDPSTEXPENDITURE NUMBER(11,2),DDPGENEXPENDITURE NUMBER(11,2),DDPSCHOOLSCEXPENDITURE NUMBER(11,2),DDPSCHOOLSTEXPENDITURE NUMBER(11,2) ,DDPSCHOOLGENEXPENDITURE NUMBER(11,2) ,COMMUNITYSCEXPENDITURE NUMBER(11,2),COMMUNITYSTEXPENDITURE NUMBER(11,2) ,COMMUNITYGENEXPENDITURE NUMBER(11,2) ,COMMUNITYSCHOOLSCEXPENDITURE NUMBER(11,2) ,COMMUNITYSCHOOLSTEXPENDITURE NUMBER(11,2) ,COMMUNITYSCHOOLGENEXPENDITURE NUMBER(11,2),SCNCEFExpenditure number(11,2)  ,STNCEFExpenditure number(11,2), GENNCEFExpenditure number(11,2) ,SCNCEFExpenditureSchool number(11,2), STNCEFExpenditureSchool number(11,2),GENNCEFExpenditureSchool number(11,2))", conn, "SCHEMEEXPENDITURE");
		isTableExists("create table Bank_Pao_exp_porting_tbl(WORK_ID varchar2(14),SumOfBILL_AMOUNT_CENTRAL number(11,2),NO_OF_HABS varchar2(3),WORK_NAME varchar2(100),DistrictId varchar2(5),month varchar2(5),CATEGORY_CODE varchar2(1))", conn, "BANK_PAO_EXP_PORTING_TBL");
		
		String bankQuery = "SELECT  A.WORK_ID ,SUM(A.BILL_AMOUNT_CENTRAL),nvl(B.NO_OF_HABS,''),B.WORK_NAME,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20','0022','21','0023','22','0024','23','0025')as dcode,b.category_code,to_char(A.BANK_SEND_DATE ,'mm'),to_char(A.BANK_SEND_DATE ,'yyyy')  FROM RWS_BILL_BANK_BRIDGE_DET_TBL A,RWS_WORK_ADMN_TBL B  WHERE  b.PROGRAMME_CODE<>'27' and  A.TXID IS NOT NULL AND A.WORK_ID=B.WORK_ID and TO_DATE(a.bank_send_date)>= ? and TO_DATE(a.bank_send_date)<= ? GROUP BY A.WORK_ID,B.NO_OF_HABS,B.WORK_NAME,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20','0022','21','0023','22','0024','23','0025'),b.category_code,to_char(A.BANK_SEND_DATE ,'mm'),to_char(A.BANK_SEND_DATE ,'yyyy')";
		bankStmt = conn.prepareStatement(bankQuery);
		bankStmt.setString(1, fromDate);
		bankStmt.setString(2, toDate);
		ResultSet rsBank = bankStmt.executeQuery();
		while (rsBank.next()) {
			String workId = rsBank.getString(1);
			double amt = rsBank.getDouble(2);
			String nohabs = rsBank.getString(3) != null && (rsBank.getString(3).equals("null") || rsBank.getString(3).equals("")) ? "0" : rsBank.getString(3);
			String wname = rsBank.getString(4);
			String dcode = rsBank.getString(5);
			String catcode = rsBank.getString(6);
			String month = rsBank.getString(7);
			String insertquery = "insert into Bank_Pao_exp_porting_tbl values ('"+workId+"',"+amt+ ",'"+nohabs+"','"+wname+ "','"+dcode+"','"+month+"','"+catcode+"')";
			bankBatchStmt.addBatch(insertquery);
		}
		
		String stateQuery = "SELECT A.WORK_ID, SUM(A.BILL_AMOUT_STATE),nvl(B.NO_OF_HABS,''),B.WORK_NAME,c.districtId,b.category_code,to_char(A.state_SEND_DATE ,'mm'),to_char(A.state_SEND_DATE ,'yyyy')  FROM RWS_BILL_PAO_BRIDGE_DET_TBL A, RWS_WORK_ADMN_TBL B,rws_delhi_district_list_tbl c WHERE c.dcode=substr(b.work_id,5,2) and b.PROGRAMME_CODE<>'27' and TO_DATE(a.state_send_date)>= ? and TO_DATE(a.state_send_date)<= ? AND A.STATE_TXID IS NOT NULL  AND A.WORK_ID=B.WORK_ID  GROUP BY A.WORK_ID,B.NO_OF_HABS,B.WORK_NAME,c.districtId,b.category_code,to_char(A.state_SEND_DATE ,'mm'),to_char(A.state_SEND_DATE ,'yyyy')";
		stateStmt = conn.prepareStatement(stateQuery);
		stateStmt.setString(1, fromDate);
		stateStmt.setString(2, toDate);
		ResultSet rsState = stateStmt.executeQuery();
		while (rsState.next()) {
			String wid = rsState.getString(1);
			double amt = rsState.getDouble(2);
			String nohabs = rsBank.getString(3) != null	&& (rsBank.getString(3).equals("null") || rsBank.getString(3).equals("")) ? "0" : rsBank.getString(3);
			String wname = rsState.getString(4);
			String dcode = rsState.getString(5);
			String catcode = rsState.getString(6);
			String month = rsState.getString(7);
			String year = rsState.getString(8);
			String insertquery = "insert into Bank_Pao_exp_porting_tbl values ('"+wid+"',"+amt+",'"+nohabs+"','"+wname+"','"+dcode+"','"+month+"','"+catcode+"') ";
			stateBatchStmt.addBatch(insertquery);
		}
		bankBatchStmt.executeBatch();
		stateBatchStmt.executeBatch();

		String popQuery = "select a.CENSUS_PLAIN_POPU,a.CENSUS_SC_POPU,a.CENSUS_ST_POPU,c.DistrictId from rws_habitation_directory_tbl a,RWS_EST_NEW_HAB_LNK_TBL b,rws_delhi_district_tbl d,Bank_Pao_exp_porting_tbl bank";
		return false;
	}

	public boolean createWorksMPR(String d1, String d2, Connection conn, HttpSession session) {
		ResultSet rs1 = null, rs3 = null, rsnew = null, rsd5 = null;
		String StateId = "", DistrictId = "", SchemeId = "";
		int MonthId = 0, YearId = 0, FullyHandedOverToOM = 0;
		double SCGOIExpenditure = 0, ProgrammeComponent = 0, STGOIExpenditure = 0, GENGOIExpenditure = 0, SCGOIExpenditureSchool = 0, STGOIExpenditureSchool = 0, GENGOIExpenditureSchool = 0, SCStateExpenditure = 0, STStateExpenditure = 0, GENStateExpenditure = 0, SCStateExpenditureSchool = 0, STStateExpenditureSchool = 0, GENStateExpenditureSchool = 0, SCCommunityExpenditure = 0, STCommunityExpenditure = 0, GENCommunityExpenditure = 0, SCCommunityExpenditureSchool = 0, STCommunityExpenditureSchool = 0, GENCommunityExpenditureSchool = 0, SCDDPExpenditure = 0, STDDPExpenditure = 0, GENDDPExpenditure = 0, SCDDPExpenditureSchool = 0, STDDPExpenditureSchool = 0, GENDDPExpenditureSchool = 0, SCNCEFEXPENDITURE = 0, STNCEFEXPENDITURE = 0, GENNCEFEXPENDITURE = 0, SCNCEFEXPENDITURESCHOOL = 0, STNCEFEXPENDITURESCHOOL = 0, GENNCEFEXPENDITURESCHOOL = 0;
		String actualInsert = "";
		String y = "";
		String bankQuery = "";
		String stateQuery = "";
		int bc = 0, sc = 0;
		String insertQuery = "";
		PreparedStatement stmt=null,  stmt55=null, stmt99=null, stmt88=null, stmt11=null;
		Statement stmt1=null, stmt3=null, stmtnew = null, stmtactual = null;
		try {
			int rcount = 0;
			String empty = "";
			int delhiProgramID = 0;
			String delhiProgramName = "";
			stmtactual=conn.createStatement();
			stmtnew=conn.createStatement();
			stmt1=conn.createStatement();
			stmt3=conn.createStatement();
			long totalp = 0;
			double bankAmount = 0, sca = 0, sta = 0, plaina = 0, value1 = 0, value2 = 0, value3 = 0;
			int prgcomp = 0;			
			isTableExists("BACKEND_FINMPRSCHEME", conn,	"create table Backend_FinMPRScheme(StateId varchar2(3) not null,DistrictId	varchar2(5) not null,IMIS_SchemeId varchar2(16) ,MonthId	number(2) not null,YearId	number(4),ProgrammeComponent	number(2) not null,SCGOIExpenditure 	number(11,2) ,STGOIExpenditure		number(11,2) ,GENGOIExpenditure	number(11,2) ,SCGOIExpenditureSchool number(11,2) ,STGOIExpenditureSchool number(11,2) ,GENGOIExpenditureSchool	number(11,2) ,SCStateExpenditure	number(11,2) ,STStateExpenditure	number(11,2) ,GENStateExpenditure	number(11,2) ,SCStateExpenditureSchool	number(11,2) ,STStateExpenditureSchool	number(11,2) ,GENStateExpenditureSchool	number(11,2) ,SCCommunityExpenditure number(11,2) ,STCommunityExpenditure number(11,2) ,GENCommunityExpenditure	number(11,2) ,SCCommunityExpenditureSchool	number(11,2) ,STCommunityExpenditureSchool	number(11,2) ,GENCommunityExpenditureSchool	number(11,2) ,SCDDPExpenditure	number(11,2) ,STDDPExpenditure	number(11,2) ,GENDDPExpenditure	number(11,2) ,SCDDPExpenditureSchool	number(11,2) ,STDDPExpenditureSchool	number(11,2) ,GENDDPExpenditureSchool	number(11,2) , SCNCEFExpenditure number(11,2)  , STNCEFExpenditure  number(11,2), GENNCEFExpenditure number(11,2),SCNCEFExpenditureSchool number(11,2), STNCEFExpenditureSchool number(11,2),GENNCEFExpenditureSchool number(11,2), ExpectedDateOfCompletion	Date,PhysicalDateOfCompletion	Date,FinancialDateOfCompletion	Date,HandedOverToCommunityDate Date,FullyHandedOverToOM	number(4),FundingSupport number(4),schemeid_state varchar2(14))");
			isTableExists("SCHEMEEXPENDITURE", conn, "create table  SchemeExpenditure(SCHEMEID     VARCHAR2(14),SCHEMENAME     VARCHAR2(100),YEARID     VARCHAR2(4) ,MONTHID     VARCHAR2(4)  ,DISTRICTID     VARCHAR2(5),  PROGRAMMEID     VARCHAR2(2)  ,PROGRAMMENAME     VARCHAR2(100),GOISCEXPENDITURE     NUMBER(11,2)  ,GOISTEXPENDITURE NUMBER(11,2)  ,GOIGENEXPENDITURE NUMBER(11,2) ,GOISCHOOLSCEXPENDITURE NUMBER(11,2)  ,GOISCHOOLSTEXPENDITURE NUMBER(11,2) ,GOISCHOOLGENEXPENDITURE NUMBER(11,2) ,STATESCEXPENDITURE NUMBER(11,2) ,STATESTEXPENDITURE NUMBER(11,2),STATEGENEXPENDITURE NUMBER(11,2) ,STATESCHOOLSCEXPENDITURE NUMBER(11,2) ,STATESCHOOLSTEXPENDITURE NUMBER(11,2) ,STATESCHOOLGENEXPENDITURE  NUMBER(11,2) ,DDPSCEXPENDITURE NUMBER(11,2) ,DDPSTEXPENDITURE NUMBER(11,2) ,DDPGENEXPENDITURE NUMBER(11,2) ,DDPSCHOOLSCEXPENDITURE  NUMBER(11,2) ,DDPSCHOOLSTEXPENDITURE     NUMBER(11,2)  ,DDPSCHOOLGENEXPENDITURE     NUMBER(11,2)  ,COMMUNITYSCEXPENDITURE     NUMBER(11,2)  ,COMMUNITYSTEXPENDITURE     NUMBER(11,2)  ,COMMUNITYGENEXPENDITURE     NUMBER(11,2)  ,COMMUNITYSCHOOLSCEXPENDITURE     NUMBER(11,2)  ,COMMUNITYSCHOOLSTEXPENDITURE     NUMBER(11,2) ,COMMUNITYSCHOOLGENEXPENDITURE     NUMBER(11,2) , SCNCEFExpenditure NUMBER(11,2) ,STNCEFExpenditure NUMBER(11,2), GENNCEFExpenditure NUMBER(11,2),SCNCEFExpenditureSchool NUMBER(11,2), STNCEFExpenditureSchool NUMBER(11,2), GENNCEFExpenditureSchool NUMBER(11,2))");
			isTableExists("BANK_PAO_EXP_PORTING_TBL", conn, "create table Bank_Pao_exp_porting_tbl(WORK_ID varchar2(14),SumOfBILL_AMOUNT_CENTRAL number(11,2),NO_OF_HABS varchar2(3),WORK_NAME varchar2(100),DistrictId varchar2(5),month varchar2(5),CATEGORY_CODE varchar2(1))");
			bankQuery = "SELECT  A.WORK_ID ,SUM(A.BILL_AMOUNT_CENTRAL),B.NO_OF_HABS,B.WORK_NAME,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20','0022','21','0023','22','0024','23','0025')as dcode,b.category_code,to_char(A.BANK_SEND_DATE ,'mm'),to_char(A.BANK_SEND_DATE ,'yyyy')  FROM RWS_BILL_BANK_BRIDGE_DET_TBL A,RWS_WORK_ADMN_TBL B  WHERE  b.PROGRAMME_CODE<>'27' and  A.TXID IS NOT NULL AND A.WORK_ID=B.WORK_ID and TO_DATE(a.bank_send_date)>= ? and TO_DATE(a.bank_send_date)<= ? GROUP BY A.WORK_ID,B.NO_OF_HABS,B.WORK_NAME,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20','0022','21','0023','22','0024','23','0025'),b.category_code,to_char(A.BANK_SEND_DATE ,'mm'),to_char(A.BANK_SEND_DATE ,'yyyy')";
			stmt= conn.prepareStatement(bankQuery);
			stmt.setString(1, d1);
			stmt.setString(2, d2);
			ResultSet rs99 = stmt.executeQuery();
			while (rs99.next()) {
				String insertquery = "";
				bc++;
				String wid = rs99.getString(1);
				double amt = rs99.getDouble(2);
				String nohabs = rs99.getString(3);
				String wname = rs99.getString(4);
				String dcode = rs99.getString(5);
				String catcode = rs99.getString(6);
				String m = rs99.getString(7);
				y = rs99.getString(8);
				if (nohabs != null) {
					insertquery = "insert into Bank_Pao_exp_porting_tbl values (?, ?, ?, ?, ?, ?, ?) ";
					stmt99= conn.prepareStatement(insertquery);
					stmt99.setString(1, wid);
					stmt99.setDouble(2, amt);
					stmt99.setString(3, nohabs);
					stmt99.setString(4, wname);
					stmt99.setString(5, dcode);
					stmt99.setString(6, m);
					stmt99.setString(7, catcode);
					stmt99.executeUpdate();
					if(stmt99 != null){
						stmt99.close();
					}
				} else {
					insertquery = "insert into Bank_Pao_exp_porting_tbl values (?, ?, ?, ?, ?, ?, ?) ";
					stmt99= conn.prepareStatement(insertquery);
					stmt99.setString(1, wid);
					stmt99.setDouble(2, amt);
					stmt99.setString(3, "0");
					stmt99.setString(4, wname);
					stmt99.setString(5, dcode);
					stmt99.setString(6, m);
					stmt99.setString(7, catcode);
					stmt99.executeUpdate();
					if(stmt99 != null){
						stmt99.close();
					}
				}
			}
			stateQuery = "SELECT A.WORK_ID, SUM(A.BILL_AMOUT_STATE),B.NO_OF_HABS,B.WORK_NAME,c.districtId,b.category_code,to_char(A.state_SEND_DATE ,'mm'),to_char(A.state_SEND_DATE ,'yyyy')  FROM RWS_BILL_PAO_BRIDGE_DET_TBL A, RWS_WORK_ADMN_TBL B,rws_delhi_district_list_tbl c WHERE c.dcode=substr(b.work_id,5,2) and b.PROGRAMME_CODE<>'27' and TO_DATE(a.state_send_date)>= ? and TO_DATE(a.state_send_date)<= ? AND  A.STATE_TXID  IS NOT NULL  AND A.WORK_ID=B.WORK_ID  GROUP BY A.WORK_ID,B.NO_OF_HABS,B.WORK_NAME,c.districtId,b.category_code,to_char(A.state_SEND_DATE ,'mm'),to_char(A.state_SEND_DATE ,'yyyy')";
			stmt11=conn.prepareStatement(stateQuery);
			stmt11.setString(1, d1);
			stmt11.setString(2, d2);
			ResultSet rs88 = stmt11.executeQuery();
			while (rs88.next()) {
				String insertquery = "";
				sc++;
				String wid = rs88.getString(1);
				double amt = rs88.getDouble(2);
				String nohabs = rs88.getString(3);
				String wname = rs88.getString(4);
				String dcode = rs88.getString(5);
				String catcode = rs88.getString(6);
				String m = rs88.getString(7);
				y = rs88.getString(8);
				if (nohabs != null) {
					insertquery = "insert into Bank_Pao_exp_porting_tbl values (?, ?, ?, ?, ?, ?, ?) ";
					stmt88= conn.prepareStatement(insertquery);
					stmt88.setString(1, wid);
					stmt88.setDouble(2, amt);
					stmt88.setString(3, nohabs);
					stmt88.setString(4, wname);
					stmt88.setString(5, dcode);
					stmt88.setString(6, m);
					stmt88.setString(7, catcode);
					stmt88.executeUpdate();
					if(stmt88 != null){
						stmt88.close();
					}
				} else {
					insertquery = "insert into Bank_Pao_exp_porting_tbl values (?, ?, ?, ?, ?, ?, ?) ";
					stmt88= conn.prepareStatement(insertquery);
					stmt88.setString(1, wid);
					stmt88.setDouble(2, amt);
					stmt88.setString(3, "0");
					stmt88.setString(4, wname);
					stmt88.setString(5, dcode);
					stmt88.setString(6, m);
					stmt88.setString(7, catcode);
					stmt88.executeUpdate();
					if(stmt88 != null){
						stmt88.close();
					}
				}
			}
			bankQuery = "select * from Bank_Pao_exp_porting_tbl";
			stmt = conn.prepareStatement(bankQuery);
			rs1 = stmt.executeQuery();
			while (rs1.next()) {
				String work_id = rs1.getString(1);
				int programeCode = Integer.parseInt(work_id.substring(0, 2));
				int subprogrameCode = Integer.parseInt(work_id.substring(2, 4));
				String districtId = rs1.getString(5);
				String workName = rs1.getString(4);
				String month = rs1.getString(6);
				String noHabs = rs1.getString(3);
				int cateGoreyCode = Integer.parseInt(rs1.getString(7));
				int noOfHabs = 0;
				if (noHabs != null) {
					noOfHabs = Integer.parseInt(noHabs);
				}
				String mvspopuLationQuery = "select a.CENSUS_PLAIN_POPU,a.CENSUS_SC_POPU,a.CENSUS_ST_POPU,c.DistrictId from rws_habitation_directory_tbl a,RWS_EST_NEW_HAB_LNK_TBL b,rws_delhi_district_list_tbl c where b.work_id= '"+work_id+"' and a.hab_code=b.hab_code and substr(B.WORK_ID,5,2)=C.dcode  and  a.COVERAGE_STATUS <>'UI' ";

				String mvsSchoolpopuLationQuery = "select a.CENSUS_PLAIN_POPU,a.CENSUS_SC_POPU,a.CENSUS_ST_POPU,c.DistrictId from rws_habitation_directory_tbl a,RWS_WORK_SCHOOL_LNK_TBL b ,rws_delhi_district_list_tbl c  where b.work_id= '"+work_id+"' and a.hab_code=b.hab_code and substr(B.WORK_ID,5,2)=C.dcode and a.COVERAGE_STATUS <>'UI'";
				bankAmount += rs1.getDouble(2);
				if (work_id.substring(6, 8).equals("11")) { 
					rs3 = stmt1.executeQuery(mvsSchoolpopuLationQuery);
				} else {
					rs3 = stmt1.executeQuery(mvspopuLationQuery);
				}
				long gen = 0, scpop = 0, stpop = 0;
				totalp = 0;
				boolean flag = false;
				while (rs3.next()) {
					value1 = rs3.getInt(1);
					value2 = rs3.getInt(2);
					value3 = rs3.getInt(3);
					districtId = rs3.getString(4);
					totalp += value1 + value2 + value3; 
					gen += value1;
					scpop += value2;
					stpop += value3;
					flag = true;
				}
				if (!flag) {
					mvspopuLationQuery = "select a.CENSUS_PLAIN_POPU,a.CENSUS_SC_POPU,a.CENSUS_ST_POPU,c.DistrictId from rws_habitation_directory_tbl a,RWS_admn_HAB_LNK_TBL b,rws_delhi_district_list_tbl c where b.work_id= '"+work_id+"' and a.hab_code=b.hab_code and substr(B.WORK_ID,5,2)=C.dcode  and  a.COVERAGE_STATUS <>'UI' ";
					rs3 = stmt1.executeQuery(mvspopuLationQuery);
					while (rs3.next()) {
						value1 = rs3.getInt(1);
						value2 = rs3.getInt(2);
						value3 = rs3.getInt(3);
						districtId = rs3.getString(4);
						totalp += value1 + value2 + value3; 
						gen += value1;
						scpop += value2;
						stpop += value3;
						flag = true;  
					}
				}
				if (flag) {
					if (totalp == 0){
						double plainPer = 0;
						double scPer = 0;
						double stPer = 0;
					} else{
						double plainPer = (gen * 100 / totalp);
						double scPer = (scpop * 100 / totalp);
						double stPer = (stpop * 100 / totalp);						
						if(subprogrameCode==2){							
							sca += bankAmount;							
						}
						else if(subprogrameCode==3){
							sta += bankAmount;
						}
						else{
							sca += (bankAmount * scpop) / totalp;
							sta += (bankAmount * stpop) / totalp;
							plaina += (bankAmount * gen) / totalp;
						}					
					}
				}
				sca = Math.round(sca);
				sta = Math.round(sta);
				plaina = Math.round(plaina);
				if (cateGoreyCode == 1) { 
					if (programeCode == 1 || programeCode == 2 || programeCode == 11 || programeCode == 18	|| programeCode == 23 || programeCode == 24	|| programeCode == 27 || programeCode == 32	|| programeCode == 33 || programeCode == 36	|| programeCode == 37 || programeCode == 49	|| programeCode == 50 || programeCode == 51	|| programeCode == 53 || programeCode == 59	|| programeCode == 58 || programeCode == 60 || programeCode == 61 || programeCode == 62 || programeCode == 63 || programeCode == 72 || programeCode == 73 || programeCode == 75 || programeCode == 76 || programeCode == 78 || programeCode == 84 || programeCode == 85) {
						if (programeCode == 58 || programeCode == 11) {
							delhiProgramID = 19;
							delhiProgramName = "NRDWP-Coverage";
						} else if (programeCode == 2 || programeCode == 11 || programeCode == 23 || programeCode == 32) {
							delhiProgramID = 19;
							delhiProgramName = "NRDWP-Coverage";
						} else if (programeCode == 36) {
							delhiProgramID = 24;
							delhiProgramName = "NRDWP-Calamities";
						} else if (programeCode == 61) {
							delhiProgramID = 19;
							delhiProgramName = "NRDWP-Coverage";
						} else if (programeCode == 63) {
							delhiProgramID = 19;
							delhiProgramName = "NRDWP-Coverage";
						} else if (programeCode == 62) {
							delhiProgramID = 19;
							delhiProgramName = "NRDWP-Coverage";
						} else if (programeCode == 37) {
							delhiProgramID = 19;
							delhiProgramName = "NRDWP-Coverage";
						} else if (programeCode == 33 || programeCode == 49 || programeCode == 84 || programeCode == 85) {
							delhiProgramID = 19;
							delhiProgramName = "NRDWP-Coverage";
						} else if (programeCode == 24) {
							delhiProgramID = 2;
							delhiProgramName = "Swajaldhara";
						} else if (programeCode == 27) {
							delhiProgramID = 27;
							delhiProgramName = "NRDWP ( O & M)";
						} else if (programeCode == 51) {
							delhiProgramID = 21;
							delhiProgramName = "NRDWP-Water Quality";
						} else if (programeCode == 60) { 
							delhiProgramID = 27;
							delhiProgramName = "NRDWP ( O & M) ";
						} else if (programeCode == 59) {
							delhiProgramID = 24;
							delhiProgramName = "NRDWP-Calamities";
						} else if (programeCode == 50) {
							delhiProgramID = 20;
							delhiProgramName = "NRDWP-SUS";
						} else if (programeCode == 53) {
							delhiProgramID = 24;
							delhiProgramName = "NRDWP-Calamities";
						} else if (programeCode == 18) {
							delhiProgramID = 14;
							delhiProgramName = "ARWSP-Submission";
						}else if (programeCode == 72) {
							delhiProgramID = 38;
							delhiProgramName = "NRDWP-NCEF";
						}else if (programeCode == 73) {
							delhiProgramID = 19;
							delhiProgramName = "NRDWP-FLEXI";
						}else if (programeCode == 75) {
							delhiProgramID = 45;
							delhiProgramName = "NRDWP-MNRE";
						}else if (programeCode == 76) {
							delhiProgramID = 47;
							delhiProgramName = "NRDWP-CTP(NITI Aayog)";
						}else if (programeCode == 78) {
							delhiProgramID = 19;
							delhiProgramName = "NRDWP-SAGY";
						}else if (programeCode == 1	&& (subprogrameCode == 0 || subprogrameCode == 1 || subprogrameCode == 2	|| subprogrameCode == 3	|| subprogrameCode == 4	|| subprogrameCode == 6	|| subprogrameCode == 7 || subprogrameCode == 8)) {
							delhiProgramID = 1;
							delhiProgramName = "ARWSP";
						} else {
							if (subprogrameCode == 5) { 
								delhiProgramID = 27;
								delhiProgramName = "NRDWP ( O & M) ";
							} else {
								delhiProgramID = 19;
								delhiProgramName = "NRDWP-Coverage";
							}
						}
						if (work_id.substring(6, 8).equals("11")){
							insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','"+sca+"','"+sta+"','"+plaina+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')"; 
						} else{
							if (programeCode == 58 || programeCode == 11) {
								insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','0','0','0','0','0','0','"+sca+"','"+sta+"','"+plaina+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
							} 							
							else if (programeCode == 72 ){
								insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','0','0','0','0','0','0','"+0+"','"+0+"','"+0+"','0','0','0','0','0','0','0','0','0','"+sca+"','"+sta+"','"+plaina+"','0','0','0' )";
							} else if (programeCode == 73 ) {
								insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','0','0','0','0','0','0','"+0+"','"+0+"','"+0+"','0','0','0','0','0','0','"+sca+"','"+sta+"','"+plaina+"','0','0','0','0','0','0')";
							} else {
								insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','"+sca+"','"+sta+"','"+plaina+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
							}
						}
					}
					else if (programeCode == 03 || programeCode == 4 || programeCode == 05 || programeCode == 06	|| programeCode == 46 || programeCode == 57	|| programeCode == 12 || programeCode == 63	|| programeCode == 15 || programeCode == 14	|| programeCode == 9 || programeCode == 10 || programeCode == 00 || programeCode == 13	|| programeCode == 16 || programeCode == 21	|| programeCode == 20 || programeCode == 25	|| programeCode == 26 || programeCode == 29	|| programeCode == 34 || programeCode == 35	|| programeCode == 38 || programeCode == 39	|| programeCode == 40 || programeCode == 41	|| programeCode == 42 || programeCode == 43	|| programeCode == 44 || programeCode == 45	|| programeCode == 54 || programeCode == 56 || programeCode == 64 || programeCode == 65	|| programeCode == 66 || programeCode == 67	|| programeCode == 83) {
						switch (programeCode) {
						case 4:
							delhiProgramID = 22;
							delhiProgramName = "NABARD";
							break;
						case 46:
							delhiProgramID = 15;
							delhiProgramName = "State Programs";
							break;
						case 57:
							delhiProgramID = 25;
							delhiProgramName = "World Bank";
							break;
						case 12:
							delhiProgramID = 15;
							delhiProgramName = "State Programs";
							break;
						case 10:
							delhiProgramID = 15;
							delhiProgramName = "State Programs";
							break;
						case 15:
							delhiProgramID = 07;
							delhiProgramName = "12th Finance Commission Grants";
							break;
						case 65:
							delhiProgramID = 31;
							delhiProgramName = "13th Finance Commission Grants";
							break;
						case 14:
							delhiProgramID = 9;
							delhiProgramName = "MP LAD/MLA LAD";
							break;
						case 34:
							delhiProgramID = 9;
							delhiProgramName = "MP LAD/MLA LAD";
							break;
						case 25:
							delhiProgramID = 9;
							delhiProgramName = "MP LAD/MLA LAD";
							break;
						case 9:
							delhiProgramID = 15;
							delhiProgramName = "State Programs";
							break;
						case 13:
							delhiProgramID = 15;
							delhiProgramName = "State Programs";
							break;
						case 16:
							delhiProgramID = 15;
							delhiProgramName = "State Programs";
							break;
						case 20:
							delhiProgramID = 15;
							delhiProgramName = "State Programs";
							break;
						case 21:
							delhiProgramID = 15;
							delhiProgramName = "State Programs";
							break;
						case 26:
							delhiProgramID = 12;
							delhiProgramName = "Panchayat Funds";
							break;
						case 35:
							delhiProgramID = 12;
							delhiProgramName = "Panchayat Funds";
							break;
						case 29:
							delhiProgramID = 4;
							delhiProgramName = "Financial Institutions";
							break;
						case 38:
							delhiProgramID = 15;
							delhiProgramName = "State Programs";
							break;
						case 39:
							delhiProgramID = 15;
							delhiProgramName = "State Programs";
							break;
						case 41:
							delhiProgramID = 15;
							delhiProgramName = "State Programs";
							break;
						case 42:
							delhiProgramID = 15;
							delhiProgramName = "State Programs";
							break;
						case 43:
							delhiProgramID = 15;
							delhiProgramName = "State Programs";
							break;
						case 44:
							delhiProgramID = 15;
							delhiProgramName = "State Programs";
							break;
						case 45:
							delhiProgramID = 15;
							delhiProgramName = "State Programs";
							break;
						case 54:
							delhiProgramID = 15;
							delhiProgramName = "State Programs";
							break;
						case 56:
							delhiProgramID = 15;
							delhiProgramName = "State Programs";
							break;
						case 64:
							delhiProgramID = 15;
							delhiProgramName = "State Programs";
							break;
						case 66:
							delhiProgramID = 15;
							delhiProgramName = "State Programs";
							break;
						case 67:
							delhiProgramID = 15;
							delhiProgramName = "State Programs";
							break;
						case 03:
							delhiProgramID = 3;
							delhiProgramName = "MNP (State Funds)";
							break;
						case 05:
							delhiProgramID = 15;
							delhiProgramName = "State Programs";
							break;
						case 06:
							delhiProgramID = 22;
							delhiProgramName = "NABARD";
							break;
						case 83:
							delhiProgramID = 15;
							delhiProgramName = "State Programs";
						}
						if (work_id.substring(6, 8).equals("11")) {
							insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','0','0','0','"+sca+"','"+sta+"','"+plaina+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0' )";								
						} else {
							insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','"+sca+"','"+sta+"','"+plaina+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0' )";
						}
					}
				} else	{ 
					if (programeCode == 1 || programeCode == 2 || programeCode == 11 || programeCode == 18	|| programeCode == 23 || programeCode == 24	|| programeCode == 27 || programeCode == 32	|| programeCode == 33 || programeCode == 36	|| programeCode == 37 || programeCode == 49	|| programeCode == 50 || programeCode == 51	|| programeCode == 53 || programeCode == 59	|| programeCode == 58 || programeCode == 60	|| programeCode == 61 || programeCode == 62	|| programeCode == 63 || programeCode == 72 || programeCode == 73 || programeCode == 75	|| programeCode == 76 || programeCode == 78	|| programeCode == 84 || programeCode == 85) {
						if (programeCode == 58 || programeCode == 11) {
							delhiProgramID = 19;
							delhiProgramName = "NRDWP-Coverage";
						} else if (programeCode == 2 || programeCode == 11 || programeCode == 23 || programeCode == 32) {
							delhiProgramID = 19;
							delhiProgramName = "NRDWP-Coverage";
						} else if (programeCode == 36) {
							delhiProgramID = 24;
							delhiProgramName = "NRDWP-Calamities";
						} else if (programeCode == 61) {
							delhiProgramID = 19;
							delhiProgramName = "NRDWP-Coverage";
						} else if (programeCode == 63) {
							delhiProgramID = 19;
							delhiProgramName = "NRDWP-Coverage";
						} else if (programeCode == 62) {
							delhiProgramID = 19;
							delhiProgramName = "NRDWP-Coverage";
						} else if (programeCode == 37) {
							delhiProgramID = 19;
							delhiProgramName = "NRDWP-Coverage";
						} else if (programeCode == 33 || programeCode == 49 || programeCode == 84 || programeCode == 85) {
							delhiProgramID = 19;
							delhiProgramName = "NRDWP-Coverage";
						} else if (programeCode == 24) {
							delhiProgramID = 2;
							delhiProgramName = "Swajaldhara";
						} else if (programeCode == 27) {
							delhiProgramID = 27;
							delhiProgramName = "NRDWP ( O & M)";
						} else if (programeCode == 51) {
							delhiProgramID = 21;
							delhiProgramName = "NRDWP-Water Quality";
						} else if (programeCode == 60) { 
							delhiProgramID = 27;
							delhiProgramName = "NRDWP ( O & M) ";
						} else if (programeCode == 59) {
							delhiProgramID = 24;
							delhiProgramName = "NRDWP-Calamities";
						} else if (programeCode == 50) {
							delhiProgramID = 20;
							delhiProgramName = "NRDWP-SUS";
						} else if (programeCode == 53) {
							delhiProgramID = 24;
							delhiProgramName = "NRDWP-Calamities";
						} else if (programeCode == 18) {
							delhiProgramID = 14;
							delhiProgramName = "ARWSP-Submission";
						} else if (programeCode == 72) {
							delhiProgramID = 38;
							delhiProgramName = "NRDWP-NCEF";
						} else if (programeCode == 73) {
							delhiProgramID = 19;
							delhiProgramName = "NRDWP-FLEXI";
						} else if (programeCode == 75) {
							delhiProgramID = 45;
							delhiProgramName = "NRDWP-MNRE";
						} else if (programeCode == 76) {
							delhiProgramID = 47;
							delhiProgramName = "NRDWP-CTP(NITI Aayog)";
						} else if (programeCode == 78) {
							delhiProgramID = 19;
							delhiProgramName = "NRDWP-SAGY";
						} else if (programeCode == 1 && (subprogrameCode == 0 || subprogrameCode == 1	|| subprogrameCode == 2	|| subprogrameCode == 3	|| subprogrameCode == 4	|| subprogrameCode == 6	|| subprogrameCode == 7 || subprogrameCode == 8)) {
							delhiProgramID = 1;
							delhiProgramName = "ARWSP";
						} else {
							if (subprogrameCode == 5) { 
								delhiProgramID = 27;
								delhiProgramName = "NRDWP ( O & M)";
							} else { 
								delhiProgramID = 19;
								delhiProgramName = "NRDWP-Coverage";
							}
						}
						if (subprogrameCode == 0 || subprogrameCode == 1) {
							if (work_id.substring(6, 8).equals("11")) {
								insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')"; // correct
							} else {
								if (programeCode == 58 || programeCode == 11) {
										insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','0','0','0','0','0','0','"+sca+"','"+sta+"','"+plaina+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								} else if(programeCode == 72){
										insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','"+bankAmount+"','0','0','0')";
								} else {
										insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								}
							}
						} 
						else if (subprogrameCode == 2) { 
							if (work_id.substring(6, 8).equals("11")) {
									insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
							} else {
                                if (programeCode == 58) {									
                                	insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','0','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";									
                                } else if(programeCode == 72){
                                	insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0')";
                                } else {
                                	insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								}
							}
						} else if (subprogrameCode == 3 || subprogrameCode == 4) { 
							if (work_id.substring(6, 8).equals("11")) {
								insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
							}else {
								if (programeCode == 58) {									
									insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','0','0','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								} else if(programeCode == 72){
									insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','"+bankAmount+"','0','0','0','0')";
								} else {
									insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								}
							}
						} else if (subprogrameCode == 5 || subprogrameCode == 6	|| subprogrameCode == 7 || subprogrameCode == 8	|| subprogrameCode == 9	|| subprogrameCode == 10 || subprogrameCode == 11 || subprogrameCode == 12 || subprogrameCode == 13) { 
							if (work_id.substring(6, 8).equals("11")) {
								// insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','2012','"+month+"','"+districtId+"','"+delhiProgramID+"','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
							} else {
								if (programeCode == 58) {								
									insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','0','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								} else if(programeCode == 72){
									insertQuery = "insert into SchemeExpenditure values('"+work_id+ "','"+workName+"','"+y+ "','"+month+ "','"+districtId+ "','"+delhiProgramID+ "','"+delhiProgramName+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','"+bankAmount+"','0','0','0','0')";
								} else if (programeCode == 73) {									
									insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','0','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								} else {
										insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								}	
							}
						}
					}
					else if (programeCode == 03 || programeCode == 4 || programeCode == 05 || programeCode == 06 || programeCode == 46 || programeCode == 57	|| programeCode == 12 || programeCode == 63	|| programeCode == 15 || programeCode == 14	|| programeCode == 9 || programeCode == 10 || programeCode == 00 || programeCode == 13	|| programeCode == 16 || programeCode == 21	|| programeCode == 20 || programeCode == 25	|| programeCode == 26 || programeCode == 29	|| programeCode == 34 || programeCode == 35	|| programeCode == 38 || programeCode == 39	|| programeCode == 40 || programeCode == 41	|| programeCode == 42 || programeCode == 43	|| programeCode == 44 || programeCode == 45	|| programeCode == 54 || programeCode == 56	|| programeCode == 64 || programeCode == 65	|| programeCode == 66 || programeCode == 67	|| programeCode == 83) {
						switch (programeCode) {
							case 4:
								delhiProgramID = 22;
								delhiProgramName = "NABARD";
								break;
							case 46:
								delhiProgramID = 15;
								delhiProgramName = "State Programs";
								break;
							case 57:
								delhiProgramID = 25;
								delhiProgramName = "World Bank";
								break;
							case 12:
								delhiProgramID = 15;
								delhiProgramName = "State Programs";
								break;
							case 10:
								delhiProgramID = 15;
								delhiProgramName = "State Programs";
								break;
							case 15:
								delhiProgramID = 07;
								delhiProgramName = "12th Finance Commission Grants";
								break;
							case 65:
								delhiProgramID = 31;
								delhiProgramName = "13th Finance Commission Grants";
								break;
							case 14:
								delhiProgramID = 9;
								delhiProgramName = "MP LAD/MLA LAD";
								break;
							case 34:
								delhiProgramID = 9;
								delhiProgramName = "MP LAD/MLA LAD";
								break;
							case 25:
								delhiProgramID = 9;
								delhiProgramName = "MP LAD/MLA LAD";
								break;
							case 9:
								delhiProgramID = 15;
								delhiProgramName = "State Programs";
								break;
							case 13:
								delhiProgramID = 15;
								delhiProgramName = "State Programs";
								break;
							case 16:
								delhiProgramID = 15;
								delhiProgramName = "State Programs";
								break;
							case 20:
								delhiProgramID = 15;
								delhiProgramName = "State Programs";
								break;
							case 21:
								delhiProgramID = 15;
								delhiProgramName = "State Programs";
								break;
							case 26:
								delhiProgramID = 12;
								delhiProgramName = "Panchayat Funds";
								break;
							case 35:
								delhiProgramID = 12;
								delhiProgramName = "Panchayat Funds";
								break;
							case 29:
								delhiProgramID = 4;
								delhiProgramName = "Financial Institutions";
								break;
							case 38:
								delhiProgramID = 15;
								delhiProgramName = "State Programs";
								break;
							case 39:
								delhiProgramID = 15;
								delhiProgramName = "State Programs";
								break;
							case 41:
								delhiProgramID = 15;
								delhiProgramName = "State Programs";
								break;
							case 42:
								delhiProgramID = 15;
								delhiProgramName = "State Programs";
								break;
							case 43:
								delhiProgramID = 15;
								delhiProgramName = "State Programs";
								break;
							case 44:
								delhiProgramID = 15;
								delhiProgramName = "State Programs";
								break;
							case 45:
								delhiProgramID = 15;
								delhiProgramName = "State Programs";
								break;
	
							case 54:
								delhiProgramID = 15;
								delhiProgramName = "State Programs";
								break;
							case 56:
								delhiProgramID = 15;
								delhiProgramName = "State Programs";
								break;
							case 64:
								delhiProgramID = 15;
								delhiProgramName = "State Programs";
								break;
							case 66:
								delhiProgramID = 15;
								delhiProgramName = "State Programs";
								break;
							case 67:
								delhiProgramID = 15;
								delhiProgramName = "State Programs";
								break;
							case 03:
								delhiProgramID = 3;
								delhiProgramName = "MNP (State Funds)";
								break;
							case 05:
								delhiProgramID = 15;
								delhiProgramName = "State Programs";
								break;
							case 06:
								delhiProgramID = 22;
								delhiProgramName = "NABARD";
								break;
							case 83:
								delhiProgramID = 15;
								delhiProgramName = "State Programs";
								break;
						}
						if ((subprogrameCode == 19 || subprogrameCode == 20 || subprogrameCode == 21 ||subprogrameCode == 22|| subprogrameCode == 23 || subprogrameCode == 24 ||subprogrameCode == 25) && programeCode == 4) {
							if (work_id.substring(6, 8).equals("11")) {
								insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','0','0','0','"+sca+"','"+sta+"','"+plaina+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0' )";
							} else {
								insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','"+sca+"','"+sta+"','"+plaina+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0' )";
							}
						}
						else if (subprogrameCode == 0 || subprogrameCode == 1) {
							if (work_id.substring(6, 8).equals("11")) {
								insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')"; // correct
							} else {
								if (programeCode == 58 || programeCode == 11) {									
										insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";										
								} else {
									insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0' )";
								}
							}
						} else if (subprogrameCode == 2) {
							if (work_id.substring(6, 8).equals("11")) {
								insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
							} else {
								if (programeCode == 58) {								
									insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','0','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								} else {
									insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0' )";
								}
							}
						} else if (subprogrameCode == 3 || subprogrameCode == 4) {
							if (work_id.substring(6, 8).equals("11")) {
								insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
							} else {
								if (programeCode == 58) {								
									insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','0','0','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								} else {
									insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0' )";
								}
							}
						} else if (subprogrameCode == 5 || subprogrameCode == 6	|| subprogrameCode == 7 || subprogrameCode == 8	|| subprogrameCode == 9	|| subprogrameCode == 10 || subprogrameCode == 11 || subprogrameCode == 12 || subprogrameCode == 13) {
							if (work_id.substring(6, 8).equals("11")) {
								// insertQuery="insert into SchemeExpenditure values('"+work_id+"','"+workName+"','2012','"+month+"','"+districtId+"','"+delhiProgramID+"','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
							} else {
								if (programeCode == 58) {
										insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','0','0','0','0','0','0','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								} else {
									insertQuery = "insert into SchemeExpenditure values('"+work_id+"','"+workName+"','"+y+"','"+month+"','"+districtId+"','"+delhiProgramID+"','"+delhiProgramName+"','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								}
							}
						}
					}
				}
				if (!insertQuery.equals(" ")) {
					rcount += stmt3.executeUpdate(insertQuery);
				}
				insertQuery = " ";
				bankAmount = 0;
				plaina = 0;
				sca = 0;
				sta = 0;
				delhiProgramID = 0;
				delhiProgramName = "";
			}
			RwsHashTable imisSchemeIds = null;
			if (session.getAttribute("IMISSCHEMES") == null) {
				String imisSchemeid = "select distinct SCHEMEID_STATE ,nvl(SchemeId_IMIS,'-') from rws_imis_schemes_tbl b where SCHEMEID_STATE is not null and b.SchemeId_IMIS  is not null and b.SchemeId_IMIS<>'null ' ";
				stmt55 = conn.prepareStatement(imisSchemeid);
				rsd5 = stmt55.executeQuery();
				imisSchemeIds = new RwsHashTable();
				while (rsd5.next()) {
					imisSchemeIds.putValue(rsd5.getString(1), rsd5.getString(2));
				}
				session.setAttribute("IMISSCHEMES", imisSchemeIds);
			} else {
				imisSchemeIds = (RwsHashTable) session.getAttribute("IMISSCHEMES");
			}
			String schemeId_IMIS = "";
			String finalinsert = "select * from SchemeExpenditure";
			rsnew = stmtnew.executeQuery(finalinsert);
			while (rsnew.next()) {
				StateId = "002";
				DistrictId = rsnew.getString(5);
				SchemeId = rsnew.getString(1);
				MonthId = rsnew.getInt(4);
				YearId = rsnew.getInt(3);
				ProgrammeComponent = rsnew.getInt(6);
				SCGOIExpenditure = rsnew.getDouble(8);
				STGOIExpenditure = rsnew.getDouble(9);
				GENGOIExpenditure = rsnew.getDouble(10);
				SCGOIExpenditureSchool = rsnew.getDouble(11);
				STGOIExpenditureSchool = rsnew.getDouble(12);
				GENGOIExpenditureSchool = rsnew.getDouble(13);
				SCStateExpenditure = rsnew.getDouble(14);
				STStateExpenditure = rsnew.getDouble(15);
				GENStateExpenditure = rsnew.getDouble(16);
				SCStateExpenditureSchool = rsnew.getDouble(17);
				STStateExpenditureSchool = rsnew.getDouble(18);
				GENStateExpenditureSchool = rsnew.getDouble(19);
				SCDDPExpenditure = rsnew.getDouble(20);
				STDDPExpenditure = rsnew.getDouble(21);
				GENDDPExpenditure = rsnew.getDouble(22);
				SCDDPExpenditureSchool = rsnew.getDouble(23);
				STDDPExpenditureSchool = rsnew.getDouble(24);
				GENDDPExpenditureSchool = rsnew.getDouble(25);
				SCCommunityExpenditure = rsnew.getDouble(26);
				STCommunityExpenditure = rsnew.getDouble(27);
				GENCommunityExpenditure = rsnew.getDouble(28);
				SCCommunityExpenditureSchool = rsnew.getDouble(29);
				STCommunityExpenditureSchool = rsnew.getDouble(30);
				GENCommunityExpenditureSchool = rsnew.getDouble(31);
				SCNCEFEXPENDITURE = rsnew.getDouble(32);
				STNCEFEXPENDITURE = rsnew.getDouble(33); 
				GENNCEFEXPENDITURE = rsnew.getDouble(34); 
				SCNCEFEXPENDITURESCHOOL = rsnew.getDouble(35);
				STNCEFEXPENDITURESCHOOL = rsnew.getDouble(36);
				GENNCEFEXPENDITURESCHOOL=rsnew.getDouble(37);				
				if (ProgrammeComponent == 1 || ProgrammeComponent == 13	|| ProgrammeComponent == 14 || ProgrammeComponent == 19 || ProgrammeComponent == 20 || ProgrammeComponent == 21 || ProgrammeComponent == 27 || ProgrammeComponent ==2 || ProgrammeComponent == 24 || ProgrammeComponent == 38 ) {
					prgcomp = 1;
				} else if(ProgrammeComponent == 00 ||ProgrammeComponent == 3 || ProgrammeComponent == 22 || ProgrammeComponent == 15 || ProgrammeComponent == 9 || ProgrammeComponent == 7 || ProgrammeComponent == 12 || ProgrammeComponent == 4 || ProgrammeComponent == 25 || ProgrammeComponent == 31 || ProgrammeComponent == 18 || ProgrammeComponent == 34 ){
					prgcomp = 2;					
				} else {
					prgcomp = 1;
				}
				String imisScheme_id = (String) imisSchemeIds.getValue(SchemeId);
				actualInsert = "insert into Backend_FinMPRScheme(StateId,	DistrictId,MonthId, YearId,ProgrammeComponent,	SCGOIExpenditure	,STGOIExpenditure,	GENGOIExpenditure	,  SCGOIExpenditureSchool   ,STGOIExpenditureSchool  , GENGOIExpenditureSchool,	  SCStateExpenditure,	  STStateExpenditure	,  GENStateExpenditure	  ,SCStateExpenditureSchool	,  STStateExpenditureSchool	,  GENStateExpenditureSchool	 , SCCommunityExpenditure,	  STCommunityExpenditure	,  GENCommunityExpenditure,	  SCCommunityExpenditureSchool	,  STCommunityExpenditureSchool,	  GENCommunityExpenditureSchool,	  SCDDPExpenditure,	  STDDPExpenditure,	  GENDDPExpenditure	,  SCDDPExpenditureSchool	,  STDDPExpenditureSchool	,  GENDDPExpenditureSchool	, SCNCEFEXPENDITURE,STNCEFEXPENDITURE ,GENNCEFEXPENDITURE ,SCNCEFEXPENDITURESCHOOL ,STNCEFEXPENDITURESCHOOL , GENNCEFEXPENDITURESCHOOL  ,FullyHandedOverToOM	,FundingSupport,schemeid_state,imis_schemeid)values('"+StateId+"','"+DistrictId+"',"+MonthId+","+YearId+",'"+ProgrammeComponent+"',"+SCGOIExpenditure+","+STGOIExpenditure+","+GENGOIExpenditure+","+SCGOIExpenditureSchool+","+STGOIExpenditureSchool+","+GENGOIExpenditureSchool+","+SCStateExpenditure+","+STStateExpenditure+","+GENStateExpenditure+","+SCStateExpenditureSchool+","+STStateExpenditureSchool+","+GENStateExpenditureSchool+","+SCCommunityExpenditure+","+STCommunityExpenditure+","+GENCommunityExpenditure+","+SCCommunityExpenditureSchool+","+STCommunityExpenditureSchool+","+GENCommunityExpenditureSchool+","+SCDDPExpenditure+","+STDDPExpenditure+","+GENDDPExpenditure+","+SCDDPExpenditureSchool+","+STDDPExpenditureSchool+","+GENDDPExpenditureSchool+","+SCNCEFEXPENDITURE+","+STNCEFEXPENDITURE+","+GENNCEFEXPENDITURE+","+SCNCEFEXPENDITURESCHOOL+","+STNCEFEXPENDITURESCHOOL+","+GENNCEFEXPENDITURESCHOOL+","+FullyHandedOverToOM+","+prgcomp+",'"+SchemeId+"','"+imisScheme_id+"')";
				stmtactual.addBatch(actualInsert);
			}
			String date1 = "update Backend_FinMPRScheme a set a.ExpectedDateOfCompletion = (select TARGET_DATE_COMP from RWS_WORK_ADMN_TBL b where b. TARGET_DATE_COMP is not null and a.schemeid_state=b.work_id)";
			stmtactual.addBatch(date1);
			String date2 = "update Backend_FinMPRScheme a set a.PhysicalDateOfCompletion = (select DATE_OF_COMPLETION from rws_work_completion_tbl b where (b.DATE_OF_COMPLETION is not null or b.PARTIAL_DATE_OF_COMPLETION is not null ) and a.schemeid_state=b.work_id) ";
			stmtactual.addBatch(date2);			
			int rcount_actual[] = stmtactual.executeBatch();			
		}
		catch (Exception e) {
			System.out.println("The Exception is in Rws_Mpr_AccessDAO createWorksMPR : " +e.getMessage());
		} 
		finally{
			try{
				if(rs1 != null)
					rs1.close();
				if(rs3 != null)					
					rs3.close();
				if(rsnew != null)	
					rsnew.close();
				if(rsd5 != null)	
					rsd5.close();
				if(stmt != null)	
					stmt.close();
				if(stmt1 != null)	
					stmt1.close(); 
				if(stmt3 != null)	
					stmt3.close(); 
				if(stmt55 != null)	
					stmt55.close(); 
				if(stmt99 != null)	
					stmt99.close();
				if(stmt88 != null)	
					stmt88.close(); 
				if(stmt11 != null)	
					stmt11.close();
				if(stmtnew != null)	
					stmtnew.close();
				if(stmtactual != null)	
					stmtactual.close();
			}catch (Exception e) {
				System.out.println("The Exception is in Rws_Mpr_AccessDAO createWorksMPR Finally : " +e.getMessage());
			}
			
		}
		return true;
	}

	public boolean createHabsMPR(String fromDate, String toDate, Connection conn, HttpSession session) {
		boolean finflag = true;
		ResultSet rs1 = null;
		int household = 0;
		ResultSet rs9 = null;
		PreparedStatement stmt1=null, st9 = null;
		Statement stmt2=null, st10 = null;
		String qry9 = "", stateid = "", districtid = "", habitationid = "", mstatus = "", mscheme = "", qry10 = "";
		int monthid = 0, yearid = 0, yearid1 = 0, sc = 0, st = 0, gen = 0, thold = 0, tconnection = 0;
		String SchemeId = "", Habitationid = "";
		int Monthid = 0, SCPopCovered = 0, STPopCovered = 0, GenPopCovered = 0;
		String HouseConnection = "";
		try {
			stmt2 = conn.createStatement();
			st10 = conn.createStatement();
			isTableExists("PHYSICALMPR", conn, "CREATE table PhysicalMPR(Hab_Code varchar(16),MonthId number(2),YearId number(4),SCCoveredPop number(8,2),STCoveredPop number(8,2),GENCoveredPop number(8,2),TotalHouseHolds number(5),HouseConnections number(5),StatusUpToMonth varchar2(3),SchemeId varchar2(14))");
			String Query2 = "select  distinct b.work_id,nvl(d.CENSUS_SC_POPU,0),nvl(d.CENSUS_ST_POPU,0),nvl(d.CENSUS_PLAIN_POPU,0),nvl(c.HOUSE_CONN,''),decode(nvl(d.COVERAGE_STATUS,'-'),'PC1','PC','PC2','PC','PC3','PC','PC4','PC','NSS','PC','FC','FC','NSS','PC','null','null'),c.hab_code,to_char(b.update_date,'mm'),to_char(b.update_date,'yyyy'),h.household_no from rws_work_admn_tbl a, RWS_WORK_COMPLETION_TBL b,RWS_WORK_COMP_HAB_LNK_TBL c,RWS_COMPLETE_HAB_VIEW d, rws_habitation_directory_tbl h where   d.COVERAGE_STATUS is not null and a.work_id=b.work_id and a.category_code<>'3' and h.hab_code=d.panch_code and  b.work_id=c.work_id and c.hab_code=d.panch_code and substr(b.work_id,7,2)<>'11' and (b.DATE_OF_COMPLETION is not null or b.PARTIAL_DATE_OF_COMPLETION is not null)and b.update_date>=to_date( ? ,'dd-mm-yyyy') and b.update_date<=to_date( ? ,'dd-mm-yyyy')";
			stmt1 = conn.prepareStatement(Query2);
			stmt1.setString(1, fromDate);
			stmt1.setString(2, toDate);
			rs1 = stmt1.executeQuery();
			int rec = 0;
			while (rs1.next()) {
				rec++;
				String Query4 = "", pstatus = "";
				SchemeId = rs1.getString(1);
				SCPopCovered = rs1.getInt(2);
				STPopCovered = rs1.getInt(3);
				GenPopCovered = rs1.getInt(4);
				HouseConnection = rs1.getString(5);
				pstatus = rs1.getString(6);
				if(pstatus==null || pstatus.length()>3){
					continue;
				}
				Habitationid = rs1.getString(7);
				Monthid = rs1.getInt(8);
				yearid = rs1.getInt(9);
				household = rs1.getInt(10);
				if (HouseConnection == null || HouseConnection.equals("null")){
					HouseConnection = "0";
				}
				Query4 = "insert into PhysicalMPR(Hab_Code,MonthId,YearId,SCCoveredPop,STCoveredPop,GENCoveredPop,TotalHouseHolds,HouseConnections,StatusUpToMonth,SchemeId) values('"+Habitationid+"',"+Monthid+","+yearid+","+SCPopCovered+","+STPopCovered+","+GenPopCovered+","+household+","+HouseConnection+",'"+pstatus+"','"+SchemeId+"')"; // correct
				stmt2.addBatch(Query4);
			} 
			int recCount[] = stmt2.executeBatch();
			if (recCount.length == rec) {
				finflag = true;
			}
			
			isTableExists("BACKEND_HABSMPR", conn, "CREATE table Backend_HabsMPR(StateId varchar2(3),DistrictId varchar2(5),HabitationId varchar2(50) not null,MonthId number(2) not null,YearId number(4) not null,SCCoveredPop number(8,2),STCoveredPop number(8,2),GENCoveredPop number(8,2),TotalHouseHolds number(5),HouseConnections number(5),StatusUpToMonth varchar2(3),IMIS_SchemeId varchar2(16) ,SchemeId_State varchar2(14) )");
			qry9 = "select a.StateId,a.DistrictId,a.HabitationId,b.MonthId,b.YearId,a.SCCoveredPop,a.STCoveredPop,a.GENCoveredPop,b.TotalHouseHolds,b.HouseConnections,b.StatusUpToMonth,b.schemeid from IMISMASTERDATA1 a,PhysicalMPR b where b.Hab_Code=a.HABCODE";
			st9 = conn.prepareStatement(qry9);
			rs9 = st9.executeQuery();
			while (rs9.next()) {
				stateid ="002"; 
				districtid = rs9.getString(2);
				habitationid = rs9.getString(3);
				monthid = rs9.getInt(4);
				yearid1 = rs9.getInt(5);
				sc = rs9.getInt(6);
				st = rs9.getInt(7);
				gen = rs9.getInt(8);
				thold = rs9.getInt(9);
				tconnection = rs9.getInt(10);
				mstatus = rs9.getString(11);
				mscheme = rs9.getString(12);
				RwsHashTable imisSchemeIds = (RwsHashTable) session.getAttribute("IMISSCHEMES");
				String imisScheme_id = (String) imisSchemeIds.getValue(rs9.getString(12));
				qry10 = "insert into Backend_HabsMPR(StateId,DistrictId,HabitationId,MonthId,YearId,SCCoveredPop,STCoveredPop,GENCoveredPop,TotalHouseHolds,HouseConnections,StatusUpToMonth,schemeid_state,IMIS_Schemeid)	values('"+stateid+"','"+districtid+"','"+habitationid+"',"+monthid+","+yearid1+","+sc+","+st+","+gen+","+thold+","+tconnection+",'"+mstatus+"','"+mscheme+"','"+imisScheme_id+"')";
				st10.addBatch(qry10);
			}
			st10.executeBatch();
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Mpr_AccessDAO createHabsMPR : "+e.getMessage());
		}
		finally{
			try{
				if(rs1 != null)					
					rs1.close();
				if(stmt1 != null)					
					stmt1.close();
				if(stmt2 != null)					
					stmt2.close(); 				
				if(st9 != null)					
					st9.close();
				if(st10 != null)					
					st10.close();				
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Mpr_AccessDAO createHabsMPR Finally : "+e.getMessage());
			}
		}
		return true;
	}

	private void isTableExists(String tableName, Connection conn, String tableQuery) throws SQLException {
		String qry7 = "Select tname from tab where tname like ? ";
		PreparedStatement stmt = conn.prepareStatement(qry7);
		stmt.setString(1, tableName);
		ResultSet rs7 = stmt.executeQuery();
		if (!rs7.next()) {
			stmt =  conn.prepareStatement(tableQuery);
			stmt.executeUpdate();
		} else {
			String qry8 ="DELETE FROM "+tableName;			
			stmt =  conn.prepareStatement(qry8);
			stmt.executeUpdate();
		}
		if (stmt != null) {
			stmt.close();
		}
		if (rs7 != null) {
			rs7.close();
		}
	}

	public boolean createSchoolsMPR(String d1, String d2, Connection conn, HttpSession session) {
		ResultSet rs1 = null, rss6 = null, rs9 = null;
		PreparedStatement st9 = null, stmt1 = null, stmt6 = null;
		String qry9 = "", stateid = "", districtid = "", habitationid = "", mscheme = "", qry10 = "";
		int monthid = 0, yearid = 0;
		String SchemeId = "", Habitationid = "", schoolcode = "";
		int Monthid = 0, YearId = 0;
		try {
			Statement st10 = conn.createStatement();
			Statement stmt2 = conn.createStatement();
			isTableExists("SCHOOLMPR", conn, "CREATE table SCHOOLMPR(Hab_Code varchar(16),MonthId number(2),YearId number(4),SchemeId varchar2(14),schoolcode varchar2(4))");
			isTableExists("BACKEND_SCHOOLMPR", conn, "create table Backend_SchoolMPR(StateId	varchar2(3) not null,DistrictId	varchar2(4) not null,HabitationId varchar2(10) not null,SchoolID varchar2(10) ,MonthId	number(2) not null,YearId	number(4) not null,IMIS_SchemeId  varchar2(16),SchemeId_State  varchar2(14))");
			String Query2 = "";
			Query2 = "select  distinct b.work_id,c.hab_code,to_char(b.update_date,'mm'),to_char(b.update_date,'yyyy'),c.school_code from RWS_WORK_COMPLETION_TBL b,RWS_WORK_SCHOOL_LNK_TBL c,RWS_COMPLETE_HAB_VIEW d where  b.work_id=c.work_id and c.hab_code=d.panch_code and (b.DATE_OF_COMPLETION is not null or b.PARTIAL_DATE_OF_COMPLETION is not null)  and b.update_date>=to_date( ? ,'dd-mm-yyyy') and b.update_date<=to_date( ? ,'dd-mm-yyyy') AND d.COVERAGE_STATUS not in('UI',' ')";
			stmt1=conn.prepareStatement(Query2);
			stmt1.setString(1, d1);
			stmt1.setString(2, d2);
			rs1 = stmt1.executeQuery();
			while (rs1.next()) {
				String Query4 = "";
				SchemeId = rs1.getString(1);
				Habitationid = rs1.getString(2);
				Monthid = rs1.getInt(3);
				YearId = rs1.getInt(4);
				schoolcode = rs1.getString(5);
				Query4 = "insert into SCHOOLMPR(Hab_Code,MonthId,YearId,SchemeId,schoolcode) values('"+Habitationid+"',"+Monthid+","+YearId+",'"+SchemeId+"','"+schoolcode+"')"; 
				stmt2.addBatch(Query4);
			}
			int rcount[] = stmt2.executeBatch();
			Hashtable<String, String> h = null;
			String qq = "SELECT HABITATIONID,SCHOOLID  from imisschoolmaster";
			stmt6=conn.prepareStatement(qq);
			rss6 = stmt6.executeQuery();
			h = new Hashtable<String, String>();
			while (rss6.next()) {
				h.put(rss6.getString(1), rss6.getString(2));
			}
			qry9 = "select distinct a.StateId,a.DistrictId,a.HabitationId,b.MonthId,b.YearId,b.SchemeId from IMISMASTERDATA1 a,SCHOOLMPR b where b.Hab_Code=a.HABCODE";
			st9=conn.prepareStatement(qry9);
			rs9 = st9.executeQuery();
			String schemeId_IMIS = "";
			while (rs9.next()) {
				stateid ="002"; 
				districtid = rs9.getString(2);
				habitationid = rs9.getString(3);
				monthid = rs9.getInt(4);
				yearid = rs9.getInt(5);
				mscheme = rs9.getString(6);
				RwsHashTable imisSchemeIds = (RwsHashTable) session.getAttribute("IMISSCHEMES");
				if (imisSchemeIds != null) {
					schemeId_IMIS = (String) imisSchemeIds.getValue(rs9.getString(6));
				}
				String schoolid = h.get(rs9.getString(3));
				if (schoolid != null && !schoolid.equals("")) {
					schoolcode = schoolid;
				} else {
					schoolcode = "0";
				}
				qry10 = "insert into Backend_SCHOOLMPR(StateId,DistrictId,HabitationId,MonthId,YearId,schemeid_state,imis_schemeid,schoolid) values('"+stateid+"','"+districtid+"','"+habitationid+"',"+monthid+","+yearid+",'"+mscheme+"','"+schemeId_IMIS+"','"+schoolcode+"')";
				st10.addBatch(qry10);
			}
			st10.executeBatch();
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Mpr_AccessDAO createSchoolsMPR : "+e.getMessage());
		}
		return true;
	}

	public static Database createDatabase(String databaseName) throws IOException {
		return DatabaseBuilder.create(FileFormat.V2007, new File(databaseName));
	}

	private static TableBuilder createTable(String tableName) {
		return new TableBuilder(tableName);
	}

	public static void addColumn(Database database, TableBuilder tableName, String columnName, Types sqlType) throws SQLException, IOException {
		tableName.addColumn(new ColumnBuilder(columnName).setSQLType(Types.INTEGER).toColumn()).toTable(database);
	}

	public boolean writeFinancialMPR(Database database, Connection conn) {
		boolean flag = false;
		Statement stmt = null;
		try {
			stmt = conn.createStatement();
			String tableName = "Backend_FinMPRScheme"; 
			Table table1 = createTable(tableName).addColumn(
					new ColumnBuilder("StateId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("DistrictId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("IMIS_SchemeId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("MonthId").setSQLType(Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("YearId").setSQLType(Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("ProgrammeComponent").setSQLType(Types.DOUBLE).toColumn()).addColumn(
					new ColumnBuilder("SCGOIExpenditure").setSQLType(Types.DOUBLE).toColumn()).addColumn(
					new ColumnBuilder("STGOIExpenditure").setSQLType(Types.DOUBLE).toColumn()).addColumn(
					new ColumnBuilder("GENGOIExpenditure").setSQLType(Types.DOUBLE).toColumn()).addColumn(
					new ColumnBuilder("SCGOIExpenditureSchool").setSQLType(Types.DOUBLE).toColumn()).addColumn(
					new ColumnBuilder("STGOIExpenditureSchool").setSQLType(Types.DOUBLE).toColumn()).addColumn(
					new ColumnBuilder("GENGOIExpenditureSchool").setSQLType(Types.DOUBLE).toColumn()).addColumn(
					new ColumnBuilder("SCStateExpenditure").setSQLType(Types.DOUBLE).toColumn()).addColumn(
					new ColumnBuilder("STStateExpenditure").setSQLType(Types.DOUBLE).toColumn()).addColumn(
					new ColumnBuilder("GENStateExpenditure").setSQLType(Types.DOUBLE).toColumn()).addColumn(
					new ColumnBuilder("SCStateExpenditureSchool").setSQLType(Types.DOUBLE).toColumn()).addColumn(
					new ColumnBuilder("STStateExpenditureSchool").setSQLType(Types.DOUBLE).toColumn()).addColumn(
					new ColumnBuilder("GENStateExpenditureSchool").setSQLType(Types.DOUBLE).toColumn()).addColumn(
					new ColumnBuilder("SCCommunityExpenditure").setSQLType(Types.DOUBLE).toColumn()).addColumn(
					new ColumnBuilder("STCommunityExpenditure").setSQLType(Types.DOUBLE).toColumn()).addColumn(
					new ColumnBuilder("GENCommunityExpenditure").setSQLType(Types.DOUBLE).toColumn()).addColumn(
					new ColumnBuilder("SCCommunityExpenditureSchool").setSQLType(Types.DOUBLE).toColumn()).addColumn(
					new ColumnBuilder("STCommunityExpenditureSchool").setSQLType(Types.DOUBLE).toColumn()).addColumn(
					new ColumnBuilder("GENCommunityExpenditureSchool").setSQLType(Types.DOUBLE).toColumn()).addColumn(
					new ColumnBuilder("SCDDPExpenditure").setSQLType(Types.DOUBLE).toColumn()).addColumn(
					new ColumnBuilder("STDDPExpenditure").setSQLType(Types.DOUBLE).toColumn()).addColumn(
					new ColumnBuilder("GENDDPExpenditure").setSQLType(Types.DOUBLE).toColumn()).addColumn(
					new ColumnBuilder("SCDDPExpenditureSchool").setSQLType(Types.DOUBLE).toColumn()).addColumn(
					new ColumnBuilder("STDDPExpenditureSchool").setSQLType(
							Types.DOUBLE).toColumn()).addColumn(new ColumnBuilder("GENDDPExpenditureSchool").setSQLType(
							Types.DOUBLE).toColumn()).addColumn(new ColumnBuilder("SCNCEFExpenditure").setSQLType(
							Types.DOUBLE).toColumn()).addColumn(new ColumnBuilder("STNCEFExpenditure").setSQLType(
							Types.DOUBLE).toColumn()).addColumn(new ColumnBuilder("GENNCEFExpenditure").setSQLType(
							Types.DOUBLE).toColumn()).addColumn(new ColumnBuilder("SCNCEFExpenditureSchool").setSQLType(
							Types.DOUBLE).toColumn()).addColumn(new ColumnBuilder("STNCEFExpenditureSchool").setSQLType(
							Types.DOUBLE).toColumn()).addColumn(new ColumnBuilder("GENNCEFExpenditureSchool").setSQLType(
							Types.DOUBLE).toColumn()).addColumn(new ColumnBuilder("ExpectedDateOfCompletion").setSQLType(
							Types.DATE).toColumn()).addColumn(new ColumnBuilder("PhysicalDateOfCompletion").setSQLType(
							Types.DATE).toColumn()).addColumn(new ColumnBuilder("FinancialDateOfCompletion").setSQLType(
							Types.DATE).toColumn()).addColumn(new ColumnBuilder("HandedOverToCommunityDate").setSQLType(
							Types.DATE).toColumn()).addColumn(new ColumnBuilder("FullyHandedOverToOM").setSQLType(
							Types.DOUBLE).toColumn()).addColumn(new ColumnBuilder("FundingSupport").setSQLType(Types.DOUBLE).toColumn()).addColumn(
					new ColumnBuilder("SchemeID_State ").setSQLType(Types.VARCHAR).toColumn()).toTable(database);
			ResultSet rrs = stmt.executeQuery("SELECT  * FROM Backend_FinMPRScheme");
			flag = RwsProjectShelfDAO.importResultSet(rrs, table1);
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Mpr_AccessDAO writeFinancialMPR : "+e.getMessage());
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Mpr_AccessDAO writeFinancialMPR : "+e.getMessage());
			}
		}
		return flag;
	}

	public boolean writePhysicalMPR(Database database, Connection conn) {
		boolean flag = false;
		PreparedStatement stmt1 = null;
		try {
			String tableName1 = "Backend_HabsMPR"; 
			Table table2 = createTable(tableName1).addColumn(new ColumnBuilder("StateId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("DistrictId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("HabitationId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("MonthId").setSQLType(Types.INTEGER).toColumn()).addColumn(
					new ColumnBuilder("YearId").setSQLType(Types.INTEGER).toColumn()).addColumn(
					new ColumnBuilder("SCCoveredPop").setSQLType(Types.INTEGER).toColumn()).addColumn(
					new ColumnBuilder("STCoveredPop").setSQLType(Types.INTEGER).toColumn()).addColumn(
					new ColumnBuilder("GENCoveredPop").setSQLType(Types.INTEGER).toColumn()).addColumn(
					new ColumnBuilder("TotalHouseHolds").setSQLType(Types.INTEGER).toColumn()).addColumn(
					new ColumnBuilder("HouseConnections").setSQLType(Types.INTEGER).toColumn()).addColumn(
					new ColumnBuilder("StatusUpToMonth").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("IMIS_SchemeId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("SchemeID_State ").setSQLType(Types.VARCHAR).toColumn()).toTable(database);
			stmt1 = conn.prepareStatement("SELECT  * FROM Backend_HabsMPR");			
			ResultSet rrs = stmt1.executeQuery();
			flag = RwsProjectShelfDAO.importResultSet(rrs, table2);
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Mpr_AccessDAO writePhysicalMPR : "+e.getMessage());
		} finally {
			try {
				if (stmt1 != null) {
					stmt1.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Mpr_AccessDAO writePhysicalMPR : "+e.getMessage());
			}
		}
		return flag;
	}

	public boolean writeSchoolMPR(Database database, Connection conn) {
		boolean flag = false;
		PreparedStatement stmt2 = null;
		try {
			String tableName2 = "Backend_SchoolMPR"; 
			Table table3 = createTable(tableName2).addColumn(
					new ColumnBuilder("StateId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("DistrictId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("HabitationId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("SchoolID").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("MonthId").setSQLType(Types.INTEGER).toColumn()).addColumn(
					new ColumnBuilder("YearId").setSQLType(Types.INTEGER).toColumn()).addColumn(
					new ColumnBuilder("IMIS_SchemeId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("SchemeID_State").setSQLType(Types.VARCHAR).toColumn()).toTable(database);
			stmt2 = conn.prepareStatement("SELECT  * FROM Backend_SchoolMPR");			
			ResultSet rrs2 = stmt2.executeQuery();
			flag = RwsProjectShelfDAO.importResultSet(rrs2, table3);
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Mpr_AccessDAO writeSchoolMPR : "+e.getMessage());
		} finally {
			try {
				if (stmt2 != null) {
					stmt2.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Mpr_AccessDAO writeSchoolMPR : "+e.getMessage());
			}
		}
		return flag;
	}

	public static Database IMGcreateDatabase(HttpServletRequest request) throws IOException {
		String filepath = request.getSession().getServletContext().getRealPath("/")+ "AssetImages";		
		File directory = new File(filepath);
    	if(!directory.exists()){
           System.out.println("Directory does not exist.");   
        }else{
           try{
               delete(directory);
           }catch(IOException e){
        	   System.out.println("The Exception is in Rws_Mpr_AccessDAO IMGcreateDatabase : "+e.getMessage());           
           }
        }
    		File file=new File(filepath);
			if (!file.exists()) {
				file.mkdir();
			} else {
				String[]entries = file.list();
				for(String s: entries){
				    File currentFile = new File(file.getPath(),s);
				    currentFile.delete();			    
				}
				if (!file.exists()) {
					file.mkdir();
				}
			}
		String filename = filepath + File.separator + "AssetComponentImages.mdb";	
		return DatabaseBuilder.create(FileFormat.V2007, new File(filename));
	}
	 public static void delete(File file) throws IOException{
    	if(file.isDirectory()){
    		if(file.list().length==0){
    		   file.delete();
    		   System.out.println("Directory is deleted : "+ file.getAbsolutePath());
    		}else{
        	   String files[] = file.list();
        	   for (String temp : files) {
        		   File fileDelete = new File(file, temp);
        		   delete(fileDelete);
        	   }
        	   if(file.list().length==0){
           	     file.delete();
           	   }
    		}
    	}else{
    		file.delete();
    	}
    }

}
