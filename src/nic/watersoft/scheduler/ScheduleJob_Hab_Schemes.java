package nic.watersoft.scheduler;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;

import nic.watersoft.commons.RwsOffices;
import nic.watersoft.smsmobile.NicSmsGateway;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

public class ScheduleJob_Hab_Schemes implements Job {
        public void execute(JobExecutionContext context)
                        throws JobExecutionException {
                
               
                Statement stmt = null,stmt1 = null;
                Connection conn = null;
                PreparedStatement pstt = null;
                ResultSet rs = null,resset=null;
                PreparedStatement preparedStatement=null;
               
                            
                try
                {
                	 conn = RwsOffices.getConn();
                	 Calendar now = Calendar.getInstance();   
                	 int year = now.get(Calendar.YEAR); 
                	 String tableExist="select tname from tab where tname='RWS_HAB_SCHEME_SRC_DATA_TBL'";
                	 stmt=conn.createStatement();  
                     rs=stmt.executeQuery(tableExist);
                     if(rs!=null){
                     if(rs.next()){
                    	 String dropTable="drop table RWS_HAB_SCHEME_SRC_DATA_TBL";
                    	 stmt1=conn.createStatement();  
                         stmt1.executeUpdate(dropTable);
                         stmt1.close();
                     }
                     rs.close();
                     stmt.close(); 
                     }
                     
                     String createTable="CREATE TABLE RWS_HAB_SCHEME_SRC_DATA_TBL("
								+"DCODE VARCHAR2(2),"
								+"DNAME VARCHAR2(13),"
								+"MCODE VARCHAR2(2),"
								+"MNAME VARCHAR2(30),"
								+"PCODE VARCHAR2(2),"
								+"PNAME VARCHAR2(30),"
								+"VCODE VARCHAR2(3),"
								+"VNAME VARCHAR2(30),"
								+"PANCH_CODE VARCHAR2(16),"
								+"PANCH_NAME VARCHAR2(50)," 
								+"COVERAGE_STATUS VARCHAR2(3),"
								+"DIVISION_OFFICE_CODE NUMBER(1),"    
								+"DIVISION_OFFICE_NAME VARCHAR2(20),"
								+"SUBDIVISION_OFFICE_CODE VARCHAR2(2),"  
								+"SUBDIVISION_OFFICE_NAME VARCHAR2(20),"
								+"CONSTITUENCY_CODE VARCHAR2(3),"  
								+"CONSTITUENCY_NAME VARCHAR2(30),"
								+"CENSUS_PLAIN_POPU NUMBER,"       
								+"CENSUS_SC_POPU NUMBER,"     
								+"CENSUS_ST_POPU NUMBER,"
								+"CENSUS_MINORITY_POPU NUMBER(4),"
								+"CENSUS_TOT_POPU NUMBER,"
								+"HOUSEHOLD_NO NUMBER(5),"
								+"NO_OF_HOUSECONN_GIVEN NUMBER(5),"
								+"CPWS_NO NUMBER(2),"
								+"CPWS_NAME VARCHAR2(2000),"
								+"CPWS_HAB_SCHEME_NO NUMBER(4),"
								+"CPWS_HAB_SCHEME_NAME VARCHAR2(2000),"
								+"CPWS_SUPPLY NUMBER,"
								+"PWS_NO NUMBER(3),"
								+"PWS_NAME VARCHAR2(2000),"
								+"PWS_HAB_SCHEME_NO NUMBER(4),"
								+"PWS_HAB_SCHEME_NAME VARCHAR2(2000),"
								+"PWS_SUPPLY_SAFE NUMBER,"
								+"PWS_SUPPLY_UNSAFE NUMBER,"
								+"MPWS_NO NUMBER(3),"
								+"MPWS_NAME VARCHAR2(2000),"
								+"MPWS_HAB_SCHEME_NO NUMBER(4),"
								+"MPWS_HAB_SCHEME_NAME VARCHAR2(2000),"
								+"MPWS_SUPPLY_SAFE NUMBER,"
								+"MPWS_SUPPLY_UNSAFE NUMBER,"
								+"HANDPUMP_NO NUMBER(3),"
								+"HANDPUMP_SUPPLY_SAFE NUMBER,"
								+"HANDPUMP_SUPPLY_UNSAFE NUMBER,"
								+"SHALLOW_HANDPUMP_NO NUMBER(3),"
								+"SHALLOW_HP_SUPPLY_SAFE NUMBER,"
								+"SHALLOW_HP_SUPPLY_UNSAFE NUMBER,"
								+"DIRECT_PUMPING_NO NUMBER,"
								+"DIRECT_PUMPING_SUPPLY_SAFE NUMBER,"
								+"DIRECT_PUMPING_SUPPLY_UNSAFE NUMBER,"
								+"OPENWELL_NO NUMBER,"
								+"OPENWELL_SUPPLY NUMBER,"
								+"SPRINGS_NO NUMBER,"
								+"SPRINGS_SUPPLY NUMBER,"
								+"OTHERS_NO NUMBER,"
								+"OTHERS_SUPPLY NUMBER,"
								+"NO_OF_GLSRS NUMBER,"
								+"NO_OF_CISTERNS NUMBER,"
								+"NO_OF_OHSRS NUMBER, "
								+"NO_OF_PUMPSETS NUMBER,"
								+"NO_OF_SSF NUMBER,"
								+"NO_OF_RSF NUMBER,"
								+"NO_OF_SSTANKS NUMBER,"
								+"CAPACITY_OF_SSTANK NUMBER,"
								+"NO_OF_MICROFILTERS NUMBER,"
								+"NO_OF_ROPLANTS NUMBER,"
								+"NO_OF_SOLARSCHEMES NUMBER,"
								+"CONTAMINATION_TYPE VARCHAR2(15),"
								+"TOTAL_HP_OF_PUMPSETS NUMBER(11,2),"
								+"STRESSED_HABS NUMBER)";
                     stmt=conn.createStatement();  
                     stmt.executeUpdate(createTable);
                     stmt.close();
                	 
                     System.out.println("table created");
                     
                	 String insertHabInfo="insert into RWS_HAB_SCHEME_SRC_DATA_TBL(DCODE,DNAME,MCODE,MNAME,PCODE,PNAME,VCODE,VNAME,PANCH_CODE,PANCH_NAME,COVERAGE_STATUS)(SELECT DCODE,DNAME,MCODE,MNAME,PCODE,PNAME,VCODE,VNAME,PANCH_CODE,PANCH_NAME,COVERAGE_STATUS FROM RWS_COMPLETE_HAB_VIEW)";
                     stmt=conn.createStatement();  
                     stmt.executeUpdate(insertHabInfo);
                     stmt.close();
                     System.out.println("insertHabInfo");
                     
                     String stressed_habs="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET STRESSED_HABS= CASE WHEN A.PANCH_code in (select habcode from RWS_DROUGHT_HABITATION_TBL b  where YEAR='"+year+"') THEN 1 ELSE 0 END";
              		 stmt1=conn.createStatement();
              		 stmt1.executeUpdate(stressed_habs);
              		 stmt1.close();
              		 System.out.println("stressed_habs");
                     
                     String updateSupply="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (CPWS_SUPPLY,PWS_SUPPLY_SAFE,MPWS_SUPPLY_SAFE,PWS_SUPPLY_UNSAFE,MPWS_SUPPLY_UNSAFE,HANDPUMP_SUPPLY_SAFE,HANDPUMP_SUPPLY_UNSAFE,SHALLOW_HP_SUPPLY_SAFE,SHALLOW_HP_SUPPLY_UNSAFE)=(SELECT sum(nvl(CPWS_SUPPLY,0)+nvl(CPWS_HAB_SUPPLY,0)) AS CPWSSUPPLY,sum(nvl(PWS_SUPPLY,0)+nvl(PWS_HAB_SUPPLY,0)) AS PWSSAFESUPPLY,sum(nvl(MPWS_SUPPLY,0)+nvl(MPWS_HAB_SUPPLY,0)) AS MPWSSUPPLY,sum(PWS_UNSAFE_SUPPLY),sum(MPWS_UNSAFE_SUPPLY),sum(HPS_OTH_SUPPLY),sum(HPS_OTH_SUPPLY_UNSAFE),sum(SHP_DK_SUPPLY_SAFE),sum(SHP_DK_SUPPLY) FROM RWS_HAB_SUPPLY_STATUS_TBL B WHERE A.PANCH_CODE=B.HAB_CODE)";
                	stmt1=conn.createStatement();
                		stmt1.executeUpdate(updateSupply);
                		stmt1.close();

                    	 System.out.println("updateSupply");
                    String Query="select dcode,mcode,panch_code,COVERAGE_STATUS from RWS_HAB_SCHEME_SRC_DATA_TBL";
                 	 stmt=conn.createStatement();
                 	 rs=stmt.executeQuery(Query);
                 	
                 	int roplants1=0,roplants2=0,roplants=0;
                 	 while(rs.next()){
                 		String typeOfContamination="--";
                 		 String mnre="select COUNT(b.WORK_ID) as WORK_COUNT FROM RWS_WORK_COMP_HAB_LNK_TBL B,RWS_WORK_ADMN_TBL C where B.work_id=C.WORK_ID AND c.Programme_code='76' and b.hab_code='"+rs.getString("panch_code")+"'";
                 		 stmt1=conn.createStatement();
                 		resset=stmt1.executeQuery(mnre);
                 		if(resset.next()){
                 			roplants1=resset.getInt(1);
                 		}
                 		resset.close();
                  		 stmt1.close();
                  		 
                  		//String ntrsujala="select COUNT(TYPE_OF_PLANT) as WORK_COUNT FROM RWS_NTR_SUJALA_MASTER_TBL where hab_code='"+rs.getString("panch_code")+"'";
                  		 String ntrsujala="select count(PLANT_TYPE_INSTALLED) from  RWS_NTR_SUJALA_HAB_IMPL_TBL where HABITATION_CODE='"+rs.getString("panch_code")+"'";
                		 stmt1=conn.createStatement();
                		 resset=stmt1.executeQuery(ntrsujala);
                		 if(resset.next()){
                  			roplants2=resset.getInt(1);
                  		 }
                		 resset.close();
                 		 stmt1.close();
                 		roplants=roplants1+roplants2;
                 		
                 		String updateROPlants="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (NO_OF_ROPLANTS)='"+roplants+"' where a.panch_code='"+rs.getString("panch_code")+"'";
             			stmt1=conn.createStatement();
             			stmt1.executeUpdate(updateROPlants);
             			stmt1.close();
             			System.out.println("updateROPlants ");
                 		
                 		if(rs.getString("COVERAGE_STATUS").equals("NSS")){
                 			 String query="select to_char(max(prepared_on),'dd/mm/yyyy'),source_code from rws_wq_test_results_tbl a,rws_wq_test_results_lnk_tbl b where a.test_id=b.test_id AND TEST_CODE='1' and substr(source_code,1,16)='"+rs.getString("panch_code")+"'  group by source_code order by max(prepared_on) desc";
                 		     Statement statement=conn.createStatement();
                 			 ResultSet resultSet=statement.executeQuery(query);
                 			 while(resultSet.next()){
                 				 
                 				
                 				 String prepared_on=resultSet.getString(1);
                 				 String source_code=resultSet.getString(2);
                 				 String flouride="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE='13' AND A.TESTING_PARAMETER_VALUE > 1.5 AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";			
                 				 preparedStatement=conn.prepareStatement(flouride);
                 				 preparedStatement.setString(1, source_code);
                 				 preparedStatement.setString(2, prepared_on);
                 				 resset=preparedStatement.executeQuery();
                 				 if(resset.next()){
                 					 typeOfContamination="FLOURIDE"; 
                 				 }
                 				 resset.close();
                 				 preparedStatement.close();
                 			 
                 			 
                 			 if(typeOfContamination.equals("--")){
                 				
                 					 
                 					 String brakish="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE='05' AND A.TESTING_PARAMETER_VALUE > 2000 AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";			
                 					 preparedStatement=conn.prepareStatement(brakish);
                 					 preparedStatement.setString(1, source_code);
                 					 preparedStatement.setString(2, prepared_on);
                 					 resset=preparedStatement.executeQuery();
                 					 if(resset.next()){
                 						 typeOfContamination="BRAKISH"; 
                 					 }
                 					 resset.close();
                 					 preparedStatement.close();
                 				 }
                 				
                 			 
                 			
                 			  if(typeOfContamination.equals("--")){
                 								 
                 					 String brakish="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE='16' AND A.TESTING_PARAMETER_VALUE > 0.3 AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";			
                 					 preparedStatement=conn.prepareStatement(brakish);
                 					 preparedStatement.setString(1, source_code);
                 					 preparedStatement.setString(2, prepared_on);
                 					 resset=preparedStatement.executeQuery();
                 					 if(resset.next()){
                 						 typeOfContamination="IRON"; 
                 					 }
                 					 resset.close();
                 					 preparedStatement.close();
                 				 }
                 				 
                 			 
                 			
                 			  
                 			  if(typeOfContamination.equals("--")){
                 					
                 						 
                 						 String brakish="SELECT TESTING_PARAMETER_VALUE FROM RWS_WQ_TEST_RESULTS_LNK_TBL A, RWS_WQ_TEST_RESULTS_TBL B WHERE A.TEST_ID =B.TEST_ID AND TEST_CODE='1' AND A.TESTING_PARAMETER_CODE='15' AND A.TESTING_PARAMETER_VALUE > 45 AND SOURCE_CODE=? AND B.PREPARED_ON=to_date(?,'dd/mm/yyyy')";			
                 						 preparedStatement=conn.prepareStatement(brakish);
                 						 preparedStatement.setString(1, source_code);
                 						 preparedStatement.setString(2, prepared_on);
                 						 resset=preparedStatement.executeQuery();
                 						 if(resset.next()){
                 							 typeOfContamination="NITRATE"; 
                 						 }
                 						 resset.close();
                 						 preparedStatement.close();
                 					 }
                 					
                 				 
                 		
                 		}
                 		 statement.close();
                 		 resultSet.close();
                 			
                 			}
                 			String updateNSSCont="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (CONTAMINATION_TYPE)='"+typeOfContamination+"' where a.panch_code='"+rs.getString("panch_code")+"'";
                 			stmt1=conn.createStatement();
                 			stmt1.executeUpdate(updateNSSCont);
                 			stmt1.close();
                 		
                 		 String dibSubdiv="select DISTINCT b.DIVISION_OFFICE_CODE,b.DIVISION_OFFICE_NAME,c.SUBDIVISION_OFFICE_CODE,c.SUBDIVISION_OFFICE_NAME from RWS_MANDAL_SUBDIVISION_TBL a,RWS_DIVISION_OFFICE_TBL b,RWS_SUBDIVISION_OFFICE_TBL c where a.CIRCLE_OFFICE_CODE=b.CIRCLE_OFFICE_CODE and a.DIVISION_OFFICE_CODe=b.DIVISION_OFFICE_CODE and a.CIRCLE_OFFICE_CODE=c.CIRCLE_OFFICE_CODE and a.DIVISION_OFFICE_CODE=c.DIVISION_OFFICE_CODE and a.SUBDIVISION_OFFICE_CODE=c.SUBDIVISION_OFFICE_CODE and b.DIVISION_OFFICE_CODE=c.DIVISION_OFFICE_CODE and a.dcode='"+rs.getString("dcode")+"' and a.mcode='"+rs.getString("mcode")+"'";
                 		 Statement  statement=conn.createStatement();
                 		ResultSet resultSet=statement.executeQuery(dibSubdiv);
                 		if(resultSet.next()){
                 			String updateDivSubdiv="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL a SET DIVISION_OFFICE_CODE='"+resultSet.getString("DIVISION_OFFICE_CODE")+"',DIVISION_OFFICE_NAME='"+resultSet.getString("DIVISION_OFFICE_NAME")+"',SUBDIVISION_OFFICE_CODE='"+resultSet.getString("SUBDIVISION_OFFICE_CODE")+"',SUBDIVISION_OFFICE_NAME='"+resultSet.getString("SUBDIVISION_OFFICE_NAME")+"' where panch_code='"+rs.getString("panch_code")+"'";
                     		stmt1=conn.createStatement();
                     		stmt1.executeUpdate(updateDivSubdiv);
                     		stmt1.close();
                 		}
                 		resultSet.close();
                 		statement.close();
                 		 
                 		
                        		
                 	  }
                 	  stmt.close();
                 	  
                 	 System.out.println("updateDivSubdiv ");

               		
               		
                 	
                 	
                     String updateHabDir="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (CENSUS_PLAIN_POPU,CENSUS_SC_POPU,CENSUS_ST_POPU,CENSUS_MINORITY_POPU,CENSUS_TOT_POPU,HOUSEHOLD_NO,NO_OF_HOUSECONN_GIVEN)=(SELECT CENSUS_PLAIN_POPU,CENSUS_SC_POPU,CENSUS_ST_POPU,CENSUS_MINORITY_POPU,CENSUS_PLAIN_POPU+CENSUS_SC_POPU+CENSUS_ST_POPU+CENSUS_MINORITY_POPU,HOUSEHOLD_NO,NO_OF_HOUSECONN_GIVEN FROM RWS_HABITATION_DIRECTORY_TBL B WHERE A.PANCH_CODE=B.HAB_CODE)";
                     stmt=conn.createStatement();  
                     stmt.executeUpdate(updateHabDir);
                     stmt.close();
                     System.out.println("updateHabDir");
                     
                     String updateConstituency="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL a set (constituency_code,constituency_name) = (select Distinct CONSTITUENCY_CODE, CONSTITUENCY_NAME from RWS_CONSTITUENCY_TBL b where a.DCODE=b.DCODE and a.MCODE=b.MCODE)";
                     stmt=conn.createStatement();  
                     stmt.executeUpdate(updateConstituency);
                     stmt.close();
                     System.out.println("updateConstituency");
                     
                     String hpPumpSets="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (TOTAL_HP_OF_PUMPSETS)=(select nvl(sum(trim(c.PUMP_CPTY)),0) from RWS_ASSET_MAST_TBL B,RWS_AST_SUBCOMP_PARAM_TBL C  where B.ASSET_CODE=C.ASSET_CODE and A.PANCH_CODE=B.HAB_CODE)";
                     stmt=conn.createStatement();  
                     stmt.executeUpdate(hpPumpSets);
                     stmt.close();
                     System.out.println("Total HP of pumpSet");
                     
                     String cpwsNoName="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (CPWS_NO,CPWS_NAME)=(select count(DISTINCT B.asset_code),LISTAGG(CONCAT(concat(B.ASSET_CODE,'-'),B.ASSET_NAME), ' / ') WITHIN GROUP (ORDER BY B.ASSET_NAME) AS ASSET_SCHEME_NAME  from RWS_ASSET_MAST_TBL B  where TYPE_OF_ASSET_CODE='03' and A.PANCH_CODE=B.HAB_CODE)";
                     stmt=conn.createStatement();  
                     stmt.executeUpdate(cpwsNoName);
                     stmt.close();
                     System.out.println("cpwsNoName");
                     

                     
                     String cpwsHabNoName="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL C SET (CPWS_HAB_SCHEME_NO,CPWS_HAB_SCHEME_NAME)=(SELECT COUNT(DISTINCT B.ASSET_CODE),LISTAGG(CONCAT(concat(A.ASSET_CODE,'-'),A.ASSET_NAME), ' / ') WITHIN GROUP (ORDER BY A.ASSET_NAME) AS ASSET_SCHEME_NAME FROM RWS_ASSET_MAST_TBL A,RWS_ASSET_HAB_TBL B WHERE TYPE_OF_ASSET_CODE='03' and A.ASSET_CODE=B.ASSET_CODE AND B.HAB_CODE=C.PANCH_CODE)";
                     stmt=conn.createStatement();  
                     stmt.executeUpdate(cpwsHabNoName);
                     stmt.close();
                     System.out.println("cpwsHabNoName");
                     
                     String pwsNoName="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (PWS_NO,PWS_NAME)=(select count(DISTINCT B.asset_code),LISTAGG(CONCAT(concat(B.ASSET_CODE,'-'),B.ASSET_NAME), ' / ') WITHIN GROUP (ORDER BY B.ASSET_NAME) AS ASSET_SCHEME_NAME  from RWS_ASSET_MAST_TBL B  where TYPE_OF_ASSET_CODE='01' and A.PANCH_CODE=B.HAB_CODE)";
                     stmt=conn.createStatement();  
                     stmt.executeUpdate(pwsNoName);
                     stmt.close();
                     System.out.println("pwsNoName");
                     
                     String pwsHabNoName="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL C SET (PWS_HAB_SCHEME_NO,PWS_HAB_SCHEME_NAME)=(SELECT COUNT(DISTINCT B.ASSET_CODE),LISTAGG(CONCAT(concat(A.ASSET_CODE,'-'),A.ASSET_NAME), ' / ') WITHIN GROUP (ORDER BY A.ASSET_NAME) AS ASSET_SCHEME_NAME FROM RWS_ASSET_MAST_TBL A,RWS_ASSET_HAB_TBL B WHERE TYPE_OF_ASSET_CODE='01' and A.ASSET_CODE=B.ASSET_CODE AND B.HAB_CODE=C.PANCH_CODE)";
                     stmt=conn.createStatement();  
                     stmt.executeUpdate(pwsHabNoName);
                     stmt.close();
                     System.out.println("pwsHabNoName");
                     
                     String mpwsNoName="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (MPWS_NO,MPWS_NAME)=(select count(DISTINCT B.asset_code),LISTAGG(CONCAT(concat(B.ASSET_CODE,'-'),B.ASSET_NAME), ' / ') WITHIN GROUP (ORDER BY B.ASSET_NAME) AS ASSET_SCHEME_NAME  from RWS_ASSET_MAST_TBL B  where TYPE_OF_ASSET_CODE='02' and A.PANCH_CODE=B.HAB_CODE)";
                     stmt=conn.createStatement();  
                     stmt.executeUpdate(mpwsNoName);
                     stmt.close();
                     System.out.println("mpwsNoName");
                	 
                     String mpwsHabNoName="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL C SET (MPWS_HAB_SCHEME_NO,MPWS_HAB_SCHEME_NAME)=(SELECT COUNT(DISTINCT B.ASSET_CODE),LISTAGG(CONCAT(concat(A.ASSET_CODE,'-'),A.ASSET_NAME), ' / ') WITHIN GROUP (ORDER BY A.ASSET_NAME) AS ASSET_SCHEME_NAME FROM RWS_ASSET_MAST_TBL A,RWS_ASSET_HAB_TBL B WHERE TYPE_OF_ASSET_CODE='02' and A.ASSET_CODE=B.ASSET_CODE AND B.HAB_CODE=C.PANCH_CODE)";
                     stmt=conn.createStatement();  
                     stmt.executeUpdate(mpwsHabNoName);
                     stmt.close();
                     System.out.println("mpwsHabNoName");
                     
                     String dpNo="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (DIRECT_PUMPING_NO)=(select count(DISTINCT B.asset_code) from RWS_ASSET_MAST_TBL B  where TYPE_OF_ASSET_CODE='09' and A.PANCH_CODE=B.HAB_CODE)";
                     stmt=conn.createStatement();  
                     stmt.executeUpdate(dpNo);
                     stmt.close();
                     System.out.println("dpNo");
                     
                     String updateDpSupply="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (DIRECT_PUMPING_SUPPLY_SAFE,DIRECT_PUMPING_SUPPLY_UNSAFE)=(select sum(SAFE_LPD),sum(UNSAFE_LPD) from RWS_SOURCE_TBL B,RWS_ASSET_MAST_TBL C where B.asset_code=C.asset_code AND A.PANCH_CODE=B.HAB_CODE and c.TYPE_OF_ASSET_CODE='09')";
             		 stmt1=conn.createStatement();
             		 stmt1.executeUpdate(updateDpSupply);
             		 stmt1.close();
                     
                     String hpNo="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (HANDPUMP_NO)=(select count(DISTINCT B.asset_code) from RWS_ASSET_MAST_TBL B  where TYPE_OF_ASSET_CODE='04' and A.PANCH_CODE=B.HAB_CODE)";
                     stmt=conn.createStatement();  
                     stmt.executeUpdate(hpNo);
                     stmt.close();
                     System.out.println("hpNo");
                     
                     String shpNo="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (SHALLOW_HANDPUMP_NO)=(select count(DISTINCT B.asset_code) from RWS_ASSET_MAST_TBL B  where TYPE_OF_ASSET_CODE='05' and A.PANCH_CODE=B.HAB_CODE)";
                     stmt=conn.createStatement();  
                     stmt.executeUpdate(shpNo);
                     stmt.close();
                     System.out.println("shpNo");
                     
                     String openwellNo="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (OPENWELL_NO)=(select count(DISTINCT B.asset_code) from RWS_ASSET_MAST_TBL B  where TYPE_OF_ASSET_CODE='06' and A.PANCH_CODE=B.HAB_CODE)";
                     stmt=conn.createStatement();  
                     stmt.executeUpdate(openwellNo);
                     stmt.close();
                     System.out.println("openwellNo");
                     
                     String updateOpenwellSupply="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (OPENWELL_SUPPLY)=(select sum(SAFE_LPD) from RWS_OPEN_WELL_MAST_TBL B,RWS_ASSET_MAST_TBL C where B.asset_code=C.asset_code and TYPE_OF_ASSET_CODE='06' and A.PANCH_CODE=B.HABITATION_CODE)";
             		 stmt1=conn.createStatement();
             		 stmt1.executeUpdate(updateOpenwellSupply);
             		 stmt1.close();
                     
                     String springNo="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (SPRINGS_NO)=(select count(OTHER_COMP_CODE) from RWS_ASSET_MAST_TBL B,RWS_AST_OTHERS_PARAM_TBL C  where TYPE_OF_ASSET_CODE='08' and C.SPECIAL_ASSET_TYPE='Spring' and B.ASSET_CODE=C.ASSET_CODE and A.PANCH_CODE=C.HAB_CODE)";
                     stmt=conn.createStatement();  
                     stmt.executeUpdate(springNo);
                     stmt.close();
                     System.out.println("Springssss");
                     
                     String updateSpringSupply="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (SPRINGS_SUPPLY)=(select sum(COLLECTION_TANK_CAPACITY) from RWS_AST_OTHERS_PARAM_TBL B,RWS_ASSET_MAST_TBL C where B.asset_code=C.asset_code  and TYPE_OF_ASSET_CODE='08'  and b.SPECIAL_ASSET_TYPE='Spring' and A.PANCH_CODE=B.HAB_CODE)";
             		 stmt1=conn.createStatement();
             		 stmt1.executeUpdate(updateSpringSupply);
             		 stmt1.close();
                     
                     String othersNo="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (OTHERS_NO)=(select count(OTHER_COMP_CODE) from RWS_ASSET_MAST_TBL B,RWS_AST_OTHERS_PARAM_TBL C  where TYPE_OF_ASSET_CODE='08' and C.SPECIAL_ASSET_TYPE is null and B.ASSET_CODE=C.ASSET_CODE and A.PANCH_CODE=C.HAB_CODE)";
                     stmt=conn.createStatement();  
                     stmt.executeUpdate(othersNo);
                     stmt.close();
                     System.out.println("Othersss");
                     
                     String updateOthersSupply="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (OTHERS_SUPPLY)=(select sum(COLLECTION_TANK_CAPACITY) from RWS_AST_OTHERS_PARAM_TBL B,RWS_ASSET_MAST_TBL C where B.asset_code=C.asset_code  and TYPE_OF_ASSET_CODE='08'  and b.SPECIAL_ASSET_TYPE is null and A.PANCH_CODE=B.HAB_CODE)";
             		 stmt1=conn.createStatement();
             		 stmt1.executeUpdate(updateOthersSupply);
             		 stmt1.close();
                     
                     String glsrNo="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (NO_OF_GLSRS)=(select count(GLSR_CODE) from RWS_ASSET_MAST_TBL B,RWS_AST_GLSR_SC_PARAM_TBL C  where TYPE_OF_ASSET_CODE in ('01','02','03','09') and B.ASSET_CODE=C.ASSET_CODE and A.PANCH_CODE=C.HAB_CODE)";
                     stmt=conn.createStatement();  
                     stmt.executeUpdate(glsrNo);
                     stmt.close();
                     System.out.println("GLSRs");
                     
                     String cisternsNo="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (NO_OF_CISTERNS)=(select count(CISSC_CODE) from RWS_ASSET_MAST_TBL B,RWS_AST_CIS_SC_PARAM_TBL C  where TYPE_OF_ASSET_CODE in ('01','02','03','09') and B.ASSET_CODE=C.ASSET_CODE and A.PANCH_CODE=C.HAB_CODE)";
                     stmt=conn.createStatement();  
                     stmt.executeUpdate(cisternsNo);
                     stmt.close();
                     System.out.println("Cisterns");
                     
                     String ohsrNo="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (NO_OF_OHSRS)=(select count(OHSR_CODE) from RWS_ASSET_MAST_TBL B,RWS_AST_OHSR_SC_PARAM_TBL C  where TYPE_OF_ASSET_CODE  in ('01','02','03','09') and B.ASSET_CODE=C.ASSET_CODE and A.PANCH_CODE=C.HAB_CODE)";
                     stmt=conn.createStatement();  
                     stmt.executeUpdate(ohsrNo);
                     stmt.close();
                     System.out.println("OHSRS");
                     
                     String pumpsetsNo="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (NO_OF_PUMPSETS)=(select count(PUMP_CODE) from RWS_ASSET_MAST_TBL B,RWS_AST_SUBCOMP_PARAM_TBL C  where TYPE_OF_ASSET_CODE in ('01','02','03','09') and B.ASSET_CODE=C.ASSET_CODE and A.PANCH_CODE=C.HAB_CODE)";
                     stmt=conn.createStatement();  
                     stmt.executeUpdate(pumpsetsNo);
                     stmt.close();
                     System.out.println("Pumpsets");
                     
                     String ssfNo="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (NO_OF_SSF)=(select count(WTPSC_CODE) from RWS_ASSET_MAST_TBL B,RWS_AST_WTP_SC_PARAM_TBL C  where substr(wtpsc_code,20,2)='SS' and B.ASSET_CODE=C.ASSET_CODE and A.PANCH_CODE=C.HAB_CODE)";
                     stmt=conn.createStatement();  
                     stmt.executeUpdate(ssfNo);
                     stmt.close();
                     System.out.println("SS filters");
                     
                     String rsfNo="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (NO_OF_RSF)=(select count(WTPSC_CODE) from RWS_ASSET_MAST_TBL B,RWS_AST_WTP_SC_PARAM_TBL C  where substr(wtpsc_code,20,2)='RS' and B.ASSET_CODE=C.ASSET_CODE and A.PANCH_CODE=C.HAB_CODE)";
                     stmt=conn.createStatement();  
                     stmt.executeUpdate(rsfNo);
                     stmt.close();
                     System.out.println("RS Filters");
                     
                     String microfNo="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (NO_OF_MICROFILTERS)=(select count(WTPSC_CODE) from RWS_ASSET_MAST_TBL B,RWS_AST_WTP_SC_PARAM_TBL C  where substr(wtpsc_code,20,2)='MS' and B.ASSET_CODE=C.ASSET_CODE and A.PANCH_CODE=C.HAB_CODE)";
                     stmt=conn.createStatement();  
                     stmt.executeUpdate(microfNo);
                     stmt.close();
                     System.out.println("Micro Filters");
                     
                     String sstankNo="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (NO_OF_SSTANKS)=(select count(SSSC_CODE) from RWS_ASSET_MAST_TBL B,RWS_AST_SS_SC_PARAM_TBL C  where B.ASSET_CODE=C.ASSET_CODE and A.PANCH_CODE=C.HAB_CODE)";
                     stmt=conn.createStatement();  
                     stmt.executeUpdate(sstankNo);
                     stmt.close();
                     System.out.println("SS Tnaksss");
                     
                     String sstankCpt="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (CAPACITY_OF_SSTANK)=(select sum(CAPACITY_MCUM) from RWS_ASSET_MAST_TBL B,RWS_AST_SS_SC_PARAM_TBL C  where B.ASSET_CODE=C.ASSET_CODE and A.PANCH_CODE=C.HAB_CODE)";
                     stmt=conn.createStatement();  
                     stmt.executeUpdate(sstankCpt);
                     stmt.close();
                     System.out.println("SS Tnaksss capacity");
                     
                     String solarNo="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL A SET (NO_OF_SOLARSCHEMES)=(select COUNT(B.WORK_ID) from RWS_WORK_ADMN_TBL B,RWS_WORK_COMP_HAB_LNK_TBL C  where B.work_id=C.work_id and B.WORK_CANCEL_DT is null and Programme_code in ('75','72') and A.PANCH_CODE=B.LEAD_HABITATION)";
                     stmt=conn.createStatement();  
                     stmt.executeUpdate(solarNo);
                     stmt.close();
                     System.out.println("Solar works");
                     
                	 String cpwssupplyUpdate="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL SET CPWS_SUPPLY=0 where CPWS_NO=0 and CPWS_HAB_SCHEME_NO=0";
            		 stmt=conn.createStatement();  
                     stmt.executeUpdate(cpwssupplyUpdate);
                     stmt.close();
                     
            		 String pwssupplyUpdate="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL SET PWS_SUPPLY_SAFE=0,PWS_SUPPLY_UNSAFE=0 where PWS_NO=0 and PWS_HAB_SCHEME_NO=0";
            		 stmt=conn.createStatement();  
                     stmt.executeUpdate(pwssupplyUpdate);
                     stmt.close();
                     
            		 String mpwssupplyUpdate="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL SET MPWS_SUPPLY_SAFE=0,MPWS_SUPPLY_UNSAFE=0 where MPWS_NO=0 and MPWS_HAB_SCHEME_NO=0";
            		 stmt=conn.createStatement();  
                     stmt.executeUpdate(mpwssupplyUpdate);
                     stmt.close();
                     
            		 String hpsupplyUpdate="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL SET HANDPUMP_SUPPLY_SAFE=0,HANDPUMP_SUPPLY_UNSAFE=0 where HANDPUMP_NO=0";
            		 stmt=conn.createStatement();  
                     stmt.executeUpdate(hpsupplyUpdate);
                     stmt.close();
                     
            		 String shpsupplyUpdate="UPDATE RWS_HAB_SCHEME_SRC_DATA_TBL SET SHALLOW_HP_SUPPLY_SAFE=0,SHALLOW_HP_SUPPLY_UNSAFE=0 where SHALLOW_HANDPUMP_NO=0";
            		 stmt=conn.createStatement();  
                     stmt.executeUpdate(shpsupplyUpdate);
                     stmt.close();
                     System.out.println("completed");
                	 
                     } 
                catch(Exception e)
                {
                	e.printStackTrace();
                }
                finally {
                	try {
                		if(conn!=null)
                			conn.close();
                		if(stmt!=null)
                			stmt.close();
                		if(pstt!=null)
                			pstt.close();
                		if(rs!=null)
                			rs.close();
                	}
                	catch(Exception e) {
                		e.printStackTrace();
                	}
                }
                
        }
}