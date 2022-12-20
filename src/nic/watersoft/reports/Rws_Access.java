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

public class Rws_Access {

	public static Database createDatabase(String databaseName) throws IOException {
		return DatabaseBuilder.open(new File(databaseName));
	}

	private static TableBuilder createTable(String tableName) {
		return new TableBuilder(tableName);
	}

	public static void addColumn(Database database, TableBuilder tableName,
		String columnName, Types sqlType) throws SQLException, IOException {
		tableName.addColumn(new ColumnBuilder(columnName).setSQLType(Types.INTEGER).toColumn()).toTable(database);
	}
	
	public boolean createWorksMPR(String d1, String d2, Connection conn) {
		boolean finflag = false;
		ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null, rs5 = null, rs6 = null, rsnew = null, rsd1 = null, rsd2 = null, rsd3 = null, rsd4 = null, rsd5 = null;
		String StateId = "", DistrictId = "", SchemeId = "";
		int MonthId = 0, YearId = 0, SCGOIExpenditure = 0, ProgrammeComponent = 0, STGOIExpenditure = 0, GENGOIExpenditure = 0, SCGOIExpenditureSchool = 0, STGOIExpenditureSchool = 0, GENGOIExpenditureSchool = 0, SCStateExpenditure = 0, STStateExpenditure = 0, GENStateExpenditure = 0, SCStateExpenditureSchool = 0, STStateExpenditureSchool = 0, GENStateExpenditureSchool = 0, SCCommunityExpenditure = 0, STCommunityExpenditure = 0, GENCommunityExpenditure = 0, SCCommunityExpenditureSchool = 0, STCommunityExpenditureSchool = 0, GENCommunityExpenditureSchool = 0, SCDDPExpenditure = 0, STDDPExpenditure = 0, GENDDPExpenditure = 0, SCDDPExpenditureSchool = 0, STDDPExpenditureSchool = 0, GENDDPExpenditureSchool = 0, FundingSupport = 0;
		String ExpectedDateOfCompletion = "", PhysicalDateOfCompletion = "", FinancialDateOfCompletion = "", HandedOverToCommunityDate = "", FullyHandedOverToOM = "";
		String LAStatus = "";
		String CAStatus = "";
		String mainreason = "";
		String test_id = "";
		String genid = "";
		String actualInsert = "";
		String Query = "", y = "";
		String bankQuery = "";
		String stateQuery = "";
		boolean flag1 = false;
		int bc = 0, sc = 0;
		String insertQuery = "", workid = "";
		int notfoundcount = 0, rcount_actual = 0;
		Statement stmt = null, stmt55 = null;
		Statement stmtdr = null, stmtnew = null, stmtactual = null, sttblcr = null, sttbldel = null, sttblsel = null;
		try {
			int rcount = 0;
			String empty = "";
			int contaminated = 0, rowcount = 0;
			int delhiProgramID = 0;
			String delhiProgramName = "";
			long totalp = 0;
			double bankAmount = 0, sca = 0, sta = 0, plaina = 0, value1 = 0, value2 = 0, value3 = 0;
			int prgcomp = 0;
			stmt = conn.createStatement();
			Statement stmt99 = conn.createStatement();
			Statement stmt88 = conn.createStatement();
			Statement stmt66 = conn.createStatement();
			Statement stmt44 = conn.createStatement();
			Statement stmt33 = conn.createStatement();
			Statement stmt22 = conn.createStatement();
			Statement stmt11 = conn.createStatement();
			Statement stmt1 = conn.createStatement();
			Statement stmtd1 = conn.createStatement();
			Statement stmtd2 = conn.createStatement();
			Statement stmtd3 = conn.createStatement();
			sttblcr = conn.createStatement();
			sttbldel = conn.createStatement();
			sttblsel = conn.createStatement();
			Statement astmt = conn.createStatement();
			Statement astmt1 = conn.createStatement();
			stmtnew = conn.createStatement();
			stmtactual = conn.createStatement();
			ResultSet rs33 = null, rstblcr = null, rstbldel = null, rstblsel = null;
			conn.setAutoCommit(false);
			Statement stmt2 = conn.createStatement();
			Statement stmt3 = conn.createStatement();
			Statement stmt4 = conn.createStatement();
			Statement stmt5 = conn.createStatement();
			Statement st1 = conn.createStatement();
			Statement bankpao = conn.createStatement();
			Statement delhi = conn.createStatement();
			String selquery1 = "Select tname from tab where tname like 'BACKEND_FINMPRSCHEME'";
			rstblsel = sttblsel.executeQuery(selquery1);
			if (!rstblsel.next()) {
				String crquery1 = "create table Backend_FinMPRScheme(StateId varchar2(3) not null,DistrictId	varchar2(5) not null,SchemeId varchar2(14) not null ,MonthId	number(2) not null,YearId	number(4)	not null,ProgrammeComponent	number(2) not null,SCGOIExpenditure 	number(11,2) ,STGOIExpenditure		number(11,2) ,GENGOIExpenditure	number(11,2) ,SCGOIExpenditureSchool number(11,2) ,STGOIExpenditureSchool number(11,2) ,GENGOIExpenditureSchool	number(11,2) ,SCStateExpenditure	number(11,2) ,STStateExpenditure	number(11,2) ,GENStateExpenditure	number(11,2) ,SCStateExpenditureSchool	number(11,2) ,STStateExpenditureSchool	number(11,2) ,GENStateExpenditureSchool	number(11,2) ,SCCommunityExpenditure	number(11,2) ,STCommunityExpenditure	number(11,2) ,GENCommunityExpenditure	number(11,2) ,SCCommunityExpenditureSchool	number(11,2) ,STCommunityExpenditureSchool	number(11,2) ,GENCommunityExpenditureSchool	number(11,2) ,SCDDPExpenditure	number(11,2) ,STDDPExpenditure	number(11,2) ,GENDDPExpenditure	number(11,2) ,SCDDPExpenditureSchool	number(11,2) ,STDDPExpenditureSchool	number(11,2) ,GENDDPExpenditureSchool	number(11,2) ,ExpectedDateOfCompletion	varchar2(10),PhysicalDateOfCompletion	varchar2(10),FinancialDateOfCompletion	varchar2(10),HandedOverToCommunityDate varchar2(10),FullyHandedOverToOM	varchar2(4),FundingSupport	number(4))";
				sttblcr.executeUpdate(crquery1);
			} else {
				String delquery1 = "delete from Backend_FinMPRScheme";
				sttbldel.executeUpdate(delquery1);
				conn.setAutoCommit(true);
			}
			String selquery = "Select tname from tab where tname like 'SCHEMEEXPENDITURE'";
			rs33 = stmt33.executeQuery(selquery);
			if (!rs33.next()) {
				String crquery = "create table  SchemeExpenditure(SCHEMEID     VARCHAR2(14),SCHEMENAME     VARCHAR2(100),YEARID     VARCHAR2(4) ,MONTHID     VARCHAR2(4)  ,DISTRICTID     VARCHAR2(5),  PROGRAMMEID     VARCHAR2(2)  ,PROGRAMMENAME     VARCHAR2(100),GOISCEXPENDITURE     NUMBER(11,2)  ,GOISTEXPENDITURE     NUMBER(11,2)  ,GOIGENEXPENDITURE     NUMBER(11,2)  ,GOISCHOOLSCEXPENDITURE     NUMBER(11,2)  ,GOISCHOOLSTEXPENDITURE     NUMBER(11,2)  ,GOISCHOOLGENEXPENDITURE     NUMBER(11,2)  ,STATESCEXPENDITURE     NUMBER(11,2)  ,STATESTEXPENDITURE     NUMBER(11,2)  ,STATEGENEXPENDITURE     NUMBER(11,2)  ,STATESCHOOLSCEXPENDITURE     NUMBER(11,2)  ,STATESCHOOLSTEXPENDITURE     NUMBER(11,2)  ,STATESCHOOLGENEXPENDITURE     NUMBER(11,2)  ,DDPSCEXPENDITURE     NUMBER(11,2)  ,DDPSTEXPENDITURE     NUMBER(11,2)  ,DDPGENEXPENDITURE     NUMBER(11,2)  ,DDPSCHOOLSCEXPENDITURE     NUMBER(11,2)  ,DDPSCHOOLSTEXPENDITURE     NUMBER(11,2)  ,DDPSCHOOLGENEXPENDITURE     NUMBER(11,2)  ,COMMUNITYSCEXPENDITURE     NUMBER(11,2)  ,COMMUNITYSTEXPENDITURE     NUMBER(11,2)  ,COMMUNITYGENEXPENDITURE     NUMBER(11,2)  ,COMMUNITYSCHOOLSCEXPENDITURE     NUMBER(11,2)  ,COMMUNITYSCHOOLSTEXPENDITURE     NUMBER(11,2) ,COMMUNITYSCHOOLGENEXPENDITURE     NUMBER(11,2) )";
				stmt22.executeUpdate(crquery);
			} else {
				String delquery = "delete from SchemeExpenditure";
				stmt44.executeUpdate(delquery);
				conn.setAutoCommit(true);
			}
			String bpaoqry = "Select tname from tab where tname like 'BANK_PAO_EXP_PORTING_TBL'";
			ResultSet bpao = bankpao.executeQuery(bpaoqry);
			if (!bpao.next()) {
				String tblquery = "create table Bank_Pao_exp_porting_tbl(WORK_ID varchar2(14),SumOfBILL_AMOUNT_CENTRAL number(11,2),NO_OF_HABS varchar2(3),WORK_NAME varchar2(100),DistrictId varchar2(5),month varchar2(5),CATEGORY_CODE varchar2(1))";
				stmt66.executeUpdate(tblquery);
			} else {
				String delquery = "delete from Bank_Pao_exp_porting_tbl";
				stmt66.executeUpdate(delquery);
				conn.setAutoCommit(true);
			}
			bankQuery = "SELECT DISTINCT A.WORK_ID ,SUM(A.BILL_AMOUNT_CENTRAL),B.NO_OF_HABS,B.WORK_NAME,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20','0022','21','0023','22','0024','23','0025')as dcode,b.category_code,to_char(A.BANK_SEND_DATE ,'mm'),to_char(A.BANK_SEND_DATE ,'yyyy')  FROM RWS_BILL_BANK_BRIDGE_DET_TBL A,RWS_WORK_ADMN_TBL B  WHERE  A.TXID IS NOT NULL AND A.WORK_ID=B.WORK_ID and TO_DATE(a.bank_send_date)>='"
					+d1+"' and TO_DATE(a.bank_send_date)<='"+d2+"' GROUP BY A.WORK_ID,B.NO_OF_HABS,B.WORK_NAME,decode(substr (a.work_id,5,2),'01','0003','02','0004','03','0005','04','0006','05','0007','06','0008','07','0009','08','0010', '09','0011','10','0012','11','0013','12','0014','13','0015','14','0016','15','0017','17','0019','18','0020','19','0021', '20','0022','21','0023','22','0024','23','0025'),b.category_code,to_char(A.BANK_SEND_DATE ,'mm'),to_char(A.BANK_SEND_DATE ,'yyyy')";
			ResultSet rs99 = stmt.executeQuery(bankQuery);
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
					insertquery = "insert into Bank_Pao_exp_porting_tbl values ('"
							+wid
							+"',"
							+amt
							+",'"
							+nohabs
							+"','"
							+wname
							+"','"
							+dcode
							+"','"
							+m
							+"','"
							+catcode
							+"') ";
					stmt99.executeUpdate(insertquery);
				} else {
					insertquery = "insert into Bank_Pao_exp_porting_tbl values ('"
							+wid
							+"',"
							+amt
							+",'0','"
							+wname
							+"','"
							+dcode+"','"+m+"','"+catcode+"')";
					stmt99.executeUpdate(insertquery);
				}
			}
			stateQuery = "SELECT  DISTINCT A.WORK_ID, SUM(A.BILL_AMOUT_STATE),B.NO_OF_HABS,B.WORK_NAME,c.districtId,b.category_code,to_char(A.state_SEND_DATE ,'mm'),to_char(A.state_SEND_DATE ,'yyyy')  FROM RWS_BILL_PAO_BRIDGE_DET_TBL A, RWS_WORK_ADMN_TBL B,rws_delhi_district_list_tbl c WHERE c.dcode=substr(b.work_id,5,2) and TO_DATE(a.state_send_date)>='"
					+d1
					+ "' and TO_DATE(a.state_send_date)<='"
					+ d2
					+ "' AND  A.STATE_TXID  IS NOT NULL  AND A.WORK_ID=B.WORK_ID  GROUP BY A.WORK_ID,B.NO_OF_HABS,B.WORK_NAME,c.districtId,b.category_code,to_char(A.state_SEND_DATE ,'mm'),to_char(A.state_SEND_DATE ,'yyyy')";
			ResultSet rs88 = stmt11.executeQuery(stateQuery);
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
					insertquery = "insert into Bank_Pao_exp_porting_tbl values ('"
							+wid
							+"',"
							+amt
							+",'"
							+nohabs
							+"','"
							+wname
							+"','"
							+dcode
							+"','"
							+m
							+"','"
							+catcode
							+"')";
					stmt88.executeUpdate(insertquery);
				} else {
					insertquery = "insert into Bank_Pao_exp_porting_tbl values ('"
							+wid
							+"',"
							+amt
							+",'0','"
							+wname
							+"','"
							+dcode+"','"+m+"','"+catcode+"')";
					stmt88.executeUpdate(insertquery);
				}
			}
			bankQuery = "select * from Bank_Pao_exp_porting_tbl";
			rs1 = stmt.executeQuery(bankQuery);
			while (rs1.next()) {
				flag1 = true;
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
				String mvspopuLationQuery = "select a.CENSUS_PLAIN_POPU,a.CENSUS_SC_POPU,a.CENSUS_ST_POPU,c.DistrictId from rws_habitation_directory_tbl a,RWS_EST_NEW_HAB_LNK_TBL b,rws_delhi_district_list_tbl c where b.work_id='"
						+ work_id
						+ "' and a.hab_code=b.hab_code and substr(B.WORK_ID,5,2)=C.dcode  and  a.COVERAGE_STATUS <>'UI' ";
				String mvsSchoolpopuLationQuery = "select a.CENSUS_PLAIN_POPU,a.CENSUS_SC_POPU,a.CENSUS_ST_POPU,c.DistrictId from rws_habitation_directory_tbl a,RWS_WORK_SCHOOL_LNK_TBL b ,rws_delhi_district_list_tbl c  where b.work_id='"
						+ work_id
						+ "' and a.hab_code=b.hab_code and substr(B.WORK_ID,5,2)=C.dcode and a.COVERAGE_STATUS <>'UI'";
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
					mvspopuLationQuery = "select a.CENSUS_PLAIN_POPU,a.CENSUS_SC_POPU,a.CENSUS_ST_POPU,c.DistrictId from rws_habitation_directory_tbl a,RWS_admn_HAB_LNK_TBL b,rws_delhi_district_list_tbl c where b.work_id='"
							+ work_id
							+ "' and a.hab_code=b.hab_code and substr(B.WORK_ID,5,2)=C.dcode  and  a.COVERAGE_STATUS <>'UI' ";
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
					if (totalp == 0) {
						double plainPer = 0;
						double scPer = 0;
						double stPer = 0;
					} else {
						double plainPer = (gen * 100 / totalp);
						double scPer = (scpop * 100 / totalp);
						double stPer = (stpop * 100 / totalp);
						if (scPer >= 40) {
						} else if (stPer >= 40) {
						} else {
						}
						sca += (bankAmount * scpop) / totalp;
						sta += (bankAmount * stpop) / totalp;
						plaina += (bankAmount * gen) / totalp;
					}
				}
				sca = Math.round(sca);
				sta = Math.round(sta);
				plaina = Math.round(plaina);
				if (cateGoreyCode == 1) { 
					if (programeCode == 1 || programeCode == 2 || programeCode == 11 || programeCode == 18	|| programeCode == 23 || programeCode == 24| programeCode == 27 || programeCode == 32	|| programeCode == 33 || programeCode == 36	|| programeCode == 37 || programeCode == 49 || programeCode == 50 || programeCode == 51	|| programeCode == 53 || programeCode == 59	|| programeCode == 58 || programeCode == 60	|| programeCode == 61 || programeCode == 62	|| programeCode == 63) {
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
						} else if (programeCode == 33 || programeCode == 49) {
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
						} else if (programeCode == 1 && (subprogrameCode == 0 || subprogrameCode == 1 || subprogrameCode == 2	|| subprogrameCode == 3	|| subprogrameCode == 4	|| subprogrameCode == 6	|| subprogrameCode == 7 || subprogrameCode == 8)) {
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
						if (work_id.substring(6, 8).equals("11")) {
							insertQuery = "insert into SchemeExpenditure values('"
									+work_id
									+ "','"
									+ workName
									+ "','"
									+ y
									+ "','"
									+ month
									+ "','"
									+ districtId
									+ "','"
									+ delhiProgramID
									+ "','"
									+ delhiProgramName
									+ "','0','0','0','"
									+ sca
									+ "','"
									+ sta
									+ "','"
									+ plaina
									+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')"; // correct
						} else {
							if (programeCode == 58 || programeCode == 11) {
								insertQuery = "insert into SchemeExpenditure values('"
										+ work_id
										+ "','"
										+ workName
										+ "','"
										+ y
										+ "','"
										+ month
										+ "','"
										+ districtId
										+ "','"
										+ delhiProgramID
										+ "','"
										+ delhiProgramName
										+ "','0','0','0','0','0','0','0','0','0','0','0','0','"
										+ sca
										+ "','"
										+ sta
										+ "','"
										+ plaina
										+ "','0','0','0','0','0','0','0','0','0')";
							} else {
								insertQuery = "insert into SchemeExpenditure values('"
										+ work_id
										+ "','"
										+ workName
										+ "','"
										+ y
										+ "','"
										+ month
										+ "','"
										+ districtId
										+ "','"
										+ delhiProgramID
										+ "','"
										+ delhiProgramName
										+ "','"
										+ sca
										+ "','"
										+ sta
										+ "','"
										+ plaina
										+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
							}
						}

					}
					// /////////////////////////////////////MVS STATE
					// PROGRAMES////////////////////////////////////////////////////////
					else if (programeCode == 03 || programeCode == 4
							|| programeCode == 05 || programeCode == 06
							|| programeCode == 46 || programeCode == 57
							|| programeCode == 12 || programeCode == 63
							|| programeCode == 15 || programeCode == 14
							|| programeCode == 9 || programeCode == 10
							|| programeCode == 00 || programeCode == 13
							|| programeCode == 16 || programeCode == 21
							|| programeCode == 20 || programeCode == 25
							|| programeCode == 26 || programeCode == 29
							|| programeCode == 34 || programeCode == 35
							|| programeCode == 38 || programeCode == 39
							|| programeCode == 40 || programeCode == 41
							|| programeCode == 42 || programeCode == 43
							|| programeCode == 44 || programeCode == 45
							|| programeCode == 54 || programeCode == 56
							|| programeCode == 64 || programeCode == 65
							|| programeCode == 66 || programeCode == 67) {
						// State Exp.- NABARD(04), State Plan(46), World
						// Bank(APRWSP-WB)57, HUDCO(12), TFC(63) (100%) & GOI 0%
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
							delhiProgramID = 3;
							delhiProgramName = "MNP (State Funds)";
							break;

						case 06:
							delhiProgramID = 22;
							delhiProgramName = "NABARD";
							break;
						}

						if (work_id.substring(6, 8).equals("11")) {
							insertQuery = "insert into SchemeExpenditure values('"
									+ work_id
									+ "','"
									+ workName
									+ "','"
									+ y
									+ "','"
									+ month
									+ "','"
									+ districtId
									+ "','"
									+ delhiProgramID
									+ "','"
									+ delhiProgramName
									+ "','0','0','0','0','0','0','0','0','0','"
									+ sca
									+ "','"
									+ sta
									+ "','"
									+ plaina
									+ "','0','0','0','0','0','0','0','0','0','0','0','0')";
						} else {

							insertQuery = "insert into SchemeExpenditure values('"
									+ work_id
									+ "','"
									+ workName
									+ "','"
									+ y
									+ "','"
									+ month
									+ "','"
									+ districtId
									+ "','"
									+ delhiProgramID
									+ "','"
									+ delhiProgramName
									+ "','0','0','0','0','0','0','"
									+ sca
									+ "','"
									+ sta
									+ "','"
									+ plaina
									+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
						}

					}
				} else { // SVS SCHEMES
					// ////////////////////////////SVS CENTRAL
					// Programs/////////////////////////
					// System.out.println("SVS SCHEME");

					if (programeCode == 1 || programeCode == 2
							|| programeCode == 11 || programeCode == 18
							|| programeCode == 23 || programeCode == 24
							|| programeCode == 27 || programeCode == 32
							|| programeCode == 33 || programeCode == 36
							|| programeCode == 37 || programeCode == 49
							|| programeCode == 50 || programeCode == 51
							|| programeCode == 53 || programeCode == 59
							|| programeCode == 58 || programeCode == 60
							|| programeCode == 61 || programeCode == 62
							|| programeCode == 63) {

						if (programeCode == 58 || programeCode == 11) {
							delhiProgramID = 19;
							delhiProgramName = "NRDWP-Coverage";
						} else if (programeCode == 2 || programeCode == 11
								|| programeCode == 23 || programeCode == 32) {
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
						} else if (programeCode == 33 || programeCode == 49) {
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
						} else if (programeCode == 60) { // (NRDWP 0&M)
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
						} else if (programeCode == 1
								&& (subprogrameCode == 0
										|| subprogrameCode == 1
										|| subprogrameCode == 2
										|| subprogrameCode == 3
										|| subprogrameCode == 4
										|| subprogrameCode == 6
										|| subprogrameCode == 7 || subprogrameCode == 8)) {
							delhiProgramID = 1;
							delhiProgramName = "ARWSP";
						} else {
							if (subprogrameCode == 5) { // ARWS 15%--(NRDWP-O &
								// M)
								delhiProgramID = 27;
								delhiProgramName = "NRDWP ( O & M)";
							} else { // NRDWP RELATED
								delhiProgramID = 19;
								delhiProgramName = "NRDWP-Coverage";

							}
						}

						if (subprogrameCode == 0 || subprogrameCode == 1) { // Start
							// //General
							// (Plain)
							if (work_id.substring(6, 8).equals("11")) {
								insertQuery = "insert into SchemeExpenditure values('"
										+ work_id
										+ "','"
										+ workName
										+ "','"
										+ y
										+ "','"
										+ month
										+ "','"
										+ districtId
										+ "','"
										+ delhiProgramID
										+ "','"
										+ delhiProgramName
										+ "','0','0','0','0','0','"
										+ bankAmount
										+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')"; // correct
							} else {
								if (programeCode == 58 || programeCode == 11) {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0')";
								} else {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								}
							}
						} // End //General (Plain)
						else if (subprogrameCode == 2) { // SC
							if (work_id.substring(6, 8).equals("11")) {
								insertQuery = "insert into SchemeExpenditure values('"
										+ work_id
										+ "','"
										+ workName
										+ "','"
										+ y
										+ "','"
										+ month
										+ "','"
										+ districtId
										+ "','"
										+ delhiProgramID
										+ "','"
										+ delhiProgramName
										+ "','0','0','0','"
										+ bankAmount
										+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
							} else {
								if (programeCode == 58) {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0','0')";
								} else {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								}
							}
						} else if (subprogrameCode == 3 || subprogrameCode == 4) { // if
							// //ST
							// we
							// get
							// subprogrammes
							// other
							// than
							// sc,plain,st
							// we
							// are
							// taken
							// as
							// st
							if (work_id.substring(6, 8).equals("11")) {
								insertQuery = "insert into SchemeExpenditure values('"
										+ work_id
										+ "','"
										+ workName
										+ "','"
										+ y
										+ "','"
										+ month
										+ "','"
										+ districtId
										+ "','"
										+ delhiProgramID
										+ "','"
										+ delhiProgramName
										+ "','0','0','0','0','"
										+ bankAmount
										+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
							} else {
								if (programeCode == 58) {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0')";
								} else {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								}
							}
						} else if (subprogrameCode == 5 || subprogrameCode == 6
								|| subprogrameCode == 7 || subprogrameCode == 8
								|| subprogrameCode == 9
								|| subprogrameCode == 10
								|| subprogrameCode == 11
								|| subprogrameCode == 12
								|| subprogrameCode == 13) { // if
							// we
							// get
							// subprogrammes
							// other
							// than
							// sc,plain,st
							// we
							// are
							// taken
							// as
							// st
							if (work_id.substring(6, 8).equals("11")) {
								// insertQuery="insert into SchemeExpenditure
								// values('"+work_id+"','"+workName+"','2012','"+month+"','"+districtId+"','"+delhiProgramID+"','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
							} else {
								if (programeCode == 58) {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0','0')";
								} else {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								}
							}
						}

					}

					// svs-state programs

					// /////////////////////////////////////SVS STATE
					// PROGRAMES////////////////////////////////////////////////////////
					else if (programeCode == 03 || programeCode == 4
							|| programeCode == 05 || programeCode == 06
							|| programeCode == 46 || programeCode == 57
							|| programeCode == 12 || programeCode == 63
							|| programeCode == 15 || programeCode == 14
							|| programeCode == 9 || programeCode == 10
							|| programeCode == 00 || programeCode == 13
							|| programeCode == 16 || programeCode == 21
							|| programeCode == 20 || programeCode == 25
							|| programeCode == 26 || programeCode == 29
							|| programeCode == 34 || programeCode == 35
							|| programeCode == 38 || programeCode == 39
							|| programeCode == 40 || programeCode == 41
							|| programeCode == 42 || programeCode == 43
							|| programeCode == 44 || programeCode == 45
							|| programeCode == 54 || programeCode == 56
							|| programeCode == 64 || programeCode == 65
							|| programeCode == 66 || programeCode == 67) {
						// State Exp.- NABARD(04), State Plan(46), World
						// Bank(APRWSP-WB)57, HUDCO(12), TFC(63) (100%) & GOI 0%
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
							delhiProgramID = 3;
							delhiProgramName = "MNP (State Funds)";
							break;

						case 06:
							delhiProgramID = 22;
							delhiProgramName = "NABARD";
							break;
						}

						if (subprogrameCode == 0 || subprogrameCode == 1) {
							if (work_id.substring(6, 8).equals("11")) {
								insertQuery = "insert into SchemeExpenditure values('"
										+ work_id
										+ "','"
										+ workName
										+ "','"
										+ y
										+ "','"
										+ month
										+ "','"
										+ districtId
										+ "','"
										+ delhiProgramID
										+ "','"
										+ delhiProgramName
										+ "','0','0','0','0','0','"
										+ bankAmount
										+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')"; // correct
							} else {
								if (programeCode == 58 || programeCode == 11) {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0')";
								} else {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								}
							}
						} else if (subprogrameCode == 2) {
							if (work_id.substring(6, 8).equals("11")) {
								insertQuery = "insert into SchemeExpenditure values('"
										+ work_id
										+ "','"
										+ workName
										+ "','"
										+ y
										+ "','"
										+ month
										+ "','"
										+ districtId
										+ "','"
										+ delhiProgramID
										+ "','"
										+ delhiProgramName
										+ "','0','0','0','"
										+ bankAmount
										+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
							} else {
								if (programeCode == 58) {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0','0')";
								} else {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								}
							}
						} else if (subprogrameCode == 3 || subprogrameCode == 4) { // if
							// we
							// get
							// subprogrammes
							// other
							// than
							// sc,plain,st
							// we
							// are
							// taken
							// as
							// st
							if (work_id.substring(6, 8).equals("11")) {
								insertQuery = "insert into SchemeExpenditure values('"
										+ work_id
										+ "','"
										+ workName
										+ "','"
										+ y
										+ "','"
										+ month
										+ "','"
										+ districtId
										+ "','"
										+ delhiProgramID
										+ "','"
										+ delhiProgramName
										+ "','0','0','0','0','"
										+ bankAmount
										+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
							} else {
								if (programeCode == 58) {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0')";
								} else {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								}
							}
						} else if (subprogrameCode == 5 || subprogrameCode == 6
								|| subprogrameCode == 7 || subprogrameCode == 8
								|| subprogrameCode == 9
								|| subprogrameCode == 10
								|| subprogrameCode == 11
								|| subprogrameCode == 12
								|| subprogrameCode == 13) { // if
							// we
							// get
							// subprogrammes
							// other
							// than
							// sc,plain,st
							// we
							// are
							// taken
							// as
							// st
							if (work_id.substring(6, 8).equals("11")) {
								// insertQuery="insert into SchemeExpenditure
								// values('"+work_id+"','"+workName+"','2012','"+month+"','"+districtId+"','"+delhiProgramID+"','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
							} else {
								if (programeCode == 58) {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0','0')";
								} else {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								}
							}
						}

					}

				}
				// System.out.println("Records inserted:" + rcount);

				// System.out.println("Insert Query:"+insertQuery);
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

			String finalinsert = "select * from SchemeExpenditure";
			rsnew = stmtnew.executeQuery(finalinsert);
			// System.out.println("StaRTING Process");
			while (rsnew.next()) {
				StateId = "002";
				DistrictId = rsnew.getString(5);
				SchemeId = rsnew.getString(1);
				MonthId = rsnew.getInt(4);
				YearId = rsnew.getInt(3);
				ProgrammeComponent = rsnew.getInt(6);
				SCGOIExpenditure = rsnew.getInt(8);
				STGOIExpenditure = rsnew.getInt(9);
				GENGOIExpenditure = rsnew.getInt(10);
				SCGOIExpenditureSchool = rsnew.getInt(11);
				STGOIExpenditureSchool = rsnew.getInt(12);
				GENGOIExpenditureSchool = rsnew.getInt(13);
				SCStateExpenditure = rsnew.getInt(14);
				STStateExpenditure = rsnew.getInt(15);
				GENStateExpenditure = rsnew.getInt(16);
				SCStateExpenditureSchool = rsnew.getInt(17);
				STStateExpenditureSchool = rsnew.getInt(18);
				GENStateExpenditureSchool = rsnew.getInt(19);
				SCDDPExpenditure = rsnew.getInt(20);
				STDDPExpenditure = rsnew.getInt(21);
				GENDDPExpenditure = rsnew.getInt(22);
				SCDDPExpenditureSchool = rsnew.getInt(23);
				STDDPExpenditureSchool = rsnew.getInt(24);
				GENDDPExpenditureSchool = rsnew.getInt(25);
				SCCommunityExpenditure = rsnew.getInt(26);
				STCommunityExpenditure = rsnew.getInt(27);
				GENCommunityExpenditure = rsnew.getInt(28);
				SCCommunityExpenditureSchool = rsnew.getInt(29);
				STCommunityExpenditureSchool = rsnew.getInt(30);
				GENCommunityExpenditureSchool = rsnew.getInt(31);
				ExpectedDateOfCompletion = "";
				PhysicalDateOfCompletion = "";
				FinancialDateOfCompletion = "";
				HandedOverToCommunityDate = "-";
				FullyHandedOverToOM = "-";
				FundingSupport = 0;
				if (ProgrammeComponent == 1 || ProgrammeComponent == 13
						|| ProgrammeComponent == 14 || ProgrammeComponent == 19
						|| ProgrammeComponent == 20 || ProgrammeComponent == 21) {
					prgcomp = 1;
				} else if (ProgrammeComponent == 15 || ProgrammeComponent == 18
						|| ProgrammeComponent == 3 || ProgrammeComponent == 34) {
					prgcomp = 2;
				} else if (ProgrammeComponent == 31 || ProgrammeComponent == 7) {
					prgcomp = 3;
				} else {
					prgcomp = 1;
				}
				actualInsert = "insert into Backend_FinMPRScheme(StateId,	DistrictId	,SchemeId ,MonthId, YearId,ProgrammeComponent,	SCGOIExpenditure	,STGOIExpenditure,	GENGOIExpenditure	,  SCGOIExpenditureSchool   ,STGOIExpenditureSchool  , GENGOIExpenditureSchool,	  SCStateExpenditure,	  STStateExpenditure	,  GENStateExpenditure	  ,SCStateExpenditureSchool	,  STStateExpenditureSchool	,  GENStateExpenditureSchool	 , SCCommunityExpenditure,	  STCommunityExpenditure	,  GENCommunityExpenditure,	  SCCommunityExpenditureSchool	,  STCommunityExpenditureSchool,	  GENCommunityExpenditureSchool,	  SCDDPExpenditure,	  STDDPExpenditure,	  GENDDPExpenditure	,  SCDDPExpenditureSchool	,  STDDPExpenditureSchool	,  GENDDPExpenditureSchool	,  ExpectedDateOfCompletion,PhysicalDateOfCompletion,FinancialDateOfCompletion,	HandedOverToCommunityDate,FullyHandedOverToOM	,FundingSupport	)values('"
						+ StateId
						+ "',	'"
						+ DistrictId
						+ "'	,'"
						+ SchemeId
						+ "' ,"
						+ MonthId
						+ ", "
						+ YearId
						+ ",'"
						+ ProgrammeComponent
						+ "',	"
						+ SCGOIExpenditure
						+ "	,"
						+ STGOIExpenditure
						+ ",	"
						+ GENGOIExpenditure
						+ "	, "
						+ SCGOIExpenditureSchool
						+ "   ,"
						+ STGOIExpenditureSchool
						+ "  ,"
						+ GENGOIExpenditureSchool
						+ ",	 "
						+ SCStateExpenditure
						+ ",	 "
						+ STStateExpenditure
						+ "	, "
						+ GENStateExpenditure
						+ "	  ,"
						+ SCStateExpenditureSchool
						+ "	, "
						+ STStateExpenditureSchool
						+ "	, "
						+ GENStateExpenditureSchool
						+ "	 , "
						+ SCCommunityExpenditure
						+ ",	 "
						+ STCommunityExpenditure
						+ "	,  "
						+ GENCommunityExpenditure
						+ ",	 "
						+ SCCommunityExpenditureSchool
						+ "	,  "
						+ STCommunityExpenditureSchool
						+ ",	  "
						+ GENCommunityExpenditureSchool
						+ ",	  "
						+ SCDDPExpenditure
						+ ",	 "
						+ STDDPExpenditure
						+ ",	 "
						+ GENDDPExpenditure
						+ "	, "
						+ SCDDPExpenditureSchool
						+ ", "
						+ STDDPExpenditureSchool
						+ ", "
						+ GENDDPExpenditureSchool
						+ "	,  '"
						+ ExpectedDateOfCompletion
						+ "','"
						+ PhysicalDateOfCompletion
						+ "','"
						+ FinancialDateOfCompletion
						+ "',	'"
						+ HandedOverToCommunityDate
						+ "','"
						+ FullyHandedOverToOM + "'	,'" + prgcomp + "')";
				// System.out.println("actual insert "+actualInsert);
				rcount_actual += stmtactual.executeUpdate(actualInsert);
				conn.commit();
				conn.setAutoCommit(true);
			}

			String date1 = "update Backend_FinMPRScheme a set a.ExpectedDateOfCompletion=(select nvl(to_char(PROBABLE_DATE,'mm/dd/yyyy'),'-') from rws_contractor_selection_tbl b where a.schemeID=b.work_id)";
			stmtd1.executeUpdate(date1);
			// System.out.println("update qry1 " + date1);
			conn.commit();
			conn.setAutoCommit(true);

			String date2 = "update Backend_FinMPRScheme a set a.PhysicalDateOfCompletion=(select nvl(to_char(DATE_OF_COMPLETION,'mm/dd/yyyy'),'-') from rws_work_completion_tbl b where a.schemeID=b.work_id) ";
			stmtd2.executeUpdate(date2);
			// System.out.println("update qry2 " + date2);
			conn.commit();
			conn.setAutoCommit(true);

			String date3 = "update Backend_FinMPRScheme a set a.FINANCIALDATEOFCOMPLETION=(select nvl(to_char(DT_FIN_COMPLETION,'mm/dd/yyyy'),'-') from rws_work_completion_tbl b where a.schemeID=b.work_id)";
			stmtd3.executeUpdate(date3);
			// System.out.println("update qry3 " + date3);
			conn.commit();
			conn.setAutoCommit(true);

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			try {

			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		if (rcount_actual > 0) {
			finflag = true;
		} else {
			finflag = false;
		}
		return finflag;
	}

	/**
	 * @param fromDate
	 * @param toDate
	 * @param conn2
	 * @return
	 */
	public boolean createHabsMPR(String fromDate, String toDate, Connection conn) {
		boolean finflag = false;
		ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null, rs5 = null, rs6 = null;
		int household = 0;
		int mprcount = 0;
		ResultSet rs7 = null, rs8 = null, rs9 = null, rs10 = null, rstblcr = null, rstbldel = null, rstblsel = null;
		Statement st7 = null, st8 = null, st9 = null, st10 = null, sttblcr = null, sttbldel = null, sttblsel = null;
		String qry9 = "", stateid = "", districtid = "", habitationid = "", mstatus = "", mscheme = "", qry10 = "";
		int monthid = 0, yearid = 0, yearid1 = 0, sc = 0, st = 0, gen = 0, thold = 0, tconnection = 0;
		String Query = "";
		String insertQuery = "";
		String SchemeId = "", Habitationid = "", Status = "";
		int Monthid = 0, YearId = 0, SCPopCovered = 0, STPopCovered = 0, GenPopCovered = 0, HouseConnection = 0;
		int notfoundcount = 0;
		try {
			int rcount = 0;

			String empty = "";
			String qry7 = "", qry8 = "";
			int contaminated = 0, rowcount = 0;

			Statement stmt = conn.createStatement();
			Statement stmt1 = conn.createStatement();
			Statement stmt2 = conn.createStatement();
			Statement stmt3 = conn.createStatement();
			Statement stmt4 = conn.createStatement();
			Statement stmt5 = conn.createStatement();
			st7 = conn.createStatement();
			st8 = conn.createStatement();
			st9 = conn.createStatement();
			st10 = conn.createStatement();

			// ///////////////////////////////////////////////////////////////////////////////////

			// /////////////////////////////////////////////////////////////
			String selquery = "Select tname from tab where tname like 'PHYSICALMPR'";
			rs4 = stmt4.executeQuery(selquery);
			if (!rs4.next()) {
				String Query1 = "CREATE table PhysicalMPR(Hab_Code varchar(16),MonthId number(2),YearId number(4),SCCoveredPop number(8,2),STCoveredPop number(8,2),GENCoveredPop number(8,2),TotalHouseHolds number(5),HouseConnections number(5),StatusUpToMonth varchar2(3),SchemeId varchar2(14))";
				stmt.executeUpdate(Query1);
				conn.setAutoCommit(true);
				System.out.println("Query1:" + Query1);
			} else {
				String Query1 = "delete from PhysicalMPR";
				stmt.executeUpdate(Query1);
				conn.setAutoCommit(true);
				System.out.println("Query1:" + Query1);
			}
			String Query2 = "";
			Query2 = "select  distinct b.work_id,d.CENSUS_SC_POPU,d.CENSUS_ST_POPU,d.CENSUS_PLAIN_POPU,c.HOUSE_CONN,nvl(d.COVERAGE_STATUS,'-'),c.hab_code,to_char(b.update_date,'mm'),to_char(b.update_date,'yyyy'),household_no from rws_work_admn_tbl c, RWS_WORK_COMPLETION_TBL b,RWS_WORK_COMP_HAB_LNK_TBL c,RWS_COMPLETE_HAB_VIEW d, rws_habitation_directory_tbl h where c.work_id=b.work_id and c.category_code<>'3' and h.hab_code=d.panch_code and  b.work_id=c.work_id and c.hab_code=d.panch_code and substr(b.work_id,7,2)<>'11' and b.DATE_OF_COMPLETION is not null and b.update_date>=to_date('"
					+ fromDate
					+ "','dd-mm-yyyy') and b.update_date<=to_date('"
					+ toDate
					+ "','dd-mm-yyyy') AND d.COVERAGE_STATUS is not null and d.COVERAGE_STATUS not in('UI',' ')";
			rs1 = stmt1.executeQuery(Query2);
			System.out
					.println("select Query2:these are updated habssssssssssss"
							+ Query2);
			while (rs1.next()) {
				String Query4 = "", pstatus = "";
				SchemeId = rs1.getString(1);
				SCPopCovered = rs1.getInt(2);
				STPopCovered = rs1.getInt(3);
				GenPopCovered = rs1.getInt(4);
				HouseConnection = rs1.getInt(5);
				Status = rs1.getString(6);
				Habitationid = rs1.getString(7);
				Monthid = rs1.getInt(8);
				yearid = rs1.getInt(9);
				household = rs1.getInt(10);

				if (Status.equals("PC1") || Status.equals("PC2")
						|| Status.equals("PC3") || Status.equals("PC4"))
					pstatus = "PC";
				else
					pstatus = Status;
				if (HouseConnection != 0) {
					Query4 = "insert into PhysicalMPR(Hab_Code,MonthId,YearId,SCCoveredPop,STCoveredPop,GENCoveredPop,TotalHouseHolds,HouseConnections,StatusUpToMonth,SchemeId) values('"
							+ Habitationid
							+ "',"
							+ Monthid
							+ ","
							+ yearid
							+ ","
							+ SCPopCovered
							+ ","
							+ STPopCovered
							+ ","
							+ GenPopCovered
							+ ","
							+ household
							+ ","
							+ HouseConnection
							+ ",'"
							+ pstatus
							+ "','"
							+ SchemeId + "')"; // correct
				} else {
					Query4 = "insert into PhysicalMPR(Hab_Code,MonthId,YearId,SCCoveredPop,STCoveredPop,GENCoveredPop,TotalHouseHolds,HouseConnections,StatusUpToMonth,SchemeId) values('"
							+ Habitationid
							+ "',"
							+ Monthid
							+ ","
							+ yearid
							+ ","
							+ SCPopCovered
							+ ","
							+ STPopCovered
							+ ","
							+ GenPopCovered
							+ ","
							+ household
							+ ",'0','"
							+ pstatus + "','" + SchemeId + "')"; // correct
					// '"+SchemeId+"',
				}
				// System.out.println("Insert Query4:"+Query4);
				if (!insertQuery.equals(" ")) {
					rcount += stmt2.executeUpdate(Query4);
				}
				// Added on 03/11/2012
				qry7 = "Select tname from tab where tname like 'BACKEND_HABSMPR'";
				rs7 = st7.executeQuery(qry7);
				if (!rs7.next()) {
					qry8 = "CREATE table Backend_HabsMPR(StateId varchar2(3),DistrictId varchar2(5),HabitationId varchar2(50) not null,MonthId number(2) not null,YearId number(4) not null,SCCoveredPop number(8,2),STCoveredPop number(8,2),GENCoveredPop number(8,2),TotalHouseHolds number(5),HouseConnections number(5),StatusUpToMonth varchar2(3),SchemeId varchar2(14) not null)";
					st8.executeUpdate(qry8);
					conn.setAutoCommit(true);
					System.out.println("Query8:" + qry8);
				} else {
					qry8 = "delete from Backend_HabsMPR";
					st8.executeUpdate(qry8);
					conn.setAutoCommit(true);
					// System.out.println("Query8:" + qry8);
				}
			}
			// Added on 03/11/2012 for MPR table
			// Added on 03/11/2012
			qry9 = "select a.StateId,a.DistrictId,a.HabitationId,b.MonthId,b.YearId,b.SCCoveredPop,b.STCoveredPop,b.GENCoveredPop,b.TotalHouseHolds,b.HouseConnections,b.StatusUpToMonth,b.SchemeId from IMISMASTERDATA1 a,PhysicalMPR b where b.Hab_Code=a.HABCODE";
			// System.out.println("select Query9:"+qry9);
			rs9 = st9.executeQuery(qry9);

			while (rs9.next()) {
				stateid = rs9.getString(1);
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
				qry10 = "insert into Backend_HabsMPR(StateId,DistrictId,HabitationId,MonthId,YearId,SCCoveredPop,STCoveredPop,GENCoveredPop,TotalHouseHolds,HouseConnections,StatusUpToMonth,SchemeId)	values('"
						+ stateid
						+ "','"
						+ districtid
						+ "','"
						+ habitationid
						+ "',"
						+ monthid
						+ ","
						+ yearid1
						+ ","
						+ sc
						+ ",		   "
						+ st
						+ ","
						+ gen
						+ ","
						+ thold
						+ ","
						+ tconnection
						+ ",'" + mstatus + "','" + mscheme + "')";

				// System.out.println("Insert Query10:"+qry10);
				mprcount += st10.executeUpdate(qry10);

				// Added on 03/11/2012
				String sno = "";
				if (mprcount > 0) {
					finflag = true;
				}

			}
		} catch (Exception e) {
			// System.out.println("Final Query:" + insertQuery);
			e.printStackTrace();

		}
		return finflag;
	}

	//Deepak Modified
	public boolean createDistLevelHabsMPR(String d1, String d2, Connection conn) {
		boolean finflag = false;
		PreparedStatement st1 = null, st2 = null, st3 = null, st4 = null, st5 = null, st6 = null, st7 = null, st8 = null;
		ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null;
		int household = 0;
		int mprcount = 0;
		String qry7 = "", qry8 = "", qry9 = "", qry10 = "", stateid = "", districtid = "", habitationid = "", mstatus = "", mscheme = "";
		int monthid = 0, yearid = 0, yearid1 = 0, sc = 0, st = 0, gen = 0, thold = 0, tconnection = 0;
		String SchemeId = "", Habitationid = "", Status = "";
		int Monthid = 0, YearId = 0, SCPopCovered = 0, STPopCovered = 0, GenPopCovered = 0, HouseConnection = 0;
		try {
			int rcount = 0;
			String selquery = "Select tname from tab where tname like 'PHYSICALMPR'";
			st1 = conn.prepareStatement(selquery);
			rs1 = st1.executeQuery();
			if (!rs1.next()) {
				String Query1 = "CREATE table PhysicalMPR(Hab_Code varchar(16),MonthId number(2),YearId number(4),SCCoveredPop number(8,2),STCoveredPop number(8,2),GENCoveredPop number(8,2),TotalHouseHolds number(5),HouseConnections number(5),StatusUpToMonth varchar2(2),SchemeId varchar2(14))";
				st2 = conn.prepareStatement(Query1);
				st2.executeUpdate();
				conn.setAutoCommit(true);
			} else {
				String Query1 = "delete from PhysicalMPR";
				st2 = conn.prepareStatement(Query1);
				st2.executeUpdate();
				conn.setAutoCommit(true);
			}
			String Query2 = "";
			Query2 = "select b.work_id,d.CENSUS_SC_POPU,d.CENSUS_ST_POPU,d.CENSUS_PLAIN_POPU,c.HOUSE_CONN,d.COVERAGE_STATUS,c.hab_code,to_char(b.update_date,'mm'),to_char(b.update_date,'yyyy'),household_no from  rws_work_admn_tbl a , RWS_WORK_COMPLETION_TBL b,RWS_WORK_COMP_HAB_LNK_TBL c,RWS_COMPLETE_HAB_VIEW d, rws_habitation_directory_tbl h where a.work_id=b.work_id and a.category_code='3'  and h.hab_code=d.panch_code and  b.work_id=c.work_id and c.hab_code=d.panch_code and b.DATE_OF_COMPLETION is not null and b.update_date>=to_date( ? ,'dd-mm-yyyy') and b.update_date<=to_date( ? ,'dd-mm-yyyy') AND d.COVERAGE_STATUS not in('UI',' ')";
			st3 = conn.prepareStatement(Query2);
			st3.setString(1, d1);
			st3.setString(2, d2);
			rs2 = st3.executeQuery();
			while (rs2.next()) {
				String Query4 = "", pstatus = "";
				SchemeId = rs2.getString(1);
				SCPopCovered = rs2.getInt(2);
				STPopCovered = rs2.getInt(3);
				GenPopCovered = rs2.getInt(4);
				HouseConnection = rs2.getInt(5);
				Status = rs2.getString(6);
				Habitationid = rs2.getString(7);
				Monthid = rs2.getInt(8);
				yearid = rs2.getInt(9);
				household = rs2.getInt(10);
				if (Status.equals("PC1") || Status.equals("PC2") || Status.equals("PC3") || Status.equals("PC4"))
					pstatus = "PC";
				else
					pstatus = Status;
				if (HouseConnection != 0) {
					Query4 = "insert into PhysicalMPR(Hab_Code,MonthId,YearId,SCCoveredPop,STCoveredPop,GENCoveredPop,TotalHouseHolds,HouseConnections,StatusUpToMonth,SchemeId) values('"+Habitationid+"',"+Monthid+","+yearid+","+SCPopCovered+","+STPopCovered+","+GenPopCovered+","+household+","+HouseConnection+",'"+pstatus+"','"+SchemeId+"')"; 
				} else {
					Query4 = "insert into PhysicalMPR(Hab_Code,MonthId,YearId,SCCoveredPop,STCoveredPop,GENCoveredPop,TotalHouseHolds,HouseConnections,StatusUpToMonth,SchemeId) values('"+Habitationid+"',"+Monthid+","+yearid+","+SCPopCovered+","+STPopCovered+","+GenPopCovered+","+household+",'0','"+pstatus+"','"+SchemeId+"')"; 				
				}
				if (!Query4.equals(" ")) {
					st4 = conn.prepareStatement(Query4);
					rcount += st4.executeUpdate();
					if(st4 != null ){
						st4.close();
					}
				}
				qry7 = "Select tname from tab where tname like 'BACKEND_HABSMPR'";
				st5 = conn.prepareStatement(qry7);
				rs3 = st5.executeQuery();
				if (!rs3.next()) {
					qry8 = "CREATE table Backend_HabsMPR(StateId varchar2(3),DistrictId varchar2(5),HabitationId varchar2(50) not null,MonthId number(2) not null,YearId number(4) not null,SCCoveredPop number(8,2),STCoveredPop number(8,2),GENCoveredPop number(8,2),TotalHouseHolds number(5),HouseConnections number(5),StatusUpToMonth varchar2(2),SCHEMEID_STATE varchar2(14) not null)";
					st6 = conn.prepareStatement(qry8);
					st6.executeUpdate();
					conn.setAutoCommit(true);
					if(st6 != null ){
						st6.close();
					}			
				} else {
					qry8 = "delete from Backend_HabsMPR";
					st6 = conn.prepareStatement(qry8);
					st6.executeUpdate();					
					conn.setAutoCommit(true);
					if(st6 != null ){
						st6.close();
					}				
				}
			}
			qry9 = "select a.StateId,a.DistrictId,a.HabitationId,b.MonthId,b.YearId,b.SCCoveredPop,b.STCoveredPop,b.GENCoveredPop,b.TotalHouseHolds,b.HouseConnections,b.StatusUpToMonth,b.SchemeId from IMISMASTERDATA1 a,PhysicalMPR b where b.Hab_Code=a.HABCODE";
			st7 = conn.prepareStatement(qry9);
			rs4 = st7.executeQuery();
			while (rs4.next()) {
				stateid = rs4.getString(1);
				districtid = rs4.getString(2);
				habitationid = rs4.getString(3);
				monthid = rs4.getInt(4);
				yearid1 = rs4.getInt(5);
				sc = rs4.getInt(6);
				st = rs4.getInt(7);
				gen = rs4.getInt(8);
				thold = rs4.getInt(9);
				tconnection = rs4.getInt(10);
				mstatus = rs4.getString(11);
				mscheme = rs4.getString(12);
				qry10 = "insert into Backend_HabsMPR(StateId,DistrictId,HabitationId,MonthId,YearId,SCCoveredPop,STCoveredPop,GENCoveredPop,TotalHouseHolds,HouseConnections,StatusUpToMonth,SCHEMEID_STATE)	values( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
				st8 = conn.prepareStatement(qry10);
				st8.setString(1, stateid);
				st8.setString(2, districtid);
				st8.setString(3, habitationid);
				st8.setInt(4, monthid);
				st8.setInt(5, yearid1);
				st8.setInt(6, sc);
				st8.setInt(7, st);
				st8.setInt(8, gen);
				st8.setInt(9, thold);
				st8.setInt(10, tconnection);
				st8.setString(11, mstatus);
				st8.setString(12, mscheme);
				mprcount += st8.executeUpdate();
				if(st8 != null ){
					st8.close();
				}
				String sno = "";
				if (mprcount > 0) {
					finflag = true;
				}		
			}
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Access createDistLevelHabsMPR : "+e.getMessage());
		}finally{
			try{
				rs1.close();
				rs2.close();
				rs3.close();
				rs4.close();
				st1.close();
				st2.close();
				st3.close();
				st4.close();
				st5.close();
				st6.close();
				st7.close();
				st8.close();
			}catch (Exception e) {
				System.out.println("The Exception is in Rws_Access createDistLevelHabsMPR : "+e.getMessage());
			}			
		}
		return finflag;
	}

	/**
	 * @param d1
	 * @param d2
	 * @param conn2
	 * @return
	 */
	public boolean createSchoolsMPR(String d1, String d2, Connection conn) {
		boolean finflag = false;
		ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null, rs5 = null, rs6 = null, rss6 = null, rss7 = null, rstblcr = null, rstbldel = null, rstblsel = null;
		int household = 0;
		int mprcount = 0;
		// Added on 03/11/2012
		ResultSet rs7 = null, rs8 = null, rs9 = null, rs10 = null;
		Statement st7 = null, st8 = null, st9 = null, st10 = null, sttblcr = null, sttbldel = null, sttblsel = null;
		String qry9 = "", stateid = "", districtid = "", habitationid = "", mstatus = "", mscheme = "", qry10 = "";
		int monthid = 0, yearid = 0, sc = 0, st = 0, gen = 0, thold = 0, tconnection = 0;
		String Query = "";
		String insertQuery = "";
		String SchemeId = "", Habitationid = "", Status = "", schoolcode = "";
		int Monthid = 0, YearId = 0, SCPopCovered = 0, STPopCovered = 0, GenPopCovered = 0, HouseConnection = 0;
		int notfoundcount = 0;
		try {
			int rcount = 0;

			String empty = "", qq = "";
			String qry7 = "", qry8 = "";
			String habid = "", schoolid = "";
			int contaminated = 0, rowcount = 0;

			Statement stmt = conn.createStatement();
			Statement stmt1 = conn.createStatement();
			Statement stmt2 = conn.createStatement();
			Statement stmt3 = conn.createStatement();
			Statement stmt4 = conn.createStatement();
			Statement stmt5 = conn.createStatement();
			Statement stmt6 = conn.createStatement();
			Statement stmt7 = conn.createStatement();
			Statement stmt8 = conn.createStatement();
			st7 = conn.createStatement();
			st8 = conn.createStatement();
			st9 = conn.createStatement();
			st10 = conn.createStatement();

			String selquery = "Select tname from tab where tname like 'SCHOOLMPR'";
			rs4 = stmt4.executeQuery(selquery);
			if (!rs4.next()) {
				String Query1 = "CREATE table SCHOOLMPR(Hab_Code varchar(16),MonthId number(2),YearId number(4),SchemeId varchar2(14),schoolcode varchar2(4))";
				stmt.executeUpdate(Query1);
				conn.setAutoCommit(true);
				System.out.println("Query1:" + Query1);
			} else {
				String Query1 = "delete from SCHOOLMPR";
				stmt.executeUpdate(Query1);
				conn.setAutoCommit(true);
				System.out.println("Query1:" + Query1);
			}
			String Query2 = "";
			Query2 = "select  distinct b.work_id,c.hab_code,to_char(b.update_date,'mm'),to_char(b.update_date,'yyyy'),c.school_code from RWS_WORK_COMPLETION_TBL b,RWS_WORK_SCHOOL_LNK_TBL c,RWS_COMPLETE_HAB_VIEW d where  b.work_id=c.work_id and c.hab_code=d.panch_code and b.DATE_OF_COMPLETION is not null and b.update_date>=to_date('"
					+ d1
					+ "','dd-mm-yyyy') and b.update_date<=to_date('"
					+ d2
					+ "','dd-mm-yyyy') AND d.COVERAGE_STATUS not in('UI',' ')";
			rs1 = stmt1.executeQuery(Query2);
			System.out.println("select Query2:" + Query2);
			while (rs1.next()) {
				String Query4 = "", pstatus = "";
				SchemeId = rs1.getString(1);
				Habitationid = rs1.getString(2);
				Monthid = rs1.getInt(3);
				YearId = rs1.getInt(4);
				schoolcode = rs1.getString(5);
				if (Status.equals("PC1") || Status.equals("PC2")
						|| Status.equals("PC3") || Status.equals("PC4"))
					pstatus = "PC";
				else
					pstatus = Status;
				Query4 = "insert into SCHOOLMPR(Hab_Code,MonthId,YearId,SchemeId,schoolcode) values('"
						+ Habitationid
						+ "',"
						+ Monthid
						+ ","
						+ YearId
						+ ",'"
						+ SchemeId + "','" + schoolcode + "')"; // correct
				// .out.println("Insert Query4:"+Query4);
				if (!insertQuery.equals(" ")) {
					rcount += stmt2.executeUpdate(Query4);
				}
				// Added on 03/11/2012
				qry7 = "Select tname from tab where tname like 'BACKEND_SCHOOLMPR'";
				rs7 = st7.executeQuery(qry7);
				if (!rs7.next()) {
					qry8 = "create table Backend_SchoolMPR(StateId	varchar2(3) not null,DistrictId	varchar2(4) not null,HabitationId varchar2(10) not null,SchoolID	varchar2(10) not null,MonthId	number(2) not null,YearId	number(4) not null,SchemeId  varchar2(14) not null )";
					st8.executeUpdate(qry8);
					conn.setAutoCommit(true);
					// System.out.println("Query8:" + qry8);
				} else {
					qry8 = "delete from Backend_SchoolMPR";
					st8.executeUpdate(qry8);
					conn.setAutoCommit(true);
					// System.out.println("Query8:" + qry8);
				}
			}
			// Added on 03/11/2012 for MPR table
			// Added on 03/11/2012
			qry9 = "select a.StateId,a.DistrictId,a.HabitationId,b.MonthId,b.YearId,b.SchemeId from IMISMASTERDATA1 a,SCHOOLMPR b where b.Hab_Code=a.HABCODE";
			// System.out.println("select Query9:"+qry9);
			rs9 = st9.executeQuery(qry9);

			while (rs9.next()) {
				stateid = rs9.getString(1);
				districtid = rs9.getString(2);
				habitationid = rs9.getString(3);
				monthid = rs9.getInt(4);
				yearid = rs9.getInt(5);
				mscheme = rs9.getString(6);

				qry10 = "insert into Backend_SCHOOLMPR(StateId,DistrictId,HabitationId,SchoolID,MonthId,YearId,SchemeId)	values('"
						+ stateid
						+ "','"
						+ districtid
						+ "','"
						+ habitationid
						+ "','00',"
						+ monthid
						+ ","
						+ yearid
						+ ",'"
						+ mscheme
						+ "')";
				// System.out.println("Insert Query10:"+qry10);
				mprcount += st10.executeUpdate(qry10);
				// Added on 03/11/2012
				String sno = "";
				conn.setAutoCommit(true);
			}

			qq = "SELECT backend_schoolmpr.habitationid,imisschoolmaster.schoolid FROM backend_schoolmpr INNER JOIN imisschoolmaster ON backend_schoolmpr.HabitationId = imisschoolmaster.habitationId";
			rss6 = stmt6.executeQuery(qq);
			Hashtable h = new Hashtable();
			while (rss6.next()) {
				h.put(rss6.getString(1), rss6.getString(2));
				// System.out.println(""+h.get(rss6.getString(2)));
			}

			String qq1 = "select HabitationId from backend_SCHOOLMPR ";
			// System.out.println("qq1"+qq1);
			rss7 = stmt7.executeQuery(qq1);

			while (rss7.next()) {

				schoolid = (String) h.get(rss7.getString(1));
				if (schoolid != null && !schoolid.equals("")) {
					schoolcode = schoolid;
				} else {
					schoolcode = "0";
				}
				// System.out.println("rss7.getString:::"+rss7.getString(1));
				String qq3 = "update backend_schoolmpr set schoolid='"
						+ schoolcode + "' where habitationid='"
						+ rss7.getString(1) + "'";
				stmt8.executeUpdate(qq3);
				// System.out.println("qq3"+qq3);
				conn.setAutoCommit(true);
			}

			if (mprcount > 0) {
				finflag = true;
			}

		} catch (Exception e) {
			// System.out.println("Final Query:" + insertQuery);
			e.printStackTrace();

		}
		return finflag;
	}

	public boolean createWorksMPRforWorksList(Connection conn) {
		boolean finflag = false;
		ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null, rs5 = null, rs6 = null, rsnew = null, rsd1 = null, rsd2 = null, rsd3 = null, rsd4 = null, rsd5 = null;
		String StateId = "", DistrictId = "", SchemeId = "";
		int MonthId = 0, YearId = 0, SCGOIExpenditure = 0, ProgrammeComponent = 0, STGOIExpenditure = 0, GENGOIExpenditure = 0, SCGOIExpenditureSchool = 0, STGOIExpenditureSchool = 0, GENGOIExpenditureSchool = 0, SCStateExpenditure = 0, STStateExpenditure = 0, GENStateExpenditure = 0, SCStateExpenditureSchool = 0, STStateExpenditureSchool = 0, GENStateExpenditureSchool = 0, SCCommunityExpenditure = 0, STCommunityExpenditure = 0, GENCommunityExpenditure = 0, SCCommunityExpenditureSchool = 0, STCommunityExpenditureSchool = 0, GENCommunityExpenditureSchool = 0, SCDDPExpenditure = 0, STDDPExpenditure = 0, GENDDPExpenditure = 0, SCDDPExpenditureSchool = 0, STDDPExpenditureSchool = 0, GENDDPExpenditureSchool = 0, FundingSupport = 0;
		String ExpectedDateOfCompletion = "", PhysicalDateOfCompletion = "", FinancialDateOfCompletion = "", HandedOverToCommunityDate = "", FullyHandedOverToOM = "";
		String LAStatus = "";
		String CAStatus = "";
		String mainreason = "";
		String test_id = "";
		String genid = "";
		String actualInsert = "";

		String Query = "", y = "";
		String bankQuery = "";
		String stateQuery = "";
		boolean flag1 = false;
		int bc = 0, sc = 0;
		String insertQuery = "", workid = "";
		int notfoundcount = 0, rcount_actual = 0;
		Statement stmt = null, stmt55 = null;
		Statement stmtdr = null, stmtnew = null, stmtactual = null, sttblcr = null, sttbldel = null, sttblsel = null;

		try {
			int rcount = 0;

			String empty = "";
			int contaminated = 0, rowcount = 0;
			int delhiProgramID = 0;
			String delhiProgramName = "";
			long totalp = 0;
			double bankAmount = 0, sca = 0, sta = 0, plaina = 0, value1 = 0, value2 = 0, value3 = 0;
			int prgcomp = 0;
			stmt = conn.createStatement();
			Statement stmt99 = conn.createStatement();
			Statement stmt88 = conn.createStatement();
			Statement stmt66 = conn.createStatement();
			Statement stmt44 = conn.createStatement();
			Statement stmt33 = conn.createStatement();
			Statement stmt22 = conn.createStatement();
			Statement stmt11 = conn.createStatement();
			Statement stmt1 = conn.createStatement();
			Statement stmtd1 = conn.createStatement();
			Statement stmtd2 = conn.createStatement();
			Statement stmtd3 = conn.createStatement();
			sttblcr = conn.createStatement();
			sttbldel = conn.createStatement();
			sttblsel = conn.createStatement();
			Statement astmt = conn.createStatement();
			Statement astmt1 = conn.createStatement();

			stmtnew = conn.createStatement();
			stmtactual = conn.createStatement();
			ResultSet rs33 = null, rstblcr = null, rstbldel = null, rstblsel = null;

			conn.setAutoCommit(false);

			Statement stmt2 = conn.createStatement();
			Statement stmt3 = conn.createStatement();
			Statement stmt4 = conn.createStatement();
			Statement stmt5 = conn.createStatement();
			Statement st1 = conn.createStatement();
			Statement bankpao = conn.createStatement();
			Statement delhi = conn.createStatement();

			// table qry///////////////////////////////////////

			String selquery1 = "Select tname from tab where tname like 'BACKEND_FINMPRSCHEME'";
			rstblsel = sttblsel.executeQuery(selquery1);
			if (!rstblsel.next()) {
				String crquery1 = "create table Backend_FinMPRScheme(StateId varchar2(3) not null,DistrictId	varchar2(5) not null,SchemeId varchar2(14) not null ,MonthId	number(2) not null,YearId	number(4)	not null,ProgrammeComponent	number(2) not null,SCGOIExpenditure 	number(11,2) ,STGOIExpenditure		number(11,2) ,GENGOIExpenditure	number(11,2) ,SCGOIExpenditureSchool number(11,2) ,STGOIExpenditureSchool number(11,2) ,GENGOIExpenditureSchool	number(11,2) ,SCStateExpenditure	number(11,2) ,STStateExpenditure	number(11,2) ,GENStateExpenditure	number(11,2) ,SCStateExpenditureSchool	number(11,2) ,STStateExpenditureSchool	number(11,2) ,GENStateExpenditureSchool	number(11,2) ,SCCommunityExpenditure	number(11,2) ,STCommunityExpenditure	number(11,2) ,GENCommunityExpenditure	number(11,2) ,SCCommunityExpenditureSchool	number(11,2) ,STCommunityExpenditureSchool	number(11,2) ,GENCommunityExpenditureSchool	number(11,2) ,SCDDPExpenditure	number(11,2) ,STDDPExpenditure	number(11,2) ,GENDDPExpenditure	number(11,2) ,SCDDPExpenditureSchool	number(11,2) ,STDDPExpenditureSchool	number(11,2) ,GENDDPExpenditureSchool	number(11,2) ,ExpectedDateOfCompletion	varchar2(10),PhysicalDateOfCompletion	varchar2(10),FinancialDateOfCompletion	varchar2(10),HandedOverToCommunityDate varchar2(10),FullyHandedOverToOM	varchar2(4),FundingSupport	number(4))";
				sttblcr.executeUpdate(crquery1);
				// System.out.println("crquery"+crquery);
			} else {
				String delquery1 = "delete from Backend_FinMPRScheme";
				sttbldel.executeUpdate(delquery1);
				conn.setAutoCommit(true);
				System.out.println("delquery" + delquery1);
			}

			// //////////////////////////////////////////////////////

			String selquery = "Select tname from tab where tname like 'SCHEMEEXPENDITURE'";
			rs33 = stmt33.executeQuery(selquery);
			if (!rs33.next()) {
				String crquery = "create table  SchemeExpenditure(SCHEMEID     VARCHAR2(14),SCHEMENAME     VARCHAR2(100),YEARID     VARCHAR2(4) ,MONTHID     VARCHAR2(4)  ,DISTRICTID     VARCHAR2(5),  PROGRAMMEID     VARCHAR2(2)  ,PROGRAMMENAME     VARCHAR2(100),GOISCEXPENDITURE     NUMBER(11,2)  ,GOISTEXPENDITURE     NUMBER(11,2)  ,GOIGENEXPENDITURE     NUMBER(11,2)  ,GOISCHOOLSCEXPENDITURE     NUMBER(11,2)  ,GOISCHOOLSTEXPENDITURE     NUMBER(11,2)  ,GOISCHOOLGENEXPENDITURE     NUMBER(11,2)  ,STATESCEXPENDITURE     NUMBER(11,2)  ,STATESTEXPENDITURE     NUMBER(11,2)  ,STATEGENEXPENDITURE     NUMBER(11,2)  ,STATESCHOOLSCEXPENDITURE     NUMBER(11,2)  ,STATESCHOOLSTEXPENDITURE     NUMBER(11,2)  ,STATESCHOOLGENEXPENDITURE     NUMBER(11,2)  ,DDPSCEXPENDITURE     NUMBER(11,2)  ,DDPSTEXPENDITURE     NUMBER(11,2)  ,DDPGENEXPENDITURE     NUMBER(11,2)  ,DDPSCHOOLSCEXPENDITURE     NUMBER(11,2)  ,DDPSCHOOLSTEXPENDITURE     NUMBER(11,2)  ,DDPSCHOOLGENEXPENDITURE     NUMBER(11,2)  ,COMMUNITYSCEXPENDITURE     NUMBER(11,2)  ,COMMUNITYSTEXPENDITURE     NUMBER(11,2)  ,COMMUNITYGENEXPENDITURE     NUMBER(11,2)  ,COMMUNITYSCHOOLSCEXPENDITURE     NUMBER(11,2)  ,COMMUNITYSCHOOLSTEXPENDITURE     NUMBER(11,2) ,COMMUNITYSCHOOLGENEXPENDITURE     NUMBER(11,2) )";
				stmt22.executeUpdate(crquery);
				// System.out.println("crquery"+crquery);
			} else {
				String delquery = "delete from SchemeExpenditure";
				stmt44.executeUpdate(delquery);
				conn.setAutoCommit(true);
				// System.out.println("delquery"+delquery);
			}

			String bpaoqry = "Select tname from tab where tname like 'BANK_PAO_EXP_PORTING_TBL'";
			ResultSet bpao = bankpao.executeQuery(bpaoqry);
			if (!bpao.next()) {
				String tblquery = "create table Bank_Pao_exp_porting_tbl(WORK_ID varchar2(14),SumOfBILL_AMOUNT_CENTRAL number(11,2),NO_OF_HABS varchar2(3),WORK_NAME varchar2(100),DistrictId varchar2(5),month varchar2(5),CATEGORY_CODE varchar2(1))";
				stmt66.executeUpdate(tblquery);
				// System.out.println("tblquery"+tblquery);
			} else {
				String delquery = "delete from Bank_Pao_exp_porting_tbl";
				stmt66.executeUpdate(delquery);
				conn.setAutoCommit(true);
				// System.out.println("delquery"+delquery);
			}

			String q1 = "select distinct WORK_ID from works_temp ";
			// System.out.println("tbl qry"+q1);
			ResultSet rr1 = astmt.executeQuery(q1);

			while (rr1.next()) {
				workid = rr1.getString(1);
				System.out.println("workid " + workid);

				bankQuery = "SELECT DISTINCT A.WORK_ID ,SUM(A.BILL_AMOUNT_CENTRAL),B.NO_OF_HABS,B.WORK_NAME, c.districtId,b.category_code,"
						+ "to_char(A.BANK_SEND_DATE ,'mm'),to_char(A.BANK_SEND_DATE ,'yyyy')  FROM RWS_BILL_BANK_BRIDGE_DET_TBL A,RWS_WORK_ADMN_TBL B ,"
						+ "rws_delhi_district_list_tbl c  WHERE  c.dcode=substr(b.work_id,5,2) and A.TXID IS NOT NULL AND A.WORK_ID=B.WORK_ID and"
						+ " b.work_id ='"
						+ workid
						+ "'  group by A.WORK_ID ,B.NO_OF_HABS,B.WORK_NAME, c.districtId,b.category_code,to_char(A.BANK_SEND_DATE ,'mm'),to_char(A.BANK_SEND_DATE ,'yyyy')";
				// System.out.println("bankQuery Query:" + bankQuery);
				ResultSet rs99 = stmt.executeQuery(bankQuery);
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

						insertquery = "insert into Bank_Pao_exp_porting_tbl values ('"
								+ wid
								+ "',"
								+ amt
								+ ",'"
								+ nohabs
								+ "','"
								+ wname
								+ "','"
								+ dcode
								+ "','"
								+ m
								+ "','"
								+ catcode + "') ";
						// System.out.println("Insert Query:"+insertquery);
						stmt99.executeUpdate(insertquery);

					} else {

						insertquery = "insert into Bank_Pao_exp_porting_tbl values ('"
								+ wid
								+ "',"
								+ amt
								+ ",'0','"
								+ wname
								+ "','"
								+ dcode + "','" + m + "','" + catcode + "') ";
						// System.out.println("Insert Query:"+insertquery);
						stmt99.executeUpdate(insertquery);

					}

				}// End of Bank
			}

			String q11 = "select distinct WORK_ID from works_temp ";
			// System.out.println("tbl qry"+q1);
			ResultSet rr11 = astmt1.executeQuery(q11);

			while (rr11.next()) {
				workid = rr11.getString(1);
				System.out.println("workid " + workid);

				stateQuery = "SELECT  DISTINCT A.WORK_ID, SUM(A.BILL_AMOUT_STATE),B.NO_OF_HABS,B.WORK_NAME,c.districtId,b.category_code,to_char(A.state_SEND_DATE ,'mm'),to_char(A.state_SEND_DATE ,'yyyy')  FROM RWS_BILL_PAO_BRIDGE_DET_TBL A, RWS_WORK_ADMN_TBL B,rws_delhi_district_list_tbl c WHERE c.dcode=substr(b.work_id,5,2)  AND  A.STATE_TXID  IS NOT NULL  AND A.WORK_ID=B.WORK_ID  "
						+ " and b.work_id='"
						+ workid
						+ "'"
						+ " GROUP BY A.WORK_ID,B.NO_OF_HABS,B.WORK_NAME,c.districtId,b.category_code,to_char(A.state_SEND_DATE ,'mm'),to_char(A.state_SEND_DATE ,'yyyy')";

				// System.out.println("stateQuery Query:" + stateQuery);
				ResultSet rs88 = stmt11.executeQuery(stateQuery);
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

						insertquery = "insert into Bank_Pao_exp_porting_tbl values ('"
								+ wid
								+ "',"
								+ amt
								+ ",'"
								+ nohabs
								+ "','"
								+ wname
								+ "','"
								+ dcode
								+ "','"
								+ m
								+ "','"
								+ catcode + "') ";
						// System.out.println("Insert Query:"+insertquery);
						stmt88.executeUpdate(insertquery);
					} else {

						insertquery = "insert into Bank_Pao_exp_porting_tbl values ('"
								+ wid
								+ "',"
								+ amt
								+ ",'0','"
								+ wname
								+ "','"
								+ dcode + "','" + m + "','" + catcode + "') ";
						// System.out.println("Insert Query:"+insertquery);
						stmt88.executeUpdate(insertquery);

					}

				}
			}// End of State

			// //////////////////////Temporary Tbls/////////////////////////////
			bankQuery = "select * from Bank_Pao_exp_porting_tbl";
			rs1 = stmt.executeQuery(bankQuery);
			// System.out.println("StaRTING Process");
			while (rs1.next()) {
				flag1 = true;
				// System.out.println("Statred Process");
				String work_id = rs1.getString(1); // /01010411120008
				// System.out.println("Work Id"+work_id);
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
				// System.out.println("Work ID:"+work_id+"Programme
				// Code:"+programeCode);
				String mvspopuLationQuery = "select a.CENSUS_PLAIN_POPU,a.CENSUS_SC_POPU,a.CENSUS_ST_POPU,c.DistrictId from rws_habitation_directory_tbl a,RWS_EST_NEW_HAB_LNK_TBL b,rws_delhi_district_list_tbl c where b.work_id='"
						+ work_id
						+ "' and a.hab_code=b.hab_code and substr(B.WORK_ID,5,2)=C.dcode  and  a.COVERAGE_STATUS <>'UI' ";

				String mvsSchoolpopuLationQuery = "select a.CENSUS_PLAIN_POPU,a.CENSUS_SC_POPU,a.CENSUS_ST_POPU,c.DistrictId from rws_habitation_directory_tbl a,RWS_WORK_SCHOOL_LNK_TBL b ,rws_delhi_district_list_tbl c  where b.work_id='"
						+ work_id
						+ "' and a.hab_code=b.hab_code and substr(B.WORK_ID,5,2)=C.dcode and a.COVERAGE_STATUS <>'UI'";

				bankAmount += rs1.getDouble(2);

				// 1 PROJECTS (mvs)
				// 2 NORMAL (svs)

				if (work_id.substring(6, 8).equals("11")) { // FOR SCHOOLS
					// System.out.println("mvsSchoolpopuLationQuery"+mvsSchoolpopuLationQuery);
					rs3 = stmt1.executeQuery(mvsSchoolpopuLationQuery);
				} else {
					// System.out.println("mvspopuLationQuery:"+mvspopuLationQuery);
					rs3 = stmt1.executeQuery(mvspopuLationQuery);
				}

				// System.out.println("Amount:"+bankAmount);
				long gen = 0, scpop = 0, stpop = 0;
				totalp = 0;
				boolean flag = false;
				while (rs3.next()) {

					value1 = rs3.getInt(1);
					value2 = rs3.getInt(2);
					value3 = rs3.getInt(3);
					districtId = rs3.getString(4);
					// System.out.println("districtId:"+districtId);
					totalp += value1 + value2 + value3; // System.out.println("Total
					// Poplation:"+totalp);

					gen += value1;
					scpop += value2;
					stpop += value3;
					flag = true;

				}
				// //////////////////////////////////////////////

				if (!flag) {
					mvspopuLationQuery = "select a.CENSUS_PLAIN_POPU,a.CENSUS_SC_POPU,a.CENSUS_ST_POPU,c.DistrictId from rws_habitation_directory_tbl a,RWS_admn_HAB_LNK_TBL b,rws_delhi_district_list_tbl c where b.work_id='"
							+ work_id
							+ "' and a.hab_code=b.hab_code and substr(B.WORK_ID,5,2)=C.dcode  and  a.COVERAGE_STATUS <>'UI' ";

					rs3 = stmt1.executeQuery(mvspopuLationQuery);
					while (rs3.next()) {

						value1 = rs3.getInt(1);
						value2 = rs3.getInt(2);
						value3 = rs3.getInt(3);
						districtId = rs3.getString(4);
						// System.out.println("districtId:"+districtId);
						totalp += value1 + value2 + value3; // System.out.println("Total
						// Poplation:"+totalp);

						gen += value1;
						scpop += value2;
						stpop += value3;
						flag = true;

					}

				}

				// //////////////////////////////////////////////
				if (flag) {
					sca += (bankAmount * scpop) / totalp;// System.out.println("SCA
					// Poplation:"+sca);
					sta += (bankAmount * stpop) / totalp;// System.out.println("sta
					// Poplation:"+sta);
					plaina += (bankAmount * gen) / totalp;
				}
				sca = Math.round(sca);
				sta = Math.round(sta);
				plaina = Math.round(plaina);

				// NRDWP Related (100%)

				if (cateGoreyCode == 1) { // MVS SCHEMES
					// System.out.println("MVS SCHEME");
					// /////////////////////////////////////MVS CENTRAL
					// PROGRAMES////////////////////////////////////////////////////////
					if (programeCode == 1 || programeCode == 2
							|| programeCode == 11 || programeCode == 18
							|| programeCode == 23 || programeCode == 24
							|| programeCode == 27 || programeCode == 32
							|| programeCode == 33 || programeCode == 36
							|| programeCode == 37 || programeCode == 49
							|| programeCode == 50 || programeCode == 51
							|| programeCode == 53 || programeCode == 59
							|| programeCode == 58 || programeCode == 60
							|| programeCode == 61 || programeCode == 62
							|| programeCode == 63) {

						if (programeCode == 58 || programeCode == 11) {
							delhiProgramID = 19;
							delhiProgramName = "NRDWP-Coverage";
						} else if (programeCode == 2 || programeCode == 11
								|| programeCode == 23 || programeCode == 32) {
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
						} else if (programeCode == 33 || programeCode == 49) {
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
						} else if (programeCode == 60) { // (NRDWP 0&M)
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
						} else if (programeCode == 1
								&& (subprogrameCode == 0
										|| subprogrameCode == 1
										|| subprogrameCode == 2
										|| subprogrameCode == 3
										|| subprogrameCode == 4
										|| subprogrameCode == 6
										|| subprogrameCode == 7 || subprogrameCode == 8)) {
							delhiProgramID = 1;
							delhiProgramName = "ARWSP";
						} else {
							if (subprogrameCode == 5) { // ARWS 15%--(NRDWP-O &
								// M)
								delhiProgramID = 27;
								delhiProgramName = "NRDWP ( O & M) ";
							} else { // NRDWP RELATED
								delhiProgramID = 19;
								delhiProgramName = "NRDWP-Coverage";
							}
						}
						if (work_id.substring(6, 8).equals("11")) {
							insertQuery = "insert into SchemeExpenditure values('"
									+ work_id
									+ "','"
									+ workName
									+ "','"
									+ y
									+ "','"
									+ month
									+ "','"
									+ districtId
									+ "','"
									+ delhiProgramID
									+ "','"
									+ delhiProgramName
									+ "','0','0','0','"
									+ sca
									+ "','"
									+ sta
									+ "','"
									+ plaina
									+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')"; // correct
						} else {
							if (programeCode == 58 || programeCode == 11) {
								insertQuery = "insert into SchemeExpenditure values('"
										+ work_id
										+ "','"
										+ workName
										+ "','"
										+ y
										+ "','"
										+ month
										+ "','"
										+ districtId
										+ "','"
										+ delhiProgramID
										+ "','"
										+ delhiProgramName
										+ "','0','0','0','0','0','0','0','0','0','0','0','0','"
										+ sca
										+ "','"
										+ sta
										+ "','"
										+ plaina
										+ "','0','0','0','0','0','0','0','0','0')";
							} else {
								insertQuery = "insert into SchemeExpenditure values('"
										+ work_id
										+ "','"
										+ workName
										+ "','"
										+ y
										+ "','"
										+ month
										+ "','"
										+ districtId
										+ "','"
										+ delhiProgramID
										+ "','"
										+ delhiProgramName
										+ "','"
										+ sca
										+ "','"
										+ sta
										+ "','"
										+ plaina
										+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
							}
						}

					}
					// /////////////////////////////////////MVS STATE
					// PROGRAMES////////////////////////////////////////////////////////
					else if (programeCode == 03 || programeCode == 4
							|| programeCode == 05 || programeCode == 06
							|| programeCode == 46 || programeCode == 57
							|| programeCode == 12 || programeCode == 63
							|| programeCode == 15 || programeCode == 14
							|| programeCode == 9 || programeCode == 10
							|| programeCode == 00 || programeCode == 13
							|| programeCode == 16 || programeCode == 21
							|| programeCode == 20 || programeCode == 25
							|| programeCode == 26 || programeCode == 29
							|| programeCode == 34 || programeCode == 35
							|| programeCode == 38 || programeCode == 39
							|| programeCode == 40 || programeCode == 41
							|| programeCode == 42 || programeCode == 43
							|| programeCode == 44 || programeCode == 45
							|| programeCode == 54 || programeCode == 56
							|| programeCode == 64 || programeCode == 65
							|| programeCode == 66 || programeCode == 67) {
						// State Exp.- NABARD(04), State Plan(46), World
						// Bank(APRWSP-WB)57, HUDCO(12), TFC(63) (100%) & GOI 0%
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
							delhiProgramID = 3;
							delhiProgramName = "MNP (State Funds)";
							break;

						case 06:
							delhiProgramID = 22;
							delhiProgramName = "NABARD";
							break;
						}

						if (work_id.substring(6, 8).equals("11")) {
							insertQuery = "insert into SchemeExpenditure values('"
									+ work_id
									+ "','"
									+ workName
									+ "','"
									+ y
									+ "','"
									+ month
									+ "','"
									+ districtId
									+ "','"
									+ delhiProgramID
									+ "','"
									+ delhiProgramName
									+ "','0','0','0','0','0','0','0','0','0','"
									+ sca
									+ "','"
									+ sta
									+ "','"
									+ plaina
									+ "','0','0','0','0','0','0','0','0','0','0','0','0')";
						} else {

							insertQuery = "insert into SchemeExpenditure values('"
									+ work_id
									+ "','"
									+ workName
									+ "','"
									+ y
									+ "','"
									+ month
									+ "','"
									+ districtId
									+ "','"
									+ delhiProgramID
									+ "','"
									+ delhiProgramName
									+ "','0','0','0','0','0','0','"
									+ sca
									+ "','"
									+ sta
									+ "','"
									+ plaina
									+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
						}

					}
				} else { // SVS SCHEMES
					// ////////////////////////////SVS CENTRAL
					// Programs/////////////////////////
					// System.out.println("SVS SCHEME");

					if (programeCode == 1 || programeCode == 2
							|| programeCode == 11 || programeCode == 18
							|| programeCode == 23 || programeCode == 24
							|| programeCode == 27 || programeCode == 32
							|| programeCode == 33 || programeCode == 36
							|| programeCode == 37 || programeCode == 49
							|| programeCode == 50 || programeCode == 51
							|| programeCode == 53 || programeCode == 59
							|| programeCode == 58 || programeCode == 60
							|| programeCode == 61 || programeCode == 62
							|| programeCode == 63) {

						if (programeCode == 58 || programeCode == 11) {
							delhiProgramID = 19;
							delhiProgramName = "NRDWP-Coverage";
						} else if (programeCode == 2 || programeCode == 11
								|| programeCode == 23 || programeCode == 32) {
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
						} else if (programeCode == 33 || programeCode == 49) {
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
						} else if (programeCode == 60) { // (NRDWP 0&M)
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
						} else if (programeCode == 1
								&& (subprogrameCode == 0
										|| subprogrameCode == 1
										|| subprogrameCode == 2
										|| subprogrameCode == 3
										|| subprogrameCode == 4
										|| subprogrameCode == 6
										|| subprogrameCode == 7 || subprogrameCode == 8)) {
							delhiProgramID = 1;
							delhiProgramName = "ARWSP";
						} else {
							if (subprogrameCode == 5) { // ARWS 15%--(NRDWP-O &
								// M)
								delhiProgramID = 27;
								delhiProgramName = "NRDWP ( O & M)";
							} else { // NRDWP RELATED
								delhiProgramID = 19;
								delhiProgramName = "NRDWP-Coverage";

							}
						}

						if (subprogrameCode == 0 || subprogrameCode == 1) {
							if (work_id.substring(6, 8).equals("11")) {
								insertQuery = "insert into SchemeExpenditure values('"
										+ work_id
										+ "','"
										+ workName
										+ "','"
										+ y
										+ "','"
										+ month
										+ "','"
										+ districtId
										+ "','"
										+ delhiProgramID
										+ "','"
										+ delhiProgramName
										+ "','0','0','0','0','0','"
										+ bankAmount
										+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')"; // correct
							} else {
								if (programeCode == 58 || programeCode == 11) {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0')";
								} else {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								}
							}
						} else if (subprogrameCode == 2) {
							if (work_id.substring(6, 8).equals("11")) {
								insertQuery = "insert into SchemeExpenditure values('"
										+ work_id
										+ "','"
										+ workName
										+ "','"
										+ y
										+ "','"
										+ month
										+ "','"
										+ districtId
										+ "','"
										+ delhiProgramID
										+ "','"
										+ delhiProgramName
										+ "','0','0','0','"
										+ bankAmount
										+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
							} else {
								if (programeCode == 58) {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0','0')";
								} else {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								}
							}
						} else if (subprogrameCode == 3 || subprogrameCode == 4) { // if
							// we
							// get
							// subprogrammes
							// other
							// than
							// sc,plain,st
							// we
							// are
							// taken
							// as
							// st
							if (work_id.substring(6, 8).equals("11")) {
								insertQuery = "insert into SchemeExpenditure values('"
										+ work_id
										+ "','"
										+ workName
										+ "','"
										+ y
										+ "','"
										+ month
										+ "','"
										+ districtId
										+ "','"
										+ delhiProgramID
										+ "','"
										+ delhiProgramName
										+ "','0','0','0','0','"
										+ bankAmount
										+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
							} else {
								if (programeCode == 58) {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0')";
								} else {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								}
							}
						} else if (subprogrameCode == 5 || subprogrameCode == 6
								|| subprogrameCode == 7 || subprogrameCode == 8
								|| subprogrameCode == 9
								|| subprogrameCode == 10
								|| subprogrameCode == 11
								|| subprogrameCode == 12
								|| subprogrameCode == 13) { // if
							// we
							// get
							// subprogrammes
							// other
							// than
							// sc,plain,st
							// we
							// are
							// taken
							// as
							// st
							if (work_id.substring(6, 8).equals("11")) {
								// insertQuery="insert into SchemeExpenditure
								// values('"+work_id+"','"+workName+"','2012','"+month+"','"+districtId+"','"+delhiProgramID+"','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
							} else {
								if (programeCode == 58) {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0','0')";
								} else {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								}
							}
						}

					}

					// svs-state programs

					// /////////////////////////////////////SVS STATE
					// PROGRAMES////////////////////////////////////////////////////////
					else if (programeCode == 03 || programeCode == 4
							|| programeCode == 05 || programeCode == 06
							|| programeCode == 46 || programeCode == 57
							|| programeCode == 12 || programeCode == 63
							|| programeCode == 15 || programeCode == 14
							|| programeCode == 9 || programeCode == 10
							|| programeCode == 00 || programeCode == 13
							|| programeCode == 16 || programeCode == 21
							|| programeCode == 20 || programeCode == 25
							|| programeCode == 26 || programeCode == 29
							|| programeCode == 34 || programeCode == 35
							|| programeCode == 38 || programeCode == 39
							|| programeCode == 40 || programeCode == 41
							|| programeCode == 42 || programeCode == 43
							|| programeCode == 44 || programeCode == 45
							|| programeCode == 54 || programeCode == 56
							|| programeCode == 64 || programeCode == 65
							|| programeCode == 66 || programeCode == 67) {
						// State Exp.- NABARD(04), State Plan(46), World
						// Bank(APRWSP-WB)57, HUDCO(12), TFC(63) (100%) & GOI 0%
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
							delhiProgramID = 3;
							delhiProgramName = "MNP (State Funds)";
							break;

						case 06:
							delhiProgramID = 22;
							delhiProgramName = "NABARD";
							break;
						}

						if (subprogrameCode == 0 || subprogrameCode == 1) {
							if (work_id.substring(6, 8).equals("11")) {
								insertQuery = "insert into SchemeExpenditure values('"
										+ work_id
										+ "','"
										+ workName
										+ "','"
										+ y
										+ "','"
										+ month
										+ "','"
										+ districtId
										+ "','"
										+ delhiProgramID
										+ "','"
										+ delhiProgramName
										+ "','0','0','0','0','0','"
										+ bankAmount
										+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')"; // correct
							} else {
								if (programeCode == 58 || programeCode == 11) {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0')";
								} else {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								}
							}
						} else if (subprogrameCode == 2) {
							if (work_id.substring(6, 8).equals("11")) {
								insertQuery = "insert into SchemeExpenditure values('"
										+ work_id
										+ "','"
										+ workName
										+ "','"
										+ y
										+ "','"
										+ month
										+ "','"
										+ districtId
										+ "','"
										+ delhiProgramID
										+ "','"
										+ delhiProgramName
										+ "','0','0','0','"
										+ bankAmount
										+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
							} else {
								if (programeCode == 58) {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0','0')";
								} else {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								}
							}
						} else if (subprogrameCode == 3 || subprogrameCode == 4) { // if
							// we
							// get
							// subprogrammes
							// other
							// than
							// sc,plain,st
							// we
							// are
							// taken
							// as
							// st
							if (work_id.substring(6, 8).equals("11")) {
								insertQuery = "insert into SchemeExpenditure values('"
										+ work_id
										+ "','"
										+ workName
										+ "','"
										+ y
										+ "','"
										+ month
										+ "','"
										+ districtId
										+ "','"
										+ delhiProgramID
										+ "','"
										+ delhiProgramName
										+ "','0','0','0','0','"
										+ bankAmount
										+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
							} else {
								if (programeCode == 58) {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0')";
								} else {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								}
							}
						} else if (subprogrameCode == 5 || subprogrameCode == 6
								|| subprogrameCode == 7 || subprogrameCode == 8
								|| subprogrameCode == 9
								|| subprogrameCode == 10
								|| subprogrameCode == 11
								|| subprogrameCode == 12
								|| subprogrameCode == 13) { // if
							// we
							// get
							// subprogrammes
							// other
							// than
							// sc,plain,st
							// we
							// are
							// taken
							// as
							// st
							if (work_id.substring(6, 8).equals("11")) {
								// insertQuery="insert into SchemeExpenditure
								// values('"+work_id+"','"+workName+"','2012','"+month+"','"+districtId+"','"+delhiProgramID+"','0','0','0','0','0','"+bankAmount+"','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
							} else {
								if (programeCode == 58) {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0','0')";
								} else {
									insertQuery = "insert into SchemeExpenditure values('"
											+ work_id
											+ "','"
											+ workName
											+ "','"
											+ y
											+ "','"
											+ month
											+ "','"
											+ districtId
											+ "','"
											+ delhiProgramID
											+ "','"
											+ delhiProgramName
											+ "','0','"
											+ bankAmount
											+ "','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0','0')";
								}
							}
						}

					}

				}
				// System.out.println("Records inserted:" + rcount);

				// System.out.println("Insert Query:"+insertQuery);
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

			String finalinsert = "select * from SchemeExpenditure";
			rsnew = stmtnew.executeQuery(finalinsert);
			// System.out.println("StaRTING Process");
			while (rsnew.next()) {
				StateId = "002";
				DistrictId = rsnew.getString(5);
				SchemeId = rsnew.getString(1);
				MonthId = rsnew.getInt(4);
				YearId = rsnew.getInt(3);
				ProgrammeComponent = rsnew.getInt(6);
				SCGOIExpenditure = rsnew.getInt(8);
				STGOIExpenditure = rsnew.getInt(9);
				GENGOIExpenditure = rsnew.getInt(10);
				SCGOIExpenditureSchool = rsnew.getInt(11);
				STGOIExpenditureSchool = rsnew.getInt(12);
				GENGOIExpenditureSchool = rsnew.getInt(13);
				SCStateExpenditure = rsnew.getInt(14);
				STStateExpenditure = rsnew.getInt(15);
				GENStateExpenditure = rsnew.getInt(16);
				SCStateExpenditureSchool = rsnew.getInt(17);
				STStateExpenditureSchool = rsnew.getInt(18);
				GENStateExpenditureSchool = rsnew.getInt(19);
				SCDDPExpenditure = rsnew.getInt(20);
				STDDPExpenditure = rsnew.getInt(21);
				GENDDPExpenditure = rsnew.getInt(22);
				SCDDPExpenditureSchool = rsnew.getInt(23);
				STDDPExpenditureSchool = rsnew.getInt(24);
				GENDDPExpenditureSchool = rsnew.getInt(25);
				SCCommunityExpenditure = rsnew.getInt(26);
				STCommunityExpenditure = rsnew.getInt(27);
				GENCommunityExpenditure = rsnew.getInt(28);
				SCCommunityExpenditureSchool = rsnew.getInt(29);
				STCommunityExpenditureSchool = rsnew.getInt(30);
				GENCommunityExpenditureSchool = rsnew.getInt(31);
				ExpectedDateOfCompletion = "";
				PhysicalDateOfCompletion = "";
				FinancialDateOfCompletion = "";
				HandedOverToCommunityDate = "-";
				FullyHandedOverToOM = "-";
				FundingSupport = 0;
				if (ProgrammeComponent == 1 || ProgrammeComponent == 13
						|| ProgrammeComponent == 14 || ProgrammeComponent == 19
						|| ProgrammeComponent == 20 || ProgrammeComponent == 21) {
					prgcomp = 1;
				} else if (ProgrammeComponent == 15 || ProgrammeComponent == 18
						|| ProgrammeComponent == 3 || ProgrammeComponent == 34) {
					prgcomp = 2;
				} else if (ProgrammeComponent == 31 || ProgrammeComponent == 7) {
					prgcomp = 3;
				} else {
					prgcomp = 1;
				}
				actualInsert = "insert into Backend_FinMPRScheme(StateId,	DistrictId	,SchemeId ,MonthId, YearId,ProgrammeComponent,	SCGOIExpenditure	,STGOIExpenditure,	GENGOIExpenditure	,  SCGOIExpenditureSchool   ,STGOIExpenditureSchool  , GENGOIExpenditureSchool,	  SCStateExpenditure,	  STStateExpenditure	,  GENStateExpenditure	  ,SCStateExpenditureSchool	,  STStateExpenditureSchool	,  GENStateExpenditureSchool	 , SCCommunityExpenditure,	  STCommunityExpenditure	,  GENCommunityExpenditure,	  SCCommunityExpenditureSchool	,  STCommunityExpenditureSchool,	  GENCommunityExpenditureSchool,	  SCDDPExpenditure,	  STDDPExpenditure,	  GENDDPExpenditure	,  SCDDPExpenditureSchool	,  STDDPExpenditureSchool	,  GENDDPExpenditureSchool	,  ExpectedDateOfCompletion,PhysicalDateOfCompletion,FinancialDateOfCompletion,	HandedOverToCommunityDate,FullyHandedOverToOM	,FundingSupport	)values('"
						+ StateId
						+ "',	'"
						+ DistrictId
						+ "'	,'"
						+ SchemeId
						+ "' ,"
						+ MonthId
						+ ", "
						+ YearId
						+ ",'"
						+ ProgrammeComponent
						+ "',	"
						+ SCGOIExpenditure
						+ "	,"
						+ STGOIExpenditure
						+ ",	"
						+ GENGOIExpenditure
						+ "	, "
						+ SCGOIExpenditureSchool
						+ "   ,"
						+ STGOIExpenditureSchool
						+ "  ,"
						+ GENGOIExpenditureSchool
						+ ",	 "
						+ SCStateExpenditure
						+ ",	 "
						+ STStateExpenditure
						+ "	, "
						+ GENStateExpenditure
						+ "	  ,"
						+ SCStateExpenditureSchool
						+ "	, "
						+ STStateExpenditureSchool
						+ "	, "
						+ GENStateExpenditureSchool
						+ "	 , "
						+ SCCommunityExpenditure
						+ ",	 "
						+ STCommunityExpenditure
						+ "	,  "
						+ GENCommunityExpenditure
						+ ",	 "
						+ SCCommunityExpenditureSchool
						+ "	,  "
						+ STCommunityExpenditureSchool
						+ ",	  "
						+ GENCommunityExpenditureSchool
						+ ",	  "
						+ SCDDPExpenditure
						+ ",	 "
						+ STDDPExpenditure
						+ ",	 "
						+ GENDDPExpenditure
						+ "	, "
						+ SCDDPExpenditureSchool
						+ ", "
						+ STDDPExpenditureSchool
						+ ", "
						+ GENDDPExpenditureSchool
						+ "	,  '"
						+ ExpectedDateOfCompletion
						+ "','"
						+ PhysicalDateOfCompletion
						+ "','"
						+ FinancialDateOfCompletion
						+ "',	'"
						+ HandedOverToCommunityDate
						+ "','"
						+ FullyHandedOverToOM + "'	,'" + prgcomp + "')";
				// System.out.println("actual insert "+actualInsert);
				rcount_actual += stmtactual.executeUpdate(actualInsert);
				conn.commit();
				conn.setAutoCommit(true);
			}

			String date1 = "update Backend_FinMPRScheme a set a.ExpectedDateOfCompletion=(select nvl(to_char(PROBABLE_DATE,'mm/dd/yyyy'),'-') from rws_contractor_selection_tbl b where a.schemeID=b.work_id)";
			stmtd1.executeUpdate(date1);
			// System.out.println("update qry1 " + date1);
			conn.commit();
			conn.setAutoCommit(true);

			String date2 = "update Backend_FinMPRScheme a set a.PhysicalDateOfCompletion=(select nvl(to_char(DATE_OF_COMPLETION,'mm/dd/yyyy'),'-') from rws_work_completion_tbl b where a.schemeID=b.work_id) ";
			stmtd2.executeUpdate(date2);
			// System.out.println("update qry2 " + date2);
			conn.commit();
			conn.setAutoCommit(true);

			String date3 = "update Backend_FinMPRScheme a set a.FINANCIALDATEOFCOMPLETION=(select nvl(to_char(DT_FIN_COMPLETION,'mm/dd/yyyy'),'-') from rws_work_completion_tbl b where a.schemeID=b.work_id)";
			stmtd3.executeUpdate(date3);
			// System.out.println("update qry3 " + date3);
			conn.commit();
			conn.setAutoCommit(true);

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			try {

			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		if (rcount_actual > 0) {
			finflag = true;
		} else {
			finflag = false;
		}
		return finflag;
	}

	public boolean createHabsMPRforWorkList(Connection conn) {
		boolean finflag = false;
		ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null, rs5 = null, rs6 = null;
		int household = 0;
		int mprcount = 0;
		ResultSet rs7 = null, rs8 = null, rs9 = null, rs10 = null, rstblcr = null, rstbldel = null, rstblsel = null;
		Statement st7 = null, st8 = null, st9 = null, st10 = null, sttblcr = null, sttbldel = null, sttblsel = null;
		String qry9 = "", stateid = "", districtid = "", habitationid = "", mstatus = "", mscheme = "", qry10 = "";
		int monthid = 0, yearid = 0, yearid1 = 0, sc = 0, st = 0, gen = 0, thold = 0, tconnection = 0;
		String Query = "";
		String insertQuery = "";
		String SchemeId = "", Habitationid = "", Status = "";
		int Monthid = 0, YearId = 0, SCPopCovered = 0, STPopCovered = 0, GenPopCovered = 0, HouseConnection = 0;
		int notfoundcount = 0;
		try {
			int rcount = 0;

			String empty = "", workid = "";
			String qry7 = "", qry8 = "";
			int contaminated = 0, rowcount = 0;

			Statement stmt = conn.createStatement();
			Statement stmt1 = conn.createStatement();
			Statement stmt2 = conn.createStatement();
			Statement stmt3 = conn.createStatement();
			Statement stmt4 = conn.createStatement();
			Statement stmt5 = conn.createStatement();
			Statement astmt1 = conn.createStatement();
			st7 = conn.createStatement();
			st8 = conn.createStatement();
			st9 = conn.createStatement();
			st10 = conn.createStatement();

			// ///////////////////////////////////////////////////////////////////////////////////

			// /////////////////////////////////////////////////////////////
			String selquery = "Select tname from tab where tname like 'PHYSICALMPR'";
			rs4 = stmt4.executeQuery(selquery);
			if (!rs4.next()) {
				String Query1 = "CREATE table PhysicalMPR(Hab_Code varchar(16),MonthId number(2),YearId number(4),SCCoveredPop number(8,2),STCoveredPop number(8,2),GENCoveredPop number(8,2),TotalHouseHolds number(5),HouseConnections number(5),StatusUpToMonth varchar2(2),SchemeId varchar2(14))";
				stmt.executeUpdate(Query1);
				conn.setAutoCommit(true);
				System.out.println("Query1:" + Query1);
			} else {
				String Query1 = "delete from PhysicalMPR";
				stmt.executeUpdate(Query1);
				conn.setAutoCommit(true);
				System.out.println("Query1:" + Query1);
			}
			String Query2 = "";

			String q11 = "select distinct WORK_ID from works_temp ";
			// System.out.println("tbl qry"+q1);
			ResultSet rr11 = astmt1.executeQuery(q11);

			while (rr11.next()) {
				workid = rr11.getString(1);
				System.out.println("workid " + workid);

				Query2 = "select  distinct b.work_id,d.CENSUS_SC_POPU,d.CENSUS_ST_POPU,d.CENSUS_PLAIN_POPU,c.HOUSE_CONN,d.COVERAGE_STATUS,c.hab_code,to_char(b.update_date,'mm'),to_char(b.update_date,'yyyy'),household_no from rws_work_admn_tbl c,RWS_WORK_COMPLETION_TBL b,RWS_WORK_COMP_HAB_LNK_TBL c,RWS_COMPLETE_HAB_VIEW d, rws_habitation_directory_tbl h where c.work_id=b.work_id and c.CATEGORY_CODE <> '3' and substr(c.work_id,7,2)<>'11' and h.hab_code=d.panch_code and  b.work_id=c.work_id and c.hab_code=d.panch_code and b.DATE_OF_COMPLETION is not null and "
						+ " b.work_id='"
						+ workid
						+ "' AND d.COVERAGE_STATUS not in('UI',' ')";
				rs1 = stmt1.executeQuery(Query2);
				System.out.println("select Query2:" + Query2);
				while (rs1.next()) {
					String Query4 = "", pstatus = "";
					SchemeId = rs1.getString(1);
					SCPopCovered = rs1.getInt(2);
					STPopCovered = rs1.getInt(3);
					GenPopCovered = rs1.getInt(4);
					HouseConnection = rs1.getInt(5);
					Status = rs1.getString(6);
					Habitationid = rs1.getString(7);
					Monthid = rs1.getInt(8);
					yearid = rs1.getInt(9);
					household = rs1.getInt(10);

					if (Status.equals("PC1") || Status.equals("PC2")
							|| Status.equals("PC3") || Status.equals("PC4"))
						pstatus = "PC";
					else
						pstatus = Status;
					if (HouseConnection != 0) {
						Query4 = "insert into PhysicalMPR(Hab_Code,MonthId,YearId,SCCoveredPop,STCoveredPop,GENCoveredPop,TotalHouseHolds,HouseConnections,StatusUpToMonth,SchemeId) values('"
								+ Habitationid
								+ "',"
								+ Monthid
								+ ","
								+ yearid
								+ ","
								+ SCPopCovered
								+ ","
								+ STPopCovered
								+ ","
								+ GenPopCovered
								+ ","
								+ household
								+ ","
								+ HouseConnection
								+ ",'"
								+ pstatus
								+ "','"
								+ SchemeId + "')"; // correct
					} else {
						Query4 = "insert into PhysicalMPR(Hab_Code,MonthId,YearId,SCCoveredPop,STCoveredPop,GENCoveredPop,TotalHouseHolds,HouseConnections,StatusUpToMonth,SchemeId) values('"
								+ Habitationid
								+ "',"
								+ Monthid
								+ ","
								+ yearid
								+ ","
								+ SCPopCovered
								+ ","
								+ STPopCovered
								+ ","
								+ GenPopCovered
								+ ","
								+ household
								+ ",'0','"
								+ pstatus + "','" + SchemeId + "')"; // correct
						// '"+SchemeId+"',
					}
					// System.out.println("Insert Query4:"+Query4);
					if (!insertQuery.equals(" ")) {
						rcount += stmt2.executeUpdate(Query4);
					}
					// Added on 03/11/2012
					qry7 = "Select tname from tab where tname like 'BACKEND_HABSMPR'";
					rs7 = st7.executeQuery(qry7);
					if (!rs7.next()) {
						qry8 = "CREATE table Backend_HabsMPR(StateId varchar2(3),DistrictId varchar2(5),HabitationId varchar2(50) not null,MonthId number(2) not null,YearId number(4) not null,SCCoveredPop number(8,2),STCoveredPop number(8,2),GENCoveredPop number(8,2),TotalHouseHolds number(5),HouseConnections number(5),StatusUpToMonth varchar2(2),SchemeId varchar2(14) not null)";
						st8.executeUpdate(qry8);
						conn.setAutoCommit(true);
						System.out.println("Query8:" + qry8);
					} else {
						qry8 = "delete from Backend_HabsMPR";
						st8.executeUpdate(qry8);
						conn.setAutoCommit(true);
						// System.out.println("Query8:" + qry8);
					}
				}
			}
			// Added on 03/11/2012 for MPR table
			// Added on 03/11/2012
			qry9 = "select a.StateId,a.DistrictId,a.HabitationId,b.MonthId,b.YearId,b.SCCoveredPop,b.STCoveredPop,b.GENCoveredPop,b.TotalHouseHolds,b.HouseConnections,b.StatusUpToMonth,b.SchemeId from IMISMASTERDATA1 a,PhysicalMPR b where b.Hab_Code=a.HABCODE";
			// System.out.println("select Query9:"+qry9);
			rs9 = st9.executeQuery(qry9);

			while (rs9.next()) {
				stateid = rs9.getString(1);
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
				qry10 = "insert into Backend_HabsMPR(StateId,DistrictId,HabitationId,MonthId,YearId,SCCoveredPop,STCoveredPop,GENCoveredPop,TotalHouseHolds,HouseConnections,StatusUpToMonth,SchemeId)	values('"
						+ stateid
						+ "','"
						+ districtid
						+ "','"
						+ habitationid
						+ "',"
						+ monthid
						+ ","
						+ yearid1
						+ ","
						+ sc
						+ ",		   "
						+ st
						+ ","
						+ gen
						+ ","
						+ thold
						+ ","
						+ tconnection
						+ ",'" + mstatus + "','" + mscheme + "')";

				// System.out.println("Insert Query10:"+qry10);
				mprcount += st10.executeUpdate(qry10);

				// Added on 03/11/2012
				String sno = "";
				if (mprcount > 0) {
					finflag = true;
				}

			}
		} catch (Exception e) {
			// System.out.println("Final Query:" + insertQuery);
			e.printStackTrace();

		}
		return finflag;
	}

	public boolean createSchoolsMPRforWorksList(Connection conn) {
		boolean finflag = false;
		ResultSet rs1 = null, rs2 = null, rs3 = null, rs4 = null, rs5 = null, rs6 = null, rss6 = null, rss7 = null, rstblcr = null, rstbldel = null, rstblsel = null;
		int household = 0;
		int mprcount = 0;
		// Added on 03/11/2012
		ResultSet rs7 = null, rs8 = null, rs9 = null, rs10 = null;
		Statement st7 = null, st8 = null, st9 = null, st10 = null, sttblcr = null, sttbldel = null, sttblsel = null;
		String qry9 = "", stateid = "", districtid = "", habitationid = "", mstatus = "", mscheme = "", qry10 = "";
		int monthid = 0, yearid = 0, sc = 0, st = 0, gen = 0, thold = 0, tconnection = 0;
		String Query = "";
		String insertQuery = "";
		String SchemeId = "", Habitationid = "", Status = "", schoolcode = "";
		int Monthid = 0, YearId = 0, SCPopCovered = 0, STPopCovered = 0, GenPopCovered = 0, HouseConnection = 0;
		int notfoundcount = 0;
		try {
			int rcount = 0;

			String empty = "", qq = "";
			String qry7 = "", qry8 = "";
			String habid = "", schoolid = "";
			int contaminated = 0, rowcount = 0;

			Statement stmt = conn.createStatement();
			Statement stmt1 = conn.createStatement();
			Statement stmt2 = conn.createStatement();
			Statement stmt3 = conn.createStatement();
			Statement stmt4 = conn.createStatement();
			Statement stmt5 = conn.createStatement();
			Statement stmt6 = conn.createStatement();
			Statement stmt7 = conn.createStatement();
			Statement stmt8 = conn.createStatement();
			Statement astmt1 = conn.createStatement();
			st7 = conn.createStatement();
			st8 = conn.createStatement();
			st9 = conn.createStatement();
			st10 = conn.createStatement();

			String selquery = "Select tname from tab where tname like 'SCHOOLMPR'";
			rs4 = stmt4.executeQuery(selquery);
			if (!rs4.next()) {
				String Query1 = "CREATE table SCHOOLMPR(Hab_Code varchar(16),MonthId number(2),YearId number(4),SchemeId varchar2(14),schoolcode varchar2(4))";
				stmt.executeUpdate(Query1);
				conn.setAutoCommit(true);
				System.out.println("Query1:" + Query1);
			} else {
				String Query1 = "delete from SCHOOLMPR";
				stmt.executeUpdate(Query1);
				conn.setAutoCommit(true);
				System.out.println("Query1:" + Query1);
			}

			// Added on 03/11/2012
			qry7 = "Select tname from tab where tname like 'BACKEND_SCHOOLMPR'";
			rs7 = st7.executeQuery(qry7);
			if (!rs7.next()) {
				qry8 = "create table Backend_SchoolMPR(StateId	varchar2(3) not null,DistrictId	varchar2(4) not null,HabitationId varchar2(10) not null,SchoolID	varchar2(10) not null,MonthId	number(2) not null,YearId	number(4) not null,SchemeId  varchar2(14) not null )";
				st8.executeUpdate(qry8);
				conn.setAutoCommit(true);
				// System.out.println("Query8:" + qry8);
			} else {
				qry8 = "delete from Backend_SchoolMPR";
				st8.executeUpdate(qry8);
				conn.setAutoCommit(true);
				// System.out.println("Query8:" + qry8);
			}

			String Query2 = "", workid = "";

			String q11 = "select distinct WORK_ID from works_temp ";
			// System.out.println("tbl qry"+q1);
			ResultSet rr11 = astmt1.executeQuery(q11);

			while (rr11.next()) {
				workid = rr11.getString(1);
				System.out.println("workid " + workid);

				Query2 = "select  distinct b.work_id,c.hab_code,to_char(b.update_date,'mm'),to_char(b.update_date,'yyyy'),c.school_code from RWS_WORK_COMPLETION_TBL b,RWS_WORK_SCHOOL_LNK_TBL c,RWS_COMPLETE_HAB_VIEW d where  b.work_id=c.work_id and c.hab_code=d.panch_code and b.DATE_OF_COMPLETION is not null and "
						+ " b.work_id='"
						+ workid
						+ "' AND d.COVERAGE_STATUS not in('UI',' ')";
				rs1 = stmt1.executeQuery(Query2);
				System.out.println("select Query2:" + Query2);
				while (rs1.next()) {
					String Query4 = "", pstatus = "";
					SchemeId = rs1.getString(1);
					Habitationid = rs1.getString(2);
					Monthid = rs1.getInt(3);
					YearId = rs1.getInt(4);
					schoolcode = rs1.getString(5);
					if (Status.equals("PC1") || Status.equals("PC2")
							|| Status.equals("PC3") || Status.equals("PC4"))
						pstatus = "PC";
					else
						pstatus = Status;
					Query4 = "insert into SCHOOLMPR(Hab_Code,MonthId,YearId,SchemeId,schoolcode) values('"
							+ Habitationid
							+ "',"
							+ Monthid
							+ ","
							+ YearId
							+ ",'" + SchemeId + "','" + schoolcode + "')"; // correct
					// .out.println("Insert Query4:"+Query4);
					if (!insertQuery.equals(" ")) {
						rcount += stmt2.executeUpdate(Query4);
					}

				}
			}
			// Added on 03/11/2012 for MPR table
			// Added on 03/11/2012
			qry9 = "select a.StateId,a.DistrictId,a.HabitationId,b.MonthId,b.YearId,b.SchemeId from IMISMASTERDATA1 a,SCHOOLMPR b where b.Hab_Code=a.HABCODE";
			// System.out.println("select Query9:"+qry9);
			rs9 = st9.executeQuery(qry9);

			while (rs9.next()) {
				stateid = rs9.getString(1);
				districtid = rs9.getString(2);
				habitationid = rs9.getString(3);
				monthid = rs9.getInt(4);
				yearid = rs9.getInt(5);
				mscheme = rs9.getString(6);

				qry10 = "insert into Backend_SCHOOLMPR(StateId,DistrictId,HabitationId,SchoolID,MonthId,YearId,SchemeId)	values('"
						+ stateid
						+ "','"
						+ districtid
						+ "','"
						+ habitationid
						+ "','00',"
						+ monthid
						+ ","
						+ yearid
						+ ",'"
						+ mscheme
						+ "')";
				// System.out.println("Insert Query10:"+qry10);
				mprcount += st10.executeUpdate(qry10);
				// Added on 03/11/2012
				String sno = "";
				conn.setAutoCommit(true);
			}

			qq = "SELECT backend_schoolmpr.habitationid,imisschoolmaster.schoolid FROM backend_schoolmpr INNER JOIN imisschoolmaster ON backend_schoolmpr.HabitationId = imisschoolmaster.habitationId";
			rss6 = stmt6.executeQuery(qq);
			Hashtable h = new Hashtable();
			while (rss6.next()) {
				h.put(rss6.getString(1), rss6.getString(2));
				// System.out.println(""+h.get(rss6.getString(2)));
			}

			String qq1 = "select HabitationId from backend_SCHOOLMPR ";
			// System.out.println("qq1"+qq1);
			rss7 = stmt7.executeQuery(qq1);

			while (rss7.next()) {

				schoolid = (String) h.get(rss7.getString(1));
				if (schoolid != null && !schoolid.equals("")) {
					schoolcode = schoolid;
				} else {
					schoolcode = "0";
				}
				// System.out.println("rss7.getString:::"+rss7.getString(1));
				String qq3 = "update backend_schoolmpr set schoolid='"
						+ schoolcode + "' where habitationid='"
						+ rss7.getString(1) + "'";
				stmt8.executeUpdate(qq3);
				// System.out.println("qq3"+qq3);
				conn.setAutoCommit(true);
			}

			if (mprcount > 0) {
				finflag = true;
			}

		} catch (Exception e) {
			// System.out.println("Final Query:" + insertQuery);
			e.printStackTrace();

		}
		return finflag;
	}

	// /writing to acces

	/**
	 * @param filename
	 */
	public boolean writeMPR(Database database) {

		boolean flag = false;
		Connection con = RwsOffices.getConn();
		Statement st = null, st1 = null, st2 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		try {

			String tableName = "Backend_FinMPRScheme"; // Creating table
			Table table1 = createTable(tableName).addColumn(
					new ColumnBuilder("StateId").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("DistrictId").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("SchemeId").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("MonthId").setSQLType(Types.NUMERIC)
							.toColumn()).addColumn(
					new ColumnBuilder("YearId").setSQLType(Types.NUMERIC)
							.toColumn()).addColumn(
					new ColumnBuilder("ProgrammeComponent").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("SCGOIExpenditure").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("STGOIExpenditure").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("GENGOIExpenditure").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("SCGOIExpenditureSchool").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("STGOIExpenditureSchool").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("GENGOIExpenditureSchool").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("SCStateExpenditure").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("STStateExpenditure").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("GENStateExpenditure").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("SCStateExpenditureSchool").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("STStateExpenditureSchool").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("GENStateExpenditureSchool").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("SCCommunityExpenditure").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("STCommunityExpenditure").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("GENCommunityExpenditure").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("SCCommunityExpenditureSchool")
							.setSQLType(Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("STCommunityExpenditureSchool")
							.setSQLType(Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("GENCommunityExpenditureSchool")
							.setSQLType(Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("SCDDPExpenditure").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("STDDPExpenditure").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("GENDDPExpenditure").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("SCDDPExpenditureSchool").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("STDDPExpenditureSchool").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("GENDDPExpenditureSchool").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("ExpectedDateOfCompletion").setSQLType(
							Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("PhysicalDateOfCompletion").setSQLType(
							Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("FinancialDateOfCompletion").setSQLType(
							Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("HandedOverToCommunityDate").setSQLType(
							Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("FullyHandedOverToOM").setSQLType(
							Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("FundingSupport").setSQLType(
							Types.NUMERIC).toColumn()).toTable(database);

			// /////////////////////////////////////

			String tableName1 = "Backend_HabsMPR"; // Creating table
			Table table2 = createTable(tableName1).addColumn(
					new ColumnBuilder("StateId").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("DistrictId").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("HabitationId").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("MonthId").setSQLType(Types.INTEGER)
							.toColumn()).addColumn(
					new ColumnBuilder("YearId").setSQLType(Types.INTEGER)
							.toColumn()).addColumn(
					new ColumnBuilder("SCCoveredPop").setSQLType(Types.INTEGER)
							.toColumn()).addColumn(
					new ColumnBuilder("STCoveredPop").setSQLType(Types.INTEGER)
							.toColumn()).addColumn(
					new ColumnBuilder("GENCoveredPop")
							.setSQLType(Types.INTEGER).toColumn()).addColumn(
					new ColumnBuilder("TotalHouseHolds").setSQLType(
							Types.INTEGER).toColumn()).addColumn(
					new ColumnBuilder("HouseConnections").setSQLType(
							Types.INTEGER).toColumn()).addColumn(
					new ColumnBuilder("StatusUpToMonth").setSQLType(
							Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("SchemeId").setSQLType(Types.VARCHAR)
							.toColumn()).toTable(database);

			// //////////////////////////////////////

			String tableName2 = "Backend_SchoolMPR"; // Creating table
			Table table3 = createTable(tableName2).addColumn(
					new ColumnBuilder("StateId").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("DistrictId").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("HabitationId").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("SchoolID").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("MonthId").setSQLType(Types.INTEGER)
							.toColumn()).addColumn(
					new ColumnBuilder("YearId").setSQLType(Types.INTEGER)
							.toColumn()).addColumn(
					new ColumnBuilder("SchemeId").setSQLType(Types.VARCHAR)
							.toColumn()).toTable(database);

			// //////////////////////////////////////////////////////

			Connection conn = RwsOffices.getConn();
			Statement stmt = conn.createStatement();
			ResultSet rrs = stmt
					.executeQuery("SELECT  * FROM Backend_FinMPRScheme");

			while (rrs.next()) {
				Object obj[] = new Object[36];
				obj[0] = rrs.getString(1);
				obj[1] = rrs.getString(2);
				obj[2] = rrs.getString(3);
				obj[3] = rrs.getString(4);
				obj[4] = rrs.getString(5);
				obj[5] = rrs.getString(6);
				obj[6] = rrs.getString(7);
				obj[7] = rrs.getString(8);
				obj[8] = rrs.getString(9);
				obj[9] = rrs.getString(10);
				obj[10] = rrs.getString(11);
				obj[11] = rrs.getString(12);
				obj[12] = rrs.getString(13);
				obj[13] = rrs.getString(14);
				obj[14] = rrs.getString(15);
				obj[15] = rrs.getString(16);
				obj[16] = rrs.getString(17);
				obj[17] = rrs.getString(18);
				obj[18] = rrs.getString(19);
				obj[19] = rrs.getString(20);
				obj[20] = rrs.getString(21);
				obj[21] = rrs.getString(22);
				obj[22] = rrs.getString(23);
				obj[23] = rrs.getString(24);
				obj[24] = rrs.getString(25);
				obj[25] = rrs.getString(26);
				obj[26] = rrs.getString(27);
				obj[27] = rrs.getString(28);
				obj[28] = rrs.getString(29);
				obj[29] = rrs.getString(30);
				obj[30] = rrs.getString(31);
				obj[31] = rrs.getString(32);
				obj[32] = rrs.getString(33);
				obj[33] = rrs.getString(34);
				obj[34] = rrs.getString(35);
				obj[35] = rrs.getString(36);
				table1.addRow(obj);
			}

			Statement stmt1 = conn.createStatement();
			ResultSet rrs1 = stmt1
					.executeQuery("SELECT  * FROM Backend_HabsMPR");

			while (rrs1.next()) {
				Object obj1[] = new Object[12];
				obj1[0] = rrs1.getString(1);
				obj1[1] = rrs1.getString(2);
				obj1[2] = rrs1.getString(3);
				obj1[3] = rrs1.getString(4);
				obj1[4] = rrs1.getString(5);
				obj1[5] = rrs1.getString(6);
				obj1[6] = rrs1.getString(7);
				obj1[7] = rrs1.getString(8);
				obj1[8] = rrs1.getString(9);
				obj1[9] = rrs1.getString(10);
				obj1[10] = rrs1.getString(11);
				obj1[11] = rrs1.getString(12);
				table2.addRow(obj1);
			}

			Statement stmt2 = conn.createStatement();
			ResultSet rrs2 = stmt2
					.executeQuery("SELECT  * FROM Backend_SchoolMPR");

			while (rrs2.next()) {
				Object obj2[] = new Object[7];
				obj2[0] = rrs2.getString(1);
				obj2[1] = rrs2.getString(2);
				obj2[2] = rrs2.getString(3);
				obj2[3] = rrs2.getString(4);
				obj2[4] = rrs2.getString(5);
				obj2[5] = rrs2.getString(6);
				obj2[6] = rrs2.getString(7);
				table3.addRow(obj2);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {

			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return flag;
	}

	public boolean writeFinancialMPR(Database database, Connection conn) {

		boolean flag = false;
		Statement st = null, st1 = null, st2 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		Statement stmt = null;
		try {
			stmt = conn.createStatement();
			String tableName = "Backend_FinMPRScheme"; // Creating table
			Table table1 = createTable(tableName).addColumn(
					new ColumnBuilder("StateId").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("DistrictId").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("SchemeId").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("MonthId").setSQLType(Types.NUMERIC)
							.toColumn()).addColumn(
					new ColumnBuilder("YearId").setSQLType(Types.NUMERIC)
							.toColumn()).addColumn(
					new ColumnBuilder("ProgrammeComponent").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("SCGOIExpenditure").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("STGOIExpenditure").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("GENGOIExpenditure").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("SCGOIExpenditureSchool").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("STGOIExpenditureSchool").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("GENGOIExpenditureSchool").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("SCStateExpenditure").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("STStateExpenditure").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("GENStateExpenditure").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("SCStateExpenditureSchool").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("STStateExpenditureSchool").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("GENStateExpenditureSchool").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("SCCommunityExpenditure").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("STCommunityExpenditure").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("GENCommunityExpenditure").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("SCCommunityExpenditureSchool")
							.setSQLType(Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("STCommunityExpenditureSchool")
							.setSQLType(Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("GENCommunityExpenditureSchool")
							.setSQLType(Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("SCDDPExpenditure").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("STDDPExpenditure").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("GENDDPExpenditure").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("SCDDPExpenditureSchool").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("STDDPExpenditureSchool").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("GENDDPExpenditureSchool").setSQLType(
							Types.NUMERIC).toColumn()).addColumn(
					new ColumnBuilder("ExpectedDateOfCompletion").setSQLType(
							Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("PhysicalDateOfCompletion").setSQLType(
							Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("FinancialDateOfCompletion").setSQLType(
							Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("HandedOverToCommunityDate").setSQLType(
							Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("FullyHandedOverToOM").setSQLType(
							Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("FundingSupport").setSQLType(
							Types.NUMERIC).toColumn()).toTable(database);
			// ExpectedDateOfCompletion is added on 20/08/2013
			ResultSet rrs = stmt
					.executeQuery("SELECT  * FROM Backend_FinMPRScheme");

			while (rrs.next()) {
				Object obj[] = new Object[36];
				obj[0] = rrs.getString(1);
				obj[1] = rrs.getString(2);
				obj[2] = rrs.getString(3);
				obj[3] = rrs.getString(4);
				obj[4] = rrs.getString(5);
				obj[5] = rrs.getString(6);
				obj[6] = rrs.getString(7);
				obj[7] = rrs.getString(8);
				obj[8] = rrs.getString(9);
				obj[9] = rrs.getString(10);
				obj[10] = rrs.getString(11);
				obj[11] = rrs.getString(12);
				obj[12] = rrs.getString(13);
				obj[13] = rrs.getString(14);
				obj[14] = rrs.getString(15);
				obj[15] = rrs.getString(16);
				obj[16] = rrs.getString(17);
				obj[17] = rrs.getString(18);
				obj[18] = rrs.getString(19);
				obj[19] = rrs.getString(20);
				obj[20] = rrs.getString(21);
				obj[21] = rrs.getString(22);
				obj[22] = rrs.getString(23);
				obj[23] = rrs.getString(24);
				obj[24] = rrs.getString(25);
				obj[25] = rrs.getString(26);
				obj[26] = rrs.getString(27);
				obj[27] = rrs.getString(28);
				obj[28] = rrs.getString(29);
				obj[29] = rrs.getString(30);
				obj[30] = rrs.getString(31);
				obj[31] = rrs.getString(32);
				obj[32] = rrs.getString(33);
				obj[33] = rrs.getString(34);
				obj[34] = rrs.getString(35);
				obj[35] = rrs.getString(36);
				table1.addRow(obj);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return flag;
	}

	//Deepak Modified
	public boolean writePhysicalMPR(Database database, Connection conn) {
		boolean flag = false;
		PreparedStatement st = null;
		ResultSet rs = null;
		Statement stmt1 = null;
		try {
			String tableName1 = "Backend_HabsMPR"; 
			Table table2 = createTable(tableName1).addColumn(
				new ColumnBuilder("StateId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
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
				new ColumnBuilder("SchemeId").setSQLType(Types.VARCHAR).toColumn()).toTable(database);
			st = conn.prepareStatement("SELECT  * FROM Backend_HabsMPR");
			rs = st.executeQuery();
			while (rs.next()) {
				Object obj1[] = new Object[12];
				obj1[0] = rs.getString(1);
				obj1[1] = rs.getString(2);
				obj1[2] = rs.getString(3);
				obj1[3] = rs.getString(4);
				obj1[4] = rs.getString(5);
				obj1[5] = rs.getString(6);
				obj1[6] = rs.getString(7);
				obj1[7] = rs.getString(8);
				obj1[8] = rs.getString(9);
				obj1[9] = rs.getString(10);
				obj1[10] = rs.getString(11);
				obj1[11] = rs.getString(12);
				table2.addRow(obj1);
			}
			flag = true;
		} catch (Exception e) {
			System.out.println("The Exception is in RwsExcelSheet writePhysicalMPR : " + e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (st != null) {
					st.close();
				}

			} catch (Exception e) {
				System.out.println("The Exception is in RwsExcelSheet writePhysicalMPR : " + e.getMessage());
			}
		}
		return flag;
	}

	public boolean writeSchoolMPR(Database database, Connection conn) {

		boolean flag = false;
		Statement st = null, st1 = null, st2 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		Statement stmt2 = null;
		try {
			stmt2 = conn.createStatement();

			String tableName2 = "Backend_SchoolMPR"; // Creating table
			Table table3 = createTable(tableName2).addColumn(
					new ColumnBuilder("StateId").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("DistrictId").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("HabitationId").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("SchoolID").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("MonthId").setSQLType(Types.INTEGER)
							.toColumn()).addColumn(
					new ColumnBuilder("YearId").setSQLType(Types.INTEGER)
							.toColumn()).addColumn(
					new ColumnBuilder("SchemeId").setSQLType(Types.VARCHAR)
							.toColumn()).toTable(database);

			ResultSet rrs2 = stmt2
					.executeQuery("SELECT  * FROM Backend_SchoolMPR");

			while (rrs2.next()) {
				Object obj2[] = new Object[7];
				obj2[0] = rrs2.getString(1);
				obj2[1] = rrs2.getString(2);
				obj2[2] = rrs2.getString(3);
				obj2[3] = rrs2.getString(4);
				obj2[4] = rrs2.getString(5);
				obj2[5] = rrs2.getString(6);
				obj2[6] = rrs2.getString(7);
				table3.addRow(obj2);
			}
			flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt2 != null) {
					stmt2.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return flag;
	}

//	public boolean exportQueryResultToAccDB(String db2Query,
//			String accessFileName, String accessExportTableName)
//			throws Exception {
//		boolean flag = false;
//		try {
//			// Database database = createDatabase(accessFileName);
//			Connection conn = RwsOffices.getConn();
//			Statement statement = conn.createStatement();
//			ResultSet resultSet = statement.executeQuery(db2Query);
//			Database.open(new File(accessFileName)).copyTable(
//					accessExportTableName, resultSet);
//			conn.close();
//			flag = true;
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//		return flag;
//	}

	/**
	 * @param filename
	 */
	public boolean createFile(String filename) {
		boolean flag = false;
		try {
			Database database = createDatabase(filename);// TODO Auto-generated
			// method stub
			flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return flag;
	}

	//Deepak Modified
	public boolean writeRws_Schemes_Tbl1(Database database, Connection conn) {
		boolean flag = false;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			String tableName = "Backend_Schemes_Schemes"; 
			Table table1 = createTable(tableName).addColumn(
				new ColumnBuilder("SchemeIdOfState").setSQLType(Types.VARCHAR).toColumn()).addColumn(
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
				new ColumnBuilder("Capacity").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("ServiceLevel").setSQLType(Types.NUMERIC).toColumn()).addColumn(
				new ColumnBuilder("Expenditure").setSQLType(Types.NUMERIC).toColumn()).addColumn(
				new ColumnBuilder("ExpMoreReason").setSQLType(Types.NUMERIC).toColumn()).addColumn(
				new ColumnBuilder("DateOfCommencement").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("DateOfCompletion").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("PhysicalCompletionDate").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("FinancialCompletionDate").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("HandedCommunityDate2222").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("IsFullyPRI").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("Category").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("IsWasteWaterMgmt").setSQLType(Types.NUMERIC).toColumn()).addColumn(
				new ColumnBuilder("WasteWaterMNREGAS").setSQLType(Types.NUMERIC).toColumn()).addColumn(
				new ColumnBuilder("WasteWaterTSC").setSQLType(Types.NUMERIC).toColumn()).addColumn(
				new ColumnBuilder("WasteWaterOTH").setSQLType(Types.NUMERIC).toColumn()).toTable(database);
			st = conn.prepareStatement("SELECT SchemeIdOfState,MainSchemeId_IMIS,SchemeName,StateId,DistrictId,SchemeTypeId,Type,SanctionYear,EstimatedCost,RevisedEstimatedCost,GOICost,StateCost,CommCont,PopulationCovered,Capacity,ServiceLevel,Expenditure,ExpMoreReason,to_char(DateOfCommencement,'mm/dd/yyyy'),nvl(to_char(DateOfCompletion,'mm/dd/yyyy'),''),nvl(to_char(PhysicalCompletionDate,'mm/dd/yyyy'),''),nvl(to_char(FinancialCompletionDate,'mm/dd/yyyy'),''),nvl(to_char(HandedCommunityDate,'mm/dd/yyyy'),''),nvl(IsFullyPRI,''),nvl(Category,''),nvl(IsWasteWaterMgmt,0),nvl(WasteWaterMNREGAS,0),nvl(WasteWaterTSC,0),nvl(WasteWaterOTH,0) FROM RWS_SCHEMES_TEMP_TBL");
			rs = st.executeQuery();
			while (rs.next()) {
				Object obj[] = new Object[29];
				obj[0] = rs.getString(1);
				obj[1] = rs.getString(2);
				obj[2] = rs.getString(3);
				obj[3] = rs.getString(4);
				obj[4] = rs.getString(5);
				obj[5] = rs.getString(6);
				obj[6] = rs.getString(7);
				obj[7] = rs.getString(8);
				obj[8] = rs.getInt(9);
				obj[9] = rs.getString(10);
				obj[10] = rs.getString(11);
				obj[11] = rs.getString(12);
				obj[12] = rs.getString(13);
				obj[13] = rs.getString(14);
				obj[14] = rs.getString(15);
				obj[15] = rs.getString(16);
				obj[16] = rs.getInt(17);
				obj[17] = rs.getInt(18);
				obj[18] = rs.getString(19);
				obj[19] = rs.getString(20);
				obj[20] = rs.getString(21);
				obj[21] = rs.getString(22);
				obj[22] = rs.getString(23);
				obj[23] = rs.getString(24);
				obj[24] = rs.getString(25);
				obj[25] = rs.getString(26);
				obj[26] = rs.getString(27);
				obj[27] = rs.getString(28);
				obj[28] = rs.getString(29);				
				table1.addRow(obj);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsExcelSheet writeRws_Schemes_Tbl1 : " + e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (st != null) {
					st.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in RwsExcelSheet writeRws_Schemes_Tbl1 : " + e.getMessage());
			}
		}
		return flag;
	}

	public boolean writeRWS_SchemeSources_Tbl2(Database database, Connection conn) {
		boolean flag = false;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
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
				new ColumnBuilder("IsInSchool").setSQLType(Types.NUMERIC).toColumn()).addColumn(
				new ColumnBuilder("DateOfCommissioning").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("Latitude").setSQLType(Types.NUMERIC).toColumn()).addColumn(
				new ColumnBuilder("Longitude").setSQLType(Types.NUMERIC).toColumn()).addColumn(
				new ColumnBuilder("Elevation").setSQLType(Types.NUMERIC).toColumn()).toTable(database);
			st = conn.prepareStatement("SELECT SourcesIdOfState,SchemeIdOfState,SourceTypeId,SourceTypeCategoryId,StateID,DistrictId,HabitationId,Location,SchoolId,IsInSchool,to_char(DateOfCommissioning,'mm/dd/yyyy') ,Latitude,Longitude,Elevation  FROM RWS_SCHEMESOURCES_TEMP_TBL");
			rs = st.executeQuery();
			while (rs.next()) {
				Object obj[] = new Object[14];
				obj[0] = rs.getString(1);
				obj[1] = rs.getString(2);
				obj[2] = rs.getString(3);
				obj[3] = rs.getString(4);
				obj[4] = rs.getString(5);
				obj[5] = rs.getString(6);
				obj[6] = rs.getString(7);
				obj[7] = rs.getString(8);
				obj[8] = rs.getString(9);
				obj[9] = rs.getString(10);
				obj[10] = rs.getString(11);
				obj[11] = rs.getString(12);
				obj[12] = rs.getString(13);
				obj[13] = rs.getString(14);
				table1.addRow(obj);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsExcelSheet writeRWS_SchemeSources_Tbl2 : " + e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (st != null) {
					st.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in RwsExcelSheet writeRWS_SchemeSources_Tbl2 : " + e.getMessage());
			}
		}
		return flag;
	}

	public boolean writeRWS_SchemesProgrammes_Tbl3(Database database, Connection conn) {
		boolean flag = false;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			String tableName = "Backend_Schemes_SchemesProgrammes"; 
			Table table1 = createTable(tableName).addColumn(
				new ColumnBuilder("SchemeIdOfState").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("ProgrammeId").setSQLType(Types.VARCHAR).toColumn()).toTable(database);
			st = conn.prepareStatement("SELECT * FROM RWS_SCHEMESPROGRAMMES_TEMP_TBL");
			rs = st.executeQuery();
			while (rs.next()) {
				Object obj[] = new Object[2];
				obj[0] = rs.getString(1);
				obj[1] = rs.getString(2);
				table1.addRow(obj);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsExcelSheet writeRWS_SchemesProgrammes_Tbl3 : " + e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (st != null) {
					st.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in RwsExcelSheet writeRWS_SchemesProgrammes_Tbl3 : " + e.getMessage());
			}
		}
		return flag;
	}

	public boolean writeRWS_SchemeHabs_Tbl4(Database database, Connection conn) {
		boolean flag = false;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			String tableName = "Backend_Schemes_HabitationsCovered"; 
			Table table1 = createTable(tableName).addColumn(
				new ColumnBuilder("DeleveryPointId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("SchemeIdOfState").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("StateID").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("DistrictId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("HabitationId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("Location").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("SchoolId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("IsInSchool").setSQLType(Types.NUMERIC).toColumn()).addColumn(
				new ColumnBuilder("DateOfCommissioning").setSQLType(Types.DATE).toColumn()).addColumn(
				new ColumnBuilder("Latitude").setSQLType(Types.NUMERIC).toColumn()).addColumn(
				new ColumnBuilder("Longitude").setSQLType(Types.NUMERIC).toColumn()).addColumn(
				new ColumnBuilder("Elevation").setSQLType(Types.NUMERIC).toColumn()).addColumn(
				new ColumnBuilder("Del_House").setSQLType(Types.VARCHAR).toColumn()).toTable(database);
			st = conn.prepareStatement("SELECT * FROM RWS_SCHEMEHABS_TEMP_TBL");
			rs = st.executeQuery();
			while (rs.next()) {
				Object obj[] = new Object[13];
				obj[0] = rs.getString(1);
				obj[1] = rs.getString(2);
				obj[2] = rs.getString(3);
				obj[3] = rs.getString(1);
				obj[4] = rs.getString(2);
				obj[5] = rs.getString(3);
				obj[6] = rs.getString(1);
				obj[7] = rs.getString(2);
				obj[8] = rs.getString(3);
				obj[9] = rs.getString(1);
				obj[10] = rs.getString(2);
				obj[11] = rs.getString(3);
				obj[12] = rs.getString(1);
				table1.addRow(obj);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsExcelSheet writeRWS_SchemeHabs_Tbl4 : " + e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (st != null) {
					st.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in RwsExcelSheet writeRWS_SchemeHabs_Tbl4 : " + e.getMessage());
			}
		}
		return flag;
	}

	public boolean writeRWS_SchemesImplementingAgency_Tbl5(Database database, Connection conn) {
		boolean flag = false;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			String tableName = "Backend_Schemes_SchemesImplementingAgency";
			Table table1 = createTable(tableName).addColumn(
				new ColumnBuilder("SchemeIdOfState").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("AgencyId").setSQLType(Types.VARCHAR).toColumn()).toTable(database);
			st = conn.prepareStatement("SELECT * FROM RWS_SCHIMPAGENCY_TEMP_TBL");			
			rs = st.executeQuery();
			while (rs.next()) {
				Object obj[] = new Object[2];
				obj[0] = rs.getString(1);
				obj[1] = rs.getString(2);
				table1.addRow(obj);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsExcelSheet writeRWS_SchemesImplementingAgency_Tbl5 : " + e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (st != null) {
					st.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in RwsExcelSheet writeRWS_SchemesImplementingAgency_Tbl5 : " + e.getMessage());
			}
		}
		return flag;
	}

	public boolean writeRWS_SchemesAgencyResForOM_Tbl6(Database database, Connection conn) {
		boolean flag = false;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			String tableName = "Backend_Schemes_SchemesAgencyResponsibleForOM";
			Table table1 = createTable(tableName).addColumn(
				new ColumnBuilder("SchemeIdOfState").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("AgencyResponsibleForOMID").setSQLType(Types.VARCHAR).toColumn()).toTable(database);
			st = conn.prepareStatement("SELECT * FROM RWS_SCHAGENCYRESFOROM_TEMP_TBL");
			rs = st.executeQuery();
			while (rs.next()) {
				Object obj[] = new Object[2];
				obj[0] = rs.getString(1);
				obj[1] = rs.getString(2);
				table1.addRow(obj);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in RwsExcelSheet writeRWS_SchemesAgencyResForOM_Tbl6 : " + e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (st != null) {
					st.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in RwsExcelSheet writeRWS_SchemesAgencyResForOM_Tbl6 : " + e.getMessage());
			}
		}
		return flag;
	}

	public boolean writeRWS_TargetHabs_Tbl7(Database database, Connection conn) {
		boolean flag = false;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			String tableName = "RWS_TargetHabs"; 
			Table table1 = createTable(tableName).addColumn(
				new ColumnBuilder("SchemeId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("HabitationId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("SchoolId").setSQLType(Types.VARCHAR).toColumn()).toTable(database);
			st = conn.prepareStatement("SELECT * FROM RWS_TARGETHABS_TEMP_TBL");
			rs = st.executeQuery();
			while (rs.next()) {
				Object obj[] = new Object[3];
				obj[0] = rs.getString(1);
				obj[1] = rs.getString(2);
				obj[2] = rs.getString(3);
				table1.addRow(obj);
			}
			flag = true;
		} catch (Exception e) {
			System.out.println("The Exception is in RwsExcelSheet writeRWS_TargetHabs_Tbl7 : " + e.getMessage());
		} finally {
			flag = true;
			try {
				if (rs != null) {
					rs.close();
				}
				if (st != null) {
					st.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in RwsExcelSheet writeRWS_TargetHabs_Tbl7 : " + e.getMessage());
			}
		}
		return flag;
	}

	//Deepak Modified
	public boolean writeRws_Dr_Schemes_Tbl1(Database database, Connection conn) {
		boolean flag = false;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			String tableName = "Rws_Schemes"; 
			Table table1 = createTable(tableName).addColumn(
				new ColumnBuilder("SchemeId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("MainSchemeId").setSQLType(Types.NUMERIC).toColumn()).addColumn(
				new ColumnBuilder("SchemeName").setSQLType(Types.LONGVARCHAR).toColumn()).addColumn(
				new ColumnBuilder("StateId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("DistrictId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("SchemeTypeId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("Type").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("SanctionYear").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("EstimatedCost").setSQLType(Types.DOUBLE).toColumn()).addColumn(
				new ColumnBuilder("RevisedEstimatedCost").setSQLType(Types.DOUBLE).toColumn()).addColumn(
				new ColumnBuilder("GOICost").setSQLType(Types.DOUBLE).toColumn()).addColumn(
				new ColumnBuilder("StateCost").setSQLType(Types.DOUBLE).toColumn()).addColumn(
				new ColumnBuilder("CommCont").setSQLType(Types.DOUBLE).toColumn()).addColumn(
				new ColumnBuilder("PopulationCovered").setSQLType(Types.DOUBLE).toColumn()).addColumn(
				new ColumnBuilder("Capacity").setSQLType(Types.DOUBLE).toColumn()).addColumn(
				new ColumnBuilder("ServiceLevel").setSQLType(Types.NUMERIC).toColumn()).addColumn(
				new ColumnBuilder("Expenditure").setSQLType(Types.DOUBLE).toColumn()).addColumn(
				new ColumnBuilder("ExpMoreReason").setSQLType(Types.NUMERIC).toColumn()).addColumn(
				new ColumnBuilder("DateOfCommencement").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("DateOfCompletion").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("ProjectShelfYear").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("Atmarpan").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("ProbableExpenditure").setSQLType(Types.DOUBLE).toColumn()).toTable(database);
			st = conn.prepareStatement("SELECT SchemeId,MainSchemeId,SchemeName,StateId,DistrictId,SchemeTypeId,Type,SanctionYear,EstimatedCost,RevisedEstimatedCost,GOICost,StateCost,CommCont,PopulationCovered,Capacity,ServiceLevel,Expenditure,ExpMoreReason,to_char(DateOfCommencement,'mm/dd/yyyy'),to_char(DateOfCompletion,'mm/dd/yyyy'),ProjectShelfYear,Atmarpan,ProbableExpenditure FROM RWS_DR_SCHEMES_TEMP_TBL");			
			rs = st.executeQuery();
			while (rs.next()) {
				Object obj[] = new Object[23];
				obj[0] = rs.getString(1);
				obj[1] = rs.getString(2);
				obj[2] = rs.getString(3);
				obj[3] = rs.getString(4);
				obj[4] = rs.getString(5);
				obj[5] = rs.getString(6);
				obj[6] = rs.getString(7);
				obj[7] = rs.getString(8);
				obj[8] = rs.getString(9);
				obj[9] = rs.getString(10);
				obj[10] = rs.getString(11);
				obj[11] = rs.getString(12);
				obj[12] = rs.getString(13);
				obj[13] = rs.getString(14);
				obj[14] = rs.getString(15);
				obj[15] = rs.getString(16);
				obj[16] = rs.getString(17);
				obj[17] = rs.getString(18);
				obj[18] = rs.getString(19);
				obj[19] = rs.getString(20);
				obj[20] = rs.getString(21);
				obj[21] = rs.getString(22);
				obj[22] = rs.getString(23);
				table1.addRow(obj);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Access writeRws_Dr_Schemes_Tbl1 : " + e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (st != null) {
					st.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Access writeRws_Dr_Schemes_Tbl1 : " + e.getMessage());
			}
		}
		return flag;
	}

	public boolean writeRWS_Dr_SchemeSources_Tbl2(Database database, Connection conn) {
		boolean flag = false;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			String tableName = "RWS_SchemeSources"; 
			Table table1 = createTable(tableName).addColumn(
				new ColumnBuilder("SchemesSourcesId").setSQLType(Types.NUMERIC).toColumn()).addColumn(
				new ColumnBuilder("SchemeId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("SourceTypeId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("StateID").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("DistrictId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("BlockId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("PanchayatId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("VillageId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("HabitationId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("Location").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("SchoolId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("IsInSchool").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("DateOfCommissioning").setSQLType(Types.VARCHAR).toColumn()).toTable(database);
			st = conn.prepareStatement("SELECT SchemesSourcesId,SchemeId,SourceTypeId,StateID,DistrictId,BlockId,PanchayatId,VillageId,HabitationId,Location,SchoolId,IsInSchool,to_char(DateOfCommissioning,'mm/dd/yyyy') FROM RWS_DR_SCHSOU_TEMP_TBL");
			rs = st.executeQuery();
			while (rs.next()) {
				Object obj[] = new Object[13];
				obj[0] = rs.getString(1);
				obj[1] = rs.getString(2);
				obj[2] = rs.getString(3);
				obj[3] = rs.getString(4);
				obj[4] = rs.getString(5);
				obj[5] = rs.getString(6);
				obj[6] = rs.getString(7);
				obj[7] = rs.getString(8);
				obj[8] = rs.getString(9);
				obj[9] = rs.getString(10);
				obj[10] = rs.getString(11);
				obj[11] = rs.getString(12);
				obj[12] = rs.getString(13);
				table1.addRow(obj);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Access writeRWS_Dr_SchemeSources_Tbl2 : " + e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (st != null) {
					st.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Access writeRWS_Dr_SchemeSources_Tbl2 : " + e.getMessage());
			}
		}
		return flag;
	}

	public boolean writeRWS_Dr_SchemesProgrammes_Tbl3(Database database, Connection conn) {
		boolean flag = false;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			String tableName = "RWS_SchemesProgrammes"; 
			Table table1 = createTable(tableName).addColumn(
				new ColumnBuilder("SchemeId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("ProgrammeId").setSQLType(Types.VARCHAR).toColumn()).toTable(database);
			st = conn.prepareStatement("SELECT * FROM RWS_DR_SCHPROG_TEMP_TBL");
			rs = st.executeQuery();
			while (rs.next()) {
				Object obj[] = new Object[2];
				obj[0] = rs.getString(1);
				obj[1] = rs.getString(2);
				table1.addRow(obj);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Access writeRWS_Dr_SchemesProgrammes_Tbl3 : " + e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (st != null) {
					st.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Access writeRWS_Dr_SchemesProgrammes_Tbl3 : " + e.getMessage());
			}
		}
		return flag;
	}

	public boolean writeRWS_Dr_SchemeHabs_Tbl4(Database database, Connection conn) {
		boolean flag = false;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			String tableName = "RWS_SchemeHabs"; 
			Table table1 = createTable(tableName).addColumn(
				new ColumnBuilder("SchemeId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("HabitationId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("SchoolId").setSQLType(Types.VARCHAR).toColumn()).toTable(database);
			st = conn.prepareStatement("SELECT * FROM RWS_DR_SCHEMEHABS_TEMP_TBL");
			rs = st.executeQuery();
			while (rs.next()) {
				Object obj[] = new Object[3];
				obj[0] = rs.getString(1);
				obj[1] = rs.getString(2);
				obj[2] = rs.getString(3);
				table1.addRow(obj);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Access writeRWS_Dr_SchemeHabs_Tbl4 : " + e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (st != null) {
					st.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Access writeRWS_Dr_SchemeHabs_Tbl4 : " + e.getMessage());
			}
		}
		return flag;
	}

	public boolean writeRWS_Dr_SchemesImplementingAgency_Tbl5(Database database, Connection conn) {
		boolean flag = false;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			String tableName = "RWS_SchemesImplementingAgency"; 
			Table table1 = createTable(tableName).addColumn(
				new ColumnBuilder("SchemeId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("AgencyId").setSQLType(Types.VARCHAR).toColumn()).toTable(database);
			st = conn.prepareStatement("SELECT * FROM RWS_DR_SCHIMPAGENCY_TEMP_TBL");
			rs = st.executeQuery();
			while (rs.next()) {
				Object obj[] = new Object[2];
				obj[0] = rs.getString(1);
				obj[1] = rs.getString(2);
				table1.addRow(obj);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Access writeRWS_Dr_SchemesImplementingAgency_Tbl5 : " + e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (st != null) {
					st.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Access writeRWS_Dr_SchemesImplementingAgency_Tbl5 : " + e.getMessage());
			}
		}
		return flag;
	}

	public boolean writeRWS_Dr_SchemesAgencyResForOM_Tbl6(Database database, Connection conn) {
		boolean flag = false;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			String tableName = "RWS_SchemesAgencyResForOM"; 
			Table table1 = createTable(tableName).addColumn(
				new ColumnBuilder("SchemeId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("AgencyResponsibleForOMID").setSQLType(Types.VARCHAR).toColumn()).toTable(database);
			st = conn.prepareStatement("SELECT * FROM RWS_DR_SCHAGRESFOROM_TEMP_TBL");
			rs = st.executeQuery();
			while (rs.next()) {
				Object obj[] = new Object[2];
				obj[0] = rs.getString(1);
				obj[1] = rs.getString(2);
				table1.addRow(obj);
			}
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Access writeRWS_Dr_SchemesAgencyResForOM_Tbl6 : " + e.getMessage());
		} finally {
			try {
				if (rs != null) {
					rs.close();
				}
				if (st != null) {
					st.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Access writeRWS_Dr_SchemesAgencyResForOM_Tbl6 : " + e.getMessage());
			}
		}
		return flag;
	}

	public boolean writeRWS_Dr_TargetHabs_Tbl7(Database database, Connection conn) {
		boolean flag = false;
		PreparedStatement st = null;
		ResultSet rs = null;
		try {
			String tableName = "RWS_TargetHabs"; 
			Table table1 = createTable(tableName).addColumn(
				new ColumnBuilder("SchemeId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("HabitationId").setSQLType(Types.VARCHAR).toColumn()).addColumn(
				new ColumnBuilder("SchoolId").setSQLType(Types.VARCHAR).toColumn()).toTable(database);
			st = conn.prepareStatement("SELECT * FROM RWS_Dr_TARGETHABS_TEMP_TBL");
			rs = st.executeQuery();
			while (rs.next()) {
				Object obj[] = new Object[3];
				obj[0] = rs.getString(1);
				obj[1] = rs.getString(2);
				obj[2] = rs.getString(3);
				table1.addRow(obj);
			}
			flag = true;
		} catch (Exception e) {
			System.out.println("The Exception is in Rws_Access writeRWS_Dr_TargetHabs_Tbl7 : " + e.getMessage());
		} finally {
			flag = true;
			try {
				if (rs != null) {
					rs.close();
				}				
				if (st != null) {
					st.close();
				}
			} catch (Exception e) {
				System.out.println("The Exception is in Rws_Access writeRWS_Dr_TargetHabs_Tbl7 : " + e.getMessage());
			}
		}
		return flag;
	}

	// //////////////////////////Water Quality FTK
	// Porting////////////////////////////////////////////////////////////

	public boolean writeWQ_FTKTestingDetails_Tbl1(Database database,
			Connection conn) {

		boolean flag = false;
		Statement st = null, st1 = null, st2 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		Statement stmt = null;
		try {
			stmt = conn.createStatement();
			String tableName = "WQ_FTKTestingDetails"; // Creating table
			Table table1 = createTable(tableName).addColumn(
					new ColumnBuilder("TestId").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("DDWS_TEST_ID").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("ParameterId").setSQLType(Types.VARCHAR)
							.toColumn()).toTable(database);

			ResultSet rrs = stmt
					.executeQuery("SELECT  * FROM WQ_FTKTestingDetails_Temp_Tbl");

			while (rrs.next()) {
				Object obj[] = new Object[3];
				obj[0] = rrs.getString(1);
				obj[1] = rrs.getString(2);
				obj[2] = rrs.getString(3);
				table1.addRow(obj);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return flag;
	}

	public boolean writeWQ_FTKWaterQualityTesting_Tbl2(Database database,
			Connection conn) {

		boolean flag = false;
		Statement st = null, st1 = null, st2 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		Statement stmt = null;
		try {
			stmt = conn.createStatement();
			String tableName = "WQ_WaterQualityTesting"; // Creating table
			Table table1 = createTable(tableName).addColumn(
					new ColumnBuilder("TestId").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("DDWS_TEST_ID").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("TestingDate").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("ContaminatedYes_No").setSQLType(
							Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("HabitationId").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("StateId").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("DistrictId").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("SchemeNo").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("GPId_testingDone").setSQLType(
							Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("FinYear").setSQLType(Types.VARCHAR)
							.toColumn()).toTable(database);

			ResultSet rrs = stmt
					.executeQuery("SELECT  * FROM WQ_WaterQtlyTesting_Temp_Tbl");

			while (rrs.next()) {
				Object obj[] = new Object[10];
				obj[0] = rrs.getString(1);
				obj[1] = rrs.getString(2);
				obj[2] = rrs.getString(3);
				obj[3] = rrs.getString(4);
				obj[4] = rrs.getString(5);
				obj[5] = rrs.getString(6);
				obj[6] = rrs.getString(7);
				obj[7] = rrs.getString(8);
				obj[8] = rrs.getString(9);
				obj[9] = rrs.getString(10);

				table1.addRow(obj);
			}
			flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return flag;
	}

	// //////////////////////////Water Quality Lab
	// Porting/////////////////////////////////////////////////////////////////////////////////

	public boolean writeWQM_WaterQualityTesting_Tbl1(Database database,
			Connection conn) {

		boolean flag = false;
		Statement st = null, st1 = null, st2 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		Statement stmt = null;
		try {
			stmt = conn.createStatement();
			String tableName = "WQM_WaterQualityTesting"; // Creating table
			Table table1 = createTable(tableName).addColumn(
					new ColumnBuilder("TESTID").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("SOURCE").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("HABITATIONID").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("DISTRICTID").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("CONTAMINATEDYES_NO").setSQLType(
							Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("TESTCODE").setSQLType(Types.VARCHAR)
							.toColumn()).toTable(database);

			ResultSet rrs = stmt
					.executeQuery("SELECT  * FROM WQM_WATERQUALITYTESTING");

			while (rrs.next()) {
				Object obj[] = new Object[6];
				obj[0] = rrs.getString(1);
				obj[1] = rrs.getString(2);
				obj[2] = rrs.getString(3);
				obj[3] = rrs.getString(4);
				obj[4] = rrs.getString(5);
				obj[5] = rrs.getString(6);

				table1.addRow(obj);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return flag;
	}

	public boolean writeWQM_WaterTestingSamples_Tbl2(Database database,
			Connection conn) {

		boolean flag = false;
		Statement st = null, st1 = null, st2 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		Statement stmt = null;
		try {
			stmt = conn.createStatement();
			String tableName = "WQM_WaterTestingSamples"; // Creating table
			Table table1 = createTable(tableName).addColumn(
					new ColumnBuilder("TESTID").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("TESTINGDATE").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("LABID").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("SAMPLE").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("AP_LABID").setSQLType(Types.VARCHAR)
							.toColumn()).toTable(database);

			ResultSet rrs = stmt
					.executeQuery("SELECT  * FROM WQM_WATERTESTINGSAMPLES");

			while (rrs.next()) {
				Object obj[] = new Object[5];
				obj[0] = rrs.getString(1);
				obj[1] = rrs.getString(2);
				obj[2] = rrs.getString(3);
				obj[3] = rrs.getString(4);
				obj[4] = rrs.getString(5);

				table1.addRow(obj);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return flag;
	}

	public boolean writeWQM_LabTestingDetails_Tbl3(Database database,
			Connection conn) {

		boolean flag = false;
		Statement st = null, st1 = null, st2 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		Statement stmt = null;
		try {
			stmt = conn.createStatement();
			String tableName = "WQM_LabTestingDetails"; // Creating table
			Table table1 = createTable(tableName).addColumn(
					new ColumnBuilder("TESTID").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("PARAMETERID").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("TESTING_PARAMETER_VALUE").setSQLType(
							Types.VARCHAR).toColumn()).toTable(database);

			ResultSet rrs = stmt
					.executeQuery("SELECT  * FROM WQM_LABTESTINGDETAILS");

			while (rrs.next()) {
				Object obj[] = new Object[3];
				obj[0] = rrs.getString(1);
				obj[1] = rrs.getString(2);
				obj[2] = rrs.getString(3);

				table1.addRow(obj);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return flag;
	}

	public boolean writeWQ_QualityYParameter_Tbl4(Database database,
			Connection conn) {

		boolean flag = false;
		Statement st = null, st1 = null, st2 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		Statement stmt = null;
		try {
			stmt = conn.createStatement();
			String tableName = "WQ_QualityYParameter"; // Creating table
			Table table1 = createTable(tableName).addColumn(
					new ColumnBuilder("TESTID").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("PARAMETERID").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("ParameterType")
							.setSQLType(Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("Description").setSQLType(
							Types.LONGVARCHAR).toColumn()).addColumn(
					new ColumnBuilder("UnitOfMeasurement").setSQLType(
							Types.LONGVARCHAR).toColumn()).addColumn(
					new ColumnBuilder("BISPermissibleLimit").setSQLType(
							Types.LONGVARCHAR).toColumn()).addColumn(
					new ColumnBuilder("BISDesirableLimit").setSQLType(
							Types.LONGVARCHAR).toColumn()).addColumn(
					new ColumnBuilder("TESTING_PARAMETER_VALUE").setSQLType(
							Types.VARCHAR).toColumn()).toTable(database);

			ResultSet rrs = stmt
					.executeQuery("SELECT  * FROM WQM_QUALITYPARAMETER");

			while (rrs.next()) {
				Object obj[] = new Object[8];
				obj[0] = rrs.getString(1);
				obj[1] = rrs.getString(2);
				obj[2] = rrs.getString(3);
				obj[3] = rrs.getString(4);
				obj[4] = rrs.getString(5);
				obj[5] = rrs.getString(6);
				obj[6] = rrs.getString(7);
				obj[7] = rrs.getString(8);

				table1.addRow(obj);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return flag;
	}

	public boolean writeRwss_Sources_Tbl5(Database database, Connection conn) {

		boolean flag = false;
		Statement st = null, st1 = null, st2 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		Statement stmt = null;
		try {
			stmt = conn.createStatement();
			String tableName = "Rwss_Sources"; // Creating table
			Table table1 = createTable(tableName).addColumn(
					new ColumnBuilder("Source").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("ASSET_CODE").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("SOURCE_CODE").setSQLType(Types.VARCHAR)
							.toColumn()).toTable(database);

			ResultSet rrs = stmt.executeQuery("SELECT  * FROM RWSS_SOURCES");

			while (rrs.next()) {
				Object obj[] = new Object[3];
				obj[0] = rrs.getString(1);
				obj[1] = rrs.getString(2);
				obj[2] = rrs.getString(3);

				table1.addRow(obj);
			}
			flag = true;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return flag;
	}

	/**
	 * 
	 * @param database
	 * @param conn
	 */
	public boolean writeSchemeContaminationTackledTbl(Database database,
			Connection conn) {

		boolean flag = false;
		Statement st = null, st1 = null, st2 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		Statement stmt = null;
		try {
			stmt = conn.createStatement();
			String tableName = "Backend_Schemes_SchemesContaminationTackeled"; // Creating
			// table
			Table table1 = createTable(tableName).addColumn(
					new ColumnBuilder("SchemeIdOfState").setSQLType(
							Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("ParameterId").setSQLType(Types.VARCHAR)
							.toColumn()).toTable(database);

			//ResultSet rrs = stmt.executeQuery("SELECT * FROM RWS_SCHEME_CONTAMINATION_TEMP_TBL");

//			while (rrs.next()) {
//				Object obj[] = new Object[2];
//				obj[0] = rrs.getString(1);
//				obj[1] = rrs.getString(2);
//				table1.addRow(obj);
//			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return flag;
	}

	/**
	 * 
	 * @param database
	 * @param conn
	 * @return
	 */
	public boolean writeSchemeSustainbilityMeasuresTakenTbl(Database database,
			Connection conn) {

		boolean flag = false;
		Statement st = null, st1 = null, st2 = null;
		ResultSet rs = null, rs1 = null, rs2 = null;
		Statement stmt = null;
		try {
			stmt = conn.createStatement();
			String tableName = "Backend_Schemes_SchemesSustainibilityMeasuresTaken"; // Creating
			// table
			Table table1 = createTable(tableName).addColumn(
					new ColumnBuilder("SchemeIdOfState").setSQLType(
							Types.VARCHAR).toColumn()).addColumn(
					new ColumnBuilder("StateID").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("DistrictId").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("HabitationId").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("SMActivityId").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("Location").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("SchoolId").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("IsInSchool").setSQLType(Types.NUMERIC)
							.toColumn()).toTable(database);

//			ResultSet rrs = stmt
//					.executeQuery("SELECT * FROM RWS_SCHEME_CONTAMINATION_TEMP_TBL");
//
//			while (rrs.next()) {
//				Object obj[] = new Object[8];
//				obj[0] = rrs.getString(1);
//				obj[1] = rrs.getString(2);
//				obj[2] = rrs.getString(3);
//				obj[3] = rrs.getString(4);
//				obj[4] = rrs.getString(5);
//				obj[5] = rrs.getString(6);
//				obj[6] = rrs.getString(7);
//				obj[7] = rrs.getString(8);
//				table1.addRow(obj);
//			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (stmt != null) {
					stmt.close();
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return true;
	}
	public boolean writeRWS_WQ_Test_Reports_to_File(Database database, Connection conn, String dist_code, String finYear) {

		String[] ar=finYear.split("/");
		String yearStart=ar[0];
		String yearEnd=ar[1];
		String financialYear=ar[2];
		
		boolean flag = false;
		Statement st = null, st1 = null, st2 = null;
		ResultSet rs = null, rs1 = null, rs2 = null, rrs = null;
		Statement stmt = null;
		int count=0;
		try {
			
			String sourcesQuery ="SELECT a.SOURCE_CODE,LOCATION,max(test_id) as test_id,to_char(max(prepared_on),'dd/mm/yyyy') as test_date FROM RWS_SOURCE_TBL a,RWS_WQ_TEST_RESULTS_TBL b where SUBSTR(a.SOURCE_CODE,1,2)='"+dist_code+"' and a.SOURCE_CODE is not null and a.source_code=b.source_code and test_code='1' and prepared_on >= to_date('"+yearStart+"','DD-MON-YY') and prepared_on <= to_date('"+yearEnd+"','DD-MON-YY') group by a.SOURCE_CODE,LOCATION UNION "+
					"SELECT POND_CODE,POND_LOCATION,max(test_id) as test_id,to_char(max(prepared_on),'dd/mm/yyyy') as test_date FROM RWS_OPENWELL_POND_TBL a,RWS_WQ_TEST_RESULTS_TBL b where SUBSTR(POND_CODE,1,2)='"+dist_code+"' and POND_CODE is not null and a.POND_CODE=b.source_code and test_code='1' and prepared_on >= to_date('"+yearStart+"','DD-MON-YY') and prepared_on <= to_date('"+yearEnd+"','DD-MON-YY') group by POND_CODE,POND_LOCATION UNION "+
					"SELECT OPENWELL_CODE,LOCATION,max(test_id) as test_id,to_char(max(prepared_on),'dd/mm/yyyy') as test_date FROM RWS_OPEN_WELL_MAST_TBL a,RWS_WQ_TEST_RESULTS_TBL b where SUBSTR(OPENWELL_CODE,1,2)='"+dist_code+"' and OPENWELL_CODE is not null and a.OPENWELL_CODE=b.source_code and test_code='1' and prepared_on >= to_date('"+yearStart+"','DD-MON-YY') and prepared_on <= to_date('"+yearEnd+"','DD-MON-YY') group by OPENWELL_CODE,LOCATION UNION "+
					"SELECT OHSR_CODE,OHSR_LOC,max(test_id) as test_id,to_char(max(prepared_on),'dd/mm/yyyy') as test_date FROM RWS_AST_OHSR_SC_PARAM_TBL a,RWS_WQ_TEST_RESULTS_TBL b where SUBSTR(OHSR_CODE,1,2)='"+dist_code+"' and OHSR_CODE is not null and a.OHSR_CODE=b.source_code and test_code='1' and prepared_on >= to_date('"+yearStart+"','DD-MON-YY') and prepared_on <= to_date('"+yearEnd+"','DD-MON-YY') group by OHSR_CODE,OHSR_LOC UNION "+
					"SELECT OHBR_CODE,OHBR_LOC,max(test_id) as test_id,to_char(max(prepared_on),'dd/mm/yyyy') as test_date FROM RWS_AST_OHBR_SC_PARAM_TBL a,RWS_WQ_TEST_RESULTS_TBL b where SUBSTR(OHBR_CODE,1,2)='"+dist_code+"' and OHBR_CODE is not null and a.OHBR_CODE=b.source_code and test_code='1' and prepared_on >= to_date('"+yearStart+"','DD-MON-YY') and prepared_on <= to_date('"+yearEnd+"','DD-MON-YY') group by OHBR_CODE,OHBR_LOC UNION "+
					"SELECT GLBR_CODE,GLBR_LOC,max(test_id) as test_id,to_char(max(prepared_on),'dd/mm/yyyy') as test_date FROM RWS_AST_GLBR_SC_PARAM_TBL a,RWS_WQ_TEST_RESULTS_TBL b where SUBSTR(GLBR_CODE,1,2)='"+dist_code+"' and GLBR_CODE is not null and a.GLBR_CODE=b.source_code and test_code='1' and prepared_on >= to_date('"+yearStart+"','DD-MON-YY') and prepared_on <= to_date('"+yearEnd+"','DD-MON-YY') group by GLBR_CODE,GLBR_LOC UNION "+
					"SELECT HP_CODE,LOCATION,max(test_id) as test_id,to_char(max(prepared_on),'dd/mm/yyyy') as test_date FROM RWS_HP_SUBCOMP_PARAM_TBL a,RWS_WQ_TEST_RESULTS_TBL b where SUBSTR(HP_CODE,1,2)='"+dist_code+"' and HP_CODE is not null and a.HP_CODE=b.source_code and test_code='1' and prepared_on >= to_date('"+yearStart+"','DD-MON-YY') and prepared_on <= to_date('"+yearEnd+"','DD-MON-YY') group by HP_CODE,LOCATION UNION "+
					"SELECT SHALLOWHP_CODE,LOCATION,max(test_id) as test_id,to_char(max(prepared_on),'dd/mm/yyyy') as test_date FROM RWS_SHALLOWHANDPUMPS_TBL a,RWS_WQ_TEST_RESULTS_TBL b where SUBSTR(SHALLOWHP_CODE,1,2)='"+dist_code+"' and SHALLOWHP_CODE is not null and a.SHALLOWHP_CODE=b.source_code and test_code='1' and prepared_on >= to_date('"+yearStart+"','DD-MON-YY') and prepared_on <= to_date('"+yearEnd+"','DD-MON-YY') group by SHALLOWHP_CODE,LOCATION";
			
			//System.out.println("**************sources Query: " +sourcesQuery);
			
			stmt = conn.createStatement();
			String tableName = "RWS_WQ_Test_Reports"; // Creating table
			
			
			
		//	columns = DistrictCode, DistrictName, MandalCode, MandalName, PanchayatCode, PanchayatName, VillageCode,
		//		VillageName, PanchayatRajCode, PanchayatRajName, SourceCode,SourceType, SourceLocation,
		//		pH, Total_Dissolved_Solids, Total_Hardness, Total_Alkanity, Fluoride, Chlorides, Iron, Nitrate, Sulphate, Test_Date, Test_Id
			
			
			Table table1 = createTable(tableName).addColumn(
					new ColumnBuilder("District").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("Mandal").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("Panchayat").setSQLType(Types.VARCHAR).setLength(200)
							.toColumn()).addColumn(
					new ColumnBuilder("Village").setSQLType(Types.VARCHAR).setLength(200)
							.toColumn()).addColumn(
					new ColumnBuilder("Habitation").setSQLType(Types.VARCHAR).setLength(300)
							.toColumn()).addColumn(
					new ColumnBuilder("SourceCode").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("SourceLocation").setSQLType(Types.VARCHAR).setLength(200)
							.toColumn()).addColumn(
					new ColumnBuilder("pH").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("Total_Dissolved_Solids").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("Total_Hardness").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("Total_Alkanity").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("Fluoride").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("Chlorides").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("Iron").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("Nitrate").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("Sulphate").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("Test_Date").setSQLType(Types.VARCHAR)
							.toColumn()).addColumn(
					new ColumnBuilder("Test_Id").setSQLType(
							Types.VARCHAR).toColumn()).toTable(database);

			rrs = stmt.executeQuery(sourcesQuery);

			RwsOffices rwsOffices = new RwsOffices();
			
			while (rrs.next()) {
				//String sourceCode="";
				if(rrs.getString("SOURCE_CODE").length()==24){
				
				String hab_code = rrs.getString("SOURCE_CODE").substring(0,16);
				//System.out.println("@@@@@@@@@@@@@@@@@@@@@@hab_code: "+hab_code);
				//System.out.println("@@@@@@@@@@@@@@@@@@@@@@d_code: "+dcode);
				String district = rwsOffices.getDistrictName(dist_code)+"/"+dist_code;
				
				String mcode = hab_code.substring(5, 7);
				//System.out.println("@@@@@@@@@@@@@@@@@@@@@@m_code: "+mcode);
				String mandal = rwsOffices.getMandalName(dist_code, mcode)+"/"+mcode;
				
				String pcode = hab_code.substring(12, 14);
				//System.out.println("@@@@@@@@@@@@@@@@@@@@@@p_code: "+pcode);
				String panchayat = rwsOffices.getPanchayatName(dist_code, mcode, pcode)+"/"+pcode;
				
				String vcode = hab_code.substring(7, 10);
				//System.out.println("@@@@@@@@@@@@@@@@@@@@@@v_code: "+vcode);
				String village = rwsOffices.getVillageName(null, dist_code, mcode, pcode, vcode)+"/"+vcode;
				
				String habitation = rwsOffices.getHabitationName(null, hab_code)+"/"+hab_code;
				
				String source_code = rrs.getString("SOURCE_CODE");
				
				
				/*String testIdQry = "select test_id,to_char(prepared_on,'dd/mm/yyyy') as test_date from RWS_WQ_TEST_RESULTS_TBL where source_code='"+source_code+"' and prepared_on >= to_date('"+yearStart+"','DD-MON-YY') and prepared_on <= to_date('"+yearEnd+"','DD-MON-YY') and test_code=1 and test_id is not null order by prepared_on desc";
				
				//System.out.println("_____^^^^^^^^^^^^^^^^^^^^^^^^^^_____Test_ID query : "+testIdQry);
				
				Statement testIdStmt = conn.createStatement();
				ResultSet testIdRs = testIdStmt.executeQuery(testIdQry);
				
				if(testIdRs.next())
				{*/
					String test_id = rrs.getString("test_id");
					String test_date = rrs.getString("test_date");
				
					Object obj[] = new Object[18];
					
					obj[0] = district;
					obj[1] = mandal;
					obj[2] = panchayat;
					obj[3] = village;
					obj[4] = habitation;
					obj[5] = source_code;
					obj[6] = rrs.getString("LOCATION");
					
					//System.out.println("test id result set is not empty");
					//System.out.println(test_id+"&&&"+test_date);
					
					
					String inQry1 = "select TESTING_PARAMETER_CODE,TESTING_PARAMETER_VALUE from RWS_WQ_TEST_RESULTS_LNK_TBL where TESTING_PARAMETER_CODE in ('04','05','06','07','12','13','14','15','16') and test_id='"+test_id+"'";
					Statement resStmt = conn.createStatement();
					ResultSet resRs = resStmt.executeQuery(inQry1);
					while(resRs.next())
					{
						
						obj[16] = test_date;
						obj[17] = test_id;
						
						String test_codeStr = resRs.getString("TESTING_PARAMETER_CODE");
						String test_value = resRs.getString("TESTING_PARAMETER_VALUE");
										
						int test_code = Integer.parseInt(test_codeStr.trim());
						
						//System.out.println("wq quality result set is not empty");
						//System.out.println(test_code+"&&&"+test_value);
						
						/*switch (test_code) {
						case 4:
							obj[7] = test_value;
							break;
						case 5:
							obj[8] = test_value;
							break;
						case 6:
							obj[9] = test_value;
							break;
						case 7:
							obj[10] = test_value;
							break;
						case 12:
							obj[12] = test_value;
							break;
						case 13:
							obj[11] = test_value;
							break;
						case 14:
							obj[15] = test_value;
							break;
						case 15:
							obj[14] = test_value;
							break;
						case 16:
							obj[13] = test_value;
							break;
						default:
							break;
						}*/
						
						if(test_codeStr.equals("04"))
						{
							obj[7] = test_value;
						}
						if(test_codeStr.equals("05"))
						{
							obj[8] = test_value;
						}
						if(test_codeStr.equals("06"))
						{
							obj[9] = test_value;
						}
						if(test_codeStr.equals("07"))
						{
							obj[10] = test_value;
						}
						if(test_codeStr.equals("12"))
						{
							obj[12] = test_value;
						}
						if(test_codeStr.equals("13"))
						{
							obj[11] = test_value;
						}
						if(test_codeStr.equals("14"))
						{
							obj[15] = test_value;
						}
						if(test_codeStr.equals("15"))
						{
							obj[14] = test_value;
						}
						if(test_codeStr.equals("16"))
						{
							obj[13] = test_value;
						}
						
					}
					/////////////////
					count++;
					if(count==3)
					{
						return true;
					}
					/////////
					table1.addRow(obj);
					resRs.close();
					resStmt.close();
				//}
				
				/////////////////
				/*count++;
				if(count==30)
				{
					return true;
				}*/
				/////////
				
				/*testIdStmt.close();
				testIdRs.close();*/
			}
			flag = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			flag = true;
			try {
				if (conn != null) {
					conn.close();
				}
				if (stmt != null) {
					stmt.close();
				}
				if (rrs != null) {
					rrs.close();
				}

			} catch (Exception e) {
				e.printStackTrace();
			}

		}

		return flag;
	}
}